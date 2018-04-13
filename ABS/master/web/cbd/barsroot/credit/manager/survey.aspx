<%@ Page Language="C#" MasterPageFile="~/credit/manager/master.master" AutoEventWireup="true"
    CodeFile="survey.aspx.cs" Inherits="credit_manager_survey" Theme="default" Title="Анкета клиента заявки №"
    MaintainScrollPositionOnPostback="true" Trace="false" meta:resourcekey="PageResource1" %>

<%@ MasterType VirtualPath="~/credit/manager/master.master" %>
<%@ Register Src="../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/RBLFlag.ascx" TagName="RBLFlag" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxFile.ascx" TagName="TextBoxFile" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxRefer.ascx" TagName="TextBoxRefer" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxScanner.ascx" TagName="TextBoxScanner" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/loading.ascx" TagName="loading" TagPrefix="bec" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function DisableControl() {
            if (typeof (ValidatorOnSubmit) == "function" && ValidatorOnSubmit() == false) return false;

            $('#dvDataContainer').append('<div id="dvProgress" class="overlay" style="height: ' + document.documentElement.scrollHeight + 'px; width: ' + document.documentElement.scrollWidth + 'px"></div>');
            return true;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">

    <div id="dvDataContainer" class="dataContainer">
        <asp:Wizard ID="wzd" runat="server" FinishCompleteButtonText="Сохранить" FinishPreviousButtonText="Назад"
            StartNextButtonText="Далее" StepNextButtonText="Далее" StepPreviousButtonText="Назад"
            OnFinishButtonClick="wzd_FinishButtonClick" OnNextButtonClick="wzd_NextButtonClick"
            OnPreviousButtonClick="wzd_PreviousButtonClick" OnActiveStepChanged="wzd_ActiveStepChanged"
            OnSideBarButtonClick="wzd_SideBarButtonClick" meta:resourcekey="wzdResource1">
            <StartNavigationTemplate>
                <table class="dataTable">
                    <tr>
                        <td class="actionButtonsContainer">
                            <asp:Button ID="StartNextButton" runat="server" SkinID="bNext" CommandName="MoveNext"
                                meta:resourcekey="StartNextButtonResource1" />
                        </td>
                    </tr>
                </table>
            </StartNavigationTemplate>
            <StepNavigationTemplate>
                <table class="dataTable">
                    <tr>
                        <td class="actionButtonsContainer">
                            <asp:Button ID="StepPreviousButton" runat="server" SkinID="bPrev" CausesValidation="False"
                                CommandName="MovePrevious" meta:resourcekey="StepPreviousButtonResource1" />
                            <asp:Button ID="StepNextButton" runat="server" SkinID="bNext" CommandName="MoveNext"
                                meta:resourcekey="StepNextButtonResource1" />
                        </td>
                    </tr>
                </table>
            </StepNavigationTemplate>
            <FinishNavigationTemplate>
                <table class="dataTable">
                    <tr>
                        <td class="actionButtonsContainer">
                            <asp:Button ID="FinishPreviousButton" runat="server" SkinID="bPrev" CausesValidation="False"
                                CommandName="MovePrevious" meta:resourcekey="FinishPreviousButtonResource1" />
                            <asp:Button ID="FinishButton" runat="server" SkinID="bNext" CommandName="MoveComplete"
                                meta:resourcekey="FinishButtonResource1" />
                        </td>
                    </tr>
                </table>
            </FinishNavigationTemplate>
            <SideBarStyle CssClass="sideBarStyle" />
            <StepStyle CssClass="stepStyle" />
        </asp:Wizard>
    </div>
</asp:Content>
