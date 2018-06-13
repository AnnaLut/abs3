
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/cck_new.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CCK_NEW is

  G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'version 1 13-06-2018';


  tobo_ varchar2(12);     -- Кто регистрирует
  CC_TOBO_ char(1) :='0'; -- 0 инициатор ГБ; 1- инициатор ТОБО
  SUMO_CF number; -- расчетная сумма аннуитетного платежа
  G_CC_KOM_ int;  -- Многоразовая ком по банку

  FL38_ASP int; --Флаг оплаты для операции  "ASP"
  SPN_BRI_ int; -- Базовая ставка пени;

  CC_KVSD8 char(1); -- 1=счет пени открывать в вал КД, иначе в нац.вал.
  CC_DAYNP number;  -- Переносить день погашения на 0 - пятницу 1 - понед
  CC_SLSTP number;  -- При відкр рах SL призупиняти нарах-ня (0) чи продовжувати нарах - 1
  G_CCK_MIGR number;  -- 1- включен режим миграции
  ern CONSTANT POSITIVE := 203;  erm VARCHAR2(250);  err EXCEPTION;

  PROCEDURE cc_gpk_msg(nd_ INT);

  -- новая проц построения ГПК
  PROCEDURE cc_gpk
  (
    mode_  INT,
    nd_    INT,
    ds_pog  NUMBER,
    flag   INT DEFAULT 0
  );


  PROCEDURE cc_gpk_ann
  ( nd_    INT,
    acc_   INT,
    Pl_    NUMBER,
    T_     INT,
    S_     NUMBER,
    Ostf   NUMBER,
    P_ir   NUMBER,
    nday_  NUMBER,
    d_sdate DATE,
    d_wdate DATE,
    d_apl_dat DATE,
    basey_ INT,
    dog_st INT,
    flag   INT DEFAULT 0
  );


  PROCEDURE cc_gpk_classic
  (
    nd_    INT,
    acc_   INT,
    Pl_    NUMBER,
    T_     INT,
    S_     NUMBER,
    Ostf   NUMBER,
    P_ir   NUMBER,
    nday_  NUMBER,
    d_sdate DATE,
    d_wdate DATE,
    d_apl_dat DATE,
    basey_ INT,
    flag_r INT,
    day_np INT,
    dog_st INT,
    freq   INT,
    flag   INT DEFAULT 0
  );

  PROCEDURE cc_gpk_freq
   (
    nd_    INT,
    acc_   INT,
    Pl_    NUMBER,
    T_     INT,
    S_     NUMBER,
    Ostf   NUMBER,
    P_ir   NUMBER,
    nday_  NUMBER,
    d_sdate DATE,
    d_wdate DATE,
    d_apl_dat DATE,
    basey_ INT,
    flag_r INT,
    day_np INT,
    dog_st INT,
    freq   INT,
    flag   INT DEFAULT 0
  );

  FUNCTION plan_rep_gpk(nd_ INT, d_rep DATE) return varchar2;
  FUNCTION prepayment_gpk(nd_ INT, d_rep DATE) return varchar2;
  FUNCTION billing_date(dd_n INT, d_rep DATE) RETURN DATE;
  FUNCTION CorrectDay( p_KV int, p_OldDate date, p_Direct number:=1) RETURN DATE;

  function header_version return varchar2;
  function body_version return varchar2;

end CCK_NEW;


/
CREATE OR REPLACE PACKAGE BODY BARS.CCK_NEW is

 G_BODY_VERSION  CONSTANT VARCHAR2(64)  := 'ver.1  25/05/2018 ';

 G_REPORTS number:=0;  -- (1) - включить режим выполнения для отчета
 -- старая проц построения ГПК

 -- Створити Проект ГПК  для початкових умов
 --  cck.cc_gpk(:GPK,
 --              pul.Get_Mas_Ini_Val ('ND'),
 --              null,null,null,null,null,null,null ,
 --              :TYPE,1)
 -- :GPK(SEM=Спосіб розбивки,TYPE=N,REF=CC_V_GPK),
 -- :TYPE(SEM=Спосіб заокруглення,TYPE=N,REF=VW_GPK_ROUND_TYPE)
 --18006440001
  PROCEDURE cc_gpk_msg(nd_ INT) IS
    d_vidd     int;
    a_acc      number;
    a_vid      int;
    ia_basey   int;
    r_bdat     date;
    r_ir       number;
    err        int;
    txt        varchar2(1000);
    tt         varchar2(10);
    ts         varchar2(100);
  BEGIN
    tt:='
';
    err:=0;
    BEGIN
      select cd.vidd,
             a.acc,
             a.vid,            -- код вида счета
             ia.basey          -- метод начисления %
        into d_vidd, a_acc, a_vid, ia_basey
        from cc_deal cd,
             nd_acc na,
             accounts a,
             int_accn ia,
             freq q,
             basey b
       where cd.nd = nd_
         and cd.nd = na.nd
         and na.acc = a.acc
         and a.tip = 'LIM'
         and ia.acc = a.acc
         and ia.id = 0
         and b.basey = ia.basey
         and q.freq = ia.freq;

      select r.bdat, r.ir  -- дата установки, индивидуальная % ставка
        into r_bdat, r_ir
        from INT_RATN r
       where acc = a_acc
         and id = 0
         and rownum=1
       order by bdat asc;
    EXCEPTION
       WHEN no_data_found THEN
         err:=err+1;
         raise_application_error(-20001, 'ГПК КД (' || nd_ || ' ) не заведені основні параметри договору для побудови ГПК!');
       WHEN OTHERS THEN
         err:=err+1;
         --DBMS_OUTPUT.PUT_LINE(err);
         raise_application_error(-20002, 'ГПК КД (' || nd_ || ' ) помилка визначення основних параметрів договору для побудови ГПК! '||SQLERRM );
    END;
    txt:='';
    ts:=null;
    if err=0 then  --20000
      txt:= 'Відсоткова ставка: '||r_ir||tt;
      if nvl(ia_basey, -1) not in(0,1,2,3) then
        err:=err+1;
        raise_application_error(-20003, 'ГПК КД (' || nd_ || ' ) помилка визначення методу нарахування % для побудови ГПК!');
      else
        select decode(ia_basey, '0', 'Г% Факт/Факт  ACT/ACT',
                              '1', 'Г% Факт/365  AFI/365',
                              '2', 'Г% SIA 30/360  SIA 30/360',
                              '3', 'Г% Факт/360  ACT/360')
          into ts
          from dual;
          txt:=txt||'Метод нарахування: '||ts||tt;
          ts:=null;
      end if;

      select decode(a_vid, '1', 'Погашення тіла кредиту рівними сумами',
                           '2', 'Погашення тіла кредиту в кінці терміну',
                           '3', 'Погашенння кредиту рівними долями з %% ( ануїтет )')
         into ts
         from dual;
         txt:=txt||'          Вид ГПК: '||ts||tt;
         ts:=null;

    end if;
    DBMS_OUTPUT.PUT_LINE(txt);
    -- может еще чего написать?
  END;


  PROCEDURE cc_gpk(mode_  INT, --способ разбивки 1-тело равными суммами; 2-тело в конце срока; 3- ануитет
                   nd_    INT,
                   ds_pog  NUMBER, -- 1-явная досрочка, 0-нет досрочки, просто пересчет графика
                   flag   INT DEFAULT 0) IS  --0 - платеж не меняем, 1- дату не меняем
    d_vidd     int;
    d_sdate    date;
    d_wdate    date;
    d_sdog     number;
    a_acc      number;
    a_vid      int;
    a_ostb     number;
    a_ostc     number;
    ia_apl_dat date;
    ia_basem   int;
    ia_basey   int;
    ia_s       int;
    ia_freq    int;
    r_bdat     date;
    r_ir       number;
    flag_s     CHAR(2);
    flag_r     int;
    flag_p     int;
    day_np     int;
    day_sn     int;
    dat_sn     date;
    date_plan  date;
    date_v     date;
    date_os    date;
    date_n     date;
    date_ch    TIMESTAMP;
    dog_st     int;     -- 0-новый; 1-действующий;
    s_ostf     number;
    s_pog      number;
    n          number DEFAULT 0; -- переменная для промежуточных расчетов, не забывать чистить
    dd_n       date;  -- переменная для промежуточных расчетов, типа даты
    T          int;
    is_Pog     int;
    s_Plan     number;
    is_GPK     int DEFAULT 0;  -- определяем способ пересчета, с уменьшениес срока 0 или нет 1
    err        int;


    S          number;
    Pl         number;
    d_start    date;
    flag_d     int;


  BEGIN
    /* bars_audit.info('CC_GPK.MODE_=' || mode_ || ', ND_=' || nd_ ||
    ' ,ACC_=' || acc_ || ' ,BDAT_1=' || bdat_1 ||
    ' ,DATN_=' || datn_ || ' ,DAT4_=' || dat4_ ||
    ' ,SUM1_=' || sum1_ || ' ,FREQ_=' || l_freq_ ||
    ',DIG_=' || dig_);*/
    --nd_:= 19166342701;--7362901; --9229101;  --7362901; --19169861311;  --19169861611; --7362901; --19169979711; аннуитет
    --nd_:= 19166177701; --19167325701; --19169621301; --19161938401;  -- классика
    --dig_:=0;
    is_Pog:=0;
    s_Plan:=0;
    err:=0;
    -- запрашиваем параметры, действующие на текущую дату
      BEGIN
        select cd.vidd,
               cd.sdate,         -- Дата заключения договора
               cd.wdate,         -- Дата завершения
               cd.sdog,          -- сумма по договору
               a.acc,
               a.vid,            -- код вида счета
              -a.ostb,           -- плановый остаток
              -a.ostc,           -- фактический остаток
               ia.apl_dat,       -- дата последней выплаты(первая платежная дата)
               ia.basem,         -- 0 - Календарный (28-31 дней); 1 - Банковский (30)
               ia.basey,         -- метод начисления %
               ia.s,             -- день оплаты
               ia.freq           -- периодичность оплаты
          into d_vidd, d_sdate, d_wdate, d_sdog, a_acc, a_vid, a_ostb, a_ostc, ia_apl_dat, ia_basem, ia_basey, ia_s, ia_freq
          from cc_deal cd,
               nd_acc na,
               accounts a,
               int_accn ia,
               freq q,
               basey b
         where cd.nd = nd_
           and cd.nd = na.nd
           and na.acc = a.acc
           and a.tip = 'LIM'
           and ia.acc = a.acc
           and ia.id = 0
           and b.basey = ia.basey
           and q.freq = ia.freq;

       select r.bdat, r.ir  -- дата установки, индивидуальная % ставка
         into r_bdat, r_ir
         from INT_RATN r
        where acc = a_acc
          and id = 0
          and rownum=1
        order by bdat asc;
      EXCEPTION
         WHEN no_data_found THEN
           err:=err+1;
           raise_application_error(-20001, 'ГПК КД (' || nd_ || ' ) не заведені основні параметри договору для побудови ГПК!');
         WHEN OTHERS THEN
           err:=err+1;
           --DBMS_OUTPUT.PUT_LINE(err);
           raise_application_error(-20002, 'ГПК КД (' || nd_ || ' ) помилка визначення основних параметрів договору для побудови ГПК! '||SQLERRM );
      END;

      -- проверяем параметры договора
      if err=0 then  --20000
        -- метод начисления %
          --0 Г% Факт/Факт  ACT/ACT
          --1 Г% Факт/365  AFI/365
          --2 Г% SIA 30/360  SIA 30/360
          --3 Г% Факт/360  ACT/360
        if nvl(ia_basey, -1) not in(0,1,2,3) then
          err:=err+1;
          raise_application_error(-20003, 'ГПК КД (' || nd_ || ' ) помилка визначення методу нарахування % для побудови ГПК!');
        end if;

        -- Временно для поддержки старых расчетов
        if ia_basey=2 then a_vid:=4; end if;
        ------------------------------------------

        -- Спосіб заокруглення - вх. параметр dig_
          -- 0  0.Коп 1123.45
          -- 1  1.10 "Коп" 1123.50
          -- 2  2.100 "Коп" 1124.00

        -- тип графіку - вх. параметр mode_, сейчас берем с переменной a_vid
          --  1.Погашення тіла кредиту рівними сумами
          --  2.Погашення тіла кредиту в кінці терміну
          --  3.Погашенння кредиту рівними долями з %% ( ануїтет )

        if d_sdate is null then
          err:=err+1;
          raise_application_error(-20004, 'ГПК КД (' || nd_ || ' ) помилка визначення дати початку договору!');
        end if;

        if nvl(ia_s, 0) = 0 then
          err:=err+1;
          raise_application_error(-20005, 'ГПК КД (' || nd_ || ' ) помилка визначення дня платіжної дати основного боргу для побудови ГПК!');
        end if;

        if ia_apl_dat is null then
          err:=err+1;
          raise_application_error(-20006, 'ГПК КД (' || nd_ || ' ) помилка визначення платіжної дати основного боргу для побудови ГПК!');
        end if;

        -- Періодичність сплати основного боргу, відсотків
        if nvl(ia_freq,0) not in(360,180, 120, 40, 30, 12, 7, 5 ) then
          err:=err+1;
          raise_application_error(-20007, 'ГПК КД (' || nd_ || ' ) періодичність сплати має не припустиме значення!');
          if a_vid=4 and nvl(ia_freq,0)<>5 then
            raise_application_error(-20007, 'ГПК КД (' || nd_ || ' ) періодичність сплати для ануїтету не є Щомісячна!');
          end if;
        end if;

        -- Сумма по договору
        if nvl(d_sdog,0) = 0 then
          err:=err+1;
          raise_application_error(-20008, 'ГПК КД (' || nd_ || ' ) не визначена сума договору!');
        end if;

        -- Відсоткова ставка
        if nvl(r_ir, 0) = 0 then
          err:=err+1;
          raise_application_error(-20009, 'ГПК КД (' || nd_ || ' ) помилка визначення відсоткової ставки для побудови ГПК!');
        end if;

        dat_sn:=null; day_sn:=null;
        flag_s := cck_app.get_nd_txt(nd_, 'FLAGS');                         -- Проценти с каникулами, без каникул
        day_np := cck_app.to_number2(cck_app.get_nd_txt(nd_, 'DAYNP'));     -- Тип врегулювання дня погашення
        day_sn := cck_app.to_number2(cck_app.get_nd_txt(nd_, 'DAYSN'));     -- День погашения процентов
        dat_sn := to_date(cck_app.get_nd_txt(nd_, 'DATSN'), 'dd.mm.yyyy');  -- Дата первого погашения процентов

        if day_np is null then
          day_np:=-2;  --без корректировки, 0-следующий, 1-предыдущий
        end if;

        if flag_s is null then
          flag_r:=1;  --% 1=месяц, 0=день
          flag_p:=0;  --каникулы не используем
        else
          if flag_s in('00','01','02','10','11','12','90','91') then
            flag_r:=to_number(substr(flag_s,2,1));
            flag_p:=to_number(substr(flag_s,1,1));
          else
            flag_r:=1;
            flag_p:=0;
          end if;
        end if;

        --if a_vid=4 and flag_r=0 then
        --  raise_application_error(-20009, 'ГПК КД (' || nd_ || ' ) для ануїтету значення ''За попередній'' для погашення відсотків, повинно дорівнювати ''Місяць''!');
        --end if;

        --if a_vid=4 and day_np<>-2 then
        --  raise_application_error(-20009, 'ГПК КД (' || nd_ || ' ) для ануїтету значення ''Тип врегулювання дня погашення'' для погашення основного боргу, повинно дорівнювати ''Без кориктування''!');
        --end if;

        if dat_sn is null then
          dat_sn:=ia_apl_dat; --уплата процентов и основного долга совпадают
          day_sn:=ia_s;
        else
          if day_sn is null then
            err:=err+1;
            raise_application_error(-20005, 'ГПК КД (' || nd_ || ' ) помилка визначення дня платіжної дати відсотків для побудови ГПК!');
          end if;
        end if;
      end if;
      ------------------------------
      dog_st:=0;
      is_Pog:=0;
      if err=0 then
        -- ищем погашения по кредиту, последнее движение по счету SS
        date_os:=null;
        begin
          select max(s.FDAT)
            into date_os
            from nd_acc n, accounts a, SALDOA s
           where n.ND = nd_
             and a.acc= n.acc
             and a.tip = 'SS'
             and s.acc=a.acc
             and s.kos<>0;
        EXCEPTION
          WHEN no_data_found THEN
            date_os:= null;
        end;

        if date_os is not null then
          select -(s.ostf+s.kos)/100, -s.ostf/100
            into s_pog, s_ostf                          --фактический и входящий остаток по кредиту без просрочки
            from nd_acc n, accounts a, SALDOA s
           where n.ND = nd_
             and a.acc= n.acc
             and a.tip = 'SS'
             and s.acc=a.acc
             and s.kos<>0
             and s.FDAT = date_os;

          -- нашли погашения, определяем новую плановую дату с которй можно пересчитывать график
          date_v:=billing_date(ia_s, date_os);  --to_date(ia_s||substr (to_char(date_os, 'dd.mm.rrrr'), 3, 8),'dd.mm.rrrr' );
          dog_st:=1; -- уже не новый график, но как будем пересчитывать пока неизвестно
        else
          date_v:=d_sdate;
          dog_st:=0; -- новый график
          s_pog:=d_sdog;
          s_ostf:=d_sdog;
        end if;

        --DBMS_OUTPUT.PUT_LINE('date_v1='||to_char(date_v, 'dd.mm.yyyy'));

        -- анализируем уплату процентов, на случай отложенной уплаты основного долга
        if dat_sn < ia_apl_dat then -- даты уплаты % и основного длга не совпадают, ищем операции по уплате %
          date_os:=null;            -- на всякий случай проверяем дату операции по уплате процентов
          begin
            select max(s.FDAT)
              into date_os
              from nd_acc n, accounts a, SALDOA s
             where n.ND = nd_
               and a.acc= n.acc
               and a.tip = 'SN'
               and s.acc=a.acc
               and s.kos<>0;
          EXCEPTION
            WHEN no_data_found THEN
              date_os:= null;
          end;

          --DBMS_OUTPUT.PUT_LINE('date_os2='||to_char(date_os, 'dd.mm.yyyy'));

          -- усли окажется, что дата последней операции по уплате % больше даты посл операции по уплате долга, то
          -- сдвигаем дату с которой можно пересчитывать график до даты операции по %

          if date_os is not null and (date_os>date_v or dog_st=0) then
            date_v:=billing_date(ia_s, date_os);
            dog_st:=1; -- уже не новый график, но как будем пересчитывать пока неизвестно
            --DBMS_OUTPUT.PUT_LINE('date_v3='||to_char(date_v, 'dd.mm.yyyy'));
          end if;
        end if;

        --DBMS_OUTPUT.PUT_LINE('date_v2='||to_char(date_v, 'dd.mm.yyyy'));

        -- определяем количество оставшихся плановых периодов по договору, бз учета фактических операций
        T:=0;
        BEGIN
          select months_between(trunc(d_wdate, 'month'), trunc(date_v, 'month') )
            into T
            from dual;
          --DBMS_OUTPUT.PUT_LINE(T);
        EXCEPTION
          WHEN OTHERS THEN
            T:=0;
        END;

        -- проверяем наличие расчета в CC_LIM
        n:=0;
        select count(acc)
          into n
          from cc_lim
         where acc=a_acc;

        -- это для отладки -----------
        if n>0 then  -- есть расчет в CC_LIM
          --raise_application_error( err, 'ГПК КД (' || nd_ || ' ) ГПК вже розраховано, для перебудови ГПК необхідно видалити записи після останнього погашення!');
          DBMS_OUTPUT.PUT_LINE('ГПК вже розраховано, для перебудови ГПК необхідно видалити записи після останнього погашення!');
        end if;
        -----------------------------------------------

        if n>0 and dog_st=1 then --есть какието записи в cc_lim и график действующий, были операцмм
          n:=0;
          dd_n:=null;
          -- пытаемся определить сумму планового платежа
          select max(fdat)
           into dd_n
           from cc_lim
          where acc=a_acc;

          if a_vid = 4 then
            select sumo/100
             into s_Plan  --сумма планового платежа
             from cc_lim
            where acc=a_acc
              and fdat>=ADD_MONTHS(dd_n,-2)
              and fdat<dd_n
              and rownum = 1;
          else
             select sumg/100
             into s_Plan  --сумма планового платежа
             from cc_lim
            where acc=a_acc
              and fdat>=ADD_MONTHS(dd_n,-2)
              and fdat<dd_n
              and rownum = 1;
          end if;
          --DBMS_OUTPUT.PUT_LINE('s_Plan='||s_Plan);
          --DBMS_OUTPUT.PUT_LINE('dd_n='||to_char(dd_n, 'dd.mm.yyyy'));
        end if;
      end if;

      /*    if date_ch is not null and date_n >=trunc(sysdate) then --есть % ставка с большей датой начала действия
            if n<>r_ir then --% ставка отличается от текущей
              -- тут нужно сообщение с вопросом или передать управление другому окну
              is_Pog:=1;
              date_v:=billing_date(ia_s, date_n);
              r_ir:=n;
              dog_st:=1;
              --будем пересчитывать график для новой % ставки с даты действия, остальной график не трогаем
              --сейчас смотрим только на ближыйшую новую % ставку
            end if;
          end if; */
          ------------------------------
/*
      -- Все что может понадобиться для расчета
      --DBMS_OUTPUT.PUT_LINE('d_vidd='|| d_vidd);
      --DBMS_OUTPUT.PUT_LINE('d_sdate='||to_char(d_sdate,'dd.mm.yyyy'));
      DBMS_OUTPUT.PUT_LINE('date_plan='||to_char(date_plan,'dd.mm.yyyy'));
      DBMS_OUTPUT.PUT_LINE('date_v='||to_char(date_v,'dd.mm.yyyy'));
      DBMS_OUTPUT.PUT_LINE('d_wdate='||to_char(d_wdate,'dd.mm.yyyy'));
      DBMS_OUTPUT.PUT_LINE('s_Plan='||s_Plan);
      DBMS_OUTPUT.PUT_LINE('d_sdog='||d_sdog);
      DBMS_OUTPUT.PUT_LINE('a_acc='||a_acc);
      DBMS_OUTPUT.PUT_LINE('a_vid='||a_vid);
      --DBMS_OUTPUT.PUT_LINE('a_ostb='||a_ostb);
      --DBMS_OUTPUT.PUT_LINE('a_ostc='||a_ostc);
      DBMS_OUTPUT.PUT_LINE('ia_apl_dat='||to_char(ia_apl_dat,'dd.mm.yyyy'));
      --DBMS_OUTPUT.PUT_LINE('ia_basem='||ia_basem);
      --DBMS_OUTPUT.PUT_LINE('ia_basey='||ia_basey);
      --DBMS_OUTPUT.PUT_LINE('ia_s='||ia_s);
      --DBMS_OUTPUT.PUT_LINE('ia_freq='||ia_freq);
      --DBMS_OUTPUT.PUT_LINE('r_ir='||r_ir);
      --DBMS_OUTPUT.PUT_LINE('r_bdat='||to_char(r_bdat,'dd.mm.yyyy'));
      --DBMS_OUTPUT.PUT_LINE('s_ostf='||s_ostf);
      DBMS_OUTPUT.PUT_LINE('T='||T);
      DBMS_OUTPUT.PUT_LINE('n='||n);
      DBMS_OUTPUT.PUT_LINE('dog_st='||dog_st);
      --DBMS_OUTPUT.PUT_LINE('is_Pog='||is_Pog);

      DBMS_OUTPUT.PUT_LINE(' Расет - пересчет графика!!!!');
      DBMS_OUTPUT.PUT_LINE('                   ');
*/
      -- пересчета график в зависимости от типа графика и расчитанных условий
        --ia_basey; -- метод мначисления
        --r_ir;  -- % ставка
        --ia_s;  -- день уплаты
        --d_wdate;
        --a_acc;
        --day_np;
        --T;  --количество периодов
      if a_vid = 4 then --аннуитет
        Pl:=s_Plan;
        if dog_st=0 then -- погашений не было, новый график
          S:=d_sdog;
          d_start:=d_sdate;
        else  -- погашения были
          S:=s_pog;  -- всегда берем сумму остатка
          d_start:=date_v;
        end if;
        cc_gpk_ann(nd_,
                   a_acc,
                   Pl,
                   T,
                   S,
                   s_ostf,
                   r_ir,
                   ia_s,
                   d_start,
                   d_wdate,
                   ia_apl_dat,
                   ia_basey,
                   dog_st,
                   flag);
      end if;

      if a_vid = 2 then --классика
        if dog_st=0 then -- погашений не было, новый график
          S:=d_sdog;
          d_start:=d_sdate;
          Pl:=0;
        else  -- погашения были
          --DBMS_OUTPUT.PUT_LINE('ПОПАЛ  s_pog='||s_pog||';  s_Plan='||s_Plan);
          S:=s_pog;  -- всегда берем сумму остатка
          d_start:=date_v;
          Pl:=s_Plan;
        end if;
--day_np:=1;
        if ia_freq=5 then
          cc_gpk_classic(nd_,
                        a_acc,
                        Pl,
                        T,
                        S,
                        s_ostf,
                        r_ir,
                        ia_s,
                        d_start,
                        d_wdate,
                        ia_apl_dat,
                        ia_basey,
                        flag_r,
                        day_np,
                        dog_st,
                        ia_freq,
                        flag);
        else
          cc_gpk_freq(nd_,
                        a_acc,
                        Pl,
                        T,
                        S,
                        s_ostf,
                        r_ir,
                        ia_s,
                        d_start,
                        d_wdate,
                        ia_apl_dat,
                        ia_basey,
                        flag_r,
                        day_np,
                        dog_st,
                        ia_freq,
                        flag);
        end if;
      end if;

  END cc_gpk;

  PROCEDURE cc_gpk_ann(
                   nd_    INT,         --договор
                   acc_   INT,         --счет 8999
                   Pl_    NUMBER,      --месячный платеж
                   T_     INT,         --количество периодов
                   S_     NUMBER,      --сумма кредита
                   Ostf   NUMBER,      --входящий остаток по кредиту без просрочки
                   P_ir   NUMBER,      --% ставка
                   nday_    NUMBER,      --день оплаты осн долга
                   d_sdate DATE,       --дата начала
                   d_wdate DATE,       --дата окончания
                   d_apl_dat DATE,     --первая платежная дата осн долг
                   basey_ INT,         --метод начисления %
                   dog_st INT,         -- 0- новый гафик, 1 - старый график
                   flag   INT DEFAULT 0--0 - платеж не меняем, 1- дату не меняем
                   ) IS

    Pl       number;
    T        int;
    P        number;
    txt      varchar2(1000);
    S        number;

    P_ratn    number;      -- годовая процентная ставка
    s_b       number;      -- погашение основного долга
    s_s       number;      -- остаток по кредиту до погашения
    s_Ostf    number;      -- остаток за предыдущий период до даты погащения
    s_m       number;      -- остаток по кредиту после погашения
    s_i       number;      -- погашение процентов
    date_plan date;        -- дата погашения текущая
    date_fact date;        -- дата погашения предыдущая
    date_pog  date;        -- дата погашения
    n_day     int;         -- количество дней в периоде
    n_yy      int;         -- количество дней в году
    bm int;                -- метод начисления
    Dp  int;               -- день погащения
    s1  number;            -- промежуточный расчет
    d_start date;          -- дата выдачи, план
    d_end   date;          -- дата возврата, план
    last_d  date;          -- последний день месяца
--    flag_d int;            -- флаг для досрочного погашения; 0-новый график; 1-была досрочка, сумму аннуитета не меняем, уменьшаем срок; 2-была досрочка, сумму аннуитета пересчитываем, дату последнего погашения не меняем
    acc_n  int;
    n      number DEFAULT 0; -- переменная для промежуточных расчетов, не забывать чистить
    P_ratn_old number;
    d_rate date;

  BEGIN

  ------------------------------------
  -- процедура для аннуитета, с выше определенными входными параметрами
  ------------------------------------

  -- расчет суммы аннуитета
  Pl:=Pl_;
  T:=T_;
  S:=S_;
  P:=P_ir;
  bm:=basey_; -- метод мначисления
  Dp:=nday_;  -- день уплаты
  d_start:=d_sdate;
  d_end:=d_wdate;
  acc_n:=acc_;

  if dog_st=0 and nvl(Pl,0)=0 then
                                     -- новый график, плановый платеж неизвестен
    s1:= P/(12*100);
--    DBMS_OUTPUT.PUT_LINE('S='||S||'  s1='||s1);
    Pl:= S*s1/( 1-POWER( (1+s1), -T) );
    Pl:=ROUND(Pl,2);
    --Pl:=ROUND(Pl,0);
    --Pl:=ceil(Pl*100)/100;
    --date_plan:=d_start;
    --DBMS_OUTPUT.PUT_LINE('Pl=!!'||Pl||'  T='||T);
    --DBMS_OUTPUT.PUT_LINE('----------------');
  else
    if flag=1 then -- дату последнего погашения не меняем
      -- расчитываем новое количество периодов
      BEGIN
        select months_between(trunc(d_end, 'month'), trunc(d_sdate, 'month') )
          into T
         from dual;
      EXCEPTION
        WHEN OTHERS THEN
        T:=0;
      END;

      if T>0 then
        s1:= P/(12*100);
        --DBMS_OUTPUT.PUT_LINE(s1);
        Pl:= S*s1/( 1-POWER( (1+s1), -T) );
      else
        Pl:=0;
      end if;
      Pl:=ROUND(Pl,2);
      --Pl:=ceil(Pl*100)/100;
      
    end if;

  end if;

  date_plan:=billing_date(Dp, d_start);
  --select  billing_date(Dp, d_start)
  --  into date_plan
  --  from dual;

  ------------------- первую строку не удаляем
  BEGIN
    delete from cc_lim
     where nd=nd_
       and acc=acc_
       and fdat>d_start;
    commit;
  EXCEPTION
        WHEN OTHERS THEN
    rollback;
    raise_application_error(-20203, 'Помилка видалення ГПК!'||sqlerrm);
  END;
  -------------------
--DBMS_OUTPUT.PUT_LINE('T=!!'||T);
--DBMS_OUTPUT.PUT_LINE('Pl=!!'||Pl);

  P_ratn:=P;
  n:=1;
  s_s:=S; -- остаток по кредиту до погашения
  s_Ostf:=S;


  WHILE n<=T LOOP
    txt:=null;

    if n=1 then
      date_fact := d_start;
    else
      date_fact := date_plan;
    end if;

    P_ratn_old:=0;

    if n>1 then
      P_ratn_old:=P_ratn;

      select max(r.bdat)
        into d_rate
        from INT_RATN r
       where acc = acc_
         and id = 0
         and r.bdat <= date_plan;

      select r.ir
        into P_ratn
       from INT_RATN r
      where acc = acc_
        and id = 0
        and r.bdat = d_rate;


      if P_ratn_old<>P_ratn then
        --расчитываем новое количество периодов
        --затем расчитываем новый аннуитет
        BEGIN
          select months_between(trunc(d_end, 'month'), trunc(date_plan, 'month') )
            into T
           from dual;
        EXCEPTION
          WHEN OTHERS THEN
          T:=0;
        END;

        if T>0 then
          s1:= P_ratn/(12*100);
          --DBMS_OUTPUT.PUT_LINE(s1);
          Pl:= S*s1/( 1-POWER( (1+s1), -T) );
        else
          Pl:=0;
        end if;
        Pl:=ROUND(Pl,2);
        --Pl:=ceil(Pl*100)/100;
        --DBMS_OUTPUT.PUT_LINE(Pl);

      end if;
    end if;

    if nvl(bm, 0) = 0 then bm:=1; end if;

    select add_months(trunc(date_plan,'yyyy'),12)-trunc(date_plan,'yyyy') into n_yy from dual;
    s_i:=0; s_b:=0; s_m:=0;

    select LAST_DAY( date_fact ) into last_d from dual;
    if n=1 then
      select last_d-date_fact into n_day from dual;
      n_day:=n_day+1;
    else
      select date_plan-trunc(date_fact, 'month') into n_day from dual;  -- плановая дата минус первое числа
    end if;

    if bm=0 then --------------------------------------------------------------------

      s_i:=s_i+ROUND(s_Ostf*P_ratn*n_day/100/n_yy, 2); -- сумма % к погашению
      if n>1 then
        select last_d-date_plan into n_day from dual;  -- последний день месяца минус плановая дата, день не добавляем т.к. пл дату не сдвинули на день вперед
        n_day:=n_day+1;
        s_i:=s_i+ROUND(s_s*P_ratn*n_day/100/n_yy, 2); -- сумма % к погашению
      end if;
      --txt:= n_day||'     '||s_i||'    '||to_char(date_plan, 'dd.mm.yyyy')||'    '||to_char(last_d, 'dd.mm.yyyy');
      --DBMS_OUTPUT.PUT_LINE(txt);

    elsif bm=1 then  --------------------------------------------------------------

      s_i:=s_i+ROUND(s_Ostf*P_ratn*n_day/100/365, 2); -- сумма % к погашению
      if n>1 then
        select last_d-date_plan into n_day from dual;  -- последний день месяца минус плановая дата, день не добавляем т.к. пл дату не сдвинули на день вперед
        n_day:=n_day+1;
        s_i:=s_i+ROUND(s_s*P_ratn*n_day/100/365, 2); -- сумма % к погашению
      end if;
      --txt:= n_day||'     '||s_i||'    '||to_char(date_plan, 'dd.mm.yyyy')||'    '||to_char(last_d, 'dd.mm.yyyy');
      --DBMS_OUTPUT.PUT_LINE(txt);

    elsif bm=2 then  --------------------------------------------------------------------

      select ADD_MONTHS(date_plan,1) into date_plan from dual;
      if Dp>28 then
        date_plan:=billing_date(Dp, date_plan);
      end if;
      s_i:=ROUND(s_s*P_ratn*30/100/360, 2); -- сумма % к погашению

    elsif bm=3 then  --------------------------------------------------------------------

      s_i:=s_i+ROUND(s_Ostf*P_ratn*n_day/100/360, 2); -- сумма % к погашению
      if n>1 then
        select last_d-date_plan into n_day from dual;  -- последний день месяца минус плановая дата, день не добавляем т.к. пл дату не сдвинули на день вперед
        n_day:=n_day+1;
        s_i:=s_i+ROUND(s_s*P_ratn*n_day/100/360, 2); -- сумма % к погашению
      end if;
      --txt:= n_day||'     '||s_i||'    '||to_char(date_plan, 'dd.mm.yyyy')||'    '||to_char(last_d, 'dd.mm.yyyy');
      --DBMS_OUTPUT.PUT_LINE(txt);

    end if;

    s_b:=ROUND( Pl-s_i, 2); --сумма осн долга к погашению

    if s_s<Pl or n=T-1 then
      s_b:=s_s;
      s_m:=0;
      Pl:=s_s+s_i;
      if last_day(date_plan)=last_day(d_wdate) then
        date_plan:=d_wdate;
      end if;
      n:=T;
    else
      s_m:=ROUND( s_s-s_b, 2); -- остаток по кредиту после погашения
    end if;

    --txt:= n||';   '||to_char(date_plan, 'dd.mm.rrrr')||';         '||s_s||';         '||s_b||';         '||s_m||';         '||s_i||';         '||Pl||';         '||P_ratn||';      '||bm;
                                         -- ||';         '||to_char(trunc(date_fact, 'month'), 'dd.mm.yyyy')||';         '||to_char(date_plan, 'dd.mm.yyyy')
                                         -- ||';         '||to_char(last_d, 'dd.mm.yyyy')||';           '||to_char(date_fact, 'dd.mm.yyyy');
    --DBMS_OUTPUT.PUT_LINE(txt);

    -------------------
    BEGIN
      insert into cc_lim (nd, fdat, lim2, acc, sumg, sumo, otm, sumk)
      values (nd_,
              date_plan,
              s_m*100,
              acc_,
              (Pl-s_i)*100,
              Pl*100,
              1,
              0);
      commit;
    EXCEPTION
          WHEN OTHERS THEN
      rollback;
      raise_application_error(-20203, 'Помилка збереження ГПК!'||sqlerrm);
    END;
    -------------------

    n:=n+1;
    if bm<>2 then
      select ADD_MONTHS(date_plan,1)
        into date_plan
        from dual;
      if Dp>28 then
        date_plan:=billing_date(Dp, date_plan);
      end if;
    end if;
    s_Ostf:=s_s; -- старая база начисления для следующего периода, до погашения
    s_s:=ROUND( s_s-s_b, 2); --новая база начисления для следующего периода
  END LOOP;

  END  cc_gpk_ann;

 --новый график % месяц, без корректировки - ПРОВЕРИЛ
 --новый график % день, без корректировки - ПРОВЕРИЛ
 --новый график % день, с корректировкой вперед - ПРОВЕРИЛ
 --новый график % день, с корректировкой назад - ПРОВЕРИЛ

 --старый график % месяц, без корректировки - ПРОВЕРИЛ
 --старый график % день, без корректировки - ПРОВЕРИЛ
 --старый график % день, с корректировкой вперед - ПРОВЕРИЛ
 --старый график % день, с корректировкой назад - ПРОВЕРИЛ

 PROCEDURE cc_gpk_classic(
                   nd_    INT,            --договор
                   acc_   INT,            --счет 8999
                   Pl_    NUMBER,         --месячный платеж
                   T_     INT,            --количество периодов
                   S_     NUMBER,         --сумма кредита, начальная
                   Ostf   NUMBER,         --входящий остаток по кредиту
                   P_ir  NUMBER,          --% ставка
                   nday_  NUMBER,          --день оплаты осн долга
                   d_sdate DATE,           --дата начала или дата последней операции погашения осн долга
                   d_wdate DATE,           --дата окончания
                   d_apl_dat DATE,         --первая платежная дата осн долг
                   basey_ INT,             --метод начисления %
                   flag_r INT,             --% 1=месяц, 0=день
                   day_np INT,             --Тип врегулювання дня погашення -2 - без змін
                   dog_st INT,             -- 0-новый график, 1-старый график
                   freq   INT,             --периодичность погашения
                   flag   INT DEFAULT 0--0 - платеж не меняем, 1- дату не меняем
                   ) IS

    Pl       number;
    T        number;
    P        number;
    txt      varchar2(1000);
    S        number;

    P_ratn    number;      -- годовая процентная ставка
    D_ratn    date;        -- дата изменения годоваой процентной ставки
    s_s       number;      -- остаток по кредиту до погашения
    s_Ostf     number;      -- остаток за предыдущий период до даты погащения
    s_m       number;      -- остаток по кредиту после погашения
    s_i       number;      -- погашение процентов
    date_plan date;        -- дата погашения текущая
    date_fact date;        -- дата погашения предыдущая
    date_pog  date;        -- дата погашения
    n_day     int;         -- количество дней в периоде
    n_yy      int;         -- количество дней в году
    bm        int;                -- метод начисления
    Dp        int;               -- день погащения
    s1        number;            -- промежуточный расчет
    d_start   date;          -- дата выдачи, план
    d_end     date;          -- дата возврата, план
    last_d    date;          -- последний день месяца
    flag_d    int;            -- флаг для досрочного погашения; 0-новый график; 1-была досрочка, сумму аннуитета не меняем, уменьшаем срок; 2-была досрочка, сумму аннуитета пересчитываем, дату последнего погашения не меняем
    acc_n     int;
    n         number DEFAULT 0; -- переменная для промежуточных расчетов, не забывать чистить
    d1        date;
    d2        date;
    d3        date;
    n_rate    number;
    d_rate    date;
    P_ratn_old number;
    vv        number;
    acc_k     number;
    k_metr    int;
    k_basey   int;
    k_bdat    date;
    k_ir      number;
    s_kommis  number;

  BEGIN

    Pl:=Pl_;
    T:=T_;
    S:=S_;
    P:=P_ir;
    bm:=basey_; -- метод мначисления
    Dp:=nday_;  -- день уплаты
    d_start:=d_sdate;
    d_end:=d_wdate;
    acc_n:=acc_;

 ------------------------------------
 -- для классики, с выше определенными входными параметрами
 ------------------------------------
 /*
  DBMS_OUTPUT.PUT_LINE('S='||S);
  DBMS_OUTPUT.PUT_LINE('Ostf='||Ostf);
  DBMS_OUTPUT.PUT_LINE('T='||T);
  DBMS_OUTPUT.PUT_LINE('Pl='||Pl);
  DBMS_OUTPUT.PUT_LINE('bm='||bm);
  DBMS_OUTPUT.PUT_LINE('d_start='||to_char(d_start, 'dd.mm.yyyy'));
  DBMS_OUTPUT.PUT_LINE('dog_st='||dog_st);
  DBMS_OUTPUT.PUT_LINE('d_apl_dat='||to_char(d_apl_dat, 'dd.mm.yyyy'));
  DBMS_OUTPUT.PUT_LINE('d_sdate='||to_char(d_sdate, 'dd.mm.yyyy'));
  DBMS_OUTPUT.PUT_LINE('flag_r='||flag_r);
  DBMS_OUTPUT.PUT_LINE('day_np='||day_np);
  DBMS_OUTPUT.PUT_LINE('freq='||freq);
  */---------------------------------------

  ------------------- первую строку не удаляем
  BEGIN
    delete from cc_lim
     where nd=nd_
       and acc=acc_
       and fdat>d_start;
    commit;
  EXCEPTION
        WHEN OTHERS THEN
    rollback;
    raise_application_error(-20203, 'Помилка видалення ГПК!'||sqlerrm);
  END;
  -------------------

  if dog_st=0 and nvl(Pl,0)=0 then
    Pl:=S/T;                                   -- новый график, плановый платеж неизвестен
    Pl:=round(Pl,0);
  else
    if flag=1 then -- срок погашения не менялся, пересчитываем платеж
      Pl:=S/T;
      Pl:=round(Pl,2);
     -- DBMS_OUTPUT.PUT_LINE('!!!!Pl='||Pl);
    end if;
  end if;
  --DBMS_OUTPUT.PUT_LINE('T_1='||T);
  --DBMS_OUTPUT.PUT_LINE('----------------------------');

  s_m:=S;
  --txt:= '0;   '||to_char(d_start, 'dd.mm.rrrr')||';     '||S||';     '||s_m||';     '||s_i||';     '||Pl||';    '||P_ratn||';     '||bm;
  --DBMS_OUTPUT.PUT_LINE(txt);

  select to_date(Dp||'.'||to_char(d_start, 'mm.rrrr'), 'dd.mm.rrrr' )
    into date_plan
    from dual;

  --DBMS_OUTPUT.PUT_LINE('date_plan_1='||to_char(date_plan, 'dd.mm.yyyy'));
  --DBMS_OUTPUT.PUT_LINE('d_start_1='||to_char(d_start, 'dd.mm.yyyy'));

  P_ratn:=P_ir;
  n:=1;
  s_s:=S; -- kbvbn по кредиту до погашения

  -- проверяем комиссию
  acc_k:=0; k_metr:=0; k_basey:=0; k_bdat:=null; k_ir:=0;
  BEGIN
    select a.acc, aa.metr, aa.basey, ir.bdat, ir.ir
      into acc_k, k_metr, k_basey, k_bdat, k_ir
       from nd_acc n, accounts a, INT_ACCN aa, INT_RATN ir
     where n.nd=nd_
       and a.acc=n.acc
       and a.dazs is null
       and a.TIP in('SK0', 'SK9')
       and a.nbs in(2238, 2208)
       and aa.acc=a.acc
       and ir.acc=aa.acc
       and ir.id=2;
  EXCEPTION
      WHEN OTHERS THEN
    k_ir:=0;
  END;
  --k_metr:=0; k_basey:=0; k_ir:=10;

  --DBMS_OUTPUT.PUT_LINE('s_o='||s_o||';  S_p='||S_p||';  S='||S);
  --date_fact - дата, которая отображается в графике со всеми сдвигами, если они есть
  --date_plan - четко плановая дата без корректировок праздничных дней
  --d1 - расчетная дата начало месяца
  --d2 - дата фактического погашения
  --d3 - расчетная дата конца месяца
  -- если расчет идет как % месяц, то d1,d2,d3 будут за прошлый месяц
  -- если расчет идет как % день, то d1 и d2 будут датами прошлого и текущего периода с корректировкой, а d3=0
  WHILE n<=T LOOP
    txt:=null;
    s_i:=0; s_m:=S;

    if n=1 then --для первого периода

      if dog_st=0 then --для нового графика все даты равны независимо от расчета
        s_Ostf:=s_s;
        d2 := d_start;
        date_fact:=add_months(date_plan,1);
        date_plan:=add_months(date_plan,1);
        if flag_r=1 then
          d3:=LAST_DAY(d2); --конец месяца
          n_day:=d3-d2+1;
        else
          d3:=null;
          n_day:=0;
        end if;
      else -- джля графика с погашениями

        if flag_r=1 then --% месяц, расчетную дату не трогаем, а дату периода двигаем на месяц вперед
          s_Ostf:=Ostf;
          d1:=trunc(date_plan, 'month');
          d2 := date_plan;
          d3:=LAST_DAY(d2);
          date_fact:=add_months(date_plan,1);
        else  -- усли % день, корректируем дату для расчета и для графика
          s_Ostf:=s_s;
          d1:=cck_app.correctdate2(gl.baseval,date_plan, day_np);
          d2 := cck_app.correctdate2(gl.baseval, add_months(date_plan,1), day_np);
          date_fact:=d2;
          d3:=null;
        end if;
        n_day:=d2-d1;
         -- плановую дату просто двигаем на месяц вперед
         date_plan:=ADD_MONTHS(date_plan,1);
      end if;
    else -- для всех последующих периодов корректируем расчетную дату для % день
         -- и ничего не делаем для % месяц
      if flag_r=1 then
        d2:=add_months(date_plan,-1);
        d1:=trunc(d2, 'month');
        d3:=LAST_DAY(d2);
      else
        d1:=cck_app.correctdate2(gl.baseval, add_months(date_plan,-1), day_np);
        d2 := cck_app.correctdate2(gl.baseval, date_plan, day_np);
        d3:=null;
      end if;
      n_day:=d2-d1;
    end if;

    n_rate:=0;
    P_ratn_old:=0;

    if n>1 then
      P_ratn_old:=P_ratn;

      select max(r.bdat)
        into d_rate
        from INT_RATN r
       where acc = acc_
         and id = 0
         and r.bdat <= d2;

      select r.ir
        into P_ratn
       from INT_RATN r
      where acc = acc_
        and id = 0
        and r.bdat = d_rate;

      select count(*)
        into n_rate
        from INT_RATN r
       where r.acc = acc_
         and r.id = 0
         and r.bdat=d_rate
         and r.bdat between d1 and d2;

      if n_rate=1 and d_rate=d1 then n_rate:=2; end if;

      if d3 is not null and n_rate=0 then
        select count(*)
          into n_rate
          from INT_RATN r
         where r.acc = acc_
           and r.id = 0
           and r.bdat=d_rate
           and r.bdat between d1 and d2;
        if n_rate=1 then n_rate:=2; end if; -- вторая половина периода
      end if;
    end if;

    --txt:=n||'!1!    s_o='||s_o||';   n_day='||n_day||';     s_i='||s_i||';    d1='||to_char(d1, 'dd.mm.yyyy')||'     d2='||to_char(d2, 'dd.mm.yyyy')||'    d3='||to_char(d3, 'dd.mm.yyyy');
    --DBMS_OUTPUT.PUT_LINE(txt);

    select add_months(trunc(d2,'yyyy'),12)-trunc(d2,'yyyy') into n_yy from dual;

    if nvl(k_metr,0)=0 and nvl(k_basey,0)=0 and nvl(k_ir,0)<>0 and k_bdat<=date_plan then
      s_kommis:=ROUND(nvl(s_Ostf,0)*k_ir*n_day/100/n_yy, 2);
      if n>1 then
        s_kommis:=nvl(s_kommis,0)+ROUND(s_s*k_ir*(LAST_DAY(d2)-d2+1)/100/n_yy, 2);
      end if;
    end if;

    if bm=0 then --------------------------------------------------------------------
      if n_rate = 0 then
        s_i:=ROUND(nvl(s_Ostf,0)*P_ratn*n_day/100/n_yy, 2); -- сумма % к погашению
      elsif n_rate = 1 then
        s_i:=ROUND(nvl(s_Ostf,0)*P_ratn_old*(d_rate-d1)/100/n_yy, 2); -- сумма % к погашению
        s_i:=nvl(s_i,0)+ROUND(nvl(s_Ostf,0)*P_ratn*(d2-d_rate)/100/n_yy, 2);

        --DBMS_OUTPUT.PUT_LINE( 'd1='||to_char(d1,'dd.mm.yyyy')||'  d_rate='||to_char(d_rate,'dd.mm.yyyy')||'   d2='||to_char(d2,'dd.mm.yyyy'));
      end if;

      --DBMS_OUTPUT.PUT_LINE(n||'  s_o='||s_o||'  s_s='||s_s||'   n_day='||n_day||'   date_fact!!='||to_char(date_fact,'dd.mm.yyyy')||' - '||to_char(cck_app.correctdate2(gl.baseval, ADD_MONTHS(date_fact,-1), day_np),'dd.mm.yyyy'));

      if flag_r=1 then
        if n>1 or dog_st<>0 then
          d3:=LAST_DAY(d2);
          n_day:=d3-d2+1;

          if n_rate = 0 then
            s_i:=nvl(s_i,0)+ROUND(s_s*P_ratn*n_day/100/n_yy, 2); -- сумма % к погашению
          elsif n_rate = 2 then
            s_i:=ROUND(nvl(s_Ostf,0)*P_ratn_old*(d_rate-d2)/100/n_yy, 2); -- сумма % к погашению
            s_i:=nvl(s_i,0)+ROUND(nvl(s_Ostf,0)*P_ratn*(d3-d_rate)/100/n_yy, 2);
          end if;

          --txt:=n||'!2!    s_s='||s_s||';   n_day='||n_day||';     s_i='||s_i||';    P_ratn='||P_ratn||';    n_yy='||n_yy||';   '||to_char(d1, 'dd.mm.yyyy')||'    '||to_char(d2, 'dd.mm.yyyy')||'    '||to_char(d3, 'dd.mm.yyyy');
          --DBMS_OUTPUT.PUT_LINE(txt);
        end if;
      end if;

      --txt:=n||'    s_o='||s_o||';   '||n_day||';     '||s_i||';    '||to_char(date_fact, 'dd.mm.yyyy')||'    '||to_char(last_d, 'dd.mm.yyyy')||'    '||to_char(date_fact, 'dd.mm.yyyy');
      --DBMS_OUTPUT.PUT_LINE(txt);

    elsif bm=1 then  --------------------------------------------------------------
      if n_rate = 0 then
        s_i:=ROUND(nvl(s_Ostf,0)*P_ratn*n_day/100/365, 2); -- сумма % к погашению
      elsif n_rate = 1 then
        s_i:=ROUND(nvl(s_Ostf,0)*P_ratn_old*(d_rate-d1)/100/365, 2); -- сумма % к погашению
        s_i:=nvl(s_i,0)+ROUND(nvl(s_Ostf,0)*P_ratn*(d2-d_rate)/100/365, 2);
        --DBMS_OUTPUT.PUT_LINE( d_rate-d1);
        --DBMS_OUTPUT.PUT_LINE( d2-d_rate);
        --DBMS_OUTPUT.PUT_LINE( 'd1='||to_char(d1,'dd.mm.yyyy')||'  d_rate='||to_char(d_rate,'dd.mm.yyyy')||'   d2='||to_char(d2,'dd.mm.yyyy'));
      end if;

      --DBMS_OUTPUT.PUT_LINE(n||'  s_o='||s_o||'  s_i='||s_i||'   n_day='||n_day||'   date_fact!!='||to_char(date_fact,'dd.mm.yyyy')||' - '||to_char(cck_app.correctdate2(gl.baseval, ADD_MONTHS(date_fact,-1), day_np),'dd.mm.yyyy'));

      if flag_r=1 then
        if n>1 or dog_st<>0 then
          d3:=LAST_DAY(d2);
          n_day:=d3-d2+1;

          if n_rate = 0 then
            s_i:=nvl(s_i,0)+ROUND(s_s*P_ratn*n_day/100/365, 2); -- сумма % к погашению
          elsif n_rate = 2 then
            s_i:=ROUND(nvl(s_Ostf,0)*P_ratn_old*(d_rate-d2)/100/365, 2); -- сумма % к погашению
            s_i:=nvl(s_i,0)+ROUND(nvl(s_Ostf,0)*P_ratn*(d3-d_rate)/100/365, 2);
          end if;

          --txt:=n||'!2!    s_s='||s_s||';   n_day='||n_day||';     s_i='||s_i||';    P_ratn='||P_ratn||';    n_yy='||n_yy||';   '||to_char(d1, 'dd.mm.yyyy')||'    '||to_char(d2, 'dd.mm.yyyy')||'    '||to_char(d3, 'dd.mm.yyyy');
          --DBMS_OUTPUT.PUT_LINE(txt);
        end if;
      end if;
    elsif bm=2 then  --------------------------------------------------------------------
      select ADD_MONTHS(date_plan,1) into date_plan from dual;
      if Dp>28 then
        date_plan:=billing_date(Dp, date_plan);
      end if;
      s_i:=ROUND(s_s*P_ratn*30/100/360, 2); -- сумма % к погашению
    elsif bm=3 then  --------------------------------------------------------------------
      if n_rate = 0 then
        s_i:=ROUND(nvl(s_Ostf,0)*P_ratn*n_day/100/360, 2); -- сумма % к погашению
      elsif n_rate = 1 then
        s_i:=ROUND(nvl(s_Ostf,0)*P_ratn_old*(d_rate-d1)/100/360, 2); -- сумма % к погашению
        s_i:=nvl(s_i,0)+ROUND(nvl(s_Ostf,0)*P_ratn*(d2-d_rate)/100/360, 2);

        --DBMS_OUTPUT.PUT_LINE( 'd1='||to_char(d1,'dd.mm.yyyy')||'  d_rate='||to_char(d_rate,'dd.mm.yyyy')||'   d2='||to_char(d2,'dd.mm.yyyy'));
      end if;

      --DBMS_OUTPUT.PUT_LINE(n||'  s_o='||s_o||'  s_i='||s_i||'   n_day='||n_day||'   date_fact!!='||to_char(date_fact,'dd.mm.yyyy')||' - '||to_char(cck_app.correctdate2(gl.baseval, ADD_MONTHS(date_fact,-1), day_np),'dd.mm.yyyy'));

      if flag_r=1 then
        if n>1 or dog_st<>0 then
          d3:=LAST_DAY(d2);
          n_day:=d3-d2+1;

          if n_rate = 0 then
            s_i:=nvl(s_i,0)+ROUND(s_s*P_ratn*n_day/100/360, 2); -- сумма % к погашению
          elsif n_rate = 2 then
            s_i:=ROUND(nvl(s_Ostf,0)*P_ratn_old*(d_rate-d2)/100/360, 2); -- сумма % к погашению
            s_i:=nvl(s_i,0)+ROUND(nvl(s_Ostf,0)*P_ratn*(d3-d_rate)/100/360, 2);
          end if;

          --txt:=n||'!2!    s_s='||s_s||';   n_day='||n_day||';     s_i='||s_i||';    P_ratn='||P_ratn||';    n_yy='||n_yy||';   '||to_char(d1, 'dd.mm.yyyy')||'    '||to_char(d2, 'dd.mm.yyyy')||'    '||to_char(d3, 'dd.mm.yyyy');
          --DBMS_OUTPUT.PUT_LINE(txt);
        end if;
      end if;
    end if;

    if s_s<Pl then
      s_m:=0;
      Pl:=s_s;
      n:=T;
      --DBMS_OUTPUT.PUT_LINE('ПОПАЛ='||s_m);
    else
      s_m:=s_s-Pl; -- остаток по кредиту после погашения
      --DBMS_OUTPUT.PUT_LINE('ПОПАЛ_s_m='||s_m);
    end if;

    --txt:= n||'='||T||';   '||to_char(date_fact, 'dd.mm.rrrr');
    --DBMS_OUTPUT.PUT_LINE(txt);
    if n=T and bm<>2 then
      if bm<>2 then
        date_fact:=d_wdate;
        select date_fact-trunc(date_fact, 'month') into n_day from dual;  -- плановая дата минус первое числа
        s_i:=s_i+ROUND(s_s*P_ratn*n_day/100/n_yy, 2); -- сумма % к погашению
        if s_m<>0 then
          Pl:=Pl+s_m;
          s_s:=s_s-Pl;
        end if;
        --DBMS_OUTPUT.PUT_LINE('ПОПАЛ='||n||';  '||T||';  '||s_i);
      end if;
    end if;

    vv:=0;
    vv:=s_i+Pl;
    --if n<11 then
    --  txt:= n||';   '||to_char(date_fact, 'dd.mm.rrrr')||';     '||s_s||';    '||s_m||';     '||s_i||';     '||Pl||';   '||vv||';    '||s_kommis||';    '||P_ratn||';   '||bm;
                                         -- ||';         '||to_char(trunc(date_fact, 'month'), 'dd.mm.yyyy')||';         '||to_char(date_plan, 'dd.mm.yyyy')
                                         -- ||';         '||to_char(last_d, 'dd.mm.yyyy')||';           '||to_char(date_fact, 'dd.mm.yyyy');
    --  DBMS_OUTPUT.PUT_LINE(txt);
    --end if;

    -------------------
    BEGIN
      insert into cc_lim (nd, fdat, lim2, acc, sumg, sumo, otm, sumk)
      values (nd_,
              date_plan,
              s_m*100,
              acc_,
              Pl*100,
              (Pl+s_i)*100,
              1,
              nvl(s_kommis,0)*100);
      commit;
    EXCEPTION
          WHEN OTHERS THEN
      rollback;
      raise_application_error(-20203, 'Помилка збереження ГПК!'||sqlerrm);
    END;
    -------------------


    n:=n+1;
    if bm<>2 then
      select ADD_MONTHS(to_date(Dp||'.'||to_char(date_fact, 'mm.rrrr'),'dd.mm.rrrr' ),1), ADD_MONTHS(date_plan,1)
        into date_fact, date_plan
        from dual;
      if Dp>28 then
        date_fact:=billing_date(Dp, date_fact);
        date_plan:=billing_date(Dp, date_plan);
      end if;

      if flag_r<>1 then
        date_fact:=cck_app.correctdate2(gl.baseval, date_plan, day_np);
      end if;
      --DBMS_OUTPUT.PUT_LINE(n||'---'||to_char(date_plan, 'dd.mm.yyyy'));
    end if;

    s_Ostf:=s_s; -- старая база начисления для следующего периода, до погашения
    if date_fact>d_apl_dat then
      s_s:=s_s-Pl; --новая база начисления для следующего периода
      if flag_r<>1 then
        s_Ostf:=s_s;
      end if;
      --DBMS_OUTPUT.PUT_LINE(n-1||'  s_s='||s_s||'  Pl='||Pl||'  s_o='||s_o);
    end if;
  END LOOP;

  END cc_gpk_classic;
  -------------------------
PROCEDURE cc_gpk_freq(
                   nd_    INT,            --договор
                   acc_   INT,            --счет 8999
                   Pl_    NUMBER,         --месячный платеж
                   T_     INT,            --количество периодов
                   S_     NUMBER,         --сумма кредита, начальная
                   Ostf   NUMBER,         --входящий остаток по кредиту
                   P_ir  NUMBER,          --% ставка
                   nday_  NUMBER,          --день оплаты осн долга
                   d_sdate DATE,           --дата начала или дата последней операции погашения осн долга
                   d_wdate DATE,           --дата окончания
                   d_apl_dat DATE,         --первая платежная дата осн долг
                   basey_ INT,             --метод начисления %
                   flag_r INT,             --% 1=месяц, 0=день
                   day_np INT,             --Тип врегулювання дня погашення -2 - без змін
                   dog_st INT,             -- 0-новый график, 1-старый график
                   freq   INT,             --периодичность погашения
                   flag   INT DEFAULT 0--0 - платеж не меняем, 1- дату не меняем
                   ) IS

    Pl       number;
    T        number;
    P        number;
    txt      varchar2(1000);
    S        number;

    P_ratn    number;      -- годовая процентная ставка
    D_ratn    date;        -- дата изменения годоваой процентной ставки
    s_s       number;      -- остаток по кредиту до погашения
    s_Ostf    number;      -- остаток за предыдущий период до даты погащения
    s_m       number;      -- остаток по кредиту после погашения
    s_i       number;      -- погашение процентов
    date_plan date;        -- дата погашения текущая
    date_fact date;        -- дата погашения предыдущая
    date_pog  date;        -- дата погашения
    n_day     int;         -- количество дней в периоде
    n_yy      int;         -- количество дней в году
    bm int;                -- метод начисления
    Dp  int;               -- день погащения
    s1  number;            -- промежуточный расчет;
    d_start date;          -- дата выдачи, план
    d_end   date;          -- дата возврата, план
    last_d  date;          -- последний день месяца
    flag_d int;            -- флаг для досрочного погашения; 0-новый график; 1-была досрочка, сумму аннуитета не меняем, уменьшаем срок; 2-была досрочка, сумму аннуитета пересчитываем, дату последнего погашения не меняем
    acc_n  int;
    n      number DEFAULT 0; -- переменная для промежуточных расчетов, не забывать чистить
    d1     date;
    d2     date;
    d3     date;
    n_rate number;
    d_rate date;
    P_ratn_old number;
    vv   number;

  BEGIN

    Pl:=Pl_;
    T:=T_;
    S:=S_;
    P:=P_ir;
    bm:=basey_; -- метод мначисления
    Dp:=nday_;  -- день уплаты
    d_start:=d_sdate;
    d_end:=d_wdate;
    acc_n:=acc_;

 ------------------------------------
 -- для классики, с выше определенными входными параметрами
 ------------------------------------
  /*DBMS_OUTPUT.PUT_LINE('S='||S);
  DBMS_OUTPUT.PUT_LINE('Ostf='||Ostf);
  DBMS_OUTPUT.PUT_LINE('T='||T);
  DBMS_OUTPUT.PUT_LINE('Pl='||Pl);
  DBMS_OUTPUT.PUT_LINE('bm='||bm);
  DBMS_OUTPUT.PUT_LINE('dog_st='||dog_st);
  DBMS_OUTPUT.PUT_LINE('d_apl_dat='||to_char(d_apl_dat, 'dd.mm.yyyy'));
  DBMS_OUTPUT.PUT_LINE('d_sdate='||to_char(d_sdate, 'dd.mm.yyyy'));
  DBMS_OUTPUT.PUT_LINE('flag_r='||flag_r);
  DBMS_OUTPUT.PUT_LINE('day_np='||day_np);
  DBMS_OUTPUT.PUT_LINE('freq='||freq);*/
  ---------------------------------------

  ------------------- первую строку не удаляем
  BEGIN
    delete from cc_lim
     where nd=nd_
       and acc=acc_
       and fdat>d_start;
    commit;
  EXCEPTION
        WHEN OTHERS THEN
    rollback;
    raise_application_error(-20203, 'Помилка видалення ГПК!'||sqlerrm);
  END;
  -------------------

  if dog_st=0 and nvl(Pl,0)=0 then
    Pl:=S/T;                                   -- новый график, плановый платеж неизвестен
    Pl:=round(Pl,0);
  else
    if flag=1 then -- срок погашения не менялся, пересчитываем платеж
      Pl:=S/T;
      Pl:=round(Pl,2);
     -- DBMS_OUTPUT.PUT_LINE('!!!!Pl='||Pl);
    end if;
  end if;
  --DBMS_OUTPUT.PUT_LINE('T_1='||T);
  --DBMS_OUTPUT.PUT_LINE('----------------------------');

  s_m:=S;
  txt:= '0;   '||to_char(d_start, 'dd.mm.rrrr')||';     '||S||';     '||s_m||';     '||s_i||';     '||Pl||';    '||P_ratn||';     '||bm;
  DBMS_OUTPUT.PUT_LINE(txt);

  select to_date(Dp||'.'||to_char(d_start, 'mm.rrrr'), 'dd.mm.rrrr' )
    into date_plan
    from dual;

  --DBMS_OUTPUT.PUT_LINE('date_plan_1='||to_char(date_plan, 'dd.mm.yyyy'));
  --DBMS_OUTPUT.PUT_LINE('d_start_1='||to_char(d_start, 'dd.mm.yyyy'));

  P_ratn:=P_ir;
  n:=1;
  s_s:=S; -- kbvbn по кредиту до погашения

  --DBMS_OUTPUT.PUT_LINE('s_o='||s_o||';  S_p='||S_p||';  S='||S);
  --date_fact - дата, которая отображается в графике со всеми сдвигами, если они есть
  --date_plan - четко плановая дата без корректировок праздничных дней
  --d1 - расчетная дата начало месяца
  --d2 - дата фактического погашения
  --d3 - расчетная дата конца месяца
  -- если расчет идет как % месяц, то d1,d2,d3 будут за прошлый месяц
  -- если расчет идет как % день, то d1 и d2 будут датами прошлого и текущего периода с корректировкой, а d3=0
  WHILE n<=T LOOP
    txt:=null;
    s_i:=0; s_m:=S;

    if n=1 then --для первого периода

      if dog_st=0 then --для нового графика все даты равны независимо от расчета
        s_Ostf:=s_s;
        d2 := d_start;
        date_fact:=add_months(date_plan,1);
        date_plan:=add_months(date_plan,1);
        if flag_r=1 then
          d3:=LAST_DAY(d2); --конец месяца
          n_day:=d3-d2+1;
        else
          d3:=null;
          n_day:=0;
        end if;
      else -- джля графика с погашениями

        if flag_r=1 then --% месяц, расчетную дату не трогаем, а дату периода двигаем на месяц вперед
          s_Ostf:=Ostf;
          d1:=trunc(date_plan, 'month');
          d2 := date_plan;
          d3:=LAST_DAY(d2);
          date_fact:=add_months(date_plan,1);
        else  -- усли % день, корректируем дату для расчета и для графика
          s_Ostf:=s_s;
          d1:=cck_app.correctdate2(gl.baseval,date_plan, day_np);
          d2 := cck_app.correctdate2(gl.baseval, add_months(date_plan,1), day_np);
          date_fact:=d2;
          d3:=null;
        end if;
        n_day:=d2-d1;
         -- плановую дату просто двигаем на месяц вперед
         date_plan:=ADD_MONTHS(date_plan,1);
      end if;
      date_pog:=date_fact;
    else -- для всех последующих периодов корректируем расчетную дату для % день
         -- и ничего не делаем для % месяц
      if flag_r=1 then
        d2:=add_months(date_plan,-1);
        d1:=trunc(d2, 'month');
        d3:=LAST_DAY(d2);
      else
        d1:=cck_app.correctdate2(gl.baseval, add_months(date_plan,-1), day_np);
        d2 := cck_app.correctdate2(gl.baseval, date_plan, day_np);
        d3:=null;
      end if;
      n_day:=d2-d1;
    end if;

    n_rate:=0;
    P_ratn_old:=0;
    if n>1 then
      P_ratn_old:=P_ratn;

      select max(r.bdat)
        into d_rate
        from INT_RATN r
       where acc = acc_
         and id = 0
         and r.bdat <= d2;

      select r.ir
        into P_ratn
       from INT_RATN r
      where acc = acc_
        and id = 0
        and r.bdat = d_rate;

      select count(*)
        into n_rate
        from INT_RATN r
       where r.acc = acc_
         and r.id = 0
         and r.bdat=d_rate
         and r.bdat between d1 and d2;

      if n_rate=1 and d_rate=d1 then n_rate:=2; end if;

      if d3 is not null and n_rate=0 then
        select count(*)
          into n_rate
          from INT_RATN r
         where r.acc = acc_
           and r.id = 0
           and r.bdat=d_rate
           and r.bdat between d1 and d2;
        if n_rate=1 then n_rate:=2; end if; -- вторая половина периода
      end if;
    end if;
    --txt:=n||'!1!    s_o='||s_o||';   n_day='||n_day||';     s_i='||s_i||';    d1='||to_char(d1, 'dd.mm.yyyy')||'     d2='||to_char(d2, 'dd.mm.yyyy')||'    d3='||to_char(d3, 'dd.mm.yyyy');
    --DBMS_OUTPUT.PUT_LINE(txt);

    select add_months(trunc(d2,'yyyy'),12)-trunc(d2,'yyyy') into n_yy from dual;

    if bm=0 then --------------------------------------------------------------------
      if n_rate = 0 then
        s_i:=ROUND(nvl(s_Ostf,0)*P_ratn*n_day/100/n_yy, 2); -- сумма % к погашению
      elsif n_rate = 1 then
        s_i:=ROUND(nvl(s_Ostf,0)*P_ratn_old*(d_rate-d1)/100/n_yy, 2); -- сумма % к погашению
        s_i:=nvl(s_i,0)+ROUND(nvl(s_Ostf,0)*P_ratn*(d2-d_rate)/100/n_yy, 2);
        --DBMS_OUTPUT.PUT_LINE( 'd1='||to_char(d1,'dd.mm.yyyy')||'  d_rate='||to_char(d_rate,'dd.mm.yyyy')||'   d2='||to_char(d2,'dd.mm.yyyy'));
      end if;

      --DBMS_OUTPUT.PUT_LINE(n||'  s_o='||s_o||'  s_i='||s_i||'   n_day='||n_day||'   date_fact!!='||to_char(date_fact,'dd.mm.yyyy')||' - '||to_char(cck_app.correctdate2(gl.baseval, ADD_MONTHS(date_fact,-1), day_np),'dd.mm.yyyy'));

      if flag_r=1 then
        if n>1 or dog_st<>0 then
          d3:=LAST_DAY(d2);
          n_day:=d3-d2+1;

          if n_rate = 0 then
            s_i:=nvl(s_i,0)+ROUND(s_s*P_ratn*n_day/100/n_yy, 2); -- сумма % к погашению
          elsif n_rate = 2 then
            s_i:=ROUND(nvl(s_Ostf,0)*P_ratn_old*(d_rate-d2)/100/n_yy, 2); -- сумма % к погашению
            s_i:=nvl(s_i,0)+ROUND(nvl(s_Ostf,0)*P_ratn*(d3-d_rate)/100/n_yy, 2);
          end if;

          --txt:=n||'!2!    s_s='||s_s||';   n_day='||n_day||';     s_i='||s_i||';    P_ratn='||P_ratn||';    n_yy='||n_yy||';   '||to_char(d1, 'dd.mm.yyyy')||'    '||to_char(d2, 'dd.mm.yyyy')||'    '||to_char(d3, 'dd.mm.yyyy');
          --DBMS_OUTPUT.PUT_LINE(txt);
        end if;
      end if;

      --txt:=n||'    s_o='||s_o||';   '||n_day||';     '||s_i||';    '||to_char(date_fact, 'dd.mm.yyyy')||'    '||to_char(last_d, 'dd.mm.yyyy')||'    '||to_char(date_fact, 'dd.mm.yyyy');
      --DBMS_OUTPUT.PUT_LINE(txt);

    elsif bm=1 then  --------------------------------------------------------------
      if n_rate = 0 then
        s_i:=ROUND(nvl(s_Ostf,0)*P_ratn*n_day/100/365, 2); -- сумма % к погашению
      elsif n_rate = 1 then
        s_i:=ROUND(nvl(s_Ostf,0)*P_ratn_old*(d_rate-d1)/100/365, 2); -- сумма % к погашению
        s_i:=nvl(s_i,0)+ROUND(nvl(s_Ostf,0)*P_ratn*(d2-d_rate)/100/365, 2);
        --DBMS_OUTPUT.PUT_LINE( d_rate-d1);
        --DBMS_OUTPUT.PUT_LINE( d2-d_rate);
        --DBMS_OUTPUT.PUT_LINE( 'd1='||to_char(d1,'dd.mm.yyyy')||'  d_rate='||to_char(d_rate,'dd.mm.yyyy')||'   d2='||to_char(d2,'dd.mm.yyyy'));
      end if;

      --DBMS_OUTPUT.PUT_LINE(n||'  s_o='||s_o||'  s_i='||s_i||'   n_day='||n_day||'   date_fact!!='||to_char(date_fact,'dd.mm.yyyy')||' - '||to_char(cck_app.correctdate2(gl.baseval, ADD_MONTHS(date_fact,-1), day_np),'dd.mm.yyyy'));

      if flag_r=1 then
        if n>1 or dog_st<>0 then
          d3:=LAST_DAY(d2);
          n_day:=d3-d2+1;

          if n_rate = 0 then
            s_i:=nvl(s_i,0)+ROUND(s_s*P_ratn*n_day/100/365, 2); -- сумма % к погашению
          elsif n_rate = 2 then
            s_i:=ROUND(nvl(s_Ostf,0)*P_ratn_old*(d_rate-d2)/100/365, 2); -- сумма % к погашению
            s_i:=nvl(s_i,0)+ROUND(nvl(s_Ostf,0)*P_ratn*(d3-d_rate)/100/365, 2);
          end if;

          --txt:=n||'!2!    s_s='||s_s||';   n_day='||n_day||';     s_i='||s_i||';    P_ratn='||P_ratn||';    n_yy='||n_yy||';   '||to_char(d1, 'dd.mm.yyyy')||'    '||to_char(d2, 'dd.mm.yyyy')||'    '||to_char(d3, 'dd.mm.yyyy');
          --DBMS_OUTPUT.PUT_LINE(txt);
        end if;
      end if;
    elsif bm=2 then  --------------------------------------------------------------------
      select ADD_MONTHS(date_plan,1) into date_plan from dual;
      if Dp>28 then
        date_plan:=billing_date(Dp, date_plan);
      end if;
      s_i:=ROUND(s_s*P_ratn*30/100/360, 2); -- сумма % к погашению
    elsif bm=3 then  --------------------------------------------------------------------
      if n_rate = 0 then
        s_i:=ROUND(nvl(s_Ostf,0)*P_ratn*n_day/100/360, 2); -- сумма % к погашению
      elsif n_rate = 1 then
        s_i:=ROUND(nvl(s_Ostf,0)*P_ratn_old*(d_rate-d1)/100/360, 2); -- сумма % к погашению
        s_i:=nvl(s_i,0)+ROUND(nvl(s_Ostf,0)*P_ratn*(d2-d_rate)/100/360, 2);
        --DBMS_OUTPUT.PUT_LINE( d_rate-d1);
        --DBMS_OUTPUT.PUT_LINE( d2-d_rate);
        --DBMS_OUTPUT.PUT_LINE( 'd1='||to_char(d1,'dd.mm.yyyy')||'  d_rate='||to_char(d_rate,'dd.mm.yyyy')||'   d2='||to_char(d2,'dd.mm.yyyy'));
      end if;

      --DBMS_OUTPUT.PUT_LINE(n||'  s_Ostf='||s_Ostf||'  s_i='||s_i||'   n_day='||n_day||'   date_fact!!='||to_char(date_fact,'dd.mm.yyyy')||' - '||to_char(cck_app.correctdate2(gl.baseval, ADD_MONTHS(date_fact,-1), day_np),'dd.mm.yyyy'));

      if flag_r=1 then
        if n>1 or dog_st<>0 then
          d3:=LAST_DAY(d2);
          n_day:=d3-d2+1;

          if n_rate = 0 then
            s_i:=nvl(s_i,0)+ROUND(s_s*P_ratn*n_day/100/360, 2); -- сумма % к погашению
          elsif n_rate = 2 then
            s_i:=ROUND(nvl(s_Ostf,0)*P_ratn_old*(d_rate-d2)/100/360, 2); -- сумма % к погашению
            s_i:=nvl(s_i,0)+ROUND(nvl(s_Ostf,0)*P_ratn*(d3-d_rate)/100/360, 2);
          end if;

          --txt:=n||'!2!    s_s='||s_s||';   n_day='||n_day||';     s_i='||s_i||';    P_ratn='||P_ratn||';    n_yy='||n_yy||';   '||to_char(d1, 'dd.mm.yyyy')||'    '||to_char(d2, 'dd.mm.yyyy')||'    '||to_char(d3, 'dd.mm.yyyy');
          --DBMS_OUTPUT.PUT_LINE(txt);
        end if;
      end if;
    end if;

    if s_s<Pl then
      s_m:=0;
      Pl:=s_s;
      n:=T;
      --DBMS_OUTPUT.PUT_LINE('ПОПАЛ='||s_m);
    else
      s_m:=s_s-Pl; -- остаток по кредиту после погашения
      --DBMS_OUTPUT.PUT_LINE('ПОПАЛ_s_m='||s_m);
    end if;

    --txt:= n||'='||T||';   '||to_char(date_fact, 'dd.mm.rrrr');
    --DBMS_OUTPUT.PUT_LINE(txt);
    if n=T and bm<>2 then
      if bm<>2 then
        date_fact:=d_wdate;
        select date_fact-trunc(date_fact, 'month') into n_day from dual;  -- плановая дата минус первое числа
        s_i:=s_i+ROUND(s_s*P_ratn*n_day/100/n_yy, 2); -- сумма % к погашению
        if s_m<>0 then
          Pl:=Pl+s_m;
          s_s:=s_s-Pl;
        end if;
        --DBMS_OUTPUT.PUT_LINE('ПОПАЛ='||n||';  '||T||';  '||s_i);
      end if;
    end if;

    vv:=0;
    vv:=s_i+Pl;
    --if n<11 then
    --  txt:= n||';   '||to_char(date_fact, 'dd.mm.rrrr')||';     '||s_s||';    '||s_m||';     '||s_i||';     '||Pl||';   '||vv||';    '||P_ratn||';   '||bm;
                                         -- ||';         '||to_char(trunc(date_fact, 'month'), 'dd.mm.yyyy')||';         '||to_char(date_plan, 'dd.mm.yyyy')
                                         -- ||';         '||to_char(last_d, 'dd.mm.yyyy')||';           '||to_char(date_fact, 'dd.mm.yyyy');
    --  DBMS_OUTPUT.PUT_LINE(txt);
    --end if;

    -------------------
    BEGIN
      insert into cc_lim (nd, fdat, lim2, acc, sumg, sumo, otm, sumk)
      values (nd_,
              date_plan,
              s_m*100,
              acc_,
              Pl*100,
              (Pl+s_i)*100,
              1,
              0);
      commit;
    EXCEPTION
          WHEN OTHERS THEN
      rollback;
      raise_application_error(-20203, 'Помилка збереження ГПК!'||sqlerrm);
    END;
    -------------------

    if freq=7 and date_fact>=date_pog then --квартал
      SELECT TO_CHAR(date_fact, 'Q') INTO s1 FROM dual;

      if s1=1 then date_pog:=to_date( Dp||'.03.'||to_char(date_fact, 'rrrr') ,'dd.mm.rrrr' ); end if;
      if s1=2 then date_pog:=to_date( Dp||'.06.'||to_char(date_fact, 'rrrr') ,'dd.mm.rrrr' ); end if;
      if s1=3 then date_pog:=to_date( Dp||'.09.'||to_char(date_fact, 'rrrr') ,'dd.mm.rrrr' ); end if;
      if s1=4 then date_pog:=to_date( Dp||'.12.'||to_char(date_fact, 'rrrr') ,'dd.mm.rrrr' ); end if;
      --DBMS_OUTPUT.PUT_LINE(s1||'---'||to_char(date_pog, 'dd.mm.yyyy'));
    elsif freq=12 then
      date_pog:=to_date( Dp||'.12.'||to_char(date_fact, 'rrrr') ,'dd.mm.rrrr' );
    elsif freq=120 then
      date_pog:=ADD_MONTHS(date_fact, 4);
    end if;

    n:=n+1;
    if bm<>2 then
      select ADD_MONTHS(to_date(Dp||substr (to_char(date_fact, 'dd.mm.rrrr'), 3, 8)  ,'dd.mm.rrrr' ),1), ADD_MONTHS(date_plan,1)
        into date_fact, date_plan
        from dual;
      if Dp>28 then
        date_fact:=billing_date(Dp, date_fact);
        date_plan:=billing_date(Dp, date_plan);
      end if;

      if flag_r<>1 then
        date_fact:=cck_app.correctdate2(gl.baseval, date_plan, day_np);
      end if;
      --DBMS_OUTPUT.PUT_LINE(n||'---'||to_char(date_plan, 'dd.mm.yyyy'));
    end if;

    s_Ostf:=s_s; -- старая база начисления для следующего периода, до погашения
    if date_fact>d_apl_dat then
      if date_fact=date_pog then
        s_s:=s_s-Pl; --новая база начисления для следующего периода
      end if;
      if flag_r<>1 then
        s_Ostf:=s_s;
      end if;
      --DBMS_OUTPUT.PUT_LINE(n-1||'  s_s='||s_s||'  Pl='||Pl||'  s_o='||s_o);
    end if;
  END LOOP;

  END cc_gpk_freq;
  -------------------------
  --функция контроля погашения
  --выдает состояние графика, а именно:
  --если на дату погашения изменилась % ставка
  --или метод насисления или срок кредита, а гафик не пересчитан,
  --выдается требование пересчитать график
  FUNCTION plan_rep_gpk(nd_ INT, d_rep DATE) RETURN VARCHAR2 IS
      n INT;
      txt varchar2(100);
  BEGIN
    n:=0;
    return txt;
  END plan_rep_gpk;

  --функция контроля при досрочном погашении
  -- проверка привязки счетов
  -- проверка просрочки
  -- проверка достаточности средств для погашения
  FUNCTION prepayment_gpk(nd_ INT, d_rep DATE) RETURN VARCHAR2 IS
      n INT;
      txt varchar2(100);
  BEGIN
    n:=0;
    return txt;
  END prepayment_gpk;

  FUNCTION billing_date(dd_n INT, d_rep DATE) RETURN DATE IS
      n INT;
      nn INT;
      date_v DATE;
      txt varchar2(100);
  BEGIN
    date_v:=null;
    if dd_n>28 then
      nn:=to_number(to_char( last_day(d_rep), 'dd'));
      if dd_n>nn then
        n:=nn;
      else
        n:=dd_n;
      end if;
    else
      n:=dd_n;
    end if;
    date_v:=to_date(n||'.'||to_char(d_rep, 'mm.rrrr'),'dd.mm.rrrr' );

    return date_v;
  END billing_date;

  --------------------------------------------------------------

 -- старая FUNCTION CorrectDate2, новая CorrectDay
 --
 -- Корректировка даты погашения для случаев когда дата погашения приходиться на выходной день
 -- Возвращает откоректированную дату
 -- p_KV   - валюта (обычно гривна)
 -- p_OldDate - дата погашения
 -- p_Direct -- как производить корректировку
 --  null - не производить
 --   -2  - Не виконувати кориктування
 --    0  - сдвигать назад
 --    1  - сдвигать вперед
 --    -1 - сдвигать назад не выходя за тек месяц
 --    2  - сдвигать вперед не выходя за тек месяц

FUNCTION CorrectDay( p_KV int, p_OldDate date, p_Direct number:=1) RETURN DATE is
  l_dDat date    ;
  l_n1 Number    ;
  l_nn Number    := 1;
  l_ed Number    ;
  l_Direct number;

 begin

   l_Direct := NVL ( nvl( p_Direct, -2 ), 1) ;

   if l_Direct = -2 then Return p_OldDate; end if;

   l_dDat   := p_OldDate;

   If l_Direct in (1,2) then  l_ed :=  1 ;
   else                       l_ed := -1 ;
   end if ;
   ----------------------------------------------------------
   While l_nn = 1
   loop
      begin
         SELECT count(kv) INTO l_nn FROM holiday
         WHERE kv = NVL(p_KV,gl.baseval) and holiday=l_dDat;
         l_dDat  := l_dDat + l_ed*l_nn;
      end;
   end loop;

   if l_Direct in (-1,2) and to_char(p_OldDate,'mmyyyy') != to_char(l_dDat,'mmyyyy') then

      l_nn    := 1;
      l_dDat  := p_OldDate;

       While l_nn = 1
       loop
             SELECT count(kv) INTO l_nn FROM holiday
             WHERE kv= NVL(p_KV,gl.baseval) and holiday=l_dDat;
             l_dDat:= l_dDat - l_ed*l_nn;
       end loop;

   end if;


  Return l_dDat;

 end CorrectDay;
  --
  -- header_version - возвращает версию заголовка пакета CCK
  --
  function header_version return varchar2 is
  begin
    return 'Package header CCK '||G_HEADER_VERSION;
  end header_version;

  --
  -- body_version - возвращает версию тела пакета CCK
  --
  function body_version return varchar2 is
  begin
    return 'Package body CCK '||G_BODY_VERSION;
  end body_version;
  --------------

end CCK_NEW;


/
 show err;
 
PROMPT *** Create  grants  CCK_NEW ***
grant EXECUTE                                                                on CCK_NEW         to BARS009;
grant EXECUTE                                                                on CCK_NEW         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CCK_NEW         to RCC_DEAL;
grant EXECUTE                                                                on CCK_NEW         to WR_ALL_RIGHTS;
grant EXECUTE                                                                on CCK_NEW         to WR_CREDIT;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/cck_new.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 