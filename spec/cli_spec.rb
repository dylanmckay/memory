
require_relative '../src/cli'

describe MemoryCLIView do

  let(:view) { MemoryCLIView.new }

  describe "#show_box" do

    it "prints the letter contained in the box" do
      box = Box.new(1,'z')
      expect(view).to receive(:puts).with(match(/z/))
      view.show_box(box)
    end
  end

  describe "#prompt_number" do

    it "doesn't accept characters" do
      expect(view).to receive(:puts).at_least(:once)
      expect(view).to receive(:print).at_least(:once)

      "abcd1".chars.each do |c|
        expect(view).to receive(:gets).and_return(c)
      end

      view.prompt_number(0,0)
    end

    it "prints the guess count" do
      expect(view).to receive(:print).with(match(/purple_turtle/))
      expect(view).to receive(:gets).and_return("1\n")

      view.prompt_number("purple_turtle", 0)
    end

    it "prints the boxes remaining count" do
      expect(view).to receive(:print).with(match(/asdf123/))
      expect(view).to receive(:gets).and_return("1\n")
      view.prompt_number(0, "asdf123")
    end
  end
end
