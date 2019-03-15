using BarsWeb.Areas.NbuIntegration;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;

namespace Areas.NbuIntegration
{
    public class SagoConfig
    {
        public SagoConfig(OracleConnection con)
        {
            List<string> notFoundParams = new List<string>();
            using (OracleCommand cmd = con.CreateCommand())
            {
                foreach (SagoParams param in Enum.GetValues(typeof(SagoParams)))
                {
                    cmd.CommandText = "select value from SAGO_PARAMETERS where upper(NAME) = :p_name";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add(new OracleParameter("p_name", OracleDbType.Varchar2, param.ToString().ToUpper(), ParameterDirection.Input));

                    object res = cmd.ExecuteScalar();

                    if (null == res || string.IsNullOrWhiteSpace(res.ToString()))
                        notFoundParams.Add(param.ToString());
                    else
                        _options.Add(param, res.ToString());
                }
            }
            if (notFoundParams.Count > 0)
                throw new Exception(string.Format("У таблиці SAGO_PARAMETERS відсутні або пусті налаштування таких параметрів '{0}'", string.Join(" , ", notFoundParams.ToArray())));
        }

        private Dictionary<SagoParams, string> _options = new Dictionary<SagoParams, string>();

        public string this[SagoParams index]
        {
            get
            {
                return _options[index];
            }
        }

        public string FullUrl
        {
            get
            {
                return CheckUrl(this[SagoParams.URL]) + CheckUrl(this[SagoParams.MethodUrl], true);
            }
        }

        public string ServerUrl
        {
            get
            {
                return CheckUrl(this[SagoParams.URL]);
            }
        }

        /// <summary>
        /// add slash to the end of url and removes it from the start (if bothSides == true)
        /// </summary>
        /// <param name="url"></param>
        /// <param name="bothSides"></param>
        /// <returns></returns>
        private string CheckUrl(string url, bool bothSides = false)
        {
            url += url.Substring(url.Length - 1, 1) == "/" ? "" : "/";
            if (bothSides)
                url = url.Substring(0, 1) == "/" ? url.Substring(1) : url;

            return url;
        }
    }
}