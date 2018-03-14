using BarsWeb.Areas.Transp.Models;
using Bars.Classes;
using barsroot.core;
using BarsWeb.Areas.Transp.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Transp.Models.ApiModels;
using BarsWeb.Models;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.IO;
using System.Xml;
using System.Runtime.Serialization.Json;
using System.Text;

namespace BarsWeb.Areas.Transp.Infrastructure.DI.Implementation
{
    public class TranspRepository : ITranspRepository
    {

        public TranspRepository()
        {
        }

       /* public transp_reqtype GetReqType(string req_type)
        {
            using (OracleConnection con = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand cmd = con.CreateCommand())
                {
                    try
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "bars.ins_ewa_mgr.get_purpose";
                        cmd.Parameters.Add("p_clob", OracleDbType.XmlType, p_xml, ParameterDirection.Input);
                        cmd.Parameters.Add("p_purpose", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                        cmd.Parameters.Add("p_errcode", OracleDbType.Decimal, ParameterDirection.Output);
                        cmd.Parameters.Add("p_errmessage", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);

                        cmd.ExecuteNonQuery();


                        if (cmd.Parameters["p_errcode"].Status == OracleParameterStatus.NullFetched || Convert.ToInt32(cmd.Parameters["p_errcode"].Value.ToString()) == 0)
                        {
                            response.message = cmd.Parameters["p_purpose"].Status == OracleParameterStatus.NullFetched ? String.Empty : cmd.Parameters["p_purpose"].Value.ToString();
                        }
                        else
                        {
                            response.message = cmd.Parameters["p_errmessage"].Value.ToString();
                            response.success = false;
                        }


                    }
                    catch (Exception e)
                    {


                        response.success = false;
                        response.message = e.Message;
                        return Request.CreateResponse(HttpStatusCode.InternalServerError, response);


                    }

                    return Request.CreateResponse(HttpStatusCode.OK, response);

                }
            }
        }


    */





































      

        /// <summary>
        /// Package import
        /// </summary>
        /// <param name="packageId"></param>
        /// <param name="packageName"></param>
        /// <param name="packageData"></param>
        /// <returns></returns>
        public ResponseData InsertPackage(decimal packageId, string packageName, string packageMfo, byte[] packageData)
        {
            var connection = OraConnector.Handler.UserConnection;
            var result = new ResponseData();
            try
            {
                var cmd = connection.CreateCommand();
                cmd.Parameters.Clear();
                cmd.CommandText = @"
                        begin
                             bars.pfu_ru_epp_utl.import_files(:p_fileid, :p_filecode, :p_kf, :p_sign, :p_file_data, :p_state, :p_message, :p_stack);
                        end;";
                cmd.Parameters.Add("p_fileid", OracleDbType.Decimal, packageId, ParameterDirection.Input);
                cmd.Parameters.Add("p_filecode", OracleDbType.Varchar2, packageName, ParameterDirection.Input);
                cmd.Parameters.Add("p_kf", OracleDbType.Varchar2, packageMfo, ParameterDirection.Input);
                cmd.Parameters.Add("p_sign", OracleDbType.Varchar2, null, ParameterDirection.Input);
                cmd.Parameters.Add("p_file_data", OracleDbType.Blob, packageData, ParameterDirection.Input);
                cmd.Parameters.Add(new OracleParameter("p_state", OracleDbType.Decimal)
                {
                    Size = 10,
                    Direction = ParameterDirection.Output
                });
                cmd.Parameters.Add(new OracleParameter("p_message", OracleDbType.Varchar2)
                {
                    Size = 2000,
                    Direction = ParameterDirection.Output
                });
                cmd.Parameters.Add(new OracleParameter("p_stack", OracleDbType.Varchar2)
                {
                    Size = 4000,
                    Direction = ParameterDirection.Output
                });

                cmd.ExecuteNonQuery();

                result.Result = new ResponseDataResult
                {
                    State = Convert.ToInt32(cmd.Parameters["p_state"].Value.ToString())
                };

                if (!((OracleString)cmd.Parameters["p_message"].Value).IsNull)
                    result.Result.Message = Convert.ToString(cmd.Parameters["p_message"].Value);
                result.Status = 0;
                if (!((OracleString)cmd.Parameters["p_stack"].Value).IsNull)
                    result.ErrorStackTrace = Convert.ToString(cmd.Parameters["p_stack"].Value);

                return result;
            }
            catch (Exception ex)
            {
                return new ResponseData { Status = -1, ErrorMessage = ex.Message, ErrorStackTrace = ex.StackTrace };
            }
            finally
            {
                connection.Close();
                connection.Dispose();
            }
        }

        /// <summary>
        /// Check package status
        /// </summary>
        /// <param name="packageId"></param>
        /// <returns></returns>
        public ResponseData CheckPackage(decimal packageId)
        {
            var connection = OraConnector.Handler.UserConnection;
            var result = new ResponseData();
            try
            {
                var cmd = connection.CreateCommand();
                cmd.Parameters.Clear();
                cmd.CommandText = @"
                        begin
                             bars.pfu_ru_epp_utl.get_filestate(:p_fileid, :p_state, :p_message);
                        end;";
                cmd.Parameters.Add("p_fileid", OracleDbType.Decimal, packageId, ParameterDirection.Input);
                cmd.Parameters.Add(new OracleParameter("p_state", OracleDbType.Decimal)
                {
                    Size = 10,
                    Direction = ParameterDirection.Output
                });
                cmd.Parameters.Add(new OracleParameter("p_message", OracleDbType.Varchar2)
                {
                    Size = 4000,
                    Direction = ParameterDirection.Output
                });

                cmd.ExecuteNonQuery();
                result.Status = 0;
                result.Result = new ResponseDataResult
                {
                    State = Convert.ToInt32(cmd.Parameters["p_state"].Value.ToString())
                };
                if (!((OracleString)cmd.Parameters["p_message"].Value).IsNull)
                    result.Result.Message = Convert.ToString(cmd.Parameters["p_message"].Value);
                return result;
            }
            catch (Exception ex)
            {
                return new ResponseData { Status = -1, ErrorMessage = ex.Message, ErrorStackTrace = ex.StackTrace };
            }
            finally
            {
                connection.Close();
                connection.Dispose();
            }
        }

        /// <summary>
        ///  Get receipt of package
        /// </summary>
        /// <param name="packageId"></param>
        /// <returns></returns>
        public ResponseData ReceiptPackage(decimal packageId)
        {
            var connection = OraConnector.Handler.UserConnection;
            var result = new ResponseData();
            try
            {
                var cmd = connection.CreateCommand();
                cmd.Parameters.Clear();
                cmd.CommandText = "select bars.pfu_ru_epp_utl.get_respfile(:p_fileid) from dual";
                cmd.Parameters.Add("p_fileid", OracleDbType.Decimal, packageId, ParameterDirection.Input);
                var rdr = cmd.ExecuteReader();
                if (rdr.Read())
                {
                    var blob = rdr.GetOracleBlob(0).Value;
                    if (blob.Length == 0)
                    {
                        result.Status = 1;
                        result.ErrorMessage = "Квитанція по файлу [" + packageId + "] не знайдена.";
                        return result;
                    }
                    result.Status = 0;
                    result.Result = new ResponseDataResult
                    {
                        State = 0,
                        Data = Convert.ToBase64String(blob)
                    };
                }
                else
                {
                    result.Status = 1;
                    result.ErrorMessage = "Квитанція по файлу [" + packageId + "] не знайдена";
                }

                return result;
            }
            catch (Exception ex)
            {
                return new ResponseData { Status = -1, ErrorMessage = ex.Message, ErrorStackTrace = ex.StackTrace };
            }
            finally
            {
                connection.Close();
                connection.Dispose();
            }
        }
    }
}