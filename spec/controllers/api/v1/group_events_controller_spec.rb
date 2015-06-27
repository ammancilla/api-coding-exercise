require 'rails_helper'

RSpec.describe Api::V1::GroupEventsController, type: :controller do
  let(:group_event) { create(:group_event) }

  describe "GET #index" do
    it "returns all the group events" do
      create_list(:group_event, 10)
      get :index, format: :json

      expect(response.body).to have_json_size(10).at_path('group_events') 
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "retrieve a specific group event" do
      get :show, id: group_event, format: :json
      
      expect(response.body).to have_json_path('published')
      expect(response.body).to have_json_size(9)
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "create a new group event" do
        expect {
          post :create, group_event: attributes_for(:group_event), format: :json
        }.to change(GroupEvent, :count).by(1)
    
        expect(response.status).to eq(201)
      end
    end

    context "with invalid attributes" do
      it "doesn't create a new group event" do
        expect {
          post :create, group_event: { duration: 0 }, format: :json
        }.to_not change(GroupEvent, :count)

        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT #update" do
    context "with valid attributes" do
      it "update group event attributes" do
        put :update, id: group_event, group_event: { name: 'my updated group event' }, format: :json
        group_event.reload

        expect(group_event.name).to eq('my updated group event')
        expect(response.status).to eq(201)
      end
    end

    context "with invalid attributes" do
      it "doesn't update group event attributes" do
        put :update, id: group_event, group_event: { name: 'my updated group event', duration: 1.2 }, format: :json
        group_event.reload

        expect(group_event.name).to_not eq('my updated group event')
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE #destroy" do
    it "mark the group event as removed" do
      delete :destroy, id: group_event, format: :json

      group_event.reload
      expect(group_event.removed).to be_truthy
      expect(response.status).to eq(204)
    end
  end
end
