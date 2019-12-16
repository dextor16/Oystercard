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

    it 'should deduct balance' do
        card = Oystercard.new
        card.top_up(20)
        card.deduct(10)
        expect(card.balance).to eq (10)
    end

    it 'should show error if balance is more than £90' do
        maximum_balance = (Oystercard::MAXIMUM_BALANCE)
        subject.top_up(maximum_balance)
        expect{ subject.top_up (1) }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end



    
end
