class Oystercard
  attr_reader :balance,:journeys, :entry_station, :exit_station

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_CHARGE = 2

  def initialize
    @balance = DEFAULT_BALANCE
    @entry_station
    @exit_station
    @journeys = []

  end

  def top_up(value)
    raise "Max balance of #{MAX_BALANCE}" if @balance + value > MAX_BALANCE

    @balance += value
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    raise "Minimum balance of #{MIN_BALANCE} required" if @balance < MIN_BALANCE

    @entry_station = station
    @in_journey = true
  end

  def touch_out(station)
    deduct(MIN_CHARGE)
    @exit_station = station
    store_journey
    @entry_station = nil
  end

  private

  def deduct(value)
    @balance -= value
  end

  def store_journey
    journey = {@entry_station => @exit_station}
    @journeys <<journey
  end
end

