import Foundation

class SinglePlayerGameScene: CCNode {
    
    //var horse: Horse!
    weak var arrow: Arrow!
    weak var finish: CCNode!
    weak var directionsLbl: CCLabelTTF!
    weak var readyLabel: CCLabelTTF!
    var otherHorses: [SingleHorse] = []
    weak var myHorse: SingleHorse!
    var allHorses: [SingleHorse] = []
    
    var restartBtn: CCButton!
    
    var currentAcceptedGesture: String!
    var hasPenalty: Bool!
    var _gameOver: Bool!
    var _curCountdown: Int!
    var _hasGameKitMP: Bool = true
    var _canStart: Bool = false
    var _inProgress: Bool = false
    
    
    func matchStarted() {
        _canStart = true
        
        var director = CCDirector.sharedDirector()
        
        // add your horse
        myHorse = CCBReader.load("SingleHorse") as! SingleHorse
        myHorse.position.y = director.viewSize().height - 100
        myHorse.position.x = 125
        myHorse.scale = 0.25
        allHorses.append(myHorse)
        self.addChild(myHorse)
        
        var myHorseLabel = CCLabelTTF.labelWithString("You", fontName: "Helvetica", fontSize: 16)
        myHorseLabel.position.y = myHorse.position.y
        myHorseLabel.position.x = 25
        self.addChild(myHorseLabel)
        
//        let players = GCHelper.sharedInstance.playersDict
//        var i = 2
//        for (playerId, player) in players {
//            var horse = CCBReader.load("Horse") as! Horse
//            horse.position.y = CGFloat(Int(director.viewSize().height) - (50 * i))
//            i = i + 1
//            horse.position.x = 125
//            horse.scale = 0.25
//            self.addChild(horse)
//            otherHorses.append(horse)
//            allHorses.append(horse)
//            
//            var myHorseLabel = CCLabelTTF.labelWithString(player.alias, fontName: "Helvetica", fontSize: 16)
//            myHorseLabel.position.y = myHorse.position.y
//            myHorseLabel.position.x = 25
//            self.addChild(myHorseLabel)
//        }
        var i = 3
        while i<=5 {
            //var skinColor = colorRGBA(247,224,194,1)
            
            //ccColor3B skinColor = skinColors[arc4random() % 5];
            //[skin setColor:skinColor];
                    var horse = CCBReader.load("SingleHorse") as! SingleHorse
            
            //horse.color =  CCColor(red: 255, green: 255, blue: 255)
                    horse.position.y = CGFloat(Int(director.viewSize().height) - (50 * i))
                    i = i + 1
                    horse.position.x = 125
                    horse.scale = 0.25
            var color = CCColor(red: 0, green: 0, blue: 0)
            var moveTo = CCActionTintTo(duration: 0.2, color: color)
            horse.runAction(moveTo)
            
                    self.addChild(horse)
                    otherHorses.append(horse)
                    allHorses.append(horse)
        
            var myHorseLabel = CCLabelTTF.labelWithString(String(i), fontName: "Helvetica", fontSize: 16)

                    myHorseLabel.position.y = myHorse.position.y
                    myHorseLabel.position.x = 25
                    self.addChild(myHorseLabel)
        }
        
    }
    
    //When working with scenes created in SpriteBuilder the method didLoadFromCCB is the right place to perform modifications that shall happen as soon as the scene gets initialized.
    func didLoadFromCCB() {
        
        OALSimpleAudio.sharedInstance().preloadBg("zelda.mp3")
        OALSimpleAudio.sharedInstance().playBgWithLoop(true)
        
        
        
        hasPenalty = false
        _gameOver = false
        restartBtn.visible = false
        directionsLbl.visible = false
        arrow.visible = false
        _curCountdown = 3
        
        readyLabel.zOrder = 100
        
        matchStarted()
        
    }
    
    func countDown()
    {
        readyLabel.string = String(_curCountdown)
        _curCountdown = _curCountdown - 1
    }
    
    override func update(delta: CCTime) {
        
        if (_canStart == true && _inProgress == false) {
            self.schedule("countDown", interval: 1)
            setupGestures()
            self.updateAndShowGesture()
            _inProgress = true
        }
        
        // check if game is over
        if (self.isGameOver()) {
            _gameOver = true
            
            restartBtn.visible = true
            return
        }
        
        if (_curCountdown < 0) {
            if (arrow.visible == false) {
                self.unschedule("countDown")
            }
            
            readyLabel.visible = false
            directionsLbl.visible = true
            arrow.visible = true
            
            let diceRoll = Int(arc4random_uniform(60))
            if diceRoll < 4 && diceRoll > 0{
                allHorses[diceRoll].scoot()
            }
        }
    }
    
    func restartGame()
    {
        _curCountdown = 3;
        var gameScene = CCBReader.loadAsScene("SinglePlayerGameScene")
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

