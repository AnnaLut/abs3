using System;
using System.Data;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Bars.Oracle;
using System.Xml;
using Bars.Web.Report;
using ICSharpCode.SharpZipLib.Zip;
using ICSharpCode.SharpZipLib.Core;
using System.Web;
using BarsWeb.Core.Logger;
using Bars.WebServices.XRM.Services.RegPayments.Models;

namespace Bars.WebServices.XRM.Services.RegPayments
{
    public static class RegPaymentsWorker
    {
        #region SBON
        public static SbonOrderResult ProcCreateSBON(SbonOrderRequest req, OracleConnection connect)
        {
            SbonOrderResult res = new SbonOrderResult();
            OracleCommand cmdMakeSbon = connect.CreateCommand();
            try
            {
                cmdMakeSbon.Parameters.Clear();
                cmdMakeSbon.BindByName = true;

                cmdMakeSbon.Parameters.Add("p_TransactionId", OracleDbType.Decimal, req.TransactionId, ParameterDirection.Input);

                cmdMakeSbon.Parameters.Add("p_payer_account_id", OracleDbType.Decimal, req.SbonOrderReq.payer_account_id, ParameterDirection.Input);
                cmdMakeSbon.Parameters.Add("p_start_date", OracleDbType.Date, req.SbonOrderReq.start_date, ParameterDirection.Input);
                cmdMakeSbon.Parameters.Add("p_stop_date", OracleDbType.Date, req.SbonOrderReq.stop_date, ParameterDirection.Input);
                cmdMakeSbon.Parameters.Add("p_payment_frequency", OracleDbType.Decimal, req.SbonOrderReq.payment_frequency, ParameterDirection.Input);
                cmdMakeSbon.Parameters.Add("p_holiday_shift", OracleDbType.Decimal, req.SbonOrderReq.holiday_shift, ParameterDirection.Input);
                cmdMakeSbon.Parameters.Add("p_provider_id", OracleDbType.Decimal, req.SbonOrderReq.provider_id, ParameterDirection.Input);
                cmdMakeSbon.Parameters.Add("p_personal_account", OracleDbType.Varchar2, 400, req.SbonOrderReq.personal_account, ParameterDirection.Input);
                cmdMakeSbon.Parameters.Add("p_regular_amount", OracleDbType.Decimal, req.SbonOrderReq.regular_amount, ParameterDirection.Input);
                cmdMakeSbon.Parameters.Add("p_extra_attributes", OracleDbType.Clob, req.SbonOrderReq.extra_attributes, ParameterDirection.Input);
                cmdMakeSbon.Parameters.Add("p_sendsms", OracleDbType.Varchar2, 1, req.SbonOrderReq.sendsms, ParameterDirection.Input);
                cmdMakeSbon.Parameters.Add("p_order_id", OracleDbType.Decimal, res.OrderId, ParameterDirection.Output);
                cmdMakeSbon.Parameters.Add("p_result_code", OracleDbType.Decimal, res.ResultCode, ParameterDirection.Output);
                cmdMakeSbon.Parameters.Add("p_result_message", OracleDbType.Varchar2, 2000, res.ResultMessage, ParameterDirection.Output);
                if (req.SbonType == 0)
                    cmdMakeSbon.CommandText = @"begin xrm_integration_oe.CreateSbonNoContr( 
                                                             p_TransactionId    => :p_TransactionId,
                                                             p_payer_account_id => :p_payer_account_id,
                                                             p_start_date       => :p_start_date,
                                                             p_stop_date        => :p_stop_date,
                                                             p_payment_frequency=> :p_payment_frequency,
                                                             p_holiday_shift    => :p_holiday_shift,
                                                             p_provider_id      => :p_provider_id,
                                                             p_personal_account => :p_personal_account,
                                                             p_regular_amount   => :p_regular_amount,                                                             
                                                             p_extra_attributes => :p_extra_attributes,
                                                             p_sendsms          => :p_sendsms,
                                                             p_order_id         => :p_order_id,
                                                             p_result_code      => :p_result_code,
                                                             p_result_message   => :p_result_message);
                                                       end;";
                if (req.SbonType == 1)
                {
                    cmdMakeSbon.Parameters.Add("p_ceiling_amount", OracleDbType.Decimal, req.SbonOrderReq.ceiling_amount, ParameterDirection.Input);
                    cmdMakeSbon.CommandText = @"begin xrm_integration_oe.CreateSbonContr( 
                                                             p_TransactionId    => :p_TransactionId,
                                                             p_payer_account_id => :p_payer_account_id,
                                                             p_start_date       => :p_start_date,
                                                             p_stop_date        => :p_stop_date,
                                                             p_payment_frequency=> :p_payment_frequency,
                                                             p_holiday_shift    => :p_holiday_shift,
                                                             p_provider_id      => :p_provider_id,
                                                             p_personal_account => :p_personal_account,
                                                             p_regular_amount   => :p_regular_amount,
                                                             p_ceiling_amount   => :p_ceiling_amount,
                                                             p_extra_attributes => :p_extra_attributes,
                                                             p_sendsms          => :p_sendsms,
                                                             p_order_id         => :p_order_id,
                                                             p_result_code      => :p_result_code,
                                                             p_result_message   => :p_result_message);                                                    
                                        end;";
                }
                cmdMakeSbon.ExecuteNonQuery();

                OracleDecimal _pOrderId = (OracleDecimal)cmdMakeSbon.Parameters["p_order_id"].Value;
                if (!_pOrderId.IsNull)
                    res.OrderId = _pOrderId.Value;
                //res.OrderId = Convert.ToDecimal(Convert.ToString(cmdMakeSbon.Parameters["p_order_id"].Value));

                OracleDecimal _pResultCode = (OracleDecimal)cmdMakeSbon.Parameters["p_result_code"].Value;
                if (!_pResultCode.IsNull)
                    res.ResultCode = Convert.ToInt16(_pResultCode.Value);
                //res.ResultCode = Convert.ToInt16(Convert.ToString(cmdMakeSbon.Parameters["p_result_code"].Value));

                OracleString _resultMessage = (OracleString)cmdMakeSbon.Parameters["p_result_message"].Value;
                if (!_resultMessage.IsNull)
                    res.ResultMessage = _resultMessage.Value;
                //res.ResultMessage = Convert.ToString(cmdMakeSbon.Parameters["p_result_message"].Value);

                if (res.ResultCode == 0) res.Doc = Convert.ToBase64String(SbonDoc(res.OrderId));
                return res;
            }
            catch (System.Exception)
            {
                throw;
            }
            finally
            {
                cmdMakeSbon.Dispose();
            }
        }
        public static SbonFreeOrderResult ProcCreateFreeSBON(SbonFreeOrderRequest req, OracleConnection connect)
        {
            SbonFreeOrderResult res = new SbonFreeOrderResult();
            OracleCommand cmdMakeFreeSbon = connect.CreateCommand();
            try
            {
                cmdMakeFreeSbon.Parameters.Clear();
                cmdMakeFreeSbon.BindByName = true;

                cmdMakeFreeSbon.Parameters.Add("p_TransactionId", OracleDbType.Decimal, req.TransactionId, ParameterDirection.Input);
                cmdMakeFreeSbon.Parameters.Add("p_payer_account_id", OracleDbType.Decimal, req.SbonFreeOrderReq.payer_account_id, ParameterDirection.Input);
                cmdMakeFreeSbon.Parameters.Add("p_start_date", OracleDbType.Date, req.SbonFreeOrderReq.start_date, ParameterDirection.Input);
                cmdMakeFreeSbon.Parameters.Add("p_stop_date", OracleDbType.Date, req.SbonFreeOrderReq.stop_date, ParameterDirection.Input);
                cmdMakeFreeSbon.Parameters.Add("p_payment_frequency", OracleDbType.Decimal, req.SbonFreeOrderReq.payment_frequency, ParameterDirection.Input);
                cmdMakeFreeSbon.Parameters.Add("p_holiday_shift", OracleDbType.Decimal, req.SbonFreeOrderReq.holiday_shift, ParameterDirection.Input);
                cmdMakeFreeSbon.Parameters.Add("p_provider_id", OracleDbType.Decimal, req.SbonFreeOrderReq.provider_id, ParameterDirection.Input);
                cmdMakeFreeSbon.Parameters.Add("p_regular_amount", OracleDbType.Decimal, req.SbonFreeOrderReq.regular_amount, ParameterDirection.Input);
                cmdMakeFreeSbon.Parameters.Add("p_receiver_mfo", OracleDbType.Varchar2, 6, req.SbonFreeOrderReq.receiver_mfo, ParameterDirection.Input);
                cmdMakeFreeSbon.Parameters.Add("p_receiver_account", OracleDbType.Varchar2, 15, req.SbonFreeOrderReq.reciever_account, ParameterDirection.Input);
                cmdMakeFreeSbon.Parameters.Add("p_receiver_name", OracleDbType.Varchar2, 90, req.SbonFreeOrderReq.reciever_name, ParameterDirection.Input);
                cmdMakeFreeSbon.Parameters.Add("p_receiver_edrpou", OracleDbType.Varchar2, 10, req.SbonFreeOrderReq.receiver_edrpou, ParameterDirection.Input);
                cmdMakeFreeSbon.Parameters.Add("p_purpose", OracleDbType.Varchar2, 160, req.SbonFreeOrderReq.purpose, ParameterDirection.Input);
                cmdMakeFreeSbon.Parameters.Add("p_extra_attributes", OracleDbType.Clob, req.SbonFreeOrderReq.extra_attributes, ParameterDirection.Input);
                cmdMakeFreeSbon.Parameters.Add("p_sendsms", OracleDbType.Varchar2, 1, req.SbonFreeOrderReq.sendsms, ParameterDirection.Input);
                cmdMakeFreeSbon.Parameters.Add("p_order_id", OracleDbType.Decimal, res.OrderId, ParameterDirection.Output);
                cmdMakeFreeSbon.Parameters.Add("p_result_code", OracleDbType.Decimal, res.ResultCode, ParameterDirection.Output);
                cmdMakeFreeSbon.Parameters.Add("p_result_message", OracleDbType.Varchar2, 2000, res.ResultMessage, ParameterDirection.Output);

                cmdMakeFreeSbon.CommandText = @"begin xrm_integration_oe.CreateFreeSbonRegular( 
                                                        p_TransactionId         => :p_TransactionId,
                                                        p_payer_account_id      => :p_payer_account_id,
                                                        p_start_date            => :p_start_date,
                                                        p_stop_date             => :p_stop_date,
                                                        p_payment_frequency     => :p_payment_frequency,
                                                        p_holiday_shift         => :p_holiday_shift,
                                                        p_provider_id           => :p_provider_id,
                                                        p_regular_amount        => :p_regular_amount,
                                                        p_receiver_mfo          => :p_receiver_mfo,
                                                        p_receiver_account      => :p_receiver_account,
                                                        p_receiver_name         => :p_receiver_name,
                                                        p_receiver_edrpou       => :p_receiver_edrpou,
                                                        p_purpose               => :p_purpose,
                                                        p_extra_attributes      => :p_extra_attributes,
                                                        p_sendsms               => :p_sendsms,
                                                        p_order_id              => :p_order_id,
                                                        p_result_code           => :p_result_code,
                                                        p_result_message        => :p_result_message
                                                        );
                                                       end;";
                cmdMakeFreeSbon.ExecuteNonQuery();

                OracleDecimal _orderId = (OracleDecimal)cmdMakeFreeSbon.Parameters["p_order_id"].Value;
                if (!_orderId.IsNull)
                    res.OrderId = _orderId.Value;
                //res.OrderId = Convert.ToDecimal(Convert.ToString(cmdMakeFreeSbon.Parameters["p_order_id"].Value));

                OracleDecimal _resultCode = (OracleDecimal)cmdMakeFreeSbon.Parameters["p_result_code"].Value;
                if (!_resultCode.IsNull)
                    res.ResultCode = Convert.ToInt16(_resultCode.Value);
                //res.ResultCode = Convert.ToInt16(Convert.ToString(cmdMakeFreeSbon.Parameters["p_result_code"].Value));

                OracleString _resultMessage = (OracleString)cmdMakeFreeSbon.Parameters["p_result_message"].Value;
                if (!_resultMessage.IsNull)
                    res.ResultMessage = _resultMessage.Value;
                //res.ResultMessage = Convert.ToString(cmdMakeFreeSbon.Parameters["p_result_message"].Value);

                if (res.ResultCode == 0) res.Doc = Convert.ToBase64String(SbonDoc(res.OrderId));
                return res;
            }
            catch (System.Exception)
            {
                throw;
            }
            finally
            {
                cmdMakeFreeSbon.Dispose();
            }
        }
        #endregion

        private static CC_DIAL GetCcDial(decimal? nd, OracleConnection connect)
        {
            using (OracleCommand command = connect.CreateCommand())
            {
                command.Parameters.Add("p_nd", OracleDbType.Decimal, nd, ParameterDirection.Input);
                command.CommandText = @"select c.ND, to_char(c.sdate, 'dd/mm/yyyy') as sdate, c.CC_ID, a.nls, a.kv, cust.OKPO, a.nms
                                          from cc_deal c, nd_acc ca, accounts a, customer cust
                                         where c.nd = :p_nd
                                           and ca.nd = c.nd
                                           and a.rnk = c.rnk
                                           and cust.rnk = c.rnk 
										   and ca.acc = a.acc
                                           and ( a.nbs in ('2620','2625') or a.tip = 'SG ')
									       and a.dazs is null and rownum = 1";
                using (var reader = command.ExecuteReader())
                {
                    CC_DIAL res = null;
                    if (reader.Read())
                    {
                        res = new CC_DIAL
                        {
                            CC_ID = Convert.ToString(reader["cc_id"]),
                            ND = Convert.ToDecimal(reader["ND"]),
                            SDATE = Convert.ToString(reader["sdate"]),
                            NLS = Convert.ToString(reader["nls"]),
                            KV = Convert.ToInt16(reader["KV"]),
                            OKPO = Convert.ToString(reader["OKPO"]),
                            NMS = Convert.ToString(reader["nms"])
                        };
                    }
                    return res;
                }
            }
        }

        public static String GetTemplateId(Decimal? Dpt_id, OracleConnection connect)
        {
            string TemplateId = String.Empty;
            if (Dpt_id != null)
            {
                using (OracleCommand cmdCommand = connect.CreateCommand())
                {
                    cmdCommand.Parameters.Add("dpt_id", OracleDbType.Decimal, Dpt_id, ParameterDirection.Input);
                    cmdCommand.CommandText = "select id_fr TemplateId from bars.DPT_VIDD_SCHEME where vidd in (select vidd from dpt_deposit where deposit_id = :dpt_id) and flags = 25";
                    using (OracleDataReader reader = cmdCommand.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                int idTemplateId = reader.GetOrdinal("TemplateId");
                                TemplateId = OracleHelper.GetString(reader, idTemplateId);
                            }
                        }
                        else
                        {
                            TemplateId = "25 ДУ не дозволено створювати для виду вкладу";
                        }
                    }
                }
            }
            else
            {
                TemplateId = "DPT_AGRMREG";
            }
            return TemplateId;
        }
        public static String GetTT(string NLSA, string idstype, OracleConnection connect)
        {
            string TT = "";
            switch (idstype)
            {
                case "dpt":
                    {
                        if (NLSA.Substring(0, 4) == "2625")
                            TT = "PK!";
                        if (NLSA.Substring(0, 4) == "2620" || NLSA.Substring(0, 3) == "263")
                            TT = "191";
                    }
                    break;
                case "cck":
                    {
                        if (NLSA.Substring(0, 4) == "2625")
                            TT = "PKO";
                        else
                            TT = "PK!";
                    }
                    break;
                default:
                    {
                        if (NLSA.Substring(0, 4) == "2625")
                            TT = "PK!";
                        if (NLSA.Substring(0, 4) == "2620" || NLSA.Substring(0, 3) == "263")
                            TT = "191";
                    }
                    break;
            }

            return TT;
        }
        public static Int16 GetIDG(string idstype, OracleConnection connect)
        {
            Int16 IDG = 0;
            switch (idstype)
            {
                case "dpt":
                    IDG = 6;
                    break;
                case "cck":
                    IDG = 12;
                    break;
                default:
                    IDG = 24;
                    break;
            }

            return IDG;
        }
        public static Decimal GetIDS(string idstype, Decimal RNK, OracleConnection connect)
        {
            Decimal IDS = -1;
            using (OracleCommand cmdMakeRegularLST = connect.CreateCommand())
            {
                try
                {
                    cmdMakeRegularLST.Parameters.Clear();
                    cmdMakeRegularLST.Parameters.Add("IDG", OracleDbType.Decimal, GetIDG(idstype, connect), ParameterDirection.Input);
                    cmdMakeRegularLST.Parameters.Add("p_IDS", OracleDbType.Decimal, IDS, ParameterDirection.Output);
                    cmdMakeRegularLST.Parameters.Add("RNK", OracleDbType.Decimal, RNK, ParameterDirection.Input);
                    cmdMakeRegularLST.Parameters.Add("NAME", OracleDbType.Varchar2, ("XRMRegular: " + GetNMK(RNK, connect)), ParameterDirection.Input);
                    cmdMakeRegularLST.Parameters.Add("SDAT", OracleDbType.Date, DateTime.Now, ParameterDirection.Input);
                    cmdMakeRegularLST.CommandText = "begin sto_all.add_RegularLST(:IDG, :p_IDS, :RNK, :NAME, :SDAT); end;";

                    cmdMakeRegularLST.ExecuteNonQuery();

                    OracleDecimal _ids = (OracleDecimal)cmdMakeRegularLST.Parameters["p_IDS"].Value;
                    if (!_ids.IsNull)
                        IDS = _ids.Value;
                    return IDS;
                }
                catch (System.Exception e)
                {
                    throw e;
                }
            }
        }
        public static String GetNMK(Decimal RNK, OracleConnection connect)
        {
            String NMK = Convert.ToString(RNK);
            using (OracleCommand cmdGetNMK = connect.CreateCommand())
            {
                try
                {
                    cmdGetNMK.Parameters.Clear();
                    cmdGetNMK.CommandText = "select nmk from customer where rnk = :p_rnk";
                    cmdGetNMK.Parameters.Add("p_rnk", OracleDbType.Decimal, RNK, ParameterDirection.Input);
                    using (OracleDataReader reader = cmdGetNMK.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                int idNMK = reader.GetOrdinal("nmk");
                                NMK = OracleHelper.GetString(reader, idNMK);
                            }
                        }
                    }
                    return NMK;
                }
                catch (System.Exception e)
                {
                    throw e;
                }
            }
        }
        public static Decimal CreateDPTAgreement(Decimal Rnk, Decimal? Dpt_id, String templateId, OracleConnection connect)
        {
            Decimal AgrId = -1;
            using (OracleCommand cmdCommand = connect.CreateCommand())
            {
                cmdCommand.Parameters.Add("p_id", OracleDbType.Decimal, Dpt_id, ParameterDirection.Input);
                cmdCommand.Parameters.Add("p_agrmnttype", OracleDbType.Decimal, 25, ParameterDirection.Input);
                cmdCommand.Parameters.Add("p_trustcustid", OracleDbType.Decimal, Rnk, ParameterDirection.Input);
                cmdCommand.Parameters.Add("p_agr_id", OracleDbType.Decimal, AgrId, ParameterDirection.Output);
                cmdCommand.Parameters.Add("p_templateid", OracleDbType.Decimal, templateId, ParameterDirection.Output);
                const string sql = @"begin dpt_web.create_agreement(
                                                :p_id,
                                                :p_agrmnttype, 
                                                :p_trustcustid,
                                                null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
                                                :p_agr_id,
                                                :p_templateid);
                                            end;";
                cmdCommand.CommandText = sql;
                cmdCommand.ExecuteNonQuery();

                OracleDecimal _argId = (OracleDecimal)cmdCommand.Parameters["p_agr_id"].Value;
                if (!_argId.IsNull)
                    AgrId = _argId.Value;
                //AgrId = Convert.ToDecimal(Convert.ToString(cmdCommand.Parameters["p_agr_id"].Value));
                return AgrId;
            }
        }
        public static void SetDetParam(Decimal? IDD, Decimal? AgrId, OracleConnection connect)
        {
            using (OracleCommand cmdCommandIns = connect.CreateCommand())
            {
                cmdCommandIns.Parameters.Add("p_id", OracleDbType.Decimal, IDD, ParameterDirection.Input);
                cmdCommandIns.Parameters.Add("p_agr_id", OracleDbType.Decimal, AgrId, ParameterDirection.Input);
                cmdCommandIns.CommandText = "insert into sto_det_agr(IDD, AGR_ID) values(:p_idd,:p_agr_id)";
                cmdCommandIns.ExecuteNonQuery();
            }
        }
        public static XRMRegPayResult CreatePayment(XRMRegPayReq XRMRegPayReq, string idstype, string templateId, OracleConnection connect)
        {
            XRMRegPayResult XRMRegPayResult = new XRMRegPayResult();
            String TT = GetTT(XRMRegPayReq.NLSA, idstype, connect);
            Decimal IDS = GetIDS(idstype, XRMRegPayReq.Rnk, connect);
            try
            {
                using (OracleCommand cmdMakeRegular = connect.CreateCommand())
                {
                    cmdMakeRegular.Parameters.Clear();
                    cmdMakeRegular.BindByName = true;

                    cmdMakeRegular.Parameters.Add("p_TransactionId", OracleDbType.Decimal, XRMRegPayReq.TransactionId, ParameterDirection.Input);
                    cmdMakeRegular.Parameters.Add("IDS", OracleDbType.Decimal, IDS, ParameterDirection.Input);
                    cmdMakeRegular.Parameters.Add("ord", OracleDbType.Decimal, null, ParameterDirection.Input);
                    cmdMakeRegular.Parameters.Add("tt", OracleDbType.Varchar2, TT, ParameterDirection.Input);
                    cmdMakeRegular.Parameters.Add("vob", OracleDbType.Decimal, 6, ParameterDirection.Input);
                    cmdMakeRegular.Parameters.Add("dk", OracleDbType.Decimal, 1, ParameterDirection.Input);
                    cmdMakeRegular.Parameters.Add("nlsa", OracleDbType.Varchar2, XRMRegPayReq.NLSA, ParameterDirection.Input);
                    cmdMakeRegular.Parameters.Add("kva", OracleDbType.Decimal, XRMRegPayReq.KV, ParameterDirection.Input);
                    cmdMakeRegular.Parameters.Add("nlsb", OracleDbType.Varchar2, XRMRegPayReq.NLSB, ParameterDirection.Input);
                    cmdMakeRegular.Parameters.Add("kvb", OracleDbType.Decimal, XRMRegPayReq.KV, ParameterDirection.Input);
                    cmdMakeRegular.Parameters.Add("mfob", OracleDbType.Varchar2, XRMRegPayReq.MFOB, ParameterDirection.Input);
                    cmdMakeRegular.Parameters.Add("polu", OracleDbType.Varchar2, XRMRegPayReq.NAMEB, ParameterDirection.Input);
                    cmdMakeRegular.Parameters.Add("nazn", OracleDbType.Varchar2, XRMRegPayReq.Purpose, ParameterDirection.Input);
                    cmdMakeRegular.Parameters.Add("fsum", OracleDbType.Varchar2, XRMRegPayReq.Sum, ParameterDirection.Input);
                    cmdMakeRegular.Parameters.Add("okpo", OracleDbType.Varchar2, XRMRegPayReq.OKPOB, ParameterDirection.Input);
                    cmdMakeRegular.Parameters.Add("DAT1", OracleDbType.Date, XRMRegPayReq.StartDate, ParameterDirection.Input);
                    cmdMakeRegular.Parameters.Add("DAT2", OracleDbType.Date, XRMRegPayReq.FinishDate, ParameterDirection.Input);
                    cmdMakeRegular.Parameters.Add("FREQ", OracleDbType.Decimal, XRMRegPayReq.Frequency, ParameterDirection.Input);
                    cmdMakeRegular.Parameters.Add("WEND", OracleDbType.Decimal, XRMRegPayReq.Holyday, ParameterDirection.Input);
                    cmdMakeRegular.Parameters.Add("DR", OracleDbType.Varchar2, "", ParameterDirection.Input);
                    cmdMakeRegular.Parameters.Add("p_idd", OracleDbType.Decimal, XRMRegPayResult.IDD, ParameterDirection.Output);
                    cmdMakeRegular.Parameters.Add("p_status", OracleDbType.Decimal, XRMRegPayResult.ResultCode, ParameterDirection.Output);
                    cmdMakeRegular.Parameters.Add("p_status_text", OracleDbType.Varchar2, 4000, XRMRegPayResult.ResultMessage, ParameterDirection.Output);

                    cmdMakeRegular.CommandText = @"begin xrm_integration_oe.CreateRegular( p_TransactionId => :p_TransactionId,
                                                    IDS => :IDS, 
                                                    ord => :ord, 
                                                    tt => :tt, 
                                                    vob => :vob, 
                                                    dk => :dk, 
                                                    nlsa => :nlsa, 
                                                    kva => :kva, 
                                                    nlsb => :nlsb, 
                                                    kvb => :kvb, 
                                                    mfob => :mfob, 
                                                    polu => :polu, 
                                                    nazn => :nazn,
                                                    fsum => :fsum, 
                                                    okpo => :okpo, 
                                                    DAT1 => :DAT1, 
                                                    DAT2 => :DAT2, 
                                                    FREQ => :FREQ, 
                                                    DAT0 => null,
                                                    WEND => :WEND, 
                                                    DR => :DR, 
                                                    branch => null,
                                                    p_nd => 1,
                                                    p_sdate => sysdate, 
                                                    p_idd => :p_idd, 
                                                    p_status => :p_status, 
                                                    p_status_text => :p_status_text); 
                                        end;";

                    using (OracleDataReader rdr = cmdMakeRegular.ExecuteReader())
                    {
                        OracleDecimal p_idd = (OracleDecimal)cmdMakeRegular.Parameters["p_idd"].Value;
                        if (!p_idd.IsNull)
                            XRMRegPayResult.IDD = p_idd.Value;

                        OracleDecimal p_status = (OracleDecimal)cmdMakeRegular.Parameters["p_status"].Value;
                        if (!p_status.IsNull)
                            XRMRegPayResult.ResultCode = Convert.ToInt16(p_status.Value);

                        OracleString _resultMessage = (OracleString)cmdMakeRegular.Parameters["p_status_text"].Value;
                        if (!_resultMessage.IsNull)
                            XRMRegPayResult.ResultMessage = _resultMessage.Value;

                        XRMRegPayResult.Doc = Convert.ToBase64String(Doc(XRMRegPayReq.Rnk, XRMRegPayResult.IDD, templateId));

                        return XRMRegPayResult;
                    }
                }
            }
            catch (System.Exception)
            {
                throw;
            }
        }
        static byte[] Doc(decimal rnk, decimal? idd, string template)
        {
            // Друк Заяви
            byte[] bytes = null;
            string outfilename = "F190";
            FrxParameters pars = new FrxParameters
                {
                    new FrxParameter("rnk", TypeCode.Int64, rnk),
                    new FrxParameter("IDD", TypeCode.String, idd)
                };
            outfilename += "_RNK" + rnk;
            outfilename += "_AGRID" + idd;

            // дополнительные параметры

            FrxDoc doc = new FrxDoc(FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(template)), pars, null);

            using (MemoryStream ms = new MemoryStream())
            {
                doc.ExportToMemoryStream(FrxExportTypes.Pdf, ms);
                bytes = ms.ToArray();
            }
            return DepositXrm.DepositXrmWorker.GetZipFile(bytes, outfilename).ToArray();
        }
        static byte[] SbonDoc(decimal orderId)
        {
            const string templateName = "STO_F190.frx";
            string outfilename = String.Format("F190_{0}", orderId);
            byte[] bytes = null;

            string templatePath = FrxDoc.GetTemplatePathByFileName(templateName);
            FrxParameters pars = new FrxParameters
                {
                    new FrxParameter("order_id", TypeCode.Decimal, orderId)
                };

            FrxDoc doc = new FrxDoc(templatePath, pars, null);
            using (MemoryStream ms = new MemoryStream())
            {
                doc.ExportToMemoryStream(FrxExportTypes.Pdf, ms);
                bytes = ms.ToArray();
            }
            return DepositXrm.DepositXrmWorker.GetZipFile(bytes, outfilename).ToArray();
        }

        public static XRMRegPayResult ProcCreateRegPay(XRMRegPayReq XRMRegPayReq, string idstype, OracleConnection connect)
        {
            String templateId = GetTemplateId(null, connect);
            XRMRegPayResult XRMRegPayResult = new XRMRegPayResult();
            try
            {
                XRMRegPayResult = CreatePayment(XRMRegPayReq, idstype, templateId, connect);
                return XRMRegPayResult;
            }
            catch
            {
                throw;
            }
        }
        public static XRMDPTRegPayResult ProcCreateDPTRegPay(XRMDPTRegPayReq XRMDPTRegPayReq, string idstype, OracleConnection connect)
        {
            XRMDPTRegPayResult XRMDPTRegPayResult = new XRMDPTRegPayResult();
            XRMDPTRegPayResult.AgrId = -1;
            String templateId = GetTemplateId(XRMDPTRegPayReq.Dpt_id, connect);
            if (templateId == "25 ДУ не дозволено створювати для виду вкладу")
            {
                XRMDPTRegPayResult.ResultCode = -1;
                XRMDPTRegPayResult.ResultMessage = templateId;
                return XRMDPTRegPayResult;
            }
            else
            {
                try
                {
                    XRMDPTRegPayResult.XRMRegPayResult = CreatePayment(XRMDPTRegPayReq.XRMRegPayReq, idstype, templateId, connect);
                    if (XRMDPTRegPayResult.XRMRegPayResult.IDD > 0)
                    {
                        // добавить печать
                        if (XRMDPTRegPayReq.Dpt_id != null)
                        {
                            XRMDPTRegPayResult.AgrId = CreateDPTAgreement(XRMDPTRegPayReq.XRMRegPayReq.Rnk, XRMDPTRegPayReq.Dpt_id, templateId, connect);
                            if (XRMDPTRegPayResult.AgrId != -1)
                            {
                                SetDetParam(XRMDPTRegPayResult.XRMRegPayResult.IDD, XRMDPTRegPayResult.AgrId, connect);
                            }
                        }
                    }
                    return XRMDPTRegPayResult;
                }
                catch (System.Exception ex)
                {
                    XRMDPTRegPayResult.ResultCode = -1;
                    XRMDPTRegPayResult.ResultMessage = ex.Message;
                    return XRMDPTRegPayResult;
                }
            }
        }
        public static XRMCCKRegPayResult ProcCreateCCKRegPay(XRMCCKRegPayReq XRMCCKRegPayReq, string idstype, OracleConnection connect)
        {
            XRMCCKRegPayResult XRMCCKRegPayResult = new XRMCCKRegPayResult();

            String templateId = GetTemplateId(null, connect);

            var ccDial = GetCcDial(XRMCCKRegPayReq.ND, connect);
            if (ccDial != null)
            {
                XRMCCKRegPayReq.XRMRegPayReq.Sum = string.Format("F_GET_SUM_CCK( '{0}', to_date('{1}','dd/mm/yyyy'))", ccDial.CC_ID, ccDial.SDATE);
                XRMCCKRegPayReq.XRMRegPayReq.Purpose = string.Format("Поповнення рахунку погашення за договором № {0} від {1}", ccDial.CC_ID, ccDial.SDATE);
                XRMCCKRegPayReq.XRMRegPayReq.OKPOB = ccDial.OKPO;
                XRMCCKRegPayReq.XRMRegPayReq.NLSB = ccDial.NLS;
                XRMCCKRegPayReq.XRMRegPayReq.KV = ccDial.KV;
                XRMCCKRegPayReq.XRMRegPayReq.MFOB = XRMCCKRegPayReq.XRMRegPayReq.KF;
                XRMCCKRegPayReq.XRMRegPayReq.NAMEB = ccDial.NMS;
                XRMCCKRegPayReq.XRMRegPayReq.Holyday = -1;
                XRMCCKRegPayReq.XRMRegPayReq.Frequency = 2; // вільний графік згідно графіку погашення кредитного договору
                try
                {
                    XRMCCKRegPayResult.XRMRegPayResult = CreatePayment(XRMCCKRegPayReq.XRMRegPayReq, idstype, templateId, connect);
                    if (XRMCCKRegPayResult.XRMRegPayResult.IDD > 0)
                    {
                        SetDetParam(XRMCCKRegPayResult.XRMRegPayResult.IDD, XRMCCKRegPayReq.ND, connect);
                    }
                    return XRMCCKRegPayResult;
                }
                catch (System.Exception ex)
                {
                    XRMCCKRegPayResult.ResultCode = -1;
                    XRMCCKRegPayResult.ResultMessage = ex.Message;
                    return XRMCCKRegPayResult;
                }
            }
            else
            {
                XRMCCKRegPayResult.ResultCode = -1;
                XRMCCKRegPayResult.ResultMessage = String.Format("Не знайдено кредитного договору з номером {0}", XRMCCKRegPayReq.ND);
                return XRMCCKRegPayResult;
            }
        }
    }
}
