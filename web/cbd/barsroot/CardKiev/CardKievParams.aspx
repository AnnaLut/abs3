<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CardKievParams.aspx.cs" Inherits="CardKievCardKievParams"%>
<%@ Register TagPrefix="uc1" TagName="textboxscanner" Src="~/credit/usercontrols/TextBoxScanner.ascx" %>
<%@ Register Src="~/credit/usercontrols/ByteImage.ascx" TagName="ByteImage" TagPrefix="bec" %>
<%@ Register Src="../credit/usercontrols/TextBoxRefer.ascx" TagName="TextBoxRefer" TagPrefix="Bars" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Параметри КК</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="Styles.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/BarsGridView.css" type="text/css" rel="stylesheet" />
    <link href="../Content/Themes/ModernUI/css/jquery-ui.css" type="text/css" rel="Stylesheet"/>
    <asp:PlaceHolder runat="server">
        <script src="../documentsview/Script.js" type="text/javascript"></script>
        <script type="text/javascript" src="../Scripts/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="../Scripts/jquery/jquery-ui.min.js"></script>
        <script type="text/javascript" src="../Scripts/jquery/jquery.bars.ui.js"></script>
        <script src="../documentsview/Script.js" type="text/javascript"></script>
        <script>
            var custRegistrationTypeChange = function () {
                var $lblRegistration = $('#lblCustRegistrationCaption');
                if ($('#REGISTER_TYPE option:selected').val() == 1) {
                    $lblRegistration.text("Адреса реєстрації");
                } else {
                    $lblRegistration.text("Адреса організації");
                }
            }

            var streets = [];
            var strTypes = [];
            var areas = [];

            var kievStreetList = [];

            var makeCompleteSteetList = function() {
                for (var s = 0; s < streets.length; s++) {
                    var streetTypes = $.grep(strTypes, function (e) { return e.ID == streets[s].STREET_TYPE_ID; });
                    var streetAreas = $.grep(areas, function (e) { return e.ID == streets[s].CITY_AREA_ID; });
                    var text = (streetTypes && streetTypes.length > 0 ? streetTypes[0].VALUE : " ") +
                        " " + streets[s].STREET_NAME + " (" +
                        (streetAreas && streetAreas.length > 0 ? streetAreas[0].NAME : "") + ")";
                    kievStreetList.push({ areaid: streets[s].CITY_AREA_ID, typeid: streets[s].STREET_TYPE_ID, value: streets[s].STREET_NAME, label: text });
                }
            }

            $(document).ready(function () {
                custRegistrationTypeChange();
                $.ajax({
                    type: "GET",
                    url: "StreetsOfKiev.ashx",
                    data: { dataType: "streets" },
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        streets = data;
                        $.ajax({
                            type: "GET",
                            url: "StreetsOfKiev.ashx",
                            data: { dataType: "strTypes" },
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                strTypes = data;
                                $.ajax({
                                    type: "GET",
                                    url: "StreetsOfKiev.ashx",
                                    data: { dataType: "areas" },
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (data) {
                                        areas = data;
                                        makeCompleteSteetList();
                                    }
                                });
                            }
                        });
                    }
                });
                
                $('#STREET').autocomplete({
                    source: kievStreetList,
                    select: function(event, ui) {
                        $("#ID_STREET_TYPE_tb").val(ui.item.typeid);
                        $("#ID_STREET_TYPE_h").val(ui.item.typeid);
                        $("#ID_CITY_AREA_tb").val(ui.item.areaid);
                        $("#ID_CITY_AREA_h").val(ui.item.areaid);
                    }
                });
                
            });
        </script>
    </asp:PlaceHolder>
</head>
<body>
    <form id="formKKParams" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:Label runat="server" Font-Size="20px">Картка киянина</asp:Label>
        <asp:Panel ID="pnButtons" runat="server" Style="margin:10px;">
            <asp:Button ID="btnSaveKKParams" runat="server" CausesValidation="False" Text="Далі" OnClick="btnSaveKKParams_Click" />
        </asp:Panel>
        <br/>
        <br/>
        <table>
            <tr style="margin-left:10px;">
                <td>
                    <asp:Label ID="lblNoPhoto" runat="server" Visible="true">Фотографія відсутня</asp:Label>        
                    <img id="kkPhoto" runat="server" alt="" src="" width="240"/>

                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label1" runat="server" Text="Сканування:"></asp:Label> 
                    <uc1:textboxscanner runat="server" id="textBoxScanner" IsRequired="True" OnDocumentScaned="sc_DocumentScaned" ImageHeight="640" ImageWidth="480"  />
                </td>
                <td style="padding-top: 15px; padding-left: 10px;">
                    <asp:Label ID="Label2" runat="server" Text="Слово-пароль:"></asp:Label> <br />
                    <asp:TextBox ID="tbPassWord" runat="server" MaxLength="24" ></asp:TextBox>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <hr />
                </td>
            </tr>
            <tr>
                <td>
                  <asp:Label runat="server" Text="Тип реєстрації громадянина:"></asp:Label>                     
                </td>
                <td colspan="2">
                    <select id="REGISTER_TYPE" runat="server">
                        <option value="1">зареєстрований у місті</option>
                        <option value="2">працює у місті</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <asp:Label ID="lblCustRegistrationCaption" runat="server" Text=""></asp:Label>                     
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <asp:Label ID="Label6" runat="server" Text="Поштовий індекс"></asp:Label> <br />
                    <input runat="server" id="Zip" />                    
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label3" runat="server" Text="Вулиця"></asp:Label> <br />
                    <input runat="server" id="STREET" />                    
                </td>
                <td>
                    <asp:Label ID="Label5" runat="server" Text="Тип вулиці:"></asp:Label>                     
                    <bars:TextBoxRefer ID="ID_STREET_TYPE" runat="server" TAB_NAME="CM_STREET_TYPE" KEY_FIELD="ID" SEMANTIC_FIELD="NAME"
                          IsRequired="true" ValidationGroup="Params" Value='<%# Bind("ID_STREET_TYPE") %>'
                          Enabled="true" />                                                            
                </td>
                <td>
                    <asp:Label ID="Label4" runat="server" Text="Район Києва:"></asp:Label>                     
                    <bars:TextBoxRefer ID="ID_CITY_AREA" runat="server" TAB_NAME="CM_CITY_AREA" KEY_FIELD="ID" SEMANTIC_FIELD="NAME"
                          IsRequired="true" ValidationGroup="Params" Value='<%# Bind("ID_CITY_AREA") %>'
                          Enabled="true" />                                        
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <asp:Label ID="Label7" runat="server" Text="№ будинку"></asp:Label> <br />
                    <input runat="server" id="Build" />                    
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
