CREATE OR REPLACE PROCEDURE BARS.P_F3A_NN (dat_ DATE, sheme_ VARCHAR2 DEFAULT 'D')
IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : ��������� ������������ #3A ��� �� (�������������) � 01.06.2009
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : ��������� ������������ #3A ��� �� (�������������) � 01.06.2009
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 15/06/2018 (05/06/2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
���������: Dat_ - �������� ����
           sheme_ - ����� ������������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
15/06/2018 - ���������� ������� �� IF0,IF1,IF2,IF3,IF4,IF5,IF6 
            (���� �������� �� ����������������� ������)
05/06/2018 - ��� ������ ���������� ����� ������� R011 = '3'
18/05/2018 - �� ����� ���������� �� ������� ����������� ��������� '024' 
10/05/2018 - �� ����� ���������� � ���� �� ������� ������� ���� �
             �������������� �� ������� ����������� - ������� �� ���������
             ( �� 2063 (��� "SP") �� 2600 (���������) )
             ��������� ������� ��� 2063 TIP = "SP". 
27/03/2018 - �� ����� ���������� � ���� �� ������� ������� ���� �
             �������������� �� ������� ����������� - ������� �� ���������
             ( �� 2063  �� 2600 (���������) )
27/12/2017 - � 26.12.2017 (�� 27.12.2017) � ���������� ������ ��������� R013
             ����� ������������� �������� R011
26/12/2017 - ��� KL_R020 �������� ������� ��� ���� D_CLOSE
06/11/2017 - ������ ��-�� KL_F3_29 ����� ������������ ��-� KOD_R020
27/10/2017 - ��� ���.���.2630 ������� ������� OB22 IN ('B2','B3','B4','B5')
             �.�. ����� ���������� � 2635 � OB22 IN ('13','14','15','16')
04/09/2017 - ��� ���������� �������� ������ 2600, 2605, 2650, 2655
             ����� ��������� R013 ����� ������������� ���������������
             ������� �� ����� (������ ���� ��)
13/02/2017 - ������� ������ %% ������ � ������ ������������ (����� ���.
             ����� ���������� � �����������)
20/10/2016 - �� ������ ������ �.�. ��� 2620 �������� S180 = '1'
30/09/2016 - ���� %% ������ ������ 9999 �� ������������� �������� 99.00
26/09/2016 - ��� ��� ��������� � ���� �� ����� ���������� ���.���� 1502
21/09/2016 - ��� ������ ������� �� W4_SPARAM ��������� ������� ROWNUM = 1
16/09/2016 - ����� �������� �����������
08/09/2016 - ��� 2202, 2203  �������� S180 ���������� �� ����. W4_SPARAM
             ���� VALUE
29/08/2016 - ��� 2202 � S180 > 'B' �������� �� "B",
             ��� 2203 � S180 <= 'B' �� �� ����. W4_SPARAM ���� VALUE
03/08/2016 - �������� �������� � 2650 �������� �� 2650 ����������
             ( R013 in ('1','3','8') )
02/12/2015 - ��������� �������� �������������� ��������� ��� ���.������
             �� 2658 �� 3739 � �� 3739 �� 2651 (���� REF)
             � � OPER  NLSA 2658  NLSB 2651 (�������������� ���������)
26/11/2015  ������� ����� ��� ����� ��� ��������������� ������
23/11/2015  ��� ������ ���.���. ������ �������� ����� ������ R013
            2600 (1,7,8,A), 2605 (1,3), 2620 (1,2,3), 2625 (2),
            2650 (1,3,8), 2655 (3)
16/11/2015  ��� ������� ���� ������� � KL_R013 ��� ������ ���.����� �
            ��������� R013 � ������������ �������� D_CLOSE ��� ����� ��
            ������� �������� R013 ������������ �������. ����������.
08/07/2015  �� �� �������� ����������� ���������� ������ ������ ���.c�����
            (�������� ���� ��������� �����)
22/12/2014  ������ ��� ���=344443 � NBS_ LIKE '16%'
            ��� �� �������� � ����� ���������� ������ ������  �������
            " sdos_ := sdos_ - vost_; "  �.�. ����� �� �� ��������
            ���������� �� ������� � ������ �����
            (��� 263 ������ ���������� ������� ������ ������)
17/10/2014  ��� �� �������� � ����� ���������� ������ ������
            ������� " sdos_ := sdos_ - vost_; "  �.�. ����� �� �� ��������
            ���������� �� ������� � ������ �����
01/10/2014 - ��������� �������� �������������� ��������� ��� ���.������
             �� 2618 �� 3739 � �� 3739 �� 2610 (���� REF)
             � � OPER  NLSA 2618  NLSB 2610 (�������������� ���������)
15/08/2014 - � �������� ������������ ����� � �������� ������������ �����������
             ����� �������� �������� OB22
             ��� ����� ������������ �������� � ���� "������ ���.�����������"
             (� ���R �� 3548 �� 3648 ����������� ��������)
             ��� ���������� 150000.... 250000.... 160000.... 260000....
08/08/2014 - ��� ��������� �� ����� �������� �� ������� �� 2630 (OB22='46')
             2635 (OB22='38') - ������� ������
30/07/2014 - ��� ������� ����� �������� ������� � 2620 �� 2630,2635 ����
             ���������� ������
28/07/2014 - ��� 300465 �������� �������� � 2620 �������� �� 2620 ����������
23/07/2014 - ��� ������� ����� �������� ������� � 2630,2635 �� 2620 ����
             ������ ������
21/07/2014 - ��������� ������� �� ����������� ������� �� '2651'
             (���� � ��������)
04/07/2014 - ��� ������� ����� �������� ������� � 2620 �� 2620, � 2630,2635
             �� 2620
29/11/2013 - ���������� �� �������
19/11/2013 - ��������� ������� �� ����������� �������� ��'2650','2652'
14/11/2013 - ��������� ��������  �.3739 - �.26 ����� � ������������
            "³������� ������������������" (���������� ���������� ���)
07/11/2013 - ����������� ����� ���������
10/09/2013 - ���������� ��������������� ��������� ������ �� ��������, �
             ���� ������ ���� ��� �������� ������ �� ������ ����� ������� +
             ��� ������� ������ �������� ������� �� ��������/���������, ��
             ��������� �� �������� �������� ������ ����������� ���
06/09/2013 - ���������� ���������������� ����������� ������ �� ���������, �
             ���� ������ ���� ��� �������� ������ �� ������ ����� ������
02/09/2013 - ���� ��������� ���������
16.08.2013 - ��������� ������� �.3739 - �. 2630,2635 � ������������
             "���������� �������", "%���������%� ����� � ���������%"
30.04.2013 - ��� ���������� ���������� ������ ������� ������ � '990D0000'
             ��  '99990D0000' (���������� � ����� ��)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   kodf_      VARCHAR2 (2)   := '3A';
   fmt_       VARCHAR2 (20)  := '99990D0000';
   typ_       NUMBER;
   datp_      DATE;  -- ���� ������ �������� ����, ���. ������������ ������� ����
   datpf_     DATE; -- ���������� ������� ����
   pproc_     NUMBER; -- ���������� ������ �� ����. ������� ����
   komm_      NUMBER; --����� ������������
   kommr_     NUMBER; --����� ������������
   kolvo_     NUMBER         := 0;

   mfou_      NUMBER;
   sdos_      NUMBER (24);
   skos_      NUMBER (24);
   se_        NUMBER (24);
   sdos1_     NUMBER(24);
   s_prol_    NUMBER (24); -- ����� �����������
   s_prol_02d NUMBER (24); -- ����� ����������� ��������� %% ����� ��� �������� ������
   s_prol_02k NUMBER (24); -- ����� ����������� ��������� %% ����� ��� ��������� ������
   s_prol_03d NUMBER (24); -- ����� ����������� ��������� %% ������ ��� �������� ������
   s_prol_03k NUMBER (24); -- ����� ����������� ��������� %% ������ ��� ��������� ������
   vost_      NUMBER (24);
   vost1_     NUMBER (24);
   spcnt_     NUMBER;
   spcntp_    NUMBER;
   spcntc_    NUMBER;
   spcnt1_    VARCHAR2 (10);
   kv_        SMALLINT;
   nbs_       VARCHAR2 (4);
   nbs1_      VARCHAR2 (4);
   cntr_      NUMBER;
   cntr1_     VARCHAR2 (1);
   mfo_       NUMBER;
   rnk_       NUMBER;
   f03k_      NUMBER;
   f03d_      NUMBER;
   f03mbk_    NUMBER;
   pap_       NUMBER;
   k071_      VARCHAR2 (1);
   k081_      VARCHAR2 (1);
   k092_      VARCHAR2 (1);
   k112_      VARCHAR2 (1);
   mb_        VARCHAR2 (1);
   ddd_       VARCHAR2 (3);
   r050_      VARCHAR2 (2);
   nls_       VARCHAR2 (15);
   data_      DATE;
   mdate_     DATE;
   kodp1_     VARCHAR2 (35);
   kodp2_     VARCHAR2 (35);
   znap_      VARCHAR2 (30);
   acc_       NUMBER;
   acc1_      NUMBER;
   accd_      NUMBER;
   acc8_      NUMBER;

   accd_      NUMBER;
   s180_      VARCHAR2 (1);
   s180new_   VARCHAR2 (1);
   s181_      VARCHAR2 (1);
   s181new_   VARCHAR2 (1);

   sob_       NUMBER;
   sobpr_     NUMBER;
   userid_    NUMBER;
   nbuc1_     VARCHAR2 (12);
   nbuc_      VARCHAR2 (12);
   kodp_      VARCHAR2 (20);
   ob22_      VARCHAR2 (2);
   sql_       VARCHAR2 (200);
   d020_      VARCHAR2 (2);
   d020_acc   VARCHAR2 (2);
   r013_      VARCHAR2 (1);
   r011_      VARCHAR2 (1);
   r011_1     VARCHAR2 (1);
   r011p_     VARCHAR2 (1);
   r013_1     VARCHAR2 (1);
   r013p_     VARCHAR2 (1);
   flag_      BOOLEAN        := TRUE;
   fmt2_      VARCHAR2 (30)  := '999G999G999G990D99';
   isp_       NUMBER;
   tips_      VARCHAR2(3);

   kom_       number;
   old_prc_   number;

   basey_     number;
   b_yea      number;

   PrcEf_    boolean:=false;
   fdat_zd2_ date;
   s_zd2_    number(24);
   pr_form_  number := 0;  -- ������� ������������ ����������� �����
   kol_      number;
   poisk_    varchar2(100);

   flag_blk  number := 0;
   tobo_    accounts.tobo%TYPE;
   nms_     accounts.nms%TYPE;
   comm1_   rnbu_trace.comm%TYPE;
   product_ w4_product.grp_code%TYPE;
   dati_    number;
   codc_    number;
   pdat_    date;
   nd1_     number;
   nd2_     number;
   sql_acc_ clob;
   ret_     number;
   date_spr date := dat_next_u(dat_, 1);
   dat_izm1     date := to_date('26/12/2017','dd/mm/yyyy');
--------------------------------------------------------------------------
   CURSOR scheta
   IS
      SELECT a.acc, a.nls, a.kv, a.ost,
           s.acc, s.s180, s.s181, nvl(s.r013, '0'), nvl(s.r011, '0')
      FROM otcn_saldo a, specparam s
      WHERE a.nbs NOT LIKE '8%'
        AND (a.nbs NOT IN ('1500','1600','2600','2605','2650','2655','8025') and a.dos+a.kos <> 0
                 or
             a.nbs IN ('1600','2600','2605','2650','2655','8025') AND a.ost < 0
                 OR
             a.nbs='1500' AND a.ost > 0
             )
        and a.acc = s.acc(+);

   CURSOR saldo
   IS
      SELECT s.acc, s.nls, s.kv, s.PAP, a.FDAT, s.nbs, k.r050,
             s.mdate, s.isp,
             DECODE( NVL(Trim (p.s180), '0'), '0', Fs180 (a.acc, substr(s.nls, 1, 1), dat_),p.s180),
             p.d020,
             NVL(p.r013,'0'), MOD (c.CODCAGENT, 2), c.rnk,
             a.dos,
             a.kos,
             a.ostf - a.dos + a.kos,
             0,
             s.tip, s.kom, -- % �������� ����
             s.accc, NVL(s.ob22,'00'), s.tobo, s.nms, nvl(p.r011, '0') r011
        FROM (SELECT s.acc, s.nls, s.kv, s.PAP, s.nbs, s.mdate, s.isp, s.tip,
                     0 kom,
                     s.rnk, s.accc, s.tobo, s.nms, s.ob22
               FROM ACCOUNTS s
               WHERE s.nbs NOT LIKE '8%'
                 AND s.tip NOT LIKE 'NL8'
                 AND s.nbs in (select r020
                               from TMP_KOD_R020)
              UNION ALL
              SELECT s.acc, s.nls, s.kv, s.PAP,
                     (case when substr(s.nbs,1,1)='8' then sm.nbs else s.nbs end) nbs,
                     s.mdate, s.isp, s.tip,
                     0, sm.rnk, s.accc, s.tobo, s.nms, s.ob22
               FROM ACCOUNTS sm, V_DPU_REL_ACC_ALL v, ACCOUNTS s
               WHERE sm.nbs in (select r020
                               from TMP_KOD_R020)
                 AND sm.nbs NOT LIKE '8%'
                 AND sm.tip = 'NL8'
                 AND sm.acc = v.gen_acc
                 and v.dep_acc = s.acc) s,
             SALDOA a,
             CUSTOMER c,
             SPECPARAM p,
             (select r020, max(r050) r050
                from kl_r020
                where d_open <= date_spr and
                    (d_close is null or d_close >= date_spr)
                group by r020) k
       WHERE a.dos+a.kos<>0
         AND s.acc = a.acc
         AND a.FDAT = Dat_
         AND s.acc = p.acc(+)
         AND s.rnk = c.rnk
         and s.nbs = k.r020;

   --- ���������� ---
   CURSOR saldoost
   IS
      SELECT a.acc, a.nls, a.kv, a.FDAT,
             a.nbs, a.mdate,
             NVL (Trim (p.s180), Fs180 (a.acc, substr(a.nls, 1, 1), dat_)),
             NVL(Trim (p.r013),'0'), NVL(Trim (p.r011),'0'), trim(p.d020),
             MOD (c.CODCAGENT, 2), c.rnk,
             a.dos, a.kos, a.ostf,
             a.ostf - a.dos + a.kos,
             0, a.isp, a.tip, a.tobo, a.nms
        FROM (SELECT s.acc, s.nls, s.kv, s.mdate, AA.FDAT, s.nbs, AA.ostf,
                     AA.dos, AA.kos, s.isp, s.tip, s.rnk, s.tobo, s.nms
                FROM SALDOA AA, ACCOUNTS s
               WHERE AA.FDAT = dat_
                 AND AA.acc = s.acc
                 AND (   (    s.nbs IN
                                 ('1600',
                                  '2600',
                                  '2605',
                                  '2620',
                                  '2625',
                                  '2650',
                                  '2655',
                                  '8025'
                                 )
                          AND AA.ostf - AA.dos + AA.kos < 0
                         )
                      OR (s.nbs = '1500' AND AA.ostf - AA.dos + AA.kos > 0)
                     )) a,
             CUSTOMER c,
             SPECPARAM p
       WHERE a.nbs in (select r020
                       from TMP_KOD_R020)
         AND a.rnk = c.rnk
         AND a.acc = p.acc(+);

  --- ���������� % ������
 CURSOR izm_proc IS
    select a.*, c.codcagent
    FROM (
            SELECT  b.acc, b.nls, b.kv, b.nbs, b.md_new, b.isp,
                b.s180_new, b.r013, b.r011, b.rnk, b.se, b.prc_old, b.tip, b.tobo, b.nms, b.odate
            from (
            SELECT r.odate, r.acc, a.nls, a.kv, a.nbs, a.PAP, a.rnk, a.isp, a.tip,
                   r.mdate md_old, a.mdate md_new, r.s180 s180_old,
                   NVL (Trim (s.s180), Fs180 (r.acc, substr(a.nls, 1, 1), dat_)) s180_new,
                   r.ints prc_old,
                   0 se, NVL(r.mb,s.r013) r013, NVL(r.mb,s.r011) r011,
                   a.tobo, a.nms
              FROM RNBU_HISTORY r, ACCOUNTS a, SPECPARAM s
              WHERE r.acc NOT IN (SELECT acc FROM RNBU_HISTORY WHERE odate=dat_) AND
                    (r.odate, r.acc) in (SELECT MAX(h.odate), h.acc
                                          FROM RNBU_HISTORY h
                                          WHERE h.odate < dat_ and
                                                --h.kf = to_char(mfo_) and
                                                h.acc in (select acc
                                                          from int_ratn
                                                          where bdat = dat_)
                                         GROUP BY h.acc)
                    AND r.acc = a.acc
                    AND a.nbs NOT LIKE '8%'
                    AND a.nbs in (select r020
                                  from TMP_KOD_R020
                                  where R020 NOT IN ('1600',
                                                     '2600',
                                                     '2605',
                                                     '2620',
                                                     '2625',
                                                     '2650',
                                                     '2655',
                                                     '8025'))
                    AND r.acc = s.acc(+))  b
            ) a, customer c
   where a.rnk = c.rnk;

   CURSOR basel IS
      SELECT nbuc, kodp, SUM (TO_NUMBER (znap)),
               SUM (TO_NUMBER (znap_pr))
      FROM (SELECT a.nbuc NBUC, a.kodp KODP, a.znap ZNAP, '0' ZNAP_PR
            FROM RNBU_TRACE a
            WHERE a.kodp like '1%'
            UNION ALL
            SELECT a.nbuc NBUC, '1'||substr(a.kodp,2) KODP, '0' ZNAP,
                   a.znap ZNAP_PR
            FROM RNBU_TRACE a
            WHERE a.kodp like '3%')
      GROUP BY nbuc, kodp;

-------------------------------------------------------------------------------
   PROCEDURE p_ins (p_kodp_ VARCHAR2, p_znap_ VARCHAR2) IS
       pr_ number := (case when PrcEf_ and spcnt_<>old_prc_ then 1 else 0 end); -- ������� ������� ���. % ������
       comm_ varchar2(200) := (case when PrcEf_ and spcnt_<>old_prc_ then '������������ ���. % ������' else null end);
       kodp_ VARCHAR2(100)  := p_kodp_;
   BEGIN
      comm_ := substr(comm1_ || '  ' || comm_, 1, 200);

      if data_ >= to_date('02092013','ddmmyyyy') then
         kodp_ := p_kodp_ || '0';
      end if;

      INSERT INTO RNBU_TRACE
                  (nls, kv, odate, kodp, znap, nbuc, isp, rnk,
                   acc, mdate, nd, comm
                  )
           VALUES (nls_, kv_, data_, kodp_, p_znap_, nbuc_, isp_, rnk_,
                   acc_, mdate_, pr_, comm_
                  );

      kolvo_ := kolvo_ + 1;
   END;
------------------------------------------------------------------------------------------------------
   PROCEDURE p_ins_log (p_kod_ VARCHAR2, p_val_ NUMBER)
   IS
           mes_ VARCHAR2(200);
   BEGIN
      IF     kodf_ IS NOT NULL
         AND userid_ IS NOT NULL
         AND (p_val_ IS NULL OR (p_val_ IS NOT NULL AND p_val_ <> 0))
      THEN
         mes_ :=  p_kod_ || Trim(TO_CHAR (p_val_ / 100, fmt2_));

         IF LENGTH(mes_) >= 100 THEN
             INSERT INTO OTCN_LOG(kodf, userid, txt)
                  VALUES (kodf_, userid_, SUBSTR(mes_,1,99));

             INSERT INTO OTCN_LOG(kodf, userid, txt)
                  VALUES (kodf_, userid_, SUBSTR(mes_,100,99));
         ELSE
             INSERT INTO OTCN_LOG(kodf, userid, txt)
                  VALUES (kodf_, userid_, mes_);
         END IF;
      END IF;
   END;

  PROCEDURE p_ins_del (pacc_ number, pnls_ varchar2, pkv_ number, ptpf_ varchar2, psumo_ number, psumf_ number)
   IS
           mes_ VARCHAR2(200);
   BEGIN
      IF kodf_ IS NOT NULL AND userid_ IS NOT NULL and psumf_<> 0 then
            BEGIN
               insert into OTCN_DEL_3A(DATF, ISP, ACC, NLS, KV, TPF, SUMO, SUMF)
               values (dat_, userid_,  pacc_, pnls_, pkv_, ptpf_, psumo_, psumf_);
            EXCEPTION WHEN OTHERS THEN
               update otcn_del_3a
               set sumo=sumo+psumo_, sumf=sumf+psumf_
               where datf=dat_
                 and isp=userid_
                 and acc=pacc_
                 and nls=pnls_
                 and kv=pkv_
                 and tpf=ptpf_;
            END;
      END IF;
   END;
 ------------------------------------------------------------------------------------------------------
BEGIN
   commit;

   EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
   -------------------------------------------------------------------
   userid_ := gl.aUID;

   logger.info ('P_F3A_NN: Begin ');

   EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
   EXECUTE IMMEDIATE 'TRUNCATE TABLE TMP_FILE03';
   EXECUTE IMMEDIATE 'TRUNCATE TABLE TMP_KOD_R020';

   EXECUTE IMMEDIATE 'alter session set NLS_NUMERIC_CHARACTERS=''.,''';

   DELETE FROM OTCN_LOG
         WHERE userid = userid_ AND kodf = kodf_;

   DELETE FROM OTCN_DEL_3A
         WHERE isp = userid_ AND datf = dat_;

   DELETE FROM OTCN_TRACE_3A
         WHERE userid = userid_ AND datf= dat_;

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

   select count(*)
   into flag_blk
   from OTCN_FLAG_BLK
   where datf = dat_ and kodf=kodf_;

   insert into TMP_KOD_R020
   select r020
   from kod_r020
   where a010 = '3A' and
         trim(prem) = '��' and
         (d_close is null or d_close > date_spr);

   if flag_blk = 0 then
       sql_acc_ := 'select r020 from TMP_KOD_R020 ';

       ret_ := F_Pop_Otcn(Dat_, 1, sql_acc_);

       -- ���������� �������� �� ��_��� ����
        insert into tmp_file03
                (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
        select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP
        from (
            with sel as
                 ( select
                      a.acc, a.nls, a.kv, a.nbs,
                      o.nazn,
                      o.userid isp,
                      p.ref, p.stmt, p.dk, p.tt,
                      p.fdat, p.s/100 s, p.sq/100 sq
                  FROM opldok p, accounts a, oper o
                  WHERE p.fdat = dat_ and
                        p.acc = a.acc and
                        a.nbs in (select r020
                                  from TMP_KOD_R020) and
                        p.sos >= 4 and
                        p.ref = o.ref and
                        o.sos = 5)
             select a.acc ACCD, a.tt TT, a.ref REF, a.kv KV, a.nls NLSD, a.s, a.SQ,
                a.FDAT, a.NAZN, b.acc ACCK, b.nls NLSK, a.ISP
             from sel a, opl b
             where a.dk = 0 and
                a.ref = b.ref and
                a.stmt = b.stmt and
                a.s = b.s/100 and
                a.sq = b.sq/100 and
                b.dk = 1
             union
             select b.acc ACCD, a.tt TT, a.ref REF, a.kv KV, b.nls NLSD, a.s, a.SQ,
                a.FDAT, a.NAZN, a.acc ACCK, a.nls NLSK, a.ISP
             from sel a, opl b
             where a.dk = 1 and
                a.ref = b.ref and
                a.stmt = b.stmt and
                a.s = b.s/100 and
                a.sq = b.sq/100 and
                b.dk = 0);

       commit;

       -- ���� ������ ������� ���. ����, ������� �������������� ������� ����
       datp_ := Calc_Pdat (dat_);

       -- ���������� ������� ����
       datpf_ := datp_ - 1;

       P_Proc_Set (kodf_, sheme_, nbuc1_, typ_);
       p_ins_log (   '�������� ��������, ����������� ��� ������������ ����� '''
                  || kodf_
                  || ''' �� '''
                  || dat_
                  || ''':',
                  NULL);
       p_ins_log
             ('-----------------------------------------------------------------',
              NULL);

       --!!!!! ������ ���� �������� �������� (������� if pr_form <> 0 then)
       OPEN scheta;

       LOOP
          FETCH scheta
           INTO acc_, nls_, kv_, se_, acc1_, s180_, s181_, r013_, r011_;

          EXIT WHEN scheta%NOTFOUND;

          nbs_ := SUBSTR (nls_, 1, 4);

          -- ��������� ������������� ��������
          if acc1_ is null then
             acc1_ := 0;
             s180_ := Fs180 (acc_, substr(nls_, 1, 1), dat_);
             s181_ := fs181(acc_, dat_, s180_);
          end if;

          s180new_ := s180_;
          s181new_ := s181_;

          -- �����������i �� �i�����i����i ������i�
          IF nbs_ LIKE '1%'
          THEN
             -- �������� �� ����������
             IF nbs_ IN ('1510', '1610', '1521', '1621')
             THEN
                s180new_ := '2';
             ELSE
                select count(*)
                INTO f03k_
                FROM cc_deal d,
                     cc_add ad,
                     cc_vidd v,
                     accounts a,
                     customer c,
                     custbank cb
                WHERE a.acc = acc_
                  and d.nd = ad.nd
                  AND d.vidd = v.vidd
                  AND v.custtype = 1
                  AND LENGTH (v.vidd) = 4
                  AND ad.accs = a.acc
                  AND c.custtype = 1
                  AND ad.adds = 0
                  AND a.dazs IS NULL
                  AND d.rnk = c.rnk
                  AND c.rnk = cb.rnk
                  AND (   a.ostc <> 0
                       OR a.dapp = dat_
                       OR d.sdate = dat_
                       OR d.wdate >= dat_)
                  AND d.wdate = NVL (a.mdate, TO_DATE ('31/12/2050', 'dd-mm-yyyy'));

                IF f03k_ > 0
                THEN
                   s180new_ := Fs180mbk (acc_, dat_);
                ELSE
                   s180new_ := s180_;
                END IF;
             END IF;
             IF nbs_='1500' THEN
                IF se_ > 0 AND NVL (Trim (s180new_), '0') = '0' THEN
                   s180new_ := '1';
                END IF;
             END IF;
          END IF;

          -- ������_ ������� ���'���_� ������������ �_�������_ �� �_������ ��_�
          IF nbs_ IN ('2600', '2605', '2620', '2625', '2650', '2655', '1600')
          THEN
             IF se_ < 0 AND NVL (Trim (s180new_), '0') = '0'
             THEN
                s180new_ := '1';
             END IF;

             --  ������_ ������� �_������ ��_�
             IF    nbs_ IN ('2620', '2625')
                AND se_ > 0
                AND NVL (Trim (s180new_), '0') = '0'
             THEN
                s180new_ := s180_;
             END IF;
          END IF;

          IF nbs_ IN ('2603', '2604')
          THEN
             s180new_ := '1';
          END IF;

          IF nbs_ LIKE '2%' AND NVL (Trim (s180new_), '0') = '0'
          THEN
             s180new_ := Fs180 (acc_, SUBSTR(nbs_, 1, 1), dat_);
          END IF;

          IF acc1_ > 0
          THEN
             IF (NVL (Trim (s180_), '0') = '0' OR s180_ <> s180new_) and s180new_ not in ('0','8','9')
                 THEN
                    s181new_ := fs181(acc_, dat_, s180new_);

                UPDATE SPECPARAM
                   SET s180 = s180new_,
                                           s181 = s181new_
                    WHERE acc = acc_;
                 ELSIF NVL (Trim (s181_), '0') = '0' OR s181_ <> s181new_
                 THEN
                    s181new_ := fs181(acc_, dat_, s180new_);

                    UPDATE SPECPARAM
                    SET s181 = s181new_
                WHERE acc = acc_;
             END IF;
          END IF;

          IF acc1_ = 0
          THEN
             INSERT INTO SPECPARAM
                         (acc, s180, s181
                         )
                  VALUES (acc_, s180new_, s181new_
                         );
          END IF;
       END LOOP;

       CLOSE scheta;

       commit;
    ----------------------------------------------------------------------------
       DELETE FROM RNBU_HISTORY
       WHERE odate = dat_;
             --and kf = to_char(mfo_);
    ----------------------------------------------------------------------------

       OPEN saldo;

       LOOP
          FETCH saldo
           INTO acc_, nls_, kv_, pap_, data_, nbs_, r050_, mdate_, isp_,
                s180_, d020_acc, r013p_, cntr_, rnk_, sdos_, skos_, se_, spcnt_,
                tips_, kom_, acc8_, ob22_, tobo_, nms_, r011_;

          EXIT WHEN saldo%NOTFOUND;

          comm1_ := '';
          comm1_ := substr(comm1_ || 'OB22=' || ob22_ || '  ' || tobo_ || '  ' || nms_, 1, 200);

          f03k_ := 0;
          f03d_ := 0;
          kolvo_ := 0;
          s_prol_02d := 0;
          s_prol_02k := 0;
          s_prol_03d := 0;
          s_prol_03k := 0;
          r013_ := r013p_;

          -- 20.10.2016   �� ������ ������ �.�.
          if mfou_ = 300465 and nbs_ = '2620' and se_ > 0
          then
             s180_ := '1';
          end if;

          if dat_ < dat_izm1
          then
             if r013_ <> '0' then
                BEGIN
                   select r013
                      into r013_1
                   from kl_r013
                   where trim(prem) = '��' and r020 = nbs_ and r013 = r013_
                     and d_close is not null and d_close <= dat_
                     and (r020, r013 ) not in ( select k.r020, k.r013
                                                from kl_r013 k
                                                where trim(k.prem) = '��'
                                                  and k.r020 = nbs_
                                                  and k.r013 = r013_
                                                  and k.d_close is null
                                              );
                   r013_ := '0';
                EXCEPTION
                   WHEN NO_DATA_FOUND
                   THEN
                   null;
                END;
             end if;
          else
             if r011_ <> '0' then
                BEGIN
                   select r011
                      into r011_1
                   from kl_r011
                   where trim(prem) = '��' and r020 = nbs_ and r011 = r011_
                     and d_close is not null and d_close <= dat_
                     and (r020, r011 ) not in ( select k.r020, k.r011
                                                from kl_r011 k
                                                where trim(k.prem) = '��'
                                                  and k.r020 = nbs_
                                                  and k.r011 = r011_
                                                  and k.d_close is null
                                              );
                   r011_ := '0';
                EXCEPTION
                   WHEN NO_DATA_FOUND
                   THEN
                   null;
                END;
             end if;
          end if;

          spcnt_     := Acrn_otc.fproc (acc_, data_);

          if se_ < 0 and acc8_ is not null then
             kom_ := Acrn_otc.fprocn (acc8_, 2, dat_);
          end if;

          -- 06/09/2013 ���������� �������� ��������� ������ �� ���������
          -- �� ������������ ��� �������� ������ �� ������ "�����"  ��������
          if se_ > 0 and spcnt_ <> 0 then
             spcnt_ := f_ret_avg_ratn(acc_, 1, dat_, mdate_, spcnt_);
          end if;

          --  10/09/2013 ���������� �������� ��������� ������ �� ��������
          if se_ < 0 and spcnt_ <> 0 then
             -- ��������� ���� ��������� (�� ��� ����� ���� �� ����� ����� ��������� ���������� ��������)
             if nbs_ like '1%' then
                select max(c.wdate)
                   into mdate_
                from nd_acc n, cc_deal c
                where n.acc = acc_ and
                      n.nd = c.nd and
                      c.sdate <= dat_;
             end if;

             spcnt_ := f_ret_avg_ratn(acc_, 0, dat_, mdate_, spcnt_);
          end if;

          old_prc_ := spcnt_;

          PrcEf_ := false;

          flag_ := TRUE;

          -- ���������� ������� % ������ � ������ ����������� ��������
          -- ����� ������ ����������� %% ������ �.�. � 02.07.2012 �������� ���
          -- ����� ���� ������ ��� �������
          if se_ < 0 and kom_ <> 0 then
             old_prc_ := spcnt_;

             declare
                metr_ number;
             begin
                select metr
                into metr_
                from int_accn
                where acc=acc8_ and
                          id=2;

                if metr_ = 97 then
                    null;
                else
                    spcnt_ := ROUND (spcnt_ + 12 * kom_, 4);

                    p_ins_log('C��� '''||nls_||
                               '. %MesKom='||Trim(TO_CHAR(kom_))||
                               '. OldPrc='||Trim(TO_CHAR(old_prc_))||
                               '. NewPrc='||LTRIM(TO_CHAR (spcnt_))||
                               '.', NULL);
                end if;
             exception
                when no_data_found then
                     metr_ := null;
             end;
          end if;

          -- ��� ��������� ���.������ ������ ���� �������� %% ������
          if nbs_ in ('1510','1521','1610','1621','2600','2605','2620',
                      '2650','2655') then
             spcnt_ := old_prc_;
          end if;

          d020_:='01';

          IF flag_ THEN
             IF typ_ > 0 THEN
                nbuc_ := NVL (F_Codobl_Tobo (acc_, typ_), nbuc1_);
             ELSE
                nbuc_ := nbuc1_;
             END IF;

             k092_ := null;
             k081_ := null;
             k112_ := null;
             k071_ := null;
             mb_ := null;

             -- �������� �� ����������
             IF nbs_ IN ('1510', '1610', '1521', '1621') THEN
                s180_ := '2';
             END IF;

             -- ��� ���.������ 2202, 2203 ���������� S180 �� ���� ��������
             -- �� W4_SPARAM
             IF nbs_ in ('2202', '2203') and newnbs.g_state = 0
             THEN

                comm1_ := comm1_ || '����� S180 � ' || s180_;

                BEGIN
                   select s.value, p.grp_code
                      into s180_, product_
                   from w4_sparam s, w4_product p, w4_acc a, w4_card c
                   where s.grp_code = p.grp_code
                     and s.sp_id = 4
                     and s.nbs = nbs_
                     and a.acc_ovr = acc_
                     and a.card_code = c.code
                     and c.product_code = p.code
                     and p.tip = s.tip
                     and rownum = 1;

                     comm1_ := comm1_ || ' �� ' || s180_ || ' ������� ' || product_;
                EXCEPTION WHEN NO_DATA_FOUND THEN
                   null;
                END;
             END IF;

             -- ���� ��� �� ���������� � ���� ��������� �������
             IF nbs_ NOT IN
                       ('1500',
                        '1600',
                        '2600',
                        '2605',
                        '2620',
                        '2625',
                        '2650',
                        '2655'
                       )
                AND r050_ = '11' AND sdos_ > 0
             THEN
                BEGIN
                  SELECT
                    NVL(SUM((case when substr(nlsk,1,4) = nbs_ then s*100 else 0 end)), 0) sum_nbs,
                    NVL(SUM((case when substr(nlsk,1,4) <> nbs_ then s*100 else 0 end)), 0) sum_gr
                  into vost_, vost1_
                  FROM tmp_file03
                  WHERE FDAT = data_
                  AND accd = acc_
                  AND nlsk LIKE substr(nbs_,1,3) || '%';

                  -- ���������� �� ����� �� ���� (������ ������ ����������� �����)
                  if vost_ <> 0 then
                      p_ins_del (acc_, nls_, kv_, '(������ ��)', sdos_, vost_);

                      p_ins_log (   '(������ ��) DK=0 r020='''
                                 || nbs_
                                 || ''' ����='''
                                 || nls_
                                 || ''' ���='''
                                 || kv_
                                 || ''' ����='''
                                 || data_
                                 || ''' �����=',
                                 vost_);
                  end if;

                  IF vost_ = 0 and vost1_ <> 0 THEN
                     vost_ := vost1_;
                    -- ���������� ������ ������ ���������� ������
                    p_ins_del (acc_, nls_, kv_, '(������ ������)', sdos_, vost_);

                    p_ins_log (   '(������ ������) DK=0 r020='''
                                 || nbs_
                                 || ''' ����='''
                                 || nls_
                                 || ''' ���='''
                                 || kv_
                                 || ''' ����='''
                                 || data_
                                 || ''' �����=',
                                 vost_);
                  END IF;
                EXCEPTION
                  WHEN NO_DATA_FOUND
                THEN
                  vost_ := 0;
                END;

                -- �������� "����������"
                sdos_ := sdos_ - vost_;

                IF mfou_ in (300465) THEN
                   if substr(trim(nls_),1,3) in ('206', '207', '220', '221', '223') then
                       case substr(trim(nls_),1,3)
                           when '206' then poisk_ := '207%';
                           when '207' then poisk_ := '206%';
                           when '220' then poisk_ := '221%';
                           when '221' then poisk_ := '220%';
                           when '223' then poisk_ := '220%';
                       else
                          poisk_ := null;
                       end case;

                       BEGIN
                          -- ���������� � ��.206 � ��.207 ��� ��������
                          SELECT NVL(SUM(s*100), 0)
                             INTO vost_
                          FROM tmp_file03
                          WHERE FDAT = data_
                            AND accd=acc_
                            AND nlsk like poisk_;

                          p_ins_del (acc_, nls_, kv_, '(���������� � '||substr(trim(nls_),1,3)||' �� '||poisk_||') ', sdos_, vost_);

                          p_ins_log (   '(���������� � '||substr(trim(nls_),1,3)||' �� '||poisk_||') DK=0 r020='''
                                     || nbs_
                                     || ''' ����='''
                                     || nls_
                                     || ''' ���='''
                                     || kv_
                                     || ''' ����='''
                                     || data_
                                     || ''' �����=',
                                     vost_);
                       EXCEPTION
                          WHEN NO_DATA_FOUND
                       THEN
                          vost_ := 0;
                       END;

                       -- �������� "����������"
                       sdos_ := sdos_ - vost_;


                       if substr(trim(nls_),1,3) = '206' and 
                          trim(tips_) = 'SP' and vost_ = 0 
                       then
                          poisk_ := '260%';

                          BEGIN
                             -- ���������� � ��.260 (���������) � ��.206 ���������
                             SELECT NVL(SUM(s*100), 0)
                                INTO vost_
                             FROM tmp_file03
                             WHERE FDAT = data_
                               AND accd=acc_
                               AND nlsk like poisk_
                               AND acck in (select acc from acc_over where NVL (sos, 0) <> 1);

                             p_ins_del (acc_, nls_, kv_, '(���������� � '||substr(trim(nls_),1,3)||' �� '||poisk_||') ', sdos_, vost_);

                             p_ins_log (   '(���������� � '||substr(trim(nls_),1,3)||' �� '||poisk_||') DK=0 r020='''
                                        || nbs_
                                        || ''' ����='''
                                        || nls_
                                        || ''' ���='''
                                        || kv_
                                        || ''' ����='''
                                        || data_
                                        || ''' �����=',
                                        vost_);
                          EXCEPTION
                             WHEN NO_DATA_FOUND
                          THEN
                             vost_ := 0;
                          END;

                          -- �������� "����������"
                          sdos_ := sdos_ - vost_;
                       end if;
                   end if;
                END IF;

                IF mfo_ = 300465 THEN
                   BEGIN
                      -- ���������� �� ����� 2063 �� ���� 2073
                      SELECT NVL(SUM(s*100), 0)
                        INTO vost_
                      FROM tmp_file03
                      WHERE FDAT = data_
                        and accd = acc_
                        AND tt = 'NE3';

                      p_ins_del (acc_, nls_, kv_, '(�������� NE3)', sdos_, vost_);

                      p_ins_log (   '(�������� NE3) DK=1 r020='''
                                 || nbs_
                                 || ''' ����='''
                                 || nls_
                                 || ''' ���='''
                                 || kv_
                                 || ''' ����='''
                                 || data_
                                 || ''' �����=',
                                 vost_);
                   EXCEPTION
                      WHEN NO_DATA_FOUND
                      THEN
                      vost_ := 0;
                   END;

                   -- �������� "����������"
                   sdos_ := sdos_ - vost_;
                END IF;

                IF mfou_ = 300465 THEN
                   BEGIN
                      vost_ := 0;

                      SELECT NVL(SUM(t.s*100), 0)
                         INTO vost_
                      FROM tmp_file03 t
                      WHERE t.TT='024'
                        AND t.FDAT = data_
                        and t.accd = acc_;

                      p_ins_del (acc_, nls_, kv_, '(�������� 024)', sdos_, vost_);

                      p_ins_log (   '(�������� 024) DK=1 r020='''
                                 || nbs_
                                 || ''' ����='''
                                 || nls_
                                 || ''' ���='''
                                 || kv_
                                 || ''' ����='''
                                 || data_
                                 || ''' �����=',
                                 vost_);
                   EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                      vost_ := 0;
                   END;

                   sdos_ := sdos_ - vost_;
                   
                   -- ���������������� ������
                   BEGIN
                      vost_ := 0;

                      SELECT NVL(SUM(t.s*100), 0)
                         INTO vost_
                      FROM tmp_file03 t
                      WHERE t.TT in ('IF0','IF1','IF2','IF3','IF4','IF5','IF6')
                        AND t.FDAT = data_
                        and t.accd = acc_;

                      p_ins_del (acc_, nls_, kv_, '(���������������� ������)', sdos_, vost_);

                      p_ins_log (   '(���������������� ������) DK=1 r020='''
                                 || nbs_
                                 || ''' ����='''
                                 || nls_
                                 || ''' ���='''
                                 || kv_
                                 || ''' ����='''
                                 || data_
                                 || ''' �����=',
                                 vost_);
                   EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                      vost_ := 0;
                   END;

                   sdos_ := sdos_ - vost_;
                END IF;

                vost_ := 0;

                BEGIN
                   case
                   when substr(nbs_,1,3) in ('220', '223') then
                      poisk_ := '2909%';
                   else
                      poisk_ := null;
                      vost_ := 0;
                   end case;

                   if poisk_ is not null then
                      SELECT NVL(SUM(s*100), 0)
                         INTO vost_
                      FROM tmp_file03
                      WHERE FDAT = data_
                        AND nlsk LIKE poisk_
                        and accd = acc_;

                      p_ins_del (acc_, nls_, kv_, '(� ' || nbs_ || ' �� 2909)', skos_,  vost_);

                      p_ins_log (   '(� '||nbs_||' �� 2909) DK=1 r020='''
                                 || nbs_
                                 || ''' ����='''
                                 || nls_
                                 || ''' ���='''
                                 || kv_
                                 || ''' ����='''
                                 || data_
                                 || ''' �����=',
                                 vost_);
                   end if;
                EXCEPTION
                   WHEN NO_DATA_FOUND
                THEN
                   vost_ := 0;
                END;

                sdos_ := sdos_ - vost_;

                vost_ := 0;

                BEGIN
                   case
                   when substr(nbs_,1,3) in ('220', '223') then
                      poisk_ := '3739%';
                   else
                      poisk_ := null;
                      vost_ := 0;
                   end case;

                   if poisk_ is not null then
                      SELECT NVL(SUM(s*100), 0)
                         INTO vost_
                      FROM tmp_file03
                      WHERE FDAT = data_
                        AND nlsk LIKE poisk_
                        and accd = acc_
                        and tt not like 'KK_';

                     p_ins_del (acc_, nls_, kv_, '(� ' || nbs_ || ' �� 3739)', skos_,  vost_);

                     p_ins_log (   '(� '||nbs_||' �� 3739) DK=1 r020='''
                                || nbs_
                                || ''' ����='''
                                || nls_
                                || ''' ���='''
                                || kv_
                                || ''' ����='''
                                || data_
                                || ''' �����=',
                                vost_);
                   end if;
                EXCEPTION
                   WHEN NO_DATA_FOUND
                THEN
                   vost_ := 0;
                END;

                sdos_ := sdos_ - vost_;

                BEGIN
                   poisk_ := '02%';

                   -- ��������� ����� ����������� D020='02'
                   SELECT NVL(SUM(p.s*100), 0 )
                      INTO s_prol_
                   FROM tmp_file03 p, OPERW o
                   WHERE p.FDAT = data_
                     AND p.accd=acc_
                     AND p.REF=o.REF
                     AND o.tag LIKE 'D020%'
                     AND o.value LIKE poisk_;

                   p_ins_del (acc_, nls_, kv_, '(D020=''02'')', sdos_, s_prol_);

                   p_ins_log (   '(D020=''02'') DK=0 r020='''
                              || nbs_
                              || ''' ����='''
                              || nls_
                              || ''' ���='''
                              || kv_
                              || ''' ����='''
                              || data_
                              || ''' �����=',
                              s_prol_);
                EXCEPTION
                   WHEN NO_DATA_FOUND
                   THEN
                      s_prol_ := 0;
                END;

                if nvl(d020_acc, '01') = '02' then
                   s_prol_ := sdos_;
                end if;

                -- �������� "�����������"
                s_prol_02d := s_prol_;
                sdos_ := sdos_ - s_prol_;

                BEGIN
                   poisk_ := 'ZZ%';

                   -- ���� ��� �� ������ ������� � �� �����������, � "_���"
                   SELECT NVL(SUM(p.s*100), 0)
                      INTO vost_
                   FROM tmp_file03 p, OPERW o
                   WHERE p.FDAT = data_
                     AND p.accd=acc_
                     AND p.REF=o.REF
                     AND o.tag LIKE 'D020%'
                     AND o.value LIKE poisk_;

                   p_ins_del (acc_, nls_, kv_, '(D020=''ZZ'')', sdos_, vost_);

                   p_ins_log (   '(D020=''ZZ'') DK=0 r020='''
                              || nbs_
                              || ''' ����='''
                              || nls_
                              || ''' ���='''
                              || kv_
                              || ''' ����='''
                              || data_
                              || ''' �����=',
                              vost_);
                EXCEPTION
                   WHEN NO_DATA_FOUND
                   THEN
                      vost_ := 0;
                END;

                -- �������� "i���" (D020='ZZ')
                sdos_ := sdos_ - vost_;

                BEGIN
                   poisk_ := '03%';

                   -- ���� ��� �� ������ ������� � �� �����������, � "��������� %% ������ (D020='03')"
                   SELECT NVL(SUM(p.s*100), 0)
                      INTO vost_
                   FROM tmp_file03 p, OPERW o
                   WHERE p.FDAT = data_
                     AND p.accd=acc_
                     AND p.REF=o.REF
                     AND o.tag LIKE 'D020%'
                     AND o.value LIKE poisk_;

                   p_ins_del (acc_, nls_, kv_, '(D020=''03'')', sdos_, vost_);

                   p_ins_log (   '(D020=''03'') DK=0 r020='''
                              || nbs_
                              || ''' ����='''
                              || nls_
                              || ''' ���='''
                              || kv_
                              || ''' ����='''
                              || data_
                              || ''' �����=',
                              vost_);
                EXCEPTION
                   WHEN NO_DATA_FOUND
                   THEN
                      vost_ := 0;
                END;

                -- �������� ����������� � ���������� %% ������ (D020='03')
                s_prol_03d := vost_;
                sdos_ := sdos_ - vost_;

                -- ��������� �������
                IF sdos_ > 0 AND spcnt_ >= 0 and r050_ = '11' AND se_ <= 0
                THEN
                   sdos_ := Gl.P_Icurval (kv_, sdos_, data_);

                   if dat_ < dat_izm1
                   then
                      kodp_ :=
                            '5'
                         || nbs_
                         || r013_
                         || s180_
                         || TO_CHAR (2 - cntr_)
                         || d020_
                         || LPAD (kv_, 3, '0');
                   else
                      kodp_ :=
                            '5'
                         || nbs_
                         || r011_
                         || s180_
                         || TO_CHAR (2 - cntr_)
                         || d020_
                         || LPAD (kv_, 3, '0');
                   end if;

                   IF s180_ = '0' THEN
                      nls_ := 'X' || nls_;
                   END IF;

                   if spcnt_ > 9999 then
                      spcnt_ := 99.00;
                   end if;

                   -- ��. �������
                   p_ins ('1' || kodp_, TO_CHAR (sdos_));
                   -- %% ������
                   p_ins ('2' || kodp_, LTRIM (TO_CHAR (ROUND (spcnt_, 4), fmt_)));
                   -- ��.�������*%% ������
                   p_ins ('3' || kodp_, TO_CHAR (sdos_*ROUND(spcnt_,4)));

                   if dat_ < dat_izm1
                   then
                      INSERT INTO RNBU_HISTORY
                                   (odate,
                                    nls,
                                    kv, CODCAGENT, ints, s180, k081, k092, dos,
                                    kos, mdate, k112, mb, d020, isp, ost, acc
                                   )
                            VALUES (dat_,
                                    DECODE (SUBSTR (nls_, 1, 1),
                                            'X', SUBSTR (nls_, 2, 14),
                                            nls_
                                           ),
                                    kv_, cntr_, spcnt_, s180_, k081_, k092_, sdos_,
                                    skos_, mdate_, k112_, r013_, d020_, isp_, se_, acc_
                                   );
                   else
                      INSERT INTO RNBU_HISTORY
                                   (odate,
                                    nls,
                                    kv, CODCAGENT, ints, s180, k081, k092, dos,
                                    kos, mdate, k112, mb, d020, isp, ost, acc
                                   )
                            VALUES (dat_,
                                    DECODE (SUBSTR (nls_, 1, 1),
                                            'X', SUBSTR (nls_, 2, 14),
                                            nls_
                                           ),
                                    kv_, cntr_, spcnt_, s180_, k081_, k092_, sdos_,
                                    skos_, mdate_, k112_, r011_, d020_, isp_, se_, acc_
                                   );
                   end if;
                END IF;

                -- ������� �����������
                IF s_prol_ > 0 AND spcnt_ >= 0 AND r050_ = '11' and se_ < 0
                THEN

                   s_prol_ := Gl.P_Icurval (kv_, s_prol_, data_);

                   if dat_ < dat_izm1
                   then
                      kodp_ :=
                            '5'
                         || nbs_
                         || r013_
                         || s180_
                         || TO_CHAR (2 - cntr_)
                         || '02'
                         || LPAD (kv_, 3, '0');
                   else
                      kodp_ :=
                            '5'
                         || nbs_
                         || r011_
                         || s180_
                         || TO_CHAR (2 - cntr_)
                         || '02'
                         || LPAD (kv_, 3, '0');
                   end if;

                   IF s180_ = '0' THEN
                      nls_ := 'X' || nls_;
                   END IF;

                   -- ������� �����������
                   p_ins ('1' || kodp_, TO_CHAR (s_prol_));
                   -- %% ������
                   p_ins ('2' || kodp_, LTRIM (TO_CHAR (ROUND (spcnt_, 4), fmt_)));
                   -- ��.�������*%% ������
                   p_ins ('3' || kodp_, TO_CHAR (s_prol_*ROUND(spcnt_,4)));

                   sdos_ := s_prol_;
                   d020_ := '02';

                   if dat_ < dat_izm1
                   then
                      INSERT INTO RNBU_HISTORY
                                   (odate,
                                    nls,
                                    kv, CODCAGENT, ints, s180, k081, k092, dos,
                                    kos, mdate, k112, mb, d020, isp, ost, acc
                                   )
                            VALUES (dat_,
                                    DECODE (SUBSTR (nls_, 1, 1),
                                            'X', SUBSTR (nls_, 2, 14),
                                            nls_
                                           ),
                                    kv_, cntr_, spcnt_, s180_, k081_, k092_, sdos_,
                                    skos_, mdate_, k112_, r013_, d020_, isp_, se_, acc_
                                   );
                   else
                      INSERT INTO RNBU_HISTORY
                                   (odate,
                                    nls,
                                    kv, CODCAGENT, ints, s180, k081, k092, dos,
                                    kos, mdate, k112, mb, d020, isp, ost, acc
                                   )
                            VALUES (dat_,
                                    DECODE (SUBSTR (nls_, 1, 1),
                                            'X', SUBSTR (nls_, 2, 14),
                                            nls_
                                           ),
                                    kv_, cntr_, spcnt_, s180_, k081_, k092_, sdos_,
                                    skos_, mdate_, k112_, r011_, d020_, isp_, se_, acc_
                                   );
                   end if;
                END IF;
             END IF;

             -- ���������� �������
             IF mfou_ not in (300465) and
                  (nbs_ = '2620' AND r013_ in ('1','2','3') OR
                   nbs_ = '2625' AND r013_ = '2') AND
                   se_ >= 0 and skos_ > 0 and dat_ < dat_izm1
                     OR
                mfou_ not in (300465) and
                  (nbs_  in ('2620', '2625') AND r011_ = '3') AND
                   se_ >= 0 and skos_ > 0 and dat_ >= dat_izm1
                     OR
                mfou_  in (300465) and
                   nbs_ = '2620' AND se_ >= 0 and skos_ > 0 and
                   ob22_ in ('14','15','18','23','24','25','26','27')
                     OR
                mfou_ not in (300465) and
                   nbs_ = '2625' and se_ >= 0 and skos_ > 0 and spcnt_ <> 0
                    OR
                (nbs_ NOT IN ('1500','1600','2600','2605',
                              '2620','2625','2630','2635','2650','2655') and skos_ > 0 )
                     OR
                (nbs_ = '2600' and r013_  in ('1','7','8','A') and skos_ > 0)
                 and dat_ < dat_izm1
                     OR
                (nbs_ in ('2600', '2605','2620','2625','2650','2655') and r011_  = '3' and skos_ > 0)
                 and dat_ >= dat_izm1
                     OR
                mfou_ not in (300465) and
                   nbs_ IN ('2630', '2635') and skos_ > 0
                     OR
                mfou_  in (300465) and
                   ((nbs_ = '2630' AND se_ >= 0 and skos_ > 0 and ob22_ not in ('46')) or
                    (nbs_ = '2635' AND se_ >= 0 and skos_ > 0 and ob22_ not in ('38')))
                    OR
                (mfou_ <> 300465 and
                   (nbs_ = '2605' AND r013_ in ('1','3') OR
                    nbs_ = '2655' AND r013_ = '3') and skos_ > 0) and
                 dat_ < dat_izm1
                     OR
                (mfou_ <> 300465 and
                   (nbs_ in ('2605', '2655') AND r011_ = '3') and skos_ > 0) and
                 dat_ >= dat_izm1
                     OR
                 mfou_ in (300465) and
                   ((nbs_ = '2605' and r013_ in ('1','3') and skos_ > 0 and spcnt_ <> 0)   OR
                    (nbs_ = '2655' and r013_ = '3' and skos_ > 0) ) and
                    dat_ < dat_izm1
                     OR
                 mfou_ in (300465) and
                   ((nbs_ ='2605' and r011_ = '3' and skos_ > 0 and spcnt_ <> 0)   OR
                    (nbs_ = '2655' and r011_ = '3' and skos_ > 0) ) and
                    dat_ >= dat_izm1
                     OR
                (nbs_ = '2650' and r013_ in ('1','3','8') and skos_ > 0) and
                dat_ < dat_izm1
                     OR
                (nbs_ = '2650' and r011_ = '3' and skos_ > 0) and
                dat_ >= dat_izm1
             THEN
                if nbs_ in ('2610','2611','2615','2616','2617','2630','2635',
                            '2636','2637','2651','2652','2653','2656') and
                   (r013_ is null OR r013_='0' OR r013_ not in ('1','9'))
                then
                   if mdate_ is null OR mdate_ > Dat_ then
                      r013_ := '9';
                   end if;

                   if mdate_ is not null AND mdate_ <= Dat_ then
                      r013_ := '1';
                   end if;
                end if;

                -- ������� ����� ���.���
                IF nbs_ IN ('2620', '2625') THEN
                   d020_ := '01';

                   IF nbs_ = '2620' and r013p_ in ('1','2','3') OR
                      nbs_ = '2625' and r013p_ = '2'
                   THEN
                      --- ��������� �������� �������
                      vost_ := se_ + sdos_ - skos_;

                      --- ���� ��.������� ��� ��������� (���������)
                      IF vost_ < 0 THEN
                         skos_ := skos_ - ABS (vost_);
                      -- ������ ������ ����. ������� (- ��������� ����������)
                      END IF;
                   ELSE
                      skos_ := 0;
                   END IF;
                END IF;

                BEGIN
                   SELECT NVL(SUM(s*100), 0)
                     INTO vost_
                   FROM tmp_file03
                   WHERE FDAT = data_
                     AND acck=acc_
                     AND nlsd LIKE nbs_ || '%';

                  -- 02/12/2010 OAB: �� ��������� ���������� � 2600 �������� ����� �� 2600 ����������
                   if nbs_ = '2600' then
                      vost_ := 0;

                      SELECT NVL(SUM(t.s*100), 0)
                        INTO vost_
                      FROM tmp_file03 t, specparam s
                      WHERE t.FDAT = data_
                        AND t.acck=acc_
                        AND t.nlsd LIKE nbs_ || '%'
                        AND t.accd = s.acc
                        AND NVL(s.r011,'0') = '3';
                   end if;

                  -- 14/07/2014 OAB: �� ��������� ���������� � 2620 �������� ����� �� 2620 ����������
                   if nbs_ = '2620' then
                      vost_ := 0;

                      SELECT NVL(SUM(t.s*100), 0)
                        INTO vost_
                      FROM tmp_file03 t, specparam s
                      WHERE t.FDAT = data_
                        AND t.acck=acc_
                        AND t.nlsd LIKE nbs_ || '%'
                        AND t.accd = s.acc
                        AND NVL(s.r011,'0') = '3';
                   end if;

                   if nbs_ = '2620' and mfou_ = 300465 then
                      vost_ := 0;

                      SELECT NVL(SUM(t.s*100), 0)
                        INTO vost_
                      FROM tmp_file03 t, specparam_int si
                      WHERE t.FDAT = data_
                        AND t.acck=acc_
                        AND t.nlsd LIKE nbs_ || '%'
                        AND t.accd = si.acc
                        AND NVL(si.ob22,'00') in ('14','15','18','23','24','25','26','27')
                        AND not exists (select 1 from specparam s
                                        where s.acc = t.accd
                                          and NVL(s.r013,'0') in ('1','2','3'));
                   end if;

                  -- 03/08/2016 OAB: �� ��������� ���������� � 2650 �������� ����� �� 2650 ����������
                  if nbs_ = '2650' then
                     vost_ := 0;

                     SELECT NVL(SUM(t.s*100), 0)
                        INTO vost_
                     FROM tmp_file03 t, specparam s
                     WHERE t.FDAT = data_
                       AND t.acck=acc_
                       AND t.nlsd LIKE nbs_ || '%'
                       AND t.accd = s.acc
                       AND NVL(s.r013,'0') in ('1','3','8');
                  end if;

                  if vost_ <> 0 then
                     p_ins_del (acc_, nls_, kv_, '(������ ������)', skos_, vost_);

                     p_ins_log (   '(������ ������) DK=1 r020='''
                                || nbs_
                                || ''' ���� (OB22)='''
                                || nls_ || ' (' || ob22_ || ')'
                                || ''' ���='''
                                || kv_
                                || ''' ����='''
                                || data_
                                || ''' �����=',
                                vost_);
                  end if;
                EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                  vost_ := 0;
                END;

                if mfo_ = 344443 and nbs_ like '16%' then
                   -- ������� 17.10.2014 �.�. ����� �� �� �������� ���������� ��
                   sdos_ := sdos_ - vost_;
                end if;
               -------------------------------------------------------------
                skos_ := skos_ - vost_;

                IF mfou_ in (300465) THEN
                   BEGIN
                      vost_ := 0;
                      -- 15.01.2010 ����� �������� ������� ������ �����������
                      SELECT NVL(SUM(t.s*100), 0)
                         INTO vost_
                      FROM tmp_file03 t
                      WHERE t.TT='R01'
                        AND t.FDAT = data_
                        and t.acck = acc_
                        and exists (select 1
                                    from oper o
                                    where o.ref = t.ref
                                      and o.nlsa like '3739%'
                                      and o.mfoa <> o.mfob
                                      and exists (select 1
                                                  from banks r
                                                  where r.mfo=o.mfoa
                                                    and r.mfou=mfou_)
                                      and exists (select 1
                                                  from banks r1
                                                  where r1.mfo=o.mfob
                                                    and r1.mfou=mfou_));

                      p_ins_del (acc_, nls_, kv_, '(�������� R01)', skos_, vost_);

                      p_ins_log (   '(�������� R01) DK=1 r020='''
                                 || nbs_
                                 || ''' ���� (OB22)='''
                                 || nls_ || ' (' || ob22_ || ')'
                                 || ''' ���='''
                                 || kv_
                                 || ''' ����='''
                                 || data_
                                 || ''' �����=',
                                 vost_);
                   EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                      vost_ := 0;
                   END;

                   skos_ := skos_ - vost_;
                END IF;

                IF mfou_ = 300465 AND nbs_ like '26%' THEN
                   BEGIN
                      -- 15.01.2010 ����� �������� ������� ������ �����������
                      SELECT NVL(SUM(s*100), 0)
                         INTO vost_
                      FROM tmp_file03
                      WHERE FDAT = data_
                        AND acck = acc_
                        AND nlsd LIKE '3739%'
                        AND lower(nazn) like '%���������� �������%';

                      p_ins_del (acc_, nls_, kv_, '(� 3739 �� 26 ����� ������� ����)', skos_, vost_);

                      p_ins_log (   '(� 3739 �� 26 ����� ����������� ������� ����) DK=1 r020='''
                                 || nbs_
                                 || ''' ���� (OB22)='''
                                 || nls_ || ' (' || ob22_ || ')'
                                 || ''' ���='''
                                 || kv_
                                 || ''' ����='''
                                 || data_
                                 || ''' �����=',
                                 vost_);
                   EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                      vost_ := 0;
                   END;

                   skos_ := skos_ - vost_;

                   BEGIN
                      -- 15.01.2010 ����� �������� ������� ������ �����������
                      SELECT NVL(SUM(s*100), 0)
                         INTO vost_
                      FROM tmp_file03
                      WHERE FDAT = data_
                        AND acck = acc_
                        AND nlsd LIKE '3739%'
                        AND (lower(nazn) like '%�_����_�%' or
                             lower(nazn) like '%�����_�%' or
                             lower(nazn) like '%��_�_%�����%�_�__%' or
                             lower(nazn) like '%���������� �������%' or
                             lower(nazn) like '%���������%� ����� � ���������%' or
                             lower(nazn) like '%�_�����%�����_��%����_��%'
                            );

                      p_ins_del (acc_, nls_, kv_, '(� 3739 �� 26 ����� ������� �� �������)', skos_, vost_);

                      p_ins_log (   '(� 3739 �� 26 ����� ������� �� �������) DK=1 r020='''
                                 || nbs_
                                 || ''' ���� (OB22)='''
                                 || nls_ || ' (' || ob22_ || ')'
                                 || ''' ���='''
                                 || kv_
                                 || ''' ����='''
                                 || data_
                                 || ''' �����=',
                                 vost_);
                   EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                      vost_ := 0;
                   END;

                   skos_ := skos_ - vost_;

                   BEGIN
                      SELECT NVL(SUM(s*100), 0)
                         INTO vost_
                      FROM tmp_file03
                      WHERE FDAT = data_
                        AND acck = acc_
                        AND nlsd LIKE '6%';

                      p_ins_del (acc_, nls_, kv_, '(� 6 ����� �� 26 ����� �����������)', skos_, vost_);

                      p_ins_log (   '(� 6 ����� �� 26 ����� �����������) DK=1 r020='''
                                 || nbs_
                                 || ''' ���� (OB22)='''
                                 || nls_ || ' (' || ob22_ || ')'
                                 || ''' ���='''
                                 || kv_
                                 || ''' ����='''
                                 || data_
                                 || ''' �����=',
                                 vost_);
                   EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                      vost_ := 0;
                   END;

                   skos_ := skos_ - vost_;
                END IF;

                BEGIN
                   poisk_ := '02%';

                   -- ��������� ������� ����������� D020='02'
                   -- 15.01.2010 ����� �������� ������� ������ �����������
                   SELECT NVL(SUM(p.s*100), 0)
                      INTO s_prol_
                   FROM tmp_file03 p, OPERW o
                   WHERE p.FDAT = data_
                     AND p.acck=acc_
                     AND p.REF=o.REF
                     AND o.tag LIKE 'D020%'
                     AND o.value LIKE poisk_;

                   p_ins_del (acc_, nls_, kv_, '(D020=''02'')', skos_, s_prol_);

                   p_ins_log (   '(�����������) DK=1 r020='''
                              || nbs_
                              || ''' ���� (OB22)='''
                              || nls_ || ' (' || ob22_ || ')'
                              || ''' ���='''
                              || kv_
                              || ''' ����='''
                              || data_
                              || ''' �����=',
                              s_prol_);
                EXCEPTION WHEN NO_DATA_FOUND THEN
                      s_prol_ := 0;
                END;

                s_prol_02k := s_prol_;
                skos_ := skos_ - s_prol_;

                BEGIN
                   poisk_ := 'ZZ%';

                   -- ���� ��� �� ������ ������� � �� �����������, � "_���"
                   -- 15.01.2010 ����� �������� ������� ������ �����������
                   SELECT NVL(SUM(p.s*100), 0)
                      INTO vost_
                   FROM tmp_file03 p, OPERW o
                   WHERE p.FDAT = data_
                     AND p.acck=acc_
                     AND p.REF=o.REF
                     AND o.tag LIKE 'D020%'
                     AND o.value LIKE poisk_;

                   p_ins_del (acc_, nls_, kv_, '(D020=''ZZ'')', skos_,  vost_);

                   p_ins_log (   '(�����������) DK=1 r020='''
                              || nbs_
                              || ''' ���� (OB22)='''
                              || nls_ || ' (' || ob22_ || ')'
                              || ''' ���='''
                              || kv_
                              || ''' ����='''
                              || data_
                              || ''' �����=',
                              vost_);
                EXCEPTION
                   WHEN NO_DATA_FOUND
                   THEN
                      vost_ := 0;
                END;

                -- �������� "_���"
                skos_ := skos_ - vost_;

                BEGIN
                   poisk_ := '03%';

                   -- ���� ��� �� ������ ������� � �� �����������, � "��������� %% ������"
                   -- 15.01.2010 ����� �������� ������� ������ �����������
                   SELECT NVL(SUM(p.s*100), 0)
                      INTO vost_
                   FROM tmp_file03 p, OPERW o
                   WHERE p.FDAT = data_
                     AND p.acck=acc_
                     AND p.REF=o.REF
                     AND o.tag LIKE 'D020%'
                     AND o.value LIKE poisk_;

                   p_ins_del (acc_, nls_, kv_, '(D020=''03'')', skos_,  vost_);

                   p_ins_log (   '(�����������) DK=1 r020='''
                              || nbs_
                              || ''' ���� (OB22)='''
                              || nls_ || ' (' || ob22_ || ')'
                              || ''' ���='''
                              || kv_
                              || ''' ����='''
                              || data_
                              || ''' �����=',
                              vost_);
                EXCEPTION
                   WHEN NO_DATA_FOUND
                   THEN
                      vost_ := 0;
                END;

                -- �������� "��������� %% ������"
                s_prol_03k := vost_;
                skos_ := skos_ - vost_;

                IF mfou_ in (300465) AND nbs_ IN ('2620','2625','2630','2635')
                THEN
                   BEGIN
                      vost_ := 0;
                      -- 15.01.2010 ����� �������� ������� ������ �����������
                      SELECT NVL(SUM(s*100), 0)  --NVL (SUM (Gl.P_Icurval (kv, s * 100, FDAT)), 0)
                         INTO vost_
                      FROM tmp_file03
                      WHERE TT='���'
                        AND FDAT = data_
                        and acck = acc_;

                      p_ins_del (acc_, nls_, kv_, '(�������� ���)', skos_,  vost_);

                      p_ins_log (   '(�������� ���) DK=1 r020='''
                                 || nbs_
                                 || ''' ���� (OB22)='''
                                 || nls_ || ' (' || ob22_ || ')'
                                 || ''' ���='''
                                 || kv_
                                 || ''' ����='''
                                 || data_
                                 || ''' �����=',
                                 vost_);
                   EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                      vost_ := 0;
                   END;

                   skos_ := skos_ - vost_;
                END IF;

                IF mfou_ = 300465
                THEN
                   BEGIN
                      vost_ := 0;
                      -- 15.01.2010 ����� �������� ������� ������ �����������
                      SELECT NVL(SUM(t.s*100), 0)
                         INTO vost_
                      FROM tmp_file03 t
                      WHERE t.TT='024'
                        AND t.FDAT = data_
                        and t.acck = acc_
                        and exists (select 1
                                    from oper o
                                    where o.ref = t.ref and
                                          (o.mfoa <> o.mfob or
                                           lower(o.nazn) like '%����������� �������%'));

                      p_ins_del (acc_, nls_, kv_, '(�������� 024)', skos_,  vost_);

                      p_ins_log (   '(�������� 024) DK=1 r020='''
                                 || nbs_
                                 || ''' ���� (OB22)='''
                                 || nls_ || ' (' || ob22_ || ')'
                                 || ''' ���='''
                                 || kv_
                                 || ''' ����='''
                                 || data_
                                 || ''' �����=',
                                 vost_);
                   EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                      vost_ := 0;
                   END;

                   skos_ := skos_ - vost_;
                END IF;

                if nbs_ not like '161%' and nbs_ not like '162%'
                then
                   if (mfou_ = 300465 and
                          (substr(nbs_,1,3) in ('260', '261', '262', '263')
                           and tips_ <> 'ODB')
                        or
                       mfou_ <> 300465)
                   then

                      vost_ := sdos_;

                      p_ins_del (acc_, nls_, kv_, '(����� ��������)', skos_,  vost_);

                      p_ins_log (   '(����� �������� ��� �������� DPG) DK=1 r020='''
                                 || nbs_
                                 || ''' ���� (OB22)='''
                                 || nls_ || ' (' || ob22_ || ')'
                                 || ''' ���='''
                                 || kv_
                                 || ''' ����='''
                                 || data_
                                 || ''' �����=',
                                 vost_);

                     skos_ := skos_ - vost_;

                   end if;
                end if;

                vost_ := 0;

                -- 05.01.2010 ��� ���� ������ �� �� �������� ��������
                -- ������������� ���������
                -- ��� ��������� �������� �� �� �������� ������������� ���������
                -- �������� ���� �� 2608 ---> �� 2600, �� 2628 ---> �� 2620, �� 2638 ---> �� 2630,2635
                -- c 19/11/2013 �� ��������� ��� ����� ��������� �� '2650','2651','2652'
                IF nbs_ IN ('1610','1612','1615','2546','2600','2610','2615',
                            '2620','2630','2635','2650','2651','2652')
                THEN
                   vost_ := 0;

                   BEGIN
                      case
                      when nbs_ in ('1610', '1612', '1615') then
                          poisk_ := '1618%';
                      when nbs_ in ('2546') then
                          poisk_ := '2548%';
                      when nbs_ in ('2600') then
                          poisk_ := '2608%';
                      when nbs_ in ('2610', '2615') then
                          poisk_ := '2618%';
                      when nbs_ in ('2620') then
                          poisk_ := '2628%';
                      when nbs_ in ('2630', '2635') then
                          poisk_ := '26_8%';
                      when nbs_ in ('2650', '2651', '2652') then
                          poisk_ := '2658%';
                      else
                         poisk_ := null;
                         vost_ := 0;
                      end case;

                      if poisk_ is not null
                      then
                          -- 15.01.2010 ����� �������� ������� ������ �����������
                          SELECT NVL(SUM(s*100), 0)
                             INTO vost_
                          FROM tmp_file03
                          WHERE FDAT = data_
                            AND acck = acc_
                            AND nlsd LIKE poisk_;

                          if mfou_ = 300465 and nbs_ in ('2610', '2615', '2650', '2651', '2652') and vost_ = 0
                          then

                             SELECT NVL(SUM(t.s*100), 0)
                                INTO vost_
                             FROM tmp_file03 t
                             WHERE t.FDAT = data_
                               AND t.acck = acc_
                               AND t.nlsd LIKE '3739%'
                               AND t.nlsk LIKE nls_ || '%'
                               AND exists ( select 1 from oper o
                                            where o.ref = t.ref
                                              and (o.nlsa like '2618%' or o.nlsa like '2658%')
                                              and o.nlsb like nbs_ || '%'
                                              and o.s = t.s*100
                                          );
                          end if;

                          p_ins_del (acc_, nls_, kv_, '(�������������)', skos_,  vost_);

                          p_ins_log (   '(�������������) DK=1 r020='''
                                 || nbs_
                                 || ''' ���� (OB22)='''
                                 || nls_ || ' (' || ob22_ || ')'
                                 || ''' ���='''
                                 || kv_
                                 || ''' ����='''
                                 || data_
                                 || ''' �����=',
                                 vost_);
                      end if;
                   EXCEPTION
                      WHEN NO_DATA_FOUND
                      THEN
                         vost_ := 0;
                   END;

                   skos_ := skos_ - vost_;

                   vost_ := 0;

                   BEGIN
                      case
                      when nbs_ in ('2620') then
                          poisk_ := '2630%';
                      else
                          poisk_ := null;
                          vost_ := 0;
                      end case;

                      if mfou_ not in (300120) and poisk_ is not null then
                         -- 15.01.2010 ����� �������� ������� ������ �����������
                         SELECT NVL(SUM(s*100), 0)
                            INTO vost_
                         FROM tmp_file03
                         WHERE FDAT = data_
                           AND acck = acc_
                           AND nlsd LIKE poisk_;

                         p_ins_del (acc_, nls_, kv_, '(� 2630 �� 2620)', skos_,  vost_);

                         p_ins_log (   '(� 2630 �� 2620) DK=1 r020='''
                                    || nbs_
                                    || ''' ���� (OB22)='''
                                    || nls_ || ' (' || ob22_ || ')'
                                    || ''' ���='''
                                    || kv_
                                    || ''' ����='''
                                    || data_
                                    || ''' �����=',
                                    vost_);
                      end if;
                   EXCEPTION
                         WHEN NO_DATA_FOUND
                   THEN
                      vost_ := 0;
                   END;

                   skos_ := skos_ - vost_;

                   vost_ := 0;

                   BEGIN
                      case
                      when nbs_ in ('2620') then
                          poisk_ := '2635%';
                      else
                         poisk_ := null;
                         vost_ := 0;
                      end case;

                      if mfou_ not in (300120) and poisk_ is not null then
                         -- 15.01.2010 ����� �������� ������� ������ �����������
                         SELECT NVL(SUM(s*100), 0)
                            INTO vost_
                         FROM tmp_file03
                         WHERE FDAT = data_
                           AND acck = acc_
                           AND nlsd LIKE poisk_;

                         p_ins_del (acc_, nls_, kv_, '(� 2635 �� 2620)', skos_,  vost_);

                         p_ins_log (   '(� 2635 �� 2620) DK=1 r020='''
                                    || nbs_
                                    || ''' ���� (OB22)='''
                                    || nls_ || ' (' || ob22_ || ')'
                                    || ''' ���='''
                                    || kv_
                                    || ''' ����='''
                                    || data_
                                    || ''' �����=',
                                    vost_);
                      end if;
                   EXCEPTION
                          WHEN NO_DATA_FOUND
                   THEN
                      vost_ := 0;
                   END;

                   skos_ := skos_ - vost_;

                   vost_ := 0;

                   BEGIN
                      case
                      when nbs_ in ('2620') then
                          poisk_ := '2638%';
                      else
                          poisk_ := null;
                          vost_ := 0;
                      end case;

                      if poisk_ is not null and mfo_ <> 300120 then
                         -- 15.01.2010 ����� �������� ������� ������ �����������
                         SELECT NVL(SUM(s*100), 0)
                            INTO vost_
                         FROM tmp_file03
                         WHERE FDAT = data_
                           AND acck = acc_
                           AND nlsd LIKE poisk_;

                         p_ins_del (acc_, nls_, kv_, '(� 2638 �� 2620)', skos_,  vost_);

                         p_ins_log (   '(� 2638 �� 2620) DK=1 r020='''
                                    || nbs_
                                    || ''' ���� (OB22)='''
                                    || nls_ || ' (' || ob22_ || ')'
                                    || ''' ���='''
                                    || kv_
                                    || ''' ����='''
                                    || data_
                                    || ''' �����=',
                                    vost_);
                      end if;
                   EXCEPTION
                         WHEN NO_DATA_FOUND
                      THEN
                      vost_ := 0;
                   END;

                   skos_ := skos_ - vost_;

                   vost_ := 0;

                   BEGIN
                      case
                         when nbs_ in ('2620') then
                         poisk_ := '7040%';
                      else
                         poisk_ := null;
                         vost_ := 0;
                      end case;

                      if poisk_ is not null then
                         -- 15.01.2010 ����� �������� ������� ������ �����������
                         SELECT NVL(SUM(s*100), 0)
                            INTO vost_
                         FROM tmp_file03
                         WHERE FDAT = data_
                           AND acck = acc_
                           AND nlsd LIKE poisk_;

                         p_ins_del (acc_, nls_, kv_, '(� 7040 �� 2620)', skos_,  vost_);

                         p_ins_log (   '(� 7040 �� 2620) DK=1 r020='''
                                    || nbs_
                                    || ''' ���� (OB22)='''
                                    || nls_ || ' (' || ob22_ || ')'
                                    || ''' ���='''
                                    || kv_
                                    || ''' ����='''
                                    || data_
                                    || ''' �����=',
                                    vost_);
                      end if;
                   EXCEPTION
                         WHEN NO_DATA_FOUND
                   THEN
                      vost_ := 0;
                   END;

                   skos_ := skos_ - vost_;
                   vost_ := 0;

                   BEGIN
                      case
                         when nbs_ in ('2630','2635') then
                         poisk_ := '704%';
                      else
                         poisk_ := null;
                         vost_ := 0;
                      end case;

                      if poisk_ is not null then
                         -- 15.01.2010 ����� �������� ������� ������ �����������
                         SELECT NVL(SUM(s*100), 0)
                            INTO vost_
                         FROM tmp_file03
                         WHERE FDAT = data_
                           AND acck = acc_
                           AND nlsd LIKE poisk_;

                         p_ins_del (acc_, nls_, kv_, '(� 704  �� ' || nbs_|| ')', skos_,  vost_);

                         p_ins_log (   '(� 704 �� ' || nbs_ || ') DK=1 r020='''
                                    || nbs_
                                    || ''' ���� (OB22)='''
                                    || nls_ || ' (' || ob22_ || ')'
                                    || ''' ���='''
                                    || kv_
                                    || ''' ����='''
                                    || data_
                                    || ''' �����=',
                                    vost_);
                      end if;
                   EXCEPTION
                         WHEN NO_DATA_FOUND
                   THEN
                      vost_ := 0;
                   END;

                   skos_ := skos_ - vost_;
                   vost_ := 0;

                   BEGIN
                      case
                         when nbs_ in ('2630','2635') then
                         poisk_ := '355%';
                      else
                         poisk_ := null;
                         vost_ := 0;
                      end case;

                      if poisk_ is not null then
                         -- 15.01.2010 ����� �������� ������� ������ �����������
                         SELECT NVL(SUM(s*100), 0)
                            INTO vost_
                         FROM tmp_file03
                         WHERE FDAT = data_
                           AND acck = acc_
                           AND nlsd LIKE poisk_;

                         p_ins_del (acc_, nls_, kv_, '(� 355 �� ' || nbs_ ||')', skos_,  vost_);

                         p_ins_log (   '(� 355 �� ' || nbs_ || ') DK=1 r020='''
                                    || nbs_
                                    || ''' ���� (OB22)='''
                                    || nls_ || ' (' || ob22_ || ')'
                                    || ''' ���='''
                                    || kv_
                                    || ''' ����='''
                                    || data_
                                    || ''' �����=',
                                    vost_);
                      end if;
                   EXCEPTION
                         WHEN NO_DATA_FOUND
                   THEN
                      vost_ := 0;
                   END;

                   skos_ := skos_ - vost_;
                   vost_ := 0;

                   if mfou_ in (300465) and mfo_ != mfou_ then
                      BEGIN
                         case
                         when nbs_ in ('2630', '2635') then
                             poisk_ := '2620%';
                         else
                            poisk_ := null;
                            vost_ := 0;
                         end case;

                         if poisk_ is not null then
                            BEGIN
                               -- 15.01.2010 ����� �������� ������� ������ �����������
                               SELECT NVL(SUM(s*100), 0)
                                  INTO vost_
                               FROM tmp_file03 t
                               WHERE FDAT = data_
                                 AND nlsd LIKE poisk_
                                 and acck = acc_
                                 and exists ( select 1
                                              from specparam_int s
                                              where s.acc = t.accd
                                                and NVL(s.ob22,'00') in ('14','15','18','23',
                                                                         '24','25','26','27')
                                            );

                               p_ins_del (acc_, nls_, kv_, '(� '||nbs_||' �� 2620)', skos_,  vost_);

                               p_ins_log (   '(� 2620 �� ' || nbs_ || ') DK=1 r020='''
                                          || nbs_
                                          || ''' ���� (OB22)='''
                                          || nls_ || ' (' || ob22_ || ')'
                                          || ''' ���='''
                                          || kv_
                                          || ''' ����='''
                                          || data_
                                          || ''' �����=',
                                          vost_);
                            EXCEPTION
                               WHEN NO_DATA_FOUND
                             THEN
                               vost_ := 0;
                            END;
                         end if;
                      EXCEPTION
                         WHEN NO_DATA_FOUND
                       THEN
                         vost_ := 0;
                      END;

                      skos_ := skos_ - vost_;

                      vost_ := 0;

                      BEGIN
                         case
                         when nbs_ in ('2625') then
                             poisk_ := '2202%';
                         else
                            poisk_ := null;
                            vost_ := 0;
                         end case;

                         if poisk_ is not null then
                             -- 15.01.2010 ����� �������� ������� ������ �����������
                             SELECT NVL(SUM(s*100), 0)
                                INTO vost_
                             FROM tmp_file03
                             WHERE FDAT = data_
                               AND nlsd LIKE poisk_
                               and acck = acc_;

                           p_ins_del (acc_, nls_, kv_, '(� 2625 �� 2202)', skos_,  vost_);

                           p_ins_log (   '(� 2625 �� 2202) DK=1 r020='''
                                      || nbs_
                                      || ''' ����='''
                                      || nls_
                                      || ''' ���='''
                                      || kv_
                                      || ''' ����='''
                                      || data_
                                      || ''' �����=',
                                      vost_);
                         end if;
                      EXCEPTION
                         WHEN NO_DATA_FOUND
                       THEN
                         vost_ := 0;
                      END;

                      skos_ := skos_ - vost_;

                      vost_ := 0;

                      BEGIN
                         case
                         when nbs_ in ('2625') then
                             poisk_ := '2203%';
                         else
                            poisk_ := null;
                            vost_ := 0;
                         end case;

                         if poisk_ is not null then
                             -- 15.01.2010 ����� �������� ������� ������ �����������
                             SELECT NVL(SUM(s*100), 0)
                                INTO vost_
                             FROM tmp_file03
                             WHERE FDAT = data_
                               AND nlsd LIKE poisk_
                               and acck = acc_;

                           p_ins_del (acc_, nls_, kv_, '(� 2625 �� 2203)', skos_,  vost_);

                           p_ins_log (   '(� 2625 �� 2203) DK=1 r020='''
                                      || nbs_
                                      || ''' ����='''
                                      || nls_
                                      || ''' ���='''
                                      || kv_
                                      || ''' ����='''
                                      || data_
                                      || ''' �����=',
                                      vost_);
                         end if;
                      EXCEPTION
                         WHEN NO_DATA_FOUND
                       THEN
                         vost_ := 0;
                      END;

                      skos_ := skos_ - vost_;

                      vost_ := 0;

                      BEGIN
                         case
                         when nbs_ in ('2625') then
                             poisk_ := '2924%';
                         else
                            poisk_ := null;
                            vost_ := 0;
                         end case;

                         if poisk_ is not null then
                             -- 15.01.2010 ����� �������� ������� ������ �����������
                             SELECT NVL(SUM(s*100), 0)
                                INTO vost_
                             FROM tmp_file03
                             WHERE FDAT = data_
                               AND nlsd LIKE poisk_
                               and acck = acc_;

                           p_ins_del (acc_, nls_, kv_, '(� 2625 �� 2924)', skos_,  vost_);

                           p_ins_log (   '(� 2625 �� 2924) DK=1 r020='''
                                      || nbs_
                                      || ''' ����='''
                                      || nls_
                                      || ''' ���='''
                                      || kv_
                                      || ''' ����='''
                                      || data_
                                      || ''' �����=',
                                      vost_);
                         end if;
                      EXCEPTION
                         WHEN NO_DATA_FOUND
                       THEN
                         vost_ := 0;
                      END;

                      skos_ := skos_ - vost_;

                      vost_ := 0;

                      BEGIN
                         case
                         when nbs_ in ('2635') then
                             poisk_ := '2630%';
                         else
                            poisk_ := null;
                            vost_ := 0;
                         end case;

                         if poisk_ is not null then
                             -- 15.01.2010 ����� �������� ������� ������ �����������
                             SELECT NVL(SUM(s*100), 0)
                                INTO vost_
                             FROM tmp_file03
                             WHERE FDAT = data_
                               AND nlsd LIKE poisk_
                               and acck = acc_;

                           p_ins_del (acc_, nls_, kv_, '(� 2635 �� 2630)', skos_,  vost_);

                           p_ins_log (   '(c 2635 �� 2630) DK=1 r020='''
                                      || nbs_
                                      || ''' ���� (OB22)='''
                                      || nls_ || ' (' || ob22_ || ')'
                                      || ''' ���='''
                                      || kv_
                                      || ''' ����='''
                                      || data_
                                      || ''' �����=',
                                      vost_);
                         end if;
                      EXCEPTION
                         WHEN NO_DATA_FOUND
                       THEN
                         vost_ := 0;
                      END;

                      skos_ := skos_ - vost_;

                      vost_ := 0;

                      BEGIN
                         case
                         when nbs_ in ('2630') then
                             poisk_ := '2635%';
                         else
                            poisk_ := null;
                            vost_ := 0;
                         end case;

                         if poisk_ is not null then
                             -- 15.01.2010 ����� �������� ������� ������ �����������
                             SELECT NVL(SUM(s*100), 0)
                                INTO vost_
                             FROM tmp_file03
                             WHERE FDAT = data_
                               AND nlsd LIKE poisk_
                               and acck = acc_;

                           p_ins_del (acc_, nls_, kv_, '(� 2630 �� 2635)', skos_,  vost_);

                           p_ins_log (   '(� 2630 �� 2635) DK=1 r020='''
                                      || nbs_
                                      || ''' ���� (OB22)='''
                                      || nls_ || ' (' || ob22_ || ')'
                                      || ''' ���='''
                                      || kv_
                                      || ''' ����='''
                                      || data_
                                      || ''' �����=',
                                      vost_);
                         end if;
                      EXCEPTION
                         WHEN NO_DATA_FOUND
                       THEN
                         vost_ := 0;
                      END;

                      skos_ := skos_ - vost_;

                      vost_ := 0;

                      BEGIN
                         case
                         when nbs_ in ('2630', '2635') then
                            poisk_ := '2909%';
                         else
                            poisk_ := null;
                            vost_ := 0;
                         end case;

                         if poisk_ is not null then
                            -- 15.01.2010 ����� �������� ������� ������ �����������
                            SELECT NVL(SUM(s*100), 0)
                               INTO vost_
                            FROM tmp_file03
                            WHERE FDAT = data_
                              AND nlsd LIKE poisk_
                              and acck = acc_
                              and accd in (select acc
                                           from specparam_int
                                           where acc in (select acc
                                                         from accounts
                                                         where nbs='2909')
                                             and ob22 = '18')
                              and lower(nazn) not like '%�����%'
                                             ;

                           p_ins_del (acc_, nls_, kv_, '(� '||nbs_||' �� 2909)', skos_,  vost_);

                           p_ins_log (   '(� '||nbs_||' �� 2909) DK=1 r020='''
                                      || nbs_
                                      || ''' ���� (OB22)='''
                                      || nls_ || ' (' || ob22_ || ')'
                                      || ''' ���='''
                                      || kv_
                                      || ''' ����='''
                                      || data_
                                      || ''' �����=',
                                      vost_);
                         end if;
                      EXCEPTION
                         WHEN NO_DATA_FOUND
                      THEN
                         vost_ := 0;
                      END;

                      skos_ := skos_ - vost_;
                   end if;

                END IF;

                IF (  (nbs_ = '2620' AND ob22_ IN ('08', '09', '11', '12'))
                   OR (nbs_ = '2630' AND ob22_ IN ('11', '12', '13', '14','B2','B3','B4','B5'))
                   OR (nbs_ = '2635' AND ob22_ IN ('13', '14', '15', '16'))
                  )
                THEN
                   vost_ := 0;

                   BEGIN
                     poisk_ := nbs_ || '%';

                     -- 15.01.2010 ����� �������� ������� ������ �����������
                     SELECT NVL(SUM(s*100), 0)
                        INTO vost_
                     FROM tmp_file03
                     WHERE FDAT = data_
                       AND nlsd LIKE poisk_
                       and acck = acc_;

                     p_ins_del (acc_, nls_, kv_, '(������ ������ + ob22)', skos_,  vost_);

                     p_ins_log (   '(������ ������ + ob22) DK=1 r020='''
                                     || nbs_
                                     || ''' ���� (OB22)='''
                                     || nls_ || ' (' || ob22_ || ')'
                                     || ''' ���='''
                                     || kv_
                                     || ''' ����='''
                                     || data_
                                     || ''' �����=',
                                     vost_);

                   EXCEPTION
                      WHEN NO_DATA_FOUND
                      THEN
                         vost_ := 0;
                   END;

                   skos_ := skos_ - vost_;
                END IF;

                if skos_ > 0 then
                   vost_ := 0;

                   BEGIN
                     SELECT NVL(SUM(s*100), 0)
                        INTO vost_
                     FROM tmp_file03
                     WHERE FDAT = data_
                       and acck = acc_
                       AND lower(NAZN) like '%������%';

                     p_ins_del (acc_, nls_, kv_, '(�������� ������)', skos_,  vost_);

                     p_ins_log (   '(�������� ������) DK=1 r020='''
                                     || nbs_
                                     || ''' ���� (OB22)='''
                                     || nls_ || ' (' || ob22_ || ')'
                                     || ''' ���='''
                                     || kv_
                                     || ''' ����='''
                                     || data_
                                     || ''' �����=',
                                     vost_);

                   EXCEPTION
                      WHEN NO_DATA_FOUND
                      THEN
                         vost_ := 0;
                   END;

                   skos_ := skos_ - vost_;
                end if;

                IF nbs_ = '2625' AND pap_ = 1
                THEN
                  skos_ := 0;
                END IF;

                -- ���������� �������
                IF (skos_ > 0 AND r050_ = '22' and se_ >= 0) OR
                   (skos_ > 0 and se_ >= 0 and nbs_ in ('2600', '2605', '2620', '2625','2650', '2655') and r011_ = '3')
                THEN
                   skos_ := Gl.P_Icurval (kv_, skos_, data_);
                   cntr1_ := TO_CHAR (2 - cntr_);
 
                   if dat_ < dat_izm1
                   then
                      kodp_ :=
                         '6' || nbs_ || r013_ || s180_ || cntr1_ || d020_ || LPAD (kv_, 3, '0');
                   else
                      kodp_ :=
                         '6' || nbs_ || r011_ || s180_ || cntr1_ || d020_ || LPAD (kv_, 3, '0');
                   end if;

                   IF s180_ = '0'
                   THEN
                      nls_ := 'X' || nls_;
                   END IF;

                   IF ((mfou_ in (300465) and mfo_ != mfou_ and nbs_ in ('2620','2625') and spcnt_ <> 0) OR
                       (mfou_ in (300465) and mfo_ != mfou_ and nbs_ not in ('2620','2625')) OR
                       (mfou_ in (300465) and mfo_ = mfou_) ) OR
                       mfou_ not in (300465)
                   THEN
                      -- ��. �������
                      p_ins ('1' || kodp_, TO_CHAR (skos_));
                      -- %% ������
                      p_ins ('2' || kodp_, LTRIM (TO_CHAR (ROUND (spcnt_, 4), fmt_)));
                      -- ��.�������*%% ������
                      p_ins ('3' || kodp_, TO_CHAR (skos_*ROUND(spcnt_,4)));

                      if dat_ < dat_izm1
                      then
                         INSERT INTO RNBU_HISTORY
                                       (odate,
                                        nls,
                                        kv, CODCAGENT, ints, s180, k081, k092, dos,
                                        kos, mdate, k112, mb, d020, isp, ost, acc
                                       )
                                VALUES (dat_,
                                        DECODE (SUBSTR (nls_, 1, 1),
                                                'X', SUBSTR (nls_, 2, 14),
                                                nls_
                                               ),
                                        kv_, cntr_, spcnt_, s180_, k081_, k092_, sdos_,
                                        skos_, mdate_, k112_, r013_, d020_, isp_, se_, acc_
                                       );
                      else
                         INSERT INTO RNBU_HISTORY
                                       (odate,
                                        nls,
                                        kv, CODCAGENT, ints, s180, k081, k092, dos,
                                        kos, mdate, k112, mb, d020, isp, ost, acc
                                       )
                                VALUES (dat_,
                                        DECODE (SUBSTR (nls_, 1, 1),
                                                'X', SUBSTR (nls_, 2, 14),
                                                nls_
                                               ),
                                        kv_, cntr_, spcnt_, s180_, k081_, k092_, sdos_,
                                        skos_, mdate_, k112_, r011_, d020_, isp_, se_, acc_
                                       );
                      end if;
                   END IF;
                END IF;

                -- ������� �����������
                IF (s_prol_ > 0 AND r050_ = '22'  and se_ > 0) OR
                   (s_prol_ > 0 and se_ > 0 and nbs_ in ('2600', '2605', '2620', '2625','2650', '2655'))
                THEN
                   s_prol_ := Gl.P_Icurval (kv_, s_prol_, data_);
                   cntr1_ := TO_CHAR (2 - cntr_);

                   if dat_ < dat_izm1
                   then
                   kodp_ :=
                      '6' || nbs_ || r013_ || s180_ || cntr1_ || '02' || LPAD (kv_, 3, '0');
                   else
                   kodp_ :=
                      '6' || nbs_ || r011_ || s180_ || cntr1_ || '02' || LPAD (kv_, 3, '0');
                   end if;

                   IF s180_ = '0'
                   THEN
                      nls_ := 'X' || nls_;
                   END IF;

                   IF ((mfou_ in (300465) and mfou_ != mfo_ and nbs_ in ('2620','2625') and spcnt_ <> 0) OR
                       (mfou_ in (300465) and mfou_ != mfo_ and nbs_ not in ('2620','2625')) OR
                       (mfou_ in (300465) and mfou_ = mfo_ ) ) OR
                       mfou_ not in (300465)
                   THEN
                      -- ������� �����������
                      p_ins ('1' || kodp_, TO_CHAR (s_prol_));
                      -- %% ������
                      p_ins ('2' || kodp_, LTRIM (TO_CHAR (ROUND (spcnt_, 4), fmt_)));
                      -- ��.�������*%% ������
                      p_ins ('3' || kodp_, TO_CHAR (s_prol_*ROUND(spcnt_,4)));
                      skos_ := s_prol_;
                      d020_ := '02';

                      if dat_ < dat_izm1
                      then
                         INSERT INTO RNBU_HISTORY
                                       (odate,
                                        nls,
                                        kv, CODCAGENT, ints, s180, k081, k092, dos,
                                        kos, mdate, k112, mb, d020, isp, ost, acc
                                       )
                                VALUES (dat_,
                                        DECODE (SUBSTR (nls_, 1, 1),
                                                'X', SUBSTR (nls_, 2, 14),
                                                nls_
                                               ),
                                        kv_, cntr_, spcnt_, s180_, k081_, k092_, sdos_,
                                        skos_, mdate_, k112_, r013_, d020_, isp_, se_, acc_
                                        );
                      else
                         INSERT INTO RNBU_HISTORY
                                       (odate,
                                        nls,
                                        kv, CODCAGENT, ints, s180, k081, k092, dos,
                                        kos, mdate, k112, mb, d020, isp, ost, acc
                                       )
                                VALUES (dat_,
                                        DECODE (SUBSTR (nls_, 1, 1),
                                                'X', SUBSTR (nls_, 2, 14),
                                                nls_
                                               ),
                                         kv_, cntr_, spcnt_, s180_, k081_, k092_, sdos_,
                                        skos_, mdate_, k112_, r011_, d020_, isp_, se_, acc_
                                       );
                      end if;
                   END IF;
                END IF;
             END IF;

             ---  ������� ������� � ������� RNBU_HISTORY ��� �������� ������ #F4
             IF s_prol_03d + s_prol_03k <> 0 THEN
                d020_ := '03';

                sdos_ := Gl.P_Icurval (kv_, s_prol_03d, data_);
                skos_ := Gl.P_Icurval (kv_, s_prol_03k, data_);

                if dat_ < dat_izm1
                then
                   INSERT INTO RNBU_HISTORY
                               (odate,
                                nls,
                                kv, CODCAGENT, ints, s180, k081, k092, dos,
                                kos, mdate, k112, mb, d020, isp, ost, acc
                              )
                        VALUES (dat_,
                                DECODE (SUBSTR (nls_, 1, 1),
                                        'X', SUBSTR (nls_, 2, 14),
                                        nls_
                                       ),
                                kv_, cntr_, spcnt_, s180_, k081_, k092_, sdos_,
                                skos_, mdate_, k112_, r013_, d020_, isp_, se_, acc_
                               );
                else
                   INSERT INTO RNBU_HISTORY
                               (odate,
                                nls,
                                kv, CODCAGENT, ints, s180, k081, k092, dos,
                                kos, mdate, k112, mb, d020, isp, ost, acc
                               )
                        VALUES (dat_,
                                DECODE (SUBSTR (nls_, 1, 1),
                                       'X', SUBSTR (nls_, 2, 14),
                                       nls_
                                       ),
                                kv_, cntr_, spcnt_, s180_, k081_, k092_, sdos_,
                                skos_, mdate_, k112_, r011_, d020_, isp_, se_, acc_
                              );
                end if;
             END IF;
          END IF;
       END LOOP;

       CLOSE saldo;
    ----------------------------------------------------------------------------

    -- ���������� --
       OPEN saldoost;

       LOOP
          FETCH saldoost
           INTO acc_, nls_, kv_, data_, nbs_, mdate_, s180_, r013_, r011_,
                d020_acc, cntr_, rnk_, sdos_, skos_, vost_, se_, spcnt_, isp_, tips_,
                tobo_, nms_;

          EXIT WHEN saldoost%NOTFOUND;
          f03k_ := 0;

          d020_ := '01';

          comm1_ := '';
          comm1_ := substr(comm1_ || tobo_ || '  ' || nms_, 1, 200);

          IF typ_ > 0
          THEN
             nbuc_ := NVL (F_Codobl_Tobo (acc_, typ_), nbuc1_);
          ELSE
             nbuc_ := nbuc1_;
          END IF;

          -- �������� ������������� 434 �� 18.12.2008
          s180_ := '1';

          spcnt_ := Acrn_otc.fproc (acc_, dat_);

          k092_ := null;
          k081_ := null;
          k112_ := null;
          k071_ := null;
          mb_ := null;

          IF     nbs_ = '1500'
             AND ((vost_ < 0 AND se_ > 0) OR (se_ - vost_ > 0))
             AND (sdos_ + skos_ <> 0)
          THEN
             IF spcnt_ >= 0 AND se_ > 0
             THEN
                IF vost_ < 0
                THEN
                   znap_ := TO_CHAR (GL.P_Icurval(kv_, ABS(se_), Data_));
                ELSE
                   znap_ := TO_CHAR (GL.P_Icurval(kv_, ABS(se_)-ABS(vost_), Data_));
                END IF;
             END IF;

             cntr1_ := TO_CHAR (2 - cntr_);

             if dat_ < dat_izm1
             then
                kodp_ :=
                      '6'
                   || nbs_
                   || r013_
                   || s180_
                   || cntr1_
                   || d020_
                   || LPAD (kv_, 3, '0');
              else
                kodp_ :=
                      '6'
                   || nbs_
                   || r011_
                   || s180_
                   || cntr1_
                   || d020_
                   || LPAD (kv_, 3, '0');
              end if;

             IF s180_ = '0' AND LENGTH(trim(nls_)) <= 14
             THEN
                nls_ := 'X' || nls_;
             END IF;

             -- ��. �������
             p_ins ('1' || kodp_, znap_);
             -- %% ������
             p_ins ('2' || kodp_, LTRIM (TO_CHAR (ROUND (spcnt_, 4), fmt_)));
             -- ��.�������*%% ������
             p_ins ('3' || kodp_, TO_CHAR (to_number(znap_)*ROUND(spcnt_,4)));

             ---  ������� ������� � ������� RNBU_HISTORY ��� �������� ������ #04,#05
             if dat_ < dat_izm1
             then
                INSERT INTO RNBU_HISTORY
                            (odate,
                             nls,
                             kv, CODCAGENT, ints, s180, k081, k092, dos, kos, mdate,
                             k112, ost, mb, d020, isp, acc
                            )
                     VALUES (dat_,
                             DECODE (SUBSTR (nls_, 1, 1),
                                     'X', SUBSTR (nls_, 2, 14),
                                     nls_
                                    ),
                             kv_, cntr_, spcnt_, s180_, k081_, k092_, 0, 0, mdate_,
                             k112_, TO_NUMBER (znap_), r013_, d020_, isp_, acc_
                            );
             else
                INSERT INTO RNBU_HISTORY
                            (odate,
                             nls,
                             kv, CODCAGENT, ints, s180, k081, k092, dos, kos, mdate,
                             k112, ost, mb, d020, isp, acc
                            )
                     VALUES (dat_,
                             DECODE (SUBSTR (nls_, 1, 1),
                                     'X', SUBSTR (nls_, 2, 14),
                                     nls_
                                    ),
                             kv_, cntr_, spcnt_, s180_, k081_, k092_, 0, 0, mdate_,
                             k112_, TO_NUMBER (znap_), r011_, d020_, isp_, acc_
                            );
             end if;
          END IF;

    --- ���� ������� �� ����� ���������, � �� ������ ��� ���������� ���
    --- ���� ������� �� ����� ��� � �� ������ ��� ��������� � ������� ������ ����
          IF nbs_ IN ('1600','2600','2605','2620','2625','2650','2655','8025')
          THEN
             if nbs_ = '2625' and mfou_ = 300465 then
                 BEGIN
                    case
                       when nbs_ in ('2625') then
                          poisk_ := '2924%';
                       else
                          poisk_ := null;
                          --sdos_ := 0;
                    end case;

                    if poisk_ is not null then
                       -- 15.01.2010 ����� �������� ������� ������ �����������
                       SELECT NVL(SUM(s*100), 0)  --NVL (SUM (Gl.P_Icurval (kv, s * 100, FDAT)), 0)
                          INTO sdos1_
                       FROM tmp_file03
                       WHERE FDAT = data_
                         AND nlsk LIKE poisk_
                         and accd = acc_;

                       p_ins_del (acc_, nls_, kv_, '(� 2625 �� 2924)', sdos1_,  vost_);

                       p_ins_log (   '(� 2625 �� 2924) DK=1 r020='''
                                   || nbs_
                                   || ''' ����='''
                                   || nls_
                                   || ''' ���='''
                                   || kv_
                                   || ''' ����='''
                                   || data_
                                   || ''' �����=',
                                      sdos1_);
                    end if;
                 EXCEPTION
                          WHEN NO_DATA_FOUND
                 THEN
                    sdos1_ := 0;
                 END;

                 se_ := se_ + sdos1_;
                 sdos_ := sdos_ - sdos1_;
             end if;

             IF    ((((vost_ > 0 AND se_ < 0) OR (ABS (se_) - ABS (vost_)) > 0
                         )
                     AND (sdos_ + skos_ <> 0)
                    )
                   )
             THEN
                IF spcnt_ >= 0 AND se_ < 0
                THEN
                  IF vost_ > 0
                  THEN
                     znap_ := TO_CHAR (GL.P_Icurval(kv_, ABS(se_), Data_));
                  ELSE
                     znap_ := TO_CHAR (GL.P_Icurval(kv_, ABS(se_)-ABS(vost_), Data_));
                  END IF;

                   -- IF mfo_ = 300465 AND spcnt_ = 0
                   -- THEN
                   --    cntr1_ := 'X';
                   -- ELSE
                      cntr1_ := TO_CHAR (2 - cntr_);
                   -- END IF;

                   IF s180_ = '0'
                   THEN
                      nls_ := 'X' || nls_;
                   END IF;

                   IF  (300465 IN (mfo_,mfou_) AND nbs_ = '2625' AND nls_ not like '8625%') OR
                       (300465 IN (mfo_,mfou_) AND nbs_ <> '2625') OR
                       (mfou_ NOT IN (300465))
                   THEN
                      if nbs_ = '8025' then
                         nbs1_ := '2625';
                      else
                         nbs1_ := nbs_;
                      end if;

                      if dat_ < dat_izm1
                      then
                         kodp_ :=
                               '5'
                            || nbs1_
                            || r013_
                            || s180_
                            || cntr1_
                            || d020_
                            || LPAD (kv_, 3, '0');
                      else
                         kodp_ :=
                               '5'
                            || nbs1_
                            || r011_
                            || s180_
                            || cntr1_
                            || d020_
                            || LPAD (kv_, 3, '0');
                      end if;

                      p_ins ('1' || kodp_, znap_);
                      p_ins ('2' || kodp_, LTRIM (TO_CHAR (ROUND (spcnt_, 4), fmt_)));
                      -- ��.�������*%% ������
                      p_ins ('3' || kodp_, TO_CHAR (to_number(znap_)*ROUND(spcnt_,4)));

                   END IF;
                   ---  ������� ������� � ������� RNBU_HISTORY ��� �������� ������ #04,#05
                   if dat_ < dat_izm1
                   then
                      INSERT INTO RNBU_HISTORY
                                  (odate,
                                   nls,
                                   kv, CODCAGENT, ints, s180, k081, k092, dos, kos,
                                   mdate, k112, ost, mb, d020, isp, acc
                                  )
                           VALUES (dat_,
                                   DECODE (SUBSTR (nls_, 1, 1),
                                           'X', SUBSTR (nls_, 2, 14),
                                           nls_
                                          ),
                                   kv_, cntr_, spcnt_, s180_, k081_, k092_, 0, 0,
                                   mdate_, k112_, TO_NUMBER (znap_), r013_, d020_, isp_, acc_
                                  );
                   else
                      INSERT INTO RNBU_HISTORY
                                  (odate,
                                   nls,
                                   kv, CODCAGENT, ints, s180, k081, k092, dos, kos,
                                   mdate, k112, ost, mb, d020, isp, acc
                                  )
                           VALUES (dat_,
                                   DECODE (SUBSTR (nls_, 1, 1),
                                           'X', SUBSTR (nls_, 2, 14),
                                           nls_
                                          ),
                                   kv_, cntr_, spcnt_, s180_, k081_, k092_, 0, 0,
                                   mdate_, k112_, TO_NUMBER (znap_), r011_, d020_, isp_, acc_
                                  );
                   end if;
                END IF;
             END IF;
          END IF;
       END LOOP;

       CLOSE saldoost;

       PrcEf_ := false;

       ----------------------------------------------------------------------------
       -- ���������� ���� ��������� + % ������ (��� �����������)
       -- 04.12.2006 �������� ���� ����������� ���� ������� ��� ���.������ (nbuc_)
       OPEN izm_proc;

       LOOP
          FETCH izm_proc
           INTO acc_, nls_, kv_, nbs_, mdate_, isp_,
                s180_, r013p_, r011p_, rnk_, se_, spcnt_, tips_, tobo_, nms_, pdat_, codc_;

          EXIT WHEN izm_proc%NOTFOUND;

          IF typ_ > 0 THEN
             nbuc_ := NVL (F_Codobl_Tobo (acc_, typ_), nbuc1_);
          ELSE
             nbuc_ := nbuc1_;
          END IF;

          comm1_ := '';
          comm1_ := substr(comm1_ || tobo_ || '  ' || nms_, 1, 200);

          if nls_ like '1%' then
             begin
                 select nvl(max(c.nd), 0)
                 into nd1_
                 from nd_acc n, cc_deal c
                 where n.acc = acc_ and
                       n.nd = c.nd and
                       c.sdate <= pdat_;

                 select nvl(max(c.nd), 0)
                 into nd2_
                 from nd_acc n, cc_deal c
                 where n.acc = acc_ and
                       n.nd = c.nd and
                       c.sdate <= dat_;
             exception
                when no_data_found then
                        nd1_ := 0;
                        nd2_ := 0;
             end;
          else
             nd1_ := 0;
             nd2_ := 0;
          end if;

          if  nd1_ = nd2_ then
              se_ := FOSTQ(acc_, dat_);

              if se_ <> 0 then
                  spcntp_ := Acrn_otc.fproc(acc_, datp_ - 1);
                  spcntc_ := Acrn_otc.fproc(acc_, dat_);
              else
                  spcntp_ := 0;
                  spcntc_ := 0;
              end if;
          else
              spcntp_ := 0;
              spcntc_ := 0;
          end if;

          -- ��������� %������ - ���������� ��� �����������
          IF spcntp_ > 0 and spcntc_ > 0 and spcntp_ <> spcntc_
          THEN
             spcnt_ := spcntc_;

             IF spcnt_ > 0 and
                (se_ < 0 or
                 se_ > 0 and codc_ not in (5, 6))
             THEN
               -- 06/09/2013 ���������� �������� ��������� ������ �� ���������
               -- ��� ������������ ��� �������� ������ �� ������ "�����"  ��������
                if se_ > 0 and spcnt_ <> 0 then
                   spcnt_ := f_ret_avg_ratn(acc_, 1, dat_, mdate_, spcnt_);
                end if;

                --  10/09/2013 ���������� �������� ��������� ������ �� ��������
                if se_ < 0 and spcnt_ <> 0 then
                   -- ��������� ���� ��������� (�� ��� ����� ���� �� ����� ����� ��������� ���������� ��������)
                   if nbs_ like '1%' then
                      select max(c.wdate)
                      into mdate_
                      from nd_acc n, cc_deal c
                      where n.acc = acc_ and
                            n.nd = c.nd and
                            c.sdate <= dat_;
                   end if;

                   spcnt_ := f_ret_avg_ratn(acc_, 0, dat_, mdate_, spcnt_);
                end if;

                d020_ := '03';

                k092_ := null;
                k081_ := null;
                k112_ := null;
                k071_ := null;
                mb_ := null;

                if dat_ < dat_izm1
                then
                   if r013p_ <> '0' then
                      BEGIN
                         select r013
                            into r013_1
                         from kl_r013
                         where trim(prem) = '��' and r020 = nbs_ and r013 = r013p_
                           and d_close is not null and d_close <= dat_
                           and (r020, r013 ) not in ( select k.r020, k.r013
                                                from kl_r013 k
                                                where trim(k.prem) = '��'
                                                  and k.r020 = nbs_
                                                  and k.r013 = r013p_
                                                  and k.d_close is null
                                              );

                         r013p_ := '0';
                      EXCEPTION
                         WHEN NO_DATA_FOUND
                           THEN
                           null;
                      END;
                   end if;
                else
                   if r011p_ <> '0' then
                      BEGIN
                         select r011
                            into r011_1
                         from kl_r011
                         where trim(prem) = '��' and r020 = nbs_ and r011 = r011p_
                           and d_close is not null and d_close <= dat_
                           and (r020, r011 ) not in ( select k.r020, k.r011
                                                from kl_r011 k
                                                where trim(k.prem) = '��'
                                                  and k.r020 = nbs_
                                                  and k.r011 = r011p_
                                                  and k.d_close is null
                                              );

                         r011p_ := '0';
                      EXCEPTION
                         WHEN NO_DATA_FOUND
                           THEN
                           null;
                      END;
                   end if;
                end if;

                if se_ < 0 then
                   ddd_ := '5';
                else
                   ddd_ := '6';
                end if;

                -- ���������� � ���. �����
                if dat_ < dat_izm1
                then
                   kodp_ := ddd_ || nbs_ || r013p_ || s180_ || TO_CHAR (2 - cntr_) || d020_ || LPAD (kv_, 3, '0')||
                            (case when dat_ >= to_date('02092013','ddmmyyyy') then '0' else '' end);
                else
                   kodp_ := ddd_ || nbs_ || r011p_ || s180_ || TO_CHAR (2 - cntr_) || d020_ || LPAD (kv_, 3, '0')||
                            (case when dat_ >= to_date('02092013','ddmmyyyy') then '0' else '' end);
                end if;

                -- �����������
                INSERT INTO RNBU_HISTORY
                             (odate,
                              nls,
                              kv, CODCAGENT, ints, s180, k081, k092, dos,
                              kos, mdate, k112, mb, d020, isp, ost, acc
                               )
                        VALUES (dat_, nls_, kv_, cntr_, spcnt_, s180_, k081_, k092_, 0,
                                0, mdate_, k112_, r013p_, d020_, isp_, se_, acc_
                               );
             END IF;
          END IF;
       END LOOP;

       CLOSE izm_proc;

       ----------------------------------------------------------------------------------------------------------------------------
       p_ins_log('---------------------------------------', NULL);
       p_ins_log('�������� % ������ � ������ ������������', NULL);
       p_ins_log('---------------------------------------', NULL);

       BEGIN
          SELECT 1
             INTO kolvo_
          FROM CC_TAG
          WHERE tag = 'D_KDO';
       EXCEPTION
                 WHEN NO_DATA_FOUND THEN
          INSERT INTO CC_TAG(tag, name)
                     VALUES ('D_KDO', '���� ��������� �������� (KDO) � #3A');
       END;

       -- �������� % ������ � ������ ������������
       FOR i IN (SELECT  a.kodp, a.acc acc_, a.nls, a.kv, TO_NUMBER (a.znap) ost, b.znap prc,
                         (TO_NUMBER (a.znap) * TO_NUMBER (b.znap))/36500 ost_prc, b.recid,
                         sum(Gl.P_Icurval(a.KV, to_number(TRANSLATE(t.txt,',','.')), Dat_)) kom,
                         s.mdate-dat_ term, c.nd nd, c.cc_id,
                         ABS(Gl.P_Icurval(a.KV, c.LIMIT * 100, Dat_)) s_zd2,
                         s.mdate
                 FROM RNBU_TRACE a, RNBU_TRACE b, ND_ACC n, CC_DEAL c, ND_TXT t, ACCOUNTS s
                 WHERE SUBSTR (a.kodp, 2) = SUBSTR (b.kodp, 2)
                   AND SUBSTR (a.kodp, 1, 1) = '1'
                   AND SUBSTR (b.kodp, 1, 1) = '2'
                   and nvl(a.nd, 0) <> 1
                   AND a.acc = b.acc
                   AND a.recid = b.recid - 1
                   AND a.odate = b.odate
                   AND a.acc=n.acc
                   AND n.nd=c.nd
                   AND (c.sdate,c.nd)= (SELECT MAX(p.sdate), MAX(p.nd)
                                        FROM ND_ACC a, CC_DEAL p
                                        WHERE a.acc=n.acc AND
                                              a.nd=p.nd AND
                                              p.sdate<=dat_)
                   AND n.nd=t.nd
                   AND t.tag in ('KDO','S_SDI')
                   and is_number(TRANSLATE(t.txt,',','.')) = 1
                   and c.vidd not in ('26')
                   AND a.acc=s.acc
                 group by a.kodp, a.acc, a.nls, a.kv, TO_NUMBER (a.znap), b.znap,
                         (TO_NUMBER (a.znap) * TO_NUMBER (b.znap))/36500, b.recid,
                         s.mdate-dat_, c.nd, c.cc_id,
                         ABS(Gl.P_Icurval(a.KV, c.LIMIT * 100, Dat_)), s.mdate
                 ORDER BY a.kodp)
        LOOP
        ---------------------------------------------------------
           BEGIN
              komm_ := TO_NUMBER(i.kom) * 100;
           EXCEPTION
                     WHEN OTHERS THEN
              IF SQLCODE=-6502 THEN
                 komm_ := 0;
              ELSE
                 RAISE_APPLICATION_ERROR(-20001, '�������: '||SQLERRM);
              END IF;
           END;

           -- �������� ��� �������: ���� � ������ ����� �������� ��������, �� ������ - �� ��������
           BEGIN
              SELECT TO_DATE(txt, 'ddmmyyyy')
                 INTO datp_
              FROM ND_TXT
              WHERE nd=i.nd AND
                    tag='D_KDO';
           EXCEPTION
                     WHEN NO_DATA_FOUND THEN
              datp_ := NULL;
           END;

           IF komm_>0 AND NVL(i.term,0)>0 AND NVL(datp_, dat_) = dat_ THEN
              -- �������� ���������� ������� ������ � �������� � ����� ����� �� ��������
              SELECT COUNT(*), SUM(TO_NUMBER(znap))
                 INTO kolvo_, se_
              FROM ND_ACC n, RNBU_TRACE r
              WHERE n.ND=i.nd AND
                    n.acc=r.acc AND
                    SUBSTR(r.KODP,1,1)='1';

              -- ���� � �������� �� ���� ������� ����
              IF kolvo_ > 1 THEN
                 -- ������������� ��������������� ��������
                 komm_ := komm_ * (i.ost / se_);
              END IF;

              kommr_ := komm_ / i.term;

              -- ���������� �������� ���� (360 �� 365)
              BEGIN
                 SELECT basey
                    into basey_
                 FROM int_accN
                 WHERE acc=i.acc_ and
                       id=0;
              EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                 basey_:=0;
              END;

              IF basey_ in (2, 3, 12) THEN
                 b_yea := 360;
              ELSE
                 b_yea := 365;
              END IF;

              if b_yea = 365 and mod(to_number(to_char(Dat_,'YYYY')), 4) = 0 THEN
                 b_yea := 366;
              end if;

              s_zd2_ := i.s_zd2;

              if i.s_zd2 = 0 or i.s_zd2 < abs(i.ost) then
                 select max(ABS(Gl.P_Icurval(i.KV, LIM2, Dat_)))
                    into s_zd2_
                 from cc_lim
                 where fdat<=Dat_
                   and nd=i.nd
                 group by nd;
              end if;

              BEGIN
                 cntr_ := ((s_zd2_ * i.prc / (b_yea * 100) + kommr_) / s_zd2_) * b_yea * 100;
              EXCEPTION
                        WHEN OTHERS THEN
                 RAISE_APPLICATION_ERROR(-20001, '���. '||i.nls||' ���.���. '||i.nd||' �������: �� ��������� ���� �i�i��');
              END;

              -- ���������� ���������� ������
              -- � ���������
              UPDATE RNBU_TRACE
                 SET znap = Trim(TO_CHAR (ROUND (cntr_, 4), fmt_))
              WHERE recid=i.recid;

              -- ���������� (�������*���������� ������)
              -- � ���������
              UPDATE RNBU_TRACE
                 SET znap = Trim(TO_CHAR (se_*ROUND(cntr_,4)))
              WHERE acc = i.acc_ and kodp like '3%';

              -- � ������
              UPDATE RNBU_HISTORY
                 SET ints=cntr_
              WHERE odate = dat_ and acc = i.acc_;

              IF datp_ IS NULL THEN
                 -- ���. ��������� ��� ��
                 INSERT INTO ND_TXT (nd, tag, txt)
                              VALUES(i.nd, 'D_KDO', TO_CHAR(dat_, 'ddmmyyyy'));
              END IF;

              p_ins_log('C��� '''||i.nls||
                        '''. ��� �� = '||Trim(TO_CHAR(i.nd))||
                        '. SK='||Trim(TO_CHAR(i.s_zd2))||
                        '. Kom='||Trim(TO_CHAR(komm_))||
                        '. Prc='||Trim(TO_CHAR(i.prc))||
                        ', PrcN='||LTRIM(TO_CHAR (ROUND (cntr_, 4), fmt_))||
                        '. Term='||i.term||'.'||
                        '. BaseY='||to_char(b_yea)||'.', NULL);
           END IF;
        END LOOP;
   else
       null;
   end if;
---------------------------------------------------
---------------------------------------------------
   if flag_blk = 0 then
       DELETE FROM TMP_NBU
             WHERE kodf = kodf_ AND datf = dat_;

       OPEN basel;

       LOOP
          FETCH basel
           INTO nbuc_, kodp_, sob_, sobpr_;

          EXIT WHEN basel%NOTFOUND;

          -- 26.09.2016 ��� ��� �� �������� ���.���� 1502
          if (mfo_ = 300465 and substr(kodp_, 3, 4) <> '1502') OR
              mfo_ <> 300465
          then

             INSERT INTO TMP_NBU
                         ( kodf,  datf, kodp,  znap,           nbuc )
                  VALUES ( kodf_, dat_, kodp_, TO_CHAR (sob_), nbuc_ );

             spcnt1_ := LTRIM (TO_CHAR (ROUND (sobpr_ / sob_, 4), fmt_));

             INSERT INTO TMP_NBU
                         ( kodf,  datf, kodp,                    znap,    nbuc )
                  VALUES ( kodf_, dat_, '2'||substr(kodp_,2), spcnt1_, nbuc_ );
          end if;

       END LOOP;

       CLOSE basel;

       DELETE FROM RNBU_TRACE
          WHERE userid = userid_ AND
                kodp like '3%';

       insert into OTCN_TRACE_3A(DATF, USERID, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO)
       select dat_, USERID_, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO
       from rnbu_trace;
   else
      null;
   end if;

   logger.info ('P_F3A_NN: End ');
----------------------------------------------------------------------
END;
/