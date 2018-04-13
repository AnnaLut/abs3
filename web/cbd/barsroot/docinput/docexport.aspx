<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DocExport.aspx.cs" Inherits="DocInput.DocExport"  CodeFileBaseClass="Bars.BarsPage" meta:resourcekey="PAGE"%>

<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Підпис проводок для експорту</title>
    <script type="text/javascript"  src="/Common/Script/Localization.js"></script>
	<script type="text/javascript" src="js/cDocSignExprt.js"></script>
	<link href="Styles.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript">
      function selectAll(ch)
      {    
        var rowCheckBox = document.getElementsByName("RowCheckBox")
        for (var i=0; i < rowCheckBox.length; i++) {      
    	  rowCheckBox[i].checked = ch;
		}    
	  }
	</script>
</head>
<body class="gv_body">
    <form id="formDocExport" runat="server">
    
        <Bars:BarsSqlDataSource ID="ds" runat="server" ProviderName="barsroot.core"
            SelectCommand="select&#13;&#10; rawtohex(utl_raw.cast_to_raw(bars_edocs.get_edoc_buf(docid))) as buf, --hide&#13;&#10;  docid,--hide&#13;&#10;  ref, --link&#13;&#10;  stmt,--hide&#13;&#10;  '/barsroot/documentview/default.aspx?ref='||to_char(ref) as doc_url,&#13;&#10;  mfoa,&#13;&#10;  nlsa,&#13;&#10;  mfob,&#13;&#10;  nlsb,&#13;&#10;  dk,&#13;&#10;  s/100 as s,&#13;&#10;  vob,&#13;&#10;  nd,&#13;&#10;  kv,&#13;&#10;  to_char(datd, 'dd.mm.yyyy') as datd,&#13;&#10;  to_char(datp, 'dd.mm.yyyy') as datp,&#13;&#10;  nam_a,&#13;&#10;  nam_b,&#13;&#10;  nazn,&#13;&#10;  d_rec,&#13;&#10;  id_a,&#13;&#10;  id_b,&#13;&#10;  ref_a&#13;&#10;from v_user_edocs&#13;&#10;where need_sign='Y'&#13;&#10;order by ref,stmt"
            SortExpression="ref, stmt">
        </Bars:BarsSqlDataSource>
        <Bars:BarsSqlDataSource ID="dsAll" runat="server" ProviderName="barsroot.core"
            SelectCommand="select&#13;&#10;  fio,&#13;&#10; rawtohex(utl_raw.cast_to_raw(bars_edocs_int.get_edoc_buf(null, docid))) as buf, --hide&#13;&#10;  docid,--hide&#13;&#10;  ref, --link&#13;&#10;  stmt,--hide&#13;&#10;  '/barsroot/documentview/default.aspx?ref='||to_char(ref) as doc_url,&#13;&#10;  mfoa,&#13;&#10;  nlsa,&#13;&#10;  mfob,&#13;&#10;  nlsb,&#13;&#10;  dk,&#13;&#10;  s/100 as s,&#13;&#10;  vob,&#13;&#10;  nd,&#13;&#10;  kv,&#13;&#10;  to_char(datd, 'dd.mm.yyyy') as datd,&#13;&#10;  to_char(datp, 'dd.mm.yyyy') as datp,&#13;&#10;  nam_a,&#13;&#10;  nam_b,&#13;&#10;  nazn,&#13;&#10;  d_rec,&#13;&#10;  id_a,&#13;&#10;  id_b,&#13;&#10;  ref_a&#13;&#10;from v_all_edocs&#13;&#10;where need_sign='Y'&#13;&#10;order by fio, ref, stmt"
            SortExpression="fio, ref, stmt" >
        </Bars:BarsSqlDataSource>
        
        <h4 meta:resourcekey="lblTitle" id="lblTitle" runat="server" enableviewstate="false">Підпис проводок для експорту</h4>
        
        <asp:PlaceHolder ID="placeHolder" runat="server"></asp:PlaceHolder>
        <br />
        <input id="ButtonSignTop" type="button" runat="server" value="Підписати вибрані" onclick="signDocs()" style="width:170px; margin-bottom: 10px;" meta:resourcekey="btnSign" enableviewstate="false" />
        
        
        
        
        <Bars:BarsGridView ID="gv" runat="server" AllowPaging="True" AllowSorting="True"
            DataSourceID="ds" PageSize="15" AutoGenerateColumns="False" meta:resourcekey="gvResource1" MergePagerCells="True" ShowFilter="True">
            <Columns>
<asp:TemplateField HeaderText="&lt;input id=&quot;cbSelectAllTop&quot; type=&quot;checkbox&quot; onclick=&quot;selectAll(checked)&quot;/&gt;"><ItemTemplate>
                        <input id="RowCheckBox" type="checkbox"/>
                    
</ItemTemplate>
</asp:TemplateField>
<asp:BoundField DataField="DOCID" HeaderText="DOCID">
<ItemStyle CssClass="GridViewHiddenCol"></ItemStyle>

<HeaderStyle CssClass="GridViewHiddenCol"></HeaderStyle>
</asp:BoundField>
<asp:BoundField DataField="BUF" HeaderText="BUF">
<ItemStyle CssClass="GridViewHiddenCol"></ItemStyle>

<HeaderStyle CssClass="GridViewHiddenCol"></HeaderStyle>
</asp:BoundField>
<asp:HyperLinkField HeaderText="REF документа" DataTextField="REF" DataNavigateUrlFields="DOC_URL" meta:resourceKey="REF"></asp:HyperLinkField>
<asp:BoundField DataField="STMT" HeaderText="STMT" meta:resourceKey="STMT">
<ItemStyle CssClass="GridViewHiddenCol"></ItemStyle>

<HeaderStyle CssClass="GridViewHiddenCol"></HeaderStyle>
</asp:BoundField>
<asp:BoundField DataField="MFOA" HeaderText="Код банку А" meta:resourceKey="MFOA">
<ItemStyle HorizontalAlign="Right"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="NLSA" HeaderText="Рахунок клiєнта банку А" meta:resourceKey="NLSA">
<ItemStyle HorizontalAlign="Right"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="MFOB" HeaderText="Код банку Б" meta:resourceKey="MFOB">
<ItemStyle HorizontalAlign="Right"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="NLSB" HeaderText="Рахунок клієнта банку Б" meta:resourceKey="NLSB">
<ItemStyle HorizontalAlign="Right"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="DK" HeaderText="Д/К" meta:resourceKey="DK">
<ItemStyle HorizontalAlign="Center"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="S" HeaderText="Сума платежу" meta:resourceKey="S"  DataFormatString="{0:F2}" HtmlEncode="False">
<ItemStyle HorizontalAlign="Right"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="VOB" HeaderText="Код документа" meta:resourceKey="VOB">
<ItemStyle HorizontalAlign="Right"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="ND" HeaderText="Номер (операційний) платежу" meta:resourceKey="ND">
<ItemStyle HorizontalAlign="Right"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="KV" HeaderText="Валюта платежу" meta:resourceKey="KV">
<ItemStyle HorizontalAlign="Center"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="DATD" HeaderText="Дата платіжного документа" meta:resourceKey="DATD">
<ItemStyle HorizontalAlign="Center"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="DATP" HeaderText="Дата надходження платіжного документа до банка А" meta:resourceKey="DATP">
<ItemStyle HorizontalAlign="Center"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="NAM_A" HeaderText="Найменування клієнта А" meta:resourceKey="NAM_A">
<ItemStyle Width="250px" Wrap="False"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="NAM_B" HeaderText="Найменування клієнта Б" meta:resourceKey="NAM_B">
<ItemStyle Width="250px" Wrap="False"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="NAZN" HeaderText="Призначення платежу"  meta:resourceKey="NAZN">
<ItemStyle Width="500px" Wrap="False" HorizontalAlign="Left"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="D_REC" HeaderText="Допоміжні реквізити" meta:resourceKey="D_REC">
<ItemStyle Width="220px" Wrap="False"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="ID_A" HeaderText="Ідентифікаційний код клієнта А" meta:resourceKey="ID_A">
<ItemStyle HorizontalAlign="Right"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="ID_B" HeaderText="Ідентифікаційний код клієнта Б" meta:resourceKey="ID_B">
<ItemStyle HorizontalAlign="Right"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="REF_A" HeaderText="Унікальний ідентифікатор документа в САБ" meta:resourceKey="REF_A">
<ItemStyle HorizontalAlign="Right"></ItemStyle>
</asp:BoundField>
</Columns>
            <RowStyle CssClass="gv_NormalRowStyle" />
            <SelectedRowStyle BackColor="White" />
            <PagerStyle HorizontalAlign="Left" />
            <HeaderStyle CssClass="gvHeaderRowStyle" />
            <AlternatingRowStyle CssClass="gv_AlternatingRowStyle" />
        </Bars:BarsGridView>
        <input id="ButtonSignBottom" type="button" runat="server" value="Підписати вибрані" onclick="signDocs()" style="width:170px; margin-top: 10px" meta:resourcekey="btnSign" enableviewstate="false"/>
        
        <table id="tblHiddenControls" style="visibility: hidden">
            <tr>    
                <td><input id="SEPNUM" value="" type="hidden" runat="server" style="width: 1px" /></td>
                <td><input id="IDOPER" value="" type="hidden" runat="server" style="width: 1px" /></td>
                <td><input id="SIGNTYPE" value="" type="hidden" runat="server" style="width: 1px" /></td>
                <td><input id="DOCKEY" value="" type="hidden" runat="server" style="width: 1px" /></td>
                <td><input id="REGNCODE" value="" type="hidden" runat="server" style="width: 1px" /></td>
                <td><input id="BARSAXVER" value="" type="hidden" runat="server" style="width: 1px" /></td>
                <td><input id="BDATE" value="" type="hidden" runat="server" style="width: 1px" /></td>
                <td><input id="SIGNS" value="" type="hidden" runat="server" style="width: 1px" /></td>
            </tr>
        </table> 
        <input id="Message20" meta:resourcekey="Message20" value="" type="hidden" runat="server" style="width: 1px" />
        <input id="Message21" meta:resourcekey="Message21" value="" type="hidden" runat="server" style="width: 1px" />
        <input id="Message22" meta:resourcekey="Message22" value="" type="hidden" runat="server" style="width: 1px" />
        
    </form>
</body>
</html>
