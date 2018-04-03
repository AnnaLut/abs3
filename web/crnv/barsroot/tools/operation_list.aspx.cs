using System;
using System.Collections.Generic;
using Bars.Classes;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Web.UI.HtmlControls;

public partial class tools_operation_list : Bars.BarsPage
{
    private void FillData()
    {
        try
        {
            InitOraConnection();
            string branch = tbBranch.Text;

            if (!IsPostBack)
            {
                branch = Convert.ToString(SQL_SELECT_scalar("select sys_context('bars_context','user_branch') from dual"));
                if (branch.Length == 8)
                    branch += "000000/060000/";
                else if (branch.Length == 15)
                    branch += "06" + branch.Substring(branch.Length - 5);

                tbBranch.Text = branch;
                SetParameters("branch", DB_TYPE.Varchar2, branch, DIRECTION.Input);
                tbBranchName.Text = Convert.ToString(SQL_SELECT_scalar("select name from branch where branch=:branch"));

                tbFDat.Date = DateTime.Now;
            }

            ClearParameters();

            SetParameters("branch", DB_TYPE.Varchar2, tbBranch.Text, DIRECTION.Input);
            SetParameters("fdat", DB_TYPE.Date, tbFDat.Date, DIRECTION.Input);

            gvMain.DataSource = SQL_SELECT_dataset(@"SELECT  M.KOL KOL,  BS0.SEK SEK,  BS0.GRP GRP,  decode ( BS0.GRP, 0, upper(BS0.NAME), BS0.NAME) NAME,
                                         BS0.KOEF KOEF, BS0.ORD,  BS0.ID,  M.ACC, m.NLS, M.KOL*BS0.KOEF RKOL
                                 from BS0, 
                                     (select A.acc, a.ID, s.kos KOL, a.nls 
                                      from (select nls, acc, to_number(substr(nls,10,5)) ID from accounts
                                            where branch=:BRANCH and nbs is null and nls like '0000%') a, 
                                           (select acc,kos from saldoa where fdat=trunc(:FDAT) ) s 
                                      where a.acc=s.acc(+)
                                      ) M 
                                 Where BS0.nrep=2 and abs(BS0.id) = M.ID (+) order by BS0.SEK,  BS0.GRP ");
            gvMain.DataBind();
        }
        finally
        {
            DisposeOraConnection();
        }
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            FillData();
    }

    protected override void OnInit(EventArgs e)
    {

        dsMain.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        base.OnInit(e);
    }
    protected void gvMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            int section = Convert.ToInt32(e.Row.Cells[1].Text) - 1;
            int group = Convert.ToInt32(e.Row.Cells[2].Text);
            int id = Convert.ToInt32(((DataRowView)e.Row.DataItem).Row["ID"]);
            TextBox tb = (TextBox)e.Row.Cells[0].Controls[1];

            Color[] colors = {Color.FromArgb( 255,240,255 ),
                Color.FromArgb( 255,255,150),
                Color.FromArgb( 255,255,220),
                Color.FromArgb( 230,255,230),
                Color.FromArgb( 220,255,255),
                Color.FromArgb( 230,245,240),
                Color.FromArgb(191,191,255)
                };
            e.Row.Cells[0].Style.Add("border-bottom", "1px dotted black");
            e.Row.Cells[1].Style.Add("border-bottom", "1px dotted black");
            e.Row.Cells[2].Style.Add("border-bottom", "1px dotted black");
            e.Row.Cells[3].Style.Add("border-bottom", "1px dotted black");
            e.Row.Cells[4].Style.Add("border-bottom", "1px dotted black");
            e.Row.Cells[5].Style.Add("border-bottom", "1px dotted black");
            e.Row.Cells[3].BackColor = colors[section];

            if (group > 0)
            {
                decimal count = (tb.Text.Length > 0) ? (Convert.ToDecimal(tb.Text)) : (0);
                decimal koef = (e.Row.Cells[4].Text.Length > 0) ? (Convert.ToDecimal(e.Row.Cells[4].Text)) : (0);
                e.Row.Cells[5].Text = (count * koef).ToString("F");
                if (id > 0)
                {
                    tb.BackColor = Color.LightGray;
                    e.Row.Cells[0].BackColor = Color.LightGray;
                }
            }
            else
                tb.Visible = false;
        }
    }
    protected void btRefresh_Click(object sender, ImageClickEventArgs e)
    {
        FillData();
    }
    protected void btNew_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            InitOraConnection();

            SetParameters("fdat", DB_TYPE.Date, tbFDat.Date, DIRECTION.Input);
            SetParameters("branch", DB_TYPE.Varchar2, tbBranch.Text, DIRECTION.Input);
            SQL_PROCEDURE("ACC_0000");

            FillData();
        }
        finally
        {
            DisposeOraConnection();
        }
    }
    protected void btSave_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            InitOraConnection();
            foreach (GridViewRow row in gvMain.Rows)
            {
                int id = Convert.ToInt32(((HiddenField)row.Cells[0].Controls[3]).Value);
                string sCount = ((TextBox)row.Cells[0].Controls[1]).Text.Trim();
                if (!string.IsNullOrEmpty(sCount))
                {
                    decimal count = decimal.Parse(sCount);
                    ClearParameters();

                    SetParameters("branch", DB_TYPE.Varchar2, tbBranch.Text, DIRECTION.Input);
                    SetParameters("id", DB_TYPE.Decimal, id, DIRECTION.Input);
                    SetParameters("fdat", DB_TYPE.Date, tbFDat.Date, DIRECTION.Input);
                    SetParameters("kol", DB_TYPE.Decimal, count, DIRECTION.Input);
                    SQL_PROCEDURE("acc1_0000");
                }
            }
        }
        finally
        {
            DisposeOraConnection();
        }
        FillData();
    }
}
