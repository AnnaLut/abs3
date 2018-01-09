using System;
using System.IO;
using System.Data;
using System.Web.Services;
using System.Web.Services.Protocols;
using Oracle.DataAccess.Client;
using BarsWeb.Core.Logger;
using Oracle.DataAccess.Types;
using System.Collections.Generic;

/// <summary>
/// XRMIntegrationRegPay сервис интеграции с Единым окном (регулярные платежи)
/// </summary>
/// 
namespace Bars.WebServices
{
    #region regpay_construnct
    public class XRMRegPayments
    {   
        public class XRMRegPay
        {
            public class XRMRegPayReq
            {
                public Decimal TransactionId;   //унікальний код транзакції
                public String UserLogin;        //логін користувача АД
                public Int16 OperationType;     //тип операції сервіса (9-регулярні платежі)
                public String KF;               //код філії (МФО)
                public string Branch;           //відділення, де виконується операція
                public Int64 Rnk;               //РНК клієнта, якому створюється регулярний платіж
                public DateTime StartDate;      //дата початку дії регулярного платежу (має бути більша за наступну банківську дату)
                public DateTime FinishDate;     //дата завершення дії регулярного платежу (для депозитного ДУ має бути меньшою або дорівнювати даті закінчення депозитного договору)
                public Int16 Frequency;         //періодичність виконання - довідник FREQ
                public Int16 KV;                //валюта платежів
                public String NLSA;             //рахунок платника - має належити клієнту, рахунок, відкритий в Банку
                public String OKPOB;            //ЗКПО отримувача регулярного платежу
                public String NAMEB;            //назва отримувача регулярного платежу
                public String MFOB;             //МФО установи, де відкрито рахунок отримувача регулярного платежу
                public String NLSB;             //рахунок отримувача регулярного платежу
                public Int16 Holyday;           //врахування вихідних днів при припаданні дати платежа на вихідний день(-1 - перенести платіж на попередню банківську дату, 1 - на наступну)
                public String Sum;              //сума (формула суми) регулярного платежу
                public String Purpose;          //призначення платежу (не більше 160 сімволів, не менше 5, не має містити спеціальніх символів і не кірилічну кодировку)
            }
            public class XRMDPTRegPayReq
            {
                public XRMRegPayReq XRMRegPayReq;   //масив даних про створюваний рег.платіж
                public Decimal? Dpt_id;             //номер депозитного договору, для якого створюється регулярний платіж
            }
            public class XRMCCKRegPayReq
            {
                public XRMRegPayReq XRMRegPayReq;   //масив даних про створюваний рег.платіж
                public Decimal ND;                   //номер кредитного договору, для якого створюється регулярний платіж
            }
            public class CC_DIAL
            {
                public decimal ND { get; set; }
                public string CC_ID { get; set; }
                public string SDATE { get; set; }
                public string NLS  { get; set; }
                public Int16 KV { get; set; }
                public string OKPO { get; set; }
                public string NMS { get; set; }
            }
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
           
            public class XRMRegPayResult
            {
                public decimal? IDD;                 //ідентифікатор регулярного платежу
                public int ResultCode;              //статус створення 0-Ок, -1 помилк
                public string ResultMessage;        //опис помилки створення рег.платежу
                public byte[] Doc;

            }
            public class XRMDPTRegPayResult
            {
                public XRMRegPayResult XRMRegPayResult; //масив даних щодо операції створення рег.платежу
                public int ResultCode;                  //загальний код виконання операції 0-Ок, -1-помилка
                public string ResultMessage;            //опис помилки створення ДУ 25 по рег.платежу
                public Decimal AgrId;                   //ідентифікатор додаткової угоди до депозиту               
            }
            public class XRMCCKRegPayResult
            {
                public XRMRegPayResult XRMRegPayResult; //масив даних щодо операції створення рег.платежу
                public int ResultCode;                  //загальний код виконання операції 0-Ок, -1-помилка
                public string ResultMessage;            //опис помилки створення регулярного платежу                     
            }

            public class XRMSBONRegPay
            {
                public class SBON_ORDER
                {
                    public Decimal payer_account_id;
                    public DateTime start_date;
                    public DateTime stop_date;
                    public Int16 payment_frequency;
                    public Int16 holiday_shift;
                    public Int16 provider_id;
                    public String personal_account;
                    public Decimal regular_amount;
                    public Decimal? ceiling_amount;
                    public String extra_attributes;
                    public String sendsms;
                }
                public class SbonOrderRequest
                {
                    public Decimal TransactionId;   //унікальний код транзакції
                    public String UserLogin;        //логін користувача АД
                    public Int16 OperationType;     //тип операції сервіса (9-регулярні платежі)
                    public String KF;               //код філії (МФО)
                    public string Branch;           //відділення, де виконується операція
                    public Int16 SbonType;          //0- без контракта, 1 - с контрактом                    
                    public SBON_ORDER SbonOrderReq; //реквізити платежу СБОН 
                }
                public class SbonOrderResult
                {
                    public decimal OrderId;
                    public byte[] Doc;
                    public int ResultCode;                  //загальний код виконання операції 0-Ок, -1-помилка
                    public string ResultMessage;
                }

                public class FREE_SBON_ORDER
                {                    
                    public decimal payer_account_id;
                    public DateTime start_date;
                    public DateTime stop_date;
                    public Int16 payment_frequency;
                    public Int16 holiday_shift;
                    public Int16 provider_id;
                    public Decimal regular_amount;
                    public String receiver_mfo;
                    public String reciever_account;
                    public String reciever_name;
                    public String receiver_edrpou;
                    public String purpose;
                    public String extra_attributes;
                    public String sendsms;
                }
                public class SbonFreeOrderRequest
                {
                    public Decimal TransactionId;   //унікальний код транзакції
                    public String UserLogin;        //логін користувача АД
                    public Int16 OperationType;     //тип операції сервіса (9-регулярні платежі)
                    public String KF;               //код філії (МФО)
                    public string Branch;           //відділення, де виконується операція  
                    public FREE_SBON_ORDER SbonFreeOrderReq; //реквізити платежу СБОН 
                }
                public class SbonFreeOrderResult
                {
                    public decimal OrderId;
                    public byte[] Doc;
                    public int ResultCode;           //загальний код виконання операції 0-Ок, -1-помилка
                    public string ResultMessage;
                }

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
                        res.OrderId = Convert.ToDecimal(Convert.ToString(cmdMakeSbon.Parameters["p_order_id"].Value));
                        res.ResultCode = Convert.ToInt16(Convert.ToString(cmdMakeSbon.Parameters["p_result_code"].Value));
                        res.ResultMessage = Convert.ToString(cmdMakeSbon.Parameters["p_result_message"].Value);
                        if (res.ResultCode == 0) res.Doc = XRMRegPay.SbonDoc(res.OrderId);
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
                        res.OrderId = Convert.ToDecimal(Convert.ToString(cmdMakeFreeSbon.Parameters["p_order_id"].Value));
                        res.ResultCode = Convert.ToInt16(Convert.ToString(cmdMakeFreeSbon.Parameters["p_result_code"].Value));
                        res.ResultMessage = Convert.ToString(cmdMakeFreeSbon.Parameters["p_result_message"].Value);
                        if (res.ResultCode == 0) res.Doc = XRMRegPay.SbonDoc(res.OrderId);
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
                                    TemplateId = XRMIntegrationUtl.OracleHelper.GetString(reader, idTemplateId);
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
            public static String GetTT(string NLSA,string idstype, OracleConnection connect)
            {
                string TT = "";
                switch (idstype) {
                    case "dpt":
                        { 
                            if (NLSA.Substring(0, 4) == "2625") { TT = "PK!"; }
                            if (NLSA.Substring(0, 4) == "2620" || NLSA.Substring(0, 3) == "263") { TT = "191"; }
                        } break;
                    case "cck": {
                            if (NLSA.Substring(0, 4) == "2625") { TT = "PKO";}
                            else { TT = "PK!";}
                        } break;
                    default:
                        {
                            if (NLSA.Substring(0, 4) == "2625") { TT = "PK!"; }
                            if (NLSA.Substring(0, 4) == "2620" || NLSA.Substring(0, 3) == "263") { TT = "191"; }
                        } break;
                }
                
                return TT;
            }
            public static Int16 GetIDG(string idstype, OracleConnection connect)
            {
                Int16 IDG = 0;
                switch (idstype) {
                    case "dpt": IDG = 6; break;
                    case "cck": IDG = 12; break;
                    default: IDG = 24; break;
                }
                
                return IDG;
            }
            public static Decimal GetIDS(string idstype, Decimal RNK, OracleConnection connect)
            {
                Decimal IDS = -1;
                OracleCommand cmdMakeRegularLST = connect.CreateCommand();
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
                    IDS = Convert.ToDecimal(Convert.ToString(cmdMakeRegularLST.Parameters["p_IDS"].Value));
                    return IDS;
                }
                catch (System.Exception e)
                {
                    throw e;
                }
                finally
                {
                    cmdMakeRegularLST.Dispose();
                }
            }
            public static String GetNMK(Decimal RNK, OracleConnection connect)
            {
                String NMK = Convert.ToString(RNK);
                OracleCommand cmdGetNMK = connect.CreateCommand();
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
                                NMK = XRMIntegrationUtl.OracleHelper.GetString(reader, idNMK);
                            }
                        }
                    }
                    return NMK;
                }
                catch (System.Exception e)
                {
                    throw e;
                }
                finally
                {
                    cmdGetNMK.Dispose();
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
                    AgrId = Convert.ToDecimal(Convert.ToString(cmdCommand.Parameters["p_agr_id"].Value));
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

                        OracleDataReader rdr = cmdMakeRegular.ExecuteReader();

                        object p_idd = cmdMakeRegular.Parameters["p_idd"].Value;
                        if (!((OracleDecimal)p_idd).IsNull)
                            XRMRegPayResult.IDD = Convert.ToDecimal(Convert.ToString(cmdMakeRegular.Parameters["p_idd"].Value));
                        object p_status = cmdMakeRegular.Parameters["p_status"].Value;
                        if (!((OracleDecimal)p_status).IsNull)
                            XRMRegPayResult.ResultCode = Convert.ToInt16(Convert.ToString(cmdMakeRegular.Parameters["p_status"].Value));
                        XRMRegPayResult.ResultMessage = Convert.ToString(cmdMakeRegular.Parameters["p_status_text"].Value);
                        XRMRegPayResult.Doc = XRMRegPay.Doc(XRMRegPayReq.Rnk, XRMRegPayResult.IDD, templateId);

                        return XRMRegPayResult;
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
                return XRMDeposits.XRMDepositFiles.GetZipFile(bytes, outfilename).ToArray();
            }
            static byte[] SbonDoc(decimal orderId)
            {
                const string templateName = "STO_F190.frx";
                string outfilename = String.Format("F190_{0}",orderId);
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
                return XRMDeposits.XRMDepositFiles.GetZipFile(bytes, outfilename).ToArray();
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
                    catch
                    {
                        throw;
                    }
                }
            }
            public static XRMCCKRegPayResult ProcCreateCCKRegPay(XRMCCKRegPayReq XRMCCKRegPayReq, string idstype, OracleConnection connect)
            {
                XRMCCKRegPayResult XRMCCKRegPayResult = new XRMCCKRegPayResult();

                String templateId = GetTemplateId(null, connect);

                var ccDial = XRMRegPay.GetCcDial(XRMCCKRegPayReq.ND, connect);
                if (ccDial != null) {
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
                    catch (System.Exception e)
                    {
                        throw;
                    }
                }
                else {
                    XRMCCKRegPayResult.ResultCode = -1;
                    XRMCCKRegPayResult.ResultMessage = String.Format("Не знайдено кредитного договору з номером {0}", XRMCCKRegPayReq.ND);
                    return XRMCCKRegPayResult;
                }
            }
        }
    }
    #endregion regpay_construnct    
    /// <summary>
    /// Веб-сервіс для взаємодії з системою XRM Єдине вікно
    /// </summary>
    [WebService(Namespace = "http://ws.unity-bars-regular.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class XRMIntegrationRegPay : BarsWebService
    {
        public WsHeader WsHeaderValue;
        private IDbLogger _dbLogger;
 
        #region create_regpay_method
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public List<XRMRegPayments.XRMRegPay.XRMRegPayResult> CreateRegPayMethod(XRMRegPayments.XRMRegPay.XRMRegPayReq[] XRMRegPay)
        {
            using (XRMIntegrationUtl XRMUtl = new XRMIntegrationUtl())
            {
                XRMIntegrationUtl.TransactionInfo Trans = new XRMIntegrationUtl.TransactionInfo();
                decimal TransSuccess = 0;
                List<XRMRegPayments.XRMRegPay.XRMRegPayResult> resList = new List<XRMRegPayments.XRMRegPay.XRMRegPayResult>();
                try
                {
                    XRMUtl.LoginADUserInt(XRMRegPay[0].UserLogin);
                    try
                    {
                        using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                        {
                            foreach (XRMRegPayments.XRMRegPay.XRMRegPayReq RegPayReq in XRMRegPay)
                            {
                                XRMRegPayments.XRMRegPay.XRMRegPayResult RegPayRes = new XRMRegPayments.XRMRegPay.XRMRegPayResult();
                                Trans.TransactionId = RegPayReq.TransactionId;
                                Trans.UserLogin = RegPayReq.UserLogin;
                                Trans.OperationType = RegPayReq.OperationType;
                                TransSuccess = XRMIntegrationUtl.TransactionCheck(Trans, con);
                                if (TransSuccess == 0)
                                {
                                    XRMIntegrationUtl.TransactionCreate(Trans, con);
                                    RegPayRes = XRMRegPayments.XRMRegPay.ProcCreateRegPay(RegPayReq, null, con);
                                    resList.Add(RegPayRes);
                                }
                                else if (TransSuccess == -1)
                                {
                                    RegPayRes.ResultCode = -1;
                                    RegPayRes.IDD = -1;
                                    RegPayRes.ResultMessage = String.Format("TransactionID {0} вже була проведена", RegPayReq.TransactionId);
                                    resList.Add(RegPayRes);
                                }
                                else
                                {
                                    RegPayRes.ResultCode = -1;
                                    RegPayRes.IDD = -1;
                                    RegPayRes.ResultMessage = String.Format("Ошибка получения транзакции из БД", RegPayReq.TransactionId);
                                    resList.Add(RegPayRes);
                                }

                            }
                        }
                        return resList;
                    }
                    catch (System.Exception ex)
                    {
                        Int32 resultCode = -1;
                        Decimal? iDD = -1;
                        String resultMessage = ex.Message;
                        resList.Add(new XRMRegPayments.XRMRegPay.XRMRegPayResult { ResultCode = resultCode, IDD = iDD, ResultMessage = resultMessage });
                        return resList;
                    }
                }
                catch (Exception.AutenticationException aex)
                {
                    String resultMessage = String.Format("Помилка авторизації: {0}", aex.Message);
                    Int32 resultCode = -1;
                    Decimal? iDD = -1;
                    resList.Add(new XRMRegPayments.XRMRegPay.XRMRegPayResult { ResultCode = resultCode, IDD = iDD, ResultMessage = resultMessage });
                    return resList;
                }
            }
        }
        #endregion create_regpay_method
        #region create_dpt_regpay_method
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public List<XRMRegPayments.XRMRegPay.XRMDPTRegPayResult> CreateDPTRegPayMethod(XRMRegPayments.XRMRegPay.XRMDPTRegPayReq[] XRMDPTRegPay)
        {
            using (XRMIntegrationUtl XRMUtl = new XRMIntegrationUtl())
            {
                XRMIntegrationUtl.TransactionInfo Trans = new XRMIntegrationUtl.TransactionInfo();
                decimal TransSuccess = 0;
                List<XRMRegPayments.XRMRegPay.XRMDPTRegPayResult> resList = new List<XRMRegPayments.XRMRegPay.XRMDPTRegPayResult>();
                try
                {
                    XRMUtl.LoginADUserInt(XRMDPTRegPay[0].XRMRegPayReq.UserLogin);
                    try
                    {
                        using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                        {
                            foreach (XRMRegPayments.XRMRegPay.XRMDPTRegPayReq RegDPTPayReq in XRMDPTRegPay)
                            {
                                XRMRegPayments.XRMRegPay.XRMDPTRegPayResult RegDPTPayRes = new XRMRegPayments.XRMRegPay.XRMDPTRegPayResult();
                                RegDPTPayRes.XRMRegPayResult = new XRMRegPayments.XRMRegPay.XRMRegPayResult();
                                Trans.TransactionId = RegDPTPayReq.XRMRegPayReq.TransactionId;
                                Trans.UserLogin = RegDPTPayReq.XRMRegPayReq.UserLogin;
                                Trans.OperationType = RegDPTPayReq.XRMRegPayReq.OperationType;
                                TransSuccess = XRMIntegrationUtl.TransactionCheck(Trans, con);
                                if (TransSuccess == 0)
                                {
                                    XRMIntegrationUtl.TransactionCreate(Trans, con);
                                    RegDPTPayRes = XRMRegPayments.XRMRegPay.ProcCreateDPTRegPay(RegDPTPayReq, "dpt", con);
                                    resList.Add(RegDPTPayRes);
                                }
                                else if (TransSuccess == -1)
                                {
                                    RegDPTPayRes.XRMRegPayResult.ResultCode = -1;
                                    RegDPTPayRes.XRMRegPayResult.IDD = -1;
                                    RegDPTPayRes.XRMRegPayResult.ResultMessage = String.Format("TransactionID {0} вже була проведена", RegDPTPayReq.XRMRegPayReq.TransactionId);
                                    resList.Add(RegDPTPayRes);
                                }
                                else
                                {
                                    RegDPTPayRes.XRMRegPayResult.ResultCode = -1;
                                    RegDPTPayRes.XRMRegPayResult.IDD = -1;
                                    RegDPTPayRes.XRMRegPayResult.ResultMessage = String.Format("Ошибка получения транзакции из БД", RegDPTPayReq.XRMRegPayReq.TransactionId);
                                    resList.Add(RegDPTPayRes);
                                }
                            }
                        }
                        return resList;
                    }
                    catch (System.Exception ex)
                    {
                        XRMRegPayments.XRMRegPay.XRMDPTRegPayResult temp = new XRMRegPayments.XRMRegPay.XRMDPTRegPayResult();
                        temp.XRMRegPayResult = new XRMRegPayments.XRMRegPay.XRMRegPayResult();
                        temp.XRMRegPayResult.ResultCode = -1;
                        temp.XRMRegPayResult.ResultMessage = ex.Message;
                        temp.XRMRegPayResult.IDD = -1;
                        resList.Add(temp);
                        return resList;
                    }
                }
                catch (Exception.AutenticationException aex)
                {
                    XRMRegPayments.XRMRegPay.XRMDPTRegPayResult temp = new XRMRegPayments.XRMRegPay.XRMDPTRegPayResult();
                    temp.XRMRegPayResult = new XRMRegPayments.XRMRegPay.XRMRegPayResult();
                    temp.XRMRegPayResult.ResultMessage = String.Format("Помилка авторизації: {0}", aex.Message);
                    temp.XRMRegPayResult.ResultCode = -1;
                    temp.XRMRegPayResult.IDD = -1;
                    resList.Add(temp);
                    return resList;
                }
            }
        }
        #endregion create_dpt_regpay_method
        #region create_cck_regpay_method
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMRegPayments.XRMRegPay.XRMCCKRegPayResult CreateCCKRegPayMethod(XRMRegPayments.XRMRegPay.XRMCCKRegPayReq XRMCCKRegPay)
        {
            using (XRMIntegrationUtl XRMUtl = new XRMIntegrationUtl())
            {
                XRMIntegrationUtl.TransactionInfo Trans = new XRMIntegrationUtl.TransactionInfo();
                decimal TransSuccess = 0;
                XRMRegPayments.XRMRegPay.XRMCCKRegPayResult RegCCKPayRes = new XRMRegPayments.XRMRegPay.XRMCCKRegPayResult();
                RegCCKPayRes.XRMRegPayResult = new XRMRegPayments.XRMRegPay.XRMRegPayResult();
                try
                {
                    XRMUtl.LoginADUserInt(XRMCCKRegPay.XRMRegPayReq.UserLogin);
                    try
                    {
                        using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                        {

                            Trans.TransactionId = XRMCCKRegPay.XRMRegPayReq.TransactionId;
                            Trans.UserLogin = XRMCCKRegPay.XRMRegPayReq.UserLogin;
                            Trans.OperationType = XRMCCKRegPay.XRMRegPayReq.OperationType;
                            TransSuccess = XRMIntegrationUtl.TransactionCheck(Trans, con);
                            if (TransSuccess == 0)
                            {
                                XRMIntegrationUtl.TransactionCreate(Trans, con);
                                RegCCKPayRes = XRMRegPayments.XRMRegPay.ProcCreateCCKRegPay(XRMCCKRegPay, "cck", con);
                            }
                            else if (TransSuccess == -1)
                            {
                                RegCCKPayRes.XRMRegPayResult.ResultCode = -1;
                                RegCCKPayRes.XRMRegPayResult.IDD = -1;
                                RegCCKPayRes.XRMRegPayResult.ResultMessage = String.Format("TransactionID {0} вже була проведена", XRMCCKRegPay.XRMRegPayReq.TransactionId);
                            }
                            else
                            {
                                RegCCKPayRes.XRMRegPayResult.ResultCode = -1;
                                RegCCKPayRes.XRMRegPayResult.IDD = -1;
                                RegCCKPayRes.XRMRegPayResult.ResultMessage = String.Format("Ошибка получения транзакции из БД", XRMCCKRegPay.XRMRegPayReq.TransactionId);
                            }
                        }

                        return RegCCKPayRes;
                    }
                    catch (System.Exception ex)
                    {
                        RegCCKPayRes.XRMRegPayResult.ResultCode = -1;
                        RegCCKPayRes.XRMRegPayResult.IDD = -1;
                        RegCCKPayRes.XRMRegPayResult.ResultMessage = ex.Message;
                        return RegCCKPayRes;
                    }
                }
                catch (Exception.AutenticationException aex)
                {
                    RegCCKPayRes.XRMRegPayResult.ResultMessage = String.Format("Помилка авторизації: {0}", aex.Message);
                    RegCCKPayRes.XRMRegPayResult.ResultCode = -1;
                    RegCCKPayRes.XRMRegPayResult.IDD = -1;
                    return RegCCKPayRes;
                }
                finally { DisposeOraConnection(); }
            }
        }
        #endregion create_cck_regpay_method
        #region create_sbon_method
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMRegPayments.XRMRegPay.XRMSBONRegPay.SbonOrderResult CreateSbonPayMethod(XRMRegPayments.XRMRegPay.XRMSBONRegPay.SbonOrderRequest XRMSBONReq)
        {
            using (XRMIntegrationUtl XRMUtl = new XRMIntegrationUtl())
            {
                XRMIntegrationUtl.TransactionInfo Trans = new XRMIntegrationUtl.TransactionInfo();
                decimal TransSuccess = 0;
                XRMRegPayments.XRMRegPay.XRMSBONRegPay.SbonOrderResult SBONRes = new XRMRegPayments.XRMRegPay.XRMSBONRegPay.SbonOrderResult();
                try
                {
                    XRMUtl.LoginADUserInt(XRMSBONReq.UserLogin);
                    using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                    {
                        Trans.TransactionId = XRMSBONReq.TransactionId;
                        Trans.UserLogin = XRMSBONReq.UserLogin;
                        Trans.OperationType = XRMSBONReq.OperationType;
                        TransSuccess = XRMIntegrationUtl.TransactionCheck(Trans, con);
                        if (TransSuccess == 0)
                        {
                            XRMIntegrationUtl.TransactionCreate(Trans, con);
                            SBONRes = XRMRegPayments.XRMRegPay.XRMSBONRegPay.ProcCreateSBON(XRMSBONReq, con);
                        }
                        else if (TransSuccess == -1)
                        {
                            SBONRes.ResultCode = -1;
                            SBONRes.OrderId = -1;
                            SBONRes.ResultMessage = String.Format("TransactionID {0} вже була проведена", XRMSBONReq.TransactionId);
                        }
                        else
                        {
                            SBONRes.ResultCode = -1;
                            SBONRes.OrderId = -1;
                            SBONRes.ResultMessage = String.Format("Ошибка получения транзакции из БД", XRMSBONReq.TransactionId);
                        }
                    }
                    return SBONRes;
                }
                catch (System.Exception ex)
                {
                    SBONRes.ResultCode = -1;
                    SBONRes.OrderId = -1;
                    SBONRes.ResultMessage = ex.Message;

                    return SBONRes;
                }
            }
        }
        #endregion create_sbon_method
        #region create_free_sbon_method
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMRegPayments.XRMRegPay.XRMSBONRegPay.SbonFreeOrderResult CreateFreeSbonPayMethod(XRMRegPayments.XRMRegPay.XRMSBONRegPay.SbonFreeOrderRequest XRMFreeSBONReq)
        {
            using (XRMIntegrationUtl XRMUtl = new XRMIntegrationUtl())
            {
                XRMIntegrationUtl.TransactionInfo Trans = new XRMIntegrationUtl.TransactionInfo();
                decimal TransSuccess = 0;
                XRMRegPayments.XRMRegPay.XRMSBONRegPay.SbonFreeOrderResult SBONFreeRes = new XRMRegPayments.XRMRegPay.XRMSBONRegPay.SbonFreeOrderResult();
                try
                {
                    XRMUtl.LoginADUserInt(XRMFreeSBONReq.UserLogin);
                    using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                    {
                        Trans.TransactionId = XRMFreeSBONReq.TransactionId;
                        Trans.UserLogin = XRMFreeSBONReq.UserLogin;
                        Trans.OperationType = XRMFreeSBONReq.OperationType;
                        TransSuccess = XRMIntegrationUtl.TransactionCheck(Trans, con);
                        if (TransSuccess == 0)
                        {
                            XRMIntegrationUtl.TransactionCreate(Trans, con);
                            SBONFreeRes = XRMRegPayments.XRMRegPay.XRMSBONRegPay.ProcCreateFreeSBON(XRMFreeSBONReq, con);
                        }
                        else if (TransSuccess == -1)
                        {
                            SBONFreeRes.ResultCode = -1;
                            SBONFreeRes.OrderId = -1;
                            SBONFreeRes.ResultMessage = String.Format("TransactionID {0} вже була проведена", XRMFreeSBONReq.TransactionId);
                        }
                        else
                        {
                            SBONFreeRes.ResultCode = -1;
                            SBONFreeRes.OrderId = -1;
                            SBONFreeRes.ResultMessage = String.Format("Ошибка получения транзакции из БД", XRMFreeSBONReq.TransactionId);

                        }
                    }
                    return SBONFreeRes;
                }
                catch (System.Exception ex)
                {
                    SBONFreeRes.ResultCode = -1;
                    SBONFreeRes.OrderId = -1;
                    SBONFreeRes.ResultMessage = ex.Message;

                    return SBONFreeRes;
                }
            }
        }
        #endregion create_free_sbon_method
    }
}
 
