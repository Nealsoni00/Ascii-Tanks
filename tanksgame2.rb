class String
      def black;          "\033[30m#{self}\033[0m" end
      def red;            "\033[31m#{self}\033[0m" end
      def green;          "\033[32m#{self}\033[0m" end
      def brown;          "\033[33m#{self}\033[0m" end
      def blue;           "\033[34m#{self}\033[0m" end
      def magenta;        "\033[35m#{self}\033[0m" end
      def cyan;           "\033[36m#{self}\033[0m" end
      def gray;           "\033[37m#{self}\033[0m" end
      def bg_black;       "\033[40m#{self}\033[0m" end
      def bg_red;         "\033[41m#{self}\033[0m" end
      def bg_green;       "\033[42m#{self}\033[0m" end
      def bg_brown;       "\033[43m#{self}\033[0m" end
      def bg_blue;        "\033[44m#{self}\033[0m" end
      def bg_magenta;     "\033[45m#{self}\033[0m" end
      def bg_cyan;        "\033[46m#{self}\033[0m" end
      def bg_gray;        "\033[47m#{self}\033[0m" end
      def bold;           "\033[1m#{self}\033[22m" end
      def reverse_color;  "\033[7m#{self}\033[27m" end
end
class Numeric
  def degrees
    self * Math::PI / 180
  end
end
def intro_animation()
  pad = "                                                      "
  pad2 = "  "
  for i in 0..25 do
    system("clear")
    pad = pad.chomp("  ")
    pad2[i] = "  "
    tank1 = pad2 + "░░░░░░███████ ]▄▄▄▄▄▄▄▄▃".red + pad + "                 ▃▄▄▄▄▄▄▄▄[ ███████░░░░░░".blue
    tank2 = pad2 + "▂▄▅█████████▅▄▃▂                    ".red + pad + "            ▂▃▄▅█████████▅▄▂".blue
    tank3 = pad2 + "I███████████████████].                  ".red + pad + "     .[███████████████████I".blue
    tank4 = pad2 + "  ◥⊙▲⊙▲⊙▲⊙▲⊙▲⊙▲⊙◤...          ".red + pad + "                ...◥⊙▲⊙▲⊙▲⊙▲⊙▲⊙▲⊙◤".blue
    puts tank1
    puts tank2
    puts tank3
    puts tank4
    sleep(0.1)
  end
  puts "                                  _________  ________  ________   ___  __    ________
                                 |\\___   ___\\\\   __  \\|\\   ___  \\|\\  \\|\\  \\ |\\   ____\\
                                 \\|___ \\  \\_\\ \\  \\|\\  \\ \\  \\\\ \\  \\ \\  \\/  /|\\ \\  \\___|_
                                      \\ \\  \\ \\ \\   __  \\ \\  \\\\ \\  \\ \\   ___  \\ \\_____  \\
                                       \\ \\  \\ \\ \\  \\ \\  \\ \\  \\\\ \\  \\ \\  \\\\ \\  \\|____|\\  \\
                                        \\ \\__\\ \\ \\__\\ \\__\\ \\__\\\\ \\__\\ \\__\\\\ \\__\\____\\_\\  \\
                                         \\|__|  \\|__|\\|__|\\|__| \\|__|\\|__| \\|__|\\_________\\
                                                                                \\|_________|"
  sleep(1)
  puts "                                     __             _   __           __   ____              _
                                    / /_  __  __   / | / /__  ____ _/ /  / ___/____  ____  (_)
                                   / __ \\/ / / /  /  |/ / _ \\/ __ `/ /   \\__ \\/ __ \\/ __ \\/ /
                                  / /_/ / /_/ /  / /|  /  __/ /_/ / /   ___/ / /_/ / / / / /
                                 /_.___/\\__, /  /_/ |_/\\___/\\__,_/_/   /____/\\____/_/ /_/_/
                                       /____/  ".green.bold
end
alias oldGets gets
def gets
  inp = oldGets
  if(inp.chop == 'exit') then
    exit()
  else
    return inp
  end
end
class HightMapGen
  def initialize(width,startRange = 0.0..20.0,variance = 9,roughness = 0.4)
    @width = width
    @internalWidth = 2 ** (Math.log(width-1) / Math.log(2)).ceil + 1
    @startRange = startRange
    @variance = variance.to_f
    @roughness = roughness.to_f
  end
  def gen()
    stepSize = @internalWidth - 1
    map = Array.new(@internalWidth)
    map[0] = rand(@startRange)
    map[-1] = rand(@startRange)
    range = 0...(@internalWidth-1)
    variance = @variance
    while stepSize > 1 do
      range.step(stepSize) do |startIndex|
        a = map[startIndex]
        b = map[startIndex + stepSize]
      #  puts [startIndex..(startIndex+stepSize), startIndex]
        c =  (a + b) / 2 + rand(-variance..variance)
        map[stepSize / 2 + startIndex] = c
      end
      variance *= @roughness
      stepSize /= 2
    end
    return map[0...@width]
  end
end
mapGen = false
while mapGen == false do
  a = HightMapGen.new(156)
  map = a.gen
  world =  Array.new(10){ |y|
    Array.new(map.length){ |x|
      map[x] < y ? '█' : ' '
    }.join('')
  }
  for i in 0..156 do
      if world[0][i] == "█" then
        mapGen = true
      end
  end
end
#puts world.join("\n").gsub("█","█".green)

#create new randome map
position = false
while position == false do
  xp1 = rand(5..156)
  xp2 = rand(5..156)
  if (xp1 - xp2).abs > 30 then
    position = true
  end
end

map_random = Array.new
map_random = map_random.fill('|' + ' '*156 + '|',5..45).fill('|' + '█'*156+'|',3..4).fill('|' + '#'*156+'|',0..2).map{|e| e+''}
for @i in 0...10 do
  for @z in 0...156 do
    map_random[44-(@i+4) - 27][@z+1] = world[@i][@z]
  end
end
map_min_array = false
map_min = Array.new
i = 44
for q in 1..156 do
  i = 44
#  puts i
  while map_min_array == false
  #  puts i
    if map_random[i][q] != " " then
      #puts "#{i} , #{q}"
      map_min_array = true
      map_min[q] = i
    end
    i = i - 1
  end
  map_min_array = false
end
p1_ylocation_test = false
p2_ylocation_test = false
i = 44
while p1_ylocation_test == false do
  if map_random[i][xp1] != " " then
    yp1 = i + 1
    puts "xp1 = #{xp1} and yp1 = #{yp1}"
    p1_ylocation_test = true
  end
  i = i - 1
end
i = 44
while p2_ylocation_test == false do
  if map_random[i][xp2] != " " then
    yp2 = i + 1
    puts "xp2 = #{xp2} and yp2 = #{yp2}"
    p2_ylocation_test = true
  end
  i = i - 1
end
player_1 = "♛"
player_2 = "♕"
if xp1 > xp2 then
  map_random[yp1+1][xp1-2] = "↖"
  map_random[yp2+1][xp2+2] = "↗"
end
if xp1 < xp2 then
  map_random[yp1+1][xp1+2] = "↗"
  map_random[yp2+1][xp2-2] = "↖"
end
map_random[yp2][xp2] = player_2
map_random[yp1][xp1] = player_1
map_blank = Array.new
map_blank = map_random.dup
puts map_random.reverse.join("\n").gsub("♛","♛".cyan).gsub("♕","♕".red).gsub("#","#".brown).gsub("█","█".green)


def draw_map(x, y, map_random, map_blank)
  print "\e[0;0f"
  if x < 0 then
    x = 156 + x
  end
  # if x > 156 then
  #   x = (x - 156)
  # end
  if x > 156 then
    x = (x - 156)
  end
  if y > 44 then
    y = 44
  end
  part = map_random[y][x]
  map_random[y][x] = "☣"
  puts map_random.reverse.join("\n").gsub("♛","♛".cyan).gsub("♕","♕".red).gsub("#","#".brown).gsub("█","█".green)
  puts "#{x}, #{y}"
  if x > 158 then
    part = " "
  end
  map_random[y][x] = part
#  map_random[y][x] = map_blank[y][x]
end


def get_velocity(turn)
  good_velocity = false
  while good_velocity == false do
    puts "please give me a velocity (20-100)"
    if turn == "1" then
      puts "Enter velocity Player: #{turn}:".cyan
    end
    if turn == "2" then
      puts "Enter velocity Player: #{turn}:".red
    end
    velocity = gets.chomp.to_f
    if velocity < 100 and velocity > 20 then
      good_velocity = true
    end
  end
  return velocity
end
def get_angle(turn)
  good_angle = false
  while good_angle == false do
    puts "angles(your options include but are not limited to): ← = 180, ↖ = 135, ↑ = 90, ↗ = 45, → = 0"
    if turn == "1" then
      puts "Enter an angle player: #{turn}:".cyan
    end
    if turn == "2" then
      puts "Enter an angle player: #{turn}:".red
    end
    angle = gets.chomp.to_f
    if angle > 0 and angle < 180 then
      good_angle = true
    end
  end
  return angle
end
puts intro_animation()

x = 2
y = 2
puts "Tanks! Please imput Player 1's Name:"
p1_name = gets.chomp
puts "please imput player 2's Name:"
p2_name = gets.chomp
system 'clear'
turn = "1"
draw_map(x, y, map_random, map_blank)
puts "Player 1: #{p1_name}".cyan
puts "Player 2: #{p2_name}".red
gameOver = false
while gameOver == false
  angle = get_angle(turn)
  velocity = get_velocity(turn)/1.5
  time = 0.0
  particle_live = true
  print "\a"
  while particle_live == true do
    x = (velocity * time *Math.cos(angle.degrees))
    y = (velocity * time *Math.sin(angle.degrees) - 0.5*9.8*time*time)
    # if time < 0.6 and time > 0.0 then
    #   y = y + 5
     #end
    time = time + 0.02
    sleep(0.02)
    if turn == "1" then
      if xp1 < xp2 then
        y = (y + yp1).to_i
        x = (x + xp1).to_i
      end
      if xp1 > xp2 then
        y = (y + yp1- 1).to_i
        x = (x + xp1 - 1).to_i
      end
    end
    if turn == "2" then
      if xp1 < xp2 then
        y = (y + yp2).to_i
        x = (x + xp2).to_i
      end
      if xp1 > xp2 then
        y = (y + yp2 - 1).to_i
        x = (x + xp2 - 1).to_i
      end
    end

    x%=156
    puts "INSIDE LOOP: #{x},#{y}"


    if y == map_min[x] and time > 0.2 then
        particle_live = false
        if turn == "1" then
          turn = "2"
        else
          turn = "1"
        end
        map_random = map_blank.dup
        system 'clear'
        draw_map(x, y, map_random, map_blank)
    end
    draw_map(x, y, map_random, map_blank)
    if turn == "2" and x < (xp1 + 3) and x > (xp1 - 3)  and y < (yp1 + 1) and y > (yp1 - 1) then
      puts "congradulations, P2, you won!!!"
      gameOver = true
    end
    if turn == "1" and x < (xp2 + 3) and x > (xp2 - 3) and y < (yp2 + 1) and y > (yp2 - 1) then
      puts "congradulations, P1, you won!!!"
      gameOver = true
    end
  end
  print "\a" #play sound
end
