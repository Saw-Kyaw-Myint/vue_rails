require "faker"

# Create categories
10.times do
  Category.create(
    title: Faker::Device.manufacturer
  )
end

# Create a user
user = User.create!(
  name: 'Saw Kyaw Myint',
  profile: 'https://dnm.nflximg.net/api/v6/BvVbc2Wxr2w6QuoANoSpJKEIWjQ/AAAAQSYvFWEjX4WN-4SJuogTJ1Jsolstp-CFXZEm4Hp6MiWPengGwUugw_pGIR6KdjOCOz5WFuNH1EP6n2S_3ZRkEkib4F6A31Uus7e9nSBeDkZquFxlDLLbkfzB-Qchb5wUHJryKVy2PlRFELVZLCAyNB5JwoI.jpg?r=957',
  email: 'saw@gmail.com',
  password: 'password', # Note: You might want to use a more secure password here
  bio: 'Hello'
)
# Seed fake posts
10.times do
  post = user.posts.new(
    title: Faker::Lorem.sentence,
    image: "https://i.pinimg.com/736x/7a/b5/72/7ab572863e511fdec78582522d7e821c.jpg",
    description: Faker::Lorem.paragraph
  )

  post.save(validate: false)

  # Assign a random category to the post
  random_category_id = Category.pluck(:id).sample
  CategoryPost.create!(
    post_id: post.id,
    category_id: random_category_id
  )
end
