using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using Areas.Way.Models;
using AttributeRouting.Helpers;
using Bars.Classes;
using BarsWeb.Areas.Ndi.Infrastructure;
using BarsWeb.Areas.Way.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Way.Models;
using BarsWeb.Models;
using Microsoft.Ajax.Utilities;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.IO;
using Ionic.Zlib;
using System.Linq;

namespace BarsWeb.Areas.Way.Infrastructure.DI.Implementation
{
    public class WayRepository : IWayRepository
    {
        private readonly WayModel _entities;
        public WayRepository()
        {
            var connectionStr = EntitiesConnection.ConnectionString("WayModel", "Way");
            _entities = new WayModel(connectionStr);
        }

        public IEnumerable<OicFile> Files(string dateFrom, string dateTo,string condition = "")
        {
            CultureInfo cultureinfo = new CultureInfo("uk-UA");

            DateTime dateF = DateTime.Parse(dateFrom, cultureinfo);
            DateTime dateT = DateTime.Parse(dateTo, cultureinfo);
            if (!string.IsNullOrEmpty(condition))
                condition = " and " + condition;
            string query = string.Format(@"select * from v_ow_files where trunc(file_date) between trunc(:p_dateFrom) and trunc(:p_dateTo) {0} order by id desc", condition);
            var parameters = new object[]
            {
                new OracleParameter("p_dateFrom", OracleDbType.Date, dateF, ParameterDirection.Input),
                new OracleParameter("p_dateTo", OracleDbType.Date, dateT, ParameterDirection.Input)
            };
            return _entities.ExecuteStoreQuery<OicFile>(query, parameters);
        }

        public IEnumerable<OwSalaryFilse> ArchFiles()
        {
            const string query = @"select id, file_name, file_date, file_n, file_deal,
                                    card_code, branch, isp
                                    from v_ow_salary_files
                                    order by file_date desc, file_name";
            return _entities.ExecuteStoreQuery<OwSalaryFilse>(query);
        }

        public TicketInfo DoFormSalaryTicket(decimal? fileid)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            TicketInfo ticketInfo = new TicketInfo();

            try
            {
                OracleCommand commandImport = new OracleCommand("bars.bars_ow.form_salary_ticket", connection);
                commandImport.CommandType = CommandType.StoredProcedure;

                commandImport.Parameters.Add("p_fileid", OracleDbType.Decimal, fileid, ParameterDirection.InputOutput);
                commandImport.Parameters.Add("p_ticketname", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);

                commandImport.ExecuteNonQuery();
                if (((OracleDecimal)(commandImport.Parameters["p_fileid"].Value)).IsNull)
                {
                    ticketInfo.Error = "Дані для формування файла відсутні!";
                }
                else
                {
                    ticketInfo.TicketName = Convert.ToString(commandImport.Parameters["p_ticketname"].Value);
                    ticketInfo.ID = (decimal?)((OracleDecimal)(commandImport.Parameters["p_fileid"].Value));
                }
            }
            finally
            {
                connection.Close();
            }

            return ticketInfo;
        }
        public string GetFileData(decimal? fileid)
        {
            const string query = @"select file_data from ow_impfile where id = :p_fileid";
            var parameters = new object[]
            {
                new OracleParameter("p_fileid", OracleDbType.Decimal, fileid, ParameterDirection.Input),
            };
            
            return _entities.ExecuteStoreQuery<string>(query, parameters).FirstOrDefault();
        }



        public UpdateStatusDb ImportFile(string fileName, byte[] fileBody, bool isZip)
        {
            if (!isZip)
            {
                fileBody = Compress(fileBody);
            }            
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                var result = new UpdateStatusDb();

                OracleCommand commandImport = new OracleCommand("bars.bars_ow.web_import_files", connection);
                commandImport.CommandType = CommandType.StoredProcedure;

                commandImport.Parameters.Add("p_filename", OracleDbType.Varchar2, fileName, ParameterDirection.Input);
                commandImport.Parameters.Add("p_filebody", OracleDbType.Blob, fileBody, ParameterDirection.Input);
                commandImport.Parameters.Add("p_fileid", OracleDbType.Decimal, ParameterDirection.Output);
                commandImport.Parameters.Add("p_msg", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);

                commandImport.ExecuteNonQuery();

                var outId = ((OracleDecimal)(commandImport.Parameters["p_fileid"].Value)).IsNull;
                if (!outId)
                {
                    result.FileId = ((OracleDecimal)(commandImport.Parameters["p_fileid"].Value)).Value;
                    result.Message = Convert.ToString(commandImport.Parameters["p_msg"].Value).IsNullOrEmpty() ? Convert.ToString(commandImport.Parameters["p_msg"].Value) : "Файл ID:" + result.FileId + " завантажено.";
                    result.Status = "OK";

                    OracleCommand command = new OracleCommand("BARS.p_job_w4importfiles", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("p_id", OracleDbType.Decimal, result.FileId, ParameterDirection.Input);
                    command.ExecuteNonQuery();
                    return result;
                }
                else
                {
                    result.FileId = null;
                    result.Message = Convert.ToString(commandImport.Parameters["p_msg"].Value);
                    result.Status = "ERROR";
                    return result;
                }
            }
            finally
            {
                connection.Close();
            }
        }

        public UpdateStatusDb ImporPhonetFile(string fileName, byte[] fileBody)
        {
            fileBody = Compress(fileBody);
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                var result = new UpdateStatusDb();

                OracleCommand commandImport = new OracleCommand("w4_import_mobile_file", connection);
                commandImport.CommandType = CommandType.StoredProcedure;

                commandImport.Parameters.Add("p_filename", OracleDbType.Varchar2, fileName, ParameterDirection.Input);
                commandImport.Parameters.Add("p_filebody", OracleDbType.Blob, fileBody, ParameterDirection.Input);
                commandImport.Parameters.Add("p_fileid", OracleDbType.Decimal, ParameterDirection.Output);
                commandImport.Parameters.Add("p_msg", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);

                commandImport.ExecuteNonQuery();

                OracleString msg = (OracleString)commandImport.Parameters["p_msg"].Value;
                if (msg == "Файл вже імпортувався")
                {
                    result.FileId = null;
                    result.Message = Convert.ToString(fileName + " - " + Convert.ToString(commandImport.Parameters["p_msg"].Value) + "\n----------------------------------------------\n");
                    result.Status = "Error";
                    return result;
                }
                if (msg != null || msg != "")
                {
                    result.FileId = ((OracleDecimal)(commandImport.Parameters["p_fileid"].Value)).Value;
                    result.Message = Convert.ToString(fileName + " - " +Convert.ToString(commandImport.Parameters["p_msg"].Value) + "\n----------------------------------------------\n");
                    result.Status = "Error";
                    return result;
                }
                else
                {
                    result.FileId = null;
                    result.Message = Convert.ToString(commandImport.Parameters["p_msg"].Value);
                    result.Status = "OK";
                    return result;
                }
            }
            finally
            {
                connection.Close();
            }
        }
        public static byte[] Compress(byte[] raw)
        {
            using (MemoryStream memory = new MemoryStream())
            {
                using (GZipStream gzip = new GZipStream(memory,
                CompressionMode.Compress, true))
                {
                    gzip.Write(raw, 0, raw.Length);
                }
                return memory.ToArray();
            }
        }


        public IEnumerable<ProcessedFile> ProcessedFiles(decimal fileId)
        {
            const string query = @"
                select 
                    a.mfoa, a.mfob, a.nlsa, a.nlsb, a.s, a.kv, v.lcv, v.dig,
                    a.s2, a.kv2, v2.lcv lcv2, v2.dig dig2, a.sk, a.dk,
                    a.vob, a.datd, a.vdat, a.tt, a.ref id, a.ref, a.sos,
                    a.userid, a.nd, a.nazn, a.id_a, a.nam_a, a.id_b,
                    a.nam_b, a.tobo
                from oper a, tabval$global v, tabval$global v2
                where a.kv = v.kv(+) and a.kv2 = v2.kv(+) and
                     (a.ref in (select ref from ow_oic_ref where id = :p_id))
                order by 19 desc
                ";
            var parameters = new object[]
            {
                new OracleParameter("p_id", OracleDbType.Decimal, fileId, ParameterDirection.Input)
            };
            return _entities.ExecuteStoreQuery<ProcessedFile>(query, parameters);
        }

        public void DeleteFile(decimal id)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand commandImport = new OracleCommand("bars.bars_ow.delete_file", connection);
                commandImport.CommandType = CommandType.StoredProcedure;

                commandImport.Parameters.Add("p_fileid", OracleDbType.Decimal, id, ParameterDirection.Input);

                commandImport.ExecuteNonQuery();
            }
            finally
            {
                connection.Close();
            }
        }

        public void RepayFile(decimal id)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand commandImport = new OracleCommand("bars.bars_ow.pay_oic_file", connection);
                commandImport.CommandType = CommandType.StoredProcedure;

                commandImport.Parameters.Add("p_id", OracleDbType.Decimal, id, ParameterDirection.Input);

                commandImport.ExecuteNonQuery();
            }
            finally
            {
                connection.Close();
            }
        }

        public IEnumerable<AFtransfers> NoProccessedAFtransfers(decimal fileId)
        {
            const string query = @"select * from v_ow_oic_atransfers_data t where t.id = :p_id and nvl(state,0) <> 99";
            var parameters = new object[]
            {
                new OracleParameter("p_id", OracleDbType.Decimal, fileId, ParameterDirection.Input)
            };
            return _entities.ExecuteStoreQuery<AFtransfers>(query, parameters);
        }

        public IEnumerable<BarsWeb.Areas.Way.Models.Documents> NoProccessedDocuments(decimal fileId)
        {
            const string query = @"select * from v_ow_oic_documents_data t where t.id = :p_id and nvl(state,0) <> 99";
            var parameters = new object[]
            {
                new OracleParameter("p_id", OracleDbType.Decimal, fileId, ParameterDirection.Input)
            };
            return _entities.ExecuteStoreQuery<BarsWeb.Areas.Way.Models.Documents>(query, parameters);
        }

        public IEnumerable<Stransfers> NoProccessedStransfers(decimal fileId)
        {
            const string query = @"select * from v_ow_oic_stransfers_data t where t.id = :p_id and nvl(state,0) <> 99";
            var parameters = new object[]
            {
                new OracleParameter("p_id", OracleDbType.Decimal, fileId, ParameterDirection.Input)
            };
            return _entities.ExecuteStoreQuery<Stransfers>(query, parameters);
        }

        public string GetGlobalOption(string paramName)
        {
            var parameters = new object[]
            {
                new OracleParameter("pName", OracleDbType.Varchar2, paramName, ParameterDirection.Input)
            };
            var result = _entities.ExecuteStoreQuery<string>(@" select GetGlobalOption(:pName) from dual", parameters).FirstOrDefault();
            if (string.IsNullOrEmpty(result))
            {
                throw new Exception("Параметр " + paramName + " не встановлено!");
            }
            return result.ToString();

        }
        public IEnumerable<BarsWeb.Areas.Way.Models.Documents> DeletedDocuments(decimal fileId)
        {
            const string query = @"select * from v_ow_oic_documents_data t where t.id = :p_id and nvl(state,0) = 99";
            var parameters = new object[]
            {
                new OracleParameter("p_id", OracleDbType.Decimal, fileId, ParameterDirection.Input)
            };
            return _entities.ExecuteStoreQuery<BarsWeb.Areas.Way.Models.Documents>(query, parameters);
        }

        public IEnumerable<AFtransfers> DeletedAFtransfers(decimal fileId)
        {
            const string query = @"select * from v_ow_oic_atransfers_data t where t.id = :p_id and nvl(state,0) = 99";
            var parameters = new object[]
            {
                new OracleParameter("p_id", OracleDbType.Decimal, fileId, ParameterDirection.Input)
            };
            return _entities.ExecuteStoreQuery<AFtransfers>(query, parameters);
        }
        public IEnumerable<Stransfers> DeletedStransfers(decimal fileId)
        {
            const string query = @"select * from v_ow_oic_stransfers_data t where t.id = :p_id and nvl(state,0) = 99";
            var parameters = new object[]
            {
                new OracleParameter("p_id", OracleDbType.Decimal, fileId, ParameterDirection.Input)
            };
            return _entities.ExecuteStoreQuery<Stransfers>(query, parameters);
        }
        public void SetRowState(decimal id, decimal idn, decimal state)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand commandImport = new OracleCommand("ow_files_proc.set_tran_state", connection);
                commandImport.CommandType = CommandType.StoredProcedure;

                commandImport.Parameters.Add("p_fileid", OracleDbType.Decimal, id, ParameterDirection.Input);
                commandImport.Parameters.Add("p_idn", OracleDbType.Decimal, idn, ParameterDirection.Input);
                commandImport.Parameters.Add("p_state", OracleDbType.Decimal, state, ParameterDirection.Input);
                commandImport.ExecuteNonQuery();
            }
            finally
            {
                connection.Close();
            }
        }
    }

}


