module Spree
  RSpec.describe UserDrop do
    let(:user_attributes) do
      {
        id: 15,
        email: 'arthur.dent@example.com',
        first_name: 'Arthur',
        last_name: 'Dent'
      }
    end

    let(:user) { build(:user, user_attributes) }
    let(:assigns) { { 'customer' => user } }
    let(:strict) { true }

    subject { render_liquid(template, assigns, strict) }

    it_behaves_like 'drop for nil', 'customer', UserFields::METHODS

    describe 'json' do
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
      it 'Not MVP: accepts_marketing'

      context 'addresses' do
        it_behaves_like('drop', 'addresses', 'customer') do
          before(:each) do
            user.addresses << build(:address)
            user.addresses << build(:address)
          end

          let(:expected) { 'AddressDrop' * 2 }
        end

        it_behaves_like('drop', 'addresses_count', 'customer') do
          let(:user) { build(:user, addresses: [build(:address)]) }

          let(:expected) { '1' }
        end

        it_behaves_like('drop', 'default_address', 'customer') do
          before(:each) do
            user.save
            user.default_address = create(:address)
          end

          let(:expected) { 'AddressDrop' }
        end
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
      it 'Not MVP: has_account'
      it_behaves_like('drop', 'last_name', 'customer') do
        let(:expected) { 'Dent' }
      end
      it_behaves_like('drop', 'name', 'customer') do
        let(:expected) { 'Arthur Dent' }
      end

      describe '#last_order' do
        context 'with orders' do
          let(:template) { '{{ customer.last_order.order_number }}' }
          it 'returns last_order' do
            user.orders << build(:order, state: OrderState::COMPLETE,
                                         completed_at: 1.week.ago)
            expected = 1.minute.ago
            order = create(:order, state: OrderState::COMPLETE,
                                   completed_at: expected)
            user.orders << order
            user.save

            expect(subject).to eq(order.number)
          end
        end

        context 'without orders' do
          it_behaves_like('drop', 'last_order', 'customer') do
            let(:expected) { '' }
          end
        end
      end

      describe '#orders' do
        it 'Implemented partially: Add specs for other order states'
        it_behaves_like('drop', 'orders', 'customer') do
          let(:user) do
            create(:user, orders: [
                     build(:order, state: OrderState::COMPLETE),
                     build(:order, state: OrderState::COMPLETE),
                     build(:order, state: OrderState::CART)
                   ])
          end

          let(:expected) { 'OrderDrop' * 2 }
        end
        it_behaves_like('drop', 'orders_count', 'customer') do
          let(:user) do
            create(:user, orders: [build(:order, state: OrderState::COMPLETE)])
          end

          let(:expected) { '1' }
        end

        context 'for cart order' do
          it_behaves_like('drop', 'orders_count', 'customer') do
            let(:user) do
              build(:user, orders: [build(:order, state: OrderState::CART)])
            end

            let(:expected) { '0' }
          end
        end
      end

      it_behaves_like('drop', 'tags', 'customer') { let(:expected) { '' } }
      it_behaves_like('drop', 'total_spent', 'customer') do
        let(:expected) { '0' }
      end
    end
  end
end
