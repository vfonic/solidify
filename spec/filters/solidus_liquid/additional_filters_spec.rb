module SolidusLiquid
  RSpec.describe AdditionalFilters, type: :helper do
    subject { render_liquid(template, assigns, strict) }
    let(:assigns) { Hash.new }
    let(:strict) { true }

    describe '#date' do
      context 'date passed as a string' do
        it_behaves_like('filter', "'#{Time.zone.parse('2006-05-05 10:00:00')}'",
                        'date', "'%B'", 'May')
        it_behaves_like('filter', "'#{Time.zone.parse('2006-06-05 10:00:00')}'",
                        'date', "'%B'", 'June')
        it_behaves_like('filter', "'#{Time.zone.parse('2006-07-05 10:00:00')}'",
                        'date', "'%B'", 'July')
      end

      context 'format empty string or nil' do
        it_behaves_like('filter', "'2006-07-05 10:00:00'", 'date: ""',
                        nil, '2006-07-05 10:00:00')
        it_behaves_like('filter', "'2006-07-05 10:00:00'", 'date: nil',
                        nil, '2006-07-05 10:00:00')
      end

      it_behaves_like('filter', "'2006-07-05 10:00:00'",
                      'date', "'%m/%d/%Y'", '07/05/2006')

      it_behaves_like('filter', "'Fri Jul 16 01:00:00 2004'",
                      'date', "'%m/%d/%Y'", '07/16/2004')
      it_behaves_like('filter', "'now'",
                      'date', "'%Y'", Time.zone.today.year.to_s)
      it_behaves_like('filter', "'today'",
                      'date', "'%Y'", Time.zone.today.year.to_s)
      it_behaves_like('filter', "'Today'",
                      'date', "'%Y'", Time.zone.today.year.to_s)

      context 'input date empty string' do
        it_behaves_like('filter', "''", 'date', "'%B'", '')
      end

      context 'input not a valid date' do
        it_behaves_like('filter', "'abc'", 'date', "'%Y'", 'abc')
      end

      context 'date from object' do
        let(:assigns) { { 'product' => create(:base_product) } }
        it_behaves_like('filter', 'product.published_at', 'date',
                        "'%d/%m/%Y'", Time.zone.today.strftime('%d/%m/%Y'))
      end
    end
  end
end
