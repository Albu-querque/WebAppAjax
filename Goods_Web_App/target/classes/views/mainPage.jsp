<%--
  Created by IntelliJ IDEA.
  User: albuquerque
  Date: 23.04.19
  Time: 21:08
  To change this template use File | Settings | File Templates.
--%>
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
                var loadDataFromDB = $.ajax({
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
                                str += "</tr>";
                                table.append(str);
                            }
                        },
                        error: function () {
                            alert("Exception on out");
                        }
                    });


                $('#btn').click(function () {
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
                        data: JSON.stringify(DATA),
                        dataType: "json",
                        success: function (response) {
                            console.log(response);
                            loadDataFromDB();
                        },
                        error: function (response) {
                            alert("Exception in send" + response)
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

        <script>
            $('#create_date').mask('11/11/1111');
        </script>

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
                </table>
            </div>
        </div>



        <div class="button js-button-campaign"><span>Акция</span></div>


        <div class="overlay js-overlay-campaign">
            <div class="popup js-popup-campaign" >
                <form id="form">
                    <input type="text" name="id" id="id" placeholder="ID" readonly><br/>

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

                    <button type="submit" id="btn">Сохранить</button>
                </form>
                <div class="close-popup js-close-campaign"></div>
            </div>
        </div>

    </body>
</html>
