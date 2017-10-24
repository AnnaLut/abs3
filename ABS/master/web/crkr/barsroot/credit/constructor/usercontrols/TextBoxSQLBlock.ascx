<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TextBoxSQLBlock.ascx.cs"
    Inherits="Bars.UserControls.TextBoxSQLBlock" %>
<%@ Register Src="../../usercontrols/TextBoxString.ascx" TagName="TextBoxString"
    TagPrefix="bec" %>
<script language="javascript" type="text/javascript">
    function ShowMacrosQuestions(tb_cid, sections, types) {
        var DialogOptions = 'dialogHeight:600px; dialogWidth:900px';
        var rnd = Math.random();

        var result = window.showModalDialog('/barsroot/credit/constructor/dialogs/wcsquestions.aspx?mode=macros&sections=' + sections + '&types=' + types + '&rnd=' + rnd, window, DialogOptions);
        if (result == null) return false;
        else {
            if (document.selection) {
                document.getElementById(tb_cid).focus();
                var selectionRange = document.selection.createRange();
                selectionRange.text = result;
            }
            else {
                document.getElementById(tb_cid).value += result;
            }
        }

        return false;
    }
</script>
<table border="0" cellpadding="2" cellspacing="0">
    <tr>
        <td>
            <bec:TextBoxString ID="tb" runat="server" />
        </td>
    </tr>
    <tr>
        <td align="center">
            <asp:ImageButton ID="ibQuests" runat="server" CausesValidation="False" ImageUrl="/Common/Images/default/16/help.png"
                Text="Добавить макрос-вопрос" ToolTip="Добавить макрос-вопрос" />
            <asp:ImageButton ID="ibMACs" runat="server" CausesValidation="False" ImageUrl="/Common/Images/default/16/help_earth.png"
                Text="Добавить макрос-МАК" ToolTip="Добавить макрос-МАК" />
        </td>
    </tr>
</table>
