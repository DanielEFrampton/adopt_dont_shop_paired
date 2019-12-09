# User Story 24, Pets can only have one approved application on them at any time

describe "As a visitor" do
  before :each do
    @shelter_1 = Shelter.create(
      name: "Ridiculous Test Name",
      address: "124 Fake Ln.",
      city: "Faketown",
      state: "FK",
      zip: "55555")
    @pet_1 = @shelter_1.pets.create(
      name: "Bill",
      approx_age: 3,
      sex: "male",
      image_path: "https://cdn.pixabay.com/photo/2016/12/13/05/15/puppy-1903313_1280.jpg",
      description: "Very canine",
      adoptable: true)
    @pet_2 = @shelter_1.pets.create(
      name: "Phil",
      approx_age: 1,
      sex: "male",
      image_path: "https://boygeniusreport.files.wordpress.com/2016/11/puppy-dog.jpg",
      description: "Very canine",
      adoptable: true)
    @application = Application.create(
      name: "Daniel The Schmuck Frampton",
      address: "123 Main",
      city: "College Station",
      state: "Texas",
      zip: "80155",
      phone_number: "2014239102",
      description: "nf wkfs. ekwj mqn wka?")
    @application_2 = Application.create(
      name: "Ryan A",
      address: "123 Main",
      city: "College Station",
      state: "Texas",
      zip: "80155",
      phone_number: "2014239102",
      description: "nf wkfs. ekwj mqn wka?")
    @application.pets << [@pet_1, @pet_2]
    @application_2.pets << [@pet_1, @pet_2]
  end
  describe "When a pet has more than one application made for them" do
    describe "And one application has already been approved for them" do
      it "I can not approve any other applications for that pet but all other applications still remain on file" do
        visit "/applications/#{@application.id}"

        click_link "Approve application for: #{@pet_2.name}"
        expect(current_path).to eq "/pets/#{@pet_2.id}"

        expect(page).to have_content "Adoptable: pending"
        expect(page).to have_content "On hold for #{@application.name}"

        visit "/applications/#{@application_2.id}"
        expect(page).not_to have_link("Approve application for: #{@pet_2.name}")
        expect(page).to have_link("Approve application for: #{@pet_1.name}")

        visit "/pets/#{@pet_2.id}/applications" # still shows on index page (remains on file)
        expect(page).to have_content(@application.name)
        expect(page).to have_content(@application_2.name)
      end
    end
  end
end
