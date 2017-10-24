﻿<%@ Page Language="C#" MasterPageFile="~/credit/manager/master.master" AutoEventWireup="true"
    CodeFile="auth.aspx.cs" Inherits="credit_manager_auth" Title="Данные авторизации заявки №{0}"
    Theme="default" Trace="false" meta:resourcekey="PageResource1" %>

<%@ MasterType VirtualPath="~/credit/manager/master.master" %>
<%@ Register Src="../usercontrols/ByteImage.ascx" TagName="ByteImage" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/RBLFlag.ascx" TagName="RBLFlag" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxFile.ascx" TagName="TextBoxFile" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxRefer.ascx" TagName="TextBoxRefer" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxScanner.ascx" TagName="TextBoxScanner" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <table class="dataTable">
            <tr>
                <td style="padding-right: 30px">
                    <bec:ByteImage ID="imgSc" runat="server" Width="450px" Height="500px" ToolTip="Связная сканкопия" 
                        ImageUrl="/Common/Images/empty_image.png" ShowView="true" ShowLabel="true" ShowPager="true" />
                </td>
                <td id="tdContainer" runat="server">
                </td>
            </tr>
            <tr>
                <td class="nextButtonContainer" colspan="2">
                    <asp:Button ID="bNext" SkinID="bNext" runat="server" OnClick="bNext_Click" meta:resourcekey="bNextResource1" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
