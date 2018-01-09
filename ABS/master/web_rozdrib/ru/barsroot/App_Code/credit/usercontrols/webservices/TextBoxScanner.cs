using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace Bars.UserControls.WebServices
{
    /// <summary>
    /// Веб-сервис для обслуживания запросов компоненты сканирования
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.Web.Script.Services.ScriptService]
    public class TextBoxScanner : System.Web.Services.WebService
    {
        # region Конструктор
        public TextBoxScanner()
        {

            //Uncomment the following line if using designed components 
            //InitializeComponent(); 
        }
        # endregion

        # region Веб-методы
        [WebMethod(EnableSession = true)]
        public void DeleteAllFromMemory(String sid)
        {
            HttpContext.Current.Session.Remove(sid);
        }
        
        [WebMethod(EnableSession = true)]
        public ScannerInitParams GetObjectParams()
        {
            ScannerInitParams res = null;

            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            try
            {
                res = new ScannerInitParams(con);
            }
            finally
            {
                con.Close();
                con.Dispose();
            }

            return res;
        }
        # endregion
    }
}