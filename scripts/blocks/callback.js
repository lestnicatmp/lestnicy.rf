jQuery(function () {
    $('[data-callback-trigger]').click(function (event) {
        event.preventDefault();
        Comagic.openSitePhonePanel();
    })
})
