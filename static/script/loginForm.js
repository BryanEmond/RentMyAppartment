$("#loginForm").submit((e) => {
    e.preventDefault();
    let data = { "email": $("#email").val(), "password": $("#password").val() }
    $.ajax({
        url: '/api/login',
        type: 'post',
        data: data,
        success: (response) => {
            window.location.href = response.redirect
        }
    })
});
$("#createAccountForm").submit((e) => {
    e.preventDefault();
    let password = $("#passwordReg").val()
    let password2 = $("#reEnterPassword").val()
    if (password === password2) {
        let data = {
            "name": $("#name").val(),
            "email": $("#emailReg").val(),
            "password": password,
        }
        $.ajax({
            url: '/api/create_account',
            type: 'post',
            data: data,
            success: (response) => {
                window.location.href = response.redirect
            }
        })
    }

})