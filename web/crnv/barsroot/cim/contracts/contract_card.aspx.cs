using System;
using System.Collections.Generic;
using Bars.Oracle;
using Bars.Classes;
using System.Web;
using System.IO;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using barsroot.cim;
using Ionic.Zip;

public partial class cim_contracts_other_contract_card : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["contr_id"] != null)
            Master.SetPageTitle(this.Title + " №" + Request["contr_id"], true);

        ScriptManager.GetCurrent(this).Scripts.Add(new ScriptReference("/barsroot/cim/contracts/scripts/cim_contact_card.js?" + DateTime.Now.Ticks));
        ScriptManager.GetCurrent(this).RegisterPostBackControl(btFormFile);
        if (!ClientScript.IsStartupScriptRegistered(this.GetType(), "init"))
            ClientScript.RegisterStartupScript(this.GetType(), "init", "CIM.setVariables('" + Request["mode"] + "','" + Request["contr_id"] + "'); ", true);

        dsContrType.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsCreditorType.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsCreditType.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsCreditPeriod.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsCreditTerm.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsCreditMethod.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsCreditPrepay.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsCreditPercent.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsCreditOperType.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        dsKv.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
    }

    #region WebMethod

    [WebMethod(EnableSession = true)]
    public static Contract PopulateContract(decimal? contrId)
    {
        Contract conreactInfo = new Contract(contrId);
        return conreactInfo;
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

    #endregion

    protected void btFormFile_Click(object sender, EventArgs e)
    {
        if (Request["contr_id"] != null)
        {
            string tempDir = Path.Combine(Path.GetTempPath(), Path.GetRandomFileName());
            string agreeFile = string.Format("{0}\\{1}{2}", tempDir, "doc_agree", Path.GetExtension(fuAgreeDoc.FileName));
            string agreeFileName = string.Empty;
            string letterFile = string.Format("{0}\\{1}{2}", tempDir, "doc_letter", Path.GetExtension(fuLetterDoc.FileName));
            string letterFileName = string.Empty;
            string xmlFile = string.Format("{0}\\{1}", tempDir, "agree.xml");
            string fileType = string.Empty;
            switch (hCreditTerm.Value)
            {
                case "1": fileType = "L"; break;
                case "2":
                case "3": fileType = "L"; break;
            }
            string zipFile = string.Format("{0}\\W{1}rrrrrr_{2}.zip", tempDir, fileType, Request["contr_id"]);
            if (!Directory.Exists(tempDir))
                Directory.CreateDirectory(tempDir);
            if (fuAgreeDoc.HasFile)
            {
                fuAgreeDoc.SaveAs(agreeFile);
                agreeFileName = Path.GetFileName(agreeFile);
            }
            if (fuLetterDoc.HasFile)
            {
                fuLetterDoc.SaveAs(letterFile);
                letterFileName = Path.GetFileName(letterFile);
            }
            try
            {
                using (StreamWriter sw = new StreamWriter(xmlFile, false, System.Text.Encoding.GetEncoding(1251)))
                {
                    Contract contr = new Contract();
                    sw.Write(contr.ContractToXml(Convert.ToDecimal(Request["contr_id"]), agreeFileName, letterFileName, tbOldBankMfo.Text,tbOldOblCode.Text, tbOldBankCode.Text, tbOldBankOblCode.Text));
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

                Response.ClearContent();
                Response.ClearHeaders();
                Response.Charset = "windows-1251";
                Response.AppendHeader("content-disposition", "attachment;filename=" + Path.GetFileName(zipFile));
                Response.ContentType = "application/octet-stream";
                Response.WriteFile(zipFile, true);
                Response.Flush();
                Response.End();
            }
            finally
            {
                if (File.Exists(agreeFile))
                    File.Delete(agreeFile);
                if (File.Exists(letterFile))
                    File.Delete(letterFile);
                if (File.Exists(xmlFile))
                    File.Delete(xmlFile);
                if (File.Exists(zipFile))
                    File.Delete(zipFile);
                Directory.Delete(tempDir, true);
            }
        }

    }
}