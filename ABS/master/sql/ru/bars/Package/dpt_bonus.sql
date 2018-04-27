PROMPT ===================================================================================== 
PROMPT ===================== *** create package dpt_bonus *** ==============================
PROMPT ===================================================================================== 

CREATE OR REPLACE PACKAGE DPT_BONUS
IS
/****************************************************************************************

-- ----------------------------------------------------------------------------------- --
--  Пакет обработки запросов на изменение %-ных ставок по депозитных договороам ФЛ
-- ----------------------------------------------------------------------------------- --

 Дата      Автор Описание
 --------  ----- ------------------------------------------------------------------------
 31.07.07  Инна  Создание пакета
 06.02.18  Геннадий Лившиц изменения в рамках задачи COBUMMFO-5176
****************************************************************************************/
-- поддержка версионности пакета
g_header_version  CONSTANT VARCHAR2(64)  := 'version 1.02 24/02/2018';
g_awk_header_defs CONSTANT VARCHAR2(512) := '';

-- фиксация типа данных и маск.размерности для текстов сообщений
g_errmsg        VARCHAR2(3000);
g_errmsg_dim    CONSTANT NUMBER NOT NULL := 3000;

-- подтип данных для определения размерности льготы
SUBTYPE ratetype IS number(9, 6);

--
-- установка контекста bars_dpt_bonus (cust_id, type_id)
--
PROCEDURE set_dpt_bonus_context
  (p_custid IN customer.rnk%type,                -- регистр.№ клиента
   p_typeid IN dpt_vidd.vidd%type,               -- вид депозитного договора
   p_dptid  IN dpt_deposit.deposit_id%type );    -- идентификатор деп.договора

--
-- определение того, является ли клиент инсайдером банка
--
FUNCTION is_insider
  (p_custcode IN customer.okpo%type)             -- идентиф.код клиента
   RETURN number;

--
-- прогнозный расчет бонусной ставки
--
FUNCTION estimate_bonus
  (p_custid IN customer.rnk%type,                -- регистр.№ клиента
   p_typeid IN dpt_vidd.vidd%type)               -- код вида вклада
   RETURN number;

--
-- Визначення bonus_id по коду на дату
--
FUNCTION get_bonus_id
  (p_bonus_code  bars.dpt_bonuses.bonus_code%type, -- код бонуса
   p_date date default null) 
   RETURN number;

--
-- Визначення кількості ЗП-карт по всім МФО
--
FUNCTION get_MMFO_ZPcard_count
  (p_rnk IN customer.rnk%type,
   p_dat IN date default null)
   RETURN number;
--   
-- Вирахування бонуса 
--
FUNCTION get_bonus_value
  (p_bonusid     dpt_bonuses.bonus_id%type,
   p_bonusquery  dpt_bonuses.bonus_query%type default null,
   p_dat         date default null) -- если null, то на текущую дату
   RETURN number;
   
--
-- установка запросов на получение льготы по договору
--
PROCEDURE set_bonus
  (p_dptid dpt_deposit.deposit_id%type);         -- идентификатор договора

--
-- проверка окончания обработки запросов на получение льгот
--
FUNCTION request_processing_done
  (p_dptid dpt_deposit.deposit_id%type)          -- идентификатор договора
   RETURN char;

--
-- удаление запроса на получение льготы
--
PROCEDURE del_request
   (p_dptid   IN dpt_deposit.deposit_id%type,    -- идентификатор договора
    p_bonusid IN dpt_bonuses.bonus_id%type);     -- идентификатор льготы

--
-- формирование дополнительного (ручного) запроса на получение льготы
--
PROCEDURE ins_request
   (p_dptid   IN dpt_deposit.deposit_id%type,    -- идентификатор договора
    p_bonusid IN dpt_bonuses.bonus_id%type);     -- идентификатор льготы

--
-- проверка допустимости формирования доп.(ручн.) запросов на получение льготы
--
FUNCTION ins_request_allowed
   (p_dptid   IN dpt_deposit.deposit_id%type)    -- идентификатор договора
    RETURN char;

--
-- подтверждение / удаление запроса на получение льготы
--
PROCEDURE request_confirmation
   (p_dptid    IN dpt_deposit.deposit_id%type,    -- идентификатор договора
    p_bonusid  IN dpt_bonuses.bonus_id%type,      -- идентификатор льготы
    p_confirm  IN char,                           -- флаг подтверждения
    p_bonusval IN ratetype);                      -- факт.значение льготы

--
-- перерасчет значения льготы
--
PROCEDURE request_recalculation
  (p_dptid    IN dpt_deposit.deposit_id%type);   -- идентификатор договора

--
-- проверка установки и фиксации в БД льготной ставки по договору
--
FUNCTION bonus_fixed
  (p_dptid dpt_deposit.deposit_id%type)
   RETURN char;

--
-- окончательный расчет и установка бонусной %-ной ставки
--
PROCEDURE set_bonus_rate
  (p_dptid    IN  dpt_deposit.deposit_id%type,         -- идентификатор договора
   p_bdate    IN  fdat.fdat%type,                      -- дата установка бонусной ставки
   p_bonusval OUT ratetype);                           -- размер льготы по факту

--
-- окончательный расчет и установка бонусной %-ной ставки (без ошибок)
PROCEDURE set_bonus_rate_web
  (p_dptid    IN  dpt_deposit.deposit_id%type,         -- идентификатор договора
   p_bdate    IN  fdat.fdat%type,                      -- дата установка бонусной ставки
   p_bonusval OUT ratetype);                           -- размер льготы по факту
--
-- управление привязкой льгот к видам договоров
--
PROCEDURE manage_dptviddbonus
  (p_bonusid   IN dpt_vidd_bonuses.bonus_id%type,      -- идентификатор льготы
   p_typeid    IN dpt_vidd_bonuses.vidd%type,          -- код вида договора
   p_rang      IN dpt_vidd_bonuses.rec_rang%type,      -- ранг льготы
   p_activity  IN dpt_vidd_bonuses.rec_activity%type,  -- признак активности привязки
   p_condition IN dpt_vidd_bonuses.rec_condition%type, -- условие привязки
   p_finally   IN dpt_vidd_bonuses.rec_finally%type);  -- признак окончания просмотра

-- служебная функция: возвращает версию заголовка пакета
FUNCTION header_version RETURN VARCHAR2;

-- служебная функция: возвращает версию тела пакета
FUNCTION body_version RETURN VARCHAR2;

END dpt_bonus;
/

PROMPT ===================================================================================== 
PROMPT ===================== *** create package body dpt_bonus *** =========================
PROMPT =====================================================================================

CREATE OR REPLACE PACKAGE BODY dpt_bonus
IS
g_body_version  CONSTANT varchar2(64)  := 'version 1.16 24/02/2018';
g_awk_body_defs CONSTANT varchar2(512) := ' ';
g_modcode       CONSTANT varchar2(3)   := 'DPT';
g_reqtype       CONSTANT char(5)       := 'BONUS';

--
--
--
PROCEDURE set_dpt_bonus_context
  (p_custid IN customer.rnk%type,
   p_typeid IN dpt_vidd.vidd%type,
   p_dptid  IN dpt_deposit.deposit_id%type)
IS
BEGIN

  bars_audit.trace('set_dpt_bonus_context: РНК = %s, вид вклада = %s',
                   to_char(p_custid), to_char(p_typeid));

  dbms_session.set_context('bars_dpt_bonus', 'cust_id', to_char(p_custid));

  dbms_session.set_context('bars_dpt_bonus', 'type_id', to_char(p_typeid));

  dbms_session.set_context('bars_dpt_bonus', 'dpt_id',  to_char(p_dptid));

END set_dpt_bonus_context;
--
--
--
FUNCTION is_insider
  (p_custcode IN customer.okpo%type)
   RETURN number
IS
  l_title      varchar2(60) := 'dpt_bonus(is_insider): ';
  l_fl_insider number(1)    := 0;
BEGIN

  bars_audit.trace('%s идентиф.код клиента = %s', l_title, p_custcode);

  SELECT decode(count(*), 0, 0, 1)
    INTO l_fl_insider
    FROM dpt_insiders
   WHERE okpo = p_custcode
     AND length(p_custcode) = 10
     AND p_custcode IS NOT NULL
     AND p_custcode NOT LIKE '00000%';

  bars_audit.trace('%s признак инсайдера = %s', l_title, to_char(l_fl_insider));

  RETURN l_fl_insider;

END is_insider;
--
--
--
FUNCTION check_bonus_condition
  (p_bonusid   dpt_vidd_bonuses.bonus_id%type,
   p_condition dpt_vidd_bonuses.rec_condition%type)
  RETURN char
IS
  l_title   varchar2(60) := 'dpt_bonus(check_bonus_condition): ';
  l_check   char(1);
BEGIN

  bars_audit.trace('%s льгота № %s, условие привязки = %s',
                   l_title, to_char(p_bonusid), p_condition);

  IF p_condition IS NOT NULL THEN

      BEGIN
        EXECUTE IMMEDIATE p_condition INTO l_check using p_bonusid;
      EXCEPTION
        WHEN OTHERS THEN
          -- Ошибка вычисления активности привязки льготы
          bars_error.raise_nerror(g_modcode, 'BONUS_CHECK_ERROR', substr(SQLERRM,1,g_errmsg_dim));
      END;

  ELSE

    l_check := 'Y';

  END IF;

  bars_audit.trace('%s флаг допустимости привязки = %s', l_title, l_check);

  RETURN l_check;

END check_bonus_condition;
--
-- Вирахування бонуса (по полю dpt_bonuses.bonus_query)
--
FUNCTION get_bonus_value
  (p_bonusid     dpt_bonuses.bonus_id%type,
   p_bonusquery  dpt_bonuses.bonus_query%type default null,
   p_dat         date default null) -- если null, то на текущую дату
   RETURN number
IS
  l_title    varchar2(60)    := 'dpt_bonus(get_bonus_value): ';
  l_bonusquery dpt_bonuses.bonus_query%type;
  l_bonusval ratetype        := 0;
  l_dat      date;
BEGIN

  if p_dat is null then
    l_dat := trunc(sysdate);
  else 
    l_dat := trunc(p_dat);
  end if;
  
  if p_bonusquery is null then
    begin 
     select bonus_query 
     into l_bonusquery
     from dpt_bonuses
     where bonus_id = p_bonusid; 
    exception when no_data_found then
      -- Ошибка вычисления размера льготы
     bars_error.raise_nerror(g_modcode, 'BONUS_CALC_ERROR', substr(SQLERRM,1,g_errmsg_dim));
    end;
  else 
    l_bonusquery := p_bonusquery;
  end if;    
     
  bars_audit.trace('%s льгота № %s, запрос для расчета = %s на дату %s' ,
                   l_title, to_char(p_bonusid), l_bonusquery, to_char(l_dat,'DD.MM.YYYY'));
      
  EXECUTE IMMEDIATE l_bonusquery INTO l_bonusval USING l_dat;
  bars_audit.trace('%s льгота = %s', l_title, l_bonusval);

  RETURN l_bonusval;

EXCEPTION
  WHEN OTHERS THEN
    -- Ошибка вычисления размера льготы
    bars_error.raise_nerror(g_modcode, 'BONUS_CALC_ERROR', substr(SQLERRM,1,g_errmsg_dim));
END get_bonus_value;
--
--
--

--=== Визначення bonus_id по коду на дату
FUNCTION get_bonus_id
  (p_bonus_code  bars.dpt_bonuses.bonus_code%type,
   p_date        date default null) -- если null , то возвращает ID действующего бонуса (с bonus_off is null)
RETURN number
IS
  l_title    varchar2(60)    := 'dpt_bonus(get_bonus_id): ';
  l_bonusid bars.dpt_bonuses.bonus_id%type;
  l_date date;
BEGIN
  
  begin
  if p_date is null then

    select bonus_id 
    into l_bonusid
    from bars.dpt_bonuses 
    where bonus_code = p_bonus_code 
      and bonus_activity = 'Y' 
      and bonus_off is null;

  else 

    select bonus_id 
    into l_bonusid
    from bars.dpt_bonuses 
    where bonus_code = p_bonus_code 
      and bonus_activity = 'Y' 
      and p_date between bonus_on and nvl(bonus_off, to_date('31.12.4999','DD.MM.YYYY'));

  end if;    

  exception when others then
    bars_error.raise_nerror(g_modcode, 'BONUS_CHECK_ERROR', substr(SQLERRM,1,g_errmsg_dim));
  end;      

  bars_audit.trace('%s bonus_id = %s', l_title, l_bonusid);
  RETURN l_bonusid;

END get_bonus_id;
--
--
-- Визначення кількості ЗП-карт по всім МФО
FUNCTION get_MMFO_ZPcard_count
  (p_rnk IN customer.rnk%type,
   p_dat IN date default null)
   RETURN number
IS
  l_title      varchar2(60) := 'dpt_bonus(ZPcard_count): ';
  l_ZPcard_count number(1)    := 0;
  l_cnt          number       := 0;
  l_dat date;
  l_mfo mv_kf.kf%type;
BEGIN
  if p_dat is null then
    l_dat := trunc(sysdate);
  else
    l_dat := trunc(p_dat);  
  end if;
  
  bars_audit.trace('%s RNK клиента = %s дата %s', l_title, p_rnk, l_dat);
  
  /* --Пока в ВЕБе нельзя перескакивать на соседние МФО. После изменения барс-контекста, можно будет
  l_mfo := nvl(gl.aMFO,'/');
    
  --необходимо учитывать ЗП-проекты по всем МФО
  bc.go('/');
  FOR cur IN (SELECT kf FROM bars.mv_kf) LOOP --cur
    bc.go(cur.kf);
    bars_audit.trace('%s MFO = %s', l_title, cur.kf);
  */    
    SELECT count(acc)
    INTO l_cnt
    FROM accounts
    WHERE rnk = p_rnk
      AND NBS = 2625
      AND OB22 IN ('24', '27', '31')
      AND l_dat between daos and nvl(dazs, to_date('31.12.4999','DD.MM.YYYY'));
    
    l_ZPcard_count := l_ZPcard_count + l_cnt;
   /* bars_audit.trace('%s кол-во ЗП-карт = %s', l_title, to_char(l_cnt));
  END LOOP;
  bc.go(l_mfo);
  */    
  bars_audit.trace('%s Общее кол-во ЗП-карт = %s', l_title, to_char(l_ZPcard_count));

  RETURN l_ZPcard_count;

END get_MMFO_ZPcard_count;

--
--
--
PROCEDURE create_bonus_request
  (p_dptid       IN dpt_bonus_requests.dpt_id%type,
   p_bonusid     IN dpt_bonus_requests.bonus_id%type,
   p_bonusvalue  IN dpt_bonus_requests.bonus_value_plan%type,
   p_reqconfirm  IN dpt_bonus_requests.request_confirm%type,
   p_reqauto     IN dpt_bonus_requests.request_auto%type,
   p_reqrecalc   IN dpt_bonus_requests.request_recalc%type,
   p_requser     IN dpt_bonus_requests.request_user%type,
   p_branch      IN dpt_bonus_requests.branch%type,
   p_reqid       IN dpt_bonus_requests.req_id%type)
IS
  l_title        varchar2(60) := 'dpt_bonus(create_bonus_request): ';
  l_reqdate      dpt_bonus_requests.request_date%type;
  l_reqbdate     dpt_bonus_requests.request_bdate%type;
  l_bonusvalueF  dpt_bonus_requests.bonus_value_fact%type;
  l_reqstate     dpt_bonus_requests.request_state%type;
  l_reqdeleted   dpt_bonus_requests.request_deleted%type;
  l_processdate  dpt_bonus_requests.process_date%type;
  l_processuser  dpt_bonus_requests.process_user%type;
BEGIN
  bars_audit.trace('%s для договора № %s размер льготы № %s = %s',
                   l_title, to_char(p_dptid), to_char(p_bonusid), to_char(p_bonusvalue));

  l_reqdeleted  := 'N';
  l_reqdate     := sysdate;
  l_reqbdate    := gl.bdate;

  IF p_reqconfirm = 'N' THEN
     bars_audit.trace('%s льгота № %s не требует подтверждения', l_title, to_char(p_bonusid));
     l_bonusvalueF := p_bonusvalue;
     l_reqstate    := 'ALLOW';
     l_processdate := l_reqdate;
     l_processuser := p_requser;
  ELSE
     bars_audit.trace('%s льгота № %s требует подтверждения', l_title, to_char(p_bonusid));
     l_bonusvalueF := null;
     l_reqstate    := 'NULL';
     l_processdate := null;
     l_processuser := null;
  END IF;
  begin
  INSERT INTO dpt_bonus_requests
     (dpt_id,
      bonus_id,
      bonus_value_plan,
      bonus_value_fact,
      request_date,
      request_bdate,
      request_user,
      request_state,
      request_auto,
      request_confirm,
      request_recalc,
      request_deleted,
      process_date,
      process_user,
      branch,
      req_id)
  VALUES
     (p_dptid,
      p_bonusid,
      p_bonusvalue,
      l_bonusvalueF,
      l_reqdate,
      l_reqbdate,
      p_requser,
      l_reqstate,
      p_reqauto,
      p_reqconfirm,
      p_reqrecalc,
      l_reqdeleted,
      l_processdate,
      l_processuser,
      p_branch,
      p_reqid);

   bars_audit.trace('%s создан запрос на получение льготы № %s по договору № %s',l_title, to_char(p_bonusid), to_char(p_dptid));

   exception when others then
    bars_audit.error(l_title || dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());
   end;

EXCEPTION
  WHEN OTHERS THEN
    -- Ошибка вставки запроса на получение льготы
    bars_error.raise_nerror(g_modcode, 'FIX_BONUS_REQUEST_ERROR',
                            to_char(p_dptid), to_char(p_bonusid), substr(SQLERRM,1,g_errmsg_dim));
END create_bonus_request;
--
--
--
PROCEDURE process_bonus_query
  (p_dptid  IN  dpt_bonus_requests.dpt_id%type,
   p_reqid  IN  dpt_bonus_requests.req_id%type)
IS
  l_title        varchar2(60) := 'dpt_bonus(process_bonus_query): ';
  l_inquery      number(38);
  l_needconfirm  number(38);
  l_tmp          number;
BEGIN

  bars_audit.trace('%s договор № %s, запрос № %s', l_title, to_char(p_dptid), to_char(p_reqid));

  -- статус глоб.запроса
  SELECT decode(req_state, null, 1, 0)
    INTO l_inquery
    FROM dpt_requests
   WHERE req_id = p_reqid;
  bars_audit.trace('%s наличие запросов в очереди = %s', l_title, to_char(l_inquery));

  -- кол-во необработанных запросов, требующих подтверждения
  SELECT count(*)
    INTO l_needconfirm
    FROM dpt_bonus_requests
   WHERE dpt_id = p_dptid
     AND req_id = p_reqid
     AND request_deleted = 'N'
     AND request_confirm = 'Y'
     AND request_state = 'NULL';
  bars_audit.trace('%s кол-во необработанных запросов, треб.подтверждения = %s',
                   l_title, to_char(l_needconfirm));

  IF (l_inquery = 1 AND l_needconfirm = 0) THEN

     -- нет необработанных запросов - закрываем глоб.запрос, удаляем из очереди
     bars_audit.trace('%s удаление договора из очереди запросов', l_title);

     dpt_web.set_bonusreq_state(p_dptid, p_reqid);

     bars_audit.trace('%s закрыт глобальный запрос № %s по договору № %s',
                      l_title, to_char(p_reqid), to_char(p_dptid));

  ELSIF (l_inquery = 0 AND l_needconfirm = 1) THEN

    -- есть необработанные записи в закрытом запросе на получение льгот по договору №
    bars_error.raise_nerror(g_modcode, 'BONUS_QUERY_DISBALANCE', to_char(p_reqid), to_char(p_dptid));

  ELSE -- (l_inquery = l_needconfirm)

     bars_audit.trace('%s запросы согласованы с очередью', l_title);

  END IF;

END process_bonus_query;
--
--
--
PROCEDURE bonus_exclusion
  (p_dptid   IN dpt_deposit.deposit_id%type,
   p_branch  IN dpt_deposit.branch%type,
   p_vidd    IN dpt_deposit.vidd%type)
IS
  l_title varchar2(60) := 'dpt_bonus(bonus_exclusion): ';
  l_func  dpt_bonus_complex.func_name%type;
BEGIN

  bars_audit.trace('%s идентификатор договора %s, вид договора %s, подразделение %s',
                   l_title, to_char(p_dptid), to_char(p_vidd), p_branch);

  BEGIN
    SELECT func_name
      INTO l_func
      FROM dpt_bonus_complex
     WHERE vidd = p_vidd
       AND func_activity = 'Y';

    bars_audit.trace('%s для вида договора %s описана процедура исключения - %s',
                     l_title, to_char(p_vidd), l_func);

    BEGIN
      EXECUTE IMMEDIATE l_func USING p_dptid, p_branch;
    EXCEPTION
      WHEN OTHERS THEN
        -- Ошибка при выполнении процедуры исключения льгот по договору
        bars_error.raise_nerror(g_modcode, 'BONUS_EXCLUSION_ERROR', substr(SQLERRM,1,g_errmsg_dim));
    END;
    bars_audit.trace('%s процедура исключения выполнена', l_title);

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      bars_audit.trace('%s процедура исключения отсутствует', l_title);
  END;

END bonus_exclusion;
--
-- Оцінка бонуса
--
FUNCTION estimate_bonus
  (p_custid IN customer.rnk%type,
   p_typeid IN dpt_vidd.vidd%type)
   RETURN number
IS
  l_title       varchar2(60) := 'dpt_bonus(estimate_bonus): ';
  l_bonuscheck  dpt_bonuses.bonus_activity%type;
  l_plsqlblock  dpt_bonuses.bonus_query%type;
  l_bonusvalue  ratetype;
  l_totalbonus  ratetype;
BEGIN

  bars_audit.trace('%s вид договора = %s', l_title, to_char(p_typeid));

  -- установка контекста bars_dpt_bonus
  set_dpt_bonus_context (p_custid, p_typeid, NULL);

  l_totalbonus := 0;

  FOR b IN
     (SELECT b.bonus_id, b.bonus_name, b.bonus_query,
             bv.rec_condition, bv.rec_rang, bv.rec_finally
        FROM dpt_bonuses b, dpt_vidd_bonuses bv
       WHERE b.bonus_id = bv.bonus_id
         AND bv.rec_activity  = 'Y'
         AND b.bonus_activity = 'Y'
         AND b.bonus_multiply = 'N'
         AND b.bonus_confirm  = 'N'
         AND bv.vidd = p_typeid
       ORDER BY bv.rec_rang)
  LOOP
    bars_audit.trace('%s льгота %s', l_title, b.bonus_name);

    -- проверка условия привязки
    BEGIN
      l_bonuscheck := check_bonus_condition (b.bonus_id, b.rec_condition);
    EXCEPTION
      WHEN bars_error.err THEN
        IF bars_error.get_nerror_code(sqlerrm) = 'DPT-'||'BONUS_CHECK_ERROR' THEN
           -- Ошибка вычисления активности привязки льготы к виду вклада
           bars_error.raise_nerror(g_modcode, 'BONUS_CHECK_FAILED',
                                   to_char(b.bonus_id), b.bonus_name, to_char(p_typeid),
                                   substr(SQLERRM,1,g_errmsg_dim));
        ELSE
          RAISE;
        END IF;
    END;
    bars_audit.trace('%s флаг допустимости привязки = %s', l_title, l_bonuscheck);

    -- расчет значения ставки
    IF l_bonuscheck = 'Y' THEN

       bars_audit.trace('%s расчет значения ставки', l_title);
       l_bonusvalue := 0;

       BEGIN
         l_bonusvalue := get_bonus_value (b.bonus_id, b.bonus_query);
       EXCEPTION
         WHEN bars_error.err THEN
           IF bars_error.get_nerror_code(sqlerrm) = 'DPT-'||'BONUS_CALC_ERROR' THEN
              -- Ошибка вычисления размера льготы
              bars_error.raise_nerror(g_modcode, 'BONUS_CALC_FAILED',
                                      to_char(b.bonus_id), b.bonus_name,
                                      substr(SQLERRM,1,g_errmsg_dim));
           ELSE
             RAISE;
           END IF;
       END;
       bars_audit.trace('%s размер льготы = %s', l_title, l_bonusvalue);

       l_totalbonus := l_totalbonus + l_bonusvalue;
       bars_audit.trace('%s суммарная льгота = %s', l_title, l_totalbonus);

    END IF;

    -- для льготы установлен флаг единственности
    IF b.rec_finally = 'Y' AND l_totalbonus != 0 THEN
       bars_audit.trace('%s для льготы установлен флаг единственности', l_title);
       RETURN l_totalbonus;
    END IF;

  END LOOP;

  RETURN l_totalbonus;

END estimate_bonus;
--
--
--
PROCEDURE set_bonus
  (p_dptid dpt_deposit.deposit_id%type)
IS
  l_title       varchar2(60)         := 'dpt_bonus(set_bonus): ';
  l_enough      char(1)              := 'N';
  l_userid      staff.id%type        := gl.auid;
  l_branch      branch.branch%type   := sys_context('bars_context','user_branch');
  l_dpt         dpt_deposit%rowtype;
  l_reqid       dpt_requests.req_id%type;
  l_bonuscheck  char(1);
  l_bonusvalue  ratetype;
  l_bonusdate   date;
BEGIN

  bars_audit.trace('%s идентификатор договора = %s', l_title, to_char(p_dptid));

  -- вычитка параметров договора
  BEGIN
    SELECT * INTO l_dpt FROM dpt_deposit WHERE deposit_id = p_dptid;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      bars_error.raise_nerror(g_modcode, 'DPT_NOT_FOUND', to_char(p_dptid));
  END;
  bars_audit.trace('%s договор № %s, вид договора № %s, РНК = %s',
                   l_title, l_dpt.nd, to_char(l_dpt.vidd), to_char(l_dpt.rnk));

  -- установка контекста bars_dpt_bonus
  set_dpt_bonus_context (p_custid => l_dpt.rnk,
                         p_typeid => l_dpt.vidd,
                         p_dptid  => l_dpt.deposit_id);
  bars_audit.trace('%s установлен контекст bars_dpt_bonus', l_title);

  -- создание глобального запроса
  l_reqid := dpt_web.create_request (g_reqtype, p_dptid);
  bars_audit.trace('%s сформирован запрос № %s', l_title, to_char(l_reqid));
    insert into dpt_bonus_requests_arc
    select * from dpt_bonus_requests where dpt_id = p_dptid;
    BARS_AUDIT.trace(l_title|| to_char(sql%rowcount) || ' rows inserted dpt_bonus_requests_arc.');
    delete dpt_bonus_requests where dpt_id = p_dptid;
    BARS_AUDIT.trace(l_title|| to_char(sql%rowcount) || ' rows deleted dpt_bonus_requests.');
  -- отбор всех активных льгот для данного вида вклада
  <<bonus_loop>>
  FOR b IN
     (SELECT b.bonus_id, b.bonus_name, b.bonus_code, b.bonus_query, b.bonus_multiply, b.bonus_confirm,
             bv.rec_condition, bv.rec_rang, bv.rec_finally, dv.type_cod
        FROM dpt_bonuses b, dpt_vidd_bonuses bv, dpt_vidd dv
       WHERE b.bonus_id = bv.bonus_id
         AND dv.vidd = bv.vidd
         AND bv.rec_activity  = 'Y'
         AND b.bonus_activity = 'Y'
         AND bv.vidd = l_dpt.vidd
         AND l_enough = 'N'
       ORDER BY bv.rec_rang)
  LOOP

    bars_audit.trace('%s льгота № %s - %s', l_title, to_char(b.bonus_id), b.bonus_name);

    -- проверка условия привязки
    BEGIN
      l_bonuscheck := check_bonus_condition (b.bonus_id, b.rec_condition);
    EXCEPTION
      WHEN bars_error.err THEN
        IF bars_error.get_nerror_code(sqlerrm) = 'DPT-'||'BONUS_CHECK_ERROR' THEN
           -- Ошибка вычисления активности привязки льготы к виду вклада
           bars_error.raise_nerror(g_modcode, 'BONUS_CHECK_FAILED',
                                   to_char(b.bonus_id), b.bonus_name, to_char(l_dpt.vidd),
                                   substr(SQLERRM,1,g_errmsg_dim));
        ELSE
          RAISE;
        END IF;
    END;
    bars_audit.trace('%s флаг допустимости привязки = %s', l_title, l_bonuscheck);

    -- расчет значения льготы, если льгота разрешена
    IF l_bonuscheck = 'Y' THEN
       BEGIN
         -- COBUMMFO-5176
         if b.bonus_code = 'DPWB' or b.bonus_code = 'DPZP' then  -- для он-лайн бонуса берем дату открытия договора
           if b.type_cod = 'MPRG' then -- но, если депозит прогрессивный, то берем дату открытия или каждой 12-й пролонгации
              select nvl(max(dat_begin), l_dpt.dat_begin)
              into l_bonusdate
              from bars.dpt_deposit_clos
              where deposit_id = l_dpt.deposit_id
              and nvl(cnt_dubl,0) = trunc(nvl(l_dpt.cnt_dubl,0)/12) * 12;
            else 
              l_bonusdate := l_dpt.dat_begin;
            end if;  
          l_bonusvalue := get_bonus_value (b.bonus_id, b.bonus_query, l_bonusdate);
         else 
           l_bonusvalue := get_bonus_value (b.bonus_id, b.bonus_query);
         end if;  
       EXCEPTION
         WHEN bars_error.err THEN
           IF bars_error.get_nerror_code(sqlerrm) = 'DPT-'||'BONUS_CALC_ERROR' THEN
              -- Ошибка вычисления размера льготы
              bars_error.raise_nerror(g_modcode, 'BONUS_CALC_FAILED',
                                      to_char(b.bonus_id), b.bonus_name,
                                      substr(SQLERRM,1,g_errmsg_dim));
           ELSE
             RAISE;
           END IF;
       END;
       bars_audit.trace('%s размер льготы = %s', l_title, l_bonusvalue);

       -- запись ненулевой льготы
       IF (l_bonusvalue != 0) THEN

          -- фиксация запроса на получение льготы
          create_bonus_request (p_dptid       => p_dptid,
                                p_bonusid     => b.bonus_id,
                                p_bonusvalue  => l_bonusvalue,
                                p_reqconfirm  => b.bonus_confirm,
                                p_reqauto     => 'Y',
                                p_reqrecalc   => 'N',
                                p_requser     => l_userid,
                                p_branch      => l_branch,
                                p_reqid       => l_reqid);

          -- для льготы установлен флаг окончания просмотра
          IF (b.rec_finally = 'Y') THEN
              bars_audit.trace('%s для льготы установлен флаг окончания просмотра', l_title);
              l_enough := 'Y';
          END IF;

       END IF;  -- запись ненулевой льготы

    END IF;  -- льгота разрешена

  END LOOP bonus_loop;

  -- исключение льгот (при необходимости)
  BEGIN
    bonus_exclusion (p_dptid, l_branch, l_dpt.vidd);
  EXCEPTION
    WHEN bars_error.err THEN
      IF bars_error.get_nerror_code(sqlerrm) = 'DPT-'||'BONUS_EXCLUSION_ERROR' THEN
         -- Ошибка при выполнении процедуры исключения льгот по договору
         bars_error.raise_nerror(g_modcode, 'BONUS_EXCLUSION_FAILED',
                                 to_char(p_dptid), substr(SQLERRM,1,g_errmsg_dim));
      ELSE
        RAISE;
      END IF;
  END;
  bars_audit.trace('%s выполнена процедура исключения льгот', l_title);

  -- обработки очереди на подтверждение запросов на получение льготы
  process_bonus_query (p_dptid, l_reqid);
  bars_audit.trace('%s выполнена процедура обработки очереди на подтверждение запросов', l_title);

END set_bonus;
--
--
--
FUNCTION request_processing_done
  (p_dptid dpt_deposit.deposit_id%type)
   RETURN char
IS
  l_title  varchar2(60) := 'dpt_bonus(request_processing_done): ';
  l_cnt    number(38);
  l_done   char(1);
BEGIN

  bars_audit.trace('%s договор № %s', l_title, to_char(p_dptid));

  SELECT count(*)
    INTO l_cnt
    FROM dpt_bonus_requests
   WHERE dpt_id = p_dptid
     AND request_deleted = 'N'
     AND request_state = 'NULL' ;
  bars_audit.trace('%s кол-во необработанных запросов = %s', l_title, to_char(l_cnt));

  l_done := CASE
            WHEN l_cnt = 0 THEN 'Y'
            ELSE                'N'
            END;
  bars_audit.trace('%s флаг окончания обработки запросов на получение льгот = %s', l_title, to_char(l_done));

  RETURN l_done;

END request_processing_done;
--
--
--
PROCEDURE del_request
   (p_dptid   IN dpt_deposit.deposit_id%type,
    p_bonusid IN dpt_bonuses.bonus_id%type)
IS
  l_title      varchar2(60) := 'dpt_bonus(del_request): ';
  l_reqstate   dpt_bonus_requests.request_state%type;
  l_reqconfirm dpt_bonus_requests.request_confirm%type;
  l_reqid      dpt_bonus_requests.req_id%type;
BEGIN

  bars_audit.trace('%s договор № %s, льгота № %s', l_title, to_char(p_dptid), to_char(p_bonusid));

  BEGIN
    SELECT request_state, request_confirm, req_id
      INTO l_reqstate, l_reqconfirm, l_reqid
      FROM dpt_bonus_requests
     WHERE dpt_id = p_dptid  AND bonus_id = p_bonusid
    FOR UPDATE OF request_deleted;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- не найден запрос на получение льготы по договору
      bars_error.raise_nerror(g_modcode, 'BONUS_REQUEST_NOT_FOUND',
                              to_char(p_bonusid), to_char(p_dptid));

  END;
  bars_audit.trace('%s статус запроса = %s, флаг подтверждения = %s, глоб.запрос № %s',
                   l_title, to_char(l_reqstate), to_char(l_reqconfirm), to_char(l_reqid));

  IF (l_reqstate != 'NULL' OR l_reqconfirm != 'Y') THEN

   -- запрещено удаление запроса на получение льготы по договору (статус, флаг подтвержд.)
   bars_error.raise_nerror(g_modcode, 'INVALID_BONUS_REQUEST_4DEL',
                           to_char(p_bonusid), to_char(p_dptid),
                           to_char(l_reqstate), to_char(l_reqconfirm));
  END IF;

  BEGIN
    UPDATE dpt_bonus_requests
       SET request_deleted = 'Y',
           request_state   = 'DELET',
           process_date    = sysdate,
           process_user    = gl.auid
     WHERE dpt_id = p_dptid
       AND bonus_id = p_bonusid;
  EXCEPTION
    WHEN OTHERS THEN
      -- ошибка удаления запроса на получение льготы по договору: ...
      bars_error.raise_nerror(g_modcode, 'BONUS_REQUEST_DEL_ERROR',
                              to_char(p_bonusid), to_char(p_dptid),
                              substr(sqlerrm, 1, g_errmsg_dim));
  END;

  IF SQL%ROWCOUNT = 0 THEN
     -- ошибка удаления запроса на получение льготы по договору: ...
     bars_error.raise_nerror(g_modcode, 'BONUS_REQUEST_DEL_ERROR',
                             to_char(p_bonusid), to_char(p_dptid),
                             'no rows updated');
  END IF;

  bars_audit.trace('%s удален запрос на получение льготы № %s по договору № %s',
                   l_title, to_char(p_dptid), to_char(p_bonusid));

  -- обработка очереди на подтверждение запросов на получение льгот
  process_bonus_query (p_dptid, l_reqid);
  bars_audit.trace('%s выполнена процедура обработки очереди на подтверждение запросов', l_title);

END del_request;
--
--
--
PROCEDURE ins_request
   (p_dptid   IN dpt_deposit.deposit_id%type,
    p_bonusid IN dpt_bonuses.bonus_id%type)
IS
  l_title     varchar2(60)       := 'dpt_bonus(ins_request): ';
  l_branch    branch.branch%type := sys_context('bars_context','user_branch');
  l_userid    staff.id%type      := gl.auid;
  l_reqid     dpt_requests.req_id%type;
BEGIN

  bars_audit.trace('%s договор № %s, льгота № %s', l_title, to_char(p_dptid), to_char(p_bonusid));

  -- поиск / создание глобального запроса
  SELECT max(req_id)
    INTO l_reqid
    FROM dpt_requests
   WHERE dpt_id = p_dptid
     AND decode(req_state, null, 1, null) = 1
     AND otm IS NULL
     AND reqtype_id = (SELECT reqtype_id FROM dpt_req_types WHERE reqtype_code = g_reqtype);

  IF l_reqid IS NULL THEN
     l_reqid := dpt_web.create_request (g_reqtype, p_dptid);
     bars_audit.trace('%s сформирован глоб.запрос № %s', l_title, to_char(l_reqid));
  ELSE
     bars_audit.trace('%s найден необработ.глоб.запрос № %s', l_title, to_char(l_reqid));
  END IF;

  create_bonus_request (p_dptid       => p_dptid,
                        p_bonusid     => p_bonusid,
                        p_bonusvalue  => null,
                        p_reqconfirm  => 'Y',
                        p_reqauto     => 'N',
                        p_reqrecalc   => 'Y',
                        p_requser     => l_userid,
                        p_branch      => l_branch,
                        p_reqid       => l_reqid);

  bars_audit.trace('%s сформирован запрос на получение льготы № s к договору № %s',
                   l_title, to_char(p_bonusid), to_char(p_dptid));

  -- обработка очереди на подтверждение запросов на получение льгот
  process_bonus_query (p_dptid, l_reqid);
  bars_audit.trace('%s выполнена процедура обработки очереди на подтверждение запросов', l_title);

END ins_request;
--
--
--
FUNCTION ins_request_allowed
   (p_dptid   IN dpt_deposit.deposit_id%type)
   RETURN char
IS
  l_title varchar2(60)  := 'dpt_bonus(ins_request_allowed): ';
  l_cnt   number(38);
  l_allow  char(1);
BEGIN

  bars_audit.trace('%s договор № %s', l_title, to_char(p_dptid));

  SELECT count(*) INTO l_cnt FROM v_dpt_bonuses_free WHERE dpt_id = p_dptid;

  bars_audit.trace('%s кол-во свободных льгот = %s', l_title, to_char(l_cnt));

  l_allow := CASE
             WHEN l_cnt = 0 THEN 'N'
             ELSE                'Y'
             END;

  bars_audit.trace('%s флаг допустимости ручного формировнаия запросов = %s', l_title, l_allow);

  RETURN l_allow;

END ins_request_allowed;
--
--
--
PROCEDURE request_confirmation
   (p_dptid    IN dpt_deposit.deposit_id%type,
    p_bonusid  IN dpt_bonuses.bonus_id%type,
    p_confirm  IN char,
    p_bonusval IN ratetype)
IS
  l_title    varchar2(60) := 'dpt_bonus(request_confirmation): ';
  l_bonusreq dpt_bonus_requests%rowtype;
  l_state    dpt_bonus_requests.request_state%type;
  l_value    dpt_bonus_requests.bonus_value_fact%type;
BEGIN

  bars_audit.trace('%s договор № %s, льгота № %s, признак подтвержд. = %s, значение льготы = %s',
                   l_title, to_char(p_dptid), to_char(p_bonusid), p_confirm, to_char(p_bonusval));

  BEGIN
    SELECT * INTO l_bonusreq
      FROM dpt_bonus_requests
     WHERE dpt_id = p_dptid AND bonus_id = p_bonusid
    FOR update OF bonus_value_fact NOWAIT;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- не найден запрос на получение льготы № %s по договору № %s
     bars_error.raise_nerror(g_modcode, 'BONUS_REQUEST_NOT_FOUND',
                             to_char(p_bonusid), to_char(p_dptid));
  END;

  bars_audit.trace('%s статус запроса = %s, необх-ть подтверждения = %s, '||
                   'признак удаления = %s, план.значение льготы = %s',
                   l_title, l_bonusreq.request_state, l_bonusreq.request_confirm,
                   l_bonusreq.request_deleted, to_char(l_bonusreq.bonus_value_plan));

  IF (l_bonusreq.request_confirm  != 'Y'
   OR l_bonusreq.request_state    != 'NULL'
   OR l_bonusreq.request_deleted   = 'Y'
   OR l_bonusreq.bonus_value_plan IS NULL   ) THEN
      -- подтверждение запроса на получение льготы № %s по договору № %s недопустимо
      bars_error.raise_nerror(g_modcode, 'INVALID_BONUS_REQUEST_2CONFIRM',
                             to_char(p_bonusid), to_char(p_dptid),
                             l_bonusreq.request_state, l_bonusreq.request_confirm,
                             l_bonusreq.request_deleted, to_char(l_bonusreq.bonus_value_plan));
  END IF;

  IF p_confirm = 'Y' THEN
     l_value := nvl(p_bonusval, l_bonusreq.bonus_value_plan);
     l_state := 'ALLOW';
  ELSE
     l_value := null;
     l_state := 'REGRT';
  END IF;

  bars_audit.trace('%s статус запроса = %s, факт.значение льготы = %s',
                   l_title, l_state, to_char(l_value));

  BEGIN
    UPDATE dpt_bonus_requests
       SET request_state    = l_state,
           bonus_value_fact = l_value,
           process_date     = sysdate,
           process_user     = gl.auid
     WHERE bonus_id = p_bonusid
       AND   dpt_id = p_dptid;
  EXCEPTION
    WHEN OTHERS THEN
      -- ошибка подтверждения запроса на получение льготы № по договору №:...
      bars_error.raise_nerror(g_modcode, 'BONUS_REQUEST_CONFIRM_ERROR',
                              to_char(p_bonusid), to_char(p_dptid),
                              substr(sqlerrm, 1, g_errmsg_dim));
  END;

  IF SQL%ROWCOUNT = 0 THEN
     -- ошибка подтверждения запроса на получение льготы № по договору №:...
     bars_error.raise_nerror(g_modcode, 'BONUS_REQUEST_CONFIRM_ERROR',
                             to_char(p_bonusid), to_char(p_dptid),
                             'no rows updated');
  END IF;

  bars_audit.trace('%s запрос на получение льготы № %s по договору № %s обработан',
                   l_title, to_char(p_bonusid), to_char(p_dptid));

  -- обработки очереди на подтверждение запросов на получение льготы
  process_bonus_query (p_dptid, l_bonusreq.req_id);
  bars_audit.trace('%s выполнена процедура обработки очереди на подтверждение запросов', l_title);

END request_confirmation;
--
--
--
PROCEDURE request_recalculation
  (p_dptid IN dpt_deposit.deposit_id%type)
IS
  l_title      varchar2(60) := 'dpt_bonus(request_recalculation): ';
  l_custid     dpt_deposit.rnk%type;
  l_typeid     dpt_deposit.vidd%type;
  l_datbegin   dpt_deposit.dat_begin%type;
  l_cntdubl    dpt_deposit.cnt_dubl%type;
  l_typecode   dpt_vidd.type_cod%type;
  l_bonusvalue ratetype;

BEGIN

  bars_audit.trace('%s договор № %s', l_title, to_char(p_dptid));

  -- вычитка параметров договора
  BEGIN
    SELECT dd.rnk, dd.vidd, dd.dat_begin, dd.cnt_dubl, dv.type_cod
      INTO l_custid, l_typeid, l_datbegin, l_cntdubl, l_typecode
      FROM dpt_deposit dd,
           dpt_vidd dv
     WHERE dd.deposit_id = p_dptid
       and dd.vidd = dv.vidd;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      bars_error.raise_nerror(g_modcode, 'DPT_NOT_FOUND', to_char(p_dptid));
  END;
  bars_audit.trace('%s вид договора № %s, РНК = %s', l_title, to_char(l_typeid), to_char(l_custid));

  -- установка контекста bars_dpt_bonus
  set_dpt_bonus_context (p_custid => l_custid,
                         p_typeid => l_typeid,
                         p_dptid  => p_dptid);
  bars_audit.trace('%s установлен контекст bars_dpt_bonus', l_title);

  -- отбор всех запросов на перерасчет льгот для данного договора
  <<request_loop>>
  FOR b IN
     (SELECT b.bonus_id, b.bonus_name, b.bonus_code, b.bonus_query, r.request_confirm, r.req_id
        FROM dpt_bonus_requests r, dpt_bonuses b
       WHERE r.dpt_id = p_dptid
         AND r.request_recalc = 'Y'
         AND r.request_state = 'NULL'
         AND r.bonus_value_plan is null
         AND r.bonus_id = b.bonus_id
       ORDER BY 1)
  LOOP

    bars_audit.trace('%s льгота № %s - %s', l_title, to_char(b.bonus_id), b.bonus_name);

    -- расчет значения льготы
    BEGIN
      --COBUMMFO-5176
      if b.bonus_code = 'DPWB' or b.bonus_code = 'DPZP' then  -- для он-лайн бонуса берем дату открытия договора
           if l_typecode = 'MPRG' then -- но, если депозит прогрессивный, то берем дату открытия или каждой 12-й пролонгации
              select nvl(max(dat_begin), l_datbegin)
              into l_datbegin
              from bars.dpt_deposit_clos
              where deposit_id = p_dptid
              and nvl(cnt_dubl,0) = trunc(nvl(l_cntdubl,0)/12) * 12;
            end if;  
        l_bonusvalue := get_bonus_value (b.bonus_id, b.bonus_query, l_datbegin);
      else 
        l_bonusvalue := get_bonus_value (b.bonus_id, b.bonus_query);
      end if;
    EXCEPTION
      WHEN bars_error.err THEN
        IF bars_error.get_nerror_code(sqlerrm) = 'DPT-'||'BONUS_CALC_ERROR' THEN
           -- ошибка перерасчета размера льготы № по договору №: ...
           bars_error.raise_nerror(g_modcode, 'BONUS_RECALC_FAILED',
                                   to_char(b.bonus_id), b.bonus_name, to_char(p_dptid),
                                   substr(SQLERRM,1,g_errmsg_dim));
        ELSE
           RAISE;
        END IF;
    END;
    bars_audit.trace('%s размер льготы = %s', l_title, l_bonusvalue);

    -- изменение значения льготы
    BEGIN

      IF b.request_confirm = 'N' THEN

        bars_audit.trace('%s запрос не требует подтверждения - устанавл.ФАКТ.льготу', l_title);
        UPDATE dpt_bonus_requests
           SET bonus_value_plan = l_bonusvalue,
               bonus_value_fact = l_bonusvalue
         WHERE bonus_id = b.bonus_id AND dpt_id = p_dptid;

      ELSE

        bars_audit.trace('%s запрос требует подтверждения - устанавл.ПЛАН.льготу', l_title);
        UPDATE dpt_bonus_requests
           SET bonus_value_plan = l_bonusvalue
         WHERE bonus_id = b.bonus_id AND dpt_id = p_dptid;

      END IF;

    EXCEPTION
      WHEN OTHERS THEN
        -- ошибка сохранения перерасчитанного значения льготы № по договору №: ...
        bars_error.raise_nerror(g_modcode, 'BONUS_RECALC_ERROR',
                                to_char(b.bonus_id), to_char(p_dptid),
                                substr(SQLERRM,1,g_errmsg_dim));
    END;

    IF SQL%ROWCOUNT = 0 THEN
       -- ошибка сохранения перерасчитанного значения льготы № по договору №: ...
       bars_error.raise_nerror(g_modcode, 'BONUS_RECALC_ERROR',
                               to_char(b.bonus_id), to_char(p_dptid),
                               'no rows updated');
    END IF;

    -- обработки очереди на подтверждение запросов на получение льготы
    process_bonus_query (p_dptid, b.req_id);
    bars_audit.trace('%s выполнена процедура обработки очереди на подтверждение запросов', l_title);

  END LOOP request_loop;

  -- обработки очереди на подтверждение запросов на получение льготы
  -- process_bonus_query (p_dptid);
  -- bars_audit.trace('%s выполнена процедура обработки очереди на подтверждение запросов', l_title);

END request_recalculation;
--
--
--
FUNCTION bonus_fixed
  (p_dptid dpt_deposit.deposit_id%type)
   RETURN char
IS
  l_title varchar2(60) := 'dpt_bonus(bonus_fixed): ';
  l_value dpt_depositw.value%type;
  l_fixed char(1);
BEGIN

  l_value := dpt.f_dptw(p_dptid, 'BONUS');
  bars_audit.trace('%s по договору № %s установлен бонус = %s',
                       l_title, to_char(p_dptid), l_value);

  l_fixed := CASE
             WHEN l_value IS NOT NULL THEN 'Y'
             ELSE                          'N'
             END;
  bars_audit.trace('%s признак выполнения = %s', l_title, l_fixed);

  RETURN l_fixed;

END bonus_fixed;
--
--
--
PROCEDURE set_bonus_rate
   (p_dptid    IN dpt_deposit.deposit_id%type,
    p_bdate    IN fdat.fdat%type,
    p_bonusval OUT ratetype)
IS
  l_title      varchar2(60)       := 'dpt_bonus(set_bonus_rate): ';
  l_branch     branch.branch%type := sys_context('bars_context','user_branch');
  l_totalbonus ratetype;
  l_dptaccid   dpt_deposit.acc%type;
  l_dptlimit   dpt_deposit.limit%type;
  l_dptcur     dpt_deposit.kv%type;
  l_dptrate    int_ratn%rowtype;
  l_operation  int_op.op%type;
  l_baserate   int_ratn.br%type;
  l_indvrate   int_ratn.ir%type;
  l_currrate   int_ratn.ir%type;
  l_vdptt      tts.tt%type;
BEGIN

  bars_audit.trace('%s старт с параметром № %s', l_title, to_char(p_dptid));

  IF request_processing_done (p_dptid) != 'Y' THEN
     -- невозможно рассчитать итоговую льготу: по договору есть необработанные запросы
     bars_error.raise_nerror(g_modcode, 'DPT_BONUS_IN_WORK', to_char(p_dptid));
  END IF;

  IF bonus_fixed (p_dptid) = 'Y' THEN
     bars_audit.trace('%s по договору № %s уже установлена бонусная ставка', l_title, to_char(p_dptid));
     RETURN;
  END IF;

  SELECT nvl(sum(bonus_value_fact),0)
    INTO l_totalbonus
    FROM dpt_bonus_requests
   WHERE dpt_id = p_dptid
     AND request_state = 'ALLOW'
     AND request_deleted = 'N';
  bars_audit.trace('%s суммарная льгота = %s', l_title, to_char(l_totalbonus));

  --IF NVL(l_totalbonus, 0) != 0 THEN
  -- 12/02/2018 закомментировано, т.к. если бонус уменьшился (стал равен 0), это также нужно записать
  
    BEGIN
      SELECT acc, limit, kv
        INTO l_dptaccid, l_dptlimit, l_dptcur
        FROM dpt_deposit
       WHERE deposit_id = p_dptid;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        -- не найден депозитный договор
        bars_error.raise_nerror(g_modcode, 'DPT_NOT_FOUND', to_char(p_dptid));
    END;
    bars_audit.trace('%s внутр.№ деп.счета = %s', l_title, to_char(l_dptaccid));

    BEGIN
      SELECT i.*
        INTO l_dptrate
        FROM int_ratn i
       WHERE i.acc = l_dptaccid
         AND i.id = 1
         AND i.bdat = (SELECT max(r.bdat) FROM int_ratn r
                        WHERE r.acc = i.acc AND r.id = i.id AND r.bdat <= p_bdate);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        -- не найдена базовая %-ная ставка по договору на дату
        bars_error.raise_nerror(g_modcode, 'DPT_RATE_NOT FOUND',
                                to_char(p_dptid), to_char(p_bdate,'DD/MM/YYYY'));
    END;
    bars_audit.trace('%s ставка без бонуса (ir, op, br) = (%s, %s, %s)', l_title,
                     to_char(l_dptrate.ir), to_char(l_dptrate.op), to_char(l_dptrate.br));

    l_currrate := dpt_web.get_dptrate (l_dptaccid, l_dptcur, l_dptlimit, l_dptrate.bdat);
    bars_audit.trace('%s значение текущей ставки по вкладу = %s', l_title, to_char(l_currrate));
    IF nvl(l_dptrate.br, 0) > 0 THEN
       l_indvrate  := l_totalbonus;
       l_operation := 1;                 -- операция сложения (+)
       l_baserate  := l_dptrate.br;
    ELSE
       l_indvrate  := l_currrate + l_totalbonus;
       l_operation := null;
       l_baserate  := null;
    END IF;
    bars_audit.trace('%s ставка с бонусом (ir, op, br) = (%s, %s, %s)', l_title,
                     to_char(l_indvrate), to_char(l_operation), to_char(l_baserate));

    IF l_dptrate.bdat = p_bdate THEN

       bars_audit.trace('%s изменение ставки, установленной %s', l_title, to_char(p_bdate,'DD/MM/YYYY'));

       BEGIN
         UPDATE int_ratn
            SET  br = l_baserate,
                 ir = l_indvrate,
                 op = l_operation
          WHERE acc = l_dptaccid
            AND id = 1
            AND bdat = l_dptrate.bdat;
       EXCEPTION
         WHEN OTHERS THEN
           -- невозможно установить льготную %-ную ставку по договору (размер, дата)
           bars_error.raise_nerror(g_modcode, 'SET_BONUS_RATE_FAILED',
                                   to_char(p_dptid), to_char(l_totalbonus), to_char(p_bdate,'DD/MM/YYYY'));

       END;
       IF SQL%ROWCOUNT = 0 THEN
          -- невозможно установить льготную %-ную ставку по договору (размер, дата)
          bars_error.raise_nerror(g_modcode, 'SET_BONUS_RATE_FAILED',
                                  to_char(p_dptid), to_char(l_totalbonus), to_char(p_bdate,'DD/MM/YYYY'));
       END IF;
       bars_audit.trace('%s изменение ставки выполнено', l_title);

    ELSE
       bars_audit.trace('%s добавление ставки, установленной %s', l_title, to_char(p_bdate,'DD/MM/YYYY'));

       BEGIN
         INSERT INTO int_ratn (acc, id, bdat, ir, br, op)
         VALUES (l_dptaccid, 1, p_bdate, l_indvrate, l_baserate, l_operation);
       EXCEPTION
        when dup_val_on_index then
        UPDATE int_ratn
            SET  br = l_baserate,
                 ir = l_indvrate,
                 op = l_operation
          WHERE acc = l_dptaccid
            AND id = 1
            AND bdat = l_dptrate.bdat;
         WHEN OTHERS THEN
           -- невозможно установить льготную %-ную ставку по договору (размер, дата)
           bars_error.raise_nerror(g_modcode, 'SET_BONUS_RATE_FAILED',
                                   to_char(p_dptid), to_char(l_totalbonus), to_char(p_bdate,'DD/MM/YYYY'));
          
       END;
       bars_audit.trace('%s добавление ставки выполнено', l_title);

    END IF;

 -- ELSE
 --  bars_audit.trace('%s льгот не будет, зафиксируем только доп.реквизит', l_title);
 --   l_totalbonus := 0;
 -- END IF;

  p_bonusval := l_totalbonus;
  begin
  INSERT INTO dpt_depositw (dpt_id, tag, value, branch)
  VALUES (p_dptid, 'BONUS', to_char(l_totalbonus), l_branch);
  exception when dup_val_on_index then
  update dpt_depositw
     set value = to_char(l_totalbonus),
         branch = l_branch
   where tag = 'BONUS' and dpt_id = p_dptid;
  end;
  bars_audit.trace('%s значение бонуса записано в доп.реквизиты вклада', l_title);

  bars_audit.trace('%s выход', l_title);

END set_bonus_rate;
--
--
--
PROCEDURE set_bonus_rate_web
   (p_dptid    IN  dpt_deposit.deposit_id%type,
    p_bdate    IN  fdat.fdat%type,
    p_bonusval OUT ratetype)
IS
  l_title varchar2(60) := 'dpt_bonus(set_bonus_rate_web): ';
BEGIN

  bars_audit.trace('%s договор № %s', l_title, to_char(p_dptid));

  IF request_processing_done (p_dptid) != 'Y' THEN
     bars_audit.trace('%s по договору № %s есть необработанные запросы', l_title, to_char(p_dptid));
     p_bonusval := null;
     RETURN;
  END IF;

  IF bonus_fixed (p_dptid) = 'Y' THEN
     bars_audit.trace('%s по договору № %s уже установлены льготы', l_title, to_char(p_dptid));
     p_bonusval := null;
     RETURN;
  END IF;

  set_bonus_rate (p_dptid, p_bdate, p_bonusval);
  bars_audit.trace('%s по договору № %s установлена льгота в размере %s',
                   l_title, to_char(p_dptid), to_char(p_bonusval));

END set_bonus_rate_web;
--
--
--
PROCEDURE manage_dptviddbonus
  (p_bonusid   IN dpt_vidd_bonuses.bonus_id%type,
   p_typeid    IN dpt_vidd_bonuses.vidd%type,
   p_rang      IN dpt_vidd_bonuses.rec_rang%type,
   p_activity  IN dpt_vidd_bonuses.rec_activity%type,
   p_condition IN dpt_vidd_bonuses.rec_condition%type,
   p_finally   IN dpt_vidd_bonuses.rec_finally%type)
IS
  l_title     varchar2(60) := 'dpt_bonus(manage_dptviddbonus): ';
  l_viddbonus dpt_vidd_bonuses%rowtype;
BEGIN

  bars_audit.trace('%s льгота № %s, вид договора № %s, ранг № %s, акт. = %s',
                   l_title, to_char(p_bonusid), to_char(p_typeid),
                   to_char(p_rang), p_activity);

  BEGIN

    SELECT * INTO l_viddbonus
      FROM dpt_vidd_bonuses
     WHERE vidd = p_typeid AND bonus_id = p_bonusid;

    bars_audit.trace('%s льгота уже привязана к виду договора (ранг %s, акт. %s)',
                     l_title, to_char(l_viddbonus.rec_rang), l_viddbonus.rec_activity);

    IF ( l_viddbonus.rec_rang                != p_rang        OR
         l_viddbonus.rec_finally             != p_finally     OR
         l_viddbonus.rec_activity            != p_activity    OR
         NVL(l_viddbonus.rec_condition, '_') != NVL(p_condition, '_') )
    THEN

      bars_audit.trace('%s изменились условия привязки');

      UPDATE dpt_vidd_bonuses
         SET rec_rang      = p_rang,
             rec_activity  = p_activity,
             rec_condition = p_condition,
             rec_finally   = p_finally
       WHERE     vidd = p_typeid
         AND bonus_id = p_bonusid;
      bars_audit.trace('%s изменения привязки льготы № %s к виду договора № %s зафиксированы в БД',
                       l_title, to_char(p_bonusid), to_char(p_typeid));

    END IF;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      bars_audit.trace('%s льгота еще не привязана к виду договора', l_title);
     INSERT INTO dpt_vidd_bonuses
        (vidd, bonus_id, rec_rang, rec_activity, rec_condition, rec_finally)
     VALUES
        (p_typeid, p_bonusid, p_rang, p_activity, p_condition, p_finally);
     bars_audit.trace('%s выполнена привязка льготы № %s к виду договора № %s (ранг № %s, акт. %s)',
                      l_title, to_char(p_bonusid), to_char(p_typeid), to_char(p_rang), p_activity);
  END;

EXCEPTION
  WHEN OTHERS THEN
    -- ошибка управления привязкой льготы к виду договора
    bars_error.raise_nerror(g_modcode, 'ADD_VIDD2BONUS_FAILED',
                            to_char(p_bonusid), to_char(p_typeid), to_char(p_rang),
                            substr(SQLERRM,1,g_errmsg_dim	));
END manage_dptviddbonus;
--
--
--
FUNCTION header_version RETURN VARCHAR2
IS
BEGIN
  RETURN 'Package header DPT_BONUS '|| chr(10)
      || g_header_version   || chr(10)
      || 'AWK definition: ' || g_awk_header_defs;
END header_version;
--
--
--
FUNCTION body_version RETURN VARCHAR2
IS
BEGIN
  RETURN 'Package body DPT_BONUS '|| chr(10)
      || g_body_version     || chr(10)
      || 'AWK definition: ' || g_awk_body_defs;
END body_version;

END dpt_bonus;
/
show err;

PROMPT *** Create  grants  DPT_BONUS ***
grant EXECUTE                                                                on DPT_BONUS       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DPT_BONUS       to DPT_ADMIN;
grant EXECUTE                                                                on DPT_BONUS       to DPT_ROLE;
grant EXECUTE                                                                on DPT_BONUS       to WR_ALL_RIGHTS;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/package/dpt_bonus.sql =========*** End *** =
PROMPT ===================================================================================== 