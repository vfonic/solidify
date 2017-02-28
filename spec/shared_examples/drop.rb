RSpec.shared_examples 'drop' do |method|
  context "##{method}" do
    let(:template) { "{{ #{variable_name}.#{method} }}" }
    it "returns #{variable_name}.#{method}" do
      # binding.pry
      expect(subject).to eq(expected)
    end
  end
end

def variable_name
  described_class.name.demodulize.chomp('Drop').downcase
end
