// CHANGE GAME NAME TO ADD QUICKER





//  GameScene.swift
//  Sum and Drum2
//
//  Created by Matthew Phraxayavong on 10/17/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var score = 0
    var scoreLabel = SKLabelNode()
    var objectiveLabel = SKLabelNode()
    var objectiveScore = 0
    var nodeTracker = 0
    var nodeLimitLabel = SKLabelNode()
    var limit = 2

    
    
    // Creates nodes at intervals, also spawns the labels for score, game over, game won, objective score, and maximum limit score.
    
    override func didMove(to view: SKView) {
        let create = SKAction.run {
            self.createDrum()
        }
        let spawnTime = SKAction.wait(forDuration: 1.0)
        let drumMakerSeq = SKAction.sequence([create, spawnTime, create, spawnTime])
        let drumRepeat = SKAction.repeatForever(drumMakerSeq)
        self.run(drumRepeat)
        
        let position = CGPoint(x: (scene?.frame.size.width)!/2, y: (scene?.frame.size.height)!/2)
        
        let objectivePosition = CGPoint(x: (scene?.frame.size.width)!/2, y: (scene?.frame.size.height)!/2 + 225 )
        
        let nodeLimitPosition = CGPoint(x: (scene?.frame.size.width)!/2, y: (scene?.frame.size.height)!/2 + 200)
        
        
        scoreLabel.position = position
        scoreLabel.fontSize = 25
        scoreLabel.color = .red
        
        objectiveLabel.position = objectivePosition
        objectiveLabel.fontSize = 25
        objectiveLabel.color = .red
        
        nodeLimitLabel.position = nodeLimitPosition
        nodeLimitLabel.fontSize = 15
        nodeLimitLabel.color = .red
        
        
        
        addChild(scoreLabel)
        scoreUpdate(score: score)
        addChild(objectiveLabel)
        objectiveScoreWin(score: "test")
        addChild(nodeLimitLabel)
        nodeLimitValue(limit: limit)
        
    }
    //  Updates the score value
    
    func scoreUpdate(score: Int) {
        scoreLabel.text = "Score: \(score)"
    }
    
    // Shows the amount of points needed to win the game
    
    func objectiveScoreWin(score: String) {
        objectiveLabel.text = "Score required to win: 8"
    }
    
    //Shows amount of available nodes available before losing the game
    
    func nodeLimitValue(limit: Int) {
        nodeLimitLabel.text = "Available clicks: \(limit)"
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }
//    func random(_ n: Int) -> Int
//    {
//        return Int(arc4random_uniform(UInt32(n)))
//    }
    
    
    // Displays what the node will look like and moves it up and deletes it once it reaches the top
    // drum variable is also initializing the DrumWithNumber class from DrumWithNumber.swift file
    
    func createDrum() {
        // let size = CGSize(width: 60, height: 60)
//        let drum = SKSpriteNode(texture: nil, color: .gray, size: size)
//        let drumNode = UIImage(cgImage: drumNode)
        // let drum = SKSpriteNode(imageNamed: "drumNode.png")
        let drum = DrumWithNumber(number: 99)
//        let drum = UIImage(image: drumNode.png!)
         drum.name = "drum"
        // drum.size = size
        
        let moveDrumUp = SKAction.moveBy(x: 0.0, y: self.size.height, duration: 10.0)
        let removeDrum = SKAction.removeFromParent()
        if self.score == 8 {
                self.scoreLabel.text = "You won!"
                removeAllActions()
            
        }
        let drumSequence = SKAction.sequence([moveDrumUp, removeDrum])
        if score >= 0 {
            drum.run(drumSequence)
            addChild(drum)
        } else if score < 0 {
            removeAllActions()
        }
        guard let view = self.view else {
            return
        }
        drum.position.x = CGFloat.random(in: 0..<frame.size.width)
    
    }
    
    // Allows the user to click on the nodes, updates score, updates maximum amount of touches left before losing
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let drumSc = DrumWithNumber(number: 99)
        
        if let touch = touches.first {
            let location = touch.location(in: self)
            let node = atPoint(location)
            if node.name == "drum" {
                let drum = node as! DrumWithNumber
                score += drum.number
                node.removeFromParent()
                scoreUpdate(score: score)
                if score < 0 {
                    return
                }
                if score == 8 {
                    return
                }
                if score > 8 {
                    scoreLabel.fontSize = 10
                    self.scoreLabel.text = "GameOver. You went over your required score!"
                    return
                }
                if nodeTracker >= 2 {
                    scoreLabel.fontSize = 15
                    self.scoreLabel.text = "GameOver. You went over your limit!"
                    return
                }
                nodeTracker += 1
                limit -= 1
                nodeLimitValue(limit: limit)
        }
    }
}

    
    
    
//    class Drum : SKSpriteNode {
//        init(scene: SKScene) {
//            let texture = SKTexture(imageNamed: "drumNode.png")
//            let size = CGSize(width: 45, height: 45)
//            super.init(texture: texture, color: .gray, size: size)
//            self.name = "drum"
//        }
//        required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")}
//    }
//
//}

}
