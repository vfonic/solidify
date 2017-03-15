FactoryGirl.define do
  factory :solidify_page, class: 'Solidify::Page' do
    author 'MyString'
    title 'MyString'
    handle 'MyString'
    body_html 'MyText'
    published_at '2017-02-09 12:52:57'
    template_suffix 'MyString'
  end
end
