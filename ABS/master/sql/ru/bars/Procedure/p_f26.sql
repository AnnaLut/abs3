

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F26.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F26 ***

CREATE OR REPLACE PROCEDURE BARS.p_f26 (Dat_ DATE )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Процедура формирование файла #26 для КБ
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
%
% VERSION     :   v.16.012 02/04/2018 (01/02/2018) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     параметры:  Dat_ - отчетная дата

   Структура показателя    DD MMM HHHHHHHHHH BBBB VVV P

 1     DD           список значений [10,11,20,21,97,98,99]
 3     MMM          K040 код страны банка/контрагента
 6     HHHHHHHHHH   rc_bnk.B010 или rcukru.glb
16     BBBB         R020 балансовый счет                           
20     R011         параметр R011
21     R013         параметр R013
22     VVV          R030 валюта
25     J            ознака обтяженосты коштів
26     S181         код початкового строку погашення
27     S245         код кінцевого строку погашення
28     S580         код розподілу активів за групами ризику

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 02/04/2018 -будемо додатково включати бал.рах. 1509 з типом 'SNA' 
 19/01/2018 -для бал.счетов 36 раздела убрали присвоение параметру S245 
             значения ноль 
 17/01/2018 -не включаются счета НБУ RNK=10009201 
 28/12/2017 -новая структура показателя
 14/11/2017 -несущественные изменения
 20/02/2017 -для бал.счета 1502 будет формироваться различные значения 
             кода показателя "P" (1 или 2) 
             (R013='1' то P='1', R013 in '2','9') то P='2')                               
 26/10/2016 -для счетов 1500 анализ спецпараметров связанных с "обтяженнями" 
 07/10/2016 -для бал.счета 1500 будет формироваться различные значения 
             кода показателя "P" (1 или 2) 
 05/09/2016 -убрал блок по разшифровке бал.счетов 3041, 3351 
 01/07/2016 -для банков нерезидентов код банка выбираем из ALT_BIC
             таблицы CUSTBANK
 20/04/2015 -расширена переменная RB_ для рейтинга банка с 4 до 5 символов
 27/10/2014 -для резидентов название банка формируем из RCUKRU поле NB
 11/06/2014 -код инвестиционного класса равен '1' будем формировать только 
             для нерезидентов
 10/06/2014 -для рейтингов 'BBB','BBB+','BBB-','Baa1','Baa2','Baa3' 
             будем формировать код инвестиционного класса '1'    
             (замечания банка Надра)
 03/06/2014 -для банка Надра по металлам не выпоняем деление на 10 как для
             унций т.к. остатки храняться в коп. а не в унциях 
 10/01/2014 -для бал.счетов 1525,1526 отбираем остатки по счетам если 
             R013 in ('1','2','3','4','5','6','7') и формируем в показателе
             R013='1' если спецпараметр R013=2,3,5,7
             R013='2' если спецпараметр R013=1
             R013='4' если спецпараметр R013=4 
             R013='9' если спецпараметр R013=6
 03/01/2014 -для бал.счетов 1525,1526 отбираем остатки по счетам если 
             R013 in ('1','2','3','4','5','9') и формируем в показателе 
             R013='4' если спецпараметр R013='4' и R013='1' для всех
             остальных значений спецпараметра R013  
 24/09/2013 -для бал.счетов 3540,3640 отбираем остатки по счетам если 
             R013 in ('4','5','6') и формируем в показателе R013='9' 
 12/01/2013 -для бал.счета 3540 отбираем остаки по счетам если 
             R013 in ('4','5','6') и формируем в показателе R013 
             с этими же значениями
 29/12/2012 -для бал.счета 3540 отбираем остатки по счетам если 
             R013 in ('4','5','6') и формируем в показателе R013='9'
 11/06/2012 -для мфо=324485 формируем glb_= 81 а для мфо=325569 glb_=93
 21/01/2011 -для названия клиента будем выбирать 60 символов 
             согласно телеграмме НБУ от 11.01.2011 N24-618/4  (было 54)
             для нерезидентов название банка выбираем из кл-ра RC_BNK
             поле NAME
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
acc_     Number;
l_acc    number;
nbs_     Varchar2(4);
nbs_o    Varchar2(4);
nls_     Varchar2(15);
dat1_    Date;
data_    Date;
datb_    date;
datr_    date;
kv_      SMALLINT;
dk_      Varchar2(2);
se_      DECIMAL(24);
sn_      DECIMAL(24);
sq_      DECIMAL(24);
sump_    DECIMAL(24);
sumpq_   DECIMAL(24);
mfo_     Varchar2(12);
mfob_    Number;
mfou_    Number;
glb_     Number;
kb_      Varchar2(12);
kb1_     Varchar2(12);
rb_      Varchar2(5);
invk_    Varchar2(1);
nb_      Varchar2(60);
nb1_     Varchar2(60);
kk_      Varchar2(8);
kodp_    Varchar2(35);
kodp1_   Varchar2(35);
znap_    Varchar2(70);
znap1_   Varchar2(70);
ref_     Number;
cs_      Number;
cs1_     Number;
agent_   Number;
r1518_   Number;
r1528_   Number;
den_     Varchar2(2);
tips_    VARCHAR2 (3);
r011_    Varchar2(1);
r011s_   Varchar2(1);
r013_    Varchar2(1);
r013s_   Varchar2(1);
s180_    Varchar2(1);
s180s_    Varchar2(1);
s181_    Varchar2(1);
s240_    Varchar2(1);
s240s_   Varchar2(1);
s245_    Varchar2(1);
s580_    Varchar2(1);
s580s_   Varchar2(1);
s580r_   Varchar2(1);
s580a_   Varchar2(1);
kod_j_   Varchar2(1);

rnk_     Number;
userid_    NUMBER;

nbs_r013_   varchar2(20);

comm_           rnbu_trace.comm%TYPE;
l_znak          smallint;
l_o_sum         number;
l_o_kv          number;
l_se            number;
l_sn            number;
dat_izm1     date := to_date('29/12/2017','dd/mm/yyyy');

--- Остатки
CURSOR SALDO IS
   SELECT a.acc, a.nls, a.kv, a.fdat, a.nbs, c.country, c.codcagent,
          cb.mfo, NVL(rc.glb,0), cb.alt_bic, NVL(cb.rating,' '),
          decode(f_ourmfo, 300205, LTRIM(RTRIM(substr(c.nmkk,1,60))), 
                                   LTRIM(RTRIM(substr(c.nmk,1,60)))), 
          a.ostf-a.dos+a.kos, 
          NVL(trim(sp.r011),'0'),
          NVL(trim(sp.r013),'0'),
          NVL(trim(sp.s180),'0'),
          NVL(trim(sp.s240),'0'),
          NVL(trim(sp.s580),'0'), 
          c.rnk
   FROM (SELECT s.acc, s.nls, s.kv, aa.fdat, s.nbs, aa.ostf,
         aa.dos, aa.kos, s.rnk, s.mdate, s.tip 
         FROM saldoa aa, accounts s
         WHERE aa.acc = s.acc    AND
               s.rnk <> 10009201 AND
              (s.acc,aa.fdat) =
               (select c.acc,max(c.fdat)
                from saldoa c
                where s.acc=c.acc and c.fdat <= Dat_
                group by c.acc)) a,    
        customer c, custbank cb, kl_k040 l, kod_r020 k, 
        rcukru rc, specparam sp 
   WHERE a.nbs=k.r020                   AND
         (a.nbs not in ('1509','1519','1529') OR 
          (a.nbs = '1509' and a.tip='SNA') ) AND 
         trim(k.prem) = 'КБ'            AND
         k.a010 = '26'                  AND
         (k.d_close is null OR 
          k.d_close > Dat_)             AND
         a.acc = sp.acc(+)              AND 
         a.rnk = c.rnk                  AND
         c.rnk = cb.rnk                 AND
         cb.mfo = rc.mfo(+)             AND 
         c.country = TO_NUMBER(l.k040)  AND
         a.ostf-a.dos+a.kos <> 0 ;

CURSOR SALDO_ACC(pacc_ in number) IS
   SELECT a.acc, a.nls, a.kv, a.fdat, a.nbs, c.country, c.codcagent,
          cb.mfo, NVL(rc.glb,0), cb.alt_bic, NVL(cb.rating,' '),
          decode(f_ourmfo, 300205, LTRIM(RTRIM(substr(c.nmkk,1,60))), 
                                   LTRIM(RTRIM(substr(c.nmk,1,60)))), 
          a.ostf-a.dos+a.kos, 
          NVL(trim(sp.r011),'0'),
          NVL(trim(sp.r013),'0'),
          NVL(trim(sp.s180),'0'),
          NVL(trim(sp.s240),'0'),
          NVL(trim(sp.s580),'0'), 
          c.rnk
   FROM (SELECT s.acc, s.nls, s.kv, aa.fdat, s.nbs, aa.ostf,
         aa.dos, aa.kos, s.rnk, s.mdate, s.tip 
         FROM saldoa aa, accounts s
         WHERE aa.acc = s.acc    AND
               s.rnk <> 10009201 AND
              (s.acc,aa.fdat) =
               (select c.acc,max(c.fdat)
                from saldoa c
                where s.acc=c.acc and c.fdat <= Dat_
                group by c.acc)) a,    
        customer c, custbank cb, kl_k040 l, kod_r020 k, 
        rcukru rc, specparam sp 
   WHERE a.acc = pacc_ and
         a.nbs=k.r020                   AND
         (a.nbs not in ('1509','1519','1529') OR 
          (a.nbs = '1509' and a.tip='SNA') ) AND 
         trim(k.prem) = 'КБ'            AND
         k.a010 = '26'                  AND
         (k.d_close is null OR 
          k.d_close > Dat_)             AND
         a.acc = sp.acc(+)              AND 
         a.rnk = c.rnk                  AND
         c.rnk = cb.rnk                 AND
         cb.mfo = rc.mfo(+)             AND 
         c.country = TO_NUMBER(l.k040);
         
CURSOR BaseL IS
    SELECT kodp, znap
    FROM rnbu_trace
order by kodp;

procedure P_Set_S580_Def(r020_ in varchar2, t020_ in varchar2, r011_ in varchar2, s245_ in varchar2) is
begin
   if s580s_ = '0' or r020_ in ('2233', '2238', '2625', '3114', '3570') then
       select nvl(max(s580), '9')
       into s580r_
       from nbur_ref_risk_s580
       where r020 = r020_ and 
            (t020 = t020_ or t020 = '*') and
            (r011 = r011_ or r011 = '*') and
            (S245 = s245_ or S245 = '*') and
            (t097 = invk_ or t097 = '*');
           
       s580_ := s580r_;
   end if;
end;
    
procedure prepare_data(nbs_ in varchar2) is
begin
   r1518_ := 0;
   r1528_ := 0;
   r013_ :='0';
   comm_ := NULL;
   
   if mfo_ = 324485 then
      glb_ := 81;
   end if;
   
   if mfo_ = 325569 then
      glb_ := 93;
   end if;

   IF nbs_ = '1502' and Dat_ < dat_izm1 
   THEN
      if r013s_ = '1' then
         r013_ := '1';
      end if;
      if r013s_ in ('2','9') then
         r013_ := '2';
      end if;
   END IF;

   IF nbs_ in ('1518','1528') and Dat_ < dat_izm1
   THEN
      if r013s_ in ('2','5','7') then
         r013_ := '1';
      end if;
      if r013s_ in ('3','6','8') then
         r013_ := '2';
      end if;
   END IF;

   IF nbs_ in ('1518','1528') and Dat_ < dat_izm1
   THEN
      BEGIN
         select substr(a.nls,1,4) 
            into nbs_o 
         from int_accn i, accounts a
         where i.acra = acc_ 
           and i.acc = a.acc
           and rownum = 1 ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         nbs_o := null;
      END;

      if nbs_o in ('1510','1512') then
         r013_ := '1';
      end if;
 
      if nbs_o in ('1511','1513','1514','1515','1516','1517') then
         r013_ := '2';
      end if;

      if nbs_o in ('1520','1521','1523') then
          r013_ := '1';
      end if;
 
      if nbs_o in ('1522','1524','1525','1526','1527') then
         r013_ := '2';
      end if;

   END IF;

   IF Dat_ >= to_date('10012014','ddmmyyyy') and 
      Dat_ < dat_izm1 and 
      nbs_ in ('1525','1526') then
      if r013s_ in ('2','3','5','7') then
         r013_ := '1';
      elsif r013s_ = '1' then
         r013_ := '2';
      elsif r013s_ = '4' then
         r013_ := '4';
      elsif r013s_ = '6' then
         r013_ := '9';
      else 
         null;
      end if;
   END IF;

   IF nbs_  in ('3540','3640','9100') and Dat_ < dat_izm1
   THEN
      r013_ := r013s_;
   END IF;

   IF nbs_ not in ('1502','1518','1528','1525','1526','3540','3640','9100') and 
      Dat_ < dat_izm1
   THEN
      r013_ := '0';
   END IF;

   IF Dat_ >= dat_izm1
   THEN
      r011_ := r011s_;
      r013_ := r013s_;
      s180_ := s180s_;
      s181_ := '0';
      if s180_ < 'C'
      then
         s181_ := '1';
      end if;

      if s180_ >= 'C'
      then
         s181_ := '2';
      end if;

      s240_ := s240s_;

      kod_j_ := '0';

      s245_ :='1';
      if tips_ in ('SK9','SP ','SPN','OFR','KSP','KK9','KPN') OR
         s240_ = 'Z'
      then
         s245_ :='2';
      elsif  nbs_ like '34__' 
         or  nbs_ like '44__' or  nbs_ like '45__'
         or  nbs_ like '9___'
         or  nbs_ in ('2920','3500')
      then
         s245_ :='0';
      end if;
      
      IF agent_ in (2,4) and (substr(rb_,1,1) = 'A' or substr(rb_,1,1) = 'T' or 
                              substr(rb_,1,1) = 'F' or 
                              rb_ in ('BBB','BBB+','BBB-','Baa1','Baa2','Baa3'))
      THEN
        invk_ := '1';
      ELSE
        invk_ := '2';
      END IF;      
      
      select nvl(max(s580), '9')
            into s580a_
           from nbur_ref_risk_s580
           where r020 = substr(nls_, 1, 4) and 
                (t020 = '1' or t020 = '*') and
                (r011 = r011_ or r011 = '*') and
                (S245 = s245_ or S245 = '*') and
                (t097 = invk_ or t097 = '*');

      if s580a_ = '0' then
         s580_ := null;

         p_set_s580_def(nbs_, (case when sn_<0 then '1' else '2' end), r011s_, s245_);

         if s580_ is not null then
            s580a_ := s580_;
         else
            s580a_ := '9';
         end if;
      end if;
      
      if substr(nls_, 1, 4) in ('1500', '1502') and s245_ = '1' and invk_ = '1' and
         kb_ in ('8260000013', '8400000053', '8400000054')
      then
         s580a_ := '1';
      end if;
      
      if substr(nls_, 1, 4) in ('3540') and r011_ = '2' 
      then
         if s245_ = '1' then
             if r013_ = '1' then
                s580a_ := '3';
             else
                s580a_ := '4';
             end if;
         else
             s580a_ := '5';
         end if;
      end if;   

      if substr(nls_, 1, 4) in ('9200') 
      then
          s580a_ := (case when r013_ = '4' then '3' 
                          when r013_ in ('5', '6') then '4'
                          when r013_ in ('3','8','A') then '1'
                          else '9'
                    end);
      end if;
   END IF;
      
   IF (SN_ <> 0 and ( nbs_ not in ('1525','1526','3540','3640') or 
                     (nbs_ in ('1525','1526') and r013_ in ('1','2','3','4','5','6','7')) or 
                     (nbs_ in ('3540','3640') and r013_ in ('4','5','6'))  
                    ) and Dat_ < dat_izm1) 
           OR
      (SN_ <> 0 and Dat_ >= dat_izm1) 
   THEN

      IF kv_<> 980 THEN
         se_ := GL.P_ICURVAL(kv_, sn_, Dat_) ;
      ELSE
         se_ := sn_ ;
      END IF;
   
      IF Dat_ >= to_date('30092013','ddmmyyyy') and 
         Dat_ < dat_izm1 and 
         nbs_ in ('3540','3640') and 
         r013s_ in ('4','5','6') 
      THEN
         r013_ := '9';
      END IF;   

      IF MOD(agent_,2)=0 THEN
         IF kb_ IS NULL OR kb_=' ' THEN
            kb_ := '0000000000' ;
         ELSE
            kb_ := lpad(kb_,10,'0') ;
         END IF;
      ELSE
         IF mfo_ IS NULL OR mfo_=' ' THEN
            kb_ := '0000000000' ;
         ELSE
            if dat_ < to_date('09072010','ddmmyyyy') then
               kb_ := lpad(mfo_,10,'0') ;
            else 
               kb_ := lpad(glb_,10,'0') ;
            end if;
         END IF;
      END IF;

      IF nbs_ = '1500' THEN

        if se_ < 0 then
          l_o_sum := 0;
          l_o_kv  := 0;

          begin
              select   acc, sum(lie_sum), sum(lie_val)
                into l_acc, l_o_sum,      l_o_kv
                from ( select acc, nvl(to_number(value),0) lie_sum, 0 lie_val
                         from accountsw
                        where acc = acc_
                          and tag = 'LIE_SUM'
                       union
                       select acc, 0 lie_sum, nvl(to_number(value),0) lie_val
                         from accountsw
                        where acc = acc_
                          and tag = 'LIE_VAL' )
               group by acc;

          exception
             when others  then l_o_sum :=0;
                               l_o_kv  :=0;
          end;

          if l_o_sum !=0  then

             comm_ := 'acc '||to_char(acc_)|| ' обтяження' ;

             l_znak :=  IIF_N(se_,0,-1,1,1);
             se_ := abs(se_);
             sn_ := abs(sn_);
  
             if l_o_kv = kv_  or l_o_kv =0  then

                l_se := least(se_,gl.p_icurval(kv_,l_o_sum,dat_));
                l_sn := least(sn_,l_o_sum);
             else

                l_se := least(se_,gl.p_icurval(l_o_kv,l_o_sum,dat_));
                l_sn := least(sn_,gl.p_ncurval(kv_,l_se,dat_));
             end if;

             dk_ := IIF_N(l_znak*se_,0,'10','20','20');
             
             -- за 29/12/2017 (на 01/01/2018) новая структура показателя 
             IF Dat_ < dat_izm1
             THEN
                kodp_:= dk_ || LPAD(to_char(cs_),3,'0') || kb_ || nbs_ ||
                               LPAD(to_char(kv_),3,'0') || '2' ;
             ELSE
                kodp_:= dk_ || LPAD(to_char(cs_),3,'0') || kb_ || nbs_ ||
                        r011_ || r013_ || LPAD(to_char(kv_),3,'0') || '2' ||
                        s181_ || s245_ || s580a_;
             END IF;

             znap_ := TO_CHAR(ABS(l_se)) ;

             INSERT INTO rnbu_trace
                      (nls, kv, odate, kodp, znap, acc, rnk, comm)
               VALUES (nls_, kv_, data_, kodp_, znap_, acc_, rnk_, comm_);

             if kv_ != 980  then

                dk_ := IIF_N(l_znak*se_,0,'11','21','21');
                IF Dat_ < dat_izm1
                THEN
                   kodp_ := dk_ || LPAD(to_char(cs_),3,'0') || kb_ || nbs_ ||
                                  LPAD(to_char(kv_),3,'0') || '2' ;
                ELSE
                   kodp_:= dk_ || LPAD(to_char(cs_),3,'0') || kb_ || nbs_ ||
                           r011_ || r013_ || LPAD(to_char(kv_),3,'0') || '2' ||
                           s181_ || s245_ || s580a_;
                END IF;

                znap_ := TO_CHAR(ABS(l_sn)) ;

                INSERT INTO rnbu_trace
                         (nls, kv, odate, kodp, znap, acc, rnk, comm)
                  VALUES (nls_, kv_, data_, kodp_, znap_, acc_, rnk_, comm_);

             end if;

             se_ := l_znak *greatest(least(se_, l_se),0);
             sn_ := l_znak *greatest(least(sn_, l_sn),0);

          end if;

        end if;
        
        IF Dat_ < dat_izm1
        THEN
           r013_ := '1';
        ELSE
           kod_j_ := '1';
        END IF;

      END IF;          

      if se_ <> 0 then
         dk_ := IIF_N(se_,0,'10','20','20');
         if nbs_ = '1500'  and  dk_='20' and Dat_ < dat_izm1  
         then
            r013_ := '0';
         end if;

         IF Dat_ < dat_izm1
         THEN
            kodp_ := dk_ || LPAD(to_char(cs_),3,'0') || kb_ || nbs_ ||
                     LPAD(to_char(kv_),3,'0') || r013_ ;
         ELSE
            kodp_:= dk_ || LPAD(to_char(cs_),3,'0') || kb_ || nbs_ ||
                    r011_ || r013_ || LPAD(to_char(kv_),3,'0') || kod_j_ ||
                    s181_ || s245_ || s580a_;
         END IF;

         znap_ := TO_CHAR(ABS(se_)) ;

         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, acc, rnk) VALUES
                                (nls_, kv_, data_, kodp_, znap_, acc_, rnk_);
      end if;

      IF kv_<> 980 and sn_ <> 0 
      THEN
         dk_ := IIF_N(sn_,0,'11','21','21');
         if nbs_ = '1500'  and  dk_ = '21'  then
            r013_ := '0';
         end if;

         IF Dat_ < dat_izm1
         THEN
         kodp_ := dk_ || LPAD(to_char(cs_),3,'0') || kb_ || nbs_ ||
                 LPAD(to_char(kv_),3,'0') || r013_ ;
         ELSE
            kodp_:= dk_ || LPAD(to_char(cs_),3,'0') || kb_ || nbs_ ||
                    r011_ || r013_ || LPAD(to_char(kv_),3,'0') || kod_j_ ||
                    s181_ || s245_ || s580a_;
         END IF;

         if kv_ in (959, 961, 962) and mfou_ not in (300465, 380764) then
            znap_ := TO_CHAR(round(ABS(sn_)/10,0));
         else 
            znap_ := TO_CHAR(ABS(sn_)) ;
         end if;

         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, acc, rnk) VALUES
                                (nls_, kv_, data_, kodp_, znap_, acc_, rnk_);
      END IF;

      -- инвестиционный класс только для банков нерезидентов
      if se_ <> 0 or (kv_<> 980 and sn_ <> 0) then
         IF Dat_ < dat_izm1 
         THEN
            kodp_ := '97' || LPAD(to_char(cs_),3,'0') || kb_ || '00000000' ;
         ELSE
            kodp_ := '97' || LPAD(to_char(cs_),3,'0') || kb_ || '0000000000009';
         END IF;
            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, acc, rnk) VALUES
                                (nls_, kv_, data_, kodp_, invk_, acc_, rnk_);

         IF MOD(agent_,2)=0 THEN
            BEGIN
               select name 
                  into nb_
               from rc_bnk
               where b010 = kb_;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               null;
            END;
         ELSE 
            BEGIN
               select nb 
                  into nb_
               from rcukru
               where mfo = mfo_;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               null;
            END;
         END IF;

         IF Dat_ < dat_izm1
         THEN
            kodp_ := '98' || LPAD(to_char(cs_),3,'0') || kb_ || '00000000' ;
         ELSE
            kodp_ := '98' || LPAD(to_char(cs_),3,'0') || kb_ || '0000000000009';
         END IF;

         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, acc, rnk) VALUES
                                (nls_, kv_, data_, kodp_, nb_, acc_, rnk_);

         IF Dat_ < dat_izm1
         THEN
            kodp_ := '99' || LPAD(to_char(cs_),3,'0') || kb_ || '00000000' ;
         ELSE
            kodp_ := '99' || LPAD(to_char(cs_),3,'0') || kb_ || '0000000000009';
         END IF;

         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, acc, rnk) VALUES
                                (nls_, kv_, data_, kodp_, rb_, acc_, rnk_);
      end if;

   end if;
end;


BEGIN
-------------------------------------------------------------------
EXECUTE IMMEDIATE 'truncate table rnbu_trace';

userid_ := user_id;
-------------------------------------------------------------------
EXECUTE IMMEDIATE 'alter session set NLS_NUMERIC_CHARACTERS=''.,''';

-- свой МФО
mfob_:=f_ourmfo();

-- МФО "родителя"
BEGIN
   SELECT NVL(trim(mfou), mfob_)
      INTO mfou_
   FROM BANKS
   WHERE mfo = mfob_;
EXCEPTION WHEN NO_DATA_FOUND THEN
   mfou_ := mfob_;
END;

den_ := to_char(Dat_,'DD');

if to_number(den_) <=10 then
   Dat1_ := to_date('01'||to_char(Dat_,'MM')||to_char(Dat_,'YYYY'),'ddmmyyyy');
elsif to_number(den_)<=20 then
   Dat1_ := to_date('11'||to_char(Dat_,'MM')||to_char(Dat_,'YYYY'),'ddmmyyyy');
else
   Dat1_ := to_date('21'||to_char(Dat_,'MM')||to_char(Dat_,'YYYY'),'ddmmyyyy');
end if;

-- дата розрахунку резервiв
select  max(dat)
into datb_
from rez_protocol
where dat_bank is not null and
     dat_bank <= dat_ and
     dat <= dat_  ;

if datb_ is null then
  datr_ := add_months(last_day(dat_)+1,-1);
else
  datr_ := last_day(datb_) + 1;
end if;

sump_ := 0 ;
znap1_ := '0' ;
kodp1_ := '0' ;

OPEN SALDO;
LOOP
   FETCH SALDO INTO acc_, nls_, kv_, data_, nbs_, cs_, agent_, mfo_,
                    glb_, kb_, rb_, nb_, sn_, r011s_, r013s_, 
                    s180s_, s240s_,  s580s_, rnk_ ;
   EXIT WHEN SALDO%NOTFOUND;

   prepare_data(nbs_);

END LOOP;
CLOSE SALDO;
---------------------------------------------------
-- розшифровка рахунків резерву
   for k in ( select /*+index(t PK_NBU23REZ_ID) */
                t.acc, t.nls, t.kv, t.rnk, t.isp, 
                t.nd, nvl(nvl(t.nls_rez, t.nls_rezn), t.nls_rez_30) nls_rez, 
                t.rez*100 rez, 
                gl.p_icurval(t.kv, t.rez*100, dat_) rezq, 
                NVL(sp.r013,'0') r013,
                t.s080, t.id, t.ob22, c.custtype,
                nvl(nvl(t.acc_rez, t.acc_rezn), t.acc_rez_30) accr 
              from nbu23_rez t, specparam sp, customer c
              where t.fdat = datr_ 
                and t.id not like 'NLO%' 
                and t.id not like 'CAC%' 
                and (nvl(nvl(t.nls_rez, t.nls_rezn), t.nls_rez_30) like '1509%'  OR
                     nvl(nvl(t.nls_rez, t.nls_rezn), t.nls_rez_30) like '1519%'  OR 
                      nvl(nvl(t.nls_rez, t.nls_rezn), t.nls_rez_30) like '1529%'  
                    ) 
                and (t.rez <> 0 or t.rezq <> 0)
                and nvl(nvl(t.acc_rez, t.acc_rezn), t.acc_rez_30) = sp.acc(+) 
                and t.rnk = c.rnk
            )
   loop
      nbs_r013_ := f_ret_nbsr_rez(k.nls, k.r013, k.s080, k.id, k.kv, k.ob22, k.custtype, k.accr);
      
      nbs_ := substr(nbs_r013_, 1, 4);
      r013_ := substr(nbs_r013_, 5, 1);

      begin
         select max(kodp) 
            into kodp_
         from rnbu_trace
         where acc = k.acc
           and substr(kodp,1,6) not in ( '201509','211509',
                                         '201519','211519',
                                         '201529','211529'
                                       ) 
           and substr(kodp,1,2) in ( '10','11', '20', '21');
                                       
      exception 
         when no_data_found then
              kodp_ := null;
      end;
      
      if kodp_ is not null then
         znap_ := to_char(k.rezq);
         comm_ := ' розшифровка рахунку резерву ';
            
         kodp_ := '20' || substr(kodp_,3,13) || nbs_ || substr(kodp_,20,1) || 
                        r013_ || substr(kodp_,22);

         INSERT INTO rnbu_trace
                           ( recid, userid,
                             nls, kv, odate, kodp,
                             znap, acc,
                             rnk, isp, 
                             comm, nd
                           )
          VALUES (s_rnbu_record.NEXTVAL, userid_,
                  k.nls, k.kv, dat_, kodp_,
                  znap_, k.acc, k.rnk, k.isp, 
                  comm_, k.nd );
      
          if k.kv <> 980 
          then
             kodp_ := '21' || substr(kodp_,3,13) || nbs_ || substr(kodp_,20,1) || 
                        r013_ || substr(kodp_,22);

             znap_ := to_char(k.rez);

             INSERT INTO rnbu_trace
                              ( recid, userid,
                                nls, kv, odate, kodp,
                                znap, acc,
                                rnk, isp, 
                                comm, nd
                              )
               VALUES (s_rnbu_record.NEXTVAL, userid_,
                      k.nls, k.kv, dat_, kodp_,
                      znap_, k.acc, k.rnk, k.isp, 
                      comm_, k.nd);
          end if;
      else
         OPEN SALDO_ACC(k.acc);
         LOOP
            FETCH SALDO_ACC INTO acc_, nls_, kv_, data_, nbs_, cs_, agent_, mfo_,
                        glb_, kb_, rb_, nb_, sn_, r011s_, r013s_, 
                        s180s_, s240s_,  s580s_, rnk_ ;
            EXIT WHEN SALDO_ACC%NOTFOUND;

            nbs_ := substr(nbs_r013_, 1, 4);
            r013s_ := substr(nbs_r013_, 5, 1);
            
            sn_ := k.rez;
            se_ := k.rezq;
            
            prepare_data(nbs_);
         END LOOP;
         CLOSE SALDO_ACC;
      end if;
   end loop;
---------------------------------------------------
DELETE FROM tmp_nbu where kodf='26' and datf= dat_;
---------------------------------------------------
sump_ := 0;
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   IF kodp1_ = '0' THEN
      kodp1_ := kodp_ ;
   END IF ;
   IF kodp1_ <> kodp_ THEN
      IF TO_NUMBER(SUBSTR(kodp1_,1,2))<97 THEN
         INSERT INTO tmp_nbu (kodf, datf, kodp, znap)
                      VALUES ('26', Dat_, kodp1_, TO_CHAR(sump_));
      END IF ;

      IF TO_NUMBER(SUBSTR(kodp1_,1,2))>96 THEN
         INSERT INTO tmp_nbu (kodf, datf, kodp, znap)
                      VALUES ('26', Dat_, kodp1_, LTRIM(RTRIM(znap1_)));
      END IF ;

      sump_ := 0 ;
      znap1_ := ' ' ;
      kodp1_ := kodp_ ;

   END IF ;
   IF kodp1_ = kodp_ AND TO_NUMBER(SUBSTR(kodp1_,1,2)) < 97 THEN
      sump_ := sump_+TO_NUMBER(znap_) ;
   END IF ;
   IF kodp1_ = kodp_ AND TO_NUMBER(SUBSTR(kodp1_,1,2)) > 96 THEN
      znap1_ := znap_ ;
   END IF ;

END LOOP;
CLOSE BaseL;

IF kodp1_ IS NOT NULL  AND  TO_NUMBER(SUBSTR(kodp1_,1,2))>96 THEN
   INSERT INTO tmp_nbu (kodf, datf, kodp, znap)
                VALUES ('26', Dat_, kodp1_, znap1_);
END IF ;
---------------------------------------------------
END p_f26;
/
show err;

PROMPT *** Create  grants  P_F26 ***
grant EXECUTE                                                                on P_F26           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F26           to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F26.sql =========*** End *** ===
PROMPT ===================================================================================== 

