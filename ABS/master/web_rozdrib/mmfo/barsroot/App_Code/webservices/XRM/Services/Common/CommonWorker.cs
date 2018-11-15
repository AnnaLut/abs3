using System.Data;
using Oracle.DataAccess.Client;
using Bars.WebServices.XRM.Models;
using Bars.WebServices.XRM.Services.Common.Models;

namespace Bars.WebServices.XRM.Services.Common
{
    public static class CommonWorker
    {
        public static XRMResponseDetailed<SignDocumentsResponse> SignDocuments(OracleConnection con, XRMRequest<SignDocumentsRequest> Request)
        {
            XRMResponseDetailed<SignDocumentsResponse> result = new XRMResponseDetailed<SignDocumentsResponse> { Results = new SignDocumentsResponse() };

            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "bars.ead_pack.doc_sign";
                cmd.CommandType = CommandType.StoredProcedure;

                for (int i = 0; i < Request.AdditionalData.DocumentsId.Count; i++)
                {
                    decimal _docId = Request.AdditionalData.DocumentsId[i];
                    try
                    {
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("p_doc_id", OracleDbType.Decimal, _docId, ParameterDirection.Input);
                        cmd.ExecuteNonQuery();
                        result.Results.Documents.Add(new DocumentResult { DocumentId = _docId, ErrMessage = "", ResultCode = 0 });
                    }
                    catch (System.Exception ex)
                    {
                        result.Results.Documents.Add(new DocumentResult { DocumentId = _docId, ErrMessage = ex.Message, ResultCode = -1 });
                    }
                }
            }

            //if (result.Results.Errors.Count > 0)
            //{
            //    result.ResultCode = -1;
            //    result.ResultMessage = "Один або декілька документів не було підписано.";
            //}

            return result;
        }
    }
}


