using System;
using System.Collections.Generic;
using System.Collections;
using Bars.Classes;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
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


  
   
public partial class edit_neruhomi : Bars.BarsPage
{
    protected OracleConnection con;
    public String BackPageUrl 
    {
        get
        {
            return Convert.ToString(ViewState["BackPageUrl"]);
        }
        set
        {
            ViewState.Add("BackPageUrl", value);
        }
    }

    private void FillData()
    {
    }

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            // сохраняем страничку с которой перешли
            ViewState.Add("PREV_URL", Request.UrlReferrer.PathAndQuery);

            if (Request.UrlReferrer != null)
                BackPageUrl = Request.UrlReferrer.PathAndQuery;

            try
            {
                InitOraConnection();

                if (Request["KEY"] != null)
                {
                    hlNameRef.Visible = false;
                    SetParameters("key", DB_TYPE.Varchar2, Request["KEY"], DIRECTION.Input);
                    SQL_Reader_Exec(@"select fio, idcode, 
                                             DECODE(DOCTYPE, 1,'Паспорт',2,'Свідоцтво про нарродження',3,'Військовий квиток',0,'Інше') DOCTYPE,
                                             PASP_S,
                                             PASP_N,
                                             PASP_W,
                                             to_char(PASP_D,'dd/mm/yyyy') PASP_D,
                                             to_char(BIRTHDAT,'dd/mm/yyyy') BIRTHDAT,
                                             BIRTHPL, 
                                             REGION,  
                                             DISTRICT,
                                             CITY,   
                                             ADDRESS, 
                                             NLS,
                                             to_char(DATO,'dd/mm/yyyy') DATO,
                                             OST/100 OST,
                                             to_char(DATN, 'dd/mm/yyyy') DATN,
                                             case when ost<100 then 0 else neruhomi.get_percent(:key)/100 end sum_p                    
                    from v_asvo_immobile where key=:key");
                    while (SQL_Reader_Read())
                    {
                        ArrayList reader = SQL_Reader_GetValues();
                        lbNameFio.Text = Convert.ToString(reader[0]);
                        lbNameCode.Text = Convert.ToString(reader[1]);
                        lbNameDocType.Text = Convert.ToString(reader[2]);
                        lbNameSer.Text = Convert.ToString(reader[3]);
                        lbNameNum.Text = Convert.ToString(reader[4]);
                        lbNamePaspW.Text = Convert.ToString(reader[5]);
                        lbNamePaspD.Text = Convert.ToString(reader[6]);
                        lbNameBirthdat.Text = Convert.ToString(reader[7]);
                        lbNameBirthpl.Text = Convert.ToString(reader[8]);
                        lbNameRegion.Text = Convert.ToString(reader[9]);
                        lbNameDistrict.Text = Convert.ToString(reader[10]);
                        lbNameCity.Text = Convert.ToString(reader[11]);
                        lbNameAdres.Text = Convert.ToString(reader[12]);
                        lbNameNls.Text = Convert.ToString(reader[13]);
                        lbNameDato.Text = Convert.ToString(reader[14]);
                        lbNameOst.Text = Convert.ToString(reader[15]);
                        lbNameDatn.Text = Convert.ToString(reader[16]);
                        lbNameSumP.Text = Convert.ToString(reader[17]);

                    }
                    SQL_Reader_Close();
                }
            }
            finally
            {
                DisposeOraConnection();
            }

            FillData();

        }

    }

    private void ShowError(String ErrorText)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_error", "alert('" + ErrorText + "');", true);
    }

    //На головну сторінку
    protected void btBack_over(object sender, ImageClickEventArgs e)
    {
        try
        {
            InitOraConnection();
            {
                Response.Redirect(BackPageUrl);
            }
            FillData();
        }
        finally
        {
            DisposeOraConnection();
        }
    }

    protected void btRefresh_Click(object sender, ImageClickEventArgs e)
    {
        FillData();
    }

    protected void btOk_Pay(object sender, EventArgs e)
    {
        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);
        try
        {

            if (Request["KEY"] != null)
            {

                cmd.ExecuteNonQuery();
                Decimal? ref_;
                String   err_;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "NERUHOMI.pay";
                cmd.Parameters.Add("KEY", OracleDbType.Int64, Request["KEY"], ParameterDirection.Input);
                cmd.Parameters.Add("ref_", OracleDbType.Decimal, null, ParameterDirection.Output);
                cmd.Parameters.Add("err_", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);

                cmd.ExecuteNonQuery();

                ref_ = ((OracleDecimal)cmd.Parameters["ref_"].Value).IsNull ? (Decimal?)null : ((OracleDecimal)cmd.Parameters["ref_"].Value).Value;
                err_ = ((OracleString)cmd.Parameters["err_"].Value).IsNull ? (String)null : ((OracleString)cmd.Parameters["err_"].Value).Value;
                hlNameRef.Text = Convert.ToString(ref_);
                hlNameRef.Visible = true;
                hlNameRef.NavigateUrl = "/barsroot/documentview/default.aspx?ref=" + ref_;
                hlNameRef.Attributes.Add("onclick",
                //*************************************************************************//
               "javascript:" +
               "window.showModalDialog(" +
                hlNameRef.ClientID + ".href," +
               "'ModalDialog'," +
               "'dialogHeight:600px; dialogLeft:100px; dialogTop:100px; dialogWidth:1100px; help:no; resizable:yes; scroll:yes;'" +
               ");" +
               "return false;");
                //************************************************************************//
                if (ref_ != null)
                {
                    ShowError("Референс " + ref_ + " успішно прийнято!");
                    btPay.Enabled = false;
                }
                else 
                {
                    ShowError(err_);
                }

                //  Response.Redirect(BackPageUrl);

            }
        }
        finally
        {
            con.Close();
            con.Dispose();

        }
    }
}
