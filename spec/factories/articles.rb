FactoryBot.define do
  factory :article do
    sequence(:url) { |n| "example.com/article-#{n}" }

    content { "MyText" }
    title { "MyString" }
    town { "novi sad" }
  end
end
