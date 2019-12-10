require 'rails_helper'

describe Pet, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :sex}
    it {should validate_presence_of :image_path}
    it {should validate_presence_of :approx_age}
    it {should validate_presence_of :description}

    # The following test produces a warning, but is the only way to test for presence of boolean
    # it {should validate_inclusion_of(:adoptable).in_array([true, false])}
  end

  describe "relationships" do
    it {should belong_to :shelter}
    it {should have_many(:pet_applications).dependent(:destroy)}
    it {should have_many(:applications).through(:pet_applications)}
  end

  describe "methods" do
    describe "instance methods" do
      before(:each) do
        @shelter_1 = Shelter.create(name: "Ridiculous Test Name",
                                   address: "124 Fake Ln.",
                                   city: "Faketown",
                                   state: "FK",
                                   zip: "55555")
        @pet_1 = @shelter_1.pets.create({
                                     name: "Bill",
                                     approx_age: 3,
                                     sex: "male",
                                     image_path: "http://www.thing.com/image.png",
                                     description: "Very canine",
                                     adoptable: true
                                   })
        @pet_2 = @shelter_1.pets.create({
                                     name: "Jill",
                                     approx_age: 5,
                                     sex: "female",
                                     image_path: "http://www.thing.com/image.png",
                                     description: "Very canine",
                                     adoptable: false
                                   })
        @pet_3 = @shelter_1.pets.create({
                                     name: "Jilly",
                                     approx_age: 5,
                                     sex: "female",
                                     image_path: "http://www.thing.com/image.png",
                                     description: "Very canine",
                                     adoptable: true
                                   })
        @application = Application.create(
          name: "Daniel The Schmuck Frampton",
          address: "123 Main",
          city: "College Station",
          state: "Texas",
          zip: "80155",
          phone_number: "2014239102",
          description: "nf wkfs. ekwj mqn wka?")
        @application.pets << [@pet_3]
        visit "/applications/#{@application.id}"
        click_link "Approve application for: #{@pet_3.name}"
      end

      it "can return adoptable/pending for adoptable status" do
        expect(@pet_1.adoptable_status).to eq("adoptable")
        expect(@pet_2.adoptable_status).to eq("pending")
      end

      it "can return application object when application is approved" do
        expect(@pet_3.owner).to eq(@application)
        expect(@pet_3.owner.name).to eq("Daniel The Schmuck Frampton")
      end
    end

    describe "class methods" do
      before(:each) do
        @shelter_1 = Shelter.create(name: "Ridiculous Test Name",
                                   address: "124 Fake Ln.",
                                   city: "Faketown",
                                   state: "FK",
                                   zip: "55555")
        @pet_1 = @shelter_1.pets.create({
                                     name: "Bill",
                                     approx_age: 3,
                                     sex: "male",
                                     image_path: "http://www.thing.com/image.png",
                                     description: "Very canine",
                                     adoptable: true
                                   })
        @pet_2 = @shelter_1.pets.create({
                                     name: "Jill",
                                     approx_age: 5,
                                     sex: "female",
                                     image_path: "http://www.thing.com/image.png",
                                     description: "Very canine",
                                     adoptable: false
                                   })
        @pet_3 = @shelter_1.pets.create({
                                     name: "Jilly",
                                     approx_age: 5,
                                     sex: "female",
                                     image_path: "http://www.thing.com/image.png",
                                     description: "Very canine",
                                     adoptable: true
                                   })
        @application = Application.create(
          name: "Daniel The Schmuck Frampton",
          address: "123 Main",
          city: "College Station",
          state: "Texas",
          zip: "80155",
          phone_number: "2014239102",
          description: "nf wkfs. ekwj mqn wka?")
        @application.pets << [@pet_2, @pet_3]
        @favorites = FavoritesList.new({@pet_1.id => true, @pet_3.id => true})
        visit "/applications/#{@application.id}"
        click_link "Approve application for: #{@pet_3.name}"
        @pets = Pet.all
      end

      it 'can return relation with all favorited pets' do
        # pets 1 and 3
        expected_relation = Pet.find([@pet_1.id, @pet_3.id])
        expect(@pets.favorited(@favorites)).to eq(expected_relation)
      end

      it 'can return relation with name and id all applied-for pets' do
        # pets 2 and 3
        expected_relation = Pet.select(:name, :id).joins(:pet_applications).distinct
        expect(@pets.applied).to eq(expected_relation)
      end

      it 'can return relation with name and id all approved-application pets' do
        # pet 3
        expect(@pets.approved).to eq([@pet_3])
      end
    end
  end
end
