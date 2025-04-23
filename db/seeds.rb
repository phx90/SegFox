# db/seeds.rb

require "faker"

puts "🔄 Limpando cachorros existentes..."
Dog.destroy_all

puts "✨ Criando cachorros fake com imagens do assets..."

# Número total de imagens seed disponíveis em app/assets/images: seed1.jpg ... seed10.jpg
IMAGE_COUNT = 10

5.times do
  dog = Dog.new(
    name:        Faker::Creature::Dog.name,
    breed:       Faker::Creature::Dog.breed,
    age:         rand(1..12),
    description: Faker::Lorem.sentence(word_count: 12)
  )

  # Seleciona entre 2 e 4 imagens diferentes de seed1.jpg a seed10.jpg
  selected_indices = (1..IMAGE_COUNT).to_a.sample(rand(2..4))
  selected_indices.each_with_index do |idx, i|
    asset_path = Rails.root.join("app/assets/images/seed#{idx}.jpg")
    if File.exist?(asset_path)
      dog.images.attach(
        io:           File.open(asset_path),
        filename:     "seed#{idx}.jpg",
        content_type: "image/jpeg"
      )
    else
      puts "  ⚠️ Imagem não encontrada: seed#{idx}.jpg, pulando..."
    end
  end

  # Se por algum motivo não anexou nenhuma (arquivos faltando), usa default
  if dog.images.blank?
    default_path = Rails.root.join("app/assets/images/default-dog.jpg")
    dog.images.attach(
      io:           File.open(default_path),
      filename:     "default-dog.jpg",
      content_type: "image/jpeg"
    )
  end

  dog.save!
  puts "  ✔️  #{dog.name} (#{dog.breed}, #{dog.age} anos) — #{dog.images.count} imagens anexadas"
end

puts "🎉 Seed finalizada com sucesso!"
