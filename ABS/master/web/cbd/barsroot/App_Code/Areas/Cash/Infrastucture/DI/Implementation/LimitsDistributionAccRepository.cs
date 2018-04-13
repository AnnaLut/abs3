using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Areas.Cash.Models;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Cash.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Cash.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using Kendo.Mvc.UI;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Cash.Infrastructure.Repository.DI.Implementation
{
    public class LimitsDistributionAccRepository: ILimitsDistributionAccRepository
    {
        readonly CashEntities _entities;
        private readonly IKendoSqlCounter _sqlCounter;
        private readonly IKendoSqlTransformer _kendoSqlTransformer;
        private string _getAccLimitSql = @"select 
                            t.acc_id as id,
                            t.acc_branch as branch,
                            t.kf as kf,
                            t.acc_ob22 as ob22,
                            t.ru_name as mfoname,
                            t.acc_number as accnumber,
                            t.acc_name as name,
                            t.acc_currency as currency,
                            t.acc_bal / 100 as balance,
                            t.lim_current / 100 as limitcurrent,
                            t.lim_max / 100 as limitmax,
                            t.acc_cashtype as cashtype,
                            t.acc_close_data as closeddate 
                        from
                            table(clim_lim.getacclimit(to_date(:p_date, 'dd/mm/yyyy'))) t
                        order by
                            t.acc_id asc";
        public LimitsDistributionAccRepository(
            ICashModel model,
            IKendoSqlCounter sqlCounter,
            IKendoSqlTransformer sqlTransformer)
        {
		    _entities = model.CashEntities;
            _sqlCounter = sqlCounter;
            _kendoSqlTransformer = sqlTransformer;
        }
        public List<LimitsDistributionAcc> GetAll(string date)
        {
            object[] parameters =        
            { 
                new OracleParameter("p_date",OracleDbType.Varchar2,date,ParameterDirection.Input)
            };

            return _entities.ExecuteStoreQuery<LimitsDistributionAcc>(_getAccLimitSql, parameters).ToList();
        }

        public DataSourceResult GetAllToDataSourceResult(string date, DataSourceRequest request)
        {
            object[] parameters =        
            { 
                new OracleParameter("p_date",OracleDbType.Varchar2,date,ParameterDirection.Input)
            };

            var barsSql = new BarsSql { SqlText = _getAccLimitSql, SqlParams = parameters };
            var adapterSql = _kendoSqlTransformer.TransformSql(barsSql, request);
            var adapterSqlCount = _sqlCounter.TransformSql(barsSql, request);

            var result = new DataSourceResult
            {
                Data = _entities.ExecuteStoreQuery<LimitsDistributionAcc>(adapterSql.SqlText, adapterSql.SqlParams).ToList(),
                Total = (int)_entities.ExecuteStoreQuery<decimal>(adapterSqlCount.SqlText, adapterSqlCount.SqlParams).FirstOrDefault()
            };
            return result;
        }

        public IQueryable<AccLimitPlan> GetPlan(int id)
        {
            return _entities.V_CLIM_ACCLIM_HIST.Where(i => i.ACC_ID == id).Select(i => new AccLimitPlan
            {
                Id = i.ACC_ID,
                LimitCurrent = i.LIM_CURRENT / 100,
                LimitMax = i.LIM_MAX / 100,
                StartDate = i.START_DATE,
                SetDate = i.SET_DATE
            });
        }
        public LimitsDistributionAcc Get(int id,string date)
        {
            return GetAll(date).FirstOrDefault(i => i.Id == id);
        }

        public UpdateDbStatus Add(LimitsDistributionAcc limDist, string date)
        {
            var result = new UpdateDbStatus();
            if (limDist.Id == null)
            {
                throw new Exception("Не переданий ACC рахунку.");
            }
            object[] parameters =        
            { 
                new OracleParameter("p_acc_id",OracleDbType.Decimal,limDist.Id,ParameterDirection.Input),
                new OracleParameter("p_limcur",OracleDbType.Decimal,limDist.LimitCurrent * 100,ParameterDirection.Input),
                new OracleParameter("p_limmax",OracleDbType.Decimal,limDist.LimitMax * 100,ParameterDirection.Input),
                new OracleParameter("p_startdate",OracleDbType.Varchar2,date,ParameterDirection.Input),
                new OracleParameter("p_checkmfolim",OracleDbType.Decimal,1,ParameterDirection.Input),
                new OracleParameter("p_status", OracleDbType.Varchar2,200){Direction = ParameterDirection.ReturnValue},
                new OracleParameter("p_message", OracleDbType.Varchar2,3500){Direction = ParameterDirection.ReturnValue}
            };
            _entities.ExecuteStoreCommand(@"begin 
                                                clim_lim.set_acclim(
                                                    :p_acc_id,
                                                    :p_limcur,
                                                    :p_limmax,
                                                    to_date(:p_startdate, 'dd/mm/yyyy'),
                                                    :p_checkmfolim,
                                                    :p_status,
                                                    :p_message); 
                                                end;", parameters);
            result.Status = ((OracleParameter) parameters[5]).Value.ToString();
            result.Message = ((OracleParameter) parameters[6]).Value.ToString();

            return result;
        }

        public UpdateDbStatus Edit(LimitsDistributionAcc limDist, string date)
        {
            return Add(limDist,date);
        }

        public bool Delete(int id, string date)
        {
            object[] parameters =
                {
                    new OracleParameter("p_acc_id ", OracleDbType.Decimal, id, ParameterDirection.Input),
                    new OracleParameter("p_startdate ", OracleDbType.Varchar2, date, ParameterDirection.Input)
                };
            _entities.ExecuteStoreCommand(@"begin clim_lim.del_acclim(:p_acc_id ,to_date(:p_startdate, 'dd/mm/yyyy'));end;", parameters);

            return true;
        }


        public UpdateDbStatus UploadFile(DateTime date, byte[] file)
        {
            var result = new UpdateDbStatus
            {
                Status = "OK",
                Message = ""
            };
            object[] parameters =
                {
                    new OracleParameter("p_acc_id", OracleDbType.Blob, file, ParameterDirection.Input),
                    new OracleParameter("p_startdate", OracleDbType.Date, date, ParameterDirection.Input),
                    new OracleParameter("p_status", OracleDbType.Varchar2,200){Direction = ParameterDirection.ReturnValue},
                    new OracleParameter("p_message", OracleDbType.Varchar2,3500){Direction = ParameterDirection.ReturnValue},
                    new OracleParameter("p_idsession", OracleDbType.Decimal,100){Direction = ParameterDirection.ReturnValue}
                };
            _entities.ExecuteStoreCommand(@"begin clim_lim.load_accxls(:p_acc_id ,:p_startdate, :p_status,:p_message,:p_idsession);end;", parameters);
            result.Status = ((OracleParameter)parameters[2]).Value.ToString() ;
            result.Message = ((OracleParameter)parameters[3]).Value.ToString();

            var idStr = ((OracleParameter)parameters[4]).Value.ToString();
            if (!string.IsNullOrEmpty(idStr))
            {
                result.SessionId = Convert.ToDecimal(idStr);
            }

            return result;
        }

        public IQueryable<V_CLIM_LOG_LOADXLS_ACCLIM> GetAccProtocolData(decimal sessionId)
        {
            return _entities.V_CLIM_LOG_LOADXLS_ACCLIM.Where(i=>i.ID_SESSION == sessionId);
        }
    }
}
