using System;
using System.Data;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Net;
using Bars.Application;
using barsroot.core;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace Bars.WebServices
{
    [WebService(Namespace = "http://ws.unity-bars.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class NewNbs : BarsWebService
    {
        [WebMethod(EnableSession = true)]
        public bool UseNewNbs()
        {
            using (OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                using (OracleCommand cmd = connect.CreateCommand())
                {
                    cmd.CommandText = @"select BARS.NEWNBS.GET_STATE() from dual";
                    return Convert.ToInt64(cmd.ExecuteScalar()) == 1;
                }
            }
            // if returned result is "1" then we should use new nbs 
            // else, old
        }
    }
}
