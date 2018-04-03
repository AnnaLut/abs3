<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DepositCoowner.aspx.cs" Inherits="DepositCoowner" %>

<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<%@ Register Assembly="Bars.DataComponents, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c"
    Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Вибір власника депозиту</title>
    <link href="style/style.css" type="text/css" rel="stylesheet" />
    <link href="/Common/css/barsgridview.css" type="text/css" rel="stylesheet"/>		
    <script language="javascript" type="text/javascript" src="scripts/Default.js"></script>        
</head>
<body>
	<form id="Form1" method="post" runat="server">
		<table id="mainTable" class="MainTable">
			<tr>
				<td align="center">
					<asp:label id="lbSearchInfo" runat="server" CssClass="InfoHeader">Вибір власника соціального договору</asp:label>
				</td>
			</tr>
            <tr>
                <td align="center">
                </td>
            </tr>
			<tr>
				<td>
					<table id="tbl_Hint" class="InnerTable">
						<tr>
							<td style="width:45%">
								<input id="btSearch" class="AcceptButton" type="submit" value="Пошук" 
								    runat="server" tabindex="1" onserverclick="btSearch_ServerClick"/>
							</td>
							<td style="width:10%"></td>
							<td style="width:25%">
								<input id="btSelect" onclick="if (ckFill('rnk'))"
								 class="AcceptButton" type="button" value="Вибрати" runat="server"
									tabindex="2" onserverclick="btSelect_ServerClick"/>
							</td>
							<td style="width:20%">
                                &nbsp;</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
                    <bars:barsgridview id="gridCoowners" runat="server" allowsorting="True" autogeneratecolumns="False"
                        cssclass="BaseGrid" datemask="dd/MM/yyyy" onrowdatabound="gridCoowners_RowDataBound" DataSourceID="dsCoowners">
                        <Columns>
                            <asp:BoundField DataField="CONTRACT_NUM" HeaderText="Депозит" HtmlEncode="False" SortExpression="CONTRACT_NUM">
                                <itemstyle horizontalalign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="RNK" HeaderText="РНК" HtmlEncode="False" SortExpression="RNK">
                                <itemstyle horizontalalign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="OWNER_NAME" HeaderText="Тип" HtmlEncode="False" SortExpression="OWNER_NAME">
                                <itemstyle horizontalalign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NMK" HeaderText="ПІБ" HtmlEncode="False" SortExpression="NMK">
                                <itemstyle horizontalalign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SER" HeaderText="Серія" HtmlEncode="False" SortExpression="SER">
                                <itemstyle horizontalalign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NUMDOC" HeaderText="Номер" HtmlEncode="False" SortExpression="NUMDOC">
                                <itemstyle horizontalalign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="OWNER_TYPE" HeaderText="*" SortExpression="OWNER_TYPE" />
                        </Columns>
                    </bars:barsgridview>
                </td>
			</tr>
			<tr>
				<td>
                    <bars:barssqldatasource ProviderName = "barsroot.core" id="dsCoowners" runat="server"></bars:barssqldatasource>
                    <input id="rnk" type="hidden" runat="server" value="null"/>&nbsp;
                    <input id="owner_type" type="hidden" runat="server" value="null"/></td>
			</tr>
		</table>
	</form>
    <script type="text/javascript">
       var oldonload = window.onload;
       window.onload = function() 
       {
           if (oldonload)   oldonload();
           focusControl('btSearch');
       }       
    </script>	
</body>
</html>
