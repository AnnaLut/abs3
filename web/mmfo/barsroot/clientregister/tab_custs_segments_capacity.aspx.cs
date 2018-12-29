using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Bars.UserControls;
using Bars.Classes;
using clientregister;

public partial class clientregister_tab_custs_segments_capacity : System.Web.UI.Page
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
        VCustomerSegmentsCapacityRecord datarecord;
        var data = new VCustomerSegmentsCapacity().SelectCustSegments(_rnk);// SelectCustSegments(_rnk)[0];
        if (data.Count > 0)
        {
            datarecord = data[0];// new VCustomerSegmentsCapacity().SelectCustSegments(_rnk)[0];
            DEPOSIT_AMOUNT.Text = datarecord.DEPOSIT_AMOUNT.ToString();
            CREDITS_AMOUNT.Text = datarecord.CREDITS_AMOUNT.ToString();
            CARDCREDITS_AMOUNT.Text = datarecord.CARDCREDITS_AMOUNT.ToString();
            GARANT_CREDITS_AMOUNT.Text = datarecord.GARANT_CREDITS_AMOUNT.ToString();
            ENERGYCREDITS_AMOUNT.Text = datarecord.ENERGYCREDITS_AMOUNT.ToString();
            CARDS_AMOUNT.Text = datarecord.CARDS_AMOUNT.ToString();
            ACCOUNTS_AMOUNT.Text = datarecord.ACCOUNTS_AMOUNT.ToString();
            INDIVIDUAL_SAFES_AMOUNT.Text = datarecord.INDIVIDUAL_SAFES_AMOUNT.ToString(); // new name
            CASHLOANS_AMOUNT.Text = datarecord.CASHLOANS_AMOUNT.ToString();
            BPK_CREDITLINE_AMOUNT.Text = datarecord.BPK_CREDITLINE_AMOUNT.ToString();
            INSURANCE_AVTOCIVILKA_AMOUNT.Text = datarecord.INSURANCE_AVTOCIVILKA_AMOUNT.ToString();
            INSURANCE_AVTOCIVILKAPLUS_AMOUNT.Text = datarecord.INSURANCE_AVTOCIVILKAPLUS_AMOUNT.ToString();
            INSURANCE_OBERIG_AMOUNT.Text = datarecord.INSURANCE_OBERIG_AMOUNT.ToString();
            INSURANCE_CASH_AMOUNT.Text = datarecord.INSURANCE_CASH_AMOUNT.ToString();
            CARD_CREDIT_PRIME.Text = datarecord.CARD_CREDIT_PRIME.ToString();
            MOBILE_SAVING.Text = datarecord.MOBILE_SAVING.ToString();
            OSHAD_ACTIVE.Text = datarecord.OSHAD_ACTIVE.ToString();
        }
        else
        {

            DEPOSIT_AMOUNT.Text = "";
            CREDITS_AMOUNT.Text = "";
            CARDCREDITS_AMOUNT.Text = "";
            GARANT_CREDITS_AMOUNT.Text = "";
            ENERGYCREDITS_AMOUNT.Text = "";
            CARDS_AMOUNT.Text = "";
            ACCOUNTS_AMOUNT.Text = "";
            INDIVIDUAL_SAFES_AMOUNT.Text = "";
            CASHLOANS_AMOUNT.Text = "";
            BPK_CREDITLINE_AMOUNT.Text = "";
            INSURANCE_AVTOCIVILKA_AMOUNT.Text = "";
            INSURANCE_AVTOCIVILKAPLUS_AMOUNT.Text = "";
            INSURANCE_OBERIG_AMOUNT.Text = "";
            INSURANCE_CASH_AMOUNT.Text = "";
            CARD_CREDIT_PRIME.Text = "";
            MOBILE_SAVING.Text="";
            OSHAD_ACTIVE.Text = "";
        }

   }



    #endregion


    
}