<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SetCurRatesBase.aspx.cs" Inherits="SetCurRatesBase"  Culture="auto" meta:resourcekey="PageResource1" UICulture="uk" %>

<%@ Register Assembly="Bars.Web.Controls, Version=1.0.0.4, Culture=neutral, PublicKeyToken=464dd68da967e56c"
    Namespace="Bars.Web.Controls" TagPrefix="Bars" %>

<%@ Register Assembly="Bars.DataComponents, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c"
    Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Установка курсов купли/продажи валют</title>
    <link href="Styles.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="js/CurRatesBase.js"></script>
</head>
<body class="gv_body">
    <form id="formCurRatesBase" runat="server">
    <div>
        <Bars:BarsSqlDataSource id="ds" runat="server" ProviderName="barsroot.core" selectcommand="select kv, vdate as vdate, bsum,nvl(rate_o,0) as rate_o, nvl(rate_b,0) as rate_b, nvl(rate_s,0) as rate_s, branch, otm&#13;&#10;from cur_rates$base v_cur_rates&#13;&#10;where branch=:b and vdate=bankdate&#13;&#10;order by vdate desc, branch, kv" UpdateCommand="bars_cur_rates.set_rate" UpdateCommandType="StoredProcedure" OldValuesParameterFormatString="ori_{0}" >
            <updateparameters>
            <asp:Parameter Name="ori_kv" Type="Decimal" ></asp:Parameter>
            <asp:Parameter Name="ori_vdate" Type="DateTime" ></asp:Parameter>
            <asp:Parameter Name="ori_branch" Type="String" Size="200" ></asp:Parameter>
            <asp:Parameter Name="rate_b" Type="Decimal"></asp:Parameter>
            <asp:Parameter Name="rate_s" Type="Decimal"></asp:Parameter>
            </updateparameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlBranch" Name="b" PropertyName="SelectedValue"
                    Size="100" Type="String" />
            </SelectParameters>
        </bars:BarsSqlDataSource>
        <Bars:BarsSqlDataSource id="dsArch" runat="server" ProviderName="barsroot.core" selectcommand="select kv,vdate, bsum,nvl(rate_o,0) as rate_o, nvl(rate_b,0) as rate_b, nvl(rate_s,0) as rate_s, branch&#13;&#10;from cur_rates$base v_cur_rates&#13;&#10;where branch=:b&#13;&#10;order by vdate desc, branch, kv" >
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlBranch" Name="b" PropertyName="SelectedValue"
                    Size="100" Type="String" />
            </SelectParameters>
        </Bars:BarsSqlDataSource>
        <Bars:BarsSqlDataSource id="dsBranch" runat="server" ProviderName="barsroot.core" selectcommand="select branch, branch||' '||name as branch_name&#13;&#10;from our_branch&#13;&#10;where branch=branch_usr.get_branch&#13;&#10;order by branch">
        </Bars:BarsSqlDataSource>
        <asp:Label ID="lblHeader" runat="server" CssClass="BarsLabel" Text="Установка торговых курсов купли/продажи валют" meta:resourcekey="lblHeaderResource1"></asp:Label><br />
        <br />
        <asp:Label ID="lblBranch" runat="server" Text="Подразделение:" Font-Bold="True" meta:resourcekey="lblBranchResource1"></asp:Label><br />
        <asp:DropDownList ID="ddlBranch" runat="server" AutoPostBack="True" DataMember="DefaultView"
            DataSourceID="dsBranch" DataTextField="branch_name" DataValueField="branch" Width="470px" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged" Enabled="False" meta:resourcekey="ddlBranchResource1">
        </asp:DropDownList>&nbsp;<br />
        <br />
        <table width="100%">
            <tr>
                <td style="height: 26px">
                    <Bars:ImageTextButton 
                        ID="itbRefresh" runat="server" ButtonStyle="ImageAndText"   Style="float:left" 
                        ImageUrl="/common/images/default/16/refresh.png" Text="Обновить" Width="106px" meta:resourcekey="itbRefreshResource1" ToolTip="Обновить"  
                    />
                    &nbsp;
                </td>
                <td style="height: 26px">
                    <Bars:ImageTextButton ID="itbArchive" runat="server" Style="float:right"
                        ImageUrl="/common/images/default/16/filter.png" Text="Показать архив" UseSubmitBehavior="False" OnClientClick="return ShowHideArchive();" Width="144px" ButtonStyle="ImageAndText" meta:resourcekey="itbArchiveResource1" ToolTip="Показать архив" 
                    />
                </td>
            </tr>
        </table>
        <Bars:BarsGridView id="gv" runat="server" DataSourceID="ds" AutoGenerateColumns="False" 
            DataKeyNames="kv,vdate,branch" DataMember="DefaultView" Style="float:left" Width="100%" OnRowCommand="gv_RowCommand" OnRowCreated="gv_RowCreated" meta:resourcekey="gvResource1" >
            <Columns>
                <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                    <itemstyle width="18px" />
                    <itemtemplate>
<Bars:ImageTextButton runat="server" ID="itbVisa" UseSubmitBehavior="False" ToolTip="Виза" Text="Виза" CommandName="Visa" ButtonStyle="ImageAndText" Visible='<%# Eval("otm").ToString()!="Y" %>' ImageUrl="/common/images/default/16/visa.png" __designer:wfdid="w22" meta:resourcekey="itbVisaResource1" OnClick="itbVisa_Click"></Bars:ImageTextButton>
 <Bars:ImageTextButton runat="server" ID="itbVisaStorno" UseSubmitBehavior="False" ToolTip="Отмена визы" Text="Отмена визы" CommandName="VisaStorno" ButtonStyle="ImageAndText" Visible='<%# Eval("otm").ToString()=="Y" %>' ImageUrl="/common/images/default/16/visa_storno.png" __designer:wfdid="w23" meta:resourcekey="itbVisaStornoResource1"></Bars:ImageTextButton>
 
</itemtemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="KV" HeaderText="Валюта" ReadOnly="True" meta:resourcekey="BoundFieldResource1" >
                    <itemstyle HorizontalAlign="Right" Width="50px" />
                </asp:BoundField>
                <asp:BoundField DataField="VDATE" HeaderText="Дата" ReadOnly="True" DataFormatString="{0:dd.MM.yyyy}" meta:resourcekey="BoundFieldResource2">
                    <itemstyle HorizontalAlign="Center" Width="100px" />
                </asp:BoundField>
                <asp:BoundField DataField="BSUM" HeaderText="Базовая сумма" ReadOnly="True" meta:resourcekey="BoundFieldResource3">
                    <itemstyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="RATE_O" HeaderText="Официальный курс" ReadOnly="True" meta:resourcekey="BoundFieldResource4">
                    <itemstyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Курс продажи" meta:resourcekey="TemplateFieldResource2">
                    <EditItemTemplate>
<Bars:NumericEdit runat="server" Width="60px" ID="neRateS" Presiction="4" Value='<%# Bind("RATE_S") %>' GroupSeparator="" meta:resourcekey="neRateSResource1"></Bars:NumericEdit>

                    
</EditItemTemplate>
                    <ItemStyle HorizontalAlign="Right" Width="68px" />
                    <ItemTemplate>
<asp:Label runat="server" Text='<%# Eval("rate_s") %>'  ID="lblRateS" meta:resourcekey="lblRateSResource1"></asp:Label>

                    
</ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Курс покупки" meta:resourcekey="TemplateFieldResource3">
                    <EditItemTemplate>
<Bars:NumericEdit runat="server" Width="60px" ID="neRateB" Presiction="4" Value='<%# Bind("RATE_B") %>' GroupSeparator="" meta:resourcekey="neRateBResource1"></Bars:NumericEdit>

                    
</EditItemTemplate>
                    <ItemStyle HorizontalAlign="Right" Width="68px" />
                    <ItemTemplate>
<asp:Label runat="server" Text='<%# Eval("rate_b") %>' ID="lblRateB" meta:resourcekey="lblRateBResource1"></asp:Label>

                    
</ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField meta:resourcekey="TemplateFieldResource4">
                    <EditItemTemplate>
<Bars:ImageTextButton  runat="server" ID="itbUpdate" UseSubmitBehavior="False" ToolTip="Update" Text="Update" CommandName="Update" ButtonStyle="Image" ImageUrl="/common/images/default/16/ok.png" meta:resourcekey="itbUpdateResource1"></Bars:ImageTextButton>
 <Bars:ImageTextButton runat="server" ID="itbCancel" UseSubmitBehavior="False" ToolTip="Cancel" Text="Cancel" CommandName="Cancel" ButtonStyle="Image" ImageUrl="/common/images/default/16/cancel.png" meta:resourcekey="itbCancelResource1"></Bars:ImageTextButton>
 
</EditItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="50px" />
                    <ItemTemplate>
<Bars:ImageTextButton runat="server" ID="itbEdit"  Enabled='<%# Eval("otm").ToString()!="Y"%>' UseSubmitBehavior="False" ToolTip="Edit" Text="Edit" CommandName="Edit" ButtonStyle="Image" ImageUrl="/common/images/default/16/open.png" meta:resourcekey="itbEditResource1"></Bars:ImageTextButton>
 
</ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle CssClass="gv_NormalRowStyle" />
            <HeaderStyle CssClass="gvHeaderRowStyle" Height="30px" />
            <AlternatingRowStyle CssClass="gv_AlternatingRowStyle" />
        </bars:BarsGridView>
        &nbsp;&nbsp;<br />&nbsp
        <br />
        <asp:Label ID="lblArch" runat="server" Text="Архив:" Font-Bold="True" meta:resourcekey="lblArchResource1"></asp:Label>
        <hr runat="server" id="hrArch" />
        <Bars:BarsGridView id="gvArch" runat="server" DataSourceID="dsArch" AutoGenerateColumns="False"  
            AllowPaging="True" Style="float:left" Width="100%" AllowSorting="True" ShowPageSizeBox="True" meta:resourcekey="gvArchResource1" ShowFilter="True" >
            <Columns>
                <asp:BoundField DataField="KV" HeaderText="Валюта" ReadOnly="True" meta:resourcekey="BoundFieldResource5" >
                    <itemstyle HorizontalAlign="Right" Width="50px" />
                </asp:BoundField>
                <asp:BoundField DataField="VDATE" HeaderText="Дата" ReadOnly="True" DataFormatString="{0:dd.MM.yyyy}" meta:resourcekey="BoundFieldResource6">
                    <itemstyle HorizontalAlign="Center" Width="100px" />
                </asp:BoundField>
                <asp:BoundField DataField="BSUM" HeaderText="Базовая сумма" ReadOnly="True" meta:resourcekey="BoundFieldResource7">
                    <itemstyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="RATE_O" HeaderText="Официальный курс" ReadOnly="True" meta:resourcekey="BoundFieldResource8">
                    <itemstyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="RATE_S" HeaderText="Курс продажи" ReadOnly="True" meta:resourcekey="BoundFieldResource9">
                    <itemstyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="RATE_B" HeaderText="Курс покупки" ReadOnly="True" meta:resourcekey="BoundFieldResource10">
                    <itemstyle HorizontalAlign="Right" />
                </asp:BoundField>                                
            </Columns>
            <RowStyle CssClass="gv_NormalRowStyle" />
            <HeaderStyle CssClass="gvHeaderRowStyle" Height="30px" />
            <AlternatingRowStyle CssClass="gv_AlternatingRowStyle" />
        </Bars:BarsGridView>
        <asp:TextBox ID="msg1" runat="server" Visible="false" meta:resourcekey="msg1"/>
        <asp:TextBox ID="msg2" runat="server" Visible="false" meta:resourcekey="msg2"/>
        <asp:TextBox ID="msg3" runat="server" Visible="false" meta:resourcekey="msg3"/>        
        <asp:TextBox ID="msg4" runat="server" Visible="false" meta:resourcekey="msg4"/>        
        <asp:TextBox ID="msg5" runat="server" Visible="false" meta:resourcekey="msg5"/>        
        <asp:TextBox ID="msg6" runat="server" Visible="false" meta:resourcekey="msg6"/>        
        <asp:TextBox ID="msg7" runat="server" Visible="false" meta:resourcekey="msg7"/>        
        </div>
    </form>
</body>
</html>
