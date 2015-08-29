import Foundation

class MainScene: CCNode {
    

    func play() {
        var gameScene = CCBReader.loadAsScene("GameScene")
        CCDirector.sharedDirector().presentScene(gameScene)
    }
    
    func playSinglePlayer() {
        var gameScene = CCBReader.loadAsScene("SinglePlayerGameScene")
        CCDirector.sharedDirector().presentScene(gameScene)
    }
    
    func didLoadFromCCB() {
         OALSimpleAudio.sharedInstance().stopEverything()
        //GCHelper.authenticateLocalUser()
    }

}
