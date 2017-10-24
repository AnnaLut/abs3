

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F53SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F53SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F53SB (Dat_ DATE)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирование файла @53 (аналог #E0)
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 19.08.2014
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
19.08.2014 - ежедневній файл внутренней отчетности (аналог #E0)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='53';
fmt_     varchar2(20):='999990D0000';
dl_      number:=100; -- для металлов
DatP_	 date; -- дата начала выходных дней, кот. предшествуют заданой дате
Dat_pmes date; -- последний рабочий день предыдущего месяца
buf_	 number;

kv_      number;
kv1_     number;
ref_     number;
ref1_    number;
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

CURSOR OPL_DOK IS
   SELECT a.accd, a.nlsd, a.kv, a.acck, a.nlsk, a.ref, a.fdat,
          a.s*100, a.isp, a.nazn
   FROM tmp_file03 a
   WHERE a.kv = 980
ORDER BY 9, 7, 6;

CURSOR Basel IS
   SELECT kodp, SUM(TO_NUMBER (znap))
   FROM RNBU_TRACE
   WHERE userid=userid_
   GROUP BY kodp;
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

Datp_ := calc_pdat(dat_);
Dat1_:= TRUNC(Dat_,'MM');

-- код 118
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 118
    from provodki_otc
    where fdat = Dat_
      and kv=980
      and nbsd like '3640%' and nbsk like '2900%'
   ) ;

    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 118
    from provodki_otc
    where fdat = Dat_
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
    from provodki_otc
    where fdat = Dat_
      and kv=980
      and nbsd like '3801%' and nbsk  like '2900%'
      and LOWER(nazn) like '%куп_вля за рахунок%'
   ) ;

   -- код 119
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 119
    from provodki_otc
    where fdat = Dat_
      and kv=980
      and nbsd like '2900%' and nbsk like '3739%'
      and ( LOWER(nazn) like '%для куп_вл_%' or
            LOWER(nazn) like '%куп_вл_ валюти%'
          )
      and ob22d='01'
      and tt='310'
   ) ;

   -- код 218
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 218
    from provodki_otc
    where fdat = Dat_
      and kv=980
      and nbsd like '3801%' and nbsk like '100%'
   ) ;

   -- код 219
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 219
    from provodki_otc
    where fdat = Dat_
      and kv=980
      and nbsd like '100%'  and nbsk  like '3801%'
   ) ;


    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
    from provodki_otc
    where fdat = Dat_
      and kv=980
      and nbsd like '7419%' and nbsk  like '3622%'
      and ob22k in ('12','35')
   ) ;

    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
    from provodki_otc
    where fdat = Dat_
      and kv=980
      and (nbsd like '100%' or nbsd like '26%' or nbsd like '2900%' or
           nbsd like '3541%' or nbsd like '3739%' or nbsd like '7399%')
      and nbsk  like '2902%'
      and ob22k in ('09','15')
   ) ;


-- код 319

    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 319
    from provodki_otc
    where fdat = Dat_
      and kv = 980
      and ( (nbsd like '2902%' and nbsk  like '3739%' and ob22d in ('09','15')) or
            (nbsd like '3622%' and nbsk  like '3739%' and ob22d in ('12','35'))
          )
   ) ;

   -- удаление проводок Дт 2900 Кт 2900 и определенные назначения платежа
   delete from tmp_file03
   where nlsd like '2900%' and nlsk like '2900%'
   and ( lower(nazn) like '%повернення зайво перерахованих%' or
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

-- удаление проводок по металлах
   DELETE FROM tmp_file03 t
   WHERE ( (t.nlsd like '100%' and t.nlsk like '3801%') or
           (t.nlsd like '3801%' and t.nlsk like '100%')
         )
     and exists ( select 1
                  from provodki_otc o
                  where o.ref = t.ref
                    and o.kv in (959,961,962,964)
               );

   DELETE FROM tmp_file03 t
   WHERE ( (nlsd like '100%' and nlsk like '3801%') or
           (nlsd like '3801%' and nlsk like '100%')
         )
     and ( lower (t.nazn) like '%959%' or lower (t.nazn) like '%xau%' or
           lower (t.nazn) like '%961%' or lower (t.nazn) like '%xag%' or
           lower (t.nazn) like '%962%' or lower (t.nazn) like '%xpt%' or
           lower (t.nazn) like '%964%' or lower (t.nazn) like '%xpd%'
         ) ;

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


-- межбанк
OPEN OPL_DOK;
LOOP
   FETCH OPL_DOK INTO accd_, nls_, kv_, acck_, nlsk_, ref_, data_, sum1_, ddd_, nazn_ ;
   EXIT WHEN OPL_DOK%NOTFOUND;

   IF SUM1_ != 0 then

      IF ddd_ in ('118','119','219','318') THEN
         nls1_:=nls_;
         acc_:=accd_;
      ELSE
         nls1_:=nlsk_;
         acc_:=acck_;
      END IF;

      kodp_:= '1' || ddd_ || '000' ;
      znap_:= TO_CHAR(sum1_);

      comm_ := substr('Дт = ' || nls_ || ' Кт = ' || nlsk_ || ' Ref = ' || to_char(ref_) || ' Nazn = ' || nazn_, 1, 200);

      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, comm, ref) VALUES
                             (nls1_, kv_, data_, kodp_, znap_, comm_, ref_);
   END IF;

END LOOP;
CLOSE OPL_DOK;
---------------------------------------------------
DELETE FROM tmp_irep where kodf=kodf_ and datf=dat_;
---------------------------------------------------
OPEN basel;
   LOOP
      FETCH basel
      INTO kodp_, sum0_;
      EXIT WHEN basel%NOTFOUND;

      IF sum0_<>0 then

         -- сумма
         INSERT INTO tmp_irep
              (kodf, datf, kodp, znap)
         VALUES
              (kodf_, Dat_, kodp_, to_char(sum0_)) ;

      end if;

   END LOOP;
CLOSE basel;
----------------------------------------
END p_f53sb;
/
show err;

PROMPT *** Create  grants  P_F53SB ***
grant EXECUTE                                                                on P_F53SB         to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F53SB.sql =========*** End *** =
PROMPT ===================================================================================== 
