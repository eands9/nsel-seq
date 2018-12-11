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
    
    var randomNumA = Int.random(in: 101 ..< 1000)
    var randomNumB = Int.random(in: 101 ..< 1000)
    var firstNum : Int = 0
    var secondNum : Int = 0
    var questionTxt : String = ""
    var answerCorrect : Int = 0
    var answerUser : Int = 0
    
    let congratulateArray = ["Great Job", "Excellent", "Way to go", "Alright", "Right on", "Correct", "Well done", "Awesome","Give me a high five"]
    let retryArray = ["Try again","Oooops"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        questionNumber = 0
        questionNumberLbl.text = "Question #\(questionNumber + 1)"
        let firstQuestion = allQuestions.list[0].question
        questionLbl.text = firstQuestion
 */
        
        askQuestion()
        
        timerLbl.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
        
        self.answerTxt.becomeFirstResponder()
    }

    @IBAction func checkAnswerByUser(_ sender: Any) {
        checkAnswer()
    }
    
    func askQuestion(){
        
        if randomNumA > randomNumB {
            firstNum = randomNumA
            secondNum = randomNumB
        }
        else{
            firstNum = randomNumB
            secondNum = randomNumA
        }
    
    questionLabel.text = "\(firstNum) - \(secondNum)"
    }
    
    func checkAnswer(){
        answerUser = (answerTxt.text! as NSString).integerValue
        answerCorrect = firstNum - secondNum
        
        if answerCorrect == answerUser {
            print("correct")
            randomPositiveFeedback()
        }
        else{
            print("wrong")
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
}

