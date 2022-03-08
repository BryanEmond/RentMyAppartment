$("#loginForm").submit((e) => {
    e.preventDefault();
    $.ajax({
        url: '/api/login',
        type: 'post',
        data: { "email": $("#email").val(), "password": $("#password").val() },
        success: (response) => {
            console.log(response)
            location.reload();
        }
    })
});
$("#createAccountForm").submit((e) => {
    e.preventDefault();
    if ($("#passwordReg").val() === $("#reEnterPassword").val()) {
        $.ajax({
            url: '/api/create_account',
            type: 'post',
            data: {
                "name": $("#name").val(),
                "email": $("#emailReg").val(),
                "password": $("#passwordReg").val(),
            },
            success: (response) => {
                console.log(response)
            }
        })
    }
})

$("#signOut, #signOut2").click((e) => {
    e.preventDefault();
    $.ajax({
        url: '/api/sign_out',
        type: 'post',
        data: null,
        success: (response) => {
            console.log(response)
        }
    })
})

$("#manageAd, #manageAd2").click((e) => {
    e.preventDefault();

    $.ajax({
        url: '/api/redirectToAdManager',
        type: 'post',
        data: { "UID": USERConst },
        success: (response) => {
            location.href = response.redirect
        }
    })
})