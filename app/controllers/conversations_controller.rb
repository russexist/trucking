# frozen_string_literal: true

class ConversationsController < ApplicationController
  before_action :set_conversation, only: %i[show destroy]

  def new
    @recipients = User.all - [current_user]
  end

  def create
    recipient = User.find(params[:user_id])
    receipt   = current_user.send_message(recipient, params[:body], recipient)
    redirect_to conversation_path(receipt.conversation)
  end

  def index
    @conversations = current_user.mailbox.conversations
  end

  def show; end

  def destroy
    @conversation.mark_as_deleted(current_user)
    redirect_to conversations_path
  end

  private

  def set_conversation
    @conversation = current_user.mailbox.conversations.find(params[:id])
  end
end
