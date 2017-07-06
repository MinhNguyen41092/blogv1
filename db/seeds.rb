5.times do
  Article.create({
    name: FFaker::Book.title,
    body: FFaker::Lorem.paragraph(5),
    user_id: 1
  })
end
