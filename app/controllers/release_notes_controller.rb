class ReleaseNotesController < ApplicationController
  before_action :set_release_note, only: %i[edit update destroy]
  before_action :check_admin, only: %i[edit update destroy]
  skip_before_action :require_login, only: %i[index]

  def index
    @release_notes = ReleaseNote.order(id: :desc)
  end

  def new
    @release_note = ReleaseNote.new
  end

  def create
    @release_note = current_user.release_notes.build(release_note_params)

    if @release_note.save
      flash[:notice] = t('defaults.flash.created', item: ReleaseNote.model_name.human)
      redirect_to release_notes_path
    else
      flash.now[:alert] = t('defaults.flash.not_created', item: ReleaseNote.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @release_note.update(release_note_params)
      flash[:notice] = t('defaults.flash.updated', item: ReleaseNote.model_name.human)
      redirect_to release_notes_path
    else
      flash.now[:alert] = t('defaults.flash.not_updated', item: ReleaseNote.model_name.human)
      render :edit
    end
  end

  def destroy
    @release_note.destroy
    flash[:notice] = t('defaults.flash.destroyed', item: ReleaseNote.model_name.human)
    redirect_to release_notes_path, status: :see_other
  end

  private

  def set_release_note
    @release_note = ReleaseNote.find(params[:id])
  end

  def check_admin
    redirect_to(root_url) unless current_user.admin?
  end

  def release_note_params
    params.require(:release_note).permit(:title, :text)
  end
end
