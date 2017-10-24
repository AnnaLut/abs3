using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;
using System.Runtime.InteropServices;
using System.Text;
using Bars.Configuration;
using Bars.DataComponents;
using Bars.Oracle;
using Bars.Classes;
using System.Web.Services;
using Dapper;
using System.Linq;

public partial class sberutls_importproc : Bars.BarsPage
{
    private const string SESS_REF_NAME = "impref";
    private const string ERR_ONLY_ONE_ROW_ACCEPTED = "Для редагування потрiбно вибрати один рядок";
    private const string SESS_READONLY_TAG = "RO";
    private void configureDs()
    {
        if (Request["tp"].ToString() == "1")
        {
            if (Request["dfilt"] != null)
            {
                var dstart = Request["dstart"];
                ds.SelectCommand = String.Format(@"select * from v_xmlimpdocs_ui 
                                                    where status=:status 
                                                    and userid = user_id 
                                                    and {0} >= TO_DATE('{1}','DD.MM.YYYY') 
                                                    and {0} <=  TO_DATE('{2}','DD.MM.YYYY') 
                                                        order by impref desc", Request["dfilt"] , Request["dstart"], Request["dEnd"]);
            }
            else
            {
                ds.SelectCommand = "select * from v_xmlimpdocs_ui where status=:status and userid = user_id order by impref desc";
            }
            dsFilter.SelectCommand = "select status, descript from xml_impstatus";
        }
        if (Request["tp"].ToString() == "2")
        {
            if (Request["dfilt"] != null)
            {
                var dstart = Request["dstart"];
                ds.SelectCommand = String.Format(@"select * from v_xmlimpdocs_ui where status=:status 
                                                    and {0} >= TO_DATE('{1}','DD.MM.YYYY') 
                                                    and {0} <=  TO_DATE('{2}','DD.MM.YYYY') 
                                                        order by impref desc", Request["dfilt"], Request["dstart"], Request["dEnd"]);
            }
            else
            {
                ds.SelectCommand = "select * from v_xmlimpdocs_ui where status=:status order by impref desc";
            }
            dsFilter.SelectCommand = "select status, descript from xml_impstatus where status not in (0,1,2)";
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["tp"] == null)
            throw new ArgumentException("Invalid parameters passed");
        //заполнить параметры datasource
        ds.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("OPER000");
        ds.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        configureDs();
        dsFilter.PreliminaryStatement = ds.PreliminaryStatement;
        dsFilter.ConnectionString = ds.ConnectionString;
        dsFilter.DataBind();
        //заголовок
        Session[SESS_REF_NAME] = null;
        lblMsg.Text = "";
        lblRes.Text = "";
        initCountDoc();
        var isf = Request["dfilt"];
    }
    protected void initCountDoc()
    {
        var docCntInf = GetCountDocs();
        V_IMPORT.Text = docCntInf.V_IMPORT;
        V_CHECK.Text = docCntInf.V_CHECK;
        V_PAYED.Text = docCntInf.V_PAYED;
        V_DELETED.Text = docCntInf.V_DELETED;
        V_ERRREQ.Text = docCntInf.V_ERRREQ;
        SUM_IMPORT.Text = String.Format("{0}",docCntInf.SUM_IMPORT);
        SUM_CHECK.Text = String.Format("{0}",docCntInf.SUM_CHECK);
        SUM_PAYED.Text = String.Format("{0}", docCntInf.SUM_PAYED );
        SUM_DELETED.Text = String.Format("{0}", docCntInf.SUM_DELETED);
        SUM_ERRREQ.Text = String.Format("{0}", docCntInf.SUM_ERRREQ);
    }
 
    protected override void OnPreRender(EventArgs e)
    {
        
        gv.DataBind();
        base.OnPreRender(e);
        Session[SESS_READONLY_TAG] = ddlFilter.SelectedIndex == 3 || ddlFilter.SelectedIndex == 4 ? "1" : null;
    }
    protected void ds_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        object obj = ddlFilter.SelectedValue;
        if (obj == null || obj.ToString() == "")
            obj = Request["tp"].ToString() == "1" ? 0 : 4;
        OracleParameter par = new OracleParameter("status", OracleDbType.Decimal, obj, System.Data.ParameterDirection.Input);
        e.Command.Parameters.Add(par);
        //hide elements for 3-deleted && 2-payed
        if (Convert.ToInt32(obj) == 3 || Convert.ToInt32(obj) == 2) {
            btnVal.Enabled = false;
            btnPay.Enabled = false;
        }
    }

    private void goProc(String procName)
    {
        decimal errcode = 0;
        decimal impref = 0;
        InitOraConnection();
        try
        {
            SetRole("OPER000");
            int errCnt = 0;
            int okCnt = 0;
            foreach (int row in gv.SelectedRows)
            {
                impref = Convert.ToDecimal(gv.DataKeys[row].Values[0]);
                ClearParameters();
                SetParameters("p_impref", DB_TYPE.Varchar2, impref, DIRECTION.Input);
                SetParameters("p_errcode", DB_TYPE.Decimal, errcode, DIRECTION.Output);
                SQL_NONQUERY(
                    "begin " +
                    "  bars_xmlklb_imp." + procName + "( " +
                    "      p_impref  => :p_impref,  " +
                    "      p_errcode => :p_errcode); " +
                    " end;");
                if ("0" == GetParameter("p_errcode").ToString())
                    okCnt++;
                else
                    errCnt++;

            }
            lblRes.Text = String.Format("Оброблено без помилок: {0}, з помилками {1}",
                okCnt.ToString(), errCnt.ToString());
        }
        finally
        {
            DisposeOraConnection();
        }
    }

    protected void btnVal_Click(object sender, EventArgs e)
    {
        goProc("validate_doc");
    }
    protected void btnPay_Click(object sender, EventArgs e)
    {
        goProc("pay_doc");
    }

    protected void btnDel_Click(object sender, EventArgs e)
    {
        goProc("delete_doc");
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        var redirectString = "importproced.aspx?skp=84";
        if (gv.SelectedRows.Count == 1)
        {
            var item = Convert.ToDecimal(gv.DataKeys[gv.SelectedRows[0]].Values[0]);
            Session[SESS_REF_NAME] = item;
            var sql = String.Format(@"select STATUS from v_xmlimpdocs_ui where impref = {0}", item);
            using (var connection = Bars.Classes.OraConnector.Handler.UserConnection)
            {
                var status = connection.Query<int>(sql).SingleOrDefault();
                if (status != 4) {
                    redirectString = "importproced.aspx?mode=RO&skp=84";
                }
            }
        }
        else
        {
            lblMsg.Text = ERR_ONLY_ONE_ROW_ACCEPTED;
            return;
        }

        Response.Redirect(redirectString);
    }
    protected class StatusDocCount{
        public string V_IMPORT { get; set; }
        public string V_CHECK { get; set; }
        public string V_PAYED { get; set; }
        public string V_DELETED { get; set; }
        public string V_ERRREQ { get; set; }
        public decimal SUM_IMPORT { get; set; }
        public decimal SUM_CHECK { get; set; }
        public decimal SUM_PAYED { get; set; }
        public decimal SUM_DELETED { get; set; }
        public decimal SUM_ERRREQ { get; set; }
    }
    protected StatusDocCount GetCountDocs() {
        string sql = @"select sum(decode(status, 0, 1, 0)) v_import,
                              sum(decode(status, 1, 1, 0)) v_check,
                              sum(decode(status, 2, 1, 0)) v_payed,
                              sum(decode(status, 3, 1, 0)) v_deleted,
                              sum(decode(status, 4, 1, 0)) v_errreq,
                              sum(decode(status, 0, S, 0)) sum_import,
                              sum(decode(status, 1, S, 0)) sum_check,
                              sum(decode(status, 2, S, 0)) sum_payed,
                              sum(decode(status, 3, S, 0)) sum_deleted,
                              sum(decode(status, 4, S, 0)) sum_errreq
                            from v_xmlimpdocs_ui
                        where status in (0, 1, 2, 3, 4) and userid = user_id";
        using (var connection = Bars.Classes.OraConnector.Handler.UserConnection)
        {
            return connection.Query<StatusDocCount>(sql).SingleOrDefault();
        }
    }
}
