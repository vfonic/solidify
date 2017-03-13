RSpec.shared_examples 'filter' do |variable, method, parameter, expected_param|
  let(:template) do
    param = ": #{parameter}" if parameter.present?
    format('{{ %s | %s%s }}', variable, method, param)
  end

  it 'returns correct result' do
    if expected_param.present?
      expect(subject).to eq(expected_param)
    else
      expect(subject).to eq(expected)
    end
  end
end
