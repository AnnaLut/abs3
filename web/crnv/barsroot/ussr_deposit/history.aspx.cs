using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class ussr_deposit_history : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["dpt_id"] == null)
            Response.Redirect("default.aspx");

        lbTitle.Text = lbTitle.Text.Replace("%s", Convert.ToString(Request["dpt_id"]));
        lbErrTitle.Text = lbErrTitle.Text.Replace("%s", Convert.ToString(Request["dpt_id"]));
        
        FillGrid();
        FillGridInc();
    }
    protected override void RaisePostBackEvent(IPostBackEventHandler sourceControl, string eventArgument)
    {
        if (sourceControl.GetType().Name == "BarsGridView" || (eventArgument != null && eventArgument.Length > 4 && eventArgument.Substring(0, eventArgument.IndexOf("$")) == "Bars"))
        { FillGrid(); FillGridInc(); }

        base.RaisePostBackEvent(sourceControl, eventArgument);
    }
    private void FillGrid()
    {
        dsHist.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsHist.PreliminaryStatement = "begin " +
            Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") +
            " begin set_full_access; end; end;";

        dsHist.SelectCommand = @"select 
               f.file_name, f.loaded,f.done,
               d.name, d.f_name, d.l_name, d.icod, d.s_pasport, d.n_pasport, d.w_pasport, 
               d.post_index, d.rg_adres, 
               d.a_adres, d.c_adres, d.s_adres, d.b_adres, d.b_adres_l, d.r_adres, 
               d.r_adres_l, d.data_b, d.region, d.otdel, d.filial, 
               d.vklad, d.val, d.n_analit, d.cfid, d.nsc, d.dato, d.nom_dog, d.attr,  
               replace(to_char(d.ost,'FM999G999G999G990D00'),',',' ') OST, d.proc, 
               replace(to_char(d.sum_proc,'FM999G999G999G990D00'),',',' ') SUM_PROC, 
               replace(to_char(d.ost_proc,'FM999G999G999G990D00'),',',' ') OST_PROC, 
               replace(to_char(d.sum,'FM999G999G999G990D00'),',',' ') SUM, 
               d.dbcode, d.data_id, 
               replace(to_char(d.total_rol,'FM999G999G999G990D00'),',',' ') TOTAL_ROL, 
               d.payoff_account NSC2, 
               replace(to_char(d.payoff_amount ,'FM999G999G999G990D00'),',',' ') SUM2, 
               d.vers, d.datm, d.timem, d.bdat, d.edat, d.datl, d.dbcodeold,
               d.cust_date,d.cust_oper
        from ussr_dbf_files f, ussr_dbf_data d
        where f.id=d.file_id and d.dpt_id=:p_dpt_id
        order by d.id ";
        dsHist.SelectParameters.Clear();
        dsHist.SelectParameters.Add("p_dpt_id", TypeCode.Decimal, Convert.ToString(Request["dpt_id"]));
    }

    private void FillGridInc()
    {
        dsHistInc.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsHistInc.PreliminaryStatement = "begin " +
            Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") +
            " begin set_full_access; end; end;";

        dsHistInc.SelectCommand = 
                @"select f.file_name, f.loaded,f.done,
               d.name, d.f_name, d.l_name, d.icod, d.s_pasport, d.n_pasport, d.w_pasport, 
               d.post_index, d.rg_adres, 
               d.a_adres, d.c_adres, d.s_adres, d.b_adres, d.b_adres_l, d.r_adres, 
               d.r_adres_l, d.data_b, d.region, d.otdel, d.filial, 
               d.vklad, d.val, d.n_analit, d.cfid, d.nsc, d.dato, d.nom_dog, d.attr,  
               replace(to_char(d.ost,'FM999G999G999G990D00'),',',' ') OST, d.proc, 
               replace(to_char(d.sum_proc,'FM999G999G999G990D00'),',',' ') SUM_PROC, 
               replace(to_char(d.ost_proc,'FM999G999G999G990D00'),',',' ') OST_PROC, 
               replace(to_char(d.sum,'FM999G999G999G990D00'),',',' ') SUM, 
               d.dbcode, d.data_id, 
               replace(to_char(d.total_rol,'FM999G999G999G990D00'),',',' ') TOTAL_ROL, 
               --d.payoff_account NSC2, 
               --replace(to_char(d.payoff_amount ,'FM999G999G999G990D00'),',',' ') SUM2, 
               d.vers, d.datm, d.timem, d.bdat, d.edat, d.datl, d.dbcodeold,
               --d.cust_date,d.cust_oper,
               d.rec_msg, d.rec_msg_ora, d.rec_error_backtrace
            from ussr_dbf_implog d, dpt_deposit dp, ussr_custcodes c, ussr_dbf_files f
            where d.branch = dp.branch and d.dbcode = c.dbcode and d.nsc = dp.nd and dp.rnk = c.rnk and dp.deposit_id = :dpt_id and d.file_id = f.id";
        dsHistInc.SelectParameters.Clear();
        dsHistInc.SelectParameters.Add("dpt_id", TypeCode.Decimal, Convert.ToString(Request["dpt_id"]));
    }

    protected void btRefresh_Click(object sender, EventArgs e)
    {
        FillGrid();
        FillGridInc();
    }
}
