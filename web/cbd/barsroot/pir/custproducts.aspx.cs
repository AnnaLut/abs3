using Pir;
using Oracle.DataAccess.Client;
using System;
using System.Collections;
using System.Data;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;

using FastReport;
using FastReport.Web;
using FastReport.Data;

public partial class pir_custproducts : Bars.BarsPage
{
    string url = "";
    string staff_mfo = "";
    string crt_mfo_name = "";
    string staff_id = "";
    string staff_branch = "";
    string crt_branch_name = "";
    string fio_ext = null;
    string bdate_ext = null;
    decimal doctype_ext = 0;
    string docser_ext = null;
    string docnum_ext = null;
    string inn_ext = null;
    string type = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!String.IsNullOrEmpty(Session["PIR_RNK"] as string) && !String.IsNullOrEmpty(Session["PIR_LOCALRNK"] as string))
            {
                SearchOrCreateBid();
            }
            else
            {
                Server.Transfer("/barsroot/pir/custinfo.aspx");
            }
        }
    }

    protected void raise_empty_url()
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "document", "alert('Не вказано шлях до Вебсервісу кримського РУ. Зверніться до адміністратора');", true);
    }

    protected void SearchOrCreateBid()
    {
        decimal? p_local_rnk = Convert.ToDecimal(Session["PIR_LOCALRNK"]);
        InitOraConnection();

        try
        {

            // получаем ключ юзера (2 символа из REGNCODE + таб. номер из staff - итого 8 символов ) и банковскую дату 
            ArrayList reader = SQL_reader("select val||docsign.GetIdOper, to_char(bankdate, 'YYYY/MM/DD HH:mm:ss') from params where par='REGNCODE'");
            tbKeyID.Value = Convert.ToString(reader[0]);
            hKeyId.Value = Convert.ToString(reader[0]); // можно тоже в hidden поле 
            hBankDate.Value = Convert.ToString(reader[1]);
            hBuffer.Value = Convert.ToString(SQL_SELECT_scalar("select /*тут типа визов функции получения буфера*/ 'This is buffer'  from dual"));

            object[] l_res = SQL_SELECT_reader("select VAL from params where par = 'PIR_SERVICE'");
            if (null != l_res)
            {
                url = Convert.ToString(l_res[0]);
            }

            l_res = SQL_SELECT_reader("select a.VAL, b.VAL from params$base a,params$base b where a.par = 'MFO' and b.par = 'NAME'");
            if (null != l_res)
            {
                staff_mfo = Convert.ToString(l_res[0]);
                crt_mfo_name = Convert.ToString(l_res[1]);
                lbOurBranch.Text = crt_mfo_name.ToString();
            }

            l_res = SQL_SELECT_reader("select s.id||'_'||s.logname||'_'||s.fio as staff_id,s.branch, b.name from  staff$base s, branch b  where s.id = bars.user_id and s.branch = b.branch");
            if (null != l_res)
            {
                staff_id = Convert.ToString(l_res[0]);
                staff_branch = Convert.ToString(l_res[1]);
                crt_branch_name = Convert.ToString(l_res[2]);
            }
        }

        finally
        {
            DisposeOraConnection();
        }


        ServicePointManager.ServerCertificateValidationCallback = delegate(object s, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors) { return true; };

        string p_cust_rnk = Session["PIR_RNK"].ToString();

        PirService service = new Pir.PirService();

        //service.WsHeaderValue = new WsHeader()
        //{
        //    Password = WebConfigurationManager.AppSettings["pcur.Password"],
        //    UserName = WebConfigurationManager.AppSettings["pcur.UserName"]
        //};

        if (url == "")
        {
            raise_empty_url();
            return;
        }
        else
        {
            service.Url = url;
        }
        PirRequestCustData CustInfo = service.GetCustInfo(p_cust_rnk, null, null, null, null, null, null);

        if (CustInfo.PirCustData.Length > 0)
        {
            lbRnkVal.Text = p_cust_rnk.ToString();
            lbFioVal.Text = String.IsNullOrEmpty(CustInfo.PirCustData[0].Nmk) ? "&nbsp" : CustInfo.PirCustData[0].Nmk;
            lblDocumentVal.Text = String.IsNullOrEmpty(CustInfo.PirCustData[0].Passp) ? "&nbsp" : CustInfo.PirCustData[0].Passp;
            lbInnVal.Text = String.IsNullOrEmpty(CustInfo.PirCustData[0].Okpo) ? "&nbsp" : CustInfo.PirCustData[0].Okpo;
            lbBirthVal.Text = String.IsNullOrEmpty(CustInfo.PirCustData[0].Bday) ? "&nbsp" : CustInfo.PirCustData[0].Bday;
            lbRnkExVal.Text = String.IsNullOrEmpty(Session["PIR_LOCALRNK"] as string) ? "&nbsp" : Session["PIR_LOCALRNK"].ToString();
            lbFioExVal.Text = String.IsNullOrEmpty(Session["PIR_LOCALFIO"] as string) ? "&nbsp" : Session["PIR_LOCALFIO"].ToString();
            lbBirthExVal.Text = String.IsNullOrEmpty(Session["PIR_LOCALBIRTH"] as string) ? "&nbsp" : Session["PIR_LOCALBIRTH"].ToString();
            lbPassportExVal.Text = String.IsNullOrEmpty(Session["PIR_LOCALPASSP"] as string) ? "&nbsp" : Session["PIR_LOCALPASSP"].ToString();
            lbInnExVal.Text = String.IsNullOrEmpty(Session["PIR_LOCALINN"] as string) ? "&nbsp" : Session["PIR_LOCALINN"].ToString();
        }


        PirResponseReqInfo ReqRes = service.GetReqId(Convert.ToDecimal(p_cust_rnk), p_local_rnk);

        // ResponseBidInfo Bidres = service.GetBitId(Convert.ToDecimal(p_cust_rnk), p_local_rnk);

        if (ReqRes.Kind.ToString() == "Error")
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + ReqRes.Errors[0].Message + "');", true);
            //Server.Transfer("/barsroot/pcur/custinfo.aspx");
            pnCustInfo.Visible = false;
            gv.Visible = false;
            btPrint.Enabled = false;
            btPrint2.Enabled = false;
            btReset.Enabled = false;
            btSave.Enabled = false;
            btVisa.Enabled = false;
            lbErr.Text = ReqRes.Errors[0].Message;
            lbGvTitle.Visible = false;
            btBack.Enabled = true;
        }

        if (ReqRes.ReqId != 0)
        {
            inBidId.Value = ReqRes.ReqId.ToString();
            //если заявка уже создана
            lbGvTitle.Text = "Продукти клієнта (РНК " + p_cust_rnk + ") згідно заявки № " + ReqRes.ReqId.ToString();

            lblReqNumber.Text = ReqRes.ReqId.ToString();
            lblReqState.Text = ReqRes.ReqStatusName.ToString();
            lblReqDateCreate.Text = ReqRes.ReqCreateDate.ToString();
            lbReqStaffCreate.Text = ReqRes.ReqCreateUserName.ToString();
            lblReqMFO.Text = ReqRes.ReqCreateMfo.ToString();
            lblBranch.Text = ReqRes.ReqCreateBranch.ToString();


            //lblReqDateCreate.Text = Bidres

            if (ReqRes.ReqStatus == "NEW" || ReqRes.ReqStatus == "CREATE_CLIENT")
            {
                gv.AutoGenerateCheckBoxColumn = true;
                btVisa.Visible = false;
                btReset.Visible = false;
                btSave.Visible = true;
                type = "1";
                btPrint.Visible = false;
                btPrint2.Visible = false;
            }
            else
            {
                gv.AutoGenerateCheckBoxColumn = false;
                btSave.Visible = false;
                btPrint.Visible = true;
                btPrint2.Visible = true;
                type = "2";

                if (ReqRes.ReqStatus == "VISA_RU")
                {
                    
                    lbGvTitle.Text += " (Заявка завізована)";
                    btPrint.Visible = true;
                    btPrint2.Visible = true;
                }

                if (ReqRes.ReqStatus == "APPROVED")
                {
                    btReset.Visible = true;
                    btVisa.Visible = true;
                }
                else
                {
                    btReset.Visible = false;
                    btVisa.Visible = false;
                }
            }

            ResponseReqData res = service.GetReqData(ReqRes.ReqId, type);

            //ResponseBidData res = service.GetBidData(Bidres.BidId, type);

            var k = res.Kind;
            var r = res.Errors;

            gv.DataSource = res.PirReqData;
            gv.DataBind();
        }
        else
        {
            InitOraConnection();

            try
            {
                object[] l_res = SQL_SELECT_reader(@"select c.nmk,
                                                       to_char(p.bday,'dd.mm.yyyy') bday,
                                                       p.passp,
                                                       p.ser,                                                        
                                                       p.numdoc,
                                                       c.okpo
                                                     from customer c,
                                                       person p,
                                                       passp pp 
                                                     where c.rnk = p.rnk
                                                       and p.passp = pp.passp
                                                       and c.date_off is null
                                                       and c.custtype = 3
                                                       and nvl(trim(c.sed), '00') != '91'
                                                       and c.rnk =" + p_local_rnk);

                if (null != l_res)
                {
                    fio_ext = Convert.ToString(l_res[0]);
                    bdate_ext = Convert.ToString(l_res[1]);
                    doctype_ext = Convert.ToDecimal(l_res[2]);
                    docser_ext = Convert.ToString(l_res[3]);
                    docnum_ext = Convert.ToString(l_res[4]);
                    inn_ext = Convert.ToString(l_res[5]);
                }
            }

            finally
            {
                DisposeOraConnection();
            }


            //создаём заявку
            ServicePointManager.ServerCertificateValidationCallback = delegate(object s, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors) { return true; };

            // decimal? p_local_rnk = Convert.ToDecimal(Session["PCUR_LOCALRNK"]);

            PirService Createservice = new Pir.PirService();

            //KrvpCustInfo Createservice = new Krvp.KrvpCustInfo();

            //Createservice.WsHeaderValue = new WsHeader()
            //{
            //    Password = WebConfigurationManager.AppSettings["pcur.Password"],
            //    UserName = WebConfigurationManager.AppSettings["pcur.UserName"]
            //};



            if (url == "")
            {
                raise_empty_url();
                return;
            }
            else
            {
                Createservice.Url = url;
            }
            ResponseCreateReq NewReqRes = Createservice.CreateReq(staff_id, staff_mfo, crt_mfo_name, staff_branch, crt_branch_name,
                                                                  Convert.ToDecimal(p_cust_rnk), Convert.ToDecimal(p_local_rnk), fio_ext, bdate_ext, doctype_ext, docser_ext, docnum_ext, inn_ext);

            //  ResponseCreateBid NewBidres = Createservice.CreateBid(staff_id, staff_mfo, crt_mfo_name, staff_branch, crt_branch_name,
            //                                                        Convert.ToDecimal(p_cust_rnk), Convert.ToDecimal(p_local_rnk), fio_ext, bdate_ext, doctype_ext, docser_ext, docnum_ext, inn_ext);

            if (NewReqRes.Kind.ToString() == "Error")
            {
                var err = NewReqRes.Errors[0].Message;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + err.Replace('"', ' ') + "');", true);
            }
            else
            {
                decimal new_id = NewReqRes.NewDiReq;

                OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
                OracleCommand cmd = con.CreateCommand();
                try
                {
                    decimal l_bid_id = new_id;
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("p_local_rnk", OracleDbType.Decimal, 38, p_local_rnk, ParameterDirection.Input);
                    cmd.BindByName = true;
                    cmd.CommandText = @"select a.kf,
                                          a.rnk,
                                          a.nls,
                                          a.kv,
                                          a.branch 
                                        from accounts a , w4_acc w
                                        where a.rnk = :p_local_rnk 
                                          and a.nbs = '2625'
                                          and a.acc = w.acc_pk
                                          and w.card_code in ('STND_CRIMEA_UAH_1_VELCTR_30','STND_CRIMEA_USD_1_VELCTR_30','STND_CRIMEA_EUR_1_VELCTR_30')";

                    OracleDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {

                        PirRequestResult AddCustAcc = Createservice.SetCustAcc(l_bid_id, rdr["kf"].ToString(), Convert.ToDecimal(rdr["rnk"]), rdr["nls"].ToString(), Convert.ToDecimal(rdr["kv"]), rdr["branch"].ToString());
                        //RequestKrvpResult AddCustAcc = Createservice.CustAcc(l_bid_id, rdr["kf"].ToString(), Convert.ToDecimal(rdr["rnk"]), rdr["nls"].ToString(), Convert.ToDecimal(rdr["kv"]), rdr["branch"].ToString());
                        if (AddCustAcc.Kind.ToString() == "Error")
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('При виконанні операції виникли помилки');", true);
                            return;
                        }
                    }
                }
                catch (System.Exception e)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert(" + e.Message + ");", true);
                }
                finally
                {
                    con.Close();
                    cmd.Dispose();
                    con.Dispose();
                }


                lbGvTitle.Text = "Продукти клієнта(РНК=" + p_cust_rnk + ") згідно заявці № " + NewReqRes.NewDiReq.ToString();

                lblReqNumber.Text = NewReqRes.NewDiReq.ToString();
                lblReqState.Text = "Створено клієнта ";
                lblReqDateCreate.Text = DateTime.Now.ToShortDateString();
                lbReqStaffCreate.Text = staff_id.ToString();
                lblReqMFO.Text = crt_mfo_name + " ( МФО " + staff_mfo + " )";
                lblBranch.Text = staff_branch + " ( " + crt_branch_name + " )";

                ResponseReqData res = service.GetReqData(new_id, "1");

                //ResponseBidData res = service.GetBidData(new_id, "1");

                gv.AutoGenerateCheckBoxColumn = true;
                btVisa.Visible = false;
                btReset.Visible = false;
                btSave.Visible = true;
                btPrint.Visible = false;
                btPrint2.Visible = false;

                inBidId.Value = new_id.ToString();

                gv.DataSource = res.PirReqData;
                gv.DataBind();
            }
        }
    }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        string buff = strBuf.Value;



        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (DataBinder.Eval(e.Row.DataItem, "APPROVED").ToString() == "1")
            {
                buff += inBidId.Value + " " + e.Row.Cells[0].Text + " " + e.Row.Cells[1].Text + " " + e.Row.Cells[2].Text + " " +
                        e.Row.Cells[3].Text + " " + e.Row.Cells[4].Text + " " + e.Row.Cells[5].Text + " " +
                        e.Row.Cells[6].Text + " " + e.Row.Cells[7].Text;
            }
            strBuf.Value = buff;
        }
    }

    protected void btBack_Click(object sender, EventArgs e)
    {
        Session["PIR_RNK"] = null;
        Response.Redirect("/barsroot/pir/custinfo.aspx");
    }

    protected void btSave_Click(object sender, EventArgs e)
    {
        string p_deal_id = "";
        string p_deal_type = "";
        string p_bid_id = inBidId.Value;
        int p_count = 0;
        string kind = "";
        //string url = "";
        //string staff_id = "";

        InitOraConnection();

        try
        {
            object[] l_res = SQL_SELECT_reader("select VAL from params where par = 'PIR_SERVICE'");
            if (null != l_res)
            {
                url = Convert.ToString(l_res[0]);
            }

            l_res = SQL_SELECT_reader("select s.id||'_'||s.logname||'_'||s.fio as staff_id from  staff$base s where s.id = bars.user_id");
            if (null != l_res)
            {
                staff_id = Convert.ToString(l_res[0]);
            }
        }

        finally
        {
            DisposeOraConnection();
        }

        foreach (int row in gv.GetSelectedIndices())
        {
            p_deal_id = gv.DataKeys[row]["DEAL_ID"].ToString();
            p_deal_type = gv.DataKeys[row]["DEAL_TYPE"].ToString();

            PirService Createservice = new Pir.PirService();

            //KrvpCustInfo Createservice = new Krvp.KrvpCustInfo();

            //Createservice.WsHeaderValue = new WsHeader()
            //{
            //    Password = WebConfigurationManager.AppSettings["pcur.Password"],
            //    UserName = WebConfigurationManager.AppSettings["pcur.UserName"]
            //};

            if (url == "")
            {
                raise_empty_url();
                return;
            }
            else
            {
                Createservice.Url = url;
            }
            PirRequestResult NewReqres = Createservice.SetReqApprove(Convert.ToDecimal(p_bid_id), p_deal_type, Convert.ToDecimal(p_deal_id), staff_id);

            kind = NewReqres.Kind.ToString();
            var m = NewReqres.Errors;
            p_count = p_count + 1;
        }

        if (p_count == 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Не вибрано жодного радка');", true);
        }

        if (kind == "Success")
        {
            btSave.Visible = false;
            btReset.Visible = true;
            btVisa.Visible = true;
        }
        else
        {
            btSave.Visible = true;
            btReset.Visible = false;
            btVisa.Visible = false;
        }

        Response.Redirect("custproducts.aspx");
    }

    protected void btReset_Click(object sender, EventArgs e)
    {
        string url = "";
        string p_bid_id = inBidId.Value;
        string staff_id = "";

        InitOraConnection();

        try
        {
            object[] l_res = SQL_SELECT_reader("select VAL from params where par = 'PIR_SERVICE'");
            if (null != l_res)
            {
                url = Convert.ToString(l_res[0]);
            }

            l_res = SQL_SELECT_reader("select s.id||'_'||s.logname||'_'||s.fio as staff_id from  staff$base s where s.id = bars.user_id");
            if (null != l_res)
            {
                staff_id = Convert.ToString(l_res[0]);
            }
        }

        finally
        {
            DisposeOraConnection();
        }

        PirService service = new Pir.PirService();
        //   KrvpCustInfo service = new Krvp.KrvpCustInfo();

        //service.WsHeaderValue = new WsHeader()
        //{
        //    Password = WebConfigurationManager.AppSettings["pcur.Password"],
        //    UserName = WebConfigurationManager.AppSettings["pcur.UserName"]
        //};

        if (url == "")
        {
            raise_empty_url();
            return;
        }
        else
        {
            service.Url = url;
        }
        PirRequestResult Deapprov = service.SetReqDeapprove(Convert.ToDecimal(p_bid_id), staff_id);

        //  RequestKrvpResult Deapprov = service.DeapproveBid(Convert.ToDecimal(p_bid_id), staff_id);
        if (Deapprov.Kind.ToString() == "Error")
        {
            string msg = @"При виконанні операції виникли помилки: " + Deapprov.Errors[0].Message.ToString().Replace("\"", "").Replace("  ","").Replace("\n"," ");

            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + msg + "');", true);
            return;
        }
        Response.Redirect("/barsroot/pir/custproducts.aspx");
    }
    protected void tbVisa_Click(object sender, EventArgs e)
    {
        string p_req_id = inBidId.Value;
        string p_user_upd = "";
        string p_buff = hSignedBuffer.Value;
        string url = "";


        if (!String.IsNullOrEmpty(hSignedBuffer.Value))
        {
            InitOraConnection();

            try
            {
                object[] l_res = SQL_SELECT_reader("select VAL from params where par = 'PIR_SERVICE'");
                if (null != l_res)
                {
                    url = Convert.ToString(l_res[0]);
                }

                l_res = SQL_SELECT_reader("select s.id||'_'||s.logname||'_'||s.fio as staff_id from  staff$base s where s.id = bars.user_id");
                if (null != l_res)
                {
                    p_user_upd = Convert.ToString(l_res[0]);
                }
            }

            finally
            {
                DisposeOraConnection();
            }

            PirService service = new Pir.PirService();

            //service.WsHeaderValue = new WsHeader()
            //{
            //    Password = WebConfigurationManager.AppSettings["pcur.Password"],
            //    UserName = WebConfigurationManager.AppSettings["pcur.UserName"]
            //};

            if (url == "")
            {
                raise_empty_url();
                return;
            }
            else
            {
                service.Url = url;
            }

            PirRequestResult SetEdsRu = service.SetEdsRu(Convert.ToDecimal(p_req_id), p_user_upd, p_buff);
            if (SetEdsRu.Kind.ToString() == "Error")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('При виконанні операції виникли помилки');", true);
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('При виконанні підпису виникли помилки');", true);
        }
        Server.Transfer("custproducts.aspx");
    }
    //protected void print1_Click(object sender, EventArgs e)
    //{
    //    //   string link = "~/dynmodal.aspx?form=fr&frt=test";
    //    //   Response.Redirect(link);

    //    ScriptManager.RegisterStartupScript(this, this.GetType(), "document", "Print1();", true);


    //}
    protected void print_Click(object sender, EventArgs e)
    {


        FrxDoc doc = new FrxDoc(FrxDoc.GetTemplatePathByFileName("test.frx"), GetParams(), this);
        doc.Print(FrxExportTypes.Pdf);

        InitOraConnection();
        try
        {
            //SQL_NONQUERY("begin delete from pir_report_data d where d.user_id = bars.user_id; end;");
        }
        finally
        {
            DisposeOraConnection();
        }
    }

    protected void print2_Click(object sender, EventArgs e)
    {


        FrxDoc doc = new FrxDoc(FrxDoc.GetTemplatePathByFileName("test_v1.frx"), GetParams(), this);
        doc.Print(FrxExportTypes.Pdf);

        InitOraConnection();
        try
        {
            //SQL_NONQUERY("begin delete from pir_report_data d where d.user_id = bars.user_id; end;");
        }
        finally
        {
            DisposeOraConnection();
        }
    }

    private FrxParameters GetParams()
    {
        InitOraConnection();
        try
        {
            object[] l_res = SQL_SELECT_reader("select VAL from params where par = 'PIR_SERVICE'");
            if (null != l_res)
            {
                url = Convert.ToString(l_res[0]);
            }
        }
        finally
        {
            DisposeOraConnection();
        }

        PirService service = new Pir.PirService();
        //KrvpCustInfo service = new Krvp.KrvpCustInfo();

        //service.WsHeaderValue = new WsHeader()
        //{
        //    Password = WebConfigurationManager.AppSettings["pcur.Password"],
        //    UserName = WebConfigurationManager.AppSettings["pcur.UserName"]
        //};
        if (url == "")
        {
            raise_empty_url();
        }
        else
        {
            service.Url = url;
        }

        ResponseReqData res = service.GetReqData(Convert.ToDecimal(inBidId.Value), "2");
        //ResponseBidData res = service.GetBidData(Convert.ToDecimal(inBidId.Value), "2");

        InitOraConnection();

        try
        {
            ClearParameters();

            SetParameters("p_cust_rnk", DB_TYPE.Decimal, Convert.ToDecimal(lbRnkVal.Text), DIRECTION.Input);
            SetParameters("p_cust_nmk", DB_TYPE.Varchar2, lbFioVal.Text, DIRECTION.Input);
            SetParameters("p_cust_doc", DB_TYPE.Varchar2, lblDocumentVal.Text, DIRECTION.Input);
            SetParameters("p_cust_code", DB_TYPE.Varchar2, lbInnVal.Text, DIRECTION.Input);
            SetParameters("p_cust_bdate", DB_TYPE.Varchar2, lbBirthVal.Text, DIRECTION.Input);
            SetParameters("p_cust_local_rnk", DB_TYPE.Decimal, Convert.ToDecimal(lbRnkExVal.Text), DIRECTION.Input);
            SetParameters("p_bid_id", DB_TYPE.Decimal, Convert.ToDecimal(inBidId.Value), DIRECTION.Input);

            SQL_NONQUERY("begin delete from pir_report_data d where d.user_id = bars.user_id; end;");

            SQL_NONQUERY(@"begin 
                             insert into pir_report_data values(
                               s_rie_report_data.nextval,
                               bars.user_id,
                               'cust_info',
                               :p_cust_rnk,
                               :p_cust_nmk,
                               :p_cust_doc,
                               :p_cust_code,
                               to_date(:p_cust_bdate,'dd.mm.yyyy'),
                               :p_cust_local_rnk,
                               :p_bid_id,
                               null,
                               null,
                               null,
                               null,
                               null,
                               null,
                               null,
                               null,
                               null);
                           end;");

            if (res.PirReqData.Length > 0)
            {
                for (int i = 0; i < res.PirReqData.Length; i++)
                {
                    ClearParameters();

                    SetParameters("p_deal_type", DB_TYPE.Varchar2, res.PirReqData[i].deal_type, DIRECTION.Input);
                    SetParameters("p_deal_id", DB_TYPE.Decimal, res.PirReqData[i].deal_id, DIRECTION.Input);
                    SetParameters("p_deal_num", DB_TYPE.Varchar2, res.PirReqData[i].deal_num, DIRECTION.Input);
                    SetParameters("p_sdate", DB_TYPE.Varchar2, res.PirReqData[i].sdate, DIRECTION.Input);
                    SetParameters("p_comm", DB_TYPE.Varchar2, res.PirReqData[i].comm, DIRECTION.Input);
                    SetParameters("p_sum", DB_TYPE.Decimal, res.PirReqData[i].summ, DIRECTION.Input);
                    SetParameters("p_sumproc", DB_TYPE.Decimal, res.PirReqData[i].summproc, DIRECTION.Input);
                    SetParameters("p_kv", DB_TYPE.Decimal, res.PirReqData[i].kv, DIRECTION.Input);
                    SetParameters("p_ref", DB_TYPE.Decimal, res.PirReqData[i].reff, DIRECTION.Input);

                    SQL_NONQUERY(@"begin 
                             insert into pir_report_data values(
                               s_rie_report_data.nextval,
                               bars.user_id,
                               'bid_data',
                               null,
                               null,
                               null,
                               null,
                               null,
                               null,
                               null,
                               :p_deal_type,
                               :p_deal_id,
                               :p_deal_num,
                               to_date(:p_sdate,'dd.mm.yyyy'),
                               :p_comm,
                               :p_sum*100,
                               :p_sumproc*100,
                               :p_kv,
                               :p_ref);
                           end;");
                }
            }
        }
        finally
        {
            DisposeOraConnection();
        }

        FrxParameters pars = new FrxParameters();
        return pars;
    }
    protected void btViewHistory_Click(object sender, EventArgs e)
    {
        var rnd = DateTime.Now;

        ScriptManager.RegisterStartupScript(this, this.GetType(), "document", "ViewHistory('" + rnd + "');", true);
    }
}
