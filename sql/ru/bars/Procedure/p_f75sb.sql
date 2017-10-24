

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F75SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F75SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F75SB (Dat_ DATE, sheme_ VARCHAR2 DEFAULT 'C' ) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    ��������� ������������ ����� @75 ��� ��
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 2009.All Rights Reserved.
% VERSION     :    25/01/2016 (07/10/2015)  ������ ��� ���������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
15.09.2012 - ��������� � ������� ����� ����������
07.11.2011 - ����������� ������ ����� (������������ �� ������� �� OB22
             �� �������, � ���� ��� ������� �� ���������)
06.10.2011 - ������ �� ������� ������ ��������
13.09.2001 - ��� �������� ���� �� 7 ��. OB22='06' � �� 3590 OB22='03'
             ����� ������������� ��� 12 (��������� �����)
08.09.2001 - �������� ��������� �������� ���� 1890 - 3800 � 3903 = 2400 �
             ����� F_POP_OTCN (� ����� ����������)
15.06.2011 - ��� ������������ ����� �� 31.05.2011 ����� �����������
             ������������ ����������� �� �������� �� 5 �������
10.06.2011 - ��� ������������� �������� �������� ���� �������������
             � �� ���� ������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2) := '75';
ref_     Number;
acc_     Number;
accd_    Number;
acck_    Number;
Dos_     DECIMAL(24);
Dosq_    DECIMAL(24);
Kos_     DECIMAL(24);
Kosq_    DECIMAL(24);
Ostn_    DECIMAL(24);
Ostq_    DECIMAL(24);
Dos96p_  DECIMAL(24);
Dosq96p_ DECIMAL(24);
Kos96p_  DECIMAL(24);
Kosq96p_ DECIMAL(24);
Dos96_   DECIMAL(24);
Dosq96_  DECIMAL(24);
Kos96_   DECIMAL(24);
Kosq96_  DECIMAL(24);
Dos99_   DECIMAL(24);
Dosq99_  DECIMAL(24);
Kos99_   DECIMAL(24);
Kosq99_  DECIMAL(24);
Doszg_   DECIMAL(24);
Koszg_   DECIMAL(24);
Dos96zg_ DECIMAL(24);
Kos96zg_ DECIMAL(24);
Dos99zg_ DECIMAL(24);
Kos99zg_ DECIMAL(24);
kodp_    Varchar2(13);
znap_    Varchar2(30);
Kv_      SMALLINT;
Nbs_     Varchar2(4);
Nbsk_    Varchar2(4);
nls_     Varchar2(15);
nlsd_    Varchar2(15);
nlsk_    Varchar2(15);
rnk_     Number;
mfo_     Varchar2(12);
ob22_    Varchar2(2);
ob22_d   Varchar2(2);
ob22_k   varchar2(2);
kk_      varchar2(2);
data_    Date;
dk_      Varchar2(2);
nbu_     SMALLINT;
pr_d     Varchar2(1);
pr_k     Varchar2(1);
prem_    Char(3);
userid_  Number;
sql_acc_ varchar2(2000):='';
sql_doda_ varchar2(200):='';
ret_     number;
comm_    Varchar2(200);
nazn_    varchar2(160);
datb_    date;
typ_     Number;
nbuc1_   VARCHAR2(12);
nbuc_    VARCHAR2(12);
d_sum_   number;
k_sum_   number;

CURSOR Saldo IS
   SELECT s.rnk, s.acc, s.nls, s.kv, s.fdat, s.nbs, s.ost, s.ostq,
          s.dos96, s.dosq96, s.kos96, s.kosq96, NVL(sp.ob22,'00')
    FROM  otcn_saldo s, specparam_int sp
    WHERE s.acc=sp.acc(+);


CURSOR OBOROTY IS
   SELECT t.fdat, t.ref, t.accd, t.nlsd, t.kv, substr(t.nlsd,1,4) nbs, t.acck,
          t.nlsk, substr(t.nlsk,1,4) nbsk,
          t.s*100,
          DECODE(t.s*100, 0, t.sq*100, gl.p_icurval (t.kv, t.s*100, o.vdat)),
          t.nazn,
          NVL(sb.f_75,'0') pr_d, NVL(sb1.f_75,'0') pr_k,
          NVL(sp.ob22,'00') ob22_d, NVL(sp1.ob22,'00') ob22_k
   FROM tmp_file03 t, sb_r020 sb, sb_r020 sb1, specparam_int sp, specparam_int sp1, oper o
   WHERE substr(t.nlsd,1,4)=sb.r020
     and sb.f_75='1'
     and t.accd=sp.acc(+)
     and substr(t.nlsk,1,4)=sb1.r020(+)
     and t.acck=sp1.acc(+)
     and not exists (select 1 from ref_kor where ref=t.ref and vob=96)
     and t.ref = o.ref
   UNION
   SELECT t.fdat, t.ref, t.accd, t.nlsd, t.kv, substr(t.nlsd,1,4) nbs, t.acck,
          t.nlsk, substr(t.nlsk,1,4) nbsk,
          t.s*100, DECODE(t.s*100, 0, t.sq*100, gl.p_icurval (t.kv, t.s*100, r.vdat/*t.fdat*/)), nazn,
          NVL(sb.f_75,'0') pr_d, NVL(sb1.f_75,'0') pr_k,
          NVL(sp.ob22,'00') ob22_d, NVL(sp1.ob22,'00') ob22_k
   FROM tmp_file03 t, sb_r020 sb, sb_r020 sb1, specparam_int sp, specparam_int sp1, ref_kor r
   WHERE substr(t.nlsd,1,4)=sb.r020
     and sb.f_75='1'
     and t.accd=sp.acc(+)
     and substr(t.nlsk,1,4)=sb1.r020(+)
     and t.acck=sp1.acc(+)
     and t.ref=r.ref
     and r.vob=96
     and r.vdat >= DECODE(Dat_, to_date('31052011','ddmmyyyy'), to_date('31122010','ddmmyyyy'), Dat_)
   UNION
   SELECT t.fdat, t.ref, t.accd, t.nlsd, t.kv, substr(t.nlsd,1,4) nbs, t.acck,
          t.nlsk, substr(t.nlsk,1,4) nbsk,
          t.s*100,
          DECODE(t.s*100, 0, t.sq*100, gl.p_icurval (t.kv, t.s*100, o.vdat)),
          t.nazn,
          NVL(sb.f_75,'0') pr_d, NVL(sb1.f_75,'0') pr_k,
          NVL(sp.ob22,'00') ob22_d, NVL(sp1.ob22,'00') ob11_k
   FROM tmp_file03 t, sb_r020 sb, sb_r020 sb1, specparam_int sp, specparam_int sp1, oper o
   WHERE substr(t.nlsk,1,4)=sb1.r020
     and sb1.f_75='1'
     and t.accd=sp.acc(+)
     and substr(t.nlsd,1,4)=sb.r020(+)
     and t.acck=sp1.acc(+)
     and not exists (select 1 from ref_kor where ref=t.ref and vob=96)
     and t.ref = o.ref
   UNION
   SELECT t.fdat, t.ref, t.accd, t.nlsd, t.kv, substr(t.nlsd,1,4) nbs, t.acck,
          t.nlsk, substr(t.nlsk,1,4) nbsk,
          t.s*100, DECODE(t.s*100, 0, t.sq*100, gl.p_icurval (t.kv, t.s*100, r.vdat/*t.fdat*/)), nazn,
          NVL(sb.f_75,'0') pr_d, NVL(sb1.f_75,'0') pr_k,
          NVL(sp.ob22,'00') ob22_d, NVL(sp1.ob22,'00') ob11_k
   FROM tmp_file03 t, sb_r020 sb, sb_r020 sb1, specparam_int sp, specparam_int sp1, ref_kor r
   WHERE substr(t.nlsk,1,4)=sb1.r020
     and sb1.f_75='1'
     and t.accd=sp.acc(+)
     and substr(t.nlsd,1,4)=sb.r020(+)
     and t.acck=sp1.acc(+)
     and t.ref=r.ref
     and r.vob=96
     and r.vdat >= DECODE(Dat_, to_date('31052011','ddmmyyyy'), to_date('31122010','ddmmyyyy'), Dat_);

CURSOR BaseL IS
    SELECT kodp, nbuc, SUM (znap)
    FROM rnbu_trace
    GROUP BY kodp, nbuc;

BEGIN
logger.info ('P_F75SB: BEGIN ');
-------------------------------------------------------------------
userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
EXECUTE IMMEDIATE 'TRUNCATE TABLE TMP_FILE03';
-------------------------------------------------------------------
-- ����������� ��������� ����������
P_Proc_Set_Int(kodf_,sheme_,nbuc1_,typ_);

-- ���������� ������������� SB_R020
sql_acc_ := 'select r020 from sb_r020 where f_75=''1'' ';

ret_ := f_pop_otcn(Dat_, 2, sql_acc_,null,1);

if dat_ = to_date('31052011','ddmmyyyy') then
   datb_ := trunc(Dat_,'YYYY') + 1;
else
   datb_ := trunc(Dat_,'MM');
end if;

-- ��������� ��� �� � �� �������� �� ����� ��� ������ ����� @75
insert into tmp_file03(ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP
   from provodki_otc p, sb_r020 sb
   where p.fdat between datb_ and trunc(Dat_+28)
     and p.nbsd = sb.r020
     and sb.f_75 = '1'
--     and soso = 5
UNION
   select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP
   from provodki_otc p, sb_r020 sb
   where p.fdat between datb_ and trunc(Dat_+28)
     and p.nbsk = sb.r020
     and sb.f_75 = '1'
--     and soso = 5
     ;

if dat_ = to_date('31052011','ddmmyyyy') then
   delete from ref_kor;
   INSERT INTO ref_kor (REF, VOB, VDAT)
      SELECT ref, vob, vdat
      FROM oper
      WHERE vdat between to_date('31122010','ddmmyyyy') and dat_+28
        and vob in (96, 99)
        and sos = 5;
end if;

-- ������� �������� ���������� ���� � �������������� �������� ����������
delete from tmp_file03
where to_char(fdat,'MM')='01'
 and  (tt like 'ZG%' or
             (((nlsd LIKE '6%' or nlsd LIKE '7%') AND
              (nlsk LIKE '5040%' OR nlsk LIKE '5041%')) OR
             ((nlsd LIKE '5040%' OR nlsd LIKE '5041%') AND
              (nlsk LIKE '6%' OR nlsk LIKE '7%'))));

delete from tmp_file03
where ref in (select t.ref
              from tmp_file03 t, oper o
              where t.ref = o.ref and
                    o.vob in (96, 99) and
                    o.vdat <> dat_);

-- �������� ��������� ��������
--delete from tmp_file03
--where kv != 980
--  and (nlsd like '6%' or nlsd like '7%' or nlsk like '6%' or nlsk like '7%') or
--  --tt = '024' and (nlsd like '3739%' or nlsk like '3739%') and lower(nazn) like '%�����������%' or
--  FDAT > Dat_ and ref not in (select ref from ref_kor where vob=96) ;

OPEN Saldo;
   LOOP
   FETCH Saldo INTO rnk_, acc_, nls_, kv_, data_, Nbs_, Ostn_, Ostq_,
                    Dos96_, Dosq96_, Kos96_, Kosq96_, ob22_;
   EXIT WHEN Saldo%NOTFOUND;

   kk_ := '00';

   IF typ_>0 THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   --- ������� �� ���������� 6,7 ������� �� 5040,5041
   IF to_char(Dat_,'MM')='12' and (nls_ like '6%' or nls_ like '7%' or nls_ like '504%') THEN
    SELECT NVL(SUM(decode(dk,0,1,0)*s),0),
                    NVL(SUM(decode(dk,1,1,0)*s),0)
             INTO d_sum_, k_sum_
             FROM opldok
             WHERE fdat  between Dat_  AND Dat_+29 AND
                   acc  = acc_   AND
                   (tt like 'ZG8%'  or tt like 'ZG9%');

      Dos96_:=Dos96_-d_sum_;
      Kos96_:=Kos96_-k_sum_;
   END IF;

   Ostn_:=Ostn_-Dos96_+Kos96_;

   IF Ostn_<>0 THEN
      dk_:=IIF_N(Ostn_,0,'1','2','2');
      dk_:=dk_ || IIF_N(kv_, 980, '1', '0', '1');

      kodp_:=dk_ || Nbs_ || ob22_ || lpad(kv_, 3, '0') || kk_;
      znap_:=TO_CHAR(ABS(Ostn_));

      INSERT INTO rnbu_trace(nls, kv, odate, kodp, znap, acc, nbuc)
        VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, nbuc_) ;
   END IF;

   Ostq_:=Ostq_-Dosq96_+Kosq96_;
   IF Ostq_<>0 THEN
      dk_:=IIF_N(Ostq_,0,'1','2','2')||'0';
      kodp_:=dk_ || Nbs_ || ob22_ || lpad(kv_, 3, '0') || kk_;
      znap_:=TO_CHAR(ABS(Ostq_));

      INSERT INTO rnbu_trace(nls, kv, odate, kodp, znap, acc, nbuc)
        VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, nbuc_) ;
   END IF;

END LOOP;
CLOSE Saldo;
-----------------------------------------------------------------------------
OPEN OBOROTY;
LOOP
   FETCH OBOROTY INTO data_, ref_, accd_, nlsd_, kv_, Nbs_, acck_, nlsk_, nbsk_,
                       Dos_, Dosq_, nazn_, pr_d, pr_k, ob22_d, ob22_k;
   EXIT WHEN OBOROTY%NOTFOUND;

   comm_ := '';

   comm_ := substr(comm_ || ' �� ���. = ' || nlsd_ || ' �� ���. = ' || nlsk_ ||
               '  ' || nazn_, 1, 200);
   kk_ := '00';

   IF pr_d in ('1','5') THEN
      if nbs_ = '7702' and ob22_d in ('11','12','13','20','21','22','23','24','25','44','46','47','49','50','51','52') then
         kk_ := '01';
      elsif nbs_ = '7702' and ob22_d in ('14','15','16','38','39','40','45','48','57','58','59','60','61','62','63','64') then
         kk_ := '12';
      elsif nbs_ = '7702' and ob22_d in ('17','18','19','53','54','55','56') then
         kk_ := '14';
      end if;

      if nbs_ = '7706' and ob22_d in ('01','03','05','07','09','11','13','15','17') then
         kk_ := '01';
      elsif nbs_ = '7706' and ob22_d in ('02','04','06','08','10','12','14','16','18') then
         kk_ := '12';
      end if;

      -- ����� ���������i �� ���������� �������
      if nlsd_ like '7%' and nlsk_ like '380%' then
         kk_ := '01';
      end if;

      if kv_=980 and nlsd_ like '7%' and
         (nlsk_ like '149%' or nlsk_ like '159%' or
          nlsk_ like '189%' or nlsk_ like '240%' or
          nlsk_ like '289%' or
          nlsk_ like '319%' or nlsk_ like '329%' or
          nlsk_ like '359%' or nlsk_ like '369%')
      then
         kk_ := '01';
      end if;

      -- ��������� ������i� �� ������� ��������
      if (nlsd_ like '1%' or nlsd_ like '2%' or nlsd_ like '3%') and
         nlsk_ like '380%'
      then
         kk_ := '02';
      end if;

      -- �������� �� ������� �������
      if nlsd_ not like '7%' and (nlsk_ like '1%' or nlsk_ like '2%' or nlsk_ like '3%') and
         nlsk_ not like '380%'
      then
         kk_ := '03';
      end if;

      -- ���������� ��������������i
      if kv_=980 and
         (nlsd_ like '1%' or nlsd_ like '2%' or nlsd_ like '3%') and nlsk_ like '7%' then
         kk_ := '02';
      end if;

      -- ������������� �� i���� �������� ������i�
      if kv_=980 and
         (nlsd_ like '1%' or nlsd_ like '2%' or nlsd_ like '3%') and nlsk_ like '5%' then
         kk_ := '05';
      end if;

      if kv_=980 and nlsd_ like '7%' and nlsk_ like '3739%'
      then
         kk_ := '07';
      end if;

      if (nlsd_ like '149%' or nlsd_ like '159%' or
          nlsd_ like '189%' or nlsd_ like '240%' or
          nlsd_ like '289%' or
          nlsd_ like '319%' or nlsd_ like '329%' or
          nlsd_ like '359%' or nlsd_ like '369%') and nlsk_ like '3739%'
      then
         kk_ := '07';
      end if;

      -- �������i ������� ���� ���� 01
      if nbs_ = nbsk_ then
         if nbs_ = '7720' and ob22_d in ('13','14','15','16','17','23','25','27') then
            kk_ := '01';
         elsif nbs_ = '7720' and ob22_d in ('18','19','20','21','22','24','26','28') then
            kk_ := '12';
         elsif nbs_ = '7720' and ob22_d in ('12') then
            kk_ := '14';
         else
            kk_ := '11';
         end if;
      end if;

      -- ��������� ������i� �� ������� �������� �����
      if kv_ = 980 and (nlsd_ like '7%' and ob22_d='06') and (nlsk_ like '3590%' and ob22_k='03')
      then
         kk_ := '12';
      end if;

      IF Dos_ > 0 THEN
         if kv_ != 980 then
            dk_ := '51';
         else
            dk_ := '50';
         end if;

         IF typ_>0 THEN
            nbuc_ := NVL(F_Codobl_Tobo(accd_,typ_),nbuc1_);
         ELSE
            nbuc_ := nbuc1_;
         END IF;

         kodp_:= dk_ || Nbs_ || ob22_d || lpad(kv_, 3, '0') || kk_ ;
         znap_:=TO_CHAR(Dos_);
         INSERT INTO rnbu_trace(nls, kv, odate, kodp, znap, ref, comm, acc, nbuc)
         VALUES  (nlsd_, kv_, data_, kodp_, znap_, ref_, comm_, accd_, nbuc_) ;
      END IF;

      IF kv_ != 980 and Dosq_ > 0 THEN
         kodp_:= '50' || Nbs_ || ob22_d || lpad(kv_, 3, '0') || kk_ ;
         znap_:=TO_CHAR(Dosq_);

         IF typ_>0 THEN
            nbuc_ := NVL(F_Codobl_Tobo(accd_,typ_),nbuc1_);
         ELSE
            nbuc_ := nbuc1_;
         END IF;

         INSERT INTO rnbu_trace(nls, kv, odate, kodp, znap, ref, comm, acc, nbuc)
         VALUES  (nlsd_, kv_, data_, kodp_, znap_, ref_, comm_, accd_, nbuc_) ;
      END IF;

      if pr_k in ('1', '6') then
         if nbsk_ = '7702' and ob22_k in ('11','12','13','20','21','22','23','24','25','44','46','47','49','50','51','52') then
            kk_ := '11';
         elsif nbsk_ = '7702' and ob22_k in ('14','15','16','38','39','40','45','48','57','58','59','60','61','62','63','64') then
            kk_ := '02';
         elsif nbsk_ = '7702' and ob22_k in ('17','18','19','53','54','55','56') then
            kk_ := '04';
         end if;

         if nbsk_ = '7706' and ob22_k in ('01','03','05','07','09','11','13','15','17') then
            kk_ := '11';
         elsif nbsk_ = '7706' and ob22_k in ('02','04','06','08','10','12','14','16','18') then
            kk_ := '02';
         end if;

         -- ����� ���������i �� ���������� �������
         if nlsd_ like '7%' and nlsk_ not like '7%' then
            kk_ := '01';
         end if;

         -- �������i ������� ���� ���� 01
         if nbs_ = nbsk_ then
             if nbs_ = '7720' and ob22_k in ('13','14','15','16','17','23','25','27') then
                kk_ := '11';
             elsif nbs_ = '7720' and ob22_k in ('18','19','20','21','22','24','26','28') then
                kk_ := '02';
             elsif nbs_ = '7720' and ob22_k in ('12') then
                kk_ := '04';
             else
                kk_ := '01';
             end if;
         end if;

         -- ��� ������������ ����� ������ ��� �������
         if nlsd_ like '3739%' and nlsk_ like '7%' then
            kk_ := '07';
         end if;

         -- ��� ������������ ����� ������ ��� �������
         if nlsd_ like '3739%' and
            (nlsk_ like '149%' or nlsk_ like '159%' or
             nlsk_ like '189%' or nlsk_ like '240%' or
             nlsk_ like '289%' or
             nlsk_ like '319%' or nlsk_ like '329%' or
             nlsk_ like '359%' or nlsk_ like '369%')
         then
            kk_ := '07';
         end if;

         -- ��������� ������i� �� ������� �������� �����
         if kv_ = 980 and (nlsd_ like '7%' and ob22_d='06') and (nlsk_ like '3590%' and ob22_k='03')
         then
            kk_ := '12';
         end if;

         IF Dos_ > 0 THEN
            if kv_ != 980 then
               dk_ := '61';
            else
               dk_ := '60';
            end if;

            IF typ_>0 THEN
               nbuc_ := NVL(F_Codobl_Tobo(acck_,typ_),nbuc1_);
            ELSE
               nbuc_ := nbuc1_;
            END IF;

            kodp_:= dk_ || Nbsk_ || ob22_k || lpad(kv_, 3, '0') || kk_ ;
            znap_:=TO_CHAR(Dos_);

            INSERT INTO rnbu_trace(nls, kv, odate, kodp, znap, ref, comm, acc, nbuc)
            VALUES  (nlsk_, kv_, data_, kodp_, znap_, ref_, comm_, acck_, nbuc_) ;
         END IF;

         IF kv_ != 980 and Dosq_ > 0 THEN
            kodp_:= '60' || Nbsk_ || ob22_k || lpad(kv_, 3, '0') || kk_ ;
            znap_:=TO_CHAR(Dosq_);

            IF typ_>0 THEN
               nbuc_ := NVL(F_Codobl_Tobo(acck_,typ_),nbuc1_);
            ELSE
               nbuc_ := nbuc1_;
            END IF;

            INSERT INTO rnbu_trace(nls, kv, odate, kodp, znap, ref, comm, acc, nbuc)
            VALUES  (nlsk_, kv_, data_, kodp_, znap_, ref_, comm_, acck_, nbuc_) ;
         END IF;
      end if;

   END IF;

   kk_ := '00';

   IF pr_k in ('1', '6') and pr_d = '0' THEN

      comm_ := substr(comm_ || '   !!! �������� !!!', 1, 200);

      -- ����� ���������i �� ���������� �������
      if nlsd_ like '380%' and nlsk_ not like '7%' then
         kk_ := '01';
      end if;

      if nlsd_ like '7%' and nlsk_ not like '7%' then
         kk_ := '01';
      end if;

      -- ��������� ������i� �� ������� ��������
      if kv_ = 980 and nlsd_ like '3801%' and nlsk_ like '7%' then
         kk_ := '02';
      end if;

      -- ���������� ��������������i
      if (nlsd_ like '1%' or nlsd_ like '2%' or nlsd_ like '3%') and nlsd_ not like '3801%' and
         nlsk_ like '7%' then
         kk_ := '04';
      end if;

      -- ��� ������������ ����� ������ ��� �������
      if nlsd_ like '3739%' and nlsk_ like '7%' then
         kk_ := '07';
      end if;

      -- ��� ������������ ����� ������ ��� �������
      if nlsd_ like '3739%' and
        (nlsk_ like '149%' or nlsk_ like '159%' or
         nlsk_ like '189%' or nlsk_ like '240%' or
         nlsk_ like '289%' or
         nlsk_ like '319%' or nlsk_ like '329%' or
         nlsk_ like '359%' or nlsk_ like '369%')
      then
         kk_ := '07';
      end if;

      -- �������� �������
      if nlsd_ like '3903%' and
        (nlsk_ like '149%' or nlsk_ like '159%' or
         nlsk_ like '189%' or nlsk_ like '240%' or
         nlsk_ like '289%' or
         nlsk_ like '319%' or nlsk_ like '329%' or
         nlsk_ like '359%' or nlsk_ like '369%')
      then
         kk_ := '07';
      end if;

      IF Dos_ > 0 THEN
         if kv_ != 980 then
            dk_ := '61';
         else
            dk_ := '60';
         end if;

         kodp_:= dk_ || Nbsk_ || ob22_k || lpad(kv_, 3, '0') || kk_ ;
         znap_:=TO_CHAR(Dos_);

         IF typ_>0 THEN
            nbuc_ := NVL(F_Codobl_Tobo(acck_,typ_),nbuc1_);
         ELSE
            nbuc_ := nbuc1_;
         END IF;

         INSERT INTO rnbu_trace(nls, kv, odate, kodp, znap, ref, comm, acc, nbuc)
         VALUES  (nlsk_, kv_, data_, kodp_, znap_, ref_, comm_, acck_, nbuc_) ;
      END IF;

      IF kv_ != 980 and Dosq_ > 0 THEN
         kodp_:= '60' || Nbsk_ || ob22_k || lpad(kv_, 3, '0') || kk_ ;
         znap_:=TO_CHAR(Dosq_);

         IF typ_>0 THEN
            nbuc_ := NVL(F_Codobl_Tobo(acck_,typ_),nbuc1_);
         ELSE
            nbuc_ := nbuc1_;
         END IF;

         INSERT INTO rnbu_trace(nls, kv, odate, kodp, znap, ref, comm, acc, nbuc)
         VALUES  (nlsk_, kv_, data_, kodp_, znap_, ref_, comm_, acck_, nbuc_) ;
      END IF;
   END IF;
END LOOP;
CLOSE OBOROTY;

-- ���������� ���������� ������� �?����? (��� 06)
comm_ := '������������ ����������� ����������';

for k in (select acc, nls, kv, substr(kodp,3,4) nbs,
                 substr(kodp,7,2) ob22, substr(kodp,9,3) kvp,
                 NVL(sum(decode(substr(kodp,1,2),'50',to_number(znap),0)),0) dos,
                 NVL(sum(decode(substr(kodp,1,2),'60',to_number(znap),0)),0) kos
          from rnbu_trace
          where kv != 980
           and odate <= Dat_
           and substr(kodp,-2) not in ('06')
          group by acc, nls, kv, substr(kodp,3,4), substr(kodp,7,2), substr(kodp,9,3)
         UNION
         select acc, nls, kv, nbs,
                ob22, lpad(to_char(kv),3,'0') kvp,
                 0 dos,
                 0 kos
          from accounts
          where kv != 980
           and nbs in (select r020 from sb_r020 where f_75='1')
           and acc not in (select t.acc
                                 from rnbu_trace t
                                 where t.kv != 980
                                   and t.odate <= Dat_) )
  loop

     IF typ_>0 THEN
        nbuc_ := NVL(F_Codobl_Tobo(k.acc,typ_),nbuc1_);
     ELSE
        nbuc_ := nbuc1_;
     END IF;

     select NVL(sum(dosq - cudosq),0), NVL(sum(kosq - cukosq),0)
        into dos_, kos_
     from agg_monbals
     where fdat = trunc(Dat_, 'mm')
       and acc=k.acc;

--     SELECT NVL(sum(gl.p_icurval (t.kv, t.s*100, r.vdat/*t.fdat*/)),0)
--        INTO dosq96_
--     FROM tmp_file03 t, ref_kor r
--     WHERE t.nlsd = k.nls
--       and t.kv = k.kv
--       and t.ref=r.ref
--       and r.vob=96
--       and r.vdat >= Dat_-35
--       and r.vdat < Dat_;
--       --and exists (select 1 from ref_kor where ref=t.ref and vob=96 and vdat < Dat_);
--
--     dos_ := dos_ - dosq96_;
--
--     SELECT NVL(sum(gl.p_icurval (t.kv, t.s*100, r.vdat/*t.fdat*/)),0)
--        INTO dosq96_
--     FROM tmp_file03 t, ref_kor r
--     WHERE t.nlsk = k.nls
--       and t.kv = k.kv
--       and t.ref=r.ref
--       and r.vob=96
--       and r.vdat >= Dat_-35
--       and r.vdat < Dat_;
--       --and exists (select 1 from ref_kor where ref=t.ref and vob=96 and vdat < Dat_);
--
--     kos_ := kos_ - dosq96_;

      if dos_ != k.dos and dos_ != 0 and k.dos >= 0 then
        if dos_ -  k.dos > 0 then
           kodp_:= '50' || k.nbs || k.ob22 || lpad(k.kvp, 3, '0') || '06' ;
           znap_:= TO_CHAR(dos_ - k.dos);
        elsif dos_ -  k.dos < 0 then
           kodp_:= '60' || k.nbs || k.ob22 || lpad(k.kvp, 3, '0') || '06' ;
           znap_:= TO_CHAR(abs(dos_ - k.dos));
        end if;

        INSERT INTO rnbu_trace(nls, kv, odate, kodp, znap, ref, comm, acc, nbuc)
        VALUES  (k.nls, k.kv, dat_, kodp_, znap_, 0, comm_, k.acc, nbuc_) ;
     end if;

     if kos_ != k.kos and kos_ != 0 and k.kos >= 0 then
        if kos_ - k.kos > 0 then
            kodp_:= '60' || k.nbs || k.ob22 || lpad(k.kvp, 3, '0') || '06' ;
            znap_:= TO_CHAR(kos_ - k.kos);
        elsif kos_ -  k.kos < 0 then
           kodp_:= '50' || k.nbs || k.ob22 || lpad(k.kvp, 3, '0') || '06' ;
           znap_:= TO_CHAR(abs(kos_ - k.kos));
        end if;

        INSERT INTO rnbu_trace(nls, kv, odate, kodp, znap, ref, comm, acc, nbuc)
        VALUES  (k.nls, k.kv, dat_, kodp_, znap_, 0, comm_, k.acc, nbuc_) ;
     end if;
  end loop;

-- �������� ������������� �������� ����������� ������
if dat_ = to_date('31052011','ddmmyyyy') then
   delete from rnbu_trace
   where odate < Dat_
     and ref in (select ref
                 from oper
                 where vob=96
                   and vdat >= to_date('31122010','ddmmyyyy')
                   and vdat < to_date('28012011','ddmmyyyy'));
else
   delete from rnbu_trace
   where odate < Dat_
     and ref in (select ref from ref_kor where vob=96);
end if;

------------------------------------------------------------------
DELETE FROM tmp_irep where kodf='75' and datf= dat_;
------------------------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, nbuc_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_irep
        (kodf, datf, kodp, znap, nbuc)
   VALUES
        ('75', Dat_, kodp_, znap_, nbuc_);
END LOOP;
CLOSE BaseL;
------------------------------------------------------------------
logger.info ('P_F75SB: END ');
END p_f75sb;
/
show err;

PROMPT *** Create  grants  P_F75SB ***
grant EXECUTE                                                                on P_F75SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F75SB         to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F75SB.sql =========*** End *** =
PROMPT ===================================================================================== 
