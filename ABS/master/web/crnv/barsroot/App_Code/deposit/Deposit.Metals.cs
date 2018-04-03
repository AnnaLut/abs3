using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Collections.Generic;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using Bars.Classes;
///
namespace Bars.Metals
{
    /// <summary>
    /// 
    /// </summary>
    public class DepositMetals
    {
        /// <summary>
        /// 
        /// </summary>
        private Int32 _BAR_ID;
        /// <summary>
        /// 
        /// </summary>
        private Int32 _BARS_COUNT;
        /// <summary>
        /// 
        /// </summary>
        private Int32 _BAR_NOMINAL;
        /// <summary>
        /// 
        /// </summary>
        private String _BAR_PROBA;
        /// <summary>
        /// 
        /// </summary>
        private Decimal _INGOT_WEIGHT;

        /// <summary>
        /// 
        /// </summary>
        private List<DepositMetals> Bars
        {
            get
            {
                if (HttpContext.Current.Session["DEPOSITMETALS"] == null)
                    HttpContext.Current.Session["DEPOSITMETALS"] = new List<DepositMetals>();

                return ((List<DepositMetals>)HttpContext.Current.Session["DEPOSITMETALS"]);
            }
            set { HttpContext.Current.Session["DEPOSITMETALS"] = value; }
        }
        /// <summary>
        /// 
        /// </summary>
        public Int32 BAR_ID
        {
            get { return _BAR_ID; }
            set { _BAR_ID = value; }
        }
        /// <summary>
        /// 
        /// </summary>
        public Int32 BARS_COUNT
        {
            get { return _BARS_COUNT; }
            set { _BARS_COUNT = value; }
        }
        /// <summary>
        /// 
        /// </summary>
        public Int32 BAR_NOMINAL
        {
            get { return _BAR_NOMINAL; }
            set { _BAR_NOMINAL = value; }
        }
        /// <summary>
        /// 
        /// </summary>
        public String BAR_PROBA
        {
            get { return _BAR_PROBA; }
            set { _BAR_PROBA = value; }
        }
        /// <summary>
        /// Вага зтитків в унціях
        /// </summary>
        public Decimal INGOT_WEIGHT
        {
            get { return _INGOT_WEIGHT; }
            set { _INGOT_WEIGHT = value; }
        }

        /// <summary>
        /// 
        /// </summary>
        public DepositMetals(){}
        /// <summary>
        /// 
        /// </summary>
        /// <param name="p_bars_count"></param>
        /// <param name="p_bar_nominal"></param>
        /// <param name="p_bar_proba"></param>
        public DepositMetals(Int32 BAR_ID, Int32 BARS_COUNT, Int32 BAR_NOMINAL, String BAR_PROBA)
        {
            this.BAR_ID = BAR_ID;
            this.BARS_COUNT = BARS_COUNT;
            this.BAR_NOMINAL = BAR_NOMINAL;
            this.BAR_PROBA = BAR_PROBA;
            this.INGOT_WEIGHT = GetWeight(BAR_NOMINAL, 959);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public List<DepositMetals> SelectBars()
        {
            return this.Bars;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public DepositMetals SelectBar(Int32 BAR_ID)
        {
            if (BAR_ID >= this.Bars.Count)
                return null;
            else
                return this.Bars[BAR_ID];
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="p_bars_count"></param>
        /// <param name="p_bar_nominal"></param>
        /// <param name="p_bar_proba"></param>
        public void InsertBar(Int32 BARS_COUNT, Int32 BAR_NOMINAL, String BAR_PROBA)
        {
            this.Bars.Add(new DepositMetals(this.Bars.Count, BARS_COUNT, BAR_NOMINAL, BAR_PROBA));
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="p_bar_id"></param>
        /// <param name="p_bars_count"></param>
        /// <param name="p_bar_nominal"></param>
        /// <param name="p_bar_proba"></param>
        public void UpdateBar(Int32 BAR_ID, Int32 BARS_COUNT, Int32 BAR_NOMINAL, String BAR_PROBA)
        {
            this.Bars[BAR_ID].BARS_COUNT = BARS_COUNT;
            this.Bars[BAR_ID].BAR_NOMINAL = BAR_NOMINAL;
            this.Bars[BAR_ID].BAR_PROBA = BAR_PROBA;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="p_bar_id"></param>
        public void DeleteBar(Int32 BAR_ID)
        {
            this.Bars.RemoveAt(BAR_ID);
        }
        /// <summary>
        /// 
        /// </summary>
        public static void ClearData()
        {
            HttpContext.Current.Session["DEPOSITMETALS"] = new List<DepositMetals>();
        }
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public static Decimal Sum()
        {
            Decimal l_sum = 0;

            for (int i = 0; i < ((List<DepositMetals>)HttpContext.Current.Session["DEPOSITMETALS"]).Count; i++)
                l_sum += ((List<DepositMetals>)HttpContext.Current.Session["DEPOSITMETALS"])[i].BARS_COUNT *
                    ((List<DepositMetals>)HttpContext.Current.Session["DEPOSITMETALS"])[i].BAR_NOMINAL;

            return l_sum;
        }

        /// <summary>
        /// Повертає загальну вагу в унціях прийнятих на депозит злитків
        /// </summary>
        /// <returns></returns>
        public static Decimal SumOunce()
        {
            Decimal l_sum = 0;

            for (int i = 0; i < ((List<DepositMetals>)HttpContext.Current.Session["DEPOSITMETALS"]).Count; i++)
            {
                l_sum += Math.Round(((List<DepositMetals>)HttpContext.Current.Session["DEPOSITMETALS"])[i].INGOT_WEIGHT *
                                    ((List<DepositMetals>)HttpContext.Current.Session["DEPOSITMETALS"])[i].BARS_COUNT, 2);
            }
            return l_sum;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public static String TagValue()
        {
            String l_value = String.Empty;

            for (int i = 0; i < ((List<DepositMetals>)HttpContext.Current.Session["DEPOSITMETALS"]).Count; i++)
                l_value += ((List<DepositMetals>)HttpContext.Current.Session["DEPOSITMETALS"])[i].BARS_COUNT.ToString() + ";" +
                    ((List<DepositMetals>)HttpContext.Current.Session["DEPOSITMETALS"])[i].BAR_NOMINAL.ToString() + ";" +
                    ((List<DepositMetals>)HttpContext.Current.Session["DEPOSITMETALS"])[i].BAR_PROBA + "#";

            if (!String.IsNullOrEmpty(l_value))
                l_value = l_value.TrimEnd('#');

            return l_value;
        }

        /// <summary>
        /// ф-я повертає вагу в унціях 
        /// </summary>
        /// <param name="COUNT">к-ть злитків</param>
        /// <param name="NOMINAL">номінал злитка (вага в грамах)</param>
        /// <returns></returns>
        internal Decimal GetWeight(Decimal NOMINAL, Int32 KV)
        {
            Decimal l_weight = 0;

            OracleConnection connect = new OracleConnection();
            try
            {
                IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
                connect = conn.GetUserConnection();

                OracleCommand cmdSQL = connect.CreateCommand();
                cmdSQL.CommandText = @"select max(ves_un) from BANK_METALS 
                                        where type_ = 1 and kv = :kv and ves = :ves"; 
                cmdSQL.Parameters.Add("kv", OracleDbType.Decimal, 959, ParameterDirection.Input);
                cmdSQL.Parameters.Add("ves", OracleDbType.Decimal, NOMINAL, ParameterDirection.Input);
                
                l_weight = Convert.ToDecimal(cmdSQL.ExecuteScalar());

                connect.Close(); 
                connect.Dispose();
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }

            return l_weight;

        }
    }
}