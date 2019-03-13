using Bars.CommonModels.ExternUtilsModels;
using System;
using System.Diagnostics;
using System.IO;
using System.Text;

/// <summary>
/// Summary description for FileHelper
/// </summary>
namespace BarsWeb.Infrastructure.Helpers
{
    public class BaseIOHelper
    {
        public BaseIOHelper()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public void ToZip(ArchiveZip archiveZip)
        {
            ExecuteExtUtil(archiveZip);
        }

        public bool ExecuteExtUtil(BaseExternModel execModel)
        {
            ProcessStartInfo psinfo = new ProcessStartInfo(@"Utils\AbsCoreUtility.exe");
            psinfo.UseShellExecute = false;

            psinfo.RedirectStandardError = true;


            string pathsString = ConvertHelper.ObjectToJsonInBase64(execModel);
            psinfo.Arguments = pathsString;
            Process proc = Process.Start(psinfo);
            if (proc != null)
            {
                string strError = proc.StandardError.ReadToEnd();
                bool flagTerm = proc.WaitForExit(execModel.TimeOut);
                if (!flagTerm)
                {
                    proc.Kill();
                    throw new Exception(
                        "Процес 'AbsCoreUtility.exe' не завершив роботу у відведений час (200000 сек).");
                }
                int nExitCode = proc.ExitCode;
                if (0 != nExitCode)
                {
                    throw new Exception(
                        "Процес 'AbsCoreUtility.exe' аварійно завершив работу. Код " + nExitCode + "."
                        + "Опис коду повернення з потоку помилок: " + strError);
                }
            }
            return true;

        }
        public StreamWriter GetStreamWriterToFile(string path, Encoding encoding)
        {
            return new StreamWriter(File.Open(path, FileMode.Create), encoding);
        }

        public static void DeleteDir(string dir)
        {
            if (Directory.Exists(dir))
            {
                DirectoryInfo dirInfo = new DirectoryInfo(dir);
                foreach (var file in dirInfo.GetFiles())
                {
                    file.Delete();
                }
                foreach (var d in dirInfo.GetDirectories())
                {
                    DeleteDir(d.FullName);
                }
                dirInfo.Delete();
            }
        }
    }
}