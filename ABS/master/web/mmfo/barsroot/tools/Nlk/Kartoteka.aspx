<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Kartoteka.aspx.cs" Inherits="tools_Nlk_Kartoteka" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <link href="/Common/css/barsgridview.css" type="text/css" rel="Stylesheet" />
    <div>
        <asp:Panel runat="server" ID="Pn1">
            <input type="hidden" runat="server" id="ACC_" />
            <input type="hidden" runat="server" id="REF1_" />
            <input type="hidden" runat="server" id="REF2_" />
        </asp:Panel>
        <asp:Panel runat="server" ID="Pn2">
            <Bars:BarsGridViewEx ID="grid_nlk" Style='width: 100%; cursor: hand' runat="server"
                DataSourceID="dsgrid_nlk" CssClass="barsGridView" DataKeyNames="SOS" JavascriptSelectionType="None"
                AutoGenerateColumns="false" AllowPaging="True" AllowSorting="True" ShowPageSizeBox="true"
                EnableViewState="true" OnRowDataBound="gridCCPortf_RowDataBound" AutoSelectFirstRow="False"
                PageSize="15">
                <AlternatingRowStyle CssClass="alternateRow" />
                <Columns>
              
                    <asp:BoundField DataField="REF2" HeaderText="РЕФ документу" SortExpression="REF2" ItemStyle-Width="120Px" 
                        ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                    <asp:BoundField DataField="NLSB" HeaderText="Рах. зарахування" SortExpression="NLSB" ItemStyle-Width="150Px">
                    </asp:BoundField>
                    <asp:BoundField DataField="S" HeaderText="Сума зарахування" SortExpression="S" DataFormatString="{0:N2}" ItemStyle-Width="150Px"
                        ItemStyle-HorizontalAlign="Right"></asp:BoundField>
                    <asp:BoundField DataField="NAZN" HeaderText="Призначення платежу" SortExpression="NAZN" ItemStyle-Width="570Px">
                    </asp:BoundField>
                    <asp:BoundField DataField="SOS" HeaderText="SOS" SortExpression="SOS" ItemStyle-Width="30Px" ItemStyle-HorizontalAlign="Right" Visible="true"></asp:BoundField>
                </Columns>
                <FooterStyle CssClass="footerRow"></FooterStyle>
                <HeaderStyle CssClass="headerRow"></HeaderStyle>
                <EditRowStyle CssClass="editRow"></EditRowStyle>
                <PagerStyle CssClass="pagerRow"></PagerStyle>
                <NewRowStyle CssClass=""></NewRowStyle>
                <SelectedRowStyle ForeColor="Black"></SelectedRowStyle>
                <RowStyle CssClass="normalRow"></RowStyle>
            </Bars:BarsGridViewEx>
            <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
            </asp:ScriptManager>
            <Bars:BarsSqlDataSourceEx ProviderName="barsroot.core" ID="dsgrid_nlk" runat="server">
            </Bars:BarsSqlDataSourceEx>
        </asp:Panel>
    </div>
    </form>
</body>
</html>
