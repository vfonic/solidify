module SolidusLiquid
  RSpec.describe 'MathFilters', type: :helper do
    subject { render_liquid(template, assigns, strict) }

    let(:assigns) { Hash.new }
    let(:strict) { true }

    describe '#abs' do
      it_behaves_like 'filter', '17', 'abs', nil, '17'
      it_behaves_like 'filter', '-17', 'abs', nil, '17'
      it_behaves_like 'filter', '"17"', 'abs', nil, '17'
      it_behaves_like 'filter', '"-17"', 'abs', nil, '17'
      it_behaves_like 'filter', '0', 'abs', nil, '0'
      it_behaves_like 'filter', '"0"', 'abs', nil, '0'
      it_behaves_like 'filter', '17.42', 'abs', nil, '17.42'
      it_behaves_like 'filter', '-17.42', 'abs', nil, '17.42'
      it_behaves_like 'filter', '"17.42"', 'abs', nil, '17.42'
      it_behaves_like 'filter', '"-17.42"', 'abs', nil, '17.42'
    end

    describe '#ceil' do
      it_behaves_like 'filter', '4.6', 'ceil', nil, '5'
      it_behaves_like 'filter', '4.3', 'ceil', nil, '5'
    end

    describe '#divided_by' do
      it_behaves_like 'filter', '12', 'divided_by', '3', '4'
      it_behaves_like 'filter', '14', 'divided_by', '3', '4'
      it_behaves_like 'filter', '15', 'divided_by', '3', '5'

      context 'divided by zero' do
        let(:template) { '{{ 1667 | divided_by: 0 }}' }

        context 'strict mode' do
          let(:strict) { true }

          it 'raises error' do
            expect { subject }.to raise_error ::Liquid::ZeroDivisionError
          end
        end

        context 'lax mode' do
          let(:strict) { false }

          it 'outputs the error' do
            expect(subject).to eq('Liquid error: divided by 0')
          end
        end
      end

      it_behaves_like 'filter', '2.0', 'divided_by', '4', '0.5'
    end

    describe '#floor' do
      it_behaves_like 'filter', '4.6', 'floor', nil, '4'
      it_behaves_like 'filter', '4.3', 'floor', nil, '4'
    end

    describe '#minus' do
      it_behaves_like 'filter', '5', 'minus', '1', '4'
      it_behaves_like 'filter', '4.3', 'minus', '2', '2.3'
    end

    describe '#plus' do
      it_behaves_like 'filter', '2', 'plus', '1', '3'
      it_behaves_like 'filter', '2.3', 'plus', '2', '4.3'
    end

    describe '#round' do
      it_behaves_like 'filter', '4.6', 'round', nil, '5'
      it_behaves_like 'filter', '4.3', 'round', nil, '4'
      it_behaves_like 'filter', '4.5612', 'round', '2', '4.56'
      it_behaves_like 'filter', '4.5662', 'round', '2', '4.57'
    end

    describe '#times' do
      it_behaves_like 'filter', '3', 'times', '4', '12'
      it_behaves_like 'filter', '"foo"', 'times', '4', '0'
      it_behaves_like 'filter', '0.0725', 'times', '100', '7.25'
      it_behaves_like 'filter', '-0.0725', 'times', '100', '-7.25'
      it_behaves_like 'filter', '-0.0725', 'times', '-100', '7.25'
    end

    describe '#modulo' do
      it_behaves_like 'filter', '3', 'modulo', '2', '1'
      it_behaves_like 'filter', '4', 'modulo', '2', '0'
    end
  end
end
