require "ruby2d"

BLACK_TILE_COLOR = "#1375d1"
WHITE_TILE_COLOR = "#b8dcff"
SQUARE_SIZE = 80

set title: "uwindow"
set background: "white"
set height: 640
set width: 640
set resizable: false
set diagnostics: true

tick = 0

def swap_colors(color)
  if color == BLACK_TILE_COLOR
    WHITE_TILE_COLOR
  else
    BLACK_TILE_COLOR
  end
end

def generate_board(current_color)
  pos_x = 0
  pos_y = 0
  size = SQUARE_SIZE

  64.times do
    Square.new(
      x: pos_x,
      y: pos_y,
      size: size,
      color: current_color
    )
    
    pos_x += size
    
    if pos_x % 640 == 0
      pos_y += size
      pos_x = 0
    else
      current_color = swap_colors(current_color)
    end
  end
end

generate_board(BLACK_TILE_COLOR)

def generate_indicator
  indicator_lines = []

  line_bottom = Line.new(
    x1: 400, y1: 315,
    x2: 480, y2: 315,
    width: 10,
    color: 'red',
  )

  line_left = Line.new(
    x1: 405, y1: 320,
    x2: 405, y2: 240,
    width: 10,
    color: "red"
  )

  line_right = Line.new(
    x1: 475, y1: 320,
    x2: 475, y2: 240,
    width: 10,
    color: "red"
  )

  line_top = Line.new(
    x1: 400, y1: 245,
    x2: 480, y2: 245,
    width: 10,
    color: "red"
  )

  indicator_lines << line_bottom
  indicator_lines << line_left
  indicator_lines << line_right
  indicator_lines << line_top

  indicator_lines
end

$indicator = generate_indicator

def move_indicator(direction)
  case direction
  when "up"
    $indicator.each do |line|
      line.y1 -= 80
      line.y2 -= 80
    end
  when "down"
    $indicator.each do |line|
      line.y1 += 80
      line.y2 += 80
    end
  when "left"
    $indicator.each do |line|
      line.x1 -= 80
      line.x2 -= 80
    end
  when "right"
    $indicator.each do |line|
      line.x1 += 80
      line.x2 += 80
    end
  end
end

on :key_down do |event|
  case event.key
  when "up", "w"
    move_indicator("up")
  when "down", "s"
    move_indicator("down")
  when "left", "a"
    move_indicator("left")
  when "right", "d"
    move_indicator("right")
  end
end

show