#!/usr/bin/env ruby

require 'rubygems'
require 'json'

Random.srand()

$stdout.sync = true

while true
  line = STDIN.gets
  begin
  	# json = JSON.parse(line)
    move = Random.rand(8)
    if move > 3
      move = move + 1
    end
    dx = move % 3 - 1
    dy = move / 3 - 1
    puts(JSON.generate([{:rover_id => 1, :action_type => 'move', :dx => dx, :dy => dy}]));
  rescue JSON::ParserError
    #don't print to output here, better to STDERR
    STDERR.puts('parse error')
  end
end
