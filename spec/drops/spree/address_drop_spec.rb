require 'rails_helper'

module Spree
  RSpec.describe AddressDrop do
    let(:assigns) { { 'address' => address } }
    let(:strict) { true }

    subject { render_liquid(template, assigns, strict) }

    describe 'json' do
      let(:template) { '{{ address | json }}' }

      address_json_attributes = %w(
        id address1 address2 city company country country_code default
        first_name last_name latitude longitude name phone province
        province_code street zip
      )

      context 'Address is nil' do
        let(:address) { nil }

        it 'returns null' do
          rendered_json = subject

          expect(rendered_json).to eq('null')
        end
      end

      context 'Address is set' do
        let(:address) { create(:address) }

        it 'renders all json attributes' do
          address_drop = AddressDrop.new(address)

          result_map = JSON.parse(subject)

          address_json_attributes.each do |attribute|
            expect(result_map[attribute]).to eq(address_drop[attribute])
          end
        end

        it 'does not render any additional attributes' do
          result_map = JSON.parse(subject)

          expect(result_map.keys - address_json_attributes).to be_empty
        end
      end
    end

    describe '#id' do
      let(:template) { '{{ address.id }}' }

      context 'Address is nil' do
        let(:address) { nil }
        let(:strict) { false }

        it 'returns empty string' do
          result = subject

          expect(result).to be_empty
        end
      end

      context 'Address is set' do
        let(:address) { create(:address) }

        it 'returns the address id' do
          result = subject

          expect(result).to eq(address.id.to_s)
        end
      end
    end
  end
end
