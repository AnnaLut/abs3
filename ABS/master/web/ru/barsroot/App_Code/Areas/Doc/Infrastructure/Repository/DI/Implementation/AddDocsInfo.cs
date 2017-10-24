using System;
using System.Collections.Generic;
using System.Data.Objects;
using Areas.Doc.Models;
using BarsWeb.Areas.Doc.Infrastructure.Repository.DI.Abstract;
using System.Linq;
using BarsWeb.Areas.Doc.Models;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Doc.Infrastructure.Repository.DI.Implementation
{
    public class AddDocsInfo : IAddDocsInfo
    {
        public List<AddOtcnTraceMain> GetAllReqInfo(string KODF, string DATEF)
        {
            string err = null;
            var result = new List<AddOtcnTraceMain>();
            try
            {
                using (OracleConnection conn = Bars.Classes.OraConnector.Handler.UserConnection)
                {
                    string codeCond = "";
                    if (KODF != null)
                    {
                        codeCond = String.Format("and o.KODF = '{0}'", KODF);
                    }

                    string sqlText = String.Format(@"SELECT o.REF,
                                                            o.KODF,
                                                            o.DATF,
                                                            o.KV,
                                                            o.SUMVAl,
                                                            o.comm
                                                      FROM v_otcn_trace_70_all o
                                                      WHERE  o.DATF = TO_DATE ('{1}', 'dd.mm.yyyy')
                                                            {0}", codeCond, DATEF);
                    using (OracleCommand cmd = new OracleCommand(sqlText, conn))
                    {
                        using (var reader = cmd.ExecuteReader())
                        {
                            int i = 0;
                            while (reader.Read())
                            {
                                i++;
                                var item = new AddOtcnTraceMain
                                {
                                    REF = Convert.ToDecimal(reader["REF"]),
                                    KODF = reader["KODF"].ToString(),
                                    DATF = Convert.ToDateTime(reader["DATF"]),
                                    KV = Convert.ToDecimal(reader["KV"]),
                                    SumVal = reader["SumVal"].ToString(),
                                    COMM = reader["comm"] == null ? Convert.ToDecimal(reader["REF"]) : Convert.ToDecimal(reader["comm"])
                                };
                                result.Add(item);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                err = string.Format("Невідома помилка читання даних з БД:  {0}", (ex.InnerException != null ? ex.InnerException.Message : ex.Message));
                throw new Exception(err + ex.StackTrace);
            }
            return result;
        }

        public List<AddOtcnTraceChild> GetReqDependInfo(decimal Ref)
        {
            string err = null;
            var result = new List<AddOtcnTraceChild>();
            try
            {
                using (OracleConnection conn = Bars.Classes.OraConnector.Handler.UserConnection)
                {
                    
                
                    string sqlText = String.Format("select  KODP, ZNAP  from otcn_trace_70 where ref  = {0}", Ref);
                    using (OracleCommand cmd = new OracleCommand(sqlText, conn))
                    {
                        using (var reader = cmd.ExecuteReader())
                        {
                            int i = 0;
                            while (reader.Read())
                            {
                                i++;
                                var item = new AddOtcnTraceChild
                                {
                                    KODP = reader["KODP"].ToString(),
                                    ZNAP = reader["ZNAP"].ToString()
                                };
                                result.Add(item);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                err = string.Format("Невідома помилка читання даних з БД:  {0}", (ex.InnerException != null ? ex.InnerException.Message : ex.Message));
                throw new Exception(err + ex.StackTrace);
            }
            return result; ;
        }
        public List<AddCodesInfoItem> GetUniqKodf()
        {
            string err = null;
            var result = new List<AddCodesInfoItem>();
            try
            {
                using (OracleConnection conn = Bars.Classes.OraConnector.Handler.UserConnection)
                {
                    string sqlText = @"select distinct kodf from otcn_trace_70";
                    using (OracleCommand cmd = new OracleCommand(sqlText, conn))
                    {
                        using (var reader = cmd.ExecuteReader())
                        {
                            int i = 0;
                            while (reader.Read())
                            {
                                i++;
                                var item = new AddCodesInfoItem
                                {
                                    KODF = reader["KODF"].ToString(),
                                    ID = i
                                };
                                result.Add(item);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                err = string.Format("Невідома помилка читання даних з БД:  {0}", (ex.InnerException != null ? ex.InnerException.Message : ex.Message));
                throw new Exception(err + ex.StackTrace);
            }
            return result;
        }
    }
}