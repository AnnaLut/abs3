using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Services;
using System.Text;
using System.IO;
using BarsWeb.Areas.OpenCloseDay.Infrastructure.DI.Abstract;
using BarsWeb.Areas.OpenCloseDay.Models;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Implementation;
using Bars.Classes;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace BarsWeb.Areas.OpenCloseDay.Controllers.Api
{
    [AuthorizeApi]
    public class KFileFormPepController : ApiController
    {
        [HttpPost]
        public HttpResponseMessage KfileFormReportBlob(FormReportParam param)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            string filename = String.Empty;
            string path = String.Empty;
            byte[] blob = null;

            //string data = "";
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = @"bars.kfile_form_report_blob";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("p_kodz", OracleDbType.Varchar2, param.kodz, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_encode", OracleDbType.Varchar2, param.encode, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_reptype", OracleDbType.Decimal, param.reptype, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_prior_statement", OracleDbType.Varchar2, param.PriorSqlStatement, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_fname_statement", OracleDbType.Varchar2, param.FnameSqlStatement, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_rep_date", OracleDbType.Date, param.RepDate, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_filename", OracleDbType.Varchar2, 4000, filename, System.Data.ParameterDirection.Output);
                cmd.Parameters.Add("p_path", OracleDbType.Varchar2, 4000, path, System.Data.ParameterDirection.Output);
                cmd.Parameters.Add("p_blob", OracleDbType.Blob, blob, System.Data.ParameterDirection.Output);
                cmd.ExecuteNonQuery();

                filename = ((OracleString)cmd.Parameters["p_filename"].Value).Value;
                path = ((OracleString)cmd.Parameters["p_path"].Value).Value;

                using (OracleBlob Body = (OracleBlob)cmd.Parameters["p_blob"].Value)
                {
                    if (!Body.IsNull)
                    {
                        //OracleBlob Body = (OracleBlob)cmd.Parameters["p_blob"].Value;
                        blob = Body.Value;//Encoding.UTF8.GetBytes(Encoding.GetEncoding(1251).GetString(Body.Value));
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
                }
                //blob = ((Oracle.DataAccess.Types.OracleBlob)cmd.Parameters["p_blob"].Value).Value;

                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }
    }
}