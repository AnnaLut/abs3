CREATE OR REPLACE PACKAGE BARS_ZAY
is
 head_ver constant varchar2(64) := 'version 6.2 09.07.2018';
 head_awk constant varchar2(512) := ''
 ||'СБЕРБАНК' ||chr(10)
;

-- Надра aw bars_zay_head.sql BARS.bars_zay_head.ndr SBER+SEGM+NOKK
-- Сбер   aw bars_zay_head.sql bars_zay_head.sb SBER
-- УПБ    aw bars_zay_head.sql bars_zay_head.upb

  --
  -- типы
  --
  type t_accrec is record (accid    accounts.acc%type,    -- внутр.№ счета
                           accnum   accounts.nls%type,    -- лицевой № счета
                           accname  accounts.nms%type,    -- наименование счета
                           curid    accounts.kv%type,     -- код валюты
                           custcode customer.okpo%type);  -- идентиф.код клиента
  --
  -- определение версии заголовка пакета
  --
  function header_version return varchar2;
  --
  -- определение версии тела пакета
  --
  function body_version   return varchar2;
  --
  -- определение торговых внутрибанковских счетов
  --
  procedure get_bankaccounts
   (p_currency  in  tabval.kv%type, -- валюта
    p_konvcurr  in  tabval.kv%type, -- валюта конверсии
    p_taxflag   in  number,         -- признак отчисления в Пенс.Фонд
    p_trdaccFC  out t_accrec,       -- торговый счет ГОУ в ин.валюте
    p_trdaccNC  out t_accrec,       -- торговый счет ГОУ в нац.валюте
    p_cmsacc    out t_accrec,       -- счет комиссионных доходов
    p_taxacc    out t_accrec);      -- транз.счет для перечисления в Пенс.Фонд
  --
  -- формирование пакета документов по заявке на покупку валюты
  --
  procedure pay_buying
   (p_zayid   in   zayavka.id%type,          -- идентификатор заявки
    p_taxrate in   number,                   -- процент отчисления в Пенс.фонд
    p_taxcust in   number,                   -- признак отчисления в Пенс.фонд на счет клиента
    p_indx39  in   varchar2,                 -- показатель для 39-го файла
    p_vobFС   in   vob.vob%type default 46,  -- вид мемориального ордера в ин.валюте
    p_vobNС   in   vob.vob%type default 6,   -- вид мемориального ордера в нац.валюте
    p_buyref  out  oper.ref%type,            -- референс зачисления валюты
    p_taxref  out  oper.ref%type);           -- референс отчисления в Пенс.Фонд
  --
  -- формирование пакета документов по заявке на продажу валюты
  --
  procedure pay_selling
   (p_zayid   in  zayavka.id%type,           -- идентификатор заявки
    p_indx39  in   varchar2,                 -- показатель для 39-го файла
    p_vobFС   in  vob.vob%type default 46,   -- вид мемориального ордера в ин.валюте
    p_vobNС   in  vob.vob%type default 6,    -- вид мемориального ордера в нац.валюте
    p_selref  out oper.ref%type);            -- референс зачисления нац.валюты

  --
  -- формирование документа по списанию средств в заявке на покупку валюты
  --
  procedure pay_buying_sps
   (p_zayid   in   zayavka.id%type,          -- идентификатор заявки
    p_vob     in   vob.vob%type default 6,   -- вид мемориального ордера
    p_buyref  out  oper.ref%type             -- референс списания нац.валюты
    );

  --
  -- формирование документа по списанию средств в заявке на продажу валюты
  --
  procedure pay_selling_sps
   (p_zayid   in   zayavka.id%type,          -- идентификатор заявки
    p_vob     in   vob.vob%type default 6,   -- вид мемориального ордера
    p_selref  out  oper.ref%type             -- референс списания валюты
    );

  --
  -- создание заявки на покупку/продажу валюты (оболочка для вызова create_request, но без асс счетов, а с nls)
  --
  procedure create_request_ex
   (p_reqtype       in  zayavka.dk%type,                          -- тип заявки (1-покупка, 2-продажа, 3-конверсия)
    p_custid        in  zayavka.rnk%type,                         -- регистр.№ клиента
    p_curid         in  zayavka.kv2%type,                         -- числ.код валюты (для dk(1,3) - которая покупается, для 2 - которая продается)
    p_curconvid     in  zayavka.kv_conv%type       default null,  -- числ.код валюты за которую покупается (для dk = 3)
    p_amount        in  zayavka.s2%type,                          -- сумма заявленной валюты ("приведенная")
    p_reqnum        in  zayavka.nd%type            default null,  -- номер заявки
    p_reqdate       in  zayavka.fdat%type          default null,  -- дата заявки
    p_reqrate       in  zayavka.kurs_z%type        default null,  -- курс заявки
    p_nls_acc1      in  zayavka.nls0%type,                        -- № счета в ин.вал. (для 1 - вал счет зачисления, для 2 - вал счет списания, для 3 - вал счет зачисления)
    p_nls_acc0      in  zayavka.nls0%type,                        -- № счета в нац.вал.(для 1 - грн счет списания, для 2 - грн счет зачисления(при зачислении выруч.грн на межбанк - поле пустует,зато заполняются поля mfo0, nls0,okpo0), для 3 - вал счет для списания)
    p_nataccnum     in  zayavka.nls0%type          default null,  -- счет в нац.валюте в др.банке     (для dk = 2)
    p_natbnkmfo     in  zayavka.mfo0%type          default null,  -- МФО банка счета в нац.валюте     (для dk = 2)
    p_cmsprc        in  zayavka.kom%type           default null,  -- процент (%) комиссии
    p_cmssum        in  zayavka.skom%type          default null,  -- фикс.сумма комиссии
    p_taxflg        in  zayavka.fl_pf%type         default 1,     -- признак отчисления в ПФ          (для dk = 1)
    p_taxacc        in  zayavka.nlsp%type          default null,  -- счет клиента для отчисления в ПФ (для dk = 1)
    p_aimid         in  zayavka.meta%type          default null,                        -- код цели покупки/продажи
    p_f092	    in  zayavka.f092%type          default null,  -- код параметра F092
    p_contractid    in  zayavka.pid%type           default null,  -- идентификатор контракта
    p_contractnum   in  zayavka.contract%type      default null,  -- номер контракта/кред.договора
    p_contractdat   in  zayavka.dat2_vmd%type      default null,  -- дата контракта/кред.договора
    p_custdeclnum   in  zayavka.num_vmd%type       default null,  -- номер последней тамож.декларации
    p_custdecldat   in  zayavka.dat_vmd%type       default null,  -- дата последней тамож.декларации
    p_prevdecldat   in  zayavka.dat5_vmd%type      default null,  -- даты предыдущ.тамож.деклараций    (для dk = 1)
    p_basis         in  zayavka.basis%type         default null,  -- основание для покупки валюты      (для dk = 1)
    p_countryid     in  zayavka.country%type       default null,  -- код страны перечисления валюты    (для dk = 1)
    p_bnfcountryid  in  zayavka.benefcountry%type  default null,  -- код страны бенефициара            (для dk = 1)
    p_bnfbankcode   in  zayavka.bank_code%type     default null,  -- код банка (B010)                  (для dk = 1)
    p_bnfbankname   in  zayavka.bank_name%type     default null,  -- название банка                    (для dk = 1)
    p_productgrp    in  zayavka.product_group%type default null,  -- код товарной группы               (для dk = 1)
    p_details       in  zayavka.details%type       default null,  -- подробности заявки
    p_flag          in  number                     default 0 ,    -- признак Кл-Б (Олег)
    p_fio           in  zayavka.contact_fio%type   default null,  -- ПИБ уполномоченного
    p_tel           in  zayavka.contact_tel%type   default null,  -- тел уполномоченного
    p_branch        in  zayavka.branch%type        default null,  -- бранч заявки
    p_operid_nokk   in  zayavka.operid_nokk%type   default null,  -- Унікальний номер операції в системі Клієнт-Банк (Олег, Надра)
    p_req_type      in  zayavka.req_type%type      default null,  -- Тип заявки
    p_vdateplan     in  zayavka.vdate_plan%type    default null,  -- Плановая дата валютирования
    p_obz           in  zayavka.obz%type           default null,  -- Признак заявки на обязательную продажу (1)
    p_rnk_pf        in  zayavka.rnk_pf%type        default null,  -- для покупки - рег.№ клиента в пф для продажи: код для 27-го файла
    p_reqid         out zayavka.id%type);

  --
  -- создание заявки на покупку/продажу валюты
  --
  procedure create_request
   (p_reqtype       in  zayavka.dk%type,                          -- тип заявки (1-покупка, 2-продажа, 3-конверсия)
    p_custid        in  zayavka.rnk%type,                         -- регистр.№ клиента
    p_curid         in  zayavka.kv2%type,                         -- числ.код валюты (для dk(1,3) - которая покупается, для 2 - которая продается)
    p_curconvid     in  zayavka.kv_conv%type       default null,  -- числ.код валюты за которую покупается (для dk = 3)
    p_amount        in  zayavka.s2%type,                          -- сумма заявленной валюты (в коп.)
    p_reqnum        in  zayavka.nd%type            default null,  -- номер заявки
    p_reqdate       in  zayavka.fdat%type          default null,  -- дата заявки
    p_reqrate       in  zayavka.kurs_z%type        default null,  -- курс заявки
    p_frxaccid      in  zayavka.acc1%type,                        -- внутр.№ счета в ин.вал. (для 1 - вал счет зачисления, для 2 - вал счет списания, для 3 - вал счет зачисления)
    p_nataccid      in  zayavka.acc0%type,                        -- внутр.№ счета (для 1 - грн счет списания, для 2 - грн счет зачисления(при зачислении выруч.грн на межбанк - поле пустует,зато заполняются поля mfo0, nls0,okpo0), для 3 - вал счет для списания)
    p_nataccnum     in  zayavka.nls0%type          default null,  -- счет в нац.валюте в др.банке     (для dk = 2)
    p_natbnkmfo     in  zayavka.mfo0%type          default null,  -- МФО банка счета в нац.валюте     (для dk = 2)
    p_okpo0         in  zayavka.okpo0%type         default null,  -- ОКПО для зачисления грн на м/б при продаже (для dk = 2)
    p_cmsprc        in  zayavka.kom%type           default null,  -- процент (%) комиссии
    p_cmssum        in  zayavka.skom%type          default null,  -- фикс.сумма комиссии
    p_taxflg        in  zayavka.fl_pf%type         default 1,     -- признак отчисления в ПФ          (для dk = 1)
    p_taxacc        in  zayavka.nlsp%type          default null,  -- счет клиента для отчисления в ПФ (для dk = 1)
    p_aimid         in  zayavka.meta%type          default null,                        -- код цели покупки/продажи
    p_contractid    in  zayavka.pid%type           default null,  -- идентификатор контракта
    p_contractnum   in  zayavka.contract%type      default null,  -- номер контракта/кред.договора
    p_contractdat   in  zayavka.dat2_vmd%type      default null,  -- дата контракта/кред.договора
    p_custdeclnum   in  zayavka.num_vmd%type       default null,  -- номер последней тамож.декларации
    p_custdecldat   in  zayavka.dat_vmd%type       default null,  -- дата последней тамож.декларации
    p_prevdecldat   in  zayavka.dat5_vmd%type      default null,  -- даты предыдущ.тамож.деклараций    (для dk = 1)
    p_basis         in  zayavka.basis%type         default null,  -- основание для покупки валюты      (для dk = 1)
    p_countryid     in  zayavka.country%type       default null,  -- код страны перечисления валюты    (для dk = 1)
    p_bnfcountryid  in  zayavka.benefcountry%type  default null,  -- код страны бенефициара            (для dk = 1)
    p_bnfbankcode   in  zayavka.bank_code%type     default null,  -- код банка (B010)                  (для dk = 1)
    p_bnfbankname   in  zayavka.bank_name%type     default null,  -- название банка                    (для dk = 1)
    p_productgrp    in  zayavka.product_group%type default null,  -- код товарной группы               (для dk = 1)
    p_details       in  zayavka.details%type       default null,  -- подробности заявки
    p_contactfio    in  zayavka.contact_fio%type   default null,  -- ФИО контактного лица
    p_contacttel    in  zayavka.contact_tel%type   default null,  -- ТЕЛ контактного лица
    p_branch        in  zayavka.branch%type        default null,  -- бранч заявки
    p_operid_nokk   in  zayavka.operid_nokk%type   default null,  -- Унікальний номер операції в системі Клієнт-Банк (Олег, Надра)
    p_identkb       in  zayavka.identkb%type       default null,  -- Признак системі клиент-банк 1- корп2, 2 - корп лайт
    p_reqid         out zayavka.id%type);                         -- идентификатор заявки

  --
  -- определение обеспеченности заявки на покупку/продажу валюты (возвращает 1/0)
  --
  function get_request_cover (p_reqid in zayavka.id%type) -- идентификатор заявки
  return number;

  --
  -- расчет комиссии (% и/или фикс.сумма) за покупку/продажу валюты
  --
  procedure get_commission
   (p_reqtype in  zayavka.dk%type,    -- тип заявки (1-покупка, 2 -продажа)
    p_custid  in  zayavka.rnk%type,   -- регистр.№ клиента
    p_curid   in  zayavka.kv2%type,   -- числ.код валюты
    p_amount  in  zayavka.s2%type,    -- сумма заявленной валюты (в коп.)
    p_reqdate in  zayavka.fdat%type,  -- дата заявки
    p_cmsprc  out zayavka.kom%type,   -- процент (%) комиссии
    p_cmssum  out zayavka.skom%type); -- фикс.сумма комиссии

  --
  -- проверка данных перед визой заявки на покупку/продажу валюты
  --
  procedure p_zay_check_data
   (p_dk     in zayavka.dk%type,      -- покупка(1) / продажа(2)
    p_id     in zayavka.id%type,      -- ид заявки
    p_kv     in zayavka.kv2%type,     -- вал заявки
    p_sum    in zayavka.s2%type,      -- сума заявки
    p_rate   in zayavka.kurs_z%type,  -- курс заявки
    p_dat    in zayavka.fdat%type     -- дата заявки
   );

  --
  -- Процедура разбиения заявки на покупку/продажу валюты (Надра, для частичного удовлетворения заявки)
  --
  procedure p_zay_multiple
   (p_id   in zayavka.id%type,               -- ид заявки
    p_sum1 in number default null,   -- сумма зааявки-1
    p_sum2 in number default null);  -- сумма зааявки-2

  --
  -- создание заявки на покупку/продажу валюты
  --
  procedure add_request (p_request in out zayavka%rowtype,
                         p_flag_klb in number default 0);

  --
  -- Изменение заявки на покупку/продажу валюты
  --
  procedure upd_request
   (p_id            in  zayavka.id%type,                          -- идентификатор заявки
    p_s2s           in  zayavka.s2%type,                         -- сумма заявленной валюты (в коп.)
    p_nd            in  zayavka.nd%type            default null,  -- номер заявки
    p_fdat          in  zayavka.fdat%type          default null,  -- дата заявки
    p_kurs          in  zayavka.kurs_z%type        default null,  -- курс заявки
    p_kv_conv       in  zayavka.kv_conv%type       default null,  -- валюта покупки (конверсия, "за что покупаем")
    p_nls           in  zayavka.nls0%type,                        -- внутр.№ счета в ин.вал.
    p_nls_acc0      in  zayavka.nls0%type,                        -- внутр.№ счета в нац.вал.
    p_nls0          in  zayavka.nls0%type          default null,  -- счет в нац.валюте в др.банке     (для dk = 2)
    p_mfo0          in  zayavka.mfo0%type          default null,  -- МФО банка счета в нац.валюте     (для dk = 2)
    p_kom           in  zayavka.kom%type           default null,  -- процент (%) комиссии
    p_skom          in  zayavka.skom%type          default null,  -- фикс.сумма комиссии
    p_meta          in  zayavka.meta%type          default null,                        -- код цели покупки/продажи
    p_f092          in  zayavka.f092%type          default null,  -- код параметра F092
    p_contract      in  zayavka.contract%type      default null,  -- номер контракта/кред.договора
    p_dat2_vmd      in  zayavka.dat2_vmd%type      default null,  -- дата контракта/кред.договора
    p_num_vmd       in  zayavka.num_vmd%type       default null,  -- номер последней тамож.декларации
    p_dat_vmd       in  zayavka.dat_vmd%type       default null,  -- дата последней тамож.декларации
    p_dat5_vmd      in  zayavka.dat5_vmd%type      default null,  -- даты предыдущ.тамож.деклараций    (для dk = 1)
    p_basis         in  zayavka.basis%type         default null,  -- основание для покупки валюты      (для dk = 1)
    p_country       in  zayavka.country%type       default null,  -- код страны перечисления валюты    (для dk = 1)
    p_benefcountry  in  zayavka.benefcountry%type  default null,  -- код страны бенефициара            (для dk = 1)
    p_bank_code     in  zayavka.bank_code%type     default null,  -- код банка (B010)                  (для dk = 1)
    p_bank_name     in  zayavka.bank_name%type     default null,  -- название банка                    (для dk = 1)
    p_product_group in  zayavka.product_group%type default null,  -- код товарной группы               (для dk = 1)
    p_comm          in  zayavka.comm%type          default null,  -- подробности заявки
    p_contactfio    in  zayavka.contact_fio%type   default null,  -- ФИО контактного лица
    p_contacttel    in  zayavka.contact_tel%type   default null,  -- ТЕЛ контактного лица
    p_pf            in  zayavka.fl_pf%type         default null,  -- признак отчисления в ПФ          (для dk = 1)
    p_req_type      in  zayavka.req_type%type      default null,  -- Тип заявки
    p_vdateplan     in  zayavka.vdate_plan%type    default null,  -- Плановая дата валютирования
    p_obz           in  zayavka.obz%type           default null,  -- Признак заявки на обязательную продажу (1)
    p_rnk_pf        in  zayavka.rnk_pf%type        default null   -- для покупки - рег.№ клиента в пф для продажи: код для 27-го файла
    );

  --
  -- Создание/Изменение/Удаление параметров клиента
  --
  procedure upd_custzay
   (p_mode          in number,               -- режим (0-insert, 1-update, 2-delete)
    p_rnk           in cust_zay.rnk%type,    -- Рег.номер клиента
    p_nls29         in cust_zay.nls29%type   default null,   --Торговый счет для списания
    p_nls26         in cust_zay.nls26%type   default null,   -- Расчетный счет для зачисления
    p_mfo26         in cust_zay.mfo26%type   default null,   -- МФО расчетного счета
    p_okpo26        in cust_zay.okpo26%type  default null,   -- ОКПО клиента
    p_kom           in cust_zay.kom%type     default null,   -- % комиссии (покупка)
    p_kom2          in cust_zay.kom2%type    default null,   -- % комиссии (продажа)
    p_kom3          in cust_zay.kom3%type    default null,   -- % комиссии (конверсия)
    p_tel           in cust_zay.tel%type     default null,   -- Контактный телефон
    p_fio           in cust_zay.fio%type     default null,   -- ФИО контактного лица
    p_mfov          in cust_zay.mfov%type    default null,   -- МФО банка для возврата излишка грн
    p_nlsv          in cust_zay.nlsv%type    default null,   -- Счет клиента для возврата излишка грн
    p_nls_kom       in cust_zay.nls_kom%type default null,   -- Счет комиссии банка (покупка)
    p_nls_kom2      in cust_zay.nls_kom2%type    default null,  -- Счет комиссии банка (продажа)
    p_custacc4cms   in cust_zay.custacc4cms%type default null,  -- Альтернат.счет клиента для списания комиссии
    p_nls_pf        in cust_zay.nls_pf%type      default null   -- Счет для списания ПФ
    );



  --
  procedure set_conv_kurs (
    p_kv1       diler_kurs_conv.kv1%type,
    p_kv2       diler_kurs_conv.kv2%type,
    p_dat       diler_kurs_conv.dat%type,
    p_kurs      diler_kurs_conv.kurs_i%type,
    p_kurstype  number );

  procedure set_support_document (
    p_id                in zayavka.id%type,
    p_support_document  in zayavka.support_document%type);

  function get_support_document (
    p_refd oper.ref%type,
    p_tt oper.tt%type) return number;

  --
  -- Визирование заявки - проставление параметров
  --
  procedure set_visa_parameters (
    p_id        in zayavka.id%type,
    p_verify_opt  in zayavka.verify_opt%type,
    p_meta      in zayavka.meta%type        default null,
    p_f092      in zayavka.f092%type        default null,
    p_contract  in zayavka.contract%type    default null,
    p_dat2_vmd  in zayavka.dat2_vmd%type    default null,
    p_dat_vmd   in zayavka.dat_vmd%type     default null,
    p_dat5_vmd  in zayavka.dat5_vmd%type    default null,
    p_country   in zayavka.country%type     default null,
    p_basis     in zayavka.basis%type       default null,
    p_benefcountry  in zayavka.benefcountry%type  default null,
    p_bank_name  in zayavka.bank_name%type  default null,
    p_bank_code  in zayavka.bank_code%type  default null,
    p_product_group  in zayavka.product_group%type  default null,
    p_num_vmd  in zayavka.num_vmd%type      default null,
    p_code_2c  in zayavka.code_2c%type      default null,
    p_p12_2c   in zayavka.p12_2c%type       default null);


  --
  -- Визирование заявки
  --
  procedure set_visa (
    p_id        in zayavka.id%type,
    p_viza      in zayavka.viza%type,
    p_priority  in zayavka.priority%type  default null,
    p_aims_code in zayavka.aims_code%type default null,
    p_f092      in zayavka.f092%type default null,
    p_sup_doc   in zayavka.support_document%type default null);

  --
  -- Удовлетворение заявки
  --
  procedure set_sos (
    p_id         in zayavka.id%type,
    p_kurs_f     in zayavka.kurs_f%type,
    p_sos        in zayavka.sos%type,
    p_vdate      in zayavka.vdate%type,
    p_close_type in zayavka.close_type%type,
    p_fdat       in zayavka.fdat%type );

  --
  --  Визирование курса дилера
  --
  procedure visa_kurs (
    p_id   in zayavka.id%type,
    p_datz in zayavka.datz%type );

  --
  -- Удаление заявки
  --
  procedure del_request (p_id in zayavka.id%type, p_flag in number);

  --
  -- Возврат заявки
  --
  procedure back_request (
    p_mode   in number,
    p_id     in zayavka.id%type,
    p_idback in zayavka.idback%type,
    p_comm   in zayavka.reason_comm%type );

  procedure set_diler_kurs (
    p_dat    in diler_kurs.dat%type,
    p_kv     in diler_kurs.kv%type,
    p_id     in diler_kurs.id%type,
    p_kurs_b in diler_kurs.kurs_b%type,
    p_kurs_s in diler_kurs.kurs_s%type,
    p_vip_b  in diler_kurs.vip_b%type,
    p_vip_s  in diler_kurs.vip_s%type,
    p_blk    in diler_kurs.blk%type );

  --
  -- Установка курсов конверсии
  --
  procedure set_diler_kurs_conv (
     p_dat    in diler_kurs_conv.dat%type,
     p_kv1    in diler_kurs_conv.kv1%type,
     p_kv2    in diler_kurs_conv.kv2%type,
     p_kurs_i in diler_kurs_conv.kurs_i%type,
     p_kurs_f in diler_kurs_conv.kurs_f%type );

  procedure set_diler_kurs_fact (
    p_dat    in diler_kurs_fact.dat%type,
    p_kv     in diler_kurs_fact.kv%type,
    p_id     in diler_kurs_fact.id%type,
    p_kurs_b in diler_kurs_fact.kurs_b%type,
    p_kurs_s in diler_kurs_fact.kurs_s%type );

  -------------------------------------------------------------------------------
  --
  -- Разбираем пришедшие xml из ЦА и устанавливаем курсы
  --
  procedure iparse_dilerkurs (p_kurs_clob clob,
    p_conv_clob clob,
    p_date varchar2);

  -------------------------------------------------------------------------------
  -- Передать курсы в конкретное РУ
  --
  procedure p_kurs_data_transfer (
    p_par number,
    p_url zay_recipients.url%type,
    p_dat date );

  -------------------------------------------------------------------------------
  -- Передать курсы в все РУ
  --
  procedure p_kurs_transfer (p_par number, p_dat date);

  -------------------------------------------------------------------------------
  --
  -- процедура создания/обновления заявки, введенной в РУ, в БД ЦА
  --
  procedure set_request_in_ca (
    -- p_flag - 1-ins, 2-upd
    p_flag                 number,
    p_mfo                  zayavka_ru.mfo%type,
    p_id                   zayavka_ru.req_id%type,
    p_dk                   zayavka_ru.dk%type,
    p_obz                  zayavka_ru.obz%type,
    p_nd                   zayavka_ru.nd%type,
    p_fdat                 zayavka_ru.fdat%type,
    p_datt                 zayavka_ru.datt%type,
    p_rnk                  zayavka_ru.rnk%type,
    p_nmk                  zayavka_ru.nmk%type,
    p_nd_rnk               zayavka_ru.nd_rnk%type,
    p_kv_conv              zayavka_ru.kv_conv%type,
    p_lcv_conv             zayavka_ru.lcv_conv%type,
    p_kv2                  zayavka_ru.kv2%type,
    p_lcv                  zayavka_ru.lcv%type,
    p_dig                  zayavka_ru.dig%type,
    p_s2                   zayavka_ru.s2%type,
    p_s2s                  zayavka_ru.s2s%type,
    p_s3                   zayavka_ru.s3%type,
    p_kom                  zayavka_ru.kom%type,
    p_skom                 zayavka_ru.skom%type,
    p_kurs_z               zayavka_ru.kurs_z%type,
    p_kurs_f               zayavka_ru.kurs_f%type,
    p_vdate                zayavka_ru.vdate%type,
    p_datz                 zayavka_ru.datz%type,
    p_acc0                 zayavka_ru.acc0%type,
    p_nls_acc0             zayavka_ru.nls_acc0%type,
    p_mfo0                 zayavka_ru.mfo0%type,
    p_nls0                 zayavka_ru.nls0%type,
    p_okpo0                zayavka_ru.okpo0%type,
    p_ostc0                zayavka_ru.ostc0%type,
    p_acc1                 zayavka_ru.acc1%type,
    p_ostc                 zayavka_ru.ostc%type,
    p_nls                  zayavka_ru.nls%type,
    p_sos                  zayavka_ru.sos%type,
    p_ref                  zayavka_ru.ref%type,
    p_viza                 zayavka_ru.viza%type,
    p_priority             zayavka_ru.priority%type,
    p_priorname            zayavka_ru.priorname%type,
    p_priorverify          zayavka_ru.priorverify%type,
    p_idback               zayavka_ru.idback%type,
    p_fl_pf                zayavka_ru.fl_pf%type,
    p_mfop                 zayavka_ru.mfop%type,
    p_nlsp                 zayavka_ru.nlsp%type,
    p_okpop                zayavka_ru.okpop%type,
    p_rnk_pf               zayavka_ru.rnk_pf%type,
    p_pid                  zayavka_ru.pid%type,
    p_contract             zayavka_ru.contract%type,
    p_dat2_vmd             zayavka_ru.dat2_vmd%type,
    p_meta                 zayavka_ru.meta%type,
    p_aim_name             zayavka_ru.aim_name%type,
    p_basis                zayavka_ru.basis%type,
    p_product_group        zayavka_ru.product_group%type,
    p_product_group_name   zayavka_ru.product_group_name%type,
    p_num_vmd              zayavka_ru.num_vmd%type,
    p_dat_vmd              zayavka_ru.dat_vmd%type,
    p_dat5_vmd             zayavka_ru.dat5_vmd%type,
    p_country              zayavka_ru.country%type,
    p_benefcountry         zayavka_ru.benefcountry%type,
    p_bank_code            zayavka_ru.bank_code%type,
    p_bank_name            zayavka_ru.bank_name%type,
    p_userid               zayavka_ru.userid%type,
    p_branch               zayavka_ru.branch%type,
    p_fl_kursz             zayavka_ru.fl_kursz%type,
    p_identkb              zayavka_ru.identkb%type,
    p_comm                 zayavka_ru.comm%type,
    p_cust_branch          zayavka_ru.cust_branch%type,
    p_kurs_kl              zayavka_ru.kurs_kl%type,
    p_contact_fio          zayavka_ru.contact_fio%type,
    p_contact_tel          zayavka_ru.contact_tel%type,
    p_verify_opt           zayavka_ru.verify_opt%type,
    p_close_type           zayavka_ru.close_type%type,
    p_close_type_name      zayavka_ru.close_type_name%type,
    p_aims_code            zayavka_ru.aims_code%type,
    p_s_pf                 zayavka_ru.s_pf%type,
    p_ref_pf               zayavka_ru.ref_pf%type,
    p_ref_sps              zayavka_ru.ref_sps%type,
    p_start_time           zayavka_ru.start_time%type,
    p_state                zayavka_ru.state%type,
    p_operid_nokk          zayavka_ru.operid_nokk%type,
    p_req_type             zayavka_ru.req_type%type,
    p_vdateplan            zayavka_ru.vdate_plan%type,
    p_custtype             zayavka_ru.custtype%type );

  procedure set_zaytrack_in_ca (
    p_mfo         zay_track_ru.mfo%type,
    p_track_id    zay_track_ru.track_id%type,
    p_req_id      zay_track_ru.req_id%type,
    p_change_time zay_track_ru.change_time%type,
    p_fio         zay_track_ru.fio%type,
    p_sos         zay_track_ru.sos%type,
    p_viza        zay_track_ru.viza%type,
    p_viza_name   zay_track_ru.viza_name%type);

  procedure set_visa_in_ca (
    p_mfo  zayavka_ru.mfo%type,
    p_id   zayavka_ru.req_id%type,
    p_viza zayavka_ru.viza%type );

  procedure set_refsps_in_ca (
    p_mfo       zayavka_ru.mfo%type,
    p_id        zayavka_ru.req_id%type,
    p_ref_sps   zayavka_ru.ref_sps%type );

  procedure set_visa_in_ru(
    p_id          zayavka.id%type,
    p_kurs_f      zayavka.kurs_f%type,
    p_sos         zayavka.sos%type,
    p_vdate       zayavka.vdate%type,
    p_close_type  zayavka.close_type%type,
    p_datz        zayavka.datz%type,
    p_viza        zayavka.viza%type,
    p_id_back     zayavka.idback%type,
    p_reason_comm zayavka.reason_comm%type);
  -------------------------------------------------------------------------------
  --
  -- создание прохождения заявки на покупку/продажу валюты через вебсервис на стороне ЦА
  --
  procedure service_track_request(p_reqest_id in zayavka.id%type);

  -------------------------------------------------------------------------------
  --
  -- Передать реф документа списания средств в ЦА
  --
  procedure p_reqest_set_refsps(p_id number,
                                p_ref_sps number);

  -------------------------------------------------------------------------------
  --
  -- создание заявки на покупку/продажу валюты через вебсервис на стороне ЦА
  --
  procedure service_request(p_reqest_id in zayavka.id%type,
                            p_flag_klb  in number default 0);

  -------------------------------------------------------------------------------
  --
  -- Передать изменения состояния заявки в РУ
  --
  procedure p_viza_reqesr_transfer(p_id number);

  -------------------------------------------------------------------------------
  --
  -- Передача валюты из РУ в ЦА
  --
  procedure set_currency_income(p_dat date);

  -------------------------------------------------------------------------------
  --
  -- Разбираем пришедшие xml из РУ и записываем в таблицу zay_currency_income_ru
  --
  procedure iparse_currency_income(p_mfo varchar2,
                                   p_date varchar2,
                                   p_currency_clob clob
                                   );

  -------------------------------------------------------------------------------
  --
  -- Процедура установки параметров клиентов для биржевых заявок
  --
  procedure set_custzay (
     p_rnk     cust_zay.rnk%type,
     p_dk      number,
     p_nls26   cust_zay.nls26%type,
     p_mfo26   cust_zay.mfo26%type,
     p_okpo26  cust_zay.okpo26%type,
     p_nls29   cust_zay.nls29%type,
     p_fl_pf   cust_zay.fl_pf%type,
     p_rnk_pf  cust_zay.rnk_pf%type,
     p_nlsp    cust_zay.nlsp%type,
     p_nlsv    cust_zay.nlsv%type,
     p_mfov    cust_zay.mfov%type,
     p_kom     cust_zay.kom%type );

  --
  -- "Розщеплення надходжень" - вставка/оновлення
  --
  procedure SET_AMOUNT
  ( p_id           in     zay_splitting_amount.id%type
  , p_ref          in     zay_splitting_amount.ref%type
  , p_sale_tp      in     zay_splitting_amount.sale_tp%type
  , p_amnt         in     zay_splitting_amount.amnt%type
  );

  --
  -- "Розщеплення надходжень" - видалення
  --
  procedure DEL_AMOUNT
  ( p_id           in     zay_splitting_amount.id%type
  );

  procedure upd_zay_params(p_ref oper.ref%type ,p_tag operw.tag%type,p_value operw.value%type);

  --очищення ZAY42 від застарілих заявок
  procedure del_zay_old ;
end BARS_ZAY;
/


CREATE OR REPLACE PACKAGE BODY BARS.BARS_ZAY
is

body_ver   constant varchar2(64)   := 'version 12.02 20.02.2018';
body_awk   constant varchar2(512)  := ''
    ||'СБЕРБАНК (назначение платежа)' ||chr(10)
    ||'Комиссия по курсу НБУ' ||chr(10)
    ||'Зачисление вырученной от продажи гривны на Р/С/кл за вычетом комиссии, списание комиссии с 2900/банка через 3570' ||chr(10)
;

-- Надра  aw bars_zay_pack.sql bars_zay_pack.ndr SEGM+CNBU+VGRN2+CMS3578+NOKK+CCOM
-- Сбер   aw bars_zay_pack.sql bars_zay_pack.sb SBER+CNBU+CMS3570
--  (было aw bars_zay_pack.sql bars_zay_pack.sb SBER+CNBU+VGRN1)
-- УПБ    aw bars_zay_pack.sql bars_zay_pack.upb


buy_type      constant number(1)   := 1;
sel_type      constant number(1)   := 2;
convbuy_type  constant number(1)   := 3;
convsel_type  constant number(1)   := 4;
modcode       constant varchar2(3) := 'ZAY';
trd_tt        constant tts.tt%type := 'GO1';
--frx_tt          constant tts.tt%type := 'GO2';
cms_tt        constant tts.tt%type := 'GO3';
mgn_tt        constant tts.tt%type := 'GO4';
out_tt        constant tts.tt%type := 'GO5';
obz_tt        constant tts.tt%type := 'GO8';
vnt_tt        constant tts.tt%type := 'GO9';
vnv_tt        constant tts.tt%type := 'GOC';
taxbank_tt    constant tts.tt%type := 'GOP';
taxcust_tt    constant tts.tt%type := 'GOF';
--d#39_buy   constant char(3)        := '112';
--d#39_sel   constant char(3)        := '122';

frx_tt            tts.tt%type;
gZAYMODE          number(1);
gZAYDAY           number;
gWEBSRV           birja.val%type;
gWallet_dir       varchar2(64);
gWallet_pass      varchar2(64);
gTransfer_eroor   number(1) default 0;
gTransfer_success number(1) default 1;

mmfo              boolean;


--
-- определение версии заголовка пакета
--
function header_version return varchar2 is
begin
  return 'Package header: '||head_ver||chr(10)||
         'AWK definition: '||head_awk;
end header_version;

--
-- определение версии тела пакета
--
function body_version return varchar2 is
begin
  return 'Package body  : '||body_ver||chr(10)||
         'AWK definition: '||body_awk;
end body_version;

-------------------------------------------------------------------------------
procedure init
is
  l_qty   pls_integer;
begin

  begin

    select count(1)
      into l_qty
      from BARS.MV_KF;

    mmfo := case when ( l_qty > 1 ) then true else false end;

  exception
    when OTHERS then
      mmfo := false;
  end;

  select nvl(max(val),0) into gZAYMODE     from birja where par = 'ZAY_MODE';
  select nvl(max(val),0) into gZAYDAY      from birja where par = 'ZAY_DAY';
  select max(val)        into gWEBSRV      from birja where par = 'WEB_SRV';
  select max(VAl)        into gWallet_dir  from birja where PAR = 'Wlt_dir';
  select max(VAl)        into gWallet_pass from birja where PAR = 'Wlt_pass';

  if ( mmfo )
  then
    frx_tt := case gZAYMODE       -- Режим работы модуля:
                when 1 then 'GO2' -- 1-на стороне ЦА
                when 2 then 'GOD' -- 2-на стороне РУ
                else 'GO2'        -- 0-обычный
              end;
  else
    frx_tt := 'GO2';
  end if;

  -- gWallet_dir := 'file:/oracle/ssl';
  -- gWallet_pass := 'qwerty123';
end init;

-------------------------------------------------------------------------------
-- кодируем строку
--
function encode_base64(par varchar2)
  return varchar2
is
begin
  return utl_encode.text_encode(par, encoding => utl_encode.base64);
end;

-------------------------------------------------------------------------------
--
-- раскодируем строку
--
function decode_base_to_row(par varchar2)
  return varchar2
is
begin
  return utl_encode.text_decode(par, encoding => utl_encode.base64);
end;

-------------------------------------------------------------------------------
-- EXTRACT()
--
--   безопаcно получает значение по XPath
--
--
function extract (p_xml in xmltype, p_xpath in varchar2, p_default in varchar2) return varchar2 is
begin
  return p_xml.extract(p_xpath).getStringVal();
exception when others then
  if sqlcode = -30625 then
    return p_default;
  else
    raise;
  end if;
end extract;

-------------------------------------------------------------------------------
-- CONVERT_TO_NUMBER()
--
--   Конвертит строку в число  соответсвующим exept
--
--
function convert_to_number (p_str varchar2) return number
is
begin
  return to_number(replace(replace(p_str, ',', substr(to_char(11/10),2,1)), '.', substr(to_char(11/10),2,1)));
exception when others then
  raise_application_error(-20000, sqlerrm, true);
end convert_to_number;

-------------------------------------------------------------------------------
--
-- внутр.функция определения реквизитов счета по acc или по nls+kv
--
function i_getaccparam
 (p_accid  in accounts.acc%type,                 -- внутр.номер счета
  p_accnum in accounts.nls%type default null,    -- лицевой № счета
  p_curid  in accounts.kv%type  default null)    -- код валюты
  return t_accrec
is
  title    varchar2(60) := 'zay.igetaccpar:';
  l_accrec t_accrec;
begin

  bars_audit.trace('%s entry, accid=>%s, accnum=>%s, curid=>%s', title,
                   to_char(p_accid), p_accnum, to_char(p_curid));

  if p_accid is not null then

     select a.acc, a.nls, substr(a.nms, 1, 38), a.kv, c.okpo
       into l_accrec
       from accounts a, customer c
      where a.rnk  = c.rnk
        and a.acc  = p_accid
        and a.dazs is null;

  else

     select a.acc, a.nls, substr(a.nms, 1, 38), a.kv, c.okpo
       into l_accrec
       from accounts a, customer c
      where a.rnk  = c.rnk
        and a.nls  = p_accnum
        and a.kv   = p_curid
        and a.dazs is null;

  end if;

  bars_audit.trace('%s exit, %s/%s (%s)', title,
                   l_accrec.accnum, to_char(l_accrec.curid), to_char(l_accrec.accid));

  return l_accrec;

end i_getaccparam;

-------------------------------------------------------------------------------
--
-- внутр.функция определения реквизитов счета из карточки операции
--
procedure i_gettsacc
 (p_tt     in  tts.tt%type,        -- код операции
  p_curid  in  accounts.kv%type,   -- код валюты
  p_accrec out t_accrec)           -- реквизиты счета
is
  title    varchar2(60) := 'zay.igettsacc:';
  l_accmask tts.nlsk%type;
begin

  bars_audit.trace('%s entry, tt=>%s, curid=>%s', title, p_tt, to_char(p_curid));

  --select decode(tt,'GO3',nlsb,nlsk) into l_accmask from tts where tt = p_tt;
  select nlsk into l_accmask from tts where tt = p_tt;

  if p_tt = 'GO3' and  l_accmask like '#(%' then          --Надра, определение счета 6114 по сегменту клиента (ф-ла счета)
          select null, null, null, null, null             -- процесс подстановки доверяем PAYTT
            into p_accrec
            from dual;
  elsif l_accmask like '#(%' then
    execute immediate 'select '||substr(l_accmask,3, length(l_accmask)-3)||' from dual ' into l_accmask;
    p_accrec := i_getaccparam (p_accid  => null,
                               p_accnum => l_accmask,
                               p_curid  => p_curid);
  else
    p_accrec := i_getaccparam (p_accid  => null,
                               p_accnum => l_accmask,
                               p_curid  => p_curid);
  end if;

  bars_audit.trace('%s exit, %s/%s (%s)', title,
                   p_accrec.accnum, to_char(p_accrec.curid), to_char(p_accrec.accid));

exception
  when no_data_found then
    -- не найден внутрибанковский счет из карточки операции %s в валюте %s
    bars_error.raise_nerror (modcode, 'TTSACC_NOT_FOUND', p_tt, p_curid);
end i_gettsacc;

-------------------------------------------------------------------------------
--
-- определение торговых внутрибанковских счетов
--
procedure get_bankaccounts
 (p_currency  in  tabval.kv%type, -- валюта
  p_konvcurr  in  tabval.kv%type, -- валюта конверсии
  p_taxflag   in  number,         -- признак отчисления в Пенс.Фонд
  p_trdaccFC  out t_accrec,       -- торговый счет ГОУ в ин.валюте
  p_trdaccNC  out t_accrec,       -- торговый счет ГОУ в нац.валюте
  p_cmsacc    out t_accrec,       -- счет комиссионных доходов
  p_taxacc    out t_accrec)       -- транз.счет для перечисления в Пенс.Фонд
is
  title     varchar2(60)   := 'zay.getbnkacc:';
  l_baseval tabval.kv%type := gl.baseval;
begin

  bars_audit.trace('%s entry, currency=>%s, p_taxflag=>%s', title,
                   to_char(p_currency), to_char(p_taxflag));

  i_gettsacc (p_tt => trd_tt,     p_curid  => p_currency, p_accrec => p_trdaccFC);
  i_gettsacc (p_tt => trd_tt,     p_curid  => (case
                                               when p_konvcurr is null then l_baseval
                                               else p_konvcurr
                                               end),
                                                          p_accrec => p_trdaccNC);
  i_gettsacc (p_tt => cms_tt,     p_curid  => l_baseval,  p_accrec => p_cmsacc);
  if p_taxflag = 1 then
     i_gettsacc (p_tt => taxbank_tt, p_curid  => l_baseval,  p_accrec => p_taxacc);
  end if;
  bars_audit.trace('%s exit with %s, %s, %s, %s', title,
                   p_trdaccFC.accnum ||'/' || to_char(p_trdaccFC.curid),
                   p_trdaccNC.accnum ||'/' || to_char(p_trdaccNC.curid),
                   p_cmsacc.accnum   ||'/' || to_char(p_cmsacc.curid),
                   p_taxacc.accnum   ||'/' || to_char(p_taxacc.curid));

end get_bankaccounts;

-------------------------------------------------------------------------------
--
-- внутр.процедура оплаты документа (плоская одновалютная бухмодель)
--
procedure i_paydoc
 (p_flg     in  number,           -- флаг оплаты
  p_sideA   in  t_accrec,         -- реквизиты стороны-А
  p_sideB   in  t_accrec,         -- реквизиты стороны-В
  p_mfoB    in  oper.mfob%type,   -- МФО банка-получателя
  p_vdat    in  oper.vdat%type,   -- дата валютировнаия
  p_tt      in  oper.tt%type,     -- код операции
  p_dk      in  oper.dk%type,     -- дебет/кредит
  p_vob     in  oper.vob%type,    -- вид документа
  p_nd      in  oper.nd%type,     -- номер документа
  p_amount  in  oper.s%type,      -- сумма документа
  p_details in  oper.nazn%type,   -- назначение платежа
  p_ref     out oper.ref%type,    -- референс документа
  p_pr      in  number  default null)   -- признак оплаты через paytt (default) / gl.payv (1)
is
  title     varchar2(60)    := 'zay.ipaydoc:';
  l_mfo    oper.mfoa%type   := gl.amfo;
  l_userid oper.userid%type := gl.auid;
  l_ref    oper.ref%type;
begin

  bars_audit.trace('%s entry, flg=>%s, tt=>%s, amount=>%s, nlsa=>%s, nlsb=>%s', title,
                   to_char(p_flg), p_tt, to_char(p_amount),
                   p_sideA.accnum || '/' || to_char(p_sideA.curid),
                   p_sideB.accnum || '/' || to_char(p_sideB.curid));

  gl.ref (l_ref);

  gl.in_doc3 (ref_   => l_ref,
              tt_    => p_tt,
              dk_    => p_dk,
              vob_   => p_vob,
              nd_    => p_nd,
              pdat_  => sysdate,
              data_  => p_vdat,
              vdat_  => p_vdat,
              datp_  => p_vdat,
              mfoa_  => l_mfo,
              nlsa_  => p_sideA.accnum,
              nam_a_ => p_sideA.accname,
              id_a_  => p_sideA.custcode,
              kv_    => p_sideA.curid,
              s_     => p_amount,
              mfob_  => p_mfoB,
              nlsb_  => p_sideB.accnum,
              nam_b_ => p_sideB.accname,
              id_b_  => p_sideB.custcode,
              kv2_   => p_sideB.curid,
              s2_    => p_amount,
              nazn_  => p_details,
              uid_   => l_userid,
              d_rec_ => null,
              sk_    => null,
              id_o_  => null,
              sign_  => null,
              sos_   => 0,
              prty_  => null);

  if p_pr = 1 then
    gl.payv(p_flg, l_ref, p_vdat, p_tt, p_dk,
            p_sideA.curid, p_sideA.accnum, p_amount,
            p_sideB.curid, p_sideB.accnum, p_amount);
  else
    paytt (p_flg, l_ref, p_vdat, p_tt, p_dk,
           p_sideA.curid, p_sideA.accnum, p_amount,
           p_sideB.curid, p_sideB.accnum, p_amount);
  end if;

  p_ref := l_ref;

  bars_audit.trace('%s exit with ref %s', title, to_char(p_ref));

exception
  when others then
    -- ошибка оплаты документа (дебет %s кредит %s на сумму %s/%s, код операции %s): %s
    bars_error.raise_nerror (modcode, 'PAYDOC_FAILED',
                             p_sideA.accnum, p_sideB.accnum,
                             to_char(p_amount), to_char(p_sideA.curid), p_tt, sqlerrm);
end i_paydoc;

-------------------------------------------------------------------------------
--
-- заполнение доп.реквизита документа
--
procedure i_insdocparam
 (p_docref  in  operw.ref%type,    -- референс документа
  p_doctag  in  operw.tag%type,    -- код доп.реквизита
  p_docval  in  operw.value%type)  -- значение доп.реквизита
is
  title varchar2(60) := 'zay.iinsdocparam:';
begin

  bars_audit.trace('%s entry, ref=>%s, tag=>%s, val=>%s', title,
                   to_char(p_docref), p_doctag, p_docval);

  if p_docval is not null then
     insert into operw (ref, tag, value)
     values (p_docref, substr(p_doctag, 1, 5), substr(p_docval, 1, 254));
  end if;

  bars_audit.trace('%s exit', title);

exception
  when others then
    -- ошибка записи доп.реквизита %s для документа %s: %s
    bars_error.raise_nerror (modcode, 'INS_DOCPARAM_FAILED', p_doctag, p_docref, sqlerrm);
end i_insdocparam;

-------------------------------------------------------------------------------
--
-- заполнение доп.реквизитов документа для 39-го и 70-го файлов
--
procedure i_setdocparams
  (p_ref      in  oper.ref%type,        -- референс документа
   p_zayrow   in  zayavka%rowtype,      -- параметры заявки
   p_nominal  in  tabval.nominal%type,  -- разрядность валюты
   p_d#39     in  varchar2)             -- показатель для 39-го файла НБУ
is
  title  varchar2(60) := 'zay.isetdocparams:';
  l_rate operw.value%type;
  l_date operw.value%type;
begin

  bars_audit.trace('%s entry, ref=>%s, zayid=>%s', title, to_char(p_ref), to_char(p_zayrow.id));

  l_rate := trim(to_char(round(p_zayrow.kurs_f * p_nominal, 4), '9999999990.99999'));
  l_date := to_char(p_zayrow.datedokkb, 'DD.MM.YYYY HH24:MI:SS');

  if p_zayrow.dk = 1 then
     i_insdocparam (p_ref, 'D1#70', substr(to_char(p_zayrow.meta),                   1, 254));
     i_insdocparam (p_ref, 'D1#3K', substr(to_char(p_zayrow.f092),                   1, 220));
     i_insdocparam (p_ref, 'D2#70', substr(p_zayrow.contract,                        1, 254));
     i_insdocparam (p_ref, 'D3#70', substr(to_char(p_zayrow.dat2_vmd, 'DD.MM.YYYY'), 1, 254));
     i_insdocparam (p_ref, 'D4#70', substr(to_char(p_zayrow.dat_vmd,  'DD.MM.YYYY'), 1, 254));
     i_insdocparam (p_ref, 'D5#70', substr(p_zayrow.dat5_vmd,                        1, 254));
     i_insdocparam (p_ref, 'D6#70', substr(to_char(p_zayrow.country),                1, 254));
     i_insdocparam (p_ref, 'D7#70', substr(p_zayrow.basis,                           1, 254));
     i_insdocparam (p_ref, 'D8#70', substr(to_char(p_zayrow.benefcountry),           1, 254));
     i_insdocparam (p_ref, 'D9#70', substr(p_zayrow.bank_code,                       1, 254));
     i_insdocparam (p_ref, 'DA#70', substr(p_zayrow.bank_name,                       1, 254));
     i_insdocparam (p_ref, 'DB#70', substr(p_zayrow.product_group,                   1, 254));
     i_insdocparam (p_ref, 'DC#70', substr(p_zayrow.num_vmd,                         1, 254));
     i_insdocparam (p_ref, 'KURS ', substr(l_rate,                                   1, 254));
     -- i_insdocparam (p_ref, 'D#39 ', substr(d#39_buy,                                 1, 254));
     i_insdocparam (p_ref, 'D#39 ', substr(p_d#39,                                   1, 254));
     i_insdocparam (p_ref, 'FN_KB', substr(p_zayrow.fnamekb,                         1, 254));
     i_insdocparam (p_ref, 'ID_KB', substr(p_zayrow.identkb,                         1, 254));
     i_insdocparam (p_ref, 'TIPKB', substr(to_char(p_zayrow.tipkb),                  1, 254));
     i_insdocparam (p_ref, 'DATKB', substr(l_date,                                   1, 254));
     if p_zayrow.kv2 in (959,961,962,964) then
        i_insdocparam (p_ref, 'D#44', 92);
     end if;
  else
     i_insdocparam (p_ref, 'D1#70', substr(to_char(p_zayrow.meta),                   1, 254));
     i_insdocparam (p_ref, 'D1#3K', substr(to_char(p_zayrow.f092),                   1, 220));
     i_insdocparam (p_ref, 'D2#70', substr(p_zayrow.contract,                        1, 254));
     i_insdocparam (p_ref, 'D3#70', substr(to_char(p_zayrow.dat2_vmd, 'DD.MM.YYYY'), 1, 254));
     i_insdocparam (p_ref, 'D4#70', substr(to_char(p_zayrow.dat_vmd,  'DD.MM.YYYY'), 1, 254));
     i_insdocparam (p_ref, 'DC#70', substr(p_zayrow.num_vmd,                         1, 254));
     i_insdocparam (p_ref, 'KURS ', substr(l_rate,                                   1, 254));
     -- i_insdocparam (p_ref, 'D#39 ', substr(d#39_sel,                                 1, 254));
     i_insdocparam (p_ref, 'D#39 ', substr(p_d#39,                                   1, 254));
     i_insdocparam (p_ref, 'D#27 ', substr(p_zayrow.rnk_pf,                          1, 254));
     i_insdocparam (p_ref, 'FN_KB', substr(p_zayrow.fnamekb,                         1, 254));
     i_insdocparam (p_ref, 'ID_KB', substr(p_zayrow.identkb,                         1, 254));
     i_insdocparam (p_ref, 'TIPKB', substr(to_char(p_zayrow.tipkb),                  1, 254));
     i_insdocparam (p_ref, 'DATKB', substr(l_date,                                   1, 254));
     if p_zayrow.kv2 in (959,961,962,964) then
        i_insdocparam (p_ref, 'D#44', 95);
     end if;
  end if;

  if p_zayrow.obz = 1 then
     i_insdocparam (p_ref, 'DD#70', substr('Обов"язковий продаж валюти',             1, 254));
  end if;

  bars_audit.trace('%s exit', title);

end i_setdocparams;

-------------------------------------------------------------------------------
--
-- формирование пакета документов по заявке на покупку валюты
--
procedure pay_buying
 (p_zayid   in  zayavka.id%type,         -- идентификатор заявки
  p_taxrate in  number,                  -- процент отчисления в Пенс.фонд
  p_taxcust in  number,                  -- признак отчисления в Пенс.фонд на счет клиента
  p_indx39  in  varchar2,                -- показатель для 39-го файла
  p_vobFС   in  vob.vob%type default 46, -- вид мемориального ордера в ин.валюте
  p_vobNС   in  vob.vob%type default 6,  -- вид мемориального ордера в нац.валюте
  p_buyref  out oper.ref%type,           -- референс зачисления валюты
  p_taxref  out oper.ref%type)           -- референс отчисления в Пенс.Фонд
is
  title           varchar2(60)   := 'zay.paybuy:';
  l_baseval       tabval.kv%type := gl.baseval;
  l_bdate         date           := gl.bdate;
  l_mfo           banks.mfo%type := gl.amfo;
  l_zay           zayavka%rowtype;
  l_cur           tabval%rowtype;
  l_custname      customer.nmkk%type;
  l_okpo          customer.okpo%type;
  l_value         varchar2(10);
  -- внутрибанк.счета
  l_bank_trdaccFC t_accrec;
  l_bank_trdaccNC t_accrec;
  l_bank_cmsacc   t_accrec;
  l_bank_taxacc   t_accrec;
  -- клиентск.счета
  l_cust_trdacc   t_accrec;
  l_cust_curacc   t_accrec;
  l_cust_taxacc   t_accrec;
  l_cust_cmsacc   t_accrec;
  l_cust_pfacc    t_accrec;
  -- суммы и назначение платежей
  l_nom_amount    number(38);
  l_eqv_amount    number(38);
  l_cms_amount    number(38);
  l_cms_detail    oper.nazn%type;
  l_tax_amount    number(38);
  l_tax_detail    oper.nazn%type;
  l_tax_detail_add  oper.nazn%type;
  l_tax_detail2   oper.nazn%type;
  l_deal_details  oper.nazn%type;
  l_doc_details   oper.nazn%type;
  l_payflg        number(1);
  l_tax_ref       oper.ref%type;
  l_doc_ref       oper.ref%type;
  l_nlskom        cust_zay.nls_kom%type;
  l_kv_base       tabval.kv%type;
  l_cust          customer%rowtype;
  l_custzay       cust_zay%rowtype;
  l_cust_pr       number(1) := 0;
  l_cnt_3570      number;
  l_val_3570      accounts.nls%type;
  l_cust_3570acc  t_accrec;
  l_pr_2620       number;
  l_par           number(1) := 0;
  cursor c_customer (p_rnk customer.rnk%type) is
    select c.*
      from customer c
     where c.rnk=p_rnk;
begin

  bars_audit.trace('%s entry, zayid=>%s, taxrate=>%s, p_taxcust=>%s, vob=>%s/%s',
                   title,              to_char(p_zayid),
                   to_char(p_taxrate), to_char(p_taxcust),
                   to_char(p_vobFС),   to_char(p_vobNС));

  bars_msg.set_lang ('UKR');

  -- параметры заявки
  begin
    select * into l_zay from zayavka where id = p_zayid for update of sos nowait;
  exception
    when no_data_found then
      -- не найдена заявка № %s
      bars_error.raise_nerror (modcode, 'ZAY_NOT_FOUND', to_char(p_zayid));
  end;
   open  c_customer (l_zay.rnk);
   fetch c_customer into l_cust;
   close c_customer;

  select decode(f_get_params('MFOP'),'300465',1,0)  into l_par from dual;

  -- проверка "готовности" заявки
  if l_zay.sos != 1 then
     -- запрещено формирование пакета документов по заявке № %s(статус заявки %s)
     bars_error.raise_nerror (modcode, 'INVALID_STATUS', to_char(p_zayid), to_char(l_zay.sos));
  end if;
  if l_zay.vdate > l_bdate then
     -- запрещено формирование пакета документов по форвардной заявке № %s(дата валютир.и %s)
     bars_error.raise_nerror (modcode, 'INVALID_VALUEDATE', to_char(p_zayid), to_char(l_zay.vdate, 'dd.mm.yyyy'));
  end if;

  -- параметры валюты
  begin
    select * into l_cur from tabval where kv = l_zay.kv2;
  exception
    when no_data_found then
      -- не найдена валюта с кодом %s
      bars_error.raise_nerror (modcode, 'CUR_NOT_FOUND', to_char(l_zay.kv2));
  end;

  -- определение внутрибанк.счетов для всех проводок пакета документов по заявке
  get_bankaccounts (p_currency => l_zay.kv2,
                    p_konvcurr => (case
                                   when l_zay.dk = 3
                                   then l_zay.kv_conv
                                   else null
                                   end),
                    p_taxflag  => (case
                                   when p_taxcust = 1
                                   then 0
                                   else l_zay.fl_pf
                                   end),           -- признак отчисления в Пенс.Фонд
                    p_trdaccFC => l_bank_trdaccFC, -- торговый счет ГОУ в ин.валюте
                    p_trdaccNC => l_bank_trdaccNC, -- торговый счет ГОУ в нац.валюте
                    p_cmsacc   => l_bank_cmsacc,   -- счет комиссионных доходов
                    p_taxacc   => l_bank_taxacc);  -- транз.счет для перечисления в Пенс.Фонд

  -- параметры клиента и все из него вытекающее:
  l_cust_pfacc  := null;
  l_cust_cmsacc := null;

  begin
     select * into l_custzay from cust_zay where rnk = l_zay.rnk;
  exception when no_data_found then
       l_custzay.rnk_pf := null; l_custzay.rnk := null; l_custzay.custacc4cms := null; l_custzay.nls_kom := null; l_custzay.nls_pf := null;  -- можно было ничего не делать вообще, но дальше используется
  end;

     -- индивид.счет клиента для списания в ПФ
     if l_custzay.nls_pf  is not null then
       begin
          l_cust_pfacc := i_getaccparam  (p_accid  => null,
                                          p_accnum => l_custzay.nls_pf,
                                          p_curid  => 980);
          l_cust_pr := 1;
       exception when no_data_found then
         -- для заявки № %s не найден заполненный в параметрах счет клиента для списания в ПФ (nls = %s)
         bars_error.raise_nerror (modcode, 'CUST_PFACC_NOT_FOUND', to_char(p_zayid), to_char(l_custzay.nls_pf));
       end;
     else
       l_cust_pfacc := null;
     end if;

     -- индивид.счет клиента для списания комиссии
     if l_custzay.custacc4cms  is not null then
       begin
          l_cust_cmsacc := i_getaccparam (p_accid  => null,
                                          p_accnum => l_custzay.custacc4cms,
                                          p_curid  => 980);
       exception when no_data_found then
         -- для заявки № %s не найден счет клиента для списания комиссии (nls = %s)
         bars_error.raise_nerror (modcode, 'CUST_CMSTACC_NOT_FOUND', to_char(p_zayid), to_char(l_custzay.custacc4cms));
       end;
     end if;

     -- индивид.счет банка из пар-ров клиента для зачисления комиссии
     if l_custzay.nls_kom is not null then
        begin
          l_bank_cmsacc := i_getaccparam (p_accid  => null,
                                          p_accnum => l_nlskom,
                                          p_curid  => gl.baseval);
        exception when no_data_found then null;
        end;
     end if;


  -- торговый счет клиента в нац.валюте
  begin
    l_cust_trdacc := i_getaccparam (p_accid  => l_zay.acc0,
                                    p_accnum => null,
                                    p_curid  => null);
  exception
    when no_data_found then
      -- для заявки № %s не найден торговый счет клиента в валюте %s (acc = %s)
      bars_error.raise_nerror (modcode, 'CUST_TRDACC_NOT_FOUND', to_char(p_zayid), to_char(l_baseval), to_char(l_zay.acc0));
  end;

  -- расчетный счет клиента в ин.валюте
  begin
    l_cust_curacc := i_getaccparam (p_accid  => l_zay.acc1,
                                    p_accnum => null,
                                    p_curid  => null);
  exception
    when no_data_found then
      -- для заявки № %s не найден расчетный счет клиента в валюте %s (acc = %s)
      bars_error.raise_nerror (modcode, 'CUST_CURTACC_NOT_FOUND', to_char(p_zayid), to_char(l_zay.kv2), to_char(l_zay.acc1));
  end;

  if l_cust_cmsacc.accid is null then
           /* l_cust_cmsacc.accid    := l_cust_trdacc.accid;
              l_cust_cmsacc.accnum   := l_cust_trdacc.accnum;
              l_cust_cmsacc.accname  := l_cust_trdacc.accname;
              l_cust_cmsacc.curid    := l_cust_trdacc.curid;
              l_cust_cmsacc.custcode := l_cust_trdacc.custcode;*/
       begin
            select acc, nls, nms, kv, rnk
              into l_cust_cmsacc
             from accounts
           where rnk = l_zay.rnk
               and nls = l_cust_trdacc.accnum
               and kv = gl.baseval;
          begin
            l_cust_cmsacc := i_getaccparam (p_accid  => null,
                                            p_accnum => l_cust_trdacc.accnum,
                                            p_curid  => gl.baseval);
          exception when no_data_found then
            -- для заявки № %s не найден счет клиента для списания комиссии (acc = %s)
            bars_error.raise_nerror (modcode, 'CUST_CMSTACC_NOT_FOUND', to_char(p_zayid), null);
          end;
       exception when no_data_found then
          -- для заявки № %s не найден счет клиента для списания комиссии (acc = %s)
            bars_error.raise_nerror (modcode, 'CUST_CMSTACC_NOT_FOUND', to_char(p_zayid), null);
       end;
  end if;

  bars_audit.trace('%s bankaccounts (%s, %s, %s, %s)', title,
                   l_bank_trdaccFC.accnum ||'/'|| to_char(l_bank_trdaccFC.curid),
                   l_bank_trdaccNC.accnum ||'/'|| to_char(l_bank_trdaccNC.curid),
                   l_bank_cmsacc.accnum   ||'/'|| to_char(l_bank_cmsacc.curid),
                   l_bank_taxacc.accnum   ||'/'|| to_char(l_bank_taxacc.curid));

    --данный блок должен работать только для не 2620
    begin
      select 1 into l_pr_2620 from accounts where acc = l_cust_curacc.accid and nbs = '2620' and ob22 = '05';
    exception when no_data_found then l_pr_2620 := 0;
    end;
    if l_pr_2620 = 0 and l_cust.codcagent not in (1,2) then
    begin
     -- смотрим, сколько счетов 3570 с Об22 = 03 на этом клиенте
     select count(*) into l_cnt_3570 from accounts where nbs = 3570 and ob22 = '03' and kv = 980 and rnk = l_zay.rnk and dazs is null;

     if l_cnt_3570 = 0 then
                            -- для заявки № %s не найден счет 3570 клиента (вообще, ни одного)
                            bars_error.raise_nerror (modcode, 'CUST_3570ACC_NOT_FOUND', to_char(p_zayid));
     elsif l_cnt_3570 = 1 then
                            -- найден однозначно один
                            select a.acc, a.nls, a.nms, a.kv, c.okpo
                              into l_cust_3570acc
                              from accounts a, customer c
                             where a.nbs = 3570 and a.ob22 = '03' and a.rnk = l_zay.rnk and a.rnk = c.rnk and a.kv = 980 and a.dazs is null;
     else
                            -- если найдено много - смотрим в доп.реквизите расчетного счета  l_cust_curacc
                           begin
                             select trim(value)
                               into l_val_3570
                               from accountsw
                              where acc = l_cust_curacc.accid and tag = 'C3570';
                           exception when no_data_found then
                                  --  для заявки № %s не указан 3570 клиента для р/с %s (%s)
                                  bars_error.raise_nerror (modcode, 'CUST_3570ACC_NOT_REGISTERED', to_char(p_zayid), to_char(l_cust_curacc.accnum), to_char(l_cust_curacc.curid));
                           end;
                           begin
                             select a.acc, a.nls, a.nms, a.kv, c.okpo
                               into l_cust_3570acc
                               from accounts a, customer c
                              where a.nls = l_val_3570 and a.nbs = 3570 and a.ob22 = '03' and a.rnk = l_zay.rnk and a.rnk = c.rnk and a.kv = 980 and a.dazs is null;
                           exception when no_data_found then
                                  --  для заявки № %s некорректно указан 3570 клиента для р/с %s (%s)
                                  bars_error.raise_nerror (modcode, 'CUST_3570ACC_ERR_REGISTERED', to_char(p_zayid), to_char(l_cust_curacc.accnum), to_char(l_cust_curacc.curid));
                           end;
     end if;
    end;
    end if;


  -- транз.счет клиента для отчисления в Пенс.Фонд
  if l_zay.fl_pf = 1 and p_taxcust = 1 then
     begin
       l_cust_taxacc := i_getaccparam (p_accid  => null,
                                       p_accnum => l_zay.nlsp,
                                       p_curid  => l_baseval);
     exception
       when no_data_found then
         -- для заявки № %s не найден транз.счет клиента %s в нац. вал. для отчисления в Пенс.Фонд
         bars_error.raise_nerror (modcode, 'CUST_TAXTACC_NOT_FOUND', to_char(p_zayid), to_char(l_zay.nlsp));
     end;
  end if;

  bars_audit.trace('%s custaccounts (%s, %s, %s, %s, %s)', title,
                   l_cust_trdacc.accnum ||'/'|| to_char(l_cust_trdacc.curid),
                   l_cust_curacc.accnum ||'/'|| to_char(l_cust_curacc.curid),
                   l_cust_cmsacc.accnum ||'/'|| to_char(l_cust_cmsacc.curid),
                   l_cust_taxacc.accnum ||'/'|| to_char(l_cust_taxacc.curid),
                   l_cust_pfacc.accnum  ||'/'|| to_char(l_cust_pfacc.curid) );

  -- cумма заявленной валюты в номинале
  l_nom_amount := l_zay.s2;

  -- cумма заявленной валюты в эквиваленте по курсу дилера
  if l_zay.dk = 3
  then -- покупка за валюту (конверсия)
    begin
      select kv_base
        into l_kv_base
        from zay_conv_kv
       where (kv1 = l_zay.kv2 and kv2 = l_zay.kv_conv)
          or (kv2 = l_zay.kv2 and kv1 = l_zay.kv_conv);
    exception
      when no_data_found then
        bars_audit.error( title||' kv2='||to_char(l_zay.kv2)||', kv_conv'||to_char(l_zay.kv_conv) );
        raise_application_error( -20222, 'Не описана базовая валюта для данной пары валют в конверсии!', true );
    end;
    -- обигрываем конверсию согласно курсам (валюта по отношению к валюте - пришлось определять понятие базовой валюты в паре)
    if l_zay.kv_conv = l_kv_base then
      l_eqv_amount := round(l_nom_amount / l_zay.kurs_f / power(10, 2) * 100);
    else
      l_eqv_amount := round(l_nom_amount * l_zay.kurs_f / power(10, 2) * 100);
    end if;
  else
    -- покупка за грн
    l_eqv_amount := round(l_nom_amount * l_zay.kurs_f / power(10, l_cur.dig) * 100);
  end if;

  -- сумма комиссии
  l_cms_amount := 0;
  if l_zay.kom > 0 then
        --l_cms_amount := gl.p_icurval(l_zay.kv2, round(l_nom_amount * l_zay.kom / 100), l_bdate);
        l_cms_amount := round( gl.p_icurval(l_zay.kv2, l_nom_amount * l_zay.kom, l_bdate)/100, 2);
     l_cms_detail := trim(to_char(l_zay.kom, 'fm990.9999'))
                   ||'% ('
                   ||trim(to_char(l_cms_amount/100, '99999999990.99'))
                   ||') '
                   ||bars_msg.get_msg (modcode, 'UAH');
  end if;
  if l_zay.skom > 0 then
     l_cms_amount := l_cms_amount + l_zay.skom * 100;
     if l_cms_detail is null then
        l_cms_detail := trim(to_char(l_zay.skom, '99999999990.99'))||' '||bars_msg.get_msg (modcode, 'UAH');
     else
        l_cms_detail := l_cms_detail ||' + ' ||trim(to_char(l_zay.skom, '99999999990.99'))||' '||bars_msg.get_msg (modcode, 'UAH');
     end if;
  end if;
  if l_zay.kom > 0 or  l_zay.skom > 0 then
      l_cms_detail := bars_msg.get_msg(modcode, 'COMMISSION')||' '||l_cms_detail;
  end if;

  select nvl(nmkk, substr(nmk,1,38)), okpo into l_custname, l_okpo from customer where rnk = l_zay.rnk;

  -- сумма отчисления в Пенсионный Фонд
  l_tax_amount := 0;
  if l_zay.fl_pf = 1 and l_zay.dk <> 3 then
--#ifdef CNBU
--     l_tax_amount  := gl.p_icurval(l_zay.kv2, round (l_nom_amount * p_taxrate / 100), l_bdate);
--#else
     l_tax_amount  := round (l_eqv_amount * p_taxrate / 100);
--#endif
     l_tax_detail  := bars_msg.get_msg(modcode, 'TAXDOC_DETAILS',
                                                trim(to_char(p_taxrate, 'fm990.9999')),
                                                trim(to_char(l_nom_amount/power(10, l_cur.dig), '99999999990.99')),
                                                l_cur.lcv,
                                                trim(to_char(l_zay.kurs_f, '999999990.00999999')));
     if l_custzay.rnk_pf is not null then
     l_tax_detail_add  := bars_msg.get_msg(modcode, 'TAXDOC_DETAILS_ADD',
                                                trim(l_custzay.rnk_pf),
                                                trim(l_custname));
     else l_tax_detail_add := null;
     end if;
     l_tax_detail2 := bars_msg.get_msg(modcode, 'TAXDOC_DETAILS2',
                                                trim(to_char(p_taxrate, 'fm990.9999')),
                                                trim(to_char(l_tax_amount/100, '99999999990.99')));
  end if;
  bars_audit.trace('%s amounts(nom,eqv,cms,tax) = (%s,%s,%s,%s)', title,
                   to_char(l_nom_amount), to_char(l_eqv_amount),
                   to_char(l_cms_amount), to_char(l_tax_amount));

  -- назначение платежа
  if l_zay.dk = 3 then
     l_doc_details := substr(bars_msg.get_msg(modcode,
                                           'BUY_DETAILS_CONV',
                                           trim(to_char(l_zay.s2/100, '99999999990.99')),
                                           l_cur.lcv,
                                           --trim(to_char(round(l_zay.kurs_f, 4), '999999990.99999')),
                                           trim(to_char(l_zay.kurs_f,'fm999999990.00999999')),
                                           l_zay.kv_conv,
                                           --nvl(l_zay.nd, to_char(l_zay.id)),
                                           nvl(l_zay.nd, ' '),
                                           to_char(l_zay.fdat, 'dd.mm.yyyy') )
                          ||' '||l_deal_details||' '||l_cms_detail||' '||l_tax_detail2, 1, 160);
                    --        ||' '||l_deal_details||' '||l_cms_detail, 1, 160);
  else
  -- Купівля %s %s по курсу %sгрн. зг.заяви клієнта на купівлю №%s від %sр. /%s/
  l_doc_details := substr(trim(bars_msg.get_msg(modcode,
                                                'BUY_DETAILS_SBER',
                                                trim(to_char(l_nom_amount/power(10, l_cur.dig), '99999999990.99')),
                                                l_cur.lcv,
                                                --trim(to_char(round(l_zay.kurs_f, 4), '999999990.99999')),
                                                trim(to_char(l_zay.kurs_f,'fm999999990.00999999')),
                                                nvl(l_zay.nd, to_char(l_zay.id)),
                                                to_char(l_zay.fdat, 'dd.mm.yyyy'),
                                                l_custname)
                          ||' '||l_cms_detail||' '||l_tax_detail2), 1, 160);
               --             ||' '||l_cms_detail), 1, 160);
  end if;

  bars_audit.trace('%s details (cms,tax,tax2,deal,doc) = (%s,%s,%s,%s,%s)', title,
                   l_cms_detail, l_tax_detail, l_tax_detail2, l_deal_details, l_doc_details);

  -- отчисление в Пенсионный Фонд
  if l_tax_amount > 0 then
     i_paydoc (p_flg     => null,
              -- p_sideA   => l_cust_trdacc,
               p_sideA   => (case when l_cust_pr = 1 then l_cust_pfacc else l_cust_trdacc end),
               p_sideB   => (case when p_taxcust = 1 then l_cust_taxacc else l_bank_taxacc end),
               p_mfoB    => l_mfo,
               p_vdat    => l_bdate,
               p_tt      => (case when p_taxcust = 1 then taxcust_tt else taxbank_tt end),
               p_dk      => 1,
               p_vob     => nvl(p_vobNС,6),
               p_nd      => nvl(l_zay.nd, to_char(l_zay.id)),
               p_amount  => l_tax_amount,
               p_details => (case when p_taxcust = 1 then substr(l_tax_detail,1,160) else substr(l_tax_detail||' '||l_tax_detail_add,1,160) end),
               p_ref     => l_tax_ref);
     bars_audit.trace('%s ref(tax) = %s', title, to_char(l_tax_ref));
  end if;

  select to_number(substr(flags, 38, 1)) into l_payflg from tts where tt = trd_tt;

  -- Оплата для конверсии
  if l_zay.dk = 3
  then
    --!!!!
    -- данный блок должен работать только для не 2620
    begin
      select 1 into l_pr_2620 from accounts where acc = l_cust_curacc.accid and nbs = '2620' and ob22 = '05';
    exception
      when no_data_found then l_pr_2620 := 0;
    end;

    if l_pr_2620 = 0 and l_cust.codcagent not in (1,2) then
 -- для Сбера гоняем через 3570
  --!!!!
  if l_par = 1 and nvl(l_zay.ref_sps,0)<>0 then
  i_paydoc (p_flg     => l_payflg,
            p_sideA   => l_cust_curacc,
            p_sideB   => l_bank_trdaccFC,
            p_mfoB    => l_mfo,
            p_vdat    => l_bdate,
            p_tt      => trd_tt,
            p_dk      => 0,
            p_vob     => nvl(p_vobFС,46),
            p_nd      => nvl(l_zay.nd, to_char(l_zay.id)),
            p_amount  => l_nom_amount,
            p_details => l_doc_details,
            p_ref     => l_doc_ref);
  paytt (l_payflg, l_doc_ref, l_bdate, vnt_tt, 1,
         l_cust_cmsacc.curid,  l_cust_cmsacc.accnum,  l_cms_amount,
         l_cust_3570acc.curid, l_cust_3570acc.accnum, l_cms_amount);
  paytt (l_payflg, l_doc_ref, l_bdate, cms_tt, 1,
         l_cust_3570acc.curid, l_cust_3570acc.accnum, l_cms_amount,
         l_bank_cmsacc.curid,  l_bank_cmsacc.accnum,  l_cms_amount);
  else
  i_paydoc (p_flg     => l_payflg,
            p_sideA   => l_cust_curacc,
            p_sideB   => l_bank_trdaccFC,
            p_mfoB    => l_mfo,
            p_vdat    => l_bdate,
            p_tt      => trd_tt,
            p_dk      => 0,
            p_vob     => nvl(p_vobFС,46),
            p_nd      => nvl(l_zay.nd, to_char(l_zay.id)),
            p_amount  => l_nom_amount,
            p_details => l_doc_details,
            p_ref     => l_doc_ref);
  paytt (l_payflg, l_doc_ref, l_bdate, frx_tt, 1,
         l_cust_trdacc.curid,   l_cust_trdacc.accnum,   l_eqv_amount,
         l_bank_trdaccNC.curid, l_bank_trdaccNC.accnum, l_eqv_amount);
  paytt (l_payflg, l_doc_ref, l_bdate, vnt_tt, 1,
         l_cust_cmsacc.curid,  l_cust_cmsacc.accnum,  l_cms_amount,
         l_cust_3570acc.curid, l_cust_3570acc.accnum, l_cms_amount);
  paytt (l_payflg, l_doc_ref, l_bdate, cms_tt, 1,
         l_cust_3570acc.curid, l_cust_3570acc.accnum, l_cms_amount,
         l_bank_cmsacc.curid,  l_bank_cmsacc.accnum,  l_cms_amount);
  end if;
 else
  if l_par = 1 and nvl(l_zay.ref_sps,0)<>0 then
  i_paydoc (p_flg     => l_payflg,
            p_sideA   => l_cust_curacc,
            p_sideB   => l_bank_trdaccFC,
            p_mfoB    => l_mfo,
            p_vdat    => l_bdate,
            p_tt      => trd_tt,
            p_dk      => 0,
            p_vob     => nvl(p_vobFС,46),
            p_nd      => nvl(l_zay.nd, to_char(l_zay.id)),
            p_amount  => l_nom_amount,
            p_details => l_doc_details,
            p_ref     => l_doc_ref);
  paytt (l_payflg, l_doc_ref, l_bdate, cms_tt, 1,
         l_cust_cmsacc.curid, l_cust_cmsacc.accnum, l_cms_amount,
         l_bank_cmsacc.curid, l_bank_cmsacc.accnum, l_cms_amount);
  else
  i_paydoc (p_flg     => l_payflg,
            p_sideA   => l_cust_curacc,
            p_sideB   => l_bank_trdaccFC,
            p_mfoB    => l_mfo,
            p_vdat    => l_bdate,
            p_tt      => trd_tt,
            p_dk      => 0,
            p_vob     => nvl(p_vobFС,46),
            p_nd      => nvl(l_zay.nd, to_char(l_zay.id)),
            p_amount  => l_nom_amount,
            p_details => l_doc_details,
            p_ref     => l_doc_ref);
  paytt (l_payflg, l_doc_ref, l_bdate, frx_tt, 1,
         l_cust_trdacc.curid,   l_cust_trdacc.accnum,   l_eqv_amount,
         l_bank_trdaccNC.curid, l_bank_trdaccNC.accnum, l_eqv_amount);
  paytt (l_payflg, l_doc_ref, l_bdate, cms_tt, 1,
         l_cust_cmsacc.curid, l_cust_cmsacc.accnum, l_cms_amount,
         l_bank_cmsacc.curid, l_bank_cmsacc.accnum, l_cms_amount);
  end if;
 end if;
-- Оплата для покупки за грн
else
  --данный блок должен работать только для не 2620
  begin
    select 1 into l_pr_2620 from accounts where acc = l_cust_curacc.accid and nbs = '2620' and ob22 = '05';
  exception when no_data_found then l_pr_2620 := 0;
  end;
  if l_pr_2620 = 0 and l_cust.codcagent not in (1,2) then
  -- для Сбера гоняем через 3570
   --!!!!
   if l_par = 1 and nvl(l_zay.ref_sps,0)<>0 then
     i_paydoc (p_flg     => l_payflg,
               p_sideA   => l_cust_curacc,
               p_sideB   => l_bank_trdaccFC,
               p_mfoB    => l_mfo,
               p_vdat    => l_bdate,
               p_tt      => trd_tt,
               p_dk      => 0,
               p_vob     => nvl(p_vobFС,46),
               p_nd      => nvl(l_zay.nd, to_char(l_zay.id)),
               p_amount  => l_nom_amount,
               p_details => l_doc_details,
               p_ref     => l_doc_ref);
     paytt (l_payflg, l_doc_ref, l_bdate, vnt_tt, 1,
            l_cust_cmsacc.curid,  l_cust_cmsacc.accnum,  l_cms_amount,
            l_cust_3570acc.curid, l_cust_3570acc.accnum, l_cms_amount);
     paytt (l_payflg, l_doc_ref, l_bdate, cms_tt, 1,
            l_cust_3570acc.curid, l_cust_3570acc.accnum, l_cms_amount,
            l_bank_cmsacc.curid,  l_bank_cmsacc.accnum,  l_cms_amount);
   else
     i_paydoc (p_flg     => l_payflg,
               p_sideA   => l_cust_curacc,
               p_sideB   => l_bank_trdaccFC,
               p_mfoB    => l_mfo,
               p_vdat    => l_bdate,
               p_tt      => trd_tt,
               p_dk      => 0,
               p_vob     => nvl(p_vobFС,46),
               p_nd      => nvl(l_zay.nd, to_char(l_zay.id)),
               p_amount  => l_nom_amount,
               p_details => l_doc_details,
               p_ref     => l_doc_ref);
     paytt (l_payflg, l_doc_ref,   l_bdate, frx_tt, 1,
            l_cust_trdacc.curid,   l_cust_trdacc.accnum,   l_eqv_amount,
            l_bank_trdaccNC.curid, l_bank_trdaccNC.accnum, l_eqv_amount);
     paytt (l_payflg, l_doc_ref, l_bdate, vnt_tt, 1,
            l_cust_cmsacc.curid,  l_cust_cmsacc.accnum,  l_cms_amount,
            l_cust_3570acc.curid, l_cust_3570acc.accnum, l_cms_amount);
     paytt (l_payflg, l_doc_ref, l_bdate, cms_tt, 1,
            l_cust_3570acc.curid, l_cust_3570acc.accnum, l_cms_amount,
            l_bank_cmsacc.curid,  l_bank_cmsacc.accnum,  l_cms_amount);
   end if;
  else
   --!!!!
   if l_par = 1 and nvl(l_zay.ref_sps,0)<>0 then
     i_paydoc (p_flg     => l_payflg,
               p_sideA   => l_cust_curacc,
               p_sideB   => l_bank_trdaccFC,
               p_mfoB    => l_mfo,
               p_vdat    => l_bdate,
               p_tt      => trd_tt,
               p_dk      => 0,
               p_vob     => nvl(p_vobFС,46),
               p_nd      => nvl(l_zay.nd, to_char(l_zay.id)),
               p_amount  => l_nom_amount,
               p_details => l_doc_details,
               p_ref     => l_doc_ref);
     paytt (l_payflg, l_doc_ref, l_bdate, cms_tt, 1,
            l_cust_cmsacc.curid, l_cust_cmsacc.accnum, l_cms_amount,
            l_bank_cmsacc.curid, l_bank_cmsacc.accnum, l_cms_amount);
   else
     i_paydoc (p_flg     => l_payflg,
               p_sideA   => l_cust_curacc,
               p_sideB   => l_bank_trdaccFC,
               p_mfoB    => l_mfo,
               p_vdat    => l_bdate,
               p_tt      => trd_tt,
               p_dk      => 0,
               p_vob     => nvl(p_vobFС,46),
               p_nd      => nvl(l_zay.nd, to_char(l_zay.id)),
               p_amount  => l_nom_amount,
               p_details => l_doc_details,
               p_ref     => l_doc_ref);
     paytt (l_payflg, l_doc_ref, l_bdate, frx_tt, 1,
            l_cust_trdacc.curid,   l_cust_trdacc.accnum,   l_eqv_amount,
            l_bank_trdaccNC.curid, l_bank_trdaccNC.accnum, l_eqv_amount);
     paytt (l_payflg, l_doc_ref, l_bdate, cms_tt, 1,
            l_cust_cmsacc.curid, l_cust_cmsacc.accnum, l_cms_amount,
            l_bank_cmsacc.curid, l_bank_cmsacc.accnum, l_cms_amount);
   end if;
  end if;

end if;
if nvl(l_cms_amount,0)<>0 then
  -- Маркирование проводок по комиссии  общебанковскими кодами тарифов
  if l_zay.dk = 3 then
     case
       when l_eqv_amount/100  <=10000   then i_insdocparam (l_doc_ref, 'KTAR', to_char('231'));
       when l_eqv_amount/100 > 10000   and l_eqv_amount/100 <=100000  then i_insdocparam (l_doc_ref, 'KTAR', to_char('232'));
       when l_eqv_amount/100 > 100000 and l_eqv_amount/100 <=1000000 then i_insdocparam (l_doc_ref, 'KTAR', to_char('233'));
       when l_eqv_amount/100 > 1000000 then i_insdocparam (l_doc_ref, 'KTAR', to_char('234'));
      end case;
  else
     case
       when l_eqv_amount/100 <=10000  then i_insdocparam (l_doc_ref, 'KTAR', to_char('222'));
       when l_eqv_amount/100 > 10000   and l_eqv_amount/100<=100000  then i_insdocparam (l_doc_ref, 'KTAR', to_char('223'));
       when l_eqv_amount/100 > 100000 and l_eqv_amount/100<=1000000 then i_insdocparam (l_doc_ref, 'KTAR', to_char('224'));
       when l_eqv_amount/100 > 1000000 then i_insdocparam (l_doc_ref, 'KTAR', to_char('225'));
      end case;
  end if;
end if;

  bars_audit.trace('%s ref(buy) = %s', title, to_char(l_doc_ref));

  -- заполнение доп.реквизитов документа для 39-го и 70-го файлов
  i_setdocparams (p_ref     => l_doc_ref,
                  p_zayrow  => l_zay,
                  p_nominal => l_cur.nominal,
                  p_d#39    => p_indx39);

  -- заполнение реквизита для тех, у кого нет ОКПО
  if l_okpo = '0000000000' then
      begin
        select ser||' '||to_char(numdoc) into l_value from person where passp = 1 and rnk = l_zay.rnk;
      exception when no_data_found then null;
      end;
      set_operw ( l_doc_ref, 'Ф    ', l_value);
      update oper set d_rec = '#Ф'||l_value||'#' where ref = l_doc_ref;
  end if;


  update zayavka set sos = 2, ref = l_doc_ref, s_pf = l_tax_amount, ref_pf = l_tax_ref where id = l_zay.id;

  p_buyref := l_doc_ref;
  p_taxref := l_tax_ref;

  bars_audit.trace('%s exit with %s, %s', title, to_char(p_buyref), to_char(p_taxref));

exception
  when bars_error.err then
    raise;
--  when others then
--    bars_error.raise_nerror (modcode, 'PAYBUY_FAILED', to_char(l_zay.id), sqlerrm);
end pay_buying;

-------------------------------------------------------------------------------
--
-- формирование документа на списание по заявке на покупку валюты
--
procedure pay_buying_sps
 (p_zayid   in  zayavka.id%type,         -- идентификатор заявки
  p_vob     in  vob.vob%type default 6,  -- вид мемориального ордера
  p_buyref  out oper.ref%type            -- референс списания нац.валюты
  )
is
  title           varchar2(60)   := 'zay.paybuy_sps:';
  l_baseval       tabval.kv%type := gl.baseval;
  l_bdate         date           := gl.bdate;
  l_mfo           banks.mfo%type := gl.amfo;
  l_zay           zayavka%rowtype;
  l_cur           tabval%rowtype;
  l_custname      customer.nmkk%type;
  l_okpo          customer.okpo%type;
  l_value         varchar2(10);
  -- внутрибанк.счета
  l_bank_trdaccFC t_accrec;
  l_bank_trdaccNC t_accrec;
  l_bank_cmsacc   t_accrec;
  l_bank_taxacc   t_accrec;
  l_bank_mfo      banks.mfo%type;
  -- клиентск.счета
  l_cust_trdacc   t_accrec;
  l_cust_curacc   t_accrec;
  l_cust_taxacc   t_accrec;
  l_cust_cmsacc   t_accrec;
  l_cust_pfacc    t_accrec;
  -- суммы и назначение платежей
  l_nom_amount    number(38);
  l_eqv_amount    number(38);
  l_doc_details   oper.nazn%type;
  l_payflg        number(1);
  l_doc_ref       oper.ref%type;
  l_kv_base       tabval.kv%type;
  l_cust          customer%rowtype;
  l_custzay       cust_zay%rowtype;
  l_cust_pr       number(1) := 0;
  l_tmp_accnum    tts.nlsb%type;
begin

  bars_msg.set_lang ('UKR');

  -- параметры заявки
  begin
    select * into l_zay from zayavka where id = p_zayid for update of sos nowait;
  exception
    when no_data_found then
      -- не найдена заявка № %s
      bars_error.raise_nerror (modcode, 'ZAY_NOT_FOUND', to_char(p_zayid));
  end;

  -- проверка "готовности" заявки
  if l_zay.sos != 1 and nvl(l_zay.ref_sps,0)<>0  then
     -- запрещено формирование документа списания по заявке № %s
     bars_error.raise_nerror (modcode, 'INVALID_STATUS_SPS', to_char(p_zayid));
  end if;
  if l_zay.vdate > l_bdate then
     -- запрещено формирование документа списания по форвардной заявке № %s(дата валютир.и %s)
     bars_error.raise_nerror (modcode, 'INVALID_VALUEDATE', to_char(p_zayid), to_char(l_zay.vdate, 'dd.mm.yyyy'));
  end if;

  -- параметры валюты
  begin
    select * into l_cur from tabval where kv = l_zay.kv2;
  exception
    when no_data_found then
      -- не найдена валюта с кодом %s
      bars_error.raise_nerror (modcode, 'CUR_NOT_FOUND', to_char(l_zay.kv2));
  end;

  -- определение внутрибанк.счетов для всех проводок пакета документов по заявке
  -- вариант, предложенный Лесняком С.Б.
  l_bank_trdaccNC.accid := null;

  begin
    select to_number(substr(FLAGS, 38, 1)), NLSB, MFOB
      into l_payflg, l_tmp_accnum, l_bank_mfo
      from BARS.TTS
     where TT = frx_tt;
  exception
    when NO_DATA_FOUND then
      raise_application_error( -20666, 'Не знайдено операцію з кодом '||frx_tt, true );
  end;

  case
    when ( l_tmp_accnum Is Null )
    then
      raise_application_error( -20666, 'Не вказано рахунок Б в налаштуваннях операції '||frx_tt, true );
    when ( l_tmp_accnum like '#(%' )
    then
      begin
        execute immediate 'select '||substr(l_tmp_accnum,3, length(l_tmp_accnum)-3)||' from dual'
           into l_bank_trdaccNC.accnum;
      exception
        when OTHERS then
          raise_application_error( -20666, 'Неможливо отримати номер рахунку по по формулі '||l_tmp_accnum, true );
      end;
    else
      l_bank_trdaccNC.accnum := l_tmp_accnum;
  end case;

  -- l_bank_trdaccNC.accname := 'ГОУ АТ Ощадбанк';
  -- поскольку во всех РУ-шках ЦА зарегистрирован как банки - оттуда найдем и ОКПО с названием
  begin
    select c.nmk, c.okpo
      into l_bank_trdaccNC.accname, l_bank_trdaccNC.custcode
      from customer c
         , custbank b
     where b.mfo  = '300465'
       and b.rnk  = c.rnk
       and rownum = 1;
  exception when no_data_found then
       raise_application_error(-20000, 'Не знайдено ОКПО ЦА!');
  end;

  if l_zay.dk = 3 then
       l_bank_trdaccNC.curid := l_zay.kv_conv;
  else
       l_bank_trdaccNC.curid := 980;
  end if;
  --l_bank_trdaccNC.custcode := '00032129';

  -- параметры клиента  и все с ним связанное
  begin
    select * into l_custzay from cust_zay where rnk = l_zay.rnk;
  exception when no_data_found then null;
  end;

  bars_audit.trace('%s bankaccounts (%s, %s, %s, %s)', title,
                   l_bank_trdaccFC.accnum ||'/'|| to_char(l_bank_trdaccFC.curid),
                   l_bank_trdaccNC.accnum ||'/'|| to_char(l_bank_trdaccNC.curid),
                   l_bank_cmsacc.accnum   ||'/'|| to_char(l_bank_cmsacc.curid),
                   l_bank_taxacc.accnum   ||'/'|| to_char(l_bank_taxacc.curid));

  -- торговый счет клиента в нац.валюте
  begin
    l_cust_trdacc := i_getaccparam (p_accid  => l_zay.acc0,
                                    p_accnum => null,
                                    p_curid  => null);
  exception
    when no_data_found then
      -- для заявки № %s не найден торговый счет клиента в валюте %s (acc = %s)
      bars_error.raise_nerror (modcode, 'CUST_TRDACC_NOT_FOUND', to_char(p_zayid), to_char(l_baseval), to_char(l_zay.acc0));
  end;

  -- cумма заявленной валюты в номинале
  l_nom_amount := l_zay.s2;

  -- cумма заявленной валюты в эквиваленте по курсу дилера
  if l_zay.dk = 3 then
    -- покупка за валюту (конверсия)
    begin
      select kv_base into l_kv_base from zay_conv_kv where (kv1 = l_zay.kv2 and kv2 = l_zay.kv_conv) or (kv2 = l_zay.kv2 and kv1 = l_zay.kv_conv);
    exception when no_data_found then
        raise_application_error(-22222, 'Не описана базовая валюта для данной пары валют в конверсии!');
    end;
    -- обигрываем конверсию согласно курсам (валюта по отношению к валюте - пришлось определять понятие базовой валюты в паре)

    if l_zay.kv_conv = l_kv_base then
       l_eqv_amount := round(l_nom_amount / l_zay.kurs_f / power(10, 2) * 100);
    else
       l_eqv_amount := round(l_nom_amount * l_zay.kurs_f / power(10, 2) * 100);
    end if;
  else
    -- покупка за грн
    l_eqv_amount := round(l_nom_amount * l_zay.kurs_f / power(10, l_cur.dig) * 100);
  end if;


  select nvl(nmkk, substr(nmk,1,38)), okpo into l_custname, l_okpo from customer where rnk = l_zay.rnk;

  -- назначение платежа
  -- Перерахування коштів на купівлю %s %s зг.заяви клієнта на купівлю №%s від %sр.
  l_doc_details := substr(trim(bars_msg.get_msg(modcode,
                                                'BUY_DETAILS_SPS',
                                                trim(to_char(l_nom_amount/power(10, l_cur.dig), '99999999990.99')),
                                                l_cur.lcv,
                                                nvl(l_zay.nd, to_char(l_zay.id)),
                                                to_char(l_zay.fdat, 'dd.mm.yyyy'))), 1, 160);


-- Оплата для конверсии
if l_zay.dk = 3 then
  i_paydoc (p_flg     => l_payflg,
            p_sideA   => l_cust_trdacc,
            p_sideB   => l_bank_trdaccNC,
            p_mfoB    => l_bank_mfo,
            p_vdat    => l_bdate,
            p_tt      => frx_tt,
            p_dk      => 1,
            p_vob     => 46,
            p_nd      => nvl(l_zay.nd, to_char(l_zay.id)),
            p_amount  => l_eqv_amount,
            p_details => l_doc_details,
            p_ref     => l_doc_ref);
-- Оплата для покупки за грн
else
     i_paydoc (p_flg     => l_payflg,
               p_sideA   => l_cust_trdacc,
               p_sideB   => l_bank_trdaccNC,
            p_mfoB    => l_bank_mfo,
               p_vdat    => l_bdate,
               p_tt      => frx_tt,
               p_dk      => 1,
               p_vob     => nvl(p_vob,6),
               p_nd      => nvl(l_zay.nd, to_char(l_zay.id)),
               p_amount  => l_eqv_amount,
               p_details => l_doc_details,
               p_ref     => l_doc_ref);

end if;

  bars_audit.trace('%s ref(buy) = %s', title, to_char(l_doc_ref));

  if l_okpo = '0000000000' then
      begin
        select ser||' '||to_char(numdoc) into l_value from person where passp = 1 and rnk = l_zay.rnk;
      exception when no_data_found then null;
      end;
      set_operw ( l_doc_ref, 'Ф    ', l_value);
      update oper set d_rec = '#Ф'||l_value||'#' where ref = l_doc_ref;
  end if;

  update zayavka set ref_sps = l_doc_ref where id = l_zay.id;

  p_buyref := l_doc_ref;

  bars_audit.trace('%s exit with %s', title, to_char(p_buyref));

exception
  when bars_error.err then
    raise;
--  when others then
--    bars_error.raise_nerror (modcode, 'PAYBUY_FAILED', to_char(l_zay.id), sqlerrm);
end pay_buying_sps;

-------------------------------------------------------------------------------
--
-- формирование пакета документов по заявке на продажу валюты
--
procedure pay_selling
 (p_zayid   in  zayavka.id%type,          -- идентификатор заявки
  p_indx39  in  varchar2,                 -- показатель для 39-го файла
  p_vobFС   in  vob.vob%type default 46,  -- вид мемориального ордера в ин.валюте
  p_vobNС   in  vob.vob%type default 6,   -- вид мемориального ордера в нац.валюте
  p_selref  out oper.ref%type)            -- референс зачисления нац.валюты
is
  title           varchar2(60)   := 'zay.paysel:';
  l_baseval       tabval.kv%type := gl.baseval;
  l_bdate         date           := gl.bdate;
  l_mfo           banks.mfo%type := gl.amfo;
  l_zay           zayavka%rowtype;
  l_cur           tabval%rowtype;
  l_custname      customer.nmkk%type;
  l_okpo          customer.okpo%type;
  l_value         varchar2(10);
  -- внутрибанк.счета
  l_bank_trdaccFC t_accrec;
  l_bank_trdaccNC t_accrec;
  l_bank_cmsacc   t_accrec;
  l_bank_taxacc   t_accrec;
  -- клиентск.счета
  l_cust_trdacc   t_accrec;
  l_cust_trdaccNC t_accrec;
  l_cust_trdaccFC t_accrec;
  l_cust_curacc   t_accrec;
  l_cust_cmsacc   t_accrec;
  l_custmfo       zayavka.mfo0%type;
  -- суммы и назначение платежей
  l_nom_amount    number(38);
  l_eqv_amount    number(38);
  l_cms_amount    number(38);
  l_cms_detail    oper.nazn%type;
  l_doc_details   oper.nazn%type;
  l_payflg        number(1);
  l_doc_ref       oper.ref%type;
  l_custzay       cust_zay%rowtype;
  l_nlskom        cust_zay.nls_kom%type;
  l_obz           zayavka.obz%type;
  l_nlsNC         accounts.nls%type;
  l_cust          customer%rowtype;
  l_tmpn          number;
  l_cnt_3570      number;
  l_val_3570      accounts.nls%type;
  l_cust_3570acc  t_accrec;
  l_pr_2620       number;
  l_par           number(1) := 0;
  l_kv_base       tabval.kv%type;
  cursor c_customer (p_rnk customer.rnk%type) is
    select c.*
      from customer c
     where c.rnk=p_rnk;

begin

  bars_audit.trace('%s entry, zayid=>%s, vob=>%s/%s', title,
                   to_char(p_zayid), to_char(p_vobFС), to_char(p_vobNС));

  bars_msg.set_lang ('UKR');

  -- параметры заявки
  begin
    select * into l_zay from zayavka where id = p_zayid for update of sos nowait;
  exception
    when no_data_found then
      -- не найдена заявка № %s
      bars_error.raise_nerror (modcode, 'ZAY_NOT_FOUND', to_char(p_zayid));
  end;
   open  c_customer (l_zay.rnk);
   fetch c_customer into l_cust;
   close c_customer;
  select decode(f_get_params('MFOP'),'300465',1,0)  into l_par from dual;

  -- проверка "готовности" заявки
  if l_zay.sos != 1 then
     -- запрещено формирование пакета документов по заявке № %s (статус заявки %s)
     bars_error.raise_nerror (modcode, 'INVALID_STATUS', to_char(p_zayid), to_char(l_zay.sos));
  end if;
  if l_zay.vdate > l_bdate then
     -- запрещено формирование пакета документов по форвардной заявке № %s(дата валютир.и %s)
     bars_error.raise_nerror (modcode, 'INVALID_VALUEDATE', to_char(p_zayid), to_char(l_zay.vdate, 'dd.mm.yyyy'));
  end if;

  -- параметры валюты
  begin
    select * into l_cur from tabval where kv = l_zay.kv2;
  exception
    when no_data_found then
      -- не найдена валюта с кодом %s
      bars_error.raise_nerror (modcode, 'CUR_NOT_FOUND', to_char(l_zay.kv2));
  end;

  -- определение внутрибанк.счетов для всех проводок пакета документов по заявке
  get_bankaccounts (p_currency => l_zay.kv2,
                    p_konvcurr => (case
                                   when l_zay.dk = 4 then l_zay.kv_conv
                                   else null
                                   end),
                    p_taxflag  => 0,
                    p_trdaccFC => l_bank_trdaccFC, -- торговый счет ГОУ в ин.валюте
                    p_trdaccNC => l_bank_trdaccNC, -- торговый счет ГОУ в нац.валюте
                    p_cmsacc   => l_bank_cmsacc,   -- счет комиссионных доходов
                    p_taxacc   => l_bank_taxacc);  -- транз.счет для перечисления в Пенс.Фонд

  bars_audit.trace('%s bankaccounts (%s, %s, %s, %s)', title,
                   l_bank_trdaccFC.accnum ||'/'|| to_char(l_bank_trdaccFC.curid),
                   l_bank_trdaccNC.accnum ||'/'|| to_char(l_bank_trdaccNC.curid),
                   l_bank_cmsacc.accnum   ||'/'|| to_char(l_bank_cmsacc.curid),
                   l_bank_taxacc.accnum   ||'/'|| to_char(l_bank_taxacc.curid));

  -- параметры клиента и все из него вытекающее:
  l_cust_cmsacc := null;

  begin
     select * into l_custzay from cust_zay where rnk = l_zay.rnk;
  exception when no_data_found then
       l_custzay.rnk_pf := null; l_custzay.rnk := null; l_custzay.custacc4cms := null; l_custzay.nls_kom := null; l_custzay.nls_pf := null;  -- можно было ничего не делать вообще, но дальше используется
  end;

  -- индивид.счет клиента для списания комиссии
  if l_custzay.custacc4cms  is not null then
    begin
       l_cust_cmsacc := i_getaccparam (p_accid  => null,
                                       p_accnum => l_custzay.custacc4cms,
                                       p_curid  => 980);
    exception when no_data_found then
      -- для заявки № %s не найден счет клиента для списания комиссии (nls = %s)
      bars_error.raise_nerror (modcode, 'CUST_CMSTACC_NOT_FOUND', to_char(p_zayid), to_char(l_custzay.custacc4cms));
    end;
  end if;

  -- индивид.счет банка из пар-ров клиента для зачисления комиссии
  if l_custzay.nls_kom is not null then
     begin
       l_bank_cmsacc := i_getaccparam (p_accid  => null,
                                       p_accnum => l_nlskom,
                                       p_curid  => gl.baseval);
     exception when no_data_found then null;
     end;
  end if;

  -- торговый счет клиента в ин.валюте
  begin
    l_cust_trdacc := i_getaccparam (p_accid  => l_zay.acc1,
                                    p_accnum => null,
                                    p_curid  => null);
  exception
    when no_data_found then
      -- для заявки № %s не найден торговый счет клиента в валюте %s (acc = %s)
      bars_error.raise_nerror (modcode, 'CUST_TRDACC_NOT_FOUND', to_char(p_zayid), to_char(l_zay.kv2), to_char(l_zay.acc1));
  end;

  if l_cust_cmsacc.accid is null then
           /* l_cust_cmsacc.accid    := l_cust_trdacc.accid;
              l_cust_cmsacc.accnum   := l_cust_trdacc.accnum;
              l_cust_cmsacc.accname  := l_cust_trdacc.accname;
              l_cust_cmsacc.curid    := l_cust_trdacc.curid;
              l_cust_cmsacc.custcode := l_cust_trdacc.custcode;*/
       begin
            select acc, nls, nms, kv, rnk
              into l_cust_cmsacc
             from accounts
           where rnk = l_zay.rnk
               and nls = l_cust_trdacc.accnum
               and kv = gl.baseval;
          begin
            l_cust_cmsacc := i_getaccparam (p_accid  => null,
                                            p_accnum => l_cust_trdacc.accnum,
                                            p_curid  => gl.baseval);
          exception when no_data_found then
            -- для заявки № %s не найден счет клиента для списания комиссии (acc = %s)
            bars_error.raise_nerror (modcode, 'CUST_CMSTACC_NOT_FOUND', to_char(p_zayid), null);
          end;
       exception when no_data_found then
          -- для заявки № %s не найден счет клиента для списания комиссии (acc = %s)
            bars_error.raise_nerror (modcode, 'CUST_CMSTACC_NOT_FOUND', to_char(p_zayid), null);
       end;
  end if;

  bars_audit.trace('%s bankaccounts (%s, %s, %s, %s)', title,
                   l_bank_trdaccFC.accnum ||'/'|| to_char(l_bank_trdaccFC.curid),
                   l_bank_trdaccNC.accnum ||'/'|| to_char(l_bank_trdaccNC.curid),
                   l_bank_cmsacc.accnum   ||'/'|| to_char(l_bank_cmsacc.curid),
                   l_bank_taxacc.accnum   ||'/'|| to_char(l_bank_taxacc.curid));


  -- расчетный счет клиента
  l_custmfo := nvl(l_zay.mfo0, l_mfo);

  if l_custmfo = l_mfo then
     begin
       l_cust_curacc := i_getaccparam (p_accid  => l_zay.acc0,
                                       p_accnum => null,
                                       p_curid  => null);
     exception
       when no_data_found then
         --  для заявки № %s не найден расчетный счет клиента в валюте %s (acc = %s)
         bars_error.raise_nerror (modcode, 'CUST_CURTACC_NOT_FOUND', to_char(p_zayid), to_char(nvl(l_zay.kv_conv, l_baseval)), to_char(l_zay.acc0));
     end;
  else
     l_cust_curacc.accid    := null;
     l_cust_curacc.accnum   := l_zay.nls0;
     -- продажа за грн.
     if l_zay.dk = 2 then
        l_cust_curacc.curid    := l_baseval;
     -- конверсия (продажа за валюту) dk = 4
     else
        l_cust_curacc.curid    := l_zay.kv_conv;
     end if;
     select substr(nmk, 1, 38), okpo
       into l_cust_curacc.accname, l_cust_curacc.custcode
       from customer
      where rnk = l_zay.rnk;
  end if;

  if l_cust_curacc.accnum is null then
     -- для заявки № %s не найден расчетный счет клиента в валюте %s (acc = %s)
     bars_error.raise_nerror (modcode, 'CUST_CURTACC_NOT_FOUND', to_char(p_zayid), to_char(nvl(l_zay.kv_conv, l_baseval)));
  end if;

  bars_audit.trace('%s custaccounts (%s, %s)', title,
                   l_cust_trdacc.accnum ||'/'|| to_char(l_cust_trdacc.curid),
                   l_cust_curacc.accnum ||'/'|| to_char(l_cust_curacc.curid));

    --данный блок должен работать только для не 2620
    begin
      select 1 into l_pr_2620 from accounts where acc = l_cust_curacc.accid and nbs = '2620' and ob22 = '05';
    exception when no_data_found then l_pr_2620 := 0;
    end;
    if l_pr_2620 = 0 and l_cust.codcagent not in (1,2) then
    begin
     -- смотрим, сколько счетов 3570 с Об22 = 03 на этом клиенте
     select count(*) into l_cnt_3570 from accounts where nbs = 3570 and ob22 = '03' and kv = 980 and rnk = l_zay.rnk and dazs is null;

     if l_cnt_3570 = 0 then
                            -- для заявки № %s не найден счет 3570 клиента (вообще, ни одного)
                            bars_error.raise_nerror (modcode, 'CUST_3570ACC_NOT_FOUND', to_char(p_zayid));
     elsif l_cnt_3570 = 1 then
                            -- найден однозначно один
                            select a.acc, a.nls, a.nms, a.kv, c.okpo
                              into l_cust_3570acc
                              from accounts a, customer c
                             where a.nbs = 3570 and a.ob22 = '03' and kv = 980 and a.rnk = l_zay.rnk and a.rnk = c.rnk and a.dazs is null;
     else
                            -- если найдено много - смотрим в доп.реквизите расчетного счета  l_cust_curacc
                           begin
                             select trim(value)
                               into l_val_3570
                               from accountsw
                              where acc = l_cust_curacc.accid and tag = 'C3570';
                           exception when no_data_found then
                                  --  для заявки № %s не указан 3570 клиента для р/с %s (%s)
                                  bars_error.raise_nerror (modcode, 'CUST_3570ACC_NOT_REGISTERED', to_char(p_zayid), to_char(l_cust_curacc.accnum), to_char(l_cust_curacc.curid));
                           end;
                           begin
                             select a.acc, a.nls, a.nms, a.kv, c.okpo
                               into l_cust_3570acc
                               from accounts a, customer c
                              where a.nls = l_val_3570 and a.nbs = 3570 and a.ob22 = '03' and kv = 980 and a.rnk = l_zay.rnk and a.rnk = c.rnk and a.dazs is null;
                           exception when no_data_found then
                                  --  для заявки № %s некорректно указан 3570 клиента для р/с %s (%s)
                                  bars_error.raise_nerror (modcode, 'CUST_3570ACC_ERR_REGISTERED', to_char(p_zayid), to_char(l_cust_curacc.accnum), to_char(l_cust_curacc.curid));
                           end;
     end if;
   end;
   end if;

  -- индивид.счет банка из пар-ров клиента для зачисления комиссии
  begin
    select nls_kom2
      into l_nlskom
      from cust_zay
     where rnk = l_zay.rnk
       and nls_kom2 is not null;
     begin
       l_bank_cmsacc := i_getaccparam (p_accid  => null,
                                       p_accnum => l_nlskom,
                                       p_curid  => gl.baseval);
     exception
       when no_data_found then null;
     end;
  exception
    when no_data_found then null;
  end;

  -- cумма заявленной валюты в номинале
  l_nom_amount := l_zay.s2;

  -- cумма заявленной валюты в эквиваленте по курсу дилера
  if l_zay.dk = 4 then
    -- продажа за валюту (конверсия)
    begin
      select kv_base into l_kv_base from zay_conv_kv where (kv1 = l_zay.kv2 and kv2 = l_zay.kv_conv) or (kv2 = l_zay.kv2 and kv1 = l_zay.kv_conv);
    exception when no_data_found then
        raise_application_error(-22222, 'Не описана базовая валюта для данной пары валют в конверсии!');
    end;
    -- обигрываем конверсию согласно курсам (валюта по отношению к валюте - пришлось определять понятие базовой валюты в паре)
    if l_zay.kv_conv = l_kv_base then
       l_eqv_amount := round(l_nom_amount / l_zay.kurs_f / power(10, 2) * 100);
    else
       l_eqv_amount := round(l_nom_amount * l_zay.kurs_f / power(10, 2) * 100);
    end if;
  else
    -- продажа за грн
    l_eqv_amount := round(l_nom_amount * l_zay.kurs_f / power(10, l_cur.dig) * 100);
  end if;

  -- сумма комиссии
  l_cms_amount := 0;
  if l_zay.kom > 0 then
     --l_cms_amount := gl.p_icurval(l_zay.kv2, round(l_nom_amount * l_zay.kom / 100), l_bdate);
     l_cms_amount := round( gl.p_icurval(l_zay.kv2, l_nom_amount * l_zay.kom, l_bdate)/100, 2);
     l_cms_detail := trim(to_char(l_zay.kom, 'fm990.9999'))
                   ||'% ('
                   ||trim(to_char(l_cms_amount/100, '99999999990.99'))
                   ||') '
                   ||bars_msg.get_msg (modcode, 'UAH');
  end if;
  if l_zay.skom > 0 then
     l_cms_amount := l_cms_amount + l_zay.skom * 100;
     if l_cms_detail is null then
        l_cms_detail := trim(to_char(l_zay.skom, '99999999990.99'))||' '||bars_msg.get_msg (modcode, 'UAH');
     else
        l_cms_detail := l_cms_detail ||' + ' ||trim(to_char(l_zay.skom, '99999999990.99'))||' '||bars_msg.get_msg (modcode, 'UAH');
     end if;
  end if;
  if l_zay.kom > 0 or l_zay.skom > 0 then
     l_cms_detail := bars_msg.get_msg(modcode, 'COMMISSION')||' '||l_cms_detail;
  end if;

  bars_audit.trace('%s amounts (nom, eqv, cms) = (%s, %s, %s)', title,
                   to_char(l_nom_amount), to_char(l_eqv_amount), to_char(l_cms_amount));

  -- назначение платежа
  select nvl(obz,0) into l_obz from zayavka where id = p_zayid;
  select nvl(nmkk, substr(nmk,1,38)), okpo into l_custname, l_okpo from customer where rnk = l_zay.rnk;

  if l_obz = 0 then
  if l_zay.dk = 4 then
  -- Зарахування коштів від продажу %s%s (курс %s) за іншу вал. зг.заяви клієнта %s від %sр. /%s/',
  -- Комісія банку ... грн.
  l_doc_details := substr(trim(bars_msg.get_msg(modcode,
                                                'SEL_DETAILS_CONV',
                                                trim(to_char(l_nom_amount/power(10, l_cur.dig), '99999999990.99')),
                                                l_cur.lcv,
                                                trim(to_char(l_zay.kurs_f,'fm999999990.00999999')),
                                                nvl(l_zay.nd, to_char(l_zay.id)),
                                                to_char(l_zay.fdat, 'dd.mm.yyyy'),
                                                l_custname)
                          ||' '||l_cms_detail), 1, 160);
  else
  -- Зарах.грн.від продажу %s %s по курсу %sгрн. зг.заяви клієнта на продаж №%s від %sр. /%s/
  -- Комісія банку ... грн.
  l_doc_details := substr(trim(bars_msg.get_msg(modcode,
                                                'SEL_DETAILS_SBER',
                                                trim(to_char(l_nom_amount/power(10, l_cur.dig), '99999999990.99')),
                                                l_cur.lcv,
                                                trim(to_char(l_zay.kurs_f,'fm999999990.00999999')),
                                                nvl(l_zay.nd, to_char(l_zay.id)),
                                                to_char(l_zay.fdat, 'dd.mm.yyyy'),
                                                l_custname)
                          ||' '||l_cms_detail), 1, 160);
  end if;
 else  --l_obz = 1
  -- Зарах. грн від обов.продажу %s %s по курсу %s грн. Заг.сума перек.%s %s. Ком.банку ... грн. Клієнт...

  l_doc_details := substr(trim(bars_msg.get_msg(modcode,
                                                'SEL_DETAILS_SBER_OBZ',
                                                trim(to_char(l_nom_amount/power(10, l_cur.dig), '99999999990.99')),
                                                l_cur.lcv,
                                                trim(to_char(l_zay.kurs_f,'fm999999990.00999999')),
                                                trim(to_char(l_zay.soper/power(10, l_cur.dig), '99999999990.99')),
                                                l_cur.lcv)
                          ||' '||l_cms_detail||' '||l_custname), 1, 160);
  end if;

  bars_audit.trace('%s details (cms,doc) = (%s, %s)', title, l_cms_detail, l_doc_details);

  if l_custmfo = l_mfo then
     -- зачисление вырученной гривны ВНУТРИБАНК
     select to_number(substr(flags, 38, 1)) into l_payflg from tts where tt = trd_tt;

   -- продажа за вал. (dk = 4)
   if l_zay.dk = 4 then
    --данный блок должен работать только для не 2620
    begin
      select 1 into l_pr_2620 from accounts where acc = l_cust_curacc.accid and nbs = '2620' and ob22 = '05';
    exception when no_data_found then l_pr_2620 := 0;
    end;
    if l_pr_2620 = 0 and l_cust.codcagent not in (1,2) then
     -- на расч.счет клиента зачисляется выруч.вал.
     if l_par = 1 and nvl(l_zay.ref_sps,0)<>0 then
     i_paydoc (p_flg     => l_payflg,
               p_sideA   => l_cust_curacc,
               p_sideB   => l_bank_trdaccNC,
               p_mfoB    => l_custmfo,
               p_vdat    => l_bdate,
               p_tt      => trd_tt,
               p_dk      => 0,
               p_vob     => nvl(p_vobFС,46),
               p_nd      => nvl(l_zay.nd, to_char(l_zay.id)),
               p_amount  => l_eqv_amount,
               p_details => l_doc_details,
               p_ref     => l_doc_ref);
     paytt (l_payflg, l_doc_ref,   l_bdate, vnt_tt, 1,
            l_cust_cmsacc.curid,   l_cust_cmsacc.accnum,   l_cms_amount,
            l_cust_3570acc.curid,  l_cust_3570acc.accnum,  l_cms_amount);
     paytt (l_payflg, l_doc_ref,   l_bdate, cms_tt, 1,
            l_cust_3570acc.curid,  l_cust_3570acc.accnum,  l_cms_amount,
            l_bank_cmsacc.curid,   l_bank_cmsacc.accnum,   l_cms_amount);
     else
     i_paydoc (p_flg     => l_payflg,
               p_sideA   => l_cust_curacc,
               p_sideB   => l_bank_trdaccNC,
               p_mfoB    => l_custmfo,
               p_vdat    => l_bdate,
               p_tt      => trd_tt,
               p_dk      => 0,
               p_vob     => nvl(p_vobFС,46),
               p_nd      => nvl(l_zay.nd, to_char(l_zay.id)),
               p_amount  => l_eqv_amount,
               p_details => l_doc_details,
               p_ref     => l_doc_ref);
     paytt (l_payflg, l_doc_ref,   l_bdate, frx_tt, 1,
            l_cust_trdacc.curid,   l_cust_trdacc.accnum,   l_nom_amount,
            l_bank_trdaccFC.curid, l_bank_trdaccFC.accnum, l_nom_amount);
     paytt (l_payflg, l_doc_ref,   l_bdate, vnt_tt, 1,
            l_cust_cmsacc.curid,   l_cust_cmsacc.accnum,   l_cms_amount,
            l_cust_3570acc.curid,  l_cust_3570acc.accnum,  l_cms_amount);
     paytt (l_payflg, l_doc_ref,   l_bdate, cms_tt, 1,
            l_cust_3570acc.curid,  l_cust_3570acc.accnum,  l_cms_amount,
            l_bank_cmsacc.curid,   l_bank_cmsacc.accnum,   l_cms_amount);
     end if;
    else
     if l_par = 1 and nvl(l_zay.ref_sps,0)<>0 then
     i_paydoc (p_flg     => l_payflg,
               p_sideA   => l_cust_curacc,
               p_sideB   => l_bank_trdaccNC,
               p_mfoB    => l_custmfo,
               p_vdat    => l_bdate,
               p_tt      => trd_tt,
               p_dk      => 0,
               p_vob     => nvl(p_vobFС,46),
               p_nd      => nvl(l_zay.nd, to_char(l_zay.id)),
               p_amount  => l_eqv_amount,
               p_details => l_doc_details,
               p_ref     => l_doc_ref);
     paytt (l_payflg, l_doc_ref,   l_bdate, cms_tt, 1,
            l_cust_cmsacc.curid,   l_cust_cmsacc.accnum,   l_cms_amount,
            l_bank_cmsacc.curid,   l_bank_cmsacc.accnum,   l_cms_amount);
     else
     i_paydoc (p_flg     => l_payflg,
               p_sideA   => l_cust_curacc,
               p_sideB   => l_bank_trdaccNC,
               p_mfoB    => l_custmfo,
               p_vdat    => l_bdate,
               p_tt      => trd_tt,
               p_dk      => 0,
               p_vob     => nvl(p_vobFС,46),
               p_nd      => nvl(l_zay.nd, to_char(l_zay.id)),
               p_amount  => l_eqv_amount,
               p_details => l_doc_details,
               p_ref     => l_doc_ref);
     paytt (l_payflg, l_doc_ref,   l_bdate, frx_tt, 1,
            l_cust_trdacc.curid,   l_cust_trdacc.accnum,   l_eqv_amount,
            l_bank_trdaccFC.curid, l_bank_trdaccFC.accnum, l_eqv_amount);
     paytt (l_payflg, l_doc_ref,   l_bdate, cms_tt, 1,
            l_cust_cmsacc.curid,   l_cust_cmsacc.accnum,   l_cms_amount,
            l_bank_cmsacc.curid,   l_bank_cmsacc.accnum,   l_cms_amount);
     end if;
   end if;

  -- продажа за грн. (dk = 2)
  else

    --данный блок должен работать только для не 2620
    begin
      select 1 into l_pr_2620 from accounts where acc = l_cust_curacc.accid and nbs = '2620' and ob22 = '05';
    exception when no_data_found then l_pr_2620 := 0;
    end;
    if l_pr_2620 = 0 and l_cust.codcagent not in (1,2) then
     -- на расч.счет клиента зачисляется выруч.гривна за вычетом комиссии (комиссия через 3570)
     if l_par = 1 and nvl(l_zay.ref_sps,0)<>0 then
     i_paydoc (p_flg     => l_payflg,
               p_sideA   => l_cust_curacc,
               p_sideB   => l_bank_trdaccNC,
               p_mfoB    => l_custmfo,
               p_vdat    => l_bdate,
               p_tt      => trd_tt,
               p_dk      => 0,
               p_vob     => nvl(p_vobNС,6),
               p_nd      => nvl(l_zay.nd, to_char(l_zay.id)),
               p_amount  => l_eqv_amount - l_cms_amount,
               p_details => l_doc_details,
               p_ref     => l_doc_ref);
     paytt (l_payflg, l_doc_ref,   l_bdate, vnt_tt, 1,
            l_bank_trdaccNC.curid, l_bank_trdaccNC.accnum, l_cms_amount,
            l_cust_3570acc.curid,  l_cust_3570acc.accnum,  l_cms_amount);
     paytt (l_payflg, l_doc_ref,   l_bdate, cms_tt, 1,
            l_cust_3570acc.curid,  l_cust_3570acc.accnum,  l_cms_amount,
            l_bank_cmsacc.curid,   l_bank_cmsacc.accnum,   l_cms_amount);
     else
     i_paydoc (p_flg     => l_payflg,
               p_sideA   => l_cust_curacc,
               p_sideB   => l_bank_trdaccNC,
               p_mfoB    => l_custmfo,
               p_vdat    => l_bdate,
               p_tt      => trd_tt,
               p_dk      => 0,
               p_vob     => nvl(p_vobNС,6),
               p_nd      => nvl(l_zay.nd, to_char(l_zay.id)),
               p_amount  => l_eqv_amount - l_cms_amount,
               p_details => l_doc_details,
               p_ref     => l_doc_ref);
     paytt (l_payflg, l_doc_ref,   l_bdate, frx_tt, 1,
            l_cust_trdacc.curid,   l_cust_trdacc.accnum,   l_nom_amount,
            l_bank_trdaccFC.curid, l_bank_trdaccFC.accnum, l_nom_amount);
     paytt (l_payflg, l_doc_ref,   l_bdate, vnt_tt, 1,
            l_bank_trdaccNC.curid, l_bank_trdaccNC.accnum, l_cms_amount,
            l_cust_3570acc.curid,  l_cust_3570acc.accnum,  l_cms_amount);
     paytt (l_payflg, l_doc_ref,   l_bdate, cms_tt, 1,
            l_cust_3570acc.curid,  l_cust_3570acc.accnum,  l_cms_amount,
            l_bank_cmsacc.curid,   l_bank_cmsacc.accnum,   l_cms_amount);
     end if;
    else
     if l_par = 1 and nvl(l_zay.ref_sps,0)<>0 then
     i_paydoc (p_flg     => l_payflg,
               p_sideA   => l_cust_curacc,
               p_sideB   => l_bank_trdaccNC,
               p_mfoB    => l_custmfo,
               p_vdat    => l_bdate,
               p_tt      => trd_tt,
               p_dk      => 0,
               p_vob     => nvl(p_vobNС,6),
               p_nd      => nvl(l_zay.nd, to_char(l_zay.id)),
               p_amount  => l_eqv_amount - l_cms_amount,
               p_details => l_doc_details,
               p_ref     => l_doc_ref);
     paytt (l_payflg, l_doc_ref,   l_bdate, cms_tt, 1,
            l_bank_trdaccNC.curid, l_bank_trdaccNC.accnum, l_cms_amount,
            l_bank_cmsacc.curid,   l_bank_cmsacc.accnum,   l_cms_amount);
     else
     i_paydoc (p_flg     => l_payflg,
               p_sideA   => l_cust_curacc,
               p_sideB   => l_bank_trdaccNC,
               p_mfoB    => l_custmfo,
               p_vdat    => l_bdate,
               p_tt      => trd_tt,
               p_dk      => 0,
               p_vob     => nvl(p_vobNС,6),
               p_nd      => nvl(l_zay.nd, to_char(l_zay.id)),
               p_amount  => l_eqv_amount - l_cms_amount,
               p_details => l_doc_details,
               p_ref     => l_doc_ref);
     paytt (l_payflg, l_doc_ref,   l_bdate, frx_tt, 1,
            l_cust_trdacc.curid,   l_cust_trdacc.accnum,   l_nom_amount,
            l_bank_trdaccFC.curid, l_bank_trdaccFC.accnum, l_nom_amount);
     paytt (l_payflg, l_doc_ref,   l_bdate, cms_tt, 1,
            l_bank_trdaccNC.curid, l_bank_trdaccNC.accnum, l_cms_amount,
            l_bank_cmsacc.curid,   l_bank_cmsacc.accnum,   l_cms_amount);
     end if;
   end if;
  end if;
     bars_audit.trace('%s ref(sel) = %s', title, to_char(l_doc_ref));
  else
     -- зачисление вырученной гривны МЕЖБАНК
     select to_number(substr(flags, 38, 1)), substr(nvl(nazn, l_doc_details), 1, 160)
       into l_payflg, l_doc_details
       from tts
      where tt = out_tt;
     if l_par = 1 and nvl(l_zay.ref_sps,0)<>0 then
     i_paydoc (p_flg     => l_payflg,
               p_sideA   => l_bank_trdaccNC,
               p_sideB   => l_cust_curacc,
               p_mfoB    => l_custmfo,
               p_vdat    => l_bdate,
               p_tt      => out_tt,
               p_dk      => 1,
               p_vob     => nvl(p_vobNС,6),
               p_nd      => nvl(l_zay.nd, to_char(l_zay.id)),
               p_amount  => l_eqv_amount - l_cms_amount,
               p_details => l_doc_details,
               p_ref     => l_doc_ref);
     paytt (l_payflg, l_doc_ref,   l_bdate, cms_tt, 1,
            l_bank_trdaccNC.curid, l_bank_trdaccNC.accnum, l_cms_amount,
            l_bank_cmsacc.curid,   l_bank_cmsacc.accnum,   l_cms_amount);
     else
     i_paydoc (p_flg     => l_payflg,
               p_sideA   => l_bank_trdaccNC,
               p_sideB   => l_cust_curacc,
               p_mfoB    => l_custmfo,
               p_vdat    => l_bdate,
               p_tt      => out_tt,
               p_dk      => 1,
               p_vob     => nvl(p_vobNС,6),
               p_nd      => nvl(l_zay.nd, to_char(l_zay.id)),
               p_amount  => l_eqv_amount - l_cms_amount,
               p_details => l_doc_details,
               p_ref     => l_doc_ref);
     paytt (l_payflg, l_doc_ref,   l_bdate, frx_tt, 1,
            l_cust_trdacc.curid,   l_cust_trdacc.accnum,   l_nom_amount,
            l_bank_trdaccFC.curid, l_bank_trdaccFC.accnum, l_nom_amount);
     paytt (l_payflg, l_doc_ref,   l_bdate, cms_tt, 1,
            l_bank_trdaccNC.curid, l_bank_trdaccNC.accnum, l_cms_amount,
            l_bank_cmsacc.curid,   l_bank_cmsacc.accnum,   l_cms_amount);
     end if;
     bars_audit.trace('%s ref(sel) = %s', title, to_char(l_doc_ref));
  end if;

if nvl(l_cms_amount,0)<>0 then
  -- Маркирование проводок по комиссии  общебанковскими кодами тарифов
  if l_zay.dk = 4 then
     case
       when l_eqv_amount/100  <=10000   then i_insdocparam (l_doc_ref, 'KTAR', to_char('231'));
       when l_eqv_amount/100 > 10000   and l_eqv_amount/100 <=100000  then i_insdocparam (l_doc_ref, 'KTAR', to_char('232'));
       when l_eqv_amount/100 > 100000 and l_eqv_amount/100 <=1000000 then i_insdocparam (l_doc_ref, 'KTAR', to_char('233'));
       when l_eqv_amount/100 > 1000000 then i_insdocparam (l_doc_ref, 'KTAR', to_char('234'));
      end case;
  else
     case
       when l_eqv_amount/100 <=10000  then i_insdocparam (l_doc_ref, 'KTAR', to_char('227'));
       when l_eqv_amount/100 > 10000   and l_eqv_amount/100<=100000  then i_insdocparam (l_doc_ref, 'KTAR', to_char('228'));
       when l_eqv_amount/100 > 100000 and l_eqv_amount/100<=1000000 then i_insdocparam (l_doc_ref, 'KTAR', to_char('229'));
       when l_eqv_amount/100 > 1000000 then i_insdocparam (l_doc_ref, 'KTAR', to_char('230'));
      end case;
  end if;
end if;

  -- заполнение доп.реквизитов документа для 27-го, 39-го и 70-го файлов
  i_setdocparams (p_ref     => l_doc_ref,
                  p_zayrow  => l_zay,
                  p_nominal => l_cur.nominal,
                  p_d#39    => p_indx39);

  -- заполнение реквизита для тех, у кого нет ОКПО
  if l_okpo = '0000000000' then
      begin
        select ser||' '||to_char(numdoc) into l_value from person where passp = 1 and rnk = l_zay.rnk;
      exception when no_data_found then null;
      end;
      set_operw ( l_doc_ref, 'Ф    ', l_value);
      update oper set d_rec = '#Ф'||l_value||'#' where ref = l_doc_ref;
  end if;


  update zayavka set sos = 2, ref = l_doc_ref where id = l_zay.id;

  p_selref := l_doc_ref;

  bars_audit.trace('%s exit with %s', title, to_char(p_selref));

exception
  when bars_error.err then
    raise;
--  when others then
--    bars_error.raise_nerror (modcode, 'PAYSEL_FAILED', to_char(l_zay.id), sqlerrm);

end pay_selling;

-------------------------------------------------------------------------------
--
-- формирование документа по списанию средств в заявке на продажу валюты
--
procedure pay_selling_sps
   (p_zayid   in   zayavka.id%type,          -- идентификатор заявки
    p_vob     in   vob.vob%type default 6,   -- вид мемориального ордера
    p_selref  out  oper.ref%type             -- референс списания валюты
    )
is
  title           varchar2(60)   := 'zay.paysel_sps:';
  l_baseval       tabval.kv%type := gl.baseval;
  l_bdate         date           := gl.bdate;
  l_mfo           banks.mfo%type := gl.amfo;
  l_zay           zayavka%rowtype;
  l_cur           tabval%rowtype;
  l_custname      customer.nmkk%type;
  l_okpo          customer.okpo%type;
  l_value         varchar2(10);
  -- внутрибанк.счета
  l_bank_trdaccFC t_accrec;
  l_bank_trdaccNC t_accrec;
  l_bank_cmsacc   t_accrec;
  l_bank_taxacc   t_accrec;
  -- клиентск.счета
  l_cust_trdacc   t_accrec;
  l_cust_trdaccNC t_accrec;
  l_cust_trdaccFC t_accrec;
  l_cust_curacc   t_accrec;
  l_custmfo       zayavka.mfo0%type;
  -- суммы и назначение платежей
  l_nom_amount    number(38);
  l_eqv_amount    number(38);
  l_cms_amount    number(38);
  l_cms_detail    oper.nazn%type;
  l_doc_details   oper.nazn%type;
  l_payflg        number(1);
  l_doc_ref       oper.ref%type;
  l_nlskom        cust_zay.nls_kom%type;
  l_obz           zayavka.obz%type;
  l_nlsNC         accounts.nls%type;
  l_tmpn          number;
  l_tmp_accnum    varchar2(2000);
begin

  bars_audit.trace('%s entry, zayid=>%s, vob=>%s', title,
                   to_char(p_zayid), to_char(p_vob));

  bars_msg.set_lang ('UKR');

  -- параметры заявки
  begin
    select * into l_zay from zayavka where id = p_zayid for update of sos nowait;
  exception
    when no_data_found then
      -- не найдена заявка № %s
      bars_error.raise_nerror (modcode, 'ZAY_NOT_FOUND', to_char(p_zayid));
  end;

  -- проверка "готовности" заявки
  if l_zay.sos != 1 and nvl(l_zay.ref_sps,0)<>0 then
     -- запрещено формирование документа списания по заявке № %s
     bars_error.raise_nerror (modcode, 'INVALID_STATUS_SPS', to_char(p_zayid));
  end if;
  if l_zay.vdate > l_bdate then
     -- запрещено формирование пакета документов по форвардной заявке № %s(дата валютир.и %s)
     bars_error.raise_nerror (modcode, 'INVALID_VALUEDATE', to_char(p_zayid), to_char(l_zay.vdate, 'dd.mm.yyyy'));
  end if;

  -- параметры валюты
  begin
    select * into l_cur from tabval where kv = l_zay.kv2;
  exception
    when no_data_found then
      -- не найдена валюта с кодом %s
      bars_error.raise_nerror (modcode, 'CUR_NOT_FOUND', to_char(l_zay.kv2));
  end;

  l_custmfo := nvl(l_zay.mfo0, l_mfo);
  select nvl(nmkk, substr(nmk,1,38)), okpo into l_custname, l_okpo from customer where rnk = l_zay.rnk;


  -- определение внутрибанк.счетов для всех проводок пакета документов по заявке
  -- вариант, предложенный Лесняком С.Б.
  l_bank_trdaccFC.accid := null;
  select to_number(substr(flags, 38, 1)), nlsb, mfob into l_payflg, l_tmp_accnum, l_custmfo from tts where tt = frx_tt;

  if l_tmp_accnum like '#(%' then
    execute immediate 'select '||substr(l_tmp_accnum,3,length(l_tmp_accnum)-3)||' from dual' into l_bank_trdaccFC.accnum;
  else
    l_bank_trdaccFC.accnum := l_tmp_accnum;
  end if;
  --l_bank_trdaccFC.accname := 'ГОУ АТ Ощадбанк';
  -- поскольку во всех РУ-шках ЦА зарегистрирован как банки - оттуда найдем и ОКПО с названием
     begin
       select c.nmk, c.okpo  into l_bank_trdaccFC.accname, l_bank_trdaccFC.custcode
         from customer c, custbank b
        where b.mfo = '300465'
          and b.rnk = c.rnk and rownum=1;
     exception when no_data_found then
          raise_application_error(-20000, 'Не знайдено ОКПО ЦА!');
     end;
  l_bank_trdaccFC.curid := l_zay.kv2;
  --l_bank_trdaccFC.custcode := '00032129';


  -- торговый счет клиента в ин.валюте
  begin
    l_cust_trdacc := i_getaccparam (p_accid  => l_zay.acc1,
                                    p_accnum => null,
                                    p_curid  => null);
  exception
    when no_data_found then
      -- для заявки № %s не найден торговый счет клиента в валюте %s (acc = %s)
      bars_error.raise_nerror (modcode, 'CUST_TRDACC_NOT_FOUND', to_char(p_zayid), to_char(l_zay.kv2), to_char(l_zay.acc1));
  end;

  -- cумма заявленной валюты в номинале
  l_nom_amount := l_zay.s2;

  -- cумма заявленной валюты в эквиваленте по курсу дилера
  l_eqv_amount := round(l_nom_amount * l_zay.kurs_f / power(10, l_cur.dig) * 100);


  -- назначение платежа
  select nvl(obz,0) into l_obz from zayavka where id = p_zayid;

  -- Перерахування коштів на продаж %s %s зг.заяви клієнта на продаж №%s від %sр.
  l_doc_details := substr(trim(bars_msg.get_msg(modcode,
                                                case when l_zay.obz=1 then 'SEL_DETAILS_SPS_OBZ' else 'SEL_DETAILS_SPS' end,
                                                trim(to_char(l_nom_amount/power(10, l_cur.dig), '99999999990.99')),
                                                l_cur.lcv,
                                                nvl(l_zay.nd, to_char(l_zay.id)),
                                                to_char(l_zay.fdat, 'dd.mm.yyyy'))), 1, 160);

  select to_number(substr(flags, 38, 1)) into l_payflg from tts where tt = frx_tt; --!!!

     i_paydoc (p_flg     => l_payflg,
               p_sideA   => l_cust_trdacc,
               p_sideB   => l_bank_trdaccFC,
               p_mfoB    => l_custmfo,
               p_vdat    => l_bdate,
               p_tt      => frx_tt,
               p_dk      => 1,
               p_vob     => nvl(p_vob,6),
               p_nd      => nvl(l_zay.nd, to_char(l_zay.id)),
               p_amount  => l_nom_amount,
               p_details => l_doc_details,
               p_ref     => l_doc_ref);

     bars_audit.trace('%s ref(sel) = %s', title, to_char(l_doc_ref));

  -- заполнение реквизита для тех, у кого нет ОКПО
  if l_okpo = '0000000000' then
      begin
        select ser||' '||to_char(numdoc) into l_value from person where passp = 1 and rnk = l_zay.rnk;
      exception when no_data_found then null;
      end;
      set_operw ( l_doc_ref, 'Ф    ', l_value);
      update oper set d_rec = '#Ф'||l_value||'#' where ref = l_doc_ref;
  end if;

  update zayavka set ref_sps = l_doc_ref where id = l_zay.id;

  p_selref := l_doc_ref;

  bars_audit.trace('%s exit with %s', title, to_char(p_selref));

exception
  when bars_error.err then
    raise;
--  when others then
--    bars_error.raise_nerror (modcode, 'PAYSEL_FAILED', to_char(l_zay.id), sqlerrm);

end pay_selling_sps;

-------------------------------------------------------------------------------
--
-- Создаём запись в протоколе взаимодействия
--
procedure p_data_transfer (p_req_id in zay_data_transfer.req_id%type,
                           p_url    in zay_data_transfer.url%type,
                           p_mfo    in zay_data_transfer.mfo%type,
                           p_type   in zay_data_transfer.transfer_type%type,
                           p_date   in zay_data_transfer.transfer_date%type,
                           p_result in zay_data_transfer.transfer_result%type,
                           p_comm   in zay_data_transfer.comm%type
                           )
is
  l_trace varchar2(500):='bars_zay. p_data_transfer';
begin
  bars_audit.info(l_trace||'.'||p_req_id||'.'||p_url||'.'|| p_result);
  insert into zay_data_transfer
   (id,
    req_id,
    url,
    mfo,
    transfer_type,
    transfer_date,
    transfer_result,
    comm)
  values
     (bars_sqnc.get_nextval('s_zay_data_transfer'),
    p_req_id,
    p_url,
    p_mfo,
    p_type,
    p_date,
    p_result,
    p_comm);
end p_data_transfer;

-------------------------------------------------------------------------------
--
-- создание прохождения заявки на покупку/продажу валюты через вебсервис на стороне ЦА
--
procedure service_track_request(p_reqest_id in zayavka.id%type) is
  l_vzay_track v_zay_track%rowtype;
  l_track_id   number;
  l_mfo        varchar2(10);
  l_sos        zayavka.sos%type;
  l_request    soap_rpc.t_request;
  l_response   soap_rpc.t_response;
  l_clob       clob;
  l_error      varchar2(2000);
  l_parser     dbms_xmlparser.parser;
  l_doc        dbms_xmldom.domdocument;
  l_reslist    dbms_xmldom.DOMNodeList;
  l_res        dbms_xmldom.DOMNode;
  l_str        varchar2(2000);
  l_status     varchar2(100);
  l_tmp        xmltype;
  ret_         varchar2(256);
  l_url        varchar2(256);
  l_type       number :=7;
  l_comm       varchar2(256);
  l_trace varchar2(500):='bars_zay.service_track_request';
begin
  select max(v.track_id)
    into l_track_id
  from v_zay_track v
  where v.id = p_reqest_id;

  select v.*
    into l_vzay_track
  from v_zay_track v
  where v.id = p_reqest_id
    and v.track_id = l_track_id;

  select mfo,sos into l_mfo,l_sos from v_zay where id = p_reqest_id;
  select url into l_url from zay_recipients where kf = sys_context('bars_context','user_mfo');

  l_request := soap_rpc.new_request(p_url         => l_url,
                                    p_namespace   => 'http://tempuri.org/',
                                    p_method      => 'SetTrack',
                                    p_wallet_dir  => gWallet_dir,
                                    p_wallet_pass => gWallet_pass);
        -- добавить параметры
  soap_rpc.add_parameter(l_request, 'mfo', l_mfo);
  soap_rpc.add_parameter(l_request,
                         'track_id',
                          to_char(l_vzay_track.track_id));
  soap_rpc.add_parameter(l_request,
                         'req_id',
                          to_char(l_vzay_track.id));
  soap_rpc.add_parameter(l_request,
                         'change_time',
                          to_char(l_vzay_track.change_time,'dd.mm.yyyy hh24:mi:ss'));
  soap_rpc.add_parameter(l_request,
                         'fio',
                          encode_base64(l_vzay_track.fio));
  soap_rpc.add_parameter(l_request, 'sos', to_char(l_sos));
  soap_rpc.add_parameter(l_request,
                               'viza',
                               to_char(l_vzay_track.viza));
  soap_rpc.add_parameter(l_request,
                         'viza_name',
                          encode_base64(l_vzay_track.viza_name));

  l_response := soap_rpc.invoke(l_request);

  --разбираем ответ
  l_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
  l_tmp  := xmltype(l_clob);

  ret_ := extract(l_tmp,
                  '/SetTrackResponse/SetTrackResult/text()',
                   null);

  l_clob   := l_response.doc.getClobVal();
  l_parser := dbms_xmlparser.newparser;
  dbms_xmlparser.parseclob(l_parser, l_clob);
  l_doc     := dbms_xmlparser.getdocument(l_parser);
  l_reslist := dbms_xmldom.getelementsbytagname(l_doc,
                                                      'SetTrackResult');
  l_res     := dbms_xmldom.item(l_reslist, 0);
  dbms_xslprocessor.valueof(l_res, 'Status/text()', l_str);
  l_status := substr(l_str, 1, 200);

  if l_status != 'ok' then
    dbms_xslprocessor.valueof(l_res, 'ErrorMessage/text()', l_str);

    p_data_transfer(p_req_id => l_vzay_track.id,
                    p_url    => l_url,
                    p_mfo    => l_mfo,
                    p_type   => l_type,
                    p_date   => sysdate,
                    p_result => gTransfer_eroor,
                    p_comm   => 'ERR проходження заявки = ' || substr(l_str, 1, 900));
  else
    l_comm := 'Інформацію щодо історії проходження заявки (№ ' ||
               p_reqest_id|| ') успішно передано до ЦА';
    p_data_transfer(p_req_id => l_vzay_track.id,
                    p_url    => l_url,
                    p_mfo    => l_mfo,
                    p_type   => l_type,
                    p_date   => sysdate,
                    p_result => gTransfer_success,
                    p_comm   => l_comm);
  end if;
  dbms_xmlparser.freeparser(l_parser);
  DBMS_XMLDOM.freeDocument(l_doc);
  bars_audit.info(l_trace||'.1.'||l_clob);
  end service_track_request;

  -------------------------------------------------------------------------------
  --
  -- создание заявки на покупку/продажу валюты через вебсервис на стороне ЦА
  --
  procedure service_request(p_reqest_id in zayavka.id%type,
                            p_flag_klb  in number default 0) is
  l_vzay       v_zay%rowtype;
  l_vzay_track v_zay_track%rowtype;
  l_track_id   number;
  l_mfo        varchar2(10);
  l_request       soap_rpc.t_request;
  l_response      soap_rpc.t_response;
  l_clob          clob;
  l_error         varchar2(2000);
  l_parser        dbms_xmlparser.parser;
  l_doc           dbms_xmldom.domdocument;
  l_reslist       dbms_xmldom.DOMNodeList;
  l_res           dbms_xmldom.DOMNode;
  l_str           varchar2(2000);
  l_status        varchar2(100);
  l_tmp           xmltype;
  ret_            varchar2(256);
  l_url           varchar2(256);
  l_flag          number;
  l_type          number;
  l_comm          varchar2(256);
  l_trace varchar2(500):='bars_zay.service_request';
begin

  bars_audit.info(l_trace||'.1.'||p_reqest_id||'.'||p_flag_klb);
  -- web-сервис
  select VAL into l_mfo from params where par = 'MFO';
  select v.* into l_vzay from v_zay v where v.id = p_reqest_id;
  select z.url into l_url from zay_recipients z where z.kf = sys_context('bars_context','user_mfo');

if l_vzay.MFO<>'300465' then

  if p_flag_klb in (2,3,4) then
    l_flag := p_flag_klb;

    if l_flag = 2 then
      l_type := 8;
      l_comm := 'Інформацію про внесення змін до заявки (№ '||l_vzay.id||') успішно передано до ЦА';
    elsif l_flag = 3 then
      l_comm := 'Інформацію про візування заявки (№ '||l_vzay.id||') успішно передано до ЦА';
      l_type := 9;
    elsif l_flag = 4 then
          l_comm := 'Інформацію про створення заявки (№ ' || l_vzay.id ||') успішно передано до ЦА';
          l_type := 9;
    end if;
  else
    l_type := 2;
    l_flag := 1;
    l_comm := 'Інформацію про створення заявки (№ '||l_vzay.id||') успішно передано до ЦА';
  end if;
  l_request := soap_rpc.new_request(p_url       => l_url,
                                    p_namespace => 'http://tempuri.org/',
                                    p_method    => 'SetRequest',
                                    p_wallet_dir =>  gWallet_dir,
                                    p_wallet_pass => gWallet_pass);
  -- добавить параметры
  soap_rpc.add_parameter(l_request, 'flag', to_char(l_flag));
  if l_mfo is not null then
    soap_rpc.add_parameter(l_request, 'mfo', encode_base64(l_mfo));
  end if;
  if l_vzay.id is not null then
    soap_rpc.add_parameter(l_request, 'id', to_char(l_vzay.id));
  end if;
  if l_vzay.dk is not null then
    soap_rpc.add_parameter(l_request, 'dk', to_char(l_vzay.dk));
  end if;
  if l_vzay.obz is not null then
    soap_rpc.add_parameter(l_request, 'obz', replace(to_char(l_vzay.obz),',','.'));
  end if;
  if l_vzay.nd is not null then
    soap_rpc.add_parameter(l_request, 'nd', encode_base64(l_vzay.nd));
  end if;
  if l_vzay.fdat is not null then
        soap_rpc.add_parameter(l_request,
                               'fdat',
                               to_char(l_vzay.fdat, 'dd.mm.yyyy'));
  end if;
  if l_vzay.datt is not null then
        soap_rpc.add_parameter(l_request,
                               'datt',
                               to_char(l_vzay.datt, 'dd.mm.yyyy'));
  end if;
  if l_vzay.rnk is not null then
    soap_rpc.add_parameter(l_request, 'rnk', to_char(l_vzay.rnk));
  end if;
  if l_vzay.nmk is not null then
    soap_rpc.add_parameter(l_request, 'nmk', encode_base64(l_vzay.nmk));
  end if;
  if l_vzay.nd_rnk is not null then
        soap_rpc.add_parameter(l_request,
                               'nd_rnk',
                               encode_base64(l_vzay.nd_rnk));
  end if;
  if l_vzay.kv_conv is not null then
        soap_rpc.add_parameter(l_request,
                               'kv_conv',
                               to_char(l_vzay.kv_conv));
  end if;
  if l_vzay.lcv_conv is not null then
        soap_rpc.add_parameter(l_request,
                               'lcv_conv',
                               encode_base64(to_char(l_vzay.lcv_conv)));
  end if;
  if l_vzay.kv2 is not null then
  soap_rpc.add_parameter(l_request, 'kv2', to_char(l_vzay.kv2));
  end if;
  if l_vzay.lcv is not null then
    soap_rpc.add_parameter(l_request, 'lcv', encode_base64(l_vzay.lcv));
  end if;
  if l_vzay.dig is not null then
    soap_rpc.add_parameter(l_request, 'dig', replace(to_char(l_vzay.dig),',','.'));
  end if;
  if l_vzay.s2 is not null then
    soap_rpc.add_parameter(l_request, 's2', replace(to_char(l_vzay.s2),',','.'));
  end if;
  if l_vzay.s2s is not null then
    soap_rpc.add_parameter(l_request, 's2s', replace(to_char(l_vzay.s2s),',','.'));
  end if;
  if l_vzay.s3 is not null then
    soap_rpc.add_parameter(l_request, 's3', replace(to_char(l_vzay.s3),',','.'));
  end if;
  if l_vzay.kom is not null then
    soap_rpc.add_parameter(l_request, 'kom', replace(to_char(l_vzay.kom),',','.'));
  end if;
  if l_vzay.skom is not null then
    soap_rpc.add_parameter(l_request, 'skom', replace(to_char(l_vzay.skom),',','.'));
  end if;
  if l_vzay.kurs_z is not null then
    soap_rpc.add_parameter(l_request, 'kurs_z', replace(to_char(l_vzay.kurs_z),',','.'));
  end if;
  if l_vzay.kurs_f is not null then
    soap_rpc.add_parameter(l_request, 'kurs_f', replace(to_char(l_vzay.kurs_f),',','.'));
  end if;
  if l_vzay.vdate is not null then
        soap_rpc.add_parameter(l_request,
                               'vdate',
                               to_char(l_vzay.vdate, 'dd.mm.yyyy'));
  end if;
  if l_vzay.datz is not null then
        soap_rpc.add_parameter(l_request,
                               'datz',
                               to_char(l_vzay.datz, 'dd.mm.yyyy'));
  end if;
  if l_vzay.acc0 is not null then
    soap_rpc.add_parameter(l_request, 'acc0', to_char(l_vzay.acc0));
  end if;
  if l_vzay.nls_acc0 is not null then
    soap_rpc.add_parameter(l_request,
                           'nls_acc0',
                            encode_base64(l_vzay.nls_acc0));
  end if;
  if l_vzay.mfo0 is not null then
    soap_rpc.add_parameter(l_request,
                           'mfo0',
                            encode_base64(l_vzay.mfo0));
  end if;
  if l_vzay.nls0 is not null then
    soap_rpc.add_parameter(l_request,
                           'nls0',
                           encode_base64(l_vzay.nls0));
  end if;
  if l_vzay.okpo0 is not null then
    soap_rpc.add_parameter(l_request,
                           'okpo0',
                            encode_base64(l_vzay.okpo0));
  end if;
  if l_vzay.ostc0 is not null then
    soap_rpc.add_parameter(l_request, 'ostc0', replace(to_char(l_vzay.ostc0),',','.'));
  end if;
  if l_vzay.acc1 is not null then
    soap_rpc.add_parameter(l_request, 'acc1', to_char(l_vzay.acc1));
  end if;
  if l_vzay.ostc is not null then
    soap_rpc.add_parameter(l_request, 'ostc', replace(to_char(l_vzay.ostc),',','.'));
  end if;
  if l_vzay.nls is not null then
    soap_rpc.add_parameter(l_request, 'nls', encode_base64(l_vzay.nls));
  end if;
  if l_vzay.sos is not null then
    soap_rpc.add_parameter(l_request, 'sos', replace(to_char(l_vzay.sos),',','.'));
  end if;
  if l_vzay.ref is not null then
    soap_rpc.add_parameter(l_request, 'ref', to_char(l_vzay.ref));
  end if;
  if l_vzay.viza is not null then
    soap_rpc.add_parameter(l_request, 'viza', replace(to_char(l_vzay.viza),',','.'));
  end if;
  if l_vzay.priority is not null then
    soap_rpc.add_parameter(l_request, 'priority', replace(to_char(l_vzay.priority),',','.'));
  end if;
  if l_vzay.priorname is not null then
    soap_rpc.add_parameter(l_request,
                           'priorname',
                            encode_base64(l_vzay.priorname));
  end if;
      if l_vzay.priorverify is not null then
      soap_rpc.add_parameter(l_request,
                             'priorverify',
                             replace(to_char(l_vzay.priorverify),',','.'));
      end if;
  if l_vzay.idback is not null then
    soap_rpc.add_parameter(l_request, 'idback', to_char(l_vzay.idback));
  end if;
      if l_vzay.fl_pf is not null then
  soap_rpc.add_parameter(l_request, 'fl_pf', replace(to_char(l_vzay.fl_pf),',','.'));
      end if;
  if l_vzay.mfop is not null then
    soap_rpc.add_parameter(l_request,
                           'mfop',
                            encode_base64(l_vzay.mfop));
  end if;
  if l_vzay.nlsp is not null then
    soap_rpc.add_parameter(l_request,
                           'nlsp',
                            encode_base64(l_vzay.nlsp));
  end if;
  if l_vzay.okpop is not null then
    soap_rpc.add_parameter(l_request,
                           'okpop',
                            encode_base64(l_vzay.okpop));
  end if;
  if l_vzay.rnk_pf is not null then
    soap_rpc.add_parameter(l_request,
                           'rnk_pf',
                            encode_base64(l_vzay.rnk_pf));
  end if;
  if l_vzay.pid is not null then
    soap_rpc.add_parameter(l_request, 'pid', replace(to_char(l_vzay.pid),',','.'));
  end if;
  if l_vzay.contract is not null then
    soap_rpc.add_parameter(l_request,
                           'contract',
                           encode_base64(l_vzay.contract));
  end if;
  if l_vzay.dat2_vmd is not null then
    soap_rpc.add_parameter(l_request,
                           'dat2_vmd',
                           to_char(l_vzay.dat2_vmd, 'dd.mm.yyyy'));
  end if;
  if l_vzay.meta is not null then
    soap_rpc.add_parameter(l_request, 'meta', replace(to_char(l_vzay.meta),',','.'));
  end if;
  if l_vzay.aim_name is not null then
    soap_rpc.add_parameter(l_request,
                   'aim_name',
                            encode_base64(l_vzay.aim_name));
  end if;
  if l_vzay.basis is not null then
    soap_rpc.add_parameter(l_request,
                           'basis',
                            encode_base64(l_vzay.basis));
  end if;
  if l_vzay.product_group is not null then
    soap_rpc.add_parameter(l_request,
                           'product_group',
                            encode_base64(l_vzay.product_group));
  end if;
  if l_vzay.product_group_name is not null then
    soap_rpc.add_parameter(l_request,
                           'product_group_name',
                            encode_base64(l_vzay.product_group_name));
  end if;
  if l_vzay.num_vmd is not null then
    soap_rpc.add_parameter(l_request,
                           'num_vmd',
                            encode_base64(l_vzay.num_vmd));
  end if;
  if l_vzay.dat_vmd is not null then
    soap_rpc.add_parameter(l_request,
                           'dat_vmd',
                            to_char(l_vzay.dat_vmd, 'dd.mm.yyyy'));
  end if;
  if l_vzay.dat5_vmd is not null then
    soap_rpc.add_parameter(l_request,
                           'dat5_vmd',
                            encode_base64(l_vzay.dat5_vmd));
  end if;
  if l_vzay.country is not null then
    soap_rpc.add_parameter(l_request,
                           'country',
                            to_char(l_vzay.country));
  end if;
  if l_vzay.benefcountry is not null then
    soap_rpc.add_parameter(l_request,
                           'benefcountry',
                           to_char(l_vzay.benefcountry));
  end if;
  if l_vzay.bank_code is not null then
    soap_rpc.add_parameter(l_request,
                           'bank_code',
                            encode_base64(l_vzay.bank_code));
  end if;
  if l_vzay.bank_name is not null then
    soap_rpc.add_parameter(l_request,
                           'bank_name',
                            encode_base64(l_vzay.bank_name));
  end if;
  if l_vzay.userid is not null then
    soap_rpc.add_parameter(l_request, 'userid', to_char(l_vzay.userid));
  end if;
  if l_vzay.branch is not null then
    soap_rpc.add_parameter(l_request,
                           'branch',
                            encode_base64(l_vzay.branch));
  end if;
  if l_vzay.fl_kursz is not null then
        soap_rpc.add_parameter(l_request,
                               'fl_kursz',
                               replace(to_char(l_vzay.fl_kursz),',','.'));
  end if;
  if l_vzay.identkb is not null then
    soap_rpc.add_parameter(l_request,
                           'identkb',
                            encode_base64(l_vzay.identkb));
  end if;
  if l_vzay.comm is not null then
    soap_rpc.add_parameter(l_request,
                           'comm',
                            encode_base64(l_vzay.comm));
  end if;
  if l_vzay.cust_branch is not null then
    soap_rpc.add_parameter(l_request,
                           'cust_branch',
                            encode_base64(l_vzay.cust_branch));
  end if;
  if l_vzay.kurs_kl is not null then
    soap_rpc.add_parameter(l_request,
                           'kurs_kl',
                            encode_base64(l_vzay.kurs_kl));
  end if;
  if l_vzay.contact_fio is not null then
    soap_rpc.add_parameter(l_request,
                           'contact_fio',
                            encode_base64(l_vzay.contact_fio));
  end if;
  if l_vzay.contact_tel is not null then
    soap_rpc.add_parameter(l_request,
                           'contact_tel',
                            encode_base64(l_vzay.contact_tel));
  end if;
  if l_vzay.verify_opt is not null then
    soap_rpc.add_parameter(l_request,
                           'verify_opt',
                           replace(to_char(l_vzay.verify_opt),',','.'));
  end if;
  if l_vzay.close_type is not null then
    soap_rpc.add_parameter(l_request,
                           'close_type',
                            replace(to_char(l_vzay.close_type),',','.'));
  end if;
  if l_vzay.close_type_name is not null then
    soap_rpc.add_parameter(l_request,
                           'close_type_name',
                            encode_base64(l_vzay.close_type_name));
  end if;
  if l_vzay.aims_code is not null then
    soap_rpc.add_parameter(l_request,
                           'aims_code',
                            replace(to_char(l_vzay.aims_code),',','.'));
  end if;
  if l_vzay.s_pf is not null then
    soap_rpc.add_parameter(l_request, 's_pf', replace(to_char(l_vzay.s_pf),',','.'));
  end if;
  if l_vzay.ref_pf is not null then
    soap_rpc.add_parameter(l_request, 'ref_pf', to_char(l_vzay.ref_pf));
  end if;
  if l_vzay.ref_sps is not null then
    soap_rpc.add_parameter(l_request,
                           'ref_sps',
                           to_char(l_vzay.ref_sps));
  end if;
  if l_vzay.start_time is not null then
    soap_rpc.add_parameter(l_request,
                           'start_time',
                            to_char(l_vzay.start_time, 'dd.mm.yyyy hh24:mi:ss'));
  end if;
  if l_vzay.state is not null then
    soap_rpc.add_parameter(l_request,
                           'state',
                            encode_base64(l_vzay.state));
  end if;
  if l_vzay.operid_nokk is not null then
    soap_rpc.add_parameter(l_request,
                           'operid_nokk',
                            encode_base64(to_char(l_vzay.operid_nokk)));
  end if;
  if l_vzay.req_type is not null then
    soap_rpc.add_parameter(l_request,
                           'req_type',
                           replace(to_char(l_vzay.req_type),',','.'));
  end if;
  if l_vzay.vdate_plan is not null then
    soap_rpc.add_parameter(l_request,
                           'vdate_plan',
                           to_char(l_vzay.vdate_plan, 'dd.mm.yyyy'));
  end if;
  if l_vzay.custtype is not null then
    soap_rpc.add_parameter(l_request,
                           'custtype',
                            to_char(l_vzay.custtype));
  end if;


  -- позвать метод веб-сервиса
  begin
    l_response := soap_rpc.invoke(l_request);

    --разбираем ответ
    l_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
    l_tmp  := xmltype(l_clob);

    ret_ := extract(l_tmp,
                    '/SetRequestResponse/SetRequestResult/text()',
                    null);

    l_clob := l_response.doc.getClobVal();
    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, l_clob);
    l_doc := dbms_xmlparser.getdocument(l_parser);
    l_reslist := dbms_xmldom.getelementsbytagname(l_doc,
                                                  'SetRequestResult');
    l_res     := dbms_xmldom.item(l_reslist, 0);
    dbms_xslprocessor.valueof(l_res, 'Status/text()', l_str);
    l_status := substr(l_str, 1, 200);

    if l_status = 'error' then
      dbms_xslprocessor.valueof(l_res, 'ErrorMessage/text()', l_str);
bars_audit.info(l_trace||'.2.'||l_vzay.id||'.'||l_url);
      p_data_transfer (p_req_id => l_vzay.id,
                       p_url    => l_url,
                       p_mfo    => l_mfo,
                       p_type   => l_type,
                       p_date   => sysdate,
                       p_result => gTransfer_eroor,
                       p_comm   => 'error = ' || substr(l_str, 1, 1000));
        elsif l_status <> 'ok' then
          p_data_transfer(p_req_id => l_vzay.id,
                          p_url    => l_url,
                          p_mfo    => l_mfo,
                          p_type   => l_type,
                          p_date   => sysdate,
                          p_result => gTransfer_eroor,
                          p_comm   => 'Необрабатываемое значение статуса - ' ||
                                      l_status);
        elsif l_status = 'ok' then
          p_data_transfer(p_req_id => l_vzay.id,
                          p_url    => l_url,
                          p_mfo    => l_mfo,
                          p_type   => l_type,
                          p_date   => sysdate,
                          p_result => gTransfer_success,
                          p_comm   => l_comm);
    end if;
    dbms_xmlparser.freeparser(l_parser);
    DBMS_XMLDOM.freeDocument(l_doc);

  if l_flag != 4 and l_status = 'ok' then
    l_type := 7;
    service_track_request(p_reqest_id);
  end if;
  exception
    when others then
      dbms_xmlparser.freeparser(l_parser);
      DBMS_XMLDOM.freeDocument(l_doc);
      l_error := substr(sqlerrm, 1, 2000);
      bars_audit.error('set_request ERROR: ' || l_error);
      l_error := substr(sqlerrm, 1, 900);

      p_data_transfer (p_req_id => l_vzay.id,
                       p_url    => l_url,
                       p_mfo    => l_mfo,
                       p_type   => l_type,
                       p_date   => sysdate,
                       p_result => gTransfer_eroor,
                       p_comm   => 'exception - '||l_error
                       );
  end;
end if;
end service_request;

-------------------------------------------------------------------------------
function get_week_limit return number
is
  l_val        birja.val%type;
  l_week_limit number;
begin
  begin
     select val into l_val from birja where par = 'WEEK_LIM';
  exception when no_data_found then
     l_val := null;
  end;
  if l_val is not null then
     begin
        l_week_limit := to_number(l_val);
     exception when others then
        raise_application_error(-20000, 'Некоректно задано параметр <Тижневий ліміт на операції>');
     end;
     if l_week_limit <= 0 then
        raise_application_error(-20000, 'Некоректно задано параметр <Тижневий ліміт на операції>');
     end if;
  end if;
  return l_week_limit;
end get_week_limit;

-------------------------------------------------------------------------------
--
-- процедура проверки Тижневий ліміт на операції
--
procedure check_week_limit (p_inn varchar2, p_s number, p_kv number)
is
  l_week_limit number;
  l_s          number;
  l_msg        varchar2(2000) := null;
  l_dig        number;
  function get_s (i_s number, i_kv number, i_dat date) return number
  is
  begin
     return case when i_kv = 959 then i_s
                 else gl.p_ncurval(959, gl.p_icurval(i_kv, i_s, i_dat), i_dat)
            end;
  end;
begin
  if p_inn is not null then
     l_week_limit := get_week_limit;
     l_s := get_s(p_s, p_kv, bankdate);
     for z in ( select z.fdat, z.s2, z.kv2, t.dig, t.lcv
                  from zayavka z, customer c, tabval$global t
                 where z.rnk  = c.rnk
                   and c.okpo = p_inn
                   and z.kv2 in (959, 961) and z.kv2 = t.kv
                   and z.dk = 1
                    -- заявки удовлетворенные и введенные/завизированные
                   and z.sos >= 0
                    -- дата заявки с ближайшего понедельника по текущий день включительно
                   and z.fdat between trunc(bankdate, 'iw') and bankdate )
     loop
        -- суммируем заявки
        -- Курс официальный НБУ за дату заявки
        l_s := l_s + get_s(z.s2, z.kv2, z.fdat);
        l_msg := substr(l_msg || z.fdat || ' - ' || z.s2/power(10,z.dig) || ' ' || z.lcv || chr(10), 1, 2000);
     end loop;
     select nvl(min(dig),2) into l_dig from tabval$global where kv = 959;
     if l_s/power(10,l_dig) > l_week_limit then
        bars_error.raise_nerror(modcode, 'ERROR_WEEK_LIMIT', 'Ліміт перевищено на ' || trim(to_char(l_s/power(10,l_dig) - l_week_limit, '9999999990.999')) || ' унції золота' || chr(10) || l_msg);
     end if;
  end if;
end check_week_limit;

-------------------------------------------------------------------------------
procedure check_week_limit (p_rnk number, p_s number, p_kv number)
is
  l_okpo  customer.okpo%type;
begin
  begin
     select okpo into l_okpo from customer where rnk = p_rnk;
  exception when others then
     l_okpo := null;
  end;
  if l_okpo is not null then
     check_week_limit(l_okpo, p_s, p_kv);
  end if;
end check_week_limit;

-------------------------------------------------------------------------------
--
-- создание заявки на покупку/продажу валюты
--
procedure add_request (p_request in out zayavka%rowtype, p_flag_klb in number default 0)
is
begin

  if p_request.dk = 1 and p_request.kv2 in (959, 961) then
     check_week_limit(p_request.rnk, p_request.s2, p_request.kv2);
  end if;

  -- процент (%) комиссии, фикс.сумма комиссии
  if p_request.kom is null and p_request.skom is null then
     get_commission(p_request.dk,
                    p_request.rnk,
                    p_request.kv2,
                    p_request.s2,
                    nvl(p_request.fdat, bankdate),
                    p_request.kom,
                    p_request.skom);
  end if;

  -- идентификатор заявки
  p_request.id := bars_sqnc.get_nextval('s_zayavka');

  -- номер заявки
  p_request.nd := case when p_request.nd is not null then p_request.nd else substr(to_char(p_request.id), 1, 10) end;

  -- ид. клиент-банка
  if p_flag_klb <> 0 and p_request.identkb is null then
     p_request.identkb := substr(to_char(p_request.id), 1, 16);
  end if;

  if p_flag_klb = -1  then
     p_request.fnamekb := 'C2';
  elsif p_flag_klb = -2 then
     p_request.fnamekb := 'CL';
  end if;

  p_request.kf := sys_context('bars_context','user_mfo');

  insert into zayavka values p_request;

  begin
     insert into zay_queue (id) values (p_request.id);
  exception when dup_val_on_index then null;
  end;

  logger.info('BARS_ZAY.ADD_REQUEST.Ид-заявки-'||p_request.id||', KF - '||p_request.kf||', gZaymode-'|| gZaymode);

  if p_request.kf <>'300465' then
    -- позвать web-сервис
    service_request(p_request.id,p_flag_klb);
  end if;

exception when others then
  bars_error.raise_nerror('ZAY', 'CREATE_REQUEST_FAILED', sqlerrm);
end add_request;

-------------------------------------------------------------------------------
--
-- создание заявки на покупку/продажу валюты (оболочка для вызова create_request, но без асс счетов, а с nls)
--
procedure create_request_ex
   (p_reqtype       in  zayavka.dk%type,                          -- тип заявки (1-покупка, 2-продажа, 3-конверсия)
    p_custid        in  zayavka.rnk%type,                         -- регистр.№ клиента
    p_curid         in  zayavka.kv2%type,                         -- числ.код валюты (для dk(1,3) - которая покупается, для 2 - которая продается)
    p_curconvid     in  zayavka.kv_conv%type       default null,  -- числ.код валюты за которую покупается (для dk = 3)
    p_amount        in  zayavka.s2%type,                          -- сумма заявленной валюты ("приведенная")
    p_reqnum        in  zayavka.nd%type            default null,  -- номер заявки
    p_reqdate       in  zayavka.fdat%type          default null,  -- дата заявки
    p_reqrate       in  zayavka.kurs_z%type        default null,  -- курс заявки
    p_nls_acc1      in  zayavka.nls0%type,                        -- № счета в ин.вал. (для 1 - вал счет зачисления, для 2 - вал счет списания, для 3 - вал счет зачисления)
    p_nls_acc0      in  zayavka.nls0%type,                        -- № счета в нац.вал.(для 1 - грн счет списания, для 2 - грн счет зачисления(при зачислении выруч.грн на межбанк - поле пустует,зато заполняются поля mfo0, nls0,okpo0), для 3 - вал счет для списания)
    p_nataccnum     in  zayavka.nls0%type          default null,  -- счет в нац.валюте в др.банке     (для dk = 2)
    p_natbnkmfo     in  zayavka.mfo0%type          default null,  -- МФО банка счета в нац.валюте     (для dk = 2)
    p_cmsprc        in  zayavka.kom%type           default null,  -- процент (%) комиссии
    p_cmssum        in  zayavka.skom%type          default null,  -- фикс.сумма комиссии
    p_taxflg        in  zayavka.fl_pf%type         default 1,     -- признак отчисления в ПФ          (для dk = 1)
    p_taxacc        in  zayavka.nlsp%type          default null,  -- счет клиента для отчисления в ПФ (для dk = 1)
    p_aimid         in  zayavka.meta%type          default null,                        -- код цели покупки/продажи
    p_f092          in  zayavka.f092%type          default null,  -- код параметра F092
    p_contractid    in  zayavka.pid%type           default null,  -- идентификатор контракта
    p_contractnum   in  zayavka.contract%type      default null,  -- номер контракта/кред.договора
    p_contractdat   in  zayavka.dat2_vmd%type      default null,  -- дата контракта/кред.договора
    p_custdeclnum   in  zayavka.num_vmd%type       default null,  -- номер последней тамож.декларации
    p_custdecldat   in  zayavka.dat_vmd%type       default null,  -- дата последней тамож.декларации
    p_prevdecldat   in  zayavka.dat5_vmd%type      default null,  -- даты предыдущ.тамож.деклараций    (для dk = 1)
    p_basis         in  zayavka.basis%type         default null,  -- основание для покупки валюты      (для dk = 1)
    p_countryid     in  zayavka.country%type       default null,  -- код страны перечисления валюты    (для dk = 1)
    p_bnfcountryid  in  zayavka.benefcountry%type  default null,  -- код страны бенефициара            (для dk = 1)
    p_bnfbankcode   in  zayavka.bank_code%type     default null,  -- код банка (B010)                  (для dk = 1)
    p_bnfbankname   in  zayavka.bank_name%type     default null,  -- название банка                    (для dk = 1)
    p_productgrp    in  zayavka.product_group%type default null,  -- код товарной группы               (для dk = 1)
    p_details       in  zayavka.details%type       default null,  -- подробности заявки
    p_flag          in  number                     default 0,     -- признак Кл-Б (Олег)
    p_fio           in  zayavka.contact_fio%type   default null,  -- ПИБ уполномоченного
    p_tel           in  zayavka.contact_tel%type   default null,  -- тел уполномоченного
    p_branch        in  zayavka.branch%type        default null,  -- бранч заявки
    p_operid_nokk   in  zayavka.operid_nokk%type   default null,  -- Унікальний номер операції в системі Клієнт-Банк (Олег, Надра)
    p_req_type      in  zayavka.req_type%type      default null,  -- Тип заявки
    p_vdateplan     in  zayavka.vdate_plan%type    default null,  -- Плановая дата валютирования
    p_obz           in  zayavka.obz%type           default null,  -- Признак заявки на обязательную продажу (1)
    p_rnk_pf        in  zayavka.rnk_pf%type        default null,  -- для покупки - рег.№ клиента в пф для продажи: код для 27-го файла
    p_reqid         out zayavka.id%type)
is
  l_acc0 accounts.acc%type;
  l_acc1 accounts.acc%type;
  l_rnk0 accounts.rnk%type;
  l_rnk1 accounts.rnk%type;
  l_dig  tabval.dig%type;
  l_request  zayavka%rowtype;
  ern        NUMBER;          -- код ошибки (из err_zay)
  msg        VARCHAR2(254);   -- текстовка ошибки "для себя"
  err        EXCEPTION;
  prm        VARCHAR2(25)  := null;  -- параметр, передаваемый в сообщения об ошибке
  prm1       VARCHAR2(25)  := null;  -- параметр, передаваемый в сообщения об ошибке
  l_title    varchar2(30)  := 'zay.create_request_ex:';
begin

  if p_reqdate < gl.bd - gZAYDAY - ( case when p_reqtype in (1, 3) then -1 else 0 end ) then
     msg  := 'Дата заявки ' || p_reqnum || ' устарела!' ;
     ern  := 28;
     prm  := p_reqnum;
     bars_audit.trace('%s Неуспешное создание заявки № %s ', l_title, to_char(p_reqnum), to_char(msg));
     raise err;
  end if;

  if p_reqtype = 3 and p_curconvid = p_curid then
     msg  := 'Валюта покупки и продажи заявки на конверсию ' || p_reqnum || ' совпадают! ';
     ern  := 40;
     prm  := p_reqnum;
     bars_audit.trace('%s Неуспешное создание заявки № %s ', l_title, to_char(p_reqnum), to_char(msg));
     raise err;
  end if;

  if p_reqtype in (1,3) or (p_reqtype = 2 and nvl(p_natbnkmfo,f_ourmfo()) = f_ourmfo() ) then
     begin
        select acc, rnk into l_acc0, l_rnk0
          from accounts where nls = p_nls_acc0 and kv = decode(p_curconvid,null,980,p_curconvid) and dazs is null;
     exception when no_data_found then
        msg  := 'Не найден т/с ' || p_nls_acc0 || ' вал '|| p_curconvid ;
        ern  := 26;
        prm  := p_nls_acc0;
        bars_audit.trace('%s Неуспешное создание заявки - %s', l_title, to_char(msg));
        raise err;
     end;
  else
     l_acc0 := null;
  end if;

  begin
     select acc, rnk into l_acc1, l_rnk1
       from accounts where nls = p_nls_acc1 and kv = p_curid and dazs is null;
  exception when no_data_found then
     msg  := 'Не найден р/с ' || p_nls_acc1 || ' вал ' || p_curid ;
     ern  := 27;
     prm  := p_nls_acc1;
     prm1 := p_curid;
     bars_audit.trace('%s Неуспешное создание заявки - %s', l_title, to_char(msg));
     raise err;
  end;


  begin
     select dig into l_dig from tabval where kv = p_curid;
  exception when no_data_found then null;
  end;

  l_request.id            := null;
  l_request.dk            := p_reqtype;
  l_request.rnk           := p_custid;
  l_request.kv2           := p_curid;
  l_request.kv_conv       := p_curconvid;
  l_request.s2            := p_amount * power(10, l_dig);
  l_request.nd            := p_reqnum;
  l_request.fdat          := p_reqdate;
  l_request.datt          := l_request.fdat + gZAYDAY + ( case when p_reqtype in (1, 3) then -1 else 0 end );
  l_request.kurs_z        := p_reqrate;
  l_request.acc1          := l_acc1;
  l_request.acc0          := l_acc0;
  l_request.nls0          := p_nataccnum;
  l_request.mfo0          := p_natbnkmfo;
  l_request.kom           := p_cmsprc;
  l_request.skom          := p_cmssum;
  l_request.fl_pf         := p_taxflg;
  l_request.nlsp          := p_taxacc;
  l_request.meta          := p_aimid;
  l_request.f092          := p_f092;
  l_request.pid           := p_contractid;
  l_request.contract      := p_contractnum;
  l_request.dat2_vmd      := p_contractdat;
  l_request.num_vmd       := p_custdeclnum;
  l_request.dat_vmd       := p_custdecldat;
  l_request.dat5_vmd      := p_prevdecldat;
  l_request.basis         := p_basis;
  l_request.country       := p_countryid;
  l_request.benefcountry  := p_bnfcountryid;
  l_request.bank_code     := p_bnfbankcode;
  l_request.bank_name     := p_bnfbankname;
  l_request.product_group := p_productgrp;
  l_request.sos           := 0;
  l_request.viza          := 0;
  l_request.priority      := 0;
  l_request.obz           := 0;
  l_request.verify_opt    := 1;
  l_request.details       := p_details;
  l_request.contact_fio   := p_fio;
  l_request.contact_tel   := p_tel;
  l_request.branch        := p_branch;
  l_request.operid_nokk   := p_operid_nokk;
  l_request.req_type      := p_req_type;
  l_request.vdate_plan    := p_vdateplan;
  l_request.obz           := p_obz;
  l_request.rnk_pf        := p_rnk_pf;
  l_request.identkb       := null;

  add_request(l_request, p_flag);

  if p_flag <> 0 then
     update cust_zay set NLS29 = nvl(NLS29, p_nls_acc0), NLS26 = nvl(NLS26,p_nls_acc1),
                         MFO26 = nvl(MFO26, f_ourmfo()),   TEL = nvl(TEL, p_tel),       FIO = nvl(FIO, p_fio),
                          MFOV = nvl(MFOV, p_natbnkmfo),  NLSV = nvl(NLSV, p_nataccnum)
      where rnk = p_custid;
     if sql%rowcount = 0 then
        Insert into CUST_ZAY (RNK, NLS29, NLS26, MFO26, TEL, FIO, MFOV, NLSV)
        values (p_custid, p_nls_acc0, p_nls_acc1, f_ourmfo, p_tel, p_fio, p_natbnkmfo, p_nataccnum);
    end if;
    if p_reqtype = 1 then
       update cust_zay set  kom = p_cmsprc where rnk = p_custid;
    elsif p_reqtype = 2 then
       update cust_zay set kom2 = p_cmsprc where rnk = p_custid;
    elsif p_reqtype = 3 then
       update cust_zay set kom3 = p_cmsprc where rnk = p_custid;
    end if;
  end if;

  p_reqid := l_request.id;

EXCEPTION WHEN err THEN
   bars_error.raise_error('ZAY', ern, prm, prm1);
end create_request_ex;

-------------------------------------------------------------------------------
--
-- создание заявки на покупку/продажу валюты
--
procedure create_request
   (p_reqtype       in  zayavka.dk%type,                          -- тип заявки (1-покупка, 2-продажа, 3-конверсия)
    p_custid        in  zayavka.rnk%type,                         -- регистр.№ клиента
    p_curid         in  zayavka.kv2%type,                         -- числ.код валюты (для dk(1,3) - которая покупается, для 2 - которая продается)
    p_curconvid     in  zayavka.kv_conv%type       default null,  -- числ.код валюты за которую покупается (для dk = 3)
    p_amount        in  zayavka.s2%type,                          -- сумма заявленной валюты (в коп.)
    p_reqnum        in  zayavka.nd%type            default null,  -- номер заявки
    p_reqdate       in  zayavka.fdat%type          default null,  -- дата заявки
    p_reqrate       in  zayavka.kurs_z%type        default null,  -- курс заявки
    p_frxaccid      in  zayavka.acc1%type,                        -- внутр.№ счета в ин.вал. (для 1 - вал счет зачисления, для 2 - вал счет списания, для 3 - вал счет зачисления)
    p_nataccid      in  zayavka.acc0%type,                        -- внутр.№ счета (для 1 - грн счет списания, для 2 - грн счет зачисления(при зачислении выруч.грн на межбанк - поле пустует,зато заполняются поля mfo0, nls0,okpo0), для 3 - вал счет для списания)
    p_nataccnum     in  zayavka.nls0%type          default null,  -- счет в нац.валюте в др.банке     (для dk = 2)
    p_natbnkmfo     in  zayavka.mfo0%type          default null,  -- МФО банка счета в нац.валюте     (для dk = 2)
    p_okpo0         in  zayavka.okpo0%type         default null,  -- ОКПО для зачисления грн на м/б при продаже (для dk = 2)
    p_cmsprc        in  zayavka.kom%type           default null,  -- процент (%) комиссии
    p_cmssum        in  zayavka.skom%type          default null,  -- фикс.сумма комиссии
    p_taxflg        in  zayavka.fl_pf%type         default 1,     -- признак отчисления в ПФ          (для dk = 1)
    p_taxacc        in  zayavka.nlsp%type          default null,  -- счет клиента для отчисления в ПФ (для dk = 1)
    p_aimid         in  zayavka.meta%type          default null,  -- код цели покупки/продажи
    p_contractid    in  zayavka.pid%type           default null,  -- идентификатор контракта
    p_contractnum   in  zayavka.contract%type      default null,  -- номер контракта/кред.договора
    p_contractdat   in  zayavka.dat2_vmd%type      default null,  -- дата контракта/кред.договора
    p_custdeclnum   in  zayavka.num_vmd%type       default null,  -- номер последней тамож.декларации
    p_custdecldat   in  zayavka.dat_vmd%type       default null,  -- дата последней тамож.декларации
    p_prevdecldat   in  zayavka.dat5_vmd%type      default null,  -- даты предыдущ.тамож.деклараций    (для dk = 1)
    p_basis         in  zayavka.basis%type         default null,  -- основание для покупки валюты      (для dk = 1)
    p_countryid     in  zayavka.country%type       default null,  -- код страны перечисления валюты    (для dk = 1)
    p_bnfcountryid  in  zayavka.benefcountry%type  default null,  -- код страны бенефициара            (для dk = 1)
    p_bnfbankcode   in  zayavka.bank_code%type     default null,  -- код банка (B010)                  (для dk = 1)
    p_bnfbankname   in  zayavka.bank_name%type     default null,  -- название банка                    (для dk = 1)
    p_productgrp    in  zayavka.product_group%type default null,  -- код товарной группы               (для dk = 1)
    p_details       in  zayavka.details%type       default null,  -- подробности заявки
    p_contactfio    in  zayavka.contact_fio%type   default null,  -- ФИО контактного лица
    p_contacttel    in  zayavka.contact_tel%type   default null,  -- ТЕЛ контактного лица
    p_branch        in  zayavka.branch%type        default null,  -- бранч заявки
    p_operid_nokk   in  zayavka.operid_nokk%type   default null,  -- Унікальний номер операції в системі Клієнт-Банк (Олег, Надра)
    p_identkb       in  zayavka.identkb%type       default null,  -- Признак системі клиент-банк 1- корп2, 2 - корп лайт
    p_reqid         out zayavka.id%type)                         -- идентификатор заявки
is
  l_request zayavka%rowtype;
  l_title   constant varchar2(60) := 'zay.create_request:';
begin
  bars_audit.trace('%s p_reqtype = %s, p_custid = %s, p_curid = %s, p_amount = %s, p_frxaccid = %s, p_nataccid = %s, p_aimid = %s', l_title,
                      to_char(p_reqtype), to_char(p_custid), to_char(p_curid), to_char(p_amount), to_char(p_frxaccid), to_char(p_nataccid), to_char(p_aimid) );

  l_request.id            := null;
  l_request.nd            := p_reqnum;
  l_request.dk            := p_reqtype;
  l_request.kv2           := p_curid;
  l_request.kv_conv       := p_curconvid;
  l_request.rnk           := p_custid;
  l_request.s2            := p_amount;
  l_request.fdat          := nvl(p_reqdate, gl.bdate);
  l_request.datt          := l_request.fdat + gZAYDAY + ( case when p_reqtype in (1, 3) then -1 else 0 end );
  l_request.kurs_z        := p_reqrate;
  l_request.acc0          := p_nataccid;
  l_request.mfo0          := substr(p_natbnkmfo, 1, 12);
  l_request.nls0          := substr(p_nataccnum, 1, 14);
  l_request.okpo0         := p_okpo0;
  l_request.acc1          := p_frxaccid;
  l_request.kom           := p_cmsprc;
  l_request.skom          := p_cmssum;
  l_request.fl_pf         := p_taxflg;
  l_request.nlsp          := substr(p_taxacc, 1, 14);
  l_request.meta          := p_aimid;
  l_request.pid           := p_contractid;
  l_request.contract      := substr(p_contractnum, 1, 50);
  l_request.dat2_vmd      := p_contractdat;
  l_request.num_vmd       := substr(p_custdeclnum, 1, 35);
  l_request.dat_vmd       := p_custdecldat;
  l_request.dat5_vmd      := substr(p_prevdecldat, 1,240);
  l_request.basis         := substr(p_basis, 1, 512);
  l_request.country       := p_countryid;
  l_request.benefcountry  := p_bnfcountryid;
  l_request.bank_code     := substr(p_bnfbankcode, 1, 10);
  l_request.bank_name     := substr(p_bnfbankname, 1, 60);
  l_request.product_group := substr(p_productgrp, 1, 2);
  l_request.sos           := 0;
  l_request.viza          := 0;
  l_request.priority      := 0;
  l_request.obz           := 0;
  l_request.verify_opt    := 1;
  l_request.datedokkb     := sysdate;
  l_request.isp           := gl.auid;
  l_request.tobo          := substr(tobopack.gettobo, 1, 22);
  l_request.identkb       := null;
  l_request.comm          := substr(p_details, 1, 250);
  l_request.contact_fio   := p_contactfio;
  l_request.contact_tel   := p_contacttel;
  l_request.branch        := case when p_branch is null then sys_context('bars_context','user_branch') else p_branch end;
  l_request.operid_nokk   := p_operid_nokk;
  l_request.req_type      := null;
  l_request.vdate_plan    := null;

  add_request(l_request, p_identkb);

  p_reqid := l_request.id;

exception
  when others then
    bars_error.raise_nerror ('ZAY', 'CREATE_REQUEST_FAILED', sqlerrm);

end create_request;

-------------------------------------------------------------------------------
--
-- определение процента отчисления в Пенс.Фонд
--
function get_taxrate return number
is
  parname  constant birja.par%type := 'PEN_FOND';
  l_taxprc number;
begin

  begin
    select to_number(val, '9999D99', 'NLS_NUMERIC_CHARACTERS=''.,''')
      into l_taxprc
      from birja
     where par = parname;
  exception
    when no_data_found then
      l_taxprc := 0;
  end;

  return nvl(l_taxprc, 0);

end get_taxrate;

-------------------------------------------------------------------------------
--
-- определение обеспеченности заявки на покупку/продажу валюты (возвращает 1/0)
--
function get_request_cover (p_reqid in zayavka.id%type) -- идентификатор заявки
return number
is
  title constant varchar2(60) := 'zay.getreqcover:';
  l_bdate date := gl.bdate;
  l_coverstate   number(1);
  l_dk     zayavka.dk%type;
  l_accid  accounts.acc%type;
  l_saldo  accounts.ostc%type;
  l_taxprc number;
  l_costs  number(38);
  l_kv_base  zay_conv_kv.kv_base%type;
  l_kv_conv  zayavka.kv_conv%type;
  l_kv       zayavka.kv2%type;
begin

  bars_audit.trace('%s entry, reqid=>%s', title, to_char(p_reqid));

  select dk, decode(dk, buy_type, acc0, convbuy_type, acc0, acc1), decode(dk, buy_type, ostc0, convbuy_type, ostc0, ostc), kv_conv, kv2
    into l_dk, l_accid, l_saldo, l_kv_conv, l_kv
    from v_zay_queue
   where id = p_reqid;

  bars_audit.trace('%s dk = %s, debitacc = %s', title, to_char(l_dk), to_char(l_accid));

  if l_dk = buy_type then
     -- покупка
     -- процент отчисления в Пенс.Фонд
     l_taxprc := get_taxrate/100;
     bars_audit.trace('%s taxprc = %s', title, to_char(l_taxprc));

     -- общая сумма затрат для списания с данного счета
     select sum(  round(s2 * decode(sos, 1, kurs_f, kurs_z))                                 -- сумма грн за валюту
         --       + round(gl.p_icurval(kv2, round(s2 * decode(fl_pf, 0, 0, l_taxprc)), l_bdate))  -- отчисление в ПФ
                + round(s2 * decode(sos, 1, kurs_f, kurs_z) * decode(fl_pf, 0, 0, l_taxprc)) -- отчисление в ПФ
                + round(gl.p_icurval(kv2, round(s2 * nvl(kom / 100, 0)), l_bdate)) -- комиссия (% от суммы)
                + nvl(skom * 100, 0)                                 -- комиссия (фикс.сумма)
               )
       into l_costs
       from v_zay_queue
      where dk     = l_dk
        and acc0   = l_accid
        and sos   >= 0
        and sos    < 2
        and s2     > 0
        and kurs_z > 0;

  elsif  l_dk = convbuy_type  then
     -- конверсия (покупка валюты за валюту)

     -- процент отчисления в Пенс.Фонд
     l_taxprc := get_taxrate/100;
     bars_audit.trace('%s taxprc = %s', title, to_char(l_taxprc));

     begin
       select kv_base into l_kv_base from zay_conv_kv where (kv1 = l_kv and kv2 = l_kv_conv) or (kv2 = l_kv and kv1 = l_kv_conv);
     exception when no_data_found then
         raise_application_error(-22222, 'Не описана базовая валюта для данной пары валют в конверсии!');
     end;

     -- обигрываем конверсию согласно курсам (валюта по отношению к валюте - пришлось определять понятие базовой валюты в паре)
     -- общая сумма затрат для списания с данного счета
    if l_kv_conv = l_kv_base then

     select sum(  round(s2 / decode(sos, 1, kurs_f, kurs_z))                                 -- сумма вал за валюту
                + round(s2 / decode(sos, 1, kurs_f, kurs_z) * decode(fl_pf, 0, 0, l_taxprc)) -- отчисление в ПФ
                + round(s2 / decode(sos, 1, kurs_f, kurs_z) * nvl(kom / 100, 0))             -- комиссия (% от суммы)
                + nvl(skom * 100, 0)                                 -- комиссия (фикс.сумма)
               )
       into l_costs
       from v_zay_queue
      where dk     = l_dk
        and acc0   = l_accid
        and sos   >= 0
        and sos    < 2
        and s2     > 0
        and kurs_z > 0;

    else

     select sum(  round(s2 * decode(sos, 1, kurs_f, kurs_z))                                 -- сумма вал за валюту
                + round(s2 * decode(sos, 1, kurs_f, kurs_z) * decode(fl_pf, 0, 0, l_taxprc)) -- отчисление в ПФ
                + round(s2 * decode(sos, 1, kurs_f, kurs_z) * nvl(kom / 100, 0))             -- комиссия (% от суммы)
                + nvl(skom * 100, 0)                                 -- комиссия (фикс.сумма)
               )
       into l_costs
       from v_zay_queue
      where dk     = l_dk
        and acc0   = l_accid
        and sos   >= 0
        and sos    < 2
        and s2     > 0
        and kurs_z > 0;

    end if;

  -- для dk in (2,4)
  else
     --продажа
     -- общая сумма всей продаваемой с данного счета валюты
     select sum(s2)
       into l_costs
       from v_zay_queue
      where dk     = l_dk
        and acc1   = l_accid
        and sos   >= 0
        and sos    < 2
        and s2     > 0;

  end if;

  l_costs := nvl(l_costs, 0);

  bars_audit.trace('%s costs = %s, saldo = %s', title, to_char(l_costs), to_char(l_saldo));

  if l_saldo < l_costs then
     l_coverstate := 0;
  else
     l_coverstate := 1;
  end if;

  bars_audit.trace('%s exit with %s', title, to_char(l_coverstate));

  return l_coverstate;

exception
  when others then return 0;
end get_request_cover;

-------------------------------------------------------------------------------
--
-- процедура расчета комиссии (% и/или фикс.сумма) за покупку/продажу валюты
-- !!!!!! доделана комиссия для конверсии (dk=3)
--
procedure get_commission
 (p_reqtype in  zayavka.dk%type,    -- тип заявки (1-покупка, 2 -продажа)
  p_custid  in  zayavka.rnk%type,   -- регистр.№ клиента
  p_curid   in  zayavka.kv2%type,   -- числ.код валюты
  p_amount  in  zayavka.s2%type,    -- сумма заявленной валюты (в коп.)
  p_reqdate in  zayavka.fdat%type,  -- дата заявки
  p_cmsprc  out zayavka.kom%type,   -- процент (%) комиссии
  p_cmssum  out zayavka.skom%type)  -- фикс.сумма комиссии
is
  g_title        constant varchar2(60)   := 'zay.getcommission:';
  g_parname      constant birja.par%type := 'PROC_KOM';
  g_parname1     constant birja.par%type := 'MSUM_KOM';
  g_parname_cnv  constant birja.par%type := 'PR_KOM_C';
  g_parname_cnv1 constant birja.par%type := 'MS_KOM_C';
  l_curgrp  tabval.grp%type;
  l_dig     tabval.dig%type;
  l_cmsprc  zayavka.kom%type;
  l_cmssum  zayavka.skom%type;
  l_cmsmins zayavka.skom%type;
  --
  -- внутр.процедура поиска комиссии по справочнику zay_comiss
  --
  procedure iget_cms (p_reqtype in  zay_comiss.dk%type,
                      p_custid  in  zay_comiss.rnk%type,
                      p_curid   in  zay_comiss.kv%type,
                      p_curgrp  in  zay_comiss.kv_grp%type,
                      p_amount  in  zay_comiss.limit%type,
                      p_reqdate in  zay_comiss.date_on%type,
                      p_cmsprc  out zayavka.kom%type,
                      p_cmssum  out zayavka.skom%type)
  is
    cursor cur_cms
        is
    select zc.rate, zc.fix_sum
      from zay_comiss zc
     where zc.dk =  p_reqtype
       and ((zc.rnk = p_custid) or (zc.rnk is null and p_custid is null))
       and zc.kv_grp =  p_curgrp
       and ((zc.kv = p_curid) or (zc.kv is null and p_curid is null))
       and nvl(zc.limit*100, 999999999999999) >= nvl(p_amount, 999999999999999)
       and zc.date_on <= p_reqdate
       and nvl(zc.date_off, p_reqdate) >= p_reqdate
     order by nvl(zc.limit, 999999999999999);
  begin
    open cur_cms;
    loop
      fetch cur_cms into p_cmsprc, p_cmssum;
      exit;
    end loop;
    close cur_cms;
  end iget_cms;
  --
begin

  bars_audit.trace('%s entry, (%s,%s,%s,%s,%s)', g_title,
                   to_char(p_reqtype), to_char(p_custid), to_char(p_curid),
                   to_char(p_amount),  to_char(p_reqdate, 'dd.mm.yyyy') );

  select nvl(grp, 1), dig into l_curgrp, l_dig from tabval where kv = p_curid;

  for i in 1..4 loop
    -- 1 - инд.тариф клиента для валюты заявки
    -- 2 - инд.тариф клиента для категории валюты
    -- 3 - станд.тариф для валюты заявки
    -- 4 - станд.тариф для категории валюты заявки
    if (l_cmsprc is null and l_cmssum is null) then
        iget_cms (p_reqtype => p_reqtype,
                  p_custid  => (case when i in (1, 2) then p_custid else null end),
                  p_curid   => (case when i in (1, 3) then p_curid  else null end),
                  p_curgrp  => l_curgrp,
                  p_amount  => p_amount,
                  p_reqdate => p_reqdate,
                  p_cmsprc  => l_cmsprc,
                  p_cmssum  => l_cmssum);
        bars_audit.trace('%s step %s -> (%s, %s)', g_title, to_char(i), to_char(l_cmsprc), to_char(l_cmssum));
    end if;
  end loop;
  bars_audit.trace('%s zay_comiss -> (%s, %s)', g_title, to_char(l_cmsprc), to_char(l_cmssum));

  if (l_cmsprc is null) then
     -- процент комиссии из "Параметры клиентов"
     begin
       select decode(p_reqtype, 1, kom, 2, kom2, kom3)
         into l_cmsprc
         from cust_zay
        where rnk = p_custid;
     exception
       when no_data_found then
         l_cmsprc := null;
     end;
  end if;

  if l_cmsprc is null then

     if p_reqtype in (1,2) then   -- покупка/продажа

     -- общебанковский процент комиссии из конфиг.параметров
        begin
          select to_number(val, '9999D99','NLS_NUMERIC_CHARACTERS=''.,''')
            into l_cmsprc
            from birja
           where par = g_parname;
        exception
          when no_data_found then l_cmsprc := null;
        end;

     -- общебанковский процент комиссии из конфиг.параметров (не меньше суммы)
        begin
          select to_number(val, '9999D99','NLS_NUMERIC_CHARACTERS=''.,''')
            into l_cmsmins
            from birja
           where par = g_parname1;
        exception
          when no_data_found then
            l_cmsmins := 0;
        end;

     else   -- конверсия

     -- общебанковский процент комиссии из конфиг.параметров
        begin
          select to_number(val, '9999D99','NLS_NUMERIC_CHARACTERS=''.,''')
            into l_cmsprc
            from birja
           where par = g_parname_cnv;
        exception
          when no_data_found then l_cmsprc := null;
        end;

     -- общебанковский процент комиссии из конфиг.параметров (не меньше суммы)
        begin
          select to_number(val, '9999D99','NLS_NUMERIC_CHARACTERS=''.,''')
            into l_cmsmins
            from birja
           where par = g_parname_cnv1;
        exception
          when no_data_found then
            l_cmsmins := 0;
        end;

     end if;

     if gl.p_icurval(p_curid, p_amount/power(10,l_dig)*nvl(l_cmsprc,0), p_reqdate) < l_cmsmins then
       l_cmssum := l_cmsmins/100;
       l_cmsprc := null;
     end if;

  end if;

  p_cmsprc := l_cmsprc;
  p_cmssum := l_cmssum;

  bars_audit.trace('%s exit with (%s, %s)', g_title, to_char(p_cmsprc), to_char(p_cmssum));

end get_commission;

-------------------------------------------------------------------------------
--
-- проверка данных перед визой заявки на покупку/продажу валюты
--
procedure p_zay_check_data
   (p_dk     in zayavka.dk%type,      -- покупка(1) / продажа(2)
    p_id     in zayavka.id%type,      -- ид заявки
    p_kv     in zayavka.kv2%type,     -- вал заявки
    p_sum    in zayavka.s2%type,      -- сума заявки
    p_rate   in zayavka.kurs_z%type,  -- курс заявки
    p_dat    in zayavka.fdat%type     -- дата заявки
   )
is
 l_BLK              number  := 0;  -- 0/1 - блокировка валюты дилером
 l_DilerRate        diler_kurs.kurs_b%type;
 l_aim              zayavka.meta%type;
 l_contract         zayavka.contract%type;
 l_dat2_vmd         zayavka.dat2_vmd%type;
 l_country          zayavka.country%type;
 l_basis            zayavka.basis%type;
 l_benefcountry     zayavka.benefcountry%type;
 l_bank_code        zayavka.bank_code%type;
 l_bank_name        zayavka.bank_name%type;
 l_product_group    zayavka.product_group%type;
 l_code_2c          zayavka.code_2c%type;
 l_p12_2c           zayavka.p12_2c%type;

 ern        NUMBER;          -- код ошибки (из err_zay)
 msg        VARCHAR2(254);   -- текстовка ошибки "для себя"
 err        EXCEPTION;
 prm        VARCHAR2(25)  := null;  -- параметр, передаваемый в сообщения об ошибке
 l_title    varchar2(100) := 'ZAY.p_zay_check_data. ';

 function f_GetDilerRate (p_dk NUMBER, p_kv NUMBER)
 RETURN number
 IS
 l_BuyRate  diler_kurs.kurs_b%type;
 l_SalRate  diler_kurs.kurs_s%type;
 BEGIN
   begin
     SELECT kurs_b, kurs_s
       INTO l_BuyRate, l_SalRate
       FROM diler_kurs
      WHERE kv = p_kv
        AND dat = (SELECT max(dat)
                     FROM diler_kurs
                    WHERE trunc(dat) = trunc(sysdate)
                      AND kv = p_kv);
   exception when no_data_found then l_BuyRate:=null; l_SalRate:=null;
   end;
  if p_dk = 1 then return l_BuyRate;
  elsif p_dk = 2 then return l_SalRate;
  end if;
 END;

BEGIN

  bars_audit.trace('%s Params: p_dk=%s, p_id=%s, p_kv=%s, p_sum=%s, p_rate=%s, p_dat=%s',
        l_title, to_char(p_dk), to_char(p_id), to_char(p_kv), to_char(p_sum), to_char(p_rate), to_char(p_dat,'dd/mm/yyyy'));

    -- Валюта заблокирована дилером
    begin
    SELECT nvl(blk,0)
       INTO l_BLK
       FROM diler_kurs
      WHERE kv = p_kv
        AND dat = (SELECT max(dat)
                     FROM diler_kurs
                    WHERE trunc(dat) = trunc(sysdate)
                      AND kv = p_kv);
    exception when no_data_found then null;
    end;

    if l_BLK = 1 then
         msg  := 'Валюта ' || p_kv || ' заблокирована Дилером!' ;
         ern  := 20;
         prm := p_kv;
         bars_audit.trace('%s Неуспешное визирование заявки № %s - %s', l_title, to_char(p_id), to_char(msg));
         raise err;
    end if;

  -- Нулевая/пустая сумма
    if nvl(p_sum,0) = 0 then
         msg  := 'Не указана сумма заявки ' || p_id;
         ern  := 21;
         prm := p_id;
         bars_audit.trace('%s Неуспешное визирование заявки № %s - %s', l_title, to_char(p_id), to_char(msg));
         raise err;
    end if;

  -- Пустая дата
    if p_dat is null then
         msg  := 'Не указана дата заявки ' || p_id;
         ern  := 22;
         prm := p_id;
         bars_audit.trace('%s Неуспешное визирование заявки № %s - %s', l_title, to_char(p_id), to_char(msg));
         raise err;
    end if;

  -- Нулевой/пустой курс
    if nvl(p_rate,0) = 0 then
      l_DilerRate := f_GetDilerRate(p_dk, p_kv);
      if l_DilerRate is null then
           msg  := 'Не указан курс заявки ' || p_id;
           ern  := 23;
           prm := p_id;
           bars_audit.trace('%s Неуспешное визирование заявки № %s - %s', l_title, to_char(p_id), to_char(msg));
           raise err;
      else
           UPDATE zayavka SET kurs_z = l_DilerRate WHERE id = p_id;
           bars_audit.trace('%s При визирование заявки № %s пользователем установлен курс из предв.курсов дилера %s', l_title, to_char(p_id),
                                                                                                                      to_char(l_DilerRate));
      end if;
    end if;

  -- Покупка
   if p_dk = 1 then
     select meta, contract, dat2_vmd, country, basis, benefcountry, bank_code, bank_name, product_group, code_2c, p12_2c
       into l_aim, l_contract, l_dat2_vmd, l_country, l_basis, l_benefcountry, l_bank_code, l_bank_name, l_product_group, l_code_2c, l_p12_2c
       from zayavka
      where id = p_id;

      -- пустой № контракта
      if l_contract is null then
           msg  := 'Не указан № контракта заявки ' || p_id;
           ern  := 46;
           prm := p_id;
           bars_audit.trace('%s Неуспешное визирование заявки № %s - %s', l_title, to_char(p_id), to_char(msg));
           raise err;
      end if;
      -- пустая дата контракта
      if l_dat2_vmd is null then
           msg  := 'Не указана дата контракта заявки ' || p_id;
           ern  := 47;
           prm := p_id;
           bars_audit.trace('%s Неуспешное визирование заявки № %s - %s', l_title, to_char(p_id), to_char(msg));
           raise err;
      end if;




   end if;



EXCEPTION
   WHEN err THEN
      bars_error.raise_error('ZAY', ern, prm);
END p_zay_check_data;

-------------------------------------------------------------------------------
--
-- Процедура разбиения заявки на покупку/продажу валюты (Надра, для частичного удовлетворения заявки)
--
procedure p_zay_multiple
   (p_id   in zayavka.id%type,      -- ид заявки
    p_sum1 in number default null,  -- сумма зааявки-1
    p_sum2 in number default null)  -- сумма зааявки-2
is

 ern        NUMBER;          -- код ошибки (из err_zay)
 msg        VARCHAR2(254);   -- текстовка ошибки "для себя"
 err        EXCEPTION;
 prm        VARCHAR2(25)  := null;  -- параметр, передаваемый в сообщения об ошибке
 l_title    varchar2(100) := 'ZAY.p_zay_multiple. ';

 r_zay      zayavka%ROWTYPE;    -- массив данных про первоначальную заявку
 r_zay1     zayavka%ROWTYPE;

 l_zay_source number := 1;

 l_req_id     number;
 l_mfo        varchar2(10);
 l_request    soap_rpc.t_request;
 l_response   soap_rpc.t_response;
 l_clob       clob;
 l_error      varchar2(2000);
 l_parser     dbms_xmlparser.parser;
 l_doc        dbms_xmldom.domdocument;
 l_reslist    dbms_xmldom.DOMNodeList;
 l_res        dbms_xmldom.DOMNode;
 l_str        varchar2(2000);
 l_status     varchar2(100);
 l_tmp        xmltype;
 ret_         varchar2(256);
 l_url        varchar2(256);
 l_type       number;
 l_comm       varchar2(256);
 l_branch   zayavka.branch%type;

 --
 -- внутр.процедура  собственно вставки новой заявки
 --
 procedure p_zay_ins (p_s int, r_rt in out zayavka%ROWtype)
 is
  l_id  number;
 begin
        l_id :=  bars_sqnc.get_nextval('s_zayavka');
        r_rt.comm := 'Разбиение заявки № '||nvl(r_rt.nd, r_rt.id)||' клиента '||r_rt.rnk||' суммы '||trim(to_char(r_rt.s2/100,'99999999990.99'));
        r_rt.id_prev := r_rt.id;
        r_rt.id := l_id;
        r_rt.s2 := p_s*100;
        r_rt.datedokkb := null;  -- чтобы триггер tbi_zayavka вставил текущее время
        r_rt.identkb :=l_id;--COBUMMFO-9206
        --null;--Степан: добавив щоб уникнути спрацювання констрейнтирейнти унікальності UK_ZAYAVKA_FNAMEKB_IDENTKB
        -- пересчитываем комиссию, поскольку поменялись суммы
        get_commission(r_rt.dk,
                       r_rt.rnk,
                       r_rt.kv2,
                       r_rt.s2,
                       bankdate,
                       r_rt.kom,
                       r_rt.skom);
        -- вставляем новую заявку
        insert into zayavka  values r_rt;
        -- потому как триггер tbi_zayavka затирает другими значениями, а нам необходимы первоначальные
        update zayavka set isp = r_rt.isp, tobo = r_rt.tobo where id = l_id;
 end;

begin
 -- трасса входящих параметров
  bars_audit.trace('%s Params: p_id=%s, p_sum1=%s, p_sum2=%s',
        l_title, to_char(p_id), to_char(p_sum1), to_char(p_sum2));

  select branch into l_branch from v_zay where id = p_id and sos<2 and sos>-1;

  if gZAYMODE = 1 then
     -- Определяем, чья заявка: ЦА или РУ
     begin
        select 1 into l_zay_source from zayavka where id = p_id and branch = l_branch;
     exception when no_data_found then
        begin
           select 2 into l_zay_source from zayavka_ru where id = p_id and branch = l_branch;
        exception when no_data_found then
           raise_application_error(-20000, 'Заявка ид.=' || p_id || ' не найдена.');
        end;
     end;
  end if;

  if l_zay_source = 1 then
    -- проверка - заявка отсутствует
    begin
     select z.* into r_zay from zayavka z where z.id = p_id and z.branch = l_branch and z.sos >= 0;
    exception when no_data_found then
         msg  := 'Заявка ' || p_id || ' не найдена!' ;
         ern  := 6;
         prm  := p_id;
         bars_audit.trace('%s Неуспешное выполнение разбиения заявки № %s - %s', l_title, to_char(p_id), to_char(msg));
         raise err;
    end;

    -- проверка - введенные суммы не равны сумме первоначальной заявки
    if (nvl(p_sum1,0) + nvl(p_sum2,0) )  <> r_zay.s2/100 or nvl(p_sum1,0) = 0 or nvl(p_sum2,0) = 0 then
         msg  := 'Введеные суммы не совпадают!' ;
         ern  := 24;
         prm  := p_id;
         bars_audit.trace('%s Неуспешное выполнение разбиения заявки № %s - %s', l_title, to_char(p_id), to_char(msg));
         raise err;
    end if;

    -- сохраняем первоначальный массив в копию
    r_zay1 := r_zay;
    -- запускаем внутр.процедуру для первой суммы с первонач.массивом
    p_zay_ins (p_sum1, r_zay);
    if gZAYMODE = 2 then
      bars_audit.info('service_request id1='||r_zay.id||' start');
      service_request(p_reqest_id => r_zay.id,
                      p_flag_klb  => 0);
      bars_audit.info('service_request id1='||r_zay.id||' done');
    end if;
    -- запускаем внутр.процедуру для второй суммы с первонач.массивом (копией, поскольку r_zay в out предыдущего запуска уже изменен)
    p_zay_ins (p_sum2, r_zay1);
    if gZAYMODE = 2 then
      bars_audit.info('service_request id2='||r_zay1.id||' start');
      service_request(p_reqest_id => r_zay1.id,
                      p_flag_klb  => 0);
      bars_audit.info('service_request id2='||r_zay1.id||' done');
    end if;
    -- первоначальной заявке меняем sos
    update zayavka set sos = -1 where id = p_id and branch = l_branch;
  else
    -- первоначальной заявке меняем sos
    update zayavka_ru set sos = -1 where id = p_id and branch = l_branch;
    -- позвать web-сервис для отправки запроса в РУ на разбиение заявки
    select url, to_char(mfo) into l_url, l_mfo from zay_recipients where to_char(mfo) = (select mfo from zayavka_ru where id = p_id and branch = l_branch);

    l_request := soap_rpc.new_request(p_url         => l_url,
                                      p_namespace   => 'http://tempuri.org/',
                                      p_method      => 'MultipleRequest',
                                      p_wallet_dir  => gWallet_dir,
                                      p_wallet_pass => gWallet_pass);

    select req_id into l_req_id from zayavka_ru where id = p_id and branch = l_branch;

    soap_rpc.add_parameter(l_request, 'req_id', to_char(nvl(l_req_id,0)));
    soap_rpc.add_parameter(l_request, 'sum1', to_char(nvl(p_sum1,0)));
    soap_rpc.add_parameter(l_request, 'sum2', to_char(nvl(p_sum2,0)));
    soap_rpc.add_parameter(l_request, 'mfo', l_mfo);

    -- позвать метод веб-сервиса
    begin
      l_response := soap_rpc.invoke(l_request);

      --разбираем ответ
      l_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
      l_tmp  := xmltype(l_clob);

      ret_ := extract(l_tmp,
                      '/MultipleRequestResponse/MultipleRequestResult/text()',
                      null);

      l_clob   := l_response.doc.getClobVal();
      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob(l_parser, l_clob);
      l_doc     := dbms_xmlparser.getdocument(l_parser);
      l_reslist := dbms_xmldom.getelementsbytagname(l_doc,
                                                      'MultipleRequestResult');
      l_res     := dbms_xmldom.item(l_reslist, 0);
      dbms_xslprocessor.valueof(l_res, 'Status/text()', l_str);
      l_status := substr(l_str, 1, 200);
      l_type := 2;
      l_comm := 'До РУ МФО '||l_mfo||' передано інформацію, щодо розбиття заявки №'||p_id;

      if l_status = 'error' then
        dbms_xslprocessor.valueof(l_res, 'ErrorMessage/text()', l_str);

        p_data_transfer(p_req_id => l_req_id,
                        p_url    => l_url,
                        p_mfo    => l_mfo,
                        p_type   => l_type,
                        p_date   => sysdate,
                        p_result => gTransfer_eroor,
                        p_comm   => 'error = ' || substr(l_str, 1, 200));
      elsif l_status <> 'ok' then
        p_data_transfer(p_req_id => l_req_id,
                        p_url    => l_url,
                        p_mfo    => l_mfo,
                        p_type   => l_type,
                        p_date   => sysdate,
                        p_result => gTransfer_eroor,
                        p_comm   => 'Необрабатываемое значение статуса - ' ||
                                     l_status);
      elsif l_status = 'ok' then
        p_data_transfer(p_req_id => l_req_id,
                        p_url    => l_url,
                        p_mfo    => l_mfo,
                        p_type   => l_type,
                        p_date   => sysdate,
                        p_result => gTransfer_success,
                        p_comm   => l_comm);
      end if;
      dbms_xmlparser.freeparser(l_parser);
      DBMS_XMLDOM.freeDocument(l_doc);
    exception
    when others then
      dbms_xmlparser.freeparser(l_parser);
      DBMS_XMLDOM.freeDocument(l_doc);
      l_error := substr(sqlerrm, 1, 2000);
      bars_audit.error('p_zyamumtiple ERROR: ' || l_error);
      l_error := substr(sqlerrm, 1, 150);

      p_data_transfer(p_req_id => l_req_id,
                      p_url    => l_url,
                      p_mfo    => l_mfo,
                      p_type   => l_type,
                      p_date   => sysdate,
                      p_result => gTransfer_eroor,
                      p_comm   => 'exception - ' || l_error);
    end;
  end if;

  EXCEPTION
    WHEN err THEN
      bars_audit.info('zay err'||sqlerrm);
      bars_error.raise_error('ZAY', ern, prm);
end p_zay_multiple;


-------------------------------------------------------------------------------
--
-- Изменение заявки на покупку/продажу валюты
--
procedure upd_request
   (p_id            in  zayavka.id%type,                          -- идентификатор заявки
    p_s2s           in  zayavka.s2%type,                          -- сумма заявленной валюты ("приведенная")
    p_nd            in  zayavka.nd%type            default null,  -- номер заявки
    p_fdat          in  zayavka.fdat%type          default null,  -- дата заявки
    p_kurs          in  zayavka.kurs_z%type        default null,  -- курс заявки
    p_kv_conv       in  zayavka.kv_conv%type       default null,  -- валюта покупки (конверсия, "за что покупаем")
    p_nls           in  zayavka.nls0%type,                        -- № счета зачисления
    p_nls_acc0      in  zayavka.nls0%type,                        -- № счета списания
    p_nls0          in  zayavka.nls0%type          default null,  -- счет в нац.валюте в др.банке     (для dk = 2)
    p_mfo0          in  zayavka.mfo0%type          default null,  -- МФО банка счета в нац.валюте     (для dk = 2)
    p_kom           in  zayavka.kom%type           default null,  -- процент (%) комиссии
    p_skom          in  zayavka.skom%type          default null,  -- фикс.сумма комиссии
    p_meta          in  zayavka.meta%type          default null,   -- код цели покупки/продажи
    p_f092          in  zayavka.f092%type          default null,  -- код параметра f092
    p_contract      in  zayavka.contract%type      default null,  -- номер контракта/кред.договора
    p_dat2_vmd      in  zayavka.dat2_vmd%type      default null,  -- дата контракта/кред.договора
    p_num_vmd       in  zayavka.num_vmd%type       default null,  -- номер последней тамож.декларации
    p_dat_vmd       in  zayavka.dat_vmd%type       default null,  -- дата последней тамож.декларации
    p_dat5_vmd      in  zayavka.dat5_vmd%type      default null,  -- даты предыдущ.тамож.деклараций    (для dk = 1)
    p_basis         in  zayavka.basis%type         default null,  -- основание для покупки валюты      (для dk = 1)
    p_country       in  zayavka.country%type       default null,  -- код страны перечисления валюты    (для dk = 1)
    p_benefcountry  in  zayavka.benefcountry%type  default null,  -- код страны бенефициара            (для dk = 1)
    p_bank_code     in  zayavka.bank_code%type     default null,  -- код банка (B010)                  (для dk = 1)
    p_bank_name     in  zayavka.bank_name%type     default null,  -- название банка                    (для dk = 1)
    p_product_group in  zayavka.product_group%type default null,  -- код товарной группы               (для dk = 1)
    p_comm          in  zayavka.comm%type          default null,  -- подробности заявки
    p_contactfio    in  zayavka.contact_fio%type   default null,  -- ФИО контактного лица
    p_contacttel    in  zayavka.contact_tel%type   default null,  -- ТЕЛ контактного лица
    p_pf            in  zayavka.fl_pf%type         default null,  -- признак отчисления в ПФ          (для dk = 1)
    p_req_type      in  zayavka.req_type%type      default null,  -- Тип заявки
    p_vdateplan     in  zayavka.vdate_plan%type    default null,  -- Плановая дата валютирования
    p_obz           in  zayavka.obz%type           default null,  -- Признак заявки на обязательную продажу (1)
    p_rnk_pf        in  zayavka.rnk_pf%type        default null   -- для покупки - рег.№ клиента в пф для продажи: код для 27-го файла
    )
is
  l_acc0     accounts.acc%type;
  l_acc1     accounts.acc%type;
  l_kv       zayavka.kv2%type;
  l_dig      tabval.dig%type;
  l_viza     zayavka.viza%type;
  l_dk       zayavka.dk%type;
  l_kv_conv  zayavka.kv_conv%type;

  ern        NUMBER;          -- код ошибки (из err_zay)
  msg        VARCHAR2(254);   -- текстовка ошибки "для себя"
  err        EXCEPTION;
  prm        VARCHAR2(25)  := null;  -- параметр, передаваемый в сообщения об ошибке
  prm1       VARCHAR2(25)  := null;  -- параметр, передаваемый в сообщения об ошибке
  l_title    varchar2(30)  := 'zay.upd_request:';

begin

  bars_audit.info( l_title||': Entry with ( p_id='||to_char(p_id)||
                                         ', p_mfo0='||p_mfo0||
                                         ', p_kv_conv='||to_char(p_kv_conv)||
                                         ' ).' );

  begin
    select z.kv2, t.dig, z.viza, z.dk, z.kv_conv
      into l_kv,  l_dig, l_viza, l_dk, l_kv_conv
      from zayavka z, tabval t
     where z.id = p_id and z.kv2 = t.kv;

    bars_audit.info( 'l_dk=' || to_char(l_dk)||', l_kv_conv='||to_char(l_kv_conv) );

  exception when no_data_found then
         msg  := 'Заявка ' || p_id || ' не найдена!' ;
         ern  := 6;
         prm := p_id;
         bars_audit.trace('%s Неуспешное изменение параметров заявки № %s - %s', l_title, to_char(p_id), to_char(msg));
         raise err;
  end;

  if l_viza >= 1 then
         msg  := 'Заявка ' || p_id || ' завизирована!' ;
         ern  := 25;
         prm := p_id;
         bars_audit.trace('%s Неуспешное изменение параметров заявки № %s - %s', l_title, to_char(p_id), to_char(msg));
         raise err;
  end if;

  if l_dk in (1,3) or (l_dk = 2 and nvl(p_mfo0,f_ourmfo()) = f_ourmfo() ) then
    begin
     select acc
       into l_acc0
       from accounts
      where nls = p_nls_acc0
        and kv  = decode(l_dk, 3, nvl(p_kv_conv,l_kv_conv), 980);
    exception when no_data_found then
           msg  := 'Не найден т/с ' || p_nls_acc0 || ' вал '||iif_n(l_dk, 3, 980, p_kv_conv, 980) ;
           ern  := 26;
           prm  := p_nls_acc0;
           bars_audit.trace('%s Неуспешное изменение параметров заявки № %s - %s', l_title, to_char(p_id), to_char(msg));
           raise err;
    end;
  else
     l_acc0 := null;
  end if;

  begin
   select acc into l_acc1 from accounts where nls = p_nls and kv = l_kv;
  exception when no_data_found then
         msg  := 'Не найден р/с ' || p_nls || ' вал ' || l_kv ;
         ern  := 27;
         prm  := p_nls;
         prm1 := l_kv;
         bars_audit.trace('%s Неуспешное изменение параметров заявки № %s - %s', l_title, to_char(p_id), to_char(msg));
         raise err;
  end;

  if p_fdat < gl.bd - gZAYDAY - ( case when l_dk in (1, 3) then 0 else 1 end ) then
         msg  := 'Дата заявки ' || p_id || ' устарела!' ;
         ern  := 28;
         prm  := p_id;
         bars_audit.trace('%s Неуспешное  изменение параметров заявки № %s - %s', l_title, to_char(p_id), to_char(msg));
         raise err;
  end if;

   UPDATE zayavka
       SET nd   = p_nd,
           acc0 = l_acc0,
           acc1 = l_acc1,
             s2 = DECODE((SELECT nvl(min(d.blk),0)
                            FROM diler_kurs d
                           WHERE d.kv = kv2
                             AND d.dat = (SELECT max(dat)
                                            FROM diler_kurs
                                           WHERE trunc(dat) = trunc(sysdate)
                                             AND kv = d.kv)
                        ), 0, p_s2s*power(10,l_dig), s2),
            kom = p_kom,
           skom = p_skom,
           fdat = p_fdat,
         kurs_z = p_kurs,
        KV_CONV = nvl(p_kv_conv,KV_CONV),
           mfo0 = p_mfo0,
           nls0 = p_nls0,
       contract = p_contract,
       dat2_vmd = p_dat2_vmd,
        dat_vmd = p_dat_vmd,
       dat5_vmd = p_dat5_vmd,
        num_vmd = p_num_vmd,
           meta = p_meta,
           f092 = p_f092,
        country = p_country,
          basis = decode(p_basis,substr(basis,1,254),basis,p_basis),
   benefcountry = p_benefcountry,
      bank_code = p_bank_code,
      bank_name = p_bank_name,
  product_group = p_product_group,
           comm = p_comm,
    contact_fio = p_contactfio,
    contact_tel = p_contacttel,
          fl_pf = nvl(p_pf,fl_pf),
       req_type = nvl(p_req_type,req_type),
     vdate_plan = p_vdateplan,
            obz = p_obz,
         rnk_pf = p_rnk_pf,
            isp = user_id
       WHERE id = p_id;

   UPDATE zay_track SET userid = user_id WHERE id = p_id;

  if gZAYMODE = 2 then
     -- позвать web-сервис
     service_request(p_id,2);
  end if;

EXCEPTION
   WHEN err THEN
      bars_error.raise_error('ZAY', ern, prm, prm1);

end upd_request;


-------------------------------------------------------------------------------
--
-- Создание/Изменение/Удаление параметров клиента
--
procedure upd_custzay
   (p_mode          in number,               -- режим (0-insert, 1-update, 2-delete)
    p_rnk           in cust_zay.rnk%type,    -- Рег.номер клиента
    p_nls29         in cust_zay.nls29%type   default null,  --Торговый счет для списания
    p_nls26         in cust_zay.nls26%type   default null,  -- Расчетный счет для зачисления
    p_mfo26         in cust_zay.mfo26%type   default null,  -- МФО расчетного счета
    p_okpo26        in cust_zay.okpo26%type  default null,  -- ОКПО клиента
    p_kom           in cust_zay.kom%type     default null,  -- % комиссии (покупка)
    p_kom2          in cust_zay.kom2%type    default null,  -- % комиссии (продажа)
    p_kom3          in cust_zay.kom3%type    default null,  -- % комиссии (конверсия)
    p_tel           in cust_zay.tel%type     default null,  -- Контактный телефон
    p_fio           in cust_zay.fio%type     default null,  -- ФИО контактного лица
    p_mfov          in cust_zay.mfov%type    default null,  -- МФО банка для возврата излишка грн
    p_nlsv          in cust_zay.nlsv%type    default null,  -- Счет клиента для возврата излишка грн
    p_nls_kom       in cust_zay.nls_kom%type default null,  -- Счет комиссии банка (покупка)
    p_nls_kom2      in cust_zay.nls_kom2%type    default null,  -- Счет комиссии банка (продажа)
    p_custacc4cms   in cust_zay.custacc4cms%type default null,  -- Альтернат.счет клиента для списания комиссии
    p_nls_pf        in cust_zay.nls_pf%type      default null   -- Счет для списания ПФ
    )
is

  ern        NUMBER;          -- код ошибки (из err_zay)
  msg        VARCHAR2(254);   -- текстовка ошибки "для себя"
  err        EXCEPTION;
  prm        VARCHAR2(25)  := null;  -- параметр, передаваемый в сообщения об ошибке
  prm1       VARCHAR2(25)  := null;  -- параметр, передаваемый в сообщения об ошибке
  l_title    varchar2(30)  := 'zay.upd_custzay:';
  l_tmode    varchar2(20)  := null;

  l_nls29    cust_zay.nls29%type;
  l_nls26    cust_zay.nls29%type;
  l_mfo26    cust_zay.mfo26%type;
  l_mfov     cust_zay.mfov%type;
  l_nlsv     cust_zay.nlsv%type;
  l_nls_kom  cust_zay.nls_kom%type;
  l_nls_kom2 cust_zay.nls_kom2%type;
  l_acc      accounts.acc%type;
  l_acccms   accounts.acc%type;
  l_nls_cms  accounts.nls%type;
  l_accpf    accounts.acc%type;
  l_nls_pf   accounts.nls%type;


begin
------------------------
  if p_mode = 0 then
    l_tmode := 'inserting cust_zay';

    if p_rnk is not null and p_nls29 is not null then
    begin
      select acc into l_acc from accounts where nls = p_nls29 and kv = 980 and rnk = p_rnk;
    exception when no_data_found then
         msg  := 'Не найден т/с ' || p_nls29 || ' вал 980' ;
         ern  := 4;
         prm1  := p_rnk;
         prm   := p_nls29;
         bars_audit.trace('%s %s ERROR - p_rnk=>%s, p_nls29=>%s', l_title, l_tmode, to_char(p_rnk), to_char(p_nls29));
         raise err;
    end;
    end if;

    if p_mfo26 is not null and p_nls26 is not null then
     if p_mfo26 = f_ourmfo() then
       begin
         select acc into l_acc from accounts where nls = p_nls26 and rnk = p_rnk and rownum = 1;
       exception when no_data_found then
            msg  := 'Не найден p/с ' || p_nls26 ;
            ern  := 4;
            prm1  := p_rnk;
            prm   := p_nls26;
            bars_audit.trace('%s %s ERROR - p_rnk=>%s, p_nls26=>%s', l_title, l_tmode, to_char(p_rnk), to_char(p_nls26));
            raise err;
       end;
     end if;
    end if;

    if p_mfov is not null and p_nlsv is not null then
     if p_mfov = f_ourmfo() then
       begin
         select acc into l_acc from accounts where nls = p_nlsv and rnk = p_rnk and rownum = 1;
       exception when no_data_found then
            msg  := 'Не найден счет возврата излишков' || p_nlsv ;
            ern  := 4;
            prm1  := p_rnk;
            prm   := p_nlsv;
            bars_audit.trace('%s %s ERROR - p_rnk=>%s, p_nlsv=>%s', l_title, l_tmode, to_char(p_rnk), to_char(p_nlsv));
            raise err;
       end;
     else
       if vkrzn(substr(p_mfov,1,5),p_nlsv) <> p_nlsv then
            msg  := 'Неверный контрольный разряд ' || p_nlsv  || ' для ' || p_mfov;
            ern  := 29;
            prm1  := p_mfov;
            prm   := p_nlsv;
            bars_audit.trace('%s %s ERROR - p_mfov=>%s, p_nlsv=>%s', l_title, l_tmode, to_char(p_mfov), to_char(p_nlsv));
            raise err;
       end if;
     end if;
    end if;

    if p_NLS_KOM is not null then
       if vkrzn(substr(f_ourmfo(),1,5),p_NLS_KOM) <> p_NLS_KOM then
            msg  := 'Неверный контрольный разряд ' || p_NLS_KOM  || ' для ' || f_ourmfo();
            ern  := 29;
            prm1  := f_ourmfo();
            prm   := p_NLS_KOM;
            bars_audit.trace('%s %s ERROR - f_ourmfo()=>%s, p_NLS_KOM=>%s', l_title, l_tmode, to_char(f_ourmfo()), to_char(p_NLS_KOM));
            raise err;
       end if;
    end if;

    if p_NLS_KOM2 is not null then
       if vkrzn(substr(f_ourmfo(),1,5),p_NLS_KOM2) <> p_NLS_KOM2 then
            msg  := 'Неверный контрольный разряд ' || p_NLS_KOM2  || ' для ' || f_ourmfo();
            ern  := 29;
            prm1  := f_ourmfo();
            prm   := p_NLS_KOM2;
            bars_audit.trace('%s %s ERROR - f_ourmfo()=>%s, NLS_KOM2=>%s', l_title, l_tmode, to_char(f_ourmfo()), to_char(p_NLS_KOM2));
            raise err;
       end if;
    end if;

    if p_custacc4cms is not null then
       begin
         select acc into l_acccms from accounts where nls = p_custacc4cms and kv = 980 and rnk = p_rnk and rownum = 1;
       exception when no_data_found then
            msg  := 'Не найден альтернативный счет списания комиссии ' || p_custacc4cms ;
            ern  := 4;
            prm1  := p_rnk;
            prm   := p_custacc4cms;
            bars_audit.trace('%s %s ERROR - p_rnk=>%s, p_custacc4cms=>%s', l_title, l_tmode, to_char(p_rnk), to_char(p_custacc4cms));
            raise err;
       end;
    end if;

    if p_nls_pf is not null then
       begin
         select acc into l_accpf from accounts where nls = p_nls_pf and kv = 980 and rnk = p_rnk and rownum = 1;
       exception when no_data_found then
            msg  := 'Не найден счет списания ПФ ' || p_custacc4cms ;
            ern  := 4;
            prm1  := p_rnk;
            prm   := p_nls_pf;
            bars_audit.trace('%s %s ERROR - p_rnk=>%s, p_nls_pf=>%s', l_title, l_tmode, to_char(p_rnk), to_char(p_nls_pf));
            raise err;
       end;
    end if;


    Insert into CUST_ZAY (  RNK,   NLS29,   NLS26,   MFO26,   OKPO26,   TEL,   FIO,   KOM,   KOM2,   KOM3,   MFOV,   NLSV,   NLS_KOM,   NLS_KOM2,   CUSTACC4CMS,   NLS_PF)
                  Values (p_rnk, p_nls29, p_nls26, p_mfo26, p_okpo26, p_tel, p_fio, p_kom, p_kom2, p_kom3, p_mfov, p_nlsv, p_nls_kom, p_nls_kom2, p_custacc4cms, p_nls_pf);

    bars_audit.trace('%s %s SUCCESS - p_rnk=>%s', l_title, l_tmode, to_char(p_rnk));

----------------------
  elsif p_mode = 1 then
    l_tmode := 'updating cust_zay';

    select   NLS29,   NLS26,   MFO26,   MFOV,   NLSV,   NLS_KOM,   NLS_KOM2, custacc4cms, NLS_PF
      into l_nls29, l_nls26, l_mfo26, l_mfov, l_nlsv, l_nls_kom, l_nls_kom2, l_nls_cms, l_nls_pf
      from cust_zay where rnk = p_rnk;

    if p_nls29 is not null and p_nls29<>nvl(l_nls29,0) then
    begin
      select acc into l_acc from accounts where nls = p_nls29 and kv = 980 and rnk = p_rnk;
    exception when no_data_found then
         msg  := 'Не найден т/с ' || p_nls29 || ' вал 980' ;
         ern  := 4;
         prm1  := p_rnk;
         prm   := p_nls29;
         bars_audit.trace('%s %s ERROR - p_rnk=>%s, p_nls29=>%s', l_title, l_tmode, to_char(p_rnk), to_char(p_nls29));
         raise err;
    end;
    end if;

    if p_mfo26 is not null and p_nls26 is not null and (p_mfo26<>l_mfo26 or p_nls26<>l_nls26) then
     if p_mfo26 = f_ourmfo() then
       begin
         select acc into l_acc from accounts where nls = p_nls26 and rnk = p_rnk and rownum = 1;
       exception when no_data_found then
            msg  := 'Не найден p/с ' || p_nls26 ;
            ern  := 4;
            prm1  := p_rnk;
            prm   := p_nls26;
            bars_audit.trace('%s %s ERROR - p_rnk=>%s, p_nls26=>%s', l_title, l_tmode, to_char(p_rnk), to_char(p_nls26));
            raise err;
       end;
     end if;
    end if;

    if p_mfov is not null and p_nlsv is not null and (p_mfov<>l_mfov or p_nlsv<>l_nlsv) then
     if p_mfov = f_ourmfo() then
       begin
         select acc into l_acc from accounts where nls = p_nlsv and rnk = p_rnk and rownum = 1;
       exception when no_data_found then
            msg  := 'Не найден счет возврата излишков' || p_nlsv ;
            ern  := 4;
            prm1  := p_rnk;
            prm   := p_nlsv;
            bars_audit.trace('%s %s ERROR - p_rnk=>%s, p_nlsv=>%s', l_title, l_tmode, to_char(p_rnk), to_char(p_nlsv));
            raise err;
       end;
     else
       if vkrzn(substr(p_mfov,1,5),p_nlsv) <> p_nlsv then
            msg  := 'Неверный контрольный разряд ' || p_nlsv  || ' для ' || p_mfov;
            ern  := 29;
            prm1  := p_mfov;
            prm   := p_nlsv;
            bars_audit.trace('%s %s ERROR - p_mfov=>%s, p_nlsv=>%s', l_title, l_tmode, to_char(p_mfov), to_char(p_nlsv));
            raise err;
       end if;
     end if;
    end if;

    if p_NLS_KOM is not null and p_nls_kom<>l_nls_kom  then
       if vkrzn(substr(f_ourmfo(),1,5),p_NLS_KOM) <> p_NLS_KOM then
            msg  := 'Неверный контрольный разряд ' || p_NLS_KOM  || ' для ' || f_ourmfo();
            ern  := 29;
            prm1  := f_ourmfo();
            prm   := p_NLS_KOM;
            bars_audit.trace('%s %s ERROR - f_ourmfo()=>%s, p_NLS_KOM=>%s', l_title, l_tmode, to_char(f_ourmfo()), to_char(p_NLS_KOM));
            raise err;
       end if;
    end if;

    if p_NLS_KOM2 is not null and p_nls_kom2<>l_nls_kom2 then
       if vkrzn(substr(f_ourmfo(),1,5),p_NLS_KOM2) <> p_NLS_KOM2 then
            msg  := 'Неверный контрольный разряд ' || p_NLS_KOM2  || ' для ' || f_ourmfo();
            ern  := 29;
            prm1  := f_ourmfo();
            prm   := p_NLS_KOM2;
            bars_audit.trace('%s %s ERROR - f_ourmfo()=>%s, p_NLS_KOM2=>%s', l_title, l_tmode, to_char(f_ourmfo()), to_char(p_NLS_KOM2));
            raise err;
       end if;
    end if;

    if p_custacc4cms is not null and p_custacc4cms<>l_nls_cms then
       begin
         select acc into l_acccms from accounts where nls = p_custacc4cms and kv = 980 and rnk = p_rnk and rownum = 1;
       exception when no_data_found then
            msg  := 'Не найден альтернативный счет списания комиссии ' || p_custacc4cms ;
            ern  := 4;
            prm1  := p_rnk;
            prm   := p_custacc4cms;
            bars_audit.trace('%s %s ERROR - p_rnk=>%s, p_custacc4cms=>%s', l_title, l_tmode, to_char(p_rnk), to_char(p_custacc4cms));
            raise err;
       end;
    end if;

    if p_nls_pf is not null and p_nls_pf<>l_nls_pf then
       begin
         select acc into l_accpf from accounts where nls = p_nls_pf and kv = 980 and rnk = p_rnk and rownum = 1;
       exception when no_data_found then
            msg  := 'Не найден счет списания ПФ ' || p_nls_pf ;
            ern  := 4;
            prm1  := p_rnk;
            prm   := p_nls_pf;
            bars_audit.trace('%s %s ERROR - p_rnk=>%s, p_nls_pf=>%s', l_title, l_tmode, to_char(p_rnk), to_char(p_nls_pf));
            raise err;
       end;
    end if;

    update CUST_ZAY
       set NLS29 = p_nls29, NLS26 = p_nls26, MFO26 = p_mfo26, OKPO26 = p_okpo26, TEL = p_tel, FIO = p_fio, KOM = p_kom,
           KOM2 = p_kom2, KOM3 = p_kom3, MFOV = p_mfov, NLSV = p_nlsv, NLS_KOM = p_nls_kom, NLS_KOM2 = p_nls_kom2, CUSTACC4CMS = p_custacc4cms,
           nls_pf = p_nls_pf
     where rnk = p_rnk;

    bars_audit.trace('%s %s SUCCESS - p_rnk=>%s', l_title, l_tmode, to_char(p_rnk));

----------------------
  elsif p_mode = 2 then
    l_tmode := 'deleting cust_zay';
    delete from cust_zay where rnk = p_rnk;
    if sql%rowcount > 0 then
        bars_audit.trace('%s %s SUCCESS - p_rnk=>%s', l_title, l_tmode, to_char(p_rnk));
    end if;

  end if;

EXCEPTION
   WHEN dup_val_on_index THEN
      bars_error.raise_error('ZAY', 43, null);
   WHEN err THEN
      bars_error.raise_error('ZAY', ern, prm, prm1);

end upd_custzay;



-------------------------------------------------------------------------------
procedure set_conv_kurs (
  p_kv1       diler_kurs_conv.kv1%type,
  p_kv2       diler_kurs_conv.kv2%type,
  p_dat       diler_kurs_conv.dat%type,
  p_kurs      diler_kurs_conv.kurs_i%type,
  p_kurstype  number )
is
  l_kurs_i diler_kurs_conv.kurs_i%type;
  l_kurs_f diler_kurs_conv.kurs_f%type;
begin
  l_kurs_i := case when p_kurstype = 1 then p_kurs else null end;
  l_kurs_f := case when p_kurstype = 2 then p_kurs else null end;
  insert into diler_kurs_conv (dat, kv1, kv2, kurs_i, kurs_f)
  values (p_dat, p_kv1, p_kv2, l_kurs_i, l_kurs_f);
exception when dup_val_on_index then
  update diler_kurs_conv
     set kurs_i = nvl(l_kurs_i, kurs_i),
         kurs_f = nvl(l_kurs_f, kurs_f)
   where dat = p_dat
     and kv1 = p_kv1
     and kv2 = p_kv2;
end set_conv_kurs;


-------------------------------------------------------------------------------
--
-- Визирование заявки - проставление параметров
--
  procedure set_visa_parameters (
    p_id        in zayavka.id%type,
    p_verify_opt  in zayavka.verify_opt%type,
    p_meta      in zayavka.meta%type        default null,
    p_f092      in zayavka.f092%type        default null,
    p_contract  in zayavka.contract%type    default null,
    p_dat2_vmd  in zayavka.dat2_vmd%type    default null,
    p_dat_vmd   in zayavka.dat_vmd%type     default null,
    p_dat5_vmd  in zayavka.dat5_vmd%type    default null,
    p_country   in zayavka.country%type     default null,
    p_basis     in zayavka.basis%type       default null,
    p_benefcountry  in zayavka.benefcountry%type  default null,
    p_bank_name  in zayavka.bank_name%type  default null,
    p_bank_code  in zayavka.bank_code%type  default null,
    p_product_group  in zayavka.product_group%type  default null,
    p_num_vmd  in zayavka.num_vmd%type      default null,
    p_code_2c  in zayavka.code_2c%type      default null,
    p_p12_2c   in zayavka.p12_2c%type       default null)
is
    l_upd   varchar2(4000);
begin
    l_upd := 'update zayavka set verify_opt = '||p_verify_opt;
    if p_meta is not null then l_upd := l_upd||', meta = '||p_meta; end if;
    if p_f092 is not null then l_upd := l_upd||', f092 = '||p_f092; end if;
    if p_contract is not null then l_upd := l_upd||', contract = '''||p_contract||''''; end if;
    if p_dat2_vmd is not null then l_upd := l_upd||', dat2_vmd = '''||p_dat2_vmd ||''''; end if;
    if p_dat_vmd is not null then l_upd := l_upd||', dat_vmd = '''||p_dat_vmd||''''; end if;
    if p_dat5_vmd is not null then l_upd := l_upd||', dat5_vmd = '''||p_dat5_vmd || ''''; end if;
    if p_country is not null then l_upd := l_upd||', country = '||p_country; end if;
    if p_basis is not null then l_upd := l_upd||', basis = '''||p_basis||''''; end if;
    if p_benefcountry is not null then l_upd := l_upd||', benefcountry = '||p_benefcountry; end if;
    if p_bank_name is not null then l_upd := l_upd||', bank_name = '''||replace(p_bank_name,'''','''''')||''''; end if;
    if p_bank_code is not null then l_upd := l_upd||', bank_code = '''||p_bank_code||''''; end if;
    if p_product_group is not null then l_upd := l_upd||', product_group = '||p_product_group; end if;
    if p_num_vmd is not null then l_upd := l_upd||', num_vmd = '''||p_num_vmd||''''; end if;
    if p_code_2c is not null then l_upd := l_upd||', code_2c = '''||p_code_2c||''''; end if;
    if p_p12_2c is not null then l_upd := l_upd||', p12_2c = '''||p_p12_2c||''''; end if;
    l_upd := l_upd||' where id = '||p_id;
    execute immediate l_upd;
end;

-------------------------------------------------------------------------------
--
-- Визирование заявки
--
procedure set_visa (
  p_id        in zayavka.id%type,
  p_viza      in zayavka.viza%type,
  p_priority  in zayavka.priority%type  default null,
  p_aims_code in zayavka.aims_code%type default null,
  p_f092      in zayavka.f092%type default null,
  p_sup_doc   in zayavka.support_document%type default null)
is
 l_trace varchar2(500):='bars_zay.set_visa';
begin
  bars_audit.info(l_trace||'.1.'||p_id||'.'||p_viza);
  update zayavka
     set viza      = p_viza,
         priority  = nvl(p_priority, priority),
         aims_code = nvl(p_aims_code, aims_code),
         f092 = nvl(p_f092, f092)
   where id = p_id;

   if nvl(p_sup_doc,0)<>0 then
    bars_zay.set_support_document (p_id, p_sup_doc);
   end if;

   -- позвать web-сервис
   if gZAYMODE = 2 then
      if p_viza = 2 then
          bars_audit.info(l_trace||'.2.'||p_id||'.'||p_viza);
         -- web-сервис-2 на изменение визы
         service_request(p_id,3);
      else
         -- web-сервис-1 на изменение всего
          bars_audit.info(l_trace||'.3.'||p_id||'.'||p_viza);
         service_request(p_id, 3);
      end if;
   end if;
end set_visa;

-- Подверждение наличия сопровождающих документов
procedure set_support_document (
  p_id                in zayavka.id%type,
  p_support_document  in zayavka.support_document%type
  )
is
 l_trace varchar2(500):='bars_zay.set_support_document';
begin
  bars_audit.info(l_trace||'.'||p_id||'.'||p_support_document);
  update zayavka z
     set z.support_document =p_support_document
   where id = p_id;

end set_support_document;

function get_support_document (
  p_refd oper.ref%type,
  p_tt oper.tt%type) return number
is
cursor c_cur is
   select z.support_document,z.sos, zd.tip
     from zay_debt zd,
          zayavka z
   where zd.refd = p_refd
     and zd.ref=z.refoper(+);
 l_support_document  zayavka.support_document%type;
 l_sos               zayavka.sos%type;
 l_tip               zay_debt.tip%type;
begin
  if p_tt = obz_tt then
    open  c_cur;
    fetch c_cur into l_support_document, l_sos, l_tip;
    close c_cur;
    if l_tip = 1 then
      return 1;
    elsif l_support_document=1 then
      return l_support_document;
    elsif l_sos = 2 then
      return 1;
    else
      return 0;
    end if;
  end if;
end;

-------------------------------------------------------------------------------
--
-- Удовлетворение заявки
--
procedure set_sos (
  p_id         in zayavka.id%type,
  p_kurs_f     in zayavka.kurs_f%type,
  p_sos        in zayavka.sos%type,
  p_vdate      in zayavka.vdate%type,
  p_close_type in zayavka.close_type%type,
  p_fdat       in zayavka.fdat%type )
is
  i             number;
  --l_priorverify zay_priority.verify%type;
  l_branch      zayavka.branch%type;
  l_sos         number;
  l_dil_viza    number;
begin

--  select priorverify into l_priorverify from v_zay where id = p_id;

  select branch into l_branch from v_zay where id = p_id and sos<2 and sos>-1;

  if (p_kurs_f is not null and p_vdate is not null) then
    -- if l_priorverify = 1  then
        if gZAYMODE = 0 then
           update zayavka
              set kurs_f = p_kurs_f,
                  sos    = p_sos,
                  vdate  = p_vdate,
                  close_type = p_close_type
            where id    = p_id
              and sos  >= 0
              and sos   < 1
              and fdat <= p_fdat;
        elsif gZAYMODE = 1 then
           -- Определяем, чья заявка: ЦА или РУ
           begin
              select 1 into i from zayavka where id = p_id and branch = l_branch;
              update zayavka
                 set kurs_f = p_kurs_f,
                     sos    = p_sos,
                     vdate  = p_vdate,
                     close_type = p_close_type
               where id    = p_id and branch = l_branch
                 and sos  >= 0
                 and sos   < 1
                 and fdat <= p_fdat;
           exception when no_data_found then
              begin
                 select 1 into i from zayavka_ru where id = p_id and branch = l_branch;
                 update zayavka_ru
                    set kurs_f = p_kurs_f,
                        sos    = p_sos,
                        vdate  = p_vdate,
                        close_type = p_close_type
                  where id    = p_id and branch = l_branch
                    and sos  >= 0
                    and sos   < 1
                    and fdat <= p_fdat;
              exception when no_data_found then
                 raise_application_error(-20000, 'Заявка ид.=' || p_id || ' не найдена.');
              end;
           end;
        elsif gZAYMODE = 2 then
           bars_error.raise_nerror (modcode, 'FAILED_SET_SOS', to_char(p_id));
        end if;
    -- else
    --    bars_error.raise_nerror (modcode, 'PRIORVERIFY_FAILED', to_char(p_id));
    -- end if;
  else
     bars_error.raise_nerror (modcode, 'FAILED_KURSF_OR_VDATE', to_char(p_id));
  end if;
end set_sos;

-------------------------------------------------------------------------------
--
-- Передать изменения состояния заявки в РУ
--
procedure p_viza_reqesr_transfer(p_id number)
is
  l_request       soap_rpc.t_request;
  l_response      soap_rpc.t_response;
  l_clob          clob;
  l_error         varchar2(2000);
  l_parser        dbms_xmlparser.parser;
  l_doc           dbms_xmldom.domdocument;
  l_reslist       dbms_xmldom.DOMNodeList;
  l_res           dbms_xmldom.DOMNode;
  l_str           varchar2(2000);
  l_status        varchar2(100);
  l_tmp           xmltype;
  ret_            varchar2(256);
  l_date          date;
  l_req_id        number;
  l_kurs_f        number;
  l_sos           number;
  l_vdate         varchar2(10);
  l_close_type    number;
  l_dat_z         varchar2(10);
  l_url           varchar2(256);
  l_mfo           varchar2(10);
  l_viza          zayavka.viza%type;
  l_id_back       zayavka.idback%type;
  l_reason_comm   zayavka.reason_comm%type;
begin

bars_audit.info ('gZAYMODE='||gZAYMODE);
  if gZAYMODE = 1 then

      select z.url, z.mfo
        into l_url, l_mfo
        from zay_recipients z
       where z.mfo = (select zr.mfo from zayavka_ru zr where zr.id = p_id);

    select r.req_id,
      r.kurs_f,
      r.sos,
      to_char(r.vdate, 'dd.mm.yyyy'),
      r.close_type,
      to_char(r.datz,'dd.mm.yyyy'),
      r.viza,
      r.idback,
      r.reason_comm
    into
      l_req_id,
      l_kurs_f,
      l_sos,
      l_vdate,
      l_close_type,
      l_dat_z,
      l_viza,
      l_id_back,
      l_reason_comm
    from zayavka_ru r
    where id = p_id;

    l_request := soap_rpc.new_request(p_url       => l_url,
                                      p_namespace => 'http://tempuri.org/',
                                      p_method    => 'ChangeSOS',
                                      p_wallet_dir =>  gWallet_dir,
                                      p_wallet_pass => gWallet_pass);
    -- добавить параметры
    soap_rpc.add_parameter(l_request, 'req_id', to_char(l_req_id));
    if l_kurs_f is not null then
    soap_rpc.add_parameter(l_request, 'kurs_f', to_char(l_kurs_f));
    end if;
    soap_rpc.add_parameter(l_request, 'sos', to_char(l_sos));
    if l_vdate is not null then
      soap_rpc.add_parameter(l_request, 'vdate', l_vdate);
    end if;
    if l_close_type is not null then
        soap_rpc.add_parameter(l_request,
                               'close_type',
                               to_char(l_close_type));
    end if;
    if l_dat_z is not null then
      soap_rpc.add_parameter(l_request, 'dat_z',  to_char(l_dat_z));
    end if;
    if l_viza is not null then
      soap_rpc.add_parameter(l_request, 'viza',  to_char(l_viza));
    end if;
    if l_id_back is not null then
      soap_rpc.add_parameter(l_request, 'id_back',  to_char(l_id_back));
    end if;
    if l_reason_comm is not null then
      soap_rpc.add_parameter(l_request, 'reason_comm',  l_reason_comm);
    end if;

    soap_rpc.add_parameter(l_request, 'mfo', l_mfo);
    -- позвать метод веб-сервиса
    begin
      l_response := soap_rpc.invoke(l_request);

      --разбираем ответ
      l_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
      l_tmp  := xmltype(l_clob);
      l_clob := l_response.doc.getClobVal();
      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob(l_parser, l_clob);
      l_doc := dbms_xmlparser.getdocument(l_parser);
      l_reslist := dbms_xmldom.getelementsbytagname(l_doc,'ChangeSOSResult');
      l_res     := dbms_xmldom.item(l_reslist, 0);
      dbms_xslprocessor.valueof(l_res, 'Status/text()', l_str);
      l_status := substr(l_str, 1, 200);

      if l_status = 'error' then
        dbms_xslprocessor.valueof(l_res, 'ErrorMessage/text()', l_str);
        p_data_transfer(p_req_id => p_id,
                        p_url    => l_url,
                        p_mfo    => l_mfo,
                        p_type   => 5,
                        p_date   => sysdate,
                        p_result => gTransfer_eroor,
                        p_comm   => 'error = ' || substr(l_str, 1, 1000)
                        );
      elsif l_status <> 'ok' then
        p_data_transfer(p_req_id => p_id,
                        p_url    => l_url,
                        p_mfo    => l_mfo,
                        p_type   => 5,
                        p_date   => sysdate,
                        p_result => gTransfer_eroor,
                        p_comm   => 'Необрабатываемое значение статуса - ' || l_status
                        );
      elsif l_status = 'ok' then
        p_data_transfer(p_req_id => p_id,
                        p_url    => l_url,
                        p_mfo    => l_mfo,
                        p_type   => 5,
                        p_date   => sysdate,
                        p_result => gTransfer_success,
                        p_comm   => 'До РУ (МФО '||l_mfo||') успішно передано інформацію про задоволення заявки '||p_id
                        );
        end if;
        dbms_xmlparser.freeparser(l_parser);
        DBMS_XMLDOM.freeDocument(l_doc);
    exception when others then
      dbms_xmlparser.freeparser(l_parser);
      DBMS_XMLDOM.freeDocument(l_doc);
      l_error := substr(sqlerrm, 1, 2000);
      bars_audit.error('set_request ERROR: ' || l_error);
      l_error := substr(sqlerrm, 1, 1000);
      p_data_transfer(p_req_id => p_id,
                        p_url    => l_url,
                        p_mfo    => l_mfo,
                        p_type   => 5,
                        p_date   => sysdate,
                        p_result => gTransfer_eroor,
                        p_comm   => 'exception - ' || l_error
                        );
    end;
  end if;
end p_viza_reqesr_transfer;

-------------------------------------------------------------------------------
--
--  Визирование курса дилера
--
procedure visa_kurs (
  p_id   in zayavka.id%type,
  p_datz in zayavka.datz%type )
is
  l_reqid    zayavka_ru.req_id%type;
  l_mfo      zayavka_ru.mfo%type;
  l_trackid  integer;
  l_viza     zayavka_ru.viza%type;
  l_branch   zayavka.branch%type;
begin

  select branch into l_branch from v_zay where id = p_id and sos<2 and sos>-1;

  if gZAYMODE = 0 then
     update zayavka
        set sos  = 1,
            datz = p_datz
      where id  = p_id
        and sos = 0.5;
  elsif gZAYMODE = 1 then
     -- Определяем, чья заявка: ЦА или РУ
     begin
        select id into l_reqid from zayavka where id = p_id and branch = l_branch;
        update zayavka
           set sos  = 1,
               datz = p_datz
         where id  = p_id and branch = l_branch
           and sos = 0.5;
     exception when no_data_found then
        begin
           -- zayavka_ru.id - ид.в ЦА (zayavka_ru.req_id-ид.в РУ)
           select req_id, mfo, viza into l_reqid, l_mfo, l_viza from zayavka_ru where id = p_id and branch = l_branch;
           update zayavka_ru
              set sos  = 1,
                  datz = p_datz
            where id  = p_id and branch = l_branch
              and sos = 0.5;

           l_trackid := bars_sqnc.get_nextval('s_zay_track');
           -- зберігаємо історію змін статусів документів
           insert into zay_track_ru (mfo, track_id, req_id, change_time, fio, sos, viza)
           values(l_mfo, l_trackid, l_reqid, sysdate, f_get_userfio(USER_ID), 1, l_viza);

           -- позвать web-сервис
           -- отправить информацию в РУ
           p_viza_reqesr_transfer(p_id);
        exception when no_data_found then
           raise_application_error(-20000, 'Заявка ид.=' || p_id || ' не найдена.');
        end;
     end;
  elsif gZAYMODE = 2 then
     raise_application_error(-20000, 'Пользователям РУ запрещено визировать курсы.');
  end if;

end visa_kurs;

-------------------------------------------------------------------------------
--
-- Удаление заявки
--
procedure del_request (
  p_id   in zayavka.id%type,
  p_flag in number )
is
  l_branch   zayavka.branch%type;
begin
  select branch into l_branch from v_zay where id = p_id and sos<=2;

   update zayavka
      set sos    = -1,
          viza   = -1,
          idback = -1
    where id     = p_id  and branch = l_branch
      and sos    = 0
      and (  p_flag = 0 and viza <  1
          or p_flag = 1 and viza >= 1 );

    if sql%rowcount > 0 and gZAYMODE = 2 then
      -- позвать web-сервис
      service_request(p_id,2);
    end if;
end del_request;

-------------------------------------------------------------------------------
--
-- Возврат заявки
--
procedure back_request (
  -- p_mode - режим возврата заявки:
  --   4 - с удовлетворения дилером (visa=>2)
  --   5 - с визирования курсов дилара (visa=>1)
  --   3, 2 и проч. - с визирования (visa=>-1)
  p_mode   in number,
  p_id     in zayavka.id%type,
  p_idback in zayavka.idback%type,
  p_comm   in zayavka.reason_comm%type )
is
  l_send_request_ru boolean := false;
  l_reqid         zayavka_ru.req_id%type;
  l_request       soap_rpc.t_request;
  l_response      soap_rpc.t_response;
  l_url           zay_recipients.url%type;
  l_mfo           zay_recipients.mfo%type;
  l_clob          clob;
  l_error         varchar2(2000);
  l_parser        dbms_xmlparser.parser;
  l_doc           dbms_xmldom.domdocument;
  l_reslist       dbms_xmldom.DOMNodeList;
  l_res           dbms_xmldom.DOMNode;
  l_str           varchar2(2000);
  l_status        varchar2(100);
  l_tmp           xmltype;
  l_branch        zayavka.branch%type;
begin

  select branch into l_branch from v_zay where id = p_id and sos<2 and sos>-1;

  if p_mode < 4 then
     update zayavka
        set viza   = -1,
            idback = p_idback,
            reason_comm = p_comm
      where id = p_id and branch = l_branch;
  else
     -- Определяем, чья заявка: ЦА или РУ
     begin
        select id into l_reqid from zayavka where id = p_id and branch = l_branch;
        if p_mode = 4 then
           update zayavka
              set viza   = 1,
                  idback = p_idback,
                  reason_comm = p_comm
            where id = p_id and branch = l_branch;
        elsif p_mode = 5 then
           update zayavka
              set viza   = 2,
                  sos    = 0,
                  kurs_f = null,
                  vdate  = null,
                  datz   = null
            where id = p_id and branch = l_branch;
        end if;
     exception when no_data_found then
        if p_mode = 4 then
           update zayavka_ru
              set viza   = 1,
                  idback = p_idback,
                  reason_comm = p_comm
            where id = p_id and branch = l_branch;
           l_send_request_ru := true;
        elsif p_mode = 5 then
           update zayavka_ru
              set viza   = 2,
                  sos    = 0,
                  kurs_f = null,
                  vdate  = null,
                  datz   = null
            where id = p_id and branch = l_branch;
        end if;
     end;
  end if;

  -- отправить изменение запроса в РУ
  if gZAYMODE = 1 and p_mode = 4 and l_send_request_ru = true then

    select z.url, z.mfo
      into l_url, l_mfo
      from zay_recipients z
     where z.mfo = (select zr.mfo from zayavka_ru zr where zr.id = p_id and branch = l_branch);

    select req_id
      into l_reqid
      from zayavka_ru
     where id = p_id and branch = l_branch;

    l_request := soap_rpc.new_request(p_url         => l_url,
                                      p_namespace   => 'http://tempuri.org/',
                                      p_method      => 'ChangeSOS',
                                      p_wallet_dir  => gWallet_dir,
                                      p_wallet_pass => gWallet_pass);
    -- добавить параметры
    soap_rpc.add_parameter(l_request, 'req_id', to_char(l_reqid));
    soap_rpc.add_parameter(l_request, 'sos', to_char(0));
    soap_rpc.add_parameter(l_request,'viza', to_char(1));
    soap_rpc.add_parameter(l_request, 'id_back', to_char(p_idback));
    if p_comm is not null then
       soap_rpc.add_parameter(l_request, 'reason_comm', to_char(p_comm));
    end if;

    -- позвать метод веб-сервиса
    begin
      l_response := soap_rpc.invoke(l_request);

      --разбираем ответ
      l_clob   := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
      l_tmp    := xmltype(l_clob);
      l_clob   := l_response.doc.getClobVal();
      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob(l_parser, l_clob);
      l_doc     := dbms_xmlparser.getdocument(l_parser);
      l_reslist := dbms_xmldom.getelementsbytagname(l_doc, 'ChangeSOSResult');
      l_res     := dbms_xmldom.item(l_reslist, 0);
      dbms_xslprocessor.valueof(l_res, 'Status/text()', l_str);
      l_status := substr(l_str, 1, 200);

      if l_status = 'error' then
        dbms_xslprocessor.valueof(l_res, 'ErrorMessage/text()', l_str);
        p_data_transfer(p_req_id => p_id,
                        p_url    => l_url,
                        p_mfo    => l_mfo,
                        p_type   => 11,
                        p_date   => sysdate,
                        p_result => gTransfer_eroor,
                        p_comm   => 'error = ' || substr(l_str, 1, 1000));
      elsif l_status <> 'ok' then
        p_data_transfer(p_req_id => p_id,
                        p_url    => l_url,
                        p_mfo    => l_mfo,
                        p_type   => 11,
                        p_date   => sysdate,
                        p_result => gTransfer_eroor,
                        p_comm   => 'Необрабатываемое значение статуса - ' ||
                                  l_status);
      elsif l_status = 'ok' then
        p_data_transfer(p_req_id => p_id,
                        p_url    => l_url,
                        p_mfo    => l_mfo,
                        p_type   => 11,
                        p_date   => sysdate,
                        p_result => gTransfer_success,
                        p_comm   => 'До РУ (МФО ' || l_mfo ||
                                    ') успішно передано інформацію повернення заявки ділером ' || p_id);
      end if;
    dbms_xmlparser.freeparser(l_parser);
    DBMS_XMLDOM.freeDocument(l_doc);
    exception when others then
      dbms_xmlparser.freeparser(l_parser);
      DBMS_XMLDOM.freeDocument(l_doc);
      l_error := substr(sqlerrm, 1, 2000);
      bars_audit.error('set_request ERROR: ' || l_error);
      l_error := substr(sqlerrm, 1, 1000);
      p_data_transfer(p_req_id => p_id,
                      p_url    => l_url,
                      p_mfo    => l_mfo,
                      p_type   => 11,
                      p_date   => sysdate,
                      p_result => gTransfer_eroor,
                      p_comm   => 'exception - ' || l_error);
    end;
  end if;
end back_request;

-------------------------------------------------------------------------------
procedure set_diler_kurs (
  p_dat    in diler_kurs.dat%type,
  p_kv     in diler_kurs.kv%type,
  p_id     in diler_kurs.id%type,
  p_kurs_b in diler_kurs.kurs_b%type,
  p_kurs_s in diler_kurs.kurs_s%type,
  p_vip_b  in diler_kurs.vip_b%type,
  p_vip_s  in diler_kurs.vip_s%type,
  p_blk    in diler_kurs.blk%type )
is
begin
  insert into diler_kurs (dat, kv, id, kurs_b, kurs_s, vip_b, vip_s, blk, code)
  values (p_dat, p_kv, 1, p_kurs_b, p_kurs_s, p_vip_b, p_vip_s, p_blk, null);
exception when dup_val_on_index then
  update diler_kurs
     set id = 1,
         kurs_b = p_kurs_b,
         kurs_s = p_kurs_s,
         vip_b = p_vip_b,
         vip_s = p_vip_s,
         blk = p_blk
   where dat = p_dat
     and kv = p_kv;
end set_diler_kurs;

-------------------------------------------------------------------------------
procedure set_diler_kurs_conv (
  p_dat    in diler_kurs_conv.dat%type,
  p_kv1    in diler_kurs_conv.kv1%type,
  p_kv2    in diler_kurs_conv.kv2%type,
  p_kurs_i in diler_kurs_conv.kurs_i%type,
  p_kurs_f in diler_kurs_conv.kurs_f%type )
is
begin
  insert into diler_kurs_conv (dat, kv1, kv2, kurs_i, kurs_f)
  values (p_dat, p_kv1, p_kv2, p_kurs_i, p_kurs_f);
exception when dup_val_on_index then
  update diler_kurs_conv
     set kurs_i = p_kurs_i,
         kurs_f = p_kurs_f
   where dat = p_dat
     and kv1 = p_kv1
     and kv2 = p_kv2;
end set_diler_kurs_conv;

-------------------------------------------------------------------------------
procedure set_diler_kurs_fact (
  p_dat    in diler_kurs_fact.dat%type,
  p_kv     in diler_kurs_fact.kv%type,
  p_id     in diler_kurs_fact.id%type,
  p_kurs_b in diler_kurs_fact.kurs_b%type,
  p_kurs_s in diler_kurs_fact.kurs_s%type )
is
begin
  insert into diler_kurs_fact (dat, kv, id, kurs_b, kurs_s, code)
  values (p_dat, p_kv, 1, p_kurs_b, p_kurs_s, null);
exception when dup_val_on_index then
  update diler_kurs_fact
     set id = 1,
         kurs_b = p_kurs_b,
         kurs_s = p_kurs_s
   where dat = p_dat
     and kv = p_kv;
end set_diler_kurs_fact;

-------------------------------------------------------------------------------
--
-- Разбираем пришедшие xml из ЦА и устанавливаем курсы
--
procedure iparse_dilerkurs (p_kurs_clob clob,p_conv_clob clob,p_date varchar2)
is
  l_dilerkurs     diler_kurs%rowtype;
  l_dilerkursconv diler_kurs_conv%rowtype;
  l_parser        dbms_xmlparser.parser;
  l_doc           dbms_xmldom.domdocument;
  l_reslist       dbms_xmldom.DOMNodeList;
  l_res           dbms_xmldom.DOMNode;
  l_data          dbms_xmldom.DOMNodeList;
  l_kurs          dbms_xmldom.DOMNode;
  l_str           varchar2(2000);
  l_status        varchar2(100);
  l_error         varchar2(250);
  l_par           number;
  l_url           varchar2(256);
  l_mfo           varchar2(10);
  l_type          number;
  l_comm          varchar2(256);
  l_dat           date;
begin

  if gZAYMODE = 2 then
    --удаляем записи за дату p_date
    bars_audit.info('ZAY. Удаление курсов за дату =>' || p_date);
    l_dat := to_date(substr(p_date,1,10),'dd/mm/yyyy');
    delete from diler_kurs d where trunc(d.dat) =l_dat;
    delete from diler_kurs_conv dc where trunc(dc.dat)= l_dat;
    bars_audit.info('ZAY. Удаление курсов за дату завершино=>' || to_char(l_dat,'dd.mm.yyyy'));
     --разбираем хml с курсами валют
    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_kurs_clob);
    l_doc := dbms_xmlparser.getdocument(l_parser);

    l_data := dbms_xmldom.getelementsbytagname(l_doc, 'DealerCourse');

    for i in 0 .. dbms_xmldom.getlength(l_data) - 1 loop

      l_kurs := dbms_xmldom.item(l_data, i);

      dbms_xslprocessor.valueof(l_kurs, 'PAR/text()', l_str);
      l_par := to_number(l_str);
      dbms_xslprocessor.valueof(l_kurs, 'DAT/text()', l_str);
      l_dilerkurs.dat := to_date(replace(l_str,'T',' '), 'dd.mm.yyyy hh24:mi:ss');
      dbms_xslprocessor.valueof(l_kurs, 'KV/text()', l_str);
      l_dilerkurs.kv     := to_number(l_str);
      dbms_xslprocessor.valueof(l_kurs, 'KURSB/text()', l_str);
      l_dilerkurs.kurs_b := to_number(l_str);
      dbms_xslprocessor.valueof(l_kurs, 'KURSS/text()', l_str);
      l_dilerkurs.kurs_s := to_number(l_str);
      if l_par = 1 then
        dbms_xslprocessor.valueof(l_kurs, 'VIPB/text()', l_str);
        l_dilerkurs.vip_b  := to_number(l_str);
        dbms_xslprocessor.valueof(l_kurs, 'VIPS/text()', l_str);
        l_dilerkurs.vip_s  := to_number(l_str);
        dbms_xslprocessor.valueof(l_kurs, 'BLK/text()', l_str);
        l_dilerkurs.blk    := to_number(l_str);
      end if;

      l_dilerkurs.id   := 1;
      l_dilerkurs.code := null;
      if l_par = 1 then
      -- устанавливаем курсы валют
      set_diler_kurs(
        p_dat    => l_dilerkurs.dat,
        p_kv     => l_dilerkurs.kv,
        p_id     => l_dilerkurs.id,
        p_kurs_b => l_dilerkurs.kurs_b,
        p_kurs_s => l_dilerkurs.kurs_s,
        p_vip_b  => l_dilerkurs.vip_b,
        p_vip_s  => l_dilerkurs.vip_s,
        p_blk    => l_dilerkurs.blk
        );
      elsif l_par = 2 then
      -- устанавливаем фактические курсы валют
        set_diler_kurs_fact(
          p_dat    => l_dilerkurs.dat,
          p_kv     => l_dilerkurs.kv,
          p_id     => l_dilerkurs.id,
          p_kurs_b => l_dilerkurs.kurs_b,
          p_kurs_s => l_dilerkurs.kurs_s
        );

      end if;
    end loop;
    --free (не забыть делать очистку в случае ошибок)
    dbms_xmlparser.freeparser(l_parser);
    DBMS_XMLDOM.freeDocument(l_doc);
     --разбираем хml с курсами конверсии валют

    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_conv_clob);

    l_doc := dbms_xmlparser.getdocument(l_parser);

    l_data := dbms_xmldom.getelementsbytagname(l_doc, 'DealerCourseConv');

    for i in 0 .. dbms_xmldom.getlength(l_data) - 1 loop

        l_kurs := dbms_xmldom.item(l_data, i);
        dbms_xslprocessor.valueof(l_kurs, 'KV1/text()', l_str);
        l_dilerkursconv.kv1:= to_number(l_str);
        dbms_xslprocessor.valueof(l_kurs, 'KV2/text()', l_str);
        l_dilerkursconv.kv2   := to_number(l_str);
        dbms_xslprocessor.valueof(l_kurs, 'DAT/text()', l_str);
        l_dilerkursconv.dat    := to_date(replace(l_str,'T',' '), 'dd.mm.yyyy');
        dbms_xslprocessor.valueof(l_kurs, 'KURSI/text()', l_str);
        l_dilerkursconv.kurs_i := to_number(l_str);
        dbms_xslprocessor.valueof(l_kurs, 'KURSF/text()', l_str);
        l_dilerkursconv.kurs_f := to_number(l_str);
      -- устанавливаем курсы конверсии валют
    set_diler_kurs_conv(
      p_dat    => l_dilerkursconv.dat,
      p_kv1    => l_dilerkursconv.kv1,
      p_kv2    => l_dilerkursconv.kv2,
      p_kurs_i => l_dilerkursconv.kurs_i,
      p_kurs_f => l_dilerkursconv.kurs_f
    );
    -- bars_audit.info('ZAY. set_diler_kurs_conv=>' || l_dilerkursconv.dat);
    end loop;
    --free (не забыть делать очистку в случае ошибок)
    dbms_xmlparser.freeparser(l_parser);
    DBMS_XMLDOM.freeDocument(l_doc);
  select url,mfo into l_url,l_mfo from zay_recipients where kf = sys_context('bars_context','user_mfo');
  if l_par = 1 then
    l_type := 1;
    l_comm := 'Прийнято індикативні курси валют та курси конверсії';
  else
    l_type := 4;
    l_comm := 'Прийнято фактичні курси валют та курси конверсії';
  end if;

  p_data_transfer(p_req_id => null,
                  p_url    => l_url,
                  p_mfo    => l_mfo,
                  p_type   => 4,
                  p_date   => sysdate,
                  p_result => gTransfer_success,
                  p_comm   => l_comm
                  );
  end if;
exception when others then
  dbms_xmlparser.freeparser(l_parser);
  DBMS_XMLDOM.freeDocument(l_doc);
  bars_audit.info('ZAY error='||sqlerrm);
--  raise_application_error(-20001, substr(sqlerrm, 1, 256));
end iparse_dilerkurs;

-------------------------------------------------------------------------------
--
-- Передать курсы в конкретное РУ
--
procedure p_kurs_data_transfer (
  p_par number,
  p_url zay_recipients.url%type,
  p_dat date )
is
  l_request       soap_rpc.t_request;
  l_response      soap_rpc.t_response;
  l_clob          clob;
  l_error         varchar2(2000);
  l_kurs_xml_body clob;
  l_conv_xml_body clob;
  l_parser        dbms_xmlparser.parser;
  l_doc           dbms_xmldom.domdocument;
  l_reslist       dbms_xmldom.DOMNodeList;
  l_res           dbms_xmldom.DOMNode;
  l_str           varchar2(2000);
  l_status        varchar2(100);
  l_tmp           xmltype;
  ret_            varchar2(256);
  l_date          date;
  l_mfo           varchar2(10);
begin

if gZAYMODE = 1 then
  if p_dat is null then
     l_date := trunc(sysdate);
  else
     l_date := p_dat;
  end if;

  select r.mfo into l_mfo from zay_recipients r where r.url = p_url;

  if p_par = 1 then

    -- создаём xml с курсами валют
    select '<?xml version="1.0" encoding="windows-1251"?>' ||
            xmlelement("xmlDealerCourse",
              xmlagg(xmlelement("DealerCourse",
                xmlelement("PAR", to_char(p_par)),
                xmlelement("DAT", to_char(k.dat,'dd.mm.yyyy hh24:mi:ss')),
                xmlelement("KV",  to_char(k.kv)),
                xmlelement("ID",'1'),
                xmlelement("KURSB", to_char(k.kurs_b)),
                xmlelement("KURSS", to_char(k.kurs_s)),
                xmlelement("VIPB",  to_char(k.vip_b)),
                xmlelement("VIPS",  to_char(k.vip_s)),
                xmlelement("BLK",   to_char(k.blk)),
                xmlelement("CODE",  to_char(k.code))))).getclobval()
     into l_kurs_xml_body
     from diler_kurs k
     where trunc(k.dat) = l_date;

    -- создаём xml с курсами конвертации валют
    select '<?xml version="1.0" encoding="windows-1251"?>' ||
            xmlelement("xmlDealerCourseConv",
              xmlagg(xmlelement("DealerCourseConv",
              xmlelement("KV1", to_char(ck.kv1)),
              xmlelement("KV2", to_char(ck.kv2)),
              xmlelement("DAT", to_char(ck.dat,'dd.mm.yyyy')),
              xmlelement("KURSI", to_char(ck.kurs_i)),
              xmlelement("KURSF", to_char(ck.kurs_f)))))
           .getclobval()
     into l_conv_xml_body
     from diler_kurs_conv ck
     where trunc(ck.dat) = l_date;

    -- web-сервис
    l_request := soap_rpc.new_request(p_url       => p_url,
                                      p_namespace => 'http://tempuri.org/',
                                      p_method    => 'SetDealerCourse',
                                      p_wallet_dir =>  gWallet_dir,
                                      p_wallet_pass => gWallet_pass);
    -- добавидяэм параметры
    soap_rpc.add_parameter(l_request, 'xmlDealerCourse', l_kurs_xml_body);
    soap_rpc.add_parameter(l_request, 'xmlDealerCourseConv', l_conv_xml_body);
  soap_rpc.add_parameter(l_request, 'currentDate', to_char(l_date,'dd.mm.yyyy'));

    -- позвать метод веб-сервиса
    begin
      l_response := soap_rpc.invoke(l_request);

      --разбираем ответ
      l_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
      l_tmp  := xmltype(l_clob);

      ret_ := extract(l_tmp,
                      '/SetDealerCourseResponse/SetDealerCourseResult/text()',
                      null);

      l_clob := l_response.doc.getClobVal();
 l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob(l_parser, l_clob);
      l_doc := dbms_xmlparser.getdocument(l_parser);
      l_reslist := dbms_xmldom.getelementsbytagname(l_doc,
                                                    'SetDealerCourseResult');
      l_res     := dbms_xmldom.item(l_reslist, 0);
      dbms_xslprocessor.valueof(l_res, 'Status/text()', l_str);
      l_status := substr(l_str, 1, 150);

      if l_status = 'error' then
        dbms_xslprocessor.valueof(l_res, 'ErrorMessage/text()', l_str);
        p_data_transfer (p_req_id => null,
                         p_url    => p_url,
                         p_mfo    => l_mfo,
                         p_type   => 1,
                         p_date   => sysdate,
                         p_result => gTransfer_eroor,
                         p_comm   => 'error = ' || substr(l_str, 1, 900)
                         );
      elsif l_status <> 'ok' then
        p_data_transfer (p_req_id => null,
                         p_url    => p_url,
                         p_mfo    => l_mfo,
                         p_type   => 1,
                         p_date   => sysdate,
                         p_result => gTransfer_eroor,
                         p_comm   => 'Необрабатываемое значение статуса - ' || l_status
                         );
      elsif l_status = 'ok' then
        p_data_transfer (p_req_id => null,
                         p_url    => p_url,
                         p_mfo    => l_mfo,
                         p_type   => 1,
                         p_date   => sysdate,
                         p_result => gTransfer_success,
                         p_comm   => 'До РУ (МФО '||l_mfo||') передано індикативні курси валют та конверсії'
                         );
      end if;
      dbms_xmlparser.freeparser(l_parser);
      DBMS_XMLDOM.freeDocument(l_doc);
    exception when others then
  dbms_xmlparser.freeparser(l_parser);
      DBMS_XMLDOM.freeDocument(l_doc);
      l_error := substr(sqlerrm, 1, 2000);
      bars_audit.error('set_diler_kurs ERROR: ' || l_error);
      l_error := substr(sqlerrm, 1, 900);

      p_data_transfer (p_req_id => null,
                       p_url    => p_url,
                       p_mfo    => l_mfo,
                       p_type   => 1,
                       p_date   => sysdate,
                       p_result => gTransfer_eroor,
                       p_comm   => 'exception - ' || l_error
                       );
    end;

    elsif p_par = 2 then
      -- создаём xml с курсами валют
       select '<?xml version="1.0" encoding="windows-1251" ?>' ||
              xmlelement("xmlDealerCourseFact",
                xmlagg(xmlelement("DealerCourse",
                  xmlelement("PAR", to_char(p_par)),
                  xmlelement("DAT", to_char(k.dat,'dd.mm.yyyy hh24:mi:ss')),
                  xmlelement("KV", to_char(k.kv)),
                  xmlelement("ID",'1'),
                  xmlelement("KURSB", to_char(k.kurs_b)),
                  xmlelement("KURSS", to_char(k.kurs_s))))).getclobval()
       into l_kurs_xml_body
       from diler_kurs_fact k
       where trunc(k.dat) = l_date;

       select '<?xml version="1.0" encoding="windows-1251"?>' ||
            xmlelement("xmlDealerCourseConv",
              xmlagg(xmlelement("DealerCourseConv",
              xmlelement("KV1", to_char(ck.kv1)),
              xmlelement("KV2", to_char(ck.kv2)),
              xmlelement("DAT", to_char(ck.dat,'dd.mm.yyyy')),
              xmlelement("KURSI", to_char(ck.kurs_i)),
              xmlelement("KURSF", to_char(ck.kurs_f)))))
           .getclobval()
       into l_conv_xml_body
       from diler_kurs_conv ck
       where trunc(ck.dat) = l_date;

    -- web-сервис
    l_request := soap_rpc.new_request(p_url       => p_url,
                                      p_namespace => 'http://tempuri.org/',
                                      p_method    => 'SetDealerCourse',
                                      p_wallet_dir =>  gWallet_dir,
                                      p_wallet_pass => gWallet_pass);
    -- добавяем параметры
    soap_rpc.add_parameter(l_request, 'xmlDealerCourse', l_kurs_xml_body);
    soap_rpc.add_parameter(l_request, 'xmlDealerCourseConv', l_conv_xml_body);
    soap_rpc.add_parameter(l_request, 'currentDate', to_char(l_date,'dd.mm.yyyy'));

    -- позвать метод веб-сервиса
    begin
      l_response := soap_rpc.invoke(l_request);

      --разбираем ответ
      l_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
      l_tmp  := xmltype(l_clob);

      ret_ := extract(l_tmp,
                      '/SetDealerCourseResponse/SetDealerCourseResult/text()',
                      null);

      l_clob := l_response.doc.getClobVal();
      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob(l_parser, l_clob);
      l_doc := dbms_xmlparser.getdocument(l_parser);
      l_reslist := dbms_xmldom.getelementsbytagname(l_doc,
                                                    'SetDealerCourseResult');
      l_res     := dbms_xmldom.item(l_reslist, 0);
      dbms_xslprocessor.valueof(l_res, 'Status/text()', l_str);
      l_status := substr(l_str, 1, 200);

      if l_status = 'error' then
        dbms_xslprocessor.valueof(l_res, 'ErrorMessage/text()', l_str);
        p_data_transfer(p_req_id => null,
                        p_url    => p_url,
                        p_mfo    => l_mfo,
                        p_type   => 4,
                        p_date   => sysdate,
                        p_result => gTransfer_eroor,
                        p_comm   => 'error = ' || l_status || substr(l_str,1,1000)
                        );
      elsif l_status <> 'ok' then
        p_data_transfer(p_req_id => null,
                        p_url    => p_url,
                        p_mfo    => l_mfo,
                        p_type   => 4,
                        p_date   => sysdate,
                        p_result => gTransfer_eroor,
                        p_comm   => 'Необрабатываемое значение статуса - ' || l_status
                        );
      elsif l_status = 'ok' then
        p_data_transfer(p_req_id => null,
                        p_url    => p_url,
                        p_mfo    => l_mfo,
                        p_type   => 4,
                        p_date   => sysdate,
                        p_result => gTransfer_success,
                        p_comm   => 'До РУ (МФО '||l_mfo||') передано фактичні курси валют та конверсии'
                        );
      end if;

    dbms_xmlparser.freeparser(l_parser);
    DBMS_XMLDOM.freeDocument(l_doc);
    exception
      when others then
        dbms_xmlparser.freeparser(l_parser);
        DBMS_XMLDOM.freeDocument(l_doc);
        l_error := substr(sqlerrm, 1, 2000);
        bars_audit.error('set_diler_kurs_fact ERROR: ' || l_error);
        l_error := substr(sqlerrm, 1, 1000);
        p_data_transfer(p_req_id => null,
                        p_url    => p_url,
                        p_mfo    => l_mfo,
                        p_type   => 4,
                        p_date   => sysdate,
                        p_result => gTransfer_eroor,
                        p_comm   => 'exception - ' || l_error
                        );
    end;
  end if;
end if;
end p_kurs_data_transfer;

-------------------------------------------------------------------------------
--
-- Передать курсы в все РУ
--
procedure p_kurs_transfer(
  p_par number, -- p_par: =1-индикативные курсы, =2-фактические курсы
  p_dat date)
is
begin
  for c in (select url from zay_recipients  where mfo not in
            (select kf from bars.params$base where par = 'IS_MMFO') and mfo<>'300465') loop
      p_kurs_data_transfer(p_par, c.url, p_dat);
  end loop;
end p_kurs_transfer;

-------------------------------------------------------------------------------
--
-- Проверка: поиск заявки для создания/обновления
--
procedure search_request (
  p_flag   in number,
  p_reqid  in number,
  p_mfo    in varchar2,
  p_id    out number )
is
begin

  begin
     select id into p_id from zayavka_ru where req_id = p_reqid and mfo = p_mfo;
  exception when no_data_found then
     p_id := null;
  end;

  -- создание заявки
  if p_flag = 1 then
     if p_id is not null then
        p_id := null;
        raise_application_error(-20000, 'Заявка ид.=' || p_reqid || ' МФО ' || p_mfo || ' уже введена.');
     end if;
     -- идентификатор заявки
     p_id := bars_sqnc.get_nextval('s_zayavka');
  -- обновление заявки
  elsif p_flag = 2 then
     if p_id is null then
        raise_application_error(-20000, 'Заявка ид.=' || p_reqid || ' МФО ' || p_mfo || ' не найдена.');
     end if;
  end if;

end search_request;

-------------------------------------------------------------------------------
--
-- процедура создания/обновления заявки, введенной в РУ, в БД ЦА
--
procedure set_request_in_ca (
  -- p_flag - 1-ins, 2-upd
  p_flag                 number,
  p_mfo                  zayavka_ru.mfo%type,
  p_id                   zayavka_ru.req_id%type,
  p_dk                   zayavka_ru.dk%type,
  p_obz                  zayavka_ru.obz%type,
  p_nd                   zayavka_ru.nd%type,
  p_fdat                 zayavka_ru.fdat%type,
  p_datt                 zayavka_ru.datt%type,
  p_rnk                  zayavka_ru.rnk%type,
  p_nmk                  zayavka_ru.nmk%type,
  p_nd_rnk               zayavka_ru.nd_rnk%type,
  p_kv_conv              zayavka_ru.kv_conv%type,
  p_lcv_conv             zayavka_ru.lcv_conv%type,
  p_kv2                  zayavka_ru.kv2%type,
  p_lcv                  zayavka_ru.lcv%type,
  p_dig                  zayavka_ru.dig%type,
  p_s2                   zayavka_ru.s2%type,
  p_s2s                  zayavka_ru.s2s%type,
  p_s3                   zayavka_ru.s3%type,
  p_kom                  zayavka_ru.kom%type,
  p_skom                 zayavka_ru.skom%type,
  p_kurs_z               zayavka_ru.kurs_z%type,
  p_kurs_f               zayavka_ru.kurs_f%type,
  p_vdate                zayavka_ru.vdate%type,
  p_datz                 zayavka_ru.datz%type,
  p_acc0                 zayavka_ru.acc0%type,
  p_nls_acc0             zayavka_ru.nls_acc0%type,
  p_mfo0                 zayavka_ru.mfo0%type,
  p_nls0                 zayavka_ru.nls0%type,
  p_okpo0                zayavka_ru.okpo0%type,
  p_ostc0                zayavka_ru.ostc0%type,
  p_acc1                 zayavka_ru.acc1%type,
  p_ostc                 zayavka_ru.ostc%type,
  p_nls                  zayavka_ru.nls%type,
  p_sos                  zayavka_ru.sos%type,
  p_ref                  zayavka_ru.ref%type,
  p_viza                 zayavka_ru.viza%type,
  p_priority             zayavka_ru.priority%type,
  p_priorname            zayavka_ru.priorname%type,
  p_priorverify          zayavka_ru.priorverify%type,
  p_idback               zayavka_ru.idback%type,
  p_fl_pf                zayavka_ru.fl_pf%type,
  p_mfop                 zayavka_ru.mfop%type,
  p_nlsp                 zayavka_ru.nlsp%type,
  p_okpop                zayavka_ru.okpop%type,
  p_rnk_pf               zayavka_ru.rnk_pf%type,
  p_pid                  zayavka_ru.pid%type,
  p_contract             zayavka_ru.contract%type,
  p_dat2_vmd             zayavka_ru.dat2_vmd%type,
  p_meta                 zayavka_ru.meta%type,
  p_aim_name             zayavka_ru.aim_name%type,
  p_basis                zayavka_ru.basis%type,
  p_product_group        zayavka_ru.product_group%type,
  p_product_group_name   zayavka_ru.product_group_name%type,
  p_num_vmd              zayavka_ru.num_vmd%type,
  p_dat_vmd              zayavka_ru.dat_vmd%type,
  p_dat5_vmd             zayavka_ru.dat5_vmd%type,
  p_country              zayavka_ru.country%type,
  p_benefcountry         zayavka_ru.benefcountry%type,
  p_bank_code            zayavka_ru.bank_code%type,
  p_bank_name            zayavka_ru.bank_name%type,
  p_userid               zayavka_ru.userid%type,
  p_branch               zayavka_ru.branch%type,
  p_fl_kursz             zayavka_ru.fl_kursz%type,
  p_identkb              zayavka_ru.identkb%type,
  p_comm                 zayavka_ru.comm%type,
  p_cust_branch          zayavka_ru.cust_branch%type,
  p_kurs_kl              zayavka_ru.kurs_kl%type,
  p_contact_fio          zayavka_ru.contact_fio%type,
  p_contact_tel          zayavka_ru.contact_tel%type,
  p_verify_opt           zayavka_ru.verify_opt%type,
  p_close_type           zayavka_ru.close_type%type,
  p_close_type_name      zayavka_ru.close_type_name%type,
  p_aims_code            zayavka_ru.aims_code%type,
  p_s_pf                 zayavka_ru.s_pf%type,
  p_ref_pf               zayavka_ru.ref_pf%type,
  p_ref_sps              zayavka_ru.ref_sps%type,
  p_start_time           zayavka_ru.start_time%type,
  p_state                zayavka_ru.state%type,
  p_operid_nokk          zayavka_ru.operid_nokk%type,
  p_req_type             zayavka_ru.req_type%type,
  p_vdateplan            zayavka_ru.vdate_plan%type,
  p_custtype             zayavka_ru.custtype%type )
is
  l_id                 number;
  l_aim_name           zayavka_ru.aim_name%type;-- := substr(p_aim_name, 1, 2);
  l_bank_code          zayavka_ru.bank_code%type;-- :=substr(p_bank_code,1,2);
  l_bank_name          zayavka_ru.bank_name%type;-- := sybstr(p_bank_name,1,2);
  l_basis              zayavka_ru.basis%type;--     := substr(p_basis,1,2);
  l_branch             zayavka_ru.branch%type;
  l_close_type_name    zayavka_ru.close_type_name%type;
  l_comm               zayavka_ru.comm%type;
  l_contact_fio        zayavka_ru.contact_fio%type;
  l_contact_tel        zayavka_ru.contact_tel%type;
  l_contract           zayavka_ru.contract%type;
  l_cust_branch        zayavka_ru.cust_branch%type;
  l_dat5_vmd           zayavka_ru.dat5_vmd%type;
  l_identkb            zayavka_ru.identkb%type;
  l_kurs_kl            zayavka_ru.kurs_kl%type;-- := substr(p_kurs_kl, 1, 2);
  l_lcv                zayavka_ru.lcv%type;
  l_lcv_conv           zayavka_ru.lcv_conv%type;
  l_mfo                zayavka_ru.mfo%type;
  l_mfo0               zayavka_ru.mfo0%type;
  l_mfop               zayavka_ru.mfop%type;
  l_nd                 zayavka_ru.nd%type;
  l_nd_rnk             zayavka_ru.nd_rnk%type;-- := substr(p_nd_rnk, 1, 2);
  l_nls                zayavka_ru.nls%type;
  l_nls_acc0           zayavka_ru.nls_acc0%type;
  l_nls0               zayavka_ru.nls0%type;
  l_nlsp               zayavka_ru.nlsp%type;
  l_nmk                zayavka_ru.nmk%type;-- := substr(p_nmk, 1, 2);
  l_num_vmd            zayavka_ru.num_vmd%type;
  l_okpo0              zayavka_ru.okpo0%type;
  l_okpop              zayavka_ru.okpop%type;
  l_operid_nokk        zayavka_ru.operid_nokk%type;
  l_priorname          zayavka_ru.priorname%type;-- := substr(p_priorname, 1, 2);
  l_product_group      zayavka_ru.product_group%type;
  l_product_group_name zayavka_ru.product_group_name%type;-- := substr(p_product_group_name, 1, 2);
  l_rnk_pf             zayavka_ru.rnk_pf%type;
  l_state              zayavka_ru.state%type;-- := substr(p_state, 1, 2);
  l_url                varchar2(256);
  l_comment               varchar2(256);
  begin


  if p_aim_name is not null then
    l_aim_name  := decode_base_to_row(p_aim_name);
  end if;
  if p_bank_code is not null then
    l_bank_code := decode_base_to_row(p_bank_code);
  end if;
  if p_bank_name is not null then
    l_bank_name := decode_base_to_row(p_bank_name);
  end if;
  if p_basis is not null then
    l_basis := decode_base_to_row(p_basis);
  end if;
  if p_branch is not null then
    l_branch := decode_base_to_row(p_branch);
  end if;
  if p_close_type_name is not null then
    l_close_type_name := decode_base_to_row(p_close_type_name);
  end if;
  if p_comm is not null then
    l_comm := decode_base_to_row(p_comm);
  end if;
  if p_contact_fio is not null then
    l_contact_fio := decode_base_to_row(p_contact_fio);
  end if;
  if p_contact_tel is not null then
    l_contact_tel := decode_base_to_row(p_contact_tel);
  end if;
  if p_contract is not null then
    l_contract := decode_base_to_row(p_contract);
  end if;
  if p_cust_branch is not null then
    l_cust_branch := decode_base_to_row(p_cust_branch);
  end if;
  if p_dat5_vmd is not null then
    l_dat5_vmd := decode_base_to_row(p_dat5_vmd);
  end if;
  if p_identkb is not null then
    l_identkb := decode_base_to_row(p_identkb);
  end if;
  if p_kurs_kl is not null then
    l_kurs_kl   := decode_base_to_row(p_kurs_kl);
  end if;
  if p_lcv is not null then
    l_lcv := decode_base_to_row(p_lcv);
  end if;
  if p_lcv_conv is not null then
    l_lcv_conv := decode_base_to_row(p_lcv_conv);
  end if;
  if p_mfo is not null then
    l_mfo := decode_base_to_row(p_mfo);
  end if;
  if p_mfo0 is not null then
    l_mfo0 := decode_base_to_row(p_mfo0);
  end if;
  if p_mfop is not null then
    l_mfop := decode_base_to_row(p_mfop);
  end if;
  if p_nd is not null then
    l_nd := decode_base_to_row(p_nd);
  end if;
  if p_nd_rnk is not null then
    l_nd_rnk := decode_base_to_row(p_nd_rnk);
  end if;
  if p_nls is not null then
    l_nls := decode_base_to_row(p_nls);
  end if;
  if p_nls_acc0 is not null then
    l_nls_acc0 := decode_base_to_row(p_nls_acc0);
  end if;
  if p_nls0 is not null then
    l_nls0 := decode_base_to_row(p_nls0);
  end if;
  if p_nlsp is not null then
    l_nlsp := decode_base_to_row(p_nlsp);
  end if;
  if p_nmk is not null then
    l_nmk := decode_base_to_row(p_nmk);
  end if;
  if p_num_vmd is not null then
    l_num_vmd:= decode_base_to_row(p_num_vmd);
  end if;
  if p_okpo0 is not null then
    l_okpo0 := decode_base_to_row(p_okpo0);
  end if;
  if p_okpop is not null then
    l_okpop := decode_base_to_row(p_okpop);
  end if;
  if p_operid_nokk is not null then
    l_operid_nokk := decode_base_to_row(p_operid_nokk);
  end if;
  if p_priorname is not null then
    l_priorname := decode_base_to_row(p_priorname);
  end if;
  if p_product_group is not null then
    l_product_group := decode_base_to_row(p_product_group);
  end if;
  if p_product_group_name is not null then
    l_product_group_name := decode_base_to_row(p_product_group_name);
  end if;
  if p_rnk_pf is not null then
    l_rnk_pf := decode_base_to_row(p_rnk_pf);
  end if;
  if p_state is not null then
    l_state := decode_base_to_row(substr(p_state, 1, 36));
  end if;

  -- поиск заявки
  search_request(p_flag  => p_flag,
                 p_reqid => p_id,
                 p_mfo   => l_mfo,
                 p_id    => l_id);

  select url into l_url from zay_recipients where to_char(mfo) = l_mfo;

  -- создание заявки
  if p_flag = 1 then

     insert into zayavka_ru
       (id, mfo, req_id, dk, obz, nd, fdat, datt, rnk, nmk, nd_rnk, kv_conv, lcv_conv, kv2, lcv, dig, s2, s2s, s3, kom, skom, kurs_z, kurs_f,
        vdate, datz, acc0, nls_acc0, mfo0, nls0, okpo0, ostc0, acc1, ostc, nls, sos, ref, viza, priority, priorname, priorverify, idback,
        fl_pf, mfop, nlsp, okpop, rnk_pf, pid, contract, dat2_vmd, meta, aim_name, basis, product_group, product_group_name, num_vmd, dat_vmd,
        dat5_vmd, country, benefcountry, bank_code, bank_name, userid, branch, fl_kursz, identkb, comm, cust_branch, kurs_kl, contact_fio, contact_tel,
        verify_opt, close_type, close_type_name, aims_code, s_pf, ref_pf, ref_sps, start_time, state, operid_nokk, req_type, vdate_plan,custtype)
     values
       (l_id, l_mfo, p_id, p_dk, p_obz, l_nd, p_fdat, p_datt, p_rnk, l_nmk, l_nd_rnk, p_kv_conv, l_lcv_conv, p_kv2, l_lcv, p_dig, p_s2, p_s2s, p_s3, p_kom, p_skom, p_kurs_z, p_kurs_f,
        p_vdate, p_datz, p_acc0, l_nls_acc0, l_mfo0, l_nls0, l_okpo0, p_ostc0, p_acc1, p_ostc, l_nls, p_sos, p_ref, p_viza, p_priority, l_priorname, p_priorverify, p_idback,
        p_fl_pf, l_mfop, l_nlsp, l_okpop, l_rnk_pf, p_pid, l_contract, p_dat2_vmd, p_meta, l_aim_name, l_basis, l_product_group, l_product_group_name, l_num_vmd, p_dat_vmd,
        l_dat5_vmd, p_country, p_benefcountry, l_bank_code, l_bank_name, p_userid, l_branch, p_fl_kursz, l_identkb, l_comm, l_cust_branch, l_kurs_kl, l_contact_fio, l_contact_tel,
        p_verify_opt, p_close_type, l_close_type_name, p_aims_code, p_s_pf, p_ref_pf, p_ref_sps, p_start_time, l_state, l_operid_nokk, p_req_type, p_vdateplan, p_custtype);

     p_data_transfer(p_req_id => p_id,
                     p_url    => l_url,
                     p_mfo    => l_mfo,
                     p_type   => 2,
                     p_date   => sysdate,
                     p_result => gTransfer_success,
                     p_comm   => 'Прийнято інформацію про створення заявки № '||p_id|| ' від РУ МФО '||p_mfo
                    );
   -- обновление заявки
  elsif p_flag > 1 then

     if p_flag = 2 then
        l_comment := 'Прийнято інформацію про внесення змін до заявки № ' || p_id || ' від РУ МФО ' || l_mfo;
     else
        l_comment := 'Прийнято інформацію про візування заявки № ' || p_id || ' від РУ МФО ' || l_mfo;
     end if;

     update zayavka_ru
        set dk                 = p_dk,
            obz                = p_obz,
            nd                 = l_nd,
            fdat               = p_fdat,
            datt               = p_datt,
            rnk                = p_rnk,
            nmk                   = l_nmk,
            nd_rnk             = l_nd_rnk,
            kv_conv            = p_kv_conv,
            lcv_conv           = l_lcv_conv,
            kv2                   = p_kv2,
            lcv                = l_lcv,
            dig                   = p_dig,
            s2                   = p_s2,
            s2s                   = p_s2s,
            s3                   = p_s3,
            kom                   = p_kom,
            skom               = p_skom,
            kurs_z             = p_kurs_z,
            kurs_f             = p_kurs_f,
            vdate              = p_vdate,
            datz               = p_datz,
            acc0               = p_acc0,
            nls_acc0           = l_nls_acc0,
            mfo0               = l_mfo0,
            nls0               = l_nls0,
            okpo0              = l_okpo0,
            ostc0              = p_ostc0,
            acc1               = p_acc1,
            ostc               = p_ostc,
            nls                = l_nls,
            sos                   = p_sos,
            ref                = p_ref,
            viza               = p_viza,
            priority           = p_priority,
            priorname          = l_priorname,
            priorverify        = p_priorverify,
            idback             = p_idback,
            fl_pf              = p_fl_pf,
            mfop               = l_mfop,
            nlsp               = l_nlsp,
            okpop              = l_okpop,
            rnk_pf             = l_rnk_pf,
            pid                = p_pid,
            contract           = l_contract,
            dat2_vmd           = p_dat2_vmd,
            meta               = p_meta,
            aim_name           = l_aim_name,
            basis              = l_basis,
            product_group      = l_product_group,
            product_group_name = l_product_group_name,
            num_vmd            = l_num_vmd,
            dat_vmd            = p_dat_vmd,
            dat5_vmd           = l_dat5_vmd,
            country            = p_country,
            benefcountry       = p_benefcountry,
            bank_code          = l_bank_code,
            bank_name          = l_bank_name,
            userid             = p_userid,
            branch             = l_branch,
            fl_kursz           = p_fl_kursz,
            identkb            = l_identkb,
            comm               = l_comm,
            cust_branch        = l_cust_branch,
            kurs_kl            = l_kurs_kl,
            contact_fio        = l_contact_fio,
            contact_tel        = l_contact_tel,
            verify_opt            = p_verify_opt,
            close_type            = p_close_type,
            close_type_name    = l_close_type_name,
            aims_code            = p_aims_code,
            s_pf               = p_s_pf,
            ref_pf             = p_ref_pf,
            ref_sps            = p_ref_sps,
            start_time         = p_start_time,
            state              = l_state,
            operid_nokk        = l_operid_nokk,
            req_type           = p_req_type,
            vdate_plan         = p_vdateplan,
            custtype           = p_custtype
      where id = l_id;

     p_data_transfer(p_req_id => p_id,
                     p_url    => l_url,
                     p_mfo    => l_mfo,
                     p_type   => 2,
                     p_date   => sysdate,
                     p_result => gTransfer_success,
                     p_comm   => l_comment);
  end if;
end set_request_in_ca;

-------------------------------------------------------------------------------
procedure set_zaytrack_in_ca (
  p_mfo         zay_track_ru.mfo%type,
  p_track_id    zay_track_ru.track_id%type,
  p_req_id      zay_track_ru.req_id%type,
  p_change_time zay_track_ru.change_time%type,
  p_fio         zay_track_ru.fio%type,
  p_sos         zay_track_ru.sos%type,
  p_viza        zay_track_ru.viza%type,
  p_viza_name   zay_track_ru.viza_name%type
  )
is
  l_id number;
  l_fio varchar2(256);
  l_viza_name varchar2(256);
begin
  -- поиск заявки
  search_request(2, p_req_id, p_mfo, l_id);
  if l_id is not null then
    l_fio := decode_base_to_row(p_fio);
    l_viza_name := decode_base_to_row(p_viza_name);
    update  zay_track_ru set
      req_id      = p_req_id,
      change_time = p_change_time,
      fio         = l_fio,
      sos         = p_sos,
      viza        = p_viza,
      viza_name   = l_viza_name
    where mfo = p_mfo
      and track_id = p_track_id;
      if sql%rowcount = 0 then
     insert into zay_track_ru (mfo, track_id, req_id, change_time, fio, sos, viza,viza_name)
     values (p_mfo, p_track_id, p_req_id, p_change_time, l_fio, p_sos, p_viza, l_viza_name);
     end if;
  end if;
end set_zaytrack_in_ca;

-------------------------------------------------------------------------------
procedure set_visa_in_ca (
  p_mfo  zayavka_ru.mfo%type,
  p_id   zayavka_ru.req_id%type,
  p_viza zayavka_ru.viza%type )
is
  l_id number;
begin
  -- поиск заявки
  search_request(2, p_id, p_mfo, l_id);
  if l_id is not null then
      update zayavka_ru
         set viza = p_viza
       where id = l_id;
  end if;
end set_visa_in_ca;

-------------------------------------------------------------------------------
procedure set_refsps_in_ca (
  p_mfo       zayavka_ru.mfo%type,
  p_id        zayavka_ru.req_id%type,
  p_ref_sps   zayavka_ru.ref_sps%type )
is
  l_id number;
 l_url  varchar2(256);
  l_comm varchar2(256);
begin
  bars_audit.info('set_refsps_in_ca p_id='||p_id);
    -- поиск заявки

  if gZAYMODE = 1 then
  search_request(2, p_id, p_mfo, l_id);
  if l_id is not null then
     update zayavka_ru
        set ref_sps = p_ref_sps
      where id = l_id;

      select url into l_url from zay_recipients where mfo = p_mfo;
      l_comm := 'Прийнято інформацію щодо передачи коштів по заявці №'||p_id||' ( МФО '||p_mfo||' РЕФ '||p_ref_sps||')';

    end if;
  elsif gZAYMODE =2 then
    l_id := p_id;
    select url into l_url from zay_recipients where kf = sys_context('bars_context','user_mfo');
    l_comm := 'Прийнято інформацію щодо передачи коштів по заявці №'||p_id;
  end if;
    if l_id is not null then
      p_data_transfer(p_req_id => p_id,
                      p_url    => l_url,
                      p_mfo    => p_mfo,
                      p_type   => 6,
                      p_date   => sysdate,
                      p_result => gTransfer_success,
                      p_comm   => l_comm
                      );
  end if;
end set_refsps_in_ca;

-------------------------------------------------------------------------------
--Запис стану заявки в РУ
--
procedure set_visa_in_ru(p_id          zayavka.id%type,
                         p_kurs_f      zayavka.kurs_f%type,
                         p_sos         zayavka.sos%type,
                         p_vdate       zayavka.vdate%type,
                         p_close_type  zayavka.close_type%type,
                         p_datz        zayavka.datz%type,
                         p_viza        zayavka.viza%type,
                         p_id_back     zayavka.idback%type,
                         p_reason_comm zayavka.reason_comm%type
                         ) is
l_url varchar2(256);
l_mfo varchar2(10);
begin
  if p_sos = 0 and p_viza = 1 then
    update zayavka set
      sos         = p_sos,
      viza        = p_viza,
      idback      = p_id_back,
      reason_comm = p_reason_comm
    where id = p_id;

    select url, mfo into l_url, l_mfo from zay_recipients where kf = sys_context('bars_context','user_mfo');

    p_data_transfer(p_req_id => p_id,
                    p_url    => l_url,
                    p_mfo    => l_mfo,
                    p_type   => 11,
                    p_date   => sysdate,
                    p_result => gTransfer_success,
                    p_comm   => 'Від ЦА успішно прийнято інформацію о поверненні заявки з обробки ділером' || p_id);
  else
    update zayavka
      set kurs_f     = p_kurs_f,
          sos        = p_sos,
          vdate      = p_vdate,
          close_type = p_close_type,
          datz       = p_datz
    where id = p_id;

    select url, mfo into l_url, l_mfo from zay_recipients where kf = sys_context('bars_context','user_mfo');
    p_data_transfer(p_req_id => p_id,
                    p_url    => l_url,
                    p_mfo    => l_mfo,
                    p_type   => 5,
                    p_date   => sysdate,
                    p_result => gTransfer_success,
                    p_comm   => 'Від ЦА успішно прийнято інформацію про задоволення заявки ' || p_id);
  end if;
end set_visa_in_ru;

-------------------------------------------------------------------------------
--
-- Передать реф документа списания средств в ЦА
--
procedure p_reqest_set_refsps(
  p_id        number,
  p_ref_sps   number)
is
  l_request       soap_rpc.t_request;
  l_response      soap_rpc.t_response;
  l_clob          clob;
  l_error         varchar2(2000);
  l_parser        dbms_xmlparser.parser;
  l_doc           dbms_xmldom.domdocument;
  l_reslist       dbms_xmldom.DOMNodeList;
  l_res           dbms_xmldom.DOMNode;
  l_str           varchar2(2000);
  l_status        varchar2(100);
  l_tmp           xmltype;
  ret_            varchar2(256);
  l_url           varchar2(256);
  l_mfo           varchar2(10);
 l_id            number;
  l_comm          varchar2(120);
begin
  if gZAYMODE = 1 then
    select z.url, z.mfo
    into   l_url, l_mfo
    from zay_recipients z
    where mfo = (select mfo from zayavka_ru where id = p_id);
    l_comm := 'В РУ ( МФО '||l_mfo||') передано інформацію щодо передачи коштів по заявці №'||p_id||' ( РЕФ  '||p_ref_sps||')';

    select req_id into l_id from zayavka_ru where id = p_id;
  elsif gZAYMODE = 2 then
  select z.url into l_url from zay_recipients z where z.kf = sys_context('bars_context','user_mfo');
  select VAL into l_mfo from params where par = 'MFO';
   l_id := p_id;
    l_comm := 'В ЦА передано інформацію щодо передачи коштів по заявці №'||p_id||' ( РЕФ  '||p_ref_sps||')';
  end if;

  l_request := soap_rpc.new_request(p_url       => l_url,
                                    p_namespace => 'http://tempuri.org/',
                                    p_method    => 'SetRefSps',
                                    p_wallet_dir =>  gWallet_dir,
                                    p_wallet_pass => gWallet_pass);
  -- добавить параметры
  soap_rpc.add_parameter(l_request, 'req_id', to_char(l_id));
  soap_rpc.add_parameter(l_request, 'mfo', l_mfo);
  soap_rpc.add_parameter(l_request, 'ref_sps', to_char(p_ref_sps));

  -- позвать метод веб-сервиса
  begin
    l_response := soap_rpc.invoke(l_request);

    --разбираем ответ
    l_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
    l_tmp  := xmltype(l_clob);
    l_clob := l_response.doc.getClobVal();
    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, l_clob);
    l_doc := dbms_xmlparser.getdocument(l_parser);
    l_reslist := dbms_xmldom.getelementsbytagname(l_doc,
                                                  'SetRefSpsResult');
    l_res     := dbms_xmldom.item(l_reslist, 0);
    dbms_xslprocessor.valueof(l_res, 'Status/text()', l_str);
    l_status := substr(l_str, 1, 200);

    if l_status = 'error' then
      dbms_xslprocessor.valueof(l_res, 'ErrorMessage/text()', l_str);
       p_data_transfer(p_req_id => p_id,
                   p_url    => l_url,
                   p_mfo    => l_mfo,
                   p_type   => 6,
                   p_date   => sysdate,
                   p_result => gTransfer_eroor,
                   p_comm   => 'error = ' || substr(l_str, 1, 1000)
                   );
    elsif l_status <> 'ok' then
      p_data_transfer(p_req_id => p_id,
                      p_url    => l_url,
                      p_mfo    => l_mfo,
                      p_type   => 6,
                      p_date   => sysdate,
                      p_result => gTransfer_eroor,
                      p_comm   => 'Необрабатываемое значение статуса - ' || l_status
                      );
    elsif l_status = 'ok' then
      p_data_transfer(p_req_id => p_id,
                      p_url    => l_url,
                      p_mfo    => l_mfo,
                      p_type   => 6,
                      p_date   => sysdate,
                      p_result => gTransfer_success,
                      p_comm   => l_comm
                      );
    end if;
    dbms_xmlparser.freeparser(l_parser);
    DBMS_XMLDOM.freeDocument(l_doc);
    exception
      when others then
            dbms_xmlparser.freeparser(l_parser);
            DBMS_XMLDOM.freeDocument(l_doc);
            l_error := substr(sqlerrm, 1, 2000);
            bars_audit.error('set_ref_sps ERROR: ' || l_error);
        l_error := substr(sqlerrm, 1, 1000);
        p_data_transfer(p_req_id => p_id,
                        p_url    => l_url,
                        p_mfo    => l_mfo,
                        p_type   => 6,
                        p_date   => sysdate,
                        p_result => gTransfer_eroor,
                        p_comm   => 'exception - ' || l_error
                        );

        end;
end p_reqest_set_refsps;
  -------------------------------------------------------------------------------
  --
  -- Разбираем пришедшие xml из РУ и записываем в таблицу zay_currency_income_ru
  --
  procedure iparse_currency_income(p_mfo varchar2,
                                   p_date varchar2,
                                   p_currency_clob clob
                                   ) is
    l_curr_ru       zay_currency_income_ru%rowtype;
    l_parser        dbms_xmlparser.parser;
    l_doc           dbms_xmldom.domdocument;
    l_reslist       dbms_xmldom.DOMNodeList;
    l_res           dbms_xmldom.DOMNode;
    l_data          dbms_xmldom.DOMNodeList;
    l_curr          dbms_xmldom.DOMNode;
    l_str           varchar2(2000);
    l_status        varchar2(100);
    l_error         varchar2(250);
    l_par           number;
    l_url           varchar2(256);
    l_mfo           varchar2(10);
    l_type          number;
    l_comm          varchar2(256);
    l_dat           date;
    l_count         number(1);
    c               number :=0;
  begin

    if gZAYMODE = 1 then
      --удаляем записи за дату p_date
      bars_audit.info('ZAY. Видалення інформации щодо надходжень за дату =>' || p_date);
      l_dat := to_date(substr(p_date, 1, 10), 'dd/mm/yyyy');
      delete from zay_currency_income_ru d where trunc(d.pdat) = l_dat and d.mfo = trim(p_mfo);
      bars_audit.info('ZAY. Видалення інформації щодо надходжень за дату завершино=>' || to_char(l_dat, 'dd.mm.yyyy'));
      --разбираем хml
      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob(l_parser, decode_base_to_row(p_currency_clob));
      l_doc := dbms_xmlparser.getdocument(l_parser);

      l_data := dbms_xmldom.getelementsbytagname(l_doc, 'CurrencyRow');

      for i in 0 .. dbms_xmldom.getlength(l_data) - 1 loop
        c := c+1;

        l_curr := dbms_xmldom.item(l_data, i);

        dbms_xslprocessor.valueof(l_curr, 'MFO/text()', l_str);
        l_curr_ru.mfo := l_str;

        dbms_xslprocessor.valueof(l_curr, 'BRANCH/text()', l_str);
        l_curr_ru.branch := l_str;

        dbms_xslprocessor.valueof(l_curr, 'PDAT/text()', l_str);
        l_curr_ru.pdat := to_date(replace(l_str, 'T', ' '),'dd.mm.yyyy hh24:mi:ss');

        dbms_xslprocessor.valueof(l_curr, 'TT/text()', l_str);
        l_curr_ru.tt := l_str;

        dbms_xslprocessor.valueof(l_curr, 'REF/text()', l_str);
        l_curr_ru.ref := to_number(l_str);

        dbms_xslprocessor.valueof(l_curr, 'NAZN/text()', l_str);
        l_curr_ru.nazn:= l_str;

        dbms_xslprocessor.valueof(l_curr, 'KV/text()', l_str);
        l_curr_ru.kv := to_number(l_str);

        dbms_xslprocessor.valueof(l_curr, 'LCV/text()', l_str);
        l_curr_ru.lcv:= l_str;

        dbms_xslprocessor.valueof(l_curr, 'RNK/text()', l_str);
        l_curr_ru.rnk:= to_number(l_str);

        dbms_xslprocessor.valueof(l_curr, 'OKPO/text()', l_str);
        l_curr_ru.okpo:= l_str;

        dbms_xslprocessor.valueof(l_curr, 'NMK/text()', l_str);
        l_curr_ru.nmk:= l_str;

        dbms_xslprocessor.valueof(l_curr, 'S/text()', l_str);
        l_curr_ru.s := to_number(l_str);

        dbms_xslprocessor.valueof(l_curr, 'S_OBZ/text()', l_str);
        l_curr_ru.s_obz := to_number(l_str);

        dbms_xslprocessor.valueof(l_curr, 'TXT/text()', l_str);
        l_curr_ru.txt := l_str;

        -- Проверяем наличие записи
        select count(i.ref)
          into l_count
        from zay_currency_income_ru i
        where i.mfo = l_curr_ru.mfo
          and i.ref = l_curr_ru.ref;
       -- Если запись новая добавляем иначе пропускаем
       if l_count = 0 then
          -- Пишем в таблицу
          insert into zay_currency_income_ru values
           (l_curr_ru.mfo,
            l_curr_ru.branch,
            l_curr_ru.pdat,
            l_curr_ru.tt,
            l_curr_ru.ref,
            l_curr_ru.nazn,
            l_curr_ru.kv,
            l_curr_ru.lcv,
            l_curr_ru.rnk,
            l_curr_ru.okpo,
            l_curr_ru.nmk,
            l_curr_ru.s,
            l_curr_ru.s_obz,
            l_curr_ru.txt
           );
         end if;
      end loop;
      --free (не забыть делать очистку в случае ошибок)
      dbms_xmlparser.freeparser(l_parser);
      DBMS_XMLDOM.freeDocument(l_doc);

      select url into l_url from zay_recipients  where mfo = p_mfo;

      l_comm := 'Прийнято інформацію щодо надходжень від РУ МФО ('||p_mfo||'), всього '||to_char(c)||' записів.';

      p_data_transfer(p_req_id => null,
                      p_url    => l_url,
                      p_mfo    => p_mfo,
                      p_type   => 10,
                      p_date   => sysdate,
                      p_result => gTransfer_success,
                      p_comm   => l_comm);
    end if;
  exception
    when others then
      dbms_xmlparser.freeparser(l_parser);
      DBMS_XMLDOM.freeDocument(l_doc);
      bars_audit.info(' error=' || sqlerrm);
      --  raise_application_error(-20001, substr(sqlerrm, 1, 256));
  end iparse_currency_income;

  -------------------------------------------------------------------------------
  --
  -- Передача валюты из РУ в ЦА
  --
  procedure set_currency_income(p_dat date) is
    l_request       soap_rpc.t_request;
    l_response      soap_rpc.t_response;
    l_clob          clob;
    l_encode_clob   clob;
    l_error         varchar2(2000);
    l_currency_xml_body clob;
    l_parser        dbms_xmlparser.parser;
    l_doc           dbms_xmldom.domdocument;
    l_reslist       dbms_xmldom.DOMNodeList;
    l_res           dbms_xmldom.DOMNode;
    l_str           varchar2(2000);
    l_status        varchar2(100);
    l_tmp           xmltype;
    ret_            varchar2(256);
    l_date          date;
    l_mfo           varchar2(10);
    l_url           varchar2(256);
  begin
  -- Только для РУ
    if gZAYMODE = 2 then
    -- Если не передали дату берём системную
      if p_dat is null then
        l_date := trunc(sysdate);
      else
        l_date := trunc(p_dat);
      end if;

      select f_ourmfo into l_mfo from dual;

      select url into l_url from zay_recipients where kf = sys_context('bars_context','user_mfo');
        -- создаём xml
      select '<?xml version="1.0" encoding="windows-1251"?>' ||
                xmlelement("xmlCurrencyIncome",
                  xmlagg(xmlelement("CurrencyRow",
                    xmlelement("MFO", to_char(k.mfo)),
                    xmlelement("BRANCH", to_char(k.branch)),
                    xmlelement("PDAT", to_char(k.pdat,'dd.mm.yyyy hh24:mi:ss')),
                    xmlelement("TT", to_char(k.tt)),
                    xmlelement("REF", to_char(k.ref)),
                    xmlelement("NAZN", k.nazn),
                    xmlelement("KV", to_char(k.kv)),
                    xmlelement("LCV", to_char(k.lcv)),
                    xmlelement("RNK", to_char(k.rnk)),
                    xmlelement("OKPO", to_char(k.okpo)),
                    xmlelement("NMK", k.nmk),
                    xmlelement("S", to_char(k.s)),
                    xmlelement("S_OBZ", to_char(k.s_obz)),
                    xmlelement("TXT", to_char(k.txt)))))
             .getclobval()
      into l_currency_xml_body
      from zay_currency_income k
      where trunc(k.pdat) = l_date;

      -- web-сервис
      l_request := soap_rpc.new_request(p_url         => l_url,
                                        p_namespace   => 'http://tempuri.org/',
                                        p_method      => 'SetCurrency',
                                        p_wallet_dir  => gWallet_dir,
                                        p_wallet_pass => gWallet_pass);
      -- добавидяэм параметры
      soap_rpc.add_parameter(l_request,
                             'currentMfo',
                              l_mfo);
      soap_rpc.add_parameter(l_request,
                             'currentDate',
                              to_char(l_date, 'dd.mm.yyyy'));
      soap_rpc.add_parameter(l_request,
                             'xmlCurrencyIncome',
                             encode_base64(l_currency_xml_body));
      -- позвать метод веб-сервиса
      begin
        l_response := soap_rpc.invoke(l_request);

        --разбираем ответ
        l_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
        l_tmp  := xmltype(l_clob);

        ret_ := extract(l_tmp,
                        '/SetCurrencyResponse/SetCurrencyResult/text()',
                        null);

        l_clob   := l_response.doc.getClobVal();
        l_parser := dbms_xmlparser.newparser;
        dbms_xmlparser.parseclob(l_parser, l_clob);
        l_doc     := dbms_xmlparser.getdocument(l_parser);
        l_reslist := dbms_xmldom.getelementsbytagname(l_doc,
                                                      'SetCurrencyResult');
        l_res     := dbms_xmldom.item(l_reslist, 0);
        dbms_xslprocessor.valueof(l_res, 'Status/text()', l_str);
        l_status := substr(l_str, 1, 150);

        if l_status = 'error' then
          dbms_xslprocessor.valueof(l_res, 'ErrorMessage/text()', l_str);
          p_data_transfer(p_req_id => null,
                          p_url    => l_url,
                          p_mfo    => l_mfo,
                          p_type   => 10,
                          p_date   => sysdate,
                          p_result => gTransfer_eroor,
                          p_comm   => 'error = ' || substr(l_str, 1, 1000));
        elsif l_status <> 'ok' then
          p_data_transfer(p_req_id => null,
                          p_url    => l_url,
                          p_mfo    => l_mfo,
                          p_type   => 10,
                          p_date   => sysdate,
                          p_result => gTransfer_eroor,
                          p_comm   => 'Необрабатываемое значение статуса - ' ||
                                       l_status);
        elsif l_status = 'ok' then
          p_data_transfer(p_req_id => null,
                            p_url    => l_url,
                            p_mfo    => l_mfo,
                            p_type   => 10,
                            p_date   => sysdate,
                            p_result => gTransfer_success,
                            p_comm   => 'До ЦА (МФО ' || l_mfo ||
                                        ') передано інформацію щодо надходжень');
        end if;
        dbms_xmlparser.freeparser(l_parser);
        DBMS_XMLDOM.freeDocument(l_doc);
      exception
        when others then
          dbms_xmlparser.freeparser(l_parser);
          DBMS_XMLDOM.freeDocument(l_doc);
          l_error := substr(sqlerrm, 1, 2000);
          bars_audit.error('set_diler_kurs ERROR: ' || l_error);
          l_error := substr(sqlerrm, 1, 1000);

          p_data_transfer(p_req_id => null,
                          p_url    => l_url,
                          p_mfo    => l_mfo,
                          p_type   => 10,
                          p_date   => sysdate,
                          p_result => gTransfer_eroor,
                          p_comm   => 'exception - ' || l_error);
      end;
      dbms_xmlparser.freeparser(l_parser);
      DBMS_XMLDOM.freeDocument(l_doc);
    end if;
  end set_currency_income;

-------------------------------------------------------------------------------
--
-- Процедура установки параметров клиентов для биржевых заявок
--
procedure set_custzay (
  p_rnk     cust_zay.rnk%type,
  p_dk      number,
  p_nls26   cust_zay.nls26%type,
  p_mfo26   cust_zay.mfo26%type,
  p_okpo26  cust_zay.okpo26%type,
  p_nls29   cust_zay.nls29%type,
  p_fl_pf   cust_zay.fl_pf%type,
  p_rnk_pf  cust_zay.rnk_pf%type,
  p_nlsp    cust_zay.nlsp%type,
  p_nlsv    cust_zay.nlsv%type,
  p_mfov    cust_zay.mfov%type,
  p_kom     cust_zay.kom%type )
is
begin
  insert into cust_zay (rnk, nls26, mfo26, okpo26, nls29, fl_pf, rnk_pf, nlsp, nlsv, mfov, kom, kom2, kom3)
  values (p_rnk, p_nls26, p_mfo26, p_okpo26, p_nls29, p_fl_pf, p_rnk_pf, p_nlsp, p_nlsv, p_mfov,
     decode(p_dk, 1, p_kom, null), decode(p_dk, 2, p_kom, null),
     case when p_dk in (3,4) then p_kom else null end );
exception when dup_val_on_index then
  update cust_zay
     set nls26  = case when p_dk = 2 then p_nls26 else nls26 end,
         mfo26  = p_mfo26,
         okpo26 = p_okpo26,
         nls29  = p_nls29,
         fl_pf  = case when p_dk in (1,3) then p_fl_pf else fl_pf end,
         rnk_pf = case when p_dk in (1,3) then p_rnk_pf else rnk_pf end,
         nlsp   = case when p_dk in (1,3) then p_nlsp else nlsp end,
         nlsv   = case when p_dk in (1,3) then p_nlsv else nlsv end,
         mfov   = case when p_dk in (1,3) then p_mfov else mfov end,
         kom    = case when p_dk = 1 then p_kom else kom end,
         kom2   = case when p_dk = 2 then p_kom else kom2 end,
         kom3   = case when p_dk in (3,4) then p_kom else kom3 end
   where rnk = p_rnk;
end set_custzay;

  --
  -- "Розщеплення надходжень" - вставка/оновлення
  --
  procedure SET_AMOUNT
  ( p_id           in     zay_splitting_amount.id%type
  , p_ref          in     zay_splitting_amount.ref%type
  , p_sale_tp      in     zay_splitting_amount.sale_tp%type
  , p_amnt         in     zay_splitting_amount.amnt%type
  ) is
    title       constant  varchar2(60) := 'bars_zay.set_amount';
    l_kf                  zay_splitting_amount.kf%type := sys_context('bars_context','user_mfo');
  begin

    bars_audit.trace( '%s: Entry with ( p_id=%s, l_kf=%s, p_ref=%s, p_sale_tp=%s, p_amnt=%s ).'
                    , title, to_char(p_id), l_kf, to_char(p_ref), to_char(p_sale_tp), to_char(p_amnt) );

    if ( p_id > 0 )
    then

      update BARS.ZAY_SPLITTING_AMOUNT
         set SALE_TP = p_sale_tp
           , AMNT    = p_amnt
       where ID      = p_id;

      bars_audit.trace( '%s: Updated %s record(s).', title, to_char(sql%rowcount) );

    else

      insert
        into BARS.ZAY_SPLITTING_AMOUNT
        ( ID, KF, REF, SALE_TP, AMNT )
      values
        ( BARS.S_ZAY_SPLITTING_AMOUNT.NextVal, l_kf, p_ref, p_sale_tp, p_amnt );

      bars_audit.trace( '%s: Inserted %s record(s).', title, to_char(sql%rowcount) );

    end if;

    bars_audit.trace( '%s: Exit.', title );

  end SET_AMOUNT;

  --
  -- "Розщеплення надходжень" - видалення
  --
  procedure DEL_AMOUNT
  ( p_id           in     zay_splitting_amount.id%type
  ) is
    title   constant  varchar2(60) := 'bars_zay.del_amount';
  begin

    bars_audit.trace( '%s: Entry with ( p_id=%s ).', title, to_char(p_id) );

    if ( p_id > 0 )
    then

      delete BARS.ZAY_SPLITTING_AMOUNT
       where ID      = p_id;

      bars_audit.trace( '%s: Deleted %s record(s).', title, to_char(sql%rowcount) );

    end if;

    bars_audit.trace( '%s: Exit.', title );

  end DEL_AMOUNT;


--COBUSUPABS-5483
procedure upd_zay_params(p_ref oper.ref%type ,p_tag operw.tag%type,p_value operw.value%type)
is
    l_zayavka            zayavka%rowtype;
    ex_parentnotfound    exception;
    pragma exception_init(ex_parentnotfound, -2291);

    function ex_init(p_sqlerrm varchar2)
    return varchar2
    is
    begin
    return substr(p_sqlerrm,instr(p_sqlerrm,'(')+6,instr(p_sqlerrm,')')-instr(p_sqlerrm,'(')-6);
    end;

begin

--по одному рефу может быть несколько заявок Оо (когда разбивают суму на несколько заявок)
    for c in (select id from zayavka where sos=2 and ref=p_ref)
    loop

        select * into l_zayavka from zayavka where id=c.id;

        update zayavka
        set  meta          = case when p_tag='D1#70' then to_number(p_value) else l_zayavka.meta end,
             contract      = case when p_tag='D2#70' then p_value else l_zayavka.contract end,
             dat2_vmd      = case when p_tag='D3#70' then to_date(p_value,'dd.mm.yyyy') else l_zayavka.dat2_vmd end,
             dat_vmd       = case when p_tag='D4#70' then to_date(p_value,'dd.mm.yyyy') else l_zayavka.dat_vmd end,
             dat5_vmd      = case when p_tag='D5#70' then p_value else l_zayavka.dat5_vmd end,
             country       = case when p_tag='D6#70' then to_number(p_value) else l_zayavka.country end,
             basis         = case when p_tag='D7#70' then p_value else l_zayavka.basis end,
             benefcountry  = case when p_tag='D8#70' then to_number(p_value) else l_zayavka.benefcountry end,
             bank_code     = case when p_tag='D9#70' then p_value else l_zayavka.bank_code end,
             bank_name     = case when p_tag='DA#70' then p_value else l_zayavka.bank_name end,
             product_group = case when p_tag='DB#70' then p_value else l_zayavka.product_group end
         where id=c.id;

    end loop;
exception when ex_parentnotfound then
  if    ex_init(sqlerrm)='FK_ZAYAVKA_ZAYAIMS'
  then
     bars_error.raise_nerror (modcode, 'FK_ZAYAVKA_ZAYAIMS');
  elsif ex_init(sqlerrm)='XFK_ZAYAVKA_COUNTRY'
  then
     bars_error.raise_nerror (modcode, 'XFK_ZAYAVKA_COUNTRY');
  elsif ex_init(sqlerrm)='FK_ZAYAVKA_PRODUCT_GROUP'
  then
     bars_error.raise_nerror (modcode, 'FK_ZAYAVKA_PRODUCT_GROUP');
  else raise; end if;
end;

--очищення ZAY від застарілих заявок --COBUMMFO-6744
procedure del_zay_old
is
 l_idback ZAY_BACK.ID%TYPE:=77; -- код причини повернення
 l_comm_back ZAY_BACK.REASON%TYPE; -- причина повернення

 -- фінальна обробка прострочених заявок -  !!!!
 procedure del_zay_fin(l_id zayavka.id%TYPE) is
  l_mfo    VARCHAR2 (10);
  l_url    VARCHAR2 (256);
 begin
     update zayavka  set sos = -1, viza = -1,  idback = 77 where id = del_zay_fin.l_id;
     SELECT r.url, r.mfo INTO l_url, l_mfo  FROM ZAY_RECIPIENTS r where mfo = '300465';
     INSERT INTO zay_data_transfer (id,req_id,url,mfo,transfer_type,transfer_date,transfer_result,comm)
     VALUES (bars_sqnc.get_nextval('s_zay_data_transfer'),
             del_zay_fin.l_id, l_url, l_mfo, 8, SYSDATE,0,'Повернення прострочених заявок на купівлю-продаж валюти');

 end;

begin
    select t.reason into l_comm_back  from ZAY_BACK t where t.id= l_idback;--причина повернення

---сторона Дилера ЦА (ZAY42) в ММФО
    bc.go('300465'); --дилер на ЦА
    ----вибір старих заявок у стані,віза 0,2 для ЦА ---------------------------
    for rec_dill in (
              select * from ( SELECT id,sos,viza,fdat,mfo FROM v_zay WHERE
                dk = 1 AND s2 > 0 AND nvl(fdat,bankdate) <= bankdate
                and sos < 1 AND sos >= 0 AND viza >= 0 OR sos >=1 AND vdate = bankdate)
              where (fdat+30)<bankdate and sos=0 and viza=2
              )
    loop
      -- повернення з дилера ЦА в РУ на ZAY3
      back_request(p_mode => 4,p_id => rec_dill.id,p_idback => l_idback,p_comm => l_comm_back); --збиваємо на 0,1
      bars_audit.info('BARS_ZAY.'||rec_dill.id||'.'||rec_dill.mfo);
      commit;
    end loop;
------------------------------------------------------------------------------------------
--- сторона РУ в ММФО

    for rec_kf in ( select * from mv_kf where kf !=300465 ) --всі РУ в ММФО
    loop
     bc.go(rec_kf.kf);
          ----вибір старих заявок (0,1) для РУ ММФО(ZAY3,ZAY12)
          for rec_ru in (
             select * from (
                      select id,sos,viza,fdat,kf
                      from zayavka
                      WHERE dk = 1 AND s2 > 0 AND nvl(fdat,bankdate) <= bankdate
                      and sos < 1 AND sos >= 0 AND viza >= 0 OR sos >=1 AND vdate = bankdate

                      )
                   where (fdat+30)<bankdate and sos=0 and viza in (0,1) --and mfo=rec_kf.kf
                   )
          loop
            -- Заявка спущена до ZAY3 (0,1)
            if rec_ru.viza=1 then
              back_request(p_mode => 1,p_id => rec_ru.id,p_idback => l_idback,p_comm => l_comm_back); --збиваємо на 0,-1
              del_zay_fin(rec_ru.id);--збиваємо на -1,-1
            end if;
            --Заявка спущена на ZAY12 - (0,-1)
            if rec_ru.viza=0 then
             del_zay_fin(rec_ru.id);--збиваємо на -1,-1
            end if;
          end loop;
    end loop;

------------------------------------------------------------------------------------------

end;
-------------------------------------


begin
  init;
end BARS_ZAY;
/

