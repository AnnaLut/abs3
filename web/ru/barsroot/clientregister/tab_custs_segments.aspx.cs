using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Bars.UserControls;
using Bars.Classes;
using clientregister;

public partial class clientregister_tab_custs_segments : System.Web.UI.Page
{
    # region Приватные свойства
    private Decimal RNK
    {
        get
        {
            return Convert.ToDecimal(Request.Params.Get("rnk"));
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        String ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        decimal _rnk = Convert.ToDecimal(Request.Params.Get("rnk"));
        ClientRnk.Text = _rnk.ToString();
        VCustomerSegmentsRecord datarecord =  new VCustomerSegments().SelectCustSegments(_rnk)[0];

        CUSTOMER_SEGMENT_ACTIVITY.Text = datarecord.CUSTOMER_SEGMENT_ACTIVITY; //
        CUSTOMER_SEGMENT_FINANCIAL.Text = datarecord.CUSTOMER_SEGMENT_FINANCIAL; //
        CUSTOMER_SEGMENT_BEHAVIOR.Text = datarecord.CUSTOMER_SEGMENT_BEHAVIOR; //
        CUSTOMER_SEGMENT_TRANSACTIONS.Text = datarecord.CUSTOMER_SEGMENT_TRANSACTIONS.ToString(); //
        CUSTOMER_SEGMENT_PRODUCTS_AMNT.Text = datarecord.CUSTOMER_SEGMENT_PRODUCTS_AMNT.ToString(); //
        CUSTOMER_SEGMENT_TVBV.Text = datarecord.CUSTOMER_SEGMENT_TVBV; // номер обслуговуючого відділення
        CUSTOMER_SEGMENT_TVBV_START.Text = datarecord.CUSTOMER_SEGMENT_TVBV_START; //Обслуговуюче відділення - Дата встановлення  +++++++++++++++++++

        CS_CASHCREDIT_GIVEN.Text = datarecord.CS_CASHCREDIT_GIVEN.ToString(); // Сума наданого кеш-кредиту
        CS_CASHCREDIT_GIVEN_START.Text = datarecord.CS_CASHCREDIT_GIVEN_START; // Сума наданого кеш-кредиту - Дата встановлення
        CS_CASHCREDIT_GIVEN_STOP.Text = datarecord.CS_CASHCREDIT_GIVEN_STOP; // Сума наданого кеш-кредиту - Дата закінчення

        CUSTOMER_SEGMENT_KODM.Text = datarecord.CUSTOMER_SEGMENT_KODM; // код менеджера

        CUSTOMER_SEGMENT_MANAGER.Text = datarecord.CUSTOMER_SEGMENT_MANAGER; // ПІБ МЕНЕДЖЕРА
       // CUSTOMER_SEGMENT_MANAGER_START.Text = datarecord.CUSTOMER_SEGMENT_MANAGER_START; // ПІБ МЕНЕДЖЕРА date inp  +++++++++++++++++++++++

        CUSTOMER_SEGMENT_ATM.Text = datarecord.CUSTOMER_SEGMENT_ATM; // Кількість операцій зняття готівки в АТМ
        //CUSTOMER_SEGMENT_ATM_START.Text = datarecord.CUSTOMER_SEGMENT_ATM_START;// Кількість операцій зняття готівки в АТМ date inp  ++++++++++++++++++++++


        CS_BPK_CREDITLINE.Text = datarecord.CS_BPK_CREDITLINE.ToString(); // Сума встановленої кредитної лінії на БПК
        CS_BPK_CREDITLINE_START.Text = datarecord.CS_BPK_CREDITLINE_START; //-- Сума встановленої кредитної лінії на БПК -Дата встановлення

        CSAT_DATE_START.Text = datarecord.CUSTOMER_SEGMENT_ATM_START; //
        CSM_DATE_START.Text = datarecord.CUSTOMER_SEGMENT_MANAGER_START; //
        CSK_DATE_START.Text = datarecord.CSK_DATE_START; //  код менеджера ДАТА ВСТАВ

        CSA_DATE_START.Text = datarecord.CSA_DATE_START; //
        CSA_DATE_STOP.Text = datarecord.CSA_DATE_STOP; //
        CSF_DATE_START.Text = datarecord.CSF_DATE_START; //
        CSF_DATE_STOP.Text = datarecord.CSF_DATE_STOP; //
        CSB_DATE_START.Text = datarecord.CSB_DATE_START; //
        CSB_DATE_STOP.Text = datarecord.CSB_DATE_STOP; //
        CSP_DATE_START.Text = datarecord.CSP_DATE_START; //
                                                         // CSP_DATE_STOP.Text = datarecord.CSP_DATE_STOP;
        CST_DATE_START.Text = datarecord.CST_DATE_START; //
        CST_DATE_STOP.Text = datarecord.CST_DATE_STOP; //
        CUSTOMER_VIP.Text = datarecord.VIP_CUSTOMER_FLAG; //
    }

    #endregion

    protected void chkShowAll_CheckedChanged(object sender, EventArgs e)
    {
        gv.DataBind();
    }
}