
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/priocom_user.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.PRIOCOM_USER is
/**
	Пакет priocom_user содержит процедуры для работы пользователя
	Кредитной системы Приоком
*/

G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'version 1.6 08/07/2008';

G_AWK_HEADER_DEFS CONSTANT VARCHAR2(512) := '';

/**
 * header_version - возвращает версию заголовка пакета
 */
function header_version return varchar2;

/**
 * body_version - возвращает версию тела пакета
 */
function body_version return varchar2;


function unique_session_id return varchar2;


function ref_stub(p_ref in number) return number;

/**
 * allow_open_acc - возвращает флаг запрещения/разрешения открытия кредитных счетов
 */
function allow_open_acc return integer;
/**
 * create_person - регистрация клиента-физлица
 */
procedure create_person(
	-- output variables
	p_code			    out	integer,			-- унікальний код клієнта в АБС
	-- input variables
	p_mfo               in  varchar2,           -- МФО
	p_kod_fil			in	integer,			-- код філіалу
	p_ident			    in	varchar2,			-- код в податковій інспекції (до 14 символів)
	p_lname			    in	varchar2,			-- прізвище (до 64 символів)
	p_fname			    in	varchar2,			-- ім’я (до 64 символів)
	p_sname			    in	varchar2,			-- по-батькові (до 64 символів)
	p_birthday		    in	date,				-- дата народження
	p_birthplace		in	varchar2,			-- місце народження (до 64 символів)
	p_isStockholder	    in	integer,			-- ознака акціонера: 1/0
	p_isVIP			    in	integer,			-- ознака VIP- клієнта: 1/0
	p_isResident		in	integer,			-- ознака резидента: 1/0
	p_regdate			in	date,				-- дата відкриття
	p_debtorclass		in	integer,			-- клас позичальника
	p_gender			in	varchar2,			-- стать (М/Ж)
	p_addr			    in	varchar2,			-- поштова адреса
	p_k040			    in	varchar2,			-- країна НБУ(k040)
	p_k060			    in	varchar2,			-- тип інсайдера НБУ(k060)
	p_paspdouble		in	varchar2,			-- номер документу, що засвідчує особу
	p_paspseries		in	varchar2,			-- серія документу, що засвідчує особу
	p_paspdate		    in	date,				-- дата видачі документу, що засвідчує особу
	p_paspissuer		in	varchar2			-- ким виданий документ, що засвідчує особу
);


/**
 * test_create_person
 */
procedure test_create_person;

/**
 * truncate_acc_list - очистка временной таблицы tmp_priocom_acc_list
 */
procedure truncate_acc_list;

/**
 * truncate_clients - очистка временной таблицы tmp_priocom_clients
 */
procedure truncate_clients;

/**
 * truncate_clients_jur - очистка временной таблицы tmp_priocom_clients_jur
 */
procedure truncate_clients_jur;

/**
 * register_clients - регистрация клиентов по данным из tmp_priocom_clients
 */
procedure register_clients;

/**
 * register_clients - регистрация клиентов юрлиц по данным из tmp_priocom_clients_jur
 */
procedure register_clients_jur;

/**
 * truncate_accounts - очистка tmp_priocom_accounts
 */
procedure truncate_accounts;

/**
 * truncate_doc_list - очистка временной таблицы tmp_priocom_doc_list
 */
procedure truncate_doc_list;

/**
 * truncate_nbs_list - очистка временной таблицы tmp_priocom_nbs_list
 */
procedure truncate_nbs_list;

/**
 * open_accounts - открытие счетов
 */
procedure open_accounts;

/**
 * pay_documents - оплата документов
 */
procedure pay_documents(p_bankdate in date, p_fname in varchar2);

/**
 * final_documents_proc - финальная обработка пачки документов
 * @param p_bankdate - дата пачки
 * @param p_fname    - имя пачки
 */
procedure final_documents_proc(p_bankdate in date, p_fname in varchar2);

/**
 * query_limit_on_deposit - запрос на установку/снятие лимита на основной депозитный счет
 * @param p_mfo         - код МФО
 * @param p_operdate    - дата поточного операційного дня
 * @param p_currency    - код валюти
 * @param p_id_cart     - ідентифікатор картотеки
 * @param p_account     - номер аналітичного рахунку
 * @param p_suma        - Сума по депозиту (повна або частка), яка надається в заставу
 * @param p_lname       - прізвище
 * @param p_fname       - ім’я
 * @param p_sname       - по-батькові
 * @param p_block       - признак блокування\розблокування: 0 - заблокувати, 1 – розблокувати
 */
procedure query_limit_on_deposit(p_mfo in varchar2, p_operdate in date, p_currency in integer,
    p_id_cart in varchar2, p_account in varchar2, p_suma in number,
    p_lname in varchar2, p_fname in varchar2, p_sname in varchar2, p_block in integer);

/**
 * get_ob22 - возвращает спецпараметр ob22
 */
function get_ob22 return varchar2;

/**
 * get_cl_type - возвращает тип клиента для маски счета: 3-юр,5-физ
 */
function get_cl_type return varchar2;

/**
 * proc_limit_on_deposit - установка/снятие лимита на депозит
 */
procedure proc_limit_on_deposit(p_limit_id in integer);

/**
 * remove_dpt_limit_query - удаляет запись из таблицы dpt_limit_query
 */
procedure remove_dpt_limit_query(p_limit_id in integer);

/**
 * export_daily_documents - экспортирует документы за день
 * @param p_export_type - 0-работаем по перечню балансовых за p_datebeg,
 *                        1-работаем по перечню лицевых за p_datebeg,
 *                        2-отбираем все за период p_datebeg-p_dateend
 * @param p_datebeg - дата начала периода (или дата отбора для p_export_type in (0,1))
 * @param p_dateend - дата окончания периода
 * @param
 */
procedure export_daily_documents(p_export_type in integer, p_datebeg in date, p_dateend in date);

/**
 * insert_acc_list - вставка списка лицевых счетов
 * @param p_acc_list - список лицевых счетов через запятую
 */
procedure insert_acc_list(p_acc_list in varchar2);

/**
 * insert_nbs_list - вставка списка балансовых номеров счетов
 * @param p_nbs_list - список балансовых номеров счетов через запятую
 */
procedure insert_nbs_list(p_nbs_list in varchar2);

/**
 * insert_doc_list - вставка идентификаторов документов
 * @param p_doc_list - список идентификаторов документов
 */
procedure insert_doc_list(p_doc_list in varchar2);

/**
 * prepare_doc_for_revise - подготовка документов для ревизии
 * @param p_date - банковская дата
 */
procedure prepare_doc_for_revise(p_date in date);

/**
 * login_request - запрос на соединение к вертушку (всегда ок если вертушка поднята)
 */
procedure login_request;

end priocom_user;
/
CREATE OR REPLACE PACKAGE BODY BARS.PRIOCOM_USER is
/**
	Пакет priocom_user содержит процедуры для работы пользователя
	Кредитной системы Приоком

*/

G_BODY_VERSION  CONSTANT VARCHAR2(64)  := 'version 1.17 01/12/2008';

G_AWK_BODY_DEFS CONSTANT VARCHAR2(512) := '';

-- Глобальные переменные пакета
--============================================================
G_PRC_ISP           INTEGER;     -- исполнитель счета
G_PRC_GRP           INTEGER;     -- группа счета
G_PRC_PRI           VARCHAR2(3); -- код внутренней операции
G_PRC_PRE           VARCHAR2(3); -- код внешней операции
G_OB22              VARCHAR2(2); -- спецпараметр OB22
G_CL_TYPE           VARCHAR2(1); -- тип клиента 3-юр,5-физ
G_PRC_QTM           INTEGER;     -- время ожидания сообщения в очереди
G_ALLOW_OPEN_ACC    INTEGER;     -- флаг запрещения/разрешения открытия кредитных счетов
                                 -- (перечень кр. сч. определяется справочником priocom_credit_nbs)
--============================================================

-- определяем исключение на отсутствие сообщений в очереди
MQ_EMPTY_OR_TIMEOUT_EXCEPTION EXCEPTION;
PRAGMA EXCEPTION_INIT(MQ_EMPTY_OR_TIMEOUT_EXCEPTION, -25228);

/**
 * header_version - возвращает версию заголовка пакета
 */
function header_version return varchar2 is
begin
  return 'Package header PRIOCOM_USER '||G_HEADER_VERSION||'.'||chr(10)
	   ||'AWK definition: '||chr(10)
	   ||G_AWK_HEADER_DEFS;
end header_version;

/**
 * body_version - возвращает версию тела пакета
 */
function body_version return varchar2 is
begin
  return 'Package body PRIOCOM_USER '||G_BODY_VERSION||'.'||chr(10)
	   ||'AWK definition: '||chr(10)
	   ||G_AWK_BODY_DEFS;
end body_version;

/**
 * load_params - загрузка значений переменных модуля
 */
procedure load_params is
begin
  select to_number(val) into G_PRC_ISP from params where par='PRC_ISP';
  select to_number(val) into G_PRC_GRP from params where par='PRC_GRP';
  select val into G_PRC_PRI from params where par='PRC_PRI';
  select to_number(val) into G_PRC_QTM from params where par='PRC_QTM';
  -- по-умолчанию открывать кредитный счет для всех запрещается
  G_ALLOW_OPEN_ACC := 0;
end load_params;

function ref_stub(p_ref in number) return number is
begin
  priocom_audit.trace('Прочитано документ, REF='||p_ref);
  return p_ref;
end ref_stub;

function unique_session_id return varchar2 is
begin
  priocom_audit.trace('unique_session_id() invoked');
  for c in (select odbid from priocom_export_documents where unique_session_id=dbms_session.unique_session_id)
  loop
    priocom_audit.trace('odbid = '||c.odbid);
  end loop;
  return dbms_session.unique_session_id;
end unique_session_id;

function allow_open_acc return integer is
begin
  return G_ALLOW_OPEN_ACC;
end allow_open_acc;

/**
 * reset_bankdate - переустановка банковской даты
 */
procedure reset_bankdate is
  erm			varchar2 (200);
  ern			constant positive := 015;
  err			exception;
  l_bankdate    date;
  l_is_open     integer;
begin
  l_bankdate := bankdate_g;
  select to_number(val) into l_is_open from params where par='RRPDAY';
  if l_is_open=0 then
    erm := '0001 - Банківську дату '||to_char(l_bankdate,'DD.MM.YYYY')||' закрито. Робота неможлива.';
    raise err;
  end if;
  gl.pl_dat(l_bankdate);
exception
    when err then
        priocom_audit.error(erm);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    when others then
        declare
            l_sqlerrm varchar2(4000);
        begin
            l_sqlerrm := substr(SQLERRM, 1, 1024);
            priocom_audit.error(substr(l_sqlerrm||chr(10)||dbms_utility.format_error_backtrace,1,3500));
            raise;
        end;
end reset_bankdate;

/**
 * create_person - регистрация клиента-физлица
 */
procedure create_person(
	-- output variables
	p_code			    out	integer,			-- унікальний код клієнта в АБС
	-- input variables
	p_mfo               in  varchar2,           -- МФО
	p_kod_fil			in	integer,			-- код філіалу
	p_ident			    in	varchar2,			-- код в податковій інспекції (до 14 символів)
	p_lname			    in	varchar2,			-- прізвище (до 64 символів)
	p_fname			    in	varchar2,			-- ім’я (до 64 символів)
	p_sname			    in	varchar2,			-- по-батькові (до 64 символів)
	p_birthday		    in	date,				-- дата народження
	p_birthplace		in	varchar2,			-- місце народження (до 64 символів)
	p_isStockholder	    in	integer,			-- ознака акціонера: 1/0
	p_isVIP			    in	integer,			-- ознака VIP- клієнта: 1/0
	p_isResident		in	integer,			-- ознака резидента: 1/0
	p_regdate			in	date,				-- дата відкриття
	p_debtorclass		in	integer,			-- клас позичальника
	p_gender			in	varchar2,			-- стать (М/Ж)
	p_addr			    in	varchar2,			-- поштова адреса
	p_k040			    in	varchar2,			-- країна НБУ(k040)
	p_k060			    in	varchar2,			-- тип інсайдера НБУ(k060)
	p_paspdouble		in	varchar2,			-- номер документу, що засвідчує особу
	p_paspseries		in	varchar2,			-- серія документу, що засвідчує особу
	p_paspdate		    in	date,				-- дата видачі документу, що засвідчує особу
	p_paspissuer		in	varchar2			-- ким виданий документ, що засвідчує особу
) is
	erm				    varchar2 (200);
	ern				    constant positive := 001;
	err				    exception;

	l_rnk				customer.rnk%type;
	l_nmk               customer.nmk%type;
	l_nmkk              customer.nmkk%type;
begin
  priocom_audit.trace('Викликано процедуру priocom_user.create_person()');
  if p_mfo<>gl.kf then
    erm := '0001 - МФО задано невірно';
    raise err;
  end if;
  -- контроль на наличие в базе клиента с аналогичными ключевыми реквизитами
  if p_ident is null or p_ident is not null and p_ident='9999999999' then -- идент.код не задан
    -- ищем по серии и номеру паспорта
    begin
	  select rnk into l_rnk from person where ser=p_paspseries and numdoc=p_paspdouble;
	  erm := '0002 - Клієнт з паспортними даними '||p_paspseries||' '||p_paspdouble||' вже існує.';
      raise err;
	exception
	  when no_data_found then
	    null;  -- не нашли и нормально
	  when too_many_rows then
	    begin
	      select rnk into l_rnk from person where ser=p_paspseries and numdoc=p_paspdouble
	      and bday=p_birthday;
	      erm := '0002 - Клієнт з паспортними даними '||p_paspseries||' '||p_paspdouble||', датою народження '
	        ||to_char(p_birthday,'DD.MM.YYYY')||' вже існує.';
          raise err;
	    exception
	      when no_data_found then
	        null;  -- дата рождения не совпала, считаем клиент новый
	      when too_many_rows then
	        erm := '0002 - Клієнтів з паспортними даними '||p_paspseries||' '||p_paspdouble||', датою народження '
	        ||to_char(p_birthday,'DD.MM.YYYY')||' існує більше одного. Виберіть з існуючих.';
            raise err;
	    end;
	end;
  else
    begin
      priocom_audit.trace('код = '||p_ident||', серия = '||p_paspseries||', номер = '||p_paspdouble);
      select c.rnk into l_rnk from customer c, person p
      where c.rnk=p.rnk and c.okpo=p_ident and p.ser=p_paspseries and p.numdoc=p_paspdouble;
      erm := '0002 - Клієнт з ідент. кодом '||p_ident||' та паспортними даними '||p_paspseries||' '||p_paspdouble||
      ' вже існує.';
      raise err;
    exception
      when no_data_found then
	    null;  -- не нашли и нормально
	    priocom_audit.trace('клієнта із заданими ключовими реквізитами не знайдено');
	  when too_many_rows then
	    begin
	      select c.rnk into l_rnk from customer c, person p
	      where c.rnk=p.rnk and c.okpo=p_ident and p.ser=p_paspseries and p.numdoc=p_paspdouble
	      and p.bday=p_birthday;
	      erm := '0002 - Клієнт з кодом '||p_ident||' та паспортними даними '||p_paspseries||' '
	        ||p_paspdouble||', датою народження '||to_char(p_birthday,'DD.MM.YYYY')||' вже існує.';
          raise err;
	    exception
	      when no_data_found then
	        null;  -- дата рождения не совпала, считаем клиент новый
	      when too_many_rows then
	        erm := '0002 - Клієнтів з кодом '||p_ident||' та паспортними даними '||p_paspseries||' '
	        ||p_paspdouble||', датою народження '||to_char(p_birthday,'DD.MM.YYYY')
	        ||' існує більше одного. Виберіть з існуючих.';
            raise err;
	    end;
    end;
  end if;
  l_nmk := substr(trim(p_lname)||' '||trim(p_fname)||' '||trim(p_sname),1,70);
  l_nmkk := substr(trim(p_lname)||' '||substr(trim(p_fname),1,1)||'.'||substr(trim(p_sname),1,1)||'.',1,35);
  KL.setCustomerAttr(
	  Rnk_           => l_rnk,   		-- Customer number
	  Custtype_      => 3,				-- Тип клиента: 1-банк, 2-юр.лицо, 3-физ.лицо
	  Nd_            => NULL,		    -- p_cc_id,	-- № договора
	  Nmk_           => l_nmk,			-- Наименование клиента
	  Nmkv_	         => l_nmk,	        -- Наименование клиента международное
	  Nmkk_          => l_nmkk,	        -- Наименование клиента краткое
	  Adr_           => substr(p_addr,1,70),	        -- Адрес клиента
	  Codcagent_     => case            -- Физическое лицо-резидент  -- Характеристика
	                    when p_isResident=1 then 5
	                    when p_isResident=0 then 6
	                    else NULL
	                    end,
	  Country_       => to_number(p_k040),		-- Страна
	  Prinsider_     => to_number(p_k060),	    -- Признак инсайдера
	  Tgr_           => 2,	            -- Тип гос.реестра  2 - Реєстр ДРФО (фiз.осiб)
	  Okpo_          => p_ident,	    -- ОКПО
	  Stmt_          => NULL,	        -- Формат выписки
	  Sab_           => NULL,	        -- Эл.код
	  DATEOn_        => p_regdate,	    -- Дата регистрации
	  Taxf_          => NULL,	        -- Налоговый код
	  CReg_          => NULL,	        -- Код обл.НИ
	  CDst_          => NULL,	        -- Код район.НИ
	  Adm_           => NULL,	        -- Админ.орган
	  RgTax_         => NULL,	        -- Рег номер в НИ
	  RgAdm_         => NULL,	        -- Рег номер в Адм.
	  DATET_         => NULL,		    -- Дата рег в НИ
	  DATEA_         => NULL,		    -- Дата рег. в администрации
	  Ise_           => NULL,	        -- Инст. сек. экономики
	  Fs_            => NULL,		    -- Форма собственности
	  Oe_            => NULL,	        -- Отрасль экономики
	  Ved_           => NULL,	        -- Вид эк. деятельности
	  Sed_           => NULL,		    -- Форма хозяйствования
	  Notes_         => 'Зареєстровано Кредитною системою',	-- Примечание
	  Notesec_       => NULL,	        -- Примечание для службы безопасности
	  CRisk_         => p_debtorclass,	        -- Категория риска
	  Pincode_       => NULL,	        --
	  RnkP_          => NULL,	        -- Рег. номер холдинга
	  Lim_           => NULL,	        -- Лимит кассы
	  NomPDV_        => NULL,	        -- № в реестре плат. ПДВ
	  MB_            => NULL,	 	    -- Принадл. малому бизнесу
	  BC_            => NULL,           -- Признак НЕклиента банка
	  Tobo_          => Tobopack.getTobo, -- Код безбалансового отделения
	  Isp_           => G_PRC_ISP         -- Менеджер клиента (ответ. исполнитель)
    );
    update customer set nd=rnk where rnk=l_rnk;
    KL.setPersonAttr(
	  Rnk_           => l_rnk,
	  Sex_           => case
	                    when p_gender='М' then 1
	                    when p_gender='Ж' then 2
	                    else 0
	                    end,
	  Passp_         => 1,  -- Паспорт
	  Ser_           => p_paspseries,
	  Numdoc_        => p_paspdouble,
	  PDate_         => p_paspdate,
	  Organ_         => p_paspissuer,
	  BDay_          => p_birthday,
	  BPlace_        => p_birthplace,
	  TelD_          => NULL,
	  TelW_          => NULL
	);
    kl.setCustomerElement(l_rnk, 'LNAME', p_lname, 0);
    kl.setCustomerElement(l_rnk, 'FNAME', p_fname, 0);
    kl.setCustomerElement(l_rnk, 'MNAME', p_sname, 0);
    if p_isVIP=1 then
        kl.setCustomerElement(l_rnk, 'VIP_K', '1', 0);
    end if;
    priocom_audit.info('Зареєстрований новий клієнт. RNK='||l_rnk||'.');
    p_code := l_rnk;
exception
    when err then
        priocom_audit.error(erm);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    when others then
        declare
            l_sqlerrm varchar2(4000);
        begin
            l_sqlerrm := substr(SQLERRM, 1, 1024);
            priocom_audit.error(substr(l_sqlerrm||chr(10)||dbms_utility.format_error_backtrace,1,3500));
            raise;
        end;
end create_person;

/**
 * test_create_person
 */
procedure test_create_person is
  l_code  integer;
begin
  priocom_user.create_person(
	-- output variables
	p_code			    => l_code,			-- унікальний код клієнта в АБС
	-- input variables
	p_mfo               => gl.kf,
	p_kod_fil			=> NULL,			-- код філіалу
	p_ident			    => '99999',			-- код в податковій інспекції (до 14 символів)
	p_lname			    => 'Приживалов',			-- прізвище (до 64 символів)
	p_fname			    => 'Иван',			-- ім’я (до 64 символів)
	p_sname			    => 'Петрович',			-- по-батькові (до 64 символів)
	p_birthday		    => to_date('01.02.1970','DD.MM.YYYY'),				-- дата народження
	p_birthplace		=> 'Тьмутаракань',			-- місце народження (до 64 символів)
	p_isStockholder	    => 1,			-- ознака акціонера: 1/0
	p_isVIP			    => 1,			-- ознака VIP- клієнта: 1/0
	p_isResident		=> 1,			-- ознака резидента: 1/0
	p_regdate			=> bankdate_g,				-- дата відкриття
	p_debtorclass		=> 2,			-- клас позичальника
	p_gender			=> 'М',			-- стать (М/Ж)
	p_addr			    => 'ул. Приживальского 12',			-- поштова адреса
	p_k040			    => '804',			-- країна НБУ(k040)
	p_k060			    => '99',			-- тип інсайдера НБУ(k060)
	p_paspdouble		=> '012048',			-- номер документу, що засвідчує особу
	p_paspseries		=> 'CC',			-- серія документу, що засвідчує особу
	p_paspdate		    => to_date('01.02.1987','DD.MM.YYYY'),				-- дата видачі документу, що засвідчує особу
	p_paspissuer		=> 'Рівненський РВ УМВС'			-- ким виданий документ, що засвідчує особу
  );
  dbms_output.put_line('Зареєстрований клієнт, RNK='||l_code);
end test_create_person;

/**
 * truncate_acc_list - очистка временной таблицы tmp_priocom_acc_list
 */
procedure truncate_acc_list is
begin
    execute immediate 'truncate table tmp_priocom_acc_list';
    priocom_audit.trace('Очищено таблицю tmp_priocom_acc_list');
end truncate_acc_list;

/**
 * truncate_doc_list - очистка временной таблицы tmp_priocom_doc_list
 */
procedure truncate_doc_list is
begin
    execute immediate 'truncate table tmp_priocom_doc_list';
    priocom_audit.trace('Очищено таблицю tmp_priocom_doc_list');
end truncate_doc_list;

/**
 * truncate_nbs_list - очистка временной таблицы tmp_priocom_nbs_list
 */
procedure truncate_nbs_list is
begin
    execute immediate 'truncate table tmp_priocom_nbs_list';
    priocom_audit.trace('Очищено таблицю tmp_priocom_nbs_list');
end truncate_nbs_list;

/**
 * truncate_clients - очистка временной таблицы tmp_priocom_clients
 */
procedure truncate_clients is
begin
    execute immediate 'truncate table tmp_priocom_clients';
    priocom_audit.trace('Очищено таблицю tmp_priocom_clients');
end truncate_clients;

/**
 * truncate_clients_jur - очистка временной таблицы tmp_priocom_clients_jur
 */
procedure truncate_clients_jur is
begin
    execute immediate 'truncate table tmp_priocom_clients_jur';
    priocom_audit.trace('Очищено таблицю tmp_priocom_clients_jur');
end truncate_clients_jur;

/**
 * register_clients - регистрация клиентов по данным из tmp_priocom_clients
 */
procedure register_clients is
    cursor cls is select * from tmp_priocom_clients for update nowait;
    l_client    tmp_priocom_clients%rowtype;
    l_code      integer;
    l_sqlcode   number;
    l_sqlerrm   varchar2(4000);
begin
    priocom_audit.trace('Викликано процедуру реєстрації клієнтів: register_clients');
    -- переинициализация на случай изм. банк. даты
    reset_bankdate;
    open cls;
    loop
        fetch cls into l_client;
        exit when cls%notfound;
        savepoint before_create_person;
        begin
            priocom_user.create_person(
                p_code			    => l_code,
                p_mfo               => l_client.mfo,
	            p_kod_fil			=> l_client.kod_fil,
	            p_ident			    => l_client.ident,
	            p_lname			    => l_client.lname,
	            p_fname			    => l_client.fname,
	            p_sname			    => l_client.sname,
	            p_birthday		    => l_client.birthday,
	            p_birthplace		=> l_client.birthplace,
	            p_isStockholder	    => l_client.isStockholder,
	            p_isVIP			    => l_client.isVIP,
	            p_isResident		=> l_client.isResident,
	            p_regdate			=> l_client.regdate,
	            p_debtorclass		=> l_client.debtorclass,
	            p_gender			=> l_client.gender,
	            p_addr			    => l_client.addr,
	            p_k040			    => l_client.k040,
	            p_k060			    => l_client.k060,
	            p_paspdouble		=> l_client.paspdouble,
	            p_paspseries		=> l_client.paspseries,
	            p_paspdate		    => l_client.paspdate,
	            p_paspissuer		=> l_client.paspissuer
            );
            update tmp_priocom_clients set code=l_code,result=0,message=null
            where current of cls;
        exception when others then
            rollback to before_create_person;
            l_sqlcode := SQLCODE;
            l_sqlerrm := trim(substr(SQLERRM,1,4000));
            update tmp_priocom_clients set code=null,result=l_sqlcode,message=l_sqlerrm
            where current of cls;
            priocom_audit.error('Помилка при реєстрації клієнта. Код '||l_sqlcode||'.'
            ||chr(10)||substr(l_sqlerrm,1,3900));
        end;
    end loop;
    close cls;
end register_clients;

/**
 * create_jur - регистрация юрлица
 */
procedure create_jur(p_company in tmp_priocom_clients_jur%rowtype, p_code out number) is
    erm				    varchar2 (200);
    ern				    constant positive := 013;
    err				    exception;
    l_rnk               customer.rnk%type;
    l_sed               customer.sed%type;
begin
  priocom_audit.trace('Викликано процедуру priocom_user.create_jur()');
  if p_company.mfo<>gl.kf then
    erm := '0001 - МФО задано невірно';
    raise err;
  end if;
  -- контроль на наличие в базе клиента с аналогичными ключевыми реквизитами
  if p_company.okpo<>'99999' then
    begin
      select rnk into l_rnk from customer where okpo=p_company.okpo and rownum=1;
      erm := '0002 - Юрособа із вказаним ЗКПО='||p_company.okpo||' вже існує в АБС. RNK='||l_rnk;
      raise err;
    exception when no_data_found then null;
    end;
  end if;
  begin
    select k051 into l_sed from kl_k050 where k050=p_company.k050;
  exception when no_data_found then
    l_sed := null;
  end;
  KL.setCustomerAttr(
	  Rnk_           => l_rnk,   		-- Customer number
	  Custtype_      => 2,				-- Тип клиента: 1-банк, 2-юр.лицо, 3-физ.лицо
	  Nd_            => NULL,		    -- p_cc_id,	-- № договора
	  Nmk_           => p_company.name,			-- Наименование клиента
	  Nmkv_	         => p_company.name,	        -- Наименование клиента международное
	  Nmkk_          => p_company.sysname,	        -- Наименование клиента краткое
	  Adr_           => p_company.legaladdr,	        -- Адрес клиента
	  Codcagent_     => case            -- Юридическое лицо-резидент  -- Характеристика
	                    when p_company.isResident=1 then 3
	                    when p_company.isResident=0 then 4
	                    else NULL
	                    end,
	  Country_       => case
	                    when p_company.isResident=1 then 804
	                    else NULL
	                    end,		-- Страна
	  Prinsider_     => p_company.k060,	    -- Признак инсайдера
	  Tgr_           => 1,	            -- Тип гос.реестра  1 - Реєстр ЄДРПОУ
	  Okpo_          => p_company.okpo,	    -- ОКПО
	  Stmt_          => NULL,	        -- Формат выписки
	  Sab_           => NULL,	        -- Эл.код
	  DATEOn_        => p_company.regdate,	    -- Дата регистрации
	  Taxf_          => p_company.salestaxcode,	        -- Налоговый код
	  CReg_          => p_company.taxregionnum,	        -- Код обл.НИ
	  CDst_          => p_company.taxadminnum,	        -- Код район.НИ
	  Adm_           => p_company.pubadminplace,	        -- Админ.орган
	  RgTax_         => p_company.taxnum,	        -- Рег номер в НИ
	  RgAdm_         => p_company.pubadminnum,	        -- Рег номер в Адм.
	  DATET_         => p_company.taxregdate,		    -- Дата рег в НИ
	  DATEA_         => p_company.pubadmindate,		    -- Дата рег. в администрации
	  Ise_           => p_company.k070,	        -- Инст. сек. экономики
	  Fs_            => p_company.k080,		    -- Форма собственности
	  Oe_            => p_company.k090,	        -- Отрасль экономики
	  Ved_           => p_company.k110,	        -- Вид эк. деятельности
	  Sed_           => l_sed,		    -- Форма хозяйствования
	  Notes_         => 'Зареєстровано Кредитною системою',	-- Примечание
	  Notesec_       => NULL,	        -- Примечание для службы безопасности
	  CRisk_         => p_company.debtorclass,	        -- Категория риска
	  Pincode_       => NULL,	        --
	  RnkP_          => NULL,	        -- Рег. номер холдинга
	  Lim_           => NULL,	        -- Лимит кассы
	  NomPDV_        => NULL,	        -- № в реестре плат. ПДВ
	  MB_            => case	 	    -- Принадл. малому бизнесу
	                    when p_company.smallbis=1 then '1'
	                    when p_company.smallbis=0 then '9'
	                    else null
	                    end,
	  BC_            => NULL,           -- Признак НЕклиента банка
	  Tobo_          => Tobopack.getTobo, -- Код безбалансового отделения
	  Isp_           => G_PRC_ISP         -- Менеджер клиента (ответ. исполнитель)
    );
    p_code := l_rnk;
    update customer set nd=rnk where rnk=l_rnk;
    if p_company.isVIP=1 then
        kl.setCustomerElement(l_rnk, 'VIP_K', '1', 0);
    end if;
    kl.setCorpAttr(
      Rnk_           => l_rnk,
      Nmku_          => null,
      Ruk_           => p_company.fiodirector,
      Telr_          => p_company.legaladdr_phone,
      Buh_           => p_company.fiosyn,
      Telb_          => null,
      TelFax_        => p_company.legaladdr_fax,
      EMail_         => p_company.legaladdr_email,
      SealId_        => null
    );
    -- посада директора
    kl.setCustomerElement(l_rnk, 'WORKU', p_company.posdirector, 0);
    -- фактична адреса
    kl.setCustomerElement(l_rnk, 'FADR ', p_company.addr, 0);
    -- фактична адреса
    kl.setCustomerElement(l_rnk, 'ADRP ', p_company.addr, 0);
    -- юридична адреса
    kl.setCustomerElement(l_rnk, 'ADRU ', p_company.legaladdr, 0);
    -- email
    kl.setCustomerElement(l_rnk, 'EMAIL', p_company.legaladdr_email, 0);
    -- індекс поштової адреси
    kl.setCustomerElement(l_rnk, 'FGIDX', p_company.addr_postind, 0);
    -- інформація про засновників
    kl.setCustomerElement(l_rnk, 'OSN  ', p_company.fiofounder||', код '||p_company.okpofounder, 0);
    -- запись в журнал
    priocom_audit.info('Зареєстровано юридичну особу. RNK='||l_rnk||', ЗКПО='||p_company.okpo);
exception
    when err then
        priocom_audit.error(erm);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    when others then
        declare
            l_sqlerrm varchar2(4000);
        begin
            l_sqlerrm := substr(SQLERRM, 1, 1024);
            priocom_audit.error(substr(l_sqlerrm||chr(10)||dbms_utility.format_error_backtrace,1,3500));
            raise;
        end;
end create_jur;

/**
 * register_clients_jur - регистрация клиентов юрлиц по данным из tmp_priocom_clients_jur
 */
procedure register_clients_jur is
    cursor cls is select * from tmp_priocom_clients_jur where result is null for update nowait;
    l_client    tmp_priocom_clients_jur%rowtype;
    l_code      integer;
    l_sqlcode   number;
    l_sqlerrm   varchar2(4000);
begin
    priocom_audit.trace('Викликано процедуру реєстрації юросіб: register_clients_jur');
    -- переинициализация на случай изм. банк. даты
    reset_bankdate;
    open cls;
    loop
        fetch cls into l_client;
        exit when cls%notfound;
        savepoint before_create_jur;
        begin
            priocom_user.create_jur(p_company => l_client, p_code => l_code);
            update tmp_priocom_clients_jur set code=l_code,result=0,message=null
            where current of cls;
        exception when others then
            rollback to before_create_jur;
            l_sqlcode := SQLCODE;
            l_sqlerrm := trim(substr(SQLERRM,1,4000));
            update tmp_priocom_clients_jur set code=null,result=l_sqlcode,message=l_sqlerrm
            where current of cls;
            priocom_audit.error('Помилка при реєстрації юрособи. Код '||l_sqlcode||'.'
            ||chr(10)||substr(l_sqlerrm,1,3900));
        end;
    end loop;
    close cls;
end register_clients_jur;

/**
 * truncate_accounts - очистка tmp_priocom_accounts
 */
procedure truncate_accounts is
begin
    execute immediate 'truncate table tmp_priocom_accounts';
    priocom_audit.trace('Очищено таблицю tmp_priocom_accounts');
end truncate_accounts;


/**
 * Генерируем лицевой счет согласно маскам Сбербанка для кредитной задачи
 */
function make_sber_nls(p_acc_row in tmp_priocom_accounts%rowtype) return varchar2 is
   	erm			varchar2 (200);
	ern			constant positive := 007;
	err			exception;

    l_nls       varchar2(14);
    l_mask      nlsmask.mask%type;
begin
    begin
      select mask into l_mask from nlsmask where maskid='PRC_'||p_acc_row.r020;
    exception when no_data_found then
      erm := '1 - Маска рахунку не задана. Балансовий = '||p_acc_row.r020;
      raise err;
    end;
    G_OB22      := p_acc_row.ob22;
    G_CL_TYPE   := case
                     when p_acc_row.cl_type=1 then '3'
                     when p_acc_row.cl_type=2 then '5'
                     else '0'
                   end;
    -- пользуемся стандартным механизмом расчета лицевых
    l_nls := F_NEWNLS2(null, 'PRC_'||p_acc_row.r020, p_acc_row.r020, p_acc_row.code, null);
    return l_nls;
exception
    when err then
        priocom_audit.error(erm);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
end make_sber_nls;

/**
 * open_single_account - открытие счета
 */
procedure open_single_account(p_acc_row in tmp_priocom_accounts%rowtype,
                              p_acc out integer, p_nls out varchar2, p_kv out integer) is
  	erm			varchar2 (200);
	ern			constant positive := 002;
	err			exception;

    l_acc       integer;
    l_nls       varchar2(14);
    l_kv        integer;
    l_ret       number;
    l_nms       varchar2(70);
    l_pap_id    integer;
    l_nmk       customer.nmk%type;
    l_nbs       priocom_credit_nbs.nbs%type;
begin
    if p_acc_row.mfo<>gl.kf then
        erm := '0001 - МФО задано невірно';
        raise err;
    end if;
    if p_acc_row.code is not null then
        begin
            select nmk into l_nmk from customer where rnk=p_acc_row.code;
        exception when no_data_found then
            erm := '0002 - Код клієнта('||p_acc_row.code||') не знайдено';
            raise err;
        end;
    end if;
    -- счет должен быть в перечне балансовых кред. системы
    begin
      select nbs into l_nbs from priocom_credit_nbs where nbs=p_acc_row.r020;
    exception when no_data_found then
      erm := '0003 - Кредитній системі заборонено відкривати рахунки по балансовому '||p_acc_row.r020;
      raise err;
    end;
    -- генерируем лицевой счет
    l_nls := make_sber_nls(p_acc_row);
    bars_audit.trace('Розраховано особовий номер рахунку: '||l_nls);
    -- открываем счет
    l_ret := null;
    -- определяемся с наименованием счета(!! TODO: выяснить как правильно именовать, т.к. наименование не передается !!)

    if p_acc_row.code is not null then
        l_nms := l_nmk;
    elsif p_acc_row.idcontract is not null then
        l_nms := 'Рахунок за договором '||p_acc_row.idcontract;
    else
        l_nms := 'Рахунок загальний';
    end if;
    op_reg_ex(99, 0, 0, G_PRC_GRP, l_ret, p_acc_row.code, l_nls, p_acc_row.currency, l_nms,
    'ODB', G_PRC_GRP, l_acc);
    -- сразу блокируем счет с наивысшим приоритетом
    update accounts set blkd=99,blkk=99 where acc=l_acc;
    -- s040 считаем равным дате открытия счета
    -- пишем параметр accounts.mdate - дату гашения
    if p_acc_row.s050 is not null then
        update accounts set mdate=p_acc_row.s050 where acc=l_acc;
    end if;
    -- вставка в SPECPARAM
    if  p_acc_row.cfpledge is not null or
        p_acc_row.s080 is not null or
        p_acc_row.s120 is not null or
        p_acc_row.s180 is not null or
        p_acc_row.s181 is not null or
        p_acc_row.s182 is not null or
        p_acc_row.s190 is not null or
        p_acc_row.s200 is not null or
        p_acc_row.r011 is not null or
        p_acc_row.r013 is not null
    then
        insert into specparam(
            acc,
            s031,
            s080,
            s120,
            s180,
            s181,
            s182,
            s190,
            s200,
            r011,
            r013)
        values(
            l_acc,
            p_acc_row.cfpledge,
            p_acc_row.s080,
            p_acc_row.s120,
            p_acc_row.s180,
            p_acc_row.s181,
            p_acc_row.s182,
            p_acc_row.s190,
            p_acc_row.s200,
            p_acc_row.r011,
            p_acc_row.r013
        );
    end if;
    -- вставка в SPECPARAM_INT
    if  p_acc_row.ob22              is not null or
        p_acc_row.idcontract        is not null or
        p_acc_row.creditsupplycode  is not null or
        p_acc_row.kl_kpr            is not null or
        p_acc_row.kod_bizn          is not null or
        p_acc_row.ndog_z            is not null or
        p_acc_row.currency_z        is not null or
        p_acc_row.s040_z            is not null or
        p_acc_row.s050_z            is not null or
        p_acc_row.lsumm             is not null
    then
        insert into specparam_int(
            acc,
            ob22,
            priocom_idcontract,
            priocom_cr_supplycode,
            priocom_kl_kpr,
	        priocom_kod_bizn,
	        priocom_ndog_z,
	        priocom_currency_z,
	        priocom_s040_z,
	        priocom_s050_z,
            priocom_lsumm)
        values(
            l_acc,
            p_acc_row.ob22,
            p_acc_row.idcontract,
            p_acc_row.creditsupplycode,
            p_acc_row.kl_kpr,
            p_acc_row.kod_bizn,
            p_acc_row.ndog_z,
            p_acc_row.currency_z,
            p_acc_row.s040_z,
            p_acc_row.s050_z,
            p_acc_row.lsumm);
    end if;
    -- проставляем %-ставку
    if p_acc_row.procent is not null then
        -- определяем признак актива/пассива для балансового
        select decode(pap,1,0,1) into l_pap_id from ps where nbs=p_acc_row.r020;
        insert into int_accn(acc,id,metr,basem,basey,freq,s,io,stp_dat,acr_dat)
        values(l_acc, l_pap_id, 0, 0, 0, 1, 0, 0,
        to_date('01.01.1901','DD.MM.YYYY'), to_date('01.01.1901','DD.MM.YYYY'));
        insert into int_ratn(acc,id,bdat,ir)
        values(l_acc, l_pap_id, gl.bDATE, p_acc_row.procent);
    end if;
    -- присваиваем out-переменные
    priocom_audit.info('Відкрито рахунок (NLS,KV,ACC)=('||l_nls||','||l_kv||','||l_acc||')');
    p_acc := l_acc;
    p_nls := l_nls;
    p_kv  := l_kv;
exception
    when err then
        priocom_audit.error(erm);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    when others then
        declare
            l_sqlerrm varchar2(4000);
        begin
            l_sqlerrm := substr(SQLERRM, 1, 1024);
            priocom_audit.error(substr(l_sqlerrm||chr(10)||dbms_utility.format_error_backtrace,1,3500));
            raise;
        end;
end open_single_account;

/**
 * open_accounts - открытие счетов
 */
procedure open_accounts is
    cursor c is select * from tmp_priocom_accounts where result is null for update nowait;
    l_acc_row   tmp_priocom_accounts%rowtype;
    l_sqlcode   number;
    l_sqlerrm   varchar2(4000);
    l_acc       integer;
    l_nls       varchar2(14);
    l_kv        integer;
begin
    priocom_audit.trace('Викликано процедуру відкриття рахунків open_accounts');
    G_ALLOW_OPEN_ACC := 1; -- разрешаем себе открытие счетов
    -- переинициализация на случай изм. банк. даты
    reset_bankdate;
    open c;
    loop
        fetch c into l_acc_row;
        exit when c%notfound;
        savepoint before_open_single_account;
        begin
            open_single_account(l_acc_row, l_acc, l_nls, l_kv);
            update tmp_priocom_accounts set account=l_nls,result=0,message=null
            where current of c;
        exception when others then
            rollback to before_open_single_account;
            l_sqlcode := SQLCODE;
            l_sqlerrm := trim(substr(SQLERRM,1,4000));
            update tmp_priocom_accounts set account=null,result=l_sqlcode,message=l_sqlerrm
            where current of c;
            priocom_audit.error('Помилка при відкритті рахунку. Код '||l_sqlcode||'.'
            ||chr(10)||substr(l_sqlerrm,1,3900));
        end;
    end loop;
    close c;
end open_accounts;

/**
 * pay_doc - оплата одного документа
 */
procedure pay_doc(p_doc in priocom_documents%rowtype, p_ref out integer) is
  	erm			varchar2 (200);
	ern			constant positive := 003;
	err			exception;

    l_acc_a     accounts%rowtype;
    l_acc_b     accounts%rowtype;
    l_new_ref   integer;
    l_cust_a    customer%rowtype;
    l_cust_b    customer%rowtype;
    l_flag      varchar2(1);
    l_vob       vob.vob%type;
    l_sk        oper.sk%type;
    l_stat		fdat.stat%type;
    l_cur_date  date;
begin
    if p_doc.mfo_a<>p_doc.mfo_b or p_doc.mfo_a<>gl.kf then
        erm := '0001 - МФО_А, МФО_Б задано невірно';
        raise err;
    end if;
    begin
        select * into l_acc_a from accounts where kv=p_doc.currency and nls=p_doc.account1;
        select * into l_cust_a from customer where rnk=(select rnk from cust_acc where acc=l_acc_a.acc);
    exception when no_data_found then
        erm := '0002 - Рахунок не знайдено('||p_doc.currency||','||p_doc.account1||')';
        raise err;
    end;
    begin
        select * into l_acc_b from accounts where kv=p_doc.currency and nls=p_doc.account2;
        select * into l_cust_b from customer where rnk=(select rnk from cust_acc where acc=l_acc_b.acc);
    exception when no_data_found then
        erm := '0003 - Рахунок не знайдено('||p_doc.currency||','||p_doc.account2||')';
        raise err;
    end;
    if l_acc_a.blkd!=0 then
        erm := '0004 - Рахунок ('||l_acc_a.kv||','||l_acc_a.nls||') заблоковано на дебет';
        raise err;
    end if;
    if l_acc_b.blkk!=0 then
        erm := '0005 - Рахунок ('||l_acc_b.kv||','||l_acc_b.nls||') заблоковано на кредит';
        raise err;
    end if;
    -- определяемся с видом документа по справочнику соответствий priocom_vob
    begin
      select bars_vob_code into l_vob from priocom_vob where priocom_vob_code=p_doc.dockind;
    exception when no_data_found then
      priocom_audit.info('УВАГА! Не знайдено відповідність виду документу № '
      ||p_doc.dockind||'. Заміняємо на 6 - мемордер.');
      l_vob := 6; -- не нашли ==> мемордер
    end;
    -- определяемся с символом кассплана
    l_sk := NULL;
    if substr(l_acc_b.nls,1,4) in ('1001','1002') then -- по кредиту касса ?
      l_sk := 61;
    end if;

    -- работаем с датой оплаты документа
    begin
    	select nvl(stat,0) into l_stat from fdat where fdat=p_doc.paydate;
        if l_stat<>0 then
        	erm := '0006 - Оплата док-тів в даті '||to_char(p_doc.paydate,'DD.MM.YYYY')||' заборонена.';
        	raise err;
        end if;
    exception when no_data_found then
    	erm := '0007 - Банківська дата '||to_char(p_doc.paydate,'DD.MM.YYYY')||' не є допустимою.';
        raise err;
    end;

    -- все проверки пройдены, ставим локальную дату, если надо
    l_cur_date := gl.bd;
    if gl.bd<>p_doc.paydate then
    	gl.pl_dat(p_doc.paydate);
    end if;
    begin
        gl.ref(l_new_ref);
        gl.in_doc2(
            l_new_ref,
            G_PRC_PRI,
            l_vob,
            substr(to_char(p_doc.docid),1,10),
            SYSDATE,
            gl.bd,
            1,
            p_doc.currency,
            p_doc.docsum,
            p_doc.currency,
            p_doc.docsum,
            p_doc.nationalcursum,
            l_sk,
            p_doc.paydate,
            gl.bd,
            substr(l_acc_a.nms,1,38),
            l_acc_a.nls,
            p_doc.mfo_a,
            substr(l_acc_b.nms,1,38),
            l_acc_b.nls,
            p_doc.mfo_b,
            p_doc.paydestination,
            NULL,
            l_cust_a.okpo,
            l_cust_b.okpo,
            NULL,
            NULL,
            0,
            0
        );
        select substr(flags,38,1) into l_flag from tts where tt=G_PRC_PRI;
        paytt(l_flag, l_new_ref, gl.bd, G_PRC_PRI, 1, p_doc.currency, p_doc.account1, p_doc.docsum,
                                           p_doc.currency, p_doc.account2, p_doc.docsum
        );
        chk.put_visa(l_new_ref,G_PRC_PRI,NULL,0,substr(p_doc.abs_key,3),p_doc.abs_sign,NULL);
        p_ref := l_new_ref;
        -- возвращаем банковскую дату
        if l_cur_date<>gl.bd then
			gl.pl_dat(l_cur_date);
        end if;
    exception when others then
    	-- возвращаем банковскую дату
        if l_cur_date<>gl.bd then
			gl.pl_dat(l_cur_date);
        end if;
        raise;
    end;
    priocom_audit.info('Оплачено документ. FNAME='||p_doc.fname||', ROWNUMBER='||p_doc.rownumber||', REF='||p_ref);
exception
    when err then
        priocom_audit.error(erm);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    when others then
        declare
            l_sqlerrm varchar2(4000);
        begin
            l_sqlerrm := substr(SQLERRM, 1, 1024);
            priocom_audit.error(substr(l_sqlerrm||chr(10)||dbms_utility.format_error_backtrace,1,3500));
            raise;
        end;
end pay_doc;

-- снятие/наложение ЭЦП с помощью внешнего обработчика
procedure sign_import(p_bankdate in date, p_fname in varchar2) is
    pragma autonomous_transaction;

  	erm			varchar2 (200);
	ern			constant positive := 006;
	err			exception;

    enqueue_options         dbms_aq.enqueue_options_t;
    dequeue_options         dbms_aq.dequeue_options_t;
    message_properties      dbms_aq.message_properties_t;
    message_handle          RAW(16);
    message                 bars.t_priocom_exchange;
    l_cnt                   number;
    l_total_timeout         number;
    l_start                 number;
    l_current               number;

begin
    -- вставить сообщения в очередь для обработки входящих документов
    message := bars.t_priocom_exchange('SIGN_IMPORT',
        'BANKDATE='||to_char(p_bankdate,'DD.MM.YYYY')||',FNAME='||p_fname);
    dbms_aq.enqueue(
        queue_name          => 'bars.priocom_inbound_queue',
        enqueue_options     => enqueue_options,
        message_properties  => message_properties,
        payload             => message,
        msgid               => message_handle
    );
    commit;
    priocom_audit.info('Пачку документів '||p_fname||' від '||to_char(p_bankdate,'DD.MM.YYYY')
    ||' передано на перевірку/накладання ЕЦП');

    -- узнаем кол-во док-тов в пачке, чтобы установить время ожидания
    select count(*) into l_cnt from priocom_documents where operdate=p_bankdate and fname=p_fname;
    -- ждем не больше (G_PRC_QTM + кол-во документов) секунд
    l_total_timeout := G_PRC_QTM + l_cnt;
    dequeue_options.wait := l_total_timeout;
    dequeue_options.deq_condition := 'tab.user_data.selector=''SIGN_IMPORT'''
    ||' and tab.user_data.message=''BANKDATE='||to_char(p_bankdate,'DD.MM.YYYY')||',FNAME='||p_fname||'''';
    -- ожидаем сообщение об обработке нашего пакета
    begin
        dbms_aq.dequeue(
            queue_name          => 'bars.priocom_outbound_queue',
            dequeue_options     => dequeue_options,
            message_properties  => message_properties,
            payload             => message,
            msgid               => message_handle
        );
        commit;
        priocom_audit.info('Пачка документів '||p_fname||' від '||to_char(p_bankdate,'DD.MM.YYYY')
        ||' оброблена сервером цифрового підпису.');
    exception when MQ_EMPTY_OR_TIMEOUT_EXCEPTION then
        erm := '0001 - Сервер цифрового підпису не відповідає. Час очікування: '||l_total_timeout||' секунд.';
    end;
    begin
        -- удалим сообщение из Inbound-очереди, если оно не было обработано сервером цифровой подписи
        dequeue_options.wait := dbms_aq.no_wait;
        dequeue_options.deq_condition := 'tab.user_data.selector=''SIGN_IMPORT'''
        ||' and tab.user_data.message=''BANKDATE='||to_char(p_bankdate,'DD.MM.YYYY')||',FNAME='||p_fname||'''';
        dbms_aq.dequeue(
            queue_name          => 'bars.priocom_inbound_queue',
            dequeue_options     => dequeue_options,
            message_properties  => message_properties,
            payload             => message,
            msgid               => message_handle
        );
        commit;
        priocom_audit.trace('Пачку документів '||p_fname||' від '||to_char(p_bankdate,'DD.MM.YYYY')
        ||' видалено із вхідної черги.');
    exception when MQ_EMPTY_OR_TIMEOUT_EXCEPTION then
        null;
    end;
    if erm is not null then
        raise err;
    end if;
exception
    when err then
        priocom_audit.error(erm);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    when others then
        declare
            l_sqlerrm varchar2(4000);
        begin
            l_sqlerrm := substr(SQLERRM, 1, 1024);
            priocom_audit.error(substr(l_sqlerrm||chr(10)||dbms_utility.format_error_backtrace,1,3500));
            raise;
        end;
end sign_import;

/**
 * login_request - запрос на соединение к вертушку (всегда ок если вертушка поднята)
 */
procedure login_request is
    pragma autonomous_transaction;

   	erm			varchar2 (200);
	ern			constant positive := 012;
	err			exception;

    enqueue_options         dbms_aq.enqueue_options_t;
    dequeue_options         dbms_aq.dequeue_options_t;
    message_properties      dbms_aq.message_properties_t;
    message_handle          RAW(16);
    message                 bars.t_priocom_exchange;
    l_total_timeout         number;
    l_start                 number;
    l_current               number;
begin
    -- вставить сообщения в очередь подтверждения соединения от работающей вертушки
    message := bars.t_priocom_exchange('LOGIN_REQUEST', NULL);
    dbms_aq.enqueue(
        queue_name          => 'bars.priocom_inbound_queue',
        enqueue_options     => enqueue_options,
        message_properties  => message_properties,
        payload             => message,
        msgid               => message_handle
    );
    commit;
    priocom_audit.info('Запит на з''єднання передано по серверу цифрового підпису');
    l_total_timeout := G_PRC_QTM;
    dequeue_options.wait := l_total_timeout;
    dequeue_options.deq_condition := 'tab.user_data.selector=''LOGIN_REQUEST''';
    -- ожидаем сообщение об обработке нашего пакета
    begin
        dbms_aq.dequeue(
            queue_name          => 'bars.priocom_outbound_queue',
            dequeue_options     => dequeue_options,
            message_properties  => message_properties,
            payload             => message,
            msgid               => message_handle
        );
        commit;
        priocom_audit.info('Отримано підтвердження на з''єднання від серверу цифрового підпису.');
    exception when MQ_EMPTY_OR_TIMEOUT_EXCEPTION then
        erm := '0001 - Сервер цифрового підпису не відповідає. Час очікування: '||l_total_timeout||' секунд.';
    end;
    begin
        -- удалим сообщение из Inbound-очереди, если оно не было обработано сервером цифровой подписи
        dequeue_options.wait := dbms_aq.no_wait;
        dequeue_options.deq_condition := 'tab.user_data.selector=''LOGIN_REQUEST''';
        dbms_aq.dequeue(
            queue_name          => 'bars.priocom_inbound_queue',
            dequeue_options     => dequeue_options,
            message_properties  => message_properties,
            payload             => message,
            msgid               => message_handle
        );
        commit;
        priocom_audit.trace('Запит на з''єднання видалено із черги.');
    exception when MQ_EMPTY_OR_TIMEOUT_EXCEPTION then
        null;
    end;
    if erm is not null then
        raise err;
    end if;
exception
    when err then
        priocom_audit.error(erm);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    when others then
        declare
            l_sqlerrm varchar2(4000);
        begin
            l_sqlerrm := substr(SQLERRM, 1, 1024);
            priocom_audit.error(substr(l_sqlerrm||chr(10)||dbms_utility.format_error_backtrace,1,3500));
            raise;
        end;
end login_request;

/**
 * pay_documents - оплата документов
 */
procedure pay_documents(p_bankdate in date, p_fname in varchar2) is
  	erm			varchar2 (200);
	ern			constant positive := 011;
	err			exception;

    cursor c_doc is select * from priocom_documents where operdate=p_bankdate and fname=p_fname
                        and ref is null -- документы, ранее не обрабатывавшиеся
                        and otm = 1 -- прошли процедуру снятия/наложения ЭЦП
                        and errmessage is null -- ошибок на документе не было
                        order by rownumber
                        for update nowait;
    doc         priocom_documents%rowtype;
    l_sqlcode   number;
    l_sqlerrm   varchar2(4000);
    l_ref       integer;
    l_cnt       integer;
begin
    priocom_audit.trace('Викликано процедуру оплати документів pay_documents. Пачка '
        ||p_fname||' за '||to_char(p_bankdate,'DD.MM.YYYY'));
    -- переинициализация на случай изм. банк. даты
    reset_bankdate;
    -- снятие/наложение ЭЦП с помощью внешнего обработчика
    sign_import(p_bankdate, p_fname);
    -- оплатить документы в пачке
    open c_doc;
    l_cnt := 0;
    loop
        fetch c_doc into doc;
        exit when c_doc%notfound;
        l_cnt := l_cnt + 1;
        savepoint before_pay;
        begin
            priocom_user.pay_doc(doc, l_ref);
            update priocom_documents set errmessage=null, ref=l_ref, otm=2 where current of c_doc;
        exception when others then
            rollback to before_pay;
            l_sqlcode := SQLCODE;
            l_sqlerrm := trim(substr(SQLERRM,1,4000));
            update priocom_documents set errmessage=l_sqlerrm, ref=null where current of c_doc;
            priocom_audit.error('Помилка при оплаті документу. Код '||l_sqlcode||'.'
            ||chr(10)||substr(l_sqlerrm,1,3900));
        end;
    end loop;
    close c_doc;
    -- если в пачке подлежащих обработке документов не было, выбрасываем исключение
    if l_cnt=0 then
      erm := '0001 - В пачці '||p_fname||' за '||to_char(p_bankdate,'DD.MM.YYYY')||' відсутні документи, що підлягають обробці';
      raise err;
    end if;
exception
    when err then
        priocom_audit.error(erm);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    when others then
        declare
            l_sqlerrm varchar2(4000);
        begin
            l_sqlerrm := substr(SQLERRM, 1, 1024);
            priocom_audit.error(substr(l_sqlerrm||chr(10)||dbms_utility.format_error_backtrace,1,3500));
            raise;
        end;
end pay_documents;

/**
 * final_documents_proc - финальная обработка пачки документов
 * @param p_bankdate - дата пачки
 * @param p_fname    - имя пачки
 */
procedure final_documents_proc(p_bankdate in date, p_fname in varchar2) is
  	erm			varchar2 (200);
	ern			constant positive := 014;
	err			exception;
	l_row       priocom_documents%rowtype;
begin
    priocom_audit.trace('Викликано процедуру фінальної обробки пачки документів. Пачка '
    ||p_fname||' за '||to_char(p_bankdate,'DD.MM.YYYY'));
    -- ищем хотя бы один оплаченный документ в пачке
    begin
        select * into l_row from priocom_documents where operdate=p_bankdate and fname=p_fname
        and ref is not null and otm = 2 and errmessage is null and rownum=1;
    exception when no_data_found then
        -- нету таких, удаляем все платежи этой пачки
        delete from priocom_documents where operdate=p_bankdate and fname=p_fname;
        if sql%rowcount=0 then
            erm := 'Пачку '||p_fname||' від '||to_char(p_bankdate,'DD.MM.YYYY')||' не знайдено';
            raise err;
        end if;
        bars_audit.info('Видалено пачку '||p_fname||' від '||to_char(p_bankdate,'DD.MM.YYYY')||'. Кількість документів: '
        ||sql%rowcount);
    end;
exception
    when err then
        priocom_audit.error(erm);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    when others then
        declare
            l_sqlerrm varchar2(4000);
        begin
            l_sqlerrm := substr(SQLERRM, 1, 1024);
            priocom_audit.error(substr(l_sqlerrm||chr(10)||dbms_utility.format_error_backtrace,1,3500));
            raise;
        end;
end final_documents_proc;

/**
 * query_limit_on_deposit - запрос на установку/снятие лимита на основной депозитный счет
 * @param p_mfo         - код МФО
 * @param p_operdate    - дата поточного операційного дня
 * @param p_currency    - код валюти
 * @param p_id_cart     - ідентифікатор картотеки
 * @param p_account     - номер аналітичного рахунку
 * @param p_suma        - Сума по депозиту (повна або частка), яка надається в заставу
 * @param p_lname       - прізвище
 * @param p_fname       - ім’я
 * @param p_sname       - по-батькові
 * @param p_block       - признак блокування\розблокування: 0 - заблокувати, 1 – розблокувати
 */
-- TODO: доработать контроль на сумму лимита
procedure query_limit_on_deposit(p_mfo in varchar2, p_operdate in date, p_currency in integer,
    p_id_cart in varchar2, p_account in varchar2, p_suma in number,
    p_lname in varchar2, p_fname in varchar2, p_sname in varchar2, p_block in integer) is
  	erm			varchar2 (200);
	ern			constant positive := 004;
	err			exception;

    l_acc       accounts.acc%type;
    l_ostc      accounts.ostc%type;
    l_dptrow    dpt_deposit%rowtype;
begin
    priocom_audit.trace('Викликано процедуру запиту на блокування депозитного рахунку');
    begin
        select acc,ostc into l_acc,l_ostc from accounts
        where nls=p_account and kv=p_currency;
    exception when no_data_found then
        erm := '0001 - Рахунок не знайдено('||p_currency||','||p_account||')';
        raise err;
    end;
    if p_operdate<>gl.bd then
        erm := '0002 - Банківська дата відмінна від поточної';
        raise err;
    end if;
    if p_block not in (0,1) then
        erm := '0003 - Значення параметру p_block задано невірно';
        raise err;
    end if;
    if p_suma>l_ostc then
        erm := '0004 - Сума застави перевищує суму вкладу';
        raise err;
    end if;
    begin
        select * into l_dptrow from dpt_deposit where acc=l_acc;
    exception when no_data_found then
        erm := '0005 - Не знайдено депозит з рахунком ('||p_currency||','||p_account||')';
        raise err;
    end;
    if l_dptrow.dat_end<=gl.bd then
        erm := '0006 - Депозит вже закрито';
        raise err;
    end if;
    insert into dpt_limit_query(mfo,operdate,currency,id_cart,account,suma,lname,fname,sname,block)
    values(p_mfo,p_operdate,p_currency,p_id_cart,p_account,p_suma,p_lname,p_fname,p_sname,p_block);
    priocom_audit.info('Прийнято запит на лімітування депозиту: (kv,nls,block,sum)=('
    ||p_currency||','||p_account||','||p_block||','||p_suma||')');
exception
    when err then
        priocom_audit.error(erm);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    when others then
        declare
            l_sqlerrm varchar2(4000);
        begin
            l_sqlerrm := substr(SQLERRM, 1, 1024);
            priocom_audit.error(substr(l_sqlerrm||chr(10)||dbms_utility.format_error_backtrace,1,3500));
            raise;
        end;
end query_limit_on_deposit;

/**
 * proc_limit_on_deposit - установка/снятие лимита на депозит
 */
-- TODO: доработать контроль на сумму лимита
procedure proc_limit_on_deposit(p_limit_id in integer) is

  	erm			varchar2 (200);
	ern			constant positive := 005;
	err			exception;

	l_limit     dpt_limit_query%rowtype;
	l_dptrow    dpt_deposit%rowtype;
	l_vv        v_dpt_limit_query%rowtype;
begin
    begin
        select * into l_limit from dpt_limit_query where limit_id=p_limit_id;
    exception when no_data_found then
        erm := '0001 - Не знайдено запит № '||p_limit_id||' на лімітування депозиту';
        raise err;
    end;
    select * into l_vv from v_dpt_limit_query where limit_id=p_limit_id;
    select * into l_dptrow from dpt_deposit where deposit_id=l_vv.deposit_id;
    -- устанавливаем лимит на счет
    if      l_vv.block=0 then
        update accounts set lim=lim-l_vv.suma where acc=l_vv.acc;
    elsif   l_vv.block=1 then
        update accounts set lim=lim+l_vv.suma where acc=l_vv.acc;
    end if;
    -- пишем запись в историю изменения депозита
    insert into dpt_deposit_clos
        (deposit_id, nd, vidd, acc, kv, rnk,
         freq, datz, dat_begin, dat_end,
         mfo_p, nls_p, name_p, okpo_p,
         limit, deposit_cod, comments,
         action_id, actiion_author, "WHEN")
    values
        (l_dptrow.deposit_id, l_dptrow.nd, l_dptrow.vidd, l_dptrow.acc, l_dptrow.kv, l_dptrow.rnk,
         l_dptrow.freq, l_dptrow.datz, l_dptrow.dat_begin, l_dptrow.dat_end,
         l_dptrow.mfo_p, l_dptrow.nls_p, l_dptrow.name_p, l_dptrow.okpo_p,
         l_dptrow.limit, l_dptrow.deposit_cod,
         case
            when l_vv.block=0 then 'Встановлено ліміт застави '||l_vv.suma
            when l_vv.block=1 then 'Знято ліміт застави '||l_vv.suma
         end,
         case
            when l_vv.block=0 then 15
            when l_vv.block=1 then 16
         end,
         user_id, sysdate);
    if      l_vv.block=0 then
        priocom_audit.info('Встановлено ліміт на депозитний рахунок ('||l_vv.currency||','||l_vv.account
                          ||'), сума='||l_vv.suma);
    elsif   l_vv.block=1 then
        priocom_audit.info('Знято ліміт з депозитного рахунку ('||l_vv.currency||','||l_vv.account
                          ||'), сума='||l_vv.suma);
    end if;
    delete from dpt_limit_query where limit_id=p_limit_id;
exception
    when err then
        priocom_audit.error(erm);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    when others then
        declare
            l_sqlerrm varchar2(4000);
        begin
            l_sqlerrm := substr(SQLERRM, 1, 1024);
            priocom_audit.error(substr(l_sqlerrm||chr(10)||dbms_utility.format_error_backtrace,1,3500));
            raise;
        end;
end proc_limit_on_deposit;

/**
 * remove_dpt_limit_query - удаляет запись из таблицы dpt_limit_query
 */
procedure remove_dpt_limit_query(p_limit_id in integer) is
begin
  delete from dpt_limit_query where limit_id=p_limit_id;
  priocom_audit.info('Видалено запит № '||p_limit_id||' на лімітування депозитного рахунку');
end remove_dpt_limit_query;

/**
 * get_ob22 - возвращает спецпараметр ob22
 */
function get_ob22 return varchar2 is
begin
    return G_OB22;
end get_ob22;

/**
 * get_cl_type - возвращает тип клиента для маски счета: 3-юр,5-физ
 */
function get_cl_type return varchar2 is
begin
    return G_CL_TYPE;
end get_cl_type;

-- снятие/наложение ЭЦП с помощью внешнего обработчика (при экспорте документов)
procedure sign_export(p_us_id in varchar2) is
    pragma autonomous_transaction;

  	erm			varchar2 (200);
	ern			constant positive := 009;
	err			exception;

    enqueue_options         dbms_aq.enqueue_options_t;
    dequeue_options         dbms_aq.dequeue_options_t;
    message_properties      dbms_aq.message_properties_t;
    message_handle          RAW(16);
    message                 bars.t_priocom_exchange;
    l_cnt                   number;
    l_total_timeout         number;
    l_start                 number;
    l_current               number;

begin
    -- узнаем кол-во док-тов в пачке, чтобы установить время ожидания
    select count(*) into l_cnt from priocom_export_documents where unique_session_id=p_us_id;
    -- если документов 0, нечего и дергаться, сразу с поля
    if l_cnt=0 then
        return;
    end if;
    -- вставить сообщения в очередь для обработки документов на экспорт
    message := bars.t_priocom_exchange('SIGN_EXPORT','UNIQUE_SESSION_ID='||p_us_id);
    dbms_aq.enqueue(
        queue_name          => 'bars.priocom_inbound_queue',
        enqueue_options     => enqueue_options,
        message_properties  => message_properties,
        payload             => message,
        msgid               => message_handle
    );
    commit;
    priocom_audit.info('Документи сесії № '||p_us_id||' передано для накладання ЕЦП');

    -- ждем не больше (G_PRC_QTM + кол-во документов) секунд
    l_total_timeout := G_PRC_QTM + l_cnt;
    dequeue_options.wait := l_total_timeout;
    dequeue_options.deq_condition := 'tab.user_data.selector=''SIGN_EXPORT'''
    ||' and tab.user_data.message=''UNIQUE_SESSION_ID='||p_us_id||'''';
    -- ожидаем сообщение об обработке нашего пакета
    begin
        dbms_aq.dequeue(
            queue_name          => 'bars.priocom_outbound_queue',
            dequeue_options     => dequeue_options,
            message_properties  => message_properties,
            payload             => message,
            msgid               => message_handle
        );
        commit;
        priocom_audit.info('Документи сесії № '||p_us_id||' оброблені сервером цифрового підпису.');
    exception when MQ_EMPTY_OR_TIMEOUT_EXCEPTION then
        erm := '0001 - Сервер цифрового підпису не відповідає. Час очікування: '||l_total_timeout||' секунд.';
    end;
    begin
        -- удалим сообщение из Inbound-очереди, если оно не было обработано сервером цыфровой подписи
        dequeue_options.wait := dbms_aq.no_wait;
        dequeue_options.deq_condition := 'tab.user_data.selector=''SIGN_EXPORT'''
        ||' and tab.user_data.message=''UNIQUE_SESSION_ID='||p_us_id||'''';
        dbms_aq.dequeue(
            queue_name          => 'bars.priocom_inbound_queue',
            dequeue_options     => dequeue_options,
            message_properties  => message_properties,
            payload             => message,
            msgid               => message_handle
        );
        commit;
        priocom_audit.info('Документи сесії № '||p_us_id||' видалено із вхідної черги.');
    exception when MQ_EMPTY_OR_TIMEOUT_EXCEPTION then
        null;
    end;
    if erm is not null then
        raise err;
    end if;
exception
    when err then
        priocom_audit.error(erm);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    when others then
        declare
            l_sqlerrm varchar2(4000);
        begin
            l_sqlerrm := substr(SQLERRM, 1, 1024);
            priocom_audit.error(substr(l_sqlerrm||chr(10)||dbms_utility.format_error_backtrace,1,3500));
            raise;
        end;
end sign_export;

/**
 * export_daily_documents - экспортирует документы за день
 * @param p_export_type - 0-работаем по перечню балансовых за p_datebeg,
 *                        1-работаем по перечню лицевых за p_datebeg,
 *                        2-отбираем все за период p_datebeg-p_dateend
 * @param p_datebeg - дата начала периода (или дата отбора для p_export_type in (0,1))
 * @param p_dateend - дата окончания периода
 * @param
 */
procedure export_daily_documents(p_export_type in integer, p_datebeg in date, p_dateend in date) is
  	erm			varchar2 (200);
	ern			constant positive := 008;
	err			exception;

	type        opl_cursor is ref cursor;

    c           opl_cursor;
    l_ref       number;
    l_stmt      number;
    dt          opldok%rowtype;
    kt          opldok%rowtype;
    doc         oper%rowtype;
    ex          priocom_export_documents%rowtype;
    us_id       varchar2(24);
    min_stmt    number;
    l_parent    integer;  -- признак родительской проводки (1-parent,0-child)
    l_kv_a      accounts.kv%type;
    l_nls_a     accounts.nls%type;
    l_nms_a     varchar2(38);
    l_nls_b     accounts.nls%type;
    l_nms_b     varchar2(38);
    l_okpo_a    customer.okpo%type;
    l_okpo_b    customer.okpo%type;
    l_dk        oper.dk%type;
    l_mb        integer; -- признак межбанка
begin
    priocom_audit.trace('Викликано процедуру експорту документiв'||CHR(10)||'p_export_type='||p_export_type
    ||CHR(10)||'p_datebeg='||to_char(p_datebeg,'DD.MM.YYYY')||CHR(10)||'p_dateend='||to_char(p_dateend,'DD.MM.YYYY'));

    if p_datebeg<to_date('26/04/2002','DD/MM/YYYY') then
        erm := '0001 - Дата початку пер_оду повинна бути не менше 26/04/2002, задано '||to_char(p_datebeg, 'DD/MM/YYYY');
        raise err;
    end if;
    -- сначала чистим таблицу от старого мусора(удаляем документы мертвых сессий)
    for fd in (select unique unique_session_id from priocom_export_documents)
    loop
      if not dbms_session.is_session_alive(fd.unique_session_id) then
        delete from priocom_export_documents where unique_session_id=fd.unique_session_id;
      end if;
    end loop;
    -- чистим документы своей сессии от предыдущего запроса
    us_id := dbms_session.unique_session_id;
    delete from priocom_export_documents where unique_session_id=us_id;
    priocom_audit.trace('unique_session_id = '||us_id);
    -- отрываем курсор по проводкам
    if    p_export_type=0 then
        open c for  -- по списку балансовых
        select unique p.ref, p.stmt from opldok p, accounts a
        where p.fdat=p_datebeg and p.acc=a.acc and p.sos=5
          and a.nbs in (select nbs from tmp_priocom_nbs_list)
          and p.ref not in (select ref from priocom_documents where ref is not null)
          and p.ref not in (select docid from tmp_priocom_doc_list)
          and to_number('1'||lpad(p.ref,14,'0')||lpad(p.stmt,14,'0')) not in
		      (select docid from tmp_priocom_doc_list);
    elsif p_export_type=1 then
        open c for  -- по списку лицевых
        select unique p.ref, p.stmt from opldok p, accounts a
        where p.fdat=p_datebeg and p.acc=a.acc and p.sos=5
          and a.nls in (select nls from tmp_priocom_acc_list)
          and p.ref not in (select ref from priocom_documents where ref is not null)
          and p.ref not in (select docid from tmp_priocom_doc_list)
          and to_number('1'||lpad(p.ref,14,'0')||lpad(p.stmt,14,'0')) not in
		      (select docid from tmp_priocom_doc_list);
    elsif p_export_type=2 then
        open c for  -- история кредитных документов за период
        select unique p.ref, p.stmt from opldok p, accounts a
        where p.fdat between p_datebeg and p_dateend
          and p.acc=a.acc and p.sos=5
          and a.nls in (select nls from tmp_priocom_acc_list);
    else
        erm := '0001 - Значення параметра p_export_type задано невiрно: '||p_export_type;
        raise err;
    end if;
    loop
        <<fetch_next>>
        fetch c into l_ref,l_stmt;
        exit when c%notfound;
        priocom_audit.trace('fetch next, l_ref='||l_ref||', l_stmt='||l_stmt);
        -- читаем половинки проводок
        select * into dt from opldok where ref=l_ref and stmt=l_stmt and dk=0;
        select * into kt from opldok where ref=l_ref and stmt=l_stmt and dk=1;
        priocom_audit.trace('opldok fetched, ref='||l_ref||', stmt='||l_stmt);
        -- читаем сам документ
        select * into doc from oper where ref=l_ref;
        priocom_audit.trace('oper fetched, ref='||l_ref);
        -- дополнительные данные
        select kv,nls,substr(nms,1,38)
			  into l_kv_a,l_nls_a,l_nms_a from accounts where acc=dt.acc;
        priocom_audit.trace('accounts fetched, nls_a='||l_kv_a);
        select nls,trim(substr(nms,1,38))
                          into l_nls_b,l_nms_b        from accounts where acc=kt.acc;
        priocom_audit.trace('accounts fetched, nls_b='||l_nls_b);
        select nvl(okpo,'99999') into l_okpo_a        from customer c, cust_acc ca
        where c.rnk=ca.rnk and ca.acc=dt.acc;
        priocom_audit.trace('customer fetched, l_okpo_a='||l_okpo_a);
        select nvl(okpo,'99999') into l_okpo_b        from customer c, cust_acc ca
        where c.rnk=ca.rnk and ca.acc=kt.acc;
        priocom_audit.trace('customer fetched, l_okpo_b='||l_okpo_b);
        l_dk := case when doc.dk is not null then doc.dk else 1 end;
        if doc.mfoa is not null and doc.mfob is not null and doc.mfoa<>doc.mfob then
            l_mb := 1;
        else
            l_mb := 0;
        end if;
        -- поехали
        ex := null;
        ex.unique_session_id := us_id;
        -- выясним: проводка родительская или дочерняя
        select min(stmt) into min_stmt from opldok where ref=l_ref and tt=doc.tt;
        if l_stmt=min_stmt then
            priocom_audit.trace('stmt=min_stmt='||min_stmt);
            l_parent             := 1;  -- родительская операция
            ex.odbid             := l_ref;
            ex.ref               := l_ref;
            ex.stmt              := l_stmt;
            ex.otm               := 0;
            ex.dockind           := case when doc.vob is not null and doc.vob in (1,6)
                                         then doc.vob
                                         else 6
                                    end;
            ex.docstatus         := 5;
            ex.currency          := l_kv_a;
            ex.docdate           := case when doc.datd is not null then doc.datd else dt.fdat end;
            ex.account1          := case
                                    when l_mb=1 and l_dk=1 then doc.nlsa
                                    when l_mb=1 and l_dk=0 then doc.nlsb
                                    else l_nls_a
                                    end;
            ex.account2          := case
                                    when l_mb=1 and l_dk=1 then doc.nlsb
                                    when l_mb=1 and l_dk=0 then doc.nlsa
                                    else l_nls_b
                                    end;
            ex.docsum            := dt.s;
            ex.nationalcursum    := dt.sq;
            ex.mfo_a             := case
                                    when l_mb=1 and l_dk=1 then doc.mfoa
                                    when l_mb=1 and l_dk=0 then doc.mfob
                                    else gl.aMFO
                                    end;
            ex.mfo_b             := case
                                    when l_mb=1 and l_dk=1 then doc.mfob
                                    when l_mb=1 and l_dk=0 then doc.mfoa
                                    else gl.aMFO
                                    end;
            ex.docid             := case when doc.nd is not null then doc.nd else substr(l_ref,1,10) end;
            ex.payer             := case
                                    when l_dk=1 and doc.nam_a is not null then doc.nam_a
                                    when l_dk=0 and doc.nam_b is not null then doc.nam_b
                                    else l_nms_a
                                    end;
            ex.recipient         := case
                                    when l_dk=1 and doc.nam_b is not null then doc.nam_b
                                    when l_dk=0 and doc.nam_a is not null then doc.nam_a
                                    else l_nms_b
                                    end;
            ex.paydestination    := case
                                    when doc.nazn is not null then doc.nazn
                                    else case
                                         when dt.txt is not null then dt.txt
                                         else dt.tt
                                         end
                                    end;
            ex.paydate           := dt.fdat;
            ex.okpo1             := case
                                    when l_dk=1 and doc.id_a is not null then doc.id_a
                                    when l_dk=0 and doc.id_b is not null then doc.id_b
                                    else l_okpo_a
                                    end;
            ex.okpo2             := case
                                    when l_dk=1 and doc.id_b is not null then doc.id_b
                                    when l_dk=0 and doc.id_a is not null then doc.id_a
                                    else l_okpo_b
                                    end;
        else
            priocom_audit.trace('stmt<>min_stmt='||min_stmt);
            l_parent := 0;  -- дочерняя операция
            ex.odbid             := to_number('1'||lpad(l_ref,14,'0')||lpad(l_stmt,14,'0'));
            ex.ref               := l_ref;
            ex.stmt              := l_stmt;
            ex.otm               := 0;
            ex.dockind           := 6;
            ex.docstatus         := 5;
            ex.currency          := l_kv_a;
            ex.docdate           := case when doc.datd is not null then doc.datd else dt.fdat end;
            ex.account1          := l_nls_a;
            ex.account2          := l_nls_b;
            ex.docsum            := dt.s;
            ex.nationalcursum    := dt.sq;
            ex.mfo_a             := gl.aMFO;
            ex.mfo_b             := gl.aMFO;
            ex.docid             := case when doc.nd is not null then doc.nd else substr(l_ref,1,10) end;
            ex.payer             := l_nms_a;
            ex.recipient         := l_nms_b;
            ex.paydestination    := case
                                    when dt.txt is not null then dt.txt
                                    else dt.tt
                                    end;
            ex.paydate           := dt.fdat;
            ex.okpo1             := l_okpo_a;
            ex.okpo2             := l_okpo_b;
        end if;
        priocom_audit.trace('insert into priocom_export_documents(), odbid='||ex.odbid);
        insert into priocom_export_documents values ex;
    end loop;
    close c;
    commit;
    priocom_audit.trace('transaction fixed');
    sign_export(us_id);
    commit;
exception
    when err then
        priocom_audit.error(erm);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    when others then
        declare
            l_sqlerrm varchar2(4000);
        begin
            l_sqlerrm := substr(SQLERRM, 1, 1024);
            priocom_audit.error(substr(l_sqlerrm||chr(10)||dbms_utility.format_error_backtrace,1,3500));
            raise;
        end;
end export_daily_documents;

/**
 * prepare_doc_for_revise - подготовка документов для ревизии
 * @param p_date - банковская дата
 */
procedure prepare_doc_for_revise(p_date in date) is
  	erm			varchar2 (200);
	ern			constant positive := 010;
	err			exception;

    cursor c is
        select unique p.ref, p.stmt, 5 status from opldok p, accounts a
        where p.fdat=p_date
          and p.acc=a.acc and p.sos=5
          and a.nls in (select nls from tmp_priocom_acc_list)
        union all
        select unique p.ref, p.stmt, 4 status from opldok_back p, accounts a
        where p.fdat=p_date
          and p.acc=a.acc and p.sos=5 and p.tt<>'BAK'
          and a.nls in (select nls from tmp_priocom_acc_list);

    l_ref       number;
    l_stmt      number;
    l_status    number;
    dt          opldok%rowtype;
    kt          opldok%rowtype;
    dt_back     opldok_back%rowtype;
    kt_back     opldok_back%rowtype;
    doc         oper%rowtype;
    ex          tmp_priocom_doc_revise%rowtype;
    l_kv        accounts.kv%type;
    l_nlsa      accounts.nls%type;
    l_nlsb      accounts.nls%type;
    min_stmt    number;
    l_dk        oper.dk%type;
    l_mb        integer; -- признак межбанка
    l_s         number;
begin
    priocom_audit.trace('Викликано процедуру звірки документів'||CHR(10)||'pdate='||to_char(p_date,'DD.MM.YYYY'));
    execute immediate 'truncate table tmp_priocom_doc_revise';
    open c;
    loop
        <<fetch_next>>
        fetch c into l_ref, l_stmt, l_status;
        exit when c%notfound;

        -- читаем сам документ
        select * into doc from oper where ref=l_ref;

        -- читаем половинки проводок и пр. инф.
        if l_status=5 then
            select * into dt from opldok where ref=l_ref and stmt=l_stmt and dk=0;
            select * into kt from opldok where ref=l_ref and stmt=l_stmt and dk=1;
            select kv,nls into l_kv, l_nlsa from accounts where acc=dt.acc;
            select nls into l_nlsb from accounts where acc=kt.acc;
            select min(stmt) into min_stmt from opldok where ref=l_ref and tt=doc.tt;
            l_s := dt.s;
        else
            select * into dt_back from opldok_back where ref=l_ref and stmt=l_stmt and dk=0 and tt<>'BAK';
            select * into kt_back from opldok_back where ref=l_ref and stmt=l_stmt and dk=1 and tt<>'BAK';
            select kv,nls into l_kv, l_nlsa from accounts where acc=dt_back.acc;
            select nls into l_nlsb from accounts where acc=kt_back.acc;
            select min(stmt) into min_stmt from opldok_back where ref=l_ref and tt=doc.tt;
            l_s := dt_back.s;
        end if;

        l_dk := case when doc.dk is not null then doc.dk else 1 end;
        if doc.mfoa is not null and doc.mfob is not null and doc.mfoa<>doc.mfob then
            l_mb := 1;
        else
            l_mb := 0;
        end if;

        ex := NULL;
        ex.ref       := l_ref;
        ex.stmt      := l_stmt;
        ex.status    := l_status;
        ex.currency  := l_kv;
        ex.docsum    := l_s;
        if l_stmt=min_stmt then -- родительская проводка
            ex.doc_id            := l_ref;
            ex.account1          := case
                                    when l_mb=1 and l_dk=1 then doc.nlsa
                                    when l_mb=1 and l_dk=0 then doc.nlsb
                                    else l_nlsa
                                    end;
            ex.account2          := case
                                    when l_mb=1 and l_dk=1 then doc.nlsb
                                    when l_mb=1 and l_dk=0 then doc.nlsa
                                    else l_nlsb
                                    end;
            ex.mfo_a             := case
                                    when l_mb=1 and l_dk=1 then doc.mfoa
                                    when l_mb=1 and l_dk=0 then doc.mfob
                                    else gl.aMFO
                                    end;
            ex.mfo_b             := case
                                    when l_mb=1 and l_dk=1 then doc.mfob
                                    when l_mb=1 and l_dk=0 then doc.mfoa
                                    else gl.aMFO
                                    end;
        else                    -- дочерняя проводка
            ex.doc_id    := to_number('1'||lpad(l_ref,14,'0')||lpad(l_stmt,14,'0'));
            ex.account1  := l_nlsa;
            ex.account2  := l_nlsb;
            ex.mfo_a     := gl.aMFO;
            ex.mfo_b     := gl.aMFO;
        end if;
        insert into tmp_priocom_doc_revise values ex;
    end loop; -- cursor c
    close c;
exception
    when err then
        priocom_audit.error(erm);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    when others then
        declare
            l_sqlerrm varchar2(4000);
        begin
            l_sqlerrm := substr(SQLERRM, 1, 1024);
            priocom_audit.error(substr(l_sqlerrm||chr(10)||dbms_utility.format_error_backtrace,1,3500));
            raise;
        end;
end prepare_doc_for_revise;

/**
 * insert_acc_list - вставка списка лицевых счетов
 * @param p_acc_list - список лицевых счетов через запятую
 */
procedure insert_acc_list(p_acc_list in varchar2) is
  i number;
  j number;
begin
  priocom_audit.trace('Задано список особових рахунків: '||substr(p_acc_list,1,3900));
  j   := 1;
  i   := instr(p_acc_list,',');
  while i>0 loop
    insert into tmp_priocom_acc_list(nls) values(trim(substr(p_acc_list,j,i-j)));
    j := i+1;
    i := instr(p_acc_list,',',j);
  end loop;
  insert into tmp_priocom_acc_list(nls) values(trim(substr(p_acc_list,j)));
end insert_acc_list;

/**
 * insert_nbs_list - вставка списка балансовых номеров счетов
 * @param p_nbs_list - список балансовых номеров счетов через запятую
 */
procedure insert_nbs_list(p_nbs_list in varchar2) is
  i number;
  j number;
begin
  priocom_audit.trace('Задано список балансових рахунків: '||substr(p_nbs_list,1,3900));
  j   := 1;
  i   := instr(p_nbs_list,',');
  while i>0 loop
    insert into tmp_priocom_nbs_list(nbs) values(trim(substr(p_nbs_list,j,i-j)));
    j := i+1;
    i := instr(p_nbs_list,',',j);
  end loop;
  insert into tmp_priocom_nbs_list(nbs) values(trim(substr(p_nbs_list,j)));
end insert_nbs_list;

/**
 * insert_doc_list - вставка идентификаторов документов
 * @param p_doc_list - список идентификаторов документов
 */
procedure insert_doc_list(p_doc_list in varchar2) is
  i number;
  j number;
begin
  priocom_audit.trace('Задано список ідентифікаторів документів: '||substr(p_doc_list,1,3900));
  j   := 1;
  i   := instr(p_doc_list,',');
  while i>0 loop
    insert into tmp_priocom_doc_list(docid) values(trim(substr(p_doc_list,j,i-j)));
    j := i+1;
    i := instr(p_doc_list,',',j);
  end loop;
  insert into tmp_priocom_doc_list(docid) values(trim(substr(p_doc_list,j)));
end insert_doc_list;


begin
  load_params;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/priocom_user.sql =========*** End **
 PROMPT ===================================================================================== 
 