PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Package/DPT_WEB.sql =============*** Run ***
PROMPT ===================================================================================== 

create or replace package DPT_WEB
is
  --
  -- основной пакет процедур для работы модуля "Вклады населения-WEB"
  --
  g_header_version  constant varchar2(32)  := 'version 40.02  30.05.2018';
  g_awk_header_defs constant varchar2(512) := 'расширенный функционал: '                              || chr(10) ||
                                              '  - учет доп.соглашений'                               || chr(10) ||
                                              '  - формирование запросов'                             || chr(10) ||
                                              '  - выполнение автомат.заданий'                        || chr(10) ||
                                              '  - учет техн.счетов'                                  || chr(10) ||
                                              '  - выплата наследникам'                               || chr(10) ||
                                              '  - поддержка хранилища документов по договорам'       || chr(10) ||
                                              'EBP - обслуговування вкдадників згідно ЕБП (Ощадбанк)' || chr(10) ||
                                              'SMS - віддправка SMS повідомлень';

  request_allowed    constant number(1) := 1;
  request_disallowed constant number(1) := -1;

  req_chgint_ind constant number(1) := 1;
  req_chgint_vid constant number(1) := 2;

  type t_cursor is ref cursor;
  type acc_rec is record(
    acc_num     accounts.nls%type,
    acc_cur     accounts.kv%type,
    acc_name    accounts.nms%type,
    cust_name   customer.nmk%type,
    cust_idcode customer.okpo%type);

  -- для триггеров tiud_intratn_dptavans*
  type t_raterec is record(
    acc  int_ratn.acc%type,
    id   int_ratn.id%type,
    bdat int_ratn.bdat%type,
    ir   int_ratn.ir%type,
    op   int_ratn.op%type,
    br   int_ratn.br%type);
  type t_ratelist is table of t_raterec;
  g_raterec  t_ratelist := t_ratelist();
  g_ratesync boolean := false;

  --
  type t_dptid is table of dpt_deposit.deposit_id%type index by pls_integer;

  --
  -- служебные функции оперделения версии заголовка / пакета
  --
  function header_version return varchar2;
  function body_version return varchar2;

  --
  -- Поиск клиента
  --
  procedure p_search_customer(p_okpo   in customer.okpo%type, -- идентификационный код
                              p_nmk    in customer.nmk%type, -- ФИО вкладчика
                              p_bday   in person.bday%type, -- дата рождения
                              p_ser    in person.ser%type, -- серия паспорта
                              p_numdoc in person.numdoc%type, -- номер паспорта
                              p_cust   out t_cursor); -- рег.№ клиента

  --
  -- Закрытие курсора (после поиска вкладчиков)
  --
  procedure p_close_cursor(p_cust in out t_cursor);

  --
  -- Проверка достаточности входных параметров для  поиска вклада.
  --
  function enough_search_params(p_dptid     in dpt_deposit.deposit_id%type, -- идентификатор договора
                                p_dptnum    in dpt_deposit.nd%type, -- номер договора
                                p_custid    in dpt_deposit.rnk%type, -- регистр.№ клиента
                                p_accnum    in accounts.nls%type, -- № депозитного счета
                                p_custname  in customer.nmk%type, -- ФИО клиента
                                p_custcode  in customer.okpo%type, -- идентиф.код клиента
                                p_birthdate in person.bday%type, -- дата рождения клиента
                                p_docserial in person.ser%type, -- серия документа
                                p_docnum    in person.numdoc%type, -- № документа
                                p_extended  in number default null -- вклад чужого відділення = 1
                                ) return number;

  --
  -- Регистрация нового клиента-вкладчика/обновление карточки существующего клиента
  --
  procedure p_open_vklad_rnk(p_clientname       in customer.nmk%type, -- ФИО клиента
                             p_client_name      in customer.nmk%type default null, -- имя
                             p_client_surname   in customer.nmk%type default null, -- фамилия
                             p_client_patr      in customer.nmk%type default null, -- отчество
                             p_country          in customer.country%type default null, -- код страны (гражданство)
                             p_index            in customer.adr%type default null, -- почтовый индекс      |
                             p_obl              in customer.adr%type default null, -- область              |
                             p_district         in customer.adr%type default null, -- район                | адрес регистрации
                             p_settlement       in customer.adr%type default null, -- населенный пункт     |
                             p_adress           in customer.adr%type default null, -- улица, дом, квартира |
                             p_fulladdress      in customer.adr%type default null, -- полный адрес регистрации
                             p_territory        in number default null, -- код території адреса регистрации
                             p_clientcodetype   in customer.tgr%type default 2, -- тип реестра
                             p_clientcode       in customer.okpo%type, -- идентификационный код
                             p_doctype          in person.passp%type default 1, -- тип документа
                             p_docserial        in person.ser%type default null, -- серия док-та
                             p_docnumber        in person.numdoc%type default null, -- номер док-та
                             p_docorg           in person.organ%type default null, -- организация, выдавшая документ
                             p_docdate          in person.pdate%type default null, -- дата выдачи док-та
                             p_photodate        in person.date_photo%type default null, -- Дата коли була вклеєна остання фотографія у паспорт
                             p_clientbdate      in person.bday%type default null, -- дата рождения
                             p_clientbplace     in person.bplace%type default null, -- место рождения
                             p_clientsex        in person.sex%type default null, -- пол
                             p_special_marks    in cust_mark_types.mark_code%type default null, -- код спеціальної відмітки клієнта
                             p_clientcellphone  in person.teld%type default null, -- моб.телефон
                             p_clienthomeph     in person.teld%type default null, -- дом.телефон
                             p_clientworkph     in person.telw%type default null, -- раб.телефон
                             p_clientname_gc    in customer.nmk%type default null, -- ФИО клиента в родит.падеже
                             p_resid_code       in number default 1, -- признак инсайдера  (1-инсайдер, 0 нет)
                             p_resid_index      in customer.adr%type default null, -- почтовый индекс      |
                             p_resid_obl        in customer.adr%type default null, -- область              |
                             p_resid_district   in customer.adr%type default null, -- район                | фактический адрес
                             p_resid_settlement in customer.adr%type default null, -- населенный пункт     |
                             p_resid_adress     in customer.adr%type default null, -- улица, дом, квартира |
                             p_resid_territory  in number default null, -- код території фактического адреса
                             p_clientid         in out customer.rnk%type, -- регистрационный № клиента
                             p_selfemployer     in number default null, -- ознака самозайнятої особи
                             p_taxagencycode    in customer.c_reg%type default null, -- Код ДПА
                             p_regagencycode    in customer.c_dst%type default null, -- Код органу реєстрації
                             p_registrydate     in customer.date_on%type default null, -- дата регистрации клиента
                             p_usagemode        in varchar2 default 'IU' -- режим выполнения процедуры
                             );

  --
  -- Создание депозитного договора
  --
  procedure create_deposit(p_vidd          in dpt_deposit.vidd%type, -- код вида вклада
                           p_rnk           in dpt_deposit.rnk%type, -- рег.№ вкладчика
                           p_nd            in dpt_deposit.nd%type, -- номер договора (произвольный)
                           p_sum           in dpt_deposit.limit%type, -- сумма вклада пол договору
                           p_nocash        in number, -- БЕЗНАЛ взнос (0-НАЛ,1- БЕЗНАЛ)
                           p_datz          in dpt_deposit.datz%type, -- дата заключения договора
                           p_namep         in dpt_deposit.name_p%type, -- получатель %%
                           p_okpop         in dpt_deposit.okpo_p%type, -- идентиф.код получателя %%
                           p_nlsp          in dpt_deposit.nls_p%type, -- счет для выплаты %%
                           p_mfop          in dpt_deposit.mfo_p%type, -- МФО для выплаты %%
                           p_fl_perekr     in dpt_vidd.fl_2620%type, -- флаг открытия техн.счета
                           p_name_perekr   in dpt_deposit.nms_d%type, -- получатель депозита
                           p_okpo_perekr   in dpt_deposit.okpo_p%type, -- идентиф.код получателя депозита
                           p_nls_perekr    in dpt_deposit.nls_d%type, -- счет для возврата депозита
                           p_mfo_perekr    in dpt_deposit.mfo_d%type, -- МФО для возврата депозита
                           p_comment       in dpt_deposit.comments%type, -- комментарий
                           p_dpt_id        out dpt_deposit.deposit_id%type, -- идентификатор договора
                           p_datbegin      in dpt_deposit.dat_begin%type default null, -- дата открытия договора
                           p_duration      in dpt_vidd.duration%type default null, -- длительность (мес.)
                           p_duration_days in dpt_vidd.duration_days%type default null, -- длительность (дней)
                           p_wb            in dpt_deposit.wb%type default 'N'); -- признак открытия через веббанинг

  --
  -- Авторизация депозитного договора
  --
  procedure sign_deposit(p_dptid in dpt_deposit.deposit_id%type); -- идентификатор депозитного договора

  --
  -- Запись текста договора или доп.соглашения
  --
  procedure create_text(p_id   in cc_docs.id%type, -- идентификатор шаблона
                        p_nd   in cc_docs.nd%type, -- идентификатор договора
                        p_adds in cc_docs.adds%type, -- номер доп.соглашения (=dpt_agreements.agrmnt_num)
                        p_text in cc_docs.text%type); -- текст договора

  --
  -- Запись текста договора при пролонгации
  --
  procedure prolongation_create_text(p_id   in cc_docs.id%type,
                                     p_nd   in cc_docs.nd%type,
                                     p_text in cc_docs.text%type);

  function dpt_closing_permitted(p_dpt in dpt_deposit.deposit_id%type)
    return number;
  --
  -- Проверка возможности закрытия счета
  --
  function acc_closing_permitted(p_acc in accounts.acc%type, -- внутр.номер счета
                                 p_sos in sos.sos%type) -- тип закрытия:
   return number; -- 0 = не допускается наличие док-тов
  -- 1 = допускается наличие план.док-тов
  --                                                           -- 3 = допускается наличие план./форвардн.док-тов
  -- Проверка возможности закрытия договора                    -- 5 = допускается наличие любых док-тов
  --
  function closing_permitted(p_dptid in dpt_deposit.deposit_id%type, -- идентификатор договора
                             p_sos   in sos.sos%type) -- тип закрытия
   return number;

  --
  -- Проверка возможности удаления деп.договора (1 - можно)
  --
  function dpt_del_enabled(p_dptid in dpt_deposit.deposit_id%type, -- идентификатор договора
                           p_dat   in dpt_deposit.dat_begin%type default bankdate) -- текущая банковская дата
   return number;

  --
  -- Удаление в архив депозитного договора
  --
  procedure dpt_delete(p_dptid    in dpt_deposit.deposit_id%type, -- идентификатор договора
                       p_dat      in fdat.fdat%type default bankdate, -- текущая банковская дата
                       p_reasonid in bp_reason.id%type default 13); -- код причины возврата при сторно док-тов

  --
  -- Изменение вида депозитного договора
  --
  procedure change_deposit_type(p_dptid   in dpt_deposit.deposit_id%type, -- идентификатор договора
                                p_typeid  in dpt_deposit.vidd%type, -- код вида вклада
                                p_amount  in dpt_deposit.limit%type, -- сумма вклада пол договору
                                p_nocash  in number, -- признак БЕЗНАЛ внесения средств (0-НАЛ,1- БЕЗНАЛ)
                                p_payoff  in number, -- флаг открытия техн.счета
                                p_comment in dpt_deposit.comments%type); -- комментарий

  --
  --  Изменение параметров выплаты процентов и возврата вклада
  --
  procedure change_deposit_accounts(p_dptid         in dpt_deposit.deposit_id%type, -- идентификатор договора
                                    p_intrcpname    in dpt_deposit.name_p%type, -- ФИО получателя процентов
                                    p_intrcpidcode  in dpt_deposit.okpo_p%type, -- иден. код получателя процентов
                                    p_intrcpacc     in dpt_deposit.nls_p%type, -- счет получателя процентов
                                    p_intrcpmfo     in dpt_deposit.mfo_p%type, -- МФО счета получателя процентов
                                    p_restrcpname   in dpt_deposit.nms_d%type, -- ФИО получателя депозита
                                    p_restrcpidcode in dpt_deposit.okpo_p%type, -- иден. код получателя депозита
                                    p_restrcpacc    in dpt_deposit.nls_d%type, -- счет получателя депозита
                                    p_restrcpmfo    in dpt_deposit.mfo_d%type); -- МФО счета получателя депозита

  --
  -- Перерасчет процентов при частичном снятия суммы депозита
  --
  procedure p_write_down(p_dptid  in dpt_deposit.deposit_id%type, -- идентификатор договора
                         p_dptsum in number, -- сумма част.снятия
                         p_acrsum out number); -- сумма процентов к выплате

  --
  -- Сумма комиссии за прием ветхих купюр при досрочном расторжении договора (в копейках)
  --
  function get_decrepit_penya(p_dptid in dpt_deposit.deposit_id%type)
    return number;

  --
  -- Взыскание штрафа при досрочном расторжении договора
  --
  procedure penalty_payment(p_dptid       in dpt_deposit.deposit_id%type, -- идентификатор договора
                            p_penalty     in number, -- сумма штрафа
                            p_dptrest     out number, -- сумма депозита к выплате
                            p_intrest     out number, -- сумма процентов к выплате
                            p_int2pay_ing out number);

  --
  -- Процедура создания доп.соглашений (ДС)
  --
  procedure create_agreement(p_dptid          in dpt_agreements.dpt_id%type, -- идентификатор договора
                             p_agrmnttype     in dpt_agreements.agrmnt_type%type, -- тип ДС
                             p_initcustid     in dpt_deposit.rnk%type, -- рег.№ инициатора ДС
                             p_trustcustid    in customer.rnk%type, -- рег.№ 3-го лица
                             p_trustid        in dpt_trustee.id%type, -- код аннулируемого ДС о 3-их лицах
                             p_transferdpt    in clob, -- параметры возврата депозита
                             p_transferint    in clob, -- параметры выплаты процентов
                             p_amountcash     in dpt_agreements.amount_cash%type, -- сумма пополнения/снятия нал.
                             p_amountcashless in dpt_agreements.amount_cashless%type, -- сумма пополнения/снятия безнал.
                             p_datbegin       in dpt_agreements.date_begin%type, -- новая дата начала договора
                             p_datend         in dpt_agreements.date_end%type, -- новая дата окончания договора
                             p_ratereqid      in dpt_agreements.rate_reqid%type, -- код запроса на изменение ставки
                             p_ratevalue      in dpt_agreements.rate_value%type, -- новое значение %-ной ставки
                             p_ratedate       in dpt_agreements.rate_date%type, -- дата начала действия новой ставки
                             p_denomamount    in dpt_agreements.denom_amount%type, -- сумма ветхих купюр
                             p_denomcount     in dpt_agreements.denom_count%type, -- кол-во ветхих купюр
                             p_denomref       in dpt_agreements.denom_ref%type, -- реф.комиссии за прием ветхих купюр
                             p_comissref      in dpt_agreements.comiss_ref%type, -- реф.комиссии за оформление ДС
                             p_docref         in dpt_agreements.doc_ref%type, -- реф. документа пополнения/частичного снятия
                             p_comissreqid    in dpt_agreements.comiss_reqid%type, -- идентификатор запроса на отмену комисии
                             p_agrmntid       out dpt_agreements.agrmnt_id%type, -- ідентифікатор ДУ
                             p_templateid     in dpt_agreements.template_id%type default null, -- ІД шаблону ДУ
                             p_freq           in dpt_deposit.freq%type default null, -- нова періодичність виплати відсотків
                             p_access_others  in dpt_agrw.value%type default null -- поле інше в шаблоні доступу додугод
                             );
  --
  -- Закрытие доп.соглашений
  --
  procedure agreement_termination(p_dptid      in dpt_agreements.dpt_id%type, -- идентификатор договора
                                  p_agrmnttype in dpt_agreements.agrmnt_type%type, -- тип ДС
                                  p_agrmntid   in dpt_agreements.agrmnt_id%type, -- идентификатор ДС
                                  p_trustid    in dpt_agreements.trustee_id%type); -- код ДС о 3-их лицах

  --
  -- Расчет тарифов за изготовление доп.соглашений
  --
  function f_tarif_agreement(p_dptid    in dpt_deposit.deposit_id%type, -- идентификатор договора
                             p_tarifid  in tarif.kod%type, -- код тарифа (основной)
                             p_tarifid2 in tarif.kod%type) -- код тарифа (альтернативный)
   return number;

  --
  -- Сторнирование доп. соглашения
  --
  procedure p_reverse_agrement(p_agr_id in dpt_agreements.agrmnt_id%type); -- уникальный номер доп.соглашения

  --
  -- Закрытие непополненных договоров
  --
  procedure auto_close_blank_deposit(p_dptid  in dpt_deposit.deposit_id%type, -- идентификатор договора (0-все)
                                     p_runid  in dpt_jobs_jrnl.run_id%type, -- № запуска автомат.задания
                                     p_branch in branch.branch%type, -- код подразделения
                                     p_bdate  in fdat.fdat%type); -- текущая банковская дата

  --
  -- Начисление процентов по депозитным договорам (по указанную дату - 1)
  --
  procedure auto_make_int(p_dptid  in dpt_deposit.deposit_id%type, -- идентификатор договора (0 - все)
                          p_runid  in dpt_jobs_jrnl.run_id%type, -- № запуска автомат.задания
                          p_branch in dpt_deposit.branch%type, -- код подразделения
                          p_bdate  in fdat.fdat%type); -- текущая банковская дата

  --
  -- Начисление процентов в предпоследний рабочий день месяца по депозитным договорам
  --
  procedure auto_make_int_monthly(p_dptid  in dpt_deposit.deposit_id%type, -- идентификатор договора (0 - все)
                                  p_runid  in dpt_jobs_jrnl.run_id%type, -- № запуска автомат.задания
                                  p_branch in dpt_deposit.branch%type, -- код подразделения
                                  p_bdate  in fdat.fdat%type, -- текущая банковская дата
                                  p_mode   in number); -- режим запуска функции

  --
  -- Начисление процентов в предпоследний рабочий день месяца по депозитным договорам
  -- Оптимизировано
  procedure auto_make_int_monthly_opt(p_dptid  in dpt_deposit.deposit_id%type, -- идентификатор договора (0 - все)
                                      p_runid  in dpt_jobs_jrnl.run_id%type, -- № запуска автомат.задания
                                      p_branch in dpt_deposit.branch%type, -- код подразделения
                                      p_bdate  in fdat.fdat%type, -- текущая банковская дата
                                      p_mode   in number); -- режим запуска функции

  --
  -- Начисление процентов по договорам, срок действия которых истек
  --
  procedure auto_make_int_finally(p_dptid  in dpt_deposit.deposit_id%type, -- идентификатор договора (0 - все)
                                  p_runid  in dpt_jobs_jrnl.run_id%type, -- № запуска автомат.задания
                                  p_branch in dpt_deposit.branch%type, -- код подразделения
                                  p_bdate  in fdat.fdat%type); -- текущая банковская дата

  --
  -- Безналичная выплата процентов по депозитным договорам
  --
  procedure auto_payout_int(p_dptid  in dpt_deposit.deposit_id%type, -- идентификатор договора (0 - все)
                            p_runid  in dpt_jobs_jrnl.run_id%type, -- № запуска автомат.задания
                            p_branch in dpt_deposit.branch%type, -- код подразделения
                            p_bdate  in fdat.fdat%type); -- текущая банковская дата

  --
  -- Начисление и безнал.выплата процентов по депозитным договорам по индивид.графику
  --
  procedure auto_payout_int_plan(p_dptid  in dpt_deposit.deposit_id%type, -- идентификатор договора (0 - все)
                                 p_runid  in dpt_jobs_jrnl.run_id%type, -- № запуска автомат.задания
                                 p_branch in dpt_deposit.branch%type, -- код подразделения
                                 p_bdate  in fdat.fdat%type); -- текущая банковская дата

  --
  -- Возврат депозита и начисленных процентов по окончанию депозитных договоров
  --
  procedure auto_maturity_payoff(p_dptid  in dpt_deposit.deposit_id%type, -- идентификатор договора (0 - все)
                                 p_runid  in dpt_jobs_jrnl.run_id%type, -- № запуска автомат.задания
                                 p_branch in dpt_deposit.branch%type, -- код подразделения
                                 p_bdate  in fdat.fdat%type); -- текущая банковская дата

  --
  -- Закрытие депозитных договоров в архив
  --
  procedure auto_move2archive(p_dptid  in dpt_deposit.deposit_id%type, -- идентификатор договора (0 - все)
                              p_runid  in dpt_jobs_jrnl.run_id%type, -- № запуска автомат.задания
                              p_branch in dpt_deposit.branch%type, -- код подразделения
                              p_bdate  in fdat.fdat%type); -- текущая банковская дата

  --
  -- Закрытие депозитных договоров в архив (опт)
  --
  procedure auto_move2archive_opt
  ( p_runid  in dpt_jobs_jrnl.run_id%type -- № запуска автомат.задания
  , p_bdate  in fdat.fdat%type            -- текущая банковская дата
  );
  
  --
  -- Изменение процентной ставки на 0% по окончанию срока депозитных договоров
  --
  procedure auto_rate_down(p_dptid  in dpt_deposit.deposit_id%type, -- идентификатор договора (0 - все)
                           p_runid  in dpt_jobs_jrnl.run_id%type, -- № запуска автомат.задания
                           p_branch in dpt_deposit.branch%type, -- код подразделения
                           p_bdate  in fdat.fdat%type); -- текущая банковская дата

  --
  -- Переоформление депозитных договоров (с перерегистрацией)
  --
  procedure auto_extension(p_dptid  in dpt_deposit.deposit_id%type, -- идентификатор договора (0 - все)
                           p_runid  in dpt_jobs_jrnl.run_id%type, -- № запуска автомат.задания
                           p_branch in dpt_deposit.branch%type, -- код подразделения
                           p_bdate  in fdat.fdat%type); -- текущая банковская дата

  --
  --  Перенесення суми вкладу та відсотків на техн.вклад до запитання
  --
  procedure auto_move2dmnd(p_bdate in fdat.fdat%type);

  --
  -- Перенесення депозитів у "НЕРУХОМІ"
  --
  procedure auto_move2immobile(p_dptid in t_dptid, -- dpt_deposit.deposit_id%type,
                               p_runid in dpt_jobs_jrnl.run_id%type,
                               p_bdate in fdat.fdat%type);

  --
  -- Фактическое закрытие технических счетов
  --
  procedure auto_close_techacc(p_accid  in accounts.acc%type, -- внутр. №  техн.счета (0- все)
                               p_runid  in dpt_jobs_jrnl.run_id%type, -- № запуска автомат.задания
                               p_branch in branch.branch%type, -- код подразделения
                               p_bdate  in fdat.fdat%type); -- текущая банковская дата

  --
  -- Проверка допустимости закрытия технического счета
  --
  function f_techacc_allow2close(p_accid in accounts.acc%type) -- внутр.№ технического счета
   return number;

  --
  -- Формрирование заявки на закрытие технических счетов (плановое закрытие)
  --
  procedure p_techacc_close(p_type   in number, -- тип закрытия: 1-план
                            p_accid  in accounts.acc%type, -- внутр. №  техн.счета (0- все)
                            p_dat    in fdat.fdat%type, -- текущая банковская дата
                            p_branch in branch.branch%type, -- код подразделения
                            p_runid  in dpt_jobs_jrnl.run_id%type); -- № запуска автомат.задания

  --
  -- Обновление документа безнал.пополнения техн.счета при снятии комиссии
  --
  procedure p_tech_oper_update(p_ref  in oper.ref%type, -- референс док-та безнал.пополнения
                               p_refl in oper.refl%type); -- референс док-та комиссии

  --
  -- Взыскание комисии за безнал.пополнение техн.счета
  --
  procedure p_techacc_nocash_comiss(p_ref0 in oper.ref%type, -- референс док-та безнал.пополнения
                                    p_ref  out oper.ref%type); -- референс док-та комиссии

  --
  -- Проверка: была ли взыскана комиссия за открытие техн.счета
  -- возвращает
  -- 'Y'  - если комиссия была взыскана и документ оплачен / ждет визу
  -- 'N'  - если комиссия не была взыскана или документ сторнирован
  -- null - если за выполнение операции типа p_typeop не предполагается взыскание комиссии
  --
  function techacc_open_comiss_taken(p_dptid  in dpt_deposit.deposit_id%type, -- идентификатор договора
                                     p_typeop in dpt_op.id%type) -- тип операции  (из спр-ка dpt_op)
   return char;

  --
  -- Функция печати номера и даты договора в назначении платежа
  --
  function f_nazn(p_type   in char, -- симв.код
                  p_dpt_id in dpt_deposit.deposit_id%type) -- идентификатор договора
   return varchar2;

  --
  -- Функция определения кода операции
  --
  function get_tt(p_type     dpt_op.id%type, -- тип депозитной операции
                  p_interpay number, -- 0 = внутрибанк  / 1 = межбанк
                  p_cardpay  number, -- 0 = стандартный / 1 = карточный
                  p_currency tabval.kv%type) -- код валюты
   return char;

  --
  -- Функция формирования назначения платежа по формуле из карточки операции
  --
  function get_nazn(p_tt     in tts.tt%type, -- код операции
                    p_dptid  in dpt_deposit.deposit_id%type, -- идентификатор договора
                    p_dptnum in dpt_deposit.nd%type, -- номер договора
                    p_dptdat in dpt_deposit.datz%type) -- дата заключения договора
   return varchar2;

  --
  -- Функция определения вида документа
  --
  function get_vob(p_kva  in tabval.kv%type, -- код валюты А
                   p_kvb  in tabval.kv%type, -- код валюты Б
                   p_tt   in tts.tt%type default null, -- код операции
                   p_type in dpt_op.id%type default null) -- тип депозитной операции
   return number;

  --
  -- Функция определения суммы платежа по формуле из карточки операции
  --
  function get_amount(p_tt        in tts.tt%type, -- код операции
                      p_formula   in tts.s%type, -- формула вычисления суммы
                      p_dealnum   in varchar2, -- идентификатор договора
                      p_ref       in oper.ref%type, -- референс первичного документа
                      p_suma      in oper.s%type, -- сумма-А первичного документа
                      p_sumb      in oper.s2%type, -- сумма-Б первичного документа
                      p_curcodea  in oper.kv%type, -- валюта-А первичного документа
                      p_curcodeb  in oper.kv2%type, -- валюта-Б первичного документа
                      p_amountm   in oper.s%type, -- основная сумма
                      p_curcodem  in oper.kv%type, -- основная валюта
                      p_accnuma   in oper.nlsa%type, -- счет-А первичного документа
                      p_accnumb   in oper.nlsb%type, -- счет-Б первичного документа
                      p_bankcodea in oper.mfoa%type, -- МФО банка-А первичного документа
                      p_bankcodeb in oper.mfob%type) -- МФО банка-Б первичного документа
   return number;

  --
  -- Проверка допустимости выплаты процентов
  --
  function f_allow2pay(p_intacc in dpt_deposit.acc%type, -- внутр.№ счета начисл.процентов
                       p_freq   in dpt_deposit.freq%type, -- период-ть выплаты процентов
                       p_begdat in dpt_deposit.dat_begin%type, -- дата начала действия вклада
                       p_enddat in dpt_deposit.dat_end%type, -- дата окончания действия вклада
                       p_curdat in date default gl.bdate, -- банковская дата
                       p_avans  in number default 0, -- признак авансовой выплаты процентов
                       p_extend in number default 0) -- признак переоофрмленного вклада
   return number;

  --
  -- Проверка на принадлежность банка к мульти-МФО-системе
  --
  function f_interbank(p_mfo in banks.mfo%type) -- МФО банка / филиала
   return number;

  --
  -- Проверка, является ли счет - карточным (Transmaster)
  --
  function account_is_card(p_bankcode in banks.mfo%type, -- МФО банка, в котором открыт счет
                           p_accnum   in accounts.nls%type) -- номер счета
   return number;

  --
  --  Поиск реквизитов счета / владельца счета
  --
  function search_acc_params(p_accid in accounts.acc%type) -- внутр. № счета
   return acc_rec;

  --
  -- Запись документа в хранилище документов по договору
  --
  procedure fill_dpt_payments(p_dptid  in dpt_payments.dpt_id%type, -- идентификатор договора
                              p_ref    in dpt_payments.ref%type, -- референс документа
                              p_branch in dpt_payments.branch%type default null, -- бранч документа
                              p_rnk    in dpt_payments.rnk%type default null -- РНК клієнта
                              );

  --
  -- Сторнирование всех бухгалтерских документов по договору
  --
  procedure kill_dpt_payments(p_dptid     in dpt_payments.dpt_id%type, -- идентификатор договора
                              p_ref       in dpt_payments.ref%type default 0, -- референс договора (0-все)
                              p_docstatus in sos.sos%type default 5, -- макс.статус сторнируемых документов
                              p_reasonid  in bp_reason.id%type default 13, -- код причины сторнирования
                              p_levelid   in number default 3, -- уровень сторнирования
                              p_fullback  in number default 1, -- признак полного сторно
                              p_novisa    in number default 0); -- запрет на наличие положит.виз

  --               |= 1 - плановые
  -- p_docstatus = |= 3 - плановые + форвардные
  --               |= 5 - все

  --
  -- Оплата документа по договору с учетом особенностей мульти-МФО-системы
  --
  procedure paydoc(p_dptid    in dpt_deposit.deposit_id%type, -- идентификатор договора
                   p_vdat     in oper.vdat%type, -- дата валютирования
                   p_brancha  in varchar2, -- код подразделения-А
                   p_nlsa     in oper.nlsa%type, -- счет-А
                   p_mfoa     in oper.mfoa%type, -- МФО-А
                   p_nama     in oper.nam_a%type, -- наименование-А
                   p_ida      in oper.id_a%type, -- идентиф.код-А
                   p_kva      in oper.kv%type, -- валюта-А
                   p_sa       in oper.s%type, -- сумма-А
                   p_branchb  in varchar2, -- код подразделения-Б
                   p_nlsb     in oper.nlsb%type, -- счет-Б
                   p_mfob     in oper.mfob%type, -- МФО-Б
                   p_namb     in oper.nam_b%type, -- наименование-Б
                   p_idb      in oper.id_b%type, -- идентиф.код-Б
                   p_kvb      in oper.kv2%type, -- валюта-Б
                   p_sb       in oper.s2%type, -- сумма-Б
                   p_nazn     in oper.nazn%type, -- назначение платежа
                   p_nmk      in oper.nam_a%type, -- наименование клиента
                   p_tt       in oper.tt%type, -- код операции
                   p_vob      in oper.vob%type, -- вид документа
                   p_dk       in oper.dk%type, -- признак Д/К
                   p_sk       in oper.sk%type, -- символ касс-плана
                   p_userid   in oper.userid%type, -- код исполнителя
                   p_type     in number, -- тип операции
                   p_mcode    in varchar2 default 'DPT', -- код модуля що викликає процедуру
                   p_ref      out number, -- референс документа
                   p_err_flag out boolean, -- флаг ошибки
                   p_err_msg  out varchar2); -- сообщение об ошибке

  --
  -- Оплата документа на взыскание комиссии безналом
  --
  procedure paydoc_nocash_commission(p_tt          in oper.tt%type, -- код операции
                                     p_dptid       in dpt_deposit.deposit_id%type, -- идентификатор договора
                                     p_main_amount in oper.s%type, -- основная сумма
                                     p_main_curcod in oper.kv%type, -- основная валюта
                                     p_main_docref in oper.ref%type, -- референс первичного документа
                                     p_main_accrec in acc_rec, -- основной счет (параметры)
                                     p_vdate       in oper.vdat%type, -- дата валютирования
                                     p_userid      in oper.userid%type, -- код исполнителя
                                     p_ref         out oper.ref%type, -- референс комиссии
                                     p_amount      in out oper.s%type); -- сумма комиссии

  --
  -- Удаление депозита
  --
  procedure delete_deposit(p_dptid in dpt_deposit_all.deposit_id%type); -- идентификатор договора

  --
  -- Процедура возвращает код и текст последнего вызова процедуры удаления договора.
  -- Возвращаемый код может быть либо 1 - договор удален, либо 0 - создан запрос
  -- на удаления (ожидает подтверждения). Текст соответствует коду сообщения
  --
  procedure get_deldeposit_msg(p_delcode out number, p_delmsg out varchar2);

  --
  -- Установка подтверждения/отказа пользователя на запрос по удалению депозитного договора
  --
  procedure put_deldeal_check(p_reqid    in dpt_requests.req_id%type, -- идентификатор запроса
                              p_reqcheck in dpt_req_deldeals.user_state%type); -- подтверждение/отказ

  --
  -- Обработка запроса на удаление депозита
  --
  procedure process_req_deldeal(p_reqid in dpt_requests.req_id%type); -- идентификатор запроса

  --
  -- Создание запроса указанного типа
  --
  function create_request(p_reqtype in dpt_req_types.reqtype_code%type, -- тип запроса (мнемонический)
                          p_dptid   in dpt_deposit_all.deposit_id%type) -- идентификатор договора
   return dpt_requests.req_id%type;

  --
  -- Вычисление статуса запроса
  --
  function get_request_state(p_reqid in dpt_requests.req_id%type) -- идентификатор запроса
   return dpt_requests.req_state%type;

  --
  -- Установка признака "Обработано" для запроса по бонусным процентным ставкам
  --
  procedure set_bonusreq_state(p_dptid in dpt_bonus_requests.dpt_id%type, -- идентификатор договора
                               p_reqid in dpt_bonus_requests.req_id%type); -- идентификатор запроса

  --
  -- Создание запроса на отмену комиссии
  --
  function create_commis_request(p_dptid    in dpt_deposit_all.deposit_id%type, -- идентификатор договора
                                 p_agrmntid in dpt_vidd_flags.id%type) -- идентификатор доп.соглашения
   return dpt_requests.req_id%type;

  --
  -- Удаление запроса на  отмену комиссии
  --
  procedure delete_commis_request(p_reqid in dpt_requests.req_id%type); -- идентификатор запроса

  --
  -- Функция получения активного запроса по договору
  --
  function get_commisreq_active(p_dptid in dpt_deposit_all.deposit_id%type) -- идентификатор договора
   return dpt_requests.req_id%type;

  procedure put_commis_check(p_reqid    in dpt_requests.req_id%type, -- идентификатор запроса
                             p_reqcheck in dpt_req_deldeals.user_state%type);

  --
  -- Создание запроса на индив. проц. ставку
  --
  function create_chgintdpt_request(p_dptid   in dpt_deposit.deposit_id%type, -- идентификатор договора
                                    p_newint  in number, -- значение новой ставки
                                    p_expdate in date default null) -- гран.дата для заключения доп.соглашения
   return dpt_requests.req_id%type;

  --
  -- Создание запросов на изм. проц. ставки
  --
  function create_chgintvid_request(p_dptvidd  in dpt_vidd.vidd%type, -- код вида договора
                                    p_newbr    in br_normal.br_id%type, -- код базовой ставки
                                    p_begdate  in date, -- дата начала действия новой ставки
                                    p_expdate  in date default null, -- гран.дата для заключения доп.соглашения
                                    p_branch   in branch.branch%type default null, -- подразделение
                                    p_dptdateu in date default null, -- дата начала договора
                                    p_dptdatef in date default null) -- дата окончания договора
   return number;

  --
  -- Удаление запроса на изм. проц.ставки
  --
  procedure delete_chgint_request(p_reqid in dpt_requests.req_id%type); -- идентификатор запроса

  --
  -- Установка признака обработки на запроса по изм. проц.ставки
  --
  procedure set_chgintreq_processed(p_reqid in dpt_requests.req_id%type); -- идентификатор запроса

  --
  -- Регистрация / обновление свидетельств о правах на наследство по договорам  (СПН)
  --
  procedure inherit_registration(p_dptid        in dpt_inheritors.dpt_id%type, -- идентификатор договора
                                 p_inheritor    in dpt_inheritors.inherit_custid%type, -- рег.№ клиента-наследника
                                 p_inheritshare in dpt_inheritors.inherit_share%type, -- доля наследства
                                 p_inheritdate  in dpt_inheritors.inherit_date%type, -- дата вступу в права спадкоємця
                                 p_certifnum    in dpt_inheritors.certif_num%type, -- номер свідоцтва про спадщину
                                 p_certifdate   in dpt_inheritors.certif_date%type -- дата свідоцтва про спадщину
                                 );

  --
  -- Проверка (промежут./окончат) правильности/достаточности заполнения долей наследования
  --
  function inherit_valid_shares(p_dptid in dpt_inheritors.dpt_id%type, -- идентификатор договора
                                p_final in number default 0) -- признак окончания регистрации
   return char;

  -- ======================================================================================
  -- Активация свидетельства о праве на наследство
  -- ======================================================================================
  procedure inherit_activation(p_dptid          in dpt_inheritors.dpt_id%type,
                               p_inherit_custid in dpt_inheritors.inherit_custid%type);
  --
  -- проверка: наследуется ли данный договор
  --
  function inherited_deal(p_dptid in dpt_inheritors.dpt_id%type,
                          p_param in dpt_inheritors.inherit_state%type default 0) -- 0 для перевірки чи по депоз. є зареєстр. спадкоємці
   return char;

  --
  -- расчет допустимого остатка для выплаты наследнику
  --
  function inherit_rest(p_dptid   in dpt_inheritors.dpt_id%type, -- идентификатор договора
                        p_heritor in dpt_inheritors.inherit_custid%type, -- рег.№ клиента-наследника
                        p_accid   in accounts.acc%type) -- внутр.№ счета
   return number;

  --
  -- поиск карт.счета для возврата депозита / выплаты %% (исп. в операциях TM%)
  --
  function get_payoffcardacc(p_payofftype in char,
                             p_debitacc   in accounts.nls%type,
                             p_currency   in accounts.kv%type)
    return varchar2;

  --
  -- расчет ставки по счету на дату (корректная обработка нулевых счетов)
  --
  function get_dptrate(p_dptacc in dpt_deposit.acc%type,
                       p_dptcur in dpt_deposit.kv%type,
                       p_dptsum in dpt_deposit.limit%type,
                       p_date   in date) return number;

  --
  -- процедура расчета и взыскания суммы штрафа при частичном/полном снятии суммы вклада
  --
  procedure global_penalty(p_dptid       in dpt_deposit.deposit_id%type, -- идентификатор договора
                           p_date        in date, -- дата снятия (текущая)
                           p_fullpay     in number, -- 1-расторжение, 0-част.снятие
                           p_amount      in number, -- сумма снятия
                           p_mode        in char, -- режим RO - расчет, RW - взыскание
                           p_penalty     out number, -- сумма штрафа
                           p_commiss     out number, -- сумма комиссии за РКО
                           p_commiss2    out number, -- сумма комиссии за прием ветхих купюр
                           p_dptrest     out number, -- сумма депозита к выплате
                           p_intrest     out number, -- сумма процентов к выплате
                           p_int2pay_ing out number -- shtraf
                           );

  --
  -- процедура расчета и взыскания суммы штрафа при частичном/полном снятии суммы вклада
  --                 с подробным описание расчета штрафа

  procedure global_penalty_ex(p_dptid       in dpt_deposit.deposit_id%type, -- идентификатор договора
                              p_modcode     in bars_supp_modules.mod_code%type, -- код депозитного модуля
                              p_date        in date, -- дата снятия (текущая)
                              p_fullpay     in number, -- 1-расторжение, 0-част.снятие
                              p_amount      in number, -- сумма снятия
                              p_mode        in char, -- режим RO - расчет, RW - взыскание
                              p_penalty     out number, -- сумма штрафа
                              p_commiss     out number, -- сумма комиссии за РКО
                              p_commiss2    out number, -- сумма комиссии за прием ветхих купюр
                              p_dptrest     out number, -- сумма депозита к выплате
                              p_intrest     out number, -- сумма процентов к выплате
                              p_details     out varchar2, -- подробное описание расчета штрафа
                              p_int2pay_ing out number, --
                              p_int2pay_tax out number -- shtraf
                              );

  --
  -- начисление процентов "наперед" по авансовому вкладу
  --
  procedure advance_makeint(p_dptid in dpt_deposit.deposit_id%type); -- идентификатор вклада

  --
  -- расчет граничной даты переоформления и пересмотра ставки в текущем месяце
  --
  function get_extdatex(p_bdate   in date, -- текущая дата
                        p_dptype  in dpt_vidd.vidd%type, -- код вида вклада
                        p_workday in number) -- гран.дата - рабочий день(1)/ любой день(0)
   return date;

  --
  -- создание запроса на отказ вкладчика от переоформления вклада
  --
  procedure fix_extcancel(p_dptid in dpt_extrefusals.dptid%type, -- ідентифікатор вкладу
                          p_state in dpt_extrefusals.req_state%type default null); -- статус запиту

  --
  -- подтверждение запроса на отказ вкладчика от переоформления вклада
  --
  procedure verify_extcancel(p_dptid  in dpt_extrefusals.dptid%type, -- идентификатор вклада
                             p_state  in dpt_extrefusals.req_state%type, -- статус (1=виза, -1=сторно)
                             p_reason in dpt_extrefusals.vrf_reason%type); -- причина сторно

  --
  -- расчет даты выполняения и граничной даты начисления процентов в конце месяца
  --
  procedure get_mnthintdates(p_bnkdate in date, -- текущая банк.дата
                             p_isfixed in char, -- признак срочного вклада (Y-срочный, N-до востреб.)
                             p_valdate out date, -- дата выполнения начисления процентов в конце месяца
                             p_acrdate out date, -- граничная дата начисления процентов в конце месяца
                             p_mode    in number); -- режим запуска функции

  --
  -- расчет суммы процентов к выплате
  --
  procedure get_intpayoff_amount(p_dptid  in dpt_deposit.deposit_id%type, -- идентификатор вклада
                                 p_amount in out number); -- сумма к выплате

  --
  -- урегулирование излишне начисленных и выплаченных процентов по авансовому вкладу
  --
  procedure advance_balsettlement(p_dptid  in dpt_deposit.deposit_id%type, -- идентификатор вклада
                                  p_bdate  in dpt_deposit.dat_end%type, -- банковская дата
                                  p_branch in dpt_deposit.branch%type, -- код подразделения
                                  p_mode   in char, -- режим выполнения (RO/RW)
                                  p_expbal out number, -- сумма к возврату на счет расходов
                                  p_amrbal out number); -- сумма к возврату на счет амортизации

  --
  -- урегулирование начисленных и выплаченных процентов
  -- по авансовым вкладам, срок действия которых истек
  --
  procedure auto_advance_balsettlement(p_branch in dpt_deposit.branch%type, -- код подразделения
                                       p_bdate  in dpt_deposit.dat_begin%type, -- банковская дата
                                       p_dptid  in dpt_deposit.deposit_id%type); -- идентификатор вклада
  --
  -- установка бонуса для пролонгированных вкладов
  --
  procedure auto_extension_bonus(p_dptid  in dpt_jobs_log.dpt_id%type, -- идентификатор договора (0 - все)
                                 p_runid  in dpt_jobs_log.run_id%type, -- № запуска автомат.задания
                                 p_branch in dpt_jobs_log.branch%type, -- код подразделения
                                 p_bdate  in date); -- текущая банковская дата

  --
  -- установка бонуса для 12-кратнопролонгированных вкладов (Правекс)
  --
  procedure set_extbonus12avg(p_extid  in dpt_vidd_extypes.id%type, -- метод переоформления
                              p_dptid  in dpt_jobs_log.dpt_id%type, -- идентификатор вклада
                              p_runid  in dpt_jobs_log.run_id%type, -- код запуска
                              p_branch in dpt_jobs_log.branch%type, -- код подразделения
                              p_bdate  in date, -- банковская дата
                              p_tt     in tts.tt%type, -- код операции для зачисления бонуса
                              p_period in number); -- кол-во мес. для расчета среднего остатка

  --
  -- определение вклада до востребования (возвращает 1 - для текущих и пенсионных вкладов,
  --                                                 0 - для срочных вкладов)
  --
  function is_demandpt(p_dptid in dpt_deposit.deposit_id%type) return number;

  --
  -- установка актуальных значений спецпараметра r013 для счетов по вкладам
  --
  procedure auto_sync_r013(p_bnkdate in date, -- текущая банковская дата
                           p_datend1 in date, -- начальная дата диапазона дат окончания вкладов
                           p_datend2 in date); -- конечная дата диапазона дат окончания вкладов

  --
  -- проверка допустимости возврата суммы вклада и процентов
  --
  function verify_depreturn(p_dptid in dpt_deposit.deposit_id%type, -- идентификатор вклада
                            p_bdate in dpt_deposit.dat_end%type) -- дата возврата вклада и процентов
   return number; -- возврат  разрешен(1)/заблокирован(0)

  --
  --
  --
  function get_bonus_rate(p_dptid dpt_deposit.deposit_id%type) return number;

  /*
  
  --
  -- повертає гріфічну інформацію клієнта
  --
  function GET_CUSTOMER_IMAGE
  ( p_rnk   in   CUSTOMER_IMAGES.rnk%type,
    p_typ   in   CUSTOMER_IMAGES.type_img%type
  ) return       CUSTOMER_IMAGES.image%type;
  
  --
  -- Збереження гріфічної інформації клієнта (Фото/підпис)
  --
  procedure SET_CUSTOMER_IMAGE
  ( p_rnk   in   CUSTOMER_IMAGES.rnk%type,
    p_typ   in   CUSTOMER_IMAGES.type_img%type,
    p_img   in   CUSTOMER_IMAGES.image%type );
  
  ---
  --
  ---
  function GET_VERIFIED_STATE
  ( p_rnk   in   dpt_customer_changes.rnk%type
  ) return number;
  
  ---
  --
  ---
  procedure SET_VERIFIED_STATE
  ( p_rnk    in   person_valid_document.rnk%type,
    p_state  in   person_valid_document.doc_state%type );
  
  --
  -- попередне тимчасове збереження змінених реквізитів клієнта
  --
  procedure PREVIOUS_SAVE_CUSTOMER_PARAMS
  ( p_rnk   in   dpt_customer_changes.rnk%type,
    p_tag   in   dpt_customer_changes.tag%type,
    p_val   in   dpt_customer_changes.val%type );
  
  --
  -- Остаточне збереження змін реквізитів клієнта
  --
  procedure SAVE_CHANGES_CUSTOMER_PARAMS
  ( p_rnk   in   dpt_customer_changes.rnk%type );
  
  ---
  -- Збереження ідентифікатора депозитного договору отриманого від ЕАД
  ---
  procedure SET_ARCHIVE_DOCID
  ( p_dptid  in   dpt_deposit.deposit_id%type,
    p_docid  in   dpt_deposit.archdoc_id%type );
  
  --
  -- Пошук шаблону для друку
  --
  function GET_TEMPLATE
  ( p_dptid  in   dpt_deposit.deposit_id%type,
    p_code   in   dpt_vidd_flags.id%type,
    p_fr     in   doc_scheme.fr%type  default 0
  ) return        dpt_vidd_scheme.id%type;
  
  ---
  -- Перевірка карткового рахунка на "ВІРТУАЛЬНІСТЬ"
  ---
  function CHECK_VIRTUAL_BPK
  ( p_acc     in accounts.acc%type
  ) return       number;
  
  
  */

  ---
  -- формування суми в текстовому вигляді для відправки SMS
  ---
  function amount2str(p_amount in number, p_currency in number)
    return varchar2;

  --
  -- відправка SMS повідомлення
  --
  procedure send_sms(p_rnk in dpt_deposit.rnk%type,
                     p_msg in msg_submit_data.msg_text%type);

  ---
  -- помічаємо тка договору для закриття
  ---
  procedure mark_to_close(p_dptid in dpt_deposit.deposit_id%type);

  -- ======================================================================================
  -- Проверка существования клиента по одновременному совпадению кода ОКПО, номера и серии паспорта - в рамках проекта Эталонный бизнес процесс
  --
  function is_already_client(p_okpo   customer.okpo%type,
                             p_nmk    customer.nmk%type,
                             p_ser    person.ser%type,
                             p_numdoc person.numdoc%type) return number;

  procedure agr_params(p_agr_id in number,
                       p_tag_id in number,
                       p_text   in varchar2);

  -- ======================================================================================
  -- проверка:депозит є заставою по кредиту
  --
  function dpt_is_pawn(p_dptid in dpt_deposit.deposit_id%type)
    return dpt_depositw.value%type;

  -- ======================================================================================
  -- проверка:депозит підпадає під пакет послуг Ексклюзивний(збільшена відсоткова ставка в результаті операції поповнення. Повний перелік видів депозитів,сум та операцій в таблиці dpt_vidd_exclusive)
  --
  procedure dpt_is_exclusive(p_rnk  customer.rnk%type,
                             p_acc  accounts.acc%type,
                             p_tt   acc_balance_changes.tt%type,
                             p_ostc acc_balance_changes.ostc%type,
                             p_kos  acc_balance_changes.kos_delta%type);

  procedure penalty_info(p_dptid     number,
                         p_datbeg    date,
                         p_datend    date,
                         p_int       out number,
                         p_tax       out number,
                         p_taxmil    out number,
                         p_sh_int    out number,
                         p_sh_tax    out number,
                         p_sh_taxmil out number);

  /*
  Функция возвращает набор ДД deposit_id по которым было досрочное расторжение с ненулевым штрафованием после указаннной даты
  */
  function f_get_dptpenalty_set(p_datbeg date, p_dptid number default null)
    return t_depositset;
  /*
  Функция расчитывает штрафные проценты по истории изменения штрафной проц. карточки
  за произвольный период
  для набора досрочно расторгнутых договоров
  */
  function f_penalty_info(p_datbeg date, -- дата начала расчета штрафных %% и налогов
                          p_datend date, -- дата окончания произвольного периода расчета штрафных %% и налогов
                          p_dptid  number default null) -- идентификатор договора/NULL - по портфелю
   return t_penaltyset; -- набор записей договор - сумма штрафных%%, сумма штрафного налога, сумма штрафного военного сбора
  -------------------------------------------------------------
  procedure close_sto_argmnt(p_dptid    in number,
                             p_accid    in number,
                             p_argmntid in number);

  function forbidden_amount(p_acc in accounts.acc%type, p_amount in number)
    return int;

  function check_forbidden_amount(p_acc    in accounts.acc%type,
                                  p_amount in number) return int;

  function check_for_extension(p_dptid in dpt_deposit.deposit_id%type)
    return number;

end dpt_web;
/

show errors;

create or replace package body DPT_WEB
is

  g_body_version  constant varchar2(32)  := 'version 48.11  12.07.2018';
  g_awk_body_defs constant varchar2(512) := 'Сбербанк' || chr(10) ||
                                            'KF - мульти-МФО схема с доступом по филиалам' || chr(10) ||
                                            'MULTIFUNC - расширенный функционал' || chr(10) ||
                                            'HO - обслуживание вклада в выходные и праздничные дни' || chr(10) ||
                                            'EBP - обслуговування вкдадників згідно ЕБП (Ощадбанк)' || chr(10) ||
                                            'SMS - віддправка SMS повідомлень';

  g_modcode            constant varchar2(3) := 'DPT';
  autocommit           constant number := 100;
  deal_deleted         constant number := 1;
  deal_delreq          constant number := 0;
  dptw_commis_reqid    constant char(5) := 'REQCM';
  dptw_commis_reqagrmn constant char(5) := 'REQCI';
  ctrlday_extcncl      constant char(15) := 'CTRLDAY_EXTCNCL';
  g_errmsg_dim         constant number := 3000;
  g_errmsg varchar2(3000);
  g_penaltymsgdim constant number := 3000;
  g_penaltymsg varchar2(3000);
  g_nulldate   date := to_date('01.01.1000', 'DD.MM.YYYY');
  g_dptdelcode number;
  dptop_mainpenalty  constant dpt_op.id%type := 5;
  dptop_bindpenalty  constant dpt_op.id%type := 51;
  dptop_mainwritedwn constant dpt_op.id%type := 8;
  dptop_bindwritedwn constant dpt_op.id%type := 81;
  dptop_avanspenalty constant dpt_op.id%type := 52;
  mainintid          constant int_accn.id%type := 1;
  cardpay_tt         constant tts.tt%type := 'W43'; --was: 'PKB' согласно заявки BRSMAIN-3021 Pavlenko
  -- ошибки
  g_dptnotfound           constant err_codes.err_name%type := 'DPT_NOT_FOUND';
  g_accnotfound           constant err_codes.err_name%type := 'ACC_NOT_FOUND';
  g_custnotfound          constant err_codes.err_name%type := 'CUST_NOT_FOUND';
  g_viddnotfound          constant err_codes.err_name%type := 'VIDD_NOT_FOUND';
  g_trusttermveto         constant err_codes.err_name%type := 'TRUST_TERM_VETO';
  g_agrmttermveto         constant err_codes.err_name%type := 'AGRMT_TERM_VETO';
  g_makeinterror          constant err_codes.err_name%type := 'MAKE_INT_ERROR';
  g_paydocerror           constant err_codes.err_name%type := 'PAYDOC_ERROR';
  request_type_not_found  constant err_codes.err_name%type := 'REQTYPE_NOT_FOUND';
  request_not_found       constant err_codes.err_name%type := 'REQUEST_NOT_FOUND';
  request_processed       constant err_codes.err_name%type := 'REQUEST_PROCESSED';
  dptcreator_not_exists   constant err_codes.err_name%type := 'DPTCREATOR_NOT_EXISTS';
  delete_deal_disallowed  constant err_codes.err_name%type := 'DELETE_DEAL_DISALLOWED';
  request_user_check_put  constant err_codes.err_name%type := 'REQUEST_USER_CHECK_PUT';
  cancel_commis_refused   constant err_codes.err_name%type := 'CANCEL_COMMIS_REFUSED';
  commission_doc_required constant err_codes.err_name%type := 'REQUIRED_COMMISSDOC';
  g_accountdebitdenied    constant err_codes.err_name%type := 'ACCOUNT_DEBIT_DENIED';
  g_jobrunidnotfound      constant err_codes.err_name%type := 'JOB_RUNID_NOT_FOUND';

  g_proc_deprecated constant err_codes.err_name%type := 'PROCEDURE_DEPRECATED';

  g_tax_mode number := nvl(to_number(getglobaloption('TAX_METHOD')), 3);

  -- используется в процедурах штрафования при част./полном снятии суммы вклада
  type t_turnrec is record(
    accid     saldoa.acc%type, -- внутр.номер счета
    currdat   saldoa.fdat%type, -- дата измеения остатка
    prevdat   saldoa.pdat%type, -- дата предыдущего движения
    saldo     saldoa.ostf%type, -- входящий остаток
    debit     saldoa.dos%type, -- сумма списаний за день
    credit    saldoa.kos%type, -- сумма зачислений за день
    rest      saldoa.ostf%type, -- вход.ост минус все последующие списания
    rest2pay  saldoa.ostf%type, -- сумма для начисления и выплаты по ставке ЧС
    rest2take saldoa.ostf%type, -- сумма для взыскания штрафа по обычной ставке
    intdat1   date, -- конечная дата предыдущего начисления %%
    intdat2   date, -- конечная дата текущего начисления по штрафной ставке
    intdat3   date); -- конечная дата текущего начисления по обычной ставке
  type t_turndata is table of t_turnrec;

  -- используются в процедурах автомат.переоформления депозитных договоров
  type t_dptextdata is record(
    dptid    dpt_deposit.deposit_id%type,
    dptnum   dpt_deposit.nd%type,
    dptdat   dpt_deposit.datz%type,
    dptype   dpt_deposit.vidd%type,
    cntdubl  dpt_deposit.cnt_dubl%type,
    datbeg   dpt_deposit.dat_begin%type,
    datend   dpt_deposit.dat_end%type,
    custid   customer.rnk%type,
    custcode customer.okpo%type,
    custname customer.nmk%type,
    custved  customer.ved%type,
    custise  customer.ise%type,
    custrzd  rezid.rezid%type,
    dptacc   accounts.acc%type,
    dptmfo   accounts.kf%type,
    dptnls   accounts.nls%type,
    dptcur   accounts.kv%type,
    dptnam   accounts.nms%type,
    dptsum   accounts.ostc%type,
    intacc   accounts.acc%type,
    intmfo   accounts.kf%type,
    intnls   accounts.nls%type,
    intcur   accounts.kv%type,
    intnam   accounts.nms%type,
    intsum   accounts.ostc%type,
    rate     int_ratn.ir%type,
    opened   accounts.daos%type,
    errcode  number(1));
  type t_dptextrec is record(
    dptid   dpt_deposit.deposit_id%type,
    dptnum  dpt_deposit.nd%type,
    dptdat  dpt_deposit.datz%type,
    comproc dpt_vidd.comproc%type,
    extflag number(1),
    extcond dpt_vidd_extypes.ext_condition%type);
  type t_dptextlist is table of t_dptextrec;

  type t_tax_settings is record(
    tax_type       number,
    tax_int        number, -- % налога;
    tax_date_begin date, -- начало действия периода налогообложения;
    tax_date_end   date -- конец  действия периода налогообложения пост 4110; если дата конца действия постановы не установлена, то принимаем, +1 месяц от сегодня
    );
  type t_taxdata is table of t_tax_settings;
  --
  -- начисление процентов
  --
  int_statement long;
  --
  -- процедура генерации sql-выражения для начисления процентов в различных режимах
  --
  procedure igen_intstatement(p_method    in number,
                              p_dptid     in number,
                              p_statement out long) is
    title varchar2(60) := 'dptweb.igenintstmt:';
    nlchr constant char(2) := chr(13) || chr(10);
    l_subquery varchar2(4000);
    l_clause   varchar2(4000);
  begin

    bars_audit.trace('%s entry, p_method=>%s, p_dptid=>%s',
                     title,
                     to_char(p_method),
                     to_char(p_dptid));

    l_subquery := '(select deposit_id, nd, datz, rnk, acc, vidd, branch ' ||
                  nlchr || '   from dpt_deposit ' || nlchr || case
                    when p_method = 10 then
                     '' -- безусловно по всем депозитам
                    else
                     case
                       when p_method = 0 then
                        '  where branch = :p_branch ' || nlchr
                       when p_method = 1 then
                        '  where dat_end is not null  and branch = :p_branch ' || nlchr
                       when p_method = 2 then
                        '  where dat_end is null and branch = :p_branch ' || nlchr
                       when p_method = 9 then
                        '  where dat_end is not null and dat_end between :p_dat1 and :p_dat2 ' || nlchr
                       when p_method = 11 then
                        '  where branch like :p_branch ' || nlchr
                     end || case
                       when p_method != 0 then
                        '    and rownum <= rownum + 1 ' || nlchr
                     end || case
                       when p_dptid > 0 then
                        '    and deposit_id = :p_dptid ' || nlchr
                     end
                  end || ')' || nlchr;

    l_clause := case
                  when p_method = 9 then
                   '   and d.branch = :p_branch ' || nlchr
                  else
                   ' '
                end;

    p_statement := 'insert into int_queue ' || nlchr ||
                   '   (kf, branch, deal_id, deal_num, deal_dat, cust_id, int_id, ' ||
                   nlchr ||
                   '    acc_id, acc_num, acc_cur, acc_nbs, acc_name, acc_iso, ' ||
                   nlchr ||
                   '    acc_open, acc_amount, int_details, int_tt, mod_code) ' ||
                   nlchr || 'select ' || nlchr || case
                     when p_method = 10 then
                      ''
                     else
                      '/*+ ORDERED INDEX(a) INDEX(i)*/ ' || nlchr
                   end ||
                   '       a.kf, a.branch, d.deposit_id, d.nd, d.datz, d.rnk, i.id, ' ||
                   nlchr ||
                   '       a.acc, a.nls, a.kv, a.nbs, substr(a.nms, 1, 38), t.lcv, ' ||
                   nlchr ||
                   '       a.daos, null, null, nvl(i.tt, ''%%1''), ''DPT'' ' ||
                   nlchr || '  from ' || l_subquery || ' d, ' || nlchr ||
                   '       accounts   a, ' || nlchr ||
                   '       int_accn   i, ' || nlchr ||
                   '       tabval$global t, ' || nlchr ||
                   '       dpt_vidd   v  ' || nlchr ||
                   ' where d.acc        = a.acc ' || nlchr ||
                   '   and d.acc        = i.acc ' || nlchr ||
                   '   and i.id         in (1, decode(v.amr_metr, 0, 1, 3)) ' ||
                   nlchr || '   and a.kv         = t.kv ' || nlchr ||
                   '   and d.vidd       = v.vidd ' || nlchr
                  -- відсікаєм вклади "до запитання"
                   || '   and v.vidd not in (103, 104, 106, 107, 108, 300) ' ||
                   nlchr || '   and (   (i.acr_dat is null) ' || nlchr ||
                   '        or (i.acr_dat < :p_acrdat and i.stp_dat is null) ' ||
                   nlchr ||
                   '        or (i.acr_dat < :p_acrdat and i.stp_dat > i.acr_dat)) ' ||
                   nlchr || l_clause || ' union all ' || nlchr || 'select ' ||
                   nlchr || case
                     when p_method = 10 then
                      ''
                     else
                      '/*+ ORDERED INDEX(a) INDEX(i)*/ ' || nlchr
                   end ||
                   '       b.kf, b.branch, d.deposit_id, d.nd, d.datz, d.rnk, m.id, ' ||
                   nlchr ||
                   '       b.acc, b.nls, b.kv, b.nbs, substr(b.nms, 1, 38), t.lcv, ' ||
                   nlchr ||
                   '       b.daos, null, null, nvl(m.tt, ''%%1''), ''DPT'' ' ||
                   nlchr || '  from ' || l_subquery || ' d, ' || nlchr ||
                   '       int_accn    i, ' || nlchr ||
                   '       accounts    b, ' || nlchr ||
                   '       int_accn    m, ' || nlchr ||
                   '       tabval$global t, ' || nlchr ||
                   '       dpt_vidd    v  ' || nlchr ||
                   ' where d.acc       = i.acc ' || nlchr ||
                   '   and i.id        = 1     ' || nlchr ||
                   '   and i.acrb      = b.acc ' || nlchr ||
                   '   and b.acc       = m.acc ' || nlchr ||
                   '   and m.id        = 0     ' || nlchr ||
                   '   and b.kv        = t.kv  ' || nlchr ||
                   '   and v.amr_metr  = 4     ' || nlchr ||
                   '   and d.vidd      = v.vidd ' || nlchr ||
                   '   and ((m.acr_dat is null) or (m.acr_dat < :p_acrdat and m.acr_dat < m.stp_dat)) ' ||
                   nlchr || l_clause;

    bars_audit.trace('%s exit with %s', title, p_statement);

  end igen_intstatement;
  -- ======================================================================================
  --                        Служебные функции
  -- ======================================================================================
  function header_version return varchar2 is
  begin
    return 'Package header DPT_WEB ' || g_header_version || '.' || chr(10) || 'AWK definition: ' || chr(10) || g_awk_header_defs;
  end header_version;

  function body_version return varchar2 is
  begin
    return 'Package body   DPT_WEB ' || g_body_version || '.' || chr(10) || 'AWK definition: ' || chr(10) || g_awk_body_defs;
  end body_version;
  -- ======================================================================================
  procedure p_search_customer(p_okpo   in customer.okpo%type,
                              p_nmk    in customer.nmk%type,
                              p_bday   in person.bday%type,
                              p_ser    in person.ser%type,
                              p_numdoc in person.numdoc%type,
                              p_cust   out t_cursor) is
    l_title  varchar2(60) := 'dpt_web.p_search_customer: ';
    l_enough number(1);
    t_cust   t_cursor;
    l_branch branch.branch%type := sys_context('bars_context',
                                               'user_branch');
    l_nmk    customer.nmk%type := '%';
    nlchr constant char(2) := chr(13) || chr(10);
    l_subquery varchar2(4000);
    l_clause   varchar2(4000) := '';
  begin

    bars_audit.trace('%s ид.код = %s, ФИО = %s, ДР = %s, серия и № паспорта = %s %s',
                     l_title,
                     p_okpo,
                     p_nmk,
                     to_char(p_bday, 'DD/MM/YYYY'),
                     p_ser,
                     p_numdoc);

    -- проверка достаточности входных параметров для поиска вкладчика
    l_enough := enough_search_params(p_dptid     => null,
                                     p_dptnum    => null,
                                     p_custid    => null,
                                     p_accnum    => null,
                                     p_custname  => p_nmk,
                                     p_custcode  => p_okpo,
                                     p_birthdate => p_bday,
                                     p_docserial => p_ser,
                                     p_docnum    => p_numdoc);

    if (p_nmk is not null) then
      l_nmk := upper(p_nmk) || l_nmk;
    end if;

    if p_okpo is not null and p_okpo != '0000000000' then
      l_subquery := 'SELECT /*+ FIRST_ROWS(10) */
           c.rnk, c.nmk, c.okpo, c.adr,
           (select s.name from passp s where passp = (select passp from person where rnk = c.rnk)) name,
           (select ser from person where rnk = c.rnk) ser,
           (select numdoc from person where rnk = c.rnk) numdoc,
           c.branch
      FROM customer c
     WHERE c.okpo = :p_okpo
       AND canilookclient(c.rnk) = 1
       AND c.date_off IS NULL';
      bars_audit.info(l_subquery);
      open t_cust for l_subquery
        using p_okpo;
    else
      l_subquery := 'select * from (' ||
                    'SELECT /*+ FIRST_ROWS(10) */
           c.rnk, c.nmk, c.okpo, c.adr, s.name, p.ser, p.numdoc, c.branch
      FROM customer c, person p, passp s
     WHERE c.rnk   = p.rnk
       AND p.passp = s.passp
       AND c.date_off IS NULL
       AND NVL(TRIM(c.sed), ''00'') != ''91'' ';
      if l_nmk is not null then
        l_clause := ' AND UPPER(c.nmk) LIKE :l_nmk ' || nlchr;
      end if;

      if p_okpo is not null then
        l_clause := l_clause || ' AND c.okpo = :p_okpo ' || nlchr;
      else
        l_clause := l_clause || ' and :p_okpo is null ' || nlchr;
      end if;

      if p_bday is not null then
        l_clause := l_clause || ' AND NVL(p.bday, to_date(''' ||
                    to_char(g_nulldate, 'dd/mm/yyyy') ||
                    ''',''dd/mm/yyyy'')) = :p_bday ' || nlchr;
      else
        l_clause := l_clause || ' and :p_bday is null ' || nlchr;
      end if;

      if p_ser is not null then
        l_clause := l_clause || ' AND NVL(p.ser,'' '') = :p_ser ' || nlchr;
      else
        l_clause := l_clause || ' and :p_ser is null  ' || nlchr;
      end if;

      if p_numdoc is not null then
        l_clause := l_clause || ' AND NVL(p.numdoc, '' '') = :p_numdoc ' ||
                    nlchr;
      else
        l_clause := l_clause || ' and :p_numdoc is null ' || nlchr;
      end if;
      l_clause   := l_clause || ' ) where canilookclient(rnk) = 1';
      l_subquery := l_subquery || l_clause;

      if l_nmk is not null then
        open t_cust for l_subquery
          using l_nmk, p_okpo, p_bday, p_ser, p_numdoc;
      else
        open t_cust for l_subquery
          using p_okpo, p_bday, p_ser, p_numdoc;
      end if;
    end if;
    bars_audit.info(l_subquery);

    p_cust := t_cust;
    bars_audit.trace('%s выход', l_title);

  end p_search_customer;
  -- ======================================================================================
  procedure p_close_cursor(p_cust in out t_cursor) is
  begin
    close p_cust;
  end p_close_cursor;
  -- ======================================================================================
  function enough_search_params(p_dptid     dpt_deposit.deposit_id%type,
                                p_dptnum    dpt_deposit.nd%type,
                                p_custid    dpt_deposit.rnk%type,
                                p_accnum    accounts.nls%type,
                                p_custname  customer.nmk%type,
                                p_custcode  customer.okpo%type,
                                p_birthdate person.bday%type,
                                p_docserial person.ser%type,
                                p_docnum    person.numdoc%type,
                                p_extended  number default null)
    return number is
    l_title varchar2(60) := 'dpt_web.enough_search_params: ';
    ------------------
    function valid_custcode(l_code customer.okpo%type) return number is
      l_valid number(1);
    begin
      l_valid := case
                   when (l_code is not null and length(l_code) = 10 and
                        l_code not like '00000%') then
                    1
                   else
                    0
                 end;
      bars_audit.trace('%s valid_custcode(%s) = %s',
                       l_title,
                       l_code,
                       to_char(l_valid));
      return l_valid;
    end valid_custcode;
    ------------------
    function valid_docparams(l_serial person.ser%type,
                             l_number person.numdoc%type) return number is
    begin
      return case when(l_serial is not null and l_number is not null) then 1 else 0 end;
    end valid_docparams;
  begin

    bars_audit.trace('%s договор № %s (%s), счет %s',
                     l_title,
                     p_dptnum,
                     to_char(p_dptid),
                     p_accnum);
    bars_audit.trace('%s клиент № %s - %s, идентиф.код = %s',
                     l_title,
                     to_char(p_custid),
                     p_custname,
                     p_custcode);
    bars_audit.trace('%s паспорт %s %s, дата рождения = %s',
                     l_title,
                     p_docserial,
                     p_docnum,
                     to_char(p_birthdate, 'DD/MM/YY'));

    if p_extended is null then
      -- спрощена система перевірок достатньості параметрів для пошуку клиєнта/договору
      if coalesce(to_char(p_dptid),
                  p_dptnum,
                  p_accnum,
                  to_char(p_custid),
                  p_custname,
                  p_custcode,
                  to_char(p_birthdate),
                  p_docserial,
                  p_docnum,
                  'null') = 'null' then
        -- Задана недостаточное количество параметров для поиска договора.
        -- Конкретизируйте условия поиска!
        bars_error.raise_nerror(g_modcode, 'NOT_ENOUGH_PARAMS');
      else
        return 1;
      end if;
    else
      -- Ускладнена перевірка достатньості параметрів для пошуку клиєнта/договору
      if coalesce(to_char(p_dptid), p_dptnum, p_accnum, 'null') = 'null' or
         coalesce(to_char(p_birthdate),
                  p_custcode,
                  p_docserial,
                  p_docnum,
                  'null') = 'null' or nvl(p_custname, 'null') = 'null' then
        -- Вказано недостатня кількість параметрів для пошуку договору
        -- Уточніть умови пошуку!
        bars_error.raise_nerror(g_modcode, 'NOT_ENOUGH_PARAMS');
      else
        return 1;
      end if;
    end if;
  end enough_search_params;
  -- ======================================================================================
  function get_custdata(p_type      in number, -- тип поиска
                        p_custid    in customer.rnk%type default null, -- рег.номер
                        p_custcode  in customer.okpo%type default null, -- идентиф.код
                        p_custname  in customer.nmk%type default null, -- ФИО
                        p_bdate     in person.bday%type default null, -- дата рождения
                        p_docserial in person.ser%type default null, -- серия паспорта
                        p_docnumber in person.numdoc%type default null) -- номер паспорта
   return customer%rowtype is
    l_num      number;
    l_custrow  customer%rowtype;
    l_custname customer.nmk%type := upper(p_custname);
    l_branch   branch.branch%type := sys_context('bars_context',
                                                 'user_branch');
  begin

    if p_type = 1 then
      -- поиск клиента по регистрационному номеру
      select *
        into l_custrow
        from customer
       where date_off is null
         and custtype = 3
         and nvl(trim(sed), '00') != '91'
         and rnk = p_custid;
    elsif p_type = 2 then
      -- поиск клиента по идентиф.коду и ФИО
      select *
        into l_custrow
        from customer
       where date_off is null
         and custtype = 3
         and nvl(trim(sed), '00') != '91'
            -- пока проверяем на полное совпадение
            -- в будущем переписать и вернуть алгоритм на 90 % совпадение
         and upper(nmk) = l_custname
         and okpo = p_custcode;
    elsif p_type = 3 then
      -- поиск клиента по идентиф.коду, ФИО и паспортным данным
      select c.*
        into l_custrow
        from customer c, person p
       where c.date_off is null
         and c.custtype = 3
         and nvl(trim(c.sed), '00') != '91'
         and c.rnk = p.rnk
            -- пока проверяем на полное совпадение
            -- в будущем переписать и вернуть алгоритм на 90 % совпадение
         and upper(nmk) = l_custname
         and c.okpo = p_custcode
         and p.bday = p_bdate
         and p.ser = p_docserial
         and p.numdoc = p_docnumber;
    elsif p_type = 4 then
      -- поиск клиента по идентиф.коду, если он не 0000000000 и не 9999999999 -- BRSMAIN-2294 (для миграции из АСВО) Павленко 20/10/2014
      select c.*
        into l_custrow
        from customer c, person p
       where c.date_off is null
         and c.custtype = 3
         and nvl(trim(c.sed), '00') != '91'
         and c.rnk = p.rnk
         and c.okpo = p_custcode;
    else
      null;
    end if;

    return l_custrow;

  end get_custdata;
  -- ======================================================================================
  -- расширенный поиск клиента
  function get_custdata_ex(p_custid    in customer.rnk%type, -- рег.номер
                           p_custcode  in customer.okpo%type, -- идентиф.код
                           p_custname  in customer.nmk%type, -- ФИО
                           p_bdate     in person.bday%type, -- дата рождения
                           p_docserial in person.ser%type, -- серия паспорта
                           p_docnumber in person.numdoc%type, -- номер паспорта
                           p_mode      in varchar2 default null)
    return customer%rowtype is
    title      constant varchar2(60) := 'dptweb.getcustdata:';
    l_nullcode constant customer.okpo%type := '000000000'; -- ид.код не известен / не присвоен
    l_custrow  customer%rowtype;
    l_complete boolean := false;
  begin

    bars_audit.trace('%s entry, (%s, %s, %s, %s, %s, %s)',
                     title,
                     to_char(p_custid),
                     p_custcode,
                     p_custname,
                     to_char(p_bdate, 'dd.mm.yyyy'),
                     p_docserial,
                     p_docnumber);

    -- попытка № 1: поиск клиента по РНК
    begin
      l_custrow  := get_custdata(p_type => 1, p_custid => p_custid);
      l_complete := true;
      bars_audit.trace('%s customer is found by CUSTID', title);
    exception
      when no_data_found then
        l_custrow  := null;
        l_complete := false;
    end;

    -- попытка № 2: поиск клиента по идентиф.коду (не 0...000) и ФИО (90%-ное совпадение)
    if not l_complete and p_custcode != l_nullcode then
      begin
        l_custrow  := get_custdata(p_type     => 2,
                                   p_custcode => p_custcode,
                                   p_custname => p_custname);
        l_complete := true;
        bars_audit.trace('%s customer is found by CUSTCODE + 0.9*NAME',
                         title);
      exception
        when no_data_found then
          l_custrow  := null;
          l_complete := false;
          bars_audit.trace('%s customer not found by CUSTCODE + 0.9*NAME',
                           title);
        when too_many_rows then
          l_custrow  := null;
          l_complete := false;
      end;
    end if;

    -- попытка № 3: расширенный поиск клиента по ид.коду, ФИО и пасп.данным
    if not l_complete then
      begin
        l_custrow  := get_custdata(p_type      => 3,
                                   p_custcode  => p_custcode,
                                   p_custname  => p_custname,
                                   p_bdate     => p_bdate,
                                   p_docserial => p_docserial,
                                   p_docnumber => p_docnumber);
        l_complete := true;
        bars_audit.trace('%s customer is found by CUSTCODE + 0.9*NAME + DOCs',
                         title);
      exception
        when no_data_found then
          l_custrow  := null;
          l_complete := false;
          bars_audit.trace('%s customer not found by CUSTCODE + 0.9*NAME + DOCs',
                           title);
        when too_many_rows then
          l_custrow  := null;
          l_complete := false;
          bars_audit.trace('%s too many customers found by CUSTCODE + 0.9*NAME + DOCs',
                           title);
      end;
    end if;
    -- попытка № 4: поиск клиента по идентиф.коду (не 0...000) для миграции по АСВО
    if not l_complete and p_custcode != l_nullcode and
       p_custcode != '9999999999' and p_mode = 'MI' then
      begin
        l_custrow  := get_custdata(p_type => 4, p_custcode => p_custcode);
        l_complete := true;
        bars_audit.trace('%s customer is found by INN', title);
      exception
        when no_data_found then
          l_custrow  := null;
          l_complete := false;
          bars_audit.trace('%s customer not found by INN', title);
        when too_many_rows then
          l_custrow  := null;
          l_complete := false;
      end;
    end if;
    bars_audit.trace('%s exit with customer № %s - %s',
                     title,
                     to_char(l_custrow.rnk),
                     l_custrow.nmk);

    return l_custrow;

  end get_custdata_ex;
  -- ======================================================================================
  --
  -- Регистрация нового клиента-вкладчика/обновление карточки существующего клиента
  --
  procedure p_open_vklad_rnk(p_clientname       in customer.nmk%type, -- ФИО клиента
                             p_client_name      in customer.nmk%type default null, -- имя
                             p_client_surname   in customer.nmk%type default null, -- фамилия
                             p_client_patr      in customer.nmk%type default null, -- отчество
                             p_country          in customer.country%type default null, -- код страны (гражданство)
                             p_index            in customer.adr%type default null, -- почтовый индекс      |
                             p_obl              in customer.adr%type default null, -- область              |
                             p_district         in customer.adr%type default null, -- район                | адрес регистрации
                             p_settlement       in customer.adr%type default null, -- населенный пункт     |
                             p_adress           in customer.adr%type default null, -- улица, дом, квартира |
                             p_fulladdress      in customer.adr%type default null, -- полный адрес регистрации
                             p_territory        in number default null, -- код території адреса регистрации
                             p_clientcodetype   in customer.tgr%type default 2, -- тип реестра
                             p_clientcode       in customer.okpo%type, -- идентификационный код
                             p_doctype          in person.passp%type default 1, -- тип документа
                             p_docserial        in person.ser%type default null, -- серия док-та
                             p_docnumber        in person.numdoc%type default null, -- номер док-та
                             p_docorg           in person.organ%type default null, -- организация, выдавшая документ
                             p_docdate          in person.pdate%type default null, -- дата выдачи док-та
                             p_photodate        in person.date_photo%type default null, -- Дата коли була вклеєна остання фотографія у паспорт
                             p_clientbdate      in person.bday%type default null, -- дата рождения
                             p_clientbplace     in person.bplace%type default null, -- место рождения
                             p_clientsex        in person.sex%type default null, -- пол
                             p_special_marks    in cust_mark_types.mark_code%type default null, -- код спеціальної відмітки клієнта
                             p_clientcellphone  in person.teld%type default null, -- моб.телефон
                             p_clienthomeph     in person.teld%type default null, -- дом.телефон
                             p_clientworkph     in person.telw%type default null, -- раб.телефон
                             p_clientname_gc    in customer.nmk%type default null, -- ФИО клиента в родит.падеже
                             p_resid_code       in number default 1, -- признак инсайдера  (1-инсайдер, 0 нет)
                             p_resid_index      in customer.adr%type default null, -- почтовый индекс      |
                             p_resid_obl        in customer.adr%type default null, -- область              |
                             p_resid_district   in customer.adr%type default null, -- район                | фактический адрес
                             p_resid_settlement in customer.adr%type default null, -- населенный пункт     |
                             p_resid_adress     in customer.adr%type default null, -- улица, дом, квартира |
                             p_resid_territory  in number default null, -- код території фактического адреса
                             p_clientid         in out customer.rnk%type, -- регистрационный № клиента
                             p_selfemployer     in number default null, -- ознака самозайнятої особи
                             p_taxagencycode    in customer.c_reg%type default null, -- Код ДПА
                             p_regagencycode    in customer.c_dst%type default null, -- Код органу реєстрації
                             p_registrydate     in customer.date_on%type default null, -- дата регистрации клиента
                             p_usagemode        in varchar2 default 'IU' -- режим выполнения процедуры
                             ) is
    --
    -- режим  с  регистрацией карточки нового     клиента (IO / IU)
    -- режим без регистрации  карточки нового     клиента (SO / UO)
    -- режим  с  обновлением  карточки найденного клиента (UO / IU)
    -- режим без обновления   карточки найденного клиента (SO / IO)
    -- режим поиска клиента только по ОКПО (BRSMAIN-2294 для миграции) (MI)
    --
    l_title         varchar2(60) := 'dpt_web.p_open_vklad_rnk: ';
    l_parname       params.par%type := 'KOD_G';
    l_ourcountry    number(38);
    l_residcode     customer.codcagent%type;
    l_custtype      customer.custtype%type;
    l_prinsider     customer.prinsider%type;
    l_ise           customer.ise%type;
    l_fs            customer.fs%type;
    l_oe            customer.oe%type;
    l_ved           customer.ved%type;
    l_sed           customer.sed%type;
    l_k050          customer.k050%type;
    l_custrow       customer%rowtype;
    l_persrow       person%rowtype;
    l_addrrow       customer_address%rowtype;
    l_custnameshurt customer.nmkk%type;
    l_cust          number(38);
    l_custadrtype   number(38);
  begin

    bars_audit.trace('%s запуск, ФИО=>%s, РНК=>%s, ид.код=>%s, паспорт=>%s, дата рождения=>%s',
                     l_title,
                     p_clientname,
                     to_char(p_clientid),
                     p_clientcode,
                     p_docserial || '/' || p_docnumber,
                     to_char(p_clientbdate, 'DD/MM/YY'));

    bars_audit.trace('%s PhotoDate = %s',
                     l_title,
                     to_char(p_photodate, 'DD/MM/YYYY'));

    bars_audit.trace('%s SelfEmployer => %s, c_reg => %s, c_dst => %s',
                     l_title,
                     to_char(p_selfemployer),
                     to_char(p_taxagencycode),
                     to_char(p_regagencycode));

    bars_audit.trace('%s режим выполнения - %s',
                     l_title,
                     p_usagemode);

    -- код нашей страны
    begin
      select to_number(val)
        into l_ourcountry
        from params
       where par = l_parname;
    exception
      when no_data_found then
        bars_error.raise_nerror(g_modcode, 'COUNTRY_NOT_FOUND');
    end;

    -- заполнение альтернативного адреса (p_resid_*) в фактический дарес
    l_custadrtype := 2;

    -- эконом.показатели
    l_residcode := case
                     when p_resid_code = 1 then
                      5
                     else
                      6
                   end;
    l_custtype  := 3;
    l_prinsider := 99;

    l_ise := case
               when p_resid_code = 1 then
                '14410'
               else
                '20000'
             end;
    l_fs   := '10';
    l_oe   := '00000';
    l_ved  := '00000';
    l_sed  := '00';
    l_k050 := '000';

    -- краткое наименование клиента
    l_custnameshurt := substr(p_client_surname, 1, 38);
    if trim(p_client_name) is not null then
      l_custnameshurt := substr(p_client_surname || ' ' ||
                                upper(substr(p_client_name, 1, 1)) || '.',
                                1,
                                38);
      if p_client_patr is not null then
        l_custnameshurt := substr(l_custnameshurt ||
                                  upper(substr(p_client_patr, 1, 1)) || '.',
                                  1,
                                  38);
      end if;
    end if;

    bars_audit.trace('%s краткое наименование = %s',
                     l_title,
                     l_custnameshurt);

    l_custrow := null;
    l_persrow := null;

    -- поиск клиента по рег.номеру, ид.коду, ФИО и пасп.данным
    l_custrow := get_custdata_ex(p_custid    => p_clientid, -- рег.номер
                                 p_custcode  => p_clientcode, -- идентиф.код
                                 p_custname  => p_clientname, -- ФИО
                                 p_bdate     => p_clientbdate, -- дата рождения
                                 p_docserial => p_docserial, -- серия паспорта
                                 p_docnumber => p_docnumber, -- номер паспорта
                                 p_mode      => p_usagemode); -- режим для поиска 'MI ' только по коду ОКПО

    if (l_custrow.rnk is null) then

      -- режим с регистрацией нового клиента (IO / IU)
      if (p_usagemode = 'IO' or p_usagemode = 'IU' or p_usagemode = 'MI') then
        bars_audit.trace('%s клиент не найден, режим %s => регистрируем нового клиента',
                         l_title,
                         p_usagemode);

        -- заполнение карточки клиента
        kl.setcustomerattr(rnk_       => l_cust,
                           custtype_  => l_custtype,
                           nd_        => null,
                           nmk_       => substr(p_clientname, 1, 70),
                           nmkv_      => substr(f_translate_kmu(p_clientname),
                                                1,
                                                70),
                           nmkk_      => substr(l_custnameshurt, 1, 35),
                           adr_       => substr(p_fulladdress, 1, 70),
                           codcagent_ => l_residcode,
                           country_   => nvl(p_country, l_ourcountry),
                           prinsider_ => l_prinsider,
                           tgr_       => p_clientcodetype,
                           okpo_      => substr(p_clientcode, 1, 14),
                           stmt_      => null,
                           sab_       => null,
                           dateon_    => nvl(p_registrydate, gl.bdate),
                           taxf_      => null,
                           creg_      => (case
                                           when p_selfemployer = 1 then
                                            p_taxagencycode
                                           else
                                            null
                                         end),
                           cdst_      => (case
                                           when p_selfemployer = 1 then
                                            p_regagencycode
                                           else
                                            null
                                         end),
                           adm_       => null,
                           rgtax_     => null,
                           rgadm_     => null,
                           datet_     => null,
                           datea_     => null,
                           ise_       => l_ise,
                           fs_        => l_fs,
                           oe_        => l_oe,
                           ved_       => l_ved,
                           sed_       => l_sed,
                           notes_     => null,
                           notesec_   => null,
                           crisk_     => 1,
                           pincode_   => null,
                           rnkp_      => null,
                           lim_       => null,
                           nompdv_    => null,
                           mb_        => null,
                           bc_        => case
                                           when (p_clientcode is null) then
                                            1
                                           else
                                            0
                                         end,
                           tobo_      => substr(tobopack.gettobo, 1, 30),
                           isp_       => null);

        -- заполнение карточки клиента-физ.лица
        kl.setpersonattrex(rnk_    => l_cust,
                           sex_    => p_clientsex,
                           passp_  => p_doctype,
                           ser_    => substr(p_docserial, 1, 10),
                           numdoc_ => substr(p_docnumber, 1, 20),
                           pdate_  => p_docdate,
                           organ_  => substr(p_docorg, 1, 50),
                           fdate_  => p_photodate,
                           bday_   => p_clientbdate,
                           bplace_ => substr(p_clientbplace, 1, 70),
                           teld_   => substr(p_clienthomeph, 1, 20),
                           telw_   => substr(p_clientworkph, 1, 20),
                           telm_   => p_clientcellphone);

        -- заполнение доп.реквизитов клиента
        kl.setcustomerelement(l_cust,
                              'SN_FN',
                              substr(p_client_name, 1, 500),
                              0);
        kl.setcustomerelement(l_cust,
                              'SN_LN',
                              substr(p_client_surname, 1, 500),
                              0);
        kl.setcustomerelement(l_cust,
                              'SN_MN',
                              substr(p_client_patr, 1, 500),
                              0);
        kl.setcustomerelement(l_cust,
                              'SN_GC',
                              substr(p_clientname_gc, 1, 500),
                              0);
        kl.setcustomerelement(l_cust, 'K013', '5', 0);

        if (branch_usr.get_branch_param2('DPT_WORKSCHEME', 1) = 'EBP') then
          -- код модуля реєстрації клієнта для ЕБП
          kl.setcustomerelement(l_cust, 'CRSRC', 'DPT', 0);
        end if;

        kl.setcustomerelement(l_cust, 'SAMZ', to_char(p_selfemployer), 0); -- Ознака самозайнятої особи
        kl.setcustomerelement(l_cust, 'SPMRK', to_char(p_special_marks), 0); -- "Особлива Вiдмiтка" нестандартного клієнта

        -- заповнення юридичної адреси
        kl.setcustomeraddressbyterritory(rnk_         => l_cust,
                                         typeid_      => 1,
                                         country_     => nvl(p_country,
                                                             l_ourcountry),
                                         zip_         => substr(p_index,
                                                                1,
                                                                5),
                                         domain_      => substr(p_obl, 1, 30),
                                         region_      => substr(p_district,
                                                                1,
                                                                30),
                                         locality_    => substr(p_settlement,
                                                                1,
                                                                30),
                                         address_     => substr(p_adress,
                                                                1,
                                                                100),
                                         territoryid_ => p_territory);

        -- заповнення фактичної адреси
        if (coalesce(p_resid_index,
                     p_resid_obl,
                     p_resid_district,
                     p_resid_settlement,
                     p_resid_adress,
                     to_char(p_resid_territory)) is not null) then
          kl.setcustomeraddressbyterritory(rnk_         => l_cust,
                                           typeid_      => l_custadrtype,
                                           country_     => nvl(p_country,
                                                               l_ourcountry),
                                           zip_         => substr(p_resid_index,
                                                                  1,
                                                                  5),
                                           domain_      => substr(p_resid_obl,
                                                                  1,
                                                                  30),
                                           region_      => substr(p_resid_district,
                                                                  1,
                                                                  30),
                                           locality_    => substr(p_resid_settlement,
                                                                  1,
                                                                  30),
                                           address_     => substr(p_resid_adress,
                                                                  1,
                                                                  100),
                                           territoryid_ => p_resid_territory);
        end if;
        -- заполнение эконом.нормативов
        kl.setcustomeren(p_rnk  => l_cust,
                         p_k070 => l_ise,
                         p_k080 => l_fs,
                         p_k110 => l_ved,
                         p_k090 => l_oe,
                         p_k050 => l_k050,
                         p_k051 => l_sed);

        bars_audit.trace('%s выполена регистрация клиента, РНК = %s',
                         l_title,
                         to_char(l_cust));
        p_clientid := l_cust;

      else

        -- режим без регистрации нового клиента (SO / UO)
        bars_audit.trace('%s клиент не найден, режим %s => без регистрации',
                         l_title,
                         p_usagemode);
        p_clientid := null;

      end if; -- p_usagemode

    else

      -- режим с обновлением карточки найденного клиента (UO / IU)
      if (p_usagemode = 'UO' or p_usagemode = 'IU') then

        bars_audit.trace('%s клиент найден, режим %s => обновляем карточку клиента',
                         l_title,
                         p_usagemode);

        -- проверка на необходимость обновления параметров клиента
        if not (nvl(l_custrow.nmk, '_') = nvl(p_clientname, '_') and
            nvl(l_custrow.nmkk, '_') = nvl(l_custnameshurt, '_') and
            nvl(l_custrow.tgr, 0) = nvl(p_clientcodetype, 0) and
            nvl(l_custrow.okpo, '_') = nvl(p_clientcode, '_') and
            nvl(l_custrow.codcagent, 0) = nvl(l_residcode, 0) and
            nvl(l_custrow.country, 0) = nvl(p_country, 0) and
            nvl(l_custrow.adr, '_') = nvl(p_fulladdress, '_') and
            nvl(l_custrow.c_reg, 0) = nvl(p_taxagencycode, 0) and
            nvl(l_custrow.c_dst, 0) = nvl(p_regagencycode, 0)) then
          -- обновление карточки клиента
          update customer
             set nmk       = substr(p_clientname, 1, 70),
                 nmkv      = substr(f_translate_kmu(p_clientname), 1, 70),
                 nmkk      = substr(l_custnameshurt, 1, 35),
                 adr       = substr(p_fulladdress, 1, 70),
                 okpo      = substr(p_clientcode, 1, 14),
                 c_reg = (case
                           when p_selfemployer = 1 then
                            p_taxagencycode
                           else
                            null
                         end),
                 c_dst = (case
                           when p_selfemployer = 1 then
                            p_regagencycode
                           else
                            null
                         end),
                 tgr       = p_clientcodetype,
                 codcagent = l_residcode,
                 country   = nvl(p_country, l_ourcountry),
                 ise = (case
                         when l_custrow.ise is null then
                          l_ise
                         else
                          ise
                       end),
                 fs = (case
                        when l_custrow.fs is null then
                         l_fs
                        else
                         fs
                      end),
                 oe = (case
                        when l_custrow.oe is null then
                         l_oe
                        else
                         oe
                      end),
                 ved = (case
                         when l_custrow.ved is null then
                          l_ved
                         else
                          ved
                       end),
                 sed = (case
                         when l_custrow.sed is null then
                          l_sed
                         else
                          sed
                       end),
                 k050 = (case
                          when l_custrow.k050 is null then
                           l_k050
                          else
                           k050
                        end)
           where rnk = l_custrow.rnk;

          -- обновление доп.реквизитов клиента
          kl.setcustomerelement(l_custrow.rnk,
                                'SN_FN',
                                substr(p_client_name, 1, 500),
                                0);
          kl.setcustomerelement(l_custrow.rnk,
                                'SN_LN',
                                substr(p_client_surname, 1, 500),
                                0);
          kl.setcustomerelement(l_custrow.rnk,
                                'SN_MN',
                                substr(p_client_patr, 1, 500),
                                0);

          -- заповнення юридичної адреси
          begin
            select *
              into l_addrrow
              from customer_address
             where rnk = l_custrow.rnk
               and type_id = 1;
          exception
            when no_data_found then
              l_addrrow := null;
          end;

          if ((l_addrrow.zip = p_index) and (l_addrrow.domain = p_obl) and
             (l_addrrow.region = p_district) and
             (l_addrrow.locality = p_settlement) and
             (l_addrrow.address = p_adress) and
             (l_addrrow.territory_id = p_territory)) then
            null;
          else

            kl.setcustomeraddressbyterritory(rnk_         => l_custrow.rnk,
                                             typeid_      => 1,
                                             country_     => nvl(p_country,
                                                                 l_ourcountry),
                                             zip_         => substr(p_index,
                                                                    1,
                                                                    5),
                                             domain_      => substr(p_obl,
                                                                    1,
                                                                    30),
                                             region_      => substr(p_district,
                                                                    1,
                                                                    30),
                                             locality_    => substr(p_settlement,
                                                                    1,
                                                                    30),
                                             address_     => substr(p_adress,
                                                                    1,
                                                                    100),
                                             territoryid_ => nvl(p_territory,
                                                                 l_addrrow.territory_id) -- якщо код території не вказаний лишаємо старе значення
                                             );

          end if;

          kl.setcustomerelement(l_custrow.rnk,
                                'FGIDX',
                                substr(p_index, 1, 500),
                                0);
          kl.setcustomerelement(l_custrow.rnk,
                                'FGOBL',
                                substr(p_obl, 1, 500),
                                0);
          kl.setcustomerelement(l_custrow.rnk,
                                'FGDST',
                                substr(p_district, 1, 500),
                                0);
          kl.setcustomerelement(l_custrow.rnk,
                                'FGTWN',
                                substr(p_settlement, 1, 500),
                                0);
          kl.setcustomerelement(l_custrow.rnk,
                                'FGADR',
                                substr(p_adress, 1, 500),
                                0);

          bars_audit.trace('%s обновлены параметры клиента',
                           l_title);

        end if;

        -- ФИО клиента в родит.падеже может измениться независимо от ФИО в именит.падеже
        kl.setcustomerelement(l_custrow.rnk,
                              'SN_GC',
                              substr(p_clientname_gc, 1, 500),
                              0);
        kl.setcustomerelement(l_custrow.rnk, 'K013', '5', 0);

        -- Ознака самозайнятої особи
        kl.setcustomerelement(l_custrow.rnk,
                              'SAMZ',
                              to_char(p_selfemployer),
                              0);

        -- "Особлива Вiдмiтка" нестандартного клієнта
        kl.setcustomerelement(l_custrow.rnk,
                              'SPMRK',
                              to_char(p_special_marks),
                              0);

        -- заполнение фактического адреса
        if (coalesce(p_resid_index,
                     p_resid_obl,
                     p_resid_district,
                     p_resid_settlement,
                     p_resid_adress) is not null) then
          begin
            select *
              into l_addrrow
              from customer_address
             where rnk = l_custrow.rnk
               and type_id = l_custadrtype;
          exception
            when no_data_found then
              l_addrrow := null;
          end;

          if ((l_addrrow.zip = p_resid_index) and
             (l_addrrow.domain = p_resid_obl) and
             (l_addrrow.region = p_resid_district) and
             (l_addrrow.locality = p_resid_settlement) and
             (l_addrrow.address = p_resid_adress) and
             (l_addrrow.territory_id = p_resid_territory)) then
            null;
          else

            kl.setcustomeraddressbyterritory(rnk_         => l_custrow.rnk,
                                             typeid_      => l_custadrtype,
                                             country_     => nvl(p_country,
                                                                 l_ourcountry),
                                             zip_         => substr(p_resid_index,
                                                                    1,
                                                                    5),
                                             domain_      => substr(p_resid_obl,
                                                                    1,
                                                                    30),
                                             region_      => substr(p_resid_district,
                                                                    1,
                                                                    30),
                                             locality_    => substr(p_resid_settlement,
                                                                    1,
                                                                    30),
                                             address_     => substr(p_resid_adress,
                                                                    1,
                                                                    100),
                                             territoryid_ => nvl(p_resid_territory,
                                                                 l_addrrow.territory_id) -- якщо код території не вказаний лишаємо старе значення
                                             );

          end if;

          bars_audit.trace('%s заполнен факт.адрес',
                           l_title);

        end if;

        -- параметры физ.лица
        begin

          select * into l_persrow from person where rnk = l_custrow.rnk;

          -- проверка на необходимость обновления параметров клиента-физ.лица
          if not
              (nvl(l_persrow.sex, '0') = nvl(p_clientsex, '0') and
              nvl(l_persrow.passp, 0) = nvl(p_doctype, 0) and
              nvl(l_persrow.ser, '_') = nvl(p_docserial, '_') and
              nvl(l_persrow.numdoc, '_') = nvl(p_docnumber, '_') and
              nvl(l_persrow.pdate, g_nulldate) = nvl(p_docdate, g_nulldate) and
              nvl(l_persrow.organ, '_') = nvl(p_docorg, '_') and
              nvl(l_persrow.date_photo, g_nulldate) =
              nvl(p_photodate, g_nulldate) and
              nvl(l_persrow.bday, g_nulldate) =
              nvl(p_clientbdate, g_nulldate) and
              nvl(l_persrow.bplace, '_') = nvl(p_clientbplace, '_') and
              nvl(l_persrow.teld, '_') = nvl(p_clienthomeph, '_') and
              nvl(l_persrow.telw, '_') = nvl(p_clientworkph, '_') and
              nvl(l_persrow.cellphone, '_') = nvl(p_clientcellphone, '_')) then
            -- обновление карточки клиента-физ.лица
            kl.setpersonattrex(rnk_    => l_persrow.rnk,
                               sex_    => (case
                                            when p_clientsex = '0' then
                                             l_persrow.sex
                                            else
                                             p_clientsex
                                          end), -- якщо стать не визначена лишаємо старе значення
                               passp_  => p_doctype,
                               ser_    => substr(p_docserial, 1, 10),
                               numdoc_ => substr(p_docnumber, 1, 20),
                               pdate_  => p_docdate,
                               organ_  => substr(p_docorg, 1, 50),
                               fdate_  => p_photodate,
                               bday_   => p_clientbdate,
                               bplace_ => substr(p_clientbplace, 1, 70),
                               teld_   => substr(p_clienthomeph, 1, 20),
                               telw_   => substr(p_clientworkph, 1, 20),
                               telm_   => p_clientcellphone);

            bars_audit.trace('%s обновлены параметры клиента-физ.лица',
                             l_title);

            -- Якщо змінився номер мобільного телефону
            if (l_persrow.cellphone = p_clientcellphone) then
              null;
            else
              begin
                for k in (select acc
                            from accounts
                           where rnk = l_custrow.rnk
                             and send_sms = 'Y'
                             and dazs is null) loop
                  update acc_sms_phones
                     set phone = '+38' || substr(p_clientcellphone, -10, 10)
                   where acc = k.acc;
                end loop;
              end;
            end if;

          end if;

        exception
          when no_data_found then
            -- клиент зарегистрирован БЕЗ параметров физ.лица
            kl.setpersonattrex(rnk_    => l_custrow.rnk,
                               sex_    => p_clientsex,
                               passp_  => p_doctype,
                               ser_    => substr(p_docserial, 1, 10),
                               numdoc_ => substr(p_docnumber, 1, 20),
                               pdate_  => p_docdate,
                               organ_  => substr(p_docorg, 1, 50),
                               fdate_  => p_photodate,
                               bday_   => p_clientbdate,
                               bplace_ => substr(p_clientbplace, 1, 70),
                               teld_   => substr(p_clienthomeph, 1, 20),
                               telw_   => substr(p_clientworkph, 1, 20),
                               telm_   => p_clientcellphone);
            bars_audit.trace('%s заполнены параметры клиента-физ.лица',
                             l_title);
        end;

        bars_audit.trace('%s выполено обновление карточки клиента, РНК = %s',
                         l_title,
                         to_char(l_custrow.rnk));
        p_clientid := l_custrow.rnk;

      else

        -- режим без обновления карточки найденного клиента (SO / IO)
        bars_audit.trace('%s клиент найден, режим %s => без обновления',
                         l_title,
                         p_usagemode);
        p_clientid := l_custrow.rnk;

      end if;

    end if; -- регистрация / обновление

    bars_audit.trace('%s выход с РНК = %s',
                     l_title,
                     to_char(p_clientid));

  end p_open_vklad_rnk;

  -- ======================================================================================
  --
  procedure create_deposit(p_vidd          in dpt_deposit.vidd%type,
                           p_rnk           in dpt_deposit.rnk%type,
                           p_nd            in dpt_deposit.nd%type,
                           p_sum           in dpt_deposit.limit%type,
                           p_nocash        in number,
                           p_datz          in dpt_deposit.datz%type,
                           p_namep         in dpt_deposit.name_p%type,
                           p_okpop         in dpt_deposit.okpo_p%type,
                           p_nlsp          in dpt_deposit.nls_p%type,
                           p_mfop          in dpt_deposit.mfo_p%type,
                           p_fl_perekr     in dpt_vidd.fl_2620%type,
                           p_name_perekr   in dpt_deposit.nms_d%type,
                           p_okpo_perekr   in dpt_deposit.okpo_p%type,
                           p_nls_perekr    in dpt_deposit.nls_d%type,
                           p_mfo_perekr    in dpt_deposit.mfo_d%type,
                           p_comment       in dpt_deposit.comments%type,
                           p_dpt_id        out dpt_deposit.deposit_id%type,
                           p_datbegin      in dpt_deposit.dat_begin%type default null,
                           p_duration      in dpt_vidd.duration%type default null,
                           p_duration_days in dpt_vidd.duration_days%type default null, -- длительность (дней)
                           p_wb            in dpt_deposit.wb%type default 'N') -- признак открытия через веббанинг
   is
    l_title     varchar2(60) := 'dpt_web.create_deposit: ';
    l_grp       groups_acc.id%type;
    l_flp       dpt_vidd.fl_2620%type;
    l_termm     dpt_vidd.duration%type;
    l_termd     dpt_vidd.duration_days%type;
    l_termm_max dpt_vidd.duration_max%type;
    l_termd_max dpt_vidd.duration_days_max%type;
    l_curcode   dpt_vidd.kv%type;
    l_dpt       dpt_deposit.deposit_id%type;
    l_termtype  dpt_vidd.term_type%type;
    l_nlsd      accounts.nls%type;
    l_nlsn      accounts.nls%type;
    l_nlsa      accounts.nls%type;
    l_errmsg    g_errmsg%type;
    l_datbegin  dpt_deposit.dat_begin%type;
    l_bonus_cnt number;
    l_bonusval  dpt_bonus_requests.bonus_value_fact%type;
    --
    l_migr           number := null;
    l_valid_mobphone number := 0;
    l_ea_pens        dpt_vidd_params.val%type := '0';
    l_pens_count     int := 0;
    l_ea_id          ead_docs.id%type;
    l_ea_blob        blob := utl_raw.cast_to_raw(''); -- пустой BLOB для отправки в ЕА (идет не скан-документ, а сообщение о его необходимости)
    l_archdocid      number;
  l_typecod        dpt_vidd.type_cod%type;
  begin

    l_valid_mobphone := bars.verify_cellphone_byrnk(p_rnk);
    if (p_datbegin is null) then
      l_datbegin := gl.bdate;
    else
      l_datbegin := p_datbegin;
    end if;

    -- Перевірка "НА МІГРАЦІЮ" (локальна банківська дата != глобальній)
    if instr(p_comment, 'Imported from') > 0 then
      l_migr := 1;
    else
      -- для Офлайну
      select case
               when exists
                (select 1
                       from customer
                      where rnk in (select rnk
                                      from kl_customer_params
                                     where isactive = 1)
                        and branch =
                            sys_context('bars_context', 'user_branch')) then
                1
               else
                null
             end
        into l_migr
        from dual;
    end if;
    if l_valid_mobphone = 0 and l_migr = 0 then
      -- В картці клієнта не заповнено або невірно заповнено мобільний телефон
      bars_error.raise_nerror('CAC', 'ERROR_MPNO');
      raise_application_error(-20001,
                              'ERR:  В картці клієнта не заповнено або невірно заповнено мобільний телефон! Заповніть корректний моб.телефон в картці клієнта і спробуйте знову.',
                              true);
    else

      bars_audit.trace('%s РНК = %s, вид вклада = %s, сумма = %s',
                       l_title,
                       to_char(p_rnk),
                       to_char(p_vidd),
                       to_char(p_sum));

      -- группа доступа

      begin
        select g.id
          into l_grp
          from params p, groups_acc g
         where g.id = to_number(p.val)
           and p.par = 'DPT_GRP';
      exception
        when no_data_found then
          bars_error.raise_nerror(g_modcode, 'DPTGRP_NOT_FOUND');
      end;
      bars_audit.trace('%s группа доступа = %s',
                       l_title,
                       to_char(l_grp));

      begin
        select nvl(duration, 0),
               nvl(duration_days, 0),
               nvl(duration_max, 0),
               nvl(duration_days_max, 0),
               term_type,
               decode(nvl(type_cod, '____'), 'COMB', 1, p_fl_perekr),
               kv,
               type_cod
          into l_termm,
               l_termd,
               l_termm_max,
               l_termd_max,
               l_termtype,
               l_flp,
               l_curcode,
               l_typecod
          from dpt_vidd
         where vidd = p_vidd;
      exception
        when no_data_found then
          bars_error.raise_nerror(g_modcode,
                                  g_viddnotfound,
                                  to_char(p_vidd));
      end;

      bars_audit.trace('%s тип = %s, min.термін = (%s міс, %s дн), max.термін = (%s міс, %s дн)',
                       l_title,
                       to_char(l_termtype),
                       to_char(l_termm),
                       to_char(l_termd),
                       to_char(l_termm_max),
                       to_char(l_termd_max));

      bars_audit.trace('%s индив.срок = (%s мес, %s дн)',
                       l_title,
                       to_char(p_duration),
                       to_char(p_duration_days));

      begin
        select val
          into l_ea_pens
          from dpt_vidd_params
         where tag = 'EA_PENS'
           and vidd = p_vidd;
      exception
        when no_data_found then
          l_ea_pens := 0;
      end;

      begin
        select count(*)
          into l_pens_count
          from ead_docs
         where rnk = p_rnk
           and ea_struct_id = 143; -- пенсійне посвідчення передавати один раз
      exception
        when no_data_found then
          l_pens_count := 0;
      end;
      bars_audit.trace('%s признак отправки пенсионного удостоверения в ЕА = %s',
                       l_title,
                       to_char(l_ea_pens));
      if (l_termtype = 2) and
         ((add_months(l_datbegin, nvl(p_duration, 0)) +
         nvl(p_duration_days, 0)) >
         (add_months(l_datbegin, l_termm_max) + l_termd_max) or -- термін більший за максимальний
         (add_months(l_datbegin, nvl(p_duration, 0)) +
         nvl(p_duration_days, 0)) <
         (add_months(l_datbegin, l_termm) + l_termd) -- термін менший  за мінімальний
         ) then
        if (l_migr = 1) then
          bars_audit.info(l_title || 'дата почтку = ' ||
                          to_char(l_datbegin, 'dd/mm/yyyy') ||
                          ' індив. термін = ' || to_char(p_duration) ||
                          ' міс, ' || to_char(p_duration_days) || ' днів.');
        else
          bars_error.raise_nerror(g_modcode, 'CORRTERM_INVALIDATES');
        end if;
      end if;

      if (l_termtype != 1) then
        l_termm := nvl(p_duration, l_termm);
        l_termd := nvl(p_duration_days, l_termd);
      end if;

      bars_audit.trace('%s => срок договора = (%s мес, %s дн)',
                       l_title,
                       to_char(l_termm),
                       to_char(l_termd));

      dpt.p_open_vklad_ex(p_vidd        => p_vidd,
                          p_rnk         => p_rnk,
                          p_nd          => p_nd,
                          p_sum         => p_sum,
                          p_nls_intpay  => p_nlsp,
                          p_mfo_intpay  => p_mfop,
                          p_okpo_intpay => p_okpop,
                          p_name_intpay => p_namep,
                          p_fl_dptpay   => l_flp,
                          p_nls_dptpay  => p_nls_perekr,
                          p_mfo_dptpay  => p_mfo_perekr,
                          p_name_dptpay => p_name_perekr,
                          p_comments    => p_comment,
                          p_datz        => p_datz,
                          p_datbegin    => l_datbegin,
                          p_dat_end_alt => to_date(null),
                          p_term_m      => l_termm,
                          p_term_d      => l_termd,
                          p_grp         => l_grp,
                          p_isp         => null,
                          p_nocash      => p_nocash,
                          p_chgtype     => 0,
                          p_depacctype  => 'DEP',
                          p_intacctype  => 'DEN',
                          p_migr        => l_migr, -- ознака міграції
                          p_dptid       => l_dpt,
                          p_nlsdep      => l_nlsd,
                          p_nlsint      => l_nlsn,
                          p_nlsamr      => l_nlsa,
                          p_errmsg      => l_errmsg,
                          p_wb          => p_wb);

      p_dpt_id := l_dpt;
      bars_audit.trace('%s открыт вклад № %s',
                       l_title,
                       to_char(l_dpt));

      bars_audit.trace('%s запуск процедуры расчета льгот',
                       l_title);

      dpt_bonus.set_bonus(l_dpt);

      bars_audit.trace('%s льготы рассчитаны', l_title);

      bars_audit.trace('%s поиск бонусной процентной ставки, не требующей подтверждения',
                       l_title);

      select count(1)
        into l_bonus_cnt
        from dpt_bonus_requests t1, dpt_bonuses t2, dpt_requests t3
       where t1.dpt_id = l_dpt
         and t1.bonus_id = t2.bonus_id
         and t3.dpt_id = t1.dpt_id
         and t1.req_id = t3.req_id
         and t3.reqtype_id = 1 -- запит на бонусну ставку
         and t2.bonus_confirm = 'N' -- не потребує додаткового підтвердження
         and t1.request_state = 'ALLOW'; -- запит погоджено автоматично;

      bars_audit.trace('%s по вкладу найдено %s бонусных ставок, переход к подтверждению',
                       l_title,
                       to_char(l_bonus_cnt));

      if (l_bonus_cnt > 0) then
        dpt_bonus.set_bonus_rate(l_dpt, p_datz, l_bonusval);
        bars_audit.trace('%s встановлена бонусна ставка = %s',
                         l_title,
                         to_char(l_bonusval));
      end if;

      -- для строкових вкладів що відкриваються по ЕБП (Ощадбанк)
      if ((branch_usr.get_branch_param2('DPT_WORKSCHEME', 1) = 'EBP') and
         ((substr(l_nlsd, 1, 4) in ('2630', '2635') and newnbs.g_state = 0) or (substr(l_nlsd, 1, 4) = '2630' and newnbs.g_state = 1))
         and (l_migr is null)) then
      if l_typecod <> 'CHIL' then   --COBUSUPABS-7074
        ebp.set_archive_docid(l_dpt, 0);
      end if;

        -- для відправки SMS повідомленнь про рух коштів по рахунках депозитного договору
        for k in (select accid from dpt_accounts where dptid = l_dpt) loop

          update accounts set send_sms = 'Y' where acc = k.accid;

          begin
            insert into acc_sms_phones
              (acc, phone, "ENCODE")
              select k.accid, '+38' || substr("VALUE", -10, 10), 'lat'
                from customerw
               where rnk = p_rnk
                 and tag = 'MPNO ';
          exception
            when dup_val_on_index then
              bars_error.raise_nerror('DP', 'ERROR_MPNO');
          end;

        end loop;

      end if;
      --inga 31/03/2015 COBUSUPABS-3311 Если параметр в карточке вида вклада EA_PENS = '1', отправляем документ 143 (Пенсионное удостоверение в ЕА)
      --COBUMMFO-6302 - при открытии через WEB пенсионное запрашиваться не должно
      if l_ea_pens = '1' and l_pens_count = 0 and is_pensioner(p_rnk) = 0 and p_wb = 'N' then
        l_ea_id := ead_pack.doc_create('SCAN',
                                       null,
                                       l_ea_blob,
                                       143,
                                       p_rnk,
                                       l_dpt);
        bars_audit.trace('%s Отправлено уведомление о наличии пенсионного удостоверения в ЕА ead_docs.id = %s',
                         l_title,
                         to_char(l_ea_id));
      end if;
    end if;
    cust_insider(p_rnk);

    if (p_wb = 'Y') then
      begin
        update dpt_deposit set wb = 'Y' where deposit_id = l_dpt;
        update dpt_deposit_clos set wb = 'Y' where deposit_id = l_dpt;
        l_archdocid :=  --intg_wb.frx2ea(l_dpt,p_rnk);
         ead_pack.doc_create(p_type_id      => 'DOC',
                                           p_template_id  => 'WB_CREATE_DEPOSIT',
                                           p_scan_data    => null,
                                           p_ea_struct_id => 541,
                                           p_rnk          => p_rnk,
                                           p_agr_id       => l_dpt);
        ebp.set_archive_docid(l_dpt, l_archdocid);
--        ead_pack.doc_sign(l_archdocid);
      exception
        when others then
          bars_audit.trace(dbms_utility.format_error_stack() || chr(10) ||
                           dbms_utility.format_error_backtrace());
      end;
    end if;
  end create_deposit;

  -- ======================================================================================
  procedure sign_deposit(p_dptid in dpt_deposit.deposit_id%type) is
    l_title varchar2(60) := 'dpt_web.sign_deposit: ';
  begin

    bars_audit.trace(l_title || 'вклад № %s', to_char(p_dptid));

    update dpt_deposit set status = 0 where deposit_id = p_dptid;

    if (sql%rowcount = 0) then
      bars_error.raise_nerror(g_modcode, g_dptnotfound, to_char(p_dptid));
    end if;

  end sign_deposit;
  -- ======================================================================================
  procedure create_text(p_id   in cc_docs.id%type,
                        p_nd   in cc_docs.nd%type,
                        p_adds in cc_docs.adds%type,
                        p_text in cc_docs.text%type) is
    l_title varchar2(60) := 'dpt_web.create_text: ';
    l_id    cc_docs.id%type;
  begin

    bars_audit.trace(l_title || 'договор № %s, ДС № %s, шаблон %s',
                     to_char(p_nd),
                     to_char(p_adds),
                     p_id);

    -- есть запись с пустым текстом
    update cc_docs
       set text = p_text, version = sysdate
     where id = p_id
       and nd = p_nd
       and adds = p_adds
       and text is null;

    if sql%rowcount = 0 then

      begin
        -- проверим, возможно есть запись с непустым текстом
        select id
          into l_id
          from cc_docs
         where id = p_id
           and nd = p_nd
           and adds = p_adds
           and text is not null;
        bars_error.raise_nerror(g_modcode,
                                'TEXT_ALREADY_EXISTS',
                                to_char(p_adds),
                                to_char(p_nd),
                                p_id);
        -- запись остутствует -> добавим
      exception
        when no_data_found then
          insert into cc_docs
            (id, nd, adds, text, version, state)
          values
            (p_id, p_nd, p_adds, p_text, sysdate, 1);
          bars_audit.trace(l_title || 'добавили запись');
      end;

    else

      bars_audit.trace(l_title || 'заполнен текст пустого договора / ДС');

    end if;

  end create_text;
  -- ======================================================================================
  procedure prolongation_create_text(p_id   in cc_docs.id%type,
                                     p_nd   in cc_docs.nd%type,
                                     p_text in cc_docs.text%type) is
    l_title varchar2(60) := 'dpt_web.prolongation_create_text: ';
    l_id    cc_docs.id%type;
  begin

    bars_audit.trace(l_title || 'договор № %s, ДС № 0, шаблон %s',
                     to_char(p_nd),
                     p_id);

    -- есть запись с пустым текстом
    update cc_docs
       set text = p_text, version = sysdate
     where id = p_id
       and nd = p_nd
       and adds = 0;

    if sql%rowcount = 0 then

      -- запись остутствует -> добавим
      insert into cc_docs
        (id, nd, adds, text, version, state)
      values
        (p_id, p_nd, 0, p_text, sysdate, 1);
      bars_audit.trace(l_title || 'добавили запись');

    else

      bars_audit.trace(l_title || 'заполнен текст договора / ДС');

    end if;

  end prolongation_create_text;

  -- ======================================================================================
  -- перевірка на належність вкладного рахунка до діючого кредитного договору
  --
  function check_belongs_credit(p_acc in accounts.acc%type) return number is
   title  varchar2(64) := 'dptweb.check_belongs_credit';
   l_flag number(1);
  begin

    bars_audit.trace('%s: Entry, acc=>%s', title, to_char(p_acc));

    select sign(count(1))
      into l_flag
      from CC_DEAL c
      join ND_ACC  n
        on ( n.ND = c.ND )
     where n.ACC = p_acc
       and c.SOS < 14;

    bars_audit.trace('%s: Exit with %s', title, to_char(l_flag));

    return l_flag;

  end check_belongs_credit;

  -- ======================================================================================
  --
  --
  function ACC_CLOSING_PERMITTED
  ( p_acc  in  accounts.acc%type
  , p_sos  in  sos.sos%type
  ) return number is
    -- p_sos = 0 - НЕ допускается наличие никаких остатков
    --         1 - допускается наличие только планового остатка
    --         3 - допускается наличие планового/форвардного остатков
    --         9 - допускается наличие только фактического остатка и движений за сегодня
    title   varchar2(64) := 'dptweb.acc_closing_permitted';
    l_flag  number(1);
  begin

    bars_audit.trace( '%s: Entry, acc=>%s, sos=>%s, gl.bdate=>%s', title
                    , to_char(p_acc), to_char(p_sos), to_char(gl.bdate, 'dd.mm.yyyy') );

    if ( CHECK_BELONGS_CREDIT(p_acc) = 1 )
    then

      l_flag := 0;

      bars_audit.error( title||': account #'||to_char(p_acc)||' is used by a loan agreement.' );

    else

      begin
        select 1
          into l_flag
          from ACCOUNTS
         where ACC = p_acc
           and ( p_sos = 0 and ostc = 0 and ostb = 0 and ostf = 0
              or p_sos = 1 and ostc = 0 and ostf = 0
              or p_sos = 3 and ostc = 0
              or p_sos = 9 and ostb = 0 and ostf = 0 );
      exception
        when no_data_found then
          l_flag := 0;
      end;

      if ( p_sos = 9 )
      then
        null;
      else

        if ( l_flag = 1 )
        then

          select case
                 when EXISTS( select 1
                                from SALDOA
                               where ACC = p_acc
                                 and FDAT >= GL.bdate
                                 and DOS + KOS > 0 )
                 then 0
                 else 1
                 end
            into l_flag
            from dual;

        end if;

      end if;

    end if;

    bars_audit.trace('%s: Exit with %s', title, to_char(l_flag));

    return l_flag;

  end ACC_CLOSING_PERMITTED;

  -- ======================================================================================
  --
  --
  function dpt_closing_permitted(p_dpt in dpt_deposit.deposit_id%type)
    return number is
    title  varchar2(60) := 'dptweb.dpt_closing_permitted:';
    l_flag number(1) := 1; -- разрешено, 0 - запрeщено
    l_dapp date;
  begin
    bars_audit.trace('%s entry, p_dptid=>%s, gl.bdate=>%s',
                     title,
                     to_char(p_dpt),
                     to_char(gl.bd, 'dd.mm.yyyy'));
    begin
      select 0
        into l_flag
        from dpt_deposit d
       where d.vidd in (53, 14)
         and d.deposit_id = p_dpt;
    exception
      when no_data_found then
        l_flag := 1;
    end;

    if l_flag = 0 then
      bars_audit.trace('%s Вклад %s на малолітню особу - не закриваємо',
                       title,
                       to_char(p_dpt));
    end if;
    return l_flag;
  end dpt_closing_permitted;

  -- ======================================================================================
  --
  --
  function closing_permitted(p_dptid in dpt_deposit.deposit_id%type,
                             p_sos   in sos.sos%type) return number is
    title  varchar2(60) := 'dptweb.clospermit:';
    l_flag number(1) := 0;
  begin

    bars_audit.trace('%s entry, dptid=>%s, sos=>%s',
                     title,
                     to_char(p_dptid),
                     to_char(p_sos));

    begin
      select 1
        into l_flag
        from dpt_deposit d, dpt_vidd v, int_accn i
       where d.vidd = v.vidd
         and d.acc = i.acc
         and i.id = 1
         and d.deposit_id = p_dptid
         and acc_closing_permitted(i.acc, p_sos) = 1
         and acc_closing_permitted(i.acra, p_sos) = 1
         and (v.amr_metr = 0 or
             v.amr_metr = 4 and acc_closing_permitted(i.acrb, p_sos) = 0)
         and (d.dpt_d is null or
             d.dpt_d is not null and closing_permitted(d.dpt_d, p_sos) = 1);
    exception
      when no_data_found then
        l_flag := 0;
    end;

    bars_audit.trace('%s exit with %s', title, to_char(l_flag));
    return l_flag;

  end closing_permitted;

  -- ======================================================================================
  --
  --
  procedure close_requests(p_dptid    in dpt_deposit.deposit_id%type,
                           p_typecode in dpt_req_types.reqtype_code%type default null,
                           p_delbonus in number default 0) is
    l_title varchar(60) := 'dpt_web.close_requests: ';
  begin

    bars_audit.trace('%s договор № %s, тип  запроса %s',
                     l_title,
                     to_char(p_dptid),
                     p_typecode);

    -- запросы на изменение ставки согл.ДС, на удаление, на отмену комиссий
    <<req_loop>>
    for req in (select r.req_id, t.reqtype_code type_code, r.branch
                  from dpt_requests r, dpt_req_types t
                 where r.reqtype_id = t.reqtype_id
                   and r.req_state is null
                   and r.dpt_id = p_dptid
                   and (p_typecode is null or t.reqtype_code = p_typecode)
                   and t.reqtype_code != 'BONUS'
                 order by 2, 1 desc) loop

      bars_audit.trace('%s запрос № %s, тип  запроса %s',
                       l_title,
                       to_char(req.req_id),
                       req.type_code);

      if req.type_code = 'DELETE_DEAL' then
        -- найден необработанный запрос (№ %s) на удаление договора №
        bars_error.raise_nerror(g_modcode,
                                'REQCLOSE_DENIED',
                                to_char(req.req_id),
                                to_char(p_dptid));
      elsif req.type_code = 'AGRMNT_COMMIS' then
        delete_commis_request(req.req_id);
      elsif req.type_code = 'AGRMNT_CHGINT' then
        delete_chgint_request(req.req_id);
      else
        bars_audit.trace('%s неопознанный тип запроса',
                         l_title);
      end if;

    end loop request_loop;
    bars_audit.trace('%s выполнено удаление необработанных запросов по договору № %s',
                     l_title,
                     to_char(p_dptid));

    bars_audit.trace('%s признак удаления запросов на получение льгот - %s',
                     l_title,
                     to_char(p_delbonus));

    <<bonus_loop>>
    for bonus in (select r.dpt_id, r.bonus_id, q.req_id, r.request_state
                    from dpt_bonus_requests r,
                         (select q.dpt_id, q.req_id
                            from dpt_requests q, dpt_req_types qt
                           where q.dpt_id = p_dptid
                             and q.reqtype_id = qt.reqtype_id
                             and qt.reqtype_code = 'BONUS') q
                   where r.dpt_id = q.dpt_id(+)
                     and r.dpt_id = p_dptid
                   order by 1) loop

      bars_audit.trace('%s запрос на получение льготы № %s',
                       l_title,
                       to_char(bonus.bonus_id));

      if p_delbonus = 1 then
        bars_audit.trace('%s физическое удаление запроса',
                         l_title);
        delete from dpt_bonus_requests
         where dpt_id = bonus.dpt_id
           and bonus_id = bonus.bonus_id;
        bars_audit.trace('%s удален запрос на получение льготы № %s',
                         l_title,
                         to_char(bonus.bonus_id));
        delete from dpt_requests where req_id = bonus.req_id;
        delete from dpt_depositw
         where dpt_id = bonus.dpt_id
           and tag = 'BONUS';
      else
        bars_audit.trace('%s закрытие запроса', l_title);
        if bonus.request_state = 'NULL' then
          dpt_bonus.del_request(p_dptid, bonus.bonus_id);
          bars_audit.trace('%s закрыт запрос на получение льготы № %s',
                           l_title,
                           to_char(bonus.bonus_id));
        end if;
      end if;

    end loop bonus_loop;

    bars_audit.trace('%s выполнено удаление запросов по договору № %s',
                     l_title,
                     to_char(p_dptid));

  end close_requests;

  -- ======================================================================================
  --
  --
  procedure close_to_archive(p_type  in varchar2,
                             p_dat   in fdat.fdat%type,
                             p_dptid in dpt_deposit.deposit_id%type,
                             p_accid in accounts.acc%type) is
    l_title varchar2(60) := 'dpt_web.close_to_archive: ';
  begin
    bars_audit.trace('%s тип закрытия = %s, договор № %s, счет acc=%s',
                     l_title, p_type, to_char(p_dptid), to_char(p_accid));

    if p_type = 'DPT' then

      bars_audit.trace('%s закрытие всех доп.соглашений',
                       l_title);
      update dpt_agreements
         set agrmnt_state = 0
       where dpt_id = p_dptid
         and nvl(agrmnt_state, 9) > 0;
      if sql%rowcount > 0 then
        bars_audit.trace('%s закрыты все доп.соглашения по договору № %s', l_title, to_char(p_dptid));
      end if;
      bars_audit.trace('%s закрытие необработанных запросов', l_title);
      close_requests(p_dptid    => p_dptid,
                     p_typecode => null,
                     p_delbonus => 0);

	-- видалення дод. реквізитів
      delete DPT_DEPOSITW where DPT_ID = p_dptid;      
	-- закрытие договора
      delete from dpt_deposit where deposit_id = p_dptid;
      
      if sql%rowcount = 0 then
        bars_error.raise_nerror(g_modcode,
                                'DPT_CLOSE_ERR',
                                to_char(p_dptid));
      else
        bars_audit.trace('%s закрыт договор № %s',
                         l_title,
                         to_char(p_dptid));
        close_sto_argmnt(p_dptid    => p_dptid,
                         p_accid    => null,
                         p_argmntid => null);
      end if;

    elsif p_type = 'ACC' then

      -- закрытие счета
      update bars.accounts
         set dazs = decode(daos, p_dat, dat_next_u(p_dat, 1), p_dat)
       where acc = p_accid
         and dazs is null;
     
      if sql%rowcount > 0
      then
        bars_audit.trace( '%s закрыт счет acc = %s', l_title, to_char(p_accid) );
      end if;

    else
      null;
    end if;

  end close_to_archive;
  -- ======================================================================================
  function dpt_del_enabled(p_dptid in dpt_deposit.deposit_id%type,
                           p_dat   in dpt_deposit.dat_begin%type default bankdate)
    return number is
    l_title  varchar2(60) := 'dpt_web.dpt_del_enabled: ';
    l_enable number(1); /* 0 - нельзя удалить, 1 - удаление разрешено */
  begin

    bars_audit.trace(l_title || 'договор № %s', to_char(p_dptid));

    l_enable := 0;

    -- Проверки:
    -- 1. дата заключения договора - текущая банковская дата (или p_dat)
    -- 2. по договору отсутствуют завизированные документы
    select closing_permitted(deposit_id, 1)
      into l_enable
      from dpt_deposit
     where deposit_id = p_dptid
       and dat_begin = p_dat;
    bars_audit.trace(l_title ||
                     'флаг допустимости закрытия договора № %s = %s',
                     to_char(p_dptid),
                     to_char(l_enable));
    return l_enable;

  exception
    when no_data_found then
      bars_audit.trace(l_title || 'закрытие договора № %s недопустимо',
                       to_char(p_dptid));
      return l_enable;
  end dpt_del_enabled;
  -- ======================================================================================
  procedure dpt_delete(p_dptid    in dpt_deposit.deposit_id%type,
                       p_dat      in fdat.fdat%type default bankdate,
                       p_reasonid in bp_reason.id%type default 13) is
    l_title   varchar2(60) := 'dpt_web.dpt_delete: ';
    l_accd    accounts.acc%type;
    l_accp    accounts.acc%type;
    l_acca    accounts.acc%type;
    l_techdpt dpt_deposit.dpt_d%type;
    l_numpar  number(38);
    l_strpar  varchar2(50);
    l_errmsg  g_errmsg%type;
  begin

    bars_audit.trace(l_title || 'договор № %s', to_char(p_dptid));

    /* Удаление депозитов запрещено. */

    bars_error.raise_nerror(g_modcode,
                            g_proc_deprecated,
                            'dpt_web.dpt_delete');

    /*
      -- допустимо ли удаление
      IF dpt_del_enabled (p_dptid, p_dat) != 1 THEN
         l_errmsg := 'закриття договору заборонено';
         bars_error.raise_nerror(g_modcode, 'DPT_CLOSE_VETO', to_char(p_dptid), l_errmsg);
      END IF;
      bars_audit.trace(l_title||'удаление допустимо');

      -- счета по договору
      BEGIN
        SELECT d.acc, i.acra, decode(v.bsa, NULL, NULL, i.acrb), d.dpt_d
          INTO l_accd, l_accp, l_acca, l_techdpt
          FROM dpt_deposit d, int_accn i, dpt_vidd v
         WHERE d.deposit_id = p_dptid
           AND d.vidd = v.vidd
           AND d.acc = i.acc
           AND i.id = 1;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          bars_error.raise_nerror(g_modcode, g_DptNotFound, to_char(p_dptid));
      END;
      bars_audit.trace(l_title||' счета по договору (%s, %s, %s)',
                       to_char(l_accd), to_char(l_accp), to_char(l_acca));

      -- сторно всех незавизированных документов
      kill_dpt_payments (p_dptid     => p_dptid,
                         p_ref       => 0,
                         p_docstatus => 1,
                         p_reasonid  => p_reasonid,
                         p_levelid   => 3,
                         p_fullback  => 1,
                         p_novisa    => 0);

      -- закрытие вклада
      BEGIN
        close_to_archive (p_type   => 'DPT',
                          p_dat    => p_dat,
                          p_dptid  => p_dptid,
                          p_accid  => null);
      EXCEPTION
        WHEN bars_error.err THEN
         l_errmsg := sqlerrm;
         IF bars_error.get_nerror_code(l_errmsg) = g_modcode||'-'||'DPT_CLOSE_ERR' THEN
            bars_error.raise_nerror(g_modcode, 'DPT_CLOSE_VETO', to_char(p_dptid), l_errmsg);
         ELSE
           RAISE;
         END IF;
      END;

      -- удалим техн.вклад, если он есть
      IF l_techdpt IS NOT NULL THEN
         dpt_delete (l_techdpt, p_dat);
      END IF;

      -- закрытие депозитного счета
      BEGIN
        close_to_archive (p_type   => 'ACC',
                          p_dat    => p_dat,
                          p_dptid  => p_dptid,
                          p_accid  => l_accd);
      EXCEPTION
        WHEN bars_error.err THEN
         l_errmsg := sqlerrm;
         IF bars_error.get_nerror_code(l_errmsg) = g_modcode||'-'||'ACC_CLOSE_ERR' THEN
            bars_error.raise_nerror(g_modcode, 'DPT_CLOSE_VETO', to_char(p_dptid), l_errmsg);
         ELSE
           RAISE;
         END IF;
      END;

      -- закрытие счета начисленных %%
      BEGIN
        close_to_archive (p_type   => 'ACC',
                          p_dat    => p_dat,
                          p_dptid  => p_dptid,
                          p_accid  => l_accp);
      EXCEPTION
        WHEN bars_error.err THEN
         l_errmsg := sqlerrm;
         IF bars_error.get_nerror_code(l_errmsg) = 'DPT-'||'ACC_CLOSE_ERR' THEN
            bars_error.raise_nerror(g_modcode, 'DPT_CLOSE_VETO', to_char(p_dptid), l_errmsg);
         ELSE
           RAISE;
         END IF;
      END;

      IF l_acca IS NOT NULL THEN
         -- закрытие счета амортизации начисленных %%
         BEGIN
           close_to_archive (p_type   => 'ACC',
                             p_dat    => p_dat,
                             p_dptid  => p_dptid,
                             p_accid  => l_acca);
         EXCEPTION
           WHEN bars_error.err THEN
             l_errmsg := sqlerrm;
             IF bars_error.get_nerror_code(l_errmsg) = 'DPT-'||'ACC_CLOSE_ERR' THEN
                bars_error.raise_nerror(g_modcode, 'DPT_CLOSE_VETO', to_char(p_dptid), l_errmsg);
             ELSE
               RAISE;
             END IF;
         END;
      END IF;
    */
  end dpt_delete;
  -- ======================================================================================
  procedure change_deposit_type(p_dptid   in dpt_deposit.deposit_id%type,
                                p_typeid  in dpt_deposit.vidd%type,
                                p_amount  in dpt_deposit.limit%type,
                                p_nocash  in number,
                                p_payoff  in number,
                                p_comment in dpt_deposit.comments%type) is
    l_title    varchar(60) := 'dpt_web.change_deposit_type: ';
    l_bankdate fdat.fdat%type := gl.bdate;
    l_dptrow   dpt_deposit%rowtype;
    -------------------------
    procedure reverse_all_agreements(l_dptid in dpt_deposit.deposit_id%type) is
      l_title varchar(60) := 'dpt_web.change_deposit_type.reverse_all_agreements: ';
      l_cnt   number(38);
    begin

      bars_audit.trace('%s договор № %s',
                       l_title,
                       to_char(l_dptid));

      <<agreement_loop>>
      for agr in (select agrmnt_id, agrmnt_num, agrmnt_date, agrmnt_type
                    from dpt_agreements
                   where dpt_id = l_dptid
                     and agrmnt_state = 1
                   order by 1 desc) loop

        bars_audit.trace('%s ДС № %s от %s (%s), тип %s',
                         l_title,
                         to_char(agr.agrmnt_num),
                         to_char(agr.agrmnt_date, 'dd.mm.yyyy'),
                         to_char(agr.agrmnt_id),
                         to_char(agr.agrmnt_type));

        p_reverse_agrement(agr.agrmnt_id);

      end loop agreement_loop;

      -- это волшебное слово - рекурсия!
      select count(*)
        into l_cnt
        from dpt_agreements
       where dpt_id = l_dptid
         and agrmnt_state = 1;
      if l_cnt > 0 then
        reverse_all_agreements(p_dptid);
      end if;

    end reverse_all_agreements;
    -------------------
  begin

    bars_audit.trace('%s договор № %s, вид договора %s, сумма договора %s',
                     l_title,
                     to_char(p_dptid),
                     to_char(p_typeid),
                     to_char(p_amount));
    begin
      select * into l_dptrow from dpt_deposit where deposit_id = p_dptid;
    exception
      when no_data_found then
        bars_error.raise_nerror(g_modcode, g_dptnotfound, to_char(p_dptid));
    end;
    bars_audit.trace('%s статус договора - %s, дата заключения - %s, дата начала - %s',
                     l_title,
                     to_char(l_dptrow.status),
                     to_char(l_dptrow.datz, 'dd.mm.yyyy'),
                     to_char(l_dptrow.dat_begin, 'dd.mm.yyyy'));

    if (l_dptrow.dat_begin != l_bankdate) or
       (l_dptrow.datz != trunc(sysdate) or (l_dptrow.status is not null) or
       closing_permitted(p_dptid, 1) != 1) then
      -- изменение вида договора для договора № запрещено
      bars_error.raise_nerror(g_modcode,
                              'CHG_DPTYPE_DENIED',
                              to_char(p_dptid));
    end if;

    bars_audit.trace('%s удаление всех активных доп.соглашений по договору',
                     l_title);
    reverse_all_agreements(p_dptid);
    bars_audit.trace('%s удаление всех необработанных запросов по договору',
                     l_title);
    close_requests(p_dptid => p_dptid, p_typecode => null, p_delbonus => 1);
    --  p_delbonus = 1 для физич.удаления всех запросов на получение льгот
    --                 для того, чтобы можно сформировать новые запросы для нового вида вклада
    bars_audit.trace('%s удаление всех незавизированных документов по договору',
                     l_title);
    kill_dpt_payments(p_dptid     => p_dptid,
                      p_ref       => 0,
                      p_docstatus => 1,
                      p_reasonid  => 13,
                      p_levelid   => 3,
                      p_fullback  => 1,
                      p_novisa    => 1);

    bars_audit.trace('%s удаление текса договора',
                     l_title);
    delete from cc_docs
     where nd = p_dptid
       and nvl(adds, 0) = 0;

    bars_audit.trace('%s изменение вида договора',
                     l_title);
    dpt.update_dpt_type(p_dptid        => p_dptid,
                        p_typeid       => p_typeid,
                        p_dptamount    => p_amount,
                        p_nocash       => p_nocash,
                        p_payoff       => p_payoff,
                        p_intrcpmfo    => null,
                        p_intrcpacc    => null,
                        p_intrcpidcode => null,
                        p_intrcpname   => null,
                        p_dptrcpmfo    => null,
                        p_dptrcpacc    => null,
                        p_dptrcpidcode => null,
                        p_dptrcpname   => null,
                        p_comment      => p_comment);
    bars_audit.trace('%s вид договора изменен', l_title);

    bars_audit.trace('%s запуск процедуры расчета льгот',
                     l_title);

    dpt_bonus.set_bonus(p_dptid);

    bars_audit.trace('%s льготы рассчитаны', l_title);

  end change_deposit_type;
  -- ======================================================================================
  procedure ivalidate_deposit_accounts(p_rcpacc in dpt_deposit.nls_d%type, -- счет получателя
                                       p_rcpmfo in dpt_deposit.mfo_d%type) -- МФО банка получателя
   is
    l_iscardacc number(1);
  begin

    if (p_rcpacc is not null and p_rcpmfo is null) or
       (p_rcpacc is null and p_rcpmfo is not null) then
      -- некорректно заданы параметры перечисления депозита/процентов (МФО, счет)
      bars_error.raise_nerror(g_modcode,
                              'INVALID_PAYOFF_PARAMS',
                              p_rcpmfo,
                              p_rcpacc);
    end if;

    l_iscardacc := 0;

    -- проверка контр.разряда для (не)карточных счетов
    if (p_rcpacc is not null and l_iscardacc = 0) then
      if p_rcpacc != vkrzn(substr(p_rcpmfo, 1, 5), p_rcpacc) then
        -- ошибка в контр.разряде счета, открытом  в банке с МФО
        bars_error.raise_nerror(g_modcode,
                                'INVALID_PAYOFF_ACCOUNT',
                                p_rcpacc,
                                p_rcpmfo);
      end if;
    end if;

  end ivalidate_deposit_accounts;
  -- ======================================================================================
  --  Изменение параметров выплаты процентов и возврата вклада
  --
  procedure change_deposit_accounts(p_dptid         in dpt_deposit.deposit_id%type,
                                    p_intrcpname    in dpt_deposit.name_p%type,
                                    p_intrcpidcode  in dpt_deposit.okpo_p%type,
                                    p_intrcpacc     in dpt_deposit.nls_p%type,
                                    p_intrcpmfo     in dpt_deposit.mfo_p%type,
                                    p_restrcpname   in dpt_deposit.nms_d%type,
                                    p_restrcpidcode in dpt_deposit.okpo_p%type,
                                    p_restrcpacc    in dpt_deposit.nls_d%type,
                                    p_restrcpmfo    in dpt_deposit.mfo_d%type) is
    title           varchar(60) := 'dptweb.changedepacc:';
    l_mfo           banks.mfo%type := gl.amfo;
    l_dptrow        dpt_deposit%rowtype;
    l_custcode      customer.okpo%type;
    l_custname      customer.nmk%type;
    l_comproc       dpt_vidd.comproc%type;
    l_disabadd      number(1);
    l_accid         accounts.acc%type;
    l_restrcpname   dpt_deposit.nms_d%type;
    l_restrcpidcode dpt_deposit.okpo_p%type;
    l_intrcpacc     dpt_deposit.nls_p%type;
    l_intrcpmfo     dpt_deposit.mfo_p%type;
    l_intrcpname    dpt_deposit.name_p%type;
    l_intrcpidcode  dpt_deposit.okpo_p%type;
  begin

    bars_audit.trace(title ||
                     ' entry, dptid=>%s, intrcp=>(%s,%s,%s,%s), deprcp=>(%s,%s,%s,%s)',
                     to_char(p_dptid),
                     p_restrcpmfo,
                     p_restrcpacc,
                     p_restrcpname,
                     p_restrcpidcode,
                     p_intrcpmfo,
                     p_intrcpacc,
                     p_intrcpname,
                     p_intrcpidcode);

    -- поиск вклада
    begin
      select * into l_dptrow from dpt_deposit where deposit_id = p_dptid;
    exception
      when no_data_found then
        bars_error.raise_nerror(g_modcode, g_dptnotfound, to_char(p_dptid));
    end;

    -- поиск клиента
    begin
      select substr(nmk, 1, 38), okpo
        into l_custname, l_custcode
        from customer
       where rnk = l_dptrow.rnk;
    exception
      when no_data_found then
        bars_error.raise_nerror(g_modcode,
                                g_custnotfound,
                                to_char(p_dptid));
    end;
    bars_audit.trace('%s customer %s (code %s)',
                     title,
                     l_custname,
                     l_custcode);

    -- признак капитализации начисленных процентов на депозитный счет
    begin
      select nvl(comproc, 0), nvl(disable_add, 0)
        into l_comproc, l_disabadd
        from dpt_vidd
       where vidd = l_dptrow.vidd;
    exception
      when no_data_found then
        bars_error.raise_nerror(g_modcode,
                                g_viddnotfound,
                                to_char(l_dptrow.vidd));
    end;
    bars_audit.trace('%s comproc - %s disable_add - %s',
                     title,
                     to_char(l_comproc));

    -- перевірка рах.випл.% для вкладів які не можна поповнювати
    if (l_disabadd = 1 and p_intrcpmfo = l_mfo) then
      begin
        select acc
          into l_accid
          from accounts
         where kv = l_dptrow.kv
           and nls = l_intrcpacc;

        -- якщо асс рах. виплати %% = асс депозитного рахунка
        if l_accid = l_dptrow.acc then
          bars_error.raise_nerror(g_modcode,
                                  'VIDD_NOT_ADD_MORE',
                                  to_char(l_dptrow.vidd));
        end if;
      exception
        when no_data_found then
          null;
      end;
    end if;

    -- для вклада с капитализацией процентов параметры выплаты %% не меняются
    if (l_comproc = 1 and l_dptrow.nls_p is not null) then
      l_intrcpacc    := substr(l_dptrow.nls_p, 1, 14);
      l_intrcpmfo    := substr(l_dptrow.mfo_p, 1, 12);
      l_intrcpname   := substr(l_dptrow.name_p, 1, 38);
      l_intrcpidcode := substr(l_dptrow.okpo_p, 1, 14);
    else
      l_intrcpacc    := substr(p_intrcpacc, 1, 14);
      l_intrcpmfo    := substr(p_intrcpmfo, 1, 12);
      l_intrcpname   := substr(p_intrcpname, 1, 38);
      l_intrcpidcode := substr(p_intrcpidcode, 1, 14);
    end if;

    -- проверяем, изменились ли счета перечисления депозита / процентов
    if (nvl(l_dptrow.name_p, '.') != nvl(p_intrcpname, '.') or
       nvl(l_dptrow.okpo_p, '.') != nvl(p_intrcpidcode, '.') or
       nvl(l_dptrow.nls_p, '.') != nvl(l_intrcpacc, '.') or
       nvl(l_dptrow.mfo_p, '.') != nvl(l_intrcpmfo, '.') or
       nvl(l_dptrow.nms_d, '.') != nvl(p_restrcpname, '.') or
       nvl(l_dptrow.okpo_d, '.') != nvl(p_restrcpidcode, '.') or
       nvl(l_dptrow.nls_d, '.') != nvl(p_restrcpacc, '.') or
       nvl(l_dptrow.mfo_d, '.') != nvl(p_restrcpmfo, '.')) then

      bars_audit.trace('%s int/dep-receipt params has changed', title);

      -- валидация параметров перечисление депозита
      ivalidate_deposit_accounts(p_restrcpacc, p_restrcpmfo);
      bars_audit.trace('%s deposit receipt params succ.checked', title);

      -- валидация параметров выплаты процентов
      ivalidate_deposit_accounts(l_intrcpacc, l_intrcpmfo);
      bars_audit.trace('%s interest receipt params succ.checked', title);

      -- поиск счета для перечисления депозита
      if (p_restrcpacc is not null and p_restrcpmfo = l_mfo) then
        begin
          select acc
            into l_accid
            from accounts
           where nls = p_restrcpacc
             and kv = l_dptrow.kv;
        exception
          when no_data_found then
            -- возможен вариант: счет принадлежит соседнему подразделению нашего МФО
            l_accid := null;
        end;
        bars_audit.trace('deposit receipt account = %s',
                         title,
                         to_char(l_accid));
      end if;

      if (p_restrcpacc is not null) then
        l_restrcpname   := substr(nvl(p_restrcpname, l_custname), 1, 38);
        l_restrcpidcode := substr(nvl(p_restrcpidcode, l_custcode), 1, 14);
      end if;

      if (l_intrcpacc is not null) then
        l_intrcpname   := substr(nvl(l_intrcpname, l_custname), 1, 38);
        l_intrcpidcode := substr(nvl(l_intrcpidcode, l_custcode), 1, 14);
      end if;

      update dpt_deposit
         set mfo_d  = substr(p_restrcpmfo, 1, 12),
             nls_d  = substr(p_restrcpacc, 1, 14),
             nms_d  = substr(l_restrcpname, 1, 38),
             okpo_d = substr(l_restrcpidcode, 1, 14),
             dpt_d  = null,
             acc_d  = l_accid,
             mfo_p  = substr(l_intrcpmfo, 1, 12),
             nls_p  = substr(l_intrcpacc, 1, 14),
             name_p = substr(l_intrcpname, 1, 38),
             okpo_p = substr(l_intrcpidcode, 1, 14)
       where deposit_id = p_dptid;

      if sql%rowcount = 0 then
        bars_error.raise_nerror(g_modcode,
                                'UPD_DEPPAYOFFPARAMS_FAILED',
                                to_char(p_dptid),
                                p_restrcpmfo,
                                p_restrcpacc);
      end if;
      bars_audit.trace('%s depreceipt succ.updated to (%s, %s)',
                       title,
                       p_restrcpmfo,
                       p_restrcpacc);

      update int_accn
         set namb = substr(l_intrcpname, 1, 38),
             nlsb = substr(l_intrcpacc, 1, 14),
             mfob = substr(l_intrcpmfo, 1, 12)
       where acc = l_dptrow.acc
         and id = 1;

      if sql%rowcount = 0 then
        bars_error.raise_nerror(g_modcode,
                                'UPD_INTPAYOFFPARAMS_FAILED',
                                to_char(p_dptid),
                                l_intrcpmfo,
                                l_intrcpacc);
      end if;
      bars_audit.trace('%s intreceipt succ.updated to (%s, %s)',
                       title,
                       l_intrcpmfo,
                       l_intrcpacc);

    else

      bars_audit.trace('%s int/dep-receipt params hasn''t changed', title);

    end if;

    bars_audit.trace('%s exit', title);

  end change_deposit_accounts;

  -- =============================================================================
  --
  --
  procedure p_write_down(p_dptid  in dpt_deposit.deposit_id%type,
                         p_dptsum in number,
                         p_acrsum out number) is
    l_title       varchar2(60) := 'dpt_web.p_write_down: ';
    l_bankdate    fdat.fdat%type := gl.bdate;
    l_penalty     number(38);
    l_commiss     number(38);
    l_commiss2    number(38);
    l_dptrest     number(38);
    l_intrest     number(38);
    l_int2pay_ing number(38);
  begin
    bars_audit.trace('%s договор № %s, сумма снятия = %s',
                     l_title,
                     to_char(p_dptid),
                     to_char(p_dptsum));
    global_penalty(p_dptid       => p_dptid, -- идентификатор договора
                   p_date        => l_bankdate, -- дата снятия (текущая)
                   p_fullpay     => 0, -- 1-расторжение, 0-част.снятие
                   p_amount      => p_dptsum, -- сумма снятия
                   p_mode        => 'RW', -- режим RO - расчет, RW - взыскание
                   p_penalty     => l_penalty, -- сумма штрафа
                   p_commiss     => l_commiss, -- сумма комиссии за РКО
                   p_commiss2    => l_commiss2, -- сумма комиссии за прием ветхих купюр
                   p_dptrest     => l_dptrest, -- сумма депозита к выплате
                   p_intrest     => l_intrest, -- сумма процентов к выплате
                   p_int2pay_ing => l_int2pay_ing); -- shtraf ); -- сумма процентов к выплате

    p_acrsum := l_intrest;
  end p_write_down;

  ---
  -- повертає ставку податку що утримується з нарахованих %%
  ---
  function get_tax_rate return number is
    title      varchar2(60) := 'dpt_web.get_tax_rate: ';
    l_tax_rate number;
  begin

    begin
      l_tax_rate := to_number(getglobaloption('TAX_INT'), '99.9999');
    exception
      when others then
        if (sqlcode = -01722) then
          begin
            bars_audit.info(title ||
                            'не знайдено або вказана невірне значення ставки податку (взято 15% позамовчуванню).');
            l_tax_rate := 0.2;
          end;
        else
          raise;
        end if;
    end;

    return l_tax_rate;

  end get_tax_rate;

  -- ======================================================================================
  --
  --
  function get_decrepit_penya(p_dptid in dpt_deposit.deposit_id%type)
    return number is
    l_amount number;
  begin
    select denom_count -- сумма комиссии за прием ветхих купюр (в копейках)
      into l_amount
      from dpt_agreements
     where dpt_id = p_dptid
       and agrmnt_type = 14 -- ДС о приеме на вклад ветхих купюр
       and agrmnt_state = 1; -- ДС активно
    return l_amount;
  exception
    when no_data_found then
      return 0;
  end get_decrepit_penya;

  -- ======================================================================================
  --
  --
  procedure penalty_payment(p_dptid       in dpt_deposit.deposit_id%type,
                            p_penalty     in number,
                            p_dptrest     out number,
                            p_intrest     out number,
                            p_int2pay_ing out number) is
    l_title    varchar2(60) := 'dpt_web.penalty_payment: ';
    l_mfo      banks.mfo%type := gl.amfo;
    l_bdate    fdat.fdat%type := gl.bdate;
    l_user     staff.id%type := gl.auid;
    l_branch   branch.branch%type := sys_context('bars_context',
                                                 'user_branch');
    l_penalty  number(38);
    l_commiss  number(38);
    l_commiss2 number(38);
    l_nd       dpt_deposit.nd%type;
    l_datz     dpt_deposit.datz%type;
    l_vidd     dpt_deposit.vidd%type;
    l_acc      accounts.acc%type;
    l_acra     accounts.acc%type;
    l_acrb     accounts.acc%type;
    l_accrecd  acc_rec; -- параметры депозитного счета
    l_accrecp  acc_rec; -- параметры счета начисленных %%
    l_accrec7  acc_rec; -- параметры счета процентных расходов
    l_sumn     oper.s%type;
    l_sumnq    oper.s2%type;
    l_sumd     oper.s%type;
    l_sumdq    oper.s2%type;
    l_amountd  accounts.ostc%type;
    l_amountp  accounts.ostc%type;
    l_refn     oper.ref%type;
    l_refd     oper.ref%type;
    l_idupd    dpt_deposit_clos.idupd%type;
    l_errmsg   g_errmsg%type;
    l_errflag  boolean;
  begin

    bars_audit.trace('%s договор № %s, сумма штрафа = %s',
                     l_title,
                     to_char(p_dptid),
                     to_char(p_penalty));

    bars_audit.trace('%s вызов процедуры dpt_web.global_penalty',
                     l_title);

    global_penalty(p_dptid       => p_dptid, -- идентификатор договора
                   p_date        => l_bdate, -- дата снятия (текущая)
                   p_fullpay     => 1, -- 1-расторжение, 0-част.снятие
                   p_amount      => null, -- сумма снятия
                   p_mode        => 'RW', -- режим RO - расчет, RW - взыскание
                   p_penalty     => l_penalty, -- сумма штрафа
                   p_commiss     => l_commiss, -- сумма комиссии за РКО
                   p_commiss2    => l_commiss2, -- сумма комиссии за прием ветхих купюр
                   p_dptrest     => p_dptrest, -- сумма депозита к выплате
                   p_intrest     => p_intrest, -- сумма процентов к выплате
                   p_int2pay_ing => p_int2pay_ing);

    bars_audit.trace('%s сумма депозита к выплате = %s',
                     l_title,
                     to_char(p_dptrest));
    bars_audit.trace('%s сумма процентов к выплате = %s',
                     l_title,
                     to_char(p_intrest));

  end penalty_payment;
  -- ======================================================================================
  procedure change_deposit_owner(p_dptid  in dpt_deposit.deposit_id%type,
                                 p_custid in dpt_deposit.rnk%type) is
    l_title varchar2(60) := 'dpt_web.change_deposit_owner: ';
    l_accd  accounts.acc%type;
    l_accp  accounts.acc%type;
    l_acca  accounts.acc%type;
    l_acct  accounts.acc%type;
    l_kptl  dpt_vidd.comproc%type; -- ознака капіт.%
    ------------------------------
    procedure change_account_owner(p_accid  in accounts.acc%type,
                                   p_custid in accounts.rnk%type) is
    begin
      bars_audit.trace('%s перерегистрация счета acc=%s на клиента № %s',
                       l_title,
                       to_char(p_accid),
                       to_char(p_custid));

      -- перерегистрация счетов
      update accounts
         set rnk = p_custid
       where acc = p_accid
         and dazs is null;

      if sql%rowcount = 0 then
        -- ошибка при перерегистрации счета (acc=%s) на клиента № %s
        bars_error.raise_error(g_modcode,
                               246,
                               to_char(p_accid),
                               to_char(p_custid));
      end if;

      bars_audit.trace('%s счет acc=%s перерегистрирован на клиента № %s',
                       l_title,
                       to_char(p_accid),
                       to_char(p_custid));

    end change_account_owner;

  begin

    bars_audit.trace('%s договор № %s', l_title, to_char(p_dptid));

    -- счета, обслуживающие данный депозитный договор
    begin
      select i.acc,
             i.acra,
             decode(v.bsa, null, null, i.acrb),
             d.acc_d,
             v.comproc
        into l_accd, l_accp, l_acca, l_acct, l_kptl
        from dpt_deposit d, int_accn i, dpt_vidd v
       where d.deposit_id = p_dptid
         and d.vidd = v.vidd
         and d.acc = i.acc
         and i.id = 1;
    exception
      when no_data_found then
        -- не найдены счета, обслуживающие вклад № %s
        bars_error.raise_error(g_modcode, 240, to_char(p_dptid));
    end;
    bars_audit.trace('%s счета по договор № %s = (%s, %s, %s, %s)',
                     l_title,
                     to_char(p_dptid),
                     to_char(l_accd),
                     to_char(l_accp),
                     to_char(l_acca),
                     to_char(l_acct));

    begin
      select acc
        into l_acct
        from accounts
       where acc = l_acct
         and dazs is null
         and rnk = p_custid
         and tip = 'TCH';
    exception
      when no_data_found then
        l_acct := null;
    end;
    bars_audit.trace('%s есть технический счет acc=%s',
                     l_title,
                     to_char(l_acct));

    -- перерегистрация счетов
    change_account_owner(l_accd, p_custid);

    change_account_owner(l_accp, p_custid);

    if l_acca is not null then
      change_account_owner(l_acca, p_custid);
    end if;

    if l_acct is not null then
      change_account_owner(l_acct, p_custid);
    end if;

    bars_audit.trace('%s выполнена перерегистрация счетов по договору № %s',
                     l_title,
                     to_char(p_dptid));

    -- перерегистрация депозита
    -- та оновлення ОКПО рах.для капіт.% в зв'язку із зміною РНК
    update dpt_deposit
       set rnk    = p_custid,
           okpo_p = decode(l_kptl,
                           1,
                           (select okpo from customer where rnk = p_custid),
                           okpo_p)
     where deposit_id = p_dptid;

    if sql%rowcount = 0 then
      -- ошибка при перерегистрации вклада № %s на клиента № %s
      bars_error.raise_error(g_modcode,
                             247,
                             to_char(p_dptid),
                             to_char(p_custid));
    end if;

    bars_audit.trace('%s выполнена перерегистрация договора № %s',
                     l_title,
                     to_char(p_dptid));

  end change_deposit_owner;
  -- ======================================================================================
  procedure create_trustee(p_dptid      in dpt_deposit.deposit_id%type,
                           p_agrmnttype in dpt_vidd_flags.id%type,
                           p_owner      in customer.rnk%type,
                           p_trustee    in customer.rnk%type,
                           p_agrmntnum  in dpt_trustee.add_num%type,
                           p_agrmntdat  in dpt_trustee.add_dat%type,
                           p_initrustid in dpt_trustee.id%type,
                           p_trustid    out dpt_trustee.id%type) is
    l_title    varchar(60) := 'dpt_web.create_trustee: ';
    l_symbtype char(1);
    l_id       dpt_trustee.id%type;
    l_undoid   dpt_trustee.id%type;
    l_active   number(1);
  begin

    bars_audit.trace(l_title ||
                     '№ вклада = %s, тип ДС = %s, ДС № %s от %s',
                     to_char(p_dptid),
                     to_char(p_agrmnttype),
                     p_agrmntnum,
                     to_char(p_agrmntdat, 'DD/MM/YYYY'));

    if p_agrmnttype not in (5, 6, 8, 9, 12, 13, 26, 27) then
      -- Тип указанного ДС (= %s) не является ДС о 3-их лицах
      bars_error.raise_error(g_modcode, 226, to_char(p_agrmnttype));
    end if;

    -- проверка входных параметров не выполняется, так как процедура вызывается из
    -- процедуры create_agreement, в которой все передаваемые параметры проверены.

    -- тип третьего лица
    l_symbtype := case
                    when p_agrmnttype in (5, 6) then
                     'B' -- бенефициар
                    when p_agrmnttype in (8, 9) then
                     'H' -- наследник
                    when p_agrmnttype in (26) then
                     'M' -- розпорядник
                    when p_agrmnttype in (27) then
                     'C' -- малолітня особа
                    else
                     'T' -- доверенное лицо
                  end;

    bars_audit.trace(l_title ||
                     'владелец вклада № %s, рег.№ и тип 3-го лица = %s / %s',
                     to_char(p_owner),
                     to_char(p_trustee),
                     l_symbtype);

    -- идентификатор доп.соглашения о 3-их лицах
    select bars_sqnc.get_nextval('S_DPT_TRUSTEE') into l_id from dual;
    bars_audit.trace(l_title || 'идентификатор ДС = ' || to_char(l_id));

    -- делегирование/аннулирование ДС
    if p_agrmnttype in (5, 8, 12, 26, 27) then
      l_active := 1;
      l_undoid := null;
    else
      l_active := 0;
      begin
        select id
          into l_undoid
          from dpt_trustee
         where dpt_id = p_dptid
           and rnk = p_owner
           and rnk_tr = p_trustee
           and typ_tr = l_symbtype
           and fl_act = 1
           and undo_id is null
           and id = p_initrustid;
      exception
        when no_data_found then
          -- Отсутствует активное ДС для 3-го №%s по договору %s
          bars_error.raise_error(g_modcode,
                                 227,
                                 to_char(p_initrustid),
                                 to_char(p_dptid));
      end;
    end if;

    begin
      insert into dpt_trustee
        (id,
         dpt_id,
         rnk,
         typ_tr,
         rnk_tr,
         add_num,
         add_dat,
         fl_act,
         undo_id)
      values
        (l_id,
         p_dptid,
         p_owner,
         l_symbtype,
         p_trustee,
         p_agrmntnum,
         p_agrmntdat,
         1,
         l_undoid);
    exception
      when others then
        -- Ошибка при записи данных о 3-ем лице: %s
        bars_error.raise_error(g_modcode, 228, substr(sqlerrm, 1, 254));
    end;

    p_trustid := l_id;

    bars_audit.trace(l_title || 'выход из процедуры с параметром = %s',
                     to_char(p_trustid));

  end create_trustee;

  -- ======================================================================================
  --
  --
  procedure create_agreement(p_dptid          in dpt_agreements.dpt_id%type,
                             p_agrmnttype     in dpt_agreements.agrmnt_type%type,
                             p_initcustid     in dpt_deposit.rnk%type, -- РНК инициатора ДС
                             p_trustcustid    in customer.rnk%type, -- РНК 3-ї ососби
                             p_trustid        in dpt_trustee.id%type, --
                             p_transferdpt    in clob, -- параметры возврата депозита
                             p_transferint    in clob, -- параметры выплаты процентов
                             p_amountcash     in dpt_agreements.amount_cash%type, -- сума готівкою (ДУ про зміну суми договору)
                             p_amountcashless in dpt_agreements.amount_cashless%type, -- сума безготівкою (ДУ про зміну суми договору)
                             p_datbegin       in dpt_agreements.date_begin%type,
                             p_datend         in dpt_agreements.date_end%type,
                             p_ratereqid      in dpt_agreements.rate_reqid%type,
                             p_ratevalue      in dpt_agreements.rate_value%type,
                             p_ratedate       in dpt_agreements.rate_date%type,
                             p_denomamount    in dpt_agreements.denom_amount%type,
                             p_denomcount     in dpt_agreements.denom_count%type,
                             p_denomref       in dpt_agreements.denom_ref%type,
                             p_comissref      in dpt_agreements.comiss_ref%type,
                             p_docref         in dpt_agreements.doc_ref%type, -- реф. документу поповнення / частк.зняття (ДУ про зміну суми договору)
                             p_comissreqid    in dpt_agreements.comiss_reqid%type, -- идентификатор запроса на отмену комисии
                             p_agrmntid       out dpt_agreements.agrmnt_id%type, -- идентификатор ДУ
                             p_templateid     in dpt_agreements.template_id%type default null, -- ІД шаблону ДУ
                             p_freq           in dpt_deposit.freq%type default null, -- нова періодичність виплати відсотків
                             p_access_others  in dpt_agrw.value%type default null -- поле інше в шаблоні доступу додугод
                             ) is
    l_title       varchar(60) := 'dpt_web.create_agreement: ';
    l_sysdate     date;
    l_bankdate    date;
    l_branch      branch.branch%type;
    l_dptowner    dpt_deposit.rnk%type;
    l_vidd        dpt_deposit.vidd%type;
    l_currency    dpt_deposit.kv%type;
    l_dptamount   dpt_deposit.limit%type;
    l_datz        dpt_deposit.datz%type;
    l_datb        dpt_deposit.dat_begin%type;
    l_typename    dpt_vidd_flags.name%type;
    l_procname    dpt_vidd_flags.mod_proc%type;
    l_agrmntid    dpt_agreements.agrmnt_id%type;
    l_agrmntnum   dpt_agreements.agrmnt_num%type;
    l_agrmntstate dpt_agreements.agrmnt_state%type;
    l_templateid  dpt_agreements.template_id%type;
    l_trustid     dpt_trustee.id%type;
    l_trustname   customer.nmk%type;
    l_trust       dpt_trustee%rowtype;
    l_amount      dpt_agreements.amount_cash%type;
    l_denompenya  dpt_agreements.denom_count%type;
    l_acrd_int    number(38);
    l_accd        accounts.acc%type;
    l_acci        accounts.acc%type;
    l_acca        accounts.acc%type;
    l_acct        accounts.acc%type;
    l_msg         g_errmsg%type;
    l_cnt         number;
    l_reqstate    dpt_requests.req_state%type;
    l_ratevalue   dpt_req_chgints.reqc_newint%type;
    l_ratebr      dpt_req_chgints.reqc_newbr%type;
    l_ratedate    dpt_req_chgints.reqc_begdate%type;
    l_expdate     dpt_req_chgints.reqc_expdate%type;
    l_op          int_ratn.op%type;
    l_rnk_tr      customer.rnk%type;
    l_arg_id      dpt_agreements.agrmnt_id%type;
    l_commis_req  dpt_requests.req_id%type;
    ----------------------------------
    l_ratn_row int_ratn%rowtype;
    ----------------------------------
    l_dataxml           xmltype;
    l_transferintname   dpt_deposit.name_p%type;
    l_transferintidcode dpt_deposit.okpo_p%type;
    l_transferintacc    dpt_deposit.nls_p%type;
    l_transferintmfo    dpt_deposit.mfo_p%type;
    l_transferintcardn  varchar2(16);
    l_transferdptname   dpt_deposit.nms_d%type;
    l_transferdptidcode dpt_deposit.okpo_p%type;
    l_transferdptacc    dpt_deposit.nls_d%type;
    l_transferdptmfo    dpt_deposit.mfo_d%type;
    l_transferdptcardn  varchar2(16);
    l_wb             dpt_deposit.wb%type;
    l_archdocid      number;
    ----------------------------------
    function get_data_from_xml(p_dataxml xmltype, p_param varchar2)
      return varchar2 is
      l_str   varchar2(254);
      l_value varchar2(254);
    begin

      l_str := '/doc/' || trim(p_param) || '/text()';

      if (p_dataxml.extract(l_str) is not null) then
        l_value := p_dataxml.extract(l_str).getstringval();
      else
        l_value := null;
      end if;

      return l_value;

    end get_data_from_xml;
    ----------------------

  begin

    bars_audit.trace('%s № вклада = %s, тип ДС = %s, реф.комиссии = %s',
                     l_title,
                     to_char(p_dptid),
                     to_char(p_agrmnttype),
                     to_char(p_comissref));

    bars_audit.trace('%s инициатор ДС = %s, 3-е лицо ДС = %s, № ДС о 3-их лицах = %s',
                     l_title,
                     to_char(p_initcustid),
                     to_char(p_trustcustid),
                     to_char(p_trustid));

    -- Вычисление глобальных параметров ДС
    -- и проверка корректности входных параметров для ДС всех типов

    l_sysdate  := sysdate;
    l_bankdate := bankdate;
    l_branch   := sys_context('bars_context', 'user_branch');

    -- идентификатор доп.соглашения
    select bars_sqnc.get_nextval('S_DPT_AGREEMENTS')
      into l_agrmntid
      from dual;

    -- вид вклада и рег.№ клиента-владельца вклада
    begin
      select rnk, vidd, kv, limit, acc, datz, dat_begin, wb
        into l_dptowner,
             l_vidd,
             l_currency,
             l_dptamount,
             l_accd,
             l_datz,
             l_datb,
             l_wb
        from dpt_deposit
       where deposit_id = p_dptid;
    exception
      when no_data_found then
        bars_error.raise_nerror(g_modcode, g_dptnotfound, to_char(p_dptid));
    end;
    bars_audit.trace('%s владелец вклада № %s, вид вклада № %s',
                     l_title,
                     to_char(l_dptowner),
                     to_char(l_vidd));

    if p_initcustid != l_dptowner then
      bars_audit.trace('%s ДС заключается довер.лицом № %s',
                       l_title,
                       to_char(p_initcustid));
    else
      bars_audit.trace('%s ДС заключается владельцем № %s',
                       l_title,
                       to_char(p_initcustid));
    end if;

    -- название типа ДС
    begin
      select name, trim(mod_proc)
        into l_typename, l_procname
        from dpt_vidd_flags
       where id = p_agrmnttype
         and id != 1;
    exception
      when no_data_found then
        if p_agrmnttype = 1 then
          -- Неверно указан тип  ДС = %s
          bars_error.raise_error(g_modcode, 230, to_char(p_agrmnttype));
        else
          --Не найдено ДС с типом № %s
          bars_error.raise_error(g_modcode, 231, to_char(p_agrmnttype));
        end if;
    end;
    bars_audit.trace('%s название ДС = %s', l_title, l_typename);

    -- номер доп.соглашения
    select to_char(nvl(max(agrmnt_num), 0) + 1)
      into l_agrmntnum
      from dpt_agreements
     where dpt_id = p_dptid;

    bars_audit.trace('%s номер ДС = %s', l_title, l_agrmntnum);

    -- шаблон ДС
    if p_templateid is null then
      begin
        select id
          into l_templateid
          from dpt_vidd_scheme
         where vidd = l_vidd
           and flags = p_agrmnttype;
      exception
        when no_data_found then
          -- Не найден шаблон ДС типа %s для вида вклада № %s
          bars_error.raise_error(g_modcode,
                                 232,
                                 to_char(p_agrmnttype),
                                 to_char(l_vidd));
        when too_many_rows then
          -- Невозможно однозначно определить шаблон ДС типа %s для вида вклада № %s
          bars_error.raise_error(g_modcode,
                                 233,
                                 to_char(p_agrmnttype),
                                 to_char(l_vidd));
      end;
    else
      l_templateid := p_templateid;
    end if;

    bars_audit.trace('%s шаблон ДС = %s', l_title, l_templateid);

    -- Обработка ДС всех типов

    if p_agrmnttype in (5, 6, 8, 9, 12, 13, 26, 27) then

      bars_audit.trace('%s ДС о 3-их лицах', l_title);

      -- ФИО 3-го лица
      begin
        select nmk
          into l_trustname
          from customer
         where rnk = p_trustcustid;
      exception
        when no_data_found then
          -- Не найдено довернное лицо с № %s
          bars_error.raise_error(g_modcode, 234, to_char(p_trustcustid));
      end;
      bars_audit.trace('%s ФИО 3-го лица = %s',
                       l_title,
                       l_trustname);

      -- запись инф-ции о 3-ем лице и соответствующем ДС
      create_trustee(p_dptid      => p_dptid,
                     p_agrmnttype => p_agrmnttype,
                     p_owner      => p_initcustid, -- l_dptowner,
                     p_trustee    => p_trustcustid,
                     p_agrmntnum  => l_agrmntnum,
                     p_agrmntdat  => l_bankdate,
                     p_initrustid => p_trustid,
                     p_trustid    => l_trustid);

      bars_audit.trace('%s идентификатор ДС о 3-их лицах = %s',
                       l_title,
                       to_char(l_trustid));

      if (p_agrmnttype = 12) then

        -- Перелік дозволеннх операцій для ДУ про довіреність
        l_denompenya := p_denomcount;

        if (l_denompenya is not null) then

          begin
            for i in 1 .. length(to_char(l_denompenya)) loop
              if (substr(to_char(l_denompenya), -i, 1) = '1') then
                if (i = 1) --для інше заносимо текст
                 then
                  agr_params(l_agrmntid, i, p_access_others);
                else
                  agr_params(l_agrmntid, i, to_char(i));
                end if;
              end if;
            end loop;
          end;

        end if;
      end if;
    elsif p_agrmnttype = 2 then

      bars_audit.trace('%s ДС на изменение суммы вклада: сумма (НАЛ) = %s, сумма (БЕЗНАЛ) = %s',
                       l_title,
                       to_char(p_amountcash),
                       to_char(p_amountcashless));

      l_amount := nvl(p_amountcash, 0) + nvl(p_amountcashless, 0);

      if (p_amountcash * p_amountcashless < 0) or (l_amount = 0) then
        -- Неверно указаны суммы НАЛ = %s и БЕЗНАЛ = %s
        bars_error.raise_error(g_modcode,
                               235,
                               to_char(p_amountcash),
                               to_char(p_amountcashless));
      end if;

      if l_amount > 0 then
        bars_audit.trace('%s сумма пополнения = %s',
                         l_title,
                         to_char(l_amount));
        -- ничего не делаем
      else
        bars_audit.trace('%s сумма част.снятия = %s',
                         l_title,
                         to_char(l_amount));
        l_amount := abs(l_amount);
        -- процедура перерасчета %% при частичном снятии средств со вклада
        p_write_down(p_dptid, l_amount, l_acrd_int);
        l_acrd_int := round(l_acrd_int);
        bars_audit.trace('%s сумма процентов к выплате = %s',
                         l_title,
                         to_char(l_acrd_int));
        -- передаю Володе значение l_acrd_int - для выплаты процентов при част.снятии
      end if;

      -- <<<  3. Додаткова угода про зміну відсоткової ставки по договору >>>
    elsif p_agrmnttype = 3 then

      l_op := null;

      bars_audit.trace('%s Дод.угода на зміну ставки (пакет Ексклюзивний), ставка %s вступає в дію з %s',
                       l_title,
                       to_char(p_ratevalue),
                       to_char(p_ratedate, 'dd/MM/yyyy'));
      -- розрахунок бонусної ставки
      l_ratevalue := dpt_web.get_bonus_rate(p_dptid);

      if (l_ratevalue > 0) then

        begin
          select *
            into l_ratn_row
            from int_ratn
           where acc = l_accd
             and id = 1
             and bdat = l_datb; -- пошук ставки на дату початку дії договору
        exception
          when no_data_found then
            -- якщо догов. пролонгований але % ставка не змінилася
            begin
              select *
                into l_ratn_row
                from int_ratn
               where acc = l_accd
                 and id = 1
                 and bdat = l_datz; -- пошук ставки на дату початку дії договору
            exception
              when no_data_found then
                bars_error.raise_nerror(g_modcode,
                                        'DPT_RATE_NOT FOUND',
                                        to_char(p_ratereqid));
            end;
        end;

        -- якщо фіксована ставка
        if (l_ratn_row.ir is not null) and (l_ratn_row.br is null) then
          l_ratebr := null;
          l_op     := null;

        elsif (l_ratn_row.ir is not null) and (l_ratn_row.br = 0) then
          -- фіксована ставка (збочення ГОУ)
          l_ratebr := null;
          l_op     := null;

          -- якщо базова ставка
        elsif (l_ratn_row.br is not null) and (l_ratn_row.ir is null) then
          l_ratevalue := l_ratevalue - l_ratn_row.ir;
          l_ratebr    := l_ratn_row.br;
          l_op        := 1;

        else
          -- всі інші варіанти
          bars_error.raise_nerror(g_modcode,
                                  'RATE_REVIEW_FAILED',
                                  to_char(p_ratereqid));

        end if;

        -- %% по новій ставці мають нараховуватися з наступного дня, після дня укладення додаткової угоди з клієнтом,
        -- незалежно від того коли було збільшено залишок по вкладу.
        l_ratedate := (l_bankdate + 1);

        bars_audit.trace('%s внутр.№ деп.рах. = %s',
                         l_title,
                         to_char(l_accd));

        begin
          insert into int_ratn
            (acc, id, bdat, ir, br, op)
          values
            (l_accd, 1, l_ratedate, l_ratevalue, l_ratebr, l_op);
        exception
          when dup_val_on_index then
            begin
              update int_ratn
                 set ir = l_ratevalue, br = l_ratebr, op = l_op
               where acc = l_accd
                 and id = 1
                 and bdat = l_ratedate;
            exception
              when others then
                -- невозможно установить новую %-ную ставку по договору (размер, дата)
                bars_error.raise_nerror(g_modcode,
                                        'SET_RATE_FAILED',
                                        to_char(p_dptid),
                                        to_char(l_ratedate, 'DD/MM/YYYY'),
                                        to_char(l_ratebr),
                                        to_char(l_ratevalue));
            end;
            if sql%rowcount = 0 then
              -- невозможно установить новую %-ную ставку по договору (размер, дата)
              bars_error.raise_nerror(g_modcode,
                                      'SET_RATE_FAILED',
                                      to_char(p_dptid),
                                      to_char(l_ratedate, 'DD/MM/YYYY'),
                                      to_char(l_ratebr),
                                      to_char(l_ratevalue));
            end if;
        end;
        bars_audit.trace('%s ставка збережена в БД',
                         l_title);

      end if;

    elsif (p_agrmnttype = 4) then
      -- <<< 4. Додаткова угода про зміну строку договору >>>

      bars_audit.trace('%s ДС на изменение периода действия договора: %s - %s',
                       l_title,
                       to_char(p_datbegin, 'dd/MM/yy'),
                       to_char(p_datend, 'dd/MM/yy'));

      if (p_datbegin is null or p_datend is null or p_datbegin >= p_datend) then
        -- Неверно задан периода действия договора: %s - %s
        bars_error.raise_error(g_modcode,
                               239,
                               to_char(p_datbegin, 'dd/MM/yyyy'),
                               to_char(p_datend, 'dd/MM/yyyy'));
      end if;

      begin
        insert into dpt_extconsent
          (dpt_id, dat_begin, dat_end)
        values
          (p_dptid, p_datbegin, p_datend);
      exception
        when dup_val_on_index then
          bars_error.raise_error(g_modcode, 241, to_char(p_dptid));
      end;

      -- відсоткова ставка на банківську дату зключення ДУ
      l_ratevalue := dpt.f_calc_rate(l_vidd,
                                     0,
                                     0,
                                     fost(l_accd, l_bankdate),
                                     l_bankdate);

      -- l_ratevalue := getbrat( l_bankdate, ext.base_rate, l_currency, l_dptamount);
      -- l_ratedate  := p_datbegin;

      /*  -- счета, обслуживающие данный депозитный договор
          BEGIN
            SELECT i.acc, i.acra, decode(v.bsa, a.nbs, i.acrb, NULL)
              INTO l_accd, l_acci, l_acca
              FROM dpt_deposit d, int_accn i, dpt_vidd v, accounts a
             WHERE d.deposit_id = p_dptid
               AND d.vidd = v.vidd
               AND d.acc = i.acc
               AND i.id = 1
               AND i.acrb = a.acc;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              -- Не найдены счета, обслуживающие вклад № %s
              bars_error.raise_error(g_modcode, 240, to_char(p_dptid));
          END;
          bars_audit.trace('%s счета по вкладу № %s = (%s, %s, %s)', l_title, to_char(p_dptid),
                           to_char(l_accd), to_char(l_acci), to_char(l_acca));

          -- изменение срока действия вклада
          UPDATE dpt_deposit
             SET dat_begin = p_datbegin,
                 dat_end = p_datend
           WHERE deposit_id = p_dptid;
          IF SQL%ROWCOUNT = 0 THEN
             -- Ошибка при изменении срока действия вклада № %s
             bars_error.raise_error(g_modcode, 241, to_char(p_dptid));
          END IF;
          bars_audit.trace('%s изменен срок действия вклада № %s', l_title, to_char(p_dptid));

          -- изменение дат погашения и стоп-дат по начислению процентов по счетам договора
          UPDATE accounts SET mdate = p_datend WHERE acc = l_accd;
          IF SQL%ROWCOUNT = 0 THEN
             -- Ошибка при изменении даты погашения для счета (acc=%s) по вкладу № %s
            bars_error.raise_error(g_modcode, 242, to_char(l_accd), to_char(p_dptid));

          END IF;
          bars_audit.trace('%s изменена дата погашения по счету № %s',l_title, to_char(l_accd));

          UPDATE accounts SET mdate = p_datend WHERE acc = l_acci;
          IF SQL%ROWCOUNT = 0 THEN
             -- Ошибка при изменении даты погашения для счета (acc=%s) по вкладу № %s
             bars_error.raise_error(g_modcode, 242, to_char(l_acci), to_char(p_dptid));
          END IF;
          bars_audit.trace('%s изменена дата погашения по счету № %s', l_title, to_char(l_acci));

          UPDATE int_accn SET stp_dat = p_datend - 1 WHERE id = 1 AND acc = l_accd;
          IF SQL%ROWCOUNT = 0 THEN
             -- Ошибка при изменении стоп-даты по начислению для вклада № %s
             bars_error.raise_error(g_modcode, 243,  to_char(p_dptid));
          END IF;
          bars_audit.trace('%s изменена стоп-дата по начислению процентов для счета № %s', l_title, to_char(l_accd));

          IF l_acca IS NOT NULL THEN
             UPDATE accounts SET mdate = p_datend WHERE acc = l_acca;
             IF SQL%ROWCOUNT = 0 THEN
                -- Ошибка при изменении даты погашения для счета (acc=%s) по вкладу № %s
                bars_error.raise_error(g_modcode, 242, to_char(l_acca), to_char(p_dptid));
             END IF;
             bars_audit.trace('%s изменена дата погашения по счету № %s', l_title, to_char(l_acca));

             UPDATE int_accn SET acr_dat = p_datbegin, stp_dat = p_datend WHERE id = 0 AND acc = l_acca;
             IF SQL%ROWCOUNT = 0 THEN
                -- Ошибка при изменении стоп-даты по начислению для вклада № %s
                bars_error.raise_error(g_modcode, 243,  to_char(p_dptid));
             END IF;
             bars_audit.trace('%s изменены даты в процентной карточке счета № %s', l_title, to_char(l_acca));
          END IF;
      */

    elsif p_agrmnttype = 7 then

      bars_audit.trace('%s ДС о вступлении 3-го лица в права вкладчика',
                       l_title);

      l_trustid := p_trustid;
      bars_audit.trace('%s код ДС о 3-их лицах, согласно которому данное дов.лицо вступает в права № %s',
                       l_title,
                       to_char(l_trustid));

      -- параметры ДС, согласно которому 3-е лицо вступает в права
      begin
        select * into l_trust from dpt_trustee where id = l_trustid;
      exception
        when no_data_found then
          -- Не найдено ДС о 3-их лицах № %s
          bars_error.raise_error(g_modcode, 244, to_char(l_trustid));
      end;

      -- ФИО 3-го лица
      begin
        select nmk
          into l_trustname
          from customer
         where rnk = p_trustcustid;
      exception
        when no_data_found then
          -- Не найдено довернное лицо с № %s
          bars_error.raise_error(g_modcode, 234, to_char(p_trustcustid));
      end;
      bars_audit.trace('%s ФИО 3-го лица = %s',
                       l_title,
                       l_trustname);

      l_msg := case
                 when l_trust.dpt_id != p_dptid then
                  '(dpt)'
                 when l_trust.rnk_tr != p_trustcustid then
                  '(trustee)'
                 when l_trust.fl_act != 1 then
                  '(activity)'
                 else
                  ''
               end;
      if l_msg is not null then
        -- Не корректно задан идентификатор ДС о 3-их лицах № %s: %s
        bars_error.raise_error(g_modcode, 245, to_char(l_trustid), l_msg);
      end if;

      -- перерегистрация договора и счетов, обслуживающих данный договор
      change_deposit_owner(p_dptid => p_dptid, p_custid => p_trustcustid);

      bars_audit.trace('%s выполнена перерегистрация договора № %s на клиента № %s',
                       l_title,
                       to_char(p_dptid),
                       to_char(p_trustcustid));

    elsif (p_agrmnttype = 10 or p_agrmnttype = 11 or p_agrmnttype = 20 or
          p_agrmnttype = 34) then

      if p_agrmnttype = 10 then
        bars_audit.trace('%s ДС о перечислении вклада и %% на текущий счет',
                         l_title);
      elsif p_agrmnttype = 11 then
         if (l_wb = 'Y') then
          begin
            l_archdocid :=
             ead_pack.doc_create(p_type_id      => 'DOC',
                                               p_template_id  => 'WB_CHANGE_ACCOUNT',
                                               p_scan_data    => null,
                                               p_ea_struct_id => 543,
                                               p_rnk          => l_dptowner,
                                               p_agr_id       => p_dptid);
            ebp.set_archive_docid(p_dptid, l_archdocid);
--            ead_pack.doc_sign(l_archdocid);
          exception
            when others then
              bars_audit.trace(dbms_utility.format_error_stack() || chr(10) ||
                               dbms_utility.format_error_backtrace());
          end;
        end if;

        bars_audit.trace('%s ДС о перечислении вклада и %% на карточный счет',
                         l_title);
      elsif p_agrmnttype = 20 then
        bars_audit.trace('%s ДС о перечислении вклада и %% на кредитний счет',
                         l_title);
      elsif p_agrmnttype = 34 then
        bars_audit.trace('%s ДС о відмові від перерахування вкладу и %% на карткові/поточні рахунки',
                         l_title);
      end if;

      if (p_agrmnttype != 34) then
        -- реквизиты для перечисления суммы депозита
        l_dataxml           := xmltype(p_transferdpt);
        l_transferdptacc    := get_data_from_xml(l_dataxml, 'nls');
        l_transferdptmfo    := get_data_from_xml(l_dataxml, 'mfo');
        l_transferdptidcode := get_data_from_xml(l_dataxml, 'okpo');
        l_transferdptname   := substr(get_data_from_xml(l_dataxml, 'nmk'),
                                      0,
                                      38); --довжина поля виходила за рамки 38 символів.

        bars_audit.trace('%s реквизиты для виплати вкладу (Mfo=%s, Nls=%s, Nms=%s, IdCode=%s)',
                         l_title,
                         l_transferdptmfo,
                         l_transferdptacc,
                         l_transferdptname,
                         l_transferdptidcode);

        -- реквизиты для выплаты процентов
        l_dataxml           := xmltype(p_transferint);
        l_transferintacc    := get_data_from_xml(l_dataxml, 'nls');
        l_transferintmfo    := get_data_from_xml(l_dataxml, 'mfo');
        l_transferintidcode := get_data_from_xml(l_dataxml, 'okpo');
        l_transferintname   := get_data_from_xml(l_dataxml, 'nmk');
      else
        -- 34 это отказ от выплаты на карту
        l_transferdptacc    := null;
        l_transferdptmfo    := null;
        l_transferdptidcode := null;
        l_transferdptname   := null;
        l_transferintacc    := null;
        l_transferintmfo    := null;
        l_transferintidcode := null;
        l_transferintname   := null;
      end if;

      bars_audit.trace('%s реквизиты для виплати відсотків (Mfo=%s, Nls=%s, Nms=%s, IdCode=%s)',
                       l_title,
                       l_transferintmfo,
                       l_transferintacc,
                       l_transferintname,
                       l_transferintidcode);

      change_deposit_accounts(p_dptid         => p_dptid,
                              p_intrcpname    => l_transferintname,
                              p_intrcpidcode  => l_transferintidcode,
                              p_intrcpacc     => l_transferintacc,
                              p_intrcpmfo     => l_transferintmfo,
                              p_restrcpname   => l_transferdptname,
                              p_restrcpidcode => l_transferdptidcode,
                              p_restrcpacc    => l_transferdptacc,
                              p_restrcpmfo    => l_transferdptmfo);
      --встановлення ознаки Депозит застава по кредиту
      if p_agrmnttype = 20 then

        update dpt_depositw d
           set d.value = to_char(l_transferintacc)
         where dpt_id = p_dptid
           and tag = 'CPAWN';

        if sql%rowcount = 0 then
          insert into dpt_depositw
            (dpt_id, tag, value)
          values
            (p_dptid, 'CPAWN', to_char(l_transferintacc));
        end if;
        --блокування основного рахунку по дебету
        update accounts t1
           set t1.blkd = nvl(trim(getglobaloption('ACC_PAWN')), 90) -- 90 - код блокування ЗАСТАВА
         where acc =
               (select acc from dpt_deposit where deposit_id = p_dptid);

      end if;

      bars_audit.trace('%s изменены реквизиты для  перечисления депозита / выплаты процентов',
                       l_title);

    elsif (p_agrmnttype = 28) then
      bars_audit.trace('%s ДУ про переоформлення депозиту на малолітню особу',
                       l_title);

      bars_audit.info('ДУ про переоформлення депозиту на малолітню особу');

      -- реквизиты для перечисления суммы депозита
      l_dataxml           := xmltype(p_transferdpt);
      l_transferdptacc    := get_data_from_xml(l_dataxml, 'nls');
      l_transferdptmfo    := get_data_from_xml(l_dataxml, 'mfo');
      l_transferdptidcode := get_data_from_xml(l_dataxml, 'okpo');
      l_transferdptname   := substr(get_data_from_xml(l_dataxml, 'nmk'),
                                    0,
                                    38); --довжина поля виходила за рамки 38 символів.

      bars_audit.trace('%s реквизиты для виплати вкладу (Mfo=%s, Nls=%s, Nms=%s, IdCode=%s)',
                       l_title,
                       l_transferdptmfo,
                       l_transferdptacc,
                       l_transferdptname,
                       l_transferdptidcode);

      -- реквизиты для выплаты процентов
      l_dataxml           := xmltype(p_transferint);
      l_transferintacc    := get_data_from_xml(l_dataxml, 'nls');
      l_transferintmfo    := get_data_from_xml(l_dataxml, 'mfo');
      l_transferintidcode := get_data_from_xml(l_dataxml, 'okpo');
      l_transferintname   := get_data_from_xml(l_dataxml, 'nmk');

      bars_audit.trace('%s реквизиты для виплати відсотків (Mfo=%s, Nls=%s, Nms=%s, IdCode=%s)',
                       l_title,
                       l_transferintmfo,
                       l_transferintacc,
                       l_transferintname,
                       l_transferintidcode);

      change_deposit_accounts(p_dptid         => p_dptid,
                              p_intrcpname    => l_transferintname,
                              p_intrcpidcode  => l_transferintidcode,
                              p_intrcpacc     => l_transferintacc,
                              p_intrcpmfo     => l_transferintmfo,
                              p_restrcpname   => l_transferdptname,
                              p_restrcpidcode => l_transferdptidcode,
                              p_restrcpacc    => l_transferdptacc,
                              p_restrcpmfo    => l_transferdptmfo);

      -- перерегистрация депозита
      -- та оновлення ОКПО рах.для капіт.% в зв'язку із зміною РНК
      update dpt_deposit
         set rnk    = p_initcustid,
             okpo_p =
             (select okpo from customer where rnk = p_initcustid)
       where deposit_id = p_dptid;

      if sql%rowcount = 0 then
        -- ошибка при перерегистрации вклада № %s на клиента № %s
        bars_error.raise_error(g_modcode,
                               247,
                               to_char(p_dptid),
                               to_char(p_initcustid));
      end if;

      -- перерегистрация депозита
      update dpt_trustee
         set fl_act = 0
       where dpt_id = p_dptid
         and typ_tr in ('C', 'M');

      bars_audit.trace('%s Власника депозиту змінено на малолітню особу',
                       l_title);

      --оформлення довіреності на розпорядника
      begin
        select rnk_tr
          into l_rnk_tr
          from dpt_trustee
         where dpt_id = p_dptid
           and typ_tr = 'M';

        --створення референсу на відміну комісії

        l_commis_req := dpt_web.create_commis_request(p_dptid, 12);

        dpt_web.create_agreement(p_dptid          => p_dptid,
                                 p_agrmnttype     => 12,
                                 p_initcustid     => p_initcustid,
                                 p_trustcustid    => l_rnk_tr,
                                 p_trustid        => null,
                                 p_transferdpt    => null,
                                 p_transferint    => null,
                                 p_amountcash     => null,
                                 p_amountcashless => null,
                                 p_datbegin       => null,
                                 p_datend         => null,
                                 p_ratereqid      => null,
                                 p_ratevalue      => null,
                                 p_ratedate       => null,
                                 p_denomamount    => null,
                                 p_denomcount     => 1111111,
                                 p_denomref       => null,
                                 p_comissref      => 1,
                                 p_docref         => null,
                                 p_comissreqid    => l_commis_req,
                                 p_agrmntid       => l_arg_id,
                                 p_templateid     => null,
                                 p_freq           => null,
                                 p_access_others  => null);

        l_agrmntnum := l_agrmntnum + 1; --необхідно для запису одразу двох ДУ в одній транзакції
      end;

    elsif (p_agrmnttype = 14) then

      bars_audit.trace('%s ДС о приеме на вклад ветхих купюр, сумма = %s / %s',
                       l_title,
                       to_char(p_denomamount),
                       to_char(l_currency));

      if l_dptamount < p_denomamount then
        -- сумма ветхих купюр превышает сумму договора
        bars_error.raise_nerror(g_modcode, 'INVALID_DENOM_AMOUNT');
      end if;

      bars_audit.trace('%s процедура расчета суммы комиссии = %s',
                       l_title,
                       l_procname);
      l_procname := replace(l_procname, '#(KV)', l_currency);
      l_procname := replace(l_procname, '#(S)', p_denomamount);
      bars_audit.trace('%s процедура расчета суммы комиссии после подстановки = %s',
                       l_title,
                       l_procname);

      if l_procname is null then
        l_denompenya := 0;
      else
        execute immediate 'select ' || l_procname || ' from dual'
          into l_denompenya;
      end if;
      bars_audit.trace('%s сумма комиссии = %s',
                       l_title,
                       to_char(l_denompenya));

      -- зміна істотних умов договору
    elsif (p_agrmnttype = 16) then
      null;

      -- відмова від автопролонгації договору
    elsif (p_agrmnttype = 17) then

     if (l_wb = 'Y') then
      begin
        l_archdocid :=
           ead_pack.doc_create(p_type_id      => 'DOC',
                               p_template_id  => 'WB_DENY_AUTOLONGATION',
                               p_scan_data    => null,
                               p_ea_struct_id => 542,
                               p_rnk          => l_dptowner,
                               p_agr_id       => p_dptid);
            ebp.set_archive_docid(p_dptid, l_archdocid);
--            ead_pack.doc_sign(l_archdocid);
      exception
        when others then
          bars_audit.trace(dbms_utility.format_error_stack() || chr(10) ||
                           dbms_utility.format_error_backtrace());
      end;
    end if;

      bars_audit.trace('%s відмова від автопролонгації договору # %s',
                       l_title,
                       to_char(p_dptid));

      fix_extcancel(p_dptid, 1);

    elsif (p_agrmnttype = 18) then
      -- заява про дострокове повернення депозиту

      bars_audit.trace('%s заява про дострокове повернення депозиту # %s',
                       l_title,
                       to_char(p_dptid));

    elsif (p_agrmnttype = 19) then
      -- ДУ про зміну періодичності виплати відсотків

      bars_audit.trace('%s ДУ про зміну періодичності виплати відсотків депозиту # %s (new freq = %s).',
                       l_title,
                       to_char(p_dptid),
                       to_char(p_freq));

      if (p_freq is null) then

        bars_error.raise_nerror(g_modcode,
                                'GENERAL_ERROR_CODE',
                                'Для ДУ №19 не вказано періодичність випалати відсотків.');

      else
        begin
          update dpt_deposit d
             set d.freq = p_freq,
                 d.vidd =
                 (select max(v1.vidd)
                    from dpt_vidd v1
                    join dpt_vidd v2
                      on (v2.type_id = v1.type_id and v2.bsd = v1.bsd and
                         v2.kv = v1.kv and v2.duration = v1.duration and
                         v2.duration_days = v1.duration_days)
                   where v1.comproc = 0 -- без капіталізації
                        -- AND v1.flag     = 1        -- тільки діючі
                     and v1.freq_k = p_freq -- із вказаною періодичністю
                     and v2.vidd = d.vidd)
           where d.deposit_id = p_dptid
          returning vidd into l_vidd;
        exception
          when others then
            if (sqlcode = -01407) then
              -- cannot update ("BARS"."DPT_DEPOSIT"."VIDD") to NULL
              l_vidd := null;
            else
              raise;
            end if;
        end;

        if (l_vidd is null) then
          bars_error.raise_nerror(g_modcode,
                                  'GENERAL_ERROR_CODE',
                                  'Не знайдено вид депозиту із заданою періодичність випалати відсотків.');
        else
          bars_audit.info(l_title || ' змінено вид депозиту по договору #' ||
                          to_char(p_dptid) || ' на vidd=' || l_vidd || '.');
        end if;

      end if;

    else

      null;

    end if;

    -- Если передан запрос на отмену комиссии
    if (p_comissreqid is not null) then

      if (p_comissreqid = -13) then
        -- открытие ДС во время миграции с АРМа Депозит
        -- не проверяем наличие комисии за оформление ДС или запроса на ее отмену
        null;
      else
        -- Проверяем подтверждение запроса
        if (get_request_state(p_comissreqid) is null or
           get_request_state(p_comissreqid) != request_allowed) then
          bars_error.raise_nerror(g_modcode, cancel_commis_refused);
        end if;
        -- Удаляем активный запрос c договора
        delete_commis_request(p_comissreqid);
      end if;

    else

      -- проверка на обязательность документа комиссии
      if (p_comissref is null) then
        select count(*)
          into l_cnt
          from dpt_vidd_flags
         where id = p_agrmnttype
           and main_tt is not null;

        if (l_cnt > 0) then
          bars_error.raise_nerror(g_modcode, commission_doc_required);
        end if;
      end if;

    end if;

    -- 3. Запись ДС в журнал

    bars_audit.trace('%s идентификатор ДС = %s',
                     l_title,
                     to_char(l_agrmntid));

    l_agrmntstate := 1;

    insert into dpt_agreements
      (agrmnt_id,
       agrmnt_date,
       agrmnt_num,
       agrmnt_type,
       agrmnt_state,
       dpt_id,
       branch,
       cust_id,
       bankdate,
       template_id,
       trustee_id,
       transfer_bank,
       transfer_account,
       amount_cash,
       amount_cashless,
       amount_interest,
       date_begin,
       date_end,
       rate_reqid,
       rate_value,
       rate_date,
       denom_amount,
       denom_count,
       denom_ref,
       comiss_ref,
       comiss_reqid,
       transfdpt,
       transfint,
       doc_ref)
    values
      (l_agrmntid,
       l_sysdate,
       l_agrmntnum,
       p_agrmnttype,
       l_agrmntstate,
       p_dptid,
       l_branch,
       p_initcustid,
       l_bankdate,
       l_templateid,
       l_trustid,
       l_transferdptmfo,
       l_transferdptacc,
       p_amountcash,
       p_amountcashless,
       l_acrd_int,
       p_datbegin,
       p_datend,
       p_ratereqid,
       l_ratevalue,
       p_ratedate,
       p_denomamount,
       l_denompenya,
       p_denomref,
       p_comissref,
       decode(p_comissreqid, -13, null, p_comissreqid),
       p_transferdpt,
       p_transferint,
       p_docref);

    bars_audit.info(l_title || 'создано доп.соглашение № ' ||
                    to_char(l_agrmntnum) || ' к договору № ' ||
                    to_char(p_dptid));

    -- запись в доп.реквизит вклада (временно для Володи)
    update dpt_depositw d
       set d.value = to_char(l_agrmntid)
     where dpt_id = p_dptid
       and tag = 'LSTAG';

    if sql%rowcount = 0 then
      insert into dpt_depositw
        (dpt_id, tag, value)
      values
        (p_dptid, 'LSTAG', to_char(l_agrmntid));
    end if;

    -- 4. Аннулирование предыдущих ДС (при необходимости)
    agreement_termination(p_dptid, p_agrmnttype, l_agrmntid, l_trustid);

    p_agrmntid := l_agrmntid;

    bars_audit.trace('%s выход из процедуры с параметром = %s',
                     l_title,
                     to_char(p_agrmntid));

  end create_agreement;

  -- ======================================================================================
  --
  --
  procedure close_agreement(v_dptid        in dpt_agreements.dpt_id%type,
                            v_agrid        in dpt_agreements.agrmnt_id%type,
                            v_agrnum       in dpt_agreements.agrmnt_num%type,
                            v_new_agrmntid in dpt_agreements.agrmnt_id%type,
                            v_trustid      in dpt_agreements.trustee_id%type) is
    l_title varchar2(60) := 'dpt_web.close_agreement: ';
    l_state dpt_agreements.agrmnt_state%type := 0;
  begin

    bars_audit.trace('%s инициатор закрытия ДС № %s, закрываемое ДС № %s / %s',
                     l_title,
                     to_char(v_new_agrmntid),
                     to_char(v_agrid),
                     to_char(v_trustid));

    if v_trustid is not null then

      update dpt_trustee set fl_act = l_state where id = v_trustid;

      if sql%rowcount = 0 then
        -- ошибка при закрытии ДС о 3-их лицах № %s к депозитному договору № %s
        bars_error.raise_error(g_modcode,
                               g_trusttermveto,
                               to_char(v_agrnum),
                               to_char(v_dptid));
      end if;
      bars_audit.trace('%s закрыто ДС о 3-их лицах № %s',
                       l_title,
                       to_char(v_trustid));

    end if;

    update dpt_agreements
       set agrmnt_state = l_state, undo_id = v_new_agrmntid
     where agrmnt_id = v_agrid;

    if sql%rowcount = 0 then
      -- ошибка при закрытии ДС № %s к депозитному договору № %s
      bars_error.raise_error(g_modcode,
                             g_agrmttermveto,
                             to_char(v_agrnum),
                             to_char(v_dptid));
    end if;
    bars_audit.trace('%s закрыто ДС № %s к договору № %s',
                     l_title,
                     to_char(v_agrnum),
                     to_char(v_dptid));
    close_sto_argmnt(p_dptid    => null,
                     p_accid    => null,
                     p_argmntid => v_agrid);
  end close_agreement;
  -- ======================================================================================
  procedure agreement_termination(p_dptid      in dpt_agreements.dpt_id%type,
                                  p_agrmnttype in dpt_agreements.agrmnt_type%type,
                                  p_agrmntid   in dpt_agreements.agrmnt_id%type,
                                  p_trustid    in dpt_agreements.trustee_id%type) is
    l_title        varchar2(60) := 'dpt_web.agreement_termination: ';
    l_state        dpt_agreements.agrmnt_state%type := 0;
    l_prevtrustid  dpt_trustee.undo_id%type;
    l_prevagrmtid  dpt_agreements.agrmnt_id%type;
    l_prevagrmtnum dpt_agreements.agrmnt_num%type;
    l_dptrow       dpt_deposit%rowtype;
    l_idupd        dpt_techaccounts.dpt_idupd%type;
    l_errmsg       g_errmsg%type;
  begin

    bars_audit.trace('%s договор № %s, тип ДС = %s, № ДС = %s, № ДС о 3-их лицах = %s',
                     l_title,
                     to_char(p_dptid),
                     to_char(p_agrmnttype),
                     to_char(p_agrmntid),
                     to_char(p_trustid));

    if p_agrmnttype = 7 then

      bars_audit.trace('%s ДС о вступлении в права',
                       l_title);

      -- аннулирование всех действующих ДС о 3-их лицах
      for prev7 in (select agrmnt_id, agrmnt_num, trustee_id
                      from dpt_agreements
                     where dpt_id = p_dptid
                       and agrmnt_id != p_agrmntid
                       and agrmnt_state = 1
                       and trustee_id is not null
                     order by 1) loop

        bars_audit.trace('%s ДС № %s / %s',
                         l_title,
                         to_char(prev7.agrmnt_id),
                         to_char(prev7.trustee_id));

        begin
          close_agreement(p_dptid,
                          prev7.agrmnt_id,
                          prev7.agrmnt_num,
                          p_agrmntid,
                          prev7.trustee_id);
          bars_audit.info(l_title || 'закрыто ДС № ' ||
                          to_char(prev7.agrmnt_num) || ' к договору № ' ||
                          to_char(p_dptid));
        exception
          when bars_error.err then
            l_errmsg := sqlerrm;
            if bars_error.get_nerror_code(l_errmsg) =
               g_modcode || '-' || g_agrmttermveto then
              bars_error.raise_nerror(g_modcode, g_agrmttermveto, l_errmsg);
            elsif bars_error.get_nerror_code(l_errmsg) =
                  g_modcode || '-' || g_trusttermveto then
              bars_error.raise_nerror(g_modcode, g_trusttermveto, l_errmsg);
            else
              raise;
            end if;
        end;

      end loop; -- prev7

      -- если есть технический счет, то он перемещается в dpt_techaccounts
      -- SELECT * INTO l_dptrow FROM dpt_deposit WHERE deposit_id = p_dptid;

      -- очистка параметров выплаты процентов и возврата депозита
      change_deposit_accounts(p_dptid         => p_dptid,
                              p_intrcpname    => null,
                              p_intrcpidcode  => null,
                              p_intrcpacc     => null,
                              p_intrcpmfo     => null,
                              p_restrcpname   => null,
                              p_restrcpidcode => null,
                              p_restrcpacc    => null,
                              p_restrcpmfo    => null);
      bars_audit.trace('%s обнулены параметров выплаты процентов и возврата депозита',
                       l_title);

    elsif p_trustid is not null then

      bars_audit.trace('%s ДС о 3-их лицах', l_title);

      -- закрытие того ДС, которое было аннулировано данным  ДС
      begin
        select t.undo_id, p.agrmnt_id, p.agrmnt_num
          into l_prevtrustid, l_prevagrmtid, l_prevagrmtnum
          from dpt_agreements a, dpt_trustee t, dpt_agreements p
         where a.agrmnt_id = p_agrmntid
           and t.id = p_trustid
           and t.undo_id = p.trustee_id;

        bars_audit.trace('%s ДС № %s / %s',
                         l_title,
                         to_char(l_prevagrmtid),
                         to_char(l_prevtrustid));

        begin
          close_agreement(p_dptid,
                          l_prevagrmtid,
                          l_prevagrmtnum,
                          p_agrmntid,
                          l_prevtrustid);
          bars_audit.info(l_title || 'закрыто ДС № ' ||
                          to_char(l_prevagrmtnum) || ' к договору № ' ||
                          to_char(p_dptid));
        exception
          when bars_error.err then
            l_errmsg := sqlerrm;
            if bars_error.get_nerror_code(l_errmsg) =
               g_modcode || '-' || g_agrmttermveto then
              bars_error.raise_nerror(g_modcode, g_agrmttermveto, l_errmsg);
            elsif bars_error.get_nerror_code(l_errmsg) =
                  g_modcode || '-' || g_trusttermveto then
              bars_error.raise_nerror(g_modcode, g_trusttermveto, l_errmsg);
            else
              raise;
            end if;
        end;

      exception
        when no_data_found then
          -- данное ДС делегирует права 3-им лицам -> ничего не закрываем
          null;
      end;

    else

      bars_audit.trace('%s ДС об изменении параметров договора',
                       l_title);

      for prev in (select agrmnt_id, agrmnt_num
                     from dpt_agreements
                    where dpt_id = p_dptid
                      and agrmnt_id != p_agrmntid
                      and agrmnt_state != l_state
                      and agrmnt_type = p_agrmnttype
                      and p_agrmnttype not in (10, 11, 25)
                   union all
                   select agrmnt_id, agrmnt_num
                     from dpt_agreements -- перечисление на карт/текущий счет
                    where dpt_id = p_dptid
                      and agrmnt_id != p_agrmntid
                      and agrmnt_state != l_state
                      and p_agrmnttype in (10, 11)
                      and agrmnt_type in (10, 11)
                    order by 1) loop

        bars_audit.trace('%s ДС № %s', l_title, to_char(prev.agrmnt_id));

        begin
          close_agreement(p_dptid,
                          prev.agrmnt_id,
                          prev.agrmnt_num,
                          p_agrmntid,
                          null);
          bars_audit.info(l_title || 'закрыто ДС № ' ||
                          to_char(prev.agrmnt_num) || ' к договору № ' ||
                          to_char(p_dptid));
        exception
          when bars_error.err then
            l_errmsg := sqlerrm;
            if bars_error.get_nerror_code(l_errmsg) =
               g_modcode || '-' || g_agrmttermveto then
              bars_error.raise_nerror(g_modcode, g_agrmttermveto, l_errmsg);
            else
              raise;
            end if;
        end;

      end loop; -- prev

    end if;

  end agreement_termination;
  -- ======================================================================================
  function f_tarif_agreement(p_dptid    dpt_deposit.deposit_id%type,
                             p_tarifid  tarif.kod%type,
                             p_tarifid2 tarif.kod%type) return number is
    -- сумма комиссии за изготовление ДС - пока криво
    -- сумма комисси зависит от остатка на депозитном счете
    l_title  varchar2(60) := 'dpt_web.f_tarif_agreement: ';
    l_nls    accounts.nls%type;
    l_kv     accounts.kv%type;
    l_saldo  accounts.ostc%type;
    l_tarif  tarif.kod%type;
    l_amount number(38);
  begin

    bars_audit.trace(l_title || 'договор № %s, тариф № %s (№ %s)',
                     to_char(p_dptid),
                     to_char(p_tarifid),
                     to_char(p_tarifid2));

    -- параметры вклада
    begin
      select a.nls, a.kv, decode(a.ostc, 0, a.ostb, a.ostc)
        into l_nls, l_kv, l_saldo
        from dpt_deposit d, accounts a
       where d.acc = a.acc
         and d.deposit_id = p_dptid;
    exception
      when no_data_found then
        bars_error.raise_error(g_modcode, g_dptnotfound, to_char(p_dptid));
    end;

    bars_audit.trace(l_title || 'текущий остаток на счете %s = %s',
                     l_nls || '/' || to_char(l_kv),
                     to_char(l_saldo));

    -- по какому тарифу работаем
    l_tarif := case
                 when (l_kv = 980 and l_saldo > 2000000) then
                  p_tarifid2
                 when (l_kv = 840 and l_saldo > 1000000) then
                  p_tarifid2
                 when (l_kv = 978 and l_saldo > 500000) then
                  p_tarifid2
                 else
                  p_tarifid
               end;
    bars_audit.trace(l_title || 'тариф = %s', to_char(l_tarif));

    begin
      l_amount := f_tarif(l_tarif, 980, l_nls, l_saldo);
    exception
      when others then
        bars_error.raise_error(g_modcode,
                               250,
                               to_char(l_tarif),
                               l_nls,
                               to_char(l_kv));
    end;
    bars_audit.trace(l_title || 'сумма комиссии = %s',
                     to_char(l_amount));

    return l_amount;

  end f_tarif_agreement;

  -- ======================================================================================
  --
  -- ======================================================================================
  procedure p_reverse_agrement(p_agr_id in dpt_agreements.agrmnt_id%type) is
    l_title      varchar2(60) := 'dpt_web.p_reverse_agrement: ';
    l_dpt_id     dpt_deposit.deposit_id%type;
    l_agr_type   dpt_agreements.agrmnt_type%type;
    l_agr_state  dpt_agreements.agrmnt_state%type;
    l_amount     dpt_agreements.amount_cash%type;
    l_trustee_id dpt_trustee.id%type;
    l_dptowner   customer.rnk%type;
    l_rnk        customer.rnk%type;
    r_agr_id     dpt_agreements.agrmnt_id%type;
    r_trustee_id dpt_trustee.id%type;
    r_agr_num    dpt_agreements.agrmnt_num%type;
    r_agr_date   dpt_agreements.agrmnt_date%type;
    l_accd       accounts.acc%type;
    l_acci       accounts.acc%type;
    l_acca       accounts.acc%type;
    l_acct       accounts.acc%type;
    ----------------------------------
    l_dataxml           xmltype;
    r_transfdpt         dpt_agreements.transfdpt%type;
    r_transfint         dpt_agreements.transfint%type;
    l_transferintname   dpt_deposit.name_p%type;
    l_transferintidcode dpt_deposit.okpo_p%type;
    l_transferintacc    dpt_deposit.nls_p%type;
    l_transferintmfo    dpt_deposit.mfo_p%type;
    l_transferdptname   dpt_deposit.nms_d%type;
    l_transferdptidcode dpt_deposit.okpo_p%type;
    l_transferdptacc    dpt_deposit.nls_d%type;
    l_transferdptmfo    dpt_deposit.mfo_d%type;
    -------------------------------------------
    indataclob clob;
    outdataxml clob;
    p_reasonid number := 14;
    l_numpar   number;
    l_strpar   varchar2(254);
    --------------------------
    procedure reverse_allowed(p_agrid dpt_agreements.agrmnt_id%type) is
      l_agrec   dpt_agreements%rowtype;
      l_amount  number;
      l_cntdocs number;
      l_allow   char(1);
      l_reason  varchar2(100);
    begin

      l_allow := 'Y';

      select * into l_agrec from dpt_agreements where agrmnt_id = p_agrid;

      l_amount := nvl(l_agrec.amount_cash, 0) +
                  nvl(l_agrec.amount_cashless, 0);

      case
        when (l_agrec.agrmnt_state != 1) then
          -- ДС закрыто
          l_allow  := 'N';
          l_reason := 'ДУ не активна/закрита';

        when (l_agrec.bankdate != gl.bdate and
             l_agrec.agrmnt_type not in (17, 25)) then
          -- "несвежее" ДС
          l_allow  := 'N';
          l_reason := 'сторнування дозволено лише в день заключення ДУ';

        when (l_agrec.agrmnt_type = 3) then
          -- изменение процентной ставки
          l_allow  := 'N';
          l_reason := 'заборонено сторнуваня ДУ про зміну відсоткової ставки';

        when (l_agrec.agrmnt_type = 2 and l_amount <= 0) then
          -- частичное снятие
          l_allow  := 'N';
          l_reason := 'заборонено сторнуваня ДУ про зміну суми депозиту';

        else

          select count(*)
            into l_cntdocs
            from oper
           where sos = 5
             and ref in (select comiss_ref
                           from dpt_agreements
                          where agrmnt_id = p_agrid
                            and comiss_ref is not null
                         union all
                         select doc_ref
                           from dpt_agreements
                          where agrmnt_id = p_agrid
                            and doc_ref is not null);

          if (l_cntdocs > 0) then
            l_allow  := 'N';
            l_reason := 'знайдено ' || to_char(l_cntdocs) ||
                        ' оплачених документів';
          end if;

      end case;

      if (l_allow = 'N') then
        -- Неможливо сторнувати додаткову угоду № ... від ... до договору № ... (...)
        bars_error.raise_nerror(g_modcode,
                                'CANT_REVERSE_AGREEMENT',
                                to_char(l_agrec.agrmnt_num),
                                to_char(l_agrec.agrmnt_date, 'DD/MM/YYYY'),
                                to_char(l_agrec.dpt_id),
                                l_reason);
      end if;

    end reverse_allowed;
    --------------------------
    function get_data_from_xml(p_dataxml xmltype, p_param varchar2)
      return varchar2 is
      l_str   varchar2(254);
      l_value varchar2(254);
    begin

      l_str := '/doc/' || trim(p_param) || '/text()';

      if (p_dataxml.extract(l_str) is not null) then
        l_value := p_dataxml.extract(l_str).getstringval();
      else
        l_value := null;
      end if;

      return l_value;

    end get_data_from_xml;
    ----------------------------
    procedure activate_agreement(p_dptid  in dpt_agreements.dpt_id%type,
                                 p_agrnum in dpt_agreements.agrmnt_num%type,
                                 p_agrdat in dpt_agreements.agrmnt_date%type,
                                 p_agrid  in dpt_agreements.agrmnt_id%type,
                                 p_trsid  in dpt_trustee.id%type) is
    begin

      if p_trsid is not null then

        update dpt_trustee
           set fl_act = 1, undo_id = null
         where id = p_trsid;
        if sql%rowcount = 0 then
          bars_error.raise_nerror(g_modcode,
                                  'TRUSTEE_NOT_FOUND',
                                  to_char(p_trsid));
        end if;
        bars_audit.trace('%s восстановлено доп.соглашение о 3-их лицах № %s',
                         l_title,
                         to_char(p_trsid));

      end if;

      update dpt_agreements
         set agrmnt_state = 1, undo_id = null
       where agrmnt_id = p_agrid;

      if sql%rowcount = 0 then
        bars_error.raise_nerror(g_modcode,
                                'AGREEMENT_NOT_FOUND',
                                to_char(p_agrid));
      else
        -- возобновление РП (COBUMMFO-4543)
        for rec in (select sd.idd
                      from dpt_agreements da, sto_det_agr a, sto_det sd
                     where da.agrmnt_id = p_agrid
                       and da.agrmnt_id = a.agr_id
                       and a.idd = sd.idd
                       and nvl(sd.status_id, 1) = -1)

         loop
          sto_all.claim_idd(p_idd        => rec.idd,
                            p_statusid   => 0,
                            p_disclaimid => 0);
        end loop;
      end if;
      bars_audit.trace('%s восстановлено доп.соглашение № %s',
                       l_title,
                       to_char(p_agrid));

      bars_audit.info(l_title || ' восстановлено доп.соглашение № ' ||
                      to_char(p_agrnum) || ' от ' ||
                      to_char(p_agrdat, 'DD/MM/YYYY') ||
                      ' к депозитному договору № ' || to_char(p_dptid));

    end activate_agreement;
    ---------------------------
  begin

    bars_audit.trace('%s сторнирование доп.соглашения № %s',
                     l_title,
                     to_char(p_agr_id));

    -- параметры доп.соглашения
    begin
      select agrmnt_type, dpt_id, trustee_id
        into l_agr_type, l_dpt_id, l_trustee_id
        from dpt_agreements
       where agrmnt_id = p_agr_id;
    exception
      when no_data_found then
        bars_error.raise_nerror(g_modcode,
                                'AGREEMENT_NOT_FOUND',
                                to_char(p_agr_id));
    end;

    bars_audit.trace('%s тип ДС %s, договор № %s',
                     l_title,
                     to_char(l_agr_type),
                     to_char(l_dpt_id));

    -- проверка допустимости торнирования ДС
    reverse_allowed(p_agr_id);

    -- ШАГ 1 - предварительные действия

    if (l_agr_type = 2) then

      bars_audit.trace('%s доп.соглашение про пополнение',
                       l_title);

      -- возобновляем все доп.соглашения, отмененные сторнируемым
      for prev_agr in (select agrmnt_id, agrmnt_num, agrmnt_date
                         from dpt_agreements
                        where undo_id = p_agr_id
                          and agrmnt_state = 0) loop
        activate_agreement(p_dptid  => l_dpt_id,
                           p_agrnum => prev_agr.agrmnt_num,
                           p_agrdat => prev_agr.agrmnt_date,
                           p_agrid  => prev_agr.agrmnt_id,
                           p_trsid  => null);
      end loop;
    elsif (l_agr_type = 4) then

      bars_audit.trace('%s дод.угода про пролонгацію вкладу',
                       l_title);

      -- видаляємо відмітку на пролонгацію догоовору
      delete from bars.dpt_extconsent
       where (dpt_id, dat_begin) in
             (select deposit_id, dat_end -- договір ще не пролонгувався по ДУ
                from bars.dpt_deposit
               where deposit_id = l_dpt_id
                 and dat_next_u(dat_end, -5) > glb_bankdate -- ще більше ніж 5 банк.днів до завершення договору
              );

      if (sql%rowcount = 0) then
        -- Дана ДУ вже всупила в дію або сплив термін її стрнування
        bars_error.raise_error(g_modcode, 241, to_char(l_dpt_id));
      else
        bars_audit.trace('%s видалено відмітку на пролонгацію вкладу # %s',
                         l_title,
                         to_char(l_dpt_id));
      end if;

    elsif (l_agr_type in (5, 8, 12)) then

      bars_audit.trace('%s доп.соглашение о правах 3-их лиц',
                       l_title);

      bars_audit.trace('%s доп.соглашение № %s не требует доп.действий',
                       l_title,
                       to_char(p_agr_id));

    elsif (l_agr_type in (6, 9, 13)) then

      bars_audit.trace('%s доп.соглашение об анулировании прав 3-их лиц',
                       l_title);

      -- активируем ДС о правах 3-их лиц, которое было отменено данным доп.соглашением
      begin
        select agrmnt_id, trustee_id, agrmnt_num, agrmnt_date
          into r_agr_id, r_trustee_id, r_agr_num, r_agr_date
          from dpt_agreements
         where undo_id = p_agr_id
           and agrmnt_state = 0;
      exception
        when no_data_found then
          bars_error.raise_nerror(g_modcode,
                                  'INCORRECT_CANCEL_AGREEMENT',
                                  to_char(p_agr_id));
      end;
      bars_audit.trace('%s первичное доп.соглашение о правах 3-их лиц № %s',
                       l_title,
                       to_char(r_agr_id));

      activate_agreement(p_dptid  => l_dpt_id,
                         p_agrnum => r_agr_num,
                         p_agrdat => r_agr_date,
                         p_agrid  => r_agr_id,
                         p_trsid  => r_trustee_id);

    elsif (l_agr_type = 7) then

      bars_audit.trace('%s доп.соглашение о вступление в права',
                       l_title);

      -- текущий владелец договора
      select rnk
        into l_dptowner
        from dpt_deposit
       where deposit_id = l_dpt_id;
      bars_audit.trace('%s текущий владелец договора - %s',
                       l_title,
                       to_char(l_dptowner));

      -- поиск предыдущего владельца договора
      begin
        select t.rnk_tr
          into l_rnk
          from dpt_agreements d, dpt_trustee t
         where d.undo_id = p_agr_id
           and d.agrmnt_state = 0
           and d.agrmnt_type = 7
           and d.trustee_id = t.id;
      exception
        when no_data_found then
          select rnk
            into l_rnk
            from dpt_deposit_clos
           where deposit_id = l_dpt_id
             and action_id = 0;
      end;
      bars_audit.trace('%s предыдущий владелец договора - %s',
                       l_title,
                       to_char(l_rnk));

      -- перерегистрация договора и счетов, обслуживающих данный договор
      change_deposit_owner(p_dptid => l_dpt_id, p_custid => l_rnk);

      bars_audit.trace('%s выполнена перерегистрация договора № %s с клиента № %s на клиента № %s',
                       l_title,
                       to_char(l_dpt_id),
                       to_char(l_dptowner),
                       to_char(l_rnk));

      -- восстановление всех ДС о 3-их лицах, которые были закрыты данным соглашением
      for prev7 in (select agrmnt_id, trustee_id, agrmnt_num, agrmnt_date
                      from dpt_agreements
                     where dpt_id = l_dpt_id
                       and agrmnt_id != p_agr_id
                       and agrmnt_state = 0
                       and trustee_id is not null
                       and undo_id = p_agr_id
                     order by 1) loop
        activate_agreement(p_dptid  => l_dpt_id,
                           p_agrnum => prev7.agrmnt_num,
                           p_agrdat => prev7.agrmnt_date,
                           p_agrid  => prev7.agrmnt_id,
                           p_trsid  => prev7.trustee_id);
      end loop;

    elsif (l_agr_type = 20) then
      --якщо сторнується ДУ про внесення депозиту в заставу по кредиту - знімаємо ознаку та блокування рахунку

      update dpt_depositw t1
         set t1.value = null
       where t1.dpt_id = l_dpt_id
         and t1.tag = 'CPAWN';

      --зняття блокування основного рахунку по дебету
      update accounts t1
         set t1.blkd = 0
       where t1.acc =
             (select acc from dpt_deposit where deposit_id = l_dpt_id);

    elsif (l_agr_type in (10, 11)) then

      bars_audit.trace('%s доп.соглашение о перечислении на текущий / карт.счет',
                       l_title);

      -- поиск предыдущего доп.соглашения,которое было отменено днным доп.соглашением
      begin
        select agrmnt_id, agrmnt_num, agrmnt_date, transfdpt, transfint
          into r_agr_id, r_agr_num, r_agr_date, r_transfdpt, r_transfint
          from dpt_agreements
         where undo_id = p_agr_id
           and agrmnt_type in (10, 11)
           and agrmnt_state = 0;

        activate_agreement(p_dptid  => l_dpt_id,
                           p_agrnum => r_agr_num,
                           p_agrdat => r_agr_date,
                           p_agrid  => r_agr_id,
                           p_trsid  => null);

        -- реквизиты для перечисления суммы депозита
        l_dataxml           := xmltype(r_transfdpt);
        l_transferdptacc    := get_data_from_xml(l_dataxml, 'nls');
        l_transferdptmfo    := get_data_from_xml(l_dataxml, 'mfo');
        l_transferdptidcode := get_data_from_xml(l_dataxml, 'okpo');
        l_transferdptname   := get_data_from_xml(l_dataxml, 'nmk');

        bars_audit.trace('%s реквизиты для перечисления суммы депозита ' ||
                         '(МФО, счет, наименование, код ОКПО) = (%s,%s,%s,%s)',
                         l_title,
                         l_transferdptmfo,
                         l_transferdptacc,
                         l_transferdptname,
                         l_transferdptidcode);

        -- реквизиты для выплаты процентов
        l_dataxml           := xmltype(r_transfint);
        l_transferintacc    := get_data_from_xml(l_dataxml, 'nls');
        l_transferintmfo    := get_data_from_xml(l_dataxml, 'mfo');
        l_transferintidcode := get_data_from_xml(l_dataxml, 'okpo');
        l_transferintname   := get_data_from_xml(l_dataxml, 'nmk');

        bars_audit.trace('%s реквизиты для выплаты процентов ' ||
                         '(МФО, счет, наименование, код ОКПО) = (%s,%s,%s,%s)',
                         l_title,
                         l_transferintmfo,
                         l_transferintacc,
                         l_transferintname,
                         l_transferintidcode);

      exception
        when no_data_found then
          bars_audit.trace('%s данное ДС-первое, реквизиты берем из карточки договора',
                           l_title);
          select mfo_d, nls_d, okpo_d, nms_d, mfo_p, nls_p, okpo_p, name_p
            into l_transferdptmfo,
                 l_transferdptacc,
                 l_transferdptidcode,
                 l_transferdptname,
                 l_transferintmfo,
                 l_transferintacc,
                 l_transferintidcode,
                 l_transferintname
            from dpt_deposit_clos
           where deposit_id = l_dpt_id
             and action_id = 0;
      end;

      change_deposit_accounts(p_dptid         => l_dpt_id,
                              p_intrcpname    => l_transferintname,
                              p_intrcpidcode  => l_transferintidcode,
                              p_intrcpacc     => l_transferintacc,
                              p_intrcpmfo     => l_transferintmfo,
                              p_restrcpname   => l_transferdptname,
                              p_restrcpidcode => l_transferdptidcode,
                              p_restrcpacc    => l_transferdptacc,
                              p_restrcpmfo    => l_transferdptmfo);

      bars_audit.trace('%s изменены реквизиты для перечисления депозита / выплаты процентов',
                       l_title);

    elsif l_agr_type = 17 then
      bars_audit.trace('%s доп.соглашение об отказе от автопролонгации',
                       l_title);

      verify_extcancel(p_dptid  => l_dpt_id, -- идентификатор вклада
                       p_state  => -1, -- статус (1=виза, -1=сторно)
                       p_reason => 'сторнирование ДУ 17');

    end if;

    -- ШАГ 2 - сторнирование документов

    for doc in (select o.ref ref, o.sos, o.nextvisagrp grp
                  from dpt_agreements d, oper o
                 where d.agrmnt_id = p_agr_id
                   and d.comiss_ref = o.ref
                   and o.sos > 0
                union all
                select o.ref ref, o.sos, o.nextvisagrp grp
                  from dpt_agreements d, oper o
                 where d.agrmnt_id = p_agr_id
                   and d.doc_ref = o.ref
                   and o.sos > 0) loop

      bars_audit.trace('%s документ № %s, статус - %s',
                       l_title,
                       to_char(doc.ref),
                       to_char(doc.sos));

      kill_dpt_payments(p_dptid     => l_dpt_id,
                        p_ref       => doc.ref,
                        p_docstatus => 3, --  плановые + форвардные
                        p_reasonid  => 14,
                        p_levelid   => 3,
                        p_fullback  => 1,
                        p_novisa    => 0);
      bars_audit.trace('%s сторнирован документ № %s',
                       l_title,
                       to_char(doc.ref));

    end loop;

    -- ШАГ 3 - сторнирование доп.соглашения

    if ((l_trustee_id is not null) and (l_agr_type != 7)) then

      update dpt_trustee
         set fl_act = -1, undo_id = null
       where id = l_trustee_id;

      if (sql%rowcount = 0) then
        bars_error.raise_nerror(g_modcode,
                                'INCORRECT_CANCEL_AGREEMENT',
                                to_char(p_agr_id));
      end if;

    end if;

    update dpt_agreements set agrmnt_state = -1 where agrmnt_id = p_agr_id;

    if sql%rowcount = 0 then
      bars_error.raise_nerror(g_modcode,
                              'AGREEMENT_NOT_FOUND',
                              to_char(p_agr_id));

    else

      -- ШАГ 4 - сторнирование РП (COBUMMFO-4543)
      for rec in (select sd.idd
                    from dpt_agreements da, sto_det_agr a, sto_det sd
                   where da.agrmnt_id = p_agr_id
                     and da.agrmnt_id = a.agr_id
                     and a.idd = sd.idd
                     and nvl(sd.status_id, 1) <> -1)

       loop
        sto_all.claim_idd(p_idd        => rec.idd,
                          p_statusid   => -1,
                          p_disclaimid => 2);
      end loop;

    end if;

    bars_audit.trace('%s выполнена процедура сторнирования доп.соглашения № %s',
                     l_title,
                     to_char(p_agr_id));

  end p_reverse_agrement;

  -- ======================================================================================
  --
  --
  procedure auto_close_blank_deposit(p_dptid  dpt_deposit.deposit_id%type,
                                     p_runid  dpt_jobs_jrnl.run_id%type,
                                     p_branch branch.branch%type,
                                     p_bdate  fdat.fdat%type) is
    title constant varchar2(60) := 'dptweb.autoclosblank:';
    l_allow  number(1);
    l_dat1   date;
    l_dat2   date;
    l_days   pls_integer;
    l_amount number(38);
    l_accd2  int_accn.acc%type;
    l_accn2  int_accn.acra%type;
    l_error exception;
  begin

    bars_audit.trace('%s branch=>%s, bdate=>%s, runid=>%s, dptid=>%s',
                     title,
                     p_branch,
                     to_char(p_bdate, 'dd.mm.yy'),
                     to_char(p_runid),
                     to_char(p_dptid));

    if (nvl(p_runid, 0) = 0 and p_dptid = 0) then
      bars_error.raise_nerror(g_modcode, g_jobrunidnotfound);
    end if;

    if p_dptid = 0 then
      bars_audit.info(bars_msg.get_msg(g_modcode,
                                       'AUTOCLOSBLANK_ENTRY',
                                       p_branch));
    end if;

    -- кількість днів протягом яких не закривається вклад відкритий безготівково
    l_days := f_get_params('DPT_DELAY_CLOSE', 1);

    -- отсекаем все вклады, по деп.счетам которых не было ни одного движения
    for d in (select /* весь депозитный портфель*/
               d.deposit_id,
               d.nd,
               d.rnk,
               d.kv,
               d.dat_begin,
               a.nls nls,
               d.acc accd,
               i.acra accn,
               decode(v.bsa, null, null, i.acrb) acca,
               nvl(dpt.f_dptw(d.deposit_id, 'NCASH'), 0) ncash,
               d.dpt_d,
               d.vidd
                from dpt_deposit d, accounts a, int_accn i, dpt_vidd v
               where d.vidd = v.vidd
                 and d.acc = a.acc
                 and a.acc = i.acc
                 and i.id = 1
                 and d.dat_begin < p_bdate
                 and a.daos < p_bdate -- для депозитів відкритих у вихідні
                 and acc_closing_permitted(a.acc, 0) = 1
                 and acc_closing_permitted(i.acra, 0) = 1
                 and d.dat_end is not null
                 and a.nbs != '2620'
                 and d.branch = p_branch
                 and p_dptid = 0
                 and dpt_closing_permitted(d.deposit_id) = 1
              union all
              select /* заданный депозитный договор*/
               d.deposit_id,
               d.nd,
               d.rnk,
               d.kv,
               d.dat_begin,
               a.nls nls,
               d.acc accd,
               i.acra accn,
               decode(v.bsa, null, null, i.acrb) acca,
               nvl(dpt.f_dptw(d.deposit_id, 'NCASH'), 0) ncash,
               d.dpt_d,
               d.vidd
                from dpt_deposit d, accounts a, int_accn i, dpt_vidd v
               where d.vidd = v.vidd
                 and d.acc = a.acc
                 and a.acc = i.acc
                 and i.id = 1
                 and d.dat_begin < p_bdate
                 and a.daos < p_bdate
                 and acc_closing_permitted(a.acc, 0) = 1
                 and acc_closing_permitted(i.acra, 0) = 1
                 and a.nbs != '2620'
                 and d.dat_end is not null
                 and d.branch = p_branch
                 and d.deposit_id = p_dptid
                 and p_dptid != 0
                 and dpt_closing_permitted(d.deposit_id) = 1
               order by 1) loop
      bars_audit.trace('%s deposit № %s', title, to_char(d.deposit_id));

      l_allow := 0; -- = 0 - закрытие НЕ допустимо, = 1 - закрытие допустимо

      l_dat1 := d.dat_begin;

      if d.ncash = 0 then
        -- наличные вклады д.б. пополнены в день открытия
        l_dat2 := d.dat_begin;
      else

        -- безнал.вклады д.б.пополнены не позже след.рабочего дня
        begin
          l_dat2 := dat_next_u(d.dat_begin, l_days);
        exception
          when others then
            l_dat2 := (l_dat1 + l_days);
            bars_audit.error(title || ' dat_begin=' ||
                             to_char(d.dat_begin, 'dd.mm.yyyy') ||
                             ', l_days=' || to_char(l_days) ||
                             dbms_utility.format_error_stack() || chr(10) ||
                             dbms_utility.format_error_backtrace());
        end;

        -- вид депозиту "Майбутнє дітям"
        if (d.vidd in (53, 14)) then

          begin
            select add_months(bday, 12)
              into l_dat2
              from person
             where rnk = d.rnk
               and bday is not null;
          exception
            when no_data_found then
              -- якщо невказана дата народження клієнта - закриваєм через рік після відкриття
              l_dat2 := add_months(d.dat_begin, 12);
          end;

        end if;

      end if;

      bars_audit.trace('%s l_dat1 = %s, l_dat2 = %s.',
                       title,
                       to_char(l_dat1, 'dd.mm.yyyy'),
                       to_char(l_dat2, 'dd.mm.yyyy'));

      -- Можно закрывать:
      -- НАЛ: если в дату открытия не был пополнен деп.счет  (dat1 = dat2 < p_dat)
      -- БЕЗНАЛ: якщо за [l_days] банківських дні не було поповнено деп.счет (dat1 < dat2 < p_dat)

      if l_dat2 < p_bdate then

        -- сумма всех поступлений за период
        select nvl(sum(kos), 0)
          into l_amount
          from saldoa
         where acc = d.accd
           and fdat between l_dat1 and l_dat2;
        bars_audit.trace('%s total credit amount = %s',
                         title,
                         to_char(l_amount));

        -- больше ничего не проверяем
        -- если не было поступлений, то не было и начисления/амортизации %%.
        if l_amount = 0 then
          l_allow := 1;
        end if;

      end if;

      -- рах. 2620 не закривається, якщо він є рах.погашення заборгованості в КД
      if ((l_allow = 1) and (substr(d.nls, 1, 4) = '2620') and
         (check_belongs_credit(d.accd) = 1)) then
        l_allow := 0;
        bars_audit.trace('%s account %s belongs to a loan agreement.',
                         title,
                         d.nls);
      end if;

      if l_allow = 0 then

        bars_audit.trace('%s close is not allowed for deposit № %s',
                         title,
                         to_char(d.deposit_id));

      else

        bars_audit.trace('%s close is allowed for deposit № %s',
                         title,
                         to_char(d.deposit_id));

        savepoint del_ok;

        begin

          -- перенос вклада в архив
          close_to_archive(p_type  => 'DPT',
                           p_dat   => p_bdate,
                           p_dptid => d.deposit_id,
                           p_accid => null);
          bars_audit.trace('%s перенесли в архив вклад № %s',
                           title,
                           to_char(d.deposit_id));

          -- закрытие основного счета
          close_to_archive(p_type  => 'ACC',
                           p_dat   => p_bdate,
                           p_dptid => null,
                           p_accid => d.accd);
          bars_audit.trace('%s закрыли деп.счет (%s) по вкладу № %s',
                           title,
                           to_char(d.accd),
                           to_char(d.deposit_id));

          -- закрытие счета начисленных процентов
          close_to_archive(p_type  => 'ACC',
                           p_dat   => p_bdate,
                           p_dptid => null,
                           p_accid => d.accn);
          bars_audit.trace('%s закрыли счет нач.%% (%s) по вкладу № %s',
                           title,
                           to_char(d.accn),
                           to_char(d.deposit_id));

          -- закрытие счета амортизации процентов (если есть)
          if d.acca is not null then
            close_to_archive(p_type  => 'ACC',
                             p_dat   => p_bdate,
                             p_dptid => null,
                             p_accid => d.acca);
            bars_audit.trace('%s закрыли счет аморт.%% (%s) по вкладу № %s',
                             title,
                             to_char(d.acca),
                             to_char(d.deposit_id));
          end if;

          -- удаление технического вклада (при наличии оного)
          if d.dpt_d is not null then
            bars_audit.trace('%s есть техн.вклад № %s',
                             title,
                             to_char(d.dpt_d));

            select i.acc, i.acra
              into l_accd2, l_accn2
              from dpt_deposit d1, int_accn i
             where d1.acc = i.acc
               and i.id = 1
               and d1.deposit_id = d.dpt_d;

            bars_audit.trace('%s счета по техн.вкладу (%s, %s)',
                             title,
                             to_char(l_accd2),
                             to_char(l_accn2));

            close_to_archive(p_type  => 'DPT',
                             p_dat   => p_bdate,
                             p_dptid => d.dpt_d,
                             p_accid => null);
            bars_audit.trace('%s перенесли в архив техн.вклад № %s',
                             title,
                             to_char(d.dpt_d));

            -- закрытие основного счета
            close_to_archive(p_type  => 'ACC',
                             p_dat   => p_bdate,
                             p_dptid => null,
                             p_accid => l_accd2);
            bars_audit.trace('%s закрыли деп.счет (%s) по техн.вкладу № %s',
                             title,
                             to_char(l_accd2),
                             to_char(d.dpt_d));

            -- закрытие счета начисленных процентов
            close_to_archive(p_type  => 'ACC',
                             p_dat   => p_bdate,
                             p_dptid => null,
                             p_accid => l_accn2);
            bars_audit.trace('%s закрыли счет нач.%% (%s) по техн.вкладу № %s',
                             title,
                             to_char(l_accn2),
                             to_char(d.dpt_d));

            bars_audit.trace('%s закрыт техн.вклад № %s',
                             title,
                             to_char(d.dpt_d));

          end if;

          bars_audit.financial('Закрыт вклад № ' || to_char(d.deposit_id));

          -- запись в журнал
          dpt_jobs_audit.p_save2log(p_runid      => p_runid,
                                    p_dptid      => d.deposit_id,
                                    p_dealnum    => d.nd,
                                    p_branch     => p_branch,
                                    p_ref        => null,
                                    p_rnk        => d.rnk,
                                    p_nls        => d.nls,
                                    p_kv         => d.kv,
                                    p_dptsum     => null,
                                    p_intsum     => null,
                                    p_status     => 1,
                                    p_errmsg     => null,
                                    p_contractid => null);
        exception
          when others then
            bars_audit.error('невозможно закрыть договор № ' ||
                             to_char(d.deposit_id) || ' : ' ||
                             substr(sqlerrm, 1, g_errmsg_dim));
            -- запись в журнал
            dpt_jobs_audit.p_save2log(p_runid      => p_runid,
                                      p_dptid      => d.deposit_id,
                                      p_dealnum    => d.nd,
                                      p_branch     => p_branch,
                                      p_ref        => null,
                                      p_rnk        => d.rnk,
                                      p_nls        => d.nls,
                                      p_kv         => d.kv,
                                      p_dptsum     => null,
                                      p_intsum     => null,
                                      p_status     => -1,
                                      p_errmsg     => substr(sqlerrm,
                                                             1,
                                                             g_errmsg_dim),
                                      p_contractid => null);
            rollback to del_ok;
        end;

      end if; -- l_allow

    end loop; -- d

    if p_dptid = 0 then
      bars_audit.info(bars_msg.get_msg(g_modcode,
                                       'AUTOCLOSBLANK_DONE',
                                       p_branch));
      commit;
    end if;

  end auto_close_blank_deposit;
  --
  -- начисление процентов по вчерашний день или по ACRDAT_X
  --
  procedure auto_make_int(p_dptid  in dpt_deposit.deposit_id%type,
                          p_runid  in dpt_jobs_jrnl.run_id%type,
                          p_branch in dpt_deposit.branch%type,
                          p_bdate  in fdat.fdat%type) is
    title constant varchar2(60) := 'dptweb.automakeint:';
    parname  params.par%type := 'ACRDAT_X';
    l_method number(1);
    l_acrdat date;
    l_tmp    number;
    l_error  boolean;
    l_cursor integer;
    l_tmpnum integer;
  begin

    bars_audit.trace('%s branch=>%s, bdate=>%s, runid=>%s, dptid=>%s',
                     title,
                     p_branch,
                     to_char(p_bdate, 'dd.mm.yy'),
                     to_char(p_runid),
                     to_char(p_dptid));

    if (nvl(p_runid, 0) = 0 and p_dptid = 0) then
      bars_error.raise_nerror(g_modcode, g_jobrunidnotfound);
    end if;

    if p_dptid = 0 then
      bars_audit.info(bars_msg.get_msg(g_modcode,
                                       'AUTOMAKEINT_ENTRY',
                                       p_branch));
    end if;

    -- м.б. задана дата начисления в конфиг.параметре
    begin
      select to_date(val, 'yyyymmdd')
        into l_acrdat
        from params
       where par = parname;
    exception
      when others then
        l_acrdat := p_bdate - 1;
    end;

    if l_acrdat is null then
      l_acrdat := p_bdate - 1;
    end if;

    l_method := 0;
    l_cursor := dbms_sql.open_cursor;
    begin
      igen_intstatement(l_method, p_dptid, int_statement);
      dbms_sql.parse(l_cursor, int_statement, dbms_sql.native);
      dbms_sql.bind_variable(l_cursor, 'p_acrdat', l_acrdat);
      dbms_sql.bind_variable(l_cursor, 'p_branch', p_branch);
      if p_dptid > 0 then
        dbms_sql.bind_variable(l_cursor, 'p_dptid', p_dptid);
      end if;
      l_tmpnum := dbms_sql.execute(l_cursor);
      dbms_sql.close_cursor(l_cursor);
    exception
      when others then
        dbms_sql.close_cursor(l_cursor);
        raise;
    end;

    make_int(p_dat2      => l_acrdat,
             p_runmode   => 1,
             p_runid     => p_runid,
             p_intamount => l_tmp,
             p_errflg    => l_error);

    if p_dptid = 0 then
      bars_audit.info(bars_msg.get_msg(g_modcode,
                                       'AUTOMAKEINT_DONE',
                                       p_branch));
      commit;
    end if;

  end auto_make_int;

  --
  -- начисление процентов в конце месяца
  --
  procedure auto_make_int_monthly(p_dptid  in dpt_deposit.deposit_id%type,
                                  p_runid  in dpt_jobs_jrnl.run_id%type,
                                  p_branch in dpt_deposit.branch%type,
                                  p_bdate  in fdat.fdat%type,
                                  p_mode   in number) is
    title constant varchar2(60) := 'dptweb.automakeintmnth:';
    l_method  number(1);
    l_valdate date;
    l_acrdate date;
    l_tmp     number;
    l_error   boolean;
    l_cursor  integer;
    l_tmpnum  integer;
  begin

    bars_audit.trace('%s branch=>%s, bdate=>%s, runid=>%s, dptid=>%s, mode=>%s',
                     title,
                     p_branch,
                     to_char(p_bdate, 'dd.mm.yyyy'),
                     to_char(p_runid),
                     to_char(p_dptid),
                     to_char(p_mode));

    if (nvl(p_runid, 0) = 0 and p_dptid = 0) then
      bars_error.raise_nerror(g_modcode, g_jobrunidnotfound);
    end if;

    if p_dptid = 0 then
      bars_audit.info(bars_msg.get_msg(g_modcode,
                                       'AUTOMAKEINTMNTH_ENTRY',
                                       p_branch));
    end if;

    -- I. начисление по срочным вкладам

    -- расчет даты выполняения и граничной даты начисления процентов в конце месяца
    get_mnthintdates(p_bnkdate => p_bdate, -- текущая банк.дата
                     p_isfixed => 'Y', -- признак срочного вклада (Y-срочный, N-до востреб.)
                     p_valdate => l_valdate, -- дата выполнения начисления
                     p_acrdate => l_acrdate, -- граничная дата начисления
                     p_mode    => p_mode); -- режим запуска функции

    if p_bdate != l_valdate then
      -- нарушен регламент начисления процентов в конце месяца
      bars_audit.info(bars_msg.get_msg(g_modcode, 'AUTOMAKEINTMNTH_DENIED'));
      return;
    end if;

    l_method := 1;
    l_cursor := dbms_sql.open_cursor;
    begin
      igen_intstatement(l_method, p_dptid, int_statement);
      dbms_sql.parse(l_cursor, int_statement, dbms_sql.native);
      dbms_sql.bind_variable(l_cursor, 'p_acrdat', l_acrdate);
      dbms_sql.bind_variable(l_cursor, 'p_branch', p_branch);
      if p_dptid > 0 then
        dbms_sql.bind_variable(l_cursor, 'p_dptid', p_dptid);
      end if;
      l_tmpnum := dbms_sql.execute(l_cursor);
      dbms_sql.close_cursor(l_cursor);
    exception
      when others then
        dbms_sql.close_cursor(l_cursor);
        raise;
    end;

    make_int(p_dat2      => l_acrdate,
             p_runmode   => 1,
             p_runid     => p_runid,
             p_intamount => l_tmp,
             p_errflg    => l_error);

    -- II. начисление по вкладам до востребования

    -- расчет даты выполняения и граничной даты начисления процентов в конце месяца
    get_mnthintdates(p_bnkdate => p_bdate, -- текущая банк.дата
                     p_isfixed => 'N', -- признак срочного вклада (Y-срочный, N-до востреб.)
                     p_valdate => l_valdate, -- дата выполнения начисления
                     p_acrdate => l_acrdate, -- граничная дата начисления
                     p_mode    => p_mode); -- режим запуска функции

    if p_bdate != l_valdate then
      -- нарушен регламент начисления процентов в конце месяца
      bars_audit.info(bars_msg.get_msg(g_modcode, 'AUTOMAKEINTMNTH_DENIED'));
      return;
    end if;

    l_method := 2;
    l_cursor := dbms_sql.open_cursor;
    begin
      igen_intstatement(l_method, p_dptid, int_statement);
      dbms_sql.parse(l_cursor, int_statement, dbms_sql.native);
      dbms_sql.bind_variable(l_cursor, 'p_acrdat', l_acrdate);
      dbms_sql.bind_variable(l_cursor, 'p_branch', p_branch);
      if p_dptid > 0 then
        dbms_sql.bind_variable(l_cursor, 'p_dptid', p_dptid);
      end if;
      l_tmpnum := dbms_sql.execute(l_cursor);
      dbms_sql.close_cursor(l_cursor);
    exception
      when others then
        dbms_sql.close_cursor(l_cursor);
        raise;
    end;

    make_int(p_dat2      => l_acrdate,
             p_runmode   => 1,
             p_runid     => p_runid,
             p_intamount => l_tmp,
             p_errflg    => l_error);

    if p_dptid = 0 then
      bars_audit.info(bars_msg.get_msg(g_modcode,
                                       'AUTOMAKEINTMNTH_DONE',
                                       p_branch));
      commit;
    end if;

  end auto_make_int_monthly;

  --
  -- Начисление процентов в предпоследний рабочий день месяца по депозитным договорам
  -- Оптимизировано
  procedure auto_make_int_monthly_opt(p_dptid  in dpt_deposit.deposit_id%type, -- идентификатор договора (0 - все)
                                      p_runid  in dpt_jobs_jrnl.run_id%type, -- № запуска автомат.задания
                                      p_branch in dpt_deposit.branch%type, -- код подразделения
                                      p_bdate  in fdat.fdat%type, -- текущая банковская дата
                                      p_mode   in number) -- режим запуска функции
   is
    title constant varchar2(60) := 'dptweb.automakeintmnth:';
    l_method  number;
    l_valdate date;
    l_acrdate date;
    l_tmp     number;
    l_error   boolean;
    l_cursor  integer;
    l_tmpnum  integer;
  begin

    -- Процедура auto_make_int_monthly_opt пока заточена только под Ощадбанк

    bars_audit.trace('%s branch=>%s, bdate=>%s, runid=>%s, dptid=>%s, mode=>%s',
                     title,
                     p_branch,
                     to_char(p_bdate, 'dd.mm.yyyy'),
                     to_char(p_runid),
                     to_char(p_dptid),
                     to_char(p_mode));

    if (nvl(p_runid, 0) = 0 and p_dptid = 0) then
      bars_error.raise_nerror(g_modcode, g_jobrunidnotfound);
    end if;

    if p_dptid = 0 then
      bars_audit.info(bars_msg.get_msg(g_modcode,
                                       'AUTOMAKEINTMNTH_ENTRY',
                                       p_branch) || ' ( collect_salho = ' ||
                      to_char(acrn.get_collect_salho) || ' )');
    else
      raise_application_error(-20000,
                              'Процедура auto_make_int_monthly_opt поддерживает только групповое начисление %%');
    end if;

    -- для Ощадбанка(SBER) граничной датой начисления %% является последняя календарная дата месяца
    -- вне зависимости срочный это вклад или до востребования
    -- поэтому начисление выполняем за один проход

    -- расчет даты выполняения и граничной даты начисления процентов в конце месяца
    get_mnthintdates(p_bnkdate => p_bdate, -- текущая банк.дата
                     p_isfixed => 'Y', -- признак срочного вклада (Y-срочный, N-до востреб.)
                     p_valdate => l_valdate, -- дата выполнения начисления
                     p_acrdate => l_acrdate, -- граничная дата начисления
                     p_mode    => p_mode); -- режим запуска функции

    if p_bdate != l_valdate then
      -- нарушен регламент начисления процентов в конце месяца
      bars_audit.info(bars_msg.get_msg(g_modcode, 'AUTOMAKEINTMNTH_DENIED'));
      return;
    end if;

    if ( p_branch like '/______/______/' )
    then --
      l_method := 11;
    else -- специальный метод начисления %% по всему массиву депозитов
      l_method := 10;
    end if;
    
    --
    igen_intstatement(l_method, p_dptid, int_statement);
    --
    if logger.trace_enabled() then
      logger.trace('%s int_statement: %s',
                   title,
                   substr(int_statement, 1, 3000));
    end if;
    --
    l_cursor := dbms_sql.open_cursor;
    begin
      dbms_sql.parse(l_cursor, int_statement, dbms_sql.native);
      dbms_sql.bind_variable(l_cursor, 'p_acrdat', l_acrdate);
      if ( l_method = 11 )
      then
        dbms_sql.bind_variable(l_cursor, 'p_branch', p_branch||'%');
      end if;
      l_tmpnum := dbms_sql.execute(l_cursor);
      dbms_sql.close_cursor(l_cursor);
    exception
      when others then
        dbms_sql.close_cursor(l_cursor);
        raise;
    end;
    --
    if logger.trace_enabled() then
      logger.trace('%s завершено выполнение выражения int_statement',
                   title);
    end if;
    --
    make_int(p_dat2      => l_acrdate,
             p_runmode   => 1,
             p_runid     => p_runid,
             p_intamount => l_tmp,
             p_errflg    => l_error);

    bars_audit.info(bars_msg.get_msg(g_modcode,
                                     'AUTOMAKEINTMNTH_DONE',
                                     p_branch));
    commit;

  end auto_make_int_monthly_opt;

  --
  -- окончательное начисление процентов по договорам, срок действия которых истек
  --
  procedure auto_make_int_finally(p_dptid  in dpt_deposit.deposit_id%type,
                                  p_runid  in dpt_jobs_jrnl.run_id%type,
                                  p_branch in dpt_deposit.branch%type,
                                  p_bdate  in fdat.fdat%type) is
    title constant varchar2(60) := 'dptweb.automakeintfinal:';
    l_method  number(1);
    l_prevdat date;
    l_acrdat  date;
    l_tmp     number;
    l_error   boolean;
    l_cursor  integer;
    l_tmpnum  integer;
  begin

    bars_audit.trace('%s branch=>%s, bdate=>%s, runid=>%s, dptid=>%s',
                     title,
                     p_branch,
                     to_char(p_bdate, 'dd.mm.yy'),
                     to_char(p_runid),
                     to_char(p_dptid));

    if (nvl(p_runid, 0) = 0 and p_dptid = 0) then
      bars_error.raise_nerror(g_modcode, g_jobrunidnotfound);
    end if;

    if p_dptid = 0 then
      bars_audit.info(bars_msg.get_msg(g_modcode,
                                       'AUTOMAKEINTFINAL_ENTRY',
                                       p_branch));
    end if;

    -- окончательное урегулирование начисленных и выплаченных авансом процентов
    -- по авансовым вкладам, срок действия которых истек
    auto_advance_balsettlement(p_branch, p_bdate, p_dptid);

    l_acrdat := p_bdate - 1;

    -- день, следующий за предыдущим банковским днем
    l_prevdat := dat_next_u(p_bdate, -1) + 1;

    l_method := 9;
    l_cursor := dbms_sql.open_cursor;
    begin
      igen_intstatement(l_method, p_dptid, int_statement);
      dbms_sql.parse(l_cursor, int_statement, dbms_sql.native);
      dbms_sql.bind_variable(l_cursor, 'p_acrdat', l_acrdat);
      dbms_sql.bind_variable(l_cursor, 'p_branch', p_branch);
      if p_dptid > 0 then
        dbms_sql.bind_variable(l_cursor, 'p_dptid', p_dptid);
      end if;
      dbms_sql.bind_variable(l_cursor, 'p_dat1', l_prevdat);
      dbms_sql.bind_variable(l_cursor, 'p_dat2', p_bdate);
      l_tmpnum := dbms_sql.execute(l_cursor);
      dbms_sql.close_cursor(l_cursor);
    exception
      when others then
        dbms_sql.close_cursor(l_cursor);
        raise;
    end;

    make_int(p_dat2      => l_acrdat,
             p_runmode   => 1,
             p_runid     => p_runid,
             p_intamount => l_tmp,
             p_errflg    => l_error);

    if p_dptid = 0 then
      bars_audit.info(bars_msg.get_msg(g_modcode,
                                       'AUTOMAKEINTFINAL_DONE',
                                       p_branch));
      commit;
    end if;

  end auto_make_int_finally;

  -- ======================================================================================
  -- Безготівкова виплата відсотків по депозитним договорам (в кінці місяця)
  --
  procedure auto_payout_int(p_dptid  in dpt_deposit.deposit_id%type,
                            p_runid  in dpt_jobs_jrnl.run_id%type,
                            p_branch in dpt_deposit.branch%type,
                            p_bdate  in fdat.fdat%type) is
    title constant varchar2(60) := 'dptweb.autopayint:';
    l_ref    oper.ref%type;
    l_vdat   oper.vdat%type;
    l_apldat date;
    l_errmsg g_errmsg%type;
    l_errflg boolean;
    type t_dptlist is table of dpt_deposit.deposit_id%type;
    type t_payrec is record(
      dptid    dpt_deposit.deposit_id%type,
      dptnum   dpt_deposit.nd%type,
      dptacc   accounts.acc%type,
      intacc   accounts.acc%type,
      curcode  accounts.kv%type,
      amount   accounts.ostc%type,
      custid   customer.rnk%type,
      custname customer.nmk%type,
      mfoa     oper.mfoa%type,
      nlsa     oper.nlsa%type,
      namea    oper.nam_a%type,
      ida      oper.id_a%type,
      mfob     oper.mfob%type,
      nlsb     oper.nlsb%type,
      nameb    oper.nam_b%type,
      idb      oper.id_b%type);
    l_dptlist t_dptlist;
    l_payrec  t_payrec;
    l_cnt     number := 0;
  begin
    -- дата валютування = глобальна банківська дата
    l_vdat := glb_bankdate;

    bars_audit.trace('%s branch=>%s, bdate=>%s, runid=>%s, dptid=>%s',
                     title,
                     p_branch,
                     to_char(p_bdate, 'dd.mm.yy'),
                     to_char(p_runid),
                     to_char(p_dptid));

    if (nvl(p_runid, 0) = 0 and p_dptid = 0) then
      bars_error.raise_nerror(g_modcode, g_jobrunidnotfound);
    end if;

    if p_dptid = 0 then
      bars_audit.info(bars_msg.get_msg(g_modcode,
                                       'AUTOPAYOUTINT_ENTRY',
                                       p_branch));
    end if;
    /*
      -- расчет даты выполняения и граничной даты начисления процентов в конце месяца
      get_mnthintdates (p_bnkdate  => p_bdate,    -- текущая банк.дата
                        p_isfixed  => 'Y',        -- признак срочного вклада (Y-срочный, N-до востреб.)
                        p_valdate  => l_valdate,  -- дата выполнения начисления
                        p_acrdate  => l_acrdate,  -- граничная дата начисления
                        p_mode     => p_mode);    -- режим запуска функции

      if p_bdate != l_valdate then
         -- нарушен регламент начисления процентов в конце месяца
         bars_audit.info(bars_msg.get_msg (g_modcode, 'AUTOMAKEINTMNTH_DENIED'));
         return;
      end if;
    */
    bars_audit.trace('%s № запуска: %s', title, to_char(p_runid));

    if (p_dptid = 0) then
      -- депозитный портфель
      select d.deposit_id
        bulk collect
        into l_dptlist
        from dpt_deposit d, dpt_vidd v
       where d.nls_p is not null
         and d.mfo_p is not null
         and d.vidd = v.vidd
         and d.branch = p_branch
         and f_allow2pay(null,
                         d.freq,
                         d.dat_begin,
                         d.dat_end,
                         p_bdate,
                         decode(v.amr_metr, 0, 0, 1),
                         decode(nvl(d.cnt_dubl, 0), 0, 0, 1)) = 1;
      -- якщо freq = 1 то відбираються всі договора
    else
      -- депозитный договор
      select d.deposit_id
        bulk collect
        into l_dptlist
        from dpt_deposit d, dpt_vidd v
       where d.nls_p is not null
         and d.mfo_p is not null
         and d.vidd = v.vidd
         and d.branch = p_branch
         and d.deposit_id = p_dptid
         and f_allow2pay(null,
                         d.freq,
                         d.dat_begin,
                         d.dat_end,
                         p_bdate,
                         decode(v.amr_metr, 0, 0, 1),
                         decode(nvl(d.cnt_dubl, 0), 0, 0, 1)) = 1;
    end if;

    for i in 1 .. l_dptlist.count loop

      bars_audit.trace('%s вклад № %s', title, to_char(l_dptlist(i)));

      l_errflg := false;
      l_errmsg := null;
      l_ref    := null;

      savepoint sp_payout;

      begin
        select d.deposit_id,
               d.nd,
               d.acc,
               p.acc,
               p.kv,
               p.ostc,
               c.rnk,
               substr(c.nmk, 1, 38),
               p.kf,
               p.nls,
               substr(p.nms, 1, 38),
               c.okpo,
               d.mfo_p,
               d.nls_p,
               substr(d.name_p, 1, 38),
               nvl(d.okpo_p, c.okpo)
          into l_payrec
          from dpt_deposit d, accounts p, customer c, int_accn i
         where d.acc = i.acc
           and i.acra = p.acc
           and i.id = 1
           and d.rnk = c.rnk
           and p.ostb = p.ostc
           and p.ostc > 0
           and p.dazs is null
           and d.deposit_id = l_dptlist(i);

        begin
          select apl_dat
            into l_apldat
            from int_accn
           where acc = l_payrec.dptacc
             and id = 1
             for update of apl_dat nowait;
        exception
          when others then
            l_errflg := true;
            l_errmsg := substr(title || 'ошибка блокировки %-ной карточки ' ||
                               'по вкладу № ' || l_payrec.dptnum || ': ' ||
                               sqlerrm,
                               1,
                               g_errmsg_dim);
            rollback to sp_payout;
        end;

        paydoc(p_dptid    => l_payrec.dptid,
               p_vdat     => l_vdat,
               p_brancha  => p_branch,
               p_nlsa     => l_payrec.nlsa,
               p_mfoa     => l_payrec.mfoa,
               p_nama     => l_payrec.namea,
               p_ida      => l_payrec.ida,
               p_kva      => l_payrec.curcode,
               p_sa       => l_payrec.amount,
               p_branchb  => p_branch, -- 05/12/2008 p_branch,
               p_nlsb     => l_payrec.nlsb,
               p_mfob     => l_payrec.mfob,
               p_namb     => l_payrec.nameb,
               p_idb      => l_payrec.idb,
               p_kvb      => l_payrec.curcode,
               p_sb       => l_payrec.amount,
               p_nazn     => null,
               p_nmk      => l_payrec.custname,
               p_tt       => null,
               p_vob      => null,
               p_dk       => 1,
               p_sk       => null,
               p_userid   => null,
               p_type     => 4,
               p_ref      => l_ref,
               p_err_flag => l_errflg,
               p_err_msg  => l_errmsg);

        bars_audit.trace('%s референс = %s', title, to_char(l_ref));

        -- протоколирование
        if p_runid > 0 then
          dpt_jobs_audit.p_save2log(p_runid      => p_runid,
                                    p_dptid      => l_payrec.dptid,
                                    p_dealnum    => l_payrec.dptnum,
                                    p_branch     => p_branch,
                                    p_ref        => l_ref,
                                    p_rnk        => l_payrec.custid,
                                    p_nls        => l_payrec.nlsa,
                                    p_kv         => l_payrec.curcode,
                                    p_dptsum     => null,
                                    p_intsum     => l_payrec.amount,
                                    p_status     => (case
                                                      when l_errflg then
                                                       -1
                                                      else
                                                       1
                                                    end),
                                    p_errmsg     => l_errmsg,
                                    p_contractid => null);
        end if;

        if l_errflg then
          if p_runid > 0 then
            bars_audit.error(title || 'ошибка оплаты: ' || l_errmsg);
          else
            bars_error.raise_nerror(g_modcode,
                                    'PAYOUT_ERR',
                                    title || l_errmsg);
          end if;
          rollback to sp_payout;
        else
          update int_accn
             set apl_dat = l_vdat
           where acc = l_payrec.dptacc
             and id = 1;
          l_cnt := l_cnt + 1;
          if (p_runid > 0 and l_cnt >= autocommit) then
            bars_audit.trace('%s промежут.фиксация (%s)',
                             title,
                             to_char(l_cnt));
            commit;
            l_cnt := 0;
          end if;
        end if;
      exception
        when no_data_found then
          bars_audit.trace('%s не выполняются условия выплаты по вкладу № %s',
                           title,
                           to_char(l_dptlist(i)));
      end;

    end loop; -- l_dptlist

    if p_dptid = 0 then
      bars_audit.info(bars_msg.get_msg(g_modcode,
                                       'AUTOPAYOUTINT_DONE',
                                       p_branch));
      commit;
    end if;

  end auto_payout_int;

  -- =======================================================================================
  --
  -- Начисление и безнал.выплата процентов по депозитным договорам по индивид.графику
  --
  procedure auto_payout_int_plan(p_dptid  in dpt_deposit.deposit_id%type, -- идентификатор договора (0 - все)
                                 p_runid  in dpt_jobs_jrnl.run_id%type, -- № запуска автомат.задания
                                 p_branch in dpt_deposit.branch%type, -- код подразделения
                                 p_bdate  in fdat.fdat%type) -- текущая банковская дата
   is
    c_title constant varchar2(60) := 'dptweb.autopayintpl:';
    type t_dptrec is record(
      dptid    dpt_deposit.deposit_id%type,
      plandate date,
      comproc  dpt_vidd.comproc%type,
      min_add  dpt_vidd.limit%type);
    type t_dptlist is table of t_dptrec;
    type t_payrec is record(
      dptid    dpt_deposit.deposit_id%type,
      dptnum   dpt_deposit.nd%type,
      dptacc   accounts.acc%type,
      intacc   accounts.acc%type,
      curcode  accounts.kv%type,
      amntfact accounts.ostc%type,
      amntplan accounts.ostb%type,
      nazn     oper.nazn%type,
      custid   customer.rnk%type,
      custname customer.nmk%type,
      mfoa     oper.mfoa%type,
      nlsa     oper.nlsa%type,
      namea    oper.nam_a%type,
      ida      oper.id_a%type,
      mfob     oper.mfob%type,
      nlsb     oper.nlsb%type,
      nameb    oper.nam_b%type,
      idb      oper.id_b%type);
    l_initdate date;
    l_plandate date;
    l_acrdat   date;
    l_tmpnum   number;
    l_dptlist  t_dptlist;
    l_payrec   t_payrec;
    l_apldat   date;
    l_ref      oper.ref%type;
    l_errflg   boolean;
    l_errmsg   g_errmsg%type;
    l_dptnls   accounts.nls%type;
    l_vidd     dpt_vidd.vidd%type;
    l_adds     number := 0; -- принадлежность счета выплаты к тому же договору
    l_tt       tts.tt%type;
    ---
    -- internal function and procedure
    ---
    function check_nls4pay(p_nls dpt_deposit.nls_p%type,
                           p_acc dpt_deposit.acc%type) return boolean result_cache is
      l_nls accounts.nls%type;
    begin
      select nls into l_nls from accounts where acc = p_acc;

      if (p_nls = l_nls) then
        return true;
      else
        return false;
      end if;
    end;
    ---
    function check_joinpay(p_deposit_id dpt_deposit.deposit_id%type,
                           p_nlsb       dpt_deposit.nls_p%type)
      return boolean result_cache is
      l_adds int;
    begin
      begin
        select 1
          into l_adds
          from accounts a, dpt_deposit d
         where d.acc = a.acc
           and a.nls = p_nlsb
           and d.deposit_id = p_deposit_id;
      exception
        when no_data_found then
          l_adds := -1;
      end;

      if (l_adds = 1) then
        return true;
      else
        return false;
      end if;
    end;
  begin

    bars_audit.trace('%s entry with {%s, %s, %s, %s)',
                     c_title,
                     to_char(p_dptid),
                     to_char(p_runid),
                     p_branch,
                     to_char(p_bdate, 'dd.mm.yyyy'));

    if (nvl(p_runid, 0) = 0 and p_dptid = 0) then
      bars_error.raise_nerror(g_modcode, g_jobrunidnotfound);
    end if;

    if p_dptid = 0 then
      bars_audit.info(bars_msg.get_msg(g_modcode,
                                       'AUTOPAYOUTINTPL_ENTRY',
                                       p_branch));
    end if;

    l_initdate := dat_next_u(p_bdate, -1) + 1;
    bars_audit.trace('%s plandate''s range: %s - %s',
                     c_title,
                     to_char(l_initdate, 'dd.mm.yyyy'),
                     to_char(p_bdate, 'dd.mm.yyyy'));

    l_plandate := l_initdate;

    while l_plandate <= p_bdate loop

      bars_audit.trace('%s processing plandate %s...',
                       c_title,
                       to_char(l_plandate, 'dd.mm.yyyy'));

      l_acrdat := l_plandate - 1;

      -- начисление %% по план.дату минус 1 день
      insert into int_queue
        (kf,
         branch,
         deal_id,
         deal_num,
         deal_dat,
         cust_id,
         int_id,
         acc_id,
         acc_num,
         acc_cur,
         acc_nbs,
         acc_name,
         acc_iso,
         acc_open,
         acc_amount,
         int_details,
         int_tt,
         mod_code)
        select /*+ ORDERED INDEX(a) INDEX(i)*/
         a.kf,
         a.branch,
         d.deposit_id,
         d.nd,
         d.datz,
         d.rnk,
         i.id,
         a.acc,
         a.nls,
         a.kv,
         a.nbs,
         substr(a.nms, 1, 38),
         t.lcv,
         a.daos,
         null,
         null,
         nvl(i.tt, '%%1'),
         'DPT'
          from dpt_deposit d, accounts a, int_accn i, tabval t, dpt_vidd v
         where d.acc = a.acc
           and d.acc = i.acc
           and i.id = 1
           and a.kv = t.kv
           and d.vidd = v.vidd
           and d.branch = p_branch
           and (p_dptid = 0 or p_dptid = d.deposit_id)
           and ((i.acr_dat is null) or
               (i.acr_dat < l_acrdat and i.stp_dat is null) or
               (i.acr_dat < l_acrdat and i.stp_dat > i.acr_dat))
           and dpt.get_intpaydate(p_bdate,
                                  d.dat_begin,
                                  d.dat_end,
                                  d.freq,
                                  decode(v.amr_metr, 0, 0, 1),
                                  decode(nvl(d.cnt_dubl, 0), 0, 0, 1),
                                  1) = l_plandate;

      /*insert into dpt_int_queue
      select bars_sqnc.get_nextval('S_DPTINT'),
             kf,
             branch,
             int_id,
             acc_id,
             acc_num,
             acc_cur,
             acc_nbs,
             acc_name,
             acc_iso,
             acc_open,
             acc_amount,
             int_details,
             int_tt,
             deal_id,
             deal_num,
             deal_dat,
             cust_id,
             mod_code,
             sysdate
        from int_queue;*/

      bars_audit.trace('%s make_int for %s...', c_title, p_branch);

      make_int(p_dat2      => l_acrdat,
               p_runmode   => 1,
               p_runid     => 0,
               p_intamount => l_tmpnum,
               p_errflg    => l_errflg);

      bars_audit.trace('%s make_int for %s completed.', c_title, p_branch);

      l_plandate := l_plandate + 1;

    end loop;

    -- отбор всех вкладов, для которых наступил день плановой выплаты процентов
    select deposit_id, plandate, comproc, limit
      bulk collect
      into l_dptlist
      from (select d.deposit_id,
                   dpt.get_intpaydate(p_bdate,
                                      d.dat_begin,
                                      d.dat_end,
                                      d.freq,
                                      decode(v.amr_metr, 0, 0, 1),
                                      decode(nvl(d.cnt_dubl, 0), 0, 0, 1),
                                      1) plandate,
                   v.comproc,
                   v.limit
              from dpt_deposit d, dpt_vidd v
             where d.vidd = v.vidd
               and d.branch = p_branch
               and p_dptid = 0 -- депозитный портфель
               and d.mfo_p is not null
               and d.nls_p is not null
               and dpt.get_intpaydate(p_bdate,
                                      d.dat_begin,
                                      d.dat_end,
                                      d.freq,
                                      decode(v.amr_metr, 0, 0, 1),
                                      decode(nvl(d.cnt_dubl, 0), 0, 0, 1),
                                      1) between l_initdate and p_bdate
            union all
            select d.deposit_id,
                   dpt.get_intpaydate(p_bdate,
                                      d.dat_begin,
                                      d.dat_end,
                                      d.freq,
                                      decode(v.amr_metr, 0, 0, 1),
                                      decode(nvl(d.cnt_dubl, 0), 0, 0, 1),
                                      1) plandate,
                   v.comproc,
                   v.limit
              from dpt_deposit d, dpt_vidd v
             where d.vidd = v.vidd
               and d.branch = p_branch
               and p_dptid != 0
               and d.deposit_id = p_dptid -- депозитный договор
               and d.mfo_p is not null
               and d.nls_p is not null
               and dpt.get_intpaydate(p_bdate,
                                      d.dat_begin,
                                      d.dat_end,
                                      d.freq,
                                      decode(v.amr_metr, 0, 0, 1),
                                      decode(nvl(d.cnt_dubl, 0), 0, 0, 1),
                                      1) between l_initdate and p_bdate);

    bars_audit.trace('%s amount of intpay-deposits = %s',
                     c_title,
                     to_char(l_dptlist.count));

    -- безначичная выплата процентов (+ oper_ext)
    l_tmpnum := 0;

    for i in 1 .. l_dptlist.count loop

      l_errflg := false;
      l_errmsg := null;
      l_ref    := null;

      savepoint sp_payout;

      begin
        select d.deposit_id,
               d.nd,
               d.acc,
               p.acc,
               p.kv,
               p.ostc,
               p.ostb,
               null,
               c.rnk,
               substr(c.nmk, 1, 38),
               p.kf,
               p.nls,
               substr(p.nms, 1, 38),
               c.okpo,
               d.mfo_p,
               d.nls_p,
               substr(d.name_p, 1, 38),
               nvl(d.okpo_p, c.okpo)
          into l_payrec
          from dpt_deposit d, accounts p, customer c, int_accn i
         where d.acc = i.acc
           and i.acra = p.acc
           and i.id = 1
           and d.rnk = c.rnk
           and p.ostc > 0
           and d.deposit_id = l_dptlist(i).dptid;

        bars_audit.trace('%s processing deposit № %s...',
                         c_title,
                         to_char(l_dptlist(i).dptid));

        -- міняєм призначення платежу якщо виплата %% - це капіталізація
        if (l_dptlist(i).comproc = 1) then

          -- перевіряємо чи не було змінено рах. виплати %%
          if (check_nls4pay(l_payrec.nlsb, l_payrec.dptacc)) then
            l_payrec.nazn := substr('Капіталізація нарахованих відсотків по договору № ' ||
                                    dpt_web.f_nazn('U', l_payrec.dptid),
                                    1,
                                    160);
          end if;
        else
          /* === COBUMMFO-7002 === убрать проверку пополнения при начислении %%

          -- якщо мін. сума поповнення більша нуля то вклад з поповненням  і це виплата на депозитний рахунок, а НЕ КАПІТАЛІЗАЦІЯ
          if (l_dptlist(i).min_add > 0) then

            -- якщо сума %% менша за мін. суму поповнення
            if (l_payrec.amntfact < l_dptlist(i).min_add) then

              l_errflg := true;
              -- сума поповнення %s менша за мінімально допустиму %s для вкладу № %s
              l_errmsg := substr(bars_msg.get_msg(g_modcode,
                                                  'AUTOPAYOUTINTPL_INVALID_MINADD',
                                                  to_char(l_payrec.amntfact / 100),
                                                  to_char(l_dptlist(i)
                                                          .min_add),
                                                  l_payrec.dptnum),
                                 1,
                                 g_errmsg_dim);

              l_payrec.amntfact := 0;

              rollback to sp_payout;
              begin
                select d.vidd
                  into l_vidd
                  from dpt_deposit d, dpt_vidd dv
                 where d.deposit_id = l_payrec.dptid
                   and dv.vidd = d.vidd
                   and dv.type_id in (7, 10, 16);
              exception
                when no_data_found then
                  l_vidd := -1;
              end;

              -- якщо депозит без поповнення та рах.виплати %% = рах.вкладу - капіталіз. згідно пакету "ЕКСКЛЮЗИВ"
              if l_vidd > 0 and (l_payrec.amntfact >= l_dptlist(i).min_add) and
                 check_joinpay(l_payrec.dptid, l_payrec.nlsb) then
                l_payrec.nazn := substr('Поповнення вкладу по договору № ' ||
                                        dpt_web.f_nazn('U', l_payrec.dptid),
                                        1,
                                        160);
              end if;
            end if;

          else
            -- якщо мін. сума поповнення нуль или пусто

          === COBUMMFO-7002 === */
            if (check_nls4pay(l_payrec.nlsb, l_payrec.dptacc)) then
              begin
                select d.vidd
                  into l_vidd
                  from dpt_deposit d, dpt_vidd dv
                 where d.deposit_id = l_payrec.dptid
                   and dv.vidd = d.vidd
                   and dv.type_id in (7, 10, 16);
              exception
                when no_data_found then
                  l_vidd := -1;
              end;

              -- якщо депозит без поповнення та рах.виплати %% = рах.вкладу - капіталіз. згідно пакету "ЕКСКЛЮЗИВ"
              if l_vidd > 0 and
                 check_joinpay(l_payrec.dptid, l_payrec.nlsb) then
                l_payrec.nazn := substr('Поповнення вкладу по договору № ' ||
                                        dpt_web.f_nazn('U', l_payrec.dptid),
                                        1,
                                        160);
              end if;
            end if;
          -- end if; === COBUMMFO-7002 ===
          end if;

        if not l_errflg then

          if (l_payrec.amntfact != l_payrec.amntplan) then

            l_errflg := true;

            -- наличие незавизир.документов на счете %s/%s для вклада № %s
            l_errmsg := substr(bars_msg.get_msg(g_modcode,
                                                'AUTOPAYOUTINTPL_INVALID_SALDO',
                                                l_payrec.nlsa,
                                                to_char(l_payrec.curcode),
                                                l_payrec.dptnum),
                               1,
                               g_errmsg_dim);

            rollback to sp_payout;

          else

            begin
              select apl_dat
                into l_apldat
                from int_accn
               where acc = l_payrec.dptacc
                 and id = 1
                 for update of apl_dat nowait;
            exception
              when others then
                l_errflg := true;
                -- ошибка блокировки %-ной карточки по деп.счету вклада № %s: %s
                l_errmsg := substr(bars_msg.get_msg(g_modcode,
                                                    'AUTOPAYOUTINTPL_LOCK_FAILED',
                                                    l_payrec.dptnum,
                                                    sqlerrm),
                                   1,
                                   g_errmsg_dim);
                rollback to sp_payout;
            end;

            paydoc(p_dptid    => l_payrec.dptid,
                   p_vdat     => p_bdate,
                   p_brancha  => p_branch,
                   p_branchb  => p_branch,
                   p_nlsa     => l_payrec.nlsa,
                   p_nlsb     => l_payrec.nlsb,
                   p_mfoa     => l_payrec.mfoa,
                   p_mfob     => l_payrec.mfob,
                   p_nama     => l_payrec.namea,
                   p_namb     => l_payrec.nameb,
                   p_ida      => l_payrec.ida,
                   p_idb      => l_payrec.idb,
                   p_kva      => l_payrec.curcode,
                   p_kvb      => l_payrec.curcode,
                   p_sa       => l_payrec.amntfact,
                   p_sb       => l_payrec.amntfact,
                   p_nmk      => l_payrec.custname,
                   p_userid   => null,
                   p_tt       => null,
                   p_vob      => null,
                   p_dk       => 1,
                   p_sk       => null,
                   p_type     => 4,
                   p_ref      => l_ref,
                   p_nazn     => l_payrec.nazn,
                   p_err_flag => l_errflg,
                   p_err_msg  => l_errmsg);

            bars_audit.trace('%s docref (%s->%s %s) = %s',
                             c_title,
                             l_payrec.nlsa,
                             l_payrec.nlsb,
                             to_char(l_payrec.amntfact),
                             to_char(l_payrec.curcode),
                             to_char(l_ref));
            if (l_ref is not null) and (l_dptlist(i).plandate != p_bdate) then

              begin
                insert into oper_ext
                  (ref, kf, pay_bankdate, pay_caldate)
                values
                  (l_ref, l_payrec.mfoa, p_bdate, l_dptlist(i).plandate);
              exception
                when dup_val_on_index then
                  null;
              end;

              bars_audit.trace('%s pay(bnk/sys)dat = %s/%s for ref %s',
                               c_title,
                               to_char(p_bdate, 'dd.mm.yyyy'),
                               to_char(l_dptlist(i).plandate, 'dd.mm.yyyy'),
                               to_char(l_ref));
            end if;
          end if;
        end if;

        -- протоколирование
        if p_runid > 0 then
          dpt_jobs_audit.p_save2log(p_runid      => p_runid,
                                    p_dptid      => l_payrec.dptid,
                                    p_dealnum    => l_payrec.dptnum,
                                    p_branch     => p_branch,
                                    p_ref        => l_ref,
                                    p_rnk        => l_payrec.custid,
                                    p_nls        => l_payrec.nlsa,
                                    p_kv         => l_payrec.curcode,
                                    p_dptsum     => null,
                                    p_intsum     => l_payrec.amntfact,
                                    p_status     => (case
                                                      when l_errflg then
                                                       -1
                                                      else
                                                       1
                                                    end),
                                    p_errmsg     => l_errmsg,
                                    p_contractid => null);
        end if;

        if l_errflg then

          if (p_runid > 0) then
            -- ошибка выплаты процентов по вкладу № %s: %s
            bars_audit.error(bars_msg.get_msg(g_modcode,
                                              'AUTOPAYOUTINTPL_DOCPAY_FAILED',
                                              l_payrec.dptnum,
                                              l_errmsg));
          else
            bars_error.raise_nerror(g_modcode,
                                    'PAYOUT_ERR',
                                    c_title || l_errmsg);
          end if;

          rollback to sp_payout;

        else
          update int_accn
             set apl_dat = p_bdate
           where acc = l_payrec.dptacc
             and id = 1;

          l_tmpnum := l_tmpnum + 1;

          if (p_runid > 0 and l_tmpnum >= autocommit) then
            bars_audit.trace('%s intermediate commit (%s dep. processed)',
                             c_title,
                             to_char(l_tmpnum));
            commit;
            l_tmpnum := 0;
          end if;

          if (ebp.get_archive_docid(l_payrec.dptid) > 0) then
            -- відправка SMS повідомлення про виплату відсотків
            /* send_sms( l_payrec.custid, 'Po depozytu N'|| to_char(l_payrec.dptid) ||' vyplacheno protsenty u sumi '||
                    Amount2Str(l_payrec.amntfact, l_payrec.curcode) || ' na kartkovyy rakhunok '|| substr(l_payrec.nlsb,1,4)||'****'||substr(l_payrec.nlsb,-4) ||'.' );
            */ -- прибрана відправка. Відправка СМС через відповідний шаблон
            null;
          end if;

        end if;

      exception
        when no_data_found then
          bars_audit.trace('%s nothing to pay for deposit № %s',
                           c_title,
                           to_char(l_dptlist(i).dptid));
      end;

    end loop; -- l_dptlist

    if p_dptid = 0 then
      bars_audit.info(bars_msg.get_msg(g_modcode,
                                       'AUTOPAYOUTINTPL_DONE',
                                       p_branch));
      commit;
    end if;

  end auto_payout_int_plan;

  -- =======================================================================================
  -- Возврат депозита и начисленных процентов по окончанию депозитных договоров
  --
  procedure auto_maturity_payoff(p_dptid  in dpt_deposit.deposit_id%type,
                                 p_runid  in dpt_jobs_jrnl.run_id%type,
                                 p_branch in dpt_deposit.branch%type,
                                 p_bdate  in fdat.fdat%type) is
    title constant varchar2(60) := 'dptweb.automatpayoff: ';
    l_errflg     boolean;
    l_errmsg     g_errmsg%type;
    l_ref_dpt    oper.ref%type;
    l_ref_int    oper.ref%type;
    l_amount_dpt oper.s%type;
    l_amount_int oper.s%type;
    l_vdat       oper.vdat%type;
    l_bdate      fdat.fdat%type;
  begin

    bars_audit.trace('%s entry, branch=>%s, bdate=>%s, runid=>%s, dptid=>%s',
                     title,
                     p_branch,
                     to_char(p_bdate),
                     to_char(p_runid),
                     to_char(p_dptid));

    if (nvl(p_runid, 0) = 0 and p_dptid = 0) then
      bars_error.raise_nerror(g_modcode, g_jobrunidnotfound);
    end if;

    if p_dptid = 0 then
      bars_audit.info(bars_msg.get_msg(g_modcode,
                                       'AUTOMATPAYOFF_ENTRY',
                                       p_branch));
    end if;

    -- дата валютування = глобальна банківська дата
    l_vdat := glb_bankdate;

    -- Ощадбанк виплачує депозити на наступний день після завершення
    l_bdate := (p_bdate - 1);

    for d in (select -- выборка данных для одного вклада № p_dptid
               d.deposit_id dptid,
               d.nd dptnum,
               d.datz dptdat,
               a.acc depaccid,
               b.acc intaccid,
               c.rnk custid,
               c.okpo custcode,
               substr(c.nmk, 1, 38) custname,
               i.id intid,
               nvl(i.tt, '%%1') inttt,
               a.branch,
               a.nbs,
               a.daos,
               t.lcv,
               a.kf depmfoa,
               a.nls depnlsa,
               substr(a.nms, 1, 38) depnama,
               a.kv depcurid,
               b.kf intmfoa,
               b.nls intnlsa,
               substr(b.nms, 1, 38) intnama,
               b.kv intcurid,
               d.mfo_d depmfob,
               d.nls_d depnlsb,
               substr(d.nms_d, 1, 38) depnamb,
               nvl(d.okpo_d, c.okpo) depidb,
               d.mfo_p intmfob,
               d.nls_p intnlsb,
               substr(d.name_p, 1, 38) intnamb,
               nvl(d.okpo_p, c.okpo) intidb
                from dpt_deposit d,
                     accounts    a,
                     int_accn    i,
                     accounts    b,
                     customer    c,
                     tabval      t
               where d.acc = a.acc
                 and i.acc = a.acc
                 and i.id = 1
                 and i.acra = b.acc
                 and d.rnk = c.rnk
                 and a.kv = t.kv
                 and a.ostc = a.ostb
                 and b.ostc = b.ostb
                 and a.ostc > 0
                 and d.mfo_d is not null
                 and d.nls_d is not null
                 and d.dat_end <= l_bdate
                 and d.branch = p_branch
                 and d.deposit_id = p_dptid
                 and p_dptid != 0
              union all
              select -- выборка всех вкладов подразделения p_branch
               d.deposit_id dptid,
               d.nd dptnum,
               d.datz dptdat,
               a.acc depaccid,
               b.acc intaccid,
               c.rnk custid,
               c.okpo custcode,
               substr(c.nmk, 1, 38) custname,
               i.id intid,
               nvl(i.tt, '%%1') inttt,
               a.branch,
               a.nbs,
               a.daos,
               t.lcv,
               a.kf depmfoa,
               a.nls depnlsa,
               substr(a.nms, 1, 38) depnama,
               a.kv depcurid,
               b.kf intmfoa,
               b.nls intnlsa,
               substr(b.nms, 1, 38) intnama,
               b.kv intcurid,
               d.mfo_d depmfob,
               d.nls_d depnlsb,
               substr(d.nms_d, 1, 38) depnamb,
               nvl(d.okpo_d, c.okpo) depidb,
               d.mfo_p intmfob,
               d.nls_p intnlsb,
               substr(d.name_p, 1, 38) intnamb,
               nvl(d.okpo_p, c.okpo) intidb
                from dpt_deposit d,
                     accounts    a,
                     int_accn    i,
                     accounts    b,
                     customer    c,
                     tabval      t
               where d.acc = a.acc
                 and i.acc = a.acc
                 and i.id = 1
                 and i.acra = b.acc
                 and d.rnk = c.rnk
                 and a.kv = t.kv
                 and a.ostc = a.ostb
                 and b.ostc = b.ostb
                    -- and a.ostc       > 0
                    -- and d.mfo_d      is not null
                    -- and d.nls_d      is not null
                 and ((a.ostc > 0 and d.mfo_d is not null and
                     d.nls_d is not null) or
                     (b.ostc > 0 and d.mfo_p is not null and
                     d.nls_p is not null))
                 and d.dat_end <= l_bdate
                 and d.branch = p_branch
                 and p_dptid = 0
               order by 1) loop
      -- 4151 снимаем блокировку инсайдерства с дебета основного счета при окончании вклада и перед выплатой
      begin
        update accounts
           set blkd = 0
         where blkd = 12
           and acc = d.depaccid;
      end;
      begin

        bars_audit.trace('%s deposit № %s (%s)',
                         title,
                         d.dptnum,
                         to_char(d.dptid));

        savepoint sp_maturity;
        -- перевірка депозиту на "пролонгацію"
        if (check_for_extension(d.dptid) = 1) then
          l_errflg := true;
          l_errmsg := substr('Депозит #' || to_char(d.dptid) ||
                             ' повинен пролонгуватися!',
                             1,
                             g_errmsg_dim);
          goto nextrec;
        end if;
        l_errflg     := false;
        l_errmsg     := null;
        l_ref_dpt    := null;
        l_ref_int    := null;
        l_amount_dpt := null;
        l_amount_int := null;

        -- начисление процентов по вчерашний день
        insert into int_queue
          (mod_code,
           kf,
           branch,
           deal_id,
           deal_num,
           deal_dat,
           acc_id,
           acc_num,
           acc_name,
           acc_cur,
           acc_iso,
           acc_nbs,
           acc_open,
           cust_id,
           int_id,
           int_tt)
        values
          ('DPT',
           d.depmfoa,
           d.branch,
           d.dptid,
           d.dptnum,
           d.dptdat,
           d.depaccid,
           d.depnlsa,
           d.depnama,
           d.depcurid,
           d.lcv,
           d.nbs,
           d.daos,
           d.custid,
           d.intid,
           d.inttt);

        make_int(p_dat2      => l_bdate - 1,
                 p_runmode   => 1,
                 p_runid     => 0,
                 p_intamount => l_amount_int,
                 p_errflg    => l_errflg);

        if l_errflg then
          l_errmsg := substr('ошибка начисления %% по договору №' ||
                             d.dptnum || ' (' || to_char(d.dptid) || ') ' ||
                             sqlerrm || chr(10) ||
                             dbms_utility.format_error_backtrace(),
                             1,
                             g_errmsg_dim);
          goto nextrec;
        else
          bars_audit.trace('%s interest amount = %s',
                           title,
                           to_char(l_amount_int));
        end if;

        if (d.intmfob is not null and d.intnlsb is not null) then
          -- уточняем остаток на счете начисленных процентов (с учетом возможного начисления %%)
          begin
            select ostb
              into l_amount_int
              from accounts
             where acc = d.intaccid
               for update of ostb nowait;
            bars_audit.trace('%s account %s saldo = %s',
                             title,
                             d.intnlsa,
                             to_char(l_amount_int));
          exception
            when others then
              l_errflg := true;
              l_errmsg := substr('ошибка блокировки счета ' || d.intnlsa || ': ' ||
                                 sqlerrm || chr(10) ||
                                 dbms_utility.format_error_backtrace(),
                                 1,
                                 g_errmsg_dim);
              goto nextrec;
          end;

          -- выплата процентов
          if (l_amount_int > 0) then
            paydoc(p_dptid    => d.dptid,
                   p_vdat     => l_vdat,
                   p_brancha  => p_branch,
                   p_nlsa     => d.intnlsa,
                   p_mfoa     => d.intmfoa,
                   p_nama     => d.intnama,
                   p_ida      => d.custcode,
                   p_kva      => d.intcurid,
                   p_sa       => l_amount_int,
                   p_branchb  => p_branch,
                   p_nlsb     => nvl(d.intnlsb, d.depnlsb),
                   p_mfob     => nvl(d.intmfob, d.depmfob),
                   p_namb     => nvl(d.intnamb, d.depnamb),
                   p_idb      => nvl(d.intidb, d.depidb),
                   p_kvb      => d.intcurid,
                   p_sb       => l_amount_int,
                   p_nazn     => null,
                   p_nmk      => d.custname,
                   p_tt       => null,
                   p_vob      => null,
                   p_dk       => 1,
                   p_sk       => null,
                   p_userid   => null,
                   p_type     => 4,
                   p_ref      => l_ref_int,
                   p_err_flag => l_errflg,
                   p_err_msg  => l_errmsg);

            if l_errflg then
              l_errmsg := substr('Помилка виплати %% по дог.№' || d.dptnum || ' (' ||
                                 to_char(d.dptid) || ') ' || l_errmsg,
                                 1,
                                 g_errmsg_dim);
              goto nextrec;
            else
              bars_audit.financial('Сформирован документ по выплате процентов. ref ' ||
                                   to_char(l_ref_int));
            end if;

          end if;
        end if;
        if (d.depmfob is not null and d.depnlsb is not null) then
          -- уточняем остаток на депозитном счете (с учетом возможной капитализации %%)
          begin
            select ostb
              into l_amount_dpt
              from accounts
             where acc = d.depaccid
               for update of ostb nowait;
            bars_audit.trace('%s account %s saldo = %s',
                             title,
                             d.depnlsa,
                             to_char(l_amount_dpt));
          exception
            when others then
              l_errflg := true;
              l_errmsg := substr('ошибка блокировки счета ' || d.depnlsa || ': ' ||
                                 dbms_utility.format_error_stack() ||
                                 chr(10) ||
                                 dbms_utility.format_error_backtrace(),
                                 1,
                                 g_errmsg_dim);
              goto nextrec;
          end;

          -- перечисление суммы депозита
          if (l_amount_dpt > 0) then
            paydoc(p_dptid    => d.dptid,
                   p_vdat     => l_vdat,
                   p_brancha  => p_branch,
                   p_nlsa     => d.depnlsa,
                   p_mfoa     => d.depmfoa,
                   p_nama     => d.depnama,
                   p_ida      => d.custcode,
                   p_kva      => d.depcurid,
                   p_sa       => l_amount_dpt,
                   p_branchb  => p_branch,
                   p_nlsb     => d.depnlsb,
                   p_mfob     => d.depmfob,
                   p_namb     => d.depnamb,
                   p_idb      => d.depidb,
                   p_kvb      => d.depcurid,
                   p_sb       => l_amount_dpt,
                   p_nazn     => null,
                   p_nmk      => d.custname,
                   p_tt       => null,
                   p_vob      => null,
                   p_dk       => 1,
                   p_sk       => null,
                   p_userid   => null,
                   p_type     => 2,
                   p_ref      => l_ref_dpt,
                   p_err_flag => l_errflg,
                   p_err_msg  => l_errmsg);

            if l_errflg then
              l_errmsg := substr('Помилка виплати коштів по дог.№' ||
                                 d.dptnum || ' (' || to_char(d.dptid) || ') ' ||
                                 l_errmsg,
                                 1,
                                 g_errmsg_dim);
              goto nextrec;
            else

              bars_audit.financial('Сформирован документ по перечислению суммы депозита. ref ' ||
                                   to_char(l_ref_dpt));

              if (ebp.get_archive_docid(d.dptid) > 0) then
                -- відправка SMS повідомлення про виплату депозиту
                /*  send_sms( d.custid, 'Depozyt N'|| to_char(d.dptid) ||' zakryto, koshty u sumi '||
                                        Amount2Str(l_amount_dpt, d.depcurid) || ' pererahovano na kartkovyy rakhunok '|| substr(d.depnlsb,1,4)||'****'||substr(d.depnlsb,-4)  ||'.' );
                */
                null;
              end if;

            end if;

          end if;
        end if;

        <<nextrec>>
        if p_runid > 0 then
          -- протоколирование
          dpt_jobs_audit.p_save2log(p_runid      => p_runid,
                                    p_dptid      => d.dptid,
                                    p_dealnum    => d.dptnum,
                                    p_branch     => p_branch,
                                    p_ref        => l_ref_dpt,
                                    p_rnk        => d.custid,
                                    p_nls        => d.depnlsa,
                                    p_kv         => d.depcurid,
                                    p_dptsum     => l_amount_dpt,
                                    p_intsum     => l_amount_int,
                                    p_status     => (case
                                                      when l_errflg then
                                                       -1
                                                      else
                                                       1
                                                    end),
                                    p_errmsg     => l_errmsg,
                                    p_contractid => null);
        end if;

        if l_errflg then

          if (p_runid > 0) then
            bars_audit.error(title || l_errmsg);

            rollback to sp_maturity;

          else
            bars_error.raise_nerror(g_modcode,
                                    'PAYOUT_ERR',
                                    title || l_errmsg);
          end if;

        end if;

      exception
        when others then
          -- для автом.завдань
          if (p_runid > 0) then
            dpt_jobs_audit.p_save2log(p_runid      => p_runid,
                                      p_dptid      => d.dptid,
                                      p_dealnum    => d.dptnum,
                                      p_branch     => p_branch,
                                      p_ref        => l_ref_dpt,
                                      p_rnk        => d.custid,
                                      p_nls        => d.depnlsa,
                                      p_kv         => d.depcurid,
                                      p_dptsum     => l_amount_dpt,
                                      p_intsum     => l_amount_int,
                                      p_status     => -1,
                                      p_errmsg     => sqlerrm,
                                      p_contractid => null);
            rollback to sp_maturity;
          else
            raise;
          end if;

      end;

    end loop;

    if (p_dptid = 0) then
      bars_audit.info(bars_msg.get_msg(g_modcode,
                                       'AUTOMATPAYOFF_DONE',
                                       p_branch));
      commit; -- ????
    end if;

  end auto_maturity_payoff;

  --=======================================================================================
  --
  --
  procedure auto_move2archive(p_dptid  in dpt_deposit.deposit_id%type,
                              p_runid  in dpt_jobs_jrnl.run_id%type,
                              p_branch in dpt_deposit.branch%type,
                              p_bdate  in fdat.fdat%type) is
    title        constant varchar2(60) := 'dptweb.automove2arch:';
    tag_2clos    constant dpt_depositw.tag%type := '2CLOS';
    val_2clos    constant dpt_depositw.value%type := 'Y';
    l_autocommit constant number := 500;
    type t_dptaccrec is record(
      dptid  dpt_deposit.deposit_id%type,
      dptnum dpt_deposit.nd%type,
      dptype dpt_deposit.vidd%type,
      custid dpt_deposit.rnk%type,
      depacc accounts.acc%type,
      intacc accounts.acc%type,
      amracc accounts.acc%type,
      accnum accounts.nls%type,
      curid  accounts.kv%type,
      blkd   accounts.blkd%type);
    type t_dptacclist is table of t_dptaccrec;
    l_dpt t_dptacclist;
    l_cnt number := 0;
  begin

    bars_audit.trace('%s entry, branch=>%s, runid=>%s, dptid=>%s, bdate=>%s',
                     title,
                     p_branch,
                     to_char(p_runid),
                     to_char(p_dptid),
                     to_char(p_bdate, 'dd.mm.yy'));

    if (nvl(p_runid, 0) = 0 and p_dptid = 0) then
      bars_error.raise_nerror(g_modcode, g_jobrunidnotfound);
    end if;

    if p_dptid = 0 then
      bars_audit.info(bars_msg.get_msg(g_modcode,
                                       'AUTOCLOS_ENTRY',
                                       p_branch));
    end if;
   /* COBUMMFO-6387
    select deposit_id, nd, vidd, rnk, acc, null, null, null, null, null
      bulk collect
      into l_dpt
      from (select d.deposit_id, d.nd, d.vidd, d.rnk, d.acc
              from dpt_deposit d
             where d.branch = p_branch
               and d.deposit_id = decode(p_dptid, 0, d.deposit_id, p_dptid)
               and d.dat_end <= p_bdate
            union all
            select d.deposit_id, d.nd, d.vidd, d.rnk, d.acc
              from dpt_deposit d, dpt_deposit_clos c
             where d.branch = p_branch
               and d.deposit_id = decode(p_dptid, 0, d.deposit_id, p_dptid)
               and d.deposit_id = c.deposit_id
               and c.action_id = 5
            union all
            select d.deposit_id, d.nd, d.vidd, d.rnk, d.acc
              from dpt_deposit d, dpt_depositw w
             where d.branch = p_branch
               and d.deposit_id = decode(p_dptid, 0, d.deposit_id, p_dptid)
                  --and d.dat_end    is null
               and d.deposit_id = w.dpt_id
               and w.tag = tag_2clos
               and w.value = val_2clos
            union all -- Майбутнє дітям
            select d.deposit_id, d.nd, d.vidd, d.rnk, d.acc
              from dpt_deposit d, person p
             where d.branch = p_branch
               and d.vidd in (53, 14)
               and d.rnk = p.rnk
               and p.bday is not null
               and d.dat_begin < add_months(p.bday, 12)
               and fkos(d.acc, d.datz, p_bdate) = 0
               and add_months(p.bday, 12) between dat_next_u(p_bdate, -1) and
                   p_bdate);
      */

    --COBUMMFO-6387
    select ddd.deposit_id, ddd.nd, ddd.vidd, ddd.rnk, ddd.acc,
    ia.acra,
               (case
                 when dv.amr_metr > 0 then
                  ia.acrb
                 else
                  null
               end),
         a.nls,
    a.kv,
               a.blkd
      bulk collect
      into l_dpt
      from (select d.deposit_id, d.nd, d.vidd, d.rnk, d.acc
              from dpt_deposit d
             where d.branch = p_branch
               and d.deposit_id = decode(p_dptid, 0, d.deposit_id, p_dptid)
               and d.dat_end <= p_bdate
            union all
            select d.deposit_id, d.nd, d.vidd, d.rnk, d.acc
              from dpt_deposit d, dpt_deposit_clos c
             where d.branch = p_branch
               and d.deposit_id = decode(p_dptid, 0, d.deposit_id, p_dptid)
               and d.deposit_id = c.deposit_id
               and c.action_id = 5
            union all
            select d.deposit_id, d.nd, d.vidd, d.rnk, d.acc
              from dpt_deposit d, dpt_depositw w
             where d.branch = p_branch
               and d.deposit_id = decode(p_dptid, 0, d.deposit_id, p_dptid)
                  --and d.dat_end    is null
               and d.deposit_id = w.dpt_id
               and w.tag = tag_2clos
               and w.value = val_2clos
            union all -- Майбутнє дітям
            select d.deposit_id, d.nd, d.vidd, d.rnk, d.acc
              from dpt_deposit d, person p
             where d.branch = p_branch
               and d.vidd in (53, 14)
               and d.rnk = p.rnk
               and p.bday is not null
               and d.dat_begin < add_months(p.bday, 12)
               and fkos(d.acc, d.datz, p_bdate) = 0
               and add_months(p.bday, 12) between dat_next_u(p_bdate, -1) and
                   p_bdate) ddd,
                   dpt_vidd dv,
                   accounts a,
                   int_accn ia
              where dv.vidd = ddd.vidd
                and a.acc = ddd.acc
                and a.acc = ia.acc
                and ia.id = 1
                and acc_closing_permitted(ia.acc, 0) = 1
                and acc_closing_permitted(ia.acra, 0) = 1
                and (dv.amr_metr = 0 or dv.amr_metr > 0 and acc_closing_permitted(ia.acrb, 0) = 1);

    for i in 1 .. l_dpt.count loop

      bars_audit.trace('%s deposit № %s',
                       title,
                       to_char(l_dpt(i).dptid) || '...');

      /* COBUMMFO-6387
       begin


        select a.nls,
               a.kv,
               i.acra,
               (case
                 when v.amr_metr > 0 then
                  i.acrb
                 else
                  null
               end),
               a.blkd
          into l_dpt(i).accnum,
               l_dpt(i).curid,
               l_dpt(i).intacc,
               l_dpt(i).amracc,
               l_dpt(i).blkd
          from dpt_vidd v, accounts a, int_accn i
         where v.vidd = l_dpt(i).dptype
           and a.acc = l_dpt(i).depacc
           and a.acc = i.acc
           and i.id = 1
           and acc_closing_permitted(i.acc, 0) = 1
           and acc_closing_permitted(i.acra, 0) = 1
           and (v.amr_metr = 0 or
               v.amr_metr > 0 and acc_closing_permitted(i.acrb, 0) = 1); */

        savepoint del_ok;

        begin

          -- рах. 2620 не закривається, якщо він є рах.погашення заборгованості в КД
          if ((substr(l_dpt(i).accnum, 1, 4) = '2620') and
             (check_belongs_credit(l_dpt(i).depacc) = 1)) then
            raise_application_error(-20666,
                                    'Рахунок ' || l_dpt(i).accnum ||
                                    '(dpt_id=' || to_char(l_dpt(i).dptid) ||
                                    ') використовується в КД!');
          end if;

          if (l_dpt(i).blkd > 0) then
            raise_application_error(-20666,
                                    'Рахунок ' || l_dpt(i).accnum ||
                                    '(dpt_id=' || to_char(l_dpt(i).dptid) ||
                                    ') арештовано !');
          end if;

          -- перенос вклада в архив
          close_to_archive(p_type  => 'DPT',
                           p_dat   => p_bdate,
                           p_dptid => l_dpt(i).dptid,
                           p_accid => null);
          -- закрытие основного счета
          close_to_archive(p_type  => 'ACC',
                           p_dat   => p_bdate,
                           p_dptid => null,
                           p_accid => l_dpt(i).depacc);
          -- закрытие счета начисленных процентов
          close_to_archive(p_type  => 'ACC',
                           p_dat   => p_bdate,
                           p_dptid => null,
                           p_accid => l_dpt(i).intacc);
          -- закрытие счета амортизации (только для авансовых вкладов)
          if l_dpt(i).amracc is not null then
            close_to_archive(p_type  => 'ACC',
                             p_dat   => p_bdate,
                             p_dptid => null,
                             p_accid => l_dpt(i).amracc);
          end if;
          bars_audit.trace('%s deposit № %s',
                           title,
                           to_char(l_dpt(i).dptid) || ' succ.closed.');

          -- запись в журнал
          dpt_jobs_audit.p_save2log(p_runid      => p_runid,
                                    p_dptid      => l_dpt(i).dptid,
                                    p_dealnum    => l_dpt(i).dptnum,
                                    p_branch     => p_branch,
                                    p_ref        => null,
                                    p_rnk        => l_dpt(i).custid,
                                    p_nls        => l_dpt(i).accnum,
                                    p_kv         => l_dpt(i).curid,
                                    p_dptsum     => null,
                                    p_intsum     => null,
                                    p_status     => 1,
                                    p_errmsg     => null,
                                    p_contractid => null);
        exception
          when others then
            bars_audit.error('Ошибка закрытия деп.договора № ' || l_dpt(i)
                             .dptnum || ' (' || to_char(l_dpt(i).dptid) ||
                             '): ' || substr(dbms_utility.format_error_stack() ||
                                             chr(10) ||
                                             dbms_utility.format_error_backtrace(),
                                             1,
                                             g_errmsg_dim));
            -- запись в журнал
            dpt_jobs_audit.p_save2log(p_runid      => p_runid,
                                      p_dptid      => l_dpt(i).dptid,
                                      p_dealnum    => l_dpt(i).dptnum,
                                      p_branch     => p_branch,
                                      p_ref        => null,
                                      p_rnk        => l_dpt(i).custid,
                                      p_nls        => l_dpt(i).accnum,
                                      p_kv         => l_dpt(i).curid,
                                      p_dptsum     => null,
                                      p_intsum     => null,
                                      p_status     => -1,
                                      p_errmsg     => substr(sqlerrm,
                                                             1,
                                                             g_errmsg_dim),
                                      p_contractid => null);
            rollback to del_ok;
        end;

     /* COBUMMFO-6387
       exception
        when no_data_found then
          bars_audit.trace('%s clos denied for deposit № %s',
                           title,
                           to_char(l_dpt(i).dptid));
      end; */

      l_cnt := l_cnt + 1;
      if l_cnt >= l_autocommit then
        bars_audit.info(title || ' autocommit');
        commit;
        l_cnt := 0;
      end if;
    end loop;

    if p_dptid = 0 then
      bars_audit.info(bars_msg.get_msg(g_modcode,
                                       'AUTOCLOS_DONE',
                                       p_branch));
      commit;
    end if;

  end auto_move2archive;
  
  ------------------
  procedure auto_move2archive_opt
  ( p_runid  in  dpt_jobs_jrnl.run_id%type -- Ід. запуску автомат.завдання
  , p_bdate  in  fdat.fdat%type            -- текущая банковская дата
  ) is
    title        constant varchar2(64) := $$PLSQL_UNIT||'AUTO_MOVE2ARCHIVE_OPT';
    l_jobid      constant dpt_jobs_list.job_id%type := 249; -- Ідентифікатор завдання
    l_runid      dpu_jobs_jrnl.run_id%type;                 -- Ідентификатор запуску
    type t_dptaccrec is record
    ( dptid      dpt_deposit.deposit_id%type
    , dptnum     dpt_deposit.nd%type
    , dptype     dpt_deposit.vidd%type
    , custid     dpt_deposit.rnk%type
    , depacc     accounts.acc%type
    , intacc     accounts.acc%type
    , amracc     accounts.acc%type
    , accnum     accounts.nls%type
    , curid      accounts.kv%type
    , blkd       accounts.blkd%type
    );
    type t_dptacclist is table of t_dptaccrec;
    t_dpt        t_dptacclist;
    l_branch     dpt_deposit.branch%type;
    l_errmsg     sec_audit.rec_message%type;
    cursor c_dpt
        is select d.DEPOSIT_ID, d.ND, d.VIDD, d.RNK, d.ACC
                , i.ACRA, case when v.amr_metr > 0 then i.ACRB else null end
                , a.NLS, a.KV, a.BLKD
             from ( select d.KF, d.DEPOSIT_ID, d.ND, d.VIDD, d.RNK, d.ACC
                      from DPT_DEPOSIT d
                     where d.DAT_END <= p_bdate
                     union all -- достроково повернуті
                    select d.KF, d.DEPOSIT_ID, d.ND, d.VIDD, d.RNK, d.ACC
                      from DPT_DEPOSIT d
                      join DPT_DEPOSIT_CLOS c
                        on ( c.KF = d.KF and c.DEPOSIT_ID = d.DEPOSIT_ID )
                     where d.DAT_END > p_bdate
                       and c.ACTION_ID = 5
                     union all
                    select d.KF, d.DEPOSIT_ID, d.ND, d.VIDD, d.RNK, d.ACC
                      from DPT_DEPOSIT d
                      join DPT_DEPOSITW w
                        on ( w.KF = d.KF and w.DPT_ID = d.DEPOSIT_ID )
                     where w.TAG   = '2CLOS'
                       and w.VALUE = 'Y'
                     union all -- Майбутнє дітям
                    select d.KF, d.DEPOSIT_ID, d.nd, d.vidd, d.rnk, d.acc
                      from DPT_DEPOSIT d
                      join PERSON p
                        on ( p.RNK = d.RNK )
                     where d.VIDD in (53,14)
                       and d.dat_begin < add_months(p.bday, 12)
                       and p.bday is not null
                       and FKOS(d.ACC,d.DATZ,p_bdate) = 0
                       and add_months(p.BDAY,12) between DAT_NEXT_U(p_bdate,-1) and p_bdate
                  ) d
             join ACCOUNTS a
               on ( a.KF = d.KF and a.ACC = d.ACC )
             join INT_ACCN i
               on ( i.KF = d.KF and i.ACC = d.ACC and i.ID = 1 )
             join DPT_VIDD v
               on ( v.VIDD = d.VIDD )
            where a.OSTC = 0
              and a.OSTB = 0
              and a.OSTF = 0;
  begin

    bars_audit.trace( '%s: Entry, runid=>%s, bdate=>%s', title, to_char(p_runid), to_char(p_bdate,'dd.mm.yyyy') );

    l_branch := sys_context('bars_context','user_branch');

    if ( length(l_branch)=8 )
    then
      dbms_application_info.set_module( g_modcode, 'AUTO_MOVE2ARCHIVE');
    else
      RAISE_APPLICATION_ERROR( -20666, 'Забрононено виконання '||to_char((length(l_branch)-1)/7)||' рівні!', true );
--    bars_error.raise_nerror( g_modcode, 'GENERAL_ERROR_CODE', 'Забрононено виконання рівні /' ); 
    end if;

    if ( nvl(p_runid,0)=0 )
    then -- фіксація старту виконання автоматичного завдання в журналі виконання
      DPT_JOBS_AUDIT.P_START_JOB( p_modcode => g_modcode
                                , p_jobid   => l_jobid
                                , p_branch  => l_branch
                                , p_bdate   => p_bdate
                                , p_run_id  => l_runid );
    else
      l_runid := p_runid;
    end if;

    bars_audit.info( bars_msg.get_msg( g_modcode, 'AUTOCLOS_ENTRY', l_branch ) );

    OPEN c_dpt;

    << FETCH_CRSR >>
    loop
      fetch c_dpt
       bulk collect
       into t_dpt
      limit 500;

      exit when t_dpt.count = 0;

      << CLS_DPT >>
      for i in 1 .. t_dpt.count
      loop

        bars_audit.trace( '%s: deposit № %s', title, to_char(t_dpt(i).dptid) || '...' );

        begin
          l_errmsg := null;

          case
          when ( ACC_CLOSING_PERMITTED(t_dpt(i).depacc,0) = 0 )
          then --
            l_errmsg := 'Рахунок #' || to_char(t_dpt(i).depacc) || ' залишок <> 0';
          when ( ACC_CLOSING_PERMITTED(t_dpt(i).intacc,0) = 0 )
          then --
            l_errmsg := 'Рахунок #' || to_char(t_dpt(i).intacc) || ' залишок <> 0';
          when ( t_dpt(i).amracc Is Not Null and ACC_CLOSING_PERMITTED(t_dpt(i).amracc,0) = 0)
          then --
            l_errmsg := 'Рахунок #' || to_char(t_dpt(i).amracc) || ' залишок <> 0';
          when ( t_dpt(i).accnum like '2620%' and CHECK_BELONGS_CREDIT(t_dpt(i).depacc) = 1 )
          then -- рах. 2620 не закривається, якщо він є рах.погашення заборгованості в КД
            l_errmsg := 'Рахунок ' || t_dpt(i).accnum ||' (dpt_id=' || to_char(t_dpt(i).dptid) ||') використовується в КД!';
            delete DPT_DEPOSITW where DPT_ID = t_dpt(i).dptid and TAG = '2CLOS';
          when ( t_dpt(i).blkd > 0 )
          then -- 
            l_errmsg := 'Рахунок ' || t_dpt(i).accnum ||' (dpt_id=' || to_char(t_dpt(i).dptid) ||') арештовано !';
          else
            savepoint del_ok;
            begin
              -- перенос вклада в архив
              CLOSE_TO_ARCHIVE( p_type  => 'DPT'
                              , p_dat   => p_bdate
                              , p_dptid => t_dpt(i).dptid
                              , p_accid => null );

              -- закрытие основного счета
              CLOSE_TO_ARCHIVE( p_type  => 'ACC'
                              , p_dat   => p_bdate
                              , p_dptid => null
                              , p_accid => t_dpt(i).depacc );

              -- закрытие счета начисленных процентов
              CLOSE_TO_ARCHIVE( p_type  => 'ACC'
                              , p_dat   => p_bdate
                              , p_dptid => null
                              , p_accid => t_dpt(i).intacc );
            
              -- закрытие счета амортизации (только для авансовых вкладов)
              if ( t_dpt(i).amracc is not null )
              then
                CLOSE_TO_ARCHIVE( p_type  => 'ACC'
                                , p_dat   => p_bdate
                                , p_dptid => null
                                , p_accid => t_dpt(i).amracc );
              end if;
            
              bars_audit.trace( '%s: deposit № %s', title, to_char(t_dpt(i).dptid) || ' succ.closed.' );
            exception
              when others then
                l_errmsg := substr( dbms_utility.format_error_stack() || dbms_utility.format_error_backtrace(), 1, g_errmsg_dim );
                bars_audit.error( 'Помилка при закритті деп.дог. № ' || t_dpt(i).dptnum || ' (' || to_char(t_dpt(i).dptid) || '): ' || l_errmsg );
                rollback to del_ok;
            end;
          end case;

          -- запись в журнал
          DPT_JOBS_AUDIT.P_SAVE2LOG( p_runid      => l_runid
                                   , p_dptid      => t_dpt(i).dptid
                                   , p_dealnum    => t_dpt(i).dptnum
                                   , p_branch     => l_branch
                                   , p_ref        => null
                                   , p_rnk        => t_dpt(i).custid
                                   , p_nls        => t_dpt(i).accnum
                                   , p_kv         => t_dpt(i).curid
                                   , p_dptsum     => null
                                   , p_intsum     => null
                                   , p_status     => case when l_errmsg is null then 1 else -1 end
                                   , p_errmsg     => l_errmsg
                                   , p_contractid => null );

        exception
          when no_data_found then
            bars_audit.trace( '%s: clos denied for deposit № %s', title, to_char(t_dpt(i).dptid) );
        end;

      end loop CLS_DPT;

      commit;

    end loop FETCH_CRSR;

    CLOSE c_dpt;

    if ( nvl(p_runid,0)=0 )
    then -- фіксація успішного завершення автоматичного завдання в журналі
      DPT_JOBS_AUDIT.P_FINISH_JOB( g_modcode, l_runid );
    end if;

    bars_audit.info( bars_msg.get_msg( g_modcode, 'AUTOCLOS_DONE', l_branch ) );

    dbms_application_info.set_module(NULL, NULL);
    dbms_application_info.set_client_info(NULL);

    --exception
    --  when OTHERS then
    --    bars_audit.error( title||chr(10)||dbms_utility.format_error_stack()||dbms_utility.format_error_backtrace() );
    --    -- фіксація завершення автоматичного завдання з помилкою в журналі
    --    DPT_JOBS_AUDIT.P_FINISH_JOB( g_modcode, l_runid, SubStr( dbms_utility.format_error_stack(), 1, g_errmsg_dim ) );
    --    dbms_application_info.set_module(NULL, NULL);
    --    dbms_application_info.set_client_info(NULL);
  end auto_move2archive_opt;
  
  --=======================================================================================
  procedure auto_rate_down(p_dptid  in dpt_deposit.deposit_id%type,
                           p_runid  in dpt_jobs_jrnl.run_id%type,
                           p_branch in dpt_deposit.branch%type,
                           p_bdate  in fdat.fdat%type) is
    title constant varchar2(60) := 'dptweb.autoratedown:';
    l_rate number(38) := 0;
  begin

    bars_audit.trace('%s branch=>%s, bdate=>%s, runid=>%s, dptid=>%s',
                     title,
                     p_branch,
                     to_char(p_bdate, 'dd.mm.yy'),
                     to_char(p_runid),
                     to_char(p_dptid));

    if (nvl(p_runid, 0) = 0 and p_dptid = 0) then
      bars_error.raise_nerror(g_modcode, g_jobrunidnotfound);
    end if;

    if p_dptid = 0 then
      bars_audit.info(bars_msg.get_msg(g_modcode,
                                       'AUTOAUTORATEDOWN_ENTRY',
                                       p_branch));
    end if;

    for d in (select /* весь депозитный портфель*/
               d.deposit_id dpt,
               d.nd         nd,
               d.dat_end    dat_end,
               d.rnk        rnk,
               a.acc        acc,
               a.nls        nls,
               a.kv         kv
                from dpt_deposit d, accounts a, int_accn i
               where d.acc = a.acc
                 and a.acc = i.acc
                 and i.id = 1
                 and d.dat_end <= p_bdate
                 and nvl(acrn.fproc(a.acc, d.dat_end), 1) != 0
                 and d.branch = p_branch
                 and p_dptid = 0
              union all
              select /* указанный депозитный договор*/
               d.deposit_id dpt,
               d.nd         nd,
               d.dat_end    dat_end,
               d.rnk        rnk,
               a.acc        acc,
               a.nls        nls,
               a.kv         kv
                from dpt_deposit d, accounts a, int_accn i
               where d.acc = a.acc
                 and a.acc = i.acc
                 and i.id = 1
                 and d.dat_end <= p_bdate
                 and nvl(acrn.fproc(a.acc, d.dat_end), 1) != 0
                 and d.branch = p_branch
                 and d.deposit_id = p_dptid
                 and p_dptid != 0
               order by 1) loop
      bars_audit.trace('%s вклад № %s', title, to_char(d.dpt));

      savepoint upd_ok;

      begin
        insert into int_ratn
          (acc, id, bdat, ir)
        values
          (d.acc, 1, d.dat_end, l_rate);
        -- запись в журнал
        bars_audit.financial('Изменена проц.ставка на 0% для вклада № ' ||
                             to_char(d.dpt));

        -- запись в журнал
        dpt_jobs_audit.p_save2log(p_runid      => p_runid,
                                  p_dptid      => d.dpt,
                                  p_dealnum    => d.nd,
                                  p_branch     => p_branch,
                                  p_ref        => null,
                                  p_rnk        => d.rnk,
                                  p_nls        => d.nls,
                                  p_kv         => d.kv,
                                  p_dptsum     => null,
                                  p_intsum     => null,
                                  p_status     => 1,
                                  p_errmsg     => null,
                                  p_contractid => null);
      exception
        when dup_val_on_index then
          null;
        when others then
          bars_audit.error('Ошибка изменения ставки на 0% для договора № ' ||
                           to_char(d.dpt) || ' : ' ||
                           substr(sqlerrm, 1, g_errmsg_dim));
          -- запись в журнал
          dpt_jobs_audit.p_save2log(p_runid      => p_runid,
                                    p_dptid      => d.dpt,
                                    p_dealnum    => d.nd,
                                    p_branch     => p_branch,
                                    p_ref        => null,
                                    p_rnk        => d.rnk,
                                    p_nls        => d.nls,
                                    p_kv         => d.kv,
                                    p_dptsum     => null,
                                    p_intsum     => null,
                                    p_status     => -1,
                                    p_errmsg     => substr(sqlerrm,
                                                           1,
                                                           g_errmsg_dim),
                                    p_contractid => null);
          rollback to upd_ok;
      end;

    end loop; --d

    if p_dptid = 0 then
      bars_audit.info(bars_msg.get_msg(g_modcode,
                                       'AUTOAUTORATEDOWN_DONE',
                                       p_branch));
      commit;
    end if;

  end auto_rate_down;
  -- =======================================================================================
  --
  -- внутр.процедура для автопереоформления: проверка допустимости переоформления вкладов
  --
  procedure intl_autoext_permit(p_dptlist in out t_dptextlist) is
    title constant varchar2(60) := 'dptweb.autoext.prmt:';
    l_query  dpt_vidd_extypes.ext_condition%type;
    l_permit number(1);
    l_cursor integer;
    l_tmpnum integer;
  begin

    bars_audit.trace('%s entry', title);

    l_query := null;

    for i in 1 .. p_dptlist.count loop

      bars_audit.trace('%s processing dpt № %s (%s)...',
                       title,
                       to_char(p_dptlist(i).dptid),
                       to_char(p_dptlist(i).extflag));

      if (p_dptlist(i).extflag is null and p_dptlist(i).extcond is not null) then

        if (l_query != p_dptlist(i).extcond) then
          dbms_sql.close_cursor(l_cursor);
          bars_audit.trace('%s cursor closed', title);
        end if;

        if (l_query is null or l_query != p_dptlist(i).extcond) then
          l_cursor := dbms_sql.open_cursor;
          bars_audit.trace('%s cursor opened', title);
          dbms_sql.parse(l_cursor, p_dptlist(i).extcond, dbms_sql.native);
          bars_audit.trace('%s cursor parsed', title);
        end if;

        begin
          dbms_sql.bind_variable(l_cursor, 'DPTID', p_dptlist(i).dptid);
          dbms_sql.define_column(l_cursor, 1, l_permit);
          l_tmpnum := dbms_sql.execute_and_fetch(l_cursor);
          dbms_sql.column_value(l_cursor, 1, l_permit);
        exception
          when others then
            dbms_sql.close_cursor(l_cursor);
            raise;
        end;
        bars_audit.trace('%s l_permit = %s', title, to_char(l_permit));

        p_dptlist(i).extflag := l_permit;

        l_query := p_dptlist(i).extcond;

      end if;

      bars_audit.trace('%s flag for dpt № %s - %s',
                       title,
                       to_char(p_dptlist(i).dptid),
                       to_char(p_dptlist(i).extflag));
    end loop;

    if l_query is not null then
      dbms_sql.close_cursor(l_cursor);
      bars_audit.trace('%s cursor closed', title);
    end if;

    bars_audit.trace('%s exit', title);

  end intl_autoext_permit;
  -- =======================================================================================
  --
  -- внутр.процедура для автопереоформления: доначисление процентов с формированием платежей
  --
  procedure intl_autoext_interest(p_dptdata in t_dptextdata, -- реквизиты договора
                                  p_errmsg  out g_errmsg%type) -- текст ошибки
   is
    title constant varchar2(60) := 'dptweb.autoext.int:';
    l_amount number(38);
    l_errflg boolean := false;
  begin

    bars_audit.trace('%s entry, dptid => %s',
                     title,
                     to_char(p_dptdata.dptid));

    insert into int_queue
      (kf,
       branch,
       deal_id,
       deal_num,
       deal_dat,
       cust_id,
       int_id,
       acc_id,
       acc_num,
       acc_cur,
       acc_nbs,
       acc_name,
       acc_iso,
       acc_open,
       acc_amount,
       int_details,
       int_tt,
       mod_code)
      select a.kf,
             a.branch,
             p_dptdata.dptid,
             p_dptdata.dptnum,
             p_dptdata.dptdat,
             a.rnk,
             1,
             a.acc,
             a.nls,
             a.kv,
             a.nbs,
             substr(a.nms, 1, 38),
             t.lcv,
             a.daos,
             null,
             null,
             '%%1',
             g_modcode
        from accounts a, tabval t
       where a.kv = t.kv
         and a.acc = p_dptdata.dptacc;

    make_int(p_dat2      => p_dptdata.datend,
             p_runmode   => 1,
             p_runid     => 0,
             p_intamount => l_amount,
             p_errflg    => l_errflg);

    if l_errflg then
      p_errmsg := substr(bars_msg.get_msg(g_modcode,
                                          'AUTOEXT_INTFAILED',
                                          p_dptdata.dptnum,
                                          to_char(p_dptdata.dptid),
                                          sqlerrm),
                         1,
                         g_errmsg_dim);
      bars_audit.trace('%s exit with %s', title, p_errmsg);
    else
      p_errmsg := null;
      bars_audit.trace('%s exit', title);
    end if;
  exception
    when others then
      p_errmsg := substr(bars_msg.get_msg(g_modcode,
                                          'AUTOEXT_INTFAILED',
                                          p_dptdata.dptnum,
                                          to_char(p_dptdata.dptid),
                                          sqlerrm),
                         1,
                         g_errmsg_dim);
      bars_audit.trace('%s exit with %s', title, p_errmsg);
  end intl_autoext_interest;
  -- =======================================================================================
  --
  -- внутр.процедура для автопереоформления: капитализация начисленных процентов на деп.счет
  --
  procedure intl_autoext_capitalize(p_dptdata in t_dptextdata, -- реквизиты договора
                                    p_bdate   in date, -- текущая дата
                                    p_branch  in branch.branch%type, -- текущее подразделение
                                    p_docref  out oper.ref%type, -- референс документа
                                    p_errmsg  out g_errmsg%type) -- текст ошибки
   is
    title constant varchar2(60) := 'dptweb.autoext.cap:';
    l_lang   char(1);
    l_nazn   oper.nazn%type;
    l_errflg boolean := false;
  begin

    bars_audit.trace('%s entry, dptid => %s',
                     title,
                     to_char(p_dptdata.dptid));

    l_lang := nvl(substr(getglobaloption('ERRLNG'), 1, 1), 'U');

    l_nazn := substr(bars_msg.get_msg(g_modcode, 'AUTOEXT_CAPDETAILS') || ' ' ||
                     f_nazn(l_lang, p_dptdata.dptid),
                     1,
                     160);

    paydoc(p_dptid    => p_dptdata.dptid,
           p_vdat     => p_bdate,
           p_brancha  => p_branch,
           p_branchb  => p_branch,
           p_nlsa     => p_dptdata.intnls,
           p_nlsb     => p_dptdata.dptnls,
           p_mfoa     => p_dptdata.intmfo,
           p_mfob     => p_dptdata.dptmfo,
           p_nama     => p_dptdata.intnam,
           p_namb     => p_dptdata.dptnam,
           p_ida      => p_dptdata.custcode,
           p_idb      => p_dptdata.custcode,
           p_kva      => p_dptdata.intcur,
           p_kvb      => p_dptdata.dptcur,
           p_sa       => p_dptdata.intsum,
           p_sb       => p_dptdata.intsum,
           p_nazn     => l_nazn,
           p_nmk      => p_dptdata.custname,
           p_dk       => 1,
           p_type     => 4,
           p_tt       => null,
           p_vob      => null,
           p_userid   => null,
           p_sk       => null,
           p_ref      => p_docref,
           p_err_flag => l_errflg,
           p_err_msg  => p_errmsg);

    bars_audit.trace('%s exit with %s, %s',
                     title,
                     to_char(p_docref),
                     p_errmsg);

  exception
    when others then
      p_docref := null;
      p_errmsg := substr(bars_msg.get_msg(g_modcode,
                                          'AUTOEXT_CAPFAILED',
                                          p_dptdata.dptnum,
                                          to_char(p_dptdata.dptid),
                                          sqlerrm),
                         1,
                         g_errmsg_dim);
      bars_audit.trace('%s exit with %s, %s',
                       title,
                       to_char(p_docref),
                       p_errmsg);
  end intl_autoext_capitalize;
  -- =======================================================================================
  --
  -- внутр.процедура для автопереоформления: перерегистрация вклада (изм. №,срока,суммы,ставки)
  --
  procedure intl_autoext_rewrite(p_bdate   in date,
                                 p_dptdata in out t_dptextdata,
                                 p_errmsg  out g_errmsg%type) is
    title constant varchar2(60) := 'dptweb.autoext.rwt:';
    l_mnthcnt   dpt_vidd.duration%type;
    l_dayscnt   dpt_vidd.duration_days%type;
    l_fixrate   dpt_vidd.basem%type;
    l_extype    dpt_vidd.extension_id%type;
    l_termtype  dpt_vidd.term_type%type;
    l_tmp       number(38);
    l_reviewdat date;
    l_bonus     int_ratn.ir%type;
    l_actrate   int_ratn.ir%type;
    l_indrate   int_ratn.ir%type;
    l_basrate   int_ratn.br%type;
    l_opid      int_ratn.op%type;
    l_min_summ  dpt_vidd.min_summ%type;
    l_br_id     dpt_vidd.br_id%type;
    l_prev_ir   int_ratn.ir%type;
    l_prev_br   int_ratn.br%type;
    l_prev_bdat int_ratn.bdat%type;
    l_bonus_cnt int := 0;
    l_bonusval  number;
    l_arest11   number := 0;
    l_type_cod  dpt_vidd.type_cod%type;

    function get_bonusval(p_deposit_id in dpt_deposit.deposit_id%type)
      return number is
      l_bonus_val_actual dpt_depositw.value%type;
      l_bonus_val        number;
    begin
      begin
        select value
          into l_bonus_val_actual
          from dpt_depositw
         where dpt_id = p_deposit_id
           and tag = 'BONUS';
        l_bonus_val := to_number(replace(l_bonus_val_actual, ',', '.'));
      exception
        when no_data_found then
          l_bonus_val := 0;
        when others then
          if sqlcode in (-1722, -6502) then
            l_bonus_val := 0;
            bars_audit.error(title ||
                             ' ERROR: Invalid number: dpt_depositw.value = ' ||
                             to_char(l_bonus_val_actual) ||
                             ' ; l_bonus_val := 0');
          else
            bars_audit.error(title || 'get_bonusval others' || sqlerrm);
          end if;
      end;
      return l_bonus_val;
    end;

  begin

    bars_audit.trace('%s entry, dptid => %s',
                     title,
                     to_char(p_dptdata.dptid));

    select duration,
           duration_days,
           basem,
           nvl(extension_id, 0),
           term_type,
           min_summ * 100,
           br_id,
           type_cod
      into l_mnthcnt,
           l_dayscnt,
           l_fixrate,
           l_extype,
           l_termtype,
           l_min_summ,
           l_br_id,
           l_type_cod
      from dpt_vidd
     where vidd = p_dptdata.dptype;
    -- № п/п переоформления
    p_dptdata.cntdubl := nvl(p_dptdata.cntdubl, 0) + 1;
    bars_audit.trace('%s p_dptdata.cntdubl(+)=> %s',
                     title,
                     to_char(p_dptdata.cntdubl));
    -- минимальная сумма вклада
    bars_audit.trace('%s l_min_summ(dpt_vidd)=> %s',
                     title,
                     to_char(l_min_summ));

    begin
      select sum(nvl(blkd, 0))
        into l_arest11
        from accounts
       where acc in
             (select accid from dpt_accounts where dptid = p_dptdata.dptid)
         and blkd = 11;
      bars_audit.trace('%s arested = %s, dptid => %s',
                       title,
                       case when l_arest11 > 0 then 'Y' else 'N' end,
                       to_char(p_dptdata.dptid));
    exception
      when no_data_found then
        l_arest11 := 0;
    end;
    --COBUSUPABS-3722

    begin
      select i.ir, i.br, i.bdat
        into l_prev_ir, l_prev_br, l_prev_bdat
        from int_ratn i
       where i.acc = p_dptdata.dptacc
         and i.id = 1
         and i.bdat = (select max(bdat)
                         from int_ratn
                        where id = 1
                          and acc = i.acc);
    exception
      when no_data_found then
        bars_error.raise_nerror(g_modcode,
                                'EXTENSION_RATE_NOT_FOUND',
                                to_char(p_dptdata.dptid));
    end;

    bars_audit.info('(l_prev_ir,l_prev_br,l_prev_bdat)=(' || l_prev_ir || ',' ||
                    l_prev_br || ',' || l_prev_bdat || ')');
    --/COBUSUPABS-3722
    -- если сумма остатка депозита меньше минимальной суммы вида вклада, то пролонгации не будет
    if l_min_summ is null or l_min_summ <= p_dptdata.dptsum then
      if l_termtype = 1 then
        -- дата начала действия договора
        p_dptdata.datbeg := p_dptdata.datend;

        -- дата окончания действия договора
        p_dptdata.datend := dpt.get_datend_uni(p_datbeg  => p_dptdata.datbeg,
                                               p_mnthcnt => l_mnthcnt,
                                               p_dayscnt => l_dayscnt,
                                               p_dptype  => p_dptdata.dptype);
      else
        -- дата закінчення договору ( + к-ть днів дії вкладу )
        l_reviewdat := p_dptdata.datend +
                       (p_dptdata.datend - p_dptdata.datbeg);

        p_dptdata.datbeg := p_dptdata.datend;
        p_dptdata.datend := l_reviewdat;
      end if;

      -- изменение №, срока и суммы договора
      update dpt_deposit
         set nd        = p_dptdata.dptnum,
             cnt_dubl  = p_dptdata.cntdubl,
             dat_begin = p_dptdata.datbeg,
             dat_end   = p_dptdata.datend,
             limit     = p_dptdata.dptsum
       where deposit_id = p_dptdata.dptid;
      bars_audit.trace('%s num -> %s, sum -> %s, dates -> %s-%s',
                       title,
                       p_dptdata.dptnum,
                       to_char(p_dptdata.dptsum),
                       to_char(p_dptdata.datbeg, 'dd.mm.yyyy'),
                       to_char(p_dptdata.datend, 'dd.mm.yyyy'));

      -- изменение дат погашения и стоп-дат по начислению процентов
      update accounts
         set mdate = p_dptdata.datend
       where acc = p_dptdata.dptacc;
      update accounts
         set mdate = p_dptdata.datend
       where acc = p_dptdata.intacc;
      update int_accn
         set stp_dat = p_dptdata.datend - 1
       where acc = p_dptdata.dptacc
         and id = 1;

      --#ifdef SBER
      bars_audit.trace('%s ratereview_extype № %s',
                       title,
                       to_char(l_extype));
      bars_audit.info('p_dptdata.dptdat = ' ||
                      to_char(p_dptdata.dptdat, 'dd/mm/yyyy') ||
                      ', l_extype =' || to_char(l_extype) ||
                      ', p_dptdata.cntdubl= ' ||
                      to_char(p_dptdata.cntdubl));
      for ext in (select indv_rate indv_rate,
                         oper_id oper_id,
                         base_rate base_rate,
                         method_id method_id,
                         dpt.get_datend_uni(p_dptdata.datbeg,
                                            term_mnth,
                                            term_days,
                                            null) intdat,
                         (select indv_rate
                            from dpt_vidd_extdesc
                           where type_id = l_extype
                             and oper_id is not null
                             and rownum = 1) indv_rate_first, -- первая прибавка при переходе с инд на базовую может быть не учтена, если пролонгация не первая, поэтому учитываем при переходе
                         (select oper_id
                            from dpt_vidd_extdesc
                           where type_id = l_extype
                             and oper_id is not null
                             and rownum = 1) oper_id_first
                    from (select indv_rate,
                                 type_id,
                                 oper_id,
                                 case
                                   when method_id not in (5, 9) then
                                    base_rate
                                   else
                                    (select v.br_id
                                       from dpt_vidd_update v
                                      where v.vidd = p_dptdata.dptype
                                        and idu = (select max(idu)
                                                   from dpt_vidd_update v
                                                   where v.vidd = p_dptdata.dptype
                                                     and dateu <= p_dptdata.dptdat + 0.99999))
                                 end base_rate,
                                 method_id,
                                 ext_num,
                                 lead(ext_num) over(partition by type_id order by ext_num) - 1 next_num,
                                 term_mnth,
                                 term_days
                            from dpt_vidd_extdesc
                           where type_id = l_extype)
                   where (p_dptdata.cntdubl between ext_num and next_num)
                      or (next_num is null and p_dptdata.cntdubl >= ext_num)
                   order by term_mnth, term_days) loop
        bars_audit.trace('%s rateereviewdat %s, rate = (%s, %s, %s/%s)',
                         title,
                         to_char(ext.intdat, 'dd.mm.yyyy'),
                         to_char(ext.indv_rate),
                         to_char(ext.oper_id),
                         to_char(ext.base_rate),
                         to_char(ext.method_id));
        l_indrate := null;
        l_basrate := null;
        l_opid    := null;

        if (ext.base_rate is not null) then

          case
            when ext.method_id = 0 then
              -- значение базовой ставки на дату оформления первичного вклада
              l_indrate := getbrat(p_dptdata.opened,
                                   ext.base_rate,
                                   p_dptdata.dptcur,
                                   p_dptdata.dptsum);

            when ext.method_id = 1 then
              -- значение базовой ставки на дату пролонгации вклада
              l_indrate := getbrat(ext.intdat,
                                   ext.base_rate,
                                   p_dptdata.dptcur,
                                   p_dptdata.dptsum);

            when ext.method_id = 2 then
              -- базовая ставка
              l_basrate := ext.base_rate;

            when ext.method_id = 3 then
              -- ставка яка діяла в момент заключення ДУ на пролонгацію

              begin

                select da.rate_value, -- ставка яка діяла в момент заключення ДУ на пролонгацію
                       da.bankdate -- банківська дата заключення ДУ на пролонгацію
                  into l_indrate, l_reviewdat
                  from dpt_agreements da
                 where da.dpt_id = p_dptdata.dptid
                   and da.agrmnt_type = 4
                   and da.agrmnt_state = 1
                   and da.bankdate < p_dptdata.datbeg; -- ДУ яка заключена до дати початку дії нового терміну

                if (l_indrate is null) then
                  l_indrate := getbrat(l_reviewdat,
                                       ext.base_rate,
                                       p_dptdata.dptcur,
                                       p_dptdata.dptsum);
                end if;

              exception
                when no_data_found then
                  -- Для обчислення %% ставки при автопереоформленні депозиту вказано невідомий метод
                  bars_error.raise_nerror(g_modcode,
                                          'EXTENSION_RATE_NOT_FOUND',
                                          to_char(p_dptdata.dptid));
                when others then
                  bars_audit.error(title || '4th method filed with err ' ||
                                   dbms_utility.format_error_stack() ||
                                   chr(10) ||
                                   dbms_utility.format_error_backtrace());
              end;

            when ext.method_id = 4 then
              -- базовая ставка по депозиту + збереження бонусної ставки та операції обчислення + бонус за пролонгацію
              begin
                bars_audit.trace('%s Ставка для лонгации 1 равнялась %s',
                                 title,
                                 to_char(ext.indv_rate_first));
                select distinct case
                                  when (nvl(l_prev_ir, 0) != 0 and
                                       nvl(l_prev_br, 0) = 0) then
                                   case
                                     when p_dptdata.cntdubl > 1 then
                                      ext.indv_rate_first
                                     else
                                      0
                                   end
                                  else
                                   last_value(ir)
                                   over(partition by acc order by bdat
                                        rows between unbounded
                                        preceding and unbounded following)
                                end as ir,
                                /*LAST_VALUE(br) over (partition by acc order by bdat rows between unbounded preceding and unbounded following) as br*/ --COBUSUPABS-3722
                                coalesce(l_br_id, ext.base_rate) as br, -- из настроек вида вклада, если не найден - из справочника dpt_vidd_extdesc для вида вклада     --/COBUSUPABS-3722
                                case
                                  when (nvl(l_prev_ir, 0) != 0 and
                                       nvl(l_prev_br, 0) = 0) then
                                   ext.oper_id_first
                                  else
                                   last_value(op)
                                   over(partition by acc order by bdat
                                        rows between unbounded
                                        preceding and unbounded following)
                                end as op
                  into l_indrate, l_basrate, l_opid
                  from bars.int_ratn
                 where acc = p_dptdata.dptacc
                   and id = 1
                   and bdat <= p_dptdata.datbeg; -- базова та індивідуальна ставка, яка діяла до дати початку дії нового терміну
              exception
                when no_data_found then
                  -- Для обчислення %% ставки при автопереоформленні депозиту не знайдено попередне значення
                  bars_error.raise_nerror(g_modcode,
                                          'EXTENSION_RATE_NOT_FOUND',
                                          to_char(p_dptdata.dptid));
                when others then
                  bars_audit.info(title || sqlerrm);
              end;
              ----4822

            when ext.method_id = 5 then
              -- код базовой ставки на дату оформления первичного вклада+ додаток з опису
              l_basrate := ext.base_rate; -- из настроек в виде вклада, на датуоткрітия договора
              l_indrate := get_bonusval(p_dptdata.dptid);
              l_opid    := ext.oper_id;

            when ext.method_id = 6 then
              -- значение базовой ставки на дату пролонгации вклада
              l_basrate := l_prev_br;
              l_indrate := get_bonusval(p_dptdata.dptid);
              l_opid    := ext.oper_id;

            when ext.method_id = 7 then
              -- базовая ставка по депозиту без збереження бонусної ставки та операції обчислення + бонус за пролонгацію
              l_indrate := get_bonusval(p_dptdata.dptid);
              l_basrate := coalesce(l_br_id, ext.base_rate);
              l_opid    := ext.oper_id;
            when ext.method_id = 8 then
              -- базовая ставка по депозиту на дату лонгации без збереження бонусної ставки та операції обчислення + бонус за пролонгацію
              dpt.fill_dptparams(p_dptdata.dptid, 'BONUS', null); -- если ставка зафиксирована - то расфиксируем
              l_indrate := 0; -- при пролонгации пересчитать бонусы, найти максимальный, исключить остальные - делает dpt_bonus.set_bonus (p_dptdata.dptid); внутри с помощью механизма dpt_bonus_complex
              l_basrate := case
                             when l_type_cod = 'MPRG' then
                              ext.base_rate
                             else
                              coalesce(l_br_id, ext.base_rate)
                           end;
              l_opid    := ext.oper_id;
            when ext.method_id = 9 then
              -- базовая ставка по депозиту на дату открытия без збереження бонусної ставки та операції обчислення + бонус за пролонгацію
              dpt.fill_dptparams(p_dptdata.dptid, 'BONUS', null); -- если ставка зафиксирована - то расфиксируем
              l_indrate := 0; -- при пролонгации пересчитать бонусы, найти максимальный, исключить остальные - делает dpt_bonus.set_bonus (p_dptdata.dptid); внутри с помощью механизма dpt_bonus_complex
              l_basrate := coalesce(l_br_id, ext.base_rate); --l_prev_br;
              l_opid    := ext.oper_id;
            when ext.method_id = 10 then
              -- базовая ставка по депозиту на дату открытия без збереження бонусної ставки та операції обчислення + бонус за пролонгацію
              dpt.fill_dptparams(p_dptdata.dptid, 'BONUS', null); -- если ставка зафиксирована - то расфиксируем
              l_indrate := 0; -- при пролонгации пересчитать бонусы, найти максимальный, исключить остальные - делает dpt_bonus.set_bonus (p_dptdata.dptid); внутри с помощью механизма dpt_bonus_complex
              l_basrate := l_prev_br;
              l_opid    := ext.oper_id;
            else
              -- Для обчислення %% ставки при автопереоформленні депозиту вказано невідомий метод
              bars_error.raise_nerror(g_modcode,
                                      'INVALID_EXTENSION_METHOD',
                                      to_char(ext.method_id));

          end case;

          if (ext.oper_id is not null) then

            if (l_basrate is not null and l_indrate is not null) --якщо зберігаємо попередне значення базової % та індив.%
             then

              l_indrate := case
                             when ext.oper_id = 1 then
                              l_indrate + ext.indv_rate
                             when ext.oper_id = 2 then
                              l_indrate - ext.indv_rate
                             when ext.oper_id = 3 then
                              l_indrate * ext.indv_rate
                             when ext.oper_id = 4 then
                              l_indrate / ext.indv_rate
                           end;

            elsif (l_basrate is not null) then

              l_indrate := ext.indv_rate;
              l_opid    := ext.oper_id;

            else

              l_indrate := case
                             when ext.oper_id = 1 then
                              l_indrate + ext.indv_rate
                             when ext.oper_id = 2 then
                              l_indrate - ext.indv_rate
                             when ext.oper_id = 3 then
                              l_indrate * ext.indv_rate
                             when ext.oper_id = 4 then
                              l_indrate / ext.indv_rate
                           end;

            end if;

          end if;

        else

          l_indrate := ext.indv_rate;

        end if;
        
        if nvl(l_arest11,0) = 0 then -- если счет арестован, бонусная ставка не устанавливается  -- COBUMMFO-7402
          
        bars_audit.info('start dpt_bonus.set_bonus for deposit_id = '||to_char(p_dptdata.dptid));
        dpt_bonus.set_bonus(p_dptdata.dptid);
        bars_audit.info('end dpt_bonus.set_bonus l_bonusval = '||to_char(l_bonusval));

        /*Если метод переоформления для вклада не (8,9,10) - убираем Эксклюзивный  (bonus_id = 4) 2017 года для вкладов с пролонгацией до 8,9,10 метода, так как его действие начинается в будущем (или не начинается)*/
        if (ext.method_id not in (8, 9, 10)) then
          update dpt_bonus_requests
             set bonus_value_fact = 0
           where dpt_id = p_dptdata.dptid
             and request_bdate = gl.bd
             and bonus_id = bars.dpt_bonus.get_bonus_id('EXCL'); --4; --Эксклюзивный 2017
        end if;

        /*
         -- COBUMMFO-6766
         -- Т.к. бонус за ЗП учитывается на дату открытия (или дату каждой 12й пролонгации), то он может быть изменен и в меньшую сторону
         -- поэтому эта проверка не нужна 
         
         select count(1)
          into l_bonus_cnt
          from dpt_bonus_requests t1, dpt_bonuses t2, dpt_requests t3
         where t1.dpt_id = p_dptdata.dptid
           and t1.bonus_id = t2.bonus_id
           and t3.dpt_id = t1.dpt_id
           and t1.req_id = t3.req_id
           and t3.reqtype_id = 1 -- запит на бонусну ставку
           and t2.bonus_confirm = 'N' -- не потребує додаткового підтвердження
           and t1.request_state = 'ALLOW'; -- запит погоджено автоматично;
        bars_audit.info('get_bonusval (p_dptdata.dptid)=' ||
                        to_char(get_bonusval(p_dptdata.dptid)));
                         
        if (l_bonus_cnt > 0) then 
        */
          dpt_bonus.set_bonus_rate(p_dptdata.dptid, ext.intdat, l_bonusval);
          bars_audit.trace('%s встановлена бонусна ставка = %s',
                           title,
                           to_char(l_bonusval));
        -- end if;
        
        l_indrate := nvl(l_indrate, 0) + nvl(l_bonusval, 0);
        bars_audit.info('get_bonusval (p_dptdata.dptid)=' ||
                        to_char(get_bonusval(p_dptdata.dptid)));
        
         begin
            insert into int_ratn
              (acc, id, bdat, ir, op, br)
            values
              (p_dptdata.dptacc,
               1,
               ext.intdat,
               l_indrate,
               l_opid,
               l_basrate);
          exception
            when dup_val_on_index then
              update int_ratn
                 set ir = l_indrate,
                     op = case
                            when nvl(l_indrate, 0) != 0 and
                                 nvl(l_opid, 0) = 0 then
                             1
                            else
                             l_opid
                          end,
                     br = l_basrate
               where acc = p_dptdata.dptacc
                 and id = 1
                 and bdat = ext.intdat;
          end;
        else 
          l_indrate := 0;
        end if;
          
        -- значення %% ставки
        if l_basrate is null then
          p_dptdata.rate := l_indrate;
        else
          p_dptdata.rate := getbrat(ext.intdat,
                                    ext.base_rate,
                                    p_dptdata.dptcur,
                                    p_dptdata.dptsum) + nvl(l_indrate, 0);
        end if;

        bars_audit.trace('%s new rate values on %s = (%s, %s, %s)',
                         title,
                         to_char(ext.intdat, 'dd.mm.yyyy'),
                         to_char(l_indrate),
                         to_char(l_opid),
                         to_char(l_basrate));

      end loop; -- ext
      bars_audit.trace('%s exit', title);
    else
      -- если сумма остатка депозита меньше минимальной суммы вида вклада, то пролонгации не будет
      --p_errmsg := 'Сума остатка на депозитному рахунку меньша за мінімальну суму виду вкладу';

      -- COBUMMFO-5162
      begin
      bars_audit.trace('%s встановлення ознаки дозволу на закриття вкладу до запитання dpt_id = %s',
                     title, to_char(p_dptdata.dptid));
      dpt.fill_dptparams(p_dptid => p_dptdata.dptid,
                         p_tag => '2CLOS',
                         p_val => 'Y');
      bars_audit.trace('%s Возврат депозита и начисленных процентов по окончанию депозитных договоров dpt_id = %s',
                     title, to_char(p_dptdata.dptid));

      auto_maturity_payoff(p_dptdata.dptid, 0, sys_context('bars_context','user_branch'), p_bdate);

      exception when others then
        p_errmsg := 'Не вдалося встановити ознаку дозволу на закриття вкладу та зробити возврат депозита та нарахування відсотків';
      end;
    end if;

  exception
    when others then
      p_errmsg := substr(bars_msg.get_msg(g_modcode,
                                          'AUTOEXT_REGFAILED',
                                          p_dptdata.dptnum,
                                          to_char(p_dptdata.dptid),
                                          sqlerrm),
                         1,
                         g_errmsg_dim);
      bars_audit.trace('%s exit with error %s sqlerrm %s',
                       title,
                       p_errmsg,
                       sqlerrm);
  end intl_autoext_rewrite;
  -- =======================================================================================

  -- Переоформление депозитных договоров (с перерегистрацией)
  procedure auto_extension(p_dptid  in dpt_deposit.deposit_id%type,
                           p_runid  in dpt_jobs_jrnl.run_id%type,
                           p_branch in dpt_deposit.branch%type,
                           p_bdate  in fdat.fdat%type) is
    title constant varchar2(60) := 'dptweb.autoext:';
    l_dptlist   t_dptextlist;
    l_dptdata   t_dptextdata;
    l_mindatend date;
    l_maxdatend date;
    l_docref    oper.ref%type;
    l_errmsg    g_errmsg%type;
    l_cnt       number(38) := 0;
    -- был ли Дт оборот в день окончания вклада, но перед переоформлением
    l_add_check varchar2(4000) := 'SELECT NVL ((SELECT 1
                                     FROM dpt_deposit d
                                    WHERE deposit_id = :dptid
                                      and nvl(forbid_extension,0) = 0
                                      and (   nvl((select sum(dos) from saldoa where acc = d.acc and fdat>= d.dat_end),0) = 0
                                           or vidd IN (SELECT vidd FROM DPT_DICT_VIDD_DEBTRANS))), 0) FROM DUAL';
    autext_expt exception;
  begin

    bars_audit.trace('%s branch=>%s, bdate=>%s, runid=>%s, dptid=>%s',
                     title,
                     p_branch,
                     to_char(p_bdate, 'dd.mm.yy'),
                     to_char(p_runid),
                     to_char(p_dptid));

    if p_dptid = 0 then
      bars_audit.info(bars_msg.get_msg(g_modcode,
                                       'AUTOEXT_STARTED',
                                       p_branch));
    end if;

    if (p_runid = 0 and p_dptid = 0) then
      bars_error.raise_nerror(g_modcode, g_jobrunidnotfound);
    end if;

    -- I. установка бонуса для пролонгированных вкладов
    auto_extension_bonus(p_dptid, p_runid, p_branch, p_bdate);

    -- определение диапазона дат закрытия вкладов-претендентов на переоформление
    l_mindatend := dat_next_u(p_bdate, -1); -- предыдущий банковский день
    if l_mindatend = trunc(sysdate) then
      -- предыдущий банковский день = календ.день
      l_maxdatend := l_mindatend;
    else
      l_maxdatend := trunc(sysdate) - 1; -- предыдущий календарный день
    end if;

    bars_audit.trace('%s datend range - (%s,%s)',
                     title,
                     to_char(l_mindatend, 'dd.mm.yyyy'),
                     to_char(l_maxdatend, 'dd.mm.yyyy'));

    -- II. отбор активных вкладов, для которых предусмотрено переоформление, дата
    -- окончания - сегодня или ближайшие выходные, без отказа от продления (т.е.
    -- не отбираем те вклады, от переоформления которых клиенты успели отказаться
    -- до граничной даты включительно)
    -- а також договора по яких заключили дод.угоду на автопролонгацію

    if (p_dptid = 0) then

      begin
        select d.deposit_id,
               d.nd,
               d.datz,
               v.comproc,
               nvl2(nvl(e.ext_condition, l_add_check), null, 1) ext_flag,
               nvl(e.ext_condition, l_add_check)
          bulk collect
          into l_dptlist
          from dpt_deposit d, dpt_vidd v, dpt_vidd_extypes e
         where d.vidd = v.vidd
           and v.fl_dubl = 2
           and v.amr_metr = 0
           and nvl(d.forbid_extension, 0) = 0 --TODO - доопрацювати пролонгацію по одному договору
           and v.extension_id = e.id(+)
           and d.dat_end >= l_mindatend
           and d.dat_end <= l_maxdatend
           and d.branch = p_branch
           and (nvl(v.term_dubl, 0) = 0 or v.term_dubl > nvl(d.cnt_dubl, 0))
           and not exists
         (select 1
                  from dpt_extrefusals r
                 where r.dptid = d.deposit_id
                   and r.req_state = 1
                   and r.req_bnkdat <=
                       dpt_web.get_extdatex(p_bdate, d.vidd, 1))
        union -- вклади по яких заключено дод.угоду на пролонгацію
        select d.deposit_id,
               d.nd,
               d.datz,
               v.comproc,
               nvl2(nvl(e.ext_condition, l_add_check), null, 1) ext_flag,
               nvl(e.ext_condition, l_add_check)
          from dpt_deposit d, dpt_vidd v, dpt_vidd_extypes e
         where d.vidd = v.vidd
           and v.extension_id = e.id(+)
           and nvl(d.forbid_extension, 0) = 0 --TODO - доопрацювати пролонгацію по одному договору
           and d.branch = p_branch
           and (d.deposit_id, d.dat_end) in
               (select dpt_id, dat_begin
                  from dpt_extconsent
                 where dat_begin >= l_mindatend
                   and dat_begin <= l_maxdatend)
         order by 5, 6; --(ext_flag, ext_condition)
      end;

    else
      -- p_dptid != 0
      begin
        select d.deposit_id,
               d.nd,
               d.datz,
               v.comproc,
               nvl2(nvl(e.ext_condition, l_add_check), null, 1),
               nvl(e.ext_condition, l_add_check)
          bulk collect
          into l_dptlist
          from dpt_deposit d, dpt_vidd v, dpt_vidd_extypes e
         where d.vidd = v.vidd
           and v.fl_dubl = 2
           and v.amr_metr = 0
           and v.extension_id = e.id(+)
              --       and nvl(D.FORBID_EXTENSION,0) =0  --TODO - доопрацювати пролонгацію по одному договору
           and d.dat_end >= l_mindatend
           and d.dat_end <= l_maxdatend
           and d.deposit_id = p_dptid
           and (nvl(v.term_dubl, 0) = 0 or v.term_dubl > nvl(d.cnt_dubl, 0))
           and not exists
         (select 1
                  from dpt_extrefusals r
                 where r.dptid = d.deposit_id
                   and r.req_state = 1
                   and r.req_bnkdat <=
                       dpt_web.get_extdatex(p_bdate, d.vidd, 1))
        union -- вклади по яких заключено дод.угоду на пролонгацію
        select d.deposit_id,
               d.nd,
               d.datz,
               v.comproc,
               nvl2(nvl(e.ext_condition, l_add_check), null, 1) ext_flag,
               e.ext_condition
          from dpt_deposit d, dpt_vidd v, dpt_vidd_extypes e
         where d.vidd = v.vidd
           and v.extension_id = e.id(+)
              --       and D.FORBID_EXTENSION <> 1--TODO - доопрацювати пролонгацію по одному договору
           and (d.deposit_id, d.dat_end) in
               (select dpt_id, dat_begin
                  from dpt_extconsent
                 where dpt_id = p_dptid
                   and dat_begin >= l_mindatend
                   and dat_begin <= l_maxdatend)
         order by 5, 6; --(ext_flag, ext_condition)
      end;
    end if;
    bars_audit.info(l_dptlist.count);
    -- проверка допустимости переоформления
    intl_autoext_permit(l_dptlist);

    for i in 1 .. l_dptlist.count loop

      bars_audit.trace('%s dpt № %s', title, to_char(l_dptlist(i).dptid));

      begin

        savepoint sp_extend;

        l_docref := null;
        l_errmsg := null;

        begin
          select d.deposit_id,
                 d.nd,
                 d.datz,
                 d.vidd,
                 d.cnt_dubl,
                 d.dat_begin,
                 d.dat_end,
                 c.rnk,
                 c.okpo,
                 substr(c.nmk, 1, 38),
                 c.ved,
                 c.ise,
                 r.rezid,
                 da.acc,
                 da.kf,
                 da.nls,
                 da.kv,
                 substr(da.nms, 1, 38),
                 da.ostc,
                 ia.acc,
                 ia.kf,
                 ia.nls,
                 ia.kv,
                 substr(ia.nms, 1, 38),
                 ia.ostc,
                 get_dptrate(da.acc, da.kv, da.ostc, p_bdate),
                 da.daos,
                 (case
                   when da.ostc != da.ostb then
                    -1
                   when da.ostc = 0 then
                    -2
                   else
                    null
                 end)
            into l_dptdata
            from dpt_deposit d,
                 accounts    da,
                 accounts    ia,
                 int_accn    i,
                 customer    c,
                 codcagent   g,
                 rezid       r
           where d.rnk = c.rnk
             and c.codcagent = g.codcagent
             and g.rezid = r.rezid
             and d.acc = da.acc
             and da.acc = i.acc
             and i.id = 1
             and i.acra = ia.acc
             and d.deposit_id = l_dptlist(i).dptid;
        exception
          when no_data_found then
            -- не найдены реквизиты вклада № %s
            l_errmsg := bars_msg.get_msg(g_modcode,
                                         'AUTOEXT_DPTNOTFOUND',
                                         to_char(l_dptlist(i).dptid));
            raise autext_expt;
        end;

        -- проверка наличия остатка и отсутствия незавизир.документов на деп.счете
        if l_dptdata.errcode = -1 then
          -- незавизир.документы на депозитном счете %s/%s
          l_errmsg := bars_msg.get_msg(g_modcode,
                                       'AUTOEXT_DENIED_1',
                                       l_dptdata.dptnls,
                                       to_char(l_dptdata.dptcur));
          raise autext_expt;
        end if;

        if l_dptdata.errcode = -2 then
          -- нулевой остаток на депозитном счете %s/%s
          l_errmsg := bars_msg.get_msg(g_modcode,
                                       'AUTOEXT_DENIED_2',
                                       l_dptdata.dptnls,
                                       to_char(l_dptdata.dptcur));
          raise autext_expt;
        end if;

        if nvl(l_dptlist(i).extflag, 0) != 1 then
          -- нарушение условий переоформления договора №%s
          l_errmsg := bars_msg.get_msg(g_modcode,
                                       'AUTOEXT_DENIED',
                                       to_char(l_dptlist(i).dptid));
          raise autext_expt;
        end if;

        -- допускается наличие незавизир.документов на счете нач.%% (м.б. бонус)
        select ostb
          into l_dptdata.intsum
          from accounts
         where acc = l_dptdata.intacc
           for update of ostb nowait;

        -- III. начисление процентов по дату окончания минус 1 день (включительно)
        intl_autoext_interest(p_dptdata => l_dptdata, p_errmsg => l_errmsg);
        if l_errmsg is not null then
          raise autext_expt;
        end if;

        -- учет суммы доначисления в кач-ве суммы для перечисления на деп.счет
        select ostb
          into l_dptdata.intsum
          from accounts
         where acc = l_dptdata.intacc;

        -- V. перерегистрация вклада (изменение №, срока, ставки и суммы договора)
        intl_autoext_rewrite(p_bdate   => p_bdate,
                             p_dptdata => l_dptdata,
                             p_errmsg  => l_errmsg);
        if l_errmsg is not null then
          raise autext_expt;
        end if;
        bars_audit.trace('%s deposit № %s succ.rewrited',
                         title,
                         to_char(l_dptdata.dptid));
        -- 4151 ставим блокировку инсайдерства с дебета основного счета при окончании вклада и перед выплатой
        cust_insider(l_dptdata.custid);
        --#ifdef IRR
        --      -- VI. расчет дисконта/премии по рыночной ставке
        --      insert into dpt_irrqueue (dpt_id, branch)
        --      values (l_dptlist(i).dptid, p_branch);
        --#endif

        -- промежуточная фиксация
        l_cnt := l_cnt + 1;
        if p_runid > 0 and l_cnt >= autocommit then
          commit;
          l_cnt := 0;
        end if;

      exception
        when autext_expt then
          if l_errmsg is not null and p_runid = 0 then
            bars_error.raise_nerror(g_modcode,
                                    'AUTOEXT_FAILED',
                                    l_dptlist(i).dptnum,
                                    to_char(l_dptlist(i).dptid),
                                    l_errmsg);
          end if;
          rollback to sp_extend;
      end;

      -- VII. протоколирование
      if p_runid > 0 then
        dpt_jobs_audit.p_save2log(p_runid      => p_runid,
                                  p_dptid      => l_dptlist(i).dptid,
                                  p_dealnum    => l_dptlist(i).dptnum,
                                  p_branch     => p_branch,
                                  p_ref        => l_docref,
                                  p_rnk        => l_dptdata.custid,
                                  p_nls        => l_dptdata.dptnls,
                                  p_kv         => l_dptdata.dptcur,
                                  p_dptsum     => l_dptdata.dptsum,
                                  p_intsum     => l_dptdata.intsum,
                                  p_status     => (case
                                                    when l_errmsg is not null then
                                                     -1
                                                    else
                                                     1
                                                  end),
                                  p_errmsg     => l_errmsg,
                                  p_contractid => null,
                                  p_rateval    => l_dptdata.rate);
      end if;

    end loop;

    if p_dptid = 0 then
      bars_audit.info(bars_msg.get_msg(g_modcode,
                                       'AUTOEXT_FINISHED',
                                       p_branch));
      commit;
    end if;

    bars_audit.trace('%s exit', title);

  end auto_extension;

  --
  --  Перенесення суми вкладу та відсотків на техн.вклад до запитання
  --
  procedure auto_move2dmnd(p_bdate in fdat.fdat%type) is
    l_title constant varchar2(60) := 'dptweb.automove2dmnd: ';
    l_branch branch.branch%type;
  begin

    l_branch := sys_context('bars_context', 'user_branch');

    if ((p_bdate is null) or (l_branch = '/')) then
      raise_application_error(-20001,
                              'ERR: Заборонено виконання вибраної функції під поточним користувачом !',
                              true);
    end if;

    for d in (select dptid, branch
                from v_dpt_move2dmnd
               where datend < dat_next_u(bankdate, -2)) loop
      savepoint sp_move2dmnd;

      if l_branch != d.branch then
        l_branch := d.branch;
        bars_context.subst_branch(l_branch);
      end if;

      begin
        dpt.move2dmnd(p_dptid => d.dptid, -- № вклада
                      p_tt    => 'DPX', -- код операции
                      p_vobnc => 6, -- вид.док.в нац.вал.
                      p_vobfc => 46 -- вид.док.в ин.вал.
                      );
      exception
        when others then
          bars_audit.error(l_title || ' помилка виконання по дог.#' ||
                           to_char(d.dptid) ||
                           dbms_utility.format_error_stack() || chr(10) ||
                           dbms_utility.format_error_backtrace());
          rollback to sp_move2dmnd;
      end;

    end loop;

    bc.set_context();

  end auto_move2dmnd;

  -- =======================================================================================
  -- Перенесення депозитів у "НЕРУХОМІ"
  --
  procedure auto_move2immobile(p_dptid in t_dptid, -- dpt_deposit.deposit_id%type,
                               p_runid in dpt_jobs_jrnl.run_id%type,
                               p_bdate in fdat.fdat%type) is
    title constant varchar2(60) := 'dptweb.automove2immobile:';
    type r_immobile_type is record(
      dpt_id    dpt_deposit.deposit_id%type,
      acc       dpt_deposit.acc%type,
      rnk       dpt_deposit.rnk%type,
      nd        dpt_deposit.nd%type,
      kv        dpt_deposit.kv%type,
      datz      dpt_deposit.datz%type,
      dat_begin dpt_deposit.dat_begin%type,
      dat_end   dpt_deposit.dat_end%type,
      branch    dpt_deposit.branch%type,
      acr_dat   int_accn.acr_dat%type,
      nls_dep   accounts.nls%type,
      nbs_dep   accounts.nbs%type,
      ob22_dep  accounts.ob22%type,
      ost_dep   accounts.ostb%type,
      nms_dep   accounts.nms%type,
      nls_int   accounts.nls%type,
      nbs_int   accounts.nbs%type,
      ob22_int  accounts.ob22%type,
      ost_int   accounts.ostb%type,
      nms_int   accounts.nms%type,
      nls_exp   accounts.nls%type,
      nbs_exp   accounts.nbs%type,
      ob22_exp  accounts.ob22%type,
      nmk       customer.nmk%type,
      okpo      customer.okpo%type,
      date_on   customer.date_on%type,
      country   customer.country%type,
      passp     person.passp%type,
      ser       person.ser%type,
      numdoc    person.numdoc%type,
      organ     person.organ%type,
      pdate     person.pdate%type,
      bday      person.bday%type,
      bplace    person.bplace%type,
      sex       person.sex%type,
      teld      person.teld%type,
      telw      person.telw%type,
      zip       customer_address.zip%type,
      domain    customer_address.domain%type,
      region    customer_address.region%type,
      locality  customer_address.locality%type,
      address   customer_address.address%type,
      nbs_term  accounts.nbs%type);
    r_immobile r_immobile_type;
    l_ref      oper.ref%type;
    l_tt       oper.tt%type := 'N24'; -- 'АСВ';
    l_dk       oper.dk%type := 1;
    l_vob      oper.vob%type := 6;
    l_mfo      oper.mfoa%type;
    l_bdate    oper.vdat%type;
    l_nazn     oper.nazn%type;
    l_sum      oper.s%type;
    l_branch   branch.branch%type;
    l_nls      accounts.nls%type;
    l_errflg   boolean := false;
    l_errmsg   g_errmsg%type := null;
    l_outmsg   barsweb_session_data.var_value%type;
    errors exception;
    ---
    -- пошук котлового рахунка (нерухомі вклади для РНВ із залишками більше 10 одиниць)
    ---
    function get_nls_immobile(p_nbs    in accounts.nbs%type,
                              p_kv     in accounts.kv%type,
                              p_branch in accounts.branch%type,
                              p_ob22   in accounts.ob22%type)
      return accounts.nls%type
    is
      l_nls    accounts.nls%type;
      l_ob22   accounts.ob22%type;
      l_branch accounts.branch%type;
    begin

      if (p_ob22 is null) then

        begin
          select ob22
            into l_ob22
            from dpt_immobile_ob22
           where r020 = p_nbs;
        exception
          when no_data_found then
            l_ob22 := case p_nbs
                        when '2620' then '30'
                        when '2630' then '46'
                        when '2635' then 'D3'
                        else null
                      end;
        end;

      else
        l_ob22 := p_ob22;
      end if;

      -- котлові рах. тільки на 2-му рівні
      l_branch := substr(p_branch,1,15);

      begin
        select a.nls
          into l_nls
          from accounts a
         where a.nbs = decode(p_nbs, '2635', '2630', p_nbs) --2635 в новом плане счетов стал 2630
           and a.kv = p_kv
           and a.branch = l_branch
           and a.ob22 = l_ob22
           and a.dazs is null
           and rownum = 1;
      exception
        when no_data_found then
          begin

            bars_error.raise_nerror( g_modcode, 'CONSACC_NOT_FOUND', p_nbs || '/' || p_kv || '|' || l_ob22 );

            -- -- 1) Установить код вал
            -- pul.Set_Mas_Ini('OP_BSOB_KV', to_char(p_kv) , 'Код вал для открытия счета');

            -- -- 2) проверить и открыть нужный счет (если не найден)
            -- OP_BS_OB1( p_branch, p_nbs||l_ob22 );

            -- -- 3) знайти відкритий рахунок
            -- l_nls := get_nls_immobile( p_nbs, p_kv, p_branch, l_ob22 );

          end;
      end;

      return l_nls;

    end get_nls_immobile;
    ---
    -- перевірка наявності руху коштів протягом трьох останніх років
    ---
    function check_conditions(p_dptid in dpt_deposit.deposit_id%type)
      return number
    is
      l_checked number;
    begin

      select case
               when exists (select 1
                       from saldoa s
                       join dpt_deposit d
                         on (d.acc = s.acc)
                      where d.deposit_id = p_dptid
                        and s.fdat > add_months(bankdate, -36)
                        and (s.kos > 0 or s.dos > 0)) then
                0
               else
                1
             end
        into l_checked
        from dual;

      return l_checked;

    end check_conditions;
    ---
  begin

    bars_audit.trace('%s start with: p_dptid.count = %s, p_runid = %s, p_bdate = %s.',
                     title,
                     to_char(p_dptid.count),
                     to_char(p_runid),
                     to_char(p_bdate, 'dd/mm/yyyy'));

    l_outmsg := null;
    l_mfo    := gl.amfo;
    l_branch := sys_context('bars_context', 'user_branch');

    if (p_bdate is null)
    then
      l_bdate := gl.bdate;
    else
      l_bdate := p_bdate;
    end if;

    for i in p_dptid.first .. p_dptid.last loop

      bars_audit.trace('%s dpt_id = %s.', title, to_char(p_dptid(i)));

      savepoint sp_immobile;

      begin

        -- перевірка на відповідність умовам для перенесення в нерухомі (відсутній рух коштів протягом останніх 3-х років)
        if (check_conditions(p_dptid(i)) = 0) then

          l_errmsg := 'Не відповідає умовам відбору для перенесення в нерухомі';

          raise errors;

        else

          begin

            select d.deposit_id as dpt_id,
                   d.acc,
                   d.rnk,
                   d.nd,
                   d.kv,
                   d.datz,
                   d.dat_begin,
                   d.dat_end,
                   d.branch,
                   i.acr_dat,
                   ad.nls as nls_dep,
                   ad.nbs as nbs_dep,
                   ad.ob22 as ob22_dep,
                   ad.ostb as ost_dep,
                   substr(ad.nms, 1, 38) as nms_dep,
                   ai.nls as nls_int,
                   ai.nbs as nbs_int,
                   ai.ob22 as ob22_int,
                   ai.ostb as ost_int,
                   substr(ai.nms, 1, 38) as nms_int,
                   ae.nls as nls_exp,
                   ae.nbs as nbs_exp,
                   ae.ob22 as ob22_exp,
                   c.nmk,
                   c.okpo,
                   c.date_on,
                   c.country,
                   p.passp,
                   p.ser,
                   p.numdoc,
                   p.organ,
                   p.pdate,
                   p.bday,
                   p.bplace,
                   p.sex,
                   p.teld,
                   p.telw,
                   ca.zip,
                   ca.domain,
                   ca.region,
                   ca.locality,
                   ca.address,
                   decode(sp.s181, 2, '2635', ad.nbs) nbs_term -- для довгострокового треба встановити вже неіснуючий 2635
              into r_immobile
              from dpt_deposit d
             inner join customer c
                on (c.rnk = d.rnk)
              left join person p
                on (p.rnk = d.rnk)
              left join customer_address ca
                on (ca.rnk = d.rnk and ca.type_id = 1)
             inner join int_accn i
                on (i.acc = d.acc and i.id = 1)
             inner join accounts ad
                on (ad.acc = i.acc)
             inner join accounts ai
                on (ai.acc = i.acra)
             inner join accounts ae
                on (ae.acc = i.acrb)
              left join specparam sp
                on (sp.acc = ad.acc)
             where d.deposit_id = p_dptid(i);
            -- for update of ad.ostb nowait;

            -- сума списання (тіло + відсотки)
            l_sum := (r_immobile.ost_dep + r_immobile.ost_int);

            if (l_sum > 0)
            then

              if (l_branch != r_immobile.branch)
              then
                l_branch := r_immobile.branch;
                bars_context.subst_branch(l_branch);
              end if;

              -- пошук котлового рахунка (нерухомі вклади для РНВ із залишками більше 10 одиниць)
              l_nls := get_nls_immobile(r_immobile.nbs_dep, 
                                        r_immobile.kv,
                                        r_immobile.branch,
                                        null);

              l_ref := null;

              gl.ref(l_ref);

              gl.in_doc3(ref_   => l_ref,
                         tt_    => l_tt,
                         dk_    => l_dk,
                         vob_   => l_vob,
                         nd_    => substr(to_char(l_ref), 1, 10),
                         pdat_  => sysdate,
                         vdat_  => l_bdate,
                         data_  => l_bdate,
                         datp_  => l_bdate,
                         mfoa_  => l_mfo,
                         nlsa_  => r_immobile.nls_dep,
                         kv_    => r_immobile.kv,
                         s_     => l_sum,
                         nam_a_ => r_immobile.nms_dep,
                         id_a_  => r_immobile.okpo,
                         nazn_  => substr( 'Списання в нерухомі коштів по договору № ' || f_nazn('U', r_immobile.dpt_id), 1, 160 ),
                         mfob_  => l_mfo,
                         nlsb_  => l_nls,
                         kv2_   => r_immobile.kv,
                         s2_    => l_sum,
                         nam_b_ => 'Нерухомі вклади для РНВ',
                         id_b_  => gl.aokpo,
                         id_o_  => null,
                         sk_    => null,
                         d_rec_ => null,
                         sign_  => null,
                         sos_   => null,
                         prty_  => 0,
                         uid_   => null);

              -- 1) Капіталізація нарахованих відсотків
              if (r_immobile.ost_int > 0)
              then
                -- DP5 - Виплата відсотків в нац.валюті (внутр)
                -- DPL - Виплата відсотків в ін.валюті (внутр)
                PAYTT( null
                     , l_ref
                     , l_bdate
                     , case when ( r_immobile.kv = gl.baseval ) then 'DP5' else 'DPL' end
                     , l_dk
                     , r_immobile.kv
                     , r_immobile.nls_int
                     , r_immobile.ost_int
                     , r_immobile.kv
                     , r_immobile.nls_dep
                     , r_immobile.ost_int );
              end if;

              -- 2) Списання в нерухомі
              paytt(null,
                    l_ref,
                    l_bdate,
                    l_tt,
                    l_dk,
                    r_immobile.kv,
                    r_immobile.nls_dep,
                    l_sum,
                    r_immobile.kv,
                    l_nls,
                    l_sum);

              -- 3) передача інформації в реєстр нерухомих
              migraas.dpt2immobile(p_source   => 'BARS', -- Источник вклада
                                   p_dptid    => r_immobile.dpt_id, -- id договора
                                   p_nd       => r_immobile.nd, -- номер договора
                                   p_dato     => r_immobile.datz, -- дата открытия вклада
                                   p_branch   => r_immobile.branch, -- номер подразделения ощадбанка в барсе
                                   p_nls      => r_immobile.nls_dep, -- Лицевой счет
                                   p_kv       => r_immobile.kv, -- Код валюты вклада
                                   p_ost      => l_sum, -- Остаток на вкладе в коп.
                                   p_sum      => l_sum, -- "Сумма в коп., которую нужно выплатить. Будет использоваться для наследников."
                                   p_datn     => r_immobile.acr_dat, -- Дата по которую начислены проценты
                                   p_bsd      => r_immobile.nbs_dep, -- Бал. рах. депозиту
                                   p_ob22de   => r_immobile.ob22_dep, -- OБ22 вклада
                                   p_bsn      => r_immobile.nbs_int, -- Бал. счет начисленных процентов';
                                   p_ob22ie   => r_immobile.ob22_int, -- "OB22 начисленных процентов"
                                   p_bsd7     => r_immobile.nbs_exp, -- "Бал. счет процентных затрат"
                                   p_ob22d7   => r_immobile.ob22_exp, -- OB22D7   IS 'OB22 процентных затрат';
                                   p_regdate  => r_immobile.date_on, -- REGDATE  IS 'Дата регистрации вкладчика';
                                   p_fio      => r_immobile.nmk, -- ПІБ
                                   p_idcode   => r_immobile.okpo, -- Идентификационный код
                                   p_landcod  => r_immobile.country, -- Код страны (гражданство)
                                   p_doctype  => r_immobile.passp, -- Тип документа (1-паспорт,2-свидетельство о рождении,3-военный билет,0-прочее)
                                   p_pasp_s   => r_immobile.ser, -- Серия документа
                                   p_pasp_n   => r_immobile.numdoc, -- Номер документа
                                   p_pasp_w   => r_immobile.organ, -- Кем выдан документ
                                   p_pasp_d   => r_immobile.pdate, -- Дата выдачи документа
                                   p_birthdat => r_immobile.bday, -- Дата рождения
                                   p_birthpl  => r_immobile.bplace, -- Место рождения
                                   p_sex      => r_immobile.sex, -- Пол (1-мужской, 2-женский)
                                   p_phone_h  => r_immobile.teld, -- Домашний телефон
                                   p_phone_j  => r_immobile.telw, -- Рабочий телефон
                                   p_postidx  => r_immobile.zip, -- Почтовый индекс
                                   p_region   => r_immobile.domain, -- Область
                                   p_district => r_immobile.region, -- Район
                                   p_city     => r_immobile.locality, -- Населений пункт
                                   p_address  => r_immobile.address, -- Адреса
                                   p_ref      => l_ref, -- реф. док. списання на нерухомі
                                   p_err      => l_errmsg -- возвращаемый текст (Ok - хорошо, иначе текст ошибки)
                                   );

              if (l_errmsg = 'Ok') then
               begin
                insert into bars.dpt_immobile
                  (dpt_id,
                   transfer_ref,
                   transfer_date,
                   transfer_author,
                   bank_date)
                values
                  (r_immobile.dpt_id, l_ref, sysdate, user_id, l_bdate);
                exception
                  when DUP_VAL_ON_INDEX then
                    update DPT_IMMOBILE
                       set TRANSFER_REF    = l_ref
                         , TRANSFER_DATE   = sysdate
                         , TRANSFER_AUTHOR = user_id
                         , BANK_DATE       = l_bdate
                     where DPT_ID = r_immobile.dpt_id;
                end;
                  
              else
                raise errors;
              end if;

            else

              -- якщо сума рівна нулю ...
              null;

            end if;

            -- Для вкладів "До запитання" проставляємо відмітку про закриття
            if (r_immobile.dat_end is null)
            then

              DPT.FILL_DPTPARAMS(p_dptid(i), '2CLOS', 'Y');

            end if;

          end;

        end if;

      exception
        when others then

          bars_audit.info( title || ' депозит #' ||  to_char(r_immobile.dpt_id) || ' error: ' ||
                          nvl( l_errmsg, sqlerrm || chr(10) || dbms_utility.format_error_backtrace() ) );

          if (p_runid > 0)
          then --  для автооперації записати помилку в журнал виконання автоматичних завдань

            null;

          else

            l_outmsg := ( l_outmsg || '<BR> депозит # ' || to_char(r_immobile.dpt_id) || '(' || nvl(l_errmsg, sqlerrm) || ');' );

          end if;

          rollback to sp_immobile;

      end;

    end loop;

    -- виклик процедури з WEB
    if ( web_utl.is_web_user = 1 )
    then

      if (l_outmsg is not null)
      then

        l_outmsg := 'Перенесення депозитів у картотеку нерухомих виконано з помилками:' || l_outmsg;

      end if;

      barsweb_session.set_varchar2('ERRORS', l_outmsg);

    end if;

    bc.set_context();

  end auto_move2immobile;

  -- =======================================================================================
  procedure auto_close_techacc(p_accid  in accounts.acc%type,
                               p_runid  in dpt_jobs_jrnl.run_id%type,
                               p_branch in branch.branch%type,
                               p_bdate  in fdat.fdat%type) is
    title constant varchar2(60) := 'dptweb.autoclostechacc:';
    l_dptid   v_dpt_tech_accounts.dpt_id%type;
    l_dptact  v_dpt_tech_accounts.dpt_active%type;
    l_techacc accounts%rowtype;
    -----------------------------------------------
    l_errmsg g_errmsg%type;
    err_num  number;
    err_par  varchar2(80);
  begin

    bars_audit.trace('%s branch=>%s, bdate=>%s, runid=>%s, accid=>%s',
                     title,
                     p_branch,
                     to_char(p_bdate, 'dd.mm.yy'),
                     to_char(p_runid),
                     to_char(p_accid));

    if (nvl(p_runid, 0) = 0 and p_accid = 0) then
      bars_error.raise_nerror(g_modcode, g_jobrunidnotfound);
    end if;

    if p_accid = 0 then
      bars_audit.info(bars_msg.get_msg(g_modcode,
                                       'AUTOCLOSTECHACC_ENTRY',
                                       p_branch));
    end if;

    -- перечень всех техн.счетов данного подразделения, уже закрытых ПЛАНОВО
    for t in (select dpt_id,
                     dpt_num,
                     dpt_active,
                     tech_dat_end_plan dat_close,
                     tech_custnum      rnk,
                     tech_accid        acc,
                     tech_accnum       nls,
                     tech_currency     kvcode,
                     tech_currencyid   kvid
                from v_dpt_tech_accounts
               where tech_dat_end_fact is null
                 and tech_dat_end_plan < p_bdate
                 and branch_id = p_branch
               order by 1) loop
      bars_audit.trace('%s техн.счет %s / %s',
                       title,
                       t.nls,
                       t.kvcode);

      select * into l_techacc from accounts where acc = t.acc;

      if (f_techacc_allow2close(t.acc) = 1) and (l_techacc.ostc = 0) and
         (l_techacc.ostb = 0) and (l_techacc.ostf = 0) and
         (l_techacc.dapp is null or l_techacc.dapp < p_bdate) then

        -- закрытие техн.счета
        update accounts set dazs = p_bdate where acc = t.acc;

        if sql%rowcount = 0 then
          l_errmsg := 'неможливо заповнити дату закриття';
          bars_audit.error('TECHACC_CLOSE(5): ' || l_errmsg);
          -- запись в журнал
          dpt_jobs_audit.p_save2log(p_runid      => p_runid,
                                    p_dptid      => t.dpt_id,
                                    p_dealnum    => t.dpt_num,
                                    p_branch     => p_branch,
                                    p_ref        => null,
                                    p_rnk        => t.rnk,
                                    p_nls        => t.nls,
                                    p_kv         => t.kvid,
                                    p_dptsum     => null,
                                    p_intsum     => null,
                                    p_status     => -1,
                                    p_errmsg     => substr(sqlerrm,
                                                           1,
                                                           g_errmsg_dim),
                                    p_contractid => null);
        else

          if t.dpt_active = 0 then
            -- основной вклад - в архиве
            delete from dpt_techaccounts where tech_acc = t.acc;

            if sql%rowcount = 0 then
              l_errmsg := 'помилка при розірванні звязку між' ||
                          ' техн.рах. та закритим вкладом';
              bars_audit.error('TECHACC_CLOSE(5): ' || l_errmsg);
              -- запись в журнал
              dpt_jobs_audit.p_save2log(p_runid      => p_runid,
                                        p_dptid      => t.dpt_id,
                                        p_dealnum    => t.dpt_num,
                                        p_branch     => p_branch,
                                        p_ref        => null,
                                        p_rnk        => t.rnk,
                                        p_nls        => t.nls,
                                        p_kv         => t.kvid,
                                        p_dptsum     => null,
                                        p_intsum     => null,
                                        p_status     => -1,
                                        p_errmsg     => substr(sqlerrm,
                                                               1,
                                                               g_errmsg_dim),
                                        p_contractid => null);
            else
              bars_audit.financial('TECHACC_CLOSE(5): закрыт техн.счет ' ||
                                   t.nls || ' ' || t.kvcode ||
                                   ' по закрытому вкладу № ' ||
                                   to_char(t.dpt_id));
              -- запись в журнал
              dpt_jobs_audit.p_save2log(p_runid      => p_runid,
                                        p_dptid      => t.dpt_id,
                                        p_dealnum    => t.dpt_num,
                                        p_branch     => p_branch,
                                        p_ref        => null,
                                        p_rnk        => t.rnk,
                                        p_nls        => t.nls,
                                        p_kv         => t.kvid,
                                        p_dptsum     => null,
                                        p_intsum     => null,
                                        p_status     => 1,
                                        p_errmsg     => null,
                                        p_contractid => null);
            end if;
          else

            -- основной вклад - активный
            update dpt_deposit
               set dpt_d       = null,
                   acc_d       = null,
                   mfo_d       = null,
                   nls_d       = null,
                   nms_d       = null,
                   okpo_d      = null,
                   dat_end_alt = null
             where acc_d = t.acc
               and deposit_id = t.dpt_id;

            if sql%rowcount = 0 then
              l_errmsg := 'помилка при видаленні інформації' ||
                          ' про техн.рах.з картки активного вкладу';
              bars_audit.error('TECHACC_CLOSE(5): ' || l_errmsg);
              dpt_jobs_audit.p_save2log(p_runid      => p_runid,
                                        p_dptid      => t.dpt_id,
                                        p_dealnum    => t.dpt_num,
                                        p_branch     => p_branch,
                                        p_ref        => null,
                                        p_rnk        => t.rnk,
                                        p_nls        => t.nls,
                                        p_kv         => t.kvid,
                                        p_dptsum     => null,
                                        p_intsum     => null,
                                        p_status     => -1,
                                        p_errmsg     => substr(l_errmsg,
                                                               1,
                                                               g_errmsg_dim),
                                        p_contractid => null);
            else
              bars_audit.financial('TECHACC_CLOSE(5): закрыт техн.счет ' ||
                                   t.nls || ' ' || t.kvcode ||
                                   ' по активному вкладу № ' ||
                                   to_char(t.dpt_id));
              dpt_jobs_audit.p_save2log(p_runid      => p_runid,
                                        p_dptid      => t.dpt_id,
                                        p_dealnum    => t.dpt_num,
                                        p_branch     => p_branch,
                                        p_ref        => null,
                                        p_rnk        => t.rnk,
                                        p_nls        => t.nls,
                                        p_kv         => t.kvid,
                                        p_dptsum     => null,
                                        p_intsum     => null,
                                        p_status     => 1,
                                        p_errmsg     => null,
                                        p_contractid => null);

            end if;

          end if; --основной вклад (не)акт.

        end if; -- закрытие счета

      else

        -- не выполнена хотя бы одна проверка допустимости закрытия техн.счета

        l_errmsg := 'закриття техн.рахунку недопустимо';

        bars_audit.error('TECHACC_CLOSE(5): ' || l_errmsg);

        dpt_jobs_audit.p_save2log(p_runid      => p_runid,
                                  p_dptid      => t.dpt_id,
                                  p_dealnum    => t.dpt_num,
                                  p_branch     => p_branch,
                                  p_ref        => null,
                                  p_rnk        => t.rnk,
                                  p_nls        => t.nls,
                                  p_kv         => t.kvid,
                                  p_dptsum     => null,
                                  p_intsum     => null,
                                  p_status     => -1,
                                  p_errmsg     => substr(l_errmsg,
                                                         1,
                                                         g_errmsg_dim),
                                  p_contractid => null);

      end if;

    end loop; -- t

    if p_accid = 0 then
      bars_audit.info(bars_msg.get_msg(g_modcode,
                                       'AUTOCLOSTECHACC_DONE',
                                       p_branch));
    end if;

  end auto_close_techacc;

  --========================================================================================
  function f_techacc_allow2close(p_accid accounts.acc%type) return number is
    l_enable number(1);
    l_dapp   accounts.dapp%type;
    l_ostb   accounts.ostb%type;
    l_ostc   accounts.ostc%type;
    l_ostf   accounts.ostf%type;
  begin
    bars_audit.trace('TECHACC_ALLOW2CLOSE: техн.счет acc=(' ||
                     to_char(p_accid) || ')');

    l_enable := 0;

    -- остатки на техн.счете
    begin
      select ostb, ostc, ostf, dapp
        into l_ostb, l_ostc, l_ostf, l_dapp
        from accounts
       where acc = p_accid;
    exception
      when no_data_found then
        bars_audit.trace('TECHACC_ALLOW2CLOSE: не найден счет acc=(' ||
                         to_char(p_accid) || ')');
        return l_enable;
    end;

    -- закрытие (и выплата) техн.счета допустимы при отсутствии план.документов
    if l_ostb = l_ostc and l_ostf = 0 then
      l_enable := 1;
    end if;

    bars_audit.trace('TECHACC_ALLOW2CLOSE: закрытие техн.счета ' || case when
                     l_enable = 1 then 'допустимо' else 'недопустимо' end);

    return l_enable;

  end f_techacc_allow2close;
  -- ======================================================================================
  procedure p_techacc_close(p_type   in number, -- тип закрытия: 1-план
                            p_accid  in accounts.acc%type,
                            p_dat    in fdat.fdat%type,
                            p_branch in branch.branch%type,
                            p_runid  in dpt_jobs_jrnl.run_id%type) is
    l_dptid   v_dpt_tech_accounts.dpt_id%type;
    l_dptact  v_dpt_tech_accounts.dpt_active%type;
    l_techacc accounts%rowtype;
  begin

    bars_audit.trace('TECHACC_CLOSE: подразделение: ' || p_branch ||
                     ', банк.дата: ' || to_char(p_dat, 'DD/MM/YYYY') ||
                     ', № запуска: ' || to_char(p_runid) ||
                     ', тип закрытия: ' || to_char(p_type));

    if p_type != 1 then
      -- Указан несуществующий тип закрытия
      bars_error.raise_error(g_modcode, 291, to_char(p_type));
    end if;

    bars_audit.trace('TECHACC_CLOSE(1): плановое закрытие');

    if f_techacc_allow2close(p_accid) != 1 then
      -- закрытие техн.счета недопустимо
      bars_error.raise_error(g_modcode, 292, to_char(p_accid));
    end if;

    -- № основного вклада и признак его активности для техн.счета
    select dpt_id, dpt_active
      into l_dptid, l_dptact
      from v_dpt_tech_accounts
     where tech_accid = p_accid;

    -- заполнение даты планового закрытия

    if l_dptact = 0 then
      -- основной вклад - в архиве

      update dpt_techaccounts
         set tech_datend = p_dat
       where tech_acc = p_accid;

      if sql%rowcount = 0 then
        -- не удалось заполнить дату планового закрытия техн.счета
        bars_error.raise_error(g_modcode, 293, to_char(p_accid));
      else
        bars_audit.trace('TECHACC_CLOSE(1): заполнена дата план.закрытия (вклад - в архиве)');
      end if;

    else
      -- основной вклад - активный

      update dpt_deposit set dat_end_alt = p_dat where acc_d = p_accid;

      if sql%rowcount = 0 then
        -- не удалось заполнить дату планового закрытия техн.счета
        bars_error.raise_error(g_modcode, 293, to_char(p_accid));
      else
        bars_audit.trace('TECHACC_CLOSE(1): заполнена дата план.закрытия (вклад - активный)');
      end if;

    end if;

  end p_techacc_close;
  -- ======================================================================================
  procedure p_tech_oper_update(p_ref  in oper.ref%type,
                               p_refl in oper.refl%type) is
  begin

    bars_audit.trace('p_tech_oper_update: ref зачисления = ' ||
                     to_char(p_ref) || ', ref комиссии   = ' ||
                     to_char(p_refl));

    update oper set refl = p_refl where ref = p_ref;

    if sql%rowcount = 0 then
      -- невозможно связать платеж-пополнение техн.счета с платежом-комиссией
      bars_error.raise_error(g_modcode,
                             294,
                             to_char(p_ref),
                             to_char(p_refl));
    else
      bars_audit.trace('p_tech_oper_update: привязка выполнена!');
    end if;

  end p_tech_oper_update;
  -- ======================================================================================
  procedure p_techacc_nocash_comiss(p_ref0 in oper.ref%type,
                                    p_ref  out oper.ref%type) is
    l_title   varchar2(60) := 'dpt_web.p_techacc_nocash_comiss: ';
    l_vdat    oper.vdat%type := gl.bdate;
    l_userid  oper.userid%type := gl.auid;
    l_basecur tabval.kv%type := gl.baseval;
    l_doc     oper%rowtype;
    l_tt      oper.tt%type;
    l_accrec  acc_rec;
    l_ref     oper.ref%type;
    l_amountc oper.s%type;
  begin

    bars_audit.trace('%s реф.безнал.пополнения = %s',
                     l_title,
                     to_char(p_ref0));

    -- реквизиты первичного документа
    begin
      select * into l_doc from oper where ref = p_ref0;
    exception
      when no_data_found then
        -- не найден документ безнал.пополнения техн.счета
        bars_error.raise_error(g_modcode, 295, to_char(p_ref0));
    end;
    bars_audit.trace('%s техн.счет = %s/%s, сумма пополнения = %s',
                     l_title,
                     l_doc.nlsb,
                     to_char(l_doc.kv2),
                     to_char(l_doc.s));

    -- поиск операции по взысканию комиссии за безнал.пополнение счета
    begin
      select tt_comiss
        into l_tt
        from v_techacc_operations
       where tt_comiss is not null
         and decode(l_doc.kv, l_basecur, tt_main_nc, tt_main_fc) = l_doc.tt;
    exception
      when no_data_found or too_many_rows then
        begin
          select tt_comiss
            into l_tt
            from v_techacc_operations
           where tt_comiss is not null
             and decode(l_doc.kv, l_basecur, tt_main_nc, tt_main_fc) =
                 (select decode(l_doc.kv, l_basecur, tt_main_nc, tt_main_fc)
                    from v_techacc_operations
                   where op_id = decode(l_doc.kv, l_basecur, 197, 198));
        exception
          when no_data_found then
            -- не найден код операции по взысканию комиссии за безнал.пополнение
            bars_error.raise_error(g_modcode, 296, to_char(p_ref0));
          when too_many_rows then
            -- невозможно однозначно определить код операции по взысканию комиссии за безнал.пополнение
            bars_error.raise_error(g_modcode, 297, to_char(p_ref0));
        end;
    end;
    bars_audit.trace('%s операция по взысканию комиссии = %s',
                     l_title,
                     l_tt);

    l_accrec.acc_num     := l_doc.nlsb;
    l_accrec.acc_cur     := l_doc.kv2;
    l_accrec.acc_name    := l_doc.nam_b;
    l_accrec.cust_name   := l_doc.nam_b;
    l_accrec.cust_idcode := l_doc.id_b;

    paydoc_nocash_commission(p_tt          => l_tt,
                             p_dptid       => null,
                             p_main_amount => l_doc.s,
                             p_main_curcod => l_doc.kv,
                             p_main_docref => p_ref0,
                             p_main_accrec => l_accrec,
                             p_vdate       => l_vdat,
                             p_userid      => l_userid,
                             p_ref         => l_ref,
                             p_amount      => l_amountc);

    bars_audit.trace('%s референс платежа - комиссии = %s, сумма комиссии = %s',
                     l_title,
                     to_char(l_ref),
                     to_char(l_amountc));

    dpt_web.p_tech_oper_update(p_ref0, l_ref);

    bars_audit.trace('%s выполнена привязка комиссии к платежу пополнения (%s <-> %s)',
                     l_title,
                     to_char(p_ref0),
                     to_char(l_ref));

    p_ref := l_ref;

  end p_techacc_nocash_comiss;

  -- ======================================================================================
  --
  --
  function techacc_open_comiss_taken(p_dptid  in dpt_deposit.deposit_id%type,
                                     p_typeop in dpt_op.id%type) return char is
    l_title varchar2(60) := 'dpt_web.techacc_open_comiss_taken: ';
    l_taken char(1);
    l_tt    tts.tt%type;
  begin
    bars_audit.trace('%s договор № %s, тип операции - %s',
                     l_title,
                     to_char(p_dptid),
                     to_char(p_typeop));

    select tt_comiss
      into l_tt
      from v_techacc_operations
     where op_id = p_typeop;
    bars_audit.trace('%s код операции по взысканию комиссии - %s',
                     l_title,
                     l_tt);

    select decode(count(*), 0, 'N', 'Y')
      into l_taken
      from dpt_payments d, oper o
     where d.ref = o.ref
       and d.dpt_id = p_dptid
       and o.tt = l_tt
       and o.sos > 0;
    bars_audit.trace('%s комиссия была взыскана? - %s',
                     l_title,
                     l_taken);

    return l_taken;

  exception
    when no_data_found then
      bars_audit.trace('%s взыскание комиссии не предусмотрено',
                       l_title);
      return null;
  end techacc_open_comiss_taken;
  -- ======================================================================================
  function f_nazn(p_type   char, -- U / R = укр / рус
                  p_dpt_id dpt_deposit.deposit_id%type) -- идентификатор вклада
   return varchar2 is
    l_dealnum  dpt_deposit.nd%type;
    l_dealdat  dpt_deposit.datz%type;
    l_datbegin dpt_deposit.dat_begin%type;
    l_nazn     oper.nazn%type;
  begin

    begin
      select nvl(nd, to_char(deposit_id)), datz, dat_begin
        into l_dealnum, l_dealdat, l_datbegin
        from dpt_deposit
       where deposit_id = p_dpt_id;
    exception
      when no_data_found then
        begin
          select nvl(nd, to_char(deposit_id)), datz, dat_begin
            into l_dealnum, l_dealdat, l_datbegin
            from dpt_deposit_clos
           where idupd = (select max(idupd)
                            from dpt_deposit_clos
                           where deposit_id = p_dpt_id);
        exception
          when no_data_found then
            return null;
        end;
    end;

    l_nazn := l_dealnum || case
                when p_type = 'R' then
                 ' от '
                else
                 ' від '
              end || f_dat_lit(l_dealdat, p_type);

    return l_nazn;

  end f_nazn;
  -- ======================================================================================
  function get_tt(p_type     dpt_op.id%type, -- тип депозитной операции
                  p_interpay number, -- 0 = внутрибанк  / 1 = межбанк
                  p_cardpay  number, -- 0 = стандартный / 1 = карточный
                  p_currency tabval.kv%type -- код валюты
                  --   p_deal      signtype default 0 -- 0 = депозити ФО / 1 = депозити ЮО
                  ) return char is
    l_title varchar2(60) := 'dpt_web.get_tt: ';
    l_type  dpt_op.id%type;
    l_tt    tts.tt%type;
    p_tagname constant op_rules.tag%type := 'DPTOP';
  begin

    bars_audit.trace('%s тип операции = %s, МБ / КАРТ / ВАЛ = (%s, %s, %s)',
                     l_title,
                     to_char(p_type),
                     to_char(p_interpay),
                     to_char(p_cardpay),
                     to_char(p_currency));

    -- в Сбербанке для выплаты депозита /процентов исп.единая операция PKR
    if p_cardpay = 1 then
      l_tt := cardpay_tt;
      bars_audit.trace('%s код операции = %s', l_title, l_tt);
      return l_tt;
    end if;

    l_type := case
                when (p_type = 2 and p_cardpay = 1) then
                 23 -- возврат депозита на карточку
                when (p_type = 2 and p_interpay = 1) then
                 26 -- возврат депозита на межбанк
                when (p_type = 2 and p_interpay = 0) then
                 23 -- возврат депозита на внутрибанк
                when (p_type = 4 and p_cardpay = 1) then
                 43 -- выплата процентов на карточку
                when (p_type = 4 and p_interpay = 1) then
                 46 -- выплата процентов на межбанк
                when (p_type = 4 and p_interpay = 0) then
                 43 -- выплата процентов на внутрибанк
                else
                 p_type
              end;
    bars_audit.trace('%s тип операции (полный) = %s',
                     l_title,
                     to_char(l_type));
    begin
      select t.tt
        into l_tt
        from tts t, op_rules r, dpt_op
       where t.tt = r.tt
         and r.tag = p_tagname
         and trim(r.val) = to_char(dpt_op.id)
            --     AND t.tt NOT LIKE 'DU%'
         and t.tt like 'DP_'
         and dpt_op.id = l_type
         and t.kv = p_currency;
    exception
      when no_data_found then
        begin
          select t.tt
            into l_tt
            from tts t, op_rules r, dpt_op
           where t.tt = r.tt
             and r.tag = p_tagname
             and trim(r.val) = to_char(dpt_op.id)
                --         AND t.tt NOT LIKE 'DU%'
             and t.tt like 'DP_'
             and dpt_op.id = l_type
             and t.kv is null
             and rownum = 1;
        exception
          when no_data_found then
            -- не найдена операция
            bars_error.raise_error(g_modcode,
                                   401,
                                   to_char(p_type) || '/' ||
                                   to_char(p_interpay));
        end;
      when too_many_rows then
        begin
          select t.tt
            into l_tt
            from tts t, op_rules r, dpt_op
           where t.tt = r.tt
             and r.tag = p_tagname
             and trim(r.val) = to_char(dpt_op.id)
                --         AND t.tt NOT LIKE 'DU%'
             and t.tt like 'DP_'
             and dpt_op.id = l_type
             and t.kv = p_currency
             and rownum = 1;
        end;
    end;
    bars_audit.trace('%s код операции = %s', l_title, l_tt);

    return l_tt;

  end get_tt;
  -- ======================================================================================
  function get_nazn(p_tt     tts.tt%type,
                    p_dptid  dpt_deposit.deposit_id%type,
                    p_dptnum dpt_deposit.nd%type,
                    p_dptdat dpt_deposit.datz%type) return varchar2 is
    l_title  varchar2(60) := 'dpt_web.get_nazn: ';
    l_nazn   tts.nazn%type;
    l_length integer;
    l_posb   integer;
    l_pose   integer;
    l_tail   varchar2(250);
    l_func   varchar2(250);
    l_result varchar2(250);
  begin

    bars_audit.trace('%s: договор № %s, код операции %s',
                     l_title,
                     to_char(p_dptid),
                     p_tt);

    select trim(nazn) into l_nazn from tts where tt = p_tt;

    if p_tt = '%%1' then
      -- нарахування відсотків по договору № %s від %s
      l_tail := bars_msg.get_msg(g_modcode,
                                 'INT_DOCDTL',
                                 trim(p_dptnum),
                                 f_dat_lit(p_dptdat, 'U'));
    elsif p_tt = cardpay_tt then
      -- выплата депозита /процентов на карточный счет в Сбербанке
      -- перерахування коштів згідно договору № %s від %s
      l_tail := substr(bars_msg.get_msg(g_modcode, 'PKR_DOCDTL') ||
                       dpt_web.f_nazn(substr(bars_msg.get_lang, 1, 1),
                                      p_dptid),
                       1,
                       160);
    elsif l_nazn is null then
      -- не описано назначение платежа для операции
      bars_error.raise_error(g_modcode, 300, p_tt);
    else

      l_length := length(l_nazn);
      l_tail   := l_nazn;
      l_tail   := substr(replace(l_tail, '#(ND)', to_char(p_dptid)), 1, 160);
      l_posb   := instr(l_tail, '#{', 1);
      l_pose   := instr(l_tail, '}', 1);

      while l_posb > 0 loop

        bars_audit.trace('%s: l_tail = %s, l_posB = %s, l_posE = %s',
                         l_title,
                         l_tail,
                         to_char(l_posb),
                         to_char(l_pose));

        l_func := substr(l_tail, l_posb + 1, l_pose - l_posb);
        l_func := replace(l_func, '{', '');
        l_func := replace(l_func, '}', '');
        l_func := 'SELECT ' || l_func || ' FROM dual';

        bars_audit.trace('%s: l_func = %s', l_title, l_func);

        begin
          execute immediate l_func
            into l_result;
        exception
          when others then
            -- невозможно рассчитать назначение платежа по формуле из карточки операции
            bars_error.raise_error(g_modcode, 301, p_tt, l_nazn);
        end;

        bars_audit.trace('%s: l_result = %s', l_title, l_result);

        l_tail := substr(l_tail, 1, l_posb - 1) || l_result ||
                  substr(l_tail, l_pose + 1);
        l_posb := instr(l_tail, '#{', 1);
        l_pose := instr(l_tail, '}', 1);

      end loop;

    end if;

    l_nazn := substr(l_tail, 1, 160);
    bars_audit.trace('%s: назначение платежа = %s',
                     l_title,
                     l_nazn);

    return l_nazn;

  end get_nazn;
  -- ======================================================================================
  function get_vob(p_kva  tabval.kv%type,
                   p_kvb  tabval.kv%type,
                   p_tt   tts.tt%type default null,
                   p_type dpt_op.id%type default null) return number is
    l_title varchar2(60) := 'dpt_web.get_vob: ';
    l_vob   vob.vob%type;
  begin

    bars_audit.trace('%s валА = %s, валБ = %s, код/тип операции = %s/%s',
                     l_title,
                     to_char(p_kva),
                     to_char(p_kvb),
                     p_tt,
                     to_char(p_type));

    if p_tt is not null then
      begin
        select vob into l_vob from tts_vob where tt = p_tt;
        bars_audit.trace('%s вид обработки для операции %s = %s',
                         l_title,
                         p_tt,
                         to_char(l_vob));
      exception
        when no_data_found or too_many_rows then
          l_vob := null;
      end;
    end if;

    if l_vob is null then
      if (p_kva <> p_kvb) then
        l_vob := 16;
      elsif (p_kva = gl.baseval) then
        l_vob := 6;
      else
        l_vob := 46;
      end if;
      bars_audit.trace('%s вид обработки для валют (%s - %s) = %s',
                       l_title,
                       to_char(p_kva),
                       to_char(p_kvb),
                       to_char(l_vob));
    end if;

    bars_audit.trace('%s вид обработки = %s',
                     l_title,
                     to_char(l_vob));

    return l_vob;

  end get_vob;
  -- ======================================================================================
  function get_amount(p_tt        tts.tt%type,
                      p_formula   tts.s%type,
                      p_dealnum   varchar2,
                      p_ref       oper.ref%type,
                      p_suma      oper.s%type,
                      p_sumb      oper.s2%type,
                      p_curcodea  oper.kv%type,
                      p_curcodeb  oper.kv2%type,
                      p_amountm   oper.s%type,
                      p_curcodem  oper.kv%type,
                      p_accnuma   oper.nlsa%type,
                      p_accnumb   oper.nlsb%type,
                      p_bankcodea oper.mfoa%type,
                      p_bankcodeb oper.mfob%type) return number is
    l_title   varchar2(60) := 'dpt_web.get_amount: ';
    l_formula varchar2(3000);
    l_result  varchar2(3000);
    l_amount  number;
  begin

    bars_audit.trace('%s операция %s, формула = %s',
                     l_title,
                     p_tt,
                     p_formula);

    if p_formula is not null then
      l_formula := p_formula;

      l_formula := replace(l_formula, '#(ND)', to_char(p_ref));
      l_formula := replace(l_formula, '#(REF)', to_char(p_dealnum));
      l_formula := replace(l_formula, '#(S)', to_char(p_suma));
      l_formula := replace(l_formula, '#(S2)', to_char(p_sumb));
      l_formula := replace(l_formula, '#(KV)', to_char(p_curcodea));
      l_formula := replace(l_formula, '#(KV2)', to_char(p_curcodeb));
      l_formula := replace(l_formula, '#(SMAIN)', to_char(p_amountm));
      l_formula := replace(l_formula, '#(KVMAIN)', to_char(p_curcodem));
      l_formula := replace(l_formula, '#(NLSA)', '''' || p_accnuma || '''');
      l_formula := replace(l_formula, '#(NLSB)', '''' || p_accnumb || '''');
      l_formula := replace(l_formula,
                           '#(MFOA)',
                           '''' || p_bankcodea || '''');
      l_formula := replace(l_formula,
                           '#(MFOB)',
                           '''' || p_bankcodeb || '''');

      bars_audit.trace('%s формула с подстановками =  %s',
                       l_title,
                       l_formula);

      begin
        execute immediate 'SELECT ' || l_formula || ' FROM dual'
          into l_result;
      exception
        when others then
          -- невозможно рассчитать сумму комиссии по формуле из карточки операции
          bars_error.raise_error(g_modcode, 303, p_tt);
      end;
      bars_audit.trace('%s значение формулы =  %s',
                       l_title,
                       l_result);

      begin
        l_amount := to_number(l_result);
      exception
        when value_error then
          -- ошибка преобразования в число суммы комиссии
          bars_error.raise_error(g_modcode, 304, l_result);
      end;

    else
      l_amount := 0;
    end if;

    bars_audit.trace('%s сумма = %s', l_title, to_char(l_amount));

    return l_amount;

  end get_amount;

  -- ======================================================================================
  -- розрахунок комісії при достроковому розірванні договору
  -- за виплату коштів що надійшли безготівковим шляхом
  --
  function f_get_nocash_commis(p_dptid  in dpt_deposit.deposit_id%type,
                               p_acc    in dpt_deposit.acc%type,
                               p_datbeg in dpt_deposit.dat_begin%type,
                               p_kv     in dpt_deposit.kv%type) return number is
    l_sum_nocash number;
    l_bdate      date;
  begin
    l_bdate := gl.bdate;

    bars_audit.trace('F_GET_NOCASH_COMMIS: start with: dpt_id = %s, acc = %s, kv = %s, bdate = %s.',
                     to_char(p_dptid),
                     to_char(p_acc),
                     to_char(p_kv),
                     to_char(l_bdate, 'dd/mm/yyyy'));

    -- BRSMAIN-2411 (пошук суми безготівкових зарахувань по міжбанку або від іншого клієнта, що надійшли після 27.02.2014 р.)
    -- BRSMAIN-3082 (пошук суми безготівкових зарахувань по міжбанку: 1) від іншого клієнта; 2) надійшли після 27.02.2014 р.; 3) надійшли не з Ощадбанку)
    -- COBUSUPABS-3240 (пошук суми безготівкового зарахування коштів клієнтів з рахунків 2625 на рах. 2620/30/35 потрапляють через рах. 2924)
    select sum(a.s)
      into l_sum_nocash
      from (select ok.*, ck.okpo
              from opldok ok
             inner join opldok od
                on (od.ref = ok.ref and od.dk = 0 and od.stmt = ok.stmt)
             inner join accounts ad
                on (ad.acc = od.acc)
             inner join accounts ak
                on (ak.acc = ok.acc)
             inner join bars.customer ck
                on (ak.rnk = ck.rnk)
             where ok.dk = 1
               and ok.acc = p_acc
                  --and od.fdat >= least(to_date('27/02/2014','dd/mm/yyyy'), p_datbeg)
               and ok.tt not in ('АСВ', 'KB8')
               and ad.nbs not in ('1001', '1002', '2924')
               and ad.rnk <> ak.rnk) a,
           oper o
     where a.ref = o.ref
       and (a.okpo <> o.id_a or
           o.mfoa not in (select mfo from banks where mfou = '300465') or
           a.fdat <= to_date('27/02/2014', 'dd/mm/yyyy'));

    -- розрахунок комісії за видачу готівки
    if (nvl(l_sum_nocash, 0) > 0) then
      begin
        --      select round(gl.p_icurval(kv, (l_sum_nocash*PR/100), l_bdate))
        select round(l_sum_nocash * pr / 100)
          into l_sum_nocash
          from tarif
         where kod = case p_kv
                 when 980 then
                  125
                 when 840 then
                  126
                 when 978 then
                  127
                 else
                  null
               end;
      exception
        when no_data_found then
          l_sum_nocash := 0;
      end;
    else
      l_sum_nocash := 0;
    end if;

    return l_sum_nocash;

  end f_get_nocash_commis;

  -- ======================================================================================
  --
  --
  function f_allow2pay(p_intacc in dpt_deposit.acc%type, -- внутр.№ счета начисл.процентов
                       p_freq   in dpt_deposit.freq%type, -- период-ть выплаты процентов
                       p_begdat in dpt_deposit.dat_begin%type, -- дата начала действия вклада
                       p_enddat in dpt_deposit.dat_end%type, -- дата окончания действия вклада
                       p_curdat in date default gl.bdate, -- банковская дата
                       p_avans  in number default 0, -- признак авансовой выплаты процентов
                       p_extend in number default 0) -- признак переооформленного вклада
   return number is
  begin

    return dpt.payoff_enable(p_intacc,
                             p_freq,
                             p_avans,
                             p_begdat,
                             p_enddat,
                             p_curdat,
                             p_extend);

  end f_allow2pay;
  --=======================================================================================
  function f_interbank(p_mfo banks.mfo%type) return number is
    l_interbank number;
  begin
    l_interbank := case
                     when (p_mfo = gl.amfo) then
                      0
                     else
                      1
                   end;
    return l_interbank;
  end f_interbank;

  --=======================================================================================
  --
  -- внешняя функция определения карточного счета
  --
  function account_is_card(p_bankcode banks.mfo%type,
                           p_accnum   accounts.nls%type) return number -- 1 = счет карточный / 0 = счет не карточный
   is
    title constant varchar2(60) := 'dptweb.acciscard:';
    l_iscard number(1);
  begin

    bars_audit.trace('%s entry with {%s, %s}', title, p_bankcode, p_accnum);

    select (case
             when count(*) > 0 then
              1
             else
              0
           end)
      into l_iscard
      from accounts a, bpk_all_accounts b -- (bpk_acc + w4_acc)
     where a.kf = p_bankcode
       and a.nls = p_accnum
       and a.dazs is null
       and a.acc = b.acc_pk;

    --
    -- якщо рахунок 2625% але його немає в BPK_ALL_ACCOUNTS (тимчасово щоб знайти причину)
    --
    if ((l_iscard = 0) and substr(p_accnum, 1, 4) = '2625') then
      bars_audit.error(title ||
                       'рахунок 2625% не прив`язаний до БПК (p_bankcode=' ||
                       p_bankcode || ',  p_accnum=' || p_accnum || ')');
    end if;
    --
    --
    --
    l_iscard := nvl(l_iscard, 0);
    bars_audit.trace('%s exit with {%s}', title, to_char(l_iscard));
    return l_iscard;

  end account_is_card;

  --=======================================================================================
  --
  --
  function search_acc_params(p_accid in accounts.acc%type) return acc_rec is
    l_accrec acc_rec;
  begin

    select a.nls, a.kv, substr(a.nms, 1, 38), substr(c.nmk, 1, 38), c.okpo
      into l_accrec
      from accounts a, customer c
     where a.rnk = c.rnk
       and a.acc = p_accid;

    return l_accrec;

  exception
    when no_data_found then
      bars_error.raise_nerror(g_modcode, g_accnotfound, to_char(p_accid));
  end search_acc_params;
  -- ======================================================================================
  procedure fill_dpt_payments(p_dptid  in dpt_payments.dpt_id%type, -- идентификатор договора
                              p_ref    in dpt_payments.ref%type, -- референс документа
                              p_branch in dpt_payments.branch%type default null, -- бранч документа
                              p_rnk    in dpt_payments.rnk%type default null -- rnk клієнта що здійснив операцію ( власник/довірена особа )
                              ) is
    l_branch branch.branch%type := nvl(p_branch,
                                       sys_context('bars_context',
                                                   'user_branch'));
  begin
    bars_audit.trace('dpt_web.fill_dpt_payments: договор № %s, реф %s',
                     to_char(p_dptid),
                     to_char(p_ref));

    begin
      insert into dpt_payments
        (dpt_id, ref, branch, rnk)
      values
        (p_dptid, p_ref, l_branch, p_rnk);
    exception
      when dup_val_on_index then
        -- данный документ (реф %s) уже связан с депозитным договором № %s
        --bars_error.raise_error(g_modcode, 311, to_char(p_ref), to_char(p_dptid));
        null;
      when others then
        -- Невозможно связать документ (реф %s) с депозитным договором № %s: %s
        bars_error.raise_error(g_modcode,
                               312,
                               to_char(p_ref),
                               to_char(p_dptid),
                               substr(sqlerrm, 1, 250));
    end;

  end fill_dpt_payments;
  -- ======================================================================================
  procedure kill_dpt_payments(p_dptid     in dpt_payments.dpt_id%type,
                              p_ref       in dpt_payments.ref%type default 0, --|= 1 - плановые
                              p_docstatus in sos.sos%type default 5, -- макс.SOS--|= 3 - плановые + форвардные
                              p_reasonid  in bp_reason.id%type default 13, --|= 5 - все
                              p_levelid   in number default 3,
                              p_fullback  in number default 1,
                              p_novisa    in number default 0) is
    l_title  varchar2(60) := 'dpt_web.kill_dpt_payments: ';
    l_reason bp_reason.reason%type;
    l_numpar number(38);
    l_strpar varchar2(50);
    l_errmsg g_errmsg%type;
    l_userid staff.id%type := gl.auid;
    ---------
    procedure fill_oper_visa(p_ref    in oper.ref%type,
                             p_userid in oper.userid%type) is
      -- вставка записи про выполнение операции сторнирования док-та в таблицу истории виз
      l_par    params.par%type := 'BACKVISA';
      l_staff  staff%rowtype;
      l_chkgrp chklist%rowtype;
    begin

      select * into l_staff from staff where id = p_userid;
      bars_audit.trace(l_title || 'пользователь № %s, %s / %s',
                       to_char(l_staff.id),
                       l_staff.fio,
                       l_staff.tabn);

      -- код группы контроля "Сторно"
      select *
        into l_chkgrp
        from chklist
       where idchk = (select to_number(val) from params where par = l_par);
      bars_audit.trace(l_title || 'группа № %s %s',
                       to_char(l_chkgrp.idchk),
                       l_chkgrp.name);

      insert into oper_visa
        (ref,
         sqnc,
         dat,
         status,
         userid,
         username,
         usertabn,
         groupid,
         groupname)
      values
        (p_ref,
         null,
         sysdate,
         3,
         l_staff.id,
         l_staff.fio,
         l_staff.tabn,
         l_chkgrp.idchk,
         l_chkgrp.name);

      bars_audit.trace(l_title ||
                       'занесена запись в историю виз на док-те № %s',
                       to_char(p_ref));

    end fill_oper_visa;
    ---------
  begin

    bars_audit.trace(l_title ||
                     'договор № %s, документ № %s, статус док-тов = %s, запрет на положит.визы =%s',
                     to_char(p_dptid),
                     to_char(p_ref),
                     to_char(p_docstatus),
                     to_char(p_novisa));

    select reason into l_reason from bp_reason where id = p_reasonid;

    for dpt_docs in (select o.*,
                            (select count(*)
                               from oper_visa
                              where ref = o.ref
                                and status in (1, 2)) visa
                       from dpt_payments d, oper o
                      where d.ref = o.ref
                        and d.dpt_id = p_dptid
                           --        AND o.sos <= p_docstatus
                        and o.sos >= 0
                        and (p_ref = 0 or p_ref = o.ref)
                      order by o.ref desc) loop
      bars_audit.trace(l_title || ' документ № %s, статус - %s',
                       to_char(dpt_docs.ref),
                       to_char(dpt_docs.sos));

      if (dpt_docs.sos > p_docstatus) or
         (p_novisa = 1 and dpt_docs.visa > 0) then
        bars_error.raise_nerror(g_modcode,
                                'DPT_KILLDOC_DENIED',
                                to_char(dpt_docs.ref),
                                to_char(p_dptid));
      end if;

      begin
        p_back_dok(ref_      => dpt_docs.ref,
                   lev_      => p_levelid,
                   reasonid_ => p_reasonid,
                   par2_     => l_numpar,
                   par3_     => l_strpar,
                   fullback_ => p_fullback);
        bars_audit.trace(l_title || 'сторнирован документ № %s',
                         to_char(dpt_docs.ref));
        -- запись инф-ции в историю виз документа
        fill_oper_visa(dpt_docs.ref, l_userid);
        bars_audit.trace(l_title ||
                         'занесена инф-ция в историю виз док-та № %s',
                         to_char(dpt_docs.ref));
      exception
        when others then
          bars_error.raise_nerror(g_modcode,
                                  'DPT_KILLDOC_ERROR',
                                  to_char(dpt_docs.ref),
                                  to_char(p_dptid),
                                  sqlerrm);
      end;
    end loop; -- dpt_docs

  end kill_dpt_payments;
  -- ======================================================================================
  procedure paydoc(p_dptid    in dpt_deposit.deposit_id%type,
                   p_vdat     in oper.vdat%type,
                   p_brancha  in varchar2,
                   p_nlsa     in oper.nlsa%type,
                   p_mfoa     in oper.mfoa%type,
                   p_nama     in oper.nam_a%type,
                   p_ida      in oper.id_a%type,
                   p_kva      in oper.kv%type,
                   p_sa       in oper.s%type,
                   p_branchb  in varchar2,
                   p_nlsb     in oper.nlsb%type,
                   p_mfob     in oper.mfob%type,
                   p_namb     in oper.nam_b%type,
                   p_idb      in oper.id_b%type,
                   p_kvb      in oper.kv2%type,
                   p_sb       in oper.s2%type,
                   p_nazn     in oper.nazn%type,
                   p_nmk      in oper.nam_a%type,
                   p_tt       in oper.tt%type,
                   p_vob      in oper.vob%type,
                   p_dk       in oper.dk%type,
                   p_sk       in oper.sk%type,
                   p_userid   in oper.userid%type,
                   p_type     in number,
                   p_mcode    in varchar2 default 'DPT', -- код модуля що викликає процедуру
                   p_ref      out number,
                   p_err_flag out boolean,
                   p_err_msg  out varchar2) is
    l_title     varchar2(60) := 'dpt_web.paydoc: ';
    l_blkd      accounts.blkd%type;
    l_card      number(1);
    l_interbank number(1);
    l_nlsb      oper.nlsb%type;
    l_nazn      oper.nazn%type;
    l_tt        oper.tt%type;
    l_vob       oper.vob%type;
    l_nama      oper.nam_a%type;
    l_userid    oper.userid%type;
    l_curbranch branch.branch%type := sys_context('bars_context',
                                                  'user_branch');
    l_branchb   branch.branch%type;
    l_error exception;
    p_erracode varchar2(4000);
    p_erramsg  varchar2(4000);
    p_errahlp  varchar2(4000);
    p_modcode  varchar2(4000);
    p_modname  varchar2(4000);
    p_errmsg   varchar2(4000);
    l_child_dk oper.dk%type;
    l_child_s  oper.s%type;
    l_child_s2 oper.s2%type;
  begin

    p_ref      := null;
    p_err_flag := false;
    p_err_msg  := null;

    bars_audit.trace('%s договор № %s, ФИО - %s, дата - %s, назначение - %s, ' ||
                     'тип/код операции - %s, вид/ДК/исп/СК - %s',
                     l_title,
                     to_char(p_dptid),
                     p_nmk,
                     to_char(p_vdat, 'dd/mm/yyyy'),
                     p_nazn,
                     to_char(p_type) || '/' || p_tt,
                     to_char(p_vob) || '/' || to_char(p_dk) || '/' ||
                     to_char(p_userid) || '/' || to_char(p_sk));
    bars_audit.trace('%s сторона-А (%s, %s, %s, %s, %s, %s, %s)',
                     l_title,
                     p_brancha,
                     p_nlsa,
                     p_mfoa,
                     p_nama,
                     p_ida,
                     to_char(p_kva),
                     to_char(p_sa));
    bars_audit.trace('%s сторона-Б (%s, %s, %s, %s, %s, %s, %s)',
                     l_title,
                     p_branchb,
                     p_nlsb,
                     p_mfob,
                     p_namb,
                     p_idb,
                     to_char(p_kvb),
                     to_char(p_sb));

    if nvl(p_sa, 0) = 0 then
      return;
    end if;

    l_userid := nvl(p_userid, gl.auid);

    -- процедура НЕ должна запускаться от имени супер-пользователя
    if (l_curbranch = '/') then
      p_err_msg := 'Заборонено виконання процедури оплати документа від імені підрозділу ' ||
                   l_curbranch;
      raise l_error;
    end if;
    -- представимся подразделением, которое инициирует платеж
    if l_curbranch != p_brancha then
      bars_context.subst_branch(p_brancha);
    end if;
    bars_audit.trace('%s представились подразделением %s',
                     l_title,
                     p_brancha);

    -- проверка "Счет для списания не заблокирован"
    select nvl(blkd, 0)
      into l_blkd
      from accounts
     where nls = p_nlsa
       and kv = p_kva
       and kf = p_mfoa;

    if l_blkd != 0 then
      p_err_msg := bars_error.get_nerror_text(g_modcode,
                                              g_accountdebitdenied,
                                              p_nlsa || '/' ||
                                              to_char(p_kva));
      raise l_error;
    end if;

    -- признак "чистого" межбанка
    if p_mfoa = p_mfob then
      l_interbank := 0;
    else
      l_interbank := f_interbank(p_mfob);
    end if;
    bars_audit.trace('%s признак "чистого" межбанка = %s',
                     l_title,
                     to_char(l_interbank));

    -- признак платежа на карточку
    l_card := account_is_card(p_mfob, p_nlsb);
    bars_audit.trace('%s признак платежа на карточку = %s',
                     l_title,
                     to_char(l_card));

    -- p_branchb = null - допустимо отсутствие счета-Б в балансе подразделения,
    --                    которое инициировало платеж (p_branchb != null - НЕдопустимо)

    -- определения счета Б для оплаты
    if (l_card = 1) then
      -- платеж на карточку
      l_nlsb    := p_nlsb;
      l_branchb := p_brancha;
    elsif (p_mfoa = p_mfob) then
      if (p_brancha = p_branchb) then
        -- переброска внутри одного подразделения
        l_nlsb    := p_nlsb;
        l_branchb := p_branchb;
      else
        -- счет может быть не открыт в балансе подразделения
        begin
          select nls
            into l_nlsb
            from accounts
           where nls = p_nlsb
             and kv = p_kvb
             and kf = p_mfob
             and dazs is null;
        exception
          when no_data_found then
            -- коррсчет данного подразделения
            l_nlsb := branch_edit.getbranchparams(p_brancha, 'CORRACC');
        end;
        l_branchb := p_brancha;
      end if;
    else
      -- коррсчет данного подразделения
      begin
        l_nlsb := branch_edit.getbranchparams(p_brancha, 'CORRACC');
      exception
        when no_data_found then
          -- коррсчет банку (для нацвалюти)
          l_nlsb := get_proc_nls('T00', gl.baseval);
      end;

      l_branchb := p_brancha;

    end if;
    bars_audit.trace('%s счет-Б для оплаты = %s',
                     l_title,
                     l_nlsb);

    -- код операции
    if p_tt is not null then
      l_tt := p_tt;
    else
      l_tt := get_tt(p_type     => p_type,
                     p_interpay => l_interbank,
                     p_cardpay  => l_card,
                     p_currency => p_kva);
    end if;
    bars_audit.trace('%s код операции = %s', l_title, l_tt);

    -- вид обработки
    if p_vob is not null then
      l_vob := p_vob;
    else
      l_vob := get_vob(p_kva, p_kvb, l_tt, p_type);
    end if;
    bars_audit.trace('%s вид обработки = %s',
                     l_title,
                     to_char(l_vob));

    -- назначение платежа
    if p_nazn is not null then
      l_nazn := p_nazn;
    else
      l_nazn := get_nazn(l_tt, p_dptid, null, null);
    end if;

    -- IF l_card = 1 THEN
    --   l_nazn := substr(l_nazn||' на картковий рахунок', 1, 160);
    -- END IF;
    bars_audit.trace('%s назначение платежа = %s',
                     l_title,
                     l_nazn);

    -- наименование отправителя
    if p_mfoa <> p_mfob and l_interbank = 1 then
      l_nama := nvl(p_nmk, p_nama);
    else
      l_nama := p_nama;
    end if;
    bars_audit.trace('%s отправитель = %s', l_title, l_nama);

    begin
      gl.ref(p_ref);
      gl.in_doc3(p_ref,
                 l_tt,
                 l_vob,
                 substr(to_char(p_ref), 1, 10),
                 sysdate,
                 p_vdat,
                 p_dk,
                 p_kva,
                 p_sa,
                 p_kvb,
                 p_sb,
                 p_sk,
                 p_vdat,
                 p_vdat,
                 l_nama,
                 p_nlsa,
                 p_mfoa,
                 p_namb,
                 p_nlsb,
                 p_mfob,
                 l_nazn,
                 null,
                 p_ida,
                 p_idb,
                 null,
                 null,
                 1,
                 null,
                 null);

      paytt(null,
            p_ref,
            p_vdat,
            l_tt,
            p_dk,
            p_kva,
            p_nlsa,
            p_sa,
            p_kvb,
            l_nlsb,
            p_sb);
      bars_audit.trace('%s референс документа =  %s',
                       l_title,
                       to_char(p_ref));

      -- доплата дочерней операции для выплаты на карточку (PKR)
      if l_card = 1 then
        for c in (select t.tt, a.dk invers, t.s formula, t.s2 formula2
                    from tts t, ttsap a
                   where a.ttap = t.tt
                     and a.tt = l_tt) loop
          -- признак д/к с учетом инверсии
          l_child_dk := case
                          when c.invers = 1 then
                           abs(p_dk - 1)
                          else
                           p_dk
                        end;

          -- сумма-а дочерней операции
          if c.formula is not null then
            l_child_s := dpt_web.get_amount(p_tt        => l_tt,
                                            p_formula   => c.formula,
                                            p_dealnum   => null,
                                            p_ref       => p_ref,
                                            p_suma      => p_sa,
                                            p_sumb      => p_sb,
                                            p_curcodea  => p_kva,
                                            p_curcodeb  => p_kvb,
                                            p_amountm   => p_sa,
                                            p_curcodem  => p_kva,
                                            p_accnuma   => p_nlsa,
                                            p_accnumb   => p_nlsb,
                                            p_bankcodea => p_mfoa,
                                            p_bankcodeb => p_mfob);
          else
            l_child_s := p_sa;
          end if;
          -- сумма-B дочерней операции
          if c.formula2 is not null then
            l_child_s2 := dpt_web.get_amount(p_tt        => l_tt,
                                             p_formula   => c.formula2,
                                             p_dealnum   => null,
                                             p_ref       => p_ref,
                                             p_suma      => p_sa,
                                             p_sumb      => p_sb,
                                             p_curcodea  => p_kva,
                                             p_curcodeb  => p_kvb,
                                             p_amountm   => p_sa,
                                             p_curcodem  => p_kva,
                                             p_accnuma   => p_nlsa,
                                             p_accnumb   => p_nlsb,
                                             p_bankcodea => p_mfoa,
                                             p_bankcodeb => p_mfob);
          else
            l_child_s2 := case
                            when p_kva = p_kvb then
                             p_sa
                            else
                             null
                          end;
          end if;
          paytt(0,
                p_ref,
                p_vdat,
                c.tt,
                l_child_dk,
                p_kva,
                p_nlsa,
                l_child_s,
                p_kvb,
                p_nlsb,
                l_child_s2);
          bars_audit.trace('%s оплачена связанная операция %s',
                           l_title,
                           c.tt);
        end loop;
      end if;

    exception
      when others then
        bars_error.get_error_info(sqlerrm,
                                  p_err_msg,
                                  p_erracode,
                                  p_erramsg,
                                  p_errahlp,
                                  p_modcode,
                                  p_modname,
                                  p_errmsg);
        raise l_error;
    end;

    -- запись документа в хранилище док-тов по депозитному договору ФО
    if (p_dptid is not null) and (p_mcode = 'DPT') then
      fill_dpt_payments(p_dptid, p_ref);
      bars_audit.trace('%s документ № %s записан в хранилище док-тов по договору № %s',
                       l_title,
                       to_char(p_ref),
                       to_char(p_dptid));
    end if;

  exception
    when l_error then
      p_err_flag := true;
      p_err_msg  := p_err_msg;
      bars_audit.error(l_title || p_err_msg);
  end paydoc;

  --========================================
  --
  --
  function get_accnum(p_formula tts.nlsa%type) return varchar2 is
    l_title  varchar2(60) := 'dptweb.get_accnum: ';
    l_accnum accounts.nls%type;
    l_result varchar2(3000);
  begin

    bars_audit.trace('%s формула для расчета счета = %s',
                     l_title,
                     p_formula);

    if (substr(p_formula, 1, 2) = '#(') then

      begin
        execute immediate 'SELECT ' ||
                          substr(p_formula, 3, length(p_formula) - 3) ||
                          ' FROM dual'
          into l_result;
      exception
        when others then
          -- невозможно рассчитать счет доходов по формуле из карточки операции
          bars_error.raise_error(g_modcode, 298, 'p_tt');
      end;
      bars_audit.trace('%s результат вычислений = %s',
                       l_title,
                       l_result);

      l_accnum := substr(l_result, 1, 14);

    else

      l_accnum := substr(p_formula, 1, 14);

    end if;

    bars_audit.trace('%s счет = %s', l_title, l_accnum);

    return l_accnum;

  end get_accnum;

  -- ======================================================================================
  --
  --
  procedure paydoc_nocash_commission(p_tt          in oper.tt%type,
                                     p_dptid       in dpt_deposit.deposit_id%type,
                                     p_main_amount in oper.s%type,
                                     p_main_curcod in oper.kv%type,
                                     p_main_docref in oper.ref%type,
                                     p_main_accrec in acc_rec,
                                     p_vdate       in oper.vdat%type,
                                     p_userid      in oper.userid%type,
                                     p_ref         out oper.ref%type,
                                     p_amount      in out oper.s%type) is
    l_title   varchar2(60) := 'dptweb.paynocashcms:';
    l_ttrow   tts%rowtype;
    l_nlsa    oper.nlsa%type;
    l_mfoa    oper.mfoa%type;
    l_nama    oper.nam_a%type;
    l_ida     oper.id_a%type;
    l_kva     oper.kv%type;
    l_amounta oper.s%type;
    l_nlsb    oper.nlsb%type;
    l_mfob    oper.mfob%type;
    l_namb    oper.nam_b%type;
    l_idb     oper.id_b%type;
    l_kvb     oper.kv2%type;
    l_amountb oper.s2%type;
    l_nazn    oper.nazn%type;
    l_ref     oper.ref%type;
    l_errflg  boolean;
    l_errmsg  g_errmsg%type;
    l_brancha branch.branch%type;
    l_branchb branch.branch%type;

  begin

    bars_audit.trace('%s операция %s', l_title, p_tt);

    -- параметры операции
    select * into l_ttrow from tts where tt = p_tt;
    bars_audit.trace('%s название операции = %s',
                     l_title,
                     l_ttrow.name);

    -- сторона А
    l_mfoa    := sys_context('bars_context', 'user_mfo');
    l_brancha := sys_context('bars_context', 'user_branch');
    l_nlsa    := p_main_accrec.acc_num;
    l_nama    := p_main_accrec.cust_name;
    l_ida     := p_main_accrec.cust_idcode;
    l_kva     := p_main_accrec.acc_cur;
    bars_audit.trace('%s счет-плательщик = %s / %s',
                     l_title,
                     l_nlsa,
                     to_char(l_kva));

    -- сторона Б
    l_mfob    := l_mfoa;
    l_branchb := l_brancha;
    l_kvb     := nvl(l_ttrow.kvk, l_kva); -- валюта-Б д.б. описана в карточке операции
    l_nlsb    := get_accnum(nvl(l_ttrow.nlsk, l_ttrow.nlsb));
    begin
      select substr(a.nms, 1, 38), c.okpo
        into l_namb, l_idb
        from accounts a, customer c
       where a.rnk = c.rnk
         and a.nls = l_nlsb
         and a.kv = l_kvb
         and a.kf = l_mfob;
    exception
      when no_data_found then
        -- не найден счет-получатель (счет доходов)
        bars_error.raise_error(g_modcode, 299, l_nlsb, to_char(l_kvb));
    end;
    bars_audit.trace('%s счет-получатель = %s / %s',
                     l_title,
                     l_nlsb,
                     to_char(l_kvb));

    -- назначение платежа
    l_nazn := dpt_web.get_nazn(p_tt     => p_tt,
                               p_dptid  => p_dptid,
                               p_dptnum => null,
                               p_dptdat => null);
    bars_audit.trace('%s назначение платежа = %s',
                     l_title,
                     l_nazn);

    -- сумма платежа - A
    if p_amount > 0 then
      l_amounta := p_amount;
    else
      l_amounta := dpt_web.get_amount(p_tt        => p_tt,
                                      p_formula   => l_ttrow.s,
                                      p_dealnum   => p_dptid,
                                      p_ref       => p_main_docref,
                                      p_suma      => null,
                                      p_sumb      => null,
                                      p_curcodea  => l_kva,
                                      p_curcodeb  => l_kvb,
                                      p_amountm   => p_main_amount,
                                      p_curcodem  => p_main_curcod,
                                      p_accnuma   => l_nlsa,
                                      p_accnumb   => l_nlsb,
                                      p_bankcodea => l_mfoa,
                                      p_bankcodeb => l_mfob);
    end if;
    bars_audit.trace('%s сумма комиссии = %s',
                     l_title,
                     to_char(l_amounta));

    -- сумма платежа - Б
    if l_ttrow.s2 is null then
      l_amountb := gl.p_icurval(l_kva, l_amounta, p_vdate);
    else
      l_amountb := dpt_web.get_amount(p_tt        => p_tt,
                                      p_formula   => l_ttrow.s2,
                                      p_dealnum   => p_dptid,
                                      p_ref       => p_main_docref,
                                      p_suma      => null,
                                      p_sumb      => null,
                                      p_curcodea  => l_kva,
                                      p_curcodeb  => l_kvb,
                                      p_amountm   => p_main_amount,
                                      p_curcodem  => p_main_curcod,
                                      p_accnuma   => l_nlsa,
                                      p_accnumb   => l_nlsb,
                                      p_bankcodea => l_mfoa,
                                      p_bankcodeb => l_mfob);
    end if;
    bars_audit.trace('%s сумма-2 комиссии = %s',
                     l_title,
                     to_char(l_amountb));

    -- оплата
    paydoc(p_dptid    => p_dptid,
           p_vdat     => p_vdate,
           p_brancha  => l_brancha,
           p_nlsa     => l_nlsa,
           p_mfoa     => l_mfoa,
           p_nama     => substr(l_nama, 1, 38),
           p_ida      => l_ida,
           p_kva      => l_kva,
           p_sa       => l_amounta,
           p_branchb  => l_branchb,
           p_nlsb     => l_nlsb,
           p_mfob     => l_mfob,
           p_namb     => substr(l_namb, 1, 38),
           p_idb      => l_idb,
           p_kvb      => l_kvb,
           p_sb       => l_amountb,
           p_nazn     => l_nazn,
           p_nmk      => substr(l_nama, 1, 38),
           p_tt       => p_tt,
           p_vob      => null,
           p_dk       => l_ttrow.dk,
           p_sk       => null,
           p_userid   => p_userid,
           p_type     => null,
           p_ref      => l_ref,
           p_err_flag => l_errflg,
           p_err_msg  => l_errmsg);

    bars_audit.trace('%s референс комиссии = %s',
                     l_title,
                     to_char(l_ref));

    if l_errflg then
      -- ошибка оплаты документа по взысканию комиссии за безнал.пополнение
      bars_error.raise_error(g_modcode, 305, substr(l_errmsg, 1, 254));
    end if;

    p_ref    := l_ref;
    p_amount := l_amounta;

  end paydoc_nocash_commission;

  -- ======================================================================================
  function create_request(p_reqtype in dpt_req_types.reqtype_code%type,
                          p_dptid   in dpt_deposit_all.deposit_id%type)
    return dpt_requests.req_id%type is
    pn constant varchar2(100) := 'dpt.crreq';
    l_reqtypeid dpt_req_types.reqtype_id%type; /*       ид. типа запроса */
    l_reqid     dpt_requests.req_id%type; /* ид. созданного запроса */
    l_branch    branch.branch%type; /*          код отделения */
  begin

    bars_audit.trace('%s: entry with: reqtype=%s, dptid=%s.',
                     pn,
                     to_char(p_reqtype),
                     to_char(p_dptid));

    begin
      select reqtype_id
        into l_reqtypeid
        from dpt_req_types
       where reqtype_code = p_reqtype;
    exception
      when no_data_found then
        bars_error.raise_nerror(g_modcode,
                                request_type_not_found,
                                p_reqtype);
    end;

    bars_audit.trace('%s: reqtype id=%s', pn, to_char(l_reqtypeid));

    -- бранч користувача
    l_branch := sys_context('bars_context', 'user_branch');

    bars_audit.trace('%s: dpt branch is %s', pn, l_branch);

    -- Создаем запрос
    insert into dpt_requests
      (req_id,
       reqtype_id,
       req_bdate,
       req_crdate,
       req_cruserid,
       dpt_id,
       branch)
    values
      (get_id_ddb(bars_sqnc.get_nextval('S_DPTREQS')),
       l_reqtypeid,
       bankdate,
       sysdate,
       user_id,
       p_dptid,
       l_branch)
    returning req_id into l_reqid;

    bars_audit.trace('%s: req created id=%s', pn, to_char(l_reqid));
    bars_audit.trace('%s: succ end', pn);

    return l_reqid;

  end create_request;

  -- ======================================================================================
  procedure process_request(p_reqid in dpt_requests.req_id%type) is
    --     Функция обработки запроса
    pn constant varchar2(100) := 'dpt.prcreq';
    l_reqfunc dpt_req_types.reqtype_func%type; /*  функция обработки запроса */
  begin

    bars_audit.trace('%s: entry point par[0]=>%s', pn, to_char(p_reqid));

    select reqtype_func
      into l_reqfunc
      from dpt_requests r, dpt_req_types t
     where r.req_id = p_reqid
       and r.reqtype_id = t.reqtype_id;

    bars_audit.trace('%s: req func is %s', pn, l_reqfunc);

    -- Запускаем
    execute immediate 'begin ' || l_reqfunc || '(:reqid); end;'
      using p_reqid;

    bars_audit.trace('%s: reqfunc completed.', pn);
    bars_audit.trace('%s: succ end', pn);

  end process_request;

  -- ======================================================================================
  procedure set_request_state(p_reqid    in dpt_requests.req_id%type,
                              p_reqstate in dpt_requests.req_state%type) is
    -- Процедура установки состояния запроса
    pn constant varchar2(100) := 'dpt.setreqst';
    l_reqfunc dpt_req_types.reqtype_func%type; /*  функция обработки запроса */
    l_cnt     number; /*    признак наличия запроса */
  begin

    bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s',
                     pn,
                     to_char(p_reqid),
                     to_char(p_reqstate));

    -- Устанавливаем состояние (только для необработ.)
    update dpt_requests
       set req_prcdate   = sysdate,
           req_prcuserid = user_id,
           req_state     = p_reqstate
     where req_id = p_reqid
       and req_state is null;

    if (sql%rowcount = 0) then

      -- Проверяем существование
      select count(*) into l_cnt from dpt_requests where req_id = p_reqid;

      -- Если запрос есть, то значит он был уже обработан
      if (l_cnt = 0) then
        bars_error.raise_nerror(g_modcode,
                                request_not_found,
                                to_char(p_reqid));
      else
        bars_error.raise_nerror(g_modcode,
                                request_processed,
                                to_char(p_reqid));
      end if;

    end if;

    bars_audit.trace('%s: succ end', pn);

  end set_request_state;

  -- ======================================================================================
  function get_request_state(p_reqid in dpt_requests.req_id%type)
    return dpt_requests.req_state%type is
    --     Функция возвращает состояние запроса
    pn constant varchar2(100) := 'dpt.getreqst';
    l_reqstate dpt_requests.req_state%type; /* состояние */
  begin

    select req_state
      into l_reqstate
      from dpt_requests
     where req_id = p_reqid;

    return l_reqstate;

  exception
    when no_data_found then
      bars_error.raise_nerror(g_modcode,
                              request_not_found,
                              to_char(p_reqid));
  end get_request_state;

  -- ======================================================================================
  procedure delete_deposit(p_dptid in dpt_deposit_all.deposit_id%type) is
    --     Процедура удаления депозита
    pn constant varchar2(100) := 'dpt.deldpt';
    l_reqid  dpt_requests.req_id%type; /*                  Ид. запроса */
    l_userid staff$base.id%type; /* Ид. польз. создашего договор */
    l_branch branch.branch%type; /*        Тек. отделение польз. */
    l_bankdt fdat.fdat%type; /*            Банк. дата польз. */
    l_isdel  number; /*       признак возм. удаления */
  begin

    bars_audit.trace('%s: enry point par[0]=>%s', pn, to_char(p_dptid));

    /* Удаление депозитов запрещено. */

    bars_error.raise_nerror(g_modcode,
                            g_proc_deprecated,
                            'dpt_web.dpt_delete');

    /*
      -- TODO: добавить функцию проверки на возможность закрытия
      l_isdel := dpt_web.dpt_del_enabled(p_dptid);
      bars_audit.trace('%s: deleting flag is %s', pn, to_char(l_isdel));

      if (l_isdel != 1) then
          bars_error.raise_nerror(g_modcode, DELETE_DEAL_DISALLOWED, to_char(p_dptid));
      end if;

      l_bankdt := bankdate;

      -- Создаем заголовок запроса
      l_reqid := create_request('DELETE_DEAL', p_dptid);
       bars_audit.trace('%s: req header created, id=%s', pn, to_char(l_reqid));

      -- Определяем пользователя, который создал договор
      begin
        select branch, actiion_author
          into l_branch, l_userid
          from dpt_deposit_clos
         where deposit_id  = p_dptid
           and action_id   = 0;
      exception
        when NO_DATA_FOUND then
          bars_error.raise_nerror(g_modcode, DPTCREATOR_NOT_EXISTS, to_char(p_dptid));
      end;
      bars_audit.trace('%s: dpt creator is user %s', pn, to_char(l_userid));

      -- Определяем нужно ли добавлять
      if (l_userid != user_id) then
          insert into dpt_req_deldeals(req_id, user_id, user_bdate, branch)
          values (l_reqid, l_userid, l_bankdt, l_branch);
          bars_audit.trace('%s: request user isnt dpt creator, creator added to queue.', pn);
      else
          bars_audit.trace('%s: request user is dpt creator, skipping', pn);
      end if;

      -- Проходим по документам
      insert into dpt_req_deldeals(req_id, user_id, user_bdate, branch)
      select l_reqid, dc.userid, l_bankdt, l_branch
        from dpt_payments dp, oper_visa dc
       where dp.ref     = dc.ref
         and dp.dpt_id  = p_dptid
         and dc.status in (1, 2)   -- только подтверждение
       group by dc.userid;

      bars_audit.trace('%s: added %s check-in user(s)', to_char(sql%rowcount));

      process_request(l_reqid);

      if (get_request_state(l_reqid) = REQUEST_ALLOWED) then
          g_dptdelcode := DEAL_DELETED;
      else
          g_dptdelcode := DEAL_DELREQ;
      end if;

      bars_audit.trace('%s: succ end', pn);
    */

  end delete_deposit;
  -- ======================================================================================
  procedure get_deldeposit_msg(p_delcode out number, p_delmsg out varchar2) is
    --     Процедура возвращает код и текст последнего вызова
    --     процедуры удаления договора. Возвращаемый код может
    --     быть либо 1 - договор удален, либо 0 - создан запрос
    --     на удаления (ожидает подтверждения). Текст соответствует
    --     коду сообщения
  begin

    p_delcode := g_dptdelcode;

    if (p_delcode = deal_deleted) then
      p_delmsg := bars_msg.get_msg(g_modcode, 'DEAL_DELETED');
    else
      p_delmsg := bars_msg.get_msg(g_modcode, 'DEAL_DELREQ');
    end if;

  end get_deldeposit_msg;

  -- ======================================================================================
  --
  --
  procedure process_req_deldeal(p_reqid in dpt_requests.req_id%type) is
    --     Процедура удаления депозита
    pn constant varchar2(100) := 'dpt.prcreqdel';
    l_cnt   number;
    l_dptid dpt_requests.dpt_id%type; /* ид. деп. договора */
  begin

    bars_audit.trace('%s: entry point par[0]=>%s', to_char(p_reqid));
    /* Удаление депозитов запрещено. */
    bars_error.raise_nerror(g_modcode,
                            g_proc_deprecated,
                            'dpt_web.dpt_delete');

    /*  -- Смотрим были ли отказы
      select count(*) into l_cnt
        from dpt_req_deldeals
       where req_id     = p_reqid
         and user_state = -1;

      bars_audit.trace('%s: req %s refused record(s) found.', pn, to_char(l_cnt));

      -- Если отказы были, то закрываем запрос
      if (l_cnt > 0) then
          set_request_state(p_reqid, REQUEST_DISALLOWED);
          return;
      end if;

      -- Проверяем все ли подтверждения получены
      select count(*) into l_cnt
        from dpt_req_deldeals
       where req_id = p_reqid
         and (user_state is null or
              user_state != 1       );
      bars_audit.trace('%s: req has %s not approved recors.', pn, to_char(l_cnt));

      -- Если неподтвержденных нет, то удаляем
      if (l_cnt = 0) then

          set_request_state(p_reqid, REQUEST_ALLOWED);

          select dpt_id into l_dptid
            from dpt_requests
           where req_id = p_reqid;

          dpt_web.dpt_delete(l_dptid);

      end if;

      bars_audit.trace('%s: succ end');
    */
  end process_req_deldeal;

  -- ======================================================================================
  procedure put_deldeal_check(p_reqid    in dpt_requests.req_id%type,
                              p_reqcheck in dpt_req_deldeals.user_state%type) is
    -- Процедура установки подтверждения/отказа пользователя на запрос по удалению депозитного договора
    pn constant varchar2(100) := 'dpt.prcreqdel';
    l_userid staff$base.id%type; /* Ид. текущего польз. */
    l_cnt    number;
  begin

    bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s',
                     to_char(p_reqid),
                     to_char(p_reqcheck));

    l_userid := user_id;
    bars_audit.trace('%s: current user is %s', pn, to_char(l_userid));

    update dpt_req_deldeals
       set user_date = sysdate, user_state = p_reqcheck
     where req_id = p_reqid
       and user_id = l_userid
       and user_state is null;

    if (sql%rowcount = 0) then

      select count(*)
        into l_cnt
        from dpt_req_deldeals
       where req_id = p_reqid
         and user_id = l_userid;

      if (l_cnt = 0) then
        bars_error.raise_nerror(g_modcode,
                                request_not_found,
                                to_char(p_reqid));
      else
        bars_error.raise_nerror(g_modcode,
                                request_user_check_put,
                                to_char(p_reqid));
      end if;

    end if;

    bars_audit.trace('%s: user check applied.', pn);

    process_request(p_reqid);

    bars_audit.trace('%s: succ end', pn);

  end put_deldeal_check;
  -- ======================================================================================
  procedure set_bonusreq_state(p_dptid in dpt_bonus_requests.dpt_id%type,
                               p_reqid in dpt_bonus_requests.req_id%type) is
    -- Процедура установки признака "Обработано" для запроса по бонусным процентным ставкам
    l_title constant varchar2(100) := 'dpt.setbnreqst';
  begin

    bars_audit.trace('%s: entry point par[0]=>%s, par[1]=>%s',
                     l_title,
                     to_char(p_dptid),
                     to_char(p_reqid));

    set_request_state(p_reqid, request_allowed);

    bars_audit.trace('%s: succ end', l_title);

  end set_bonusreq_state;

  -- ======================================================================================
  function create_commis_request(p_dptid    in dpt_deposit_all.deposit_id%type,
                                 p_agrmntid in dpt_vidd_flags.id%type)
    return dpt_requests.req_id%type is
    --
    -- Создание запроса на отмену комиссии
    --
    pn constant varchar2(100) := 'dpt.crcomreq';
    l_reqid dpt_requests.req_id%type; /* Ид. запроса */
  begin
    bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s',
                     pn,
                     to_char(p_dptid),
                     to_char(p_agrmntid));

    -- Создаем запрос
    l_reqid := create_request('AGRMNT_COMMIS', p_dptid);
    bars_audit.trace('%s: req created id=%s', pn, to_char(l_reqid));

    -- Сохраняем инф. о активном запросе в рекв. дог.
    dpt.fill_dptparams(p_dptid => p_dptid,
                       p_tag   => dptw_commis_reqid,
                       p_val   => to_char(l_reqid));
    dpt.fill_dptparams(p_dptid => p_dptid,
                       p_tag   => dptw_commis_reqagrmn,
                       p_val   => to_char(p_agrmntid));
    -- Автообработка спец. для сбер
    put_commis_check(l_reqid, 1);

    bars_audit.trace('%s: succ end', pn);
    return l_reqid;

  end create_commis_request;

  -- ======================================================================================
  procedure delete_commis_request(p_reqid in dpt_requests.req_id%type) is
    --
    -- Удаление запроса на  отмену комиссии
    --
    pn constant varchar2(100) := 'dpt.delcomreq';
    l_reqst dpt_requests.req_state%type; /*  Код состояния запроса */
    l_dptid dpt_deposit.deposit_id%type; /*       Ид. деп договора */
  begin
    bars_audit.trace('%s: entry point par[0]=>%s', pn, to_char(p_reqid));

    -- Получаем состояние
    l_reqst := get_request_state(p_reqid);
    bars_audit.trace('%s: req state is ', pn, nvl(to_char(l_reqst), 0));

    if (l_reqst is null) then
      set_request_state(p_reqid, dpt_web.request_disallowed);
      bars_audit.trace('%s: req auto process to disallowed.', pn);
    end if;

    select dpt_id into l_dptid from dpt_requests where req_id = p_reqid;
    bars_audit.trace('%s: req dptid is %s', pn, to_char(l_dptid));

    delete from dpt_depositw
     where dpt_id = l_dptid
       and tag in (dptw_commis_reqid, dptw_commis_reqagrmn);
    bars_audit.trace('%s: succ end', pn);

  end delete_commis_request;

  -- ======================================================================================
  function get_commisreq_active(p_dptid in dpt_deposit_all.deposit_id%type)
    return dpt_requests.req_id%type is
    --
    -- Функция получения активного запроса по договору
    --
    pn constant varchar2(100) := 'dpt.getcomreqa';
    l_reqid dpt_requests.req_id%type; /* ид. запроса */
  begin
    bars_audit.trace('%s: entry point par[0]=>%s', pn, to_char(p_dptid));

    select to_number(value)
      into l_reqid
      from dpt_depositw
     where dpt_id = p_dptid
       and tag = dptw_commis_reqid;
    bars_audit.trace('%s: active req id is %s', pn, to_char(l_reqid));

    return l_reqid;
  exception
    when no_data_found then
      bars_audit.trace('%s: active req not exists', pn);
      return null;
  end get_commisreq_active;

  -- ======================================================================================
  procedure put_commis_check(p_reqid    in dpt_requests.req_id%type,
                             p_reqcheck in dpt_req_deldeals.user_state%type) is
    -- Процедура установки подтверждения/отказа на запрос по отмене комиссий
    pn constant varchar2(100) := 'dpt.prcreqcom';
    l_userid staff$base.id%type; /* Ид. текущего польз. */
    l_cnt    number;
  begin
    bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s',
                     to_char(p_reqid),
                     to_char(p_reqcheck));
    set_request_state(p_reqid, p_reqcheck);
    bars_audit.trace('%s: succ end', pn);
  end put_commis_check;

  --
  -- Создание запроса на индив. проц. ставку
  --
  function create_chgintdpt_request(p_dptid   in dpt_deposit.deposit_id%type,
                                    p_newint  in number,
                                    p_expdate in date default null)
    return dpt_requests.req_id%type is
    pn constant varchar2(100) := 'dptweb.crchgintreqind';
    l_reqid  dpt_requests.req_id%type; /*       Ид. запроса */
    l_branch branch.branch%type; /*     Код отделения */
    l_cint   number; /* Тек. проц. ставка */
  begin
    bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s par[2]=>%s',
                     pn,
                     to_char(p_dptid),
                     to_char(p_newint),
                     to_char(p_expdate, 'dd.mm.yyyy'));

    l_reqid := create_request('AGRMNT_CHGINT', p_dptid);
    bars_audit.trace('%s: created req header id=%s', pn, to_char(l_reqid));

    select branch into l_branch from dpt_requests where req_id = l_reqid;

    select acrn.fproc(acc, bankdate)
      into l_cint
      from dpt_deposit
     where deposit_id = p_dptid;
    bars_audit.trace('%s: current int rate is %s', pn, to_char(l_cint));

    -- Вставляем расширенную часть запроса
    insert into dpt_req_chgints
      (req_id, reqc_type, reqc_expdate, reqc_oldint, reqc_newint, branch)
    values
      (l_reqid, req_chgint_ind, p_expdate, l_cint, p_newint, l_branch);
    bars_audit.trace('%s: request detail created.', pn);

    bars_audit.trace('%s: succ end', pn);
    return l_reqid;

  end create_chgintdpt_request;

  --
  -- Создание запросов на изм. проц. ставки
  --
  function create_chgintvid_request(p_dptvidd  in dpt_vidd.vidd%type,
                                    p_newbr    in br_normal.br_id%type,
                                    p_begdate  in date,
                                    p_expdate  in date default null,
                                    p_branch   in branch.branch%type default null,
                                    p_dptdateu in date default null,
                                    p_dptdatef in date default null)
    return number is
    pn constant varchar2(100) := 'dptweb.crchgintreqvid';
    l_reqid  dpt_requests.req_id%type; /*           Ид. запроса */
    l_reqcnt number := 0; /* Кол-во созд. запросов */
  begin
    bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s par[2]=>%s par[3]=>%s par[4]=>%s par[5]=>%s par[6]=>%s par[7]=>%s',
                     pn,
                     to_char(p_dptvidd),
                     to_char(p_newbr),
                     to_char(p_begdate, 'dd.mm.yyyy'),
                     to_char(p_expdate, 'dd.mm.yyyy'),
                     p_branch,
                     to_char(p_dptdateu, 'dd.mm.yyyy'),
                     to_char(p_dptdatef, 'dd.mm.yyyy'));

    for c in (select deposit_id, branch
                from dpt_deposit
               where vidd = p_dptvidd
                 and branch = nvl(p_branch, branch)
                 and datz <= nvl(p_dptdateu, datz)
                 and datz >= nvl(p_dptdatef, datz)) loop
      bars_audit.trace('%s: creating req for dptid=%s',
                       pn,
                       to_char(c.deposit_id));

      l_reqid := create_request('AGRMNT_CHGINT', c.deposit_id);

      insert into dpt_req_chgints
        (req_id, reqc_type, reqc_expdate, reqc_begdate, reqc_newbr, branch)
      values
        (l_reqid, req_chgint_vid, p_expdate, p_begdate, p_newbr, c.branch);
      bars_audit.trace('%s: req for dptid=%s created.',
                       pn,
                       to_char(c.deposit_id));

      l_reqcnt := l_reqcnt + 1;
    end loop;

    bars_audit.trace('%s: succ end reqcnt=%s', pn, to_char(l_reqcnt));
    return l_reqcnt;

  end create_chgintvid_request;

  --
  -- Удаление запроса на изм. проц.ставки
  --
  procedure delete_chgint_request(p_reqid in dpt_requests.req_id%type) is
    pn constant varchar2(100) := 'dptweb.delchgintreq';
  begin
    bars_audit.trace('%s: entry point par[0]=>%s', pn, to_char(p_reqid));
    set_request_state(p_reqid, request_disallowed);
    bars_audit.trace('%s: succ end');
  end delete_chgint_request;

  --
  -- Установка признака обработки на запроса по изм. проц.ставки
  --
  procedure set_chgintreq_processed(p_reqid in dpt_requests.req_id%type) is
    pn constant varchar2(100) := 'dptweb.setchgintprc';
  begin
    bars_audit.trace('%s: entry point par[0]=>%s', pn, to_char(p_reqid));
    set_request_state(p_reqid, request_allowed);
    bars_audit.trace('%s: succ end');
  end set_chgintreq_processed;

  -- ===================================================================================
  -- Регистрация / обновление свидетельств о правах на наследство по договорам  (СПН) --
  --
  procedure inherit_registration(p_dptid        in dpt_inheritors.dpt_id%type,
                                 p_inheritor    in dpt_inheritors.inherit_custid%type,
                                 p_inheritshare in dpt_inheritors.inherit_share%type,
                                 p_inheritdate  in dpt_inheritors.inherit_date%type,
                                 p_certifnum    in dpt_inheritors.certif_num%type,
                                 p_certifdate   in dpt_inheritors.certif_date%type) is
    l_title      varchar2(60) := 'dpt_web.inherit_registation';
    l_bankdate   date := gl.bdate;
    l_branch     branch.branch%type := sys_context('bars_context',
                                                   'user_branch');
    l_dptnum     dpt_deposit.nd%type;
    l_dptdat     dpt_deposit.datz%type;
    l_heritor    customer.nmk%type;
    l_codcagent  customer.codcagent%type;
    l_inheritrow dpt_inheritors%rowtype;

  begin

    bars_audit.trace('%s депозит № %s, рег.№ наследника = %s, доля = %s',
                     l_title,
                     to_char(p_dptid),
                     to_char(p_inheritor),
                     to_char(p_inheritshare));

    if (p_certifnum is null or p_certifdate is null) then
      -- не заданы реквизиты свидетельства о праве на наследство
      bars_error.raise_nerror(g_modcode, 'INVALID_INHERIT_CERT');
    end if;

    if (p_inheritshare is null or p_inheritdate is null) then
      -- не заданы реквизиты наследника (доля и дата вступления в права наследования)
      bars_error.raise_nerror(g_modcode, 'INVALID_INHERIT_PARAMS');
    end if;

    if (p_inheritdate < p_certifdate) then
      -- дата вступу в права має бути більша за дату видачі свідоцтва
      bars_error.raise_nerror(g_modcode, 'INVALID_INHERIT_DATES');
    end if;

    -- параметры договора (проверка существования договора)
    begin
      select nd, datz
        into l_dptnum, l_dptdat
        from dpt_deposit
       where deposit_id = p_dptid;
    exception
      when no_data_found then
        bars_error.raise_nerror(g_modcode, g_dptnotfound, to_char(p_dptid));
    end;
    bars_audit.trace('%s договор № %s от %s',
                     l_title,
                     l_dptnum,
                     to_char(l_dptdat, 'dd.mm.yyyy'));

    -- параметры клиента-наследника (проверка существования клиента)
    begin
      select nmk, codcagent
        into l_heritor, l_codcagent
        from customer
       where rnk = p_inheritor;
    exception
      when no_data_found then
        bars_error.raise_nerror(g_modcode,
                                'CUST_NOT_FOUND',
                                to_char(p_inheritor));
    end;
    bars_audit.trace('%s наследник - %s, (codcagent = %s)',
                     l_title,
                     l_heritor,
                     to_char(l_codcagent));

    begin

      select *
        into l_inheritrow
        from dpt_inheritors
       where dpt_id = p_dptid
         and inherit_custid = p_inheritor;

      bars_audit.trace('%s изменение реквизитов записи в СПН',
                       l_title);

      if (l_inheritrow.certif_num != p_certifnum or
         l_inheritrow.certif_date != p_certifdate or
         l_inheritrow.inherit_share != p_inheritshare or
         l_inheritrow.inherit_date != p_inheritdate) then

        bars_audit.trace('%s параметры записи изменились',
                         l_title);

        if (l_inheritrow.inherit_state = 1) then
          -- наследник уже вступил в права наследования, изменение реквизитов недопустимо
          bars_error.raise_nerror(g_modcode, 'INHERIT_UPDATE_DENIED');
        end if;

        update dpt_inheritors
           set inherit_share = p_inheritshare,
               inherit_date  = p_inheritdate,
               certif_num    = p_certifnum,
               certif_date   = p_certifdate
         where dpt_id = p_dptid
           and inherit_custid = p_inheritor;

        if sql%rowcount = 1 then
          bars_audit.trace('%s изменение зафиксировано в БД',
                           l_title);
        else
          -- ошибка изменения реквизитов наследника № ... по договору № ...
          bars_error.raise_nerror(g_modcode,
                                  'INHERIT_UPDATE_FAILED',
                                  to_char(p_inheritor),
                                  to_char(p_dptid));
        end if;

      else
        bars_audit.trace('%s параметры записи не изменились',
                         l_title);
      end if;

    exception
      when no_data_found then

        bars_audit.trace('%s регистрация нового наследника',
                         l_title);
        -- сихронізація дати вступу в права спадкоємців (дата вступу у всіх має бути однакова)
        select decode(count(1), 0, l_bankdate, min(bankdate))
          into l_bankdate
          from dpt_inheritors
         where dpt_id = p_dptid;

        -- якщо по вкладу вже наявний активний спадкоємець то і всі наступні активні
        if inherited_deal(p_dptid, 1) = 'Y' then
          l_inheritrow.inherit_state := 1;
        else
          l_inheritrow.inherit_state := 0;
        end if;

        insert into dpt_inheritors
          (dpt_id,
           inherit_custid,
           inherit_share,
           inherit_date,
           inherit_state,
           certif_num,
           certif_date,
           branch,
           bankdate,
           attr_income)
        values
          (p_dptid,
           p_inheritor,
           p_inheritshare,
           p_inheritdate,
           0, -- inga 30/03/2015 COBUSUPABS-3383 was inherit_state inherit_state=l_inheritrow.inherit_state, now inherit_state = 0
           p_certifnum,
           p_certifdate,
           l_branch,
           l_bankdate,
           0);

        bars_audit.trace('%s наследник № %s к договору № %s занесен в БД',
                         l_title,
                         to_char(p_inheritor),
                         to_char(p_dptid));
    end;

    if inherit_valid_shares(p_dptid, 0) != 'Y' then

      -- неверно заданы доли наследников по договору № %s
      bars_error.raise_nerror(g_modcode,
                              'INVALID_INHERIT_SHARE',
                              to_char(p_dptid));

    end if;

    bars_audit.trace('%s процедура выполнена', l_title);

  end inherit_registration;

  -- ======================================================================================
  -- Проверка (промежут./окончат) правильности/достаточности заполнения долей наследования
  --
  function inherit_valid_shares(p_dptid in dpt_inheritors.dpt_id%type,
                                p_final in number default 0) return char is
    l_title      varchar2(60) := 'dpt_web.inherit_valid_shares: ';
    l_totalshare number;
    l_result     char(1);
  begin

    bars_audit.trace('%s договор № %s, признак окончания регистрации = %s',
                     l_title,
                     to_char(p_dptid),
                     to_char(p_final));

    select nvl(sum(inherit_share), 0)
      into l_totalshare
      from dpt_inheritors
     where dpt_id = p_dptid;

    bars_audit.trace('%s общая сумма долей = %s',
                     l_title,
                     to_char(l_totalshare));

    if p_final = 1 and not (l_totalshare = 100) then
      l_result := 'N';
    elsif p_final = 0 and not (l_totalshare between 0 and 100) then
      l_result := 'N';
    else
      l_result := 'Y';
    end if;

    bars_audit.trace('%s флаг достоверности данных = %s',
                     l_title,
                     l_result);

    return l_result;

  end inherit_valid_shares;

  -- ======================================================================================
  -- Активация свидетельства о праве на наследство
  -- ======================================================================================
  procedure inherit_activation(p_dptid          in dpt_inheritors.dpt_id%type,
                               p_inherit_custid in dpt_inheritors.inherit_custid%type) is
    l_title varchar2(60) := 'dpt_web.inherit_activation: ';
    l_state dpt_inheritors.inherit_state%type;
  begin
    bars_audit.trace('%s депозит № %s', l_title, to_char(p_dptid));
    bars_audit.trace('CONTRACT_ID = ' || to_char(p_dptid) ||
                     'TRUSTEE_RNK = ' || to_char(p_inherit_custid));

    select sum(inherit_state)
      into l_state
      from dpt_inheritors
     where dpt_id = p_dptid
       and inherit_custid = p_inherit_custid;

    if (l_state is null or l_state != 0) then
      -- СПН по договору № %s уже активировано
      bars_error.raise_nerror(g_modcode,
                              'INHERIT_ALREADY_ACTIVATED',
                              to_char(p_dptid));
    end if;

    /*
      -- забрав перевірку часток для можливості виплати спадщили одному спадкоємцю (Ощадбанк)
      IF inherit_valid_shares (p_dptid, 1) != 'Y' THEN
         -- неверно заданы доли наследников по договору № %s
         bars_error.raise_nerror(g_modcode, 'INVALID_INHERIT_SHARE', to_char(p_dptid));
      END IF;
    */

    bars_audit.trace('%s закрытие акт.ДС о правах 3-их лиц и о перечислении вклада',
                     l_title);

    for agr in (select a.agrmnt_id,
                       a.agrmnt_num,
                       a.trustee_id,
                       a.agrmnt_type,
                       f.name agrmnt_typename
                  from dpt_agreements a, dpt_vidd_flags f
                 where a.dpt_id = p_dptid
                   and a.agrmnt_type = f.id
                   and a.agrmnt_type in (5, 8, 10, 11, 12)
                   and a.agrmnt_state = 1
                 order by 1) loop
      bars_audit.trace('%s ДС № %s (%s), тип %s - %s',
                       l_title,
                       to_char(agr.agrmnt_num),
                       to_char(agr.agrmnt_id),
                       to_char(agr.agrmnt_type),
                       agr.agrmnt_typename);

      close_agreement(v_dptid        => p_dptid,
                      v_agrid        => agr.agrmnt_id,
                      v_agrnum       => agr.agrmnt_num,
                      v_new_agrmntid => null,
                      v_trustid      => agr.trustee_id);
    end loop;

    bars_audit.trace('%s выполнено закрытие ДС',
                     l_title);

    bars_audit.trace('%s очистка параметров выплаты процентов и возврата депозита',
                     l_title);

    change_deposit_accounts(p_dptid         => p_dptid,
                            p_intrcpname    => null,
                            p_intrcpidcode  => null,
                            p_intrcpacc     => null,
                            p_intrcpmfo     => null,
                            p_restrcpname   => null,
                            p_restrcpidcode => null,
                            p_restrcpacc    => null,
                            p_restrcpmfo    => null);

    bars_audit.trace('%s выполнена очистка параметров выплаты ',
                     l_title);

    update dpt_inheritors set inherit_state = 1 where dpt_id = p_dptid;

    if sql%rowcount = 0 then
      -- ошибка активации свидетельства о правах наследования договора № ...
      bars_error.raise_nerror(g_modcode,
                              'INHERIT_ACTIVATION_FAILED',
                              to_char(p_dptid));
    else
      bars_audit.trace('%s СПН договора № %s активировано',
                       l_title,
                       to_char(p_dptid));
    end if;
  end inherit_activation;

  -- ======================================================================================
  -- проверка: наследуется ли данный договор
  --
  function inherited_deal(p_dptid in dpt_inheritors.dpt_id%type,
                          p_param in dpt_inheritors.inherit_state%type default 0) -- для перевірки чи по депоз. є зареєстр.[=0]/активні[=1] спадкоємці
   return char is
    l_title  varchar2(60) := 'dpt_web.inherited_deal: ';
    l_result char(1);
  begin

    bars_audit.trace('%s договор № %s', l_title, to_char(p_dptid));

    select decode(cnt, 0, 'N', 'Y')
      into l_result
      from (select count(*) cnt
              from dpt_inheritors
             where dpt_id = p_dptid
               and inherit_state = decode(p_param, 1, 1, inherit_state));
    bars_audit.trace('%s флаг наследования = %s (p_param = %s)',
                     l_title,
                     l_result,
                     to_char(p_param));

    return l_result;

  end inherited_deal;

  -- ======================================================================================
  -- расчет допустимого остатка для выплаты наследнику
  --
  function inherit_rest(p_dptid   in dpt_inheritors.dpt_id%type,
                        p_heritor in dpt_inheritors.inherit_custid%type,
                        p_accid   in accounts.acc%type) return number is
    l_title      varchar2(60) := 'dpt_web.inherit_rest: ';
    l_heritrow   dpt_inheritors%rowtype;
    l_accrow     accounts%rowtype;
    l_bdate      date := gl.bdate;
    l_saldo0     number;
    l_credit     number;
    l_debit      number;
    l_payoff     number;
    l_payoff_all number;
    l_rest       number;
  begin

    bars_audit.trace('%s депозит № %s (счет %s), наследник № %s',
                     l_title,
                     to_char(p_dptid),
                     to_char(p_accid),
                     to_char(p_heritor));

    begin
      select *
        into l_heritrow
        from dpt_inheritors
       where dpt_id = p_dptid
         and inherit_custid = p_heritor;
    exception
      when no_data_found then
        -- не найдена запись о наследнике № ... по договору № ...
        bars_error.raise_nerror(g_modcode,
                                'INHERITOR_NOT_FOUND',
                                to_char(p_heritor),
                                to_char(p_dptid));
    end;

    bars_audit.trace('%s доля в наследстве = %s %%',
                     l_title,
                     to_char(l_heritrow.inherit_share));

    if (l_heritrow.inherit_date > trunc(sysdate) or
       l_heritrow.inherit_state != 1) then
      -- наследник №.. еще не вступил в права наследования договора № ...
      bars_error.raise_nerror(g_modcode,
                              'INHERIT_NOT_ACTIVE',
                              to_char(p_heritor),
                              to_char(p_dptid));
    end if;

    -- поиск счета, проверка параметров
    begin
      select a.*
        into l_accrow
        from accounts a, v_dpt_accounts da
       where a.acc = p_accid
         and a.acc = da.acc_id
         and da.dpt_id = p_dptid
         and a.dazs is null;
    exception
      when no_data_found then
        -- не найден счет
        bars_error.raise_nerror(g_modcode,
                                'ACC_NOT_FOUND',
                                to_char(p_accid));
    end;
    bars_audit.trace('%s счет %s / %s',
                     l_title,
                     l_accrow.nls,
                     to_char(l_accrow.kv));

    if l_accrow.ostc != l_accrow.ostb then
      -- невозможно расчитать допустимую сумму выплаты по счету %s / %s - есть незавизир.документы
      bars_error.raise_nerror(g_modcode,
                              'INHERIT_CALC_DENIED',
                              l_accrow.nls,
                              to_char(l_accrow.kv));
    end if;

    /*
      -- Перевірка на вплату спадщини з технічного вкладу
      select vidd
        into l_vidd
        from dpt_deposit
       where deposit_id = p_dptid;

      if (l_vidd < 0) then
        begin
          select d.deposit_id, d.acc, d.dat_end, i.acra
            into l_dpt, l_acc
            from dpt_deposit_clos d,
                 int_accn         i,
                 dpt_inheritors   h
           where d.dpt_d = p_dptid
             and d.action_id in (1,2)
             and d.acc = i.acc
             and i.id = 1
             AND d.deposit_id = h.dpt_id;
             --AND h.inherit_custid = p_heritor;
        exception
          when NO_DATA_FOUND then
            null;
            -- по депозитному договору до тех.вкладу не було зареєстровано спадкоємців
            -- bars_error.raise_nerror(g_modcode, '');
        end;
      end if;
    */

    -- входящий остаток на счете на банк.дату ввода в систему свид-тва о правах на наследство
    begin
      select (ost + dos - kos)
        into l_saldo0
        from sal
       where acc = p_accid
         and fdat =
             (select max(fdat) from fdat where fdat <= l_heritrow.bankdate);
    exception
      when no_data_found then
        begin
          -- для депозитів мігрованих пізніше дати вступу в права залишок = 0 (+ сума усіх надходжень післі дати вступу (l_credit))
          select 0
            into l_saldo0
            from bars.dpt_deposit d
           where d.deposit_id = p_dptid
             and instr(d.comments, 'Imported from') > 0;
        exception
          when no_data_found then
            -- невозможно рассчитать остаток на счете %s / %s на %s
            bars_error.raise_nerror(g_modcode,
                                    'SALDO_CALC_ERROR',
                                    l_accrow.nls,
                                    to_char(l_accrow.kv),
                                    to_char(l_heritrow.bankdate,
                                            'dd.mm.yyyy'));
        end;
    end;

    bars_audit.trace('%s вход.остаток на  %s = %s',
                     l_title,
                     to_char(l_heritrow.bankdate, 'dd.mm.yyyy'),
                     to_char(l_saldo0));

    -- сумма всех поступлений на счет после ввода в систему свид-тва о правах на наследство
    select nvl(sum(kos), 0), nvl(sum(dos), 0)
      into l_credit, l_debit
      from saldoa
     where acc = p_accid
       and fdat >= l_heritrow.bankdate
       and fdat <= l_bdate;
    -- AND fdat >= l_heritrow.inherit_date AND fdat <= l_bdate;

    bars_audit.trace('%s сумма всех поступлений / списаний за период с %s по %s = %s / %s',
                     l_title,
                     to_char(l_heritrow.bankdate, 'dd.mm.yyyy'),
                     to_char(l_bdate, 'dd.mm.yyyy'),
                     to_char(l_credit),
                     to_char(l_debit));

    -- сумма выплат данному наследнику
    select nvl(sum(decode(w.value, to_char(p_heritor), s, 0)), 0),
           nvl(sum(s), 0)
      into l_payoff, l_payoff_all
      from opldok o, operw w
     where o.acc = p_accid
       and o.dk = 0
       and o.sos = 5
       and o.fdat >= l_heritrow.bankdate
       and o.fdat <= l_bdate
       and o.ref = w.ref
       and w.tag = 'HERIT';

    bars_audit.trace('%s общая сумма выплат наследнику = %s',
                     l_title,
                     to_char(l_payoff));
    bars_audit.trace('%s общая сумма выплат наследникам = %s',
                     l_title,
                     to_char(l_payoff_all));
    bars_audit.trace('%s общая сумма выплат "в никуда"  = %s',
                     l_title,
                     to_char((l_debit - l_payoff_all)));

    --l_rest := (l_saldo0 + l_credit - (l_debit - l_payoff_all))
    --        * (l_heritrow.inherit_share/100)
    --        - l_payoff;

    l_rest := (l_saldo0 + l_credit);
    bars_audit.trace('%s общая сумма наследства = %s',
                     l_title,
                     to_char(l_rest));

    l_rest := l_rest - (l_debit - l_payoff_all);
    bars_audit.trace('%s чистая сумма наследства = %s',
                     l_title,
                     to_char(l_rest));

    l_rest := round(l_rest * l_heritrow.inherit_share / 100);
    bars_audit.trace('%s общая сумма наследства для наследника = %s',
                     l_title,
                     to_char(l_rest));

    l_rest := l_rest - l_payoff;
    bars_audit.trace('%s остаток к выплате наследнику = %s',
                     l_title,
                     to_char(l_rest));

    -- на счете может не хватить средств из-за погрешности округления
    l_rest := least(l_rest, l_accrow.ostc);
    bars_audit.trace('%s ИТОГО: %s', l_title, to_char(l_rest));

    return l_rest;

  end inherit_rest;

  -- ======================================================================================
  -- поиск карт.счета для возврата депозита / выплаты %% (исп. в операциях TM%)
  function get_payoffcardacc(p_payofftype in char,
                             p_debitacc   in accounts.nls%type,
                             p_currency   in accounts.kv%type)
    return varchar2 is
    l_cardaccount dpt_deposit.nls_d%type;
  begin

    if p_payofftype = 'D' then

      begin
        select d.nls_d
          into l_cardaccount
          from dpt_deposit d, accounts a
         where d.acc = a.acc
           and a.nls = p_debitacc
           and a.kv = p_currency
           and d.nls_d is not null
           and account_is_card(gl.amfo, d.nls_d) = 1;
      exception
        when no_data_found then
          l_cardaccount := null;
      end;

    elsif p_payofftype = 'P' then

      begin
        select d.nls_p
          into l_cardaccount
          from dpt_deposit d, int_accn i, accounts a
         where d.acc = i.acc
           and i.id = 1
           and i.acra = a.acc
           and a.nls = p_debitacc
           and a.kv = p_currency
           and d.nls_p is not null
           and account_is_card(gl.amfo, d.nls_p) = 1;
      exception
        when no_data_found then
          l_cardaccount := null;
      end;

    else

      l_cardaccount := null;

    end if;

    return l_cardaccount;

  end get_payoffcardacc;
  -- ======================================================================================
  -- расчет ставки по счету на дату (корректная обработка нулевых счетов)
  function get_dptrate(p_dptacc in dpt_deposit.acc%type,
                       p_dptcur in dpt_deposit.kv%type,
                       p_dptsum in dpt_deposit.limit%type,
                       p_date   in date) return number is
    l_id    int_accn.id%type := 1;
    l_rate  number;
    l_saldo accounts.ostc%type;
    l_ir    int_ratn.ir%type;
    l_br    int_ratn.br%type;
    l_op    int_ratn.op%type;
  begin

    begin
      select s.ostf - s.dos + s.kos
        into l_saldo
        from saldoa s
       where s.acc = p_dptacc
         and s.fdat = (select max(fdat)
                         from saldoa
                        where acc = p_dptacc
                          and fdat <= p_date);
    exception
      when no_data_found then
        l_saldo := 0;
    end;

    if l_saldo != 0 then

      l_rate := acrn.fproc(p_dptacc, p_date);
      return l_rate;

    else

      begin
        select nvl(ir, 0), nvl(br, 0), op
          into l_ir, l_br, l_op
          from int_ratn
         where acc = p_dptacc
           and id = l_id
           and bdat = (select max(bdat)
                         from int_ratn
                        where acc = p_dptacc
                          and id = l_id
                          and bdat <= p_date);
      exception
        when no_data_found then
          return 0;
      end;

      if l_br > 0 then
        -- значение базової ставки на дату
        l_rate := nvl(getbrat(p_date, l_br, p_dptcur, p_dptsum), 0);
      else
        l_rate := 0;
      end if;

      l_rate := case
                  when (l_ir + l_rate = 0) then
                   0
                  when (l_ir * l_rate = 0) then
                   l_ir + l_rate
                  else
                   case
                     when l_op = 1 then
                      l_ir + l_rate
                     when l_op = 2 then
                      l_ir - l_rate
                     when l_op = 3 then
                      l_ir * l_rate
                     when l_op = 4 then
                      l_ir / l_rate
                   end
                end;

    end if;

    return l_rate;

  end get_dptrate;
  -- ======================================================================================
  --
  --  внутренняя процедура очистки альтернативной %-ной карточки
  --
  procedure intl_clear_altintcard(p_dptaccid in accounts.acc%type, -- внутр.номер депозитного счета
                                  p_altintid in int_accn.id%type) -- код альтерн.процентной карточки
   is
    title varchar2(60) := 'dpt_web.glpenalty.clear: ';
  begin

    bars_audit.trace('%s старт с параметрами (%s, %s)...',
                     title,
                     to_char(p_dptaccid),
                     to_char(p_altintid));

    delete from int_ratn
     where acc = p_dptaccid
       and id = p_altintid;
    delete from acr_docs
     where acc = p_dptaccid
       and id = p_altintid;
    delete from int_accn
     where acc = p_dptaccid
       and id = p_altintid;
    delete from tmp_intarc
     where acc = p_dptaccid
       and id = p_altintid;

    bars_audit.trace('%s выполнено для параметров (%s, %s)',
                     title,
                     to_char(p_dptaccid),
                     to_char(p_altintid));

  end intl_clear_altintcard;

  --
  --  внутренняя процедура заполнения альтернативной процентной карточки и ставки
  --
  procedure intl_fill_altintcard(p_dptaccid  in accounts.acc%type, -- внутр.номер депозитного счета
                                 p_genintid  in int_accn.id%type, -- код основной процентной карточки
                                 p_altintid  in int_accn.id%type, -- код альтерн.процентной карточки
                                 p_intdat1   in int_accn.acr_dat%type, -- дата предыдущего начисления
                                 p_intdat2   in int_accn.stp_dat%type, -- граничная дата начисления
                                 p_penyadate in int_ratn.bdat%type, -- дата установки штрафной ставки
                                 p_penyarate in int_ratn.ir%type) -- штрафная ставка
   is
    title varchar2(60) := 'dpt_web.glpenalty.fill: ';
  begin

    bars_audit.trace('%s старт с параметрами (dptaccid = %s, altintid = %s, intdat1 = %s, intdat2 = %s, penyarate = %s, penyadate = %s)',
                     title,
                     to_char(p_dptaccid),
                     to_char(p_altintid),
                     to_char(p_intdat1, 'dd.mm.yyyy'),
                     to_char(p_intdat2, 'dd.mm.yyyy'),
                     nvl(to_char(p_penyarate), 'null'),
                     nvl(to_char(p_penyadate, 'dd.mm.yyyy'), 'null'));
    -- параметры альтернативной карточки наследуем из основной карточки
    -- меняем дату предыдущего начисления и стоп-дату для начисления
    begin
      insert into int_accn
        (acc, id, acr_dat, stp_dat, metr, basey, freq, io, acra, acrb, tt)
        select acc,
               p_altintid,
               p_intdat1,
               p_intdat2,
               metr,
               basey,
               1,
               io,
               acra,
               acrb,
               tt
          from int_accn
         where acc = p_dptaccid
           and id = p_genintid;
    exception
      when dup_val_on_index then
        update int_accn
           set acr_dat = p_intdat1, stp_dat = p_intdat2
         where acc = p_dptaccid
           and id = p_altintid;
    end;

    --
    delete from int_ratn
     where acc = p_dptaccid
       and id = p_altintid;

    if ((p_penyadate is not null) and (p_penyarate is not null)) then

      -- установка штрафной ставки
      insert into int_ratn
        (acc, id, bdat, ir)
      values
        (p_dptaccid, p_altintid, p_penyadate, p_penyarate);

      bars_audit.trace('%s вставлено штрафну ставку (bdat = %s, ir = %s)',
                       title,
                       to_char(p_penyadate, 'DD/MM/YYYY'),
                       to_char(p_penyarate));

      -- переносим значення ставок які передують даті штрафної ставки (штрафується не весь термін договору)
      if (p_penyadate > p_intdat1) then

        -- копіюєм значення основної ставки
        insert into int_ratn
          (acc, id, bdat, ir, op, br)
          select i.acc, p_altintid, i.bdat, i.ir, i.op, i.br
            from int_ratn i
           where i.acc = p_dptaccid
             and i.id = p_genintid
             and i.bdat < p_penyadate;

        bars_audit.trace('%s зкопійовано значення основної ставки (%s записів)...',
                         title,
                         to_char(sql%rowcount));

      end if;

    else

      -- наследование основной ставки
      insert into int_ratn
        (acc, id, bdat, ir, op, br)
        select i.acc, p_altintid, i.bdat, i.ir, i.op, i.br
          from int_ratn i
         where i.acc = p_dptaccid
           and i.id = p_genintid;

      bars_audit.trace('%s наследование основной ставки (%s, %s)...',
                       title,
                       to_char(p_dptaccid),
                       to_char(p_altintid));
    end if;

    bars_audit.trace('%s виконано для параметрів (%s, %s)',
                     title,
                     to_char(p_dptaccid),
                     to_char(p_altintid));

  end intl_fill_altintcard;
  --
  --  внутренняя процедура расчета суммы процентов (RO) и порождения документа (RO + RW)
  --
  procedure intl_calc_interest(p_mode      in char, -- RO - расчет, RW - проводки
                               p_date      in date, -- дата списания средств
                               p_accrec    in accounts%rowtype, -- параметры депозитного счета
                               p_intid     in int_accn.id%type, -- код процентной карточки (1 / 3)
                               p_stopdate  in int_accn.stp_dat%type, -- граничная дата начисления
                               p_curcode   in tabval.lcv%type, -- символьный код валюты депозита
                               p_details   in oper.nazn%type, -- назначение платежа
                               p_dptamount in number, -- сумма начисления (м.б. null)
                               p_dptid     in number default null, -- идентификатор договора
                               p_intamount out number) -- сумма начисленных процентов
   is
    title       varchar2(60) := 'dpt_web.glpenalty.calcint: ';
    l_mode      number;
    l_intamount number;
    l_errflg    boolean := false;
  begin

    bars_audit.trace('%s старт, режим %s, сумма - %s %s',
                     title,
                     p_mode,
                     to_char(p_dptamount),
                     p_curcode);

    -- 0 = расчет, 1 = расчет + проводки
    l_mode := case
                when p_mode = 'RO' then
                 0
                else
                 1
              end;

    -- delete from int_queue; -- where acc_id = p_accrec.acc and int_id = p_intid;
    insert into int_queue
      (kf,
       branch,
       deal_id,
       deal_num,
       deal_dat,
       cust_id,
       int_id,
       acc_id,
       acc_num,
       acc_cur,
       acc_nbs,
       acc_name,
       acc_iso,
       acc_open,
       acc_amount,
       int_details,
       int_tt,
       mod_code)
    values
      (p_accrec.kf,
       p_accrec.branch,
       p_dptid,
       null,
       null,
       p_accrec.rnk,
       p_intid,
       p_accrec.acc,
       p_accrec.nls,
       p_accrec.kv,
       p_accrec.nbs,
       substr(p_accrec.nms, 1, 38),
       p_curcode,
       p_accrec.daos,
       p_dptamount,
       substr(p_details, 1, 160),
       '%%1',
       'DPT');

    make_int(p_dat2      => p_stopdate,
             p_runmode   => l_mode,
             p_runid     => 0,
             p_intamount => l_intamount,
             p_errflg    => l_errflg);

    if l_errflg then
      bars_error.raise_nerror(g_modcode,
                              'MAKE_INT_ERROR',
                              p_accrec.nls,
                              to_char(p_accrec.kv),
                              to_char(p_accrec.acc));
    end if;

    p_intamount := nvl(l_intamount, 0);
    --p_intamount := nvl(round(l_intamount), 0);

    bars_audit.trace('%s выход, начислено %s %s',
                     title,
                     p_mode,
                     to_char(p_intamount),
                     p_curcode);

  end intl_calc_interest;
  --
  -- внутренняя процедура проверок при частичном / полном снятии суммы вклада
  --
  procedure intl_validate_payoff(p_date      in date, -- дата снятия средств
                                 p_begdate   in date, -- дата начала действия договора
                                 p_enddate   in date, -- дата окончания действия договора
                                 p_dptaccrow in accounts%rowtype, -- реквизиты депозитного счета
                                 p_intaccrow in accounts%rowtype, -- реквизиты процентного счета
                                 p_amraccrow in accounts%rowtype, -- реквизиты счета амортизации
                                 p_fullpay   in number, -- признак расторжения договора
                                 p_minsum    in number, -- мин.сумма для вида вклада
                                 p_amount    in number, -- сумма снятия
                                 p_stopid    in dpt_vidd.id_stop%type, -- код штрафа
                                 p_brwd      in dpt_vidd.br_wd%type, -- код ставки част.снятия
                                 p_nopenya   out boolean, -- признак свободной выплаты
                                 p_errmsg    out varchar2) -- сообщение об ошибке
   is
    title     varchar2(60) := 'dpt_web.glpenalty.valid: ';
    l_nopenya boolean := false;
    l_errmsg  varchar2(3000) := null;
    l_done    number;
  begin

    bars_audit.trace('%s старт...', title);

    if (p_date < p_begdate) then
      -- договор еще не вступил в силу
      l_nopenya := false;
      l_errmsg  := bars_msg.get_msg(g_modcode, 'GLPENALTY_EARLY');
    elsif (p_date >= p_enddate) then
      -- срок действия договора истек
      l_nopenya := true;
      l_errmsg  := bars_msg.get_msg(g_modcode, 'GLPENALTY_LATE');
    elsif (p_enddate is null) then
      -- договор до востребования
      l_nopenya := true;
      l_errmsg  := bars_msg.get_msg(g_modcode, 'GLPENALTY_DEMAND');
    elsif (p_dptaccrow.blkd = 12) then
      l_nopenya := false;
      l_errmsg  := bars_msg.get_msg(g_modcode, 'GLPENALTY_INSIDER');
    elsif (p_dptaccrow.ostc = 0) then
      -- нулевой остаток на депозитном счете
      l_nopenya := true;
      l_errmsg  := bars_msg.get_msg(g_modcode, 'GLPENALTY_NULL_AMOUNT');
    elsif (p_fullpay = 1 and p_stopid = 0) then
      -- не описан штраф для вида вклада
      l_nopenya := true;
      l_errmsg  := bars_msg.get_msg(g_modcode, 'GLPENALTY_NO_STOPID');
    elsif (p_fullpay = 0 and p_brwd = 0) then
      -- не описана ставка част.снятия для вида вклада
      if (p_minsum > 0 and p_minsum > p_dptaccrow.ostc - p_amount) then
        -- остаток после част.снятия меньше минимально допустимого
        l_nopenya := false;
        l_errmsg  := bars_msg.get_msg(g_modcode, 'GLPENALTY_INVALID_REST');
      else
        l_nopenya := true;
        l_errmsg  := bars_msg.get_msg(g_modcode, 'GLPENALTY_NO_BRWD');
      end if;
    elsif (p_fullpay = 1) then
      select count(*)
        into l_done
        from dpt_deposit_clos
       where acc = p_dptaccrow.acc
         and action_id = 5;
      if l_done > 0 then
        -- штрафование уже было выполнено
        l_nopenya := true;
        l_errmsg  := bars_msg.get_msg(g_modcode, 'GLPENALTY_DONE');
      end if;
    elsif ((p_dptaccrow.ostc != p_dptaccrow.ostb and
          p_dptaccrow.ostc != p_dptaccrow.ostb + p_amount) or
          p_dptaccrow.ostf != 0) then
      -- найдены незавизированные документы по депозитному счету
      l_nopenya := false;
      l_errmsg  := bars_msg.get_msg(g_modcode,
                                    'GLPENALTY_PLAN_DPTDOCS_EXISTS');
    elsif (p_intaccrow.ostc != p_intaccrow.ostb or p_intaccrow.ostf != 0) then
      -- найдены незавизированные документы по процентному счету
      l_nopenya := false;
      l_errmsg  := bars_msg.get_msg(g_modcode,
                                    'GLPENALTY_PLAN_INTDOCS_EXISTS');
    elsif (p_amraccrow.acc is not null and
          (p_amraccrow.ostc != p_amraccrow.ostb or p_amraccrow.ostf != 0)) then
      -- найдены незавизированные документы по счету амортизации
      l_nopenya := false;
      l_errmsg  := bars_msg.get_msg(g_modcode,
                                    'GLPENALTY_PLAN_AMRDOCS_EXISTS');
    elsif (p_fullpay = 0 and p_minsum > 0 and
          p_minsum > p_dptaccrow.ostc - p_amount) then
      -- остаток после част.снятия меньше минимально допустимого
      l_nopenya := false;
      l_errmsg  := bars_msg.get_msg(g_modcode, 'GLPENALTY_INVALID_REST');
    elsif (p_amount > p_dptaccrow.ostc) then
      -- остаток на депозитном счете меньше суммы снятия
      l_nopenya := false;
      l_errmsg  := bars_msg.get_msg(g_modcode, 'GLPENALTY_BROKEN_LIMIT');
    else
      l_nopenya := false;
      l_errmsg  := null;
    end if;
    bars_audit.trace('%s сообщение - %s', title, l_errmsg);

    if l_nopenya then
      p_nopenya := l_nopenya;
      p_errmsg  := null;
      bars_audit.trace('%s штраф не предусмотрен',
                       title);
    else
      p_nopenya := l_nopenya;
      p_errmsg  := l_errmsg;
      if p_errmsg is null then
        bars_audit.trace('%s штраф разрешен', title);
      else
        bars_audit.trace('%s штраф заблокирован - %s',
                         title,
                         p_errmsg);
      end if;
    end if;

  end intl_validate_payoff;
  --
  -- внутренняя процедура формирования t_turndata в разрезе БАНКОВСКИХ дней
  --
  procedure intl_get_turndata_bnk(p_accid   in accounts.acc%type, -- внутр.№ депозитного счета
                                  p_datbeg  in date, -- дата начала действия договора
                                  p_datend  in date, -- дата списания средств
                                  p_accturn out t_turndata) -- банк.даты с оборотами
   is
    title     varchar2(60) := 'dpt_web.glpenalty.getamounts.bnk:';
    l_mindat  date;
    l_maxdat  date;
    l_accturn t_turndata;
  begin

    bars_audit.trace('%s entry, acc=>%s, datbeg=>%s, datend=>%s',
                     title,
                     to_char(p_accid),
                     to_char(p_datbeg, 'dd.mm.yy'),
                     to_char(p_datend, 'dd.mm.yy'));

    -- даты первого и последнего движения по счету
    select min(fdat), max(fdat)
      into l_mindat, l_maxdat
      from (select fdat
              from saldoa
             where acc = p_accid
               and fdat >= p_datbeg
               and fdat <= p_datend
               and dos + kos > 0
            union
            select p_datbeg -- берем дату начала вклада, если движений не было, но вклад с остатком
              from saldoa
             where acc = p_accid
               and fdat = (select max(s.fdat)
                             from saldoa s
                            where s.acc = p_accid
                              and s.fdat < p_datbeg
                              and s.ostf - s.dos + s.kos > 0));

    bars_audit.trace('%s 1-st date - %s, last date - %s',
                     title,
                     to_char(l_mindat, 'dd.mm.yy'),
                     to_char(l_maxdat, 'dd.mm.yy'));

    select acc,
           fdat,
           pdat,
           ostf,
           dos,
           kos,
           null,
           null,
           null,
           null,
           null,
           null
      bulk collect
      into l_accturn
      from ( -- все движения, не включая дату перв.взноса и текущую
            select acc,
                    fdat,
                    greatest(pdat, l_mindat - 1) pdat,
                    ostf,
                    dos,
                    kos
              from saldoa
             where acc = p_accid
               and fdat > l_mindat
               and fdat < p_datend
               and dos + kos > 0
            union
            -- текущая дата (если сегодня уже были движения есть)
            select acc,
                    fdat,
                    decode(fdat, l_mindat, fdat, greatest(pdat, l_mindat - 1)),
                    decode(fdat, l_mindat, ostf - dos + kos, ostf),
                    decode(fdat, l_mindat, 0, dos),
                    decode(fdat, l_mindat, 0, kos)
              from saldoa
             where acc = p_accid
               and fdat = l_maxdat
               and l_maxdat = p_datend
            union
            -- текущая дата с вход.остатком (если сегодня движений не было)
            select acc, p_datend, fdat, ostf - dos + kos, 0, 0
              from saldoa
             where acc = p_accid
               and fdat = l_maxdat
               and l_maxdat < p_datend);

    if l_accturn.count = 0 then
      select acc,
             p_datend,
             l_mindat - 1,
             ostf - dos + kos,
             0,
             0,
             null,
             null,
             null,
             null,
             null,
             null
        bulk collect
        into l_accturn
        from saldoa
       where (acc, fdat) = (select s.acc, max(s.fdat)
                              from saldoa s
                             where s.acc = p_accid
                               and s.fdat < p_datbeg
                               and s.ostf - s.dos + s.kos > 0
                             group by s.acc);
    end if;

    p_accturn := l_accturn;
    bars_audit.trace('%s exit', title);

  end intl_get_turndata_bnk;
  --
  -- внутренняя процедура формирования t_turndata в разрезе КАЛЕНДАРНЫХ дней
  --
  procedure intl_get_turndata_sys(p_accid   in accounts.acc%type, -- внутр.№ депозитного счета
                                  p_datbeg  in date, -- дата начала действия договора
                                  p_datend  in date, -- дата списания средств
                                  p_accturn out t_turndata) -- банк.даты с оборотами
   is
    title     varchar2(60) := 'dpt_web.glpenalty.getamounts.sys:';
    l_mindat  date;
    l_maxdat  date;
    l_accturn t_turndata;
  begin

    bars_audit.trace('%s entry, acc=>%s, datbeg=>%s, datend=>%s',
                     title,
                     to_char(p_accid),
                     to_char(p_datbeg, 'dd.mm.yy'),
                     to_char(p_datend, 'dd.mm.yy'));

    delete from saldoho;

    insert into saldoho
      (fdat, pdat, ostf, dos, kos)
      select fdat,
             lag(fdat) over(order by fdat),
             acrn.ho_ost(p_accid, fdat, -dos + kos, rownum),
             dos,
             kos
        from (select fdat, dos, kos
                from (select fdat, sum(dos) dos, sum(kos) kos
                        from (select fdat, dos, kos
                                from saldoa
                               where acc = p_accid
                                 and fdat =
                                     (select max(fdat)
                                        from saldoa
                                       where acc = p_accid
                                         and fdat < p_datbeg - 10) -- выбираем с запасом 10 выходных подряд
                              union all
                              select fdat, dos, kos
                                from saldoa
                               where acc = p_accid
                                 and fdat between p_datbeg - 10 and p_datend
                              union all
                              select cdat, nvl(dos, 0), nvl(kos, 0)
                                from v_saldo_holiday
                               where acc = p_accid
                                 and cdat between p_datbeg - 10 and p_datend
                              union all
                              select (select min(s.fdat)
                                        from saldoa s
                                       where s.acc = p_accid
                                         and s.fdat > v.cdat),
                                     nvl(-v.dos, 0),
                                     nvl(-v.kos, 0)
                                from v_saldo_holiday v
                               where v.acc = p_accid
                                 and v.cdat between p_datbeg - 10 and p_datend)
                       group by fdat
                       order by fdat)
               where dos + kos != 0);

    -- даты первого и последнего движения по счету
    select min(fdat), max(fdat)
      into l_mindat, l_maxdat
      from (select fdat
              from saldoho
             where fdat >= p_datbeg
               and fdat <= p_datend
               and dos + kos > 0
            union
            select p_datbeg -- берем дату начала вклада, если движений не было, но вклад с остатком
              from saldoho
             where fdat = (select max(s.fdat)
                             from saldoho s
                            where s.fdat < p_datbeg
                              and s.ostf - s.dos + s.kos > 0));

    bars_audit.trace('%s 1-st date - %s, last date - %s',
                     title,
                     to_char(l_mindat, 'dd.mm.yy'),
                     to_char(l_maxdat, 'dd.mm.yy'));

    select p_accid,
           fdat,
           pdat,
           ostf,
           dos,
           kos,
           null,
           null,
           null,
           null,
           null,
           null
      bulk collect
      into l_accturn
      from ( -- все движения, не включая дату перв.взноса и текущую
            select fdat, greatest(pdat, l_mindat - 1) pdat, ostf, dos, kos
              from saldoho
             where fdat > l_mindat
               and fdat < p_datend
               and dos + kos > 0
            union
            -- текущая дата (если сегодня уже были движения есть)
            select fdat,
                    decode(fdat, l_mindat, fdat, greatest(pdat, l_mindat - 1)),
                    decode(fdat, l_mindat, ostf - dos + kos, ostf),
                    decode(fdat, l_mindat, 0, dos),
                    decode(fdat, l_mindat, 0, kos)
              from saldoho
             where fdat = l_maxdat
               and l_maxdat = p_datend
            union
            -- текущая дата с вход.остатком (если сегодня движений не было)
            select p_datend, fdat, ostf - dos + kos, 0, 0
              from saldoho
             where fdat = l_maxdat
               and l_maxdat < p_datend);

    if l_accturn.count = 0 then
      select p_accid,
             p_datend,
             l_mindat - 1,
             ostf - dos + kos,
             0,
             0,
             null,
             null,
             null,
             null,
             null,
             null
        bulk collect
        into l_accturn
        from saldoho
       where fdat = (select max(s.fdat)
                       from saldoho s
                      where s.fdat < p_datbeg
                        and s.ostf - s.dos + s.kos > 0);
    end if;

    p_accturn := l_accturn;
    bars_audit.trace('%s exit', title);

  end intl_get_turndata_sys;
  --
  --  внутренняя процедура разметки сумм и дат для начисления процентов
  --
  procedure intl_get_amounts(p_dptaccid in accounts.acc%type, -- внутр.№ депозитного счета
                             p_datbeg   in date, -- дата начала действия договора
                             p_date     in date, -- дата списания средств
                             p_amount   in number, -- сумма списания
                             p_commiss  in number, -- сумма комиссии
                             p_intio    in number, -- тип вычисления остатка
                             p_accturn  out t_turndata) -- суммы к штрафованию
   is
    title     varchar2(60) := 'dpt_web.glpenalty.getamounts: ';
    l_accturn t_turndata;
    l_acrdat  date;
    l_turncnt number;
    l_payed   number;
  begin

    bars_audit.trace('%s разметка сумм по срокам для счета %s и суммы снятия %s (+%s)...',
                     title,
                     to_char(p_dptaccid),
                     to_char(p_amount),
                     to_char(p_commiss));

    -- для режима RO начисление выполняется "в уме", без изменения даты посл.начисления
    -- в любом случае, проценты начислены минимум по текущую дату минус 1 день
    select acr_dat
      into l_acrdat
      from int_accn
     where acc = p_dptaccid
       and id = 1;
    if l_acrdat is null then
      l_acrdat := p_date - 1;
    else
      l_acrdat := greatest(l_acrdat, p_date - 1);
    end if;
    bars_audit.trace('%s проценты начислены по %s',
                     title,
                     to_char(l_acrdat, 'dd.mm.yy'));

    bars_audit.trace('%s тип вычисления остатка - %s',
                     title,
                     to_char(p_intio));
    if p_intio = 3 then
      bars_audit.trace('%s разметка в разрезе календарных дат',
                       title);
      intl_get_turndata_sys(p_accid   => p_dptaccid, -- внутр.№ депозитного счета
                            p_datbeg  => p_datbeg, -- дата начала действия договора
                            p_datend  => p_date, -- дата списания средств
                            p_accturn => l_accturn); -- банк.даты с оборотами
    else
      bars_audit.trace('%s разметка в разрезе банковских дат',
                       title);
      intl_get_turndata_bnk(p_accid   => p_dptaccid, -- внутр.№ депозитного счета
                            p_datbeg  => p_datbeg, -- дата начала действия договора
                            p_datend  => p_date, -- дата списания средств
                            p_accturn => l_accturn); -- банк.даты с оборотами
    end if;

    l_turncnt := l_accturn.count;

    for i in 1 .. l_turncnt loop

      l_payed := 0;
      for j in i .. l_turncnt loop
        -- общая сумма последующих списаний
        l_payed := l_payed + l_accturn(j).debit;
      end loop;

      --входящий остаток минус все последующие списания
      l_accturn(i).rest := greatest(l_accturn(i).saldo - l_payed, 0);

      -- сумма для начисления и выплаты по штрафной ставке
      l_accturn(i).rest2pay := least(l_accturn(i).rest, p_amount);

      -- сумма для начисления и взыскания штрафа по обычной ставке
      l_accturn(i).rest2take := least(l_accturn(i).rest,
                                      p_amount + p_commiss);

      -- конечная дата предыдущего начисления
      l_accturn(i).intdat1 := l_accturn(i).prevdat;

      -- конечная дата текущего начисления по ставке част.снятия ( max() = текущая - 1)
      l_accturn(i).intdat2 := case
                                when l_accturn(i).currdat < p_date then
                                 l_accturn(i).currdat
                                else
                                 l_accturn(i).currdat - 1
                              end;

      -- конечная дата текущего начисления по обычной ставке ( max() >= текущая - 1)
      l_accturn(i).intdat3 := case
                                when l_accturn(i).currdat < p_date then
                                 l_accturn(i).currdat
                                else
                                 l_acrdat -- !!! l_accturn(i).currdat - 1
                              end;

      bars_audit.trace('%s %s - %s: вх.ост./Дт/Кт = (%s, %s, %s), ' ||
                       'сумма для нач.по штрафной ставке = %s, ' ||
                       'сумма для нач.и взыскания штрафа = %s',
                       title,
                       to_char(l_accturn(i).currdat, 'dd.mm.yy'),
                       to_char(l_accturn(i).prevdat, 'dd.mm.yy'),
                       to_char(l_accturn(i).saldo),
                       to_char(l_accturn(i).debit),
                       to_char(l_accturn(i).credit),
                       to_char(l_accturn(i).rest2pay),
                       to_char(l_accturn(i).rest2take));

      bars_audit.trace('%s гран.даты начисления (%s, %s, %s)',
                       title,
                       to_char(l_accturn(i).intdat1, 'dd.mm.yy'),
                       to_char(l_accturn(i).intdat2, 'dd.mm.yy'),
                       to_char(l_accturn(i).intdat3, 'dd.mm.yy'));

    end loop;

    p_accturn := l_accturn;

    bars_audit.trace('%s разметка сумм по срокам для счета %s и суммы снятия %s (+%s) выполнена',
                     title,
                     to_char(p_dptaccid),
                     to_char(p_amount),
                     to_char(p_commiss));

  end intl_get_amounts;
  --
  -- внутренняя процедура формирования пакета документов при част./полном снятии суммы со вклада
  --
  procedure intl_make_penaltydocs(p_dptid         in dpt_deposit.deposit_id%type, -- идентификатор договора
                                  p_dptaccid      in accounts.acc%type, -- внутр.№ депозитного счета
                                  p_intaccid      in accounts.acc%type, -- внутр.№ процентного счета
                                  p_amraccid      in accounts.acc%type, -- внутр.№ счета амортизации
                                  p_expaccid      in accounts.acc%type, -- внутр.№ счета расходов
                                  p_expaccid2     in accounts.acc%type, -- внутр.№ счета расходов для возврата штрафа
                                  p_taxaccid      in accounts.acc%type, -- внутр.№ счета утримання податку з нарах. %% по штрафній ставці
                                  p_taxaccid2     in accounts.acc%type, -- внутр.№ счета повернення утриманого податку при штрафуванні
                                  p_taxaccid_mil  in accounts.acc%type, -- внутр.№ счета утримання податку (Військовий збір) з нарах. %% по штрафній ставці
                                  p_taxaccid2_mil in accounts.acc%type, -- внутр.№ счета повернення утриманого податку (Військовий збір) при штрафуванні
                                  p_amount        in number, -- сумма снятия
                                  p_int2payoff    in number, -- сумма процентов на сумму снятия (%%1)
                                  p_intdetails    in oper.nazn%type, -- назначение платежа по начислению %%
                                  p_intamount     in number, -- сумма штрафа для списания с проц.счета
                                  p_dptamount     in number, -- сумма штрафа для списания с деп.счета на 7041
                                  p_amramount     in number, -- сумма штрафа для списания с деп.счета на 3500
                                  p_rkoamount     in number, -- сумма комиссии за РКО
                                  p_vetamount     in number, -- сумма комиссии за (прием ветхих/ виплату коштів що надійшли безготівковим шляхом)
                                  p_fullpay       in number, -- 1=расторжение, 0=част снятие
                                  p_tax2ret       in number, -- сума податку для повернення (утриманого з нарахованих %% по основній  ставці)
                                  p_tax2pay       in number, -- сума податку для утримання  (з нарахованих %% до виплати по штрафній ставці)
                                  p_tax2ret_mil   in number, -- сума податку (Військовий збір) для повернення (утриманого з нарахованих %% по основній  ставці)
                                  p_tax2pay_mil   in number -- сума податку (Військовий збір) для утримання  (з нарахованих %% до виплати по штрафній ставці)
                                  ) is
    title          varchar2(60) := 'dpt_web.glpenalty.paydocs: ';
    l_mfo          banks.mfo%type := gl.amfo;
    l_userid       staff.id%type := gl.auid;
    l_bankdate     fdat.fdat%type := gl.bdate;
    l_branch       branch.branch%type := sys_context('bars_context',
                                                     'user_branch');
    l_accrecd      dpt_web.acc_rec;
    l_accrecp      dpt_web.acc_rec;
    l_accrece      dpt_web.acc_rec;
    l_accrece2     dpt_web.acc_rec;
    l_accreca      dpt_web.acc_rec;
    l_accrect      dpt_web.acc_rec;
    l_accrect2     dpt_web.acc_rec;
    l_accrect_mil  dpt_web.acc_rec;
    l_accrect2_mil dpt_web.acc_rec;
    l_int2payoffq  number;
    l_intamountq   number;
    l_dptamountq   number;
    l_tax2retq     number;
    l_tax2payq     number;
    l_tax2retq_mil number;
    l_tax2payq_mil number;
    l_refi         oper.ref%type;
    l_refp         oper.ref%type;
    l_refd         oper.ref%type;
    l_refa         oper.ref%type;
    l_refc         oper.ref%type;
    l_refv         oper.ref%type;
    l_reft         oper.ref%type;
    l_tt           oper.tt%type;
    l_vob          oper.vob%type;
    l_details      oper.nazn%type;
    l_errflg       boolean;
    l_errmsg       varchar2(3000);
    l_idupd        dpt_deposit_clos.idupd%type;
    l_tmp          number;
  begin
    bars_audit.trace('%s формирование пакета док-тов при снятии суммы %s по вкладу № %s...',
                     title,
                     to_char(p_amount),
                     to_char(p_dptid));

    -- реквизиты депозитного счета
    l_accrecd := dpt_web.search_acc_params(p_dptaccid);
    bars_audit.trace('%s деп.счет = %s/%s',
                     title,
                     l_accrecd.acc_num,
                     to_char(l_accrecd.acc_cur));

    -- реквизиты процентного счета
    l_accrecp := dpt_web.search_acc_params(p_intaccid);
    bars_audit.trace('%s проц.счет = %s/%s',
                     title,
                     l_accrecp.acc_num,
                     to_char(l_accrecp.acc_cur));

    -- реквизиты контрсчета (расходов)
    l_accrece := dpt_web.search_acc_params(p_expaccid);
    bars_audit.trace('%s контр.счет = %s/%s',
                     title,
                     l_accrece.acc_num,
                     to_char(l_accrece.acc_cur));

    -- реквизиты контрсчета (расходов) для возврата штрафа
    if p_expaccid2 = p_expaccid then
      l_accrece2 := l_accrece;
    else
      l_accrece2 := dpt_web.search_acc_params(p_expaccid2);
    end if;
    bars_audit.trace('%s контр.счет для возврата штрафа = %s/%s',
                     title,
                     l_accrece2.acc_num,
                     to_char(l_accrece2.acc_cur));

    -- (ПДФО)
    l_accrect := dpt_web.search_acc_params(p_taxaccid);
    bars_audit.trace('%s контр.рахунок для утримання податку = %s/%s',
                     title,
                     l_accrect.acc_num,
                     to_char(l_accrect.acc_cur));

    l_accrect2 := dpt_web.search_acc_params(p_taxaccid2);
    bars_audit.trace('%s контр.рахунок для повернення утриманого податку = %s/%s',
                     title,
                     l_accrect2.acc_num,
                     to_char(l_accrect2.acc_cur));

    --(Військовий збір)
    l_accrect_mil := dpt_web.search_acc_params(p_taxaccid_mil);
    bars_audit.trace('%s контр.рахунок для утримання податку (Військовий збір) = %s/%s',
                     title,
                     l_accrect_mil.acc_num,
                     to_char(l_accrect_mil.acc_cur));

    l_accrect2_mil := dpt_web.search_acc_params(p_taxaccid2_mil);
    bars_audit.trace('%s контр.рахунок для повернення утриманого податку (Військовий збір)= %s/%s',
                     title,
                     l_accrect2_mil.acc_num,
                     to_char(l_accrect2_mil.acc_cur));

    -- реквизиты счета амортизации процентов
    if p_amraccid is not null then
      l_accreca := dpt_web.search_acc_params(p_amraccid);
      bars_audit.trace('%s счет аморт. = %s/%s',
                       title,
                       l_accreca.acc_num,
                       to_char(l_accreca.acc_cur));
    end if;

    -- гривневый эквивалент сумм платежей
    if (l_accrecd.acc_cur = l_accrece.acc_cur) then
      l_vob          := 6;
      l_int2payoffq  := p_int2payoff;
      l_intamountq   := p_intamount;
      l_dptamountq   := p_dptamount;
      l_tax2retq     := p_tax2ret;
      l_tax2payq     := p_tax2pay;
      l_tax2retq_mil := p_tax2ret_mil;
      l_tax2payq_mil := p_tax2pay_mil;
    else
      l_vob          := 16;
      l_int2payoffq  := gl.p_icurval(l_accrecp.acc_cur,
                                     p_int2payoff,
                                     l_bankdate);
      l_intamountq   := gl.p_icurval(l_accrecp.acc_cur,
                                     p_intamount,
                                     l_bankdate);
      l_dptamountq   := gl.p_icurval(l_accrecd.acc_cur,
                                     p_dptamount,
                                     l_bankdate);
      l_tax2retq     := gl.p_icurval(l_accrecp.acc_cur,
                                     p_tax2ret,
                                     l_bankdate);
      l_tax2payq     := gl.p_icurval(l_accrecp.acc_cur,
                                     p_tax2pay,
                                     l_bankdate);
      l_tax2retq_mil := gl.p_icurval(l_accrecp.acc_cur,
                                     p_tax2ret_mil,
                                     l_bankdate);
      l_tax2payq_mil := gl.p_icurval(l_accrecp.acc_cur,
                                     p_tax2pay_mil,
                                     l_bankdate);
    end if;

    -- (I) начисление процентов на сумму снятия по штрафной ставке
    -- 1. не фиксируем дату последнего начисления
    -- 2. не формируем ведомость начисленных процентов
    -- 3. не заполняем acrn.acr_dati
    if p_int2payoff > 0 then
      dpt_web.paydoc(p_dptid    => p_dptid,
                     p_vdat     => l_bankdate,
                     p_brancha  => l_branch,
                     p_nlsa     => l_accrecp.acc_num,
                     p_mfoa     => l_mfo,
                     p_nama     => substr(l_accrecp.acc_name, 1, 38),
                     p_ida      => l_accrecp.cust_idcode,
                     p_kva      => l_accrecp.acc_cur,
                     p_sa       => p_int2payoff,
                     p_branchb  => l_branch,
                     p_nlsb     => l_accrece.acc_num,
                     p_mfob     => l_mfo,
                     p_namb     => substr(l_accrece.acc_name, 1, 38),
                     p_idb      => l_accrece.cust_idcode,
                     p_kvb      => l_accrece.acc_cur,
                     p_sb       => l_int2payoffq,
                     p_nazn     => p_intdetails,
                     p_nmk      => substr(l_accrecp.acc_name, 1, 38),
                     p_tt       => '%%1',
                     p_vob      => l_vob,
                     p_dk       => 0,
                     p_sk       => null,
                     p_userid   => l_userid,
                     p_type     => null,
                     p_ref      => l_refi,
                     p_err_flag => l_errflg,
                     p_err_msg  => l_errmsg);

      -- утримання податку з суми нарахованих %% по штрафній ставці за період бази оподаткування
      if (p_tax2pay > 0) then

        gl.payv(1,
                l_refi,
                l_bankdate,
                '%15',
                1,
                l_accrecp.acc_cur,
                l_accrecp.acc_num,
                p_tax2pay,
                l_accrect.acc_cur,
                l_accrect.acc_num,
                l_tax2payq);
      end if;

      if (p_tax2pay_mil > 0) then

        gl.payv(1,
                l_refi,
                l_bankdate,
                'MIL',
                1,
                l_accrecp.acc_cur,
                l_accrecp.acc_num,
                p_tax2pay_mil,
                l_accrect_mil.acc_cur,
                l_accrect_mil.acc_num,
                l_tax2payq_mil);
        bars_audit.trace('%s ref(2638 -> 3622 = %s) = %s',
                         title,
                         to_char(p_tax2pay_mil),
                         to_char(l_refi));
      end if;

      bars_audit.trace('%s ref(7041 -> 2638 = %s) = %s',
                       title,
                       to_char(p_int2payoff),
                       to_char(l_refi));
      bars_audit.trace('%s ref(2638 -> 3622 = %s) = %s',
                       title,
                       to_char(p_tax2pay),
                       to_char(l_refi));

      if l_errflg then
        bars_error.raise_nerror(g_modcode, 'PAYDOC_ERROR', l_errmsg);
      end if;
    end if;

    -- (II) взыскание штрафа со счета начисленных процентов
    if p_intamount > 0 then
      dpt_web.paydoc(p_dptid    => p_dptid,
                     p_vdat     => l_bankdate,
                     p_brancha  => l_branch,
                     p_nlsa     => l_accrecp.acc_num,
                     p_mfoa     => l_mfo,
                     p_nama     => substr(l_accrecp.acc_name, 1, 38),
                     p_ida      => l_accrecp.cust_idcode,
                     p_kva      => l_accrecp.acc_cur,
                     p_sa       => p_intamount,
                     p_branchb  => l_branch,
                     p_nlsb     => l_accrece2.acc_num,
                     p_mfob     => l_mfo,
                     p_namb     => substr(l_accrece2.acc_name, 1, 38),
                     p_idb      => l_accrece2.cust_idcode,
                     p_kvb      => l_accrece2.acc_cur,
                     p_sb       => l_intamountq,
                     p_nazn     => null,
                     p_nmk      => substr(l_accrecp.acc_name, 1, 38),
                     p_tt       => null,
                     p_vob      => null,
                     p_dk       => 1,
                     p_sk       => null,
                     p_userid   => l_userid,
                     p_type     => (case
                                     when p_fullpay = 1 then
                                      dptop_mainpenalty
                                     else
                                      dptop_mainwritedwn
                                   end),
                     p_ref      => l_refp,
                     p_err_flag => l_errflg,
                     p_err_msg  => l_errmsg);
      bars_audit.trace('%s ref(2638 -> 7041 = %s) = %s',
                       title,
                       to_char(p_intamount),
                       to_char(l_refp));
      if l_errflg then
        bars_error.raise_nerror(g_modcode, 'PAYDOC_ERROR', l_errmsg);
      end if;
    end if;

    -- (III.а) взыскание штрафа с депозитного счета на счет расходов банка
    if p_dptamount > 0 then
      if p_amraccid is null then
        l_tmp := case
                   when p_fullpay = 1 then
                    dptop_bindpenalty
                   else
                    dptop_bindwritedwn
                 end;
        l_tt      := null;
        l_details := null;
      else
        l_tmp     := dptop_avanspenalty;
        l_tt      := get_tt(p_type     => l_tmp,
                            p_interpay => 0,
                            p_cardpay  => 0,
                            p_currency => l_accrecd.acc_cur);
        l_details := substr(bars_msg.get_msg(g_modcode, 'GLPENALTY_DOCDTL_EXP') ||
                            (case
                               when p_fullpay = 1 then
                                bars_msg.get_msg(g_modcode, 'GLPENALTY_DOCDTL_FULL')
                               else
                                bars_msg.get_msg(g_modcode, 'GLPENALTY_DOCDTL_PART')
                             end) || get_nazn(l_tt, p_dptid, null, null),
                            1,
                            160);
      end if;

      dpt_web.paydoc(p_dptid    => p_dptid,
                     p_vdat     => l_bankdate,
                     p_brancha  => l_branch,
                     p_nlsa     => l_accrecd.acc_num,
                     p_mfoa     => l_mfo,
                     p_nama     => substr(l_accrecd.acc_name, 1, 38),
                     p_ida      => l_accrecd.cust_idcode,
                     p_kva      => l_accrecd.acc_cur,
                     p_sa       => p_dptamount,
                     p_branchb  => l_branch,
                     p_nlsb     => l_accrece2.acc_num,
                     p_mfob     => l_mfo,
                     p_namb     => substr(l_accrece2.acc_name, 1, 38),
                     p_idb      => l_accrece2.cust_idcode,
                     p_kvb      => l_accrece2.acc_cur,
                     p_sb       => l_dptamountq,
                     p_nazn     => l_details,
                     p_nmk      => substr(l_accrecd.acc_name, 1, 38),
                     p_tt       => l_tt,
                     p_vob      => null,
                     p_dk       => 1,
                     p_sk       => null,
                     p_userid   => l_userid,
                     p_type     => l_tmp,
                     p_ref      => l_refd,
                     p_err_flag => l_errflg,
                     p_err_msg  => l_errmsg);
      bars_audit.trace('%s ref(2630 -> 7041 = %s) = %s',
                       title,
                       to_char(p_dptamount),
                       to_char(l_refd));
      if l_errflg then
        bars_error.raise_nerror(g_modcode, 'PAYDOC_ERROR', l_errmsg);
      end if;
    end if;

    -- (III.b) взыскание штрафа с депозитного счета на счет амортизации процентов
    if p_amramount > 0 then
      if p_dptamount > 0 then
        l_tmp     := dptop_avanspenalty;
        l_tt      := get_tt(p_type     => l_tmp,
                            p_interpay => 0,
                            p_cardpay  => 0,
                            p_currency => l_accrecd.acc_cur);
        l_details := substr(bars_msg.get_msg(g_modcode, 'GLPENALTY_DOCDTL_AMR') ||
                            (case
                               when p_fullpay = 1 then
                                bars_msg.get_msg(g_modcode, 'GLPENALTY_DOCDTL_FULL')
                               else
                                bars_msg.get_msg(g_modcode, 'GLPENALTY_DOCDTL_PART')
                             end) || get_nazn(l_tt, p_dptid, null, null),
                            1,
                            160);
      end if;

      dpt_web.paydoc(p_dptid    => p_dptid,
                     p_vdat     => l_bankdate,
                     p_brancha  => l_branch,
                     p_nlsa     => l_accrecd.acc_num,
                     p_mfoa     => l_mfo,
                     p_nama     => substr(l_accrecd.acc_name, 1, 38),
                     p_ida      => l_accrecd.cust_idcode,
                     p_kva      => l_accrecd.acc_cur,
                     p_sa       => p_amramount,
                     p_branchb  => l_branch,
                     p_nlsb     => l_accreca.acc_num,
                     p_mfob     => l_mfo,
                     p_namb     => substr(l_accreca.acc_name, 1, 38),
                     p_idb      => l_accreca.cust_idcode,
                     p_kvb      => l_accreca.acc_cur,
                     p_sb       => p_amramount,
                     p_nazn     => l_details,
                     p_nmk      => substr(l_accrecd.acc_name, 1, 38),
                     p_tt       => l_tt,
                     p_vob      => null,
                     p_dk       => 1,
                     p_sk       => null,
                     p_userid   => l_userid,
                     p_type     => l_tmp,
                     p_ref      => l_refa,
                     p_err_flag => l_errflg,
                     p_err_msg  => l_errmsg);
      bars_audit.trace('%s ref(2630 -> 3500 = %s) = %s',
                       title,
                       to_char(p_amramount),
                       to_char(l_refa));
      if l_errflg then
        bars_error.raise_nerror(g_modcode, 'PAYDOC_ERROR', l_errmsg);
      end if;
    end if;

    -- (IV) оплата комиссии за частичное снятие или досрочное расторжение
    if p_rkoamount > 0 then
      l_tmp := p_rkoamount;
      dpt_web.paydoc_nocash_commission(p_tt          => 'K08',
                                       p_dptid       => p_dptid,
                                       p_main_amount => p_amount,
                                       p_main_curcod => l_accrecd.acc_cur,
                                       p_main_docref => null,
                                       p_main_accrec => l_accrecd,
                                       p_vdate       => l_bankdate,
                                       p_userid      => l_userid,
                                       p_ref         => l_refc,
                                       p_amount      => l_tmp);
      bars_audit.trace('%s ref(РКО -> %s) = %s',
                       title,
                       to_char(p_rkoamount),
                       to_char(l_refc));
    end if;

    -- (V) оплата комиссии за прием на вклад ветхих купюр при частичном снятии или досрочном расторжении
    if p_vetamount > 0 then
      l_tmp := p_vetamount;
      dpt_web.paydoc_nocash_commission(p_tt          => 'K09',
                                       p_dptid       => p_dptid,
                                       p_main_amount => p_amount,
                                       p_main_curcod => l_accrecd.acc_cur,
                                       p_main_docref => null,
                                       p_main_accrec => l_accrecd,
                                       p_vdate       => l_bankdate,
                                       p_userid      => l_userid,
                                       p_ref         => l_refv,
                                       p_amount      => l_tmp);
      bars_audit.trace('%s ref(ветх.купюр -> %s) = %s',
                       title,
                       to_char(p_vetamount),
                       to_char(l_refv));
    end if;

    if (p_tax2ret > 0) then
      -- повернення утриманого податку з нарахованих %%

      l_tt      := '%15';
      l_details := 'Повернення податку з процентних доходів ФО при достроковому розірванні договору №' ||
                   to_char(p_dptid);
      l_vob := (case
                 when l_accrecp.acc_cur = l_accrect2.acc_cur then
                  6
                 else
                  16
               end);

      begin
        -- платим через а не dpt_web.paydoc з paytt через прописані рахунки для орлати в картці операці %15

        gl.ref(l_reft);
        gl.in_doc3(ref_   => l_reft,
                   mfoa_  => l_mfo,
                   tt_    => l_tt,
                   nlsa_  => l_accrecp.acc_num,
                   vob_   => l_vob,
                   kv_    => l_accrecp.acc_cur,
                   dk_    => 0,
                   nam_a_ => substr(l_accrecp.acc_name, 1, 38),
                   nd_    => substr(to_char(l_reft), 1, 10),
                   id_a_  => l_accrecp.cust_idcode,
                   pdat_  => sysdate,
                   s_     => p_tax2ret,
                   vdat_  => l_bankdate,
                   mfob_  => l_mfo,
                   data_  => l_bankdate,
                   nlsb_  => l_accrect2.acc_num,
                   datp_  => l_bankdate,
                   kv2_   => l_accrect2.acc_cur,
                   sk_    => null,
                   nam_b_ => substr(l_accrect2.acc_name, 1, 38),
                   d_rec_ => null,
                   id_b_  => l_accrect2.cust_idcode,
                   id_o_  => null,
                   s2_    => l_tax2retq,
                   sign_  => null,
                   nazn_  => l_details,
                   sos_   => null,
                   uid_   => null,
                   prty_  => 0);

        gl.payv(null,
                l_reft,
                l_bankdate,
                l_tt,
                1,
                l_accrect2.acc_cur,
                l_accrect2.acc_num,
                l_tax2retq,
                l_accrecp.acc_cur,
                l_accrecp.acc_num,
                p_tax2ret);

        -- запись документа в хранилище док-тов по депозитному договору ФО
        fill_dpt_payments(p_dptid, l_reft);

        bars_audit.trace('%s ref(3522 -> 2638 = %s) = %s',
                         title,
                         to_char(p_tax2ret),
                         to_char(l_reft));

      exception
        when others then
          bars_error.raise_nerror('DPT', 'PAYDOC_ERROR', sqlerrm);
      end;

      /*
      dpt_web.paydoc( p_dptid      => p_dptid,
                      p_vdat       => l_bankdate,
                      p_brancha    => l_branch,
                      p_nlsa       => l_accrecT2.acc_num,
                      p_mfoa       => l_mfo,
                      p_nama       => substr(l_accrecT2.acc_name, 1, 38),
                      p_ida        => l_accrecT2.cust_idcode,
                      p_kva        => l_accrecT2.acc_cur,
                      p_sa         => l_tax2retQ,
                      p_branchb    => l_branch,
                      p_nlsb       => l_accrecP.acc_num,
                      p_mfob       => l_mfo,
                      p_namb       => substr(l_accrecP.acc_name, 1, 38),
                      p_idb        => l_accrecP.cust_idcode,
                      p_kvb        => l_accrecP.acc_cur,
                      p_sb         => p_tax2ret,
                      p_nazn       => l_details,
                      p_nmk        => substr(l_accrecP.acc_name, 1, 38),
                      p_tt         => l_tt,
                      p_vob        => l_vob,
                      p_dk         => 0,
                      p_sk         => null,
                      p_userid     => l_userid,
                      p_type       => null,
                      p_ref        => l_refT,
                      p_err_flag   => l_errflg,
                      p_err_msg    => l_errmsg);

        bars_audit.trace( '%s ref(3522 -> 2638 = %s) = %s', title, to_char(p_tax2ret), to_char(l_refT) );

      if l_errflg then
        bars_error.raise_nerror(g_modcode, 'PAYDOC_ERROR', l_errmsg);
      end if;
      */
    end if;

    if (p_tax2ret_mil > 0) then
      -- повернення утриманого податку (Військовий збір) з нарахованих %%

      l_tt      := 'MIL';
      l_details := 'Повернення податку (Військовий збір) з процентних доходів ФО при достроковому розірванні договору №' ||
                   to_char(p_dptid);
      l_vob := (case
                 when l_accrecp.acc_cur = l_accrect2_mil.acc_cur then
                  6
                 else
                  16
               end);

      begin
        -- платим через а не dpt_web.paydoc з paytt через прописані рахунки для орлати в картці операці MIL

        gl.ref(l_reft);
        gl.in_doc3(ref_   => l_reft,
                   mfoa_  => l_mfo,
                   tt_    => l_tt,
                   nlsa_  => l_accrecp.acc_num,
                   vob_   => l_vob,
                   kv_    => l_accrecp.acc_cur,
                   dk_    => 0,
                   nam_a_ => substr(l_accrecp.acc_name, 1, 38),
                   nd_    => substr(to_char(l_reft), 1, 10),
                   id_a_  => l_accrecp.cust_idcode,
                   pdat_  => sysdate,
                   s_     => p_tax2ret_mil,
                   vdat_  => l_bankdate,
                   mfob_  => l_mfo,
                   data_  => l_bankdate,
                   nlsb_  => l_accrect2_mil.acc_num,
                   datp_  => l_bankdate,
                   kv2_   => l_accrect2_mil.acc_cur,
                   sk_    => null,
                   nam_b_ => substr(l_accrect2_mil.acc_name, 1, 38),
                   d_rec_ => null,
                   id_b_  => l_accrect2_mil.cust_idcode,
                   id_o_  => null,
                   s2_    => l_tax2retq_mil,
                   sign_  => null,
                   nazn_  => l_details,
                   sos_   => null,
                   uid_   => null,
                   prty_  => 0);

        gl.payv(null,
                l_reft,
                l_bankdate,
                l_tt,
                1,
                l_accrect2_mil.acc_cur,
                l_accrect2_mil.acc_num,
                l_tax2retq_mil,
                l_accrecp.acc_cur,
                l_accrecp.acc_num,
                p_tax2ret_mil);

        -- запись документа в хранилище док-тов по депозитному договору ФО
        fill_dpt_payments(p_dptid, l_reft);

        bars_audit.trace('%s ref(3522 -> 2638 = %s) = %s',
                         title,
                         to_char(p_tax2ret_mil),
                         to_char(l_reft));

      exception
        when others then
          bars_error.raise_nerror('DPT', 'PAYDOC_ERROR', sqlerrm);
      end;

    end if;

    if (p_fullpay = 1)
    -- нефіксувється факт штрафування якщо воно відбувалося в день заключення договору (всі суми = 0)
    -- and coalesce (l_refP, l_refD, l_refA, l_refC, l_refV) is not null)
     then
      -- фиксация факта штрафования в архиве депозитов
      select bars_sqnc.get_nextval('S_DPT_DEPOSIT_CLOS')
        into l_idupd
        from dual;
      insert into dpt_deposit_clos
        (idupd,
         deposit_id,
         nd,
         branch,
         vidd,
         acc,
         kv,
         rnk,
         freq,
         datz,
         dat_begin,
         dat_end,
         mfo_p,
         nls_p,
         name_p,
         okpo_p,
         dpt_d,
         acc_d,
         mfo_d,
         nls_d,
         nms_d,
         okpo_d,
         limit,
         deposit_cod,
         comments,
         action_id,
         actiion_author,
         "WHEN",
         bdate,
         ref_dps,
         dat_end_alt,
         stop_id,
         cnt_dubl,
         cnt_ext_int,
         dat_ext_int,
         userid,
         archdoc_id)
        select l_idupd,
               deposit_id,
               nd,
               branch,
               vidd,
               acc,
               kv,
               rnk,
               freq,
               datz,
               dat_begin,
               dat_end,
               mfo_p,
               nls_p,
               name_p,
               okpo_p,
               dpt_d,
               acc_d,
               mfo_d,
               nls_d,
               nms_d,
               okpo_d,
               limit,
               deposit_cod,
               comments,
               5,
               l_userid,
               sysdate,
               l_bankdate,
               coalesce(l_refp, l_refd, l_refa, l_refc, l_refv),
               dat_end_alt,
               stop_id,
               cnt_dubl,
               cnt_ext_int,
               dat_ext_int,
               l_userid,
               archdoc_id
          from dpt_deposit
         where deposit_id = p_dptid;
    end if;

    -- Якщо було нараховано % по штрафній ставці то підв"язуєм реф. даної опер. під
    --  операцію стягення штрафу з рахунку нар.%(або рах.депозиту)

    if l_refi is not null then
      update oper set refl = l_refi where ref = nvl(l_refp, l_refd);
    end if;

    -- Для Ощадбанку якщо вид вкладу не ... то необхідно встановити дату погашення
    --  по рахунку = поточна системна дата та % ставку = 0

    bars_audit.trace('%s формирование пакета док-тов при снятии суммы %s по вкладу № %s выполнено',
                     title,
                     to_char(p_amount),
                     to_char(p_dptid));

  end intl_make_penaltydocs;
  --
  -- внутренняя процедура расчета невыплач.процентов за прошлые сроки переоформленного вклада
  --
  procedure intl_get_prevint(p_depaccrow in accounts%rowtype, -- параметры деп.счета
                             p_intsaldo  in accounts.ostb%type, -- план.остаток на проц.счете
                             p_curcode   in tabval.lcv%type, -- симв.код валюты
                             p_intdat1   in date, -- дата начала действия текущего вклада
                             p_intdat2   in date, -- дата посл.начисления процентов
                             p_bankdat   in date, -- текущая банк.дата
                             p_prevint   out number) -- сумма процентов прошлых периодов
   is
    title    constant varchar2(60) := 'dpt_web.glpenalty.getprevint: ';
    genintid constant int_accn.id%type := 1; -- код основной проц.карточки
    altintid constant int_accn.id%type := 5; -- код временной проц.карточки
    l_intdat2 date;
    l_currint number;
    l_prevint number(38);
  begin

    bars_audit.trace('%s старт, счет %s/%s, остаток на проц.счете %s, период начисления %s',
                     title,
                     p_depaccrow.nls,
                     to_char(p_depaccrow.kv),
                     to_char(p_intsaldo),
                     to_char(p_intdat1, 'dd.mm.yyyy'),
                     to_char(p_intdat2, 'dd.mm.yyyy'));

    if p_intsaldo = 0 then

      l_prevint := 0;

    else

      -- гран.дата начисления (как минимум, вчерашний день)
      l_intdat2 := greatest(p_bankdat - 1, nvl(p_intdat2, p_bankdat - 1));

      -- общая сумма начисленных процентов для текущего переоформления
      intl_clear_altintcard(p_dptaccid => p_depaccrow.acc, -- внутр.номер деп.счета
                            p_altintid => altintid); -- код альтерн.карточки
      intl_fill_altintcard(p_dptaccid  => p_depaccrow.acc, -- внутр.номер деп.счета
                           p_genintid  => genintid, -- код основной карточки
                           p_altintid  => altintid, -- код альтерн.карточки
                           p_intdat1   => p_intdat1 - 1, -- дата предыдущего начисления
                           p_intdat2   => l_intdat2, -- граничная дата начисления
                           p_penyadate => null, -- дата установки альт.ставки
                           p_penyarate => null); -- значение альтернат.ставки
      intl_calc_interest(p_mode      => 'RO', -- только расчет процентов
                         p_date      => p_bankdat, -- текущая банк.дата
                         p_accrec    => p_depaccrow, -- параметры деп.счета
                         p_intid     => altintid, -- код альтерн.карточки
                         p_stopdate  => l_intdat2, -- граничная дата начисления
                         p_curcode   => p_curcode, -- симв.код валюты
                         p_details   => null, -- назначение платежа
                         p_dptamount => null, -- сумма депозита
                         p_intamount => l_currint); -- сума начисленных процентов
      intl_clear_altintcard(p_dptaccid => p_depaccrow.acc, -- внутр.номер деп.счета
                            p_altintid => altintid); -- код альтерн.карточки

      l_currint := nvl(round(l_currint), 0);
      bars_audit.trace('%s сумма процентов за период с %s по %s = %s',
                       title,
                       to_char(p_intdat1, 'dd.mm.yyyy'),
                       to_char(l_intdat2, 'dd.mm.yyyy'),
                       to_char(l_currint));

      l_prevint := greatest(0, p_intsaldo - l_currint);

    end if;

    p_prevint := l_prevint;

    bars_audit.trace('%s выход, сумма процентов прошлых периодов = %s',
                     title,
                     to_char(p_prevint));

  end intl_get_prevint;

  --
  -- добавление строки в описание процедуры штрафования
  --
  procedure str2txt(p_details in out g_penaltymsg%type, -- полный текст подробного описания
                    p_message in g_penaltymsg%type) -- строка подробного описания
   is
  begin
    p_details := substr(p_details || chr(13) || chr(10) || p_message,
                        1,
                        g_penaltymsgdim);
  end str2txt;
  --
  -- форматирование числовых данных при описании процедуры штрафования
  --
  function num2str(p_amount in number, p_currency in varchar2)
    return varchar2 is
  begin
    return to_char(p_amount / 100, '999999990D99') || ' ' || case when p_currency = 'UAH' then 'грн' else p_currency end;
  end num2str;

  ---
  -- формування суми в текстовому вигляді для відправки SMS
  ---
  function amount2str(p_amount in number, p_currency in number)
    return varchar2 is
  begin
    return to_char(p_amount / 100, 'FM999G999G990D00') || ' ' || case p_currency when 643 then 'RUB' when 840 then 'USD' when 959 then 'XAU' when 961 then 'XAG' when 978 then 'EUR' when 980 then 'UAH' else to_char(p_currency) end;
  end amount2str;

  --
  -- розрахунок відсоткової ставки та штрафного періоду
  -- при достроковому розірванні депозиту
  --
  procedure get_penalty_options(p_dpt_id       in number,
                                p_dat          in date,
                                p_penalty_rate out number, -- штрафна ставка
                                p_penalty_date out date -- дата початку штрафного періоду
                                ) is
    title         varchar2(60) := 'dpt_web.PenaltyOptions: ';
    l_accid       dpt_deposit.acc%type;
    l_kv          dpt_deposit.kv%type;
    l_datz        dpt_deposit.datz%type;
    l_dat_begin   dpt_deposit.dat_begin%type;
    l_dat_end     dpt_deposit.dat_end%type;
    l_cntdubl     dpt_deposit.cnt_dubl%type;
    l_stopid      dpt_deposit.stop_id%type;
    l_freq        dpt_deposit.freq%type;
    l_stoprow     dpt_stop%rowtype;
    l_months      number;
    l_term        number;
    l_dptrate     number;
    l_penaltyrate number;
    l_penaltydate date;
    l_sh_rate     dpt_stop_a.k_proc%type;
    l_sh_type     dpt_stop_a.sh_proc%type;
    l_sh_term     dpt_stop_a.k_term%type;
    l_termtype    dpt_stop_a.sh_term%type;
    --WITHOUT_PENALTY exception;
  begin

    bars_audit.trace('%s дата розірвання договору № %s - %s',
                     title,
                     to_char(p_dpt_id),
                     to_date(p_dat, 'dd/mm/yyyy'));

    -- параметры вклада
    begin
      select acc,
             kv,
             datz,
             dat_begin,
             dat_end,
             freq,
             stop_id,
             nvl(cnt_dubl, 0)
        into l_accid,
             l_kv,
             l_datz,
             l_dat_begin,
             l_dat_end,
             l_freq,
             l_stopid,
             l_cntdubl
        from dpt_deposit
       where deposit_id = p_dpt_id;
    exception
      when no_data_found then
        bars_error.raise_nerror(g_modcode,
                                'DPT_NOT_FOUND',
                                to_char(p_dpt_id));
    end;
    bars_audit.trace('%s штраф № %s, даты %s - %s',
                     title,
                     to_char(l_stopid),
                     to_char(l_dat_begin, 'dd.mm.yy'),
                     to_char(l_dat_end, 'dd.mm.yy'));

    if not (l_dat_begin <= p_dat and l_dat_end > p_dat and l_stopid != 0) then
      bars_audit.trace('%s штраф не предусмотрен',
                       title);
      l_penaltyrate := null;
    else
      -- параметры штрафа
      begin
        select * into l_stoprow from dpt_stop where id = l_stopid;
      exception
        when no_data_found then
          bars_error.raise_nerror(g_modcode,
                                  'FINEPARAMS_NOT_FOUND',
                                  to_char(l_stopid));
      end;

      bars_audit.trace('%s вичитали карточку штрафа %s - %s',
                       title,
                       to_char(l_stoprow.id),
                       l_stoprow.name);

      l_months := months_between(p_dat, l_dat_begin);

      if (l_stoprow.sh_proc = 1 and trunc(l_months) < 1) then
        bars_audit.trace('%s факт.срок вклад < 1 мес -> полный штраф',
                         title);
        l_penaltyrate := 0;
      else
        begin
          l_term := case
                      when l_stoprow.fl = 0 then
                       trunc(((p_dat - l_dat_begin + 1) /
                             (l_dat_end - l_dat_begin + 1)) * 100)
                      when l_stoprow.fl = 1 then
                       round(l_months, 2)
                      else
                       p_dat - l_dat_begin + sign(l_cntdubl) -- для пролонгоапних дата початку враховується
                    end;
          bars_audit.trace('%s относит.срок вклада - %s',
                           title,
                           to_char(l_term) || ' ' || case when
                           l_stoprow.fl = 0 then '%%' when l_stoprow.fl = 1 then
                           'міс.' else 'днів' end);

          -- расчет типа и значения штрафа для данного периода
          begin
            select s.sh_proc, s.k_proc, s.k_term, s.sh_term
              into l_sh_type, l_sh_rate, l_sh_term, l_termtype
              from dpt_stop_a s
             where s.id = l_stopid
               and s.k_srok =
                   (select max(t.k_srok)
                      from dpt_stop_a t
                     where t.id = s.id
                       and t.k_srok <= l_term
                       and t.k_srok <= (select min(k_srok)
                                          from dpt_stop_a
                                         where k_srok > l_term
                                           and id = s.id));
          exception
            when no_data_found then
              bars_audit.trace('%s вышли за диапазон штрафования',
                               title);
              raise;
          end;

          bars_audit.trace('%s тип - %s, значение %s',
                           title,
                           case when l_sh_type = 1 then 'Жорсткий штраф' -- по історії змін ставки
                           when l_sh_type = 2 then 'М`який штраф' -- по останній діючій ставці
                           when l_sh_type = 3 then 'фикс.процент штрафа' when
                           l_sh_type = 5 then 'штраф по баз.ставке' else
                           'пустой штраф' end,
                           to_char(l_sh_rate));

          -- Мягкий штраф / Жесткий штраф
          if l_sh_type in (1, 2) then
            if l_sh_rate = 0 then
              bars_audit.trace('%s штраф не предусмотрен',
                               title);
              l_penaltyrate := null;
            else
              l_dptrate := acrn.fproc(l_accid, p_dat);
              if l_dptrate is null then
                bars_error.raise_nerror(g_modcode, 'DPTRATE_CALC_ERROR');
              else
                l_penaltyrate := (100 - l_sh_rate) * l_dptrate / 100;
              end if;
            end if;

            -- Фиксированный процент штрафа
          elsif l_sh_type = 3 then
            l_penaltyrate := l_sh_rate;

            -- Штраф по указанной базовой %-ой ставке
          elsif l_sh_type = 5 then
            begin
              l_penaltyrate := getbrat(p_dat,
                                       l_sh_rate,
                                       l_kv,
                                       fost(l_accid, p_dat));
            exception
              when others then
                bars_error.raise_nerror(g_modcode,
                                        'DPTRATE_CALC_ERROR',
                                        to_char(l_sh_rate));
            end;
          else
            bars_audit.trace('%s невозможно вычислить значение штрафной ставки',
                             title);
            l_penaltyrate := null;
          end if; -- l_sh_type

        exception
          when others then
            l_penaltyrate := null;
        end;
      end if;
    end if;

    bars_audit.trace('%s штрафна ставка = %s',
                     title,
                     nvl(to_char(l_penaltyrate), 'null'));
    p_penalty_rate := l_penaltyrate;

    if l_penaltyrate is not null then
      -- Розрахунок штрафного періоду
      case
      -- Розрахуноквий період    (Штраф розраховується за останній розрахунковий період)
        when l_termtype = 1 then
          begin
            bars_audit.trace('%s расчетный период ',
                             title,
                             to_char(l_sh_term));
            l_penaltydate := case
                               when (l_freq = 3) then
                                l_dat_begin + 7 * trunc((p_dat - l_dat_begin) / 7, 0)
                               when (l_freq = 5) then
                                add_months(l_dat_begin,
                                           1 *
                                           trunc(months_between(p_dat, l_dat_begin), 0))
                               when (l_freq = 7) then
                                add_months(l_dat_begin,
                                           3 * trunc(months_between(p_dat, l_dat_begin) / 3,
                                                     0))
                               when (l_freq = 180) then
                                add_months(l_dat_begin,
                                           6 * trunc(months_between(p_dat, l_dat_begin) / 6,
                                                     0))
                               when (l_freq = 360) then
                                add_months(l_dat_begin,
                                           12 * trunc(months_between(p_dat, l_dat_begin) / 12,
                                                      0))
                               when (l_freq = 400) then
                                l_dat_end
                               else
                                l_dat_begin
                             end;
          end;

      -- Строк штрафу    (Штраф стягується виходячи з параметру "строк штрафа")
        when l_termtype = 2 then
          begin
            bars_audit.trace('%s штрафза вказаний термін = %s',
                             title,
                             to_char(l_sh_term));
            if l_stoprow.fl = 1 then
              -- срок задан в месяцах
              l_penaltydate := add_months(p_dat, -nvl(l_sh_term, 0));

            elsif l_stoprow.fl = 2 then
              -- срок задан в днях
              l_penaltydate := p_dat - nvl(l_sh_term + 1, 0);
            else
              -- некорректно описан штраф
              bars_error.raise_nerror(g_modcode, 'INVALID_FINE');
            end if;
          end;

      -- Неповний рік    (Виплата відсотків відбувається за повний рік)
        when l_termtype = 3 then
          begin
            bars_audit.trace('%s штраф за неповний рік ',
                             title,
                             to_char(l_sh_term));
            l_penaltydate := add_months(l_dat_begin,
                                        12 * trunc(months_between(p_dat,
                                                                  l_dat_begin) / 12,
                                                   0) /* к-ть повних років */);
          end;

      -- Неповний квартал    (Виплата відсотків відбувається за повний квартал)
        when l_termtype = 4 then
          begin
            bars_audit.trace('%s штраф за неповний квартал (%)',
                             title,
                             to_char(l_sh_term));
            l_penaltydate := add_months(l_dat_begin,
                                        3 * trunc(months_between(p_dat,
                                                                 l_dat_begin) / 3,
                                                  0) /* к-ть повних кварталів */);
          end;

      -- Неповні півроку    (Виплата відсотків відбувається за повні півроку)
        when l_termtype = 5 then
          begin
            bars_audit.trace('%s штраф за неповні півроку (%)',
                             title,
                             to_char(l_sh_term));
            l_penaltydate := add_months(l_dat_begin,
                                        6 * trunc(months_between(p_dat,
                                                                 l_dat_begin) / 6,
                                                  0) /* к-ть повних піврічч */);
          end;

      -- Фактичний період (Штраф розраховується за час фактичного строку вкладу)
        else
          -- l_termtype = 0
          begin
            bars_audit.trace('%s штраф за фактичний період %s',
                             title,
                             to_char(l_sh_term));
            -- для прологованих депозитів
            if ((l_dat_begin > l_datz) and (l_cntdubl > 0)) then
              l_penaltydate := l_dat_begin - 1;
            else
              l_penaltydate := null;
            end if;
          end;
      end case;
    else
      l_penaltyrate := null;
    end if;

    bars_audit.trace('%s выплатим по %s',
                     title,
                     to_char(l_penaltydate, 'dd/mm/yyyy'));
    p_penalty_date := l_penaltydate;

  end get_penalty_options;

  --
  -- процедура расчета и взыскания суммы штрафа при частичном/полном снятии суммы вклада
  --

  procedure global_penalty(p_dptid       in dpt_deposit.deposit_id%type, -- идентификатор договора
                           p_date        in date, -- дата снятия (текущая)
                           p_fullpay     in number, -- 1-расторжение, 0-част.снятие
                           p_amount      in number, -- сумма част.снятия (null для расторжения)
                           p_mode        in char, -- режим RO - расчет, RW - взыскание
                           p_penalty     out number, -- сумма штрафа
                           p_commiss     out number, -- сумма комиссии за РКО
                           p_commiss2    out number, -- сумма комиссии за прием ветхих купюр
                           p_dptrest     out number, -- сумма депозита к выплате
                           p_intrest     out number, -- сумма процентов к выплате
                           p_int2pay_ing out number) -- shtraf
   is
    l_msg         g_penaltymsg%type;
    l_int2pay_tax number;
  begin
    global_penalty_ex(p_dptid,
                      'DPT',
                      p_date,
                      p_fullpay,
                      p_amount,
                      p_mode,
                      p_penalty,
                      p_commiss,
                      p_commiss2,
                      p_dptrest,
                      p_intrest,
                      l_msg,
                      p_int2pay_ing,
                      l_int2pay_tax);
  end global_penalty;

  --
  -- процедура расчета и взыскания суммы штрафа при частичном/полном снятии суммы вклада
  --
  procedure global_penalty_ex(p_dptid       in dpt_deposit.deposit_id%type, -- идентификатор договора
                              p_modcode     in bars_supp_modules.mod_code%type, -- код депозитного модуля
                              p_date        in date, -- дата снятия (текущая)
                              p_fullpay     in number, -- 1-расторжение, 0-част.снятие
                              p_amount      in number, -- сумма част.снятия (null для расторжения)
                              p_mode        in char, -- режим RO - расчет, RW - взыскание
                              p_penalty     out number, -- сумма штрафа
                              p_commiss     out number, -- сумма комиссии за РКО
                              p_commiss2    out number, -- сумма комиссии за прием ветхих купюр
                              p_dptrest     out number, -- сумма депозита к выплате
                              p_intrest     out number, -- сумма процентов к выплате
                              p_details     out varchar2, -- описание расчета штрафа
                              p_int2pay_ing out number,
                              p_int2pay_tax out number) -- shtraf
   is
    title           varchar2(60) := 'dpt_web.glpenalty: ';
    l_genintid      int_accn.id%type := 1; -- код %-ной карточки депозитного счета
    l_altintid      int_accn.id%type := 5; -- код %-ной карточки для расчета штрафа
    l_amrintid      int_accn.id%type := 0; -- код %-ной карточки счета амортизации
    l_dealnum       varchar2(100);
    l_dealdat       dpt_deposit.datz%type;
    l_begdate       dpt_deposit.dat_begin%type;
    l_enddate       dpt_deposit.dat_end%type;
    l_stopid        dpt_deposit.stop_id%type;
    l_rnk           dpt_deposit.rnk%type;
    l_vidd          dpt_vidd.vidd%type;
    l_brwd          dpt_vidd.br_wd%type;
    l_minsum        dpt_vidd.min_summ%type;
    l_avans         number(1);
    l_dptaccid      accounts.acc%type;
    l_intaccid      accounts.acc%type;
    l_expaccid      accounts.acc%type;
    l_expaccid2     accounts.acc%type;
    l_taxaccid      accounts.acc%type;
    l_taxaccid2     accounts.acc%type;
    l_taxaccid_mil  accounts.acc%type;
    l_taxaccid2_mil accounts.acc%type;
    l_amraccid      accounts.acc%type;
    l_dptaccrow     accounts%rowtype;
    l_intaccrow     accounts%rowtype;
    l_amraccrow     accounts%rowtype;
    l_acrdat        int_accn.acr_dat%type;
    l_intio         int_accn.io%type;
    l_curcode       tabval.lcv%type;
    l_details       oper.nazn%type;
    l_dptamount     number(38);
    l_intamount     number(38);
    l_amramount     number(38);
    l_penyarate     number;
    l_accturn       t_turndata;
    l_accturncnt    number;
    l_int2pay       number;
    l_int2ret       number;
    l_amr2ret       number;
    l_prevrest      number;
    l_tmp           number;
    l_expbal        number;
    l_amrbal        number;
    l_formula       tts.s%type;
    l_nopenya       boolean := false;
    l_penyaa        number(38);
    l_penyad        number(38);
    l_penyap        number(38);
    l_penyac        number(38);
    l_penyav        number(38);
    l_date          date; -- дата снятия (текущая)
    l_penyadate     date; -- дата з якої починається штрафний період вкладу
    l_errmsg        varchar2(3000);
    l_log_level     positive;
    l_tmp_intrest   number;

    l_tax2ret     number := 0;
    l_tax2pay     number := 0;
    l_tax2ret_mil number := 0;
    l_tax2pay_mil number := 0;

    l_taxlist        t_taxdata;
    l_taxlist_mil    t_taxdata;
    l_less_stp_dat   number := 0; -- Pavlenko 19/07/2014 BRSMAIN-2752
    l_valid_mobphone number := 0;
    l_inherited      number := 0;
  begin

    bars_audit.trace('%s старт с параметрами {%s, %s, %s, %s, %s}',
                     title,
                     to_char(p_dptid),
                     to_char(p_date, 'dd.mm.yyyy'),
                     to_char(p_fullpay),
                     to_char(p_amount),
                     p_mode);

    -- Код депозитного модуля
    if p_modcode is null or p_modcode not in ('DPT', 'DPU') then
      bars_error.raise_nerror(g_modcode,
                              'INVALID_PENALTY_MODCODE',
                              nvl(p_modcode, 'null'));
    end if;

    -- режим выполнения процедуры
    if p_mode is null or p_mode not in ('RO', 'RW') then
      bars_error.raise_nerror(g_modcode, 'INVALID_PENALTY_MODE', p_mode);
    end if;

    -- тип выплаты
    if p_fullpay is null or p_fullpay not in (0, 1) then
      bars_error.raise_nerror(g_modcode,
                              'INVALID_PENALTY_TYPE',
                              to_char(p_fullpay));
    end if;

    -- Встановлюємо присусову трасіровку для штрафування
    l_log_level := bars_audit.get_log_level();

    if (l_log_level < bars_audit.log_level_trace) then
      bars_audit.set_log_level(bars_audit.log_level_trace);
      bars_audit.info(title || 'змінено рівень деталізації повідомлень з ' ||
                      to_char(l_log_level) || ' на ' ||
                      to_char(bars_audit.log_level_trace));
    end if;

    l_date := least(trunc(sysdate), p_date);
    if l_date != p_date then
      bars_audit.trace('%s дата штрафування не банківський день %s',
                       title,
                       to_char(p_date, 'dd.mm.yyyy'));
    end if;

    -- реквизиты договора
    if p_modcode = 'DPT' then
      begin
        select d.nd,
               d.datz,
               d.dat_begin,
               d.dat_end,
               d.stop_id,
               d.rnk,
               v.vidd,
               nvl(v.br_wd, 0),
               nvl(v.min_summ * 100, 0),
               decode(v.amr_metr, 4, 1, 0),
               d.acc,
               i.acra,
               i.acrb,
               i.acr_dat,
               i.io,
               t.lcv,
               substr(dpt_web.get_nazn(nvl(i.tt, '%%1'),
                                       d.deposit_id,
                                       d.nd,
                                       d.datz),
                      1,
                      160)
          into l_dealnum,
               l_dealdat,
               l_begdate,
               l_enddate,
               l_stopid,
               l_rnk,
               l_vidd,
               l_brwd,
               l_minsum,
               l_avans,
               l_dptaccid,
               l_intaccid,
               l_expaccid,
               l_acrdat,
               l_intio,
               l_curcode,
               l_details
          from dpt_deposit d, dpt_vidd v, int_accn i, tabval t
         where d.vidd = v.vidd
           and d.acc = i.acc
           and i.id = l_genintid
           and d.kv = t.kv
           and d.deposit_id = p_dptid;
      exception
        when no_data_found then
          bars_error.raise_nerror(g_modcode,
                                  g_dptnotfound,
                                  to_char(p_dptid));
      end;
    else
      -- DPU
      begin
        select d.nd,
               d.datz,
               d.dat_begin,
               d.dat_end,
               d.id_stop,
               v.vidd,
               0,
               nvl(v.min_summ * 100, 0),
               0,
               d.acc,
               i.acra,
               i.acrb,
               i.acr_dat,
               i.io,
               t.lcv,
               substr(dpt_web.get_nazn(nvl(i.tt, '%%1'),
                                       d.dpu_id,
                                       d.nd,
                                       d.datz),
                      1,
                      160)
          into l_dealnum,
               l_dealdat,
               l_begdate,
               l_enddate,
               l_stopid,
               l_vidd,
               l_brwd,
               l_minsum,
               l_avans,
               l_dptaccid,
               l_intaccid,
               l_expaccid,
               l_acrdat,
               l_intio,
               l_curcode,
               l_details
          from dpu_deal d, dpu_vidd v, int_accn i, tabval t
         where d.vidd = v.vidd
           and d.acc = i.acc
           and i.id = l_genintid
           and v.kv = t.kv
           and d.dpu_id = p_dptid;
      exception
        when no_data_found then
          bars_error.raise_nerror(g_modcode,
                                  g_dptnotfound,
                                  to_char(p_dptid));
      end;
    end if;

    l_dealnum := bars_msg.get_msg(g_modcode,
                                  'GLPENALTY_FULLDEALNUM',
                                  l_dealnum,
                                  to_char(l_dealdat, 'dd.mm.yyyy'),
                                  to_char(p_dptid));

    -- РАСЧЕТ И ВЗЫСКАНИЕ ШТРАФА
    p_details := bars_msg.get_msg(g_modcode, 'GLPENALTY_TITLE');
    p_details := lpad(p_details, length(p_details) + 13, ' ');
    p_details := rpad(p_details, length(p_details) + 26, ' ');

    if p_fullpay = 0 then
      -- при частичном снятии суммы вклада № %s
      str2txt(p_details,
              bars_msg.get_msg(g_modcode, 'GLPENALTY_PART', l_dealnum));
    else
      -- при расторжении договора № %s
      str2txt(p_details,
              bars_msg.get_msg(g_modcode, 'GLPENALTY_FULL', l_dealnum));
    end if;

    bars_audit.trace('%s договор № %s, период действия %s - %s, штраф/ставка ЧС - %s/%s',
                     title,
                     l_dealnum,
                     to_char(l_begdate, 'dd.mm.yy'),
                     to_char(l_enddate, 'dd.mm.yy'),
                     to_char(l_stopid),
                     to_char(l_brwd));

    -- Период действия договора: %s - %s
    str2txt(p_details,
            bars_msg.get_msg(g_modcode,
                             'GLPENALTY_TERM',
                             to_char(l_begdate, 'dd.mm.yyyy'),
                             to_char(l_enddate, 'dd.mm.yyyy')));

    -- Код штрафа для договора: %s
    str2txt(p_details,
            bars_msg.get_msg(g_modcode,
                             'GLPENALTY_STOPID',
                             to_char(l_stopid)));

    -- счет амортизации для авансового вклада = контр.счет в проц.карточке
    if l_avans = 1 then
      l_amraccid := l_expaccid;
      select acrb
        into l_expaccid
        from int_accn
       where acc = l_amraccid
         and id = l_amrintid;
    else
      l_amraccid := null;
    end if;

    -- параметры депозитного счета + блокировка
    begin
      select *
        into l_dptaccrow
        from accounts
       where acc = l_dptaccid
         for update nowait;
    exception
      when no_data_found then
        bars_error.raise_nerror(g_modcode, 'DPTACC_NOT_FOUND', l_dealnum);
    end;
    bars_audit.trace('%s счет %s/%s, остаток = %s',
                     title,
                     l_dptaccrow.nls,
                     l_curcode,
                     to_char(l_dptaccrow.ostc));

    -- параметры процентного счета + блокировка
    begin
      select *
        into l_intaccrow
        from accounts
       where acc = l_intaccid
         for update nowait;
    exception
      when no_data_found then
        bars_error.raise_nerror(g_modcode, 'INTACC_NOT_FOUND', l_dealnum);
    end;
    bars_audit.trace('%s счет %s/%s, остаток = %s',
                     title,
                     l_intaccrow.nls,
                     l_curcode,
                     to_char(l_intaccrow.ostc));

    if l_avans = 1 then
      -- параметры счета амортизации + блокировка
      begin
        select *
          into l_amraccrow
          from accounts
         where acc = l_amraccid
           for update nowait;
      exception
        when no_data_found then
          bars_error.raise_nerror(g_modcode, 'AMRACC_NOT_FOUND', l_dealnum);
      end;
      bars_audit.trace('%s счет %s/%s, остаток = %s',
                       title,
                       l_amraccrow.nls,
                       l_curcode,
                       to_char(l_amraccrow.ostc));
    end if;

    -- Текущий остаток на деп.счете %s: %s
    str2txt(p_details,
            bars_msg.get_msg(g_modcode,
                             'GLPENALTY_DEPACC',
                             l_dptaccrow.nls,
                             num2str(l_dptaccrow.ostc, l_curcode)));
    -- Текущий остаток на проц.счете %s: %s
    str2txt(p_details,
            bars_msg.get_msg(g_modcode,
                             'GLPENALTY_INTACC',
                             l_intaccrow.nls,
                             num2str(l_intaccrow.ostc, l_curcode)));

    if l_avans = 1 then
      -- Текущий остаток на счете амортизации %s: %s
      str2txt(p_details,
              bars_msg.get_msg(g_modcode,
                               'GLPENALTY_AMRACC',
                               l_amraccrow.nls,
                               num2str(l_amraccrow.ostc, l_curcode)));
    end if;

    -- уточнение:
    -- для частичного снятия      сумма снятия = заявленная сумма (p_amount)
    -- для досрочного расторжения сумма снятия = факт.остаток на депозитном счете
    l_dptamount := case
                     when p_fullpay = 1 then
                      l_dptaccrow.ostc
                     else
                      p_amount
                   end;
    bars_audit.trace('%s сумма снятия = %s',
                     title,
                     to_char(l_dptamount));

    -- Заявленная сумма снятия с депозитного счета: %s
    str2txt(p_details,
            bars_msg.get_msg(g_modcode,
                             'GLPENALTY_AMOUNT',
                             num2str(l_dptamount, l_curcode)));

    -- вызов внутренней процедуры проверок при частином / полном снятии суммы вклада
    intl_validate_payoff(p_date      => p_date, -- дата снятия средств
                         p_begdate   => l_begdate, -- дата начала действия договора
                         p_enddate   => l_enddate, -- дата окончания действия договора
                         p_dptaccrow => l_dptaccrow, -- реквизиты депозитного счета
                         p_intaccrow => l_intaccrow, -- реквизиты процентного счета
                         p_amraccrow => l_amraccrow, -- реквизиты счета амортизации
                         p_fullpay   => p_fullpay, -- признак расторжения договора
                         p_minsum    => l_minsum, -- мин.сумма для вида вклада
                         p_amount    => l_dptamount, -- сумма снятия
                         p_stopid    => l_stopid, -- код штрафа
                         p_brwd      => l_brwd, -- код ставки част.снятия
                         p_nopenya   => l_nopenya, -- признак свободной выплаты
                         p_errmsg    => l_errmsg); -- сообщение об ошибке
    if l_errmsg is not null then
      bars_error.raise_nerror(g_modcode,
                              'PENALTY_DENIED',
                              l_dealnum,
                              l_errmsg);
    end if;

    -- расчет штрафной ставки
    if not l_nopenya then
      -- значение штрафной ставки берется из настройки штрафа для частичного и полного снятия
      l_penyarate := dpt.f_shtraf_rate(p_dptid, l_date);
      bars_audit.trace('%s штрафная ставка = %s',
                       title,
                       to_char(l_penyarate));
    end if;

    if l_penyarate is null then
      l_nopenya := true;
    end if;

    if l_nopenya then
      bars_audit.trace('%s снятие без штрафных санкций для договора № %s',
                       title,
                       to_char(p_dptid));
      -- штрафные санкции не предусмотрены
      str2txt(p_details, bars_msg.get_msg(g_modcode, 'GLPENALTY_DENIED'));
    end if;

    -- доначисление процентов по основной ставке по истории депозитного счета
    -- p_mode = RW -->  и порождение платежных документов

    -- вызов внутренней процедуры расчета суммы процентов и порождения документа
    intl_calc_interest(p_mode      => p_mode, -- RO - расчет, RW - проводки
                       p_date      => l_date, -- дата списания средств
                       p_accrec    => l_dptaccrow, -- параметры депозитного счета
                       p_intid     => l_genintid, -- 1  -- код процентной карточки
                       p_stopdate  => l_date - 1, -- граничная дата начисления
                       p_curcode   => l_curcode, -- символьный код валюты депозита
                       p_details   => l_details, -- назначение платежа
                       p_dptamount => null, -- сумма начисления
                       p_dptid     => p_dptid, --
                       p_intamount => l_intamount); -- сумма начисленных процентов
    bars_audit.trace('%s сумма доначисления = %s',
                     title,
                     to_char(l_intamount));

    /*
      if l_avans = 1 then
         -- амортизация выплаченных авансом процентов по вчерашний день включительно
         -- p_mode = RW -->  и порождение платежных документов
         intl_calc_interest (p_mode      =>  p_mode,           -- RO - расчет, RW - проводки
                             p_date      =>  p_date,           -- дата списания средств
                             p_accrec    =>  l_amraccrow,      -- параметры счета амортизации
                             p_intid     =>  l_amrintid,       -- код процентной карточки (=0)
                             p_stopdate  =>  p_date - 1,       -- граничная дата начисления
                             p_curcode   =>  l_curcode,        -- символьный код валюты депозита
                             p_details   =>  l_details,        -- назначение платежа
                             p_dptamount =>  null,             -- сумма начисления
                             p_intamount =>  l_amramount);     -- сумма амортизированных процентов
         bars_audit.trace('%s сумма доамортизации = %s', title, to_char(l_amramount));
      end if;
    */
    if l_avans = 1 and p_fullpay = 0 then
      -- амортизация выплаченных авансом процентов по вчерашний день включительно
      -- p_mode = RW -->  и порождение платежных документов
      intl_calc_interest(p_mode      => p_mode, -- RO - расчет, RW - проводки
                         p_date      => p_date, -- дата списания средств
                         p_accrec    => l_amraccrow, -- параметры счета амортизации
                         p_intid     => l_amrintid, -- код процентной карточки (=0)
                         p_stopdate  => p_date - 1, -- граничная дата начисления
                         p_curcode   => l_curcode, -- символьный код валюты депозита
                         p_details   => l_details, -- назначение платежа
                         p_dptamount => null, -- сумма начисления
                         p_intamount => l_amramount); -- сумма амортизированных процентов
      bars_audit.trace('%s сумма доамортизации = %s',
                       title,
                       to_char(l_amramount));
    else
      l_amramount := 0;
    end if;

    l_int2pay     := 0; -- сумма процентов к выплате
    l_int2ret     := 0; -- сумма процентов к возврату
    l_amr2ret     := 0; -- сумма амортизированных процентов к возврату
    l_tax2ret     := 0; -- сума нарахованих %% за базу оподаткування деп. договору по основній ставці
    l_tax2pay     := 0; -- сума нарахованих %% за базу оподаткування деп. договору по штрафній ставці
    l_tax2ret_mil := 0; -- сума нарахованих %% за базу оподаткування деп. договору по основній ставці
    l_tax2pay_mil := 0; -- сума нарахованих %% за базу оподаткування деп. договору по штрафній ставці

    if (not l_nopenya) then

      -- расчет сумм комиссий за частичное снятие / досрочное расторжение
      begin
        select s into l_formula from tts where tt = 'K08';
        if l_formula is null then
          l_penyac := 0;
        else
          l_penyac := dpt_web.get_amount(p_tt        => 'K08',
                                         p_formula   => l_formula,
                                         p_dealnum   => p_dptid,
                                         p_ref       => null,
                                         p_suma      => null,
                                         p_sumb      => null,
                                         p_curcodea  => l_dptaccrow.kv,
                                         p_curcodeb  => gl.baseval,
                                         p_amountm   => l_dptamount,
                                         p_curcodem  => l_dptaccrow.kv,
                                         p_accnuma   => null,
                                         p_accnumb   => null,
                                         p_bankcodea => null,
                                         p_bankcodeb => null);
        end if;
      exception
        when no_data_found then
          l_penyac := 0;
      end;
      bars_audit.trace('%s сумма комиссии за РКО = %s',
                       title,
                       to_char(l_penyac));

      -- Сумма комиссии за расчетно-касс.обслуживание :%s
      str2txt(p_details,
              bars_msg.get_msg(g_modcode,
                               'GLPENALTY_CMSRKO',
                               num2str(l_penyac, l_curcode)));

      -- коміся за виплату коштів що надійшли безготівковим шляхом
      l_penyav := dpt_web.f_get_nocash_commis(p_dptid  => p_dptid,
                                              p_acc    => l_dptaccrow.acc,
                                              p_datbeg => l_begdate,
                                              p_kv     => l_dptaccrow.kv);
      bars_audit.trace('%s сума комісії за виплату коштів що надійшли безготівковим шляхом = %s',
                       title,
                       to_char(l_penyav));

      -- Сума комісії за виплату коштів що надійшли безготівковим шляхом: %s
      str2txt(p_details,
              bars_msg.get_msg(g_modcode,
                               'GLPENALTY_CMSVET',
                               num2str(l_penyav, l_curcode)));

      -- значення штрафної ставки берется з налаштувань штрафу для часткового та повного зняття
      get_penalty_options(p_dpt_id       => p_dptid,
                          p_dat          => l_date,
                          p_penalty_rate => l_penyarate,
                          p_penalty_date => l_penyadate);
      /*   l_penyarate := dpt.f_shtraf_rate(p_dptid, p_date); */
      bars_audit.trace('%s штрафная ставка = %s',
                       title,
                       to_char(l_penyarate));

      -- Штрафная ставка = %s%
      str2txt(p_details,
              bars_msg.get_msg(g_modcode,
                               'GLPENALTY_PENYARATE',
                               to_char(l_penyarate, '90D99')));

      if (l_penyarate is null) then
        bars_error.raise_nerror(g_modcode,
                                'PENALTY_RATE_NOT_FOUND',
                                l_dealnum);
      end if;

      -- дата початку періоду для бази оподаткування
      --l_tax_dat_beg := to_date(GetGlobalOption('TAX_DON'), 'dd.mm.yyyy');  -- дата початку утримання податку з нарах.%% згідно постанови
      --l_dat4tax     := greatest(l_tax_dat_beg, l_begdate);                 -- максимальна дата з дати початку дії догов. та дата початку утримання податку

      -- ставка податку
      --l_tax_rate    := get_tax_rate();

      --  вызов внутренней процедуры расчета сумм и периодов для вычисления процентов к выплате и суммы штрафа
      --  расчет штрафа для суммы снятия / для всей суммы депозита
      intl_get_amounts(p_dptaccid => l_dptaccrow.acc, -- внутр.№ депозитного счета
                       p_datbeg   => l_begdate, -- дата начала действия договора
                       p_date     => l_date, -- дата списания средств
                       p_amount   => l_dptaccrow.ostc, -- сумма депозита
                       p_commiss  => 0, -- сумма комиссии
                       p_intio    => l_intio,
                       p_accturn  => l_accturn);

      -- вызов внутренней процедуры очистки альтернативной %-ной карточки (id = 3)
      intl_clear_altintcard(p_dptaccid => l_dptaccid,
                            p_altintid => l_altintid);

      l_accturncnt := l_accturn.count;
      bars_audit.trace('%s кол-во движений = %s',
                       title,
                       to_char(l_accturncnt));

      -- <<<  >>>
      for i in 1 .. l_accturncnt loop
        --
        -- расчет %% по штрафной ставке на сумму снятия по вчерашний день включительно
        --
        -- вызов внутренней процедуры заполнения альтернативной процентной карточки и ставки
        intl_fill_altintcard(p_dptaccid  => l_accturn(i).accid,
                             p_genintid  => l_genintid, -- 1
                             p_altintid  => l_altintid, -- 5
                             p_intdat1   => l_accturn(i).intdat1,
                             p_intdat2   => l_accturn(i).intdat2,
                             p_penyadate => nvl(l_penyadate,
                                                l_accturn(i).intdat1),
                             p_penyarate => l_penyarate);

        -- вызов внутренней процедуры расчета суммы процентов (RO)
        intl_calc_interest(p_mode      => 'RO',
                           p_date      => l_date,
                           p_accrec    => l_dptaccrow,
                           p_intid     => l_altintid, -- 5 - код процентной карточки
                           p_stopdate  => l_accturn(i).intdat2,
                           p_curcode   => l_curcode,
                           p_details   => l_details,
                           p_dptamount => l_accturn(i).rest2pay,
                           p_intamount => l_tmp);

        l_int2pay := l_int2pay + nvl(l_tmp, 0);

        bars_audit.trace('%s за период с %s по %s начислено на сумму %s по штрафной ставке %s = %s',
                         title,
                         to_char(l_accturn(i).intdat1 + 1, 'dd.mm.yy'),
                         to_char(l_accturn(i).intdat2, 'dd.mm.yy'),
                         to_char(l_accturn(i).rest2pay),
                         to_char(l_penyarate),
                         to_char(l_tmp));

        -- По штрафной ставке начислено %s %
        str2txt(p_details,
                bars_msg.get_msg(g_modcode,
                                 'GLPENALTY_PENYAINT',
                                 num2str(l_tmp, l_curcode)));
        -- (за период с %s по %s /%s дн./ на сумму %s)
        str2txt(p_details,
                bars_msg.get_msg(g_modcode,
                                 'GLPENALTY_PENYAINTDET',
                                 to_char(l_accturn(i).intdat1 + 1,
                                         'dd.mm.yyyy'),
                                 to_char(l_accturn(i).intdat2, 'dd.mm.yyyy'),
                                 to_char(l_accturn(i)
                                         .intdat2 - l_accturn(i).intdat1,
                                         '99999'),
                                 num2str(l_accturn(i).rest2pay, l_curcode)));

        --
        -- расчет %% по основной ставке на сумму снятия и сумму комиссии по дату последнего начисления включительно
        --
        -- вызов внутренней процедуры заполнения альтернативной процентной карточки и ставки
        intl_fill_altintcard(p_dptaccid  => l_accturn(i).accid,
                             p_genintid  => l_genintid, -- 1
                             p_altintid  => l_altintid, -- 3
                             p_intdat1   => l_accturn(i).intdat1,
                             p_intdat2   => l_accturn(i).intdat3,
                             p_penyadate => null,
                             p_penyarate => null);

        -- вызов внутренней процедуры расчета суммы процентов (RO)
        intl_calc_interest(p_mode      => 'RO',
                           p_date      => l_date,
                           p_accrec    => l_dptaccrow,
                           p_intid     => l_altintid, -- 3
                           p_stopdate  => l_accturn(i).intdat3,
                           p_curcode   => l_curcode,
                           p_details   => l_details,
                           p_dptamount => l_accturn(i).rest2take,
                           p_intamount => l_tmp);

        l_int2ret := l_int2ret + nvl(l_tmp, 0);

        bars_audit.trace('%s за период с %s по %s начислено на сумму %s по основной ставке = %s',
                         title,
                         to_char(l_accturn(i).intdat1 + 1, 'dd.mm.yy'),
                         to_char(l_accturn(i).intdat3, 'dd.mm.yy'),
                         to_char(l_accturn(i).rest2take),
                         to_char(l_tmp));

        -- По основной ставке начислено %s %
        str2txt(p_details,
                bars_msg.get_msg(g_modcode,
                                 'GLPENALTY_MAININT',
                                 num2str(l_tmp, l_curcode)));
        -- (за период с %s по %s /%s дн./ на сумму %s)
        str2txt(p_details,
                bars_msg.get_msg(g_modcode,
                                 'GLPENALTY_MAININTDET',
                                 to_char(l_accturn(i).intdat1 + 1,
                                         'dd.mm.yyyy'),
                                 to_char(l_accturn(i).intdat3, 'dd.mm.yyyy'),
                                 to_char(l_accturn(i)
                                         .intdat3 - l_accturn(i).intdat1,
                                         '99999'),
                                 num2str(l_accturn(i).rest2take, l_curcode)));

        if (l_avans = 1 /* and p_fullpay = 0 */
           ) then
          --
          -- расчет амортиз.%% по основной ставке на сумму снятия и сумму комиссии по вчерашний день включительно
          --
          intl_fill_altintcard(p_dptaccid  => l_accturn(i).accid,
                               p_genintid  => l_genintid, -- 1
                               p_altintid  => l_altintid, -- 3
                               p_intdat1   => l_accturn(i).intdat1,
                               p_intdat2   => l_accturn(i).intdat2,
                               p_penyadate => null,
                               p_penyarate => null);
          intl_calc_interest(p_mode      => 'RO',
                             p_date      => p_date,
                             p_accrec    => l_dptaccrow,
                             p_intid     => l_altintid, -- 3
                             p_stopdate  => l_accturn(i).intdat2,
                             p_curcode   => l_curcode,
                             p_details   => l_details,
                             p_dptamount => l_accturn(i).rest2take,
                             p_intamount => l_tmp);
          l_amr2ret := l_amr2ret + nvl(l_tmp, 0);
          bars_audit.trace('%s за период с %s по %s амортизировано на сумму %s по основной ставке = %s',
                           title,
                           to_char(l_accturn(i).intdat1 + 1, 'dd.mm.yy'),
                           to_char(l_accturn(i).intdat2, 'dd.mm.yy'),
                           to_char(l_accturn(i).rest2take),
                           to_char(l_tmp));

          -- По основной ставке амортизировано %s %
          str2txt(p_details,
                  bars_msg.get_msg(g_modcode,
                                   'GLPENALTY_MAINAMR',
                                   num2str(l_tmp, l_curcode)));
          -- (за период с %s по %s /%s дн./ на сумму %s)
          str2txt(p_details,
                  bars_msg.get_msg(g_modcode,
                                   'GLPENALTY_MAINAMRDET',
                                   to_char(l_accturn(i).intdat1 + 1,
                                           'dd.mm.yyyy'),
                                   to_char(l_accturn(i).intdat2,
                                           'dd.mm.yyyy'),
                                   to_char(l_accturn(i)
                                           .intdat2 - l_accturn(i).intdat1,
                                           '99999'),
                                   num2str(l_accturn(i).rest2take, l_curcode)));
        end if;

        /*
        * ДЛЯ ПОВЕРНЕННЯ / УТРИМАННЯ ПОДАТКУ З ВІДСОТКІВ *
        */
        -- Определение периодов и ставок налогообложения по справочнику TAX_SETTINGS

        bars_audit.trace('PENALTY l_acrdat = ' ||
                         to_date(l_acrdat, 'dd/mm/yyyy'));
        select tax_type, tax_int, dat_begin - 1, dat_end
          bulk collect
          into l_taxlist
          from tax_settings
         where tax_type = 1; -- 1 Налог на пассивные доходы ФЛ

        -- Определение периодов и ставок налогообложения по справочнику TAX_SETTINGS
        select tax_type, tax_int, dat_begin - 1, dat_end
          bulk collect
          into l_taxlist_mil
          from tax_settings
         where tax_type = 2; -- 2 Военный сбор

        bars_audit.trace('PENALTY Количество периодов налогообложения (ПДФО) = ' ||
                         to_char(l_taxlist.count));
        for j in 1 .. l_taxlist.count loop
          --
          -- розрахунок суми %% нарах. по штрафній ставці за період бази оподаткування
          --
          -- вызов внутренней процедуры заполнения альтернативной процентной карточки и ставки
          bars_audit.trace('Период расчета налога (ПДФО)' ||
                           to_char(greatest(l_taxlist(j).tax_date_begin,
                                            l_accturn(i).intdat1),
                                   'dd/mm/yyyy') || ' - ' ||
                           to_char(nvl(l_taxlist(j).tax_date_end,
                                       l_accturn(i).intdat2),
                                   'dd/mm/yyyy'));

          intl_fill_altintcard(p_dptaccid  => l_accturn(i).accid,
                               p_genintid  => l_genintid, -- 1
                               p_altintid  => l_altintid, -- 5
                               p_intdat1   => greatest(l_taxlist(j)
                                                       .tax_date_begin,
                                                       l_accturn(i).intdat1),
                               p_intdat2   => least(l_accturn(i).intdat2,
                                                    nvl(l_taxlist(j)
                                                        .tax_date_end,
                                                        l_accturn(i).intdat2)),
                               p_penyadate => nvl(l_penyadate,
                                                  greatest(l_taxlist(j)
                                                           .tax_date_begin,
                                                           l_accturn(i).intdat1)),
                               p_penyarate => l_penyarate);

          -- вызов внутренней процедуры расчета суммы процентов (RO)
          intl_calc_interest(p_mode      => 'RO',
                             p_date      => l_date,
                             p_accrec    => l_dptaccrow,
                             p_intid     => l_altintid, -- 5 - код процентной карточки
                             p_stopdate  => least(l_accturn(i).intdat2,
                                                  nvl(l_taxlist(j)
                                                      .tax_date_end,
                                                      l_accturn(i).intdat2)),
                             p_curcode   => l_curcode,
                             p_details   => l_details,
                             p_dptamount => l_accturn(i).rest2pay,
                             p_intamount => l_tmp);

          bars_audit.trace('PENALTY: Сумма налога к оплате (l_tax2pay.l_tmp) = ' ||
                           to_char(round(nvl(l_tmp, 0) * l_taxlist(j)
                                         .tax_int,
                                         0)) || ' за период ' ||
                           to_char(greatest(l_taxlist(j).tax_date_begin,
                                            l_accturn(i).intdat1)) || '-' ||
                           to_char(least(l_accturn(i).intdat2,
                                         nvl(l_taxlist(j).tax_date_end,
                                             l_accturn(i).intdat2))));

          l_tax2pay := nvl(l_tax2pay, 0) +
                       round(nvl(l_tmp, 0) * l_taxlist(j).tax_int);
          bars_audit.trace('%s за период с %s по %s начислено на сумму %s по штрафной ставке %s = %s',
                           title,
                           to_char(greatest(l_taxlist(j).tax_date_begin,
                                            l_accturn(i).intdat1 + 1),
                                   'dd.mm.yy'),
                           to_char(least(l_accturn(i).intdat2,
                                         nvl(l_taxlist(j).tax_date_end,
                                             l_accturn(i).intdat2)),
                                   'dd.mm.yy'),
                           to_char(l_accturn(i).rest2pay),
                           to_char(l_penyarate),
                           to_char(l_tmp));

          -- По штрафной ставке начислено %s %
          str2txt(p_details,
                  bars_msg.get_msg(g_modcode,
                                   'GLPENALTY_PENYATAX',
                                   num2str(l_tmp, l_curcode)));
          -- (за период с %s по %s /%s дн./ на сумму %s)
          str2txt(p_details,
                  bars_msg.get_msg(g_modcode,
                                   'GLPENALTY_PENYATAXDET',
                                   to_char(greatest(l_taxlist(j)
                                                    .tax_date_begin,
                                                    l_accturn(i).intdat1 + 1),
                                           'dd.mm.yyyy'),
                                   to_char(nvl(l_taxlist(j).tax_date_end,
                                               l_accturn(i).intdat2),
                                           'dd.mm.yyyy'),
                                   to_char(nvl(l_taxlist(j).tax_date_end,
                                               l_accturn(i).intdat2) -
                                           greatest(l_taxlist(j)
                                                    .tax_date_begin,
                                                    l_accturn(i).intdat1 + 1),
                                           '99999'),
                                   num2str(l_accturn(i).rest2pay, l_curcode)));

          ----------------------------------------------------------------------------
          -- розрахунок суми %% нарах. по основній ставці за період бази оподаткування
          --
          -- вызов внутренней процедуры заполнения альтернативной процентной карточки и ставки
          intl_fill_altintcard(p_dptaccid  => l_accturn(i).accid,
                               p_genintid  => l_genintid, -- 1
                               p_altintid  => l_altintid, -- 3
                               p_intdat1   => greatest(l_taxlist(j)
                                                       .tax_date_begin,
                                                       l_accturn(i).intdat1),
                               p_intdat2   => least(l_accturn(i).intdat3,
                                                    nvl(l_taxlist(j)
                                                        .tax_date_end,
                                                        l_accturn(i).intdat3)),
                               p_penyadate => null,
                               p_penyarate => null);

          -- вызов внутренней процедуры расчета суммы процентов (RO)
          intl_calc_interest(p_mode      => 'RO',
                             p_date      => l_date,
                             p_accrec    => l_dptaccrow,
                             p_intid     => l_altintid, -- 3
                             p_stopdate  => least(l_accturn(i).intdat3,
                                                  nvl(l_taxlist(j)
                                                      .tax_date_end,
                                                      l_accturn(i).intdat3)),
                             p_curcode   => l_curcode,
                             p_details   => l_details,
                             p_dptamount => l_accturn(i).rest2take,
                             p_intamount => l_tmp);

          bars_audit.trace('PENALTY: Сумма налога к возврату (l_tax2ret.l_tmp) = ' ||
                           to_char(round(nvl(l_tmp, 0) * l_taxlist(j)
                                         .tax_int,
                                         0)) || ' за период ' ||
                           to_char(greatest(l_taxlist(j).tax_date_begin,
                                            l_accturn(i).intdat1)) || '-' ||
                           to_char(least(l_accturn(i).intdat3,
                                         nvl(l_taxlist(j).tax_date_end,
                                             l_accturn(i).intdat3))));

          l_tax2ret := nvl(l_tax2ret, 0) +
                       round(nvl(l_tmp, 0) * l_taxlist(j).tax_int);
          bars_audit.trace('%s за период с %s по %s начислено на сумму %s по основной ставке = %s',
                           title,
                           to_char(greatest(l_taxlist(j).tax_date_begin,
                                            l_accturn(i).intdat1 + 1),
                                   'dd.mm.yy'),
                           to_char(least(l_accturn(i).intdat2,
                                         nvl(l_taxlist(j).tax_date_end,
                                             l_accturn(i).intdat2)),
                                   'dd.mm.yy'),
                           to_char(l_accturn(i).rest2take),
                           to_char(l_tmp));

          -- По основной ставке начислено %s %
          str2txt(p_details,
                  bars_msg.get_msg(g_modcode,
                                   'GLPENALTY_MAINTAX',
                                   num2str(l_tmp, l_curcode)));
          -- (за период с %s по %s /%s дн./ на сумму %s)
          str2txt(p_details,
                  bars_msg.get_msg(g_modcode,
                                   'GLPENALTY_MAINTAXDET',
                                   to_char(greatest(l_taxlist(j)
                                                    .tax_date_begin,
                                                    l_accturn(i).intdat1),
                                           'dd.mm.yyyy'),
                                   to_char(least(l_accturn(i).intdat3,
                                                 nvl(l_taxlist(j).tax_date_end,
                                                     l_accturn(i).intdat3)),
                                           'dd.mm.yyyy'),
                                   to_char(least(l_accturn(i).intdat3,
                                                 nvl(l_taxlist(j).tax_date_end,
                                                     l_accturn(i).intdat3)) -
                                           greatest(l_taxlist(j)
                                                    .tax_date_begin,
                                                    l_accturn(i).intdat1),
                                           '99999'),
                                   num2str(l_accturn(i).rest2take, l_curcode)));
        end loop;
        bars_audit.trace('PENALTY Количество периодов налогообложения (Военный сбор) = ' ||
                         to_char(l_taxlist.count));
        for z in 1 .. l_taxlist_mil.count loop
          --
          -- розрахунок суми %% нарах. по штрафній ставці за період бази оподаткування
          --
          -- вызов внутренней процедуры заполнения альтернативной процентной карточки и ставки
          intl_fill_altintcard(p_dptaccid  => l_accturn(i).accid,
                               p_genintid  => l_genintid, -- 1
                               p_altintid  => l_altintid, -- 5
                               p_intdat1   => greatest(l_taxlist_mil(z)
                                                       .tax_date_begin,
                                                       l_accturn    (i)
                                                       .intdat1),
                               p_intdat2   => least(l_accturn(i).intdat2,
                                                    nvl(l_taxlist_mil(z)
                                                        .tax_date_end,
                                                        l_accturn    (i)
                                                        .intdat2)),
                               p_penyadate => nvl(l_penyadate,
                                                  greatest(l_taxlist_mil(z)
                                                           .tax_date_begin,
                                                           l_accturn    (i)
                                                           .intdat1)),
                               p_penyarate => l_penyarate);

          -- вызов внутренней процедуры расчета суммы процентов (RO)
          intl_calc_interest(p_mode      => 'RO',
                             p_date      => l_date,
                             p_accrec    => l_dptaccrow,
                             p_intid     => l_altintid, -- 5 - код процентной карточки
                             p_stopdate  => least(l_accturn(i).intdat2,
                                                  nvl(l_taxlist_mil(z)
                                                      .tax_date_end,
                                                      l_accturn    (i).intdat2)),
                             p_curcode   => l_curcode,
                             p_details   => l_details,
                             p_dptamount => l_accturn(i).rest2pay,
                             p_intamount => l_tmp);

          bars_audit.trace('PENALTY (Военный сбор): Сумма налога к оплате (l_tmp) = ' ||
                           to_char(round(nvl(l_tmp, 0) * l_taxlist_mil(z)
                                         .tax_int),
                                   0) || ' за период ' ||
                           to_char(greatest(l_taxlist_mil(z).tax_date_begin,
                                            l_accturn    (i).intdat1)) || '-' ||
                           to_char(least(l_accturn(i).intdat2,
                                         nvl(l_taxlist_mil(z).tax_date_end,
                                             l_accturn    (i).intdat2))));

          l_tax2pay_mil := nvl(l_tax2pay_mil, 0) +
                           round(nvl(l_tmp, 0) * l_taxlist_mil(z).tax_int);

          bars_audit.trace('%s за период с %s по %s начислено на сумму %s по штрафной ставке %s = %s',
                           title,
                           to_char(greatest(l_taxlist_mil(z).tax_date_begin,
                                            l_accturn    (i).intdat1),
                                   'dd.mm.yy'),
                           to_char(least(l_accturn(i).intdat2,
                                         nvl(l_taxlist_mil(z).tax_date_end,
                                             l_accturn    (i).intdat2)),
                                   'dd.mm.yy'),
                           to_char(l_accturn(i).rest2pay),
                           to_char(l_penyarate),
                           to_char(l_tmp));

          -- По штрафной ставке начислено %s %
          str2txt(p_details,
                  bars_msg.get_msg(g_modcode,
                                   'GLPENALTY_PENYATAX',
                                   num2str(l_tmp, l_curcode)));
          -- (за период с %s по %s /%s дн./ на сумму %s)
          str2txt(p_details,
                  bars_msg.get_msg(g_modcode,
                                   'GLPENALTY_PENYATAXDET',
                                   to_char(greatest(l_taxlist_mil(z)
                                                    .tax_date_begin,
                                                    l_accturn    (i).intdat1),
                                           'dd.mm.yyyy'),
                                   to_char(least(l_accturn(i).intdat2,
                                                 nvl(l_taxlist_mil(z)
                                                     .tax_date_end,
                                                     l_accturn    (i).intdat2)),
                                           'dd.mm.yyyy'),
                                   to_char(least(l_accturn(i).intdat2,
                                                 nvl(l_taxlist_mil(z)
                                                     .tax_date_end,
                                                     l_accturn    (i).intdat2)) -
                                           greatest(l_taxlist_mil(z)
                                                    .tax_date_begin,
                                                    l_accturn    (i).intdat1),
                                           '99999'),
                                   num2str(l_accturn(i).rest2pay, l_curcode)));

          ----------------------------------------------------------------------------
          -- розрахунок суми %% нарах. по основній ставці за період бази оподаткування
          --
          -- вызов внутренней процедуры заполнения альтернативной процентной карточки и ставки
          intl_fill_altintcard(p_dptaccid  => l_accturn(i).accid,
                               p_genintid  => l_genintid, -- 1
                               p_altintid  => l_altintid, -- 3
                               p_intdat1   => greatest(l_taxlist_mil(z)
                                                       .tax_date_begin,
                                                       l_accturn    (i)
                                                       .intdat1),
                               p_intdat2   => least(l_accturn(i).intdat3,
                                                    nvl(l_taxlist_mil(z)
                                                        .tax_date_end,
                                                        l_accturn    (i)
                                                        .intdat3)),
                               p_penyadate => null,
                               p_penyarate => null);

          -- вызов внутренней процедуры расчета суммы процентов (RO)
          intl_calc_interest(p_mode      => 'RO',
                             p_date      => l_date,
                             p_accrec    => l_dptaccrow,
                             p_intid     => l_altintid, -- 3
                             p_stopdate  => least(l_accturn(i).intdat3,
                                                  nvl(l_taxlist_mil(z)
                                                      .tax_date_end,
                                                      l_accturn    (i).intdat3)),
                             p_curcode   => l_curcode,
                             p_details   => l_details,
                             p_dptamount => l_accturn(i).rest2take,
                             p_intamount => l_tmp);

          --l_tax2ret := l_tax2ret + nvl(l_tmp, 0);
          bars_audit.trace('PENALTY (Военный сбор): Сумма налога к возврату (l_tmp) = ' ||
                           to_char(round(nvl(l_tmp, 0) * l_taxlist_mil(z)
                                         .tax_int) || ' за период ' ||
                                   to_char(greatest(l_taxlist_mil(z)
                                                    .tax_date_begin,
                                                    l_accturn    (i).intdat1)) || '-' ||
                                   to_char(least(l_accturn(i).intdat3,
                                                 nvl(l_taxlist_mil(z)
                                                     .tax_date_end,
                                                     l_accturn    (i).intdat3)))));

          l_tax2ret_mil := nvl(l_tax2ret_mil, 0) +
                           round(nvl(l_tmp, 0) * l_taxlist_mil(z).tax_int);
          bars_audit.trace('%s за период с %s по %s начислено на сумму %s по основной ставке = %s',
                           title,
                           to_char(greatest(l_taxlist_mil(z).tax_date_begin,
                                            l_accturn    (i).intdat1 + 1),
                                   'dd.mm.yy'),
                           to_char(least(l_accturn(i).intdat3,
                                         nvl(l_taxlist_mil(z).tax_date_end,
                                             l_accturn    (i).intdat3)),
                                   'dd.mm.yy'),
                           to_char(l_accturn(i).rest2take),
                           to_char(l_tmp));

          -- По основной ставке начислено %s %
          str2txt(p_details,
                  bars_msg.get_msg(g_modcode,
                                   'GLPENALTY_MAINTAX',
                                   num2str(l_tmp, l_curcode)));
          -- (за период с %s по %s /%s дн./ на сумму %s)
          str2txt(p_details,
                  bars_msg.get_msg(g_modcode,
                                   'GLPENALTY_MAINTAXDET',
                                   to_char(greatest(l_taxlist_mil(z)
                                                    .tax_date_begin,
                                                    l_accturn    (i).intdat1),
                                           'dd.mm.yyyy'),
                                   to_char(least(l_accturn(i).intdat3,
                                                 nvl(l_taxlist_mil(z)
                                                     .tax_date_end,
                                                     l_accturn    (i).intdat3)),
                                           'dd.mm.yyyy'),
                                   to_char(least(l_accturn(i).intdat3,
                                                 nvl(l_taxlist_mil(z)
                                                     .tax_date_end,
                                                     l_accturn    (i).intdat3)) -
                                           greatest(l_taxlist_mil(z)
                                                    .tax_date_begin,
                                                    l_accturn    (i).intdat1),
                                           '99999'),
                                   num2str(l_accturn(i).rest2take, l_curcode)));

        end loop;
        /* ********************************************** */
        bars_audit.trace('PENALTY: Сумма налога к возврату (l_tax2ret) = ' ||
                         to_char(l_tax2ret));
        bars_audit.trace('PENALTY: Сумма налога к возврату (l_tax2ret_mil) = ' ||
                         to_char(l_tax2ret_mil));
        if i = 1 then
          l_details := l_details || ' (' ||
                       to_char(l_accturn(i).intdat1 + 1, 'dd.mm.yyyy');
        end if;

        if i = l_accturncnt then
          l_details := l_details || ' - ' ||
                       to_char(l_accturn(i).intdat2, 'dd.mm.yyyy') ||
                       ') за штрафною ставкою ' ||
                       to_char(l_penyarate, '90D99');
        end if;

      end loop;
      bars_audit.trace('%s назначение платежа - %s',
                       title,
                       l_details);

      -- вызов внутренней процедуры очистки альтернативной %-ной карточки (id = 3)
      intl_clear_altintcard(p_dptaccid => l_dptaccid,
                            p_altintid => l_altintid);

      l_int2pay     := round(l_int2pay);
      p_int2pay_ing := l_int2pay; --inga

      l_int2ret := round(l_int2ret);

      bars_audit.trace('%s общая сумма процентов к выплате = %s',
                       title,
                       to_char(l_int2pay));
      bars_audit.trace('%s общая сумма процентов к возврату = %s',
                       title,
                       to_char(l_int2ret));
      bars_audit.trace('%s загальна сума податку до повернення = %s',
                       title,
                       to_char(l_tax2ret));
      bars_audit.trace('%s загальна сума податку до сплати = %s',
                       title,
                       to_char(l_tax2pay));
      bars_audit.trace('%s загальна сума податку (ВЗ) до повернення = %s',
                       title,
                       to_char(l_tax2ret_mil));
      bars_audit.trace('%s загальна сума податку (ВЗ) до сплати = %s',
                       title,
                       to_char(l_tax2pay_mil));

      -- Общая сумма процентов к выплате  :%s
      -- Общая сумма процентов к возврату :%s
      str2txt(p_details,
              bars_msg.get_msg(g_modcode,
                               'GLPENALTY_INT2PAY',
                               num2str(l_int2pay, l_curcode)));
      str2txt(p_details,
              bars_msg.get_msg(g_modcode,
                               'GLPENALTY_INT2RET',
                               num2str(l_int2ret, l_curcode)));

      -- всі кредитові обороти по рахунку нарахованих %%
      select sum(kos)
        into l_tmp
        from saldoa
       where acc = l_intaccrow.acc
         and fdat > l_begdate;

      if (l_int2ret > l_tmp) then
        bars_audit.info(title || ' Сума %% до повернення ' ||
                        to_char(l_int2ret) ||
                        ' більша від суми кредитових надходжень ' ||
                        to_char(l_tmp));
        l_int2ret := l_tmp;
      end if;

      -- (inga + baa) высчитаем сумму реально взятого налога по истории
      select nvl(sum(s), 0)
        into l_tmp
        from opldok
       where ref in (select ref from dpt_payments where dpt_id = p_dptid)
         and acc = l_intaccrow.acc
         and tt = '%15'
         and sos = 5
         and dk = 0;

      if (l_tax2ret > l_tmp) then
        bars_audit.info(title || ' Сума податку до повернення ' ||
                        to_char(l_tax2ret) ||
                        ' більша від суми утриманого податку ' ||
                        to_char(l_tmp));
        l_tax2ret := l_tmp;
      end if;

      -- (inga + baa) высчитаем сумму реально взятого налога по истории
      select nvl(sum(s), 0)
        into l_tmp
        from opldok
       where ref in (select ref from dpt_payments where dpt_id = p_dptid)
         and acc = l_intaccrow.acc
         and tt = 'MIL'
         and sos = 5
         and dk = 0;

      if (l_tax2ret_mil > l_tmp) then
        bars_audit.info(title ||
                        ' Сума податку (Військовий збір) до повернення ' ||
                        to_char(l_tax2ret) ||
                        ' більша від суми утриманого податку (Військовий збір) ' ||
                        to_char(l_tmp));
        l_tax2ret_mil := l_tmp;
      end if;
      -- остаток на процентном счете с учетом доначисления
      if p_mode = 'RW' then
        select ostb
          into l_intaccrow.ostb
          from accounts
         where acc = l_intaccid;
      else
        l_intaccrow.ostb := l_intaccrow.ostc + round(l_intamount);
      end if;

      -- остаток на cчете амортизации с учетом доамортизации
      if (l_avans = 1) then

        if (p_mode = 'RW') then
          select ostb
            into l_amraccrow.ostb
            from accounts
           where acc = l_amraccid;
        else
          l_amraccrow.ostb := l_amraccrow.ostc - round(l_amramount);
        end if;

        l_amr2ret := round(l_amr2ret);

        bars_audit.trace('%s общая сумма аморт.%%  к возврату = %s',
                         title,
                         to_char(l_amr2ret));

        -- Общая сумма амортизированных процентов к возврату :%s
        str2txt(p_details,
                bars_msg.get_msg(g_modcode,
                                 'GLPENALTY_AMR2RET',
                                 num2str(l_amr2ret, l_curcode)));

        if (p_fullpay = 1) then
          -- окончательное урегулирование начисленных и выплаченных авансом процентов
          advance_balsettlement(p_dptid  => p_dptid,
                                p_bdate  => p_date,
                                p_branch => l_dptaccrow.branch,
                                p_mode   => 'RO',
                                p_expbal => l_expbal,
                                p_amrbal => l_amrbal);
          bars_audit.trace('%s сумма урегулир.возврата на 7041/3500 = %s/%s',
                           title,
                           to_char(l_expbal),
                           to_char(l_amrbal));
        else
          l_expbal := 0;
          l_amrbal := 0;
        end if;

      end if;

    end if; -- (not l_nopenya)

    if (p_mode = 'RW') then
      if (l_dptaccrow.nbs != '2620') then
        -- вставка ознаки відбору депозиту на перенесення в архів
        dpt.fill_dptparams(p_dptid, '2CLOS', 'Y');
      else
        bars_audit.trace('%s Поточні рахунки не відмічаємо до закриття',
                         title);
      end if;

      -- Pavlenko 19/07/2014 l_less_stp_dat
      begin
        select 1
          into l_less_stp_dat
          from dpt_deposit
         where deposit_id = p_dptid
           and vidd in (select vidd from dpt_dict_vidd_debtrans);
      exception
        when no_data_found then
          l_less_stp_dat := 0;
      end;

      if (l_dptaccrow.nbs != '2620') and (l_less_stp_dat = 0) then

        update int_accn
           set stp_dat =
               (l_date - 1)
         where acc = l_dptaccrow.acc
           and id = l_genintid
           and stp_dat > l_date;

        bars_audit.info(title ||
                        ' зупинено нарахування відсотків по депозиту ' ||
                        to_char(p_dptid) ||
                        ' через часкове вилучення коштів.');

        update dpt_deposit
           set forbid_extension = 1
         where deposit_id = p_dptid;

        bars_audit.info(title ||
                        ' проставлена ознака заборони пролонгації по депозиту ' ||
                        to_char(p_dptid) ||
                        ' через часкове вилучення коштів.');

      end if;

    end if;

    if l_nopenya then

      -- без штрафа
      select ostb
        into l_intaccrow.ostb
        from accounts
       where acc = l_intaccid;

      p_penalty  := 0; -- сумма штрафа
      p_commiss  := 0; -- сумма комиссии за РКО
      p_commiss2 := 0; -- сумма комиссии за прием ветхих купюр
      p_intrest  := l_intaccrow.ostb; -- сумма процентов к выплате
      p_dptrest  := l_dptamount; -- сумма депозита к выплате
      l_penyap   := 0;
      l_penyad   := 0;
      l_penyac   := 0;
      l_penyav   := 0;

    else
      p_commiss  := l_penyac; -- комиссия за РКО
      p_commiss2 := l_penyav; -- комиссия за прием ветхих купюр
      p_penalty  := nvl(l_int2ret, 0) + nvl(l_expbal, 0) + nvl(l_amrbal, 0); -- общая сумма штрафа

      if (l_avans = 0) then
        -- зал. на %% рах. + %% нарах. по штр. ставці + податок до повернення - податок з нарах. %% по штр. ставці
        l_tmp := (l_intaccrow.ostb + l_int2pay +
                 (l_tax2ret + l_tax2ret_mil) - (l_tax2pay + l_tax2pay_mil));

        l_penyap := least(l_tmp, l_int2ret); -- в т.ч. с проц.счета 2638->6399
        l_penyaa := 0; -- в т.ч. с деп.счета  2630->3500
        l_penyad := greatest(l_int2ret - l_penyap, 0); -- в т.ч. с деп.счета  2630->6399

      else
        l_penyap  := 0; -- в т.ч. с проц.счета 2638->6399
        l_penyaa  := least(abs(l_amraccrow.ostb),
                           l_int2ret - l_amr2ret + l_amrbal); -- в т.ч. с деп.счета  2630->3500
        l_penyad  := greatest((l_int2ret + l_expbal + l_amrbal - l_penyaa),
                              0); -- в т.ч. с деп.счета  2630->6399
        l_int2ret := p_penalty;
      end if;

      p_dptrest := least(l_dptaccrow.ostc - l_penyad - l_penyaa - l_penyac -
                         l_penyav,
                         l_dptamount); -- сумма депозита к выплате
      p_intrest := l_int2pay; -- сумма процентов к выплате

      -- сумма процентов к выплате = проценты по штрафной ставке на сумму снятия
      --                           + невыплач.проценты за прошлые сроки переоформл.вклада
      intl_get_prevint(p_depaccrow => l_dptaccrow, -- параметры деп.счета
                       p_intsaldo  => l_intaccrow.ostb, -- план.остаток на проц.счете
                       p_curcode   => l_curcode, -- симв.код валюты
                       p_intdat1   => l_begdate, -- начальная дата начисления
                       p_intdat2   => l_acrdat, -- конечная дата начисления
                       p_bankdat   => l_date, -- текущая банковская дата
                       p_prevint   => l_prevrest); -- сумма процентов прошлых периодов
      bars_audit.trace('%s невыплач.проценты за прошлые сроки = %s',
                       title,
                       to_char(l_prevrest));
      p_intrest := p_intrest + l_prevrest;

      -- доп.проверка для част.снятия - "остаток меньше минимально допустимого"
      if (p_fullpay = 0) then
        -- Операция заблокирована: сумма договора № %s после снятия указанной суммы (%s),
        -- списания комиссий (%s+%s) и возврата излишне выплач.процентов (%s+%s)
        -- меньше минимально допустимой (%s)
        if (l_dptaccrow.ostc - l_penyad - l_penyaa - l_penyac - l_penyav -
           p_dptrest < l_minsum) then
          bars_error.raise_nerror(g_modcode,
                                  'PENALTY_EXCESSAMOUNT',
                                  l_dealnum,
                                  num2str(l_dptamount, l_curcode),
                                  num2str(l_penyac, l_curcode),
                                  num2str(l_penyav, l_curcode),
                                  num2str(l_penyad + l_penyaa, l_curcode),
                                  num2str(l_minsum, l_curcode));
        end if;
      end if;

      if p_mode = 'RW' then
        -- проверка мобильного телефона при досрочном расторжении / только если процедура досрочного запускается в режиме RW

        begin
          select count(*)
            into l_inherited
            from dpt_inheritors
           where dpt_id = p_dptid
             and inherit_state = 1;
        exception
          when no_data_found then
            l_inherited := 0;
        end;
        l_valid_mobphone := bars.verify_cellphone_byrnk(l_rnk);

        if l_valid_mobphone = 0 and p_fullpay = 1 and l_inherited = 0 then
          -- В картці клієнта не заповнено або невірно заповнено мобільний телефон
          bars_error.raise_nerror('CAC', 'ERROR_MPNO');
          raise_application_error(-20001,
                                  'ERR:  В картці клієнта не заповнено або невірно заповнено мобільний телефон! Заповніть корректний моб.телефон в картці клієнта і спробуйте знову.',
                                  true);
        else
          -- если проверка телефона дает 1 - то штрафуем
          -- поиск счета проц.расходов для возврата излишне начисленных процентов
          l_expaccid2 := dpt.get_expenseacc(p_dptype  => l_vidd,
                                            p_balacc  => l_dptaccrow.nbs,
                                            p_curcode => l_dptaccrow.kv,
                                            p_branch  => l_dptaccrow.branch,
                                            p_penalty => 1);

          bars_audit.trace('%s счет расходов для возврата штрафа = %s',
                           title,
                           to_char(l_expaccid2));

          -- пошук рахунка для утримання податку з нарахованих відсотків
          begin
            select a.acc
              into l_taxaccid
              from accounts a
             where nls = nbs_ob22_null('3622', '37', l_dptaccrow.branch)
               and kv = gl.baseval
               and dazs is null;
          exception
            when others then
              l_taxaccid := null;
          end;

          bars_audit.trace('%s рахунок для повернення утриманого податку = %s',
                           title,
                           to_char(l_taxaccid));

          -- пошук рахунка повернення утриманого податку з нарахованих відсотків
          begin
            select a.acc
              into l_taxaccid2
              from accounts a
             where nls = nbs_ob22_null('3522', '29', l_dptaccrow.branch)

               and kv = gl.baseval
               and dazs is null;
          exception
            when others then
              l_taxaccid2 := null;
          end;

          bars_audit.trace('%s рахунок для повернення утриманого податку = %s',
                           title,
                           to_char(l_taxaccid2));
          --(Військовий Збір)

          -- пошук рахунка для утримання податку (Військовий Збір)  з нарахованих відсотків
          begin
            select a.acc
              into l_taxaccid_mil
              from accounts a
             where nls = nbs_ob22_null('3622', '36', l_dptaccrow.branch)
               and kv = gl.baseval
               and dazs is null;
          exception
            when others then
              l_taxaccid_mil := null;
          end;

          bars_audit.trace('%s рахунок для повернення утриманого податку (Військовий Збір) = %s',
                           title,
                           to_char(l_taxaccid_mil));

          -- пошук рахунка повернення утриманого податку (Військовий Збір) з нарахованих відсотків
          begin
            select a.acc
              into l_taxaccid2_mil
              from accounts a
             where nls = nbs_ob22_null('3522', '30', l_dptaccrow.branch)

               and kv = gl.baseval
               and dazs is null;
          exception
            when others then
              l_taxaccid2_mil := null;
          end;

          bars_audit.trace('%s рахунок для повернення утриманого податку (Військовий Збір) = %s',
                           title,
                           to_char(l_taxaccid2_mil));
          -- вызов внутренней процедуры формирования пакета документов при част./полном снятии суммы со вклада
          intl_make_penaltydocs(p_dptid         => p_dptid, -- идентификатор договора
                                p_dptaccid      => l_dptaccid, -- внутр.№ депозитного счета
                                p_intaccid      => l_intaccid, -- внутр.№ процентного счета
                                p_amraccid      => l_amraccid, -- внутр.№ счета амортизации
                                p_expaccid      => l_expaccid, -- внутр.№ счета расходов
                                p_expaccid2     => l_expaccid2, -- внутр.№ счета расходов для возврата штрафа
                                p_taxaccid      => l_taxaccid, -- внутр.№ счета утримання податку з нарах. %% по штрафній ставці
                                p_taxaccid2     => l_taxaccid2, -- внутр.№ счета повернення утриманого податку при штрафуванні
                                p_taxaccid_mil  => l_taxaccid_mil, -- внутр.№ счета утримання податку (Військовий Збір) з нарах. %% по штрафній ставці
                                p_taxaccid2_mil => l_taxaccid2_mil, -- внутр.№ счета повернення утриманого податку (Військовий Збір) при штрафуванні
                                p_amount        => l_dptamount, -- сумма депозита к выплате  (заявленная, нужна для комисс.операций)
                                p_int2payoff    => l_int2pay, -- сумма процентов к выплате (на сумму снятия по штрафной ставке)
                                p_intdetails    => l_details, -- назначение платежа по начислению %%
                                p_intamount     => l_penyap, -- сумма штрафа для списания с проц.счета
                                p_dptamount     => l_penyad, -- сумма штрафа для списания с деп.счета на 6399
                                p_amramount     => l_penyaa, -- сумма штрафа для списания с деп.счета на 3500
                                p_rkoamount     => l_penyac, -- сумма комиссии за РКО
                                p_vetamount     => l_penyav, -- сумма комиссии за прием ветхих
                                p_fullpay       => p_fullpay, -- 1=расторжение, 0=част.снятие
                                p_tax2ret       => l_tax2ret, -- сума податку для повернення (утриманого з нарахованих %% по основній  ставці)
                                p_tax2pay       => l_tax2pay, -- сума податку для утримання  (з нарахованих %% до виплати по штрафній ставці)
                                p_tax2ret_mil   => l_tax2ret_mil, -- сума податку (Військовий Збір) для повернення (утриманого з нарахованих %% по основній  ставці)
                                p_tax2pay_mil   => l_tax2pay_mil); -- сума податку (Військовий Збір)  для утримання  (з нарахованих %% до виплати по штрафній ставці)

          if l_avans = 1 and p_fullpay = 1 then
            -- окончательная амортизация выплаченных авансом процентов
            intl_calc_interest(p_mode      => p_mode, -- RO - расчет, RW - проводки
                               p_date      => p_date, -- дата списания средств
                               p_accrec    => l_amraccrow, -- параметры счета амортизации
                               p_intid     => l_amrintid, -- код процентной карточки (=0)
                               p_stopdate  => l_enddate - 1, -- граничная дата начисления
                               p_curcode   => l_curcode, -- символьный код валюты депозита
                               p_details   => l_details, -- назначение платежа
                               p_dptamount => null, -- сумма начисления
                               p_intamount => l_amramount); -- сумма амортизированных процентов
            bars_audit.trace('%s сумма доамортизации = %s',
                             title,
                             to_char(l_amramount));
          end if;

          -- Постанова правління АТ «Ощадбанк» від 24.02.2014 року № 128.
          bars.dpt_ret_early(3, p_dptid);

          close_sto_argmnt(p_dptid    => p_dptid,
                           p_accid    => null,
                           p_argmntid => null);
        end if;
      end if;
    end if;

    bars_audit.trace('%s ИТОГО: штраф = %s, комиссия за РКО/инкассо = %s / %s',
                     title,
                     to_char(p_penalty),
                     to_char(l_penyac),
                     to_char(l_penyav));

    bars_audit.trace('%s ИТОГО: деп.счет: к списанию - %s, к выплате - %s',
                     title,
                     to_char(l_penyad + l_penyaa),
                     to_char(p_dptrest));

    bars_audit.trace('%s ИТОГО: проц.счет: к списанию - %s, к выплате - %s',
                     title,
                     to_char(l_penyap),
                     to_char(p_intrest));

    bars_audit.trace('%s ИТОГО: сума утриманого податку для повернення - %s',
                     title,
                     to_char(l_tax2ret));

    str2txt(p_details, bars_msg.get_msg(g_modcode, 'GLPENALTY_TOTAL')); -- ИТОГ
    str2txt(p_details,
            bars_msg.get_msg(g_modcode,
                             'GLPENALTY_TOTALPENALTY',
                             num2str(p_penalty, l_curcode))); -- сумма штрафа
    str2txt(p_details,
            bars_msg.get_msg(g_modcode,
                             'GLPENALTY_TOTALCMSRKO',
                             num2str(l_penyac, l_curcode))); -- комиссия за РКО
    str2txt(p_details,
            bars_msg.get_msg(g_modcode,
                             'GLPENALTY_TOTALCMSVET',
                             num2str(l_penyav, l_curcode))); -- комиссия за инкассо
    str2txt(p_details,
            bars_msg.get_msg(g_modcode,
                             'GLPENALTY_TOTALDEP2RET',
                             num2str(l_penyad + l_penyaa, l_curcode))); -- удержано депозита
    str2txt(p_details,
            bars_msg.get_msg(g_modcode,
                             'GLPENALTY_TOTALINT2RET',
                             num2str(l_penyap, l_curcode))); -- удержано процентов
    str2txt(p_details,
            bars_msg.get_msg(g_modcode,
                             'GLPENALTY_TOTALDTP2PAY',
                             num2str(p_dptrest, l_curcode))); -- депозит к выплате
    str2txt(p_details,
            bars_msg.get_msg(g_modcode,
                             'GLPENALTY_TOTALINT2PAY',
                             num2str(p_intrest, l_curcode))); -- процентов к выплате

    if (p_mode = 'RW') and (ebp.get_archive_docid(p_dptid) > 0) then
      -- відправка SMS повідомлення про дострокове повернення депозиту
      send_sms(l_rnk,
               'Depozyt N' || to_char(p_dptid) ||
               ' bulo dostrokovo poverneno.'); --||' u sumi '|| Amount2Str(p_dptrest, l_dptaccrow.kv)  вилучено, оскільки передавало всю суму депозиту в разі часткового зняття. після візування приходить смс про к-ть реально виплачених коштів.
    end if;

    bars_audit.trace('%s exit, %s', title, p_details);

    -- вертаєм рівень деталізації "по замовчуванню"
    if (l_log_level < bars_audit.log_level_trace) then

      bars_audit.set_log_level(l_log_level);

      bars_audit.info(title || 'Повернено рівень деталізації повідомлень ' ||
                      to_char(l_log_level) || ' з ' ||
                      to_char(bars_audit.get_log_level()));
    end if;

  end global_penalty_ex;

  --
  -- начисление процентов "наперед" по авансовому вкладу
  --
  procedure advance_makeint(p_dptid in dpt_deposit.deposit_id%type) is
    title     varchar2(60) := 'dptweb.advancemakeint:';
    l_dptrow  dpt_deposit%rowtype;
    l_amrmetr dpt_vidd.amr_metr%type;
    l_nazn    oper.nazn%type;
    l_advdat  date;
    l_amount  number(38);
    l_errflg  boolean := false;
  begin

    bars_audit.trace('%s entry, dptid => %s', title, to_char(p_dptid));

    begin
      select * into l_dptrow from dpt_deposit where deposit_id = p_dptid;
    exception
      when no_data_found then
        bars_error.raise_nerror(g_modcode,
                                'DPT_NOT_FOUND',
                                to_char(p_dptid));
    end;
    bars_audit.trace('%s deposit type № %s',
                     title,
                     to_char(l_dptrow.vidd));

    select amr_metr
      into l_amrmetr
      from dpt_vidd
     where vidd = l_dptrow.vidd;
    bars_audit.trace('%s amortization method № %s',
                     title,
                     to_char(l_amrmetr));

    if nvl(l_amrmetr, 0) != 4 then
      -- амортизационный
      -- для вклада не предусмотрено авансовое начисление процентов
      bars_error.raise_nerror(g_modcode,
                              'ADVANCE_MAKEINT_DENIED',
                              l_dptrow.nd,
                              to_char(l_dptrow.datz, 'dd.mm.yyyy'),
                              to_char(p_dptid));
    end if;

    -- граничная дата авансового начисления  (пока так)
    l_advdat := l_dptrow.dat_end - 1;
    bars_audit.trace('%s advance stopintdate - %s',
                     title,
                     to_char(l_advdat, 'dd.mm.yyyy'));

    -- Авансовое перечисление процентов по договору № ... от ...
    l_nazn := substr(bars_msg.get_msg(g_modcode, 'ADVANCE_MAKEINT_DETAILS1') || ' ' ||
                     l_dptrow.nd || ' ' ||
                     bars_msg.get_msg(g_modcode, 'ADVANCE_MAKEINT_DETAILS2') || ' ' ||
                     to_char(l_dptrow.datz, 'dd/mm/yyyy'),
                     1,
                     160);

    bars_audit.trace('%s advance makeint details - %s', title, l_nazn);

    insert into int_queue
      (kf,
       branch,
       deal_id,
       deal_num,
       deal_dat,
       cust_id,
       int_id,
       acc_id,
       acc_num,
       acc_cur,
       acc_nbs,
       acc_name,
       acc_iso,
       acc_open,
       acc_amount,
       int_details,
       int_tt,
       mod_code)
      select /*+ ORDERED*/
       a.kf,
       a.branch,
       l_dptrow.deposit_id,
       l_dptrow.nd,
       l_dptrow.datz,
       l_dptrow.rnk,
       i.id,
       a.acc,
       a.nls,
       a.kv,
       a.nbs,
       substr(a.nms, 1, 38),
       t.lcv,
       a.daos,
       null,
       l_nazn,
       nvl(i.tt, '%%1'),
       'DPT'
        from accounts a, int_accn i, tabval t
       where a.acc = l_dptrow.acc
         and a.acc = i.acc
         and i.id = 1
         and a.kv = t.kv
         and a.ostc = a.ostb
         and a.ostc > 0
         and nvl(i.acr_dat, a.daos) < l_advdat;

    if sql%rowcount = 0 then
      bars_audit.trace('%s nothing to interest', title);
    else
      make_int(p_dat2      => l_advdat, -- граничная дата начисления процентов
               p_runmode   => 1, -- режим запуска (0-начисление, 1-оплата)
               p_runid     => 0, -- № запуска
               p_intamount => l_amount, -- сумма начисленных процентов
               p_errflg    => l_errflg); -- флаг ошибки

      bars_audit.trace('%s interest amount - %s', title, to_char(l_amount));

      if l_errflg then
        -- ошибка авансового начисления процентов по вкладу
        bars_error.raise_nerror(g_modcode,
                                'ADVANCE_MAKEINT_FAILED',
                                l_dptrow.nd,
                                to_char(l_dptrow.datz, 'dd.mm.yyyy'),
                                to_char(p_dptid),
                                sqlerrm);
      end if;
    end if;

  end advance_makeint;

  --
  -- расчет граничной даты для переоформления и пересмотра ставки относительно текущей даты
  --
  function get_extdatex(p_bdate   in date, -- текущая дата
                        p_dptype  in dpt_vidd.vidd%type, -- код вида вклада
                        p_workday in number) -- гран.дата - рабочий день(1)/ любой день(0)
   return date is
    title     varchar2(60) := 'dptweb.getextdateX:';
    l_ctrlday varchar(2);
    l_date    date;
  begin

    bars_audit.trace('%s entry, bdate=>%s, dptype=>%s, workday=>%s',
                     title,
                     to_char(p_bdate, 'dd.mm.yyyy'),
                     to_char(p_dptype),
                     to_char(p_workday));

    begin
      select substr(val, 1, 2)
        into l_ctrlday
        from dpt_vidd_params
       where vidd = p_dptype
         and tag = ctrlday_extcncl;

      -- первый день прошлого месяца
      l_date := add_months(last_day(p_bdate), -2) + 1;
      while to_char(l_date, 'yyyymm') < to_char(p_bdate, 'yyyymm') and
            to_char(l_date, 'dd') != l_ctrlday loop
        l_date := l_date + 1;
      end loop;

    exception
      when no_data_found then
        l_date := p_bdate;
    end;

    -- l_date := last_day(p_bdate);
    -- while to_char(l_date, 'mm')  = to_char(p_bdate, 'mm')
    --   and to_char(l_date, 'dd') != l_ctrlday
    -- loop
    --     l_date := l_date - 1;
    -- end loop;

    if p_workday = 1 then
      begin
        select dat_next_u(l_date, 1)
          into l_date
          from holiday
         where kv = gl.baseval
           and holiday = l_date;
      exception
        when no_data_found then
          null;
      end;
    end if;

    bars_audit.trace('%s exit with %s',
                     title,
                     to_char(l_date, 'dd.mm.yyyy'));
    return l_date;

  end get_extdatex;

  --
  -- создание запроса на отказ вкладчика от переоформления вклада
  --
  procedure fix_extcancel(p_dptid in dpt_extrefusals.dptid%type, -- ідентифікатор вкладу
                          p_state in dpt_extrefusals.req_state%type default null -- статус запиту
                          ) is
    title constant varchar2(60) := 'dptweb.fixextcncl:';
    l_dptnum  dpt_deposit.nd%type;
    l_dptdat  dpt_deposit.datz%type;
    l_branch  dpt_deposit.branch%type;
    l_machine dpt_extrefusals.req_machine%type;
  begin

    bars_audit.trace('%s entry, dptid=>%s', title, to_char(p_dptid));

    begin
      select nd, datz, branch
        into l_dptnum, l_dptdat, l_branch
        from dpt_deposit
       where deposit_id = p_dptid;
    exception
      when no_data_found then
        bars_error.raise_nerror(g_modcode, g_dptnotfound, to_char(p_dptid));
    end;

    -- l_machine := substr(sys_context('userenv', 'terminal'), 1, 254);
    l_machine := substr(nvl(bars_audit.get_machine,
                            sys_context('bars_global', 'host_name')),
                        1,
                        254);
    if l_machine is null then
      l_machine := 'NOT AVAILABLE';
    end if;

    begin
      insert into dpt_extrefusals
        (dptid,
         branch,
         req_userid,
         req_bnkdat,
         req_sysdat,
         req_machine,
         req_state)
      values
        (p_dptid, l_branch, gl.auid, gl.bdate, sysdate, l_machine, p_state);

      bars_audit.info(bars_msg.get_msg(g_modcode,
                                       'FIX_EXTCANCEL_DONE',
                                       l_dptnum,
                                       to_char(l_dptdat, 'dd.mm.yyyy'),
                                       to_char(p_dptid)));
    exception
      when dup_val_on_index then
        bars_error.raise_nerror(g_modcode,
                                'FIX_EXTCANCEL_DUPLICATE',
                                l_dptnum,
                                to_char(l_dptdat, 'dd.mm.yyyy'),
                                to_char(p_dptid));
      when others then
        bars_error.raise_nerror(g_modcode,
                                'FIX_EXTCANCEL_FAILED',
                                l_dptnum,
                                to_char(l_dptdat, 'dd.mm.yyyy'),
                                to_char(p_dptid),
                                sqlerrm);
    end;

    bars_audit.trace('%s exit', title);

  end fix_extcancel;

  --
  -- подтверждение запроса на отказ вкладчика от переоформления вклада
  --
  procedure verify_extcancel(p_dptid  in dpt_extrefusals.dptid%type, -- идентификатор вклада
                             p_state  in dpt_extrefusals.req_state%type, -- статус (1=виза, -1=сторно)
                             p_reason in dpt_extrefusals.vrf_reason%type) -- причина сторно
   is
    title constant varchar2(60) := 'dptweb.vrfextcncl:';
    l_dptnum    dpt_deposit.nd%type;
    l_dptdat    dpt_deposit.datz%type;
    l_requserid dpt_extrefusals.req_userid%type;
    l_vrfuserid dpt_extrefusals.vrf_userid%type;
    l_machine   dpt_extrefusals.req_machine%type;
  begin

    bars_audit.trace('%s entry, dptid=>%s, state=>%s, reason=>%s',
                     title,
                     to_char(p_dptid),
                     to_char(p_state),
                     p_reason);

    begin
      select nd, datz
        into l_dptnum, l_dptdat
        from dpt_deposit
       where deposit_id = p_dptid;
    exception
      when no_data_found then
        bars_error.raise_nerror(g_modcode, g_dptnotfound, to_char(p_dptid));
    end;

    l_vrfuserid := gl.auid;

    begin
      select req_userid
        into l_requserid
        from dpt_extrefusals
       where dptid = p_dptid
         and req_state is null
         for update of req_state;
    exception
      when no_data_found or too_many_rows then
        bars_error.raise_nerror(g_modcode,
                                'VERIFY_EXTCANCEL_NOT_FOUND',
                                l_dptnum,
                                to_char(l_dptdat, 'dd.mm.yyyy'),
                                to_char(p_dptid));
    end;

    if l_requserid = l_vrfuserid then
      bars_error.raise_nerror(g_modcode,
                              'VERIFY_EXTCANCEL_DENIED',
                              l_dptnum,
                              to_char(l_dptdat, 'dd.mm.yyyy'),
                              to_char(p_dptid));

    end if;

    if nvl(p_state, 0) not in (1, -1) then
      bars_error.raise_nerror(g_modcode,
                              'VERIFY_EXTCANCEL_INVALIDSTATE',
                              nvl(to_char(p_state), '_'),
                              l_dptnum,
                              to_char(l_dptdat, 'dd.mm.yyyy'),
                              to_char(p_dptid));
    end if;

    -- l_machine := substr(sys_context('userenv', 'terminal'), 1, 254);
    l_machine := substr(nvl(bars_audit.get_machine,
                            sys_context('bars_global', 'host_name')),
                        1,
                        254);
    if l_machine is null then
      l_machine := 'NOT AVAILABLE';
    end if;

    begin
      update dpt_extrefusals
         set req_state   = p_state,
             vrf_userid  = l_vrfuserid,
             vrf_bnkdat  = gl.bdate,
             vrf_sysdat  = sysdate,
             vrf_machine = l_machine,
             vrf_reason  = substr(p_reason, 1, 100)
       where dptid = p_dptid
         and req_state is null;
      bars_audit.info(bars_msg.get_msg(g_modcode,
                                       (case when p_state = 1 then
                                        'VERIFY_EXTCANCEL_DONE' else
                                        'VERIFY_EXTCANCEL_BACK' end),
                                       l_dptnum,
                                       to_char(l_dptdat, 'dd.mm.yyyy'),
                                       to_char(p_dptid)));
    exception
      when others then
        bars_error.raise_nerror(g_modcode,
                                'VERIFY_EXTCANCEL_FAILED',
                                l_dptnum,
                                to_char(l_dptdat, 'dd.mm.yyyy'),
                                to_char(p_dptid),
                                sqlerrm);
    end;

    bars_audit.trace('%s exit', title);

  end verify_extcancel;

  --
  -- расчет даты выполняения и граничной даты начисления процентов в конце месяца
  --
  procedure get_mnthintdates(p_bnkdate in date, -- текущая банк.дата
                             p_isfixed in char, -- признак срочного вклада (Y-срочный, N-до востреб.)
                             p_valdate out date, -- дата выполнения начисления процентов в конце месяца
                             p_acrdate out date, -- граничная дата начисления процентов в конце месяца
                             p_mode    in number) -- режим запуска функции
   is
    title constant varchar2(60) := 'dptweb.getmnthintdates:';
    l_lastbnkdate date;
    l_lastsysdate date;
  begin

    bars_audit.trace('%s entry, bdate=>%s, isfixed=>%s, mode=>%s',
                     title,
                     to_char(p_bnkdate, 'dd.mm.yyyy'),
                     p_isfixed,
                     to_char(p_mode));

    l_lastsysdate := last_day(p_bnkdate); -- последний календарный день месяца
    l_lastbnkdate := dat_last(p_bnkdate, null); -- последний рабочий день месяца
    p_valdate     := dat_next_u(l_lastbnkdate, -p_mode); -- (пред)последний рабочий день месяца
    p_acrdate     := l_lastsysdate; -- последний календарный день месяца

    bars_audit.trace('%s exit, valdate=>%s, acrdate=>%s',
                     title,
                     to_char(p_valdate, 'dd.mm.yyyy'),
                     to_char(p_acrdate, 'dd.mm.yyyy'));

  end get_mnthintdates;

  --
  -- расчет суммы процентов к выплате
  --
  procedure get_intpayoff_amount(p_dptid  in dpt_deposit.deposit_id%type, -- идентификатор вклада
                                 p_amount in out number) -- сумма к выплате
   is
    title      constant varchar2(60) := 'dptweb.getintpayoffamount:';
    l_bdate    constant date := gl.bdate;
    l_genintid constant int_accn.id%type := 1;
    l_altintid constant int_accn.id%type := 5; --3;
    l_vidd       dpt_vidd.vidd%type;
    l_datbeg     dpt_deposit.dat_begin%type;
    l_datend     dpt_deposit.dat_end%type;
    l_freq       dpt_deposit.freq%type;
    l_depacc     accounts.acc%type;
    l_intacc     accounts.acc%type;
    l_intsal     accounts.ostb%type;
    l_iso        tabval.lcv%type;
    l_acrdat     date;
    l_avans      number(1);
    l_extend     number(1);
    l_mnthcnt    number(1);
    l_amount     accounts.ostc%type;
    l_row        accounts%rowtype;
    l_payed      saldoa.dos%type;
    l_overint    number;
    l_intpaydate date;
    --l_fromASVO number;
  begin

    bars_audit.trace('%s entry, dptid=>%s,amount=>%s',
                     title,
                     to_char(p_dptid),
                     to_char(p_amount));

    begin
      select v.vidd,
             decode(v.amr_metr, 0, 0, 1),
             d.dat_begin,
             d.dat_end,
             d.freq,
             i.acc,
             i.acra,
             a.ostb,
             i.acr_dat,
             t.lcv,
             decode(nvl(d.cnt_dubl, 0), 0, 0, 1)
        into l_vidd,
             l_avans,
             l_datbeg,
             l_datend,
             l_freq,
             l_depacc,
             l_intacc,
             l_intsal,
             l_acrdat,
             l_iso,
             l_extend
        from dpt_deposit d, dpt_vidd v, int_accn i, accounts a, tabval t
       where d.vidd = v.vidd
         and d.kv = t.kv
         and d.acc = i.acc
         and i.id = l_genintid
         and i.acra = a.acc
         and d.deposit_id = p_dptid;
    exception
      when no_data_found then
        bars_error.raise_nerror(g_modcode, g_dptnotfound, to_char(p_dptid));
    end;
    bars_audit.trace('%s depacc/intacc=%s/%s, freq=%s, avans=%s, extend=%s, term=%s-%s',
                     title,
                     to_char(l_depacc),
                     to_char(l_intacc),
                     to_char(l_freq),
                     to_char(l_avans),
                     to_char(l_extend),
                     to_char(l_datbeg, 'dd.mm.yy'),
                     to_char(l_datend, 'dd.mm.yy'));

    -- проверка допустимости выплаты процентов по вкладу (1-допустима, 0-недопустима)
    if 0 = dpt.payoff_enable(p_intacc => l_intacc, -- внутр.№ счета начисл.процентов
                             p_freq   => l_freq, -- период-ть выплаты процентов
                             p_avans  => l_avans, -- признак авансовой выплаты процентов
                             p_begdat => l_datbeg, -- дата начала действия вклада
                             p_enddat => l_datend, -- дата окончания действия вклада
                             p_curdat => l_bdate, -- банковская дата
                             p_extend => l_extend) -- признак переоформленного вклада
     then
      bars_audit.trace('%s interest payoff denied', title);
      l_amount := 0;
    else

      bars_audit.trace('%s intacc saldo = %s', title, to_char(l_intsal));

      select * into l_row from accounts where acc = l_depacc;

      if (l_avans = 1 and l_freq in (5, 7) and l_datend > l_bdate) then

        bars_audit.trace('%s advance deposit with freq = %s',
                         title,
                         to_char(l_freq));

        if l_freq = 7 then
          -- выплата на 1 квартал вперед
          l_mnthcnt := 3 *
                       (1 + trunc(months_between(l_bdate, l_datbeg) / 3));
        else
          -- выплата на 1 месяц вперед
          l_mnthcnt := 1 *
                       (1 + trunc(months_between(l_bdate, l_datbeg) / 1));
        end if;
        l_acrdat := add_months(l_datbeg, l_mnthcnt) - 1;
        l_acrdat := least(l_acrdat, l_datend - 1);
        bars_audit.trace('%s acrdat = %s',
                         title,
                         to_char(l_acrdat, 'dd.mm.yyyy'));

        -- заполнение альтернативной процентной карточки  (id = 3)
        intl_fill_altintcard(p_dptaccid  => l_depacc, -- внутр.номер деп.счета
                             p_genintid  => l_genintid, -- код основной карточки
                             p_altintid  => l_altintid, -- код альтерн.карточки
                             p_intdat1   => l_datbeg, -- дата предыдущего начисления
                             p_intdat2   => l_acrdat, -- граничная дата начисления
                             p_penyadate => null, -- дата установки альт.ставки
                             p_penyarate => null); -- значение альтернат.ставки
        -- расчет начисленных процентов по l_acrdat включительно
        intl_calc_interest(p_mode      => 'RO', -- только расчет процентов
                           p_date      => l_bdate, -- текущая банк.дата
                           p_accrec    => l_row, -- параметры деп.счета
                           p_intid     => l_altintid, -- код альтерн.карточки
                           p_stopdate  => l_acrdat, -- граничная дата начисления
                           p_curcode   => l_iso, -- симв.код валюты
                           p_details   => null, -- назначение платежа
                           p_dptamount => null, -- сумма депозита
                           p_intamount => l_amount); -- сума начисленных процентов
        -- очистка альтернативной %-ной карточки (id = 3)
        intl_clear_altintcard(p_dptaccid => l_depacc,
                              p_altintid => l_altintid);

        l_amount := nvl(round(l_amount), 0);
        bars_audit.trace('%s total interest = %s',
                         title,
                         to_char(l_amount));

        -- сумма всех выплат
        select nvl(sum(dos), 0)
          into l_payed
          from saldoa
         where acc = l_intacc
           and fdat >= l_datbeg
           and fdat <= l_bdate;
        bars_audit.trace('%s total payed = %s', title, to_char(l_payed));

        l_amount := greatest(l_amount - l_payed, 0);
        bars_audit.trace('%s rest to payoff = %s',
                         title,
                         to_char(l_amount));

        -- учитываем план.остаток на счете (абы не выдать больше чем есть)
        l_amount := least(l_amount, l_intsal);

      else

        bars_audit.trace('%s standart deposit', title);

        -- сумма процентов к снятию = план.остаток минус "излишек" начисленных
        -- процентов (%% с даты ближ.выплаты по дату посл.начисления)
        l_intpaydate := dpt.get_intpaydate(p_date   => l_bdate,
                                           p_datbeg => l_datbeg,
                                           p_datend => l_datend,
                                           p_freqid => l_freq,
                                           p_advanc => l_avans,
                                           p_extend => l_extend,
                                           p_nocash => 0);
        if l_acrdat > l_intpaydate then
          bars_audit.trace('%s overpayed int...', title);
          intl_clear_altintcard(p_dptaccid => l_depacc,
                                p_altintid => l_altintid);
          -- заполнение альтернативной процентной карточки  (id = 3)
          intl_fill_altintcard(p_dptaccid  => l_depacc,
                               p_genintid  => l_genintid,
                               p_altintid  => l_altintid,
                               p_intdat1   => l_intpaydate - 1,
                               p_intdat2   => l_acrdat,
                               p_penyadate => null,
                               p_penyarate => null);
          -- расчет начисленных процентов по l_acrdat включительно
          intl_calc_interest(p_mode      => 'RO',
                             p_date      => l_bdate,
                             p_accrec    => l_row,
                             p_intid     => l_altintid,
                             p_stopdate  => l_acrdat,
                             p_curcode   => l_iso,
                             p_details   => null,
                             p_dptamount => null,
                             p_intamount => l_overint);
          l_overint := nvl(round(l_overint), 0);

          -- за мінусом утриманого податку
          l_overint := l_overint - round(l_overint * get_tax_rate());

          -- очистка альтернативной %-ной карточки (id = 3)
          intl_clear_altintcard(p_dptaccid => l_depacc,
                                p_altintid => l_altintid);
        else
          l_overint := 0;
        end if;
        -- долбаная миграция с АСВО
        /* begin
          select to_number(w.value)
            into l_fromASVO
            from accountsw  w,
                 (select acc, min(fdat) minkosdat
                    from saldoa
                   where acc = l_depacc
                     and kos > 0
                   group by acc) dep,
                 (select acc,
                         min(case when kos > 0 then fdat else null end) minkosdat,
                         max(case when dos > 0 then fdat else null end) maxdosdat
                    from saldoa
                   where acc = l_intacc
                   group by acc) prc
           where dep.minkosdat  = prc.minkosdat
             and dep.minkosdat <= l_acrdat
             and dep.minkosdat >  l_datbeg
             and prc.maxdosdat is null
             and w.acc         = dep.acc
             and w.tag         = 'ZPR_D';
          bars_audit.trace('%s ZPR_D = %s', title, to_char(l_fromASVO));
          if l_fromASVO > 0 then
              l_overint := greatest(l_intsal - l_fromASVO, 0);
          end if;
        exception
          when others then
            l_fromASVO := 0;
        end;   */
        bars_audit.trace('%s overint = %s', title, to_char(l_overint));

        -- описати логіку (поки не понятконо (для авнсових не дає виплатити))
        if nvl(p_amount, 0) = 0 then
          l_amount := greatest(l_intsal - l_overint, 0);
        else
          l_amount := least(p_amount, l_intsal - l_overint);
        end if;

      end if;

    end if;

    bars_audit.trace('%s interest payoff amount = %s',
                     title,
                     to_char(l_amount));

    p_amount := l_amount;
    bars_audit.trace('%s exit with %s', title, to_char(p_amount));

  end get_intpayoff_amount;

  --
  -- урегулирование начисленных и выплаченных авансом процентов
  --      при (досрочном) закрытии авансового вклада
  --
  procedure advance_balsettlement(p_dptid  in dpt_deposit.deposit_id%type,
                                  p_bdate  in dpt_deposit.dat_end%type,
                                  p_branch in dpt_deposit.branch%type,
                                  p_mode   in char,
                                  p_expbal out number,
                                  p_amrbal out number) is
    title    constant varchar2(60) := 'dptweb.advbalstlm:';
    genintid constant int_accn.id%type := 1; -- код основной проц.карточки
    altintid constant int_accn.id%type := 5; -- код временной проц.карточки
    l_mfo        banks.mfo%type := gl.amfo;
    l_userid     staff.id%type := gl.auid;
    l_dptid      dpt_deposit.deposit_id%type;
    l_dptnum     dpt_deposit.nd%type;
    l_dptdat     dpt_deposit.datz%type;
    l_datbeg     dpt_deposit.dat_begin%type;
    l_datend     dpt_deposit.dat_end%type;
    l_curcode    tabval.lcv%type;
    l_dptaccid   accounts.acc%type;
    l_amraccid   accounts.acc%type;
    l_expaccid   accounts.acc%type;
    l_dptaccrow  accounts%rowtype;
    l_expaccint  number;
    l_amraccint  number;
    l_total_int  number;
    l_int        number;
    l_expaccintq number;
    l_intdat2    date;
    l_accrecd    dpt_web.acc_rec;
    l_accrece    dpt_web.acc_rec;
    l_accreca    dpt_web.acc_rec;
    l_refe       oper.ref%type;
    l_refa       oper.ref%type;
    l_tt         oper.tt%type;
    l_details1   oper.nazn%type;
    l_details2   oper.nazn%type;
    l_errflg     boolean;
    l_errmsg     varchar2(3000);
  begin

    bars_audit.trace('%s entry, dptid => %s, bdate => %s, branch => %s',
                     title,
                     to_char(p_dptid),
                     to_char(p_bdate, 'dd.mm.yyyy'),
                     p_branch);
    begin
      select d.deposit_id,
             d.nd,
             d.datz,
             d.dat_begin,
             d.dat_end,
             i.acc,
             i.acra,
             i.acrb,
             t.lcv
        into l_dptid,
             l_dptnum,
             l_dptdat,
             l_datbeg,
             l_datend,
             l_dptaccid,
             l_amraccid,
             l_expaccid,
             l_curcode
        from dpt_deposit d, int_accn i, dpt_vidd v, tabval t, accounts a
       where d.acc = i.acc
         and i.id = 3
         and v.amr_metr > 0 -- авансовый
         and a.acc = i.acra
         and d.vidd = v.vidd
         and d.kv = t.kv
         and (p_mode = 'RO' or (p_mode = 'RW' --and i.acr_dat = i.stp_dat     -- проценты окончательно
             --and i.acr_dat = d.dat_end - 1 -- амортизированы
             and a.ostb < 0))
         and d.deposit_id = p_dptid;
    exception
      when no_data_found then
        p_expbal := 0;
        p_amrbal := 0;
        return;
    end;
    bars_audit.trace('%s depacc № %s, amracc № %s, expacc № %s',
                     title,
                     to_char(l_dptaccid),
                     to_char(l_amraccid),
                     to_char(l_expaccid));

    -- параметры депозитного счета + блокировка
    begin
      select *
        into l_dptaccrow
        from accounts
       where acc = l_dptaccid
         for update nowait;
    exception
      when no_data_found then
        bars_error.raise_nerror(g_modcode,
                                'DPTACC_NOT_FOUND',
                                bars_msg.get_msg(g_modcode,
                                                 'GLPENALTY_FULLDEALNUM',
                                                 l_dptnum,
                                                 to_char(l_dptdat,
                                                         'dd.mm.yyyy'),
                                                 to_char(l_dptid)));
    end;

    l_expaccint := 0;
    l_amraccint := 0;
    l_total_int := 0;

    for docs in (with tbl_docs as
                    (select d.fdat dat, sum(d.s) amount
                      from opldok d, opldok k
                     where d.ref = k.ref
                          --   and d.stmt  = k.stmt
                       and d.fdat = k.fdat
                       and d.sos = k.sos
                       and d.dk = 1 - k.dk
                       and d.sos = 5
                       and d.dk = 0
                       and d.acc = l_dptaccid
                       and k.acc in (l_amraccid, l_expaccid)
                       and d.fdat >= l_datbeg
                       and d.fdat <= l_datend
                     group by d.fdat)
                   select dat, amount
                     from tbl_docs
                   union all
                   select null, sum(amount)
                     from tbl_docs
                   having nvl (sum(amount), 0) != 0
                    order by 1) loop

      bars_audit.trace('%s %s at %s',
                       title,
                       to_char(docs.dat, 'dd.mm.yyyy'),
                       to_char(docs.amount));

      -- граничная дата начисления
      l_intdat2 := case
                     when docs.dat is null then
                      l_datend - 1
                     else
                      docs.dat - 1
                   end;
      bars_audit.trace('%s граничная дата начисления %s',
                       title,
                       to_char(l_intdat2, 'dd.mm.yyyy'));

      -- вызов внутренней процедуры очистки доп.процентной карточки (id = 5)
      intl_clear_altintcard(p_dptaccid => l_dptaccid,
                            p_altintid => altintid);

      -- вызов внутренней процедуры заполнения доп.процентной карточки и ставки
      intl_fill_altintcard(p_dptaccid  => l_dptaccid,
                           p_genintid  => genintid,
                           p_altintid  => altintid,
                           p_intdat1   => l_datbeg,
                           p_intdat2   => l_intdat2,
                           p_penyadate => null,
                           p_penyarate => null);

      -- вызов внутренней процедуры расчета суммы процентов (RO)
      intl_calc_interest(p_mode      => 'RO',
                         p_date      => p_bdate,
                         p_accrec    => l_dptaccrow,
                         p_intid     => altintid,
                         p_stopdate  => l_intdat2,
                         p_curcode   => l_curcode,
                         p_details   => null,
                         p_dptamount => docs.amount,
                         p_intamount => l_int);
      bars_audit.trace('%s interest amount = %s', title, to_char(l_int));

      -- вызов внутренней процедуры очистки доп.процентной карточки (id = 5)
      intl_clear_altintcard(p_dptaccid => l_dptaccid,
                            p_altintid => altintid);

      if docs.dat is not null then
        l_expaccint := l_expaccint + nvl(l_int, 0);
      else
        l_total_int := l_total_int + nvl(l_int, 0);
      end if;
      bars_audit.trace('%s expaccint/totalint = %s/%s',
                       title,
                       to_char(l_expaccint),
                       to_char(l_total_int));

    end loop; -- docs

    l_expaccint := round(l_expaccint);
    l_total_int := round(l_total_int);
    l_amraccint := l_total_int - l_expaccint;
    bars_audit.trace('%s expaccint/amraccint/totalint = %s/%s/%s',
                     title,
                     to_char(l_expaccint),
                     to_char(l_amraccint),
                     to_char(l_total_int));

    if p_mode = 'RW' and l_total_int > 0 then

      -- реквизиты счетов депозита/амортизации/расходов
      l_accrecd := search_acc_params(l_dptaccid);
      l_accreca := search_acc_params(l_amraccid);
      l_accrece := search_acc_params(l_expaccid);

      l_tt := get_tt(p_type     => dptop_avanspenalty,
                     p_interpay => 0,
                     p_cardpay  => 0,
                     p_currency => l_accrecd.acc_cur);

      if l_datend > p_bdate then
        l_details1 := substr(bars_msg.get_msg(g_modcode,
                                              'GLPENALTY_DOCDTL_EXP') ||
                             bars_msg.get_msg(g_modcode,
                                              'GLPENALTY_DOCDTL_FULL') ||
                             get_nazn(l_tt, p_dptid, null, null),
                             1,
                             160);
        l_details2 := substr(bars_msg.get_msg(g_modcode,
                                              'GLPENALTY_DOCDTL_AMR') ||
                             bars_msg.get_msg(g_modcode,
                                              'GLPENALTY_DOCDTL_FULL') ||
                             get_nazn(l_tt, p_dptid, null, null),
                             1,
                             160);
      else
        l_details1 := substr(bars_msg.get_msg(g_modcode,
                                              'GLPENALTY_DOCDTL_EXP') ||
                             bars_msg.get_msg(g_modcode,
                                              'GLPENALTY_DOCDTL_EXPIRED') ||
                             get_nazn(l_tt, p_dptid, null, null),
                             1,
                             160);
        l_details2 := substr(bars_msg.get_msg(g_modcode,
                                              'GLPENALTY_DOCDTL_AMR') ||
                             bars_msg.get_msg(g_modcode,
                                              'GLPENALTY_DOCDTL_EXPIRED') ||
                             get_nazn(l_tt, p_dptid, null, null),
                             1,
                             160);
      end if;

      -- возврат с депозитного счета на счет расходов банка
      if l_expaccint > 0 then
        if l_accrecd.acc_cur = l_accrece.acc_cur then
          l_expaccintq := l_expaccint;
        else
          l_expaccintq := round(gl.p_icurval(l_accrecd.acc_cur,
                                             l_expaccint,
                                             p_bdate));
        end if;
        paydoc(p_dptid    => l_dptid,
               p_vdat     => p_bdate,
               p_brancha  => p_branch,
               p_nlsa     => l_accrecd.acc_num,
               p_mfoa     => l_mfo,
               p_nama     => substr(l_accrecd.acc_name, 1, 38),
               p_ida      => l_accrecd.cust_idcode,
               p_kva      => l_accrecd.acc_cur,
               p_sa       => l_expaccint,
               p_branchb  => p_branch,
               p_nlsb     => l_accrece.acc_num,
               p_mfob     => l_mfo,
               p_namb     => substr(l_accrece.acc_name, 1, 38),
               p_idb      => l_accrece.cust_idcode,
               p_kvb      => l_accrece.acc_cur,
               p_sb       => l_expaccintq,
               p_nazn     => l_details1,
               p_nmk      => substr(l_accrecd.acc_name, 1, 38),
               p_tt       => l_tt,
               p_vob      => null,
               p_dk       => 1,
               p_sk       => null,
               p_userid   => l_userid,
               p_type     => dptop_avanspenalty, -- 52
               p_ref      => l_refe,
               p_err_flag => l_errflg,
               p_err_msg  => l_errmsg);
        bars_audit.trace('%s ref(2630-7041=%s)=%s',
                         title,
                         to_char(l_expaccint),
                         to_char(l_refe));
        if l_errflg then
          bars_error.raise_nerror(g_modcode, 'PAYDOC_ERROR', l_errmsg);
        end if;
      end if;

      -- возврат с депозитного счета на счет амортизации процентов
      if l_amraccint > 0 then
        paydoc(p_dptid    => l_dptid,
               p_vdat     => p_bdate,
               p_brancha  => p_branch,
               p_nlsa     => l_accrecd.acc_num,
               p_mfoa     => l_mfo,
               p_nama     => substr(l_accrecd.acc_name, 1, 38),
               p_ida      => l_accrecd.cust_idcode,
               p_kva      => l_accrecd.acc_cur,
               p_sa       => l_amraccint,
               p_branchb  => p_branch,
               p_nlsb     => l_accreca.acc_num,
               p_mfob     => l_mfo,
               p_namb     => substr(l_accreca.acc_name, 1, 38),
               p_idb      => l_accreca.cust_idcode,
               p_kvb      => l_accreca.acc_cur,
               p_sb       => l_amraccint,
               p_nazn     => l_details2,
               p_nmk      => substr(l_accrecd.acc_name, 1, 38),
               p_tt       => l_tt,
               p_vob      => null,
               p_dk       => 1,
               p_sk       => null,
               p_userid   => l_userid,
               p_type     => dptop_avanspenalty, -- 52
               p_ref      => l_refa,
               p_err_flag => l_errflg,
               p_err_msg  => l_errmsg);
        bars_audit.trace('%s ref(2630->3500=%s)=%s',
                         title,
                         to_char(l_amraccint),
                         to_char(l_refa));
        if l_errflg then
          bars_error.raise_nerror(g_modcode, 'PAYDOC_ERROR', l_errmsg);
        end if;
      end if;

    end if;

    p_expbal := l_expaccint;
    p_amrbal := l_amraccint;
    bars_audit.trace('%s exit with %s / %s',
                     title,
                     to_char(p_expbal),
                     to_char(p_amrbal));

  end advance_balsettlement;

  --
  -- окончательное урегулирование начисленных и выплаченных авансом процентов
  -- по авансовым вкладам, срок действия которых истек
  --
  procedure auto_advance_balsettlement(p_branch in dpt_deposit.branch%type, -- код подразделения
                                       p_bdate  in dpt_deposit.dat_begin%type, -- банковская дата
                                       p_dptid  in dpt_deposit.deposit_id%type) -- идентификатор вклада
   is
    title constant varchar2(60) := 'dptweb.autoadvbalstlm:';
    l_expbal number;
    l_amrbal number;
  begin

    bars_audit.trace('%s entry, branch=>%s, bdate=>%s, dptid=>%s',
                     title,
                     p_branch,
                     to_char(p_bdate, 'dd.mm.yyyy'),
                     to_char(p_dptid));

    for avans in (select d.deposit_id dptid
                    from dpt_deposit d, int_accn i, dpt_vidd v
                   where d.acc = i.acc
                     and i.id = 3
                     and v.amr_metr > 0
                     and d.vidd = v.vidd
                     and d.dat_end >= dat_next_u(p_bdate, -1) + 1
                     and d.dat_end <= p_bdate
                        --  and i.acr_dat    = i.stp_dat
                     and d.branch = p_branch
                     and d.deposit_id =
                         decode(p_dptid, 0, d.deposit_id, p_dptid)) loop
      bars_audit.trace('%s dptid № %s', title, to_char(avans.dptid));
      advance_balsettlement(avans.dptid,
                            p_bdate,
                            p_branch,
                            'RW',
                            l_expbal,
                            l_amrbal);
    end loop;

    bars_audit.trace('%s exit', title);

  end auto_advance_balsettlement;

  --
  -- установка бонуса для пролонгированных вкладов
  --
  procedure auto_extension_bonus(p_dptid  in dpt_jobs_log.dpt_id%type, -- идентификатор договора (0 - все)
                                 p_runid  in dpt_jobs_log.run_id%type, -- № запуска автомат.задания
                                 p_branch in dpt_jobs_log.branch%type, -- код подразделения
                                 p_bdate  in date) -- текущая банковская дата
   is
    title constant varchar2(60) := 'dptweb.autoextbonus: ';
    type t_extype is table of dpt_vidd_extypes%rowtype;
    l_extype  t_extype;
    l_cursor  integer;
    l_tmpnum  integer;
    l_plblock varchar2(3000);
  begin

    bars_audit.trace('%s entry, dptid=>%s, runid=>%s, branch=%s, bdate=>%s',
                     title,
                     to_char(p_dptid),
                     to_char(p_runid),
                     p_branch,
                     to_char(p_bdate));

    select *
      bulk collect
      into l_extype
      from dpt_vidd_extypes
     where bonus_proc is not null
       and bonus_rate is not null;

    for e in 1 .. l_extype.count loop

      bars_audit.trace('%s extype № %s, proc - %s',
                       title,
                       to_char(l_extype(e).id),
                       l_extype(e).bonus_proc);

      l_plblock := 'begin ' || l_extype(e).bonus_proc || '; end;';

      begin
        savepoint sp_extbonus;
        l_cursor := dbms_sql.open_cursor;
        dbms_sql.parse(l_cursor, l_plblock, dbms_sql.native);
        dbms_sql.bind_variable(l_cursor, 'extid', l_extype(e).id);
        dbms_sql.bind_variable(l_cursor, 'dptid', p_dptid);
        dbms_sql.bind_variable(l_cursor, 'runid', p_runid);
        dbms_sql.bind_variable(l_cursor, 'branch', p_branch);
        dbms_sql.bind_variable(l_cursor, 'date', p_bdate);
        l_tmpnum := dbms_sql.execute(l_cursor);
        dbms_sql.close_cursor(l_cursor);
      exception
        when others then
          rollback to sp_extbonus;
          dbms_sql.close_cursor(l_cursor);
          -- Ошибка установки бонуса для пролонгированных договоров подразделения %s
          bars_error.raise_nerror(g_modcode,
                                  'AUTOEXTBONUS_FAILED',
                                  p_branch,
                                  to_char(l_extype(e).id),
                                  l_extype(e).bonus_proc,
                                  to_char(p_dptid),
                                  sqlerrm);
      end;

    end loop; -- e

    bars_audit.trace('%s exit', title);

  end auto_extension_bonus;

  --
  -- проверка допустимости получения бонуса и определение значения бонусной процентной ставки
  --
  function iextbonus12_get_rate(p_query in dpt_vidd_extypes.bonus_rate%type, -- запрос для вычисления ставки
                                p_dptid in dpt_deposit.deposit_id%type, -- идентификатор вклада
                                p_bdate in date) -- текущая банковская дата
   return number -- значения бонусной процентной ставки
   is
    title constant varchar2(60) := 'dptweb.setextbonus12avg.getrate: ';
    l_cursor number(38);
    l_tmpnum number(38);
    l_rate   number(10, 4);
  begin

    bars_audit.trace('%s entry, dptid => %s, bdate => %s, query => %s',
                     title,
                     to_char(p_dptid),
                     to_char(p_bdate, 'dd.mm.yyyy'),
                     p_query);

    l_cursor := dbms_sql.open_cursor;
    dbms_sql.parse(l_cursor, p_query, dbms_sql.native);
    dbms_sql.bind_variable(l_cursor, 'DPTID', p_dptid);
    dbms_sql.bind_variable(l_cursor, 'DAT', p_bdate);
    dbms_sql.define_column(l_cursor, 1, l_rate);
    l_tmpnum := dbms_sql.execute_and_fetch(l_cursor);
    dbms_sql.column_value(l_cursor, 1, l_rate);
    dbms_sql.close_cursor(l_cursor);

    bars_audit.trace('%s exit with rate %s', title, to_char(l_rate));

    return l_rate;

  exception
    when others then
      dbms_sql.close_cursor(l_cursor);
      raise;
  end iextbonus12_get_rate;

  --
  -- расчет среднекалендарного остатка по счету за указанный период
  --
  function iextbonus12_get_saldo(p_dptrow  in dpt_deposit%rowtype, -- данные по вкладу
                                 p_mnthcnt in number) -- кол-во мес. для расчета среднего остатка
   return number -- среднекалендарный остаток
   is
    title constant varchar2(60) := 'dptweb.setextbonus12avg.getsal: ';
    l_dat1   date;
    l_dat2   date;
    l_avgsal number(38);
  begin

    bars_audit.trace('%s entry, dptid => %s, mnthcnt => %s',
                     title,
                     to_char(p_dptrow.deposit_id),
                     to_char(p_mnthcnt));

    -- вычисление начальной и конечной дат периода
    select dat_begin
      into l_dat1
      from dpt_deposit_clos
     where idupd =
           (select max(idupd)
              from dpt_deposit_clos
             where deposit_id = p_dptrow.deposit_id
               and action_id in (0, 3)
               and nvl(cnt_dubl, 0) = (p_dptrow.cnt_dubl + 1) - p_mnthcnt);

    l_dat2 := p_dptrow.dat_end - 1;

    bars_audit.trace('%s term = (%s,%s)',
                     title,
                     to_char(l_dat1, 'dd.mm.yy'),
                     to_char(l_dat2, 'dd.mm.yy'));

    select round(avg(s.ostf - s.dos + s.kos))
      into l_avgsal
      from saldoa s, conductor c
     where c.num > 0
       and c.num <= l_dat2 - l_dat1 + 1
       and s.acc = p_dptrow.acc
       and (s.acc, s.fdat) = (select s1.acc, max(s1.fdat)
                                from saldoa s1
                               where s1.acc = s.acc
                                 and s1.fdat <= (l_dat1 + c.num - 1)
                               group by s1.acc);

    bars_audit.trace('%s exit with avgsaldo %s', title, to_char(l_avgsal));

    return nvl(l_avgsal, 0);

  end iextbonus12_get_saldo;

  --
  -- оплата документа по зачислению бонуса на процентный счет клиента
  --
  procedure iextbonus12_paydoc(p_dptrow   in dpt_deposit%rowtype, -- данные по вкладу
                               p_amount   in oper.s%type, -- сумма бонуса
                               p_bdate    in oper.vdat%type, -- банковская дата
                               p_tt       in oper.tt%type, -- код операции
                               p_comments in oper.nazn%type, -- расчет суммы бонуса
                               p_docref   out oper.ref%type) -- референс документа
   is
    title constant varchar2(60) := 'dptweb.setextbonus12avg.paydoc: ';
    l_doc    oper%rowtype;
    l_errflg boolean;
    l_errmsg varchar2(3000);
  begin

    bars_audit.trace('%s entry, dptid => %s, amount => %s, bdate => %s, tt => %s',
                     title,
                     to_char(p_dptrow.deposit_id),
                     to_char(p_amount),
                     to_char(p_bdate, 'dd.mm.yyyy'),
                     p_tt);

    begin
      select ap.nls,
             ap.kv,
             substr(ap.nms, 1, 38),
             cp.okpo,
             ap.kf,
             ae.nls,
             ae.kv,
             substr(ae.nms, 1, 38),
             ce.okpo,
             ae.kf
        into l_doc.nlsa,
             l_doc.kv,
             l_doc.nam_a,
             l_doc.id_a,
             l_doc.mfoa,
             l_doc.nlsb,
             l_doc.kv2,
             l_doc.nam_b,
             l_doc.id_b,
             l_doc.mfob
        from int_accn i, accounts ap, accounts ae, customer cp, customer ce
       where i.acc = p_dptrow.acc
         and i.id = mainintid
         and i.acra = ap.acc
         and i.acrb = ae.acc
         and ap.rnk = cp.rnk
         and ae.rnk = ce.rnk;
    exception
      when no_data_found then
        -- не найдены счета для начисления бонуса за пролонгацию договора
        bars_error.raise_nerror(g_modcode,
                                'EXTBONUS_PAYACC_NOT_FOUND',
                                p_dptrow.nd,
                                to_char(p_dptrow.datz, 'dd.mm.yyyy'),
                                to_char(p_dptrow.deposit_id));
    end;

    l_doc.dk   := 0;
    l_doc.tt   := p_tt;
    l_doc.vdat := p_bdate;
    l_doc.s    := p_amount;
    l_doc.vob  := get_vob(p_kva => l_doc.kv, p_kvb => l_doc.kv2);
    l_doc.s2 := case
                  when l_doc.kv = l_doc.kv2 then
                   l_doc.s
                  else
                   round(gl.p_icurval(l_doc.kv, l_doc.s, l_doc.vdat))
                end;

    -- Нарахування додаткових відсотків при .. пролонгації деп.договору № .. від ..
    l_doc.nazn := substr(bars_msg.get_msg(g_modcode,
                                          'EXTBONUS_DOCDTL',
                                          to_char(p_dptrow.cnt_dubl),
                                          p_dptrow.nd,
                                          to_char(p_dptrow.datz,
                                                  'dd.mm.yyyy')) ||
                         p_comments,
                         1,
                         160);

    paydoc(p_dptid    => p_dptrow.deposit_id,
           p_vdat     => l_doc.vdat,
           p_brancha  => p_dptrow.branch,
           p_branchb  => p_dptrow.branch,
           p_nlsa     => l_doc.nlsa,
           p_nlsb     => l_doc.nlsb,
           p_mfoa     => l_doc.mfoa,
           p_mfob     => l_doc.mfob,
           p_nama     => l_doc.nam_a,
           p_namb     => l_doc.nam_b,
           p_ida      => l_doc.id_a,
           p_idb      => l_doc.id_b,
           p_kva      => l_doc.kv,
           p_kvb      => l_doc.kv2,
           p_sa       => l_doc.s,
           p_sb       => l_doc.s2,
           p_nazn     => l_doc.nazn,
           p_nmk      => l_doc.nam_a,
           p_tt       => l_doc.tt,
           p_userid   => l_doc.userid,
           p_vob      => l_doc.vob,
           p_dk       => l_doc.dk,
           p_sk       => l_doc.sk,
           p_type     => null,
           p_err_flag => l_errflg,
           p_err_msg  => l_errmsg,
           p_ref      => l_doc.ref);

    bars_audit.trace('%s ref (%s - %s = %s) = %s',
                     title,
                     l_doc.nlsa,
                     l_doc.nlsb,
                     to_char(l_doc.s),
                     to_char(l_doc.ref));
    if l_errflg then
      -- ошибка оплаты документа по начислению бонуса за пролонгацию договора №
      bars_error.raise_nerror(g_modcode,
                              'EXTBONUS_PAYDOC_FAILED',
                              p_dptrow.nd,
                              to_char(p_dptrow.datz, 'dd.mm.yyyy'),
                              to_char(p_dptrow.deposit_id),
                              l_errmsg);
    end if;

    p_docref := l_doc.ref;

    bars_audit.trace('%s exit with ref %s', title, to_char(p_docref));

  end iextbonus12_paydoc;

  --
  -- установка бонуса для 12-кратнопролонгированных вкладов (Правекс)
  --
  procedure set_extbonus12avg(p_extid  in dpt_vidd_extypes.id%type, -- метод переоформления
                              p_dptid  in dpt_jobs_log.dpt_id%type, -- идентификатор вклада
                              p_runid  in dpt_jobs_log.run_id%type, -- код запуска
                              p_branch in dpt_jobs_log.branch%type, -- код подразделения
                              p_bdate  in date, -- банковская дата
                              p_tt     in tts.tt%type, -- код операции для зачисления бонуса
                              p_period in number) -- кол-во мес. для расчета среднего остатка
   is
    title constant varchar2(60) := 'dptweb.setextbonus12avg: ';
    l_query dpt_vidd_extypes.bonus_rate%type;
    type t_dptlist is table of dpt_deposit%rowtype;
    l_dptlist   t_dptlist;
    l_bonusrate number(10, 4);
    l_avgsaldo  number(38);
    l_dayscnt   number(38);
    l_intbase   number(38);
    l_intamount number(38);
    l_comments  varchar2(160);
    l_docref    number(38);
    l_cnt       number(38) := 0;
  begin

    bars_audit.trace('%s entry, extid => %s, dptid => %s, runid => %s, branch => %s,' ||
                     ' bdate => %s, tt => %s, period => %s',
                     title,
                     to_char(p_extid),
                     to_char(p_dptid),
                     to_char(p_runid),
                     p_branch,
                     to_char(p_bdate, 'dd.mm.yyyy'),
                     p_tt,
                     to_char(p_period));

    -- функция для расчета значения бонусной процентной ставки
    begin
      select bonus_rate
        into l_query
        from dpt_vidd_extypes
       where id = p_extid;
    exception
      when no_data_found then
        -- не найдена процедура расчета бонуса для метода пролонгации №
        bars_error.raise_nerror(g_modcode,
                                'EXTBONUS_TYPE_NOT_FOUND',
                                to_char(p_extid));
    end;

    -- отбор всех вкладов с пролонгацией, для видов вкладов которых предусмотрен бонус
    select d.*
      bulk collect
      into l_dptlist
      from dpt_vidd_extypes e, dpt_vidd v, dpt_deposit d
     where d.vidd = v.vidd
       and v.extension_id = e.id
       and e.id = p_extid
       and d.branch = p_branch
       and d.deposit_id = decode(p_dptid, 0, d.deposit_id, p_dptid);

    for i in 1 .. l_dptlist.count loop

      bars_audit.trace('%s processing deposit № %s...',
                       title,
                       to_char(l_dptlist(i).deposit_id));

      begin

        savepoint sp_bonusext;

        -- проверка выполнения условия получения бонуса и
        -- определение значения бонусной процентной ставки
        l_bonusrate := iextbonus12_get_rate(p_query => l_query,
                                            p_dptid => l_dptlist(i).deposit_id,
                                            p_bdate => p_bdate);
        bars_audit.trace('%s bonusrate = %s', title, to_char(l_bonusrate));

        if l_bonusrate > 0 then

          -- расчет остатка, на который начисляется бонус
          l_avgsaldo := iextbonus12_get_saldo(p_dptrow  => l_dptlist(i),
                                              p_mnthcnt => p_period);
          bars_audit.trace('%s avgsaldo = %s', title, to_char(l_avgsaldo));

          -- расчет периода, за который начисляются бонусные проценты
          l_dayscnt := (l_dptlist(i).dat_end - 1) - l_dptlist(i).dat_begin + 1;
          bars_audit.trace('%s dayscnt = %s', title, to_char(l_dayscnt));

          -- процентная база для начисления процентов
          l_intbase := to_date('3112' ||
                               to_char(l_dptlist(i).dat_begin, 'YYYY'),
                               'DDMMYYYY') -
                       trunc(l_dptlist(i).dat_begin, 'YEAR') + 1;
          -- сумма начисленных процентов
          l_intamount := round(l_bonusrate * l_avgsaldo * l_dayscnt /
                               l_intbase / 100);
          l_intamount := greatest(nvl(l_intamount, 0), 0);
          bars_audit.trace('%s intamount = %s',
                           title,
                           to_char(l_intamount));

          if l_intamount > 0 then
            -- (на сумму %s/%s за %s дн. под %s % годовых)
            l_comments := substr(bars_msg.get_msg(g_modcode,
                                                  'EXTBONUS_DOCOMM',
                                                  trim(to_char(l_avgsaldo / 100,
                                                               '9G999G999G999D09')),
                                                  to_char(l_dptlist(i).kv),
                                                  to_char(l_dayscnt),
                                                  trim(to_char(l_bonusrate,
                                                               '990D99'))),
                                 1,
                                 160);

            -- оплата документа
            iextbonus12_paydoc(p_dptrow   => l_dptlist(i), -- данные по вкладу
                               p_amount   => l_intamount, -- сумма бонуса
                               p_bdate    => p_bdate, -- банковская дата
                               p_tt       => p_tt, -- код операции
                               p_comments => l_comments, -- расчет суммы бонуса
                               p_docref   => l_docref); -- референс документа
            bars_audit.trace('%s docref = %s', title, to_char(l_docref));

            -- промежуточная фиксация
            l_cnt := l_cnt + 1;
            if p_runid > 0 and l_cnt >= autocommit then
              commit;
              l_cnt := 0;
            end if;

          end if;

        end if;

      exception
        when others then
          rollback to sp_bonusext;
          -- ошибка расчета и начисления бонуса за пролонгацию договора №
          bars_error.raise_nerror(g_modcode,
                                  'EXTBONUS_FAILED',
                                  l_dptlist(i).nd,
                                  to_char(l_dptlist(i).datz, 'dd.mm.yyyy'),
                                  to_char(l_dptlist(i).deposit_id),
                                  sqlerrm);
      end;

    end loop; -- i

    bars_audit.trace('%s exit', title);

  end set_extbonus12avg;

  --
  -- функция определения вклада до востребования
  -- возвращает 1 - для текущих и пенсионных вкладов, 0 - для срочных вкладов
  --
  function is_demandpt(p_dptid in dpt_deposit.deposit_id%type) return number is
    l_socflg number(1) := 0;
  begin

    begin
      select 1
        into l_socflg
        from dpt_deposit
       where deposit_id = p_dptid
         and dat_end is null;
    exception
      when no_data_found then
        l_socflg := 0;
    end;

    return l_socflg;

  end is_demandpt;

  --
  -- установка актуальных значений спецпараметра r013 для счетов по вкладам
  --
  procedure auto_sync_r013(p_bnkdate in date, -- текущая банковская дата
                           p_datend1 in date, -- начальная дата диапазона дат окончания вкладов
                           p_datend2 in date) -- конечная дата диапазона дат окончания вкладов
   is
    title constant varchar2(60) := 'dpt.autosyncr013:';
    type t_dptrec is record(
      dptid  dpt_deposit.deposit_id%type,
      accid  dpt_deposit.acc%type,
      branch dpt_deposit.branch%type,
      datend dpt_deposit.dat_end%type);
    type t_dpttbl is table of t_dptrec;
    l_dpt  t_dpttbl;
    l_r013 specparam.r013%type;
  begin

    bars_audit.trace('%s entry, bnkdate=>%s, datend1=>%s, datend2=>%s',
                     title,
                     to_char(p_bnkdate, 'dd.mm.yyyy'),
                     to_char(p_datend1, 'dd.mm.yyyy'),
                     to_char(p_datend2, 'dd.mm.yyyy'));

    select deposit_id, acc, branch, dat_end
      bulk collect
      into l_dpt
      from dpt_deposit
     where dat_end >= p_datend1
       and dat_end <= p_datend2
     order by branch;

    for i in 1 .. l_dpt.count loop

      bars_audit.trace('%s processing dpt № %s...',
                       title,
                       to_char(l_dpt(i).dptid));

      -- представимся подразделением
      if l_dpt(i).branch != sys_context('bars_context', 'user_branch') then
        bars_context.subst_branch(l_dpt(i).branch);
      end if;

      begin
        for a in (select a.acc,
                         a.nls,
                         a.tip,
                         s.r013,
                         decode(s.acc, null, 1, 2) need2ins
                    from dpt_accounts da, accounts a, specparam s
                   where da.accid = a.acc
                     and a.acc = s.acc(+)
                     and da.dptid = l_dpt(i).dptid) loop

          bars_audit.trace('%s processing acc № %s...', title, a.nls);

          -- значение спецпараметра R013 для депозитного счета
          if a.acc = l_dpt(i).accid then
            if l_dpt(i).datend > p_bnkdate then
              l_r013 := dpt.r013_actdep;
            else
              l_r013 := dpt.r013_clsdep;
            end if;
          else
            l_r013 := null;
          end if;

          -- несоответствие реального и требуемого значений R013
          if l_r013 is not null and nvl(a.r013, '_') != l_r013 then
            if a.need2ins = 1 then
              insert into specparam (acc, r013) values (a.acc, l_r013);
            else
              update specparam set r013 = l_r013 where acc = a.acc;
            end if;
            bars_audit.trace('%s r013 for acc № %s: %s->%s',
                             title,
                             a.nls,
                             nvl(a.r013, '_'),
                             l_r013);
          end if;

        end loop;

      exception
        when others then
          bars_context.set_context;
          bars_error.raise_nerror(g_modcode,
                                  'SYNCR013_FAILED',
                                  to_char(l_dpt(i).dptid),
                                  sqlerrm);
      end;

    end loop;

    bars_context.set_context;
    bars_audit.trace('%s exit', title);

  end auto_sync_r013;

  --
  -- проверка допустимости возврата суммы вклада и процентов
  --
  function verify_depreturn(p_dptid in dpt_deposit.deposit_id%type, -- идентификатор вклада
                            p_bdate in dpt_deposit.dat_end%type) -- дата возврата вклада и процентов
   return number -- возвращаем 1(разрешено) или ошибку
   is
    title varchar2(60) := 'dptweb.vrfdepreturn:';
    l_flg number(1);
  begin

    bars_audit.trace('%s entry, dptid=>%s', title, to_char(p_dptid));

    l_flg := 1;

    bars_audit.trace('%s exit with %s', title, to_char(l_flg));
    return l_flg;

  end verify_depreturn;

  --=============================================================================
  --
  --
  function get_bonus_rate(p_dptid dpt_deposit.deposit_id%type) return number is
    type t_dptrow is record(
      vidd    dpt_deposit.vidd%type,
      kv      dpt_deposit.kv%type,
      dat_beg dpt_deposit.dat_begin%type,
      acc     dpt_deposit.acc%type,
      ost     dpt_deposit.limit%type);

    l_dptrow t_dptrow;
    title    varchar2(60) := 'DPT_WEB.GET_BONUS_RATE:';

    l_br         dpu_vidd.br_id%type;
    l_rate       int_ratn.ir%type;
    l_date       date;
    l_current_br int_ratn.br%type;
    l_viddmin_dt dpt_vidd_update.dateu%type;

  begin

    begin
      select vidd, kv, dat_begin, acc, fost(acc, gl.bd)
        into l_dptrow
        from dpt_deposit
       where deposit_id = p_dptid;

      bars_audit.trace('%s found for deposit_id = %s (vidd = %s, kv = %s, dat_begin = %s, ost = %s)',
                       title,
                       to_char(p_dptid),
                       to_char(l_dptrow.vidd),
                       to_char(l_dptrow.kv),
                       to_char(l_dptrow.dat_beg, 'dd.mm.yyyy'),
                       to_char(l_dptrow.ost));
    exception
      when no_data_found then
        l_rate := 0;
        bars_audit.trace('%s nothing found for deposit_id = %s',
                         title,
                         to_char(p_dptid));
    end;

    begin
      select br
        into l_current_br
        from int_ratn
       where acc = l_dptrow.acc
         and id = 1
         and bdat = (select max(bdat)
                       from int_ratn
                      where acc = l_dptrow.acc
                        and id = 1);
    exception
      when no_data_found then
        l_rate := 0;
        bars_audit.trace('%s nothing found for in INT_RATN deposit_id = %s',
                         title,
                         to_char(p_dptid));
    end;

    if l_rate = 0 then
      null;
    else
      begin

        -- COBUSUPABS-4401
        -- Необхідно виправити програмне забезпечення таким чином, щоб 3ДУ змінювала процентну ставку,
        -- відносно пакету послуг ексклюзивного, на ставку яка діяла по цьому виду вкладу на дату відкриття депозиту.
        if l_current_br is null then
          select max(v.dateu)
            into l_viddmin_dt
            from dpt_vidd_update v, brates b
           where v.vidd = l_dptrow.vidd
                -- and v.type_id in (2, 4, 9, 10, 16)
             and v.br_id = b.br_id
             and b.br_type = 2 --< Ступінчаста %% ставка
             and dateu <= l_dptrow.dat_beg;

          select v.br_id
            into l_br
            from dpt_vidd_update v, brates b
           where v.vidd = l_dptrow.vidd
                -- and v.type_id in (2, 4, 9, 10, 16)
             and v.br_id = b.br_id
             and b.br_type = 2 --< Ступінчаста %% ставка
             and dateu = l_viddmin_dt;
        else
          -- пошук Ступінчастої базової ставки для депозиту
          select v.br_id -- на якй поширюється пакет "Ексклюзивний"
            into l_br
            from dpt_vidd v, brates b
           where v.vidd = l_dptrow.vidd
                -- and v.type_id in (2, 4, 9, 10, 16)
             and v.br_id = b.br_id
             and b.br_type = 2; --< Ступінчаста %% ставка
        end if;
        -- шукаєм мінімальну дату для якої існує значення ставки
        select min(bdate)
          into l_date
          from br_tier_edit
         where br_id = l_br
           and kv = l_dptrow.kv;

        -- якщо дату (інакше для депозитів які відкритті раніше нова ставка буде = 0 )
        -- l_date := greatest( l_date, l_dptrow.dat_beg );
        if (l_date < l_dptrow.dat_beg) then
          l_date := l_dptrow.dat_beg;
        else
          bars_audit.trace('%s for BR_ID = %s and KV = %s min_date = %s (search rate on min_date because dat_beg < min_date)',
                           title,
                           to_char(l_br),
                           to_char(l_dptrow.kv),
                           to_char(l_date, 'dd.mm.yyyy'));
        end if;

        l_rate := getbrat(l_date, l_br, l_dptrow.kv, l_dptrow.ost);

      exception
        when no_data_found then
          l_rate := 0;
      end;

    end if;

    bars_audit.trace('%s exit, rates => %s ', title, to_char(l_rate));

    return l_rate;

  end get_bonus_rate;

  --
  -- відправка SMS повідомлення
  --
  procedure send_sms(p_rnk in dpt_deposit.rnk%type,
                     p_msg in msg_submit_data.msg_text%type) is
    l_msgid msg_submit_data.msg_id%type;
    l_phone msg_submit_data.msg_text%type;
    l_kf    varchar2(6);
  begin
    if (p_rnk > 1) then

      begin
        -- пошук номеру мобільного телефону
        select "VALUE"
          into l_phone
          from customerw
         where rnk = p_rnk
           and tag = 'MPNO'
           and isp = 0;

        select kf into l_kf from customer where rnk = p_rnk;

        case length(l_phone)
          when 9 then
            l_phone := '+380' || l_phone;
          when 10 then
            l_phone := '+38' || l_phone;
          when 12 then
            l_phone := '+' || l_phone;
          else
            null;
        end case;

        bars_sms.create_msg(p_msgid           => l_msgid,
                            p_creation_time   => sysdate,
                            p_expiration_time => sysdate + 1,
                            p_phone           => l_phone,
                            p_encode          => 'lat',
                            p_msg_text        => substr(p_msg ||
                                                        ' Dovidka 0800210800.',
                                                        1,
                                                        160),
                            p_rnk             => p_rnk,
                            p_kf              => l_kf);
        --  зберігаємо інфу по відпрвці
        insert into acc_msg
          (msg_id, change_time, rnk)
        values
          (l_msgid, sysdate, p_rnk);

      exception
        when no_data_found then
          bars_audit.info('DPT_WEB.SEND_SMS: В клієнта (рнк=' ||
                          to_char(p_rnk) ||
                          ') відсутня інформація про номер мобільного телефону!');
        when others then
          bars_audit.info('DPT_WEB.SEND_SMS: Error => ' || sqlerrm);
      end;

    else
      bars_audit.info('DPT_WEB.SEND_SMS: Не вказано РНК отримувача SMS повідомлення!');
    end if;

  end send_sms;

  ---
  -- Відправка повідомлень-нагадувань клієнту
  ---
  procedure sending_messages is
    l_bankdate date;
    l_date_end date;
  begin

    l_bankdate := bankdate;
    l_date_end := (l_bankdate + 3);

    -- 1) Нагадування про закінчення дії депозитного договору
    for k in (select deposit_id as dpt_id, rnk, dat_end
                from dpt_deposit
               where dat_end between l_bankdate and l_date_end) loop
      send_sms(k.rnk,
               'Termin dii depozytu N' || to_char(k.dpt_id) ||
               ' zakinchuetsya ' || to_char(k.dat_end, 'dd/mm/yy') ||
               '. Zvernitsya bud-laska v Bank.');
    end loop;

    -- 2) Нагадування про програму лояльності "Ексклюзив"
    -- Dlya zbilshennya protsentnoi stavky po Vashomu depozytu zvernitsya bud-laska v Bank.

  end sending_messages;

  -- ======================================================================================
  -- помічаємо договір на закриття
  --
  procedure mark_to_close(p_dptid in dpt_deposit.deposit_id%type) is
  begin

    -- Блокуємо можливість зарахування на рахунки договору
    for k in (select accid from dpt_accounts where dptid = p_dptid) loop
      update accounts a
         set a.blkk = 99
       where a.acc = k.accid
         and a.dazs is null;
    end loop;

    -- проставляємо відмітку на закриття
    dpt.fill_dptparams(p_dptid, '2CLOS', 'Y');

  end mark_to_close;

  --==============================================================
  -- Проверка существования клиента по одновременному совпадению кода ОКПО, номера и серии паспорта
  -- BRSMAIN-2619
  -- Павленко 21/05/2014
  --==============================================================
  function is_already_client(p_okpo   in customer.okpo%type,
                             p_nmk    in customer.nmk%type,
                             p_ser    in person.ser%type,
                             p_numdoc in person.numdoc%type) return number is
    l_rnk    number := 0;
    p_cust   sys_refcursor;
    l_nmk    varchar2(100);
    l_okpo   varchar2(100);
    l_adr    varchar2(100);
    l_name   varchar2(100);
    l_ser    varchar2(100);
    l_numdoc varchar2(100);
    l_branch varchar2(100);
  begin
    dpt_web.p_search_customer(p_okpo, p_nmk, null, p_ser, p_numdoc, p_cust);
    loop
      fetch p_cust
        into l_rnk, l_nmk, l_okpo, l_adr, l_name, l_ser, l_numdoc, l_branch;
      exit when p_cust%notfound;
    end loop;
    close p_cust;
    return l_rnk;
  end;

  --
  --
  --
  procedure agr_params(p_agr_id in number,
                       p_tag_id in number,
                       p_text   in varchar2) is
  begin

    update dpt_agrw
       set value = trim(p_text)
     where agreement_id = p_agr_id
       and tag_id = p_tag_id; -- для поля Інше - прописью из ДУ  (=1) dpt_dict_agrtag

    if (sql%rowcount = 0) then
      insert into dpt_agrw
        (agreement_id, tag_id, value)
      values
        (p_agr_id, p_tag_id, trim(p_text));
    end if;

  end agr_params;

  -- ======================================================================================
  -- проверка:депозит є заставою по кредиту
  --
  function dpt_is_pawn(p_dptid in dpt_deposit.deposit_id%type)
    return dpt_depositw.value%type is
    l_title  varchar2(60) := 'dpt_web.dpt_is_pawn: ';
    l_result dpt_depositw.value%type;
  begin

    bars_audit.trace('%s договор № %s', l_title, to_char(p_dptid));
    begin
      select nvl(value, 0)
        into l_result
        from dpt_depositw
       where dpt_id = p_dptid
         and tag = 'CPAWN';
    exception
      when no_data_found then
        l_result := '0';
    end;

    -- bars_audit.trace('%s флаг наследования = %s (p_param = %s)', l_title, l_result, to_char(p_param) );

    return l_result;

  end dpt_is_pawn;

  procedure dpt_is_exclusive(p_rnk  customer.rnk%type,
                             p_acc  accounts.acc%type,
                             p_tt   acc_balance_changes.tt%type,
                             p_ostc acc_balance_changes.ostc%type,
                             p_kos  acc_balance_changes.kos_delta%type) is
    l_dpt_id number := 0;
  begin
    select nvl(max(t2.deposit_id), 0)
      into l_dpt_id
      from dpt_deposit t2, dpt_vidd_exclusive t3, dpt_vidd t4
     where t2.acc = p_acc
       and t3.tt = p_tt
       and t2.vidd = t4.vidd
       and t4.type_id = t3.type_id
       and p_ostc between t3.ostc_min and t3.ostc_max
       and (p_ostc - p_kos) < t3.ostc_min
       and months_between(bankdate, t2.dat_begin) >= t3.month_term
       and t2.kv = t3.kv;

    if (l_dpt_id > 0) then
      /*SEND_SMS (
      p_rnk,
         'Dlya zbilshennya protsentnoi stavky po Vashomu depozytu N '
      || TO_CHAR (l_dpt_id)
      || ' zvernitsya, bud-laska, v Bank. Dovidka 0800210800');*/
      null;
    end if;
  end dpt_is_exclusive;

  /*
  Процедура расчета процентов (и налогов) по дострочно расторгнутым договорам за произвольный период
  */
  procedure penalty_info(p_dptid     number,
                         p_datbeg    date,
                         p_datend    date,
                         p_int       out number,
                         p_tax       out number,
                         p_taxmil    out number,
                         p_sh_int    out number,
                         p_sh_tax    out number,
                         p_sh_taxmil out number) is
    l_when   date;
    l_dptacc number;
    l_kv     number;
    l_base   number := 365;

    l_msg varchar2(50);

    type t_raterec is record(
      dat1 int_ratn_arc.bdat%type,
      dat2 int_ratn_arc.bdat%type,
      ir   int_ratn_arc.ir%type,
      br   int_ratn_arc.br%type,
      op   int_ratn_arc.op%type);

    type t_ratedata is table of t_raterec;

    l_accturn     t_turndata;
    l_accrates    t_ratedata;
    l_taxlist     t_taxdata;
    l_taxlist_mil t_taxdata;

    l_accturn_cnt   number := 0;
    l_accrates_cnt  number := 0;
    l_int           number := 0;
    l_tax           number := 0;
    l_tax_mil       number := 0;
    l_tmp_int       number := 0;
    l_tmp_int_j     number := 0;
    l_tmp_tax       number := 0;
    l_tmp_tax_k     number := 0;
    l_tmp_tax_mil   number := 0;
    l_tmp_tax_mil_l number := 0;
  begin
    begin
      select trunc(dc.when), dc.acc, dc.kv
        into l_when, l_dptacc, l_kv
        from dpt_deposit_clos dc
       where dc.deposit_id = p_dptid
         and dc.action_id = 5;
    exception
      when no_data_found then
        raise_application_error(-20001,
                                'ERR:  Дострокового розторгнення за договором №' ||
                                to_char(p_dptid) || ' не відбувалось.',
                                true);
      when dup_val_on_index then
        raise_application_error(-20001,
                                'ERR:  Дострокового розторгнення за договором №' ||
                                to_char(p_dptid) ||
                                ' відбувалось неодноразово. ',
                                true);
    end;

    --l_base := CASE WHEN l_kv = 980 THEN 365 ELSE 360 END;
    bars_audit.trace('Дата досрочного расторжения - ' ||
                     to_char(l_when, 'dd/mm/yyyy'));
    -- 1. Ищем набор периодов + остатков, входящих в период расчета штрафных %%
    intl_get_turndata_bnk(p_accid  => l_dptacc, -- внутр.№ депозитного счета
                          p_datbeg => p_datbeg, -- дата начала действия договора
                          p_datend => least(p_datend, l_when - 1), -- дата списания средств
                          --p_datend    => p_datend,    -- дата списания средств
                          p_accturn => l_accturn); -- банк.даты с оборотами
    l_accturn_cnt := l_accturn.count;
    /* for jj in 1..l_accturn_cnt
    loop
       l_accturn (jj).currdat := l_accturn (jj).currdat - 1;
    end loop;*/

    bars_audit.trace('START. Количество оборотов по счету за период с ' ||
                     to_char(p_datbeg, 'dd/mm/yyyy') || ' по ' ||
                     to_char(p_datend, 'dd/mm/yyyy') || '=' ||
                     to_char(l_accturn_cnt));

    l_tmp_int       := 0;
    l_tmp_tax       := 0;
    l_tmp_tax_mil   := 0;
    l_tmp_int_j     := 0;
    l_tmp_tax_k     := 0;
    l_tmp_tax_mil_l := 0;
    for m in 0 .. 1 loop
      l_msg     := case
                     when m = 0 then
                      'штрафной'
                     else
                      'нормальной'
                   end;
      l_int     := 0;
      l_tax     := 0;
      l_tax_mil := 0;

      for i in 1 .. l_accturn_cnt loop

        bars_audit.trace('(' ||
                         to_char(l_accturn(i).prevdat, 'dd/mm/yyyy') || '-' ||
                         to_char(l_accturn(i).currdat, 'dd/mm/yyyy') || ')' ||
                         ' saldo = ' || to_char(l_accturn(i).saldo) || ' ' ||
                         to_char(l_accturn(i)
                                 .currdat - l_accturn(i).prevdat) ||
                         ' дн.');

        -- 2. Ищем набор периодов + %%ставок, входящим в период расчета штрафных %%
        begin
          select distinct bdat dat1,
                          lead(bdat) over(order by bdat) dat2,
                          ir,
                          br,
                          op
            bulk collect
            into l_accrates
            from int_ratn_arc
           where id = 5
             and acc = l_dptacc
             and vid = 'I'
             and bdat <= l_accturn(i).currdat
             and (dpt.fproc(acc, bdat) <> ir and m = 0 or
                 dpt.fproc(acc, bdat) = ir and m = 1)
           order by bdat;

          l_accrates_cnt := l_accrates.count;
          l_tmp_int_j    := 0;

          for j in 1 .. l_accrates_cnt loop
            if nvl(l_accrates(j).dat2, l_accturn(i).currdat) >
               greatest(l_accrates(j).dat1, l_accturn(i).prevdat) then
              l_tmp_int := l_accturn(i)
                           .saldo * l_accrates(j).ir / 100 *
                            (nvl(l_accrates(j).dat2, l_accturn(i).currdat) -
                             greatest(l_accrates(j).dat1,
                                      l_accturn (i).prevdat)) / l_base;
              bars_audit.trace('  (' ||
                               to_char(greatest(l_accrates(j).dat1,
                                                l_accturn (i).prevdat),
                                       'DD/MM/YYYY') || '-' ||
                               to_char(nvl(l_accrates(j).dat2,
                                           l_accturn (i).currdat),
                                       'DD/MM/YYYY') || ') ' ||
                               to_char((nvl(l_accrates(j).dat2,
                                            l_accturn (i).currdat) -
                                       greatest(l_accrates(j).dat1,
                                                 l_accturn (i).prevdat))) ||
                               ' дн.' || 'IR = ' ||
                               to_char(l_accrates(j).ir) || ' INT = ' ||
                               to_char(l_tmp_int));

              -- 3. Ищем набор периодов + ставок налогообложения (ПДФО) за период расчета штрафных %%
              -- Определение периодов и ставок налогообложения по справочнику TAX_SETTINGS
              select tax_type,
                     tax_int,
                     dat_begin,
                     nvl(dat_end, l_accturn(i).currdat)
                bulk collect
                into l_taxlist
                from tax_settings
               where tax_type = 1
                 and dat_begin <=
                     nvl(l_accrates(j).dat2, l_accturn(i).currdat)
               order by dat_begin; -- 1 Налог на пассивные доходы ФЛ

              l_tmp_tax_k := 0;

              for k in 1 .. l_taxlist.count loop
                if (least(nvl(l_accrates(j).dat2, l_accturn(i).currdat),
                          l_taxlist(k).tax_date_end) >
                   greatest(greatest(l_accrates(j).dat1,
                                      l_accturn (i).prevdat),
                             l_taxlist(k).tax_date_begin)) then
                  l_tmp_tax := l_accturn(i)
                               .saldo * l_accrates(j).ir / 100 *
                                (least(nvl(l_accrates(j).dat2,
                                           l_accturn (i).currdat),
                                       l_taxlist(k).tax_date_end,
                                       l_when) -
                                 greatest(greatest(l_accrates(j).dat1,
                                                   l_accturn (i).prevdat),
                                          l_taxlist(k).tax_date_begin) + 1) * l_taxlist(k)
                               .tax_int / l_base;

                  bars_audit.trace('     (' ||
                                   to_char(greatest(greatest(l_accrates(j).dat1,
                                                             l_accturn (i)
                                                             .prevdat),
                                                    l_taxlist(k)
                                                    .tax_date_begin),
                                           'DD/MM/YYYY') || '-' ||
                                   to_char(least(nvl(l_accrates(j).dat2,
                                                     l_accturn (i).currdat),
                                                 l_taxlist(k).tax_date_end,
                                                 l_when),
                                           'DD/MM/YYYY') || ') ' ||
                                   to_char(least(nvl(l_accrates(j).dat2,
                                                     l_accturn (i).currdat),
                                                 l_taxlist(k).tax_date_end,
                                                 l_when) -
                                           greatest(greatest(l_accrates(j).dat1,
                                                             l_accturn (i)
                                                             .prevdat),
                                                    l_taxlist(k)
                                                    .tax_date_begin) + 1) ||
                                   ' дн.' || 'TR = ' ||
                                   to_char(l_taxlist(k).tax_int) ||
                                   ' TAX = ' || to_char(l_tmp_tax));

                  l_tmp_tax_k := l_tmp_tax_k + l_tmp_tax;
                end if;
              end loop; --k

              --4. Ищем набор периодов + ставок налогообложения Военного сбора за период расчета штрафных %%
              -- Определение периодов и ставок налогообложения по справочнику TAX_SETTINGS
              select tax_type,
                     tax_int,
                     dat_begin,
                     nvl(dat_end, l_accturn(i).currdat)
                bulk collect
                into l_taxlist_mil
                from tax_settings
               where tax_type = 2
                 and dat_begin <=
                     nvl(l_accrates(j).dat2, l_accturn(i).currdat); -- 2 Военный сбор

              l_tmp_tax_mil_l := 0;

              for l in 1 .. l_taxlist_mil.count loop
                if (least(nvl(l_accrates(j).dat2, l_accturn(i).currdat),
                          l_taxlist_mil(l).tax_date_end,
                          l_when) >
                   greatest(greatest(l_accrates(j).dat1,
                                      l_accturn (i).prevdat),
                             l_taxlist_mil(l).tax_date_begin)) then
                  l_tmp_tax_mil := l_accturn(i)
                                   .saldo * l_accrates(j).ir / 100 *
                                    (least(nvl(l_accrates(j).dat2,
                                               l_accturn (i).currdat),
                                           l_taxlist_mil(l).tax_date_end,
                                           l_when) -
                                     greatest(greatest(l_accrates(j).dat1,
                                                       l_accturn (i).prevdat),
                                              l_taxlist_mil(l).tax_date_begin)) * l_taxlist_mil(l)
                                   .tax_int / l_base;

                  bars_audit.trace('     (' ||
                                   to_char(greatest(greatest(l_accrates(j).dat1,
                                                             l_accturn (i)
                                                             .prevdat),
                                                    l_taxlist_mil(l)
                                                    .tax_date_begin),
                                           'DD/MM/YYYY') || '-' ||
                                   to_char(least(nvl(l_accrates(j).dat2,
                                                     l_accturn (i).currdat),
                                                 l_taxlist_mil(l)
                                                 .tax_date_end,
                                                 l_when),
                                           'DD/MM/YYYY') || ') ' ||
                                   to_char(least(nvl(l_accrates(j).dat2,
                                                     l_accturn (i).currdat),
                                                 l_taxlist_mil(l)
                                                 .tax_date_end,
                                                 l_when) -
                                           greatest(greatest(l_accrates(j).dat1,
                                                             l_accturn (i)
                                                             .prevdat),
                                                    l_taxlist_mil(l)
                                                    .tax_date_begin)) ||
                                   ' дн.' || 'TR_MIL = ' ||
                                   to_char(l_taxlist_mil(l).tax_int) ||
                                   ' TAX_MIL = ' || to_char(l_tmp_tax_mil));

                  l_tmp_tax_mil_l := l_tmp_tax_mil_l + l_tmp_tax_mil;
                end if;
              end loop; --k

              l_tmp_int_j := l_tmp_int_j + l_tmp_int;
            end if;
          end loop; -- j

          l_int     := l_int + l_tmp_int_j;
          l_tax     := l_tax + l_tmp_tax_k;
          l_tax_mil := l_tax_mil + l_tmp_tax_mil_l;
        end;
      end loop; -- i

      l_int     := round(l_int, 0);
      l_tax     := round(l_tax, 0);
      l_tax_mil := round(l_tax_mil, 0);

      if m = 0 then
        p_sh_int    := l_int;
        p_sh_tax    := l_tax;
        p_sh_taxmil := l_tax_mil;
      end if;

      if m = 1 then
        p_int    := l_int;
        p_tax    := l_tax;
        p_taxmil := l_tax_mil;
      end if;
      bars_audit.trace('По ' || l_msg || ' ставке за период начислено ' ||
                       to_char(l_int));
      bars_audit.trace('По ' || l_msg || ' ставке за период снято налога ' ||
                       to_char(l_tax));
      bars_audit.trace('По ' || l_msg ||
                       ' ставке за период снято военного сбора ' ||
                       to_char(l_tax_mil));
    end loop;

    bars_audit.trace('exit penalty_info');
  end penalty_info;
  /*
  Функция возвращает набор ДД deposit_id по которым было досрочное расторжение с ненулевым штрафованием после указаннной даты
  */
  function f_get_dptpenalty_set(p_datbeg date, p_dptid number default null)
    return t_depositset is
    l_depositset t_depositset := t_depositset();
    l_count      number;
  begin

    select /*+ use_hash(i a) */
     count(dc.deposit_id)
      into l_count
      from bars.accounts a, bars.int_accn i, dpt_deposit_clos dc
     where (nbs = '2638' or
           nbs = '2628' and ob22 not in ('16', '19', '22', '23') or
           nbs = '3622' or nbs = '3522')
       and (a.dazs >= p_datbeg or a.dazs is null)
       and i.acra = a.acc
       and i.id = 1
       and dc.action_id = 5
       and dc.acc = i.acc
       and dc.ref_dps is not null
       and dc.when >= p_datbeg
       and (dc.deposit_id = p_dptid or p_dptid is null);

    l_depositset.extend(l_count);
    for k in (select /*+ use_hash(i a) */
               rownum as rw, dc.deposit_id
                from bars.accounts a, bars.int_accn i, dpt_deposit_clos dc
               where (nbs = '2638' or
                     nbs = '2628' and ob22 not in ('16', '19', '22', '23') or
                     nbs = '3622' or nbs = '3522')
                 and (a.dazs >= p_datbeg or a.dazs is null)
                 and i.acra = a.acc
                 and i.id = 1
                 and dc.action_id = 5
                 and dc.acc = i.acc
                 and dc.ref_dps is not null
                 and dc.when >= p_datbeg
                 and (dc.deposit_id = p_dptid or p_dptid is null)) loop
      l_depositset(k.rw) := t_depositrec(k.deposit_id);
    end loop;

    return l_depositset;
  end;

  /*
  Функция расчитывает штрафные проценты по истории изменения штрафной проц. карточки
  за произвольный период
  для набора досрочно расторгнутых договоров
  */

  function f_penalty_info(p_datbeg date, -- дата начала расчета штрафных %% и налогов
                          p_datend date, -- дата окончания произвольного периода расчета штрафных %% и налогов
                          p_dptid  number default null) -- идентификатор договора/NULL - по портфелю
   return t_penaltyset -- набор записей договор - сумма штрафных%%, сумма штрафного налога, сумма штрафного военного сбора
   is
    pragma autonomous_transaction;
    l_depositset t_depositset := t_depositset();
    l_penaltyset t_penaltyset := t_penaltyset();

    l_int       number;
    l_tax       number;
    l_taxmil    number;
    l_sh_int    number;
    l_sh_tax    number;
    l_sh_taxmil number;
  begin
    l_depositset := f_get_dptpenalty_set(p_datbeg, p_dptid);
    l_penaltyset.extend(l_depositset.count);

    for k in 1 .. l_depositset.count loop
      penalty_info(p_dptid     => l_depositset(k).deposit_id,
                   p_datbeg    => p_datbeg,
                   p_datend    => p_datend,
                   p_int       => l_int,
                   p_tax       => l_tax,
                   p_taxmil    => l_taxmil,
                   p_sh_int    => l_sh_int,
                   p_sh_tax    => l_sh_tax,
                   p_sh_taxmil => l_sh_taxmil);
      rollback;
      l_penaltyset(k) := t_penaltyrec(l_depositset(k).deposit_id,
                                      l_int,
                                      l_tax,
                                      l_taxmil,
                                      l_sh_int,
                                      l_sh_tax,
                                      l_sh_taxmil);
    end loop;

    return l_penaltyset;
  end;

  -------------------------------------------------------------
  -- Удалить регулярные платежи, связанные с договором
  -------------------------------------------------------------
  procedure close_sto_argmnt(p_dptid    in number,
                             p_accid    in number,
                             p_argmntid in number) is
    l_title varchar2(30) := 'dpt_web.close_sto_argmnt: ';
  begin

    bars_audit.trace('%s Start.', l_title);

    if (coalesce(p_dptid, p_accid, p_argmntid, -1) = -1) then
      -- Вказано недостатня кількість параметрів для пошуку договору
      bars_audit.info(l_title ||
                      ' Вказано недостатня кількість параметрів для пошуку договору');
    end if;

    if (p_argmntid is not null) then

      bars_audit.trace('%s p_argmntid = %s.', l_title, to_char(p_argmntid));

      sto_all.del_regulartreaty(p_argmntid);

    else

      if (p_dptid is not null) then

        bars_audit.trace('%s p_dptid = %s.', l_title, to_char(p_dptid));

        for k in (select s.idd
                    from bars.dpt_accounts d
                    join bars.accounts a
                      on (a.acc = d.accid)
                    join bars.sto_det s
                      on (s.nlsb = a.nls and s.kvb = a.kv)
                   where d.dptid = p_dptid) loop

          delete from bars.sto_dat where idd = k.idd;

          delete from sto_det where idd = k.idd;

        end loop;

      else

        bars_audit.trace('%s p_accid = %s.', l_title, to_char(p_accid));

        for k in (select s.idd
                    from bars.dpt_accounts d
                    join bars.accounts a
                      on (a.acc = d.accid)
                    join bars.sto_det s
                      on (s.nlsb = a.nls and s.kvb = a.kv)
                   where d.accid = p_accid) loop

          delete from bars.sto_dat where idd = k.idd;

          delete from sto_det where idd = k.idd;

        end loop;

      end if;

    end if;

    bars_audit.trace('%s Exit.', l_title);

  end close_sto_argmnt;

  function forbidden_amount(p_acc in accounts.acc%type, p_amount in number)
    return int is
    l_title        varchar2(26) := 'dpt_web.forbidden_amount:';
    l_is_forbidden int := 0;
    l_min_summ     dpt_vidd.min_summ%type;
    l_disable_add  dpt_vidd.disable_add%type;
    l_comproc      dpt_vidd.comproc%type;
  begin
    bars_audit.trace(l_title ||
                     ':Starts with param. p_acc = %s, p_amount = %s',
                     to_char(p_acc),
                     to_char(p_amount));

    begin
      select nvl(dv.limit, 0) * 100, disable_add, nvl(dv.comproc, 0)
        into l_min_summ, l_disable_add, l_comproc
        from dpt_deposit d, dpt_vidd dv
       where d.vidd = dv.vidd
         and d.acc = p_acc;
    exception
      when no_data_found then
        l_is_forbidden := 0;
    end;

    if nvl(l_disable_add, 0) = 1 and l_comproc = 0 then
      l_is_forbidden := 1;
    else
      if (p_amount < l_min_summ) and l_comproc = 0 then
        l_is_forbidden := l_min_summ;
      else
        l_is_forbidden := 0;
      end if;
    end if;

    return l_is_forbidden;

  end forbidden_amount;

  function check_forbidden_amount(p_acc    in accounts.acc%type,
                                  p_amount in number) return int is
    l_title varchar2(36) := 'dpt_web.check_forbidden_amount:';
    ern constant positive := 803;
    err exception;
    erm   varchar2(1024);
    l_res number;
  begin
    bars_audit.trace('%s Starts with param. p_acc = %s,p_amount = %s',
                     l_title,
                     to_char(p_acc),
                     to_char(p_amount));
    begin
      l_res := forbidden_amount(p_acc, p_amount);
      if (l_res = 0) then
        return 0;
      elsif (l_res = 1) then
        erm := '******Вклад не передбачає поповнення!';
        raise err;
      else
        erm := '******Cума зарахування на депозитний рахунок менша за мінімальну суму поповнення вкладу ' ||
               to_char(l_res / 100);
        raise err;
      end if;
    exception
      when err then
        raise_application_error(- (20000 + ern), '\' || erm, true);
    end;
    return 0;
  end check_forbidden_amount;

  function check_for_extension(p_dptid in dpt_deposit.deposit_id%type)
    return number is
    l_out number;
  begin
    begin
      select 1
        into l_out
        from dpt_deposit d
       inner join dpt_vidd v
          on (v.vidd = d.vidd)
        left join dpt_extconsent ec
          on (ec.dpt_id = d.deposit_id and ec.dat_begin = d.dat_end)
        left join dpt_extrefusals er
          on (er.dptid = d.deposit_id and er.req_state = 1 and
             er.req_bnkdat <= sysdate)
        left join dpt_depositw dw -- COBUMMFO-5162
          on (dw.dpt_id = d.deposit_id and dw.tag = '2CLOS' and dw.value = 'Y')
       where d.deposit_id = p_dptid
         and (v.fl_dubl = 2 or ec.dpt_id is not null)
         and er.dptid is null
         and (nvl(d.cnt_dubl, 0) < nvl(v.term_dubl, 0) or
             nvl(v.term_dubl, 0) = 0)
         and dw.dpt_id is null;
    exception
      when no_data_found then
        l_out := 0;
    end;

    return l_out;
  end;

end dpt_web;
/

show errors;

grant EXECUTE on DPT_WEB to ABS_ADMIN;
grant EXECUTE on DPT_WEB to BARSUPL;
grant EXECUTE on DPT_WEB to BARS_ACCESS_DEFROLE;
grant EXECUTE on DPT_WEB to DPT;
grant EXECUTE on DPT_WEB to DPT_ADMIN;
grant EXECUTE on DPT_WEB to DPT_ROLE;
grant EXECUTE on DPT_WEB to VKLAD;
grant EXECUTE on DPT_WEB to WR_ALL_RIGHTS;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Package/DPT_WEB.sql =============*** End ***
PROMPT ===================================================================================== 
