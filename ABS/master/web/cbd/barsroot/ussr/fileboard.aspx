<%@ Page Language="C#" AutoEventWireup="true" CodeFile="fileboard.aspx.cs" Inherits="FileBoard" EnableViewState="true" %>
<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link href="/common/css/barsgridview.css" rel="stylesheet" type="text/css" />
</head>
<body style="font-size:8pt">
    <form id="formFileBoard" runat="server">
        <div id="divTitle" runat="server" 
            style="border-bottom: 1px solid gray;font-size:12pt; color:Gray; margin-bottom:10px">
                Адмiнiстрування файлового сховища
        </div>
        
        <div>
        
            <Bars:BarsSqlDataSource ID="ds" ProviderName="barsroot.core" runat="server" EnableViewState="false" 
                SelectCommand="select * from bars_file_board order by file_name" 
                DeleteCommand="delete from bars_file_board where id=:id" OnSelected="ds_Selected" >
            </Bars:BarsSqlDataSource>  
            <Bars:BarsGridView ID="gv" runat="server"  
                    DateMask="dd.MM.yyyy hh:mm:ss" 
                    ShowFilter="True"
                    DataSourceID="ds" 
                    AllowPaging="True"
                    MergePagerCells="True" 
                    DataKeyNames="id" 
                    ShowPageSizeBox="True"
                    BackColor="White" 
                    AllowSorting="True" 
                    AutoGenerateColumns="False"
                    CssClass="barsGridView" 
                    OnRowDeleting="gv_RowDeleting" OnRowCommand="gv_RowCommand">
                <FooterStyle CssClass="footerRow" />
                <HeaderStyle CssClass="headerRow" />
                <EditRowStyle CssClass="editRow" />
                <PagerStyle CssClass="pagerRow" />
                <AlternatingRowStyle CssClass="alternateRow" />
                <RowStyle CssClass="normalRow" />                         
                <Columns>
                    <asp:TemplateField ShowHeader="False" Visible="False">
                        <itemtemplate>
                            <asp:ImageButton id="ImageButton1" runat="server" 
                                Text="Delete" CausesValidation="False" 
                                ImageUrl="/common/images/default/16/cancel.png" 
                                CommandName="Delete" CommandArgument='<%#Eval("ID")%>' >
                            </asp:ImageButton>
                        </itemtemplate>
                    </asp:TemplateField>
                    <asp:ButtonField CommandName="download" Text="Отримати" ButtonType="Image" ImageUrl="/common/images/default/16/arrow_down.png" />
                    <asp:BoundField HeaderText="Файл" DataField="file_name" />
                    <asp:BoundField DataField="file_desc" HeaderText="Опис файлу" >
                        <itemstyle width="400px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="modified" HeaderText="Дата завантаження" >
                        <itemstyle horizontalalign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="file_version" HeaderText="Верciя файлу" >
                        <itemstyle horizontalalign="Center" />
                    </asp:BoundField>                    
                    <asp:BoundField DataField="file_size" HeaderText="розмір файлу" >
                        <itemstyle horizontalalign="Center" />
                    </asp:BoundField>
                </Columns>
            </Bars:BarsGridView>             
        </div>
        <br />
        <table>
            <tr>
                <td>
                    <asp:Panel ID="pnlAddFile" GroupingText="Додати або поновити файл" runat="server">
                       <table>
                            <tr>
                              <td>Файл:</td>
                              <td><asp:FileUpload ID="fileUpload" runat="server" Width="350px" /></td>
                            </tr>
                            <tr>
                              <td>Опис:</td>
                              <td>
                                  <asp:TextBox ID="tbFileDesc" runat="server" EnableViewState="false"
                                        TextMode="MultiLine" MaxLength="256" Rows="5" Width="350px" >
                                  </asp:TextBox>
                              </td>
                            </tr> 
                            <tr>
                                <td align="right" colspan="2">
                                    <asp:Button ID="btnAddFile" runat="server" Text="OK" OnClick="btnAddFile_Click" /></td>
                            </tr>          
                        </table>        
                    </asp:Panel>
                    <asp:Label ID="lblErrm" ForeColor="red" runat="server" Text="" EnableViewState="false"></asp:Label>
                </td>
            </tr>
        </table>        
    </form>
</body>
</html>
