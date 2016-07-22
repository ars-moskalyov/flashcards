class CheckAnswer

  def initialize(card_id, answer)
    @card = Card.find(card_id)
    @answer = answer
    @hh = { 1 => 12.hours,
            2 => 3.days,
            3 => 1.week,
            4 => 2.weeks,
            5 => 1.month }
  end

  def check
    if levenshtein_distance <= 1
      set_date
    else
      wrong_answer
    end
    { err: levenshtein_distance,
      card: @card,
      answer: @answer }
  end

  private

  def levenshtein_distance
    DamerauLevenshtein.distance(@card.original_text.mb_chars.downcase, @answer.strip.mb_chars.downcase)
  end

  def set_date
    x = @card.check + 1
    x = 5 unless x <= 5
    @card.update!(review_date: Time.current + @hh[x], check: x, effort: 0)
  end

  def wrong_answer
    new_attrs = @card.effort < 2 ? effort_up : check_down
    @card.update!(new_attrs)
  end

  def effort_up
    { effort: @card.effort + 1 }
  end

  def check_down
    if @card.check > 1
      { review_date: Time.current + @hh[@card.check - 1], check: @card.check - 1, effort: 0 }
    else
      { effort: 0 }
    end
  end
end
