# frozen_string_literal: true

class SitesController < AuthedController
  before_action :set_site, only: %i[show edit update destroy]

  # GET /sites
  # GET /sites.json
  def index
    @site_members = current_user.site_members
  end

  # GET /sites/1
  # GET /sites/1.json
  def show;
  end

  # GET /sites/new
  def new
    @site = Site.new
  end

  # GET /sites/1/edit
  def edit;
  end

  # POST /sites
  # POST /sites.json
  def create
    respond_to do |format|
      if create_site_and_member
        format.html { redirect_to @site, notice: 'Site was successfully created.' }
        format.json { render :show, status: :created, location: @site }
      else
        format.html { render :new }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_site_and_member
    @site = Site.new(site_params)
    site_member_attrs = { user: current_user, site: @site }
    @site_member = SiteMember.new(site_member_attrs)
    @site_member.role = 'host'
    @site_member.status = 'present'
    @site.save && @site_member.save
  end

  # PATCH/PUT /sites/1
  # PATCH/PUT /sites/1.json
  def update
    respond_to do |format|
      if @site.update(site_params)
        format.html { redirect_to @site, notice: 'Site was successfully updated.' }
        format.json { render :show, status: :ok, location: @site }
      else
        format.html { render :edit }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site.destroy
    respond_to do |format|
      format.html { redirect_to sites_url, notice: 'Site was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_site
    if current_user
      @site = current_user.sites.where(id: params[:id]).first
      raise ActiveRecord::RecordNotFound unless @site
    end

    @site
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def site_params
    params.require(:site).permit(:name)
  end
end
