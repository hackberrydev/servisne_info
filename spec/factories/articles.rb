FactoryBot.define do
  factory :article do
    sequence(:url) { |n| "example.com/article-#{n}" }
    title { "MyString" }
    content { "MyText" }
  end
end
