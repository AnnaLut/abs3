<%@ Page Language="C#" AutoEventWireup="true" Inherits="Qdocs" CodeFile="info_req.aspx.cs" 
    EnableViewState="False" CodeFileBaseClass="Bars.BarsPage"  
    meta:resourcekey="Qdocs" %>

<%@ Register Assembly="Bars.Web.Controls, Version=1.0.0.4, Culture=neutral, PublicKeyToken=464dd68da967e56c"
    Namespace="Bars.Web.Controls" TagPrefix="bars" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Информационные сообщения СЭП</title>
    <link href="css/Default.css" type="text/css" rel="Stylesheet"/>
    <script type="text/javascript" src="js/Qdocs.js"></script>
    <script language="javascript" type="text/javascript" src="/Common/jquery/jquery.js"></script>
    <script language="javascript" type="text/javascript" src="/Common/jquery/jquery-ui.js"></script>
</head>
<body>
    <form id="wfSepQdocs" runat="server">
    <div>
        <asp:Label ID="lblTitle" runat="server" CssClass="PageTitle"
            Text="Информационные сообщения СЭП" meta:resourcekey="lblTitleResource"></asp:Label>
    </div>

    <div>
        <br />            
        <Bars:BarsSqlDataSourceEx ID="ds" runat="server" ProviderName="barsroot.core" AllowPaging="true" SelectCommand="select * from V_SEP_QDOCS_IMM order by rec"/>
        <bars:ImageTextButton ID="ImageTextButton1" runat="server" 
            ImageUrl="/common/images/default/16/gear_run.png" meta:resourcekey="btnRun"  
            OnClick="btnRun_Click" ButtonStyle="Image"/>
        &nbsp;&nbsp;&nbsp;<asp:PlaceHolder ID="placeHolder" runat="server" EnableViewState="False"></asp:PlaceHolder>
    </div>
        <Bars:BarsGridViewEx ID="gv" runat="server" AllowPaging="True" PageSize="100"
            DataSourceID="ds" AllowSorting="True"  ShowPageSizeBox="true"
            ShowFilter="True" AlternatingRowStyle-CssClass="gv_AlternatingRowStyle" 
            AutoGenerateColumns="False"  ShowCaption="false"
            OnRowCreated="gv_RowCreated" DataKeyNames="rec" meta:resourcekey="gvResource1" EnableViewState="false" >
            <Columns>
               <asp:TemplateField>
                    <HeaderTemplate>
                        <span>Всі</span><br />
                        <asp:CheckBox runat="server" EnableViewState="False" ID="chkSelectAll" meta:resourcekey="chkSelectResource1" OnClick="if (this.checked) SelectAllRows(); if(!this.checked) DeSelectAllRows()"></asp:CheckBox>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox runat="server" EnableViewState="False" ID="chkSelect" meta:resourcekey="chkSelectResource1"></asp:CheckBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="REC" HeaderText="Референс сообщения" meta:resourcekey="Rec" />
                <asp:BoundField DataField="DATD" HeaderText="Дата поступления" meta:resourcekey="PostDate" />
                <asp:BoundField DataField="DK" HeaderText="Д/К" meta:resourcekey="DK" />
                <asp:BoundField DataField="MFOA" HeaderText="МФО А" meta:resourcekey="MFOA" >
                    <itemstyle horizontalalign="Right" />
                </asp:BoundField>                  
                <asp:BoundField DataField="NLSA" HeaderText="Счет А" meta:resourcekey="NLSA" >
                    <itemstyle horizontalalign="Right" />
                </asp:BoundField>                    
                <asp:BoundField DataField="KV" HeaderText="ВАЛ" meta:resourcekey="VAL" />
                <asp:BoundField DataField="ID_A" HeaderText="ОКПО А" meta:resourcekey="OKPOA" >
                    <itemstyle horizontalalign="Right" />
                </asp:BoundField>    
                <asp:BoundField DataField="NAM_A" HeaderText="Название" meta:resourcekey="NAMA"/>
                <asp:BoundField DataField="S" HeaderText="Сумма" meta:resourcekey="S" />
                <asp:BoundField DataField="NLSB" HeaderText="Наш счет" meta:resourcekey="NLSB" >
                    <itemstyle horizontalalign="Right" />
                </asp:BoundField>                  
                <asp:BoundField DataField="ID_B" HeaderText="ОКПО В" meta:resourcekey="OKPOB" >
                    <itemstyle horizontalalign="Right" />
                </asp:BoundField>                 
                <asp:BoundField DataField="NAM_B" HeaderText="Название счета из сообщения" meta:resourcekey="NAMB" />
                <asp:BoundField DataField="OSTC" HeaderText="Остаток" meta:resourcekey="OSTC" />
                <asp:BoundField DataField="FN_A" HeaderText="Файл А$" meta:resourcekey="FN_A" />
                <asp:BoundField DataField="DAT_A" HeaderText="Дата создания файла $A" meta:resourcekey="DAT_A" />
            </Columns>
            <AlternatingRowStyle CssClass="gv_AlternatingRowStyle" />
        </Bars:BarsGridViewEx>
        <asp:Label ID="lblMsg1" runat="server" Visible="False" meta:resourcekey="Msg1" EnableViewState="False" />
        <asp:Label ID="lblMsg2" runat="server" Visible="False" meta:resourcekey="Msg2" EnableViewState="False" />
        <asp:Label ID="lblMsg3" runat="server" Visible="False" meta:resourcekey="Msg3" EnableViewState="False" />
        <asp:Label ID="lblMsg4" runat="server" Visible="False" meta:resourcekey="Msg4" EnableViewState="False" />
        <asp:Label ID="lblMsg5" runat="server" Visible="False" meta:resourcekey="Msg5" EnableViewState="False" />
        <asp:Label ID="lblMsg6" runat="server" Visible="False" meta:resourcekey="Msg6" EnableViewState="False" />
        <asp:Label ID="lblMsg7" runat="server" Visible="False" meta:resourcekey="Msg7" EnableViewState="False" />
        <asp:Label ID="lblMsg8" runat="server" Visible="False" meta:resourcekey="Msg8" EnableViewState="False" />
        <asp:Label ID="lblMsg9" runat="server" Visible="False" meta:resourcekey="Msg9" EnableViewState="False" />
        <asp:Label ID="lblMsg10" runat="server" Visible="False" meta:resourcekey="Msg10" EnableViewState="False" />
        <asp:Label ID="lblMsg11" runat="server" Visible="False" meta:resourcekey="Msg11" EnableViewState="False" />
    </form>
</body>
</html>
