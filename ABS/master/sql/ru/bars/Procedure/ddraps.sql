

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DDRAPS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DDRAPS ***

  CREATE OR REPLACE PROCEDURE BARS.DDRAPS (dat_ DATE, mode_ SMALLINT DEFAULT 0) IS
--
-- Нові драпси
-- $Ver: 5.6.5106 2015-06-23 09:54:22Z michael.martseniuk draps.sql $
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
              tip VARCHAR2(3), ostf NUMBER(24), dos NUMBER(24),kos NUMBER(24));
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
      IF dats_>dat_ THEN
         raise_application_error(-20000,'Заборонено формування знімків раніше '||to_char(dats_,'dd.mm.yyyy'));
      END IF;
   exception when no_data_found then NULL;
   end;

-- Перевірка на операційну дату
   begin
      SELECT 0 INTO i FROM fdat WHERE fdat=dat_;
   exception when no_data_found then
      raise_application_error(-20000,'Заборонено формування знімків за неопераційну дату '||to_char(dat_,'dd.mm.yyyy'));
   end;

-- Блокування від 2-х запусків
   SYS.DBMS_SESSION.CLEAR_IDENTIFIER;
   sid_:=SYS_CONTEXT('BARS_GLPARAM','SNPBAL');
   SYS.DBMS_SESSION.SET_IDENTIFIER(sess_);

   begin
      select sid into sid_ from v$session
       where sid=sid_ and sid<>SYS_CONTEXT ('USERENV', 'SID');
      raise_application_error(-20000,'Знімок балансу вже формується SID '|| sid_);
   exception
      when no_data_found THEN NULL;
   end;

   gl.setp('SNPBAL',SYS_CONTEXT ('USERENV', 'SID'),NULL);

-- Отримати код юзера для проведень переоцінки ВП
   begin
      SELECT TRIM(val) INTO uid_ FROM params WHERE par='PVPUSER';
   exception when no_data_found then uid_:=gl.aUID;
   end;

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

-- Превентивно прибити переоцінку з цей день

--   FOR x IN (SELECT ref FROM oper WHERE tt='PVP' AND vdat=dat_ AND sos>0)
--   LOOP
--      gl.bck( x.ref, 9);
--   END LOOP;

--   bars_audit.info('DRAPS2: Back PVP Ok '||to_char(dat_,'dd.mm.yyyy'));

-- Превентивно доплатити пакетні проводки

   bc.subst_mfo(gl.aMFO);
   gl.paysos0;
   commit;

   bars_audit.info('DRAPS2: Paysos0 Ok '||to_char(dat_,'dd.mm.yyyy'));

-- Вибрати підходящий курсор

   IF mod_=0 THEN

      OPEN x FOR
        'SELECT a.acc, a.rnk, a.nbs, a.nls, a.kv, a.tip,
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
            AND a.daos <= :1
            AND (a.dazs is null OR a.dazs >= :1)'
          USING dat_,dat_,dat_,dat_,dat_,dat_;

 -- AND a.nbs not like ''8___''


   ELSE  -- мод=1

        OPEN x FOR
          'SELECT a.acc, a.rnk, a.nbs, a.nls, a.kv, a.tip,
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
              AND a.daos <= :3
              AND (a.dazs is null OR a.dazs >= :4)' USING dat#,dat_,dat_,dat_;
   END IF;

   dbms_application_info.set_client_info ('Формування денного знімку за '||TO_CHAR(dat_,'ddmmyyyy')||' mode_='||mode_);

   LOOP
   FETCH x INTO c;
    EXIT WHEN x%NOTFOUND;

-- Вычисление эквивалента остатка и обортов

      IF c.kv=980 THEN
         ost1_:=c.ostf;
         dosq_:=c.dos;
         kosq_:=c.kos;
      ELSE
         ost1_ := eqv1 (c.kv, c.ostf);
         ost2_ := eqv2 (c.kv, c.ostf - c.dos + c.kos);
         dosq_ := eqv2 (c.kv, c.dos);
         kosq_ := eqv2 (c.kv, c.kos);

         dlta_ := ost2_ - (ost1_ - dosq_ + kosq_);

         IF dlta_ < 0 THEN
            dosq_ := dosq_ - dlta_;
         ELSE
            kosq_ := kosq_ + dlta_;
         END IF;
      END IF;

-- Опеределение номера вешалки

      i := CASE WHEN c.nbs BETWEEN '1000' and '7999' THEN c.kv*10+1
                WHEN c.nbs BETWEEN '9000' and '9599' OR c.nbs IN ('9900','9920') THEN c.kv*10+2
                WHEN c.nbs BETWEEN '9600' and '9899' OR c.nbs ='9910' THEN c.kv*10+3 ELSE 9999 END;
-- Накопление вешалок
      IF ves.EXISTS(i) THEN
         ves(i).ostq:=ves(i).ostq - (ost1_-dosq_+kosq_);
         ves(i).dosq:=ves(i).dosq+kosq_;
         ves(i).kosq:=ves(i).kosq+dosq_;
      ELSE
         ves(i).ostq:= - (ost1_-dosq_+kosq_);
         ves(i).dosq:= kosq_;
         ves(i).kosq:= dosq_;
      END IF;

-- Запомнить счет вешалки (tip VE1-3)

      IF c.tip LIKE 'VE_' THEN
         ves(i).acc:=c.acc;
         ves(i).rnk:=c.rnk;
         ves(i).ost:=c.ostf-c.dos+c.kos;
         ves(i).dos:=c.dos;
         ves(i).kos:=c.kos;
         ves(i).ost0:=ost1_-dosq_+kosq_;
         ves(i).dos0:=dosq_;
         ves(i).kos0:=kosq_;
      ELSE
         IF c.ostf<>0 OR c.dos<>0 OR c.kos<>0
         OR  ost1_<>0 OR dosq_<>0 OR kosq_<>0 OR c.nbs IN ('3800','3801') THEN
            insert into snap_balances -- вставка простых счетов
                   (fdat, acc, rnk, ost, dos, kos, ostq, dosq, kosq)
            VALUES (dat_,c.acc,c.rnk,c.ostf-c.dos+c.kos,c.dos,c.kos,
                                    ost1_-dosq_+kosq_,dosq_,kosq_);
         END IF;
      END IF;
   END LOOP;

-- Теперь повесить ошибки округления на вешалки4

   i   := ves.FIRST;

   WHILE i IS NOT NULL
   LOOP
--    deb.trace(1,'='||i||'=',ves(i).acc);
      IF i>2 AND TRUNC(i/10) NOT IN (980,999)
             AND (ves(i).ost<>0  OR ves(i).dos<>0  OR ves(i).kos<>0  OR
                  ves(i).ost0<>0 OR ves(i).dos0<>0 OR ves(i).kos0<>0 OR
                  ves(i).ostq<>0 OR ves(i).dosq<>0 OR ves(i).kosq<>0) THEN
         IF ves(i).acc IS NOT NULL THEN
            insert into snap_balances -- вставка вешалок
                   (fdat, acc, rnk, ost, dos, kos, ostq, dosq, kosq)
            VALUES (dat_,
                    ves(i).acc,ves(i).rnk,ves(i).ost,ves(i).dos,ves(i).kos,
                    ves(i).ost0+ves(i).ostq,
                    ves(i).dos0+greatest(ves(i).dosq-ves(i).kosq,0),
                    ves(i).kos0+greatest(ves(i).kosq-ves(i).dosq,0));
         ELSE
            raise_application_error(-20000, 'Не знайдно рахунок вішалки VE'||MOD(i,10)||' для вал. '||TRUNC(i/10));
         END IF;

      END IF;

      i := ves.NEXT(i);

   END LOOP;

-- Переоцінка ВП

   FOR v IN (SELECT /*+ FULL(v) INDEX(b0) INDEX(b1) */
                    v.acc3800,(SELECT nls||'/'||LPAD(kv,3,'0') FROM accounts WHERE acc=acc3800) nls3800,
                    v.acc3801,(SELECT RPAD(nls,14)||nms FROM accounts WHERE acc=acc3801) nls3801,
                    v.acc6204,(SELECT RPAD(nls,14)||nms FROM accounts WHERE acc=acc6204) nls6204,
                    (CASE WHEN b0.ostq+NVL(b1.ostq,0)>0 THEN 1 ELSE 0 END) dk, b0.rnk,
                    ABS(b0.ostq+NVL(b1.ostq,0)) s
               FROM vp_list v, snap_balances b0, snap_balances b1
              WHERE b0.fdat=dat_ AND v.acc3800=b0.acc
                AND b1.fdat=dat_ AND v.acc3801=b1.acc(+)
                AND b0.ostq+NVL(b1.ostq,0)<>0 )
   LOOP

      bc.subst_branch(SUBSTR(branch#,1,8)); --/380764/

      bars_audit.info('DRAPS2: ВП'||v.nls3800||':'||v.dk||'='||v.s);

      gl.bDATE:=dat_;
      gl.aUID :=uid_;

      gl.ref (ref_);

      INSERT INTO oper (ref,tt,vob,nd,dk,pdat,vdat,datd,userid,
                      nam_a,nlsa,mfoa,nam_b,nlsb,mfob,kv,s,nazn)
      VALUES
      (ref_,'PVP',6,ref_,v.dk,SYSDATE,gl.bDATE,gl.bDATE,gl.aUID,
       SUBSTR(v.nls3801,15,38),TRIM(SUBSTR(v.nls3801,1,14)),gl.aMFO,
       SUBSTR(v.nls6204,15,38),TRIM(SUBSTR(v.nls6204,1,14)),gl.aMFO,980,v.s,
       'Переоцінка валютної позиції '||v.nls3800);

      gl.payv(1,ref_,gl.bDATE,'PVP',v.dk,980,TRIM(SUBSTR(v.nls3801,1,14)),v.s,
                                         980,TRIM(SUBSTR(v.nls6204,1,14)),v.s);

      FOR i IN 0..1 LOOP

         if i=0 then acc_:=v.acc3801; else v.dk:=1-v.dk; acc_:=v.acc6204; end if;

         UPDATE snap_balances
            SET ost =ost +CASE WHEN v.dk=1 THEN 0-v.s ELSE v.s END,
                dos =dos +CASE WHEN v.dk=1 THEN v.s ELSE 0 END,
                kos =kos +CASE WHEN v.dk=1 THEN 0 ELSE v.s END,
                ostq=ostq+CASE WHEN v.dk=1 THEN 0-v.s ELSE v.s END,
                dosq=dosq+CASE WHEN v.dk=1 THEN v.s ELSE 0 END,
                kosq=kosq+CASE WHEN v.dk=1 THEN 0 ELSE v.s END
          WHERE acc=acc_ AND fdat=dat_;
         IF SQL%ROWCOUNT=0 THEN
            insert into snap_balances
                   (fdat, acc, rnk, ost, dos, kos, ostq, dosq, kosq)
            VALUES (dat_, acc_, v.rnk,
                    CASE WHEN v.dk=1 THEN 0-v.s ELSE v.s END,
                    CASE WHEN v.dk=1 THEN v.s ELSE 0 END,
                    CASE WHEN v.dk=1 THEN 0 ELSE v.s END,
                    CASE WHEN v.dk=1 THEN 0-v.s ELSE v.s END,
                    CASE WHEN v.dk=1 THEN v.s ELSE 0 END,
                    CASE WHEN v.dk=1 THEN 0 ELSE v.s END);
         END IF;
      END LOOP;

      gl.bDATE:=dat0_;                           -- Back to
      gl.aUID :=uid#; bc.subst_branch(branch#);  -- my branch

   END LOOP;

-- Кінець нових драпсів

   dbms_output.put_line('DRAPS2: '||TO_CHAR(dat_,'dd-mm-yyyy')||' Час A '|| to_char((dbms_utility.get_time-t)/100/60) );
   bars_audit.info('DRAPS2: Час A '|| to_char((dbms_utility.get_time-t)/100/60) );
   gl.setp('SNPBAL','',NULL);
   COMMIT;

  -- Фіксуємо SCN для SALDOA and SALDOA_DEL_ROWS
      --BARS_UTL_SNAPSHOT.set_snap_scn(dat_);
   begin
      execute immediate 'begin BARS_UTL_SNAPSHOT.set_snap_scn(to_date('''||TO_CHAR(dat_,'ddmmyyyy')||''',''DDMMYYYY'')); end;';
   exception when others then
      if   sqlcode in (-00201,-06550) then null;
	  else raise; end if;
   end;


  dbms_application_info.set_client_info(null);

EXCEPTION WHEN OTHERS THEN

   gl.setp('SNPBAL','',NULL);
   gl.bDATE:=dat0_;                           -- Back to
   gl.aUID :=uid#; bc.subst_branch(branch#);  -- my branch
   dbms_application_info.set_client_info(null);
   raise;

END;
/
show err;

PROMPT *** Create  grants  DDRAPS ***
grant EXECUTE                                                                on DDRAPS          to BARSUPL;
grant EXECUTE                                                                on DDRAPS          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DDRAPS.sql =========*** End *** ==
PROMPT ===================================================================================== 
