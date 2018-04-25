using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Net;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Xml;
using Bars.Classes;
using Bars.Configuration;
using BarsWeb.Core.Logger;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.SalaryBagSrv.Models;
using barsroot.core;
using Bars.Application;
using Dapper;
using System.Linq;

namespace Bars.SalaryBagSrv
{
    /// <summary>
    ///     this is salary bag web service :)
    /// </summary>
    [WebService(Namespace = "http://ws.unity-bars-utl.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class ZPServiceMain : ZPSrvBase
    {
        private const string err = "ERROR";

        [WebMethod(EnableSession = true)]
        public Result SendCentralToAll(string mfo, string nls, string central, string sessionId)
        {
            Result res = new Result();

            try
            {
                String UserName = ConfigurationSettings.AppSettings["ZP.ABS_login"];
                LoginUser(UserName, sessionId);

                res = ZPSrvWorker.SendCentrallToAll(mfo, nls, central, sessionId);
            }
            catch (System.Exception ex)
            {
                res.message = ex.Message;
                res.status = err;
            }
            return res;
        }

        [WebMethod(EnableSession = true)]
        public CorpAddIfoResult GetCorp2ClientInfo(string rnk, decimal? sum, string mfo, string sessionId)
        {
            CorpAddIfoResult res = new CorpAddIfoResult();

            try
            {
                String UserName = ConfigurationSettings.AppSettings["ZP.ABS_login"];
                LoginUser(UserName, sessionId);

                res = ZPSrvWorker.GetCorp2ClientInfo(rnk, sum, mfo);
            }
            catch (System.Exception ex)
            {
                res.message = ex.Message;
                res.status = err;
            }

            return res;
        }

        [WebMethod(EnableSession = true)]
        public Result UploadDictToCorp2(string url, string dictContent)
        {
            try
            {
                Corp2Intr.ZPIntrWebService ws = new Corp2Intr.ZPIntrWebService()
                {
                    Url = url,
                    Timeout = 30 * 60 * 1000
                };

                Corp2Intr.SimpleResponse res = ws.UploadCardsDictionary(dictContent);

                return new Result()
                {
                    status = res.Status,
                    message = res.Msg
                };
            }
            catch (System.Exception ex)
            {
                return new Result()
                {
                    message = ex.Message,
                    status = err
                };
            }
        }

        [WebMethod(EnableSession = true)]
        public OpenCardsResult OpenCardsFromCorp2(byte[] inBlob, string mfo, string sessionId)
        {
            OpenCardsResult res = new OpenCardsResult();

            try
            {
                String UserName = ConfigurationSettings.AppSettings["ZP.ABS_login"];
                LoginUser(UserName, sessionId);
                res = ZPSrvWorker.OpenCardsFromCorp2(inBlob, mfo);
            }
            catch (System.Exception ex)
            {
                res.message = ex.Message;
                res.status = err;
            }
            return res;
        }

        #region process payroll
        [WebMethod(EnableSession = true)]
        public Result SendPayrollResultToCorp2(string url, string data)
        {
            Result res = new Result();
            try
            {
                Corp2Intr.ZPIntrWebService ws = new Corp2Intr.ZPIntrWebService()
                {
                    Url = url
                };

                Corp2Intr.SimpleResponse response = ws.SavePayrollInfoFromAbs(data);
                res.message = response.Msg;

                if (response.Status.ToUpper() != "OK")
                    throw new System.Exception(response.Msg);
            }
            catch (System.Exception ex)
            {
                res.status = err;
                res.message = ex.Message;
            }
            return res;
        }

        [WebMethod(EnableSession = true)]
        public Result ProcessPayrollFromCorp2(string data)
        {
            Result res = new Result();
            try
            {
                String UserName = ConfigurationSettings.AppSettings["ZP.ABS_login"];
                LoginUser(UserName, "");
                res = ZPSrvWorker.ProcessPayrollFromCorp2(data);
            }
            catch (System.Exception ex)
            {
                res.status = err;
                res.message = ex.Message;
            }
            return res;
        }
        #endregion
    }
}