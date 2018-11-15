using System;
using System.Data;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Collections.Generic;
using System.IO;
using System.Xml;
using ICSharpCode.SharpZipLib.Zip;
using ICSharpCode.SharpZipLib.Core;
using Bars.WebServices.XRM.Services.DepositXrm.Models;
using ibank.core;
using Bars.EAD;
using Bars.Requests;
using Bars.WebServices.XRM.Models;
using System.Text;

namespace Bars.WebServices.XRM.Services.DepositXrm
{
    public static class DepositWorker
    {
        #region DepositAgreement

        #region CreateDocument
        public static Account TransferDPT;          // параметры возврата депозита
        public static Account TransferINT;          // параметры выплаты процентов       

        private static XmlDocument _p_doc;
        public static XmlDocument p_doc
        {
            get
            {
                if (_p_doc == null)
                {
                    _p_doc = CreateXmlDoc(TransferDPT.Nls, TransferDPT.Mfo, TransferDPT.Okpo, TransferDPT.Nmk, null);
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
                    _d_doc = CreateXmlDoc(TransferINT.Nls, TransferINT.Mfo, TransferINT.Okpo, TransferINT.Nmk, null);
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
        private static int GetEaStructIdByTypeId(short typeId)
        {
            switch (typeId)
            {
                case 1: // основной договор
                    return 212;
                case 101: // осн.дог на бенеф
                    return 212;
                case 99: // тут анкета финмониторинга
                    return 212;
                // тут будут все додугоды
                case 7:
                    return 222;
                case 8:
                    return 223;
                case 9:
                    return 226;
                case 12:
                    return 222;
                case 13:
                    return 225;
                case 18:
                    return 211;
                default:
                    return 213;
            }
        }
        public static XRMResponseDetailed<AdditionalAgreementResponse> GetDepositAdditionalAgreement(OracleConnection con, XRMRequest<AdditionalAgreementRequest> Request)
        {
            string _kf = Request.AdditionalData.Kf;

            EadPack ep = new EadPack(new BbConnection());
            List<FrxParameter> frx_additional_params = new List<FrxParameter>();
            frx_additional_params.Add(new FrxParameter("p_agrmnt_id", TypeCode.Int64, Request.AdditionalData.AgrId.AddRuTail(_kf)));
            decimal? _DocId = null;
            byte[] bytes = null;

            int EAStructID = GetEaStructIdByTypeId(Request.AdditionalData.TypeId);
            string TemplateID = getDocTemplate(Request.AdditionalData.TypeId, Request.AdditionalData.DptId.AddRuTail(_kf));

            if (EAStructID != -1)
                _DocId = ep.DOC_CREATE("DOC", TemplateID, null, EAStructID, Request.AdditionalData.Rnk.AddRuTail(_kf), Request.AdditionalData.DptId.AddRuTail(_kf));


            string outfilename = TemplateID;
            // печатаем документ
            FrxParameters pars = new FrxParameters();
            if (_DocId != null)
            {
                pars.Add(new FrxParameter("p_doc_id", TypeCode.Int64, Convert.ToInt64(_DocId.Value.ToString())));
            }

            if (Request.AdditionalData.Rnk != null)
            {
                pars.Add(new FrxParameter("p_rnk", TypeCode.Int64, Request.AdditionalData.Rnk.AddRuTail(_kf)));
                outfilename += "_RNK" + Request.AdditionalData.Rnk;
            }
            if (Request.AdditionalData.AgrId != null)
            {
                pars.Add(new FrxParameter("p_agr_id", TypeCode.Int64, Request.AdditionalData.AgrId.AddRuTail(_kf)));
                outfilename += "_AGRID" + Request.AdditionalData.AgrId;
            }

            outfilename += "_DPTID" + Request.AdditionalData.DptId;
            // дополнительные параметры
            foreach (FrxParameter par in frx_additional_params)
                pars.Add(par);
            FrxDoc doc = new FrxDoc(FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(TemplateID)), pars, null);

            using (MemoryStream ms = new MemoryStream())
            {
                doc.ExportToMemoryStream(FrxExportTypes.Pdf, ms);
                bytes = ms.ToArray();
            }

            return new XRMResponseDetailed<AdditionalAgreementResponse>
            {
                Results = new AdditionalAgreementResponse()
                {
                    Doc = Convert.ToBase64String(GetZipFile(bytes, outfilename).ToArray()),
                    DocId = _DocId.CutRuTail()
                }
            };
        }
        public static string getDocTemplate(Int16 typeId, Int64? dptId)
        {
            string template = String.Empty;
            if (typeId != 99)
            {
                using (OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                using (OracleCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = "select dvc.id_fr id from dpt_deposit d, dpt_vidd_scheme dvc where d.deposit_id = :p_deposit_id and dvc.vidd = d.vidd and dvc.flags = :p_flags";
                    cmd.Parameters.Add("p_deposit_id", OracleDbType.Decimal, dptId, ParameterDirection.Input);
                    cmd.Parameters.Add("p_flags", OracleDbType.Decimal, typeId, ParameterDirection.Input);

                    using (OracleDataReader rdr_findtemplate = cmd.ExecuteReader())
                    {
                        if (rdr_findtemplate.Read())
                        {
                            template = Convert.ToString(rdr_findtemplate["id"]);
                        }
                        else
                        {
                            throw new System.Exception(string.Format("Не знайдено шаблон {0} у таблиці doc_scheme, або шаблон не описано як FastReport", template));
                        }
                    }
                }
            }
            else
            {
                template = "DPT_FINMON_QUESTIONNAIRE";
            }
            return template;
        }

        public static XRMResponseDetailed<DepositAgreementRsponse> ProcDepositAgreement(OracleConnection con, XRMRequest<DepositAgreementRequest> Request)
        {
            XRMResponseDetailed<DepositAgreementRsponse> res = new XRMResponseDetailed<DepositAgreementRsponse> { Results = new DepositAgreementRsponse() };

            using (OracleCommand cmd = con.CreateCommand())
            {
                string TransferDPT = "";
                string TransferINT = "";
                if (global::Deposit.InheritedDeal(Convert.ToString(Request.AdditionalData.DptId), con))
                {
                    res.ResultCode = -1;
                    res.ResultMessage = "По депозитному договору є зареєстровані спадкоємці. Дана функція заблокована.";
                }
                else
                {
                    Request.AdditionalData.Denomcount = "11111111";
                    if (Request.AdditionalData.DATrusteeOpt != null && Request.AdditionalData.AgreementType == 12)
                    {
                        Request.AdditionalData.Denomcount = Request.AdditionalData.DATrusteeOpt.ToString();
                    }

                    if (Request.AdditionalData.AgreementType == 11 || Request.AdditionalData.AgreementType == 20 || Request.AdditionalData.AgreementType == 28)
                    {
                        if (Request.AdditionalData.TransferDPT != null) // реквізити для виплати депозиту                        
                        {
                            XmlDocument d_doc = CreateXmlDoc(Request.AdditionalData.TransferDPT.Nls, Request.AdditionalData.TransferDPT.Mfo, Request.AdditionalData.TransferDPT.Okpo, Request.AdditionalData.TransferDPT.Nmk, null);
                            TransferDPT = d_doc.InnerXml;
                        }

                        if (Request.AdditionalData.TransferINT != null) // реквізити для виплати відсотків
                        {
                            XmlDocument p_doc = CreateXmlDoc(Request.AdditionalData.TransferINT.Nls, Request.AdditionalData.TransferINT.Mfo, Request.AdditionalData.TransferINT.Okpo, Request.AdditionalData.TransferINT.Nmk, null);
                            TransferINT = p_doc.InnerXml;
                        }
                    }

                    cmd.BindByName = true;
                    cmd.Parameters.Clear();
                    cmd.CommandText = "bars.xrm_integration_oe.CreateDepositAgreement";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("p_TransactionID", OracleDbType.Decimal, Request.TransactionId, ParameterDirection.Input);
                    cmd.Parameters.Add("P_DPTID", OracleDbType.Decimal, Request.AdditionalData.DptId, ParameterDirection.Input);
                    cmd.Parameters.Add("P_AGRMNTTYPE", OracleDbType.Decimal, Request.AdditionalData.AgreementType, ParameterDirection.Input);
                    cmd.Parameters.Add("P_INITCUSTID", OracleDbType.Decimal, Request.AdditionalData.InitCustid, ParameterDirection.Input);
                    cmd.Parameters.Add("P_TRUSTCUSTID", OracleDbType.Decimal, Request.AdditionalData.TrustCustid, ParameterDirection.Input);
                    cmd.Parameters.Add("p_trustid", OracleDbType.Decimal, Request.AdditionalData.Trustid, ParameterDirection.Input);

                    cmd.Parameters.Add("P_DENOMCOUNT", OracleDbType.Varchar2, 20, Request.AdditionalData.Denomcount, ParameterDirection.Input);
                    cmd.Parameters.Add("p_transferdpt", OracleDbType.Clob, 400, TransferDPT, ParameterDirection.Input);
                    cmd.Parameters.Add("p_transferint", OracleDbType.Clob, 400, TransferINT, ParameterDirection.Input);
                    cmd.Parameters.Add("p_datbegin", OracleDbType.Date, XrmHelper.GmtToLocal(Request.AdditionalData.DateBegin), ParameterDirection.Input);
                    cmd.Parameters.Add("p_datend", OracleDbType.Date, XrmHelper.GmtToLocal(Request.AdditionalData.DateEnd), ParameterDirection.Input);

                    // ***
                    cmd.Parameters.Add("p_amountcash", OracleDbType.Decimal, Request.AdditionalData.Amountcash, ParameterDirection.Input);
                    cmd.Parameters.Add("p_amountcashless", OracleDbType.Decimal, Request.AdditionalData.Amountcashless, ParameterDirection.Input);
                    cmd.Parameters.Add("p_ratereqid", OracleDbType.Decimal, Request.AdditionalData.RateReqId, ParameterDirection.Input);
                    cmd.Parameters.Add("p_ratevalue", OracleDbType.Decimal, Request.AdditionalData.RateValue, ParameterDirection.Input);
                    cmd.Parameters.Add("p_ratedate", OracleDbType.Date, XrmHelper.GmtToLocal(Request.AdditionalData.RateDate), ParameterDirection.Input);
                    cmd.Parameters.Add("p_denomamount", OracleDbType.Decimal, Request.AdditionalData.DenomAmount, ParameterDirection.Input);
                    cmd.Parameters.Add("p_denomref", OracleDbType.Decimal, Request.AdditionalData.DenomRef, ParameterDirection.Input);
                    cmd.Parameters.Add("p_docref", OracleDbType.Decimal, Request.AdditionalData.DocRef, ParameterDirection.Input);
                    cmd.Parameters.Add("p_freq", OracleDbType.Decimal, Request.AdditionalData.Frequency, ParameterDirection.Input);

                    cmd.Parameters.Add("p_comissref", OracleDbType.Decimal, Request.AdditionalData.ComissRef, ParameterDirection.Input);
                    cmd.Parameters.Add("p_comissreqid", OracleDbType.Decimal, Request.AdditionalData.ComissReqId, ParameterDirection.Input);
                    cmd.Parameters.Add("P_AGRMNTID", OracleDbType.Decimal, null, ParameterDirection.Output);
                    cmd.Parameters.Add("p_ERRORMESSAGE", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                    cmd.ExecuteNonQuery();

                    OracleString ressign = (OracleString)cmd.Parameters["p_ERRORMESSAGE"].Value;
                    res.ResultMessage = ressign.IsNull ? "" : ressign.Value;

                    OracleDecimal resarchdoc = (OracleDecimal)cmd.Parameters["P_AGRMNTID"].Value;
                    res.Results.AgrementId = resarchdoc.IsNull ? -1 : resarchdoc.Value;

                    if (res.Results.AgrementId == -1) res.ResultCode = -1;
                }
                return res;
            }
        }
        #endregion

        #region OpenDeposit
        public static DocumentSignResult ProcDocSign(DepositDocument DepositDoc, OracleConnection con)
        {
            DocumentSignResult ODepositDocRes = new DocumentSignResult();
            ODepositDocRes.ArchiveDocumentId = DepositDoc.DepositId;
            ODepositDocRes.ResultCode = 0;
            ODepositDocRes.ResultMessage = string.Empty;

            using (OracleCommand cmd = con.CreateCommand())
            {
                try
                {
                    cmd.CommandText = "bars.xrm_integration_oe.sign_deposit_doc";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("p_TransactionID", OracleDbType.Decimal, DepositDoc.TransactionId, ParameterDirection.Input);
                    cmd.Parameters.Add("p_archdoc_id", OracleDbType.Decimal, DepositDoc.DepositId, ParameterDirection.InputOutput);
                    cmd.Parameters.Add("p_ERRORMESSAGE", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                    cmd.ExecuteNonQuery();

                    OracleString ressign = (OracleString)cmd.Parameters["p_ERRORMESSAGE"].Value;
                    ODepositDocRes.ResultMessage = ressign.IsNull ? "" : ressign.Value;

                    OracleDecimal resarchdoc = (OracleDecimal)cmd.Parameters["p_archdoc_id"].Value;
                    ODepositDocRes.ArchiveDocumentId = resarchdoc.IsNull ? -1 : resarchdoc.Value;

                    return ODepositDocRes;
                }
                catch (System.Exception e)
                {
                    ODepositDocRes.ResultCode = -1;
                    ODepositDocRes.ResultMessage = string.Format("Помилка підпису депозитного договору: {0}", e.Message);
                    return ODepositDocRes;
                }
            }
        }

        public static XRMResponseDetailed<OpenDepositResponse> OpenDeposit(OracleConnection con, XRMRequest<OpenDepositRequest> Request)
        {
            XRMResponseDetailed<OpenDepositResponse> response = new XRMResponseDetailed<OpenDepositResponse> { Results = new OpenDepositResponse() };
            OpenDepositResponse ODepositRes = new OpenDepositResponse { Agreements = new List<DepositAgreementAddInfo>() };

            using (OracleCommand cmd = con.CreateCommand())
            {
                Int64 RNK = Request.AdditionalData.Rnk;
                if (Request.AdditionalData.DepositType == 2 && Request.AdditionalData.RnkInfant > 0)
                {
                    Request.AdditionalData.Rnk = Request.AdditionalData.RnkInfant;
                    Request.AdditionalData.RnkTrustee = RNK;
                }

                // открываем депозитный договор
                #region DON'T OPEN !
                cmd.CommandText = "bars.xrm_integration_oe.open_deposit";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("p_TransactionID", OracleDbType.Decimal, Request.TransactionId, ParameterDirection.Input);
                cmd.Parameters.Add("p_KF", OracleDbType.Varchar2, Request.AdditionalData.Kf, ParameterDirection.Input);
                cmd.Parameters.Add("p_branch", OracleDbType.Varchar2, Request.AdditionalData.Branch, ParameterDirection.Input);
                cmd.Parameters.Add("p_vidd", OracleDbType.Decimal, Request.AdditionalData.Vidd, ParameterDirection.Input);
                cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, Request.AdditionalData.Rnk, ParameterDirection.Input);
                cmd.Parameters.Add("p_nd", OracleDbType.Varchar2, 1, ParameterDirection.Input);
                cmd.Parameters.Add("p_sum", OracleDbType.Decimal, Request.AdditionalData.Sum, ParameterDirection.Input);
                cmd.Parameters.Add("p_nocash", OracleDbType.Int16, Request.AdditionalData.Nocash, ParameterDirection.Input);
                cmd.Parameters.Add("p_datz", OracleDbType.Date, XrmHelper.GmtToLocal(Request.AdditionalData.DateZ), ParameterDirection.Input);
                cmd.Parameters.Add("p_namep", OracleDbType.Varchar2, Request.AdditionalData.Namep, ParameterDirection.Input);
                cmd.Parameters.Add("p_okpop", OracleDbType.Varchar2, Request.AdditionalData.Okpop, ParameterDirection.Input);
                cmd.Parameters.Add("p_nlsp", OracleDbType.Varchar2, Request.AdditionalData.Nlsp, ParameterDirection.Input);
                cmd.Parameters.Add("p_mfop", OracleDbType.Varchar2, Request.AdditionalData.Mfop, ParameterDirection.Input);
                cmd.Parameters.Add("p_fl_perekr", OracleDbType.Varchar2, Request.AdditionalData.FlPerekr, ParameterDirection.Input);
                cmd.Parameters.Add("p_name_perekr", OracleDbType.Varchar2, Request.AdditionalData.NamePerekr, ParameterDirection.Input);
                cmd.Parameters.Add("p_okpo_perekr", OracleDbType.Varchar2, Request.AdditionalData.OkpoPerekr, ParameterDirection.Input);
                cmd.Parameters.Add("p_nls_perekr", OracleDbType.Varchar2, Request.AdditionalData.NlsPerekr, ParameterDirection.Input);
                cmd.Parameters.Add("p_mfo_perekr", OracleDbType.Varchar2, Request.AdditionalData.MfoPerekr, ParameterDirection.Input);
                cmd.Parameters.Add("p_comment", OracleDbType.Varchar2, Request.AdditionalData.Comment, ParameterDirection.Input);
                cmd.Parameters.Add("p_dpt_id", OracleDbType.Decimal, ODepositRes.DptId, ParameterDirection.Output);
                cmd.Parameters.Add("p_datbegin", OracleDbType.Date, XrmHelper.GmtToLocal(Request.AdditionalData.Datbegin), ParameterDirection.Input);
                cmd.Parameters.Add("p_duration", OracleDbType.Int16, Request.AdditionalData.Duration, ParameterDirection.Input);
                cmd.Parameters.Add("p_duration_days", OracleDbType.Int16, Request.AdditionalData.DurationDays, ParameterDirection.Input);
                cmd.Parameters.Add("p_rate", OracleDbType.Decimal, ODepositRes.Rate, ParameterDirection.Output);
                cmd.Parameters.Add("p_nls", OracleDbType.Varchar2, 15, ODepositRes.Nls, ParameterDirection.Output);
                cmd.Parameters.Add("p_nlsint", OracleDbType.Varchar2, 15, ODepositRes.NlsInt, ParameterDirection.Output);
                cmd.Parameters.Add("p_daos", OracleDbType.Varchar2, 250, ODepositRes.Daos, ParameterDirection.Output);
                cmd.Parameters.Add("p_dat_begin", OracleDbType.Varchar2, 250, ODepositRes.DateBegin, ParameterDirection.Output);
                cmd.Parameters.Add("p_dat_end", OracleDbType.Varchar2, 250, ODepositRes.DateEnd, ParameterDirection.Output);
                cmd.Parameters.Add("p_blkd", OracleDbType.Int16, ODepositRes.BlkD, ParameterDirection.Output);
                cmd.Parameters.Add("p_blkk", OracleDbType.Int16, ODepositRes.BlkK, ParameterDirection.Output);
                cmd.Parameters.Add("p_dkbo_num", OracleDbType.Varchar2, 50, ODepositRes.DkboNumber, ParameterDirection.Output);
                cmd.Parameters.Add("p_dkbo_in", OracleDbType.Varchar2, 250, ODepositRes.DkboIn, ParameterDirection.Output);
                cmd.Parameters.Add("p_dkbo_out", OracleDbType.Varchar2, 250, ODepositRes.DkboOut, ParameterDirection.Output);
                cmd.Parameters.Add("ResultCode", OracleDbType.Int16, response.ResultCode, ParameterDirection.Output);
                cmd.Parameters.Add("ResultMessage", OracleDbType.Varchar2, 500, response.ResultMessage, ParameterDirection.Output);
                #endregion
                cmd.ExecuteNonQuery();

                OracleDecimal reserrcode = (OracleDecimal)cmd.Parameters["ResultCode"].Value;
                if (!reserrcode.IsNull)
                    response.ResultCode = Convert.ToInt16(reserrcode.Value);

                OracleString resResultMessage = (OracleString)cmd.Parameters["ResultMessage"].Value;
                response.ResultMessage = resResultMessage.IsNull ? "" : resResultMessage.Value;

                if (response.ResultCode == 0)
                {
                    OracleDecimal resdptid = (OracleDecimal)cmd.Parameters["p_dpt_id"].Value;
                    ODepositRes.DptId = resdptid.IsNull ? -1 : resdptid.Value;

                    OracleDecimal resrate = (OracleDecimal)cmd.Parameters["p_rate"].Value;
                    ODepositRes.Rate = resrate.IsNull ? -1 : resrate.Value;

                    OracleDecimal resblkd = (OracleDecimal)cmd.Parameters["p_blkd"].Value;
                    ODepositRes.BlkD = resblkd.IsNull ? -1 : Convert.ToInt16(resblkd.Value);

                    OracleDecimal resblkk = (OracleDecimal)cmd.Parameters["p_blkk"].Value;
                    ODepositRes.BlkK = resblkk.IsNull ? -1 : Convert.ToInt16(resblkk.Value);

                    OracleString resnls = (OracleString)cmd.Parameters["p_nls"].Value;
                    ODepositRes.Nls = resnls.IsNull ? "" : resnls.Value;

                    OracleString resnlsint = (OracleString)cmd.Parameters["p_nlsint"].Value;
                    ODepositRes.NlsInt = resnlsint.IsNull ? "" : resnlsint.Value;

                    OracleString resdaos = (OracleString)cmd.Parameters["p_daos"].Value;
                    ODepositRes.Daos = resdaos.IsNull ? "" : resdaos.Value;

                    OracleString resdate_begin = (OracleString)cmd.Parameters["p_dat_begin"].Value;
                    ODepositRes.DateBegin = resdate_begin.IsNull ? "" : resdate_begin.Value;

                    OracleString resdate_end = (OracleString)cmd.Parameters["p_dat_end"].Value;
                    ODepositRes.DateEnd = resdate_end.IsNull ? "" : resdate_end.Value;

                    OracleString resdkbo_num = (OracleString)cmd.Parameters["p_dkbo_num"].Value;
                    ODepositRes.DkboNumber = resdkbo_num.IsNull ? "" : resdkbo_num.Value;

                    OracleString resdkbo_in = (OracleString)cmd.Parameters["p_dkbo_in"].Value;
                    ODepositRes.DkboIn = resdkbo_in.IsNull ? "" : resdkbo_in.Value;

                    OracleString resdkbo_out = (OracleString)cmd.Parameters["p_dkbo_out"].Value;
                    ODepositRes.DkboOut = resdkbo_out.IsNull ? "" : resdkbo_out.Value;
                }

                if (ODepositRes.DptId != null)
                {
                    decimal dpt_id = (decimal)ODepositRes.DptId.AddRuTail(Request.AdditionalData.Kf);
                    long rnk = Request.AdditionalData.Rnk.AddRuTail(Request.AdditionalData.Kf);
                    long rnkTrustee = Request.AdditionalData.RnkTrustee.AddRuTail(Request.AdditionalData.Kf);
                    long _RNK = RNK.AddRuTail(Request.AdditionalData.Kf);

                    decimal dpt_agreement = 0;

                    // проверки на третьих лиц
                    if (Request.AdditionalData.DepositType != 0)
                    {
                        switch (Request.AdditionalData.DepositType)
                        {
                            case 1: // 1(депозит на бенефіціара);
                                dpt_agreement = DepositAgreement.Create(dpt_id, 5, rnk,
                                    Request.AdditionalData.RnkBeneficiary.AddRuTail(Request.AdditionalData.Kf), null, null, null, Request.AdditionalData.Datbegin, Convert.ToDateTime(ODepositRes.DateEnd, BarsWebService.CXRMinfo()),
                                    null, null, 11111111, 0, con);
                                ODepositRes.Agreements.Add(GetAgrInfo(con, dpt_agreement));
                                break;
                            case 2: // 2(депозит на імя малолітньої особи); 
                                dpt_agreement = DepositAgreement.Create(dpt_id, 12, rnk,
                                   _RNK, null, null, null, Request.AdditionalData.Datbegin, Convert.ToDateTime(ODepositRes.DateEnd, BarsWebService.CXRMinfo()),
                                   null, Tools.CreateCommisRequest(dpt_id, 12), 11111111, 0, con);
                                ODepositRes.Agreements.Add(GetAgrInfo(con, dpt_agreement));
                                dpt_agreement = DepositAgreement.Create(dpt_id, 26, rnk,
                                   _RNK, null, null, null, Request.AdditionalData.Datbegin, Convert.ToDateTime(ODepositRes.DateEnd, BarsWebService.CXRMinfo()),
                                   null, null, 11111111, 0, con);
                                ODepositRes.Agreements.Add(GetAgrInfo(con, dpt_agreement));
                                break;
                            case 3: //3(депозит на користь малолітньої особи);
                                dpt_agreement = DepositAgreement.Create(dpt_id, 26, rnk,
                                   Request.AdditionalData.RnkInfant.AddRuTail(Request.AdditionalData.Kf), null, null, null, Request.AdditionalData.Datbegin, Convert.ToDateTime(ODepositRes.DateEnd, BarsWebService.CXRMinfo()),
                                   null, null, 11111111, 0, con);
                                ODepositRes.Agreements.Add(GetAgrInfo(con, dpt_agreement));
                                dpt_agreement = DepositAgreement.Create(dpt_id, 27, rnk,
                                   rnkTrustee, null, null, null, Request.AdditionalData.Datbegin, Convert.ToDateTime(ODepositRes.DateEnd, BarsWebService.CXRMinfo()),
                                   null, null, 11111111, 0, con);
                                ODepositRes.Agreements.Add(GetAgrInfo(con, dpt_agreement));
                                break;
                            case 4: //4(відкритий по довіреності) 
                                decimal commisrequest = Tools.CreateCommisRequest(dpt_id, 12);
                                dpt_agreement = DepositAgreement.Create(dpt_id, 12, rnk,
                                    rnkTrustee, null, null, null, Request.AdditionalData.Datbegin, Convert.ToDateTime(ODepositRes.DateEnd, BarsWebService.CXRMinfo()),
                                    null, commisrequest, 11111111, 0, con);
                                ODepositRes.Agreements.Add(GetAgrInfo(con, dpt_agreement));
                                break;
                        }
                    }
                }

                response.Results = ODepositRes;
                return response;
            }
        }

        private static DepositAgreementAddInfo GetAgrInfo(OracleConnection con, decimal agrId)
        {
            #region select
            string sql = @"select a.agrmnt_id   AgreementId                           --уникальный номер дс
                                 ,a.agrmnt_type AgreementType                         --тип дс
                                 ,decode((select max(id)
                                    from ead_docs ed
                                   where ed.agr_id = a.dpt_id),null,0,(select max(id)
                                    from ead_docs ed
                                   where ed.agr_id = a.dpt_id)) DocId                 --id последней печатной формы
                                 ,(select dpt.archdoc_id  
                                    from bars.dpt_deposit dpt 
                                   where dpt.deposit_id = a.dpt_id) ArchdocId         --id депозитного договору в еад 
                                 ,a.agrmnt_state  Status                              --статус дс: активн./аннулир.
                                 ,decode((select ed.sign_date 
                                    from bars.ead_docs ed
                                   where ed.id = (select dpt.archdoc_id 
                                                    from bars.dpt_deposit dpt 
                                                   where dpt.deposit_id = a.dpt_id)
                                  ),null,0,1) IsSigned                                --дата відмітки про підписання 
                                 ,a.agrmnt_date  ConclusionDate                       --дата заключения дс (календарная)
                                 ,a.date_begin   DateBegin                            --дата начала действия доверенности 
                                 ,a.date_end     DateEnd                              --дата окончания действия доверенности
                                 ,(select dpt.rnk_tr 
                                     from bars.dpt_trustee dpt 
                                    where dpt.id =a.trustee_id 
                                      and dpt.kf = a.kf ) ClientRNK                   --клиент на которого оформлена дс      
                           from dpt_agreements a
                           where a.agrmnt_id =  :p_agr_id";
            #endregion

            DepositAgreementAddInfo res = new DepositAgreementAddInfo();
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = sql;
                cmd.Parameters.Add(new OracleParameter("p_agr_id", OracleDbType.Decimal, agrId, ParameterDirection.Input));

                using (OracleDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        int _agrId = reader.GetOrdinal("AgreementId");
                        int _agrType = reader.GetOrdinal("AgreementType");
                        int _docId = reader.GetOrdinal("DocId");
                        int _archdocId = reader.GetOrdinal("ArchdocId");
                        int _status = reader.GetOrdinal("Status");
                        int _isSigned = reader.GetOrdinal("IsSigned");
                        int _conclusionDate = reader.GetOrdinal("ConclusionDate");
                        int _dateBegin = reader.GetOrdinal("DateBegin");
                        int _dateEnd = reader.GetOrdinal("DateEnd");
                        int _clientRNK = reader.GetOrdinal("ClientRNK");

                        while (reader.Read())
                        {
                            res.AgreementId = (long)agrId.CutRuTail();
                            res.AgreementType = reader.IsDBNull(_agrType) ? null : (int?)reader.GetInt32(_agrType);
                            res.ArchdocId = reader.IsDBNull(_archdocId) ? null : (long?)reader.GetInt64(_archdocId).CutRuTail();
                            res.ClientRNK = reader.IsDBNull(_clientRNK) ? null : (long?)reader.GetInt64(_clientRNK).CutRuTail();
                            res.ConclusionDate = reader.IsDBNull(_conclusionDate) ? null : (DateTime?)reader.GetDateTime(_conclusionDate);
                            res.DateBegin = reader.IsDBNull(_dateBegin) ? null : (DateTime?)reader.GetDateTime(_dateBegin);
                            res.DateEnd = reader.IsDBNull(_dateEnd) ? null : (DateTime?)reader.GetDateTime(_dateEnd);
                            res.DocId = reader.IsDBNull(_docId) ? null : (long?)reader.GetInt64(_docId);
                            res.Status = reader.IsDBNull(_status) ? null : (int?)reader.GetInt64(_status);
                            res.IsSigned = reader.IsDBNull(_isSigned) ? null : (int?)reader.GetInt64(_isSigned);
                        }
                    }
                }

                return res;
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
        public static XRMResponseDetailed<RequestCreateResponse> RequestCreate(OracleConnection con, XRMRequest<RequestCreateRequest> Request)
        {
            RequestCreateResponse DptRequestRes = new RequestCreateResponse();
            DepositRequest DptRequest;
            // Створення нового запиту без статусу (для друку заяви)         
            DptRequest = 0 == Request.AdditionalData.RequestType ? new DepositRequest() : new DepositRequest(Request.AdditionalData.AccessList);

            string _kf = Request.AdditionalData.Kf;
            DptRequest.Save(
                Request.AdditionalData.RequestType, Request.AdditionalData.TrusteeType, Request.AdditionalData.CustomerId.AddRuTail(_kf),
                Request.AdditionalData.CertificateNumber, Request.AdditionalData.CertificateDate, Request.AdditionalData.DateStart,
                Request.AdditionalData.DateFinish, con);

            DptRequestRes.RequestId = DptRequest.ID;
            DptRequestRes.Doc = Convert.ToBase64String(GetFileForPrint(DptRequestRes.RequestId, Request.AdditionalData.RequestType));

            return new XRMResponseDetailed<RequestCreateResponse>
            {
                Results = DptRequestRes
            };
        }
        //public XRMResponseDetailed<RequestStateResponse> GetRequestState(XRMRequest<RequestStateRequest> Request)
        public static XRMResponseDetailed<RequestStateResponse> GetRequestState(OracleConnection con, XRMRequest<RequestStateRequest> Request)
        {
            RequestStateResponse requestStateRes = new RequestStateResponse();
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "select req_state, comments from bars.cust_requests where req_id = :req_id";
                cmd.BindByName = true;
                cmd.Parameters.Add("req_id", OracleDbType.Decimal, Request.AdditionalData.RequestId.AddRuTail(Request.AdditionalData.Kf), ParameterDirection.Input);

                using (OracleDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        int idstate = reader.GetOrdinal("req_state");
                        int idcomments = reader.GetOrdinal("comments");
                        while (reader.Read())
                        {
                            requestStateRes.RequestState = Convert.ToDecimal(OracleHelper.GetDecimalString(reader, idstate, "0"));
                            requestStateRes.RequestMessage = Convert.ToString(OracleHelper.GetString(reader, idcomments));
                        }
                    }

                }
            }
            return new XRMResponseDetailed<RequestStateResponse>
            {
                Results = requestStateRes
            };
        }
        #endregion

        #region EarlyClose
        private static decimal GetParamVal(object oraParam, decimal denom)
        {
            decimal _res = 0;
            if (string.IsNullOrEmpty(Convert.ToString(oraParam)) || Convert.ToString(oraParam) == "null") return _res;
            else
            {
                try
                {
                    _res = ((OracleDecimal)oraParam).Value / denom;
                }
                catch (InvalidCastException) { }
            }
            return _res;
        }
        public static XRMResponseDetailed<EarlyCloseResponse> GetEarlyTerminationParams(OracleConnection con, XRMRequest<EarlyCloseRequest> Request)
        {
            string _kf = Request.AdditionalData.Kf;
            XRMResponseDetailed<EarlyCloseResponse> res = new XRMResponseDetailed<EarlyCloseResponse>
            {
                Results = new EarlyCloseResponse()
            };

            Decimal p_penalty = 0;          // Сума штрафу               
            Decimal p_commiss = 0;          // Сума комісії за РКО                
            Decimal p_commiss2 = 0;         // Сума комісії за прийом вітхих купюр                
            Decimal p_dptrest = 0;          // Сума депозиту до виплати               
            Decimal p_intrest = 0;          // Сума відсотків до виплати
            Decimal p_int2pay_ing = 0;      // Сума до виплати

            if (global::Deposit.InheritedDeal(Convert.ToString(Request.AdditionalData.DepositId)) && (Request.AdditionalData.CustomerType == "H"))
            {
                res.ResultCode = -1;
                res.ResultMessage = "По депозитному договору є зареєстровані спадкоємці. Дана функція заблокована.";
            }
            else
            {
                global::Deposit dpt = new global::Deposit(Request.AdditionalData.DepositId.AddRuTail(_kf), true);
                res.Results.Currency = dpt.Currency;
                res.Results.DepositSum = dpt.dpt_f_sum;
                res.Results.PercentSum = dpt.perc_f_sum;
                res.Results.Rate = dpt.RealIntRate;

                using (OracleCommand cmdGetShtrafRate = con.CreateCommand())
                {
                    cmdGetShtrafRate.CommandText = "select nvl(dpt.f_shtraf_rate(:dpt_id,bankdate),0) from dual";
                    cmdGetShtrafRate.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt.ID, ParameterDirection.Input);

                    res.Results.PenaltyRate = Convert.ToDecimal(cmdGetShtrafRate.ExecuteScalar());
                }

                using (OracleCommand cmdGetShtrafInfo = con.CreateCommand())
                {
                    cmdGetShtrafInfo.CommandText = "begin " +
                                                    "dpt_web.global_penalty (:p_dptid, bankdate, :p_fullpay, null, 'RO', " +
                                                    ":p_penalty, :p_commiss, :p_commiss2, :p_dptrest, :p_intrest, :p_int2pay_ing); " +
                                                "end;";

                    cmdGetShtrafInfo.Parameters.Add("p_dptid", OracleDbType.Decimal, dpt.ID, ParameterDirection.Input);
                    cmdGetShtrafInfo.Parameters.Add("p_fullpay", OracleDbType.Decimal, Request.AdditionalData.FullPay, ParameterDirection.Input);
                    cmdGetShtrafInfo.Parameters.Add("p_penalty", OracleDbType.Decimal, p_penalty, ParameterDirection.Output);
                    cmdGetShtrafInfo.Parameters.Add("p_commiss", OracleDbType.Decimal, p_commiss, ParameterDirection.Output);
                    cmdGetShtrafInfo.Parameters.Add("p_commiss2", OracleDbType.Decimal, p_commiss2, ParameterDirection.Output);
                    cmdGetShtrafInfo.Parameters.Add("p_dptrest", OracleDbType.Decimal, p_dptrest, ParameterDirection.Output);
                    cmdGetShtrafInfo.Parameters.Add("p_intrest", OracleDbType.Decimal, p_intrest, ParameterDirection.Output);
                    cmdGetShtrafInfo.Parameters.Add("p_int2pay_ing", OracleDbType.Decimal, p_int2pay_ing, ParameterDirection.Output);

                    cmdGetShtrafInfo.ExecuteNonQuery();

                    p_int2pay_ing = GetParamVal(cmdGetShtrafInfo.Parameters["p_int2pay_ing"].Value, dpt.Sum_denom);
                    p_penalty = GetParamVal(cmdGetShtrafInfo.Parameters["p_penalty"].Value, dpt.Sum_denom);
                    p_commiss = GetParamVal(cmdGetShtrafInfo.Parameters["p_commiss"].Value, dpt.Sum_denom);
                    p_commiss2 = GetParamVal(cmdGetShtrafInfo.Parameters["p_commiss2"].Value, dpt.Sum_denom);
                    p_dptrest = GetParamVal(cmdGetShtrafInfo.Parameters["p_dptrest"].Value, dpt.Sum_denom);
                    p_intrest = GetParamVal(cmdGetShtrafInfo.Parameters["p_intrest"].Value, dpt.Sum_denom);
                }

                res.Results.PenaltySum = p_intrest - p_penalty;
                res.Results.PenaltyPercentSum = p_intrest;
                res.Results.AllPercentSum = p_penalty;
                res.Results.ComissionSum = p_commiss;
                res.Results.DenomSum = p_commiss2;
                res.Results.DepositSumToPay = p_dptrest;
                res.Results.PercentSumToPay = p_intrest; //сума без урахування утриманого податку 18 % +Військовий збір 1,5 %

                if (Request.AdditionalData.CustomerType == "T")
                    // Сума дозволена для отримання довіреною особою 
                    res.Results.DepositSumToPay = DepositAgreement.GetAllowedAmount(con, dpt.ID, Request.AdditionalData.Rnk);
                if (Tools.DPT_IRREVOCABLE(dpt.ID.ToString()) >= 1)
                {
                    if (Tools.DPT_HASNO35AGREEMENT(dpt.ID.ToString()) >= 1)
                    {
                        res.ResultCode = -1;
                        res.ResultMessage = "Вклад є невідкличним. Для дострокового повернення сформуйте запит на бек-офіс та сформуйте додаткову угоду на дострокове розірвання (35)";
                    }
                }
                // знайти операції, якими можна виплатити тіло і відстотки 

                string sql_tts_deposit = string.Format(@"select op_type as tt, op_name as name, tt_cash 
                                                                   from bars.v_dpt_vidd_tts t, bars.dpt_deposit d 
                                                                  where d.deposit_id = {0} 
                                                                    and d.vidd = t.dpttype_id 
                                                                    and tt_id in (21,23,25,26,33,35) 
                                                                    and tt_cash = {1}
                                                                    and (d.kv = 980 or(op_type in ('EDP', 'DPE')) or (ebp.dpt_out_kv(d.deposit_id) = 1 and(op_type not in ('EDP', 'DPE'))))",
                                         Convert.ToString(dpt.ID),
                                         Convert.ToString(Request.AdditionalData.UseCash));
                string sql_tts_percent = string.Format(@"select op_type as tt, op_name as name, tt_cash 
                                                                   from bars.v_dpt_vidd_tts t, bars.dpt_deposit d 
                                                                  where d.deposit_id = {0} 
                                                                    and d.vidd = t.dpttype_id 
                                                                    and tt_id in (3,33,34,23,26,45) 
                                                                    and tt_cash = {1}",
                                         Convert.ToString(dpt.ID),
                                         Convert.ToString(Request.AdditionalData.UseCash));

                using (OracleCommand cmdtts_deposit = con.CreateCommand())
                {
                    cmdtts_deposit.CommandText = sql_tts_deposit;
                    OracleDataReader rdr = null;
                    using (rdr = cmdtts_deposit.ExecuteReader())
                    {
                        int tt_n = 0;
                        DepositTTS[] XrmDepositTTSSet = new DepositTTS[1];
                        while (rdr.Read())
                        {
                            if (!rdr.IsDBNull(0))
                            {
                                DepositTTS XrmDepositTTSd = new DepositTTS();
                                XrmDepositTTSd.TT = Convert.ToString(rdr.GetOracleString(0).Value);
                                XrmDepositTTSd.Name = Convert.ToString(rdr.GetOracleString(1).Value);
                                Array.Resize(ref XrmDepositTTSSet, tt_n + 1);
                                XrmDepositTTSSet[tt_n] = XrmDepositTTSd;
                                XrmDepositTTSd = null;
                                tt_n = tt_n + 1;
                            }
                        }
                        res.Results.XrmDepositTTS = XrmDepositTTSSet;
                        cmdtts_deposit.CommandText = sql_tts_percent;

                        rdr = cmdtts_deposit.ExecuteReader();
                        tt_n = 0;
                        DepositTTS[] XrmDepositTTSSetp = new DepositTTS[0];
                        while (rdr.Read())
                        {
                            if (!rdr.IsDBNull(0))
                            {
                                DepositTTS XrmDepositTTSp = new DepositTTS();
                                XrmDepositTTSp.TT = Convert.ToString(rdr.GetOracleString(0).Value);
                                XrmDepositTTSp.Name = Convert.ToString(rdr.GetOracleString(1).Value);
                                Array.Resize(ref XrmDepositTTSSetp, tt_n + 1);
                                XrmDepositTTSSetp[tt_n] = XrmDepositTTSp;
                                XrmDepositTTSp = null;
                                tt_n = tt_n + 1;
                            }
                        }
                        res.Results.XrmPercentTTS = XrmDepositTTSSetp;
                    }
                }
            }

            return res;
        }

        //public XRMResponseDetailed<EarlyCloseRunResponse> RunEarlyClose(XRMRequest<EarlyCloseRequest> Request)
        public static XRMResponseDetailed<EarlyCloseRunResponse> RunEarlyTermination(OracleConnection con, XRMRequest<EarlyCloseRequest> Request)
        {
            EarlyCloseRunResponse res = new EarlyCloseRunResponse();

            Decimal sum2pay = 0;
            Decimal perc2pay = 0;
            Decimal p_int2pay_ing = 0;
            using (OracleCommand cmdShtraf = con.CreateCommand())
            {
                cmdShtraf.CommandText = "begin dpt_web.penalty_payment(:dpt_id,:sum, :dpt_rest, :perc_rest, :p_int2pay_ing); end;";

                cmdShtraf.Parameters.Add("dpt_id", OracleDbType.Decimal, Request.AdditionalData.DepositId.AddRuTail(Request.AdditionalData.Kf), ParameterDirection.Input);
                cmdShtraf.Parameters.Add("sum", OracleDbType.Decimal, Request.AdditionalData.Sum, ParameterDirection.Input);

                cmdShtraf.Parameters.Add("dpt_rest", OracleDbType.Decimal, sum2pay, ParameterDirection.Output);
                cmdShtraf.Parameters.Add("perc_rest", OracleDbType.Decimal, perc2pay, ParameterDirection.Output);
                cmdShtraf.Parameters.Add("p_int2pay_ing", OracleDbType.Decimal, p_int2pay_ing, ParameterDirection.Output);

                cmdShtraf.ExecuteNonQuery();
            }

            using (OracleCommand cmdRests = con.CreateCommand())
            {
                cmdRests.CommandText = @"select 
                                            sum(case when nbs in ('2620','2630') then ostb else 0 end)/100 dptrest, 
                                            sum(case when nbs in ('2628','2638') then ostb else 0 end)/100 percentrest 
                                         from accounts 
                                         where 
                                            acc in (select accid FROM DPT_ACCOUNTS WHERE DPTID = :dpt_id)";
                cmdRests.Parameters.Add("dpt_id", OracleDbType.Decimal, Request.AdditionalData.DepositId.AddRuTail(Request.AdditionalData.Kf), ParameterDirection.Input);

                using (OracleDataReader rdr = cmdRests.ExecuteReader())
                {
                    if (rdr.Read())
                    {
                        res.DepositSumToPay = rdr.GetOracleDecimal(0).Value;
                        res.PercentSumToPay = rdr.GetOracleDecimal(1).Value; //сума з урахуванням утриманого податку 18 % +Військовий збір 1,5 %
                    }
                }
            }
            return new XRMResponseDetailed<EarlyCloseRunResponse>
            {
                Results = res
            };
        }
        #endregion

        #region DepositFiles
        /*формування довідки по депозитному рахунку*/
        // public XRMResponseDetailed<FilesResponse> GetAccountStatusFile(XRMRequest<AccStatusRequest> Request)
        public static XRMResponseDetailed<FilesResponse> GetAccStatusFile(OracleConnection con, XRMRequest<AccStatusRequest> Request)
        {
            byte[] bytes = null;
            string templatePath = FrxDoc.GetTemplatePathByFileName("DPT_ACCOUNT_STATUS.frx");
            string outfilename = "DPT_ACCOUNT_STATUS_RNK" + Request.AdditionalData.Rnk + "_AGRID_" + Request.AdditionalData.AgrId;
            FrxParameters pars = new FrxParameters
                {
                    new FrxParameter("p_rnk", TypeCode.Int32, Request.AdditionalData.Rnk.AddRuTail(Request.AdditionalData.Kf)),
                    new FrxParameter("p_agr_id", TypeCode.Int32, Request.AdditionalData.AgrId.AddRuTail(Request.AdditionalData.Kf))
                };
            FrxDoc doc = new FrxDoc(templatePath, pars, null);

            using (MemoryStream ms = new MemoryStream())
            {
                doc.ExportToMemoryStream(FrxExportTypes.Pdf, ms);
                bytes = ms.ToArray();
            }
            return new XRMResponseDetailed<FilesResponse>
            {
                Results = new FilesResponse
                {
                    Doc = Convert.ToBase64String(GetZipFile(bytes, outfilename).ToArray())
                }
            };
        }
        /*формування виписок в нац. і іноз. валютах по депозитному рахунку*/
        public static XRMResponseDetailed<FilesResponse> GetЕxtractFile(OracleConnection con, XRMRequest<ExtractFileRequest> Request)
        {
            byte[] bytes = null;
            string templatePath = FrxDoc.GetTemplatePathByFileName("DPT_EXTRACT_" + Request.AdditionalData.National + ".frx");
            string outfilename = "";

            if (Request.AdditionalData.National == 35)
                outfilename = "DPT_EXTRACT_NATIONALKV_REF" + Request.AdditionalData.Param;
            else
                outfilename = "DPT_EXTRACT_FOREIGNKV_REF" + Request.AdditionalData.Param;

            FrxParameters pars = new FrxParameters()
                    {
                        new FrxParameter("DATFROM", TypeCode.String, Request.AdditionalData.DateFrom),
                        new FrxParameter("DATTO", TypeCode.String, Request.AdditionalData.DateTo),
                        new FrxParameter("PARAM", TypeCode.Int32, Request.AdditionalData.Param)
                    };
            FrxDoc doc = new FrxDoc(templatePath, pars, null);

            using (MemoryStream ms = new MemoryStream())
            {
                doc.ExportToMemoryStream(FrxExportTypes.Pdf, ms);
                bytes = ms.ToArray();
            }

            return new XRMResponseDetailed<FilesResponse>
            {
                Results = new FilesResponse
                {
                    Doc = Convert.ToBase64String(GetZipFile(bytes, outfilename).ToArray())
                }
            };
        }

        #endregion

        #region DPTPortfolio
        public static XRMResponseDetailed<PortfolioRecord[]> GetPortfolio(OracleConnection con, XRMRequest<PortfolioRequest> Request)
        {
            XRMResponseDetailed<PortfolioRecord[]> result = new XRMResponseDetailed<PortfolioRecord[]>();

            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Clear();
                cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, Request.AdditionalData.Rnk.AddRuTail(Request.AdditionalData.Kf), ParameterDirection.Input);
                cmd.CommandText = @"select 
                                         p.dpt_id dpt_id
                                        ,p.dpt_num dpt_num
                                        ,p.archdoc_id
                                        ,p.vidd_name type_name
                                        ,p.dat_begin datz
                                        ,p.dat_end
                                        ,p.dpt_accnum nls
                                        ,p.dpt_curcode lcv
                                        ,p.dpt_lock
                                        ,(p.dpt_saldo / p.dpt_cur_denom) ostc
                                        ,(p.int_saldo / dpt_cur_denom) ost_int
                                    from table(dpt_views.get_portfolio(:p_rnk, 1)) p";
                using (OracleDataReader rdr = cmd.ExecuteReader())
                {
                    List<PortfolioRecord> PortfolioRows = new List<PortfolioRecord>();
                    if (rdr.HasRows)
                    {
                        while (rdr.Read())
                        {
                            PortfolioRecord PortfolioRecord = new PortfolioRecord();
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

                            PortfolioRecord.DepositId = Convert.ToDecimal(OracleHelper.GetDecimalString(rdr, dptidid, "0"));
                            PortfolioRecord.DepositNumber = OracleHelper.GetString(rdr, dptnumid);
                            PortfolioRecord.ArchiveDocId = Convert.ToDecimal(OracleHelper.GetDecimalString(rdr, archid, "0"));
                            PortfolioRecord.TypeName = OracleHelper.GetString(rdr, type_nameid);
                            PortfolioRecord.DateZ = Convert.ToDateTime(OracleHelper.GetDateTimeString(rdr, datzid, "dd.MM.yyyy"));
                            PortfolioRecord.DateEnd = Convert.ToDateTime(OracleHelper.GetDateTimeString(rdr, dat_endid, "dd.MM.yyyy"));
                            PortfolioRecord.Nls = OracleHelper.GetString(rdr, nlsid);
                            PortfolioRecord.Lcv = OracleHelper.GetString(rdr, lcvid);
                            PortfolioRecord.OstC = Convert.ToDecimal(OracleHelper.GetDecimalString(rdr, ostcid, "0.00"));
                            PortfolioRecord.OstInt = Convert.ToDecimal(OracleHelper.GetDecimalString(rdr, ost_intid, "0.00"));

                            PortfolioRows.Add(PortfolioRecord);
                        }
                    }
                    result.Results = PortfolioRows.ToArray();
                }
                return result;
            }
        }
        #endregion

        #region DepositProduct
        public static XRMResponseDetailed<List<Product>> GetDepositProducts(OracleConnection con)
        {
            XRMResponseDetailed<List<Product>> res = new XRMResponseDetailed<List<Product>> { Results = new List<Product>() };

            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = @"SELECT 
                                          dt.type_id,
                                          dt.type_name,
                                          dt.type_code,
                                          dt.fl_active,
                                          dt.fl_demand,
                                          dt.fl_webbanking,
                                          dv.vidd,
                                          dv.kv,
                                          dv.type_name AS vidd_name,
                                          dv.duration,
                                          dv.duration_days,
                                          dv.LIMIT,
                                          dv.freq_k,
                                          CASE WHEN DV.FL_DUBL > 0 THEN 'З автопролонгацією' ELSE 'Без автопролонгації' END AS dubl
                                    FROM  TABLE (dpt_adm.get_dpt_type_sets) dt,
                                          TABLE (dpt_adm.get_dpt_vidd_sets (dt.type_id)) dv
                                    WHERE dt.fl_act = 1 
                                          AND dv.flagid = 1";
                using (OracleDataReader rdr = cmd.ExecuteReader())
                {
                    List<Product> DepositProducts = new List<Product>();
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
                            Product Product = new Product();

                            Product.TypeId = Convert.ToInt32(OracleHelper.GetDecimalString(rdr, type_idid, "0"));
                            Product.TypeName = OracleHelper.GetString(rdr, type_nameid);
                            Product.TypeCode = OracleHelper.GetString(rdr, type_codeid);
                            Product.IsActiveStr = OracleHelper.GetString(rdr, fl_activeid);
                            Product.ProductTypeStr = OracleHelper.GetString(rdr, fl_demandid);
                            Product.IsWebBanking = OracleHelper.GetString(rdr, fl_webbankingid);
                            Product.Vidd = Convert.ToInt32(OracleHelper.GetDecimalString(rdr, viddid, "0"));
                            Product.Kv = Convert.ToInt32(OracleHelper.GetDecimalString(rdr, kvid, "0"));
                            Product.ViddName = OracleHelper.GetString(rdr, vidd_nameid);
                            Product.Duration = Convert.ToInt16(OracleHelper.GetDecimalString(rdr, durationid, "0"));
                            Product.DurationDays = Convert.ToInt16(OracleHelper.GetDecimalString(rdr, duration_daysid, "0"));
                            Product.Limit = OracleHelper.GetString(rdr, LIMITid);
                            Product.PayoutFrequency = OracleHelper.GetString(rdr, freq_kid);
                            Product.AutoprolongationText = OracleHelper.GetString(rdr, dublid);

                            DepositProducts.Add(Product);
                        }
                        res.Results = DepositProducts;
                    }
                }
            }

            return res;
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
                Flags.InnerText = AccessList[i].FlReport.ToString() + AccessList[i].FlMoney.ToString() +
                    AccessList[i].FlEarly.ToString() + AccessList[i].FlAgreement.ToString() + AccessList[i].FlKv.ToString();
                p_row.AppendChild(Flags);
            }
            return XmlDoc;
        }

        public static XRMResponseDetailed<BOAccessResponse> CreateAccessRequest(OracleConnection con, XRMRequest<BOAccessRequest> Request)
        {
            BOAccessResponse res = new BOAccessResponse();
            using (OracleCommand cmd = con.CreateCommand())
            using (OracleXmlType _xml = new OracleXmlType(con, GetXML(Request.AdditionalData.AccessList).InnerXml))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "XRM_INTEGRATION_OE.request_access_req";
                cmd.BindByName = true;

                cmd.Parameters.Add("p_type", OracleDbType.Decimal, Request.AdditionalData.Type, ParameterDirection.Input);
                cmd.Parameters.Add("p_trustee", OracleDbType.Varchar2, Request.AdditionalData.TrusteeType, ParameterDirection.Input);
                cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, Request.AdditionalData.Rnk, ParameterDirection.Input);
                cmd.Parameters.Add("p_cert_num", OracleDbType.Varchar2, Request.AdditionalData.CertifNumber, ParameterDirection.Input);
                cmd.Parameters.Add("p_cert_date", OracleDbType.Date, Request.AdditionalData.CertifDate, ParameterDirection.Input);
                cmd.Parameters.Add("p_date_start", OracleDbType.Date, Request.AdditionalData.StartDate, ParameterDirection.Input);
                cmd.Parameters.Add("p_date_finish", OracleDbType.Date, Request.AdditionalData.FinishDate, ParameterDirection.Input);
                cmd.Parameters.Add("p_access_info", OracleDbType.XmlType, _xml, ParameterDirection.Input);

                cmd.Parameters.Add("p_reqid", OracleDbType.Decimal, res.ReqId, ParameterDirection.Output);

                cmd.ExecuteNonQuery();

                OracleDecimal pRequestId = (OracleDecimal)cmd.Parameters["p_reqid"].Value;
                if (pRequestId.IsNull)
                {
                    res.ReqId = -1;
                }
                else
                {
                    res.ReqId = pRequestId.Value;

                    string mfo = XrmHelper.GetMfo(con);

                    FrxParameters pars = new FrxParameters();
                    pars.Add(new FrxParameter("p_req_id", TypeCode.Int64, pRequestId.Value.AddRuTail(mfo)));

                    byte[] toDeposit = XrmHelper.CreateFrxFile(FrxDoc.GetTemplateFileNameByID("DPT_ACCESS_APPLICATION"), pars);

                    res.Templates.Add(new TemplateDoc()
                    {
                        Content = Convert.ToBase64String(toDeposit),
                        Name = "Заява на доступ до вкладного (депозитного) рахунку через бек-офіс"
                    });

                    if (Request.AdditionalData.TrusteeType.ToUpper() != "V")
                    {
                        byte[] toCard = XrmHelper.CreateFrxFile(FrxDoc.GetTemplateFileNameByID("DPT_ACCESS_APPLICATION_CARD"), pars);
                        res.Templates.Add(new TemplateDoc()
                        {
                            Name = "Заява на доступ до картки клієнта через бек-офіс",
                            Content = Convert.ToBase64String(toCard)
                        });
                    }
                }
            }

            res.ReqId = res.ReqId.CutRuTail();
            return new XRMResponseDetailed<BOAccessResponse>
            {
                Results = res
            };
        }

        public static XRMResponse BackOfficeProc(OracleConnection con, XRMRequest<BOGetAccessRequest> Request)
        {
            XRMResponse res = new XRMResponse();
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.Parameters.Clear();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "XRM_INTEGRATION_OE.request_forbackoff";
                cmd.BindByName = true;

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("p_transactionid", OracleDbType.Decimal, Request.TransactionId, ParameterDirection.Input);
                cmd.Parameters.Add("p_trustee", OracleDbType.Varchar2, Request.AdditionalData.TrusteeType, ParameterDirection.Input);
                cmd.Parameters.Add("p_req_id", OracleDbType.Decimal, Request.AdditionalData.RequestId, ParameterDirection.Input);
                cmd.Parameters.Add("p_req_type", OracleDbType.Decimal, Request.AdditionalData.RequestType, ParameterDirection.Input);
                cmd.Parameters.Add("p_cust_id", OracleDbType.Decimal, Request.AdditionalData.CustomerId, ParameterDirection.Input);
                cmd.Parameters.Add("p_scaccess", OracleDbType.Clob, Request.AdditionalData.ScAccess, ParameterDirection.Input);
                cmd.Parameters.Add("p_scwarrant", OracleDbType.Clob, Request.AdditionalData.ScWarrant, ParameterDirection.Input);
                cmd.Parameters.Add("p_scsignscard", OracleDbType.Clob, Request.AdditionalData.ScSignsCard, ParameterDirection.Input);
                OracleParameter param = new OracleParameter("p_depositlist", OracleDbType.Array, Request.AdditionalData.Deposits.Length,
                    (Bars.Oracle.NumberList)Request.AdditionalData.Deposits, ParameterDirection.Input)
                { UdtTypeName = "NUMBER_LIST", Value = Request.AdditionalData.Deposits };
                cmd.Parameters.Add(param);

                cmd.Parameters.Add("resultcode", OracleDbType.Decimal, res.ResultCode, ParameterDirection.Output);
                cmd.Parameters.Add("resultmessage", OracleDbType.Varchar2, res.ResultMessage, ParameterDirection.Output);

                cmd.ExecuteNonQuery();

                OracleDecimal resultCode = (OracleDecimal)cmd.Parameters["resultcode"].Value;
                res.ResultCode = resultCode.IsNull ? -1 : (int)resultCode.Value;

                OracleString resultMessage = (OracleString)cmd.Parameters["resultmessage"].Value;
                res.ResultMessage = resultMessage.IsNull ? "" : resultMessage.Value;

                return res;
            }
        }

        public static XRMResponseDetailed<BOGetStateResponse> BackOfficeGetStateProc(OracleConnection con, XRMRequest<BOGetStateRequest> Request)
        {
            BOGetStateResponse res = new BOGetStateResponse();
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "XRM_INTEGRATION_OE.request_frombackoff";
                cmd.BindByName = true;

                cmd.Parameters.Add("p_req_id", OracleDbType.Decimal, Request.AdditionalData.RequestId, ParameterDirection.Input);
                cmd.Parameters.Add("resultstate", OracleDbType.Decimal, res.State, ParameterDirection.Output);
                cmd.Parameters.Add("result_comments", OracleDbType.Varchar2, 4000, res.Comment, ParameterDirection.Output);
                cmd.ExecuteNonQuery();

                OracleDecimal state = (OracleDecimal)cmd.Parameters["resultstate"].Value;
                res.State = state.IsNull ? (Decimal?)null : state.Value;

                OracleString comment = (OracleString)cmd.Parameters["result_comments"].Value;
                if (!comment.IsNull)
                    res.Comment = comment.Value;

                res.Message = "Статус запиту: ";

                Int32? flag = (Int32?)res.State;
                switch (flag)
                {
                    case null: res.Message += "Статус запиту: не оброблений"; break;
                    case -1: res.Message += "Статус запиту: відхилений"; break;
                    case 0: res.Message += "Статус запиту: новий"; break;
                    case 1: res.Message += "Статус запиту: оброблений"; break;
                    case 2: res.Message += "Статус запиту: анульований"; break;
                    default: res.Message = "Статус запиту: Немає даних по цьому запиту"; break;
                }
            }
            return new XRMResponseDetailed<BOGetStateResponse> { Results = res };
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
