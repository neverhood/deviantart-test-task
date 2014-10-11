# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#

$.api.notifiers = api =
    init: ->

        if $.api.action == 'index'

            # Components
            $formToggler   = $('a#new-notifier-form-toggler')
            $formContainer = $('div#new-notifier-form-container')
            $form          = $('form#notifier-form')
            $notifiers     = $('tbody#notifiers')

            # Live Selectors
            $destroy = 'a.destroy-notifier'


            #########
            # New
            #########
            $formToggler.bind 'click', (event) ->
                event.preventDefault()
                $formContainer.slideToggle 'fast'

                $(this).toggleClass 'active'

                $('#notifier_path').autocomplete
                    source: 'notifiers',
                    minLength: 2


            #########
            # Create
            #########
            $form.bind('ajax:complete', (event, xhr, status) ->
                $this    = $(this)
                response = $.parseJSON(xhr.responseText)

                if ( status == 'success' )
                    $this.trigger 'reset'

                    $notifiers.prepend response.notifier
                    $formContainer.slideToggle 'fast'

                    $formToggler.removeClass 'active'
                else
                    for own attribute, errors of response.errors
                        input = $this.find('#notifier_' + attribute)

                        $.api.utils.appendErrorsTo(input, errors)
            ).bind 'ajax:beforeSend', -> $.api.utils.removeErrorsFrom $(this)

            #########
            # Destroy
            #########
            $notifiers.on 'ajax:beforeSend', $destroy, ->
                $(this).parents('tr').remove()

        if $.api.action == 'show'
            groupId          = $('table#instances-table').data('id')
            $instances       = $('tbody#instances')

            instanceIds = (instance.attributes['data-id'].value for instance in $instances.find('tr.instance'))

            dispatcher = new EventSource("/streams/instances_status?group_id=#{groupId}")
            dispatcher.addEventListener 'instanceUpdate', (event) ->
                eventData  = $.parseJSON(event.data)
                instanceId = eventData.id
                status     = eventData.status

                $instances.find("tr[data-id='#{instanceId}'] td.status").html status

            dispatcher.addEventListener 'instancesUpdated', (event) ->
                dispatcher.close()

