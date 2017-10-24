using Areas.DepoFiles.Models;
using Bars.Classes;
using Bars.Oracle;
using BarsWeb.Areas.DepoFiles.Infrastructure.DI.Abstract;
using BarsWeb.Areas.DepoFiles.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.DepoFiles.Models;
using BarsWeb.Areas.DepoFiles.Services;
using Dapper;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Objects.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;


namespace BarsWeb.Areas.DepoFiles.Infrastructure.Repository.DI.Implementation
{
    public class DepoFilesRepository : IDepoFilesRepository
    {
        private readonly DepoFilesService _service;
        private Entities _entities;

        public DepoFilesRepository(IModel model)
        {
            _entities = model.Entities;
            _service = new DepoFilesService();
        }

        public IEnumerable<AcceptedFiles> GetAcceptedFiles()
        {
            string sql = @"SELECT 
                                FILENAME,
                                DAT,
                                INFO_LENGTH,
                                to_char(SUM/100,'9999999999999999990.99') SUM, 
                                NAZN, HEADER_ID, to_char(DAT,'dd/mm/yyyy') FDAT, 
                                1 as CAN_DELETE,
                                BRANCH 
                            FROM DPT_FILE_HEADER 
                            WHERE BRANCH like sys_context('bars_context','user_branch_mask') and file_version = '2' ORDER BY header_id desc, DAT DESC, FILENAME DESC";
            return _entities.DPT_FILE_HEADER.Where(i => i.FILE_VERSION == "2").Select(i => new AcceptedFiles
            {
                FILENAME = i.FILENAME,
                DAT = i.DAT,
                INFO_LENGTH = i.INFO_LENGTH,
                SUM = i.SUM/100,
                NAZN = i.NAZN,
                HEADER_ID = i.HEADER_ID,
                BRANCH = i.BRANCH
            }).OrderByDescending(i => i.HEADER_ID);
        }

        public decimal Copy(decimal? header_id)
        {
            OracleConnection connect = new OracleConnection();

            try
            {
                connect = OraConnector.Handler.IOraConnection.GetUserConnection();


                OracleCommand cmdSetRole = connect.CreateCommand();
                cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
                cmdSetRole.ExecuteNonQuery();

                Decimal new_header_id = Decimal.MinValue;
                OracleCommand cmd = connect.CreateCommand();
                cmd.CommandText = "begin dpt_social.file_copy(:p_header_id,:p_header_id_new); end;";
                cmd.Parameters.Add("p_header_id", OracleDbType.Decimal, header_id.Value, ParameterDirection.Input);
                cmd.Parameters.Add("p_header_id_new", OracleDbType.Decimal, new_header_id, ParameterDirection.Output);

                cmd.ExecuteNonQuery();

                new_header_id = Convert.ToDecimal(Convert.ToString(cmd.Parameters["p_header_id_new"].Value));

                if (new_header_id != decimal.MinValue)
                {
                    CopyAdjustDptFileHeader(new_header_id);
                    return new_header_id;
                }
                else
                    throw new Exception("Файл не можна копіювати!");

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                    connect.Close(); connect.Dispose();
            }
        }

        public void Delete(decimal? header_id)
        {
            OracleConnection connect = new OracleConnection();

            connect = OraConnector.Handler.IOraConnection.GetUserConnection();

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = "begin dpt_social.file_delete(:p_header_id); end;";
            cmd.Parameters.Add("p_header_id", OracleDbType.Decimal, header_id, ParameterDirection.Input);

            cmd.ExecuteNonQuery();

            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
            
        }

        public static void CopyAdjustDptFileHeader(Decimal header_id)
        {
            OracleConnection connect = new OracleConnection();

            try
            {
                connect = OraConnector.Handler.IOraConnection.GetUserConnection();

                OracleCommand cmdSetRole = connect.CreateCommand();
                cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
                cmdSetRole.ExecuteNonQuery();

                OracleCommand cmdUpdateHeader = connect.CreateCommand();
                cmdUpdateHeader.CommandText = "update dpt_file_header " +
                    "set info_length = null, sum = null " +
                    "where header_id = :header_id";

                cmdUpdateHeader.BindByName = true;
                cmdUpdateHeader.Parameters.Add("header_id", OracleDbType.Decimal, header_id, ParameterDirection.Input);

                cmdUpdateHeader.ExecuteNonQuery();
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }
        }

        public IEnumerable<ShowFile> GetShowFile(decimal? header_id)
        {
            return _entities.V_DPT_FILE_ROW.Where(i => i.HEADER_ID == header_id).Select(i => new ShowFile
            {
                INFO_ID = i.INFO_ID,
                INFO_ID_TEXT = i.INFO_ID,
                NLS = i.NLS,
                BRANCH_CODE = i.BRANCH_CODE,
                DPT_CODE = i.DPT_CODE,
                SUM = i.SUM/100,
                FIO = i. FIO,
                ID_CODE = i.ID_CODE,
                PAYOFF_DATE = i.PAYOFF_DATE,
                REF = i.REF,
                INCORRECT = i.INCORRECT,
                CLOSED = i.CLOSED,
                EXCLUDED = i.EXCLUDED,
                BRANCH = i. BRANCH,
                AGENCY_NAME = i.AGENCY_NAME,
                MARKED4PAYMENT = i.MARKED4PAYMENT,
                DEAL_CREATED = i.DEAL_CREATED,
                REAL_ACC_NUM = i.REAL_ACC_NUM,
                REAL_CUST_CODE = i. REAL_CUST_CODE,
                REAL_CUST_NAME = i.REAL_CUST_NAME
            }).OrderBy(i => i.INFO_ID);
        }

        public IEnumerable<GridBranch> GetGridBranch(decimal? header_id)
        {
            string sql = @"SELECT 
                                A.BRANCH as BRANCH, 
                                A.AGENCY_ID as AGENCY_ID, 
                                S.AGENCY_NAME as AGENCY_NAME 
                           FROM DPT_FILE_AGENCY A, V_SOCIALAGENCIES_EXT S WHERE A.HEADER_ID = " + Convert.ToString(header_id) + " AND A.AGENCY_ID = S.AGENCY_ID";

            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<GridBranch>(sql).AsEnumerable();
            }
        }

        public List<DropDown> LoadFileTypes()
        {
            string sql = "SELECT type_id as value, type_name || ' - (Позабалансовий символ ' || sk_zb || ')' as text FROM SOCIAL_FILE_TYPES";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<DropDown>(sql).ToList();
            }
        }

        public List<DropDown> LoadAgencyTypes()
        {
            string sql = "SELECT type_id as value, type_name as text FROM SOCIAL_AGENCY_TYPE";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<DropDown>(sql).ToList();
            }
        }

        public List<DropDown> LoadAgencyInGb(int agency_type)
        {
            var p = new DynamicParameters();
            string sql = @"select name as TEXT, agency_id as VALUE from social_agency
                where branch = '/' || sys_context('bars_context', 'user_mfo') || '/'
                and type_id = :type_id
                and date_off is null";
            p.Add("type_id", dbType: DbType.Decimal, value: agency_type, direction: ParameterDirection.Input);
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<DropDown>(sql, p).ToList();
            }
        }

        public List<AccDropDown> LoadAccTypes()
        {
            string sql = "select type as value, name as text from v_file_account_types";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<AccDropDown>(sql).ToList();
            }
        }

        public List<AccDropDown> LoadBranchTypes()
        {
            string sql = @"select b.branch as VALUE, b.name as TEXT
                            from branch b, (
                                        SELECT CHILD_BRANCH || '%' branch
                                        FROM DPT_FILE_SUBST
                                        WHERE PARENT_BRANCH = sys_context('bars_context', 'user_branch')
                                    ) sub
                            WHERE b.branch = sys_context('bars_context', 'user_branch')
                     OR b.BRANCH like sub.branch";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<AccDropDown>(sql).ToList();
            }
        }

        public List<DropDown> GetSocAgency(string branch, int agency_type)
        {
            string sql = "select agency_id as value, agency_name as text from v_socialagencies_ext where agency_branch = :branch and agency_type = :agency_type ";
            var p = new DynamicParameters();
            p.Add("branch", dbType: DbType.String, size: 100, value: branch, direction: ParameterDirection.Input);
            p.Add("agency_type", dbType: DbType.String, size: 100, value: agency_type, direction: ParameterDirection.Input);
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<DropDown>(sql, p).ToList();
            }
        }

        public object GetDropDownValues(decimal header_id)
        {
            string sql = @"SELECT
                                TYPE_ID, AGENCY_TYPE
                            FROM DPT_FILE_HEADER
                            WHERE header_id =" + Convert.ToString(header_id) + "and file_version = '2'";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<object>(sql).ToList()[0];
            }
        }

        public void DeleteRow(decimal info_id)
        {
            string sql = @"DELETE FROM DPT_FILE_ROW WHERE INFO_ID = " + Convert.ToString(info_id);
            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Query(sql);
            }
        }


        public string GetStatistics(decimal header_id)
        {
            if (!String.IsNullOrEmpty(Convert.ToString(header_id)))
            {
                Decimal total_count = 0;
                Decimal total_sum = 0;
                Statistic statisctic = new Statistic();

                OracleConnection connect = new OracleConnection();

                connect = OraConnector.Handler.IOraConnection.GetUserConnection();

                OracleCommand cmdSetRole = connect.CreateCommand();
                cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
                cmdSetRole.ExecuteNonQuery();

                OracleCommand cmd = connect.CreateCommand();
                cmd.CommandText = "select sum/100, info_length from dpt_file_header where header_id = :header_id";
                cmd.Parameters.Add("header_id", OracleDbType.Decimal, header_id, ParameterDirection.Input);
                OracleDataReader rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                    if (!rdr.IsDBNull(0))
                        total_sum = rdr.GetOracleDecimal(0).Value;
                    if (!rdr.IsDBNull(1))
                        total_count = rdr.GetOracleDecimal(1).Value;
                }

                string sql = @"select sum(case when ref is not null then sum else 0 end)/100 as paid_sum, 
                                    count(case when ref is not null then ref else null end) as paid_count,
                                    sum(sum / 100) as our_sum,
                                    count(*) as our_count,
                                    sum(case when excluded = 1 then sum else 0 end) / 100 as ex_sum, 
                                    count(case when excluded = 1 then excluded else null end) as ex_count
                                from v_dpt_file_row
                                where header_id = " + Convert.ToString(header_id);

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    statisctic = connection.Query<Statistic>(sql).ToList()[0];
                }
                sql = "select sum(sum/100), count(*) from v_dpt_file_row where header_id = :header_id and marked4payment = 1";
                cmd.CommandText = sql;
                rdr = cmd.ExecuteReader();
                decimal topay_sum = 0, topay_count = 0;
                if (rdr.Read())
                {
                    if (!rdr.IsDBNull(0))
                        topay_sum = rdr.GetOracleDecimal(0).Value;
                    if (!rdr.IsDBNull(1))
                        topay_count = rdr.GetOracleDecimal(1).Value;
                }

                return "Загальна інформація про файл: кількість стрічок = " + Convert.ToString(total_count) + " сума = " + Convert.ToString(total_sum) + "\n" +
                "Видимих користувачу: кількість стрічок = " + Convert.ToString(statisctic.our_count) + " сума = " + Convert.ToString(statisctic.our_sum) + "\n" +
                "Зарахованих: кількість стрічок = " + Convert.ToString(statisctic.paid_count) + " сума = " + Convert.ToString(statisctic.paid_sum) + "\n" +
                "Виключених: кількість стрічок = " + Convert.ToString(statisctic.ex_count) + " сума = " + Convert.ToString(statisctic.ex_sum) + "\n" +
                "До зарахування: кількість стрічок = " + Convert.ToString(topay_count) + " сума = " + Convert.ToString(topay_sum);
            }
            else return "";
        }

        public void MarkLine(decimal info_id, decimal mark)
        {
            if (!String.IsNullOrEmpty(Convert.ToString(info_id)))
            {
                OracleConnection connect = new OracleConnection();
                IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
                connect = conn.GetUserConnection();


                OracleCommand cmdSetRole = connect.CreateCommand();
                cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
                cmdSetRole.ExecuteNonQuery();

                OracleCommand cmdIns = connect.CreateCommand();
                cmdIns.CommandText = @"update dpt_file_row set marked4payment = :mark where info_id = :info_id and ref is null";

                cmdIns.Parameters.Add("mark", OracleDbType.Decimal, mark, ParameterDirection.Input);
                cmdIns.Parameters.Add("info_id", OracleDbType.Decimal, info_id, ParameterDirection.Input);
                cmdIns.ExecuteNonQuery();
            }
            else throw new Exception("Некоректный номер стрічки.");
        }

        public void UpdateGridBranch(decimal header_id, string branch, int agency_id)
        {
            string sql = @"UPDATE DPT_FILE_AGENCY SET AGENCY_ID = :agency_id WHERE BRANCH = :branch AND HEADER_ID = :header_id";
            var p = new DynamicParameters();
            p.Add("branch", dbType: DbType.String, size: 100, value: branch, direction: ParameterDirection.Input);
            p.Add("agency_id", dbType: DbType.Int32, value: agency_id, direction: ParameterDirection.Input);
            p.Add("header_id", dbType: DbType.Decimal, value: header_id, direction: ParameterDirection.Input);
            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute(sql, p);
            }
        }

        public void InsertFileGrid(dynamic row)
        {
            string header = row["HEADER_ID"];
            string sql = @"begin dpt_social.create_file_row_ext( " +
                    " to_number('" + Convert.ToString(row["HEADER_ID"]) + "'), '" + row["FILE_NAME"] +
                    "', to_date('" + row["FDAT"] + "','dd/MM/yyyy'), " +
                    " :NLS,:BRANCH_CODE,:DPT_CODE,:SUM * 100,:FIO,:ID_CODE, null, to_date(:PAYOFF_DATE,'dd/mm/yyyy'), " +
                    " null, :INFO_ID); end;";
            var p = new DynamicParameters();
            p.Add("NLS", dbType: DbType.String, size: 19, value: Convert.ToString(row["NLS"]), direction: ParameterDirection.Input);
            p.Add("BRANCH_CODE", dbType: DbType.Decimal, value: Convert.ToDecimal(row["BRANCH_CODE"]), direction: ParameterDirection.Input);
            p.Add("DPT_CODE", dbType: DbType.Decimal, value: Convert.ToDecimal(row["DPT_CODE"]), direction: ParameterDirection.Input);
            p.Add("SUM", dbType: DbType.Decimal,  value: Convert.ToDecimal(row["SUM"]), direction: ParameterDirection.Input);
            p.Add("FIO", dbType: DbType.String, size: 100, value: Convert.ToString(row["FIO"]), direction: ParameterDirection.Input);
            p.Add("ID_CODE", dbType: DbType.String, size: 10, value: Convert.ToString(row["ID_CODE"]), direction: ParameterDirection.Input);
            p.Add("PAYOFF_DATE", dbType: DbType.String, size: 100, value: Convert.ToString(row["PAYOFF_DATE"]), direction: ParameterDirection.Input);
            p.Add("INFO_ID", dbType: DbType.Decimal, value: Convert.ToDecimal(row["INFO_ID"]), direction: ParameterDirection.Input);
            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute(sql, p);
            }
        }

        public string GetUFilename()
        {
            string sql = "select '.' || lpad(S_SOC_FILENAME.nextval,15,'0') from dual";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<string>(sql).SingleOrDefault();
            }
        }

        public string InsertHeader(AcceptedFiles obj)
        {
            OracleConnection connect = new OracleConnection();

            connect = OraConnector.Handler.IOraConnection.GetUserConnection();

            OracleCommand cmdIns = connect.CreateCommand();

            cmdIns.CommandText = "BEGIN " +
                " dpt_social.create_file_header(:filename,:header_length,:dat,:info_length, " +
                "  :mfo_a,:nls_a,:mfo_b,:nls_b,:DK,:SUM,:TYPE,:num,:has_add,:name_a,:name_b, " +
                "  :dest,:branch_num,:dpt_code,:exec_ord,:ks_ep,:type_id,:AGENCY_TYPE,:header_id,'2'); " +
                " end; ";
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";
            DateTime date = Convert.ToDateTime(obj.FDAT, cinfo);
            cmdIns.Parameters.Add("FILENAME", OracleDbType.Varchar2, obj.FILENAME, ParameterDirection.Input);
            cmdIns.Parameters.Add("HEADER_LENGTH", OracleDbType.Decimal, obj.HEADER_LENGTH, ParameterDirection.Input);
            cmdIns.Parameters.Add("DAT", OracleDbType.Date, date.Date, ParameterDirection.Input);
            cmdIns.Parameters.Add("INFO_LENGTH", OracleDbType.Decimal, null, ParameterDirection.Input);
            cmdIns.Parameters.Add("MFO_A", OracleDbType.Varchar2, obj.MFO_A, ParameterDirection.Input);
            cmdIns.Parameters.Add("NLS_A", OracleDbType.Varchar2, obj.NLS_A, ParameterDirection.Input);
            cmdIns.Parameters.Add("MFO_B", OracleDbType.Varchar2, obj.MFO_B, ParameterDirection.Input);
            cmdIns.Parameters.Add("NLS_B", OracleDbType.Varchar2, obj.NLS_B, ParameterDirection.Input);
            cmdIns.Parameters.Add("DK", OracleDbType.Decimal, obj.DK, ParameterDirection.Input);
            cmdIns.Parameters.Add("SUM", OracleDbType.Decimal, null, ParameterDirection.Input);
            cmdIns.Parameters.Add("TYPE", OracleDbType.Decimal, obj.TYPE, ParameterDirection.Input);
            cmdIns.Parameters.Add("NUM", OracleDbType.Varchar2, obj.NUM, ParameterDirection.Input);
            cmdIns.Parameters.Add("HAS_ADD", OracleDbType.Varchar2, obj.HAS_ADD, ParameterDirection.Input);
            cmdIns.Parameters.Add("NAME_A", OracleDbType.Varchar2, obj.NAME_A, ParameterDirection.Input);
            cmdIns.Parameters.Add("NAME_B", OracleDbType.Varchar2, obj.NAME_B, ParameterDirection.Input);
            cmdIns.Parameters.Add("NAZN", OracleDbType.Varchar2, obj.NAZN, ParameterDirection.Input);
            cmdIns.Parameters.Add("BRANCH_CODE", OracleDbType.Decimal, obj.BRANCH_CODE, ParameterDirection.Input);
            cmdIns.Parameters.Add("DPT_CODE", OracleDbType.Decimal, obj.DPT_CODE, ParameterDirection.Input);
            cmdIns.Parameters.Add("EXEC_ORD", OracleDbType.Varchar2, obj.EXEC_ORD, ParameterDirection.Input);
            cmdIns.Parameters.Add("KS_EP", OracleDbType.Varchar2, obj.KS_EP, ParameterDirection.Input);
            cmdIns.Parameters.Add("TYPE_ID", OracleDbType.Decimal, obj.TYPE_ID, ParameterDirection.Input);
            cmdIns.Parameters.Add("AGENCY_TYPE", OracleDbType.Decimal, obj.AGENCY_TYPE, ParameterDirection.Input);
            cmdIns.Parameters.Add("HEADER_ID", OracleDbType.Decimal, ParameterDirection.Output);

            cmdIns.ExecuteNonQuery();
            return Convert.ToString(cmdIns.Parameters[22].Value);

        }
        public FileHeaderModel GetFileHeader(string str)
        {
            FileHeaderModel obj = new FileHeaderModel();
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd\\MM\\yy";
            cinfo.DateTimeFormat.DateSeparator = "\\";

            CultureInfo cinfo_alt = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo_alt.DateTimeFormat.ShortDatePattern = "ddMMyyyy";

            try
            {
                obj.filename = str.Substring(0, 16);
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовка: імя файлу (символи 1-16)");
            }
            try
            {
                obj.mainFilialNumber = str.Substring(0, 5);
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовка: код філії (символи 1-5)");
            }
            try
            {
                obj.subFilialNumber = str.Substring(5, 5);
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовка: код відділення (символи 6-10)");
            }
            try
            {
                obj.filePayoffDate = str.Substring(10, 2);
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовка: дата виплати (символи 11-12)");
            }
            try
            {
                obj.separator = str.Substring(12, 1);
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовка: роздільник (символ 13)");
            }
            try
            {
                obj.regionCode = str.Substring(13, 3);
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовка: код регіону (символи 14-16)");
            }
            try
            {
                obj.headerLength = Convert.ToDecimal(str.Substring(16, 3));
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовка: довжина заголовку (символи 17-19)");
            }
            try
            {
                obj.dtCreated = Convert.ToDateTime(str.Substring(19, 8), cinfo);
            }
            catch (Exception)
            {
                try
                {
                    obj.dtCreated = new DateTime(Convert.ToInt32(str.Substring(23, 4)),
                        Convert.ToInt32(str.Substring(21, 2)),
                        Convert.ToInt32(str.Substring(19, 2)));

                }
                catch (Exception ex)
                {
                    throw new Exception("Помилка розбору заголовка: дата створення (символи 20-27)");
                }
            }
            try
            {
                obj.numInfo = Convert.ToDecimal(str.Substring(27, 6));
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовка: кількість рядків (символи 28-33)");
            }
            try
            {
                obj.MFO_A = str.Substring(33, 9);
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовка: мфо платника (символи 34-42)");
            }
            try
            {
                obj.NLS_A = str.Substring(42, 9);
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовка: рахунок платника (символи 43-51)");
            }
            try
            {
                obj.MFO_B = str.Substring(51, 9);
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовка: мфо одержувача (символи 52-60)");
            }
            try
            {
                obj.NLS_B = str.Substring(60, 9);
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовка: рахунок одержувача (символи 61-69)");
            }
            try
            {
                String sdk = str.Substring(69, 1);
                if (sdk == " ")
                    obj.DK = 1;
                else
                    obj.DK = Convert.ToDecimal(str.Substring(69, 1));
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовка: дебет-кредит (символ 70)");
            }
            try
            {
                obj.Sum = Convert.ToDecimal(str.Substring(70, 19));
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовка: сума файла (символи 71-89)");
            }
            try
            {
                obj.Typ = Convert.ToDecimal(str.Substring(89, 2));
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовка: тип (символи 90-91)");
            }
            try
            {
                obj.Number = str.Substring(91, 10);
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовка: номер (символи 92-101)");
            }
            try
            {
                obj.AddExists = str.Substring(101, 1);
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовка: (символ 102)");
            }
            try
            {
                obj.NMK_A = str.Substring(102, 27);
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовка: найменування платника (символи 103-129)");
            }
            try
            {
                obj.NMK_B = str.Substring(129, 27);
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовка: найменування одержувача (символи 130-156)");
            }
            try
            {
                obj.Nazn = str.Substring(156, 160);
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовка: призначення (символи 157-316)");
            }
            try
            {
                obj.Branch_code = Convert.ToDecimal(str.Substring(316, 5));
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовка: код відділення (символи 317-321)");
            }
            try
            {
                if (String.IsNullOrEmpty(str.Substring(321, 3).Trim()))
                    obj.Dpt_code = 0;
                else
                    obj.Dpt_code = Convert.ToDecimal(str.Substring(321, 3));
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовка: код депозита (символи 322-324)");
            }
            try
            {
                obj.Exec_ord = str.Substring(324, 10);
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовка: порядок виконання (символи 325-334)");
            }
            try
            {
                obj.KS_EP = str.Substring(334, 32);
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовка: (символи 335-366)");
            }
            return obj;
        }

        public ShowFile GetFileInfo(int str_num, string str, int month, int year)
        {
            ShowFile obj = new ShowFile();
            obj.ID = Decimal.MinValue;

            try
            {
                obj.NLS = str.Substring(0, 19);
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору стрічки №" + Convert.ToString(str_num) + ": рахунок (символи 1-19)");
            }
            try
            {
                obj.BRANCH_CODE = Convert.ToDecimal(str.Substring(19, 5));
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору стрічки №" + Convert.ToString(str_num) + ": код відділення (символи 20-24)");
            }
            try
            {
                obj.DPT_CODE = Convert.ToDecimal(str.Substring(24, 3));
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору стрічки №" + Convert.ToString(str_num) + ": код депозиту (символи 25-27)");
            }
            try
            {
                obj.SUM = Convert.ToDecimal(str.Substring(27, 19));
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору стрічки №" + Convert.ToString(str_num) + ": сума(символи 28-46)");
            }
            try
            {
                obj.FIO = str.Substring(46, 100);
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору стрічки №" + Convert.ToString(str_num) + ": піб (символи 47-146)");
            }
            try
            {
                obj.ID_CODE = str.Substring(146, 10);
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору стрічки №" + Convert.ToString(str_num) + ": ід. код. (символи 147-156)");
            }
            try
            {
                obj.FILE_PAYOFF_DATE = str.Substring(156, 2);
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору стрічки №" + Convert.ToString(str_num) + ": дата виплати (символи 157-158)");
            }
            try
            {
                obj.PAYOFF_DATE = new DateTime(year, month, 1);
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору стрічки №" + Convert.ToString(str_num) + ": помилка формування дати проплати");
            }

            obj.BRANCH = String.Empty;
            obj.REF = Decimal.MinValue;
            obj.INCORRECT = 0;
            obj.CLOSED = 0;
            obj.EXCLUDED = 0;
            return obj;
        }

        public decimal WriteToDatabaseExt(bool setupAgencies, FileHeaderModel header, List<ShowFile> info, decimal type_id, decimal agency_type, string Acc_Type)
        {
            string sql = "BEGIN " +
                " dpt_social.create_file_header(:filename,:header_length,:dat,:info_length, " +
                "  :mfo_a,:nls_a,:mfo_b,:nls_b,:DK,:SUM,:TYPE,:num,:has_add,:name_a,:name_b, " +
                "  :dest,:branch_num,:dpt_code,:exec_ord,:ks_ep,:type_id,:agency_type,:header_id,'2'); " +
                " end; ";
            var p = new DynamicParameters();
            p.Add("filename", dbType: DbType.String, value: header.filename, direction: ParameterDirection.Input);
            p.Add("header_length", dbType: DbType.Decimal, value: header.headerLength, direction: ParameterDirection.Input);
            p.Add("dat", dbType: DbType.Date, value: header.dtCreated, direction: ParameterDirection.Input);
            p.Add("info_length", dbType: DbType.Decimal, value: header.numInfo, direction: ParameterDirection.Input);
            p.Add("mfo_a", dbType: DbType.String, value: header.MFO_A.Trim(), direction: ParameterDirection.Input);
            p.Add("nls_a", dbType: DbType.String, value: header.NLS_A.Trim(), direction: ParameterDirection.Input);
            p.Add("mfo_b", dbType: DbType.String, value: header.MFO_B.Trim(), direction: ParameterDirection.Input);
            p.Add("nls_b", dbType: DbType.String, value: header.NLS_B.Trim(), direction: ParameterDirection.Input);
            p.Add("DK", dbType: DbType.Decimal, value: header.DK, direction: ParameterDirection.Input);
            p.Add("SUM", dbType: DbType.Decimal, value: header.Sum, direction: ParameterDirection.Input);
            p.Add("TYPE", dbType: DbType.Decimal, value: header.Typ, direction: ParameterDirection.Input);
            p.Add("num", dbType: DbType.String, value: header.Number, direction: ParameterDirection.Input);
            p.Add("has_add", dbType: DbType.String, value: header.AddExists, direction: ParameterDirection.Input);
            p.Add("name_a", dbType: DbType.String, value: header.NMK_A, direction: ParameterDirection.Input);
            p.Add("name_b", dbType: DbType.String, value: header.NMK_B, direction: ParameterDirection.Input);
            p.Add("dest", dbType: DbType.String, value: header.Nazn, direction: ParameterDirection.Input);
            p.Add("branch_num", dbType: DbType.Decimal, value: header.Branch_code, direction: ParameterDirection.Input);
            p.Add("dpt_code", dbType: DbType.Decimal, value: header.Dpt_code, direction: ParameterDirection.Input);
            p.Add("exec_ord", dbType: DbType.String, value: header.Exec_ord, direction: ParameterDirection.Input);
            p.Add("ks_ep", dbType: DbType.String, value: header.KS_EP, direction: ParameterDirection.Input);
            p.Add("type_id", dbType: DbType.Decimal, value: type_id, direction: ParameterDirection.Input);
            p.Add("agency_type", dbType: DbType.Decimal, value: agency_type, direction: ParameterDirection.Input);
            p.Add("header_id", dbType: DbType.Decimal, direction: ParameterDirection.Output);

            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute(sql, p);
            }

            decimal header_id = p.Get<decimal>("header_id");


            OracleConnection connect = new OracleConnection();

            connect = OraConnector.Handler.IOraConnection.GetUserConnection();

            OracleCommand cmdInsertInfo = connect.CreateCommand();
            cmdInsertInfo.CommandText = " begin dpt_social.create_file_row_ext_group( " +
                " :header_id, :filename,:dat,:nls,:branch_code,:dpt_code,:sum,:fio,:id_code, " +
                " :file_payoff, :payoff_date, :acc_type, :info_id); end;";

            _service.TrimNls(info);

            cmdInsertInfo.Parameters.Clear();
            cmdInsertInfo.BindByName = true;

            OracleParameter headerid = cmdInsertInfo.Parameters.Add("header_id", OracleDbType.Decimal);
            headerid.Direction = ParameterDirection.Input;
            headerid.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
            headerid.Value = _service.get_header_id(info, header_id);
            headerid.Size = info.Count;
            headerid.ArrayBindSize = null;

            OracleParameter filename = cmdInsertInfo.Parameters.Add("filename", OracleDbType.Varchar2);
            filename.Direction = ParameterDirection.Input;
            filename.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
            filename.Value = _service.get_filename(info, header);
            filename.Size = info.Count;
            filename.ArrayBindSize = _service.get_filename_size(info, header);

            OracleParameter dat = cmdInsertInfo.Parameters.Add("dat", OracleDbType.Date);
            dat.Direction = ParameterDirection.Input;
            dat.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
            dat.Value = _service.get_dat(info, header);
            dat.Size = info.Count;

            OracleParameter nls = cmdInsertInfo.Parameters.Add("nls", OracleDbType.Varchar2);
            nls.Direction = ParameterDirection.Input;
            nls.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
            nls.Value = _service.get_nls(info);
            nls.Size = info.Count;
            nls.ArrayBindSize = _service.get_nls_size(info);

            OracleParameter branch_code = cmdInsertInfo.Parameters.Add("branch_code", OracleDbType.Decimal);
            branch_code.Direction = ParameterDirection.Input;
            branch_code.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
            branch_code.Value = _service.get_branch_code(info);
            branch_code.Size = info.Count;


            OracleParameter dpt_code = cmdInsertInfo.Parameters.Add("dpt_code", OracleDbType.Decimal);
            dpt_code.Direction = ParameterDirection.Input;
            dpt_code.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
            dpt_code.Value = _service.get_dpt_code(info);
            dpt_code.Size = info.Count;

            OracleParameter sum = cmdInsertInfo.Parameters.Add("sum", OracleDbType.Decimal);
            sum.Direction = ParameterDirection.Input;
            sum.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
            sum.Value = _service.get_sum(info);
            sum.Size = info.Count;

            OracleParameter fio = cmdInsertInfo.Parameters.Add("fio", OracleDbType.Varchar2);
            fio.Direction = ParameterDirection.Input;
            fio.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
            fio.Value = _service.get_fio(info);
            fio.Size = info.Count;
            fio.ArrayBindSize = _service.get_fio_size(info);

            OracleParameter id_code = cmdInsertInfo.Parameters.Add("id_code", OracleDbType.Varchar2);
            id_code.Direction = ParameterDirection.Input;
            id_code.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
            id_code.Value = _service.get_id_code(info);
            id_code.Size = info.Count;
            id_code.ArrayBindSize = _service.get_id_code_size(info);

            OracleParameter file_payoff = cmdInsertInfo.Parameters.Add("file_payoff", OracleDbType.Varchar2);
            file_payoff.Direction = ParameterDirection.Input;
            file_payoff.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
            file_payoff.Value = _service.get_file_payoff(info);
            file_payoff.Size = info.Count;
            file_payoff.ArrayBindSize = _service.get_file_payoff_size(info);

            OracleParameter payoff_date = cmdInsertInfo.Parameters.Add("payoff_date", OracleDbType.Date);
            payoff_date.Direction = ParameterDirection.Input;
            payoff_date.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
            payoff_date.Value = _service.get_payoff_date(info);
            payoff_date.Size = info.Count;

            OracleParameter acc_type = cmdInsertInfo.Parameters.Add("acc_type", OracleDbType.Char);
            acc_type.Direction = ParameterDirection.Input;
            acc_type.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
            acc_type.Value = _service.get_acc_type(info, Acc_Type);
            acc_type.Size = info.Count;

            OracleParameter info_id = cmdInsertInfo.Parameters.Add("info_id", OracleDbType.Decimal);
            info_id.Direction = ParameterDirection.Output;
            info_id.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
            info_id.Value = null;
            info_id.Size = info.Count;

            cmdInsertInfo.ExecuteNonQuery();

            for (int i = 0; i < info.Count; i++)
                info[i].ID = Convert.ToDecimal(Convert.ToString(
                    (cmdInsertInfo.Parameters["info_id"].Value as Array).GetValue(i)
                    ));

            if (setupAgencies)
            {
                OracleCommand cmdFinish = connect.CreateCommand();
                cmdFinish.CommandText = "begin dpt_social.set_agencyid(:header_id); end;";

                cmdFinish.Parameters.Add("header_id", OracleDbType.Decimal, header.id, ParameterDirection.Input);
                cmdFinish.ExecuteNonQuery();
            }
            return header_id;
        }


        public FileHeaderModel GetFileHeader(string filename, DateTime dat, string header_id)
        {
            OracleConnection connect = new OracleConnection();
            FileHeaderModel header = new FileHeaderModel();
            // Создаем соединение
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            // Открываем соединение с БД


            // Устанавливаем роль
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdReadHeader = connect.CreateCommand();
            cmdReadHeader.CommandText = "SELECT " +
                "FILENAME,  HEADER_LENGTH, to_char(DAT,'dd/MM/yyyy'), INFO_LENGTH, MFO_A, NLS_A, " +
                "MFO_B, NLS_B, DK, SUM, TYPE, NUM, HAS_ADD, NAME_A, NAME_B, " +
                "NAZN, BRANCH_CODE, DPT_CODE, EXEC_ORD, KS_EP, TYPE_ID, AGENCY_TYPE " +
                "FROM DPT_FILE_HEADER " +
                "WHERE header_id=:header_id and file_version = '2'";
            cmdReadHeader.Parameters.Add("header_id", OracleDbType.Decimal, Convert.ToDecimal(header_id), ParameterDirection.Input);

            OracleDataReader hRead = cmdReadHeader.ExecuteReader();
            if (!hRead.Read())
            {
                throw new Exception("Не знайдено заголовок банківського файлу id = " + header_id +
                    " з іменем: " + filename + " за дату: " + dat.ToShortDateString());
            }

            if (!hRead.IsDBNull(0))
                header.filename = Convert.ToString(hRead.GetOracleString(0).Value);
            if (!hRead.IsDBNull(1))
                header.headerLength = Convert.ToDecimal(hRead.GetOracleDecimal(1).Value);
            if (!hRead.IsDBNull(2))
            {
                CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                cinfo.DateTimeFormat.DateSeparator = "/";

                header.dtCreated = Convert.ToDateTime(Convert.ToString(hRead.GetOracleString(2).Value), cinfo);
            }
            if (!hRead.IsDBNull(3))
                header.numInfo = Convert.ToDecimal(hRead.GetOracleDecimal(3).Value);
            if (!hRead.IsDBNull(4))
                header.MFO_A = Convert.ToString(hRead.GetOracleString(4).Value);
            if (!hRead.IsDBNull(5))
                header.NLS_A = Convert.ToString(hRead.GetOracleString(5).Value);
            if (!hRead.IsDBNull(6))
                header.MFO_B = Convert.ToString(hRead.GetOracleString(6).Value);
            if (!hRead.IsDBNull(7))
                header.NLS_B = Convert.ToString(hRead.GetOracleString(7).Value);
            if (!hRead.IsDBNull(8))
                header.DK = Convert.ToDecimal(hRead.GetOracleDecimal(8).Value);
            if (!hRead.IsDBNull(9))
                header.Sum = Convert.ToDecimal(hRead.GetOracleDecimal(9).Value);
            if (!hRead.IsDBNull(10))
                header.Typ = Convert.ToDecimal(hRead.GetOracleDecimal(10).Value);
            if (!hRead.IsDBNull(11))
                header.Number = Convert.ToString(hRead.GetOracleString(11).Value);
            if (!hRead.IsDBNull(12))
                header.AddExists = Convert.ToString(hRead.GetOracleString(12).Value);
            if (!hRead.IsDBNull(13))
                header.NMK_A = Convert.ToString(hRead.GetOracleString(13).Value);
            if (!hRead.IsDBNull(14))
                header.NMK_B = Convert.ToString(hRead.GetOracleString(14).Value);
            if (!hRead.IsDBNull(15))
                header.Nazn = Convert.ToString(hRead.GetOracleValue(15));
            if (!hRead.IsDBNull(16))
                header.Branch_code = Convert.ToDecimal(hRead.GetOracleDecimal(16).Value);
            if (!hRead.IsDBNull(17))
                header.Dpt_code = Convert.ToDecimal(hRead.GetOracleDecimal(17).Value);
            if (!hRead.IsDBNull(18))
                header.Exec_ord = Convert.ToString(hRead.GetOracleString(18).Value);
            if (!hRead.IsDBNull(19))
                header.KS_EP = Convert.ToString(hRead.GetOracleString(19).Value);

            if (!hRead.IsClosed) { hRead.Close(); }
            hRead.Dispose();

            return header;
            

        }
        public decimal[] GetParams(string header_id)
        {
            OracleConnection connect = new OracleConnection();
            FileHeaderModel header = new FileHeaderModel();
            // Создаем соединение
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            // Открываем соединение с БД


            // Устанавливаем роль
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdReadHeader = connect.CreateCommand();
            cmdReadHeader.CommandText = "SELECT " +
                "TYPE_ID, AGENCY_TYPE " +
                "FROM DPT_FILE_HEADER " +
                "WHERE header_id=:header_id and file_version = '2'";
            cmdReadHeader.Parameters.Add("header_id", OracleDbType.Decimal, Convert.ToDecimal(header_id), ParameterDirection.Input);

            OracleDataReader hRead = cmdReadHeader.ExecuteReader();
            decimal type_id = 0, AGENCY_TYPE = 0;
            while (hRead.Read())
            {
                if (!hRead.IsDBNull(0))
                    type_id = Convert.ToDecimal(hRead.GetOracleDecimal(0).Value);
                if (!hRead.IsDBNull(1))
                    AGENCY_TYPE = Convert.ToDecimal(hRead.GetOracleDecimal(1).Value);
            }
            if (!hRead.IsClosed) { hRead.Close(); }
            hRead.Dispose();

            return new decimal []{ type_id, AGENCY_TYPE };
        }

        public List<ShowFile> GetFileInfo(string header_id)
        {
            OracleConnection connect = new OracleConnection();
            List<ShowFile> info = new List<ShowFile>();

            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            OracleCommand cmdGetFileRow = connect.CreateCommand();
            cmdGetFileRow.CommandText = @"SELECT info_id, nls, branch_code, dpt_code, SUM, fio,
            id_code, payoff_date, REF,
            incorrect, closed, excluded, branch, marked4payment
            FROM DPT_FILE_ROW 
            WHERE header_id=:header_id order by info_id";

            cmdGetFileRow.Parameters.Add("header_id", OracleDbType.Decimal, Convert.ToDecimal(header_id), ParameterDirection.Input);

            OracleDataReader iReader = cmdGetFileRow.ExecuteReader();
            int i = 0;

            while (iReader.Read())
            {
                ShowFile sfile = new ShowFile();
                if (!iReader.IsDBNull(0))
                {
                    sfile.INFO_ID = Convert.ToDecimal(iReader.GetOracleDecimal(0).Value);
                    sfile.ID = Convert.ToDecimal(iReader.GetOracleDecimal(0).Value);
                }  
                if (!iReader.IsDBNull(1))
                    sfile.NLS = Convert.ToString(iReader.GetOracleString(1).Value);
                if (!iReader.IsDBNull(2))
                    sfile.BRANCH_CODE = Convert.ToDecimal(iReader.GetOracleDecimal(2).Value);
                if (!iReader.IsDBNull(3))
                    sfile.DPT_CODE = Convert.ToDecimal(iReader.GetOracleDecimal(3).Value);
                if (!iReader.IsDBNull(4))
                    sfile.SUM = Convert.ToDecimal(iReader.GetOracleDecimal(4).Value);
                if (!iReader.IsDBNull(5))
                    sfile.FIO = Convert.ToString(iReader.GetOracleString(5).Value);
                if (!iReader.IsDBNull(6))
                    sfile.ID_CODE = Convert.ToString(iReader.GetOracleString(6).Value);
                if (!iReader.IsDBNull(7))
                    sfile.PAYOFF_DATE = iReader.GetOracleDate(7).Value;
                if (!iReader.IsDBNull(8))
                    sfile.REF = Convert.ToDecimal(iReader.GetOracleDecimal(8).Value);
                if (!iReader.IsDBNull(9))
                    sfile.INCORRECT = Convert.ToDecimal(iReader.GetOracleDecimal(9).Value);
                if (!iReader.IsDBNull(10))
                    sfile.CLOSED = Convert.ToDecimal(iReader.GetOracleDecimal(10).Value);
                if (!iReader.IsDBNull(11))
                    sfile.EXCLUDED = Convert.ToDecimal(iReader.GetOracleDecimal(11).Value);
                if (!iReader.IsDBNull(12))
                    sfile.BRANCH = Convert.ToString(iReader.GetOracleString(12).Value);
                if (!iReader.IsDBNull(13))
                    sfile.MARKED4PAYMENT = iReader.GetOracleDecimal(13).Value;
                info.Add(sfile);
                i++;
            }

            if (!iReader.IsClosed) { iReader.Close(); }
            iReader.Dispose();

            return info;
        }

        public void PayGb(decimal agency_id, decimal header_id, decimal type_id)
        {
            OracleConnection connect = new OracleConnection();

            try
            {
                // Создаем соединение
                IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
                connect = conn.GetUserConnection();

                // Открываем соединение с БД


                // Устанавливаем роль
                OracleCommand cmdSetRole = connect.CreateCommand();
                cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
                cmdSetRole.ExecuteNonQuery();

                OracleCommand cmdRunPayProcedure = connect.CreateCommand();
                cmdRunPayProcedure.CommandText = "BEGIN dpt_social.pay_bankfile_ext_center(:header_id,:typeid,:agency_id); end;";
                cmdRunPayProcedure.Parameters.Add("header_id", OracleDbType.Decimal, header_id, ParameterDirection.Input);
                cmdRunPayProcedure.Parameters.Add("typeid", OracleDbType.Decimal, type_id, ParameterDirection.Input);
                cmdRunPayProcedure.Parameters.Add("agency_id", OracleDbType.Decimal, agency_id, ParameterDirection.Input);
                cmdRunPayProcedure.ExecuteNonQuery();
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }
        }

        public void Pay(decimal header_id, decimal type_id)
        {
            OracleConnection connect = new OracleConnection();

            try
            {
                // Создаем соединение
                IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
                connect = conn.GetUserConnection();

                // Открываем соединение с БД


                // Устанавливаем роль
                OracleCommand cmdSetRole = connect.CreateCommand();
                cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
                cmdSetRole.ExecuteNonQuery();

                OracleCommand cmdRunPayProcedure = connect.CreateCommand();
                cmdRunPayProcedure.CommandText = "BEGIN dpt_social.pay_bankfile_ext(:header_id,:typeid); end;";
                cmdRunPayProcedure.Parameters.Add("header_id", OracleDbType.Decimal, header_id, ParameterDirection.Input);
                cmdRunPayProcedure.Parameters.Add("typeid", OracleDbType.Decimal, type_id, ParameterDirection.Input);
                cmdRunPayProcedure.ExecuteNonQuery();
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }
        }

        public List<DepositBfRow> GetDepositBfRowCorrection(decimal info_id)
        {
            string sql = @"select cust_id, acc_id, acc_num, acc_type, asvo_account, cust_name, cust_code, doc_serial, doc_number, doc_issued, cust_bday, doc_date, branch_name from v_file_pretenders where info_id = :info_id";
            var p = new DynamicParameters();
            p.Add("info_id", dbType: DbType.Decimal, value: info_id, direction: ParameterDirection.Input);
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<DepositBfRow>(sql, p).ToList();
            }
        }

        public static bool IsCardAcc(String nls)
        {
            OracleConnection connect = new OracleConnection();

            try
            {
                connect = OraConnector.Handler.IOraConnection.GetUserConnection();


                OracleCommand cmdSetRole = connect.CreateCommand();
                cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
                cmdSetRole.ExecuteNonQuery();

                OracleCommand cmdCk = connect.CreateCommand();
                cmdCk.CommandText = @"select nvl(dpt_web.account_is_card (bars_context.extract_mfo(sys_context('bars_context','user_branch'))
                    ,:NLS),0) from dual";
                cmdCk.Parameters.Add("NLS", OracleDbType.Varchar2, nls, ParameterDirection.Input);

                String res = Convert.ToString(cmdCk.ExecuteScalar());

                return (res != "0");
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }
        }

        public void UpdateRow(UpdateModel model)
        {
            OracleConnection connect = new OracleConnection();

            try
            {
                IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
                connect = conn.GetUserConnection();


                OracleCommand cmdSetRole = connect.CreateCommand();
                cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
                cmdSetRole.ExecuteNonQuery();

                /// Не перевіряємо карткові рахунки
                if (model.NLS.Trim().Length < 1)
                {
                    throw new Exception("Довжина рахунку менша допустимої!");
                }
                if (IsCardAcc(model.NLS.Trim()))
                {
                    OracleCommand cmdCkCardAcc = connect.CreateCommand();
                    cmdCkCardAcc.CommandText = "select dpt_social.check_tm_card(:nls,:branch)+dpt_social.is_valid_social_card(:nls,:branch) from dual";
                    cmdCkCardAcc.BindByName = true;
                    cmdCkCardAcc.Parameters.Add("nls", OracleDbType.Varchar2, model.NLS.Trim(), ParameterDirection.Input);
                    cmdCkCardAcc.Parameters.Add("branch", OracleDbType.Varchar2, model.BRANCH, ParameterDirection.Input);
                    Decimal res = Convert.ToDecimal(cmdCkCardAcc.ExecuteScalar());
                    if (res < 1 && model.EXCLUDED == 0)
                    {
                        throw new Exception("Картковий рахунок не існує або некоректний");
                    }
                }
                else
                {
                    OracleCommand cmdCheckNLS = connect.CreateCommand();
                    cmdCheckNLS.CommandText = @"begin dpt_social.check_account_access(:nls,:branch,:p_id_code,:p_nmk,:acc_type,:p_exists); 
                    dpt_social.check_account_closed(:nls,:branch,:p_id_code,:p_nmk,:acc_type,:p_closed); end;";
                    cmdCheckNLS.BindByName = true;

                    Decimal p_exists = 0;
                    Decimal p_closed = 1;
                    cmdCheckNLS.Parameters.Add("nls", OracleDbType.Varchar2, model.NLS.Trim(), ParameterDirection.Input);
                    cmdCheckNLS.Parameters.Add("branch", OracleDbType.Varchar2, model.BRANCH, ParameterDirection.Input);
                    cmdCheckNLS.Parameters.Add("p_id_code", OracleDbType.Varchar2, model.IDCODE, ParameterDirection.Input);
                    cmdCheckNLS.Parameters.Add("p_nmk", OracleDbType.Varchar2, model.FIO, ParameterDirection.Input);
                    cmdCheckNLS.Parameters.Add("acc_type", OracleDbType.Char, model.ACCTYPE, ParameterDirection.Input);
                    cmdCheckNLS.Parameters.Add("p_exists", OracleDbType.Decimal, p_exists, ParameterDirection.Output);
                    cmdCheckNLS.Parameters.Add("p_closed", OracleDbType.Decimal, p_closed, ParameterDirection.Output);

                    cmdCheckNLS.ExecuteNonQuery();
                    p_exists = Convert.ToDecimal(Convert.ToString(cmdCheckNLS.Parameters["p_exists"].Value));
                    p_closed = Convert.ToDecimal(Convert.ToString(cmdCheckNLS.Parameters["p_closed"].Value));

                    if ((p_exists - p_closed <= 0) && model.EXCLUDED == 0)
                    {
                        throw new Exception("Введений рахунок не вірний або не існує!\\nВведіть коректні дані.");
                    }
                }

                OracleCommand cmdUpdate = connect.CreateCommand();
                cmdUpdate.CommandText = "update DPT_FILE_ROW set NLS=:nls, " +
                    " branch_code=:branch_code,dpt_code=:dpt_code,SUM=:sum,fio=:fio, " +
                    "id_code = :id_code, payoff_date = :payoff_date, excluded = :excluded, branch = :branch, incorrect = 0, closed = 0, acc_type = :acc_type " +
                    "WHERE info_id=:info_id";

                cmdUpdate.Parameters.Add("nls", OracleDbType.Varchar2, model.NLS.Trim(), ParameterDirection.Input);
                cmdUpdate.Parameters.Add("branch_code", OracleDbType.Decimal, model.BRANCHCODE, ParameterDirection.Input);
                cmdUpdate.Parameters.Add("dpt_code", OracleDbType.Decimal, model.DPTCODE, ParameterDirection.Input);
                cmdUpdate.Parameters.Add("sum", OracleDbType.Decimal, model.SUM * 100, ParameterDirection.Input);
                cmdUpdate.Parameters.Add("fio", OracleDbType.Varchar2, model.FIO, ParameterDirection.Input);
                cmdUpdate.Parameters.Add("id_code", OracleDbType.Varchar2, model.IDCODE, ParameterDirection.Input);
                cmdUpdate.Parameters.Add("payoff_date", OracleDbType.Date, model.PAYOFFDATE.Date, ParameterDirection.Input);
                cmdUpdate.Parameters.Add("excluded", OracleDbType.Decimal, model.EXCLUDED, ParameterDirection.Input);
                cmdUpdate.Parameters.Add("branch", OracleDbType.Varchar2, model.BRANCH, ParameterDirection.Input);
                cmdUpdate.Parameters.Add("acc_type", OracleDbType.Varchar2, model.ACCTYPE, ParameterDirection.Input);
                cmdUpdate.Parameters.Add("info_id", OracleDbType.Decimal, model.INFOID, ParameterDirection.Input);

                cmdUpdate.ExecuteNonQuery();
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }
        }

        public void Finish(decimal header_id)
        {
            OracleConnection connect = new OracleConnection();

            connect = OraConnector.Handler.IOraConnection.GetUserConnection();


            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdUpdateHeader = connect.CreateCommand();
            cmdUpdateHeader.CommandText = "update dpt_file_header " +
                "set (info_length,sum) = (select count(info_id),nvl(sum(sum),0) from dpt_file_row where header_id = :header_id) " +
                "where header_id = :header_id";

            cmdUpdateHeader.BindByName = true;
            cmdUpdateHeader.Parameters.Add("header_id", OracleDbType.Decimal, header_id, ParameterDirection.Input);

            cmdUpdateHeader.ExecuteNonQuery();

            OracleCommand cmdFinish = connect.CreateCommand();
            cmdFinish.CommandText = "begin dpt_social.set_agencyid(:header_id); end;";

            cmdFinish.Parameters.Add("header_id", OracleDbType.Decimal, header_id, ParameterDirection.Input);
            cmdFinish.ExecuteNonQuery();

            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }

        }

    }


}

