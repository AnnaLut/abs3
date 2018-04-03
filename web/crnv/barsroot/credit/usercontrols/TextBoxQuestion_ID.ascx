<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TextBoxQuestion_ID.ascx.cs"
    Inherits="Bars.UserControls.TextBoxQuestion_ID" %>
<%@ Register Src="TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<script language="javascript" type="text/javascript">

    function ShowRef(tb_cid, sections, types) {
        var DialogOptions = 'dialogHeight:600px; dialogWidth:900px';
        var rnd = Math.random();

        var result = window.showModalDialog('/barsroot/credit/constructor/dialogs/wcsquestions.aspx?mode=question&sections=' + sections + '&types=' + types + '&rnd=' + rnd, window, DialogOptions);
        if (result == null) return false;
        else {
            document.getElementById(tb_cid).value = result;
            return true;
        }
    }
    function ShowQuestion(tb_cid, question_id, mode, types) {
        var DialogOptions = 'dialogHeight:800px; dialogWidth:800px; resizable: yes';
        var rnd = Math.random();

        var result = window.showModalDialog('/barsroot/credit/constructor/dialogs/wcsquestion.aspx?question_id=' + question_id + '&mode=' + mode + '&types=' + types + '&rnd=' + rnd, window, DialogOptions);
        if (result == null) return false;
        else {
            document.getElementById(tb_cid).value = result;
            return true;
        }
    }
</script>
<asp:HiddenField ID="hDialogResult" runat="server" />
<table border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td valign="middle">
            <bec:TextBoxString ID="tb" runat="server" ReadOnly="true" />
        </td>
        <td valign="middle">
            <asp:ImageButton ID="ibParams" runat="server" ImageUrl="/Common/Images/default/16/find.png"
                CausesValidation="False" ToolTip="Параметры" 
                meta:resourcekey="ibParamsResource1" />
        </td>
        <td valign="middle">
            <asp:ImageButton ID="ibNew" runat="server" CausesValidation="False" ImageUrl="/Common/Images/default/16/new.png"
                ToolTip="Добавить новий" OnClick="ibNew_Click" 
                meta:resourcekey="ibNewResource1" />
        </td>
        <td valign="middle">
            <asp:ImageButton ID="ibNewFromRef" runat="server" CausesValidation="False" ImageUrl="/Common/Images/default/16/reference_open.png"
                ToolTip="Добавить из справочника" OnClick="ibNewFromRef_Click" 
                meta:resourcekey="ibNewFromRefResource1" />
        </td>
    </tr>
</table>
