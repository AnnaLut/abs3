using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Collections.Generic;
using credit;

using Bars.Classes;
using Oracle.DataAccess.Client;
using ibank.core;

public partial class credit_admin_bid_card : System.Web.UI.Page
{
    # region Приватные свойства
    private VWcsBidsRecord _BidRecord;

    # endregion

    # region Публичные свойства
    public VWcsBidsRecord BidRecord
    {
        get
        {
            if (_BidRecord == null)
            {
                List<VWcsBidsRecord> lst = (new VWcsBids()).SelectBid(Master.BID_ID);
                if (lst.Count > 0) _BidRecord = lst[0];
            }

            return _BidRecord;
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        Master.SetPageTitle(String.Format(this.Title, Convert.ToString(Master.BidRecord.BID_ID)), true);

        Master.FillData();
        
        if (!IsPostBack)
        {
            CheckStateAccess();
            //String mstr = Master.SRV_HIERARCHY.ToUpper();
        }
        if (Request.Form["__EVENTTARGET"] == "ctl00_ctl00_body_cphCommands_btRun")
        {
            btRun_Click(this, new EventArgs());
        }
    }

    protected void lbRestartRequest0_Click(object sender, EventArgs e)
    {
        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        cmn.wp.BID_STATE_SET(Master.BID_ID, "NEW_INFOQUERIES_0", "Перезапуск інформаційних запитів");

        Response.Redirect(String.Format("/barsroot/credit/admin/bid_card.aspx?bid_id={0}", Master.BID_ID));
    }

    protected void lbRestartRequest1_Click(object sender, EventArgs e)
    {
        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        cmn.wp.BID_STATE_SET(Master.BID_ID, "NEW_INFOQUERIES_1", "Перезапуск інформаційних запитів");

        Response.Redirect(String.Format("/barsroot/credit/admin/bid_card.aspx?bid_id={0}", Master.BID_ID));
    }
    
    protected void btRun_Click(object sender, EventArgs e)
    {
        //1. Ввод данных (NEW_CREDITDATA_DI, NEW_DATAINPUT);--INPDATA
        if (RadioButton.SelectedIndex == 0)
        {
            DelHistory(Master.BID_ID, "INPDATA");
        }
        //2. Завершение ввода данных (NEW_DATAINPUT, NEW_DATAINPUT_FINISHED);--INPDATA_FIN
        if (RadioButton.SelectedIndex == 1)
        {
            DelHistory(Master.BID_ID, "INPDATA_FIN");
        }
        //3. Кредитная служба РУ (NEW_RU_CREDIT_S, NEW_RU_CREDIT_S_PRC);--CREDSERV_RU
        if (RadioButton.SelectedIndex == 2)
        {
            DelHistory(Master.BID_ID, "CREDSERV_RU");
        }
        //4. Анализ рассмотрения служб РУ (NEW_RU_CREDIT_S, NEW_RU_CREDIT_S_SRVANALYSE);--SRVANALYSE_RU
        if (RadioButton.SelectedIndex == 3)
        {
            DelHistory(Master.BID_ID, "SRVANALYSE_RU");
        }
        //5. Анализ решения кредитного комитета РУ (NEW_RU_CREDIT_S, NEW_RU_CREDIT_S_CCANALYSE);--CCANALYSE_RU
        if (RadioButton.SelectedIndex == 4)
        {
            DelHistory(Master.BID_ID, "CCANALYSE_RU");
        }
        //6. Кредитная служба ЦА (NEW_CA_CREDIT_S, NEW_CA_CREDIT_S_PRC);--CREDSERV_CA
        if (RadioButton.SelectedIndex == 5)
        {
            DelHistory(Master.BID_ID, "CREDSERV_CA");
        }
        //7. Анализ рассмотрения служб ЦА (NEW_CA_CREDIT_S, NEW_CA_CREDIT_S_SRVANALYSE);--SRVANALYSE_CA
        if (RadioButton.SelectedIndex == 6)
        {
            DelHistory(Master.BID_ID, "SRVANALYSE_CA");
        }
        //8. Анализ решения кредитного комитета ЦА (NEW_CA_CREDIT_S, NEW_CA_CREDIT_S_CCANALYSE);--CCANALYSE_CA
        if (RadioButton.SelectedIndex == 7)
        {
            DelHistory(Master.BID_ID, "CCANALYSE_CA");
        }
        //9. Выдача Данные кредита (NEW_SIGNDOCS, NEW_CREDITDATA_SD);--CREDITDATA
        if (RadioButton.SelectedIndex == 8)
        {
            DelHistory(Master.BID_ID, "CREDITDATA");
        }
        //10. Завершение Подписание договоров (NEW_SIGNDOCS, NEW_SIGNDOCS_FINISHED);--SIGNFIN
        if (RadioButton.SelectedIndex == 9)
        {
            DelHistory(Master.BID_ID, "SIGNFIN");
        }
        //11. Виза (NEW_VISA).--VISA
        if (RadioButton.SelectedIndex == 10)
        {
            DelHistory(Master.BID_ID, "VISA");
        }
    }
    # endregion

    # region Приватные методы
    private void DelHistory(Decimal? BidId, String StateStatus)
    {
        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        cmn.wp.BID_HISTORY_RESTORE(BidId, StateStatus);

        Response.Redirect(String.Format("/barsroot/credit/admin/bid_card.aspx?bid_id={0}", Master.BID_ID));
    }
    private void CheckStateAccess()
    {
        Common cmn = new Common(new BbConnection());

        lbRestartRequest0.Enabled = (1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_INFOQUERIES_0"));
        lbRestartRequest1.Enabled = (1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_INFOQUERIES_1"));
        
        RadioButton.Items[10].Selected = (1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_VISA"));
        RadioButton.Items[10].Enabled = (1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_VISA"));

        RadioButton.Items[9].Selected = (1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_SIGNDOCS") && 1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_SIGNDOCS_FINISHED") && !RadioButton.Items[9].Enabled);
        RadioButton.Items[9].Enabled = (1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_SIGNDOCS") && 1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_SIGNDOCS_FINISHED"));
        
        RadioButton.Items[8].Selected = (1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_SIGNDOCS") && 1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_CREDITDATA_SD") && !RadioButton.Items[8].Enabled);
        RadioButton.Items[8].Enabled = (1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_SIGNDOCS") && 1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_CREDITDATA_SD"));

        RadioButton.Items[7].Selected = (1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_CA_CREDIT_S") && 1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_CA_CREDIT_S_CCANALYSE") && !RadioButton.Items[7].Enabled);
        RadioButton.Items[7].Enabled = (1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_CA_CREDIT_S") && 1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_CA_CREDIT_S_CCANALYSE"));
        
        RadioButton.Items[6].Selected = (1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_CA_CREDIT_S") && 1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_CA_CREDIT_S_SRVANALYSE") && !RadioButton.Items[6].Enabled);
        RadioButton.Items[6].Enabled = (1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_CA_CREDIT_S") && 1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_CA_CREDIT_S_SRVANALYSE"));
        
        RadioButton.Items[5].Selected = (1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_CA_CREDIT_S") && 1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_CA_CREDIT_S_PRC") && !RadioButton.Items[5].Enabled);
        RadioButton.Items[5].Enabled = (1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_CA_CREDIT_S") && 1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_CA_CREDIT_S_PRC"));
        
        RadioButton.Items[4].Selected = (1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_RU_CREDIT_S") && 1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_RU_CREDIT_S_CCANALYSE") && !RadioButton.Items[4].Enabled);
        RadioButton.Items[4].Enabled = (1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_RU_CREDIT_S") && 1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_RU_CREDIT_S_CCANALYSE"));

        RadioButton.Items[3].Selected = (1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_RU_CREDIT_S") && 1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_RU_CREDIT_S_SRVANALYSE") && !RadioButton.Items[3].Enabled);
        RadioButton.Items[3].Enabled = (1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_RU_CREDIT_S") && 1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_RU_CREDIT_S_SRVANALYSE"));

        RadioButton.Items[2].Selected = (1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_RU_CREDIT_S") && 1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_RU_CREDIT_S_PRC") && !RadioButton.Items[2].Enabled);
        RadioButton.Items[2].Enabled = (1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_RU_CREDIT_S") && 1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_RU_CREDIT_S_PRC"));
        
        /*RadioButton.Items[4].Selected = (1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_CREDIT_S") && 1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_CREDIT_S_CCANALYSE") && !RadioButton.Items[5].Enabled);
        RadioButton.Items[4].Enabled = (1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_CREDIT_S") && 1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_CREDIT_S_CCANALYSE"));
        
        RadioButton.Items[3].Selected = (1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_CREDIT_S") && 1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_CREDIT_S_SRVANALYSE") && !RadioButton.Items[4].Enabled);
        RadioButton.Items[3].Enabled = (1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_CREDIT_S") && 1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_CREDIT_S_SRVANALYSE"));

        RadioButton.Items[2].Selected = (1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_CREDIT_S") && 1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_CREDIT_S_PRC") && !RadioButton.Items[3].Enabled);
        RadioButton.Items[2].Enabled = (1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_CREDIT_S") && 1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_CREDIT_S_PRC"));
*/
        RadioButton.Items[1].Selected = (1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_DATAINPUT") && 1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_DATAINPUT_FINISHED") && !RadioButton.Items[2].Enabled && !RadioButton.Items[5].Enabled);
        RadioButton.Items[1].Enabled = (1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_DATAINPUT") && 1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_DATAINPUT_FINISHED"));
        
        RadioButton.Items[0].Selected = (1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_CREDITDATA_DI") && 1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_DATAINPUT") && !RadioButton.Items[1].Enabled);
        RadioButton.Items[0].Enabled = (1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_CREDITDATA_DI") && 1 == cmn.wu.HAD_BID_STATE(Master.BID_ID, "NEW_DATAINPUT"));
    }
}
    # endregion