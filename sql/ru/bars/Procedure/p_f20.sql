

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F20.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F20 ***

  CREATE OR REPLACE PROCEDURE BARS.P_F20 (Dat_ DATE, sheme_ varchar2 default 'G' )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    ��������� ������������ ����� #20 ��� ��
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
%
% VERSION     :     v.17.002      20.12.2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ���������: Dat_ - �������� ����

   ��������� ����������    DDDDDDDD

 1     DDDDDDDD          ������ ����������� �� stru_20

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%/%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

20.12.2017 ����� ������ �����������, ������ �������� � R013 �� R011
01.12.2017 �������� ������ �������� DDDDDDDD
11.01.2016 � ������� SALDO ����� �������(view) CUST_ACC
31.12.2014 �� 31.12.2014 �� ����� ������������� ��������� ����������
           � ���.������ (��� ������ 643)
           � 31.12.2014 ���� 821-877 �� ����� �������������
26.09.2014 ��� ���.������ 1416,1417 ��������� ������ 83814171,83914171
           � ��-� KL_F20 � ����� ��� R016 in ('10','90')
           ��� ���������� � ���� � ������������ 83214171, 83314161
17.06.2014 ��������� � ������� ����� ����������
26.11.2013 ��������� ��������� ��������� R016
05.11.2012 ��������� ������������ ����� "41714001", "41814001"
31.10.2012 ������� ������������ ����� ����������� 751-757, 761-767
           � ��-�� KL_F20 ������� �������� S181='X' ��� 1410,1420
           � ������� � ��� 1410 ������ ��� ��������
04.07.2012 � 02.07.2012 ������� ����� ���������� 751-757, 761-767
30.05.2012 � 01.04.2012 �������� ���������� ��� ������ 643 � ������� ���
           ����������� � ����� DDD in (192,193) � ������ 643 ���������
           ���� DDD (392,393) � ��� ����� 801-820 � ������ 643 ���������
           ���� DDD (901-920)
15.09.2010 ��� ���(mfou_=300205) ?�� ��������� ���������� 99900000"
18.05.2010 ��� ��������� (mfou_=300465) �� ��������� ���������� "99900000"
22.10.2008 ��������� ��������� ����� ����� 721-738 �� �������� ����
           ��������� �������
26.06.2008 � 115 ������ ������� ������� k030 in ('X', rez_) ��
           k030 in ('X', to_char(rez_)) (k030- ������, rez_ - �����)
           (�� ����������� ������������ � ���������)
05.01.2008 ������������ ��������� ������������� KL_F20  ������ KL_F3_29
24.11.2007 ��������� ���� 092, 192 (�/� 2700,2701,2706,2707 �����������
           � R013='2')
27.02.2007 ��� ���.����� 2600 ��������� ��������� �������� ���������
          R013  '5','6','7' (����� ���� '1','2','9')
10.05.2006 ��������� ������������ ����� ����� 031,032,041,042,043,044,
046,047,048,049,050,051,131,132,141,142,143,144,146,146,148,149,150,151
����� ����� ������� ��-�� ��� #20 ������ KL_F20.sql
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

kodf_     Varchar2(2) := '20';
kodp_     varchar2(10);
znap_     varchar2(30);

acc_      Number;
nbs_      varchar2(4);
nls_      varchar2(15);
data_     date;
mdate_    date;
kv_       SMALLINT;
t020_     Varchar2(1);
rez_      NUMBER;

r031_     VARCHAR2(1);
se_       DECIMAL(24);
r011_     varchar2(1);
r013_     varchar2(1);

ddd_      varchar2(8);
userid_   Number;
mfo_      NUMBER;
mfou_     NUMBER;
typ_      number;
nbuc_     varchar2(12);
nbuc1_    varchar2(12);

-------------------------------------------------------------------
CURSOR SALDO IS
   SELECT a.acc, a.nls, a.kv, dat_, a.nbs, a.mdate, 2-mod(c.codcagent,2),
          decode(a.kv,980,'1','2'), nvl(cc.r011,'9'), nvl(cc.r013,'9'),
          fostq(a.acc, Dat_)
   FROM accounts a,
        customer c, specparam cc
   WHERE a.nbs in (select distinct r020 from kl_f20 where kf='20')
     AND a.acc=cc.acc(+)
     AND c.rnk=a.rnk ;

CURSOR BaseL IS
   SELECT kodp, nbuc, SUM (ABS(znap))
   FROM rnbu_trace
   WHERE userid=userid_
   GROUP BY kodp, nbuc;

BEGIN
-------------------------------------------------------------------
userid_ := user_id;
logger.info ('P_F20: Begin for datf = '||to_char(dat_, 'dd/mm/yyyy'));
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
   mfo_ := f_ourmfo ();

-- ��� "��������"
   BEGIN
      SELECT mfou
         INTO mfou_
      FROM banks
      WHERE mfo = mfo_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         mfou_ := mfo_;
   END;

   -- ����������� ��������� ���������� (��� ������� ��� ��� ��� �������������)
   P_Proc_Set(kodf_,sheme_,nbuc1_,typ_);
   nbuc_ := nbuc1_;

   OPEN SALDO;
   LOOP
      FETCH SALDO INTO acc_, nls_, kv_, data_, nbs_, mdate_, rez_, r031_,
                       r011_, r013_, se_ ;
      EXIT WHEN SALDO%NOTFOUND;
   
      IF typ_ >0 THEN
         nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
      ELSE
         nbuc_ := nbuc1_;
      END IF;
   
      if se_ < 0 then
         t020_ := '1';
      else
         t020_ := '2';
      end if;

      IF  (nbs_='2601' and r011_ in ('4','5')     and se_>0 )  OR
          (nbs_='2701' and r011_ in ('1','2','3') and se_>0 )  OR
          (nbs_='2706' and r011_ in ('1','2','3') )
      THEN

         BEGIN
            SELECT ddd    into ddd_
            FROM kl_f20
            WHERE kf ='20'
              and r020 = nbs_
              and t020 = t020_
              and k030 = 'X'
              and r031 in ('X', r031_)
              and s181 = 'X'
              and r013 in ('X', r011_)
              and rownum = 1 ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            ddd_ :='99900000';
         END ;

         if ddd_ != '99900000'  then

             kodp_ := trim(ddd_) ;
             znap_ := to_char(ABS(se_)) ;

             INSERT INTO rnbu_trace
                       ( nls, kv, odate, kodp, znap, nbuc, comm)
                VALUES ( nls_, kv_, data_, kodp_, znap_, nbuc_,
                         't020='||t020_||' r031='||r031_||' r011='||r011_ ) ;
         end if;

      END IF;

   END LOOP;

CLOSE SALDO;

---------------------------------------------------
DELETE FROM tmp_nbu where kodf='20' and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, nbuc_, znap_;
   EXIT WHEN BaseL%NOTFOUND;

   IF znap_<>0 THEN
      INSERT INTO tmp_nbu
                ( kodf, datf, kodp, znap, nbuc)
         VALUES ( kodf_, Dat_, kodp_, znap_, nbuc_);
   END IF;

END LOOP;
CLOSE BaseL;
----------------------------------------
   logger.info ('P_F20: END ');
END p_f20;
/
show err;

PROMPT *** Create  grants  P_F20 ***
grant EXECUTE                                                                on P_F20           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F20           to RPBN002;
grant EXECUTE                                                                on P_F20           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F20.sql =========*** End *** ===
PROMPT ===================================================================================== 
