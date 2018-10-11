using System;
using Oracle.DataAccess.Client;
using Bars.WebServices.XRM.Models;
using System.Collections.Generic;

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

        protected Resp ExecuteMethod<Resp, Req>(Req Request, Func<OracleConnection, Req, Resp> method, bool checkTransaction = true)
            where Resp : IResponse, new()
            where Req : IRequest
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
                        int transactionCheckResp = ProcessTransactions(con, Request.TransactionId, Request.UserLogin, Request.OperationType, out transResp, moduleName);

                        if (new List<int> { -1, -2 }.Contains(transactionCheckResp))
                        {
                            Resp r = -1 == transactionCheckResp ? ToResponse<Resp>(transResp) : new Resp();
                            r.ResultCode = -1 == transactionCheckResp ? 0 : 1;
                            r.ResultMessage = -1 == transactionCheckResp ?
                                  string.Format("Транзакція номер {0} вже була проведена \r{1}", Request.TransactionId, r.ResultMessage)
                                : string.Format("Транзакція номер {0} вже була проведена, але обробка ще не завершилась", Request.TransactionId);
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
