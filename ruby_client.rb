#!/usr/bin/env ruby

require 'logger'

logger = Logger.new('./log.txt')

require 'rubygems'
require 'json'
require 'pry'

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
    data, base, rovers = get_data(line)
    puts data
    puts '*' * 100

    action_type = %w(move dig).sample
    puts(JSON.generate([{:rover_id => 1, :action_type => action_type, :dx => dx, :dy => dy}]));
  rescue JSON::ParserError
    #don't print to output here, better to STDERR
    STDERR.puts('parse error')
  end
end

def get_data(line)
  data = JSON.parse(line)['data']
  base = data['base']
  rovers = data['rovers']

  [data, base, rovers]
end
