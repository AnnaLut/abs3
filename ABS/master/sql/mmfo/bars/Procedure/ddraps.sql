
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/procedure/ddraps.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PROCEDURE BARS.DDRAPS 
( dat_    in      DATE
, mode_   in      SMALLINT DEFAULT 0
) IS
  /**
  <b>CREATE_DAILY_SNAPSHOT</b> - процедура створення денних знімків балансу
  %param

  %version 2.3 (06.03.2018)
  %usage   створення денних знімків балансу.
  */
  cursor cur_vp_list
  (
   p_dat in date,
   p_kf  in varchar2
  )
  is
   SELECT /*+ LEADING(vp b0) FULL(vp) INDEX(b1 UK_SNAP_BALANCES_EXCHANGE) */
          vp.acc3800, (SELECT nls||'/'||LPAD(kv,3,'0') FROM accounts WHERE acc=acc3800) nls3800,
          vp.acc3801, (SELECT RPAD(nls,14)||nms        FROM accounts WHERE acc=acc3801) nls3801,
          vp.acc6204, (SELECT RPAD(nls,14)||nms        FROM accounts WHERE acc=acc6204) nls6204
        , CASE WHEN b0.ostq+NVL(b1.ostq,0)>0 THEN 1 ELSE 0 END as DK
        , b0.RNK, b0.KF
        , ABS(b0.ostq+NVL(b1.ostq,0)) as S
     FROM VP_LIST vp
     JOIN SNAP_BALANCES_INTR_TBL b0
       on ( b0.FDAT = p_dat  and b0.KF = vp.KF  and b0.ACC = vp.ACC3800 )
     left
     join SNAP_BALANCES_INTR_TBL b1
       on ( b1.FDAT = b0.FDAT and b1.KF = b0.KF and b1.ACC = vp.ACC3801 )
    WHERE vp.KF = p_kf
      AND b0.ostq + NVL(b1.ostq,0) <> 0;

  type t_vp_list is table of cur_vp_list%rowtype index by pls_integer;
  v    t_vp_list;

  type t_oper is table of oper%rowtype index by pls_integer;
  oper_tab t_oper;


  c_limit           constant pls_integer := 10e3;
  l_errmsg          varchar2(500);

  dat#              DATE;
  l_mode            SMALLINT := mode_;

  l_pvp_uid         NUMBER(38);
  uid#              NUMBER := gl.aUID;
  l_bank_dt         DATE   := gl.bDATE;

  dlta_             accounts.ostc%type;
  ost1_             accounts.ostc%type;
  ost2_             accounts.ostc%type;
  dosq_             accounts.dos%type;
  kosq_             accounts.kos%type;

  --l_acc             accounts.acc%type;
  l_ref             NUMBER;
  l_allowed_dt      DATE; -- Дата раніше якої заборонено формування
  l_kf              snap_balances.kf%type;
  l_condition       varchar2(200);

  x                 SYS_REFCURSOR;
  l_cur_scn         NUMBER;
  -- тип для вичитки вхідних даних
  TYPE imp_rec IS RECORD( kf    char(6)
                        , acc   NUMBER
                        , rnk   NUMBER
                        , nbs   VARCHAR2(4)
                        , nls   VARCHAR2(15)
                        , kv    SMALLINT
                        , tip   VARCHAR2(3)
                        , ostf  NUMBER(24)
                        , dos   NUMBER(24)
                        , kos   NUMBER(24) );

  type imp_rec_tab is table of imp_rec index by pls_integer;
  c imp_rec_tab;

  -- тип для накопления вставки простых счетов
  type snap_balance_tab is table of snap_balances_intr_tbl%rowtype index by pls_integer;

  l_snap_balance snap_balance_tab;
  -- счетчик для накопления вставки простых счетов
  l_sb pls_integer := 0; -- counter for l_snap_balance

  -- типы для накопления вешалок в Нових драпсах
  TYPE ves_rec IS RECORD( kf   char(6),
                          acc  NUMBER,     rnk  NUMBER,
                          ost  NUMBER(24), dos  NUMBER(24), kos  NUMBER(24),
                          ost0 NUMBER(24), dos0 NUMBER(24), kos0 NUMBER(24),
                          ostq NUMBER(24), dosq NUMBER(24), kosq NUMBER(24)
                         );
  TYPE ves_tab IS TABLE OF ves_rec INDEX BY BINARY_INTEGER;

  ves  ves_tab;
  i                   BINARY_INTEGER;

  -- Вирахування еквівалентів
  TYPE rat_rec IS RECORD( dig  SMALLINT
                        , rat1 NUMBER
                        , rat2 NUMBER );
  TYPE rat_tab IS TABLE OF rat_rec INDEX BY BINARY_INTEGER;
  q    rat_tab;

  -- Ініціалізація курсів по даті
  PROCEDURE get_rat(dat_ DATE)
  IS
  BEGIN
     FOR x IN ( select kv, dig
                     , ( SELECT rate_o/bsum
                           FROM cur_rates
                          WHERE ( kv,vdate ) = ( SELECT kv,MAX(vdate) FROM cur_rates WHERE vdate <  dat_ AND kv = t.kv GROUP BY kv )
                       ) rat1
                     , ( SELECT rate_o/bsum
                           FROM cur_rates
                          WHERE ( kv,vdate ) = ( SELECT kv,MAX(vdate) FROM cur_rates WHERE vdate <= dat_ AND kv = t.kv GROUP BY kv )
                       ) rat2
           from TABVAL$GLOBAL t )
     LOOP
        q(x.kv).dig := x.dig;
        q(x.kv).rat1 := NVL(x.rat1,0);
        q(x.kv).rat2 := NVL(x.rat2,0);
     END LOOP;
  END;

  -- Еквівалент по курсу1
  FUNCTION eqv1
  ( kv_    SMALLINT
  , s_     NUMBER
  ) RETURN NUMBER
  IS
    s NUMBER;
  BEGIN
    s := ROUND(q(kv_).rat1*s_*POWER(10,2-q(kv_).dig));
    RETURN CASE s WHEN 0 THEN SIGN(s_) ELSE s END;
  END;

  -- Еквівалент по курсу2
  FUNCTION eqv2
  ( kv_    SMALLINT
  , s_     NUMBER
  ) RETURN NUMBER
  IS
    s NUMBER;
  BEGIN
    s := ROUND(q(kv_).rat2*s_*POWER(10,2-q(kv_).dig));
    RETURN CASE s WHEN 0 THEN SIGN(s_) ELSE s END;
  END;

  procedure p_exception
  (
   ip_text in varchar2
  )
  as
  begin
    raise_application_error( -20666, ip_text );
  end p_exception;

  procedure p_oper_tab_add
  (
   p_ix in pls_integer
  )
  as
  begin
    oper_tab(p_ix).REF    := l_ref;
    oper_tab(p_ix).TT     := 'PVP';
    oper_tab(p_ix).VOB    := 6;
    oper_tab(p_ix).ND     := SubStr(l_ref,-10);
    oper_tab(p_ix).DK     := v(p_ix).dk;
    oper_tab(p_ix).PDAT   := SYSDATE;
    oper_tab(p_ix).VDAT   := dat_;
    oper_tab(p_ix).DATD   := dat_;
    oper_tab(p_ix).USERID := l_pvp_uid;
    oper_tab(p_ix).MFOA   := gl.aMFO;
    oper_tab(p_ix).NLSA   := TRIM(SUBSTR(v(p_ix).nls3801,1,14));
    oper_tab(p_ix).NAM_A  := SUBSTR(v(p_ix).nls3801,15,38);
    oper_tab(p_ix).KV     := 980;
    oper_tab(p_ix).S      := v(p_ix).s;
    oper_tab(p_ix).ID_A   := gl.aOKPO;
    oper_tab(p_ix).MFOB   := gl.aMFO;
    oper_tab(p_ix).NLSB   := TRIM(SUBSTR(v(p_ix).nls6204,1,14));
    oper_tab(p_ix).NAM_B  := SUBSTR(v(p_ix).nls6204,15,38);
    oper_tab(p_ix).KV2    := 980;
    oper_tab(p_ix).S2     := v(p_ix).s;
    oper_tab(p_ix).ID_B   := gl.aOKPO;
    oper_tab(p_ix).NAZN   := 'Переоцінка валютної позиції '||v(p_ix).nls3800;
    oper_tab(p_ix).BRANCH := null;
    oper_tab(p_ix).TOBO   := null;
    oper_tab(p_ix).KF     := v(p_ix).KF;
  end p_oper_tab_add;

  procedure p_oper_tab_insert
  as
  begin
   forall idx in indices of oper_tab
    insert
      into OPER
      ( REF
       ,TT
       ,VOB
       ,ND
       ,DK
       ,PDAT
       ,VDAT
       ,DATD
       ,USERID
       ,MFOA
       ,NLSA
       ,NAM_A
       ,KV
       ,S
       ,ID_A
       ,MFOB
       ,NLSB
       ,NAM_B
       ,KV2
       ,S2
       ,ID_B
       ,NAZN
       ,BRANCH
       ,TOBO
       ,KF )
    VALUES
       ( oper_tab(idx).REF
        ,oper_tab(idx).TT
        ,oper_tab(idx).VOB
        ,oper_tab(idx).ND
        ,oper_tab(idx).DK
        ,oper_tab(idx).PDAT
        ,oper_tab(idx).VDAT
        ,oper_tab(idx).DATD
        ,oper_tab(idx).USERID
        ,oper_tab(idx).MFOA
        ,oper_tab(idx).NLSA
        ,oper_tab(idx).NAM_A
        ,oper_tab(idx).KV
        ,oper_tab(idx).S
        ,oper_tab(idx).ID_A
        ,oper_tab(idx).MFOB
        ,oper_tab(idx).NLSB
        ,oper_tab(idx).NAM_B
        ,oper_tab(idx).KV2
        ,oper_tab(idx).S2
        ,oper_tab(idx).ID_B
        ,oper_tab(idx).NAZN
        ,oper_tab(idx).BRANCH
        ,oper_tab(idx).TOBO
        ,oper_tab(idx).KF );
   end p_oper_tab_insert;

   procedure p_snap_balance_insert
   as
   begin
     forall idx in 1..l_snap_balance.count
      insert
      into SNAP_BALANCES_INTR_TBL
         ( FDAT, KF, ACC, RNK, OST, DOS, KOS, OSTQ, DOSQ, KOSQ )
      values
         (
          l_snap_balance(idx).FDAT
         ,l_snap_balance(idx).KF
         ,l_snap_balance(idx).ACC
         ,l_snap_balance(idx).RNK
         ,l_snap_balance(idx).OST
         ,l_snap_balance(idx).DOS
         ,l_snap_balance(idx).KOS
         ,l_snap_balance(idx).OSTQ
         ,l_snap_balance(idx).DOSQ
         ,l_snap_balance(idx).KOSQ
        );
      l_sb := 0;
      l_snap_balance.delete;
   end p_snap_balance_insert;

   procedure p_snap_balance_add
    (
     p_idx in pls_integer,
     p_vdk in pls_integer,
     p_acc in integer
    )
    as
    begin
      l_sb := l_sb + 1;
      l_snap_balance(l_sb).FDAT := dat_;
      l_snap_balance(l_sb).KF   := v(p_idx).KF;
      l_snap_balance(l_sb).ACC  := p_acc;
      l_snap_balance(l_sb).RNK  := v(p_idx).rnk;
      l_snap_balance(l_sb).OST  := CASE WHEN p_vdk = 1 THEN 0-v(p_idx).s ELSE v(p_idx).s END;
      l_snap_balance(l_sb).DOS  := CASE WHEN p_vdk = 1 THEN v(p_idx).s   ELSE 0          END;
      l_snap_balance(l_sb).KOS  := CASE WHEN p_vdk = 1 THEN 0            ELSE v(p_idx).s END;
      l_snap_balance(l_sb).OSTQ := CASE WHEN p_vdk = 1 THEN 0-v(p_idx).s ELSE v(p_idx).s END;
      l_snap_balance(l_sb).DOSQ := CASE WHEN p_vdk = 1 THEN v(p_idx).s   ELSE 0          END;
      l_snap_balance(l_sb).KOSQ := CASE WHEN p_vdk = 1 THEN 0            ELSE v(p_idx).s END;
    end p_snap_balance_add;

BEGIN

  BARS_AUDIT.INFO( $$PLSQL_UNIT||': Start running with (dat_='||to_char(dat_,'dd.mm.yyyy')||', mode_='||to_char(mode_)||').' );

  IF ( sys_context('bars_global','application_name') = 'BARSWEB_JOBS' )
  THEN -- При запуску з ВЕБ формування драпсів не виконуємо (мовчки)
    RETURN;
  END IF;

  if ( dat_ Is Null )
  then
    p_exception('Не вказано дату для формування знімку!' );
  end if;

  l_kf := sys_context('bars_context','user_mfo');

  if ( l_kf Is Null )
  then
    p_exception('Не вказано МФО ( l_kf Is Null ) для формування знімку!' );
  end if;

  begin

    select to_date(val,'DDMMYYYY')
      into l_allowed_dt
      from PARAMS
     where PAR = 'DATRAPS';

    if ( l_allowed_dt > dat_ )
    then
      p_exception('Заборонено формування знімків за дату меншу ніж '||to_char(l_allowed_dt,'dd.mm.yyyy') );
    end if;

  exception
    when NO_DATA_FOUND then
      NULL;
  end;

  -- Перевірка на операційну дату
  begin
    select FDAT
      into l_allowed_dt
      from FDAT
     where FDAT = dat_;
  exception
    when NO_DATA_FOUND then
     p_exception('Заборонено формування знімків за неопераційну дату '||to_char(dat_,'dd.mm.yyyy') );
  end;

  -- Перевірка наявності активного процесу формування знімку
  l_errmsg := BARS_UTL_SNAPSHOT.CHECK_SNP_RUNNING( 'DAYBALS', l_kf );

  if (l_errmsg is Not Null)
  then
    p_exception('формування денного знімку балансу вже запущено користувачем ' || l_errmsg );
  else -- Блокування від декількох запусків
    BARS_UTL_SNAPSHOT.SET_RUNNING_FLAG( 'DAYBALS' );
  end if;

  dbms_application_info.set_client_info( 'Формування денного знімку балансу для '||l_kf||' за ' || F_MONTH_LIT(dat_,0,0) );

  -- Отримати дату попередніх драпсів для прискореного режиму mode=1
  IF ( l_mode = 1 )
  THEN

    SELECT MAX(FDAT)
      INTO dat#
      FROM FDAT
     WHERE FDAT < dat_;

    l_mode := CASE WHEN dat# IS NULL THEN 0 ELSE 1 END;

  END IF;

  bars_audit.info( $$PLSQL_UNIT||': l_kf='||l_kf||', dat#='||to_char(dat#,'dd.mm.yyyy')||', mode='||to_char(l_mode)||'.' );

  -- Превентивно доплатити пакетні проводки
  GL.PAYSOS0;
  commit;

  bars_audit.trace( $$PLSQL_UNIT||': gl.paysos0 -> Ok.' );

  pkg_ddl.p_partition_truncate('SNAP_BALANCES_INTR_TBL','P_'||l_kf);

  l_condition := q'[ (to_date('%dt','ddmmyyyy'),'%kf') ]';
  l_condition := replace( l_condition, '%dt', to_char(dat_,'ddmmyyyy') );
  l_condition := replace( l_condition, '%kf', l_kf );

  if ( dat_ < GL.GBD() )
  then
    pkg_ddl.p_subpartition_for_lock(ip_table => 'SALDOA',ip_for => l_condition);--???
    bars_audit.info( $$PLSQL_UNIT||': SALDOA subpartition locked.' );
  end if;

  -- Вибрати підходящий курсор
  IF ( l_mode = 0 )
  THEN
    OPEN x FOR
        select /*+ NO_PARALLEL FULL(a) */ a.KF
              ,a.acc, a.rnk, a.nbs, a.nls, a.kv, a.tip
              ,NVL(s.ostf,0) ostf
              ,NVL(s.dos, 0) dos
              ,NVL(s.kos, 0) kos
           from ACCOUNTS a
           left
           join ( SELECT sa1.KF,
                         sa1.ACC,
                         DECODE(sa1.fdat, dat_, sa1.ostf, sa1.OSTF-sa1.DOS+sa1.KOS) ostf,
                         DECODE(sa1.fdat, dat_, sa1.dos, 0) dos,
                         DECODE(sa1.fdat, dat_, sa1.kos, 0) kos
                    FROM saldoa sa1,
                        ( select ACC, max(FDAT) as FDAT
                            from SALDOA
                           where FDAT <= dat_
                             and KF = l_kf
                           group by ACC
                        ) sa2
                   WHERE sa1.fdat = sa2.fdat
                     AND sa1.acc  = sa2.acc
                     AND sa1.kf = l_kf
                ) s
             on ( s.KF = a.KF and s.ACC = a.ACC )
          WHERE a.KF = l_kf
            and a.DAOS <= dat_
            AND ( a.dazs is null OR a.dazs >= dat_ );

  ELSE -- ( l_mode = 1 )

    OPEN x FOR
           SELECT a.KF, a.acc, a.rnk, a.nbs, a.nls, a.kv, a.tip
                , NVL(s.ostf,0) OSTF
                , NVL(s.dos, 0) DOS
                , NVL(s.kos, 0) KOS
            from ACCOUNTS a
            left
            join ( select nvl(c.KF,   b.KF ) as KF,
                          NVL(c.acc,  b.acc) as ACC,
                          NVL(c.ostf, b.ost) as OSTF,
                          NVL(c.dos,  0    ) as DOS,
                          NVL(c.kos,  0    ) as KOS
                     from ( select *
                              from SNAP_BALANCES
                             where FDAT = dat#
                               and KF   = l_kf
                          ) b
                     full
                     join ( select *
                              from SALDOA
                             where FDAT = dat_
                               and KF   = l_kf
                          ) c
                       on ( c.KF = b.KF and c.ACC = b.ACC )
                ) s
             on ( s.KF = a.KF and s.ACC = a.ACC )
            WHERE a.KF = l_kf
              and a.DAOS <= dat_
              and ( a.dazs is null OR a.dazs >= dat_ );

  END IF;

  GET_RAT(dat_);

  LOOP

    FETCH x bulk collect INTO c limit c_limit;
    EXIT WHEN c.count = 0;

    -- Вычисление эквивалента остатка и оборoтов
    for idx in 1..c.count
    loop
      IF ( c(idx).kv = 980 )
      THEN
        ost1_ := c(idx).ostf;
        dosq_ := c(idx).dos;
        kosq_ := c(idx).kos;
      ELSE
        ost1_ := eqv1 (c(idx).kv, c(idx).ostf);
        ost2_ := eqv2 (c(idx).kv, c(idx).ostf - c(idx).dos + c(idx).kos);
        dosq_ := eqv2 (c(idx).kv, c(idx).dos);
        kosq_ := eqv2 (c(idx).kv, c(idx).kos);

        dlta_ := ost2_ - (ost1_ - dosq_ + kosq_);

        IF dlta_ < 0 THEN
           dosq_ := dosq_ - dlta_;
        ELSE
           kosq_ := kosq_ + dlta_;
        END IF;

      END IF;

        -- Опеределение номера вешалки
        i := CASE
               WHEN c(idx).nbs BETWEEN '1000' and '7999'
               THEN c(idx).kv*10+1
               WHEN c(idx).nbs BETWEEN '9000' and '9599' OR c(idx).nbs IN ('9900','9920')
               THEN c(idx).kv*10+2
               WHEN c(idx).nbs BETWEEN '9600' and '9899' OR c(idx).nbs ='9910'
               THEN c(idx).kv*10+3 ELSE 9999
             END;

        -- Накопление вешалок
        IF ves.EXISTS(i)
        THEN
           ves(i).ostq:=ves(i).ostq - (ost1_-dosq_+kosq_);
           ves(i).dosq:=ves(i).dosq + kosq_;
           ves(i).kosq:=ves(i).kosq + dosq_;
        ELSE
           ves(i).ostq:= - (ost1_-dosq_+kosq_);
           ves(i).dosq:= kosq_;
           ves(i).kosq:= dosq_;
        END IF;

    -- Запомнить счет вешалки (tip VE1-3)
    IF c(idx).tip LIKE 'VE_'
    THEN
      ves(i).acc  := c(idx).acc;
      ves(i).kf   := c(idx).kf;
      ves(i).rnk  := c(idx).rnk;
      ves(i).ost  := c(idx).ostf-c(idx).dos+c(idx).kos;
      ves(i).dos  := c(idx).dos;
      ves(i).kos  := c(idx).kos;
      ves(i).ost0 := ost1_-dosq_+kosq_;
      ves(i).dos0 := dosq_;
      ves(i).kos0 := kosq_;
    ELSE
      -- накопление простых счетов
      l_sb := l_sb + 1;
      l_snap_balance(l_sb).FDAT := dat_                                  ;
      l_snap_balance(l_sb).KF   := c(idx).KF                             ;
      l_snap_balance(l_sb).ACC  := c(idx).acc                            ;
      l_snap_balance(l_sb).RNK  := c(idx).rnk                            ;
      l_snap_balance(l_sb).OST  := c(idx).ostf - c(idx).dos + c(idx).kos ;
      l_snap_balance(l_sb).DOS  := c(idx).dos                            ;
      l_snap_balance(l_sb).KOS  := c(idx).kos                            ;
      l_snap_balance(l_sb).OSTQ := ost1_ - dosq_ + kosq_                 ;
      l_snap_balance(l_sb).DOSQ := dosq_                                 ;
      l_snap_balance(l_sb).KOSQ := kosq_                                 ;
    END IF;

   end loop;
    -- вставка простых счетов
    p_snap_balance_insert;

  END LOOP; -- fetch

  -- Теперь повесить ошибки округления на вешалки4
  i := ves.FIRST;

  WHILE i IS NOT NULL
  LOOP
    IF i > 2 AND TRUNC(i/10) NOT IN (980,999)
             AND (ves(i).ost<>0  OR ves(i).dos<>0  OR ves(i).kos<>0  OR
                  ves(i).ost0<>0 OR ves(i).dos0<>0 OR ves(i).kos0<>0 OR
                  ves(i).ostq<>0 OR ves(i).dosq<>0 OR ves(i).kosq<>0)
    THEN
      IF ves(i).acc IS NOT NULL
      THEN
         l_sb := l_sb + 1;
         l_snap_balance(l_sb).FDAT := dat_;
         l_snap_balance(l_sb).KF   := ves(i).kf;
         l_snap_balance(l_sb).ACC  := ves(i).acc;
         l_snap_balance(l_sb).RNK  := ves(i).rnk;
         l_snap_balance(l_sb).OST  := ves(i).ost;
         l_snap_balance(l_sb).DOS  := ves(i).dos;
         l_snap_balance(l_sb).KOS  := ves(i).kos;
         l_snap_balance(l_sb).OSTQ := ves(i).ost0 + ves(i).ostq;
         l_snap_balance(l_sb).DOSQ := ves(i).dos0 + greatest(ves(i).dosq-ves(i).kosq,0);
         l_snap_balance(l_sb).KOSQ := ves(i).kos0 + greatest(ves(i).kosq-ves(i).dosq,0);
      ELSE
        p_exception('Не знайдно рахунок "вішалки" VE'||MOD(i,10)||' для вал. '||TRUNC(i/10));
      END IF;
    END IF;
    i := ves.NEXT(i);
  END LOOP;

  -- cleanup collection
  ves.delete;
  -- вставка вешалок
  p_snap_balance_insert;

   --
  -- переоцінка валютних позицій (коригуючі проводки + корекція даних в AGG_MONBALS_EXCHANGE)
  -- BARS_SNAPSHOT.DAILY_CURRENCY_REVALUATION;
  --

  -- Код юзера для проведень переоцінки ВП
  begin
    select trim(VAL)
      into l_pvp_uid
      from PARAMS
     where PAR = 'PVPUSER';
  exception
    when NO_DATA_FOUND then
      l_pvp_uid := gl.aUID;
  end;

  if ( dat_ = DAT_NEXT_U( GL.GBD(), -1 ) )
  then --
    gl.bDATE := dat_;
  else --
    GL.PL_DAT( dat_ );
  end if;

  gl.aUID := l_pvp_uid;

  open cur_vp_list(dat_,l_kf);

  LOOP
    fetch cur_vp_list bulk collect into v limit c_limit;
    exit when  v.count = 0;


   -- init
   l_sb := 0;

    for idx in 1..v.count
    loop
      bars_audit.trace( $$PLSQL_UNIT||': ВП '||v(idx).nls3800||', DK='||v(idx).DK||', S='||v(idx).s );
      GL.REF( l_ref );
      GL.PAYV( 1, l_ref, dat_, 'PVP', v(idx).dk
           , 980, TRIM(SUBSTR(v(idx).nls3801,1,14)), v(idx).s
           , 980, TRIM(SUBSTR(v(idx).nls6204,1,14)), v(idx).s );
      -- заполнение коллекции для oper;
      p_oper_tab_add(idx);
      -- заполнение коллекции для SNAP_BALANCES_INTR_TBL
      p_snap_balance_add(idx, v(idx).dk,   v(idx).acc3801);
      p_snap_balance_add(idx, 1-v(idx).dk, v(idx).acc6204);

    end loop;

    p_oper_tab_insert;
    -- cleanup collection after insert
    oper_tab.delete;

    -- merge SNAP_BALANCES_INTR_TBL
    forall idx in indices of l_snap_balance
    merge
    into SNAP_BALANCES_INTR_TBL m
    using (
           select l_snap_balance(idx).FDAT as FDAT
                 ,l_snap_balance(idx).KF   as KF
                 ,l_snap_balance(idx).ACC  as ACC
                 ,l_snap_balance(idx).RNK  as RNK
                 ,l_snap_balance(idx).OST  as OST
                 ,l_snap_balance(idx).OSTQ as OSTQ
                 ,l_snap_balance(idx).DOS  as DOS
                 ,l_snap_balance(idx).DOSQ as DOSQ
                 ,l_snap_balance(idx).KOS  as KOS
                 ,l_snap_balance(idx).KOSQ as KOSQ
           from dual
          ) s
    on ( m.FDAT = s.FDAT
         and m.KF   = s.KF
         and m.ACC  = s.ACC)
    when matched then
      update
         set m.OST  = m.OST   + s.OST
            ,m.OSTQ = m.OSTQ  + s.OSTQ
            ,m.DOS  = m.DOS   + s.DOS
            ,m.DOSQ = m.DOSQ  + s.DOSQ
            ,m.KOS  = m.KOS   + s.KOS
            ,m.KOSQ = m.KOSQ  + s.KOSQ
     when not matched then
       insert
         ( FDAT, KF, ACC, RNK, OST, DOS, KOS, OSTQ, DOSQ, KOSQ )
       values
         ( s.FDAT, s.KF, s.ACC, s.RNK, s.OST, s.DOS, s.KOS, s.OSTQ, s.DOSQ, s.KOSQ );
    -- cleanup collection
    l_snap_balance.delete;
  END LOOP;

  -- Back to
  GL.PL_DAT( l_bank_dt );

  gl.aUID  := uid#;

  q.delete;

  if ( dat_ = DAT_NEXT_U( GL.GBD(), -1 ) )
  then -- Доплата проводок переоцінки породжених при формуванні знімків балансу
    GL.OVERPAY_PVP;
  end if;

  COMMIT;

  -- Фіксуємо SCN , що був до формування знімку балансу для можливого відкату
  l_cur_scn := BARS_UTL_SNAPSHOT.GET_SNP_SCN(p_table => 'SALDOA', p_date  => dat_);
  -- Фіксуємо SCN на якому формуємо знімок балансу по табл. SALDOA
  BARS_UTL_SNAPSHOT.SET_TABLE_SCN( p_table => 'SALDOA'
                                 , p_date  => dat_
                                 , p_kf    => l_kf
                                 , p_scn   => DM_UTL.GET_LAST_SCN( 'SNAP_BALANCES_INTR_TBL', 'BARS', null, l_kf ) );

  BARS_AUDIT.INFO( $$PLSQL_UNIT||': lock requested.' );

  if ( DBMS_LOCK.REQUEST( to_number( l_kf ), dbms_lock.x_mode, 600, FALSE ) = 0 )
  then

    BARS_AUDIT.INFO( $$PLSQL_UNIT||': lock acquired.' );

    pkg_ddl.p_table_truncate('SNAP_BALANCES_EXCHANGE');

    -- bypass the RLS policies
    DM_UTL.EXCHANGE_PARTITION( p_source_table_nm => 'SNAP_BALANCES_EXCHANGE'
                             , p_target_table_nm => 'SNAP_BALANCES_INTR_TBL'
                             , p_partition_nm    => 'P_'||l_kf
                             , p_novalidate      => true );

    -- bypass the RLS policies
    DM_UTL.EXCHANGE_SUBPARTITION_FOR( p_source_table_nm => 'SNAP_BALANCES_EXCHANGE'
                                    , p_target_table_nm => 'SNAP_BALANCES'
                                    , p_condition       => l_condition );

    if ( DBMS_LOCK.RELEASE( to_number( l_kf ) ) = 0 )
    then
      BARS_AUDIT.INFO( $$PLSQL_UNIT||': lock released.' );
    end if;

  else
    BARS_AUDIT.INFO( $$PLSQL_UNIT||': lock was not acquired.' );
  end if;

  BARS_UTL_SNAPSHOT.PURGE_RUNNING_FLAG();

  BARS_AUDIT.INFO( $$PLSQL_UNIT||': Exit.' );

EXCEPTION
  WHEN OTHERS THEN
    -- Back to
    if l_cur_scn is not null then
        -- відкочуємо зміни по збереженим SCN
        BARS_UTL_SNAPSHOT.SET_TABLE_SCN( p_table => 'SALDOA'
                                     , p_date  => dat_
                                     , p_kf    => l_kf
                                     , p_scn   => l_cur_scn );
        commit;
    end if;

    GL.PL_DAT( l_bank_dt );
    gl.aUID  := uid#;
    BARS_UTL_SNAPSHOT.PURGE_RUNNING_FLAG();
    bars_audit.error( $$PLSQL_UNIT|| ': ' || dbms_utility.format_error_stack() ||
                                  chr(10) || dbms_utility.format_error_backtrace() );
    raise;
END DDRAPS;

/
 show err;
 
PROMPT *** Create  grants  DDRAPS ***
grant EXECUTE                                                                on DDRAPS          to BARSUPL;
grant EXECUTE                                                                on DDRAPS          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DDRAPS          to UPLD;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/procedure/ddraps.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 