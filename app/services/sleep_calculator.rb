class SleepCalculator

  def initialize(clock_ins)
    @clock_ins = clock_ins.order(created_at: :desc)
  end

  def start
    clock_ins = filter_noises(@clock_ins)
    total_sleep_times = 0
    clock_ins.each_with_index do |clock_in, index|
      if !clock_in.sleep && clock_ins[index+1].sleep
        total_sleep_times += clock_in.created_at - clock_ins[index+1].created_at
      end
    end
    total_sleep_times
  end

  # private
  
  def filter_noises(clock_ins)
    remove_duplicate(
      remove_not_yet_over(clock_ins)
    )
  end

  def remove_not_yet_over(clock_ins)
    break_index = 0
    clock_ins.each_with_index do |clock_in, index|
      unless clock_in.sleep
        break_index = index
        break
      end
    end
    clock_ins[break_index..]
  end

  def remove_duplicate(clock_ins)
    prev = clock_ins.first.sleep
    clock_ins[1..].map.with_index do |clock_in, index|
      if clock_in.sleep == prev
        if prev
          clock_ins.delete(index-1)
        else
          clock_ins.delete(index)
        end
      end
      prev = clock_in.sleep
    end
    clock_ins
  end
end