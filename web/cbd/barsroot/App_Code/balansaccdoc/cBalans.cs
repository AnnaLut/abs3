using System;
using System.Data;
using System.Globalization;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Bars;

public class Service : BarsWebService
{
    string BalansRole = "web_balans";
    CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
    public Service()
    {
        cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
        cinfo.DateTimeFormat.DateSeparator = "/";
    }

    [WebMethod(EnableSession = true)]
    public string[] GetGlobalData()
    {
        string[] result = new string[3];
        try
        {
            InitOraConnection(Context);
            SetRole(BalansRole);
            DateTime dDat = Convert.ToDateTime(SQL_SELECT_scalar("select bankdate from dual"), cinfo);
            result[0] = dDat.ToString("dd/MM/yyyy");
            SQL_Reader_Exec("select t.tobo, t.name from tobo t where t.tobo=tobopack.gettobo");
            if (SQL_Reader_Read())
            {
                ArrayList list = SQL_Reader_GetValues();
                result[1] = Convert.ToString(list[0]);
                result[2] = Convert.ToString(list[0]) + " " + Convert.ToString(list[1]);
            }
            SQL_Reader_Close();
        }
        finally
        {
            DisposeOraConnection();
        }
        return result;
    }
    
    [WebMethod(EnableSession = true)]
    public object[] GetData(string[] data)
    {
        object[] obj = new object[20];
        try
        {
            InitOraConnection(Context);
            SetRole(BalansRole);

            string sTable = "v_balans_all";
            string sITable = "v_balansi_all";
            string sFilterTobo = "";

            DateTime fdat = Convert.ToDateTime(data[10],cinfo);
            string tobo = data[12];
            if (tobo != "")
            {
                sTable = "v_balans_tobo";
                sITable = "v_balansi_tobo";
                sFilterTobo = "b.tobo like :sTobo||'%' and ";
                SetParameters("sTobo", DB_TYPE.Varchar2, tobo, DIRECTION.Input);
            }

            SetParameters("dDat", DB_TYPE.Date, fdat, DIRECTION.Input);
            object[] oBind = BindTableWithNewFilter("p.sb SB, b.nbs NBS, b.dosr/100 DOSR, b.kosr/100 KOSR," +
                "b.dosq/100 DOS, b.kosq/100 KOS, b.ostd/100 ISD, b.ostk/100 ISK, p.name NAME",
                sTable + " b, ps p",
                sFilterTobo + "b.nbs=p.nbs and b.fdat=:dDat and (b.dosq<>0 or b.kosq<>0 or b.ostd<>0 or b.ostk<>0)", data);
            obj[0] = oBind[0];
            obj[1] = oBind[1];

            ClearParameters();
            if (tobo != "")
            {
                SetParameters("sTobo", DB_TYPE.Varchar2, tobo, DIRECTION.Input);
            }
            SetParameters("dDat", DB_TYPE.Date, fdat, DIRECTION.Input);
            data[3] = "";
            DataSet ds = GetFullDataSetForTable(
                "nvl(sum(decode(b.sb,'B',b.dosr,0))/100,0) iB_Dosr," +
                "nvl(sum(decode(b.sb,'B',b.kosr,0))/100,0) iB_Kosr," +
                "nvl(sum(decode(b.sb,'B',b.dos,0))/100,0) iB_Dos," +
                "nvl(sum(decode(b.sb,'B',b.kos,0))/100,0) iB_Kos," +
                "nvl(sum(decode(b.sb,'B',b.ostd,0))/100,0) iB_OstD," +
                "nvl(sum(decode(b.sb,'B',b.ostk,0))/100,0) iB_OstK," +
                "nvl(sum(decode(b.sb,'M',b.dosr,0))/100,0) iM_Dosr," +
                "nvl(sum(decode(b.sb,'M',b.kosr,0))/100,0) iM_Kosr," +
                "nvl(sum(decode(b.sb,'M',b.dos,0))/100,0) iM_Dos," +
                "nvl(sum(decode(b.sb,'M',b.kos,0))/100,0) iM_Kos," +
                "nvl(sum(decode(b.sb,'M',b.ostd,0))/100,0) iM_OstD," +
                "nvl(sum(decode(b.sb,'M',b.ostk,0))/100,0) im_OstK," +
                "nvl(sum(decode(b.sb,'V',b.dosr,0))/100,0) iV_Dosr," +
                "nvl(sum(decode(b.sb,'V',b.kosr,0))/100,0) iV_Kosr," +
                "nvl(sum(decode(b.sb,'V',b.dos,0))/100,0) iV_Dos," +
                "nvl(sum(decode(b.sb,'V',b.kos,0))/100,0) iV_Kos," +
                "nvl(sum(decode(b.sb,'V',b.ostd,0))/100,0) iV_OstD," +
                "nvl(sum(decode(b.sb,'V',b.ostk,0))/100,0) iV_OstK",
                sITable + " b",
                sFilterTobo + "b.fdat=:dDat", data);
            object[] oBindSum = ds.Tables[0].Rows[0].ItemArray;
            if (oBindSum.Length > 0)
            {
                obj[2] = oBindSum[0];
                obj[3] = oBindSum[1];
                obj[4] = oBindSum[2];
                obj[5] = oBindSum[3];
                obj[6] = oBindSum[4];
                obj[7] = oBindSum[5];
                obj[8] = oBindSum[6];
                obj[9] = oBindSum[7];
                obj[10] = oBindSum[8];
                obj[11] = oBindSum[9];
                obj[12] = oBindSum[10];
                obj[13] = oBindSum[11];
                obj[14] = oBindSum[12];
                obj[15] = oBindSum[13];
                obj[16] = oBindSum[14];
                obj[17] = oBindSum[15];
                obj[18] = oBindSum[16];
                obj[19] = oBindSum[17];
           }
        }
        finally
        {
            DisposeOraConnection();
        }
        return obj;
    }

    [WebMethod(EnableSession = true)]
    public object[] GetDataByIsp(string[] data)
    {
        try
        {
            InitOraConnection(Context);
            SetRole(BalansRole);

            string sTable = "v_balans_isp";
            string sFilterTobo = "";

            string nbs = data[10];
            DateTime fdat = Convert.ToDateTime(data[11],cinfo);
            string tobo = data[12];

            SetParameters("sNbs", DB_TYPE.Varchar2, nbs, DIRECTION.Input);
            SetParameters("dDat", DB_TYPE.Date, fdat, DIRECTION.Input);
            return BindTableWithNewFilter("b.nbs NBS, b.isp ISP, b.dos/100 DOS, b.kos/100 KOS," +
                "b.isd/100 ISD, b.isk/100 ISK, b.fio FIO",
                sTable + " b",
                sFilterTobo + "b.nbs=:sNbs and b.fdat=:dDat and (b.dos<>0 or b.kos<>0 or b.isd<>0 or b.isk<>0)", data);
        }
        finally
        {
            DisposeOraConnection();
        }
    }

    [WebMethod(EnableSession = true)]
    public object[] GetDataByVal(string[] data)
    {
        try
        {
            InitOraConnection(Context);
            SetRole(BalansRole);

            string sTable = "v_balans_val";
            string sFilterTobo = "";

            string nbs = data[10];
            DateTime fdat = Convert.ToDateTime(data[11],cinfo);
            string tobo = data[12];

            SetParameters("sNbs", DB_TYPE.Varchar2, nbs, DIRECTION.Input);
            SetParameters("dDat", DB_TYPE.Date, fdat, DIRECTION.Input);
            return BindTableWithNewFilter("b.nbs NBS, b.kv VAL, b.dos DOS, b.kos KOS," +
                "b.isd ISD, b.isk ISK, b.name NAME, power(10,b.dig) DIG",
                sTable + " b",
                sFilterTobo + "b.nbs=:sNbs and b.fdat=:dDat and (b.dos<>0 or b.kos<>0 or b.isd<>0 or b.isk<>0)", data);
        }
        finally
        {
            DisposeOraConnection();
        }
    }

    [WebMethod(EnableSession = true)]
    public object[] GetDataByAcc(string[] data)
    {
        try
        {
            InitOraConnection(Context);
            SetRole(BalansRole);

            string sFilter = "";
            string sFilterTobo = "";

            Int32 par = Convert.ToInt32(data[10]);
            Int32 val = Convert.ToInt32(data[11]);
            string nbs = data[12];
            DateTime fdat = Convert.ToDateTime(data[13],cinfo);
            string tobo = data[14];

            if (par == 1) sFilter = "b.isp=:nVal";
            else sFilter = "b.kv=:nVal";

            SetParameters("nVal", DB_TYPE.Int32, val, DIRECTION.Input);
            SetParameters("sNbs", DB_TYPE.Varchar2, nbs, DIRECTION.Input);
            SetParameters("dDat", DB_TYPE.Date, fdat, DIRECTION.Input);
            return BindTableWithNewFilter("b.isp ISP, b.acc ACC, b.nls NLS, b.kv KV," +
                "b.dos DOS, b.kos KOS, b.isd ISD, b.isk ISK, b.nms NMS, b.nmk NMK, power(10,b.dig) DIG",
                "v_balans_acc b",
                sFilterTobo + sFilter + " and b.nbs=:sNbs and b.fdat=:dDat and (b.dos<>0 or b.kos<>0 or b.isd<>0 or b.isk<>0)", data);
        }
        finally
        {
            DisposeOraConnection();
        }
    }
}