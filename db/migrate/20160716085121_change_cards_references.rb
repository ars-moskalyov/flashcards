class ChangeCardsReferences < ActiveRecord::Migration[5.0]
  def change
    add_reference :cards, :deck, index: true, foreign_key: true

    User.all.each do |user|
      cards = Card.where(user_id: user.id)
      if cards.first
        user.decks.create(title: 'First deck')
        cards.each do |card|
          card.update!(deck_id: user.decks.first.id)
        end
      end
    end
    
    remove_reference :cards, :user, foreign_key: true
  end
end
