using System.Linq;
using System.Collections.Generic;
using BarsWeb.Areas.CreditUi.Models;
using BarsWeb.Areas.CreditUi.Infrastructure.DI.Abstract;
using Bars.Classes;
using Oracle.DataAccess.Client;
using System;
using BarsWeb.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;

namespace BarsWeb.Areas.CreditUi.Infrastructure.DI.Implementation
{
    public class AnalysisBalanceRepository : IAnalysisBalanceRepository
    {
        private readonly IHomeRepository _balanceRepository;

        public AnalysisBalanceRepository(IHomeRepository balanceRepository)
        {
            _balanceRepository = balanceRepository;
        }

        public CreditInfo GetInfo(decimal nd)
        {
            CreditInfo credit = new CreditInfo();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = @"select cd.cc_id || ' від ' || to_char(cd.sdate,'dd.MM.yyyy') as cc_id, 
                                           c.okpo,
                                           cd.nd
                                      from cc_deal cd, 
                                           customer c
                                     where cd.rnk = c.rnk
                                       and cd.nd = :nd";
                cmd.Parameters.Add("nd", OracleDbType.Decimal, nd, System.Data.ParameterDirection.Input);
                using (OracleDataReader reader = cmd.ExecuteReader())
                {

                    while (reader.Read())
                    {
                        credit.CC_ID = reader.GetString(0);
                        credit.OKPO = reader.GetString(1);
                        credit.ND = reader.GetDecimal(2);
                    }
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return credit;
        }

        public IQueryable<AccKredit> getAccKredit(decimal nd)
        {
            var accList = new List<AccKredit>();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = @"SELECT t.acc, t.tip, t.kv,t.nls, t.nms, t.ostb, t.ostc
                                      FROM VW_ASP_DEBIT_LIST t
                                     WHERE t.nd = :nd ";
                cmd.Parameters.Add("nd", OracleDbType.Decimal, nd, System.Data.ParameterDirection.Input);
                using (OracleDataReader reader = cmd.ExecuteReader())
                {

                    while (reader.Read())
                    {
                        AccKredit acc = new AccKredit();
                        acc.ACC = reader.GetDecimal(0);
                        acc.TIP = reader.GetString(1);
                        acc.KV = reader.GetInt16(2);
                        acc.NLS = reader.GetString(3);
                        acc.NMS = reader.GetString(4);
                        acc.OSTB = reader.GetDecimal(5);
                        acc.OSTC = reader.GetDecimal(6);
                        accList.Add(acc);
                    }
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return accList.AsQueryable();
        }

        public IQueryable<AccKredit> getAccDebit(decimal nd, string ccId)
        {
            var accList = new List<AccKredit>();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = @"SELECT  t.dplan,t.FDAT,t.NPP,t.acc,t.tip,t.kv,t.nls,t.nms,t.ostb,t.ostc
                    from VW_ASP_CREDIT_LIST_SUB_ND t where t.ndg=:nd
                    union all
                    select t.dplan,t.FDAT,t.NPP,t.acc,t.tip,t.kv,t.nls,t.nms,t.ostb,t.ostc 
                    from VW_ASP_CREDIT_LIST t where nd=:nd";
                cmd.Parameters.Add("nd", OracleDbType.Decimal, nd, System.Data.ParameterDirection.Input);
                using (OracleDataReader reader = cmd.ExecuteReader())
                {

                    while (reader.Read())
                    {
                        AccKredit acc = new AccKredit();
                        acc.DPLAN = String.IsNullOrEmpty(reader.GetValue(0).ToString()) ? (DateTime?)null : reader.GetDateTime(0);
                        acc.FDAT = String.IsNullOrEmpty(reader.GetValue(1).ToString()) ? (DateTime?)null : reader.GetDateTime(1);
                        acc.NPP = String.IsNullOrEmpty(reader.GetValue(2).ToString()) ? (decimal?)null : reader.GetDecimal(2);
                        acc.ACC = reader.GetDecimal(3);
                        acc.TIP = reader.GetString(4);
                        acc.KV = reader.GetInt16(5);
                        acc.NLS = reader.GetString(6);
                        acc.NMS = reader.GetString(7);
                        acc.OSTB = reader.GetDecimal(8);
                        acc.OSTC = reader.GetDecimal(9);
                        switch (acc.TIP)
                        {
                            case "SS ": acc.NAZN = "Погашення основного боргу"; break;
                            case "SN ": acc.NAZN = "Погашення процентного боргу"; break;
                            case "SP ": acc.NAZN = "Погашення проср.осн.боргу"; break;
                            case "SPN": acc.NAZN = "Погашення проср.проц.боргу"; break;
                            case "SL ": acc.NAZN = "Погашення сумн.осн.боргу"; break;
                            case "SLN": acc.NAZN = "Погашення сумн.проц.боргу"; break;
                            case "SK0": acc.NAZN = "Погашення нарах. комісії"; break;
                            case "SK9": acc.NAZN = "Погашення проср.нарах.комісії"; break;
                            case "SN8": acc.NAZN = "Погашення нарах.пені"; break;
                            case "ISG": acc.NAZN = "Зарахування на доходи майб.періодів"; break;
                            case "SDI": acc.NAZN = "Перерахування на дисконт"; break;
                            default: break;
                        }
                        if (!String.IsNullOrEmpty(acc.NAZN))
                        {
                            acc.NAZN += " зг. КД " + ccId;
                        }
                        accList.Add(acc);
                    }
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return accList.AsQueryable();
        }

        public List<CreateResponse> createIsg(List<CreateIsg> isg)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            List<CreateResponse> resArr = new List<CreateResponse>();
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = @"bars.cck.isg1";
                for (int i = 0; i < isg.Count; i++)
                {
                    CreateResponse result = new CreateResponse();
                    try
                    {
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("p_kvD", OracleDbType.Decimal, isg[i].KVD, System.Data.ParameterDirection.Input);
                        cmd.Parameters.Add("p_nlsD", OracleDbType.Varchar2, isg[i].NLSD, System.Data.ParameterDirection.Input);
                        cmd.Parameters.Add("p_sD", OracleDbType.Decimal, isg[i].SD, System.Data.ParameterDirection.Input);
                        cmd.Parameters.Add("p_kvk", OracleDbType.Decimal, isg[i].KVK, System.Data.ParameterDirection.Input);
                        cmd.Parameters.Add("p_nlsK", OracleDbType.Varchar2, isg[i].NLSK, System.Data.ParameterDirection.Input);
                        cmd.Parameters.Add("p_nazn", OracleDbType.Varchar2, isg[i].NAZN, System.Data.ParameterDirection.Input);
                        cmd.Parameters.Add("p_REF", OracleDbType.Decimal, null, System.Data.ParameterDirection.Output);
                        cmd.ExecuteNonQuery();
                        result.referense = Convert.ToDecimal(cmd.Parameters["p_REF"].Value.ToString());
                        result.error = false;
                        resArr.Add(result);
                    }
                    catch (Exception e)
                    {
                        result.error = true;
                        result.nlsb = isg[i].NLSK;
                        result.referense = (decimal?)null;
                        resArr.Add(result);
                    }
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return resArr;
        }

    }
}