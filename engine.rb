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

  def return_to_base

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
