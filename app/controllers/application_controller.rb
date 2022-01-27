class ApplicationController < ActionController::Base

  helper_method :render_flash
  
  def render_flash
    return unless request.format.turbo_stream?
    return if response.status == 301 || response.status == 302

    Turbo::StreamsChannel.broadcast_update_to([current_user, :posts], target: :notifications, partial: 'shared/flash', locals: { flash: flash })
    # render turbo_stream: turbo_stream.update(:flash, partial: 'shared/flash')
  end
end
