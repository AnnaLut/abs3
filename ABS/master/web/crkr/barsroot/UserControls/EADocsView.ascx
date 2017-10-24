<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EADocsView.ascx.cs" Inherits="UserControls_EADocsView" %>

<script type="text/javascript">
    function EADocsView_ShowDialog(eas_id, rnk, agr_id, modal) {
        if (eas_id == '' || rnk == '') return false;

        var Url = '/barsroot/UserControls/dialogs/EADocsView.aspx?eas_id=' + eas_id + '&rnk=' + rnk + '&agr_id=' + agr_id + '&rnd=' + Math.random();

        var WindowOptions = 'width=650, height=600, location=no, menubar=no, resizable=yes, scrollbars=yes';
        var DialogOptions = 'dialogWidth: 650px; dialogHeight: 600px; resizable: yes; scroll: yes';

        if (modal) {
            var result = window.showModalDialog(Url, window, DialogOptions);

            ///
            /// Закоментарив поки в dialogs\EADocsView.btDocViewed.Visible = false;
            ///
            // if (result) return true;
            // else return false;
            
            return true;
        }
        else {
            window.open(Url, '_blank', WindowOptions, false);
            return false;
        }
    }
</script>

<asp:LinkButton ID="btn" runat="server" Text="Перегляд документів ЕА" OnClick="btn_Click"></asp:LinkButton>