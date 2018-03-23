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
using Bars.WebServices.XRM.Services.DepositXrm.Models;
using ibank.core;
using Bars.EAD;
using Bars.Requests;

namespace Bars.WebServices.XRM.Services.DepositXrm
{
    public static class DepositXrmWorker
    {
        #region DepositAgreement

        #region CreateDocument
        public static XRMDepositAgreementAccount TransferDPT;          // параметры возврата депозита
        public static XRMDepositAgreementAccount TransferINT;          // параметры выплаты процентов       

        private static XmlDocument _p_doc;
        public static XmlDocument p_doc
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

        private static XmlDocument _d_doc;
        public static XmlDocument d_doc
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
        #endregion

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
        public static string getDocTemplate(Int16 type_id, Int64? dpt_id)
        {
            string Template = String.Empty;
            if (type_id != 99)
            {
                using (OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                {
                    using (OracleCommand cmd_findtemplate = con.CreateCommand())
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
                }
            }
            else
            {
                Template = "DPT_FINMON_QUESTIONNAIRE";
            }
            return Template;
        }

        private static Boolean CkConditionIRREVOCABLE(Decimal DptID, Int32 AgrTypeID, OracleConnection con)
        {
            Boolean res = false;

            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = @"select dpt_irrevocable(:p_dpt_id) from dual";
                cmd.Parameters.Add("p_dpt_id", OracleDbType.Decimal, DptID, ParameterDirection.Input);

                using (OracleDataReader rdr = cmd.ExecuteReader())
                {
                    try
                    {
                        if (rdr.Read())
                        {
                            res = rdr.GetOracleDecimal(0).Value != 1;
                        }
                    }
                    catch { }
                }
            }
            return res;
        }
        public static XRMDepositAgreementResult ProcDepositAgreement(XRMDepositAgreementReq DepositAgrmnt, OracleConnection con)
        {
            XRMDepositAgreementResult ODepositAgrRes = new XRMDepositAgreementResult();

            ODepositAgrRes.Status = 0;
            ODepositAgrRes.ErrMessage = String.Empty;

            using (OracleCommand cmd = con.CreateCommand())
            {
                try
                {
                    string TransferDPT = "";
                    string TransferINT = "";
                    if (Deposit.InheritedDeal(Convert.ToString(DepositAgrmnt.DptId), con))
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
                        else
                        {
                            DepositAgrmnt.Denomcount = "11111111";
                        }

                        if (DepositAgrmnt.AgreementType == 11 || DepositAgrmnt.AgreementType == 20 || DepositAgrmnt.AgreementType == 28)
                        {
                            if (DepositAgrmnt.TransferDPT != null) // реквізити для виплати депозиту                        {
                            {
                                XmlDocument d_doc = CreateXmlDoc(DepositAgrmnt.TransferDPT.nls, DepositAgrmnt.TransferDPT.mfo, DepositAgrmnt.TransferDPT.okpo, DepositAgrmnt.TransferDPT.nmk, null);
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
                        cmd.Parameters.Add("p_datbegin", OracleDbType.Date, XrmHelper.GmtToLocal(DepositAgrmnt.DateBegin), ParameterDirection.Input);
                        cmd.Parameters.Add("p_datend", OracleDbType.Date, XrmHelper.GmtToLocal(DepositAgrmnt.DateEnd), ParameterDirection.Input);

                        // ***
                        cmd.Parameters.Add("p_amountcash", OracleDbType.Decimal, DepositAgrmnt.Amountcash, ParameterDirection.Input);
                        cmd.Parameters.Add("p_amountcashless", OracleDbType.Decimal, DepositAgrmnt.Amountcashless, ParameterDirection.Input);
                        cmd.Parameters.Add("p_ratereqid", OracleDbType.Decimal, DepositAgrmnt.RateReqId, ParameterDirection.Input);
                        cmd.Parameters.Add("p_ratevalue", OracleDbType.Decimal, DepositAgrmnt.RateValue, ParameterDirection.Input);
                        cmd.Parameters.Add("p_ratedate", OracleDbType.Date, XrmHelper.GmtToLocal(DepositAgrmnt.RateDate), ParameterDirection.Input);
                        cmd.Parameters.Add("p_denomamount", OracleDbType.Decimal, DepositAgrmnt.DenomAmount, ParameterDirection.Input);
                        cmd.Parameters.Add("p_denomref", OracleDbType.Decimal, DepositAgrmnt.DenomRef, ParameterDirection.Input);
                        cmd.Parameters.Add("p_docref", OracleDbType.Decimal, DepositAgrmnt.DocRef, ParameterDirection.Input);
                        cmd.Parameters.Add("p_freq", OracleDbType.Decimal, DepositAgrmnt.freq, ParameterDirection.Input);

                        cmd.Parameters.Add("p_comissref", OracleDbType.Decimal, DepositAgrmnt.ComissRef, ParameterDirection.Input);
                        cmd.Parameters.Add("p_comissreqid", OracleDbType.Decimal, DepositAgrmnt.ComissReqId, ParameterDirection.Input);
                        cmd.Parameters.Add("P_AGRMNTID", OracleDbType.Decimal, ODepositAgrRes.AgrementId, ParameterDirection.Output);
                        cmd.Parameters.Add("p_ERRORMESSAGE", OracleDbType.Varchar2, 4000, ODepositAgrRes.ErrMessage, ParameterDirection.Output);
                        cmd.ExecuteNonQuery();

                        OracleString ressign = (OracleString)cmd.Parameters["p_ERRORMESSAGE"].Value;
                        ODepositAgrRes.ErrMessage = ressign.IsNull ? "" : ressign.Value;

                        OracleDecimal resarchdoc = (OracleDecimal)cmd.Parameters["P_AGRMNTID"].Value;
                        ODepositAgrRes.AgrementId = resarchdoc.IsNull ? -1 : resarchdoc.Value;

                        if (ODepositAgrRes.AgrementId == -1)
                        {
                            ODepositAgrRes.Status = -1;
                        }
                        return ODepositAgrRes;
                    }
                }
                catch (System.Exception e)
                {
                    ODepositAgrRes.Status = -1;
                    ODepositAgrRes.ErrMessage = String.Format("Помилка створення додаткової угоди депозитного договору: {0}", e.Message + e.StackTrace);
                }
            }
            return ODepositAgrRes;
        }
        #endregion

        #region OpenDeposit
        public static XRMDepositDocResult ProcDocSign(XRMDepositDoc DepositDoc, OracleConnection con)
        {
            XRMDepositDocResult ODepositDocRes = new XRMDepositDocResult();
            ODepositDocRes.Archdoc_id = DepositDoc.Archdoc_id;
            ODepositDocRes.Status = 0;
            ODepositDocRes.ErrMessage = String.Empty;

            using (OracleCommand cmd = con.CreateCommand())
            {
                try
                {
                    cmd.CommandText = "bars.xrm_integration_oe.sign_doc";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("p_TransactionID", OracleDbType.Decimal, DepositDoc.TransactionId, ParameterDirection.Input);
                    cmd.Parameters.Add("p_archdoc_id", OracleDbType.Decimal, DepositDoc.Archdoc_id, ParameterDirection.InputOutput);
                    cmd.Parameters.Add("p_ERRORMESSAGE", OracleDbType.Varchar2, 4000, DepositDoc.ResultMessage, ParameterDirection.Output);
                    cmd.ExecuteNonQuery();

                    OracleString ressign = (OracleString)cmd.Parameters["p_ERRORMESSAGE"].Value;
                    ODepositDocRes.ErrMessage = ressign.IsNull ? "" : ressign.Value;

                    OracleDecimal resarchdoc = (OracleDecimal)cmd.Parameters["p_archdoc_id"].Value;
                    ODepositDocRes.Archdoc_id = resarchdoc.IsNull ? -1 : resarchdoc.Value;

                    return ODepositDocRes;
                }
                catch (System.Exception e)
                {
                    ODepositDocRes.Status = -1;
                    ODepositDocRes.ErrMessage = String.Format("Помилка підпису депозитного договору: {0}", e.Message);
                    return ODepositDocRes;
                }
            }
        }

        public static XRMOpenDepositResult ProcOpenDeposit(XRMOpenDepositReq DepositParams, OracleConnection con)
        {
            XRMOpenDepositResult ODepositRes = new XRMOpenDepositResult();

            ODepositRes.ResultCode = 0;
            ODepositRes.ResultMessage = String.Empty;

            using (OracleCommand cmd = con.CreateCommand())
            {
                try
                {
                    Int64 RNK = DepositParams.Rnk;
                    if (DepositParams.DepositType == 2 && DepositParams.RNKInfant > 0)
                    {
                        DepositParams.Rnk = DepositParams.RNKInfant;
                        DepositParams.RNKTrustee = RNK;
                    }
                    // открываем депозитный договор
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
                    cmd.Parameters.Add("p_datz", OracleDbType.Date, XrmHelper.GmtToLocal(DepositParams.DateZ), ParameterDirection.Input);
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
                    cmd.Parameters.Add("p_datbegin", OracleDbType.Date, XrmHelper.GmtToLocal(DepositParams.Datbegin), ParameterDirection.Input);
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

                    OracleDecimal reserrcode = (OracleDecimal)cmd.Parameters["ResultCode"].Value;
                    if (!reserrcode.IsNull)
                        ODepositRes.ResultCode = Convert.ToInt16(reserrcode.Value);

                    OracleString resResultMessage = (OracleString)cmd.Parameters["ResultMessage"].Value;
                    ODepositRes.ResultMessage = resResultMessage.IsNull ? "" : resResultMessage.Value;

                    if (ODepositRes.ResultCode == 0)
                    {

                        OracleDecimal resdptid = (OracleDecimal)cmd.Parameters["p_dpt_id"].Value;
                        ODepositRes.DptId = resdptid.IsNull ? -1 : resdptid.Value;

                        OracleDecimal resrate = (OracleDecimal)cmd.Parameters["p_rate"].Value;
                        ODepositRes.rate = resrate.IsNull ? -1 : resrate.Value;

                        OracleDecimal resblkd = (OracleDecimal)cmd.Parameters["p_blkd"].Value;
                        ODepositRes.blkd = resblkd.IsNull ? -1 : Convert.ToInt16(resblkd.Value);

                        OracleDecimal resblkk = (OracleDecimal)cmd.Parameters["p_blkk"].Value;
                        ODepositRes.blkk = resblkk.IsNull ? -1 : Convert.ToInt16(resblkk.Value);

                        OracleString resnls = (OracleString)cmd.Parameters["p_nls"].Value;
                        ODepositRes.nls = resnls.IsNull ? "" : resnls.Value;

                        OracleString resnlsint = (OracleString)cmd.Parameters["p_nlsint"].Value;
                        ODepositRes.nlsint = resnlsint.IsNull ? "" : resnlsint.Value;

                        OracleString resdaos = (OracleString)cmd.Parameters["p_daos"].Value;
                        ODepositRes.daos = resdaos.IsNull ? "" : resdaos.Value;

                        OracleString resdate_begin = (OracleString)cmd.Parameters["p_dat_begin"].Value;
                        ODepositRes.dat_begin = resdate_begin.IsNull ? "" : resdate_begin.Value;

                        OracleString resdate_end = (OracleString)cmd.Parameters["p_dat_end"].Value;
                        ODepositRes.dat_end = resdate_end.IsNull ? "" : resdate_end.Value;

                        OracleString resdkbo_num = (OracleString)cmd.Parameters["p_dkbo_num"].Value;
                        ODepositRes.dkbo_num = resdkbo_num.IsNull ? "" : resdkbo_num.Value;

                        OracleString resdkbo_in = (OracleString)cmd.Parameters["p_dkbo_in"].Value;
                        ODepositRes.dkbo_in = resdkbo_in.IsNull ? "" : resdkbo_in.Value;

                        OracleString resdkbo_out = (OracleString)cmd.Parameters["p_dkbo_out"].Value;
                        ODepositRes.dkbo_out = resdkbo_out.IsNull ? "" : resdkbo_out.Value;
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
                                        null, null, 11111111, 0, con);
                                    break;
                                case 2: // 2(депозит на імя малолітньої особи); 
                                    dpt_agreement = DepositAgreement.Create(dpt_id, 12, DepositParams.Rnk,
                                       RNK, null, null, null, DepositParams.Datbegin, Convert.ToDateTime(ODepositRes.dat_end, XRMIntegrationUtl.CXRMinfo()),
                                       null, null, 11111111, 0, con);
                                    dpt_agreement = DepositAgreement.Create(dpt_id, 26, DepositParams.Rnk,
                                       RNK, null, null, null, DepositParams.Datbegin, Convert.ToDateTime(ODepositRes.dat_end, XRMIntegrationUtl.CXRMinfo()),
                                       null, null, 11111111, 0, con);
                                    break;
                                case 3: //3(депозит на користь малолітньої особи);
                                    dpt_agreement = DepositAgreement.Create(dpt_id, 26, DepositParams.Rnk,
                                       DepositParams.RNKInfant, null, null, null, DepositParams.Datbegin, Convert.ToDateTime(ODepositRes.dat_end, XRMIntegrationUtl.CXRMinfo()),
                                       null, null, 11111111, 0, con);
                                    dpt_agreement = DepositAgreement.Create(dpt_id, 27, DepositParams.Rnk,
                                       DepositParams.RNKTrustee, null, null, null, DepositParams.Datbegin, Convert.ToDateTime(ODepositRes.dat_end, XRMIntegrationUtl.CXRMinfo()),
                                       null, null, 11111111, 0, con);
                                    break;
                                case 4: //4(відкритий по довіреності) 
                                    decimal commisrequest = Tools.CreateCommisRequest(dpt_id, 12);
                                    dpt_agreement = DepositAgreement.Create(dpt_id, 12, DepositParams.Rnk,
                                        DepositParams.RNKTrustee, null, null, null, DepositParams.Datbegin, Convert.ToDateTime(ODepositRes.dat_end, XRMIntegrationUtl.CXRMinfo()),
                                        null, commisrequest, 11111111, 0, con);
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
            }
        }
        #endregion

        #region DptRequest
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
            using (MemoryStream outputMemStream = new MemoryStream())
            {
                using (ZipOutputStream zipStream = new ZipOutputStream(outputMemStream))
                {
                    zipStream.SetLevel(6); //0-9, 9 being the highest level of compression
                    byte[] bytes = null;

                    var newEntry = new ZipEntry("req_id_" + req_id + ".pdf");
                    newEntry.DateTime = DateTime.Now;

                    zipStream.PutNextEntry(newEntry);
                    bytes = CreateFile(req_id, req_type);

                    using (MemoryStream inStream = new MemoryStream(bytes))
                    {
                        StreamUtils.Copy(inStream, zipStream, new byte[4096]);
                    }
                }
                return outputMemStream.ToArray();
            }
        }
        public static XRMDptRequestRes RequestCreate(OracleConnection con, XRMDptRequestReq DptRequestReq)
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

            DptRequest.Save(DptRequestReq.req_type, DptRequestReq.TrusteeType, DptRequestReq.cust_id, DptRequestReq.CertifNum, DptRequestReq.CertifDate, DptRequestReq.DateStart, DptRequestReq.DateFinish, con);

            DptRequestRes.req_id = DptRequest.ID;
            DptRequestRes.Doc = Convert.ToBase64String(GetFileForPrint(DptRequestRes.req_id, DptRequestReq.req_type));
            return DptRequestRes;
        }
        public static XRMDptRequestStateRes GetRequestState(XRMDptRequestStateReq XRMDptRequestStateReq, OracleConnection con)
        {
            XRMDptRequestStateRes XRMDptRequestStateRes = new XRMDptRequestStateRes();
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "select req_state, comments from bars.cust_requests where req_id = :req_id";
                cmd.BindByName = true;
                cmd.Parameters.Add("req_id", OracleDbType.Decimal, XRMDptRequestStateReq.req_id, ParameterDirection.Input);

                using (OracleDataReader reader = cmd.ExecuteReader())
                {
                    try
                    {
                        if (reader.HasRows)
                        {
                            int idstate = reader.GetOrdinal("req_state");
                            int idcomments = reader.GetOrdinal("comments");
                            while (reader.Read())
                            {
                                XRMDptRequestStateRes.RequestState = Convert.ToDecimal(OracleHelper.GetDecimalString(reader, idstate, "0"));
                                XRMDptRequestStateRes.RequestMessage = Convert.ToString(OracleHelper.GetString(reader, idcomments));
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
                }
            }
            return XRMDptRequestStateRes;
        }
        #endregion

        #region EarlyClose
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
                        XRMEarlyCloseRes.DepositSumToPay = DepositAgreement.GetAllowedAmount(con, dpt.ID, XRMEarlyCloseReq.RNK);
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
                        OracleDataReader rdr = null;
                        using (rdr = cmdtts_deposit.ExecuteReader())
                        {
                            int tt_n = 0;
                            XrmDepositTTS[] XrmDepositTTSSet = new XrmDepositTTS[1];
                            while (rdr.Read())
                            {
                                if (!rdr.IsDBNull(0))
                                {
                                    XrmDepositTTS XrmDepositTTSd = new XrmDepositTTS();
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
                            XrmDepositTTS[] XrmDepositTTSSetp = new XrmDepositTTS[0];
                            while (rdr.Read())
                            {
                                if (!rdr.IsDBNull(0))
                                {
                                    XrmDepositTTS XrmDepositTTSp = new XrmDepositTTS();
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
        #endregion

        #region DepositFiles
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

        #endregion

        #region DPTPortfolio
        public static XRMDPTPortfolioRec[] GetPortfolio(decimal RNK, OracleConnection con)
        {
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Clear();
                cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, RNK, ParameterDirection.Input);
                cmd.CommandText = @"select mark, dpt_id, dpt_num, archdoc_id,type_name,datz,dat_end,nls,lcv,dpt_lock,ostc,ost_int from table(dpt_views.get_portfolio_all(:p_rnk))";
                using (OracleDataReader rdr = cmd.ExecuteReader())
                {
                    List<XRMDPTPortfolioRec> DPTPortfolioRecSet = new List<XRMDPTPortfolioRec>();
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

                            XRMDPTPortfolioRec.mark = OracleHelper.GetString(rdr, markid);
                            XRMDPTPortfolioRec.dpt_id = Convert.ToDecimal(OracleHelper.GetDecimalString(rdr, dptidid, "0"));
                            XRMDPTPortfolioRec.dpt_num = OracleHelper.GetString(rdr, dptnumid);
                            XRMDPTPortfolioRec.archdoc_id = Convert.ToDecimal(OracleHelper.GetDecimalString(rdr, archid, "0"));
                            XRMDPTPortfolioRec.type_name = OracleHelper.GetString(rdr, type_nameid);
                            XRMDPTPortfolioRec.datz = Convert.ToDateTime(OracleHelper.GetDateTimeString(rdr, datzid, "dd.MM.yyyy"));
                            XRMDPTPortfolioRec.dat_end = Convert.ToDateTime(OracleHelper.GetDateTimeString(rdr, dat_endid, "dd.MM.yyyy"));
                            XRMDPTPortfolioRec.nls = OracleHelper.GetString(rdr, nlsid);
                            XRMDPTPortfolioRec.lcv = OracleHelper.GetString(rdr, lcvid);
                            XRMDPTPortfolioRec.ostc = Convert.ToDecimal(OracleHelper.GetDecimalString(rdr, ostcid, "0.00"));
                            XRMDPTPortfolioRec.ost_int = Convert.ToDecimal(OracleHelper.GetDecimalString(rdr, ost_intid, "0.00"));

                            DPTPortfolioRecSet.Add(XRMDPTPortfolioRec);
                        }
                        return DPTPortfolioRecSet.ToArray();
                    }
                    else
                        return new XRMDPTPortfolioRec[] { };
                }
            }
        }
        #endregion

        #region DepositProduct
        public static XRMDepositProduct[] GetDepositProducts(OracleConnection con)
        {
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = @"SELECT type_id, 
                                           type_name, 
                                            type_code, 
                                            fl_active, 
                                            fl_demand, 
                                            fl_webbanking,
                                            vidd, 
                                            kv, 
                                            vidd_name, 
                                            duration, 
                                            duration_days, 
                                            LIMIT, 
                                            freq_k, 
                                            dubl
                                    FROM TABLE (dpt_views.get_dpt_products)";
                using (OracleDataReader rdr = cmd.ExecuteReader())
                {
                    List<XRMDepositProduct> DepositProducts = new List<XRMDepositProduct>();
                    if (rdr.Read())
                    {
                        int type_idid = rdr.GetOrdinal("type_id"),
                            type_nameid = rdr.GetOrdinal("type_name"),
                            type_codeid = rdr.GetOrdinal("type_code"),
                            fl_activeid = rdr.GetOrdinal("fl_active"),
                            fl_demandid = rdr.GetOrdinal("fl_demand"),
                            fl_webbankingid = rdr.GetOrdinal("fl_webbanking"),
                            viddid = rdr.GetOrdinal("vidd"),
                            kvid = rdr.GetOrdinal("kv"),
                            vidd_nameid = rdr.GetOrdinal("vidd_name"),
                            durationid = rdr.GetOrdinal("duration"),
                            duration_daysid = rdr.GetOrdinal("duration_days"),
                            LIMITid = rdr.GetOrdinal("LIMIT"),
                            freq_kid = rdr.GetOrdinal("freq_k"),
                            dublid = rdr.GetOrdinal("dubl");

                        while (rdr.Read())
                        {
                            XRMDepositProduct XRMDepositProduct = new XRMDepositProduct();

                            XRMDepositProduct.type_id = Convert.ToInt32(OracleHelper.GetDecimalString(rdr, type_idid, "0"));
                            XRMDepositProduct.type_name = OracleHelper.GetString(rdr, type_nameid);
                            XRMDepositProduct.type_code = OracleHelper.GetString(rdr, type_codeid);
                            XRMDepositProduct.fl_active = OracleHelper.GetString(rdr, fl_activeid);
                            XRMDepositProduct.fl_demand = OracleHelper.GetString(rdr, fl_demandid);
                            XRMDepositProduct.fl_webbanking = OracleHelper.GetString(rdr, fl_webbankingid);
                            XRMDepositProduct.vidd = Convert.ToInt32(OracleHelper.GetDecimalString(rdr, viddid, "0"));
                            XRMDepositProduct.kv = Convert.ToInt32(OracleHelper.GetDecimalString(rdr, kvid, "0"));
                            XRMDepositProduct.vidd_name = OracleHelper.GetString(rdr, vidd_nameid);
                            XRMDepositProduct.duration = Convert.ToInt16(OracleHelper.GetDecimalString(rdr, durationid, "0"));
                            XRMDepositProduct.duration_days = Convert.ToInt16(OracleHelper.GetDecimalString(rdr, duration_daysid, "0"));
                            XRMDepositProduct.LIMIT = OracleHelper.GetString(rdr, LIMITid);
                            XRMDepositProduct.freq_k = OracleHelper.GetString(rdr, freq_kid);
                            XRMDepositProduct.dubl = OracleHelper.GetString(rdr, dublid);

                            DepositProducts.Add(XRMDepositProduct);
                        }
                        return DepositProducts.ToArray();
                    }
                    else
                        return null;
                }
            }
        }
        #endregion

        #region BackOffice
        private static XmlDocument GetXML(AccessList[] AccessList)
        {
            XmlDocument XmlDoc = new XmlDocument();
            XmlNode p_root = XmlDoc.CreateElement("AccessInfo");
            XmlDoc.AppendChild(p_root);

            for (int i = 0; i < AccessList.Length; i++)
            {
                XmlNode p_row = XmlDoc.CreateElement("row");
                p_root.AppendChild(p_row);

                XmlNode ContractID = XmlDoc.CreateElement("ContractID");
                ContractID.InnerText = AccessList[i].DepositId.ToString();
                p_row.AppendChild(ContractID);

                XmlNode Amount = XmlDoc.CreateElement("Amount");
                Amount.InnerText = AccessList[i].Amount.ToString("########0.00##");
                p_row.AppendChild(Amount);

                XmlNode Flags = XmlDoc.CreateElement("Flags");
                Flags.InnerText = AccessList[i].Fl_Report.ToString() + AccessList[i].Fl_Money.ToString() +
                    AccessList[i].Fl_Early.ToString() + AccessList[i].Fl_Agreement.ToString() + AccessList[i].Fl_Kv.ToString();
                p_row.AppendChild(Flags);
            }
            return XmlDoc;
        }

        public static AccessRequestRes CreateAccessRequestProc(OracleConnection con, AccessRequestReq req)
        {
            AccessRequestRes res = new AccessRequestRes();
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "ebp.create_access_request";
                cmd.BindByName = true;

                cmd.Parameters.Add("p_type", OracleDbType.Decimal, req.Type, ParameterDirection.Input);
                cmd.Parameters.Add("p_trustee", OracleDbType.Varchar2, req.TrusteeType, ParameterDirection.Input);
                cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, req.Rnk, ParameterDirection.Input);
                cmd.Parameters.Add("p_cert_num", OracleDbType.Varchar2, req.CertifNumber, ParameterDirection.Input);
                cmd.Parameters.Add("p_cert_date", OracleDbType.Date, req.CertifDate, ParameterDirection.Input);
                cmd.Parameters.Add("p_date_start", OracleDbType.Date, req.StartDate, ParameterDirection.Input);
                cmd.Parameters.Add("p_date_finish", OracleDbType.Date, req.FinishDate, ParameterDirection.Input);
                cmd.Parameters.Add("p_access_info", OracleDbType.XmlType, GetXML(req.AccessList).InnerXml, ParameterDirection.Input);

                cmd.Parameters.Add("p_reqid", OracleDbType.Decimal, res.ReqId, ParameterDirection.Output);

                cmd.ExecuteNonQuery();

                OracleDecimal req_id = (OracleDecimal)cmd.Parameters["p_reqid"].Value;
                res.ReqId = req_id.IsNull ? -1 : req_id.Value;
            }
            return res;
        }

        public static BackOfficeGetAccessRes BackOfficeProc(OracleConnection con, BackOfficeGetAccessReq req)
        {
            BackOfficeGetAccessRes res = new BackOfficeGetAccessRes();
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.Parameters.Clear();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "XRM_INTEGRATION_OE.request_forbackoff";
                cmd.BindByName = true;

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("p_transactionid", OracleDbType.Decimal, req.TransactionId, ParameterDirection.Input);
                cmd.Parameters.Add("p_trustee", OracleDbType.Varchar2, req.TrusteeType, ParameterDirection.Input);
                cmd.Parameters.Add("p_req_id", OracleDbType.Decimal, req.Req_id, ParameterDirection.Input);
                cmd.Parameters.Add("p_req_type", OracleDbType.Decimal, req.Req_type, ParameterDirection.Input);
                cmd.Parameters.Add("p_cust_id", OracleDbType.Decimal, req.Cust_id, ParameterDirection.Input);
                cmd.Parameters.Add("p_scaccess", OracleDbType.Clob, req.ScAccess, ParameterDirection.Input);
                cmd.Parameters.Add("p_scwarrant", OracleDbType.Clob, req.ScWarrant, ParameterDirection.Input);
                cmd.Parameters.Add("p_scsignscard", OracleDbType.Clob, req.ScSignsCard, ParameterDirection.Input);
                OracleParameter param = new OracleParameter("p_depositlist", OracleDbType.Array, req.Deposits.Length, (Bars.Oracle.NumberList)req.Deposits, ParameterDirection.Input) { UdtTypeName = "NUMBER_LIST", Value = req.Deposits };
                cmd.Parameters.Add(param);

                cmd.Parameters.Add("resultcode", OracleDbType.Decimal, res.ResultCode, ParameterDirection.Output);
                cmd.Parameters.Add("resultmessage", OracleDbType.Varchar2, res.ResultMessage, ParameterDirection.Output);

                cmd.ExecuteNonQuery();

                OracleDecimal resultCode = (OracleDecimal)cmd.Parameters["resultcode"].Value;
                res.ResultCode = resultCode.IsNull ? -1 : resultCode.Value;

                OracleString resultMessage = (OracleString)cmd.Parameters["resultmessage"].Value;
                res.ResultMessage = resultMessage.IsNull ? "" : resultMessage.Value;

                return res;
            }
        }

        public static BackOfficeGetStateProcRes BackOfficeGetStateProc(OracleConnection con, BackOfficeGetStateProcReq req)
        {
            BackOfficeGetStateProcRes res = new BackOfficeGetStateProcRes();
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "XRM_INTEGRATION_OE.request_frombackoff";
                cmd.BindByName = true;

                cmd.Parameters.Add("p_req_id", OracleDbType.Decimal, req.ReqId, ParameterDirection.Input);
                cmd.Parameters.Add("resultstate", OracleDbType.Decimal, res.State, ParameterDirection.Output);
                cmd.Parameters.Add("result_comments", OracleDbType.Varchar2, res.Comment, ParameterDirection.Output);
                cmd.ExecuteNonQuery();

                OracleDecimal state = (OracleDecimal)cmd.Parameters["resultstate"].Value;
                res.State = state.IsNull ? (Decimal?)null : state.Value;

                OracleString comment = (OracleString)cmd.Parameters["result_comments"].Value;
                if (!comment.IsNull)
                    res.Comment = comment.Value;

                res.ResultMessage = "Статус запиту: ";

                Int32? flag = (Int32?)res.State;
                switch (flag)
                {
                    case null: res.ResultMessage += "не оброблений"; break;
                    case -1: res.ResultMessage += "відхилений"; break;
                    case 0: res.ResultMessage += "новий"; break;
                    case 1: res.ResultMessage += "оброблений"; break;
                    case 2: res.ResultMessage += "анульований"; break;
                    default: res.ResultMessage = "Немає даних по цьому запиту"; break;
                }
            }
            return res;
        }
        #endregion

        #region Common
        /*зіпування файлу в base64*/
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

                        return outputMemStream;
                    }
                }
            }
        }
        #endregion
    }
}
