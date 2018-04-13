<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BarsReminder.ascx.cs" Inherits="credit_usercontrols_BarsReminder" %>
<%@ Register Src="TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="bars" %>
<script language="javascript" type="text/jscript" src="/Common/jquery/jquery.tabslideout.v1.2.js"></script>
<style>
    .slide-out-div {
        background: #ffffff;
        float: left;
        text-align: left;
        z-index: 99999;
        vertical-align: top;
    }

    .handle {
        width: 35px;
        height: 100%;
        background-color: darkseagreen;
        color: blue;
        border: 2px;
    }

    .box_shadow {
        -moz-box-shadow: 4px 4px 4px #ccc;
        -webkit-box-shadow: 4px 4px 4px #ccc;
        box-shadow: 4px 4px 4px #ccc;
        border: 1px solid #ccc;
    }
</style>
<bars:BarsSqlDataSourceEx ID="sds" runat="server" ProviderName="barsroot.core" CancelSelectOnNullParameter="False">
</bars:BarsSqlDataSourceEx>
<div id="divslide" class="slide-out-div" style="width: 300px;">
    <div class="handle" style="cursor: pointer;" title="Додати нагадування"></div>
    <div class="box_shadow" style="height: auto; width: auto;">
        <table width="100%">
            <thead align="center">
                <tr>
                    <th colspan="2">Нагадування</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td align="right">Дата:</td>
                    <td>
                        <bec:TextBoxDate ID="tbDate" runat="server" Enabled="true" Width="100px" CssClass="cssTextBoxDate"
                             ValidationGroup="Reminder" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <bec:TextBoxString ID="tbMsg" runat="server" Width="250px" Enabled="true" Rows="6" CssClass="cssTextBoxString"
                             ValidationGroup="Reminder" />
                    </td>
                </tr>
            </tbody>
            <tfoot  align="center">
                <tr>
                    <td colspan="2">
                        <asp:ImageButton ID="imgBtn" runat="server" ImageUrl="/Common/Images/default/24/check.png" CssClass="close_slide"
                             OnClick="imgBtn_Click" ValidationGroup="Reminder" />
                    </td>
                </tr>
            </tfoot>
        </table>
        <div id="test">
            
        </div>
    </div>
</div>