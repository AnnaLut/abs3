

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FB6.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FB6 ***

  CREATE OR REPLACE PROCEDURE BARS.P_FB6 (Dat_ DATE )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	��������� ������������ ����� #B6 ��� ��
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 16.04.2010 (09.03.10,14.10.09,10.07.09,17.04.09,10.04.09,
%                           08.04.09,16.01.07)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
���������: Dat_ - �������� ����

16.04.2010 ��� mfou_=300465 �� ���.������  6204,6399,7701,7702,7720 ����
           �� �������������� ����� � ��-�� ����������� �� OB22
           ��� 7720 ���� OB22='01','02','09','10' ������� � ������� �����
           �� ������� ��� ������������ ���� "703"
09.03.2010 ��� �������(������) ������ �� ������������ ���� �������� ����.
           ����������.
14.10.2009 ��� ����� 163,169,387,393 � ������� to_date ������� ���������
           'ddmmyyyy'
10.07.2009 ����� ORDER BY ��� ����. RNBU_TRACE
17.04.2009 ��� �/� 6203 ����� ���������� ������� �� �������� ������ �����-
           ����� �� � �������� �������� (3007,3015)
10.04.2009 ��� �/� 7703 ����� ���������� �� ��������� R013 ��� ��� ��������
           ���� ��� � ��� ��������. ���� �������� ����������, �� ���������-
           ���� R013='1' (��� 708) ��� R013='9' �� ��� 704.
16.01.2007 ��� �/� 7900 ����� ���������� �� ��������� R013 ��� ��� ��������
           ���� ��� � ��� ��������. ���� �������� ����������, �� ���������-
           ���� R013='1' (��� 706).
17.10.2006 ��� �/� 7703 ����� ���������� �� ��������� R013 ��� ��� ��������
           ���� ��� � ��� ��������. ���� �������� ����������, �� ���������-
           ���� R013='1' (��� 715).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='B6';
acc_     Number;
acc1_    Number;
dk_      Varchar2(1);
nbs_     Varchar2(4);
nls_     Varchar2(15);
r012_    Varchar2(1);
r013_    Varchar2(1);
kod_11_  Varchar2(2);
dd_      Varchar2(2);
Dat1_    Date;
Dat2_    Date;
Dat3_    Date;
Dat4_    Date;
data_    Date;
kv_      SMALLINT;
Ostn_    DECIMAL(24);
Ostq_    DECIMAL(24);
Dos96_   DECIMAL(24);
Kos96_   DECIMAL(24);
Dosq96_  DECIMAL(24);
Kosq96_  DECIMAL(24);
Doszg_   DECIMAL(24);
Koszg_   DECIMAL(24);
Dos96zg_ DECIMAL(24);
Kos96zg_ DECIMAL(24);
Dos99zg_ DECIMAL(24);
Kos99zg_ DECIMAL(24);
sn_      DECIMAL(24);
se_      DECIMAL(24);
se_6203  DECIMAL(24);
dos_     NUMBER;
kos_     NUMBER;
kodp_    Varchar2(6);
kodp1_   Varchar2(6);
znap_    Varchar2(30);
ddd_     Varchar(3);
flag_    number;
userid_  Number;
sql_acc_ varchar2(2000):='';
sql_doda_ varchar2(200):='';
ff_      number;
ret_	 number;
ob22_    Varchar2(2);
mfo_      NUMBER;
mfou_     NUMBER;

--- ������� ������+�������� �������������� �������+
--- ������� ����������(6,7 ����� �� 5040(5041))+����.������� ����������
CURSOR SALDOOG IS
   SELECT s.acc, s.nls, s.kv, s.fdat, s.nbs, s.ost, s.ostq,
          s.dos96, s.dosq96, s.kos96, s.kosq96,
          s.doszg, s.koszg, s.dos96zg, s.kos96zg, s.dos99zg, s.kos99zg
   FROM  otcn_saldo s;

CURSOR BaseL IS
   SELECT kodp, SUM(znap)
   FROM rnbu_trace
   WHERE userid=userid_
   GROUP BY kodp;
--   ORDER BY kodp;

BEGIN
-------------------------------------------------------------------
SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
--DELETE FROM RNBU_TRACE WHERE userid = userid_;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
-- ���� ���
mfo_ := F_Ourmfo ();

-- ��� "��������"
BEGIN
   SELECT NVL(trim(mfou), mfo_)
      INTO mfou_
   FROM BANKS
   WHERE mfo = mfo_;
EXCEPTION WHEN NO_DATA_FOUND THEN
   mfou_ := mfo_;
END;

--Dat1_:= TRUNC(Dat_ - TO_NUMBER(TO_CHAR(Dat_,'DD')));
--Dat2_:= TRUNC(Dat_ + 28);

IF to_char(Dat_,'MM') in ('01','03','05','07','08','10','12') THEN
   dd_:='31';
ELSIF to_char(Dat_,'MM') = '02' and
      mod(to_number(to_char(Dat_,'YYYY')),4) = 0  then
   dd_ := '29';
ELSIF to_char(Dat_,'MM') = '02' and
      mod(to_number(to_char(Dat_,'YYYY')),4) != 0 then
   dd_ := '28';
ELSE
   dd_:='30';
END IF;

data_:=to_date(dd_ || to_char(Dat_,'MM') ||
               to_char(to_number(to_char(Dat_,'YYYY'))-1),'DDMMYYYY');

SELECT max(Fdat) INTO Dat3_ FROM FDAT WHERE fdat<=data_;

Dat4_:=TRUNC(Dat3_ + 28);

sql_acc_ := 'select distinct r020 from kl_f3_29 where kf=''B6''';
ret_ := f_pop_otcn(Dat_, 2, sql_acc_);
-------------------------------------------------------------------
--- ������� ��������� ����
OPEN SALDOOG;
LOOP
   FETCH SALDOOG INTO acc_, nls_, kv_, data_, nbs_, Ostn_, Ostq_,
                      Dos96_, Dosq96_, Kos96_, Kosq96_,
                      Doszg_, Koszg_, Dos96zg_, Kos96zg_, Dos99zg_, Kos99zg_ ;
   EXIT WHEN SALDOOG%NOTFOUND;

   IF kv_ <> 980 THEN
      se_:=Ostq_-Dosq96_+Kosq96_;
   ELSE
      se_:=Ostn_-Dos96_+Kos96_;
   END IF;

   ---��� ���������� ������ 6 � 7 ������� �������� �������� ����������
   if to_char(Dat_,'MM')='12' and substr(nbs_,1,1) in ('6','7') then
      se_:=se_+Doszg_-Koszg_; -- ������� ���������� ��� "ZG%"
--      se_:=se_+Dos96zg_-Kos96zg_; -- ���.����. ������� ���������� ��� "ZG%"
--      se_:=se_+Dos99zg_-Kos99zg_; -- ���.����. ������� ���������� ��� "ZG%"
   end if;

   ---��� ���������� ������ 5040,5041 �������� �������� ����������
   if to_char(Dat_,'MM')='12' and nbs_ in ('5040','5041') then
--      se_:=se_+Doszg_-Koszg_; -- ������� ���������� ��� "ZG%"
      se_:=se_-Dos96zg_+Kos96zg_; -- ���.����. ������� ���������� ��� "ZG%"
      se_:=se_-Dos99zg_+Kos99zg_; -- ���.����. ������� ���������� ��� "ZG%"
   end if;

   flag_ := f_is_est(nls_, kv_);

   IF se_ <> 0  THEN
      dk_:=IIF_N(se_,0,'1','2','2');

      BEGIN
         SELECT NVL(ddd,'000')
            INTO ddd_
         FROM kl_f3_29
         WHERE kf='B6'
           and r020=nbs_
           and r012=dk_;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         BEGIN
            SELECT NVL(ddd,'000')
               INTO ddd_
            FROM kl_f3_29
            WHERE kf='B6'
              and r020=nbs_;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            ddd_:='000';
         END;
      END;

-- �������� � 31.03.2009
      IF nbs_='6203' THEN
         for k in (select fdat, nlsd, nlsk, s*100 S
                   from provodki
                   where fdat >= to_date('01'||to_char(Dat_,'MMYYYY'),'ddmmyyyy')
                     and fdat <= Dat_
                     and nlsd like '6203%'
                   UNION
                   select fdat, nlsd, nlsk, s*100
                   from provodki
                   where fdat >= to_date('01'||to_char(Dat_,'MMYYYY'),'ddmmyyyy')
                     and fdat <= Dat_
                     and nlsk like '6203%' )
         loop
           if k.nlsd like '6203%' and substr(k.nlsk,1,4) in ('3007','3015') then
              dos_ := dos_+k.s;
           end if;
           if k.nlsk like '6203%' and substr(k.nlsd,1,4) in ('3007','3015') then
              kos_ := kos_+k.s;
           end if;

         end loop;
         if dos_+kos_ <> 0 then
            se_6203 := dos_ - kos_;
            if se_6203 <> 0 then
               dk_:=IIF_N(se_6203,0,'1','2','2');
               kodp_:= dk_ || RTRIM(ddd_) || '10' ;
               znap_:= TO_CHAR(ABS(se_));

               INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                       (nls_, kv_, data_, kodp_, znap_);

               se_ := se_ - se_6203;
            end if;
         end if;
      END IF;

-- �������� � 31.03.2009
      IF mfou_ != 300465 and nbs_ = '6204' THEN
         BEGIN
            SELECT NVL(r013,'0') INTO r013_ FROM specparam
            WHERE acc=acc_;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            r013_:='0';
         END ;
         IF r013_='2' THEN
            ddd_:='614';
         END IF;
      END IF;

      if mfou_ = 300465 then
         IF nbs_ in ('6204','6399','7701','7702','7720') THEN
            BEGIN
               SELECT NVL(ob22,'00')
                  INTO ob22_
               FROM specparam_int
               WHERE acc=acc_;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               ob22_:='00';
            END ;
            IF nbs_ = '6204' and ob22_ in ('01','15','16') THEN
               ddd_:='614';
            END IF;
            IF nbs_ = '6399' and ob22_ in ('10','11','12','16') THEN
               ddd_:='602';
            END IF;
            IF nbs_ = '7701' and ob22_ in ('18','20','21','22') THEN
               ddd_:='707';
            END IF;
            IF nbs_ = '7702' and ob22_ in ('32','33','34','35','36','37','41',
                                           '42','43') THEN
               ddd_:='707';
            END IF;
            -- ��� 7720 ���� OB22='01','02','09','10' ������� ����� �� �������
            IF nbs_ = '7720' and ob22_ not in ('23','24','25','26') THEN
               ddd_:='708';
            END IF;
         END IF;
      end if;

-- �������� � 01.01.2006
      IF nbs_ in ('6393','6499') THEN
         BEGIN
            SELECT NVL(r013,'0') INTO r013_ FROM specparam
            WHERE acc=acc_;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            r013_:='0';
         END ;
         IF nbs_ in ('6393','6499') and r013_='1' THEN
            ddd_:='610';
         END IF;
      END IF;

-- �������� � 31.03.2006
      IF nbs_='6300' THEN
         BEGIN
            SELECT NVL(r013,'0') INTO r013_ FROM specparam
            WHERE acc=acc_;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            r013_:='0';
         END ;
         IF nbs_='6300' and r013_='7' THEN
            ddd_:='611';
         END IF;
      END IF;

-- �������� � 31.03.2006
-- ������� ��� ������������ � 610 �� 615 � 31.03.2009
      IF nbs_='7499' THEN
         BEGIN
            SELECT NVL(r013,'0') INTO r013_ FROM specparam
            WHERE acc=acc_;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            r013_:='0';
         END ;
         IF nbs_='7499' and r013_='1' THEN
            ddd_:='615';  --'610';
         END IF;
--         IF nbs_='7499' and r013_='9' THEN
--            ddd_:='713';
--         END IF;
      END IF;

-- �������� � 31.03.2006
-- ���������� � 708 � ���� R013='9' �� � 704 31.03.2009
      IF nbs_='7703' THEN
         BEGIN
            SELECT NVL(r013,'1') INTO r013_ FROM specparam
            WHERE acc=acc_;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            r013_:='1';
         END ;
         IF nbs_='7703' and r013_='9' THEN
            ddd_:='704';
         END IF;
--         IF nbs_='7703' and r013_='1' THEN
--            ddd_:='715';
--         END IF;
      END IF;

-- �������� � 31.03.2006
      IF nbs_='7900' THEN
         BEGIN
            SELECT NVL(r013,'0') INTO r013_ FROM specparam
            WHERE acc=acc_;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            r013_:='0';
         END ;
         IF nbs_='7900' and r013_='5' THEN
            ddd_:='710';
         END IF;
      END IF;

-- ����� 13.10.2005
--      IF nbs_='7900' THEN  --nbs_='6300' OR nbs_='7900' THEN
--         BEGIN
--            SELECT NVL(r013,'1') INTO r013_ FROM specparam
--            WHERE acc=acc_;
--         EXCEPTION WHEN NO_DATA_FOUND THEN
--            r013_:='1';
--         END ;
--      IF nbs_='6300' and r013_ in ('0','1','2','3') THEN
--         ddd_:='606';
--      END IF;
--         IF nbs_='7900' and r013_ in ('3','4') THEN
--           ddd_:='710';
--         END IF;
--      END IF;

      if se_ <> 0 then
         dk_:=IIF_N(se_,0,'1','2','2');
         kodp_:= dk_ || RTRIM(ddd_) || '10' ;
         znap_:= TO_CHAR(ABS(se_));

         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                               (nls_, kv_, data_, kodp_, znap_);
      end if;

   END IF;
END LOOP;
CLOSE SALDOOG;
---------------------------------------------------------------------------
if to_number(to_char(Dat3_,'YYYY'))=to_number(to_char(Dat_,'YYYY'))-1 then

--- ���������� ���
---���������� OTCN_SALDO
ret_ := f_pop_otcn(Dat3_, 2, sql_acc_);

--DELETE FROM kor_prov ;
--EXECUTE IMMEDIATE 'TRUNCATE TABLE kor_prov';
--INSERT INTO KOR_PROV (REF,  DK,  ACC , S,  FDAT , VDAT, SOS,  VOB)
--SELECT o.ref, o.dk, o.acc, o.s, o.fdat, p.vdat, o.sos, p.vob
--FROM opldok o, ref_kor p     --- oper p
--WHERE ((o.fdat>Dat3_    AND
--      o.fdat<=Dat4_    AND
--      p.vob=96)        OR
--      (o.fdat>Dat3_    AND
--      o.fdat<=Dat_     AND
--      p.vob=99))        AND
--      o.ref=p.ref      AND
--      o.sos=5 ;

--- ������� ������������ �������� ��� ����������� ����
OPEN SALDOOG;
LOOP
   FETCH SALDOOG INTO acc_, nls_, kv_, data_, nbs_, Ostn_, Ostq_,
                      Dos96_, Dosq96_, Kos96_, Kosq96_,
                      Doszg_, Koszg_, Dos96zg_, Kos96zg_, Dos99zg_, Kos99zg_ ;
   EXIT WHEN SALDOOG%NOTFOUND;

   IF kv_ <> 980 THEN
      se_:=Ostq_-Dosq96_+Kosq96_;
   ELSE
      se_:=Ostn_-Dos96_+Kos96_;
   END IF;

   ---��� ���������� ������ 6 � 7 ������� �������� �������� ����������
   if to_char(Dat3_,'MM')='12' and substr(nbs_,1,1) in ('6','7') then
      se_:=se_+Doszg_-Koszg_; -- ������� ���������� ��� "ZG%"
--      se_:=se_+Dos96zg_-Kos96zg_; -- ���.����. ������� ���������� ��� "ZG%"
--      se_:=se_+Dos99zg_-Kos99zg_; -- ���.����. ������� ���������� ��� "ZG%"
   end if;

   ---��� ���������� ������ 5040,5041 �������� �������� ����������
   if to_char(Dat3_,'MM')='12' and nbs_ in ('5040','5041') then
--      se_:=se_+Doszg_-Koszg_; -- ������� ���������� ��� "ZG%"
      se_:=se_-Dos96zg_+Kos96zg_; -- ���.����. ������� ���������� ��� "ZG%"
      se_:=se_-Dos99zg_+Kos99zg_; -- ���.����. ������� ���������� ��� "ZG%"
   end if;

   flag_ := f_is_est(nls_, kv_);

   IF se_ <> 0  THEN
      dk_:=IIF_N(se_,0,'1','2','2');

      BEGIN
         SELECT NVL(ddd,'000')
            INTO ddd_
         FROM kl_f3_29
         WHERE kf='B6'
           and r020=nbs_
           and r012=dk_;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         BEGIN
            SELECT NVL(ddd,'000')
               INTO ddd_
            FROM kl_f3_29
            WHERE kf='B6'
              and r020=nbs_;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            ddd_:='000';
         END;
      END;

-- �������� � 31.03.2009
      IF nbs_='6203' THEN
         for k in (select fdat, nlsd, nlsk, s*100 S
                   from provodki
                   where fdat >= to_date('01'||to_char(Dat_,'MMYYYY'),'ddmmyyyy')
                     and fdat <= Dat_
                     and nlsd like '6203%'
                   UNION
                   select fdat, nlsd, nlsk, s*100
                   from provodki
                   where fdat >= to_date('01'||to_char(Dat_,'MMYYYY'),'ddmmyyyy')
                     and fdat <= Dat_
                     and nlsk like '6203%' )
         loop
           if k.nlsd like '6203%' and substr(k.nlsk,1,4) in ('3007','3015') then
              dos_ := dos_+k.s;
           end if;
           if k.nlsk like '6203%' and substr(k.nlsd,1,4) in ('3007','3015') then
              kos_ := kos_+k.s;
           end if;

         end loop;
         if dos_+kos_ <> 0 then
            se_6203 := dos_ - kos_;
            if se_6203 <> 0 then
               dk_:=IIF_N(se_6203,0,'1','2','2');
               kodp_:= dk_ || RTRIM(ddd_) || '20' ;
               znap_:= TO_CHAR(ABS(se_));

               INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                       (nls_, kv_, data_, kodp_, znap_);

               se_ := se_ - se_6203;
            end if;
         end if;
      END IF;

-- �������� � 31.03.2009
      IF mfou_ != 300465 and nbs_ = '6204' THEN
         BEGIN
            SELECT NVL(r013,'0') INTO r013_ FROM specparam
            WHERE acc=acc_;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            r013_:='0';
         END ;
         IF r013_='2' THEN
            ddd_:='614';
         END IF;
      END IF;

      if mfou_ = 300465 then
         IF nbs_ in ('6204','6399','7701','7702','7720') THEN
            BEGIN
               SELECT NVL(ob22,'00')
                  INTO ob22_
               FROM specparam_int
               WHERE acc=acc_;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               ob22_:='00';
            END ;
            IF nbs_ = '6204' and ob22_ in ('01','15','16') THEN
               ddd_:='614';
            END IF;
            IF nbs_ = '6399' and ob22_ in ('10','11','12','16') THEN
               ddd_:='602';
            END IF;
            IF nbs_ = '7701' and ob22_ in ('18','20','21','22') THEN
               ddd_:='707';
            END IF;
            IF nbs_ = '7702' and ob22_ in ('32','33','34','35','36','37','41',
                                           '42','43') THEN
               ddd_:='707';
            END IF;
            -- ��� 7720 ���� OB22='01','02','09','10' ������� ����� �� �������
            IF nbs_ = '7720' and ob22_ not in ('23','24','25','26') THEN
               ddd_:='708';
            END IF;
         END IF;
      end if;

-- �������� � 01.01.2006
      IF nbs_ in ('6393','6499') THEN
         BEGIN
            SELECT NVL(r013,'0') INTO r013_ FROM specparam
            WHERE acc=acc_;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            r013_:='0';
         END ;
         IF nbs_ in ('6393','6499') and r013_='1' THEN
            ddd_:='610';
         END IF;
      END IF;

-- ������� ��� ������������ � 610 �� 615 � 31.03.2009
      IF nbs_='7499' THEN
         BEGIN
            SELECT NVL(r013,'0') INTO r013_ FROM specparam
           WHERE acc=acc_;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            r013_:='0';
         END ;
         IF nbs_='7499' and r013_='1' THEN
            ddd_:='615';  --'610';
         END IF;
--         IF nbs_='7499' and r013_='9' THEN
--            ddd_:='713';
--         END IF;
      END IF;

-- �������� � 31.03.2006
-- ���������� � 708 � ���� R013='9' �� � 704 31.03.2009
      IF nbs_='7703' THEN
         BEGIN
            SELECT NVL(r013,'1') INTO r013_ FROM specparam
            WHERE acc=acc_;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            r013_:='1';
         END ;
         IF nbs_='7703' and r013_='9' THEN
            ddd_:='704';
         END IF;
--         IF nbs_='7703' and r013_='1' THEN
--            ddd_:='715';
--         END IF;
      END IF;

-- �������� � 31.03.2006
      IF nbs_='7900' THEN
         BEGIN
            SELECT NVL(r013,'0') INTO r013_ FROM specparam
            WHERE acc=acc_;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            r013_:='0';
         END ;
         IF nbs_='7900' and r013_='5' THEN
            ddd_:='710';
         END IF;
      END IF;

-- ����� 13.10.2005
--      IF nbs_='7900' THEN  --nbs_='6300' OR nbs_='7900' THEN
--         BEGIN
--            SELECT NVL(r013,'1') INTO r013_ FROM specparam
--            WHERE acc=acc_;
--         EXCEPTION WHEN NO_DATA_FOUND THEN
--            r013_:='1';
--         END ;
--      IF nbs_='6300' and r013_ in ('0','1','2','3') THEN
--         ddd_:='606';
--      END IF;
--         IF nbs_='7900' and r013_ in ('3','4') THEN
--            ddd_:='710';
--         END IF;
--      END IF;

      if se_ <> 0 then
         dk_:=IIF_N(se_,0,'1','2','2');

         kodp_:= dk_ || RTRIM(ddd_) || '20' ;
         znap_:= TO_CHAR(ABS(se_));

         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                (nls_, kv_, data_, kodp_, znap_);
      end if;
   END IF;
END LOOP;
CLOSE SALDOOG;
end if;

-----------------------------------------------------------------------------
DELETE FROM tmp_nbu where kodf=kodf_ and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap)
   VALUES
        (kodf_, Dat_, kodp_, znap_);
END LOOP;
CLOSE BaseL;
----------------------------------------
INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap)
   VALUES
        (kodf_, Dat_, '152119', '0');
INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap)
   VALUES
        (kodf_, Dat_, '252119', '0');
--INSERT INTO tmp_nbu
--        (kodf, datf, kodp, znap)
--   VALUES
--        (kodf_, Dat_, '252219', '0');
--INSERT INTO tmp_nbu
--        (kodf, datf, kodp, znap)
--   VALUES
--        (kodf_, Dat_, '252229', '0');
INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap)
   VALUES
        (kodf_, Dat_, '252319', '0');
INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap)
   VALUES
        (kodf_, Dat_, '252419', '0');

END p_fB6;
/
show err;

PROMPT *** Create  grants  P_FB6 ***
grant EXECUTE                                                                on P_FB6           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FB6           to RPBN002;
grant EXECUTE                                                                on P_FB6           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FB6.sql =========*** End *** ===
PROMPT ===================================================================================== 
