//
//  DrumWithNumber.swift
//  Sum and Drum2
//
//  Created by Matthew Phraxayavong on 10/19/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import SpriteKit

// Class creates random values for each node and also displays the values of those nodes in text form

class DrumWithNumber: SKSpriteNode {
    
    var label: SKLabelNode
    var number: Int
    
    init(number: Int = 99) {
        label = SKLabelNode(fontNamed: "Helvetica")
        let s = CGSize(width: 40, height: 40)
//        self.number = Int(arc4random() % 10)
        self.number = Int.random(in: 1...5)
        
        super.init(texture: nil, color: .red, size: s)
        name = "drum"
        
        addChild(label)
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center
//        label.position.x = 5
//        label.position.y = 5
        label.fontColor = .white
        label.text = "\(self.number)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
