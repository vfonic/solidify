module Spree
  RSpec.describe OrderDrop do
    subject { render_liquid(template, assigns, strict) }

    let(:assigns) { { 'order' => order } }
    let(:strict) { true }

    it_behaves_like 'drop for nil', 'order', OrderFields::METHODS

    describe 'json' do
      let(:template) { '{{ order | json }}' }
      let(:order) do
        create(:order_with_line_items,
               line_items_count: 2,
               line_items_price: 9.99, special_instructions: 'Order note')
      end

      it 'renders correct json attributes' do
        result_map = JSON.parse(subject)
        result_map.transform_values!(&:to_s)

        expect(result_map['item_count']).to eq('2')
        expect(result_map['items']).to eq(order.line_items.as_json.to_s)
        expect(result_map['note']).to eq('Order note')
        expect(result_map['original_total_price']).to eq((999 * 2).to_s)
        expect(result_map['requires_shipping']).to eq('true')
        expect(result_map['total_discount']).to eq('0')
        expect(result_map['total_price']).to eq((999 * 2).to_s)
        expect(result_map['total_weight']).to eq('0')
      end

      it 'renders all json attributes' do
        result_map = JSON.parse(subject)

        expect(result_map.keys).to eq(OrderFields::JSON)
      end

      context '#attributes' do
        it 'outputs "attributes" attribute'
      end
    end

    describe 'methods' do
      let(:variant1) { build(:variant, price: 9.00) }
      let(:variant2) { build(:variant, price: 1.25) }
      let(:line_item1) { build(:line_item, variant: variant1) }
      let(:line_item2) { build(:line_item, variant: variant2) }
      let(:order) do
        build(:order,
              id: 8,
              email: 'viktor.fonic@gmail.com',
              billing_address: build(:address),
              shipping_address: build(:address),
              line_items: [line_item1, line_item2],
              special_instructions: 'Please bring in one piece')
      end

      it_behaves_like('drop', 'billing_address') do
        let(:expected) { 'AddressDrop' }
      end

      describe '#cancelled' do
        context 'order cancelled' do
          before(:each) { order.state = :canceled }

          it_behaves_like('drop', 'cancelled') { let(:expected) { 'true' } }
        end
        context 'order not cancelled' do
          it_behaves_like('drop', 'cancelled') { let(:expected) { 'false' } }
        end
      end

      describe '#cancelled_at' do
        context 'order cancelled' do
          let(:template) { '{{ order.cancelled_at }}' }
          let(:order) { create(:completed_order_with_totals) }

          before(:each) { order.canceled_by(build(:user)) }

          it 'behaves like drop for cancelled_at' do
            expect(Time.zone.parse(subject))
              .to be_within(2.seconds).of(Time.now.utc)
          end
        end
        context 'order not cancelled' do
          it_behaves_like('drop', 'cancelled_at') { let(:expected) { '' } }
        end
      end

      it 'Not MVP: cancel_reason'
      it 'Not MVP: cancel_reason_label'

      describe '#created_at' do
        let(:template) { '{{ order.created_at }}' }
        let(:order) { create(:order) }

        it 'behaves like drop for created_at' do
          expect(Time.zone.parse(subject))
            .to be_within(2.seconds).of(Time.now.utc)
        end
      end

      it 'Not MVP: customer'

      it 'Not MVP: discounts'

      it_behaves_like('drop', 'email') do
        let(:expected) { 'viktor.fonic@gmail.com' }
      end

      it 'Not MVP: financial_status'
      it 'Not MVP: financial_status_label'
      it 'Not MVP: fulfillment_status'
      it 'Not MVP: fulfillment_status_label'

      it_behaves_like('drop', 'line_items') do
        let(:expected) { 'LineItemDrop' * 2 }
      end

      it 'Not MVP: location'

      describe '#name' do
        let(:template) { '{{ order.name }}' }

        it 'behaves like drop for name' do
          order.save

          expect(subject).to match(/^R[0-9]{9}$/)
        end
      end
      it_behaves_like('drop', 'note') do
        let(:expected) { 'Please bring in one piece' }
      end
      describe '#order_number' do
        let(:template) { '{{ order.order_number }}' }

        it 'behaves like drop for order_number' do
          order.save

          expect(subject).to match(/^R[0-9]{9}$/)
        end
      end
      it_behaves_like('drop', 'shipping_address') do
        let(:expected) { 'AddressDrop' }
      end

      it 'Not MVP: shipping_methods'
      it 'Not MVP: shipping_price'
      it 'Not MVP: tax_price'

      it 'Not MVP: transactions'
      it 'Not MVP: tags'
    end
  end
end
