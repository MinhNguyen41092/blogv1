FactoryGirl.define do
  factory :article do
    name {FFaker::Name.name}
    body {FFaker::Lorem.paragraph(5)}
    user_id 1
  end
end
