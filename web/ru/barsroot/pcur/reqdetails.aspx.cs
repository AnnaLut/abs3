using System.Linq;
using Bars.Classes;
using Microsoft.Ajax.Utilities;
using Oracle.DataAccess.Client;
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class pcur_reqdetails_aspx : Bars.BarsPage
{
    private decimal? _currentReqId;
    private string _fullConnectionString;
    private bool _tnansAccountsAlreadyCreated;
    private bool _reqHasApprovedProducts;
    private bool _credsAlreadyBuilded;
    private double _credsSum;

    protected void Page_Load()
    {
        _fullConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        _currentReqId = Convert.ToDecimal(Session["PCUR_REQID"]);
    }

    protected override void OnPreRender(EventArgs e)
    {
        FillUserInfo(_currentReqId);
        FillBpkGrid(_currentReqId);
        FillProductsGrid(_currentReqId);
        FillTransitAccounts(_currentReqId);
        FillCredits(_currentReqId);
    }
    private void FillUserInfo(decimal? reqId)
    {
        //достаем детальную информацию о клиенте
        OracleConnection _con = OraConnector.Handler.IOraConnection.GetUserConnection();
        try
        {
            OracleCommand cmdClient = _con.CreateCommand();
            cmdClient.CommandType = CommandType.Text;
            cmdClient.CommandText =
                @"select cd.*, 
                coalesce(p.name, '') || ' ' || coalesce(cd.doc_ser, ' ') || coalesce(cd.doc_num, ' ') as doc_type_name,
                coalesce(p_ext.name, '') || ' ' || coalesce(cd.doc_ser_ext, ' ') || coalesce(cd.doc_num_ext, ' ') as doc_type_name_ext
                from pir_req_clients_data cd 
                left join passp p on p.passp = cd.doc_type 
                left join passp p_ext on p_ext.passp = cd.doc_type_ext
                where req_id = :preqid";
            cmdClient.Parameters.Add("pReqId", reqId);
            OracleDataReader rdr = cmdClient.ExecuteReader();
            rdr.Read();
            if (rdr.HasRows)
            {
                
                lbRnkVal.Text = rdr["RNK"].ToString() != "" ? rdr["RNK"].ToString() + @"&nbsp;" : "";
                lbFioVal.Text = rdr["FIO"].ToString() != "" ? rdr["FIO"].ToString() + @"&nbsp;" : "";
                lblDocumentVal.Text = rdr["DOC_TYPE_NAME"].ToString() != "" ? rdr["DOC_TYPE_NAME"].ToString() : "";
                lbBirthVal.Text = rdr["BDATE"].ToString() != ""
                    ? rdr.GetDateTime(rdr.GetOrdinal("BDATE")).ToShortDateString()
                    : "--";
                lbInnVal.Text = rdr["INN"].ToString() != "" ? rdr["INN"].ToString() : "";

                lbRnkExVal.Text = rdr["RNK_EXT"].ToString() != "" ? rdr["RNK_EXT"].ToString() : "";
                lblFieExt.Text = rdr["FIO_EXT"].ToString() != "" ? rdr["FIO_EXT"].ToString() : "";
                lbBirthExt.Text = rdr["BDATE_EXT"].ToString() != ""
                    ? rdr.GetDateTime(rdr.GetOrdinal("BDATE_EXT")).ToShortDateString()
                    : "";
                lblDocumentValExt.Text = rdr["DOC_TYPE_NAME_EXT"].ToString() != "" ? rdr["DOC_TYPE_NAME_EXT"].ToString() : "";
                lbInnValExt.Text = rdr["INN_EXT"].ToString() != "" ? rdr["INN_EXT"].ToString() : "";
                
            }

            cmdClient = _con.CreateCommand();
            cmdClient.CommandText = @"select req.id, req.mfo, b.nb as bank_name, br.name as branch_name, req.crt_date, rs.name as state_name, req.crt_staff
                from pir_requests req 
                left join banks b on req.mfo = b.mfo 
                left join branch br on req.branch = br.branch 
                left join pir_req_states rs on req.state_id = rs.id
                where req.id = :preqid";
            cmdClient.Parameters.Add("pReqId", reqId);
            rdr = cmdClient.ExecuteReader();
            rdr.Read();
            if (rdr.HasRows)
            {
                lblOurRu.Text = rdr["bank_name"].ToString();
                lblReqNumber.Text = rdr["ID"].ToString();
                lblReqMFO.Text = rdr["MFO"].ToString();
                lblReqDateCreate.Text = rdr["CRT_DATE"].ToString();
                lblFilialName.Text = rdr["bank_name"].ToString();
                lblBranch.Text = rdr["branch_name"].ToString();
                lblReqState.Text = rdr["state_name"].ToString();
				lblCreatorName.Text = rdr["crt_staff"].ToString();
            }
        }
        finally
        {
            _con.Close();
        }
    }
    private void FillProductsGrid(decimal? reqId)
    {
        //достанем данные о договорах (депозитах)
        dsDeals.SelectCommand = "select t.*, CASE APPROVED WHEN 0 THEN 'Ні' ELSE 'Так' END AS APPROVED_C, '' as dummy  from v_pir_deals_data_doc t where req_id = :pReqId";
        dsDeals.ConnectionString = _fullConnectionString;
        dsDeals.SelectParameters.Add("pReqId", TypeCode.Int32, reqId.ToString());
        dsDeals.DataBind();

        //уствановим видимость кнопки открытия счетов
        OracleConnection _con = OraConnector.Handler.IOraConnection.GetUserConnection();
        try
        {
            OracleCommand cmdClient = _con.CreateCommand();
            cmdClient.CommandType = CommandType.Text;
            cmdClient.CommandText = "select count(*) from table(pir_request.getReqDealInfo(:pReqId)) where approved = 1";
            cmdClient.Parameters.Add("pReqId", reqId);
            _reqHasApprovedProducts = int.Parse(cmdClient.ExecuteScalar().ToString()) > 0;
        }
        finally
        {
            _con.Close();
        }
        btnCreateAccs.Enabled = _reqHasApprovedProducts;
    }

    private void FillBpkGrid(decimal? reqId)
    {
        dsBpk.SelectCommand = "select * from pir_req_cards where req_id = :pReqId";
        dsBpk.ConnectionString = _fullConnectionString;
        dsBpk.SelectParameters.Add("pReqId", TypeCode.Int32, reqId.ToString());
        dsBpk.DataBind();
    }

    private void FillTransitAccounts(decimal? reqId)
    {
        //управление видимостью и доступностью елементов касающихся транзитных счетов
        OracleConnection _con = OraConnector.Handler.IOraConnection.GetUserConnection();
        try
        {
            OracleCommand cmdClient = _con.CreateCommand();
            cmdClient.CommandType = CommandType.Text;
            cmdClient.CommandText = "select count(*) from v_pir_nls2909 where rnk = pir_request.get_rnk_reqid(:pReqId)";
            cmdClient.Parameters.Add("pReqId", reqId);
            _tnansAccountsAlreadyCreated = int.Parse(cmdClient.ExecuteScalar().ToString()) > 0;

            //видимость блока с таблицей счетов
            dvTransAccsTitle.Visible = _tnansAccountsAlreadyCreated;
            gvTransAccs.Visible = _tnansAccountsAlreadyCreated;
            if (_tnansAccountsAlreadyCreated)
            {
                dsTransAccs.SelectCommand = "select * from v_pir_nls2909 where rnk = pir_request.get_rnk_reqid(:pReqId)";
                dsTransAccs.ConnectionString = _fullConnectionString;
                dsTransAccs.SelectParameters.Add("pReqId", TypeCode.Int32, reqId.ToString());
                gvTransAccs.DataBind();
            }
        }
        finally
        {
            _con.Close(); 
        }

        //доступность кнопки создания транзитных счетов (если счета еще не созданы и есть подтвержденный продукты в заявке)
        btnCreateAccs.Enabled = _reqHasApprovedProducts && !_tnansAccountsAlreadyCreated;
        //доступность кнопки перечисления на транзитные счета
        btnTransferBalance.Enabled = _tnansAccountsAlreadyCreated;
    }

    private void FillCredits(decimal? reqId)
    {
        //управление доступностью кнопки расчета задолженостей
        OracleConnection _con = OraConnector.Handler.IOraConnection.GetUserConnection();
        try
        {
            OracleCommand cmdClient = _con.CreateCommand();
            cmdClient.CommandType = CommandType.Text;
            cmdClient.CommandText = "select count(*) as c, sum(summ) as s from PIR_REQ_CREDITS_DATA where req_id = :reqid";
            cmdClient.Parameters.Add("pReqId", reqId);

            _credsSum = 0;
            OracleDataReader rdr = cmdClient.ExecuteReader();
            rdr.Read();
            if (rdr.HasRows)
            {
                _credsAlreadyBuilded = Convert.ToInt32(rdr["c"]) > 0;
                //рассчитаем также общую сумму задолжености по кредитам
                if (_credsAlreadyBuilded)
                {
                    _credsSum = Convert.ToDouble(rdr["s"]);
                }
            }
        }
        finally
        {
            _con.Close();
        }

        btnCalcDept.Enabled = !_credsAlreadyBuilded;

        //отобразим список с кредитами если они уже посчитаны
        dvCreds.Visible = _credsAlreadyBuilded;
        gvCreds.Visible = _credsAlreadyBuilded;
        
        dsCreds.SelectCommand = "select credit_type, nd, summ from PIR_REQ_CREDITS_DATA where req_id = :reqid";
        dsCreds.ConnectionString = _fullConnectionString;
        dsCreds.SelectParameters.Add("reqId", reqId.ToString());
        dsCreds.DataBind();
        

        //доступность кнопок конвертации задолжености, погашения задолжености и выплаты остатков
        btConvertDebt.Enabled = _credsAlreadyBuilded && (_credsSum > 0);
        btnRepayDebt.Enabled = _credsAlreadyBuilded && (_credsSum > 0);
        btnPayMoney.Enabled = _credsSum < 0.009;
        btnRepayDebt.Enabled = _credsSum >= 0.01;
    }

     protected void btBack_Click(object sender, EventArgs e)
    {
        Session["PCUR_REQID"] = null;
        Response.Redirect("/barsroot/pcur/reqinfo.aspx");
    }
     protected void btCreateAccounts_Click(object sender, EventArgs e)
     {
         //step 1 Открытие транзитных счетов
         OracleConnection _con = OraConnector.Handler.IOraConnection.GetUserConnection();
         try
         {
             OracleCommand cmdClient = _con.CreateCommand();
             cmdClient.CommandType = CommandType.StoredProcedure;
             cmdClient.CommandText = "pir_payoff.open_2909";
             cmdClient.Parameters.Add("p_reqid", _currentReqId);
             try
             {
                 cmdClient.ExecuteNonQuery();
                 ScriptManager.RegisterStartupScript(this, GetType(), "SuccessCreateAccountsAlert", "successPayAlert('Рахунки відкрито!');", true);
             }
             catch (System.Exception ex)
             {
                 string messageFunction = @"errorMessage('" + CutMessage(ex) + "');";
                 ScriptManager.RegisterStartupScript(this, GetType(), "ErrorCreateAccountsMessage", messageFunction, true);
             }
         }
         finally
         {
             _con.Close();
         }
     }
     protected void btTransferBalance_Click(object sender, EventArgs e)
     {
         //step 2 Перечисление остатков + проценты со счетов Крымского РУ на транзитные счета в разрезе валют
         OracleConnection _con = OraConnector.Handler.IOraConnection.GetUserConnection();
         try
         {
             OracleCommand cmdClient = _con.CreateCommand();
             cmdClient.CommandType = CommandType.StoredProcedure;
             cmdClient.CommandText = "pir_payoff.payoff_deals";
             cmdClient.Parameters.Add("p_reqid", _currentReqId);
             try
             {
                 cmdClient.ExecuteNonQuery();
                 ScriptManager.RegisterStartupScript(this, GetType(), "SuccessTransfeAlert", "successPayAlert('Залишки перераховано!');", true);
             }
             catch (System.Exception ex)
             {
                 string messageFunction = @"errorMessage('" + CutMessage(ex) + "');";
                 ScriptManager.RegisterStartupScript(this, GetType(), "ErrorTransferMessage", messageFunction, true);
             }
         }
         finally
         {
             _con.Close();
         }
     }
     protected void btCalcDedt_Click(object sender, EventArgs e)
     {
         //step 3  Расчет возможных задолженостей по кредитам
         OracleConnection _con = OraConnector.Handler.IOraConnection.GetUserConnection();
         try
         {
             OracleCommand cmdClient = _con.CreateCommand();
             cmdClient.CommandType = CommandType.StoredProcedure;
             cmdClient.CommandText = "pir_payoff.build_creds";
             cmdClient.Parameters.Add("p_req_id", _currentReqId);
             try
             {
                 cmdClient.ExecuteNonQuery();
                 ScriptManager.RegisterStartupScript(this, GetType(), "SuccessCalcDebtAlert", "successPayAlert('Заборгованість розраховано!');", true);
             }
             catch (System.Exception ex)
             {
                 string messageFunction = @"errorMessage('" + CutMessage(ex) + "');";
                 ScriptManager.RegisterStartupScript(this, GetType(), "ErrorCalcDebtMessage", messageFunction, true);
             }
         }
         finally
         {
             _con.Close();
         }
     }
     protected void btConvertDebt_Click(object sender, EventArgs e)
     {
         //step 4 Конвертация сум задолженностей в подходящие валюты
     }
     protected void btRepayDebt_Click(object sender, EventArgs e)
     {
         //step 5 Погашение задолженностей по кредитам
         OracleConnection _con = OraConnector.Handler.IOraConnection.GetUserConnection();
         try
         {
             OracleCommand cmdClient = _con.CreateCommand();
             cmdClient.CommandType = CommandType.StoredProcedure;
             cmdClient.CommandText = "pir_payoff.pay_creds";
             cmdClient.Parameters.Add("p_req_id", _currentReqId);
             try
             {
                 cmdClient.ExecuteNonQuery();
                 ScriptManager.RegisterStartupScript(this, GetType(), "SuccessPayAlert", "successPayAlert('Заборгованість погашено!');", true);
             }
             catch (System.Exception ex)
             {
                 string messageFunction = @"errorMessage('" + CutMessage(ex) + "');";
                 ScriptManager.RegisterStartupScript(this, GetType(), "ErrorRepayDebtMessage", messageFunction, true);
             }
         }
         finally
         {
             _con.Close();
         }
     }
     protected void btnPayMoney_Click(object sender, EventArgs e)
     {
         //step 5 Выплата депозитов 
         OracleConnection _con = OraConnector.Handler.IOraConnection.GetUserConnection();
         try
         {
             OracleCommand cmdClient = _con.CreateCommand();
             cmdClient.CommandType = CommandType.StoredProcedure;
             cmdClient.CommandText = "pir_payoff.pay_vps";
             cmdClient.Parameters.Add("p_req_id", _currentReqId);
             try
             {
                 cmdClient.ExecuteNonQuery();
                 ScriptManager.RegisterStartupScript(this, GetType(), "SuccessPayAlert", "successPayAlert('Виплату на БПК здійснео успішно!');", true);
             }
             catch (System.Exception ex)
             {
                 string messageFunction = @"errorMessage('" + CutMessage(ex) + "');";
                 ScriptManager.RegisterStartupScript(this, GetType(), "ErrorPayMessage", messageFunction, true);
             }
         }
         finally
         {
             _con.Close();
         }
     }
     private string CutMessage(System.Exception ex)
     {
         return ex.Message.Split(new[] {'\r', '\n'}).FirstOrDefault();
     }

    
}
