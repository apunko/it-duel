class Step
  attr_accessor :area

  def initialize(area)
    @area = area
  end

  def analyze_object
    area.each do |step|
      puts 'step'
    end
  end
end
