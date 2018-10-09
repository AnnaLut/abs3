CREATE OR REPLACE PROCEDURE BARS.P_F07_NN (Dat_ DATE,
                                      sheme_ varchar2 default 'G')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Процедура формирование файла #07 для КБ
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 20/09/2018 (11/09/2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата
               sheme_ - схема формирования
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
11.09.2018 - для 14 розд?лу виконується розбивка на обтяжен? ? 
             необтяжен? ЦП ? для необтяжених зам?на параметру R011
08.08.2018 - изменено формирование переменной KIL_ (кол-во ЦБ) 
09.02.2018 - закоментарил блок присвоения K072='N1' для нерезидентов
06.02.2018 - изменено формирование переменной для количества ЦБ
22.01.2018 - изменено формирование кода показателя (после включения 
             блока расшифровки счетов резерва)  
19.01.2018 - для KOD_R020 добавлены условия для полей D_OPEN и D_CLOSE
18.01.2018 - для определения переменной KIL_ (кол-во ЦБ) добавлено
             begin  ... exception ... end (возникала ошибка) 
09.01.2018 - новая структура показателя (24 символа вместо 13)
             добавляется код L - 1-сумма, 3-кол-во, 9-код ЦП за кодом
             випуску, добавляется код MMM-код країни, код L - код
             строку до погашення и код NNNN - порядковий номер ЦП 
29.03.2016 - на 01.04.2016 будет формироваться новая часть показателя
             "код виду ц_нних папер_в" (параметр S130 2-х значный код)
10.07.2015 - для KL_K070 добавлено условие "D_CLOSE is null"
             после перехода на DRAPS(ы) не будем добавлять коректирующие
             проводки по родительским счетам (они уже добавлены)
25.02.2015 - для нерезидентов параметр K072 будет равен '0'
             (изменения необходимы для ФЛ предпринимателей Крыма)
07.02.2014 - для бал.счета 3115 выбираем родительские счета вместо
             дочерних (Замечание ГОУ)
21.01.2014 - добавлен блок для наполнения корректирующих проводок
             прошлого и текущего отчетных месяцев по родительским счетам
             из дочерних (счета для ЦБ)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='07';
rnk_     number;
typ_     number;
acc_     Number;
acc1_    Number;
mfo_     Number;
mfou_    Number;
nbs_     Varchar2(4);
nls_     Varchar2(15);
tips_    Varchar2(3);
data_    Date;
Dat1_    Date;
Dat2_    Date;
dat_kl_  Date; 
kv_      SMALLINT;
rez_     SMALLINT;
se_      DECIMAL(24);
sn_      DECIMAL(24);
Ostn_    DECIMAL(24);
Ostq_    DECIMAL(24);
Dos96_   DECIMAL(24);
Kos96_   DECIMAL(24);
Dosq96_  DECIMAL(24);
Kosq96_  DECIMAL(24);
dk_      Char(1);
kodp_    Varchar2(24);
znap_    Varchar2(30);
s180_    Varchar2(1);
s183_    Varchar2(1);
r011_    Varchar2(1);
r011_n   Varchar2(1);
r012_    Varchar2(1);
s120s_   Varchar2(1);
s120_    Varchar2(1);
s130_    Varchar2(2);
k071_    Varchar2(1);
k072_    Varchar2(2);
r031_    Char(1);
kol_     Number;
pr_accc  Number;
userid_  Number;
nbuc1_   varchar2(12);
nbuc_    varchar2(12);
DatN_    date;
sql_acc_ varchar2(2000):='';
sql_doda_ varchar2(200):='';
ret_     number;
dats_    Date;
dat_izm1 Date := to_date('29122017','ddmmyyyy');
dat23_   Date;
country_ Varchar2(3);
s240_    Varchar2(1);
mdate_   Date;
comm_    varchar2(200);
nnnn_    Number;
cp_id_   Varchar2(20);
KIL_     Number;
recid_   Number;
sum_zal_ Number;

---Значение R011 из кл-ра KL_R011
CURSOR SCHETA IS
   SELECT k.r011
   FROM accounts a, accounts b, kl_r011 k
   WHERE a.nbs = nbs_ and a.nbs = k.r020 and a.kv = b.kv and
         substr(a.nls,6,9) = substr(b.nls,6,9) and
         b.nbs = k.r020r011 and trim(k.prem) = 'КБ' and a.acc = acc_ ;

--Остатки
CURSOR Saldo IS
   SELECT s.rnk, s.acc, s.nls, s.kv, s.fdat, s.nbs,
          NVL(cd.k071,'0'), NVL(cd.k072,'0'), 2-mod(cc.codcagent,2),
          s.ost, s.ostq, s.dos96, s.kos96, s.dosq96, s.kosq96,
          NVL ( sp.s130, '00'), lpad (to_char(cc.country), 3, '0'),
          NVL(sp.s240, '0'), a.mdate, a.tip
   FROM  otcn_saldo s, customer cc, kl_k070 cd, specparam sp, otcn_acc a
   WHERE (s.ost-s.dos96+s.kos96<>0 OR s.ostq-s.dosq96+kosq96 <> 0)
     and a.acc = s.acc 
     and s.rnk = cc.rnk
     and cc.ise = cd.k070(+)
     and cd.d_open <= dat_
     and (cd.d_close is null or cd.d_close > dat_)
     and s.acc = sp.acc (+);

procedure p_ins(p_dat_ date, p_tp_ varchar2, p_nls_ varchar2,p_nbs_ varchar2,
          p_kv_ smallint, p_country_ varchar2, 
                p_r011_ varchar2, p_k071_ varchar2,
          p_s183_ varchar2, p_s130_ varchar2,
                p_s240_ varchar2, p_nnnn_ number,
                p_acc_ number, p_rnk_ number, 
                p_znap_ varchar2, p_nbuc_ varchar2) IS
                kod_ varchar2(23);

begin

   kod_:= '1' ||p_tp_ || p_nbs_ || p_r011_ || p_k071_ || lpad(p_kv_,3,'0') || 
          p_s183_ || p_s130_ || p_country_ || p_s240_ || lpad(to_char(p_nnnn_), 4, '0');

   INSERT INTO rnbu_trace
            (nls, kv, odate, kodp, znap, nbuc, acc, rnk)
   VALUES  (p_nls_, p_kv_, p_dat_, kod_, p_znap_, p_nbuc_, p_acc_, p_rnk_);
end;
-----------------------------------------------------------------------------
BEGIN
   commit;

EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
-------------------------------------------------------------------
logger.info ('P_F07_NN: Begin ');
-------------------------------------------------------------------
userid_ := user_id;

EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
mfo_:=F_OURMFO();

-- МФО "родителя"
BEGIN
  SELECT mfou
    INTO mfou_
  FROM BANKS
  WHERE mfo = mfo_;
EXCEPTION WHEN NO_DATA_FOUND THEN
  mfou_ := mfo_;
END;

-- определение кода МФО или кода области для выбранного файла и схемы
p_proc_set(kodf_,sheme_,nbuc1_,typ_);

-- вираховуємо зв_тну дату "станом на" для класиф_катора
dat_kl_ := add_months(trunc(dat_, 'mm'), 1);

-- вираховуємо дату на яку розраховано резерв
Dat23_ := TRUNC(add_months(Dat_,1),'MM');

if mfou_ = 300465 then
   sql_acc_ :=       'select r020 from kod_r020 where trim(prem)=''КБ'' and a010=''07'' ';
   sql_acc_ := sql_acc_ || 'and d_open<=to_date('''||to_char(dat_kl_, 'ddmmyyyy')||''',''ddmmyyyy'') ';
   sql_acc_ := sql_acc_ || 'and (d_close is null or d_close>to_date('''||to_char(dat_kl_, 'ddmmyyyy')||''',''ddmmyyyy''))) or ';
   sql_acc_ := sql_acc_ || '(nbs is null and substr(nls,1,4) in
                (select r020 from kod_r020 where trim(prem)=''КБ'' and a010=''07'' ';
   sql_acc_ := sql_acc_ || 'and d_open<=to_date('''||to_char(dat_kl_, 'ddmmyyyy')||''',''ddmmyyyy'') ';
   sql_acc_ := sql_acc_ || 'and (d_close is null or d_close>to_date('''||to_char(dat_kl_, 'ddmmyyyy')||''',''ddmmyyyy''))) ';
else
      sql_acc_ := 'select r020 from kod_r020 where trim(prem)=''КБ'' and a010=''07'' ';
      sql_acc_ := sql_acc_ || 'and d_open<=to_date('''||to_char(dat_kl_, 'ddmmyyyy')||''',''ddmmyyyy'') ';
      sql_acc_ := sql_acc_ || 'and (d_close is null or d_close>to_date('''||to_char(dat_kl_, 'ddmmyyyy')||''',''ddmmyyyy'')) ';
end if;

ret_ := f_pop_otcn(Dat_, 2, sql_acc_,null,1); -- после перехода на SNAP таблицы

BEGIN
  SELECT TO_DATE(val,'DDMMYYYY')
     INTO dats_
  FROM params WHERE par='DATRAPS';
EXCEPTION
  WHEN NO_DATA_FOUND
THEN
  dats_ := null;
END;

if mfou_ = 300465 then
  -- блок для наполнения корректирующих проводок
  -- прошлого и текущего отчетных месяцев
  -- по родительским счетам из дочерних
  IF dats_ is null
  THEN
     for tt in ( select a.accc accc, a.acc acc, a.nls, a.kv,
                        s.crdos, s.crdosq, s.crkos, s.crkosq,
                        s.cudos, s.cudosq, s.cukos, s.cukosq
                 from accounts a, agg_monbals s, kod_r020 k
                 where a.accc is not null
                   and a.acc = s.acc
                   and s.fdat = dat_
                   and a.nls like k.r020 || '%'
                   and a010 = '02'
                   and trim(prem)='КБ'
               )

        loop
     
           if tt.cudos+tt.cudosq+tt.cukos+tt.cukosq+tt.crdos+tt.crdosq+tt.crkos+tt.crkosq<>0 then

              update otcn_saldo set dos96p=dos96p+tt.cudos, dosq96p=decode(tt.kv,980,0,dosq96p+tt.cudosq),
                                    kos96p=kos96p+tt.cukos, kosq96p=decode(tt.kv,980,0,kosq96p+tt.cukosq),
                                    dos96=dos96+tt.crdos,   dosq96=decode(tt.kv,980,0,dosq96+tt.crdosq),
                                    kos96=kos96+tt.crkos,   kosq96=decode(tt.kv,980,0,kosq96+tt.crkosq)
              where acc = tt.accc;
           end if;

     end loop;
  END IF;

  -- коригуюч_ за минулий м_сяць добавляємо по "родительским" рахункам
  IF to_char(dats_,'MM') = to_char(Dat_,'MM')
  THEN
     for tt in ( select a.accc accc, a.acc acc, a.nls, a.kv,
                        s.crdos, s.crdosq, s.crkos, s.crkosq,
                        s.cudos, s.cudosq, s.cukos, s.cukosq
                 from accounts a, agg_monbals s, kod_r020 k
                 where a.accc is not null
                   and a.acc = s.acc
                   and s.fdat = dat_
                   and a.nls like k.r020 || '%'
                   and a010 = '02'
                   and trim(prem)='КБ'
               )

        loop

           if tt.cudos+tt.cudosq+tt.cukos+tt.cukosq<>0 then

              update otcn_saldo set dos96p = dos96p + tt.cudos,
                                    dosq96p = dosq96p + decode(tt.kv, 980, 0, tt.CUdosq),
                                    kos96p = kos96p + tt.cukos,
                                    kosq96p = kosq96p + decode(tt.kv, 980, 0, tt.CUkosq)
              where acc = tt.accc;
           end if;
     end loop;
  END IF;

end if;
-------------------------------------------------------------------
   if mfo_ = 300465 then
         pul_dat(to_char(Dat_,'dd-mm-yyyy'), '');

         EXECUTE IMMEDIATE 'delete from otcn_f42_cp';

         sql_acc_ :=
                'insert into otcn_f42_cp (fdat, acc, nls, kv, sum_zal, dat_zal, rnk, kodp) '
              ||'select c.fdat, a.acc, a.nls, a.kv, nvl(c.sum_zal, 0), c.dat_zal, a.rnk, null '
              ||'from accounts a, cp_v_zal_acc c '
              ||'where a.acc = c.acc '
              ||'  and c.fdat = :dat_ '
              ||'  and substr(a.nls,1,4) like ''14__%''' ;

            EXECUTE IMMEDIATE sql_acc_ USING dat_;
   end if;
-------------------------------------------------------------------

nnnn_ := 0;
----------------------------------------------------------------------
OPEN SALDO;
LOOP
   FETCH SALDO INTO rnk_, acc_, nls_, kv_, data_, nbs_, k071_, k072_, rez_,
                    Ostn_, Ostq_, Dos96_, Kos96_, Dosq96_, Kosq96_, s130_, 
                    country_, s240_, mdate_, tips_;
   EXIT WHEN SALDO%NOTFOUND;

   if substr(nls_, 1, 4)  not in ('1419', '1429', '3107', '3119', '3219') OR
      (substr(nls_, 1, 4) = '3119'  and tips_ = 'SNA')
   then

      IF kv_ <> 980 THEN
         se_ := Ostq_-Dosq96_+Kosq96_;
         if se_ = 0 then
            se_ := GL.P_ICURVAL(kv_, Ostn_-Dos96_+Kos96_, Dat_);
         end if;
      ELSE
         se_ := Ostn_-Dos96_+Kos96_;
      END IF;

      if nbs_ is null then
         -- отбор корректирующих по дочерним счетам ЦБ
         BEGIN
            SELECT NVL(SUM(DECODE(a.DK, 0, a.s, 0)),0),
                   NVL(SUM(DECODE(s.kv,980,0,DECODE(a.DK, 0, Gl.P_Icurval(s.kv, a.s, p.vDat),0))),0),
                   NVL(SUM(DECODE(a.DK, 1, a.s, 0)),0),
                   NVL(SUM(DECODE(s.kv,980,0,DECODE(a.DK, 1, Gl.P_Icurval(s.kv, a.s, p.vDat),0))),0)
                INTO dos96_, dosq96_, kos96_, kosq96_
            FROM ref_kor p, opldok a, otcn_saldo s
            WHERE a.sos = 5
              and a.fdat >= dat_+1
              and a.fdat <= dat_+28
              and a.ref = p.ref
              and a.acc = s.acc
             and s.acc = acc_;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            dos96_ := 0;
            dosq96_ := 0;
            kos96_ := 0;
            kosq96_ := 0;
         END;

         IF kv_ <> 980 THEN
            se_ := Ostq_ - Dosq96_ + Kosq96_;
            if se_ = 0 then
               se_ := GL.P_ICURVAL(kv_, Ostn_ - Dos96_ + Kos96_, Dat_);
            end if;
         ELSE
            se_ := Ostn_ - Dos96_ + Kos96_;
         END IF;

      end if;

      IF se_ <> 0 THEN
         if typ_ > 0 then
            nbuc_ := nvl(f_codobl_tobo_new(acc_,dat_,typ_),nbuc1_);
         else
            nbuc_ := nbuc1_;
         end if;

         pr_accc:=0;

         if mfou_ = 300465 and substr(nls_,1,3) in ('140','141','142','143','144',
                                                    '300','301','310','311','312',
                                                    '313','321','330','331','410',
                                                    '420') 
         then
            if nbs_ is not null and 
               nbs_ not in ('1435','3007','3107') 
            then
               BEGIN
                  SELECT count(*)
                     INTO pr_accc
                  FROM otcn_saldo a, accounts s
                  WHERE s.accc = acc_
                    and s.accc = a.acc
                    and s.nbs is null;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  pr_accc := 0;
               END ;
            end if;
         end if;

         if mfou_ = 300465 and
            (nbs_ is null
              and substr(nls_,1,4) not in ('1435','3007','3107'  )
              OR
             pr_accc = 0 and nbs_ is not null) OR
            mfou_ not in (300465) 
         then
            if nbs_ is null then
               nbs_ := substr(nls_,1,4);
            end if;
-----------------------------------------------------------------------------
            begin
               r011_ := '0';

               BEGIN
                  SELECT count(*) INTO kol_
                  FROM KL_R011
                  WHERE r020 = nbs_ ;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  kol_ := 0;
               END ;

               IF kol_<>0 THEN
                  BEGIN
                     SELECT acc, nvl(r011,'0') into acc1_, r011_
                     FROM specparam
                     WHERE acc = acc_ ;
                  EXCEPTION WHEN NO_DATA_FOUND THEN
                     acc1_ := 0;
                     r011_ := '0';
                  END ;

                  IF acc1_=0  THEN
                     insert into specparam (acc,r011) values (acc_,'0') ;
                     acc1_ := acc_;
                  END IF;

                  IF r011_ = '0' THEN
                     OPEN SCHETA;
                        LOOP
                           FETCH Scheta INTO r012_ ;
                           EXIT WHEN Scheta%NOTFOUND;

                           IF acc1_>0 and r011_='0' THEN
                              update specparam set r011 = r012_ where acc = acc_ ;
                              r011_ := r012_ ;
                           END IF;

                        END LOOP;
                     CLOSE Scheta;
                  END IF ;
               END IF;

               IF (kol_ <> 0 and r011_ = '0') or k072_ = '00' THEN
                  nls_ := 'X' || nls_;
               END IF;
            end;

            BEGIN
               SELECT DECODE(Trim(s180), NULL, Fs180(acc_,SUBSTR(nbs_,1,1), dat_), s180)
               INTO s180_
               FROM specparam
               WHERE acc = acc_ ;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               s180_ := '0';
            END ;

            IF substr(nbs_,1,3) in ('140','301') and s180_='0' THEN
               s180_ := '1';
            END IF;

            -- с 01.02.2007 добавляется параметр S183
            BEGIN
               SELECT NVL(s183,'0')
                  INTO S183_
               FROM kl_s180
               WHERE s180 = s180_;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               s183_ := '0';
            END ;

            if S130_ in ('1D', '1E', '1Y', '20', '21', '22', '23', '24', '25', '26', '27', '2X', '2Y', '30', '90') then
               s183_ := '0';
            end if;

            nnnn_ := nnnn_ + 1;
       
            if s240_ = '0'
            then
               s240_ := fs240(dat_, acc_);
            end if;
   
            dk_ := IIF_N(se_,0,'1','2','2');

            -- обтяження по ЦП
            if nls_ like '14%' OR nls_ like 'X14%' 
            then
                select nvl(sum(sum_zal), 0)
                into sum_zal_
                  from otcn_f42_cp
                  where fdat = dat_
                    and acc = acc_;
            else
                sum_zal_ := 0;
            end if;
     
            if sum_zal_ <> 0 then
               -- необтяжен_ ЦП 
               p_ins(data_, dk_, nls_, nbs_, kv_, country_, r011_, k072_, s183_, 
                     s130_, s240_, nnnn_, acc_, rnk_, TO_CHAR(ABS(se_ - sum_zal_)), nbuc_);

               -- обтяжен_ ЦП
               r011_n := r011_;
               if r011_ = 'C' 
               then
                  r011_n := '1';
               elsif r011_ = 'D' then
                  r011_n := '2';
               elsif r011_ = 'E' then 
                  r011_n := '3';
               else 
                  null;
               end if;

               p_ins(data_, dk_, nls_, nbs_, kv_, country_, r011_n, k072_, s183_, 
                     s130_, s240_, nnnn_, acc_, rnk_, TO_CHAR(ABS(sum_zal_)), nbuc_);
            else
               p_ins(data_, dk_, nls_, nbs_, kv_, country_, r011_, k072_, s183_, 
                     s130_, s240_, nnnn_, acc_, rnk_, TO_CHAR(ABS(se_)), nbuc_);
            end if;

--            p_ins(data_, dk_, nls_, nbs_, kv_, country_, r011_, k072_, s183_, 
--                  s130_, s240_, nnnn_, acc_, rnk_, TO_CHAR(ABS(se_)), nbuc_);
         end if;
      END IF;
   end if;

END LOOP;
CLOSE SALDO;
--------------------------------------------------------------------------
-- перекодування параметру S240
    update rnbu_trace
       set kodp =substr(kodp,1,18)||'M'||substr(kodp,20)
     where substr(kodp,19,1) in ('G','H');

    update rnbu_trace
       set kodp =substr(kodp,1,18)||'L'||substr(kodp,20)
     where substr(kodp,19,1) in ('E','F');

    update rnbu_trace
       set kodp =substr(kodp,1,18)||'K'||substr(kodp,20)
     where substr(kodp,19,1) in ('C','D');

    update rnbu_trace
       set kodp =substr(kodp,1,18)||'J'||substr(kodp,20)
     where substr(kodp,19,1) in ('6','7','8','A','B');

    update rnbu_trace
       set kodp =substr(kodp,1,18)||'I'||substr(kodp,20)
     where substr(kodp,19,1) in ('3','4','5');
--------------------------------------------------------------------------
-- блок формування коду ЦП _з CP_KOD поле CP_ID
begin

   for k in ( select acc 
              from rnbu_trace
               where acc is not null
            )
      loop

         begin
            select  NVL(ck.cp_id, 'YYYYYYYYYY') 
               into cp_id_
            from cp_deal cd, cp_kod ck 
            where k.acc  in  (cd.acc, cd.accd, cd.accp, cd.accr, cd.accr2, cd.accr3,   
                              cd.accs, cd.accexpn, cd.accexpr, cd.accunrec)
              and cd.id = ck.id
              and cd.active in (1, -1) 
              and rownum = 1;  
         exception when no_data_found then
            begin
                select NVL(ck.cp_id, 'YYYYYYYYYY') 
                   into cp_id_
                from cp_accounts ca, cp_deal cd, cp_kod ck               
                where ca.cp_acc = k.acc and
                      ca.cp_ref = cd.ref and 
                      cd.id = ck.id and 
                      cd.active in (1, -1) and
                      rownum = 1;
            exception when no_data_found then                         
                cp_id_ := 'YYYYYYYYYY';
            end;
         end ;    

         update rnbu_trace set comm = cp_id_ where acc = k.acc;

      end loop;
       
end;

-- блок для формування частини коду NNNN 
-- по зростанню кода CP_ID
begin
   nnnn_ := 0;
   cp_id_ := null;

   for k in ( select * from rnbu_trace 
              where kodp not like '3%' 
                and kodp not like '9%'
              order by comm
            )
      
      loop
         
         if cp_id_ is null OR (cp_id_ is not null and cp_id_ <> trim(k.comm))
         then
            cp_id_ := trim(k.comm);
            nnnn_ := nnnn_ + 1;

            begin
                select ROUND ( sum (
                 (  (FOSTZN (cd.acc,  Dat_) + FOSTZN (cd.accexpn,  Dat_))
                  / NULLIF (F_CENA_CP (cd.id, Dat_, 0), 0)
                  * DECODE (ck.tip, 1, -1, 1)
                  / 100)),
                 0)
                   into KIL_ 
                 from cp_deal cd, cp_kod ck 
                 where cd.id = ck.id
                   and ck.cp_id = trim(k.comm);
            exception
                when no_data_found then 
                    KIL_ := 0;
            end;

            kodp_ := '3000000' || substr(k.kodp, 8, 11) || '0' || 
                      lpad( to_char(nnnn_), 4, '0');
            znap_ := to_char(KIL_);

            INSERT INTO rnbu_trace
                    (nls, kv, odate, kodp, znap, nbuc, acc, rnk, comm)
            VALUES  (k.nls, k.kv, dat_, kodp_, znap_, k.nbuc, k.acc, k.rnk, cp_id_);

            kodp_ := '9000000' || substr(k.kodp, 8, 11) || '0' || 
                      lpad( to_char(nnnn_), 4, '0');

            if mfo_ in (351823, 352457)
            then
               znap_ := substr(cp_id_, 3);
            else
               znap_ := cp_id_;
            end if;

            INSERT INTO rnbu_trace
                    (nls, kv, odate, kodp, znap, nbuc, acc, rnk, comm)
            VALUES  (k.nls, k.kv, dat_, kodp_, znap_, k.nbuc, k.acc, k.rnk, cp_id_);

         end if;

         update rnbu_trace set kodp = substr(k.kodp,1,19) || 
                                      lpad( to_char(nnnn_), 4, '0')
         where acc = k.acc and kodp like '1%' and kodp = k.kodp;

      end loop;
end;
---------------------------------------------------------------------------
-- формирование показателей для счетов резерва 1419, 1429, 3107, 3119, 3219
if dat_ >= dat_izm1 
then

   dats_ := trunc(dat_, 'mm');

   for k in (select /*+ leading(r) */
                    t.nls, t.kv, t.dat, t.szq, t.sz, gl.p_icurval(t.kv, t.sz, dat_) sz1,
                    t.s080, t.rnk, t.nd nd, t.tobo,
                    r.acc, r.odate, r.kodp, r.comm, r.nd ndr, t.id, 
                    substr(r.kodp,7,1) r011
             from v_tmp_rez_risk t, rnbu_trace r, agg_monbals m 
             where t.dat=Dat23_
               and t.acc = r.acc
               and substr(r.kodp,3,4) not in ('1419','1429','3107','3119','3219') 
               and r.kodp not like '3%'
               and r.kodp not like '9%'
               and t.acc = m.acc 
               and m.fdat = dats_
               and m.ost - m.crdos + m.crkos <> 0                            
            )
   loop
      se_ := NVL(k.sz1, k.szq);
      dk_ := '2';
      rnk_ := k.rnk;
      acc_ := k.acc;
      nls_ := k.nls;
      kv_ := k.kv;
      data_ := k.odate;

      IF typ_ > 0 THEN
         nbuc_ := NVL(F_Codobl_Tobo(k.acc,typ_), nbuc1_);
      ELSE
         nbuc_ := nbuc1_;
      END IF;

      if k.nls like '141%'
      then
         nbs_ := '1419';
      elsif k.nls like '142%' then
         nbs_ := '1429';
      elsif k.nls like '310%' then
         nbs_ := '3107';
      elsif k.nls like '311%' then
         nbs_ := '3119';
      elsif k.nls like '321%' then
         nbs_ := '3219';
      else
         null;
      end if;
  
      -- обработка счетов резерва
      if se_ <> 0  
      then
         kodp_:= '1' || dk_ || nbs_ || substr(k.kodp, 7, 17);

         znap_ := to_char(ABS(se_));

         INSERT INTO rnbu_trace
            (nls, kv, odate, kodp, znap, nbuc, rnk, acc, comm)
         VALUES
            (nls_, kv_, dat_, kodp_, znap_, nbuc_, rnk_, acc_, k.comm);
      end if;
   end loop;
      
   -- блок для формирования разницы остатков по счетам 1419, 1429, 3107, 3119, 3219
   for k in (select a.nbs, a.kv,  
                    sum(a.Ost) Ostn, sum(a.Ostq) Ostq,
                    sum(a.Dos96) dos96, sum(a.Kos96) Kos96,
                    sum(a.Dosq96) Dosq96, sum(a.Kosq96) kosq96
             from otcn_saldo a 
             where a.nbs in ('1419', '1429', '3107', '3119', '3219') 
               and (a.Ost-a.Dos96+a.Kos96 <> 0  or a.Ostq-a.Dosq96+a.Kosq96<>0)
             group by a.nbs, a.kv  
             order by 1,2)

      loop

         IF k.kv <> 980 THEN
            se_:=k.Ostq - k.Dosq96 + k.Kosq96;
         ELSE
            se_:=k.Ostn - k.Dos96 + k.Kos96;
         END IF;

         select NVL(sum(to_number(r.znap)),0)
            into sn_
         from rnbu_trace r
         where r.kodp like '11' || substr(k.nbs,1,3) || '%'
           and substr(r.kodp,3,4) not in ('1419', '1429', '3107', '3119', '3219');

         -- формируем разницу остатков
         if se_ <> sn_ and ABS(se_ - sn_) <= 100 then
            znap_ := to_char(se_ - sn_);

            select r.kodp, trim(r.comm)
               into kodp_, comm_
            from rnbu_trace r
            where r.kodp like '11' || substr(k.nbs,1,3) || '%'
              and rownum = 1;

            kodp_ := '12' || k.nbs || substr(kodp_,7,17);

            INSERT INTO rnbu_trace
               (nls, kv, odate, kodp, znap, nbuc, comm)
            VALUES
               (k.nbs, k.kv, dat_, kodp_, znap_, nbuc_, comm_);
         end if;

      end loop;

end if;
---------------------------------------------------
-- блок для згортання рахунк_в переоц_нки 1415, 3115
for k in ( select comm, substr(kodp,20,4) NOMCP, 
                  sum(decode(substr(kodp,1,2), '11', znap, 0)) sum_a, 
                  sum(decode(substr(kodp,1,2), '12', znap, 0)) sum_p 
           from rnbu_trace
           where substr(kodp,3,4) in ('1415','3115')
             and kodp like '1%'
           group by comm, substr(kodp,20,4)
           order by 1, 2
         )

    loop

       if k.sum_a > k.sum_p and k.sum_a <> 0 and k.sum_p <> 0
       then
          znap_ := k.sum_a - k.sum_p;

          begin
             select min(recid) 
                into recid_
             from rnbu_trace
             where comm = k.comm
               and substr(kodp,20,4) = k.nomcp
               and substr(kodp,3,4) in ('1415','3115')
               and kodp like '11%';
          exception when no_data_found then
             null;
          end; 

          update rnbu_trace r set r.znap = znap_
          where r.recid = recid_ 
            and r.comm = k.comm 
            and substr(r.kodp,20,4) = k.nomcp
            and substr(r.kodp,3,4) in ('1415','3115')
            and r.kodp like '11%';

          delete from rnbu_trace r
          where r.recid <> recid_  
            and r.comm = k.comm 
            and substr(r.kodp,20,4) = k.nomcp
            and substr(r.kodp,3,4) in ('1415','3115')
            and r.kodp like '11%'; 

          delete from rnbu_trace r
          where r.comm = k.comm 
            and substr(r.kodp,20,4) = k.nomcp
            and substr(r.kodp,3,4) in ('1415','3115')
            and r.kodp like '12%'; 

       end if;          

       if k.sum_p > k.sum_a and k.sum_a <> 0 and k.sum_p <> 0
       then
          znap_ := k.sum_p - k.sum_a;

          begin
             select min(recid) 
                into recid_
             from rnbu_trace
             where comm = k.comm
               and substr(kodp,20,4) = k.nomcp
               and substr(kodp,3,4) in ('1415','3115')
               and kodp like '12%';
          exception when no_data_found then
             null;
          end; 

          update rnbu_trace r set r.znap = znap_
          where r.recid = recid_
            and r.comm = k.comm 
            and substr(r.kodp,20,4) = k.nomcp
            and substr(r.kodp,3,4) in ('1415','3115')
            and r.kodp like '12%';

          delete from rnbu_trace r 
          where r.recid <> recid_ 
            and r.comm = k.comm 
            and substr(r.kodp,20,4) = k.nomcp
            and substr(r.kodp,3,4) in ('1415','3115')
            and r.kodp like '12%'; 

          delete from rnbu_trace r 
          where r.comm = k.comm 
            and substr(r.kodp,20,4) = k.nomcp
            and substr(r.kodp,3,4) in ('1415','3115')
            and r.kodp like '11%'; 

       end if;          
   
     end loop;
---------------------------------------------------
DELETE FROM tmp_nbu where kodf=kodf_ and datf= dat_;
---------------------------------------------------
INSERT INTO TMP_NBU (kodf, datf, kodp, nbuc, znap)
select kodf_, dat_, kodp, nbuc, SUM(znap)
from RNBU_TRACE
where substr(kodp,1,1) not in ('3', '9')
GROUP BY kodp, nbuc;

INSERT INTO TMP_NBU (kodf, datf, kodp, nbuc, znap)
select kodf_, dat_, kodp, nbuc, znap
from RNBU_TRACE
where substr(kodp,1,1) in ('3', '9');
----------------------------------------
logger.info ('P_F07_NN: End ');

END p_f07_nn;
/
