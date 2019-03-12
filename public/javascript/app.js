$(document).ready(function() {
    $('#message-form').submit(function (e) {
        e.preventDefault();

        let form = $(e.target);

        let raw_message = form.find('#message').val();
        if (raw_message != '') {
            let encrypt_password = form.find('input[name=password]').val();
            let encrypted_message = CryptoJS.AES.encrypt(raw_message, encrypt_password);

            $('input[name=message]').val(encrypted_message);
        }

        $(this).unbind('submit').submit();
    });

    $('#show-message-form').submit(function (e) {
        e.preventDefault();

        let form = $(e.target);
        let message_container = form.parent().find('div#message-card .card-body');

        let encrypted_message = message_container.text().trim();
        let encrypt_password = form.find('input[name=password]').val();

        let decrypted_message = CryptoJS.AES.decrypt(encrypted_message, encrypt_password);

        message_container.empty().append(decrypted_message.toString(CryptoJS.enc.Utf8));

        message_container.parent().removeClass('d-none');
        form.addClass('d-none');
    });
});