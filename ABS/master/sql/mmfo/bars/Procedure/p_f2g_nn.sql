

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F2G_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F2G_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_F2G_NN (
   dat_     DATE,
   sheme_   VARCHAR2 DEFAULT 'G'
)
IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :   ��������� ������������ #2G ��� �� (�������������)
% COPYRIGHT   :   Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :   19/03/2015 (17/03/2015, 16/03/2015, 13/03/2015) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
���������: Dat_ - �������� ����
      sheme_ - ����� ������������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
19/03/2015 - ��� ���� ������ ��� "MM" � ���������� ����� ������������� 
             ��� "01"
17/03/2015 - ��� 300120 ��� "MM" � ���������� ����� ������������� ��� "01"
16/03/2015 - ��� 300120 ����� ���������� �������� �� 1500 �� 3540
13/03/2015 - ��� �������� �� 2900 �� 3800 �� ����� ���������� ���������
12/03/2015 - ������ ������� 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   kodf_      VARCHAR2 (2)   := '2G';
   sql_z      VARCHAR2 (200);
   typ_       NUMBER;
   gr_sum_    NUMBER         := 1;  --5000000;     --��� �������
   -- ��� ������� i ����������� �i� ����������i�
   flag_      NUMBER;
   -- ���� ��� ����������� ������� ���� BENEFCOUNTRY �.TOP_CONTRACTS
   -- (�� ������ �������� ��������)
   pr_s3_     NUMBER;    -- ���� ��� ����������� ������� ���� S3 ����.ZAYAVKA
   -- (�� ������ �������� ��������)
   s3_        NUMBER;
   ko_        VARCHAR2 (2);      -- ������ ������ii � ������i������ i��������
   ko_1       VARCHAR2 (2);      -- ������ ������ii � ������i������ i��������
   kod_b      VARCHAR2 (10);                          -- ��� i��������� �����
   nam_b      VARCHAR2 (70);                        -- ����� i��������� �����
   n_         NUMBER         := 10;
   -- ���-�� ���.���������� �� 03.07.2006 ����� n_=11
   acc_       NUMBER;
   acck_       NUMBER;
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
   ourOKPO_   varchar2(14);
   ourGLB_    varchar2(3); 
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
   sumk1_     DECIMAL (24);                 --���_�_� � �_���� �� �����������
   sumk0_     DECIMAL (24);                            --���_�_� �� ���������
   kodp_      VARCHAR2 (10);
   znap_      VARCHAR2 (70);
   kurs_      NUMBER;
   kurs1_     NUMBER;
   tag_       VARCHAR2 (5);
   nnnn_      NUMBER         := 0;
   userid_    NUMBER;
   ref_       NUMBER;
   rez_       NUMBER;
   codc_      NUMBER;
   mfo_       number;
   mfou_      number;
   koldop_    number;
   refd_      number;
   s0_        varchar2(16);
   kol_       number;
   swift_k_   VARCHAR2 (12);
   --branch_    customer.branch%TYPE;
   branch_      customer.tobo%TYPE;
   kod_obl_   varchar2 (2);

--- ���� ��� �����
   CURSOR opl_dok
   IS
      SELECT   t.ko, t.REF, t.accd, t.nlsd, t.kv, t.acck, t.nlsk, t.nazn, 
               SUM (t.s_nom),
               SUM (t.s_kom)
          FROM OTCN_PROV_TEMP t
      GROUP BY t.ko, t.REF, t.acck, t.nlsk, t.kv, t.accd, t.nlsd, t.nazn;

-------------------------------------------------------------------
   PROCEDURE p_ins (p_kodp_ IN VARCHAR2, p_znap_ IN VARCHAR2)
   IS
      l_kodp_   VARCHAR2 (13);
   BEGIN
      l_kodp_ := p_kodp_ ;

      INSERT INTO rnbu_trace
                  (nls, kv, odate, kodp, znap, nbuc, ref, rnk, comm
                  )
           VALUES (nls_, kv_, dat_, l_kodp_, p_znap_, nbuc_, ref_, rnk_, to_char(refd_)
                  );
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
   p_proc_set (kodf_, sheme_, nbuc1_, typ_);
   --- ����� ����� ������ ��� ��������� �����
   nbuc_ := nbuc1_;
   
   kurs_ := f_ret_kurs (840, dat_);

   ourOKPO_ := lpad(F_Get_Params('OKPO',null), 8, '0');

   BEGIN
     select lpad(to_char(glb), 3, '0')
        into ourGLB_
     from rcukru
     where mfo=mfo_;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      ourGLB_ := null;
   END;

   -- ����� ��������, ��������������� �������
   INSERT INTO OTCN_PROV_TEMP
               (ko, rnk, REF, acck, nlsk, kv, accd, nlsd, nazn, s_nom, s_eqv)
      SELECT *
        FROM (  SELECT   '1' ko, ca.rnk, o.REF, o.accd, o.nlsd, o.kv, o.acck, o.nlsk, o.nazn, 
                       SUM (o.s * 100) s_nom,
                       SUM (gl.p_icurval (o.kv, o.s * 100, dat_)) s_eqv
                  FROM provodki o, cust_acc ca
                 WHERE o.fdat = dat_
                   AND o.kv not in (959, 961, 962, 964, 980)
                   AND (   ( SUBSTR (o.nlsd, 1, 4) IN
                                     ('2600', '2603', '2620', '2650')   
                             AND SUBSTR (o.nlsk, 1, 4) = '2900'
                            AND LOWER (TRIM (o.nazn)) not like '%�������%'
                            AND LOWER (TRIM (o.nazn)) not like '%�������%'
                            AND LOWER (TRIM (o.nazn)) not like '%���_���%' 
                           )
                        --OR  mfo_ <> 300465 and
                        --    (   SUBSTR (o.nlsd, 1, 4) in ('2625', '3570')  
                        --    AND SUBSTR (o.nlsk, 1, 4) = '2900'  
                        --   )
                        OR (    o.nlsd like  '1919691%'
                            AND SUBSTR (o.nlsk, 1, 4) = '2900'
                            AND mfou_ = 300205 
                           )
                        OR (    o.nlsd like  '29004691%'
                            AND SUBSTR (o.nlsk, 1, 4) = '2900'
                            AND mfou_ = 300205 
                           )
                        OR (    SUBSTR (o.nlsd, 1, 4) = '1919'
                            AND SUBSTR (o.nlsk, 1, 4) = '2900'
                            AND mfou_ = 380764 
                            AND (LOWER (TRIM (o.nazn)) like '%������� �����_%' or 
                                 LOWER (TRIM (o.nazn)) like '%������ �����_%') 
                           )
                        OR (    SUBSTR (o.nlsd, 1, 4) = '2900'
                            AND SUBSTR (o.nlsk, 1, 4) = '2900'
                            AND mfou_ = 300465 AND mfou_ <> mfo_ 
                            AND LOWER (TRIM (o.nazn)) like '%������%'                            
                          )
                        OR (    SUBSTR (o.nlsd, 1, 4) = '2924'
                            AND SUBSTR (o.nlsk, 1, 4) = '2900'
                            AND mfou_ = 380764 
                            AND LOWER (TRIM (o.nazn)) like '%������������� ����_� ��� �_������ �������%' 
                           )
                        OR (    SUBSTR (o.nlsd, 1, 4) = '2924'
                            AND SUBSTR (o.nlsk, 1, 4) = '2900'
                            AND mfou_ = 300120 
                           )
                        OR (    o.nlsd LIKE '2900205%'    -- �� ������ ������ �� 16.04.2013 
                            AND o.nlsk LIKE '29003%'
                            AND mfo_ = 300465 
                           )
                        OR (    SUBSTR (o.nlsd, 1, 4) = '2603'
                            AND SUBSTR (o.nlsk, 1, 4) = '3739'
                            AND mfou_ = 300465 
                            AND LOWER (TRIM (o.nazn)) like '%������������� ����_� ��� ����_�������� �������%' 
                           )
                        OR (    SUBSTR (o.nlsd, 1, 4) in ('2900', '2600', '2620', '2650')
                            AND SUBSTR (o.nlsk, 1, 4) = '3739'
                            AND mfou_ = 300465 
                            AND LOWER (TRIM (o.nazn)) like '%������������� ����_� �� ������%' 
                           )
                        OR (    SUBSTR (o.nlsd, 1, 4) in ('2625','2909','2600')
                            AND SUBSTR (o.nlsk, 1, 4) = '2900' 
                            AND mfou_ = 300120
                           )
                        OR (    SUBSTR (o.nlsd, 1, 4) in ('2800','2900')
                            AND SUBSTR (o.nlsk, 1, 4) = '3800' 
                            AND mfou_ = 300120
                           )
                        OR (    SUBSTR(o.nlsd, 1, 4) in ('3800')
                            AND SUBSTR (o.nlsk, 1, 4) = '1819' 
                            AND mfou_ not in (300205)
                            AND lower(nazn) like '%���_���%'
                           )
                        OR (    SUBSTR(o.nlsd, 1, 4) in ('1500')
                            AND SUBSTR (o.nlsk, 1, 4) = '3540' 
                            AND mfou_ = 300120
                            AND LOWER (TRIM (o.nazn)) not like '%�������%'
                            AND LOWER (TRIM (o.nazn)) not like '%�������%'
                            AND LOWER (TRIM (o.nazn)) not like '%������%'
                           )
                        OR (    o.nlsd like '1819791%'
                            AND SUBSTR(o.nlsk, 1, 4) in ('3800') 
                            AND mfou_ = 300205 
                            AND lower(nazn) like '%���_���%'
                           )
                       ) 
                   AND o.accd = ca.acc
               GROUP BY '1', ca.rnk, o.REF, o.accd, o.nlsd, o.kv, o.acck, o.nlsk, o.nazn 
               UNION ALL -- ������ ������
	       SELECT '2' ko, ca.rnk, o.REF, o.accd, o.nlsd,
	              o.kv, o.acck, o.nlsk, o.nazn, 
                      SUM (o.s * 100) s_nom,
                      SUM (gl.p_icurval (o.kv, o.s * 100, dat_)) s_eqv
               FROM provodki o, cust_acc ca
               WHERE o.fdat = dat_
                 AND o.kv not in (959, 961, 962, 964, 980)
                 AND (   (    SUBSTR (o.nlsd, 1, 4) = '2900'
                           AND SUBSTR (o.nlsk, 1, 4) IN
                                    ('2600', '2620', '2650')
                            AND LOWER (TRIM (o.nazn)) not like '%�������%'
                            AND LOWER (TRIM (o.nazn)) not like '%�������%'
                            AND LOWER (TRIM (o.nazn)) not like '%�� ������� _���_%'
                           )
                        OR (    SUBSTR (o.nlsd, 1, 4) = '2903'
                            AND SUBSTR (o.nlsk, 1, 4) = '2900'
                           )
                        OR (    SUBSTR (o.nlsd, 1, 4) = '3540'
                            AND SUBSTR (o.nlsk, 1, 4) = '1819' 
                            AND LOWER (TRIM (o.nazn)) like '%���_���%'
                            AND mfou_ = 380764
                           )
                        OR (    SUBSTR (o.nlsd, 1, 4) = '3640'
                            AND SUBSTR (o.nlsk, 1, 4) = '1919' 
                            --AND LOWER (TRIM (o.nazn)) not like '%������%'
                            AND LOWER (TRIM (o.nazn)) not like '%�������%'
                            AND LOWER (TRIM (o.nazn)) not like '%�������%'
                            AND mfou_ = 300120
                           )
                        OR (    SUBSTR (o.nlsd, 1, 4) IN ('1819', '2800', '2900')
                            AND SUBSTR (o.nlsk, 1, 4) in ('3800')  
                            AND ( mfou_ not in (300120, 300205) --or
				  --mfou_ = 300120 and LOWER (TRIM (o.nazn)) not like '%�������%'
                                )
                            AND LOWER (TRIM (o.nazn)) not like '%������%'
                            AND LOWER (TRIM (o.nazn)) not like '%�������%'
                            AND LOWER (TRIM (o.nazn)) not like '%�������%'
                           )
                        --OR (    SUBSTR (o.nlsd, 1, 4) IN ('1500','1819')
                        --    AND SUBSTR (o.nlsk, 1, 4) in ('3540')  
                        --    AND mfou_ = 300120
                        --    AND LOWER (TRIM (o.nazn)) not like '%������%'
                        --    AND LOWER (TRIM (o.nazn)) not like '%�������%'
                        --    AND LOWER (TRIM (o.nazn)) not like '%�������%'
                        --   )
                        OR (    SUBSTR (o.nlsd, 1, 4) in ('3800')
                            AND o.nlsk LIKE '1819791%'
                            AND mfou_ = 300205
                            AND LOWER (TRIM (o.nazn)) like '%������%'
                           )
                       )
                   AND o.acck = ca.acc
              GROUP BY '2', ca.rnk, o.REF, o.acck, o.nlsk, o.kv, o.accd, o.nlsd, o.nazn 
             );
   
   -- �������� ������ ��������
   if mfou_ = 300205 then
      delete from otcn_prov_temp 
      where substr (nlsd, 1, 4) IN ('2600', '2603', '2620', '2650')
        and nlsk not like '290009228%'; 
   end if;

         --- ���� ��� ����� ������
         OPEN opl_dok;

          LOOP
            FETCH opl_dok
             INTO ko_1, ref_, acc_, nls_, kv_, acck_, nlsk_, nazn_, sum0_, sumk0_;

            EXIT WHEN opl_dok%NOTFOUND;

            IF typ_ > 0
            THEN
               if ko_1 = 1 then
                  nbuc_ := NVL (f_codobl_tobo (acc_, typ_), nbuc1_);
               end if;
               if ko_1 = 2 then
                  nbuc_ := NVL (f_codobl_tobo (acck_, typ_), nbuc1_);
               end if;
            ELSE
               nbuc_ := nbuc1_;
            END IF;

            sum0_ := gl.p_icurval(kv_, sum0_, dat_);

            if ko_1 = 1 and nlsk_ not like '1819%' and nlsk_ not like '1500%' 
            then
               -- ���� ����� � �볺��� 
               p_ins ('11' || '01', to_char (sum0_));
            end if;

            if ko_1 = 1 and (nlsk_ like '1819%' or nlsk_ like '1500%') and 
               lower(nazn_) not like '%swap%' and lower(nazn_) not like '%���%'
            then
               -- ���� ����� � �����
               p_ins ('12' || '01', to_char (sum0_));
            end if;

            if ko_1 = 1 and (nlsk_ like '1819%' or nlsk_ like '1500%') and 
               lower(nazn_) like '%���%'
            then
               -- ���� ����� � ���
               p_ins ('13' || '01', to_char (sum0_));
            end if;


            if ko_1 = 2 and nls_ not like '1819%' and nls_ not like '1919%' 
            then
               -- ���� ������� �볺���� 
               p_ins ('21' || '01', to_char (sum0_));
            end if;

            if ko_1 = 2 and (nls_ like '1819%' or nls_ like '1919%') and 
               lower(nazn_) not like '%swap%' and lower(nazn_) not like '%���%'
            then
               -- ���� ������� ������
               p_ins ('22' || '01', to_char (sum0_));
            end if;

            if ko_1 = 2 and (nls_ like '1819%' or nls_ like '1919%') and 
               lower(nazn_) like '%���%'
            then
               -- ���� ������� ���
               p_ins ('23' || '01', to_char (sum0_));
            end if;

          END LOOP;

         CLOSE opl_dok;
---------------------------------------------------
   DELETE FROM tmp_nbu
         WHERE kodf = kodf_ AND datf = dat_;

---------------------------------------------------
   INSERT INTO tmp_nbu 
   (kodf, datf, kodp, znap, nbuc) 
      SELECT kodf_, dat_, kodp, sum(znap), nbuc
        FROM rnbu_trace
       WHERE userid = userid_
      GROUP BY kodf_, dat_, kodp, nbuc ;
----------------------------------------
END p_f2g_nn;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F2G_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
