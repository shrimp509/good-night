require "test_helper"

class SleepCalculatorTest < ActiveSupport::TestCase

  test "total_sleep_times normal case" do
    assert_equal SleepCalculator.new(users(:normal_user).clock_ins).start, 16.5
  end

  test "total_sleep_times some sleep not yet over" do
    assert_equal SleepCalculator.new(users(:sleep_not_yet_over).clock_ins).start, 6.0
  end

  test "total_sleep_times some duplicates clock ins" do
    assert_equal SleepCalculator.new(users(:duplicate_sleep).clock_ins).start, 14.0
  end
end
