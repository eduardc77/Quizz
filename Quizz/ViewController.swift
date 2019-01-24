//
//  ViewController.swift
//  Quizz
//
//  Created by Eduard Caziuc on 28/04/2018.
//  Copyright © 2018 Eduard Caziuc. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    let questionModel = QuestionModel()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
    var score : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
    }
    
    //This action gets called when either the true or false button is pressed.
    @IBAction func answerPressed(_ sender: AnyObject) {
        
        if sender.tag == 1 {
            pickedAnswer = true
        }
            
        else if sender.tag == 2 {
            pickedAnswer = false
        }
        
        checkAnswer()
        
        questionNumber = questionNumber + 1
        
        updateUI()
        
    }
    
    /// This method will update all the views on screen (progress bar, score label, etc)
    func updateUI() {
        
        progressBar.frame.size.width = (view.frame.size.width / CGFloat(questionModel.list.count)) * CGFloat(questionNumber)
        
        progressLabel.text = String(questionNumber) + "/13"
        
        scoreLabel.text = "Score: " + String(score)
        
        nextQuestion()
    }
    
    ///This method will update the question text and check if it reached the end.
    func nextQuestion() {
        
        if questionNumber <= questionModel.list.count - 1 {
            questionLabel.text = questionModel.list[questionNumber].questionText
        }
        else {
            let alert = UIAlertController(title: "Awesome", message: "You've finished all the questions, do you want to start over?", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { UIAlertAction in
                self.startOver()
            })
            
            alert.addAction(restartAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    ///This method will check if the user has got the right answer.
    func checkAnswer() {
        
        let correctAnswer = questionModel.list[questionNumber].answer
        
        if correctAnswer == pickedAnswer {
            
            scoreLabel.textColor = UIColor(red: 90/255.0, green: 187/255.0, blue: 181/255.0, alpha: 1.0)
            
            ProgressHUD.showSuccess("Correct!")
            
            score = score + 1
        }else {
            
            scoreLabel.textColor = UIColor(red: 223/255.0, green: 86/255.0, blue: 94/255.0, alpha: 1.0)
            
            ProgressHUD.showError("Wrong!")
            if score != 0 {
                score -= 1
            } else {
                score = 0
            }
        }
    }
    
    ///This method will wipe the board clean, so that users can retake the quiz.
    func startOver() {
        if score == questionModel.list.count {
            scoreLabel.textColor = UIColor(red: 85/255.0, green: 176/255.0, blue: 112/255.0, alpha: 1.0)
        }
        questionNumber = 0
        score = 0
        scoreLabel.textColor = UIColor(red: 1000/255.0, green: 1000/255.0, blue: 1000/255.0, alpha: 1.0)
        updateUI()
        
    }
}

