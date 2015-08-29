import Foundation
import GameKit

class MainScene: CCNode, GCHelperDelegate {
    
    func play() {
        GCHelper.sharedInstance.findMatchWithMinPlayers(2, maxPlayers: 2, viewController: CCDirector.sharedDirector(), delegate: self)
    }
    
    func play2() {
        var gameScene = CCBReader.loadAsScene("GameScene")
        CCDirector.sharedDirector().presentScene(gameScene)
    }
    
    func match(match: GKMatch, didReceiveData: NSData, fromPlayer: String) {
        
    }
    
    func matchEnded() {
        
    }
    
    func matchStarted() {
        var gameScene = CCBReader.loadAsScene("GameScene")
        CCDirector.sharedDirector().presentScene(gameScene)
    }
    func didLoadFromCCB() {
        OALSimpleAudio.sharedInstance().stopEverything()
    }

}
