//
//  QuestionViewController.swift
//  PersonalityQuizFinal
//
//  Created by Jerry Eapen on 4/4/21.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var Questionlabel: UILabel!
    
    
    @IBOutlet weak var singleStackView: UIStackView!
    
    @IBOutlet weak var singlebutton1: UIButton!
    @IBOutlet weak var singlebutton2: UIButton!
    @IBOutlet weak var singlebutton3: UIButton!
    @IBOutlet weak var singlebutton4: UIButton!
    @IBOutlet weak var multipleStackView: UIStackView!
    
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiswitch2: UISwitch!
    @IBOutlet weak var multiswitch3: UISwitch!
    @IBOutlet weak var multiswitch4: UISwitch!
    
    
    @IBOutlet weak var multilabel1: UILabel!
    @IBOutlet weak var multilabel2: UILabel!
    @IBOutlet weak var multilabel3: UILabel!
    @IBOutlet weak var multilabel4: UILabel!
    
    
    @IBOutlet weak var rangedStackView: UIStackView!
    
    @IBOutlet weak var rangedlabel1: UILabel!
    @IBOutlet weak var rangedlabel2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    
    @IBOutlet weak var questionProgressView: UIProgressView!

    
    var questions: [Question] = [
        Question(text: "Which food do you like the most?",
                 type: .single,
                 answers: [
                    Answer(text: "Steak", type: .dog),
                    Answer(text: "Fish", type: .cat),
                    Answer(text: "Carrots", type: .rabbit),
                    Answer(text: "Corn", type: .turtle)
                 
                 ]),
            Question(text: "Which Activites do you enjoy?",
                     type: .multiple,
                     answers: [
                        Answer(text: "Swimming", type: .turtle),
                        Answer(text: "Sleeping", type: .cat),
                        Answer(text: "Cuddling", type: .rabbit),
                        Answer(text: "Eating", type: .dog)
                     ]),
            Question(text: "How much do you enjoy car rides?",
                         type: .ranged,
                         answers: [
                            Answer(text: "I dislike them", type: .cat),
                            Answer(text: "I get a little nervous", type: .rabbit),
                            Answer(text: "I barely notice them", type: .turtle),
                            Answer(text: "I love them", type: .dog)
                         
                         ]),
                ]
    var questionIndex = 0
    
    var answersChosen: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateUI()
    }
    func updateUI() {
        
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        navigationItem.title = "Question #\(questionIndex+1))"
        
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float (questions.count)
        
        Questionlabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated:true)
    
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
    }
    
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singlebutton1.setTitle(answers[0].text, for: .normal)
        singlebutton2.setTitle(answers[1].text, for: .normal)
        singlebutton3.setTitle(answers[2].text, for: .normal)
        singlebutton4.setTitle(answers[3].text, for: .normal)
    }
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiswitch2.isOn = false
        multiswitch3.isOn = false
        multiswitch4.isOn = false
        multilabel1.text = answers[0].text
        multilabel2.text = answers[1].text
        multilabel3.text = answers[2].text
        multilabel4.text = answers[3].text
        
    }
    func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedlabel1.text = answers.first?.text
        rangedlabel2.text = answers.last?.text
        
        
    }

    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
        case singlebutton1:
            answersChosen.append(currentAnswers[0])
        case singlebutton2:
            answersChosen.append(currentAnswers[1])
        case singlebutton3:
            answersChosen.append(currentAnswers[2])
        case singlebutton4:
            answersChosen.append(currentAnswers[3])
        
        default:
            break
        }
    
        nextQuestion()
        
    }
    
    @IBAction func multipleAnswerButtonPressed(_ sender: Any) {
        
        let currentAnswer = questions[questionIndex].answers
        
        if multiSwitch1.isOn {
            answersChosen.append(currentAnswer[0])
        }
        if multiswitch2.isOn {
            answersChosen.append(currentAnswer[1])
        }
        if multiswitch3.isOn {
            answersChosen.append(currentAnswer[2])
        }
        if multiswitch4.isOn {
            answersChosen.append(currentAnswer[3])
        
        }
        
        nextQuestion()
        
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.responses = answersChosen
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

}
