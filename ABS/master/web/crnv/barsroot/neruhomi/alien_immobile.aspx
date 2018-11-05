<%@ Page Language="C#" AutoEventWireup="true" CodeFile="alien_immobile.aspx.cs" Inherits="alien" %>

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
<%@ Register Src="~/credit/usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Реквізити для виплати</title>
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
<body style="width: 550px;">


    <form id="formOperationList" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
    </asp:ScriptManager>
   
   <script type="text/javascript">
     function close_window()
     {
         window.returnValue = true;
         window.close();
     }


     function CheckLength() {
            var textbox = document.getElementById("<%=tbPurposePayment.ClientID%>").value;
            if (textbox.trim().length >= 100) {
                return false;
            }
            else {
                return true;
            }
        }
     </script>

    <div class="pageTitle">
        <asp:Label ID="lbTitle" runat="server" Text="Реквізити для виплати" />
    </div>
    <asp:Panel  ID="pnAlien" GroupingText="Реквізити:" runat="server" Style="margin-left: 10px;
        margin-right: 10px;">
        <table>
        <tr>
            <td>
                 <asp:RadioButton id="rbOwner" runat="server" GroupName="rb_owner_group" Checked="true" OnCheckedChanged="rbOwner_CheckedChanged" AutoPostBack="true"/>
            </td>
            <td>
                <asp:Label ID="lbOwnerName" runat="server" Text=" - власник рахунку" ></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:RadioButton id="rbSpadok" runat="server" GroupName="rb_owner_group" OnCheckedChanged="rbOwner_CheckedChanged" AutoPostBack="true"/>
            </td>
            <td>
                <asp:Label ID="lbSpadokName" runat="server" Text=" - спадкоємець"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:RadioButton id="rbDover" runat="server" GroupName="rb_owner_group" OnCheckedChanged="rbOwner_CheckedChanged" AutoPostBack="true"/>
            </td>
            <td>
                <asp:Label ID="lbDover" runat="server" Text=" - довірена особа"></asp:Label>
            </td>
        </tr>
            <tr>
                <td>

                </td>
            </tr>
         <tr>
            <td>
                <asp:Label ID="lbNMK_NAME" runat="server" Text="Отримувач:"></asp:Label>
            </td>
            <td>
               <asp:TextBox ID="lbNMK" runat="server" Enabled="false" MaxLength="70"></asp:TextBox>
            </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lb_MFO_NAME" runat="server" Text="МФО отримувача:"></asp:Label>
                </td>
                <td>
                   <bec:TextBoxRefer ID="lbMFO" runat="server" TAB_NAME="BANKS" KEY_FIELD="MFO" SEMANTIC_FIELD="NB" IsRequired="true" OnValueChanged="LbMFO_Changed"/> 
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbOKPO_NAME" runat="server" Text="ОКПО отримувача:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="lbOKPO" runat="server" Enabled="false" MaxLength="10" OnTextChanged="lbOKPO_TextChanged" AutoPostBack="true"></asp:TextBox>
		    <asp:RequiredFieldValidator runat="server" id="reqOKPO" controltovalidate="lbOKPO" errormessage="Не заповнено номер ОКПО отримувача!" />
                </td>
            </tr>


              <tr>
	          <td>
             	     <asp:Label ID="lbNMK_PASPN" runat="server" Text="Паспорт №:"></asp:Label>
                  </td>
                  <td>
                     <asp:TextBox ID="txtNMK_PASPN" runat="server" Enabled="false" MaxLength="9"></asp:TextBox>
                  </td>
	      </tr>
	      <tr>
                  <td>
             	     <asp:Label ID="lbNMK_PASPS" runat="server" Text="Паспорт Серія:"></asp:Label>
                  </td>
                  <td>
                     <asp:TextBox ID="txtNMK_PASPS" runat="server" Enabled="false" MaxLength="9"></asp:TextBox>
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
                    <asp:Label ID="lbNLS_NAME" runat="server" Text="Рахунок отримувача:"></asp:Label>
                </td>
                <td>
                     <Bars2:BarsTextBox ID="tbNLS" runat="server"  Font-Size="10" Width="150Px"  OnTextChanged="tbNLS_TextChanged" AutoPostBack="true" MaxLength="14"></Bars2:BarsTextBox>
                     <asp:RequiredFieldValidator id="tbNLS_Validator" runat="server" ControlToValidate="tbNLS" ErrorMessage="Не заповнено рахунок отримувача!"  ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <asp:Panel ID="DopInfo" runat="server" Visible="false">
                <tr>

                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbl_dop_name" runat="server"></asp:Label>
                    </td>
                    <td>
                        <bec:TextBoxString ID="dop_name" runat="server" OnValueChanged="DopInfoValueChanged"></bec:TextBoxString>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbl_dop_okpo" runat="server" Text="РНОКПП:"></asp:Label>
                    </td>
                    <td>
                        <bec:TextBoxString ID="dop_okpo" runat="server" OnValueChanged="DopInfoValueChanged" MaxLength="10"></bec:TextBoxString>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbl_dop_pasp_num" runat="server" Text="Паспорт №:"></asp:Label>
                    </td>
                    <td>
                        <bec:TextBoxString ID="dop_pasp_num" runat="server" OnValueChanged="DopInfoValueChanged"></bec:TextBoxString>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbl_dop_pasp_serial" runat="server" Text="Паспорт серія:"></asp:Label>
                    </td>
                    <td>
                        <bec:TextBoxString ID="dop_pasp_serial" runat="server" OnValueChanged="DopInfoValueChanged"></bec:TextBoxString>
                    </td>
                </tr> 
                <tr>
                    <td>
                        <asp:Label ID="lbl_dop_doc_num" runat="server"></asp:Label>
                    </td>
                    <td>
                        <bec:TextBoxString ID="dop_doc_num" runat="server" OnValueChanged="DopInfoValueChanged"></bec:TextBoxString>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbl_dop_part_of_inheritance" runat="server" Text="Частка спадку"></asp:Label>
                    </td>
                    <td>
                        <bec:TextBoxString ID="dop_part_of_inheritance" runat="server" OnValueChanged="DopInfoValueChanged"></bec:TextBoxString>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbl_dop_doc_date" runat="server"></asp:Label>
                    </td>
                    <td>
                        <bec:TextBoxString ID="dop_doc_date" runat="server" OnValueChanged="DopInfoValueChanged"></bec:TextBoxString>
                    </td>
                </tr>
                <tr>

                </tr>
        </asp:Panel>
	    <tr>
                <td>
                    <asp:Label ID="lbPurposePayment" runat="server" Text="Призначення платежу:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbPurposePayment" runat="server" TextMode="MultiLine" Rows="3" Width="250" Enabled="false" onkeypress="return CheckLength();"  MaxLength="160"></asp:TextBox>
                    <asp:TextBox ID="PurposeLayout" runat="server" Enabled="false" Visible="false"></asp:TextBox>
                </td>
            </tr>

	    <tr>
                <td>
                    <asp:Label ID="lbComments" runat="server" Text="Коментар:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbComments" runat="server" TextMode="MultiLine" Rows="3" Width="250" OnTextChanged="tbComments_TextChanged" AutoPostBack="true"></asp:TextBox>
                </td>
            </tr>

	    

        </table>
            <table>
            <tr>
                <td>
                    <asp:Label ID="lbDescription" runat="server" Text="* - у разі відсутності кода ОКПО чи неправильності його заповнення, необхідно зайти в картку вкладу і відредагувати його. Після цього відредаговані дані, мають бути підтверджені іншим співробітником банку!" ForeColor="#afbcb9"></asp:Label>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="pnSum" GroupingText="Параметри виплати:" runat="server" Style="margin-left: 10px; margin-right: 10px;" Enabled="true">
        <table>
            <tr>
                <td>
                    <asp:RadioButton id="rbFULL" runat="server" GroupName="RB" Checked="true" OnCheckedChanged="rbFULL_CheckedChanged" AutoPostBack="true"/>
                </td>
                <td>
                    <asp:Label ID="lbFULL" runat="server" Text="Вся сума"></asp:Label>
                </td>
                <td>
                    <Bars2:BarsNumericTextBox ID="tbSUM_FULL" runat="server" Enabled="false"></Bars2:BarsNumericTextBox>
                </td>
                
            </tr>
            <tr>
                <td>
                    <asp:RadioButton id="rbPART" runat="server" GroupName="RB" OnCheckedChanged="rbFULL_CheckedChanged" AutoPostBack="true"/>
                </td>
                <td>
                    <asp:Label ID="lbPART" runat="server" Text="Часткова сума"></asp:Label>
                </td>
                <td>
                    <Bars2:BarsNumericTextBox ID="tbSUM_PART" runat="server" Enabled="false" MinValue="0.00"></Bars2:BarsNumericTextBox>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel  ID="pnPay" GroupingText="Виконання дій:" runat="server" Style="margin-left: 10px;
        margin-right: 10px;">
        <tr>
            <td>
                <asp:ImageButton runat="server" ID="bt_back" ToolTip="Перечитати" OnClick="bt_Cencel_Click" ImageUrl="\Common\Images\default\24\refresh.png"/>
            </td>
            <td>
                <asp:ImageButton runat="server" ID="bt_save" ToolTip="Зберегти" OnClick="bt_save_Click" ImageUrl="\Common\Images\default\24\disk_gray.png"/>
            </td>
            <td>
                <asp:ImageButton runat="server" ID="bt_pay" ToolTip="Оплатити" ImageUrl="\Common\Images\default\24\check_gray.png" OnClick="bt_pay_Click" OnclientClick = "close_window();"/>
            </td>
        </tr>
    </asp:Panel>
        <table>
            <tr>
                <td>
                    <asp:Label ID="lbERR" runat="server" ForeColor="#f00c00"></asp:Label>
                </td>
            </tr>
            <asp:HiddenField runat="server" ID="EnableFullPay"/>
            <asp:HiddenField runat="server" ID="ND"/>

        </table>
   </form>
</body>
</html>
