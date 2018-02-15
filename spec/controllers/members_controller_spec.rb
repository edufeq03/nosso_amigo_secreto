require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  include Devise::Test::ControllerHelpers

   before(:each) do
     @request.env["devise.mapping"] = Devise.mappings[:user]
     @current_user = FactoryBot.create(:user)
     sign_in @current_user
   end

  describe "POST #create" do
    before(:each) do
      @campaign = create(:campaign, user: @current_user)
      @member_attributes = attributes_for(:member, campaing: @campaign)
    end

    it "Member created with success" do
      post :create, params: {member: @member_attributes}
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @campaign = create(:campaign, user: @current_user)
      @member = create(:member, campaign: @campaign)
      delete :destroy, params: {id: @member.id}, format: :json
    end

    it "Member deleted with success" do
      expect(response).to have_http_status(:success)
    end

    it 'Destroy member of database' do
      expect( Member.find_by(id: @member.id) ).to be_nil
    end
  end

  describe "PUT #update" do
    before(:each) do
      @campaign = create(:campaign, user: @current_user)
      @member = create(:member, campaign: @campaign)
      @new_member_attributes = attributes_for(:member, campaign: @campaign)
      put :update, params: {id: @member.id, member: @new_member_attributes}, format: :json
      request.env["HTTP_ACCEPT"] = 'application/json'
    end

    it "Member updated with success" do
      expect(response).to have_http_status(:success)
    end

  end
end
