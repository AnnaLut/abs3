<%@ Page Language="C#" AutoEventWireup="true" Inherits="Qdocs" CodeFile="default.aspx.cs" 
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
</head>
<body>
    <form id="wfSepQdocs" runat="server">
    <div>
        <asp:Label ID="lblTitle" runat="server" CssClass="PageTitle"
            Text="Информационные сообщения СЭП" meta:resourcekey="lblTitleResource"></asp:Label>
    </div>
    <div>
        <br />            
        <Bars:BarsSqlDataSourceEx ID="ds" runat="server" ProviderName="barsroot.core" AllowPaging="true" SelectCommand="select 
 dk,
 rec,
 ref,
 datd,
 nd,
 vob,
 mfoa,
 nlsa,
 kv,
 s,
 nlsb,
 nam_b,
 nazn,
 d_rec,
 to_char(dat_a, 'dd.mm.yyyy hh24:mi:ss') as dat_a, fn_a, 
 nam_a,
 id_a,
 id_b,
 datp,
 nms,
 ostc,
 lim,
 pap,
 otm 
from v_sep_qdocs
order by rec"/>
       <!-- <bars:ImageTextButton ID="btnRefresh" runat="server" ImageUrl="/common/images/default/16/refresh.png" meta:resourcekey="btnRefresh" CommandName="RefreshDoc" OnCommand="toolBar_Command" ButtonStyle="Image" UseSubmitBehavior="False" />
        <bars:Separator ID="Separator3" runat="server" /> !-->
        <bars:ImageTextButton ID="btnOpenDoc" runat="server" 
            ImageUrl="/common/images/default/16/open.png" meta:resourcekey="btnOpenDoc"  
            CommandName="OpenDoc" OnCommand="toolBar_Command" ButtonStyle="Image" 
            UseSubmitBehavior="False"/>
        <bars:Separator ID="Separator1" runat="server" />
        <bars:ImageTextButton ID="btnReturnDoc" runat="server" ImageUrl="/common/images/default/16/arrow_up.png" meta:resourcekey="btnReturnDoc"  CommandName="BackDoc" OnCommand="toolBar_Command" OnInit="btnReturnDoc_Init" ButtonStyle="Image" UseSubmitBehavior="False"/>
        <bars:Separator ID="Separator2" runat="server" />
        <bars:ImageTextButton ID="btnDeleteDoc" runat="server" ImageUrl="/common/images/default/16/cancel.png" meta:resourcekey="btnDeleteDoc" CommandName="DeleteDoc" OnCommand="toolBar_Command" OnInit="btnDeleteDoc_Init" ButtonStyle="Image" UseSubmitBehavior="False" />
        &nbsp;&nbsp;&nbsp;<asp:PlaceHolder ID="placeHolder" runat="server" EnableViewState="False"></asp:PlaceHolder>
    </div>
        <Bars:BarsGridViewEx ID="gv" runat="server" AllowPaging="True" 
            DataSourceID="ds" AllowSorting="True"  ShowPageSizeBox="true"
            ShowFilter="True" AlternatingRowStyle-CssClass="gv_AlternatingRowStyle" 
            AutoGenerateColumns="False"  ShowCaption="false"
            OnRowCreated="gv_RowCreated" DataKeyNames="rec" meta:resourcekey="gvResource1" EnableViewState="false" >
            <Columns>
               <asp:TemplateField>
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
