﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан программой.
//     Исполняемая версия:2.0.50727.5420
//
//     Изменения в этом файле могут привести к неправильной работе и будут потеряны в случае
//     повторной генерации кода.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.ComponentModel;
using System.Diagnostics;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml.Serialization;

// 
// This source code was auto-generated by wsdl, Version=2.0.50727.3038.
// 


/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.3038")]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
[System.Web.Services.WebServiceBindingAttribute(Name="CigReportsSoap", Namespace="http://ws.creditinfo.com")]
public partial class CigReports : System.Web.Services.Protocols.SoapHttpClientProtocol {
    
    private CigWsHeader cigWsHeaderValueField;
    
    private System.Threading.SendOrPostCallback GetSchemaOperationCompleted;
    
    private System.Threading.SendOrPostCallback GetReportOperationCompleted;
    
    private System.Threading.SendOrPostCallback GetAvailableReportsOperationCompleted;
    
    private System.Threading.SendOrPostCallback GetAvailableReportsForIdOperationCompleted;
    
    private System.Threading.SendOrPostCallback GetCurrencyRateOperationCompleted;
    
    private System.Threading.SendOrPostCallback GetCurrencyRateByIdsOperationCompleted;
    
    private System.Threading.SendOrPostCallback GetCurrencyRateByCodesOperationCompleted;
    
    private System.Threading.SendOrPostCallback GetSubjectPDBValidationOperationCompleted;
    
    /// <remarks/>
    public CigReports() {
    }
    
    public CigWsHeader CigWsHeaderValue {
        get {
            return this.cigWsHeaderValueField;
        }
        set {
            this.cigWsHeaderValueField = value;
        }
    }
    
    /// <remarks/>
    public event GetSchemaCompletedEventHandler GetSchemaCompleted;
    
    /// <remarks/>
    public event GetReportCompletedEventHandler GetReportCompleted;
    
    /// <remarks/>
    public event GetAvailableReportsCompletedEventHandler GetAvailableReportsCompleted;
    
    /// <remarks/>
    public event GetAvailableReportsForIdCompletedEventHandler GetAvailableReportsForIdCompleted;
    
    /// <remarks/>
    public event GetCurrencyRateCompletedEventHandler GetCurrencyRateCompleted;
    
    /// <remarks/>
    public event GetCurrencyRateByIdsCompletedEventHandler GetCurrencyRateByIdsCompleted;
    
    /// <remarks/>
    public event GetCurrencyRateByCodesCompletedEventHandler GetCurrencyRateByCodesCompleted;
    
    /// <remarks/>
    public event GetSubjectPDBValidationCompletedEventHandler GetSubjectPDBValidationCompleted;
    
    /// <remarks/>
    [System.Web.Services.Protocols.SoapHeaderAttribute("CigWsHeaderValue", Direction=System.Web.Services.Protocols.SoapHeaderDirection.InOut)]
    [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://ws.creditinfo.com/GetSchema", RequestNamespace="http://ws.creditinfo.com", ResponseNamespace="http://ws.creditinfo.com", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
    public System.Xml.XmlNode GetSchema(string reportCode) {
        object[] results = this.Invoke("GetSchema", new object[] {
                    reportCode});
        return ((System.Xml.XmlNode)(results[0]));
    }
    
    /// <remarks/>
    public System.IAsyncResult BeginGetSchema(string reportCode, System.AsyncCallback callback, object asyncState) {
        return this.BeginInvoke("GetSchema", new object[] {
                    reportCode}, callback, asyncState);
    }
    
    /// <remarks/>
    public System.Xml.XmlNode EndGetSchema(System.IAsyncResult asyncResult) {
        object[] results = this.EndInvoke(asyncResult);
        return ((System.Xml.XmlNode)(results[0]));
    }
    
    /// <remarks/>
    public void GetSchemaAsync(string reportCode) {
        this.GetSchemaAsync(reportCode, null);
    }
    
    /// <remarks/>
    public void GetSchemaAsync(string reportCode, object userState) {
        if ((this.GetSchemaOperationCompleted == null)) {
            this.GetSchemaOperationCompleted = new System.Threading.SendOrPostCallback(this.OnGetSchemaOperationCompleted);
        }
        this.InvokeAsync("GetSchema", new object[] {
                    reportCode}, this.GetSchemaOperationCompleted, userState);
    }
    
    private void OnGetSchemaOperationCompleted(object arg) {
        if ((this.GetSchemaCompleted != null)) {
            System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
            this.GetSchemaCompleted(this, new GetSchemaCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
        }
    }
    
    /// <remarks/>
    [System.Web.Services.Protocols.SoapHeaderAttribute("CigWsHeaderValue", Direction=System.Web.Services.Protocols.SoapHeaderDirection.InOut)]
    [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://ws.creditinfo.com/GetReport", RequestNamespace="http://ws.creditinfo.com", ResponseNamespace="http://ws.creditinfo.com", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
    public System.Xml.XmlNode GetReport(string subjectIdNumber, string subjectIdNumberType, string reportType) {
        object[] results = this.Invoke("GetReport", new object[] {
                    subjectIdNumber,
                    subjectIdNumberType,
                    reportType});
        return ((System.Xml.XmlNode)(results[0]));
    }
    
    /// <remarks/>
    public System.IAsyncResult BeginGetReport(string subjectIdNumber, string subjectIdNumberType, string reportType, System.AsyncCallback callback, object asyncState) {
        return this.BeginInvoke("GetReport", new object[] {
                    subjectIdNumber,
                    subjectIdNumberType,
                    reportType}, callback, asyncState);
    }
    
    /// <remarks/>
    public System.Xml.XmlNode EndGetReport(System.IAsyncResult asyncResult) {
        object[] results = this.EndInvoke(asyncResult);
        return ((System.Xml.XmlNode)(results[0]));
    }
    
    /// <remarks/>
    public void GetReportAsync(string subjectIdNumber, string subjectIdNumberType, string reportType) {
        this.GetReportAsync(subjectIdNumber, subjectIdNumberType, reportType, null);
    }
    
    /// <remarks/>
    public void GetReportAsync(string subjectIdNumber, string subjectIdNumberType, string reportType, object userState) {
        if ((this.GetReportOperationCompleted == null)) {
            this.GetReportOperationCompleted = new System.Threading.SendOrPostCallback(this.OnGetReportOperationCompleted);
        }
        this.InvokeAsync("GetReport", new object[] {
                    subjectIdNumber,
                    subjectIdNumberType,
                    reportType}, this.GetReportOperationCompleted, userState);
    }
    
    private void OnGetReportOperationCompleted(object arg) {
        if ((this.GetReportCompleted != null)) {
            System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
            this.GetReportCompleted(this, new GetReportCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
        }
    }
    
    /// <remarks/>
    [System.Web.Services.Protocols.SoapHeaderAttribute("CigWsHeaderValue", Direction=System.Web.Services.Protocols.SoapHeaderDirection.InOut)]
    [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://ws.creditinfo.com/GetAvailableReports", RequestNamespace="http://ws.creditinfo.com", ResponseNamespace="http://ws.creditinfo.com", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
    public System.Xml.XmlNode GetAvailableReports() {
        object[] results = this.Invoke("GetAvailableReports", new object[0]);
        return ((System.Xml.XmlNode)(results[0]));
    }
    
    /// <remarks/>
    public System.IAsyncResult BeginGetAvailableReports(System.AsyncCallback callback, object asyncState) {
        return this.BeginInvoke("GetAvailableReports", new object[0], callback, asyncState);
    }
    
    /// <remarks/>
    public System.Xml.XmlNode EndGetAvailableReports(System.IAsyncResult asyncResult) {
        object[] results = this.EndInvoke(asyncResult);
        return ((System.Xml.XmlNode)(results[0]));
    }
    
    /// <remarks/>
    public void GetAvailableReportsAsync() {
        this.GetAvailableReportsAsync(null);
    }
    
    /// <remarks/>
    public void GetAvailableReportsAsync(object userState) {
        if ((this.GetAvailableReportsOperationCompleted == null)) {
            this.GetAvailableReportsOperationCompleted = new System.Threading.SendOrPostCallback(this.OnGetAvailableReportsOperationCompleted);
        }
        this.InvokeAsync("GetAvailableReports", new object[0], this.GetAvailableReportsOperationCompleted, userState);
    }
    
    private void OnGetAvailableReportsOperationCompleted(object arg) {
        if ((this.GetAvailableReportsCompleted != null)) {
            System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
            this.GetAvailableReportsCompleted(this, new GetAvailableReportsCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
        }
    }
    
    /// <remarks/>
    [System.Web.Services.Protocols.SoapHeaderAttribute("CigWsHeaderValue", Direction=System.Web.Services.Protocols.SoapHeaderDirection.InOut)]
    [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://ws.creditinfo.com/GetAvailableReportsForId", RequestNamespace="http://ws.creditinfo.com", ResponseNamespace="http://ws.creditinfo.com", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
    public System.Xml.XmlNode GetAvailableReportsForId(string subjectIdNumber, string subjectIdNumberType) {
        object[] results = this.Invoke("GetAvailableReportsForId", new object[] {
                    subjectIdNumber,
                    subjectIdNumberType});
        return ((System.Xml.XmlNode)(results[0]));
    }
    
    /// <remarks/>
    public System.IAsyncResult BeginGetAvailableReportsForId(string subjectIdNumber, string subjectIdNumberType, System.AsyncCallback callback, object asyncState) {
        return this.BeginInvoke("GetAvailableReportsForId", new object[] {
                    subjectIdNumber,
                    subjectIdNumberType}, callback, asyncState);
    }
    
    /// <remarks/>
    public System.Xml.XmlNode EndGetAvailableReportsForId(System.IAsyncResult asyncResult) {
        object[] results = this.EndInvoke(asyncResult);
        return ((System.Xml.XmlNode)(results[0]));
    }
    
    /// <remarks/>
    public void GetAvailableReportsForIdAsync(string subjectIdNumber, string subjectIdNumberType) {
        this.GetAvailableReportsForIdAsync(subjectIdNumber, subjectIdNumberType, null);
    }
    
    /// <remarks/>
    public void GetAvailableReportsForIdAsync(string subjectIdNumber, string subjectIdNumberType, object userState) {
        if ((this.GetAvailableReportsForIdOperationCompleted == null)) {
            this.GetAvailableReportsForIdOperationCompleted = new System.Threading.SendOrPostCallback(this.OnGetAvailableReportsForIdOperationCompleted);
        }
        this.InvokeAsync("GetAvailableReportsForId", new object[] {
                    subjectIdNumber,
                    subjectIdNumberType}, this.GetAvailableReportsForIdOperationCompleted, userState);
    }
    
    private void OnGetAvailableReportsForIdOperationCompleted(object arg) {
        if ((this.GetAvailableReportsForIdCompleted != null)) {
            System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
            this.GetAvailableReportsForIdCompleted(this, new GetAvailableReportsForIdCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
        }
    }
    
    /// <remarks/>
    [System.Web.Services.Protocols.SoapHeaderAttribute("CigWsHeaderValue", Direction=System.Web.Services.Protocols.SoapHeaderDirection.InOut)]
    [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://ws.creditinfo.com/GetCurrencyRate", RequestNamespace="http://ws.creditinfo.com", ResponseNamespace="http://ws.creditinfo.com", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
    public System.Xml.XmlNode GetCurrencyRate(int typeId, System.DateTime date) {
        object[] results = this.Invoke("GetCurrencyRate", new object[] {
                    typeId,
                    date});
        return ((System.Xml.XmlNode)(results[0]));
    }
    
    /// <remarks/>
    public System.IAsyncResult BeginGetCurrencyRate(int typeId, System.DateTime date, System.AsyncCallback callback, object asyncState) {
        return this.BeginInvoke("GetCurrencyRate", new object[] {
                    typeId,
                    date}, callback, asyncState);
    }
    
    /// <remarks/>
    public System.Xml.XmlNode EndGetCurrencyRate(System.IAsyncResult asyncResult) {
        object[] results = this.EndInvoke(asyncResult);
        return ((System.Xml.XmlNode)(results[0]));
    }
    
    /// <remarks/>
    public void GetCurrencyRateAsync(int typeId, System.DateTime date) {
        this.GetCurrencyRateAsync(typeId, date, null);
    }
    
    /// <remarks/>
    public void GetCurrencyRateAsync(int typeId, System.DateTime date, object userState) {
        if ((this.GetCurrencyRateOperationCompleted == null)) {
            this.GetCurrencyRateOperationCompleted = new System.Threading.SendOrPostCallback(this.OnGetCurrencyRateOperationCompleted);
        }
        this.InvokeAsync("GetCurrencyRate", new object[] {
                    typeId,
                    date}, this.GetCurrencyRateOperationCompleted, userState);
    }
    
    private void OnGetCurrencyRateOperationCompleted(object arg) {
        if ((this.GetCurrencyRateCompleted != null)) {
            System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
            this.GetCurrencyRateCompleted(this, new GetCurrencyRateCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
        }
    }
    
    /// <remarks/>
    [System.Web.Services.Protocols.SoapHeaderAttribute("CigWsHeaderValue", Direction=System.Web.Services.Protocols.SoapHeaderDirection.InOut)]
    [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://ws.creditinfo.com/GetCurrencyRateByIds", RequestNamespace="http://ws.creditinfo.com", ResponseNamespace="http://ws.creditinfo.com", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
    public System.Xml.XmlNode GetCurrencyRateByIds(int[] typeIds, System.DateTime date) {
        object[] results = this.Invoke("GetCurrencyRateByIds", new object[] {
                    typeIds,
                    date});
        return ((System.Xml.XmlNode)(results[0]));
    }
    
    /// <remarks/>
    public System.IAsyncResult BeginGetCurrencyRateByIds(int[] typeIds, System.DateTime date, System.AsyncCallback callback, object asyncState) {
        return this.BeginInvoke("GetCurrencyRateByIds", new object[] {
                    typeIds,
                    date}, callback, asyncState);
    }
    
    /// <remarks/>
    public System.Xml.XmlNode EndGetCurrencyRateByIds(System.IAsyncResult asyncResult) {
        object[] results = this.EndInvoke(asyncResult);
        return ((System.Xml.XmlNode)(results[0]));
    }
    
    /// <remarks/>
    public void GetCurrencyRateByIdsAsync(int[] typeIds, System.DateTime date) {
        this.GetCurrencyRateByIdsAsync(typeIds, date, null);
    }
    
    /// <remarks/>
    public void GetCurrencyRateByIdsAsync(int[] typeIds, System.DateTime date, object userState) {
        if ((this.GetCurrencyRateByIdsOperationCompleted == null)) {
            this.GetCurrencyRateByIdsOperationCompleted = new System.Threading.SendOrPostCallback(this.OnGetCurrencyRateByIdsOperationCompleted);
        }
        this.InvokeAsync("GetCurrencyRateByIds", new object[] {
                    typeIds,
                    date}, this.GetCurrencyRateByIdsOperationCompleted, userState);
    }
    
    private void OnGetCurrencyRateByIdsOperationCompleted(object arg) {
        if ((this.GetCurrencyRateByIdsCompleted != null)) {
            System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
            this.GetCurrencyRateByIdsCompleted(this, new GetCurrencyRateByIdsCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
        }
    }
    
    /// <remarks/>
    [System.Web.Services.Protocols.SoapHeaderAttribute("CigWsHeaderValue", Direction=System.Web.Services.Protocols.SoapHeaderDirection.InOut)]
    [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://ws.creditinfo.com/GetCurrencyRateByCodes", RequestNamespace="http://ws.creditinfo.com", ResponseNamespace="http://ws.creditinfo.com", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
    public System.Xml.XmlNode GetCurrencyRateByCodes(string[] currencyCodes, System.DateTime date) {
        object[] results = this.Invoke("GetCurrencyRateByCodes", new object[] {
                    currencyCodes,
                    date});
        return ((System.Xml.XmlNode)(results[0]));
    }
    
    /// <remarks/>
    public System.IAsyncResult BeginGetCurrencyRateByCodes(string[] currencyCodes, System.DateTime date, System.AsyncCallback callback, object asyncState) {
        return this.BeginInvoke("GetCurrencyRateByCodes", new object[] {
                    currencyCodes,
                    date}, callback, asyncState);
    }
    
    /// <remarks/>
    public System.Xml.XmlNode EndGetCurrencyRateByCodes(System.IAsyncResult asyncResult) {
        object[] results = this.EndInvoke(asyncResult);
        return ((System.Xml.XmlNode)(results[0]));
    }
    
    /// <remarks/>
    public void GetCurrencyRateByCodesAsync(string[] currencyCodes, System.DateTime date) {
        this.GetCurrencyRateByCodesAsync(currencyCodes, date, null);
    }
    
    /// <remarks/>
    public void GetCurrencyRateByCodesAsync(string[] currencyCodes, System.DateTime date, object userState) {
        if ((this.GetCurrencyRateByCodesOperationCompleted == null)) {
            this.GetCurrencyRateByCodesOperationCompleted = new System.Threading.SendOrPostCallback(this.OnGetCurrencyRateByCodesOperationCompleted);
        }
        this.InvokeAsync("GetCurrencyRateByCodes", new object[] {
                    currencyCodes,
                    date}, this.GetCurrencyRateByCodesOperationCompleted, userState);
    }
    
    private void OnGetCurrencyRateByCodesOperationCompleted(object arg) {
        if ((this.GetCurrencyRateByCodesCompleted != null)) {
            System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
            this.GetCurrencyRateByCodesCompleted(this, new GetCurrencyRateByCodesCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
        }
    }
    
    /// <remarks/>
    [System.Web.Services.Protocols.SoapHeaderAttribute("CigWsHeaderValue", Direction=System.Web.Services.Protocols.SoapHeaderDirection.InOut)]
    [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://ws.creditinfo.com/GetSubjectPDBValidation", RequestNamespace="http://ws.creditinfo.com", ResponseNamespace="http://ws.creditinfo.com", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
    public string GetSubjectPDBValidation(System.Xml.XmlNode document) {
        object[] results = this.Invoke("GetSubjectPDBValidation", new object[] {
                    document});
        return ((string)(results[0]));
    }
    
    /// <remarks/>
    public System.IAsyncResult BeginGetSubjectPDBValidation(System.Xml.XmlNode document, System.AsyncCallback callback, object asyncState) {
        return this.BeginInvoke("GetSubjectPDBValidation", new object[] {
                    document}, callback, asyncState);
    }
    
    /// <remarks/>
    public string EndGetSubjectPDBValidation(System.IAsyncResult asyncResult) {
        object[] results = this.EndInvoke(asyncResult);
        return ((string)(results[0]));
    }
    
    /// <remarks/>
    public void GetSubjectPDBValidationAsync(System.Xml.XmlNode document) {
        this.GetSubjectPDBValidationAsync(document, null);
    }
    
    /// <remarks/>
    public void GetSubjectPDBValidationAsync(System.Xml.XmlNode document, object userState) {
        if ((this.GetSubjectPDBValidationOperationCompleted == null)) {
            this.GetSubjectPDBValidationOperationCompleted = new System.Threading.SendOrPostCallback(this.OnGetSubjectPDBValidationOperationCompleted);
        }
        this.InvokeAsync("GetSubjectPDBValidation", new object[] {
                    document}, this.GetSubjectPDBValidationOperationCompleted, userState);
    }
    
    private void OnGetSubjectPDBValidationOperationCompleted(object arg) {
        if ((this.GetSubjectPDBValidationCompleted != null)) {
            System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
            this.GetSubjectPDBValidationCompleted(this, new GetSubjectPDBValidationCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
        }
    }
    
    /// <remarks/>
    public new void CancelAsync(object userState) {
        base.CancelAsync(userState);
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.3038")]
[System.SerializableAttribute()]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
[System.Xml.Serialization.XmlTypeAttribute(Namespace="http://ws.creditinfo.com")]
[System.Xml.Serialization.XmlRootAttribute(Namespace="http://ws.creditinfo.com", IsNullable=false)]
public partial class CigWsHeader : System.Web.Services.Protocols.SoapHeader {
    
    private string userNameField;
    
    private string passwordField;
    
    private string versionField;
    
    private string cultureField;
    
    private string securityTokenField;
    
    private int userIdField;
    
    private System.Xml.XmlAttribute[] anyAttrField;
    
    /// <remarks/>
    public string UserName {
        get {
            return this.userNameField;
        }
        set {
            this.userNameField = value;
        }
    }
    
    /// <remarks/>
    public string Password {
        get {
            return this.passwordField;
        }
        set {
            this.passwordField = value;
        }
    }
    
    /// <remarks/>
    public string Version {
        get {
            return this.versionField;
        }
        set {
            this.versionField = value;
        }
    }
    
    /// <remarks/>
    public string Culture {
        get {
            return this.cultureField;
        }
        set {
            this.cultureField = value;
        }
    }
    
    /// <remarks/>
    public string SecurityToken {
        get {
            return this.securityTokenField;
        }
        set {
            this.securityTokenField = value;
        }
    }
    
    /// <remarks/>
    public int UserId {
        get {
            return this.userIdField;
        }
        set {
            this.userIdField = value;
        }
    }
    
    /// <remarks/>
    [System.Xml.Serialization.XmlAnyAttributeAttribute()]
    public System.Xml.XmlAttribute[] AnyAttr {
        get {
            return this.anyAttrField;
        }
        set {
            this.anyAttrField = value;
        }
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.3038")]
public delegate void GetSchemaCompletedEventHandler(object sender, GetSchemaCompletedEventArgs e);

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.3038")]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
public partial class GetSchemaCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
    
    private object[] results;
    
    internal GetSchemaCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
            base(exception, cancelled, userState) {
        this.results = results;
    }
    
    /// <remarks/>
    public System.Xml.XmlNode Result {
        get {
            this.RaiseExceptionIfNecessary();
            return ((System.Xml.XmlNode)(this.results[0]));
        }
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.3038")]
public delegate void GetReportCompletedEventHandler(object sender, GetReportCompletedEventArgs e);

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.3038")]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
public partial class GetReportCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
    
    private object[] results;
    
    internal GetReportCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
            base(exception, cancelled, userState) {
        this.results = results;
    }
    
    /// <remarks/>
    public System.Xml.XmlNode Result {
        get {
            this.RaiseExceptionIfNecessary();
            return ((System.Xml.XmlNode)(this.results[0]));
        }
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.3038")]
public delegate void GetAvailableReportsCompletedEventHandler(object sender, GetAvailableReportsCompletedEventArgs e);

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.3038")]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
public partial class GetAvailableReportsCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
    
    private object[] results;
    
    internal GetAvailableReportsCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
            base(exception, cancelled, userState) {
        this.results = results;
    }
    
    /// <remarks/>
    public System.Xml.XmlNode Result {
        get {
            this.RaiseExceptionIfNecessary();
            return ((System.Xml.XmlNode)(this.results[0]));
        }
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.3038")]
public delegate void GetAvailableReportsForIdCompletedEventHandler(object sender, GetAvailableReportsForIdCompletedEventArgs e);

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.3038")]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
public partial class GetAvailableReportsForIdCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
    
    private object[] results;
    
    internal GetAvailableReportsForIdCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
            base(exception, cancelled, userState) {
        this.results = results;
    }
    
    /// <remarks/>
    public System.Xml.XmlNode Result {
        get {
            this.RaiseExceptionIfNecessary();
            return ((System.Xml.XmlNode)(this.results[0]));
        }
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.3038")]
public delegate void GetCurrencyRateCompletedEventHandler(object sender, GetCurrencyRateCompletedEventArgs e);

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.3038")]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
public partial class GetCurrencyRateCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
    
    private object[] results;
    
    internal GetCurrencyRateCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
            base(exception, cancelled, userState) {
        this.results = results;
    }
    
    /// <remarks/>
    public System.Xml.XmlNode Result {
        get {
            this.RaiseExceptionIfNecessary();
            return ((System.Xml.XmlNode)(this.results[0]));
        }
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.3038")]
public delegate void GetCurrencyRateByIdsCompletedEventHandler(object sender, GetCurrencyRateByIdsCompletedEventArgs e);

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.3038")]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
public partial class GetCurrencyRateByIdsCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
    
    private object[] results;
    
    internal GetCurrencyRateByIdsCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
            base(exception, cancelled, userState) {
        this.results = results;
    }
    
    /// <remarks/>
    public System.Xml.XmlNode Result {
        get {
            this.RaiseExceptionIfNecessary();
            return ((System.Xml.XmlNode)(this.results[0]));
        }
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.3038")]
public delegate void GetCurrencyRateByCodesCompletedEventHandler(object sender, GetCurrencyRateByCodesCompletedEventArgs e);

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.3038")]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
public partial class GetCurrencyRateByCodesCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
    
    private object[] results;
    
    internal GetCurrencyRateByCodesCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
            base(exception, cancelled, userState) {
        this.results = results;
    }
    
    /// <remarks/>
    public System.Xml.XmlNode Result {
        get {
            this.RaiseExceptionIfNecessary();
            return ((System.Xml.XmlNode)(this.results[0]));
        }
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.3038")]
public delegate void GetSubjectPDBValidationCompletedEventHandler(object sender, GetSubjectPDBValidationCompletedEventArgs e);

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.3038")]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
public partial class GetSubjectPDBValidationCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
    
    private object[] results;
    
    internal GetSubjectPDBValidationCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
            base(exception, cancelled, userState) {
        this.results = results;
    }
    
    /// <remarks/>
    public string Result {
        get {
            this.RaiseExceptionIfNecessary();
            return ((string)(this.results[0]));
        }
    }
}