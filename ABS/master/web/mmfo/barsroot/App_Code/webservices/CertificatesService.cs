using System;
using System.Web.Services;
using System.Threading.Tasks;
using System.Runtime.InteropServices;
using System.Text;
using System.Collections.Generic;
using System.Web.Script.Services;
using Oracle.DataAccess.Client;
using System.IO;

namespace Bars.Certificates
{
    /// <summary>
    /// Тимчасовий клас для аудиту роботи веб-сервісу прийняття сертифікатів VEGA та ключів НБУ
    /// </summary>
    public static class TraceHelper
    {
        public static void Trace(OracleConnection _connection, string _procedureName, string _message)
        {
            using (OracleCommand command = new OracleCommand("bars.bars_audit.log_error", _connection))
            {
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.BindByName = true;
                command.Parameters.Add("p_procedure_name", _procedureName);
                command.Parameters.Add("p_log_message", _message);

                command.ExecuteNonQuery();
            }
        }

        public static void Trace(string _procedureName, string _message)
        {
            using (OracleConnection connection = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                Trace(connection, _procedureName, _message);
            }
        }
    }

    [ScriptService]
    public class CertificatesService: BarsWebService
    {
        /// <summary>
        /// Сервис для работы с библиотекой vega32.dll
        /// Для работы с этой библиотекой используется другая библиотека - TokVega.dll (wrapper)
        /// т.к. не удалось "поднять" vega32.dll под .NET 4.0
        /// Исходники TokVega.dll тут: http://svn.unity-bars.com.ua:8080/svn/bars/Releases/Customers/State Savings Bank of Ukraine/Projects/COBUSUP/Private/COBUMMFO-3249_TokVega
        /// </summary>
        /// <returns>VegaResult</returns>
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Xml)]
        [WebMethod(Description = "Обновление ТОК ВЕГА на старте дня", EnableSession = true)]
        public VegaResult ProcessVega()
        {
            Task<VegaResult> t = new Task<VegaResult>(() => VegaProc());
            t.Start();

            try
            {
                t.Wait();
            }
            catch (System.Exception e)
            {
                string message = e.InnerException != null ? e.InnerException.Message : e.Message;
                return new VegaResult() { Message = message };
            }

            return t.Result;
        }

        VegaResult VegaProc()
        {
            VegaClass vp = new VegaClass();
            return vp.Fire();
        }

        [StructLayout(LayoutKind.Sequential)]
        public struct ProcessResults
        {
            public int Result;
            public int VegaResult;
        }

        public class VegaClass
        {
            const int VEGA_MSG_BUF_LEN = 1024;

            #region Imported functions
            // vegamsg.dll
            [DllImport("vegamsg.dll")]
            public static extern void VegaGetMsgAux(int nCode, StringBuilder szMsgBuf, int nBufLen);

            // TokVega.dll
            //ProcessResults __stdcall ProcessCertificates(char* path, int* resultCodes, char**resultfiles, int length)
            [DllImport("TokVega.dll", CallingConvention = CallingConvention.StdCall, CharSet = CharSet.Ansi)]
            public static extern ProcessResults ProcessCertificates(
                [MarshalAs(UnmanagedType.LPStr)] StringBuilder path,
                int[] resultCodes,
                IntPtr[] resultfiles,
                int length
                );

            //int __stdcall GetCrtCount(char* path)
            [DllImport("TokVega.dll", CallingConvention = CallingConvention.StdCall, CharSet = CharSet.Ansi)]
            public static extern int GetCrtCount([MarshalAs(UnmanagedType.LPStr)] StringBuilder path);
            #endregion

            public VegaResult Fire()
            {
                VegaResult vr = new VegaResult();
                vr.Message = "OK";

                string strPath = System.Configuration.ConfigurationManager.AppSettings["vegaTok.CertificatesFolder"];
                DirectoryInfo di = new DirectoryInfo(strPath);
                if (!di.Exists)
                {
                    vr.Message = string.Format("Тека відсутня або немає доступу: {0}", strPath);
                    return vr;
                }
                StringBuilder path = new StringBuilder(strPath);
                int crtCount = GetCrtCount(path);
                if (crtCount == 0)
                {
                    vr.Message = VegaResultDescription.GetText(-2);
                    return vr;
                }                

                int[] resultCodes = new int[crtCount];
                for (int i = 0; i < crtCount; i++)
                {
                    resultCodes[i] = -1;        // set error state
                }
                string[] resultfiles = new string[crtCount];
                IntPtr[] pResultfiles = new IntPtr[crtCount];

                ProcessResults resPtr = ProcessCertificates(path, resultCodes, pResultfiles, crtCount);
                if (resPtr.Result != 0) // TokVega error
                {
                    vr.Message = VegaResultDescription.GetText(resPtr.Result);
                    return vr;
                }
                else if (resPtr.VegaResult != 0)    // Vega32 error
                {
                    StringBuilder errDesc = new StringBuilder(VEGA_MSG_BUF_LEN);
                    VegaGetMsgAux(resPtr.VegaResult, errDesc, VEGA_MSG_BUF_LEN);
                    vr.Message = errDesc.ToString();
                    return vr;
                }

                for (int i = 0; i < crtCount; i++)
                {
                    resultfiles[i] = Marshal.PtrToStringAnsi(pResultfiles[i]);

                    int fRes = resultCodes[i];
                    string ResultMessage = "OK";
                    if (fRes != 0)
                    {
                        StringBuilder fResErrDesc = new StringBuilder(VEGA_MSG_BUF_LEN);
                        VegaGetMsgAux(fRes, fResErrDesc, VEGA_MSG_BUF_LEN);
                        ResultMessage = fResErrDesc.ToString();
                    }
                    else
                    {
                        try
                        {
                            FileInfo crtFi = new FileInfo(Path.Combine(strPath, resultfiles[i]));
                            crtFi.Delete(); // delete .crt file
                        }
                        catch (IOException e) { }
                    }
                    vr.FilesResult.Add(new VegaFileResult() {
                        FileName = resultfiles[i],
                        Message = ResultMessage
                    });
                }
                return vr;
            }
        }

        public class VegaFileResult
        {
            public string FileName { get; set; }
            public string Message { get; set; }
        }

        public class VegaResult
        {
            public string Message { get; set; }
            public List<VegaFileResult> FilesResult = new List<VegaFileResult>();
        }

        static class VegaResultDescription
        {
            static Dictionary<int, string> desc = new Dictionary<int, string>()
                {
                    { -1, "Не вдалось створити теку" },
                    { -2, "Файли сертифікатів відсутні (*.crt)" },
                    { -3, "Не вдалось завантажити vega32.dll" },
                    { -4, "Не вдалось зчитати функцію VegaSetBuf" },
                    { -5, "Не вдалось зчитати функцію VegaCheckDB" },
                    { -6, "Не вдалось зчитати функцію VegaOpen" },
                    { -7, "Не вдалось зчитати функцію VegaMail" },
                    { -8, "Не вдалось зчитати функцію VegaClose" },
                };

            public static string GetText(int id)
            {
                return desc.ContainsKey(id) ? desc[id] : null;
            }
        }


        /// <summary>
        /// Сервис для работы с библиотекой RSAC.DLL 
        /// На вход получаем папку с ключами ( barsroot\appSettings.config; key = "nbuTok.CertificatesFolder" )
        /// На выходе файлы: protocol.rsa и report.pub
        /// В теле возвращается xml объект RscaResult. Если Status = 0 - все ОК, иначе - ошибка
        /// Строка вызова: ХОСТ/barsroot/webservices/CertificatesService.asmx/ProcessRsca
        /// </summary>
        /// <param name="sDate" format: "YYYY/MM/DD HH:mm:ss"
        /// <returns>RscaResult</returns>
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Xml)]
        [WebMethod(Description = "Обновление ТОК НБУ на старте дня", EnableSession = true)]
        public RscaResult ProcessRsca(string sDate)
        {
            TraceHelper.Trace("hello from ProcessRsca", "sDate : " + sDate + " isNull:"+string.IsNullOrEmpty(sDate));
            Task<RscaResult> t = new Task<RscaResult>(() => RscaProc(sDate));
            t.Start();

            try
            {
                t.Wait();
            }
            catch (System.Exception e)
            {
                string message = e.InnerException != null ? e.InnerException.Message : e.Message;
                return new RscaResult() { Status = -1, Message = message };
            }

            return t.Result;
        }

        RscaResult RscaProc(string sDate)
        {
            RscaClass rsca = new RscaClass();
            RscaResult r = rsca.ProcessCertificates(sDate);

            return r;
        }
    }  

    public class RscaClass
    {
        #region Imported functions

        // RSAC.dll
        [DllImport("RSAC.DLL", CallingConvention = CallingConvention.StdCall)]
        public static extern int RENEW_ZAH(
            char szOpenKey,
            [MarshalAs(UnmanagedType.LPStr)] StringBuilder szSecretKeyDrv,
            [MarshalAs(UnmanagedType.LPStr)] StringBuilder szIdOper,
            [MarshalAs(UnmanagedType.LPStr)] StringBuilder szBankDate
        );
        #endregion

        public RscaResult ProcessCertificates(string sDate)
        {
            RscaResult r = new RscaResult() { Message = "" };

            //DateTime dt = DateTime.Now;
            //string szCurDate = dt.ToString("yyyy'/'MM'/'dd HH:mm:ss");
            string szPubKeyDir = System.Configuration.ConfigurationManager.AppSettings["nbuTok.CertificatesFolder"];
            if (!System.IO.Directory.Exists(szPubKeyDir))
            {
                r.Status = -404;
                r.Message = string.Format("Тека відсутня або немає доступу: {0}", szPubKeyDir);
                return r;
            }

            string szCurDate = !string.IsNullOrEmpty(sDate) ? sDate : GetDate();
            StringBuilder szPubKeyDir_SB = new StringBuilder(szPubKeyDir);
            StringBuilder szCurDate_SB = new StringBuilder(szCurDate);

            // Обработка сертификатов
            r.Status = RENEW_ZAH('r', szPubKeyDir_SB, null, szCurDate_SB);
            if (r.Status != 0)
            {
                r.Message = RscaResultDescription.GetText(r.Status);
            }
            if (r.Status >= -90 && r.Status <= -70)
            {
                if (string.IsNullOrEmpty(r.Message))
                {
                    r.Message = "WARNING: Попередження при виконанні RENEW_ZAH";
                }
            }
            else if (r.Status != 0)
            {
                if (string.IsNullOrEmpty(r.Message))
                {
                    r.Message = "ERROR: Помилка виконання RENEW_ZAH";
                }
            }
            return r;
        }

        /// <summary>
        /// Получить банковскую дату
        /// </summary>
        /// <returns>string</returns>
        string GetDate()
        {
            string bDate = string.Empty;

            OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            TraceHelper.Trace(con, "CertificatesService.GetDate()", "");
            try
            {
                using (OracleCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = "select to_char(BARS.bankdate(), 'yyyy/mm/dd hh24:mi:ss') as BDATE from dual";
                    using (OracleDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            bDate = reader["BDATE"].ToString();
                        }
                    }
                }
            }
            catch (System.Exception e)
            {
                throw e;
            }
            finally
            {
                con.Close();
                con.Dispose();
            }

            return bDate;
        }
    }

    public class RscaResult
    {
        public int Status { get; set; }
        public string Message { get; set; }
    }

    /// <summary>
    /// Описания выдает библиотека RSAC.DLL
    /// </summary>
    static class RscaResultDescription
    {
        static Dictionary<int, string> desc = new Dictionary<int, string>()
                {
                    { -1, "Подпись неверна" },
                    { -2, "Недостаточно памяти" },
                    { -3, "Неверно указан дисковод с дискетой с секретным ключом" },
                    { -4, "Ошибка работы с файлом секретного ключа" },
                    { -5, "Неверно указан путь к таблицам открытых ключей" },
                    { -6, "Ошибка работы с индексным файлом pub_odb.ind" },
                    { -7, "Индексный файл pub_odb.ind испорчен" },
                    { -8, "Ошибка работы с файлом открытых ключей pub_odb.key" },
                    { -9, "Файл открытых ключей pub_odb.key испорчен" },
                    { -10, "Не найден идентификатор открытого ключа" },
                    { -11, "Испорчена строка в таблице открытых ключей" },
                    { -12, "Срок действия ключа истек" },
                    { -13, "Секретный ключ испорчен" },
                    { -14, "Файл секретного ключа переименован" },
                    { -15, "Несовпадение номера сеанса генерации ключа" },
                    { -16, "Несоответствие открытого и секретного ключа" },
                    { -17, "Ошибка чтения входного файла" },
                    { -18, "Подпись сделана старым ключом" },
                    { -20, "Прерывание пользователя (при работе с Touch Memory)" },
                    { -21, "Ошибка чтения при работе с Touch Memory" },
                    { -22, "Неверный пароль для секретного ключа" },
                    { -23, "Ошибка открытия файла протокола" },
                    { -24, "Ошибка чтения файла протокола" },
                    { -25, "Файл протокола модифицирован" },
                    { -47, "Несоответствие файла pub_odb.key и pub_odb.ind" },
                    { -70, "Последний день действия ключа" },
                    { -71, "До истечения срока действия ключа остался 1 день" },
                    { -72, "До истечения срока действия ключа осталось 2 дня" },
                    { -73, "До истечения срока действия ключа осталось 3 дня" },
                    { -74, "До истечения срока действия ключа осталось 4 дня" },
                    { -75, "До истечения срока действия ключа осталось 5 дня" },
                    { -76, "До истечения срока действия ключа осталось 6 дня" },
                    { -78, "Подпись сделана старым ключом" },
                    { -91, "Неверные параметры вызова функции" },
                    { -92, "Неверно указан тип параметров вызова функции (только для АРМ-2)" }
                };

        public static string GetText(int id)
        {
            return desc.ContainsKey(id) ? desc[id] : null;
        }
    }
}

