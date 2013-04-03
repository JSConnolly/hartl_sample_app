require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  describe "profile page" do
    let(:user){ FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
    it { should have_selector("img.gravatar")}
  end

  describe "signup" do
    before { visit signup_path }

    let(:submit){ "Create my account" }

    context "with valid information" do
      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      it "has a welcome message" do
        click_button submit
        page.should have_selector("div.alert-success")
      end
    end

    context "with invalid information" do
      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "user@example"
        fill_in "Password", with: "fooba"
        fill_in "Confirmation", with: "foobar"
      end

      it "should not create a user" do
        expect{ click_button submit }.not_to change(User, :count)
      end
      
      it "should show errors" do
        click_button submit
        page.should have_selector("div.field_with_errors")
      end
    end
  end

end
