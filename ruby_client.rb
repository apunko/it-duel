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
    rover = engine.rovers[0]
    step = Step.new(engine.area, rover['x'], rover['y'])
    step_move = step.move_steps.sample

    if engine.full?
      last_move = moves.pop
      next_move = { :dx => last_move[:dx] * (-1), :dy => last_move[:dy] * (-1) }

      rover = engine.rovers[0]

      action_type = "move"
      if (rover['energy'] <= 0)
        action_type = "charge"
      end

      puts(JSON.generate([{:rover_id => 1, :action_type => action_type, :dx => next_move[:dx], :dy => next_move[:dy] }]));
      STDOUT.flush
    else
      rover = engine.rovers[0]
      action_type = %w(move dig).sample
      action_type = 'move' if engine.area[1][1]['terrain'] == 5

      if (rover['energy'] <= 0)
        action_type = "charge"
      end
      moves.push(dx: step_move.first, dy: step_move.last)
      # moves.push(dx: dx, dy: dy)
      puts(JSON.generate([{:rover_id => 1, :action_type => action_type, :dx => dx, :dy => dy}]));
      STDOUT.flush
    end
  rescue JSON::ParserError
    #don't print to output here, better to STDERR
    STDERR.puts('parse error')
  end
end
