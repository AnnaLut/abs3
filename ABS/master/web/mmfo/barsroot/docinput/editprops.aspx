<%@ Page Language="C#" AutoEventWireup="true" CodeFile="editprops.aspx.cs" Inherits="docinput_editprops" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Редагування додаткових реквізитів</title>
    <link href="../Content/Themes/Kendo/kendo.common.min.css" rel="stylesheet" />
    <link href="../Content/Themes/Kendo/kendo.dataviz.min.css" rel="stylesheet" />
    <link href="../Content/Themes/Kendo/kendo.bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/Themes/Kendo/kendo.dataviz.bootstrap.min.css" rel="stylesheet" />
        <link href="/Common/CSS/BarsGridView.css" rel="Stylesheet" type="text/css" />
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <base target="_self">
    <script type="text/javascript" src="../Scripts/jquery/jquery.js"></script>
    <script language="javascript" type="text/javascript" src="../Scripts/jquery/jquery.bars.ui.js"></script>
    <script language="javascript" type="text/javascript" src="../Scripts/kendo/kendo.all.min.js"></script>
    <script language="javascript" type="text/javascript" src="../Scripts/kendo/kendo.aspnetmvc.min.js"></script>
    <script language="javascript" type="text/javascript" src="../Scripts/kendo/kendo.timezones.min.js"></script>
    <script type="text/javascript" src="../Scripts/Bars/bars.config.js"></script>
    <script language="javascript" type="text/javascript" src="../Scripts/kendo/cultures/kendo.culture.uk.min.js"></script>
    <script language="javascript" type="text/javascript" src="../Scripts/kendo/cultures/kendo.culture.uk-UA.min.js"></script>
    <script language="javascript" type="text/javascript" src="../Scripts/kendo/messages/kendo.messages.uk-UA.min.js"></script>
    <script language="javascript" type="text/javascript" src="/barsroot/Scripts/Bars/bars.ui.js"></script>
    <script type="text/javascript" src="/Common/Script/BarsIe.js"></script>
    <script type="text/javascript">
        function showRelWindow(tag) {
            var boxID = document.getElementById("hEditBoxId").value;
            var box = document.getElementById(boxID);
            var reqname = tag;
            var reqvalue = box;
            var result = window.showModalDialog("dialog.aspx?type=metatab_req&role=wr_doc_input&reqname=" + escape(reqname) + "&reqvalue=" + reqvalue,
            window,
            "dialogWidth:600px;dialogHeight:600px;center:yes;edge:sunken;help:no;status:no;");
            if (result != null)
                box.value = result[0];
        }

        function getGridFilter() {
            bars.ui.getFiltersByMetaTable(function (response) {
                if (response.length > 0) {
                    var sql = response.join(' and ');
                    if (ifParInURl())
                        window.location.href = getNewUrl(true, sql);
                    else
                        window.location.href = document.URL + "&FilterSQL=" + sql;
                }
                else
                {
                    window.location.href = getNewUrl(false, "");
                }
            }, { tableName: "OPER" });
        }

        function getUrlVars(url) {
            var vars = {};
            var parts = url.replace(/[?&]+([^=&]+)=([^&]*)/gi,
            function (m, key, value) {
                vars[key] = value;
            });
            return vars;
        }

        function ifParInURl() {
            var obj = getUrlVars(document.URL);
            for (var prop in obj) {
                if (prop == "FilterSQL")
                    return true;
            }
            return false;
        }

        function getNewUrl(use_filter, filter)
        {
            var new_url = document.URL.split("?")[0] + "?";
            var obj = getUrlVars(document.URL);
            for (var prop in obj) {
                if (prop == "FilterSQL" && !use_filter)
                    continue;
                else if (prop == "FilterSQL" && use_filter)
                {
                    new_url += prop + "=" + filter + "&";
                    continue;
                }
                new_url += prop + "=" + obj[prop] + "&";
            }
            return new_url.substring(0, new_url.length - 1);
        }
    </script>
</head>
<body>
    <form id="formEditprops" runat="server" target="">
        <div class="pageTitle">
            <asp:Label ID="lbTitle" runat="server" Text="Редагування додаткових реквізитів"></asp:Label>
        </div>
        <table style="width: 99%">
            <tr>
                <td colspan="2">
                    <asp:Panel runat="server" ID="pnDocuments" GroupingText="Перегляд документів">
                        <table runat="server" style="margin-left: 10px">
                            <tr>
                                <td id="trDateFilter" runat="server" visible="false">
                                    <asp:Label runat="server" Text="Починаючи з дати"></asp:Label>
                                    <bars:DateEdit runat="server" ID="deStartDate" Width="90px" />
                                </td>
                                <td>
                                    <asp:Label runat="server" Text="Реф. документа"></asp:Label>
                                    <asp:TextBox runat="server" ID="tbRef" />
                                </td>
                                <td>
                                    <asp:Button runat="server" ID="btRefresh" Text="Перечитати" OnClick="OnClick" />
                                </td>
                                <td style="padding-right: 5px; width: 1px">
                                    <bars:imagetextbutton id="bt_Filter" meta:resourcekey="bt_Filter" runat="server"
                                        text="Фильтр" tooltip="Установить фильтр" imageurl="/Common/Images/default/16/filter.png"
                                        onclientclick="getGridFilter();return false;" />
                                </td>
                            </tr>
                        </table>
                        <asp:Panel runat="server" ID="pnEmptyData" Visible="false" Style="margin-left: 10px">
                            <asp:Label runat="server" ForeColor="Red" Font-Bold="True" Text="Документу(ів) не знайдено, або відсутні реквізити по операції!"></asp:Label>
                        </asp:Panel>
                        <bars:BarsSqlDataSourceEx ID="sdsDocs" runat="server" ProviderName="barsroot.core" AllowPaging="True">
                        </bars:BarsSqlDataSourceEx>
                        <bars:BarsGridViewEx runat="server" ID="gvDocs" DataSourceID="sdsDocs" DataKeyNames="REF" CssClass="barsGridView" PageSize="8"
                            AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" OnRowCommand="gvDocs_OnRowCommand" ShowPageSizeBox="True" AutoSelectFirstRow="False" OnPreRender="gvDocs_OnPreRender">
                            <columns>
                <asp:TemplateField HeaderText="Вибрати">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                    <ItemTemplate>
                        <asp:ImageButton runat="server" ID="imgEditReqv" Width="16px" ToolTip="Редагувати реквізит"
                            CommandName="Select" CommandArgument='<%# Eval("REF") %>' ImageUrl="/Common/Images/default/16/open_blue.png">
                        </asp:ImageButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="REF" SortExpression="REF" HeaderText="Референс документу"></asp:BoundField>
                <asp:TemplateField>
                    <ItemTemplate >
                        <img title="Карточка документа" src="/Common/Images/default/16/document.png" style="color:black" onclick='<%# "window.showModalDialog(\"/barsroot/documentview/default.aspx?ref=" + Eval("REF") + "\", \"\", \"dialogWidth:1100px;dialogHeight:550px;center:yes;\" )" %>'></img>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="TT" SortExpression="TT" HeaderText="Код ОП">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="USERID" SortExpression="USERID" HeaderText="Вик."></asp:BoundField>
                <asp:BoundField DataField="NLSA" SortExpression="NLSA" HeaderText="Рахунок А"></asp:BoundField>
                <asp:BoundField DataField="S" SortExpression="S" DataFormatString="{0:N}" HeaderText="Сума"></asp:BoundField>
                <asp:BoundField DataField="LCV_A" SortExpression="LCV_A" HeaderText="Вал юта">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="VDAT" SortExpression="VDAT" HeaderText="Дата валютування"></asp:BoundField>
                <asp:BoundField DataField="S2" SortExpression="S2" DataFormatString="{0:N}" HeaderText="Сума в валюті Б"></asp:BoundField>
                <asp:BoundField DataField="LCV_B" SortExpression="LCV_B" HeaderText="Вал Б">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="MFOB" SortExpression="MFOB" HeaderText="МФО Б"></asp:BoundField>
                <asp:BoundField DataField="NLSB" SortExpression="NLSB" HeaderText="Рахунок Б"></asp:BoundField>
                <asp:BoundField DataField="DK" SortExpression="DK" HeaderText="Д\К"></asp:BoundField>
                <asp:BoundField DataField="SK" SortExpression="SK" HeaderText="СКП"></asp:BoundField>
                <asp:BoundField DataField="DATD" SortExpression="DATD" HeaderText="Дата документа"></asp:BoundField>
            </columns>
                        </bars:BarsGridViewEx>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td style="width: 60%;">
                    <div style="overflow: auto; height: 400px;">
                        <asp:Panel runat="server" ID="pnProps" GroupingText="Реквізити документу">
                            <bars:BarsSqlDataSourceEx ID="sdsProps" runat="server" ProviderName="barsroot.core" OldValuesParameterFormatString="old_{0}">
                                <selectparameters>
     <asp:ControlParameter Name="REF" Type="String" ControlID="gvDocs"
                    PropertyName="SelectedValue" />
</selectparameters>
                            </bars:BarsSqlDataSourceEx>

                            <bars:BarsGridViewEx ID="gvProps" runat="server" DataSourceID="sdsProps" AllowSorting="True"
                                DataKeyNames="REF,TAG" CssClass="barsGridView" AutoGenerateColumns="False" OnRowUpdating="gvProps_RowUpdating"
                                OnRowDataBound="gvProps_RowDataBound">
                                <columns>
                <asp:TemplateField ShowHeader="False">
                    <EditItemTemplate>
                        <asp:ImageButton runat="server" ID="imgUpdate" Width="16px" ToolTip="Зберегти зміни"
                            CommandName="Update" CommandArgument='<%# Eval("TAG") %>' ImageUrl="/Common/Images/default/16/save.png">
                        </asp:ImageButton>
                        <asp:ImageButton runat="server" ID="imgCancel" Width="16px" ToolTip="Відмінити редагування"
                            CommandName="Cancel" CommandArgument='<%# Eval("TAG") %>' ImageUrl="/Common/Images/default/16/cancel.png">
                        </asp:ImageButton>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:ImageButton runat="server" ID="imgEdit" Width="16px" ToolTip="Редагувати реквізит"
                            CommandName="Edit" CommandArgument='<%# Eval("TAG") %>' ImageUrl="/Common/Images/default/16/open_blue.png">
                        </asp:ImageButton>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="50px" />
                </asp:TemplateField>
                <asp:BoundField DataField="NAME" SortExpression="NAME" HeaderText="Реквізит" ReadOnly="true">
                </asp:BoundField>
                <asp:TemplateField SortExpression="VALUE" HeaderText="Значення">
                    <EditItemTemplate>
                        <asp:TextBox runat="server" ID="tbVALUE" Text='<%# Bind("VALUE") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lbVALUE" Text='<%# Eval("VALUE") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <EditItemTemplate>
                        <asp:LinkButton Text="Довідник" runat="server" ID="lbShowRel" OnClientClick='<%# "showRelWindow(\"" + Eval("TAG") + "\");return false;" %>'
                            Visible='<%# Convert.ToBoolean(Eval("REL")) %>'></asp:LinkButton>
                    </EditItemTemplate>
                </asp:TemplateField>
            </columns>
                            </bars:BarsGridViewEx>

                        </asp:Panel>
                    </div>
                </td>
                <td></td>
            </tr>
        </table>
        <asp:HiddenField runat="server" ID="hEditBoxId" />
    </form>
</body>
</html>
