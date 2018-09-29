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

    puts '-' * 100
    data = JSON.parse(line)['data']
    engine = Engine.new(data)
    puts engine.base

    step = Step.new(engine.area)
    puts '*' * 100

    action_type = %w(move dig).sample
    puts(JSON.generate([{:rover_id => 1, :action_type => action_type, :dx => dx, :dy => dy}]));
  rescue JSON::ParserError
    #don't print to output here, better to STDERR
    STDERR.puts('parse error')
  end
end
