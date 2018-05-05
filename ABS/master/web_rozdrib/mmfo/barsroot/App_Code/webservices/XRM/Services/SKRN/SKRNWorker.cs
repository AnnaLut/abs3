using System;
using System.Data;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Collections.Generic;
using Bars.WebServices.XRM.Services.SKRN.Models;
using Bars.WebServices.XRM.Models;
using System.IO;
using Bars.DocPrint;
using System.Text;
using Bars.Classes;

namespace Bars.WebServices.XRM.Services.SKRN
{
    public static class SkrnWorker
    {
        public static XRMResponse SetDocIsSigned(OracleConnection con, XRMRequest<SetDocIsSignedRequest> request)
        {
            using (OracleCommand cmd = new OracleCommand())
            {
                using (OracleParameter rState = new OracleParameter("p_state", OracleDbType.Decimal, ParameterDirection.Output),
                                        rCode = new OracleParameter("p_result_code", OracleDbType.Decimal, ParameterDirection.Output),
                                         rMsg = new OracleParameter("p_result_message", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output))
                {
                    cmd.Connection = con;
                    cmd.CommandText = "XRM_INTEGRATION_OE.setdocissigned_skrn";
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add(new OracleParameter("p_id", OracleDbType.Varchar2, 4000, request.AdditionalData.TemplateId, ParameterDirection.Input));
                    cmd.Parameters.Add(new OracleParameter("p_nd", OracleDbType.Decimal, request.AdditionalData.Nd, ParameterDirection.Input));
                    cmd.Parameters.Add(new OracleParameter("p_adds", OracleDbType.Decimal, request.AdditionalData.Adds, ParameterDirection.Input));
                    cmd.Parameters.Add(rState);
                    cmd.Parameters.Add(rCode);
                    cmd.Parameters.Add(rMsg);

                    cmd.ExecuteNonQuery();

                    MessageProcessing(rMsg);
                }
            }

            return new XRMResponse();
        }

        public static XRMResponseDetailed<string> TemplatesCreation(OracleConnection con, XRMRequest<TemplatesCrtRequest> request)
        {
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = @"select count(*) from SKRYNKA_ND where nd = :p_nd";
                cmd.Parameters.Add(new OracleParameter("p_nd", OracleDbType.Decimal, request.AdditionalData.Nd, ParameterDirection.Input));

                var _count = cmd.ExecuteScalar();
                int count = null == _count ? 0 : Convert.ToInt32(_count);
                if (count <= 0) throw new System.Exception(string.Format("Договору з номером \"{0}\" не знайдено", request.AdditionalData.Nd));
            }

            string templatePath;
            string[] tmp = request.AdditionalData.TemplateId.Split('.');
            if (tmp.Length == 2)
                templatePath = FrxDoc.GetTemplatePathByFileName(request.AdditionalData.TemplateId + ".frx");
            else
                templatePath = FrxDoc.GetTemplatePathByFileName(tmp[0] + ".frx");

            FrxParameters pars = new FrxParameters();
            pars.Add(new FrxParameter("p_nd", TypeCode.Int32, request.AdditionalData.Nd));
            pars.Add(new FrxParameter("p_rnk", TypeCode.Int64, request.AdditionalData.Rnk));

            FrxDoc doc = new FrxDoc(templatePath, pars, null);
            byte[] content;

            using (MemoryStream str = new MemoryStream())
            {
                doc.ExportToMemoryStream(FrxExportTypes.Pdf, str);
                content = str.ToArray();
            }

            return new XRMResponseDetailed<string>()
            {
                Results = Convert.ToBase64String(content)
            };
        }

        public static XRMResponseDetailed<DocumentsByDealResponse> GetDocsByDeal(OracleConnection con, XRMRequest<DocsByDealRequest> request)
        {
            XRMResponseDetailed<DocumentsByDealResponse> response = new XRMResponseDetailed<DocumentsByDealResponse>()
            {
                Results = new DocumentsByDealResponse()
                {
                    Documents = new List<DocumentModel>()
                }
            };

            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "select * from table(XRM_INTEGRATION_OE.getdocsbydeal_skrn(:p_nd))";
                cmd.BindByName = true;
                cmd.Parameters.Add("p_nd", OracleDbType.Decimal, request.AdditionalData.Nd, ParameterDirection.Input);

                using (OracleDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        int _ref = reader.GetOrdinal("REF");
                        int _DatD = reader.GetOrdinal("DATD");
                        int _NlsA = reader.GetOrdinal("NLSA");
                        int _KvA = reader.GetOrdinal("KVA");
                        int _SA = reader.GetOrdinal("SA");
                        int _NlsB = reader.GetOrdinal("NLSB");
                        int _KvB = reader.GetOrdinal("KVB");
                        int _SB = reader.GetOrdinal("SB");
                        int _Nazn = reader.GetOrdinal("NAZN");

                        while (reader.Read())
                        {
                            DocumentModel doc = new DocumentModel();

                            doc.Ref = reader.IsDBNull(_ref) ? null : (long?)reader.GetDecimal(_ref);
                            doc.DatD = reader.IsDBNull(_DatD) ? null : (DateTime?)reader.GetDateTime(_DatD);
                            doc.NlsA = reader.IsDBNull(_NlsA) ? "" : reader.GetString(_NlsA);
                            doc.KvA = reader.IsDBNull(_KvA) ? null : (int?)reader.GetInt32(_KvA);
                            doc.SA = reader.IsDBNull(_SA) ? null : (decimal?)reader.GetDecimal(_SA);

                            doc.NlsB = reader.IsDBNull(_NlsB) ? "" : reader.GetString(_NlsB);
                            doc.KvB = reader.IsDBNull(_KvB) ? null : (int?)reader.GetInt32(_KvB);
                            doc.SB = reader.IsDBNull(_SB) ? null : (decimal?)reader.GetDecimal(_SB);

                            doc.Nazn = reader.IsDBNull(_Nazn) ? "" : reader.GetString(_Nazn);

                            response.Results.Documents.Add(doc);
                        }
                    }
                }
            }
            return response;
        }

        public static XRMResponseDetailed<OpenNewBoxResponse> OpenNewSafeDeal(OracleConnection con, XRMRequest<OpenNewDealRequest> request)
        {
            XRMResponseDetailed<OpenNewBoxResponse> response = new XRMResponseDetailed<OpenNewBoxResponse>();

            using (OracleCommand cmd = new OracleCommand())
            {
                using (OracleParameter dealId = new OracleParameter("p_deal_id", OracleDbType.Decimal, ParameterDirection.Output),
                                        rCode = new OracleParameter("p_resultcode", OracleDbType.Decimal, ParameterDirection.Output),
                                         rMsg = new OracleParameter("p_resultmessage", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output))
                {
                    cmd.Connection = con;
                    cmd.CommandText = "XRM_INTEGRATION_OE.OPEN_SAFE_DEPOSIT";
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add(new OracleParameter("p_n_sk", OracleDbType.Decimal, request.AdditionalData.NSk, ParameterDirection.Input));
                    cmd.Parameters.Add(new OracleParameter("p_o_sk", OracleDbType.Decimal, request.AdditionalData.OSk, ParameterDirection.Input));
                    cmd.Parameters.Add(new OracleParameter("p_keynumber", OracleDbType.Varchar2, 4000, request.AdditionalData.KeyNumber, ParameterDirection.Input));
                    cmd.Parameters.Add(new OracleParameter("p_keycount", OracleDbType.Decimal, request.AdditionalData.KeyCount, ParameterDirection.Input));
                    cmd.Parameters.Add(new OracleParameter("p_dealnum", OracleDbType.Varchar2, 4000, request.AdditionalData.NDoc, ParameterDirection.Input));
                    cmd.Parameters.Add(new OracleParameter("p_tarif_id", OracleDbType.Decimal, request.AdditionalData.TarifId, ParameterDirection.Input));
                    cmd.Parameters.Add(new OracleParameter("p_dealstartdate", OracleDbType.Date, request.AdditionalData.DealStartDate, ParameterDirection.Input));
                    cmd.Parameters.Add(new OracleParameter("p_dealenddate", OracleDbType.Date, request.AdditionalData.DealEndDate, ParameterDirection.Input));
                    cmd.Parameters.Add(new OracleParameter("p_rnk", OracleDbType.Decimal, request.AdditionalData.Rnk, ParameterDirection.Input));
                    cmd.Parameters.Add(dealId);
                    cmd.Parameters.Add(rCode);
                    cmd.Parameters.Add(rMsg);

                    cmd.ExecuteNonQuery();

                    MessageProcessing(rMsg);

                    OracleDecimal _dealId = (OracleDecimal)dealId.Value;
                    if (_dealId.IsNull)
                    {
                        throw new System.Exception("Процедура не повернула значення ID договору.");
                    }

                    response.Results = new OpenNewBoxResponse()
                    {
                        Nd = Convert.ToInt64(_dealId.Value)
                    };
                }
            }
            return response;
        }

        public static XRMResponse CloseSafeDeal(OracleConnection con, XRMRequest<CloseDealRequest> request)
        {
            XRMResponse response = new XRMResponse();

            using (OracleCommand cmd = new OracleCommand())
            {
                using (OracleParameter rCode = new OracleParameter("p_resultcode", OracleDbType.Decimal, ParameterDirection.Output),
                                        rMsg = new OracleParameter("p_resultmessage", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output))
                {
                    cmd.Connection = con;
                    cmd.CommandText = "XRM_INTEGRATION_OE.СLOSE_CONTRACTLEASE";
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add(new OracleParameter("p_n_sk", OracleDbType.Decimal, request.AdditionalData.NSk, ParameterDirection.Input));
                    cmd.Parameters.Add(new OracleParameter("p_nd", OracleDbType.Decimal, request.AdditionalData.Nd, ParameterDirection.Input));
                    cmd.Parameters.Add(new OracleParameter("p_userid", OracleDbType.Decimal, null, ParameterDirection.Input));
                    cmd.Parameters.Add(new OracleParameter("p_sum", OracleDbType.Decimal, null, ParameterDirection.Input));
                    cmd.Parameters.Add(new OracleParameter("p_ndoc", OracleDbType.Decimal, null, ParameterDirection.Input));
                    cmd.Parameters.Add(rCode);
                    cmd.Parameters.Add(rMsg);

                    cmd.ExecuteNonQuery();

                    MessageProcessing(rMsg);
                }
            }
            return response;
        }

        public static XRMResponse OperDepSkrn(OracleConnection con, XRMRequest<OperDepSkrnRequest> request)
        {
            using (OracleCommand cmd = new OracleCommand())
            {
                using (OracleParameter rCode = new OracleParameter("p_resultcode", OracleDbType.Decimal, ParameterDirection.Output),
                                        rMsg = new OracleParameter("p_resultmessage", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output))
                {
                    cmd.Connection = con;
                    cmd.CommandText = "XRM_INTEGRATION_OE.oper_dep_skrn";
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add(new OracleParameter("p_dat", OracleDbType.Date, request.AdditionalData.DateFrom, ParameterDirection.Input));
                    cmd.Parameters.Add(new OracleParameter("p_dat2", OracleDbType.Date, request.AdditionalData.DateTo, ParameterDirection.Input));
                    cmd.Parameters.Add(new OracleParameter("p_n_sk", OracleDbType.Decimal, request.AdditionalData.NSk, ParameterDirection.Input));
                    cmd.Parameters.Add(new OracleParameter("p_mode", OracleDbType.Decimal, request.AdditionalData.OperationCode, ParameterDirection.Input));
                    cmd.Parameters.Add(new OracleParameter("p_nd", OracleDbType.Decimal, request.AdditionalData.Nd, ParameterDirection.Input));
                    cmd.Parameters.Add(new OracleParameter("p_userid", OracleDbType.Decimal, null, ParameterDirection.Input));
                    cmd.Parameters.Add(new OracleParameter("p_sum", OracleDbType.Decimal, request.AdditionalData.Sum, ParameterDirection.Input));
                    cmd.Parameters.Add(new OracleParameter("p_ndoc", OracleDbType.Varchar2, 4000, request.AdditionalData.NDoc, ParameterDirection.Input));
                    cmd.Parameters.Add(rCode);
                    cmd.Parameters.Add(rMsg);

                    cmd.ExecuteNonQuery();

                    MessageProcessing(rMsg);
                }
            }

            return new XRMResponse();
        }

        public static XRMResponse MergeAttorney(OracleConnection con, XRMRequest<MergeAttorney> request)
        {
            using (OracleCommand cmd = new OracleCommand())
            {
                cmd.Connection = con;
                cmd.CommandText = "XRM_INTEGRATION_OE.Merge_Skrynka_Attorney";
                cmd.CommandType = CommandType.StoredProcedure;

                object cDate = request.AdditionalData.CancelDate == null ? null : request.AdditionalData.CancelDate.ToString("dd/MM/yyyy");

                cmd.Parameters.Add(new OracleParameter("p_nd", OracleDbType.Decimal, request.AdditionalData.Nd, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_rnk", OracleDbType.Decimal, request.AdditionalData.Rnk, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_date_from", OracleDbType.Varchar2, 4000, request.AdditionalData.DateFrom.ToString("dd/MM/yyyy"), ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_date_to", OracleDbType.Varchar2, 4000, request.AdditionalData.DateTo.ToString("dd/MM/yyyy"), ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_cancel_date", OracleDbType.Varchar2, 4000, cDate, ParameterDirection.Input));

                cmd.ExecuteNonQuery();
            }

            return new XRMResponse();
        }

        private static void MessageProcessing(OracleParameter msg)
        {
            OracleString _rMsg = (OracleString)msg.Value;
            if (!_rMsg.IsNull && !string.IsNullOrWhiteSpace(_rMsg.Value) && _rMsg.Value.ToUpper() != "OK")
            {
                throw new System.Exception(_rMsg.Value);
            }
        }

        public static XRMResponseDetailed<PrintDocByRefResponse> PrintDocByRef(OracleConnection con, XRMRequest<PrintDocByRefRequest> request)
        {
            XRMResponseDetailed<PrintDocByRefResponse> response = new XRMResponseDetailed<PrintDocByRefResponse>()
            {
                Results = new PrintDocByRefResponse()
                {
                    Extension = "HTML"
                }
            };


            //XRMResponseDetailed<PrintDocByRefResponse> response = new XRMResponseDetailed<PrintDocByRefResponse>()
            //{
            //    Results = new PrintDocByRefResponse()
            //    {
            //        Extension = "PDF"
            //    }
            //};

            //FrxParameters pars = new FrxParameters();
            //pars.Add(new FrxParameter("p_ref_c", TypeCode.Decimal, request.AdditionalData.Reference));

            //string frxName = DocInput.DocService.GetPdfFileName(Convert.ToDecimal(request.AdditionalData.Reference));

            //if (!string.IsNullOrWhiteSpace(frxName))
            //{
            //    string templatePath = FrxDoc.GetTemplatePathByFileName(frxName);
            //    FrxDoc doc = new FrxDoc(templatePath, pars, null);

            //    using (MemoryStream str = new MemoryStream())
            //    {
            //        doc.ExportToMemoryStream(FrxExportTypes.Pdf, str);
            //        response.Results.Content = Convert.ToBase64String(str.ToArray());
            //    }
            //}
            //else
            //{
            bool printBM = 1 == request.AdditionalData.PrintBuhModel;

            cDocPrint ourTick = new cDocPrint(con, long.Parse(request.AdditionalData.Reference), FrxDoc.GetTemplatePathByFileName(""), printBM, false);
            response.Results.Content = Convert.ToBase64String(CreateHtmlF(ourTick.GetTicketFileName()));
            //}

            return response;
        }

        private static byte[] CreateHtmlF(string tmpFile)
        {
            StringBuilder htmlContent = new StringBuilder();
            string txtContent = File.ReadAllText(tmpFile, Encoding.GetEncoding(1251));

            htmlContent.AppendLine("<STYLE>@media Screen{.print_action{DISPLAY: none}} @media Print{.screen_action {DISPLAY: none}}</STYLE>");
            htmlContent.AppendLine("<DIV align=center class=screen_action>");
            htmlContent.AppendLine("<INPUT id=btPrint type=\"button\" value=\"Надрукувати\" style=\"FONT-SIZE:14px;font-weight:bold\" onclick=\"window.print()\"><BR>");
            htmlContent.AppendLine("</DIV>");
            //htmlContent.AppendLine("<PRE style=\"MARGIN-LEFT: 20pt; FONT-SIZE: 8pt; COLOR: black; FONT-FAMILY: 'Courier New'; WIDTH: 300pt; BACKGROUND-COLOR: gainsboro\">");
            htmlContent.AppendLine("<PRE style=\"MARGIN-LEFT: 20pt; FONT-SIZE: 8pt; COLOR: black; FONT-FAMILY: 'Courier New'; WIDTH: 300pt;\">");
            htmlContent.Append(txtContent);
            htmlContent.AppendLine("</PRE>");

            //File.WriteAllText(tmpFile)
            return Encoding.GetEncoding(1251).GetBytes(htmlContent.ToString());
        }
    }

    public static class SomeExts
    {
        public static string ToString(this DateTime? dt, string format)
        {
            if (dt == null) return string.Empty;

            DateTime _dt = (DateTime)dt;

            return _dt.ToString(format);
        }
    }
}


