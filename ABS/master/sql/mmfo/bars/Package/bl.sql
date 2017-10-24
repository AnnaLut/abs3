
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bl.sql =========*** Run *** ========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BL is
  -------------------------------------------------------------------
  --     Пакет по обслуговуванню Block та Black ліста
  -------------------------------------------------------------------
  G_HEADER_VERSION  constant varchar2(64) := 'version 1.01 21.04.2011';
  G_AWK_HEADER_DEFS constant varchar2(512) := '';
  -------------------------------------------------------------------
  --  BLACK

  /*
    21.04.2011 Nov  Функция function F_SP сделана локальной в данном пакете  ('из CCK_REP version 5.3  26.03.2010';)


  */

  CC_RMS_ number; -- Допустимая сумма просрочки(коп) для отчетов РИСК-МЕНЕДЖМЕНТА
  -------------------------------------------------------------------

  -- Функция вічисления различніх видов просрочек

  -- Mode_=1  Сумма просрочки на ДОГОВОРЕ, попадающая в интервал DN_
  -- Mode_=2  ДОГОВОР  попадающий по прсрочке в интервал DN_
  -- Mode_=3  КОД просрочки (количество (интервал) дней просрочки)
  -- Mode_=4  Сумма просрочки на дату
  -- Mode_=5  реальное колво дней просрочки на дату

  function F_SP(mode_  int, -- что ищем
                DN_    int, -- сколько дней просрочки
                ND_    int, -- реф дог
                p_FDAT date,
                DM_    in char default 'M' --'D' - просрочка <на Дату> 'M' - просрочка <на останнiй день Мiсяця цiєї дати> + ОДИН Рабочий день
                ) return number;


  -- Поиск клиента в Черном Списке по
  -- p_err_code = 1 - ИНН
  -- p_err_code = 2 - ФИО + дата рождения
  -- p_err_code = 3 - серия + номер паспорта
  procedure bl_find(p_inn in bl_person.inn%type, -- Идентификационный налоговый номер

                    p_lname in bl_person.lname%type, -- Фамилия
                    p_fname in bl_person.fname%type, -- Имя
                    p_mname in bl_person.mname%type, -- Отчество
                    p_bdate in bl_person.bdate%type, -- Дата рождения

                    p_pass_ser in bl_passport.pass_ser%type, -- Серия паспорта. Кириллица в верхнем регистре.
                    p_pass_num in bl_passport.pass_num%type, -- Номер паспорта, с ведущими нулями.

                    p_err_code out number, -- Код результата поиска (0 - не найден)
                    p_err_msg  out varchar2 -- Текстовый комментарий поиска
                    );

  procedure CheckBlackList(INN_      BL_PERSON.INN%TYPE,
                           PASS_SER_ BL_PASSPORT.PASS_SER%TYPE,
                           PASS_NUM_ BL_PASSPORT.PASS_NUM%TYPE,
                           LNAME_    BL_PERSON.LNAME%type,
                           FNAME_    BL_PERSON.FNAME%type,
                           MNAME_    BL_PERSON.MNAME%type,
                           LNAME_Alt BL_PERSON.LNAME%type,
                           FNAME_Alt BL_PERSON.FNAME%type,
                           MNAME_Alt BL_PERSON.MNAME%type,
                           BDATE_    BL_PERSON.BDATE%type,
                           ERR_CODE  OUT NUMBER,
                           ERR_MSG   OUT VARCHAR2);

  -- Функція збереження даних особи в чорний список  повертає ідентифікатор з яким було збережена особа.(абоіснуючої особи) .
  function Set_bl_Person(person_id v_bl_person.person_id%type,
                         inn       v_bl_person.inn%type,
                         lname     v_bl_person.lname%type,
                         fname     v_bl_person.fname%type,
                         mname     v_bl_person.mname%type,
                         bdate     v_bl_person.bdate%type,
                         inn_date  v_bl_person.inn_date%type,
                         ins_date  v_bl_person.ins_date%type,
                         user_id   v_bl_person.user_id%type,
                         base_id   v_bl_person.base_id%type) return number;

  -- Функція збереження даних паспорта особи в чорний список  повертає ідентифікатор з яким було збережена особа(або існуючого паспорта) .
  function Set_bl_Passport(passport_id v_bl_passport.passport_id%type,
                           person_id   v_bl_passport.person_id%type,
                           pass_ser    v_bl_passport.pass_ser%type,
                           pass_num    v_bl_passport.pass_num%type,
                           pass_date   v_bl_passport.pass_date%type,
                           pass_office v_bl_passport.pass_office%type,
                           pass_region v_bl_passport.pass_region%type,
                           ins_date    v_bl_passport.ins_date%type,
                           user_id     v_bl_passport.user_id%type,
                           base_id     v_bl_passport.base_id%type)
    return number;

  -- Функція збереження даних причин постановки в чорний список  повертає ідентифікатор причини постановки
  function Set_bl_Reason(reason_id    v_bl_reason.reason_id%type,
                         person_id    v_bl_reason.person_id%type,
                         reason_group v_bl_reason.reason_group%type,
                         base         v_bl_reason.base%type,
                         info_source  v_bl_reason.info_source%type,
                         comment_text v_bl_reason.comment_text%type,
                         ins_date     v_bl_reason.ins_date%type,
                         user_id      v_bl_reason.user_id%type,
                         base_id      v_bl_reason.base_id%type,
                         type_id      v_bl_reason.type_id%type := null,
                         svz_id       v_bl_reason.svz_id%type := null)
    return number;

  -----------------------------------------------------------------------------------------------------------------
  ---   BLOCK LIST
  -----------------------------------------------------------------------------------------------------------------

  -- CheckBlockList - здійснює поіск особи в BLOCK-листі по коду ЭДРПОУ.

  -- INN      - код ЭДРПОУ
  -- повертає
  -- BLK_CODE   - код блокування особи (null - особа відсутня у лісті)
  -- BLK_REPORT - повідомлення для менеджера
  -- BLK_MSG - повідомлення блокування особи
  -- BLK_USER_ID - код користувача який блокував контрагента
  procedure CheckBlockList(INN_        BL_PERSON.INN%TYPE,
                           BLK_CODE    OUT NUMBER,
                           BLK_REPORT  OUT bl_block_dict.report%type,
                           BLK_MSG     OUT bl_block_dict.message%type,
                           BLK_USER_ID OUT NUMBER);

  -------------------------------------------------------------------------------------
  -- Постановка особи в блок лист.
  -- INN         - КОД ЕДРПОУ
  -- BLK         -  КОД БЛОКУВАННЯ
  -- BLK_COMMENT - коментар користувача
  -- SVZ_ID      - ідентифікатор заяви (bid_id)
  -- type_id_     - тип ідентифікатора (SVZ_ID) 0 - bid_id;   1- nd;
  -- обов'язкові поля для заповнення
  --Для type_id_=0  (INN_, BLK_, SVZ_ID_, type_id_ )   (BLK_COMMENT_ - бажано)
  --    Записи з кодом блокування BLK_ які можуть бути перенесені у БЛЕК-ліст обов'язкові усі поля для заповнення
  --Для type_id_=1  (BLK_, SVZ_ID_, type_id_ )  - обовьязкові (INN,ПІБ, паспортні дані будуть ігноруватися)
  procedure SetBlockList(INN_         bl_block.inn%type,
                         BLK_         NUMBER,
                         BLK_COMMENT_ VARCHAR2,
                         SVZ_ID_      NUMBER,
                         type_id_     NUMBER := 0,
                         INN_DATE_    DATE := null,
                         LNAME_       VARCHAR2 := null,
                         FNAME_       VARCHAR2 := null,
                         MNAME_       VARCHAR2 := null,
                         BDATE_       DATE := null,
                         PASS_SER_    VARCHAR2 := null,
                         PASS_NUM_    VARCHAR2 := null,
                         PASS_DATE_   DATE := null,
                         PASS_OFFICE_ VARCHAR2 := null);

  ----- актуализация блок листа
  -- bdat - поточна дата перевірки
  -- typ_check - 0 - стандарний режим (в якому постановку та зняття з блок листа здійснює процедура JOBS4_PB)
  --           - 1  - повний режим (в якому постановку та зняття з блок листа здійснює данною процедурою)

  procedure bl_actualization_day(bdat date := gl.bd, typ_check number := 0);

  -- проверяет на коректность серию паспорта(при ошибке возвращая exception)
  -- а також проводит перевод схожих букв на украинскую раскладку
  function validation_pass_ser(pass_ser_ varchar2) return varchar2;

  -- проверяет на коректность номер паспорта(при ошибке возвращая exception)
  function validation_pass_num(pass_num_ varchar2) return varchar2;

  --------------------------------------------------------
  -- HEADER_VERSION()
  --
  --     Функция возвращает строку с версией заголовка пакета
  --
  function header_version return varchar2;

  --------------------------------------------------------
  -- BODY_VERSION()
  --
  --     Функция возвращает строку с версией тела пакета
  --
  function body_version return varchar2;
end bl;
/
CREATE OR REPLACE PACKAGE BODY BARS.BL is
  -------------------------------------------------------------------
  --
  -------------------------------------------------------------------
  G_BODY_VERSION  constant varchar2(64) := 'version 1.01 21.04.2011';
  G_AWK_BODY_DEFS constant varchar2(512) := '';
  -------------------------------------------------------------------

  -------------------------------------------------------------------

  function F_SP(mode_  int, -- что ищем
                DN_    int, -- сколько дней просрочки
                ND_    int, -- реф дог
                p_FDAT date,
                DM_    char default 'M' -- 'D' - просрочка <на Дату> 'M' - просрочка <на останнiй день Мiсяця цiєї дати> + Рабочий ОДИН день
                ) return number is
    -- Mode_=1  Сумма просрочки на ДОГОВОРЕ, попадающая в интервал DN_
    -- Mode_=2  ДОГОВОР  попадающий по прсрочке в интервал DN_
    -- Mode_=3  КОД просрочки (количество (интервал) дней просрочки)
    -- Mode_=4  Сумма просрочки на дату
    -- Mode_=5  реальное колво дней просрочки на дату

    FDAT_ date := p_FDAT;
    N_    int := 0;
    S_    number := 0;

    -- По уточнению Н.Косьмий:
    --    В качестве просрочки считать суммы  < CC_RMS (гл.параметр =-30.00 грн )
    --    А также возвращать для Mode_=1 всю сумму задолженности по КД
    --  Иначе = 0

    -- Заказ Болтика Если ищём до 30+ то учитываем теническую просрочку, если же 31+ и больше то считам все копейки
    DN_BOLT_ number := 36;

    function IG_DAT_SP(ACC_  NUMBER, -- Счет
                       Fdat_ date -- дата на которую отчет
                       ) RETURN date is
      -- возвращает реальную дату просрочки с учетом частичных погашений, + с учётом ТЕХНИЧЕСКОЙ ПРОСРОЧКИ CC_RMS_
      -- которые гасили "самую старую" просрочку
      KOS_ number; --сколько всего погашено до отчетной даты
    begin
      -- Сумма всех списаний (сколько уплачено)
      select Nvl(sum(kos), 0)
        into kos_
        from saldoa
       where acc = ACC_
         and fdat <= FDAT_;
      --ловим непогашенн?й интервал
      For k in (select fdat, dos
                  from saldoa
                 where acc = ACC_
                   and fdat <= FDAT_
                   and dos > 0
                 order by fdat) loop
        KOS_ := KOS_ - k.DOS;
        -- если долг перевысил техническую просрочку CC_RMS_
        If KOS_ < CC_RMS_ then
          return k.FDAT;
        end if;
      end loop;
      RETURN to_date(null);
    end IG_DAT_SP;

  begin

    If DM_ = 'M' then
      select Nvl(min(fdat), last_day(p_FDAT))
        into FDAT_
        from fdat
       where fdat > last_day(p_FDAT);
    end if;

    for k in (select n.acc, a.accc
                from nd_acc n, accounts a
               where n.nd = ND_
                 and n.acc = a.acc
                 and a.tip in ('SP ', 'SL ')) loop
      S_ := fost(k.acc, FDAT_); -- Сумма не сплаченного долга

      -- Игумнов
      If S_ < 0 then
        --    If S_ < CC_RMS_ then

        If Mode_ = 4 then
          if (S_ > CC_RMS_) and (FDAT_ - DAT_SP(k.acc, FDAT_)) < DN_BOLT_ then
            return 0;
          else
            return S_;
          end if;
        end if;
        -- Игумнов     Было:    select FDAT_ - Nvl(max(fdat),FDAT_-1) into N_
        --                  from saldoa where acc=k.ACC and fdat<=FDAT_ and ostf>= CC_RMS_;
        -- а стало:
        -- Игумнов   select FDAT_ - DAT_SP(k.acc,FDAT_) into N_ from dual;
        if ((S_ > CC_RMS_) and (FDAT_ - DAT_SP(k.acc, FDAT_)) < DN_BOLT_) then
          N_ := FDAT_ - IG_DAT_SP(k.acc, FDAT_);
        else
          N_ := FDAT_ - DAT_SP(k.acc, FDAT_);
        end if;

        If mode_ = 5 then
          RETURN N_;
        end if;

        If Mode_ = 3 then
          If n_ > 180 then
            return 181;
          end if;
          If n_ > 120 then
            return 121;
          end if;
          If n_ > 90 then
            return 91;
          end if;
          If n_ > 60 then
            return 61;
          end if;
          If n_ > 30 then
            return 31;
          end if;
          If n_ > 0 then
            return 1;
          end if;
          return 0;
        end if;

        If n_ > DN_ then
          -- все, попался
          If MODE_ = 2 then
            RETURN 1;
          elsIf Mode_ = 1 then
            RETURN fost(k.accC, FDAT_);
          else
            return 0;
          end if;
        end if;
      end if;
    end loop;

    return 0;

  end F_SP;

  -------------------------------------------------------------------------------------------------------------------

  -- Поиск клиента в Черном Списке по
  -- p_err_code = 1 - ИНН
  -- p_err_code = 2 - ФИО + дата рождения
  -- p_err_code = 3 - серия + номер паспорта
  procedure bl_find(p_inn in bl_person.inn%type, -- Идентификационный налоговый номер

                    p_lname in bl_person.lname%type, -- Фамилия
                    p_fname in bl_person.fname%type, -- Имя
                    p_mname in bl_person.mname%type, -- Отчество
                    p_bdate in bl_person.bdate%type, -- Дата рождения

                    p_pass_ser in bl_passport.pass_ser%type, -- Серия паспорта. Кириллица в верхнем регистре.
                    p_pass_num in bl_passport.pass_num%type, -- Номер паспорта, с ведущими нулями.

                    p_err_code out number, -- Код результата поиска (0 - не найден)
                    p_err_msg  out varchar2 -- Текстовый комментарий поиска
                    ) is
  begin
    p_err_code := 0;
    p_err_msg  := null;

    case
      when p_inn is not null then
        -- ИНН
        begin
          select 1,
                 'ІПН - ' || p_inn || ' знайдено у ЧС з причиною: ' ||
                 brd.reason
            into p_err_code, p_err_msg
            from bl_person bp, bl_reason br, bl_reason_dict brd
           where bp.inn = p_inn
             and bp.person_id = br.person_id
             and br.reason_group = brd.reason_group
             and rownum = 1;
        exception
          when no_data_found then
            null;
        end;
      when p_lname is not null and p_fname is not null and
           p_mname is not null and p_bdate is not null then
        -- ФИО + дата рождения
        begin
          select 2,
                 'ПІБ - ' || p_lname || ' ' || p_fname || ' ' || p_mname ||
                 ', ДН - ' || to_char(p_bdate, 'dd.mm.yyyy') ||
                 ' знайдено у ЧС з причиною: ' || brd.reason
            into p_err_code, p_err_msg
            from bl_person bp, bl_reason br, bl_reason_dict brd
           where bp.lname = upper(trim(p_lname))
             and bp.fname = upper(trim(p_fname))
             and bp.mname = upper(trim(p_mname))
             and bp.bdate = trunc(p_bdate)
             and bp.person_id = br.person_id
             and br.reason_group = brd.reason_group
             and rownum = 1;
        exception
          when no_data_found then
            null;
        end;
      when p_pass_ser is not null and p_pass_num is not null then
        -- серия + номер паспорта
        begin
          select 3,
                 'Паспорт ' || p_pass_ser || p_pass_num ||
                 ' знайдено у ЧС з причиною: ' || brd.reason
            into p_err_code, p_err_msg
            from bl_passport bp, bl_reason br, bl_reason_dict brd
           where bp.pass_ser = upper(trim(p_pass_ser))
             and bp.pass_num = upper(trim(p_pass_num))
             and bp.person_id = br.person_id
             and br.reason_group = brd.reason_group
             and rownum = 1;
        exception
          when no_data_found then
            null;
        end;
      else
        p_err_code := 0;
        p_err_msg  := null;
    end case;
  end bl_find;

  procedure CheckBlackList(INN_      BL_PERSON.INN%TYPE,
                           PASS_SER_ BL_PASSPORT.PASS_SER%TYPE,
                           PASS_NUM_ BL_PASSPORT.PASS_NUM%TYPE,
                           LNAME_    BL_PERSON.LNAME%type,
                           FNAME_    BL_PERSON.FNAME%type,
                           MNAME_    BL_PERSON.MNAME%type,
                           LNAME_Alt BL_PERSON.LNAME%type,
                           FNAME_Alt BL_PERSON.FNAME%type,
                           MNAME_Alt BL_PERSON.MNAME%type,
                           BDATE_    BL_PERSON.BDATE%type,
                           ERR_CODE  OUT NUMBER,
                           ERR_MSG   OUT VARCHAR2) is
    SER_ BL_PASSPORT.PASS_SER%TYPE;
    NUM_ BL_PASSPORT.PASS_NUM%TYPE;

  begin

    err_code := 0;
    err_msg  := null;
    -- Проверяем заполненсть и корректность предоставленных данных
    if LNAME_ is null then
      bars_error.raise_nerror('BL', 'BL_PRFM_NULL', INN_);
    end if;

    if FNAME_ is null then
      bars_error.raise_nerror('BL', 'BL_PRIM_NULL', INN_);
    end if;
    if BDATE_ is null then
      bars_error.raise_nerror('BL', 'BL_BDATE_NULL', INN_);
    end if;

    if INN_ is not null and BDATE_ is not null then
      if nvl(v_okpo10(INN_, BDATE_), '0') != INN_ or length(INN_) <> 10 then
        bars_error.raise_nerror('BL',
                                'BL_BAD_OKPO',
                                LNAME_,
                                FNAME_,
                                MNAME_,
                                INN_);
      end if;
    end if;

    SER_ := validation_pass_ser(PASS_SER_);
    NUM_ := validation_pass_num(PASS_NUM_);

    --  проводим проверку на утерянность паспорта
    select count(*)
      into err_code
      from bl_lost_pass
     where pass_ser = SER_
       and pass_num = NUM_;

    if err_code > 0 then
      err_code := 1;
      return;
    else
      err_code := 0;
    end if;

    --  проводим проверку на  паспорта
    for i in (select reason_group, ins_date, comment_text
                from bl_reason
               where person_id in (select person_id
                                     from bl_passport
                                    where pass_ser = SER_
                                      and pass_num = NUM_
                                   union
                                   select person_id
                                     from bl_person
                                    where lname = upper(trim(LNAME_))
                                      and fname = upper(trim(FNAME_))
                                      and mname = upper(trim(MNAME_))
                                      and bdate = BDATE_
                                   union
                                   select person_id
                                     from bl_person
                                    where lname = upper(trim(LNAME_ALT))
                                      and fname = upper(trim(FNAME_ALT))
                                      and mname = upper(trim(MNAME_ALT))
                                      and bdate = BDATE_)) loop
      err_code := 2;
      if length(err_msg) > 0 then
        err_msg := err_msg || chr(10) || chr(13);
      end if;
      err_msg := err_msg || to_char(i.reason_group) || ';' ||
                 to_char(i.ins_date, 'dd.mm.yyyy') || i.comment_text;
    end loop;

    return;

  end CheckBlackList;

  function Set_bl_Person(person_id v_bl_person.person_id%type,
                         inn       v_bl_person.inn%type,
                         lname     v_bl_person.lname%type,
                         fname     v_bl_person.fname%type,
                         mname     v_bl_person.mname%type,
                         bdate     v_bl_person.bdate%type,
                         inn_date  v_bl_person.inn_date%type,
                         ins_date  v_bl_person.ins_date%type,
                         user_id   v_bl_person.user_id%type,
                         base_id   v_bl_person.base_id%type) return number is

    NEW_  V_BL_PERSON%rowtype;
    pers_ boolean;

  begin

    pers_ := false;

    NEW_.PERSON_ID := PERSON_ID;
    NEW_.INN       := INN;
    NEW_.LNAME     := upper(trim(LNAME));
    NEW_.FNAME     := upper(trim(FNAME));
    NEW_.MNAME     := upper(trim(MNAME));
    NEW_.BDATE     := BDATE;
    NEW_.INN_DATE  := INN_DATE;
    NEW_.BASE_ID   := nvl(BASE_ID, 0);
    NEW_.USER_ID   := user_id;
    --   NEW_.:=:NEW.;

    if NEW_.BASE_ID = 0 then
      if NEW_.PERSON_ID is null then
        -- сначало попытаемя найти данного человека
        begin
          select person_id
            into NEW_.PERSON_ID
            from BL_PERSON
           where LNAME = NEW_.LNAME
             and FNAME = NEW_.FNAME
             and MNAME = NEW_.MNAME
             and bdate = NEW_.BDATE
             and inn = NEW_.INN
             and NEW_.base_id = 0
             and rownum = 1;
          pers_ := true;
        EXCEPTION
          WHEN no_data_found THEN
            -- не нашли создаем нового
            select s_person_id.nextval into NEW_.PERSON_ID from dual;
            pers_ := false;
        end;
      end if;
    else
      if NEW_.PERSON_ID is null then
        bars_error.raise_nerror('BL', 'BL_ERROR_OUT_PRIMARY_KEY', '');
      end if;
    end if;

    -- мы еще не знаем есть ли строка с данным идентификатором в базе (пытаемся вставлять)
    if pers_ = false then
      begin
        Insert into BL_PERSON
          (PERSON_ID, INN, LNAME, FNAME, MNAME, BDATE, INN_DATE, BASE_ID, USER_ID)
        Values
          (NEW_.PERSON_ID,
           NEW_.INN,
           NEW_.LNAME,
           NEW_.FNAME,
           NEW_.MNAME,
           NEW_.BDATE,
           NEW_.INN_DATE,
           NEW_.BASE_ID,
           NEW_.USER_ID);
      EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
          -- обратить внимание что именно PERSON_ID
          if NEW_.BASE_ID = 0 and PERSON_ID is null then
            bars_error.raise_nerror('BL',
                                    'BL_ERROR_SEQUENCE',
                                    'PERSON_ID=',
                                    to_char(NEW_.PERSON_ID));
          else
            pers_ := true;
          end if;
      end;
    end if;

    if pers_ = true then
      update BL_PERSON
         set INN      = NEW_.INN,
             LNAME    = NEW_.LNAME,
             FNAME    = NEW_.FNAME,
             MNAME    = NEW_.MNAME,
             BDATE    = NEW_.BDATE,
             INN_DATE = NEW_.INN_DATE,
             USER_ID = NEW_.USER_ID
       where PERSON_ID = NEW_.PERSON_ID
         and BASE_ID = NEW_.BASE_ID
         and (nvl(INN, 0) != nvl(NEW_.INN, 0) or
             nvl(LNAME, '0') != nvl(NEW_.LNAME, '0') or
             nvl(FNAME, '0') != nvl(NEW_.FNAME, '0') or
             nvl(MNAME, '0') != nvl(NEW_.MNAME, '0') or
             nvl(BDATE, gl.bd) != nvl(NEW_.BDATE, gl.bd) or
             nvl(INN_DATE, gl.bd) != nvl(NEW_.INN_DATE, gl.bd) or
             USER_ID != NEW_.USER_ID);
    end if;

    return NEW_.PERSON_ID;
  end;

  function Set_bl_Passport(passport_id v_bl_passport.passport_id%type,
                           person_id   v_bl_passport.person_id%type,
                           pass_ser    v_bl_passport.pass_ser%type,
                           pass_num    v_bl_passport.pass_num%type,
                           pass_date   v_bl_passport.pass_date%type,
                           pass_office v_bl_passport.pass_office%type,
                           pass_region v_bl_passport.pass_region%type,
                           ins_date    v_bl_passport.ins_date%type,
                           user_id     v_bl_passport.user_id%type,
                           base_id     v_bl_passport.base_id%type)
    return number is

    NEW_      V_BL_PASSPORT%rowtype;
    passport_ boolean;

  begin

    if PERSON_ID is null then
      bars_error.raise_nerror('BL', 'BL_ERROR_PRIMARY_KEY', 'особи');
    end if;

    passport_        := false;
    NEW_.PERSON_ID   := PERSON_ID;
    NEW_.PASSPORT_ID := PASSPORT_ID;
    NEW_.PASS_SER    := bl.validation_pass_ser(PASS_SER);
    NEW_.PASS_NUM    := bl.validation_pass_num(PASS_NUM);
    NEW_.PASS_DATE   := PASS_DATE;
    NEW_.PASS_OFFICE := PASS_OFFICE;
    NEW_.PASS_REGION := PASS_REGION;
    NEW_.BASE_ID     := nvl(BASE_ID, 0);

    if NEW_.BASE_ID = 0 then
      if NEW_.PASSPORT_ID is null then
        -- сначало попытаемя найти данный паспорт
        begin
          select p.passport_id
            into NEW_.PASSPORT_ID
            from BL_PASSPORT p
           where p.person_id = NEW_.PERSON_ID
             and p.pass_ser = NEW_.PASS_SER
             and p.pass_num = NEW_.PASS_NUM
             and NEW_.base_id = 0
             and rownum = 1;
          passport_ := true;
        EXCEPTION
          WHEN no_data_found THEN
            -- не нашли создаем новый
            select s_PASSPORT_id.nextval into NEW_.PASSPORT_ID from dual;
            passport_ := false;
        end;
      end if;
    else
      if NEW_.PASSPORT_ID is null then
        bars_error.raise_nerror('BL', 'BL_ERROR_OUT_PRIMARY_KEY', '');
      end if;

    end if;

    -- мы еще не знаем есть ли строка с данным идентификатором в базе (пытаемся вставлять)
    if passport_ = false then
      begin
        Insert into BL_PASSPORT
          (PASSPORT_ID,
           PERSON_ID,
           PASS_SER,
           PASS_NUM,
           PASS_DATE,
           PASS_OFFICE,
           PASS_REGION,
           BASE_ID)
        Values
          (NEW_.PASSPORT_ID,
           NEW_.PERSON_ID,
           NEW_.PASS_SER,
           NEW_.PASS_NUM,
           NEW_.PASS_DATE,
           NEW_.PASS_OFFICE,
           NEW_.PASS_REGION,
           NEW_.BASE_ID);
      EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
          -- обратить внимание что именно PERSON_ID
          if NEW_.BASE_ID = 0 and PERSON_ID is null then
            bars_error.raise_nerror('BL',
                                    'BL_ERROR_SEQUENCE',
                                    'PERSON_ID=',
                                    to_char(NEW_.PERSON_ID));
          else
            passport_ := true;
          end if;
      end;
    end if;
    if passport_ = true then
      update BL_PASSPORT
         set PERSON_ID   = NEW_.PERSON_ID,
             PASS_SER    = NEW_.PASS_SER,
             PASS_NUM    = NEW_.PASS_NUM,
             PASS_DATE   = NEW_.PASS_DATE,
             PASS_OFFICE = NEW_.PASS_OFFICE,
             PASS_REGION = NEW_.PASS_REGION
       where PASSPORT_ID = NEW_.PASSPORT_ID
         and BASE_ID = NEW_.BASE_ID
         and (nvl(PERSON_ID, 0) != nvl(NEW_.PERSON_ID, 0) or
             nvl(PASS_SER, '0') != nvl(NEW_.PASS_SER, '0') or
             nvl(PASS_NUM, 0) != nvl(NEW_.PASS_NUM, 0) or
             nvl(PASS_DATE, gl.bd) != nvl(NEW_.PASS_DATE, gl.bd) or
             nvl(PASS_OFFICE, '0') != nvl(NEW_.PASS_OFFICE, '0') or
             nvl(PASS_REGION, '0') != nvl(NEW_.PASS_REGION, '0'));
    end if;
    return NEW_.PASSPORT_ID;
  end;

  function Set_bl_Reason(reason_id    v_bl_reason.reason_id%type,
                         person_id    v_bl_reason.person_id%type,
                         reason_group v_bl_reason.reason_group%type,
                         base         v_bl_reason.base%type,
                         info_source  v_bl_reason.info_source%type,
                         comment_text v_bl_reason.comment_text%type,
                         ins_date     v_bl_reason.ins_date%type,
                         user_id      v_bl_reason.user_id%type,
                         base_id      v_bl_reason.base_id%type,
                         type_id      v_bl_reason.type_id%type := null,
                         svz_id       v_bl_reason.svz_id%type := null)
    return number is

    NEW_ V_BL_REASON%rowtype;
    --reason_ boolean;

  begin
    if PERSON_ID is null then
      bars_error.raise_nerror('BL', 'BL_ERROR_PRIMARY_KEY', 'PERSON_ID=');
    end if;

    NEW_.PERSON_ID    := PERSON_ID;
    NEW_.REASON_ID    := REASON_ID;
    NEW_.REASON_GROUP := REASON_GROUP;
    NEW_.BASE         := upper(trim(BASE));
    NEW_.INFO_SOURCE  := upper(trim(INFO_SOURCE));
    NEW_.COMMENT_TEXT := COMMENT_TEXT;
    NEW_.BASE_ID      := nvl(BASE_ID, 0);
    NEW_.TYPE_ID      := TYPE_ID;
    NEW_.SVZ_ID       := SVZ_ID;

    if NEW_.BASE_ID = 0 then

      if NEW_.REASON_ID is null then
        select s_REASON_id.nextval into NEW_.REASON_ID from dual;
      end if;
    end if;

    begin
      Insert into BL_REASON
        (REASON_ID,
         PERSON_ID,
         REASON_GROUP,
         BASE,
         INFO_SOURCE,
         COMMENT_TEXT,
         BASE_ID,
         TYPE_ID,
         SVZ_ID)
      Values
        (NEW_.REASON_ID,
         NEW_.PERSON_ID,
         NEW_.REASON_GROUP,
         NEW_.BASE,
         NEW_.INFO_SOURCE,
         NEW_.COMMENT_TEXT,
         NEW_.BASE_ID,
         NEW_.TYPE_ID,
         NEW_.SVZ_ID)
      returning reason_id into new_.reason_id;

    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN

        if NEW_.BASE_ID = 0 and REASON_ID is null and sqlcode = -1 then
          bars_error.raise_nerror('BL',
                                  'BL_ERROR_SEQUENCE',
                                  'PERSON_ID=',
                                  to_char(NEW_.PERSON_ID));
        end if;
        -- исключает обнуление идентификаторов связи type_id  svz_id
        update BL_REASON
           set PERSON_ID    = NEW_.PERSON_ID,
               REASON_GROUP = NEW_.REASON_GROUP,
               BASE         = NEW_.BASE,
               INFO_SOURCE  = NEW_.INFO_SOURCE,
               COMMENT_TEXT = NEW_.COMMENT_TEXT,
               TYPE_ID      = nvl(NEW_.TYPE_ID, TYPE_ID),
               SVZ_ID       = NVL(NEW_.SVZ_ID, SVZ_ID)
         where REASON_ID = NEW_.REASON_ID
           and BASE_ID = NEW_.BASE_ID
           and (nvl(PERSON_ID, 0) != nvl(NEW_.PERSON_ID, 0) or
               nvl(REASON_GROUP, '0') != nvl(NEW_.REASON_GROUP, '0') or
               nvl(BASE, 0) != nvl(NEW_.BASE, 0) or
               nvl(INFO_SOURCE, gl.bd) != nvl(NEW_.INFO_SOURCE, gl.bd) or
               nvl(COMMENT_TEXT, '0') != nvl(NEW_.COMMENT_TEXT, '0') or
               nvl(TYPE_ID, '-121') != nvl(NEW_.TYPE_ID, TYPE_ID) or
               nvl(SVZ_ID, '0') != NVL(NEW_.SVZ_ID, SVZ_ID))
        returning reason_id into new_.reason_id;

    end;
    return NEW_.REASON_ID;
  end;

  --------------------------------------------------------------------------------------------------------------------
  -------------------------------    BLOCK LIST   --------------------------------------------------------------------
  --------------------------------------------------------------------------------------------------------------------
  procedure CheckBlockList(INN_        BL_PERSON.INN%TYPE,
                           BLK_CODE    OUT NUMBER,
                           BLK_REPORT  OUT bl_block_dict.report%type,
                           BLK_MSG     OUT bl_block_dict.message%type,
                           BLK_USER_ID OUT NUMBER) is

  begin

    --     if nvl(v_okpo10(INN_,BDATE_),'0')!= INN_ or length(INN_)<>10 then
    --      bars_error.raise_nerror('BL','BL_BAD_OKPO',LNAME_,FNAME_,MNAME_,INN_);
    --     end if;

    select b.blk, bd.report, bd.message, user_id
      into BLK_CODE, BLK_REPORT, BLK_MSG, BLK_USER_ID
      from bl_block b, bl_block_dict bd
     where b.inn = INN_
       and b.blk = bd.blk(+)
       and (b.blk != 100 or user_id != gl.aUID)
       and rownum = 1

     order by sign_bl desc, sign desc, count_day desc;

  exception
    when no_data_found then
      BLK_CODE := null;

  end;

  procedure SetBlockList(INN_         bl_block.inn%type,
                         BLK_         NUMBER,
                         BLK_COMMENT_ VARCHAR2,
                         SVZ_ID_      NUMBER,
                         type_id_     NUMBER := 0,
                         INN_DATE_    DATE := null,
                         LNAME_       VARCHAR2 := null,
                         FNAME_       VARCHAR2 := null,
                         MNAME_       VARCHAR2 := null,
                         BDATE_       DATE := null,
                         PASS_SER_    VARCHAR2 := null,
                         PASS_NUM_    VARCHAR2 := null,
                         PASS_DATE_   DATE := null,
                         PASS_OFFICE_ VARCHAR2 := null) is
    block_      bl_block_dict%rowtype;
    prs         bl_block%rowtype;
    err         varchar2(1000);
    Id_Pers     number;
    count_black number;
  begin
    err := null;
    -- 1 перевіряемо наявність та читаемо хак-ки коду блокування
    begin
      select * into block_ from bl_block_dict where blk = BLK_;

      -- блокуємо  повторну постановку в блок лист записів внесених до Чорного списку.
      -- (тількі просрочені кредити)
      if block_.sign_bl = 1 and svz_id_ is not null and
         type_id_ is not null then
        select count(*)
          into count_black
          from bl_reason b
         where b.type_id = type_id_
           and b.svz_id = svz_id_
           and b.reason_group = block_.reason_group;

        if count_black > 0 then
          return;
        end if;

      end if;

    exception
      when no_data_found then
        bars_error.raise_nerror('BL', 'BL_BAD_BLK', to_char(BLK_));
    end;
    -- 2 далі працюємо тількі зі змінною  prs
    prs.inn         := inn_;
    prs.inn_date    := inn_date_;
    prs.lname       := lname_;
    prs.fname       := fname_;
    prs.mname       := mname_;
    prs.bdate       := bdate_;
    prs.pass_ser    := pass_ser_;
    prs.pass_num    := pass_num_;
    prs.pass_date   := pass_date_;
    prs.pass_office := pass_office_;
    prs.svz_id      := svz_id_;
    prs.type_id     := type_id_;
    prs.blk_comment := blk_comment_;
    prs.blk         := blk_;

    -- для видів блокування КД додаємо інформацію о кліенті з таблиць "Реєстрації кліентів і рахунків"
    if prs.type_id = 1 and prs.svz_id is not null then

      select to_number(c.okpo),
             nvl(c.datet, to_date('01012000', 'ddmmyyyy')),
             fio(c.nmk, 1),
             fio(c.nmk, 2),
             fio(c.nmk, 3),
             p.BDAY,
             p.PASSP,
             p.NUMDOC,
             p.PDATE,
             p.ORGAN
        into prs.inn,
             prs.inn_date,
             prs.lname,
             prs.fname,
             prs.mname,
             prs.bdate,
             prs.pass_ser,
             prs.pass_num,
             prs.pass_date,
             prs.pass_office
        from cc_deal cd, customer c, person p
       where cd.rnk = c.rnk
         and cd.rnk = p.rnk
         and cd.nd = prs.svz_id;

    end if;

    -- Перевірка заповнення усіх необхідних даних
    -- для видів блокування які йдуть без постановки в чорний список
    if block_.sign_bl = 0 then

      if prs.INN is null or prs.BLK is null or prs.SVZ_ID is null or
         prs.type_id is null then
        --raise_application_error(-20100,decode(inn_date,null,'inn_date' ))
        select decode(prs.INN,
                      null,
                      'Ідентифікаційний податковий номер, ',
                      null) ||
               decode(prs.BLK, null, 'Код блокування, ', null) ||
               decode(prs.SVZ_ID,
                      null,
                      'Ідентифікатор анкети , ',
                      null) ||
               decode(prs.type_id, null, 'тип зв''язку, ', null)
          into err
          from dual;
      end if;
    else
      -- для видів блокування які можуть бути  поставлені в чорний список
      if prs.BLK is null or prs.SVZ_ID is null or prs.type_id is null or
         prs.INN_DATE is null or prs.LNAME is null or prs.FNAME is null or
         prs.BDATE is null or prs.PASS_SER is null or prs.PASS_NUM is null or
         prs.PASS_DATE is null or prs.PASS_OFFICE is null then
        select decode(prs.BLK, null, 'Код блокування, ', null) ||
               decode(prs.SVZ_ID,
                      null,
                      'Ідентифікатор анкети , ',
                      null) ||
               decode(prs.type_id, null, 'тип зв''язку, ', null) ||
               decode(prs.INN_DATE,
                      null,
                      'Дата видачі ідентифікаційного номеру, ',
                      null) ||
               decode(prs.LNAME, null, 'Прізвище, ', null) ||
               decode(prs.FNAME, null, 'Ім''я, ', null) ||
               decode(prs.BDATE,
                      null,
                      'Дата народження, ',
                      null) || decode(prs.PASS_SER,
                                      null,
                                      'Серія паспорта, ',
                                      null) ||
               decode(prs.PASS_NUM,
                      null,
                      'Номер паспорта, ',
                      null) || decode(prs.PASS_DATE,
                                      null,
                                      'Дата видачі паспорта, ',
                                      null) ||
               decode(prs.PASS_OFFICE,
                      null,
                      'Ким виданий паспорт, ',
                      null)
          into err
          from dual;
      end if;
    end if;

    if err is not null then
      bars_error.raise_nerror('BL',
                              'BL_NULL_FIELDS',
                              substr(err, 1, length(err) - 2));
    end if;

    -- намагаємося знайти блокіровку на цю особу
    begin
      select id
        into Id_Pers
        from bl_block b
       where -- b.inn=prs.INN
      --     and nvl(b.inn_date,gl.bd)=nvl(INN_DATE_,gl.bd)
      --     and nvl(b.lname,'0')    =nvl(LNAME_,'0')
      --     and nvl(b.fname,'0')    =nvl(FNAME_,'0')
      --     and nvl(b.mname,'0')    =nvl(mNAME_,'0')
      --     and nvl(b.bdate,gl.bd)  =nvl(bdate_,gl.bd)
      --     and nvl(b.pass_ser,'0') =nvl(PASS_SER_,'0')
      --     and nvl(b.pass_num,'0')   =nvl(PASS_NUM_ ,'0')
      --     and nvl(b.pass_date,gl.bd) =nvl(PASS_DATE_,gl.bd)
      --     and nvl(b.pass_office,'0')=nvl(PASS_OFFICE_,'0')
       b.svz_id = prs.SVZ_ID
       and b.type_id = prs.TYPE_ID
      --     and nvl(b.blk_comment,'0')=nvl(BLK_COMMENT_,'0')
       and b.blk = prs.BLK
      -- and trunc(b.blk_date)=trunc(sysdate)
       and b.user_id = gl.aUID
       and rownum = 1;
    exception
      when no_data_found then
        err := null;

        Insert into BL_BLOCK
          (ID,
           INN,
           INN_DATE,
           LNAME,
           FNAME,
           MNAME,
           BDATE,
           PASS_SER,
           PASS_NUM,
           PASS_DATE,
           PASS_OFFICE,
           SVZ_ID,
           TYPE_ID,
           BLK_COMMENT,
           BLK,
           BLK_DATE,
           USER_ID)
        Values
          (null,
           prs.INN,
           prs.INN_DATE,
           prs.LNAME,
           prs.FNAME,
           prs.MNAME,
           prs.BDATE,
           prs.PASS_SER,
           prs.PASS_NUM,
           prs.PASS_DATE,
           prs.PASS_OFFICE,
           prs.SVZ_ID,
           prs.TYPE_ID,
           prs.BLK_COMMENT,
           prs.BLK,
           sysdate,
           gl.aUID);

    end;

    --  змінюємо не первинні данні
    -- для видів блокування без постановлки в чорний список дата оновлюється, для ---//-- ні

    update bl_block b
       set b.inn         = prs.inn,
           b.INN_DATE    = decode(block_.sign_bl,
                                  1,
                                  prs.INN_DATE,
                                  b.INN_DATE),
           b.LNAME       = prs.LNAME,
           b.FNAME       = prs.FNAME,
           b.MNAME       = prs.MNAME,
           b.BDATE       = prs.BDATE,
           b.PASS_SER    = prs.PASS_SER,
           b.PASS_NUM    = prs.PASS_NUM,
           b.PASS_DATE   = prs.PASS_DATE,
           b.PASS_OFFICE = prs.PASS_OFFICE,
           b.BLK_COMMENT = prs.BLK_COMMENT,
           b.BLK_DATE    = decode(block_.sign_bl, 1, b.BLK_DATE, sysdate)
     where id = Id_Pers
       and (b.inn != decode(block_.sign_bl, 1, prs.inn, inn) or
           nvl(b.inn_date, trunc(sysdate)) !=
           nvl(INN_DATE_, trunc(sysdate)) or
           nvl(b.lname, '0') != nvl(LNAME_, '0') or
           nvl(b.fname, '0') != nvl(FNAME_, '0') or
           nvl(b.mname, '0') != nvl(mNAME_, '0') or
           nvl(b.bdate, gl.bd) != nvl(bdate_, gl.bd) or
           nvl(b.pass_ser, '0') != nvl(PASS_SER_, '0') or
           nvl(b.pass_num, '0') != nvl(PASS_NUM_, '0') or
           nvl(b.pass_date, gl.bd) != nvl(PASS_DATE_, gl.bd) or
           nvl(b.pass_office, '0') != nvl(PASS_OFFICE_, '0') or
           nvl(b.blk_comment, '0') != nvl(BLK_COMMENT_, '0') or
           trunc(b.blk_date) !=
           decode(block_.sign_bl, 1, BLK_DATE, sysdate));

  end;

  procedure bl_actualization_day(bdat date := gl.bd, typ_check number := 0) is

    CC_RMS_ number;
    id_pers bl_person.person_id%type;
    tmpN    bl_passport.passport_id%type;
    NAZN_   Varchar2(1000);

  begin

    CC_RMS_ := nvl(to_number(GetGlobalOption('CC_RMS')), 0);
    -- 1 видаляємо всі некритичні рядки блокування в яких вийшов строк

    delete from bl_block
     where id in (select id
                    from bl_block b, bl_block_dict d
                   where b.BLK = d.BLK
                     and BDAT - d.count_day > trunc(b.blk_date)
                     and d.sign_bl = 0);

    -- 2 видаляємо всі колишні прострочені договори з БЛОСК ЛИСТ-а
    -- та    переносимо в BLACK LIST  необхідні записи
    for i in (select b.*, d.REASON_GROUP, d.author
                from bl_block b, bl_block_dict d
               where b.BLK = d.BLK
                 and BDAT - d.count_day > trunc(b.blk_date)
                 and d.sign_bl = 1) loop
      -- 2.1 усі заявки
      if i.type_id = 0 then
        Savepoint a1;
        begin
          id_pers := bl.SET_bl_PERSON(null,
                                      i.inn,
                                      i.lname,
                                      i.fname,
                                      i.mname,
                                      i.bdate,
                                      i.inn_date,
                                      null,
                                      i.user_id,
                                      0);
          tmpN    := bl.SET_bl_PASSPORT(null,
                                        id_pers,
                                        i.pass_ser,
                                        i.pass_num,
                                        i.pass_date,
                                        i.pass_office,
                                        null,
                                        null,
                                        i.user_id,
                                        0);
          tmpN    := bl.SET_bl_REASON(null,
                                      id_pers,
                                      i.reason_group,
                                      '1',
                                      to_char(i.svz_id),
                                      i.blk_comment,
                                      null,
                                      i.user_id,
                                      0,
                                      i.type_id,
                                      i.svz_id);
          delete bl_block where id = i.id;
        exception
          when others then
            bars_audit.ERROR('BL-0 ' || SQLERRM);
            Rollback to a1;
        end;
      end if;
      -- 2.2 усі просрочені кредити
      if i.type_id = 1 then
        -- про всякий випадок повторно перевіряємо кіл-ть днів прострочення перед перенесенням у BLACK LIST
        if F_SP(5, null, i.SVZ_ID, bdat) >= 90 then
          SavePoint A2;
          begin
            id_pers := bl.SET_bl_PERSON(null,
                                        i.inn,
                                        i.lname,
                                        i.fname,
                                        i.mname,
                                        i.bdate,
                                        i.inn_date,
                                        null,
                                        i.user_id,
                                        0);
            tmpN    := bl.SET_bl_PASSPORT(null,
                                          id_pers,
                                          i.pass_ser,
                                          i.pass_num,
                                          i.pass_date,
                                          i.pass_office,
                                          null,
                                          null,
                                          i.user_id,
                                          0);
            tmpN    := bl.SET_bl_REASON(null,
                                        id_pers,
                                        i.reason_group,
                                        '1',
                                        to_char(i.svz_id),
                                        i.blk_comment,
                                        null,
                                        i.user_id,
                                        0,
                                        i.type_id,
                                        i.svz_id);
            delete bl_block where id = i.id;
          exception
            when others then
              bars_audit.ERROR('BL-0 ' || SQLERRM);
              Rollback to a2;
          end;
        end if;
      end if;

      if i.type_id not in (0, 1) then
        bars_audit.ERROR('BL-0 ' ||
                         'Знайден невідоий тип ідентифікатора в блок листе при перенесенні особи в "Чорний список"');
      end if;

    end loop;

    if typ_check = 0 then
      return;
    end if;

    -- 3. видаляаємо всі записи з блок листа в яких зникла просрочка
    delete bl_block
     where type_id = 1
       and svz_id in
           (select svz_id
              from bl_block
             where type_id = 1
               and nvl(F_SP(5, null, SVZ_ID, bdat), 0) = 0);

    -- відбираємо всі всі  договора з прострочками та проставляемо їх в БЛОСК ЛИСТ
    for i in (select cd.cc_id,
                     cd.nd,
                     cd.sdate,
                     c.rnk,
                     c.nmk,
                     c.okpo,
                     p.BDAY,
                     p.PASSP,
                     p.numdoc,
                     p.pdate,
                     p.organ,
                     c.datet
                from cc_deal cd, customer c, person p
               where cd.rnk = c.rnk
                 and cd.rnk = p.rnk
                 and cd.sos < 15
                 and cd.sos >= 10
                 and F_SP(5, null, cd.nd, bdat) > 0) loop
      SavePoint A10;
      begin
        NAZN_ := 'Договор № ' || i.CC_ID || ' вiд ' ||
                 to_char(i.sdate, 'dd/mm/yyyy') ||
                 ' перенесенo на просрочку';
        --SetBlocklist(i.okpo,381,' tekst ',i.nd,1,i.datet,fio(i.nmk,1),
        --fio(i.nmk,2),fio(i.nmk,3),i.BDAY,i.PASSP,i.numdoc,i.pdate,i.organ);
        SetBlocklist(null, 381, NAZN_, i.nd, 1);
      exception
        when others then
          bars_audit.ERROR('BL-0 ' || SQLERRM);
          Rollback to a10;
      end;

    end loop;

  end;

  -- перевірка на коректність серії паспорта (при помилці повертаючи exceptіon)
  -- а також проводит перевод схожих букв на украинскую раскладку
  function validation_pass_ser(pass_ser_ varchar2) return varchar2 is
    ser_ varchar2(10);
  begin

    SER_ := trim(upper(PASS_SER_));
    if SER_ is null or
       SER_ <> translate(SER_, '1234567890`~!@#$%^&*()-=+/\?;:''"|', ' ') or
       length(SER_) != 2 then
      bars_error.raise_error('BL', 12, SQLERRM);
    else
      SER_ := translate(SER_, 'ABEKMHOPCTXI_', 'АВЕКМНОРСТХІІ');

    end if;

    return SER_;
  end;

  -- проверяет на коректность номер паспорта(при ошибке возвращая exception)
  function validation_pass_num(pass_num_ varchar2) return varchar2 is
    num_ varchar2(6);
  begin

    NUM_ := trim(PASS_NUM_);
    if NUM_ is null or
       translate(NUM_, '1234567890*', '********** ') != '******' then
      bars_error.raise_error('BL', 13, SQLERRM);
    end if;

    return num_;
  end;
  ---------------------------------------------------------------------
  ---------------------------------------------------------------------

  -----------------------------------------------------------------
  -- HEADER_VERSION()
  --
  --     Функция возвращает строку с версией заголовка пакета
  --
  function header_version return varchar2 is
  begin
    return 'package header BL ' || G_HEADER_VERSION || chr(10) || 'package header definition(s):' || chr(10) || G_AWK_HEADER_DEFS;
  end header_version;

  -----------------------------------------------------------------
  -- BODY_VERSION()
  --
  --     Функция возвращает строку с версией тела пакета
  --
  function body_version return varchar2 is
  begin
    return 'package body BL ' || G_BODY_VERSION || chr(10) || 'package body definition(s):' || chr(10) || G_AWK_BODY_DEFS;
  end body_version;

end bl;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bl.sql =========*** End *** ========
 PROMPT ===================================================================================== 
 