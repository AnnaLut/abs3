using Bars.Classes;
using BarsWeb.Areas.Dpa.Models;
using Dapper;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

public class RepositoryHelper
{
    public RepositoryHelper()
    {

    }

    static byte[] GetBytes(string str)
    {
        byte[] bytes = new byte[str.Length * sizeof(char)];
        System.Buffer.BlockCopy(str.ToCharArray(), 0, bytes, 0, bytes.Length);
        return bytes;
    }

    public List<FileResponse> SaveCVFiles(decimal count, string fileType)
    {
        List<FileResponse> fileList = new List<FileResponse>();
        for (int j = 1; j < count + 1; j++)
        {
            var p = new OracleParameter[4];
            FileResponse file = new FileResponse();

            p[0] = new OracleParameter("p_filetype", OracleDbType.Varchar2, 4000, fileType, ParameterDirection.Input);
            p[1] = new OracleParameter("p_file_number", OracleDbType.Int32, j, direction: ParameterDirection.Input);
            p[2] = new OracleParameter("p_filename", OracleDbType.Varchar2, 4000, ParameterDirection.Output);
            p[3] = new OracleParameter("l_clob", OracleDbType.Clob, ParameterDirection.ReturnValue);

            //var sql = @"bars_dpa.get_cvk_file";

            using (var connection = OraConnector.Handler.UserConnection)
            {
                OracleCommand oraCommand = connection.CreateCommand();
                oraCommand.CommandText = "bars_dpa.get_cvk_file";
                oraCommand.CommandType = CommandType.StoredProcedure;
                oraCommand.Parameters.AddRange(p);
                oraCommand.ExecuteNonQuery();
            }

            file.fileName = p[2].Value.ToString();// p.Get<string>("p_filename");
            file.fileBody = p[3].Value.ToString();// p.Get<string>("l_clob");

        }
        return fileList;
    }

    public List<FileResponse> SaveCAFiles(decimal id, string fileType)
    {
        List<FileResponse> fileList = new List<FileResponse>();
        var p = new OracleParameter[4];
        FileResponse file = new FileResponse();

        p[0] = new OracleParameter("p_filetype", OracleDbType.Varchar2, 4000, fileType, ParameterDirection.Input);
        p[1] = new OracleParameter("p_file_number", OracleDbType.Int32, id, direction: ParameterDirection.Input);
        p[2] = new OracleParameter("p_filename", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
        p[3] = new OracleParameter("l_clob", OracleDbType.Clob, ParameterDirection.ReturnValue);

        using (var connection = OraConnector.Handler.UserConnection)
        using (OracleCommand oraCommand = connection.CreateCommand())
        {
            oraCommand.BindByName = true;
            oraCommand.CommandText = "bars_dpa.get_cvk_file";
            oraCommand.CommandType = CommandType.StoredProcedure;
            oraCommand.Parameters.AddRange(p);
            oraCommand.ExecuteNonQuery();

            file.fileName = p[2].Value.ToString();// p.Get<string>("p_filename");
            using (OracleClob data = (OracleClob)p[3].Value)
            {
                file.fileBody = data.Value;
            }
        }

        fileList.Add(file);

        return fileList;
    }

    public decimal FormCVFilesAndGetCount(string fileType, string entereddate)
    {
        var p = new DynamicParameters();

        p.Add("p_filetype", dbType: DbType.String, value: fileType, direction: ParameterDirection.Input);
        p.Add("p_filedate", dbType: DbType.String, value: entereddate, direction: ParameterDirection.Input);
        p.Add("p_file_count", dbType: DbType.Decimal, direction: ParameterDirection.Output);

        var sql = @"begin
                        bars_dpa.form_cvk_file(:p_filetype, to_date(:p_filedate, 'dd/mm/yyyy'), :p_file_count);
                     end;";

        using (var connection = OraConnector.Handler.UserConnection)
        {
            connection.Execute(sql, p);
        }

        Decimal count = p.Get<Decimal>("p_file_count");

        return count;
    }

    public void CheckAndCreateDirectory(string path)
    {
        if (!Directory.Exists(path))
        {
            Directory.CreateDirectory(path);
        }
    }

    public string GetPath(string sql)
    {
        string path = "";

        using (var connection = OraConnector.Handler.UserConnection)
        {
            path = connection.Query<string>(sql).SingleOrDefault();
        }

        return path;
    }

    public string GetDirectoryPathAndCheckIt(string branch, string prefix, string fileType)
    {
        string par = prefix + branch.Replace("/", "");
        string sql = string.Format(@"select val from dpa_params where par = '{0}'", par);

        string path = GetPath(sql);
        if (string.IsNullOrWhiteSpace(path))
        {
            throw new Exception(string.Format("Відсутнє налаштування шляху для {0}-файлів.", fileType));
        }

        CheckAndCreateDirectory(path);

        return path;
    }
}