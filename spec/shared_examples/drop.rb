RSpec.shared_examples 'drop' do |method, variable, expected_param|
  let(:template) do
    variable ||= described_class.name.demodulize.chomp('Drop').downcase
    "{{ #{variable}.#{method} }}"
  end

  it "returns correct #{method}" do
    if expected_param.present?
      expect(subject).to eq(expected_param)
    else
      expect(subject).to eq(expected)
    end
  end
end
