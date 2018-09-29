class Engine
  attr_accessor :base, :rovers, :command

  def initialize(data, command)
    @base = data['base']
    @rovers = data['rovers']
    @command = command
  end

  def return_to_base_if_full
    return_to_base if is_full?
  end

  def base_rov
    x = @base['x']
    y = @base['y']

    r_x = rover['x']
    r_y = rover['y']

    r_x == x && r_y == y
  end

  def back_move
    x = @base['x']
    y = @base['y']

    step = Step.new(engine.area, rover['x'], rover['y'])
    find_best(step.move_steps, x, y)
  end

  def find_best(move_steps, x, y)
    min = 10000
    step_move = null

    move_steps.each do |move|
      f_x_r = move[0]
      f_y_r = move[1]

      if (abs(x - f_x_r) + abs(y - f_y_r)) < min 
        step_move = move
      end
    end

    step_move
  end

  def full?
    load.size == 3
  end

  def rover
    @rovers.first
  end

  def load
    rover['load']
  end

  def area
    rover['area']
  end
end
