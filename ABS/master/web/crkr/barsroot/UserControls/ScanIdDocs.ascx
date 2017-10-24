<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ScanIdDocs.ascx.cs" Inherits="UserControls_ScanIdDocs" %>

<script type="text/javascript">
    function ShowDialog(rnk) {
        var DialogOptions = 'dialogHeight: 600px; dialogWidth: 650px; scroll: no';
        var rnd = Math.random();

        //var result = window.showModalDialog('/barsroot/UserControls/dialogs/ScanIdDocs.aspx?rnk=' + rnk + '&rnd=' + rnd, window, DialogOptions);
         window.open('/barsroot/UserControls/dialogs/ScanIdDocs.aspx?rnk=' + rnk + '&rnd=' + rnd, "Dialog", 'height: 600px, width: 650px');
        //if (result) return true;
        //else return false;
    }
</script>

<asp:LinkButton ID="btn" runat="server" Text="Сканування ідент. документів" CausesValidation="false"></asp:LinkButton>