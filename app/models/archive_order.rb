class ArchiveOrder < ApplicationRecord
  belongs_to :user
  enum status: [I18n.t('status.new'), I18n.t('status.accepted'), I18n.t('status.delivered')]
end
