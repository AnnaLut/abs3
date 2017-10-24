using System;
using System.Data;
using System.Linq;
using System.Collections.Generic;
using BarsWeb.Areas.AccpReport.Infrastructure;
using BarsWeb.Areas.AccpReport.Infrastructure.DI.Abstract;
using BarsWeb.Areas.AccpReport.Infrastructure.Repository.DI.Abstract;
using Areas.AccpReport.Models;
using System.Globalization;
using Areas.AccpReportDocs.Models;
using Oracle.DataAccess.Client;
using Bars.Classes;
using BarsWeb.Areas.Kernel.Models;

namespace BarsWeb.Areas.AccpReport.Infrastucture.DI.Implementation
{
    public class AccpReportRepository : IAccpReportRepository
    {
        public BarsSql _getAccDocsSql;
        readonly Entities _entities;
        public AccpReportRepository(IAccpReportModel model)
        {
            _entities = model.AccpReportEntities;
        }
        public IQueryable<V_ACCP_ACCOUNTS> GetAccounts()
        {
            return _entities.V_ACCP_ACCOUNTS;
        }

       
        public void SetAccounts(string OKPO, string NLS,   bool Check)
        {

            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();

            try
            {

                if (con.State != ConnectionState.Open)
                    con.Open();

                OracleCommand cmd = con.CreateCommand();
                cmd.CommandType = CommandType.Text;
                cmd.BindByName = true;
                cmd.CommandText = "update accp_accounts set check_on = :p_CHECK" +
                   " where okpo = :p_OKPO and nls = :p_NLS";
                cmd.Parameters.Add(new OracleParameter("p_OKPO", OracleDbType.Varchar2, OKPO, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_NLS", OracleDbType.Varchar2, NLS, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_CHECK", OracleDbType.Decimal, Check? 1 : 0, ParameterDirection.Input));
                cmd.ExecuteNonQuery();

            }
            finally
            {
                con.Close();
            }


        }

        public void CreateReport(string DateFrom, string DateTo, string OKPO)
        {

            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();

            try
            {

                if (con.State != ConnectionState.Open)
                    con.Open();

                OracleCommand cmd = con.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure; 
                cmd.BindByName = true;
                cmd.CommandText = "accp_reports.get_docs";
                cmd.Parameters.Add(new OracleParameter("p_startdate", OracleDbType.Date, DateTime.ParseExact(DateFrom, "dd/MM/yyyy", CultureInfo.InvariantCulture) , ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_enddate", OracleDbType.Date , DateTime.ParseExact(DateTo, "dd/MM/yyyy", CultureInfo.InvariantCulture) , ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_okpo", OracleDbType.Varchar2, OKPO, ParameterDirection.Input));
                cmd.ExecuteNonQuery();



            }
            finally
            {
                con.Close();
            }
        }

        
        private void InitAccDocsSql(String OKPO)
        {
            //OKPO = "2305979";
            _getAccDocsSql = new BarsSql()
            {
                SqlText = string.Format(@"SELECT * FROM TMP_ACCP_DOCS WHERE  okpo_org = :p_OKPO "),
                SqlParams = new object[] { new OracleParameter("p_OKPO", OracleDbType.Varchar2) { Value = OKPO } }
            };
        }


        public IEnumerable<ACCPDOCS> GetAccountsDocs(String OKPO)
        {
            InitAccDocsSql(OKPO);
            var result = _entities.ExecuteStoreQuery<ACCPDOCS>(_getAccDocsSql.SqlText, _getAccDocsSql.SqlParams);
            return result;
        }


        public void CheckAccountsDoc(decimal REF, bool Check)
        {
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();

            try
            {

                if (con.State != ConnectionState.Open)
                    con.Open();

                OracleCommand cmd = con.CreateCommand();
                cmd.CommandType = CommandType.Text;
                cmd.BindByName = true;
                cmd.CommandText = "update tmp_accp_docs set check_on = :p_CHECK" +
                   " where ref = :p_REF";
                cmd.Parameters.Add(new OracleParameter("p_REF", OracleDbType.Decimal, REF, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_CHECK", OracleDbType.Decimal, Check ? 1 : 0, ParameterDirection.Input));
                cmd.ExecuteNonQuery();

            }
            finally
            {
                con.Close();
            }


        }





    }
}