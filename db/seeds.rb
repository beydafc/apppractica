require "open-uri"

# Borrado de datos
puts "Borrando datos de las tablas"
CategoryRestaurant.destroy_all
Restaurant.destroy_all
User.destroy_all
Category.destroy_all

# Creación de categorías

puts "Creando categorías"

vegana = Category.create!(name: "Vegana")
vegetariana = Category.create!(name: "Vegetariana")
china = Category.create!(name: "China")
japonesa = Category.create!(name: "Japonesa")
mexicana = Category.create!(name: "Mexicana")
tradicional = Category.create!(name: "Tradicional")
pescados = Category.create!(name: "Pescados")
mariscos = Category.create!(name: "Mariscos")

puts "Finalizando creación de categorías"

# Creación user

puts "Creando usuario"

usuario1 = User.create!(email: "beyda@hotmail.com", password: "123456")

usuario2 = User.create!(email: "vicky@hotmail.com", password: "123456")

# Agregó foto

file = URI.open("https://avatars.githubusercontent.com/u/144365996?v=4")
usuario1.photo.attach(io: file, filename: "beyda.png", content_type: "image/png")

file = URI.open("https://avatars.githubusercontent.com/u/150090896?v=4")
usuario2.photo.attach(io: file, filename: "vicky.png", content_type: "image/png")

# Guardo en la tabla users

usuario1.save!

usuario2.save!

puts "Se ha creado el usuario: #{usuario1.email}"
puts "Se ha creado el usuario: #{usuario2.email}"

# Creación de restaurante y categoría para un usuario

restaurante1 = Restaurant.create!(
  name: "La Cantina",
  description: "La mejor comida mexicana y del mundo",
  address: "Sendero del Amanecer 16, Queretaro, Mexico",
  avg_rating: 5,
  user: usuario1
)

restaurante2 = Restaurant.create!(
  name: "Aramburu",
  description: "La mejor comida argentina",
  address: "Italia 234, Buenos Aires, Argentina",
  avg_rating: 5,
  user: usuario2
)
# Agregó foto

file_restaurante1 = URI.open("https://raw.githubusercontent.com/abdulaba/restaurants-images-seed/main/cantina-la-15.jpeg")
restaurante1.photo.attach(io: file_restaurante1, filename: "la-cantina.png", content_type: "image/png")

restaurante1.category_ids = [mexicana.id, japonesa.id]

file_restaurante2 = URI.open("https://raw.githubusercontent.com/abdulaba/restaurants-images-seed/main/aramburu.jpeg")
restaurante2.photo.attach(io: file_restaurante2, filename: "aramburu.png", content_type: "image/png")

restaurante2.category_ids = [vegetariana.id, tradicional.id]

# antes de guardar los cambios, le asigno sus categorías y luego guardo

# Guardo en la tabla users

restaurante1.save!
restaurante2.save!

puts "Se ha creado el restaurante: #{restaurante1.name}"
puts "Se ha creado el restaurante: #{restaurante2.name}"

# Creando categorías para el restaurante

# categoria1 = CategoryRestaurant.create!(category_id: mexicana.id,restaurant_id: restaurante1.id)

# puts "Se agregó categoría #{mexicana.name} para el restaurante #{restaurante1.name}"

# categoria2 = CategoryRestaurant.create!(category_id: japonesa.id,restaurant_id: restaurante1.id)

# puts "Se agregó categoría #{japonesa.name} para el restaurante #{restaurante1.name}"
