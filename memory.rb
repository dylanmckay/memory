#! /usr/bin/ruby

TURN_COUNT = 40
BOX_COUNT = 20
LETTER_BAG = "abbccddeeffgghhiijj".chars

class Box
  attr_reader :letter, :number

  def initialize(number, letter)
    @number = number
    @letter = letter
  end
end

class MemoryModel
  attr_reader :boxes, :remaining_turns
  
  def initialize(box_count, turn_count, letter_bag)
    @boxes = (1..box_count).map { |num| Box.new(num, letter_bag.sample) }
    @remaining_turns = turn_count
  end

  def in_progress?
    @remaining_turns > 0 && !won?
  end

  def won?
    @boxes.empty?
  end

  def decrement_remaining_turns
    fail if @remaining_turns <= 0
    @remaining_turns -= 1
  end

  def find_box(number)
    @boxes.find { |box| box.number == number }
  end

  def remove_boxes!(box1, box2)
    @boxes.reject! { |box| box==box1 || box==box2 }
  end

  def remaining_box_count
    @boxes.length
  end
end

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
    @model.decrement_remaining_turns

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

class MemoryView
  def prompt_number(guesses_left, boxes_remaining_count)
    
    loop do
      print("[#{guesses_left} guesses, #{boxes_remaining_count} boxes left] Enter a box number: ")
      num = gets.chomp.to_i

      if num
        return num
      else
        puts("Please enter a number")
      end
    end
  end

  def show_box(box)
    puts("The box contains '#{box.letter}'")
  end

  def show_nonexistent_box_message(number)
    puts("No box numbered `#{number}` exists")
  end

  def show_correct_guess(box1, box2)
    puts("You correctly guessed the letter #{box1.letter}! Cases #{box1.number} and #{box2.number} have been removed!")
  end
  
  def show_win
    puts("You win!")
  end

  def show_lose(boxes)
    puts("You lose :(")

    show_boxes(boxes)
  end

  def show_boxes(boxes)
    puts("Boxes:")

    boxes.each { |box| puts("#{box.number}: #{box.letter}") }
  end
end

model = MemoryModel.new(BOX_COUNT, TURN_COUNT, LETTER_BAG)
view = MemoryView.new
controller = MemoryController.new(model, view)

controller.play
