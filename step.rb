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

  def move_steps_dig_no
     results = []

     results << [x - 1, y - 1] unless area.flatten[0] == 5 || area[0][0]['objects'].include?(4)
     results << [x, y - 1] unless area.flatten[1] == 5 || area[0][1]['objects'].include?(4)
     results << [x + 1, y - 1] unless area.flatten[2] == 5 || area[0][2]['objects'].include?(4)
     results << [x - 1, y] unless area.flatten[3] == 5 || area[1][0]['objects'].include?(4)
     results << [x + 1, y] unless area.flatten[5] == 5 || area[1][2]['objects'].include?(4)
     results << [x - 1, y + 1] unless area.flatten[6] == 5 || area[2][0]['objects'].include?(4)
     results << [x, y + 1] unless area.flatten[7] == 5 || area[2][1]['objects'].include?(4)
     results << [x + 1, y + 1] unless area[2][2]['objects'].include?(4) || area.flatten[8] == 5

     results
  end
end
