require 'rails_helper'

RSpec.describe ChoresController, type: :controller do
  let(:site) {FactoryBot.create(:site)}
  let(:user) {FactoryBot.create(:user)}
  let(:valid_attributes) {
    { name: 'fake chore name',
      description: 'fake chore description',
      schedule: 'daily',
      site: site
    }
  }

  let(:invalid_attributes) {{ name: nil }}

  let(:valid_session) {{}}

  context "when user authenticated" do
    before do
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end

    describe "GET #index" do

      it "returns a success response" do
        chore = Chore.create! valid_attributes
        get :index, params: {}, session: valid_session
        expect(response).to be_successful
      end
    end

    describe "GET #show" do
      it "returns a success response" do
        chore = Chore.create! valid_attributes
        get :show, params: { id: chore.to_param }, session: valid_session
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
        chore = Chore.create! valid_attributes
        get :edit, params: { id: chore.to_param }, session: valid_session
        expect(response).to be_successful
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Chore" do
          expect {
            post :create,
                 params: { chore: valid_attributes, selected_site: site.id },
                 session: valid_session
          }.to change(Chore, :count).by(1)
        end

        it "redirects to the created chore" do
          post :create,
               params: { chore: valid_attributes, selected_site: site.id },
               session: valid_session
          expect(response).to redirect_to(Chore.last)
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: { chore: invalid_attributes, selected_site: site.id }, session: valid_session
          expect(response).to be_successful
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          { name: 'new chore name', schedule: 'daily' }
        }

        it "updates the requested chore" do
          chore = Chore.create! valid_attributes
          put :update, params: { id: chore.to_param, chore: new_attributes, selected_site: site.id }, session: valid_session
          chore.reload
          expect(chore.name).to eq 'new chore name'
        end

        it "redirects to the chore" do
          chore = Chore.create! valid_attributes
          put :update,
              params: { id: chore.to_param, chore: new_attributes, selected_site: site.id },
              session: valid_session
          expect(response).to redirect_to(chore)
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'edit' template)" do
          chore = Chore.create! valid_attributes
          put :update,
              params: { id: chore.to_param, chore: invalid_attributes, selected_site: site.id },
              session: valid_session
          expect(response).to be_successful
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested chore" do
        chore = Chore.create! valid_attributes
        expect {
          delete :destroy, params: { id: chore.to_param }, session: valid_session
        }.to change(Chore, :count).by(-1)
      end

      it "redirects to the chores list" do
        chore = Chore.create! valid_attributes
        delete :destroy, params: { id: chore.to_param }, session: valid_session
        expect(response).to redirect_to(chores_url)
      end
    end
  end
end
