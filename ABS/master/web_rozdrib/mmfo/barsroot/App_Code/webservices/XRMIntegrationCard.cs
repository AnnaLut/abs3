using System;
using System.IO;
using System.Data;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using BarsWeb.Core.Logger;
using Bars.Classes;
using System.Xml;
using ICSharpCode.SharpZipLib.Zip;
using Bars.Web.Report;
using ICSharpCode.SharpZipLib.Core;
using System.Linq;
using System.Collections.Generic;
using BarsWeb.Areas.Kernel.Models;
using Bars.Oracle;
using System.Collections;
using System.Xml.Serialization;

/// <summary>
/// XRMIntegrationCar сервис интеграции с Единым окном (открытие картсчета и депозитного договора)
/// v. 2017-01-30 + XRMCardCreditReq, XRMCardCreditRes
/// </summary>
/// 
namespace Bars.WebServices
{
    #region cardsconstruct

    public class XRMCards
    {       
        public class XRMOpenCard
        {
            public class XRMOpenCardReq
            {
                public Decimal TransactionId;
                public String UserLogin;
                public Int16 OperationType;
                public Int64 KF;
                public String Branch;
                public Int64 Rnk;
                public String Nls;
                public String Cardcode;
                public String Embfirstname;
                public String Emblastname;
                public String Secname;
                public String Work;
                public String Office;
                public DateTime? Wdate;
                public Int64? Salaryproect;
                public Int32 Term;
                public String Branchissue;
                public String Barcode;
                public String Cobrandid;
            }
            public class XRMOpenCardResult
            {
                public Decimal nd;
                public Decimal acc;
                public String NLS;
                public String daos;
                public String date_begin;
                public Int32 status;
                public Int32 blkd;
                public Int32 blkk;
                public String dkbo_num;
                public String dkbo_in;
                public String dkbo_out;
                public Int32 ResultCode;
                public String ResultMessage;
            }
            public static XRMOpenCardResult ProcOpenCard(XRMOpenCardReq CardParams,OracleConnection con)
            {
                XRMOpenCardResult OCardRes = new XRMOpenCardResult();
                OracleCommand cmd = con.CreateCommand();
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
                    cmd.Parameters.Add("p_wdate", OracleDbType.Date, XRMIntegrationUtl.GmtToLocal(CardParams.Wdate), ParameterDirection.Input);
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
                finally
                {
                    cmd.Dispose();
                }
            }
        }
        public class XRMInstant
        {
            public class XRMInstantDict
            {
                public String ProductCode;
                public String ProductName;
                public String CardCode;
                public String CardName;
                public String KV;
            }
            public class XRMInstantList
            {
                public String NLS;
                public String KV;
                public String Branch;
                public String ErrorMessage;
            }
            public class XRMInstantOrderReq
            {
                public Decimal TransactionId;
                public String UserLogin;
                public Int16 OperationType;
                public Int64 KF;
                public String CardCode;
                public String Branch;
                public Int16 CardCount;
            }
            public static List<XRMInstantDict> XRMGetInstantDict()
            {
                var XRMInstantDictionary = new List<XRMInstantDict>();

                OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
                OracleCommand cmdGetInstant = con.CreateCommand();
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
                                XRMInstantDict.ProductCode = XRMIntegrationUtl.OracleHelper.GetString(reader, idproductCode);
                                XRMInstantDict.ProductName = XRMIntegrationUtl.OracleHelper.GetString(reader, idproductName);
                                XRMInstantDict.CardCode = XRMIntegrationUtl.OracleHelper.GetString(reader, idCardCode);
                                XRMInstantDict.CardName = XRMIntegrationUtl.OracleHelper.GetString(reader, idCardName);
                                XRMInstantDict.KV = XRMIntegrationUtl.OracleHelper.GetString(reader, idKV);
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
                finally
                {
                    cmdGetInstant.Dispose();
                    con.Close();
                    con.Dispose();
                }
            }
            public static XRMInstantList[] OrderInstant(Decimal TransactionId, String Cardcode, String Branch, Int16 CardCount, OracleConnection connect)
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
                                XRMInstantList.NLS = XRMIntegrationUtl.OracleHelper.GetString(reader, idNLS);
                                XRMInstantList.KV = XRMIntegrationUtl.OracleHelper.GetString(reader, idKV);
                                XRMInstantList.Branch = XRMIntegrationUtl.OracleHelper.GetString(reader, idBranch);
                                XRMInstantList.ErrorMessage = "Ok";
                                XRMInstantListSet[rowCounter++] = XRMInstantList;
                                if (rowCounter % 100 == 0)
                                    Array.Resize(ref XRMInstantListSet, rowCounter + 100);
                            }
                        }
                        Array.Resize(ref XRMInstantListSet, rowCounter++);
                    }
                }
                return XRMInstantListSet;
            }
        }
        [Serializable()]
        public class XRMCardSetCredit
        {
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
                    StreamReader sr = new StreamReader(filepath, System.Text.Encoding.GetEncoding(1251));
                    StreamWriter writer = new StreamWriter(ms);
                    try
                    {
                        String str = sr.ReadToEnd();
                        writer.Write(str);
                        writer.Flush();
                    }
                    finally
                    {
                        sr.Close();
                        sr.Dispose();
                        writer.Close();
                        writer.Dispose();
                    }
                    ms.Position = 0;
                    bytes = ms.ToArray();
                    File.Delete(fullpath);
                }
                return bytes;
            }
            public class XRMCardCreditReq
            {
                public Decimal TransactionId;
                public String UserLogin;
                public Int16 OperationType;
                public Int64 KF;                //delete this
                public long[] acc;
                public decimal maxSum;
                public decimal desiredSum;
                public decimal installedSum;
                public string[] template;
            }
            public class XRMCardCreditRes
            {
                public long[] acc;
                public byte[] Docs;
                public int ResultCode;
                public string ResultMessage;
            }
            public static XRMCardCreditRes SetCardCredit(XRMCardCreditReq XRMCardCreditReq, OracleConnection connect)
            {
                XRMCardCreditRes XRMCardCreditRes = new XRMCardCreditRes();
                int i = 0;
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
                    XRMCardCreditRes.Docs = GetFileForPrint(XRMCardCreditReq.acc, XRMCardCreditReq.template, XRMCardCreditReq.maxSum.ToString());
                }
                catch (SystemException e)
                {
                    XRMCardCreditRes.ResultCode = -1;
                    XRMCardCreditRes.ResultMessage = e.InnerException + e.Message;
                }
                return XRMCardCreditRes;
            }
        }
        public class XRMCardParameter
        {
            public class XRMCardParam { public String TAG; public String VAL; public String ERR; }
            public class XRMCardParams
            {
                public Decimal TransactionId;
                public String UserLogin;
                public Int16 OperationType;
                public Int64 KF;
                public String ND;
                public String ErrorMessage;
                public XRMCardParam[] XRMCardParamList;
            }
            public static XRMCardParam[] SetGetCardParam(Decimal TransactionId, XRMCardParams _XRMCardParams, OracleConnection connect)
            {
                XRMCardParam[] XRMCardParamList = new XRMCardParam[100];
                XmlDocument p_doc = null;

                if (_XRMCardParams.XRMCardParamList != null)
                {
                    p_doc = CreateXmlDoc(_XRMCardParams.XRMCardParamList);
                }
                else
                    p_doc = CreateXmlDoc(null);

                using (OracleCommand cmdSetCardParam = new OracleCommand())
                {
                    cmdSetCardParam.Connection = connect;

                    cmdSetCardParam.CommandText = "select TAG, VAL, ERR from table(xrm_integration_oe.SetGetCardParam(:p_TransactionId,:p_nd, :p_xmltags))";
                    cmdSetCardParam.Parameters.Clear();
                    cmdSetCardParam.BindByName = true;
                    cmdSetCardParam.Parameters.Add("p_TransactionId", OracleDbType.Decimal, TransactionId, ParameterDirection.Input);
                    cmdSetCardParam.Parameters.Add("p_nd", OracleDbType.Varchar2, _XRMCardParams.ND, ParameterDirection.Input);
                    cmdSetCardParam.Parameters.Add("p_xmltags", OracleDbType.Clob, p_doc.InnerXml, ParameterDirection.Input);

                    using (OracleDataReader reader = cmdSetCardParam.ExecuteReader())
                    {
                        int rowCounter = 0;
                        if (reader.HasRows)
                        {
                            int idTAG = reader.GetOrdinal("TAG");
                            int idVAL = reader.GetOrdinal("VAL");
                            int idErr = reader.GetOrdinal("ERR");
                            while (reader.Read())
                            {
                                XRMCardParam XRMCardParam = new XRMCardParam();
                                XRMCardParam.TAG = XRMIntegrationUtl.OracleHelper.GetString(reader, idTAG);
                                XRMCardParam.VAL = XRMIntegrationUtl.OracleHelper.GetString(reader, idVAL);
                                XRMCardParam.ERR = XRMIntegrationUtl.OracleHelper.GetString(reader, idErr);

                                XRMCardParamList[rowCounter++] = XRMCardParam;
                                if (rowCounter % 100 == 0)
                                    Array.Resize(ref XRMCardParamList, rowCounter + 100);
                            }
                        }
                        Array.Resize(ref XRMCardParamList, rowCounter++);
                    }
                }
                return XRMCardParamList;
            }
        }
        public static XmlDocument CreateXmlDoc(XRMCardParameter.XRMCardParam[] XRMCardParam)
        {
            XmlDocument res;
            res = new XmlDocument();            
            XmlNode p_root = res.CreateElement("params");
            res.AppendChild(p_root);

            if (XRMCardParam != null)
            {
                foreach (XRMCardParameter.XRMCardParam _XRMCardParam in XRMCardParam)
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

        public class XRMBulkCard {
            public class XRMBulkCardReq
            {
                public Decimal TransactionId;
                public String UserLogin;
                public Int16 OperationType;
                public Int64 KF;
                public string Branch;
                public string ext_id;
                public string type_code;
                public string receiver_url;
                public String request_data;
                public String hash;
            }
            public class XRMBulkCardRes
            {
                public decimal BulkID;
                public int ResultCode;
                public string ResultMessage;
            }

            public class XRMBulkCardTicketReq
            {
                public Decimal TransactionId;
                public String UserLogin;
                public Int16 OperationType;
                public Int64 KF;
                public string Branch;
                public decimal BulkID;
            }
            public class XRMBulkCardTicketRes
            {
                public string Ticket;
                public int ResultCode;
                public string ResultMessage;
            }
            public static XRMBulkCardRes XRMBulkCardProc(XRMBulkCardReq XRMBulkCardReq, OracleConnection connect)
            {
                XRMBulkCardRes XRMBulkCardRes = new XRMBulkCardRes();
                OracleCommand cmdBulkCardParam = new OracleCommand();
                try
                {
                    cmdBulkCardParam.Connection = connect;
                    cmdBulkCardParam.CommandType = CommandType.StoredProcedure;
                    cmdBulkCardParam.CommandText = "xrm_integration_oe.CardBulkInsert";
                    cmdBulkCardParam.Parameters.Clear();
                    cmdBulkCardParam.BindByName = true;
                    cmdBulkCardParam.Parameters.Add("p_unit_type_code", OracleDbType.Varchar2, XRMBulkCardReq.type_code, ParameterDirection.Input);
                    cmdBulkCardParam.Parameters.Add("p_ext_id", OracleDbType.Varchar2, XRMBulkCardReq.ext_id, ParameterDirection.Input);
                    cmdBulkCardParam.Parameters.Add("p_receiver_url", OracleDbType.Varchar2, XRMBulkCardReq.receiver_url, ParameterDirection.Input);
                    cmdBulkCardParam.Parameters.Add("p_request_data", OracleDbType.Clob, XRMBulkCardReq.request_data, ParameterDirection.Input);
                    cmdBulkCardParam.Parameters.Add("p_hash", OracleDbType.Clob, XRMBulkCardReq.hash, ParameterDirection.Input);
                    cmdBulkCardParam.Parameters.Add("p_state", OracleDbType.Decimal, XRMBulkCardRes.ResultCode, ParameterDirection.Output);
                    cmdBulkCardParam.Parameters.Add("p_msg", OracleDbType.Varchar2, 4000, XRMBulkCardRes.ResultMessage, ParameterDirection.Output);
                    cmdBulkCardParam.Parameters.Add("p_bulkid", OracleDbType.Decimal, XRMBulkCardRes.BulkID, ParameterDirection.Output);

                    cmdBulkCardParam.ExecuteNonQuery();
                    object resstate = cmdBulkCardParam.Parameters["p_state"].Value;
                    object resmsg = cmdBulkCardParam.Parameters["p_msg"].Value;
                    object res = cmdBulkCardParam.Parameters["p_bulkid"].Value;
                    XRMBulkCardRes.ResultCode = Convert.ToInt16((resstate == null || ((OracleDecimal)resstate).IsNull) ? -2 : ((OracleDecimal)resstate).Value);
                    XRMBulkCardRes.ResultMessage = (resmsg == null || ((OracleString)resmsg).IsNull) ? "" : ((OracleString)resmsg).Value;
                    XRMBulkCardRes.BulkID = (res == null || ((OracleDecimal)res).IsNull) ? -2 : ((OracleDecimal)res).Value;
                }
                catch (SystemException e)
                {
                    XRMBulkCardRes.ResultCode = -1;
                    XRMBulkCardRes.ResultMessage = "XRMBulkCardProc: error =" + e.Message;
                }
                finally
                {
                    cmdBulkCardParam.Dispose();
                }
                return XRMBulkCardRes;
            }
            public static XRMBulkCardTicketRes XRMBulkCardTicket(XRMBulkCardTicketReq XRMBulkCardTicketReq, OracleConnection connect)
            {
                XRMBulkCardTicketRes XRMBulkCardTicketRes = new XRMBulkCardTicketRes();
                OracleCommand cmdBulkCardTicket = new OracleCommand();
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
                finally
                {
                    cmdBulkCardTicket.Dispose();
                }
                return XRMBulkCardTicketRes;
            }
        }
        public class XRMDKBO
        {
            public class XRMDKBOReq {
                public Decimal TransactionId;
                public String UserLogin;
                public Int16 OperationType;
                public Int64 KF;
                public string Branch;
                public decimal RNK;
                public string DealNumber;
                public List<Decimal?> AccList;
                public DateTime? DKBODateFrom;
                public DateTime? DKBODateTo;
            }
            public class XRMDKBORes
            {
                public decimal? DealId;
                public DateTime? StartDate;
                public int ResultCode;
                public string ResultMessage;
                public decimal Rnk;
            }

            public class XRMQuestionnaireDKBOAttrReq
            {
                public string Code;
                public string Value;
            }

            public class XRMQuestionnaireDKBOReq
            {
                public Decimal TransactionId;
                public String UserLogin;
                public Int16 OperationType;
                public string NewDKBOId;
                public XRMQuestionnaireDKBOAttrReq[] Attributes;
            }

            public class XRMQuestionnaireDKBOAttrRes
            {
                public string AttributeCode;
                public string AttributeMessage;
            }

            public class XRMQuestionnaireDKBORes
            {
                public int ResultCode;
                public string ResultMessage;
                public List<XRMQuestionnaireDKBOAttrRes> Answers;
            }
            public static XRMDKBORes MapToDKBO(XRMDKBOReq XRMDKBOReq, OracleConnection con)
            {
                XRMDKBORes XRMDKBORes = new XRMDKBORes();
                OracleCommand cmd = con.CreateCommand();
                try
                {
                    List<Decimal?> acclist = XRMDKBOReq.AccList;
                    cmd.Parameters.Clear();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.BindByName = true;
                    cmd.CommandText = "xrm_integration_oe.MapDKBO";
                    cmd.Parameters.Add("p_TransactionID", OracleDbType.Decimal, XRMDKBOReq.TransactionId, ParameterDirection.Input);
                    cmd.Parameters.Add("p_customer_id", OracleDbType.Decimal, XRMDKBOReq.RNK, ParameterDirection.Input);
                    cmd.Parameters.Add("p_deal_number", OracleDbType.Varchar2, 400, XRMDKBOReq.DealNumber, ParameterDirection.Input);
                    Decimal?[] data = acclist.Select(i => (Decimal?)i).ToArray();
                    OracleParameter param = new OracleParameter("p_acc_list", OracleDbType.Array, data.Length, (NumberList)data, ParameterDirection.Input) { UdtTypeName = "NUMBER_LIST", Value = data };
                    cmd.Parameters.Add(param);
                    cmd.Parameters.Add("p_dkbo_date_from", OracleDbType.Date, XRMDKBOReq.DKBODateFrom, ParameterDirection.Input);
                    cmd.Parameters.Add("p_dkbo_date_to", OracleDbType.Date, XRMDKBOReq.DKBODateTo, ParameterDirection.Input);
                    cmd.Parameters.Add("p_deal_id", OracleDbType.Decimal, XRMDKBORes.DealId, ParameterDirection.Output);
                    cmd.Parameters.Add("p_start_date", OracleDbType.Date, XRMDKBORes.StartDate, ParameterDirection.Output);

                    cmd.ExecuteNonQuery();
                    Object res = cmd.Parameters["p_deal_id"].Value;
                    XRMDKBORes.DealId = (((OracleDecimal)res).IsNull ? -1 : ((OracleDecimal)res).Value);
                    Object resdate = cmd.Parameters["p_start_date"].Value;
                    if (!((OracleDate)cmd.Parameters["p_start_date"].Value).IsNull) { XRMDKBORes.StartDate = ((OracleDate)cmd.Parameters["p_start_date"].Value).Value; } else { XRMDKBORes.StartDate = null; }
                    XRMDKBORes.Rnk = XRMDKBOReq.RNK;
                    if (XRMDKBORes.DealId == -1)
                    {
                        XRMDKBORes.DealId = null;
                        XRMDKBORes.ResultCode = -1;
                        XRMDKBORes.ResultMessage = String.Format("Помилка приєднання рахунків {0} до ДКБО клієнта {1} (ДКБО не існує)", String.Join(" , ",acclist), XRMDKBOReq.RNK);
                    }
                }
                catch (System.Exception ex)
                {
                    XRMDKBORes.ResultCode = -1;
                    XRMDKBORes.ResultMessage = "MapToDKBO: error = " + ex.Message;
                }
                finally
                {
                    cmd.Dispose();
                }
                return XRMDKBORes;
            }

            public static XRMQuestionnaireDKBORes QuestionnaireDKBOMethod(XRMQuestionnaireDKBOReq xrmQestionnaireReq, OracleConnection con)
            {
                XRMQuestionnaireDKBORes res = new XRMQuestionnaireDKBORes();
                res.Answers = new List<XRMQuestionnaireDKBOAttrRes>();
                XRMQuestionnaireDKBOAttrRes resTemp = new XRMQuestionnaireDKBOAttrRes();
                using (OracleCommand cmd = con.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "xrm_integration_oe.p_quest_answ_ins";
                    cmd.BindByName = true;
                    for (int i = 0; i < xrmQestionnaireReq.Attributes.Length; i++)
                    {
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
                                resTemp.AttributeCode = xrmQestionnaireReq.Attributes[i].Code;
                                resTemp.AttributeMessage = "Success";
                                res.Answers.Add(resTemp);
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
        }

    }
    #endregion cardsconstruct    
    /// <summary>
    /// Веб-сервіс для взаємодії з системою XRM Єдине вікно
    /// </summary>
    [WebService(Namespace = "http://ws.unity-bars-card.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class XRMIntegrationCard : BarsWebService
    {
        public WsHeader WsHeaderValue;
        private IDbLogger _dbLogger;        

        #region card_method
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public List<XRMCards.XRMOpenCard.XRMOpenCardResult> CreateCardMethod(XRMCards.XRMOpenCard.XRMOpenCardReq[] XRMOpenCard)
        {
            XRMIntegrationUtl XRMUtl = new XRMIntegrationUtl();
            XRMIntegrationUtl.TransactionInfo Trans = new XRMIntegrationUtl.TransactionInfo();
            Decimal TransSuccess = 0;
            List<XRMCards.XRMOpenCard.XRMOpenCardResult> resList = new List<XRMCards.XRMOpenCard.XRMOpenCardResult>(); 
            try
            {
                XRMUtl.LoginADUserInt(XRMOpenCard[0].UserLogin);
                try
                {
                    using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                    {
                        foreach (XRMCards.XRMOpenCard.XRMOpenCardReq CardReq in XRMOpenCard)
                        {
                            XRMCards.XRMOpenCard.XRMOpenCardResult CardRes = new XRMCards.XRMOpenCard.XRMOpenCardResult();
                            Trans.TransactionId = CardReq.TransactionId;
                            Trans.UserLogin = CardReq.UserLogin;
                            Trans.OperationType = CardReq.OperationType;
                            TransSuccess = XRMIntegrationUtl.TransactionCheck(Trans,con);
                            if (TransSuccess == 0)
                            {
                                XRMIntegrationUtl.TransactionCreate(Trans,con);
                                CardRes = XRMCards.XRMOpenCard.ProcOpenCard(CardReq,con);
                                resList.Add(CardRes);
                            }
                            else if (TransSuccess == -1)
                            {
                                CardRes.ResultCode = -1;
                                CardRes.nd = -1;
                                CardRes.ResultMessage = String.Format(XRMIntegrationUtl.TransactionExistsMessage, CardReq.TransactionId);
                                resList.Add(CardRes);
                            }
                            else
                            {
                                CardRes.ResultCode = -1;
                                CardRes.nd = -1;
                                CardRes.ResultMessage = String.Format(XRMIntegrationUtl.TransactionErrorMessage, CardReq.TransactionId);
                                resList.Add(CardRes);
                            }
                        }
                    }
                    return resList;
                }
                catch (System.Exception ex)
                {
                    Int32 resultCode = -1;
                    Decimal ndTemp = -1;
                    resList.Add(new XRMCards.XRMOpenCard.XRMOpenCardResult { ResultCode = resultCode, nd = ndTemp, ResultMessage = ex.Message } );
                    return resList;
                }
            }
            catch (Exception.AutenticationException ex)
            {
                String resultMessage = String.Format("Помилка авторизації: {0}", ex.Message);
                Int32 resultCode = -1;
                Decimal ndTemp = -1;
                resList.Add(new XRMCards.XRMOpenCard.XRMOpenCardResult { ResultMessage = resultMessage, ResultCode = resultCode, nd = ndTemp});
                return resList;
            }
        }
        #endregion card_method

        #region getInstantDict
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public List<XRMCards.XRMInstant.XRMInstantDict> GetInstantDictMethod()
        {
            var XRMInstantDictionary = new List<XRMCards.XRMInstant.XRMInstantDict>();
            using (XRMIntegrationUtl XRMUtl = new XRMIntegrationUtl())
            {
                try
                {
                    XRMUtl.LoginUserInt(System.Configuration.ConfigurationManager.AppSettings["XRM_USER"]);
                    XRMInstantDictionary = XRMCards.XRMInstant.XRMGetInstantDict();
                    return XRMInstantDictionary;
                }
                catch
                {
                    return XRMInstantDictionary;
                }
            }
        }
        #endregion getInstantDict

        #region OrderInstant
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMCards.XRMInstant.XRMInstantList[] OrderInstant(XRMCards.XRMInstant.XRMInstantOrderReq XRMInstantOrderReq)
        {
            using (XRMIntegrationUtl XRMUtl = new XRMIntegrationUtl())
            {
                XRMCards.XRMInstant.XRMInstantList XRMInstantList = new XRMCards.XRMInstant.XRMInstantList();
                XRMCards.XRMInstant.XRMInstantList[] XRMInstantListSet = new XRMCards.XRMInstant.XRMInstantList[XRMInstantOrderReq.CardCount];
                XRMIntegrationUtl.TransactionInfo Trans = new XRMIntegrationUtl.TransactionInfo();
                decimal TransSuccess = 0;
                try
                {
                    XRMUtl.LoginADUserInt(XRMInstantOrderReq.UserLogin);
                    try
                    {
                        using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                        {
                            Trans.TransactionId = XRMInstantOrderReq.TransactionId;
                            Trans.UserLogin = XRMInstantOrderReq.UserLogin;
                            Trans.OperationType = XRMInstantOrderReq.OperationType;
                            TransSuccess = XRMIntegrationUtl.TransactionCheck(Trans, con);
                            if (TransSuccess == 0)
                            {
                                XRMIntegrationUtl.TransactionCreate(Trans, con);
                                XRMInstantListSet = XRMCards.XRMInstant.OrderInstant(XRMInstantOrderReq.TransactionId, XRMInstantOrderReq.CardCode, XRMInstantOrderReq.Branch, XRMInstantOrderReq.CardCount, con);
                            }
                            else if (TransSuccess == -1)
                            {
                                XRMInstantList.ErrorMessage = String.Format(XRMIntegrationUtl.TransactionExistsMessage, XRMInstantOrderReq.TransactionId);
                                Array.Resize(ref XRMInstantListSet, 1);
                                XRMInstantListSet[0] = XRMInstantList;
                            }
                            else
                            {
                                XRMInstantList.ErrorMessage = String.Format(XRMIntegrationUtl.TransactionErrorMessage, XRMInstantOrderReq.TransactionId);
                                Array.Resize(ref XRMInstantListSet, 1);
                                XRMInstantListSet[0] = XRMInstantList;
                            }
                            return XRMInstantListSet;
                        }
                    }
                    catch (System.Exception ex)
                    {
                        XRMInstantList.ErrorMessage = String.Format(XRMIntegrationUtl.TransactionErrorMessage, ex.InnerException);
                        Array.Resize(ref XRMInstantListSet, 1);
                        XRMInstantListSet[0] = XRMInstantList;
                        return XRMInstantListSet;
                    }
                }
                catch (Exception.AutenticationException ex)
                {
                    XRMInstantList.ErrorMessage = String.Format("Ошибка выполнения запроса {0}", ex.InnerException);
                    Array.Resize(ref XRMInstantListSet, 1);
                    XRMInstantListSet[0] = XRMInstantList;
                    return XRMInstantListSet;
                }
            }
        }
        #endregion OrderInstant

        #region CardParams
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMCards.XRMCardParameter.XRMCardParam[] SetCardParam(XRMCards.XRMCardParameter.XRMCardParams XRMCardParamReq)
        {
            using (XRMIntegrationUtl XRMUtl = new XRMIntegrationUtl())
            {
                XRMCards.XRMCardParameter.XRMCardParam[] XRMCardParamSet = new XRMCards.XRMCardParameter.XRMCardParam[1];
                XRMIntegrationUtl.TransactionInfo Trans = new XRMIntegrationUtl.TransactionInfo();
                decimal TransSuccess = 0;
                try
                {
                    XRMUtl.LoginADUserInt(XRMCardParamReq.UserLogin);
                    try
                    {
                        using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                        {
                            Trans.TransactionId = XRMCardParamReq.TransactionId;
                            Trans.UserLogin = XRMCardParamReq.UserLogin;
                            Trans.OperationType = XRMCardParamReq.OperationType;
                            TransSuccess = XRMIntegrationUtl.TransactionCheck(Trans, con);
                            if (TransSuccess == 0)
                            {
                                XRMIntegrationUtl.TransactionCreate(Trans, con);
                                XRMCardParamSet = XRMCards.XRMCardParameter.SetGetCardParam(XRMCardParamReq.TransactionId, XRMCardParamReq, con);
                            }
                            else if (TransSuccess == -1)
                            {
                                XRMCardParamReq.ErrorMessage = String.Format(XRMIntegrationUtl.TransactionExistsMessage, XRMCardParamReq.TransactionId);
                                return XRMCardParamSet;
                            }
                            else
                            {
                                XRMCardParamReq.ErrorMessage = String.Format(XRMIntegrationUtl.TransactionErrorMessage, XRMCardParamReq.TransactionId);
                                return XRMCardParamSet;
                            }
                            return XRMCardParamSet;
                        }
                    }
                    catch
                    {
                        Array.Resize(ref XRMCardParamSet, 1);
                        return XRMCardParamSet;
                    }
                }
                catch (Exception.AutenticationException)
                {
                    Array.Resize(ref XRMCardParamSet, 1);
                    return XRMCardParamSet;
                }
            }
        }
        #endregion CardParams

        #region CardCreditParams+Print
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMCards.XRMCardSetCredit.XRMCardCreditRes SetCardCreditParam(XRMCards.XRMCardSetCredit.XRMCardCreditReq XRMCardCreditReq)
        {
            using (XRMIntegrationUtl XRMUtl = new XRMIntegrationUtl())
            {
                XRMCards.XRMCardSetCredit.XRMCardCreditRes XRMCardCreditRes = new XRMCards.XRMCardSetCredit.XRMCardCreditRes();
                XRMIntegrationUtl.TransactionInfo Trans = new XRMIntegrationUtl.TransactionInfo();
                decimal TransSuccess = 0;
                try
                {
                    XRMUtl.LoginADUserInt(XRMCardCreditReq.UserLogin);
                    using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                    {
                        Trans.TransactionId = XRMCardCreditReq.TransactionId;
                        Trans.UserLogin = XRMCardCreditReq.UserLogin;
                        Trans.OperationType = XRMCardCreditReq.OperationType;
                        TransSuccess = XRMIntegrationUtl.TransactionCheck(Trans, con);
                        if (TransSuccess == 0)
                        {
                            XRMIntegrationUtl.TransactionCreate(Trans, con);
                            XRMCardCreditRes = XRMCards.XRMCardSetCredit.SetCardCredit(XRMCardCreditReq, con);
                        }
                        else if (TransSuccess == -1)
                        {
                            XRMCardCreditRes.ResultMessage = String.Format(XRMIntegrationUtl.TransactionExistsMessage, XRMCardCreditReq.TransactionId);
                            XRMCardCreditRes.ResultCode = -1;
                            return XRMCardCreditRes;
                        }
                        else
                        {
                            XRMCardCreditRes.ResultMessage = String.Format(XRMIntegrationUtl.TransactionErrorMessage, XRMCardCreditReq.TransactionId);
                            XRMCardCreditRes.ResultCode = -1;
                            return XRMCardCreditRes;
                        }
                        return XRMCardCreditRes;
                    }
                }
                catch (System.Exception aex)
                {
                    XRMCardCreditRes.ResultMessage = aex.Message;
                    XRMCardCreditRes.ResultCode = -1;
                    return XRMCardCreditRes;
                }
            }
        }
        #endregion CardCreditParams+Print

        #region BulkCard
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMCards.XRMBulkCard.XRMBulkCardRes BulkCardMethod(XRMCards.XRMBulkCard.XRMBulkCardReq XRMBulkCardReq)
        {
            using (XRMIntegrationUtl XRMUtl = new XRMIntegrationUtl())
            {
                XRMCards.XRMBulkCard.XRMBulkCardRes XRMBulkCardRes = new XRMCards.XRMBulkCard.XRMBulkCardRes();
                XRMIntegrationUtl.TransactionInfo Trans = new XRMIntegrationUtl.TransactionInfo();
                decimal TransSuccess = 0;
                try
                {
                    XRMUtl.LoginADUserInt(XRMBulkCardReq.UserLogin);
                    using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                    {
                        Trans.TransactionId = XRMBulkCardReq.TransactionId;
                        Trans.UserLogin = XRMBulkCardReq.UserLogin;
                        Trans.OperationType = XRMBulkCardReq.OperationType;
                        TransSuccess = XRMIntegrationUtl.TransactionCheck(Trans, con);
                        if (TransSuccess == 0)
                        {
                            XRMIntegrationUtl.TransactionCreate(Trans, con);
                            XRMBulkCardRes = XRMCards.XRMBulkCard.XRMBulkCardProc(XRMBulkCardReq, con);
                        }
                        else if (TransSuccess == -1)
                        {
                            XRMBulkCardRes.ResultMessage = String.Format(XRMIntegrationUtl.TransactionExistsMessage, XRMBulkCardReq.TransactionId);
                            XRMBulkCardRes.ResultCode = -1;
                        }
                        else
                        {
                            XRMBulkCardRes.ResultMessage = String.Format(XRMIntegrationUtl.TransactionErrorMessage, XRMBulkCardReq.TransactionId);
                            XRMBulkCardRes.ResultCode = -1;
                        }
                        return XRMBulkCardRes;
                    }
                }
                catch (System.Exception ex)
                {
                    XRMBulkCardRes.ResultMessage = ex.Message;
                    XRMBulkCardRes.ResultCode = -1;
                    return XRMBulkCardRes;
                }
            }
        }

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMCards.XRMBulkCard.XRMBulkCardTicketRes GetBulkCardTicketMethod(XRMCards.XRMBulkCard.XRMBulkCardTicketReq XRMBulkCardTicketReq)
        {
            using (XRMIntegrationUtl XRMUtl = new XRMIntegrationUtl())
            {
                XRMCards.XRMBulkCard.XRMBulkCardTicketRes XRMBulkCardTicketRes = new XRMCards.XRMBulkCard.XRMBulkCardTicketRes();
                XRMIntegrationUtl.TransactionInfo Trans = new XRMIntegrationUtl.TransactionInfo();
                decimal TransSuccess = 0;
                try
                {
                    XRMUtl.LoginADUserInt(XRMBulkCardTicketReq.UserLogin);
                    using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                    {
                        Trans.TransactionId = XRMBulkCardTicketReq.TransactionId;
                        Trans.UserLogin = XRMBulkCardTicketReq.UserLogin;
                        Trans.OperationType = XRMBulkCardTicketReq.OperationType;
                        TransSuccess = XRMIntegrationUtl.TransactionCheck(Trans, con);
                        if (TransSuccess == 0)
                        {
                            XRMIntegrationUtl.TransactionCreate(Trans, con);
                            XRMBulkCardTicketRes = XRMCards.XRMBulkCard.XRMBulkCardTicket(XRMBulkCardTicketReq, con);
                        }
                        else if (TransSuccess == -1)
                        {
                            XRMBulkCardTicketRes.ResultMessage = String.Format(XRMIntegrationUtl.TransactionExistsMessage, XRMBulkCardTicketReq.TransactionId);
                            XRMBulkCardTicketRes.ResultCode = -1;
                        }
                        else
                        {
                            XRMBulkCardTicketRes.ResultMessage = String.Format(XRMIntegrationUtl.TransactionErrorMessage, XRMBulkCardTicketReq.TransactionId);
                            XRMBulkCardTicketRes.ResultCode = -1;
                        }
                        return XRMBulkCardTicketRes;
                    }
                }
                catch (System.Exception ex)
                {
                    XRMBulkCardTicketRes.ResultMessage = ex.Message;
                    XRMBulkCardTicketRes.ResultCode = -1;
                    return XRMBulkCardTicketRes;
                }
            }
        }
        #endregion BulkCard

        #region DKBO
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public List<XRMCards.XRMDKBO.XRMDKBORes> MapDKBOMethod(XRMCards.XRMDKBO.XRMDKBOReq[] XRMDKBOReqList)
        {
            using (XRMIntegrationUtl XRMUtl = new XRMIntegrationUtl())
            {
                XRMIntegrationUtl.TransactionInfo Trans = new XRMIntegrationUtl.TransactionInfo();
                decimal TransSuccess = 0;
                List<XRMCards.XRMDKBO.XRMDKBORes> resList = new List<XRMCards.XRMDKBO.XRMDKBORes>();
                try
                {
                    XRMUtl.LoginADUserInt(XRMDKBOReqList[0].UserLogin);
                    using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                    {
                        foreach (var reqItem in XRMDKBOReqList)
                        {
                            XRMCards.XRMDKBO.XRMDKBORes res = new XRMCards.XRMDKBO.XRMDKBORes();
                            Trans.TransactionId = reqItem.TransactionId;
                            Trans.UserLogin = reqItem.UserLogin;
                            Trans.OperationType = reqItem.OperationType;
                            TransSuccess = XRMIntegrationUtl.TransactionCheck(Trans, con);
                            if (TransSuccess == 0)
                            {
                                XRMIntegrationUtl.TransactionCreate(Trans, con);
                                res = XRMCards.XRMDKBO.MapToDKBO(reqItem, con);
                                resList.Add(res);
                            }
                            else
                            {
                                res.ResultMessage = TransSuccess == -1 ? String.Format(XRMIntegrationUtl.TransactionExistsMessage, reqItem.TransactionId) : String.Format(XRMIntegrationUtl.TransactionErrorMessage, reqItem.TransactionId);
                                res.ResultCode = -1;
                                resList.Add(res);
                            }
                        }
                    }
                    return resList;
                }
                catch (System.Exception ex)
                {
                    String resultMessage = ex.Message;
                    Int32 resultCode = -1;
                    resList.Add(new XRMCards.XRMDKBO.XRMDKBORes { ResultMessage = resultMessage, ResultCode = resultCode });
                    return resList;
                }
            }
        }

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMCards.XRMDKBO.XRMQuestionnaireDKBORes QuestionnaireDKBO(XRMCards.XRMDKBO.XRMQuestionnaireDKBOReq xrmQuestionnaireDKBOReq)
        {
            using (XRMIntegrationUtl XRMUtl = new XRMIntegrationUtl())
            {
                XRMIntegrationUtl.TransactionInfo Trans = new XRMIntegrationUtl.TransactionInfo();
                decimal TransSuccess = 0;

                XRMCards.XRMDKBO.XRMQuestionnaireDKBORes xrmQuestionnaireDKBORes = new XRMCards.XRMDKBO.XRMQuestionnaireDKBORes();
                try
                {
                    XRMUtl.LoginADUserInt(xrmQuestionnaireDKBOReq.UserLogin);
                    using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                    {
                        Trans.TransactionId = xrmQuestionnaireDKBOReq.TransactionId;
                        Trans.UserLogin = xrmQuestionnaireDKBOReq.UserLogin;
                        Trans.OperationType = xrmQuestionnaireDKBOReq.OperationType;
                        TransSuccess = XRMIntegrationUtl.TransactionCheck(Trans, con);

                        if (TransSuccess == 0)
                        {
                            XRMIntegrationUtl.TransactionCreate(Trans, con);
                            xrmQuestionnaireDKBORes = XRMCards.XRMDKBO.QuestionnaireDKBOMethod(xrmQuestionnaireDKBOReq, con);
                            return xrmQuestionnaireDKBORes;
                        }
                        else if (TransSuccess == -1)
                        {
                            xrmQuestionnaireDKBORes.ResultCode = -1;
                            xrmQuestionnaireDKBORes.ResultMessage = String.Format(XRMIntegrationUtl.TransactionExistsMessage, xrmQuestionnaireDKBOReq.TransactionId);
                        }
                        else
                        {
                            xrmQuestionnaireDKBORes.ResultCode = -1;
                            xrmQuestionnaireDKBORes.ResultMessage = String.Format(XRMIntegrationUtl.TransactionErrorMessage, xrmQuestionnaireDKBOReq.TransactionId);
                        }
                    }
                    return xrmQuestionnaireDKBORes;
                }
                catch (System.Exception ex)
                {
                    xrmQuestionnaireDKBORes.ResultCode = -1;
                    xrmQuestionnaireDKBORes.ResultMessage = ex.Message;
                    return xrmQuestionnaireDKBORes;
                }
            }
        }
        #endregion DKBO

        #region ArrestAcc
        public class XRMArrestAccReq
        {
            public string UserLogin;
            public decimal TransactionId;
            public string Branch;
            public string Nls;
            public int Kv;
            public int Blkd;
            public int Blkk;
        }

        public class XRMArrestAccRes
        {
            public string status;
            public string message;
        }

        public void LoginADUserInt(String userName)
        {
            // информация о текущем пользователе
            try
            {
                InitOraConnection();
                // установка первичных параметров
                ClearParameters();
                SetParameters("p_session_id", DB_TYPE.Varchar2, Session.SessionID, DIRECTION.Input);
                SetParameters("p_login_name", DB_TYPE.Varchar2, userName, DIRECTION.Input);
                SetParameters("p_authentication_mode", DB_TYPE.Varchar2, "ACTIVE DIRECTORY", DIRECTION.Input);
                SetParameters("p_hostname", DB_TYPE.Varchar2, RequestHelpers.GetClientIpAddress(HttpContext.Current.Request), DIRECTION.Input);
                SetParameters("p_appname", DB_TYPE.Varchar2, "barsroot", DIRECTION.Input);
                SQL_PROCEDURE("bars.bars_login.login_user");

                ClearParameters();
                SetParameters("p_info", DB_TYPE.Varchar2,
                    String.Format("XRMIntegration: авторизация. Хост {0}, пользователь {1} ", RequestHelpers.GetClientIpAddress(HttpContext.Current.Request), userName),
                    DIRECTION.Input);
                SQL_PROCEDURE("bars_audit.info");
            }
            finally
            {
                DisposeOraConnection();
            }

            // Если выполнили установку параметров
            Session["UserLoggedIn"] = true;
        }


        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMArrestAccRes ArrestAcc(XRMArrestAccReq XRMArrestAccReq)
        {
            XRMArrestAccRes result = new XRMArrestAccRes();
            XRMIntegrationUtl XRMUtl = new XRMIntegrationUtl();
            try
            {
                LoginADUserInt(XRMArrestAccReq.UserLogin);
                using (OracleConnection connection = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                {
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
                        command.Parameters.Add("p_transactionid", OracleDbType.Decimal, XRMArrestAccReq.TransactionId, ParameterDirection.Input);
                        command.Parameters.Add("p_branch", OracleDbType.Varchar2, XRMArrestAccReq.Branch, ParameterDirection.Input);
                        command.Parameters.Add("p_nls", OracleDbType.Varchar2, XRMArrestAccReq.Nls, ParameterDirection.Input);
                        command.Parameters.Add("p_kv", OracleDbType.Int16, XRMArrestAccReq.Kv, ParameterDirection.Input);
                        command.Parameters.Add("p_blkd", OracleDbType.Int16, XRMArrestAccReq.Blkd, ParameterDirection.Input);
                        command.Parameters.Add("p_blkk", OracleDbType.Int16, XRMArrestAccReq.Blkk, ParameterDirection.Input);
                        command.Parameters.Add("p_info_out", OracleDbType.Varchar2, 1000, result.message, ParameterDirection.Output);
                        command.ExecuteNonQuery();

                        result.status = "OK";
                        result.message = Convert.ToString(command.Parameters["p_info_out"].Value);
                    }
                }
            }
            catch (System.Exception ex)
            {
                result.status = "ERROR";
                result.message = ex.Message;
            }
            return result;
        }
        #endregion DKBO
    }
}

