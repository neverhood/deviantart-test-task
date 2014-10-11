$.api = api = {
    I18n: {
        schedules: {
            weekdaysToStart: {
                empty: 'Weekdays to start instance at are not specified'
            },
            weekdaysToStop: {
                empty: 'Weekdays to stop instance at are not specified'
            }
        }
    },

    controller: null,
    action:     null,

    loading: false,

    components: {
        formGroup:                'div.form-group',
        formGroupErrorClass:      'has-error',
        formGroupInlineHelpClass: 'text-danger'
    },

    utils: {
        spinner: function() {
            return "<i class='fa fa-spinner fa-spin'></i>";
        },

        notifications: function() {
            return $('div#notifications');
        },

        notification: function(message, status) {
            var notificationClass;

            switch(status) {
                case 'success':
                    notificationClass = 'alert-success';
                    break;
                case 'danger':
                    notificationClass = 'alert-danger';
                    break;
                case 'info':
                    notificationClass = 'alert-info';
                    break;
                case 'warning':
                    notificationClass = 'alert-warning';
                    break;
                default:
                    notificationClass = 'well';
            };

            var notification = $('div#notification-template').clone().removeAttr('id').removeClass('hidden').addClass(notificationClass);

            notification.find('h4.notification-header').html(message.header);
            notification.find('div.notification-content').html(message.content);

            $.api.utils.notifications().append(notification);
        },

        inlineHelp: function(error) {
            return "<span class='" + api.components.formGroupInlineHelpClass + "'>" + error + "</span>";
        },

        appendErrorsTo: function($input, errors) {
            $input.parents(api.components.formGroup).addClass(api.components.formGroupErrorClass);

            $.each(errors, function(index, error) {
                $input.after(api.utils.inlineHelp(error));
            });
        },

        removeErrorsFrom: function($form) {
            $form.find(api.components.formGroup).removeClass(api.components.formGroupErrorClass);
            $form.find('.' + api.components.formGroupInlineHelpClass).remove();
        }
    }
}

