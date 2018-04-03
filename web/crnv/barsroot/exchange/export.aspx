<%@ Page Language="C#" AutoEventWireup="true" CodeFile="export.aspx.cs" Inherits="Export" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Экспорт платежей</title>
    <script type="text/javascript" language="javascript" src="/Common/WebEdit/RadInput.js"></script>
    <script type="text/javascript" language="javascript">
    <!--
    function fill_controls(){
        window["dt_start"].SetValue(document.getElementById('hd_bankdate_start').value);
        window["dt_finish"].SetValue(document.getElementById('hd_bankdate_finish').value);
    }
    // -->
    </script>
</head>
<body onload="javascript:fill_controls();">
    <form id="form_export" runat="server">
    <div>
        <asp:Label ID="label_info" runat="server" Text="Укажите период дат для экспорта документов"></asp:Label><br />
        <br />
        <asp:Label ID="label_start" runat="server" Text="с"></asp:Label>&nbsp;
        <input id='dt_start' type='hidden' runat="server"/><input id='dt_start_Value' type='hidden' name='dt_start' runat="server"/><input id='dt_start_TextBox' name='dt_start_TextBox' style="TEXT-ALIGN:center; width: 100px;" runat="server"/>
        <script type="text/javascript" language="javascript">
          window["dt_start"] = new RadDateInput("dt_start", 'Windows');
          window["dt_start"].PromptChar='_'; 
          window["dt_start"].DisplayPromptChar='_';
          window["dt_start"].SetMask(rdmskr(1, 31, false, true),rdmskl('.'),rdmskr(1,12, false, true),rdmskl('.'),rdmskr(1, 2099, false, true));
          window["dt_start"].RangeValidation=true; 
          window["dt_start"].SetMinDate('01.01.1900 00:00:00');
          window["dt_start"].SetMaxDate('31.12.2099 00:00:00');
          window["dt_start"].Initialize();
       </script>
        &nbsp;
        <asp:Label ID="label_finish" runat="server" Text="по"></asp:Label>&nbsp; &nbsp;<input id='dt_finish' type='hidden' runat="server"/><input id='dt_finish_Value' type='hidden' name='dt_finish' runat="server"/><input id='dt_finish_TextBox' name='dt_finish_TextBox' style="TEXT-ALIGN:center; width: 100px;" runat="server"/>
        <script type="text/javascript" language="javascript">
          window["dt_finish"] = new RadDateInput("dt_finish", 'Windows');
          window["dt_finish"].PromptChar='_'; 
          window["dt_finish"].DisplayPromptChar='_';
          window["dt_finish"].SetMask(rdmskr(1, 31, false, true),rdmskl('.'),rdmskr(1,12, false, true),rdmskl('.'),rdmskr(1, 2099, false, true));
          window["dt_finish"].RangeValidation=true; 
          window["dt_finish"].SetMinDate('01.01.1900 00:00:00');
          window["dt_finish"].SetMaxDate('31.12.2099 00:00:00');          
          window["dt_finish"].Initialize();
       </script>

        <br />
        <br />
        <asp:Button ID="bt_export" runat="server" Text="Экспорт" EnableViewState="False" OnClick="bt_export_Click" /><br />
        <asp:HiddenField ID="hd_bankdate_start" runat="server" EnableViewState="False" /><asp:HiddenField ID="hd_bankdate_finish" runat="server" EnableViewState="False" />
    </div>
    </form>
</body>
</html>
