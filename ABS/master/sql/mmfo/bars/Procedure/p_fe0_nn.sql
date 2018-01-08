

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FE0_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FE0_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_FE0_NN (Dat_ DATE, sheme_ varchar2 default 'G')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    ��������� ������������ ����� #E0 ��� �� (�������������)
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 09/09/2016 (22/08/2016, 11/08/2016)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ���������: Dat_ - �������� ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
09.09.2016 - �������� ���������� ���� 218 
22.08.2016 - �� ������������ ����� ����������� �������� "AA0" 
11.08.2016 - ��� �������� �������� �� �������� ��������� ������� 
             "and lower (t.nazn) not like '%������� ������%'"
             �.�. ��������� ������ �������� 
18.08.2015 - ������� ����� ���������� �������� ��� ������� � ����
             ��������� ��������� ����������� �� ��������� �����������
03.03.2015 - � 01.01.2015 ����������� ���������� ��� �� (118,119,218)
             (��� ���������� �� ������ ��������� ���������)
09.02.2015 - ��� �� � ��� 318 ����� ��������� ��������
             �� 100*  �� 2902 OB22=('09','15')
04.02.2015 - �� ��������� �������������� �������� � ���������� 219 �.�.
             �� ������������ ���������� 218.
             ������ ������� ��������� ���������� 218 � ����� �����
             �������� �������������� �������� �� ���������� 219
             ������� ���������� 218
03.02.2015 - � 01.01.2015 ����������� ���������� ��� �� (118,119,218)
             � ���������� 219 ����������� �������� ������� ������
             ��� ��������� ������� (AAL, AAE)
17.01.2015 - ��� ��� � ��� 318 ����� ��������� ��������
             �� 7419 �� 362259537
16.01.2015 - ��� �������� �� 100*, 2900 �� 2902 ��������� ���������
             ���������� ������� '%2%� ����.����%,'%0.5%� ����_���� ����%'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='E0';
fmt_     varchar2(20):='999990D0000';

dl_      number:=100; -- ��� ��������
DatP_     date; -- ���� ������ �������� ����, ���. ������������ ������� ����
Dat_pmes date; -- ��������� ������� ���� ����������� ������
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

   -- ��� "��������"
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

   -- � 01.01.2015 ���������� 118,119,218 �� ������ �������������
   if Dat_ <= dat_izm1 then

      -- ��� 118
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
        and LOWER(nazn) like '%���_���%'
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
         and LOWER(nazn) like '%���_��� �� �������%'
      ) ;

      if mfou_ = 300465 then
         -- ��� 119
          insert into tmp_file03
                      (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
         select * from
         (
          select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 119
          from provodki_otc
          where fdat between Dat1_ and dat_
            and kv=980
            and nbsd like '2900%' and nbsk like '3739%'
            and ( LOWER(nazn) like '%��� ���_��_%' or
                  LOWER(nazn) like '%�� ���_��_%' or
                  LOWER(nazn) like '%���_��_ ������%' or
                  LOWER(nazn) like '%���_��_ _�������_ ������%'
                )
            and ob22d='01'
            and tt='310'
         ) ;
      end if;

   end if;
   -- ��������� ����� c 01.01.2015 ���� 118,119,218 �� ����� �������������

   -- ��� 218
   -- ������� ��������� ���������� ��� ���������� (����������������)
   -- � ����� ������� �� TMP_FILE03 ISP=218 � ������������������ ������� 
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
   
   -- ��� 219
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

   -- ��� 318
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
         and ( lower(nazn) like '%��%'                            or
               lower(nazn) like '%���%'                           or
               lower(nazn) like '%� ����.����%'                   or
               lower(nazn) like '%�_���������� ����� �� ����%'    or
               lower(nazn) like '%����������� ���� ����� �� ����_����� �����%'    or
               lower(nazn) like '%��_� �� ������.����.�����%'     or
               lower(nazn) like '%����%�� ������� �����_%'        or
               lower(nazn) like '%����%�� ����������� �����_%'    or
               lower(nazn) like '%��_�%�_� ���_��_%'              or
               lower(nazn) like '%����_������%����. �����������%' or
               lower(nazn) like '%����_������%����_��� �����������%'
             )
      ) ;
   end if;

   -- ��� 318
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
         and ( lower(nazn) like '%��%'                            or
               lower(nazn) like '%���%'                           or
               lower(nazn) like '%0.5%� ����.����%'               or
               lower(nazn) like '%0.5%� ����_���� ����%'          or
               lower(nazn) like '%2%� ����.����%'                 or
               lower(nazn) like '%�_���������� ����� �� ����%'    or
               lower(nazn) like '%��_� �� ������.����.�����%'     or
               lower(nazn) like '%����%�� ������� �����_%'        or
               lower(nazn) like '%����%�� ����������� �����_%'    or
               lower(nazn) like '%��_�%�_� ���_��_%'              or
               lower(nazn) like '%����_������%����. �����������%' or
               lower(nazn) like '%����_������%����_��� �����������%'
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

   -- ��� 319
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
         and ( lower(nazn) like '%��_� �� ����.����.����.�����%'              or
               lower(nazn) like '%��_� �� ����_���. ����. ����. �����%'       or
               lower(nazn) like '%� ���_��_ ������_�����_ _�������_ ������%'  or
               lower(nazn) like '%05%���_�_� ��� ���_��_ �����_%'             or
               lower(nazn) like '%� ���_��_ ���_�����_ _�������_ ������%'     or
               lower(nazn) like '%����_���� ��_�%'                            or
               lower(nazn) like '%��_�%� ��%'                                 or
               lower(nazn) like '%��_�%� ���%'
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

   -- �������� �������� �� 2900 �� 2900 � ������������ ���������� �������
   delete from tmp_file03
   where nlsd like '2900%' and nlsk like '2900%' 
     and (lower(nazn) like '%���������� ����� �������������%' or 
          lower(nazn) like '%���������� ������� ����_�%'      or
          lower(nazn) like '%���������� ����_�%'              or 
          lower(nazn) like '%������� ������� �������������%'  or
          lower(nazn) like '%������� �������%'                or
          lower(nazn) like '%������� ���������������� ��-�%'  or
          lower(nazn) like '%������� ������������� �������%'  or 
          lower(nazn) like '%������� ��-� , �������������%'   or 
          lower(nazn) like '%������� ��-� ������������� �� �������%'   
        );
    --and lower(nazn) not like '%��������� ������� ��-� ������������� �� �������%';   

   -- �������� ��������� �������� �� ���� 218
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

   -- �������� �������� �� ��������
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
           lower (t.nazn) like '%�����%' or
           lower (t.nazn) like '%������%' or
           lower (t.nazn) like '%������%' or
           lower (t.nazn) like '%�����%'
         )
     and lower (t.nazn) not like '%�_���%'
     and lower (t.nazn) not like '%������� ������%';

   if mfou_ = 300465 
   then
      -- �������� �������� �� ��������
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

      -- �������� �������� �� 100 �� 3801 �������� I02, I03
      -- 22/08/2016 ��������� �������� "AA0"
      -- 09/09/2016 ������� �������� "AA0" (�� �������� �������� �.�.) 
      DELETE FROM tmp_file03
      WHERE ( (nlsd like '3801%' and nlsk like '100%') or
              (nlsd like '100%' and nlsk like '3801%')
            )
        and tt in ('I02','I03');  --,'AA0');
   end if;

   -- �������� �������������� ��������
   DELETE FROM tmp_file03
   WHERE ( (nlsd like '100%' and nlsk like '3801%') or
           (nlsd like '3801%' and nlsk like '100%') or
           (nlsd like '100%' and nlsk like '2902%') or
           (nlsd like '2902%' and nlsk like '100%')
         )
     and ref in ( select o.ref
                  from tmp_file03 o
                  where o.tt = 'BAK');

   -- �������� BAK ��������
   DELETE FROM tmp_file03
   WHERE ( (nlsd like '100%' and nlsk like '3801%') or
           (nlsd like '3801%' and nlsk like '100%') or
           (nlsd like '100%' and nlsk like '2902%') or
           (nlsd like '2902%' and nlsk like '100%')
         )
     and tt = 'BAK';

   -- � 01.01.2015 ���������� 118,119,218 �� ������ �������������
   -- ��������� ��� 218 ��� �������� �������������� �������� (�������� "BAK")
   if Dat_ > dat_izm1 
   then
      -- �������� ���� 118, 119, 218
      DELETE FROM tmp_file03
      WHERE isp in (118, 119, 218);
   end if;

   -- �������� ���� �� ����������� �����
   if mfou_ = 300120 
   then
      DELETE FROM tmp_file03
      WHERE nlsd like '100%' and nlsk like '3801%'
        and tt in ('�2', '�_2') ;
   end if;

   -- �������
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

         -- ���������� ��� �������
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

         comm_ := substr('TT = '||tt_ ||' �� = ' || nls_ || ' �� = ' || nlsk_ || ' Ref = ' || to_char(ref_) || ' Nazn = ' || nazn_, 1, 200);

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

            -- �����
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
