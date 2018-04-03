using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using Bars.DataComponents;
using credit;

public partial class credit_constructor_wcstemplates : Bars.BarsPage
{
    # region Приватные методы
    private String MakeFile(String FileName, String FileExtention, String FileData)
    {
        String FilePath = String.Format("{0}{1}.{2}", System.IO.Path.GetTempPath(), FileName, FileExtention);

        System.IO.StreamWriter sw = new System.IO.StreamWriter(FilePath);
        sw.Write(FileData);
        sw.Close();

        return FilePath;
    }
    private String GetFileData()
    {
        String FileData = String.Empty;

        FileUpload fuTEMPLATE = fv.FindControl("fuTEMPLATE") as FileUpload;
        if (fuTEMPLATE.HasFile)
        {
            HttpPostedFile pf = fuTEMPLATE.PostedFile;
            System.IO.StreamReader sr = new System.IO.StreamReader(pf.InputStream);
            FileData = sr.ReadToEnd();
        }

        return FileData;
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void fv_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gv.DataBind();
    }
    protected void fv_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        gv.DataBind();
    }
    protected void fv_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        gv.DataBind();
    }
    # endregion
}
