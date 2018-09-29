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
    response = JSON.parse(line)
    engine = Engine.new(response['data'], response['command'])
    rover = engine.rovers[0]

    if engine.command == 'reset'
      moves = []
    end

    if engine.full?
      logger.info('RETURNING')
      logger.info(moves)
      logger.info(moves.length)
      last_move = moves.pop
      logger.info(last_move)
      logger.info('*'*10)

      next_move = { :dx => last_move[:dx] * (-1), :dy => last_move[:dy] * (-1) }

      rover = engine.rovers[0]

      action_type = "move"
      if (rover['energy'] <= 0)
        action_type = "charge"
      end

      puts(JSON.generate([{:rover_id => 1, :action_type => action_type, :dx => next_move[:dx], :dy => next_move[:dy] }]));
      STDOUT.flush
    else
      step = Step.new(engine.area, rover['x'], rover['y'])
      step_move = step.call

      rover = engine.rovers[0]
      action_type = engine.base_rov ? 'move' : 'dig'

      if engine.command == 'reset' || engine.area[1][1]['objects'].include?(4)
        action_type = 'move'
      end

      if (rover['energy'] <= 0)
        action_type = "charge"
      end
      next_move = { :dx => step_move.first - rover['x'], :dy => step_move.last - rover['y'] }
      logger.info('NEXT MOVE')
      logger.info(next_move)
      if (action_type == 'move')
        moves.push(next_move)
      end
      # moves.push(dx: dx, dy: dy)
      puts(JSON.generate([{:rover_id => 1, :action_type => action_type, :dx => next_move[:dx], :dy => next_move[:dy]}]));
      STDOUT.flush
    end

  rescue JSON::ParserError
    #don't print to output here, better to STDERR
    STDERR.puts('parse error')
  end
end
