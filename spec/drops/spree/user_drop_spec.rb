# require 'rails_helper'

module Spree
  RSpec.describe UserDrop do
    let(:user_attributes) do
      {
        id: 15,
        # accepts_marketing: false,
        # addresses: '',
        # default_address: '',
        email: 'arthur.dent@example.com',
        first_name: 'Arthur',
        # has_account: '',
        last_name: 'Dent',
        # last_order: '',
        # orders: '',
        # tags: '',
        # total_spent: ''
      }
    end

    let(:assigns) { { 'customer' => user } }
    let(:strict) { true }

    subject { render_liquid(template, assigns, strict) }

    it_behaves_like 'drop for nil', 'customer', UserFields::METHODS

    describe 'json' do
      let(:user) { build(:user, user_attributes) }
      let(:template) { '{{ customer | json }}' }

      it 'renders json not allowed for this object' do
        expected = { "error": 'json not allowed for this object' }.to_json
        expect(subject).to eq(expected)
      end
    end

    describe 'methods' do
      let(:user) { build(:user, user_attributes) }

      it_behaves_like('drop', 'id', 'customer') { let(:expected) { '15' } }
      it_behaves_like('drop', 'accepts_marketing', 'customer') do
        let(:expected) { 'false' }
      end
      it_behaves_like('drop', 'addresses_count', 'customer') do
        before(:each) do
          user.addresses << build(:address)
        end

        let(:expected) { '1' }
      end
      it_behaves_like('drop', 'email', 'customer') do
        let(:expected) { 'arthur.dent@example.com' }
      end
      it_behaves_like('drop', 'first_name', 'customer') do
        let(:expected) { 'Arthur' }
      end
      it_behaves_like('drop', 'has_account', 'customer') do
        let(:expected) { 'true' }
      end
      it_behaves_like('drop', 'last_name', 'customer') do
        let(:expected) { 'Dent' }
      end
      it_behaves_like('drop', 'name', 'customer') do
        let(:expected) { 'Arthur Dent' }
      end
      it_behaves_like('drop', 'tags', 'customer') do
        let(:expected) { '' }
      end
    end
  end
end
