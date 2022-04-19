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
    if ($("#name").val() != "" && $("#lastName").val() != "" && $("#emailReg").val() != "" && $("#passwordReg").val() != "" && $("#reEnterPassword").val() != "") {
        if ($("#passwordReg").val() === $("#reEnterPassword").val()) {
            $.ajax({
                url: '/api/create_account',
                type: 'post',
                data: {
                    "name": $("#name").val(),
                    "email": $("#emailReg").val(),
                    "password": $("#passwordReg").val(),
                    "middleName": $("#middleName").val(),
                    "lastName": $("#lastName").val(),
                },
                success: (response, status) => {
                    $(".hideAlert").css("display", "none");
                    $("#alertAccountCreationSuccess").css("display", "block");
                    $("#btnAccountCreation").prop('disabled', true);
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

$("#signOut").click((e) => {
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

$("#manageAd").click((e) => {
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

$("#createAdForm").submit((e) => {
    e.preventDefault();
    $.ajax({
        url: '/api/CreateAd',
        type: 'post',
        data: {
            "UID": USERConst,
            "town": $("#town").val(),
            "size": $("#size").val(),
            "description": $("#description").val(),
            "AID": $("#address").val(),
            "price": $("#price").val(),

        },
        success: (response) => {
            location.reload();
        }
    })
});

function doFunction(app){
    console.log(app)
    $.ajax({
        url: '/api/deleteAppartment',
        type: 'post',
        data: {
            "AID": app

        },
        success: (response) => {
            location.reload();
        }
    })
}

$("#SearchApp").submit((e) => {
    e.preventDefault();
    $.ajax({
        url: '/api/searchAppartment',
        type: 'post',
        data: {
            "UID": USERConst,
            "town": $("#searchTown").val(),
            "size": $("#searchSize").val(),
            "AID": $("#searchAddress").val(),
            "minPrice": $("#minPrice").val(),
            "maxPrice": $("#maxPrice").val(),

        },
        success: (response) => {
            location.href = response.redirect + "?AID="+response.message.AID+"&loc="+response.message.town+ "&size="+response.message.size+ "&minP="+response.message.minPrice+ "&maxP="+response.message.maxPrice
        }
    })
});
