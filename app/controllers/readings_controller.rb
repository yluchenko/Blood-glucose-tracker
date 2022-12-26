class ReadingsController < ApplicationController
  def index
    authorize Reading

    @readings = current_user.readings.today
  end

  def create
    @reading = current_user.readings.create(reading_params)
    authorize(@reading)
    if @reading.valid?
      redirect_to root_path, notice: 'Glucose level was successfully added.'
    else
      flash[:alert] = @reading.full_error_message
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @reading = Reading.new
  end

  def search
    @readings = ReadingReport.search(current_user, params[:q]) if params[:q].present?
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('readings',
                                                  partial: 'reading',
                                                  locals: { readings: @readings })
      end
    end
  end

  private

  def reading_params
    params.require(:reading).permit(:level)
  end
end
