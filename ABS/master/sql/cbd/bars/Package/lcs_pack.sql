CREATE OR REPLACE PACKAGE BARS.LCS_PACK is

  -- Author  : MOS
  -- Created : 01/07/2014 11:33:56
  -- Purpose : Limits Control System

g_header_version   CONSTANT VARCHAR2 (64) := ' version 2.0.4  21/01/2018';
-- 1.2.1 Shygyda - Додані функції для форм виведення.
-- 1.2.2 - Інформація про транзакці
-- 1.2.3 - Додано опис помилки про відсутність
-- 1.2.4 - Удалено get_user_info.
-- 1.2.5,6 - Коррективы в отобрвжении информации  и логирование
-- 2.0.0 - Додано set_return
-- 2.0.1 - Додано функцію  back

type t_limits_list  is table of number;

--header_version - возвращает версию заголовка пакета LCS_PACK

function header_version return varchar2;

-- body_version - возвращает версию тела пакета LCS_PACK
 function body_version return varchar2;

--Функція перевірки активності ліміту
function check_active_limit(p_id lcs_limits.id%type) return boolean;

--Функція, яка повертає суму обмеження по Ід. ліміту
function get_limit(p_id lcs_limits.id%type) return lcs_limits.s_eq_limit%type;

--Функція визначення по якій даті перевіряти ліміт
function get_filter_date(p_id lcs_limits.id%type) return lcs_limits.filter_date%type;

-- Функція яка повертає обмеження по датам для даного ліміту на певну дату
-- наприклад на дату 05/06/2014 стоїть період "місяць" результатом мае стати "crt_date >=01/06/2014 and crt_date<=30/06/2014"
--функція отримання Ід.бранча
function get_branch_id(p_branch lcs_branches.code_in_src1%type) return lcs_transactions.branch_id%type;

--функція отримання Ід. джерела завантаження
function get_source_id(p_type lcs_sources.type%type) return lcs_sources.id%type;

--Отримання списку правил(исходя из lcs_limits.filter_clause) по которым нужно проверять
function get_limits_list(p_trans_code lcs_transactions.trans_code%type, p_resident_flag number, p_approve_docs_flag number, p_cash number )
    return t_limits_list ;

--функція отримання еквіваленту доступного клієнту
function get_eqv(p_date       varchar2,
                   p_source_type           lcs_sources.type%type,
                   p_src_trans_id          lcs_transactions.src_trans_id%type,
                   p_mfo                   lcs_transactions.mfo%type,
                   p_branch                lcs_branches.code_in_src1%type,
                   p_trans_crt_date        varchar2,
                   p_trans_bank_date       varchar2,
                   p_trans_code            lcs_transactions.trans_code%type,
                   p_s                     lcs_transactions.s%type,
                   p_sq                    lcs_transactions.s_equivalent%type,
                   p_currency_code         lcs_transactions.currency_code%type,
                   p_ex_rate_official      lcs_transactions.ex_rate_official%type,
                   p_ex_rate_sale          lcs_transactions.ex_rate_sale%type,
                   p_doc_type_id           lcs_transactions.doc_type_id%type,
                   p_serial_doc            varchar2,
                   p_numb_doc              varchar2,
                   p_fio                   lcs_transactions.fio%type,
                   p_birth_date            varchar2,
                   p_resident_flag         lcs_transactions.resident_flag%type,
                   p_cash_acc_flag         lcs_transactions.cash_acc_flag%type,
                   p_approve_docs_flag     lcs_transactions.approve_docs_flag%type,
                   p_exception_flag        lcs_transactions.exception_flag%type,
                   p_exception_description lcs_transactions.exception_description%type,
                   p_staff_logname         lcs_transactions.staff_logname%type,
                   p_staff_fio             lcs_transactions.staff_fio%type,
                   p_recipient             lcs_transactions.recipient%type default null,
                   p_purpose               lcs_transactions.purpose%type  default null) return varchar2;

--процедура підтвердження документа
procedure approve(p_src_trans_id lcs_transactions.src_trans_id%type,
                  p_mfo lcs_transactions.mfo%type,
                  p_source_type lcs_sources.type%type);

--функція вилучення
function back(p_src_trans_id lcs_transactions.src_trans_id%type, p_mfo lcs_transactions.mfo%type, p_source_type lcs_sources.type%type)
    return varchar2;
--процедура вилучення
/*procedure back(p_src_trans_id lcs_transactions.src_trans_id%type,
               p_mfo lcs_transactions.mfo%type,
               p_source_type lcs_sources.type%type);*/

-- процедура створення/оновлення матер. предст.
procedure refresh_mv;

-- функція аудиту
procedure audit ( p_user varchar2, p_doc_series varchar2, p_doc_number varchar2, p_id_list varchar2, p_success out number, p_message out varchar2, p_error_msg out varchar2 );

-- перенесення застарілих даних
procedure f_archive;

-- Перевірка статусу ліміта
function get_limit_status(p_serial_doc varchar2, p_numb_doc varchar2)  return clob;
-- Перевірка періоду
function get_condition_period(p_id lcs_limits.id%type, p_date date, p_column varchar2)   return varchar2;
-- Встановлення статусу RETURN
function set_return(p_src_trans_id varchar2,
                    p_mfo          varchar2,
                    p_source_type  varchar2) return varchar2;

function f_check_remaning(p_id         number,
                          p_serial_doc varchar2,
                          p_numb_doc   varchar2) return number;

--Отримання ознаки винятку по призначенню платежу
function f_get_exception_by_nazn(p_nazn varchar2) return integer;

--Перевірка зі списком BLACKLIST
  function f_get_blacklist(p_ida   varchar2,
                          p_idb    varchar2,
                          p_mfoa   varchar2,
                          p_mfob   varchar2,
                          p_namea  varchar2,
                          p_nameb  varchar2,
                          p_nlsa   varchar2,
                          p_nlsb   varchar2) return varchar2;

end LCS_PACK;
/

CREATE OR REPLACE PACKAGE BODY BARS.LCS_PACK is

  g_body_version constant varchar2(64) := ' version 3.0.0 21/01/2018';
  -- 1.2.1 Shygyda - Додані функції для форм виведення.
  -- 1.2.2 Shygyda - Інформація про транзакці
  -- 2.0.0 Shygyda - Додано set_return
  -- 2.1.0 Litvin - Додано функцію  back
  -- 2.2.2 Litvin - Перевірка зі списком BLACKLIST
  --По якій даті ведемо контроль
  -- 2.4.0 Litvin - Перевірка зі списком паспортів
  g_type_date params.val%type;
  --Назва пакету
  p constant varchar2(64) := 'LCS_PACK';
  -- Необмеженість ліміту
  g_infinity constant number := 99999999999999;
  -- якщо обмеження 150000 виводити додаткове повідомлення
  g_additional_message number := 150000;
  g_nvl_number number := 999;
  -- header_version - возвращает версию заголовка пакета LCS_PACK

  FUNCTION header_version RETURN VARCHAR2 IS
  BEGIN
    RETURN 'Package header ' || p || g_header_version;
  END header_version;

  --body_version - возвращает версию тела пакета LCS_PACK

  FUNCTION body_version RETURN VARCHAR2 IS
  BEGIN
    RETURN 'Package body ' || p || g_body_version;
  END body_version;

  function decode_base_to_row(par varchar2) return varchar2 is
  begin
    return utl_encode.text_decode(par, encoding => utl_encode.base64);
  end;

function recode_fio(p_par varchar2) return varchar2 is
l_res varchar2(4000) :='' ;
begin
   for i in 1..length( p_par ) loop
      if substr( p_par, i, 1 ) = 'E' then
         l_res := l_res || 'Е';
      elsif substr( p_par, i, 1 ) = 'T' then
         l_res := l_res || 'Т';
      elsif substr( p_par, i, 1 ) = 'O' then
         l_res := l_res || 'О';
      elsif substr( p_par, i, 1 ) = 'P' then
         l_res := l_res || 'Р';
      elsif substr( p_par, i, 1 ) = 'A' then
         l_res := l_res || 'А';
      elsif substr( p_par, i, 1 ) = 'H' then
         l_res := l_res || 'Н';
      elsif substr( p_par, i, 1 ) = 'K' then
         l_res := l_res || 'К';
      elsif substr( p_par, i, 1 ) = 'X' then
         l_res := l_res || 'Х';
      elsif substr( p_par, i, 1 ) = 'C' then
         l_res := l_res || 'С';
      elsif substr( p_par, i, 1 ) = 'B' then
         l_res := l_res || 'В';
      elsif substr( p_par, i, 1 ) = 'M' then
         l_res := l_res || 'М';
      elsif substr( p_par, i, 1 ) = 'e' then
         l_res := l_res || 'е';
      elsif substr( p_par, i, 1 ) = 'o' then
         l_res := l_res || 'о';
      elsif substr( p_par, i, 1 ) = 'p' then
         l_res := l_res || 'р';
      elsif substr( p_par, i, 1 ) = 'a' then
         l_res := l_res || 'а';
      elsif substr( p_par, i, 1 ) = 'k' then
         l_res := l_res || 'к';
      elsif substr( p_par, i, 1 ) = 'x' then
         l_res := l_res || 'х';
      elsif substr( p_par, i, 1 ) = 'c' then
         l_res := l_res || 'с';
      elsif substr( p_par, i, 1 ) = 'm' then
         l_res := l_res || 'м';
      else
         l_res := l_res || substr( p_par, i, 1 );

      end if;
   end loop;
   return l_res;
  end;

  function destruct_passp_num(p_ser varchar2, p_num varchar2) return number is
l_count number;
l_res number;
begin
  begin
   select  count(1)
            into l_count
      from destruct_passp dp
     where dp.ser||dp.num =  p_ser||p_num;
  end;
        if l_count > 0 then
               return 1; -- есть паспорт, запрещаем
         else
               return 0; -- нет паспорта, проводим
        end if;
   return l_res;
  end;
  --процедура трасування
  procedure trace(p_msg in varchar2, p_arg1 in varchar2 default null, p_arg2 in varchar2 default null, p_arg3 in varchar2 default null, p_arg4 in varchar2 default null, p_arg5 in varchar2 default null, p_arg6 in varchar2 default null, p_arg7 in varchar2 default null, p_arg8 in varchar2 default null, p_arg9 in varchar2 default null) is
  begin
    bars_audit.trace(p_msg, p_arg1, p_arg2, p_arg3, p_arg4, p_arg5, p_arg6, p_arg7, p_arg8, p_arg9);
  end trace;

  --Ініціалізація
  procedure init is
  begin
    select val into g_type_date from params where par = 'LCS_DATE';
  --BANKDATE --CALDATE
  exception
    when no_data_found then
      g_type_date := 'BANKDATE';
  end init;

  -- Представлення сумм у номіналі
  function f_summ_in_nominal (p_sum_in_penny number) return number
    is
    begin
      return p_sum_in_penny/100;
    end;

  --Функція перевірки активності ліміту
  function check_active_limit(p_id lcs_limits.id%type) return boolean is
    --true is active
    l_lcs_limits lcs_limits%rowtype;
    l_ret        boolean;
  begin
    trace('%s.check_active_limit: entry point', p);
    begin
      select l.* into l_lcs_limits from lcs_limits l where l.id = p_id;
    exception
      when no_data_found then
        l_ret := false;
    end;

    if (trunc(sysdate) >= l_lcs_limits.active_start_date and
       trunc(sysdate) <= l_lcs_limits.active_end_date and
       l_lcs_limits.active_flag = 1) then
      l_ret := true;
    else
      l_ret := false;
    end if;

    trace('%s.check_active_limit - limit_id=%s return %s', p, to_char(p_id), case when
           l_ret = true then
           'TRUE' else
           'FALSE' end);

    return l_ret;

  end check_active_limit;

  --Функція, яка повертає суму обмеження по Ід. ліміту
  function get_limit(p_id lcs_limits.id%type)
    return lcs_limits.s_eq_limit%type is
    l_eq_limit lcs_limits.s_eq_limit%type;
  begin
    trace('%s.get_limit: entry point', p);
    begin
      select l.s_eq_limit
      into l_eq_limit
      from lcs_limits l
      where l.id = p_id;
    exception
      when no_data_found then
        l_eq_limit := 0;
    end;
    trace('%s.get_limit - limit_id=%s , l_eq_limit = %s', p, to_char(p_id), to_char(l_eq_limit));
    return l_eq_limit;
  end get_limit;

  --Функція визначення по якій даті перевіряти ліміт
  function get_filter_date(p_id lcs_limits.id%type)
    return lcs_limits.filter_date%type is
    l_filter_date lcs_limits.filter_date%type;
  begin
    trace('%s.get_limit: entry point', p);
    begin
      select l.filter_date
      into l_filter_date
      from lcs_limits l
      where l.id = p_id;
    exception
      when no_data_found then
        l_filter_date := 'CALDATE';
    end;
    trace('%s.get_limit - limit_id=%s , l_eq_limit = %s', p, to_char(p_id), l_filter_date);
    return l_filter_date;
  end get_filter_date;

  -- Функція яка повертає обмеження по датам для даного ліміту на певну дату
  -- наприклад на дату 05/06/2014 стоїть період "місяць" результатом має бути "crt_date >=01/06/2014 and crt_date<=30/06/2014"
  function get_condition_period(p_id lcs_limits.id%type, p_date date, p_column varchar2)
    return varchar2 is
    l_stmt      varchar2(4000);
    l_period_id lcs_limits.period_id%type;
  begin
    --Читаємо який у нас період в налаштуваннях
    begin
      select l.period_id
      into l_period_id
      from lcs_limits l
      where l.id = p_id;
    exception
      when no_data_found then
        l_period_id := 1;
    end;

    l_stmt := ' ' || p_column || ' >= @dat1 and ' || p_column ||
              ' < @dat2 ';

    --День
    if (l_period_id = 1) then
      l_stmt := replace(l_stmt, '@dat1', 'to_date(''' ||
                         to_char(p_date, 'dd.mm.yyyy') ||
                         ''',''dd.mm.yyyy'')');
      l_stmt := replace(l_stmt, '@dat2', 'to_date(''' ||
                         to_char(p_date + 1, 'dd.mm.yyyy') ||
                         ''',''dd.mm.yyyy'')');
      --Тиждень
    elsif (l_period_id = 2) then
      l_stmt := replace(l_stmt, '@dat1', 'to_date(''' ||
                         to_char(trunc(p_date - 1, 'D') + 1, 'dd.mm.yyyy') ||
                         ''',''dd.mm.yyyy'')');
      l_stmt := replace(l_stmt, '@dat2', 'to_date(''' ||
                         to_char(trunc(p_date - 1, 'D') + 8, 'dd.mm.yyyy') ||
                         ''',''dd.mm.yyyy'')');
      --Місяць
    elsif (l_period_id = 3) then
      l_stmt := replace(l_stmt, '@dat1', 'to_date(''' ||
                         to_char(trunc(p_date, 'MM'), 'dd.mm.yyyy') ||
                         ''',''dd.mm.yyyy'')');
      l_stmt := replace(l_stmt, '@dat2', 'to_date(''' ||
                         to_char(last_day(p_date) + 1, 'dd.mm.yyyy') ||
                         ''',''dd.mm.yyyy'')');
      --Квартал
    elsif (l_period_id = 4) then
      l_stmt := replace(l_stmt, '@dat1', 'to_date(''' ||
                         to_char(trunc(add_months(p_date, 0), 'q'), 'dd.mm.yyyy') ||
                         ''',''dd.mm.yyyy'')');
      l_stmt := replace(l_stmt, '@dat2', 'to_date(''' ||
                         to_char(trunc(add_months(p_date, 3), 'q'), 'dd.mm.yyyy') ||
                         ''',''dd.mm.yyyy'')');
      --Рік
    elsif (l_period_id = 5) then
      l_stmt := replace(l_stmt, '@dat1', 'to_date(''' ||
                         to_char(trunc(p_date, 'YY'), 'dd.mm.yyyy') ||
                         ''',''dd.mm.yyyy'')');
      l_stmt := replace(l_stmt, '@dat2', 'to_date(''' ||
                         to_char(add_months(trunc(p_date, 'YY'), 12), 'dd.mm.yyyy') ||
                         ''',''dd.mm.yyyy'')');
    end if;
    dbms_output.put_line(l_stmt);

    return l_stmt;
  end get_condition_period;

  --функція отримання Ід.бранча
  function get_branch_id(p_branch lcs_branches.code_in_src1%type)
    return lcs_transactions.branch_id%type is
    l_id lcs_branches.id%type := 0;
  begin
    --Біжимо по всіх 5 колонках
    for i in 1 .. 5 loop
      begin
        execute immediate 'select l.id from lcs_branches l where l.CODE_IN_SRC' ||
                          to_char(i) || ' = :p_branch and rownum=1'
          into l_id
          using p_branch;
      exception
        when no_data_found then
          l_id := 0;
      end;
      if l_id > 0 then
        exit;
      end if;
    end loop;
    if l_id > 0 then
      return l_id;
    else
      raise_application_error(  -20203, 'Бранч ' || p_branch ||' не знайдено!');
    end if;

  end get_branch_id;

  --функція отримання Ід. джерела завантаження
  function get_source_id(p_type lcs_sources.type%type)
    return lcs_sources.id%type is
    l_id lcs_sources.id%type;
  begin
    begin
      select l.id into l_id from lcs_sources l where l.type = p_type;
    exception
      when no_data_found then
        raise_application_error(-20005, 'Недозволене джерело завантаження даних!');
    end;
    return l_id;
  end get_source_id;

  --Получение списка правил(исходя из lcs_limits.filter_clause) по которым нужно проверять
  /*function get_limits_list(p_trans_code lcs_transactions.trans_code%type)
    return t_limits_list is
    l_list t_limits_list := t_limits_list();
    l_cnt  number := 1;
  begin
    for i in (select l.id
              from lcs_limits l
              where l.filter_clause like '%''' || p_trans_code || '''%' order by l.s_eq_limit) loop
      l_list.extend;
      l_list(l_cnt) := i.id;
      l_cnt := l_cnt + 1;
    end loop;

    return l_list;
  end get_limits_list;
*/
  function get_limits_list(p_trans_code lcs_transactions.trans_code%type, p_resident_flag number, p_approve_docs_flag number, p_cash number )
    return t_limits_list is
    l_list t_limits_list := t_limits_list();
    l_cnt  number := 1;
  begin
    for i in (select l.id, l.special_setings, l.approve_docs_flag, l.resident_flag, l.cash_acc_flag
              from lcs_limits l
              where l.filter_clause like '%''' || p_trans_code || '''%' ) loop
      -- Якщо правило містить спец параметри, то перевірити флаги
      if  ( nvl(i.special_setings,'NO') = 'YES' and nvl(i.approve_docs_flag,g_nvl_number) = p_approve_docs_flag and nvl(i.resident_flag,g_nvl_number) = p_resident_flag /*and nvl(i.cash_acc_flag,g_nvl_number) = p_cash */) then

            l_list.extend;
            l_list(l_cnt) := i.id;
            l_cnt := l_cnt + 1;
      elsif ( nvl(i.special_setings,'NO') != 'YES' ) then
          l_list.extend;
          l_list(l_cnt) := i.id;
          l_cnt := l_cnt + 1;
       end if;
    end loop;
    return l_list;
  end get_limits_list;

  --процедура вставки транзакції
  procedure set_eqv(p_source_type lcs_sources.type%type, p_src_trans_id lcs_transactions.src_trans_id%type, p_mfo lcs_transactions.mfo%type, p_branch lcs_branches.code_in_src1%type, p_trans_crt_date varchar2, p_trans_bank_date varchar2, p_trans_code lcs_transactions.trans_code%type, p_s lcs_transactions.s%type, p_currency_code lcs_transactions.currency_code%type, p_ex_rate_official lcs_transactions.ex_rate_official%type, p_ex_rate_sale lcs_transactions.ex_rate_sale%type, p_s_equivalent lcs_transactions.s_equivalent%type, p_doc_type_id lcs_transactions.doc_type_id%type, p_doc_series lcs_transactions.doc_series%type, p_doc_number lcs_transactions.doc_number%type, p_fio lcs_transactions.fio%type, p_birth_date varchar2, p_resident_flag lcs_transactions.resident_flag%type, p_cash_acc_flag lcs_transactions.cash_acc_flag%type, p_approve_docs_flag lcs_transactions.approve_docs_flag%type, p_exception_flag lcs_transactions.exception_flag%type, p_exception_description lcs_transactions.exception_description%type, p_staff_logname lcs_transactions.staff_logname%type, p_staff_fio lcs_transactions.staff_fio%type, p_recipient lcs_transactions.recipient%type default null, p_purpose   lcs_transactions.purpose%type  default null, o_ret_ out varchar2) is
   l_id number := S_LCS_TRANSACTIONS.nextval;
    pragma autonomous_transaction;
  begin
    begin
      insert into lcs_transactions
        (id, src_id, src_trans_id, crt_date, status_id, mfo, branch_id, trans_crt_date, trans_bank_date, trans_code, s, currency_code, ex_rate_official, ex_rate_sale, s_equivalent, doc_type_id, doc_series, doc_number, fio, birth_date, resident_flag, cash_acc_flag, approve_docs_flag, exception_flag, exception_description, staff_logname, staff_fio, recipient, purpose)
      values
        (l_id, get_source_id(p_source_type), p_src_trans_id, sysdate, 'NEW', p_mfo, get_branch_id(p_branch), to_date(p_trans_crt_date, 'dd.mm.yyyy'), to_date(p_trans_bank_date, 'dd.mm.yyyy'), p_trans_code, p_s, p_currency_code, p_ex_rate_official, p_ex_rate_sale, p_s_equivalent, p_doc_type_id, p_doc_series, p_doc_number, upper(p_fio), to_date(p_birth_date, 'dd.mm.yyyy'), p_resident_flag, p_cash_acc_flag, p_approve_docs_flag, p_exception_flag, p_exception_description, p_staff_logname, p_staff_fio, p_recipient,p_purpose);
      o_ret_ := 'OK';

      if ( p_birth_date like '01.01.1090' ) then
          update lcs_transactions t set t.birth_date = null where t.id = l_id;
        end if;
        commit;

  exception
      when others then
        o_ret_ := 'Операйція не була виконана Помилка:' || SQLERRM;
        rollback;
    end;

  end set_eqv;

  --функція отримання еквіваленту доступного клієнту
  function get_eqv(p_date varchar2, p_source_type lcs_sources.type%type, p_src_trans_id lcs_transactions.src_trans_id%type, p_mfo lcs_transactions.mfo%type, p_branch lcs_branches.code_in_src1%type, p_trans_crt_date varchar2, p_trans_bank_date varchar2, p_trans_code lcs_transactions.trans_code%type, p_s lcs_transactions.s%type, p_sq lcs_transactions.s_equivalent%type, p_currency_code lcs_transactions.currency_code%type, p_ex_rate_official lcs_transactions.ex_rate_official%type, p_ex_rate_sale lcs_transactions.ex_rate_sale%type, p_doc_type_id lcs_transactions.doc_type_id%type, p_serial_doc varchar2, p_numb_doc varchar2, p_fio lcs_transactions.fio%type, p_birth_date varchar2, p_resident_flag lcs_transactions.resident_flag%type, p_cash_acc_flag lcs_transactions.cash_acc_flag%type, p_approve_docs_flag lcs_transactions.approve_docs_flag%type, p_exception_flag lcs_transactions.exception_flag%type, p_exception_description lcs_transactions.exception_description%type, p_staff_logname lcs_transactions.staff_logname%type, p_staff_fio lcs_transactions.staff_fio%type,p_recipient lcs_transactions.recipient%type  default null, p_purpose  lcs_transactions.purpose%type  default null)
    return varchar2 is

    l_eqv        number := 0;
    l_eq         number := 0;
    l_free_eqv       number := 0;
    l_stmt_date  varchar2(250);
    l_stmt       clob;
    l_trans_code lcs_transactions.trans_code%type := decode_base_to_row(p_trans_code);

    l_serial_doc varchar2(10);
    l_numb_doc   varchar2(20);

    l_fio      lcs_transactions.fio%type := decode_base_to_row(p_fio);
    l_date     date;
    l_id       number;
    l_list     t_limits_list;
    l_res      varchar2(4000) := 'Ліміт по заданій операції не знайдено';
    l_ret      varchar2(4000) := 'No';
    l_tts_list varchar2(4000);
    r_transaction lcs_transactions%rowtype;
    l_err varchar2(4000);

  begin


      bars_audit.info ('LCS_PACK : get_eqv p_date : '||p_date||
      ' p_source_type : '||p_source_type||
      ' p_src_trans_id : '||p_src_trans_id||
      ' p_mfo  : '||p_mfo||
      ' p_branch : '||p_branch||
      ' p_trans_crt_date : '||p_trans_crt_date||
      ' p_trans_bank_date : '||p_trans_bank_date||
      ' p_trans_code : '||p_trans_code||
      ' p_s  : '||to_char(p_s)||
      ' p_sq  : '||to_char(p_sq)||
      ' p_currency_code  : '||p_currency_code||
      ' p_ex_rate_official  : '||p_ex_rate_official||
      ' p_ex_rate_sale  : '||p_ex_rate_sale||
      ' p_doc_type_id : '||p_doc_type_id||
      ' p_serial_doc  : '||p_serial_doc||
      ' p_numb_doc : '||p_numb_doc||
      ' p_fio : '||p_fio||
      ' p_birth_date : '||p_birth_date||
      ' p_resident_flag : '||p_resident_flag||
      ' p_cash_acc_flag : '||p_cash_acc_flag||
      ' p_approve_docs_flag : '||to_char(p_approve_docs_flag)||
      ' p_exception_flag : '||to_char(p_exception_flag)||
      ' p_exception_description : '||p_exception_description||
      ' p_staff_logname  : '||p_staff_logname);



    -- Перевірка корректності формату документа
    -- якщо паспорт
    if (p_doc_type_id in (1,21)) then
                begin
                    l_serial_doc:= kl.recode_passport_serial(decode_base_to_row(p_serial_doc));
                exception when others then
                 l_err := substr(sqlerrm,1,254);
                 return l_err;
                end;

                begin
                    l_numb_doc := kl.recode_passport_number( decode_base_to_row(p_numb_doc));
                exception when others then
                 l_err := substr(sqlerrm,1,254);
                 return l_err;
                end;
               -- logger.info('LCS_PACK DESTR_1 l_serial_doc = ' || l_serial_doc||' l_numb_doc = '||l_numb_doc|| 'p_doc_type_id = '||p_doc_type_id);

                if (destruct_passp_num(l_serial_doc, l_numb_doc) = 1) then
                    return 'Неможливо здійснити операцію за даним паспортом. Паспорт '||l_serial_doc||l_numb_doc||' видано з порушенням умов чинного законодавства';
                end if;
      --l_serial_doc := kl.recode_passport_serial(decode_base_to_row(p_serial_doc));
      --l_numb_doc   := kl.recode_passport_number(decode_base_to_row(p_numb_doc));

    elsif(p_source_type <> 'BRS_EXCH' and p_doc_type_id = 1) then
    l_serial_doc := kl.recode_passport_serial(decode_base_to_row(nvl(p_serial_doc,' ')));
    l_numb_doc   := decode_base_to_row(p_numb_doc);
    l_fio := recode_fio(l_fio);
              -- logger.info('LCS_PACK DESTR_2 l_serial_doc = ' || l_serial_doc||' l_numb_doc = '||l_numb_doc|| 'p_doc_type_id = '||p_doc_type_id);

                if (destruct_passp_num(l_serial_doc, l_numb_doc) = 1) then
                    return 'Неможливо здійснити операцію за даним паспортом. Паспорт '||l_serial_doc||l_numb_doc||' видано з порушенням умов чинного законодавства';
                end if;

    else
               -- logger.info('LCS_PACK DESTR_3 l_serial_doc = ' || l_serial_doc||' l_numb_doc = '||l_numb_doc|| 'p_doc_type_id = '||p_doc_type_id);

      l_serial_doc := decode_base_to_row(nvl(p_serial_doc,' '));
         if length(replace(l_serial_doc,' ')) = 2 then
            l_serial_doc := recode_fio(upper(l_serial_doc));
         end if;
      l_numb_doc   := decode_base_to_row(p_numb_doc);

                if (destruct_passp_num(replace(l_serial_doc,' ',''), l_numb_doc) = 1) then
                    return 'Неможливо здійснити операцію за даним паспортом. Паспорт '||l_serial_doc||l_numb_doc||' видано з порушенням умов чинного законодавства';
                end if;
    end if;

    if (( p_ex_rate_sale = 1 or p_ex_rate_official = 1 or p_sq  = 1) and p_currency_code != '980')
      then
        return  'Помилка курсу валют!';
      end if;

    --Отримуємо список лімітів по яких треба перевірити транзакцію
    l_list := get_limits_list(l_trans_code,p_resident_flag,p_approve_docs_flag,p_cash_acc_flag);

    --Проходимо по усьому списку активних правил
    for i in 1 .. l_list.count loop
      begin
        l_id := l_list(i);
     -- перевіримо чи активний даний ліміт
        if (lcs_pack.check_active_limit(l_id)) then
          begin

          select case nvl(sum_filter_clause,'NO') when 'NO' then filter_clause else filter_clause||','||sum_filter_clause end
                   into l_tts_list
                   from lcs_limits
                    where id = l_id;
          exception
            when no_data_found then
                l_tts_list := '   ';
            end;

          -- По банківській даті чи по календарній
          if (get_filter_date(l_id) = 'CALDATE') then
            l_date      := to_date(p_trans_crt_date, 'dd.mm.yyyy');
            l_stmt_date := get_condition_period(l_id, l_date, 'TRANS_CRT_DATE');
          else
            l_date      := to_date(p_trans_bank_date, 'dd.mm.yyyy');
            l_stmt_date := get_condition_period(l_id, l_date, 'TRANS_BANK_DATE');
          end if;

          l_stmt := '';
          l_stmt := 'select nvl(sum(s_equivalent),0)
                    from lcs_transactions where ' ||
                    l_stmt_date || ' and doc_series = :l_serial_doc
                    and doc_number = :l_numb_doc
                    and exception_flag = 0
                    --and cash_acc_flag = 1
                    and status_id in( ''APPROVED'',''NEW'')
                    and trans_code in (' || l_tts_list || ')';
          logger.info('LCS l_stmt' || l_stmt);

          execute immediate l_stmt
            into l_eq
            using l_serial_doc, l_numb_doc;
            -- якщо поточний рахунок, не враховумо hardcode !!!
          if (p_exception_flag = '1' or  ( p_cash_acc_flag = '0' and l_trans_code = '437' )/* or (p_cash_acc_flag = '1' and l_trans_code = 'CAA' )*/) then
             l_eqv := g_infinity;
             else
              l_eqv := get_limit(l_id) - (nvl(l_eq, 0) + p_sq) ;
             end if;

        else
          --ліміт не активний
          l_eqv := g_infinity;
        end if;

        l_free_eqv := f_summ_in_nominal(get_limit(l_id) - l_eq);
        if (l_free_eqv < 0) then l_free_eqv := 0; end if;

        if l_eqv < 0 then
               return 'Спроба внести: ' || to_char(f_summ_in_nominal(p_sq),'FM99999999990D00') || ' грн. Вичерпано ліміт по правилу № ' || l_id || ' (' || to_char(f_summ_in_nominal(get_limit(l_id)) , 'FM999999990D00') || ' грн.), вільно коштів у гривневому еквіваленті ' ||  to_char(l_free_eqv, 'FM9999999999990D00')   || ' грн.';
         else
          l_res := 'OK';
        end if;
      end;
    end loop;
    logger.info('l_res' || l_res);
    if l_res = 'OK' then
      set_eqv(p_source_type => p_source_type, p_src_trans_id => p_src_trans_id,
              p_mfo => p_mfo, p_branch => p_branch, p_trans_crt_date => p_trans_crt_date,
              p_trans_bank_date => p_trans_bank_date, p_trans_code => l_trans_code,
              p_s => p_s, p_currency_code => p_currency_code,
              p_ex_rate_official => to_number(p_ex_rate_official),
              p_ex_rate_sale => p_ex_rate_sale, p_s_equivalent => p_sq,
              p_doc_type_id => p_doc_type_id,
              p_doc_series => l_serial_doc, p_doc_number => l_numb_doc,
              p_fio => l_fio, p_birth_date => p_birth_date,
              p_resident_flag => p_resident_flag,
              p_cash_acc_flag => p_cash_acc_flag,
              p_approve_docs_flag => p_approve_docs_flag,
              p_exception_flag => p_exception_flag,
              p_exception_description => decode_base_to_row(p_exception_description),
              p_staff_logname => p_staff_logname, p_staff_fio => decode_base_to_row(p_staff_fio), 
              p_recipient => case when p_recipient is null then null else decode_base_to_row(p_recipient) end,
              p_purpose =>case when p_recipient is null then null else  decode_base_to_row(p_purpose)  end, o_ret_ => l_ret);
      logger.info('l_ret' || l_ret);
      if l_ret != 'OK' then
        l_res := l_ret;
      end if;
    end if;
    return l_res;
  end get_eqv;

  --Процедура підтвердження документа
  procedure approve(p_src_trans_id lcs_transactions.src_trans_id%type, p_mfo lcs_transactions.mfo%type, p_source_type lcs_sources.type%type) is
  begin
    update lcs_transactions l
    set l.status_id = 'APPROVED'
    where l.src_trans_id = p_src_trans_id and
          l.mfo = p_mfo and
          l.src_id = get_source_id(p_source_type);

  end approve;

   --функція вилучення
  function back(p_src_trans_id lcs_transactions.src_trans_id%type,
                      p_mfo lcs_transactions.mfo%type,
                      p_source_type lcs_sources.type%type) return varchar2
  is
  begin
      update lcs_transactions l
            set l.status_id = 'CANCELED'
          where l.src_trans_id = p_src_trans_id and
              l.mfo = p_mfo and
              l.src_id = get_source_id(p_source_type) and
              l.id = (select max(id) from  lcs_transactions l where l.src_trans_id = p_src_trans_id and l.status_id in ('NEW', 'APPROVED','RETURN'));

    if SQL%NOTFOUND = true then
      return 'ERROR';
    end if;

    return 'OK';

  end back;

 /* --процедура вилучення
  procedure back(p_src_trans_id lcs_transactions.src_trans_id%type, p_mfo lcs_transactions.mfo%type, p_source_type lcs_sources.type%type) is

    begin
    update lcs_transactions l
          set l.status_id = 'CANCELED'
        where l.src_trans_id = p_src_trans_id and
              l.mfo = p_mfo and
              l.src_id = get_source_id(p_source_type) and
              l.id = (select max(id) from  lcs_transactions l where l.src_trans_id = p_src_trans_id and l.status_id in ('NEW', 'APPROVED','RETURN'));

      l_mfo lcs_transactions.mfo%type;
    l_src_id LCS_TRANSACTIONS.SRC_ID%type;
    l_src_trans_id LCS_TRANSACTIONS.SRC_TRANS_ID%type;
   -- l lcs_transactions%rowtype;

  begin

    select mfo, src_id, src_trans_id into l_mfo, l_src_id, l_src_trans_id
    from lcs_transactions
    where mfo = p_mfo and src_trans_id = p_src_trans_id and src_id = get_source_id(p_source_type);

    if (l_mfo != p_mfo) then
        bars_error.raise_error('DOC',47,'МФО не знайдено');
    elsif (l_src_id != get_source_id(p_source_type)) then
        bars_error.raise_error('DOC',47,'Код джерела не знайдено');
    elsif (l_src_trans_id != p_src_trans_id) then
        bars_error.raise_error('DOC',47,'Код транзакції не знайдено');

    else
       update lcs_transactions l
          set l.status_id = 'CANCELED'
        where l.src_trans_id = p_src_trans_id and
              l.mfo = p_mfo and
              l.src_id = get_source_id(p_source_type) and
              l.id = (select max(id) from  lcs_transactions l where l.src_trans_id = p_src_trans_id and l.status_id in ('NEW', 'APPROVED','RETURN'));
    end if;
  end back;*/

  -- процедура створення/оновлення матер. предст.
  procedure refresh_mv is
  begin
    null;
  end refresh_mv;
  /*
  * Перевірка залишку по ліміту
  */
  function f_check_remaning(p_id number, p_serial_doc varchar2, p_numb_doc varchar2)
    return number is

    l_eqv       number := 0;
    l_eq        number := 0;
    l_stmt_date varchar2(250);
    l_stmt      clob;
    l_tts_list  varchar2(4000);
    l_date      date;

  begin
    -- Перевірка активності ліміту
    if (lcs_pack.check_active_limit(p_id)) then
      begin
        -- filter clause
        select filter_clause
        into l_tts_list
        from lcs_limits
        where id = p_id;
      exception
        when no_data_found then
          l_tts_list := '   ';
      end;

      -- По банківській даті чи по календарній
      if (lcs_pack.get_filter_date(p_id) = 'CALDATE') then
        l_date      := to_date(sysdate, 'dd.mm.yy');
        l_stmt_date := get_condition_period(p_id, l_date, 'CRT_DATE');
      else
        l_date      := to_date(bankdate, 'dd.mm.yy');
        l_stmt_date := get_condition_period(p_id, l_date, 'TRANS_BANK_DATE');
      end if;

      l_stmt := 'select nvl(sum(s_equivalent),0)
                    from lcs_transactions where ' ||
                l_stmt_date || ' and doc_series = :l_serial_doc
                    and doc_number = :l_numb_doc
                    and exception_flag = 0
                    and status_id in( ''APPROVED'',''NEW'')
                    and trans_code in (' || l_tts_list || ')';
      execute immediate l_stmt
        into l_eq
        using p_serial_doc, p_numb_doc;

      l_eqv := lcs_pack.get_limit(p_id) - (l_eq);
    else
      --ліміт не активний
      l_eqv := g_infinity;
    end if;
    return l_eqv;

  end f_check_remaning;
/*
  * Архівація. перенесення застарілих даних.
  */
  /*
  * Переміщення партіції
  */
/*  procedure exchange_partition is
    G_ONE_YEAR constant number := 1;
  begin
    for i in (select t.partition_name
              from user_tab_partitions t
              where t.table_name = 'LCS_TRANSACTIONS' and
                    length(t.partition_name) > 5 and
                    (to_number(substr(t.partition_name, 2, 4)) -
                    to_number(to_char(sysdate, 'YYYY'))) > G_ONE_YEAR) loop
      for j in (select a.subpartition_name
                from user_tab_subpartitions a
                where a.table_name = 'LCS_TRANSACTIONS' and
                      a.partition_name = i.partition_name) loop
        begin
          execute immediate 'alter table lcs_transactions exchange subpartition ' ||
                            j.subpartition_name ||
                            ' with table lcs_history  whout validation';
        end;
      end loop; -- subpartition
    end loop; -- partition
  end exchange_partition;*/
  /*
  * процедура переміщенн застрілих даних до архіву  по запису.
  */
  procedure move_record is
    G_ONE_YEAR constant number := 1;
  begin
    -- all records for this limits
    begin
      savepoint before_move;
      for i in (select l.rowid
                from lcs_transactions l
                where to_number(to_char(l.crt_date, 'YYYY')) -
                      to_number(to_char(sysdate, 'YYYYY')) >= G_ONE_YEAR) loop

        insert into lcs_archive select * from lcs_transactions l where l.rowid = i.rowid;
        delete from lcs_transactions l where l.rowid = i.rowid;
        commit;

      end loop;
    exception
      when others then
        rollback to before_move;
    end;
  end move_record;

  procedure f_archive is
  begin
     move_record;
  end;
function get_branch_name (p_id in number) return varchar2 is

  l_name varchar2(100);
  begin
    select b.name into l_name from lcs_branches b where b.id = p_id;
    return l_name;
    exception when no_data_found
      then
        return  '-';
  end;
 /*
   * Функція пошуку даних по серії та номеру паспорта
  */

  function get_limit_status(p_serial_doc varchar2, p_numb_doc varchar2)
    return clob is


    l_remaining  number;
    l_serial_doc varchar2(10):= upper(nvl(p_serial_doc,' '));--kl.recode_passport_serial(p_serial_doc);
    l_numb_doc   varchar2(20);
    l_msg  clob;
    l_xml_main      xmltype;
    l_xml_tmp_src    xmltype;
    l_xml_tmp_trg    xmltype;
    l_xml_tmp_trg_2  xmltype;
    r_trans  lcs_transactions%rowtype;
    --get active limits for current passport and series

    cursor c_limits is select distinct  t.id
                        from
                        (
                            SELECT  l.id, l.name,l.status_id, l.active_flag, trim(REGEXP_SUBSTR (replace(l.filter_clause,'''','') ,'[^,]+',1,LEVEL)) as token
                            FROM   lcs_limits l
                            CONNECT BY trim(REGEXP_SUBSTR (replace(l.filter_clause,'''',''),'[^,]+',1,LEVEL)) IS NOT NULL
                        )t
                        where t.active_flag = 1 and t.status_id not like 'UNLIMITED' and t.id in (1,2,3,8,9,10);
   cursor c_transactions  is select l.* from lcs_transactions l
        where l.doc_series = l_serial_doc
                and l.doc_number = l_numb_doc and l.exception_flag = 0 and l.trans_crt_date>=  to_date(to_char(trunc(sysdate, 'MM'), 'dd.mm.yyyy'),'dd.mm.yyyy');

  begin
    bars_audit.info ('LCS.trans1: p_serial_doc'||p_serial_doc|| ' l_serial_doc '||l_serial_doc);
    if l_serial_doc <> ' ' then
        l_serial_doc :=kl.recode_passport_serial(l_serial_doc);
    end if;
      l_numb_doc := REPLACE(p_numb_doc,' ');
      bars_audit.info ('LCS.trans2: p_serial_doc'||p_serial_doc|| ' l_serial_doc '||l_serial_doc);
    -- Отримуємо список лімітів по яких треба перевірити транзакцію
    -- <OperationCollection><Operations>
    begin

      for i in c_limits
        loop
        l_remaining := f_check_remaning(i.id, l_serial_doc, l_numb_doc);
        select XmlElement ("Limit",(select l.name from lcs_limits l where l.id = i.id) ) into l_xml_tmp_src from dual;
        select XmlElement ("Sum",(select to_char(l_remaining/100, 'FM9999999999999999D00') from dual)) into l_xml_tmp_trg from dual;
        select XmlConcat(l_xml_tmp_src, l_xml_tmp_trg) into l_xml_tmp_src from dual;
        select XmlElement ("Operation",l_xml_tmp_src )into l_xml_tmp_src from dual;
        select XmlConcat(l_xml_main, l_xml_tmp_src) into l_xml_main from dual;

       end loop;

       select XmlElement ("Operations",l_xml_main )into l_xml_main from dual;
       select XmlElement ("OperationCollection",l_xml_main )into l_xml_main from dual;

        l_xml_tmp_src := null;
        l_xml_tmp_trg := null;


       for i in c_transactions
         loop
           select XmlElement ("Date", i.trans_crt_date) into l_xml_tmp_trg  from dual;
           select XmlElement ("Branch", ( select l.code_in_src1 from lcs_branches l where l.id = i.branch_id) ) into l_xml_tmp_trg_2  from dual;
           select XmlConcat(l_xml_tmp_trg, l_xml_tmp_trg_2) into l_xml_tmp_trg from dual;

           select XmlElement ("Operation", i.trans_code ) into  l_xml_tmp_trg_2 from dual;
           select XmlConcat(l_xml_tmp_trg, l_xml_tmp_trg_2) into l_xml_tmp_trg from dual;

           select XmlElement ("Currency", i.currency_code ) into l_xml_tmp_trg_2 from dual;
           select XmlConcat(l_xml_tmp_trg, l_xml_tmp_trg_2) into l_xml_tmp_trg from dual;

           select XmlElement ("Sum", to_char(i.s/100, 'FM9999999999999999D00') ) into l_xml_tmp_trg_2 from dual;
           select XmlConcat(l_xml_tmp_trg, l_xml_tmp_trg_2) into l_xml_tmp_trg from dual;

           select XmlElement ("SumEquivalent", to_char(i.s_equivalent/100, 'FM9999999999999999D00') ) into l_xml_tmp_trg_2 from dual;
           select XmlConcat(l_xml_tmp_trg, l_xml_tmp_trg_2) into l_xml_tmp_trg from dual;

           select XmlElement ("Transaction", l_xml_tmp_trg ) into l_xml_tmp_trg from dual;
           select XmlConcat(l_xml_tmp_src, l_xml_tmp_trg) into l_xml_tmp_src from dual;
        end loop;
       select XmlElement ("Transactions",l_xml_tmp_src )into l_xml_tmp_src from dual;
       select XmlElement ("TransactionCollection",l_xml_tmp_src )into l_xml_tmp_src from dual;

       select XmlConcat(l_xml_main, l_xml_tmp_src) into l_xml_main from dual;
       select XmlConcat( (select XmlElement ("Success", '1' ) from dual), l_xml_main) into l_xml_main from dual;
       select XmlConcat( ( select XmlElement ("ErrorMessage", '' ) from dual ), l_xml_main) into l_xml_main from dual;
       select XmlElement ("LimitStatus",l_xml_main )into l_xml_main from dual;

    return to_clob( '<?xml version="1.0" encoding="utf-8"?>'||l_xml_main.getStringVal());
    exception
      when others then
        begin
          l_msg := sqlerrm;

          select XmlElement ("ErrorMessage",l_msg ) into l_xml_tmp_trg from dual;
          select XmlElement ("Success",'0') into l_xml_tmp_src from dual;
          select XmlConcat (l_xml_tmp_trg , l_xml_tmp_src) into l_xml_tmp_src from dual;
          select XmlElement ("LimitStatus",l_xml_tmp_src )into l_xml_main from dual;

          return  '<?xml version="1.0" encoding="utf-8"?>'||l_xml_main.getStringVal();
        end;
    end;

  end get_limit_status;

  /* Сума та параметри запиту зберігаються для подальшого аудиту*/

  procedure audit(p_user varchar2, p_doc_series varchar2, p_doc_number varchar2, p_id_list varchar2, p_success out number, p_message out varchar2, p_error_msg out varchar2) is
    l_id_list varchar2(4000);
    l_sum     number;
    l_count   number;
  begin

    execute immediate 'select count(*), sum(l.S_EQUIVALENT) from lcs_transactions l where l.id in ( ' ||
                      p_id_list || ')'
      into l_count, l_sum;

    begin
      insert into LCS_AUDIT_MASTER
        (user_id, audit_date, doc_series, doc_number, amount, summ_selected)
      values
        (p_user, sysdate, p_doc_series, p_doc_number, l_count, l_sum);
      commit;

      p_message   := ' Дані успішно збережено';
      p_error_msg := '';
      p_success   := 1;

    exception
      when others then
        begin
          p_message   := 'Виникла внутрішня помилка. Дані не збережено';
          p_error_msg := sqlerrm;
          p_success   := 0;
        end;
    end;
  end audit;
-- Встановлення ознаки виплати
function set_return(p_src_trans_id varchar2,
                    p_mfo          varchar2,
                    p_source_type  varchar2) return varchar2 is
  PRAGMA AUTONOMOUS_TRANSACTION;
  l_count number;
  l_res   varchar2(4000);
begin
bars_audit.info ('LCS.SET_RETURN2. p_src_trans_id:'||p_src_trans_id|| ' p_mfo '|| p_mfo);
select count(*)
    into l_count
    from lcs_transactions l
   where to_char(l.src_trans_id) = p_src_trans_id
          and l.trans_code in ('CN1','CUV')
          and l.src_id = get_source_id(p_source_type)
          and l.mfo = p_mfo;
bars_audit.info ('LCS.SET_RETURN3. l_count:'||l_count);
  case
    when l_count = 0 then
      l_res := 'Відповідної транзакції не знайдено';
    when l_count = 1 then
    begin
     l_res := 'OK';
         update lcs_transactions l
           set l.status_id = 'RETURN'
         where to_char(l.src_trans_id) = p_src_trans_id
          and l.trans_code in ('CN1','CUV')
          and l.src_id = get_source_id(p_source_type)
          and l.mfo = p_mfo;
         commit;
bars_audit.info ('LCS.SET_RETURN3_1. p_source_type:'||p_source_type||' p_mfo: '||p_mfo);
         exception
           when others
             then l_res := 'Виникла помилка. Статус RETURN не встановлено!'||sqlerrm;
       end;
    else


      l_res := 'Знайдено більше однієї транзакції';
  end case;
bars_audit.info ('LCS.SET_RETURN4. l_res:'||l_res);
  return l_res;


end;

--Отримання ознаки винятку по призначенню платежу
function f_get_exception_by_nazn(p_nazn varchar2) return integer is
  l_exception_flag integer;
begin
  begin
    select l.exception_flag
      into l_exception_flag
      from lcs_exception_nazn l
     where upper(p_nazn) like  upper(l.nazn)
       and rownum = 1;
  exception
    when no_data_found then
      l_exception_flag := 0;
  end;
  return l_exception_flag;
end f_get_exception_by_nazn;

--Перевірка зі списком BLACKLIST
  function f_get_blacklist(p_ida   varchar2,
                            p_idb    varchar2,
                            p_mfoa   varchar2,
                            p_mfob   varchar2,
                            p_namea  varchar2,
                            p_nameb  varchar2,
                            p_nlsa   varchar2,
                            p_nlsb   varchar2) return varchar2 is
  l_namea varchar2(160) := decode_base_to_row(p_namea);
  l_nameb varchar2(160) := decode_base_to_row(p_nameb);
  l_ida number(10) := to_number(p_ida);
  l_idb number(10) := to_number(p_idb);
  l_cnt integer;
  l_res varchar2(160);
begin
  begin
  --bars_audit.info ('LCS_PACK: start');
    select  count(1)
            into l_cnt
      from lcs_black_list blc
     where l_ida = blc.okpo
           or  l_idb = blc.okpo
           or (p_nlsa = blc.nls and p_mfoa = blc.mfo)
           or (p_nlsb = blc.nls and p_mfob = blc.mfo);
  end;
        if l_cnt > 0 then
               return 'Заборона проведення операції по клієнту '||l_nameb|| ' ЄДРПО '|| l_idb ||' зі списку неблагонадійних партнерів (BLACKLIST)';
         else
          l_res := 'OK';
        end if;
  return l_res;
end f_get_blacklist;

begin
  -- Initialization
  init;
end LCS_PACK;
/
