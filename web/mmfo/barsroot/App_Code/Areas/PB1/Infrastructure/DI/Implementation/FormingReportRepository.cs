using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using BarsWeb.Areas.PB1.Models;
using BarsWeb.Areas.PB1.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;
using Newtonsoft.Json;
using Oracle.DataAccess.Client;
using Bars.Classes;
using Dapper;
using System.Data;
using System.IO;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.PB1.Infrastructure.Repository.DI.Implementation
{
    public class FormingReportRepository : IFormingReportRepository
    {
        public FormingReportRepository()
        {
        }

        public List<DropDown> GetDropDownData()
        {
            List<DropDown> list = new List<DropDown>();
            string sql_query = @" SELECT distinct  to_char(d.fdat,'YYYY-MM')||' '||m.NAME_PLAIN as TEXT, to_number(to_char(d.fdat,'YYYYMM')) as VALUE
                                 FROM fdat d, meta_month m 
                                 WHERE to_char(d.fdat,'MM')+0=m.n and d.fdat <= bankdate
                                 ORDER  by 1 desc ";

            using (var connection = OraConnector.Handler.UserConnection)
            {
                list = connection.Query<DropDown>(sql_query).ToList();
            }
            return list;
        }

        public object GetParams()
        {
            List<DropDown> list = new List<DropDown>();
            string sql_query = @"SELECT p.val as KOD_B, GetGlobalOption('BANKTYPE') as BANKTYPE from params p, dual where par='1_PB'";

            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<object>(sql_query).SingleOrDefault();
            }
        }

        public List<GridData> GetGridData(string D, string KOD_B, bool data_do)
        {
            List<GridData> list = new List<GridData>();

            string sql_query = "";
            string temp = "";
            var p = new DynamicParameters();

            if (data_do)
            {
                sql_query = @"SELECT status 
                               FROM all_objects 
                               WHERE owner='BARS' AND object_name='FPB1'";

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    temp = connection.Query<string>(sql_query).SingleOrDefault();
                }

                sql_query = @"begin
                                FPB1(:sKOD_B, :sD);
                              end;";

                p.Add("sKOD_B", dbType: DbType.String, size: 100, value: KOD_B, direction: ParameterDirection.Input);
                p.Add("sD", dbType: DbType.String, size: 100, value: D, direction: ParameterDirection.Input);

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    connection.Execute(sql_query, p);
                }
            }

            sql_query = @"SELECT srt as KOST, refc as REFE, tt as TT, LN, 
                                       DEN, MEC, GOD, BAKOD, COUNKOD, PARTN, VALKOD, 
                                       NLS, KRE, DEB, COUN, KOD, OPER, BANK, KOR  

                                FROM (
                                SELECT   DECODE (SUBSTR (kod, 1, 1), '9', '0', '1') srt, refc, tt, LN, den,
                                                 mec, god, bakod, counkod, partn, valkod, nls, kre, deb, coun,
                                                 kod, oper, bank, kor
                                            FROM pb_1
                                           WHERE (SUBSTR (kod, 1, 1) <> '9' ) AND
                                                 (kre <> 0 OR deb <> 0)
                                UNION ALL 
                                SELECT   DECODE (SUBSTR (kod, 1, 1), '9', '0', '1') srt, refc, tt, LN, den,
                                                 mec, god, bakod, counkod, partn, valkod, nls, kre, deb, coun,
                                                 kod, oper, bank, kor
                                            FROM pb_1
                                           WHERE (SUBSTR (kod, 1, 1) ='9' AND partn<>'ГОТІВКА') 
                                UNION ALL 
                                SELECT   DECODE (SUBSTR (kod, 1, 1), '9', '0'||substr(kod,2), '1') srt,
                                                 TO_NUMBER (NULL) refc, '' tt, '' ln, TO_NUMBER (NULL) den, mec, god,
                                                 bakod, counkod, partn, valkod, SUBSTR(nls,1,3), SUM (kre) kre, SUM (deb) deb,
                                                 coun, kod, oper, bank, kor
                                            FROM pb_1
                                           WHERE SUBSTR (kod, 1, 1) = '9' AND partn='ГОТІВКА'
                                        GROUP BY mec,
                                                 god,
                                                 bakod,
                                                 counkod,
                                                 partn,
                                                 valkod,
                                                 coun,
                                                 kod,
                                                 oper,
                                                 bank,
                                                 kor, 
                                                 SUBSTR(nls,1,3))
                                WHERE god = " + D.Substring(2, 2) + " AND mec = " + D.Substring(4, 2)
                                + " ORDER BY VALKOD, PARTN, NLS, srt, god, mec, den, kod";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                list = connection.Query<GridData>(sql_query).ToList();
            }
            return list;
        }

        public Object CreateFileForPrint()
        {
            string file_type = "";
            string templateName = "PB1Report.frx";

            string templatePath = FrxDoc.GetTemplatePathByFileName(templateName);
            FrxDoc doc = new FrxDoc(templatePath, null, null);

            using (var str = new MemoryStream())
            {
                doc.ExportToMemoryStream(FrxExportTypes.Text, str);
                file_type = ".txt";
                string TempDir = Path.GetTempPath();
                DirectoryInfo TmpDitInf = new DirectoryInfo(TempDir);
                if (!TmpDitInf.Exists)
                    TmpDitInf.Create();
                string TempPath = TempDir + "PB1Report" + file_type;

                string buffer = Encoding.UTF8.GetString(str.ToArray());
                buffer = buffer.Replace("\f\r", string.Empty);
                var utf8bytes = Encoding.UTF8.GetBytes(buffer);
                var win1252Bytes = Encoding.Convert(Encoding.UTF8, Encoding.GetEncoding("windows-1251"), utf8bytes);
                for (int i = 0; i < win1252Bytes.Length; i++)
                {
                    if (win1252Bytes[i] == 76 && win1252Bytes[i + 1] == 45)//L
                        win1252Bytes[i] = 45;// line
                    if (win1252Bytes[i] == 84 && win1252Bytes[i + 1] == 43)//T+
                    {
                        win1252Bytes[i] = 43;//+
                        win1252Bytes[i + 1] = 45;
                    }
                    if (win1252Bytes[i] == 84 && win1252Bytes[i - 1] == 45)//-T
                        win1252Bytes[i] = 43;//+
                    if (win1252Bytes[i] == 63)//?
                        win1252Bytes[i] = 32;//space  
                }

                File.WriteAllBytes(TempPath, win1252Bytes);
                return new { tempDir = TempDir, name = "PB1Report" + file_type };
            }
        }
    }
}