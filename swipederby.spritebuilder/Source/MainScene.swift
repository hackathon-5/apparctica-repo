import Foundation

class MainScene: CCNode {
    

    func play() {
        var gameScene = CCBReader.loadAsScene("GameScene")
        CCDirector.sharedDirector().presentScene(gameScene)
    }
    
    func play2() {
        // needs to worked to not use multiplayer
        var gameScene = CCBReader.loadAsScene("GameScene")
        CCDirector.sharedDirector().presentScene(gameScene)
    }
    
    func didLoadFromCCB() {
         OALSimpleAudio.sharedInstance().stopEverything()
        //GCHelper.authenticateLocalUser()
    }

}
