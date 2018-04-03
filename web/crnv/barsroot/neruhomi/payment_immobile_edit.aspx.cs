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



public partial class payment_edit : Bars.BarsPage
{
    protected OracleConnection con;
    
    private void FillData()
    {
        Response.Redirect(String.Format("/barsroot/neruhomi/payment_immobile_edit.aspx?key={0}", Request["KEY"]));
    }

  
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            // сохраняем страничку с которой перешли
           
            bt_Cencel.Enabled = false;
            btSave.Enabled = false;
            bt_Edit.Enabled = true;

            tbNameFio.Enabled = false;
            tbNameCode.Enabled = false;
            tbNameDocType.Enabled = false;
            tbNameSer.Enabled = false;
            tbNameNum.Enabled = false;
            tbNamePaspW.Enabled = false;
            tbNamePaspD.Enabled = false;
            tbNameBirthdat.Enabled = false;
            tbNameBirthpl.Enabled = false;
            tbNameRegion.Enabled = false;
            tbNameDistrict.Enabled = false;
            tbNameCity.Enabled = false;
            tbNameAdres.Enabled = false;
            tbPhone1.Enabled = false;
            tbPhone2.Enabled = false;

            
            try
            {
                InitOraConnection();

                if (Request["KEY"] != null)
                {
                    hlNameRef.Visible = false;
                    SetParameters("key", DB_TYPE.Varchar2, Request["KEY"], DIRECTION.Input);
                    SQL_Reader_Exec(@"select fio, idcode, 
                                            DOCTYPE, 
                                            --DECODE(DOCTYPE, 1,'Паспорт',2,'Свідоцтво про нарродження',3,'Військовий квиток',0,'Інше') DOCTYPE,
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
                                             PHONE_H, 
                                             PHONE_J, 
                                             NLS,
                                             to_char(DATO,'dd/mm/yyyy') DATO,
                                             OST/100 OST,
                                             to_char(DATN, 'dd/mm/yyyy') DATN
                    from asvo_immobile where key=:key for update nowait");
                    while (SQL_Reader_Read())
                    {
                        ArrayList reader = SQL_Reader_GetValues();
                        tbNameFio.Text = Convert.ToString(reader[0]);
                        tbNameCode.Text = Convert.ToString(reader[1]);
                        tbNameDocType.Value = Convert.ToString(reader[2]);
                        tbNameSer.Text = Convert.ToString(reader[3]);
                        tbNameNum.Text = Convert.ToString(reader[4]);
                        tbNamePaspW.Text = Convert.ToString(reader[5]);
                        tbNamePaspD.Value = String.IsNullOrEmpty(Convert.ToString(reader[6]))? (DateTime?)null : Convert.ToDateTime(reader[6]);
                        tbNameBirthdat.Value =String.IsNullOrEmpty(Convert.ToString(reader[7]))?(DateTime?)null:Convert.ToDateTime(reader[7]);
                        tbNameBirthpl.Text = Convert.ToString(reader[8]);
                        tbNameRegion.Text = Convert.ToString(reader[9]);
                        tbNameDistrict.Text = Convert.ToString(reader[10]);
                        tbNameCity.Text = Convert.ToString(reader[11]);
                        tbNameAdres.Text = Convert.ToString(reader[12]);
                        tbPhone1.Text = Convert.ToString(reader[13]);
                        tbPhone2.Text = Convert.ToString(reader[14]);
                        tbNameNls.Text = Convert.ToString(reader[15]);
                        tbNameDato.Value =String.IsNullOrEmpty(Convert.ToString(reader[16]))?(DateTime?)null:Convert.ToDateTime(reader[16]);
                        tbNameOst.Text = Convert.ToString(reader[17]);
                        tbNameDatn.Value = String.IsNullOrEmpty(Convert.ToString(reader[18])) ? (DateTime?)null : Convert.ToDateTime(reader[18]);
                        
                    }
                    SQL_Reader_Close();
                }
            }
            finally
            {
                DisposeOraConnection();
            }

            
        }

    }

    private void ShowError(String ErrorText)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_error", "alert('" + ErrorText + "');", true);
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
                   // btPay.Enabled = false;
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
    protected void btSave_Click(object sender, EventArgs e)
    {

        String err_ ="";

        InitOraConnection();

        try
        {
            if (Request["KEY"] != null)
            {

                if (String.IsNullOrEmpty(tbNameCode.Text))
                {
                    err_= "***** Увага не заповнено ідентифікаційний номер клієнта. Оплата не може бути виконана. Заповніть ідентифікаційний номер!";
               
                }
                else
                {
                    if ((tbNameCode.Text.Length > 7 || tbNameCode.Text == "99999" || tbNameCode.Text == "000000000" || tbNameCode.Text == "0000000000") &&
                    (tbNameCode.Text != "00000000" && tbNameCode.Text != "11111111" && tbNameCode.Text != "22222222" && tbNameCode.Text != "33333333" && tbNameCode.Text != "44444444"
                    && tbNameCode.Text != "55555555" && tbNameCode.Text != "66666666" && tbNameCode.Text != "77777777" && tbNameCode.Text != "88888888"
                    && tbNameCode.Text != "99999999"&&
                    tbNameCode.Text != "111111111" && tbNameCode.Text != "222222222" && tbNameCode.Text != "333333333" && tbNameCode.Text != "444444444"
                    && tbNameCode.Text != "555555555" && tbNameCode.Text != "666666666" && tbNameCode.Text != "777777777" && tbNameCode.Text != "888888888"
                    && tbNameCode.Text != "999999999"
                    && tbNameCode.Text != "1111111111" && tbNameCode.Text != "2222222222" && tbNameCode.Text != "3333333333" && tbNameCode.Text != "4444444444"
                    && tbNameCode.Text != "5555555555" && tbNameCode.Text != "6666666666" && tbNameCode.Text != "7777777777" && tbNameCode.Text != "8888888888" && tbNameCode.Text != "9999999999"))
                    {
                        ClearParameters();
                        SetParameters("fio_", DB_TYPE.Varchar2, tbNameFio.Text, DIRECTION.Input);
                        SetParameters("idcode_", DB_TYPE.Varchar2, tbNameCode.Text, DIRECTION.Input);
                        SetParameters("pasp_s_", DB_TYPE.Varchar2, tbNameSer.Text, DIRECTION.Input);
                        SetParameters("pasp_n_", DB_TYPE.Varchar2, tbNameNum.Text, DIRECTION.Input);
                        SetParameters("pasp_w_", DB_TYPE.Varchar2, tbNamePaspW.Text, DIRECTION.Input);
                        SetParameters("pasp_d_", DB_TYPE.Date, tbNamePaspD.Value, DIRECTION.Input);
                        SetParameters("birthdat_", DB_TYPE.Date, tbNameBirthdat.Value, DIRECTION.Input);
                        SetParameters("birthpl_", DB_TYPE.Varchar2, tbNameBirthpl.Text, DIRECTION.Input);
                        SetParameters("region_", DB_TYPE.Varchar2, tbNameRegion.Text, DIRECTION.Input);
                        SetParameters("district_", DB_TYPE.Varchar2, tbNameDistrict.Text, DIRECTION.Input);
                        SetParameters("city_", DB_TYPE.Varchar2, tbNameCity.Text, DIRECTION.Input);
                        SetParameters("address_", DB_TYPE.Varchar2, tbNameAdres.Text, DIRECTION.Input);
                        SetParameters("phone_h_", DB_TYPE.Varchar2, tbPhone1.Text, DIRECTION.Input);
                        SetParameters("phone_j_", DB_TYPE.Varchar2, tbPhone2.Text, DIRECTION.Input);
                        SetParameters("doctype_", DB_TYPE.Varchar2, tbNameDocType.Value, DIRECTION.Input);
                        SetParameters("key_", DB_TYPE.Decimal, Request["KEY"], DIRECTION.Input);
                        SQL_NONQUERY(@"begin
                                    update asvo_immobile 
                                    set fio=:fio_, 
                                        idcode=:idcode_,
                                        pasp_s=:pasp_s_,
                                        pasp_n=:pasp_n_,
                                        pasp_w=:pasp_w_,
                                        pasp_d=:pasp_d_,
                                        birthdat=:birthdat_,
                                        birthpl=:birthpl_,
                                        region=:region_,
                                        district=:district_,
                                        city=:city_,
                                        address=:address_,
                                        phone_h=:phone_h_,
                                        phone_j=:phone_j_,
                                        doctype=:doctype_,
                                        --fl=6  --убираем подтверждение и сразу ставим флаг 7(по просьбе Шарадова 20/05/2014)
                                        fl=7
                                    where key=:key_ ; 
                                    end;");
                    }
                    else
                    {
                        err_= "***** Увага не коректно заповнено ідентифікаційний номер клієнта. Оплата не може бути виконана!";
                       
                    }
                }

               
             }
        }
        finally 
        {
            DisposeOraConnection();

        }
        if (err_=="")
        { 
        FillData();
        }
        else { ShowError(err_); }
        
      //  Response.Redirect("/barsroot/neruhomi/payment_immobile.aspx");
    }
    protected void bt_Cencel_Click(object sender, EventArgs e)
    {
        FillData();
    }
    protected void bt_Edit_Click(object sender, EventArgs e)
    {
        this.bt_Edit.Enabled = false;
        bt_Cencel.Enabled = true;
        btSave.Enabled = true;

        tbNameFio.Enabled = true;
        tbNameCode.Enabled = true;
        tbNameDocType.Enabled = true;
        tbNameSer.Enabled = true;
        tbNameNum.Enabled = true;
        tbNamePaspW.Enabled = true;
        tbNamePaspD.Enabled = true;
        tbNameBirthdat.Enabled = true;
        tbNameBirthpl.Enabled = true;
        tbNameRegion.Enabled = true;
        tbNameDistrict.Enabled = true;
        tbNameCity.Enabled = true;
        tbNameAdres.Enabled = true;
        tbPhone1.Enabled = true;
        tbPhone2.Enabled = true;

    }
    protected void bt_back_Click(object sender, EventArgs e)
    {
        Response.Redirect("/barsroot/neruhomi/payment_immobile.aspx");
    }
}
