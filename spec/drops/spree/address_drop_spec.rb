require 'rails_helper'

module Spree
  RSpec.describe AddressDrop do
    context 'Address is nil' do
      describe 'json' do
        it 'returns null' do
          rendered_json = render_liquid(
            template: '{{ address | json }}',
            assigns: { 'address' => nil }
          )

          expect(rendered_json).to eq('null')
        end
      end
    end

    context 'Address is set' do
      describe 'json' do
        address_json_attributes = %w(
          id address1 address2 city company country country_code default
          first_name last_name latitude longitude name phone province
          province_code street zip
        )

        it 'renders all json attributes' do
          address = create(:address)
          address_drop = AddressDrop.new(address)

          result_map = JSON.parse(
            render_liquid(
              template: '{{ address | json }}',
              assigns: { 'address' => address }
            )
          )

          address_json_attributes.each do |attribute|
            expect(result_map[attribute]).to eq(address_drop[attribute])
          end
        end

        it 'does not render any additional attributes' do
          address = create(:address)

          result_map = JSON.parse(
            render_liquid(
              template: '{{ address | json }}',
              assigns: { 'address' => address }
            )
          )

          expect(result_map.keys - address_json_attributes).to be_empty
        end
      end
    end
  end
end
