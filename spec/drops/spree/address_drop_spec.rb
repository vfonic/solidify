require 'rails_helper'

module Spree
  RSpec.describe AddressDrop do
    let(:assigns) { { 'address' => address } }
    let(:strict) { true }

    subject { render_liquid(template, assigns, strict) }

    describe 'json' do
      let(:address) { create(:address) }
      let(:template) { '{{ address | json }}' }

      address_json_attributes = %w(
        id address1 address2 city company country country_code default
        first_name last_name latitude longitude name phone province
        province_code street zip
      )

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

    describe '#id' do
      let(:address) { create(:address) }
      let(:expected) { address.id.to_s }
      it_behaves_like 'drop', 'id'
    end

    let(:address) { build(:address, last_name: 'Doe') }
    describe '#name' do
      let(:expected) { "#{address.first_name} #{address.last_name}" }
      it_behaves_like 'drop', 'name'
    end

    describe '#first_name' do
      let(:expected) { address.first_name }
      it_behaves_like 'drop', 'first_name'
    end

    describe '#last_name' do
      let(:expected) { address.last_name }
      it_behaves_like 'drop', 'last_name'
    end

    describe '#address1' do
      let(:expected) { address.address1 }
      it_behaves_like 'drop', 'address1'
    end

    describe '#address2' do
      let(:expected) { address.address2 }
      it_behaves_like 'drop', 'address2'
    end

    describe '#street' do
      let(:expected) { "#{address.address1}, #{address.address2}" }
      it_behaves_like 'drop', 'street'
    end

    describe '#company' do
      let(:expected) { address.company }
      it_behaves_like 'drop', 'company'
    end

    describe '#city' do
      let(:expected) { address.city }
      it_behaves_like 'drop', 'city'
    end

    describe '#default' do
      let(:expected) { address.default.to_s }
      it_behaves_like 'drop', 'default'
    end

    describe '#latitude' do
      let(:expected) { '0' }
      it_behaves_like 'drop', 'latitude'
    end

    describe '#longitude' do
      let(:expected) { '0' }
      it_behaves_like 'drop', 'longitude'
    end

    describe '#province' do
      let(:expected) { address.province }
      it_behaves_like 'drop', 'province'
    end

    describe '#province_code' do
      let(:expected) { address.province_code }
      it_behaves_like 'drop', 'province_code'
    end

    describe '#zip' do
      let(:expected) { address.zip }
      it_behaves_like 'drop', 'zip'
    end

    describe '#country' do
      let(:expected) { address.country.name }
      it_behaves_like 'drop', 'country'
    end

    describe '#country_code' do
      let(:expected) { address.country.iso }
      it_behaves_like 'drop', 'country_code'
    end

    describe '#phone' do
      let(:expected) { address.phone }
      it_behaves_like 'drop', 'phone'
    end

    context 'Address is nil' do
      let(:address) { nil }
      let(:strict) { false }

      describe 'json' do
        let(:template) { '{{ address | json }}' }

        it 'returns null' do
          expect(subject).to eq('null')
        end
      end

      methods = %w(
        id name first_name last_name address1 address2 street company city
        default latitude longitude province province_code zip country
        country_code phone
      )

      methods.each do |method|
        describe "##{method}" do
          let(:template) { "{{ address.#{method} }}" }

          it 'returns empty string' do
            expect(subject).to be_empty
          end
        end
      end
    end
  end
end
