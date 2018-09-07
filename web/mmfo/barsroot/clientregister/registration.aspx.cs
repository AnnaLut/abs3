using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Areas.Cdm.Models.Transport;
using BarsWeb.Areas.Cdm.Models.Transport.Individual;
using BarsWeb.Areas.Cdm.Models.Transport.Legal;
using BarsWeb.Areas.Cdm.Models.Transport.PrivateEn;
using BarsWeb.Areas.Cdm.Utils;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Implementation;
using BarsWeb.Core.Infrastructure;
using Newtonsoft.Json;
using Ninject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Http;

namespace clientregister
{
    /// <summary>
    /// Страница содержит закладки регистрации.
    /// Создание класса клиента и заполнение первоначальными параметрами
    /// </summary>
    public partial class registration : Bars.BarsPage
    {

        readonly ClientAdditionalUtil _clientAdditionalUtil =  new ClientAdditionalUtil();

        public IEbkFindRepository repo
        {
            get
            {
                var ninjectKernel = (INinjectDependencyResolver)GlobalConfiguration.Configuration.DependencyResolver;
                var kernel = ninjectKernel.GetKernel();
                return kernel.Get<IEbkFindRepository>();
            }
        }

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
                }
                // Удаляем реквизит ReadOnly 
                Session.Remove("ClientRegister.RO");
                //проверяем передан ли рнк, тогда это просмотр или перерегистрация
                if (Request.Params.Get("gcif") == null && Request.Params.Get("rnk") != null)
                {
                    MyClient.ID = Request.Params.Get("rnk");
                    var ebkClientParams = GetClientEbkParamString(MyClient.ID, custParams, MyClient.Kf);

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

                }
                else if (Request.Params.Get("addSeparatedSubdivision") != null && custParams.UseCdmValidation)
                {
                    MyClient.OKPO = Request.Params.Get("customerCode");
                    MyClient.NMK = Request.Params.Get("fullName");
                    MyClient.NMKV = Request.Params.Get("fullNameInternational");
                }
                else if (Request.Params.Get("gcif") != null && custParams.UseCdmValidation){

                    var gcif = Request.Params.Get("gcif");
                    string bDate = Request.Params.Get("birthDate");
                    string dateOn = Request.Params.Get("dateOn");
                    var param = new ClientSearchParams
                    {
                        Inn = Request.Params.Get("customerCode"),
                        CustomerType = Request.Params.Get("customerType"),
                        FirstName = Request.Params.Get("firstName"),
                        LastName = Request.Params.Get("lastName"),
                        DocSerial = Request.Params.Get("documentSerial"),
                        DocNumber = Request.Params.Get("documentNumber"),
                        EddrId = Request.Params.Get("eddrId"),
                        FullName = Request.Params.Get("fullName"),
                        FullNameInternational = Request.Params.Get("fullNameInternational"),
                        Gcif = gcif
                    };
                    if (!string.IsNullOrEmpty(Request.Params.Get("customerRnk")))
                        param.Rnk = Convert.ToDecimal(Request.Params.Get("customerRnk"));
                    if (!String.IsNullOrEmpty(bDate))
                        param.BirthDate = DateTime.ParseExact(bDate, "yyyy-MM-dd", null);
                    if (!String.IsNullOrEmpty(dateOn))
                        param.DateOn = DateTime.ParseExact(dateOn, "yyyy-MM-dd", null);

                    try
                    {
                        var ebkClientRnk = Request.Params.Get("rnk");
                        ErrorMessage errorMsg=new ErrorMessage();
                        QualityClientsContainer[] qualityClientsContainers = repo.RequestEbkClient(param, errorMsg);
                        if (!string.IsNullOrEmpty(errorMsg.Message))
                        {
                            throw new Exception(message:errorMsg.Message);
                        }
                        {
                            var client = qualityClientsContainers.FirstOrDefault(c =>
                                (c.ClientCard != null && c.ClientCard.Rnk == Convert.ToDecimal(ebkClientRnk) ||
                                 c.ClientPrivateEnCard != null &&
                                 c.ClientPrivateEnCard.Rnk == Convert.ToDecimal(ebkClientRnk) ||
                                 c.ClientLegalCard != null &&
                                 c.ClientLegalCard.Rnk == Convert.ToDecimal(ebkClientRnk)));
                            if (client != null)
                            {
                                if (client.ClientCard != null)
                                {
                                    SetEbkClientParamToClient(client.ClientCard, MyClient);
                                }
                                else if (client.ClientPrivateEnCard != null)
                                {
                                    SetEbkClientPeParamToClient(client.ClientPrivateEnCard, MyClient);
                                }
                                else if (client.ClientLegalCard != null)
                                {
                                    SetEbkClientLpParamToClient(client.ClientLegalCard, MyClient);
                                }
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

            string[] tabs = new string[9];

            tabs[0] = Resources.clientregister.GlobalResources.tab0;
            tabs[1] = Resources.clientregister.GlobalResources.tab1;
            tabs[2] = Resources.clientregister.GlobalResources.tab2;
            tabs[3] = Resources.clientregister.GlobalResources.tab3;
            tabs[4] = Resources.clientregister.GlobalResources.tab4;
            tabs[5] = Resources.clientregister.GlobalResources.tab5;
            tabs[6] = Resources.clientregister.GlobalResources.tab6;
			tabs[7] = Resources.clientregister.GlobalResources.tab7;
            tabs[8] = Resources.clientregister.GlobalResources.tab8;

            string nSPD ;
            string rezId;

            string userFio;
            string clMode;
            bool addCorp2Tube;
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
                addCorp2Tube = GetUsageCorp2Param();
                clMode = string.IsNullOrEmpty(Request.Params.Get("clmode")) ? "base": Request.Params.Get("clmode");
            }
            finally
            {
                DisposeOraConnection();
            }
            bool isKred = (Request.Params.Get("kred") != null); // для умолчабельного перехода на вкладку "Для Кредитного реєстру" в доп.реквизитах COBUMMFO-8558
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
                            	    array['" + tabs[5] + @"']='tab_dop_rekv.asPX?rnk=" + rnk + @"&client=" + client + (isKred ? "&kred=1" : "") + @"&spd=" +nSPD+ @"&rezid=" + rezId + @"';
                            	    array['" + tabs[6] + @"']='tab_linked_custs.asPX?rnk=" + rnk + @"&client=" + client + @"&spd=" + nSPD + @"&rezid=" + rezId + @"';
									" + ((!string.IsNullOrEmpty(rnk)) ? ("array['" + tabs[7] + @"']='tab_custs_segments.aspx?rnk=" + rnk + @"&client=" + client + "';") :(""))  + @";
                                    " + (GetUsageCorpLightParam() && (!string.IsNullOrEmpty(rnk)) ? "array['" + tabs[8] + @"']='/barsroot/cdo/common/relatedCustomers/index?custId=" + rnk + 
                                            @"&clmode=" + clMode + @"&addCorp2Tube=" + addCorp2Tube + @"'" : "") + @";
                            	    fnInitTab('webtab',array,1200,'onChangeTab');
									
									" + (isKred ? " goPage({id:'bTab5'}); ":"") + @"
                                }
                                function onChangeTab()
                                {
                            		
                                }
                            </script>";
            ClientScript.RegisterStartupScript(typeof(string), "tabs", sScript);
        }

        private bool GetUsageCorpLightParam()
        {
            var sql = "select val from params$global where par = :p_par";
            InitOraConnection();
            ClearParameters();
            SetParameters("p_par", DB_TYPE.Varchar2, "USAGE_CORPLIGHT", DIRECTION.Input);
            return Convert.ToString(SQL_SELECT_scalar(sql)) == "1";
        }

        private bool GetUsageCorp2Param()
        {
            InitOraConnection();
            ClearParameters();
            string sqlGetBranch = "select SYS_CONTEXT('bars_context', 'user_branch') current_branch from dual";
            string currentBrancch = Convert.ToString(SQL_SELECT_scalar(sqlGetBranch));
            if (currentBrancch == @"\")
                throw new Exception("оберіть відділення");
            string branchWithoutFirstSlash = currentBrancch.Substring(currentBrancch.IndexOf('/') + 1);
            string hierBranch = "/" + branchWithoutFirstSlash.Substring(0, branchWithoutFirstSlash.IndexOf('/') +1);
            string sql = "select branch_attribute_utl.get_attribute_value(p_branch_code    => :p_branch,p_attribute_code => :p_attribute) from dual";


            SetParameters("p_branch", DB_TYPE.Varchar2, hierBranch, DIRECTION.Input);
            SetParameters("p_attribute", DB_TYPE.Varchar2, "CORP2_PILOT", DIRECTION.Input);
            string resІtring = string.Empty;
            try
            {
                 resІtring = SQL_SELECT_scalar(sql) as string;
            }
            catch (Exception ex)
            {
                if(!ex.Message.Contains("20000"))
                throw ex;
            }
           
            int res;
            if (!string.IsNullOrEmpty(resІtring) && Int32.TryParse(resІtring, out res))
                return res == 1;
            else
                return false;
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
            // client.DATE_OFF = ebkClient.DateOff != null ? ebkClient.DateOff.Value.ToString("dd.MM.yyyy"):null;        // Дата закрытия
            //client.ID = "";              // Идентификатор
            client.ND = ebkClient.Document == null ? "" : ebkClient.Document.Numdoc ?? "";              // Номер договора
            client.NMK = ebkClient.Nmk ?? "";             // Наименование или ФИО
            client.NMKV = ebkClient.Nmkv ?? "";            // Наименование (межд.)
            client.NMKK = ebkClient.Nmk ?? "";             // Наименование (краткое)


            client.ADR = ebkClient.Address != null ? (ebkClient.Address.Adr ?? "") : "";

            if (ebkClient.Address == null)
            {
                client.fullADR = new CustomerAddress
                {
                    type1 = new CustomerAddress.Address()
                }; 
            }
            else
            {
                client.fullADR = new CustomerAddress
                {
                    type1 = new CustomerAddress.Address
                    {
                        filled = true,
                        zip = ebkClient.Address.UrZip ?? "",
                        domain = ebkClient.Address.UrDomain ?? "",
                        region = ebkClient.Address.UrRegion ?? "",
                        locality = ebkClient.Address.UrLocality ?? "",
                        address = ebkClient.Address.UrAddress ?? "",
                        territory_id = ebkClient.Address.UrTerritoryId,

                        locality_type = ebkClient.Address.UrLocalityType,
                        street_type = ebkClient.Address.UrStreetType,
                        street = ebkClient.Address.UrStreet ?? "",
                        home_type = ebkClient.Address.UrHomeType,
                        home = ebkClient.Address.UrHome ?? "",
                        homepart_type = ebkClient.Address.UrHomepartType,
                        homepart = ebkClient.Address.UrHomepart ?? "",
                        room_type = ebkClient.Address.UrRoomType,
                        room = ebkClient.Address.UrRoom ?? ""

                    }
                };
            }
            
            //client.fullADRMORE = "";     // Дополнительные адреса (для юр лиц)
            client.CODCAGENT = Convert.ToString(ebkClient.Codcagent);       // Характеристика клиента (К010)
            client.COUNTRY = Convert.ToString(ebkClient.Country);         // Цифровой код страны
            client.PRINSIDER = Convert.ToString(ebkClient.Prinsider);       // Признак инсайдера (К060)
            client.TGR = Convert.ToString(ebkClient.Tgr);             // Тип гос. реестра
            //client.STMT = "";            // Вид выписки
            client.OKPO = ebkClient.Okpo ?? "";            // Идентификационный код
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
            client.ISE = ebkClient.Ise ?? "";             // Инст. сек. экономики (К070)
            client.FS = ebkClient.Fs ?? "";              // Форма собственности (К080)
            client.VED = ebkClient.Ved ?? "";             // Вид эк. деятельности (К110)
            //client.OE = "";              // Отрасль экономики (К090)
            client.K050 = ebkClient.K050 ?? "";            // Форма хозяйствования (К050)
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
            client.PASSP = ebkClient.Document != null ? Convert.ToString(ebkClient.Document.Passp) : "";           // Вид документа
            client.SER = ebkClient.Document !=null ? (ebkClient.Document.Ser ?? "") : "";             // Серия
            client.NUMDOC = ebkClient.Document != null ? (ebkClient.Document.Numdoc ?? "") : "";         // Номер док.
            client.ORGAN = ebkClient.Document != null ? (ebkClient.Document.Organ ?? "") : "";           // Кем выдан
            client.PDATE = ebkClient.Document != null && ebkClient.Document.Pdate != null ? ebkClient.Document.Pdate.Value.ToString("dd.MM.yyyy") : null;            // Когда выдан
            client.BDAY = ebkClient.Bday != null ? ebkClient.Bday.Value.ToString("dd.MM.yyyy") : null;            // Дата рождения
            client.BPLACE = ebkClient.Bplace ?? "";          // Место рождения
            client.SEX = ebkClient.Sex ?? "";             // Пол
            client.TELD = ebkClient.Contact != null && ebkClient.Contact.Teld != null ? ebkClient.Contact.Teld : "";            // Телефон 1
            client.TELW = ebkClient.Contact != null && ebkClient.Contact.Telw != null ? ebkClient.Contact.Telw : "";           // Телефон 2.

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

            client.DopRekv_MPNO = ebkClient.Contact != null && ebkClient.Contact.Mpno != null ? ebkClient.Contact.Mpno : ""; //тавлиця CUSTOMERW параметр MPNO
            client.ACTUAL_DATE = ebkClient.Document != null && ebkClient.Document.ActualDate != null ? ebkClient.Document.ActualDate.Value.ToString("dd.MM.yyyy") : null;
            client.EDDR_ID = ebkClient.Document != null ?  (ebkClient.Document.EddrId ?? "") : "";
            client.DATE_PHOTO = ebkClient.Document != null  && ebkClient.Document.DatePhoto != null ? ebkClient.Document.DatePhoto.Value.ToString("dd.MM.yyyy") : null;

            List<AdditionalСlientInformation> additionalClientInfo = _clientAdditionalUtil.GetAdditionalClientInformationListPerson();

            _clientAdditionalUtil.AddDopRekv(client, additionalClientInfo, ebkClient);

            return client;
        }

        // Private En
        private Client SetEbkClientPeParamToClient(PrivateEnPerson ebkClient, Client client)
        {
            //client.DATE_OFF = ebkClient.DateOff != null ? ebkClient.DateOff.Value.ToString("dd.MM.yyyy") : null;        // Дата закрытия
            //client.ND = ebkClient.AdditionalInformation. Document.Numdoc;              // Номер договора
            client.NMK = ebkClient.fullName ?? "";             // Наименование или ФИО
            client.NMKV = ebkClient.fullNameInternational ?? "";            // Наименование (межд.)
            client.NMKK = ebkClient.fullNameAbbreviated ?? "";             // Наименование (краткое)
            //client.ADR = ebkClient.ActualAddress.Adr;             // Адрес клиента
            client.fullADR = new CustomerAddress
            {
                type1 = new CustomerAddress.Address
                {
                    filled = true,
                    domain = ebkClient.LegalAddress == null ? "" : ebkClient.LegalAddress.La_Area ?? "",
                    zip = ebkClient.LegalAddress == null ? "" : ebkClient.LegalAddress.La_Index ?? "",
                    region = ebkClient.LegalAddress == null ? "" : ebkClient.LegalAddress.La_Region ?? "",
                    locality = ebkClient.LegalAddress == null ? "" : ebkClient.LegalAddress.La_Settlement ?? "",
                    address = ebkClient.LegalAddress == null ? "" : ebkClient.LegalAddress.La_Street ?? "",
                    territory_id = ebkClient.LegalAddress == null ? null : ebkClient.LegalAddress.La_TerritoryCode,
                    street = ebkClient.LegalAddress == null ? "" : ebkClient.LegalAddress.La_Street ?? "",
                    home = ebkClient.LegalAddress == null ? "" : ebkClient.LegalAddress.La_HouseNumber ?? "",
                    homepart = ebkClient.LegalAddress == null ? "" : ebkClient.LegalAddress.La_SectionNumber ?? "",
                    room = ebkClient.LegalAddress == null ? "" : ebkClient.LegalAddress.La_apartmentsNumber ?? "",
                    Comment = ebkClient.LegalAddress == null ? "" : ebkClient.LegalAddress.La_Notes ?? ""

                },
                type2 = new CustomerAddress.Address
                {
                    filled = true,
                    domain = ebkClient.ActualAddress == null ? "" : ebkClient.ActualAddress.Aa_Area ?? "",
                    zip = ebkClient.ActualAddress == null ? "" : ebkClient.ActualAddress.Aa_Index ?? "",
                    region = ebkClient.ActualAddress == null ? "" : ebkClient.ActualAddress.Aa_Region ?? "",
                    locality = ebkClient.ActualAddress == null ? "" : ebkClient.ActualAddress.Aa_Settlement ?? "",
                    address = ebkClient.ActualAddress == null ? "" : ebkClient.ActualAddress.Aa_Street ?? "",
                    territory_id = ebkClient.ActualAddress == null ? null : ebkClient.ActualAddress.Aa_territoryCode,
                    street = ebkClient.ActualAddress == null ? "" : ebkClient.ActualAddress.Aa_Street ?? "",
                    home = ebkClient.ActualAddress == null ? "" : ebkClient.ActualAddress.Aa_HouseNumber ?? "",
                    homepart = ebkClient.ActualAddress == null ? "" : ebkClient.ActualAddress.Aa_SectionNumber ?? "",
                    room = ebkClient.ActualAddress == null ? "" : ebkClient.ActualAddress.Aa_ApartmentsNumber ?? "",
                    Comment = ebkClient.ActualAddress == null ? "" : ebkClient.ActualAddress.Aa_Notes ?? ""
                }
            };        // Полний адрес клиента
            //client.fullADRMORE = "";     // Дополнительные адреса (для юр лиц)
            client.CODCAGENT = Convert.ToString(ebkClient.K010);       // Характеристика клиента (К010)
            client.COUNTRY = Convert.ToString(ebkClient.K040);         // Цифровой код страны
            client.PRINSIDER = Convert.ToString(ebkClient.K060);       // Признак инсайдера (К060)
            client.TGR = Convert.ToString(ebkClient.buildStateRegister);             // Тип гос. реестра
            //client.STMT = "";            // Вид выписки
            client.OKPO = ebkClient.Okpo ?? "";            // Идентификационный код
            //client.SAB = "";             // Эликтронный код клиента
            //client.BC = "";              // Признак не является клиентом банка (1)
            client.TOBO = "";//ebkClient.Kf;            // ТОБО отделения

            // Рекв. налогопл.
            client.RNlPres = "";         // Рекв. налогопл. заполнены\не заполнены

            if (ebkClient.TaxpayersDetail == null)
            {
                client.C_REG = "";
                client.C_DST = "";
                client.ADM = "";
                client.TAXF = "";
                client.RGADM = "";
                client.RGTAX = "";
                client.DATET = "";
                client.DATEA = "";
            }
            else
            {
                client.C_REG = ebkClient.TaxpayersDetail.RegionalPi.ToString();           // Областная НИ
                client.C_DST = ebkClient.TaxpayersDetail.AreaPi.ToString();         // Районная НИ
                client.ADM = ebkClient.TaxpayersDetail.AdmRegAuthority ?? "";         // Адм. орган регистрации
                client.TAXF = ebkClient.TaxpayersDetail.TP_K050.ToString();             // Налоговый код (К050)
                client.RGADM = ebkClient.TaxpayersDetail.AdmRegNumber ?? "";           // Рег. номер в Адм.
                client.RGTAX = ebkClient.TaxpayersDetail.PiRegNumber ?? "";           // Рег. номер в НИ
                client.DATET = ebkClient.TaxpayersDetail.Piregdate == null ? "" : ebkClient.TaxpayersDetail.Piregdate.Value.ToString("dd.MM.yyyy");           // Дата рег. в НИ
                client.DATEA = ebkClient.TaxpayersDetail.AdmRegDate == null ? "" : ebkClient.TaxpayersDetail.AdmRegDate.Value.ToString("dd.MM.yyyy");            // Дата рег. в Адм.
            }


            // Экономические нормативы
            client.NEkPres = "";         // Экономические нормативы заполнены\не заполнены
            client.ISE = ebkClient.economicRegulations == null ? "" : ebkClient.economicRegulations.K070 ?? "";             // Инст. сек. экономики (К070)
            client.FS = ebkClient.economicRegulations == null ? "" : ebkClient.economicRegulations.K080 ?? "";              // Форма собственности (К080)
            client.VED = ebkClient.economicRegulations == null ? "" : ebkClient.economicRegulations.K110 ?? "";             // Вид эк. деятельности (К110)
            //client.OE = "";              // Отрасль экономики (К090)
            client.K050 = ebkClient.economicRegulations == null ? "" : ebkClient.economicRegulations.K050 ?? "";            // Форма хозяйствования (К050)
            client.SED = ebkClient.economicRegulations == null ? "" : ebkClient.economicRegulations.K051 ?? "";            // Форма хозяйствования (К051)

            client.RCFlPres = "";        // Реквизиты клиента физ.лицо заполнены\не заполнен

            if (ebkClient.CustomerDetails == null)
            {
                client.PASSP = "";
                client.SER = "";
                client.NUMDOC = "";
                client.ORGAN = "";
                client.PDATE = "";
                client.BDAY = "";
                client.BPLACE = "";
                client.SEX = "";
                client.TELW = "";
            }
            else
            {
                client.PASSP = Convert.ToString(ebkClient.CustomerDetails.DocType) ?? "";           // Вид документа
                client.SER = ebkClient.CustomerDetails.DocSer ?? "";             // Серия
                client.NUMDOC = ebkClient.CustomerDetails.DocNumber ?? "";          // Номер док.
                client.ORGAN = ebkClient.CustomerDetails.DocOrgan ?? "";           // Кем выдан
                client.PDATE = ebkClient.CustomerDetails.DocIssueDate != null ? ebkClient.CustomerDetails.DocIssueDate.Value.ToString("dd.MM.yyyy") : null;            // Когда выдан
                client.BDAY = ebkClient.CustomerDetails.BirthDate != null ? ebkClient.CustomerDetails.BirthDate.Value.ToString("dd.MM.yyyy") : null;            // Дата рождения
                client.BPLACE = ebkClient.CustomerDetails.BirthPlace ?? "";          // Место рождения
                client.SEX = ebkClient.CustomerDetails.Sex ?? "";             // Пол
                client.TELW = ebkClient.CustomerDetails.MobilePhone ?? "";            // Телефон 2
                client.DopRekv_MPNO = ebkClient.CustomerDetails.MobilePhone ?? "";
                client.ACTUAL_DATE = ebkClient.CustomerDetails.ActualDate != null ? ebkClient.CustomerDetails.ActualDate.Value.ToString("dd.MM.yyyy") : null;
                client.EDDR_ID = ebkClient.CustomerDetails.EddrId ?? "";
            }


            // Доп реквизиты
            client.DopRekv = "";

            client.CRISK = ebkClient.AdditionalInformation == null ? "" : ebkClient.AdditionalInformation.BorrowerClass.ToString();
            client.MB = ebkClient.AdditionalInformation == null ? "" : ebkClient.AdditionalInformation.SmallBusinessBelonging ?? "";

            List<AdditionalСlientInformation> additionalClientInfo = _clientAdditionalUtil.GetAdditionalClientInformationListPrivateEn();

            _clientAdditionalUtil.AddDopRekv(client, additionalClientInfo, ebkClient);

            return client;
        }

        // Legal
        private Client SetEbkClientLpParamToClient(LegalPerson ebkClient, Client client)
        {
            //client.DATE_OFF = ebkClient.DateOff != null ? ebkClient.DateOff.Value.ToString("dd.MM.yyyy") : null;        // Дата закрытия
            //client.ND = ebkClient.AdditionalInformation. Document.Numdoc;              // Номер договора
            client.NMK = ebkClient.FullName ?? "";             // Наименование или ФИО
            client.NMKV = ebkClient.FullNameInternational ?? "";            // Наименование (межд.)
            client.NMKK = ebkClient.FullNameAbbreviated ?? "";             // Наименование (краткое)
            //client.ADR = ebkClient.ActualAddress.Adr;             // Адрес клиента
            client.fullADR = new CustomerAddress();

            if (ebkClient.LegalAddress == null)
            {
               client.fullADR.type1 = new CustomerAddress.Address();
            }
            else
            {
                client.fullADR.type1 = new CustomerAddress.Address
                {
                    filled = true,
                    zip = ebkClient.LegalAddress.La_Index ?? "",
                    region = ebkClient.LegalAddress.La_Region ?? "",
                    locality = ebkClient.LegalAddress.La_Settlement ?? "",
                    address = ebkClient.LegalAddress.La_FullAddress ?? "",
                    territory_id = ebkClient.LegalAddress.La_TerritoryCode,
                    domain = ebkClient.LegalAddress.La_Area ?? ""

                };
            }

            if (ebkClient.ActualAddress == null)
            {
                client.fullADR.type2 = new CustomerAddress.Address();
            }
            else
            {

                client.fullADR.type2 = new CustomerAddress.Address
                {
                    filled = true,
                    zip = ebkClient.ActualAddress.Aa_Index ?? "",
                    region = ebkClient.ActualAddress.Aa_Region ?? "",
                    locality = ebkClient.ActualAddress.Aa_Settlement ?? "",
                    address = ebkClient.ActualAddress.Aa_FullAddress ?? "",
                    territory_id = ebkClient.ActualAddress.Aa_TerritoryCode,
                    domain = ebkClient.ActualAddress.Aa_Area ?? ""

                };

            }

            //client.fullADRMORE = "";     // Дополнительные адреса (для юр лиц)
            client.COUNTRY = Convert.ToString(ebkClient.K040);         // Цифровой код страны
            client.PRINSIDER = Convert.ToString(ebkClient.K060);       // Признак инсайдера (К060)
            client.TGR = Convert.ToString(ebkClient.BuildStateRegister);             // Тип гос. реестра
            //client.STMT = "";            // Вид выписки
            client.OKPO = ebkClient.Okpo ?? "";            // Идентификационный код
            //client.SAB = "";             // Эликтронный код клиента
            //client.BC = "";              // Признак не является клиентом банка (1)
            client.TOBO = "";//ebkClient.Kf;            // ТОБО отделения

            // Рекв. налогопл.
            client.RNlPres = "";         // Рекв. налогопл. заполнены\не заполнены
            client.C_REG = ebkClient.TaxpayerDetails != null ? (ebkClient.TaxpayerDetails.RegionalPi != null ? ebkClient.TaxpayerDetails.RegionalPi.ToString() : "") : "";          // Областная НИ
            client.C_DST = ebkClient.TaxpayerDetails != null ? (ebkClient.TaxpayerDetails.AreaPi != null ? ebkClient.TaxpayerDetails.AreaPi.ToString() : "") : "";         // Районная НИ
            client.ADM = ebkClient.TaxpayerDetails != null ? (ebkClient.TaxpayerDetails.AdmRegAuthority ?? "") : "";        // Адм. орган регистрации
            client.TAXF =  "";// Налоговый код (К050)
            client.RGADM = "";           // Рег. номер в Адм.
            client.RGTAX = "";           // Рег. номер в НИ
            client.DATET = ebkClient.TaxpayerDetails != null ? (ebkClient.TaxpayerDetails.AdmRegDate  != null ? ebkClient.TaxpayerDetails.AdmRegDate.Value.ToString("dd.MM.yyyy") : "") : "";           // Дата рег. в НИ
            client.DATEA = ebkClient.TaxpayerDetails != null ? (ebkClient.TaxpayerDetails.PiRegDate  != null ? ebkClient.TaxpayerDetails.PiRegDate.Value.ToString("dd.MM.yyyy") : "" ) : ""; // Дата рег. в Адм.

            client.NMKU = ebkClient.CustomerDetails != null ? (ebkClient.CustomerDetails.NameByStatus ?? "") : "";

            // Экономические нормативы
            client.NEkPres = "";         // Экономические нормативы заполнены\не заполнены
            client.ISE = ebkClient.EconomicRegulations != null ? (ebkClient.EconomicRegulations.K070 ?? "") : ""; // Инст. сек. экономики (К070)
            client.FS = ebkClient.EconomicRegulations != null ? (ebkClient.EconomicRegulations.K080 ?? "") : "";  // Форма собственности (К080)
            client.VED = ebkClient.EconomicRegulations != null ? (ebkClient.EconomicRegulations.K110 ?? "") : ""; // Вид эк. деятельности (К110)
            //client.OE = "";              // Отрасль экономики (К090)
            client.K050 = ebkClient.EconomicRegulations != null ? (ebkClient.EconomicRegulations.K050 ?? "") : ""; // Форма хозяйствования (К050)
            client.SED = ebkClient.EconomicRegulations != null ? (ebkClient.EconomicRegulations.K051 ?? "") : "";  // Форма хозяйствования (К051)


            client.CRISK = ebkClient.AdditionalInformation != null ? ( ebkClient.AdditionalInformation.BorrowerClass != null ? ebkClient.AdditionalInformation.BorrowerClass.ToString() : "") :  "";       // Класс заемщика
            client.RNKP = ebkClient.AdditionalInformation != null ? (ebkClient.AdditionalInformation.RegionalHoldingNumber ?? "") : "";        // регистрационный № холдинга

            client.RCFlPres = "";        // Реквизиты клиента физ.лицо заполнены\не заполнен

            if (ebkClient.AdditionalDetails != null)
            {
                List<AdditionalСlientInformation> additionalClientInfo = _clientAdditionalUtil.GetAdditionalClientInformationListLegal();
                _clientAdditionalUtil.AddDopRekv(client, additionalClientInfo, ebkClient.AdditionalDetails);
            }

            return client;
        }

        private string GetClientEbkParamString(string rnk, CustomerParameters custParams, string kf)
        {

            if (!String.IsNullOrEmpty(rnk) && custParams.UseCdmValidation)
            {
                string result = new DeduplicateRepository(new BanksRepository(), null, null).GetGcif(Decimal.Parse(rnk), kf);
                if (!string.IsNullOrEmpty(result))
                {
                    return ", GCIF: " + result;
                }
            }
            return "";
        }       
    }
}
