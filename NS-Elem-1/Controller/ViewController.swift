//
//  ViewController.swift
//  NS-Elem-1
//
//  Created by Eric Hernandez on 12/2/18.
//  Copyright © 2018 Eric Hernandez. All rights reserved.
//

import UIKit
import Speech

class ViewController: UIViewController {
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var answerTxt: UITextField!
    @IBOutlet weak var progressLbl: UILabel!
    @IBOutlet weak var questionNumberLbl: UILabel!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    var randomPick: Int = 0
    var correctAnswers: Int = 0
    var numberAttempts: Int = 0
    var timer = Timer()
    var counter = 0.0
    
    var randomNumA : Int = 0
    var randomNumB : Int = 0
    var randomNumC : Int = 0
    var randomNumD : Int = 0
    var firstNum : Double = 0
    var secondNum : Double = 0
    var thirdNum : Double = 0
    var fourthNum : Double = 0
    var questionTxt : String = ""
    var answerCorrect : Double = 0
    var answerUser : Double = 0
    
    var randomHigh: Int = 0
    var randomLow: Int = 0
    var randomHighIndex: Int = 0
    var randomLowIndex: Int = 0
    
    let congratulateArray = ["Great Job", "Excellent", "Way to go", "Alright", "Right on", "Correct", "Well done", "Awesome","Give me a high five"]
    let retryArray = ["Try again","Oooops"]
    
    let bigNumberArray = [8,9]
    let smallNumberArray = [1,2]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        askQuestion()
        
        timerLbl.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
        
        self.answerTxt.becomeFirstResponder()
    }

    @IBAction func checkAnswerByUser(_ sender: Any) {
        checkAnswer()
    }
    
    func askQuestion(){
        pickHighNum()
        pickLowNum()
        //2 digit questions starting at 100
        randomNumA = Int.random(in: 10 ..< 51)
        randomNumD = Int.random(in: 1 ..< 10)
        randomNumB = randomNumA * 10 + randomHigh
        randomNumC = randomNumD * 10 + randomLow

        
        firstNum = Double(randomNumB)
        secondNum = Double(randomNumC)
        
        questionLabel.text = "\(randomNumB) X \(randomNumC)"
    }
    
    func checkAnswer(){
        answerUser = (answerTxt.text! as NSString).doubleValue
        answerCorrect = firstNum * secondNum
        
        if answerUser >= answerCorrect * 0.95 && answerUser <= answerCorrect * 1.05 {
            correctAnswers += 1
            numberAttempts += 1
            updateProgress()
            randomPositiveFeedback()
            askQuestion()
            answerTxt.text = ""
        }
        else{
            randomTryAgain()
            answerTxt.text = ""
            numberAttempts += 1
            updateProgress()
        }
    }
    
    @objc func updateTimer(){
        counter += 0.1
        timerLbl.text = String(format:"%.1f",counter)
    }
    
    func readMe( myText: String) {
        let utterance = AVSpeechUtterance(string: myText )
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    func randomPositiveFeedback(){
        randomPick = Int(arc4random_uniform(9))
        readMe(myText: congratulateArray[randomPick])
    }
    
    func updateProgress(){
        progressLbl.text = "\(correctAnswers) / \(numberAttempts)"
    }
    
    func randomTryAgain(){
        randomPick = Int(arc4random_uniform(2))
        readMe(myText: retryArray[randomPick])
    }
    
    func pickHighNum(){
        randomHighIndex = Int(arc4random_uniform(2))
        randomHigh = bigNumberArray[randomHighIndex]
    }
    
    func pickLowNum(){
        randomLowIndex = Int(arc4random_uniform(2))
        randomLow = smallNumberArray[randomHighIndex]
    }
}

