﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

// 
// This source code was auto-generated by wsdl, Version=4.6.1055.0.
// 
namespace Corp2Intr {
    using System;
    using System.Web.Services;
    using System.Diagnostics;
    using System.Web.Services.Protocols;
    using System.Xml.Serialization;
    using System.ComponentModel;
    
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "4.6.1055.0")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Web.Services.WebServiceBindingAttribute(Name="ZPIntrWebServiceSoap", Namespace="http://unity-bars.com.ua/ws")]
    public partial class ZPIntrWebService : System.Web.Services.Protocols.SoapHttpClientProtocol {
        
        private System.Threading.SendOrPostCallback UploadCardsDictionaryOperationCompleted;
        
        private System.Threading.SendOrPostCallback SendOpenCardsToAbsOperationCompleted;
        
        private System.Threading.SendOrPostCallback SendPayrollToAbsOperationCompleted;
        
        private System.Threading.SendOrPostCallback SavePayrollInfoFromAbsOperationCompleted;
        
        /// <remarks/>
        public ZPIntrWebService() {
            this.Url = "http://10.10.10.44:18777/ibank/webservices/ZPIntrWebService.asmx";
        }
        
        /// <remarks/>
        public event UploadCardsDictionaryCompletedEventHandler UploadCardsDictionaryCompleted;
        
        /// <remarks/>
        public event SendOpenCardsToAbsCompletedEventHandler SendOpenCardsToAbsCompleted;
        
        /// <remarks/>
        public event SendPayrollToAbsCompletedEventHandler SendPayrollToAbsCompleted;
        
        /// <remarks/>
        public event SavePayrollInfoFromAbsCompletedEventHandler SavePayrollInfoFromAbsCompleted;
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://unity-bars.com.ua/ws/UploadCardsDictionary", RequestNamespace="http://unity-bars.com.ua/ws", ResponseNamespace="http://unity-bars.com.ua/ws", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public SimpleResponse UploadCardsDictionary(string dictXml) {
            object[] results = this.Invoke("UploadCardsDictionary", new object[] {
                        dictXml});
            return ((SimpleResponse)(results[0]));
        }
        
        /// <remarks/>
        public System.IAsyncResult BeginUploadCardsDictionary(string dictXml, System.AsyncCallback callback, object asyncState) {
            return this.BeginInvoke("UploadCardsDictionary", new object[] {
                        dictXml}, callback, asyncState);
        }
        
        /// <remarks/>
        public SimpleResponse EndUploadCardsDictionary(System.IAsyncResult asyncResult) {
            object[] results = this.EndInvoke(asyncResult);
            return ((SimpleResponse)(results[0]));
        }
        
        /// <remarks/>
        public void UploadCardsDictionaryAsync(string dictXml) {
            this.UploadCardsDictionaryAsync(dictXml, null);
        }
        
        /// <remarks/>
        public void UploadCardsDictionaryAsync(string dictXml, object userState) {
            if ((this.UploadCardsDictionaryOperationCompleted == null)) {
                this.UploadCardsDictionaryOperationCompleted = new System.Threading.SendOrPostCallback(this.OnUploadCardsDictionaryOperationCompleted);
            }
            this.InvokeAsync("UploadCardsDictionary", new object[] {
                        dictXml}, this.UploadCardsDictionaryOperationCompleted, userState);
        }
        
        private void OnUploadCardsDictionaryOperationCompleted(object arg) {
            if ((this.UploadCardsDictionaryCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.UploadCardsDictionaryCompleted(this, new UploadCardsDictionaryCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://unity-bars.com.ua/ws/SendOpenCardsToAbs", RequestNamespace="http://unity-bars.com.ua/ws", ResponseNamespace="http://unity-bars.com.ua/ws", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public void SendOpenCardsToAbs() {
            this.Invoke("SendOpenCardsToAbs", new object[0]);
        }
        
        /// <remarks/>
        public System.IAsyncResult BeginSendOpenCardsToAbs(System.AsyncCallback callback, object asyncState) {
            return this.BeginInvoke("SendOpenCardsToAbs", new object[0], callback, asyncState);
        }
        
        /// <remarks/>
        public void EndSendOpenCardsToAbs(System.IAsyncResult asyncResult) {
            this.EndInvoke(asyncResult);
        }
        
        /// <remarks/>
        public void SendOpenCardsToAbsAsync() {
            this.SendOpenCardsToAbsAsync(null);
        }
        
        /// <remarks/>
        public void SendOpenCardsToAbsAsync(object userState) {
            if ((this.SendOpenCardsToAbsOperationCompleted == null)) {
                this.SendOpenCardsToAbsOperationCompleted = new System.Threading.SendOrPostCallback(this.OnSendOpenCardsToAbsOperationCompleted);
            }
            this.InvokeAsync("SendOpenCardsToAbs", new object[0], this.SendOpenCardsToAbsOperationCompleted, userState);
        }
        
        private void OnSendOpenCardsToAbsOperationCompleted(object arg) {
            if ((this.SendOpenCardsToAbsCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.SendOpenCardsToAbsCompleted(this, new System.ComponentModel.AsyncCompletedEventArgs(invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://unity-bars.com.ua/ws/SendPayrollToAbs", RequestNamespace="http://unity-bars.com.ua/ws", ResponseNamespace="http://unity-bars.com.ua/ws", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public SimpleResponse SendPayrollToAbs(string mfo, string data) {
            object[] results = this.Invoke("SendPayrollToAbs", new object[] {
                        mfo,
                        data});
            return ((SimpleResponse)(results[0]));
        }
        
        /// <remarks/>
        public System.IAsyncResult BeginSendPayrollToAbs(string mfo, string data, System.AsyncCallback callback, object asyncState) {
            return this.BeginInvoke("SendPayrollToAbs", new object[] {
                        mfo,
                        data}, callback, asyncState);
        }
        
        /// <remarks/>
        public SimpleResponse EndSendPayrollToAbs(System.IAsyncResult asyncResult) {
            object[] results = this.EndInvoke(asyncResult);
            return ((SimpleResponse)(results[0]));
        }
        
        /// <remarks/>
        public void SendPayrollToAbsAsync(string mfo, string data) {
            this.SendPayrollToAbsAsync(mfo, data, null);
        }
        
        /// <remarks/>
        public void SendPayrollToAbsAsync(string mfo, string data, object userState) {
            if ((this.SendPayrollToAbsOperationCompleted == null)) {
                this.SendPayrollToAbsOperationCompleted = new System.Threading.SendOrPostCallback(this.OnSendPayrollToAbsOperationCompleted);
            }
            this.InvokeAsync("SendPayrollToAbs", new object[] {
                        mfo,
                        data}, this.SendPayrollToAbsOperationCompleted, userState);
        }
        
        private void OnSendPayrollToAbsOperationCompleted(object arg) {
            if ((this.SendPayrollToAbsCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.SendPayrollToAbsCompleted(this, new SendPayrollToAbsCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://unity-bars.com.ua/ws/SavePayrollInfoFromAbs", RequestNamespace="http://unity-bars.com.ua/ws", ResponseNamespace="http://unity-bars.com.ua/ws", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public SimpleResponse SavePayrollInfoFromAbs(string data) {
            object[] results = this.Invoke("SavePayrollInfoFromAbs", new object[] {
                        data});
            return ((SimpleResponse)(results[0]));
        }
        
        /// <remarks/>
        public System.IAsyncResult BeginSavePayrollInfoFromAbs(string data, System.AsyncCallback callback, object asyncState) {
            return this.BeginInvoke("SavePayrollInfoFromAbs", new object[] {
                        data}, callback, asyncState);
        }
        
        /// <remarks/>
        public SimpleResponse EndSavePayrollInfoFromAbs(System.IAsyncResult asyncResult) {
            object[] results = this.EndInvoke(asyncResult);
            return ((SimpleResponse)(results[0]));
        }
        
        /// <remarks/>
        public void SavePayrollInfoFromAbsAsync(string data) {
            this.SavePayrollInfoFromAbsAsync(data, null);
        }
        
        /// <remarks/>
        public void SavePayrollInfoFromAbsAsync(string data, object userState) {
            if ((this.SavePayrollInfoFromAbsOperationCompleted == null)) {
                this.SavePayrollInfoFromAbsOperationCompleted = new System.Threading.SendOrPostCallback(this.OnSavePayrollInfoFromAbsOperationCompleted);
            }
            this.InvokeAsync("SavePayrollInfoFromAbs", new object[] {
                        data}, this.SavePayrollInfoFromAbsOperationCompleted, userState);
        }
        
        private void OnSavePayrollInfoFromAbsOperationCompleted(object arg) {
            if ((this.SavePayrollInfoFromAbsCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.SavePayrollInfoFromAbsCompleted(this, new SavePayrollInfoFromAbsCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        public new void CancelAsync(object userState) {
            base.CancelAsync(userState);
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "4.6.1055.0")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(Namespace="http://unity-bars.com.ua/ws")]
    public partial class SimpleResponse {
        
        private string statusField;
        
        private string msgField;
        
        /// <remarks/>
        public string Status {
            get {
                return this.statusField;
            }
            set {
                this.statusField = value;
            }
        }
        
        /// <remarks/>
        public string Msg {
            get {
                return this.msgField;
            }
            set {
                this.msgField = value;
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "4.6.1055.0")]
    public delegate void UploadCardsDictionaryCompletedEventHandler(object sender, UploadCardsDictionaryCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "4.6.1055.0")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class UploadCardsDictionaryCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal UploadCardsDictionaryCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public SimpleResponse Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((SimpleResponse)(this.results[0]));
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "4.6.1055.0")]
    public delegate void SendOpenCardsToAbsCompletedEventHandler(object sender, System.ComponentModel.AsyncCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "4.6.1055.0")]
    public delegate void SendPayrollToAbsCompletedEventHandler(object sender, SendPayrollToAbsCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "4.6.1055.0")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class SendPayrollToAbsCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal SendPayrollToAbsCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public SimpleResponse Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((SimpleResponse)(this.results[0]));
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "4.6.1055.0")]
    public delegate void SavePayrollInfoFromAbsCompletedEventHandler(object sender, SavePayrollInfoFromAbsCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "4.6.1055.0")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class SavePayrollInfoFromAbsCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal SavePayrollInfoFromAbsCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public SimpleResponse Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((SimpleResponse)(this.results[0]));
            }
        }
    }
}
