class GorillasGame

  def initialize(buffer=VIM::Buffer.current)
    @buffer = buffer
    @window = VIM::Window.current
    @height = @window.height
    @width  = @window.width

    start_game
  end

  def start_game
    display_menu
  end

  def display_menu
    clear_screen
    print_to_screen((@width/2)-4, (@height/2)-1, "Gorillas")
  end


  private

  def print_to_screen(x, y, str)
    x = (x > 0) ? x : 1
    y = (y > 0) ? y : 1

    new_line = @buffer[y]
    new_line[x, str.length] = str
    @buffer[y] = new_line
  end

  def clear_screen
    blank_line = " "*@width
    (0...@height).each do |line|
      @buffer.append(line, blank_line)
    end
    @buffer.delete(@height) # append adds another line, we don't want it
  end
end
