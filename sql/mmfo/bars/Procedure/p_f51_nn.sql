

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F51_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F51_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_F51_NN (Dat_ DATE,
                                      sheme_ varchar2 default 'G',
                                      tipost_ varchar2 default 'S') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    ��������� ������������ @51 �������i� ���� ���������
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 2009.  All Rights Reserved.
% VERSION     :    13/01/2016 (12/01/2016, 29/01/2015)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
���������: Dat_ - �������� ����
           sheme_ - ����� ������������
           tipost_ - ��� �������� 6 � 7 �������
                     'S'-� ������ �������� ���������� �� 5040(5041)
                     'R'- ��� ����� �������� ���������� �� 5040(5041)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
13/01/2016 - ��������� �������� ���������� �������������� �� �������
07/09/2012 - ��������� �� �������� ���������� �� 02 �����
24.07.2012 - ������� ����� ������� F_POP_OTCN �� F_POP_OTCN_OLD �.�.
             �� ���������� ������� � �������� SNAP � 13.07.2012
07/12/2011 - ��������� �� �������� ���������� �� 02 �����
04/11/2011 - ������� �� OTCN_ARCH_PEREOC
05.04.2011 - ����� ORDER BY � ������� BASEL
18.03.2010 - ������� � ����� "C" ��� ������������ ���� �������������
07.10.2009 - ��� OB22 ������� ������� TRIM(ob22)
11.09.2009 - �������� �������������� ���� �� 02 �����, ���. ��� ��������
             ���������� ��� ���������
08.09.2009 - �� ������������� ��������i ��������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='51';
typ_     number;
rnk_     Number;
acc_     Number;
nbs_     Varchar2(4);
kv_      SMALLINT;
nls_     Varchar2(15);
mfo_     Varchar2(12);
nbuc1_   Varchar2(20);
nbuc_    Varchar2(20);
data_    Date;
re_      SMALLINT;
Ostn_    DECIMAL(24);
Ostq_    DECIMAL(24);
Dose_    DECIMAL(24);
dk_      Varchar2(2);
kodp_    Varchar2(11);
znap_    Varchar2(30);
userid_  Number;
dig_     number;
b_       Varchar2(30);
flag_    number;
tips_    Varchar2(3);
tsql_    varchar2(1000);
sql_acc_ varchar2(2000):='';
ret_     number;
ob22_    Varchar2(2);
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
pr_      NUMBER;
comm_    rnbu_trace.comm%TYPE;
add_     number;
k041_    varchar2(1);
pacc_    number;
d_sum_    number; 
k_sum_    number; 

CURSOR SALDO IS
   SELECT a.acc, a.nls, a.kv, a.nbs, s.fdat,  NVL(s.ost,0), NVL(s.ostq,0),
          a.tip, NVL(trim(p.ob22),'00'),
          s.dos96, s.dosq96, s.kos96, s.kosq96,
          s.dos99, s.dosq99, s.kos99, s.kosq99,
          s.doszg, s.koszg, s.dos96zg, s.kos96zg,
          substr(F_K041 (c.country),1,1) K041,
          lag(s.acc, 1) over (partition by substr(s.nls,1,4),s.kv order by s.acc) p_acc
   FROM otcn_saldo s, otcn_acc a, specparam_int p, customer c
   WHERE s.acc = a.acc
     and s.acc = p.acc(+)
     and s.rnk = c.rnk;
------------------------------------------------------------------
CURSOR BaseL IS
    SELECT kodp, nbuc, SUM(znap)
    FROM rnbu_trace
    WHERE to_number(znap) <> 0
    GROUP BY kodp, nbuc;
-----------------------------------------------------------------------------
procedure p_ins(p_dat_ date, p_tp_ varchar2, p_nls_ varchar2, p_nbs_ varchar2,
          p_ob22_ varchar2, p_kv_ smallint,
          p_znap_ varchar2) IS
                kod_ varchar2(11);

begin
   if length(trim(p_tp_)) = 1 then
      IF p_kv_ = 980 THEN
         kod_ := '0' ;
      ELSE
         kod_ := '1' ;
      END IF ;
   else
      kod_ := '';
   end if;

   kod_:= p_tp_ || kod_ || p_nbs_ || p_ob22_ || lpad(p_kv_,3,'0') ;

   if length(trim(p_tp_))>1 then
      flag_ := f_is_est(p_nls_, p_kv_);
   end if;

   INSERT INTO rnbu_trace
            (nls, kv, odate, kodp, znap, nbuc, comm, acc)
   VALUES  (p_nls_, p_kv_, p_dat_, kod_, p_znap_, nbuc_, comm_, acc_);
end;
-----------------------------------------------------------------------------
BEGIN
-------------------------------------------------------------------
userid_ := user_id;

EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
mfo_ := F_OURMFO();

------------------------------------------------------------------------
-- ����������� ��������� ���������� (��� ������� ��� ��� ��� �������������)
p_proc_set(kodf_,sheme_,nbuc1_,typ_);

sql_acc_ := 'select r020 from sb_r020 where f_21=''1''';

ret_ := f_pop_otcn(Dat_, 3, sql_acc_);

--- ������������ ��������� � ����. RBNU_TRACE
OPEN SALDO;
LOOP
   FETCH SALDO INTO acc_, nls_, kv_, nbs_, data_, Ostn_, Ostq_,
                    tips_, ob22_, Dos96_, Dosq96_, Kos96_, Kosq96_,
                    Dos99_, Dosq99_, Kos99_, Kosq99_,
                    Doszg_, Koszg_, Dos96zg_, Kos96zg_ , k041_, pacc_;
   EXIT WHEN SALDO%NOTFOUND;

   comm_ := ' ';

   if sheme_  in ('C','G') and (tips_<>'T00' and tips_<>'T0D') and typ_>0 then
      nbuc_ := nvl(nvl(F_Codobl_Tobo_new(acc_, dat_, typ_), F_Codobl_Tobo(acc_,typ_)), nbuc1_);
   else
      nbuc_ := nbuc1_;
   end if;

   -- ������� �� ���������� 6,7 ������� �� 5040,5041
   IF to_char(Dat_,'MM')='12' and (nls_ like '6%' or nls_ like '7%' or nls_ like '504%' or nls_ like '390%') THEN
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
   
   Ostn_ := Ostn_ - Dos96_ + Kos96_;
   Ostq_ := Ostq_ - Dosq96_ + Kosq96_;

   IF Ostn_ <> 0 THEN
      dk_ := IIF_N(Ostn_,0,'1','2','2');
      p_ins(data_, dk_, nls_, nbs_, ob22_, kv_, TO_CHAR(ABS(Ostn_)));
   END IF;

   IF Ostq_ <> 0 THEN
      dk_ := IIF_N(Ostq_,0,'1','2','2') || '0';

      p_ins(data_, dk_, nls_, nbs_, ob22_, kv_, TO_CHAR(ABS(Ostq_)));
   END IF;

END LOOP;
CLOSE SALDO;
---------------------------------------------------------------------
for k in (select a.*,
    (select recid from rnbu_trace r where r.kodp = substr(a.kodp,1,1)||'0'||substr(a.kodp,2) and nbuc = a.nbuc) recid,
    (select max(nbuc) from rnbu_trace r where r.kodp = substr(a.kodp,1,1)||'1'||substr(a.kodp,2)) new_nbuc
            from (
            select substr(kodp,1,1)||substr(kodp,3) kodp, nbuc
            from rnbu_trace
            where kodp not like '%980'
            group by substr(kodp,1,1)||substr(kodp,3), nbuc
            having count(*) = 1) a)
loop
    if k.new_nbuc is not null then
        update rnbu_trace
        set nbuc = k.new_nbuc
        where recid = k.recid;
    else
        select max(kodp), max(nbuc)
        into kodp_, nbuc_
        from rnbu_trace
        where kodp like substr(k.kodp,1,1)||'1'||substr(k.kodp,2,4)||'__'||substr(k.kodp,8);

        if kodp_ is not null and nbuc_ is not null then
            kodp_ := substr(kodp_,1,1)||'0'||substr(kodp_,3);

            update rnbu_trace
            set nbuc = nbuc_,
                kodp = kodp_
            where recid = k.recid;
        end if;
    end if;
end loop;
---------------------------------------------------
DELETE FROM tmp_nbu WHERE kodf = kodf_ AND datf = Dat_;
---------------------------------------------------
--- ������������ ����� � ����. TMP_NBU
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, nbuc_, znap_;
   EXIT WHEN BaseL%NOTFOUND;

   if substr(kodp_,9,3) = '980' or substr(kodp_,2,1) <> '1' then
      b_ := znap_;
   else
      dig_ := f_ret_dig(to_number(substr(kodp_,9,3)));
      b_ := TO_CHAR(ROUND(TO_NUMBER(znap_)/dig_,0));
   end if;

   INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap, nbuc)
   VALUES
        (kodf_, Dat_, kodp_, b_, nbuc_);
END LOOP;
CLOSE BaseL;

otc_del_arch('51', dat_, 0);
OTC_SAVE_ARCH('51', dat_, 0);
commit;
------------------------------------------------------------------
END p_f51_NN;
/
show err;

PROMPT *** Create  grants  P_F51_NN ***
grant EXECUTE                                                                on P_F51_NN        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F51_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
