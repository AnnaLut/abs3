using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Classes;
using Bars.Logger;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

public partial class clientproducts_SelectCardType : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // вичитка реквізитів клієнта
            if (Request["rnk"] != null)
            {
                Client client = new Client();

                client.ID = Convert.ToDecimal(Request["rnk"]);
                client.ReadFromDatabase();

                if (client.isResident && String.IsNullOrEmpty(client.Patronymic))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Error", "alert('Для клієнта резидента необхідно не вказано По батькові!');", true);
                }

                //
                textClientName.Text = client.Name;
                textClientCode.Text = client.Code;
                textClienBirthPlace.Text = client.BirthPlace;
                textClienBirthday.Text = client.BirthDate.ToString("dd/MM/yyyy");
                textClientAddress.Text = client.Address;
                textDocument.Text = client.DocTypeName + " " + client.DocSerial + " " + client.DocNumber + " " + client.DocOrg;
                textDocDate.Text = client.DocDate.ToString("dd/MM/yyyy");

                // Транслітерація Імені та Прізвища клієнта
                textClientNameOnCard.Text = Tools.Translate(client.FirstName);
                textClientSurnameOnCard.Text = Tools.Translate(client.LastName);

                // Поточний код та назва підрозділу
                OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

                try
                {
                    OracleCommand cmdSQL = connect.CreateCommand();
                    cmdSQL.CommandText = @"select branch, name from BRANCH 
                    where BRANCH = sys_context('bars_context','user_branch') and length(BRANCH) >= 15";

                    OracleDataReader rdr = cmdSQL.ExecuteReader();
                    if (rdr.Read())
                    {
                        textBranchCode.Text = Convert.ToString(rdr["branch"]);
                        textBranchName.Text = Convert.ToString(rdr["name"]);

                        textDeliveryBranchCode.Text = Convert.ToString(rdr["branch"]);
                        textDeliveryBranchName.Text = Convert.ToString(rdr["name"]);
                    }

                }
                finally
                {
                    if (connect.State != ConnectionState.Closed)
                    {
                        connect.Close();
                        connect.Dispose();
                    }
                }
            }
            else
            {
                Response.Redirect("/barsroot/clientproducts/dptclientsearch.aspx");
            }

            // 
            FillProductGrpList();
        }
    }

    /// <summary>
    /// Перелік груп
    /// </summary>
    protected void FillProductGrpList()
    {
        dsProductGrp.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        dsProductGrp.SelectCommand = @"SELECT code, name FROM w4_product_groups 
                                        WHERE code Not In ('INSTANT','LOCAL') 
                                          AND date_close Is Null
                                          AND client_type = 1
                                        ORDER BY code";

        listProductGrp.DataBind();

    }

    protected void listProductGrp_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (listProductGrp.SelectedItem.Value == "SALARY")
        {
            FillProjectList();

            listCurrency.Items.Clear();

            listCurrency.Items.Insert(0, new ListItem("Гривня України", "980", true));
        }
        else
        {
            listProject.Items.Clear();

            listProject.Items.Insert(0, new ListItem("Власна картка", "-1", true));

            FillCurrencyList();
        }

        listProduct.Items.Clear();
        listCard.Items.Clear();
    }

    /// <summary>
    /// Перелік зарплатних проектів
    /// </summary>
    protected void FillProjectList()
    {
        dsProject.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        dsProject.SelectCommand = @"select ID as project_id, NAME as project_name from BPK_PROECT
                                      where USED_W4 = 1 order by NAME ";

        listProject.DataBind();

        listProject.Items.Insert(0, new ListItem("-", "-1", true));
    }

    /// <summary>
    /// 
    /// </summary>
    protected void listProject_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillProductList(false);

        FillCardsList();
    }

    /// <summary>
    /// Перелік валют
    /// </summary>
    protected void FillCurrencyList()
    {
        dsCurrency.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        dsCurrency.SelectCommand = @"select c.KV as currency_code, c.NAME as currency_name from TABVAL$GLOBAL c
                                      where exists ( select 1 from V_W4_PRODUCT w where w.GRP_CODE = :grp_code and w.KV = c.KV )";

        dsCurrency.SelectParameters.Add("grp_code", TypeCode.String, listProductGrp.SelectedItem.Value);

        listCurrency.DataBind();

        listCurrency.Items.Insert(0, new ListItem("-", "-1", true));
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void listCurrency_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillProductList(true);
    }

    /// <summary>
    /// Перелік продутків
    /// </summary>
    /// <param name="EmptyLine">Додати в список 1-й порожній рядок</param>
    protected void FillProductList(Boolean EmptyLine)
    {
        dsProduct.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();


        dsProduct.SelectCommand = @"select unique product_code, product_name from V_W4_PRODUCT
                                        where grp_code = :grp_code and proect_id = :proect_id and kv = :kv";
            
        dsProduct.SelectParameters.Add("grp_code", TypeCode.String, listProductGrp.SelectedItem.Value);            
        dsProduct.SelectParameters.Add("proect_id", TypeCode.Int32, listProject.SelectedItem.Value);
        dsProduct.SelectParameters.Add("kv", TypeCode.String, listCurrency.SelectedItem.Value);

        listProduct.DataBind();

        if (EmptyLine)
        {
            listProduct.Items.Insert(0, "-");
            listProduct.Items[0].Value = "-1";
        }
    }

    protected void listProduct_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillCardsList();
    }

    protected void FillCardsList()
    {
        dsCard.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        dsCard.SelectCommand = @"select card_code, sub_name from V_W4_PRODUCT
                                     where proect_id = :proect_id And product_code = :product_code";

        dsCard.SelectParameters.Add("proect_id", TypeCode.Int32, listProject.SelectedItem.Value);
        dsCard.SelectParameters.Add("product_code", TypeCode.String, listProduct.SelectedItem.Value);

        listCard.DataBind();

        listCard.Items.Insert(0, "-");
        listCard.Items[0].Value = "<NULL>";
    }

    protected void listCard_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (listCard.SelectedItem.Value != "<NULL>")
        {
            btnRegisterCard.Enabled = true;
        }
        else
        {
            btnRegisterCard.Enabled = false;
        }

        GetCardParams();

        textSecretWord.Focus();
    }

    /// <summary>
    /// Параметри продукту обранї картки
    /// </summary>
    protected void GetCardParams()
    {
        OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

        try
        {
            OracleCommand cmdSQL = connect.CreateCommand();

            cmdSQL.CommandText = @"SELECT mm_max from V_W4_PRODUCT
                                    WHERE proect_id = :proect_id AND product_code = :product_code
                                      AND card_code = :card_code ";

            cmdSQL.Parameters.Add("proect_id", OracleDbType.Decimal, listProject.SelectedItem.Value, ParameterDirection.Input);
            cmdSQL.Parameters.Add("product_code", OracleDbType.Varchar2, listProduct.SelectedItem.Value, ParameterDirection.Input);
            cmdSQL.Parameters.Add("card_code", OracleDbType.Varchar2, listCard.SelectedItem.Value, ParameterDirection.Input);

            OracleDataReader rdr = cmdSQL.ExecuteReader();

            if (rdr.Read())
            {
                // к-ть місців
                textMonths.Text = Convert.ToString(rdr["mm_max"]);
                MaxMonths.Text = Convert.ToString(rdr["mm_max"]);

                CompareValidatorMonths.ErrorMessage = "К-ть місяців має бути менша або рівна " + MaxMonths.Text + "!";
            }
            else
            {
                textMonths.Text = String.Empty;
                MaxMonths.Text = String.Empty;
            }

        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            {
                connect.Close();
                connect.Dispose();
            }
        }
    }

    /// <summary>
    /// Реєстрація нової картки
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnRegisterCard_Click(object sender, EventArgs e)
    {
        Decimal cust_id = Convert.ToDecimal(Request["rnk"]);

        Decimal? Card_ID = null;

        DateTime? DateHiring = null;

        if (!String.IsNullOrEmpty(textDateHiring.Text))
            DateHiring = Convert.ToDateTime(textDateHiring.Text, Tools.Cinfo());

        OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

        try
        {
            OracleCommand cmd = connect.CreateCommand();

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "bars_ow.open_card";
            cmd.BindByName = true;
            // Input
            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, cust_id, ParameterDirection.Input);
            cmd.Parameters.Add("p_nls", OracleDbType.Varchar2, textInstantAccount.Text, ParameterDirection.Input);
            cmd.Parameters.Add("p_cardcode", OracleDbType.Varchar2, listCard.SelectedItem.Value, ParameterDirection.Input);
            cmd.Parameters.Add("p_branch", OracleDbType.Varchar2, textBranchCode.Text, ParameterDirection.Input);
            cmd.Parameters.Add("p_embfirstname", OracleDbType.Varchar2, textClientNameOnCard.Text.ToUpper(), ParameterDirection.Input);
            cmd.Parameters.Add("p_emblastname", OracleDbType.Varchar2, textClientSurnameOnCard.Text.ToUpper(), ParameterDirection.Input);
            cmd.Parameters.Add("p_secname", OracleDbType.Varchar2, textSecretWord.Text, ParameterDirection.Input);
            cmd.Parameters.Add("p_work", OracleDbType.Varchar2, textWorkPlace.Text, ParameterDirection.Input);
            cmd.Parameters.Add("p_office", OracleDbType.Varchar2, textWorkPost.Text, ParameterDirection.Input);
            cmd.Parameters.Add("p_wdate", OracleDbType.Date, DateHiring, ParameterDirection.Input);
            
            // зарплат. проект - власна картка
            cmd.Parameters.Add("p_salaryproect", OracleDbType.Decimal, -1, ParameterDirection.Input);

            cmd.Parameters.Add("p_term", OracleDbType.Decimal, Convert.ToDecimal(textMonths.Text), ParameterDirection.Input);
            cmd.Parameters.Add("p_branchissue", OracleDbType.Varchar2, textDeliveryBranchCode.Text, ParameterDirection.Input);
            
            // Output
            cmd.Parameters.Add("p_nd", OracleDbType.Decimal, Card_ID, ParameterDirection.Output);

            cmd.ExecuteNonQuery();

            Card_ID = ((OracleDecimal)cmd.Parameters["p_nd"].Value).Value;

            DBLogger.Info("Користувач заключив новий договір БПК №" + Convert.ToString(Card_ID.Value), "deposit");

            ClientScript.RegisterStartupScript(this.GetType(), "CardRegistration_Done",
            "alert('Картку зареєстровано!'); location.replace('/barsroot/clientproducts/SelectCardType.aspx?rnk=" + Request.QueryString["rnk"] + "');", true);
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }

    }

    /// <summary>
    /// Повернутися
    /// </summary>
    protected void btnBack_Click(object sender, EventArgs e)
    {
        // tab=1 - друга закладка (Карткові рахунки)
        Response.Redirect("/barsroot/clientproducts/DptClientPortfolioContracts.aspx?cust_id=" + Request.QueryString["rnk"] + "&tab=1");
    }
}