<%@ Page Language="c#" CodeFile="DepositAgreementPrint.aspx.cs" AutoEventWireup="true" Inherits="DepositAgreementPrint" %>

<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<%@ Register Src="~/UserControls/EADoc.ascx" TagName="EADoc" TagPrefix="uc" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagPrefix="uc" TagName="TextBoxDate" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDecimal.ascx" TagPrefix="uc" TagName="TextBoxDecimal" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Депозитний модуль: Друк додаткових угод</title>
    <link rel="stylesheet" type="text/css" href="/barsroot/deposit/style/dpt.css" />
    <link rel="stylesheet" type="text/css" href="/Common/CSS/jquery/jquery.css" />
    <script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
    <script type="text/javascript" language="javascript" src="/barsroot/deposit/js/js.js"></script>
    <script language="javascript" type="text/jscript" src="/barsroot/credit/jscript/JScript.js?v=1.0"></script>
    <script language="javascript" type="text/javascript" src="/Common/jquery/jquery.js"></script>
    <script language="javascript" type="text/javascript" src="/Common/jquery/jquery-ui.js"></script>
    <style type="text/css">
        .tbl {
        }

            .tbl .td_caption {
                text-align: center;
                padding-bottom: 10px;
            }

            .tbl .td_title {
                width: 250px;
            }

            .tbl .td_separator {
                padding-top: 10px;
                padding-bottom: 10px;
                vertical-align: central;
                text-align: center;
            }

            .tbl .td_separator hr {
                color: #B1B1B1;
                height: -13px;
                width: 100%;
        }
    </style>
  <script>
    $(function () { $('#cblAlowedOperations_7').on('change',function() { cblAlowedOperationsOtherChange(this); }); });
    function cblAlowedOperationsOtherChange(elem) {
      var input = document.getElementById('cblAlowedOperationsOther');
      var checkBox = elem;//document.getElementById('cblAlowedOperations_7');
      input.value = '';
      if (checkBox.checked == true) {
        input.style.display = 'block';
      } else {
        input.style.display = 'none';
      }
    }
  </script>
</head>
<body>
    <form id="Form1" method="post" runat="server">
        <ajax:ToolkitScriptManager ID="sm" runat="server" EnablePageMethods="true">
        </ajax:ToolkitScriptManager>
        <table border="0" class="tbl">
            <tr>
                <td colspan="2" class="td_caption">
                    <asp:Label ID="lbTitle" Text="Друк додугоди" meta:resourcekey="lbTitle6" runat="server" CssClass="InfoLabel" />
                </td>
            </tr>
            <tr>
                <td class="td_title">
                    <asp:Label ID="lbDpt" meta:resourcekey="lbDpt" runat="server" CssClass="InfoText" Text="Депозитний договір №" />
                </td>
                <td>
                    <asp:TextBox ID="textDptNum" runat="server" Enabled="false" CssClass="InfoText" />
                </td>
            </tr>
            <tr>
                <td class="td_title">
                    <asp:Label ID="lbAgrType" Text="Тип додугоди" meta:resourcekey="lbAgrType" runat="server" CssClass="InfoText" />
                </td>
                <td>
                    <asp:TextBox ID="textAgrType" runat="server" Enabled="false" CssClass="InfoText" Width="350px"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="td_title">
                    <asp:Label ID="Label1" Text="Дата заключення" meta:resourcekey="Label1_4" runat="server" CssClass="InfoText" />
                </td>
                <td>
                    <uc:TextBoxDate runat="server" ID="dtDate" Enabled="false" />
                </td>
            </tr>
            <tr id="trDover1" runat="server" visible="false">
                <td class="td_title">
                    <asp:Label ID="lbDuration" runat="server" CssClass="InfoText" Text="Термін дії довіреності - З" />
                </td>
                <td>
                    <uc:TextBoxDate runat="server" ID="dtBegin" MinValue="01/01/2010" TabIndex="101" IsRequired="true" ValidationGroup="Params" />
                </td>
            </tr>
            <tr id="trDover2" runat="server" visible="false">
                <td class="td_title">
                    <asp:Label ID="Label2" runat="server" CssClass="InfoText" Text="Термін дії довіреності - ПО" />
                </td>
                <td>
                    <uc:TextBoxDate runat="server" ID="dtEnd" MinValue="01/01/2010" TabIndex="102" IsRequired="false" ValidationGroup="Params" />
                </td>
            </tr>
            <tr id="trDover3" runat="server" visible="false">
                <td class="td_title">
                    <asp:Label ID="lbMandateAmount" runat="server" CssClass="InfoText" Text="Сума доручення" />
                </td>
                <td>
                    <uc:TextBoxDecimal runat="server" ID="nmAmount" TabIndex="103" ValidationGroup="Params" />
                </td>
            </tr>
            <tr id="trDover4" runat="server" visible="false">
                <td class="td_title">
                    <asp:Label ID="lbAlowedOperations" runat="server" CssClass="InfoText" Text="Дозволенні операції" />
                </td>
                <td>
                    <asp:CheckBoxList ID="cblAlowedOperations" runat="server" TabIndex="104">                        
                    </asp:CheckBoxList>
                    <input id="cblAlowedOperationsOther" type="text" onchange="cblAlowedOperationsOther_Click" runat="server" style="display: none;width: 100%"/>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="td_separator">
                    <hr />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btCreate" runat="server" CssClass="AcceptButton"
                        TabIndex="201" Text="Створити" CausesValidation="true" ValidationGroup="Dates" OnClick="btCreate_Click" />
                </td>
                <td>
                    <asp:Button ID="btPrint" meta:resourcekey="btPrint" runat="server" class="AcceptButton"
                        TabIndex="202" Text="Друк" CausesValidation="false" />
                    <uc:EADoc ID="EADocPrint" runat="server" TitleText="Друк" TabIndex="203"
                        CausesValidation="true" ValidationGroup="Params"
                        OnBeforePrint="EADocPrint_BeforePrint" OnDocSigned="EADocPrint_DocSigned" />
                </td>
            </tr>
            <tr>
                <td colspan="2" class="td_separator">
                    <hr />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Button ID="btNextAgr" meta:resourcekey="btNextAgr" runat="server" CssClass="AcceptButton"
                        TabIndex="301" Text="Повернутись" ToolTip="Повернутися до картки депозиту"
                        CausesValidation="false" OnClick="btNextAgr_Click" />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
