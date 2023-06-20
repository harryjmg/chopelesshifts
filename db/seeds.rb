
# Create a main sample user.
User.create!(email: "test@test.fr", password: "test", password_confirmation: "test")

# Create 3 plannings
3.times do |n|
    Planning.create!(name: "Planning #{n+1}")
end