<%@ Page language="c#" Inherits="barsroot.barsweb.Welcome"  enableViewState="True" CodeFile="welcome.aspx.cs" %>

<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>Welcome</title>
		<link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet"/>		
		<style type="text/css">
		  .date
		  {
		    font-size:8pt;
		  }
		  .title
		  {
		    font-weight:bold;
		    font-size: 11pt;
		    border-bottom: dashed 1px #DFDFDF;
		    width: 100%;
		  }
		  .text
		  {
		    padding-left: 20px;
		    padding-bottom: 20px;
		    font-size: 10pt;
		  }
		</style>
    </HEAD>
	<body style="font-size:10pt;">
		<form id="Form1" method="post" runat="server">
			<table id="table1" cellspacing="1" cellpadding="1" border="0">
                <tr valign="top">
                    <td>
                        <Bars:BarsSqlDataSource ID="ds" runat="server" ProviderName="barsroot.core"
                            SelectCommand="select to_char(b.msg_date,'dd.MM.yyyy HH24:mi') msg_date, b.msg_title, b.msg_text, s.fio from bars_board b, v_board_staff s where b.writer = s.logname order by b.id desc">
                        </Bars:BarsSqlDataSource>                                
                        <Bars:BarsGridView ID="gvBoards"
                            DataSourceID="ds"
                            runat="server" 
                            CssClass="grid" 
                            ShowHeader="false" 
                            AutoGenerateColumns="False" 
                            GridLines="none" AllowPaging="True" PageSize="5" OnRowCommand="gvBoards_RowCommand">
                            
                           <Columns>
                               <asp:TemplateField HeaderText="Дата">
                                   <ItemTemplate>
                                       <div class="title"> 
                                           <asp:Label CssClass="date" ID="Label1" runat="server" Text='<%# Convert.ToString(Eval("MSG_DATE")) + " " + Convert.ToString(Eval("FIO")) %>'></asp:Label>
                                           <%# Eval("MSG_TITLE") %>
                                       </div>
                                       <p runat="server" class="text"><%# Eval("MSG_TEXT") %></p>
                                   </ItemTemplate>
                                   <ItemStyle Width="100%" />
                               </asp:TemplateField>
                            </Columns>
                        </Bars:BarsGridView>
                    </td>
                </tr>
				<tr>
					<td align="center" id="tdInfo">
						<p>
						    <br />
						    <asp:Label id="labelBankdateClosed" runat="server" Font-Size="10pt" Font-Bold="True" EnableViewState="False" ForeColor="Red"></asp:Label>
                        </p>
					</td>
				</tr>
				<tr>
					<td valign="bottom" style="height:60%" align="right">
						<asp:Label id="Label11" runat="server" Font-Names="Arial" Font-Size="9pt">Copyright © 2004-2006, UNITY-BARS </asp:Label>
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
