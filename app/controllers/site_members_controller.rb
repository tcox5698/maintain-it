# frozen_string_literal: true

class SiteMembersController < AuthedController
  before_action :set_site_member, only: %i[show edit update destroy]

  # GET /site_members
  # GET /site_members.json
  def index
    @site_members = SiteMember.all
  end

  # GET /site_members/1
  # GET /site_members/1.json
  def show; end

  # GET /site_members/new
  def new
    @site_member = SiteMember.new
  end

  # GET /site_members/1/edit
  def edit; end

  # POST /site_members
  # POST /site_members.json
  def create
    @site_member = SiteMember.new(site_member_params)

    respond_to do |format|
      if @site_member.save
        format.html { redirect_to @site_member, notice: 'Site member was successfully created.' }
        format.json { render :show, status: :created, location: @site_member }
      else
        format.html { render :new }
        format.json { render json: @site_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /site_members/1
  # PATCH/PUT /site_members/1.json
  def update
    respond_to do |format|
      if @site_member.update(site_member_params)
        format.html { redirect_to @site_member, notice: 'Site member was successfully updated.' }
        format.json { render :show, status: :ok, location: @site_member }
      else
        format.html { render :edit }
        format.json { render json: @site_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /site_members/1
  # DELETE /site_members/1.json
  def destroy
    @site_member.destroy
    respond_to do |format|
      format.html { redirect_to site_members_url, notice: 'Site member deleted.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_site_member
    @site_member = SiteMember.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def site_member_params
    params.require(:site_member).permit(:nick_name, :user_id, :site_id)
  end
end
