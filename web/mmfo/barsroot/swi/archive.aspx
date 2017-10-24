<%@ Page Language="C#" AutoEventWireup="true" CodeFile="archive.aspx.cs" Inherits="swi_archive" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEx" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script type="text/javascript">
        function ShowProgress() {
            var top = document.body.offsetHeight / 2 - 15;
            var left = document.body.offsetWidth / 2 - 50;

            /* var sImg = '<div style="position: absolute; top:' + top + '; background:white; left:' + left + '; width:101; height:33;" ></div>';
             oImg = document.createElement(sImg);
             oImg.innerHTML = '<img src=/Common/Images/process.gif>';
 
             document.body.insertAdjacentElement("beforeEnd", oImg);*/
            var sImg = document.createElement("div");
            sImg.style.position = 'absolute';
            sImg.style.top = top;
            sImg.style.background = 'white';
            sImg.style.left = left;
            sImg.style.width = "101";
            sImg.style.height = "33";

            oImg = document.body.appendChild(sImg);
            oImg.innerHTML = '<img src=/Common/Images/process.gif>';

            document.body.insertAdjacentElement("beforeEnd", oImg);
        }
    </script>
    <title>Архів повідомлень</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
</head>
    

<body>
    <form id="frm_archive" runat="server">
    <div>
    <table>
                <tr>
                    <td>
                        <br>АРХІВ ПОВІДОМЛЕНЬ
                        </br>
                    </td>
                </tr>
            </table>
    </div>
        <asp:Panel runat="server" ID="pnRun" GroupingText="Виконання дій">
            <table>
                <tr>
                    <td>
                        <asp:Button runat="server" ID="btPay" ToolTip="Підбір документу" Text="Підібрати" OnClick="btPay_Click" OnClientClick="ShowProgress();"/>
                    </td>
                    <td>
                         <asp:CheckBox runat="server" ID="cbDetails" OnClick="ShowProgress();" AutoPostBack="true" OnCheckedChanged ="btRefresh_Click" Text="Показати деталі"/>
                    </td>
                </tr>
            </table>
        </asp:Panel>
         <br />
        <hr style="margin-left: 10px; margin-right: 10px" />
        <BarsEx:BarsSqlDataSourceEx ID="dsMain" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
        <BarsEx:BarsGridViewEx ID="gvMain" runat="server" AllowPaging="True" AllowSorting="True"
            DataSourceID="dsMain" CssClass="barsGridView" DataKeyNames="swref" ShowPageSizeBox="true"
            AutoGenerateColumns="False" DateMask="dd/MM/yyyy" JavascriptSelectionType="SingleRow"
            PagerSettings-PageButtonCount="10" PageIndex="0"
            PageSize="20">
            <FooterStyle CssClass="footerRow"></FooterStyle>
            <HeaderStyle CssClass="headerRow"></HeaderStyle>
            <EditRowStyle CssClass="editRow"></EditRowStyle>
            <PagerStyle CssClass="pagerRow"></PagerStyle>
            <NewRowStyle CssClass=""></NewRowStyle>
            <SelectedRowStyle ForeColor="Black"></SelectedRowStyle>
            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
            <Columns>
                  <asp:TemplateField HeaderText="Референс" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                             <asp:HyperLink ID="hlRef" BackColor="White" runat="server" Text='<%#Eval("SWREF")%>' NavigateUrl='<%# "/barsroot/documentview/view_swift.aspx?swref="+Eval("SWREF")%>'></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="IO_IND" HeaderText="Вх./Вих."  ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="MT" HeaderText="Тип"   ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="TRN" HeaderText="SWIFT реф." />
                <asp:BoundField DataField="SENDER" HeaderText="Код відправника" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="SENDER_NAME" HeaderText="Назва відправника" Visible="false"/>
                <asp:BoundField DataField="PAYER" HeaderText="Платник" Visible="false"/>
                <asp:BoundField DataField="AMOUNT" HeaderText="Сума" ItemStyle-HorizontalAlign="Right"/>
                <asp:BoundField DataField="CURRENCY" HeaderText="Валюта"   ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="RECEIVER" HeaderText="Код отримувача" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="RECEIVER_NAME" HeaderText="Назва отримувача" Visible="false" />
                <asp:BoundField DataField="PAYEE" HeaderText="Отримувач" Visible="false"/>
                <asp:BoundField DataField="TRANSIT" HeaderText="Транзит" Visible="false" />
                <asp:BoundField DataField="ACCD" HeaderText="ACCD" Visible="false"/>
                <asp:BoundField DataField="ACCK" HeaderText="ACCK" Visible="false"/>
                <asp:BoundField DataField="DATE_IN" HeaderText="Дата вх."   ItemStyle-HorizontalAlign="Center" Visible="false"/>
                <asp:BoundField DataField="DATE_OUT" HeaderText="Дата вих."   ItemStyle-HorizontalAlign="Center" Visible="false"/>
                <asp:BoundField DataField="DATE_PAY" HeaderText="Дата оплати"   ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="VDATE" HeaderText="Дата валютування"   ItemStyle-HorizontalAlign="Center"/>
                 <asp:TemplateField HeaderText="Референс АБС" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:HyperLink ID="hlRefABS" runat="server" Target="_self" NavigateUrl='<%#String.Format("/barsroot/documentview/default.aspx?ref={0}",Eval("REF")) %>'>
                            <asp:Label ID="lbRefABS" BackColor="White" runat="server" Text='<%#String.Format("{0}",Eval("REF")) %>'></asp:Label>
                        </asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="TAG20" HeaderText="Поле 20"   ItemStyle-HorizontalAlign="Center"/>
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </BarsEx:BarsGridViewEx>
        <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
        </asp:ScriptManager>
    </form>
</body>
</html>
