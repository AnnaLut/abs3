using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserControls_dialogs_EADocsView : System.Web.UI.Page
{
    # region Публичные свойства
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
    public Int64 RNK
    {
        get
        {
            return Convert.ToInt64(Request.Params.Get("rnk"));
        }
    }
    /// <summary>
    /// Ид. сделки
    /// </summary>
    public Int64? AgrID
    {
        get
        {
            if (String.IsNullOrEmpty(Request.Params.Get("agr_id")))
                return (Int64?)null;

            return Convert.ToInt64(Request.Params.Get("agr_id"));
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        // Получаем перечень документов из ЕА
    
        try
        {
            if (this.EAStructID == 1)
            {
                short[] do_list = new short[] { 111, 112, 113, 114, 115, 116, 117, 118, 119, 1110, 1111, 121, 122, 13, 142, 145, 147, 401 };
                /*
                List<Bars.EAD.Structs.Result.DocumentData> docs = new List<Bars.EAD.Structs.Result.DocumentData>();
                foreach (short element in do_list)
                {
                    docs.AddRange(Bars.EAD.EADService.GetDocumentData(null, this.RNK, this.AgrID, element));
                }
                */
                List<Bars.EAD.Structs.Result.DocumentData> docs_ea = Bars.EAD.EADService.GetDocumentData(null, this.RNK, this.AgrID, this.EAStructID);
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
               List<Bars.EAD.Structs.Result.DocumentData> docs = Bars.EAD.EADService.GetDocumentData(null, this.RNK, this.AgrID, this.EAStructID);
               lvDocs.DataSource = docs;
               lvDocs.DataBind();
            }

           }
        catch (System.Exception ex)
        {
            String ErrorText = "Виникли помилки при отриманні відповіді від ЕА: Message = " + ex.Message + "; StackTrace = " + ex.StackTrace;
            Decimal RecID = Bars.Logger.DBLogger.Error(ErrorText.Length > 3000 ? ErrorText.Substring(0, 3000) : ErrorText);

            ScriptManager.RegisterStartupScript(this, this.GetType(), "ead_errors", String.Format("alert('Виникли помилки при отриманні відповіді від ЕА. Номер запису в журналі аудиту {0}'); ", RecID), true);
        }

        // пока нам єто не нужно!
        btDocViewed.Visible = false;
    }
    # endregion
}