require 'rails_helper'

RSpec.describe Reading, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end
  describe 'validations' do
    it { should validate_presence_of(:level) }
    it { should validate_numericality_of(:level).only_integer }

    let(:user) { create(:user) }
    context 'when level count is greater than 2 digit' do
      it 'validates false' do
        reading = user.readings.create(level: 10)
        expect(reading.valid?).to eq(false)
        expect(reading.full_error_message).to eq('Level is too long (maximum is 1 character)')
      end
    end
    context 'when level count is less than 4 records per day' do
      it 'validates level true' do
        reading = create(:reading)
        expect(reading.valid?).to eq(true)
      end
    end
    context 'when level count is more than 4 records per day' do
      it 'validates level false' do
        4.times { user.readings.create(level: 4) }
        reading = user.readings.create(level: 9)
        expect(reading.valid?).to eq(false)
        expect(reading.full_error_message).to eq('Level can only be store 4 times per day')
      end
    end
  end
end
