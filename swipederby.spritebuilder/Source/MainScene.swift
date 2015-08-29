import Foundation

class MainScene: CCNode {
    
    var horses : Array<Horse>!
        
    func didLoadFromCCB() {
        GCHelper.authenticateLocalUser()
    }
    
    func play() {
        let gameScene = CCBReader.loadAsScene("GameScene")
        CCDirector.sharedDirector().presentScene(gameScene)
    }

}
