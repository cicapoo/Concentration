//
//  ViewController.swift
//  Concentration
//
//  Created by Дима Печенин on 27.08.2021.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = ConcentrationGame(numberOfPairsOfCards: (buttonCollection.count + 1) / 2)

// Создали перменную и назвали ее touches. Каждый раз при нажатии кнопок к нашей переменной touches будет прибавляться 1:
    var touches = 0 {
        didSet{
            touchLabel.text = "Touches: \(touches)"
        }
    }
    
//  В этой части мы создали логику как будет переворачиваться наша карточка (мы создали функцию, которая принимает 2 параметра: эмодзи и прописасли весь механизм):
//    func flipButton(emoji: String, button: UIButton) {
//        if button.currentTitle == emoji {
//            button.setTitle("", for: .normal)
//            button.backgroundColor = #colorLiteral(red: 0.2338206172, green: 0.4236084819, blue: 1, alpha: 1)
//        } else {
//            button.setTitle(emoji, for: .normal)
//            button.backgroundColor = #colorLiteral(red: 0.999904573, green: 1, blue: 0.9998808503, alpha: 1)
//        }
//    }

    
// Мы создали массив из эмодзи который будет передавать нашей функции (которая принимает эмодзи) и переворачивать карточкуЖ
    var emojiCollection = ["🦟","🦑","🦛","🦓","🦒","🐊","🐳","🦫","🐀","🐗","🐖","🦔"]
    
    var emojiDictionary = [Int:String]()
    
    func emojiIdentifier(for card: Card) -> String {
        if emojiDictionary[card.identifier] == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiCollection.count)))
            emojiDictionary[card.identifier] = emojiCollection.remove(at: randomIndex)
        }

//        let chosenEmoji = emojiDictionary[card.identifier]
//        if emojiDictionary[card.identifier] != nil {
//            return emojiDictionary[card.identifier]!
//        } else {
//            return "?"
//        }
        
        return emojiDictionary[card.identifier] ?? "?"
    }
        
    func updateViewFromModel() {
        for index in buttonCollection.indices {
            let button = buttonCollection[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emojiIdentifier(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.999904573, green: 1, blue: 0.9998808503, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.2666102052, green: 0.4350079894, blue: 1, alpha: 1)
        
                
            }
        }
        
    }

        
    @IBOutlet var buttonCollection: [UIButton]!
    @IBOutlet weak var touchLabel: UILabel!
    @IBAction func burronAction(_ sender: UIButton) {
        touches += 1
// Функцией нажатия на кнопку мы вызываем функцию с нашей инструкцией  как нужно переворачивать карточки и как каждой кнопке присваивать эмодзи, которая имеет тот же индекс, что и индекс кнопки:
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            
            game.chooseCard(at: buttonIndex)
//            flipButton(emoji: emojiCollection[buttonIndex], button: sender)
            updateViewFromModel()
            
    }
    
}

}

extension Int {
    
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
    
}


