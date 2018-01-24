CREATE OR REPLACE FUNCTION F_POP_OTCN_SNP
( Dat_     DATE
, type_    NUMBER
, sql_acc_ VARCHAR2
, datp_    DATE   default null
, tp_sql_  number default 0
, add_KP_  number default 0
) RETURN NUMBER
IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	������� ���������� ������ ��� ������������ ����������
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 24.01.2018 (14.12.2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
06/02/2015 - � ������� OTCN_SALDO �� ������������� ������� �� �������
             ����������.
21/01/2015 - ��� ���� 4 ��������� ����� ������������ � OTCN_SALDO � ���
             ������� ���� �������������� �������� ��� ������� ������� ��
             ���� �������������� ��������
05/11/2013 - ���������� �� ������������� ����
05.09.2013 - �� ���������� �������� ����� � OTCN_SALDO �.�. ��� ������ ��
             ACCM_AGG_MONBALS ���� �������� ��������� ���� ��� ������������
             � ��� �������� ������ �� �� ����������� ����������
01.02.2012 - ��������� ������� �� ���������� ������ ��� 12 ������
             (���� � ��� 01)
30.01.2012 - ��� ���������� 5040(5041) � ��������� ������������ ���.�����
             3902,3903. ������ ���.����� ��������� � ������� ����������
17.01.2012 - ������� ���������� �������� ���������� 6,7 ��. �� 5040(5041)
             � ������� �� ���������� �������������� 6,7 �� ������� ��
             5040(5041)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
���������:
 Dat_ - �������� ����
 type_- ��� ���������� (1 - ������ ������� �� ����
                        2 - ������� + �������������� ��������
                        3 - ������� + �������������� �������
                            (�� �������� � ������. �����, � �������)
                             + �������� �������
                        4 - ������������ ������� ������ (�4, 81 � �.�.)
                        5 - ������������ ��������� (��� ��� 3, �� ��������
                            ��������� ���������)
 sql_acc_ - ������ �������������� ���-�� ������ ����������� � �������
 datp_    - ���� ������ ������� (��� type_ = 5)
 tp_sql_  - ��� ������� � sql_acc_ (=0 - ����� �� NBS, = 1 - �� ACC)
 add_KP_  - ���������� ������ REF_KOR � KOR_PROV (0 - ���, 1 - ��)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
dat1_     DATE; -- ������ ��������� ������� (��� type_ >= 2)
dat2_     DATE; -- ���� ��������� ������� ����. �������� ��� ��������� �������
dat3_     DATE; -- ���� ��������� ������� ����. �������� ��� ����������� ��������� �������
dat1_kor_ DATE;
dat2_kor_ DATE;
datn_     DATE; -- ����, ����. �� ��������
dat99_    DATE; -- ���� ��������� ������� ����. ��������
god_      Varchar2(4);
sql_doda_ clob;
type_kor_ NUMBER;
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

   dat1_kor_ := Dat_last(ADD_MONTHS(Dat1_, -1), Dat1_ - 1);
   dat2_kor_ := Dat_last(Dat1_, Dat_+28);
ELSE
   -- ������� ��_����� ���_���
   Dat1_ := datp_;

   -- �i���� ���i��� ���������� ��� ���. ������_�
   Dat2_ := ADD_MONTHS(Dat_, 1);

   -- �i���� ���i��� ���������� ��� ��. ������_�
   Dat3_ := LAST_DAY(Dat1_);

   -- ��� ������ �������
   god_ := to_char(Dat2_,'YYYY');

   dat1_kor_ := Dat_last(ADD_MONTHS(Dat1_, -1), Dat1_ - 1);
   dat2_kor_ := Dat_last(Dat1_, Dat_);
END IF;

-- ��� ������� �������������� ��������
IF type_ = 4 THEN
   dat99_ := glb_bankdate();  --Bankdate;
ELSE
   dat99_ := dat_;
END IF;

DatN_ := TRUNC(Dat_ + 1); -- ���� �������� �� ��_����

-- ����� ������ ������ ������
if tp_sql_ = 0 then
    sql_doda_ := 'insert /*+APPEND PARALLEL(8) */  into OTCN_ACC (ACC, NLS, KV, NBS, OB22, RNK, DAOS, DAPP, ISP, NMS, LIM, PAP, TIP, VID, MDATE, DAZS, ACCC, TOBO, NLS_ALT, OB22_ALT, DAT_ALT) '||
                 'select a.acc, a.nls, a.kv, a.nbs, a.ob22, a.rnk, a.daos, a.dapp, a.isp, a.nms, a.lim, a.pap, a.tip, a.vid, a.mdate, a.dazs, a.accc, a.tobo, a.nlsalt, s.ob22_alt, a.dat_alt '||
                 'from (select * from accounts where nbs ';

    IF Trim(sql_acc_) IS NULL THEN
       sql_doda_ := sql_doda_ || ' not like ''8%'' ';
    ELSE
       sql_doda_ := sql_doda_ || ' in (' || sql_acc_ ||')';
    END IF;

    sql_doda_ := sql_doda_ || ') a, specparam s where a.acc = s.acc(+) ';
else
    sql_doda_ := 'insert /*+APPEND PARALLEL(8) */ into OTCN_ACC (ACC, NLS, KV, NBS, OB22, RNK, DAOS, DAPP, ISP, NMS, LIM, PAP, TIP, VID, MDATE, DAZS, ACCC, TOBO, NLS_ALT, OB22_ALT, DAT_ALT) '||
                 'select distinct a.acc, a.nls, a.kv, a.nbs, a.ob22, a.rnk, a.daos, a.dapp, a.isp, a.nms, a.lim, a.pap, a.tip, a.vid, a.mdate, a.dazs, a.accc, a.tobo, a.nlsalt, s.ob22_alt, a.dat_alt '||
                 'from (';

    IF Trim(sql_acc_) IS NULL THEN
       sql_doda_ := sql_doda_ || ' select * from accounts where nbs not like ''8%'' ';
    ELSE
       sql_doda_ := sql_doda_ || sql_acc_;
    END IF;

    sql_doda_ := sql_doda_ || ') a, specparam s where a.acc = s.acc(+) ';
end if;

EXECUTE IMMEDIATE sql_doda_;
commit;

if add_KP_ = 1 then
   IF TO_CHAR(Dat_,'MM') in ('12') THEN
      sql_doda_ := ' AND tt NOT LIKE ''ZG%'' AND '||
             'not (((nlsa LIKE ''6%'' OR nlsa LIKE ''7%'') '||
             'and (nlsb LIKE ''5040%'' OR nlsb LIKE ''5041%'')) or ' ||
             '((nlsa LIKE ''5040%'' OR nlsa LIKE ''5041%'') and '||
             '(nlsb LIKE ''6%'' OR nlsb LIKE ''7%'')) or ' ||
             '((nlsa LIKE ''3902%'' OR nlsa LIKE ''3903%'') '||
             'and (nlsb LIKE ''5040%'' OR nlsb LIKE ''5041%'')) or ' ||
             '((nlsa LIKE ''5040%'' OR nlsa LIKE ''5041%'') and '||
             '(nlsb LIKE ''3902%'' OR nlsb LIKE ''3903%'')))';
      type_kor_ := 1;
   ELSE
      sql_doda_ := '';
      type_kor_ := 0;
   END IF ;

-- ��� �i���� ���������� ������i� ����� ������i� �i������� ����i������ ����
-- (����� #81, #A4)
    IF type_ = 4 THEN
       P_Populate_Kor(Dat1_,glb_bankdate(),sql_doda_,type_kor_);
    ELSE
       P_Populate_Kor(dat1_kor_,dat2_kor_,sql_doda_,type_kor_);
    END IF;
    
  end if;

  if type_ = 1 then

    INSERT /*+APPEND PARALLEL(8) */
      INTO OTCN_SALDO (ODATE, FDAT, ACC, NLS, KV, NBS, OB22, RNK,
           VOST, VOSTQ,
           OST, OSTQ,
           DOS, DOSQ,
           KOS, KOSQ,
           DOS96P, DOSQ96P, KOS96P, KOSQ96P, DOS96, DOSQ96, KOS96, KOSQ96,
           DOS99, DOSQ99, KOS99, KOSQ99, DOSZG, KOSZG, DOS96ZG, KOS96ZG, DOS99ZG, KOS99ZG)
    select dat_, dat_, a.acc, a.NLS,  a.KV, a.NBS, a.OB22, a.RNK,
           b.ost - b.kos + b.dos, decode(a.kv, 980, 0, b.ostq  - b.kosq + b.dosq),
           b.ost, decode(a.kv, 980, 0, b.ostq),
           b.dos, decode(a.kv, 980, 0, b.dosq),
           b.Kos, decode(a.kv, 980, 0, b.Kosq),
           0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
      from SNAP_BALANCES b, OTCN_ACC a
     where b.FDAT = dat_
       and b.acc = a.acc
       and ( b.ostq <> 0 or b.ost <> 0 or
             b.kosq <> 0 or b.kos <> 0 or
             b.dosq <> 0 or b.dos <> 0
           );
elsif type_ in (2, 3, 5) then

    INSERT /*+APPEND */
    INTO OTCN_SALDO (ODATE, FDAT, ACC, NLS, KV, NBS, OB22, RNK,
           VOST, VOSTQ, OST, OSTQ,
           DOS, DOSQ, KOS, KOSQ,
           DOS96, DOSQ96, KOS96, KOSQ96,
           DOS96P, DOSQ96P, KOS96P, KOSQ96P,
           DOS99, DOSQ99, KOS99, KOSQ99, DOSZG, KOSZG, DOS96ZG, KOS96ZG, DOS99ZG, KOS99ZG)
    select dat_, dat_, a.acc, a.NLS,  a.KV, a.NBS, a.OB22, a.RNK,
           b.ost - (b.kos - b.dos),
           decode(a.kv, 980, 0, b.ostq  - (b.kosq - b.dosq)),
           b.ost,
           decode(a.kv, 980, 0, b.ostq),
           b.dos,
           decode(a.kv, 980, 0, b.dosq),
           b.Kos,
           decode(a.kv, 980, 0, b.Kosq),
           b.CRdos, decode(a.kv, 980, 0, b.CRdosq),
           b.CRKos, decode(a.kv, 980, 0, b.CRKosq),
           b.CUdos, decode(a.kv, 980, 0, b.CUdosq),
           b.CUKos, decode(a.kv, 980, 0, b.CUKosq),
           0,0,0,0,0,0,0,0,0,0
      from AGG_MONBALS b, OTCN_ACC a
     where b.fdat = trunc(dat_,'mm')
       and b.ACC = a.acc
       and ( b.ostq   <> 0 or b.ost <> 0 or
             b.kosq   <> 0 or b.kos <> 0 or
             b.dosq   <> 0 or b.dos <> 0 or
             b.CRdosq + b.CRkosq <> 0 or b.CRdos + b.CRkos <> 0 or
             b.CUdosq + b.CUkosq <> 0 or b.CUdos + b.CUkos <> 0
           );
  elsif type_ in (4) then

    INSERT /*+APPEND */
      INTO OTCN_SALDO (ODATE, FDAT, ACC, NLS, KV, NBS, OB22, RNK,
           VOST, VOSTQ, OST, OSTQ,
           DOS, DOSQ, KOS, KOSQ,
           DOS96, DOSQ96, KOS96, KOSQ96,
           DOS96P, DOSQ96P, KOS96P, KOSQ96P,
           DOS99, DOSQ99, KOS99, KOSQ99, DOSZG, KOSZG, DOS96ZG, KOS96ZG, DOS99ZG, KOS99ZG)
    select dat_, dat_, a.acc, a.NLS,  a.KV, a.NBS, a.OB22, a.RNK,
           b.ost - (b.kos - b.dos),
           decode(a.kv, 980, 0, b.ostq  - (b.kosq - b.dosq)),
           b.ost,
           decode(a.kv, 980, 0, b.ostq),
           b.dos,
           decode(a.kv, 980, 0, b.dosq),
           b.Kos,
           decode(a.kv, 980, 0, b.Kosq),
           b.CRdos, decode(a.kv, 980, 0, b.CRdosq),
           b.CRKos, decode(a.kv, 980, 0, b.CRKosq),
           b.CUdos, decode(a.kv, 980, 0, b.CUdosq),
           b.CUKos, decode(a.kv, 980, 0, b.CUKosq),
           0,0,0,0,0,0,0,0,0,0
      from AGG_MONBALS b, OTCN_ACC a
     where b.fdat = trunc(dat_,'mm')
       and b.ACC = a.acc;

   commit;

--  INSERT /*+APPEND */
--    INTO OTCN_SALDO (ODATE, FDAT, ACC, NLS, KV, NBS, OB22, RNK,
--         VOST, VOSTQ, OST, OSTQ,
--         DOS, DOSQ, KOS, KOSQ,
--         DOS96, DOSQ96, KOS96, KOSQ96,
--         DOS96P, DOSQ96P, KOS96P, KOSQ96P,
--         DOS99, DOSQ99, KOS99, KOSQ99, DOSZG, KOSZG, DOS96ZG, KOS96ZG, DOS99ZG, KOS99ZG)
--  select distinct dat_, dat_, s.acc, s.NLS,  s.KV, s.NBS, s.OB22, s.RNK,
--         0, 0, 0, 0,
--         0, 0, 0, 0,
--         0, 0, 0, 0,
--         0, 0, 0, 0,
--         0,0,0,0,0,0,0,0,0,0
--    FROM KOR_PROV a, OTCN_ACC s
--   WHERE s.nls like '504%'
--     AND a.FDAT BETWEEN Dat1_ AND dat99_
--     AND a.acc=s.acc
--     AND s.acc not in (select acc from otcn_saldo);

--  commit;

    INSERT /*+APPEND */
      INTO OTCN_SALDO (ODATE, FDAT, ACC, NLS, KV, NBS, OB22, RNK,
           VOST, VOSTQ, OST, OSTQ,
           DOS, DOSQ, KOS, KOSQ,
           DOS96, DOSQ96, KOS96, KOSQ96,
           DOS96P, DOSQ96P, KOS96P, KOSQ96P,
           DOS99, DOSQ99, KOS99, KOSQ99, DOSZG, KOSZG, DOS96ZG, KOS96ZG, DOS99ZG, KOS99ZG)
    select distinct dat_, dat_, s.acc, s.NLS,  s.KV, s.NBS, s.OB22, s.RNK,
           0, 0, 0, 0,
           0, 0, 0, 0,
           0, 0, 0, 0,
           0, 0, 0, 0,
           0,0,0,0,0,0,0,0,0,0
      FROM KOR_PROV a, OTCN_ACC s
     WHERE a.VOB>100
       AND a.VOB NOT IN (196, 199)
       AND a.FDAT BETWEEN Dat1_ AND Dat2_
       AND a.acc=s.acc
       AND s.acc not in (select acc from otcn_saldo);
    
    commit;
    
    INSERT /*+APPEND */
      INTO OTCN_SALDO (ODATE, FDAT, ACC, NLS, KV, NBS, OB22, RNK,
           VOST, VOSTQ, OST, OSTQ,
           DOS, DOSQ, KOS, KOSQ,
           DOS96, DOSQ96, KOS96, KOSQ96,
           DOS96P, DOSQ96P, KOS96P, KOSQ96P,
           DOS99, DOSQ99, KOS99, KOSQ99, DOSZG, KOSZG, DOS96ZG, KOS96ZG, DOS99ZG, KOS99ZG)
    select distinct dat_, dat_, s.acc, s.NLS,  s.KV, s.NBS, s.OB22, s.RNK,
           0, 0, 0, 0,
           0, 0, 0, 0,
           0, 0, 0, 0,
           0, 0, 0, 0,
           0,0,0,0,0,0,0,0,0,0
      FROM KOR_PROV a, OTCN_ACC s
     WHERE a.VOB>100
       AND a.VOB IN (196)
       and s.nls like '504%'
       AND a.FDAT BETWEEN Dat1_ AND Dat2_
       AND a.acc=s.acc
       AND s.acc not in (select acc from otcn_saldo)
       and fost(s.acc, glb_bankdate()) <> 0;

   commit;

    -- ��������� �������������� ��������
    merge into OTCN_SALDO o
    using (
        select  k.acc, a.NLS,  a.KV, a.NBS, a.OB22, a.RNK,
            nvl(sum(DECODE(k.tips,'3',k.Dos96, 0)),0) dos99,
            nvl(sum(DECODE(k.tips,'3',k.Dosq96,0)),0) dosq99,
            nvl(sum(DECODE(k.tips,'3',k.kos96, 0)),0) kos99,
            nvl(sum(DECODE(k.tips,'3',k.kosq96,0)),0) kosq99,
            nvl(sum(DECODE(k.tips,'4',k.Dos96, 0)),0) doszg,
            nvl(sum(DECODE(k.tips,'4',k.Kos96, 0)),0) koszg,
            nvl(sum(DECODE(k.tips,'5',k.Dos96, 0)),0) dos96zg,
            nvl(sum(DECODE(k.tips,'5',k.Kos96, 0)),0) kos96zg,
            nvl(sum(DECODE(k.tips,'6',k.Dos96, 0)),0) dos99zg,
            nvl(sum(DECODE(k.tips,'6',k.Kos96, 0)),0) kos99zg
        from (
           -- � ������� �������������� ��������
           SELECT '3' tips, s.acc,
                  NVL(SUM(DECODE(a.DK, 0, a.s, 0)),0) dos96,
                  NVL(SUM(DECODE(s.kv,980,0,DECODE(a.DK, 0, Gl.P_Icurval(s.kv, a.s, a.vDat),0))),0) dosq96,
                  NVL(SUM(DECODE(a.DK, 1, a.s, 0)),0) kos96,
                  NVL(SUM(DECODE(s.kv,980,0,DECODE(a.DK, 1, Gl.P_Icurval(s.kv, a.s, a.vDat),0))),0) kosq96
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
             AND a.FDAT BETWEEN Dat1_ AND Dat2_
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
           GROUP BY '6', s.acc) k, accounts a
           where k.acc = a.acc
           group by k.acc, a.NLS,  a.KV, a.NBS, A.RNK) p
    on (o.acc = p.acc)
    WHEN MATCHED THEN
        UPDATE SET
           o.dos99   = o.dos99   + p.dos99,
           o.dosq99  = o.dosq99  + p.dosq99,
           o.kos99   = o.kos99   + p.kos99,
           o.kosq99  = o.kosq99  + p.kosq99,
           o.doszg   = o.doszg   + p.doszg,
           o.koszg   = o.koszg   + p.koszg,
           o.dos96zg = o.dos96zg + p.dos96zg,
           o.kos96zg = o.kos96zg + p.kos96zg,
           o.dos99zg = o.dos99zg + p.dos99zg,
           o.kos99zg = o.kos99zg + p.kos99zg
    WHEN NOT MATCHED THEN
        INSERT (o.ODATE, o.FDAT, o.ACC, o.NLS, o.KV, o.NBS, o.OB22, o.RNK,
                o.VOST, o.VOSTQ, o.OST, o.OSTQ, o.DOS, o.DOSQ, o.KOS, o.KOSQ,
                o.DOS96, o.DOSQ96, o.KOS96, o.KOSQ96, o.DOS96P, o.DOSQ96P,
                o.KOS96P, o.KOSQ96P, o.DOS99, o.DOSQ99, o.KOS99, o.KOSQ99,
                o.DOSZG, o.KOSZG, o.DOS96ZG, o.KOS96ZG, o.DOS99ZG, o.KOS99ZG)
        VALUES (dat_, dat_, p.acc, p.NLS,  p.KV, p.NBS, p.OB22, p.RNK,
                0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,
                p.dos99, p.dosq99,p.kos99, p.kosq99,
                p.doszg, p.koszg,
                p.dos96zg, p.kos96zg, p.dos99zg, p.kos99zg);

  else
    null;
  end if;

  commit;

  RETURN 0;

END F_POP_OTCN_SNP;
/

show err;
