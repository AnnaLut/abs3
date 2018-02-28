using BarsWeb.Areas.PC.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.PC.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using Dapper;
using Bars.Classes;
using System.Data;
using System.Xml;
using System.IO;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace BarsWeb.Areas.PC.Infrastructure.Repository.DI.Implementation
{
    public class PCRepository : IPCRepository
    {
        public PCRepository()
        {
        }

        public List<Operations> GetOperations()
        {
            var sql = @"select funcname as NAME, id as ID from OW_OUT_FILES_SOURCE order by id";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<Operations>(sql).ToList();
            }
        }

        public string RunSelectedProcedure(int id)
        {
            string path = "", message = "", proc = "";
            int count = 0;

            //------------------//
            var sql = @"select GETGLOBALOPTION('OWOUTDIR') from dual";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                path = connection.Query<string>(sql).SingleOrDefault();
            }
            CheckAndCreateDirectory(path);
            //------------------//

            //------------------//
            sql = @"select proc from OW_OUT_FILES_SOURCE where id = " + id;
            using (var connection = OraConnector.Handler.UserConnection)
            {
                proc = connection.Query<string>(sql).SingleOrDefault();
            }
            //------------------//

            while (true)
            {
                using (OracleConnection connection = OraConnector.Handler.UserConnection)
                using (OracleTransaction trans = connection.BeginTransaction())
                using (OracleCommand commandImport = new OracleCommand(proc, connection))
                {
                    commandImport.CommandType = CommandType.StoredProcedure;

                    commandImport.Parameters.Add("p_mode", OracleDbType.Int32, id, ParameterDirection.Input);
                    commandImport.Parameters.Add("p_filename", OracleDbType.Varchar2, 100, null,
                        ParameterDirection.Output);
                    commandImport.Parameters.Add("p_filebody", OracleDbType.Clob, null, ParameterDirection.Output);
                    commandImport.Parameters.Add("p_msg", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);

                    commandImport.ExecuteNonQuery();

                    //var p = new DynamicParameters();
                    //p.Add("p_filename", dbType: DbType.String, direction: ParameterDirection.Output, size: 100);
                    //p.Add("p_filebody", OracleDbType.Clob, direction: ParameterDirection.Output);
                    //p.Add("p_msg", dbType: DbType.String, direction: ParameterDirection.Output, size: 500);

                    //sql = @"begin " + proc + ";" + " end;";

                    //using (var connection = OraConnector.Handler.UserConnection)
                    //{
                    //    connection.Execute(sql, p);
                    //}

                    string fileName = Convert.ToString(commandImport.Parameters["p_filename"].Value);
                    using (OracleClob Body = (OracleClob) commandImport.Parameters["p_filebody"].Value)
                    {

                        //string fileBody = (string)Body.Value;
                        // Есть вероятность что данная реализация работает только для файлов с кодеровкой UTF-8
                        string fileBody = Encoding.UTF8.GetString(Encoding.GetEncoding(1251).GetBytes(Body.Value));

                        if (fileName != "null")
                        {
                            /*XmlDocument xdoc = new XmlDocument();
                            xdoc.LoadXml(fileBody);
                            xdoc.Save(path + "\\" + fileName);*/
                            File.WriteAllText(path + "\\" + fileName, fileBody);
                            count++;
                            trans.Commit();
                        }
                        else
                        {
                            message = count != 0 ? "Файли успішно сформовано." : "Дані для формування файлів відсутні.";
                            trans.Commit();
                            break;
                        }
                    }
                }
            }
            return message;
        }

        public List<Grid> GetGridData(string date_from, string date_to)
        {
            var sql = @"select file_name, file_date, file_n from v_ow_out_files 
                        where file_date between to_date(:date_from, 'dd/mm/yyyy hh24:MI:ss') and to_date(:date_to, 'dd/mm/yyyy hh24:MI:ss' )
                        order by file_date desc";
            var p = new DynamicParameters();
            p.Add("date_from", dbType: DbType.String, value: date_from, direction: ParameterDirection.Input, size: 100);
            p.Add("date_to", dbType: DbType.String, value: date_to, direction: ParameterDirection.Input, size: 100);
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<Grid>(sql, p).ToList();
            }
        }

        public void CheckAndCreateDirectory(string path)
        {
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }
        }
    }
}