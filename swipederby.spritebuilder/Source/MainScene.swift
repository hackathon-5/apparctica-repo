import Foundation

class MainScene: CCNode {
    
    var horse: Horse!
    var arrow: Arrow!
    var finish: Finish!
    
    var currentAcceptedGesture: String!
    var hasPenalty: Bool!
    var _gameOver: Bool!
    
    
    //When working with scenes created in SpriteBuilder the method didLoadFromCCB is the right place to perform modifications that shall happen as soon as the scene gets initialized.
    func didLoadFromCCB() {
        hasPenalty = false
        setupGestures()
        _gameOver = false
        
        var director = CCDirector.sharedDirector()
        
        // add a horse
        horse = CCBReader.load("Horse") as! Horse
        horse.position.y = director.viewSize().height - 50
        horse.position.x = 60
        horse.scale = 0.25
        self.addChild(horse)
        
        // add the arrow
        arrow = CCBReader.load("Arrow") as! Arrow
        arrow.position = ccp(60, 60)
        arrow.scale = 0.25
        //arrow.visible = false
        self.addChild(arrow)
        
        finish = CCBReader.load("Finish") as! Finish
        finish.position.x = director.viewSize().width - 50
        finish.position.y = director.viewSize().height - 25
        self.addChild(finish)
        
        self.updateAndShowGesture()
    }
    
    override func update(delta: CCTime) {
        
        // check if game is over
        if (self.isGameOver()) {
            _gameOver = true
            
            // go to the restart/winner screen
        }
    
        
    }
    
    func isGameOver() -> Bool
    {
        return ((horse.position.x + (horse.contentSizeInPoints.width * 0.25)) >= finish.position.x)
    }
    
    func updateAndShowGesture()
    {
        if (_gameOver == true) {
            return
        }
        
        // pick a random direction
        let directions = ["left", "right", "up", "down"]
        let randomIndex = Int(arc4random_uniform(UInt32(directions.count)))
        
        let direction = directions[randomIndex]
        
        // update which direction is allowed
        currentAcceptedGesture = direction
        
        switch (direction) {
            case "left":
                arrow.setLeft()
                break
            case "right":
                arrow.setRight()
                break;
            case "up":
                arrow.setUp()
                break;
            default:
                arrow.setDown()
                break;
        }
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
        if (_gameOver == true) {
            return
        }
        
        if (self.currentAcceptedGesture == "left") {
            horse.scoot()
            self.updateAndShowGesture()
        }
    }
    
    func swipeRight() {
        if (_gameOver == true) {
            return
        }
        
        if (self.currentAcceptedGesture == "right") {
            horse.scoot()
            self.updateAndShowGesture()
        }
    }
    
    func swipeUp() {
        if (_gameOver == true) {
            return
        }
        
        if (self.currentAcceptedGesture == "up") {
            horse.scoot()
            self.updateAndShowGesture()
        }
    }
    
    func swipeDown() {
        if (_gameOver == true) {
            return
        }
        
        if (self.currentAcceptedGesture == "down") {
            horse.scoot()
            self.updateAndShowGesture()
        }
    }
    
}
