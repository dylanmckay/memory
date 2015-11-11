
TURN_COUNT = 40
BOX_COUNT = 20
LETTER_BAG = "abbccddeeffgghhiijj".chars

require_relative 'model'
require_relative 'cli'

class MemoryController

  def initialize(model, view)
    @model = model
    @view = view
    @last_box = nil
  end

  def play
    play_turn while @model.in_progress?

    if won?
      @view.show_win
    else
      @view.show_lose(@model.boxes)
    end
  end

  def play_turn
    number = @view.prompt_number(@model.remaining_turns, @model.remaining_box_count)
    try_open_box(number)
  end

  def try_open_box(number)
    box = @model.find_box(number)

    if box
      open_box(box)
    else
      @view.show_nonexistent_box_message(number)
      @last_box = nil
    end
  end

  def open_box(box)
    @view.show_box(box)
    @model.take_turn

    if boxes_match?(box, @last_box)
      @view.show_correct_guess(box, @last_box)
      @model.remove_boxes!(@last_box, box)
      @last_box = nil
    else
      @last_box = box
    end
  end

  private

  def boxes_match?(box1, box2)
    box1 && box2 && (box1 != box2) && box1.letter == box2.letter
  end
end

