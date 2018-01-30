//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
     let allQuestions = QuestionBank()
    
    var correctSound = AVAudioPlayer()
    var errorSound = AVAudioPlayer()
    
    var chosenAnswer : Bool = false
    
    var questionNumber : Int  = 0
    var scoreNumber  : Int = 0
    var progressNumber : Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        correctSound = try! AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "correctSound" , ofType: "wav")!))
        errorSound = try! AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "errorSound", ofType: "wav")!))
        questionNumber = 0
        progressNumber = 1
        scoreNumber = 0
        scoreLabel.text = "Score: \(scoreNumber) "
        updateUI()
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if questionNumber < allQuestions.list.count - 1 {
        if sender.tag == 1 {
           chosenAnswer = true
        }
        else {
           chosenAnswer = false
        }
     checkAnswer()
        }
        else {
            nextQuestion()
        }
    }

    func nextQuestion() {
        if questionNumber < allQuestions.list.count - 1 {
            questionNumber+=1
            progressNumber += 1
            updateUI()
        }
        else {
            let maxScore = 10*allQuestions.list.count
            let percentage : Int = Int((Double(scoreNumber)/Double(maxScore)) * 100 )
          let alert = UIAlertController(title: "Congrats", message: "\(percentage)% !! you got \(scoreNumber) out of \(maxScore), would you like to restart?", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Yes", style: .default , handler: { (UIAlertAction) in
            self.startOver()
            })
            let alertAction2 = UIAlertAction(title: "No", style: .default , handler: { (UIAlertAction) in

            })
       
            alert.addAction(alertAction)
            alert.addAction(alertAction2)
            present(alert, animated: true, completion: nil)
          }
    }
    
    
    func checkAnswer() {
        if chosenAnswer == allQuestions.list[questionNumber].answer {
            ProgressHUD.showSuccess("Right")
            correctSound.play()
            if questionNumber == 0 {
                scoreNumber = 10
            }
            else {
                scoreNumber += 10
            }
        } else {
            errorSound.play()
            ProgressHUD.showError("Wrong")
        }
      nextQuestion()
        
    }
    
    
    func startOver() {
        viewDidLoad()
    }
    func updateUI(){
        let theQuestion = allQuestions.list[questionNumber]
        questionLabel.text = theQuestion.questionText
        scoreLabel.text = "Score: \(scoreNumber) "
        progressLabel.text = "\(progressNumber)/\(allQuestions.list.count)"
   progressBar.frame.size.width = ( view.frame.size.width / 13 ) * CGFloat(progressNumber)
        
    }

    
}
