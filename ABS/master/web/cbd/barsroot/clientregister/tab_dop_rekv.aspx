<%@ Page Language="C#" AutoEventWireup="true" CodeFile="tab_dop_rekv.aspx.cs" Inherits="clientregister_tab_dop_rekv"
    Culture="auto" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Дополнительные реквизиты</title>
    <link href="DefaultStyleSheet.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/BarsGridView.css" rel="Stylesheet" type="text/css" />
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    
    <script type="text/javascript" src="../Scripts/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../scripts/jquery/jquery.maskMoney.js"></script>
    <script type="text/javascript" src="../Scripts/jquery/jquery.numbermask.js"></script>
    <script type="text/javascript" src="../scripts/jquery/jquery.maskedinput-1.3.1.js"></script>

    <script language="javascript" type="text/jscript" src="JScriptFortab_dop_rekv.js?v1.8"></script>
    <script language="javascript" type="text/jscript" src="additionalFuncs.js"></script>

</head>
<body onload="InitObjects();">
    <link href="../Content/Themes/ModernUI/css/WebTab.css" rel="stylesheet" />
    <form id="form1" runat="server">
        <div style="padding-left: 10px; padding-top: 10px;">
                <div style="padding-left: 20px; padding-top: 10px; height: 30px" class="simpleTextStyle">
                    <input type="checkbox" id="chCheckReq" checked runat="server" />
                    <label for="chCheckReq">Перевіряти заповнення обов'язкових реквізитів</label>
                </div>            
        <asp:Menu ID="mRecvTabs" 
                OnMenuItemClick="mRecvTabs_MenuItemClick" 
                runat="server" 
                Orientation="Horizontal" 
                StaticEnableDefaultPopOutImage="false"
                StaticDisplayLevels="1"  
                MaximumDynamicDisplayLevels="1">
        <StaticMenuStyle CssClass="web-tab"/>
        <StaticMenuItemStyle CssClass="tabDeactive"/>
        <StaticSelectedStyle CssClass="tabActive"  />  
        <StaticHoverStyle CssClass="hover"/>   
      </asp:Menu>
            

<%--            <asp:Menu CssClass="webTab" ID="mRecvTabs1" runat="server" DynamicEnableDefaultPopOutImage="false" Orientation="Horizontal"
                 OnMenuItemClick="mRecvTabs_MenuItemClick" 
                    >
                <StaticSelectedStyle CssClass="tabActive" BorderStyle="NotSet" BackColor="" VerticalPadding=""
                    BorderColor="" HorizontalPadding="" ForeColor="" BorderWidth="" />
                <StaticMenuItemStyle CssClass="tabDeactive" BorderStyle="NotSet"  BorderColor=""
                    HorizontalPadding="" VerticalPadding="" />
            </asp:Menu>--%>

            <div style="border: 1px solid #c5d0dc;padding: 10px">
                <div  runat="server" id="tabs">
                    
                </div>
                

                <asp:Panel runat="server" ID="pnMain">
                    <bars:BarsSqlDataSourceEx 
                        ID="dsMain" 
                        runat="server" 
                        AllowPaging="False" 
                        FilterStatement=""
                        PageButtonCount="10" 
                        PagerMode="NextPrevious" 
                        PageSize="10" 
                        PreliminaryStatement=""
                        ProviderName="barsroot.core" 
                        SortExpression="" 
                        SystemChangeNumber="" 
                        WhereStatement=""
                        OnSelecting="dsMain_Selecting">
                    </bars:BarsSqlDataSourceEx>
                    <bars:BarsGridViewEx 
                        ID="gvMain" 
                        DataSourceID="dsMain" 
                        runat="server" 
                        AutoGenerateColumns="False"
                        CaptionText="" 
                        CssClass="barsGridView" 
                        DateMask="dd.MM.yyyy" 
                        ExcelImageUrl="/common/images/default/16/export_excel.png"
                        FilterImageUrl="/common/images/default/16/find.png" 
                        MetaFilterImageUrl="/common/images/default/16/filter.png"
                        CaptionType="Cool" 
                        RefreshImageUrl="/common/images/default/16/refresh.png" 
                        ShowPageSizeBox="False"
                        GridLines="Horizontal" 
                        Width="99%" 
                        AllowSorting="true" 
                        OnRowDataBound="gvMain_RowDataBound">
                        <columns>
                        <asp:BoundField DataField="NAME" SortExpression="NAME" HeaderText="Наименование" meta:resourcekey="TemplateFieldResource2">
                            <ItemStyle BorderStyle="Dotted" BorderWidth="1px" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Значение" meta:resourcekey="TemplateFieldResource3">
                            <ItemTemplate>
                                <input type="text" 
                                    runat="server" 
                                    style='<%# "width: 250px;background-color:" + ((Convert.ToString(Eval("OPT"))=="1")?("pink"): ("white")) %>'
                                    tag='<%# Eval("TAG") %>' 
                                    opt='<%# Eval("OPT") %>' 
                                    isp='<%# Eval("ISP") %>' 
                                    tagtype='<%# Eval("TYPE") %>' 
                                    colname='<%# Eval("TABCOLUMN_CHECK") %>' 
                                    tabname='<%# Eval("TABNAME") %>' 
                                    value='<%# Eval("VALUE") %>'
                                    id="edEdVal"
                                    onchange="addToSaveTags(this)" />
                            </ItemTemplate>
                            <ItemStyle Width="250px" HorizontalAlign="Center"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderImageUrl="/Common/Images/default/16/reference.png" >
                            <ItemTemplate>
                                <asp:ImageButton 
                                    runat="server" 
                                    ID="imgEdHelp" 
                                    Width="16px" 
                                    ToolTip="Справочник"
                                    Height="16px" 
                                    Visible='<%# ( Convert.ToString(Eval("TABNAME")) == "" ? false : true ) %>'
                                    ImageUrl="/Common/Images/default/16/reference_open.png" 
                                    OnClientClick=<%# "return ShowHelp(this, '" + Eval("TABNAME") + "')" %>
                                    meta:resourcekey="imgEdHelpResource1"></asp:ImageButton>
                            </ItemTemplate>
                            <ItemStyle Width="25px" HorizontalAlign="Center"></ItemStyle>
                        </asp:TemplateField>
                    </columns>
                    </bars:BarsGridViewEx>
                </asp:Panel>

                <asp:Panel runat="server" ID="pnRisk" Visible="false">
                    <bars:BarsSqlDataSourceEx ID="dsCrisk" runat="server" AllowPaging="False" FilterStatement=""
                        PageButtonCount="10" PagerMode="NextPrevious" PageSize="10" PreliminaryStatement=""
                        ProviderName="barsroot.core" SortExpression="" SystemChangeNumber="" WhereStatement="">
                    </bars:BarsSqlDataSourceEx>
                    <bars:BarsGridViewEx ID="gvCrisk" DataSourceID="dsCrisk" runat="server" AutoGenerateColumns="False"
                        CaptionText="" CssClass="barsGridView" DateMask="dd.MM.yyyy" ExcelImageUrl="/common/images/default/16/export_excel.png"
                        FilterImageUrl="/common/images/default/16/find.png" MetaFilterImageUrl="/common/images/default/16/filter.png"
                        MetaTableName="" DataKeyNames="RISK_ID" RefreshImageUrl="/common/images/default/16/refresh.png"
                        ShowFooter="True" ShowPageSizeBox="False" GridLines="Horizontal" Width="99%">
                        <columns>
                        <asp:BoundField DataField="RISK_ID" HeaderText="Код ризику"></asp:BoundField>
                        <asp:TemplateField HeaderText="Встановити">
                            <ItemTemplate>
                                <input type="checkbox" runat="server" id="cbCheckRisk" onclick="addToSaveRisk(this)"
                                    RiskId='<%# Eval("RISK_ID") %>' checked='<%#( Convert.ToString(Eval("VALUE")) == "1" ? true : false ) %>' />
                            </ItemTemplate>
                            <ItemStyle Width="65px" HorizontalAlign="Center"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Назва ризику">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="Label1" Text='<%# (Convert.ToString(Eval("RISK_NAME")).Length > 130) ? (Convert.ToString(Eval("RISK_NAME")).Substring(0, 130) + " ..."):(Eval("RISK_NAME")) %>'
                                    ToolTip='<%# Eval("RISK_NAME") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </columns>
                    </bars:BarsGridViewEx>
                </asp:Panel>

                <asp:Panel runat="server" ID="pnRept" Visible="false">
                    <bars:BarsSqlDataSourceEx ID="dsRept" runat="server" AllowPaging="False" FilterStatement=""
                        PageButtonCount="10" PagerMode="NextPrevious" PageSize="10" PreliminaryStatement=""
                        ProviderName="barsroot.core" SortExpression="" SystemChangeNumber="" WhereStatement="">
                    </bars:BarsSqlDataSourceEx>
                    <bars:BarsGridViewEx ID="gvCrept" DataSourceID="dsRept" runat="server" AutoGenerateColumns="False"
                        CaptionText="" CssClass="barsGridView" DateMask="dd.MM.yyyy" ExcelImageUrl="/common/images/default/16/export_excel.png"
                        FilterImageUrl="/common/images/default/16/find.png" MetaFilterImageUrl="/common/images/default/16/filter.png"
                        MetaTableName="" DataKeyNames="REPT_ID" RefreshImageUrl="/common/images/default/16/refresh.png"
                        ShowFooter="True" ShowPageSizeBox="False" GridLines="Horizontal" Width="99%">
                        <columns>
                        <asp:BoundField DataField="REPT_ID" HeaderText="Код"></asp:BoundField>
                        <asp:TemplateField HeaderText="Встановити">
                            <ItemTemplate>
                                <input 
                                    type="checkbox" 
                                    runat="server" 
                                    id="cbCheckRept" 
                                    onclick="addToSaveRept(this)"
                                    ReptId='<%# Eval("REPT_ID") %>' 
                                    checked='<%#( Convert.ToString(Eval("VALUE")) == "1" ) %>' />
                            </ItemTemplate>
                            <ItemStyle Width="65px" HorizontalAlign="Center"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Назва">
                            <ItemTemplate>
                                <asp:Label 
                                    runat="server" 
                                    ID="Label2" 
                                    Text='<%# (Convert.ToString(Eval("REPT_NAME")).Length > 130) ? (Convert.ToString(Eval("REPT_NAME")).Substring(0, 130) + " ..."):(Eval("REPT_NAME")) %>'
                                    ToolTip='<%# Eval("REPT_NAME") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </columns>
                    </bars:BarsGridViewEx>
                </asp:Panel>
            </div>
        </div>
        <asp:HiddenField runat="server" ID="hCheckFM" />
    </form>
</body>
</html>
