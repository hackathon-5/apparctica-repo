//
//  Arrow.swift
//  swipederby
//
//  Created by Jonathan Mayhak on 8/28/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class Arrow: CCSprite {
    
    func setLeft()
    {
        self.rotation = 180
        println("left")
    }
    
    func setRight()
    {
        self.rotation = 0
        println("right")
    }
    
    func setUp()
    {
        self.rotation = 270
        println("up")
    }
    
    func setDown()
    {
        self.rotation = 90
        println("down")
    }
    
}