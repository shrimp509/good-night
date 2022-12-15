class SleepCalculator

  def initialize(clock_ins)
    @clock_ins = clock_ins.order(created_at: :desc)
  end

  def start
    clock_ins = filter_noises(@clock_ins)
    total_sleep_times = 0
    clock_ins.each_with_index do |clock_in, index|
      if !clock_in.sleep && clock_ins[index+1]&.sleep
        total_sleep_times += clock_in.created_at - clock_ins[index+1].created_at
      end
    end
    seconds_to_hours(total_sleep_times)
  end

  private
  
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
    clock_ins.map.with_index do |clock_in, index|
      next if index == 0
      if clock_in.sleep == prev
        deleted_index = prev ? index : index-1
        clock_ins[deleted_index] = nil
      end
      prev = clock_in.sleep
    end
    clock_ins.compact
  end

  def seconds_to_hours(sec)
    sec.to_f / 3600
  end
end