class NotifiersController < ApplicationController
  before_filter :find_notifier!, only: [ :show, :destroy ]

  def index
    respond_to do |format|
      format.html do
        @notifiers = Notifier.all
        @notifier  = Notifier.new
      end

      format.json do
        directories = Dir.glob("#{params[:term]}*/*/*/").take(10)

        render text: directories.to_json, status: 202
      end
    end
  end

  def create
    @notifier = Notifier.create(notifier_params)

    if @notifier.persisted?
      render json: { notifier: render_to_string(partial: 'notifier', locals: { notifier: @notifier }) }, status: 202
    else
      render json: { errors: @notifier.errors }, status: 422
    end
  end

  def show
  end

  def history
    @notifier = Notifier.find(params[:notifier_id])
    seconds   = params[:seconds].to_i

    events = @notifier.events.where(['file_mtime > ?', seconds.ago])

    if events.count > 0
      render json: { files: events.map { |event| event.absolute_file_path },
                     median_length: (events.inject(0) { |sum, event| sum + event.file_name.length })/events.count }
    else
      render json: { error: "No events found for notifier #{@notifier.id} for last #{seconds} seconds}", status: 422 }
    end
  end

  def destroy
    @notifier.destroy

    render nothing: true, status: 200
  end

  private

  def find_notifier!
    @notifier = Notifier.find(params[:id])
  end

  def notifier_params
    params.require(:notifier).permit(:path, :pattern)
  end
end
