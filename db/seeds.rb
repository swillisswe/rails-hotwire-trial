User.find_or_create_by!(email: "user@example.com") do |user|
  user.name = "Demo User"
  user.password = "password"
  user.password_confirmation = "password"
end
