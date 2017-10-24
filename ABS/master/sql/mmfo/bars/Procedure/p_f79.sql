

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F79.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F79 ***

  CREATE OR REPLACE PROCEDURE BARS.P_F79 (Dat_ DATE )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : #79 for KB
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 02.10.2014 (21.02.2014,29.01.2014,21.01.2014,18.02.2013)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ���������: Dat_ - �������� ����
%
%01.10.2014 - ��� ������ ������������ ������������ ��������� �� ���� 
%             NAME ����. RC_BNK (���������� ���)            
%21.02.2014 - ���������� 08ZZZZZZZZZZVVVNNNN ����� ������������� ��� 
%             ���������� ��������� ����� (D#79_08) �.�. ��� ������ 840
%             � 10.02.2014 ���������� ��������� �����   
%29.01.2014 - ��������� ������������ ���������� 16ZZZZZZZZZZVVVNNNN 
%             � 01.02.2014   
%21.01.2014 - ������� ����������� ���������� userid_  
%18.02.2013 - ���������� "10" ��� ����� �� (300465) ����� ������������� 
%             ����� ��� � ��� ������ ������  (���."07"*���."09")/100. 
%             (��������� ������������� ������������) 
%01.06.2010 - ���������� "10" ����� ������������ ��� ����� (���."07"*
%             ���."09")/100. ���������� 09 �������� %% �����������.
%28.05.2010 - � ������� ��������� ������� ���������� ACC ����� ��� ����
%             ����� ��������� (���� �� ��� ����) 
%27.05.2010 - ��� ���=300465 �������� ���������� 10 ����� ������������� 
%             ����� �� ��� � ���������� 07 
%26.05.2010 - ����� ��������� ��������� ����. ACCOUNTSW ���.���������
%             D#79_01 - D#79_15. 
%03.01.2008 - �������� ���.����� 3660,3661 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
acc_     Number;
nls_     Varchar2(15);
dat_izm1 Date := to_date('31/01/2014','dd/mm/yyyy');
data_    Date;
kv_      SMALLINT;
dat1_    Date;
Oste_    Number;
na_      Number;
pna_     Char(4);
nmk_     Varchar2(70);
adr_     Varchar2(70);
kod_     Varchar2(14);
kodp_    Varchar2(19);
znap_    Varchar2(70);
userid_  Number;
n_       Number;
tag_     Varchar2(8);
val_     Varchar2(200);
sum_p09_ Number;
sum_p10_ Number;
rez_     Number;
mfo_     Number;
mfou_    Number;
custtype_ Number;
rnk_     Number;

--�������
CURSOR Saldo IS
  SELECT a.acc, a.nls, a.kv, a.fdat, a.ostf-a.dos+a.kos, 
         LTRIM(RTRIM(c.nmk)), c.adr, c.okpo, 2-mod(c.codcagent,2), c.custtype
  FROM (SELECT s.acc, s.nls, s.kv, aa.fdat, s.nbs, aa.ostf,
         aa.dos, aa.kos
         FROM saldoa aa, accounts s
         WHERE aa.acc=s.acc     AND
              (s.acc,aa.fdat) =
               (select c.acc,max(c.fdat)
                from saldoa c
                where s.acc=c.acc and c.fdat <= Dat_
                group by c.acc)) a,
        cust_acc ca, customer c
  WHERE a.acc=ca.acc             AND
        c.rnk=ca.rnk             AND
        a.nbs in ('3660','3661') AND
        a.ostf-a.dos+a.kos <>0    
  ORDER BY a.ostf-a.dos+a.kos DESC ;

CURSOR BaseL IS
    SELECT nls, kodp, znap
    FROM rnbu_trace
    WHERE userid=userid_
---    GROUP BY kodp
    ORDER BY nls, substr(kodp,3,2) ;

BEGIN
-------------------------------------------------------------------
--SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
--DELETE FROM RNBU_TRACE WHERE userid = userid_;
userid_ := user_id;
EXECUTE IMMEDIATE 'truncate table rnbu_trace';
-------------------------------------------------------------------
-- ���� ���
   mfo_ := F_Ourmfo ();

-- ��� "��������"
   BEGIN
      SELECT NVL(trim(mfou), mfo_)
        INTO mfou_
      FROM BANKS
      WHERE mfo = mfo_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         mfou_ := mfo_;
   END;

na_:=1 ;

OPEN Saldo;
LOOP
    FETCH Saldo INTO acc_, nls_, kv_, data_, Oste_, nmk_, adr_, kod_, rez_,
                     custtype_ ;
    EXIT WHEN Saldo%NOTFOUND;
    
    sum_p10_ := 0;

    IF Oste_ <> 0 THEN 

       pna_:= LPAD (to_char(na_), 4, '0');  --SUBSTR((10000+na_) || '',2,4) ;
       kod_:= LPAD (TRIM (kod_), 10, '0');  --SUBSTR((10000000000+to_number(kod_)) || '',2,10) ;

       --kodp_:='01' || kod_ || LPAD (to_char(kv_), 3, '0') || pna_ ;
       --INSERT INTO rnbu_trace         -- ������������ �������
       --                 (nls, kv, odate, kodp, znap, acc) VALUES
       --                 (nls_, kv_, data_, kodp_, nmk_, acc_);

       n_ := 15;

       FOR i IN 1 .. n_
       LOOP
          tag_ := 'D#79_' || LPAD(TO_CHAR (i),2,'0');

          BEGIN
             SELECT SUBSTR (VALUE, 1, 70)
                INTO val_
             FROM accountsw
             WHERE acc = acc_ AND trim(tag) = tag_;
          EXCEPTION WHEN NO_DATA_FOUND THEN
             val_ := NULL;
          END;

          if i = 1 then
             nmk_ := NVL(trim(val_),nmk_);
          end if;                        

          if i in (2,3,4,5,8,9,14,15) then 
             -- ����� ���������
             if i = 2 then
                val_ := NVL(trim(val_),'���� ��������� �����');
             elsif i = 3 then
                val_ := NVL(trim(val_),'���� ��������� 䳿 �����');
             elsif i = 4 then
                val_ := NVL(trim(val_),'���� ������ ���������� �������');
             elsif i = 5 then
                val_ := NVL(trim(val_),'����� ������ ���������� �������');
             elsif i = 8 then
                --sum_p10_ := sum_p10_ + to_number(val_);
                sum_p10_ := sum_p10_ + GL.P_ICURVAL(kv_, to_number(val_), dat_);
                --val_ := NVL(trim(val_),'���� ���������� ������� �� ��������� �� �� �������');
                val_ := NVL(to_char(GL.P_ICURVAL(kv_, to_number(trim(val_)), dat_)),'���� ���������� ������� �� ��������� �� �� �������');
             elsif i = 9 then
                sum_p09_ := to_number(val_);
                val_ := NVL(trim(val_),'����� �����������');
             elsif i = 14 then
                val_ := NVL(trim(val_),'����� ��������� ��������');
             elsif i = 15 then
                val_ := NVL(trim(val_),'���� ��������� ��������');
             else 
                null;
             end if;

             kodp_:=LPAD(to_char(i),2,'0') || kod_ || LPAD(to_char(kv_),3,'0') || pna_ ;
             znap_:=val_;
             INSERT INTO rnbu_trace         
                        (nls, kv, odate, kodp, znap, acc) VALUES
                        (nls_, kv_, data_, kodp_, znap_, acc_);
          end if;

       END LOOP;

       -- ����� ����������� (����� �� RC_BNK) 
       if custtype_ = 1 and rez_ = 2
       then
          BEGIN
             select name 
                into nmk_
             from rc_bnk
             where b010 = kod_; 
          EXCEPTION WHEN NO_DATA_FOUND THEN
             null;
          END;
       end if;

       kodp_:='01' || kod_ || LPAD (to_char(kv_), 3, '0') || pna_ ;
       INSERT INTO rnbu_trace         -- ������������ �������
                        (nls, kv, odate, kodp, znap, acc) VALUES
                        (nls_, kv_, data_, kodp_, nmk_, acc_);

       --kodp_:='02' || kod_ || substr((1000+kv_) || '',2,3) || pna_ ;
       --znap_:='���� ��������� �����' ;
       --INSERT INTO rnbu_trace         -- ���� ��������� �����
       --                 (nls, kv, odate, kodp, znap, acc) VALUES
       --                 (nls_, kv_, data_, kodp_, znap_, acc_);
 
       --kodp_:='03' || kod_ || substr((1000+kv_) || '',2,3) || pna_ ;
       --znap_:='���� ���i������ �ii �����' ;
       --INSERT INTO rnbu_trace         -- ���� ���i������ �ii �����
       --                 (nls, kv, odate, kodp, znap, acc) VALUES
       --                 (nls_, kv_, data_, kodp_, znap_, acc_);

       --kodp_:='04' || kod_ || substr((1000+kv_) || '',2,3) || pna_ ;
       --znap_:='���� �i����� ���������� �������' ;
       --INSERT INTO rnbu_trace         -- ���� �i����� ���������� �������
       --                 (nls, kv, odate, kodp, znap, acc) VALUES
       --                 (nls_, kv_, data_, kodp_, znap_, acc_);

       --kodp_:='05' || kod_ || substr((1000+kv_) || '',2,3) || pna_ ;
       --znap_:='����� �i����� ���������� �������' ;
       --INSERT INTO rnbu_trace         -- ����� �i����� ���������� �������
       --                 (nls, kv, odate, kodp, znap, acc) VALUES
       --                 (nls_, kv_, data_, kodp_, znap_, acc_);

       kodp_:='07' || kod_ || substr((1000+kv_) || '',2,3) || pna_ ;
       znap_:=to_char(ABS(GL.P_ICURVAL(kv_, Oste_, Dat_)));
       INSERT INTO rnbu_trace         -- ���� ��������������� �����
                        (nls, kv, odate, kodp, znap, acc) VALUES
                        (nls_, kv_, data_, kodp_, znap_, acc_);

       --kodp_:='08' || kod_ || substr((1000+kv_) || '',2,3) || pna_ ;
       --znap_:='���� ���������� �������' ;
       --INSERT INTO rnbu_trace         -- ���� ���������� ������� �� ��������� 
       --                 (nls, kv, odate, kodp, znap, acc) VALUES
       --                 (nls_, kv_, data_, kodp_, znap_, acc_);

       --kodp_:='09' || kod_ || substr((1000+kv_) || '',2,3) || pna_ ;
       --znap_:='����i� ���������ii �� ���� ����������� �����' ;
       --INSERT INTO rnbu_trace         -- ����i� ���������ii
       --                 (nls, kv, odate, kodp, znap, acc) VALUES
       --                 (nls_, kv_, data_, kodp_, znap_, acc_);

       kodp_:='10' || kod_ || LPAD(to_char(kv_),3,'0') || pna_ ;
       --znap_:='���� � ����������� ���������ii' ;
       znap_ := ABS(GL.P_ICURVAL(kv_, Oste_, Dat_))*sum_p09_/100;
       if Dat_ <= to_date('29122012','ddmmyyyy') and mfo_ = 300465 then
          znap_ := to_char(ABS(GL.P_ICURVAL(kv_, Oste_, Dat_)));
       end if;
       INSERT INTO rnbu_trace         -- ���� � ����������� ���������ii
                        (nls, kv, odate, kodp, znap, acc) VALUES
                        (nls_, kv_, data_, kodp_, znap_, acc_); 

       znap_:=trim(to_char(acrn.FPROC(acc_, Dat_),'9990D0000'));
       IF Kv_ =980 THEN
          kodp_:='11' || kod_ || LPAD(to_char(kv_),3,'0') || pna_ ;
          INSERT INTO rnbu_trace         -- %% ������ � ���.�����i
                           (nls, kv, odate, kodp, znap, acc) VALUES
                           (nls_, kv_, data_, kodp_, znap_, acc_);
       ELSE
          kodp_:='12' || kod_ || LPAD(to_char(kv_),3,'0') || pna_ ;
          INSERT INTO rnbu_trace         -- %% ������ � i������i
                           (nls, kv, odate, kodp, znap, acc) VALUES
                           (nls_, kv_, data_, kodp_, znap_, acc_);
       END IF ;

       kodp_:='13' || kod_ || LPAD(to_char(kv_),3,'0') || pna_ ;
       znap_ := to_char(rez_);
       INSERT INTO rnbu_trace         -- ���������?��� ?��������
                        (nls, kv, odate, kodp, znap, acc) VALUES
                        (nls_, kv_, data_, kodp_, znap_, acc_); 

       if Dat_ >= dat_izm1 
       then
          kodp_:='16' || kod_ || LPAD(to_char(kv_),3,'0') || pna_ ;
          znap_ := 0;
          INSERT INTO rnbu_trace         -- ���� ����������� ���������
                           (nls, kv, odate, kodp, znap, acc) VALUES
                        (nls_, kv_, data_, kodp_, znap_, acc_); 
       end if;

       na_:= na_+1 ;
    END IF;
END LOOP;
CLOSE Saldo;
---------------------------------------------------
DELETE FROM tmp_nbu where kodf='79' AND datf=Dat_ ;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  nls_, kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap)
   VALUES
        ('79', Dat_, kodp_, TRIM(znap_));
END LOOP;
CLOSE BaseL;
----------------------------------------
END p_f79;
/
show err;

PROMPT *** Create  grants  P_F79 ***
grant EXECUTE                                                                on P_F79           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F79.sql =========*** End *** ===
PROMPT ===================================================================================== 
