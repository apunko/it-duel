#!/usr/bin/env ruby

require 'logger'

logger = Logger.new('./log.txt')

require 'rubygems'
require 'json'
require 'pry'
require_relative 'engine'
require_relative 'step'

Random.srand()

$stdout.sync = true

moves = []
while true
  line = STDIN.gets
  begin
  	json = JSON.parse(line)

    logger.info("MOVE: #{json}")

    move = Random.rand(8)
    if move > 3
      move = move + 1
    end
    dx = move % 3 - 1
    dy = move / 3 - 1

    data = JSON.parse(line)['data']
    engine = Engine.new(data)
    step = Step.new(engine.area)

    if engine.full?
      last_move = moves.pop
      next_move = { :dx => last_move[:dx] * (-1), :dy => last_move[:dy] * (-1) }

      puts(JSON.generate([{:rover_id => 1, :action_type => 'move', :dx => next_move[:dx], :dy => next_move[:dy] }]));
      STDOUT.flush
    else
      action_type = %w(move dig).sample
      moves.push(dx: dx, dy: dy)
      puts(JSON.generate([{:rover_id => 1, :action_type => action_type, :dx => dx, :dy => dy}]));
      STDOUT.flush
    end
  rescue JSON::ParserError
    #don't print to output here, better to STDERR
    STDERR.puts('parse error')
  end
end
