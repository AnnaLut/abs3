<%@ Page Language="C#" AutoEventWireup="true" CodeFile="docexportback.aspx.cs" Inherits="docinput_docexportback" Culture="auto" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>

<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link href="Styles.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="js/GVSelection.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <bars:barssqldatasource id="ds" runat="server" ProviderName="barsroot.core" selectcommand="select   &#13;&#10; '/barsroot/documentview/default.aspx?ref='||to_char(ref) as doc_url,&#13;&#10;  REF,&#13;&#10;  tt,&#13;&#10;  pdat,&#13;&#10;  vdat,&#13;&#10;  nam_a,&#13;&#10;  nlsa,&#13;&#10;  mfoa,&#13;&#10;  nam_b,&#13;&#10;  nlsb,&#13;&#10;  mfob,&#13;&#10;  s, kv, &#13;&#10;  nazn &#13;&#10;from v_user_extdoc_back order by ref desc"></bars:barssqldatasource>
        <bars:barssqldatasource id="dsAll" runat="server" ProviderName="barsroot.core" SelectCommand="select&#13;&#10;  '/barsroot/documentview/default.aspx?ref='||to_char(ref) as doc_url,&#13;&#10;  REF,&#13;&#10;  tt,&#13;&#10;  pdat,&#13;&#10;  vdat,&#13;&#10;  nam_a,&#13;&#10;  nlsa,&#13;&#10;  mfoa,&#13;&#10;  nam_b,&#13;&#10;  nlsb,&#13;&#10;  mfob,&#13;&#10;  s, kv, &#13;&#10;  nazn&#13;&#10;from v_all_extdoc_back&#13;&#10;order by ref desc"></bars:barssqldatasource>
        <asp:Label ID="Label1" runat="server" CssClass="title" Text="Сторнирование отбракованных документов" meta:resourcekey="Label1Resource1"></asp:Label>
        <br />
        <br />
        <cc1:imagetextbutton id="ImageTextButton1" runat="server" ImageUrl="/common/images/default/16/visa_storno.png" Text="Сторнировать" CommandName="Storno" OnCommand="ImageTextButton1_Command" EnabledAfter="0" meta:resourcekey="ImageTextButton1Resource1" OnClientClick="if (!showReasonDlg()) return false; " ToolTip="Сторнировать"></cc1:imagetextbutton>
        <br />
        <br />
        <bars:barsgridview id="gv" runat="server" allowpaging="True"
            datasourceid="ds" AutoGenerateColumns="False" OnRowDataBound="gv_RowDataBound" DataKeyNames="ref" meta:resourcekey="gvResource1">
            <Columns>
                 <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                    <ItemTemplate>
<asp:CheckBox runat="server" ID="chkSelect" meta:resourceKey="chkSelectResource1"></asp:CheckBox>

                    
</ItemTemplate>
                </asp:TemplateField>    
                <asp:HyperLinkField DataNavigateUrlFields="DOC_URL" DataTextField="REF" HeaderText="Референс операции"
                    SortExpression="REF" meta:resourcekey="HyperLinkFieldResource1" >
                    <itemstyle horizontalalign="Right" />
                </asp:HyperLinkField>
                <asp:BoundField DataField="TT" HeaderText="Операция" SortExpression="TT" meta:resourcekey="BoundFieldResource1">
                    <itemstyle horizontalalign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="PDAT" HeaderText="Дата поступления" SortExpression="PDAT" meta:resourcekey="BoundFieldResource2">
                    <itemstyle horizontalalign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="VDAT" HeaderText="Дата валютирования" SortExpression="VDAT" meta:resourcekey="BoundFieldResource3">
                    <itemstyle horizontalalign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="NAM_A" HeaderText="Наименование отаравителя" SortExpression="NAM_A" meta:resourcekey="BoundFieldResource4">
                    <itemstyle horizontalalign="Left" wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="NLSA" HeaderText="Счет-А" SortExpression="NLS_A" meta:resourcekey="BoundFieldResource5">
                    <itemstyle horizontalalign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="MFOA" HeaderText="МФО-А" SortExpression="MFO_A" meta:resourcekey="BoundFieldResource6">
                    <itemstyle horizontalalign="Right" />
                </asp:BoundField>                
                <asp:BoundField DataField="NAM_B" HeaderText="Наименование получателя" SortExpression="NAM_B" meta:resourcekey="BoundFieldResource7">
                    <itemstyle horizontalalign="Left" wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="NLSB" HeaderText="Счет-B" SortExpression="NLS_B" meta:resourcekey="BoundFieldResource8">
                    <itemstyle horizontalalign="Right" />
                </asp:BoundField>                
                <asp:BoundField DataField="MFOB" HeaderText="МФО-B" SortExpression="MFO_B" meta:resourcekey="BoundFieldResource9">
                    <itemstyle horizontalalign="Right" />
                </asp:BoundField>   
                <asp:BoundField DataField="KV" HeaderText="Валюта" SortExpression="KV" meta:resourcekey="BoundFieldResource10">
                    <itemstyle horizontalalign="Right" />
                </asp:BoundField>                   
                <asp:BoundField DataField="S" HeaderText="Сумма" SortExpression="S" DataFormatString="{0:F2}" HtmlEncode="False" meta:resourcekey="BoundFieldResource11">
                    <itemstyle horizontalalign="Right" />
                </asp:BoundField>        
                <asp:BoundField DataField="NAZN" HeaderText="Назначение платежа" SortExpression="NAZN" meta:resourcekey="BoundFieldResource12">
                    <itemstyle horizontalalign="Left" wrap="False" />
                </asp:BoundField>                                               
            </Columns>
            <HeaderStyle ForeColor="#707070" />
        </bars:barsgridview>
    </div>
    <asp:hiddenfield ID="hid_SR" runat="server"></asp:hiddenfield>
    <asp:hiddenfield ID="hid_SR_text" runat="server"></asp:hiddenfield>
    </form>
</body>
</html>
