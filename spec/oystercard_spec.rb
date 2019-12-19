require 'oystercard'

describe Oystercard do

  let(:entry_station){ double :station }
  let(:exit_station){ double :station }

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
      expect { subject.touch_in(entry_station) }.to raise_error message
    end
  end

  describe '#touch' do
    it 'starts not in a journey' do
      expect(subject).not_to be_in_journey
    end

    # it 'should touch in' do
    #   subject.top_up(10)
    #   subject.touch_in(entry_station)
    #   expect(subject).to be_in_journey
    # end

    it 'should store entry station' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq(entry_station)
    end

    it 'should touch out' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-Oystercard::MIN_CHARGE)
    end

    it 'should forget entry station' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.entry_station).to eq nil
    end

    it 'should store exit station' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq(exit_station)
    end
  end

  describe '#journeys' do

  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

    it 'should show journey list is empty' do
      expect(subject.journeys).to be_empty
    end

    it 'stores 1 complete journey' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journeys).to include {journey}
    end
  end
end
