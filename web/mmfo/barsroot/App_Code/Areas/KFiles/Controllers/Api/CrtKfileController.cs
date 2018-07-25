using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.IO;
using Bars.Classes;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Text;

namespace BarsWeb.Areas.KFiles.Controllers
{
    [AuthorizeApi]
    public class CrtKfileController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage CrtKfile(Int64 sess_id, Int32 corp_id, string kf, string path)
        {
            string filename = String.Empty;
            string kfile = String.Empty;
            byte[] blob = null;

            Encoding windows1251 = Encoding.GetEncoding("windows-1251");

            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = connection.CreateCommand())
            {

                try
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = @"bars.kfile_pack.crt_txt_k_file";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("p_sess_id", OracleDbType.Int64, sess_id, System.Data.ParameterDirection.Input);
                    cmd.Parameters.Add("p_corp_id", OracleDbType.Int32, corp_id, System.Data.ParameterDirection.Input);
                    cmd.Parameters.Add("p_kf",      OracleDbType.Varchar2, kf, System.Data.ParameterDirection.Input);
                    cmd.Parameters.Add("p_fname",   OracleDbType.Varchar2, 255, filename, System.Data.ParameterDirection.InputOutput);
                    cmd.Parameters.Add("p_k_file",  OracleDbType.Clob, System.Data.ParameterDirection.Output);
                    cmd.ExecuteNonQuery();

                    filename = cmd.Parameters["p_fname"].Status == OracleParameterStatus.NullFetched ? String.Empty : cmd.Parameters["p_fname"].Value.ToString();

                    if (cmd.Parameters["p_k_file"].Status != OracleParameterStatus.NullFetched)
                        using (OracleClob RespClob = (OracleClob)cmd.Parameters["p_k_file"].Value)
                        {
                            kfile = RespClob.Value;
                        }
                }
                catch (Exception ex)
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
                }
            }

            if (!String.IsNullOrEmpty(kfile))
            {
                blob = Encoding.Convert(Encoding.UTF8, windows1251, Encoding.UTF8.GetBytes(kfile));

                if (!Directory.Exists(path))
                {
                    DirectoryInfo di = Directory.CreateDirectory(path);
                }
                File.WriteAllBytes(path + "\\" + filename, blob);

            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.OK, "Процедура повернула пусте значення");
            }

            return Request.CreateResponse(HttpStatusCode.OK);
        }
    }
}