<%@ Page Language="C#" AutoEventWireup="true" CodeFile="docparams_bulk.aspx.cs" Inherits="finmon_docparams_bulk" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEX" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Параметри фінансового моніторингу</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="Styles.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/BarsGridView.css" type="text/css" rel="stylesheet" />
    <base target="_self" />
</head>
<script language="javascript" type="text/javascript">

    window.onunload = Close;
    function Close() {
        var vReturnValue = new Object();
        vReturnValue.close = "ok";
        window.returnValue = vReturnValue;
    }

    
    function OpenKdfm02() {

        var dialogRefKdfm02Return = window.showModalDialog('/barsroot/finmon/refkdfm02.aspx', window, 'center:{yes};dialogheight:650px;dialogwidth:780px');

        if (dialogRefKdfm02Return.code != -1) {
            document.getElementById('<%=tbKDFM02.ClientID%>').value = dialogRefKdfm02Return.code;
         }
     }
     function AdditionalKdfm02() {
         var dialogRefKdfm02Return = window.showModalDialog('/barsroot/finmon/refkdfm02.aspx', window, 'center:{yes};dialogheight:650px;dialogwidth:780px');

         if (dialogRefKdfm02Return.code != -1) {
             document.getElementById('<%=MandatoryCodesTextBox.ClientID%>').value += dialogRefKdfm02Return.code + " ";
        }
    }

    function OpenKdfm03() {

        var dialogRefKdfm03Return = window.showModalDialog('/barsroot/finmon/refkdfm03.aspx', window, 'center:{yes};dialogheight:650px;dialogwidth:780px');;

        if (dialogRefKdfm03Return.code != -1) {
            document.getElementById('<%=tbKDFM03.ClientID%>').value = dialogRefKdfm03Return.code;
        }
    }
    function AdditionalKdfm03() {
        var dialogRefKdfm03Return = window.showModalDialog('/barsroot/finmon/refkdfm03.aspx', window, 'center:{yes};dialogheight:650px;dialogwidth:780px');;

        if (dialogRefKdfm03Return.code != -1) {
            document.getElementById('<%=InCodesTextBox.ClientID%>').value += dialogRefKdfm03Return.code + " ";
        }
    }


    function OpenCodeType() {

        var code = document.getElementById('<%=tbCode.ClientID%>').value;

        if (code.length != 15) {
            alert('Довжина коду виду фінансової операції має бути довжиною 15символів');
        }
        else {
            var dialogCodeTypeReturn = window.showModalDialog('/barsroot/finmon/codetype.aspx?code=' + code, window, 'center:{yes};dialogheight:600px;dialogwidth:550px');;

            if (dialogCodeTypeReturn.code != null) {
                document.getElementById('<%=tbCode.ClientID%>').value = dialogCodeTypeReturn.code;
            }
        }
    }

    ///Перевірка на числа і пробіл
    function isNumberKey(evt)
    {
        debugger;
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode > 32 && (charCode < 48 || charCode > 57))
        return false;    
        return true;
    }

    ///Перевірка на числа
    function isNumberKeyOnly(evt)
      {
         debugger;
         var charCode = (evt.which) ? evt.which : evt.keyCode;
         if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;    
         return true;
      }


</script>
<body bgcolor="#f0f0f0">
    <form id="formFinMonFilter" runat="server">
        <asp:Label ID="errLbl" runat="server" Text="" ForeColor="Red"></asp:Label>
        <div class="pageTitle">
            <asp:Label ID="lbTitle" runat="server" Text="Параметри фінансового моніторингу"></asp:Label>
        </div>
        <asp:Panel ID="pnCharacter" runat="server" GroupingText="Ознака повідомлень:">
            <table>
                <tr>
                    <td>
                        <asp:CheckBox ID="cbCompulsoryMon" runat="server" OnCheckedChanged="cbCompulsoryMon_CheckedChanged" AutoPostBack="true"/>
                    </td>
                    <td style="width: 160px">
                        <asp:Label ID="lbCompulsoryMon" runat="server" Text="Обов'язковий моніторинг"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbKDFM02" runat="server" MaxLength="4" Width="40px" EnabledStyle-HorizontalAlign="Center" AutoPostBack="false"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbKDFM02_Name" runat="server" Text="не заповнено (вн.моніторинг)" ReadOnly="true" Width="320px"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <bars:ImageTextButton ID="ibKDFM02" runat="server" ImageUrl="/common/images/default/16/find.png" OnClientClick="OpenKdfm02()" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbDummy" runat="server"></asp:Label>
                    </td>
                    <td>
                        
                    </td>
                    <td colspan="3">
                        <Bars2:BarsTextBox ID="tbPlus" runat="server" Width="400px"></Bars2:BarsTextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbDummy2" runat="server"></asp:Label>
                    </td>
                    <td>
                       
                    </td>
                    <td colspan="3">
                        <asp:Label ID="Label1" runat="server" Text="Додаткові коди моніторингу "></asp:Label>
                        <Bars2:BarsTextBox ID="MandatoryCodesTextBox" 
                            runat="server" 
                            Width="380px"
                            onkeypress="return isNumberKey(event)"/>

                        <bars:ImageTextButton ID="ImageTextButton2" runat="server" ImageUrl="/common/images/default/16/find.png" Enabled="true" OnClientClick="AdditionalKdfm02()" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:CheckBox ID="cbInternalMob" runat="server" OnCheckedChanged="cbInternalMob_CheckedChanged" AutoPostBack="true" />
                    </td>
                    <td>
                        <asp:Label ID="lbInternalMob" runat="server" Text="Внутрішній моніторинг"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbKDFM03" runat="server" MaxLength="3" Width="40px" EnabledStyle-HorizontalAlign="Center" Enabled="false" AutoPostBack="false"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbKDFM03Name" runat="server" ReadOnly="true" Text="не заповнено (вн.моніторинг)" Width="320px" Enabled="false"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <bars:ImageTextButton ID="ibKDFM03" runat="server" ImageUrl="/common/images/default/16/find.png" Enabled="false" OnClientClick="OpenKdfm03()" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbDummy3" runat="server"></asp:Label>
                    </td>
                    <td>
                       
                    </td>
                    <td colspan="3">
                        <Bars2:BarsTextBox ID="tbPlus2" runat="server" Width="400px" Enabled="false"></Bars2:BarsTextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbDummy4" runat="server"></asp:Label>
                    </td>
                    <td>
                       
                    </td>
                    <td colspan="3">
                        <asp:Label ID="Label2" runat="server" Text="Додаткові коди моніторингу "></asp:Label>
                        <Bars2:BarsTextBox ID="InCodesTextBox" runat="server" Width="380px" Enabled="false" onkeypress="return isNumberKey(event)"></Bars2:BarsTextBox>


                        <bars:ImageTextButton ID="ImageTextButton1" 
                            runat="server" 
                            ImageUrl="/common/images/default/16/find.png" 
                            Enabled="true" 
                            OnClientClick="AdditionalKdfm03()" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnDailyMon" runat="server" GroupingText="Режим моніторінгу клієнтів:">
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lbDummy5" runat="server"></asp:Label>
                    </td>
                    <td style="width: 180px">
                        <asp:RadioButton ID="rbDailySideA" runat="server" Text="Сторона A" AutoPostBack="true" OnCheckedChanged="rbDailySideA_CheckedChanged" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbDummy6" runat="server"></asp:Label>
                    </td>
                    <td>
                        <asp:RadioButton ID="rbDailySideB" runat="server" Text="Сторона B" AutoPostBack="true" OnCheckedChanged="rbDailySideB_CheckedChanged" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbDummy7" runat="server"></asp:Label>
                    </td>
                    <td>
                       
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <table>
            <tr align="left">
                <td style="width: 180px">
                    <asp:Label ID="lbCode" runat="server" Text="Код виду фінансової операції" Width="188px"></asp:Label>
                </td>
                <td>
                    <Bars2:BarsTextBox ID="tbCode" 
                        runat="server" 
                        EnabledStyle-HorizontalAlign="Center" 
                        MaxLength="15" 
                        Width="370px" 
                        Enabled="true" 
                        onkeypress="return isNumberKeyOnly(event)"/>

                    <asp:RegularExpressionValidator ID="regexpName" runat="server"     
                                    ErrorMessage="Введіть будь ласка 15 чисел" 
                                    ControlToValidate="tbCode"     
                                    ValidationExpression="^(\d{15})$" />
                </td>
                <td>
                    <bars:ImageTextButton ID="ibtCode" runat="server" ImageUrl="/common/images/default/16/find.png" OnClientClick="OpenCodeType()" />
                </td>
            </tr>
        </table>

        <p></p>
        <table width="100%">
            <tr>
                <td align="center" style="width: 50%">
                    <cc1:ImageTextButton ID="btOK" runat="server" Text="Зберегти" ImageUrl="/common/images/default/16/ok.png" Enabled="false" OnClick="btOK_Click" />
                </td>
                <td align="center" style="width: 50%">
                    <cc1:ImageTextButton ID="btCancel" runat="server" Text="Відмінити" ImageUrl="/common/images/default/16/cancel.png" OnClick="btCancel_Click" />
                </td>
            </tr>
        </table>
        <asp:ScriptManager ID="sm" runat="server" EnablePageMethods="true" EnableScriptGlobalization="false" EnableScriptLocalization="True">
            <Services>
                <asp:ServiceReference Path="~/finmon/finmonFilterService.asmx" />
            </Services>
        </asp:ScriptManager>
    </form>
</body>
</html>