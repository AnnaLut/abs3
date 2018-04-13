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
    public class LimitsDistributionAtmRepository : ILimitsDistributionAtmRepository
    {
        readonly CashEntities _entities;
        private readonly IKendoSqlCounter _sqlCounter;
        private readonly IKendoSqlTransformer _kendoSqlTransformer;
        private string _getAtmLimitSql = @"select 
                            t.acc_id as id,
                            t.acc_branch as branch,
                            t.kf as kf,
                            t.ru_name as mfoname,
                            t.acc_number as accnumber,
                            t.acc_name as name,
                            t.acc_currency as currency,
                            t.acc_bal / 100 as balance,
                            t.lim_maxload / 100 as limitmaxload,
                            t.acc_cashtype as cashtype,
                            t.acc_close_data as closeddate ,
                            t.cod_atm as atmcode
                        from
                            table(clim_lim.getatmlimit(to_date(:p_date, 'dd/mm/yyyy'))) t";

        public LimitsDistributionAtmRepository(
            ICashModel model,
            IKendoSqlCounter sqlCounter,
            IKendoSqlTransformer sqlTransformer)
        {
		    _entities = model.CashEntities;
            _sqlCounter = sqlCounter;
            _kendoSqlTransformer = sqlTransformer;
        }

        public List<LimitsDistributionAtm> GetAll(string date)
        {
            object[] parameters =        
            { 
                new OracleParameter("p_date",OracleDbType.Varchar2,date,ParameterDirection.Input)
            };

            return _entities.ExecuteStoreQuery<LimitsDistributionAtm>(_getAtmLimitSql, parameters).ToList();
        }

        public DataSourceResult GetAllToDataSourceResult(string date, DataSourceRequest request)
        {
            object[] parameters =        
            { 
                new OracleParameter("p_date",OracleDbType.Varchar2,date,ParameterDirection.Input)
            };

            var barsSql = new BarsSql { SqlText = _getAtmLimitSql, SqlParams = parameters };
            var adapterSql = _kendoSqlTransformer.TransformSql(barsSql, request);
            var adapterSqlCount = _sqlCounter.TransformSql(barsSql, request);

            var result = new DataSourceResult
            {
                Data = _entities.ExecuteStoreQuery<LimitsDistributionAtm>(adapterSql.SqlText, adapterSql.SqlParams).ToList(),
                Total = (int)_entities.ExecuteStoreQuery<decimal>(adapterSqlCount.SqlText, adapterSqlCount.SqlParams).FirstOrDefault()
            };
            return result;
        }
        public int GetAllCount(string date, DataSourceRequest request)
        {
            object[] parameters =        
            { 
                new OracleParameter("p_date",OracleDbType.Varchar2,date,ParameterDirection.Input)
            };

            var barsSql = new BarsSql { SqlText = _getAtmLimitSql, SqlParams = parameters };
            var adapterSql = _sqlCounter.TransformSql(barsSql, request);
            return (int)_entities.ExecuteStoreQuery<decimal>(adapterSql.SqlText, adapterSql.SqlParams).FirstOrDefault();
        }
        public IQueryable<AtmLimitPlan> GetPlan(int id)
        {
            return _entities.V_CLIM_ATMLIM_HIST.Where(i => i.ACC_ID == id).Select(i => new AtmLimitPlan
            {
                Id = i.ACC_ID,
                LimitMaxLoad = i.LIM_MAXLOAD / 100,
                StartDate = i.START_DATE,
                SetDate = i.SET_DATE
            });
        }
        public LimitsDistributionAtm Get(int id,string date)
        {
            return GetAll(date).FirstOrDefault(i => i.Id == id);
        }

        public LimitsDistributionAtm Add(LimitsDistributionAtm limDist, string date)
        {
            if (limDist.Id == null)
            {
                throw new Exception("Не переданий ACC рахунку.");
            }
            object[] parameters =        
            { 
                new OracleParameter("p_acc_id",OracleDbType.Decimal,limDist.Id,ParameterDirection.Input),
                new OracleParameter("p_limmax",OracleDbType.Decimal,limDist.LimitMaxLoad * 100,ParameterDirection.Input),
                new OracleParameter("p_startdate",OracleDbType.Varchar2,date,ParameterDirection.Input)
            };
            _entities.ExecuteStoreCommand(@"begin 
                                                clim_lim.set_atmlim(
                                                    :p_acc_id,
                                                    :p_limmax,
                                                    to_date(:p_startdate, 'dd/mm/yyyy')); 
                                                end;", parameters);
            return Get((int)limDist.Id,date);
        }

        public LimitsDistributionAtm Edit(LimitsDistributionAtm limDist, string date)
        {
            return Add(limDist,date);
        }

        public bool Delete(int id, string date)
        {
            object[] parameters =
                {
                    new OracleParameter("p_acc_id", OracleDbType.Decimal, id, ParameterDirection.Input),
                    new OracleParameter("p_startdate", OracleDbType.Varchar2, date, ParameterDirection.Input)
                };
            _entities.ExecuteStoreCommand(@"begin clim_lim.del_atmlim(:p_acc_id ,to_date(:p_startdate, 'dd/mm/yyyy'));end;", parameters);

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
                    new OracleParameter("p_message", OracleDbType.Varchar2,3500){Direction = ParameterDirection.ReturnValue}
                };
            _entities.ExecuteStoreCommand(@"begin clim_lim.load_atmxls(:p_acc_id ,:p_startdate, :p_status,:p_message);end;", parameters);
            result.Status = ((OracleParameter)parameters[2]).Value.ToString();
            result.Message = ((OracleParameter)parameters[3]).Value.ToString();

            return result;
        }


    }
}
