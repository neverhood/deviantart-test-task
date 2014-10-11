class DirectoryValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, I18n.t('activerecord.errors.models.notifier.attributes.path.not_a_directory')) unless File.directory?(value)
  end
end

class Notifier < ActiveRecord::Base
  validates :path, :pattern, presence: true

  validates :path, directory: true,  if: -> { path.present? }
  validates :path, uniqueness: true, if: -> { path.present? }

  before_validation -> { path.gsub!(/\/+$/, '') if path.end_with?('/') }
end
