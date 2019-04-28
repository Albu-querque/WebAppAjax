<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
    <head>
        <title>Список продуктов</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <style>
            <%@ include file="/WEB-INF/resources/css/stylesForTable.css"%>
            <%@ include file="/WEB-INF/resources/css/stylesForPopupWindow.css"%>
            <%@ include file="/WEB-INF/resources/css/common.css"%>
        </style>

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
              integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
              crossorigin="anonymous">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
        <script src="/WEB-INF/resources/js/popupWindow.js"></script>

        <script>
            var LIST_PRODUCTS = "/listProducts";

            $(document).ready(function() {

                var table = $('table');
                var loadDataFromDB =$.ajax({
                                    type: "GET",
                                    url: LIST_PRODUCTS,
                                    dataType: "json",
                                    async: true,
                                    success: function (result) {
                                        for(var i in result) {
                                            var str = "<tr>";
                                            for(var prop in result[i]){
                                                str += "<td>" + result[i][prop] + "</td>";
                                            }
                                            str += "<td><a href='/' data-id='" + result[i].id + "' class='delete'>удалить</a></td>";
                                            str += "<td><a href='/' data-id='" + result[i].id + "' class='edit'>редактировать</a></td>";
                                            str += "</tr>";
                                            table.append(str);
                                        }
                                    },
                                    error: function () {
                                        alert("Exception on out");
                                    }
                                });



                $(document).on('click', '.delete', function () {
                    var row = $(this).closest('td').parent();
                    console.log($(this).attr("data-id"));
                    $.ajax({
                        type: "DELETE",
                        url: LIST_PRODUCTS + "/delete/" + $(this).attr("data-id"),
                        async: true,
                        success: function (result) {
                            loadDataFromDB();
                        },
                        error: function (result) {
                            alert("Exception in DELETE")
                        }
                    });
                });

                $('#form').submit(function () {
                    sendAjaxForm();
                    console.log(response);
                });

                function sendAjaxForm() {
                    var DATA = {
                        name: $("#name").val(),
                        description: $("#description").val(),
                        create_date: $("#create_date").val(),
                        place_storage: $("#place_storage").val(),
                        reserved: $("#reserved").val()
                    };

                    $.ajax({
                        url: LIST_PRODUCTS + "/create",
                        type: "POST",
                        /*data: $('#form').serialize(),*/
                        data: JSON.stringify(DATA),
                        dataType: "json",
                        contentType:"application/json; charset=utf-8",
                        async: true,
                        success: function (response) {
                            loadDataFromDB();
                        }
                    });
                }

                $('.js-button-campaign').click(function() {

                    $('.js-overlay-campaign').fadeIn();
                    $('.js-overlay-campaign').addClass('disabled');
                });

                // закрыть на крестик
                $('.js-close-campaign').click(function() {
                    $('.js-overlay-campaign').fadeOut();

                });
            });
        </script>

        <%--<script>
            $('#create_date').mask('11/11/1111');
        </script>--%>

    </head>
   <body class="center">

        <div class="container">
            <div class="row">
                <table class="table table-dark">
                    <th class="WH">ID</th>
                    <th class="WH">Наименование</th>
                    <th class="WH">Описание</th>
                    <th class="WH">Дата создания</th>
                    <th class="WH">Место хранения</th>
                    <th class="WH">Зарезервирован</th>
                    <th></th>
                    <th></th>
                </table>
            </div>
            <div class="row">
                <div class="button js-button-campaign"><span>Добавить</span></div>
            </div>
        </div>




        <div class="overlay js-overlay-campaign">
            <div class="popup js-popup-campaign" >
                <form id="form" action="">
                    <label id="forName" for="name">Наименование товара</label>
                    <input type="text" name="name" id="name" required placeholder="Введите имя"><br/>

                    <label id="forDescription" for="description">Описание</label>
                    <textarea style="resize: none" name="description" id="description" placeholder="Введите описание"></textarea><br/>

                    <label id="forDate" for="create_date">Дата</label>
                    <input type="date" name="create_date" id="create_date" required placeholder="Введите дату"><br/>

                    <label id="forPlace_storage" for="place_storage">Номер ячейки</label>
                    <input type="number" name="place_storage" id="place_storage" required placeholder="Введите номер ячейки"><br/>

                    <label id="forReserved" for="yes">Зарезервирован: </label>
                    <input type="radio" name="reserved" id="yes" value="true">Да
                    <input type="radio" name="reserved" id="no" value="false">Нет<br/>

                    <button type="submit" id="btn" class="btn btn-success">Сохранить</button>
                    <button type="reset" id="reset" class="btn btn-danger">Очистить поля</button>
                </form>
                <div class="close-popup js-close-campaign"></div>
            </div>
        </div>

        <div class="overlay js-overlay-campaign">
            <div class="popup js-popup-campaign" >
                <form id="formEdit" action="">
                    <label id="forName2" for="name2">Наименование товара</label>
                    <input type="text" name="name2" id="name2" required placeholder="Введите имя"><br/>

                    <label id="forDescription2" for="description">Описание</label>
                    <textarea style="resize: none" name="description2" id="description2" placeholder="Введите описание"></textarea><br/>

                    <label id="forDate2" for="create_date2">Дата</label>
                    <input type="date" name="create_date2" id="create_date2" required placeholder="Введите дату"><br/>

                    <label id="forPlace_storage2" for="place_storage2">Номер ячейки</label>
                    <input type="number" name="place_storage2" id="place_storage2" required placeholder="Введите номер ячейки"><br/>

                    <label id="forReserved2" for="yes">Зарезервирован: </label>
                    <input type="radio" name="reserved2" id="yes2" value="true">Да
                    <input type="radio" name="reserved2" id="no2" value="false">Нет<br/>

                    <button type="submit" id="btn2">редактировать</button>
                </form>
                <div class="close-popup js-close-campaign"></div>
            </div>
        </div>

    </body>
</html>
