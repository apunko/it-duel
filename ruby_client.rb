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
      action_type = %w(dig dig dig move dig dig dig dig dig).sample #data['step'] == 0 ? 'move' : 'dig'
      action_type = 'move' if engine.area.flatten.size > 0 && engine.area[1][1]['terrain'] == 5

      if (rover['energy'] <= 0)
        action_type = "charge"
      end
      moves.push(dx: step_move.first - rover['x'], dy: step_move.last - rover['y'])
      # moves.push(dx: dx, dy: dy)
      puts(JSON.generate([{:rover_id => 1, :action_type => action_type, :dx => step_move.first - rover['x'], :dy => step_move.last - rover['y']}]));
      STDOUT.flush
    end
  rescue JSON::ParserError
    #don't print to output here, better to STDERR
    STDERR.puts('parse error')
  end
end
