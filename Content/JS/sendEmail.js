function submitEmail() {

    if ($(".email").val() == "") {

        $('#areaSelect').attr("disabled", "disabled");

        return false;
    }
    var email = $(".email").val();
    //var remark = $(".remark").val();

    sendEmail();
};


function sendEmail() {

    var telorMail = $(".email").val();
    var pageName = $(".pageName").val();
    $('#send').attr("disabled", true);

    $.ajax({
        type: 'POST',
        url: '../send.ashx',
        data: { "parmes": telorMail },
        dataType: "text",

        success: function (results) {
           
            if (results == "") {

                $(".email").val("");
                $(".remark").val("");
                $('#myModal').modal('hide');
                $('#send').attr("disabled", false);
            }
            else {

                $(".email").val("");
                $(".remark").val("");
                $('#myModal').modal('hide');
                $("#send").removeAttr("disabled");

                $('#send').attr("disabled", false);
            }
        },
        error: function (e) {
         
            console.log(e);
        }
    });
}
$('#send').click(function () {
    submitEmail()
    $('#send').attr("disabled", false);
})
document.onkeydown = function (event) {
    var e = event || window.event || arguments.callee.caller.arguments[0];
    if (e && e.keyCode == 13) {

        submitEmail()
        return false;
    }
};