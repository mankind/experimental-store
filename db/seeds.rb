# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#http://stackoverflow.com/questions/5149128/rails-3-multiple-has-one-associations-seeding

#User.create(:email => 'nnn@gmail.com', :password => 'foobar', :password_confirmation => 'foobar', :first_name => 'nn', :last_name => 'yy')

User.delete_all
@a = User.create!(email: 'a@test.com', password: 'abcdefgh', password_confirmation: 'abcdefgh')
@a.seller = true
@a.save
@b = User.create!(email: 'b@test.com', password: 'abcdefgh', password_confirmation: 'abcdefgh')
@b.seller = true
@b.save

@buyer = User.create!(email: 'buyer@test.com', password: 'abcdefgh', password_confirmation: 'abcdefgh')

Address.delete_all
Address.create(user_id: @a.id, line1: "123 First Street", line2: "Suite B", city: "Washington", state: "DC", zip: "20011")
Address.create(user_id: @b.id, line1: "321 Second Street", line2: "Suite E", city: "Arlington", state: "VA", zip: "22182")

@watch = 'http://www.thewatchhut.co.uk/assets/products/A168WG-9EF%202142267-336750.jpg'
@women = 'http://media.eu.christianlouboutin.com/media/catalog/product/cache/11/image/660x400/9df78eab33525d08d6e5fb8d27136e95/c/h/christianlouboutin-ronron-3100122_L001_1_1200x1200.jpg?'
@shirt = 'http://johnlewis.scene7.com/is/image/JohnLewis/000721110?$prod_main$'
@cufflink = 'http://dappered.com/wp-content/uploads/2012/05/HB-Cufflinks.jpg'

Product.delete_all
Product.create!(user_id: @a.id, title: 'Designer watches', price: '2.95', description: 'For men with class', stock: 10, image_url: open(@watch) )
Product.create!(user_id: @a.id, title: 'RON RON VEAU VELOURS', price: '120.95', description: 'For women with taste', stock: 5, image_url: open(@women) )
Product.create!(user_id: @b.id, title: 'shirt', price: '22.95', description: 'men shirt', stock: 15, image_url: open(@shirt))
Product.create!(user_id: @b.id, title: 'cufflinks', price: '1.95', description: 'men cufflink', stock: 15, image_url: open(@cufflink))
