using Bars.Classes;
using BarsWeb.Areas.Dpa.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Dpa.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Dapper;
using System.IO;
using System.Xml;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Oracle;
using System.Web;
using Bars.Web.Report;

public class RegisterCountsDPARepository : IRegisterCountsDPARepository
{
    RepositoryHelper _helper = new RepositoryHelper();

    public RegisterCountsDPARepository()
    {

    }

    public List<T> GetFileReport<T>(string entereddate, string fileType)
    {
        List<T> list = new List<T>();
        if (fileType == "F")
        {
            var sql = @"SELECT t.rowid AS idrow
      ,t.mfo
      ,t.id_a
      ,t.rt
      ,t.ot
      ,t.odat
      ,t.nls
      ,t.kv
      ,t.c_ag
      ,SUBSTR(t.nmk, 0, 38) as nmk
      ,c.adr
      ,t.c_reg
      ,t.c_dst
      ,s.kod_reg
      ,t.rec_o
  FROM bars.ree_tmp  t
      ,bars.accounts a
      ,bars.dpa_nbs  d
      ,bars.spr_obl  s
      ,bars.customer c
 WHERE (t.odat <= (CASE
                     WHEN a.dat_alt IS NOT NULL THEN -- была трансформация
                      t.odat
                     ELSE
                      to_date(:entereddate
                             ,'dd/mm/yyyy')
                   END) OR t.odat IS NULL)
   AND (   a.nls    = t.nls
        OR a.nlsalt = t.nls)
   AND a.kv = t.kv
   AND a.kf = t.mfo
   AND substr(t.nls
             ,1
             ,4) = d.nbs
   AND d.type = 'DPA'
   AND t.fn_o IS NULL
   AND t.ot = d.taxotype
   AND c.c_reg = s.c_reg
   AND a.rnk = c.rnk
   AND CASE
         WHEN a.dat_alt IS NOT NULL THEN -- была трансформация
          t.odat
         ELSE
          greatest(daos
                  ,nvl(dazs
                      ,a.daos))
       END >= to_date(:entereddate
                     ,'dd/mm/yyyy') - 30

UNION ALL
-- COBUMMFO-4028 часть для нотариусов
SELECT t.rowid AS idrow
      ,t.mfo
      ,t.id_a
      ,t.rt
      ,t.ot
      ,t.odat
      ,t.nls
      ,t.kv
      ,t.c_ag
      ,SUBSTR(t.nmk, 0, 38) as nmk 
      ,c.adr
      ,t.c_reg
      ,t.c_dst
      ,s.kod_reg
      ,t.rec_o
  FROM bars.ree_tmp  t
      ,bars.accounts a
      ,bars.spr_obl  s
      ,bars.customer c
 WHERE (t.odat <= (CASE
                     WHEN a.dat_alt IS NOT NULL THEN -- была трансформация
                      t.odat
                     ELSE
                      to_date(:entereddate
                             ,'dd/mm/yyyy')
                   END) OR t.odat IS NULL)
   AND a.nbs = '2620'
   AND a.ob22 in ('07', '32')
   AND a.nls = t.nls
   AND a.kv = t.kv
   AND a.kf = t.mfo
   AND t.fn_o IS NULL
   AND c.c_reg = s.c_reg
   AND a.rnk = c.rnk
   AND CASE
         WHEN a.dat_alt IS NOT NULL THEN -- была трансформация
          t.odat
         ELSE
          greatest(daos
                  ,nvl(dazs
                      ,a.daos))
       END >= to_date(:entereddate
                     ,'dd/mm/yyyy') - 30";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<T>(sql, new { entereddate }).ToList();
            }
        }
        else if (fileType == "CV")
        {
            var sql = @"select nls,
                            vid,
                            opldok_ref,
                            fdat,
                            mfo_d, 
                            nls_d,
                            mfo_k,
                            nls_k,
                            dk, s, vob, nd,
                            kv, datd, datp, 
                            nam_a,
                            nam_b,
                            nazn,
                            d_rec, 
                            naznk, 
                            nazns, 
                            id_d,
                            id_k,
                            ref, 
                            dat_a, 
                            dat_b
                       from v_dpa_cv
                        where fdat = to_date(:entereddate,'dd/mm/yyyy')
                        order by nls";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<T>(sql, new { entereddate }).ToList();
            }
        }
        else if (fileType == "CA")
        {
            var sql = @"select mfo, nb, nls, daos, vid, tvo, name_blok,
                    fio_blok, fio_isp, inf_isp, addr, okpo
                    from v_cvk_ca
                      where daos = to_date(:entereddate,'dd/mm/yyyy')";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<T>(sql, new { entereddate }).ToList();
            }
        }
        else if (fileType == "K")
        {
            var sql = @"select a.id as idrow, substr(a.mfo,1,40) as mfo, a.nmk, a.ot,
                         a.odat, nvl(f.nls,a.nls) as nls, a.kv, a.c_ag,
                                a.country, a.c_reg, a.okpo
                           from ( select c.rowid id, b.bic mfo, c.nmk, c.ot,
                                         c.odat, c.nls, c.kv, c.c_ag,
                                         decode(c.c_ag,1,'',cu.country) country, c1.c_reg, c1.okpo, s.kod_reg
                                    from ree_tmp c, dpa_nbs d, accounts a, spr_obl s, custbank b, customer cu, customer c1
                                   where c.odat <= to_date(:entereddate,'dd/mm/yyyy')
                                     and c.fn_o is null 
                                     and substr(c.nls,1,4) = d.nbs and d.type = 'DPK' and c.ot = d.taxotype
                                     and a.nls = c.nls and a.kv = c.kv
                                     and c.c_reg = s.c_reg
                                     and a.rnk = cu.rnk
                                     and cu.rnk = b.rnk
                                     and c1.rnk = (select trim(val) from params where par='OUR_RNK') ) a, forex_alien f
                          where f.bic(+)=a.mfo and f.kv(+)=a.kv
                          order by a.kod_reg";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<T>(sql, new { entereddate }).ToList();
            }
        }
        return list;
    }

    public void DeleteRows(dynamic rows, string fileType)
    {
        for (int i = 0; i < rows.Count; i++)
        {
            var p = new DynamicParameters();
            p.Add("p_idrow", dbType: DbType.String, size: 100, value: Convert.ToString(rows[i].IDROW), direction: ParameterDirection.Input);

            var sql = @"begin
                        bars_dpa.del_f_row(:p_idrow);
                     end;";

            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute(sql, p);
            }
        }
    }

    public string ProcessFilesDPA(string fileName, string path)
    {
        var branch = GetBranch();
        var sql = @"begin
            bars_dpa.import_ticket(:p_filename, :p_errcode);
         end;";
        var p = new DynamicParameters();
        p.Add("p_filename", dbType: DbType.String, size: 500, value: fileName, direction: ParameterDirection.Input);
        p.Add("p_errcode", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);

        using (var connection = OraConnector.Handler.UserConnection)
        {
            connection.Execute(sql, p);
        }

        string errorcode = p.Get<string>("p_errcode");

        if (fileName.Contains("@F"))
            sql = @"select 
                           val
                        from dpa_params where par = 'fb_" + branch.Replace("/", "") + "'";
        else
            sql = @"select 
                           val
                        from dpa_params where par = 'kb_" + branch.Replace("/", "") + "'";

        var dest_path = _helper.GetPath(sql);
        _helper.CheckAndCreateDirectory(dest_path);

        foreach (var file in Directory.GetFiles(path))
            if (Path.GetFileName(file) == fileName)
            {
                File.Copy(file, Path.Combine(dest_path, Path.GetFileName(file)), true);
                File.Delete(file);
            }

        return errorcode;
    }

    public object UploadGrid(dynamic grid, string fileType, string entereddate)
    {
        var branch = GetBranch();
        string path = "";
        var p = new DynamicParameters();
        string sql = "";
        string filename = "";
        if (fileType == "F")
        {
            path = _helper.GetDirectoryPathAndCheckIt(branch, "fo_", fileType);

            //выполняем insert grid во временную таблицу
            try
            {
                List<FFile> gridList = grid.ToObject<List<FFile>>();
                if (gridList[0].RT != null)
                {
                    for (int i = 0; i < gridList.Count; i++)
                    {
                        DateTime date = Convert.ToDateTime(gridList[i].ODAT);
                        p = new DynamicParameters();
                        p.Add("MFO", dbType: DbType.Decimal, value: gridList[i].MFO, direction: ParameterDirection.Input);
                        p.Add("ID_A", dbType: DbType.String, value: gridList[i].ID_A, direction: ParameterDirection.Input);
                        p.Add("RT", dbType: DbType.String, value: gridList[i].RT, direction: ParameterDirection.Input);
                        p.Add("OT", dbType: DbType.String, value: gridList[i].OT, direction: ParameterDirection.Input);
                        p.Add("ODAT", dbType: DbType.Date, value: date.Date, direction: ParameterDirection.Input);
                        p.Add("NLS", dbType: DbType.String, value: gridList[i].NLS, direction: ParameterDirection.Input);
                        p.Add("KV", dbType: DbType.Decimal, value: gridList[i].KV, direction: ParameterDirection.Input);
                        p.Add("C_AG", dbType: DbType.String, value: gridList[i].C_AG, direction: ParameterDirection.Input);
                        p.Add("NMK", dbType: DbType.String, value: gridList[i].NMK, direction: ParameterDirection.Input);
                        p.Add("ADR", dbType: DbType.String, value: gridList[i].ADR, direction: ParameterDirection.Input);
                        p.Add("C_REG", dbType: DbType.Decimal, value: gridList[i].C_REG, direction: ParameterDirection.Input);
                        p.Add("C_DST", dbType: DbType.Decimal, value: gridList[i].C_DST, direction: ParameterDirection.Input);
                        p.Add("KOD_REG", dbType: DbType.String, value: gridList[i].KOD_REG, direction: ParameterDirection.Input);
                        p.Add("REC_O", dbType: DbType.Decimal, value: gridList[i].REC_O, direction: ParameterDirection.Input);

                        sql = @"begin
                          Bars_dpa.insert_data_to_temp(:MFO, :ID_A, :RT, :OT, :ODAT, :NLS, :KV, :C_AG, :NMK, :ADR, :C_REG, :C_DST, :KOD_REG, :REC_O);
                       end;";

                        using (var connection = OraConnector.Handler.UserConnection)
                        {
                            connection.Execute(sql, p);
                        }
                    }
                }
                else throw new Exception();
            }
            catch
            {
                List<F0Grid> gridList = grid.ToObject<List<F0Grid>>();
                for (int i = 0; i < gridList.Count; i++)
                {
                    DateTime date = Convert.ToDateTime(gridList[i].ODATE);
                    p = new DynamicParameters();
                    p.Add("MFO", dbType: DbType.Decimal, value: gridList[i].MFO, direction: ParameterDirection.Input);
                    p.Add("ID_A", dbType: DbType.String, value: gridList[i].OKPO, direction: ParameterDirection.Input);
                    p.Add("RT", dbType: DbType.String, value: gridList[i].RTYPE, direction: ParameterDirection.Input);
                    p.Add("OT", dbType: DbType.String, value: gridList[i].OTYPE, direction: ParameterDirection.Input);
                    p.Add("ODAT", dbType: DbType.Date, value: date.Date, direction: ParameterDirection.Input);
                    p.Add("NLS", dbType: DbType.String, value: gridList[i].NLS, direction: ParameterDirection.Input);
                    p.Add("KV", dbType: DbType.Decimal, value: gridList[i].KV, direction: ParameterDirection.Input);
                    p.Add("C_AG", dbType: DbType.String, value: gridList[i].RESID, direction: ParameterDirection.Input);
                    p.Add("NMK", dbType: DbType.String, value: gridList[i].NMKK, direction: ParameterDirection.Input);
                    p.Add("ADR", dbType: DbType.String, value: gridList[i].ADR, direction: ParameterDirection.Input);
                    p.Add("C_REG", dbType: DbType.Decimal, value: gridList[i].C_REG, direction: ParameterDirection.Input);
                    p.Add("C_DST", dbType: DbType.Decimal, value: gridList[i].C_DST, direction: ParameterDirection.Input);
                    p.Add("KOD_REG", dbType: DbType.String, value: gridList[i].KOD_REG, direction: ParameterDirection.Input);
                    p.Add("REC_O", dbType: DbType.Decimal, value: gridList[i].REC_O, direction: ParameterDirection.Input);

                    sql = @"begin
                        Bars_dpa.insert_data_to_temp(:MFO, :ID_A, :RT, :OT, :ODAT, :NLS, :KV, :C_AG, :NMK, :ADR, :C_REG, :C_DST, :KOD_REG, :REC_O);
                     end;";

                    using (var connection = OraConnector.Handler.UserConnection)
                    {
                        connection.Execute(sql, p);
                    }
                }
            }

            string fileName = GetFileName(fileType);
            filename = fileName;
            string fileBody = GetFileBody(fileName);
            XmlDocument xdoc = new XmlDocument();
            xdoc.LoadXml(fileBody);
            xdoc.Save(path + '/' + fileName);
        }
        else if (fileType == "CV")
        {
            List<CVFile> gridList = grid.ToObject<List<CVFile>>();
            List<FileResponse> filesList = new List<FileResponse>();

            path = _helper.GetDirectoryPathAndCheckIt(branch,  "cvo_", fileType);

            //выполняем insert grid во временную таблицу
            for (int i = 0; i < gridList.Count; i++)
            {
                p = new DynamicParameters();
                p.Add("p_ref", dbType: DbType.Decimal, value: gridList[i].OPLDOC_REF, direction: ParameterDirection.Input);

                sql = @"begin
                        bars_dpa.insert_data_to_temp(:p_ref);
                     end;";

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    connection.Execute(sql, p);
                }
            }

            filesList = GetList(fileType, entereddate);

            foreach (var file in filesList)
            {
                XmlDocument xdoc = new XmlDocument();
                xdoc.LoadXml(file.fileBody);
                xdoc.Save(path + '/' + file.fileName);
            }
        }
        else if (fileType == "K")
        {
            path = _helper.GetDirectoryPathAndCheckIt(branch, "ko_", fileType);

            //выполняем insert grid во временную таблицу

            List<KFile> gridList = grid.ToObject<List<KFile>>();

            for (int i = 0; i < gridList.Count; i++)
            {
                DateTime date = Convert.ToDateTime(gridList[i].ODAT);
                p = new DynamicParameters();
                p.Add("p_bic", dbType: DbType.String, value: gridList[i].MFO, direction: ParameterDirection.Input);
                p.Add("p_nmk", dbType: DbType.String, value: gridList[i].NMK, direction: ParameterDirection.Input);
                p.Add("p_ot", dbType: DbType.String, value: gridList[i].OT, direction: ParameterDirection.Input);
                p.Add("p_odat", dbType: DbType.Date, value: date.Date, direction: ParameterDirection.Input);
                p.Add("p_nls", dbType: DbType.String, value: gridList[i].NLS, direction: ParameterDirection.Input);
                p.Add("p_kv", dbType: DbType.Decimal, value: gridList[i].KV, direction: ParameterDirection.Input);
                p.Add("p_c_ag", dbType: DbType.Decimal, value: gridList[i].C_AG, direction: ParameterDirection.Input);
                p.Add("p_country", dbType: DbType.Decimal, value: gridList[i].COUNTRY, direction: ParameterDirection.Input);
                p.Add("p_c_reg", dbType: DbType.String, value: gridList[i].C_REG, direction: ParameterDirection.Input);
                p.Add("p_okpo", dbType: DbType.String, value: gridList[i].OKPO, direction: ParameterDirection.Input);
                sql = @"begin
                    bars_dpa.insert_data_to_temp(:p_bic, :p_nmk, :p_ot, :p_odat, :p_nls, :p_kv, :p_c_ag, :p_country, :p_c_reg, :p_okpo);
                end;";

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    connection.Execute(sql, p);
                }
            }

            string fileName = GetFileName(fileType);
            filename = fileName;
            string fileBody = GetFileBody(fileName);

            XmlDocument xdoc = new XmlDocument();
            xdoc.LoadXml(fileBody);
            xdoc.Save(path + '/' + fileName);
        }
        else throw new Exception();
        return new { path = path, filename = filename };
    }

    public List<FileResponse> GetList(string fileType, string entereddate)
    {
        var count = _helper.FormCVFilesAndGetCount(fileType, entereddate);
        return _helper.SaveCVFiles(count, fileType);
    }

    public string GetFileName(string fileType)
    {
        var p = new DynamicParameters();
        p.Add("p_sFileType", dbType: DbType.String, value: fileType, direction: ParameterDirection.Input);
        p.Add("p_sFileName", dbType: DbType.String, direction: ParameterDirection.Output, size: 50);

        string sql = @"begin
                        bars_dpa.form_file(:p_sFileType,  :p_sFileName);
                       end;";

        using (var connection = OraConnector.Handler.UserConnection)
        {
            connection.Execute(sql, p);
        }

        string fileName = p.Get<string>("p_sFileName");

        return fileName;
    }

    public string GetFileBody(string fileName)
    {
        string sql = @"select file_data from dpa_lob where file_name ='" + fileName + "'";

        using (var connection = OraConnector.Handler.UserConnection)
        {
            return connection.Query<string>(sql).SingleOrDefault();
        }
    }

    public string GetBranch()
    {
        string sql = @"select branch_usr.get_branch from dual";
        string branch = "";

        using (var connection = OraConnector.Handler.UserConnection)
        {
            branch = connection.Query<string>(sql).SingleOrDefault();
        }
        return branch;
    }

    public DateTime GetBankDate()
    {
        string sql = @"select gl.bd from dual";
        DateTime bdate = new DateTime();

        using (var connection = OraConnector.Handler.UserConnection)
        {
            bdate = connection.Query<DateTime>(sql).SingleOrDefault();
        }
        return bdate;
    }

    public List<CodesF2> GetCodesF2(string fileName)
    {
        string sql = "";
        if (fileName.Contains("@F2"))
            sql = @"select lf.err, S.n_er
                        from lines_f lf, s_er s  
                            where LF.ERR = S.K_ER
                            and lf.fn_r = '" + fileName + "'";
        else
            sql = @"select lf.err, S.n_er
                        from lines_k lf, s_er s  
                            where LF.ERR = S.K_ER
                            and lf.fn_r = '" + fileName + "'";

        using (var connection = OraConnector.Handler.UserConnection)
        {
            return connection.Query<CodesF2>(sql).ToList();
        }
    }

    public List<AllFiles> GetAllFiles(string fileType)
    {
        List<AllFiles> filesList = new List<AllFiles>();

        if (fileType == "F")
        {
            string branch = GetBranch();

            string path = _helper.GetDirectoryPathAndCheckIt(branch, "fi_", fileType);

            var filePaths = Directory.GetFiles(path);
            if (filePaths.Length != 0)
            {
                foreach (var file_path in filePaths)
                {
                    if (Path.GetFileName(file_path).Contains("@F1") || Path.GetFileName(file_path).Contains("@F2"))
                    {
                        AllFiles file = new AllFiles();
                        file.fileName = Path.GetFileName(file_path);
                        file.fileBody = File.ReadAllText(file_path);
                        file.path = Path.GetDirectoryName(file_path);
                        filesList.Add(file);
                    }
                }
            }
            else
            {
                AllFiles file = new AllFiles();
                file.path = path;
                filesList.Add(file);
            }
            if (filesList.Count == 0)
            {
                AllFiles file = new AllFiles();
                file.path = path;
                filesList.Add(file);
            }
        }
        else if (fileType == "R")
        {
            string branch = GetBranch();

            string path = _helper.GetDirectoryPathAndCheckIt(branch, "ri_", fileType);

            var filePaths = Directory.GetFiles(path);
            if (filePaths.Length != 0)
            {
                foreach (var file_path in filePaths)
                {
                    if (Path.GetFileName(file_path).Contains("@R"))
                    {
                        AllFiles file = new AllFiles();
                        file.fileName = Path.GetFileName(file_path);
                        file.fileBody = File.ReadAllText(file_path);
                        file.path = Path.GetDirectoryName(file_path);
                        filesList.Add(file);
                    }
                }
            }
            else
            {
                AllFiles file = new AllFiles();
                file.path = path;
                filesList.Add(file);
            }
            if (filesList.Count == 0)
            {
                AllFiles file = new AllFiles();
                file.path = path;
                filesList.Add(file);
            }
        }
        else if (fileType == "K")
        {
            string branch = GetBranch();

            string path = _helper.GetDirectoryPathAndCheckIt(branch, "ki_", fileType);

            var filePaths = Directory.GetFiles(path);
            if (filePaths.Length != 0)
            {
                foreach (var file_path in filePaths)
                {
                    if (Path.GetFileName(file_path).Contains("@K"))
                    {
                        AllFiles file = new AllFiles();
                        file.fileName = Path.GetFileName(file_path);
                        file.fileBody = File.ReadAllText(file_path);
                        file.path = Path.GetDirectoryName(file_path);
                        filesList.Add(file);
                    }
                }
            }
            else
            {
                AllFiles file = new AllFiles();
                file.path = path;
                filesList.Add(file);
            }
            if (filesList.Count == 0)
            {
                AllFiles file = new AllFiles();
                file.path = path;
                filesList.Add(file);
            }
        }
        return filesList;
    }

    public void InsertTicket(string path, string fileType, string fileName, string fileBody)
    {
        var branch = GetBranch();
        OracleParameter[] p = null;
        var sql = "";
        if (fileType == "F")
        {
            p = new OracleParameter[2];
            p[0] =  new OracleParameter("p_filename", OracleDbType.Varchar2,  100, fileName,  ParameterDirection.Input);
            p[1] =  new OracleParameter("p_filedata", OracleDbType.Clob, fileBody, ParameterDirection.Input);

            //sql = @"begin
            //            bars_dpa.ins_ticket(:p_filename, :p_filedata);
            //         end;";

            using (var connection = OraConnector.Handler.UserConnection)
            {
                OracleCommand oraCommand = connection.CreateCommand();
                oraCommand.CommandText = "bars_dpa.ins_ticket";
                oraCommand.CommandType = CommandType.StoredProcedure;
                oraCommand.Parameters.AddRange(p);
                oraCommand.ExecuteNonQuery();
            }
        }
        else if (fileType == "R0")
        {
            p = new OracleParameter[3];
            p[0] = new OracleParameter("p_filename", OracleDbType.Varchar2, 100, fileName, ParameterDirection.Input);
            p[1] = new OracleParameter("p_filedata", OracleDbType.Clob, fileBody, ParameterDirection.Input);
            p[2] = new OracleParameter("p_tickname", OracleDbType.Varchar2,4000,null, direction: ParameterDirection.Output);
            
            //sql = @"begin
            //            bars_dpa.ins_r0(:p_filename, :p_filedata, :p_tickname);
            //         end;";
           
            using (var connection = OraConnector.Handler.UserConnection)
            {
                OracleCommand oraCommand  =  connection.CreateCommand();
                oraCommand.CommandText = "bars_dpa.ins_r0";
                oraCommand.CommandType = CommandType.StoredProcedure;
                oraCommand.Parameters.AddRange(p);
                oraCommand.ExecuteNonQuery();
            }
           
            string p_tickname = p[2].Value.ToString();// p.Get<string>("p_tickname");

            sql = @"select 
                       val
                    from dpa_params where par = 'rb_" + branch.Replace("/", "") + "'";

            var dest_path = _helper.GetPath(sql);
            _helper.CheckAndCreateDirectory(dest_path);

            foreach (var file in Directory.GetFiles(path))
                if (Path.GetFileName(file) == fileName)
                {
                    File.Copy(file, Path.Combine(dest_path, Path.GetFileName(file)), true);
                    File.Delete(file);
                }

            sql = @"select file_data from dpa_lob where file_name = :p_tickname";

            var file_data = "";

            using (var connection = OraConnector.Handler.UserConnection)
            {
                file_data = connection.Query<string>(sql, new { p_tickname }).SingleOrDefault();
            }

            sql = @"select 
                       val
                    from dpa_params where par = 'ro_" + branch.Replace("/", "") + "'";

            path = _helper.GetPath(sql);
            _helper.CheckAndCreateDirectory(path);

            XmlDocument xdoc = new XmlDocument();
            xdoc.LoadXml(file_data);
            xdoc.Save(path + '/' + p_tickname);
        }
    }

    public List<F2Arc> GetF2Archive()
    {
        string sql = @"select fnk   
                       from zag_f
                       where fnk like '@F2%' 
                       and dat > sysdate-364
                       order by dat desc";

        using (var connection = OraConnector.Handler.UserConnection)
        {
            return connection.Query<F2Arc>(sql).ToList();
        }
    }

    public List<F2Arc> GetK2Archive()
    {
        string sql = @"select fnk   
                       from zag_f
                       where fnk like '@K2%' 
                       and dat > sysdate-364
                       order by dat desc";

        using (var connection = OraConnector.Handler.UserConnection)
        {
            return connection.Query<F2Arc>(sql).ToList();
        }
    }

    public List<R0Arc> GetR0Archive()
    {
        string sql = @"select fn  
                       from zag_f
                       where fn like '@R0%' 
                       and dat > sysdate-364
                       order by dat desc";

        using (var connection = OraConnector.Handler.UserConnection)
        {
            return connection.Query<R0Arc>(sql).ToList();
        }
    }

    public List<F2Grid> GetF2Grid(string fileName)
    {
        string sql = @"select err, mfo, okpo, rtype, nmkk, otype, odate, nls, kv, resid
                       from lines_f
                       where fn_r = :fileName
                       and trunc(dat) = (select max(trunc(dat)) from lines_f where fn_r = :fileName)";

        using (var connection = OraConnector.Handler.UserConnection)
        {
            return connection.Query<F2Grid>(sql, new { fileName }).ToList();
        }
    }

    public List<K0Grid> GetK2Grid(string fileName)
    {
        string sql = @"select mfo, okpo, otype, dat, nls, kv, resid, nmkk, c_reg, err
                       from lines_k
                       where fn_r = :fileName";

        using (var connection = OraConnector.Handler.UserConnection)
        {
            return connection.Query<K0Grid>(sql, new { fileName }).ToList();
        }
    }

    public List<R0Grid> GetR0Grid(string fileName)
    {
        string sql = @"select n, mfo, okpo, rtype, nmkk, odate, nls, kv, resid, 
        dat_in_dpa, dat_acc_dpa, id_pr, id_dpa, id_dps, id_rec, fn_f, n_f, err, (SELECT substr(err_msg,1,100) FROM dpa_err_codes WHERE err_code = err) as com
        from lines_r   
        where fn = :fileName
        and trunc(dat) = (select max(trunc(dat)) from zag_f where fn = :fileName)
		and dat > sysdate-364";

        using (var connection = OraConnector.Handler.UserConnection)
        {
            return connection.Query<R0Grid>(sql, new { fileName }).ToList();
        }
    }

    public void DeleteFile(string fileName, string path)
    {
        foreach (var file in Directory.GetFiles(path))
            if (Path.GetFileName(file) == fileName)
            {
                File.Delete(file);
            }
    }

    public List<T> GetFormedFilesF0Grid<T>(string file_type)
    {
        List<T> list = new List<T>();
        string sql = "";
        if (file_type == "F0List")
        {
            sql = @"select fn, 
                trunc(dat) as d_f0, 
                case when substr(f.fnk,1,3) = '@F1' then datk else datk1 end as d_F1,
                case when substr(f.fnk,1,3) = '@F2' then datk else null end as d_F2,
                (select dat from zag_f l where l.fn = replace(f.fn,'@F0','@R0') and l.dat >= trunc(f.dat, 'year')) as d_R0,
                nvl(err,' ') err, 
                C.ERR_MSG
                from zag_f f left join DPA_ERR_CODES c on C.ERR_CODE = f.err
                where F.DAT > sysdate-364 and fn like '@F0%'";
        }
        else
            sql = @"select fn, dat, nvl(err,' ') err
                       from zag_f
                       where fn like '@K%' 
                       and dat > sysdate-364
                       order by dat desc";
        using (var connection = OraConnector.Handler.UserConnection)
        {
            return connection.Query<T>(sql).ToList();
        }
    }

    public List<T> GetF0Grid<T>(string fileName)
    {
        string sql = "";
        List<T> list = new List<T>();
        if (Path.GetFileName(fileName).Contains("@F"))
        {
            sql = @"select mfo, okpo, rtype, otype, odate, nls, kv, nmkk, adr, resid, ntax as C_DST,
                c_reg, id_dps, err
                from lines_f
                where dat > sysdate-364 
                and fn = :fileName
                order by dat desc";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<T>(sql, new { fileName }).ToList();
            }
        }
        else if (Path.GetFileName(fileName).Contains("@K"))
        {
            sql = @"  select mfo, okpo, otype, dat, nls, kv, resid, nmkk, 
                            err
                            from lines_k
                            where dat > sysdate-364 
                            and fn = :fileName
                            order by dat desc";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<T>(sql, new { fileName }).ToList();
            }
        }
        return list;
    }

    private long GetContractNumber(string nls, decimal? kv)
    {
        var p = new DynamicParameters();

        p.Add("sNls", dbType: DbType.String, size: 100, value: nls, direction: ParameterDirection.Input);
        p.Add("nKv", dbType: DbType.Decimal, size: 100, value: kv, direction: ParameterDirection.Input);

        var sql = @"select acc from accounts where nls=:sNls and kv=:nKv";

        using (var connection = OraConnector.Handler.UserConnection)
        {
            return connection.Query<long>(sql, p).SingleOrDefault();
        }
    }

    private string GetIDTemplate(decimal? oper_type)
    {
        var sql = "";
        if (oper_type == 1)
            sql = @"SELECT ID FROM DOC_SCHEME WHERE ID = GetGlobalOption('DPA_DOCO')";
        else
            sql = @"SELECT ID FROM DOC_SCHEME WHERE ID =GetGlobalOption('DPA_DOCC')";

        using (var connection = OraConnector.Handler.UserConnection)
        {
            return connection.Query<string>(sql).SingleOrDefault();
        }
    }

    public void FormF0Files(string file_name, List<F0Grid> grid)
    {
        foreach (var row in grid)
        {
            string branch = GetBranch();
            var ContractNumber = GetContractNumber(row.NLS, row.KV);
            var TemplateID = GetIDTemplate(row.OTYPE);

            RtfReporter rep = new RtfReporter(HttpContext.Current);

            rep.RoleList = "reporter,dpt_role,cc_doc";
            rep.ContractNumber = ContractNumber;
            rep.TemplateID = TemplateID;

            rep.Generate();
            string sql = @"select 
                       val
                    from dpa_params where par = 'prt_" + branch.Replace("/", "") + "'";

            string path = _helper.GetPath(sql) + "/DPA_" + Path.GetFileNameWithoutExtension(file_name) + "/";
            _helper.CheckAndCreateDirectory(path);
            if (File.Exists(path + row.NLS + "_" + row.KV + ".rtf"))
            {
                File.Delete(path + row.NLS + "_" + row.KV + ".rtf");
            }
            else
                File.Copy(rep.ReportFile, path + row.NLS + "_" + row.KV + ".rtf");
        }
    }

    public PrintHeader GetPrintHeader()
    {
        PrintHeader list = new PrintHeader();

        string sql = @"select FIO from staff$base where id = user_id";

        using (var connection = OraConnector.Handler.UserConnection)
        {
            list.USER_NAME = connection.Query<string>(sql).SingleOrDefault();
        }

        list.DATE = DateTime.Now;

        return list;
    }
    public List<KVModel> GetKVs()
    {
        string sql = @"SELECT KV as ID, NAME FROM tabval";

        using (var connection = OraConnector.Handler.UserConnection)
        {
            return connection.Query<KVModel>(sql).ToList();
        }
    }


    public List<KVModel> GetCountries()
    {
        string sql = @"select country as ID, name from country";

        using (var connection = OraConnector.Handler.UserConnection)
        {
            return connection.Query<KVModel>(sql).ToList();
        }
    }
}
