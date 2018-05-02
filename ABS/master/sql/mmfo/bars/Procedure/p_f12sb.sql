

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F12SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F12SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F12SB (Dat_ DATE, sheme_ VARCHAR2 DEFAULT 'C')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FILE NAME   : otcn.sql
% DESCRIPTION : Отчетность СберБанка: формирование файлов
% COPYRIGHT   : Copyright UNITY-BARS Limited, 2001.  All Rights Reserved.
% VERSION     : 21/02/2018 (12/01/2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 12/01/2017 Будем изменять симв.кассплана для операций (027)
%            c 30 на 32 и на 61 если код операции 'BAK'.
% 02/10/2013 для операции 416 в которой по одному REF есть проводки
%            Дт 1002 Кт 2909 и Дт 2909 Кт 1002 и символ кассплана SK=32
%            для проводки Дт 2909 Кт 1002 изменяем символ на 61 (для
%            данной проводки код операции K16)
% 24/04/2013 не враховувалась, що СТОРНО операції K33 повинен мати інше СК
% 01/11/2012 Операцію TOP замінили на TCC
% 13/09/2012 формируем в разрезе кодов территорий
% 21/08/2012 не враховувалась, що СТОРНО операції АА8 та 150 повинен мати інше СК
% 14/08/2012 не враховувалась, що СТОРНО операції АА7 повинен мати інше СК (не 56)
% 30.10.2011 в поле комментарий добавил сообщение о замене СК
%            (Вирко добавляла 07.06.2011)
% 05.10.2011 для проводок Дт 1001,1002,1003,1004  Кт 1001,1002,1003,1004
%            вместо DK из OPER будем выбирать DK из OPLDOK
% 14.03.2011 в поле комментарий вносим код TOBO и название счета
% 26.01.2011 по настоянию Департамента СБЕРбанка возвратили
%            дочернюю операцию TOP в операцию TOC и в операцию TOC добавили
%            флаг "символ кассы" и значение = 1. Для данной операции при
%            вводе имеется возможность заполнять символ кассплана (2 или 5).
%            Для дочерней операции TOP символ кассплана выбираем из поля SK
%            табл. OPER. Из операции TOP убрали символ кассплана равный 2.
% 22.12.2010 изменил некоторые условия для операций покупки/продажи
%            валюты и их возвращения.
%            Будем изменять симв.кассплана для операций продажи (AA4,AA6)
%            на 32 если TT(OPER)=TT(OPLDOK) и на 61 если код операции 'BAK'.
%            Будем изменять симв.кассплана для операций покупки (AA3,AA5)
%            на 61 если TT(OPER)=TT(OPLDOK) и на 32 если код операции 'BAK'.
% 07.12.2010 по настоянию Департамента СБЕРбанка разделили операции TOC и TOP,
%   поэтому возникли проблемы заполнения СК для дочерней операции TOP
%   (раньше символ был зашит в эту операцию)
% 26.11.2010 изменил только комментарий
% 23.11.2010 изменения для валютообменных операций (сторно операции)
%            для операции "BAK' присваиваем символ 61 если SK=30 или
%            символ 32 если SK=56
% 01.11.2010 выполнялись изменения символа не для всех указанных операций
%            Исправлено.
% 21.10.2010 для операций покупки/продажи валюты и их возвращения будем
%            изменять символ кассплана с 30 на 32 и с 56 на 61
%            операции AA3, AA4, AA5, AA6
% 23.02.2009 рахунки вибироємо 1001,1002,1003,1004 KV=980
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='12';
nls_     varchar2(15);
nls1_    varchar2(15);
nlsd_    varchar2(15);
nlsk_    varchar2(15);
nazn_    varchar2(100);
dat1_    date;
data_    date;
kv_      SMALLINT;
dk_      Number;
dk1_     Number;
s35      DECIMAL(24);
s70      DECIMAL(24);
kodp_    varchar2(10);
znap_    varchar2(30);
sk_      SMALLINT;
sk2_     SMALLINT;
sk_o_    SMALLINT;
s_       DECIMAL(24);
nbu_     SMALLINT;
ref_     Number;
ref1_    Number;
stmt_    Number;
userid_  Number;
acc_     NUMBER;
tt_      varchar2(3);
tt_pr    varchar2(3);
pr_bak   Number;
pr_doch  Number;
tobo_    accounts.tobo%TYPE;
nms_     accounts.nms%TYPE;
comm_    rnbu_trace.comm%TYPE;
typ_     Number;
nbuc1_   VARCHAR2(12);
nbuc_    VARCHAR2(12);

CURSOR OPERA IS
   SELECT  s.acc, s.nls, o.nlsa, o.kv, o.dk, p.fdat, p.ref, p.stmt,
           decode(p.tt, o.tt, o.sk, t.sk), p.s, o.tt, NVL(o.sk,0), p.dk,
           decode(p.tt, o.tt, 0, 1) pr -- признак дочерней операции
   FROM OPER o, OPLDOK p, ACCOUNTS s, tts t  
   WHERE p.acc=s.acc             AND
         s.tip='KAS'             AND
         s.nbs in ('1001','1002','1003','1004') AND
         s.kv=980                AND
         p.fdat=Dat_             AND
         o.ref=p.ref             AND
         p.sos=5                 AND
         p.tt=t.tt ;

--Остатки
CURSOR SALDO IS
   SELECT  o.acc, o.nls, o.kv, sa.fdat, 
           sa.ost-sa.kos+sa.dos ostf, sa.ost,
           o.tobo, o.nms
   FROM snap_balances sa, accounts o
   WHERE o.tip='KAS'
     and o.nbs in ('1001','1002','1003','1004')
     and o.kv=980
     and o.acc=sa.acc
     and sa.fdat = Dat_ ;

CURSOR BaseL IS
   SELECT kodp, nbuc, SUM (znap)
   FROM rnbu_trace
   GROUP BY kodp, nbuc;

BEGIN
logger.info ('P_F12SB: Begin for datf = '||to_char(dat_, 'dd/mm/yyyy'));
-------------------------------------------------------------------
userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
nbu_:=IsNBUBank();
dat1_ := Dat_;

-- определение начальных параметров
P_Proc_Set_Int(kodf_,sheme_,nbuc1_,typ_);

OPEN OPERA;
LOOP
   FETCH OPERA INTO acc_, nls1_, nls_, kv_, dk_, data_, ref_, stmt_, sk_, s_, tt_, sk_o_,
                    dk1_, pr_doch ;
   EXIT WHEN OPERA%NOTFOUND;

   comm_ := '';

   -- вибираємо рахунок кореспондент для рахунку каси
   BEGIN
      select tt, nlsd, nlsk, substr(nazn,1,100)
         into tt_pr, nlsd_, nlsk_, nazn_
      from provodki
      where ref = ref_
        and fdat= Dat_
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
           and fdat= Dat_
           and kv  = 980
           and nlsk= nls1_
           and s*100=s_;
         comm_ := comm_ || ' Дт рах. = ' || nlsd_ || ' Кт рах. = ' || nlsk_ ||
                  '  ' || nazn_;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         comm_ := comm_ || ' кореспондент не знайдений ';
      END;
   END;

   IF typ_>0 THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   IF sk_ is null THEN
      begin
         select to_number(substr(value,1,2))  into sk_
         from operw where ref=ref_ and tag='SK';
         exception when others then sk_ := 0;
      end;
   END IF ;

   -- по настоянию Департамента СБЕРбанка разделили операции TOC и TOP, поэтому возникли проблемы
   -- заполнения СК для дочерней операции TOP (раньше символ был зашит в эту операцию)
   IF sk_ = 0 AND tt_ in ('TOC', 'TCC') and pr_doch = 1 then
      comm_ := '!!! авт. замена ' || sk_  ||' на '|| sk_o_  ||' '|| comm_;
      sk_ := sk_o_;
   end if;

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
      sk_:='39';
   END IF;

   IF substr(nls_,1,4) in ('1001','1002','1003','1004') and substr(nls1_,1,4) in ('1001','1002','1003','1004') and
      dk1_=1 and sk_=39 THEN
      comm_ := '!!! авт. замена ' || sk_  ||' на 66 '|| comm_;
      sk_:=66;
   END IF;

   IF tt_ in ('025','027','K33','045','046','A22','150','151','AA3','AA4','AA5','AA6','AA7','AA8') then
      BEGIN
         select count(*)
            into pr_bak
         from provodki
         where ref=ref_
           and tt='BAK';
      EXCEPTION WHEN NO_DATA_FOUND THEN
         pr_bak := 0;
      END;

      if tt_ in ('025','027','K33','045','046','A22','150','AA4','AA6','AA8') and pr_bak != 0 and sk_o_ < 40 then
         if tt_ = tt_pr then
            comm_ := '!!! авт. замена ' || sk_o_  ||' на 32 '|| comm_;
            sk_ := 32;
         end if;
         if tt_ != tt_pr and tt_pr = 'BAK' and nlsk_ like '100%' and sk_o_ < 40 then
            comm_ := '!!! авт. замена ' || sk_o_  ||' на 61 '|| comm_;
            sk_ := 61;
         end if;
      end if;

      if tt_ in ('151','AA3','AA5','AA7') and pr_bak != 0 and sk_o_ > 39 then
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

   -- добавил 02.10.2013 в Николаеве была проводка для Швидкої копійки
   -- один REF=31025355 Дт 1002 Кт 2909 и Дт 2909 Кт 1002
   if tt_ = '416' and tt_ != tt_pr and tt_pr = 'K16' and nlsk_ like '100%' and sk_o_ < 40 then
      comm_ := '!!! авт. замена ' || sk_o_  ||' на 61 '|| comm_;
      sk_ := 61;
   end if;

   IF s_<>0 THEN
      kodp_:= iif_N(sk_,10,'0','','') || TO_CHAR(sk_);
      znap_:= TO_CHAR(s_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, ref, comm, nbuc) VALUES
                             (nls_, kv_, data_, kodp_, znap_, ref_, comm_, nbuc_);
   END IF;
    END LOOP;
CLOSE OPERA;

OPEN SALDO;
LOOP
   FETCH SALDO INTO acc_, nls_, kv_, data_, s35, s70, tobo_, nms_ ;
   EXIT WHEN SALDO%NOTFOUND;
   comm_ := '';
   comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);

   IF typ_>0 THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   IF data_=Dat_ THEN
      s_ := s35 ;
   ELSE
      s_ := s70 ;
   END IF ;
   IF (s35 <> 0 OR s70 <> 0) THEN
      IF nbu_ = 1 THEN
         kodp_:= '34';
      ELSE
         kodp_:= '35';
      END IF;
      znap_:= TO_CHAR(ABS(s_)) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc) VALUES
                             (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_, nbuc_);
   END IF;
   IF s70 <> 0 THEN
      IF nbu_ = 1 THEN
         kodp_:= '69';
      ELSE
         kodp_:= '70';
      END IF;
      znap_:= ABS(s70) || '' ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc) VALUES
                             (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_, nbuc_);
   END IF;
END LOOP;
CLOSE SALDO;
---------------------------------------------------
DELETE FROM tmp_irep where datf=Dat_ and kodf='12' ;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, nbuc_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_irep
        (kodf, datf, kodp, nbuc, znap)
   VALUES
        ('12', Dat_, kodp_, nbuc_, znap_);
END LOOP;
CLOSE BaseL;
----------------------------------------
-- перевiрка на допустимiсть символiв по KL_D010
-- а також залишку бал.рах.1007 та символiв 39 i 66
p_ch_sk_int('12',dat_,dat1_,userid_);
p_ch_f12_int('12',dat_,userid_);

DELETE FROM OTCN_TRACE_12  WHERE datf= dat_ AND isp = userid_ ;

insert into OTCN_TRACE_12(DATF, USERID, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO)
select dat_, USERID_, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO
from rnbu_trace;

logger.info ('P_F12SB: End for datf = '||to_char(dat_, 'dd/mm/yyyy'));
-----------------------------------------------------------------------------
END p_f12sb;
/
show err;

PROMPT *** Create  grants  P_F12SB ***
grant EXECUTE                                                                on P_F12SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F12SB         to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F12SB.sql =========*** End *** =
PROMPT ===================================================================================== 
