using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Web;
using Bars.Oracle;
using FastReport.Cloud;
using Newtonsoft.Json;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace deposit
{
    /// <summary>
    /// Діалог для пошуку існуючого клієнта
    /// </summary>
    public partial class SearchCustomer : Bars.BarsPage
    {
        /// <summary>
        /// Загрузка страницы
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void Page_Load(object sender, EventArgs e)
        {

            if (HttpContext.Current.Request.HttpMethod == HttpMethod.Post)
            {
                var param = HttpContext.Current.Request.Params;
                var searchParam = new SearchCurstomerParam();
                var result = new Result { Status = "ok" };
                try
                {
                    var fioParam = param.GetValues("fio");
                    if (fioParam != null && !string.IsNullOrWhiteSpace(Convert.ToString(fioParam.GetValue(0))))
                    {
                        searchParam.Fio = fioParam.GetValue(0) + "%";
                    }
                    var edrpoParam = param.GetValues("edrpo");
                    if (edrpoParam != null && !string.IsNullOrWhiteSpace(Convert.ToString(edrpoParam.GetValue(0))))
                    {
                        searchParam.Edrpo = Convert.ToString(edrpoParam.GetValue(0));
                    }
                    var birthDateParam = param.GetValues("birthdate");
                    if (birthDateParam != null && !string.IsNullOrWhiteSpace(Convert.ToString(birthDateParam.GetValue(0))))
                    {
                        var cultute = new CultureInfo("uk-UA")
                        {
                            DateTimeFormat = {ShortDatePattern = "dd/MM/yyyy", DateSeparator = "/"}
                        };
                        searchParam.BirthDate = Convert.ToDateTime(birthDateParam.GetValue(0), cultute);
                    }
                    var documNumber = param.GetValues("documNamber");
                    if (documNumber != null && !string.IsNullOrWhiteSpace(Convert.ToString(documNumber.GetValue(0))))
                    {
                        searchParam.DocumNumber = Convert.ToString(documNumber.GetValue(0));
                    }
                    var documSeries = param.GetValues("documSeries");
                    if (documSeries != null && !string.IsNullOrWhiteSpace(Convert.ToString(documSeries.GetValue(0))))
                    {
                        searchParam.DocumSeries = Convert.ToString(documSeries.GetValue(0));
                    }
                    result.Data = Search(searchParam);
                }
                catch (Exception ex)
                {
                    result.Status = "error";
                    result.Message = ex.InnerException == null ? ex.Message : ex.InnerException.Message;
                }
                Response.ClearContent();
                Response.ClearHeaders();
                Response.ContentType = "text/json";
                Response.Write(JsonConvert.SerializeObject(result));
                Response.Flush();
                Response.End(); 
            }
        }

        public List<Customer> Search(SearchCurstomerParam param)
        {
            var result = new List<Customer>();
            // Создаем соединение
            IOraConnection conn = (IOraConnection)Context.Application["OracleConnectClass"];
            var connect = conn.GetUserConnection();
            try
            {
                // Формируем запрос на поиск
                OracleCommand cmdSearchCustomer = connect.CreateCommand();

                cmdSearchCustomer.CommandText = "dpt_web.p_search_customer";
                cmdSearchCustomer.CommandType = CommandType.StoredProcedure;

                cmdSearchCustomer.Parameters.Add("p_okpo", OracleDbType.Varchar2, param.Edrpo, ParameterDirection.Input);
                cmdSearchCustomer.Parameters.Add("p_nmk", OracleDbType.Varchar2, param.Fio, ParameterDirection.Input);
                cmdSearchCustomer.Parameters.Add("p_bday", OracleDbType.Date, param.BirthDate, ParameterDirection.Input);
                cmdSearchCustomer.Parameters.Add("p_ser", OracleDbType.Varchar2, param.DocumSeries, ParameterDirection.Input);
                cmdSearchCustomer.Parameters.Add("p_numdoc", OracleDbType.Varchar2, param.DocumNumber, ParameterDirection.Input);
                cmdSearchCustomer.Parameters.Add("p_cust", OracleDbType.RefCursor, ParameterDirection.Output);

                cmdSearchCustomer.ExecuteNonQuery();

                DataSet fClients = new DataSet();
                ((System.ComponentModel.ISupportInitialize)(fClients)).BeginInit();
                fClients.DataSetName = "fClients";
                fClients.Locale = new CultureInfo("uk-UA");
                ((System.ComponentModel.ISupportInitialize)(fClients)).EndInit();
                // Беремо з процедури RefCursor, в якому записані дані про всіх знайдених клієнтів
                OracleRefCursor refcur = (OracleRefCursor)cmdSearchCustomer.Parameters["p_cust"].Value;

                OracleDataAdapter da = new OracleDataAdapter("", connect);
                da.Fill(fClients, refcur);

                for (int i = 0; i < fClients.Tables[0].Rows.Count; i++)
                {
                    var item = fClients.Tables[0].Rows[i].ItemArray;
                    result.Add(new Customer
                    {
                        Rnk = Convert.ToDecimal(item[0].ToString()),
                        Fio = item[1].ToString(),
                        Edrpo = item[2].ToString(),
                        Address = item[3].ToString(),
                        DocumType = item[4].ToString(),
                        DocumSeries = item[5].ToString(),
                        DocumNumber = item[6].ToString(),
                        Branch = item[7].ToString()
                    });
                }
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { 
                    connect.Close();
                    connect.Dispose();
                }
            }
            return result;

        }

        public class SearchCurstomerParam
        {
            public string Edrpo { get; set; }
            public string Fio { get; set; }
            public DateTime? BirthDate { get; set; }
            public string DocumSeries { get; set; }
            public string DocumNumber { get; set; }
        }

        public class Customer
        {
            public decimal? Rnk { get; set; }
            public string Edrpo { get; set; }
            public string Fio { get; set; }
            public string DocumType { get; set; }
            public string DocumSeries { get; set; }
            public string DocumNumber { get; set; } 
            public string Address { get; set; } 
            public string Branch { get; set; }         
        }

        public class Result
        {
            public string Status { get; set; }
            public object Data { get; set; }
            public string Message { get; set; }
        }
    }
}
