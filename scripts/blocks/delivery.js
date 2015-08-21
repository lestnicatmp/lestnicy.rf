jQuery(function () {

    var content = $('.delivery-content');
    var link = $('.delivery-close-link');

    // Initial sync
    sync();

    // Togle on click
    link.click(function (event) {
        var visible = JSON.parse(localStorage.delivery || 'true');
        localStorage.delivery = JSON.stringify(!visible)
        event.preventDefault();
        sync();
    });

    // Sync content status
    function sync(status) {
        var visible = JSON.parse(localStorage.delivery || 'true');
        if (visible) {
            content.show();
        } else {
            content.hide();
        }
    }

});
