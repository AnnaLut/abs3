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
using Oracle.DataAccess.Client;
using Bars.Classes;
using Bars.Logger;
using Bars.Oracle;
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
        /// Кількість злитків
        /// </summary>
        private Int32 _BARS_COUNT;
        
        /// <summary>
        /// Номінал (вага в грамах)
        /// </summary>
        private Decimal _BAR_NOMINAL;
        
        /// <summary>
        /// Проба злитку
        /// </summary>
        private Decimal _BAR_PROBA;
        
        /// <summary>
        /// Вага злитків в унціях
        /// </summary>
        private Decimal _INGOT_WEIGHT;
        
        /// <summary>
        /// Код валюти металу
        /// </summary>
        private Int32 _CURRENCY;

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
        /// Кількість злитків
        /// </summary>
        public Int32 BARS_COUNT
        {
            get { return _BARS_COUNT; }
            set { _BARS_COUNT = value; }
        }
        
        /// <summary>
        /// Номінал (вага в грамах)
        /// </summary>
        public Decimal BAR_NOMINAL
        {
            get { return _BAR_NOMINAL; }
            set { _BAR_NOMINAL = value; }
        }

        /// <summary>
        /// Проба злитку
        /// </summary>
        public Decimal BAR_PROBA
        {
            get { return _BAR_PROBA; }
            set { _BAR_PROBA = value; }
        }

        /// <summary>
        /// Вага злитків в унціях
        /// </summary>
        public Decimal INGOT_WEIGHT
        {
            get { return _INGOT_WEIGHT; }
            set { _INGOT_WEIGHT = value; }
        }

        ///// <summary>
        ///// Валюта металу (ЧИСЛОВИЙ КОД)
        ///// </summary>
        //public Int32 CURRENCY
        //{
        //    get { return _CURRENCY; }
        //    set { _CURRENCY = value; }
        //}

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
        public DepositMetals(Int32 BAR_ID, Int32 BARS_COUNT, Decimal BAR_NOMINAL, Decimal BAR_PROBA, Int32 CURRENCY)
        {
            this.BAR_ID = BAR_ID;
            this.BARS_COUNT = BARS_COUNT;
            this.BAR_NOMINAL = BAR_NOMINAL;
            this.BAR_PROBA = BAR_PROBA;
            this.INGOT_WEIGHT = GetWeight(BAR_NOMINAL, CURRENCY);
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
            if (this.Bars.Count > 0)
            {
                return this.Bars[GetIndex(BAR_ID)];
            }
            else
            {
                return null;
            }
        }
        /// <summary>
        /// Insert new record with ingot description
        /// </summary>
        /// <param name="p_bars_count"></param>
        /// <param name="p_bar_nominal"></param>
        /// <param name="p_bar_proba"></param>
        public void InsertBar(Int32 BARS_COUNT, Decimal BAR_NOMINAL, Decimal BAR_PROBA, Int32 CURRENCY)
        {
            Int32 ID = this.Bars.Count;

            if (ID > 0)
            {                
                ID = (this.Bars[ID-1].BAR_ID + 1);
            }

            this.Bars.Add(new DepositMetals(ID, BARS_COUNT, BAR_NOMINAL, BAR_PROBA, CURRENCY));
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="p_bar_id"></param>
        /// <param name="p_bars_count"></param>
        /// <param name="p_bar_nominal"></param>
        /// <param name="p_bar_proba"></param>
        public void UpdateBar(Int32 BAR_ID, Int32 BARS_COUNT, Decimal BAR_NOMINAL, Decimal BAR_PROBA)
        {
            Int32 Index = GetIndex(BAR_ID);

            this.Bars[Index].BARS_COUNT = BARS_COUNT;
            this.Bars[Index].BAR_NOMINAL = BAR_NOMINAL;
            this.Bars[Index].BAR_PROBA = BAR_PROBA;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="p_bar_id"></param>
        public void DeleteBar(Int32 BAR_ID)
        {
            this.Bars.RemoveAt(GetIndex(BAR_ID));
        }
        /// <summary>
        /// 
        /// </summary>
        public static void ClearData()
        {
            HttpContext.Current.Session["DEPOSITMETALS"] = new List<DepositMetals>();
        }

        /// <summary>
        /// /// Return Index in List with specified BAR_ID
        /// </summary>
        /// <param name="ID">BAR_ID</param>
        /// <returns></returns>
        private Int32 GetIndex(Int32 ID)
        {
            return this.Bars.FindIndex(delegate(DepositMetals m) { return m.BAR_ID == ID; });           
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

            // УПБ використовує три знаки після розділювача
            // * (перевести на вибірку к-ті знаків з TABVAL) *
            int l_dig = ((BankType.GetDptBankType() == BANKTYPE.UPB) ? 3 : 2);

            for (int i = 0; i < ((List<DepositMetals>)HttpContext.Current.Session["DEPOSITMETALS"]).Count; i++)
            {
                l_sum += Math.Round(((List<DepositMetals>)HttpContext.Current.Session["DEPOSITMETALS"])[i].INGOT_WEIGHT *
                                    ((List<DepositMetals>)HttpContext.Current.Session["DEPOSITMETALS"])[i].BARS_COUNT, l_dig);
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


        public static String TagValueMETAL()
        {
            String l_value = String.Empty;

            for (int i = 0; i < ((List<DepositMetals>)HttpContext.Current.Session["DEPOSITMETALS"]).Count; i++)
                l_value +=
                    ((List<DepositMetals>)HttpContext.Current.Session["DEPOSITMETALS"])[i].BAR_PROBA + ";" +
                    ((List<DepositMetals>)HttpContext.Current.Session["DEPOSITMETALS"])[i].BAR_NOMINAL.ToString() + ";" +
                    ((List<DepositMetals>)HttpContext.Current.Session["DEPOSITMETALS"])[i].BARS_COUNT.ToString();
                    
            if (!String.IsNullOrEmpty(l_value))
                l_value = l_value.TrimEnd('#');
            l_value = l_value.Replace(";", "/");
            return l_value;
        }

        /// <summary>
        /// ф-я повертає вагу в унціях злитку вказаного номіналу
        /// </summary>
        /// <param name="COUNT">к-ть злитків</param>
        /// <param name="NOMINAL">номінал злитка (вага в грамах)</param>
        /// <returns></returns>
        internal Decimal GetWeight(Decimal NOMINAL, Int32 KV)
        {
            Decimal l_weight = 0;

            OracleConnection connect = OraConnector.Handler.IOraConnection.GetUserConnection();

            try
            {
                OracleCommand cmdSQL = connect.CreateCommand();

                cmdSQL.CommandText = @"select VES_UN from BANK_METALS 
                                        where TYPE_ = 1 and KV = :kv and VES = :ves and VES_UN is Not Null";
                cmdSQL.Parameters.Add("kv", OracleDbType.Decimal, KV, ParameterDirection.Input);
                cmdSQL.Parameters.Add("ves", OracleDbType.Decimal, NOMINAL, ParameterDirection.Input);

                OracleDataReader rdr = cmdSQL.ExecuteReader();

                if (rdr.Read())
                {
                    if (!rdr.IsDBNull(0))
                        l_weight = rdr.GetOracleDecimal(0).Value;
                    //else
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", String.Format("alert('{0}'); ", "Сформовано документи згідно списку"), true);
                }

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