//
//  SegmentedCell.swift
//  GoGo
//
//  Created by Mathias Erligmann on 25/11/2020.
//

import UIKit

class SegmentedCell: UITableViewCell {
    
    private let segmentedControl = UISegmentedControl()
    private var onSegmentChange: ((String) -> Void)?
    
    private var segments: [FormModels.Segment]?
    
    class var cellIdentifier: String {
        return "SegmentedCell"
    }
    
    // MARK: Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSelectionStyle()
        configureBackground()
        configureSegmentedControl()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set
    
    func set(entry: FormModels.SegmentEntry) {
        self.onSegmentChange = entry.onSegmentChange
        self.segments = entry.segments
        segmentedControl.removeAllSegments()
        for (i, segment) in entry.segments.enumerated() {
            segmentedControl.insertSegment(withTitle: segment.name, at: i, animated: false)
            if segment.isSelected {
                segmentedControl.selectedSegmentIndex = i
            }
        }
        segmentedControl.isEnabled = entry.isEnabled
    }
    
    // MARK: Configure
    
    private func configureSelectionStyle() {
        selectionStyle = .none
    }
    
    private func configureBackground() {
        backgroundColor = .clear
    }
    
    private func configureSegmentedControl() {
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueDidChanged), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(segmentedControl)
        segmentedControl.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        segmentedControl.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        segmentedControl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        segmentedControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
    }
    
    // MARK: User Action
    
    @objc private func segmentedControlValueDidChanged() {
        if let segmentSlug = segments?[segmentedControl.selectedSegmentIndex].name {
            onSegmentChange?(segmentSlug)
        }
    }
}
