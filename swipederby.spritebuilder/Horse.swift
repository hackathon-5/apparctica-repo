//
//  Horse.swift
//  swipederby
//
//  Created by Jonathan Mayhak on 8/28/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation
import GameKit

class Horse : CCSprite {
    func scoot(otherHorse: Bool)
    {
        var x = Int(self.position.x)
        var y = Int(self.position.y)
        var toX = x + 15
        
        moveTile(self, fromX: x, fromY: y, toX: toX, toY: y)
        
        if (otherHorse == false) {
            var testStr = "test"
            let data = (testStr as NSString).dataUsingEncoding(NSUTF8StringEncoding)
            
            let success = GCHelper.match.sendDataToAllPlayers(data, withDataMode: .Reliable, error: nil)
            if !success {
                println("An unknown error occured while sending data")
            }
        }
        
    }
    
    func moveTile(tile: Horse, fromX: Int, fromY: Int, toX: Int, toY: Int) {
        var moveTo = CCActionMoveTo(duration: 0.2, position: CGPoint(x: toX, y: toY))
        tile.runAction(moveTo)
    }
    
}