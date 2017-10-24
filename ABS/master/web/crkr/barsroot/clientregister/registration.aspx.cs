using BarsWeb.Areas.Cdm.Models.Transport;
using System;
using System.Linq;
using System.Text;
using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Implementation;
using BarsWeb.Core.Logger;
using Newtonsoft.Json;

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
            var custParams = new defaultWebService().CustParameters;

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
                //проверяем передан ли рнк, тогда это просмотр или перерегистрация
                if (Request.Params.Get("gcif") == null && Request.Params.Get("rnk") != null)
                {
                    MyClient.ID = Request.Params.Get("rnk");
                    var ebkClientParams = GetClientEbkParamString(MyClient.ID, custParams);
                    
                    PageTitle.InnerHtml = "Редагування параметрів клієнта <small>(рнк: " + MyClient.ID + ebkClientParams +")</small>";
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

                    // вычитываем данные про клиента из базы
                    MyClient.ReadFromDatabase(Context, Application);

                } else if (Request.Params.Get("gcif") != null && custParams.UseCdmValidation){

                    var gcif = Request.Params.Get("gcif");
                    string bDate = Request.Params.Get("birthDate");
                    var param = new ClientSearchParams
                    {
                        Inn = Request.Params.Get("customerCode"),
                        FirstName = Request.Params.Get("firstName"),
                        LastName = Request.Params.Get("lastName"),
                        DocSerial = Request.Params.Get("documentSerial"),
                        DocNumber = Request.Params.Get("documentNumber"),
                        Gcif = gcif
                    };
                    if (!String.IsNullOrEmpty(bDate))
                    {
                        param.BirthDate = DateTime.ParseExact(bDate, "yyyy-MM-dd", null);
                    }

                    try
                    {
                        var ebkClientRnk = Request.Params.Get("rnk");
                        var repo = new EbkFindRepository(DbLoggerConstruct.NewDbLogger());
                        var client = repo.RequestEbkClient(param).FirstOrDefault(c => c.ClientCard.Rnk == Convert.ToInt32(ebkClientRnk));
                        if (client != null)
                        {
                            if (client.ClientCard != null)
                            {
                                SetEbkClientParamToClient(client.ClientCard, MyClient);
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        ErrorSumaryMessage.InnerText = "Помилка з'єдняння з ЄБК: " + (ex.InnerException == null ? ex.Message : ex.InnerException.Message);
                    }
                }
                // Обезательное заполнение экон. нормативов
                MyClient.Par_EN = Client.GetLists.GetPar_EN(Context, MyClient.CUSTTYPE);
                // банковская дата
                MyClient.BANKDATE = Convert.ToString(Client.GetLists.GetBankDate(Context), Common.cinfo);
                // заполняем javascript переменные
                RegisterStartupScript("initVarsScript", "<script language=javascript>" + MyClient.PrepareSetString() + "</script>");

                StringBuilder cstext = new StringBuilder();
                cstext.Append("<script type=text/javascript>");
                cstext.Append("var CacParams=");
                cstext.Append(JsonConvert.SerializeObject(custParams));
                cstext.Append("</script>");
                ClientScript.RegisterStartupScript(this.GetType(), "ModuleParametersScript",cstext.ToString());
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
            switch (client.ToLower())
            {
                case "person": client_rekv_link += "person.asPX";
                    break;
                case "corp": client_rekv_link += "corp.asPX?rnk=" + rnk + "&readonly=" + blFlag;
                    break;
                case "bank": client_rekv_link += "bank.asPX";
                    break;
            }

            string[] tabs = new string[8];

            tabs[0] = Resources.clientregister.GlobalResources.tab0;
            tabs[1] = Resources.clientregister.GlobalResources.tab1;
            tabs[2] = Resources.clientregister.GlobalResources.tab2;
            tabs[3] = Resources.clientregister.GlobalResources.tab3;
            tabs[4] = Resources.clientregister.GlobalResources.tab4;
            tabs[5] = Resources.clientregister.GlobalResources.tab5;
            tabs[6] = Resources.clientregister.GlobalResources.tab6;
			tabs[7] = Resources.clientregister.GlobalResources.tab7;

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
									array['" + tabs[7] + @"']='tab_custs_segments.aspx?rnk=" + rnk + @"&client=" + client + @"';
                            		
                            	    fnInitTab('webtab',array,500,'onChangeTab');
                                }
                                function onChangeTab()
                                {
                            		
                                }
                            </script>";
            ClientScript.RegisterStartupScript(typeof(string), "tabs", sScript);
        }

        private Client SetEbkClientParamToClient(BufClientData ebkClient, Client client)
        {
            //client.EditType = "";        // Reg, ReReg, View - для чего открыто приложение
            //client.ReadOnly = "false";   // Правка разрешена\запрещена
            //client.ReadOnlyMode = "0";   // Тип ограничения функционала
            //client.BANKDATE = "";        // Банковская дата
            //client.Par_EN = "";          // Обязательное заполнение эк. нормативов

            //client.CUSTTYPE = "";        // Тип клиента (person,corp,bank)

            // Осн. рквизиты
            //client.DATE_ON = "";         // Дата регистрации
            client.DATE_OFF = ebkClient.DateOff != null ? ebkClient.DateOff.Value.ToString("dd.MM.yyyy"):null;        // Дата закрытия
            //client.ID = "";              // Идентификатор
            client.ND = ebkClient.Numdoc;              // Номер договора
            client.NMK = ebkClient.Nmk;             // Наименование или ФИО
            client.NMKV = ebkClient.Nmkv;            // Наименование (межд.)
            client.NMKK = ebkClient.Nmk;             // Наименование (краткое)
            client.ADR = ebkClient.Adr;             // Адрес клиента
            client.fullADR = new CustomerAddress
            {
                type1 = new CustomerAddress.Address
                {
                    filled = true,
                    zip = ebkClient.UrZip,
                    domain = ebkClient.UrDomain,
                    region = ebkClient.UrRegion,
                    locality = ebkClient.UrLocality,
                    address = ebkClient.UrAddress,
                    territory_id = ebkClient.UrTerritoryId,

                    locality_type = ebkClient.UrLocalityType,
                    street_type = ebkClient.UrStreetType,
                    street = ebkClient.UrStreet,
                    home_type = ebkClient.UrHomeType,
                    home = ebkClient.UrHome,
                    homepart_type = ebkClient.UrHomepartType,
                    homepart = ebkClient.UrHomepart,
                    room_type = ebkClient.UrRoomType,
                    room = ebkClient.UrRoom

                }
            };        // Полний адрес клиента
            //client.fullADRMORE = "";     // Дополнительные адреса (для юр лиц)
            client.CODCAGENT = Convert.ToString(ebkClient.Codcagent);       // Характеристика клиента (К010)
            client.COUNTRY = Convert.ToString(ebkClient.Country);         // Цифровой код страны
            client.PRINSIDER = Convert.ToString(ebkClient.Prinsider);       // Признак инсайдера (К060)
            client.TGR = Convert.ToString(ebkClient.Tgr);             // Тип гос. реестра
            //client.STMT = "";            // Вид выписки
            client.OKPO = ebkClient.Okpo;            // Идентификационный код
            //client.SAB = "";             // Эликтронный код клиента
            //client.BC = "";              // Признак не является клиентом банка (1)
            client.TOBO = "";//ebkClient.Kf;            // ТОБО отделения
            //client.PINCODE = "";         // Неизвесное поле(неисп.)


            // Рекв. налогопл.
            client.RNlPres = "";         // Рекв. налогопл. заполнены\не заполнены
            client.C_REG = "";           // Областная НИ
            client.C_DST = "";           // Районная НИ
            client.ADM = "";             // Адм. орган регистрации
            client.TAXF = "";            // Налоговый код (К050)
            client.RGADM = "";           // Рег. номер в Адм.
            client.RGTAX = "";           // Рег. номер в НИ
            client.DATET = "";           // Дата рег. в НИ
            client.DATEA = "";           // Дата рег. в Адм.

            // Экономические нормативы
            client.NEkPres = "";         // Экономические нормативы заполнены\не заполнены
            client.ISE = ebkClient.Ise;             // Инст. сек. экономики (К070)
            client.FS = ebkClient.Fs;              // Форма собственности (К080)
            client.VED = ebkClient.Ved;             // Вид эк. деятельности (К110)
            //client.OE = "";              // Отрасль экономики (К090)
            client.K050 = ebkClient.K050;            // Форма хозяйствования (К050)
            //client.SED = "";             // Форма хозяйствования (К051)

            // Реквизиты клиента
            // -----(банк)-----
            //client.MFO = "";             // Код банка - МФО
            //client.ALT_BIC = "";         // Альтернативный 
            //client.BIC = "";             // ВІС
            //client.RATING = "";          // Рейтинг банка
            //client.KOD_B = "";           // Для 1ПБ
            //client.DAT_ND = "";          // Неизвесная дата
            //client.NUM_ND = "";          // Номер геню. соглашения (неисп.)  
                                         // --(банк/юр.лицо)--
            //client.RUK = "";             // Руководитель
            //client.BUH = "";             // Гл. бухгалтер банка
            //client.TELR = "";            // Телефон руководителя
            //client.TELB = "";            // Телефон гл. бухгалтера
                                         // -----(юр.лицо)-----
            //client.NMKU = "";            // Наименование по уставу
            //client.fullACCS = "";        // Счета контрагента Юр.Лица
            //client.E_MAIL = "";          // EMAIL
            //client.TEL_FAX = "";         // Факс
            //client.SEAL_ID = "";         // Ид. графического образа печати
                                         /*public string MAINMFO = "";		// Реквизиты в другом банке - МФО
                                         public string MAINNLS = "";			// Реквизиты в другом банке - ЛС
                                         public string MFONEW = "";			// Новые реквизиты - МФО
                                         public string NLSNEW = "";			// Новые реквизиты - ЛС*/
            // -----(физ.лицо)-----
            client.RCFlPres = "";        // Реквизиты клиента физ.лицо заполнены\не заполнен
            client.PASSP = Convert.ToString(ebkClient.Passp);           // Вид документа
            client.SER = ebkClient.Ser ?? "";             // Серия
            client.NUMDOC = ebkClient.Numdoc ?? "";          // Номер док.
            client.ORGAN = ebkClient.Organ ?? "";           // Кем выдан
            client.PDATE = ebkClient.Pdate != null ? ebkClient.Pdate.Value.ToString("dd.MM.yyyy") : null;            // Когда выдан
            client.BDAY = ebkClient.Bday != null ? ebkClient.Bday.Value.ToString("dd.MM.yyyy") : null;            // Дата рождения
            client.BPLACE = ebkClient.Bplace ?? "";          // Место рождения
            client.SEX = ebkClient.Sex ?? "";             // Пол
            client.TELD = ebkClient.Teld ?? "";            // Телефон 1
            client.TELW = ebkClient.Telw ?? "";            // Телефон 2

            // Доп информация
            //client.ISP = "";         // Менеджер клиента (ответ. исполнитель)
            //client.NOTES = "";       // Примечание
            //client.CRISK = "";       // Класс заемщика
            //client.MB = "";          // Принадлежность малому бизнесу
            //client.ADR_ALT = "";     // Альтнрнативный адрес
            //client.NOM_DOG = "";     // № дог. за сопровождение
            //client.LIM_KASS = "";    // Лимит кассы
            //client.LIM = "";         // Лимит на активніе операции
            //client.NOMPDV = "";      // № в реестре плательщиков ПДВ
            //client.RNKP = "";        // регистрационный № холдинга
            //client.NOTESEC = "";     // Примечание для службы безопасности
            //client.TrustEE = "";     // таблица довереных лиц
            //client.NRezidCode = "";  // код в країні реєстрації (для не резидентів)

            // Доп реквизиты
            client.DopRekv = "";            // таблица доп реквизитов

            client.DopRekv_SN_LN = ebkClient.SnLn ?? ""; //таблиця CUSTOMERW параметр SN_LN
            client.DopRekv_SN_FN = ebkClient.SnFn ?? ""; //таблиця CUSTOMERW параметр SN_FN
            client.DopRekv_SN_MN = ebkClient.SnMn ?? ""; //таблиця CUSTOMERW параметр SN_MN
            //client.DopRekv_SN_4N = ""; //таблиця CUSTOMERW параметр SN_4N

            client.DopRekv_MPNO = ebkClient.Mpno ?? ""; //тавлиця CUSTOMERW параметр MPNO

            return client;
        }

        private string GetClientEbkParamString(string rnk, CustomerParameters custParams)
        {

            if (!String.IsNullOrEmpty(rnk) && custParams.UseCdmValidation)
            {
                var result = new DeduplicateRepository(new BanksRepository(), null, null).GetGcif(Decimal.Parse(rnk));
                if (result != null && !string.IsNullOrEmpty(result.GCIF))
                {
                    return ", GCIF: " + result.GCIF;
                }
            }
            return "";
        }
    }
}
