# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Pet.destroy_all
Review.destroy_all
Shelter.destroy_all

shelter_1 = Shelter.create(
  name: "All Puppies All the Time",
  address: "124 Fake Ln.",
  city: "Faketown",
  state: "FK",
  zip: "55555")

shelter_2 = Shelter.create(
  name: "Your Best Dog Now!",
  address: "45 Dumpster Fire Alley",
  city: "Faketown",
  state: "FK",
  zip: "55555")

pet_1 = shelter_1.pets.create({
  name: "Bill",
  approx_age: 3,
  sex: "male",
  image_path: "https://cdn.pixabay.com/photo/2016/12/13/05/15/puppy-1903313_1280.jpg",
  description: "Very canine",
  adoptable: true})

pet_2 = shelter_1.pets.create({
  name: "Phil",
  approx_age: 1,
  sex: "male",
  image_path: "https://boygeniusreport.files.wordpress.com/2016/11/puppy-dog.jpg",
  description: "Very canine",
  adoptable: true})

shelter_2.pets.create({
  name: "Jill",
  approx_age: 5,
  sex: "female",
  image_path: "http://files.alfresco.mjh.group/alfresco_images/DVM360//2019/02/27/c23624de-1b4c-4e61-961f-db10dcf27341/veterinary-black-puppy-licking-wood-AdobeStock_211167675-450.jpg",
  description: "Very canine",
  adoptable: true})

shelter_2.pets.create({
  name: "Will",
  approx_age: 2,
  sex: "male",
  image_path: "https://image.cnbcfm.com/api/v1/image/105992231-1561667465295gettyimages-521697453.jpeg",
  description: "Very canine",
  adoptable: true})

shelter_1.reviews.create!(
 title: "Great Location",
 rating: 4,
 content: "3n22 ewlrjwe kej wrkjw nwke nqln qn onrkew 3k iw qm",
 image_path: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHrpmj6jvqKicV9ttIunW_Oz_PM-x5RfLsPYYCdAlw6uLf628JxA&s")

shelter_1.reviews.create!(
 title: "Small store front",
 rating: 2,
 content: "3n2 ww q2 ewlrjwe ke wrkw qw jw nwke 23 2nqln qn onrkew 3k iw dqqm")
