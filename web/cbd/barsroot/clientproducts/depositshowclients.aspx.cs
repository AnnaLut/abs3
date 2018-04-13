using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Bars.Oracle;
using Bars.Logger;
using Oracle.DataAccess.Client;
using Bars.Exception;
using Bars.Classes;

/// <summary>
/// Summary description for DepositShowClients.
/// </summary>
public partial class DepositShowClients : Bars.BarsPage
{
    protected System.Data.DataSet dsClients;
    private OracleDataAdapter adapterSearchClients;
    private int row_counter = 0;

    private void Page_Load(object sender, System.EventArgs e)
    {
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositShowClients;
        Deposit dpt = (Deposit)Session["DepositInfo"];
        if (dpt == null)
            Response.Redirect("/barsroot/clientproducts/DepositClient.aspx");
        String OKPO = dpt.Client.Code;

        RegisterClientScript();

        OracleConnection connect = new OracleConnection();
        try
        {
            // Открываем соединение с БД
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = new OracleCommand();
            cmdSetRole.Connection = connect;
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdSearch = new OracleCommand();
            cmdSearch.Connection = connect;

            string searchQuery = @"select rnk, name, okpo from v_dpt_customer where okpo = :okpo";

            cmdSearch.CommandText = searchQuery;
            cmdSearch.Parameters.Add("okpo", OracleDbType.Decimal, OKPO, ParameterDirection.Input);

            adapterSearchClients = new OracleDataAdapter();
            adapterSearchClients.SelectCommand = cmdSearch;
            dsClients.Dispose();
            dsClients = new DataSet();
            gridClients.Columns.Clear();
            adapterSearchClients.Fill(dsClients);

            dsClients.Tables[0].Columns[0].ColumnName = "РНК";
            dsClients.Tables[0].Columns[1].ColumnName = "ФИО";
            dsClients.Tables[0].Columns[2].ColumnName = "ДРФО";

            gridClients.DataSource = dsClients;
            gridClients.DataBind();

            gridClients.HeaderStyle.BackColor = Color.Gray;
            gridClients.HeaderStyle.Font.Bold = true;
            gridClients.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }

    /// <summary>
    /// Локализация DataGrid
    /// </summary>
    protected override void OnPreRender(EventArgs evt)
    {
        // Локализируем грид
        if (gridClients.Controls.Count > 0)
        {
            Table tb = gridClients.Controls[0] as Table;
            tb.Rows[0].Cells[0].Text = Resources.Deposit.GlobalResources.tb17;
            tb.Rows[0].Cells[1].Text = Resources.Deposit.GlobalResources.tb18;
            tb.Rows[0].Cells[2].Text = Resources.Deposit.GlobalResources.tb19;
        }
    }

    #region Web Form Designer generated code
    override protected void OnInit(EventArgs e)
    {
        //
        // CODEGEN: This call is required by the ASP.NET Web Form Designer.
        //
        InitializeComponent();
        base.OnInit(e);
    }

    /// <summary>
    /// Required method for Designer support - do not modify
    /// the contents of this method with the code editor.
    /// </summary>
    private void InitializeComponent()
    {
        this.dsClients = new System.Data.DataSet();
        ((System.ComponentModel.ISupportInitialize)(this.dsClients)).BeginInit();
        this.gridClients.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.gridClients_ItemDataBound);
        this.btContinue.Click += new System.EventHandler(this.btContinue_Click);
        // 
        // dsClients
        // 
        this.dsClients.DataSetName = "NewDataSet";
        this.dsClients.Locale = new System.Globalization.CultureInfo("uk-UA");
        ;
        ((System.ComponentModel.ISupportInitialize)(this.dsClients)).EndInit();

    }
    #endregion
    /// <summary>
    /// Клієнтський скріпт, який
    /// при виборі рядка таблиці
    /// виділяє його кольором
    /// </summary>
    private void RegisterClientScript()
    {
        string script = @"<script language='javascript'>
			var selectedRow;
			function S(id,val)
			{
			 if(selectedRow != null) selectedRow.style.background = '';
			 document.getElementById('r_'+id).style.background = '#d3d3d3';
			 selectedRow = document.getElementById('r_'+id);
			 document.getElementById('rnk').value = val;
			}
			</script>";
        ClientScript.RegisterStartupScript(this.GetType(), ID + "Script", script);
    }
    private void gridClients_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            row_counter++;
            string row_id = "r_" + row_counter.ToString();
            DataGridItem row = e.Item;
            row.Attributes.Add("id", row_id);
            row.Attributes.Add("onclick", "S('" + row_counter.ToString() + "','" + row.Cells[0].Text + "')");
        }
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void btContinue_Click(object sender, System.EventArgs e)
    {
        btBack.Disabled = true;
        if (Request["update"] == null)
        {
            Client client = ((Deposit)Session["DepositInfo"]).Client;
            client.WriteToDatabase();

            Response.Redirect("/barsroot/deposit/deloitte/DepositContract.aspx");
        }
        else
        {
            OracleConnection connect = new OracleConnection();

            try
            {
                Client client = ((Deposit)Session["DepositInfo"]).Client;

                client.WriteToDatabase();

                DBLogger.Info("Пользователь обновил данные о клиенте №" + client.ID.ToString() + " на странице \"Информация о вкладчике\"",
                    "deposit");

                if (Request["agr_id"] != null)
                {
                    if (Request["dest"] == "print")
                    {
                        String dest = "/barsroot/deposit/deloitte/DepositAgreementPrint.aspx?dpt_id="
                            + Convert.ToString(Request["dpt_id"])
                            + "&agr_id=" + Convert.ToString(Request["dpt_id"])
                            + "&template=" + Convert.ToString(Request["template"])
                            + "&rnk=" + Convert.ToString(Request["rnk_b"]);
                        if (Request["idtr"] != null)
                            dest += "&idtr=" + Convert.ToString(Request["idtr"]);
                        if (Request["rnk_tr"] != null)
                            dest += "&rnk_tr=" + Convert.ToString(Request["rnk_tr"]);

                        Response.Redirect(dest);
                        return;
                    }
                    else
                    {
                        if (Request["dpt_id"] == null)
                            Response.Redirect("/barsroot/deposit/DepositSearch.aspx?action=agreement&extended=0");

                        if (Request["template"] == null)
                            Response.Redirect("/barsroot/deposit/DepositSearch.aspx?action=agreement&extended=0");

                        IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
                        connect = conn.GetUserConnection();
                        

                        OracleCommand cmd = connect.CreateCommand();
                        cmd.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
                        cmd.ExecuteNonQuery();

                        Decimal agr_id = Convert.ToDecimal(Request["agr_id"]);
                        Decimal dpt_id = Convert.ToDecimal(Request["dpt_id"]);
                        String typ_tr = String.Empty;
                        String typ = String.Empty;
                        if (agr_id == 5) { typ_tr = "B"; typ = "бенефециаром"; }
                        else if (agr_id == 8) { typ_tr = "H"; typ = "наследником"; }
                        else if (agr_id == 12) { typ_tr = "T"; typ = "довереным лицом"; }

                        /// Дебільна доробка зроблена по ЕКСКЛЮЗИВНОМУ проханню ПРАВЕКСУ
                        //if (typ_tr != String.Empty)
                        //{
                        //    OracleCommand ckPerson = connect.CreateCommand();
                        //    ckPerson.CommandText = "select id from dpt_trustee where rnk_tr=:rnk and dpt_id = :dpt_id and fl_act=1 and typ_tr=:typ_tr and undo_id is null ";
                        //    ckPerson.Parameters.Add("rnk", OracleDbType.Decimal, client.ID, ParameterDirection.Input);
                        //    ckPerson.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
                        //    ckPerson.Parameters.Add("typ_tr", OracleDbType.Varchar2, typ_tr, ParameterDirection.Input);
                        //    String result = Convert.ToString(ckPerson.ExecuteScalar());
                        //    if (result != String.Empty)
                        //        throw new DepositException("Даний клієнт вже є існуючим " +
                        //            typ + " по даному договору!");
                        //}

                        String dest = "/barsroot/deposit/DepositAgreementPrint.aspx?dpt_id="
                            + Convert.ToString(dpt_id) + "&agr_id=" + Convert.ToString(agr_id) +
                            "&template=" + Convert.ToString(Request["template"]) +
                            "&rnk=" + Convert.ToString(client.ID);
                        if (Request["idtr"] != null)
                            dest += "&idtr=" + Convert.ToString(Request["idtr"]);
                        if (Request["rnk_tr"] != null)
                            dest += "&rnk_tr=" + Convert.ToString(Request["rnk_tr"]);

                        cmd.CommandText = "select nvl(main_tt,'') from dpt_vidd_flags where id=:agr_id";
                        cmd.Parameters.Add("agr_id", OracleDbType.Decimal, Convert.ToDecimal(agr_id), ParameterDirection.Input);

                        String TT = Convert.ToString(cmd.ExecuteScalar());

                        if (TT != String.Empty && String.IsNullOrEmpty(Convert.ToString(Session["NO_COMISSION"])))
                        {
                            DBLogger.Info("За оформление доп. соглашения тип=" + Convert.ToString(agr_id) +
                                " по депозитному договору №" + dpt_id.ToString() +
                                " была взята коммиссия. Код операции " + TT,
                                "deposit");

                            cmd.Parameters.Clear();
                            cmd.CommandText = "select s.nls, s.kv from dpt_deposit d, saldo s where d.deposit_id = :dpt_id and d.acc = s.acc";
                            cmd.Parameters.Add("dpt_id", OracleDbType.Decimal, Convert.ToString(dpt_id), ParameterDirection.Input);

                            OracleDataReader rdr = cmd.ExecuteReader();

                            if (!rdr.Read())
                                throw new DepositException("Депозитний договір №" +
                                    Convert.ToString(dpt_id) + " не знайдено!");

                            String nls = Convert.ToString(rdr.GetOracleString(0).Value);
                            Decimal kv = Convert.ToDecimal(rdr.GetOracleDecimal(1).Value);

                            if (!rdr.IsClosed)
                                rdr.Close();

                            Client cl;

                            if (Request["rnk_tr"] != null)
                            {
                                cl = new Client();
                                cl.ID = Convert.ToDecimal(Convert.ToString(Request["rnk_tr"]));
                                cl.ReadFromDatabase();
                            }
                            else
                            {
                                Deposit dpt_dop = new Deposit();
                                dpt_dop.ID = dpt_id;
                                dpt_dop.ReadFromDatabase();
                                cl = dpt_dop.Client;
                            }

                            //String dop_rec = "&FIO=" + cl.Name +
                            //    "&PASP=" + cl.DocTypeName + "&PASPN=" + cl.DocSerial + " " + cl.DocNumber +
                            //    "&ATRT=" + cl.DocOrg + " " + cl.DocDate.ToString("dd/mm/yyyy") +
                            //    "&ADRES=" + cl.Address +
                            //    "&DT_R=" + cl.BirthDate.ToString("dd/mm/yyyy");
                            Random r = new Random();
                            String dop_rec = "&RNK=" + Convert.ToString(cl.ID) +
                                "&Code=" + Convert.ToString(r.Next());

                            string url = "\"/barsroot/DocInput/DocInput.aspx?tt=" + TT + "&nd=" +
                                Convert.ToString(dpt_id) + dop_rec + "&SumC_t=1&APROC=" +
                                OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") +
                                "@" + "begin dpt_web.fill_dpt_payments(" + dpt_id + ",:REF);end;" +
                                "\"";

                            string script = "<script>window.showModalDialog(encodeURI(" + url + "),null," +
                                "'dialogWidth:700px; dialogHeight:800px; center:yes; status:no');";

                            script += "location.replace('" + dest + "');";

                            script += "</script>";
                            Response.Write(script);
                            Response.Flush();
                        }
                        else
                        {
                            String script = "<script>location.replace('" + dest + "');";

                            script += "</script>";
                            Response.Write(script);
                            Response.Flush();
                        }
                    }
                }
                else
                {
                    Page_Load(sender, e);

                    String s_str = "<script>window.alert(\"" +
                        Resources.Deposit.GlobalResources.al16 +
                        "\");</script>";

                    if (Request["inherit"] != null)
                        s_str += "<script>var res = new Array(); res[0] = " + client.ID + "; " +
                        "res[1] = '" + client.Name + "'; " +
                        "window.returnValue = res; window.close(); </script>";
                    Response.Write(s_str);
                    //Response.Write("<script>alert(\"Изменения были успешно внесены!\");</script>");
                    Response.Flush();
                }
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }
        }
    }
}