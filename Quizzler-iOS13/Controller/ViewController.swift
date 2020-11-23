

import UIKit

class ViewController: UIViewController {
    
    //Link to UI Elements
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var QuestionText: UILabel!
    @IBOutlet weak var TrueButton: UIButton!
    @IBOutlet weak var FalseButton: UIButton!
    @IBOutlet weak var ProgressBar: UIProgressView!
    
    //Link to Logic/Data
    var quizBrain = QuizBrain()
    var quizDatabase = QuizDatabase()
    
    //Initial View
    override func viewDidLoad() {
        super.viewDidLoad()
        QuestionText.text = self.quizBrain.GetQuestionText()
        ScoreLabel.text = "SCORE: \(quizBrain.GetScore())"
        ProgressBar.progress = 0
        TrueButton.alpha = 1
        FalseButton.alpha = 1
        ScoreLabel.alpha = 1
    }
    
    //Respond to Answer Button (True/False) Pressed
    @IBAction func AnswerButtonPressed(_ sender: UIButton) {
        let AnswerValidation: Bool = quizBrain.ValidateAnswer(UserAnswer: sender.currentTitle!)
        if AnswerValidation == true {
            let NextQuestion = quizBrain.NextQuestion()
            ScoreLabel.text = "SCORE: \(quizBrain.GetScore())"
            if NextQuestion == true {
                QuestionText.text = "Nice! Next question..."
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.QuestionText.text = self.quizBrain.GetQuestionText()
                    self.ProgressBar.progress = self.quizBrain.GetCurrentProgress()
                }
            } else {
                QuestionText.text = "End of Quiz! Will Restart in 3s..."
                ProgressBar.progress = 1
                TrueButton.alpha = 0
                FalseButton.alpha = 0
                ScoreLabel.alpha = 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.Restart()
                }
            }
        } else {
            QuestionText.text = "Wrong. Please try again."
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.QuestionText.text = self.quizBrain.GetQuestionText()
            }
        }
    }
    
    //Restart/Reset Once Quiz is Over
    func Restart() {
        quizBrain.Restart(true)
        viewDidLoad()
    }
}
