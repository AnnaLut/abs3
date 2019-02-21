using Areas.SignStatFiles.Models;
using Bars.Classes;
using Bars.Oracle;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.SignStatFiles.Infrastructure.DI.Abstract;
using BarsWeb.Areas.SignStatFiles.Models;
using BarsWeb.Core.Models;
using BarsWeb.Models;
using ICSharpCode.SharpZipLib.Zip;
using MakeAttachedSign;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Objects;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;

namespace BarsWeb.Areas.SignStatFiles.Infrastructure.DI.Implementation
{
    public class SignStatFilesRepository : ISignStatFilesRepository
    {
        readonly SignStatFilesModel _SignStatFiles;
        readonly IKendoSqlTransformer _sqlTransformer;
        readonly IKendoSqlCounter _kendoSqlCounter;
        readonly IParamsRepository _globalData;
        public SignStatFilesRepository(IKendoSqlTransformer sqlTransformer, IKendoSqlCounter kendoSqlCounter, IParamsRepository globalData)
        {
            _SignStatFiles = new SignStatFilesModel(EntitiesConnection.ConnectionString("SignStatFilesModel", "SignStatFiles"));

            _sqlTransformer = sqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
            _globalData = globalData;
        }

        private CultureInfo _ci;
        public CultureInfo Ci
        {
            get
            {
                if (_ci == null)
                {
                    _ci = CultureInfo.CreateSpecificCulture("en-GB");
                    _ci.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
                    _ci.DateTimeFormat.DateSeparator = ".";
                }
                return _ci;
            }
        }

        #region kendo data source
        public KendoDataSource<StatFile> GetAllFiles(DataSourceRequest request)
        {
            BarsSql sql = SqlCreator.GetAllFiles();
            return GetKendoDs<StatFile>(sql, request);
        }
        public KendoDataSource<FileWorkflow> GetFileDetails(long fileId)
        {
            SetFileDetailsId(fileId);
            BarsSql sql = SqlCreator.GetFileHistory();
            return GetKendoDs<FileWorkflow>(sql);
        }

        private KendoDataSource<T> GetKendoDs<T>(BarsSql sql, DataSourceRequest request = null)
        {
            KendoDataSource<T> res = new KendoDataSource<T>
            {
                Data = SearchGlobal<T>(request, sql),
                Total = Convert.ToInt32(CountGlobal(request, sql))
            };

            return res;
        }
        #endregion

        public string GetDecodedFileDate(string fileName)
        {
            //if (fileName.Length < 8) throw new ArgumentException("Не коректне ім'я файлу.");

            //string m = fileName.Substring(6, 1);
            //string d = fileName.Substring(7, 1);

            //return GetFileDate(d, m);

            //ConsNBU_OOO_01122018

            string date = fileName.Split('_')[2];
            return date.Substring(0, 2) + "." + date.Substring(2, 2) + "." + date.Substring(4, 4);
        }

        public IList<string> GetAllowedExtensions()
        {
            List<string> res = new List<string>();
            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "pkg_stat.get_type_list_p";
                OracleParameter retVal = new OracleParameter("res", OracleDbType.Array, System.Data.ParameterDirection.Output);
                retVal.UdtTypeName = "BARS.VARCHAR2_LIST";
                cmd.Parameters.Add(retVal);
                cmd.ExecuteNonQuery();

                if (null != retVal.Value)
                {
                    StringList _retVal = (StringList)retVal.Value;
                    if (!_retVal.IsNull)
                        res = _retVal.Value.ToList();
                }
            }
            return res;
        }

        public void SetFileOperation(FileOperation operation)
        {
            if (operation.IsCAdES)
            {
                if (string.IsNullOrWhiteSpace(operation.Sign))
                    throw new ArgumentNullException("Sign", "Підпис не може бути пустим!");

                byte[] fileData = GetFileDataByStorageId(operation.StorageId);
                byte[] p7sEnvelope = null;

                if (UseIIT())
                {
                    SignMaker sm = new SignMaker();
                    p7sEnvelope = sm.Make(fileData, HexToByteArray(operation.Sign));
                }
                else
                {
                    P7SEnvelopeMaker p7sMaker = new P7SEnvelopeMaker(GetWebCfgParameter(BarsWebConfig.CipherUrl));
                    p7sEnvelope = p7sMaker.Make(HexToByteArray(operation.Sign), fileData);
                }

                string p7sEnvelopeStr = Convert.ToBase64String(p7sEnvelope);
                operation.Sign = p7sEnvelopeStr;
            }

            SetFileOperationInDb(operation);
        }

        private bool UseIIT()
        {
            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "select branch_attribute_utl.get_value('/', 'STATSIGN_PROVIDER') from dual";
                object _res = cmd.ExecuteScalar();
                if (null == _res) return false;
                return _res.ToString().ToUpper() == "IIT";
            }
        }
        private byte[] HexToByteArray(string hex)
        {
            int length = hex.Length;
            byte[] bytes = new byte[length / 2];
            for (int i = 0; i < length; i += 2)
            {
                bytes[i / 2] = Convert.ToByte(hex.Substring(i, 2), 16);
            }
            return bytes;
        }

        private void SetFileOperationInDb(FileOperation operation)
        {
            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "pkg_stat.set_file_operation";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new OracleParameter("p_file_id", OracleDbType.Decimal, operation.FileId, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_oper_id", OracleDbType.Decimal, operation.OperationId, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_sign", OracleDbType.Clob, operation.Sign, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_reverse", OracleDbType.Decimal, operation.Reverse, ParameterDirection.Input));

                cmd.ExecuteNonQuery();
            }
        }

        public string GetFileHash(long storageId)
        {
            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "select pkg_stat.get_file_hash_by_storage(:p_storage_id) from dual";
                cmd.Parameters.Add(new OracleParameter("p_storage_id", OracleDbType.Decimal, storageId, ParameterDirection.Input));

                object _res = cmd.ExecuteScalar();
                if (null == _res) throw new Exception("Пустий хеш файлу з storage_id = " + storageId);

                return Convert.ToString(_res);
            }
        }

        public string GetCurrentUserSubjectSN()
        {
            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "select pkg_stat.get_user_key_id() from dual";
                return Convert.ToString(cmd.ExecuteScalar());
            }
        }

        public List<FileListRow> GetFilesList(List<string> allowedFileTypes)
        {
            List<FileListRow> result = new List<FileListRow>();
            string dirPath = GetWebCfgParameter(BarsWebConfig.DownloadPath);

            IEnumerable<string> files = Directory.GetFiles(dirPath, "*.zip", SearchOption.TopDirectoryOnly).Where(s => IsFileAllowed(allowedFileTypes, s));

            foreach (string file in files)
            {
                string _fname = Path.GetFileName(file);
                result.Add(new FileListRow
                {
                    Name = _fname,
                    Date = GetDecodedFileDate(_fname),
                    FullPath = file
                });
            }

            return result;
        }
        public decimal UploadFileToDb(string filePath)
        {
            if (!File.Exists(filePath)) throw new Exception(string.Format("Файл \"{0}\" не існує, або до нього немає доступу.", filePath));

            List<FileUploadData> decompressedData = Decompress(File.ReadAllBytes(filePath));
            if (decompressedData.Count <= 0) throw new Exception(string.Format("Архів \"{0}\" не містить файлів.", filePath));

            FileUploadData signFile = GetFileByExt(decompressedData, "SGN");
            if (null == signFile) throw new Exception(string.Format("Файл з МАК підписом відсутній або пустий."));
            if (null == signFile.Content || signFile.Content.Length <= 0) throw new Exception(string.Format("У файлі \"{0}\" відсутній МАК підпис.", signFile.Name + signFile.Extension));
            string _mac = Encoding.UTF8.GetString(signFile.Content, 0, signFile.Content.Length);

            FileUploadData xmlFile = GetFileByExt(decompressedData, "XML");
            if (null == xmlFile || null == xmlFile.Content || xmlFile.Content.Length <= 0) throw new Exception(string.Format("Файл \"{0}\" відсутній або пустий.", xmlFile.Name + xmlFile.Extension));


            //byte[] sgnFile = decompressedData.Where(x => x.Extension == ".SGN").FirstOrDefault().Content;
            //if (null == sgnFile || sgnFile.Length <= 0) throw new Exception(string.Format("Файл з МАК підписом відсутній або пустий."));
            //string _mac = Encoding.UTF8.GetString(sgnFile, 0, sgnFile.Length);

            //byte[] mainFileContent = decompressedData.Where(x => x.Extension == ".XML").FirstOrDefault().Content;
            //if (null == mainFileContent || mainFileContent.Length <= 0) throw new Exception(string.Format("XML-файл відсутній або пустий."));



            //string fname = Path.GetFileNameWithoutExtension(filePath);
            //string signFilePath = Path.GetDirectoryName(filePath) + Path.DirectorySeparatorChar + fname + ".SGN";

            //if (!File.Exists(signFilePath)) throw new Exception(string.Format("Файл з МАК підписом відсутній(або немає доступу)."));

            //string _mac = File.ReadAllText(signFilePath);
            //if (string.IsNullOrWhiteSpace(_mac)) throw new Exception(string.Format("У файлі \"{0}\" відсутній МАК підпис.", signFilePath));

            //byte[] mainFileContent = File.ReadAllBytes(filePath);

            decimal id = UploadFile(new FileUploadData
            {
                Content = xmlFile.Content,
                Hash = _mac,
                Name = xmlFile.Name
            });

            string dirPath = Path.GetDirectoryName(filePath);
            try
            {
                string archiveDir = dirPath + Path.DirectorySeparatorChar + "ARCHIVE";
                if (!Directory.Exists(archiveDir)) Directory.CreateDirectory(archiveDir);
                File.Copy(filePath, archiveDir + Path.DirectorySeparatorChar + Path.GetFileName(filePath));
                File.Delete(filePath);
            }
            catch { }


            return id;
        }

        public byte[] GetLastSignature(long fileId)
        {
            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            using (OracleParameter pSign = new OracleParameter("p_sign", OracleDbType.Clob, ParameterDirection.Output))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "pkg_stat.get_last_sign";

                cmd.Parameters.Add(new OracleParameter("p_file_id", OracleDbType.Decimal, fileId, ParameterDirection.Input));
                cmd.Parameters.Add(pSign);

                cmd.ExecuteNonQuery();

                using (OracleClob _signClob = (OracleClob)pSign.Value)
                {
                    if (_signClob.IsNull || _signClob.IsEmpty) throw new Exception("Підписаний конверт пустий або відсутній.");

                    string signStr = _signClob.Value;
                    return Convert.FromBase64String(signStr);
                    //return Encoding.GetEncoding(1251).GetBytes(signStr);
                }
            }
        }

        public void UploadFileToResDir(string fileName, long fileId)
        {
            byte[] fileContent = GetLastSignature(fileId);
            string dirPath = GetWebCfgParameter(BarsWebConfig.UploadPath);
            if (!Directory.Exists(dirPath)) throw new Exception(string.Format("Каталог {0} відсутній або до нього немає доступу", dirPath));

            string path = dirPath + Path.DirectorySeparatorChar + fileName + ".p7s";

            File.WriteAllBytes(path, fileContent);
        }

        public string GetFileHashForCAdES(long storageId)
        {
            byte[] content = GetFileDataByStorageId(storageId);
            if (null == content || content.Length <= 0) throw new Exception("Empty File data.");

            using (Stream stream = new MemoryStream(content))
            {
                return HashFile.Gost34311Hash(stream);
            }
        }

        public void SetFileDetailsId(long fileId)
        {
            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "pul.set_mas_ini";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new OracleParameter("tag_", OracleDbType.Varchar2, "FILE_ID", ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("val_", OracleDbType.Varchar2, fileId, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("comm_", OracleDbType.Varchar2, null, ParameterDirection.Input));

                cmd.ExecuteNonQuery();
            }
        }

        #region private
        private decimal UploadFile(FileUploadData data)
        {
            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            using (OracleParameter pFileId = new OracleParameter("p_file_id", OracleDbType.Decimal, null, ParameterDirection.Output),
                                pStorageId = new OracleParameter("p_storage_id", OracleDbType.Decimal, null, ParameterDirection.Output))
            {
                cmd.CommandText = "pkg_stat.add_file";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new OracleParameter("p_file_name", OracleDbType.Varchar2, data.Name, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_file_data", OracleDbType.Blob, data.Content, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_file_hash", OracleDbType.Varchar2, data.Hash, ParameterDirection.Input));
                cmd.Parameters.Add(pFileId);
                cmd.Parameters.Add(pStorageId);

                cmd.ExecuteNonQuery();

                OracleDecimal _fileId = (OracleDecimal)pFileId.Value;
                if (_fileId.IsNull) throw new ArgumentNullException("p_file_id", "Процедура не повернула ІД файла");

                return _fileId.Value;
            }
        }
        private bool IsFileAllowed(List<string> allowedFileTypes, string filePath)
        {
            string fName = Path.GetFileName(filePath);
            string _fType = fName.Split('_')[1];

            if (!fName.ToUpper().StartsWith("CONSNBU")) return false;

            for (int i = 0; i < allowedFileTypes.Count; i++)
            {
                if (_fType == allowedFileTypes[i]) return true;
            }
            return false;
        }
        private string GetWebCfgParameter(string paramName)
        {
            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "select t.val from WEB_BARSCONFIG t where t.key = :p_name";
                cmd.Parameters.Add(new OracleParameter("p_name", OracleDbType.Varchar2, paramName, ParameterDirection.Input));
                object path = cmd.ExecuteScalar();
                if (null == path || string.IsNullOrWhiteSpace(Convert.ToString(path))) throw new Exception("Не заповнено параметр '" + paramName + "', або він пустий.");
                return Convert.ToString(path);
            }
        }
        private string GetCipherUrl()
        {
            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "select t.val from WEB_BARSCONFIG t where t.key = 'StatFiles.cipher.url'";
                object path = cmd.ExecuteScalar();
                if (null == path) throw new Exception("Не заповнено параметр \"Шлях до сервісу Cipher\" (StatFiles.cipher.url)");
                return Convert.ToString(path);
            }
        }

        private byte[] GetFileDataByStorageId(long storageId)
        {
            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            using (OracleParameter pFileData = new OracleParameter("p_file_data", OracleDbType.Blob, ParameterDirection.Output))
            {
                cmd.CommandText = "pkg_stat.get_file_data_by_storage";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new OracleParameter("p_storage_id", OracleDbType.Decimal, storageId, ParameterDirection.Input));
                cmd.Parameters.Add(pFileData);

                cmd.ExecuteNonQuery();

                using (OracleBlob _pFileData = (OracleBlob)pFileData.Value)
                {
                    return _pFileData.Value;
                }
            }
        }

        private FileUploadData GetFileByExt(List<FileUploadData> data, string ext)
        {
            ext = "." + ext.ToUpper();
            for (int i = 0; i < data.Count; i++)
            {
                if (ext == data[i].Extension) return data[i];
            }
            return null;
        }

        private List<FileUploadData> Decompress(byte[] zipContent)
        {
            List<FileUploadData> res = new List<FileUploadData>();

            using (MemoryStream mem = new MemoryStream(zipContent))
            using (ZipInputStream zipStream = new ZipInputStream(mem))
            {
                ZipEntry currentEntry;
                while ((currentEntry = zipStream.GetNextEntry()) != null)
                {
                    int size = 2048;
                    byte[] data = new byte[currentEntry.Size];
                    size = zipStream.Read(data, 0, (int)currentEntry.Size);

                    res.Add(new FileUploadData
                    {
                        Content = data,
                        Name = Path.GetFileNameWithoutExtension(currentEntry.Name),
                        Extension = Path.GetExtension(currentEntry.Name)
                    });
                }
            }

            return res;
        }
        private string GetFileDate(string day, string month)
        {
            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "select pkg_stat.nbu_decode(:p_day) || '.' || pkg_stat.nbu_decode(:p_month) from dual";
                cmd.Parameters.Add(new OracleParameter("p_day", OracleDbType.Varchar2, day, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_month", OracleDbType.Varchar2, month, System.Data.ParameterDirection.Input));

                object objRes = cmd.ExecuteScalar();

                return Convert.ToString(objRes);
            }
        }
        #endregion

        #region Global search & Count
        private IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _sqlTransformer.TransformSql(searchQuery, request);
            var item = _SignStatFiles.ExecuteStoreQuery<T>(query.SqlText, query.SqlParams);
            return item;
        }
        private decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _kendoSqlCounter.TransformSql(searchQuery, request);
            ObjectResult<decimal> res = _SignStatFiles.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams);
            decimal count = res.Single();
            return count;
        }
        private IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery)
        {
            return _SignStatFiles.ExecuteStoreQuery<T>(searchQuery.SqlText, searchQuery.SqlParams);
        }

        private int ExecuteStoreCommand(string commandText, params object[] parameters)
        {
            return _SignStatFiles.ExecuteStoreCommand(commandText, parameters);
        }

        private Params GetParam(string id)
        {
            return _globalData.GetParam(id);
        }
        #endregion
        private static class BarsWebConfig
        {
            /// <summary>
            /// StatFiles.path
            /// </summary>
            public static readonly string DownloadPath = "StatFiles.path";
            /// <summary>
            /// StatFiles.upload.path
            /// </summary>
            public static readonly string UploadPath = "StatFiles.upload.path";
            /// <summary>
            /// StatFiles.cipher.url
            /// </summary>
            public static readonly string CipherUrl = "StatFiles.cipher.url";
        }
    }
}
