//
//  ConcentrationGame.swift
//  Concentration
//
//  Created by Дима Печенин on 30.08.2021.
//

import Foundation


class ConcentrationGame {
    var cards = [Card] ()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchingIndex = indexOfOneAndOnlyFaceUpCard, matchingIndex != index {
                if cards[matchingIndex].identifier == cards[index].identifier {
                    cards[matchingIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for flipDown in cards.indices {
                    cards[flipDown].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
    }

    init(numberOfPairsOfCards: Int) {
        var preShuffledCards = [Card]()
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            preShuffledCards += [card, card]
        }
        for _ in preShuffledCards {
            let randomIndex = preShuffledCards.count.arc4random
            let randomCard = preShuffledCards.remove(at: randomIndex)
            cards.append(randomCard)
//            print(randomCard)
        }

        }
        //TODO: Shuffle the cards
    }



