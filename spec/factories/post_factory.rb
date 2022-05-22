FactoryBot.define do
  factory :post do
    subject { "Hello" }
    content { "Lipsum" }
    user
  end
end
