# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Validators::NumberValidator do
  let(:dummy_class) do
    Class.new do
      include Validators::NumberValidator
    end.new
  end

  describe '.integer?' do
    context 'when str is non negative integer' do
      it 'returns true' do
        expect(dummy_class.integer?('0')).to be_truthy
      end
    end

    context 'when str is negative integer' do
      it 'returns true' do
        expect(dummy_class.integer?('-1')).to be_truthy
      end
    end

    context 'when str is not integer' do
      it 'returns false' do
        expect(dummy_class.integer?('a')).to be_falsey
      end
    end
  end
end
