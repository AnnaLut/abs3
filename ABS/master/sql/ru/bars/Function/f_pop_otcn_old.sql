
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_pop_otcn_old.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_POP_OTCN_OLD (Dat_ DATE, type_ NUMBER,
                                       sql_acc_ VARCHAR2,
                                       datp_ IN DATE DEFAULT NULL )
RETURN NUMBER IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    ��������� ������������ ����� #02 ��� ��
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 05.08.2011 (29.02.2008,18.01.2008,08.02.2007,16.02.2006)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
���������:
  Dat_ - �������� ����
  type_ - ��� ���������� (1 - ������ ������� �� ����
                          2 - ������� + �������������� ��������
                          3 - ������� + �������������� �������
                              (�� �������� � ������. �����, � �������)
                               + �������� �������
                          4 - ������������ ������� ������ (�4, 81 � �.�.)
                          5 - ������������ ��������� (��� ��� 3, �� ��������
                              ��������� ���������)
  sql_acc_ - ������ �������������� ���-�� ������ ����������� � �������
  datp_ - ���� ������ ������� (��� type_ = 5)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
05.08.2011 - �����������
             ��� ������� �� Saldoa ����� ������� "max(fdat) < Dat_"
             �������� ������� "and c.acc=s.acc"
             ������ ������� Fdos, Fkos ���������� ���������� ��������
             �� �������� SALDOA, SALDOB
29.02.2008 - ��� ���������� Dat3_ ����� ��������� ������� ������ ������
             ������� � ��� �������������� �������� ������ �������� �
             �������������� ���������� (vob=196  ������ vob=96 �����
             vob in (96, 196))
18.01.2008 - ������� ������� ������ SUBSTR(nlsa,1,1) in ('6','7') �
             SUBSTR(nlsb,1,4) in ('5040','5041') ������� �� LIKE
08.02.2007 - ��������� ��� ���������� Dat1_ Dat3_ (������ �� ���� 3112)
15.02.2006 - ���������� ������� OTCN_SALDO ������ VOST � VOSTQ
12.12.2005 - ��� ������ ���.���������� ��������� ����� 3800_000000000
             (KV<>980) ������ ����� ��������  (s0000,s0009,s3800,s3801)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
dat1_    DATE; -- ������ ��������� ������� (��� type_ >= 2)
dat2_    DATE; -- ���� ��������� ������� ����. �������� ��� ��������� �������
dat3_    DATE; -- ���� ��������� ������� ����. �������� ��� ����������� ��������� �������
datn_    DATE; -- ����, ����. �� ��������
datv_    DATE; -- ���� ��������� ������. �������
dat99_  DATE; -- ���� ��������� ������� ����. ��������

god_    Varchar2(4);
sql_doda_ VARCHAR2(2000):='';
acc_     NUMBER;
Dos96_   DECIMAL(24);
Dosq96_  DECIMAL(24);
Kos96_   DECIMAL(24);
Kosq96_  DECIMAL(24);
tips_    VARCHAR2(3);
type_kor_ NUMBER;
---------------------------------------------------------------------------
CURSOR KOR_PROV96 IS
   -- �������� �������������� �������� ����������� � ����������� ������,
   SELECT '1', s.acc,
          NVL(SUM(DECODE(a.DK, 0, a.s, 0)),0),
          NVL(SUM(DECODE(s.kv,980,0,DECODE(a.DK, 0, Gl.P_Icurval(s.kv, a.s, a.vDat),0))),0),
          NVL(SUM(DECODE(a.DK, 1, a.s, 0)),0),
          NVL(SUM(DECODE(s.kv,980,0,DECODE(a.DK, 1, Gl.P_Icurval(s.kv, a.s, a.vDat),0))),0)
   FROM  KOR_PROV a, OTCN_ACC s
   WHERE type_ > 2
--     AND a.VOB=96  -- �� ���������� �������� ���������� �������������� (vob=196)
     AND a.VOB in (96, 196)
     AND a.FDAT BETWEEN Dat1_ AND Dat3_
     AND a.acc=s.acc
   GROUP BY '1', s.acc
UNION ALL
   -- �������� �������������� �������� ��������� ������
   SELECT '2', s.acc,
          NVL(SUM(DECODE(a.DK, 0, a.s, 0)),0),
          NVL(SUM(DECODE(s.kv,980,0,DECODE(a.DK, 0, Gl.P_Icurval(s.kv, a.s, a.vDat),0))),0),
          NVL(SUM(DECODE(a.DK, 1, a.s, 0)),0),
          NVL(SUM(DECODE(s.kv,980,0,DECODE(a.DK, 1, Gl.P_Icurval(s.kv, a.s, a.vDat),0))),0)
   FROM  KOR_PROV a, OTCN_ACC s
   WHERE type_ > 1
     AND a.VOB=96
     AND a.FDAT BETWEEN Datn_ AND Dat2_
     AND a.acc=s.acc
   GROUP BY '2', s.acc
UNION ALL
   -- � ������� �������������� ��������
   SELECT '3', s.acc,
          NVL(SUM(DECODE(a.DK, 0, a.s, 0)),0),
          NVL(SUM(DECODE(s.kv,980,0,DECODE(a.DK, 0, Gl.P_Icurval(s.kv, a.s, a.vDat),0))),0),
          NVL(SUM(DECODE(a.DK, 1, a.s, 0)),0),
          NVL(SUM(DECODE(s.kv,980,0,DECODE(a.DK, 1, Gl.P_Icurval(s.kv, a.s, a.vDat),0))),0)
   FROM  KOR_PROV a, OTCN_ACC s
   WHERE type_ > 1
     AND a.VOB=99
     AND a.FDAT BETWEEN Dat1_ AND dat99_
     AND a.acc=s.acc
   GROUP BY '3', s.acc
UNION ALL
   -- ������� �� ���������� �� �_���� ����
   SELECT '4', s.acc,
          NVL(SUM(DECODE(a.DK, 0, a.s, 0)),0),
          NVL(SUM(DECODE(s.kv,980,0,DECODE(a.DK, 0, Gl.P_Icurval(s.kv, a.s, a.vDat),0))),0),
          NVL(SUM(DECODE(a.DK, 1, a.s, 0)),0),
          NVL(SUM(DECODE(s.kv,980,0,DECODE(a.DK, 1, Gl.P_Icurval(s.kv, a.s, a.vDat),0))),0)
   FROM  KOR_PROV a, OTCN_ACC s
   WHERE type_ > 1
     AND a.VOB>100
     AND a.VOB NOT IN (196, 199)
     AND a.FDAT BETWEEN Dat1_ AND Dat_
     AND a.acc=s.acc
   GROUP BY '4', s.acc
UNION ALL
   -- ������� �� ���������� �_������ ���������� ��������
   SELECT '5', s.acc,
          NVL(SUM(DECODE(a.DK, 0, a.s, 0)),0),
          NVL(SUM(DECODE(s.kv,980,0,DECODE(a.DK, 0, Gl.P_Icurval(s.kv, a.s, a.vDat),0))),0),
          NVL(SUM(DECODE(a.DK, 1, a.s, 0)),0),
          NVL(SUM(DECODE(s.kv,980,0,DECODE(a.DK, 1, Gl.P_Icurval(s.kv, a.s, a.vDat),0))),0)
   FROM  KOR_PROV a, OTCN_ACC s
   WHERE type_ > 1
     AND a.VOB=196
     AND a.FDAT BETWEEN Datn_ AND Dat2_
     AND a.acc=s.acc
   GROUP BY '5', s.acc
UNION ALL
   -- ������� �� ���������� �_���� ���������� ��������
   SELECT '6', s.acc,
          NVL(SUM(DECODE(a.DK, 0, a.s, 0)),0),
          NVL(SUM(DECODE(s.kv,980,0,DECODE(a.DK, 0, Gl.P_Icurval(s.kv, a.s, a.vDat),0))),0),
          NVL(SUM(DECODE(a.DK, 1, a.s, 0)),0),
          NVL(SUM(DECODE(s.kv,980,0,DECODE(a.DK, 1, Gl.P_Icurval(s.kv, a.s, a.vDat),0))),0)
   FROM  KOR_PROV a, OTCN_ACC s
   WHERE type_ > 1
     AND a.VOB=199
     AND a.FDAT BETWEEN Dat1_ AND dat99_
     AND a.acc=s.acc
   GROUP BY '6', s.acc;
---------------------------------------------------------------------------
BEGIN
--- �������� ���������� �� ����. �� �������� ����
EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_ACC';
EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_SALDO';
---------------------------------------------------------------------------
IF datp_ IS NULL THEN -- ���� ������ �� ������, �� ��������� - �����
   -- ������� ������������ �_����
   Dat1_ := TRUNC(Dat_,'MM');

   -- �i���� ���i��� ���������� ��� �i������ ����i�
   Dat2_ := ADD_MONTHS(Dat1_ - 1, 2);

   -- �i���� ���i��� ���������� ��� ������������ ���i���
   Dat3_ := dat_;

   -- ��� ������ �������
   god_ := to_char(Dat2_,'YYYY');
ELSE
   -- ������� ��_����� ���_���
   Dat1_ := datp_;

   -- �i���� ���i��� ���������� ��� ���. ������_�
   Dat2_ := ADD_MONTHS(Dat_, 1);

   -- �i���� ���i��� ���������� ��� ��. ������_�
   Dat3_ := LAST_DAY(Dat1_);   --ADD_MONTHS(Dat1_, 1);

   -- ��� ������ �������
   god_ := to_char(Dat2_,'YYYY');
END IF;

-- ��� ������� �������������� ��������
IF type_ = 4 THEN
   dat99_ := Bankdate;
ELSE
   dat99_ := dat_;
END IF;

DatN_ := TRUNC(Dat_ + 1); -- ���� �������� �� ��_����

-- � ������ ���������� ��������
--Dat1_ := Calc_Pdat(Dat1_);

-- ��� ������, ������� ��������� ���������� ���� 31.12.2005
--IF Dat1_ = TO_DATE('31122006', 'ddmmyyyy') THEN
--    Dat1_ := TO_DATE('01012007', 'ddmmyyyy');
--END IF;
-- ��������� �� 08.02.2007
-- ��������������� 18.01.2008 ��� ��� ����� �� ��������� �������� �
-- �������� ��� ����������� ������ ����� �������� ���� (���� � �������)
--IF to_char(Dat1_,'DDMM') = '3112' THEN
--    Dat1_ := TO_DATE('0101' || god_, 'ddmmyyyy');
--END IF;

-- � ������ ���������� ��������
--Dat3_ := Calc_Pdat(Dat3_);

-- ��� ������, ������� ��������� ���������� ���� 31.12.2005
--IF Dat3_ = TO_DATE('31122006', 'ddmmyyyy') THEN
--    Dat3_ := TO_DATE('01012007', 'ddmmyyyy');
--END IF;
-- ��������� �� 08.02.2007
-- ��������������� 18.01.2008 ��� ��� ����� �� ��������� �������� �
-- �������� ��� ����������� ������ ����� �������� ���� (���� � �������)
--IF to_char(Dat3_,'DDMM') = '3112' THEN
--    Dat3_ := TO_DATE('0101' || god_, 'ddmmyyyy');
--END IF;

-- ����� ������ ������ ������
sql_doda_ := 'insert into OTCN_ACC (ACC, NLS, KV, NBS, RNK, DAOS, DAPP, ISP, NMS, LIM, PAP, TIP, VID, MDATE, DAZS, ACCC, TOBO) '||
             'select distinct a.acc, a.nls, a.kv, a.nbs, c.rnk, a.daos, a.dapp, a.isp, a.nms, a.lim, a.pap, a.tip, a.vid, a.mdate, a.dazs, a.accc, a.tobo '||
             'from (select * from accounts where nbs ';

IF Trim(sql_acc_) IS NULL THEN
   sql_doda_ := sql_doda_ || ' not like ''8%'' ';
ELSE
   sql_doda_ := sql_doda_ || ' in (' || sql_acc_ ||')';
END IF;

sql_doda_ := sql_doda_ || ') a, cust_acc c where a.acc=c.acc';

EXECUTE IMMEDIATE sql_doda_;

--- ���������� �������� ��������� �� ������
INSERT INTO OTCN_SALDO (ODATE, FDAT, ACC, NLS, KV, NBS, RNK, VOST, VOSTQ,
       OST, OSTQ, DOS, DOSQ, KOS, KOSQ, DOS96P, DOSQ96P, KOS96P, KOSQ96P, DOS96, DOSQ96, KOS96, KOSQ96,
       DOS99, DOSQ99, KOS99, KOSQ99, DOSZG, KOSZG, DOS96ZG, KOS96ZG, DOS99ZG, KOS99ZG)
SELECT Dat_, a.FDAT, s.acc, s.nls, s.kv, s.nbs, s.rnk, 0, 0,
       a.ostf-a.dos+a.kos,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
FROM SALDOA a, OTCN_ACC s
WHERE a.acc=s.acc
  AND (s.acc,a.fdat) in (SELECT c.acc, MAX(c.FDAT)
                           FROM SALDOA c
                          WHERE c.FDAT <= Dat_ and
                                c.acc = s.acc
                         GROUP BY c.acc);

--- ���������� �������� ������������ �� �������� ������
UPDATE OTCN_SALDO b
SET b.ostq = NVL((SELECT a.ostf-a.dos+a.kos
                    FROM SALDOB a
                    WHERE a.acc=b.acc AND
                          a.FDAT = (SELECT MAX(c.FDAT)
                                    FROM SALDOB c
                                    WHERE c.acc=a.acc AND
                                          c.FDAT <= Dat_)),0)
WHERE b.kv<>980 ;

--- ���������� �������� ������������ ������ ����������� ����������
INSERT INTO OTCN_SALDO (ODATE, FDAT, ACC, NLS, KV, NBS, RNK, VOST, VOSTQ,
                        OST, OSTQ, DOS, DOSQ, KOS, KOSQ, DOS96P, DOSQ96P,
                        KOS96P, KOSQ96P, DOS96, DOSQ96, KOS96, KOSQ96,
                        DOS99, DOSQ99, KOS99, KOSQ99, DOSZG, KOSZG,
                        DOS96ZG, KOS96ZG, DOS99ZG, KOS99ZG)
SELECT Dat_, a.FDAT, a.acc, a.nls, a.kv, a.nbs, a.rnk, 0, 0,
       0, a.ostf-a.dos+a.kos,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
FROM (SELECT AA.FDAT,s.acc,s.nls,s.kv,s.nbs,s.rnk,AA.ostf,AA.dos,AA.kos
      FROM SALDOB AA, OTCN_ACC s, TABVAL t
      WHERE t.kv<>980                     AND
            s.kv=t.kv                     AND
           (s.nls IN (t.s0000,t.s3800,t.s3801,t.s0009) OR
            s.nls LIKE '3800_000000000')  AND
            s.acc=AA.acc                  AND
            AA.acc NOT IN (SELECT b.acc FROM OTCN_SALDO b) AND
            (s.acc,AA.FDAT) = (SELECT c.acc,MAX(c.FDAT)
                               FROM SALDOB c
                               WHERE s.acc=c.acc AND
                                     c.FDAT <= Dat_
                               GROUP BY c.acc)) a;

IF type_ > 1 THEN
----------------------------------------------------------------------------
   IF TO_CHAR(Dat_,'MM')='12' THEN
      sql_doda_ := ' AND tt NOT LIKE ''ZG%'' AND '||
             'not (((nlsa LIKE ''6%'' OR nlsa LIKE ''7%'') '||
             'and (nlsb LIKE ''5040%'' OR nlsb LIKE ''5041%'')) or ' ||
             '((nlsa LIKE ''5040%'' OR nlsa LIKE ''5041%'') and '||
             '(nlsb LIKE ''6%'' OR nlsb LIKE ''7%'')))';
      type_kor_ := 1;
   ELSE
      sql_doda_ := '';
      type_kor_ := 0;
   END IF ;

-- ��� �i���� ���������� ������i� ����� ������i� �i������� ����i������ ����
-- (����� #81, #A4)
   IF type_ = 4 THEN
      P_Populate_Kor(Dat1_,Bankdate,sql_doda_,type_kor_);
   ELSE
      P_Populate_Kor(Dat1_,Dat2_,sql_doda_,type_kor_);
   END IF;

--- ���������� ������ �� ACCOUNTS ������������� � OTCN_SALDO (SALDOA,SALDOB)
INSERT INTO OTCN_SALDO (ODATE, FDAT, ACC, NLS, KV, NBS, RNK, VOST, VOSTQ,
                        OST, OSTQ, DOS, DOSQ, KOS, KOSQ,
                        DOS96P, DOSQ96P, KOS96P, KOSQ96P,
                        DOS96, DOSQ96, KOS96, KOSQ96,
                        DOS99, DOSQ99, KOS99, KOSQ99,
                        DOSZG, KOSZG, DOS96ZG, KOS96ZG,
                        DOS99ZG, KOS99ZG)
   SELECT Dat_,a.daos,a.acc,a.nls,a.kv,a.nbs, a.rnk, 0, 0,
          0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    FROM (SELECT o.daos, o.acc, o.nls, o.kv, o.nbs, o.rnk
          FROM OTCN_ACC o,
             ( SELECT DISTINCT acc
                           FROM KOR_PROV
                           WHERE acc IS NOT NULL
                                 MINUS
                                 SELECT acc
                                 FROM OTCN_SALDO) o2
          WHERE o.acc = o2.acc) a;

   IF type_ = 2 THEN
---��������� �������������� ��������
      OPEN KOR_PROV96;
         LOOP
            FETCH KOR_PROV96 INTO  tips_, acc_, Dos96_, Dosq96_, Kos96_, Kosq96_ ;
            EXIT WHEN KOR_PROV96%NOTFOUND;

            UPDATE OTCN_SALDO
               SET DOS96=DOS96+DECODE(TIPS_,'2',DOS96_,0),
                   DOSQ96=DOSQ96+DECODE(TIPS_,'2',DOSQ96_,0),
                   KOS96=KOS96+DECODE(TIPS_,'2',KOS96_,0),
                   KOSQ96=KOSQ96+DECODE(TIPS_,'2',KOSQ96_,0),
                   DOS99=DOS99+DECODE(TIPS_,'3',DOS96_,0),
                   DOSQ99=DOSQ99+DECODE(TIPS_,'3',DOSQ96_,0),
                   kos99=kos99+DECODE(tips_,'3',Kos96_,0),
                   kosq99=kosq99+DECODE(tips_,'3',Kosq96_,0),
                   doszg=doszg+DECODE(tips_,'4',Dos96_,0),     -- ������� �� ����������
                   koszg=koszg+DECODE(tips_,'4',Kos96_,0),
                   dos96zg=dos96zg+DECODE(tips_,'5',Dos96_,0),
                   kos96zg=kos96zg+DECODE(tips_,'5',Kos96_,0),
                   dos99zg=dos99zg+DECODE(tips_,'6',Dos96_,0),
                   kos99zg=kos99zg+DECODE(tips_,'6',Kos96_,0)
            WHERE acc=acc_ ;
         END LOOP;
      CLOSE KOR_PROV96;
   ELSE
---��������� �������������� ��������
      OPEN KOR_PROV96;
         LOOP
            FETCH KOR_PROV96 INTO  tips_, acc_, Dos96_, Dosq96_, Kos96_, Kosq96_ ;
            EXIT WHEN KOR_PROV96%NOTFOUND;

            UPDATE OTCN_SALDO
               SET dos96p=dos96p+DECODE(tips_,'1',Dos96_,0),
                   dosq96p=dosq96p+DECODE(tips_,'1',Dosq96_,0),
                   kos96p=kos96p+DECODE(tips_,'1',Kos96_,0),
                   kosq96p=kosq96p+DECODE(tips_,'1',Kosq96_,0),
                   dos96=dos96+DECODE(tips_,'2',Dos96_,0),
                   dosq96=dosq96+DECODE(tips_,'2',Dosq96_,0),
                   kos96=kos96+DECODE(tips_,'2',Kos96_,0),
                   kosq96=kosq96+DECODE(tips_,'2',Kosq96_,0),
                   dos99=dos99+DECODE(tips_,'3',Dos96_,0),
                   dosq99=dosq99+DECODE(tips_,'3',Dosq96_,0),
                   kos99=kos99+DECODE(tips_,'3',Kos96_,0),
                   kosq99=kosq99+DECODE(tips_,'3',Kosq96_,0),
                   doszg=doszg+DECODE(tips_,'4',Dos96_,0),     -- ������� �� ����������
                   koszg=koszg+DECODE(tips_,'4',Kos96_,0),
                   dos96zg=dos96zg+DECODE(tips_,'5',Dos96_,0),
                   kos96zg=kos96zg+DECODE(tips_,'5',Kos96_,0),
                   dos99zg=dos99zg+DECODE(tips_,'6',Dos96_,0),
                   kos99zg=kos99zg+DECODE(tips_,'6',Kos96_,0)
            WHERE acc=acc_ ;
         END LOOP;
      CLOSE KOR_PROV96;

      IF type_ = 5 THEN -- ��� ��������� �� ���_��
         -- �_���� ������������ ���_���
         SELECT MAX(FDAT)
          INTO datv_
         FROM FDAT
         WHERE FDAT < dat1_;

         --- ���������� �������� �� �����
        for k in (
            select acc,
                   sum(vost) vost, sum(vostq) vostq,
                   sum(dos) dos, sum(dosq) dosq,
                   sum(kos) kos, sum(kosq) kosq
            from (
                select s.acc,
                       0 vost, 0 vostq,
                       sum(s.dos) dos, 0 dosq,
                       sum(s.kos) kos, 0 kosq
                from saldoa s, otcn_acc a
                where s.fdat between dat1_ and dat_
                    and s.acc=a.acc
                group by s.acc
                union all
                select s.acc,
                       0 vost, 0 vostq,
                       0 dos, sum(s.dos) dosq,
                       0 kos, sum(s.kos) kosq
                from saldob s, otcn_acc a
                where s.fdat between dat1_ and dat_
                    and s.acc=a.acc
                group by s.acc
                union all
                select s.acc,
                       ost vost, 0 vostq,
                       0 dos, 0 dosq,
                       0 kos, 0 kosq
                from sal s
                where s.fdat = datv_
                  and s.acc in (select acc from otcn_acc)
                union all
                select s.acc,
                       0 vost, ost vostq,
                       0 dos, 0 dosq,
                       0 kos, 0 kosq
                from salb s
                where s.fdat = datv_
                    and s.acc in (select acc from otcn_acc))
            group by acc
        ) --s

        loop
           update otcn_saldo set vost=k.vost, vostq=k.vostq,
                                 dos=k.dos, dosq=k.dosq,
                                 kos=k.kos, kosq=k.kosq
           where acc=k.acc;
        end loop;
      ELSE
         --- ���������� �������� �� �����
        for k in (
            select acc,
                   sum(dos) dos, sum(dosq) dosq,
                   sum(kos) kos, sum(kosq) kosq
            from (
                select s.acc,
                       sum(s.dos) dos, 0 dosq,
                       sum(s.kos) kos, 0 kosq
                from saldoa s, otcn_acc a
                where s.fdat between dat1_ and dat_
                  and s.acc=a.acc
                group by s.acc
                union all
                select s.acc,
                       0 dos, sum(s.dos) dosq,
                       0 kos, sum(s.kos) kosq
                from saldob s, otcn_acc a
                where s.fdat between dat1_ and dat_
                  and s.acc=a.acc
                group by s.acc)
            group by acc
            having sum(dos)+sum(dosq)+sum(kos)+sum(kosq)<>0
        ) --s

        loop
           update otcn_saldo set dos=k.dos, dosq=k.dosq,
                                 kos=k.kos, kosq=k.kosq
           where acc=k.acc;
        end loop;
      END IF;
   END IF;
END IF;

RETURN 0;
EXCEPTION
    WHEN OTHERS THEN
         RAISE_APPLICATION_ERROR(-20001, SQLERRM);
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_pop_otcn_old.sql =========*** End
 PROMPT ===================================================================================== 
 