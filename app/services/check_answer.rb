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

  def success?
    check
  end

  private

  def check
    if @card.original_text.mb_chars.downcase == @answer.strip.mb_chars.downcase
      set_date
      return true
    else
      wrong_answer
      return false
    end
  end

  def set_date
    x = @card.check + 1
    if x <= 5
      @card.update!(review_date: Time.now + @hh[x], check: x, effort: 0)
    else
      @card.update!(review_date: Time.now + @hh[5], check: 5, effort: 0)
    end
  end

  def wrong_answer
    if @card.effort < 2
      effort_up
    else
      check_down
    end
  end

  def effort_up
    @card.update!(effort: @card.effort + 1)
  end

  def check_down
    if @card.check > 1
      @card.update!(review_date: Time.now + @hh[@card.check - 1], check: @card.check - 1, effort: 0)
    else
      @card.update!(effort: 0)
    end
  end
end
