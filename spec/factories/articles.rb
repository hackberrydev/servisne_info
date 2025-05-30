FactoryBot.define do
  factory :article do
    sequence(:url) { |n| "example.com/article-#{n}" }

    content { "MyText" }
    title { "MyString" }
    town { "novi sad" }

    trait :pending do
      pending { true }
    end

    trait :sent do
      pending { false }
    end
  end
end
