class Event < ActiveRecord::Base
  default_scope -> { order('created_at DESC') }

  belongs_to :notifier
end
