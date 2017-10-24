

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DDRAPS_OLD.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DDRAPS_OLD ***

  CREATE OR REPLACE PROCEDURE BARS.DDRAPS_OLD (dat_ DATE, mode_ SMALLINT DEFAULT 0) IS
--
--  Версія 1 від 16.04.2015
--
   dat#  DATE;
   mod_  SMALLINT := mode_;

   t  NUMBER := dbms_utility.get_time;
   branch# VARCHAR2(30) := sys_context('bars_context','user_branch');
   sess_   varchar2(64) :=bars_login.get_session_clientid;
   sid_    varchar2(64);

   uid_    NUMBER;
   uid#    NUMBER       := gl.aUID;

   dlta_               accounts.ostc%type;
   ost1_               accounts.ostc%type;
   ost2_               accounts.ostc%type;
   dosq_               accounts.dos%type;
   kosq_               accounts.kos%type;

   acc_            NUMBER;
   ref_            NUMBER;
   dats_           DATE;    -- Дата раніше якої заборонено формування
   dat0_           DATE := gl.bDATE;

   x        SYS_REFCURSOR;

-- тип для вичитки вхідних даних
   TYPE imp_rec IS RECORD(acc NUMBER, rnk NUMBER, nbs VARCHAR2(4),
              nls VARCHAR2(15), kv SMALLINT,
              tip VARCHAR2(3), daos date, ostf NUMBER(24), dos NUMBER(24),kos NUMBER(24));
   c imp_rec;

-- типы для накопления вешалок в Нових драпсах
   TYPE ves_rec IS RECORD(acc NUMBER, rnk NUMBER,
          ost  NUMBER(24),dos  NUMBER(24),kos  NUMBER(24),
          ost0 NUMBER(24),dos0 NUMBER(24),kos0 NUMBER(24),
          ostq NUMBER(24),dosq NUMBER(24),kosq NUMBER(24));
   TYPE ves_tab IS TABLE OF ves_rec INDEX BY BINARY_INTEGER;

   ves  ves_tab;
   i                   BINARY_INTEGER;
-- Вирахування еквівалентів
   TYPE rat_rec IS RECORD(dig SMALLINT,rat1 NUMBER,rat2 NUMBER);
   TYPE rat_tab IS TABLE OF rat_rec INDEX BY BINARY_INTEGER;
   q    rat_tab;

-- Ініціалізація курсів по даті
   PROCEDURE get_rat(dat_ DATE) IS
   BEGIN
      FOR x IN (SELECT kv,dig,
        ( SELECT rate_o/bsum FROM cur_rates WHERE ( kv,vdate ) =
        ( SELECT kv,MAX(vdate) FROM cur_rates WHERE vdate <  dat_ AND kv = t.kv GROUP BY kv )) rat1,
        ( SELECT rate_o/bsum FROM cur_rates WHERE ( kv,vdate ) =
        ( SELECT kv,MAX(vdate) FROM cur_rates WHERE vdate <= dat_ AND kv = t.kv GROUP BY kv )) rat2
            FROM tabval t )
      LOOP
         q(x.kv).dig := x.dig;
         q(x.kv).rat1 := NVL(x.rat1,0);
         q(x.kv).rat2 := NVL(x.rat2,0);
      END LOOP;
   END;
-- Еквівалент по курсу1
   FUNCTION eqv1 (kv_ SMALLINT,s_ NUMBER) RETURN NUMBER IS
   s NUMBER;
   BEGIN
     s := ROUND(q(kv_).rat1*s_*POWER(10,2-q(kv_).dig));
     RETURN CASE s WHEN 0 THEN SIGN(s_) ELSE s END;
   END;
-- Еквівалент по курсу2
   FUNCTION eqv2 (kv_ SMALLINT,s_ NUMBER) RETURN NUMBER IS
   s NUMBER;
   BEGIN
     s := ROUND(q(kv_).rat2*s_*POWER(10,2-q(kv_).dig));
     RETURN CASE s WHEN 0 THEN SIGN(s_) ELSE s END;
   END;

BEGIN

-- При запуску з ВЕБ формування драпсів не виконуємо (мовчки)
   IF SYS_CONTEXT('bars_global', 'application_name') = 'BARSWEB_JOBS' THEN
      RETURN;
   END IF;

   begin
      SELECT TO_DATE(val,'DDMMYYYY') INTO dats_ FROM params WHERE par='DATRAPS';
      IF dats_-2< dat_ THEN
         raise_application_error(-20000,'Заборонено формування знімків > '||to_char(dats_,'dd.mm.yyyy'));
      END IF;
   exception when no_data_found then NULL;
   end;

-- Блокування від 2-х запусків
   SYS.DBMS_SESSION.CLEAR_IDENTIFIER;
   sid_:=SYS_CONTEXT('BARS_GLPARAM','SNPBAL2');
   SYS.DBMS_SESSION.SET_IDENTIFIER(sess_);

   begin
      select sid into sid_ from v$session
       where sid=sid_ and sid<>SYS_CONTEXT ('USERENV', 'SID');
      raise_application_error(-20000,'Знімок балансу вже формується SID '|| sid_);
   exception
      when no_data_found THEN NULL;
   end;

   gl.setp('SNPBAL2',SYS_CONTEXT ('USERENV', 'SID'),NULL);


-- Отримати дату попередніх драпсів для прискореного режиму mode=1

   IF mod_=1 THEN
      SELECT MAX(fdat) INTO dat# FROM fdat WHERE fdat < dat_;
      mod_:=CASE WHEN dat# IS NULL THEN 0 ELSE 1 END;
   END IF;

   bars_audit.info('DRAPS2: Start '||to_char(dat_,'dd.mm.yyyy'));
   bars_audit.info('DRAPS2: MODE='||mod_);

   get_rat(dat_);

   begin
      execute immediate 'alter table snap_balances drop partition for
          (to_date('''||TO_CHAR(dat_,'ddmmyyyy')||''',''DDMMYYYY''))';
   exception when others then
--    ORA-02149: Specified partition does not exist
      if sqlcode =-02149 then null; else raise; end if;
   end;


   bc.subst_mfo(gl.aMFO);
   gl.paysos0;
   commit;

   bars_audit.info('DRAPS2: Paysos0 Ok '||to_char(dat_,'dd.mm.yyyy'));

-- Вибрати підходящий курсор

   IF mod_=0 THEN

      OPEN x FOR
        'SELECT a.acc, a.rnk, a.nbs, a.nls, a.kv, a.tip, a.daos,
                NVL(s.ostf,0) ostf, NVL(s.dos,0) dos, NVL(s.kos,0) kos
           FROM accounts a,
               (SELECT sa1.acc,
                       DECODE (sa1.fdat, :1, sa1.ostf,
                               sa1.ostf-sa1.dos+sa1.kos) ostf,
                       DECODE (sa1.fdat, :1, sa1.dos, 0) dos,
                       DECODE (sa1.fdat, :1, sa1.kos, 0) kos
                  FROM saldoa sa1,
                      (SELECT acc, MAX (fdat) fdat
                         FROM saldoa
                        WHERE fdat <= :1
                        GROUP BY acc) sa2
                 WHERE sa1.fdat = sa2.fdat AND sa1.acc = sa2.acc ) s
          WHERE a.acc = s.acc(+)
            AND a.daos <= :1 AND a.nls not like ''8%''
            AND (a.dazs is null OR a.dazs >= :1)'
          USING dat_,dat_,dat_,dat_,dat_,dat_;

   ELSE  -- мод=1

        OPEN x FOR
          'SELECT a.acc, a.rnk, a.nbs, a.nls, a.kv, a.tip, a.daos,
                  NVL(s.ostf,0) ostf, NVL(s.dos,0) dos, NVL(s.kos,0) kos
            FROM accounts a,
                ( SELECT NVL(c.acc,b.acc) acc,
                         NVL(c.ostf, b.ost) ostf,
                         NVL(c.dos,0) dos,
                         NVL(c.kos,0) kos
                    FROM
                  ( select * from snap_balances where fdat=:1) b
                      full join
                  ( select * from saldoa where fdat=:2 ) c on c.acc=b.acc ) s
            WHERE a.acc = s.acc(+)
              AND a.daos <= :3 AND a.nbs not like ''8___''
              AND (a.dazs is null OR a.dazs >= :4)' USING dat#,dat_,dat_,dat_;
   END IF;

   LOOP
   FETCH x INTO c;
    EXIT WHEN x%NOTFOUND;

-- Вычисление эквивалента остатка и обортов

      IF c.kv=980 THEN
         ost1_:=c.ostf;
         dosq_:=c.dos;
         kosq_:=c.kos;
      ELSE
      /*
         ost1_ := eqv1 (c.kv, c.ostf);
         ost2_ := eqv2 (c.kv, c.ostf - c.dos + c.kos);
         dosq_ := eqv2 (c.kv, c.dos);
         kosq_ := eqv2 (c.kv, c.kos);
       */
                  begin
                     select decode(fdat,dat_,ostf,ostf-dos+kos),
                            decode(fdat, dat_,dos, 0),
                            decode(fdat, dat_, kos, 0)
                       into ost1_, dosq_, kosq_
                       from saldob_old
                     where acc = c.acc
                       and fdat in (select max(fdat) from saldob_old where acc = c.acc and fdat between c.daos and dat_);
                  EXCEPTION   WHEN NO_DATA_FOUND
                     THEN
                           ost1_ := 0;
                           dosq_ := 0;
                           kosq_ := 0;
                  end;


      END IF;


         IF c.ostf<>0 OR c.dos<>0 OR c.kos<>0
         OR  ost1_<>0 OR dosq_<>0 OR kosq_<>0  THEN
            insert into snap_balances -- вставка простых счетов
                   (fdat, acc, rnk, ost, dos, kos, ostq, dosq, kosq)
            VALUES (dat_,c.acc,c.rnk,c.ostf-c.dos+c.kos,c.dos,c.kos,
                                    ost1_-dosq_+kosq_,dosq_,kosq_);
        end if;

   END LOOP;


-- Кінець нових драпсів

   dbms_output.put_line('DRAPS2: '||TO_CHAR(dat_,'dd-mm-yyyy')||' Час A '|| to_char((dbms_utility.get_time-t)/100/60) );
   bars_audit.info('DRAPS2: Час A '|| to_char((dbms_utility.get_time-t)/100/60) );
   gl.setp('SNPBAL2','',NULL);
   COMMIT;

EXCEPTION WHEN OTHERS THEN

   gl.setp('SNPBAL2','',NULL);
   gl.bDATE:=dat0_;                           -- Back to
   gl.aUID :=uid#; bc.subst_branch(branch#);  -- my branch
   raise;

END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DDRAPS_OLD.sql =========*** End **
PROMPT ===================================================================================== 
