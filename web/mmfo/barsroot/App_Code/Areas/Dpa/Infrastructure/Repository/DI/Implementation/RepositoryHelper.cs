﻿using Bars.Classes;
using BarsWeb.Areas.Dpa.Models;
using Dapper;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Oracle;
using System.Globalization;

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

    public List<FileResponse> SaveCaCvFiles(List<decimal> idList, string fileType)
    {
        List<FileResponse> fileList = new List<FileResponse>();

        using (OracleConnection con = OraConnector.Handler.UserConnection)
        using (OracleCommand cmd = con.CreateCommand())
        {
            cmd.BindByName = true;
            cmd.CommandText = "bars_dpa2.get_cvk_file";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            foreach (decimal id in idList)
            {
                OracleParameter[] p = new OracleParameter[4];
                FileResponse file = new FileResponse();

                p[0] = new OracleParameter("p_filetype", OracleDbType.Varchar2, 4000, fileType, ParameterDirection.Input);
                p[1] = new OracleParameter("p_file_number", OracleDbType.Int32, id, direction: ParameterDirection.Input);
                p[2] = new OracleParameter("p_filename", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                p[3] = new OracleParameter("l_clob", OracleDbType.Clob, ParameterDirection.ReturnValue);

                cmd.Parameters.AddRange(p);
                cmd.ExecuteNonQuery();

                file.fileName = p[2].Value.ToString();
                using (OracleClob data = (OracleClob)p[3].Value)
                {
                    file.fileBody = data.IsNull ? "" : data.Value;
                }

                fileList.Add(file);
            }
        }
        return fileList;
    }

    public List<decimal> FormCVFilesAndGetIds(string fileType, string entereddate)
    {
        CultureInfo _ci;
        _ci = CultureInfo.CreateSpecificCulture("en-GB");
        _ci.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
        _ci.DateTimeFormat.DateSeparator = ".";


        List<decimal> res = new List<decimal>();

        using (OracleConnection con = OraConnector.Handler.UserConnection)
        using (OracleCommand cmd = con.CreateCommand())
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "bars_dpa2.form_cvk_file";

            cmd.Parameters.Add(new OracleParameter("p_filetype", OracleDbType.Varchar2, fileType, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_filedate", OracleDbType.Date, Convert.ToDateTime(entereddate, _ci), ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_file_count", OracleDbType.Decimal, ParameterDirection.Input));
            OracleParameter retVal = new OracleParameter("p_ids", OracleDbType.Array, ParameterDirection.Output);
            retVal.UdtTypeName = "BARS.NUMBER_LIST";
            cmd.Parameters.Add(retVal);

            cmd.ExecuteNonQuery();

            if (null != retVal.Value)
            {
                NumberList _retVal = (NumberList)retVal.Value;
                if (!_retVal.IsNull)
                    res = _retVal.Value.ToList();
            }
            return res;
        }
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