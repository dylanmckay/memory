#! /usr/bin/ruby

require_relative 'memory'

DEBUG = true

if !DEBUG
  system "clear" or system "cls"
end

model = MemoryModel.new
view = MemoryCLIView.new
controller = MemoryController.new(model, view)

controller.play
