using System;

namespace ViewAccounts
{
    public partial class Tab5 : Bars.BarsPage
    {
        private void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.Params.Get("accessmode") == "0")
                {
                    hintDiv.Visible = false;
                    hintDiv1.Visible = false;
                }

                try
                {
                    InitOraConnection();
                    decimal acc = Convert.ToDecimal(Request["acc"]);
                    decimal id = 0;
                    decimal pap = 0;
                    string sql = string.Empty;
                    if (acc > 0)
                    {
                        SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
                        object[] reader = SQL_SELECT_reader("select pap,lim from accounts where acc=:acc");
                        if (reader.Length > 0)
                        {
                            pap = Convert.ToDecimal(reader[0]);
                            decimal lim = Convert.ToDecimal(reader[1]);
                            if (pap == 1 && lim >= 0)
                            {
                                id = 0;
                                sql = "(select ID, id||'-'||name NAME from int_idn where mod(id,2)=0 union all " +
                                      " select id, id||'-Alt' from int_accn where acc=:acc and id not in (select id from int_idn))";
                            }
                            else if (pap == 2 && lim <= 0)
                            {
                                id = 1;
                                sql = "(select ID, id||'-'||name NAME from int_idn where mod(id,2)=1 union all " +
                                      " select id, id||'-Alt' from int_accn where acc=:acc and id not in (select id from int_idn))";
                            }
                            else
                            {
                                sql = "(select ID, id||'-'||name NAME from int_idn union all " +
                                      " select id, id||'-Alt' from int_accn where acc=:acc and id not in (select id from int_idn))";
                                if (lim > 0)
                                    id = 0;
                                else
                                    id = 1;
                            }

                        }
                    }
                    else
                    {
                        string nbs = Request["nbs"];
                        if (!string.IsNullOrEmpty(nbs))
                        {
                            SetParameters("nbs", DB_TYPE.Varchar2, nbs, DIRECTION.Input);
                            pap = Convert.ToDecimal(SQL_SELECT_scalar("select pap from ps where nbs=:nbs"));
                            if (pap == 1)
                            {
                                id = 0;
                                sql = "(select ID, id||'-'||name NAME from int_idn where mod(id,2)=0 )";
                            }
                            else if (pap == 2)
                            {
                                id = 1;
                                sql = "(select ID, id||'-'||name NAME from int_idn where mod(id,2)=1 )";
                            }
                            else
                            {
                                sql = "(select ID, id||'-'||name NAME from int_idn )";
                                id = 1;
                            }
                            ClearParameters();
                        }
                    }

                    if (!string.IsNullOrEmpty(sql))
                    {
                        ddGroups.DataValueField = "ID";
                        ddGroups.DataTextField = "NAME";
                        ddGroups.DataSource = SQL_SELECT_dataset("select id,name from " + sql + " order by abs(id)");
                        ddGroups.DataBind();
                        ddGroups.Attributes["onchange"] = "changeGroup(this)";
                        ddGroups.SelectedValue = Convert.ToString(id);
                    }
                }
                finally
                {
                    DisposeOraConnection();
                }
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
            this.Load += new System.EventHandler(this.Page_Load);

        }
        #endregion
    }
}
