﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using BarsWeb.Core.Logger;
using System.Data;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
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
    public String EAStructID
    {
        get
        {
            var a = Request.Params.Get("eas_id");
            return string.IsNullOrWhiteSpace(a) ? "" : a.ToString();
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

    /// <summary>
    /// doc_id
    /// </summary>
    public String DocId
    {
        get
        {
            if (String.IsNullOrEmpty(Request.Params.Get("doc_id")))
                return String.Empty;

            return Convert.ToString(Request.Params.Get("doc_id"));
        }
    }

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            cmd.Parameters.Clear();
            cmd.CommandText = "SELECT  sys_context('bars_context','user_mfo')  FROM dual";
            cmd.CommandType = CommandType.Text;
            string KF = Convert.ToString(cmd.ExecuteScalar());
            if (this.EAStructID == "1" && string.IsNullOrWhiteSpace(DocId))
            {
                string[] do_list = new string[] { "111", "112", "113", "114", "115", "116", "117", "118", "119", "1110", "1111", "121", "122", "13", "142", "145", "147", "401", "148", "1319", "1115" };

                List<Bars.EAD.Structs.Result.DocumentData> docs_ea = Bars.EAD.EADService.GetDocumentData(null, this.RNK, this.AgrID, this.EAStructID, this.ReqID, null, null, null, null, KF);
                List<Bars.EAD.Structs.Result.DocumentData> docs = new List<Bars.EAD.Structs.Result.DocumentData>();

                foreach (Bars.EAD.Structs.Result.DocumentData a in docs_ea)
                {
                    if (do_list.Contains(a.Struct_Code))
                        docs.Add(a);
                }

                lvDocs.DataSource = docs;
                lvDocs.DataBind();
            }
            else
            {
                String _docId = string.IsNullOrWhiteSpace(DocId) ? null : DocId;

                List<Bars.EAD.Structs.Result.DocumentData> docs = Bars.EAD.EADService.GetDocumentData(_docId, this.RNK, this.AgrID, this.EAStructID, this.ReqID, null, null, null, null, KF);
                lvDocs.DataSource = docs;
                lvDocs.DataBind();
            }

        }
        catch (Exception ex)
        {
            String ErrorText = "Виникли помилки при отриманні відповіді від ЕА: Message = " + ex.Message + "; StackTrace = " + ex.StackTrace;
            Decimal RecID = _dbLogger.Error(ErrorText.Length > 3000 ? ErrorText.Substring(0, 3000) : ErrorText);

            ScriptManager.RegisterStartupScript(this, this.GetType(), "ead_errors", String.Format("alert('Виникли помилки при отриманні відповіді від ЕА. Номер запису в журналі аудиту {0}'); ", RecID), true);
        }

        // пока нам єто не нужно!
        btDocViewed.Visible = false;
    }
    # endregion
}