require 'rails_helper'
require 'bigdecimal'
require 'bigdecimal/util'

RSpec.describe Fibonacci, type: :model do
  describe 'validations' do
    subject { build(:fibonacci) }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a position' do
      subject.position = nil
      aggregate_failures do
        expect(subject).to_not be_valid
        expect(subject.errors[:position]).to include("can't be blank")
      end
    end

    it 'is not valid without a non-integer position' do
      subject.position = "a"
      aggregate_failures do
        expect(subject).to_not be_valid
        expect(subject.errors[:position]).to include("is not a number")
      end
    end

    it 'is not valid without a negative position' do
      subject.position = -1
      aggregate_failures do
        expect(subject).to_not be_valid
        expect(subject.errors[:position]).to include("must be greater than or equal to 0")
      end
    end

    it 'is not valid with a duplicate position' do
      create(:fibonacci, position: subject.position)
      aggregate_failures do
        expect(subject).to_not be_valid
        expect(subject.errors[:position]).to include("has already been taken")
      end
    end

    it 'is not valid without a value' do
      subject.value = nil
      aggregate_failures do
        expect(subject).to_not be_valid
        expect(subject.errors[:value]).to include("can't be blank")
      end
    end

    it 'is not valid with a non integer value' do
      subject.value = "a"
      aggregate_failures do
        expect(subject).to_not be_valid
        expect(subject.errors[:value]).to include("must be a non negative integer")
      end
    end
  end

  describe '.value' do
    context 'when the position already exists' do
      let(:fibonacci) { create(:fibonacci, position: 0, value: "1")}

      it 'calls find_by and return the value' do
        aggregate_failures do
          expect(described_class).to receive(:find_by).with(position: 0)
          expect(described_class.value(position: 0)).to eq BigDecimal("1")
        end
      end
    end

    context 'when the position does not exist' do
      context 'and is 0' do
        before do
          allow(described_class).to receive(:generate).with(position: 0, value: BigDecimal("1")).and_return(BigDecimal("1"))
        end

        it 'calls generate and return 1' do
          aggregate_failures do
            expect(described_class).to receive(:generate).with(position: 0, value: BigDecimal("1"))
            expect(described_class.value(position: 0)).to eq BigDecimal("1")
          end
        end
      end

      context 'when the position is 1' do
        before do
          allow(described_class).to receive(:generate).with(position: 1, value: BigDecimal("1")).and_return(BigDecimal("1"))
        end

        it 'calls generate and return 1' do
          aggregate_failures do
            expect(described_class).to receive(:generate).with(position: 1, value: BigDecimal("1"))
            expect(described_class.value(position: 1)).to eq BigDecimal("1")
          end
        end
      end

      context 'when the position is over 1' do
        it 'return the valid fibonacci number' do
          expect(described_class.value(position: 98)).to eq 218922995834555169026
        end
      end

      context 'when the position is negative number' do
        it 'raise an error' do
          expect { described_class.value(position: -1) }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end
  end

  describe '.generate' do
    context 'when the arrtibutes are invalid' do
      it 'raise an error' do
        expect { described_class.generate(position: nil, value: nil) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when the attributes are valid' do
      it 'create new fibonacci' do
        expect { described_class.generate(position: 0, value: BigDecimal("1")) }.to change{ Fibonacci.count }.by(1)
      end

      it 'return the value' do
        expect(described_class.generate(position: 0, value: BigDecimal("1"))).to eq 1
      end
    end
  end
end
