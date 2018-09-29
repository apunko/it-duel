class Step
  attr_accessor :area, :x, :y

  def initialize(area, x, y)
    @area = area
    @x = x
    @y = y
  end

  def move_steps
   results = []

   results << [x - 1, y - 1] if area.flatten[0] != 5
   results << [x, y - 1] if area.flatten[1] != 5
   results << [x + 1, y - 1] if area.flatten[2] != 5
   results << [x - 1, y] if area.flatten[3] != 5
   results << [x + 1, y] if area.flatten[5] != 5
   results << [x - 1, y + 1] if area.flatten[6] != 5
   results << [x, y + 1] if area.flatten[7] != 5
   results << [x + 1, y + 1] if area.flatten[7] != 5

   results
  end
end
