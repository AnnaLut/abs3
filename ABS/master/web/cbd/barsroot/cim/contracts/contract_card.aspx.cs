using System;
using System.IO;
using System.Web.Services;
using System.Web.UI;
using Bars.Classes;
using barsroot.cim;
using Ionic.Zip;

public partial class cim_contracts_other_contract_card : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["contr_id"] != null)
        {
            Master.SetPageTitle(this.Title + " №" + Request["contr_id"], true);
            pnOwnerUser.Visible = true;
        }
        else
        {
            Master.SetPageTitle("Створення контракту", true);
            pnOwnerUser.Visible = false;
        }

        //ScriptManager.GetCurrent(this).Scripts.Add(new ScriptReference("/barsroot/cim/contracts/scripts/cim_contact_card.js?v" + CimManager.Version + Master.BuildVersion));
        Master.AddScript("/barsroot/cim/contracts/scripts/cim_contact_card.js");
        ScriptManager.GetCurrent(this).RegisterPostBackControl(btFormFile);
        if (!ClientScript.IsStartupScriptRegistered(this.GetType(), "init"))
            ClientScript.RegisterStartupScript(this.GetType(), "init", "CIM.setVariables('" + Request["mode"] + "','" + Request["contr_id"] + "'); ", true);

        dsContrType.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsCreditorType.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsCreditType.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsCreditBorrower.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsBranches.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsCreditTerm.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        //dsCreditMethod.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsCreditPrepay.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsCreditPercent.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsTrDeadline.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsTrSpecs.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsTrSubjects.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        dsKv.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        if (Request["mode"] == "download")
        {
            DownloadFile(Request["file"]);
        }
    }

    #region WebMethod

    [WebMethod(EnableSession = true)]
    public static Contract PopulateContract(decimal? contrId)
    {
        Contract contractInfo = new Contract(contrId);
        return contractInfo;
    }

    [WebMethod(EnableSession = true)]
    public static decimal SaveContract(Contract contract)
    {
        return contract.SaveContract();
    }

    [WebMethod(EnableSession = true)]
    public static decimal ApproveNbuContract(Contract contract)
    {
        return contract.ApproveNbuContract();
    }

    [WebMethod(EnableSession = true)]
    public static decimal DiscardNbuContract(Contract contract)
    {
        return contract.DiscardNbuContract();
    }

    [WebMethod(EnableSession = true)]
    public static ClientClass GetClientInfo(decimal? rnk, string okpo)
    {
        ClientClass clientInfo = new ClientClass(rnk, okpo);
        return clientInfo;
    }

    [WebMethod(EnableSession = true)]
    public static BeneficiarClass GetBeneficiarInfo(decimal id)
    {
        BeneficiarClass beneficiarInfo = new BeneficiarClass(id);
        return beneficiarInfo;
    }
    [WebMethod(EnableSession = true)]
    public static BeneficiarBankClass GetBeneficiarBankInfo(string bicCode, string b010)
    {
        BeneficiarBankClass beneficiarBankInfo = new BeneficiarBankClass(bicCode, b010);
        return beneficiarBankInfo;
    }

    [WebMethod(EnableSession = true)]
    public static void SetOwner(decimal contrId)
    {
        CimManager cm = new CimManager(false);
        cm.SetOwner(contrId);
    }

    [WebMethod(EnableSession = true)]
    public static void SetBranch(decimal contrId, string branch)
    {
        CimManager cm = new CimManager(false);
        cm.SetContractBranch(contrId, branch);
    }

    

    #endregion


    private void DownloadFile(string filePath)
    {
        try
        {
            Response.ClearContent();
            Response.ClearHeaders();
            Response.Charset = "windows-1251";
            Response.AppendHeader("content-disposition", "attachment;filename=" + Path.GetFileName(filePath));
            Response.ContentType = "application/octet-stream";
            Response.WriteFile(filePath, true);
            Response.Flush();
            Response.End();
        }
        finally
        {
            if (File.Exists(filePath))
                File.Delete(filePath);
            Directory.Delete(Path.GetDirectoryName(filePath), true);
        }
    }

    protected void btFormFile_Click(object sender, EventArgs e)
    {
        if (Request["contr_id"] != null)
        {
            CimManager cm = new CimManager(true);
            string tempDir = Path.Combine(Path.GetTempPath(), Path.GetRandomFileName());
            string agreeFile = string.Format("{0}\\{1}{2}", tempDir, "agree", Path.GetExtension(fuAgreeDoc.FileName));
            string agreeFileName = string.Empty;
            string letterFile = string.Format("{0}\\{1}{2}", tempDir, "letter", Path.GetExtension(fuLetterDoc.FileName));
            string letterFileName = string.Empty;
            string xmlFile = string.Format("{0}\\{1}", tempDir, "agree.xml");
            string zipFile = string.Format("{0}\\WL{1}_{2}_{3}.zip", tempDir, cm.BankId, Request["contr_id"], DateTime.Now.ToString("yyyyMMdd"));
            if (!Directory.Exists(tempDir))
                Directory.CreateDirectory(tempDir);
            if (fuAgreeDoc.HasFile)
            {
                if (fuAgreeDoc.PostedFile.ContentLength > 8388608)
                {
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "max_size", "alert(\"Перевищено допустимий розмір файлу (8 Мб).\");", true);
                    return;
                }

                fuAgreeDoc.SaveAs(agreeFile);
                agreeFileName = Path.GetFileName(agreeFile);
            }
            if (fuLetterDoc.HasFile)
            {
                if (fuLetterDoc.PostedFile.ContentLength > 8388608)
                {
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "max_size", "alert(\"Перевищено допустимий розмір файлу (8 Мб).\");", true);
                    return;
                }
                fuLetterDoc.SaveAs(letterFile);
                letterFileName = Path.GetFileName(letterFile);
            }
            try
            {
                using (StreamWriter sw = new StreamWriter(xmlFile, false, System.Text.Encoding.GetEncoding(1251)))
                {
                    Contract contr = new Contract();
                    sw.Write(contr.ContractToXml(Convert.ToDecimal(Request["contr_id"]), agreeFileName, letterFileName, tbOldBankMfo.Text, tbOldOblCode.Text, tbOldBankCode.Text, tbOldBankOblCode.Text, tbOldApproveCrdDocKey.Value, tbOldApproveCrdDate.Value, tbOldApproveCrdNum.Value));
                    sw.Close();
                }

                using (ZipFile zip = new ZipFile(zipFile, System.Text.Encoding.GetEncoding(1251)))
                {
                    zip.CompressionLevel = Ionic.Zlib.CompressionLevel.Level9;
                    zip.TempFileFolder = Path.GetTempPath();
                    if (File.Exists(agreeFile))
                        zip.AddFile(agreeFile, "\\");
                    if (File.Exists(letterFile))
                        zip.AddFile(letterFile, "\\");
                    zip.AddFile(xmlFile, "\\");
                    zip.Save();
                }
                ClientScript.RegisterClientScriptBlock(this.GetType(), "downloadfile", "var win=window.open('/barsroot/cim/contracts/contract_card.aspx?mode=download&file=" + System.Web.HttpUtility.UrlEncode(zipFile) + "',null,'width=1,height=1,left=1,top=1'); win.style='visibility:hidden';", true);
                /*Response.ClearContent();
                Response.ClearHeaders();
                Response.Charset = "windows-1251";
                Response.AppendHeader("content-disposition", "attachment;filename=" + Path.GetFileName(zipFile));
                Response.ContentType = "application/octet-stream";
                Response.WriteFile(zipFile, true);
                Response.Flush();
                Response.End();*/
            }
            finally
            {
                /*if (File.Exists(agreeFile))
                    File.Delete(agreeFile);
                if (File.Exists(letterFile))
                    File.Delete(letterFile);
                if (File.Exists(xmlFile))
                    File.Delete(xmlFile);
                if (File.Exists(zipFile))
                    File.Delete(zipFile);
                Directory.Delete(tempDir, true);*/
            }
        }

    }
}