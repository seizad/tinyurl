class UrlsController < ApplicationController
  before_action :set_url, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /urls
  # GET /urls.json
  def index
    @urls = Url.where(user_id: current_user.id)
  end

  # GET /urls/1
  # GET /urls/1.json
  def show
  end

  # GET /urls/new
  def new
    @url = Url.new
    @url.http_status = 301 # can come from a property file with all defaults
    @url.outgoing = "http://sample.com"
  end

  # GET /urls/1/edit
  def edit
  end

  # POST /urls
  # POST /urls.json
  def create
    @url = Url.new(url_params)
    @url.user = current_user

    respond_to do |format|
      if @url.save
        format.html { redirect_to @url, notice: 'Url was successfully created.' }
        format.json { render :show, status: :created, location: @url }
      else
        format.html { render :new }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /urls/1
  # PATCH/PUT /urls/1.json
  def update
    respond_to do |format|
      if @url.update(url_params)
        format.html { redirect_to @url, notice: 'Url was successfully updated.' }
        format.json { render :show, status: :ok, location: @url }
      else
        format.html { render :edit }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /urls/1
  # DELETE /urls/1.json
  def destroy
    @url.destroy
    respond_to do |format|
      format.html { redirect_to urls_url, notice: 'Url was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def follow
    @url = Url.find_by_incoming(params[:incoming])
    new_click @url.id
    redirect_to @url.outgoing, status: @url.http_status
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_url
      @url = Url.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def url_params
      params.require(:url).permit(:incoming, :outgoing, :http_status)
    end

    def new_click(url_id)
      @stat = Stat.new(url_id: url_id, event: 1)
      @stat.save # todo: add error handling here.
    end
end
