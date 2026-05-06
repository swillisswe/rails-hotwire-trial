require "csv"

User.find_or_create_by!(email: "user@example.com") do |user|
  user.name = "Demo User"
  user.password = "password"
  user.password_confirmation = "password"
end

CSV.foreach(Rails.root.join("db/photos.csv"), headers: true) do |row|
  Photo.find_or_create_by!(source_url: row["url"]) do |photo|
    photo.photographer = row["photographer"]
    photo.image_url    = row["src.medium"]
    photo.alt          = row["alt"]
  end
end
