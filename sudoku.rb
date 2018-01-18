require_relative "board"

# People write terrible method names in real life.
# On the job, it is your job to figure out how the methods work and then name them better.
# Do this now.


class SudokuGame
  def self.from_file(filename)
    board = Board.from_file(filename)
    self.new(board)
  end

  def initialize(board)
    @board = board
  end

  def retrieve_pos
    p = nil
    board.render
    until p && legal_pos?(p)
      puts "Please enter a position on the board (e.g., '3,4')"
      print "> "

      begin
        p = to_int(gets.chomp)
      rescue
        puts "Invalid position entered (did you use a comma?)"
        puts ""

        p = nil
      end
    end
    p
  end

  def retrieve_value
    v = nil
    until v && legal_v?(v)
      puts "Please enter a value between 1 and 9 (0 to clear the tile)"
      print "> "
      v = to_i(gets.chomp)
    end
    v
  end

  def to_int(string)
    string.split(",").map { |char| Integer(char) }
  end

  def to_i(string)
    Integer(string)
  end

  def pos_val
    pos_to_val(retrieve_pos, retrieve_value)
  end

  def pos_to_val(p, v)
    board[p] = v
  end

  def run
    pos_val until quit?
    puts "Congratulations, you win!"
  end

  def quit?
    board.quit?
  end

  def legal_pos?(pos)
    pos.is_a?(Array) &&
      pos.length == 2 &&
      pos.all? { |x| x.between?(0, board.size - 1) }
  end

  def legal_v?(val)
    val.is_a?(Integer) &&
      val.between?(0, 9)
  end

  private
  attr_reader :board
end


game = SudokuGame.from_file("puzzles/sudoku1.txt")
game.run
