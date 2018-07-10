using System;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public enum ResponseStatus
    {
        OK,
        ERROR,
        EBK001,
        EBK002,
        EBK003,
        EBK004,
        EBK005,
        EBK006,
        EBK007,
        EBK100
    }

    [XmlRoot(ElementName = "response")]
    public class BaseResponse
    {
        private ResponseStatus _status = ResponseStatus.ERROR;
        private const string ErrorTxt = "ERROR";
        private const string OkTxt = "OK";

        public void SetStatus(ResponseStatus newStatus)
        {
            _status = newStatus;
        }
        [XmlElement(ElementName = "status")]
        public string Status
        {
            get
            {
                var status = _status.ToString("G").StartsWith("EBK")
                    ? _status.ToString("G").Insert(3, "-")
                    : _status.ToString("G");
                return status;
            }
            set
            {
                _status = (ResponseStatus) Enum.Parse(typeof(ResponseStatus),
                    value.Contains("-")
                        ? value.Replace("-", "")
                        : value);
            }
        }
    }
}