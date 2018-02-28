using System;
using System.Data;
using System.Web;
using System.Web.Services;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using barsroot.core;
using BarsWeb.Core.Logger;
using System.Collections.Generic;
using System.Globalization;
using System.Web.Services.Protocols;
using Bars.WebServices.XRM.Models;
using System.IO;
using System.Text;
using Ionic.Zlib;
using Bars.Oracle;

namespace Bars.WebServices.XRM.Services
{
    /// <summary>
    /// Базовий класс для веб-сервісів XRM
    /// </summary>
    public class XrmBaseWebService : BarsWebService
    {
        public XrmBaseWebService() { }

        #region Exception processing
        protected T ProcessException<T>(System.Exception ex) where T : IResponse, new()
        {
            return new T()
            {
                ResultCode = -1,
                ResultMessage = ex.Message
            };
        }
        #endregion

        protected Resp ExecuteMethod<Resp, Req>(Req Request, Func<OracleConnection, Req, Resp> method, bool checkTransaction = true) where Resp : IResponse, new() where Req : IRequest
        {
            Resp response = new Resp();
            using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                try
                {
                    byte[] transResp = null;
                    LoginADUserIntSingleCon(con, Request.UserLogin);

                    if (checkTransaction)
                    {
                        ProcessTransactions(con, Request.TransactionId, Request.UserLogin, Request.OperationType, out transResp, moduleName);

                        if (null != transResp)
                        {
                            Resp r = ToResponse<Resp>(transResp);
                            r.ResultMessage = string.Format("Транзакція номер {0} вже була проведена \r{1}", Request.TransactionId, r.ResultMessage);

                            return r;
                        }
                    }
                    response = method(con, Request);
                }
                catch (System.Exception ex)
                {
                    response = ProcessException<Resp>(ex);
                }

                if (checkTransaction)
                    WriteRequestResponseToLog(con, Request.TransactionId, Request, response);
            }

            return response;
        }
    }
}
