using Bars.Classes;
using BarsWeb.Areas.TechWorks.Models;
using Dapper;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace BarsWeb.Areas.TechWorks.Infrastructure
{
    public class FileManager
    {
        public FileManager()
        {
        }

        public RequestFileInfo FileProcess(string fileName, Stream file)
        {
            try
            {
                string data;

                using (StreamReader stream = new StreamReader(file, Encoding.GetEncoding("Windows-1251")))
                {
                    data = stream.ReadToEnd();
                }

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var xmlFileName = Path.GetFileName(fileName);
                    var sKu = GetSKU(connection);
                    var kvtFileName = Path.GetFileNameWithoutExtension(fileName) + "P" + sKu + Path.GetExtension(fileName);
                    PutFileIntoTempTable(connection, data);
                    var errormessage = CreateReceipt(connection, xmlFileName, kvtFileName, sKu);
                    return new RequestFileInfo { FileName = kvtFileName, FileMessage = errormessage };
                }
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        private void PutFileIntoTempTable(OracleConnection connection, string data)
        {
            OracleCommand insertCommand = new OracleCommand("insert into BARS.TMP_RI_CLOB(NAMEF, C) values(:p_Name, :p_Body)", connection);
            insertCommand.Parameters.Add("p_Name", OracleDbType.Decimal, 1, ParameterDirection.Input);
            insertCommand.Parameters.Add("p_Body", OracleDbType.Clob, data, ParameterDirection.Input);
            insertCommand.ExecuteNonQuery();
        }

        private string GetSKU(OracleConnection connection)
        {
            return connection.Query<string>(@"SELECT decode(mfo,'300465','27',substr(to_char(ku+100),-2)) FROM   rcukru WHERE  mfo=f_ourmfo").FirstOrDefault();
        }

        private string CreateReceipt(OracleConnection connection, string xmlFileName, string kvtFileName, string sKu)
        {
            int errorCode = 0;
            string errorMsg = "";
            OracleCommand command = new OracleCommand("bars.GET_XML_RI", connection);

            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("p_FILEXML", OracleDbType.Varchar2, xmlFileName, ParameterDirection.Input);
            command.Parameters.Add("p_FILEKVT", OracleDbType.Varchar2, kvtFileName, ParameterDirection.Input);
            command.Parameters.Add("p_KU", OracleDbType.Varchar2, sKu, ParameterDirection.Input);
            command.Parameters.Add("p_key", OracleDbType.Decimal, 1, ParameterDirection.Input);
            command.Parameters.Add("p_RET", OracleDbType.Int32, errorCode, ParameterDirection.Output);
            command.Parameters.Add("p_err", OracleDbType.Varchar2, 4096, errorMsg, ParameterDirection.Output);
            command.ExecuteNonQuery();

            var tmpPRet = command.Parameters[4].Value;
            if (tmpPRet == null) throw new Exception("Помилка. Функція bars.GET_XML_RI не повернула код результату виконання.");
            OracleDecimal pRet = (OracleDecimal)tmpPRet;

            if (Convert.ToInt32(pRet.Value) == 0) return "Файл успішно оброблено.";
            else
            {
                var tmpPErr = command.Parameters[5].Value;
                if (tmpPErr == null) return "Описання помилки відсутнє.";

                OracleString tmpVal = (OracleString)tmpPErr;
                return tmpVal.Value.ToString();
            }
        }

        public string GetReceiptFile()
        {
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<string>(@"SELECT C FROM BARS.TMP_RI_CLOB where NAMEF=2").FirstOrDefault();
            }
        }
    }
}