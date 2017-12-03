using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Net;
using Bars.Classes;
using BarsWeb.Areas.Mbdk.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Mbdk.Models;
using Oracle.DataAccess.Types;
using Dapper;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Mbdk.Infrastructure.DI.Implementation
{
    public class DealRepository : IDealRepository
    {
        public object SaveDeal(SaveDealParam megamodel)
        {
            if (!string.IsNullOrEmpty(megamodel.colSummaZ))
                SavePledgeSumm(megamodel.colSummaZ);

            #region check dates
            DateTime colDatDU;
            DateTime colDatDV;
            DateTime dDatEnd;
            DateTime dDateConclusion;
            DateTime? dNbuRegDate;
            if (!DateTime.TryParseExact(megamodel.colDatDV, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out colDatDU))
                throw new Exception("Невірний формат дати!");

            if (!DateTime.TryParseExact(megamodel.colDatDV, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out colDatDV))
                throw new Exception("Невірний формат дати!");

            if (!DateTime.TryParseExact(megamodel.colDatEndDog, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out dDatEnd))
                throw new Exception("Невірний формат дати!");

            if (!DateTime.TryParseExact(megamodel.colDatConclusion, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out dDateConclusion))
                throw new FormatException("Невірний формат дати фактичного заключення договору!");

            if (string.IsNullOrWhiteSpace(megamodel.colNbuRegDate))
                dNbuRegDate = null;
            else
            {
                DateTime tmpNbuDate;
                if (!DateTime.TryParseExact(megamodel.colNbuRegDate, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out tmpNbuDate))
                    throw new FormatException("Невірний формат дати реєстрації в НБУ!");
                dNbuRegDate = (DateTime?)tmpNbuDate;
            }
            #endregion

            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                // need to add new input parameters here, after DB side will be ready
                #region DONT OPEN
                p.Add("CC_ID_", megamodel.CC_ID, DbType.String, ParameterDirection.Input);
                p.Add("nVidd_", megamodel.nVidd, DbType.Decimal, ParameterDirection.Input);
                p.Add("nTipd_", null);
                p.Add("nKv_", megamodel.nKv, DbType.String, ParameterDirection.Input);
                p.Add("RNKB_", megamodel.RNKB, DbType.Decimal, ParameterDirection.Input);
                p.Add("DAT2_", colDatDU, DbType.DateTime, ParameterDirection.Input);
                p.Add("p_datv", colDatDV, DbType.DateTime, ParameterDirection.Input);
                p.Add("DAT4_", dDatEnd, DbType.DateTime, ParameterDirection.Input);
                p.Add("IR_", megamodel.IR, DbType.Decimal, ParameterDirection.Input);
                p.Add("OP_", null);//витягується в базі
                p.Add("BR_", null);//витягується в базі
                p.Add("SUM_", megamodel.colSumma, DbType.Decimal, ParameterDirection.Input);
                p.Add("nBASEY_", megamodel.nBASEY, DbType.Decimal, ParameterDirection.Input);
                p.Add("nIO_", null);//витягується в базі
                p.Add("S1_", megamodel.S1, DbType.String, ParameterDirection.Input);
                p.Add("S2_", megamodel.S2, DbType.String, ParameterDirection.Input);
                p.Add("S3_", megamodel.S3, DbType.String, ParameterDirection.Input);
                p.Add("S4_", megamodel.S4, DbType.String, ParameterDirection.Input);
                p.Add("S5_", megamodel.S5, DbType.Decimal, ParameterDirection.Input);

                p.Add("NLSA_", megamodel.NLSA, DbType.String, ParameterDirection.Input);
                p.Add("NMS_", megamodel.NMS, DbType.String, ParameterDirection.Input);
                p.Add("NLSNA_", megamodel.NLSNA, DbType.String, ParameterDirection.Input);
                p.Add("NMSN_", megamodel.NMSN, DbType.String, ParameterDirection.Input);

                p.Add("NLSNB_", megamodel.NLSNB, DbType.String, ParameterDirection.Input);
                p.Add("NMKB_", megamodel.NMKB, DbType.String, ParameterDirection.Input);

                p.Add("Nazn_", megamodel.Nazn_, DbType.String, ParameterDirection.Input);
                p.Add("NLSZ_", megamodel.NLSZ_, DbType.String, ParameterDirection.Input);
                p.Add("nKVZ_", megamodel.nKVZ_, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_pawn", megamodel.p_pawn, DbType.Decimal, ParameterDirection.Input);
                p.Add("Id_DCP_", null);//витягується в базі
                p.Add("S67_", null);//витягується в базі
                p.Add("nGrp_", null);//витягується в базі
                p.Add("nIsp_", null);//витягується в базі
                p.Add("BICA_", megamodel.BICKA, DbType.String, ParameterDirection.Input);
                p.Add("SSLA_", megamodel.SSLA, DbType.String, ParameterDirection.Input);
                p.Add("BICB_", megamodel.BICKB, DbType.String, ParameterDirection.Input);
                p.Add("SSLB_", megamodel.SSLB, DbType.String, ParameterDirection.Input);
                p.Add("SUMP_", megamodel.colSummaP, DbType.Decimal, ParameterDirection.Input);
                p.Add("AltB_", megamodel.AltB, DbType.String, ParameterDirection.Input);
                p.Add("IntermB_", null);
                p.Add("IntPartyA_", null);
                p.Add("IntPartyB_", null);
                p.Add("IntIntermA_", null);
                p.Add("IntIntermB_", null);

                #region new parameters
                p.Add("DDAte_", dDateConclusion, DbType.DateTime, ParameterDirection.Input);
                p.Add("IRR_", megamodel.irr, DbType.Decimal, ParameterDirection.Input);
                p.Add("code_product_", megamodel.productCode, DbType.Int32, ParameterDirection.Input);
                p.Add("n_nbu_", megamodel.n_nbu, DbType.String, ParameterDirection.Input);
                p.Add("d_nbu_", dNbuRegDate, DbType.DateTime, ParameterDirection.Input);
                #endregion

                p.Add("ND_", dbType: DbType.Int64, direction: ParameterDirection.Output);
                p.Add("ACC1_", dbType: DbType.Int64, direction: ParameterDirection.Output);
                p.Add("sErr_", dbType: DbType.String, direction: ParameterDirection.Output, size: 32767);
                #endregion
                connection.Execute("BARS.MBK.inp_deal_Ex", p, commandType: CommandType.StoredProcedure);

                var nd = p.Get<long?>("ND_");
                var acc = p.Get<long?>("ACC1_");
                var error = p.Get<string>("sErr_");
                var resultObj = new { nd, acc, error };
                return resultObj;
            }
        }

        public UpdateDealResponse UpdateDeal(SaveDealParam model)
        {
            UpdateDealResponse res = new UpdateDealResponse() { error = "", result = "OK" };
            try
            {
                DateTime dDateConclusion;
                if (!DateTime.TryParseExact(model.colDatConclusion, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out dDateConclusion))
                    throw new FormatException("Невірний формат дати фактичного заключення договору!");

                DateTime? dNbuRegDate;
                if (string.IsNullOrWhiteSpace(model.colNbuRegDate))
                    dNbuRegDate = null;
                else
                {
                    DateTime tmpNbuDate;
                    if (!DateTime.TryParseExact(model.colNbuRegDate, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out tmpNbuDate))
                        throw new FormatException("Невірний формат дати реєстрації в НБУ!");
                    dNbuRegDate = (DateTime?)tmpNbuDate;
                }

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var p = new DynamicParameters();
                    p.Add("p_nd", model.nd, DbType.String, ParameterDirection.Input);
                    p.Add("p_sdate", dDateConclusion, DbType.DateTime, ParameterDirection.Input);
                    p.Add("p_prod", model.productCode, DbType.String, ParameterDirection.Input);
                    p.Add("p_n_nbu", model.n_nbu, DbType.String, ParameterDirection.Input);
                    p.Add("p_d_nbu", dNbuRegDate, DbType.DateTime, ParameterDirection.Input);

                    connection.Execute("BARS.MBK.upd_cc_deal", p, commandType: CommandType.StoredProcedure);
                    //procedure upd_cc_deal (p_nd number, p_sdate date, p_prod varchar2, p_n_nbu varchar2);
                }
            }
            catch (Exception ex)
            {
                res.error = ex.Message;
                res.result = "ERROR";
            }

            return res;
        }

        public decimal DealSum(SummInfo model)
        {
            DateTime dealStartDate = DateTime.ParseExact(model.colDatDU, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            DateTime dealExpiryDate = DateTime.ParseExact(model.dDatEnd, "dd/MM/yyyy", CultureInfo.InvariantCulture);

            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                OracleCommand command = new OracleCommand("mbk.estimate_interest_amount", connection) { CommandType = CommandType.StoredProcedure };

                OracleParameter estimatedAmountParameter = new OracleParameter("p_estimated_amount", OracleDbType.Decimal, ParameterDirection.ReturnValue);

                command.Parameters.Add(estimatedAmountParameter);
                command.Parameters.Add("p_product_id", OracleDbType.Decimal, model.nVidd, ParameterDirection.Input);
                command.Parameters.Add("p_deal_start_date", OracleDbType.Date, dealStartDate, ParameterDirection.Input);
                command.Parameters.Add("p_deal_expiry_date", OracleDbType.Date, dealExpiryDate, ParameterDirection.Input);
                command.Parameters.Add("p_amount", OracleDbType.Decimal, model.nAmnt, ParameterDirection.Input);
                command.Parameters.Add("p_currency_id", OracleDbType.Decimal, model.nKv, ParameterDirection.Input);
                command.Parameters.Add("p_interest_base", OracleDbType.Decimal, model.nBASEY, ParameterDirection.Input);
                command.Parameters.Add("p_interest_rate", OracleDbType.Decimal, model.colProcStavka, ParameterDirection.Input);

                command.ExecuteNonQuery();

                OracleDecimal res = (OracleDecimal)estimatedAmountParameter.Value;
                if (!res.IsNull)
                    return ((OracleDecimal)estimatedAmountParameter.Value).Value;

                return 0;
            }
        }

        public Deal ReadReal(string id)
        {
            decimal ND;
            if (!decimal.TryParse(id, out ND))
                throw new Exception("Не коректний формат договору!");
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var sql = @"SELECT d.cc_id, d.vidd, d.vidd_name, d.tipd, d.date_u, d.date_end,
                                       d.s SUMM, d.int_amount, d.s_pr, d.basey, 
                                       d.a_nls, d.a_kv, t.lcv, d.b_nls, d.refp,
                                       d.acckred, d.accperc, d.mfokred, d.mfoperc, 
                                       d.rnk, d.nmk, d.okpo, d.mfo, d.bic, d.kod_b, d.num_nd,
                                       d.swi_bic, d.swi_acc, d.swo_bic, d.swo_acc, d.alt_partyb, t.dig,
                                       d.irr, d.date_b, d.code_product, d.name_product, d.n_nbu, d.nd, d.d_nbu
                                FROM mbk_deal d, tabval t
                                WHERE d.nd   = :ND
                                AND d.a_kv = t.kv ";

                var model = connection.Query<Deal>(sql, new { ND }).SingleOrDefault();
                if (model == null)
                {
                    var error = string.Format("За данним номером {0} договору інформації не існує", id);
                    throw new Exception(error);
                }
                return model;
            }
        }

        public List<object> ScoresNms(ScoreNms model)
        {
            var result = new List<object>();
            const string sqlNms = @"SELECT n.acc, n.nls, n.nms, a.acc, a.nls, a.nms 
                                    FROM accounts n, accounts a 
                                    WHERE n.acc = f_proc_dr(:RNKB,4,1,'MKD',:nVidd,:nKv) 
                                    AND a.acc = f_proc_dr(:RNKB,4,0,'MKD',:nVidd,:nKv)";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                object data = connection.Query(sqlNms, new { model.RNKB, model.nVidd, model.nKv }).ToList();
                result.Add(data);
                result.Add(GetNms(model, connection));
                return result;
            }
        }

        public IQueryable<Currency> GetCurrency()
        {
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                var sql = @"select kv, name lcv from v_mbdk_currency order by kv desc";
                return connection.Query<Currency>(sql).AsQueryable();
            }
        }

        private void SavePledgeSumm(string summ)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var param = new DynamicParameters();
                param.Add("tag_", "COLLATERAL_AMOUNT", DbType.String, ParameterDirection.Input);
                param.Add("val_", summ, DbType.String, ParameterDirection.Input);
                param.Add("comm_ ", "Сума застави (для проводки)", DbType.String, ParameterDirection.Input);

                connection.Execute("pul.set_mas_ini", param, commandType: CommandType.StoredProcedure);
            }
        }

        private object GetNms(ScoreNms model, IDbConnection connection)
        {
            var p = new DynamicParameters();
            p.Add("p_nbs", model.nVidd);
            p.Add("p_rnk", model.RNKB);
            p.Add("p_acrb", 0);
            p.Add("p_kv", model.nKv);
            p.Add("p_maskid", "MBK");
            p.Add("p_initiator", model.initiator);
            p.Add("p_acc_num_1", null, DbType.String, ParameterDirection.Output, 15);
            p.Add("p_acc_num_2", null, DbType.String, ParameterDirection.Output, 15);

            connection.Execute("BARS.MBK.F_NLS_MB", p, commandType: CommandType.StoredProcedure);
            var nls1 = p.Get<string>("p_acc_num_1");
            var nls2 = p.Get<string>("p_acc_num_2");
            return new { nls1, nls2 };
        }

    }
}
