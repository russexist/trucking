# frozen_string_literal: true

class ConversationsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
  end

  def create
    recipient = User.find(conversation_params[:recipient])
    receipt = current_user.send_message(recipient, conversation_params[:body], recipient)

    redirect_to conversation_path(receipt.conversation)
  end

  def show
    @receipts = conversation.receipts_for(current_user).order(:created_at).where(deleted: false)

    conversation.mark_as_read(current_user)
  end

  def destroy
    conversation.mark_as_deleted(current_user)
    redirect_to mailbox_inbox_path
  end

  def destroy_message
    message = Mailboxer::Message.find(params[:msg_id])
    current_user.mark_as_deleted message

    redirect_back(fallback_location: root_path)
  end

  def reply
    current_user.reply_to_conversation(conversation, message_params[:body])

    redirect_to conversation_path(conversation)
  end

  private

  def conversation_params
    params.require(:conversation).permit(:body, :subject, :recipient)
  end

  def message_params
    params.require(:message).permit(:body, :subject)
  end
end
