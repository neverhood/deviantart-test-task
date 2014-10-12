class StreamsController < ApplicationController
  include ActionController::Live

  before_filter :set_content_type

  def watcher_updates
    # binding.pry
    @notifier     = Notifier.find(params[:notifier_id])

    response.stream.write sse({ events: render_to_string(partial: 'events/event', collection: @notifier.events) }, event: 'fileCreated')

    # binding.pry if events.count > 0
    # response.stream.write sse({ status: ':(' }, { event: 'fileCreated' })

    #@instances = if params[:group_id].present? and Group.where(id: params[:group_id]).any?
                   #Group.find(params[:group_id]).instances
                 #else
                   #Instance.all
                 #end
    #threads    = []

    #@instances.each do |instance|
      #threads << Thread.new do
        #instance.update_status!
        #response.stream.write sse({ status: view_context.colorified_instance_status(instance.status) , id: instance.id.to_s }, { event: INSTANCE_UPDATED_EVENT })
      #end
    #end

    #threads.map(&:join)
    #response.stream.write sse({}, { event: INSTANCES_UPDATED_EVENT })
    #response.stream.close
  rescue IOError
    # client disconnected
  ensure
    response.stream.close
  end

  private

  def set_content_type
    response.headers['Content-Type'] = 'text/event-stream'
  end

  def sse(object, options = {})
    (options.map{ |k,v| "#{k}: #{v}" } << "data: #{JSON.dump object}").join("\n") + "\n\n"
  end
end
