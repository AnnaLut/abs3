using BarsWeb.Areas.Escr.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Escr.Models;
using BarsWeb.Models;
using System.Linq;
using System;
using System.Text;
using System.Web;
using System.Collections.Generic;
using System.Globalization;
using System.Threading;
using System.Threading.Tasks;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Runtime.Serialization.Json;
using System.IO;
using Newtonsoft.Json;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Classes;
using BarsWeb.Areas.Escr.Infrastructure.OraTypeConverter;
using System.Xml;
using System.Security.Cryptography;
using System.Globalization;
namespace BarsWeb.Areas.Escr.Infrastructure.DI.Implementation
{
    public class EscrRepository : IEscrRepository
    {
        //private EscrEntities _entities;
        CultureInfo ci = CultureInfo.CreateSpecificCulture("en-GB");
        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
        public EscrRepository()
        {
            ci.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
            ci.DateTimeFormat.DateSeparator = ".";
        }

        public IQueryable<EscrRegisterMain> GetRegisterMain(string dateFrom, string dateTo, string type, string kind)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            List<EscrRegisterMain> register = new List<EscrRegisterMain>();
            var sql = @"select rownum as num, t.* 
                          from vw_escr_reg_all_credits t 
                         where 1=1";
            if (!String.IsNullOrEmpty(dateFrom) && !String.IsNullOrEmpty(dateTo))
            {
                sql += " and to_date(t.doc_date,'dd.mm.yyyy') >= to_date('" +  dateFrom + "','dd.mm.yyyy')" +
                      " and to_date(t.doc_date,'dd.mm.yyyy') <= to_date('" + dateTo + "','dd.mm.yyyy')";
            }
            if (!String.IsNullOrEmpty(type.ToString()))
            {
                sql += " and t.reg_type_code = '" + type + "'";
            }
            if (!String.IsNullOrEmpty(kind.ToString()))
            {
                sql += " and t.reg_kind_code = '" + kind + "'";
            }
            if (!String.IsNullOrEmpty(dateFrom) && !String.IsNullOrEmpty(dateTo) && !String.IsNullOrEmpty(type.ToString()) && !String.IsNullOrEmpty(kind.ToString()))
            {
                sql += " and not exists (select  null from  escr_reg_mapping rm where rm.out_doc_id=t.deal_id and rm.oper_type=0)";
            }
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = sql;
                //cmd.Parameters.Add("p_date_from", OracleDbType.Date, Convert.ToDateTime(dateFrom, ci), System.Data.ParameterDirection.Input);
                //cmd.Parameters.Add("p_date_to", OracleDbType.Date, Convert.ToDateTime(dateTo, ci), System.Data.ParameterDirection.Input);

                OracleDataReader reader = cmd.ExecuteReader();
                
                while (reader.Read())
                {
                    EscrRegisterMain r = new EscrRegisterMain();
                    r.NUM = reader.GetDecimal(0);
                    r.CUSTOMER_ID = Convert.ToDecimal(reader.GetDecimal(1));
                    r.CUSTOMER_NAME = reader.GetString(2);
                    r.CUSTOMER_OKPO = reader.GetString(3);
                    r.CUSTOMER_REGION = String.IsNullOrEmpty(reader.GetValue(4).ToString()) ? String.Empty : reader.GetString(4);
                    r.CUSTOMER_FULL_ADDRESS = String.IsNullOrEmpty(reader.GetValue(5).ToString()) ? String.Empty : reader.GetString(5);
                    r.CUSTOMER_TYPE = reader.GetDecimal(6);
                    r.SUBS_NUMB = String.IsNullOrEmpty(reader.GetValue(7).ToString()) ? String.Empty : reader.GetString(7);
                    r.SUBS_DATE = String.IsNullOrEmpty(reader.GetValue(8).ToString()) ? (DateTime?)null : Convert.ToDateTime(reader.GetValue(8).ToString(), ci);
                    r.SUBS_DOC_TYPE = String.IsNullOrEmpty(reader.GetValue(9).ToString()) ? String.Empty : reader.GetString(9);
                    r.DEAL_ID = reader.GetDecimal(10);
                    r.DEAL_NUMBER = String.IsNullOrEmpty(reader.GetValue(11).ToString()) ? String.Empty : reader.GetString(11);
                    r.DEAL_DATE_FROM = String.IsNullOrEmpty(reader.GetValue(12).ToString()) ? (DateTime?)null : Convert.ToDateTime(reader.GetValue(12).ToString(), ci);
                    r.DEAL_DATE_TO = String.IsNullOrEmpty(reader.GetValue(13).ToString()) ? (DateTime?)null : Convert.ToDateTime(reader.GetValue(13).ToString(), ci);
                    r.DEAL_TERM = reader.GetDecimal(14);
                    r.DEAL_PRODUCT = String.IsNullOrEmpty(reader.GetValue(15).ToString()) ? String.Empty : reader.GetString(15);
                    r.DEAL_STATE = String.IsNullOrEmpty(reader.GetValue(16).ToString()) ? String.Empty : reader.GetString(16);
                    r.DEAL_TYPE_CODE = reader.GetDecimal(17);
                    r.DEAL_TYPE_NAME = String.IsNullOrEmpty(reader.GetValue(18).ToString()) ? String.Empty : reader.GetString(18);
                    r.DEAL_SUM = Convert.ToDecimal(reader.GetValue(19).ToString());
                    r.CREDIT_STATUS_ID = String.IsNullOrEmpty(reader.GetValue(20).ToString()) ? (decimal?)null : Convert.ToDecimal(reader.GetValue(20).ToString());
                    r.CREDIT_STATUS_NAME = String.IsNullOrEmpty(reader.GetValue(21).ToString()) ? String.Empty : reader.GetString(21);
                    r.CREDIT_STATUS_CODE = String.IsNullOrEmpty(reader.GetValue(22).ToString()) ? String.Empty : reader.GetString(22);
                    r.CREDIT_COMMENT = String.IsNullOrEmpty(reader.GetValue(23).ToString()) ? String.Empty : reader.GetString(23);
                    r.STATE_FOR_UI = String.IsNullOrEmpty(reader.GetValue(24).ToString()) ? String.Empty : reader.GetString(24);
                    r.GOOD_COST = String.IsNullOrEmpty(reader.GetValue(25).ToString()) ? (decimal?)null : Convert.ToDecimal(reader.GetValue(25).ToString().Replace(".", ","));
                    r.NLS = reader.GetValue(26).ToString();
                    r.ACC = Convert.ToDecimal(reader.GetValue(27).ToString());
                    r.DOC_DATE = String.IsNullOrEmpty(reader.GetValue(28).ToString()) ? (DateTime?)null : Convert.ToDateTime(reader.GetValue(28).ToString(), ci);
                    r.MONEY_DATE = String.IsNullOrEmpty(reader.GetValue(29).ToString()) ? String.Empty : reader.GetString(29);
                    r.COMP_SUM = String.IsNullOrEmpty(reader.GetValue(30).ToString()) ? (decimal?)null : reader.GetDecimal(30);
                    r.VALID_STATUS = String.IsNullOrEmpty(reader.GetValue(31).ToString()) ? String.Empty : reader.GetValue(31).ToString();
                    r.BRANCH_CODE = reader.GetString(32);
                    r.BRANCH_NAME = reader.GetString(33);
                    r.MFO = reader.GetValue(34).ToString();
                    r.USER_ID = reader.GetDecimal(35);
                    r.USER_NAME = reader.GetString(36);
                    r.REG_KIND_CODE = reader.GetString(37);
                    r.REG_KIND_NAME = reader.GetValue(38).ToString();
                    r.REG_TYPE_CODE = String.IsNullOrEmpty(reader.GetValue(39).ToString()) ? String.Empty : reader.GetString(39);
                    r.REG_TYPE_NAME = String.IsNullOrEmpty(reader.GetValue(40).ToString()) ? String.Empty : reader.GetString(40);
                    register.Add(r);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return register.AsQueryable();
        }

        public IQueryable<EscrEvents> GetEvents(decimal customerId, decimal dealId)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            List<EscrEvents> events = new List<EscrEvents>();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select rownum as num, t.* from vw_escr_reg_body_ca t where deal_id = :p_deal_id";
                //cmd.Parameters.Add("p_customer_id", OracleDbType.Decimal, customerId, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_deal_id", OracleDbType.Decimal, dealId, System.Data.ParameterDirection.Input);

                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    EscrEvents r = new EscrEvents();
                    r.NUM = reader.GetDecimal(0);
                    r.DEAL_ID = reader.GetDecimal(1);
                    r.DEAL_KF = String.IsNullOrEmpty(reader.GetValue(2).ToString()) ? String.Empty : reader.GetString(2);
                    r.DEAL_ADR_ID = String.IsNullOrEmpty(reader.GetValue(3).ToString()) ? (decimal?)null : reader.GetDecimal(3);
                    r.DEAL_REGION = String.IsNullOrEmpty(reader.GetValue(4).ToString()) ? String.Empty : reader.GetString(4);
                    r.DEAL_FULL_ADDRESS = String.IsNullOrEmpty(reader.GetValue(5).ToString()) ? String.Empty : reader.GetString(5);
                    r.DEAL_BUILD_TYPE = String.IsNullOrEmpty(reader.GetValue(6).ToString()) ? String.Empty : reader.GetString(6);
                    r.DEAL_EVENT_ID = String.IsNullOrEmpty(reader.GetValue(7).ToString()) ? (decimal?)null : reader.GetDecimal(7);
                    r.DEAL_EVENT = String.IsNullOrEmpty(reader.GetValue(8).ToString()) ? String.Empty : reader.GetString(8);
                    r.ID = String.IsNullOrEmpty(reader.GetValue(11).ToString()) ? (decimal?)null : reader.GetDecimal(11);
                    events.Add(r);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return events.AsQueryable();
        }

        public IQueryable<EscrProd> GetProd()
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            List<EscrProd> prod = new List<EscrProd>();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select t.* from escr_reg_types t";

                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    EscrProd p = new EscrProd();
                    p.ID = reader.GetDecimal(0);
                    p.CODE = String.IsNullOrEmpty(reader.GetValue(1).ToString()) ? String.Empty : reader.GetString(1);
                    p.NAME = String.IsNullOrEmpty(reader.GetValue(2).ToString()) ? String.Empty : reader.GetString(2);
                    prod.Add(p);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return prod.AsQueryable();
        }
        public IQueryable<EscrViddRee> GetVidd()
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            List<EscrViddRee> vidd = new List<EscrViddRee>();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select t.* from escr_reg_kind t";

                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    EscrViddRee v = new EscrViddRee();
                    v.ID = reader.GetDecimal(0);
                    v.CODE = String.IsNullOrEmpty(reader.GetValue(1).ToString()) ? String.Empty : reader.GetString(1);
                    v.NAME = String.IsNullOrEmpty(reader.GetValue(2).ToString()) ? String.Empty : reader.GetString(2);
                    vidd.Add(v);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return vidd.AsQueryable();
        }

        public decimal SaveRegister(EscrSaveRegister param)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            decimal reg_id = 0;
            decimal[] di = param.deals.ToArray();
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "pkg_escr_reg_utl.p_reg_create";

                cmd.Parameters.Add(new OracleParameter("in_date_from", OracleDbType.Date, param.dateFrom, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("in_date_to", OracleDbType.Date, param.dateTo, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("in_reg_type", OracleDbType.Varchar2, param.type, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("in_reg_kind", OracleDbType.Varchar2, param.kind, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("in_reg_level", OracleDbType.Decimal, 0, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("in_oper_type", OracleDbType.Decimal, 0, System.Data.ParameterDirection.Input));
                
                OracleParameter dealListParam = new OracleParameter("in_obj_list", OracleDbType.Array, di.Length, di, System.Data.ParameterDirection.Input);
                dealListParam.UdtTypeName = "BARS.NUMBER_LIST";
                cmd.Parameters.Add(dealListParam);
                cmd.Parameters.Add(new OracleParameter("out_reg_id", OracleDbType.Decimal, System.Data.ParameterDirection.Output));

                cmd.ExecuteNonQuery();
                reg_id = Convert.ToDecimal(cmd.Parameters["out_reg_id"].Value.ToString());

                /*cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "pkg_escr_reg_utl.p_mapping";
                //decimal[] deal_id = {};
                List<decimal> deal_id = new List<decimal>();
                foreach (var item in param.deals)
                {
                    deal_id.Add(item.DEAL_ID);
                }
                decimal[] di = deal_id.ToArray();
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new OracleParameter("in_in_doc_id", OracleDbType.Decimal, regId, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("in_in_doc_type", OracleDbType.Decimal, 1, System.Data.ParameterDirection.Input));
                OracleParameter dealListParam = new OracleParameter("in_out_doc_id", OracleDbType.Array, di.Length, di, System.Data.ParameterDirection.Input);
                dealListParam.UdtTypeName = "BARS.NUMBER_LIST";
                cmd.Parameters.Add(dealListParam);
                cmd.Parameters.Add(new OracleParameter("in_out_doc_type", OracleDbType.Decimal, 0, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("in_oper_type", OracleDbType.Decimal, 0, System.Data.ParameterDirection.Input));

                cmd.ExecuteNonQuery();*/
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return reg_id;
        }

        public IQueryable<EscrRegister> GetRegister(string dateFrom, string dateTo, string type, string kind)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            List<EscrRegister> register = new List<EscrRegister>();
            var sql = "select * from vw_escr_register_list t where 1=1";
            if (!String.IsNullOrEmpty(dateFrom) && !String.IsNullOrEmpty(dateTo))
            {
                sql += " and t.date_from >= to_date('" + dateFrom + "','dd.mm.yyyy')" +
                      " and  t.date_to <= to_date('" + dateTo + "','dd.mm.yyyy')";
            }
            if (!String.IsNullOrEmpty(type))
            {
                sql += " and t.reg_type_code = '" + type + "'";
            }
            if (!String.IsNullOrEmpty(kind))
            {
                sql += " and t.reg_kind_code = '" + kind + "'";
               
           }
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = sql;
                
                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    EscrRegister r = new EscrRegister();
                    r.ID = reader.GetDecimal(0);
                    r.INNER_NUMBER = String.IsNullOrEmpty(reader.GetValue(1).ToString()) ? String.Empty : reader.GetString(1);
                    r.OUTER_NUMBER = String.IsNullOrEmpty(reader.GetValue(2).ToString()) ? String.Empty : reader.GetString(2);
                    r.CREATE_DATE = String.IsNullOrEmpty(reader.GetValue(3).ToString()) ? (DateTime?)null : reader.GetDateTime(3);
                    r.DATE_FROM = String.IsNullOrEmpty(reader.GetValue(4).ToString()) ? (DateTime?)null : reader.GetDateTime(4);
                    r.DATE_TO = String.IsNullOrEmpty(reader.GetValue(5).ToString()) ? (DateTime?)null : reader.GetDateTime(5);
                    r.REG_TYPE_ID = reader.GetDecimal(6);
                    r.REG_TYPE_CODE = String.IsNullOrEmpty(reader.GetValue(7).ToString()) ? String.Empty : reader.GetString(7);
                    r.REG_TYPE_NAME = String.IsNullOrEmpty(reader.GetValue(8).ToString()) ? String.Empty : reader.GetString(8);
                    r.REG_KIND_ID = reader.GetDecimal(9);
                    r.REG_KIND_CODE = String.IsNullOrEmpty(reader.GetValue(10).ToString()) ? String.Empty : reader.GetString(10);
                    r.REG_KIND_NAME = String.IsNullOrEmpty(reader.GetValue(11).ToString()) ? String.Empty : reader.GetString(11);
                    r.BRANCH = String.IsNullOrEmpty(reader.GetValue(12).ToString()) ? String.Empty : reader.GetString(12);
                    r.REG_LEVEL = reader.GetDecimal(13);
                    r.REG_LEVEL_CODE = String.IsNullOrEmpty(reader.GetValue(14).ToString()) ? String.Empty : reader.GetString(14);
                    r.USER_ID = reader.GetDecimal(15);
                    r.USER_NAME = String.IsNullOrEmpty(reader.GetValue(16).ToString()) ? String.Empty : reader.GetString(16);
                    r.REG_STATUS_ID = reader.GetDecimal(17);
                    r.REG_STATUS_CODE = String.IsNullOrEmpty(reader.GetValue(18).ToString()) ? String.Empty : reader.GetString(18);
                    r.REG_STATUS_NAME = String.IsNullOrEmpty(reader.GetValue(19).ToString()) ? String.Empty : reader.GetString(19);
                    r.REG_UNION_FLAG = reader.GetDecimal(20) == 1 ? true : false;
                    r.CREDIT_COUNT = String.IsNullOrEmpty(reader.GetValue(21).ToString()) ? (decimal?)null : reader.GetDecimal(21);
                    r.ERR_COUNT = String.IsNullOrEmpty(reader.GetValue(22).ToString()) ? (decimal?)null : reader.GetDecimal(22);
                    r.VALID_STATUS = String.IsNullOrEmpty(reader.GetValue(23).ToString()) ? (decimal?)null : reader.GetDecimal(23);
                    register.Add(r);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return register.AsQueryable();
        }

        public IQueryable<EscrRegisterDeals> GetRegisterDeals(decimal registerId)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            List<EscrRegisterDeals> register = new List<EscrRegisterDeals>();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select rownum as num, t.* from vw_escr_reg_header_ca t where t.reg_id = :p_reg_id";
                cmd.Parameters.Add(new OracleParameter("p_reg_id", OracleDbType.Decimal, registerId, System.Data.ParameterDirection.Input));

                OracleDataReader readerDeals = cmd.ExecuteReader();

                while (readerDeals.Read())
                {
                    EscrRegisterDeals r = new EscrRegisterDeals();
                    r.NUM = readerDeals.GetDecimal(0);
                    r.CUSTOMER_ID = Convert.ToDecimal(readerDeals.GetDecimal(1));
                    r.CUSTOMER_NAME = readerDeals.GetString(2);
                    r.CUSTOMER_OKPO = readerDeals.GetString(3);
                    r.CUSTOMER_REGION = String.IsNullOrEmpty(readerDeals.GetValue(4).ToString()) ? String.Empty : readerDeals.GetString(4);
                    r.CUSTOMER_FULL_ADDRESS = readerDeals.GetString(5);
                    r.CUSTOMER_TYPE = String.IsNullOrEmpty(readerDeals.GetValue(6).ToString()) ? (decimal?)null : readerDeals.GetDecimal(6);
                    r.SUBS_NUMB = String.IsNullOrEmpty(readerDeals.GetValue(7).ToString()) ? String.Empty : readerDeals.GetString(7);
                    r.SUBS_DATE = String.IsNullOrEmpty(readerDeals.GetValue(8).ToString()) ? (DateTime?)null : Convert.ToDateTime(readerDeals.GetValue(8).ToString(), ci);
                    r.SUBS_DOC_TYPE = String.IsNullOrEmpty(readerDeals.GetValue(9).ToString()) ? String.Empty : readerDeals.GetString(9);
                    r.DEAL_ID = readerDeals.GetDecimal(10);
                    r.DEAL_NUMBER = readerDeals.GetString(11);
                    r.DEAL_DATE_FROM = readerDeals.GetDateTime(12);
                    r.DEAL_DATE_TO = readerDeals.GetDateTime(13);
                    r.DEAL_TERM = readerDeals.GetDecimal(14);
                    r.DEAL_PRODUCT = readerDeals.GetString(15);
                    r.DEAL_STATE = readerDeals.GetString(16);
                    r.DEAL_TYPE_CODE = String.IsNullOrEmpty(readerDeals.GetValue(17).ToString()) ? (decimal?)null : readerDeals.GetDecimal(17);
                    r.DEAL_TYPE_NAME = String.IsNullOrEmpty(readerDeals.GetValue(18).ToString()) ? String.Empty : readerDeals.GetString(18);
                    //r.DEAL_SUM = readerDeals.GetDecimal(19);
                    r.DEAL_SUM = String.IsNullOrEmpty(Convert.ToString(readerDeals.GetValue(19))) ? (decimal?)null : Convert.ToDecimal(readerDeals.GetValue(19).ToString().Replace(".", ","));
                    r.CREDIT_STATUS_ID = String.IsNullOrEmpty(readerDeals.GetValue(20).ToString()) ? (decimal?)null : readerDeals.GetDecimal(20);
                    r.CREDIT_STATUS_NAME = String.IsNullOrEmpty(readerDeals.GetValue(21).ToString()) ? String.Empty : readerDeals.GetString(21);
                    r.CREDIT_STATUS_CODE = String.IsNullOrEmpty(readerDeals.GetValue(22).ToString()) ? String.Empty : readerDeals.GetString(22);
                    r.CREDIT_COMMENT = String.IsNullOrEmpty(readerDeals.GetValue(23).ToString()) ? String.Empty : readerDeals.GetString(23);
                    r.STATE_FOR_UI = String.IsNullOrEmpty(readerDeals.GetValue(24).ToString()) ? String.Empty : readerDeals.GetString(24);
                    r.GOOD_COST = String.IsNullOrEmpty(readerDeals.GetValue(25).ToString()) ? (decimal?)null : Convert.ToDecimal(readerDeals.GetValue(25).ToString().Replace(".",","));
                    r.NLS = readerDeals.GetString(26);
                    r.ACC = String.IsNullOrEmpty(readerDeals.GetValue(27).ToString()) ? (decimal?)null : readerDeals.GetDecimal(27);
                    r.DOC_DATE = String.IsNullOrEmpty(readerDeals.GetValue(28).ToString()) ? (DateTime?)null : Convert.ToDateTime(readerDeals.GetValue(28).ToString(),ci);
                    r.MONEY_DATE = String.IsNullOrEmpty(readerDeals.GetValue(29).ToString()) ? String.Empty : readerDeals.GetString(29);
                    r.COMP_SUM = String.IsNullOrEmpty(readerDeals.GetValue(30).ToString()) ? (decimal?)null : readerDeals.GetDecimal(30);
                    r.VALID_STATUS = String.IsNullOrEmpty(readerDeals.GetValue(31).ToString()) ? (decimal?)null : readerDeals.GetDecimal(31);
                    r.BRANCH_CODE = readerDeals.GetString(32);
                    r.BRANCH_NAME = readerDeals.GetString(33);
                    r.MFO = readerDeals.GetString(34);
                    r.USER_ID = readerDeals.GetDecimal(35);
                    r.USER_NAME = readerDeals.GetString(36);
                    r.REG_TYPE_ID = readerDeals.GetDecimal(37);
                    r.REG_KIND_ID = readerDeals.GetDecimal(38);
                    r.REG_ID = readerDeals.GetDecimal(39);
                    register.Add(r);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return register.AsQueryable();
        }

        public string SendRegister(List<decimal> registers)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            List<EscrParam> outRegister = new List<EscrParam>();
            var result = "";
            try
            {
                for (var i = 0; i < registers.Count; i++)
                {
                    EscrParam param = new EscrParam();
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.CommandText = @"select r.*
                                      from vw_escr_register_list r
                                     where r.id = " + registers[i];

                    OracleDataReader readerReg = cmd.ExecuteReader();
                    List<EscrDealParam> deals = new List<EscrDealParam>();

                    if (readerReg.Read())
                    {
                        EscrRegisterForSend register = new EscrRegisterForSend();
                        register.ID = readerReg.GetDecimal(0);
                        register.INNER_NUMBER = String.IsNullOrEmpty(readerReg.GetValue(1).ToString()) ? String.Empty : readerReg.GetString(1);
                        register.OUTER_NUMBER = String.IsNullOrEmpty(readerReg.GetValue(2).ToString()) ? String.Empty : readerReg.GetString(2);
                        register.CREATE_DATE = String.IsNullOrEmpty(readerReg.GetValue(3).ToString()) ? (DateTime?)null : Convert.ToDateTime(readerReg.GetValue(3).ToString(), ci);
                        register.DATE_FROM = String.IsNullOrEmpty(readerReg.GetValue(4).ToString()) ? (DateTime?)null : Convert.ToDateTime(readerReg.GetValue(4).ToString(), ci);
                        register.DATE_TO = String.IsNullOrEmpty(readerReg.GetValue(5).ToString()) ? (DateTime?)null : Convert.ToDateTime(readerReg.GetValue(5).ToString(), ci);
                        register.REG_TYPE_ID = readerReg.GetDecimal(6);
                        register.REG_KIND_ID = readerReg.GetDecimal(9);
                        register.BRANCH = String.IsNullOrEmpty(readerReg.GetValue(12).ToString()) ? String.Empty : readerReg.GetString(12);
                        register.REG_LEVEL = readerReg.GetDecimal(13);
                        register.USER_ID = readerReg.GetDecimal(15);
                        register.USER_NAME = String.IsNullOrEmpty(readerReg.GetValue(16).ToString()) ? String.Empty : readerReg.GetString(16);
                        register.STATUS_ID = readerReg.GetDecimal(17);
                        register.REG_UNION_FLAG = readerReg.GetDecimal(20);
                        param.register = register;

                        cmd.CommandType = System.Data.CommandType.Text;
                        cmd.CommandText = @"select rownum as num, rm.*
                                      from vw_escr_reg_header_ca rm
                                     where rm.reg_id = :p_id";
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add(new OracleParameter("p_id", OracleDbType.Decimal, register.ID, System.Data.ParameterDirection.Input));

                        OracleDataReader readerDeals = cmd.ExecuteReader();
                        while (readerDeals.Read())
                        {
                            EscrDealParam credit = new EscrDealParam();
                            EscrRegHeader r = new EscrRegHeader();
                            r.NUM = readerDeals.GetDecimal(0);
                            r.CUSTOMER_ID = Convert.ToDecimal(readerDeals.GetDecimal(1));
                            r.CUSTOMER_NAME = readerDeals.GetString(2);
                            r.CUSTOMER_OKPO = readerDeals.GetString(3);
                            r.CUSTOMER_REGION = String.IsNullOrEmpty(readerDeals.GetValue(4).ToString()) ? String.Empty : readerDeals.GetString(4);
                            r.CUSTOMER_FULL_ADDRESS = readerDeals.GetString(5);
                            r.CUSTOMER_TYPE = readerDeals.GetDecimal(6);
                            r.SUBS_NUMB = String.IsNullOrEmpty(readerDeals.GetValue(7).ToString()) ? String.Empty : readerDeals.GetString(7);
                            r.SUBS_DATE = String.IsNullOrEmpty(readerDeals.GetValue(8).ToString()) ? (DateTime?)null : Convert.ToDateTime(readerDeals.GetValue(8).ToString(), ci);
                            r.SUBS_DOC_TYPE = String.IsNullOrEmpty(readerDeals.GetValue(9).ToString()) ? String.Empty : readerDeals.GetString(9);
                            r.DEAL_ID = readerDeals.GetDecimal(10);
                            r.DEAL_NUMBER = readerDeals.GetString(11);
                            r.DEAL_DATE_FROM = readerDeals.GetDateTime(12);
                            r.DEAL_DATE_TO = readerDeals.GetDateTime(13);
                            r.DEAL_TERM = readerDeals.GetDecimal(14);
                            r.DEAL_PRODUCT = readerDeals.GetString(15);
                            r.DEAL_STATE = readerDeals.GetString(16);
                            r.DEAL_TYPE_NAME = readerDeals.GetString(18);
                            r.DEAL_SUM = readerDeals.GetDecimal(19);
                            r.CREDIT_STATUS_ID = String.IsNullOrEmpty(readerDeals.GetValue(20).ToString()) ? (decimal?)null : readerDeals.GetDecimal(20);
                            r.CREDIT_STATUS_NAME = readerDeals.GetString(21);
                            r.CREDIT_STATUS_CODE = readerDeals.GetString(22);
                            r.CREDIT_COMMENT = String.IsNullOrEmpty(readerDeals.GetValue(23).ToString()) ? String.Empty : readerDeals.GetString(23);
                            r.STATE_FOR_UI = readerDeals.GetString(24);
                            r.GOOD_COST = String.IsNullOrEmpty(readerDeals.GetValue(25).ToString()) ? (decimal?)null : Convert.ToDecimal(readerDeals.GetValue(25).ToString().Replace(".", ","));
                            r.NLS = readerDeals.GetString(26);
                            r.DOC_DATE = String.IsNullOrEmpty(readerDeals.GetValue(28).ToString()) ? (DateTime?)null : Convert.ToDateTime(readerDeals.GetValue(28).ToString(), ci);
                            r.MONEY_DATE = String.IsNullOrEmpty(readerDeals.GetValue(29).ToString()) ? String.Empty : readerDeals.GetString(29);
                            r.COMP_SUM = String.IsNullOrEmpty(readerDeals.GetValue(30).ToString()) ? (decimal?)null : readerDeals.GetDecimal(30);
                            r.VALID_STATUS = String.IsNullOrEmpty(readerDeals.GetValue(31).ToString()) ? (decimal?)null : readerDeals.GetDecimal(31);
                            r.BRANCH_CODE = readerDeals.GetString(32);
                            r.BRANCH_NAME = readerDeals.GetString(33);
                            r.MFO = readerDeals.GetString(34);
                            r.USER_ID = readerDeals.GetDecimal(35);
                            r.USER_NAME = readerDeals.GetString(36);
                            r.REG_TYPE_ID = readerDeals.GetDecimal(37);
                            r.REG_KIND_ID = readerDeals.GetDecimal(38);
                            r.REG_ID = readerDeals.GetDecimal(39);
                            credit.credit = r;

                            cmd.CommandText = "select rownum as num, t.* from vw_escr_reg_body_ca t where deal_id = :p_deal_id";
                            cmd.Parameters.Clear();
                            cmd.Parameters.Add("p_deal_id", OracleDbType.Decimal, credit.credit.DEAL_ID, System.Data.ParameterDirection.Input);

                            OracleDataReader reader = cmd.ExecuteReader();
                            List<EscrHeaderEvents> events = new List<EscrHeaderEvents>();
                            while (reader.Read())
                            {
                                EscrHeaderEvents e = new EscrHeaderEvents();
                                e.NUM = reader.GetDecimal(0);
                                e.DEAL_ID = reader.GetDecimal(1);
                                e.DEAL_ADR_ID = String.IsNullOrEmpty(reader.GetValue(3).ToString()) ? (decimal?)null : reader.GetDecimal(3);
                                e.DEAL_REGION = String.IsNullOrEmpty(reader.GetValue(4).ToString()) ? String.Empty : reader.GetString(4);
                                e.DEAL_FULL_ADDRESS = String.IsNullOrEmpty(reader.GetValue(5).ToString()) ? String.Empty : reader.GetString(5);
                                e.DEAL_BUILD_TYPE = String.IsNullOrEmpty(reader.GetValue(6).ToString()) ? String.Empty : reader.GetString(6);
                                e.DEAL_EVENT_ID = String.IsNullOrEmpty(reader.GetValue(7).ToString()) ? (decimal?)null : reader.GetDecimal(7);
                                e.DEAL_BUILD_ID = String.IsNullOrEmpty(reader.GetValue(9).ToString()) ? (decimal?)null : reader.GetDecimal(9);
                                events.Add(e);
                            }
                            credit.events = events;
                            deals.Add(credit);
                        }
                    }
                    param.deals = deals;
                    outRegister.Add(param);
                }
                result = Send(outRegister, "POST", "CreateRegister");
                if (result == "\"Ok\"")
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "pkg_escr_reg_utl.p_set_obj_status";
                    for (int i = 0; i < outRegister.Count; i++)
                    {
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add(new OracleParameter("in_obj_id", OracleDbType.Decimal, outRegister[i].register.ID, System.Data.ParameterDirection.Input));
                        cmd.Parameters.Add(new OracleParameter("in_obj_type", OracleDbType.Decimal, 1, System.Data.ParameterDirection.Input));
                        cmd.Parameters.Add(new OracleParameter("in_status_code", OracleDbType.Varchar2, "SENT_TO_CA", System.Data.ParameterDirection.Input));

                        cmd.ExecuteNonQuery();
                    }

                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return result;
        }

        public void SetComment(decimal deal_id, string comment, string state_code, decimal object_type, decimal obj_check) 
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "pkg_escr_reg_utl.p_set_obj_status";
                cmd.Parameters.Add("in_obj_id", OracleDbType.Decimal, deal_id, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("in_obj_type", OracleDbType.Decimal, object_type, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("in_status_code", OracleDbType.Varchar2, state_code, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("in_status_comment", OracleDbType.Varchar2, comment, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("in_obj_check", OracleDbType.Decimal, obj_check, System.Data.ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }
        public void SetNewSum(decimal deal_id, decimal? new_good_cost, decimal? new_deal_sum, decimal? new_comp_sum)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "pkg_escr_reg_utl.p_set_new_sum";
                cmd.Parameters.Add("in_deal_id", OracleDbType.Decimal, deal_id, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("in_new_good_cost", OracleDbType.Decimal, new_good_cost, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("in_new_deal_sum", OracleDbType.Decimal, new_deal_sum, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("in_new_comp_sum", OracleDbType.Decimal, new_comp_sum, System.Data.ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }
       

        public void СhangeCompSum(decimal deal_id, decimal new_good_cost)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            string res = String.Empty;
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "pkg_escr_reg_utl.p_change_comp_sum";
                cmd.Parameters.Add("in_deal_id", OracleDbType.Decimal, deal_id, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("in_new_good_cost", OracleDbType.Decimal, new_good_cost, System.Data.ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }
        public void DelRegEvent(decimal deal_id, decimal event_id)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();

            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "pkg_escr_reg_utl.p_event_del";
                cmd.Parameters.Add("in_deal_id", OracleDbType.Decimal, deal_id, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("in_event_id", OracleDbType.Decimal, event_id, System.Data.ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }
        public void SetDocDate(decimal deal_id, string doc_date)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "cck_app.Set_ND_TXT";
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new OracleParameter("p_nd", OracleDbType.Decimal, deal_id, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_tag", OracleDbType.Varchar2, "ES002", System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_txt", OracleDbType.Varchar2, doc_date, System.Data.ParameterDirection.Input));
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }

        public void SetCreditState(decimal deal_id, string state_code) 
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            /*decimal[] di = new decimal[1];
            di[0] = deal_id;*/
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "pkg_escr_reg_utl.p_set_obj_status";
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new OracleParameter("in_obj_id", OracleDbType.Decimal, deal_id, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("in_obj_type ", OracleDbType.Decimal, 0, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("in_status_code ", OracleDbType.Decimal, state_code, System.Data.ParameterDirection.Input));
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }

        public decimal GroupByRegister(GroupByParams param)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            decimal reg_id = 0;
            decimal[] gr = param.registers.ToArray();
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "pkg_escr_reg_utl.p_reg_create";

                cmd.Parameters.Add(new OracleParameter("in_date_from", OracleDbType.Date, param.dateFrom, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("in_date_to", OracleDbType.Date, param.dateTo, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("in_reg_type", OracleDbType.Varchar2, param.type, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("in_reg_kind", OracleDbType.Varchar2, param.kind, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("in_reg_level", OracleDbType.Decimal, param.reg_level, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("in_oper_type", OracleDbType.Decimal, 1, System.Data.ParameterDirection.Input));

                OracleParameter dealListParam = new OracleParameter("in_obj_list", OracleDbType.Array, gr.Length, gr, System.Data.ParameterDirection.Input);
                dealListParam.UdtTypeName = "BARS.NUMBER_LIST";
                cmd.Parameters.Add(dealListParam);
                cmd.Parameters.Add(new OracleParameter("out_reg_id", OracleDbType.Decimal, System.Data.ParameterDirection.Output));

                cmd.ExecuteNonQuery();
                reg_id = Convert.ToDecimal(cmd.Parameters["out_reg_id"].Value.ToString());
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return reg_id;
        }

        public void DelGroupRegister(List<decimal> registers)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            decimal[] reg = registers.ToArray();
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "pkg_escr_reg_utl.p_unmapping";
                cmd.Parameters.Clear();
                OracleParameter dealListParam = new OracleParameter("in_doc_id", OracleDbType.Array, reg.Length, reg, System.Data.ParameterDirection.Input);
                dealListParam.UdtTypeName = "BARS.NUMBER_LIST";
                cmd.Parameters.Add(dealListParam);
                cmd.Parameters.Add(new OracleParameter("in_oper_type", OracleDbType.Decimal, 1, System.Data.ParameterDirection.Input));

                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }

        public void DelDealRegister(List<decimal> deals)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            decimal[] deal = deals.ToArray();
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "bars.pkg_escr_reg_utl.p_unmapping";
                cmd.Parameters.Clear();
                OracleParameter dealListParam = new OracleParameter("in_doc_id", OracleDbType.Array, deal.Length, deal, System.Data.ParameterDirection.Input);
                dealListParam.UdtTypeName = "BARS.NUMBER_LIST";
                cmd.Parameters.Add(dealListParam);
                cmd.Parameters.Add(new OracleParameter("in_oper_type", OracleDbType.Decimal, 0, System.Data.ParameterDirection.Input));

                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }

        public EscrChkStateResult CheckState(EscrGetStateParam param)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                EscrChkStateResult res = new EscrChkStateResult();
                EscrGetStateParam response = new EscrGetStateParam();
                /*var jsonStr = new JavaScriptSerializer().Serialize(param);
                var json = Encoding.UTF8.GetBytes(jsonStr);
                File.WriteAllBytes("h:\\test.json", json);

                XmlDocument doc = new XmlDocument();
                doc = JsonConvert.DeserializeXmlNode(jsonStr, "root");
                var xml = Encoding.UTF8.GetBytes(doc.OuterXml);
                File.WriteAllBytes("h:\\test.xml", xml);*/

                var result = "";
                if (param.deals.deal.Count > 0)
                {
                    result = Send(param, "POST", "createregister/checkstate");
                }
                else
                {
                    res.state = "success";
                    res.message = "Кредити для перевірки відсутні";
                    return res;
                }
                try
                {
                    response = new System.Web.Script.Serialization.JavaScriptSerializer().Deserialize<EscrGetStateParam>(result);
                }
                catch (Exception e)
                {
                    //_dbLogger.Error("ESCR. result=[ " + e.Message + " ]");
                    res.state = "error";
                    res.message = result;
                    return res;
                }

                try
                {
                    /*todo проставить все статусы по кредитам*/
                    List<decimal> errDeals = new List<decimal>();
                    foreach (var item in response.deals.deal)
                    {
                        var status_code = GetStatusCode((decimal)item.state_id);
                        if (item.state_id == 5 || item.state_id == 8 || item.state_id == 9)
                        {
                            errDeals.Add(item.deal_id);
                        }
                        if (item.state_id == 7 || item.state_id == 11)
                        {
                            cmd.CommandType = System.Data.CommandType.Text;
                            cmd.CommandText = "select reg_id from vw_escr_reg_header where deal_id = :p_deal_id";
                            cmd.Parameters.Clear();
                            cmd.Parameters.Add(new OracleParameter("p_deal_id", OracleDbType.Decimal, item.deal_id, System.Data.ParameterDirection.Input));
                            OracleDataReader readerDeals = cmd.ExecuteReader();
                            if (readerDeals.Read())
                            {
                                var regId = Convert.ToDecimal(readerDeals.GetValue(0).ToString());
                                SetComment(regId, String.Empty, status_code, 1, 1);
                            }
                        }
                        SetComment(item.deal_id, item.comment, status_code, 0, 0);
                    }
                    if (errDeals.Count > 0)
                    {
                        DelDealRegister(errDeals);
                    }
                    res.state = "success";
                    res.message = "Синхронізація успішно виконана";
                    return res;
                }
                catch (Exception e)
                {
                    res.state = "error";
                    res.message = e.Message;
                    return res;
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }

        /*public void CheckState()
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                EscrGetStateParam param = new EscrGetStateParam();
                /*cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "f_ourmfo_g";
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new OracleParameter("res_", OracleDbType.Varchar2, 4000, param.mfo, System.Data.ParameterDirection.ReturnValue));
                cmd.ExecuteNonQuery();
                param.mfo = cmd.Parameters["res_"].Value.ToString();*
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select bars.f_ourmfo_g as mfo from dual";
                OracleDataReader readerMfo = cmd.ExecuteReader();
                if (readerMfo.Read())
                {
                    param.mfo = readerMfo.GetString(0);
                }
                
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select rm.* from bars.vw_escr_reg_header rm where rm.credit_status_id not in (5,8,9,11,12,13,15,16) and rm.credit_status_id is not null";
                cmd.Parameters.Clear();
                
                OracleDataReader reader = cmd.ExecuteReader();
                List<EscrGetStateDeals> deals = new List<EscrGetStateDeals>();
                while (reader.Read())
                {
                    EscrGetStateDeals d = new EscrGetStateDeals();
                    d.deal_id = reader.GetDecimal(9);
                    d.state_id = reader.GetDecimal(19) == 11 ? reader.GetDecimal(19) : (decimal?)null;
                    d.comment = String.Empty;
                    d.money_date = (DateTime?)null;
                    d.is_set = reader.GetDecimal(19) == 11 ? true : false;
                    deals.Add(d);
                }
                
                param.deals = deals;
                var jsonStr = new JavaScriptSerializer().Serialize(param);
                var json = Encoding.UTF8.GetBytes(jsonStr);
                File.WriteAllBytes("h:\\test.json", json);

                XmlDocument doc = new XmlDocument();
                doc = JsonConvert.DeserializeXmlNode(jsonStr, "root");
                var xml = Encoding.UTF8.GetBytes(doc.OuterXml);
                File.WriteAllBytes("h:\\test.xml", xml);
                
                var result = "";
                if (deals.Count > 0)
                {
                    result = Send(param, "POST", "createregister/checkstate");
                }
                else 
                {
                    return;
                }
                //_dbLogger.Info("ESCR. result=[ " + result + " ]");
                try
                {
                    param = new System.Web.Script.Serialization.JavaScriptSerializer().Deserialize<EscrGetStateParam>(result);
                }
                catch (Exception e)
                {
                    //_dbLogger.Error("ESCR. result=[ " + e.Message + " ]");
                    
                }
                
                /*todo проставить все статусы по кредитам*
                List<decimal> errDeals = new List<decimal>();
                foreach(var item in param.deals)
                {
                    var status_code = GetStatusCode((decimal)item.state_id);
                    if (item.state_id == 5 || item.state_id == 8 || item.state_id == 9)
                    {
                        errDeals.Add(item.deal_id);
                    }
                    if (item.state_id == 7 || item.state_id == 11)
                    {
                        cmd.CommandType = System.Data.CommandType.Text;
                        cmd.CommandText = "select reg_id from vw_escr_reg_header where deal_id = :p_deal_id";
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add(new OracleParameter("p_deal_id", OracleDbType.Decimal, item.deal_id, System.Data.ParameterDirection.Input));
                        OracleDataReader readerDeals = cmd.ExecuteReader();
                        if (readerDeals.Read())
                        {
                            var regId = Convert.ToDecimal(readerDeals.GetValue(0).ToString());
                            SetComment(regId, String.Empty, status_code, 1, 1);
                        }
                    }
                    SetComment(item.deal_id, item.comment, status_code, 0, 0);
                }
                if (errDeals.Count > 0) 
                {
                    DelDealRegister(errDeals);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }*/

        public string Send(object register, string method, string func)
        {
            var result = "";
            HttpWebResponse response;
            try
            {
                MemoryStream stream = new MemoryStream();
                DataContractJsonSerializer ser = new DataContractJsonSerializer(register.GetType());
                ser.WriteObject(stream, register);
                stream.Position = 0;
                StreamReader reader = new StreamReader(stream);
                byte[] arrStream = Encoding.UTF8.GetBytes(reader.ReadToEnd());
                stream.Close();
                OracleConnection connection = OraConnector.Handler.UserConnection;
                OracleCommand cmd = connection.CreateCommand();
                var serviceUrl = "";
                //var loginUser = "";
                //try
                //{
                //    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                //    cmd.CommandText = "GetGlobalOption";
                //    cmd.Parameters.Clear();
                //    cmd.Parameters.Add(new OracleParameter("res_", OracleDbType.Varchar2, 4000, serviceUrl, System.Data.ParameterDirection.ReturnValue));
                //    cmd.Parameters.Add(new OracleParameter("par_", OracleDbType.Varchar2, "ESCR_USER", System.Data.ParameterDirection.Input));
                //    cmd.ExecuteNonQuery();
                //    loginUser = cmd.Parameters["res_"].Value.ToString();
                //}
                //finally
                //{

                //}
                //var passwdUser = "";
                //try
                //{
                //    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                //    cmd.CommandText = "GetGlobalOption";
                //    cmd.Parameters.Clear();
                //    cmd.Parameters.Add(new OracleParameter("res_", OracleDbType.Varchar2, 4000, serviceUrl, System.Data.ParameterDirection.ReturnValue));
                //    cmd.Parameters.Add(new OracleParameter("par_", OracleDbType.Varchar2, "ESCR_USR_ID", System.Data.ParameterDirection.Input));
                //    cmd.ExecuteNonQuery();
                //    passwdUser = cmd.Parameters["res_"].Value.ToString();
                //}
                //finally
                //{

                //}
                //var password = passwdUser;//Hash(passwdUser);
                ////password = password.Replace("-", "").ToLower();

                //byte[] passByte = Encoding.UTF8.GetBytes(loginUser + ":" + password);
                //password = Convert.ToBase64String(passByte);
                try
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "GetGlobalOption";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add(new OracleParameter("res_", OracleDbType.Varchar2, 4000, serviceUrl, System.Data.ParameterDirection.ReturnValue));
                    cmd.Parameters.Add(new OracleParameter("par_", OracleDbType.Varchar2, "ESCR_URL_CA", System.Data.ParameterDirection.Input));
                    cmd.ExecuteNonQuery();
                    serviceUrl = cmd.Parameters["res_"].Value.ToString() + func + "/";
                }
                finally
                {
                    cmd.Dispose();
                    connection.Dispose();
                    connection.Close();
                }

                var request = (HttpWebRequest)WebRequest.Create(serviceUrl);
                request.Method = method;
                request.ContentType = "application/json";
                request.ContentLength = arrStream.Length;
                //request.Headers.Add("Authorization", "Hashpassword " + password);
                Stream dataStream = request.GetRequestStream();
                dataStream.Write(arrStream, 0, arrStream.Length);
                dataStream.Close();
                response = (HttpWebResponse)request.GetResponse();
                WebHeaderCollection header = response.Headers;
                var encoding = ASCIIEncoding.ASCII;
                using (var rdr = new StreamReader(response.GetResponseStream(), encoding))
                {
                    result = rdr.ReadToEnd();
                }
            }
            catch (Exception e)
            {
                result = e.Message;
            }

            return result;
        }

        public ImportParams GetRegDeal(ImportParams param)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            string dealId = String.Empty;
            List<EscrRegisterMain> register = new List<EscrRegisterMain>();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = @"select r.reg_id,
                                           r.deal_id,
                                           r.credit_status_code
                                      from vw_escr_reg_header_ca r
                                     where r.deal_date_from = trunc(:p_deal_date)
                                       and r.deal_number = :p_deal_number
                                       and r.deal_sum = :p_deal_sum
                                       and r.customer_okpo = :p_okpo";
                cmd.Parameters.Add("p_deal_date", OracleDbType.Date, param.dealDate, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_deal_number", OracleDbType.Varchar2, 4000, param.dealNumber, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_deal_sum", OracleDbType.Decimal, param.dealSum, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_okpo", OracleDbType.Varchar2, 4000, param.okpo, System.Data.ParameterDirection.Input);
                OracleDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    param.regId = Convert.ToDecimal(reader.GetValue(0).ToString());
                    param.dealId = Convert.ToDecimal(reader.GetValue(1).ToString());
                    param.status_code = reader.GetValue(2).ToString();
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return param;
        }

        public void GenRegPl(List<decimal> registers)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            decimal[] reg = registers.ToArray();
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "bars.pkg_escr_reg_utl.p_gen_pay";
                cmd.Parameters.Clear();
                OracleParameter regListParam = new OracleParameter("in_reg_list", OracleDbType.Array, reg.Length, reg, System.Data.ParameterDirection.Input);
                regListParam.UdtTypeName = "BARS.NUMBER_LIST";
                cmd.Parameters.Add(regListParam);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }

        public string GetStatusCode(decimal status_id)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            string res = String.Empty;
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "pkg_escr_reg_utl.p_get_status_code";
                cmd.Parameters.Add("in_status_id", OracleDbType.Decimal, status_id, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("out_status_code", OracleDbType.Varchar2, 4000, res, System.Data.ParameterDirection.Output);
                cmd.ExecuteNonQuery();
                res = cmd.Parameters["out_status_code"].Value.ToString();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return res;
        }

        public void SetOutNumber(decimal reg_id, string out_number)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            string res = String.Empty;
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "pkg_escr_reg_utl.p_set_reg_out_number";
                cmd.Parameters.Add("in_reg_id", OracleDbType.Decimal, reg_id, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("in_out_number", OracleDbType.Varchar2, out_number, System.Data.ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }

        public string Validate(decimal reg_id)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            string res = String.Empty;
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "pkg_escr_reg_utl.p_get_reg_list";
                cmd.Parameters.Add("in_reg_id", OracleDbType.Decimal, reg_id, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("out_branch_list", OracleDbType.Varchar2, 4000, res, System.Data.ParameterDirection.Output);
                cmd.ExecuteNonQuery();
                res = cmd.Parameters["out_branch_list"].Value.ToString();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return res;
        }

        public static string Hash(string stringToHash)
        {
            using (var sha1 = new SHA1Managed())
            {
                return BitConverter.ToString(sha1.ComputeHash(Encoding.UTF8.GetBytes(stringToHash)));
            }
        }
    }
}