﻿using System;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public enum ResponseStatus
    {
        OK,
        ERROR,
    }
    [XmlRoot(ElementName = "response")]
    public partial class Response
    {
        private ResponseStatus _status = ResponseStatus.ERROR;
        private const string ErrorTxt = "ERROR";
        private const string OkTxt = "OK";

        public void SetStatus(ResponseStatus newStatus)
        {
            _status = newStatus;
        }
        [XmlElement("status")]
        public string Status
        {
            get
            {
                return _status == ResponseStatus.OK ? OkTxt : ErrorTxt;
            }
            set {
                _status = value.Trim().ToUpper() == OkTxt ? ResponseStatus.OK : ResponseStatus.ERROR;
            }
        }
        [XmlElement("msg")]
        public string Msg { get; set; }
    }
}