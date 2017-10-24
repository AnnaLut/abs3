<%@ Control Language="C#" AutoEventWireup="true" CodeFile="WebPartManagerPanel.ascx.cs" Inherits="BarsWebPartManagerPanel" %>
<asp:WebPartManager ID="BarsPartManager" runat="server"></asp:WebPartManager>
<div runat=server id=divImg align=right class="Toolbar">
    <asp:LinkButton ID="lnShowOptions" runat="server" meta:resourcekey="lnShowOptionsResource" OnClick="lnShowOptions_Click" CssClass="Menu">Управление стартовой страницей</asp:LinkButton>&nbsp;</div>
<div runat=server id=divControls visible=false>
<table class="Toolbar" border="0" cellpadding="0" cellspacing="2" width="100%">	
	<tr>
		<td align="right">
		  <span>
			<asp:LinkButton ID="cmdBrowseView" runat="server" OnClick="cmdBrowseView_Click" CssClass="Menu" meta:resourcekey="cmdBrowseViewResource" >Browse View</asp:LinkButton>&nbsp;|&nbsp;
		  </span>	
		  <span>
			<asp:LinkButton ID="cmdDesignView" runat="server" OnClick="cmdDesignView_Click" CssClass="Menu" meta:resourcekey="cmdDesignViewResource">Design View</asp:LinkButton>&nbsp;|&nbsp;
      </span>	
		  <span>
			<asp:LinkButton ID="cmdEditView" runat="server" OnClick="cmdEditView_Click" CssClass="Menu" meta:resourcekey="cmdEditViewResource">Edit View</asp:LinkButton>&nbsp;|&nbsp;
      </span>	
		  <span>
			<asp:LinkButton ID="cmdCatalogView" runat="server" CssClass="Menu" OnClick="cmdCatalogView_Click" meta:resourcekey="cmdCatalogViewResource">Catalog View</asp:LinkButton>&nbsp;|&nbsp;
      </span>	
		  <span>
			<asp:LinkButton ID="cmdClear" runat="server" CssClass="Menu" OnClick="cmdClear_Click" meta:resourcekey="cmdClearResource">Clear</asp:LinkButton>&nbsp;|&nbsp;
      </span>	
      <span>
			<asp:LinkButton ID="cmdHide" runat="server" CssClass="Menu" meta:resourcekey="cmdHideResource" OnClick="cmdHide_Click">Hide</asp:LinkButton>&nbsp;|&nbsp;
      </span>	
		</td>
  </tr>
  <tr>
		<td align=right>				
		    <asp:Label runat="server" ID="lbCurrMode" meta:resourcekey="lbCurrModeResource">
            </asp:Label><asp:Label ForeColor=Black runat="server" ID="lbModeValue"></asp:Label>
	  </td>
  </tr>
</table>
</div>