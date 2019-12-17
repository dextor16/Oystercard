require 'oystercard'

describe Oystercard do
    it 'should show default balance of 0' do
        expect(subject.balance).to eq (0)
    end

    it 'should top up balance' do
        card = Oystercard.new
        card.top_up(30)
        expect(card.balance).to eq (30)
    end

    # it 'should deduct balance' do
    #     card = Oystercard.new
    #     card.top_up(20)
    #     card.deduct(10)
    #     expect(card.balance).to eq (10)
    # end

    it 'should show error if balance is more than £90' do
        maximum_balance = (Oystercard::MAXIMUM_BALANCE)
        subject.top_up(maximum_balance)
        expect{ subject.top_up (1) }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end

    # it 'should respond to touch in' do
    #     expect(subject).to respond_to(:touch_in)
    # end

    it 'starts not in a journey' do
        expect(subject).not_to be_in_journey
    end

    it "should touch in" do
        subject.top_up(1)
        subject.touch_in
        expect(subject).to be_in_journey
      end

    describe '#touch_out' do
    
      it 'should touch out' do
        subject.top_up(10)
        subject.touch_in
        expect{ subject.touch_out }.to change{ subject.balance }.by(-Oystercard::MIN_CHARGE)
        end
    end

    it 'should show error if balance is less than £1' do
        minimum_balance = (Oystercard::MINIMUM_BALANCE)
        expect{ subject.touch_in }.to raise_error "Minimum balance of #{minimum_balance} required"
    end
end
