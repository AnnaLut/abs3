using System;
using System.Data;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Collections.Generic;
using Bars.WebServices.XRM.Services.SKRN.Models;
using Bars.WebServices.XRM.Models;
using Bars.WebServices.XRM.Services.CreateDocuments.Models;
using System.IO;

namespace Bars.WebServices.XRM.Services.CreateDocuments
{
    public static class CreateDocumentsWorker
    {
        public static XRMResponseDetailed<OperProcResponse> ProcessOperation(OracleConnection con, XRMRequest<OperProcRequest> request)
        {
            XRMResponseDetailed<OperProcResponse> response = new XRMResponseDetailed<OperProcResponse>() { Results = new OperProcResponse() };

            using (OracleCommand cmd = new OracleCommand())
            {
                cmd.Connection = con;
                cmd.CommandText = "xrm_intg_cashdesk.doc_service";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new OracleParameter("p_doctype", OracleDbType.Int32, request.AdditionalData.Doctype, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_requestdata", OracleDbType.Clob, request.AdditionalData.RequestData, ParameterDirection.Input));

                OracleParameter rRes = new OracleParameter("p_result", OracleDbType.Clob, ParameterDirection.Output);
                OracleParameter rCode = new OracleParameter("p_resultcode", OracleDbType.Int16, ParameterDirection.Output);
                OracleParameter rMsg = new OracleParameter("p_resultmessage", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);

                cmd.Parameters.Add(rRes);
                cmd.Parameters.Add(rCode);
                cmd.Parameters.Add(rMsg);

                cmd.ExecuteNonQuery();

                MessageProcessing(rMsg);

                OracleClob res = (OracleClob)rRes.Value;
                if (!res.IsNull && !res.IsEmpty) response.Results.ResultData = res.Value;
                else throw new System.Exception("Result data is empty!");
            }
            return response;
        }

        private static void MessageProcessing(OracleParameter msg)
        {
            OracleString _rMsg = (OracleString)msg.Value;
            if (!_rMsg.IsNull && !string.IsNullOrWhiteSpace(_rMsg.Value) && _rMsg.Value.ToUpper() != "OK")
            {
                throw new System.Exception(_rMsg.Value);
            }
        }
    }
}
