<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ScanIdDocs.aspx.cs" Inherits="UserControls_dialogs_ScanIdDocs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajx" %>

<%@ Register Src="~/credit/usercontrols/TextBoxScanner.ascx" TagPrefix="bars" TagName="TextBoxScanner" %>
<%@ Register Src="~/credit/usercontrols/ByteImage.ascx" TagPrefix="bars" TagName="ByteImage" %>
<%@ Register Src="~/UserControls/ByteImageCutter.ascx" TagPrefix="bars" TagName="ByteImageCutter" %>
<%@ Register Src="~/UserControls/EADoc.ascx" TagPrefix="bars" TagName="EADoc" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Сканування ідентифікуючих документів</title>
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/BarsGridView.css" type="text/css" rel="stylesheet" />
    <base target="_self" />
    <style type="text/css">
        .header {
            border-bottom: 1px solid #CCD7ED;
            font-size: 12pt;
            color: #1C4B75;
            padding-top: 10px;
            padding-bottom: 2px;
            padding-left: 5px;
        }

        .step {
            width: 100%;
            text-align: center;
            vertical-align: top;
            padding-top: 20px;
            padding-bottom: 20px;
            padding-left: 20px;
        }

        .navigation {
            width: 100%;
            border-top: 1px solid #CCD7ED;
            padding-top: 5px;
            padding-right: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <ajx:ToolkitScriptManager ID="sm" runat="server" />
            <asp:Wizard ID="wzd" runat="server" Width="100%" OnActiveStepChanged="wzd_ActiveStepChanged" OnNextButtonClick="wzd_NextButtonClick" DisplaySideBar="false" OnFinishButtonClick="wzd_FinishButtonClick">
                <HeaderStyle CssClass="header" />
                <StepStyle CssClass="step" />
                <NavigationStyle CssClass="navigation" />
                <WizardSteps>
                    <asp:WizardStep ID="scan_doc" runat="server" Title="Сканування/фотографування документу, що посвідчує особу">
                        <bars:TextBoxScanner runat="server" ID="scDoc" IsRequired="true" />
                    </asp:WizardStep>
                    <asp:WizardStep ID="cut_photo" runat="server" Title="Вирізання фото клієнта з сканкопії/фото документу">
                        <bars:ByteImageCutter runat="server" ID="bicCutPhoto" Width="500" Height="400" OnDocumentSaved="bicCutPhoto_DocumentSaved" />
                    </asp:WizardStep>
                    <asp:WizardStep ID="wc_photo" runat="server" Title="Фото клієнта з веб-камери">
                        <bars:TextBoxScanner runat="server" ID="scWCPhoto" IsRequired="true" />
                    </asp:WizardStep>
                    <asp:WizardStep ID="cut_sign" runat="server" Title="Підпис клієнта">
                        <bars:ByteImageCutter runat="server" ID="bicCutSign" Width="500" Height="400" OnDocumentSaved="bicCutSign_DocumentSaved" />
                    </asp:WizardStep>
                    <asp:WizardStep ID="scan_inn" runat="server" Title="Сканування довідки про присвоєння РНОКПП (або сторінки паспорту з відмовою)">
                        <bars:TextBoxScanner runat="server" ID="scInn" IsRequired="true" />
                    </asp:WizardStep>
                    <asp:WizardStep ID="scan_SpecialDoc" runat="server" Title="Сканування документу що підтверджує особливу відмітку клієнта">
                        <bars:TextBoxScanner runat="server" ID="scSpecialDoc" IsRequired="true" />
                    </asp:WizardStep>
                    <asp:WizardStep ID="print_pagecount" runat="server" Title="Кіл-ть сторінок документів для ксерокопіювання">
                        <table border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lbDocPageCount" runat="server" Text="Кіл-ть сторінок у документі, що посвідчує особу (для ксерокопіювання): "></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlDocPageCount" runat="server">
                                        <asp:ListItem Value="3" Text="3" Selected="True"></asp:ListItem>
                                        <asp:ListItem Value="4" Text="4"></asp:ListItem>
                                        <asp:ListItem Value="5" Text="5"></asp:ListItem>
                                        <asp:ListItem Value="6" Text="6"></asp:ListItem>
                                        <asp:ListItem Value="7" Text="7"></asp:ListItem>
                                        <asp:ListItem Value="8" Text="8"></asp:ListItem>
                                        <asp:ListItem Value="9" Text="9"></asp:ListItem>
                                        <asp:ListItem Value="10" Text="10"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                    </asp:WizardStep>
                    <asp:WizardStep ID="print" runat="server" Title="Друк копій документів">
                        <table border="0">
                            <tr>
                                <td>
                                    <bars:EADoc runat="server" ID="eadDoc" TitleText="Документ, що посвідчує особу: " TemplateID="PRINT_DOC" OnDocSigned="eadDoc_DocSigned" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <bars:EADoc runat="server" ID="eadInn" TitleText="Довідка про присвоєння РНОКПП (або сторінки паспорту з відмовою): " TemplateID="PRINT_INN" OnDocSigned="eadInn_DocSigned" />
                                </td>
                            </tr>
                        </table>
                    </asp:WizardStep>
                    <asp:WizardStep ID="print_SpecialDoc" runat="server" Title="Друк копій документів що підтверджує особливу відмітку клієнта">
                        <table border="0">
                            <tr>
                                <td>
                                    <bars:EADoc runat="server" ID="eadSpecialDoc" TitleText="Документу що підтверджує особливу відмітку клієнта: " TemplateID="PRINT_SPECIALDOC" OnDocSigned="eadSpecialDoc_DocSigned" />
                                </td>
                            </tr>
                        </table>
                    </asp:WizardStep>
                </WizardSteps>
                <StartNavigationTemplate>
                    <asp:Button ID="btnNext" runat="server" CommandName="MoveNext" Text="Далі" CausesValidation="true" />
                </StartNavigationTemplate>
                <StepNavigationTemplate>
                    <asp:Button ID="btnPrevious" runat="server" CausesValidation="False" CommandName="MovePrevious" Text="Назад" />
                    <asp:Button ID="btnNext" runat="server" CausesValidation="true" CommandName="MoveNext" Text="Далі" />
                </StepNavigationTemplate>
                <FinishNavigationTemplate>
                    <asp:Button ID="btnPrevious" runat="server" CausesValidation="False" CommandName="MovePrevious" Text="Назад" />
                    <asp:Button ID="btnNext" runat="server" CausesValidation="true" CommandName="MoveComplete" Text="Завершити" />
                </FinishNavigationTemplate>
            </asp:Wizard>
        </div>
    </form>
</body>
</html>
