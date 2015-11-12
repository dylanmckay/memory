
require_relative '../src/memory.rb'

describe MemoryController do

  let(:model) { MemoryModel.new }
  let(:view) { instance_double(MemoryCLIView) }
  let(:controller) { MemoryController.new(model,view) }

  let(:test_box1) { Box.new(12,'a') }
  let(:test_box2) { Box.new(13,'a') }
  let(:test_box3) { Box.new(123,'a') }

  describe "#boxes_match?" do
    it "doesn't match the same box with itself" do
      expect(controller.boxes_match?(test_box1,test_box1)).to eq false
    end

    it "matches two boxes with the same letter" do
      expect(controller.boxes_match?(test_box1, test_box2)).to eq true
    end
  end

  describe "#try_open_box" do
    it "prints message when the box doesn't exist" do

      expect(view).to receive(:show_nonexistent_box_message)
      controller.try_open_box_number(test_box3.number)
    end

    it "removes two matching boxes if opened consecutively" do

      model = MemoryModel.new.with_boxes([test_box1,test_box2])
      controller = MemoryController.new(model,view)

      expect(model.find_box(test_box1.number)).to be_truthy
      expect(model.find_box(test_box2.number)).to be_truthy

      expect(view).to receive(:show_box)
      controller.try_open_box_number(test_box1.number)
      expect(view).to receive(:show_box)
      expect(view).to receive(:show_correct_guess)
      controller.try_open_box_number(test_box2.number)

      expect(model.find_box(test_box1.number)).to be_falsy
      expect(model.find_box(test_box2.number)).to be_falsy
    end
  end

end
