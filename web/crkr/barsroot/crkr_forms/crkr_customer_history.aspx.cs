using System;
using Bars.Classes;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Client;
using System.Globalization;


public partial class crkr_cust_history : Bars.BarsPage
{
    protected OracleConnection con;
    private void FillData()
    {
        dsMain.DataBind();
        gvMain.DataBind();
    }

    //Населення грида
    protected void Page_Load(object sender, EventArgs e)
    {

        dsMain.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        String SelectCommand = String.Empty;

     
            SelectCommand = @"select
                            to_char(LASTEDIT, 'dd.mm.yyyy HH24:MI:SS') LASTEDIT,
                            rnk, 
                            name, 
                            inn,
                            birth_date, 
                            case rezid when 1 then 'Резидент' else 'Не резидент' end rezid, 
                            (select name from passp where passp = c.id_doc_type) doc_type,
                            ser, 
                            numdoc, 
                            date_of_issue, 
                            tel, 
                            tel_mob, 
                            branch, 
                            notes,  
                            date_registry, 
                            zip, 
                            domain,
                            region, 
                            locality, 
                            address, 
                            c.user_id, 
                            user_fio,
                            change_info
                            from CUSTOMER_CRKR_UPDATE c 
                        where rnk=" + Request["rnk"]+" order by id desc";

    



        dsMain.SelectCommand = SelectCommand;
    }
    //Перечитати дани
    protected void btRefresh_Click(object sender, EventArgs e)
    {
        dsMain.DataBind();
        gvMain.DataBind();
    }

    // Для коректного відображення алертiв
    private void ShowError(String ErrorText)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_error", "alert('" + ErrorText + "');", true);
    }

    //Для открытия в новом окне
    private void Window_open(String URL)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "open", " window.open('" + URL + "');", true);
    }


    //Розкраска грида
    protected void gvMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
      
    }

}