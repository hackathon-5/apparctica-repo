import Foundation

class GameScene: CCNode {
    
    //var horse: Horse!
    weak var arrow: Arrow!
    weak var finish: CCNode!
    weak var directionsLbl: CCLabelTTF!
    weak var readyLabel: CCLabelTTF!
    var otherHorses: [Horse] = []
    weak var myHorse: Horse!
    var allHorses: [Horse] = []
    
    var restartBtn: CCButton!
    
    var currentAcceptedGesture: String!
    var hasPenalty: Bool!
    var _gameOver: Bool!
    var _curCountdown: Int!
    var _hasGameKitMP: Bool = false
    
    //When working with scenes created in SpriteBuilder the method didLoadFromCCB is the right place to perform modifications that shall happen as soon as the scene gets initialized.
    func didLoadFromCCB() {
        
        hasPenalty = false
        _gameOver = false
        restartBtn.visible = false
        directionsLbl.visible = false
        arrow.visible = false
        _curCountdown = 3
        
        readyLabel.zOrder = 100
        
        var director = CCDirector.sharedDirector()
        
        // add your horse
        myHorse = CCBReader.load("Horse") as! Horse
        myHorse.position.y = director.viewSize().height - 50
        myHorse.position.x = 125
        myHorse.scale = 0.25
        allHorses.append(myHorse)
        self.addChild(myHorse)
        
        var myHorseLabel = CCLabelTTF.labelWithString("You", fontName: "Helvetica", fontSize: 16)
        myHorseLabel.position.y = myHorse.position.y
        myHorseLabel.position.x = 25
        self.addChild(myHorseLabel)
        
        // add all of the gamecenter horses (or AI)
        // for each player, create a horse and set their name
        for i in 2...4 {
            var horse = CCBReader.load("Horse") as! Horse
            horse.position.y = CGFloat(Int(director.viewSize().height) - (50 * i))
            horse.position.x = 125
            horse.scale = 0.25
            self.addChild(horse)
            otherHorses.append(horse)
            allHorses.append(horse)
        }
        
        self.schedule("countDown", interval: 1)
        setupGestures()
        self.updateAndShowGesture()
    }
    
    func countDown()
    {
        readyLabel.string = String(_curCountdown)
        _curCountdown = _curCountdown - 1
    }
    
    override func update(delta: CCTime) {
        
        // check if game is over
        if (self.isGameOver()) {
            _gameOver = true
            
            restartBtn.visible = true
            return
        }
        
        if (_curCountdown < 0) {
            readyLabel.visible = false
            directionsLbl.visible = true
            arrow.visible = true
            self.unschedule("countDown")
        }
    }
    
    func restartGame()
    {
        _curCountdown = 3;
        var gameScene = CCBReader.loadAsScene("GameScene")
        CCDirector.sharedDirector().replaceScene(gameScene)
    }
    
    func isGameOver() -> Bool
    {
        for horse in allHorses {
            if ((horse.position.x + (horse.contentSizeInPoints.width * 0.12)) >= finish.position.x) {
                return true
            }
        }
        
        return false
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
            directionsLbl.string = "Swipe Left!"
            break
        case "right":
            arrow.setRight()
            directionsLbl.string = "Swipe Right!"
            break;
        case "up":
            arrow.setUp()
            directionsLbl.string = "Swipe Up!"
            break;
        default:
            arrow.setDown()
            directionsLbl.string = "Swipe Down!"
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
        if (_gameOver == true || _curCountdown > -1) {
            return
        }
        
        if (self.currentAcceptedGesture == "left") {
            myHorse.scoot()
            self.updateAndShowGesture()
        }
    }
    
    func swipeRight() {
        if (_gameOver == true || _curCountdown > -1) {
            return
        }
        
        if (self.currentAcceptedGesture == "right") {
            myHorse.scoot()
            self.updateAndShowGesture()
        }
    }
    
    func swipeUp() {
        if (_gameOver == true || _curCountdown > -1) {
            return
        }
        
        if (self.currentAcceptedGesture == "up") {
            myHorse.scoot()
            self.updateAndShowGesture()
        }
    }
    
    func swipeDown() {
        if (_gameOver == true || _curCountdown > -1) {
            return
        }
        
        if (self.currentAcceptedGesture == "down") {
            myHorse.scoot()
            self.updateAndShowGesture()
        }
    }
    
}

