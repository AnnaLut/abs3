<%@ Page Language="C#" AutoEventWireup="true" CodeFile="import_hits.aspx.cs" Inherits="sberutls_import_ispro" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEx" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title title="Завантаження файлу приналежності до співробітників Банку"></title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
    <style type="text/css">
        .title {
            border-bottom-color: #CCD7ED;
            border-bottom: 1px solid;
            margin-bottom: 20px;
            font-size: 12pt;
            color: #1C4B75;
        }

        #lblRes {
            width: 300px;
        }

        #lblRes0 {
            width: 300px;
        }

        #lblResOk {
            width: 340px;
        }

        #lblResBad {
            width: 314px;
        }
    </style>
</head>
<body>

    <form id="form1" runat="server">
        <div>
            <table>
                <tr>
                    <td>
                        <br>Завантаження файлу приналежності до співробітників Банку
                        </br>
                    </td>
                </tr>
            </table>
        </div>
        <div>

            <hr />


            <table>
                <tr>
                    <br>Файл:
                    </br>
                    <td>
                        <asp:FileUpload ID="fileUpload" runat="server" EnableViewState="false" />
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <br />
                        <asp:Button ID="btnLoad" runat="server" Text="Завантажити"
                            OnClick="btnLoad_Click" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="divMsg" style="color: Red" runat="server"></div>
                        <div id="divMsgOk" style="color: Green" runat="server"></div>
                    </td>

                </tr>
            </table>
            <hr />
			 <table>
                <tr>
                    <td>
                        <asp:Button runat="server" ID="btPay" Text="Встановити" OnClick="btPay_Click" />
                    </td>
                </tr>
            </table>
            <table>
                <tr>
                    <td>
                        <BarsEx:BarsSqlDataSourceEx ID="dsMain" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
                        <BarsEx:BarsGridViewEx ID="gvMain" runat="server" AllowPaging="True" AllowSorting="True" DataKeyNames="OKPO"
                            DataSourceID="dsMain" CssClass="barsGridView" ShowPageSizeBox="true"
                            AutoGenerateColumns="False" DateMask="dd/MM/yyyy" JavascriptSelectionType="None"
                            pagersettings-pageindex="0"
                            PageSize="10">
                            <SelectedRowStyle CssClass="selectedRow" />
                            <Columns>
                                <asp:BoundField DataField="NMK" HeaderText="Назва клієнта" />
                                <asp:BoundField DataField="OKPO" HeaderText="Ідентифікаційний код" />
                                <asp:BoundField DataField="SER" HeaderText="Серія документа" />
                                <asp:BoundField DataField="NUMDOC" HeaderText="Номер документа" />
                                <asp:BoundField DataField="PL" HeaderText="Результат встановлення" />
                            </Columns>
                        </BarsEx:BarsGridViewEx>
                    </td>
                </tr>
            </table>
            <hr />

        </div>
    </form>
</body>
</html>
