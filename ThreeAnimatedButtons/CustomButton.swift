//
//  CustomButton.swift
//  ThreeAnimatedButtons
//
//  Created by Denis Evdokimov on 11/5/23.
//

import UIKit

class CustomButton: UIButton {

    override func updateConfiguration() {
        super.updateConfiguration()
        guard let configuration = configuration, let title = configuration.title else {
            return
        }
        var updatedConfiguration = configuration
        let updateForegroundColor: UIColor = tintAdjustmentMode == .dimmed ? .systemGray3 : .white
        let updateBackgroundColor: UIColor = tintAdjustmentMode == .dimmed ? .systemGray2 : .systemBlue
        var background = configuration.background
        background.backgroundColor = updateBackgroundColor
        
        var container = AttributeContainer()
        container.foregroundColor = updateForegroundColor
        
        updatedConfiguration.background = background
        updatedConfiguration.attributedTitle = AttributedString(title, attributes: container)
        updatedConfiguration.imageColorTransformer = UIConfigurationColorTransformer({ _ in
            updateForegroundColor
        })
        self.configuration = updatedConfiguration
        
    }
}

