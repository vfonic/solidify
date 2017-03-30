module Spree
  RSpec.describe OrderDrop do
    subject { render_liquid(template, assigns, strict) }

    let(:variant1) { create(:variant, price: 9.00) }
    let(:variant2) { create(:variant, price: 1.25) }
    let(:order) do
      build(:order,
            email: 'viktor.fonic@gmail.com',
            billing_address: build(:address),
            shipping_address: build(:address),
            line_items: [
              build(:line_item, variant: variant1),
              build(:line_item, variant: variant2)
            ],
            special_instructions: 'Please bring in one piece')
    end

    let(:assigns) { { 'order' => order } }
    let(:strict) { true }

    it_behaves_like 'drop for nil', 'order', OrderFields::METHODS

    describe 'json' do
      let(:template) { '{{ order | json }}' }

      it 'renders json not allowed for this object' do
        expected = { "error": 'json not allowed for this object' }.to_json

        expect(subject).to eq(expected)
      end
    end

    describe 'methods' do
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
              .to be_within(1.second).of(Time.now.utc)
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
            .to be_within(1.second).of(Time.now.utc)
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
