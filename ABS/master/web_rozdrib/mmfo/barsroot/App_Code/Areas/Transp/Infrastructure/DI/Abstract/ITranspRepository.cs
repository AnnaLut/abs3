using BarsWeb.Areas.Transp.Models.ApiModels;
using System.Collections.Generic;

namespace BarsWeb.Areas.Transp.Infrastructure.DI.Abstract
{
    /// <summary>
    /// Summary description for ITranspRepository
    /// </summary>
    public interface ITranspRepository
    {

        InputTypes GetReqType(string TypeName);

        string InsertReq(string ReqType, string HttpType, string ActionType, string UserName, string GetParams);

        string InsertReq(string ReqType, string HttpType, string ActionType, string UserName, string GetParams, string ReqBody);

        void InsertReqParams(string ReqId, string ParamType, string ReqParams);

        void ProcessRequest(string ReqId);

        string GetRespData(string ReqId, string UserName);

        List<KeyValuePair<string, string>> GetRespParams(string ReqId);

        string GetReqStatus(string ReqId, string UserName);

        void InputLoger(string ReqId, string Act, string State, string Message);

        void InputLoger(string ReqId, string Act, string State, string Message, string LargeMessage);

    }
}