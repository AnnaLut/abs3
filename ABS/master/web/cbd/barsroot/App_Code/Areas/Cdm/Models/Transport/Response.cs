using System;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public enum ResponseStatus
    {
        OK,
        ERROR,
    }
    public partial class Response
    {
        private ResponseStatus _status = ResponseStatus.ERROR;
        private const string ErrorTxt = "ERROR";
        private const string OkTxt = "OK";

        public void SetStatus(ResponseStatus newStatus)
        {
            _status = newStatus;
        }
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
        public string Msg { get; set; }
    }
}