using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class EDocs : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // референс документа 
        decimal nRef = Convert.ToDecimal(Request.Params.Get("ref"));
        // таблица данных
        DataTable oData = new DataTable();
        // системные параметры
        DataTable dtSystemParams = new DataTable();

        InitOraConnection();
        try
        {
            SetRole(Resources.documentview.Global.AppRole);

            // выборка параметров подписи
            dtSystemParams = SQL_SELECT_dataset(@"SELECT chk.get_SignLng as SIGNLNG, 
                                                                 docsign.getIdOper as DOCKEY, 
                                                                 to_char(web_utl.get_bankdate, 'yyyy/MM/dd hh:mm:ss') as BDATE, 
                                                                 (SELECT NVL( min(to_number(VAL)), 1 ) FROM PARAMS WHERE PAR = 'SEPNUM') as SEPNUM, 
                                                                 (SELECT NVL( min(val), 'NBU' ) FROM PARAMS WHERE PAR = 'SIGNTYPE') as SIGNTYPE, 
                                                                 (SELECT NVL( min(to_number(VAL)), 1 ) FROM PARAMS WHERE PAR = 'VISASIGN') as VISASIGN, 
                                                                 (SELECT NVL( min(to_number(VAL)), 1 ) FROM PARAMS WHERE PAR = 'INTSIGN') as INTSIGN, 
                                                                 (SELECT NVL( min(to_number(VAL)), 1 ) FROM PARAMS WHERE PAR = 'REGNCODE') as REGNCODE
                                                          FROM dual").Tables[0];

            // выборка данных по проводкам
            ClearParameters();
            SetParameters("pref", DB_TYPE.Decimal, nRef, DIRECTION.Input);
            oData = SQL_SELECT_dataset("select '<img alt=\"Int Sign Check\" title=\"" + Resources.documentview.GlobalResource.labProverkaVnutreneiPodpisi + "\" height=\"20px\" width=\"20px\" src=\"/Common/Images/CheckSign.gif\" onclick=\"CheckSign('||ed.DOCID||')\" style=\"cursor: hand\" />' as IMG, "
                                               +@"ed.*, ed.S/power(10, t.dig) as Sdiv 
                                        from V_ALL_EDOCS_BUF ed, TABVAL t where ed.KV = t.KV and ed.REF = :pref order by ed.DOCID").Tables[0];
        }
        finally
        {
            DisposeOraConnection();
        }
        
        // наполняем таблицу
        for (int i = 0; i < oData.Rows.Count; i++)
            oData.Rows[i]["BUFF"] = oData.Rows[i]["BUFF"].ToString().Replace(" ", "&nbsp;");

        if (oData.Rows.Count == 0)
            oData.Rows.Add(oData.NewRow());

        grdData.DataSource = oData;
        grdData.DataBind();
        
        // передаем параметры подписи
        SIGNLNG.Value = Convert.ToString(dtSystemParams.Rows[0]["SIGNLNG"]);
        DOCKEY.Value = Convert.ToString(dtSystemParams.Rows[0]["DOCKEY"]);
        BDATE.Value = Convert.ToString(dtSystemParams.Rows[0]["BDATE"]);
        SEPNUM.Value = Convert.ToString(dtSystemParams.Rows[0]["SEPNUM"]);
        SIGNTYPE.Value = Convert.ToString(dtSystemParams.Rows[0]["SIGNTYPE"]);
        VISASIGN.Value = Convert.ToString(dtSystemParams.Rows[0]["VISASIGN"]);
        INTSIGN.Value = Convert.ToString(dtSystemParams.Rows[0]["INTSIGN"]);
        REGNCODE.Value = Convert.ToString(dtSystemParams.Rows[0]["REGNCODE"]);
    }
}
