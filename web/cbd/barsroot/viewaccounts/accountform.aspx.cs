using System;
using System.Reflection;
using Bars.Configuration;
using System.Collections.Generic;

namespace ViewAccounts
{
    public partial class AccountsForm : Bars.BarsPage
    {
        private void Page_Load(object sender, EventArgs e)
        {
            if (Request.Params.Get("rnk") == null)
                throw new Exception("Не определен Контрагент - владелец счета!");
            if (Request.Params.Get("acc") == null)
                throw new Exception("Не задан номер счета(acc)!");
            if (Request.Params.Get("type") == null)
                throw new Exception("Не задан параметр type!");
            int type = Convert.ToInt32(Request.Params.Get("type"));
            decimal acc = Convert.ToDecimal(Request.Params.Get("acc"));
            decimal rnk = Convert.ToDecimal(Request.Params.Get("rnk"));

            try
            {
                InitOraConnection();
                parNBSNULL.Value = GetGlobalParam("NBS_NULL", "BASIC_INFO");
                SetRole("wr_viewacc");
                SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
                if (type == 1)
                {
                    //if(SQL_SELECT_scalar("select acc from web_sal where acc=:acc") == null)	
                    //	throw new Exception("Нет права на просмотр даного счета!");
                }
                else if (type == 2)
                {
                    //if(SQL_SELECT_scalar("select acc from v_tobo_accounts where acc=:acc") == null)	
                    //	throw new Exception("Нет права на просмотр даного счета!");
                }
                else if (type == 3)
                {
                    if (SQL_SELECT_scalar("select acc from v_nd_accounts where acc=:acc") == null)
                        throw new Exception("Нет права на просмотр даного счета!");
                }
 

                if (acc == 0 && type != 4)
                {
                    throw new Exception("Неверный параметр при открытии счета!");
                }
                if (acc == 0)
                {
                    ClearParameters();
                    SetParameters("rnk", DB_TYPE.Decimal, Request.Params.Get("rnk"), DIRECTION.Input);
                    if (SQL_SELECT_scalar("select rnk from v_tobo_cust where rnk=:rnk") == null)
                        throw new Exception("Нет права открывать счет для даного контрагента!");
                }
            }
            finally
            {
                DisposeOraConnection();
            }

            (new Bars.Configuration.ModuleSettings()).JsSettingsBlockRegister(this);
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
