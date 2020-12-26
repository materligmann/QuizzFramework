//
//  UIImage+QR.swift
//  GoGo
//
//  Created by Mathias Erligmann on 23/11/2020.
//

import UIKit

extension String {
    func generateQRCode(lightBackground: Bool = true) -> UIImage? {
        let data = self.data(using: String.Encoding.ascii)
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else {
            return UIImage()
        }
        qrFilter.setValue(data, forKey: "inputMessage")
        guard let output = qrFilter.outputImage else { return nil }
        
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledQR = output.transformed(by: transform)
        guard let colorInvertFilter = CIFilter(name: "CIColorInvert") else { return nil }
        colorInvertFilter.setValue(scaledQR, forKey: "inputImage")
        guard let outputInvertedImage = colorInvertFilter.outputImage else { return nil}
        guard let maskToAlphaFilter = CIFilter(name: "CIMaskToAlpha") else { return nil }
        maskToAlphaFilter.setValue(outputInvertedImage, forKey: "inputImage")
        guard let outputCIImage = maskToAlphaFilter.outputImage else { return nil }
        if lightBackground {
            colorInvertFilter.setValue(outputCIImage, forKey: "inputImage")
            guard let outputImageFinal = colorInvertFilter.outputImage else { return nil }
            let context = CIContext()
            guard let cgImage = context.createCGImage(outputImageFinal, from: outputImageFinal.extent) else { return nil }
            let processedImage = UIImage(cgImage: cgImage)
            return processedImage
        } else {
            let context = CIContext()
            guard let cgImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) else { return nil }
            let processedImage = UIImage(cgImage: cgImage)
            return processedImage
        }
    }
}
