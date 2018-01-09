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
    /// Результат проверки клиента
    /// </summary>
    public class ResultCheckClient
    {
        public String MFO { get; set; }
        public Int64 RNK { get; set; }
        public String FIO { get; set; }

        public Int32 ErrorCode { get; set; }
        public String ErrorText { get; set; }

        public ResultCheckClient()
        {
            this.ErrorCode = 0;
            this.ErrorText = String.Empty;
        }
    }

    /// <summary>
    /// Веб-сервис для обслуживания запросов компоненты идентификации по карте
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.Web.Script.Services.ScriptService]
    public class BPKIdentification : System.Web.Services.WebService
    {
        public BPKIdentification()
        {
        }

        /// <summary>
        /// Проверка клиента по полученому коду РУ и РНК
        /// </summary>
        [WebMethod(true)]
        public ResultCheckClient CheckClient(String CodeRu, Int64 RNK)
        {
			ResultCheckClient res = new ResultCheckClient();    
            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            try
            {
                OracleCommand cmdMfo = con.CreateCommand();
                cmdMfo.CommandText = "select f_ourmfo as mfo, min(p.val) as code_ru from ow_params p where p.par = 'W4_BRANCH'";
                using (OracleDataReader rdr = cmdMfo.ExecuteReader())
                {
                    if (rdr.Read() && Convert.ToString(rdr["code_ru"]) == CodeRu)
                    {
                        res.MFO = Convert.ToString(rdr["mfo"]);
                    }
                    else
                    {
                        res.ErrorCode = 1;
                        res.ErrorText = "Клієнт зареєстрований у іншому МФО";
                    }
                    rdr.Close();
                }

                // если нет ошибки
                if (res.ErrorCode == 0)
                {
                    OracleCommand cmdCl = con.CreateCommand();
                    cmdCl.CommandText = "select c.rnk, c.nmk from customer c where c.rnk = :p_rnk and c.date_off is null";
                    cmdCl.Parameters.Add("p_rnk", OracleDbType.Int64, RNK, System.Data.ParameterDirection.Input);

                    using (OracleDataReader rdr = cmdCl.ExecuteReader())
                    {
                        if (rdr.Read())
                        {
                            res.RNK = Convert.ToInt64(rdr["rnk"]);
                            res.FIO = Convert.ToString(rdr["nmk"]);
                        }
                        else
                        {
                            res.ErrorCode = 2;
                            res.ErrorText = String.Format("Клієнта РНК={0} не знайдено, або його картку закрито", RNK);
                        }
                        rdr.Close();
                    }
                }
            }
            finally
            {
                con.Close();
                con.Dispose();
            }

            return res;
        }
    }
}
