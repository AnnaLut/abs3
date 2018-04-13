using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Client;
using System.Data;
using Bars.Classes;

public partial class deposit_depositbonusconfirm : Bars.BarsPage
{
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {        
        FillGrid();
    }
    /// <summary>
    /// 
    /// </summary>
    private void FillGrid()
    {
        dsBonuses.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsBonuses.SelectCommand = @"select dpt_id, dpt_num, to_char(dpt_dat,'dd/mm/yyyy') dpt_dat, dpt_rate, cust_id, cust_name, cust_code,
                    type_id, type_name, type_code, branch_id, branch_name,
                    substr(dpt_bonus.request_processing_done(dpt_id),1,1) processing_done
            from v_dpt_in_bonus_queue
			where branch_id like sys_context('bars_context','user_branch_mask')
            order by dpt_id desc";
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvBonuses_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "DETAILS")
        {
            if (e.CommandArgument == null ||
                String.IsNullOrEmpty(Convert.ToString(e.CommandArgument)))
                return;

            dsBonusDetails.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
            dsBonusDetails.SelectCommand = @"select dpt_id, bonus_id, bonus_name, bonusval_plan, bonusval_fact, 
                                req_stateid, req_statename, req_auto,
                                req_confirm, req_recalc, 
                                to_char(req_date,'dd/mm/yyyy') req_date, req_userid, req_username
                           from v_dpt_in_bonus_queue_details
                          where dpt_id = :dpt_id
                          order by bonus_id";
            dsBonusDetails.SelectParameters.Add("dpt_id", TypeCode.Decimal, Convert.ToString(e.CommandArgument));

            gvBonusDetails.DataBind();
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvBonusDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {            
        if (e.CommandName == "ACCEPT")
        {
            if (e.CommandArgument == null ||
                String.IsNullOrEmpty(Convert.ToString(e.CommandArgument)))
                return;

            String[] obj = e.CommandArgument.ToString().Split(':');

            AcceptBonus(Convert.ToDecimal(obj[0]), Convert.ToDecimal(obj[1]), "Y");

            gvBonuses.DataBind();
            gvBonusDetails.DataBind();
        }
        else if (e.CommandName == "DECLINE")
        {
            if (e.CommandArgument == null ||
                String.IsNullOrEmpty(Convert.ToString(e.CommandArgument)))
                return;

            String[] obj = e.CommandArgument.ToString().Split(':');

            AcceptBonus(Convert.ToDecimal(obj[0]), Convert.ToDecimal(obj[1]), "N");

            gvBonuses.DataBind();
            gvBonusDetails.DataBind();
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="dpt_id"></param>
    /// <param name="bonus_id"></param>
    /// <param name="confirm"></param>
    private void AcceptBonus(Decimal dpt_id, Decimal bonus_id, String confirm)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = "begin dpt_bonus.request_confirmation(:dpt_id, :bonus_id, :confirm, null); end;";
            cmd.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
            cmd.Parameters.Add("bonus_id", OracleDbType.Decimal, bonus_id, ParameterDirection.Input);
            cmd.Parameters.Add("confirm", OracleDbType.Char, confirm, ParameterDirection.Input);

            cmd.ExecuteNonQuery();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }
}