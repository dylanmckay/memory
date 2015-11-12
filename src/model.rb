
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
  
  def initialize(box_count = BOX_COUNT,
                 turn_count = TURN_COUNT,
                 letter_bag = LETTER_BAG)
    @boxes = []

    # TODO: Clean this up
    (1..(BOX_COUNT/2)).each do |n|
      letter = letter_bag.sample
      @boxes << Box.new(n,letter)
      @boxes << Box.new(n+BOX_COUNT/2,letter)
    end

    @remaining_turns = turn_count
  end

  def in_progress?
    @remaining_turns > 0 && !won?
  end

  def won?
    @boxes.empty?
  end

  def take_turn
    fail if @remaining_turns <= 0
    @remaining_turns -= 1
  end

  def find_box(number)
    @boxes.find { |box| box.number == number }
  end

  # TODO: remove bang
  def remove_boxes!(box1, box2)
    @boxes.reject! { |box| box==box1 || box==box2 }
  end

  def remove_box(box)
    @boxes.reject! { |b| b==box }
  end

  def remaining_box_count
    @boxes.length
  end

  def with_boxes(boxes)
    @boxes = boxes
    self
  end
end

