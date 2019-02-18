PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/package/sps.sql =========*** Run *** =======
PROMPT ===================================================================================== 



  CREATE OR REPLACE PACKAGE BARS.SPS is

  --
  -- Автор  : yurii.hrytsenia, sergey.gorobets
  -- Создан : 09.07.2016
  --
  -- Purpose : Робота зі схемами перекриття
  --

  -- Public constant declarations
  g_header_version constant varchar2(64) := 'version 1.0.2 20/02/2018';

  --------------------------------------------------------------------------------
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2;

  --------------------------------------------------------------------------------
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2;

  ------------------------------------------------------------------------------
  -- delete_scheme_side_b - видалити запис із схеми отримувача (perekr_b)
  --
  procedure delete_scheme_side_b(p_id in perekr_b.id%type);

  ------------------------------------------------------------------------------
  -- delete_scheme_account - видалити рахунок зі схеми перекриття (відвязка у specparam)
  --
  procedure delete_scheme_account(p_acc in specparam.acc%type);

  ------------------------------------------------------------------------------
  -- add_scheme_account - добавити рахунок до схеми перекриття
  --
  procedure add_scheme_account(p_acc       in specparam.acc%type,
                               p_group_id  in specparam.idg%type,
                               p_scheme_id in specparam.ids%type,
                               p_sps       in specparam.sps%type default 1);

  ------------------------------------------------------------------------------
  -- add_scheme_side_b - добавити запис з данними отримувача по схемі перекриття
  --
  procedure add_scheme_side_b(p_id        in perekr_b.id%type,
                              p_scheme_id in perekr_b.ids%type,
                              p_op_type   in perekr_b.vob%type,
                              p_op_code   in perekr_b.tt%type,
                              p_mfob      in perekr_b.mfob%type,
                              p_nlsb      in perekr_b.nlsb%type,
                              p_kv        in perekr_b.kv%type,
                              p_koef      in perekr_b.koef%type,
                              p_polu      in perekr_b.polu%type,
                              p_nazn      in perekr_b.nazn%type,
                              p_okpo      in perekr_b.okpo%type,
                              p_idr       in perekr_b.idr%type,
                              p_kod       in perekr_b.kod%type default null,
                              p_formula   in perekr_b.formula%type default null);

  ------------------------------------------------------------------------------
  -- sel015 --процедура вибору рахунків і розрахунку перекриття

  procedure SEL015(mode_ int,
                   grp   int,
                   ssps  varchar2 default '',
                   spars varchar2 default 'A',
                   isp number default 0);

  procedure PAY_PEREKR(tt_    char, --код операції
                       vob_   number, --код документу
                       nd_    varchar2, --ID запису nd_  => substr(B.id,1,10) а таблиці perekr_b --треба вивести як поле у виборці
                       pdat_  date default sysdate, --pdat_=> SYSDATE
                       vdat_  date default sysdate, --vdat_=> gl.BDATE
                       dk_    number, --dk передаємо
                       kv_    number, ---KVA
                       s_     number, --SUMA
                       kv2_   number, ---KVB
                       s2_    number, ---еквівалент SUMA, оскільки грн основна сума, передаємо просто SUMA
                       sk_    number, --симол кас плана NULL
                       mfoa_  varchar2, --MFOA
                       nam_a_ varchar2, --назва рахунку NMS
                       nlsa_  varchar2, --NLSA
                       nam_b_ varchar2, --NMKB
                       nlsb_  varchar2, --NLSB
                       mfob_  varchar2, --MFOB
                       nazn_  varchar2, --NAZN
                       id_a_  varchar2, --OKPOA
                       id_b_  varchar2, --OKPOB
                       id_o_  varchar2, --id_o_ => null
                       sign_  raw, --sign_=> null
                       sos_   number, -- Doc status sos_=> 1
                       prty_  number, -- Doc priority prty_=> null
                       uid_   number default null,
                       koef_  number);

-- sel023 --процедура вибору рахунків і розрахунку перекриття
PROCEDURE SEL023 (Mode_  INT,
                  Grp    INT,
                  Іnview VARCHAR2);

PROCEDURE PAY_PEREKR023(
               tt_     CHAR,   --код операції
               vob_    NUMBER, --код документу
               nd_     VARCHAR2, --ID запису nd_
               pdat_   DATE DEFAULT SYSDATE, --pdat_=> SYSDATE
               vdat_   DATE DEFAULT SYSDATE, --vdat_=> gl.BDATE
               dk_     NUMBER, --dk передаємо
               kv_     NUMBER,  ---KVA
               s_      NUMBER, --SUMA
               kv2_    NUMBER, ---KVB
               s2_     NUMBER, ---еквівалент SUMA, оскільки грн основна сума, передаємо просто SUMA
               sk_     NUMBER, --симол кас плана NULL
               nam_a_  VARCHAR2, --назва рахунку NMS
               nlsa_   VARCHAR2, --NLSA
               nam_b_  VARCHAR2, --NMKB
               nlsb_   VARCHAR2, --NLSB
               mfob_   VARCHAR2, --MFOB
               nazn_   VARCHAR2, --NAZN
               id_a_   VARCHAR2, --OKPOA
               id_b_   VARCHAR2, --OKPOB
               id_o_   VARCHAR2, --id_o_ => null
               sign_   RAW,      --sign_=> null
               sos_    NUMBER,     -- Doc status sos_=> 1
               prty_   NUMBER,     -- Doc priority prty_=> null
               uid_    NUMBER DEFAULT NULL,
               d_rec_  VARCHAR2,
               id_     NUMBER,
               tabn_   VARCHAR2
);

--процедура оплати груп рахунків (для технологів)
procedure pay_some_perekr (p_union_id number);

end sps;
/

CREATE OR REPLACE PACKAGE BODY BARS.sps is

  ------------------------------------------------------------------------------
  --  Author : yurii.hrytsenia, sergey.gorobets
  --  Created : 27.06.2016
  --  Purpose: Пакет для роботи схемами перекриття
  ------------------------------------------------------------------------------

  -- Private constant declarations
  g_body_version constant varchar2(64) := 'version 1.0.2 20/02/2018';
  g_log_prefix   constant varchar2(20) := 'sps:: ';

  ------------------------------------------------------------------------------
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2 is
  begin
    return 'Package header sps ' || g_header_version;
  end header_version;

  ------------------------------------------------------------------------------
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2 is
  begin
    return 'Package body sps ' || g_body_version;
  end body_version;

  ------------------------------------------------------------------------------
  -- delete_scheme_side_b - видалити запис із схеми отримувача (perekr_b)
  --
  procedure delete_scheme_side_b(p_id in perekr_b.id%type) is
  begin
    delete from perekr_b p where p.id = p_id;
    if (sql%rowcount = 0) then
      logger.info(g_log_prefix || 'Не вдалося видалити сторону отримувача зі схеми перекриття (perekr_b) з id=' || p_id);
    else
      logger.info(g_log_prefix || 'Видалено ' || sql%rowcount || ' рядків з отримувачем(ами) (perekr_b) зі схеми перекриття з id=' || p_id);
    end if;
  end;

  ------------------------------------------------------------------------------
  -- delete_scheme_account - видалити рахунок зі схеми перекриття (відвязка у specparam)
  --
  procedure delete_scheme_account(p_acc in specparam.acc%type) is
  begin
    update specparam set idg = null, ids = null, sps = null where acc = p_acc;
    if (sql%rowcount = 0) then
      logger.info(g_log_prefix || 'Не вдалося відв`язати рахунок від схеми перекриття, acc=' || p_acc);
    else
      logger.info(g_log_prefix || 'Відв`язано рахунок від схеми перекриття, acc=' || p_acc);
    end if;
  end;

  ------------------------------------------------------------------------------
  -- add_scheme_account - добавити рахунок до схеми перекриття
  --
  procedure add_scheme_account(p_acc       in specparam.acc%type,
                               p_group_id  in specparam.idg%type,
                               p_scheme_id in specparam.ids%type,
                               p_sps       in specparam.sps%type default 1) is
  begin
    update specparam set idg = p_group_id, ids = p_scheme_id, sps = p_sps where acc = p_acc;
    if (sql%rowcount = 0) then
      insert into specparam (acc, idg, ids, sps) values (p_acc, p_group_id, p_scheme_id, p_sps);
      logger.info(g_log_prefix || 'Рахунок acc=' || p_acc || ' добавлено до схеми перекриття (idg=' || p_group_id || ', ids=' || p_scheme_id || ').');
    else
      logger.info(g_log_prefix || 'Рахунок acc=' || p_acc || ' змінено у схемі перекриття (idg=' || p_group_id || ', ids=' || p_scheme_id || ').');
    end if;
  end;

  ------------------------------------------------------------------------------
  -- add_scheme_side_b - добавити запис з данними отримувача по схемі перекриття
  --
  procedure add_scheme_side_b(p_id        in perekr_b.id%type,
                              p_scheme_id in perekr_b.ids%type,
                              p_op_type   in perekr_b.vob%type,
                              p_op_code   in perekr_b.tt%type,
                              p_mfob      in perekr_b.mfob%type,
                              p_nlsb      in perekr_b.nlsb%type,
                              p_kv        in perekr_b.kv%type,
                              p_koef      in perekr_b.koef%type,
                              p_polu      in perekr_b.polu%type,
                              p_nazn      in perekr_b.nazn%type,
                              p_okpo      in perekr_b.okpo%type,
                              p_idr       in perekr_b.idr%type,
                              p_kod       in perekr_b.kod%type default null,
                              p_formula   in perekr_b.formula%type default null) is
  /*
  29.01.2018 додано можливість додавати формули через інтерфейс програми:
                              p_kod       in perekr_b.kod%type default null, - порядок сортування (пріорітет виконання) формули
                              p_formula   in perekr_b.formula%type default null); - формула
  */
  begin
    if p_id is null then
      insert into perekr_b (ids, vob, tt, mfob, nlsb, kv, koef, polu, nazn, okpo, idr, kod, formula) values (p_scheme_id, p_op_type, p_op_code, p_mfob, p_nlsb, p_kv, p_koef, p_polu, p_nazn, p_okpo, p_idr, p_kod, p_formula);
      logger.info(g_log_prefix || 'Вставка нового отримувача по схемі перекриття ids=' || p_scheme_id);
    else
      update perekr_b p
         set p.vob = p_op_type, p.tt = p_op_code, p.mfob = p_mfob, p.nlsb = p_nlsb, p.kv = p_kv, p.koef = p_koef, p.polu = p_polu, p.nazn = p_nazn, p.okpo = p_okpo, p.idr = p_idr, p.kod = p_kod, p.formula = p_formula
       where id = p_id;
      logger.info(g_log_prefix || 'Оновлення отримувача perekr_b.id=' || p_id || ' по схемі перекриття ids=' || p_scheme_id);
    end if;
  end;


  ------------------------------------------------------------------------------
  --sel015
  PROCEDURE SEL015(
    Mode_ int,
    Grp   int,
    sSps  varchar2 default '',
    sParS varchar2 default 'A',
    isp   number   default 0)
is
/****************************************************************************
  26.09.2018 MDom скореговано parsing призначень (tsel015.nazn), додана умова для обробки TO_CHAR, F_TARIF - COBUMMFO-9481
  24.03.2017 Додано трансляцію призначень платежу. Тобто можна в призначенні платежу використоувавати
  деякі значення з самого платежу:
   #(S)', - зашальний залишок рахунку
   #(S2)', -   суму платежу
   #(NLSA)',  - рахунок А
   #(NLSB)',  - рахунок Б
   #(MFOA)', -  МФО А
   #(MFOB)',  - МФО Б
   #(KV)',   -  вал. А
   #(KV2)',  -  вал. Б
   #(TT)',   -  код операції
   #(KOEF)',' -  коефіцієнт
  Також в призначенні можна використовувати формлу виду:  #{F_DOG_PER (1)}
  функція F_DOG_PER (1) вибирає значення з таблиці perekr_dog відповідно до ID (в нашому випадку це 1)
  Інших інтерпритацій не передбачено. При не правильному записі формули вона не буде
  трансльована і передасться в призначення як є, тобто помилковий запис формули.
  19.01.2017 введено додатковий параметр "isp number default 0" в процедуру, який буде визначати
  чи необхідно до загальної виборки додавати умову відбору рахунків по виконавцю. Введено для
  реалізації функцій виду: Sel015(hWndMDI,1,2, 'S','a.isp='||Str(GetUserId()))
  Якщо необхідно додати умову, параметру треба поставити значення 1
  17.01.2017 додано для кожної вибірки умову по KF для таблиць saldo або accounts та perekr_b
  (a.kf=sys_context('bars_context','user_mfo'), pb.kf=sys_context('bars_context','user_mfo'))
  29.07.2016 дані в таблиці записються і відбираються з sys_context('bars_global','user_id')
  07.07.2016 додано обробку формул для перекриттів SEL015.
  18.06.2016 додає в призначення % перерахованих коштів (н-д 33%)
  17.06.2016 добавлено перевірку на закритий рахунок по поточному МФО
  (select dazs from accounts where nls=pb.nlsb and kv=pb.kv and PB.MFOB=bars.f_ourmfo()) is null
  16.06.2016
  добавив поле ID NUMBER (38),
  (з таблиці perekr_b), добавив поле MFOA (з таблиць accounts or saldo)
  треба для проводок
  Mode_ - параметр, який у виборці відповідає за те чи відбирати рахунки з
  відслідковуванням планових залишків (плановий залитшок = фактичному Mode_= 1)
  або без відслідковування (плановий залишок не довівнює фактичному Mode_= 1)
  GRP - номер групи перекриття
  sParS - Параметр який задає чи буде виборка робитися з таблиці saldo (не має
  політик доступу на таблиці saldo) замість accounts (
  по суті доступ до рахунків по наданим правам)
  sSps - Параметр який задає спосіб обчислення суми документу для перерахування
  (01,29,763)
  формула виводиться у виборку завжди (таб, perekr_b поле formula)
  (pb.formula - формула,pb.kod - порядок сортування (буде першим списуватися
  з формулою потім з коефіцієнтом))
  /*****************************************************************/
  /*Логіка для перекриттів яка включає обрахунок сум документів
  при використанні формул.
  06.07.2016 Алгоритм обраховує розщеплення по рахунку NLSA. Якщо в розщепленнні
  є формули з відповідними KOD (порядок обрахування формул) то спочатку обраховуються
  стрічки з формулами у яких найменший KOD, після обрахування всіх стрічок з формулами
  обраховуються рядки з коефіцієнтами, починаючи з найменшого до найбільшого коефіцієнта.
  Останній рядок отримує суму лишку  віднімання від залишку на рахунку всіх вище перерахованих сум.
  02.07.2016
  --Важливо: При встановленні в таблиці формул типу F_TARIF(46,980,#(NLSA), #(S))
  необхідно обов'язково дивитися щоб було проставлено для кожної
  вписаної формули поле KOD. KOD - задає порядок (послідовність) обрахунку сум по формулам.
  KOD=1,2,3...
  */
  /*****************************************************************/
    sSql        varchar2(4000); --загальний запит
    l_mfo       char(6);        --поточне мфо
    strTabN     varchar2(30);   --в залежності від параметрів saldo or accounts
    sSps1       varchar2(2);   --спосіб обчислення суми
    l_sSps      varchar2 (25);
    s1          number;
    l_U_ID      number;
    l_str       varchar2(255 BYTE); --змінна для запису формули
    l_sf        number; -- локальна змінна для суми формули
    s2          number; -- змінна для залишкової суми після віднімання формули
    s3          number; --залишкова сума
    B_sum       number;
    num     number;
    -------------змінні для трансляції призначення платежу
    l_nazn  varchar2(4000); --перепризначене призначення
    l_s     varchar2(4000); --проміжні значення формул
    s_nazn  varchar2(4000); --значення формули
    l_s1    varchar2(4000); --проміжні значення формул
    n1      number; --позиція початку входження формули
    n2      number; --позиція кінця входження формули
    n3      number; --позиція початку входження формули
    n4      number; --позиція кінця входження формули
    -----------------------------------
  begin
    if Grp is null then
      RAISE_APPLICATION_ERROR(-20000, 'Не вірний номер групи перекриття');
    end if;

    --беремо поточне МФО
    l_mfo := bars.f_ourmfo();

    --аналізуємо параметр на предмет використання saldo чи accounts
    IF SUBSTR(sParS, 1, 1) = 'S' THEN
      strTabN := 'saldo';
    ELSE
      strTabN := 'accounts';
    END IF;
    
    --Аналізуємо параметр СПОСІБ ОБЧИСЛЕННЯ СУМИ sSps varchar2
    --якщо явно заданий sSps тоді вираховуємо суму документа через
    --функцію KAZ, якщо не задано явно - вираховуємо через KAZ з
    --з поточним SPS (SPECPARAM поле SPS)
    IF sSps IS NULL THEN
      l_ssps := 'KAZ(pa.sps, pa.acc)';
    ELSE
      l_ssps := 'KAZ('||sSps||', pa.acc)';
    END IF;

    -------------------------
    sSql := q'[
               SELECT a.nls as NLSA,
                      a.kv as KVA,
                      pb.mfob as MFOB,
                      SUBSTR(
                        VKRZN(
                          SUBSTR(pb.mfob, 1, 5),
                          TRIM(
                            SUBSTR(
                              DECODE(
                                SUBSTR(pb.nlsb, 5, 1),
                                '*',
                                SUBSTR(pb.nlsb, 1, 4) || SUBSTR(a.nls, 5), pb.nlsb),
                              1, 14)
                            )
                          ),
                        1, 14) as NLSB,
                        pb.kv as KVB,
                        pb.tt as TT,
                        pb.vob as VOB,
                        ABS(%sSps) as SUMA_SPS,
                        pb.koef as KOEF,
                        SUBSTR(DECODE(pb.mfob, %mfo, a.nms, NVL(k.nmkk, k.nmk)), 1, 38) as NMK,
                        SUBSTR(a.nms, 1, 38) as NMS,
                        DECODE(SUBSTR(pb.nlsb, 5, 1), '*', NVL(k.nmkk, k.nmk), pb.polu) as NMKB,
                        pb.nazn as NAZN,
                        a.acc as ACC,
                        k.okpo as OKPOA,
                        DECODE(SUBSTR(pb.nlsb, 5, 1), '*', k.okpo, pb.okpo) as OKPOB,
                        pb.idr as IDR,
                        t.dig as DIG,
                        pa.sps as sps,
                        CASE WHEN KAZ(pa.sps, pa.acc) < 0 THEN 0 ELSE 1 END as DK,
                        ABS(%sSps*pb.koef) as SUMA,
                        pb.KOD as KOD,
                        pb.FORMULA as FORMULA,
                        pb.id as ID,
                        a.KF as MFOA,
                        rownum as U_ID,
                        (select sys_context('bars_global', 'user_id') from dual) as US_ID
                   from SPECPARAM pa,
                        PEREKR_B  pb,
                        %STRTABN  a,
                        TABVAL    t,
                        CUSTOMER  k,
                        CUST_ACC  c
                  WHERE pa.ids = pb.ids
                    AND pa.acc = a.acc
                    AND a.kv = t.kv
                    AND c.acc = a.acc
                    AND c.rnk = k.rnk
                    AND pa.idg = %GRP
                    AND pb.koef > 0
                    AND %sSps <> 0]'||
                    case
                      when (Mode_ = 11) then ''
                      else chr(13)||chr(10)||q'[                    AND KAZ(763, pa.acc)<>0]'
                    end||q'[
                    AND a.kf = sys_context('bars_context', 'user_mfo')
                    AND pb.kf = sys_context('bars_context', 'user_mfo')]';
    
    sSql := REPLACE(sSql, '%sSps', l_sSps);
    sSql := REPLACE(sSql, '%mfo', l_mfo);
    sSql := REPLACE(sSql, '%STRTABN', strTabN);
    sSql := REPLACE(sSql, '%GRP', TO_CHAR(Grp));

    --видалення даних з таблиці по USER_ID
    DELETE FROM tsel015 WHERE US_ID = SYS_CONTEXT('bars_global', 'user_id'); --(SELECT SYS_CONTEXT('bars_global', 'user_id') FROM DUAL);
    COMMIT;

    --аналізуємо вхідний параметр ISP. Якщо параметр = 1 то додаємо до загальної виборки
    --умову відбору по виконавцю.
    /*CASE isp
      WHEN 1 THEN
        sSql := sSql||chr(13)||chr(10)||'                  and a.isp = '||SYS_CONTEXT('bars_global', 'user_id');
      ELSE NULL;
    END CASE;*/
    if isp = 1 then
      sSql := sSql||chr(13)||chr(10)||'                    and a.isp = '||SYS_CONTEXT('bars_global', 'user_id');
    end if;

    logger.info('SPS: '||ssql);
    
    sSql := 'insert into TSEL015 '||sSql;
    EXECUTE IMMEDIATE sSql;
    COMMIT;
    --вираховування сум  перерахувань, враховуючи округлення та формули

    --відбір рахунку А
    for A in (select distinct NLSA, KVA, suma_sps
                from TSEL015
               where US_ID = sys_context('bars_global', 'user_id'))
    loop
      s2 := A.suma_sps;
      
      for B in (SELECT NLSA,
                       NLSB,
                       KVB,
                       KOEF,
                       SUMA_SPS,
                       SUMA,
                       U_ID,
                       ROUND(SUMA_SPS * KOEF, 0) AS ROUND_SUMA,
                       FORMULA,
                       KOD,
                       TT,
                       sum(suma) over (partition by NLSA) as all_suma, --сума всіх розподільчих сум, використовується для перевірки з початковим залишком на рахунку
                       ROW_NUMBER() OVER (PARTITION BY nlsa ORDER BY formula, kod, koef) AS ROW_NUMBER, --порядковий номер рядка в пачці, використовується для порівняння
                       --к-ть рядків в пачці, використовується для порівняння
                       COUNT(*) OVER (PARTITION BY nlsa ORDER BY formula, kod, koef ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS total_count
                  from tsel015
                 where NLSA = A.NLSA
                   and KVA = A.KVA
                   and US_ID = sys_context('bars_global', 'user_id')
                 order by kod, koef, row_number) --сортування спочатку по формулі потім код і коефіцієнт, важливо при обрахунках
      loop
        select count(1)
          into num
          from tsel015
         where NLSA = A.NLSA
           and US_ID = sys_context('bars_global', 'user_id')
           and formula is not null; --флаг присутності формули у підвиборці
        
        l_str := B.formula;
        
        --розрахунок якщо передається формула в рядку
        IF B.formula is not null THEN
          
          if instr(l_str, '#(NLSA)') > 0 then
            l_str := replace(l_str, '#(NLSA)', to_char(A.NLSA));
          end if; --рахунок А
          
          if instr(l_str, '#(NLSB)') > 0 then
            l_str := replace (l_str, '#(NLSB)', to_char(B.NLSB));
          end if; --рахунок B
          
          if instr(l_str, '#(S0)') > 0 then
            l_str := replace(l_str, '#(S0)', to_char(S2)); --залишкова сума
          end if; --поточний залишок
          
          if instr(l_str, '#(TT)') > 0 then
            l_str := replace (l_str, '#(TT)', to_char(B.TT));
          end if; --код операції
          
          if instr(l_str, '#(S)') > 0 then
            l_str := replace (l_str, '#(S)', to_char(round(A.suma_sps*B.koef, 0)));
          end if; --сума: загальний залишок на рахунку А * на коефіцієнт 

          --вирахування по формулі
          begin
            execute immediate 'select '||l_str||' from dual' into l_sf;
          exception
            when others then
              RAISE_APPLICATION_ERROR(-20004, 'Помилка при виконанні обрахунку формули: '||l_str);
          end;
          
          --перевірка формування суми по формулі, перериваємо виконання процедури, якщо сума
          --яка сформована по формулі перевищує залишок на рахунку
          if l_sf > S2 then
            RAISE_APPLICATION_ERROR(-20000, 'Сума сформована формулою більша чим залишкова сума на рахунку - '||A.NLSA);
          end if;
          
          --якщо поточний номер рядка дорівнює загальній к-ті рядків (тобто останній рядок)
          --якщо для одного рахунку розщеплення тільки один рахунок з формулою і ми списуємо
          --суму яка менша чим повний залишок по рахунку.
          if b.total_count <> 1 then --якщо для одного рахунку розщеплення більше чим один рахунок зарахувань
            if b.row_number = b.total_count then
              null; --03.02.2017 при розрахунку формул не будемо закидувати всю суму на останній рах. (стрічку)
              --old l_sf := s2; --присвоюємо всю суму яка лишилася
            else
              s2 := s2 - l_sf; --якщо рядок не останній віднімаємо від поточного залишку обраховану по формулі суму
              s3 := s2;
            end if;
          --else s2 := s2 - l_sf;
          end if;
          
          --перевірка формування суми по формулі, перериваємо виконання процедури, якщо сума
          --перевірка чи сума не менша за 0
          IF l_sf < 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Сума для перерахування з рахунку '||A.NLSA||' на рахунок '||B.NLSB||' менша за 0');
          END IF;
          
          update tsel015 --апдейтимо суму документу (рядка)
             set suma = l_sf
           where NLSA = A.NLSA
             and NLSB = B.NLSB
             and koef = B.koef
             and U_ID = B.U_ID;
        end if; --для формули
        
        --для рядків які обраховуються не по формулі
        IF B.formula is null THEN
          --суму документу вибираємо по CASE
          update tsel015
             set suma = case
                          when b.row_number = b.total_count then --s2, s3 --якщо рядок останній сума документу весь зилишок
                            case
                              when num = 0 then s2
                              else s3
                            end
                          else
                            case
                              when num = 0 then
                                round(B.suma_sps * b.koef, 0) --якщо рядок не останній сума документу = поточний залишку на рахунку * на коефіцієнт
                              else
                                round(s2 * b.koef, 0)
                            end
                        end
           where NLSA = A.NLSA
             and NLSB = B.NLSB
             and koef = B.koef
             and U_ID = B.U_ID;
          
          s3 := s3 - round(s2 * b.koef, 0); --залишкова сума, якщо використ. коефіц + формули.
          
          --перевірка чи сума не менша за 0
          /*
          logger.info('SPS debug A.NLSA: '    ||A.NLSA);
          logger.info('SPS debug A.KVA: '     ||A.KVA);
          logger.info('SPS debug A.suma_sps: '||A.suma_sps);
          logger.info('SPS debug s2: '        ||s2);
          logger.info('SPS debug s2 B.NLSB: ' ||B.NLSB);
          logger.info('SPS debug s2 B.NLSA: ' ||B.NLSA);
          logger.info('SPS debug s2 B.KVB: '  ||B.KVB);
          */
          IF s2 < 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'Сума для перерахування з рахунку '||A.NLSA||' на рахунок '||B.NLSB||' менша за 0');
          END IF;

          --перевірка, якщо рядок не останній то від поточного залишку віднімаємо обраховану суму (поточний залишок * на коефіцієнт)
          IF b.row_number <> b.total_count THEN
            --s2:=s2-round(B.suma_sps * B.koef,0);
            case num
              when 0 then s2:=s2-round(B.suma_sps * B.koef,0);
              else null;
            end case;
          end if;
        END IF;
      end loop; --кінець циклу В

      /*
      SELECT SUM (suma)
        INTO B_sum
        FROM TSEL015
       WHERE NLSA = A.NLSA and US_ID = sys_context('bars_global', 'user_id');
        
      IF B_sum <> A.suma_sps THEN
        RAISE_APPLICATION_ERROR (-20003,'Сума всіх розщеплень по рахунку '|| A.NLSA|| ' не рівна залишку на рахунку '|| A.NLSA);
      END IF;
      */
    end loop; --кінець циклу А
    COMMIT;

    --------------------------------------ТРАНСЛЯЦІЯ ПРИЗНАЧЕНЬ
    for k in (select *
                from TSEL015
               where US_ID = SYS_CONTEXT('bars_global','user_id'))
    loop
      l_nazn := k.nazn;
      
      --2018.09.26 MDom parsing всіх формул #{F_DOG_PER (1)}, #{TO_CHAR (1)}, #{F_TARIF (1)}
      --old розбір формул виду #{F_DOG_PER (1)}
      if regexp_like(l_nazn, '#') then
        -----------------------розбір формул реквізитів документу
        --2018.09.26 MDom нова умова, та перенесено перед F_DOG_PER/TO_CHAR/F_TARIF бо щоб спрацювала формула, спочатку потрібно зробити parsing значень
        if regexp_like(l_nazn, '#\(') then --якщо знаходимо '#(', то робимо parsing
        /*--old закоментовано тому що перевіряло лише перший '#' і наприклад '#{TO_CHAR(#(S)/600,''9999990.99'')}' parsing не зробився би
        if regexp_like(l_nazn, '#') then
          IF SUBSTR(l_nazn, regexp_instr(l_nazn,'#',1), 2)='#(' THEN*/
            l_nazn := REPLACE(UPPER(l_nazn), '#(S)',    TO_CHAR(k.suma_sps));
            l_nazn := REPLACE(UPPER(l_nazn), '#(S2)',   TO_CHAR(k.suma));
            l_nazn := REPLACE(UPPER(l_nazn), '#(NLSA)', ''''||k.nlsa||'''');
            l_nazn := REPLACE(UPPER(l_nazn), '#(NLSB)', ''''||k.nlsb||'''');
            l_nazn := REPLACE(UPPER(l_nazn), '#(MFOA)', ''''||k.mfoa||'''');
            l_nazn := REPLACE(UPPER(l_nazn), '#(MFOB)', ''''||k.mfob||'''');
            l_nazn := REPLACE(UPPER(l_nazn), '#(KV)',   TO_CHAR(k.kva));
            l_nazn := REPLACE(UPPER(l_nazn), '#(KV2)',  TO_CHAR(k.kvb));
            l_nazn := REPLACE(UPPER(l_nazn), '#(TT)',   ''''||k.tt||'''');
            l_nazn := REPLACE(UPPER(l_nazn), '#(KOEF)', ''''||TO_CHAR(k.koef,'0D0000')||'''');
          --end if;
        end if;
        
        --На#(MFOA)--#(MFOB)--#(KV)--#(KV2)--#(TT)--#(KOEF) вик.п.НКРЕ #{F_DOG_PER(1)}, в т.ч.ПДВ--#{F_DOG_PER (1)}--#(S), #(NLSA)--#(NLSb)
        --тільки для ЦА
        --2018.09.26 MDom додано TO_CHAR та F_TARIF
        if regexp_like(l_nazn, 'F_DOG_PER') or regexp_like(l_nazn, 'TO_CHAR') or regexp_like(l_nazn, 'F_TARIF') then
          --цикли забрали, проходимо по призначенню тільки один раз.
          --while regexp_like(l_nazn, '(#{)')
          --loop
          --вирізаємо запис формули для replace
          n1 := regexp_instr(l_nazn, '(#{)', 1); --позиція першого входження #
          --DBMS_OUTPUT.PUT_LINE('N1: '||n1);
          --#{F_DOG_PER (1)}
          n2 := regexp_instr(l_nazn, '\)}', 1); --позиція першого входження }
          --DBMS_OUTPUT.PUT_LINE('N2: '||n2);
          --s1:=substr(l_nazn, regexp_instr(l_nazn,'#',1), 16);
          l_s1 := substr(l_nazn, n1, n2-n1+2); --вирізаємо повну форму формули
          --DBMS_OUTPUT.PUT_LINE('Формула -1: '||s1);
          -------------------------------------------------
          --з запису вирізаємо саму формулу для обрахунку
          n3 := regexp_instr(l_s1, '#', 1) + 2;
          --DBMS_OUTPUT.PUT_LINE('N3: '||n3);
          --DBMS_OUTPUT.PUT_LINE('S1: '||s1);
          n4 := regexp_instr(l_s1, '\)}', 1) - 2;
          --DBMS_OUTPUT.PUT_LINE('N4: '||n4);
          l_s := substr(l_s1, n3, n4);
          --DBMS_OUTPUT.PUT_LINE('Формула: '||s);
          --обрахунок значення по формулі
          begin
            execute immediate 'select '||l_s||' from dual' into s_nazn; --порахували формулу
            --DBMS_OUTPUT.PUT_LINE('Формула 0: '||s_nazn);
          exception when others then
            RAISE_APPLICATION_ERROR (-20004, 'Помилка при виконанні обрахунку формули в призначенні: '||l_s||'NLSB: '||k.NLSB||'Призначення: '||k.NAZN);
          end;
          --заміна формули на значення формули в призначенні
          l_nazn := replace(l_nazn, l_s1 , s_nazn);
          --DBMS_OUTPUT.PUT_LINE('Формула 1: '||l_nazn);
          --end loop;
        end if; --закінчення IF по формулі #{F_DOG_PER (1)}
        
        --DBMS_OUTPUT.PUT_LINE('Призначення full:     '||l_nazn);
        l_nazn := substr(l_nazn, 1, 160); --обрізаємо наформоване призначення платежу до 160 символів
        --DBMS_OUTPUT.PUT_LINE('Призначення shot:  '||l_nazn);
        --апдейтимо призначення для стрічки
        update TSEL015
           set nazn = l_nazn
         where US_ID = SYS_CONTEXT('bars_global', 'user_id')
           and U_ID = k.U_ID;
        commit;
      end if; --загальний IF
    end loop;
    --------------------------------
  end SEL015;


procedure pay_perekr  (
                       tt_     CHAR,   --код операції
                       vob_    NUMBER, --код документу
                       nd_     VARCHAR2, --ID запису nd_  => substr(B.id,1,10) а таблиці perekr_b
                       pdat_   DATE DEFAULT SYSDATE, --pdat_=> SYSDATE
                       vdat_   DATE DEFAULT SYSDATE, --vdat_=> gl.BDATE
                       dk_     NUMBER, --dk передаємо
                       kv_     NUMBER,  ---KVA
                       s_      NUMBER, --SUMA
                       kv2_    NUMBER, ---KVB
                       s2_     NUMBER, ---еквівалент SUMA, оскільки грн основна сума, передаємо просто SUMA
                       sk_     NUMBER, --симол кас плана NULL
                       mfoa_   VARCHAR2, --MFOA
                       nam_a_  VARCHAR2, --назва рахунку NMS
                       nlsa_   VARCHAR2, --NLSA
                       nam_b_  VARCHAR2, --NMKB
                       nlsb_   VARCHAR2, --NLSB
                       mfob_   VARCHAR2, --MFOB
                       nazn_   VARCHAR2, --NAZN
                       id_a_   VARCHAR2, --OKPOA
                       id_b_   VARCHAR2, --OKPOB
                       id_o_   VARCHAR2, --id_o_ => null
                       sign_   RAW,      --sign_=> null
                       sos_    NUMBER,     -- Doc status sos_=> 1
                       prty_   NUMBER,     -- Doc priority prty_=> null
                       uid_    NUMBER DEFAULT NULL,
                       koef_   NUMBER)
IS
  REF_    number; --референс
  data_   DATE;   --data_ => gl.BDATE,
  datp_   DATE;   --datp_ => gl.bdate,
  l_d_rec varchar2(60);
  l_nazn  varchar2(160);
  l_flag  number;
  l_sos   number;

/*
20.11.2018 COBUMMFO-10143 MDom додав savepoint, rollbak та блок exception
10.07.2018 Одеса ввела не правильно перекриття. Для внутрішніх платежів
           замість операції PS1 використала зовнішню операцію PS5,
           додаю страховку замість paytt => gl.dyntt2
*/
begin
  l_d_rec := '';
  data_   := gl.BDATE;
  datp_   := gl.bdate;
  l_nazn  := nazn_;

  --формування призначення
  --IF length(nazn_) <= 148 then l_NAZN := l_NAZN||' ('||KOEF_*100||'%)';
  --else l_d_rec := '#П ('||KOEF_*100||'%)'||'#'; end if;

  BEGIN
    SELECT SUBSTR(flags, 38, 1)
      INTO l_flag
      FROM tts
     WHERE tt = tt_;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      l_flag := 0;
  END;
  
  savepoint before_pay_doc;
  
  --logger.info('SPS l_flag      '||l_flag);
  --оплата документу
  IF S_> 0 THEN
    begin
      gl.REF(REF_);
      gl.in_doc3(
        ref_   => REF_,          tt_    => tt_,           
        vob_   => vob_,          nd_    => TO_CHAR(REF_), 
        pdat_  => pdat_,         vdat_  => gl.BDATE,      
        dk_    => dk_,           kv_    => kv_,           
        s_     => S_,            kv2_   => kv2_,          
        s2_    => S_,            sk_    => sk_,           
        data_  => data_,         datp_  => datp_,         
        nam_a_ => nam_a_,        nlsa_  => nlsa_,         
        mfoa_  => mfoa_,         nam_b_ => nam_b_,        
        nlsb_  => nlsb_,         mfob_  => mfob_,         
        nazn_  => l_nazn,        d_rec_ => l_d_rec,       
        id_a_  => id_a_,         id_b_  => id_b_,         
        id_o_  => id_o_,         sign_  => sign_,         
        sos_   => sos_,          prty_  => prty_,         
        uid_   => uid_);

      gl.dyntt2(
        sos_   => l_sos,
        mod1_  => l_flag,
        mod2_  => 1,
        ref_   => REF_,
        vdat1_ => gl.bDATE,
        vdat2_ => null,
        tt0_   => TT_,
        dk_    => DK_,
        kva_   => kv_,
        mfoa_  => mfoa_,
        nlsa_  => nlsa_,
        sa_    => S_,
        kvb_   => kv2_,
        mfob_  => mfob_,
        nlsb_  => nlsb_,
        sb_    => S_,
        sq_    => null,
        nom_   => null);
      --gl.dyntt(l_flag, REF_, gl.bDATE, DK_, kv_, nlsa_, S_, kv2_, nlsb_, S_);
      --paytt(l_flag, REF_, gl.bDATE, TT_, DK_, kv_, nlsa_, S_, kv2_, nlsb_, S_);
    exception
      when others then
        rollback to savepoint before_pay_doc;
        raise;
    end;
  end if;

  if ref_ is not null then
    begin
      logger.info('SPS015: '||ref_);
      --logger.info('SPS: '||nlsa_||' '||mfoa_||' '||id_a_||' '||sys_context('bars_global', 'user_id')||'suma '||S_);
      delete from tsel015 t
       where T.NLSA = nlsa_
         and T.MFOA = mfoa_
         and T.OKPOA = id_a_
         and T.KVA = kv_

         and T.NLSB = nlsb_
         and T.MFOB = mfob_
         and T.OKPOB = id_b_
         and T.KVB = kv2_

         and t.tt = tt_
         and t.dk = dk_

         and T.SUMA = S_
         and t.nazn like l_nazn

         and t.us_id = sys_context('bars_global', 'user_id');
         ----------------------------
      commit;
    end;
  end if;
END;


PROCEDURE SEL023
( Mode_ int, Grp  int, Іnview varchar2)
IS

/*******************************************/
/*
17.01.2017 Додано уточнення по користувачу при формуванні циклу:
WHERE US_ID = (SELECT SYS_CONTEXT ('bars_global', 'user_id') FROM DUAL)
06.07.2016
Mode_ - передається режим запуска, для таких перекриттів
поки тільки 7, можливо потім треба буде розширити
Grp  - група перекриття
Inview  - параметр у якому передають яку VIEW використовувати для
перекриття: PER_KRM, PER_INK_N, PER_INK

Добавив поле DREC VARCHAR2(60) для темпової таблиці
показувати поки не будемо його, якщо треба буде добавляти
реквізити поставити відмітку в базі метаданих "показувати поле".

*/
/*******************************************/
sSql varchar2 (4000);
l_tabn varchar2(10);
begin

 --перевірка чи правильний mode
 IF MODE_ <> 7
    THEN
        RAISE_APPLICATION_ERROR(-20000,'Не вірний параметр Mode_');
 END IF;
  --перевірка чи правильна view
 IF TRIM (Іnview) NOT IN ('PER_KRM','PER_INK_N','PER_INK')
    THEN
        RAISE_APPLICATION_ERROR(-20001, 'Не вірний параметр Іnview');
 END IF;

  --формування загального запиту вибору рахунків
    IF Mode_= 7
      THEN
       BEGIN
                 sSql:=q'[
                 SELECT
                 nlsa,
                 kva,
                 mfob,
                 nlsb,
                 NVL (kvb, kva) as KVB,
                 tt,
                 vob,
                 SUBSTR (a.nd, 1, 10) as ND,
                 datd,
                 s,
                 nam_a,
                 nam_b,
                 SUBSTR (a.nazn, 1, 217) NAZN,
                 okpoa,
                 okpob,
                 grp,
                 ref,
                 sos,
                 id,
                 CASE WHEN s < 0 THEN 0 ELSE 1 END as DK,
                 CASE
                    WHEN kva <> NVL (kvb, kva) AND (kva = 980 OR NVL (kvb, kva) = 980)
                    THEN
                       DECODE (kva,
                               980, gl.p_ncurval (NVL (kvb, kva), s, gl.bd),
                               gl.p_icurval (kva, s, gl.bd))
                    ELSE
                       s
                 END as s2,
                 null as DREC,
                 null as Tabn,
                 (select sys_context('bars_global','user_id') from dual) as US_ID
            FROM %VIEW a
           WHERE NVL (a.sos, 0) = 0 AND a.grp = '%Grp'
        ORDER BY a.grp,
                 SUBSTR (a.nlsa, 1, 4),
                 SUBSTR (a.nlsa, -3),
                 a.kva,
                 a.id]';
        END;
       --міняємо в запиті значення на дані введені через параметри
       sSql := REPLACE( sSql, '%Grp', TO_CHAR(Grp) );
       sSql := REPLACE( sSql, '%VIEW', TO_CHAR(Іnview));

       -- видалення даних з таблиці по USER_ID
    BEGIN
       DELETE FROM TSEL023
             WHERE US_ID =
                      (SELECT SYS_CONTEXT ('bars_global', 'user_id') FROM DUAL);
       COMMIT;
    END;

    BEGIN
       EXECUTE IMMEDIATE 'insert into TSEL023 ' || sSql;
    END;
      COMMIT;

     l_tabn:=Іnview;

     FOR T IN (SELECT tabn FROM TSEL023  WHERE US_ID = (SELECT SYS_CONTEXT ('bars_global', 'user_id') FROM DUAL))
        LOOP
            UPDATE TSEL023
               SET tabn = l_tabn;
        END LOOP;
     COMMIT;
    END IF;

end;
PROCEDURE PAY_PEREKR023(
               tt_     CHAR,   --код операції
               vob_    NUMBER, --код документу
               nd_     VARCHAR2, --ID запису nd_
               pdat_   DATE DEFAULT SYSDATE, --pdat_=> SYSDATE
               vdat_   DATE DEFAULT SYSDATE, --vdat_=> gl.BDATE
               dk_     NUMBER, --dk передаємо
               kv_     NUMBER,  ---KVA
               s_      NUMBER, --SUMA
               kv2_    NUMBER, ---KVB
               s2_     NUMBER, ---еквівалент SUMA, оскільки грн основна сума, передаємо просто SUMA
               sk_     NUMBER, --симол кас плана NULL
               nam_a_  VARCHAR2, --назва рахунку NMS
               nlsa_   VARCHAR2, --NLSA
               nam_b_  VARCHAR2, --NMKB
               nlsb_   VARCHAR2, --NLSB
               mfob_   VARCHAR2, --MFOB
               nazn_   VARCHAR2, --NAZN
               id_a_   VARCHAR2, --OKPOA
               id_b_   VARCHAR2, --OKPOB
               id_o_   VARCHAR2, --id_o_ => null
               sign_   RAW,      --sign_=> null
               sos_    NUMBER,     -- Doc status sos_=> 1
               prty_   NUMBER,     -- Doc priority prty_=> null
               uid_    NUMBER DEFAULT NULL,
               d_rec_  VARCHAR2,
               id_     NUMBER,
               Tabn_   VARCHAR2
               )

IS
/*****************
--01.03.2017 Дадано видалення стрічок з таблиці TSEL023, які були оплачені.
*********************/
REF_    number ; --референс
data_   DATE ; --data_=> gl.BDATE,
datp_   DATE ; --datp_=> gl.bdate,
mfoa    number;
l_tabn  varchar2(10);

BEGIN
data_:=gl.BDATE;
datp_:=gl.bdate;
mfoa:=gl.amfo;

            IF S_> 0 THEN
                     gl.REF(REF_);
                     gl.in_doc3
                      (ref_  => REF_,   tt_   => tt_  , vob_ => vob_  , nd_  => TO_CHAR (REF_),  pdat_=> pdat_ , vdat_=> gl.BDATE,  dk_=> dk_,
                       kv_   => kv_,   s_    => S_*100   , kv2_ => kv2_, s2_  => S_*100,   sk_ => sk_, data_=> data_ , datp_=> datp_ ,
                       nam_a_=> nam_a_,  nlsa_ => nlsa_ , mfoa_=> mfoa,
                       nam_b_=> nam_b_, nlsb_ => nlsb_, mfob_=> mfob_ , nazn_ => nazn_,
                       d_rec_=> d_rec_  , id_a_ => id_a_, id_b_=> id_b_ , id_o_ => id_o_, sign_=> sign_, sos_=> sos_, prty_=> prty_, uid_=> uid_);

                     paytt (0, REF_,  gl.bDATE, TT_, DK_, kv_, nlsa_, S_*100, kv2_, nlsb_, S_*100  );
            end if;

            execute immediate '
            UPDATE '||tabn_||'
             SET (ref,sos)=(SELECT ref,(CASE
                                            WHEN dk IN (0,1) THEN sos
                                            ELSE 1
                                            END) FROM oper
                            WHERE ref='||ref_||') WHERE id= '||id_;

          -- видаляємо стрічки які оплачені
          if ref_ is not null then
                           begin
                           logger.info ('SPS023: ' || ref_);

                           delete from TSEL023 t
                           where  T.NLSA=nlsa_
                              and T.OKPOA = id_a_
                              and T.KVA= kv_

                              and T.NLSB=nlsb_
                              and T.MFOB=mfob_
                              and T.OKPOB=id_b_
                              and T.KVB=kv2_

                              and t.tt=tt_
                              and t.dk=dk_

                              and T.S=S_*100
                              and t.nazn like nazn_

                              and t.us_id=sys_context('bars_global','user_id');
                              -----------------------
                              if sql%rowcount=0 then  begin
                                                          logger.info ('SPS023 стрічку не видалено, реф: '||ref_);
                                                          logger.info ('SPS023: NLSA:  ' ||nlsa_||' NLSB: '||nlsb_||' ОКПО А: '||id_a_||' ID користувача: '||sys_context('bars_global','user_id')||'Сума:  '||S_||'Операція: '||tt_||'NAZN: '||nazn_);
                                                      end;
                              end if;
                           commit;
                           end;

    end if;

END;

--процедура оплати груп рахунків (для технологів)
procedure pay_some_perekr (p_union_id number)
is
/*
02.04.2018 - для таблиці SPS_GROUP_RU додано колонку ID
для черговості виконання розрахунків перекриття по групам
(н-д: треба щоб спочатку виконалося перекриття по 104 групі, 
а потім по 105 групі в межах одного МФО. В таблицю пропишемо наступне:
1/104/322669/1
2/105/322669/1)
21.02.2018:
в таблицю SPS_GROUP_RU внесено додаткове
поле UNION_ID (номер об'єднання груп) для виконання
того чи іншого об'єднання груп перегриттів відповідно
до потреб. Наразі будемо використовувати два значення
об'єднання груп 1 і 2, для технологів рознесемо
виконання на окремі функції 1 буде виконуватися перед
закриття дня інша раніше. (запуски функції: sps.pay_some_perekr(1),
sps.pay_some_perekr(2))
20.02.2018:
http://jira.unity-bars.com:11000/browse/COBUMMFO-5368
процедура виконується технологами в кінці робочого дня
для чітко визначених груп рахунків та РУ (SPS_GROUP_RU)
Представляється кожним РУ з довідника - проводить розрахунок
сум для відповідних груп - оплачує документи.
В процесі виконання процедури ведеться лог роботи, записується
в SPS_GR_PROTOCOL, дані витираються через 7 днів
----exec bars_login.login_user('******',1,'','');
*/
l_branch    varchar2(8);
l           number;
l_date      date;
l_err       varchar2(4000);
l_union_id  number;

begin
 --bc.home; --прибрати при відправці в прод
 l_branch:= sys_context('bars_context', 'user_branch');
 -- перевірка чи функція запускається з рівня /
  if l_branch <> '/' then  RAISE_APPLICATION_ERROR (-20000,' Перейдіть на бранч /  '); end if ;
 l_union_id:=p_union_id;
 for c in (select distinct ru from SPS_GROUP_RU) --цикл по РУ, які прописані в довіднику
  loop
    bc.go( c.ru ); --представлення відділенням
     --прохід по всім групам відповідно до МФО РУ
     for k in (select group_sps from SPS_GROUP_RU where ru = c.ru and union_id = l_union_id order by id )
       loop
        insert into SPS_GR_PROTOCOL (RU, GROUP_SPS, MESSAGE) values (c.ru, k.group_sps, 'SPS: Розрахунок для RU: ' ||c.ru||' та GROUP_RU: '|| k.group_sps); --log
        --DBMS_OUTPUT.PUT_LINE('SPS: Розрахунок для RU: ' ||c.ru||' та GROUP_RU: '|| k.group_sps);
        logger.info('SPS: Розрахунок для RU: ' ||c.ru||' та GROUP_RU: '|| k.group_sps);
        --перевірка чи існує група на рівні РУ, яку прописали в довіднику
        begin
        select 1 into l from PEREKR_G where idg = k.group_sps;
         exception when no_data_found then begin
                                            logger.info ('SPS: Заданої групи: '||k.group_sps||' не існує на рівні МФО: '||c.ru);
                                            insert into SPS_GR_PROTOCOL (RU, GROUP_SPS, MESSAGE) values (c.ru, k.group_sps, 'SPS: Заданої групи: '||k.group_sps||' не існує на рівні МФО: '||c.ru); --log
                                            end;
          continue; --якщо групи не має, пишемо запис в sec_audit і пропускаємо ітерацію
        end;
        --формування перекриття
        SPS.SEL015(11,k.group_sps,01,'A');
        --оплата кожної стрічки розрахунків
        for p in (select * from TSEL015 where us_id = sys_context('bars_global','user_id') )
          loop

              p.TT:= case when p.MFOA=p.MFOB  then 'PSG'
                          when p.MFOA<>p.MFOB then 'PS5'
                          else p.TT
                     end;
              --оплата
              begin
               SPS.PAY_PEREKR (p.TT,p.VOB,p.ID,SYSDATE,SYSDATE,p.DK,p.KVA,p.SUMA,p.KVB,p.SUMA,NULL,p.MFOA,p.NMS,p.NLSA,p.NMKB,p.NLSB,p.MFOB,p.NAZN,p.OKPOA,p.OKPOB,NULL,NULL,1,NULL,NULL,p.KOEF);
                if sqlcode = 0 then
                         insert into SPS_GR_PROTOCOL (RU, GROUP_SPS, MESSAGE) values (c.ru, k.group_sps, 'SPS: Розрахунок для RU: ' ||c.ru||' та GROUP_RU: '|| k.group_sps||' - OK!');
                end if;
               exception when others then
                l_err:=sqlerrm;
                insert into SPS_GR_PROTOCOL (RU, GROUP_SPS, MESSAGE) values (c.ru, k.group_sps, 'SPS: '||l_err); --log
                l_err:='SPS: NLSA: '||p.NLSA||' MFOA: '||p.MFOA||' KVA: '||p.KVA||' SUMA: '||p.SUMA/100||' NLSB: '||p.NLSB||' MFOB: '||p.MFOB||' KVB: '||p.KVB;
                insert into SPS_GR_PROTOCOL (RU, GROUP_SPS, MESSAGE) values (c.ru, k.group_sps,l_err ); --log
              end;
          end loop; --цикл по платежах
       end loop; --цикл по групах рахунків
  end loop; --цикл по МФО
  bc.home; --вертаємся на "/"
  --видалення протоколів роботи функції старших 7 днів
  select max(trunc(time_sps)) into l_date from SPS_GR_PROTOCOL;
  delete SPS_GR_PROTOCOL where trunc(time_sps) < l_date -7;
  commit;
  -----
end;

end sps;
/

show err;
 
PROMPT *** Create  grants  SPS ***

grant EXECUTE                                                                on SPS             to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SPS             to START1;

 
 
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/package/sps.sql =========*** End *** =======
PROMPT ===================================================================================== 
 