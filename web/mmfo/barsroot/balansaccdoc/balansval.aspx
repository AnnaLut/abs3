<%@ Page Language="C#" AutoEventWireup="true" CodeFile="balansval.aspx.cs" Inherits="BalansVal" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <LINK href="Style.css" type="text/css" rel="stylesheet">
    <LINK href="\Common\WebGrid\Grid.css" type="text/css" rel="stylesheet">
    <script language="JavaScript" src="Scripts\sBalansVal.js"></script>
    <script language="JavaScript" src="Scripts\Common.js"></script>
    <script language="JavaScript" src="\Common\WebGrid\Grid2005.js"></script>
    <script language="JavaScript" src="\Common\Script\Localization.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <table width="100%">
            <tr>
                <td align="center" style="width: 764px; height: 20px">
                    <asp:Label ID="Label1" runat="server" Text="Состояние БС (ном.) по Валютам" Font-Bold="True" meta:resourcekey="Label1Resource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="width: 764px; height: 20px">
    <div class="webservice" id="webService" showProgress="true"></div>
                </td>
            </tr>
        </table>
        <input runat="server" type="hidden" id="currentPageCulture" meta:resourcekey="currentPageCulture" value="ru" />
        <input runat="server" type="hidden" id="wgPageSizeText" meta:resourcekey="wgPageSizeText" value="Cтрок на странице:" />
        <input runat="server" type="hidden" id="wgPrevPage" meta:resourcekey="wgPrevPage" value="Предыдущая страница" />
        <input runat="server" type="hidden" id="wgNextPage" meta:resourcekey="wgNextPage" value="Следующая страница" />
        <input runat="server" type="hidden" id="wgRowsInTable" meta:resourcekey="wgRowsInTable" value="Количество строк в таблице" />
        <input runat="server" type="hidden" id="wgAscending" meta:resourcekey="wgAscending" value="По возрастанию" />
        <input runat="server" type="hidden" id="wgDescending" meta:resourcekey="wgDescending" value="По убыванию" />
        <input runat="server" type="hidden" id="wgSave" meta:resourcekey="wgSave" value="Сохранить" />
        <input runat="server" type="hidden" id="wgCancel" meta:resourcekey="wgCancel" value="Отмена" />
        <input runat="server" type="hidden" id="wgSetFilter" meta:resourcekey="wgSetFilter" value="Установить фильтр" />
        <input type="hidden" id="wgFilter" value="Фильтр" />
        <input type="hidden" id="wgAttribute" value="Атрибут" />
        <input type="hidden" id="wgOperator" value="Оператор" />
        <input type="hidden" id="wgLike" value="похож" />
        <input type="hidden" id="wgNotLike" value="не похож" />
        <input type="hidden" id="wgIsNull" value="пустой" />
        <input type="hidden" id="wgIsNotNull" value="не пустой" />
        <input type="hidden" id="wgOneOf" value="один из" />
        <input type="hidden" id="wgNotOneOf" value="ни один из" />
        <input type="hidden" id="wgValue" value="Значение" />
        <input type="hidden" id="wgApply" value="Применить" />
        <input type="hidden" id="wgFilterCancel" value="Отменить" />
        <input type="hidden" id="wgCurrentFilter" value="Текущий фильтр:" />
        <input type="hidden" id="wgDeleteRow" value="Удалить строку" />
        <input type="hidden" id="wgDeleteAll" value="Удалить все" />
    </form>
</body>
</html>
