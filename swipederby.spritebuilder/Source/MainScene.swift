import Foundation

class MainScene: CCNode {
    
    func play() {        
        var gameScene = CCBReader.loadAsScene("GameScene")
        CCDirector.sharedDirector().presentScene(gameScene)
    }
}
