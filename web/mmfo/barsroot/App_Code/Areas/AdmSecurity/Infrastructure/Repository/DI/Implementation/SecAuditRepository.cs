using System;
using System.Data;
using System.Globalization;
using Areas.AdmSecurity.Models;
using Bars.Classes;
using BarsWeb.Areas.AdmSecurity.Infrastructure.Repository.DI.Abstract;
using Oracle.DataAccess.Client;
using System.Linq;
using BarsWeb.Areas.AdmSecurity.Models;

namespace BarsWeb.Areas.AdmSecurity.Infrastructure.Repository.DI.Implementation
{
    public class SecAuditRepository : ISecAuditRepository
    {
        Entities _entities;
        public SecAuditRepository(ISecurityModel model)
        {
            _entities = model.Entities;
        }

        public bool SeedSecAuditTable(string start, string end)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                CultureInfo cultureInfo = new CultureInfo("uk-UA");
                DateTime datestart = DateTime.Parse(start, cultureInfo);
                DateTime dateend = DateTime.Parse(end, cultureInfo);

                OracleCommand command = new OracleCommand("bars.secaudit_utl.view_arc_data", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("p_start_date", OracleDbType.Date, datestart, ParameterDirection.Input);
                command.Parameters.Add("p_end_date", OracleDbType.Date, dateend, ParameterDirection.Input);
                command.ExecuteNonQuery();
                return true;
            }
            finally
            {
                connection.Close();
            }
        }

        public IQueryable<SecAuditArchModel> GetGridData()
        {
            const string queryStr = @"select * from sec_audit_arch";
            return _entities.ExecuteStoreQuery<SecAuditArchModel>(queryStr).AsQueryable();
        }
    }
}