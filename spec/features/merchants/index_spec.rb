require "rails_helper"

RSpec.describe "Merchant Index Page", type: :feature do
  describe "As a visitor" do
    before(:each) do
      @merchant_1 = Merchant.create!(name: "Merchant 1", address: "Address 1", city: "City 1", state: "State 1", zip: "Zip 1")
      @merchant_2 = Merchant.create!(name: "Merchant 2", address: "Address 2", city: "City 2", state: "State 2", zip: "Zip 2")
      @merchant_3 = Merchant.create!(name: "Merchant 3", address: "Address 3", city: "City 3", state: "State 3", zip: "Zip 3")
    end

    it "I see the name of each merchant in the system" do
      visit "/merchants"

      within "#merchant-id-#{@merchant_1.id}" do
        expect(page).to have_content(@merchant_1.name)
      end

      within "#merchant-id-#{@merchant_2.id}" do
        expect(page).to have_content(@merchant_2.name)
      end

      within "#merchant-id-#{@merchant_3.id}" do
        expect(page).to have_content(@merchant_3.name)
      end
    end

    it "When I click on the Merchant's name, it takes me to that Merchant's show page" do
      visit "/merchants"

      within "#merchant-id-#{@merchant_1.id}" do
        expect(page).to have_link(@merchant_1.name)

        click_on "#{@merchant_1.name}"
        expect(current_path).to eq("/merchants/#{@merchant_1.id}")
      end

      visit "/merchants"

      within "#merchant-id-#{@merchant_2.id}" do
        expect(page).to have_link(@merchant_2.name)

        click_on "#{@merchant_2.name}"
        expect(current_path).to eq("/merchants/#{@merchant_2.id}")
      end

      visit "/merchants"

      within "#merchant-id-#{@merchant_3.id}" do
        expect(page).to have_link(@merchant_3.name)

        click_on "#{@merchant_3.name}"
        expect(current_path).to eq("/merchants/#{@merchant_3.id}")
      end
    end
  end
end
