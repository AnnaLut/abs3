using BarsWeb.Areas.Dcp.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Dcp.Models;
using System.Collections.Generic;
using Dapper;
using Bars.Classes;
using System.Linq;
using System.IO;
using System;
using System.Data;
using System.Globalization;
using System.Text;
using System.Collections;
using Bars.Doc;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace BarsWeb.Areas.Dcp.Infrastructure.Repository.DI.Implementation
{
    public class DepositaryRepository : IDepositaryRepository
    {
        const int HEADER_ROW_INDEX = 1;
        const int DATA_ROW_INDEX = 2;

        public DepositaryRepository()
        {
        }

        /// <summary>
        /// Повертає дані для таблиці
        /// </summary>
        /// <param name="nPar"></param>
        /// <returns></returns>
        public List<PFileGridData> GetGridData(decimal nPar, string fn)
        {
            string sql_select = @"SELECT DCP_P.MFOA as MFOA,    DCP_P.MDOA as MDOA,   DCP_P.MFOB as MFOB,  
                                    DCP_P.MDOB as MDOB,   DCP_P.NLSB as NLSB, 
                                    DCP_P.OKPOB as OKPOB,   DCP_P.S / 100 as S,  DCP_P.ID_UG as ID_UG,
                                    DCP_P.DAT_UG as DAT_UG, DCP_P.OZN_SP as OZN_SP, 
                                    DCP_P.FN as FN, substr(b.nb, 1, 38) as NAMB, DCP_P.acc as ACC,   
                                    DCP_P.ID as ID, DCP_P.ref as REF, 
                                    DCP_P.OKPOA as OKPOA,   DCP_P.N_UG as N_UG,   DCP_P.D_UG as D_UG,
                                    case when DCP_P.MFOA = DCP_P.MFOB then 
                                         (SELECT a.name as VOB_NAME1 
                                            FROM vob a, tts_vob b
                                           WHERE a.vob = b.vob and b.tt = 'ЦП1')
                                    else (SELECT a.name as VOB_NAME2 
                                            FROM vob a, tts_vob b 
                                           WHERE a.vob = b.vob and b.tt = 'ЦП2')
                                    end as VOB_NAME,
                                     case when DCP_P.MFOA = DCP_P.MFOB then 
                                         (SELECT a.vob as VOB
                                            FROM vob a, tts_vob b
                                           WHERE a.vob = b.vob and b.tt = 'ЦП1')
                                    else (SELECT a.vob  
                                            FROM vob a, tts_vob b 
                                           WHERE a.vob = b.vob and b.tt = 'ЦП2')
                                    end as VOB, 
                                                (SELECT nls FROM accounts WHERE acc=DCP_P.ACC) as NLSA,
                                                (SELECT substr(nms,1,38) FROM accounts WHERE acc=DCP_P.ACC) as NAMA     
                                  FROM DCP_P, banks b
                                 WHERE DCP_P.mfob = b.mfo ";//substr(dcp.get_nazn_by_mask(dcp_p.id), 1, 160) as NAZN
            string sql_where = " AND DCP_P.REF IS NULL ";
            string sql_ord = " ORDER BY DCP_P.MFOB, DCP_P.FN ";
            string sql_query = "";
            List<PFileGridData> list = new List<PFileGridData>();
            if (nPar == 1)
            {
                if (fn == null)
                    return list;
                else
                {
                    list = GetAcceptedGridData(fn);
                    for (int i = 0; i < list.Count; i++)
                    {
                        list[i].NAZN = "Поставка проти оплати за ДЦП. Угода " + list[i].N_UG + " Дата " + list[i].DAT_UG.ToString(@"dd\/MM\/yyyy");
                    }
                    return list;
                }
            }
            else
            {
                sql_query = sql_select + sql_where + sql_ord;//
            }
            using (var connection = OraConnector.Handler.UserConnection)
            {
                list = connection.Query<PFileGridData>(sql_query).ToList();
            }
            for (int i = 0; i < list.Count; i++)
            {
                list[i].NAZN = "Поставка проти оплати за ДЦП. Угода " + list[i].N_UG + " Дата " + list[i].DAT_UG.ToString(@"dd\/MM\/yyyy");
            }
            return list;
        }

        /// <summary>
        /// Повертає вид документу
        /// </summary>
        /// <param name="type"></param>
        /// <returns></returns>
        public Vob GetVob(string type)
        {
            string sql_query = @"SELECT a.vob as VOB, a.name as VOB_NAME 
                          FROM vob a, tts_vob b
                          WHERE a.vob = b.vob and b.tt = '" + type + "'" +
                          " ORDER BY ord";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<Vob>(sql_query).SingleOrDefault();
            }
        }

        /// <summary>
        /// Повертає дані прийнятих файлів для таблиці
        /// </summary>
        /// <param name="nPar"></param>
        /// <returns></returns>
        public List<PFileGridData> GetAcceptedGridData(string fn)
        {
            string sql_select = @"SELECT DCP_P.MFOA as MFOA,    DCP_P.MDOA as MDOA,   DCP_P.MFOB as MFOB,  
                                    DCP_P.MDOB as MDOB,   DCP_P.NLSB as NLSB, 
                                    DCP_P.OKPOB as OKPOB,   DCP_P.S / 100 as S,  DCP_P.ID_UG as ID_UG,
                                    DCP_P.DAT_UG as DAT_UG, DCP_P.OZN_SP as OZN_SP, 
                                    DCP_P.FN as FN, substr(b.nb, 1, 38) as NAMB, DCP_P.acc as ACC,   
                                    DCP_P.ID as ID, DCP_P.ref as REF, 
                                    DCP_P.OKPOA as OKPOA,   DCP_P.N_UG as N_UG,   DCP_P.D_UG as D_UG
                                  FROM DCP_P, banks b
                                  WHERE DCP_P.mfob = b.mfo ";//substr(dcp.get_nazn_by_mask(dcp_p.id), 1, 160) as NAZN
            string sql_where = " AND DCP_P.REF IS NULL";
            string sql_ord = " ORDER BY DCP_P.MFOB, DCP_P.FN ";
            string sql_query = "";
            sql_query = sql_select + sql_where + " AND substr(DCP_P.FN,2,11) like ('" + fn.Substring(1, 11) + "') " + sql_ord;
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<PFileGridData>(sql_query).ToList();
            }
        }

        /// <summary>
        /// Повертає дані архіву 
        /// </summary>
        /// <returns></returns>
        public List<PFileGridData> GetArchGridData()
        {
            List<PFileGridData> list = new List<PFileGridData>();
            string sql_select = @"SELECT DCP_P.MFOA as MFOA,    DCP_P.MDOA as MDOA,   DCP_P.MFOB as MFOB,  
                                    DCP_P.MDOB as MDOB,   DCP_P.NLSB as NLSB, 
                                    DCP_P.OKPOB as OKPOB,   DCP_P.S / 100 as S,  DCP_P.ID_UG as ID_UG,
                                    DCP_P.DAT_UG as DAT_UG, DCP_P.OZN_SP as OZN_SP, 
                                    DCP_P.FN as FN, substr(b.nb, 1, 38) as NAMB, DCP_P.acc as ACC,   
                                    DCP_P.ID as ID, DCP_P.ref as REF, 
                                    DCP_P.OKPOA as OKPOA,   DCP_P.N_UG as N_UG,   DCP_P.D_UG as D_UG, 
                                                (SELECT nls FROM accounts WHERE acc=DCP_P.ACC) as NLSA,
                                                (SELECT substr(nms,1,38) FROM accounts WHERE acc=DCP_P.ACC) as NAMA
                                  FROM DCP_P, banks b
                                  WHERE DCP_P.mfob = b.mfo ";//substr(dcp.get_nazn_by_mask(dcp_p.id), 1, 160) as NAZN
            string sql_ord = " ORDER BY DCP_P.MFOB, DCP_P.FN ";
            string sql_query = "";
            sql_query = sql_select + sql_ord;
            using (var connection = OraConnector.Handler.UserConnection)
            {
                list = connection.Query<PFileGridData>(sql_query).ToList();
            }
            return list;
        }

        /// <summary>
        /// Приймає та оброблює файл
        /// </summary>
        public object AcceptFile(bool update)
        {
            HeaderData header_data = new HeaderData();
            List<PFileGridData> grid_data = new List<PFileGridData>();
            string[] filePaths = Directory.GetFiles(GetPath(), "&P1ILP*.*");
            if (filePaths.Length > 0)
            {
                header_data = GetHeaderFromFile(filePaths[0]);
                if (update)
                {
                    DeleteFromDCP(header_data.FN, header_data.DATF);
                }
                WriteToDcpZag(header_data.FN, header_data.DATF.ToString(@"dd\/MM\/yyyy HH:mm:ss"));
                grid_data = GetListGridDataFromFile(filePaths[0], header_data.INFO_LENGTH);
                InsertFileData(grid_data, filePaths[0], header_data);
                return new { fn = header_data.FN };
            }
            else throw new Exception("Немає файлів &P1ILP*.* у " + GetPath());
        }

        public string GetPath()
        {
            string sql_query = @"select val from dcp_params where par = 'DCP_IN'";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<string>(sql_query).SingleOrDefault();
            }
        }

        /// <summary>
        /// Перевіряє чи був оплачений файл
        /// </summary>
        public bool CheckStorno()
        {
            StornoModel model = new StornoModel();
            HeaderData header_data = new HeaderData();
            string[] filePaths = Directory.GetFiles(GetPath(), "&P1ILP*.*");
            if (filePaths.Length > 0)
            {
                header_data = GetHeaderFromFile(filePaths[0]);
                string sql_query = @"SELECT count(p1.ref) as nSos1, count(p5.ref) as nSos5
                                 FROM dcp_p d, oper p1, oper p5
                                 WHERE upper(d.fn) = upper('" + header_data.FN + @"') 
                                        and dat = to_date('" + header_data.DATF.ToString(@"dd\/MM\/yyyy HH:mm:ss") + @"', 'dd/mm/yyyy hh24:MI:ss')  
                                        and d.ref= p1.ref(+) AND p1.sos(+) = 1 AND d.ref= p5.ref(+) AND p5.sos(+) = 5";
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    model = connection.Query<StornoModel>(sql_query).SingleOrDefault();
                }
            }
            if (model.nSos5 > 0)
                throw new Exception("Файл " + header_data.FN + "не може бути прийнято повторно - документ вже оплачено!");
            if (model.nSos1 > 0)
                return true;
            return false;
        }

        /// <summary>
        /// Записує оброблений файл до бази
        /// </summary>
        /// <param name="path"></param>
        public void InsertFileData(List<PFileGridData> grid_data, string path, HeaderData header_data)
        {
            string sql_query = @"INSERT INTO dcp_p(MFOA,MDOA,MFOB,MDOB,NLSB,OKPOB,S,ID_UG,DAT_UG,OZN_SP,FN,DAT,OKPOA,N_UG,D_UG, ACC)
                                 VALUES(:MFOA,:MDOA,:MFOB,:MDOB,:NLSB,:OKPOB,:S,:ID_UG, to_date(:DAT_UG,'dd/mm/yyyy'),:OZN_SP, :sFile, to_date(:dDatFile,'dd/mm/yyyy hh24:MI:ss'), :OKPOA,:N_UG, to_date(:D_UG,'dd/mm/yyyy'), :nAcc)";//:sRezerv
            for (int i = 0; i < grid_data.Count; i++)
            {
                var p = new DynamicParameters();
                p.Add("MFOA", dbType: DbType.String, size: 100, value: grid_data[i].MFOA, direction: ParameterDirection.Input);
                p.Add("MDOA", dbType: DbType.String, size: 100, value: grid_data[i].MDOA, direction: ParameterDirection.Input);
                p.Add("MFOB", dbType: DbType.String, size: 100, value: grid_data[i].MFOB, direction: ParameterDirection.Input);
                p.Add("MDOB", dbType: DbType.String, size: 100, value: grid_data[i].MDOB, direction: ParameterDirection.Input);
                p.Add("NLSB", dbType: DbType.String, size: 100, value: grid_data[i].NLSB, direction: ParameterDirection.Input);
                p.Add("OKPOB", dbType: DbType.String, size: 100, value: grid_data[i].OKPOB, direction: ParameterDirection.Input);
                p.Add("S", dbType: DbType.Decimal, value: grid_data[i].S, direction: ParameterDirection.Input);
                p.Add("ID_UG", dbType: DbType.String, size: 100, value: grid_data[i].ID_UG, direction: ParameterDirection.Input);
                p.Add("DAT_UG", dbType: DbType.String, value: grid_data[i].DAT_UG.ToString("dd/MM/yyyy"), direction: ParameterDirection.Input);
                p.Add("OZN_SP", dbType: DbType.String, size: 100, value: grid_data[i].OZN_SP, direction: ParameterDirection.Input);
                p.Add("sFile", dbType: DbType.String, size: 100, value: header_data.FN, direction: ParameterDirection.Input);
                p.Add("dDatFile", dbType: DbType.String, value: header_data.DATF.ToString(@"dd\/MM\/yyyy HH:mm:ss"), direction: ParameterDirection.Input);
                p.Add("OKPOA", dbType: DbType.String, size: 100, value: grid_data[i].OKPOA, direction: ParameterDirection.Input);
                p.Add("N_UG", dbType: DbType.String, size: 100, value: grid_data[i].N_UG, direction: ParameterDirection.Input);
                p.Add("D_UG", dbType: DbType.String, value: grid_data[i].D_UG.ToString("dd/MM/yyyy"), direction: ParameterDirection.Input);
                p.Add("nAcc", dbType: DbType.Decimal, value: grid_data[i].ACC, direction: ParameterDirection.Input);
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    connection.Execute(sql_query, p);
                }
            }
        }

        List<string> GetFileLines(string path)
        {
            byte[] bytes = File.ReadAllBytes(path);
            List<List<byte>> bb = new List<List<byte>>();
            int i = 0;
            for (int j = 0; j < bytes.Length; j++)
            {
                byte b = bytes[j];

                if (bb.Count == i)
                    bb.Add(new List<byte>());

                bool theEnd = false;
                if (b == 13)    // CR
                {
                    if (j + 1 < bytes.Length - 1 && bytes[j + 1] == 10)     // LF
                    {
                        i++;
                        j++;
                        theEnd = true;
                    }
                }
                if (!theEnd)
                    bb[i].Add(b);
            }

            List<string> str = new List<string>();
            foreach (List<byte> lb in bb)
            {
                str.Add(Encoding.GetEncoding("windows-1251").GetString(lb.ToArray()));
            }

            return str;
        }

        /// <summary>
        /// Повертає об'єкт заголовку файла
        /// </summary>
        /// <param name="path"></param>
        /// <returns></returns>
        public HeaderData GetHeaderFromFile(string path)
        {
            HeaderData hd = new HeaderData();
            string line = GetFileLines(path)[HEADER_ROW_INDEX];

            try
            {
                hd.FN = line.Substring(0, 12).Replace(" ", "").ToUpper();
                if (hd.FN.ToUpper() != Path.GetFileName(path).ToUpper())
                    throw new Exception();
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовку файлу: Ім'я файлу (символи 1-12)");
            }

            try
            {
                hd.DATF = new DateTime(2000 + Convert.ToInt32(line.Substring(12, 2)),
                                       Convert.ToInt32(line.Substring(14, 2)),
                                       Convert.ToInt32(line.Substring(16, 2)),
                                       Convert.ToInt32(line.Substring(18, 2)),
                                       Convert.ToInt32(line.Substring(20, 2)),
                                       0);
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовку файлу: Дата файлу (символи 13-22)");
            }

            try
            {
                hd.INFO_LENGTH = Convert.ToInt32(line.Substring(22, 6));
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовку файлу: Кількість рядків (символи 23-28)");
            }

            try
            {
                hd.NUMO = Convert.ToDecimal(line.Substring(28, 16));
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовку файлу: Число о (символи 29-44)");
            }

            try
            {
                hd.S = Convert.ToDecimal(line.Substring(44, 16));
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовку файлу: Сума кредиту за файлом (символи 45-60)");
            }

            try
            {
                hd.ECP = line.Substring(60, 64).Replace(" ", "");
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовку файлу: ЕЦП файла (символи 61-124)");
            }

            try
            {
                hd.ID_ECP = line.Substring(124, 6).Replace(" ", "");
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовку файлу: Ідентифікатор ключа ЕЦП (символи 125-130)");
            }

            try
            {
                hd.Reserve = line.Substring(130, 128).Replace(" ", "");
            }
            catch (Exception ex)
            {
                throw new Exception("Помилка розбору заголовку файлу: Резерв (символи 131-258)");
            }
            return hd;
        }

        /// <summary>
        /// Повертає інформаційні рядки файла
        /// </summary>
        /// <param name="path"></param>
        /// <returns></returns>
        public List<PFileGridData> GetListGridDataFromFile(string path, int length)
        {
            List<PFileGridData> list = new List<PFileGridData>();
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd\\MM\\yy";
            cinfo.DateTimeFormat.DateSeparator = "\\";

            List<string> lines = GetFileLines(path);

            for (int i = DATA_ROW_INDEX; i < length + DATA_ROW_INDEX; i++)
            {
                PFileGridData grid_row = new PFileGridData();
                try
                {
                    grid_row.MFOA = lines[i].Substring(0, 9).Replace(" ", ""); ;
                }
                catch (Exception ex)
                {
                    throw new Exception("Помилка розбору файлу: МФО А (символи 1-9)");
                }

                try
                {
                    grid_row.MDOA = lines[i].Substring(9, 9).Replace(" ", "");
                }
                catch (Exception ex)
                {
                    throw new Exception("Помилка розбору файлу: МДО А (символи 10-18)");
                }

                try
                {
                    grid_row.MFOB = lines[i].Substring(18, 9).Replace(" ", "");
                }
                catch (Exception ex)
                {
                    throw new Exception("Помилка розбору файлу: МФО Б (символи 19-27)");
                }

                try
                {
                    grid_row.MDOB = lines[i].Substring(27, 9).Replace(" ", "");
                }
                catch (Exception ex)
                {
                    throw new Exception("Помилка розбору файлу: МДО Б (символи 28-36)");
                }

                try
                {
                    grid_row.NLSB = lines[i].Substring(36, 14).Replace(" ", "");
                }
                catch (Exception ex)
                {
                    throw new Exception("Помилка розбору файлу: Рахунок Б (символи 37-50)");
                }

                try
                {
                    grid_row.OKPOB = lines[i].Substring(50, 14).Replace(" ", "");
                }
                catch (Exception ex)
                {
                    throw new Exception("Помилка розбору файлу: ОКПО Б (символи 51-64)");
                }

                try
                {
                    grid_row.S = Convert.ToDecimal(lines[i].Substring(64, 16));
                }
                catch (Exception ex)
                {
                    throw new Exception("Помилка розбору файлу: Сума (символи 65-80)");
                }

                try
                {
                    grid_row.ID_UG = lines[i].Substring(80, 8);
                }
                catch (Exception ex)
                {
                    throw new Exception("Помилка розбору файлу: Номер оплати (символи 81-88)");
                }

                try
                {
                    grid_row.DAT_UG = new DateTime(Convert.ToInt32(lines[i].Substring(88, 4)),
                       Convert.ToInt32(lines[i].Substring(92, 2)),
                       Convert.ToInt32(lines[i].Substring(94, 2)));
                }
                catch (Exception ex)
                {
                    throw new Exception("Помилка розбору файлу: Дата розр. (символи 89-92, 92-94, 94-96)");
                }

                try
                {
                    grid_row.OZN_SP = lines[i].Substring(96, 16);
                }
                catch (Exception ex)
                {
                    throw new Exception("Помилка розбору файлу: OZN_SP (символи 97-112)");
                }

                try
                {
                    grid_row.OKPOA = lines[i].Substring(112, 14).Replace(" ", "");
                }
                catch (Exception ex)
                {
                    throw new Exception("Помилка розбору файлу: ОКПО А (символи 113-126)");
                }

                try
                {
                    grid_row.N_UG = lines[i].Substring(126, 15).Replace(" ", "") + lines[i].Substring(169, 15).Replace(" ", "");
                }
                catch (Exception ex)
                {
                    throw new Exception("Помилка розбору файлу: Номер угоди (символи 127-141, 170-184)");
                }

                try
                {
                    grid_row.D_UG = new DateTime(Convert.ToInt32(lines[i].Substring(141, 4)),
                                                   Convert.ToInt32(lines[i].Substring(145, 2)),
                                                   Convert.ToInt32(lines[i].Substring(147, 2)));
                }
                catch (Exception ex)
                {
                    throw new Exception("Помилка розбору файлу: Дата угоди (символи 142-145, 146-147, 148-149)");
                }

                try
                {
                    grid_row.RESERV = lines[i].Substring(149, 91).Replace(" ", "");
                }
                catch (Exception ex)
                {
                    throw new Exception("Помилка розбору файлу: Резерв (символи 150-240)");
                }

                try
                {
                    grid_row.ACC = null;
                }
                catch (Exception ex)
                {
                    throw new Exception("Помилка розбору файлу: Рахунок");
                }
                grid_row.NAZN = "Поставка проти оплати за ДЦП. Угода " + grid_row.N_UG + " Дата" + grid_row.DAT_UG;
                var defacc = GetsDefAcc();
                if (defacc != null && grid_row.OKPOA != "")
                {
                    grid_row.ACC = GetAcc(defacc, grid_row.OKPOA);
                }
                list.Add(grid_row);
            }
            return list;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public string GetsDefAcc()
        {
            string sql_query = @"select val from dcp_params where par = 'DEF_ACC'";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<string>(sql_query).SingleOrDefault();
            }
        }

        /// <summary>
        /// Повертає дефолтний аккаунт
        /// </summary>
        /// <param name="defacc"></param>
        /// <param name="OKPOA"></param>
        /// <returns></returns>
        public decimal GetAcc(string defacc, string OKPOA)
        {
            string sql_query = @"select acc
                                 from accounts a, customer c
                                 where a.rnk = c.rnk
                                   and c.okpo = '" + OKPOA + "'" + 
                                   @" and a.nls like '" + defacc + @"' and a.kv = 980 and a.dazs is null
                                   and rownum = 1";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<decimal>(sql_query).SingleOrDefault();
            }
        }

        /// <summary>
        /// Повертає загальну інформацію сесії
        /// </summary>
        /// <returns></returns>
        public GeneralInfo GeneralInfo()
        {
            string err = null;
            var result = new GeneralInfo();
            try
            {
                using (OracleConnection conn = Bars.Classes.OraConnector.Handler.UserConnection)
                {
                    string sqlText = @"select GetGlobalOption('BASEVAL') from dual";
                    using (OracleCommand cmd = new OracleCommand(sqlText, conn))
                    {
                        using (var reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                result.KV = Convert.ToDecimal(reader["GetGlobalOption('BASEVAL')"].ToString());
                            }
                        }
                    }

                    sqlText = @"select GetGlobalOption('NAME') from dual";
                    using (OracleCommand cmd = new OracleCommand(sqlText, conn))
                    {
                        using (var reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                result.GO_NAME = reader["GETGLOBALOPTION('NAME')"].ToString();
                            }
                        }
                    }

                    sqlText = @"select VAL from bars.params$base t where  t.par = 'BANKDATE' and KF=(select f_ourmfo from dual)";
                    using (OracleCommand cmd = new OracleCommand(sqlText, conn))
                    {
                        using (var reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                result.B_DATE = reader["VAL"].ToString();
                            }
                        }
                    }

                }
            }
            catch (Exception ex)
            {
                err = string.Format(" Невідома помилка читання даних з БД:  {0}", (ex.InnerException != null ? ex.InnerException.Message : ex.Message));
                throw new Exception(err + ex.StackTrace);
            }
            return result;
        }

        /// <summary>
        /// Перевіряє чи був прийнятий файл
        /// </summary>
        public object CheckFile()
        {
            HeaderData header_data = new HeaderData();
            string[] filePaths = Directory.GetFiles(GetPath(), "&P1ILP*.*");
            if (filePaths.Length > 0)
            {
                header_data = GetHeaderFromFile(filePaths[0]);
                string sql_query = @"SELECT fn
                                     FROM dcp_zag 
                                     WHERE upper(fn) = upper('" + header_data.FN + "')" +
                                        "and dat = to_date('" + header_data.DATF.ToString(@"dd\/MM\/yyyy HH:mm:ss") + "', 'dd/mm/yyyy hh24:MI:ss')";
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    string filename = connection.Query<string>(sql_query).SingleOrDefault();
                    if (filename != null)
                        return new { update = true, fn = header_data.FN };
                    else
                        return new { update = false, fn = header_data.FN };
                }
            }
            else throw new Exception("Немає файлів &P1ILP*.* у " + GetPath());
        }

        /// <summary>
        /// Записує файл до dcp_zag
        /// </summary>
        /// <param name="fn"></param>
        /// <param name="dat"></param>
        public void WriteToDcpZag(string fn, string dat)
        {
            string sql_query = @"INSERT INTO dcp_zag(fn, dat) VALUES(upper('" + fn + "'), to_date('" + dat + "', 'dd/mm/yyyy hh24:MI:ss'))";

            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Query<string>(sql_query).SingleOrDefault();
            }
        }

        /// <summary>
        /// Видаляє файл з бази
        /// </summary>
        /// <param name="fn"></param>
        /// <param name="dat"></param>
        public void DeleteFromDCP(string fn, DateTime dat)
        {
            string sql_query = "DELETE FROM dcp_p WHERE fn=upper('" + fn + "') and dat = to_date('" + dat.ToString(@"dd\/MM\/yyyy HH:mm:ss") + "', 'dd/mm/yyyy hh24:MI:ss')";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute(sql_query);
            }

            sql_query = "DELETE FROM dcp_zag WHERE fn=upper('" + fn + "') and dat = to_date('" + dat.ToString(@"dd\/MM\/yyyy HH:mm:ss") + "', 'dd/mm/yyyy hh24:MI:ss')";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute(sql_query);
            }
        }

        /// <summary>
        /// Оплачує файл
        /// </summary>
        /// <param name="data"></param>
        public void Pay(List<PFileGridData> data)
        {
            string error_string = "";
            string id = null;
            using (OracleConnection conn2 = Bars.Classes.OraConnector.Handler.UserConnection)
            {
                var trans = conn2.BeginTransaction();
                string sqlText = @"select tabn from staff where id=(select user_id from dual)";
                using (OracleCommand cmd = new OracleCommand(sqlText, conn2))
                {
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            id = reader["TABN"].ToString();
                        }
                    }
                }
                GeneralInfo gen_info = GeneralInfo();

                if (gen_info.B_DATE == null)
                    throw new Exception("Банківська дата пуста.");

            System.Threading.Thread.CurrentThread.CurrentCulture = new CultureInfo("en-CA");
                var bank_date = DateTime.ParseExact(gen_info.B_DATE, "MM/dd/yyyy", CultureInfo.InvariantCulture);

            String d_rec = null;
            for (int i = 0; i < data.Count; i++)
            {
                d_rec = "";
                try
                {
                    string TT = "";
                    decimal? Prty = null;

                    if (data[i].MFOA == data[i].MFOB)
                    {
                        TT = "ЦП1";
                        Prty = 0;
                    }
                    else
                    {
                        TT = "ЦП2";
                        Prty = 3;
                    }

                    d_rec = String.Format("#d{0}{1}{2}{3}{4}#", 
                                            data[i].MDOA.PadLeft(9, ' '), 
                                            data[i].MDOB.PadLeft(9, ' '), 
                                            data[i].ID_UG, 
                                            data[i].DAT_UG.ToString("yyyyMMdd"), 
                                            data[i].OZN_SP);

                    if (data[i].REF == null && data[i].ACC != null)
                    {

                        cDoc cdoc = new cDoc(
                                conn2,
                            0,                                      // референс (NUMBER_Null для новых)
                            TT,                                     // Код операции
                            Convert.ToByte(1),                      // ДК (0-дебет, 1-кредит)
                            Convert.ToInt16(data[i].VOB),           // Вид обработки
                                data[i].ND == null ? "" : data[i].ND,                             // № док
                            bank_date,                              // Дата док
                            bank_date,                              // Дата ввода(поступления в банк)
                            bank_date,                              // Дата валютирования основной операции
                            bank_date,                              // Дата валютирования связаной операции
                            data[i].NLSA,                           // Счет-А
                            data[i].NAMA,                           // Наим-А
                            data[i].MFOA,                           // МФО-А
                            "",                                     // Наим банка-А(м.б. '')
                            Convert.ToInt16(GeneralInfo().KV),      // Код вал-А
                                Convert.ToDecimal(data[i].S) * 100,       // Сумма-А
                            data[i].OKPOA,                          // ОКПО-А
                            data[i].NLSB,                           // Счет-Б
                            data[i].NAMB,                           // Наим-Б
                            data[i].MFOB,                           // МФО-Б
                            "",                                     // Наим банка-Б(м.б. '')
                            Convert.ToInt16(GeneralInfo().KV),      // Код вал-Б
                                Convert.ToDecimal(data[i].S) * 100,       // Сумма-Б
                            data[i].OKPOB,                          // ОКПО-Б
                            data[i].NAZN,                           // Назначение пл
                            d_rec,                                  // Доп реквизиты
                            id,                                     // Идентификатор ключа опрециониста
                            null,                                   // ЭЦП опрециониста
                            0,                                      // СКП
                            0,                                      // Приоритет документа
                            0,                                      // Эквивалент для одновалютной оп
                            string.Empty,                           // Внешняя ЭЦП в 16-ричном формате (оно же закодированное поле byte[] Sign)
                            string.Empty,                           // Внутренняя ЭЦП в 16-ричном формате
                            string.Empty,                           // процедура після оплати
                            string.Empty                            // процедура перед оплатою
                        );
                        if (cdoc.oDocument())
                        {
                            decimal gen_ref = cdoc.Ref;
                            string sql_query = "UPDATE dcp_p set ref=" + gen_ref + " WHERE ID =" + data[i].ID;
                            using (var connection = OraConnector.Handler.UserConnection)
                            {
                                connection.Execute(sql_query);
                            }
                        }
                    }
                    else
                    {
                        throw new Exception("Референс не пустий або відсутній 'ACC'");
                    }
                }
                catch (Exception ex)
                {
                    error_string = string.Format("Помилка оплати документа №{0}</br>{1}", (i + 1), (ex.InnerException != null ? ex.InnerException.Message : ex.Message));
                    trans.Rollback();
                    throw new Exception(error_string);
                }
            }
            trans.Commit();
            }
        }

        /// <summary>
        /// Видаляє стрічку з бази
        /// </summary>
        /// <param name="id"></param>
        public void DeleteRow(decimal? id)
        {
            string sql_query = "DELETE from dcp_p WHERE ref is null AND id = " + id;
            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute(sql_query);
            }
        }

        /// <summary>
        /// Повертає дані по рахунку
        /// </summary>
        /// <param name="nls"></param>
        /// <param name="id"></param>
        /// <param name="okpo"></param>
        /// <returns></returns>
        public NlsModel GetDataByNLS(string nls, decimal id, string okpo)
        {
            NlsModel model = new NlsModel();
            string sql_query = @"SELECT substr(a.nms,1,38) as NAM, a.acc as ACC, c.okpo as OKPO
                                 FROM accounts a, cust_acc b, customer c 
                                 WHERE a.kv=980 AND a.nls='" + nls + @"' AND a.dazs is null AND 
                                       a.acc=b.acc AND b.rnk=c.rnk";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                model = connection.Query<NlsModel>(sql_query).SingleOrDefault();
            }

            if (model == null)
            {
                nls = "";
            }
            if (nls == "")
            {
                model = new NlsModel();
                model.ACC = null;
                model.NAM = "";
                model.OKPO = okpo;
            }
            sql_query = "UPDATE dcp_p set acc=" + ((model.ACC == null) ? "null" : model.ACC.ToString()) + ", okpoa='" + model.OKPO + @"' 
                          WHERE ID=" + id;
            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute(sql_query);
            }
            return model;
        }

        /// <summary>
        /// Повертає причини для ВАСК-операцій
        /// </summary>
        /// <returns></returns>
        public List<BP_REASON> GetBPReasons()
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<BP_REASON>("select * from bp_reason order by id").ToList();
            }
        }

        /// <summary>
        /// Виконує BACK-операції по файлу
        /// </summary>
        public object Storno(int reasonid, string fn)
        {
            List<string> list = new List<string>();
            string status = "ok";
            string message = "";
            HeaderData header_data = GetHeaderFromFile(GetPath() + "/&" + fn);
            string sql_query = @"SELECT p.ref INTO: nRef FROM dcp_p d, oper p
                                 WHERE upper(d.fn) = upper('" + header_data.FN + @"')
                                        and dat = to_date('" + header_data.DATF.ToString(@"dd\/MM\/yyyy HH:mm:ss") + @"', 'dd/mm/yyyy hh24:MI:ss')
                                        AND d.ref= p.ref AND p.sos < 5 AND p.sos > 0";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                list = connection.Query<string>(sql_query).ToList();
            }
            for (int i = 0; i < list.Count; i++)
            {
                OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
                OracleCommand cmd = con.CreateCommand();
                try
                {
                    cmd.CommandText = "begin p_back_web(:p_ref,:p_reason,:res_code,:res_text);end;";
                    cmd.Parameters.Add("p_ref", OracleDbType.Decimal, list[i], ParameterDirection.Input);
                    cmd.Parameters.Add("p_reason", OracleDbType.Decimal, reasonid, ParameterDirection.Input);
                    cmd.Parameters.Add("res_code", OracleDbType.Decimal, 0, ParameterDirection.Output);
                    cmd.Parameters.Add("res_text", OracleDbType.Varchar2, 200, null, ParameterDirection.Output);
                    if (con.State != ConnectionState.Open) con.Open();
                    cmd.ExecuteNonQuery();

                    if (Convert.ToDecimal(((OracleDecimal)cmd.Parameters["res_code"].Value).Value) != 0)
                    {
                        status = "error";
                    }

                    message = Convert.ToString(cmd.Parameters["res_text"].Value);
                }
                catch (Exception e)
                {
                    status = "error";
                    message = e.InnerException == null ? e.Message : e.InnerException.Message;
                }
                finally
                {
                    con.Close();
                    cmd.Dispose();
                    con.Dispose();
                }
            }
            if (status == "ok")
            {
                DeleteFromDCP(header_data.FN, header_data.DATF);
            }
            return new { STATUS = status, MESSAGE = message };
        }
    }
}