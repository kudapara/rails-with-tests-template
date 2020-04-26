require 'rails_helper'

describe Contact do
  describe "model validations" do
 
    it "has a valid factory" do
      expect(build(:contact)).to be_valid
    end

    it "is valid with firstname, lastname and email" do
      expect(build(:contact)).to be_valid
    end

    it "is invalid without firstname" do
      contact = build(:contact, firstname: nil)
      contact.valid?

      expect(contact.errors[:firstname]).to include("can't be blank")
    end

    it "is invalid without lastname" do
      contact = build(:contact, lastname: nil)
      contact.valid?

      expect(contact.errors[:lastname]).to include("can't be blank")
    end

    it "is invalid without email address" do
      contact = build(:contact, email: nil)
      contact.valid?

      expect(contact.errors[:email]).to include("can't be blank")
    end

    it "is invalid with a duplicate email address" do
      first_contact = create(:contact, email: "kuda@gmail.com")
      contact = build(:contact, email: "kuda@gmail.com")
      contact.valid?

      expect(contact.errors[:email]).to include("has already been taken")
    end
  
    it "returns a contact fullname as a string" do
      contact = build(:contact, firstname: "Kudakwashe", lastname: "Paradzayi")
      contact.valid?

      expect(contact.fullname).to eql("Kudakwashe Paradzayi")
    end
  end

  describe "Searching contacts" do
    before :each do
      @kuda = create(:contact, lastname: "Paradzayi")
      @dani = create(:contact, lastname: "Pareremoyo")
      @muzi = create(:contact, lastname: "Nyathi")
    end

    it "returns a sorted array of results that match" do
      expect(Contact.by_letter("P")).to eq([@kuda, @dani])
    end

    it "exludes records that are not matched by the search" do
      expect(Contact.by_letter("P")).not_to include(@muzi)
    end
  end
end
