<%@ Page Language="C#" AutoEventWireup="true" CodeFile="payments.aspx.cs" Inherits="Payments" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Перечень платежей для импорта</title>
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet"/>
    <script language="javascript" type="text/javascript" src="/Common/Script/Sign.js"></script>
    <script language="javascript" type="text/javascript" src="js/import.js"></script>
    <style>
    .GridViewHiddenCol
    {
        display:none;
    }
    </style>
</head>
<body>
    <form id="formPayments" runat="server">
    <div>
        <asp:Label ID="label_Info" runat="server" EnableViewState="False" Font-Bold="True"
            Text="Импорт платежей из файла:" meta:resourcekey="label_InfoResource1"></asp:Label>
        &nbsp;
        <asp:Label ID="label_file" runat="server" EnableViewState="False" Font-Bold="True"
            Font-Italic="False" Text="$A_____.___" meta:resourcekey="label_fileResource1"></asp:Label><br />
        <br />
        <asp:Label ID="label_count" runat="server" EnableViewState="False" Text="Количество платежей:" meta:resourcekey="label_countResource1"></asp:Label>&nbsp;
        <asp:TextBox ID="text_count" runat="server" EnableViewState="False" ReadOnly="True"
            Width="107px" style="text-align:center" meta:resourcekey="text_countResource1"></asp:TextBox>&nbsp;&nbsp;
        <asp:Button ID="bt_pay" runat="server" EnableViewState="False" Text="Оплатить" meta:resourcekey="bt_payResource1" OnClick="bt_pay_Click" OnClientClick="return GetSigns();" /><br />
        <br />        
        <asp:GridView ID="gv" runat="server" EnableViewState="False" AutoGenerateColumns="False" meta:resourcekey="gvResource1" CssClass="barsGridView">
            <Columns>
                <asp:BoundField DataField="REC" HeaderText="№ документа" ReadOnly="True" meta:resourcekey="BoundFieldResource1">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="MFOA" HeaderText="МФО отправителя" meta:resourcekey="BoundFieldResource2">
                    <ItemStyle HorizontalAlign="Center" Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="NLSA" HeaderText="Счет отправителя" meta:resourcekey="BoundFieldResource3">
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="MFOB" HeaderText="МФО получателя" meta:resourcekey="BoundFieldResource4">
                    <ItemStyle HorizontalAlign="Center" Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="NLSB" HeaderText="Счет получателя" meta:resourcekey="BoundFieldResource5">
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="SUM100" DataFormatString="{0:### ### ### ##0.00}" HeaderText="Сумма"
                    HtmlEncode="False" meta:resourcekey="BoundFieldResource6">
                    <ItemStyle HorizontalAlign="Right" Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="VOB" HeaderText="Вид документа" meta:resourcekey="BoundFieldResource16">
                    <ItemStyle CssClass="GridViewHiddenCol" />
                    <HeaderStyle CssClass="GridViewHiddenCol" />
                </asp:BoundField>
                <asp:BoundField DataField="ND" HeaderText="Номер документа" meta:resourcekey="BoundFieldResource7">
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="DATD" DataFormatString="{0:dd.MM.yyyy}" HeaderText="Дата документа"
                    HtmlEncode="False" meta:resourcekey="BoundFieldResource8">
                    <ItemStyle HorizontalAlign="Center" Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="NAM_A" HeaderText="Плательщик" meta:resourcekey="BoundFieldResource10">
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="NAM_B" HeaderText="Получатель" meta:resourcekey="BoundFieldResource11">
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="NAZN" HeaderText="Назначение платежа" meta:resourcekey="BoundFieldResource12">
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="ID_A" HeaderText="ОКПО отправителя" meta:resourcekey="BoundFieldResource13">
                    <ItemStyle HorizontalAlign="Center" Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="ID_B" HeaderText="ОКПО получателя" meta:resourcekey="BoundFieldResource14">
                    <ItemStyle HorizontalAlign="Center" Wrap="False" />
                </asp:BoundField>
                <asp:BoundField ConvertEmptyStringToNull="False" DataField="SEPBUF2SIGN" HeaderText="SEPBUF2SIGN" meta:resourcekey="BoundFieldResource15" HtmlEncode="False" >
                    <ItemStyle CssClass="GridViewHiddenCol" />
                    <HeaderStyle CssClass="GridViewHiddenCol" />
                </asp:BoundField>
                <asp:BoundField ConvertEmptyStringToNull="False" DataField="INTBUF2SIGN" HeaderText="INTBUF2SIGN"
                    HtmlEncode="False" meta:resourcekey="BoundFieldResource17">
                    <ItemStyle CssClass="GridViewHiddenCol" />
                    <HeaderStyle CssClass="GridViewHiddenCol" />
                </asp:BoundField>
                <asp:BoundField DataField="REF" HeaderText="REF" meta:resourcekey="BoundFieldResource18">
                    <ItemStyle CssClass="GridViewHiddenCol" />
                    <HeaderStyle CssClass="GridViewHiddenCol" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>        
        <br />
        <br />
        <asp:HiddenField ID="hd_bankdate" runat="server" EnableViewState="False" />
        <asp:HiddenField ID="hd_regncode" runat="server" EnableViewState="False" />
        <asp:HiddenField ID="hd_key_id" runat="server" EnableViewState="False" />
    </div>
        <asp:HiddenField ID="hd_int_flag" runat="server" EnableViewState="False" />
        <asp:HiddenField ID="hd_ext_flag" runat="server" EnableViewState="False" />
        <asp:HiddenField ID="hd_tt_ext" runat="server" EnableViewState="False" OnValueChanged="HiddenField3_ValueChanged" />
        <asp:HiddenField ID="hd_tt_int" runat="server" EnableViewState="False" /><asp:HiddenField ID="hd_debug_bankdate" runat="server" EnableViewState="False" /><asp:HiddenField ID="hd_signatures" runat="server" EnableViewState="False" />
        <asp:HiddenField ID="hd_status_sign" runat="server" EnableViewState="False" Value="Наложение ЭЦП, документ: "  meta:resourcekey="hd_status_signResource1"/>        
    </form>
</body>
</html>
