//
//  Question.swift
//  Quizzler
//
//  Created by Ahmed Amr on 1/21/18.
//

import Foundation

class Question {
    
    let questionText : String
    let answer : Bool
    
    init( questionText : String , answer : Bool ) {
        self.questionText = questionText
        self.answer = answer
    }
    
}

class otherclass {
    let q1 = Question(questionText: "ahmd??", answer: true)
}
