using Bars.Classes;
using BarsWeb.Areas.DptAdm.Infrastructure.Repository.DI.Abstract;
using Dapper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

/// <summary>
/// Summary description for EditFinesDFORepository
/// </summary>
namespace BarsWeb.Areas.DptAdm.Infrastructure.Repository.DI.Implementation
{
    public class EditFinesDFORepository : IEditFinesDFORepository
    {
        public EditFinesDFORepository()
        {

        }

        public List<T> GetData<T>(string modcode)
        {
            List<T> list = new List<T>();
            if (modcode == "DPT")
            {
                var sql = @"SELECT dpt_stop.rowid as idrow, 
                            dpt_stop.id,
                            dpt_stop.name, 
                            dpt_stop.mod_code,
                            dpt_stop.sh_proc,
                            d3.id term_NAME,
                            d2.id rest_NAME ,
                            d3.ID term_id ,
                            d2.ID rest_id      
                                  FROM dpt_stop,
                            dpt_shost d2,
                            dpt_shsrok d3
                            WHERE (dpt_stop.MOD_CODE = NVL('DPT', dpt_stop.MOD_CODE) OR dpt_stop.MOD_CODE IS NULL)
                                    AND dpt_stop.sh_ost = d2.id(+) 
                                    AND dpt_stop.fl = d3.id(+)
                            ORDER BY dpt_stop.id";
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    list = connection.Query<T>(sql).ToList();
                    return list;
                }
            }
            else if (modcode == "DPU")
            {
                var sql = @"SELECT dpt_stop.rowid as idrow, 
                            dpt_stop.id,
                            dpt_stop.name, 
                            dpt_stop.mod_code,
                            dpt_stop.sh_proc,
                            d3.id term_NAME,
                            d2.id rest_NAME ,
                            d3.ID term_id ,
                            d2.ID rest_id      
                                  FROM dpt_stop,
                            dpt_shost d2,
                            dpt_shsrok d3
                            WHERE (dpt_stop.MOD_CODE = NVL('DPU', dpt_stop.MOD_CODE) OR dpt_stop.MOD_CODE IS NULL)
                                    AND dpt_stop.sh_ost = d2.id(+) 
                                    AND dpt_stop.fl = d3.id(+)
                            ORDER BY dpt_stop.id";
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    return connection.Query<T>(sql).ToList();
                }
            }

            return list;
        }
        public List<T> GetFineData<T>(int id)
        {
            var p = new DynamicParameters();
            p.Add("p_Id", dbType: DbType.Int32, size: 50, value: id, direction: ParameterDirection.Input);

            var sql = @"SELECT a.rowid as IDROW, a.k_srok asr,
                        b.k_srok bsr,
                         a.k_proc,
                        a.sh_proc,
                        a.k_term,
                        a.sh_term
                        FROM dpt_stop_a a, dpt_stop_a b
                        WHERE     a.id = :p_Id
                                        AND b.id = :p_Id
                                        AND a.k_srok < b.k_srok
                                        AND b.K_SROK = (SELECT MIN (c.k_srok)
                                        FROM dpt_stop_a c
                                        WHERE c.k_srok > a.k_srok AND id = :p_Id)
                        ORDER BY a.k_srok";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<T>(sql, p).ToList();
            }
        }
        public List<T> TypesList<T>(string type)
        {
            var sql = "";
            if (type == "shost")
            {
                sql = @"select ID,NAME from DPT_SHOST";
            }
            else if (type == "shsrok")
            {
                sql = @"select ID,NAME from DPT_SHSROK";
            }
            else if (type == "shtype")
            {
                sql = @"select ID,NAME from DPT_SHTYPE";
            }
            else if (type == "shterm")
            {
                sql = @"select ID,NAME from DPT_SHTERM";
            }
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<T>(sql).ToList();
            }

        }
        public List<T> IfCheckBoxs<T>(int id)
        {
            var p = new DynamicParameters();
            p.Add("p_Id", dbType: DbType.Int32, size: 50, value: id, direction: ParameterDirection.Input);

            var sql = @"SELECT NVL (SUM (shproc_count), 0) AS nSh_Count,
                               NVL (SUM (shterm_count), 0) AS nShTerm_Count,
                               case when NVL (SUM (shproc_count), 0) = 1 then min(sh_proc) else null end nSh_Value,
                               case when NVL (SUM (shterm_count), 0) = 1 then min(sh_term) else null end nShTerm_Value
                          FROM (SELECT UNIQUE sh_proc, null as sh_term, 1 shproc_count, 0 shterm_count
                                  FROM dpt_stop_a
                                 WHERE id = :p_Id AND sh_proc <> 0
                                UNION ALL
                                SELECT UNIQUE null, sh_term, 0 shproc_count, 1 shterm_count
                                  FROM dpt_stop_a
                                 WHERE id = :p_Id AND sh_proc <> 0)";

            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<T>(sql, p).ToList();
            }
        }
        public String InsertRow(dynamic grid)
        {
            String message = "";
            var p = new DynamicParameters();
            /*var sql = @"insert into dpt_stop 
                        (ID, NAME, FL, SH_OST, MOD_CODE)
                        values (s_dpt_stop_id.nextval,:p_Name,:p_PeriodType ,:p_OstType,:p_ModCode)";*/
            var sql = @"begin
                            dpt_adm.InsPenalty(:p_NAME, :p_FL, :p_SH_PROC, :p_SH_OST, :p_MOD_CODE,:p_message);
                    end;";
            for (int i = 0; i < grid.Count; i++)
            {
                p.Add("p_Name", dbType: DbType.String, size: 500, value: Convert.ToString(grid[i].NAME), direction: ParameterDirection.Input);
                p.Add("p_FL", dbType: DbType.Decimal, size: 500, value: Convert.ToDecimal(grid[i].term_NAME), direction: ParameterDirection.Input);
                p.Add("p_SH_PROC", dbType: DbType.Decimal, size: 50, value: 0, direction: ParameterDirection.Input);
                p.Add("p_SH_OST", dbType: DbType.Decimal, value: Convert.ToDecimal(grid[i].rest_NAME), direction: ParameterDirection.Input);
                p.Add("p_MOD_CODE", dbType: DbType.String, size: 50, value: Convert.ToString(grid[i].MOD_CODE), direction: ParameterDirection.Input);
                p.Add("p_message", dbType: DbType.String, size: 2000, direction: ParameterDirection.Output);


                using (var connection = OraConnector.Handler.UserConnection)
                {
                    connection.Execute(sql, p);
                }
                message = p.Get<String>("p_message");
            }
            return message;

        }
        public void InsertFine(dynamic grid, dynamic ID)
        {
            decimal? BSR = 0;
            decimal? K_PROC = 0;
            decimal? SH_PROC = 0;
            decimal? K_TERM = 0;
            decimal? SH_TERM = 0;

            var p = new DynamicParameters();
            var sql = @"begin 
                             dpt_adm.FillPenalty(
                             :p_ID,
                             :p_K_SROK, 
                             :p_K_PROC, 
                             :p_SH_PROC,
                             :p_K_TERM,
                             :p_SH_TERM);
                         end;";


            for (int i = 0; i < grid.Count; i++)
            {

                if (Convert.ToString(grid[i].BSR) == "")
                {
                    BSR = null;
                }
                else
                    BSR = Convert.ToDecimal(grid[i].BSR);

                if (Convert.ToString(grid[i].K_PROC) == "")
                {
                    K_PROC = null;
                }
                else
                    K_PROC = Convert.ToDecimal(grid[i].K_PROC);

                if (Convert.ToString(grid[i].SH_PROC) == "")
                {
                    SH_PROC = null;
                }
                else
                    SH_PROC = Convert.ToDecimal(grid[i].SH_PROC);

                if (Convert.ToString(grid[i].K_TERM) == "")
                {
                    K_TERM = null;
                }
                else
                    K_TERM = Convert.ToDecimal(grid[i].K_TERM);

                if (Convert.ToString(grid[i].SH_TERM) == "")
                {
                    SH_TERM = null;
                }
                else
                    SH_TERM = Convert.ToDecimal(grid[i].SH_TERM);



                p.Add("p_ID", dbType: DbType.Decimal, size: 38, value: Convert.ToDecimal(ID), direction: ParameterDirection.Input);//+
                p.Add("p_K_SROK", dbType: DbType.Decimal, size: 7, value: BSR, direction: ParameterDirection.Input);//+
                p.Add("p_K_PROC", dbType: DbType.Decimal, size: 7, value: K_PROC, direction: ParameterDirection.Input);//+
                p.Add("p_SH_PROC", dbType: DbType.Decimal, size: 2, value: SH_PROC, direction: ParameterDirection.Input);//+
                p.Add("p_K_TERM", dbType: DbType.Decimal, size: 5, value: K_TERM, direction: ParameterDirection.Input);//+
                p.Add("p_SH_TERM", dbType: DbType.Decimal, size: 5, value: SH_TERM, direction: ParameterDirection.Input);//+

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    connection.Execute(sql, p);
                }
            }

        }

        public void UpdateFine(dynamic grid, dynamic ID)
        {
            decimal? BSR = 0;
            decimal? K_PROC = 0;
            decimal? SH_PROC = 0;
            decimal? K_TERM = 0;
            decimal? SH_TERM = 0;

            var p = new DynamicParameters();
            var sql = @"begin 
                             dpt_adm.UpdFillPenalty(
                             :p_idrow,
                             :p_ID,
                             :p_K_SROK, 
                             :p_K_PROC, 
                             :p_SH_PROC,
                             :p_K_TERM,
                             :p_SH_TERM);
                                commit;
                         end;";


            for (int i = 0; i < grid.Count; i++)
            {

                if (Convert.ToString(grid[i].BSR) == "")
                {
                    BSR = null;
                }
                else
                    BSR = Convert.ToDecimal(grid[i].BSR);

                if (Convert.ToString(grid[i].K_PROC) == "")
                {
                    K_PROC = null;
                }
                else
                    K_PROC = Convert.ToDecimal(grid[i].K_PROC);

                if (Convert.ToString(grid[i].SH_PROC) == "")
                {
                    SH_PROC = null;
                }
                else
                    SH_PROC = Convert.ToDecimal(grid[i].SH_PROC);

                if (Convert.ToString(grid[i].K_TERM) == "")
                {
                    K_TERM = null;
                }
                else
                    K_TERM = Convert.ToDecimal(grid[i].K_TERM);

                if (Convert.ToString(grid[i].SH_TERM) == "")
                {
                    SH_TERM = null;
                }
                else
                    SH_TERM = Convert.ToDecimal(grid[i].SH_TERM);


                p.Add("p_idrow", dbType: DbType.String, size: 38, value: Convert.ToString(grid[i].IDROW), direction: ParameterDirection.Input);//+
                p.Add("p_ID", dbType: DbType.Decimal, size: 38, value: Convert.ToDecimal(ID), direction: ParameterDirection.Input);//+
                p.Add("p_K_SROK", dbType: DbType.Decimal, size: 7, value: BSR, direction: ParameterDirection.Input);//+
                p.Add("p_K_PROC", dbType: DbType.Decimal, size: 7, value: K_PROC, direction: ParameterDirection.Input);//+
                p.Add("p_SH_PROC", dbType: DbType.Decimal, size: 2, value: SH_PROC, direction: ParameterDirection.Input);//+
                p.Add("p_K_TERM", dbType: DbType.Decimal, size: 5, value: K_TERM, direction: ParameterDirection.Input);//+
                p.Add("p_SH_TERM", dbType: DbType.Decimal, size: 5, value: SH_TERM, direction: ParameterDirection.Input);//+

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    connection.Execute(sql, p);
                }
            }

        }

        public String DeleteRow(dynamic rows)
        {
            String message = "";
            for (int i = 0; i < rows.Count; i++)
            {
                //try
                //{
                var p = new DynamicParameters();

                p.Add("p_ID", dbType: DbType.Decimal, size: 100, value: Convert.ToDecimal(rows[i].ID), direction: ParameterDirection.Input);
                p.Add("p_message", dbType: DbType.String, size: 2000, direction: ParameterDirection.Output);

                var sql = @"begin
                        dpt_adm.DelPenalty(:p_ID, :p_message);
                     end;";

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    connection.Execute(sql, p);
                }
                message = p.Get<String>("p_message");
                //return message;
                // }
                // catch (Exception ex) { };
            }
            return message;
        }
        public String DeleteFineSetting(dynamic rows, dynamic ID)
        {
            String message = "";
            for (int i = 0; i < rows.Count; i++)
            {
                var p = new DynamicParameters();
                p.Add("p_K_SROK", dbType: DbType.Decimal, size: 100, value: Convert.ToDecimal(rows[i].BSR), direction: ParameterDirection.Input);
                p.Add("p_ID", dbType: DbType.Decimal, size: 100, value: Convert.ToDecimal(ID), direction: ParameterDirection.Input);
                p.Add("p_message", dbType: DbType.String, size: 2000, direction: ParameterDirection.Output);

                var sql = @"begin
                        dpt_adm.DelFillPenalty(:p_ID, :p_K_SROK, :p_message);
                     end;";

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    connection.Execute(sql, p);
                }
                message = p.Get<String>("p_message");
            }
            return message;
        }
        public String UpdateRow(dynamic rows)
        {
            decimal? SH_PROC = null;
            string message = "";
            for (int i = 0; i < rows.Count; i++)
            {
                var p = new DynamicParameters();

                //if (rows[i].SH_PROC != null)
                //{
                //    if (Convert.ToString(rows[i].SH_PROC) == "")
                //    {
                //        SH_PROC = null;
                //    }
                //    else
                //        SH_PROC = Convert.ToDecimal(rows[i].SH_PROC);
                //}

                p.Add("p_ID", dbType: DbType.Decimal, value: Convert.ToDecimal(rows[i].ID), direction: ParameterDirection.Input);
                p.Add("p_Name", dbType: DbType.String, size: 50, value: Convert.ToString(rows[i].NAME), direction: ParameterDirection.Input);
                p.Add("p_FL", dbType: DbType.Decimal, value: Convert.ToDecimal(rows[i].FL), direction: ParameterDirection.Input);
                p.Add("p_SH_PROC", dbType: DbType.Decimal, value: Convert.ToDecimal(rows[i].SH_PROC), direction: ParameterDirection.Input);
                p.Add("p_SH_OST", dbType: DbType.Decimal, value: Convert.ToDecimal(rows[i].SH_OST), direction: ParameterDirection.Input);
                p.Add("p_MOD_CODE", dbType: DbType.String, size: 100, value: Convert.ToString(rows[i].MOD_CODE), direction: ParameterDirection.Input);

                p.Add("p_message", dbType: DbType.String, size: 100, value: message, direction: ParameterDirection.Output);


                var sql = @"begin
                        dpt_adm.updPenalty(:p_ID, :p_NAME, :p_FL, :p_SH_PROC, :p_SH_OST, :p_MOD_CODE, :p_message);
                     end;";

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    connection.Execute(sql, p);
                }
                message = p.Get<String>("p_message");
            }
            return message;
        }
    }
}