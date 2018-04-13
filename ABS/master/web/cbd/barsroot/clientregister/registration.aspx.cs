using System;

namespace clientregister
{
    /// <summary>
    /// Страница содержит закладки регистрации.
    /// Создание класса клиента и заполнение первоначальными параметрами
    /// </summary>
    public partial class registration : Bars.BarsPage
    {

        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (!IsPostBack)
            {
                //клас клиента
                Client MyClient = new Client();
                //если есть тип клиента, то это регистрация
                if (Request.Params.Get("client") != null)
                {
                    MyClient.CUSTTYPE = Request.Params.Get("client");
                    MyClient.EditType = "Reg";

                    MyClient.RNlPres = "true";
                    MyClient.NEkPres = "true";
                    MyClient.RCFlPres = "true";

                    MyClient.DATE_ON = Client.GetLists.GetBankDate(Context).ToString("dd.MM.yyyy");
                    MyClient.EditType = "Reg";
                }
                // Удаляем реквизит ReadOnly 
                Session.Remove("ClientRegister.RO");
                //проверяем передан ли рнк, тогда это просмотр или перепегистрация
                if (Request.Params.Get("rnk") != null)
                {
                    bt_reg.Value = Resources.clientregister.GlobalResources.strSohranit;
                    //данные переданы для просмотра или перезаписи
                    if (Request.Params.Get("readonly") != null)
                    {
                        string rO = Request.Params.Get("readonly");
                        MyClient.ReadOnlyMode = rO;
                        // Сохраняем в сесии значение readonly - нужно на других закладках
                        Session["ClientRegister.RO"] = rO;
                        MyClient.ReadOnly = ((rO == "0" || rO == "2") ? ("false") : ("true"));
                        MyClient.EditType = ((MyClient.ReadOnly == "true") ? ("View") : ("ReReg"));
                        if (rO == "2" || rO == "3") bt_accounts.Disabled = true;
                    }
                    else
                    {
                        MyClient.EditType = "ReReg";
                    }

                    MyClient.ID = Request.Params.Get("rnk");
                    // вычитываем данные про клиента из базы
                    MyClient.ReadFromDatabase(Context, Application);
                }
                // Обезательное заполнение экон. нормативов
                MyClient.Par_EN = Client.GetLists.GetPar_EN(Context, MyClient.CUSTTYPE);
                // банковская дата
                MyClient.BANKDATE = Convert.ToString(Client.GetLists.GetBankDate(Context), Common.cinfo);
                // заполняем javascript переменные
                RegisterStartupScript("initVarsScript", "<script language=javascript>" + MyClient.PrepareSetString() + "</script>");
                // наполняем закладки
                InsertTargetUrls(MyClient.CUSTTYPE, MyClient.ID, MyClient.ReadOnly, MyClient.CODCAGENT,MyClient.SED.Trim());
                ClientScript.RegisterHiddenField("__BANKDATE", Client.GetLists.GetBankDate(Context).ToString("dd/MM/yyyy"));
                ClientScript.RegisterHiddenField("__SYSDATE", DateTime.Now.ToString("dd/MM/yyyy"));
                ClientScript.RegisterHiddenField("__CUSTPRNT", Client.GetLists.GetPar_CUSTPRNT());

                (new Bars.Configuration.ModuleSettings()).JsSettingsBlockRegister(this);
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

        }
        #endregion
        private void InsertTargetUrls(string client, string rnk, string blFlag, string codagent, string sed)
        {
            string client_rekv_link = "tab_client_rekv_";
            switch (client)
            {
                case "person": client_rekv_link += "person.asPX";
                    break;
                case "corp": client_rekv_link += "corp.asPX?rnk=" + rnk + "&readonly=" + blFlag;
                    break;
                case "bank": client_rekv_link += "bank.asPX";
                    break;
            }

            string[] tabs = {"Осн. реквизиты", "Рекв. налогопл.", "Эк.нормативы", "Реквизиты клиента",
                "Доп. информация", "Доп. реквизиты", "Дов. лица", "Связные лица"};

            tabs[0] = Resources.clientregister.GlobalResources.tab0;
            tabs[1] = Resources.clientregister.GlobalResources.tab1;
            tabs[2] = Resources.clientregister.GlobalResources.tab2;
            tabs[3] = Resources.clientregister.GlobalResources.tab3;
            tabs[4] = Resources.clientregister.GlobalResources.tab4;
            tabs[5] = Resources.clientregister.GlobalResources.tab5;
            tabs[6] = Resources.clientregister.GlobalResources.tab6;

            string nSPD ;
            string rezId;

            string userFio;
            try
            {
                InitOraConnection();
                //передаємо на сторінку фіо користувача
                userFio = Convert.ToString(SQL_SELECT_scalar("select fio from staff where id = user_id"));
                if (rnk == "")
                {
                    rezId = Request.Params.Get("rezid");
                    nSPD = Request.Params.Get("spd");
                }
                else
                {
                    SetParameters("codagent", DB_TYPE.Decimal, codagent, DIRECTION.Input);
                    rezId = Convert.ToString(SQL_SELECT_scalar("select rezid from codcagent where codcagent = :codagent "));
        
                    if (client == "person" && sed == "91") nSPD = "1";
                    else nSPD = "0";
                }
            }
            finally
            {
                DisposeOraConnection();
            }
            string sScript = @"<script language=javascript>
                                var userFio = '" + userFio.Replace("'","`") +@"';
                                var dopCustomerParam = {rezid:'" + rezId + @"',spd:'" + nSPD + @"',client:'" + client + @"'}
                                function InitTabs()
                                {
                            	    var array = new Array();
                            	    array['" + tabs[0] + @"']='tab_main_rekv.asPX?rezid=" + rezId + @"&spd="+nSPD+@"';
                            	    array['" + tabs[1] + @"']='about:blank';
                            	    array['" + tabs[2] + @"']='about:blank';
                            	    array['" + tabs[3] + @"']='" + client_rekv_link + @"';
                            	    array['" + tabs[4] + @"']='tab_dop_inf.asPX?rnk=" + rnk + @"&client=" + client + @"&spd=" +nSPD+ @"&rezid=" + rezId + @"';
                            	    array['" + tabs[5] + @"']='tab_dop_rekv.asPX?rnk=" + rnk + @"&client=" + client + @"&spd=" +nSPD+ @"&rezid=" + rezId + @"';
                            	    array['" + tabs[6] + @"']='tab_linked_custs.asPX?rnk=" + rnk + @"&client=" + client + @"&spd=" + nSPD + @"&rezid=" + rezId + @"';
                            		
                            	    fnInitTab('webtab',array,500,'onChangeTab');
                                }
                                function onChangeTab()
                                {
                            		
                                }
                            </script>";
            ClientScript.RegisterStartupScript(typeof(string), "tabs", sScript);
        }
    }
}
