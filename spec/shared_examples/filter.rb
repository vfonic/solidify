RSpec.shared_examples 'filter' do |variable, method, parameter|
  let(:template) do
    param = ": #{parameter}" if parameter.present?
    format('{{ %s | %s%s }}', variable, method, param)
  end

  it 'returns correct result' do
    expect(subject).to eq(expected)
  end
end
