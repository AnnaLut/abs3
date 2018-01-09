using System;
using System.IO;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Collections.Generic;
using System.Globalization;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using barsroot.core;
using BarsWeb.Core.Logger;
using Bars.Classes;
using Bars.Application;
using Bars.Requests;
using System.Xml;
using ICSharpCode.SharpZipLib.Zip;
using ICSharpCode.SharpZipLib.Core;
using System.Web.UI;
using Bars.EAD;
using ibank.core;
/*using DsLib;
using DsLib.Algorithms;*/

/// <summary>
/// XRMIntegrationDeposit сервис интеграции с Единым окном (открытие картсчета и депозитного договора + текущего счета в депозитной системе)
/// v 1.4
/// </summary>
/// 
namespace Bars.WebServices
{

    #region deposits
    public class XRMDeposits
    {
        #region DepositAgreement
        public class XRMDepositAgreement
        {
            public class XRMDepositAgreementAccount
            {
                public String nls;
                public String mfo;
                public String okpo;
                public String nmk;
            }
            public class XRMDepositAgreementTrusteeOpt
            {
                public Int16? flag1;
                public Int16? flag2;
                public Int16? flag3;
                public Int16? flag4;
                public Int16? flag5;
                public Int16? flag6;
                public Int16? flag7;
                public Int16? flag8;
            }
            public class XRMDepositAgreementReq
            {
                public Decimal TransactionId;
                public String UserLogin;
                public Int16 OperationType;
                public String KF;
                public String Branch;
                public Decimal DptId;
                public Int16 AgreementType;
                public Decimal InitCustid;                              // РНК инициатора ДС
                public Decimal TrustCustid;                             // РНК 3-ї ососби                
                public Decimal Trustid;                                 // ДУ 3й особи
                public XRMDepositAgreementAccount TransferDPT;          // параметры возврата депозита
                public XRMDepositAgreementAccount TransferINT;          // параметры выплаты процентов
                public Decimal? Amountcash;                             // сума готівкою (ДУ про зміну суми договору)
                public Decimal? Amountcashless;                         // сума безготівкою(ДУ про зміну суми договору)
                public DateTime? DateBegin;
                public DateTime? DateEnd;
                public Decimal? RateReqId;
                public Decimal? RateValue;
                public DateTime? RateDate;
                public Decimal? DenomAmount;
                public String Denomcount;
                public XRMDepositAgreementTrusteeOpt DATrusteeOpt;      // опции при заключении доверенности на депозит 
                public Decimal? DenomRef;
                public Decimal? ComissRef;
                public Decimal? DocRef;                                 // реф.документу поповнення / частк.зняття (ДУ про зміну суми договору)
                public Decimal? ComissReqId;                            // идентификатор запроса на отмену комисии
                public String TemplateId;                               // ІД шаблону ДУ
                public Int16? freq;                                     // нова періодичність виплати відсотків
                public String Access_others;                            // поле інше в шаблоні доступу додугод
            }
            public class XRMDepositAgreementResult
            {
                public Decimal? AgrementId;
                public decimal Status;
                public string ErrMessage;
            }
            #region DepositAgreement_AccountsChange
            public XRMDepositAgreementAccount TransferDPT;          // параметры возврата депозита
            public XRMDepositAgreementAccount TransferINT;          // параметры выплаты процентов       

            private XmlDocument _p_doc;
            public XmlDocument p_doc
            {
                get
                {
                    if (_p_doc == null)
                    {
                        _p_doc = CreateXmlDoc(TransferDPT.nls, TransferDPT.mfo, TransferDPT.okpo, TransferDPT.nmk, null);
                    }
                    return _p_doc;
                }
                set
                {
                    _p_doc = value;
                }
            }

            private XmlDocument _d_doc;
            public XmlDocument d_doc
            {
                get
                {
                    if (_d_doc == null)
                    {
                        _d_doc = CreateXmlDoc(TransferINT.nls, TransferINT.mfo, TransferINT.okpo, TransferINT.nmk, null);
                    }
                    return _d_doc;
                }
                set
                {
                    _d_doc = value;
                }
            }

            /// Формування XML із реквізитами отримувача відсотків / депозиту            
            /// <param name="NLS">№ рахунка отримувача</param>
            /// <param name="MFO">МФО банку отримувача</param>
            /// <param name="OKPO">ОКПО отримувача</param>
            /// <param name="NMK">Назва отримувача</param>
            /// <param name="CardN">№ БПК отримувача</param>            
            public static XmlDocument CreateXmlDoc(String NLS, String MFO, String OKPO, String NMK, String CardN)
            {
                XmlDocument res;
                res = new XmlDocument();
                XmlNode p_root = res.CreateElement("doc");
                res.AppendChild(p_root);

                XmlNode a_p_nls = res.CreateElement("nls");
                a_p_nls.InnerText = NLS;
                p_root.AppendChild(a_p_nls);

                XmlNode a_p_mfo = res.CreateElement("mfo");
                a_p_mfo.InnerText = MFO;
                p_root.AppendChild(a_p_mfo);

                XmlNode a_p_okpo = res.CreateElement("okpo");
                a_p_okpo.InnerText = OKPO;
                p_root.AppendChild(a_p_okpo);

                XmlNode a_p_nmk = res.CreateElement("nmk");
                a_p_nmk.InnerText = NMK;
                p_root.AppendChild(a_p_nmk);

                if (!String.IsNullOrEmpty(CardN))
                {
                    XmlNode a_p_cardn = res.CreateElement("cardn");
                    a_p_cardn.InnerText = CardN;
                    p_root.AppendChild(a_p_cardn);
                }
                return res;
            }
            #endregion DepositAgreement_AccountsChange

            private static Boolean CkConditionIRREVOCABLE(Decimal DptID, Int32 AgrTypeID, OracleConnection con)
            {
                Boolean res = false;

                using (OracleCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = @"select dpt_irrevocable(:p_dpt_id) from dual";
                    cmd.Parameters.Add("p_dpt_id", OracleDbType.Decimal, DptID, ParameterDirection.Input);

                    OracleDataReader rdr = cmd.ExecuteReader();
                    try
                    {
                        if (rdr.Read())
                        {
                            if (rdr.GetOracleDecimal(0).Value == 1)
                            {
                                res = false;
                            }
                            else
                            {
                                res = true;
                            }
                        }
                    }
                    finally
                    {
                        rdr.Close();
                        rdr.Dispose();
                    }
                }
                return res;
            }
            public static XRMDepositAgreementResult ProcDepositAgreement(XRMDepositAgreementReq DepositAgrmnt, OracleConnection con)
            {
                XRMDepositAgreementResult ODepositAgrRes = new XRMDepositAgreementResult();

                ODepositAgrRes.Status = 0;
                ODepositAgrRes.ErrMessage = String.Empty;

                OracleCommand cmd = con.CreateCommand();
                try
                {
                    string TransferDPT = "";
                    string TransferINT = "";
                    if (Deposit.InheritedDeal(Convert.ToString(DepositAgrmnt.DptId)))
                    {
                        ODepositAgrRes.Status = -1;
                        ODepositAgrRes.ErrMessage = "По депозитному договору є зареєстровані спадкоємці. Дана функція заблокована.";
                    }
                    else
                    {
                        if (DepositAgrmnt.DATrusteeOpt != null && DepositAgrmnt.AgreementType == 12)
                        {
                            DepositAgrmnt.Denomcount = Convert.ToString((DepositAgrmnt.DATrusteeOpt.flag1 == null) ? 0 : DepositAgrmnt.DATrusteeOpt.flag1)
                                                    + Convert.ToString((DepositAgrmnt.DATrusteeOpt.flag2 == null) ? 0 : DepositAgrmnt.DATrusteeOpt.flag2)
                                                    + Convert.ToString((DepositAgrmnt.DATrusteeOpt.flag3 == null) ? 0 : DepositAgrmnt.DATrusteeOpt.flag3)
                                                    + Convert.ToString((DepositAgrmnt.DATrusteeOpt.flag4 == null) ? 0 : DepositAgrmnt.DATrusteeOpt.flag4)
                                                    + Convert.ToString((DepositAgrmnt.DATrusteeOpt.flag5 == null) ? 0 : DepositAgrmnt.DATrusteeOpt.flag5)
                                                    + Convert.ToString((DepositAgrmnt.DATrusteeOpt.flag6 == null) ? 0 : DepositAgrmnt.DATrusteeOpt.flag6)
                                                    + Convert.ToString((DepositAgrmnt.DATrusteeOpt.flag7 == null) ? 0 : DepositAgrmnt.DATrusteeOpt.flag7)
                                                    + Convert.ToString((DepositAgrmnt.DATrusteeOpt.flag8 == null) ? 0 : DepositAgrmnt.DATrusteeOpt.flag8);
                        }
                        else { DepositAgrmnt.Denomcount = "11111111"; }
                        if (DepositAgrmnt.AgreementType == 11 || DepositAgrmnt.AgreementType == 20 || DepositAgrmnt.AgreementType == 28)
                        {
                            if (DepositAgrmnt.TransferDPT != null) // реквізити для виплати депозиту                        {
                            {
                                XmlDocument d_doc = XRMDepositAgreement.CreateXmlDoc(DepositAgrmnt.TransferDPT.nls, DepositAgrmnt.TransferDPT.mfo, DepositAgrmnt.TransferDPT.okpo, DepositAgrmnt.TransferDPT.nmk, null);
                                TransferDPT = d_doc.InnerXml;
                            }

                            if (DepositAgrmnt.TransferINT != null) // реквізити для виплати відсотків
                            {
                                XmlDocument p_doc = CreateXmlDoc(DepositAgrmnt.TransferINT.nls, DepositAgrmnt.TransferINT.mfo, DepositAgrmnt.TransferINT.okpo, DepositAgrmnt.TransferINT.nmk, null);
                                TransferINT = p_doc.InnerXml;
                            }
                        }

                        cmd.BindByName = true;
                        cmd.Parameters.Clear();
                        cmd.CommandText = "bars.xrm_integration_oe.CreateDepositAgreement";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("p_TransactionID", OracleDbType.Decimal, DepositAgrmnt.TransactionId, ParameterDirection.Input);
                        cmd.Parameters.Add("P_DPTID", OracleDbType.Decimal, DepositAgrmnt.DptId, ParameterDirection.Input);
                        cmd.Parameters.Add("P_AGRMNTTYPE", OracleDbType.Decimal, DepositAgrmnt.AgreementType, ParameterDirection.Input);
                        cmd.Parameters.Add("P_INITCUSTID", OracleDbType.Decimal, DepositAgrmnt.InitCustid, ParameterDirection.Input);
                        cmd.Parameters.Add("P_TRUSTCUSTID", OracleDbType.Decimal, DepositAgrmnt.TrustCustid, ParameterDirection.Input);
                        cmd.Parameters.Add("p_trustid", OracleDbType.Decimal, DepositAgrmnt.Trustid, ParameterDirection.Input);

                        cmd.Parameters.Add("P_DENOMCOUNT", OracleDbType.Varchar2, 20, DepositAgrmnt.Denomcount, ParameterDirection.Input);
                        cmd.Parameters.Add("p_transferdpt", OracleDbType.Clob, 400, TransferDPT, ParameterDirection.Input);
                        cmd.Parameters.Add("p_transferint", OracleDbType.Clob, 400, TransferINT, ParameterDirection.Input);
                        cmd.Parameters.Add("p_datbegin", OracleDbType.Date, XRMIntegrationUtl.GmtToLocal(DepositAgrmnt.DateBegin), ParameterDirection.Input);
                        cmd.Parameters.Add("p_datend", OracleDbType.Date, XRMIntegrationUtl.GmtToLocal(DepositAgrmnt.DateEnd), ParameterDirection.Input);

                        // ***
                        cmd.Parameters.Add("p_amountcash", OracleDbType.Decimal, DepositAgrmnt.Amountcash, ParameterDirection.Input);
                        cmd.Parameters.Add("p_amountcashless", OracleDbType.Decimal, DepositAgrmnt.Amountcashless, ParameterDirection.Input);
                        cmd.Parameters.Add("p_ratereqid", OracleDbType.Decimal, DepositAgrmnt.RateReqId, ParameterDirection.Input);
                        cmd.Parameters.Add("p_ratevalue", OracleDbType.Decimal, DepositAgrmnt.RateValue, ParameterDirection.Input);
                        cmd.Parameters.Add("p_ratedate", OracleDbType.Date, XRMIntegrationUtl.GmtToLocal(DepositAgrmnt.RateDate), ParameterDirection.Input);
                        cmd.Parameters.Add("p_denomamount", OracleDbType.Decimal, DepositAgrmnt.DenomAmount, ParameterDirection.Input);
                        cmd.Parameters.Add("p_denomref", OracleDbType.Decimal, DepositAgrmnt.DenomRef, ParameterDirection.Input);
                        cmd.Parameters.Add("p_docref", OracleDbType.Decimal, DepositAgrmnt.DocRef, ParameterDirection.Input);
                        cmd.Parameters.Add("p_freq", OracleDbType.Decimal, DepositAgrmnt.freq, ParameterDirection.Input);

                        cmd.Parameters.Add("p_comissref", OracleDbType.Decimal, DepositAgrmnt.ComissRef, ParameterDirection.Input);
                        cmd.Parameters.Add("p_comissreqid", OracleDbType.Decimal, DepositAgrmnt.ComissReqId, ParameterDirection.Input);
                        cmd.Parameters.Add("P_AGRMNTID", OracleDbType.Decimal, ODepositAgrRes.AgrementId, ParameterDirection.Output);
                        cmd.Parameters.Add("p_ERRORMESSAGE", OracleDbType.Varchar2, 4000, ODepositAgrRes.ErrMessage, ParameterDirection.Output);
                        cmd.ExecuteNonQuery();

                        object ressign = cmd.Parameters["p_ERRORMESSAGE"].Value;
                        ODepositAgrRes.ErrMessage = (ressign == null || ((OracleString)ressign).IsNull) ? "" : ((OracleString)ressign).Value;
                        object resarchdoc = cmd.Parameters["P_AGRMNTID"].Value;
                        ODepositAgrRes.AgrementId = (resarchdoc == null || ((OracleDecimal)resarchdoc).IsNull) ? -1 : ((OracleDecimal)resarchdoc).Value;
                        if (ODepositAgrRes.AgrementId == -1) { ODepositAgrRes.Status = -1; }
                        return ODepositAgrRes;
                    }
                }
                catch (System.Exception e)
                {
                    ODepositAgrRes.Status = -1;
                    ODepositAgrRes.ErrMessage = String.Format("Помилка створення додаткової угоди депозитного договору: {0}", e.Message + e.StackTrace);
                }
                finally
                {
                    cmd.Dispose();
                }
                return ODepositAgrRes;
            }


            #region  DepositAdditionAgreementDoc
            public class XRMDepositAdditionalAgreementReq
            {
                public Decimal TransactionId;
                public String UserLogin;
                public Int16 OperationType;
                public String KF;
                public Decimal? Rnk;
                public Int16 TypeId;
                public Int32? DptId;
                public Int32? AgrId;
            }

            public class XRMDepositAdditionalAgreementRes
            {
                public byte[] Doc;
                public int ResultCode;
                public string ResultMessage;
            }

            public static byte[] GetDepositAdditionalAgreement(XRMDepositAdditionalAgreementReq request)
            {
                EadPack ep = new EadPack(new BbConnection());
                List<FrxParameter> frx_additional_params = new List<FrxParameter>();
                frx_additional_params.Add(new FrxParameter("p_agrmnt_id", TypeCode.Int64, request.AgrId));
                decimal? _DocId = null;
                int EAStructID = -1;
                string TemplateID = "";
                byte[] bytes = null;
                string outfilename = "";
                switch (request.TypeId)
                {
                    case 1: // основной договор
                        EAStructID = 212;
                        TemplateID = getDocTemplate(request.TypeId, request.DptId);
                        break;
                    case 101: // осн.дог на бенеф
                        EAStructID = 212;
                        TemplateID = getDocTemplate(request.TypeId, request.DptId);
                        break;
                    case 99: // тут анкета финмониторинга
                        EAStructID = 212;
                        TemplateID = getDocTemplate(request.TypeId, request.DptId);
                        break;
                    // тут будут все додугоды
                    case 7:
                        EAStructID = 222;
                        TemplateID = getDocTemplate(request.TypeId, request.DptId);
                        break;
                    case 8:
                        EAStructID = 223;
                        TemplateID = getDocTemplate(request.TypeId, request.DptId);
                        break;
                    case 9:
                        EAStructID = 226;
                        TemplateID = getDocTemplate(request.TypeId, request.DptId);
                        break;
                    case 12:
                        EAStructID = 222;
                        TemplateID = getDocTemplate(request.TypeId, request.DptId);
                        break;
                    case 13:
                        EAStructID = 225;
                        TemplateID = getDocTemplate(request.TypeId, request.DptId);
                        break;
                    case 18:
                        EAStructID = 211;
                        TemplateID = getDocTemplate(request.TypeId, request.DptId);
                        break;
                    default:
                        EAStructID = 213;
                        TemplateID = getDocTemplate(request.TypeId, request.DptId);
                        break;
                }

                if (EAStructID != -1)
                    _DocId = ep.DOC_CREATE("DOC", TemplateID, null, EAStructID, request.Rnk, request.DptId);


                outfilename = TemplateID;
                // печатаем документ
                FrxParameters pars = new FrxParameters();
                if (_DocId != null)
                {
                    pars.Add(new FrxParameter("p_doc_id", TypeCode.Int64, Convert.ToInt64(_DocId.Value.ToString())));
                }

                if (request.Rnk != null)
                {
                    pars.Add(new FrxParameter("p_rnk", TypeCode.Int64, request.Rnk));
                    outfilename += "_RNK" + request.Rnk;
                }
                if (request.AgrId != null)
                {
                    pars.Add(new FrxParameter("p_agr_id", TypeCode.Int64, request.AgrId));
                    outfilename += "_AGRID" + request.AgrId;
                }

                outfilename += "_DPTID" + request.DptId;
                // дополнительные параметры
                foreach (FrxParameter par in frx_additional_params)
                    pars.Add(par);
                FrxDoc doc = new FrxDoc(FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(TemplateID)), pars, null);

                using (MemoryStream ms = new MemoryStream())
                {
                    doc.ExportToMemoryStream(FrxExportTypes.Pdf, ms);
                    bytes = ms.ToArray();
                }
                return GetZipFile(bytes, outfilename).ToArray();
            }

            public static MemoryStream GetZipFile(byte[] buffer, string filename)
            {
                using (MemoryStream outputMemStream = new MemoryStream())
                {
                    using (ZipOutputStream zipStream = new ZipOutputStream(outputMemStream))
                    {
                        using (MemoryStream inStream = new MemoryStream(buffer))
                        {
                            zipStream.SetLevel(6);

                            var newEntry = new ZipEntry(filename + ".pdf");
                            newEntry.DateTime = DateTime.Now;

                            zipStream.PutNextEntry(newEntry);
                            StreamUtils.Copy(inStream, zipStream, new byte[4096]);
                        }
                        zipStream.CloseEntry();

                        zipStream.IsStreamOwner = false;
                    }
                    return outputMemStream;
                }
            }

            public static string getDocTemplate(Int16 type_id, Int64? dpt_id)
            {
                string Template = String.Empty;
                if (type_id != 99)
                {
                    OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
                    OracleCommand cmd_findtemplate = con.CreateCommand();
                    try
                    {

                        cmd_findtemplate.CommandText = "select dvc.id_fr id from dpt_deposit d, dpt_vidd_scheme dvc where d.deposit_id = :p_deposit_id and dvc.vidd = d.vidd and dvc.flags = :p_flags";
                        cmd_findtemplate.Parameters.Add("p_deposit_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
                        cmd_findtemplate.Parameters.Add("p_flags", OracleDbType.Decimal, type_id, ParameterDirection.Input);

                        using (OracleDataReader rdr_findtemplate = cmd_findtemplate.ExecuteReader())
                        {
                            if (rdr_findtemplate.Read())
                            {
                                Template = Convert.ToString(rdr_findtemplate["id"]);
                            }
                            else
                            {
                                throw new System.Exception(String.Format("Не знайдено шаблон {0} у таблиці doc_scheme, або шаблон не описано як FastReport", Template));
                            }
                        }
                    }
                    finally
                    {
                        cmd_findtemplate.Dispose();
                        con.Close();
                        con.Dispose();
                    }
                }
                else
                {
                    Template = "DPT_FINMON_QUESTIONNAIRE";
                }
                return Template;
            }
            #endregion DepositAdditionAgreementDoc
        }

        #endregion DepositAgreement
        #region OpenDeposit
        public class XRMOpenDeposit
        {
            public class XRMOpenDepositReq
            {
                public Decimal TransactionId;
                public String UserLogin;
                public Int16 OperationType;
                public string KF;
                public string Branch;
                public Int16 DepositType;       //0 (стандартний депозит); 1 (депозит на бенефіціара);2 (депозит на імя малолітньої особи);3 (депозит на користь малолітньої особи), 4( відкритий по довіреності)
                public Int64 RNKBeneficiary;    //рнк бенефициара
                public Int64 RNKInfant;         //рнк малолетнего лица
                public Int64 RNKTrustee;        //рнк опекуна малолетнего лица
                public Int32 Vidd;              //dpt_deposit.vidd%type,                        -- код вида вклада
                public Int64 Rnk;               //dpt_deposit.rnk%type,                         -- рег.№ вкладчика                
                public decimal Sum;             //dpt_deposit.limit%type,                       -- сумма вклада пол договору
                public int Nocash;              //number,                                       -- БЕЗНАЛ взнос (0-НАЛ,1- БЕЗНАЛ)
                public DateTime? DateZ;         //dpt_deposit.datz%type,                        -- дата заключения договора
                public string Namep;            //dpt_deposit.name_p%type,                      -- получатель %%
                public string Okpop;            //dpt_deposit.okpo_p%type,                      -- идентиф.код получателя %%
                public string Nlsp;             //dpt_deposit.nls_p%type,                       -- счет для выплаты %%
                public string Mfop;             //dpt_deposit.mfo_p%type,                       -- МФО для выплаты %%  
                public int Fl_perekr;           //dpt_vidd.fl_2620%type,                        -- флаг открытия техн.счета
                public string Name_perekr;      //dpt_deposit.nms_d%type,                       -- получатель депозита
                public string Okpo_perekr;      //dpt_deposit.okpo_p%type,                      -- идентиф.код получателя депозита
                public string Nls_perekr;       //dpt_deposit.nls_d%type,                       -- счет для возврата депозита
                public string Mfo_perekr;       //dpt_deposit.mfo_d%type,                       -- МФО для возврата депозита
                public string Comment;          //dpt_deposit.comments%type,                    -- комментарий
                public DateTime? Datbegin;      //dpt_deposit.dat_begin%type  default null,     -- дата открытия договора
                public int? Duration;           //dpt_vidd.duration%type      default null,     -- длительность (мес.)
                public int? Duration_days;      //dpt_vidd.duration_days%type default null);    -- длительность (дней)                            
            }
            public class XRMOpenDepositResult
            {
                public decimal? DptId;
                public int ResultCode;
                public string ResultMessage;
                public string nls;
                public decimal rate;
                public string nlsint;
                public string daos;
                public string dat_begin;
                public string dat_end;
                public int blkd;
                public int blkk;
                public string dkbo_num;
                public string dkbo_in;
                public string dkbo_out;
            }

            public class XRMDepositDoc
            {
                public Decimal TransactionId;
                public String UserLogin;
                public Int16 OperationType;
                public decimal Archdoc_id;
                public string ResultMessage;
            }
            public class XRMDepositDocResult
            {
                public decimal Archdoc_id;
                public decimal Status;
                public string ErrMessage;
            }
            public class XRMDepositFilesRes
            {
                public byte[] Doc;
                public int ResultCode;
                public string ResultMessage;
            }

            public static XRMDepositDocResult ProcDocSign(XRMDepositDoc DepositDoc, OracleConnection con)
            {
                XRMDepositDocResult ODepositDocRes = new XRMDepositDocResult();
                ODepositDocRes.Archdoc_id = DepositDoc.Archdoc_id;
                ODepositDocRes.Status = 0;
                ODepositDocRes.ErrMessage = String.Empty;

                OracleCommand cmd = con.CreateCommand();
                try
                {
                    cmd.Parameters.Clear();
                    cmd.CommandText = "bars.xrm_integration_oe.sign_doc";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("p_TransactionID", OracleDbType.Decimal, DepositDoc.TransactionId, ParameterDirection.Input);
                    cmd.Parameters.Add("p_archdoc_id", OracleDbType.Decimal, DepositDoc.Archdoc_id, ParameterDirection.InputOutput);
                    cmd.Parameters.Add("p_ERRORMESSAGE", OracleDbType.Varchar2, 4000, DepositDoc.ResultMessage, ParameterDirection.Output);
                    cmd.ExecuteNonQuery();

                    object ressign = cmd.Parameters["p_ERRORMESSAGE"].Value;
                    ODepositDocRes.ErrMessage = (ressign == null || ((OracleString)ressign).IsNull) ? "" : ((OracleString)ressign).Value;
                    object resarchdoc = cmd.Parameters["p_archdoc_id"].Value;
                    ODepositDocRes.Archdoc_id = (resarchdoc == null || ((OracleDecimal)resarchdoc).IsNull) ? -1 : ((OracleDecimal)resarchdoc).Value;

                    return ODepositDocRes;
                }
                catch (System.Exception e)
                {
                    ODepositDocRes.Status = -1;
                    ODepositDocRes.ErrMessage = String.Format("Помилка підпису депозитного договору: {0}", e.Message);
                    return ODepositDocRes;
                }
                finally
                {
                    cmd.Dispose();
                }
            }

            public static XRMOpenDepositResult ProcOpenDeposit(XRMOpenDepositReq DepositParams, OracleConnection con)
            {
                XRMOpenDepositResult ODepositRes = new XRMOpenDepositResult();

                ODepositRes.ResultCode = 0;
                ODepositRes.ResultMessage = String.Empty;

                OracleCommand cmd = con.CreateCommand();
                try
                {
                    Int64 RNK = DepositParams.Rnk;
                    if (DepositParams.DepositType == 2 && DepositParams.RNKInfant > 0)
                    {
                        DepositParams.Rnk = DepositParams.RNKInfant;
                        DepositParams.RNKTrustee = RNK;
                    }
                    // открываем депозитный договор
                    cmd.Parameters.Clear();
                    cmd.CommandText = "bars.xrm_integration_oe.open_deposit";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("p_TransactionID", OracleDbType.Decimal, DepositParams.TransactionId, ParameterDirection.Input);
                    cmd.Parameters.Add("p_KF", OracleDbType.Varchar2, DepositParams.KF, ParameterDirection.Input);
                    cmd.Parameters.Add("p_branch", OracleDbType.Varchar2, DepositParams.Branch, ParameterDirection.Input);
                    cmd.Parameters.Add("p_vidd", OracleDbType.Decimal, DepositParams.Vidd, ParameterDirection.Input);
                    cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, DepositParams.Rnk, ParameterDirection.Input);
                    cmd.Parameters.Add("p_nd", OracleDbType.Varchar2, 1, ParameterDirection.Input);
                    cmd.Parameters.Add("p_sum", OracleDbType.Decimal, DepositParams.Sum, ParameterDirection.Input);
                    cmd.Parameters.Add("p_nocash", OracleDbType.Int16, DepositParams.Nocash, ParameterDirection.Input);
                    cmd.Parameters.Add("p_datz", OracleDbType.Date, XRMIntegrationUtl.GmtToLocal(DepositParams.DateZ), ParameterDirection.Input);
                    cmd.Parameters.Add("p_namep", OracleDbType.Varchar2, DepositParams.Namep, ParameterDirection.Input);
                    cmd.Parameters.Add("p_okpop", OracleDbType.Varchar2, DepositParams.Okpop, ParameterDirection.Input);
                    cmd.Parameters.Add("p_nlsp", OracleDbType.Varchar2, DepositParams.Nlsp, ParameterDirection.Input);
                    cmd.Parameters.Add("p_mfop", OracleDbType.Varchar2, DepositParams.Mfop, ParameterDirection.Input);
                    cmd.Parameters.Add("p_fl_perekr", OracleDbType.Varchar2, DepositParams.Fl_perekr, ParameterDirection.Input);
                    cmd.Parameters.Add("p_name_perekr", OracleDbType.Varchar2, DepositParams.Name_perekr, ParameterDirection.Input);
                    cmd.Parameters.Add("p_okpo_perekr", OracleDbType.Varchar2, DepositParams.Okpo_perekr, ParameterDirection.Input);
                    cmd.Parameters.Add("p_nls_perekr", OracleDbType.Varchar2, DepositParams.Nls_perekr, ParameterDirection.Input);
                    cmd.Parameters.Add("p_mfo_perekr", OracleDbType.Varchar2, DepositParams.Mfo_perekr, ParameterDirection.Input);
                    cmd.Parameters.Add("p_comment", OracleDbType.Varchar2, DepositParams.Comment, ParameterDirection.Input);
                    cmd.Parameters.Add("p_dpt_id", OracleDbType.Decimal, ODepositRes.DptId, ParameterDirection.Output);
                    cmd.Parameters.Add("p_datbegin", OracleDbType.Date, XRMIntegrationUtl.GmtToLocal(DepositParams.Datbegin), ParameterDirection.Input);
                    cmd.Parameters.Add("p_duration", OracleDbType.Int16, DepositParams.Duration, ParameterDirection.Input);
                    cmd.Parameters.Add("p_duration_days", OracleDbType.Int16, DepositParams.Duration_days, ParameterDirection.Input);
                    cmd.Parameters.Add("p_rate", OracleDbType.Decimal, ODepositRes.rate, ParameterDirection.Output);
                    cmd.Parameters.Add("p_nls", OracleDbType.Varchar2, 15, ODepositRes.nls, ParameterDirection.Output);
                    cmd.Parameters.Add("p_nlsint", OracleDbType.Varchar2, 15, ODepositRes.nlsint, ParameterDirection.Output);
                    cmd.Parameters.Add("p_daos", OracleDbType.Varchar2, 250, ODepositRes.daos, ParameterDirection.Output);
                    cmd.Parameters.Add("p_dat_begin", OracleDbType.Varchar2, 250, ODepositRes.dat_begin, ParameterDirection.Output);
                    cmd.Parameters.Add("p_dat_end", OracleDbType.Varchar2, 250, ODepositRes.dat_end, ParameterDirection.Output);
                    cmd.Parameters.Add("p_blkd", OracleDbType.Int16, ODepositRes.blkd, ParameterDirection.Output);
                    cmd.Parameters.Add("p_blkk", OracleDbType.Int16, ODepositRes.blkk, ParameterDirection.Output);
                    cmd.Parameters.Add("p_dkbo_num", OracleDbType.Varchar2, 50, ODepositRes.dkbo_num, ParameterDirection.Output);
                    cmd.Parameters.Add("p_dkbo_in", OracleDbType.Varchar2, 250, ODepositRes.dkbo_in, ParameterDirection.Output);
                    cmd.Parameters.Add("p_dkbo_out", OracleDbType.Varchar2, 250, ODepositRes.dkbo_out, ParameterDirection.Output);
                    cmd.Parameters.Add("ResultCode", OracleDbType.Int16, ODepositRes.ResultCode, ParameterDirection.Output);
                    cmd.Parameters.Add("ResultMessage", OracleDbType.Varchar2, 500, ODepositRes.ResultMessage, ParameterDirection.Output);
                    cmd.ExecuteNonQuery();

                    object reserrcode = cmd.Parameters["ResultCode"].Value;
                    ODepositRes.ResultCode = Convert.ToInt16(((OracleDecimal)reserrcode).Value);

                    object resResultMessage = cmd.Parameters["ResultMessage"].Value;
                    ODepositRes.ResultMessage = (resResultMessage == null || ((OracleString)resResultMessage).IsNull) ? "" : ((OracleString)resResultMessage).Value;

                    if (ODepositRes.ResultCode == 0)
                    {

                        object resdptid = cmd.Parameters["p_dpt_id"].Value;
                        ODepositRes.DptId = (((OracleDecimal)resdptid).IsNull) ? -1 : ((OracleDecimal)resdptid).Value;

                        object resrate = cmd.Parameters["p_rate"].Value;
                        ODepositRes.rate = (((OracleDecimal)resrate).IsNull) ? -1 : ((OracleDecimal)resrate).Value;

                        object resblkd = cmd.Parameters["p_blkd"].Value;
                        ODepositRes.blkd = (((OracleDecimal)resblkd).IsNull) ? -1 : Convert.ToInt16(((OracleDecimal)resblkd).Value);

                        object resblkk = cmd.Parameters["p_blkk"].Value;
                        ODepositRes.blkk = (((OracleDecimal)resblkk).IsNull) ? -1 : Convert.ToInt16(((OracleDecimal)resblkk).Value);

                        object resnls = cmd.Parameters["p_nls"].Value;
                        ODepositRes.nls = (resnls == null || ((OracleString)resnls).IsNull) ? "" : ((OracleString)resnls).Value;

                        object resnlsint = cmd.Parameters["p_nlsint"].Value;
                        ODepositRes.nlsint = (resnlsint == null || ((OracleString)resnlsint).IsNull) ? "" : ((OracleString)resnlsint).Value;

                        object resdaos = cmd.Parameters["p_daos"].Value;
                        ODepositRes.daos = (resdaos == null || ((OracleString)resdaos).IsNull) ? "" : ((OracleString)resdaos).Value;

                        object resdate_begin = cmd.Parameters["p_dat_begin"].Value;
                        ODepositRes.dat_begin = (resdate_begin == null || ((OracleString)resdate_begin).IsNull) ? "" : ((OracleString)resdate_begin).Value;

                        object resdate_end = cmd.Parameters["p_dat_end"].Value;
                        ODepositRes.dat_end = (resdate_end == null || ((OracleString)resdate_end).IsNull) ? "" : ((OracleString)resdate_end).Value;

                        object resdkbo_num = cmd.Parameters["p_dkbo_num"].Value;
                        ODepositRes.dkbo_num = (resdkbo_num == null || ((OracleString)resdkbo_num).IsNull) ? "" : ((OracleString)resdkbo_num).Value;

                        object resdkbo_in = cmd.Parameters["p_dkbo_in"].Value;
                        ODepositRes.dkbo_in = (resdkbo_in == null || ((OracleString)resdkbo_in).IsNull) ? "" : ((OracleString)resdkbo_in).Value;

                        object resdkbo_out = cmd.Parameters["p_dkbo_out"].Value;
                        ODepositRes.dkbo_out = (resdkbo_out == null || ((OracleString)resdkbo_out).IsNull) ? "" : ((OracleString)resdkbo_out).Value;
                    }

                    if (ODepositRes.DptId != null)
                    {
                        decimal dpt_id = Convert.ToDecimal(ODepositRes.DptId);
                        decimal dpt_agreement = 0;

                        // проверки на третьих лиц
                        if (DepositParams.DepositType != 0)
                        {
                            switch (DepositParams.DepositType)
                            {
                                case 1: // 1(депозит на бенефіціара);
                                    dpt_agreement = DepositAgreement.Create(dpt_id, 5, DepositParams.Rnk,
                                        DepositParams.RNKBeneficiary, null, null, null, DepositParams.Datbegin, Convert.ToDateTime(ODepositRes.dat_end, XRMIntegrationUtl.CXRMinfo()),
                                        null, null, 11111111, 0);
                                    break;
                                case 2: // 2(депозит на імя малолітньої особи); 
                                    dpt_agreement = DepositAgreement.Create(dpt_id, 12, DepositParams.Rnk,
                                       RNK, null, null, null, DepositParams.Datbegin, Convert.ToDateTime(ODepositRes.dat_end, XRMIntegrationUtl.CXRMinfo()),
                                       null, null, 11111111, 0);
                                    dpt_agreement = DepositAgreement.Create(dpt_id, 26, DepositParams.Rnk,
                                       RNK, null, null, null, DepositParams.Datbegin, Convert.ToDateTime(ODepositRes.dat_end, XRMIntegrationUtl.CXRMinfo()),
                                       null, null, 11111111, 0);
                                    break;
                                case 3: //3(депозит на користь малолітньої особи);
                                    dpt_agreement = DepositAgreement.Create(dpt_id, 26, DepositParams.Rnk,
                                       DepositParams.RNKInfant, null, null, null, DepositParams.Datbegin, Convert.ToDateTime(ODepositRes.dat_end, XRMIntegrationUtl.CXRMinfo()),
                                       null, null, 11111111, 0);
                                    dpt_agreement = DepositAgreement.Create(dpt_id, 27, DepositParams.Rnk,
                                       DepositParams.RNKTrustee, null, null, null, DepositParams.Datbegin, Convert.ToDateTime(ODepositRes.dat_end, XRMIntegrationUtl.CXRMinfo()),
                                       null, null, 11111111, 0);
                                    break;
                                case 4: //4(відкритий по довіреності) 
                                    decimal commisrequest = Tools.CreateCommisRequest(dpt_id, 12);
                                    dpt_agreement = DepositAgreement.Create(dpt_id, 12, DepositParams.Rnk,
                                        DepositParams.RNKTrustee, null, null, null, DepositParams.Datbegin, Convert.ToDateTime(ODepositRes.dat_end, XRMIntegrationUtl.CXRMinfo()),
                                        null, commisrequest, 11111111, 0);
                                    //Decimal? WarrantID = ep.DOC_CREATE("SCAN", null, scWarrant.Value, 222, Convert.ToDecimal(Request["rnk_tr"]), dpt.ID);
                                    break;
                            }
                        }
                    }

                    return ODepositRes;
                }
                catch (System.Exception e)
                {
                    ODepositRes.ResultCode = -1;
                    ODepositRes.ResultMessage = String.Format("Помилка при створенні депозиту: {0}", e.Message);
                    return ODepositRes;
                }
                finally
                {
                    cmd.Dispose();
                }
            }
        }
        #endregion OpenDeposit
        #region requests
        public class XRMDptRequest
        {
            public class XRMDptRequestReq
            {
                public Decimal TransactionId;
                public String UserLogin;
                public Int16 OperationType;
                public String KF;
                public String Branch;
                public decimal req_type;
                public string TrusteeType;
                public decimal cust_id;
                public string CertifNum;
                public DateTime CertifDate;
                public DateTime DateStart;
                public DateTime DateFinish;
                public List<AccessInfo> AccessList;
            }
            public class XRMDptRequestRes
            {
                public decimal req_id;
                public byte[] Doc;
                public decimal Status;
                public string ErrMessage;
            }
            public class XRMDptRequestStateReq
            {
                public Decimal TransactionId;
                public String UserLogin;
                public Int16 OperationType;
                public String KF;
                public String Branch;
                public decimal req_id;
            }
            public class XRMDptRequestStateRes
            {
                public decimal RequestState;
                public string RequestMessage;
                public decimal Status;
                public string ErrMessage;
            }

            private static byte[] CreateFile(decimal req_id, decimal req_type)
            {
                byte[] bytes = null;
                using (MemoryStream ms = new MemoryStream())
                {
                    FrxParameters pars = new FrxParameters();
                    pars.Add(new FrxParameter("p_req_id", TypeCode.Int64, req_id));

                    String template = (req_type == 0 ? "DPT_ACCESS_APPLICATION_CARD" : "DPT_ACCESS_APPLICATION");

                    FrxDoc doc = new FrxDoc(FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(template)), pars, null);

                    // выбрасываем в поток в формате PDF
                    doc.ExportToMemoryStream(FrxExportTypes.Pdf, ms);
                    bytes = ms.ToArray();
                }
                return bytes;
            }
            public static byte[] GetFileForPrint(decimal req_id, decimal req_type)
            {
                MemoryStream outputMemStream = new MemoryStream();
                ZipOutputStream zipStream = new ZipOutputStream(outputMemStream);
                try
                {
                    zipStream.SetLevel(6); //0-9, 9 being the highest level of compression
                    byte[] bytes = null;

                    var newEntry = new ZipEntry("req_id_" + req_id + ".pdf");
                    newEntry.DateTime = DateTime.Now;

                    zipStream.PutNextEntry(newEntry);
                    bytes = XRMDptRequest.CreateFile(req_id, req_type);

                    using (MemoryStream inStream = new MemoryStream(bytes))
                    {
                        StreamUtils.Copy(inStream, zipStream, new byte[4096]);
                    }
                    //inStream.Close();
                    //zipStream.CloseEntry();

                    //zipStream.IsStreamOwner = false;    // False stops the Close also Closing the underlying stream.
                    //zipStream.Close();          // Must finish the ZipOutputStream before using outputMemStream.

                    return outputMemStream.ToArray();
                }
                finally
                {
                    zipStream.Close();
                    zipStream.Dispose();
                    outputMemStream.Close();
                    outputMemStream.Dispose();
                }
            }
            public static XRMDptRequestRes RequestCreate(XRMDptRequestReq DptRequestReq)
            {
                XRMDptRequestRes DptRequestRes = new XRMDptRequestRes();
                DepositRequest DptRequest;
                // Створення нового запиту без статусу (для друку заяви)                        
                if (DptRequestReq.req_type == 0)
                {
                    DptRequest = new DepositRequest();
                }
                else
                {
                    DptRequest = new DepositRequest(DptRequestReq.AccessList);
                }

                DptRequest.Save(DptRequestReq.req_type, DptRequestReq.TrusteeType, DptRequestReq.cust_id, DptRequestReq.CertifNum, DptRequestReq.CertifDate, DptRequestReq.DateStart, DptRequestReq.DateFinish);

                DptRequestRes.req_id = DptRequest.ID;
                DptRequestRes.Doc = XRMDptRequest.GetFileForPrint(DptRequestRes.req_id, DptRequestReq.req_type);
                return DptRequestRes;
            }
            public static XRMDptRequestStateRes GetRequestState(XRMDptRequestStateReq XRMDptRequestStateReq, OracleConnection con)
            {
                XRMDptRequestStateRes XRMDptRequestStateRes = new XRMDptRequestStateRes();
                OracleCommand cmd = con.CreateCommand();
                cmd.CommandText = "select req_state, comments from bars.cust_requests where req_id = :req_id";
                cmd.Parameters.Clear();
                cmd.BindByName = true;
                cmd.Parameters.Add("req_id", OracleDbType.Decimal, XRMDptRequestStateReq.req_id, ParameterDirection.Input);

                OracleDataReader reader = cmd.ExecuteReader();
                try
                {
                    if (reader.HasRows)
                    {
                        int idstate = reader.GetOrdinal("req_state");
                        int idcomments = reader.GetOrdinal("comments");
                        while (reader.Read())
                        {
                            XRMDptRequestStateRes.RequestState = Convert.ToDecimal(XRMIntegrationUtl.OracleHelper.GetDecimalString(reader, idstate, "0"));
                            XRMDptRequestStateRes.RequestMessage = Convert.ToString(XRMIntegrationUtl.OracleHelper.GetString(reader, idcomments));
                            XRMDptRequestStateRes.Status = 0;
                            XRMDptRequestStateRes.ErrMessage = "Ok";
                        }
                    }
                }
                catch (System.Exception e)
                {
                    XRMDptRequestStateRes.Status = -1;
                    XRMDptRequestStateRes.ErrMessage = e.Message;
                }
                finally
                {
                    reader.Close();
                    reader.Dispose();
                    cmd.Dispose();
                }
                return XRMDptRequestStateRes;
            }
        }

        #endregion requests
        #region earlyclose
        public class XRMEarlyClose
        {
            public class XRMEarlyCloseReq
            {
                public Decimal TransactionId;
                public String UserLogin;
                public Int16 OperationType;
                public String KF;
                public String Branch;
                public decimal RNK;             // РНК клієнта, що звернувся за достроковим закриттям депозиту
                public decimal DPT_ID;          // номер депозитного договору
                public string CUST_TYPE;        // тип клієнта, що звернувся (V - власник, T - довірена особа, H - спадкоємець)
                public Int16 FullPay;           // ознака 1 - повного повернення, 0 - часткового повернення
                public Decimal? Sum;            // запрошена сума
                public Int16 UseCash;           // ознака виплати готівкою 1, 0 - безготівково
            }
            public class XrmDepositTTS
            {
                public string tt;               // код операції
                public string name;               // найменування операції
            }
            public class XRMEarlyCloseRes
            {
                public decimal Currency;            // Валюта вкладу
                public decimal DepositSum;          // Сума на депозитному рахунку
                public decimal PercentSum;          // Сума на рахунку нарахованих відсотків
                public decimal Rate;                // Номінальна %% ставка
                public decimal PenaltyRate;         // Штрафна %% ставка
                public decimal AllPercentSum;       // Загальна сума нарахованих відсотків до штрафування
                public decimal PenaltyPercentSum;   // Загальна сума нарахованих відсотків з урахуванням штрафної ставки
                public decimal PenaltySum;          // Сума штрафа
                public decimal ComissionSum;        // Сума комісії за дострокове розторгнення
                public decimal DenomSum;            // Сума комісії за прийом на вклад зношених купюр
                public decimal DepositSumToPay;     // Сума до виплати депозита
                public decimal PercentSumToPay;     // Сума до виплати відсотків
                public XrmDepositTTS[] XrmDepositTTS; // перелік доступних операцій для виплати достроково
                public XrmDepositTTS[] XrmPercentTTS; // перелік доступних операцій для виплати достроково
                public decimal Status;
                public string ErrMessage;
            }
            public class XRMEarlyCloseRunRes
            {
                public decimal DepositSumToPay;     // Сума до виплати депозита
                public decimal PercentSumToPay;     // Сума до виплати відсотків
                public decimal Status;
                public string ErrMessage;
            }
            public static XRMEarlyCloseRes GetEarlyTerminationParams(XRMEarlyCloseReq XRMEarlyCloseReq, OracleConnection con)
            {
                XRMEarlyCloseRes XRMEarlyCloseRes = new XRMEarlyCloseRes();

                Decimal p_penalty = 0;          // Сума штрафу               
                Decimal p_commiss = 0;          // Сума комісії за РКО                
                Decimal p_commiss2 = 0;         // Сума комісії за прийом вітхих купюр                
                Decimal p_dptrest = 0;          // Сума депозиту до виплати               
                Decimal p_intrest = 0;          // Сума відсотків до виплати
                Decimal p_int2pay_ing = 0;      // Сума до виплати

                try
                {
                    if (Deposit.InheritedDeal(Convert.ToString(XRMEarlyCloseReq.DPT_ID)) && (XRMEarlyCloseReq.CUST_TYPE == "H"))
                    {
                        XRMEarlyCloseRes.Status = -1;
                        XRMEarlyCloseRes.ErrMessage = "По депозитному договору є зареєстровані спадкоємці. Дана функція заблокована.";
                    }
                    else
                    {
                        Deposit dpt = new Deposit(XRMEarlyCloseReq.DPT_ID, true);
                        XRMEarlyCloseRes.Currency = dpt.Currency;
                        XRMEarlyCloseRes.DepositSum = dpt.dpt_f_sum;
                        XRMEarlyCloseRes.PercentSum = dpt.perc_f_sum;
                        XRMEarlyCloseRes.Rate = dpt.RealIntRate;

                        using (OracleCommand cmdGetShtrafRate = con.CreateCommand())
                        {
                            cmdGetShtrafRate.CommandText = "select nvl(dpt.f_shtraf_rate(:dpt_id,bankdate),0) from dual";
                            cmdGetShtrafRate.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt.ID, ParameterDirection.Input);

                            XRMEarlyCloseRes.PenaltyRate = Convert.ToDecimal(cmdGetShtrafRate.ExecuteScalar());
                        }

                        using (OracleCommand cmdGetShtrafInfo = con.CreateCommand())
                        {
                            cmdGetShtrafInfo.CommandText = "begin " +
                                                            "dpt_web.global_penalty (:p_dptid, bankdate, :p_fullpay, null, 'RO', " +
                                                            ":p_penalty, :p_commiss, :p_commiss2, :p_dptrest, :p_intrest, :p_int2pay_ing); " +
                                                        "end;";

                            cmdGetShtrafInfo.Parameters.Add("p_dptid", OracleDbType.Decimal, dpt.ID, ParameterDirection.Input);
                            cmdGetShtrafInfo.Parameters.Add("p_fullpay", OracleDbType.Decimal, XRMEarlyCloseReq.FullPay, ParameterDirection.Input);
                            cmdGetShtrafInfo.Parameters.Add("p_penalty", OracleDbType.Decimal, p_penalty, ParameterDirection.Output);
                            cmdGetShtrafInfo.Parameters.Add("p_commiss", OracleDbType.Decimal, p_commiss, ParameterDirection.Output);
                            cmdGetShtrafInfo.Parameters.Add("p_commiss2", OracleDbType.Decimal, p_commiss2, ParameterDirection.Output);
                            cmdGetShtrafInfo.Parameters.Add("p_dptrest", OracleDbType.Decimal, p_dptrest, ParameterDirection.Output);
                            cmdGetShtrafInfo.Parameters.Add("p_intrest", OracleDbType.Decimal, p_intrest, ParameterDirection.Output);
                            cmdGetShtrafInfo.Parameters.Add("p_int2pay_ing", OracleDbType.Decimal, p_int2pay_ing, ParameterDirection.Output);

                            cmdGetShtrafInfo.ExecuteNonQuery();

                            if (String.IsNullOrEmpty(Convert.ToString(cmdGetShtrafInfo.Parameters["p_int2pay_ing"].Value)) ||
                                Convert.ToString(cmdGetShtrafInfo.Parameters["p_int2pay_ing"].Value) == "null")
                                p_int2pay_ing = 0;
                            else
                            {
                                try
                                {
                                    p_int2pay_ing = ((OracleDecimal)cmdGetShtrafInfo.Parameters["p_int2pay_ing"].Value).Value / dpt.Sum_denom;
                                }
                                catch (InvalidCastException)
                                {
                                    p_int2pay_ing = 0;
                                }
                            }

                            if (String.IsNullOrEmpty(Convert.ToString(cmdGetShtrafInfo.Parameters["p_penalty"].Value)) ||
                                Convert.ToString(cmdGetShtrafInfo.Parameters["p_penalty"].Value) == "null")
                                p_penalty = 0;
                            else
                            {
                                try
                                {
                                    p_penalty = ((OracleDecimal)cmdGetShtrafInfo.Parameters["p_penalty"].Value).Value / dpt.Sum_denom;
                                }
                                catch (InvalidCastException)
                                {
                                    p_penalty = 0;
                                }
                            }

                            if (String.IsNullOrEmpty(Convert.ToString(cmdGetShtrafInfo.Parameters["p_commiss"].Value)) ||
                                Convert.ToString(cmdGetShtrafInfo.Parameters["p_commiss"].Value) == "null")
                                p_commiss = 0;
                            else
                            {
                                try
                                {
                                    p_commiss = ((OracleDecimal)cmdGetShtrafInfo.Parameters["p_commiss"].Value).Value / dpt.Sum_denom;
                                }
                                catch (InvalidCastException)
                                {
                                    p_commiss = 0;
                                }
                            }
                            if (String.IsNullOrEmpty(Convert.ToString(cmdGetShtrafInfo.Parameters["p_commiss2"].Value)) ||
                                Convert.ToString(cmdGetShtrafInfo.Parameters["p_commiss2"].Value) == "null")
                                p_commiss2 = 0;
                            else
                            {
                                try
                                {
                                    p_commiss2 = ((OracleDecimal)cmdGetShtrafInfo.Parameters["p_commiss2"].Value).Value / dpt.Sum_denom;
                                }
                                catch (InvalidCastException)
                                {
                                    p_commiss2 = 0;
                                }
                            }
                            if (String.IsNullOrEmpty(Convert.ToString(cmdGetShtrafInfo.Parameters["p_dptrest"].Value)) ||
                                Convert.ToString(cmdGetShtrafInfo.Parameters["p_dptrest"].Value) == "null")
                                p_dptrest = 0;
                            else
                            {
                                try
                                {
                                    p_dptrest = ((OracleDecimal)cmdGetShtrafInfo.Parameters["p_dptrest"].Value).Value / dpt.Sum_denom;
                                }
                                catch (InvalidCastException)
                                {
                                    p_dptrest = 0;
                                }
                            }
                            if (String.IsNullOrEmpty(Convert.ToString(cmdGetShtrafInfo.Parameters["p_intrest"].Value)) ||
                                Convert.ToString(cmdGetShtrafInfo.Parameters["p_intrest"].Value) == "null")
                                p_intrest = 0;
                            else
                            {
                                try
                                {
                                    p_intrest = ((OracleDecimal)cmdGetShtrafInfo.Parameters["p_intrest"].Value).Value / dpt.Sum_denom;
                                }
                                catch (InvalidCastException)
                                {
                                    p_intrest = 0;
                                }
                            }
                        }

                        XRMEarlyCloseRes.PenaltySum = p_intrest - p_penalty;
                        XRMEarlyCloseRes.PenaltyPercentSum = p_intrest;
                        XRMEarlyCloseRes.AllPercentSum = p_penalty;
                        XRMEarlyCloseRes.ComissionSum = p_commiss;
                        XRMEarlyCloseRes.DenomSum = p_commiss2;
                        XRMEarlyCloseRes.DepositSumToPay = p_dptrest;
                        XRMEarlyCloseRes.PercentSumToPay = p_intrest; //сума без урахування утриманого податку 18 % +Військовий збір 1,5 %

                        if (XRMEarlyCloseReq.CUST_TYPE == "T")
                            // Сума дозволена для отримання довіреною особою 
                            XRMEarlyCloseRes.DepositSumToPay = DepositAgreement.GetAllowedAmount(dpt.ID, XRMEarlyCloseReq.RNK);
                        if (Tools.DPT_IRREVOCABLE(dpt.ID.ToString()) >= 1)
                        {
                            if (Tools.DPT_HASNO35AGREEMENT(dpt.ID.ToString()) >= 1)
                            {
                                XRMEarlyCloseRes.Status = -1;
                                XRMEarlyCloseRes.ErrMessage = "Вклад є невідкличним. Для дострокового повернення сформуйте запит на бек-офіс та сформуйте додаткову угоду на дострокове розірвання (35)";
                            }
                        }
                        // знайти операції, якими можна виплатити тіло і відстотки 

                        string sql_tts_deposit = String.Format(@"select op_type as tt, op_name as name, tt_cash 
                                                                   from bars.v_dpt_vidd_tts t, bars.dpt_deposit d 
                                                                  where d.deposit_id = {0} 
                                                                    and d.vidd = t.dpttype_id 
                                                                    and tt_id in (21,23,25,26,33,35) 
                                                                    and tt_cash = {1}
                                                                    and (d.kv = 980 or(op_type in ('EDP', 'DPE')) or (ebp.dpt_out_kv(d.deposit_id) = 1 and(op_type not in ('EDP', 'DPE'))))",
                                                 Convert.ToString(dpt.ID),
                                                 Convert.ToString(XRMEarlyCloseReq.UseCash));
                        string sql_tts_percent = String.Format(@"select op_type as tt, op_name as name, tt_cash 
                                                                   from bars.v_dpt_vidd_tts t, bars.dpt_deposit d 
                                                                  where d.deposit_id = {0} 
                                                                    and d.vidd = t.dpttype_id 
                                                                    and tt_id in (3,33,34,23,26,45) 
                                                                    and tt_cash = {1}",
                                                 Convert.ToString(dpt.ID),
                                                 Convert.ToString(XRMEarlyCloseReq.UseCash));

                        using (OracleCommand cmdtts_deposit = con.CreateCommand())
                        {
                            cmdtts_deposit.CommandText = sql_tts_deposit;
                            OracleDataReader rdr = cmdtts_deposit.ExecuteReader();
                            int tt_n = 0;
                            XRMEarlyClose.XrmDepositTTS[] XrmDepositTTSSet = new XrmDepositTTS[1];
                            while (rdr.Read())
                            {
                                if (!rdr.IsDBNull(0))
                                {
                                    XRMEarlyClose.XrmDepositTTS XrmDepositTTSd = new XrmDepositTTS();
                                    XrmDepositTTSd.tt = Convert.ToString(rdr.GetOracleString(0).Value);
                                    XrmDepositTTSd.name = Convert.ToString(rdr.GetOracleString(1).Value);
                                    Array.Resize(ref XrmDepositTTSSet, tt_n + 1);
                                    XrmDepositTTSSet[tt_n] = XrmDepositTTSd;
                                    XrmDepositTTSd = null;
                                    tt_n = tt_n + 1;
                                }
                            }
                            XRMEarlyCloseRes.XrmDepositTTS = XrmDepositTTSSet;
                            cmdtts_deposit.CommandText = sql_tts_percent;
                            rdr = cmdtts_deposit.ExecuteReader();
                            tt_n = 0;
                            XRMEarlyClose.XrmDepositTTS[] XrmDepositTTSSetp = new XrmDepositTTS[0];
                            while (rdr.Read())
                            {
                                if (!rdr.IsDBNull(0))
                                {
                                    XRMEarlyClose.XrmDepositTTS XrmDepositTTSp = new XrmDepositTTS();
                                    XrmDepositTTSp.tt = Convert.ToString(rdr.GetOracleString(0).Value);
                                    XrmDepositTTSp.name = Convert.ToString(rdr.GetOracleString(1).Value);
                                    Array.Resize(ref XrmDepositTTSSetp, tt_n + 1);
                                    XrmDepositTTSSetp[tt_n] = XrmDepositTTSp;
                                    XrmDepositTTSp = null;
                                    tt_n = tt_n + 1;
                                }
                            }
                            XRMEarlyCloseRes.XrmPercentTTS = XrmDepositTTSSetp;
                        }
                    }
                }
                catch (System.Exception e)
                {
                    XRMEarlyCloseRes.Status = -1;
                    XRMEarlyCloseRes.ErrMessage = String.Format("Помилка розрахунку штрафної ставки для депозитного договору: {0}", e.Message + e.StackTrace);
                }
                return XRMEarlyCloseRes;
            }
            public static XRMEarlyCloseRunRes RunEarlyTermination(XRMEarlyCloseReq XRMEarlyCloseReq, OracleConnection con)
            {
                XRMEarlyCloseRunRes XRMEarlyCloseRunRes = new XRMEarlyCloseRunRes();

                Decimal sum2pay = 0;
                Decimal perc2pay = 0;
                Decimal p_int2pay_ing = 0;
                using (OracleCommand cmdShtraf = con.CreateCommand())
                {
                    cmdShtraf.CommandText = "begin dpt_web.penalty_payment(:dpt_id,:sum, :dpt_rest, :perc_rest, :p_int2pay_ing); end;";

                    cmdShtraf.Parameters.Add("dpt_id", OracleDbType.Decimal, XRMEarlyCloseReq.DPT_ID, ParameterDirection.Input);
                    cmdShtraf.Parameters.Add("sum", OracleDbType.Decimal, XRMEarlyCloseReq.Sum, ParameterDirection.Input);

                    cmdShtraf.Parameters.Add("dpt_rest", OracleDbType.Decimal, sum2pay, ParameterDirection.Output);
                    cmdShtraf.Parameters.Add("perc_rest", OracleDbType.Decimal, perc2pay, ParameterDirection.Output);
                    cmdShtraf.Parameters.Add("p_int2pay_ing", OracleDbType.Decimal, p_int2pay_ing, ParameterDirection.Output);

                    cmdShtraf.ExecuteNonQuery();
                }

                using (OracleCommand cmdRests = con.CreateCommand())
                {

                    Bars.WebServices.NewNbs ws = new Bars.WebServices.NewNbs();
                    string a = "";
                    if (ws.UseNewNbs())
                    {
                        a = "('2620','2630')";
                    }
                    else
                    {
                        a = "('2620','2630','2635')";
                    }

                    cmdRests.CommandText = "select sum(case when nbs in " + a + " then ostb else 0 end)/100 dptrest, sum(case when nbs in ('2628','2638') then ostb else 0 end)/100 percentrest from accounts where acc in (select accid FROM DPT_ACCOUNTS WHERE DPTID = :dpt_id)";
                    cmdRests.Parameters.Add("dpt_id", OracleDbType.Decimal, XRMEarlyCloseReq.DPT_ID, ParameterDirection.Input);

                    using (OracleDataReader rdr = cmdRests.ExecuteReader())
                    {
                        if (rdr.Read())
                        {
                            XRMEarlyCloseRunRes.DepositSumToPay = rdr.GetOracleDecimal(0).Value;
                            XRMEarlyCloseRunRes.PercentSumToPay = rdr.GetOracleDecimal(1).Value; //сума з урахуванням утриманого податку 18 % +Військовий збір 1,5 %
                        }
                    }
                }
                return XRMEarlyCloseRunRes;
            }
        }
        #endregion earlyclose
        #region DepositFiles
        public class XRMDepositFiles
        {
            /*формування довідки по депозитному рахунку*/
            public class XRMDepositAccStatus
            {
                public Decimal TransactionId;
                public String UserLogin;
                public Int16 OperationType;
                public Int64 KF;
                public int rnk;
                public int agr_id;
            }
            /*формування виписок в нац. і іноз. валютах по депозитному рахунку*/
            public class XRMDepositExtract
            {
                public Decimal TransactionId;
                public String UserLogin;
                public Int16 OperationType;
                public Int64 KF;
                public String DATFROM;
                public String DATTO;
                public Decimal Param;
                public Decimal National;
            }
            /*формування довідки по депозитному рахунку*/
            public static byte[] XRMGetAccStatusFile(XRMDepositAccStatus XRMDepositAccStatusReq)
            {
                byte[] bytes = null;
                string templatePath = FrxDoc.GetTemplatePathByFileName("DPT_ACCOUNT_STATUS.frx");
                string outfilename = "DPT_ACCOUNT_STATUS_RNK" + XRMDepositAccStatusReq.rnk + "_AGRID_" + XRMDepositAccStatusReq.agr_id;
                FrxParameters pars = new FrxParameters()
                    {
                        new FrxParameter("p_rnk", TypeCode.Int32, XRMDepositAccStatusReq.rnk),
                        new FrxParameter("p_agr_id", TypeCode.Int32, XRMDepositAccStatusReq.agr_id)
                    };
                FrxDoc doc = new FrxDoc(templatePath, pars, null);

                using (MemoryStream ms = new MemoryStream())
                {
                    doc.ExportToMemoryStream(FrxExportTypes.Pdf, ms);
                    bytes = ms.ToArray();
                }
                return GetZipFile(bytes, outfilename).ToArray();
            }
            /*формування виписок в нац. і іноз. валютах по депозитному рахунку*/
            public static byte[] XRMGetЕxtractFile(XRMDepositExtract XRMDepositExtractReq)
            {
                byte[] bytes = null;
                string templatePath = FrxDoc.GetTemplatePathByFileName("DPT_EXTRACT_" + XRMDepositExtractReq.National + ".frx");
                string outfilename = "";

                if (XRMDepositExtractReq.National == 35)
                    outfilename = "DPT_EXTRACT_NATIONALKV_REF" + XRMDepositExtractReq.Param;
                else
                    outfilename = "DPT_EXTRACT_FOREIGNKV_REF" + XRMDepositExtractReq.Param;

                FrxParameters pars = new FrxParameters()
                    {
                        new FrxParameter("DATFROM", TypeCode.String, XRMDepositExtractReq.DATFROM),
                        new FrxParameter("DATTO", TypeCode.String, XRMDepositExtractReq.DATTO),
                        new FrxParameter("PARAM", TypeCode.Int32, XRMDepositExtractReq.Param)
                    };
                FrxDoc doc = new FrxDoc(templatePath, pars, null);

                using (MemoryStream ms = new MemoryStream())
                {
                    doc.ExportToMemoryStream(FrxExportTypes.Pdf, ms);
                    bytes = ms.ToArray();
                }

                return GetZipFile(bytes, outfilename).ToArray();
            }
            /*зіпування файлу в base64*/
            public static MemoryStream GetZipFile(byte[] buffer, string filename)
            {
                MemoryStream outputMemStream = new MemoryStream();
                ZipOutputStream zipStream = new ZipOutputStream(outputMemStream);
                MemoryStream inStream = new MemoryStream(buffer);
                try
                {
                    zipStream.SetLevel(6);

                    var newEntry = new ZipEntry(filename + ".pdf");
                    newEntry.DateTime = DateTime.Now;

                    zipStream.PutNextEntry(newEntry);
                    StreamUtils.Copy(inStream, zipStream, new byte[4096]);

                    return outputMemStream;
                }
                finally
                {
                    inStream.Close();
                    inStream.Dispose();
                    zipStream.Close();
                    zipStream.Dispose();
                    outputMemStream.Close();
                    outputMemStream.Dispose();
                }
            }
        }
        #endregion DepositFiles
        #region dpt_portfolio
        public class XRMDPTPortfolio
        {
            public class XRMDPTPortfolioRec
            {
                public string mark;
                public decimal dpt_id;
                public string dpt_num;
                public string type_name;
                public DateTime? datz;
                public DateTime? dat_end;
                public string nls;
                public string lcv;
                public Int16 dpt_lock;
                public decimal archdoc_id;
                public decimal ostc;
                public decimal ost_int;
            }
            public class XRMDPTPortfolioRequest
            {
                public Decimal TransactionId;
                public String UserLogin;
                public Int16 OperationType;
                public String KF;
                public String Branch;
                public decimal RNK;
            }
            public class XRMDPTPortfolioResponce
            {
                public XRMDPTPortfolioRec[] XRMDPTPortfolioRec;
                public int ResultCode;
                public string ResultMessage;
            }
            public static XRMDPTPortfolioRec[] GetPortfolio(decimal RNK, OracleConnection con)
            {
                using (OracleCommand cmd = con.CreateCommand())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, RNK, ParameterDirection.Input);
                    cmd.CommandText = @"select mark, dpt_id, dpt_num, archdoc_id,type_name,datz,dat_end,nls,lcv,dpt_lock,ostc,ost_int from table(dpt_views.get_portfolio_all(:p_rnk))";
                    int i = 0;
                    using (OracleDataReader rdr = cmd.ExecuteReader())
                    {
                        Int64 size = 1000;
                        XRMDPTPortfolioRec[] XRMDPTPortfolioRecSet = new XRMDPTPortfolioRec[size];
                        if (rdr.Read())
                        {
                            while (rdr.Read())
                            {
                                XRMDPTPortfolioRec XRMDPTPortfolioRec = new XRMDPTPortfolioRec();
                                int markid = rdr.GetOrdinal("mark");
                                int dptidid = rdr.GetOrdinal("dpt_id");
                                int dptnumid = rdr.GetOrdinal("dpt_num");
                                int archid = rdr.GetOrdinal("archdoc_id");
                                int type_nameid = rdr.GetOrdinal("type_name");
                                int datzid = rdr.GetOrdinal("datz");
                                int dat_endid = rdr.GetOrdinal("dat_end");
                                int nlsid = rdr.GetOrdinal("nls");
                                int lcvid = rdr.GetOrdinal("lcv");
                                int dpt_lockid = rdr.GetOrdinal("dpt_lock");
                                int ostcid = rdr.GetOrdinal("ostc");
                                int ost_intid = rdr.GetOrdinal("ost_int");

                                XRMDPTPortfolioRec.mark = XRMIntegrationUtl.OracleHelper.GetString(rdr, markid);
                                XRMDPTPortfolioRec.dpt_id = Convert.ToDecimal(XRMIntegrationUtl.OracleHelper.GetDecimalString(rdr, dptidid, "0"));
                                XRMDPTPortfolioRec.dpt_num = XRMIntegrationUtl.OracleHelper.GetString(rdr, dptnumid);
                                XRMDPTPortfolioRec.archdoc_id = Convert.ToDecimal(XRMIntegrationUtl.OracleHelper.GetDecimalString(rdr, archid, "0"));
                                XRMDPTPortfolioRec.type_name = XRMIntegrationUtl.OracleHelper.GetString(rdr, type_nameid);
                                XRMDPTPortfolioRec.datz = Convert.ToDateTime(XRMIntegrationUtl.OracleHelper.GetDateTimeString(rdr, datzid, "dd.MM.yyyy"));
                                XRMDPTPortfolioRec.dat_end = Convert.ToDateTime(XRMIntegrationUtl.OracleHelper.GetDateTimeString(rdr, dat_endid, "dd.MM.yyyy"));
                                XRMDPTPortfolioRec.nls = XRMIntegrationUtl.OracleHelper.GetString(rdr, nlsid);
                                XRMDPTPortfolioRec.lcv = XRMIntegrationUtl.OracleHelper.GetString(rdr, lcvid);
                                XRMDPTPortfolioRec.ostc = Convert.ToDecimal(XRMIntegrationUtl.OracleHelper.GetDecimalString(rdr, ostcid, "0.00"));
                                XRMDPTPortfolioRec.ost_int = Convert.ToDecimal(XRMIntegrationUtl.OracleHelper.GetDecimalString(rdr, ost_intid, "0.00"));
                                XRMDPTPortfolioRecSet[i] = XRMDPTPortfolioRec;
                                i++;
                            }
                            Array.Resize(ref XRMDPTPortfolioRecSet, i);
                            return XRMDPTPortfolioRecSet;
                        }
                        else
                            return null;
                    }
                }
            }
            #endregion dpt_portfolio     
        }
        #region dpt_products
        public class XRMDepositProduct
        {
            public Int32 type_id;
            public string type_name;
            public string type_code;
            public string fl_active;
            public string fl_demand;
            public string fl_webbanking;
            public Int32 vidd;
            public Int32 kv;
            public string vidd_name;
            public Int16 duration;
            public Int16 duration_days;
            public string LIMIT;
            public string freq_k;
            public string dubl;
            public static XRMDepositProduct[] GetDepositProducts(OracleConnection con)
            {
                int i = 0;
                using (OracleCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = @"SELECT type_id, type_name, type_code, fl_active, fl_demand, fl_webbanking,
                                               vidd, kv, vidd_name, duration, duration_days, LIMIT, freq_k, dubl
                                          FROM TABLE (dpt_views.get_dpt_products)";
                    using (OracleDataReader rdr = cmd.ExecuteReader())
                    {
                        Int64 size = 1000;
                        XRMDepositProduct[] XRMDepositProducts = new XRMDepositProduct[size];
                        if (rdr.Read())
                        {
                            while (rdr.Read())
                            {
                                XRMDepositProduct XRMDepositProduct = new XRMDepositProduct();
                                int type_idid = rdr.GetOrdinal("type_id");
                                int type_nameid = rdr.GetOrdinal("type_name");
                                int type_codeid = rdr.GetOrdinal("type_code");
                                int fl_activeid = rdr.GetOrdinal("fl_active");
                                int fl_demandid = rdr.GetOrdinal("fl_demand");
                                int fl_webbankingid = rdr.GetOrdinal("fl_webbanking");
                                int viddid = rdr.GetOrdinal("vidd");
                                int kvid = rdr.GetOrdinal("kv");
                                int vidd_nameid = rdr.GetOrdinal("vidd_name");
                                int durationid = rdr.GetOrdinal("duration");
                                int duration_daysid = rdr.GetOrdinal("duration_days");
                                int LIMITid = rdr.GetOrdinal("LIMIT");
                                int freq_kid = rdr.GetOrdinal("freq_k");
                                int dublid = rdr.GetOrdinal("dubl");
                                XRMDepositProduct.type_id = Convert.ToInt32(XRMIntegrationUtl.OracleHelper.GetDecimalString(rdr, type_idid, "0"));
                                XRMDepositProduct.type_name = XRMIntegrationUtl.OracleHelper.GetString(rdr, type_nameid);
                                XRMDepositProduct.type_code = XRMIntegrationUtl.OracleHelper.GetString(rdr, type_codeid);
                                XRMDepositProduct.fl_active = XRMIntegrationUtl.OracleHelper.GetString(rdr, fl_activeid);
                                XRMDepositProduct.fl_demand = XRMIntegrationUtl.OracleHelper.GetString(rdr, fl_demandid);
                                XRMDepositProduct.fl_webbanking = XRMIntegrationUtl.OracleHelper.GetString(rdr, fl_webbankingid);
                                XRMDepositProduct.vidd = Convert.ToInt32(XRMIntegrationUtl.OracleHelper.GetDecimalString(rdr, viddid, "0"));
                                XRMDepositProduct.kv = Convert.ToInt32(XRMIntegrationUtl.OracleHelper.GetDecimalString(rdr, kvid, "0"));
                                XRMDepositProduct.vidd_name = XRMIntegrationUtl.OracleHelper.GetString(rdr, vidd_nameid);
                                XRMDepositProduct.duration = Convert.ToInt16(XRMIntegrationUtl.OracleHelper.GetDecimalString(rdr, durationid, "0"));
                                XRMDepositProduct.duration_days = Convert.ToInt16(XRMIntegrationUtl.OracleHelper.GetDecimalString(rdr, duration_daysid, "0"));
                                XRMDepositProduct.LIMIT = XRMIntegrationUtl.OracleHelper.GetString(rdr, LIMITid);
                                XRMDepositProduct.freq_k = XRMIntegrationUtl.OracleHelper.GetString(rdr, freq_kid);
                                XRMDepositProduct.dubl = XRMIntegrationUtl.OracleHelper.GetString(rdr, dublid);
                                XRMDepositProducts[i] = XRMDepositProduct;
                                i++;
                            }
                            Array.Resize(ref XRMDepositProducts, i);
                            return XRMDepositProducts;
                        }
                        else
                            return null;
                    }
                }
            }
        }

        #endregion dpt_products
        #endregion deposits
    }

    /// <summary>
    /// Веб-сервіс для взаємодії з системою XRM Єдине вікно
    /// </summary>
    [WebService(Namespace = "http://ws.unity-bars-deposit.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class XRMIntegrationDeposit : BarsWebService
    {
        public WsHeader WsHeaderValue;
        private IDbLogger _dbLogger;

        #region deposit_method
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public List<XRMDeposits.XRMOpenDeposit.XRMOpenDepositResult> CreateDepositMethod(XRMDeposits.XRMOpenDeposit.XRMOpenDepositReq[] XRMOpenDeposit)
        {
            using (XRMIntegrationUtl XRMUtl = new XRMIntegrationUtl())
            {
                XRMIntegrationUtl.TransactionInfo Trans = new XRMIntegrationUtl.TransactionInfo();
                decimal TransSuccess = 0;
                List<XRMDeposits.XRMOpenDeposit.XRMOpenDepositResult> resList = new List<XRMDeposits.XRMOpenDeposit.XRMOpenDepositResult>();
                try
                {
                    XRMUtl.LoginADUserInt(XRMOpenDeposit[0].UserLogin);
                    try
                    {
                        using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                        {
                            foreach (XRMDeposits.XRMOpenDeposit.XRMOpenDepositReq DepositReq in XRMOpenDeposit)
                            {
                                XRMDeposits.XRMOpenDeposit.XRMOpenDepositResult DepositRes = new XRMDeposits.XRMOpenDeposit.XRMOpenDepositResult();
                                Trans.TransactionId = DepositReq.TransactionId;
                                Trans.UserLogin = DepositReq.UserLogin;
                                Trans.OperationType = DepositReq.OperationType;
                                TransSuccess = XRMIntegrationUtl.TransactionCheck(Trans, con);
                                if (TransSuccess == 0)
                                {
                                    XRMIntegrationUtl.TransactionCreate(Trans, con);
                                    DepositRes = XRMDeposits.XRMOpenDeposit.ProcOpenDeposit(DepositReq, con);
                                    resList.Add(DepositRes);
                                }
                                else
                                {
                                    DepositRes.ResultMessage = TransSuccess == -1 ? String.Format("TransactionID {0} вже була проведена", DepositReq.TransactionId) : String.Format("Ошибка получения транзакции из БД", DepositReq.TransactionId);
                                    DepositRes.ResultCode = -1;
                                    resList.Add(DepositRes);
                                }
                            }
                        }
                        return resList;
                    }
                    catch (System.Exception ex)
                    {
                        Int32 resultCode = -1;
                        String resultMessage = ex.Message;
                        resList.Add(new XRMDeposits.XRMOpenDeposit.XRMOpenDepositResult { ResultCode = resultCode, ResultMessage = resultMessage });
                        return resList;
                    }
                }
                catch (Exception.AutenticationException ex)
                {
                    String resultMessage = String.Format("Помилка авторизації: {0}", ex.Message);
                    Int32 resultCode = -1;
                    decimal? dptId = -1;
                    resList.Add(new XRMDeposits.XRMOpenDeposit.XRMOpenDepositResult { ResultMessage = resultMessage, ResultCode = resultCode, DptId = dptId });
                    return resList;
                }
                finally { DisposeOraConnection(); }
            }
        }
        #endregion deposit_method

        #region docsign_method
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public List<XRMDeposits.XRMOpenDeposit.XRMDepositDocResult> DocSignMethod(XRMDeposits.XRMOpenDeposit.XRMDepositDoc[] XRMDepositDocs)
        {
            using (XRMIntegrationUtl XRMUtl = new XRMIntegrationUtl())
            {
                XRMIntegrationUtl.TransactionInfo Trans = new XRMIntegrationUtl.TransactionInfo();
                decimal TransSuccess = 0;
                List<XRMDeposits.XRMOpenDeposit.XRMDepositDocResult> resList = new List<XRMDeposits.XRMOpenDeposit.XRMDepositDocResult>();
                try
                {
                    XRMUtl.LoginADUserInt(XRMDepositDocs[0].UserLogin);
                    using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                    {
                        foreach (XRMDeposits.XRMOpenDeposit.XRMDepositDoc DocSign in XRMDepositDocs)
                        {
                            XRMDeposits.XRMOpenDeposit.XRMDepositDocResult DocSignRes = new XRMDeposits.XRMOpenDeposit.XRMDepositDocResult();
                            Trans.TransactionId = DocSign.TransactionId;
                            Trans.UserLogin = DocSign.UserLogin;
                            Trans.OperationType = DocSign.OperationType;
                            TransSuccess = XRMIntegrationUtl.TransactionCheck(Trans, con);
                            if (TransSuccess == 0)
                            {
                                XRMIntegrationUtl.TransactionCreate(Trans, con);
                                DocSignRes = XRMDeposits.XRMOpenDeposit.ProcDocSign(DocSign, con);
                            }
                            else
                            {
                                DocSignRes.Status = -1;
                                DocSignRes.ErrMessage = TransSuccess == -1 ? String.Format("TransactionID {0} already exists", DocSign.TransactionId) : String.Format("Ошибка получения транзакции из БД", DocSign.TransactionId);
                            }
                            resList.Add(DocSignRes);
                        }
                    }
                    return resList;
                }
                catch (System.Exception ex)
                {
                    string errMessage = ex.Message;
                    decimal status = -1;
                    resList.Add(new XRMDeposits.XRMOpenDeposit.XRMDepositDocResult { Status = status, ErrMessage = errMessage });
                }
                return resList;
            }
        }
        #endregion docsign_method

        #region deposit_agreement
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public List<XRMDeposits.XRMDepositAgreement.XRMDepositAgreementResult> CreateDepositAgreement(XRMDeposits.XRMDepositAgreement.XRMDepositAgreementReq[] XRMDepositAgrmnt)
        {
            using (XRMIntegrationUtl XRMUtl = new XRMIntegrationUtl())
            {
                XRMIntegrationUtl.TransactionInfo Trans = new XRMIntegrationUtl.TransactionInfo();
                decimal TransSuccess = 0;
                List<XRMDeposits.XRMDepositAgreement.XRMDepositAgreementResult> resList = new List<XRMDeposits.XRMDepositAgreement.XRMDepositAgreementResult>();
                try
                {
                    XRMUtl.LoginADUserInt(XRMDepositAgrmnt[0].UserLogin);
                    using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                    {
                        foreach (XRMDeposits.XRMDepositAgreement.XRMDepositAgreementReq XRMDepositAgr in XRMDepositAgrmnt)
                        {
                            XRMDeposits.XRMDepositAgreement.XRMDepositAgreementResult CreateDepositAgreementRes = new XRMDeposits.XRMDepositAgreement.XRMDepositAgreementResult();
                            Trans.TransactionId = XRMDepositAgr.TransactionId;
                            Trans.UserLogin = XRMDepositAgr.UserLogin;
                            Trans.OperationType = XRMDepositAgr.OperationType;
                            TransSuccess = XRMIntegrationUtl.TransactionCheck(Trans, con);
                            if (TransSuccess == 0)
                            {
                                XRMIntegrationUtl.TransactionCreate(Trans, con);
                                CreateDepositAgreementRes = XRMDeposits.XRMDepositAgreement.ProcDepositAgreement(XRMDepositAgr, con);
                            }
                            else
                            {
                                CreateDepositAgreementRes.ErrMessage = TransSuccess == -1 ? String.Format("TransactionID {0} already exists", XRMDepositAgr.TransactionId) : String.Format("Ошибка получения транзакции из БД", XRMDepositAgr.TransactionId);
                                CreateDepositAgreementRes.Status = -1;
                            }
                            resList.Add(CreateDepositAgreementRes);
                        }
                    }
                    return resList;
                }
                catch (System.Exception ex)
                {
                    decimal status = -1;
                    string errorMessage = ex.Message;
                    resList.Add(new XRMDeposits.XRMDepositAgreement.XRMDepositAgreementResult { ErrMessage = errorMessage, Status = status });
                }
                return resList;
            }
        }
        #endregion deposit_agreement

        #region deposit_status_file
        /// <summary>
        /// /*формування довідки по депозитному рахунку*/
        /// </summary>
        /// <param name="XRMDepositAccStatusReq"></param>
        /// <returns></returns>
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]

        public XRMDeposits.XRMOpenDeposit.XRMDepositFilesRes GetAccountStatusFile(XRMDeposits.XRMDepositFiles.XRMDepositAccStatus XRMDepositAccStatusReq)
        {
            using (XRMIntegrationUtl XRMUtl = new XRMIntegrationUtl())
            {
                XRMIntegrationUtl.TransactionInfo Trans = new XRMIntegrationUtl.TransactionInfo();
                decimal TransSuccess = 0;
                XRMDeposits.XRMOpenDeposit.XRMDepositFilesRes result = new XRMDeposits.XRMOpenDeposit.XRMDepositFilesRes();
                try
                {
                    XRMUtl.LoginADUserInt(XRMDepositAccStatusReq.UserLogin);
                    using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                    {
                        Trans.TransactionId = XRMDepositAccStatusReq.TransactionId;
                        Trans.UserLogin = XRMDepositAccStatusReq.UserLogin;
                        Trans.OperationType = XRMDepositAccStatusReq.OperationType;

                        TransSuccess = XRMIntegrationUtl.TransactionCheck(Trans, con);

                        if (TransSuccess == 0)
                        {
                            XRMIntegrationUtl.TransactionCreate(Trans, con);
                            result.Doc = XRMDeposits.XRMDepositFiles.XRMGetAccStatusFile(XRMDepositAccStatusReq);

                        }
                        else if (TransSuccess == -1)
                        {
                            result.ResultMessage = String.Format("TransactionID {0} вже була проведена", XRMDepositAccStatusReq.TransactionId);
                            result.ResultCode = -1;
                        }
                        else
                        {
                            result.ResultMessage = String.Format("Ошибка получения транзакции {0} из БД", XRMDepositAccStatusReq.TransactionId);
                            result.ResultCode = -1;
                        }
                        return result;
                    }
                }
                catch (System.Exception ex)
                {
                    result.ResultCode = -1;
                    result.ResultMessage = ex.Message;
                    return result;
                }
            }
        }
        #endregion deposit_status_file

        #region deposit_extract_file
        /// <summary>
        /// /*формування виписок в нац. і іноз. валютах по депозитному рахунку*/
        /// </summary>
        /// <param name="XRMDepositExtractReq"></param>
        /// <returns></returns>

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMDeposits.XRMOpenDeposit.XRMDepositFilesRes GetExtractFile(XRMDeposits.XRMDepositFiles.XRMDepositExtract XRMDepositExtractReq)
        {
            using (XRMIntegrationUtl XRMUtl = new XRMIntegrationUtl())
            {
                XRMIntegrationUtl.TransactionInfo Trans = new XRMIntegrationUtl.TransactionInfo();
                decimal TransSuccess = 0;
                XRMDeposits.XRMOpenDeposit.XRMDepositFilesRes result = new XRMDeposits.XRMOpenDeposit.XRMDepositFilesRes();
                try
                {
                    XRMUtl.LoginUserInt(System.Configuration.ConfigurationManager.AppSettings["XRM_USER"]);
                    using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                    {
                        Trans.TransactionId = XRMDepositExtractReq.TransactionId;
                        Trans.UserLogin = XRMDepositExtractReq.UserLogin;
                        Trans.OperationType = XRMDepositExtractReq.OperationType;

                        TransSuccess = XRMIntegrationUtl.TransactionCheck(Trans, con);

                        if (TransSuccess == 0)
                        {
                            XRMIntegrationUtl.TransactionCreate(Trans, con);
                            result.Doc = XRMDeposits.XRMDepositFiles.XRMGetЕxtractFile(XRMDepositExtractReq);

                        }
                        else if (TransSuccess == -1)
                        {
                            result.ResultMessage = String.Format("TransactionID {0} вже була проведена", XRMDepositExtractReq.TransactionId);
                            result.ResultCode = -1;
                        }
                        else
                        {
                            result.ResultMessage = String.Format("Ошибка получения транзакции {0} из БД", XRMDepositExtractReq.TransactionId);
                            result.ResultCode = -1;
                        }
                        return result;
                    }
                }
                catch (System.Exception ex)
                {
                    result.ResultCode = -1;
                    result.ResultMessage = ex.Message;
                    return result;
                }
            }
        }
        #endregion deposit_extract_file

        #region requests
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMDeposits.XRMDptRequest.XRMDptRequestRes RequestCreateMethod(XRMDeposits.XRMDptRequest.XRMDptRequestReq XRMRequest)
        {
            using (XRMIntegrationUtl XRMUtl = new XRMIntegrationUtl())
            {
                XRMIntegrationUtl.TransactionInfo Trans = new XRMIntegrationUtl.TransactionInfo();
                decimal TransSuccess = 0;
                XRMDeposits.XRMDptRequest.XRMDptRequestRes DptRequestRes = new XRMDeposits.XRMDptRequest.XRMDptRequestRes();
                try
                {
                    XRMUtl.LoginADUserInt(XRMRequest.UserLogin);
                    using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                    {
                        Trans.TransactionId = XRMRequest.TransactionId;
                        Trans.UserLogin = XRMRequest.UserLogin;
                        Trans.OperationType = XRMRequest.OperationType;
                        TransSuccess = XRMIntegrationUtl.TransactionCheck(Trans, con);
                        if (TransSuccess == 0)
                        {
                            XRMIntegrationUtl.TransactionCreate(Trans, con);
                            DptRequestRes = XRMDeposits.XRMDptRequest.RequestCreate(XRMRequest);
                        }
                        else if (TransSuccess == -1)
                        {
                            DptRequestRes.Status = -1;
                            DptRequestRes.ErrMessage = String.Format("TransactionID {0} already exists", XRMRequest.TransactionId);
                        }
                        else
                        {
                            DptRequestRes.Status = -1;
                            DptRequestRes.ErrMessage = String.Format("Ошибка получения транзакции из БД", XRMRequest.TransactionId);
                        }
                    }
                    return DptRequestRes;
                }
                catch (System.Exception ex)
                {
                    DptRequestRes.Status = -1;
                    DptRequestRes.ErrMessage = ex.Message;
                    return DptRequestRes;
                }
            }
        }
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMDeposits.XRMDptRequest.XRMDptRequestStateRes GetRequestStateMethod(XRMDeposits.XRMDptRequest.XRMDptRequestStateReq XRMRequestStateReq)
        {
            using (XRMIntegrationUtl XRMUtl = new XRMIntegrationUtl())
            {
                XRMIntegrationUtl.TransactionInfo Trans = new XRMIntegrationUtl.TransactionInfo();
                decimal TransSuccess = 0;
                XRMDeposits.XRMDptRequest.XRMDptRequestStateRes DptRequestStateRes = new XRMDeposits.XRMDptRequest.XRMDptRequestStateRes();
                try
                {
                    XRMUtl.LoginADUserInt(XRMRequestStateReq.UserLogin);
                    using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                    {

                        Trans.TransactionId = XRMRequestStateReq.TransactionId;
                        Trans.UserLogin = XRMRequestStateReq.UserLogin;
                        Trans.OperationType = XRMRequestStateReq.OperationType;
                        TransSuccess = XRMIntegrationUtl.TransactionCheck(Trans, con);
                        if (TransSuccess == 0)
                        {
                            XRMIntegrationUtl.TransactionCreate(Trans, con);
                            DptRequestStateRes = XRMDeposits.XRMDptRequest.GetRequestState(XRMRequestStateReq, con);
                        }
                        else if (TransSuccess == -1)
                        {
                            DptRequestStateRes.Status = -1;
                            DptRequestStateRes.ErrMessage = String.Format("TransactionID {0} already exists", XRMRequestStateReq.TransactionId);
                        }
                        else
                        {
                            DptRequestStateRes.Status = -1;
                            DptRequestStateRes.ErrMessage = String.Format("Ошибка получения транзакции из БД", XRMRequestStateReq.TransactionId);
                        }

                    }
                    return DptRequestStateRes;
                }
                catch (System.Exception ex)
                {
                    DptRequestStateRes.Status = -1;
                    DptRequestStateRes.ErrMessage = ex.Message;
                    return DptRequestStateRes;
                }
            }
        }

        #endregion requests

        #region deposit_add_agreement
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMDeposits.XRMDepositAgreement.XRMDepositAdditionalAgreementRes GetAdditionalAgreement(XRMDeposits.XRMDepositAgreement.XRMDepositAdditionalAgreementReq request)
        {
            using (XRMIntegrationUtl XRMUtl = new XRMIntegrationUtl())
            {
                XRMIntegrationUtl.TransactionInfo Trans = new XRMIntegrationUtl.TransactionInfo();
                decimal TransSuccess = 0;
                XRMDeposits.XRMDepositAgreement.XRMDepositAdditionalAgreementRes result = new XRMDeposits.XRMDepositAgreement.XRMDepositAdditionalAgreementRes();
                try
                {
                    XRMUtl.LoginADUserInt(request.UserLogin);
                    using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                    {
                        Trans.TransactionId = request.TransactionId;
                        Trans.UserLogin = request.UserLogin;
                        Trans.OperationType = request.OperationType;

                        TransSuccess = XRMIntegrationUtl.TransactionCheck(Trans, con);

                        if (TransSuccess == 0)
                        {
                            XRMIntegrationUtl.TransactionCreate(Trans, con);
                            result.Doc = XRMDeposits.XRMDepositAgreement.GetDepositAdditionalAgreement(request);

                        }
                        else if (TransSuccess == -1)
                        {
                            result.ResultMessage = String.Format("TransactionID {0} вже була проведена", request.TransactionId);
                            result.ResultCode = -1;
                        }
                        else
                        {
                            result.ResultMessage = String.Format("Ошибка получения транзакции {0} из БД", request.TransactionId);
                            result.ResultCode = -1;
                        }
                        return result;
                    }
                }
                catch (System.Exception ex)
                {
                    result.ResultCode = -1;
                    result.ResultMessage = ex.Message;
                    return result;
                }
            }
        }
        #endregion deposit_add_agreement

        #region earlyClose    
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMDeposits.XRMEarlyClose.XRMEarlyCloseRes GetEarlyCloseMethod(XRMDeposits.XRMEarlyClose.XRMEarlyCloseReq XRMEarlyCloseReq)
        {
            using (XRMIntegrationUtl XRMUtl = new XRMIntegrationUtl())
            {
                XRMIntegrationUtl.TransactionInfo Trans = new XRMIntegrationUtl.TransactionInfo();
                decimal TransSuccess = 0;
                XRMDeposits.XRMEarlyClose.XRMEarlyCloseRes XRMEarlyCloseRes = new XRMDeposits.XRMEarlyClose.XRMEarlyCloseRes();
                try
                {
                    XRMUtl.LoginADUserInt(XRMEarlyCloseReq.UserLogin);
                    using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                    {

                        Trans.TransactionId = XRMEarlyCloseReq.TransactionId;
                        Trans.UserLogin = XRMEarlyCloseReq.UserLogin;
                        Trans.OperationType = XRMEarlyCloseReq.OperationType;
                        TransSuccess = XRMIntegrationUtl.TransactionCheck(Trans, con);
                        if (TransSuccess == 0)
                        {
                            XRMIntegrationUtl.TransactionCreate(Trans, con);
                            XRMEarlyCloseRes = XRMDeposits.XRMEarlyClose.GetEarlyTerminationParams(XRMEarlyCloseReq, con);
                        }
                        else if (TransSuccess == -1)
                        {
                            XRMEarlyCloseRes.Status = -1;
                            XRMEarlyCloseRes.ErrMessage = String.Format("TransactionID {0} already exists", XRMEarlyCloseReq.TransactionId);
                        }
                        else
                        {
                            XRMEarlyCloseRes.Status = -1;
                            XRMEarlyCloseRes.ErrMessage = String.Format("Ошибка получения транзакции из БД", XRMEarlyCloseReq.TransactionId);
                        }
                    }
                    return XRMEarlyCloseRes;
                }
                catch (System.Exception ex)
                {
                    XRMEarlyCloseRes.Status = -1;
                    XRMEarlyCloseRes.ErrMessage = ex.Message;
                    return XRMEarlyCloseRes;
                }
            }
        }
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMDeposits.XRMEarlyClose.XRMEarlyCloseRunRes RunEarlyCloseMethod(XRMDeposits.XRMEarlyClose.XRMEarlyCloseReq XRMEarlyCloseReq)
        {
            using (XRMIntegrationUtl XRMUtl = new XRMIntegrationUtl())
            {
                XRMIntegrationUtl.TransactionInfo Trans = new XRMIntegrationUtl.TransactionInfo();
                decimal TransSuccess = 0;
                XRMDeposits.XRMEarlyClose.XRMEarlyCloseRunRes XRMEarlyCloseRunRes = new XRMDeposits.XRMEarlyClose.XRMEarlyCloseRunRes();
                try
                {
                    XRMUtl.LoginADUserInt(XRMEarlyCloseReq.UserLogin);
                    using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                    {

                        Trans.TransactionId = XRMEarlyCloseReq.TransactionId;
                        Trans.UserLogin = XRMEarlyCloseReq.UserLogin;
                        Trans.OperationType = XRMEarlyCloseReq.OperationType;
                        TransSuccess = XRMIntegrationUtl.TransactionCheck(Trans, con);
                        if (TransSuccess == 0)
                        {
                            XRMIntegrationUtl.TransactionCreate(Trans, con);
                            XRMEarlyCloseRunRes = XRMDeposits.XRMEarlyClose.RunEarlyTermination(XRMEarlyCloseReq, con);
                        }
                        else if (TransSuccess == -1)
                        {
                            XRMEarlyCloseRunRes.Status = -1;
                            XRMEarlyCloseRunRes.ErrMessage = String.Format("TransactionID {0} already exists", XRMEarlyCloseReq.TransactionId);
                        }
                        else
                        {
                            XRMEarlyCloseRunRes.Status = -1;
                            XRMEarlyCloseRunRes.ErrMessage = String.Format("Ошибка получения транзакции из БД", XRMEarlyCloseReq.TransactionId);
                        }

                    }
                    return XRMEarlyCloseRunRes;
                }
                catch (System.Exception ex)
                {
                    XRMEarlyCloseRunRes.Status = -1;
                    XRMEarlyCloseRunRes.ErrMessage = ex.Message;
                    return XRMEarlyCloseRunRes;
                }
            }
        }
        #endregion earlyClose

        #region portfolio
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMDeposits.XRMDPTPortfolio.XRMDPTPortfolioResponce GetDPTPortfolioMethod(XRMDeposits.XRMDPTPortfolio.XRMDPTPortfolioRequest XRMDPTPortfolioRequest)
        {
            using (XRMIntegrationUtl XRMUtl = new XRMIntegrationUtl())
            {
                XRMIntegrationUtl.TransactionInfo Trans = new XRMIntegrationUtl.TransactionInfo();
                decimal TransSuccess = 0;
                XRMDeposits.XRMDPTPortfolio.XRMDPTPortfolioResponce XRMDPTPortfolioResponce = new XRMDeposits.XRMDPTPortfolio.XRMDPTPortfolioResponce();
                try
                {
                    XRMUtl.LoginADUserInt(XRMDPTPortfolioRequest.UserLogin);
                    using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                    {
                        Trans.TransactionId = XRMDPTPortfolioRequest.TransactionId;
                        Trans.UserLogin = XRMDPTPortfolioRequest.UserLogin;
                        Trans.OperationType = XRMDPTPortfolioRequest.OperationType;
                        TransSuccess = XRMIntegrationUtl.TransactionCheck(Trans, con);
                        if (TransSuccess == 0)
                        {
                            XRMIntegrationUtl.TransactionCreate(Trans, con);
                            XRMDPTPortfolioResponce.XRMDPTPortfolioRec = XRMDeposits.XRMDPTPortfolio.GetPortfolio(XRMDPTPortfolioRequest.RNK, con).ToArray();
                        }
                        else if (TransSuccess == -1)
                        {
                            XRMDPTPortfolioResponce.ResultCode = -1;
                            XRMDPTPortfolioResponce.ResultMessage = String.Format("TransactionID {0} already exists", XRMDPTPortfolioRequest.TransactionId);
                        }
                        else
                        {
                            XRMDPTPortfolioResponce.ResultCode = -1;
                            XRMDPTPortfolioResponce.ResultMessage = String.Format("Ошибка получения транзакции из БД", XRMDPTPortfolioRequest.TransactionId);
                        }
                    }
                    return XRMDPTPortfolioResponce;
                }
                catch (System.Exception ex)
                {
                    XRMDPTPortfolioResponce.ResultCode = -1;
                    XRMDPTPortfolioResponce.ResultMessage = ex.Message;
                    return XRMDPTPortfolioResponce;
                }
            }
        }
        #endregion portfolio

        #region dpt_products 
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMDeposits.XRMDepositProduct[] GetDPTProductsMethod()
        {
            using (XRMIntegrationUtl XRMUtl = new XRMIntegrationUtl())
            {

                XRMDeposits.XRMDepositProduct[] XRMDepositProducts = new XRMDeposits.XRMDepositProduct[0];

                XRMUtl.LoginUserInt(System.Configuration.ConfigurationManager.AppSettings["XRM_USER"]);
                try
                {
                    using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                    {
                        return XRMDeposits.XRMDepositProduct.GetDepositProducts(con);
                    }
                }
                catch (System.Exception)
                {
                    return null;
                }
            }
        }
        #endregion dpt_products
    }
}
