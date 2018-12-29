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

    var answerCorrect : Int = 0
    var answerUser : Int = 0
    
    let congratulateArray = ["Great Job", "Excellent", "Way to go", "Alright", "Right on", "Correct", "Well done", "Awesome","Give me a high five"]
    let retryArray = ["Try again","Oooops"]
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        askQuestion()
        
        timerLbl.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
        
        self.answerTxt.becomeFirstResponder()
/* SOLUTION:    get number of seq = last number - first number; divide by increment; plus 1
                answerCorrect = number of seq X (last number + first number) / 2
 */
    }
    struct DoubleGenerator: Sequence, IteratorProtocol {
        
        var current = Int.random(in: 1...20)
        var randomAdd = Int.random(in: 1...10)
        
        mutating func next() -> Int? {
            defer {
                current += randomAdd
            }
            return current
        }
    }
    @IBAction func checkAnswerByUser(_ sender: Any) {
        checkAnswer()
    }
    func askQuestion(){
        let randomSeqLength = Int.random(in: 4...10)
        var seqList = [Int]()
        var i = 0
        var question = ""
        
        let numbers = DoubleGenerator()
        for number in numbers {
            i += 1
            if i == randomSeqLength { break }
            seqList.append(number)
        }
        
        for num in seqList{
            if num == seqList.last{
                question += String(num)
            }
            else {
                question += String(num) + " + "
            }
        }
        
        questionLabel.text = question
        answerCorrect = seqList.reduce(0, +)
    }
    
    func checkAnswer(){
        answerUser = (answerTxt.text! as NSString).integerValue
        
        if answerUser == answerCorrect{
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
}

