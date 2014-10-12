class DirectoryValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, I18n.t('activerecord.errors.models.notifier.attributes.path.not_a_directory')) unless File.directory?(value)
  end
end

class RegexpValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      Regexp.new value
    rescue RegexpError => error
      record.errors.add(attribute, error.message)
    end
  end
end

class Notifier < ActiveRecord::Base
  has_many :events, :dependent => :destroy

  validates :path, :pattern, presence: true

  validates :path, directory: true,  if: -> { path.present? }
  validates :path, uniqueness: true, if: -> { path.present? }

  validates :pattern, regexp: true, if: -> { pattern.present? }

  before_validation -> { path.gsub!(/\/+$/, '') if path.end_with?('/') }
  after_create      -> { NotifierWorker.perform_async(id) }

  def start!
    @watcher  = INotify::Notifier.new

    logger.info "Things are happening."
    logger.info path

    catch(:done) do
      @watcher.watch(path, :create) do |event|
        file = File.new(File.join path, event.name)
        stat = File.stat(file)

        if Notifier.where(id: id).any?
          if event.name =~ Regexp.new(pattern)
            events.create(file_name: event.name, absolute_file_path: file.path, file_mtime: file.mtime, ownership: "uid: #{stat.uid}, gid: #{stat.gid}")
          end
        else
          @watcher.stop
          throw :done
        end
      end

      loop do
        @watcher.process
      end
    end
  end
end
