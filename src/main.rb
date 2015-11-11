#! /usr/bin/ruby

require_relative 'memory'

model = MemoryModel.new
view = MemoryCLIView.new
controller = MemoryController.new(model, view)

controller.play
