import Foundation

class MainScene: CCNode {
    
    //When working with scenes created in SpriteBuilder the method didLoadFromCCB is the right place to perform modifications that shall happen as soon as the scene gets initialized.
    func didLoadFromCCB() {
        setupGestures()
    }
    
    func setupGestures() {
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "swipeLeft")
        swipeLeft.direction = .Left
        CCDirector.sharedDirector().view.addGestureRecognizer(swipeLeft)
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "swipeRight")
        swipeRight.direction = .Right
        CCDirector.sharedDirector().view.addGestureRecognizer(swipeRight)
        
        var swipeUp = UISwipeGestureRecognizer(target: self, action: "swipeUp")
        swipeUp.direction = .Up
        CCDirector.sharedDirector().view.addGestureRecognizer(swipeUp)
        
        var swipeDown = UISwipeGestureRecognizer(target: self, action: "swipeDown")
        swipeDown.direction = .Down
        CCDirector.sharedDirector().view.addGestureRecognizer(swipeDown)
    }
    
    func swipeLeft() {
        println("Left swipe!")
    }
    
    func swipeRight() {
        println("Right swipe!")
    }
    
    func swipeUp() {
        println("Up swipe!")
    }
    
    func swipeDown() {
        println("Down swipe!")
    }
    
}
