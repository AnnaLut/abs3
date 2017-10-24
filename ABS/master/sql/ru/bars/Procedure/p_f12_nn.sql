

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F12_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F12_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_F12_NN (Dat_ DATE ,
                                      sheme_ VARCHAR2 DEFAULT 'G',
                                      p_kodf_ VARCHAR2 DEFAULT '12')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирование файла #12 для КБ
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 01/11/2012 (21/08/2012)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата
    sheme_ - схема формирования

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
01/11/2012 Операцію TOP замінили на TCC
21/08/2012 доработка по BAK для операций АА7, АА8 и 150
12/12/2011 додала контрольні точки після формування файла (як у @12):
           викликаються доопрацьовані процедури p_ch_sk та p_ch_f12_kb
30.10.2011 в поле комментарий добавил сообщение о замене СК
           (Вирко добавляла 07.06.2011)
05.10.2011 для проводок Дт 1001,1002,1003,1004  Кт 1001,1002,1003,1004
           вместо DK из OPER будем выбирать DK из OPLDOK
26.01.2011 по настоянию Департамента СБЕРбанка возвратили
           дочернюю операцию TOP в операцию TOC и в операцию TOC добавили
           флаг "символ кассы" и значение = 1. Для данной операции при
           вводе имеется возможность заполнять символ кассплана (2 или 5).
           Для дочерней операции TOP символ кассплана выбираем из поля SK
           табл. OPER т.к. из операции TOP убрали символ кассплана равный 2.
22.12.2010 изменил некоторые условия для операций покупки/продажи
           валюты и их возвращения.
           Будем изменять симв.кассплана для операций продажи (AA4,AA6)
           на 32 если TT(OPER)=TT(OPLDOK) и на 61 если код операции 'BAK'.
           Будем изменять симв.кассплана для операций покупки (AA3,AA5)
           на 61 если TT(OPER)=TT(OPLDOK) и на 32 если код операции 'BAK'.
08.12.2010 для блока "IF o_tt_ in ('AA3','AA4','AA5','AA6') then "
           вместо переменной "o_tt_" - код операции из OPER была
           переменная "tt_" - код операции из OPLDOK
           (исправлено замечание Ровно СБ)
07.12.2010 по настоянию Департамента СБЕРбанка разделили операции TOC и TOP,
           поэтому возникли проблемы заполнения СК для дочерней операции TOP
           (раньше символ был зашит в эту операцию)
26.11.2010 изменения для валютообменных операций (сторно операции)
           для операции "BAK' присваиваем символ 61 если SK=30 или
           символ 32 если SK=56 (так сделано и проверено в P_F12sb)
01.11.2010 выполнялись изменения символа не для всех указанных операций
           Исправлено.
21.10.2010 для операций покупки/продажи валюты и их возвращения будем
           изменять символ кассплана с 30 на 32 и с 56 на 61
           операции AA3, AA4, AA5, AA6
08.07.2010 в протокол формирования для курсора OPERA добавлено заполнение
           полей REF и COMM(назначение платежа)
18.02.2009 в RNBU_TRACE в поле ACC заносим ACC счета кассы
21.12.2007 Доп.параметры SK_P, SK_V будем обрабатывать для всех банков
           если имеются данные доп.реквизиты в операциях
           (ранее было только для УПБ, пожелало ОПЕРУ СБ)
24.11.2006 Для банка УПБ (МФО=300205) выполнена спецобработка символов
           кассплана т.к. при вводе существует 2 доп.реквизита SK_P, SK_V
           и их можно вводить в одном документе.
02.11.2006 Для отбора бал.счетов использовалось условие tip='KAS'
           добавил tip='KAS and NBS in ('1001','1002','1003','1004') and
           kv=980. (была проблема в Укоопспилке Львова. Для бал.счета 1003
           и различных валют(кроме 980) установили тип счета 'KAS').
25.09.2006 для проводок вида
Дт 1001,1002,1003,1004  Кт 1001 и DK=1 меняем символа кассплана с 66 на 39
для счетов Дт
Дт 1001,1002,1003,1004  Кт 1001 и DK=0 меняем символа кассплана с 39 на 66
для счетов Дт
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    VARCHAR2(2):='12';
typ_ NUMBER;

nls_     VARCHAR2(15);
nls1_    VARCHAR2(15);
nlsd_    varchar2(15);
nlsk_    varchar2(15);
data_    DATE;
kv_      SMALLINT;
kodp_    VARCHAR2(10);
znap_    VARCHAR2(30);
sk_      SMALLINT;
t_sk_    SMALLINT;  -- з TTS
sk_o_    SMALLINT;  -- з OPER
sk1_     SMALLINT;
sk2_     SMALLINT;
s_       DECIMAL(24);
nbu_     SMALLINT;
ref_     NUMBER;
stmt_    Number;
userid_  NUMBER;
kol_sk_  NUMBER :=0;
tt_      Varchar2(3);  -- з OPLDOK
tt_pr    varchar2(3);
o_tt_    Varchar2(3);  -- з OPER
dat1_    DATE;        -- дата начала декады !!!
dc_      INTEGER;
dk_      NUMBER;
dk1_     NUMBER;
nbuc1_   VARCHAR2(12);
nbuc_    VARCHAR2(12);
acc_     NUMBER;
nazn_    Varchar2(160);
comm_    Varchar2(200);
pr_bak   Number;
pr_doch  Number;
mfo_     number;
mfou_    Number;

CURSOR OPERA IS
   SELECT  s.acc, s.nls, o.nlsa, o.kv, o.dk, p.FDAT, p.REF, p.stmt, o.nazn,
           DECODE(p.TT, o.TT, o.SK, t.SK), t.sk, p.dk, p.tt, o.tt, o.sk, p.s,
           decode(p.tt, o.tt, 0, 1) pr -- признак дочерней операции
   FROM OPER o, OPLDOK p, ACCOUNTS s, TTS t
   WHERE p.acc=s.acc             AND
         s.tip='KAS'             AND
         s.nbs in ('1001','1002','1003','1004') AND
         s.kv=980                AND
         p.FDAT BETWEEN Dat1_ AND Dat_ AND
         o.REF=p.REF             AND
         p.SOS=5                 AND
         p.TT=t.TT ;

-- исходящие остатки
CURSOR SALDO IS
   SELECT  o.acc, o.nls, o.kv, sa.FDAT, sa.ostf-sa.dos+sa.kos
   FROM SALDOA sa, ACCOUNTS o
   WHERE o.tip='KAS'    AND
         o.nbs in ('1001','1002','1003','1004') AND
         o.kv=980       AND
         o.acc=sa.acc   AND
         sa.FDAT  IN ( SELECT MAX ( bb.FDAT )
                  FROM  SALDOA bb
                  WHERE o.acc = bb.acc AND bb.FDAT  <= Dat_) ;

-- входящие остатки
CURSOR SALDO2 IS
   SELECT  o.acc, o.nls, o.kv, sa.FDAT, sa.ostf-sa.dos+sa.kos
   FROM SALDOA sa, ACCOUNTS o
   WHERE o.tip='KAS'    AND
         o.nbs in ('1001','1002','1003','1004') AND
         o.kv=980       AND
         o.acc=sa.acc   AND
         sa.FDAT  IN ( SELECT MAX ( bb.FDAT )
                  FROM  SALDOA bb
                  WHERE o.acc = bb.acc AND bb.FDAT  < Dat1_) ;

CURSOR BaseL IS
   SELECT kodp,nbuc, SUM (znap)
   FROM RNBU_TRACE
   WHERE userid=userid_
   GROUP BY kodp,nbuc
   ORDER BY kodp;

BEGIN
-------------------------------------------------------------------
--SELECT id INTO userid_ FROM STAFF WHERE UPPER(logname)=UPPER(USER);
userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
nbu_:= Isnbubank();

mfo_ := F_OURMFO();

BEGIN
  SELECT NVL(trim(mfou), mfo_)
    INTO mfou_
  FROM BANKS
  WHERE mfo = mfo_;
EXCEPTION
  WHEN NO_DATA_FOUND
  THEN
     mfou_ := mfo_;
END;

select count(*) into kol_sk_
from op_rules
where trim(tag) in ('SK_P','SK_V');

-- определение начальных параметров
P_Proc_Set(kodf_,sheme_,nbuc1_,typ_);

IF p_kodf_ = '12' THEN
-- определение даты начала декады
   dc_:=TO_NUMBER(LTRIM(TO_CHAR(dat_,'DD'),'0'));

   FOR i IN 1..3
   LOOP
      IF dc_ BETWEEN 10*(i-1)+1 AND 10*(i-1)+10+Iif(i,3,0,1,0) THEN
         dat1_:=TO_DATE(LPAD(10*(i-1)+1,2,'0')||TO_CHAR(dat_,'mmyyyy'),'ddmmyyyy');
         EXIT;
      END IF;
   END LOOP;
ELSIF p_kodf_ = '13' THEN -- файл 13
-- определение даты начала месяца
   dat1_ := TO_DATE('01'||TO_CHAR(dat_,'mmyyyy'),'ddmmyyyy');
ELSIF p_kodf_ = '92' THEN
   dat1_:=Calc_Pdat(Dat_);
ELSE
   dat1_:=Dat_;
END IF;

-- если начало декады (или месяца) - след. день после выходных - то включить обороты за выходные
Dat1_:=Calc_Pdat(Dat1_);

OPEN OPERA;
LOOP
   FETCH OPERA INTO acc_, nls1_, nls_, kv_, dk_, data_, ref_, stmt_, nazn_, sk_,
                    t_sk_, dk1_, tt_, o_tt_, sk_o_, s_, pr_doch ;
   EXIT WHEN OPERA%NOTFOUND;

   comm_ := '';

   comm_ := '';

   -- вибираємо рахунок кореспондент для рахунку каси
   BEGIN
      select tt, nlsd, nlsk, substr(nazn,1,100)
         into tt_pr, nlsd_, nlsk_, nazn_
      from provodki
      where ref = ref_
        and fdat= data_
        and kv  = 980
        and nlsd= nls1_
        and stmt=stmt_
        and s*100=s_;
      comm_ := comm_ || ' Дт рах. = ' || nlsd_ || ' Кт рах. = ' || nlsk_ ||
               '  ' || nazn_;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      BEGIN
         select tt, nlsd, nlsk, substr(nazn,1,100)
            into tt_pr, nlsd_, nlsk_, nazn_
         from provodki
         where ref = ref_
           and stmt=stmt_
           and fdat= data_
           and kv  = 980
           and nlsk= nls1_
           and s*100=s_;
         comm_ := comm_ || ' Дт рах. = ' || nlsd_ || ' Кт рах. = ' || nlsk_ ||
                  '  ' || nazn_;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         comm_ := comm_ || ' кореспондент не знайдений ';
      END;
   END;

   --comm_ := comm_ || trim(nazn_);

   IF typ_>0 THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

-- для банка УПБ и ОПЕРУ СБ в кассовых операциях по 980 и типов проводок
--  Дт 1001-1004 Кт 1001-1004 имеется два доп.реквизита символов кассплана
-- символ кассплана SK_P (приход) и SK_V (расход)
--   IF f_ourmfo() in (300205, 300465) THEN
-- для всех банков !!! если имеются доп.реквизиты SK_P, SK_V в операциях
   IF kol_sk_ > 0 THEN
      sk2_:=sk_;  ---null;

      if tt_ = o_tt_ then        -- основна операцiя
      -- все одно прiоритет доп.реквiзитiв SK_P, SK_V
         begin
            select to_number(substr(value,1,2)) into sk1_
            from operw
            where ref=ref_ and
                  trim(tag)=DECODE(dk1_,0,'SK_P','SK_V');
         exception when others then
            sk1_:=0;
         end;
         if sk1_ is not NULL and sk1_<>0 then
            sk2_:=sk1_;
         else
            NULL;
         end if;
      else                          -- зв'язана операцiя
         sk2_:=t_sk_;               -- ! прiоритет СКП з карточки зв'язаної операцiї?
         if sk2_ is NULL then
            begin
               select to_number(substr(value,1,2)) into sk2_
               from operw
               where ref=ref_ and trim(tag)='SK';
            exception when others then
               sk2_:=0;
            end;
         end if;
      end if;
      sk_:=sk2_;
      if sk2_ is NULL then
         sk_:=0;
      end if;
   ELSE
      IF sk_ IS NULL THEN
         BEGIN
            SELECT TO_NUMBER(SUBSTR(value,1,2)) INTO sk_
            FROM OPERW
            WHERE REF=ref_ AND
                  trim(tag)='SK';
         EXCEPTION WHEN OTHERS THEN
            sk_:=0;
         END;
      END IF ;

      -- для проводок вида Дт 1001  Кт 1001,1002,1003,1004 или
      -- Дт 1001,1002,1003,1004  Кт 1001
      IF substr(nls_,1,4) in ('1001','1002','1003','1004') and--nls_=nls1_ and
         dk_=1 and  dk1_=1 and sk_=39 and tt_ = 'МГР' THEN
         comm_ := '!!! авт. замена ' || sk_  ||' на 66 '|| comm_;
         sk_:=66;
      END IF;

      IF substr(nls_,1,4) in ('1001','1002','1003','1004') and substr(nls1_,1,4) in ('1001','1002','1003','1004') and
         dk1_=0 and sk_=66 THEN
         comm_ := '!!! авт. замена ' || sk_  ||' на 39 '|| comm_;
         sk_:=39;
      END IF;

      --IF substr(nls_,1,4) in ('1001','1002','1003','1004') and--nls_=nls1_ and
      --   dk_=1 and dk1_=1 and sk_=39 and tt_ != 'МГР' THEN
      --   sk_:=66;
      --END IF;

      IF substr(nls_,1,4) in ('1001','1002','1003','1004') and substr(nls1_,1,4) in ('1001','1002','1003','1004') and
         dk1_=1 and sk_=39 THEN
         comm_ := '!!! авт. замена ' || sk_  ||' на 66 '|| comm_;
         sk_:=66;
      END IF;
   END IF;

   IF tt_ in ('150','AA3','AA4','AA5','AA6','AA7','AA8') then
      BEGIN
         select count(*)
            into pr_bak
         from provodki
         where ref=ref_
           and tt='BAK';
      EXCEPTION WHEN NO_DATA_FOUND THEN
         pr_bak := 0;
      END;

      if tt_ in ('AA4','AA6','AA8') and pr_bak != 0 and sk_o_ < 40 then
         if tt_ = tt_pr then
            comm_ := '!!! авт. замена ' || sk_o_  ||' на 32 '|| comm_;
            sk_ := 32;
         end if;
         if tt_ != tt_pr and tt_pr = 'BAK' and nlsk_ like '100%' and sk_o_ < 40 then
            comm_ := '!!! авт. замена ' || sk_o_  ||' на 61 '|| comm_;
            sk_ := 61;
         end if;
      end if;

      if tt_ in ('150','AA3','AA5','AA7') and pr_bak != 0 and sk_o_ > 39 then
         if tt_ = tt_pr then
            comm_ := '!!! авт. замена ' || sk_o_  ||' на 61 '|| comm_;
            sk_ := 61;
         end if;
         if tt_ != tt_pr and tt_pr = 'BAK' and nlsd_ like '100%' and sk_o_ > 39 then
            comm_ := '!!! авт. замена ' || sk_o_  ||' на 32 '|| comm_;
            sk_ := 32;
         end if;
      end if;
   END IF;

   -- по настоянию Департамента СБЕРбанка разделили операции TOC и TOP, поэтому возникли проблемы
   -- заполнения СК для дочерней операции TOP (раньше символ был зашит в эту операцию)
   IF mfou_ = 300465 and sk_ = 0 AND tt_ in ('TOP', 'TCC') and pr_doch = 1 then
      sk_ := sk_o_;  --2;
   end if;

   IF s_<>0 THEN
      kodp_:= LPAD(TO_CHAR(sk_),2,'0');
      znap_:= TO_CHAR(s_) ;

      INSERT INTO RNBU_TRACE (nls, kv, odate, kodp, znap, nbuc, acc, ref, comm) VALUES
                             (nls_, kv_, data_, kodp_, znap_, nbuc_, acc_, ref_, comm_);
   END IF;
END LOOP;
CLOSE OPERA;

-- исходящие остатки
OPEN SALDO;
LOOP
   FETCH SALDO INTO acc_,nls_, kv_, data_, s_ ;
   EXIT WHEN SALDO%NOTFOUND;

   IF typ_>0 THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   IF s_ <> 0 THEN
      IF nbu_ = 1 THEN
         kodp_:= '69';
      ELSE
         kodp_:= '70';
      END IF;

      znap_:= TO_CHAR(ABS(s_));
      INSERT INTO RNBU_TRACE (nls, kv, odate, kodp, znap, nbuc, acc) VALUES
                             (nls_, kv_, data_, kodp_, znap_, nbuc_, acc_);
   END IF;
END LOOP;
CLOSE SALDO;

-- входящие остатки
OPEN SALDO2;
LOOP
   FETCH SALDO2 INTO acc_,nls_, kv_, data_, s_ ;
   EXIT WHEN SALDO2%NOTFOUND;

   IF typ_>0 THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   IF s_ <> 0  THEN
      IF nbu_ = 1 THEN
         kodp_:= '34';
      ELSE
         kodp_:= '35';
      END IF;

      znap_:= TO_CHAR(ABS(s_)) ;
      INSERT INTO RNBU_TRACE (nls, kv, odate, kodp, znap, nbuc, acc) VALUES
                             (nls_, kv_, data_, kodp_, znap_, nbuc_, acc_);
   END IF;

END LOOP;
CLOSE SALDO2;
---------------------------------------------------
DELETE FROM TMP_NBU WHERE datf=Dat_ AND kodf=p_kodf_ ;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, nbuc_, znap_;
   EXIT WHEN BaseL%NOTFOUND;

   INSERT INTO TMP_NBU
        (kodf, datf, kodp, znap, nbuc)
   VALUES
        (p_kodf_, Dat_, kodp_, znap_, nbuc_);
END LOOP;
CLOSE BaseL;

----------------------------------------
p_ch_sk('12',dat_,dat1_,userid_);
p_ch_f12_kb('12',dat1_,dat_,userid_);
----------------------------------------
END P_F12_Nn;
/
show err;

PROMPT *** Create  grants  P_F12_NN ***
grant EXECUTE                                                                on P_F12_NN        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F12_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
