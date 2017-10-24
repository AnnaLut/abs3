

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F2E_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F2E_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_F2E_NN (dat_ DATE, sheme_ VARCHAR2 DEFAULT 'G')
IS
   /*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % DESCRIPTION :   ��������� ������������ #70 ��� �� (�������������)
   % COPYRIGHT   :   Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
   % VERSION     :   13/05/2015 (16/03/2015, 11/03/2015)
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   ���������: Dat_ - �������� ����
         sheme_ - ����� ������������
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   13/05/2015 - ��� 300465 ��������� ����� ������� ��� ������ ����������
                ( �� 2900 �� 3739 � ����� ���������� �������)
   16/03/2015 - ��� ����� ��������� ���������� "�������", "���������"
   13/03/2015 - ��������� � ������� ������ ���������� ������������ ����������
                �������
   06/03/2015 - ������ �������
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   kodf_      VARCHAR2 (2) := '2E';
   sql_z      VARCHAR2 (200);
   typ_       NUMBER;
   gr_sum_    NUMBER := 1;                        --5000000;     --��� �������
   -- ��� ������� i ����������� �i� ����������i�
   flag_      NUMBER;
   -- ���� ��� ����������� ������� ���� BENEFCOUNTRY �.TOP_CONTRACTS
   -- (�� ������ �������� ��������)
   pr_s3_     NUMBER;     -- ���� ��� ����������� ������� ���� S3 ����.ZAYAVKA
   -- (�� ������ �������� ��������)
   s3_        NUMBER;
   ko_        VARCHAR2 (2);       -- ������ ������ii � ������i������ i��������
   ko_1       VARCHAR2 (2);       -- ������ ������ii � ������i������ i��������
   kod_b      VARCHAR2 (10);                           -- ��� i��������� �����
   nam_b      VARCHAR2 (70);                         -- ����� i��������� �����
   n_         NUMBER := 10;
   -- ���-�� ���.���������� �� 03.07.2006 ����� n_=11
   acc_       NUMBER;
   acck_      NUMBER;
   kv_        NUMBER;
   kv1_       NUMBER;
   nls_       VARCHAR2 (15);
   nlsk_      VARCHAR2 (15);
   nlsk1_     VARCHAR2 (15);
   nbuc1_     VARCHAR2 (12);
   nbuc_      VARCHAR2 (12);
   country_   VARCHAR2 (3);
   b010_      VARCHAR2 (10);
   bic_code   VARCHAR2 (14);
   rnk_       NUMBER;
   okpo_      VARCHAR2 (14);
   ourOKPO_   VARCHAR2 (14);
   ourGLB_    VARCHAR2 (3);
   nmk_       VARCHAR2 (70);
   adr_       VARCHAR2 (70);
   nazn_      VARCHAR2 (160);
   nb_        VARCHAR2 (70);
   nb1_       VARCHAR2 (70);
   tg_        VARCHAR2 (70);
   data_      DATE;
   dig_       NUMBER;
   bsum_      NUMBER;
   bsu_       NUMBER;
   sum1_      DECIMAL (24);
   sum0_      DECIMAL (24);
   sumk1_     DECIMAL (24);                  --���_�_� � �_���� �� �����������
   sumk0_     DECIMAL (24);                             --���_�_� �� ���������
   kodp_      VARCHAR2 (10);
   znap_      VARCHAR2 (70);
   kurs_      NUMBER;
   kurs1_     NUMBER;
   tag_       VARCHAR2 (5);
   nnnn_      NUMBER := 0;
   userid_    NUMBER;
   ref_       NUMBER;
   rez_       NUMBER;
   codc_      NUMBER;
   mfo_       NUMBER;
   mfou_      NUMBER;
   koldop_    NUMBER;
   refd_      NUMBER;
   s0_        VARCHAR2 (16);
   kol_       NUMBER;
   swift_k_   VARCHAR2 (12);
   --branch_    customer.branch%TYPE;
   branch_    customer.tobo%TYPE;
   kod_obl_   VARCHAR2 (2);

   --- ���� ��� �����
   CURSOR opl_dok
   IS
        SELECT t.ko,
               t.REF,
               t.accd,
               t.nlsd,
               t.kv,
               t.acck,
               t.nlsk,
               t.nazn,
               SUM (t.s_nom),
               SUM (t.s_kom)
          FROM OTCN_PROV_TEMP t
      GROUP BY t.ko,
               t.REF,
               t.acck,
               t.nlsk,
               t.kv,
               t.accd,
               t.nlsd,
               t.nazn;

   -------------------------------------------------------------------
   PROCEDURE p_ins (p_kodp_ IN VARCHAR2, p_znap_ IN VARCHAR2)
   IS
      l_kodp_   VARCHAR2 (13);
   BEGIN
      l_kodp_ := p_kodp_;

      INSERT INTO rnbu_trace (nls,
                              kv,
                              odate,
                              kodp,
                              znap,
                              nbuc,
                              REF,
                              rnk,
                              comm)
           VALUES (nls_,
                   kv_,
                   dat_,
                   l_kodp_,
                   p_znap_,
                   nbuc_,
                   ref_,
                   rnk_,
                   TO_CHAR (refd_));
   END;

-------------------------------------------------------------------
BEGIN
   EXECUTE IMMEDIATE 'ALTER SESSION SET NLS_NUMERIC_CHARACTERS=''.,''';

   -------------------------------------------------------------------
   userid_ := user_id;

   EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';


   DELETE FROM OTCN_PROV_TEMP;

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

   -------------------------------------------------------------------
   -- ��������� ������������ �����
   p_proc_set (kodf_,
               sheme_,
               nbuc1_,
               typ_);
   --- ����� ����� ������ ��� ��������� �����
   nbuc_ := nbuc1_;

   kurs_ := f_ret_kurs (840, dat_);

   ourOKPO_ := LPAD (F_Get_Params ('OKPO', NULL), 8, '0');

   BEGIN
      SELECT LPAD (TO_CHAR (GLB), 3, '0')
        INTO ourGLB_
        FROM rcukru
       WHERE mfo = mfo_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         ourGLB_ := NULL;
   END;

   -- ����� ��������, ��������������� �������
   INSERT INTO OTCN_PROV_TEMP (ko,
                               rnk,
                               REF,
                               acck,
                               nlsk,
                               kv,
                               accd,
                               nlsd,
                               nazn,
                               s_nom,
                               s_eqv)
      SELECT *
        FROM (                                       --���� ��� ���_�� ������
              SELECT   '1' ko,
                       ca.rnk,
                       o.REF,
                       o.acck,
                       o.nlsk,
                       o.kv,
                       o.accd,
                       o.nlsd,
                       o.nazn,
                       SUM (o.s * 100) s_nom,
                       SUM (gl.p_icurval (o.kv, o.s * 100, dat_)) s_eqv
                  FROM provodki o, cust_acc ca
                 WHERE     o.fdat = dat_
                       AND o.kv = 980
                       AND (   (    SUBSTR (o.nlsd, 1, 4) IN
                                       ('2600', '2620', '2650')
                                AND SUBSTR (o.nlsk, 1, 4) = '2900'
                                AND (   LOWER (TRIM (o.nazn)) LIKE
                                           '%���_��_%'
                                     OR LOWER (TRIM (o.nazn)) LIKE
                                           '%������_%'
                                     OR LOWER (TRIM (o.nazn)) LIKE
                                           '%�������%'
                                     OR LOWER (TRIM (o.nazn)) LIKE
                                           '%���������%'))
                            OR (    SUBSTR (o.nlsd, 1, 4) = '3929'
                                AND SUBSTR (o.nlsk, 1, 4) = '2900'))
                       AND o.accd = ca.acc
              GROUP BY '1',
                       ca.rnk,
                       o.REF,
                       o.acck,
                       o.nlsk,
                       o.kv,
                       o.accd,
                       o.nlsd,
                       o.nazn
              UNION
                SELECT '1' ko,
                       ca.rnk,
                       o.REF,
                       o.acck,
                       o.nlsk,
                       o.kv,
                       o.accd,
                       o.nlsd,
                       o.nazn,
                       SUM (o.s * 100) s_nom,
                       SUM (gl.p_icurval (o.kv, o.s * 100, dat_)) s_eqv
                  FROM provodki o, cust_acc ca
                 WHERE     mfou_ = 300465
                       AND o.fdat = dat_
                       AND o.kv = 980
                       AND (    SUBSTR (o.nlsd, 1, 4) = '2900'
                            AND SUBSTR (o.nlsk, 1, 4) = '3739'
                            AND EXISTS
                                   (SELECT 1
                                      FROM oper o1
                                     WHERE     o1.REF = o.REF
                                           AND (LOWER (TRIM (o1.nazn)) LIKE
                                                   '%������������� ����_� �� ���_��_%')))
                       AND o.accd = ca.acc
              GROUP BY '1',
                       ca.rnk,
                       o.REF,
                       o.acck,
                       o.nlsk,
                       o.kv,
                       o.accd,
                       o.nlsd,
                       o.nazn
              UNION
                SELECT '1' ko,
                       ca.rnk,
                       o.REF,
                       o.acck,
                       o.nlsk,
                       o.kv,
                       o.accd,
                       o.nlsd,
                       o.nazn,
                       SUM (o.s * 100) s_nom,
                       SUM (gl.p_icurval (o.kv, o.s * 100, dat_)) s_eqv
                  FROM provodki o, cust_acc ca
                 WHERE     mfou_ = 380764
                       AND o.fdat = dat_
                       AND o.kv = 980
                       AND (    SUBSTR (o.nlsd, 1, 4) IN
                                   ('2600', '2620', '2650')
                            AND SUBSTR (o.nlsk, 1, 4) = '2900'
                            AND EXISTS
                                   (SELECT 1
                                      FROM oper o1
                                     WHERE     o1.REF = o.REF
                                           AND (   LOWER (TRIM (o1.nazn)) LIKE
                                                      '%���_��_%'
                                                OR LOWER (TRIM (o1.nazn)) LIKE
                                                      '%������_%'
                                                OR LOWER (TRIM (o1.nazn)) LIKE
                                                      '%�������%'
                                                OR LOWER (TRIM (o1.nazn)) LIKE
                                                      '%���������%')))
                       AND o.accd = ca.acc
              GROUP BY '1',
                       ca.rnk,
                       o.REF,
                       o.acck,
                       o.nlsk,
                       o.kv,
                       o.accd,
                       o.nlsd,
                       o.nazn
              UNION
                --���� �� ������� ������
                SELECT '2' ko,
                       ca.rnk,
                       o.REF,
                       o.acck,
                       o.nlsk,
                       o.kv,
                       o.accd,
                       o.nlsd,
                       o.nazn,
                       SUM (o.s * 100) s_nom,
                       SUM (gl.p_icurval (o.kv, o.s * 100, dat_)) s_eqv
                  FROM provodki o, cust_acc ca
                 WHERE     o.fdat = dat_
                       AND o.kv = 980
                       AND (   (    SUBSTR (o.nlsd, 1, 4) = '2900'
                                AND SUBSTR (o.nlsk, 1, 4) IN
                                       ('2600', '2620', '2650')
                                AND LOWER (TRIM (o.nazn)) LIKE '%������%')
                            OR (    SUBSTR (o.nlsd, 1, 4) = '2900'
                                AND SUBSTR (o.nlsk, 1, 4) = '3929'
                                AND LOWER (TRIM (o.nazn)) LIKE '%������%'))
                       AND o.accd = ca.acc
              GROUP BY '2',
                       ca.rnk,
                       o.REF,
                       o.acck,
                       o.nlsk,
                       o.kv,
                       o.accd,
                       o.nlsd,
                       o.nazn
              UNION
                SELECT '2' ko,
                       ca.rnk,
                       o.REF,
                       o.acck,
                       o.nlsk,
                       o.kv,
                       o.accd,
                       o.nlsd,
                       o.nazn,
                       SUM (o.s * 100) s_nom,
                       SUM (gl.p_icurval (o.kv, o.s * 100, dat_)) s_eqv
                  FROM provodki o, cust_acc ca
                 WHERE     mfou_ = 300465
                       AND o.fdat = dat_
                       AND o.kv = 980
                       AND o.nlsd LIKE '2900%'
                       AND SUBSTR (o.nlsk, 1, 4) IN
                              ('2600', '2620', '2650', '3739')
                       AND (   LOWER (TRIM (o.nazn)) LIKE
                                  '%�������������� ������� �_� ������__ ���_��_%'
                            OR LOWER (TRIM (o.nazn)) LIKE
                                  '%���������� ����_�, ���������� ������������� ��� ���_��_%'
                            OR LOWER (TRIM (o.nazn)) LIKE
                                  '%����������%����������.%����_�%'
                            OR LOWER (TRIM (o.nazn)) LIKE
                                  '%����������%����_�%�_������%���%'
                            OR LOWER (TRIM (o.nazn)) LIKE
                                  '%����������%����_�%��_���%���������%') ------
                       AND o.accd = ca.acc
              GROUP BY '2',
                       ca.rnk,
                       o.REF,
                       o.acck,
                       o.nlsk,
                       o.kv,
                       o.accd,
                       o.nlsd,
                       o.nazn
              UNION
                SELECT '2' ko,
                       ca.rnk,
                       o.REF,
                       o.acck,
                       o.nlsk,
                       o.kv,
                       o.accd,
                       o.nlsd,
                       o.nazn,
                       SUM (o.s * 100) s_nom,
                       SUM (gl.p_icurval (o.kv, o.s * 100, dat_)) s_eqv
                  FROM provodki o, cust_acc ca
                 WHERE     mfo_ = 300205
                       AND o.fdat = dat_
                       AND o.kv = 980
                       AND ( (    o.nlsd LIKE '290009228%'
                              AND TRIM (o.nlsk) IN ('1919691', '28005691')))
                       AND o.accd = ca.acc
              GROUP BY '2',
                       ca.rnk,
                       o.REF,
                       o.acck,
                       o.nlsk,
                       o.kv,
                       o.accd,
                       o.nlsd,
                       o.nazn
              UNION
                SELECT '2' ko,
                       ca.rnk,
                       o.REF,
                       o.acck,
                       o.nlsk,
                       o.kv,
                       o.accd,
                       o.nlsd,
                       o.nazn,
                       SUM (o.s * 100) s_nom,
                       SUM (gl.p_icurval (o.kv, o.s * 100, dat_)) s_eqv
                  FROM provodki o, cust_acc ca
                 WHERE     mfo_ = 300120
                       AND o.fdat = dat_
                       AND o.kv = 980
                       AND (   (    o.nlsd LIKE '29008302%'
                                AND o.nlsk LIKE '2900500002%')
                            OR (o.nlsd LIKE '29008302%' AND o.nlsk LIKE '6114%'))
                       AND o.accd = ca.acc
              GROUP BY '2',
                       ca.rnk,
                       o.REF,
                       o.acck,
                       o.nlsk,
                       o.kv,
                       o.accd,
                       o.nlsd,
                       o.nazn
              UNION
                SELECT '2' ko,
                       ca.rnk,
                       o.REF,
                       o.acck,
                       o.nlsk,
                       o.kv,
                       o.accd,
                       o.nlsd,
                       o.nazn,
                       SUM (o.s * 100) s_nom,
                       SUM (gl.p_icurval (o.kv, o.s * 100, dat_)) s_eqv
                  FROM provodki o, cust_acc ca
                 WHERE     mfou_ = 380764
                       AND o.fdat = dat_
                       AND o.kv = 980
                       AND o.nlsd LIKE '2900%'
                       AND SUBSTR (o.nlsk, 1, 4) IN ('2600', '2620', '2650')
                       AND EXISTS
                              (SELECT 1
                                 FROM oper o1
                                WHERE     o1.REF = o.REF
                                      AND LOWER (TRIM (o1.nazn)) LIKE
                                             '%������%')
                       AND o.accd = ca.acc
              GROUP BY '2',
                       ca.rnk,
                       o.REF,
                       o.acck,
                       o.nlsk,
                       o.kv,
                       o.accd,
                       o.nlsd,
                       o.nazn);

   --- ���� ��� ����� ������
   OPEN opl_dok;

   LOOP
      FETCH opl_dok
         INTO ko_1, ref_, acc_, nls_, kv_, acck_, nlsk_, nazn_, sum0_, sumk0_;

      EXIT WHEN opl_dok%NOTFOUND;

      IF typ_ > 0
      THEN
         IF ko_1 = 1
         THEN
            nbuc_ := NVL (f_codobl_tobo (acc_, typ_), nbuc1_);
         END IF;

         IF ko_1 = 2
         THEN
            nbuc_ := NVL (f_codobl_tobo (acck_, typ_), nbuc1_);
         END IF;
      ELSE
         nbuc_ := nbuc1_;
      END IF;

      IF mfo_ = 300120
      THEN
         nbuc_ := '26';
      END IF;

      IF ko_1 = 1 AND mfou_ <> 300465
      THEN
         -- ���� ��� �����
         p_ins ('10' || '0000', TO_CHAR (sum0_));

         -- ���� ��� ����� �� �����������
         p_ins ('20' || '0000', TO_CHAR (sum0_));
      END IF;

      IF ko_1 = 1 AND mfou_ = 300465 AND nls_ LIKE '26%'
      THEN
         -- ���� ��� �����
         p_ins ('10' || '0000', TO_CHAR (sum0_));
      END IF;

      IF ko_1 = 1 AND mfou_ = 300465 AND nls_ LIKE '2900%'
      THEN
         -- ���� ��� ����� �� �����������
         p_ins ('20' || '0000', TO_CHAR (sum0_));
      END IF;

      IF ko_1 = 2 AND mfou_ NOT IN (300120, 300205, 300465)
      THEN
         -- ���� �� �������
         p_ins ('30' || '0000', TO_CHAR (sum0_));
      END IF;

      IF ko_1 = 2 AND mfo_ = 300205 AND nls_ LIKE '290009228%'
      THEN
         -- ���� �� �������
         p_ins ('30' || '0000', TO_CHAR (sum0_));
      END IF;

      IF ko_1 = 2 AND mfo_ = 300205 AND NOT nls_ LIKE '290009228%'
      THEN
         -- ���� �� �������
         p_ins ('40' || '0000', TO_CHAR (sum0_));
      END IF;

      IF ko_1 = 2 AND mfo_ = 300120 AND nls_ LIKE '29008302%'
      THEN
         -- ���� �� �������
         p_ins ('30' || '0000', TO_CHAR (sum0_));
      END IF;

      IF ko_1 = 2 AND mfo_ = 300120 AND NOT nls_ LIKE '29008302%'
      THEN
         -- ���� �� �������
         p_ins ('40' || '0000', TO_CHAR (sum0_));
      END IF;

      IF     ko_1 = 2
         AND mfou_ = 300465
         AND LOWER (nazn_) NOT LIKE
                '%�������������� ������� �_� ������__ ���_��_%'
         AND LOWER (nazn_) NOT LIKE
                '%���������� ����_�, ���������� ������������� ��� ���_��_%'
         AND LOWER (nazn_) NOT LIKE
                '%���������� ����������.%����_�%'
         AND LOWER (nazn_) NOT LIKE
                '%����������%����_�%�_������%���%'
         AND LOWER (nazn_) NOT LIKE
                '%����������%����_�%��_���%���������%'
      THEN
         -- ���� �� �������
         p_ins ('30' || '0000', TO_CHAR (sum0_));
      END IF;

      IF     ko_1 = 2
         AND mfou_ = 300465
         AND (   LOWER (TRIM (nazn_)) LIKE
                    '%�������������� ������� �_� ������__ ���_��_%'
              OR LOWER (TRIM (nazn_)) LIKE
                    '%���������� ����_�, ���������� ������������� ��� ���_��_%'
              OR LOWER (TRIM (nazn_)) LIKE
                    '%���������� ����������.%����_�%'
              OR LOWER (TRIM (nazn_)) LIKE
                    '%����������%����_�%�_������%���%'
              OR LOWER (TRIM (nazn_)) LIKE
                    '%����������%����_�%��_���%���������%')
      THEN
         -- ���� �� �������
         p_ins ('40' || '0000', TO_CHAR (sum0_));
      END IF;
   END LOOP;

   CLOSE opl_dok;

   ---------------------------------------------------
   DELETE FROM tmp_nbu
         WHERE kodf = kodf_ AND datf = dat_;

   ---------------------------------------------------
   INSERT INTO tmp_nbu (kodf,
                        datf,
                        kodp,
                        znap,
                        nbuc)
        SELECT kodf_,
               dat_,
               kodp,
               SUM (znap),
               nbuc
          FROM rnbu_trace
         WHERE userid = userid_
      GROUP BY kodf_,
               dat_,
               kodp,
               nbuc;
----------------------------------------
END p_f2e_nn;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F2E_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
