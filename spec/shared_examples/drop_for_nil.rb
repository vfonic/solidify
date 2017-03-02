RSpec.shared_examples 'drop for nil' do |variable_name, methods|
  context 'variable_name is nil' do
    let(:assigns) { { variable_name => nil } }
    let(:strict) { false }

    describe 'json' do
      let(:template) { '{{ variable_name | json }}' }

      it 'returns null' do
        expect(subject).to eq('null')
      end
    end

    describe 'methods' do
      methods.each do |method|
        describe "##{method}" do
          let(:template) { "{{ variable_name.#{method} }}" }

          it 'returns empty string' do
            expect(subject).to eq('')
          end
        end
      end
    end
  end
end
