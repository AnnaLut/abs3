using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using Bars.CommonModels;
using System.IO;
using ICSharpCode.SharpZipLib.Zip;
using Ninject;
using BarsWeb.Core.Logger;
using BarsWeb.Areas.Ndi.Models;
/// <summary>
/// Summary description for ImportToFileHelper
/// </summary>

namespace BarsWeb.Areas.Ndi.Infrastructure.Helpers
{

    public class ImportToFile
    {


        private IDbLogger _dbLogger;
        public ImportToFile()
        {
            _dbLogger = DbLoggerConstruct.NewDbLogger();

        }
        public string ExcelExportToZipCSVFiles(char columnSeparator, string fileName, IEnumerable<Dictionary<string, object>> dataRecords, 
            List<ColumnMetaInfo> columnsInfo,int limit)
        {
            _dbLogger.Info(string.Format("begin ExcelExportToZipCSVFiles for file:  {0} ", fileName));
            string _tempDir = Path.GetTempPath();
            string fileNameWithExt = fileName + ".csv";
            string dirPath = _tempDir + "__" + HttpContext.Current.Session.SessionID + "__" + fileName;
            CreateNewDirectoryAndFile(dirPath);
            string path = dirPath + "\\" + fileNameWithExt;
            Dictionary<string, int> headerLen = new Dictionary<string, int>();
            Encoding windows = Encoding.GetEncoding("windows-1251");
            StringBuilder sbHeaders = new StringBuilder();
            foreach (var colInfo in columnsInfo)
            {
                sbHeaders.Append(colInfo.SEMANTIC != null ? colInfo.SEMANTIC.Replace("~", " ") : "");
                sbHeaders.Append(columnSeparator);
            }
            sbHeaders.Remove(sbHeaders.Length - 1, 1);
            string headers = sbHeaders.ToString();
            List<string> filePathes = new List<string>() { path };
            StreamWriter sw = GetStreamWriterToFile(path, windows);
            try
            {
                // remove last 'columnSeparator' symbol
                //sbHeaders.AppendLine();
                sw.WriteLine("sep=" + columnSeparator);
                sw.WriteLine(sbHeaders);
                int rowCount = 0;
                
                    foreach (Dictionary<string, object> rowData in dataRecords)
                    {
                    if (rowCount >= limit)
                        break;
                        rowCount++;
                        if (rowCount % 1000000 == 0)
                        {

                        sw.Close();
                        sw.Dispose();
                        string newFilePath = dirPath + "\\" + fileName + "_more_" + rowCount.ToString() + ".csv";
                        filePathes.Add(newFilePath);
                        sw = GetStreamWriterToFile(newFilePath, windows);
                        sw.WriteLine("sep=" + columnSeparator);
                        sw.WriteLine(sbHeaders);
                    }

                        //System.Text.StringBuilder sbRow = new System.Text.StringBuilder();
                        string v = string.Empty;
                        string sbRow = "";
                        foreach (var colInfo in columnsInfo)
                        {
                            object o = rowData[colInfo.COLNAME];
                            if (o != null)
                            {
                                v = o.ToString();
                                if (colInfo == null)
                                    continue;
                                //hack for A7 report
                                if (colInfo.COLTYPE == "D")
                                {
                                    if (!string.IsNullOrEmpty(v))
                                        v = ((DateTime)o).ToString(string.IsNullOrEmpty(colInfo.COLTYPE) ? "ddMMyyyy" 
                                            : colInfo.COLTYPE);
                                }

                                sbRow += v;
                            }
                            else
                                sbRow += "";

                            sbRow += columnSeparator;
                        }
                        sbRow = sbRow.Remove(sbRow.Length - 1, 1);
                        sw.WriteLine(sbRow);

                    }
                
                sw.Close();
                sw.Dispose();
                sw = null;
                if (filePathes.Count() == 1)
                    return filePathes.First();
                string zipFilePath = _tempDir + fileName + DateTime.Now.Hour + DateTime.Now.Minute + DateTime.Now.Second + ".zip";
                ToZip(filePathes, zipFilePath);
                return zipFilePath;



            }
            catch (Exception e)
            {
                sw.Close();
                sw.Dispose();
                sw = null;
                DirectoryInfo di = new DirectoryInfo(dirPath);

                foreach (FileInfo file in di.GetFiles())
                {
                    file.Delete();
                }
                foreach (DirectoryInfo dir in di.GetDirectories())
                {
                    dir.Delete(true);
                }
                _dbLogger.Error(string.Format("ExcelExportToZipCSVFiles BarsWeb.Areas.Ndi.Infrastructure.Helpers: {0}", e.Message), "ExcelExportToZipCSVFiles");
                throw e;
            }
            finally
            {
                
            }
        }

        private static void ToZip(List<string> filesPathes, string zipFile)
        {
            var zipOutputStream = new ZipOutputStream(File.Create(zipFile));
            foreach (var item in filesPathes)
            {
                ZipEntry zipEntry = new ZipEntry(Path.GetFileName(item));
                zipOutputStream.PutNextEntry(zipEntry);
                FileStream fs = File.OpenRead(item);
                byte[] buffer = new byte[fs.Length];
                fs.Read(buffer, 0, buffer.Length);
                zipOutputStream.Write(buffer, 0, buffer.Length);
                fs.Close();
                fs.Dispose();
                fs = null;
            }

            zipOutputStream.Finish();
            zipOutputStream.Close();
        }

        public static void CreateNewDirectoryAndFile(string path)
        {
            if (!Directory.Exists(path))
                Directory.CreateDirectory(path);


        }

        public static StreamWriter GetStreamWriterToFile(string path, Encoding encoding)
        {
            return new StreamWriter(File.Open(path, FileMode.Create), encoding);
        }

    }
}