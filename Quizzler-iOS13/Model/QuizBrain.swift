
import Foundation

var quizDatabase = QuizDatabase()

var QuestionCount: Int = 0

struct QuizBrain {
    
    func ValidateAnswer (UserAnswer: String) -> Bool {
        if UserAnswer == quizDatabase.AnswerBank[QuestionCount] {
            return true
        } else {
            return false
        }
    }
    
    func NextQuestion () -> Bool {
        QuestionCount += 1
        if QuestionCount <= quizDatabase.QuestionBank.count - 1 {
            return true
        } else {
            return false
        }
    }
    
    func GetQuestionText () -> String {
        let QuestionText = quizDatabase.QuestionBank[QuestionCount]
        return QuestionText
    }
    
    func GetCurrentProgress () -> Float {
        let NumberOfQuestions = Float(quizDatabase.QuestionBank.count)
        let CurrentQuestion = Float(QuestionCount)
        var Progress: Float = (NumberOfQuestions - CurrentQuestion)/NumberOfQuestions
        Progress = 1-Progress
        return Progress
    }
    
    func GetScore () -> Int {
        let Score = QuestionCount
        return Score
    }
    
    func Restart (_ True: Bool) {
        if True == true {
            QuestionCount = 0
        }
    }
}
