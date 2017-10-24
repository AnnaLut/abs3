<%@ Page Language="C#" AutoEventWireup="true" CodeFile="pickup_doc.aspx.cs" Inherits="swi_pickup_doc" %>
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
    <title>Документи</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
    <base target="_self"/>
</head>
<body>
    <form id="frm_pickup_doc" runat="server">
    <div>
    
    </div>
        <asp:Panel runat="server" ID="pnRun" GroupingText="Фільтр">
            <table>
                <tr>
                    <td>
                        <asp:CheckBox runat="server" ID="cbAmount" Text="Рівні по сумі" AutoPostBack="true" OnClick="ShowProgress();" OnCheckedChanged ="cbAmount_CheckedChanged" Checked="true"/>
                    </td>
                      <td>
                        <asp:CheckBox runat="server" ID="cb20" Text="Рівні по 20 полю" AutoPostBack="true" OnClick="ShowProgress();" OnCheckedChanged ="cbAmount_CheckedChanged" Checked="true"/>
                    </td>
                </tr>
            </table>
        </asp:Panel>
         <br />
        <hr style="margin-left: 10px; margin-right: 10px" />
        <table>
            <tr>
                <td>
        <BarsEx:BarsSqlDataSourceEx ID="dsMain" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
        <BarsEx:BarsGridViewEx ID="gvMain" runat="server" AllowPaging="True" AllowSorting="True"
            DataSourceID="dsMain" CssClass="barsGridView" DataKeyNames="ref" ShowPageSizeBox="true"
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
                  <asp:TemplateField HeaderText="Референс АБС" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                             <asp:HyperLink ID="hlRef" BackColor="White" runat="server" Text='<%#Eval("REF")%>' NavigateUrl='<%# "/barsroot/documentview/default.aspx?ref="+Eval("REF")%>'></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="VDAT" HeaderText="Дата валютування"   ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="NLSA" HeaderText="Рахунок А"  ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="NLSB" HeaderText="Рахунок Б"   ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="AMOUNT" HeaderText="Сума" />
                <asp:BoundField DataField="LCV" HeaderText="Валюта" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="NAZN" HeaderText="Призначення платежу"/>
                <asp:BoundField DataField="TAG20" HeaderText="Поле20"/>
                <asp:BoundField DataField="TT" HeaderText="Код операції" />
                <asp:BoundField DataField="NEXTVISAGRP" HeaderText="Наступна віза"   ItemStyle-HorizontalAlign="Center"/>
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </BarsEx:BarsGridViewEx>
                    </td>
                </tr>
            <tr>
                <td>
                    <asp:Button runat="server" ID="btLink" Text="Прив'язати" OnClick="btLink_Click"/>
                    <asp:Button runat="server" ID="btClose" Text="Відмінити" OnClick="btClose_Click"/>
                </td>
            </tr>
            </table>
        <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
        </asp:ScriptManager>
    </form>
</body>
</html>
