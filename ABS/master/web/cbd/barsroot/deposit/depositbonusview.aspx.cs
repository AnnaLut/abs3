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
        dsBonuses.SelectCommand = @"select DPT_ID, DPT_NUM, to_char(DPT_DAT,'dd/mm/yyyy') DPT_DAT, BONUS_NAME, BONUS_VALUE_PLAN, BONUS_VALUE_FACT, REQ_CONFIRM, REC_STATENAME, REQ_DATE, REC_USERNAME, PRC_USERNAME, BRANCH from v_dpt_bonus_requests where branch like sys_context('bars_context','user_branch_mask') ORDER BY REQ_DATE DESC";
    }
}