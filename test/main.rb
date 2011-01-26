require 'timer'
require 'all_down'

timer = Timer.new
down = new Down
down.all_script_down(timer.month, timer.date)