class GorillasGame

  def initialize(buffer=VIM::Buffer.current)
    @buffer = buffer
    @window = VIM::Window.current
    @height = @window.height
    @width  = @window.width

    if @height < 20 || @width < 70
      clear_screen
      VIM::message("Your window is too small, please resize it to at least 70x20")
      VIM::command('q!')
    else
      start_game
    end
  end

  def start_game
    display_menu
  end

  def display_menu
    clear_screen
    print_to_screen((@width/2)-4, (@height/2)-1, "G\u00f6rillas")
  end


  private

  def print_to_screen(x, y, str)
    x = (x < 0) ? 0 : x
    y = (y < 1) ? 1 : y

    new_line = @buffer[y]
    new_line[x, str.length] = str
    @buffer[y] = new_line
  end

  def clear_screen
    VIM::evaluate("genutils#OptClearBuffer()")
    blank_line = " "*@width
    @buffer[1] = blank_line
    (1...@height).each do |line|
      @buffer.append(line, blank_line)
    end
    #@buffer.delete(1) # append adds another line, we don't want it
  end
end
