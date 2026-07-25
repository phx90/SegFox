admin_email = ENV.fetch("SEED_ADMIN_EMAIL", "admin@segfox.local")
admin_password = ENV["SEED_ADMIN_PASSWORD"]

IMAGE_POOL = %w[
  seed1.jpg seed2.jpg seed3.jpg seed4.jpg seed5.jpg
  seed6.jpg seed7.jpg seed8.jpg seed9.jpg seed10.jpg
  terrier11.jpg pastor11.jpg terrier_brasileiro.jpg pastor_mantiqueira.jpg
].freeze

def ensure_demo_images(dog, preferred_image)
  start_index = IMAGE_POOL.index(preferred_image) || 0
  candidates = IMAGE_POOL.rotate(start_index)
  attached_filenames = dog.images.map { |image| image.filename.to_s }

  candidates.each do |filename|
    break if dog.images.size >= 4
    next if attached_filenames.include?(filename)

    path = Rails.root.join("app/assets/images", filename)
    next unless path.exist?

    dog.images.attach(io: File.open(path, "rb"), filename: filename, content_type: "image/jpeg")
    attached_filenames << filename
  end
end

if admin_password.present?
  admin = Admin.find_or_initialize_by(email: admin_email)
  admin.password = admin_password
  admin.password_confirmation = admin_password
  admin.save!
  puts "Administrador de demonstração disponível em #{admin.email}."
else
  puts "Administrador não criado. Defina SEED_ADMIN_PASSWORD para criá-lo."
end

dogs = [
  {
    name: "Jade",
    breed: "Terrier Brasileiro",
    birth_date: Date.new(2023, 4, 12),
    description: "Terrier Brasileiro ativo, sociável e criado com acompanhamento responsável.",
    image: "seed1.jpg"
  },
  {
    name: "Mantiqueira",
    breed: "Pastor da Mantiqueira",
    birth_date: Date.new(2022, 9, 3),
    description: "Pastor da Mantiqueira equilibrado, atento e adaptado ao convívio familiar.",
    image: "seed2.jpg"
  }
]

dogs.each do |attributes|
  image = attributes.delete(:image)
  dog = Dog.find_or_initialize_by(name: attributes[:name], breed: attributes[:breed])
  dog.assign_attributes(attributes.merge(available: true))

  ensure_demo_images(dog, image)

  dog.save!
end

puts "#{dogs.size} cães de demonstração preparados sem apagar registros existentes."

families = {
  "Terrier Brasileiro" => [
    { name: "Bento", birth_date: Date.new(2017, 2, 14), image: "seed3.jpg" },
    { name: "Luna", birth_date: Date.new(2018, 6, 9), image: "seed4.jpg" },
    { name: "Nina", birth_date: Date.new(2020, 3, 21), father: "Bento", mother: "Luna", image: "seed5.jpg" },
    { name: "Theo", birth_date: Date.new(2020, 11, 5), father: "Bento", mother: "Luna", image: "seed6.jpg" },
    { name: "Mel", birth_date: Date.new(2023, 8, 17), father: "Theo", mother: "Nina", image: "seed7.jpg" }
  ],
  "Pastor da Mantiqueira" => [
    { name: "Apolo", birth_date: Date.new(2016, 5, 11), image: "seed8.jpg" },
    { name: "Serena", birth_date: Date.new(2017, 10, 24), image: "seed9.jpg" },
    { name: "Gaia", birth_date: Date.new(2019, 7, 2), father: "Apolo", mother: "Serena", image: "seed10.jpg" },
    { name: "Thor", birth_date: Date.new(2020, 1, 19), father: "Apolo", mother: "Serena", image: "pastor11.jpg" },
    { name: "Aurora", birth_date: Date.new(2023, 12, 6), father: "Thor", mother: "Gaia", image: "pastor_mantiqueira.jpg" }
  ]
}

families.each do |breed, members|
  members.each do |attributes|
    dog = Dog.find_or_initialize_by(name: attributes[:name], breed: breed)
    dog.assign_attributes(
      birth_date: attributes[:birth_date],
      description: "#{attributes[:name]} integra a família de demonstração da raça #{breed}.",
      available: true,
      father: attributes[:father] && Dog.find_by!(name: attributes[:father], breed: breed),
      mother: attributes[:mother] && Dog.find_by!(name: attributes[:mother], breed: breed)
    )

    ensure_demo_images(dog, attributes[:image])

    dog.save!
  end
end

puts "#{families.values.sum(&:size)} cães com genealogia preparados sem duplicar registros."
