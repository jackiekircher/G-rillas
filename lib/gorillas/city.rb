class City
  attr_accessor :p1_pos, :p2_pos
  attr_accessor :grid

  def initialize(width, height)
    @width = width
    @height = height
    @grid = Array.new(width) { Array.new(height) { " " } }

    generate_buildings
  end

  private

  def generate_buildings
    used = 0
    while used < @width
      used += generate_building(used)
    end
  end

  def generate_building(used)
    if (@width - used) < 20
      width = @width - used
    elsif (@width - used) < 30
      max = @width - used - 10
      width = rand( max-9 )+10 # 10 <= width <= 20
    else
      width = rand( 11 )+10 # 10 <= width <= 20
    end

    height = rand( (@height*3)/4 - 1 ) + 1

    column = [" "]*(@height-height) + ["."]*height
    @grid[used, width] = [column]*width 

    return width
  end

end
