using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Areas.Cash.Models;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Cash.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Cash.Models;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Cash.Infrastructure.Repository.DI.Implementation
{
    public class TresholdRepository : ITresholdRepository
    {
        readonly CashEntities _entities;
        public TresholdRepository(ICashModel model)
        {
		    _entities = model.CashEntities;
        }

        public IQueryable<Treshold> GetAllTresholds()
        {
            return _entities.CLIM_TRESHOLD.Select(i=>new Treshold
            {
                Id = i.ID,
                LimitType = i.LIM_TYPE,
                DeviationPercent = i.PERCENT_DEV,
                ViolationDeys = i.DAYS_VIOL,
                ViolationColor = i.COLOUR,
                DateStart = i.PERIOD_START,
                NacCurrencyFlag = i.CURRENCY_FLAG ,
                //DateStop = i.PERIOD_STOP,
                Mfo = i.MFO,
                DateSet = i.SET_DATE,
                DateUpdate = i.UPD_DATE
            });
        }

        public List<Treshold> GetCurrentTresholds(string date)
        {
            object[] parameters =        
            { 
                new OracleParameter("p_date", OracleDbType.Varchar2, date, ParameterDirection.Input)
            };
            var sql = @"select 
                            a.id as id 
                            ,a.lim_type as LimitType
                            ,a.CURRENCY_FLAG as NacCurrencyFlag
                            ,a.kf as Mfo
                            ,a.name_ru as MfoName
                            ,a.days_viol as ViolationDeys
                            ,a.percent_dev as DeviationPercent
                            ,a.colour as ViolationColor
                            ,a.period_start as DateStart
                            ,a.set_date as DateSet
                        from 
                            table(clim_lim.getalltreshold(to_date(:p_date,'dd/mm/yyyy'))) a
                        order by 
                            a.kf";
            var result = _entities.ExecuteStoreQuery<Treshold>(sql, parameters).ToList();

            return result;
        }       

        public Treshold GetTreshold(int id)
        {
            return GetAllTresholds().FirstOrDefault(i => i.Id == id);
        }

        public List<Treshold> GetTresholdHistory(string type, string mfo, decimal curFlag)
        {
            object[] parameters =        
            { 
                new OracleParameter("p_type", OracleDbType.Varchar2, type, ParameterDirection.Input),
                new OracleParameter("p_mfo", OracleDbType.Varchar2, mfo, ParameterDirection.Input),
                new OracleParameter("p_currency_flag", OracleDbType.Decimal, curFlag, ParameterDirection.Input)
            };
            var sql = @"select 
                            a.id as id 
                            ,a.lim_type as LimitType
                            ,a.kf as Mfo
                            ,a.name_ru as MfoName
                            ,a.days_viol as ViolationDeys
                            ,a.percent_dev as DeviationPercent
                            ,a.colour as ViolationColor
                            ,a.period_start as DateStart
                            ,a.set_date as DateSet
                        from 
                            table(clim_lim.gettresholdhist(:t_type, :p_mfo,:p_currency_flag)) a
                        order by 
                            a.set_date";
            var result = _entities.ExecuteStoreQuery<Treshold>(sql, parameters).ToList();

            return result;
        }
        public Treshold AddTreshold(Treshold treshold)
        {
            switch (treshold.LimitType)
            {
                case "CASH":
                    return AddTresholdCash(treshold);
                case "ATM":
                    return AddTresholdAtm(treshold);
                case "BRANCH":
                    return AddTresholdBranch(treshold);
                default:
                    throw new Exception("Невірний тип ліміту.");
            }
        }
        public Treshold AddTresholdCash(Treshold treshold)
        {
            object[] parameters =        
            { 
                new OracleParameter("p_percent",OracleDbType.Decimal,treshold.DeviationPercent,ParameterDirection.Input),
                new OracleParameter("p_days",OracleDbType.Decimal,treshold.ViolationDeys,ParameterDirection.Input),
                new OracleParameter("p_colour",OracleDbType.Varchar2,treshold.ViolationColor,ParameterDirection.Input),
                new OracleParameter("p_start",OracleDbType.Date,treshold.DateStart,ParameterDirection.Input),
                new OracleParameter("p_mfo",OracleDbType.Varchar2,treshold.Mfo,ParameterDirection.Input),
                new OracleParameter("p_currency_flag",OracleDbType.Decimal,treshold.NacCurrencyFlag,ParameterDirection.Input),
                new OracleParameter("p_id",OracleDbType.Decimal,treshold.Id,ParameterDirection.InputOutput)
            };
            _entities.ExecuteStoreCommand(@"begin 
                                                clim_lim.set_treshold_cash(
                                                    :p_percent,
                                                    :p_days,
                                                    :p_colour,
                                                    :p_start,
                                                    :p_mfo,
                                                    :p_currency_flag,
                                                    :p_id); 
                                            end;", parameters);
            var newId = int.Parse(((OracleParameter)parameters[6]).Value.ToString());
            return GetTreshold(newId);
        }
        public Treshold AddTresholdAtm(Treshold treshold)
        {
            object[] parameters =        
            { 
                new OracleParameter("p_days",OracleDbType.Decimal,treshold.ViolationDeys,ParameterDirection.Input),
                new OracleParameter("p_colour",OracleDbType.Varchar2,treshold.ViolationColor,ParameterDirection.Input),
                new OracleParameter("p_start",OracleDbType.Date,treshold.DateStart,ParameterDirection.Input),
                new OracleParameter("p_mfo",OracleDbType.Varchar2,treshold.Mfo,ParameterDirection.Input),
                new OracleParameter("p_currency_flag",OracleDbType.Decimal,treshold.NacCurrencyFlag,ParameterDirection.Input),
                new OracleParameter("p_id",OracleDbType.Decimal,treshold.Id,ParameterDirection.InputOutput)
            };
            _entities.ExecuteStoreCommand(@"begin 
                                                clim_lim.set_treshold_atm(
                                                    :p_days,
                                                    :p_colour,
                                                    :p_start,
                                                    :p_mfo,
                                                    :p_currency_flag,
                                                    :p_id); 
                                            end;", parameters);
            var newId = int.Parse(((OracleParameter)parameters[5]).Value.ToString());
            return GetTreshold(newId);
        }
        public Treshold AddTresholdBranch(Treshold treshold)
        {
            object[] parameters =        
            { 
                new OracleParameter("p_percent",OracleDbType.Decimal,treshold.DeviationPercent,ParameterDirection.Input),
                new OracleParameter("p_days",OracleDbType.Decimal,treshold.ViolationDeys,ParameterDirection.Input),
                new OracleParameter("p_colour",OracleDbType.Varchar2,treshold.ViolationColor,ParameterDirection.Input),
                new OracleParameter("p_start",OracleDbType.Date,treshold.DateStart,ParameterDirection.Input),
                new OracleParameter("p_mfo",OracleDbType.Varchar2,treshold.Mfo,ParameterDirection.Input),
                new OracleParameter("p_currency_flag",OracleDbType.Decimal,treshold.NacCurrencyFlag,ParameterDirection.Input),
                new OracleParameter("p_id",OracleDbType.Decimal,treshold.Id,ParameterDirection.InputOutput)
            };
            _entities.ExecuteStoreCommand(@"begin 
                                                clim_lim.set_treshold_branch(
                                                    :p_percent,
                                                    :p_days,
                                                    :p_colour,
                                                    :p_start,
                                                    :p_mfo,
                                                    :p_currency_flag,
                                                    :p_id); 
                                            end;", parameters);
            var newId = int.Parse(((OracleParameter)parameters[6]).Value.ToString());
            return GetTreshold(newId);
        }


        public Treshold EditTreshold(Treshold treshold)
        {
            if (treshold.Id != null)
            {
                object[] parameters =
                {
                    new OracleParameter("p_limtype", OracleDbType.Varchar2, treshold.LimitType,ParameterDirection.Input),
                    new OracleParameter("p_percent", OracleDbType.Decimal, treshold.DeviationPercent,ParameterDirection.Input),
                    new OracleParameter("p_days", OracleDbType.Decimal, treshold.ViolationDeys, ParameterDirection.Input),
                    new OracleParameter("p_colour", OracleDbType.Varchar2, treshold.ViolationColor,ParameterDirection.Input),
                    new OracleParameter("p_start", OracleDbType.Date, treshold.DateStart, ParameterDirection.Input),
                    new OracleParameter("p_mfo", OracleDbType.Varchar2, treshold.Mfo, ParameterDirection.Input),
                    new OracleParameter("p_currency_flag",OracleDbType.Decimal,treshold.NacCurrencyFlag,ParameterDirection.Input),
                    new OracleParameter("p_id", OracleDbType.Decimal, treshold.Id, ParameterDirection.InputOutput)

                };
                _entities.ExecuteStoreCommand(@"begin 
                                                clim_lim.set_treshold(
                                                    :p_limtype,
                                                    :p_percent,
                                                    :p_days,
                                                    :p_colour,
                                                    :p_start,
                                                    :p_mfo,
                                                    :p_currency_flag,
                                                    :p_id); 
                                                end;", parameters);
                return GetTreshold((int) treshold.Id);
            }
            return null;
        }

        public bool DeleteTreshold(int id)
        {
            var treshold = GetTreshold(id);
            if (treshold == null)
            {
                return false;
            }
            object[] parameters =
                {
                    new OracleParameter("p_id", OracleDbType.Decimal, id, ParameterDirection.Input)
                };
            _entities.ExecuteStoreCommand(@"begin clim_lim.del_treshold(:p_id); end;", parameters);
            return true;
        }

    }
}
