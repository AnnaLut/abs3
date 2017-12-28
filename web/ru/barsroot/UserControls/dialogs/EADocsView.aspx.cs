using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using BarsWeb.Core.Logger;
using System.Data;
public partial class UserControls_dialogs_EADocsView : System.Web.UI.Page
{
    private readonly IDbLogger _dbLogger;
    public UserControls_dialogs_EADocsView()
    {
        _dbLogger = DbLoggerConstruct.NewDbLogger();
    }

    /// <summary>
    /// Код структуры документа
    /// </summary>
    public Int16 EAStructID
    {
        get
        {
            return Convert.ToInt16(Request.Params.Get("eas_id"));
        }
    }
    /// <summary>
    /// РНК клиента
    /// </summary>
    public Decimal RNK
    {
        get
        {
            return Convert.ToDecimal(Request.Params.Get("rnk"));
        }
    }
    /// <summary>
    /// Ид. сделки
    /// </summary>
    public Double? AgrID
    {
        get
        {
            if (String.IsNullOrEmpty(Request.Params.Get("agr_id")))
                return (Int64?)null;

            return Convert.ToInt64(Request.Params.Get("agr_id"));
        }
    }
    /// <summary>
    /// Номер запиту на бек-офіс
    /// </summary>
    public String ReqID
    {
        get
        {
            if (String.IsNullOrEmpty(Request.Params.Get("req_id")))
                return String.Empty;

            return Convert.ToString(Request.Params.Get("req_id"));
        }
    }

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (this.EAStructID == 1)
            {
                short[] do_list = new short[] { 111, 112, 113, 114, 115, 116, 117, 118, 119, 1110, 1111, 121, 122, 13, 142, 145, 147, 401, 148, 1319, 1115 };
                List<Bars.EAD.Structs.Result.DocumentData> docs_ea = Bars.EAD.EADService.GetDocumentData(null, this.RNK, this.AgrID, this.EAStructID, this.ReqID);
                List<Bars.EAD.Structs.Result.DocumentData> docs = new List<Bars.EAD.Structs.Result.DocumentData>();
                
                foreach (Bars.EAD.Structs.Result.DocumentData a in docs_ea )
                {
                    if (do_list.Contains(a.Struct_Code))
                    docs.Add(a);
                }
                
                lvDocs.DataSource = docs;
                lvDocs.DataBind();
            }
            else
            {
               List<Bars.EAD.Structs.Result.DocumentData> docs = Bars.EAD.EADService.GetDocumentData(null, this.RNK, this.AgrID, this.EAStructID, this.ReqID);
               lvDocs.DataSource = docs;
               lvDocs.DataBind();
            }

           }
        catch (Exception ex)
        {
            String ErrorText = "Виникли помилки при отриманні відповіді від ЕА: Message = " + ex.Message + "; StackTrace = " + ex.StackTrace;
            Decimal RecID = _dbLogger.Error(ErrorText.Length > 3000 ? ErrorText.Substring(0, 3000) : ErrorText);

            //ScriptManager.RegisterStartupScript(this, this.GetType(), "ead_errors", String.Format("alert('Виникли помилки при отриманні відповіді від ЕА. Номер запису в журналі аудиту {0}'); ", RecID), true);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "ead_errors", String.Format("window.alert('{0}.  Номер запису в журналі аудиту {1}'); ", ex.Message.Replace("'", null).Replace("\r\n", null), RecID), true);  // alert не показывалсо с '  \r\n
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ead_errors", String.Format("core$ErrorBox('{0}.  Номер запису в журналі аудиту {1}', 'Помилка отримання документів з ЕА')", ex.Message.Replace("'", null).Replace("\r\n", null), RecID), true);  // alert не показывалсо с '  \r\n


        }

        // пока нам єто не нужно!
        btDocViewed.Visible = false;
    }
    # endregion
}