<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BPKIdentification.ascx.cs"
    Inherits="Bars.UserControls.UserControls_BPKIdentification" %>
<asp:Button ID="btn" runat="server" Text="Ідент. за БПК" />
<asp:HiddenField ID="hResult" runat="server" />
<div id="dialogSelectDevice" title="Вибір типу POS-терміналу та порту">
    <div>
        <table>
            <tr>
                <td>
                    <select id="deviceTypes" size="3" style="width: 300px">
                        <option value="INPAS" selected="selected">InPas (VeriFone Vx510)</option>
                        <option value="SSI">SSI (VeriFone OptimumT 4220)</option>
                        <option value="INGENICO">Ingenico (iCT250)</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    <select id="COMPort" style="width: 300px">
                        <option value="1" selected="selected">COM 1</option>
                        <option value="2">COM 2</option>
                        <option value="3">COM 3</option>
                    </select>
                </td>
            </tr>
        </table>
    </div>
</div>
<div id="dialogMessages" title="Ідентифікація клієнта за БПК">
    <table border="0">
        <tr>
            <td style="width: 60px">
                <input type="image" id="imgMessage" />
            </td>
            <td>
                <p id="lbMessages">
                </p>
            </td>
        </tr>
        <tr id="trButtons">
            <td style="text-align: right" colspan="2">
                <asp:Button ID="btnOk" runat="server" Text="Ok" OnClick="btnOk_Click" CausesValidation="true"
                    ValidationGroup="BPKIdentification" />
                <asp:Button ID="btnCancel" runat="server" Text="Відміна" OnClientClick="HideMessages(); return false;"
                    CausesValidation="false" />
            </td>
        </tr>
    </table>
</div>
