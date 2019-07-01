require "rails_helper"

RSpec.describe "New Merchant Item Form/Creation", type: :feature do
  describe "As a Visitor" do
    before(:each) do
      @merchant_1 = Merchant.create!(name: "Merchant 1", address: "Address 1", city: "City 1", state: "State 1", zip: "Zip 1")

      @item_1 = Item.create!(name: "Item 1", description: "Description 1", price: 1.00, image: "https://www.westelm.com/weimgs/rk/images/wcm/products/201916/0031/img7c.jpg", active: true, inventory: 5, merchant: @merchant_1)
      @item_2 = Item.create!(name: "Item 2", description: "Description 2", price: 2.00, image: "https://www.westelm.com/weimgs/rk/images/wcm/products/201922/0578/img66c.jpg", active: true, inventory: 5, merchant: @merchant_1)
      @item_3 = Item.create!(name: "Item 3", description: "Description 3", price: 3.00, image: "https://www.westelm.com/weimgs/rk/images/wcm/products/201922/0181/slope-leather-lounge-chair-c.jpg", active: true, inventory: 5, merchant: @merchant_1)
    end

    it "I see a form to add a new merchant item" do

      name = "New Item"
      price = 7.00
      description = "Description for New Item"
      image = "https://www.westelm.com/weimgs/rk/images/wcm/products/201909/0012/img7o.jpg"
      inventory = 10

      visit "/merchants/#{@merchant_1.id}/items"

      expect(page).to have_link("Add Item")

      click_link "Add Item"

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/new")

      fill_in "Name", with: name
      fill_in "Price", with: price
      fill_in "Description", with: description
      fill_in "Inventory", with: inventory
      fill_in "Image", with: image

      click_button "Create Item"

      new_item = Item.last

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")

      within "#merchant-item-id-#{new_item.id}" do
        expect(page).to have_content(new_item.name)
        expect(page).to have_content(new_item.price)
        expect(page).to have_content(new_item.description)
        expect(page).to have_content(new_item.inventory)
        expect(page).to have_css("img[src*='#{new_item.image}']")
      end
    end
  end
end