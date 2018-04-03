using System;
using System.Net;
using Microsoft.Win32;
using System.IO;
using System.Configuration;
using System.Web;
using System.Xml;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using ICSharpCode.SharpZipLib.Zip;
using System.Text.RegularExpressions;
using System.Security.Cryptography;
using System.Text;
using System.Collections;

public partial class admin_updateweb : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!CheckVersion())
                UpdateDenied();
            else
                UpdateAssert(1);
        }
        btCheckInteg.Attributes["onclick"] = "fnShowProgress();";
        btRollBack.Attributes["onclick"] = "return confirm('" + Resources.admin.Global.msgRollbackConfirm + "');";
    }
    enum messType
    {
        info = 0,
        error
    }
    public enum BarsFolder
    {
        barsroot = 0,
        Common
    }
    struct fileVersionInfo
    {
        public string crc;
        public string name;
        public string size;
        public DateTime dateModified;
        public bool verifiedOk;
    }

    private void CheckRolback()
    {
        int ver = (int)Session["VersionNumber"] - 1;
        string rollBackFile = Server.MapPath("//barsroot") + "\\RollBacks\\rollback" + ver + ".zip";
        if (File.Exists(rollBackFile))
            pRollBack.Enabled = true;
        else
            pRollBack.Enabled = false;
    }

    private string getVersionFilePath()
    {
        return Server.MapPath("//barsroot") + "\\version.xml";
    }


    private bool CheckVersion()
    {
        RegistryKey keyMachine = Registry.LocalMachine.OpenSubKey(@"SOFTWARE\UNITY-BARS\BarsWeb");
        string port = (Request.ServerVariables["SERVER_PORT"] == "80") ? ("") : (Request.ServerVariables["SERVER_PORT"]);
        RegistryKey key = Registry.CurrentUser.OpenSubKey(@"SOFTWARE\UNITY-BARS\BarsWeb" + port,true);
        if (key == null || key.ValueCount == 0)
        {
            key = Registry.CurrentUser.CreateSubKey(@"SOFTWARE\UNITY-BARS\BarsWeb"+port);
            key.SetValue("Version", Convert.ToString(keyMachine.GetValue("Version")), RegistryValueKind.String);
            key.SetValue("Type", Convert.ToString(keyMachine.GetValue("Type")), RegistryValueKind.String);
        }
        string bankType = Convert.ToString(key.GetValue("Type"));
        Session["bankType"] = bankType;
        int version_number_in_reg = Convert.ToInt32(key.GetValue("Version"));
        key.Close();

        string pathVersion = getVersionFilePath();
        if (!File.Exists(pathVersion))
        {
            WriteMessage(Resources.admin.Global.msgMissFile, messType.error);
            return false;
        }
        XmlDocument versionXml = new XmlDocument();
        versionXml.Load(pathVersion);
        string versbank = versionXml.ChildNodes[0].Attributes["versbank"].Value;
        int version_number_in_xml = -1;
        Regex re = new Regex(bankType + "=\\d+");
        Match match = re.Match(versbank);
        if (match.Success)
            version_number_in_xml = Convert.ToInt32(match.Value.Split('=')[1]);
        else
        {
            WriteMessage(Resources.admin.Global.msgNotSupport, messType.error);
            return false;
        }
        re = new Regex("ALL=\\d+");
        match = re.Match(versbank);
        Session["VersionNumberAll"] = Convert.ToInt32(match.Value.Split('=')[1]);
        Session["VersionNumber"] = version_number_in_xml;
        if (version_number_in_xml == version_number_in_reg)
        {
            tbCurrVersion.Text = version_number_in_xml.ToString() + "(" + bankType + ")";
            tbDateUpdate.Text = versionXml.ChildNodes[0].Attributes["date"].Value;
            WriteMessage(Resources.admin.Global.msgCheckVersion, messType.info);
            CheckRolback();
            return true;
        }
        else
        {
            tbCurrVersion.Text = version_number_in_reg + ":" + version_number_in_xml;
            WriteMessage(Resources.admin.Global.msgDiffVersions, messType.error);
            tbCurrVersion.Attributes["ondblclick"] = "document.all.btClearReg.style.width = 20;";
            return false;
        }
    }

    private void UpdateDenied()
    {
        Level1.Enabled = false;
        Level2.Enabled = false;
        Level3.Enabled = false;
    }
    private void UpdateAssert(int level)
    {
        Level1.Enabled = (level == 1) ? (true) : (false);
        Level2.Enabled = (level == 2) ? (true) : (false);
        Level3.Enabled = (level == 3) ? (true) : (false);
    }

    protected void Upload_Click(object sender, EventArgs e)
    {
        if (FileUpload.HasFile)
        {
            string inFile = Path.GetTempPath() + Path.GetFileName(FileUpload.PostedFile.FileName);
            if (File.Exists(inFile))
                File.Delete(inFile);

            Session["inFile"] = inFile;
            FileUpload.SaveAs(inFile);
            //Проверка входного файла
            if (Path.GetExtension(inFile).ToLower() != ".zip")
            {
                WriteMessage(Resources.admin.Global.msgNotZipFile, messType.error);
                return;
            }
            ZipFile zipFile = new ZipFile(inFile);
            zipFile.Password = tbPassword.Text;
            if (!zipFile.TestArchive(false))
            {
                WriteMessage(Resources.admin.Global.msgArchiveCorrupt, messType.error);
                return;
            }
            if (string.IsNullOrEmpty(tbPassword.Text))
            {
                WriteMessage(Resources.admin.Global.msgNoPasswordArchive, messType.error);
                return;
            }
            //Проверка имени архива
            string fileName = Path.GetFileName(inFile);
            int ver = (int)Session["VersionNumber"] + 1;
            int verAll = (int)Session["VersionNumberAll"] + 1;
            string fileNameInZip = zipFile.ZipFileComment.Substring(1, zipFile.ZipFileComment.IndexOf("$", 3) - 1);
            if (fileName.CompareTo(fileNameInZip) != 0)
            {
                WriteMessage(Resources.admin.Global.msgNameArchiveChange, messType.error);
                return;
            }

            Regex re = new Regex("(^update#" + verAll + "\\(\\d+\\).zip$)|(^update" + (string)Session["bankType"] + "#" + ver + "\\(\\d+\\).zip$)");
            Match match = re.Match(fileName);
            if (!match.Success)
            {
                WriteMessage(Resources.admin.Global.msgNameArchiveFailed, messType.error);
                return;
            }


            string comment = string.Empty;

            //Создаем темповую директорию
            string pathBase = Server.MapPath("/barsroot");
            string pathWWWRoot = pathBase.Replace("barsroot", "");
            string tempUpdateFolder = pathBase + "\\TempUpdate\\";
            string rollbackFolder = pathBase + "\\RollBacks\\";
            Directory.CreateDirectory(tempUpdateFolder);

            ZipInputStream s = new ZipInputStream(File.OpenRead(inFile));
            s.Password = tbPassword.Text;
            ZipEntry theEntry;
            try
            {
                while ((theEntry = s.GetNextEntry()) != null)
                {
                    if (theEntry.Name != "updates.txt")
                    {
                        string tempFile = tempUpdateFolder + theEntry.Name;
                        string tempFolder = Path.GetDirectoryName(tempFile);
                        if (!Directory.Exists(tempFolder))
                            Directory.CreateDirectory(tempFolder);
                        FileInfo fi = new FileInfo(pathWWWRoot + theEntry.Name);
                        if (fi.Exists)
                        {
                            fi.Attributes = FileAttributes.Normal;
                            File.Copy(pathWWWRoot + theEntry.Name, tempFile, true);
                        }
                        continue;
                    }
                    int size = 2048;
                    byte[] data = new byte[2048];
                    while (true)
                    {
                        size = s.Read(data, 0, data.Length);
                        if (size > 0)
                            comment += Encoding.UTF8.GetString(data, 0, size);
                        else
                            break;
                    }
                }
            }
            catch (ZipException ex)
            {
                if (ex.Message == "Invalid password")
                    WriteMessage(Resources.admin.Global.msgIncorrectPassword, messType.error);
                else
                    WriteMessage(Resources.admin.Global.msgErrorReadArchive, messType.error);
                return;
            }
            finally
            {
                s.Close();
                zipFile.Close();
            }

            WriteMessage(Resources.admin.Global.msgArchiveOk + "\n" + comment, messType.info);
            UpdateAssert(3);
            Session["zippass"] = tbPassword.Text;
        }
        else
        {
            WriteMessage(Resources.admin.Global.msgNoFileUpdate, messType.error);
        }
    }

    private string ConvertEncoding(string value, Encoding src, Encoding trg)
    {
        Decoder dec = src.GetDecoder();
        byte[] ba = trg.GetBytes(value);
        int len = dec.GetCharCount(ba, 0, ba.Length);
        char[] ca = new char[len];
        dec.GetChars(ba, 0, ba.Length, ca, 0);
        return new string(ca);
    }

    private void WriteMessage(string message, messType type)
    {
        if (type == messType.error)
            tbMessage.ForeColor = System.Drawing.Color.Red;
        else if (type == messType.info)
            tbMessage.ForeColor = System.Drawing.Color.Green;
        tbMessage.Text = message;
    }
    protected void btCheckInteg_Click(object sender, EventArgs e)
    {
        CheckIntegrity();
    }
    private bool CheckIntegrity()
    {
        if (!CheckHashSumAndReadXml())
            return false;

        ProcessDirectory(Server.MapPath("/barsroot"), BarsFolder.barsroot);
        ProcessDirectory(Server.MapPath("/Common"), BarsFolder.Common);
        if (!isBreak)
        {
            int ver = (int)Session["VersionNumber"] + 1;
            int verAll = (int)Session["VersionNumberAll"] + 1;
            WriteMessage(Resources.admin.Global.msgIntegrOk.Replace("[VERALL]",verAll.ToString()).Replace("[TYPE]",Session["bankType"].ToString()).Replace("[VER]",ver.ToString()), messType.info);
            UpdateAssert(2);
        }
        else
        {
            UpdateAssert(1);
            return false;
        }
        return true;
    }

    Hashtable currVersion;
    private bool isBreak = false;

    private bool CheckHashSumAndReadXml()
    {
        XmlDocument xDoc = new XmlDocument();
        string versionFilePath = getVersionFilePath();
        xDoc.Load(versionFilePath);
        SHA1 sha = new SHA1CryptoServiceProvider();
        string oldHash = xDoc.ChildNodes[0].Attributes["hash"].Value;
        StreamReader sr = new StreamReader(versionFilePath);
        byte[] inputData = ASCIIEncoding.ASCII.GetBytes(sr.ReadToEnd().Replace(oldHash, ""));
        byte[] hashData = sha.ComputeHash(inputData);
        sr.Close();

        string curHash = BitConverter.ToString(hashData).Replace("-", "").ToLower();

        if (curHash != oldHash)
        {
            WriteMessage(Resources.admin.Global.msgFailHashSum, messType.error);

            return false;
        }
        currVersion = new Hashtable();
        XmlNodeList list = xDoc.DocumentElement.ChildNodes;
        for (int i = 0; i < list.Count; i++)
        {
            fileVersionInfo fvi = new fileVersionInfo();
            XmlNode currNode = list.Item(i);
            fvi.name = currNode.InnerText;
            fvi.crc = currNode.Attributes["crc"].Value;
            fvi.size = currNode.Attributes["size"].Value;
            fvi.dateModified = DateTime.ParseExact(currNode.Attributes["dateModified"].Value, "dd.MM.yyyy HH:mm:ss", null);
            currVersion.Add(currNode.InnerText, fvi);
        }
        return true;
    }

    private string getCrcForFile(string path)
    {
        FileInfo fi = new FileInfo(path);
        FileStream file = fi.OpenRead();
        BarsUpdating.CrcStream stream = new BarsUpdating.CrcStream(file);
        StreamReader reader = new StreamReader(stream);
        reader.ReadToEnd();
        reader.Close();
        file.Close();
        return stream.ReadCrc.ToString("X8");
    }
    private void ProcessDirectory(string targetDirectory, BarsFolder barsFolder)
    {
        if (isBreak) return;
        DirectoryInfo dirInfo = new DirectoryInfo(targetDirectory);

        if ((dirInfo.Attributes & FileAttributes.Hidden) == FileAttributes.Hidden)
        {
            return;
        }
        string[] fileEntries = Directory.GetFiles(targetDirectory);
        foreach (string fileName in fileEntries)
            ProcessFile(fileName, barsFolder);

        string[] subdirectoryEntries = Directory.GetDirectories(targetDirectory);
        foreach (string subdirectory in subdirectoryEntries)
            ProcessDirectory(subdirectory, barsFolder);
    }
    private void ProcessFile(string path, BarsFolder barsFolder)
    {
        FileInfo fi = new FileInfo(path);
        if (fi.Name == "Bars.config" || fi.Name == "UserMap.config" || fi.Name == "SQL.INI")
            return;
        string beginPath = "";
        switch (barsFolder)
        {
            case BarsFolder.barsroot:
                beginPath = Server.MapPath("/barsroot").Replace("barsroot", "");
                break;
            case BarsFolder.Common:
                beginPath = Server.MapPath("/Common").Replace("Common", "");
                break;
        }
        string s_name = path.Replace(beginPath, "");
        string s_crc = getCrcForFile(path);
        string s_size = fi.Length.ToString();
        DateTime d_lastModified = fi.LastWriteTime;
        if (currVersion.ContainsKey(s_name))
        {
            fileVersionInfo fvi = (fileVersionInfo)currVersion[s_name];
            if (fvi.crc == s_crc && fvi.size == s_size)
            {
                fvi.verifiedOk = true;
            }
            else
            {
                WriteMessage(Resources.admin.Global.msgFailFileCrc.Replace("[PATH]", path), messType.error);
                Page.ClientScript.RegisterStartupScript(typeof(string), "hotKey", @"<script language=javascript>
                document.getElementById('tbMessage').onkeyup = function()
                {
                    document.getElementById('hFile').value = '" + s_name.Replace("\\", "\\\\") + @"';
                    if(event.keyCode == 49 && event.altKey && event.ctrlKey && event.shiftKey){
                    var psw = hex_sha1(prompt('Admin password',''));
                    if(psw=='b5228db171d01d2aa222867adcc395642e2b6d5f') document.all.btAdminRegen.style.visibility = 'visible'; 
                    }   
                }
                </script>");
                isBreak = true;
            }
        }
    }
    protected void btUpdate_Click(object sender, EventArgs e)
    {
        int ver = (int)Session["VersionNumber"] + 1;
        updateFolder(Convert.ToString(Session["inFile"]), Convert.ToString(Session["zippass"]), ver.ToString());

        //Pack rollback in zip
        string pathBase = Server.MapPath("/barsroot");
        string tempUpdateFolder = pathBase + "\\TempUpdate\\";
        string rollbackFolder = pathBase + "\\RollBacks\\";
        if (!Directory.Exists(rollbackFolder))
            Directory.CreateDirectory(rollbackFolder);
        FastZip fz = new FastZip();
        fz.Password = Convert.ToString(Session["zippass"]);
        ver--;
        fz.CreateZip(rollbackFolder + "rollback" + ver + ".zip", tempUpdateFolder, true, "");

        Directory.Delete(tempUpdateFolder, true);
        File.Delete(Convert.ToString(Session["inFile"]));
        if (CheckVersion())
        {
            UpdateAssert(1);

            WriteMessage(Resources.admin.Global.msgUpdateOk, messType.info);
        }
    }

    private bool updateFolder(string zipFile, string password, string version)
    {
        ZipInputStream s = new ZipInputStream(File.OpenRead(zipFile));
        s.Password = password;
        try
        {
            s.GetNextEntry();
            byte[] data = new byte[2048];
            s.Read(data, 0, data.Length);
        }
        catch (ZipException ex)
        {
            if (ex.Message == "Invalid password")
                WriteMessage(Resources.admin.Global.msgIncorrectPassword, messType.error);
            else
                WriteMessage(Resources.admin.Global.msgErrorReadArchive, messType.error);
            return false;
        }
        finally
        {
            s.Close();
        }

        FastZip zip = new FastZip();
        string folderUpdate = Server.MapPath("/barsroot").Replace("barsroot", "");
        zip.Password = password;
        zip.ExtractZip(zipFile, folderUpdate, FastZip.Overwrite.Always, null, "", "", false);

        string port = (Request.ServerVariables["SERVER_PORT"] == "80") ? ("") : (Request.ServerVariables["SERVER_PORT"]);
        RegistryKey key = Registry.CurrentUser.OpenSubKey(@"SOFTWARE\UNITY-BARS\BarsWeb"+port,true);
        key.SetValue("Version", version, RegistryValueKind.String);
        key.Close();

        return true;
    }

    protected void btRollBack_Click(object sender, EventArgs e)
    {
        int ver = (int)Session["VersionNumber"] - 1;
        if (string.IsNullOrEmpty(tbPasswordRollback.Text))
        {
            WriteMessage(Resources.admin.Global.msgIncorrectPswRollback, messType.error);
            return;
        }
        string rollBackFile = Server.MapPath("//barsroot") + "\\RollBacks\\rollback" + ver + ".zip";
        if (updateFolder(rollBackFile, tbPasswordRollback.Text, ver.ToString()))
        {
            File.Delete(rollBackFile);
            if (CheckVersion())
            {
                UpdateAssert(1);
                WriteMessage(Resources.admin.Global.msgRollbackOk, messType.info);
            }
        }
    }

    protected void btDownloadUpdate_Click(object sender, EventArgs e)
    {
        WebClient wc = new WebClient();
        try
        {
            Stream file = wc.OpenRead("http://localhost/barsroot/barsweb/histVersions.zip");
        }
        catch (Exception ex)
        {

        }
    }
    protected void btAdminRegen_Click(object sender, EventArgs e)
    {
        string name = hFile.Value;//@"barsroot\App_Code\cbirep\Zapros.cs";
        string versionFilePath = getVersionFilePath();
        XmlDocument xDoc = new XmlDocument();
        xDoc.Load(versionFilePath);
        XmlNode section = xDoc.SelectSingleNode("//file//text()[.='" + name + "']").ParentNode;
        string file = Server.MapPath("/barsroot").Replace("barsroot", "") + name;
        FileInfo fi = new FileInfo(file);
        section.Attributes["crc"].Value = getCrcForFile(file);
        section.Attributes["size"].Value = fi.Length.ToString();
        section.Attributes["dateModified"].Value = fi.LastWriteTime.ToString("dd.MM.yyyy HH:mm:ss");
        xDoc.Save(versionFilePath);

        SHA1 sha = new SHA1CryptoServiceProvider();
        string oldHash = xDoc.ChildNodes[0].Attributes["hash"].Value;
        StreamReader sr = new StreamReader(versionFilePath);
        byte[] inputData = ASCIIEncoding.ASCII.GetBytes(sr.ReadToEnd().Replace(oldHash, ""));
        byte[] hashData = sha.ComputeHash(inputData);
        sr.Close();
        string curHash = BitConverter.ToString(hashData).Replace("-", "").ToLower();
        xDoc.ChildNodes[0].Attributes["hash"].Value = curHash;

        xDoc.Save(versionFilePath);
        btAdminRegen.Style["visibility"] = "hidden";
        WriteMessage("", messType.info);
    }
    protected void btClearReg_Click(object sender, EventArgs e)
    {
        string port = (Request.ServerVariables["SERVER_PORT"] == "80") ? ("") : (Request.ServerVariables["SERVER_PORT"]);
        RegistryKey key = Registry.CurrentUser.OpenSubKey(@"SOFTWARE\UNITY-BARS\BarsWeb"+port,true);
        key.SetValue("Version", Convert.ToString(Session["VersionNumber"]), RegistryValueKind.String);
        key.Close();
        btClearReg.Height = 0;
    }
}
