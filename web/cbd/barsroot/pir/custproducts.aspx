<%@ Page Language="C#" AutoEventWireup="true" CodeFile="custproducts.aspx.cs" Inherits="pir_custproducts" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEX" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="Styles.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/BarsGridView.css" type="text/css" rel="stylesheet" />

    <script type="text/javascript" language="javascript">
        var aSigner;
        var strSignBuf = "";

        // инициализация
        function InitSign() {
            try {
                aSigner = new ActiveXObject("BARSAX.RSAC");
                if (!aSigner.IsInitialized) aSigner.Init("VEG");
                if (!aSigner.IsInitialized) {
                    alert("ActiveX not initialized");
                    return false;
                }
            }
            catch (e) {
                alert("Не знайдено програмного забезпечення для накладення ЕЦП (ActiveX). Зверніться до адміністратора.");
                return false;
            }
            alert("ActiveX успішно ініціалізовано.");
            SignBuffer();
        }

        function SignBuffer() {
            var strBuf = document.getElementById("strBuf").value;
            aSigner.BufferEncoding = "WIN";
            aSigner.BankDate = document.getElementById("hBankDate").value;
            aSigner.IdOper = document.getElementById("hKeyId").value;
            strSignBuf = aSigner.SignBuffer(strBuf);
            document.getElementById("hSignedBuffer").value = strSignBuf;
            return true;
        }

        function ViewHistory(rnd) {
            var ReqId = document.getElementById("lblReqNumber").innerText;
            var Return = window.showModalDialog('/barsroot/pir/history.aspx?rnd=' + rnd + '&req_id=' + ReqId, window, 'center:{yes};dialogheight:600px;dialogwidth:900px');;
        }
        // предварительный просмотр отчёта
        //function Print1() {
        //    window.showModalDialog('/barsroot/pcur/pcur_print.aspx', window, 'center:{yes};dialogheight:650px;dialogwidth:800px');
        //}
    </script>
</head>
<body bgcolor="#f0f0f0">
    <form id="formfindCust" runat="server" style="vertical-align: central">
        <!-- блок hidden-ов -->
        <asp:HiddenField runat="server" ID="hKeyId" />
        <asp:HiddenField runat="server" ID="hBuffer" />
        <asp:HiddenField runat="server" ID="hBankDate" />
        <asp:HiddenField runat="server" ID="hSignedBuffer" />

        <asp:HiddenField ID="inBidId" runat="server" />
        <asp:HiddenField ID="strBuf" runat="server" />
        <asp:HiddenField ID="tbKeyID" runat="server" />

        <asp:Panel ID="pnCustInfo" runat="server" GroupingText="Інформація про заявника:" Style="margin-left: 10px; margin-right: 10px">
            <table>
                <tr>
                    <td colspan="2" align="left">
                        <asp:Label ID="lbOurBranch" runat="server" Text="" Font-Bold="true"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbDummy1" runat="server" Text="      " Width="50px"></asp:Label>
                    </td>
                    <td colspan="2" align="left">
                        <asp:Label ID="lbBranch" runat="server" Text="Кримське РУ" Font-Bold="true"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbRnkEx" runat="server" Text="РНК клієнта:" AssociatedControlID="lbRnkExVal"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbRnkExVal" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbDummy2" runat="server" Text="      " Width="50px"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbRnk" runat="server" Text="РНК клієнта:"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbRnkVal" runat="server" Font-Bold="True" Width="250px"></asp:Label>

                    </td>

                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbFioEx" runat="server" Text="ПІБ клієнта:"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbFioExVal" runat="server" Font-Bold="True"></asp:Label>

                    </td>
                    <td>
                        <asp:Label ID="lbDummy3" runat="server" Text="      " Width="50px"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbFio" runat="server" Text="ПІБ клієнта:"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbFioVal" runat="server" Font-Bold="True"></asp:Label>

                    </td>

                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbBirthEx" runat="server" Text="Дата народження клієнта:" AssociatedControlID="lbBirthVal"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbBirthExVal" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbDummy4" runat="server" Text="      " Width="50px"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbBirth" runat="server" Text="Дата народження клієнта:" AssociatedControlID="lbBirthVal"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbBirthVal" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblPassportEx" runat="server" Text="Документ:"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbPassportExVal" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbDummy5" runat="server" Text="      " Width="50px"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblPassport" runat="server" Text="Документ:"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblDocumentVal" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbInnEx" runat="server" Text="ІНН клієнта:"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbInnExVal" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbDummy6" runat="server" Text="      " Width="50px"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbInn" runat="server" Text="ІНН клієнта:"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbInnVal" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnReqInfo" runat="server" GroupingText="Інформація про заявку:" Style="margin-left: 10px; margin-right: 10px">
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lblReqNumberCatpion" runat="server" Text="Заява № "></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblReqNumber" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblReqStateCaprion" runat="server" Text="Статус "></asp:Label>

                    </td>
                    <td>
                        <asp:Label ID="lblReqState" runat="server" Font-Bold="True"></asp:Label>
                    </td>

                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblReqDateCreateCaption" runat="server" Text="cтворена "></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblReqDateCreate" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbReqStaffCreateCaption" runat="server" Text="користувачем "></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbReqStaffCreate" runat="server" Font-Bold="True"></asp:Label>
                    </td>

                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblReqMFOCaption" runat="server" Text="МФО "></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblReqMFO" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblBranchCaption" runat="server" Text="Відділення "></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblBranch" runat="server" Font-Bold="True"></asp:Label>
                    </td>

                </tr>

            </table>
        </asp:Panel>
        <asp:Panel ID="pnButtons" runat="server" GroupingText="Доступні дії:" Style="margin-left: 10px; margin-right: 10px">
            <bars:ImageTextButton ID="btBack" runat="server" ImageUrl="/common/images/default/16/arrow_left.png" Text="Назад" ToolTip="Повернутись в початок пошуку" OnClick="btBack_Click" />
            <bars:ImageTextButton ID="btSave" runat="server" ImageUrl="/common/images/default/16/ok.png" Text="Зберегти" ToolTip="Виконати зв`язку виділених продуктів та заявки" OnClick="btSave_Click" />
            <bars:ImageTextButton ID="btReset" runat="server" ImageUrl="/common/images/default/16/delete.png" Text="Видалити" ToolTip="Відмінити зв`язку виділених продуктів та заявки" OnClick="btReset_Click" />
            <bars:ImageTextButton ID="btVisa" runat="server" ImageUrl="/common/images/default/16/visa.png" Text="Накласти підпис" OnClick="tbVisa_Click" ToolTip="Накласти підпис" OnClientClick="InitSign()" />
            <asp:Button ID="btPrint" runat="server" Text="Друк заявки" OnClick="print_Click" Visible="false" />
            <asp:Button ID="btPrint2" runat="server" Text="Друк заявки v1" OnClick="print2_Click" Visible="false" />
            <asp:Button ID="btViewHistory" runat="server" Text="Перегляд історії заявки" ToolTip="Перегляд історії заявки" OnClick="btViewHistory_Click" Visible="true" />
        </asp:Panel>
        <br />
        <div id="dvGridTitle" runat="server">
            <asp:Label ID="lbGvTitle" runat="server" Text="Продукти клієнта" Font-Size="Medium" Style="margin-left: 10px; margin-right: 10px"></asp:Label>
        </div>
        <asp:Label ID="lbBidId" runat="server" Visible="true"></asp:Label>
        <asp:Label ID="lbErr" runat="server" Visible="true" ForeColor="Red"></asp:Label>
        <BarsEX:BarsSqlDataSourceEx ID="odsFmDocs" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEX:BarsSqlDataSourceEx>

        <BarsEX:BarsGridViewEx ID="gv" runat="server" PagerSettings-PageButtonCount="10"
            PageSize="100" AllowPaging="false" AllowSorting="True" AutoGenerateCheckBoxColumn="true"
            CssClass="barsGridView" DateMask="dd/MM/yyyy" DataKeyNames="DEAL_ID,DEAL_TYPE,APPROVED"
            JavascriptSelectionType="None" AutoGenerateColumns="false" CaptionType="Cool"
            ShowPageSizeBox="false" EnableViewState="true" OnRowDataBound="gv_RowDataBound"
            AutoSelectFirstRow="false"
            HoverRowCssClass="headerRow" 
            RefreshImageUrl="/common/images/default/16/refresh.png"
            ExcelImageUrl="/common/images/default/16/export_excel.png"
            FilterImageUrl="/common/images/default/16/filter.png">
            <AlternatingRowStyle CssClass="alternateRow" />
            <Columns>
                <asp:BoundField DataField="DEAL_TYPE_NAME" HeaderText="Тип" ItemStyle-HorizontalAlign="Left" Visible="true"></asp:BoundField>
                <asp:BoundField DataField="DEAL_ID" HeaderText="Ід." ItemStyle-HorizontalAlign="Right" Visible="true"></asp:BoundField>
                <asp:BoundField DataField="DEAL_NUM" HeaderText="Номер" ItemStyle-HorizontalAlign="Left" Visible="true"></asp:BoundField>
                <asp:BoundField DataField="SDATE" HeaderText="Дата" ItemStyle-HorizontalAlign="Center" Visible="true"></asp:BoundField>
                <asp:BoundField DataField="COMM" HeaderText="Коментар" ItemStyle-HorizontalAlign="Left" Visible="true"></asp:BoundField>
                <asp:BoundField DataField="SUMM" HeaderText="Залишок" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:###,###,###,###,###,##0.00}" Visible="true"></asp:BoundField>
                <asp:BoundField DataField="SUMMPROC" HeaderText="Відсотки" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:###,###,###,###,###,##0.00}" Visible="true"></asp:BoundField>
                <asp:BoundField DataField="KV" HeaderText="Валюта" ItemStyle-HorizontalAlign="Right" Visible="true"></asp:BoundField>
                <asp:BoundField DataField="REFF" HeaderText="Реф" ItemStyle-HorizontalAlign="Right" Visible="true"></asp:BoundField>
            </Columns>
            <FooterStyle CssClass="footerRow" />
            <HeaderStyle CssClass="headerRow" />
            <EditRowStyle CssClass="editRow" />
            <PagerStyle CssClass="pagerRow" />
            <SelectedRowStyle CssClass="selectedRow" />
            <AlternatingRowStyle CssClass="alternateRow" />
            <PagerSettings Mode="Numeric"></PagerSettings>
            <RowStyle CssClass="normalRow" />
            <NewRowStyle CssClass="newRow" />
        </BarsEX:BarsGridViewEx>

    </form>
</body>
</html>
