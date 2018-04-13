<%@ Page Language="C#" AutoEventWireup="true" CodeFile="fin_form.aspx.cs" Inherits="credit_fin_form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Введення фінрезу</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
    <script type="text/javascript">
        function select_KVED() {
            var tail = '';
            tail = "D_CLOSE IS NULL OR D_CLOSE >GL.BD";
            var result = window.showModalDialog('dialog.aspx?type=metatab&tail=\'' + tail + '\'&role=WR_CREDIT&tabname=VED',
		             window, "dialogWidth:600px;dialogHeight:600px;center:yes;edge:sunken;help:no;status:no;");
            if (result != null) {

                document.getElementById("tb_kved").value = result[0];

            }
        }
    </script>
</head>
<body>
    <form id="formOperationList" runat="server">
    <div class="pageTitle">
        <asp:Label ID="lbTitle" runat="server" Text="Введення ФІНРЕЗУ" />
    </div>
    <asp:Panel runat="server" ID="pnInfo" GroupingText="Виконання дій" Style="margin-left: 10px;
        margin-right: 10px">
        <table>
            <tr>
                <td>
                    <asp:Label ID="tbOKP" runat="server" Text="ОКПО:" meta:resourcekey="lbCC_IDResource1"></asp:Label>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="tbOKPO" TabIndex="8" ReadOnly="true" BackColor="Azure"
                        Width="100Px" />
                </td>
                <td>
                    <asp:Label ID="tbFr" runat="server" Text="Форма №:" meta:resourcekey="lbFrmResource1"
                        Width="110Px"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxNumb runat="server" ID="tbFrm" TabIndex="9" ReadOnly="true" MaxValue="2"
                        Width="30Px" />
                </td>
                <td>
                    <asp:Label ID="tbDAT" runat="server" Text="Дата:" meta:resourcekey="lbCC_IDResource2"> </asp:Label>
                </td>
                <td>
                    <%--<bec:DDLList ID="tbFDat" runat="server" IsRequired="true" Width="100Px"  BackColor="Azure" /> --%>
                    <asp:DropDownList ID="tbFDat" runat="server" IsRequired="true" Width="100Px" BackColor="Azure" />
                </td>
                <td style="padding-left: 5px; padding-right: 5px; border-right: dotted 1px gray">
                    <asp:ImageButton ID="btRefresh" runat="server" ImageUrl="/Common/Images/default/16/find.png"
                        CausesValidation="false" TabIndex="4" ToolTip="Вибрати дані" OnClick="btRefresh_Click" />
                </td>
                <td style="padding-left: 5px; padding-right: 5px; border-right: dotted 1px gray">
                    <asp:ImageButton ID="btOk" runat="server" ImageUrl="/Common/Images/default/16/save.png"
                        CausesValidation="true" TabIndex="7" ToolTip="Виконати" OnClick="btOk_Click"
                        Width="16px" />
                    <%--OnClientClick='return confirm("Ви дійсно бажаєте зберегти?")'--%>
                </td>
                <td style="padding-left: 5px; padding-right: 5px; border-right: dotted 1px gray">
                    <asp:ImageButton ID="BtPrint" runat="server" ImageUrl="/Common/Images/default/16/print.png"
                        CausesValidation="false" TabIndex="7" ToolTip="Друк форми в форматі XLS" OnClientClick='return confirm(" Увага.\n Друк необхідно проводити після збереження даних!!! \n Продовжити?")'
                        Width="16px" OnClick="BtPrint_Click" />
                </td>
                <td style="padding-left: 5px; padding-right: 5px; border-right: dotted 1px gray">
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="/Common/Images/default/16/arrow_left.png"
                        CausesValidation="false" TabIndex="7" ToolTip="повернутись на попередню сторінку"
                        OnClick="backToFolders" Width="16px" />
                </td>
                <td>
                    <asp:TextBox ID="t_read" runat="server" Width="23px" Visible="false"></asp:TextBox>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td>
                    <asp:Label ID="lb_kol" runat="server" Text="Середня кількість працівників"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tb_kol" runat="server" MaxLength="10" Style="text-align: right"
                        Width="100Px">
                    </asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="ReqFVal1" runat="server" ControlToValidate="tb_kol"
                        Display="Dynamic" SetFocusOnError="true" ToolTip="Не вірний формат">Заповніть поле</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="ReqEVal1" runat="server" ControlToValidate="tb_kol"
                        Display="Dynamic" SetFocusOnError="true" ToolTip="Не вірний формат" ValidationExpression="&gt;(^(\ |\-)(([1-9][0-9]*))([0-9])?$)|(^(([1-9][0-9]*))([0-9])?$)">Не вірний формат</asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lb_kved" runat="server" Text="КВЕД"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tb_kved" runat="server" MaxLength="10" OnTextChanged="ChangetTb_kved"
                        AutoPostBack="true" CausesValidation="false" Style="text-align: right" Width="100Px">
                    </asp:TextBox>
                </td>
                <td>
                    <asp:Button ID="btKVED" runat="server" Height="22px" OnClientClick="select_KVED()"
                        Text="..." ToolTip="Пошук КВЕД" Width="22px" CausesValidation="false" />
                    <asp:Label ID="Lb_n_ved" runat="server"></asp:Label>
                    <asp:RequiredFieldValidator ID="Reqtb_kved" runat="server" ControlToValidate="tb_kved"
                        Display="Dynamic" SetFocusOnError="true" ToolTip="Не вірний формат">Заповніть поле</asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel runat="server" ID="pnGrid" GroupingText="Форма">
        <Bars:BarsSqlDataSourceEx ID="dsMain" runat="server" AllowPaging="False" ProviderName="barsroot.core">
        </Bars:BarsSqlDataSourceEx>
        <Bars:BarsGridViewEx ID="gvMain" runat="server" AllowPaging="False" AllowSorting="True"
            CssClass="barsGridView" DataKeyNames="OKPO,KOD,IDF,POB,FDAT" ShowPageSizeBox="False"
            AutoGenerateColumns="False" DateMask="dd/MM/yyyy" JavascriptSelectionType="None"
            OnRowDataBound="gvMain_RowDataBound" ShowCaption="False">
            <FooterStyle CssClass="footerRow"></FooterStyle>
            <HeaderStyle CssClass="headerRow"></HeaderStyle>
            <EditRowStyle CssClass="editRow"></EditRowStyle>
            <PagerStyle CssClass="pagerRow"></PagerStyle>
            <NewRowStyle CssClass=""></NewRowStyle>
            <SelectedRowStyle ForeColor="Black"></SelectedRowStyle>
            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
            <Columns>
                <asp:BoundField DataField="OKPO" HeaderText="ЕДРПО" />
                <asp:BoundField DataField="FDAT" HeaderText="Дата" />
                <asp:BoundField DataField="KOD" HeaderText="Код" />
                <asp:BoundField DataField="NAME" HeaderText="Назва" />
                <asp:TemplateField HeaderText="Сума">
                    <ItemTemplate>
                        <Bars:NumericEdit Visible='<%# (Convert.ToString(Eval("KOD")) == "")?(false):(true) %>'
                            runat="server" Width="150px" ID="tbS" Value='<%#  Convert.ToDecimal(Eval("S")) %>'
                            MinValue="-1000000000" MaxValue="1000000000" Enabled='<%# (Convert.ToString(t_read.Text) == "0")?(false):(true) %>'
                            EnableTheming="True" /></ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:BoundField DataField="KOD" HeaderText="Код" />
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </Bars:BarsGridViewEx>
    </asp:Panel>
    <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
    </asp:ScriptManager>
    </form>
</body>
</html>
