FactoryGirl.define do
  factory :solidus_liquid_page, class: 'SolidusLiquid::Page' do
    author "MyString"
    title "MyString"
    handle "MyString"
    body_html "MyText"
    published_at "2017-02-09 12:52:57"
    template_suffix "MyString"
  end
end
