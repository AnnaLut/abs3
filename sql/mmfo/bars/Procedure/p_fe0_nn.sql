

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FE0_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FE0_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_FE0_NN (Dat_ DATE, sheme_ varchar2 default 'G')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Процедура формирование файла #E0 для КБ (универсальная)
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 09/09/2016 (22/08/2016, 11/08/2016)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
09.09.2016 - изменено наполнение кода 218 
22.08.2016 - из формирования файла исключается операция "AA0" 
11.08.2016 - для удаления проводок по металлам добавлено условие 
             "and lower (t.nazn) not like '%продано валюту%'"
             т.к. удалялись нужные проводки 
18.08.2015 - удалены блоки наполнения проводок для Демарка и Надр
             выполнена некоторая оптимизация по отдельным показателям
03.03.2015 - с 01.01.2015 исключаются показатели для ЮЛ (118,119,218)
             (эти показатели не всегда удалялись полностью)
09.02.2015 - для СБ в код 318 будут вклчаться проводки
             Дт 100*  Кт 2902 OB22=('09','15')
04.02.2015 - не удалялись сторнировочные проводки в показателе 219 т.к.
             не формировался показатель 218.
             Теперь сначала формируем показатель 218 и затем после
             удаления сторнировочных проводок из показателя 219
             удаляет показатель 218
03.02.2015 - с 01.01.2015 исключаются показатели для ЮЛ (118,119,218)
             в показателе 219 исключаются операции покупки валюты
             для погашения кредита (AAL, AAE)
17.01.2015 - для УПБ в код 318 будут вклчаться проводки
             Дт 7419 Кт 362259537
16.01.2015 - для проводок Дт 100*, 2900 Кт 2902 добавлено обработку
             назначения платежа '%2%в пенс.фонд%,'%0.5%в пенс_йний фонд%'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='E0';
fmt_     varchar2(20):='999990D0000';

dl_      number:=100; -- для металлов
DatP_     date; -- дата начала выходных дней, кот. предшествуют заданой дате
Dat_pmes date; -- последний рабочий день предыдущего месяца
buf_     number;

typ_     number;
kv_      number;
kv1_     number;
ref_     number;
ref1_    number;
tt_      varchar2(3);
nls_     varchar2(15);
nlsk_    varchar2(15);
nls1_    varchar2(15);
nlsb_    varchar2(15);
mfo_     Varchar2(12);
mfou_    Number;
mfoa_    Varchar2(12);
mfob_    Varchar2(12);
comm_    Varchar2(200);
dat1_    Date;
data_    date;
kol_     number;
dig_     number;
bsu_     number;
sum_     number;
sum1_    number;
sum0_    number;
sun1_    number;
sun0_    number;
kodp_    varchar2(10);
kodp1_   varchar2(10);
znap_    varchar2(30);
VVV      varchar2(3) ;
ddd39_   varchar2(3) ;
ddd_     varchar2(3) ;
d39_     varchar2(200) ;
kurs_    varchar2(200) ;
tag_     varchar2(5) ;
a_       varchar2(20);
b_       varchar2(20);
userid_  number;
nbuc1_   varchar2(12);
nbuc_    varchar2(12);
acc_     number;
accd_    number;
acck_    number;
pr_      number;
rate_o_  number;
div_     number;
nazn_    Varchar2(200);
dat_izm1 date := to_date('31/12/2014','dd/mm/yyyy');

CURSOR OPL_DOK IS
   SELECT a.tt, a.accd, a.nlsd, a.kv, a.acck, a.nlsk, a.ref, a.fdat,
          a.s*100, a.isp, a.nazn
   FROM tmp_file03 a
   WHERE a.kv = 980
ORDER BY 10, 8, 7;

CURSOR Basel IS
   SELECT nbuc, kodp, SUM(TO_NUMBER (znap))
   FROM RNBU_TRACE a
   GROUP BY nbuc, kodp;
-----------------------------------------------------------------------
BEGIN
-------------------------------------------------------------------
   userid_ := user_id;
   EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
   EXECUTE IMMEDIATE 'TRUNCATE TABLE TMP_FILE03';

   mfo_ := F_OURMFO();

   -- МФО "родителя"
   BEGIN
      SELECT mfou
         INTO mfou_
      FROM BANKS
      WHERE mfo = mfo_;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      mfou_ := mfo_;
   END;

   p_proc_set(kodf_,sheme_,nbuc1_,typ_);
   Datp_ := calc_pdat(dat_);
   Dat1_:= TRUNC(Dat_,'MM');

   -- с 01.01.2015 показатели 118,119,218 не должны формироваться
   if Dat_ <= dat_izm1 then

      -- код 118
      insert into tmp_file03
                  (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
     select * from
     (
      select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 118
      from provodki_otc
      where fdat between Dat1_ and Dat_
        and kv=980
        and nbsd like '3640%' and nbsk like '2900%'
     ) ;

      insert into tmp_file03
                  (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
     select * from
     (
      select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 118
      from provodki_otc
      where fdat between Dat1_ and Dat_
        and kv=980
        and nbsd like '3801%' and nbsk  like '1819%'
        and LOWER(nazn) like '%куп_вля%'
        and LOWER(nazn) not like '%swap%'
     ) ;

      insert into tmp_file03
                  (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
      select * from
      (
      select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 118
      from provodki_otc t
      where  fdat between Dat1_ and dat_
         and kv=980
         and nbsd like '3801%' and nbsk  like '2900%'
         and LOWER(nazn) like '%куп_вля за рахунок%'
      ) ;

      if mfou_ = 300465 then
         -- код 119
          insert into tmp_file03
                      (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
         select * from
         (
          select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 119
          from provodki_otc
          where fdat between Dat1_ and dat_
            and kv=980
            and nbsd like '2900%' and nbsk like '3739%'
            and ( LOWER(nazn) like '%для куп_вл_%' or
                  LOWER(nazn) like '%на куп_вл_%' or
                  LOWER(nazn) like '%куп_вл_ валюти%' or
                  LOWER(nazn) like '%куп_вл_ _ноземно_ валюти%'
                )
            and ob22d='01'
            and tt='310'
         ) ;
      end if;

   end if;
   -- окончание блока c 01.01.2015 коды 118,119,218 не будут формироваться

   -- код 218
   -- сначала выполняем наполнение без исключения (закомментировано)
   -- а затем удаляем из TMP_FILE03 ISP=218 и закомментированное условие 
   insert into tmp_file03
                (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select /* NOPARALLEL */ 
       t.ACCD, t.TT, t.REF, t.KV, t.NLSD, t.S, t.SQ, t.FDAT, t.NAZN, t.ACCK, t.NLSK, 218
    from provodki_otc t
    where t.fdat between Dat1_ and Dat_
      and t.kv=980
      and t.nbsd like '3801%' and t.nbsk like '100%'
      --and not exists ( select 1
      --                 from provodki_otc o
      --                 where o.ref = t.ref
      --                   and o.fdat = t.fdat 
      --                   and o.kv <> 980
      --                   and o.nbsd like '2909%'
      --                   and o.nbsk like '3800%' 
      --               )
   ) ;
   commit;
   
   -- код 219
    insert into tmp_file03
                (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select /* NOPARALLEL */ 
       ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 219
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and nbsd like '100%'  and nbsk  like '3801%'
      and tt not in ('AAL','AAE')
   ) ;
   commit;

   -- код 318
   if mfou_ not in (300465) 
   then
       insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
      select * from
      (
       select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
       from provodki_otc
       where fdat between Dat1_ and Dat_
         and kv=980
         and (nbsd like '3522%' or nbsd like '7419%') and nbsk  like '3622%'
         and ( lower(nazn) like '%пф%'                            or
               lower(nazn) like '%пфу%'                           or
               lower(nazn) like '%в пенс.фонд%'                   or
               lower(nazn) like '%в_драхування збору на обов%'    or
               lower(nazn) like '%нарахування суми збору до пенс_йного фонду%'    or
               lower(nazn) like '%зб_р на обовяз.пенс.страх%'     or
               lower(nazn) like '%сбор%от покупки валют_%'        or
               lower(nazn) like '%сбор%от конвертации валют_%'    or
               lower(nazn) like '%зб_р%в_д куп_вл_%'              or
               lower(nazn) like '%обов_язкове%пенс. страхування%' or
               lower(nazn) like '%обов_язкове%пенс_йне страхування%'
             )
      ) ;
   end if;

   -- код 318
   if mfou_ not in (300465) 
   then
       insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
      select * from
      (
       select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
       from provodki_otc
       where fdat between Dat1_ and Dat_
         and kv=980
         and (nbsd like '100%' or nbsd like '2900%')  and nbsk  like '2902%'
         and ( lower(nazn) like '%пф%'                            or
               lower(nazn) like '%пфу%'                           or
               lower(nazn) like '%0.5%в пенс.фонд%'               or
               lower(nazn) like '%0.5%в пенс_йний фонд%'          or
               lower(nazn) like '%2%в пенс.фонд%'                 or
               lower(nazn) like '%в_драхування збору на обов%'    or
               lower(nazn) like '%зб_р на обовяз.пенс.страх%'     or
               lower(nazn) like '%сбор%от покупки валют_%'        or
               lower(nazn) like '%сбор%от конвертации валют_%'    or
               lower(nazn) like '%зб_р%в_д куп_вл_%'              or
               lower(nazn) like '%обов_язкове%пенс. страхування%' or
               lower(nazn) like '%обов_язкове%пенс_йне страхування%'
             )
      ) ;
   end if;

   if mfou_ = 300465 
   then
      if dat_ <= to_date('31122014','ddmmyyyy') 
      then
          insert into tmp_file03
                      (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
         select * from
         (
          select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
          from provodki_otc
          where fdat between Dat1_ and Dat_
            and kv=980
            and nbsd like '7419%' and nbsk  like '3622%'
            and ob22k in ('12','35')
          UNION
          select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
          from provodki_otc
          where fdat between Dat_ and Dat_ + 25
            and kv=980
            and vob = 96
            and nbsd like '7419%' and nbsk  like '3622%'
            and ob22k in ('12','35')
         ) ;

          insert into tmp_file03
                      (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
         select * from
         ( 
          select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
          from provodki_otc
          where fdat between Dat1_ and Dat_
            and kv=980
            and ( nbsd like '100%' or nbsd like '26%' or nbsd like '2900%' or
                  nbsd like '3541%' or nbsd like '3739%' or nbsd like '7399%'
                )
            and nbsk  like '2902%'
            and ob22k in ('09','15')
         ) ;
      end if;

      if Dat_ > to_date('31122014','ddmmyyyy') 
      then
          insert into tmp_file03
                      (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
         select * from
         (
          select /* NOPARALLEL */ 
             ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
          from provodki_otc
          where fdat between Dat1_ and Dat_
            and kv=980
            and nbsd like '100%'
            and nbsk  like '2902%'
            and ob22k in ('09','15')
         ) ;
      end if;
   end if;

   -- код 319
   if mfou_ not in (300465) 
   then
       insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
      select * from
      (
       select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 319
       from provodki_otc
       where fdat between Dat1_ and Dat_
         and kv=980
         and (nbsd like '2902%' or nbsd like '3622%') and nbsk  like '3739%'
         and ( lower(nazn) like '%зб_р на обов.держ.пенс.страх%'              or
               lower(nazn) like '%зб_р на обов_язк. держ. пенс. страх%'       or
               lower(nazn) like '%з куп_вл_ безгот_вково_ _ноземно_ валюти%'  or
               lower(nazn) like '%05%ком_с_я при куп_вл_ валют_%'             or
               lower(nazn) like '%з куп_вл_ гот_вково_ _ноземно_ валюти%'     or
               lower(nazn) like '%пенс_йний зб_р%'                            or
               lower(nazn) like '%зб_р%в пф%'                                 or
               lower(nazn) like '%зб_р%в пфу%'
             )
      ) ;
   end if;

   if mfou_ = 300465 
   then
       insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
      select * from
      (
       select /* NOPARALLEL */ 
          ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 319
       from provodki_otc
       where fdat between Dat1_ and Dat_
         and kv = 980
         and ( (nbsd like '2902%' and nbsk  like '3739%' and ob22d in ('09','15')) or
               (nbsd like '3622%' and nbsk  like '3739%' and ob22d in ('12','35'))
             )
      ) ;
   end if;

   -- удаление проводок Дт 2900 Кт 2900 и определенные назначения платежа
   delete from tmp_file03
   where nlsd like '2900%' and nlsk like '2900%' 
     and (lower(nazn) like '%повернення зайво перерахованих%' or 
          lower(nazn) like '%повернення залишку кошт_в%'      or
          lower(nazn) like '%повернення кошт_в%'              or 
          lower(nazn) like '%возврат излишне перечисленных%'  or
          lower(nazn) like '%возврат средств%'                or
          lower(nazn) like '%возврат неиспользованных ср-в%'  or
          lower(nazn) like '%возврат перечисленных средств%'  or 
          lower(nazn) like '%возврат ср-в , перечисленных%'   or 
          lower(nazn) like '%возврат ср-в перечисленных на покупку%'   
        );
    --and lower(nazn) not like '%частичный возврат ср-в перечисленных на покупку%';   

   -- удаление некоторых проводок из кода 218
   DELETE FROM tmp_file03 t
   WHERE t.isp = 218 
     and (t.nlsd like '3801%' and t.nlsk like '100%') 
     and exists ( select 1
                  from provodki_otc o
                  where o.ref = t.ref
                    and o.fdat = t.fdat 
                    and o.kv <> 980
                    and o.nbsd like '2909%'
                    and o.nbsk like '3800%' 
                 );

   -- удаление проводок по металлах
   DELETE FROM tmp_file03 t
   WHERE ( (t.nlsd like '100%' and t.nlsk like '3801%') or
           (t.nlsd like '3801%' and t.nlsk like '100%')
         )
     and exists ( select 1
                  from provodki_otc o
                  where o.fdat between Dat1_ and Dat_
                    and o.ref = t.ref
                    and o.kv in (959,961,962,964)
               );

   DELETE FROM tmp_file03 t
   WHERE ( (nlsd like '100%' and nlsk like '3801%') or
           (nlsd like '3801%' and nlsk like '100%')
         )
     and ( lower (t.nazn) like '%959%' or lower (t.nazn) like '%xau%' or
           lower (t.nazn) like '%961%' or lower (t.nazn) like '%xag%' or
           lower (t.nazn) like '%962%' or lower (t.nazn) like '%xpt%' or
           lower (t.nazn) like '%964%' or lower (t.nazn) like '%xpd%' or
           lower (t.nazn) like '%метал%' or
           lower (t.nazn) like '%злиток%' or
           lower (t.nazn) like '%зливок%' or
           lower (t.nazn) like '%злитк%'
         )
     and lower (t.nazn) not like '%в_куп%'
     and lower (t.nazn) not like '%продано валюту%';

   if mfou_ = 300465 
   then
      -- удаление проводок по металлах
      DELETE FROM tmp_file03 t
      WHERE ( (t.nlsd like '100%' and t.nlsk like '3801%') or
              (t.nlsd like '3801%' and t.nlsk like '100%')
            )
         and exists ( select 1
                      from provodki_otc o
                      where o.fdat between Dat1_ and Dat_
                        and o.ref = t.ref
                        and (o.nbsd like '3801%' or o.nbsk like '3801%')
                        and (o.ob22d ='09' or o.ob22k = '09')
                    );

      -- удаление проводок Дт 100 Кт 3801 операции I02, I03
      -- 22/08/2016 добавлена операция "AA0"
      -- 09/09/2016 убираем операцию "AA0" (по указанию Демкович М.С.) 
      DELETE FROM tmp_file03
      WHERE ( (nlsd like '3801%' and nlsk like '100%') or
              (nlsd like '100%' and nlsk like '3801%')
            )
        and tt in ('I02','I03');  --,'AA0');
   end if;

   -- удаление сторнированных проводок
   DELETE FROM tmp_file03
   WHERE ( (nlsd like '100%' and nlsk like '3801%') or
           (nlsd like '3801%' and nlsk like '100%') or
           (nlsd like '100%' and nlsk like '2902%') or
           (nlsd like '2902%' and nlsk like '100%')
         )
     and ref in ( select o.ref
                  from tmp_file03 o
                  where o.tt = 'BAK');

   -- удаление BAK операций
   DELETE FROM tmp_file03
   WHERE ( (nlsd like '100%' and nlsk like '3801%') or
           (nlsd like '3801%' and nlsk like '100%') or
           (nlsd like '100%' and nlsk like '2902%') or
           (nlsd like '2902%' and nlsk like '100%')
         )
     and tt = 'BAK';

   -- с 01.01.2015 показатели 118,119,218 не должны формироваться
   -- наполняли код 218 для удаления сторнировочных проводок (операция "BAK")
   if Dat_ > dat_izm1 
   then
      -- удаление кода 118, 119, 218
      DELETE FROM tmp_file03
      WHERE isp in (118, 119, 218);
   end if;

   -- зворотній обмін не використаної гривні
   if mfou_ = 300120 
   then
      DELETE FROM tmp_file03
      WHERE nlsd like '100%' and nlsk like '3801%'
        and tt in ('И2', 'И_2') ;
   end if;

   -- межбанк
   OPEN OPL_DOK;
   LOOP
      FETCH OPL_DOK INTO tt_, accd_, nls_, kv_, acck_, nlsk_, ref_, data_, sum1_, ddd_, nazn_ ;
      EXIT WHEN OPL_DOK%NOTFOUND;

      IF SUM1_ != 0 
      then

         IF ddd_ in ('118','119','219','318') 
         THEN
            nls1_:=nls_;
            acc_:=accd_;
         ELSE
            nls1_:=nlsk_;
            acc_:=acck_;
         END IF;

         IF nls_ like '7419%' and nlsk_ like '3622%'
         THEN
            BEGIN
               select accd
                  into acc_
               from provodki_otc
               where ref = ref_
                 and nlsd like '100%'
                 and rownum = 1;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               BEGIN
                  select acck
                     into acc_
                  from provodki_otc
                  where ref = ref_
                    and nlsk like '100%'
                    and rownum = 1;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  null;
               END;
            END;
         END IF;

         -- определяем код области
         if typ_ > 0 then
            nbuc_ := nvl(f_codobl_tobo(acc_,typ_),nbuc1_);
         else
            nbuc_ := nbuc1_;
         end if;

         if ddd_ = '319' then
            nbuc_ := nbuc1_;
         end if;

         kodp_:= '1' || ddd_ || '000' ;
         znap_:= TO_CHAR(sum1_);

         comm_ := substr('TT = '||tt_ ||' Дт = ' || nls_ || ' Кт = ' || nlsk_ || ' Ref = ' || to_char(ref_) || ' Nazn = ' || nazn_, 1, 200);

         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, comm, ref) VALUES
                                (nls1_, kv_, data_, kodp_, znap_, nbuc_, comm_, ref_);
      END IF;

   END LOOP;
   CLOSE OPL_DOK;
---------------------------------------------------
   DELETE FROM tmp_nbu where kodf=kodf_ and datf=dat_;
---------------------------------------------------
   OPEN basel;
      LOOP
         FETCH basel
         INTO nbuc_, kodp_, sum0_;
         EXIT WHEN basel%NOTFOUND;

         IF sum0_<>0 then

            -- сумма
            INSERT INTO tmp_nbu
                 (kodf, datf, kodp, znap, nbuc)
            VALUES
                 (kodf_, Dat_, kodp_, to_char(sum0_), nbuc_) ;

         end if;

      END LOOP;
   CLOSE basel;
----------------------------------------
END p_fE0_NN;
/
show err;

PROMPT *** Create  grants  P_FE0_NN ***
grant EXECUTE                                                                on P_FE0_NN        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FE0_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
