CREATE OR REPLACE PROCEDURE BARS.p_f3kx_nn (
                    dat_     DATE,
                    sheme_   VARCHAR2 DEFAULT 'G',
                    pr_op_   NUMBER DEFAULT 1
)
IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :   ��������� ������������ 3KX     ��� �� (�������������)
% COPYRIGHT   :   Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :   v.18.002          12.03.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
���������: Dat_ - �������� ����
      sheme_ - ����� ������������
      pr_op_ - ������� ��������: 1 - ���i���/������ ������,
                                 2 - ����������� �i� ����������i�
                                 3 - ��i ������ii
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

12.03.2018  ��������e �� ������������ �������� �� 3739
03.03.2018  � �������� ��� ����������.������ �� ��������� ��������� ������/��������
15.02.2018  �� ��������� p_f70_nn  ��  20.11.2017  ��� ��

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   userid_      number;
   mfo_         number;
   mfou_        number;
   ourOKPO_     varchar2(14);
   ourGLB_      varchar2(3);

   gr_sumn_     number        := 1;        --  ��������� ��� ������� ������
   gr_sum_      number        := 1;        --  ��������� ��� ����� ������
   kons_sum_    number;

   kodp_      varchar2(10);
   znap_      varchar2(70);
   kodf_      VARCHAR2 (2)   := '3K';
   nbuc_      varchar2(12);
   nbuc1_     varchar2(12);
   kurs_      number;
   kurs1_     number;

   pr_s3_           number;               -- ���� ��� ����������� ������� ���� S3 ����.ZAYAVKA
   is_swap_tag_     number;               -- ���� ��� ����������� ������� ���� SWAP_TAG ����.FX_DEAL
   is_f092_         number;               -- ���� ��� ����������� ������� ���� F092 ����.ZAYAVKA

   sql_z      varchar2(200);
   typ_       number;
   rez_       number;
   dig_       number;
   bsum_      number;
-----------------------------
   TYPE  type_ref_curs  IS REF CURSOR;

   rfc1_          type_ref_curs;
   v_sql_      varchar2(2000);
   f089_      varchar2(1);
   f091_      varchar2(1);
   r030_      number;
   t071_      number;
   k020_      varchar2(20);
   k021_      varchar2(1);
   q001_      varchar2(38);
   q024_      varchar2(1);
   d100_      varchar2(2);
   k_days_    number;
-----------------------------
   ko_        varchar2(2);                  -- ������ ������ii � ������i������ i��������
   kod_obl_   varchar2(2);
   rnk_       number;
   okpo_      varchar2(14);
   nmk_       varchar2(70);
   k040_      varchar2(3);
   adr_       varchar2(70);
   k110_      varchar2(5);
   codc_      number;
   kv1_       number;
   sum0_      number;
   sum1_      number;
   sumk0_     number;
   sumk1_     number;
   ko_1       varchar2(2);                  -- ������ ������ii � ������i������ i��������
   ref_       number;
   refd_      number;
   acc_       number;
   nls_       varchar2(15);
   kv_        number;
   acck_      number;
   nlsk_      varchar2(15);
   nazn_      varchar2(160);

   koldop_    number;
   s0_        number;
   n_         number               := 10;
   nnnn_      number               := 0;
   tag_       varchar2(5);
   val_       varchar2(70);
   d1#D3_     varchar2(70);
   d1#70_     varchar2(70);
   d1#3K_     varchar2(70);
   a2_        varchar2(70);
   a3_        varchar2(70);

   ser_       person.ser%TYPE;
   numdoc_    person.numdoc%TYPE;
--������ �� ������������
   CURSOR c_main
   IS
      SELECT   t.ko,
               nvl(decode(substr(b.b040,9,1),'2',substr(b.b040,15,2),substr(b.b040,10,2)),nbuc_),
               c.rnk, c.okpo, c.nmk, TO_CHAR (c.country), c.adr,
               NVL (c.ved, '00000'), c.codcagent,
               1,
               SUM (t.s_eqv),
               SUM (gl.p_icurval (t.kv, t.s_kom, dat_))     --����� � ������� ���.���
          FROM OTCN_PROV_TEMP t, customer c, tobo b      --branch b
         WHERE t.rnk = c.rnk
           and c.tobo = b.tobo(+)                        --c.branch = b.branch
      GROUP BY t.ko,
               nvl(decode(substr(b.b040,9,1),'2',substr(b.b040,15,2),substr(b.b040,10,2)),nbuc_),
               c.rnk,
               c.okpo,
               c.nmk,
               TO_CHAR (c.country),
               c.adr,
               NVL (c.ved, '00000'),
               c.codcagent,
               1
      ORDER BY 2, 3;

--- �������/������ ������i�����i ������ i ����������� �i� ����������i�
   CURSOR opl_dok
   IS
      SELECT   t.ko, t.REF, t.acck, t.nlsk, t.kv, t.accd, t.nlsd, t.nazn,
               SUM (t.s_nom),
               SUM (t.s_kom)
          FROM OTCN_PROV_TEMP t
         WHERE t.rnk = rnk_
      GROUP BY t.ko, t.REF, t.acck, t.nlsk, t.kv, t.accd, t.nlsd, t.nazn;

-------------------------------------------------------------------
   FUNCTION f_s180_day (p_days IN NUMBER)
       RETURN  varchar2
   IS
      l_ret_val    varchar2(1);
   BEGIN
         IF    (p_days < 1) THEN              l_ret_val :='1';
         ELSIF (p_days < 2) THEN              l_ret_val :='2';
         ELSIF (p_days < 8) THEN              l_ret_val :='3';
         ELSIF (p_days < 22) THEN             l_ret_val :='4';
         ELSIF (p_days < 32) THEN             l_ret_val :='5';
         ELSIF (p_days < 93) THEN             l_ret_val :='6';
         ELSIF (p_days < 184) THEN            l_ret_val :='7';
         ELSIF (p_days < 275) THEN            l_ret_val :='A';
         ELSIF (p_days < 366) THEN            l_ret_val :='B';
         ELSIF (p_days < 549) THEN            l_ret_val :='C';
         ELSIF (p_days < 732) THEN            l_ret_val :='D';
         ELSIF (p_days < 1098) THEN           l_ret_val :='E';
         ELSIF (p_days < 1830) THEN           l_ret_val :='F';
         ELSIF (p_days < 3660) THEN           l_ret_val :='G';
         ELSE
            l_ret_val :='H';
         END IF;
         return(l_ret_val);
   END;
-------------------------------------------------------------------
   PROCEDURE p_ins (p_np_ IN NUMBER, p_kodp_ IN VARCHAR2, p_znap_ IN VARCHAR2)
   IS
      l_kodp_   VARCHAR2 (10);
   BEGIN
      l_kodp_ := p_kodp_ || LPAD (TO_CHAR (p_np_), 3, '0');

      if f089_ ='2'  then
        INSERT INTO rnbu_trace
                  ( nls, kv, odate, kodp, znap, nbuc, ref, rnk, comm, acc )
           VALUES ( nls_, kv_, dat_, l_kodp_, p_znap_, nbuc_, ref_, rnk_, to_char(refd_), acc_ );
      else
        INSERT INTO rnbu_trace
                  ( nls, kv, odate, kodp, znap, nbuc, ref, rnk, comm, acc )
           VALUES ( '', kv_, dat_, l_kodp_, p_znap_, nbuc_, 0, 0, '�����������', 0 );
      end if;

   END;

-------------------------------------------------------------------
   PROCEDURE p_tag (
      p_i_       IN       NUMBER,
      p_value_   IN OUT   VARCHAR2,
      p_kodp_    OUT      VARCHAR2,
      p_ref_     IN       NUMBER DEFAULT NULL
   )
   IS
   BEGIN
      IF p_i_ = 1
      THEN
         p_kodp_ := 'F092';                  --40

         p_value_ :=
                    NVL (LPAD (TRIM (SUBSTR (d1#3K_, 1, 3)), 3, '0'), '000');

/*         IF ko_ = 1
         THEN
            p_value_ :=
                    NVL (LPAD (TRIM (SUBSTR (p_value_, 1, 2)), 2, '0'), '00');
         END IF;
*/
         IF ko_ = 2
         THEN
/*            if d1#D3_ is not null then
                p_value_ :=
                        NVL (LPAD (TRIM (SUBSTR (d1#D3_, 1, 2)), 2, '1'), '00');
            else
                p_value_ :=
                        NVL (LPAD (TRIM (SUBSTR (p_value_, 1, 2)), 2, '1'), '00');
            end if;
*/
            if nls_ like '2900205%' and nlsk_ like '29003%' or
               --nls_ like '2909%' and nlsk_ like '2900%' or
               nls_ like '2625%' and nlsk_ like '2900%' or
               nls_ like '2625%' and nlsk_ like '3800%'
            then
               p_value_ := '216';
               d1#D3_ := '16';
            end if;

            if ( nls_ like '2610%'  or  nls_ like '2615%'  or
                 nls_ like '2630%'  or  nls_ like '2635%'  or
                 nls_ like '2525%'  or  nls_ like '2546%' )
               and nlsk_ like '3800%'
            then
               p_value_ := '238';
               d1#D3_ := '38';
            end if;
         END IF;

/*         IF ko_ = 3
         THEN
            p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 2), '00');
         END IF;
*/
         d1#70_ := p_value_;
      ELSIF p_i_ = 2
      THEN
         p_kodp_ := 'Q003';                          --51
         p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 70), 'N �����.');

         if ko_ = 2 and (trim(p_value_) is null or trim(p_value_)='N �����.')
         then
            a2_ := ' ';
            IF pr_s3_ >= 1
            THEN
               sql_z := 'SELECT contract, to_char(id) '
                     || 'FROM ZAYAVKA  '
                     || 'WHERE REF = :ref_';

               BEGIN
                  EXECUTE IMMEDIATE sql_z
                     INTO p_value_, a2_
                  USING ref_ ;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                 a2_ := ' ';
               END;
            END IF;

            if trim(p_value_) is null or trim(p_value_)='N �����.' then  --and trim(a2_) is not null then
               p_value_ := a2_;
            end if;
         end if;
      ELSIF p_i_ = 3
      THEN
         p_kodp_ := 'Q007';                          --52
         p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 70), 'DDMMYYYY');

         if ko_ = 2 and (trim(p_value_) is null or trim(p_value_)='DDMMYYYY')
         then
            a3_ := ' ';
            IF pr_s3_ >= 1
            THEN
               sql_z := 'SELECT NVL(to_char(datz,''DDMMYYYY''),''DDMMYYYY''),'
                     || '       NVL(to_char(fdat,''DDMMYYYY''),''DDMMYYYY'') '
                     || 'FROM ZAYAVKA  '
                     || 'WHERE REF = :ref_';
               BEGIN
                  EXECUTE IMMEDIATE sql_z
                     INTO p_value_, a3_
                  USING ref_ ;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  a3_ := ' ';
               END;
            END IF;

            if (trim(p_value_) is null or trim(p_value_)='DDMMYYYY') then --and trim(a3_) is not null then
               p_value_ := a3_;
            end if;
         end if;
      ELSIF p_i_ = 4
      THEN                null;
/*         p_kodp_ := '60';        */

      ELSIF p_i_ = 5
      THEN                null;
/*         p_kodp_ := '61';        */
      ELSIF p_i_ = 7
      THEN                null;
/*         p_kodp_ := '63';        */
      ELSIF p_i_ = 8
      THEN               null;
/*         p_kodp_ := '64';        */

      ELSIF p_i_ = 9
      THEN               null;
/*         p_kodp_ := '65';        */
      ELSIF p_i_ = 10
      THEN             null;
/*         p_kodp_ := '66';        */

      ELSIF p_i_ = 11
      THEN             null;
         -- ���� #70
/*         IF dat_ >= TO_DATE ('01-09-2014','dd-mm-yyyy') and pr_op_ = 1
         THEN
            p_kodp_ := '71';
            p_value_ :=
                  NVL (SUBSTR (TRIM (p_value_), 1, 70), '01');
         END IF;                   */
         -- ���� #D3
/*         IF dat_ >= dat_Izm2_ and pr_op_ = 3
         THEN
            p_kodp_ := '42';
            p_value_ :=
                  NVL (SUBSTR (TRIM (p_value_), 1, 70), '01');
         END IF;                   */
     ELSIF p_i_ = 13
     THEN
           p_kodp_ := 'Q006';
        --��� ������� ������ i ����������� �i� ����������i� ����� ��������

        IF dat_ >= TO_DATE('13082007','ddmmyyyy') AND ko_ = 2 then
           p_kodp_ := 'Q006';
           p_value_ :=NVL (SUBSTR (TRIM (p_value_), 1, 70), '');

           if trim(p_value_) is null then
              BEGIN
                 select DECODE(substr(lower(txt),1,13), '������� ���.�', '������ ������� �������',txt)
                    into p_value_
                 from kod_d3_1
                 where p40 = d1#D3_;
              EXCEPTION WHEN NO_DATA_FOUND THEN
                 null;
              END;

           end if;

        END IF;

--        IF trim(p_value_) is NULL and mfo_ in (300465,333368)
--        THEN
--           p_value_ := substr(nazn_,1,70);
--        END IF;

        if mfo_ = 300465 and nlsk_ like '2900%' and nls_ like '2909%'
        then
           p_value_ := '555';
        end if;

        if nls_ like '2900205%' and nlsk_ like '29003%'
        then
           p_value_ := '�i����� ������';
        end if;

        IF mfou_ = 300465 and ko_ = 2
        THEN
           case
              when d1#D3_ = '11' then p_value_ := '�������';
              when d1#D3_ = '12' then p_value_ := '������������ �����';
              when d1#D3_ = '13' then p_value_ := '������ �����';
              when d1#D3_ = '14' then p_value_ := '������ ��, ������ ������� �� ����';
              when d1#D3_ = '15' then p_value_ := '������ ����� �����';
              when d1#D3_ = '16' then p_value_ := '������� � ����� �����';
              when d1#D3_ = '18' then p_value_ := '�������� ����� �������� ������ �� �����������';
              when d1#D3_ = '19' then p_value_ := '������ �볺��� ����� �� �����������';
              when d1#D3_ = '20' then p_value_ := '������ ��������� �����������';
              when d1#D3_ = '37' then p_value_ := '������ ��������';
              when d1#D3_ = '38' then p_value_ := '��������.������/�����.������i���i� � i�.�����i,��i������ � ���.�����i';
            else
               p_value_ := null;
               d1#D3_ := null;
            end case;
        END IF;
      ELSE
         p_kodp_ := 'NN';
      END IF;

      IF p_kodp_ IN ('52', '60') AND length(trim(p_value_))=9
      THEN
         p_value_ :=
               SUBSTR (p_value_, 1, 1)
            || SUBSTR (p_value_, 3, 2)
            || SUBSTR (p_value_, 6, 4);
      END IF;

      IF p_kodp_ IN ('52', '60') AND length(trim(p_value_))=10
      THEN
         p_value_ :=
               SUBSTR (p_value_, 1, 2)
            || SUBSTR (p_value_, 4, 2)
            || SUBSTR (p_value_, 7, 4);
      END IF;

   END;

BEGIN

   EXECUTE IMMEDIATE 'ALTER SESSION SET NLS_NUMERIC_CHARACTERS=''.,''';
   logger.info ('P_F3KX begin for date = '||to_char(dat_, 'dd.mm.yyyy'));
-------------------------------------------------------------------
   userid_ := user_id;

   EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';

   EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_PROV_TEMP';
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
   kurs_ := f_ret_kurs (840, dat_);
   kurs1_ := f_ret_kurs (840, dat_);

   kons_sum_ := gl.p_icurval (840, 100000, dat_);

   ourOKPO_ := lpad(F_Get_Params('OKPO',null), 8, '0');

   BEGIN
     select lpad(to_char(glb), 3, '0')
        into ourGLB_
     from rcukru
     where mfo=mfo_;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      ourGLB_ := null;
   END;

-- ����������� ������� ���� S3 ����.ZAYAVKA
   SELECT COUNT (*)
     INTO pr_s3_
     FROM all_tab_columns
    WHERE owner = 'BARS' AND table_name = 'ZAYAVKA' AND column_name = 'S3';

-- ����������� ������� ���� SWAP_TAG ����.FX_DEAL
   SELECT COUNT (*)
     INTO is_swap_tag_
     FROM all_tab_columns
    WHERE owner = 'BARS' AND table_name = 'FX_DEAL' AND column_name = 'SWAP_TAG';

-- ����������� ������� ���� F092 ����.FX_DEAL
   SELECT COUNT ( * )
     INTO is_f092_
     FROM all_tab_columns
    WHERE owner = 'BARS' AND table_name = 'ZAYAVKA' AND column_name = 'F092';

   -- ����� ��������, ��������������� �������
   INSERT INTO OTCN_PROV_TEMP
               (ko, rnk, REF, acck, nlsk, kv, accd, nlsd, nazn, s_nom, s_eqv)
      SELECT *
        FROM ( 		--������ ������
               SELECT  '1' ko, o.rnkk, o.REF, o.acck, o.nlsk,
                       o.kv, o.accd, o.nlsd, o.nazn,
                       SUM (o.s * 100) s_nom,
                       SUM (gl.p_icurval (o.kv, o.s * 100, dat_)) s_eqv
                  FROM provodki_otc o
                 WHERE o.fdat = dat_
                   AND o.kv not in (959, 961, 962, 964, 980)
                   AND (   (    SUBSTR (o.nlsd, 1, 4) = '2900'
                            AND SUBSTR (o.nlsk, 1, 4) IN
                                     ('1600', '1602', '2520', '2530',
                                      '2541', '2542', '2544', '2545',
                                      '2600', '2602', '2620', '2650')
                            AND LOWER (TRIM (o.nazn)) not like '%�������%'
                            AND LOWER (TRIM (o.nazn)) not like '%�������%'
                            AND LOWER (TRIM (o.nazn)) not like '%�� ������� _���_%'
                           )
                        OR (    SUBSTR (o.nlsd, 1, 4) = '2903'
                            AND SUBSTR (o.nlsk, 1, 4) = '2900'
                           )
                        OR (    o.nlsd LIKE '29003%'    -- 21/11/2016 ��������� SC-0007882 �� ���.zip
                            AND o.nlsk LIKE '26039301886%'
                            AND mfo_ = 300465
                           )
                       )
              GROUP BY '1', o.rnkk, o.REF, o.acck, o.nlsk, o.kv, o.accd, o.nlsd, o.nazn
              UNION ALL -- ������ ������
              SELECT   '2' ko, o.rnkd, o.REF, o.accd, o.nlsd, o.kv, o.acck, o.nlsk, o.nazn,
                       SUM (o.s * 100) s_nom,
                       SUM (gl.p_icurval (o.kv, o.s * 100, dat_)) s_eqv
                  FROM provodki_otc o
                 WHERE o.fdat = dat_
                   AND o.kv not in (959, 961, 962, 964, 980)
                   AND (   (    SUBSTR (o.nlsk, 1, 4) = '2900'
                            AND
                                SUBSTR (o.nlsd, 1, 4) IN
                                     ('1600', '1602', '2520', '2530',
                                      '2541', '2544', '2555', '2600', '2603',
                                      '2620', '2650', '3640')
                            AND LOWER (TRIM (o.nazn)) not like '%�������%'
                            AND LOWER (TRIM (o.nazn)) not like '%�������%'
                            AND LOWER (TRIM (o.nazn)) not like '%���_���%'
                           )
                        OR (    SUBSTR (o.nlsk, 1, 4) = '2900'
                            AND SUBSTR (o.nlsd, 1, 4) in ('2062','2063','2072','2073'))
                        OR (    SUBSTR (o.nlsk, 1, 4) = '2903'
                            AND SUBSTR (o.nlsd, 1, 4) = '2900'
                           )
                        OR (    SUBSTR (o.nlsk, 1, 4) = '2900'  -- 14.12.2012 ���� ������� ������ ��� ���������
                            AND SUBSTR (o.nlsd, 1, 4) = '2909'  -- 28.12.2012 ��� ���� (����� ���)
                           )
                        OR (    SUBSTR (o.nlsd, 1, 4) = '2900'
                            AND SUBSTR (o.nlsk, 1, 4) = '2900'
                            AND mfou_ = 300465 AND mfou_ <> mfo_
                            AND LOWER (TRIM (o.nazn)) like '%������%'
                          )
                        OR (    o.nlsd LIKE '2900205%'    -- �� ������ ������ �� 16.04.2013
                            AND o.nlsk LIKE '29003%'
                            AND mfo_ = 300465
                           )
                        OR (    SUBSTR (o.nlsd, 1, 4) = '2603'
                            AND SUBSTR (o.nlsk, 1, 4) = '3739'
                            AND mfou_ = 300465
                            AND ( LOWER (TRIM (o.nazn)) like '%�������%����_� ��� ����_�������� �������%' OR
                                  LOWER (TRIM (o.nazn)) like '%�������%����_�%������%'
                                )
                           )
                        OR (    SUBSTR (o.nlsd, 1, 4) in ('2900', '2600', '2620', '2650')
                            AND SUBSTR (o.nlsk, 1, 4) = '3739'
                            AND mfou_ = 300465
                            AND LOWER (TRIM (o.nazn)) like '%�������%����_�%������%'
                           )
                        OR (    SUBSTR (o.nlsd, 1, 4) in ('2610','2615', '2620','2625',
                                                          '2630','2635', '2525','2546')
                            AND SUBSTR (o.nlsk, 1, 4) = '3800'
                            AND mfou_ = 300465
                           )
                       )
              GROUP BY '2', o.rnkd, o.REF, o.accd, o.nlsd, o.kv, o.acck, o.nlsk, o.nazn );

   commit;
   -- ��� �� ��������� ��������� �������� ���� �� 2600/2620/2650 �� 2900
   -- ���� ������ ������ �� ������ ������ �� �� ���� �� ����� �볺��� � ��������� +/- 3 ���
   if mfou_ = 300465 and mfo_ = 351823  then

      DELETE FROM otcn_prov_temp a
      WHERE
           ( select max(id) from zayavka z
              where z.dk=2 and z.s2=a.s_nom and z.kv2=a.kv
                and abs(z.fdat-dat_)<4 and z.acc1=a.accd) is not null
       and SUBSTR (a.nlsk, 1, 4) in ('2600', '2620', '2650')
       and a.nlsd like '2900%';
   end if;

   -- ������� �������� ���� �� 2900 �� 2900 ��� ������� ���� ��� �� ��
   if mfo_ <> 300465  then

      DELETE FROM otcn_prov_temp a
      WHERE a.nlsd like '2900%'
        and a.nlsk like '2900%'
        and a.ko = 2
        and a.ref not in (SELECT ref
                          FROM provodki
                          WHERE ref=a.ref
                            and (nlsd like '2901%' or nlsk like '2901%'))
        and a.ref not in (SELECT ref
                          FROM operw
                          WHERE ref=a.ref
                            and tag ='D#39'
                            and trim(value) is not null
                            and trim(value) not in ('110','120','131','132'));
   end if;

   -- ������� ��� �������� �� 2909 �� 2900 ����� �� 2909 (OB22=56) �� 2900 (OB22=01) C�������
   if mfou_ = 300465
   then
      delete from otcn_f70_temp a
      where a.nlsd like '2900%'
        and a.nlsk like '2909%'
        and a.accd in ( select acc
                        from specparam_int
                        where acc in (select acc
                                      from accounts
                                      where nbs='2900')
                          and NVL(trim(ob22),'00') <> '01'
                      );
   end if;

   if mfou_ = 300465  then   --and pr_op_ =3  then

      delete from otcn_prov_temp a
      where a.nlsk like '2900%'
        and a.nlsd like '3739%'
        and exists ( select 1
                     from otcn_prov_temp b
                     where b.accd = a.acck
                       and b.s_nom = a.s_nom
                   )
        and a.ref in ( select ref_sps
                       from zayavka
                     );
   end if;

   -- 08.06.2017 ��� �������
   -- ��� ��������������� �� 2625 �� 3800 �������� ��������
   -- ������ � ���.���������� OW_AM � � �������� ���� ����� "/980"
   if mfou_ = 300465  then  -- and pr_op_ = 3

      delete from otcn_prov_temp a
      where a.nlsk like '2625%'
        and a.nlsd like '3800%'
        and not exists ( select 1
                         from operw b
                         where b.ref = a.ref
                           and b.tag like 'OW_AM%'
                           and b.value like '%/980%'
                       );
   end if;


   IF pr_s3_ >= 1  THEN

      sql_z :=
            'UPDATE OTCN_PROV_TEMP t '
         || 'SET t.s_kom=(SELECT z.s3 FROM ZAYAVKA z WHERE z.REF = t.REF) '
         || 'WHERE t.REF IN (SELECT REF FROM ZAYAVKA WHERE NVL(s3,0) <> 0)';

      EXECUTE IMMEDIATE sql_z;
   END IF;

   -- 28.05.2014 ��� 300465 ��������� �������� �� ���������
   -- c 26.05.2014 ���������� ������ �� ���������
   IF mfou_ = 300465  THEN

      sql_z :=
            'UPDATE OTCN_PROV_TEMP t '
         || 'SET t.s_nom = 0, t.s_eqv = 0 '
         || 'WHERE t.REF IN (SELECT REF FROM ZAYAVKA WHERE dk = 3)';

      EXECUTE IMMEDIATE sql_z;
   END IF;

   OPEN c_main;

   LOOP
      FETCH c_main
       INTO ko_, kod_obl_, rnk_, okpo_, nmk_, k040_, adr_, k110_, codc_, kv1_, sum1_, sumk1_;

      EXIT WHEN c_main%NOTFOUND;

      sum1_ := sum1_ - NVL (sumk1_, 0);
      rez_ := MOD (codc_, 2);
      k021_ :='1';

      if length(trim(okpo_)) <= 8
      then
         okpo_:=lpad(trim(okpo_),8,'0');
         k021_ :='1';
      else
         okpo_:=lpad(trim(okpo_),10,'0');
         k021_ :='2';
      end if;

      q024_ :='2';
      -- ��� ������ �� ���� ���� �� RCUKRU(IKOD)
      -- ���������� ��� ����� ���� GLB
      if codc_ in (1,2)
      then
         q024_ :='1';
         k021_ :='3';
         BEGIN
            select glb
               into okpo_
            from rcukru
            where trim(ikod)=trim(okpo_)
              and rownum=1;

--            if okpo_ ='1'  then  q024_ :='3';  end if;

         EXCEPTION WHEN NO_DATA_FOUND THEN
            null;
         END;

      end if;

      -- ��� ������ ���������� �� ������� OKPO
      --���������� ����� � ����� �������� �� PERSON
      if codc_ = 5 and trim(okpo_) in ('99999','999999999','00000','000000000','0000000000')
      then
         BEGIN
            select ser, numdoc
               into ser_, numdoc_
            from person
            where rnk = rnk_
              and rownum=1;

            okpo_ := substr (trim(ser_)||trim(numdoc_), 1, 14);
            k021_ :='6';
         EXCEPTION WHEN NO_DATA_FOUND THEN
            null;
         END;
      end if;

      IF (   ( ko_ = '1' AND ROUND (sum1_ / kurs_, 0) > gr_sum_ )
          OR ( ko_ = '2' AND ROUND (sum1_ / kurs1_, 0) > gr_sumn_ )
         )   THEN

         dig_ := f_ret_dig (kv_) * 100; -- ����� ������ ���� � �������� ������

         ---�������/������� ����������� ������
         OPEN opl_dok;

         LOOP
            FETCH opl_dok
             INTO ko_1, ref_, acc_, nls_, kv_, acck_, nlsk_, nazn_, sum0_, sumk0_;

            EXIT WHEN opl_dok%NOTFOUND;

            IF ko_ = ko_1 and ( (ROUND (GL.P_ICURVAL(kv_, sum0_, dat_) / kurs1_, 0) > gr_sumn_) OR
                                (ROUND (GL.P_ICURVAL(kv_, sum0_, dat_) / kurs_, 0) > gr_sum_)
                              )
            THEN

               IF typ_ > 0  THEN

                  nbuc_ := NVL (f_codobl_tobo (acc_, typ_), nbuc1_);
               ELSE
                  nbuc_ := nbuc1_;
               END IF;

               s0_ := to_char(sum0_/100, '999999999999.99');

               nnnn_ := nnnn_ + 1;
               sum0_ := sum0_ - NVL (sumk0_, 0);
               f089_ := '2';                          --������������������� ������

               if ko_ = 2
               then
                   BEGIN
                      SELECT SUBSTR (VALUE, 1, 70)
                        INTO d1#D3_
                        FROM operw
                       WHERE REF = ref_ AND tag = 'D1#D3';
                   EXCEPTION
                      WHEN NO_DATA_FOUND
                      THEN
                      BEGIN
                         SELECT  meta
                            INTO d1#D3_
                         FROM zayavka
                         WHERE ref_ in (ref, ref_sps);
                      EXCEPTION
                         WHEN NO_DATA_FOUND
                         THEN
                         d1#D3_ := NULL;
                      END;
                   END;
               else
                  d1#D3_ := NULL;
               end if;

               if ko_ = 2 and   -- mfo_ in (353553, 313957) and
                  nls_ like '2600%' and nlsk_ like '2900%' and
                  d1#D3_ is null
               then
                  BEGIN
                     SELECT  z.meta
                        INTO d1#D3_
                     FROM provodki_otc p, zayavka z
                     WHERE p.fdat = dat_
                       and p.nlsd = nlsk_
                       and p.s*100 = sum0_
                       and p.ref in (z.ref, z.ref_sps)
                       and rownum =1;
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                     d1#D3_ := NULL;
                  END;
               end if;

               -- �������� ���� �� ��� ������ �������� ���. ���������
               SELECT count( * )
                  INTO koldop_
               FROM operw
               WHERE REF = ref_ AND tag like 'D_#70';

               if koldop_ > 0
               then
                  refd_ := ref_;
               else
                  if ko_ = 2 and nls_ like '2600%' and nlsk_ like '2900%'
                  then
                     begin
                        select ref
                           into refd_
                        from provodki p
                        WHERE fdat = dat_
                          AND accd = acck_
                          AND kv=kv_
                          AND s = s0_
                          AND EXISTS (SELECT 1
                                      FROM operw o
                                      WHERE o.REF = p.ref AND tag like 'D_#70')
                          AND rownum=1;
                     exception
                               when no_data_found then
                        refd_ := null;
                     end;
                  else
                     refd_ := null;
                  end if;
               end if;

               d1#3K_ := null;
               BEGIN
                  SELECT SUBSTR (VALUE, 1, 70)
                    INTO d1#3K_
                    FROM operw
                   WHERE REF = refd_ AND tag = 'D1#3K';
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     d1#3K_ := NULL;
               END;
               if ko_ =1  and d1#3K_ is null  then

                   if is_f092_ >=1  then

                      sql_z := 'SELECT F092 '
                            || 'FROM ZAYAVKA  '
                            || 'WHERE REF = :ref_ and nvl(dk, 1) = 1';

                      begin
                          EXECUTE IMMEDIATE sql_z
                             INTO d1#3K_
                            USING ref_ ;
                      exception
                          WHEN NO_DATA_FOUND  THEN
                                       d1#3K_ := NULL;
                      end;
                   else
                      d1#3K_ :='000';
                   end if;

               end if;
               if ko_ =2  and d1#3K_ is null  then

                   if is_f092_ >=1  then

                      sql_z := 'SELECT F092 '
                            || 'FROM ZAYAVKA  '
                            || 'WHERE :ref_ in (ref, ref_sps) and nvl(dk, 1) = 2';

                      begin
                          EXECUTE IMMEDIATE sql_z
                             INTO d1#3K_
                            USING ref_ ;
                      exception
                          WHEN NO_DATA_FOUND  THEN
                                       d1#3K_ := NULL;
                      end;
                   else
                      d1#3K_ :='000';
                   end if;

               end if;

         if  mfo_ =300465  and ko_='2' and nls_ ='2900205'
                                       and nlsk_='29003'
         then
               f089_ :='1';
               p_ins (nnnn_, 'F091', '4');
               p_ins (nnnn_, 'R030', LPAD (kv_, 3,'0'));
               p_ins (nnnn_, 'T071', TO_CHAR (sum0_));
               p_ins (nnnn_, 'K020', 'k');
               p_ins (nnnn_, 'K021', '#');
               p_ins (nnnn_, 'Q024', '2');
               p_ins (nnnn_, 'D100', '00');
               p_ins (nnnn_, 'S180', '#');
               p_ins (nnnn_, 'F089', f089_);
               p_ins (nnnn_, 'F092', '216');

               f089_ :='2';

         elsif mfo_ =322669  and ko_='2' and nls_ ='29008801905'
                                         and nlsk_ like '2900%'
         then
               f089_ :='1';
               p_ins (nnnn_, 'F091', '4');
               p_ins (nnnn_, 'R030', LPAD (kv_, 3,'0'));
               p_ins (nnnn_, 'T071', TO_CHAR (sum0_));
               p_ins (nnnn_, 'K020', 'k');
               p_ins (nnnn_, 'K021', '#');
               p_ins (nnnn_, 'Q024', '2');
               p_ins (nnnn_, 'D100', '00');
               p_ins (nnnn_, 'S180', '#');
               p_ins (nnnn_, 'F089', f089_);
               p_ins (nnnn_, 'F092', '216');

               f089_ :='2';

         elsif ko_='2' and nlsk_ like '3739%' and d1#3K_='216' and sum1_< kons_sum_ 
         then
               f089_ :='1';
               p_ins (nnnn_, 'F091', '4');
               p_ins (nnnn_, 'R030', LPAD (kv_, 3,'0'));
               p_ins (nnnn_, 'T071', TO_CHAR (sum0_));
               p_ins (nnnn_, 'K020', 'k');
               p_ins (nnnn_, 'K021', '#');
               p_ins (nnnn_, 'Q024', '2');
               p_ins (nnnn_, 'D100', '00');
               p_ins (nnnn_, 'S180', '#');
               p_ins (nnnn_, 'F089', f089_);
               p_ins (nnnn_, 'F092', '216');

               f089_ :='2';

         else
--               if (d6#70_ is null or d6#70_ <> '804') and ROUND (sum0_/dig_, 0) >= 1
--               if  round(sum0_, 0) >= 1
--               then
                  -- ��� ��������
                  p_ins (nnnn_, 'F091', (case when ko_=1 then '3'  else '4'  end));
                  -- ��� ������
                  p_ins (nnnn_, 'R030', LPAD (kv_, 3,'0'));

                  -- ���� �  ����� ������ (��� 11)
                  p_ins (nnnn_, 'T071', TO_CHAR ( sum0_ ));
--                  p_ins (nnnn_, 'T071', TO_CHAR (ROUND (sum0_ / dig_, 0)));

                  -- ���� ��i����
                  IF rez_ = 0 and trim(okpo_) is NULL -- ��� ����������i�
                  THEN
                     okpo_ := '0';
                  END IF;

                  if okpo_ = ourOKPO_ then
                     okpo_ := ourGLB_;
                     codc_ := 1 ;
                     k021_ :='3';
                  end if;

	          p_ins (nnnn_, 'K020', lpad(TRIM (okpo_),10,'0'));
	          p_ins (nnnn_, 'K021', k021_);

                  p_ins (nnnn_, 'Q001', TRIM (nmk_));       -- ����� ��i����
                  p_ins (nnnn_, 'Q024', q024_);             -- ��� �����������
                  p_ins (nnnn_, 'D100', '00');              -- ��� ���� ������� ��������
                  p_ins (nnnn_, 'S180', '#');               -- ����� ������� ��������
                  p_ins (nnnn_, 'F089', f089_);             -- �����������
    
                  n_ := 13;
                  
                  FOR i IN 1 .. n_
                  LOOP
                     IF i < 10
                     THEN
                        tag_ := 'D' || TO_CHAR (i) || '#70';
                     ELSIF i = 10
                     THEN
                        tag_ := 'DA#70';
                     ELSIF i = 11
                     THEN
                        tag_ := 'DB#70';
                     ELSIF i = 12
                     THEN
                        tag_ := 'DC#70';
                     ELSE
                        tag_ := 'DD#70';
                     END IF;
    
                     -- ��� ������� ����� ��� ���.��������� (D1#70 - DA#70)
                     IF ko_ = 1  AND i in (1, 2, 3, 13) THEN
                        if i !=1 then
                          BEGIN
                             SELECT SUBSTR (VALUE, 1, 70)
                               INTO val_
                               FROM operw
                              WHERE REF = refd_ AND tag = tag_;
                          EXCEPTION
                             WHEN NO_DATA_FOUND
                             THEN
                                val_ := NULL;
                          END;
                        else 
                           val_ := d1#3K_;
                        end if;
                        -- ��� ��������� �� default-��������
                        p_tag (i, val_, kodp_, ref_);
                        -- ����� ���������
                        p_ins (nnnn_, kodp_, val_);
     
                     END IF;
     
                     -- ��� ������� ����� ���.��������� (D1#70)
                     -- � 13.08.2007 ����� ����� ���.��������� D2#70,D3#70
--                     IF   ko_ = 2 AND i in (1, 11, 13)
                     IF   ko_ = 2 AND i in (1, 13)
                     THEN
                        if i !=1 then
                          BEGIN
                             SELECT SUBSTR (VALUE, 1, 70)
                               INTO val_
                               FROM operw
                              WHERE REF = refd_ AND tag = tag_;
                          EXCEPTION
                             WHEN NO_DATA_FOUND
                             THEN
                                val_ := NULL;
                          END;
                        else  
                           val_ := d1#3K_;
                        end if;
                        -- ��� ��������� �� default-��������
                        p_tag (i, val_, kodp_, ref_);
                        -- ����� ���������
                        p_ins (nnnn_, kodp_, val_);
                     END IF;
                  END LOOP;
--               end if;

         end if;

            END IF;

         END LOOP;

         CLOSE opl_dok;

      END IF;

   END LOOP;

   CLOSE c_main;

   f089_ :='1';
--   ������������  ��������  �� rnbu_trace    �������� 216 ��� ��������
   for u in ( select f091, r030, f092, sum(t071) t071
                from ( select *
                         from ( select substr(kodp,5,3) ekp_2,
                                       substr(kodp,1,4) ekp_1, znap 
                                  from rnbu_trace
                              )
                              pivot
                              ( max(trim(znap))
                                  for ekp_1 in ( 'F091' as F091, 'R030' as R030, 'T071' as T071,
                                                 'K020' as K020, 'K021' as K021, 'Q001' as Q001,
                                                 'Q024' as Q024, 'D100' as D100, 'S180' as S180,
                                                 'F089' as F089, 'F092' as F092, 
                                                 'Q003' as Q003, 'Q007' as Q007, 'Q006' as Q006 )
                              )   
                        where  f091 ='4' and f092 ='216' and k021 in ('2','6') and
                               gl.p_icurval (r030, t071, dat_)< kons_sum_ 
                             or
                               f091 ='4' and f092 ='216' and k020 ='k' and k021 ='#' and f089 ='1' 
                     )          
               group by f091, r030, f092
   ) loop
         nnnn_ := nnnn_+1;
         kv_ := u.r030;
         p_ins (nnnn_, 'F091', u.f091);
         p_ins (nnnn_, 'R030', LPAD (u.r030, 3,'0'));
         p_ins (nnnn_, 'T071', TO_CHAR (u.t071 ));
	 p_ins (nnnn_, 'K020', '0');
	 p_ins (nnnn_, 'K021', '#');
         p_ins (nnnn_, 'Q024', '2');
         p_ins (nnnn_, 'D100', '00');
         p_ins (nnnn_, 'S180', '#');
         p_ins (nnnn_, 'F089', f089_);
         p_ins (nnnn_, 'F092', '216');
   end loop;
   f089_ :='2';

   delete from rnbu_trace
    where substr(kodp,5,3) in ( select ekp_2 from (select *
                         from ( select substr(kodp,5,3) ekp_2,
                                       substr(kodp,1,4) ekp_1, znap 
                                  from rnbu_trace )
                              pivot
                              ( max(trim(znap))
                                  for ekp_1 in ( 'F091' as F091, 'R030' as R030, 'T071' as T071,
                                                 'K020' as K020, 'K021' as K021, 'Q001' as Q001,
                                                 'Q024' as Q024, 'D100' as D100, 'S180' as S180,
                                                 'F089' as F089, 'F092' as F092, 
                                                 'Q003' as Q003, 'Q007' as Q007, 'Q006' as Q006 )
                              )   
                        where  f091 ='4' and f092 ='216' and k021 in ('2','6') and f089 ='2' and
                               gl.p_icurval (r030, t071, dat_)< kons_sum_
                             or
                               f091 ='4' and f092 ='216' and k020 ='k' and k021 ='#' and f089 ='1' 
                     ));  

--   �������� �� ������ FOREX
    IF is_swap_tag_ >= 1
    THEN
         v_sql_ :=
            ' select ''3'' f091, kva r030, suma t071, ''0000000006'' k020, ''3'' k021, '
          ||'        (select nb from rcukru where glb=6) q001, '
          ||'        decode(kodb,''300001'',''3'',''2'') q024, '
          ||'        (case  when nvl(swap_tag,0) != 0  then  ''05'' '
          ||'               when dat_a =dat     then  ''01'' '
          ||'               when dat_a -dat =1  then  ''02'' '
          ||'               when dat_a -dat =2  then  ''03'' '
          ||'               when dat_a -dat >2  then  ''04'' '
          ||'          end) d100, dat_a-dat k_days, ref '
          ||'   from fx_deal f'
          ||'  where dat =:1 '
          ||'    and kva != 980   and kvb =980 '
          ||'    and exists (select 1 from oper o where o.ref=f.ref and sos=5) '
          ||' union all '
          ||' select ''4'' f091, kvb r030, sumb t071, ''0000000006'' k020, ''3'' k021, '
          ||'        (select nb from rcukru where glb=6) q001, '
          ||'        decode(kodb,''300001'',''3'',''2'') q024, '
          ||'        (case  when nvl(swap_tag,0) != 0  then  ''05'' '
          ||'               when dat_b =dat     then  ''01'' '
          ||'               when dat_b -dat =1  then  ''02'' '
          ||'               when dat_b -dat =2  then  ''03'' '
          ||'               when dat_b -dat >2  then  ''04'' '
          ||'          end) d100, dat_b-dat k_days, ref '
          ||'   from fx_deal f'
          ||'  where dat =:2 '
          ||'    and kva = 980     and kvb !=980 '
          ||'    and exists (select 1 from oper o where o.ref=f.ref and sos=5) ';
    ELSE
         v_sql_ :=
            ' select ''3'' f091, kva r030, suma t071, ''0000000006'' k020, ''3'' k021, '
          ||'        (select nb from rcukru where glb=6) q001, '
          ||'        decode(kodb,''300001'',''3'',''2'') q024, '
          ||'        (case  when dat_a =dat     then  ''01'' '
          ||'               when dat_a -dat =1  then  ''02'' '
          ||'               when dat_a -dat =2  then  ''03'' '
          ||'               when dat_a -dat >2  then  ''04'' '
          ||'          end) d100, dat_a-dat k_days, ref '
          ||'   from fx_deal f'
          ||'  where dat =:1 '
          ||'    and kva != 980     and kvb =980 '
          ||'    and exists (select 1 from oper o where o.ref=f.ref and sos=5) '
          ||' union all '
          ||' select ''4'' f091, kvb r030, sumb t071, ''0000000006'' k020, ''3'' k021, '
          ||'        (select nb from rcukru where glb=6) q001, '
          ||'        decode(kodb,''300001'',''3'',''2'') q024, '
          ||'        (case  when dat_b =dat     then  ''01'' '
          ||'               when dat_b -dat =1  then  ''02'' '
          ||'               when dat_b -dat =2  then  ''03'' '
          ||'               when dat_b -dat >2  then  ''04'' '
          ||'          end) d100, dat_b-dat k_days, ref '
          ||'   from fx_deal f'
          ||'  where dat =:2 '
          ||'    and kva = 980     and kvb !=980 '
          ||'    and exists (select 1 from oper o where o.ref=f.ref and sos=5) ' ;

    END IF ;
                                                    --3 �������, 4 �������
    OPEN rfc1_  FOR v_sql_  USING dat_, dat_;
    LOOP
       FETCH rfc1_
          INTO  f091_, r030_, t071_, k020_, k021_, q001_, q024_, d100_, k_days_, ref_;
       EXIT WHEN rfc1_%NOTFOUND;

         nnnn_ :=nnnn_+1;
         dig_ := f_ret_dig (r030_) * 100; -- ����� ������ ���� � �������� ������

         nls_ := null;
         rnk_ := null;
         kv_ := r030_;
         refd_ := null;

         p_ins (nnnn_, 'F091', f091_);
         p_ins (nnnn_, 'R030', LPAD (r030_, 3,'0'));
         p_ins (nnnn_, 'T071', TO_CHAR (t071_ ));
--         p_ins (nnnn_, 'T071', TO_CHAR (ROUND (t071_ / dig_, 0)));
	 p_ins (nnnn_, 'K020', k020_);
	 p_ins (nnnn_, 'K021', k021_);
         p_ins (nnnn_, 'Q001', q001_);
         p_ins (nnnn_, 'Q024', q024_);
         p_ins (nnnn_, 'D100', d100_);
         if d100_ in ('04','05')  then
            p_ins (nnnn_, 'S180', f_s180_day(k_days_));
         else
            p_ins (nnnn_, 'S180', '#');
         end if;
         p_ins (nnnn_, 'F089', f089_);

                   BEGIN
                      SELECT substr(value, 1,3)
                        INTO d1#3K_
                        FROM operw
                       WHERE REF = ref_ AND tag = 'F092';
                   EXCEPTION
                      WHEN NO_DATA_FOUND
                         THEN  d1#3K_ := '000';
                   END;
         p_ins (nnnn_, 'F092', d1#3k_);
    END LOOP;
    CLOSE rfc1_;

--    ���������� �������� FXE
    for u in ( SELECT  '3' ko, o.rnkk rnk, o.REF, o.acck, o.nlsk,
                       o.kv, o.accd, o.nlsd, o.nazn,
                       SUM (o.s * 100) s_nom,
                       SUM (gl.p_icurval (o.kv, o.s * 100, dat_)) s_eqv
                  FROM provodki_otc o
                 WHERE o.fdat = dat_
                   AND o.kv not in (959, 961, 962, 964, 980)
                   AND o.tt ='FXE'
                   and o.nlsd ='29003'
                   and o.nlsk like '3800%'
                   and o.kv =o.kv_o and o.kv2_o =980
              GROUP BY '3', o.rnkk, o.REF, o.acck, o.nlsk, o.kv, o.accd, o.nlsd, o.nazn
              union
               SELECT  '4' ko, o.rnkd rnk, o.REF, o.acck, o.nlsk,
                       o.kv, o.accd, o.nlsd, o.nazn,
                       SUM (o.s * 100) s_nom,
                       SUM (gl.p_icurval (o.kv, o.s * 100, dat_)) s_eqv
                  FROM provodki_otc o
                 WHERE o.fdat = dat_
                   AND o.kv not in (959, 961, 962, 964, 980)
                   AND o.tt ='FXE'
                   and o.nlsk ='29003'
                   and o.nlsd like '3800%'
                   and o.kv =o.kv2_o and o.kv_o =980
              GROUP BY '4', o.rnkd, o.REF, o.acck, o.nlsk, o.kv, o.accd, o.nlsd, o.nazn
    ) loop

         nnnn_ :=nnnn_+1;

         kv_ := u.kv;
         r030_ := u.kv;
         dig_ := f_ret_dig (r030_) * 100; -- ����� ������ ���� � �������� ������

         f091_ := u.ko;
         if f091_ ='3'  then
              nls_ := u.nlsk;
              rnk_ := u.rnk;
         else
              nls_ := u.nlsd;
              rnk_ := u.rnk;
         end if;
         refd_ := u.ref;

         p_ins (nnnn_, 'F091', f091_);
         p_ins (nnnn_, 'R030', LPAD (r030_, 3,'0'));
         p_ins (nnnn_, 'T071', TO_CHAR (u.s_nom));
--         p_ins (nnnn_, 'T071', TO_CHAR (ROUND (u.s_nom / dig_, 0)));
	 p_ins (nnnn_, 'K020', '0000000006');
	 p_ins (nnnn_, 'K021', '3');
         p_ins (nnnn_, 'Q001', '�� ��������');
         p_ins (nnnn_, 'Q024', '1');
         p_ins (nnnn_, 'D100', '01');
         p_ins (nnnn_, 'S180', '#');
         p_ins (nnnn_, 'F089', f089_);
         if f091_ ='3'  then
            p_ins (nnnn_, 'F092', '164');
         else
            p_ins (nnnn_, 'F092', '215');
         end if;
    end loop;

---------------------------------------------------
   DELETE FROM tmp_nbu
         WHERE kodf = kodf_ AND datf = dat_;

   INSERT INTO tmp_nbu
            (kodf, datf, kodp, znap, nbuc)
      SELECT kodf_, dat_, kodp, znap, nbuc
        FROM rnbu_trace
       WHERE userid = userid_;
----------------------------------------

DELETE FROM OTCN_TRACE_70
         WHERE kodf = kodf_ and datf= dat_ ;

insert into OTCN_TRACE_70(KODF, DATF, USERID, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO)
select kodf_, dat_, USERID_, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO
from rnbu_trace;

--             otc_del_arch('3K', dat_, 1);
--             OTC_SAVE_ARCH('3K', dat_, 1);
--             commit;

    logger.info ('P_F3KX  end  for date = '||to_char(dat_, 'dd.mm.yyyy'));

END;
/               