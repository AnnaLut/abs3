using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.DataComponents;
using Bars.Oracle;
using Bars.Logger;
using Bars.Classes;
using Bars.Exception;

public partial class deposit_DptClientPortfolioContracts : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Request["cust_id"] == null)
        {
            Response.Redirect("DptClientSearch.aspx");
        }
        else
        {
            // Клієнт (РНК)
            Int32 cust_id = Convert.ToInt32(Request["cust_id"]);

            // Населяємо шапку форми
            GetCustParams(cust_id);

            // Населяємо табл. договорів клієнта
            FillGrid("MAIN", cust_id);

            // Населяємо табл. договорів на які у клієнта є доручення
            FillGrid("TRUSTEE", cust_id);

            // Населяємо табл. договорів по яких клієнт є спадкоємцем
            FillGrid("HERITOR", cust_id);

            // Населяємо табл. договорів по яких клієнт є бенефіціаром
            FillGrid("BENEFICIARY", cust_id);

            // Населяємо табл. договорів по яких клієнт є розпорядником (для малолітніх осіб)
            FillGrid("CHILDREN", cust_id);

            // карткові рахунки клієнта
            FillGrid("CARD_ACCOUNT", cust_id);

            // Доступність полів в залежності від рівня доступу операціоніста
            if (ClientAccessRights.Get_AccessLevel(cust_id) == LevelState.Limited)
            {
                gvDepositMain.Columns[7].Visible = false;
                gvDepositMain.Columns[8].Visible = false;

                gvHeritage.Columns[8].Visible = false;
                gvHeritage.Columns[9].Visible = false;

                gvDepositBeneficiary.Columns[8].Visible = false;
                gvDepositBeneficiary.Columns[9].Visible = false;
            }

            // Статус актуальності ідентифікуючого документу
            // if (ClientAccessRights.Get_DocumentState(cust_id) == DocumentState.NotVerified)
            if (!Tools.Get_DocumentVerifiedState(cust_id))
            {
                btCreateContract.ToolTip = "Заключення договорів недоступне: не актуальні ідентифікуючі документи клієнта!";
                btCreateContract.Enabled = false;
            }

            // Перевірка на малолітнього клієнта
            if (!Client.Allowed2Oopen(cust_id))
            {
                btCreateContract.ToolTip = "Заключення договорів недоступне: клієнту не виповнилося 14 років!";
                btCreateContract.Enabled = false;
            }
        }

        if (!IsPostBack)
        {
            if (!(ViewState["ActiveMainTabindex"] == null) && (!(sender == null)))
            {
                
                    TabMainContainer.ActiveTabIndex = (int)ViewState["ActiveMainTabindex"];
               
            }
            if (!(ViewState["ActiveDepositTabindex"] == null) && (!(sender == null)))
            {

                TabDepositContainer.ActiveTabIndex = (int)ViewState["ActiveDepositTabindex"];

            }
          
        }

    }

    // вичитуємо данні клієнта
    private void GetCustParams(Int32 p_cust_id)
    {
        OracleConnection connect = new OracleConnection();
        try
        {
            // Открываем соединение с БД
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            OracleCommand cmdSQL = connect.CreateCommand();
            cmdSQL.CommandText = @"select c.nmk, c.okpo, p.bday 
                                     from customer c, person p
                                    where c.rnk = :cust_id
                                      and c.rnk = p.rnk";

            cmdSQL.Parameters.Add("cust_id", OracleDbType.Int32, p_cust_id, ParameterDirection.Input);

            OracleDataReader rdrSQL = cmdSQL.ExecuteReader();

            if (!rdrSQL.Read())
                throw new DepositException("Інформація про клієнта з РНК №" + p_cust_id.ToString() +
                                            " не знайдена! (або клієнт закритий)");
            // Назва
            if (!rdrSQL.IsDBNull(0))
                textClientName.Text = rdrSQL.GetString(0);

            // ОКПО
            if (!rdrSQL.IsDBNull(1))
                textClientCode.Text = rdrSQL.GetString(1);

            // Дата народження
            if (!rdrSQL.IsDBNull(2))
                dtClienBirthday.Date = rdrSQL.GetDateTime(2);
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

    private void FillGrid(String p_type, Int32 p_cust_id)
    {
        string searchQuery;

        switch (p_type)
        {
            case "MAIN":

                dsDepositMain.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
                // dsDepositMain.PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");

                searchQuery = @"SELECT P.DPT_ID, P.DPT_NUM DPT_NUM, P.VIDD_NAME type_name, P.DAT_BEGIN datz, P.DAT_END dat_end,
                                       P.DPT_ACCNUM nls, P.DPT_CURCODE lcv, p.DPT_LOCK, p.ARCHDOC_ID,
                                       to_char((P.DPT_SALDO/p.DPT_CUR_DENOM),'FM999G999G999G990D009') ostc,
                                       decode(P.DPT_ACCID,P.INT_ACCID,'0.00',to_char((P.INT_SALDO/DPT_CUR_DENOM),'FM999G999G999G990D009')) ost_int
                                  FROM v_dpt_portfolio_all_active P
                                 WHERE DAT_END is Not Null
                                   AND CUST_ID = :p_client_id";

                dsDepositMain.WhereParameters.Clear();
                dsDepositMain.SelectCommand = searchQuery;
                dsDepositMain.WhereParameters.Add("p_client_id", TypeCode.Int32, Convert.ToString(p_cust_id));

                // gvDepositMain.DataSourceID = "dsSearchDeposit";
                // gvDepositMain.DataBind();

                if (gvDepositMain.Rows.Count == 0)
                    btSelectContract.Enabled = false;

                break;

            case "TRUSTEE":

                dsDepositTrustee.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
                // dsDepositTrustee.PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");

                searchQuery = @"SELECT p.dpt_id DPT_ID,  p.dpt_num DPT_NUM, p.cust_name NMK, p.dpt_accnum NLS,
                                       p.dpt_curcode LCV, p.dat_begin DATZ, p.dat_end DAT_END, p.DPT_LOCK, p.ARCHDOC_ID
                                  FROM v_dpt_portfolio_ALL_active p
                                 WHERE p.DAT_END is Not Null
                                   AND p.DPT_ID in (select dpt_id from DPT_TRUSTEE
                                                     where rnk_tr = :p_client_id And typ_tr = 'T' 
                                                       And FL_ACT = 1 And UNDO_ID Is Null)";

                dsDepositTrustee.WhereParameters.Clear();
                dsDepositTrustee.SelectCommand = searchQuery;
                dsDepositTrustee.WhereParameters.Add("p_client_id", TypeCode.Int32, Convert.ToString(p_cust_id));

                gvDepositTrustee.DataBind();

                if (gvDepositTrustee.Rows.Count == 0)
                    btSelectTrusteeContract.Enabled = false;

                break;

            case "HERITOR":

                dsDepositHeritor.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
                dsDepositHeritor.PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");

                searchQuery = @"SELECT p.dpt_id DPT_ID,  p.dpt_num DPT_NUM, p.vidd_name TYPE_NAME, p.cust_name NMK,
                                       p.dpt_accnum NLS, p.dpt_curcode LCV, p.dat_begin DATZ, p.dat_end, h.INHERIT_SHARE,
                                       (p.dpt_saldo/p.dpt_cur_denom) OST_DEP, (p.int_saldo/dpt_cur_denom) OST_INT, 
                                       p.DPT_LOCK, p.ARCHDOC_ID
                                  from V_DPT_PORTFOLIO_ALL_ACTIVE p,
                                       DPT_INHERITORS h
                                 WHERE p.DPT_ID = h.dpt_id
                                   and h.INHERIT_CUSTID = :p_client_id";

                dsDepositHeritor.WhereParameters.Clear();
                dsDepositHeritor.SelectCommand = searchQuery;
                dsDepositHeritor.WhereParameters.Add("p_client_id", TypeCode.Int32, Convert.ToString(p_cust_id));

                gvHeritage.DataBind();

                if (gvHeritage.Rows.Count == 0)
                    btnPayoutHeritage.Enabled = false;

                break;

            case "BENEFICIARY":

                dsDepositBeneficiary.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
                dsDepositBeneficiary.PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");

                searchQuery = @"SELECT p.dpt_id DPT_ID, p.dpt_num DPT_NUM, p.dat_begin DATZ, p.dat_end DAT_END,
                                       p.vidd_name TYPE_NAME, p.cust_name NMK, p.dpt_accnum NLS, p.dpt_curcode LCV, 
                                      (p.dpt_saldo/p.dpt_cur_denom) OST_DEP, (p.int_saldo/dpt_cur_denom) OST_INT,
                                       p.DPT_LOCK, p.ARCHDOC_ID, b.RNK_TR, b.ID TRUSTEE_ID
                                  FROM v_dpt_portfolio_ALL_active p,
                                       dpt_trustee b
                                 WHERE p.DAT_END is Not Null
                                   AND p.DPT_ID = b.dpt_id
                                   AND rnk_tr = :p_client_id
                                   AND typ_tr = 'B' AND FL_ACT = 1";

                dsDepositBeneficiary.WhereParameters.Clear();
                dsDepositBeneficiary.SelectCommand = searchQuery;
                dsDepositBeneficiary.WhereParameters.Add("p_client_id", TypeCode.Int32, Convert.ToString(p_cust_id));

                gvDepositBeneficiary.DataBind();

                if (gvDepositBeneficiary.Rows.Count == 0)
                    btnGetOwnership.Enabled = false;

                break;

            case "CHILDREN":

                dsDepositChildren.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
                dsDepositChildren.PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");

                searchQuery = @"SELECT p.dpt_id DPT_ID,
                                       p.dpt_num DPT_NUM,
                                       p.cust_name NMK,
                                       p.dpt_accnum NLS,
                                       p.dpt_curcode LCV,
                                       p.dat_begin DATZ,
                                       p.dat_end DAT_END,
                                       p.DPT_LOCK,
                                       p.ARCHDOC_ID,
                                       0 AS RNK_M,
                                       T.RNK_tr AS rnk_c
                                  FROM v_dpt_portfolio_ALL_active p, DPT_TRUSTEE t
                                 WHERE     p.DAT_END IS NOT NULL
                                       AND t.typ_tr = 'C'
                                       AND t.FL_ACT = 1
                                       AND t.UNDO_ID IS NULL
                                       AND T.DPT_ID = P.DPT_ID
                                       AND NOT EXISTS
                                                  (SELECT 1
                                                     FROM DPT_TRUSTEE
                                                    WHERE     typ_tr = 'M'
                                                          AND dpt_id = p.DPT_ID
                                                          AND FL_ACT = 1
                                                          AND UNDO_ID IS NULL)
                                       AND T.RNK_TR = :p_client_id
                                UNION
                                SELECT p.dpt_id DPT_ID,
                                       p.dpt_num DPT_NUM,
                                       p.cust_name NMK,
                                       p.dpt_accnum NLS,
                                       p.dpt_curcode LCV,
                                       p.dat_begin DATZ,
                                       p.dat_end DAT_END,
                                       p.DPT_LOCK,
                                       p.ARCHDOC_ID,
                                       NVL (t.rnk, 0) AS RNK_M,
                                       T_2.RNK_tr AS rnk_c
                                  FROM v_dpt_portfolio_ALL_active p, DPT_TRUSTEE t, DPT_TRUSTEE t_2
                                 WHERE     p.DAT_END IS NOT NULL
                                       AND p.dpt_id = T.DPT_ID
                                       AND T.TYP_TR = 'M'
                                       AND t.FL_ACT = 1
                                       AND t.UNDO_ID IS NULL
                                       AND t_2.typ_tr = 'C'
                                       AND t_2.FL_ACT = 1
                                       AND t_2.UNDO_ID IS NULL
                                       AND T_2.DPT_ID = P.DPT_ID
                                       and T.RNK_TR = :p_client_id
                                        ";

                dsDepositChildren.WhereParameters.Clear();
                dsDepositChildren.SelectCommand = searchQuery;
                dsDepositChildren.WhereParameters.Add("p_client_id", TypeCode.Int32, Convert.ToString(p_cust_id));

                gvDepositChildren.DataBind();

                if (gvDepositChildren.Rows.Count == 0)
                {
                    SetManager.Enabled = false;
                    SetChild.Enabled = false;
                }


                break;


            case "CARD_ACCOUNT":

                dsCards.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
                dsCards.PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");

                searchQuery = @"SELECT w4.ACC_ACC,
                                       w4.ND,
                                       w4.ACC_TIPNAME,
                                       w4.CARD_CODE,
                                       w4.ACC_NLS,
                                       w4.ACC_LCV,
                                       w4.ACC_OB22,
                                       w4.ACC_OST,
                                       w4.ACC_DAOS,
                                       w4.BRANCH,
                                          'id in (select doc_id from w4_product_doc where grp_code='''
                                       || wp.grp_code
                                       || ''' and doc_id not like ''%MIGR%'')'
                                          doc_id
                                  FROM W4_PORTFOLIO_ACTIVE w4, w4_card wc, w4_product wp
                                 WHERE w4.cust_rnk = :p_client_id
                                     AND w4.acc_dazs is Null
                                     AND w4.CARD_CODE = wc.CODE
                                     AND wc.PRODUCT_CODE = wp.CODE";

                dsCards.WhereParameters.Clear();
                dsCards.SelectCommand = searchQuery;
                dsCards.WhereParameters.Add("p_client_id", TypeCode.Int32, Convert.ToString(p_cust_id));

                //gvCards.DataBind();

                if (gvCards.Rows.Count == 0)
                    btnShowAccount.Enabled = false;

                break;
        }

    }

    // Вибрати договір
    protected void SelectContract_Click(object sender, EventArgs e)
    {
        Button btn = (sender as Button);
        BarsGridViewEx gv = (gvDepositMain as BarsGridViewEx);

        String url = "&scheme=DELOITTE";

        //if (btn.ID == "btSelectContract")
        //    gv = (gvDepositMain as BarsGridViewEx);

        // Довірений депозит
        if (btn.ID == "btSelectTrusteeContract")
        {
            gv = (gvDepositTrustee as BarsGridViewEx);

            url = url + "&rnk_tr=" + Request.QueryString["cust_id"];
        }

        if (gv.SelectedRows.Count > 0)
        {
            if (gv.DataKeys.Count > 0)
            {
                decimal? dpt_id = Convert.ToDecimal(gv.DataKeys[gv.SelectedRows[0]].Values[0]);

                if (dpt_id == null)
                {
                    Response.Write("<script>alert('Не вибрано депозитний договір!');</script>");
                    return;
                }
                else
                {
                    DBLogger.Info("Користувач вибрав для перегляду договір №" + Convert.ToString(Request["cust_id"]) +
                        " на сторінці [Портфель договорів].", "deposit");
                   
                    Response.Redirect("/barsroot/deposit/deloitte/DepositContractInfo.aspx?dpt_id=" + Convert.ToString(dpt_id) + url);
                }
            }
        }
    }

    // Новий договір
    protected void btCreateContract_Click(object sender, EventArgs e)
    {
        DBLogger.Info("Користувач створення нового договору для клієнта №" + Request.QueryString["cust_id"] +
             " на сторінці [Портфель договорів].", "deposit");

        Int32 cust_id = Convert.ToInt32(Request["cust_id"]);

       
        Response.Redirect("/barsroot/deposit/deloitte/DepositContract.aspx?scheme=DELOITTE");
    }

    /// <summary>
    /// Новий договір(оформлює довірена особа)
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btCreateTrusteeContract_Click(object sender, EventArgs e)
    {
        DBLogger.Info("Довірена особа розпочала створення нового договору для клієнта №" + Request.QueryString["cust_id"] +
             " на сторінці [Портфель договорів].", "deposit");

        Int32 cust_id = Convert.ToInt32(Request["cust_id"]);
        Session["OnTrustee"] = "YES";
       
        Response.Redirect("/barsroot//clientproducts/DepositClient.aspx?scheme=DELOITTE&agr_id=12&rnk_tr=" + cust_id.ToString());
        //&dpt_id=10478301&agr_id=5&dest=print&template=DPT_ADD_OB_3OS&rnk_tr=1137956

    }


    /// <summary>
    /// Виплата спадщини
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnPayoutHeritage_Click(object sender, EventArgs e)
    {
        
        if (gvHeritage.SelectedRows.Count > 0)
        {
            if (gvHeritage.DataKeys.Count > 0)
            {
                decimal? dpt_id = Convert.ToDecimal(gvHeritage.DataKeys[gvHeritage.SelectedRows[0]].Values[0]);

                if (dpt_id == null)
                {
                    Response.Write("<script>alert('Не вибрано депозитний договір!');</script>");
                    Response.Flush();
                }
                else
                {
                    DBLogger.Info("Користувач вибрав для виплати спадкоємцю (РНК=" + Request.QueryString["cust_id"] +
                        ") договір №" + Convert.ToString(dpt_id.Value) + " на сторінці [Портфель договорів].", "deposit");

                    // Дата завершення вкладу
                    DateTime? DateEnd = Convert.ToDateTime(gvHeritage.DataKeys[gvHeritage.SelectedRows[0]].Values[3]);

                    if (DateEnd > DateTime.Now.Date)
                    {
                        Response.Redirect("/barsroot/deposit/deloitte/DepositClosePayIt.aspx?dpt_id=" +
                            Convert.ToString(dpt_id.Value) + "&inherit_id=" + Request.QueryString["cust_id"] +
                            "&dest=return&tt=DP1&scheme=DELOITTE");
                    }
                    else
                    {
                        Response.Redirect("/barsroot/deposit/deloitte/DepositSelectTT.aspx?dpt_id=" +
                            Convert.ToString(dpt_id.Value) + "&inherit_id=" + Request.QueryString["cust_id"] +
                            "&dest=return&scheme=DELOITTE");
                    }
                }
            }
        }
    }


    /// <summary>
    /// Вступ в права власника бенефіціаром
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnGetOwnership_Click(object sender, EventArgs e)
    {

        if (gvDepositBeneficiary.SelectedRows.Count > 0)
        {
            if (gvDepositBeneficiary.DataKeys.Count > 0)
            {
                decimal? dpt_id = Convert.ToDecimal(gvDepositBeneficiary.DataKeys[gvDepositBeneficiary.SelectedRows[0]].Values[0]);


                if (dpt_id == null)
                {
                    Response.Write("<script>alert('Не вибрано депозитний договір!');</script>");
                    return;
                }
                else
                {
                    String trus_id = Convert.ToString(gvDepositBeneficiary.DataKeys[gvDepositBeneficiary.SelectedRows[0]].Values[3]);

                    String cust_id = Request.QueryString["cust_id"];

                    if (!Tools.card_account_exists(Convert.ToDecimal(cust_id), 0))
                    {
                        throw new DepositException("В клієнта відсутній картковий рахунок. Реєстрація неможлива!");
                        return;
                    }

                    DBLogger.Info("Користувач обрав \"Вступ в право власності\" на депозит #" + dpt_id.ToString() +
                        " клієнтом з РНК=" + cust_id, "deposit");
                   

                    Response.Redirect("/barsroot/deposit/deloitte/DepositAgreementPrint.aspx?dpt_id=" + dpt_id.Value.ToString() +
                        "&agr_id=7&idtr=" + trus_id + "&rnk=" + cust_id + "&scheme=DELOITTE");
                }
            }
        }
    }


    /// <summary>
    /// Вступ в права власника малолітньої особи(зміна власника + рахунків виплати)
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSetChild_Click(object sender, EventArgs e)
    {
        if (gvDepositChildren.SelectedRows.Count > 0)
        {
            if (gvDepositChildren.DataKeys.Count > 0)
            {
                decimal? dpt_id = Convert.ToDecimal(gvDepositChildren.DataKeys[gvDepositChildren.SelectedRows[0]].Values[0]);

                if (dpt_id == null)
                {
                    Response.Write("<script>alert('Не вибрано депозитний договір!');</script>");
                    return;
                }
                else
                {
                    DBLogger.Info("Користувач обрав \"Передати депозит малолітній особи\" на депозит #" + dpt_id.ToString(), "deposit");

                    decimal rnk_c = Convert.ToDecimal(gvDepositChildren.DataKeys[gvDepositChildren.SelectedRows[0]].Values[4]);

                   
                    Response.Redirect("/barsroot/deposit/deloitte/DepositEditAccount.aspx?next=print&dpt_id=" + dpt_id.ToString() +
                        "&agr_id=28&rnk_tr=" + rnk_c + "&scheme=DELOITTE" + "&template=" + "DPT_CHNG_OWNER");


                }
            }
        }
    }

    /// <summary>
    /// Додати розпорядника до депозиту малолітньої особи
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSetManager_Click(object sender, EventArgs e)
    {
        if (gvDepositChildren.SelectedRows.Count > 0)
        {
            if (gvDepositChildren.DataKeys.Count > 0)
            {
                decimal? dpt_id = Convert.ToDecimal(gvDepositChildren.DataKeys[gvDepositChildren.SelectedRows[0]].Values[0]);

                if (dpt_id == null)
                {
                    Response.Write("<script>alert('Не вибрано депозитний договір!');</script>");
                    return;
                }
                else
                {
                    // String trus_id = Convert.ToString(gvDepositChildren.DataKeys[gvDepositChildren.SelectedRows[0]].Values[3]);
                    decimal rnk_m = Convert.ToDecimal(gvDepositChildren.DataKeys[gvDepositChildren.SelectedRows[0]].Values[3]);

                    if (rnk_m != 0)
                    {
                        DBLogger.Info("По депозитному договору № " + dpt_id.ToString() + " вже є розпорядник з rnk= " + rnk_m.ToString() + ". Реєстрація неможлива!", "deposit");
                        throw new DepositException("По депозитному договору № " + dpt_id.ToString() + " вже є розпорядник з rnk= " + rnk_m.ToString() + ". Реєстрація неможлива!");
                        return;
                    }
                    String cust_id = Request.QueryString["cust_id"];

                    DBLogger.Info("Користувач обрав \"Додати розпорядника для малолітньої особи\" на депозит #" + dpt_id.ToString() + "cust_id =" + cust_id, "deposit");
                   

                    Response.Redirect("/barsroot/clientproducts/DepositClient.aspx?dpt_id=" + dpt_id.ToString() +
                        "&agr_id=26&rnk_tr=" + cust_id + "&scheme=DELOITTE" + "&template=" + "DPT_ADD_CHILD");

                }
            }
        }
    }


    /// <summary>
    /// Розмальовуємо табличку
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e != null && e.Row.RowType == DataControlRowType.DataRow)
        {
            // if (Convert.ToString(((DataRowView)row.DataItem).Row[14]) == "1"

            GridView gv = (sender as GridView);

            Int64 EADocID = Convert.ToInt64(gv.DataKeys[e.Row.DataItemIndex]["ARCHDOC_ID"]);

            if (EADocID == -1)
            {
                e.Row.ForeColor = System.Drawing.Color.Green;
            }

            if (EADocID == 0)
            {
                e.Row.Cells[1].BackColor = System.Drawing.Color.Yellow;
            }

            Int16 DPTLock = Convert.ToInt16(gv.DataKeys[e.Row.DataItemIndex]["DPT_LOCK"]);

            if (DPTLock == 1)
            {
                e.Row.ForeColor = System.Drawing.Color.Red;
                e.Row.Font.Bold = true;
            }
        }
    }

    /// <summary>
    /// Перехід на картку клієнта
    /// </summary>
    protected void btnClientCard_Click(object sender, EventArgs e)
    {
        DBLogger.Info("Користувач натиснув кнопку \"Картка Клієнта\" на сторінці \"Портфель договорів\".", "deposit");

       
        Response.Redirect("/barsroot/clientproducts/DepositClient.aspx?rnk=" + Request.QueryString["cust_id"] + "&scheme=DELOITTE");
    }

    /// <summary>
    /// Реєстрація нової картки
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnCreateCard_Click(object sender, EventArgs e)
    {
      
        Response.Redirect("/barsroot/clientproducts/SelectCardType.aspx?rnk=" + Request.QueryString["cust_id"]);
    }

    /// <summary>
    /// Друк договорів по картці
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void bntPrint_Click(object sender, EventArgs e)
    {
        if (gvCards.SelectedRows.Count > 0)
        {

            if (gvCards.DataKeys.Count > 0)
            {
                decimal? acc_acc = Convert.ToDecimal(gvCards.DataKeys[gvCards.SelectedRows[0]].Values[0]);
                string doc_id = Convert.ToString(gvCards.DataKeys[gvCards.SelectedRows[0]].Values[1]);
                DBLogger.Info("acc_acc = " + acc_acc.ToString(), "deposit");
                DBLogger.Info("DOC_ID = " + doc_id, "deposit");

                if (acc_acc == null)
                {
                    Response.Write("<script>alert('Не вибрано картковий договір!');</script>");
                    return;
                }
                else
                {
                    List<object> accList = new List<object>() { acc_acc };
                    Session["multiprint_id"] = accList;
                    List<object> accfilterList = new List<object>() { doc_id };
                    Session["multiprint_filter"] = accfilterList;
                   
                    Response.Redirect("/barsroot/printcontract/index?multiSelection=true");
                }
            }
        }

    }

    /// <summary>
    /// Перегляд картки рахунку
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnShowAccount_Click(object sender, EventArgs e)
    {
        if (gvCards.SelectedRows.Count > 0)
        {
           
            if (gvCards.DataKeys.Count > 0)
            {
                decimal? acc = Convert.ToDecimal(gvCards.DataKeys[gvCards.SelectedRows[0]].Values[0]);

                if (acc == null)
                {
                    Response.Write("<script>alert('Не вибрано рахунок!');</script>");
                    Response.Flush();
                }
                else
                {
                    DBLogger.Info("Користувач натиснув кнопку \"Картка рахунку\" на сторінці \"Портфель договорів\".", "deposit");

                    // Random r = new Random();
                    // &code={2} // , r.Next()
                    String url = string.Format("window.showModalDialog('/barsroot/viewaccounts/accountform.aspx?type=0&acc={0}&rnk={1}&accessmode=0',null,'dialogWidth:800px; dialogHeight:600px; center:yes; status:no');", acc.Value.ToString(), Request.QueryString["cust_id"]);

                    // Перегляд атрибутів рахунку
                    ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "ShowAccountCard", url, true);
                }
            }
        }
    }
    /// <summary>
    /// Перегляд картки рахунку
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void MainTabChanged_Click(object sender, EventArgs e)
    {

        ViewState["ActiveMainTabindex"] = TabMainContainer.ActiveTabIndex;

    }
    /// <summary>
    /// Перегляд картки рахунку
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void DepositTabChanged_Click(object sender, EventArgs e)
    {
        ViewState["ActiveDepositTabindex"] = TabDepositContainer.ActiveTabIndex;
    }
}