using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Globalization;
using System.Threading;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Document : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        decimal Ref = Convert.ToDecimal(Request.Params.Get("ref"));

        InitOraConnection(Context);
        try
        {
            SetRole(Resources.documentview.Global.AppRole);

            // вычитка данных
            ClearParameters();
            SetParameters("pref", DB_TYPE.Decimal, Ref, DIRECTION.Input);
            DataTable dt = SQL_SELECT_dataset(@"SELECT	s.MFOA as MFOA, s.ID_A as ID_A, s.ID_B as ID_B, 
												        s.NLSA as NLSA, s.MFOB as MFOB, s.NLSB as NLSB, 
												        s.S/power(10,v1.DIG) as S, 
												        nvl(s.S2/power(10,v2.DIG), s.S/power(10,v1.DIG)) as S2, 
												        s.ND as ND, s.NAM_A as NAM_A, s.NAM_B as NAM_B, 
												        s.NAZN as NAZN, s.DATD as DATD, to_char(s.VDAT,'dd.mm.yyyy') as VDAT, 
												        s.DK as DK, v1.LCV as LCV_A, nvl(v2.LCV,v1.LCV) as LCV_B, 
												        vb.NAME as NAME, bnk1.NB as NB_A, bnk2.NB as NB_B, 
												        F_SumPr(s.S,v1.KV,'F',2) as SUMPR, 
												        v1.DIG as DIG_A, nvl(v2.DIG,v1.DIG) as DIG_B 
												    FROM	OPER s, TABVAL v1, TABVAL v2, 
														VOB vb, BANKS bnk1, BANKS bnk2 
												    WHERE	REF = :pref and s.KV = v1.KV 
														and s.KV2 = v2.KV(+) 
														and vb.VOB = s.VOB 
														and s.MFOA = bnk1.MFO 
														and s.MFOB = bnk2.MFO").Tables[0];

            // заполняем поля
            bool NoFlip = (Convert.ToInt32(dt.Rows[0]["DK"]) == 1 || Convert.ToInt32(dt.Rows[0]["DK"]) == 3);

            // МФО
            edMfoA.Value = (NoFlip) ? (Convert.ToString(dt.Rows[0]["MFOA"])) : (Convert.ToString(dt.Rows[0]["MFOB"]));
            edMfoB.Value = (NoFlip) ? (Convert.ToString(dt.Rows[0]["MFOB"])) : (Convert.ToString(dt.Rows[0]["MFOA"]));

            // ОКПО
            edSendreOKPO.Value = (NoFlip) ? (Convert.ToString(dt.Rows[0]["ID_A"])) : (Convert.ToString(dt.Rows[0]["ID_B"]));
            edReceiverOKPO.Value = (NoFlip) ? (Convert.ToString(dt.Rows[0]["ID_B"])) : (Convert.ToString(dt.Rows[0]["ID_A"]));

            // Cчета
            edAccA.Value = (NoFlip) ? (Convert.ToString(dt.Rows[0]["NLSA"])) : (Convert.ToString(dt.Rows[0]["NLSB"]));
            edAccB.Value = (NoFlip) ? (Convert.ToString(dt.Rows[0]["NLSB"])) : (Convert.ToString(dt.Rows[0]["NLSA"]));

            // Суммы(отличаются если суммы в разной валюте)
            edSumA.Value = (NoFlip) ? (Convert.ToDouble(dt.Rows[0]["S"]).ToString(GetNFormat(dt.Rows[0]["DIG_A"]))) : (Convert.ToDouble(dt.Rows[0]["S2"]).ToString(GetNFormat(dt.Rows[0]["DIG_B"])));
            edSumB.Value = (NoFlip) ? (Convert.ToDouble(dt.Rows[0]["S2"]).ToString(GetNFormat(dt.Rows[0]["DIG_B"]))) : (Convert.ToDouble(dt.Rows[0]["S"]).ToString(GetNFormat(dt.Rows[0]["DIG_A"])));

            // Названия
            string strFaceNum = Convert.ToString(dt.Rows[0]["ND"]);

            lbSender.InnerText = (NoFlip) ? (Convert.ToString(dt.Rows[0]["NAM_A"])) : (Convert.ToString(dt.Rows[0]["NAM_B"]));
            lbReceiver.InnerText = (NoFlip) ? (Convert.ToString(dt.Rows[0]["NAM_B"])) : (Convert.ToString(dt.Rows[0]["NAM_A"]));

            lbBankA.InnerText = (NoFlip) ? (Convert.ToString(dt.Rows[0]["NB_A"])) : (Convert.ToString(dt.Rows[0]["NB_B"]));
            lbBankB.InnerText = (NoFlip) ? (Convert.ToString(dt.Rows[0]["NB_B"])) : (Convert.ToString(dt.Rows[0]["NB_A"]));

            lbDetails.InnerText = Convert.ToString(dt.Rows[0]["NAZN"]);
            lbSumPr.InnerText = Convert.ToString(dt.Rows[0]["SUMPR"]);

            Thread.CurrentThread.CurrentCulture = (CultureInfo)Thread.CurrentThread.CurrentUICulture.Clone();
            // Даты
            lbDocDate.InnerText = Resources.documentview.GlobalResource.labOt + Convert.ToDateTime(dt.Rows[0]["DATD"]).ToString("D");
            edValueDate.Value = Convert.ToString(dt.Rows[0]["VDAT"]);

            // Заголовок документа
            lbDoctitle.InnerText = Resources.documentview.GlobalResource.DOKUMENTLabel;
            if (Convert.ToInt32(dt.Rows[0]["DK"]) == 2) lbDoctitle.InnerText = Resources.documentview.GlobalResource.INFORMACIONYIZAPROSLabel.ToUpper();
            else if (Convert.ToInt32(dt.Rows[0]["DK"]) > 2) lbDoctitle.InnerText = Resources.documentview.GlobalResource.INFORMACIONOESOOSBSENIELabel.ToUpper();
            lbDoctitle.InnerText += Convert.ToString(dt.Rows[0]["NAME"]).ToUpper() + " №" + Convert.ToString(dt.Rows[0]["ND"]);

            // Валюты
            edCcyA.Value = (NoFlip) ? (Convert.ToString(dt.Rows[0]["LCV_A"])) : (Convert.ToString(dt.Rows[0]["LCV_B"]));
            edCcyB.Value = (NoFlip) ? (Convert.ToString(dt.Rows[0]["LCV_B"])) : (Convert.ToString(dt.Rows[0]["LCV_A"]));

            //Если валюти совпадают, то выводим только одну
            if (edCcyB.Value == edCcyA.Value)
            {
                edCcyB.Visible = false;
                edSumB.Visible = false;
                lbCcyB.Visible = false;
                lbSumB.Visible = false;
            }
        }
        finally
        {
            DisposeOraConnection();
        }

    }
    /// <summary>
    /// Возвращает подходящий нам формат числа
    /// </summary>
    /// <param name="DigCount">К-во знаков после запятой</param>
    private string GetNFormat(object DigCount)
    {
        string res = "### ### ### ### ### ### ##0.";
        for (int i = 0; i < Convert.ToInt32(DigCount); i++) res += "0";

        return res;
    }
    /// <summary>
    /// Возвращает месяц прописью 
    /// </summary>
    /// <param name="Mounth">задает номер месяца (1-12)</param>
    /// <returns>месяц прописью или пустую строку если Mounth 
    /// выходит из допустимого диапазона</returns>
    private string GetMounthPr(int Mounth)
    {
        string[] Mon = { "января", "февраля", "марта", "апреля", "мая", "июня", "июля", "августа", "сентября", "октября", "ноября", "декабря" };
        if (Mounth >= 1 && Mounth <= 12) return (Mon[Mounth - 1]);
        else return "";
    }
}
