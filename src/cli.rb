

class MemoryCLIView
  def prompt_number(guesses_left, boxes_remaining_count)
    
    loop do
      print("[#{guesses_left} guesses, #{boxes_remaining_count} boxes left] Enter a box number: ")
      num = Integer(gets.chomp) rescue nil

      if num
        if !DEBUG
          system "clear" or system "cls"
        end

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
