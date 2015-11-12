
require_relative '../src/model'

describe MemoryModel do

  let(:model) { MemoryModel.new }
  
  describe "#in_progress?" do

    it "returns false when there are no turns left and true while there are" do
      expect(model.in_progress?).to eq true

      TURN_COUNT.times do ||
        model.take_turn
      end

      expect(model.in_progress?).to eq false
    end
  end

  describe "#find_box" do
    it "correctly finds all boxes" do
      (1..BOX_COUNT).each do |n|
        expect(model.find_box(n)).to be_truthy
      end
    end

    it "doesn't find nonexistent boxes" do
      expect(model.find_box(BOX_COUNT+1)).to be_falsy
    end
  end

  describe "#remove_boxes" do

    it "removes boxes when called" do
      (1..BOX_COUNT).step(2).each do |n|
        box1 = model.find_box(n)
        box2 = model.find_box(n+1)

        model.remove_boxes(box1, box2)

        expect(model.find_box(n)).to be_falsy
        expect(model.find_box(n+1)).to be_falsy
      end
    end
  end

  describe "#remaining_box_count" do

    it "decrements when a box is removed" do

      expect(model.remaining_box_count).to eq BOX_COUNT

      (1..BOX_COUNT).each do |n|
        model.remove_box(model.find_box(n))
        expect(model.remaining_box_count).to eq(BOX_COUNT-n)
      end

      expect(model.remaining_box_count).to eq 0
    end
  end
end
