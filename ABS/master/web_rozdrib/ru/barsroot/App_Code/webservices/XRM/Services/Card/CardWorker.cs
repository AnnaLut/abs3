using System;
using System.Data;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Collections.Generic;
using Bars.WebServices.XRM.Services.Card.Models;
using System.IO;
using System.Linq;
using Bars.Oracle;
using FastReport.Utils;
using System.Xml;
using Bars.Web.Report;
using ICSharpCode.SharpZipLib.Zip;
using ICSharpCode.SharpZipLib.Core;
using System.Web;

namespace Bars.WebServices.XRM.Services.Card
{
    public static class CardWorker
    {
        #region DKBO
        public static XRMDKBOResInner MapToDKBO(XRMDKBOReqInner XRMDKBOReq, Decimal TransactionId, OracleConnection con)
        {
            XRMDKBOResInner XRMDKBORes = new XRMDKBOResInner();
            List<Decimal?> acclist = XRMDKBOReq.AccList;
            Decimal?[] data = acclist.Select(i => i).ToArray();

            using (OracleCommand cmd = con.CreateCommand())
            {
                using (OracleParameter param = new OracleParameter("p_acc_list", OracleDbType.Array, data.Length, (NumberList)data, ParameterDirection.Input) { UdtTypeName = "NUMBER_LIST", Value = data })
                {
                    try
                    {
                        cmd.Parameters.Clear();
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.BindByName = true;
                        cmd.CommandText = "xrm_integration_oe.MapDKBO";
                        cmd.Parameters.Add("p_TransactionID", OracleDbType.Decimal, TransactionId, ParameterDirection.Input);
                        cmd.Parameters.Add("p_ext_id", OracleDbType.Varchar2, XRMDKBOReq.Ext_id, ParameterDirection.Input);
                        cmd.Parameters.Add("p_customer_id", OracleDbType.Decimal, XRMDKBOReq.RNK, ParameterDirection.Input);
                        cmd.Parameters.Add("p_deal_number", OracleDbType.Varchar2, 400, XRMDKBOReq.DealNumber, ParameterDirection.Input);
                        cmd.Parameters.Add(param);
                        cmd.Parameters.Add("p_dkbo_date_from", OracleDbType.Date, XRMDKBOReq.DKBODateFrom, ParameterDirection.Input);
                        cmd.Parameters.Add("p_dkbo_date_to", OracleDbType.Date, XRMDKBOReq.DKBODateTo, ParameterDirection.Input);
                        cmd.Parameters.Add("p_deal_id", OracleDbType.Decimal, XRMDKBORes.DealId, ParameterDirection.Output);
                        cmd.Parameters.Add("p_start_date", OracleDbType.Date, XRMDKBORes.StartDate, ParameterDirection.Output);

                        cmd.ExecuteNonQuery();
                        Object p_deal_id = cmd.Parameters["p_deal_id"].Value;
                        XRMDKBORes.DealId = (((OracleDecimal)p_deal_id).IsNull ? -1 : ((OracleDecimal)p_deal_id).Value);
                        Object p_start_date = cmd.Parameters["p_start_date"].Value;
                        XRMDKBORes.StartDate = ((OracleDate)p_start_date).IsNull ? (DateTime?)null : ((OracleDate)p_start_date).Value;
                        if (XRMDKBORes.DealId == -1)
                        {
                            XRMDKBORes.DealId = null;
                            XRMDKBORes.ResultCode = -1;
                            XRMDKBORes.ResultMessage = String.Format("Помилка приєднання рахунків {0} до ДКБО клієнта {1} (ДКБО не існує)", String.Join(" , ", acclist), XRMDKBOReq.RNK);
                        }
                    }
                    catch (System.Exception ex)
                    {
                        XRMDKBORes.ResultCode = -1;
                        XRMDKBORes.ResultMessage = "MapToDKBO: error = " + ex.Message;
                    }
                }
            }
            XRMDKBORes.Rnk = XRMDKBOReq.RNK;
            XRMDKBORes.Ext_id = XRMDKBOReq.Ext_id;
            return XRMDKBORes;
        }

        public static XRMQuestionnaireDKBORes QuestionnaireDKBOMethod(XRMQuestionnaireDKBOReq xrmQestionnaireReq, OracleConnection con)
        {
            XRMQuestionnaireDKBORes res = new XRMQuestionnaireDKBORes();
            res.Answers = new List<XRMQuestionnaireDKBOAttrRes>();
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "xrm_integration_oe.p_quest_answ_ins";
                cmd.BindByName = true;
                for (int i = 0; i < xrmQestionnaireReq.Attributes.Length; i++)
                {
                    XRMQuestionnaireDKBOAttrRes resTemp = new XRMQuestionnaireDKBOAttrRes();
                    if (!String.IsNullOrEmpty(xrmQestionnaireReq.Attributes[i].Value))
                    {
                        try
                        {
                            cmd.Parameters.Clear();
                            cmd.Parameters.Add("p_transactionid", OracleDbType.Decimal, xrmQestionnaireReq.TransactionId, ParameterDirection.Input);
                            cmd.Parameters.Add("p_object_id", OracleDbType.Varchar2, 400, xrmQestionnaireReq.NewDKBOId, ParameterDirection.Input);
                            cmd.Parameters.Add("p_attribute_code", OracleDbType.Varchar2, 400, xrmQestionnaireReq.Attributes[i].Code, ParameterDirection.Input);
                            cmd.Parameters.Add("p_attribute_value", OracleDbType.Varchar2, 400, xrmQestionnaireReq.Attributes[i].Value, ParameterDirection.Input);
                            cmd.ExecuteNonQuery();
                        }
                        catch (System.Exception ex)
                        {
                            resTemp.AttributeCode = xrmQestionnaireReq.Attributes[i].Code;
                            resTemp.AttributeMessage = "Error: " + ex.Message;
                            res.Answers.Add(resTemp);
                        }
                    }
                }
            }
            return res;
        }
        #endregion

        #region XRMBulkCard
        public static XRMBulkCardRes XRMBulkCardProc(XRMBulkCardReq XRMBulkCardReq, OracleConnection connect)
        {
            XRMBulkCardRes XRMBulkCardRes = new XRMBulkCardRes();
            using (OracleCommand cmdBulkCardParam = connect.CreateCommand())
            {
                try
                {
                    cmdBulkCardParam.CommandType = CommandType.StoredProcedure;
                    cmdBulkCardParam.CommandText = "xrm_integration_oe.CardBulkInsert";
                    cmdBulkCardParam.BindByName = true;
                    cmdBulkCardParam.Parameters.Add("p_branch", OracleDbType.Varchar2, XRMBulkCardReq.Branch, ParameterDirection.Input);
                    cmdBulkCardParam.Parameters.Add("p_unit_type_code", OracleDbType.Varchar2, XRMBulkCardReq.type_code, ParameterDirection.Input);
                    cmdBulkCardParam.Parameters.Add("p_ext_id", OracleDbType.Varchar2, XRMBulkCardReq.ext_id, ParameterDirection.Input);
                    cmdBulkCardParam.Parameters.Add("p_receiver_url", OracleDbType.Varchar2, XRMBulkCardReq.receiver_url, ParameterDirection.Input);
                    cmdBulkCardParam.Parameters.Add("p_request_data", OracleDbType.Clob, XRMBulkCardReq.request_data, ParameterDirection.Input);
                    cmdBulkCardParam.Parameters.Add("p_hash", OracleDbType.Clob, XRMBulkCardReq.hash, ParameterDirection.Input);
                    cmdBulkCardParam.Parameters.Add("p_state", OracleDbType.Decimal, XRMBulkCardRes.ResultCode, ParameterDirection.Output);
                    cmdBulkCardParam.Parameters.Add("p_msg", OracleDbType.Varchar2, 4000, XRMBulkCardRes.ResultMessage, ParameterDirection.Output);
                    cmdBulkCardParam.Parameters.Add("p_bulkid", OracleDbType.Decimal, XRMBulkCardRes.BulkID, ParameterDirection.Output);

                    cmdBulkCardParam.ExecuteNonQuery();
                    OracleDecimal resstate = (OracleDecimal)cmdBulkCardParam.Parameters["p_state"].Value;
                    OracleString resmsg = (OracleString)cmdBulkCardParam.Parameters["p_msg"].Value;
                    OracleDecimal res = (OracleDecimal)cmdBulkCardParam.Parameters["p_bulkid"].Value;

                    XRMBulkCardRes.ResultCode = Convert.ToInt16(resstate.IsNull ? -2 : resstate.Value);
                    XRMBulkCardRes.ResultMessage = resmsg.IsNull ? "" : resmsg.Value;
                    XRMBulkCardRes.BulkID = res.IsNull ? -2 : res.Value;
                }
                catch (SystemException e)
                {
                    XRMBulkCardRes.ResultCode = -1;
                    XRMBulkCardRes.ResultMessage = "XRMBulkCardProc: error =" + e.Message;
                }

            }
            return XRMBulkCardRes;
        }
        public static XRMBulkCardTicketRes XRMBulkCardTicket(XRMBulkCardTicketReq XRMBulkCardTicketReq, OracleConnection connect)
        {
            XRMBulkCardTicketRes XRMBulkCardTicketRes = new XRMBulkCardTicketRes();
            using (OracleCommand cmdBulkCardTicket = new OracleCommand())
            {
                try
                {
                    cmdBulkCardTicket.Connection = connect;
                    cmdBulkCardTicket.CommandType = CommandType.StoredProcedure;
                    cmdBulkCardTicket.CommandText = "xrm_integration_oe.CardBulkTicket";
                    cmdBulkCardTicket.Parameters.Clear();
                    cmdBulkCardTicket.BindByName = true;
                    cmdBulkCardTicket.Parameters.Add("p_bulkid", OracleDbType.Decimal, XRMBulkCardTicketReq.BulkID, ParameterDirection.Input);
                    cmdBulkCardTicket.Parameters.Add("p_bulkstatus", OracleDbType.Varchar2, 400, XRMBulkCardTicketRes.ResultMessage, ParameterDirection.Output);
                    cmdBulkCardTicket.Parameters.Add("p_ticket", OracleDbType.Clob, null, ParameterDirection.Output);


                    cmdBulkCardTicket.ExecuteNonQuery();
                    object res = cmdBulkCardTicket.Parameters["p_bulkstatus"].Value;
                    XRMBulkCardTicketRes.ResultMessage = ((OracleString)res).Value;
                    object ticket = cmdBulkCardTicket.Parameters["p_ticket"].Value;
                    string s = ((OracleClob)ticket).IsNull ? ((OracleString)res).Value : ((OracleClob)ticket).Value;
                    if (s != XRMBulkCardTicketRes.ResultMessage)
                    {
                        byte[] bytes = new byte[s.Length * sizeof(char)];
                        System.Buffer.BlockCopy(s.ToCharArray(), 0, bytes, 0, bytes.Length);

                        XRMBulkCardTicketRes.Ticket = s;
                    }
                    XRMBulkCardTicketRes.ResultCode = 0;
                }
                catch (SystemException e)
                {
                    XRMBulkCardTicketRes.ResultCode = -1;
                    XRMBulkCardTicketRes.ResultMessage = "XRMBulkCardTicketRes: error =" + e.Message;
                }
            }
            return XRMBulkCardTicketRes;
        }
        #endregion

        #region XRMCardParameter
        public static List<XRMCardParam> SetGetCardParam(Decimal TransactionId, XRMCardParams _XRMCardParams, OracleConnection connect)
        {
            List<XRMCardParam> CardParamList = new List<XRMCardParam>();
            System.Xml.XmlDocument p_doc = CreateXmlDoc(_XRMCardParams.XRMCardParamList);

            using (OracleCommand cmdSetCardParam = connect.CreateCommand())
            {
                cmdSetCardParam.CommandText = "select TAG, VAL, ERR from table(xrm_integration_oe.SetGetCardParam(:p_TransactionId,:p_nd, :p_xmltags))";
                cmdSetCardParam.BindByName = true;
                cmdSetCardParam.Parameters.Add("p_TransactionId", OracleDbType.Decimal, TransactionId, ParameterDirection.Input);
                cmdSetCardParam.Parameters.Add("p_nd", OracleDbType.Varchar2, _XRMCardParams.ND, ParameterDirection.Input);
                cmdSetCardParam.Parameters.Add("p_xmltags", OracleDbType.Clob, p_doc.InnerXml, ParameterDirection.Input);

                using (OracleDataReader reader = cmdSetCardParam.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        int idTAG = reader.GetOrdinal("TAG");
                        int idVAL = reader.GetOrdinal("VAL");
                        int idErr = reader.GetOrdinal("ERR");
                        while (reader.Read())
                        {
                            XRMCardParam XRMCardParam = new XRMCardParam();
                            XRMCardParam.TAG = OracleHelper.GetString(reader, idTAG);
                            XRMCardParam.VAL = OracleHelper.GetString(reader, idVAL);
                            XRMCardParam.ERR = OracleHelper.GetString(reader, idErr);

                            CardParamList.Add(XRMCardParam);
                        }
                    }
                }
            }
            return CardParamList;
        }
        #endregion

        #region XRMCardSetCredit
        public static byte[] GetFileForPrint(long[] acc, string[] templateId, string maxSum)
        {
            using (MemoryStream outputMemStream = new MemoryStream())
            {
                using (ZipOutputStream zipStream = new ZipOutputStream(outputMemStream))
                {
                    zipStream.SetLevel(6); //0-9, 9 being the highest level of compression
                    byte[] bytes = null;
                    var newEntry = new ZipEntry("ACC_TMPL.rtf");
                    newEntry.DateTime = DateTime.Now;

                    zipStream.PutNextEntry(newEntry);

                    bytes = CreateFile(acc, templateId);

                    using (MemoryStream inStream = new MemoryStream(bytes))
                    {
                        StreamUtils.Copy(inStream, zipStream, new byte[4096]);
                    }
                    zipStream.CloseEntry();
                    zipStream.IsStreamOwner = false;
                    // False stops the Close also Closing the underlying stream.
                    // Must finish the ZipOutputStream before using outputMemStream.
                }
                return outputMemStream.ToArray();
            }
        }

        private static byte[] CreateFile(long[] acc, string[] template)
        {
            byte[] bytes = null;
            using (MemoryStream ms = new MemoryStream())
            {
                var ContractNumber = acc;
                var TemplateID = template;

                MultiPrintRtfReporter rep = new MultiPrintRtfReporter(HttpContext.Current);

                rep.Roles = "reporter,dpt_role,cc_doc";
                rep.ContractNumbers = ContractNumber.AsEnumerable();
                rep.TemplateIds = TemplateID;
                var fullpath = rep.GetReportFile();
                var filepath = fullpath.Replace(".zip", ".rtf");
                using (StreamReader sr = new StreamReader(filepath, System.Text.Encoding.GetEncoding(1251)))
                {
                    using (StreamWriter writer = new StreamWriter(ms))
                    {
                        String str = sr.ReadToEnd();
                        writer.Write(str);
                        writer.Flush();
                        ms.Position = 0;
                        bytes = ms.ToArray();
                        File.Delete(fullpath);
                    }
                }
            }
            return bytes;
        }
        public static XRMCardCreditRes SetCardCredit(XRMCardCreditReq XRMCardCreditReq, OracleConnection connect)
        {
            XRMCardCreditRes XRMCardCreditRes = new XRMCardCreditRes();
            string filename = string.Empty;
            XRMCardCreditRes.acc = XRMCardCreditReq.acc;
            try
            {
                foreach (var acc in XRMCardCreditReq.acc)
                {
                    if (XRMCardCreditReq.maxSum > 0)
                    {
                        using (OracleCommand cmd = connect.CreateCommand())
                        {
                            cmd.CommandText = @"begin accreg.setAccountwParam(:acc, 'MAXCRSUM', :maxSum);
                                                    update accounts set lim = :lim where acc = :acc; 
                                                    end;";
                            cmd.Parameters.Add("acc", OracleDbType.Decimal).Value = acc;
                            cmd.Parameters.Add("maxSum", OracleDbType.Varchar2).Value = XRMCardCreditReq.maxSum;
                            cmd.Parameters.Add("lim", OracleDbType.Decimal).Value = XRMCardCreditReq.maxSum * 100;
                            cmd.ExecuteNonQuery();

                            cmd.CommandText = @"begin accreg.setAccountwParam(:acc, 'DESCRSUM', :desSum); end;";
                            cmd.Parameters.Clear();
                            cmd.Parameters.Add("acc", OracleDbType.Decimal).Value = acc;
                            cmd.Parameters.Add("desSum", OracleDbType.Varchar2).Value = XRMCardCreditReq.desiredSum;
                            cmd.ExecuteNonQuery();

                            cmd.CommandText = @"begin accreg.setAccountwParam(:acc, 'SETCRSUM', :insSum); end;";
                            cmd.Parameters.Clear();
                            cmd.Parameters.Add("acc", OracleDbType.Decimal).Value = acc;
                            cmd.Parameters.Add("insSum", OracleDbType.Varchar2).Value = XRMCardCreditReq.installedSum;
                            cmd.ExecuteNonQuery();
                            cmd.CommandText = @"begin accreg.setAccountwParam(:acc, 'PRPCRSUM', f_sumpr(:insSum * 100,'980','F')); end;";
                            cmd.ExecuteNonQuery();
                            // создаем документы для печати по всем картам из списка public string GetFileForPrint(string id, string templateId)
                        }
                    }
                }
                XRMCardCreditRes.Docs = Convert.ToBase64String(GetFileForPrint(XRMCardCreditReq.acc, XRMCardCreditReq.template, XRMCardCreditReq.maxSum.ToString()));
            }
            catch (SystemException e)
            {
                XRMCardCreditRes.ResultCode = -1;
                XRMCardCreditRes.ResultMessage = e.InnerException + e.Message;
            }
            return XRMCardCreditRes;
        }
        #endregion

        #region XRMInstant
        public static List<XRMInstantDict> XRMGetInstantDict(OracleConnection con)
        {
            var XRMInstantDictionary = new List<XRMInstantDict>();

            using (OracleCommand cmdGetInstant = con.CreateCommand())
            {
                try
                {
                    cmdGetInstant.CommandText = "select ProductCode, ProductName, CardCode, CardName, KV from table(xrm_integration_oe.getInstantDict)";

                    using (OracleDataReader reader = cmdGetInstant.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            int idproductCode = reader.GetOrdinal("ProductCode");
                            int idproductName = reader.GetOrdinal("ProductName");
                            int idCardCode = reader.GetOrdinal("CardCode");
                            int idCardName = reader.GetOrdinal("CardName");
                            int idKV = reader.GetOrdinal("KV");

                            while (reader.Read())
                            {
                                XRMInstantDict XRMInstantDict = new XRMInstantDict();
                                XRMInstantDict.ProductCode = OracleHelper.GetString(reader, idproductCode);
                                XRMInstantDict.ProductName = OracleHelper.GetString(reader, idproductName);
                                XRMInstantDict.CardCode = OracleHelper.GetString(reader, idCardCode);
                                XRMInstantDict.CardName = OracleHelper.GetString(reader, idCardName);
                                XRMInstantDict.KV = OracleHelper.GetString(reader, idKV);
                                XRMInstantDictionary.Add(XRMInstantDict);
                            }
                        }
                    }
                    return XRMInstantDictionary;
                }
                catch
                {
                    return XRMInstantDictionary;
                }
            }
        }
        public static List<XRMInstantList> OrderInstant(Decimal TransactionId, String Cardcode, String Branch, Int16 CardCount, OracleConnection connect)
        {
            XRMInstantList[] XRMInstantListSet = new XRMInstantList[100];

            using (OracleCommand cmdOrderInstant = connect.CreateCommand())
            {
                cmdOrderInstant.CommandText = "select NLS, KV, Branch from table(xrm_integration_oe.OrderInstant(:p_TransactionId,:p_cardcode,:p_branch,:p_cardcount))";
                cmdOrderInstant.Parameters.Clear();
                cmdOrderInstant.BindByName = true;
                cmdOrderInstant.Parameters.Add("p_TransactionId", OracleDbType.Decimal, TransactionId, ParameterDirection.Input);
                cmdOrderInstant.Parameters.Add("p_cardcode", OracleDbType.Varchar2, Cardcode, ParameterDirection.Input);
                cmdOrderInstant.Parameters.Add("p_branch", OracleDbType.Varchar2, Branch, ParameterDirection.Input);
                cmdOrderInstant.Parameters.Add("p_cardcount", OracleDbType.Int16, CardCount, ParameterDirection.Input);

                using (OracleDataReader reader = cmdOrderInstant.ExecuteReader())
                {
                    int rowCounter = 0;
                    if (reader.HasRows)
                    {
                        int idNLS = reader.GetOrdinal("NLS");
                        int idKV = reader.GetOrdinal("KV");
                        int idBranch = reader.GetOrdinal("Branch");

                        while (reader.Read())
                        {
                            XRMInstantList XRMInstantList = new XRMInstantList();
                            XRMInstantList.NLS = OracleHelper.GetString(reader, idNLS);
                            XRMInstantList.KV = OracleHelper.GetString(reader, idKV);
                            XRMInstantList.Branch = OracleHelper.GetString(reader, idBranch);
                            XRMInstantList.ErrorMessage = "Ok";
                            XRMInstantListSet[rowCounter++] = XRMInstantList;
                            if (rowCounter % 100 == 0)
                                Array.Resize(ref XRMInstantListSet, rowCounter + 100);
                        }
                    }
                    Array.Resize(ref XRMInstantListSet, rowCounter++);
                }
            }
            return XRMInstantListSet.ToList();
        }
        #endregion

        #region XRMOpenCard
        public static XRMOpenCardResult ProcOpenCard(XRMOpenCardReq CardParams, OracleConnection con)
        {
            XRMOpenCardResult OCardRes = new XRMOpenCardResult();
            using (OracleCommand cmd = con.CreateCommand())
            {
                try
                {   // открываем карточный счет
                    cmd.Parameters.Clear();
                    cmd.CommandText = "bars.xrm_integration_oe.open_card";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("p_TransactionID", OracleDbType.Decimal, CardParams.TransactionId, ParameterDirection.Input);
                    cmd.Parameters.Add("p_kf", OracleDbType.Decimal, CardParams.KF, ParameterDirection.Input);
                    cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, CardParams.Rnk, ParameterDirection.Input);
                    cmd.Parameters.Add("p_nls", OracleDbType.Varchar2, 20, CardParams.Nls, ParameterDirection.InputOutput);
                    cmd.Parameters.Add("p_cardcode", OracleDbType.Varchar2, CardParams.Cardcode, ParameterDirection.Input);
                    cmd.Parameters.Add("p_branch", OracleDbType.Varchar2, CardParams.Branch, ParameterDirection.Input);
                    cmd.Parameters.Add("p_embfirstname", OracleDbType.Varchar2, CardParams.Embfirstname, ParameterDirection.Input);
                    cmd.Parameters.Add("p_emblastname", OracleDbType.Varchar2, CardParams.Emblastname, ParameterDirection.Input);
                    cmd.Parameters.Add("p_secname", OracleDbType.Varchar2, CardParams.Secname, ParameterDirection.Input);
                    cmd.Parameters.Add("p_work", OracleDbType.Varchar2, CardParams.Work, ParameterDirection.Input);
                    cmd.Parameters.Add("p_office", OracleDbType.Varchar2, CardParams.Office, ParameterDirection.Input);
                    cmd.Parameters.Add("p_wdate", OracleDbType.Date, XrmHelper.GmtToLocal(CardParams.Wdate), ParameterDirection.Input);
                    cmd.Parameters.Add("p_salaryproect", OracleDbType.Decimal, CardParams.Salaryproect, ParameterDirection.Input);
                    cmd.Parameters.Add("p_term", OracleDbType.Decimal, CardParams.Term, ParameterDirection.Input);
                    cmd.Parameters.Add("p_branchissue", OracleDbType.Varchar2, CardParams.Branchissue, ParameterDirection.Input);
                    cmd.Parameters.Add("p_barcode", OracleDbType.Varchar2, CardParams.Barcode, ParameterDirection.Input);
                    cmd.Parameters.Add("p_cobrandid", OracleDbType.Varchar2, CardParams.Cobrandid, ParameterDirection.Input);
                    cmd.Parameters.Add("p_nd", OracleDbType.Decimal, ParameterDirection.Output);
                    cmd.Parameters.Add("p_daos", OracleDbType.Varchar2, 250, OCardRes.daos, ParameterDirection.Output);
                    cmd.Parameters.Add("p_date_begin", OracleDbType.Varchar2, 250, OCardRes.date_begin, ParameterDirection.Output);
                    cmd.Parameters.Add("p_status", OracleDbType.Int16, ParameterDirection.Output);
                    cmd.Parameters.Add("p_blkd", OracleDbType.Int16, ParameterDirection.Output);
                    cmd.Parameters.Add("p_blkk", OracleDbType.Int16, ParameterDirection.Output);
                    cmd.Parameters.Add("p_dkbo_num", OracleDbType.Varchar2, 250, OCardRes.dkbo_num, ParameterDirection.Output);
                    cmd.Parameters.Add("p_dkbo_in", OracleDbType.Varchar2, 250, OCardRes.dkbo_in, ParameterDirection.Output);
                    cmd.Parameters.Add("p_dkbo_out", OracleDbType.Varchar2, 250, OCardRes.dkbo_out, ParameterDirection.Output);
                    cmd.Parameters.Add("p_acc", OracleDbType.Decimal, OCardRes.acc, ParameterDirection.Output);

                    cmd.ExecuteNonQuery();

                    object resnls = cmd.Parameters["p_nls"].Value;
                    OCardRes.NLS = (resnls == null || ((OracleString)resnls).IsNull) ? "" : ((OracleString)resnls).Value;

                    object resnd = cmd.Parameters["p_nd"].Value;
                    OCardRes.nd = ((OracleDecimal)resnd).Value;

                    object resacc = cmd.Parameters["p_acc"].Value;
                    OCardRes.acc = ((OracleDecimal)resacc).Value;

                    object resdaos = cmd.Parameters["p_daos"].Value;
                    OCardRes.daos = (resdaos == null || ((OracleString)resdaos).IsNull) ? "" : ((OracleString)resdaos).Value;

                    object resdate_begin = cmd.Parameters["p_date_begin"].Value;
                    OCardRes.date_begin = (resdate_begin == null || ((OracleString)resdate_begin).IsNull) ? "" : ((OracleString)resdate_begin).Value;

                    object resdkbo_num = cmd.Parameters["p_dkbo_num"].Value;
                    OCardRes.dkbo_num = (resdkbo_num == null || ((OracleString)resdkbo_num).IsNull) ? "" : ((OracleString)resdkbo_num).Value;

                    object resdkbo_in = cmd.Parameters["p_dkbo_in"].Value;
                    OCardRes.dkbo_in = (resdkbo_in == null || ((OracleString)resdkbo_in).IsNull) ? "" : ((OracleString)resdkbo_in).Value;

                    object resdkbo_out = cmd.Parameters["p_dkbo_out"].Value;
                    OCardRes.dkbo_out = (resdkbo_out == null || ((OracleString)resdkbo_out).IsNull) ? "" : ((OracleString)resdkbo_out).Value;

                    return OCardRes;
                }
                catch (System.Exception e)
                {
                    OCardRes.ResultCode = -1;
                    OCardRes.ResultMessage = String.Format("Помилка при створенні карткового рахунку: {0}", e.Message);
                    return OCardRes;
                }
            }
        }
        #endregion

        public static System.Xml.XmlDocument CreateXmlDoc(XRMCardParam[] XRMCardParam)
        {
            System.Xml.XmlDocument res;
            res = new System.Xml.XmlDocument();
            XmlNode p_root = res.CreateElement("params");
            res.AppendChild(p_root);

            if (XRMCardParam != null)
            {
                foreach (XRMCardParam _XRMCardParam in XRMCardParam)
                {
                    XmlNode a_tag = res.CreateElement("TAG");
                    a_tag.InnerText = _XRMCardParam.TAG;
                    p_root.AppendChild(a_tag);

                    XmlNode a_val = res.CreateElement("VAL");
                    a_val.InnerText = _XRMCardParam.VAL;
                    p_root.AppendChild(a_val);
                }
            }
            return res;
        }

        #region ArrestAcc
        public static XRMArrestAccRes ArestAccMethod(OracleConnection connection, XRMArrestAccReq req)
        {
            var result = new XRMArrestAccRes();
            using (OracleCommand command = connection.CreateCommand())
            {
                command.CommandText = @"BEGIN
                                              bars.xrm_integration_oe.blk_change(:p_transactionid,
                                                                            :p_branch,
                                                                            :p_nls,
                                                                            :p_kv,
                                                                            :p_blkd,
                                                                            :p_blkk,
                                                                            :p_info_out);
                                            END;";

                command.Parameters.Clear();
                command.Parameters.Add("p_transactionid", OracleDbType.Decimal, req.TransactionId, ParameterDirection.Input);
                command.Parameters.Add("p_branch", OracleDbType.Varchar2, req.Branch, ParameterDirection.Input);
                command.Parameters.Add("p_nls", OracleDbType.Varchar2, req.Nls, ParameterDirection.Input);
                command.Parameters.Add("p_kv", OracleDbType.Int16, req.Kv, ParameterDirection.Input);
                command.Parameters.Add("p_blkd", OracleDbType.Int16, req.Blkd, ParameterDirection.Input);
                command.Parameters.Add("p_blkk", OracleDbType.Int16, req.Blkk, ParameterDirection.Input);
                command.Parameters.Add("p_info_out", OracleDbType.Varchar2, 1000, result.message, ParameterDirection.Output);
                command.ExecuteNonQuery();

                result.status = "OK";
                result.message = Convert.ToString(command.Parameters["p_info_out"].Value);

                return result;
            }
        }
        #endregion
    }
}
