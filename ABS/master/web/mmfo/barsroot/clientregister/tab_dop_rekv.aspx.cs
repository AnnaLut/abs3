using System;
using System.Data;
using System.Collections;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using Bars.Classes;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Implementation;
using BarsWeb.Areas.Kernel.Infrastructure.Repository.DI.Implementation;
using Oracle.DataAccess.Client;
using MenuItem = System.Web.UI.WebControls.MenuItem;

public partial class clientregister_tab_dop_rekv : Bars.BarsPage
{
    # region Приватные свойства
    # endregion

    # region Публичные свойства

    public Decimal nRnk
    {
        get
        {
            Decimal? nRnkReturn;
            if (!String.IsNullOrEmpty(Request.Params.Get("rnk")))
                nRnkReturn = Convert.ToDecimal(Request.Params.Get("rnk"));
            else nRnkReturn = Convert.ToDecimal(-1);
            return Convert.ToDecimal(nRnkReturn);
        }
    }
    public Decimal nRezId
    {
        get
        {
            return Convert.ToDecimal(Request.Params.Get("rezid"));
        }
    }
    public Decimal nSPD
    {
        get
        {
            return Convert.ToDecimal(Request.Params.Get("spd"));
        }
    }
    public Decimal custtype
    {
        get
        {
            Decimal returnCusttype;
            switch (Request.Params.Get("client").ToLower())
            {
                case "person":
                    returnCusttype = Convert.ToDecimal(3);
                    break;
                case "corp":
                    returnCusttype = Convert.ToDecimal(2);
                    break;
                case "bank":
                    returnCusttype = Convert.ToDecimal(1);
                    break;
                default:
                    returnCusttype = Convert.ToDecimal(0);
                    break;
            }
            return returnCusttype;
        }
    }
    # endregion

    # region События страницы
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
			MenuItem miKred = null; // COBUMMFO-8558
            try
            {
                InitOraConnection();

                Session["DopReqv.CustRisk"] = Convert.ToString(SQL_SELECT_scalar("select val from params where par='CUSTRISK'"));
                if (Convert.ToString(Session["DopReqv.CustRisk"]) == "1")
                {
                    if (nRnk > 0)
                        hCheckFM.Value = Convert.ToString(SQL_SELECT_scalar("select sum(value) from v_customer_risk where rnk=" + nRnk));
                    else
                        hCheckFM.Value = "-1";
                }

                string sTail = string.Empty;
                switch (Convert.ToString(custtype))
                {
                    case "1": sTail = "b=1"; break;
                    case "2":
                        sTail = "u=1";
                        if (nRezId == 2)
                        {
                            sTail = "u_nrez=1";
                        }
                        break;
                    case "3":
                        sTail = "f=1";
                        if (nRezId == 2)
                        {
                            sTail = "f_nrez=1";
                        }
                        if (nRezId == 1 && nSPD == 1)
                        {
                            sTail = "f_spd=1";
                        }
                        break;
                }
                ClearParameters();

                mRecvTabs.Items.Clear();
                SQL_Reader_Exec(@"select unique f.code, s.name, s.ord
                      from customer_field f, customer_field_codes s
                      where f.code = s.code and " + sTail + " order by s.ord");
                while (SQL_Reader_Read())
                {
                    ArrayList reader = SQL_Reader_GetValues();
                    MenuItem mi = new MenuItem();
                    mi.Text = Convert.ToString(reader[1]);
                    mi.Value = Convert.ToString(reader[0]);
                    mRecvTabs.Items.Add(mi);
					if(mi.Value == "KRED") // для умолчабельного перехода на вкладку "Для Кредитного реєстру" COBUMMFO-8558
						miKred = mi;
                }
                SQL_Reader_Close();
            }
            finally
            {
                DisposeOraConnection();
            }

            // Категории риска
            if (Convert.ToString(Session["DopReqv.CustRisk"]) == "1")
                mRecvTabs.Items.Add(new MenuItem("Критерії ризику", "CRISK"));

            //репутація клієнта
            var custmrept = GetGlobalParam("CUSTREPT", "");
            if (custmrept == "1")
            {
                mRecvTabs.Items.Add(new MenuItem("Репутація", "REPT"));
            }

            IParamsRepository parameters = new ParamsRepository(new KernelModel());
            var custCtg = parameters.GetParam("CUSTCTG");
            if (custtype == 2 && custCtg != null && custCtg.Value == "1")
            {
                mRecvTabs.Items.Add(new MenuItem("Належність до особових категорій", "INMAINCATS"));
            }

            mRecvTabs.Items[0].Selected = true;

            var custmpsp = GetGlobalParam("CUSTMDR", "");
            if (custmpsp == "1" || custmrept == "1" )
            {
                chCheckReq.Disabled = true;
                chCheckReq.Checked = true;
            }
			// для умолчабельного перехода на вкладку "Для Кредитного реєстру" COBUMMFO-8558
            bool isKred = (Request.Params.Get("kred") != null);
			if( isKred && miKred != null)
				miKred.Selected = true;
			
        }
        SetDataSet();
    }

    protected override void OnPreRender(EventArgs e)
    {
        gvCrisk.DataBind();
        gvMain.DataBind();
        base.OnPreRender(e);
    }

    private void SetDataSet()
    {
        string rnk = Convert.ToString(nRnk);
        string cs = Convert.ToString(custtype);
        dsMain.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        string queryRisk;
        string queryRept;
        string queryCats;
        string sqlTail;
        if(cs == "1") 
            sqlTail = "f.b";
        else if(cs == "2") 
            sqlTail = ((nRezId == 1) ? ("f.u"):("f.u_nrez"));
        else
        {
            if(nRezId == 1)
                if(nSPD == 1) sqlTail = "f.f_spd";
                else sqlTail = "f.f";
            else 
                sqlTail = "f.f_nrez";
        }
        var sqlTailUsed = string.Format("and nvl({0}, 0) > 0 ", sqlTail);

        string query = @"SELECT 
                            b.tag, 
                            b.name name, 
                            b.tabname, 
                            b.tabcolumn_check, 
                            b.byisp, 
                            b.opt, 
                            b.sqlval, 
                            w.value, 
                            b.isp, 
                            b.type, 
                            b.not_to_edit, b.chkr, b.mask
                        FROM ( SELECT 
                                    f.tag, 
                                    f.name, 
                                    f.tabname, 
                                    f.tabcolumn_check, 
                                    --nvl(f.opt,0) opt, 
                                    decode(nvl("+sqlTail+@",0),0,0,1,0,2,1) opt,
                                    f.sqlval, 
                                    nvl(a.isp,0) isp, 
                                    nvl(f.byisp,0) byisp, 
                                    type, 
                                    not_to_edit , f.chkr, f.mask
                                FROM ( SELECT 
                                            tag, 
                                            max(isp) isp 
                                        FROM 
                                            v_customerw 
                                        WHERE 
                                            rnk=:rnk 
                                            AND isp in (0,(select otd from otd_user where userid = bars.user_id and rownum = 1) ) 
                                        GROUP BY tag
                                    ) a, 
                                    customer_field f
                                 WHERE 
                                    a.tag(+)= f.tag 
                                    and code=:code " + sqlTailUsed + @"
                            ) b, 
                            v_customerw w 
                        WHERE 
                            b.tag = w.tag(+) 
                            AND b.isp = w.isp(+) 
                            AND w.rnk(+) = :rnk 
                        order by 
                            nvl(b.opt,0) desc, 
                            replace(b.name,'І', 'Каа')";

        if (rnk == "-1")
        {
            queryRisk = @"select 
                                id risk_id, 
                                name risk_name, 
                                0 value 
                            from 
                                fm_risk_criteria 
                            order by 
                                id";
            queryRept = @"select 
                                id rept_id, 
                                name rept_name, 
                                0 value 
                            from 
                                fm_rept_criteria 
                            order by 
                                id";
            queryCats = "select id as CATEGORY_ID, name as CATEGORY_NAME, 0 as VALUE from fm_category where inuse = 1";
        }
        else
        {
            dsCrisk.SelectParameters.Add("prnk", TypeCode.Decimal, rnk);
            queryRisk = @"select 
                                risk_id, 
                                risk_name, 
                                value 
                            from 
                                v_customer_risk 
                            where 
                                rnk = :prnk 
                            order by 
                                risk_id";

            dsRept.SelectParameters.Add("prnk", TypeCode.Decimal, rnk);
            queryRept = @"select 
                                rept_id, 
                                rept_name, 
                                value 
                            from 
                                v_customer_rept 
                            where 
                                rnk = :prnk 
                            order by 
                                rept_id";

            dsCats.SelectParameters.Add("prnk", TypeCode.Decimal, rnk);
            queryCats = "select CATEGORY_ID, CATEGORY_NAME, VALUE from v_customer_category where rnk = :prnk";
        }

        if (Convert.ToString(Session["DopReqv.CustRisk"]) == "1")
        {
            var connStr = OraConnector.Handler.IOraConnection.GetUserConnectionString();

            dsCrisk.ConnectionString = connStr;
            dsCrisk.SelectCommand = queryRisk;

            dsRept.ConnectionString = connStr;
            dsRept.SelectCommand = queryRept;

            dsCats.ConnectionString = connStr;
            dsCats.SelectCommand = queryCats;
        }

        dsMain.SelectCommand = query;
    }

    # endregion

    protected void mRecvTabs_MenuItemClick(object sender, MenuEventArgs e)
    {
        switch (e.Item.Value)
        {
            case "CRISK":
                pnMain.Visible = false;
                pnRisk.Visible = true;
                pnRept.Visible = false;
                pnCats.Visible = false;
                break;
            case "REPT":
                pnMain.Visible = false;
                pnRisk.Visible = false;
                pnRept.Visible = true;
                pnCats.Visible = false;
                break;
            case "INMAINCATS":
                pnMain.Visible = false;
                pnRisk.Visible = false;
                pnRept.Visible = false;
                pnCats.Visible = true;
                break;
            default:
                pnMain.Visible = true;
                pnRisk.Visible = false;
                pnRept.Visible = false;
                pnCats.Visible = false;
                break;
        }
    }
    protected void gvMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e != null && e.Row.RowType == DataControlRowType.DataRow)
        {
            string sqlVal = Convert.ToString(((DataRowView)e.Row.DataItem).Row["SQLVAL"]);
            string notToEdit = Convert.ToString(((DataRowView)e.Row.DataItem).Row["NOT_TO_EDIT"]);
            string tagName = Convert.ToString(((DataRowView)e.Row.DataItem).Row["TAG"]);
            string tagType = Convert.ToString(((DataRowView)e.Row.DataItem).Row["TYPE"]);
            string defVal = string.Empty;
            // для НАДРА - временное решение
            if ("SEGM" == tagName)
            {
                string segmValue = Convert.ToString(((DataRowView)e.Row.DataItem).Row["VALUE"]);
                ClientScript.RegisterClientScriptBlock(this.GetType(), "segmValue", "if(parent.ModuleSettings) {parent.ModuleSettings.Customers.Segm = '" + segmValue + "';}else{var ModuleSettings = {Customers:{Segm:'" + segmValue + "'}}} ", true);
            }
            if (notToEdit == "1")
                ((HtmlInputText)e.Row.Cells[1].Controls[1]).Disabled = true;
            if (sqlVal.Length > 0)
            {
                try
                {
                    InitOraConnection();
                    /*
                     Для получения значений приявязаных к типу или номеру клиента,
                     в селекте вожножно использование след. макросов: 
                     :CUSTTYPE - тип клиента (значения 1,2,3)
                     :RNK - РНК клиента (значения целые числа)
                     :SPD – признак ФО-СПД (значения 1 (СПД), 0 (не СПД))
                     :REZID – резидентность (значения 1 (резидент), 2 (нерезидент))
                     значение подставляется простой заменой текста
                     */
                    sqlVal = sqlVal.Replace(":CUSTTYPE", custtype.ToString()).Replace(":RNK", nRnk.ToString());
                    sqlVal = sqlVal.Replace(":SPD", nSPD.ToString()).Replace(":REZID", nRezId.ToString());
                    defVal = Convert.ToString(SQL_SELECT_scalar("select (" + sqlVal + ") val from dual"));
                }
                finally
                {
                    DisposeOraConnection();
                }
                if (string.IsNullOrEmpty(((HtmlInputText)e.Row.Cells[1].Controls[1]).Value))
                    ((HtmlInputText)e.Row.Cells[1].Controls[1]).Value = defVal;
            }
            if (mRecvTabs.SelectedValue != "FM" && Convert.ToString(Session["ClientRegister.RO"]) == "3")
            {
                ((HtmlInputText)e.Row.Cells[1].Controls[1]).Disabled = true;
                e.Row.Cells[2].Visible = false;
            }
            if (Convert.ToString(Session["ClientRegister.RO"]) == "1")
            {
                ((HtmlInputText)e.Row.Cells[1].Controls[1]).Disabled = true;
                e.Row.Cells[2].Visible = false;
            }

            // Заменяем формат даты на DD.MM.YYYY
            if (tagType == "D")
            {
                ((HtmlInputText)e.Row.Cells[1].Controls[1]).Value = ((HtmlInputText)e.Row.Cells[1].Controls[1]).Value.Replace("/", ".");
            }
        }
    }


    protected void dsMain_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        OracleParameter par = new OracleParameter("rnk", OracleDbType.Decimal, nRnk, System.Data.ParameterDirection.Input);
        e.Command.Parameters.Add(par);

        par = new OracleParameter("code", OracleDbType.Varchar2, mRecvTabs.SelectedValue, System.Data.ParameterDirection.Input);
        e.Command.Parameters.Add(par);
    }
}
