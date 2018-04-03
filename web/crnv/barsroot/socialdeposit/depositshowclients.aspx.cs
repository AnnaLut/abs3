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
        SocialDeposit dpt = (SocialDeposit)Session["DepositInfo"];
        if (dpt == null)
            Response.Redirect("DepositClient.aspx");
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

            string searchQuery = "select rnk, nmk, okpo from customer where custtype=3 and okpo = :okpo";

            cmdSearch.CommandText = searchQuery;
            cmdSearch.Parameters.Add("okpo", OracleDbType.Varchar2, OKPO, ParameterDirection.Input);

            adapterSearchClients = new OracleDataAdapter();
            adapterSearchClients.SelectCommand = cmdSearch;
            dsClients.Dispose();
            dsClients = new DataSet();
            gridClients.Columns.Clear();
            adapterSearchClients.Fill(dsClients);

            dsClients.Tables[0].Columns[0].ColumnName = "РНК";
            dsClients.Tables[0].Columns[1].ColumnName = "ПІБ";
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
        this.Load += new System.EventHandler(this.Page_Load);
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
        Page.RegisterStartupScript(ID + "Script", script);
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
            Client client = ((SocialDeposit)Session["DepositInfo"]).Client;
            client.WriteToDatabase();
            Response.Redirect("DepositContract.aspx");
        }
        else
        {
            OracleConnection connect = new OracleConnection();

            try
            {
                Client client = ((SocialDeposit)Session["DepositInfo"]).Client;

                client.WriteToDatabase();

                DBLogger.Info("Пользователь обновил данные о клиенте №" + client.ID.ToString() + " на странице \"Информация о вкладчике\"",
                    "SocialDeposit");

                if (Request["agr_id"] != null)
                {
                    if (Request["dest"] == "print")
                    {
                        String dest = "DepositAgreementPrint.aspx?"
                            + "dpt_id=" + Convert.ToString(Request["dpt_id"])
                            + "&agr_id=" + Convert.ToString(Request["agr_id"])
                            + "&template=" + Convert.ToString(Request["template"])
                            + "&rnk=" + Convert.ToString(Request["rnk_b"]); ;
                        Response.Redirect(dest);
                        return;
                    }
                    else
                    {
                        if (Request["dpt_id"] == null)
                            Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");
                        if (Request["template"] == null)
                            Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");

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

                        if (typ_tr != String.Empty)
                        {
                            OracleCommand ckPerson = connect.CreateCommand();
                            ckPerson.CommandText = @"SELECT trust_id FROM SOCIAL_TRUSTEE 
                            WHERE trust_rnk=:rnk AND contract_id = :dpt_id AND fl_act=1 AND trust_type=:typ_tr AND undo_id IS NULL";
                            ckPerson.Parameters.Add("rnk", OracleDbType.Decimal, client.ID, ParameterDirection.Input);
                            ckPerson.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
                            ckPerson.Parameters.Add("typ_tr", OracleDbType.Varchar2, typ_tr, ParameterDirection.Input);
                            String result = Convert.ToString(ckPerson.ExecuteScalar());
                            if (result != String.Empty)
                                throw new ApplicationException("Даный клиент уже является действующим " + typ + " по даному договору!");
                        }

                        String dest = "DepositAgreementPrint.aspx?dpt_id="
                            + Convert.ToString(dpt_id) + "&agr_id=" + Convert.ToString(agr_id) +
                            "&template=" + Convert.ToString(Request["template"]) + "&rnk=" + Convert.ToString(client.ID);

                        cmd.CommandText = "select nvl(main_tt,'') from dpt_vidd_flags where id=:agr_id";
                        cmd.Parameters.Add("agr_id", OracleDbType.Decimal, Convert.ToDecimal(agr_id), ParameterDirection.Input);

                        String TT = Convert.ToString(cmd.ExecuteScalar());

                        if (TT != String.Empty)
                        {
                            DBLogger.Info("За оформление доп. соглашения тип=" + Convert.ToString(agr_id) +
                                " по депозитному договору №" + dpt_id.ToString() +
                                " была взята коммиссия. Код операции " + TT,
                                "SocialDeposit");

                            cmd.Parameters.Clear();
                            cmd.CommandText = @"SELECT s.nls, s.kv 
                            FROM SOCIAL_CONTRACTS d, saldo s 
                            WHERE d.contract_id = :dpt_id AND d.acc = s.acc";
                            cmd.Parameters.Add("dpt_id", OracleDbType.Decimal, Convert.ToString(dpt_id), ParameterDirection.Input);

                            OracleDataReader rdr = cmd.ExecuteReader();

                            if (!rdr.Read())
                                throw new ApplicationException("Депозитный договор №" + Convert.ToString(dpt_id) + " не найден!");

                            String nls = Convert.ToString(rdr.GetOracleString(0).Value);
                            Decimal kv = Convert.ToDecimal(rdr.GetOracleDecimal(1).Value);

                            if (!rdr.IsClosed)
                                rdr.Close();

                            Client cl;

                            if (Request["rnk_tr"] != null)
                            {
                                cl = new Client(Convert.ToDecimal(Convert.ToString(Request["rnk_tr"])));
                                if (client.ID == cl.ID)
                                {
                                    Response.Write("<script>alert('Не можна оформити додаткову угоду на самого себе!');history.go(-2);</script>");
                                    Response.Flush();
                                    return;
                                }
                            }
                            else
                            {
                                SocialDeposit dpt_dop = new SocialDeposit();
                                dpt_dop.ID = dpt_id;
                                dpt_dop.ReadFromDatabase(Context);
                                cl = dpt_dop.Client;
                                if (client.ID == cl.ID)
                                {
                                    Response.Write("<script>alert('Не можна оформити додаткову угоду на самого себе!');history.go(-2);</script>");
                                    Response.Flush();
                                    return;
                                }
                            }

                            Random r = new Random();
                            String dop_rec = "&RNK=" + Convert.ToString(cl.ID) +
                                "&Code=" + Convert.ToString(r.Next());

                            //String dop_rec = "&FIO=" + cl.Name +
                            //    "&PASP=" + cl.DocTypeName + "&PASPN=" + cl.DocSerial + " " + cl.DocNumber +
                            //    "&ATRT=" + cl.DocOrg + " " + cl.DocDate.ToString("dd/mm/yyyy") +
                            //    "&ADRES=" + cl.Address +
                            //    "&DT_R=" + cl.BirthDate.ToString("dd/mm/yyyy");

                            string url = "\"/barsroot/DocInput/DocInput.aspx?tt=" + TT + "&nd=" + Convert.ToString(dpt_id) + dop_rec + "&SumC_t=1\"";

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

                    Response.Write("<script>alert(\"Изменения были успешно внесены!\");</script>");
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

