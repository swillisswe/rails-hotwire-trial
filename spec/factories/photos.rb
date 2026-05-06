FactoryBot.define do
  factory :photo do
    photographer { "Test Photographer" }
    image_url    { "https://example.com/photo.jpg" }
    sequence(:source_url) { |n| "https://example.com/photo/#{n}" }
    alt          { "A test photo" }
  end
end
