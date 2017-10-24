<%@ Page Language="C#" AutoEventWireup="true" CodeFile="seizure_immobile.aspx.cs" Inherits="seizure_immobile" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars2" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars2" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars2" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxRefer.ascx" TagName="TextBoxRefer" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxScanner.ascx" TagName="TextBoxScanner" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Виконання арешту</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
    <base target="_self" />
    <style type="text/css">
        .hand {cursor:pointer;}
    </style>
</head>
<body>


    <form id="formOperationList" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
    </asp:ScriptManager>
   
   <script type="text/javascript">
       
     function close_window()
     {
         window.returnValue = true; window.close();
     }
     </script>

    <div class="pageTitle">
        <asp:Label ID="lbTitle" runat="server" Text="Арешт коштів" />
    </div>
    <asp:Panel ID="pnSum" GroupingText="Дані про арешт:" runat="server" Style="margin-left: 10px; margin-right: 10px" Enabled="true">
        <table>
            <tr>
                <td>
                    <asp:Label ID="lbFULL" runat="server" Text="Доступно коштів"></asp:Label>
                </td>
                <td>
                    <Bars2:BarsNumericTextBox ID="tbSUM_FULL" runat="server" Enabled="false"></Bars2:BarsNumericTextBox>
                </td>
            </tr>
            <tr>
                <td>
                     <asp:Label ID="lbSumSeizure" runat="server" Text="Сума арешту:"></asp:Label>
                </td>
                <td>
                    <Bars2:BarsNumericTextBox ID="tbSumSeizure" runat="server" MinValue="0.00"></Bars2:BarsNumericTextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbComments" runat="server" Text="Привід для арешту:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbComments" runat="server" TextMode="MultiLine" Rows="3" Width="250" OnTextChanged="tbComments_TextChanged" AutoPostBack="true"></asp:TextBox>
                </td>
            </tr>
        </table>
    </asp:Panel>
        
        <asp:Panel  ID="pnAlien" GroupingText="Реквізити виконавчої служби:" runat="server" Style="margin-left: 10px;
        margin-right: 10px">
        <table>
           <tr>
            <td>
                <asp:Label ID="lbSender" runat="server" Text="Власник вкладу:"></asp:Label>
            </td>
            <td>
                <asp:Label ID="tbSender" runat="server" Enabled="false"></asp:Label>
            </td>
            </tr>
            <tr>
            <td>
                <asp:Label ID="lbNMK_NAME" runat="server" Text="Отримувач:"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="lbNMK" runat="server"></asp:TextBox>
            </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lb_MFO_NAME" runat="server" Text="МФО виконавчого органу:"></asp:Label>
                </td>
                <td>
                   <bec:TextBoxRefer ID="lbMFO" runat="server" TAB_NAME="BANKS" KEY_FIELD="MFO" SEMANTIC_FIELD="NB" IsRequired="false" WHERE_CLAUSE="WHERE MFO like '8%' and blk=0" /> 
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbOKPO_NAME" runat="server" Text="ОКПО виконавчого органу:"></asp:Label>
                </td>
                <td>
                    <Bars2:BarsTextBox ID="lbOKPO" runat="server" MaxLength="8"></Bars2:BarsTextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbKV_NAME" runat="server" Text="Валюта:"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lbKV" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbNLS_NAME" runat="server" Text="Рахунок виконавчого органу:"></asp:Label>
                </td>
                <td>
                     <Bars2:BarsTextBox ID="tbNLS" runat="server"  Font-Size="10" Width="150Px" OnTextChanged="tbNLS_TextChanged" AutoPostBack="true" MaxLength="14"></Bars2:BarsTextBox>
                </td>
            </tr>
            
        </table>
          
    </asp:Panel>
    
    <asp:Panel  ID="pnPay" GroupingText="Виконання дій:" runat="server" Style="margin-left: 10px;
        margin-right: 10px">
        <tr>
            <td>
                <asp:ImageButton runat="server" ID="bt_back" ToolTip="Перечитати" OnClick="bt_Cencel_Click" ImageUrl="\Common\Images\default\24\refresh.png"/>
            </td>
            <td>
                <asp:ImageButton runat="server" ID="bt_save" ToolTip="Зберегти" OnClick="bt_save_Click" ImageUrl="\Common\Images\default\24\disk_gray.png"/>
            </td>
            <td>
                <asp:ImageButton runat="server" ID="bt_pay" ToolTip="Оплатити" ImageUrl="\Common\Images\default\24\check_gray.png" OnClick="bt_pay_Click"  />
            </td>
        </tr>
    </asp:Panel>
        <table>
            <tr>
                <td>
                    <asp:Label ID="lbERR" runat="server" ForeColor="#f00c00"></asp:Label>
                </td>
            </tr>

        </table>
   </form>
</body>
</html>
