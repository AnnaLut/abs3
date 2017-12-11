<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ScanIdDocs.ascx.cs" Inherits="UserControls_ScanIdDocs" %>

<script type="text/javascript">
    function ShowDialog(rnk) {
        var DialogOptions = 'dialogHeight: 600px; dialogWidth: 650px; scroll: no';
        var rnd = Math.random();


        var DialogOptions = 'width=1024, height=860, toolbar=yes, location=yes, directories=no, menubar=yes, scrollbars=yes, resizable=yes, status=no';


        //var result = window.showModalDialog('/barsroot/UserControls/dialogs/ScanIdDocs.aspx?rnk=' + rnk + '&rnd=' + rnd, window, DialogOptions);
        window.open('/barsroot/UserControls/dialogs/ScanIdDocs.aspx?rnk=' + rnk + '&rnd=' + rnd, "Dialog",
            DialogOptions);
        //if (result) return true;
        //else return false;
    }
</script>

<asp:LinkButton ID="btn" runat="server" Text="Сканування ідент. документів" CausesValidation="false"></asp:LinkButton>