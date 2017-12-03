class Spiral
  def initialize(max)
    @grid = Hash.new(0)
    @max = max
  end

  def calculate
    n = 1
    width = 0

    @grid[[0,0]] = 1

    loop do
      width += 1

      (-width + 1).upto(width) do |y|
        fill(width,y)
      end
      width.downto(-width) do |x|
        fill(x,width)
      end
      width.downto(-width) do |y|
        fill(-width,y)
      end
      (-width).upto(width) do |x|
        fill(x,-width)
      end

      break if @grid.values.any?{ |x| x > @max }
    end

    @grid.values.select{ |x| x > @max }.min
  end

  def fill(x,y)
    @grid[[x,y]] =
      @grid[[x,y-1]] +
      @grid[[x,y+1]] +
      @grid[[x-1,y]] +
      @grid[[x+1,y]] +
      @grid[[x-1,y-1]] +
      @grid[[x-1,y+1]] +
      @grid[[x+1,y-1]] +
      @grid[[x+1,y+1]]
  end
end

spiral = Spiral.new(312051)
p spiral.calculate
