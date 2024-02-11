class EntriesController < ApplicationController
  skip_before_action :ensure_user_authenticated!, only: %i[index show]
  before_action :user_authenticated?, only: %i[index show]

  # GET /entries
  def index
    @entries = Entry.all
  end

  # GET /entries/1
  def show
    if params[:id] == "new"
      redirect_to root_path
    else
      @entry = Entry.find(params[:id])
    end
  end

  # GET /entries/new
  def new
    @entry = Current.user.entries.build
  end

  # GET /entries/1/edit
  def edit
    @entry = Current.user.entries.find(params[:id])
  end

  # POST /entries
  def create
    @entry = Current.user.entries.build(entry_params)

    if @entry.save
      redirect_to @entry, notice: "Entry was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /entries/1
  def update
    @entry = Current.user.entries.find(params[:id])

    if @entry.update(entry_params)
      redirect_to @entry, notice: "Entry was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /entries/1
  def destroy
    @entry = Current.user.entries.find(params[:id])

    @entry.destroy!
    redirect_to entries_url, notice: "Entry was successfully destroyed.", status: :see_other
  end

  private
    # Only allow a list of trusted parameters through.
    def entry_params
      params
        .require(:entry)
        .permit(
          :name,
          :url,
          :repository_url,
          :host,
          :operating_system,
          uses: []
        )
    end
end
