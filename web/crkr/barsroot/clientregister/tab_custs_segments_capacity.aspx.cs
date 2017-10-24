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
            DEPOSIT_AMMOUNT.Text = datarecord.DEPOSIT_AMMOUNT.ToString();
            CREDITS_AMMOUNT.Text = datarecord.CREDITS_AMMOUNT.ToString();
            CARDCREDITS_AMMOUNT.Text = datarecord.CARDCREDITS_AMMOUNT.ToString();
            GARANT_CREDITS_AMMOUNT.Text = datarecord.GARANT_CREDITS_AMMOUNT.ToString();
            ENERGYCREDITS_AMMOUNT.Text = datarecord.ENERGYCREDITS_AMMOUNT.ToString();
            CARDS_AMMOUNT.Text = datarecord.CARDS_AMMOUNT.ToString();
            ACCOUNTS_AMMOUNT.Text = datarecord.ACCOUNTS_AMMOUNT.ToString();
            TRANSFERS_AMMOUNT.Text = datarecord.TRANSFERS_AMMOUNT.ToString();
        }
        else
        {

            DEPOSIT_AMMOUNT.Text = "";
            CREDITS_AMMOUNT.Text = "";
            CARDCREDITS_AMMOUNT.Text = "";
            GARANT_CREDITS_AMMOUNT.Text = "";
            ENERGYCREDITS_AMMOUNT.Text = "";
            CARDS_AMMOUNT.Text = "";
            ACCOUNTS_AMMOUNT.Text = "";
            TRANSFERS_AMMOUNT.Text = "";
        }
        

    }



    #endregion


    
}