using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Classes;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using System.Data;
using System.Web;
using System.Globalization;
using System.Threading;
using System.Collections.Generic;

public partial class customerlist_total_curr : Bars.BarsPage
{
    //protected override void OnLoad(EventArgs args)
    //{
    //    base.OnLoad(args);
    //    if (!IsPostBack)
    //        mp1.Show();
    //}


    string BankDate
    {
        get
        {
            if (Session["BankDate"] != null)
                return Session["BankDate"].ToString();
            else
                return "";
        }
        set
        {
            Session["BankDate"] = value;
        }
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            mp1.Show();
            BankDate = Request[txtDate.UniqueID];
            lblSelectedBankDate.Text = "Вибрана дата: " + BankDate;
        }
        else
        {
            if (Request[txtDate.UniqueID] != null)
            {
                if (Request[txtDate.UniqueID].Length > 0)
                {
                    //        //txtDate.Text = Request[txtDate.UniqueID];
                    //        //txtDateExtender.SelectedDate = DateTime.Parse(Request[txtDate.UniqueID]);
                    BankDate = Request[txtDate.UniqueID];
                    //        lblSelectedBankDate.Text = lblSelectedBankDate.Text + BankDate;
                    //        //string script = "$(document).ready(function () { $('[id*=btnGo]').click(); });";
                    //        //ClientScript.RegisterStartupScript(this.GetType(), "load", script, true);
                    //        //System.Threading.Thread.Sleep(3000);
                }
            }

            //        //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>ShowProgress();</script>", false);

            GenScript(BankDate);
            //    }
            //    else
            //    {
            //        BankDate=System.DateTime.Now.ToString("dd.MM.yyyy");
            //    }
            //}
        }
    }

    private void GenScript(string bankdate)
    {
        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("uk");
        cinfo.NumberFormat.NumberDecimalSeparator = ".";
        cinfo.DateTimeFormat.DateSeparator = "/";
        Thread.CurrentThread.CurrentCulture = cinfo;

        //trunc(bankdate)
        string acc_list = Convert.ToString(Session["SQL_CURRENCY"]);

        dsMainTT.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        String SelectCommand = string.Format(@"SELECT t.kv, t.lcv, 
                nvl(c.isdf,0)/power(10,t.dig) isdf, 
                nvl(c.iskf,0)/power(10,t.dig) iskf, 
                nvl(b.dos,0)/power(10,t.dig) dos, 
                nvl(b.kos,0)/power(10,t.dig) kos, 
                d.ostcd/power(10,t.dig) ostcd, 
                d.ostck/power(10,t.dig) ostck, 
                d.rat/power(10,t.dig) rat,
                nvl(c.isdq,0)/power(10,2) isdq, 
                nvl(c.iskq,0)/power(10,2) iskq, 
                nvl(b.dosq,0)/power(10,2) dosq, 
                nvl(b.kosq,0)/power(10,2) kosq, 
                d.ostcdq/power(10,2) ostcdq, 
                d.ostckq/power(10,2) ostckq, 
                d.ratq/100 ratq 
                FROM tabval t, 
                (SELECT a.kv,
                  sum(decode(sign(decode(s.fdat, to_date('{0}','dd.mm.yyyy'), s.ostf, s.ostf - s.dos + s.kos)), 1,0,decode(s.fdat, to_date('{0}','dd.mm.yyyy'), s.ostf, s.ostf - s.dos + s.kos))) isdf,
                  sum(decode(sign(decode(s.fdat, to_date('{0}','dd.mm.yyyy'), s.ostf, s.ostf - s.dos + s.kos)),-1,0,decode(s.fdat, to_date('{0}','dd.mm.yyyy'), s.ostf, s.ostf - s.dos + s.kos))) iskf,
                  sum(decode(sign(decode(s.fdat, to_date('{0}','dd.mm.yyyy'), s.ostf, s.ostf - s.dos + s.kos)), 1,0,decode(s.fdat, to_date('{0}','dd.mm.yyyy'), gl.p_icurval(a.kv, s.ostf, to_date('{0}','dd.mm.yyyy')), gl.p_icurval(a.kv, (s.ostf - s.dos + s.kos), to_date('{0}','dd.mm.yyyy'))))) isdq,
                  sum(decode(sign(decode(s.fdat, to_date('{0}','dd.mm.yyyy'), s.ostf, s.ostf - s.dos + s.kos)),-1,0,decode(s.fdat, to_date('{0}','dd.mm.yyyy'), gl.p_icurval(a.kv, s.ostf, to_date('{0}','dd.mm.yyyy')), gl.p_icurval(a.kv, (s.ostf - s.dos + s.kos), to_date('{0}','dd.mm.yyyy'))))) iskq
                FROM saldoa s, (", bankdate);
        SelectCommand = SelectCommand + acc_list;

        SelectCommand = SelectCommand +
            string.Format(@") a
          WHERE s.acc = a.acc AND 
               (a.acc,s.fdat) = (SELECT acc, max(fdat) 
                   FROM saldoa 
                   WHERE acc=a.acc AND fdat<=to_date('{0}','dd.mm.yyyy') 
                   GROUP BY acc ) 
          GROUP BY a.kv) c, 
          (SELECT a.kv,
                sum(decode(sign(s.ostf - s.dos + s.kos), 1,0,s.ostf - s.dos + s.kos)) ostcd,
                sum(decode(sign(s.ostf - s.dos + s.kos),-1,0,s.ostf - s.dos + s.kos)) ostck,
                sum((s.ostf - s.dos + s.kos)*acrn.fprocn(a.acc,null,s.fdat)) rat,
                sum(decode(sign(s.ostf - s.dos + s.kos), 1,0, gl.p_icurval(a.kv, s.ostf - s.dos + s.kos, to_date('{0}','dd.mm.yyyy')))) ostcdq,
                sum(decode(sign(s.ostf - s.dos + s.kos),-1,0, gl.p_icurval(a.kv, s.ostf - s.dos + s.kos, to_date('{0}','dd.mm.yyyy')))) ostckq,
                sum((gl.p_icurval(a.kv, s.ostf - s.dos + s.kos,s.fdat))*acrn.fprocn(a.acc,null,s.fdat)) ratq
          FROM saldoa s, (", bankdate);

        SelectCommand = SelectCommand + acc_list;

        SelectCommand = SelectCommand +
            string.Format(@") a
          WHERE s.acc = a.acc AND 
               (a.acc,s.fdat) = (SELECT acc, max(fdat) 
                   FROM saldoa 
                   WHERE acc = a.acc AND fdat <= to_date('{0}','dd.mm.yyyy') 
                   GROUP BY acc ) 
          GROUP BY a.kv) d, 
          (SELECT a.kv, 
                sum(decode(s.fdat, B.fdat, s.dos, 0)) dos, 
                sum(decode(s.fdat, B.fdat, s.kos, 0)) kos,
                sum(decode(s.fdat, B.fdat, gl.p_icurval(a.kv, s.dos,s.fdat), 0)) dosq, 
                sum(decode(s.fdat, B.fdat, gl.p_icurval(a.kv, s.kos,s.fdat), 0)) kosq
  FROM saldoa s, fdat B , (", bankdate);

        SelectCommand = SelectCommand + acc_list;

        SelectCommand = SelectCommand +
            string.Format(@") a
          WHERE a.acc=s.acc AND 
               (a.acc,s.fdat) = (SELECT c.acc, max(c.fdat) 
                   FROM saldoa c 
                   WHERE a.acc=c.acc AND c.fdat<= B.fdat 
                   GROUP BY c.acc) AND 
                b.fdat >= to_date('{0}','dd.mm.yyyy') AND b.fdat <= to_date('{0}','dd.mm.yyyy') 
          GROUP BY a.kv) b
 WHERE t.kv=c.kv(+) AND t.kv=d.kv AND t.kv=b.kv(+) 
 ORDER BY 2, 1", bankdate);


        /*with t as
(
 .... твой запрос
 )
 select kv, lcv,   isdf,       iskf,      dos,     kos,       ostcd, ostck from t 
 union all
 select null, 'Екв:', sum(isdq),  sum(iskq), sum(dosq), sum(kosq), sum(ostcdq), sum(ostckq) from t*/



        string select_command_all = "with t as ( " + SelectCommand +
            @" ) select kv, lcv,   isdf,       iskf,      dos,     kos,       ostcd, ostck, rat from t 
 union all
 select null, 'Екв:', sum(isdq),  sum(iskq), sum(dosq), sum(kosq), sum(ostcdq), sum(ostckq), 0 from t ";

        dsMainTT.SelectCommand = select_command_all;
        dsMainTT.DataBind();


        ///Створюємо темпову колекцію з фільтрами гріда перед примусовим байндом гріда, якщо вона не пуста. 
        ///Очищаєм і присвоюєм назад до властивостей гріда
        if (gvMainTT.FilterState.Count > 0)
        {
            var temp = new System.Collections.Generic.List<Bars.DataComponents.Filter>();
            temp.AddRange(gvMainTT.FilterState);
            gvMainTT.FilterState.Clear();
            gvMainTT.ApplyFilters();

            gvMainTT.DataBind();

            gvMainTT.FilterState = temp;
            gvMainTT.ApplyFilters();
        }
        else
            gvMainTT.DataBind();

    }


    private void AddTotal()
    {
        GridViewRow row = new GridViewRow(-1, -1, DataControlRowType.DataRow, DataControlRowState.Normal);
        row.BackColor = System.Drawing.Color.White;
        //row.Font.Bold = true;
        TableCell cell = new TableCell();
        cell.Text = "Екв.";
        row.Cells.Add(cell);

        for (int i = 0; i < eqTotals.Count; i++)
        {
            var value = eqTotals[i];
            cell = new TableCell();
            if (value < 0)
            {
                cell.ForeColor = System.Drawing.Color.Red;
                cell.Text = (value * (-1)).ToString("F2", new CultureInfo("en-US"));
            }
            else
                cell.Text = (value).ToString("F2", new CultureInfo("en-US"));

            cell.Style.Add("text-align", "right");
            row.Cells.Add(cell);
        }
        if (gvMainTT.FooterRow != null)
        {
            Table tbl = (gvMainTT.FooterRow.Parent as Table);
            GridViewRow frow = new GridViewRow(-1, -1, DataControlRowType.DataRow, DataControlRowState.Normal);
            for (int j = 0; j < 8; j++)
            {
                var cc = new TableCell();
                cc.BorderWidth = Unit.Pixel(4);
                cc.BorderColor = System.Drawing.Color.Gray;
                frow.Cells.Add(cc);
            }
            tbl.Rows.AddAt(gvMainTT.Rows.Count + 1, row);
            tbl.Rows.AddAt(gvMainTT.Rows.Count + 1, frow);
        }
    }

    List<decimal> eqTotals = new List<decimal>() { 0, 0, 0, 0, 0, 0, 0 };

    protected void gvMainTT_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        { 
           // String.Format("{0:C2}", Convert.ToDecimal(DataBinder.Eval
           //                                     (Container.DataItem, "CH_OSTF"))).Replace(",", " ").Replace("£", "")


        //    var fields = new List<string>() { "ISDF", "ISKF", "DOS", "KOS", "OSTCD", "OSTCK", "RAT", "ISDQ", "ISKQ", "DOSQ", "KOSQ", "OSTCDQ", "OSTCKQ", "RATQ" };
        //    for (int i = 0; i < fields.Count; i++)
        //    {
        //        if (i <= 6)
        //        {
        //            decimal value = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, fields[i]));
        //            if (value < 0)
        //            {
        //                e.Row.Cells[i + 1].ForeColor = System.Drawing.Color.Red;
        //                e.Row.Cells[i + 1].Text = (value * (-1)).ToString("F2", new CultureInfo("en-US"));
        //            }
        //        }
        //        //else
        //        //
        //            ///Допускаємо зміни тільки нульових значень (проблема подвоєння суми). 
        //            ///Не можна так, але немає часу
        //            //if (eqTotals[i - 7] == 0)
        //            //{
        //            eqTotals[i - 7] += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, fields[i]));
        //            //}
        //        //}
        //    }
        }

    }

    protected void gvMainTT_DataBound(object sender, EventArgs e)
    {
        //AddTotal();
    }


    protected void gvMainTT_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvMainTT.PageIndex = e.NewPageIndex;
        GenScript(BankDate);
    }

    protected void btnGo_Click(object sender, EventArgs e)
    {
        //string bankDate = BankDate;

        if (Request[txtDate.UniqueID] != null)
        {
            if (Request[txtDate.UniqueID].Length > 0)
            {
                //txtDate.Text = Request[txtDate.UniqueID];
                //txtDateExtender.SelectedDate = DateTime.Parse(Request[txtDate.UniqueID]);
                BankDate = Request[txtDate.UniqueID];
                lblSelectedBankDate.Text = "Вибрана дата: " + BankDate;
                //string script = "$(document).ready(function () { $('[id*=btnGo]').click(); });";
                //ClientScript.RegisterStartupScript(this.GetType(), "load", script, true);
                //System.Threading.Thread.Sleep(3000);



                //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>ShowProgress();</script>", false);

                //GenScript(BankDate);
            }
            else
            {
                BankDate = System.DateTime.Now.ToString("dd.MM.yyyy");
            }
        }
        mp1.Hide();
    }

}