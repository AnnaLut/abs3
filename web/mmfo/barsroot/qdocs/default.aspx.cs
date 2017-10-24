﻿using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Web.Caching;
using System.Collections.Generic;
using System.Web.Script.Serialization;

enum Severity { Error, Warning, Info}
 // <summary>
/// Класс для работы с кешированными данными
/// </summary>
public sealed class StaticData : Bars.BarsPage
{
    string f_key;
    public StaticData(string key)
    {
        if (key != "Params" && key != "snrTable")
            throw new ArgumentException("Недопустимое имя параметра для конструктора класса StaticData");
        f_key = key;
    }
    private DataTable GetDataFromDb()
    {
        InitOraConnection();
        try
        {
            SetRole(Resources.qdocs.GlobalResources.RoleName);
            switch (f_key)
            {
                case "snrTable" :
                    return SQL_SELECT_dataset("select k_rk, n_rk from s_nr where k_rk in ('!','*','-','+','?')").Tables[0];
                case "Params":            
                    return SQL_SELECT_dataset("select par, val from params where par in ('INFDB_OP', 'INFKR_OP')").Tables[0];
                default: return null;
            }
        }
        finally
        {
            DisposeOraConnection();
        }
    }
    public DataTable GetCachedData()
    {
        Cache cache = System.Web.HttpContext.Current.Cache;
        DataTable table = (DataTable)cache[f_key];
        if (null == table)
        {
            table = GetDataFromDb();
            cache.Add(
                f_key,
                table,
                null, // CacheDependency
                Cache.NoAbsoluteExpiration,
                Cache.NoSlidingExpiration,
                CacheItemPriority.Normal,
                null // CacheItemRemovedCallback
            );
        }
        return table;
    }
}

/// <summary>
/// Класс веб-формы
/// </summary>
public partial class Qdocs : Bars.BarsPage
{

    #region События формы
    protected void Page_Init(object sender, EventArgs e)
    {
		//заполнить параметры datasource
		ds_n.DataBind();
		gv.DataBind();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        #region Обрабока ответа от формы ввода
        //если в запросе есть параметр rrp_rec - удалить документ
        if (null != Request["rrp_rec"])
        {
            decimal rec = 0;
            try
            {
                rec = Convert.ToDecimal(Request["rrp_rec"]);
            }
            catch (FormatException)
            { 
                //Невозможно получить информацию о введенном документе. Обратитесь к администратору
                showMessage(lblMsg1.Text, Severity.Error);
            }
            deleteInfoQuery(rec);
        }
    }
	#endregion
	protected void toolBar_Command(object sender, CommandEventArgs e)
    {
        decimal infoRef = 0;
        #region Получениe референса СЭП из GridView

        foreach (GridViewRow gr in gv.Rows)
        {
            CheckBox chk = (CheckBox)gr.FindControl("chkSelect");
            if (chk == null) continue;
            if (!chk.Checked) continue;
            infoRef = Convert.ToDecimal(gv.DataKeys[gr.RowIndex]["rec"].ToString());
            break;
        }
        if (0 == infoRef && "RefreshDoc"!=e.CommandName)
        {   //Необходимо выбрать информационный запрос
            showMessage(lblMsg10.Text, Severity.Error);
            return;
        }
        #endregion

        switch (e.CommandName)
        {
            case "OpenDoc":
            case "BackDoc":
                DataRow infoDoc = null;
                DataRow baseDoc = null;
                getRrpDocs(infoRef, out baseDoc, out infoDoc);
                if (null == infoDoc)
                    //Не обнаружено информационного запроса с референсом {0} 
                    showMessage(String.Format(lblMsg9.Text, infoRef), Severity.Error);
                else
                {
                    //для безусловного возврата документа моделируем расхождение реквизитов в документах
                    //и передаем обработчику - он интерпритирует это так как нужно
                    if ("BackDoc" == e.CommandName)
                        infoDoc["kv"]="-1";
                    handleQdocs(infoDoc, baseDoc, "BackDoc"==e.CommandName);
                }
                break;
            case "DeleteDoc":
                deleteInfoQuery(infoRef);
                gv.DataBind();
                break;
            case "RefreshDoc":
                gv.DataBind();
                break;
        }
    }
    protected void gv_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            CheckBox chk = (CheckBox)e.Row.FindControl("chkSelect");
            if (chk != null)
            {
                chk.Attributes.Add("onclick", "SelectRow()");
            }
            e.Row.Attributes.Add("onclick", "SelectRow()");
        }
    }
	protected void gv_V_RowDataBound(object sender, GridViewRowEventArgs e)
	{
		if (e.Row.RowType == DataControlRowType.DataRow)
		{

			var objJson = new Dictionary<string, object>
				{
					{"REC", getJsonMapping(e.Row.DataItem, "REC")},
					{"DATD", getJsonMapping(e.Row.DataItem, "DATD")},
					{"DK", getJsonMapping(e.Row.DataItem, "DK")},
					{"MFOA", getJsonMapping(e.Row.DataItem, "MFOA")},
					{"NLSA", getJsonMapping(e.Row.DataItem, "NLSA")},
					{"KV", getJsonMapping(e.Row.DataItem, "KV")},
					{"ID_A", getJsonMapping(e.Row.DataItem, "ID_A")},
					{"NAM_A", getJsonMapping(e.Row.DataItem, "NAM_A")},
					{ "S", getJsonMapping(e.Row.DataItem, "S")},
					{"NLSB", getJsonMapping(e.Row.DataItem, "NLSB")},
					{ "ID_B", getJsonMapping(e.Row.DataItem, "ID_B")},
					{"NAM_B", getJsonMapping(e.Row.DataItem, "NAM_B")},
					{"OSTC", getJsonMapping(e.Row.DataItem, "OSTC")},
					{"FN_A", getJsonMapping(e.Row.DataItem, "FN_A")},
					{"DAT_A", getJsonMapping(e.Row.DataItem, "DAT_A")}
				};
			e.Row.Attributes.Add("rd", new JavaScriptSerializer().Serialize(objJson));
		}
	}

	protected void gv_V_PageIndexChanging(object sender, GridViewPageEventArgs e)
	{
		gv.PageIndex = e.NewPageIndex;
		gv.DataBind();
	}

	protected void gv_V_PreRender(object sender, EventArgs e)
	{
		gv.DataBind();
	}
	private object getJsonMapping(object dataItem, string sourceField)
	{
		var obj = DataBinder.Eval(dataItem, sourceField);
		if (obj is DateTime)
			obj = (obj == DBNull.Value || Convert.ToString(obj) == "") ? ("") : (Convert.ToDateTime(obj).ToString("dd/MM/yyyy"));

		return obj;
	}

	#endregion

	#region Закрытые методы класса

	/// <summary>
	/// Обработка базового документа и информационного запроса
	/// </summary>
	/// <param name="infoDoc">информационный запрос</param>
	/// <param name="baseDoc">первичный документ</param>
	private void handleQdocs(DataRow infoDoc, DataRow baseDoc, bool directReturn)
    {
        string currType = String.Empty;
        byte dK = 0;

        #region Анализ информационного запроса

        //базовый документ найден
        if (null != baseDoc)
        {
            //если не совпадает один из обязательных реквизитов
            //формируется сообщение о требовании возврата документа
            if (0 != String.Compare(infoDoc["mfoa"].ToString(), baseDoc["mfob"].ToString()) ||
                0 != String.Compare(infoDoc["mfob"].ToString(), baseDoc["mfoa"].ToString()) ||
                0 != String.Compare(infoDoc["nlsb"].ToString(), baseDoc["nlsa"].ToString()) ||
                0 != String.Compare(infoDoc["s"].ToString(), baseDoc["s"].ToString()) ||
                0 != String.Compare(infoDoc["vob"].ToString(), baseDoc["vob"].ToString()) ||
                0 != String.Compare(infoDoc["nd"].ToString(), baseDoc["nd"].ToString()) ||
                0 != String.Compare(infoDoc["kv"].ToString(), baseDoc["kv"].ToString()) ||
                0 != String.Compare(infoDoc["datp"].ToString(), baseDoc["datp"].ToString()) ||
                0 != String.Compare(infoDoc["datd"].ToString(), baseDoc["datd"].ToString()) ||
                0 != String.Compare(infoDoc["id_b"].ToString(), baseDoc["id_a"].ToString()))/* ||
                (0 != String.Compare(infoDoc["id_a"].ToString(), baseDoc["id_b"].ToString()) && 
                  0 != String.Compare(infoDoc["nlsa"].ToString(), baseDoc["nlsb"].ToString()) ))*/
            {
                currType = "-";
                dK = 2;
            }
            else
            {
                dK = 3;
                currType = "?";
            }
        }
        //не найден документ, на который получен запрос
        else
        {
            currType = "*";
            dK = 3;
        }

        #endregion

        //подготовить доп. реквизит ответа
        string dRec = infoDoc["d_rec"].ToString();

        if (dRec.Length != 21)
        {
            //Информационное сообщение содержит некорректный доп. реквизит СЭП: {0}
            showMessage(String.Format(lblMsg8.Text,dRec), Severity.Error);
            return;
        }

        if ("*" == currType || "-" == currType)
           dRec = dRec.Replace("?", currType);

        //название файла А из доп реквизита
        string fnA = dRec.Substring(2, 12);
        //номер строки в файле А
        string recA = dRec.Substring(14, 6);

        //даты
        DateTime datD;
        DateTime datP;

        #region Получение параметров

        //список назначения платежа для информационных запросов
        string nazn = String.Empty;
        StaticData snrTable = new StaticData("snrTable");
        DataRow[] rows = snrTable.GetCachedData().Select(String.Format("k_rk='{0}'", currType));
        if (0 != rows.Length)
        {
            nazn = rows[0]["n_rk"].ToString();
        }
        else
        {
            //не обнаружено назначение платежа
            showMessage(String.Format(lblMsg2.Text,currType),Severity.Error);
            return;
        }

        //операции информационного дебета и кредита
        string TT_dk2 = String.Empty;
        string TT_dk3 = String.Empty;
        StaticData pars = new StaticData("Params");
        rows = pars.GetCachedData().Select();
        foreach (DataRow row in rows)
        {
            switch (row["par"].ToString())
            {
                case "INFDB_OP":
                    TT_dk2 = row["val"].ToString();
                    break;
                case "INFKR_OP":
                    TT_dk3 = row["val"].ToString();
                    break;
            }
        }
        if (String.Empty == TT_dk2 || String.Empty == TT_dk3)
        {
            showMessage(lblMsg3.Text,Severity.Error);
            return;
        }

        #endregion

        #region Формирование URL для создания документа

        // Наличие параметра qdoc говорит форме ввода о том, 
        // что нужно поднять документ полностью из данного URL.
        // Значение параметра qdoc - это тип документа. 
        // Тип обрабатывается формой ввода в случае, если нужно 
        // провести доп. манипуляции с данным документом.
        // Тип указывается в произвольной форме.
        string url = string.Empty;
        switch (currType)
        {
            case "*":

                datD = Convert.ToDateTime(infoDoc["datd"].ToString());
                datP = Convert.ToDateTime(infoDoc["datp"].ToString());

                url = 
                    "/barsroot/docinput/docinput.aspx" +
                    "?qdoc=" + HttpUtility.UrlEncode(currType) +
                    "&rrp_rec=" + infoDoc["rec"].ToString()+
                    "&tt=" + HttpUtility.UrlEncode(((dK==2)? TT_dk2 : TT_dk3)) +
                    "&mfo_a=" + infoDoc["mfob"].ToString() +
                    "&nls_a=" + infoDoc["nlsb"].ToString() +
                    "&mfo_b=" + infoDoc["mfoa"].ToString() +
                    "&nls_b=" + infoDoc["nlsa"].ToString() +
                    "&SumC=" + Convert.ToDecimal(infoDoc["s"].ToString()) / 100 +
                    "&docN=" + HttpUtility.UrlEncode(infoDoc["nd"].ToString()) +
                    "&vob=" + HttpUtility.UrlEncode(infoDoc["vob"].ToString()) +
                    "&kv_a=" + infoDoc["kv"].ToString() +
                    "&kv_b=" + infoDoc["kv"].ToString() +
                    "&datd=" + HttpUtility.UrlEncode(datD.ToString("dd/MM/yyyy").Replace(".", "/")) +
                    "&datp=" + HttpUtility.UrlEncode(datP.ToString("dd/MM/yyyy").Replace(".", "/")) +
                    "&nam_a=" + HttpUtility.UrlEncode(infoDoc["nam_b"].ToString()) +
                    "&nam_b=" + HttpUtility.UrlEncode(infoDoc["nam_a"].ToString()) +
                    "&nazn=" + HttpUtility.UrlEncode(nazn) +
                    "&drec_" + HttpUtility.UrlEncode(currType) + "=" + HttpUtility.UrlEncode(dRec) +
                    "&id_a=" + infoDoc["id_b"].ToString() +
                    "&id_b=" + infoDoc["id_a"].ToString();
                break;
            case "?":
            case "-":

                datD = Convert.ToDateTime(baseDoc["datd"].ToString());
                datP = Convert.ToDateTime(baseDoc["datp"].ToString());

                url =
                    "/barsroot/docinput/docinput.aspx" +
                    "?qdoc=" + HttpUtility.UrlEncode(currType) +
                    "&rrp_rec=" + infoDoc["rec"].ToString() +
                    "&tt=" + HttpUtility.UrlEncode((dK == 2) ? TT_dk2 : TT_dk3) +
                    "&mfo_a=" + baseDoc["mfoa"].ToString() +
                    "&nls_a=" + baseDoc["nlsa"].ToString() +
                    "&mfo_b=" + baseDoc["mfob"].ToString() +
                    "&nls_b=" + baseDoc["nlsb"].ToString() +
                    "&SumC=" + Convert.ToString(Convert.ToDecimal(infoDoc["s"].ToString()) / 100) +
                    "&docN=" + HttpUtility.UrlEncode(baseDoc["nd"].ToString()) +
                    "&vob=" + HttpUtility.UrlEncode(baseDoc["vob"].ToString()) +
                    "&kv_a=" + baseDoc["kv"].ToString() +
                    "&kv_b=" + baseDoc["kv"].ToString() +
                    "&datd=" + HttpUtility.UrlEncode(datD.ToString("dd/MM/yyyy").Replace(".", "/")) +
                    "&datp=" + HttpUtility.UrlEncode(datP.ToString("dd/MM/yyyy").Replace(".", "/")) +
                    "&nam_a=" + HttpUtility.UrlEncode(baseDoc["nam_a"].ToString()) +
                    "&nam_b=" + HttpUtility.UrlEncode(baseDoc["nam_b"].ToString()) +
                    "&nazn=" + HttpUtility.UrlEncode(nazn) +
                    "&drec_"+ HttpUtility.UrlEncode(currType)+"="+ HttpUtility.UrlEncode(dRec) +
                    "&id_a=" + baseDoc["id_a"].ToString() +
                    "&id_b=" + baseDoc["id_b"].ToString();
                break;
        }
        #endregion
        
        // если заранее известно что в документе не так - выдать диалог
        // и перейти в форму ввода
        if  ("*" == currType || ("-" == currType&&!directReturn))
        {
            string msg = currType == "*" ? String.Format(lblMsg4.Text, fnA, recA) : lblMsg5.Text;
            Hashtable ht = new Hashtable();
            
            ht.Add("Сancel", "/barsroot/qdocs/default.aspx");
            ht.Add("Оk ", url);
            
            Session.Add("dlg_buttons", ht);
            Session.Add("dlg_text",msg);
            Session.Add("dlg_title", lblMsg6.Text);
            Response.Redirect("qdialog.aspx");
            return;
        }
        //переход на форму ввода
        Response.Redirect(url);
        
    }

    private void getRrpDocs(decimal infoRef, out DataRow baseDoc, out DataRow infoDoc)
    {
        baseDoc = null;
        infoDoc = null;

        InitOraConnection();
        try
        {
            SetRole(Resources.qdocs.GlobalResources.RoleName);

            #region Получение записи информационного запроса

            ClearParameters();
            SetParameters("rec", DB_TYPE.Decimal, infoRef, DIRECTION.Input);
            DataTable table = SQL_SELECT_dataset("select * from arc_rrp where rec=:rec").Tables[0];
            if (table.Rows.Count > 0)
                infoDoc = table.Rows[0];

            #endregion

            #region Получение записи исходного документа

            //доп.реквизит в котором указан файл А и номер строки
            string dRec = infoDoc["d_rec"].ToString();
            //название файла А из доп реквизита
            string fnA = dRec.Substring(2, 12);
            //номер строки в файле А
            decimal recA = 0;
            try
            {
                recA = Convert.ToDecimal(dRec.Substring(14, 6));
            }
            catch (FormatException)
            {
                showMessage(String.Format("Error parsing $A line number in addintional property of information query ({0})", dRec), Severity.Error);
                return;
            }
            ClearParameters();
            SetParameters("fn_a", DB_TYPE.Varchar2, fnA, DIRECTION.Input);
            SetParameters("rec_a", DB_TYPE.Decimal, recA, DIRECTION.Input);
            table = SQL_SELECT_dataset(
                 @"select * 
                     from arc_rrp 
                    where fn_b=:fn_a 
                      and rec_b=:rec_a
                      and dat_b >= add_months(bankdate_g,-1)").Tables[0];
            //есть соответствующий документ
            if (table.Rows.Count > 0)
                baseDoc = table.Rows[0];

            #endregion;

        }
        finally
        {
            DisposeOraConnection();
        }
    }

    private void deleteInfoQuery(decimal rec)
    {
        if (0 == rec) return;
        InitOraConnection();
        try
        {
            SetRole(Resources.qdocs.GlobalResources.RoleName);
            ClearParameters();
            SetParameters("p_rec", DB_TYPE.Decimal, rec, DIRECTION.Input);
            SQL_NONQUERY("delete from tzapros where rec=:p_rec");
            Commit();
        }
        finally
        {
            DisposeOraConnection();
        }
    }

    /// <summary>
    /// Отображает текст в левом верхнем углу грида
    /// Используется для вывода сообщений 
    /// </summary>
    /// <param name="msgText">Текст сообщения</param>
    private void showMessage(string msgText, Severity msgSeverity)
    {
        Label lblMsg = new Label();
        lblMsg.Text = msgText;
        switch (msgSeverity)
        {
            case Severity.Error: lblMsg.CssClass = "MsgError";
                break;
            case Severity.Warning: lblMsg.CssClass = "MsgWarning";
                break;
            case Severity.Info: lblMsg.CssClass = "MsgInfo";
                break;
        }
        placeHolder.Controls.Add(lblMsg);
    }

    protected void btnReturnDoc_Init(object sender, EventArgs e)
    {
        //Сформировать запрос на возврат документа?
        btnReturnDoc.OnClientClick = "if (!confirm(\""+lblMsg7.Text+"\")) return false;";
    }
    protected void btnDeleteDoc_Init(object sender, EventArgs e)
    {
        //Удалить информационное сообщение?
        btnDeleteDoc.OnClientClick = "if (!confirm(\"" + btnDeleteDoc.Text + "?\")) return false;";
    }
    #endregion

}


