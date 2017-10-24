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

using Oracle.DataAccess.Types;

public partial class Visa : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        decimal Ref = Convert.ToDecimal(Request.Params.Get("ref"));

        DataTable dtData = new DataTable();
        DataTable dtSystemParams = new DataTable();

        InitOraConnection(Context);
        try
        {
            SetRole(Resources.documentview.Global.AppRole);

            // проверка доступности документа
            // выборка данных
            ClearParameters();
            SetParameters("pref", DB_TYPE.Decimal, Ref, DIRECTION.Input);
            dtData = SQL_SELECT_dataset(@"	SELECT MARK, CHECKGROUP, USERNAME, DAT, MARKID 
												    FROM V_VISALIST 
												    WHERE REF = :pref 
												    ORDER by Counter, Sqnc").Tables[0];

            // выборка параметров подписи
            dtSystemParams = SQL_SELECT_dataset(@"SELECT chk.get_SignLng as SIGNLNG, 
                                                                 docsign.getIdOper as DOCKEY, 
                                                                 to_char(web_utl.get_bankdate, 'yyyy/MM/dd hh:mm:ss') as BDATE, 
                                                                 (SELECT NVL( min(to_number(VAL)), 1 ) FROM PARAMS WHERE PAR = 'SEPNUM') as SEPNUM, 
                                                                 (SELECT NVL( min(val), 'NBU' ) FROM PARAMS WHERE PAR = 'SIGNTYPE') as SIGNTYPE, 
                                                                 (SELECT NVL( min(to_number(VAL)), 1 ) FROM PARAMS WHERE PAR = 'VISASIGN') as VISASIGN, 
                                                                 (SELECT NVL( min(to_number(VAL)), 1 ) FROM PARAMS WHERE PAR = 'INTSIGN') as INTSIGN, 
                                                                 (select nvl(val,'00') from params where par='REGNCODE') as REGNCODE
                                                          FROM dual").Tables[0];

            // добавляем колонки буфферов
            dtData.Columns.Add("SIGN_FLAG", typeof(string));
            dtData.Columns.Add("BUFINT", typeof(string));
            // колонки для отображения значков проверки подписи
            dtData.Columns.Add("INTSIGN", typeof(string));

            for (int Lev = 0; Lev < dtData.Rows.Count; Lev++)
                if (Convert.ToInt32(dtData.Rows[Lev]["MARKID"]) != 4)
                {
                    ClearParameters();
                    SetParameters("pRef", DB_TYPE.Decimal, Ref, DIRECTION.Input);
                    SetParameters("pLev", DB_TYPE.Decimal, Lev, DIRECTION.Input);
                    SetParameters("FSign", DB_TYPE.Int32, 1, DIRECTION.InputOutput);
                    SetParameters("IntBuff", DB_TYPE.Varchar2, "".PadRight(2000, 't'), DIRECTION.InputOutput);
                    SetParameters("ExtBuff", DB_TYPE.Varchar2, "".PadRight(2000, 't'), DIRECTION.InputOutput);

                    SQL_PROCEDURE("CHK.getVisaBuffersForCheck");

                    dtData.Rows[Lev]["SIGN_FLAG"] = Convert.ToString(GetParameter("FSign"));
                    dtData.Rows[Lev]["BUFINT"] = Convert.ToString(GetParameter("IntBuff"));

                    dtData.Rows[Lev]["INTSIGN"] = "<img alt='Int Sign Check' title='" + Resources.documentview.GlobalResource.labProverkaVnutreneiPodpisi + "' height='20px' width='20px' src='/Common/Images/CheckSign.gif' onclick='CheckIntSign(" + Lev + ")' style='cursor: hand' />";
                }
                else
                {
                    dtData.Rows[Lev]["SIGN_FLAG"] = "";
                    dtData.Rows[Lev]["BUFINT"] = "";

                    dtData.Rows[Lev]["INTSIGN"] = "";
                }

            // вычитываем внешний буффер
            ClearParameters();
            SetParameters("pRef", DB_TYPE.Decimal, Ref, DIRECTION.Input);
            SetParameters("pLev", DB_TYPE.Decimal, 0, DIRECTION.Input);
            SetParameters("FSign", DB_TYPE.Int32, 1, DIRECTION.InputOutput);
            SetParameters("IntBuff", DB_TYPE.Varchar2, "".PadRight(2000, 't'), DIRECTION.InputOutput);
            SetParameters("ExtBuff", DB_TYPE.Varchar2, "".PadRight(2000, 't'), DIRECTION.InputOutput);

            SQL_PROCEDURE("CHK.getVisaBuffersForCheck");

            EXTSIGNBUFF.Value = Convert.ToString(GetParameter("ExtBuff"));
            if ( ((OracleString)GetParameter("ExtBuff")).IsNull ) EXTSIGNBUFF.Value = "0";
        }
        finally
        {
            DisposeOraConnection();
        }

        // берем локализированую пометки
        for (int i = 0; i < dtData.Rows.Count; i++)
        {
            switch (Convert.ToInt32(dtData.Rows[i]["MARKID"]))
            {
                case 0: dtData.Rows[i]["MARK"] = Resources.documentview.GlobalResource.labVvelDokument;
                    break;
                case 1: dtData.Rows[i]["MARK"] = Resources.documentview.GlobalResource.labViziroval;
                    break;
                case 2: dtData.Rows[i]["MARK"] = Resources.documentview.GlobalResource.labOplatil;
                    break;
                case 3: dtData.Rows[i]["MARK"] = Resources.documentview.GlobalResource.labStorniroval;
                    break;
                case 4: dtData.Rows[i]["MARK"] = Resources.documentview.GlobalResource.labOgidaet;
                    break;
            }
        }

        // наполняем даными
        grdData.DataSource = dtData;
        grdData.DataBind();

        // разукрашиваем рядки
        for (int i = 0; i < dtData.Rows.Count; i++)
        {
            switch (Convert.ToInt32(dtData.Rows[i]["MARKID"]))
            {
                case 0: grdData.Rows[i].Style.Add("color", "DarkBlue");
                    break;
                case 1: grdData.Rows[i].Style.Add("color", "Black");
                    break;
                case 2: grdData.Rows[i].Style.Add("color", "Black");
                    break;
                case 3: grdData.Rows[i].Style.Add("color", "Red");
                    break;
                case 4: grdData.Rows[i].Style.Add("color", "Green");
                    break;
            }
        }

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
