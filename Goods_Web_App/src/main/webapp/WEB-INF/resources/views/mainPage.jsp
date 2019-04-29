<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Список продуктов</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="http-equiv" content="Content-type: text/html; charset=UTF-8">
    <style>
        <%@ include file="/WEB-INF/resources/css/stylesForTable.css"%>
        <%@ include file="/WEB-INF/resources/css/stylesForPopupWindow.css"%>
        <%@ include file="/WEB-INF/resources/css/common.css"%>
    </style>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
          crossorigin="anonymous">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>

    <script type="text/javascript" charset="UTF-8">
        <%@include file="../js/popupWindow.js"%>
    </script>

</head>
<body style="background-color: black" class="center">

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
            <div class="btn btn-info js-button-create"><span>Добавить</span></div>
        </div>
    </div>




    <div class="overlay js-overlay-create">
        <div class="popup js-popup-create" >
            <form id="form" action="">
                <div class="main">
                    <div class="field">
                        <label id="forName" for="name">Наименование товара</label>
                        <input type="text" name="name" id="name" required placeholder="Введите имя"><br/>
                    </div>
                    <div class="field">
                        <label id="forDescription" for="description">Описание</label>
                        <textarea style="resize: none" name="description" id="description" placeholder="Введите описание"></textarea><br/>
                    </div>
                    <div class="field">
                        <label id="forDate" for="create_date">Дата</label>
                        <input type="date" name="create_date" id="create_date" required placeholder="Введите дату"><br/>
                    </div>
                    <div class="field">
                        <label id="forPlace_storage" for="place_storage">Номер ячейки</label>
                        <input type="number" name="place_storage" id="place_storage" pattern="[^0\D]\d*" required placeholder="Введите номер ячейки"><br/>
                    </div>
                    <div class="field">
                    <label id="forReserved" for="no">Зарезервирован: </label>
                    <input type="radio" name="reserved" id="yes" value="true">Да
                    <input type="radio" name="reserved" id="no" value="false">Нет
                    </div>
                </div>
                <br/>
                <button type="submit" id="btn" class="btn btn-success">Сохранить</button>
                <button type="reset" id="reset" class="btn btn-danger">Очистить поля</button>
            </form>
            <div class="close-popup js-close-create"></div>
        </div>
    </div>

    <div class="overlay js-overlay-edit">
        <div class="popup js-popup-edit" >
            <form id="formEdit" action="">
                <div class="main">
                    <div class="field">
                        <label id="forId2" for="id2">ID</label>
                        <input style="background-color: lightgrey" type="text" name="id2" id="id2" required readonly><br/>
                    </div>
                    <div class="field">
                        <label id="forName2" for="name2">Наименование товара</label>
                        <input type="text" name="name2" id="name2" required placeholder="Введите имя"><br/>
                    </div>
                    <div class="field">
                        <label id="forDescription2" for="description2">Описание</label>
                        <textarea style="resize: none" name="description2" id="description2" placeholder="Введите описание"></textarea><br/>
                    </div>
                    <div class="field">
                        <label id="forDate2" for="create_date2">Дата</label>
                        <input type="date" name="create_date2" id="create_date2" required placeholder="Введите дату"><br/>
                    </div>
                    <div class="field">
                        <label id="forPlace_storage2" for="place_storage2">Номер ячейки</label>
                        <input type="number" name="place_storage2" id="place_storage2" required placeholder="Введите номер ячейки"><br/>
                    </div>
                    <div class="field">
                        <label id="forReserved2" for="yes2">Зарезервирован: </label>
                        <input type="radio" name="reserved2" id="yes2" value="true">Да
                        <input type="radio" name="reserved2" id="no2" value="false">Нет
                    </div>
                </div>
                <br/>
                <button type="reset" id="reset2" class="btn btn-primary" hidden>reset</button>
                <button type="submit" id="btn2" class="btn btn-primary">Редактировать</button>

            </form>
            <div class="close-popup js-close-edit"></div>
        </div>
    </div>

</body>
</html>
