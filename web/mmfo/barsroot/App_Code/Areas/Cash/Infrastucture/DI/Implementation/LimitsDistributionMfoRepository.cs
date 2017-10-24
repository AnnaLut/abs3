using System;
using System.Data;
using Areas.Cash.Models;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Cash.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Cash.Models;
using Oracle.DataAccess.Client;
using System.Collections.Generic;
using Dapper;
using Bars.Classes;
using System.Linq;

namespace BarsWeb.Areas.Cash.Infrastructure.Repository.DI.Implementation
{
    public class LimitsDistributionMfoRepository : ILimitsDistributionMfoRepository
    {
        readonly CashEntities _entities;


        public LimitsDistributionMfoRepository(ICashModel model)
        {
		    _entities = model.CashEntities;
        }
        

        public UpdateDbStatus UploadFile(DateTime date, byte[] file)
        {
            var result = new UpdateDbStatus
            {
                Status = "OK",
                Message = "",
                SessionId = null
            };
            object[] parameters =
                {
                    new OracleParameter("p_acc_id", OracleDbType.Blob, file, ParameterDirection.Input),
                    new OracleParameter("p_startdate", OracleDbType.Date, date, ParameterDirection.Input),
                    new OracleParameter("p_status", OracleDbType.Varchar2,200){Direction = ParameterDirection.ReturnValue},
                    new OracleParameter("p_message", OracleDbType.Varchar2,3500){Direction = ParameterDirection.ReturnValue},
                    new OracleParameter("p_idsession", OracleDbType.Decimal){Direction = ParameterDirection.ReturnValue}
                };
            _entities.ExecuteStoreCommand(@"begin clim_lim.load_mfoxls(:p_acc_id ,:p_startdate, :p_status,:p_message, :p_idsession);end;", parameters);
            result.Status = ((OracleParameter)parameters[2]).Value.ToString();
            result.Message = ((OracleParameter)parameters[3]).Value.ToString();
            var idStr = ((OracleParameter)parameters[4]).Value.ToString();
            if (!string.IsNullOrEmpty(idStr))
            {
                result.SessionId = Convert.ToDecimal(idStr);
            }
            return result;
        }

        public List<MfoProtocolModel> GetMfoProtocolData(decimal sessionId)
        {
            var sql = @"select KF, NAME_KF, KV, LIM_CURRENT, LIM_MAX, STATUS, TEXT as ERROR
                                from V_CLIM_LOG_LOADXLS_MFOLIM 
                                where ID_SESSION = :p_idsession";
            var p = new DynamicParameters();
            p.Add("p_idsession", dbType: DbType.Decimal, value: sessionId, direction: ParameterDirection.Input);
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<MfoProtocolModel>(sql, p).ToList();
            }
        }

    }
}
