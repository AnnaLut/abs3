using Pir;
using Oracle.DataAccess.Client;
using System;
using System.Data;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using Bars.Classes;

public partial class pir_custinfo : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["PIR_RNK"] = null;
            Session["PIR_LOCALRNK"] = null;
            Session["PIR_LOCALFIO"] = null;
            Session["PIR_LOCALBIRTH"] = null;
            Session["PIR_LOCALPASSP"] = null;
            Session["PIR_LOCALINN"] = null;


            gv.DataBind();
            pnButtons.Visible = false;
            dvGridTitle.Visible = false;
            gv.Visible = false;

            pnFilter.GroupingText = "Параметри пошуку клієнта зареєстрованого в поточному відділені:";
        }
        PopulateDdlPassp();
    }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

    protected void raise_empty_url()
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "document", "alert('Не вказано шлях до Вебсервісу кримського РУ. Зверніться до адміністратора');", true);
    }

    protected void btFind_Click(object sender, EventArgs e)
    {
        string p_cust_rnk = "";
        string url = "";

        if (!String.IsNullOrEmpty(tbCustRnk.Text))
        {
            p_cust_rnk = tbCustRnk.Text;
        }

        string p_cust_code = tbCustCode.Text;
        string p_cust_fio = tbCustFio.Text.ToUpper().Trim();
        string p_cust_birthdau = diCustBirthday.SelectedDate.ToString().Replace("/", ".");
        string p_cust_doc_type = ddlCustDocType.SelectedValue;
        string p_cust_doc_serial = tbCustDocSerial.Text;
        string p_cust_doc_number = tbCustDocNumber.Text;

        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();

        try
        {
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select VAL from params where par = 'PIR_SERVICE'";
            OracleDataReader rdr = cmd.ExecuteReader();

            while (rdr.Read())
            {
                url = rdr["val"].ToString();
            }
        }

        finally
        {
            con.Close();
            cmd.Dispose();
            con.Dispose();
        }

        if (url == "")
        {
            raise_empty_url();
            return;
        }

        ServicePointManager.ServerCertificateValidationCallback = delegate(object s, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors) { return true; };

        //KrvpCustInfo Createservice = new Krvp.KrvpCustInfo();

          PirService service = new Pir.PirService();
        //service.WsHeaderValue = new WsHeader()
        //{
        //    Password = WebConfigurationManager.AppSettings["pcur.Password"],
        //    UserName = WebConfigurationManager.AppSettings["pcur.UserName"]
        //};

        service.Url = url;

        PirRequestCustData res = service.GetCustInfo(p_cust_rnk, p_cust_code, p_cust_fio, p_cust_birthdau, p_cust_doc_type, p_cust_doc_serial, p_cust_doc_number);

        if (res.Kind.ToString() == "Success")
        {
            gv.DataSourceID = "";

            if (res.PirCustData.Length > 0)
            {
                pnButtons.Visible = true;
                dvGridTitle.Visible = true;
                gv.Visible = true;
                lbGvTitle.Text = "Клієнти зареєстровані в АР Крим";


                gv.DataSource = res.PirCustData;
                gv.DataBind();
            }
            else
            {
                pnButtons.Visible = false;
                dvGridTitle.Visible = false;
                gv.Visible = false;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "document", "alert('Клієнта не знайдено');", true);
            }
        }
        else
        {
            pnButtons.Visible = false;
            dvGridTitle.Visible = false;
            gv.Visible = false;

            if ("ERR_AUTH_UNAMEPASSW" == res.Errors[0].Code)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "document", "alert('Невірно вказаний пароль користувача, зв`яжіться з адміністратором');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "document", "alert('Клієнта не знайдено');", true);
            }
        }
    }
    protected void btNext_Click(object sender, EventArgs e)
    {
        if (gv.SelectedRows.Count != 0)
        {
            string RNK = gv.DataKeys[gv.SelectedRows[0]]["RNK"].ToString();

            Session["PIR_RNK"] = RNK;
            Session["PIR_LOCALRNK"] = inLocalRnk.Value;
            

            Server.Transfer("/barsroot/pir/custproducts.aspx");
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Не вибрано жодного радка');", true);
        }
    }

    private void FillLocalGrid()
    {
        string selectCommand = "";
        //decimal p_cust_rnk = 0;
        string p_cust_rnk = "";
        string p_cust_code = "";
        string p_cust_fio = "";
        string p_cust_birthday = "";
        string p_cust_doc_type = "";
        string p_cust_doc_serial = "";
        string p_cust_doc_number = "";

        if (!String.IsNullOrEmpty(tbCustRnk.Text))
        {
            p_cust_rnk = tbCustRnk.Text;
        }
        if (!String.IsNullOrEmpty(tbCustCode.Text))
        {
            p_cust_code = tbCustCode.Text;
        }
        if (!String.IsNullOrEmpty(tbCustFio.Text))
        {
            p_cust_fio = tbCustFio.Text.ToUpper().Trim();
        }
        if (!String.IsNullOrEmpty(diCustBirthday.SelectedDate.ToString()))
        {
            p_cust_birthday = diCustBirthday.SelectedDate.ToString().Replace("/", ".");

        }
        if (!String.IsNullOrEmpty(ddlCustDocType.SelectedValue))
        {
            p_cust_doc_type = ddlCustDocType.SelectedValue;
        }
        if (!String.IsNullOrEmpty(tbCustDocSerial.Text))
        {
            p_cust_doc_serial = tbCustDocSerial.Text;
        }
        if (!String.IsNullOrEmpty(tbCustDocNumber.Text))
        {
            p_cust_doc_number = tbCustDocNumber.Text;
        }

        odsFmDocs.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        odsFmDocs.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("");
        odsFmDocs.SelectParameters.Clear();
        odsFmDocs.WhereParameters.Clear();

        selectCommand = @"select c.rnk,
                            c.nmk,
                            c.okpo,
                            c.adr,
                            to_char(p.bday,'dd.mm.yyyy') bday,
                            pp.name||' '|| p.ser||' '|| p.numdoc passp,
                            p.ser,
                            p.numdoc,
                            pp.name doc_name
                          from customer c,
                            person p,
                            passp pp 
                          where c.rnk = p.rnk
                            and p.passp = pp.passp
                            and c.date_off is null
                            and c.custtype = 3
                            and nvl(trim(c.sed), '00') != '91'";

        if (!String.IsNullOrEmpty(p_cust_rnk))
        {
            selectCommand += " and c.rnk = :p_cust_rnk";

            odsFmDocs.WhereParameters.Add("p_cust_rnk", TypeCode.Char, Convert.ToString(p_cust_rnk));
            gv.Visible = true;
            dvGridTitle.Visible = true;
        }
        else if (!String.IsNullOrEmpty(p_cust_code))
        {
            selectCommand += " and c.okpo =  :p_cust_code";

            odsFmDocs.WhereParameters.Add("p_cust_code", TypeCode.Char, Convert.ToString(p_cust_code));
            gv.Visible = true;
            dvGridTitle.Visible = true;
        }
        else if (!String.IsNullOrEmpty(p_cust_fio) && !String.IsNullOrEmpty(p_cust_birthday))
        {
            selectCommand += " and upper(c.nmk) = upper(:p_cust_fio) and to_char(p.bday,'dd.mm.yyyy') = substr(:p_cust_birthdau,1,10)";

            odsFmDocs.WhereParameters.Add("p_cust_fio", TypeCode.Char, Convert.ToString(p_cust_fio));
            odsFmDocs.WhereParameters.Add("p_cust_birthdau", TypeCode.Char, Convert.ToString(p_cust_birthday));
            gv.Visible = true;
            dvGridTitle.Visible = true;
        }
        else if (!String.IsNullOrEmpty(p_cust_doc_type) && !String.IsNullOrEmpty(p_cust_doc_serial) && !String.IsNullOrEmpty(p_cust_doc_number))
        {

            selectCommand += " and p.passp = to_number(:p_cust_doc_type) and p.ser = :p_cust_doc_serial and p.numdoc = :p_cust_doc_number";

            odsFmDocs.WhereParameters.Add("p_cust_doc_type", TypeCode.Char, Convert.ToString(p_cust_doc_type));
            odsFmDocs.WhereParameters.Add("p_cust_doc_serial", TypeCode.Char, Convert.ToString(p_cust_doc_serial));
            odsFmDocs.WhereParameters.Add("p_cust_doc_number", TypeCode.Char, Convert.ToString(p_cust_doc_number));
            gv.Visible = true;
            dvGridTitle.Visible = true;
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alertSearchTypes();", true);
            selectCommand += " and 1=2";
            gv.Visible = false;
            dvGridTitle.Visible = false;
        }
        odsFmDocs.SelectCommand = selectCommand;

        lbGvTitle.Text = "Клієнти зареєстровані в поточному відділені";

        gv.DataSourceID = "odsFmDocs";
    }

    private void FillData()
    {
        odsFmDocs.DataBind();
        gv.DataBind();
    }

    private void Check_2625()
    {
        string p_local_rnk = "";
        decimal count = 0;

        string RNK = gv.DataKeys[gv.SelectedRows[0]]["RNK"].ToString();
        string OKPO = gv.DataKeys[gv.SelectedRows[0]]["OKPO"].ToString();
       

        if (!String.IsNullOrEmpty(RNK))
        {
            p_local_rnk = RNK;
        }

        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();

        try
        {
            cmd.Parameters.Add("p_local_rnk", OracleDbType.Decimal, 38, Convert.ToDecimal(p_local_rnk), ParameterDirection.Input);

            cmd.CommandType = CommandType.Text;
            cmd.CommandText = @"select count(a.nls) count
                                from accounts a, w4_acc w
                                where a.rnk = :p_local_rnk 
                                  and a.nbs = '2625'
                                  and a.acc = w.acc_pk
                                  and w.card_code in ('STND_CRIMEA_UAH_1_VELCTR_30','STND_CRIMEA_USD_1_VELCTR_30','STND_CRIMEA_EUR_1_VELCTR_30')";

            cmd.BindByName = true;
            OracleDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                count = Convert.ToDecimal(rdr["count"]);
            }
        }
        catch (System.Exception e)
        {

        }
        finally
        {
            con.Close();
            cmd.Dispose();
            con.Dispose();
        }

        if (count == 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Клієнту не відкрито рахунки 2625');", true);
        }
        else
        {
          
            inLocalRnk.Value = RNK;
            tbCustRnk.Text = null;
            tbCustCode.Text = OKPO;

            gv.Visible = false;
            dvGridTitle.Visible = false;

            pnButtons.Visible = false;
            btGoToSearchInCrimea.Visible = false;
            btNext.Visible = true;

            btFindLocalRNK.Visible = false;
            btFind.Visible = true;

            pnFilter.GroupingText = "Параметри пошуку клієнта зареєстрованого в Кримському РУ:";
        }
    }

    protected void btFindLocalRNK_Click(object sender, EventArgs e)
    {

        FillLocalGrid();
        FillData();

        if (gv.Rows.Count > 0)
        {
            pnButtons.Visible = true;
            btGoToSearchInCrimea.Visible = true;
            btNext.Visible = false;
        }
        else
        {
            pnButtons.Visible = false;
            btGoToSearchInCrimea.Visible = false;
            btNext.Visible = true;
        }
    }

    protected void btGoToSearchInCrimea_Click(object sender, EventArgs e)
    {
        if (gv.SelectedRows.Count != 0)
        {
            Check_2625();
            Session["PIR_LOCALFIO"] = gv.DataKeys[gv.SelectedRows[0]]["NMK"].ToString();
            Session["PIR_LOCALBIRTH"] = gv.DataKeys[gv.SelectedRows[0]]["BDAY"].ToString();
            Session["PIR_LOCALPASSP"] = gv.DataKeys[gv.SelectedRows[0]]["PASSP"].ToString();
            Session["PIR_LOCALINN"] = gv.DataKeys[gv.SelectedRows[0]]["OKPO"].ToString();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Не вибрано жодного радка');", true);
        }
    }

    protected void PopulateDdlPassp()
    {
        string selectCommand = "";

        odsPassp.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        odsPassp.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("");
        odsPassp.SelectParameters.Clear();
        odsPassp.WhereParameters.Clear();

        selectCommand = @"select null passp, null name from dual union all select p.passp, p.name from passp p where p.passp > 0 order by passp nulls first";

        odsPassp.SelectCommand = selectCommand;

        ddlCustDocType.DataSourceID = "odsPassp";
    }
}
