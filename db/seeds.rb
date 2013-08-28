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
@user = User.create!(email: 'a@test.com', password: 'abcdefgh', password_confirmation: 'abcdefgh')
@user.seller = true
@b = User.create!(email: 'b@test.com', password: 'abcdefgh', password_confirmation: 'abcdefgh')
@b.seller = true

@buyer = User.create!(email: 'buyer@test.com', password: 'abcdefgh', password_confirmation: 'abcdefgh')

Address.delete_all
Address.create(user_id: @user.id, line1: "123 First Street", line2: "Suite B", city: "Washington", state: "DC", zip: "20011")
Address.create(user_id: @b.id, line1: "321 Second Street", line2: "Suite E", city: "Arlington", state: "VA", zip: "22182")

Product.delete_all
Product.create!(title: 'Designer watches', price: '2.95', description: 'For men with class', stock: 10, image_url: 'watches.jpg' )
Product.create!(title: 'RON RON VEAU VELOURS', price: '120.95', description: 'For women with taste', stock: 5, image_url: 'shoe.jpg')
Product.create!(title: 'shirt', price: '22.95', description: 'men shirt', stock: 15, image_url: 'shirt.jpg')
Product.create!(title: 'cufflinks', price: '1.95', description: 'men cufflink', stock: 15, image_url: 'cufflink.jpg')

