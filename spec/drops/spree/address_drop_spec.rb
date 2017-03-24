module Spree
  RSpec.describe AddressDrop do
    let(:address_attributes) do
      {
        id: 5,
        first_name: 'Arthur',
        last_name: 'Dent',
        address1: '155',
        address2: 'Country Lane',
        company: 'Vogons',
        city: 'Cottington',
        state_name: 'Córdoba',
        state_code: 'X',
        zipcode: '21000',
        country: 'Argentina',
        country_code: 'AR',
        phone: '+66983824021'
      }
    end

    let(:address) do
      address = build(:address, address_attributes)
      address.users << build(:user)
      address.user_addresses.first.default = true
      # no idea why state_code can't be set on `build`
      address.state_code = address_attributes[:state_code]
      address
    end
    let(:assigns) { { 'address' => address } }
    let(:strict) { true }

    subject { render_liquid(template, assigns, strict) }

    it_behaves_like 'drop for nil', 'address', AddressFields::METHODS

    describe 'json' do
      let(:template) { '{{ address | json }}' }

      it 'renders correct json attributes' do
        result_map = JSON.parse(subject)
        result_map.transform_values!(&:to_s)

        expect(result_map['id']).to eq('5')
        expect(result_map['address1']).to eq('155')
        expect(result_map['address2']).to eq('Country Lane')
        expect(result_map['city']).to eq('Cottington')
        expect(result_map['company']).to eq('Vogons')
        expect(result_map['country']).to eq('Argentina')
        expect(result_map['country_code']).to eq('AR')
        expect(result_map['country_name']).to eq('Argentina')
        expect(result_map['default']).to eq('true')
        expect(result_map['first_name']).to eq('Arthur')
        expect(result_map['last_name']).to eq('Dent')
        expect(result_map['name']).to eq('Arthur Dent')
        expect(result_map['phone']).to eq('+66983824021')
        expect(result_map['province']).to eq('Córdoba')
        expect(result_map['province_code']).to eq('X')
        expect(result_map['zip']).to eq('21000')
      end

      it 'renders all json attributes' do
        result_map = JSON.parse(subject)

        expect(result_map.keys).to eq(AddressFields::JSON)
      end

      it 'does not render any additional attributes' do
        result_map = JSON.parse(subject)

        expect(result_map.keys - AddressFields::JSON).to be_empty
      end
    end

    describe 'methods' do
      it_behaves_like('drop', 'id') { let(:expected) { '5' } }
      it_behaves_like('drop', 'address1') { let(:expected) { '155' } }
      it_behaves_like('drop', 'address2') { let(:expected) { 'Country Lane' } }
      it_behaves_like('drop', 'city') { let(:expected) { 'Cottington' } }
      it_behaves_like('drop', 'company') { let(:expected) { 'Vogons' } }
      it_behaves_like('drop', 'country') { let(:expected) { 'Argentina' } }
      it_behaves_like('drop', 'country_code') { let(:expected) { 'AR' } }
      it_behaves_like('drop', 'default') { let(:expected) { 'true' } }
      it_behaves_like('drop', 'first_name') { let(:expected) { 'Arthur' } }
      it_behaves_like('drop', 'last_name') { let(:expected) { 'Dent' } }
      it_behaves_like('drop', 'latitude') { let(:expected) { '' } }
      it 'Not MVP: latitude'
      it_behaves_like('drop', 'longitude') { let(:expected) { '' } }
      it 'Not MVP: longitude'
      it_behaves_like('drop', 'name') { let(:expected) { 'Arthur Dent' } }
      it_behaves_like('drop', 'phone') { let(:expected) { '+66983824021' } }
      it_behaves_like('drop', 'province') { let(:expected) { 'Córdoba' } }
      it_behaves_like('drop', 'province_code') { let(:expected) { 'X' } }
      it_behaves_like('drop', 'street') do
        let(:expected) { '155, Country Lane' }
      end
      it_behaves_like('drop', 'zip') { let(:expected) { '21000' } }
    end
  end
end
