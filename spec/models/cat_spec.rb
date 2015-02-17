require 'rails_helper'

RSpec.describe Cat, type: :model do
  describe "Validations" do
    it "validates presence of name" do
      cat = build(:cat, name: nil)

      expect(cat.valid?).to be false
      expect(cat.errors[:name].present?).to be true
    end

    it "validates the presence of email" do
      cat = build(:cat, email: nil)

      expect(cat.valid?).to be false
      expect(cat.errors[:email].present?).to be true
    end

    it "validates the presence of password" do
      cat = build(:cat, password_digest: nil)

      expect(cat.valid?).to be false
      expect(cat.errors[:password].present?).to be true
    end

    it "validates the right format of the email" do
      cat = build(:cat, email: "this is a test")

      expect(cat.valid?).to be false
      expect(cat.errors[:email].present?).to be true
    end
  end

  describe "#followers association" do
    let(:cat) { create(:cat) }

    it "returns the list of visible cats that are followed by cat" do
      Rails.cache.delete('cat')

      followed1 = create(:follower_relation, cat: cat)
      followed2 = create(:follower_relation, cat: cat)
      followed3 = create(:follower_relation, cat: cat, followed: create(:cat, visible: false))

      followers_array = cat.followers.all.to_a

      expect(followers_array).to include followed1.followed
      expect(followers_array).to include followed2.followed
      
      expect(followers_array).to_not include followed3.followed

      # expect(cat.followers.all).to eq([followed1.followed, followed2.followed])
    end
  end

  describe "#followed_by association" do
    let(:cat) { create(:cat) }

    it "returns the list of visible cats that are following cat" do
      follower1 = create(:follower_relation, followed: cat)
      follower2 = create(:follower_relation, followed: cat)
      create(:follower_relation, cat: create(:cat, visible: false), followed: cat)

      expect(cat.followed_by.all).to eq([follower1.cat, follower2.cat])
    end
  end

end
