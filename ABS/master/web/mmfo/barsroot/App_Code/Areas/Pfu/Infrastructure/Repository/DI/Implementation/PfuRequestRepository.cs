using Areas.Pfu.Models;
using Bars.Classes;
using barsroot.core;
using BarsWeb.Areas.Pfu.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Pfu.Models.ApiModels;
using BarsWeb.Models;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Pfu.Infrastructure.Repository.DI.Implementation
{
    public class PfuRequestRepository : IPfuRequestRepository
    {
        private readonly PfuModel _pfu;
        public PfuRequestRepository()
        {
            var connectionStr = EntitiesConnection.ConnectionString("PfuModel", "Pfu");
            this._pfu = new PfuModel(connectionStr);
        }

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
                    using (OracleBlob _blob = rdr.GetOracleBlob(0))
                    {
                        byte[] blob = _blob.Value;
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