require 'rails_helper'

RSpec.describe ScheduledChoresController, type: :controller do
  let(:site) {FactoryBot.create(:site)}
  let(:chore) {FactoryBot.create(:chore, site: site)}

  let(:valid_attributes) {
    { due: Time.now(), site_id: site.id, chore_id: chore.id }
  }

  let(:invalid_attributes) {
    { due: nil, site_id: nil, chore_id: nil }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ScheduledChoresController. Be sure to keep this updated too.
  let(:valid_session) {{}}

  describe "GET #index" do
    it "returns a success response" do
      scheduled_chore = ScheduledChore.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      scheduled_chore = ScheduledChore.create! valid_attributes
      get :show, params: { id: scheduled_chore.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      scheduled_chore = ScheduledChore.create! valid_attributes
      get :edit, params: { id: scheduled_chore.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new ScheduledChore" do
        expect {
          post :create, params: { scheduled_chore: valid_attributes }, session: valid_session
        }.to change(ScheduledChore, :count).by(1)
      end

      it "redirects to the created scheduled_chore" do
        post :create, params: { scheduled_chore: valid_attributes }, session: valid_session
        expect(response).to redirect_to(ScheduledChore.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { scheduled_chore: invalid_attributes }, session: valid_session
        expect(response).to be_successful
        expect(ScheduledChore.count).to eq 0
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_due_date) {3.days.from_now.round}
      let(:new_attributes) {
        { due: new_due_date }
      }

      it "updates the requested scheduled_chore" do
        scheduled_chore = ScheduledChore.create! valid_attributes
        put :update, params: { id: scheduled_chore.to_param, scheduled_chore: new_attributes }, session: valid_session
        scheduled_chore.reload
        expect(scheduled_chore.due).to eq new_due_date
      end

      it "redirects to the scheduled_chore" do
        scheduled_chore = ScheduledChore.create! valid_attributes
        put :update, params: { id: scheduled_chore.to_param, scheduled_chore: valid_attributes }, session: valid_session
        expect(response).to redirect_to(scheduled_chore)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        scheduled_chore = ScheduledChore.create! valid_attributes
        put :update, params: { id: scheduled_chore.to_param, scheduled_chore: invalid_attributes }, session: valid_session
        expect(response).to be_successful
        scheduled_chore.reload
        expect(scheduled_chore.due).to eq valid_attributes[:due]
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested scheduled_chore" do
      scheduled_chore = ScheduledChore.create! valid_attributes
      expect {
        delete :destroy, params: { id: scheduled_chore.to_param }, session: valid_session
      }.to change(ScheduledChore, :count).by(-1)
    end

    it "redirects to the scheduled_chores list" do
      scheduled_chore = ScheduledChore.create! valid_attributes
      delete :destroy, params: { id: scheduled_chore.to_param }, session: valid_session
      expect(response).to redirect_to(scheduled_chores_url)
    end
  end
end
