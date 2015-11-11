#! /usr/bin/ruby

require_relative 'memory'

model = MemoryModel.new(BOX_COUNT, TURN_COUNT, LETTER_BAG)
view = MemoryCLIView.new
controller = MemoryController.new(model, view)

controller.play
