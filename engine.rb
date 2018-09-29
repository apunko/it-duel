class Engine
  attr_accessor :base, :rovers

  def initialize(data)
    @base = data['base']
    @rovers = data['rovers']
  end

  def return_to_base_if_full
    return_to_base if is_full?
  end

  def return_to_base

  end

  def is_full?
    @rovers.first['load'].size == 3
  end

  def area
    @rovers.first['area']
  end
end
