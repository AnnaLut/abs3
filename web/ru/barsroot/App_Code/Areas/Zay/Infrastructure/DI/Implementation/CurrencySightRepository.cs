using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using Areas.Zay.Models;
using Bars.Classes;
using BarsWeb.Areas.Ndi.Infrastructure;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Zay.Models;
using BarsWeb.Models;
using Microsoft.Ajax.Utilities;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Text;

namespace BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Implementation
{
    public class CurrencySightRepository : ICurrencySightRepository
    {
        private readonly ZayModel _entities;
        public CurrencySightRepository()
        {
            var connectionStr = EntitiesConnection.ConnectionString("ZayModel", "Zay");
            _entities = new ZayModel(connectionStr);
        }

        public IEnumerable<CurrencyBuyModel> BuyDataList(decimal dk)
        {
            const string query = @"
                SELECT v.kv2, v.dk, v.id, v.fdat,v.rnk, v.nmk, v.cust_branch, v.s2, v.kurs_z, v.acc0, v.nls_acc0, v.ostc0/100 ostc0, v.okpo0,
                       v.acc1, v.nls, v.kom, v.skom, v.mfop, v.nlsp, v.okpop, v.dig, 
                       trim(to_char(v.meta,'09')||' '||v.aim_name) meta_aim_name,
                       v.contract, v.dat2_vmd, v.dat_vmd, v.dat5_vmd, 
                       trim(c.country||' '||c.name) country_name,
                       trim(substr(v.basis||' '||k7.txt,1,100)) basis_txt,
                       bc.name,
                       v.bank_code, v.bank_name, 
                       trim(to_char(v.product_group,'09')||' '||v.product_group_name) product_group_name, 
                       v.num_vmd, v.viza, v.priority, v.priorname, v.comm,
                       bars_zay.get_request_cover(v.id) cover_id,
                       v.verify_opt, v.identkb, v.kv_conv, v.req_type, v.code_2c, v.p12_2c, v.ATTACHMENTS_COUNT, 
                       v.f092 F092_Code,
                       v.f092||' '||(select z.txt from f092 z where v.f092=z.f092) F092_Text               
                FROM bars.v_zay_queue v,
                     bars.country c,
                     bars.country bc, bars.v_kod_70_2 k7
                WHERE v.sos = 0 AND v.dk = :p_dk AND v.viza = 0 AND v.country = c.country(+) AND v.benefcountry = bc.country(+)
                      AND v.basis = k7.p63(+) and mfo = f_ourmfo
                ORDER BY v.fdat desc, v.id desc
            ";

            var parameters = new object[]
            {
                new OracleParameter("p_dk", OracleDbType.Decimal, dk, ParameterDirection.Input)
            };

            return _entities.ExecuteStoreQuery<CurrencyBuyModel>(query, parameters);
        }
        public IEnumerable<CurrencySaleModel> SaleDataList(decimal dk)
        {
            // v.dk = IifS(cb_CONV=TRUE, "4", "2")

            const string query = @"
                SELECT v.kv2, v.dk, v.id, v.fdat, v.rnk, v.nmk, v.cust_branch, v.s2, v.kurs_z, v.acc0, v.nls_acc0, v.mfo0, v.okpo0, 
                    v.acc1, v.nls, v.ostc, v.dig, v.kom, v.skom, 
                    to_char(v.meta,'09')||' '||v.aim_name meta_aim_name,
                    v.viza, v.priority, v.priorname, v.comm,
                    bars_zay.get_request_cover(v.id) cover_id, 
                    v.verify_opt, v.obz, v.aims_code, null txt, v.kv_conv, v.req_type, v.ATTACHMENTS_COUNT,
                    v.f092 F092_Code,
                    v.f092||' '||(select z.txt from f092 z where v.f092=z.f092) F092_Text
                FROM v_zay_queue v
                WHERE v.sos = 0 
                      AND v.dk = :p_dk
                      AND v.viza <= 0 
                      and mfo = f_ourmfo  /*IifS(strDFilter='', '', ' and ' strDFilter) '*/
                ORDER BY v.fdat desc, v.id desc
            ";

            var parameters = new object[]
            {
                new OracleParameter("p_dk", OracleDbType.Decimal, dk, ParameterDirection.Input)
            };

            return _entities.ExecuteStoreQuery<CurrencySaleModel>(query, parameters);
        }
        public IEnumerable<PrimaryBuy> PrimaryBuyDataList(decimal dk)
        {
            const string query = @"
                SELECT dk, id, rnk, sos, nmk, cust_branch, fdat, kv2, lcv, dig, kurs_z, s2, priority, priorname, kv_conv, req_type, code_2c, p12_2c, viza
                FROM v_zay_queue
                WHERE dk = :p_dk AND sos = 0 AND viza = 1 AND priorverify = 1 AND s2 > 0 and mfo = f_ourmfo
                ORDER BY fdat desc, id desc";

            var parameters = new object[]
            {
                new OracleParameter("p_dk", OracleDbType.Decimal, dk, ParameterDirection.Input)
            };

            return _entities.ExecuteStoreQuery<PrimaryBuy>(query, parameters);;
        }

        public IEnumerable<PrimarySale> PrimarySaleDataList(decimal dk)
        {
            const string query = @"
                SELECT dk, id, rnk, sos, nmk, cust_branch, fdat, kv2, lcv, dig, kurs_z, s2, priority, priorname, req_type, viza
                FROM v_zay_queue
                WHERE dk = :p_dk AND sos = 0 AND viza = 1 AND priorverify = 1 AND s2 > 0 AND kurs_z IS NOT NULL
                    and mfo = f_ourmfo
                ORDER BY fdat desc, id desc";

            var parameters = new object[]
            {
                new OracleParameter("p_dk", OracleDbType.Decimal, dk, ParameterDirection.Input)
            };

            return _entities.ExecuteStoreQuery<PrimarySale>(query, parameters);
        }

        public void SaveAdditionalDetails(AdditionalDetails details)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                CultureInfo cultureinfo = new CultureInfo("uk-UA");
                var datVmd = !details.DatVmd.IsNullOrEmpty() ? DateTime.Parse(details.DatVmd, cultureinfo) : (DateTime?)null;
                var dat2Vmd = !details.Dat2Vmd.IsNullOrEmpty() ? DateTime.Parse(details.Dat2Vmd, cultureinfo) : (DateTime?)null;

                OracleCommand command = new OracleCommand("bars.bars_zay.set_visa_parameters", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("p_id", OracleDbType.Decimal, details.Id, ParameterDirection.Input);
                command.Parameters.Add("p_verify_opt", OracleDbType.Decimal, details.VerifyOpt, ParameterDirection.Input);
                command.Parameters.Add("p_meta", OracleDbType.Decimal, details.Meta, ParameterDirection.Input);
                command.Parameters.Add("p_f092", OracleDbType.Varchar2, details.F092, ParameterDirection.Input);
                command.Parameters.Add("p_contract", OracleDbType.Varchar2, details.Contract, ParameterDirection.Input);
                command.Parameters.Add("p_dat2_vmd", OracleDbType.Date, dat2Vmd, ParameterDirection.Input);
                command.Parameters.Add("p_dat_vmd", OracleDbType.Date, datVmd, ParameterDirection.Input);
                command.Parameters.Add("p_dat5_vmd", OracleDbType.Varchar2, details.Dat5Vmd, ParameterDirection.Input);
                command.Parameters.Add("p_country", OracleDbType.Decimal, details.Country, ParameterDirection.Input);
                command.Parameters.Add("p_basis", OracleDbType.Varchar2, details.Basis, ParameterDirection.Input);
                command.Parameters.Add("p_benefcountry", OracleDbType.Decimal, details.BenefCountry,
                    ParameterDirection.Input);
                command.Parameters.Add("p_bank_name", OracleDbType.Varchar2, details.BankName, ParameterDirection.Input);
                command.Parameters.Add("p_bank_code", OracleDbType.Varchar2, details.BankCode, ParameterDirection.Input);
                command.Parameters.Add("p_product_group", OracleDbType.Varchar2, details.ProductGroup,
                    ParameterDirection.Input);
                command.Parameters.Add("p_num_vmd", OracleDbType.Varchar2, details.NumVmd, ParameterDirection.Input);
                command.Parameters.Add("p_code_2c", OracleDbType.Varchar2, details.Code2C, ParameterDirection.Input);
                command.Parameters.Add("p_p12_2c", OracleDbType.Varchar2, details.P122C, ParameterDirection.Input);

                command.ExecuteNonQuery();
                /*
                 * 	ORA-00933: SQL command not properly ended 
                 * 	ORA-06512: at "BARS.BARS_ZAY", line 4384 
                 * 	ORA-06512: at line 1   
                 */
            }
            finally
            {
                connection.Close();
            }
        }
        
        public void BackRequestFunc(BackRequestModel request)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("bars.bars_zay.back_request", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("p_mode", OracleDbType.Decimal, request.Mode, ParameterDirection.Input);
                command.Parameters.Add("p_id", OracleDbType.Decimal, request.Id, ParameterDirection.Input);
                command.Parameters.Add("p_idback", OracleDbType.Decimal, request.IdBack, ParameterDirection.Input);
                command.Parameters.Add("p_comm", OracleDbType.Varchar2, request.Comment, ParameterDirection.Input);

                command.ExecuteNonQuery();
            }
            finally
            {
                connection.Close();
            }
        }
        
        public byte[] GetFileCorpData(decimal id)
        {
            const string query = @"select z.doc_desc from zay_corpdocs z where z.doc_id = :p_docId";
            var param = new object[]
            {
                new OracleParameter("p_docId", OracleDbType.Decimal, id, ParameterDirection.Input)
            };
            return _entities.ExecuteStoreQuery<byte[]>(query, param).SingleOrDefault();
        }

        public decimal CurrencyStatus(decimal kv)
        {
            const string query = @"SELECT nvl(blk,0) 
                FROM diler_kurs
                WHERE kv = :nKV AND dat = 
                    (SELECT max(dat) FROM diler_kurs WHERE trunc(dat) = trunc(sysdate) AND kv = :nKV)";
            var parameters = new object[]
            {
                new OracleParameter("nKV", OracleDbType.Decimal, kv, ParameterDirection.Input)
            };
            return _entities.ExecuteStoreQuery<decimal>(query, parameters).SingleOrDefault();
        }

        public CurrencyRate CurrencyRate(decimal kv)
        {
            const string query = @"
                SELECT d.kurs_b CurrencyBuy, d.kurs_s CurrencySale 
                FROM diler_kurs d
                WHERE kv = :nCUR 
                AND dat = (SELECT max(dat) FROM diler_kurs WHERE trunc(dat) = trunc(sysdate) 
                AND kv = :nCUR)";
            var param = new object[]
            {
                new OracleParameter("nCUR", OracleDbType.Decimal, kv, ParameterDirection.Input)
            };
            return _entities.ExecuteStoreQuery<CurrencyRate>(query, param).SingleOrDefault();
        }

        public void CurrencyRateUpdate(decimal id, decimal kursZ)
        {
            const string query = @"UPDATE zayavka SET kurs_z = :nRate WHERE id = :nId";
            var parameters = new object[]
            {
                new OracleParameter("nRate", OracleDbType.Decimal, kursZ, ParameterDirection.Input),
                new OracleParameter("nId", OracleDbType.Decimal, id, ParameterDirection.Input)
            };
            _entities.ExecuteStoreCommand(query, parameters);
        }

        public void ZayCheckData(ZayCheckDataModel item)
        {

            var verifyOpt = _entities.ZAYAVKA.Where(z => z.ID == item.id).Select(z => z.VERIFY_OPT).SingleOrDefault();

            if (verifyOpt == 1)
            {
                OracleConnection connection = OraConnector.Handler.UserConnection;
                try
                {
                    OracleCommand command = new OracleCommand("bars.bars_zay.p_zay_check_data", connection);
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add("p_dk", OracleDbType.Decimal, item.dk, ParameterDirection.Input);
                    command.Parameters.Add("p_id", OracleDbType.Decimal, item.id, ParameterDirection.Input);
                    command.Parameters.Add("p_kv", OracleDbType.Decimal, item.kv, ParameterDirection.Input);
                    command.Parameters.Add("p_sum", OracleDbType.Decimal, item.s, ParameterDirection.Input);
                    command.Parameters.Add("p_rate", OracleDbType.Decimal, item.kursZ, ParameterDirection.Input);
                    command.Parameters.Add("p_dat", OracleDbType.Date, item.fDat, ParameterDirection.Input);

                    command.ExecuteNonQuery();
                }
                finally
                {
                    connection.Close();
                }
            }
        }

        public decimal IsReserved()
        {
            const string query = @"
                SELECT to_number(val) nReserve
                FROM birja
                WHERE par = 'RESERV'";
            
            return _entities.ExecuteStoreQuery<decimal>(query).SingleOrDefault();
        }
        
        public ReserveResult ReserveCheckout(decimal type, decimal id)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                ReserveResult res = new ReserveResult();

                decimal s = 0;
                var msg = "";

                OracleCommand command = new OracleCommand("BARS.p_zay_reserve", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("type_", OracleDbType.Decimal, type, ParameterDirection.Input);
                command.Parameters.Add("idz_", OracleDbType.Decimal, id, ParameterDirection.Input);
                //command.Parameters.Add("sum_", OracleDbType.Decimal, s, ParameterDirection.InputOutput);

                OracleParameter sum = new OracleParameter("sum_", OracleDbType.Int32,
                    ParameterDirection.InputOutput);
                command.Parameters.Add(sum);

                command.Parameters.Add("msg_", OracleDbType.Varchar2, 300, msg, ParameterDirection.InputOutput);

                command.ExecuteNonQuery();

                res.SumB = ((OracleDecimal) sum.Value).Value; // Convert.ToDecimal(command.Parameters["sum_"].Value);
                res.Msg = Convert.ToString(command.Parameters["msg_"].Value);

                return res;
            }
            finally
            {
                connection.Close();
            }
        }

        public decimal IsBlocked(decimal id)
        {
            const string query = @"
                SELECT dk 
                FROM zayavka 
                WHERE id = :nIdZay";

            var param = new object[]
            {
                new OracleParameter("nIdZay", OracleDbType.Decimal, id, ParameterDirection.Input)
            };

            return _entities.ExecuteStoreQuery<decimal>(query, param).SingleOrDefault();
        }


        public decimal CoveredValue()
        {
            const string query = @"
                SELECT to_number(val) 
                FROM birja
                WHERE par = 'COVERED'";

            return _entities.ExecuteStoreQuery<decimal>(query).SingleOrDefault();
        }

        public void SetVisa(Visa item)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("bars.bars_zay.set_visa", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("p_id", OracleDbType.Decimal, item.Id, ParameterDirection.Input);
                command.Parameters.Add("p_viza", OracleDbType.Decimal, item.Viza, ParameterDirection.Input);
                command.Parameters.Add("p_priority", OracleDbType.Decimal, item.Priority, ParameterDirection.Input);
                command.Parameters.Add("p_aims_code", OracleDbType.Decimal, item.AimsCode, ParameterDirection.Input);
                command.Parameters.Add("p_f092", OracleDbType.Varchar2, item.F092Code, ParameterDirection.Input);
                command.Parameters.Add("p_sup_doc", OracleDbType.Decimal, item.SupDoc, ParameterDirection.Input);

                command.ExecuteNonQuery();
            }
            finally
            {
                connection.Close();
            }
        }

        // Dealer:
        public IEnumerable<DealerBuy> DealerBuyData(decimal dk, decimal? sos, decimal? visa)
        {
            StringBuilder queryBuilder = new StringBuilder()
                .Append(@"
                        SELECT id, mfo, mfo_name, req_id, dk, sos, decode(sos, 0, 0, 1) SOS_DECODED, kv2, lcv, dig, kv_conv,
                                fdat, kurs_z, vdate, kurs_f, (nvl(s2, 0)/100) s2, viza, datz,
                                rnk, nmk, cust_branch, priority, priorname, aim_name, comm, kurs_kl,
                                (case when priorverify = 0 and viza >= 1 then 1
                                      when priorverify = 1 and viza >= 2 then 1
                                      else 0 
                                 end) PRIORVERIFY_VIZA,
                                close_type, close_type_name, state, start_time, req_type, vdate_plan, sq S2_EQV
                        FROM v_zay
                        WHERE dk = :p_dk AND s2 > 0 AND nvl(fdat,bankdate) <= bankdate 
                            AND")
                .AppendFormat((null == sos && null == visa) 
                            ? " (sos < 1 AND sos >= 0 AND viza >= 0 OR sos >=1  AND vdate = bankdate)"
                            : " (sos = {0} AND viza = {1})", sos, visa)
                .Append(" ORDER BY fdat desc, id desc");

            var parameters = new object[]
            {
                new OracleParameter("p_dk", OracleDbType.Decimal, dk, ParameterDirection.Input)
            };
            string query = queryBuilder.ToString();

            return _entities.ExecuteStoreQuery<DealerBuy>(query, parameters); ;
        }

        public IEnumerable<DealerSale> DealerSaleData(decimal dk, decimal? sos, decimal? visa)
        {
            StringBuilder queryBuilder = new StringBuilder()
                .Append(@"
                        SELECT id, mfo, mfo_name, req_id, dk, sos, decode(sos,0,0,1) SOS_DECODED, kv2, lcv, dig, kv_conv, 
                                fdat, kurs_z, vdate, kurs_f, (nvl(s2, 0)/100) s2, viza, datz, 
                                rnk, nmk, cust_branch, priority, priorname, aim_name, comm, kurs_kl,
                                (case when priorverify = 0 and viza >= 1 then 1
                                      when priorverify = 1 and viza >= 2 then 1
                                      else 0 
                                 end) PRIORVERIFY_VIZA,
                                close_type, close_type_name, nvl(obz,0) obz, state, start_time, req_type, sq S2_EQV
                        FROM v_zay
                        WHERE dk = :p_dk AND s2 > 0  AND nvl(fdat,bankdate) <= bankdate 
                            AND")
                .AppendFormat((null == sos && null == visa)
                            ? @" (sos < 1 AND sos >= 0 AND viza >= 0 OR sos >=1  AND vdate = bankdate)"
                            : " (sos = {0} AND viza = {1})", sos, visa)
                .Append(" ORDER BY fdat desc, id desc");

            var parameters = new object[]
            {
                new OracleParameter("p_dk", OracleDbType.Decimal, dk, ParameterDirection.Input)
            };
            string query = queryBuilder.ToString();

            return _entities.ExecuteStoreQuery<DealerSale>(query, parameters); ;
        }

        public decimal DilViza()
        {
            const string query = @"
                SELECT to_number(nvl(val,0))
                    FROM birja WHERE par='DIL_VIZA'";

            return _entities.ExecuteStoreQuery<decimal>(query).SingleOrDefault();
        }
        public DateTime BankDate()
        {
            var date = _entities.ExecuteStoreQuery<DateTime>("SELECT bankdate FROM dual").FirstOrDefault();
            return date;
        }


        public void UpdateSosData(SetSos item)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("bars.bars_zay.set_sos", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("p_id", OracleDbType.Decimal, item.Id, ParameterDirection.Input);
                command.Parameters.Add("p_kurs_f", OracleDbType.Decimal, item.KursF, ParameterDirection.Input);
                command.Parameters.Add("p_sos", OracleDbType.Decimal, item.Sos, ParameterDirection.Input);
                command.Parameters.Add("p_vdate", OracleDbType.Date, item.Vdate, ParameterDirection.Input);
                command.Parameters.Add("p_close_type", OracleDbType.Decimal, item.CloseType, ParameterDirection.Input);
                command.Parameters.Add("p_fdat", OracleDbType.Date, item.Fdat, ParameterDirection.Input);

                command.ExecuteNonQuery();
            }
            finally
            {
                connection.Close();
            }
        }


        public IEnumerable<DILER_KURS> DilerKursData(decimal mode)
        {
            var query = string.Format(@"
                SELECT diler_kurs.type, diler_kurs.dat, diler_kurs.kv, diler_kurs.id,
                    diler_kurs.kurs_b, diler_kurs.kurs_s,
                    diler_kurs.vip_b, diler_kurs.vip_s,
                    s.fio, t.name, diler_kurs.blk   
                FROM ( select 'Індикативний' type, dat, kv, id, kurs_b, kurs_s, vip_b, vip_s, blk, code from diler_kurs
                           union all
                    select 'Фактичний', dat, kv, id, kurs_b, kurs_s, null, null, null, code from diler_kurs_fact ) diler_kurs, staff$base s, tabval t
                WHERE diler_kurs.kv = t.kv AND diler_kurs.id = s.id {0} 
                    ORDER BY 2 desc, 3 asc", mode == 1 ? " AND trunc(diler_kurs.dat) = trunc(sysdate)" : "");
            return _entities.ExecuteStoreQuery<DILER_KURS>(query);
        }

        public IEnumerable<DILER_KURS_CONV> DilerKursConvData(decimal mode)
        {
            var query = string.Format(@"
                SELECT diler_kurs_conv.dat, diler_kurs_conv.kv1, diler_kurs_conv.kv2,
                    diler_kurs_conv.kurs_i, diler_kurs_conv.kurs_f
                FROM diler_kurs_conv 
                WHERE 1=1 {0} 
                ORDER BY 1 desc, 2 asc", mode == 1 ? " AND trunc(diler_kurs_conv.dat) = trunc(sysdate)" : "");
            return _entities.ExecuteStoreQuery<DILER_KURS_CONV>(query);
        }


        public void UpdateDilerIndKurs(decimal? kvCode, bool blk, decimal? indBuy, decimal? indSale, decimal? indBuyVip, decimal? indSaleVip)
        {
            const string query = @"
                INSERT INTO diler_kurs (dat,kv,id,kurs_b,kurs_s,vip_b,vip_s,blk) VALUES
                        (sysdate,:dfKV,null,:dfKURS_B,:dfKURS_S,:dfVIP_B,:dfVIP_S,:cbBLK)";
            var parameters = new object[]
            {
                new OracleParameter("dfKV", OracleDbType.Decimal, kvCode, ParameterDirection.Input),
                new OracleParameter("dfKURS_B", OracleDbType.Decimal, indBuy, ParameterDirection.Input),
                new OracleParameter("dfKURS_S", OracleDbType.Decimal, indSale, ParameterDirection.Input),
                new OracleParameter("dfVIP_B", OracleDbType.Decimal, indBuyVip, ParameterDirection.Input),
                new OracleParameter("dfVIP_S", OracleDbType.Decimal, indSaleVip, ParameterDirection.Input),
                new OracleParameter("cbBLK", OracleDbType.Decimal, blk ? 1 : 0, ParameterDirection.Input)
            };
            _entities.ExecuteStoreCommand(query, parameters);
        }

        public void UpdateDilerFactKurs(decimal? kvCode, decimal? fBuy, decimal? fSale)
        {
            const string query = @"
                insert into diler_kurs_fact (dat, kv, id, kurs_b, kurs_s) 
                    values (sysdate, :dfKV, null, :dfKURS_B, :dfKURS_S)";
            var parameters = new object[]
            {
                new OracleParameter("dfKV", OracleDbType.Decimal, kvCode, ParameterDirection.Input),
                new OracleParameter("dfKURS_B", OracleDbType.Decimal, fBuy, ParameterDirection.Input),
                new OracleParameter("dfKURS_S", OracleDbType.Decimal, fSale, ParameterDirection.Input)
            };
            _entities.ExecuteStoreCommand(query, parameters);
        }

        public void SetDilerConvKurs(decimal type, decimal? pairKursF, decimal? pairKursS, decimal? newKurs)
        {
            const string query = @"
                begin
                    bars.bars_zay.set_conv_kurs(:nKv1, :nKv2, trunc(sysdate), :dfKURS_Conv, :type);
                end;";
            var parameters = new object[]
            {
                new OracleParameter("nKv1", OracleDbType.Decimal, pairKursF, ParameterDirection.Input),
                new OracleParameter("nKv2", OracleDbType.Decimal, pairKursS, ParameterDirection.Input),
                new OracleParameter("dfKURS_Conv", OracleDbType.Decimal, newKurs, ParameterDirection.Input),
                new OracleParameter("type", OracleDbType.Decimal, type, ParameterDirection.Input)
            };
            _entities.ExecuteStoreCommand(query, parameters);
        }


        public void BirjaSetViza(decimal id, DateTime? datz)
        {
            //CultureInfo cultureinfo = new CultureInfo("uk-UA");
            //var datZ = datz.HasValue ? DateTime.Parse(datz, cultureinfo) : (DateTime?)null;
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("bars.bars_zay.visa_kurs", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("p_id", OracleDbType.Decimal, id, ParameterDirection.Input);
                command.Parameters.Add("p_datz", OracleDbType.Date, datz, ParameterDirection.Input);

                command.ExecuteNonQuery();
            }
            finally
            {
                connection.Close();
            }
        }

        public void BirjaBackRequest(decimal id)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("bars.bars_zay.back_request", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("p_mode", OracleDbType.Decimal, 5, ParameterDirection.Input);
                command.Parameters.Add("p_id", OracleDbType.Decimal, id, ParameterDirection.Input);
                command.Parameters.Add("p_idback", OracleDbType.Decimal, 0, ParameterDirection.Input);
                command.Parameters.Add("p_comm", OracleDbType.Varchar2, "", ParameterDirection.Input);

                command.ExecuteNonQuery();
            }
            finally
            {
                connection.Close();
            }
        }

        public void SepatationSum(SeparationModel item)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("bars.bars_zay.p_zay_multiple", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("p_id", OracleDbType.Decimal, item.id, ParameterDirection.Input);
                command.Parameters.Add("p_sum1", OracleDbType.Decimal, item.sum1, ParameterDirection.Input);
                command.Parameters.Add("p_sum2", OracleDbType.Decimal, item.sum2, ParameterDirection.Input);

                command.ExecuteNonQuery();
            }
            finally
            {
                connection.Close();
            }
        }

        public IEnumerable<string> DealerFieldValues(decimal dk, decimal? sos, decimal? visa, string field)
        {
            StringBuilder queryBuilder = new StringBuilder()
                .AppendFormat("SELECT DISTINCT to_char({0}) ", field)
                .Append(@"
                        FROM v_zay
                        WHERE dk = :p_dk AND s2 > 0 AND nvl(fdat,bankdate) <= bankdate 
                            AND")
                .AppendFormat((null == sos && null == visa)
                ? " (sos < 1 AND sos >= 0 AND viza >= 0 OR sos >=1  AND vdate = bankdate)"
                : " (sos = {0} AND viza = {1})", sos, visa);

            var parameters = new object[]
            {
                new OracleParameter("p_dk", OracleDbType.Decimal, dk, ParameterDirection.Input)
            };
            string query = queryBuilder.ToString();

            return _entities.ExecuteStoreQuery<string>(query, parameters);
        }
    }
}