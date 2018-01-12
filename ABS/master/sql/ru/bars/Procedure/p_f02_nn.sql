

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F02_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F02_NN ***

 CREATE OR REPLACE PROCEDURE BARS.P_F02_NN (Dat_ DATE,
                                      sheme_ varchar2 default 'G')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    ��������� ������������ ����� #02 ��� ��
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     :    10/01/2018 (14/11/2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
���������: Dat_ - �������� ����
           sheme_ - ����� ������������

05.02.2016 ��������� ��� ��������� �������� � ���������� ��������
08.07.2015 ����� �������� �� DRAPS(�) �� ����� ��������� �������������
           �������� �� ������������ ������ (��� ��� ���������)
05.03.2015 �� ���������� ������� �������������� �������� ����������� �
           ��������� �� �������� ������� ��� ������������
           (��� ��������� ����������)
02.01.2014 ������� ��������� ��������� ����������� � ��� ��� ���������
18.11.2013 �������� ���� ��� ���������� �������������� �������� ��������
           � �������� ������� ��� ������������ ������ �� �������� �.�.
           � ����. ACCM_AGG_MONBAL ��� ������������� ������ �� ��������
13.09.2013 ��� ���� PREM ����. KOD_R020 ������� ������� TRIM
           �.�. ����� ������� DBF ����� KOD_R020 ���� PREM ��� �������
04.02.2012 �������� ������� �������������� ��������� � ��������� ��
           �������� ������
01.02.2012 ��� ������ 6 ������� ����� �������� ������������� �������
           �������������� ������� � �� ��� ����������� ����������
           ������� ����� ��������� P_OTC_VE9 (������� ��� �������������)
27.07.2009 � ������� SALDO ���� ������� ������� OTCN_ACC �� ����������
           ���������� ������� OTCN_SALDO (���������� ���� "TIP")
24.07.2009 � ������� SALDO ����� ������� OTCN_ACC �.�. ���� "TIP" �������
           � ����. OTCN_SALDO
20.07.2009 ��� 9910 ������� ���� ���������� ����������
12.07.2009 ��� 3800_000000000 �������� ��� ������ ������ ��� ��������
02.06.2009 ������� ��� ����� �� �� ������ 9910_001% ����� ����� ������
           ������� ���������� ("10","20") �.�. � ����� #01.
           ��� ����� �� ��� ������ ���.���������� � ����� ����� �� 643,840,
           978 ��� ���������� �������� �������� ��� ������ �� 978 �.�.
           ��� ���� ������ ������ ���� ������� (��� � ������ ��).
01.04.2009 �� �������� ��� ������ ��� ������ ���.���������� ���.������
           � ������������� ������
04.04.2008 ����� �� ��� ������ ���.���������� � ����� ����� �� 643,840,
           978 ��� ���������� �������� �������� ��� ������ �� 978 �.�.
           ��� ���� ������ ������ ���� �������.
           ���� ���� ���������� � ��� �������� ��������� ������ ���
           ���������� ��������(��-��� ���������) � ����� �����������
           ������ ������������� �����.
07.03.2008 ��� ����� ���� ���������� ��������� �������� P_CH_FILE01
04.02.2008 ��� ��� ��� �� ������������ ���������� ���� F_01 � ��������-
           ������ KL_R020, � �������� ���.������ ���������� � ����
           ������� � KOD_R020, �� ����� ������������ KOD_R020 ������
           KL_R020
03.10.2006 ��� ���.����� 3929 ������� ��������� �������������� ��������
           �� �������� �� ����� (����� �� �������������� ���.�������� ��
           ������� ���.�����)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='02';
rnk_     number;
typ_      number;
acc_     Number;
dat1_    Date;
--dat2_    Date;
--datn_    date;
dig_     Number;
Dos_     DECIMAL(24);
Dosq_    DECIMAL(24);
Kos_     DECIMAL(24);
Kosq_    DECIMAL(24);
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
Ostn_    DECIMAL(24);
Ostq_    DECIMAL(24);
sk_      Number;
kodp_    Varchar2(10);
znap_    Varchar2(30);
Kv_      SMALLINT;
Kv1_     SMALLINT;
--Vob_     SMALLINT;
Nbs_     Varchar2(4);
nls_     Varchar2(15);
mfo_     number;
mfou_    NUMBER;
data_    Date;
p_dat    Date;
p_kodf   Varchar2(2):='02';
k041_    Char(1);
dk_      varchar2(2);
prem_    Char(3);
userid_  Number;
nbuc1_   Varchar2(12);
nbuc_    Varchar2(12);
b_       Varchar2(30);
tips_    Varchar2(3);
flag_    number;
sql_acc_ clob:='';
sql_doda_ clob:='';
ff_      number;
ret_     number;
pr_      NUMBER;
dati_    number;
dats_    Date;
d_sum_   DECIMAL(24);
k_sum_   DECIMAL(24);
l_acc_type    varchar2(3);
-------------------------------------------------------------------------------
CURSOR Saldo IS
   SELECT s.rnk, s.acc, s.nls, s.kv, s.fdat, s.nbs, s.ost, s.ostq,
          s.dos, s.dosq, s.kos, s.kosq,
          s.dos96p, s.dosq96p, s.kos96p, s.kosq96p,
          s.dos96, s.dosq96, s.kos96, s.kosq96,
          s.dos99, s.dosq99, s.kos99, s.kosq99,
          s.doszg, s.koszg, s.dos96zg, s.kos96zg,
          a.tip, nvl(l.k041,'1'), 
          'NOT' acc_type
   FROM  otcn_saldo s, otcn_acc a, customer cc, kl_k040 l
   WHERE a.acc=s.acc    and
         a.rnk=cc.rnk   and
         NVL(lpad(to_char(cc.country),3,'0'),'804')=l.k040(+) and
         a.dat_alt is null
         union all
   SELECT s.rnk, s.acc, d.acc_num nls, s.kv, s.fdat, substr(d.acc_num, 1, 4) nbs,
          (case when d.acc_type = 'OLD' then 0 else s.ost end) ost,
          (case when d.acc_type = 'OLD' then 0 else s.ostq end) ostq,
          --
          (case when d.acc_type = 'OLD' then d.dos_repm  else s.dos + d.dos_repm end) dos,
          (case when d.kv = 980 then 0 else (case when d.acc_type = 'OLD' then d.dosq_repm  else s.dosq + d.dosq_repm end) end) dosq,
          (case when d.acc_type = 'OLD' then d.kos_repm  else s.kos + d.kos_repm end) kos,
          (case when d.kv = 980 then 0 else (case when d.acc_type = 'OLD' then d.kosq_repm  else s.kosq + d.kosq_repm end) end) kosq,
          --
          s.dos96p,
          s.dosq96p,
          s.kos96p,
          s.kosq96p,
          (case when d.acc_type = 'OLD' then 0 else s.dos96 end) dos96,
          (case when d.acc_type = 'OLD' then 0 else s.dosq96 end) dosq96,
          (case when d.acc_type = 'OLD' then 0 else s.kos96 end) kos96,
          (case when d.acc_type = 'OLD' then 0 else s.kosq96 end) kosq96,
          (case when d.acc_type = 'OLD' then 0 else s.dos99 end) dos99,
          (case when d.acc_type = 'OLD' then 0 else s.dosq99 end) dosq99,
          (case when d.acc_type = 'OLD' then 0 else s.kos99 end) kos99,
          (case when d.acc_type = 'OLD' then 0 else s.kosq99 end) kosq99,
          (case when d.acc_type = 'OLD' then 0 else s.doszg end) doszg,
          (case when d.acc_type = 'OLD' then 0 else s.koszg end) koszg,
          (case when d.acc_type = 'OLD' then 0 else s.dos96zg end) dos96zg,
          (case when d.acc_type = 'OLD' then 0 else s.kos96zg end) kos96zg,
          a.tip, nvl(l.k041,'1'), d.acc_type
   FROM  otcn_saldo s, otcn_acc a, nbur_kor_balances d, customer cc, kl_k040 l
   WHERE a.acc=s.acc    and
         a.rnk=cc.rnk   and
         NVL(lpad(to_char(cc.country),3,'0'),'804')=l.k040(+)  and
         d.report_date between trunc(dat_, 'mm') and dat_ and
         s.acc = d.acc_id and
         a.dat_alt = to_date('18122017', 'ddmmyyyy');

---------------------------------------------------------------------------
procedure p_ins(p_dat_ date, p_tp_ varchar2, p_nls_ varchar2,p_nbs_ varchar2,
          p_kv_ smallint, p_k041_ varchar2, p_znap_ varchar2, p_acc_ number, p_nbuc_ varchar2) IS
                kod_ varchar2(10);

begin
   if length(trim(p_tp_))=1 then
      IF p_kv_=980 THEN
         kod_:='0' ;
      ELSE
         kod_:='1' ;
      END IF ;
   else
      kod_:= '';
   end if;

   kod_:= p_tp_ || kod_ || p_nbs_ || lpad(p_kv_,3,'0') || p_k041_ ;
   
   INSERT INTO rnbu_trace
            (nls, kv, odate, kodp, znap, nbuc, acc)
   VALUES  (p_nls_, p_kv_, p_dat_, kod_, p_znap_, p_nbuc_, p_acc_);
end;
-------------------------------------------------------------------------------
BEGIN
-------------------------------------------------------------------
userid_ := user_id;

EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
-- ���� ���
mfo_ := F_Ourmfo ();

-- ��� "��������"
BEGIN
   SELECT mfou
     INTO mfou_
     FROM BANKS
    WHERE mfo = mfo_;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      mfou_ := mfo_;
END;

p_dat := Dat_;

-- ����������� ���� ������� ��� ���������� ����� � �����
p_proc_set(kodf_,sheme_,nbuc1_,typ_);

--- �������� ���������� �� ����. otcn_acc, otcn_saldo
--- ���������� ������ (� ��� ����� ������ ���.����������) �
--- �� �������� (��������+�����������)+�������+�������������� �������
--- ��� ��� �������� ����������� � ������� F_POP_OTCN

-- ������ �������������� KL_R020 ����� ������������ KOD_R020
sql_acc_ := 'select r020 from kod_r020 where trim(prem)=''��'' and a010=''02'' and '||
            '(d_close is null or d_close > to_date('''||to_char(dat_, 'ddmmyyyy')||''',''ddmmyyyy'')) ';

if to_char(Dat_,'MM') in ('01','02','03','04','05','06') then
   ret_ := f_pop_otcn(Dat_, 4, sql_acc_, null, 1);
else
   ret_ := f_pop_otcn(Dat_, 3, sql_acc_);
end if;

Dat1_ := TRUNC(Dat_,'MM'); -- ������� ������������ �_����

dati_ := f_snap_dati(dat_, 2);

BEGIN
   SELECT TO_DATE(val,'DDMMYYYY')
      INTO dats_
   FROM params WHERE par='DATRAPS';
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      dats_ := null;
END;

----------------------------------------------------------------------------
-- ���� ��� ���������� �������������� ��������
-- �������� � �������� �������� �������
-- �� ������������ ������ �� ��������
IF dats_ is null
THEN
   for tt in ( select a.accc accc, a.acc acc, a.nls, a.kv,
                      s.crdos, s.crdosq, s.crkos, s.crkosq,
                      s.cudos, s.cudosq, s.cukos, s.cukosq
               from accounts a, accm_agg_monbals s, kod_r020 k
               where a.accc is not null
                 and a.acc = s.acc
                 and s.caldt_id = dati_
                 and a.nls like k.r020 || '%'
                 and a010 = '02'
                 and trim(prem)='��'
             )

       loop

         if tt.cudos+tt.cudosq+tt.cukos+tt.cukosq+tt.crdos+tt.crdosq+tt.crkos+tt.crkosq<>0 then

            update otcn_saldo set dos96p = dos96p + tt.cudos,
                                  dosq96p = dosq96p + decode(tt.kv, 980, 0, tt.CUdosq),
                                  kos96p = kos96p + tt.cukos,
                                  kosq96p = kosq96p + decode(tt.kv, 980, 0, tt.CUkosq),
                                  dos96  = dos96 + tt.crdos,
                                  dosq96 = dosq96 + decode(tt.kv, 980, 0, tt.CRdosq),
                                  kos96  = kos96 + tt.crkos,
                                  kosq96 = kosq96 + decode(tt.kv, 980, 0, tt.CRkosq)
            where acc = tt.accc;

         end if;

       end loop;
END IF;

-- ��������� �� ������� ����� ���������� �� "������������" ��������
IF to_char(dats_,'MM') = to_char(Dat_,'MM')
THEN
   for tt in ( select a.accc accc, a.acc acc, a.nls, a.kv,
                      s.crdos, s.crdosq, s.crkos, s.crkosq,
                      s.cudos, s.cudosq, s.cukos, s.cukosq
               from accounts a, accm_agg_monbals s, kod_r020 k
               where a.accc is not null
                 and a.acc = s.acc
                 and s.caldt_id = dati_
                 and a.nls like k.r020 || '%'
                 and a010 = '02'
                 and trim(prem)='��'
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
----------------------------------------------------------------------------
OPEN Saldo;
   LOOP
   FETCH Saldo INTO rnk_, acc_, nls_, kv_, data_, Nbs_, Ostn_, Ostq_,
                    Dos_, Dosq_, Kos_, Kosq_,
                    Dos96p_, Dosq96p_, Kos96p_, Kosq96p_,
                    Dos96_, Dosq96_, Kos96_, Kosq96_,
                    Dos99_, Dosq99_, Kos99_, Kosq99_,
                    Doszg_, Koszg_, Dos96zg_, Kos96zg_,
                    tips_, k041_, l_acc_type;
   EXIT WHEN Saldo%NOTFOUND;

   if typ_ > 0 then
      nbuc_ := nvl(f_codobl_tobo(acc_,typ_),nbuc1_);
   else
      nbuc_ := nbuc1_;
   end if;
   
   if l_acc_type in ('NEW', 'NOT') then
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

       IF Dos99_ > 0 THEN
          BEGIN
            select NVL(sum(s),0)
               into sk_
            from kor_prov
            where vob=99
              and dk=0
              and acc=acc_
              and fdat between Dat_+1 and Dat_+28;
          EXCEPTION WHEN NO_DATA_FOUND THEN
             sk_ := 0;
          END;

          Dos99_ := Dos99_ - sk_;
       END IF;

       IF Kos99_ > 0 THEN
          BEGIN
            select NVL(sum(s),0)
               into sk_
            from kor_prov
            where vob=99
              and dk=1
              and acc=acc_
              and fdat between Dat_+1 and Dat_+28;
          EXCEPTION WHEN NO_DATA_FOUND THEN
             sk_ := 0;
          END;

          Kos99_ := Kos99_ - sk_;
       END IF;

       IF Dosq99_ > 0 THEN
          BEGIN
            select NVL( sum(gl.p_icurval(kv_, s, vdat)), 0)
               into sk_
            from kor_prov
            where vob=99
              and dk=0
              and acc=acc_
              and fdat between Dat_+1 and Dat_+28;
          EXCEPTION WHEN NO_DATA_FOUND THEN
             sk_ := 0;
          END;

          Dosq99_ := Dosq99_ - sk_;
       END IF;

       IF Kosq99_ > 0 THEN
          BEGIN
            select NVL( sum(gl.p_icurval(kv_, s, vdat)), 0)
               into sk_
            from kor_prov
            where vob=99
              and dk=1
              and acc=acc_
              and fdat between Dat_+1 and Dat_+28;
          EXCEPTION WHEN NO_DATA_FOUND THEN
             sk_ := 0;
          END;
          
          Kosq99_ := Kosq99_ - sk_;
       END IF;

       Dos_  := Dos_ - Dos96p_ - Dos99_;
       Dosq_ := Dosq_ - Dosq96p_ - Dosq99_;
       Kos_  := Kos_ - Kos96p_ - Kos99_;
       Kosq_ := Kosq_ - Kosq96p_ - Kosq99_;

       --- ������� �� ���������� 6,7 ������� �� 5040,5041
       IF to_char(Dat_,'MM')='01' and (nls_ like '6%' or nls_ like '7%' or nls_ like '504%') THEN
        SELECT NVL(SUM(decode(dk,0,1,0)*s),0),
                        NVL(SUM(decode(dk,1,1,0)*s),0)
                 INTO d_sum_, k_sum_
                 FROM opldok
                 WHERE fdat  = trunc(Dat_, 'mm') AND
                       acc  = acc_   AND
                       (tt like 'ZG1%' OR tt like 'ZG2%');

          Dos_ := Dos_ - d_sum_;
          Kos_ := Kos_ - k_sum_;
       END IF;
   end if;

   if l_acc_type  = 'NEW' then
      declare
         dosn_kor number;
         kosn_kor number;
         dosq_kor number;
         kosq_kor number;
       begin
          SELECT nvl(DOS_REPM, 0) - nvl(DOS_REPD, 0), 
                 nvl(DOSQ_REPM, 0) - nvl(DOSQ_REPD, 0), 
                 nvl(KOS_REPM, 0) - nvl(KOS_REPD, 0), 
                 nvl(KOSQ_REPM, 0) - nvl(KOSQ_REPD, 0)
             INTO dosn_kor, dosq_kor, kosn_kor, kosq_kor
          FROM nbur_kor_balances
          WHERE report_date = to_date('18122017','ddmmyyyy') AND
                acc_id  = acc_   AND
                acc_type = 'OLD';
              
          Dos_ := Dos_ - (dosn_kor - Dos96p_);
          Kos_ := Kos_ - (kosn_kor - Kos96p_);
              
          if kv_ <> 980 then
             Dosq_ := Dosq_ - (dosq_kor - Dosq96p_);
             Kosq_ := Kosq_ - (kosq_kor - Kosq96p_);
          end if;
       exception 
            when no_data_found then 
                null;
       end;
   end if;     
   
   if l_acc_type  = 'OLD' then
          Dos_ := Dos_ - Dos96p_;
          Kos_ := Kos_ - Kos96p_;
              
          if kv_ <> 980 then
             Dosq_ := Dosq_ - Dosq96p_;
             Kosq_ := Kosq_ - Kosq96p_;
          end if;
   end if;       

   IF substr(nls_,1,4)='3929' AND Kv_=980 then

      IF Dos_=Kos_ THEN
         Dos_:=0;
         Kos_:=0;
      END IF;

      IF Dos_ > Kos_ THEN
         Dos_:=Dos_-Kos_ ;
         Kos_:=0;
      END IF;

      IF Dos_ < Kos_ THEN
         Kos_:=Kos_-Dos_ ;
         Dos_:=0;
      END IF;

      IF Dosq_=Kosq_ THEN
         Dosq_:=0;
         Kosq_:=0;
      END IF;

      IF Dosq_ > Kosq_ THEN
         Dosq_:=Dosq_-Kosq_ ;
         Kosq_:=0;
      END IF;

      IF Dosq_ < Kosq_ THEN
         Kosq_:=Kosq_-Dosq_ ;
         Dosq_:=0;
      END IF;
   END IF;

-- ������ ** ������� 28.09.2005
   IF Dos_ < 0 THEN
      Kos_:=Kos_+ABS(Dos_);
      Dos_ := 0;
   END IF;

   IF Kos_ < 0 THEN
      Dos_:=Dos_+ABS(Kos_);
      Kos_ := 0;
   END IF;
-- ��������� **

   IF Dosq_ < 0 THEN
      Kosq_:=Kosq_+ABS(Dosq_);
      Dosq_ := 0;
   END IF;

   IF Kosq_ < 0 THEN
      Dosq_:=Dosq_+ABS(Kosq_);
      Kosq_ := 0;
   END IF;

   IF Dos_ > 0 THEN
      p_ins(data_, '5', nls_, nbs_, kv_, k041_, TO_CHAR(Dos_), acc_, nbuc_);
   END IF;

   IF Dosq_ > 0  THEN
      p_ins(data_, '50', nls_, nbs_, kv_ , k041_, TO_CHAR(Dosq_), acc_, nbuc_);
   END IF;

   IF Kos_ > 0 THEN
      p_ins(data_, '6', nls_, nbs_, kv_, k041_, TO_CHAR(Kos_), acc_, nbuc_);
   END IF;

   IF Kosq_ > 0 THEN
      p_ins(data_, '60', nls_, nbs_, kv_ , k041_, TO_CHAR(Kosq_), acc_, nbuc_);
   END IF;

   IF Dos96_ > 0  THEN
      p_ins(data_, '7', nls_, nbs_, kv_, k041_, TO_CHAR(Dos96_), acc_, nbuc_);
   END IF;

   IF Dosq96_ > 0 THEN
      p_ins(data_, '70', nls_, nbs_, kv_, k041_, TO_CHAR(Dosq96_), acc_, nbuc_);
   END IF;

   IF Kos96_ > 0 THEN
      p_ins(data_, '8', nls_, nbs_, kv_, k041_, TO_CHAR(Kos96_), acc_, nbuc_);
   END IF;

   IF Kosq96_ > 0 THEN
      p_ins(data_, '80', nls_, nbs_, kv_, k041_, TO_CHAR(Kosq96_), acc_, nbuc_);
   END IF;

   IF Dos99_ > 0 THEN
      p_ins(data_, '9', nls_, nbs_, kv_, k041_, TO_CHAR(Dos99_), acc_, nbuc_);
   END IF;

   IF Dosq99_ > 0 THEN
      p_ins(data_, '90', nls_, nbs_, kv_, k041_, TO_CHAR(Dosq99_), acc_, nbuc_);
   END IF;

   IF Kos99_ > 0 THEN
      p_ins(data_, '0', nls_, nbs_, kv_, k041_, TO_CHAR(Kos99_), acc_, nbuc_);
   END IF;

   IF Kosq99_ > 0 THEN
      p_ins(data_, '00', nls_, nbs_, kv_, k041_, TO_CHAR(Kosq99_), acc_, nbuc_);
   END IF;

   if l_acc_type <> 'OLD' then
      Ostn_:=Ostn_-Dos96_+Kos96_;
      Ostq_:=Ostq_-Dosq96_+Kosq96_;
   end if;
   
   IF Ostn_<>0 THEN
      dk_:=IIF_N(Ostn_,0,'1','2','2');
      p_ins(data_, dk_, nls_, nbs_, kv_, k041_, TO_CHAR(ABS(Ostn_)), acc_, nbuc_);
   END IF;
    
   IF Ostq_<>0 THEN
      dk_:=IIF_N(Ostq_,0,'1','2','2')||'0';
      p_ins(data_, dk_ , nls_, nbs_, kv_ , k041_, TO_CHAR(ABS(Ostq_)), acc_, nbuc_);
   END IF;

END LOOP;
CLOSE Saldo;

-- ������� ����� � �������.
DELETE FROM TMP_NBU WHERE kodf=kodf_ AND datf= dat_;

INSERT INTO TMP_NBU (kodf, datf, kodp, nbuc, znap)
select kodf_, dat_, kodp, nbuc, SUM(znap)
from RNBU_TRACE
GROUP BY kodp, nbuc;
------------------------------------------------------------------
END p_f02_NN;
/
show err;

PROMPT *** Create  grants  P_F02_NN ***
grant EXECUTE                                                                on P_F02_NN        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F02_NN.sql =========*** End *** 
PROMPT ===================================================================================== 

