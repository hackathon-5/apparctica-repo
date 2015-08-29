//
//  Horse.swift
//  swipederby
//
//  Created by Jonathan Mayhak on 8/28/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class Horse : CCSprite {
    func scoot()
    {
        var x = Int(self.position.x)
        var y = Int(self.position.y)
        var toX = x + 50
        
        moveTile(self, fromX: x, fromY: y, toX: toX, toY: y)
    }
    
    func moveTile(tile: Horse, fromX: Int, fromY: Int, toX: Int, toY: Int) {
        var moveTo = CCActionMoveTo(duration: 0.2, position: CGPoint(x: toX, y: toY))
        tile.runAction(moveTo)
    }
}