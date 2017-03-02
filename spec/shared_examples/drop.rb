RSpec.shared_examples 'drop' do |method|
  let(:template) { "{{ #{variable_name}.#{method} }}" }
  it "returns #{variable_name}.#{method}" do
    expect(subject).to eq(expected)
  end
end

def variable_name
  described_class.name.demodulize.chomp('Drop').downcase
end
