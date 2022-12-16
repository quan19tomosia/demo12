class MessagesController < ApplicationController
  def create
    @message = current_user.messages.create(room_id: params[:room_id], body: msg_params[:body])
  end

  private
    def msg_params
      params.require(:message).permit(:body)
    end
end
