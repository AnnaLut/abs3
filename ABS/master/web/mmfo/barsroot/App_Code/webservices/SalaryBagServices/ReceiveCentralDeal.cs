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
using Bars.Application;
using barsroot.core;

namespace Bars.SalaryBagSrv
{
    /// <summary>
    ///     
    /// </summary>
    [WebService(Namespace = "http://ws.unity-bars-utl.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class ReceiveCentralDeal : ZPSrvBase
    {
        [WebMethod(EnableSession = true)]
        public Result SetCentral(string mfo, string nls, string central, string session)
        {
            try
            {
                String UserName = ConfigurationSettings.AppSettings["ZP.ABS_login"];
                LoginUser(UserName, session);

                using (OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection())
                {
                    using (OracleCommand cmd = con.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "zp.set_central";

                        cmd.Parameters.Add("p_mfo", OracleDbType.Varchar2, mfo, ParameterDirection.Input);
                        cmd.Parameters.Add("p_nls", OracleDbType.Varchar2, nls, ParameterDirection.Input);
                        cmd.Parameters.Add("p_central", OracleDbType.Decimal, Convert.ToInt32(central), ParameterDirection.Input);

                        cmd.ExecuteNonQuery();
                    }
                }

                return new Result();
            }
            catch (System.Exception ex)
            {
                return new Result() { status = "ERROR", message = ex.Message };
            }
        }
    }
}