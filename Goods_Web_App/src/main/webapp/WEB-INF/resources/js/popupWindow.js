var LIST_PRODUCTS = "/listProducts";
$(document).ready(function() {
    var table = $('table');
    //ЗАГРУЖАЕМ ТАБЛИЧКУ ПРИ ПЕРВОМ ОБРАЩЕНИИ К СТРАНИЦЕ
    $.ajax({
        type: "GET",
        url: LIST_PRODUCTS,
        dataType: "json",
        async: true,
        success: function (result) {
            for (var i in result) {
                var str = "<tr>";
                for (var prop in result[i]) {
                    str += "<td>" + result[i][prop] + "</td>";
                }
                str += "<td><a href='#deleted' data-id='" + result[i].id + "' class='delete'>delete</a></td>";
                str += "<td><a href='#edit' data-id='" + result[i].id + "' class='edit'>edit</a></td>";
                str += "</tr>";
                table.append(str);
            }
        },
        error: function () {
            alert("Exception on out");
        }
    });


    //РЕДАКТИРОВАНИЕ
    $(document).on('click', '.edit', function () {
        $('.js-overlay-edit').fadeIn();
        $('.js-overlay-edit').addClass('disable');
        var row = $(this).closest('td').parent();
        var id = $("td", row).eq(0);
        var name = $("td", row).eq(1);
        var description = $("td", row).eq(2);
        var create_date = $("td", row).eq(3);
        var place_storage = $("td", row).eq(4);
        var reserved = $("td", row).eq(5);

        $('#id2').val(id.text());
        $('#name2').val(name.text());
        $('#description2').val(description.text());
        $('#create_date2').val(create_date.text());
        $('#place_storage2').val(place_storage.text());
        /*$("input[name='reserved2']").attr('checked', reserved.val());*/
        /*$(":radio[name=reserved2]").attr('checked', reserved.text());*/
        if(reserved.text()+"" === 'false')
            $('#no2').attr("checked", reserved.val());
        else
            $('#yes2').attr("checked", reserved.val());
    });

    $('#formEdit').submit(function () {
        updateAjaxForm();
        $("#reset2").click();
        $('.js-overlay-edit').fadeOut();
        event.preventDefault();
    });

    function updateAjaxForm() {
        var DATA = {
            id: $("#id2").val(),
            name: $("#name2").val(),
            description: $("#description2").val(),
            create_date: $("#create_date2").val(),
            place_storage: $("#place_storage2").val(),
            reserved: $("input[name='reserved2']:checked").val()
        };

        $.ajax({
            url: LIST_PRODUCTS + "/updateProduct",
            type: "PUT",
            data: JSON.stringify(DATA),
            dataType: "json",
            contentType:"application/json; charset=utf-8",
            async: true,
            success: function (response) {
                var row = $("td").filter(function() {
                    return $(this).text() === response.id +"";
                }).closest("tr");
                $("td", row).eq(1).html(response.name);
                $("td", row).eq(2).html(response.description);
                $("td", row).eq(3).html(response.create_date);
                $("td", row).eq(4).html(response.place_storage);
                if(response.reserved+"" === 'false')
                    $("td", row).eq(5).html('false');
                else
                    $("td", row).eq(5).html('true');
            },
            error: function (response) {
                alert("Exception in UPDATE")
            }
        });
    }


    $('#form').submit(function () {
        sendAjaxForm();
        $("#reset").click();
        event.preventDefault();
    });

    function sendAjaxForm() {
        var DATA = {
            name: $("#name").val(),
            description: $("#description").val(),
            create_date: $("#create_date").val(),
            place_storage: $("#place_storage").val(),
            reserved: $("input[name='reserved']:checked").val()
        };

        $.ajax({
            url: LIST_PRODUCTS + "/create",
            type: "POST",
            data: JSON.stringify(DATA),
            dataType: "json",
            contentType:"application/json; charset=utf-8",
            async: true,
            success: function (response) {
                table.append(
                    "<tr>" +
                    "<td>" + response.id +            "</td>"+
                    "<td>" + response.name +          "</td>"+
                    "<td>" + response.description +   "</td>"+
                    "<td>" + response.create_date +   "</td>"+
                    "<td>" + response.place_storage + "</td>"+
                    "<td>" + response.reserved +      "</td>"+
                    "<td><a href='#deleted' data-id='" + response.id + "' class='delete'>delete</a></td>" +
                    "<td><a href='#edit' data-id='" + response.id + "' class='js-button-edit'>edit</a></td>" +
                    "</tr>");
            },
            error: function (response) {
                alert("Exception in SEND")
            }
        });
    }

    //УДАЛЕНИЕ
    $(document).on('click', '.delete', function () {
        var row = $(this).closest('td').parent();
        console.log($(this).attr("data-id"));
        $.ajax({
            type: "DELETE",
            url: LIST_PRODUCTS + "/delete/" + $(this).attr("data-id"),
            async: true,
            success: function (response) {
                row.remove();
            },
            error: function (response) {
                alert("Exception in DELETE")
            }
        });
    });

    //ОТКРЫТИЕ/ЗАКРЫТИЕ ВСПЛЫВАЮЩЕГО ОКНА
    $('.js-button-create').click(function() {
        $('.js-overlay-create').fadeIn();
        $('.js-overlay-create').addClass('disabled');
    });

    $('.js-close-create').click(function() {
        $('#reset').click();
        $('.js-overlay-create').fadeOut();
    });

    $('.js-button-edit').click(function() {
        $('.js-overlay-edit').fadeIn();
        $('.js-overlay-edit').addClass('disabled');
    });

    $('.js-close-edit').click(function() {
        $('#reset2').click();
        $('.js-overlay-edit').fadeOut();
    });
});
