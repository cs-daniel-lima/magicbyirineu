import Foundation

///Organiza as cartas
class CardOrganizer {
    
    var decks:Array<CardDeck> = Array()
    
    private var lastSet:CardSet? = nil
    
    func append(cards:[Card], set:CardSet, type:String) {
        //Se for um Set novo cria-se um deck
        if self.lastSet == nil || self.lastSet != set {
            self.lastSet = set
            var deck = CardDeck(set: set)
            deck.add(type: type)
            deck.add(cards: cards)
            self.decks.append(deck)
        }else{
            self.decks[self.decks.count-1].add(type: type)
            self.decks[self.decks.count-1].add(cards: cards)
        }
    }
    
    func getElement(setIndex:Int, elementIndex:Int) -> Any? {
        if decks.indices.contains(setIndex){
            return decks[setIndex].getElement(at: elementIndex)
        } else {
            return nil
        }
    }
    
    func clean() {
        self.decks = Array()
        self.lastSet = nil
    }
}
