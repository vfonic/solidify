RSpec.shared_examples 'drop' do |method, variable|
  let(:template) do
    variable ||= described_class.name.demodulize.chomp('Drop').downcase
    "{{ #{variable}.#{method} }}"
  end

  it "returns correct #{method}" do
    expect(subject).to eq(expected)
  end
end
