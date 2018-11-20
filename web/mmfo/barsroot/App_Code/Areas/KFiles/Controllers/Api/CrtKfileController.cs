using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.IO;
using Oracle.DataAccess.Client;
using Bars.Classes;
using Oracle.DataAccess.Types;

namespace BarsWeb.Areas.KFiles.Controllers
{
    [AuthorizeApi]
    public class CrtKfileController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage CrtKfile(int sessId, int corpId)
        {

            string filePath = String.Empty;
            string fileName = String.Empty;
            byte[] kFile = null;

            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand cmd = connection.CreateCommand())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "bars.kfile_pack.crt_kfile";
                    cmd.Parameters.Add("p_sess_id", OracleDbType.Int32, sessId, System.Data.ParameterDirection.Input);
                    cmd.Parameters.Add("p_corp_id", OracleDbType.Int32, corpId, System.Data.ParameterDirection.Input);
                    cmd.Parameters.Add("p_f_path", OracleDbType.Varchar2, 255, null, System.Data.ParameterDirection.Output);
                    cmd.Parameters.Add("p_fname", OracleDbType.Varchar2, 255, null, System.Data.ParameterDirection.Output);
                    cmd.Parameters.Add("p_blob", OracleDbType.Blob, System.Data.ParameterDirection.Output);
                    cmd.ExecuteNonQuery();

                    filePath = cmd.Parameters["p_f_path"].Value.ToString();
                    fileName = cmd.Parameters["p_fname"].Value.ToString();

                    using (OracleBlob blob = (OracleBlob)cmd.Parameters["p_blob"].Value)
                    {
                        kFile = blob.Value;
                    }
                }
            }


            if (kFile != null && kFile.Length > 0)
            {

                if (!Directory.Exists(filePath))
                {
                    DirectoryInfo di = Directory.CreateDirectory(filePath);
                }
                File.WriteAllBytes(Path.Combine(filePath, fileName), kFile);

            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.OK, "Процедура повернула пусте значення");
            }

            return Request.CreateResponse(HttpStatusCode.OK);
        }
    }
}