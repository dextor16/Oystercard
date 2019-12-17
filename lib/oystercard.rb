class Oystercard

    attr_reader :balance

    DEFAULT_BALANCE = 0
    MAXIMUM_BALANCE = 90
    MINIMUM_BALANCE = 1
    MIN_CHARGE = 2

    def initialize
        @balance = DEFAULT_BALANCE
    end

    # def balance
    #     @balance
    # end

    def top_up(value)
        raise "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if @balance + value > MAXIMUM_BALANCE
        @balance = @balance + value
    end

    def in_journey?
        @in_journey
    end

    def touch_in
        raise "Minimum balance of #{MINIMUM_BALANCE} required" if @balance < MINIMUM_BALANCE
        @in_journey = true
    end

    def touch_out
        deduct(MIN_CHARGE)
        @in_journey = false
    end

    private

    def deduct(value)
        @balance -= value
    end
end