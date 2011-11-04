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
    display_splash
    wait_for_input("any")
    display_menu
  end

  def display_splash
    clear_screen
    print_to_screen((@width/2)-6, (@height/2)-2, "( G\u00f6rillas )")
    print_to_screen((@width/2)-8, (@height/2)+2, "press any key to")
    print_to_screen((@width/2)-5, (@height/2)+3, "start game")
  end

  def display_menu
    clear_screen

    @rounds = prompt("Number of rounds? ").to_i
    @rounds = 3 if @rounds < 1

    round_str = "First to #{@rounds} "
    round_offset = (@width/2)-10

    round_offset += print_to_screen(round_offset, @height/2, round_str)

    wait 500
    round_offset += print_to_screen(round_offset, @height/2, ".")
    wait 500
    round_offset += print_to_screen(round_offset, @height/2, ".")
    wait 500
    round_offset += print_to_screen(round_offset, @height/2, ". ")
    wait 800
    print_to_screen(round_offset, @height/2,"Fight!")

    wait 1000
  end


  private

  def print_to_screen(x, y, str)
    x = (x < 0) ? 0 : x
    y = (y < 1) ? 1 : y

    new_line = @buffer[y]
    new_line[x, str.length] = str
    @buffer[y] = new_line
    redraw

    return str.length
  end

  def clear_screen
    VIM::evaluate("genutils#OptClearBuffer()")
    blank_line = " "*@width
    @buffer[1] = blank_line
    (1...@height).each do |line|
      @buffer.append(line, blank_line)
    end
  end

  def wait_for_input(args)
    valid_input = args.split(",")
    if valid_input.first == "any"
      VIM::evaluate("getchar()")
    else
      while true
        break if valid_input.include?(VIM::evaluate("getchar()"))
      end
    end

    return
  end

  def redraw
    VIM::command("redraw")
  end

  def prompt(question)
    VIM::message('prompting...')
    return VIM::evaluate("input('#{question}')")
  end

  def wait(time)
    VIM::command("sleep #{time}m")
  end
end
