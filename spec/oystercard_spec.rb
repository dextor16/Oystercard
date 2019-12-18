require 'oystercard'

describe Oystercard do

  let(:station){ double :station }

  it 'should show default balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe '#balance' do
    it 'should top up balance' do
      card = Oystercard.new
      card.top_up(30)
      expect(card.balance).to eq 30
    end

    it 'should show error if balance is more than £90' do
      max_balance = Oystercard::MAX_BALANCE
      subject.top_up(max_balance)
      expect { subject.top_up 1 }.to raise_error "Max balance of #{max_balance}"
    end

    it 'should show error if balance is less than £1' do
      min_balance = Oystercard::MIN_BALANCE
      message = "Minimum balance of #{min_balance} required"
      expect { subject.touch_in(station) }.to raise_error message
    end
  end

  describe '#touch' do
    it 'starts not in a journey' do
      expect(subject).not_to be_in_journey
    end

    it 'should touch in' do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'should store entry station' do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject.entry_station).to eq(station)
    end

    it 'should touch out' do
      subject.top_up(10)
      subject.touch_in(station)
      expect { subject.touch_out }.to change { subject.balance }.by(-Oystercard::MIN_CHARGE)
    end

    it 'should forget entry station' do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out
      expect(subject.entry_station).to eq nil
    end
  end
end
