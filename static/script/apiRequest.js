$("#loginForm").submit((e) => {
    e.preventDefault();
    if ($("#email").val() != "" && $("#password").val() != "") {
        $.ajax({
            url: '/api/login',
            type: 'post',
            data: { "email": $("#email").val(), "password": $("#password").val() },
            success: (response) => {
                location.reload();
            },
            error: (error) => {
                $(".hideAlert").css("display", "none");
                $("#alertAccountLoginAPIFailed").css("display", "block");
            }
        })
    }
    else {
        $(".hideAlert").css("display", "none");
        $("#alertAccountLoginFailed").css("display", "block");
    }

});
$("#createAccountForm").submit((e) => {
    e.preventDefault();
    if ($("#name").val() != "" && $("#emailReg").val() != "" && $("#passwordReg").val() != "" && $("#reEnterPassword").val() != "") {
        if ($("#passwordReg").val() === $("#reEnterPassword").val()) {
            $.ajax({
                url: '/api/create_account',
                type: 'post',
                data: {
                    "name": $("#name").val(),
                    "email": $("#emailReg").val(),
                    "password": $("#passwordReg").val(),
                },
                success: (response, status) => {
                    $(".hideAlert").css("display", "none");
                    $("#alertAccountCreationSuccess").css("display", "block");
                },
                error: (error) => {
                    $(".hideAlert").css("display", "none");
                    $("#alertAccountCreationAPIFailed").css("display", "block");
                },
            })
        }
        else {
            
            $("#alertAccountCreationDiffPassword").css("display", "block");
        }
    }
    else {
        $(".hideAlert").css("display", "none");
        $("#alertAccountCreationFailed").css("display", "block");
    }

})

$("#signOut, #signOut2").click((e) => {
    e.preventDefault();
    $.ajax({
        url: '/api/sign_out',
        type: 'post',
        data: null,
        success: (response) => {
            location.reload();
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