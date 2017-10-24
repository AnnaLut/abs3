using Ionic.Zlib;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Text;
using System.Web.Services;
using System.Web.Services.Protocols;

namespace Bars.WebServices
{
    public static class ZipHelper
    {
        public static byte[] Pack(byte[] _data)
        {
            using (MemoryStream uncompressedDataStream = new MemoryStream(_data))
            {
                using (MemoryStream compressedDataStream = new MemoryStream())
                {
                    using (GZipStream compressStream = new GZipStream(compressedDataStream, CompressionMode.Compress))
                    {
                        uncompressedDataStream.CopyTo(compressStream);
                        compressStream.Close();

                        return compressedDataStream.ToArray();
                    }
                }
            }
        }

        public static byte[] UnPack(byte[] _data)
        {
            using (MemoryStream compressedDataStream = new MemoryStream(_data))
            {
                using (MemoryStream uncompressedDataStream = new MemoryStream())
                {
                    using (GZipStream compressingStream = new GZipStream(compressedDataStream, CompressionMode.Decompress))
                    {
                        compressingStream.CopyTo(uncompressedDataStream);
                        compressingStream.Close();

                        return uncompressedDataStream.ToArray();
                    }
                }
            }
        }
    }

    /// <summary>
    /// Summary description for ExternalFileManager
    /// </summary>
    [WebService(Namespace = "http://ws.unity-bars.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class ExternalFileManager : BarsWebService
    {

        public WsHeader WsHeaderValue;

        [WebMethod(EnableSession = true)]
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
        public string[] ListFolders(string FolderPath, bool WithSubfolders)
        {
            throw new NotImplementedException();
        }

        [WebMethod(EnableSession = true)]
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
        public string[] CheckWhetherFolderExists(string FolderPath)
        {
            throw new NotImplementedException();
        }

        [WebMethod(EnableSession = true)]
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
        public UnifiedResponse CreateFolder(string FolderPath)
        {
            throw new NotImplementedException();
        }

        [WebMethod(EnableSession = true)]
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
        public UnifiedResponse RemoveFolder(string FolderPath)
        {
            throw new NotImplementedException();
        }

        [WebMethod(EnableSession = true)]
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
        public FilesListResponse ListFiles(string FolderPath, bool WithSubfolders, string FileMask)
        {
            try
            {
                if (!Directory.Exists(FolderPath))
                    return new FilesListResponse() { ResponseCode = "Error", ResponseMessage = "DirectoryNotFoundException" + "\r\n" + String.Format("Каталог {0} не існує або відсутні права доступу до нього", FolderPath) };

                return new FilesListResponse() { ResponseCode = "Success", FilesList = Directory.GetFiles(FolderPath, FileMask, WithSubfolders ? SearchOption.AllDirectories : SearchOption.TopDirectoryOnly) };
            }
            catch (System.Exception ex)
            {
                return new FilesListResponse() { ResponseCode = "Error", ResponseMessage = ex.GetType().ToString() + "\r\n" + ex.Message + "\r\n" + ex.StackTrace };
            }
        }

        [WebMethod(EnableSession = true)]
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
        public FileResponse CheckWhetherFileExists(string FilePath)
        {
            try
            {
                return new FileResponse() { ResponseCode = "Success", Path = FilePath, Exists = File.Exists(FilePath) };
            }
            catch (System.Exception ex)
            {
                return new FileResponse() { ResponseCode = "Error", Path = FilePath, ResponseMessage = ex.GetType().ToString() + "\r\n" + ex.Message + "\r\n" + ex.StackTrace };
            }
        }

        [WebMethod(EnableSession = true)]
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
        public FileResponse GetFile(string FilePath)
        {
            try
            {
                Byte[] fileBody = File.ReadAllBytes(FilePath);
                fileBody = ZipHelper.Pack(fileBody);

                return new FileResponse() { ResponseCode = "Success", Path = FilePath, Exists = true, FileBody = Convert.ToBase64String(fileBody) };
            }
            catch (System.Exception ex)
            {
                return new FileResponse() { ResponseCode = "Error", Path = FilePath, ResponseMessage = ex.GetType().ToString() + "\r\n" + ex.Message + "\r\n" + ex.StackTrace };
            }
        }

        [WebMethod(EnableSession = true)]
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
        public FileResponse PutFile(string FileBody, string FilePath, bool Overwrite)
        {
            try
            {
                if (File.Exists(FilePath) && !Overwrite)
                {
                    return new FileResponse()
                    {
                        ResponseCode = "Success",
                        Path = FilePath,
                        Exists = true,
                        ResponseMessage = String.Format("Файл \"{0}\" вже існує", FilePath)
                    };
                }

                string directory = Path.GetDirectoryName(FilePath);

                if (!Directory.Exists(directory))
                    Directory.CreateDirectory(directory);

                Byte[] fileBody = Convert.FromBase64String(FileBody);
                fileBody = ZipHelper.UnPack(fileBody);

                File.WriteAllBytes(FilePath, fileBody);

                return new FileResponse { ResponseCode = "Success", Path = FilePath, Exists = true };
            }
            catch (System.Exception ex)
            {
                return new FileResponse { ResponseCode = "Error", ResponseMessage = ex.GetType().ToString() + "\r\n" + ex.Message + "\r\n" + ex.StackTrace };
            }
        }

        [WebMethod(EnableSession = true)]
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
        public FileResponse RemoveFile(string FilePath)
        {
            try
            {
                File.Delete(FilePath);

                return new FileResponse { Path = FilePath, ResponseCode = "Success" };
            }
            catch(System.Exception ex)
            {
                return new FileResponse { Path = FilePath, ResponseCode = "Error", ResponseMessage = ex.GetType().ToString() + "\r\n" + ex.Message + "\r\n" + ex.StackTrace };
            }
        }
    }

    public class UnifiedResponse
    {
        public String ResponseCode { get; set; }
        public String ResponseMessage { get; set; }
    }

    public class FileResponse : UnifiedResponse
    {
        public String Path { get; set; }
        public Boolean Exists { get; set; }
        public String FileBody { get; set; }
    }

    public class FilesListResponse : UnifiedResponse
    {
        public String[] FilesList { get; set; }
    }
}
