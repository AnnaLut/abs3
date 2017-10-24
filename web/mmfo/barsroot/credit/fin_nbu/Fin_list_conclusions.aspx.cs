using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Classes;
using System.Data;
using System.Drawing;
using System.Web.UI.HtmlControls;
using Oracle.DataAccess.Client;
using System.Globalization;
using Oracle.DataAccess.Types;
using System.Threading;
using System.Web.Security;
using Bars.UserControls;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;

public partial class credit_fin_nbu_Fin_list_conclusions : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!String.IsNullOrEmpty(Request["RNK"]) && !String.IsNullOrEmpty(Request["ND"]) && !IsPostBack)
        { 
        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);
        try
        {
           cmd.CommandText = (@"  Select '№ угоди: '||cc.cc_id as cc_id, c.nmk||'('||c.okpo||')' as nmk, to_char(cc.wdate,'dd/mm/yyyy') as wdate, to_char(cc.sdate,'dd/mm/yyyy') as sdate" +
                               "    From cc_deal cc, customer c " +
                               "   Where cc.rnk = c.rnk and cc.rnk = " + Convert.ToString(Request["RNK"]) + 
                               "     and cc.nd = " + Convert.ToString(Request["ND"])
                              );
           OracleDataReader rdr = cmd.ExecuteReader();
           if (rdr.Read())
           {
               Lb_rnk2.Text = Convert.ToString(Request["RNK"]);
               Lb_rnk3.Text = rdr["NMK"] == DBNull.Value ? (String)null : (String)rdr["NMK"];
               Lb_nd2.Text = Convert.ToString(Request["ND"]);
               Lb_nd3.Text = rdr["CC_ID"] == DBNull.Value ? (String)null : (String)rdr["CC_ID"];
               Lb_sdat2.Text = rdr["SDATE"] == DBNull.Value ? (String)null : (String)rdr["SDATE"];
               Lb_wdat2.Text = rdr["WDATE"] == DBNull.Value ? (String)null : (String)rdr["WDATE"];
           }
           else Response.Write("1");
            rdr.Close();
            rdr.Dispose();
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
        
    }


        if (!String.IsNullOrEmpty(Request["RNK"]) && !String.IsNullOrEmpty(Request["ND"]) && !IsPostBack)
        {
            try
            {
                InitOraConnection();

                Drd_dat.DataSource = SQL_SELECT_dataset("select to_char(dat,'dd/MM/yyyy') as dat from (select null as dat from dual  union all select distinct dat as dat from FIN_CALCULATIONS where rnk = " + Convert.ToString(Request["RNK"]) + " and nd = " + Convert.ToString(Request["ND"]) + " order by dat desc)").Tables[0];
                Drd_dat.DataTextField = "dat";
                Drd_dat.DataValueField = "dat";
                Drd_dat.DataBind();

            }
            finally
            {
                DisposeOraConnection();
            }
        }


        if (!String.IsNullOrEmpty(Request["RNK"]) && !String.IsNullOrEmpty(Request["ND"]))
        { 
            FillData();
        }

    }

    /// <summary>
    /// Перечитка грида
    /// </summary>
    private void FillData()
    {

        if (!String.IsNullOrEmpty(Request["RNK"]) && !String.IsNullOrEmpty(Request["ND"]))
        {

            dsMain.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
            String selectCommand;

            selectCommand = @"select rnk, nd, dat as dat, fdat as fdat, datd, fin23, obs23, kat23, k23, ved, vnkr, decode(tip_v,1,'Поточний',2,'Попередній','----') as tip_v ";
            selectCommand += " from FIN_CALCULATIONS ";
            selectCommand += " where  rnk = " + Request["RNK"];
            selectCommand += "  and  nd  = " + Request["ND"];
            
            if (!String.IsNullOrEmpty(Drd_dat.SelectedValue)) { selectCommand += "  and dat = to_date('" + Drd_dat.SelectedValue + "','dd/mm/yyyy')"; }
            selectCommand += " order by to_char(dat,'yyyy/MM/dd') desc, to_char(fdat,'yyyy/MM/dd') desc ";

          dsMain.SelectCommand = selectCommand;
          
        }

        dsMain.DataBind();
        gvMain.DataBind();
        
    }


    protected void gvMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
    /// <summary>
    /// повідомлення про помилку
    /// </summary>
    private void ShowError(String ErrorText)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_error", "alert('" + ErrorText + "');", true);
    }

    /// <summary>
    ///  Кнопка друку висновка
    /// </summary>
    protected void Bt_print_Click(object sender, ImageClickEventArgs e)
    {
      try {
          if (String.IsNullOrEmpty(Convert.ToString(gvMain.SelectedDataKey[0]))) { ShowError("Не вибрано жодного рядка"); return; }
          }
      catch (Exception) { ShowError("Не вибрано жодного рядка"); return; }
        
        
            Bt_print.Enabled = false;
            Im_run.Visible = true;


            String TemplateId = "fin_obu_CGD_Hist.frx";
            String DOCEXP_TYPE_ID;

            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";


            //if (bt_v.SelectedValue == "1")
            //{TemplateId = "fin_obu_CGD_Pot.frx";}
            //else if (bt_v.SelectedValue == "2")
            //{TemplateId = "fin_obu_CGD_Pop.frx";}
            //else
            //{ TemplateId = "fin_obu_CGD_Pot.frx"; }


            FrxParameters pars = new FrxParameters();
            pars.Add(new FrxParameter("p_fdat", TypeCode.DateTime, Convert.ToDateTime(gvMain.SelectedDataKey[3], cinfo)));
            pars.Add(new FrxParameter("p_dat", TypeCode.DateTime, Convert.ToDateTime(gvMain.SelectedDataKey[2], cinfo)));
            pars.Add(new FrxParameter("fdat", TypeCode.String, Convert.ToString(gvMain.SelectedDataKey[2], cinfo).Substring(0, 10)));
            pars.Add(new FrxParameter("rnk", TypeCode.String, Convert.ToString(gvMain.SelectedDataKey[0])));
            pars.Add(new FrxParameter("ND", TypeCode.String, Convert.ToString(gvMain.SelectedDataKey[1])));

            FrxDoc doc = new FrxDoc(

            FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(TemplateId)) + TemplateId, pars, this.Page);

            DOCEXP_TYPE_ID = ddl_print.SelectedValue;


           switch (DOCEXP_TYPE_ID)
                {
                    case "PDF1": doc.Print(FrxExportTypes.Pdf);
                        break;
                    case "RTF": doc.Print(FrxExportTypes.Rtf);
                        break;
                    case "XLS": doc.Print(FrxExportTypes.Excel2007);
                        break;
                    default: doc.Print(FrxExportTypes.Pdf);
                        break;
                }
           



            Bt_print.Enabled = true;
            Im_run.Visible = false;

        
    
    }


    protected void Drd_dat_TextChanged(object sender, EventArgs e)
    {
        FillData();
        gvMain.SelectedIndex = 0;
    }
}