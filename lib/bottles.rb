class Bottles
  def initialize
  end

  def verses(t, b=nil)
    arr = b ? (b..t).to_a.reverse : [t]
    arr.map { |e| COMPOSER.(DISPATCHER).(e) }.join("\n")
  end

  def verse(t)
    verses(t)
  end

  def song
    verses(99, 0)
  end

  private

  MAX = 99

  DISPATCHER = -> place {
    case place
    when "head"
      -> n {
        case n
        when 0
          "No more bottles "
        when 1
          "1 bottle "
        else
          "#{n} bottles "
        end
      }
    when "second_head"
      -> n {
        case n
        when 0
          "Go to the store and buy some more"
        when 1
          "Take it down and pass it around"
        else
          "Take one down and pass it around"
        end
      }
    when "tail"
      -> n {
        DISPATCHER["head"][n].downcase
      }
    end
  }

  COMPOSER = -> d {
    -> n {
      m = (n > 0) ? (n - 1) : MAX
      d["head"][n] + "of beer on the wall, " + 
      d["tail"][n] + "of beer." + "\n" +
      d["second_head"][n] + ", " +
      d["tail"][m] + "of beer on the wall." + "\n"
    }
  }
end

