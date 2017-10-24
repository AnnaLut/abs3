using Bars.Classes;
using Dapper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using BarsWeb.Areas.DptSocial.Infrastructure.Repository.DI.Abstract;
using Bars.Areas.DptSocial.Models;
using System.Web;
using System.IO;
using System.Text;
using System.Collections;
using System.Globalization;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.DptSocial.Infrastructure.Repository.DI.Implementation
{
    public class ImportFilesRepository : IImportFilesRepository
    {

        public ImportFilesRepository()
        {
        }

        public List<V_DPT_FILE_IMPR> GetImportedFilesGridData(Int32 file_tp, String file_date)
        {
            //query to get data form DB
            String sql_query = @"SELECT * from V_DPT_FILE_IMPR WHERE FILE_TP = :p_file_tp AND FILE_DT = to_date(:p_file_date, 'dd/MM/yyyy')";

            //parameters for query 
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("p_file_tp", dbType: DbType.Int32, value: file_tp, direction: ParameterDirection.Input);
            parameters.Add("p_file_date", dbType: DbType.String, value: file_date.Substring(0, 10), direction: ParameterDirection.Input);

            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<V_DPT_FILE_IMPR>(sql_query, parameters).ToList();
            }
        }

        public List<V_DPT_FILE_IMPR_DTL> GetImportedFileDetailGridData(String file_dt, Int32 file_tp)
        {
            //query to get data form DB
            String sql_query = @"SELECT * from V_DPT_FILE_IMPR_DTL WHERE FILE_DT = to_date(:p_file_dt, 'dd/MM/yyyy') AND FILE_TP = :p_file_tp";

            //parameters for query 
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("p_file_dt", dbType: DbType.String, value: file_dt, direction: ParameterDirection.Input);
            parameters.Add("p_file_tp", dbType: DbType.Int32, value: file_tp, direction: ParameterDirection.Input);

            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<V_DPT_FILE_IMPR_DTL>(sql_query, parameters).ToList();
            }
        }

        public Result ProcessFiles(String path, Int32 file_tp)
        {
            if (Directory.Exists(path))
            {
                String bank_date = GetBankDate();
                List<ProcessFileResult> error_files = new List<ProcessFileResult>();
                //get files by path
                var files = Directory.GetFiles(path);
                foreach (var fl in files)
                {
                    List<String> list = new List<String>();
                    List<INFO> info = new List<INFO>();
                    HEADER header = new HEADER();
                    String line = String.Empty;
                    String file_name = Path.GetFileName(fl);
                    String name = Path.GetFileNameWithoutExtension(file_name);
                    Int32 dd = Convert.ToInt32(name.Substring(name.Length - 2));
                    //commented by request of bank:
                    //"Огромная просьба отключить привязку к банковской дате, поскольку зачисление пенсии и соц. выплат не всегда привязан к банковской дате. Бывают случаи как дополнительного финансирования так и финансирования на будущие дни выплат."
                    //Int32 bank_day = Convert.ToInt32(bank_date.Substring(3,2));
                    if ((dd > 3 && dd < 26 && file_tp == 1) || file_tp == 2) //&& dd == bank_day
                        try
                        {
                            //get file content
                            using (var sr = new StreamReader(fl, Encoding.GetEncoding(866)))
                            {
                                while (true)
                                {
                                    line = sr.ReadLine();
                                    if (String.IsNullOrEmpty(line))
                                        break;
                                    list.Add(line);
                                }
                            }

                            //parse line to get file header
                            header = GetFileHeader(list[0]);

                            if (header.NUM_INFO > list.Count - 1)
                                throw new Exception("Недостатньо рядків у прийнятому банківському файлі!");
                            else if (header.NUM_INFO < list.Count - 1)
                                throw new Exception("Надлишкові рядки у прийнятому банківському файлі!");

                            //parse content to get file rows
                            for (int i = 0; i < header.NUM_INFO; i++)
                            {
                                info.Add(GetFileInfo(i + 1, Convert.ToString(list[i + 1]), bank_date));
                            }

                            //insert data to BD
                            WriteToDatabaseExt(true, header, info, file_tp, null, "");
                            //move file to another dir
                            try
                            {
                                MoveFile(path, bank_date, file_name);
                            }
                            catch (Exception ex)
                            {
                                throw new Exception("Немає прав для переміщення файлу.<br/>" + ex.Message);
                            }
                        }
                        catch (Exception ex)
                        {
                            error_files.Add(new ProcessFileResult(file_name, ex.Message));
                        }
                    else
                    {
                        error_files.Add(new ProcessFileResult(file_name, "Для пенсій день зарахування повинен бути у діапазоні від 4 до 25 та дорювнювати дню банківської дати."));
                    }
                }
                return new Result(error_files, files.ToList().Count);
            }
            else
                throw new Exception("Помилка.<br/>Шлях " + path + " відсутній.");
        }

        private bool WriteToDatabaseExt(bool setupAgencies, HEADER header, List<INFO> info, decimal type_id, decimal? agency_type, String Acc_Type)
        {
            string sql = @"BEGIN  dpt_social.create_file_header(:filename,:header_length,:dat,:info_length, 
                                                                :mfo_a,:nls_a,:mfo_b,:nls_b,:DK,:SUM,:TYPE,:num,:has_add,:name_a,:name_b,
                                                                :dest,:branch_num,:dpt_code,:exec_ord,:ks_ep,:type_id,:agency_type,:header_id,'2');
                           end; ";
            var p = new DynamicParameters();
            p.Add("filename", dbType: DbType.String, value: header.FILE_NAME, direction: ParameterDirection.Input);
            p.Add("header_length", dbType: DbType.Decimal, value: header.HEADER_LENGRH, direction: ParameterDirection.Input);
            p.Add("dat", dbType: DbType.Date, value: header.DTCREATED, direction: ParameterDirection.Input);
            p.Add("info_length", dbType: DbType.Decimal, value: header.NUM_INFO, direction: ParameterDirection.Input);
            p.Add("mfo_a", dbType: DbType.String, value: header.MFO_A, direction: ParameterDirection.Input);
            p.Add("nls_a", dbType: DbType.String, value: header.NLS_A, direction: ParameterDirection.Input);
            p.Add("mfo_b", dbType: DbType.String, value: header.MFO_B, direction: ParameterDirection.Input);
            p.Add("nls_b", dbType: DbType.String, value: header.NLS_B, direction: ParameterDirection.Input);
            p.Add("DK", dbType: DbType.Decimal, value: header.DK, direction: ParameterDirection.Input);
            p.Add("SUM", dbType: DbType.Decimal, value: header.SUM, direction: ParameterDirection.Input);
            p.Add("TYPE", dbType: DbType.Decimal, value: header.TYP, direction: ParameterDirection.Input);
            p.Add("num", dbType: DbType.String, value: header.NUMBER, direction: ParameterDirection.Input);
            p.Add("has_add", dbType: DbType.String, value: header.ADDEXIST, direction: ParameterDirection.Input);
            p.Add("name_a", dbType: DbType.String, value: header.NMK_A, direction: ParameterDirection.Input);
            p.Add("name_b", dbType: DbType.String, value: header.NMK_B, direction: ParameterDirection.Input);
            p.Add("dest", dbType: DbType.String, value: header.NAZN, direction: ParameterDirection.Input);
            p.Add("branch_num", dbType: DbType.Decimal, value: header.BRANCH_CODE, direction: ParameterDirection.Input);
            p.Add("dpt_code", dbType: DbType.Decimal, value: header.DPT_CODE, direction: ParameterDirection.Input);
            p.Add("exec_ord", dbType: DbType.String, value: header.EXEC_ORD, direction: ParameterDirection.Input);
            p.Add("ks_ep", dbType: DbType.String, value: header.KS_EP, direction: ParameterDirection.Input);
            p.Add("type_id", dbType: DbType.Decimal, value: type_id, direction: ParameterDirection.Input);
            p.Add("agency_type", dbType: DbType.Decimal, value: agency_type, direction: ParameterDirection.Input);
            p.Add("header_id", dbType: DbType.Decimal, direction: ParameterDirection.Output);

            bool isOk = false;
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var trans = connection.BeginTransaction();
                try
                {
                    connection.Execute(sql, p);
                    header.ID = p.Get<decimal>("header_id");

                    OracleCommand cmdInsertInfo = connection.CreateCommand();
                    cmdInsertInfo.CommandText = @"begin dpt_social.create_file_row_ext_group(:header_id, :filename,:dat,:nls,:branch_code,:dpt_code,:sum,:fio,:id_code,
                                                                                      :file_payoff, :payoff_date, :acc_type, :info_id); 
                                          end;";

                    TrimNls(info);

                    cmdInsertInfo.Parameters.Clear();
                    cmdInsertInfo.BindByName = true;

                    OracleParameter headerid = cmdInsertInfo.Parameters.Add("header_id", OracleDbType.Decimal);
                    headerid.Direction = ParameterDirection.Input;
                    headerid.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
                    headerid.Value = Enumerable.Repeat(header.ID, info.Count).ToArray();
                    headerid.Size = info.Count;
                    headerid.ArrayBindSize = null;

                    OracleParameter filename = cmdInsertInfo.Parameters.Add("filename", OracleDbType.Varchar2);
                    filename.Direction = ParameterDirection.Input;
                    filename.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
                    filename.Value = Enumerable.Repeat(header.FILE_NAME, info.Count).ToArray();
                    filename.Size = info.Count;
                    filename.ArrayBindSize = Enumerable.Repeat(header.FILE_NAME.Length, info.Count).ToArray();

                    OracleParameter dat = cmdInsertInfo.Parameters.Add("dat", OracleDbType.Date);
                    dat.Direction = ParameterDirection.Input;
                    dat.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
                    dat.Value = Enumerable.Repeat(header.DTCREATED, info.Count).ToArray();
                    dat.Size = info.Count;

                    OracleParameter nls = cmdInsertInfo.Parameters.Add("nls", OracleDbType.Varchar2);
                    nls.Direction = ParameterDirection.Input;
                    nls.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
                    nls.Value = info.Select(x => x.NLS).ToArray();
                    nls.Size = info.Count;
                    nls.ArrayBindSize = info.Select(x => x.NLS.Length).ToArray();

                    OracleParameter branch_code = cmdInsertInfo.Parameters.Add("branch_code", OracleDbType.Decimal);
                    branch_code.Direction = ParameterDirection.Input;
                    branch_code.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
                    branch_code.Value = info.Select(x => x.BRANCH_CODE).ToArray();
                    branch_code.Size = info.Count;


                    OracleParameter dpt_code = cmdInsertInfo.Parameters.Add("dpt_code", OracleDbType.Decimal);
                    dpt_code.Direction = ParameterDirection.Input;
                    dpt_code.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
                    dpt_code.Value = info.Select(x => x.DPT_CODE).ToArray();
                    dpt_code.Size = info.Count;

                    OracleParameter sum = cmdInsertInfo.Parameters.Add("sum", OracleDbType.Decimal);
                    sum.Direction = ParameterDirection.Input;
                    sum.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
                    sum.Value = info.Select(x => x.SUM).ToArray();
                    sum.Size = info.Count;

                    OracleParameter fio = cmdInsertInfo.Parameters.Add("fio", OracleDbType.Varchar2);
                    fio.Direction = ParameterDirection.Input;
                    fio.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
                    fio.Value = info.Select(x => x.FIO).ToArray();
                    fio.Size = info.Count;
                    fio.ArrayBindSize = info.Select(x => x.FIO.Length).ToArray();

                    OracleParameter id_code = cmdInsertInfo.Parameters.Add("id_code", OracleDbType.Varchar2);
                    id_code.Direction = ParameterDirection.Input;
                    id_code.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
                    id_code.Value = info.Select(x => x.ID_CODE).ToArray();
                    id_code.Size = info.Count;
                    id_code.ArrayBindSize = info.Select(x => x.ID_CODE.Length).ToArray();

                    OracleParameter file_payoff = cmdInsertInfo.Parameters.Add("file_payoff", OracleDbType.Varchar2);
                    file_payoff.Direction = ParameterDirection.Input;
                    file_payoff.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
                    file_payoff.Value = info.Select(x => x.FILE_PAYOFF_DATE).ToArray();
                    file_payoff.Size = info.Count;
                    file_payoff.ArrayBindSize = info.Select(x => x.FILE_PAYOFF_DATE.Length).ToArray();

                    OracleParameter payoff_date = cmdInsertInfo.Parameters.Add("payoff_date", OracleDbType.Date);
                    payoff_date.Direction = ParameterDirection.Input;
                    payoff_date.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
                    payoff_date.Value = info.Select(x => x.PAYOFF_DATE).ToArray();
                    payoff_date.Size = info.Count;

                    OracleParameter acc_type = cmdInsertInfo.Parameters.Add("acc_type", OracleDbType.Char);
                    acc_type.Direction = ParameterDirection.Input;
                    acc_type.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
                    acc_type.Value = Enumerable.Repeat(Acc_Type, info.Count).ToArray();
                    acc_type.Size = info.Count;

                    OracleParameter info_id = cmdInsertInfo.Parameters.Add("info_id", OracleDbType.Decimal);
                    info_id.Direction = ParameterDirection.Output;
                    info_id.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
                    info_id.Value = null;
                    info_id.Size = info.Count;

                    cmdInsertInfo.ExecuteNonQuery();

                    if (setupAgencies)
                    {
                        sql = @"begin dpt_social.set_agencyid(:header_id); end;";
                        p = new DynamicParameters();
                        p.Add("header_id", dbType: DbType.Decimal, value: header.ID, direction: ParameterDirection.Input);
                        connection.Execute(sql, p);
                    }
                    isOk = true;
                }
                catch (Exception ex)
                {
                    trans.Rollback();
                    throw ex;
                }
                finally
                {
                    if (isOk)
                        trans.Commit();
                }
            }
            return true;
        }

        private HEADER GetFileHeader(String str)
        {
            HEADER obj = new HEADER();
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd\\MM\\yy";
            cinfo.DateTimeFormat.DateSeparator = "\\";

            CultureInfo cinfo_alt = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo_alt.DateTimeFormat.ShortDatePattern = "ddMMyyyy";
            String error = String.Empty;
            String sub_string = String.Empty;
            try
            {
                error = "Помилка розбору заголовка: імя файлу (символи 0-15)";
                obj.FILE_NAME = str.Substring(0, 16).Trim();

                error = "Помилка розбору заголовка: код філії (символи 0-4)";
                obj.MAIN_FILIAL_NUMBER = str.Substring(0, 5).Trim(); ;

                error = "Помилка розбору заголовка: код відділення (символи 5-9)";
                obj.SUB_FILIAL_NUMBER = str.Substring(5, 5).Trim();

                error = "Помилка розбору заголовка: дата виплати (символи 10-11)";
                obj.FILE_PAYOFFDATE = str.Substring(10, 2).Trim();

                error = "Помилка розбору заголовка: роздільник (символи 12-12)";
                obj.SEPARATOR = str.Substring(12, 1).Trim();

                error = "Помилка розбору заголовка: код регіону (символи 13-15)";
                obj.REGION_CODE = str.Substring(13, 3).Trim();

                sub_string = str.Substring(16, 3);
                error = "Помилка розбору заголовка: довжина заголовку (символи 16-18)";
                obj.HEADER_LENGRH = Convert.ToDecimal(sub_string);

                sub_string = str.Substring(19, 8);
                error = "Помилка розбору заголовка: дата створення (символи 19-26)";
                obj.DTCREATED = Convert.ToDateTime(sub_string, cinfo);

                sub_string = str.Substring(27, 6).Trim();
                error = "Помилка розбору заголовка: кількість рядків (символи 27-32)";
                obj.NUM_INFO = Convert.ToDecimal(sub_string);

                error = "Помилка розбору заголовка: мфо платника (символи 33-41)";
                obj.MFO_A = str.Substring(33, 9).Trim();

                error = "Помилка розбору заголовка: рахунок платника (символи 42-50)";
                obj.NLS_A = str.Substring(42, 9).Trim();

                error = "Помилка розбору заголовка: мфо одержувача (символи 51-59)";
                obj.MFO_B = str.Substring(51, 9).Trim();

                error = "Помилка розбору заголовка: рахунок одержувача (символи 60-68)";
                obj.NLS_B = str.Substring(60, 9).Trim();

                error = "Помилка розбору заголовка: дебет-кредит (символи 69-69)";
                String sdk = str.Substring(69, 1).Trim();
                if (String.IsNullOrEmpty(sdk))
                    obj.DK = 1;
                else
                    obj.DK = Convert.ToDecimal(sdk);

                sub_string = str.Substring(70, 19).Trim();
                error = "Помилка розбору заголовка: сума файла (символи 70-88)";
                obj.SUM = Convert.ToDecimal(sub_string);

                sub_string = str.Substring(89, 2).Trim();
                error = "Помилка розбору заголовка: тип (символи 89-90)";
                obj.TYP = Convert.ToDecimal(sub_string);

                error = "Помилка розбору заголовка: номер (символи 91-100)";
                obj.NUMBER = str.Substring(91, 10).Trim();

                error = "Помилка розбору заголовка: (символи 101-101)";
                obj.ADDEXIST = str.Substring(101, 1).Trim();

                error = "Помилка розбору заголовка: найменування платника (символи 102-128)";
                obj.NMK_A = str.Substring(102, 27).Trim();

                error = "Помилка розбору заголовка: найменування одержувача (символи 129-155)";
                obj.NMK_B = str.Substring(129, 27).Trim();

                error = "Помилка розбору заголовка: призначення (символи 156-315)";
                obj.NAZN = str.Substring(156, 160).Trim();

                sub_string = str.Substring(316, 5).Trim();
                error = "Помилка розбору заголовка: код відділення (символи 316-320)";
                obj.BRANCH_CODE = Convert.ToDecimal(sub_string);

                error = "Помилка розбору заголовка: код депозита (символи 321-323)";
                String sdpt = str.Substring(321, 3).Trim();
                if (String.IsNullOrEmpty(sdpt))
                    obj.DPT_CODE = 0;
                else
                    obj.DPT_CODE = Convert.ToDecimal(sdpt);

                error = "Помилка розбору заголовка: порядок виконання (символи 324-333)";
                obj.EXEC_ORD = str.Substring(324, 10).Trim();

                error = "Помилка розбору заголовка: (символи 334-365)";
                obj.KS_EP = str.Substring(334, 32).Trim();
            }
            catch (Exception ex)
            {
                throw new Exception(error + ". " + ex.Message);
            }
            return obj;
        }

        private INFO GetFileInfo(int str_num, String str, String bdate)
        {
            String error = String.Empty;
            String sub_string = String.Empty;
            INFO obj = new INFO();
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";
            try
            {
                obj.ID = Decimal.MinValue;

                error = "Помилка розбору стрічки №" + Convert.ToString(str_num) + ": рахунок (символи 0-18)";
                obj.NLS = str.Substring(0, 19).Trim();

                sub_string = str.Substring(19, 5).Trim();
                error = "Помилка розбору стрічки №" + Convert.ToString(str_num) + ": код відділення (символи 19-23)";
                obj.BRANCH_CODE = Convert.ToDecimal(sub_string);

                sub_string = str.Substring(24, 3).Trim();
                error = "Помилка розбору стрічки №" + Convert.ToString(str_num) + ": код депозиту (символи 24-26)";
                obj.DPT_CODE = Convert.ToDecimal(sub_string);

                sub_string = str.Substring(27, 19).Trim();
                error = "Помилка розбору стрічки №" + Convert.ToString(str_num) + ": сума (символи 27-45)";
                obj.SUM = Convert.ToDecimal(sub_string);

                error = "Помилка розбору стрічки №" + Convert.ToString(str_num) + ": піб (символи 46-145)";
                obj.FIO = str.Substring(46, 100).Trim();

                error = "Помилка розбору стрічки №" + Convert.ToString(str_num) + ": ід. код. (символи 146-155)";
                obj.ID_CODE = str.Substring(146, 10).Trim();

                error = "Помилка розбору стрічки №" + Convert.ToString(str_num) + ": дата виплати (символи 156-157)";
                obj.FILE_PAYOFF_DATE = str.Substring(156, 2).Trim();

                obj.PAYOFF_DATE = DateTime.ParseExact(bdate, "MM/dd/yyyy", CultureInfo.InvariantCulture);
                obj.BRANCH = String.Empty;
                obj.REF = Decimal.MinValue;
                obj.INCORRECT = 0;
                obj.CLOSED = 0;
                obj.EXCLUDED = 0;
            }
            catch (Exception ex)
            {
                throw new Exception(error + ". " + ex.Message);
            }
            return obj;
        }

        private String GetBankDate()
        {
            String sql_query = @"select getglobaloption('BANKDATE') from dual";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<String>(sql_query).SingleOrDefault();
            }
        }

        private void MoveFile(String path, String bank_date, String file_name)
        {
            String bdate = bank_date.Replace('/', '-');
            String dest_dir = path + "\\" + bdate;
            String dest_path = dest_dir + "\\" + file_name;
            String source_path = path + "\\" + file_name;
            if (!Directory.Exists(dest_dir))
                Directory.CreateDirectory(dest_dir);
            File.Copy(source_path, dest_path, true);
            File.Delete(source_path);
        }

        private void TrimNls(List<INFO> info)
        {
            for (int i = 0; i < info.Count; i++)
            {
                info[i].NLS = info[i].NLS.Trim();

                String tmp = info[i].NLS.TrimStart('0');

                if (tmp == String.Empty)
                    continue;

                if (tmp.Length == 9)
                    info[i].NLS = "0" + tmp;
                else
                    info[i].NLS = tmp;
            }
        }
    }
}

