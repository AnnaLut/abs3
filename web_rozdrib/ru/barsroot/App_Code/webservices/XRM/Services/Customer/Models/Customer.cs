using System;
using System.Collections.Generic;

namespace Bars.WebServices.XRM.Services.Customer.Models
{
    public class NMK
    {
        public String LastName;
        public String FirstName;
        public String ThirdName;
        public string NMK_;
    }
    /// класс адреса

    public class CustAddress
    {
        public Decimal? TYPE_ID;                   //Тип адреса (1	Юридична, 2	Фактична,3	Почтова)
        public Decimal? COUNTRY;                   //Код страны
        public String ZIP;                         //Индекс
        public String DOMAIN;                      //Область
        public String REGION;                      //Регион
        public String LOCALITY;                    //Населенный пункт
        public String ADDRESS;                     //Адрес (улица, дом, квартира) - это составное поле из остальных!
        public Decimal? TERRITORY_ID;              //Код адреса
        public Decimal? LOCALITY_TYPE;             //Тип населенного пункта
        public Decimal? STREET_TYPE;               //Тип улицы
        public String STREET;                      //Улица
        public Decimal? HOME_TYPE;                 //Тип дома
        public String HOME;                        //№ дома
        public Decimal? HOMEPART_TYPE;             //Тип деления дома(если есть)
        public String HOMEPART;                    //№ типа деления дома
        public Decimal? ROOM_TYPE;                 //Тип жилого помещенияs
        public String ROOM;                        //№ жилого помещения
        public String COMM;                        //Довільний коментар                
        public String AREA;
        public String SETTLEMENT;
        public String STREET_ID;
    }
    public class Person
    {
        public Decimal? PASSP;
        public String SER;
        public String DOCNUM;
        public String EDDR_ID;
        public DateTime? PASSP_EXPIRES;
        public String OrganMain;
        public DateTime? PasspFrom;
        public DateTime? PasspPhoto;
        public DateTime? Birthday;
        public String Birthplace;
        public Decimal? SEX;
        public Decimal? MobPhoneIsAbsent;
        public String MobPhone;
        public String HomePhone;
        public String WorkPhone;
    }
    public class TaxIndicators
    {
        public String RGTAX;                       //Тип держ. реєстру
        public Decimal? C_REG;                     //Обласна ПІ
        public Decimal? C_DST;                     //Районна ПІ
        public String ADM;                         //Адміністративний орган реєстрації
        public String RGADM;                       //Реєстраційний номер в адміністрації
        public String RGPI;                        //Реєстраційний номер у Податк
        public DateTime? DPIDate;                  //Дата реєстрації у ПІ
        public DateTime? RGADMDate;                //Дата реєстрації у адміністрації
        public String TAXF;                        //индивидуальный налоговый номер
        public String nomPDV;
    }
    public class EconomicIndicators
    {
        public Decimal? COUNTRY;                   //Громадянство
        public Decimal? PRINSIDER;                 //Ознака інсайдера (К060)       
        public Decimal? TGR;                       //Тип реєстрації клієнта
        public String K050;                        //Податковий код (К050)       
        public String ISE;                         //Інституційний сектор економіки (К070)
        public String FS;                          //Форма власності (К080)
        public String OE;                          //Форма господарювання (К051)
        public String VED;                         //Вид економічної діяльності (К110)
        public String SED;
        public String MB;                          //Належність до малого бізнесу
        public String BC;                          //признак не клиента банка
        public String CRISK;                       //Клас позичальника
        public String PINCODE;                     //хрензнаетчто пустьбудет
        public Decimal? RnkP;                      //рнк холдинга
        public String SAB;                         //эл.код клиента, возможно в КБ
        public String NREZID_CODE;                 //номер в стране регистрации для нерезидентов
    }
    public class AdditionalInfo
    {
        public String Notes;                       //Примітка
        public String OtherADDRESS;                //Альтернативна адреса
        public Decimal? ActLimit;                  //Ліміт на активні операції
        public Decimal? CashLimit;                 //Ліміт каси
        public String ND;                          //№ договору за супроводження 
        public String Holding;                     //Реєстраційний № холдингу
        public String SecurityNotes;               //Примітка для служби безпеки
    }
    public class AdditionalCommon
    {
        public String BUSSS;                       //Бізнес-сектор
        public String INSFO;                     //Ознака наявності анкети інсайдера (0-ні, 1-так)
    }
    public class AdditionalFM
    {
        public String EMAIL;                       //Адреса електронної пошти
        public String ID_YN;                       //Ідентифікація клієнта проведена FM_YESNO
        public String DATZ;                        //Дата первинного заповнення анкети
        public String RIZIK;                       //Рiвень ризику
        public String O_REP;                       //Оцінка репутації клієнта FM_O_REP
        public String IDPIB;                       //ПІБ та тел. працівника, відповідальн. за ідентифікацію і вивчення клієнта 
        public String DJER;                        //Характеристика джерел надходжень коштів        
        public String FADR;                        //Адреса тимчасового перебування (ФО-нерезидент)
        public String CCVED;                       //Вид (види) господарської (економічної) діяльності
        public String VPD;                         //Вид підприємницької діяльності (ФО)
        public String PHKLI;                       //Види послуг, якими користується клієнт
        public String AF1_9;                       //Дані про реєстрацію фізичної особи як підприємця (ФО)
        public String DATVR;                       //Дата відкриття першого рахунку
        public String IDDPD;                       //Дата внесення до анкети останніх змін
        public String IDDPL;                       //Дата планової iдентифiкацiї
        public String OBSLU;                       //Історія обслуговування(iнф. щодо послуг, позит./негат. фактів співробітництва)
        public String LICO;                        //Ліцензії(дозволи) на право здійснення певних операцій
        public String WORK;                        //Місце роботи, посада
        public String PUBLP;                       //Належність до публічних діячів
        public String SNSDR;                       //Облікова серія,№ свідоцтва про державну реєстрацію
        public String OVIFS;                       //Оцінка відповідності операцій клієнта наявній інформації щодо його фінансового стану
        public String OVIDP;                       //Оцінка відповідності операцій клієнта суті та напрямам діяльності
        public String FSVSN;                       //Оцінка фінансового стану: висновок
        public String FSZPD;                       //Оцінка фін.стану: Здійснення підприємницької діяльності (ФО)
        public String FSSST;                       //Оцінка фiн.стану: Соціальний статус (ФО)
        public String FSKRK;                       //Оцінка фiн.стану: Наявність кредит. Заборгованості перед банками (ФО)
        public String FSOMD;                       //Оцінка фiн.стану: Орієнтовний місячний сукупний дохід сiм’ї (ФО)
        public String FSSOD;                       //Оцінка фiн.стану: Сума основного доходу (ФО)
        public String FSVLA;                       //Оцінка фiн.стану: власність – авто
        public String FSVLZ;                       //Оцінка фiн.стану: власність - земельна ділянка
        public String FSVLN;                       //Оцінка фiн.стану: власність – нерухомість
        public String DJ_CP;                       //Оцінка фiн.стану: власність - цінні папери
        public String AINAB;                       //Рахунки клієнта в інших банках
        public String SUTD;                        //Характеристика суті діяльності
        public String IDDPR;                       //Дата проведеної iдентифiкацiї/уточнення інформації
    }
    public class AdditionalDeposit
    {
        public String DOV_A;                       //Адреса довіреної особи (Вклади)
        public String DOV_F;                       //Довірена особа (Вклади)
        public String DOV_P;                       //Паспортні дані довіреної особи (Вклади)
    }
    public class AdditionalBPK
    {
        public String PC_MF;                       //  БПК. Дівоче прізвище матері
        public String PC_Z4;                       //  БПК. Закордонний паспорт. Дійсний до
        public String PC_Z3;                       //  БПК. Закордонний паспорт. Ким виданий
        public String PC_Z5;                       //  БПК. Закордонний паспорт. Коли виданий
        public String PC_Z2;                       //  БПК. Закордонний паспорт. Номер
        public String PC_Z1;                       //  БПК. Закордонний паспорт. Серія
        public String AGENT;                       //  БПК. Код ЕДРПОУ п_дприємства, в якому працює
        public String PC_SS;                       //  БПК. Сімейний стан
        public String PENSN;                       //  Номер ЕПП         
    }
    public class AdditionalMisc
    {
        public String K013;                         //  Код виду клієнта (K013)KL_K013
        public String SUBS;                         //  Наявн субсидії
        public String SUBSN;                        //  Номер субсидії
        public String SUBSD;                        //  Датасубсидії
        public String CIGPO;                        //  Статус зайнятості особи CIG_D09
        public String ELT_N;                        //  ELT: № договору Клієнт-Банк і т.п.    
        public String ELT_D;                        //  ELT: Дата договору Клієнт-Банк і т.п.   
        public String SW_RN;                        //  SWIFT: Найменування клієнта російською мовою 
        public String Y_ELT;                        //  Авто стягнення тарифа абонплати (по умолч= Y)    
        public String SAMZ;                         //  Відмітка про самозайнятiсть фiз.особи  FM_YESNO   
        public String VIDKL;                        //  Вид клієнта     FM_SAILOR
        public String CRSRC;                        //  Джерело створення (DPT - деп. модуль, CCK - кредитний модуль і тп)    
        public String MS_FS;                        //  КП-г.05 Орг-прав.форма клієнта     MS_FS_K
        public String MS_VD;                        //  КП-г.50 Галузь виду діяльн. Позичальника  MS_VD_K
        public String MS_GR;                        //  КП-г.53 Приналежність до групи 
        public String CHORN;                        //  Категорія громадян, якi постраждали внаслідок Чорноб.катастрофи CAT_CHORNOBYL
        public String SPMRK;                        //  Код "Особливої Відмітки" нестандартного клієнта ФО MARK_CODE 
        public String KODID;                        //  Код iдентифiкацiї клієнта
        public String UADR;                         //  Місцезнаходження юридичної справи
        public String MPNO;                         //  Мобільний телефон
        public String MOB01;                        //  Мобільний телефон 1
        public String MOB02;                        //  Мобільний телефон 2
        public String MOB03;                        //  Мобільний телефон 3
        public String NSMCC;                        //  НСМЕП: Вид клієнта (клієнт/співробітник/депозит/пенсіонер)
        public String NSMCT;                        //  Код клієнта в картковій системі
        public String NSMCV;                        //  Тип клієнта (A - власник картки, B - торговець)
                                                    //Настання смерті клієнта ???
        public String ADRP;                         //  Поштова адреса
        public String TARIF;                        //  Страховий тариф ФО (%)

    }
    public class AdditionalReq
    {
        public AdditionalCommon AdditionalCommon;
        public AdditionalFM AdditionalFM;
        public AdditionalDeposit AdditionalDeposit;
        public AdditionalBPK AdditionalBPK;
        public AdditionalMisc AdditionalMisc;
    }

    public class SetCustomerRisk
    {
        public decimal RiskId;
        public decimal Value;
        public String ErrorCode;
    }
    public class CustomerRisk
    {
        public decimal RiskId;
        public string Dat_Begin;
        public string Dat_End;
    }

    //class for testing terrorists, insiders, public figures
    public class CheckClient
    {
        public Decimal? RelId;
        public Decimal? RelRnk;
        public Decimal? Relintext;
        public Decimal? Vaga1;
        public Decimal? Vaga2;
        public Decimal? TypeId;
        public String Position;
        public String Position_r;
        public String FirstName;
        public String MiddleName;
        public String LastName;
        public Decimal? DocumentTypeId;
        public String Document;
        public String TrustRegNum;
        public DateTime? TrustRegDat;
        public DateTime? BDate;
        public DateTime? EDate;
        public String NotaryName;
        public String NotaryRegion;
        public Decimal? SignPrivs;
        public Decimal? SignId;
        public String Namer;
    }

    /// класс полного перечня реквизитов клиента
    public class ClientCommonReq
    {
        public Decimal? RNK;
        public string KF;
        public Decimal? CUSTTYPE;
        public Decimal? CODCAGENT;
        public DateTime? DATE_ON;
        public DateTime? DATE_OFF;
        public NMK NMKSplit;
        public String NMK;
        public String NMKK;
        public String NMKV;
        public String NMKR;                            //ПІБ клієнта в родовому відмінку
        public String ADDR;                            //коротка адреса
        public CustAddress ClientAddressLegal;         //Юридична
        public CustAddress ClientAddressActual;        //Фактична
        public CustAddress ClientAddressPostal;        //Поштова адреса
        public Person ClientPerson;                    //документи клієнта
        public AdditionalInfo AdditionalInfo;          //Содержимое закладки Додаткова інформація
        public TaxIndicators TaxIndicators;            //Содержимое закладки Реквізити податкової
        public EconomicIndicators EconomicIndicators;  //Содержимое закладки Економічні показники        
        public String OKPO;                            //Ідентифікаційний номер
        public String BRANCH;                          //Безбалансове відділення (Бранч)
        public String TOBO;                            //Безбалансове відділення (Бранч)             
        public AdditionalReq AdditionalReq;            //блок додаткових параметрів разного содержания      
        public SetCustomerRisk[] SetCustomerRisks;     //блок установки рисков
        public CustomerRisk[] CustomerRisk;            //все установленные риски клиента списком
        public CheckClient CheckClient;
    }
    public class SetClient
    {
        public Decimal TransactionId;
        public String UserLogin;
        public Int16 OperationType;
        public Int16 ClientType;
        public Int16 FormType;
        public ClientCommonReq ClientRequisites;
        public Decimal ClientManager;
        public Decimal Status;
        public Decimal RNK;
        public String NMKR;
        public String StatusCode;
        public String ErrorCode;
    }

    public class SetVerifiedClient
    {
        public Decimal TransactionId;
        public String UserLogin;
        public Int16 OperationType;
        public Decimal RNK;
        public Decimal StatusCode;
        public String ErrorCode;
    }

    public class ClientAttr
    {
        public Decimal RNK;
        public String TAG;
        public String VAL;
        public Decimal OTD;

    }
}