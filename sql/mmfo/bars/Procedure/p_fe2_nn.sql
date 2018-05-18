CREATE OR REPLACE PROCEDURE BARS.p_fe2_nn ( dat_     DATE,
                                       sheme_   VARCHAR2 DEFAULT 'G') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : ��������� ������������ #E2 ��� ��
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     : v.17.009  14.05.2018 (24.04.2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
���������: Dat_ - �������� ����
           sheme_ - ����� ������������

   ��������� ����������    DDNNN

   DD         {10,20,31,32,62,40,41,64,65,66,61}
   NNN        �������� ���������� �����

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
14.05.2018 ��� �������� �� 2909 �� 3739 � OB22='35' ����� ������������� 
           ��������� �������� ��� ��������� ����������� 
           DD=31 "0', DD=32 - " ", DD=61 - ������� ��� ������������� 
           DD=62 - "1"
20.03.2018 ��� �������� �� 3720 �� 3739 �� ���.��������� "PASPN"
           �� ���� ����� � �� ������ �������� ���������� �����������
           � ��� ��� ���
12.02.2018 ��� ������������ ���������� D3#E2_ (���� ���������) �������
           ��� ���� ������� ��� ������� ���� 'DD,MM,YYYY'
           (���.�������� D3#70 ��� �������� � ����� ���� �
            � ��������� ������).
29.01.2018 ��� ������������ ���������� D3#E2_ (���� ���������) �������
           ��� ���� ������� ��� ������� ���� 'DD-MM-YYYY'
           (���.�������� D3#70 ��� �������� � ����� ���� � 
            � ��������� ������).
           �������� ������������ ���������� 61NNN 
22.01.2018 �������� ������������ ���������� 54NNN
12.01.2018 �������� ������������ ���������� 53NNN
03.01.2018 ��������� ������������ ���������� 32NNN � 
           �������� ������������ ���������� 54NNN
02.01.2018 �� 01.01.2018 ����������� ���������� 51, 52, 53, 54, 55
07.11.2017 ������ ����� ��� �������� ���
06.06.2017 ����� ���������� ��� ����� ���-��� >= 0.01 (0.01 USD)
30.05.2017 �� 02.06.2017 ����� ���������� ��� ����� ���-��� > 100 (1 USD)
01.03.2017 ��� ����� 344443 (����.�����) ��������� ��������� �� 3500 �� 1500
13.02.2017 ��� �������� �� 1600 �� 1500 � ��� ������ ����������� ��� 
           1600 �� ����� 804 ���������� 031 ����� ����������� � �������
           ��������� 
02.02.2017 �� ����� �������� �������� �� 1600 �� 1500 � ��� ������ 
           ����������� ��� 1600 ����� 804 
13.01.2017 ��� ����� 300465 � �������� �� 3739,2924 �� 1500
           ����������� ������� ����� �� � ����������� ������ ��������� �
           ���� ���� -DD=40 ����� 37:���������� �� ����i���� ��������
                     -DD=61 ����������� ��������� ������� �������� �� �����������
08.11.2016 ��� ����� 300465 ��������� ��������� �� 3739 �� 1502
15.03.2016 � 21.03.2016 (�� 22.03.2016) ����������� ���������� 41NNN
23.02.2016 �������� ������������ ����� ����������� � ������� 
           OTCN_TRACE_70
02.11.2015 ��� ����� 300465 � �������� �� 1600 �� 1500 ���������� 61 ����� 
           ����������� ��� "������� ����� � ������� ���� �����-�����������"
12.10.2015 ��� 300465 ���������� 61 (������� ��� ��������) ����� 
           ����������� � ����������� �� ���� ���� ������� 
           (�������� ������ 52-18/773 �� 12.06.2015)
21.09.2015 ��� �� �� �������� ����� ���������� ������ ��� ������� � 
           ARC_RRP
11.08.2015 ��� ���� �� �� ��� ������������ ����� ���������� ��������
           �� 2520,2530,2541,2542,2544,2545
           �� 1500, 1600, 3720, 3739, 3900, 2909  
22.06.2015 ��� 300465 ���������� 61 (������� ��� ��������) ����� 
           ����������� � ����������� �� ���� ���� ������� 
           (�������� ������ 52-18/773 �� 12.06.2015)
06.02.2015 ��� ���� �� �� ����� ���������� �������� �� 2600,2620 �� 1919
           ����� ��� � ��� �� 2909 �� 1919 ������ ��� �����
04.02.2015 ��� 300465 ����� ���������� �������� �� 1600 �� 1500
22.01.2015 ��� ���� �� �� ����� ���������� �������� �� 2600,2620 �� 1919
           �� 2909 �� 1919
15.01.2015 ��� ���������� 40��� � �� 1600 �� 1500 ��������� �������� = '31' 
26.11.2014 ������������� ����� ������������ ���.�������� 57A
           ��� ����������� ���� ����� (B010) 
25.11.2014 ��� ����������� ���� ������ ������������� ������������ ���.
           �������� "n"
24.06.2014 ������ ���.��������� 57A ����� ������������ ���.�������� 58A
           - SWIFT_CODE (����� �������� ������� ���.����������)
03.06.2014 ��� ���.��������� tag like '59%' �������� ������ 3 �������
           �� ���� VALUE
09.04.2014 ���������� ����� ���-��� >=1001$ � ���������� 1000.01$ � ������ 
03.04.2014 ����� ���������� ����� ���������� ������ ������ 1000$ 
27.02.2014 ��� ����� �� �� ����� �������� �������� ���� 
           �� '37396506' �� '1500%' � ���������� "���������� �� ������"
19.02.2014 ��� ������ ���������� �� ������� ���� ���������� ����� � �����
           ��������
13.02.2014 ����� ���������� ���-�� � ������ �� ����� 1000.00$
08.01.2014 ��� ����� �� ����� �������� �������� ���� 
           �� '37396506' �� '1500%' � ���������� "���������� �� ������"
26.07.2013 ��� ������ ����������� ������ ��� ����� ���������� 
           �� TAG='50F' � � �������� ��������� ������� 'UA'
           (�� ����� �������� �������� �������� �� �������)
22.07.2013 ��� ����� �� ����� �������� �������� ����
           �� ����� �� '292430003718%', '292460003717%' �� �� '1500%' 
03.01.2013 ��� ����� �� ����� �������� �������� ����
           �� ����� �� '292490204%', '292460205%' �� �� '1500%' 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   kodf_      VARCHAR2 (2)   := 'E2';
   sql_z      VARCHAR2 (200);
   typ_       NUMBER;
   gr_sum_    NUMBER         := 5000000;   --��� ��������
   sum_kom    NUMBER;                      -- ���� ���i�i�
   flag_      NUMBER;
   ko_        VARCHAR2 (2);      -- ������ ������ii � ������i������ i��������
   ko_1       VARCHAR2 (2);      -- ������ ������ii � ������i������ i��������
   kod_b_     VARCHAR2 (10);                          -- ��� �����
   nam_b      VARCHAR2 (70);                        -- ����� �����
   n_         NUMBER         := 10;
   -- ���-�� ���.���������� �� 03.07.2006 ����� n_=11
   acc_       NUMBER;
   accd_      NUMBER;
   acck_      NUMBER;
   kv_        NUMBER;
   kv1_       NUMBER;
   nls_       VARCHAR2 (15);
   nlsk_      VARCHAR2 (15);
   nlsk1_     VARCHAR2 (15);
   nbuc1_     VARCHAR2 (12);
   nbuc_      VARCHAR2 (12);
   kod_g_     VARCHAR2 (3);
   country_   VARCHAR2 (3);
   b010_      VARCHAR2 (10);
   swift_k_   VARCHAR2 (12);
   bic_code   VARCHAR2 (14);
   rnk_       NUMBER;
   rnk1_       NUMBER;
   okpo_      VARCHAR2 (14);
   okpo1_     VARCHAR2 (14);
   nmk_       VARCHAR2 (70);
   adr_       VARCHAR2 (70);
   k040_      VARCHAR2 (3);
   k110_      VARCHAR2 (5);
   val_       VARCHAR2 (200);
   a1_        VARCHAR2 (70);
   a2_        VARCHAR2 (70);
   a3_        VARCHAR2 (70);
   a4_        VARCHAR2 (70);
   a5_        VARCHAR2 (70);
   a6_        VARCHAR2 (70);
   a7_        VARCHAR2 (70);
   nb_        VARCHAR2 (70);
   tg_        VARCHAR2 (70);
   data_      DATE;
   dig_       NUMBER;
   bsum_      NUMBER;
   bsu_       NUMBER;
   sum1_      DECIMAL (24);
   sum0_      DECIMAL (24);
   sumk1_     DECIMAL (24);                 --���i�i� � �i���� �� �����������
   sumk0_     DECIMAL (24);                            --���i�i� �� ���������
   kodp_      VARCHAR2 (10);
   znap_      VARCHAR2 (70);
   kurs_      NUMBER;
   tag_       VARCHAR2 (5);
   nnnn_      NUMBER         := 0;
   userid_    NUMBER;
   ref_       NUMBER;
   rez_       NUMBER;
   codc_      NUMBER;
   mfo_       number;
   mfou_      number;
   tt_        varchar2(3);

   kod_n_     varchar2(4);
   refd_      number;
   ttd_       varchar2(3);
   nlsdd_     varchar2(20);
   formOk_    boolean;
   s180_      varchar2(1);
   accdd_     number;

   d1#E2_     VARCHAR2 (70);
   d2#E2_     VARCHAR2 (70);
   d3#E2_     VARCHAR2 (70);
   d4#E2_     VARCHAR2 (70);
   d6#E2_     VARCHAR2 (70);
   d7#E2_     VARCHAR2 (70);
   d8#E2_     VARCHAR2 (70);
   db#E2_     VARCHAR2 (70);
   dc#E2_     VARCHAR2 (70);
   dc#E2_max  VARCHAR2 (70);
   d61#E2_    VARCHAR2 (170);
   kol_61     number;
   DC1#E2_    VARCHAR2 (70);
   DE#E2_     VARCHAR2 (3);
   D53#E2_    VARCHAR2 (2000) := null;
   D54#E2_    VARCHAR2 (2) := null;
   D55#E2_    VARCHAR2 (1) := null;
   nazn_      VARCHAR2 (160);
   mbkOK_     boolean;
   ourOKPO_   varchar2 (14);
   ourGLB_    varchar2 (3);
   pid_       Number;
   id_        Number;
   id_min_    Number :=0;
   kol_ref_   Number;
   kod_obl_   Varchar2 (2);
   ser_       person.ser%TYPE;
   numdoc_    person.numdoc%TYPE;
   dat_Izm1_  DATE := TO_DATE('18032016','ddmmyyyy'); -- ����������� �������� 
                                                      -- 41000
   dat_Izm2_  DATE := TO_DATE('01062017','ddmmyyyy'); -- ���� ���� ��� ������ 
   dat_Izm3_  DATE := TO_DATE('29122017','ddmmyyyy'); -- ��� ��������� 

   name_sp_        varchar2(30);
   exist_trans     NUMBER                 := 0;

   cont_num_     varchar2(100);
   cont_dat_     varchar2(100);
   ob22_         varchar2(2);

--������ �� ������������
   CURSOR c_main
   IS
      SELECT   t.ko, decode(substr(b.b040,9,1),'2',substr(b.b040,15,2),substr(b.b040,10,2)), 
               c.rnk, trim(c.okpo), c.nmk, TO_CHAR (c.country), c.adr,
               NVL (c.ved, '00000'), c.codcagent, NVL(SUM (t.s_eqv),0),
               NVL(SUM (gl.p_icurval (t.kv, t.s_kom, dat_)),0)
          FROM OTCN_PROV_TEMP t, customer c, tobo b  
         WHERE t.rnk = c.rnk
           and c.tobo = b.tobo  
      GROUP BY t.ko,
               decode(substr(b.b040,9,1),'2',substr(b.b040,15,2),substr(b.b040,10,2)), 
               c.rnk,
               c.okpo,
               c.nmk,
               TO_CHAR (c.country),
               c.adr,
               NVL (c.ved, '00000'),
               c.codcagent
      ORDER BY 2;

--- ������� ������i�����i ������
   CURSOR opl_dok
   IS
      SELECT   t.ko, t.REF, t.tt, t.accd, t.nlsd, t.kv, t.acck, t.nlsk,
               t.nazn, t.s_nom, t.s_eqv
          FROM OTCN_PROV_TEMP t
         WHERE t.rnk = rnk_;

-------------------------------------------------------------------
   PROCEDURE p_exist_trans
   IS
   BEGIN
      SELECT COUNT (*)
        INTO exist_trans
        FROM all_tables
       WHERE owner = 'BARS' AND table_name LIKE 'OTCN_TRANSIT_NLS';
   END;

   PROCEDURE p_ins (p_np_ IN NUMBER, p_kodp_ IN VARCHAR2, p_znap_ IN VARCHAR2)
   IS
      l_kodp_   VARCHAR2 (1000);
      p_znap1_  VARCHAR2 (250);
   BEGIN

      if p_kodp_ in ('31','64') and length(trim(p_znap_)) < 3 and trim(p_znap_) != '0' then
         p_znap1_ := LPAD (p_znap_, 3, '0');
      else
         p_znap1_ := p_znap_;
      end if;

      if mfo_ = 300465 and p_kodp_='31' then
         if (nlsk_ like '1500%' and ( nls_ in ('29091000580557',
                                               '29092000040557',
                                               '29095000081557',
                                               '29095000046547',
                                               '29091927',
                                               '2909003101',
                                               '292460205',
                                               '292490204') OR
                                      substr(nls_,1,4) = '1502')
                                             ) OR p_znap1_='6' then
            p_znap1_ := '006';
         end if;
      end if;

      l_kodp_ := p_kodp_ || LPAD (TO_CHAR (p_np_), 3, '0');

    if substr(l_kodp_, 1, 2) = '64' then
          INSERT INTO rnbu_trace
                      (nls, kv, odate, kodp, znap, nbuc, ref, rnk, comm
                      )
               VALUES (nls_, kv_, dat_, l_kodp_, p_znap1_, nbuc_, ref_, rnk_, D6#E2_
                      );
    elsif substr(l_kodp_, 1, 2) = '65' then
          INSERT INTO rnbu_trace
                      (nls, kv, odate, kodp, znap, nbuc, ref, rnk, comm
                      )
               VALUES (nls_, kv_, dat_, l_kodp_, p_znap1_, nbuc_, ref_, rnk_, nvl(D7#E2_, kod_b_||' '||to_char(kv_))
                      );
    elsif substr(l_kodp_, 1, 2) = '66' then
          INSERT INTO rnbu_trace
                      (nls, kv, odate, kodp, znap, nbuc, ref, rnk, comm
                      )
               VALUES (nls_, kv_, dat_, l_kodp_, p_znap1_, nbuc_, ref_, rnk_, D8#E2_
                      );
    else
         INSERT INTO rnbu_trace
                  (nls, kv, odate, kodp, znap, nbuc, ref, rnk, comm, nd
	                  )
           VALUES (nls_, kv_, dat_, l_kodp_, p_znap1_, nbuc_, ref_, rnk_, to_char(refd_), id_min_
                  );
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

      BEGIN
         select substr(trim(value),1,4)
            into kod_n_
         from operw
         where ref=p_ref_
           and tag='KOD_N';
      EXCEPTION WHEN NO_DATA_FOUND THEN
         kod_n_ := null;
      END;

      IF p_i_ = 1
      THEN
         p_kodp_ := '40';

         if mfo_ = 300465 then
            if nlsk_ like '1500%' and nls_ in ('29091000580557',
                                               '29092000040557',
                                               '29095000081557',
                                               '29095000046547',
                                               '29091927',
                                               '2909003101',
                                               '292460205',
                                               '292490204') then
               d1#E2_ := '37';    -- � 26.07.2012 �������� ������ ������� �� 11.07.2012
            end if;
            if nlsk_ like '1500%' and
                nls_ in ('37394501547') --and  --,'37396506') 
            then
               d1#E2_ := '31';  -- � 26.07.2012 �������� ������ ������� �� 11.07.2012
            end if;

--  �������� ������� ����� �� � ����������� ������ ���������  13.01.2017
            if nlsk_ like '1500%' and
               ( nls_ like '3739%' or nls_ like '2924%' ) 
            then
                if exist_trans >0 then
                  begin
                     select t_system  into name_sp_
                       from otcn_transit_nls
                      where nls = trim(nls_);
                  exception
                    when others
                       then name_sp_ :='';
                  end;
                  if trim(name_sp_) is not null  then
                        d1#E2_ := '37';
                  end if;
                end if;
            end if;

            if nls_ like '1600%' and nlsk_ like '1500%' 
            then
               d1#E2_ := '31';  -- � 16.01.2015 �������� ������ ������� �� 15.01.2015
            end if;

         end if;

         if TRIM (p_value_) is null and d1#E2_ is null and nazn_ is not null then
            if instr(lower(nazn_),'����') > 0 then
               d1#E2_ := '38';  -- � 26.07.2012 �������� ������ ������� �� 11.07.2012
            end if;
            
            if instr(lower(nazn_),'������') > 0 then
               d1#E2_ := '38';  -- � 26.07.2012 �������� ������ ������� �� 11.07.2012
            end if;
            
            if instr(lower(nazn_),'���_������ �������') > 0 then
               d1#E2_ := '38';  -- � 26.07.2012 �������� ������ ������� �� 11.07.2012
            end if;

            if d1#E2_ is null and instr(lower(nazn_),'�������') > 0 and trim(nls_) like '2620%' then
               d1#E2_ := '38';  -- � 26.07.2012 �������� ������ ������� �� 11.07.2012
            end if;

         end if;

         if TRIM (p_value_) is null and d1#E2_ is not null then
            p_value_ := NVL (SUBSTR (TRIM (d1#E2_), 1, 2), '00');
         else
            p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 2), '00');
            if p_value_ = '00' then
               if kod_n_='8445' then
                  p_value_ := '30';
               end if;
            end if;

            d1#E2_ := p_value_;
         end if;
      ELSIF p_i_ = 2
      THEN
         p_kodp_ := '51';

         if cont_num_ is not null then
            p_value_ := NVL (SUBSTR (TRIM (cont_num_), 1, 70), 'N �����.');
         else
            p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 70), 'N �����.');
         end if;
         -- ��� ������� ������ � ������������� ��������
         if mbkOK_ or d1#E2_='30' then
            p_value_ := '';
         end if;
      ELSIF p_i_ = 3
      THEN
         p_kodp_ := '52';

         if cont_dat_ is not null then
            p_value_ := NVL (SUBSTR (TRIM (cont_dat_), 1, 70), '���� �����.');
         else
            p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 70), '���� �����.');
         end if;

         -- ��� ������� ������ � ������������� ��������
         if mbkOK_ or d1#E2_='30' then
            p_value_ := '';
         end if;
      ELSIF p_i_ = 4
      THEN
         p_kodp_ := '60';

         if TRIM (p_value_) is null and d4#E2_ is not null then
            p_value_ := NVL (SUBSTR (TRIM (d4#E2_), 1, 70), '');
         else
            p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 70), '');
         end if;
         -- ��� ������� ������ � ������������� ��������
         if mbkOK_ or d1#E2_='30' then
            p_value_ := '';
         end if;
      ELSIF p_i_ = 6
      THEN
         p_kodp_ := '64';

         IF p_value_ IS NOT NULL
         THEN
            p_value_ := LPAD (p_value_, 3, '0');
         else
            p_value_ := trim(D6#E2_);
         END IF;

         if trim(kod_g_) is not null then
            p_value_ := trim(kod_g_);
         end if;

         IF p_value_ is null THEN
            p_value_ := f_get_swift_country(REF_);
         end if;
         
         country_ := NVL (LPAD (SUBSTR (TRIM (p_value_), 1, 3), 3, '0'), '000');
         p_value_ :=
            NVL (
               LPAD (SUBSTR (TRIM (p_value_), 1, 70), 3, '0'), 
               '��� ���i�� � ��� ���������� ������');
      ELSIF p_i_ = 9
      THEN
         b010_ := null;
         p_kodp_ := '65';

         if TRIM (p_value_) is null and d7#E2_ is not null then
            p_value_ := NVL (SUBSTR (TRIM (d7#E2_), 1, 10), '��� �����');
         end if;

         if TRIM (p_value_) is null and d7#E2_ is null then
            p_value_ := f_get_swift_bank_code(ref_);

            p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 10), '��� �����');
         end if;

         IF trim(p_value_) != '��� �����'
         THEN
            b010_:= SUBSTR (TRIM (p_value_), 1, 10);
         ELSE
            p_value_ := country_||'0000000';
         END IF;
      ELSIF p_i_ = 10
      THEN
         nb_ :=null;
         p_kodp_ := '66';

         if TRIM (p_value_) is null then
            if b010_ is not null then
               if length(b010_)=3 then
                  BEGIN
                     SELECT NVL (knb, '����� �����')
                        INTO nb_
                     FROM rcukru
                     WHERE glb = b010_
                       and rownum=1;
                  EXCEPTION
                            WHEN NO_DATA_FOUND
                        THEN
                     nb_ := '����� �����';
                  END;
               else
                  BEGIN
                     SELECT NVL (NAME, '����� �����')
                        INTO nb_
                     FROM rc_bnk
                     WHERE b010 = b010_
                       and rownum=1;
                  EXCEPTION
                            WHEN NO_DATA_FOUND
                       THEN
                     nb_ := '����� �����';
                  END;
               end if;
            else
               nb_ := '����� �����';
            end if;

         end if;

         if p_value_ IS NULL AND trim(d8#E2_) is not null then  
            p_value_ := NVL (SUBSTR (TRIM (d8#E2_), 1, 70), '����� �����');
            nb_ := p_value_;
         end if;

         IF p_value_ IS NULL AND nb_ != '����� �����'
         THEN
            p_value_ :=
                   NVL (SUBSTR (TRIM (nb_), 1, 70), '����� �����');
         ELSE
            p_value_ :=
               NVL (SUBSTR (TRIM (p_value_), 1, 70),
                    '����� �����');
         END IF;
      ELSIF p_i_ = 11
      THEN
         p_kodp_ := '70';

         p_value_ :=
                  NVL (SUBSTR (TRIM (p_value_), 1, 70), '99');

         -- ��� ������� ������ � ������������� ��������
         if mbkOK_ or d1#E2_='30' or d1#E2_ != '21' then
            p_value_ := '00';
         end if;

         if p_value_='99' and kod_n_ not like '1%' then
            p_value_ := '00';
         end if;

         if db#E2_ is not null then
            p_value_ := NVL (SUBSTR (TRIM (db#E2_), 1, 70), '');
         end if;
      ELSIF p_i_ = 12
      THEN
         p_kodp_ := '59';

         if TRIM (p_value_) is null and dc#E2_ is not null then
            p_value_ := NVL (SUBSTR (TRIM (dc#E2_), 1, 70), '');
         else
            p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 70), '');
         end if;
         -- ��� ������� ������ � ������������� ��������
         if mbkOK_ or d1#E2_='30' then
            p_value_ := '';
         end if;
      ELSIF p_i_ = 13
      THEN
         p_kodp_ := '61';

         --��� �������� ������ ����� ��������
         if TRIM (p_value_) is null and d61#E2_ is not null then
            if length(trim(d61#E2_)) > 70 then
               n_ := 70;
            else
               n_ := length(trim(d61#E2_))-1;
            end if;
            p_value_ := NVL (SUBSTR (TRIM (d61#E2_), 1, n_), '');
         else
            p_value_ :=NVL (SUBSTR (TRIM (p_value_), 1, 70), '');
         end if;
         IF trim(p_value_) is NULL and mfou_ in (300465) THEN
            p_value_ := substr(nazn_,1,70);
         END IF;

         IF mfo_ = 300465 and d1#E2_ = '37'
         THEN
            if name_sp_ <> ''
            then 
               p_value_ := substr(name_sp_, 1, 70);
            end if;
         END IF;

         IF mfou_ = 300465 and mfou_ != mfo_ 
         THEN 
            case
               when d1#E2_ = '20' then p_value_ := '������ � ������';
               when d1#E2_ = '21' then p_value_ := '������ ������, ����, ������';
               when d1#E2_ = '23' then p_value_ := '��������� �볺���� ������� �� ����������� (�� �����)';
               when d1#E2_ = '24' then p_value_ := '��������� ������ ������� �� �����-�����������';
               when d1#E2_ = '25' then p_value_ := '������ ������(���������, ����, ������) ��� ��������';
               when d1#E2_ = '26' then p_value_ := '������� ������� �����������';
               when d1#E2_ = '27' then p_value_ := '��������� �������� � �����������';
               when d1#E2_ = '28' then p_value_ := '�����������';
               when d1#E2_ = '29' then p_value_ := '����������';
               when d1#E2_ = '30' then p_value_ := '���������� ��������';
               when d1#E2_ = '31' then p_value_ := '������������� � ����� �����';
               when d1#E2_ = '32' then p_value_ := '������ �� ����������';
               when d1#E2_ = '33' then p_value_ := '������������ ���������, ����������';
               when d1#E2_ = '34' then p_value_ := '��������� �볺���� �������, ���������� �� �����';
               when d1#E2_ = '35' then p_value_ := '��������� ������ ������� �� ����������� (�� �����)';
               when d1#E2_ = '36' then p_value_ := '���������� �� ����������� (�� ��������� ����������)';
               when d1#E2_ = '37' then p_value_ := '���������� �� �������� �������� '||name_sp_;
               when d1#E2_ = '38' then p_value_ := '������� ��������';
               when d1#E2_ = '39' then p_value_ := '�����';
               when d1#E2_ = '40' then p_value_ := '��������� ��������������';
               when d1#E2_ = '41' then p_value_ := '�������';
               when d1#E2_ = '42' then p_value_ := '�������� ������������';
               when d1#E2_ = '43' then p_value_ := '������ �� �������� ��������';
               when d1#E2_ = '44' then p_value_ := '�� ���������� � ����� ���������� ������';
               when d1#E2_ = '45' then p_value_ := '������ ������(���������, ����, ������) �� ������ �������.������';
               when d1#E2_ = '46' then p_value_ := '���������� ��������';

            else 
               null;
            end case;
         END IF;

         if mfo_ = 300465 and nls_ like '1600%' and nlsk_ like '1500%' 
         then
            p_value_ := '������� ����� � ������� ���� �����-�����������';  -- � 16.01.2015 �������� ������ ������� �� 15.01.2015
         end if;

         if nlsk_ like '3739%' and nls_ like '2909%' and ob22_ = '35'
         then 
            p_value_ := '������� ��� �������������';  -- � 14.05.2018 �������� ��������� 07.05.2018
         end if;
      ELSIF p_i_ = 14
      THEN
         IF Dat_ <= dat_Izm1_ 
         THEN
            p_kodp_ := '41';
            -- � 01.06.2009 ����� ��������
            --  (��� �������� ������ �i����i��� �� ����i����� ���������)
            if TRIM (p_value_) is null and de#E2_ is not null then
               p_value_ := NVL (SUBSTR (TRIM (de#E2_), 1, 3), '��� ��������');
            else
               p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 3), '��� ��������');
            end if;

            IF trim(d1#E2_) not in ('23','24','34','35') THEN
               p_value_:='999';
            end if;

            IF trim(d1#E2_) in ('23','24','34','35') and p_value_='999' THEN
               p_value_:='000';
            end if;
         END IF;
      -- ����� ���� � 01.01.2018
      ELSIF p_i_ = 15
      THEN
         IF Dat_ >= dat_Izm3_ 
         THEN
            p_kodp_ := '53';
            -- � 29.12.2017 ����� ��������
            --  ����� �����������
            
            if D2#E2_ is not null and D3#E2_ is not null 
            then

              begin
                select substr(MAX(trim(benef_name)), 1,135)
                  into d53#E2_
                  from V_CIM_ALL_CONTRACTS
                 where upper(num) = upper(cont_num_)
                   and open_date = to_date(cont_dat_, 'ddmmyyyy')
                   and status_id in (0, 8)
                   and lpad(okpo, 10, '0') = lpad(okpo_, 10, '0')
                   and contr_type = case 
                                    when d1#E2_ = '36' then 0 
                                    when d1#E2_ in ('23','24','34','35') then 2 
                                    else 1
                                    end;
              exception
                when OTHERS then
                  bars_audit.error( 'P_FE2_NN: cont_num_='||cont_num_||', cont_dat_='||cont_dat_||chr(10)||sqlerrm );
                  d53#E2_ := null;
              end;

              if ( d53#E2_ is null )
              then

                begin
                  select substr(MAX(trim(benef_name)), 1,135)
                    into d53#E2_
                    from V_CIM_ALL_CONTRACTS
                   where upper(num) = upper(cont_num_)
                     and open_date = to_date(cont_dat_, 'ddmmyyyy')
                     and status_id = 1
                     and lpad(okpo, 10, '0') = lpad(okpo_, 10, '0')
                     and contr_type = case
                                      when d1#E2_ = '36' then 0
                                      when d1#E2_ in ('23','24','34','35') then 2
                                      else 1
                                      end;
                exception
                  when OTHERS then
                    bars_audit.error( 'P_FE2_NN: cont_num_='||cont_num_||', cont_dat_='||cont_dat_||chr(10)||sqlerrm );
                    d53#E2_ := null;
                end;

                if d53#E2_ is null
                then

                  begin
                    select substr(MAX(trim(benef_name)), 1,135)
                      into d53#E2_
                      from v_cim_all_contracts
                     where upper(num) = upper(cont_num_) and
                           open_date = to_date(cont_dat_, 'ddmmyyyy')  and
                           status_id in (0, 1, 8) and
                           lpad(okpo, 10, '0') = lpad(okpo_, 10, '0');
                  exception
                    when OTHERS then
                      bars_audit.error( 'P_FE2_NN: cont_num_='||cont_num_||', cont_dat_='||cont_dat_||chr(10)||sqlerrm );
                      d53#E2_ := null;
                  end;

                end if;

              end if;

            end if;

            if d53#E2_ is null then
               d53#E2_ := f_get_swift_benef(ref_); 
            end if;
            
            if d53#E2_ is not null then
               p_value_ := NVL (SUBSTR (TRIM (d53#E2_), 1, 135), '����� �����������');
            else
               p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 135), '����� �����������');
            end if;
         END IF;
      ELSIF p_i_ = 16
      THEN
         IF Dat_ >= dat_Izm3_ 
         THEN
            p_kodp_ := '54';
            -- � 29.12.2017 ����� ��������
            --  ��� �������������� - F027 (���.�������� 12_2C)
            if TRIM (p_value_) is null and d54#E2_ is not null then
               p_value_ := NVL (lpad (SUBSTR (TRIM (d54#E2_), 1, 2), 2, '0'), '00');
            else
               p_value_ := NVL (lpad(SUBSTR(TRIM (p_value_), 1, 2), 2, '0'), '00');
            end if;
         END IF;
      ELSIF p_i_ = 17
      THEN
         IF Dat_ >= dat_Izm3_ 
         THEN
            p_kodp_ := '55';
            -- � 29.12.2017 ����� ��������
            --  ������ ����������� �������� (F089)
            if TRIM (p_value_) is null and d55#E2_ is not null then
               p_value_ := NVL (SUBSTR (TRIM (d55#E2_), 1, 3), '2');
            else
               p_value_ := '2';
            end if;
         END IF;

      ELSE
         p_kodp_ := 'NN';
      END IF;
   END;
-----------------------------------------------------------------------------
BEGIN
    logger.info ('P_FE2_NN: Begin for datf = '||to_char(dat_, 'dd/mm/yyyy'));

   EXECUTE IMMEDIATE 'ALTER SESSION SET NLS_NUMERIC_CHARACTERS=''.,''';
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
   ourOKPO_ := lpad(F_Get_Params('OKPO',null), 8, '0');

   begin
     select decode(glb, 0, '0', lpad(to_char(glb), 3, '0'))
        into ourGLB_
     from rcukru
     where mfo=mfo_
       and rownum=1;
   exception
     when no_data_found then
         ourGLB_ := null;
   END;

   p_exist_trans ();

   IF dat_ >= to_date('01062009','ddmmyyyy') THEN
      gr_sum_ := 100;   --1000000;
   ELSIF dat_ >= to_date('11022014','ddmmyyyy') THEN
      gr_sum_ := 100000;
   elsIF dat_ >= to_date('01062017','ddmmyyyy') THEN
      gr_sum_ := 0;
   END IF;

   -- � 01.06.2017 ��� �������� ������.i������� ����������� ������ii >=1.00$ 
   IF dat_ >= dat_Izm2_ THEN
      gr_sum_ := 1;
   END IF;
   
   sum_kom := gl.p_icurval(840, 100000, dat_);  -- ���� ���i�i�

   -- � 01.06.2017 ��� �������� ������.i������� ����������� ������ii >=1.00$ 
   IF dat_ >= dat_Izm2_ THEN
       sum_kom := gl.p_icurval(840, 100, dat_);  -- ���� ���i�i�
   END IF;
    
   kol_ref_ := 0;
   
   IF mfou_=300465 and mfo_ != mfou_ and Dat_ > to_date('28072009','ddmmyyyy')
   THEN
      select /*+ index(a, XIE_DAT_A_ARC_RRP) */ count(*)
         INTO kol_ref_
      from arc_rrp a
      where trunc(dat_a) >= Dat_
        and dk = 3
        and nlsb like '2909%'
        and nazn like '#E2;%'
        and trim(d_rec) is not null
        and d_rec like '%D' || to_char(Dat_, 'yymmdd') || '%'
        and kf = to_char(mfo_);
   END IF;

   if ( (mfou_ = 300465 and mfou_ = mfo_) OR mfou_ <> 300465 ) and kol_ref_ = 0 then
        -- ����� ��������, ��������������� �������
        -- ����������� �i� ����������i�
        INSERT INTO OTCN_PROV_TEMP
               (ko, rnk, REF, tt, accd, nlsd, kv, acck, nlsk, nazn,
                s_nom, s_eqv)
        SELECT *
        FROM (
              SELECT   '3' ko, ca.rnk, o.REF, tt, o.accd, o.nlsd, o.kv, o.acck,
                       o.nlsk, o.nazn,
                       o.s * 100 s_nom,
                       gl.p_icurval (o.kv, o.s * 100, dat_) s_eqv
                  FROM provodki o, cust_acc ca
                 WHERE o.fdat = dat_
                   AND o.kv not in (959,961,962,964,980)
        AND (
                       (SUBSTR (o.nlsd, 1, 4) in ('2600', '2620') and
                        SUBSTR (o.nlsk, 1, 4) in ('1919','2909','3739') and
                        (mfou_=300465 and mfou_ <> mfo_) ) -- BAP
                   OR  (SUBSTR (o.nlsd, 1, 4) in ('2909') and
                        SUBSTR (o.nlsk, 1, 4) in ('1919','3739') and
                        mfou_=333368 ) 
                   OR  (SUBSTR (o.nlsd, 1, 4) IN
                                                ('1502',
                                                 '1511',
                                                 '1512',
                                                 '1515',
                                                 '1516',
                                                 '1522',
                                                 '1523',
                                                 '1524',
                                                 '1525',
                                                 '1600',
                                                 '1602',
                                                 '1623',
                                                 '1624',
                                                 '1811',
                                                 '1819',
                                                 '1911',
                                                 '1919',
                                                 '2520',
                                                 '2530',
                                                 '2541',
                                                 '2542',
                                                 '2544',
                                                 '2545',
                                                 '2600',
                                                 '2602',
                                                 '2620',
                                                 '2625',
                                                 '2650',
                                                 '2901',
                                                 '2909',
                                                 '3510',
                                                 '3519',
                                                 '3660',  -- ������� 06.02.09
                                                 '3661',  -- 3660,3661,3668
                                                 '3668' )
        -- �������� 18.08.2008                             '3720',
        --                                                 '3739'  )
                          AND SUBSTR(o.nlsk,1,4) in ('1500','1600','3720','3739','3900','2909')
                          AND SUBSTR (LOWER (TRIM (o.nazn)), 1, 4) != '����')
                   OR (o.nlsd LIKE '1919%'     and
                       o.nlsk LIKE '1500%'     and
                       mfo_ = 300465           and
                       SUBSTR (LOWER (TRIM (o.nazn)), 1, 4) = '����')
                   OR (o.nlsd LIKE '191992%'     and
                       (o.nlsk LIKE '1500%' or o.nlsk like '1600%') and
                       mfo_ in (300465) )
                   OR (o.nlsd in ('37394501547') and  --,'37396506')
                       o.nlsk LIKE '1500%' and
                       mfo_ in (300465) )
                   OR (o.nlsd like ('3739%') and 
                       o.nlsk LIKE '1502%' and
                       mfo_ in (300465) )
                   OR (o.nlsd LIKE '15_8%'     and
                       (o.nlsk LIKE '1500%' or o.nlsk like '1600%') and
                       mfo_ in (300465) )
                   OR (o.nlsd LIKE '3500%'     and
                       o.nlsk LIKE '1500%' and
                       mfo_ in (344443) )
                   OR ((o.nlsd LIKE '292490204%' or o.nlsd LIKE '292460205%') and  -- 03/01/2013
                        o.nlsk LIKE '1500%'  and
                       mfo_ in (300465) )
                   OR ((o.nlsd LIKE '292430003718%' or o.nlsd LIKE '292460003717%') and  -- 22/07/2013
                        o.nlsk LIKE '1500%'  and
                       mfo_ in (300465) )    
                   OR ( o.nlsd like '3800%'   -- 29/07/2012
                        AND SUBSTR (o.nlsk, 1, 4) in ('1500','1600')
                        AND mfo_ in (300465)
                        AND ref in (select ref 
                                    from oper 
                                    where ( ((nlsa like '70%' or nlsa like '71%') and 
                                             (nlsb like '1500%' or nlsb like '1600%')) or
                                            ((nlsa like '1500%' or nlsa like '1600%') and 
                                            (nlsb like '70%' or nlsb like '71%')) )
                                   )
                        AND gl.p_icurval(o.kv, o.s*100, dat_) > sum_kom ) )
                   AND o.accd = ca.acc);

        -- ������� �������� ���������� ��������� (� OPER �� 1500 �� 1500)
        delete from otcn_prov_temp
        where ref in (select a.ref
                 from oper a
                 where a.ref in (select b.ref from otcn_prov_temp b)
                   and a.nlsa like '1500%' and a.nlsb like '1500%')
          AND SUBSTR (LOWER (TRIM (nazn)), 1, 4) != '����';

        -- ��� MFO=300465 ������� �������� � ������� MFOA<>MFOB �������� ��������
        IF mfo_ = 300465 THEN
            delete from otcn_prov_temp
            where ref in (select a.ref
                        from oper a
                        where a.ref in (select b.ref from otcn_prov_temp b)
                          and a.mfoa != a.mfob);
        END IF;

        -- ������� �������� �������� (�� 7100 �� 1500)
        delete from otcn_prov_temp
        where ref in (select a.ref
                      from oper a
                      where a.ref in (select b.ref from otcn_prov_temp b)
                        and a.nlsa like '1500%' and a.nlsb like '7100%' and a.dk=0)
                        and round(s_eqv / kurs_, 0) < 100000 ;
   else
     -- ����� ��������, ��������������� �������
     -- ����������� �i� ����������i�
     INSERT INTO OTCN_PROV_TEMP
           (ko, rnk, REF, tt, accd, nlsd, kv, acck, nlsk, nazn,
            s_nom, s_eqv)
        SELECT *
        FROM (
            SELECT /*+NO_MERGE(v) PUSH_PRED(v) */
                  '3' ko, o.rnkd rnk, o.REF, tt, o.accd, o.nlsd, o.kv, o.acck,
                     o.nlsk, o.nazn,
                     o.s * 100 s_nom,
                     gl.p_icurval (o.kv, o.s * 100, dat_) s_eqv
            FROM provodki_otc o,
               ( select /*+ index(a, XIE_DAT_A_ARC_RRP) */ o.ref
                  from arc_rrp a, oper o
                  where trunc(a.dat_a) >= Dat_
                    and a.dk = 3
                    and a.nlsb like '2909%'
                    and a.nazn like '#E2;%'
                    and trim(a.d_rec) is not null
                    and a.d_rec like '%D' || to_char(Dat_, 'yymmdd') || '%'
                    and substr(a.d_rec, 6+instr(a.d_rec, '#CREF:'),
                        instr(substr(a.d_rec, 6+instr(a.d_rec, '#CREF:')), '#')-1) = o.ref_a and
                        o.kv = a.kv and
                        o.s = a.s) v
            WHERE o.kv != 980
              and o.fdat between Dat_ - 10 and dat_
              and o.ref = v.ref
              and lower(o.nazn) not like '%��������%����%');
   end if;
   
   delete 
   from OTCN_PROV_TEMP
   where ref in (
        select ref
        from OTCN_PROV_TEMP
        group by ref
        having count(*)>1) and
        nlsd like '2924%' and nlsk like  '3739%';

   OPEN c_main;

   LOOP
      FETCH c_main
       INTO ko_, kod_obl_, rnk_, okpo1_, nmk_, k040_, adr_, k110_, codc_, sum1_, sumk1_;

      EXIT WHEN c_main%NOTFOUND;
      rez_ := MOD (codc_, 2);

      -- 16.06.2009 ������� �� ���������
      if length(trim(okpo1_)) <= 8 then
         okpo1_:=lpad(trim(okpo1_),8,'0');
      else
         okpo1_:=lpad(trim(okpo1_),10,'0');
      end if;

      -- ��� ������ �� ���� ���� �� RCUKRU(IKOD)
      -- ���������� ��� ����� ���� GLB
      if codc_ in (1,2) then
         BEGIN
            select glb into okpo1_
            from rcukru
            where trim(ikod)=trim(okpo1_)
              and rownum=1;
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
         okpo_ := trim(ser_) || ' ' || trim(numdoc_);               
         EXCEPTION WHEN NO_DATA_FOUND THEN 
            null;
         END;
      end if;

         ---������� ������i�����i ������
         OPEN opl_dok;

         LOOP
            FETCH opl_dok
             INTO ko_1, ref_, tt_, acc_, nls_, kv_, acck_, nlsk_,
                  nazn_, sum0_, sumk0_;

            EXIT WHEN opl_dok%NOTFOUND;

            okpo_ := okpo1_;
            ttd_ := null;
            nlsdd_ := null;
            d1#E2_ := null;
            d2#E2_ := null;
            d3#E2_ := null;
            d4#E2_ := null;
            d6#E2_ := null;
            d7#E2_ := null;
            d8#E2_ := null;
            db#E2_ := null;
            dc#E2_ := null;
            dc1#E2_ := '';
            d61#e2_ := null;
            de#E2_ := null;
            d53#E2_ := null;
            d54#E2_ := null;
            d55#E2_ := null;
 
            kol_61 := 0;

            mbkOK_ := false;
            kod_b_ := null;
            name_sp_ := '';

            IF ko_ = '3' AND ROUND (sumk0_ / kurs_, 0) > gr_sum_
            THEN

               formOk_ := true;

               dig_ := f_ret_dig (kv_) * 100;
                                       -- ����� ������ ���� � �������� ������

               IF ko_ = ko_1
               THEN

                  IF typ_ > 0
                  THEN
                     nbuc_ := NVL (f_codobl_tobo (acc_, typ_), nbuc1_);
                  ELSE
                     nbuc_ := nbuc1_;
                  END IF;

                  refd_ :=ref_;

                  -- OAB ������� 18.08.08 �� ������� ����� ������������
                  -- ���������� ��� ������ ��� ������������ ������
                  -- 25.07.2009 ��� ���� ������ ���������� ��� ������
                  -- � 01.08.2012 ����������� ��� ������ ����������� ��� ���������� ��������
                  BEGIN
                    SELECT SUBSTR (VALUE, 2, 3)
                       INTO d6#E2_
                    FROM operw
                    WHERE REF = ref_
                      and tag like 'n%'
                      and substr(trim(value),1,1) in ('O','P','�','�');
                  EXCEPTION WHEN NO_DATA_FOUND THEN
                     BEGIN
                       SELECT SUBSTR (VALUE, 1, 3)
                          INTO d6#E2_
                       FROM operw
                       WHERE REF = ref_
                         and tag like 'n%'
                         and substr(trim(value),1,1) not in ('O','P','�','�');
                     EXCEPTION WHEN NO_DATA_FOUND THEN
                        BEGIN
                          SELECT SUBSTR (VALUE, 1, 70)
                             INTO d6#E2_
                          FROM operw
                          WHERE REF = ref_
                            AND tag = 'D6#70';
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                           BEGIN
                             SELECT SUBSTR (VALUE, 1, 70)
                                INTO d6#E2_
                             FROM operw
                             WHERE REF = ref_
                               AND tag = 'D6#E2';
                           EXCEPTION WHEN NO_DATA_FOUND THEN
                              d6#E2_ := NULL;
                           END;
                        END;
                     END;
                  END;

                  kod_g_ := f_nbur_get_kod_g(ref_, 2);

                  if d6#E2_ is null and trim(kod_g_) is not null then
                     d6#E2_ := kod_g_;
                  end if;

                  if d6#E2_ is null or d6#E2_ not in ('804','UKR') then

                     begin
                        select p.pid, min(p.id), max(p.id)
                           into pid_, id_min_, id_
                        from contract_p p
                        where p.ref=ref_
                        group by p.pid;

                        select 20+t.id_oper, t.name, to_char(t.dateopen, 'ddmmyyyy'),
                               t.bankcountry, t.bank_code, t.benefbank, trim(t.aim)
                           into D1#E2_, D2#E2_, D3#E2_,
                                D6#E2_, D7#E2_, D8#E2_, DB#E2_
                        from top_contracts t
                        where t.pid=pid_ ;  

                        if length(trim(D7#E2_))=3 then
                           D7#E2_ := D7#E2_ ||'0000000';
                        end if;

                        BEGIN
                           select max(trim(name))
                              into DC#E2_max
                           from tamozhdoc
                           where pid=pid_
                             and id=id_;

                           select count(*)
                              INTO kol_61
                           from tamozhdoc
                           where pid=pid_
                             and id=id_;
                        exception
                                  when no_data_found then
                           DC#E2_ := null;
                        END;

                        if DC#E2_max is null then
                           BEGIN
                              select max(trim(name))
                                 into DC#E2_max
                              from tamozhdoc
                              where pid=pid_
                                and id=id_min_;

                              select count(*)
                                 INTO kol_61
                              from tamozhdoc
                              where pid=pid_
                                and id=id_min_;

                              id_ := id_min_;
                           exception
                                     when no_data_found then
                              DC#E2_ := null;
                           END;
                        end if;

                        if DC#E2_max is not null then

                           BEGIN
                              select to_char(t.datedoc,'ddmmyyyy'),
                                     lpad(trim(c.cnum_cst),9,'#')||'/'||
                                     substr(c.cnum_year,-1)||'/'||
                                     lpad(DC#E2_max,6,'0')
                                 into D4#E2_, DC#E2_
                              from tamozhdoc t, customs_decl c
                              where t.pid=pid_
                                and t.id=id_
                                and trim(t.name)=trim(DC#E2_max)
                                and trim(c.cnum_num)=trim(t.name)
                                and trim(c.f_okpo)=trim(okpo_) ;
                           exception
                                     when no_data_found then
                              null;
                           end;

                           if kol_61 <= 3 then
                              for k in (select name,
                                               to_char(datedoc,'ddmmyyyy') DATEDOC
                                        from tamozhdoc
                                        where pid=pid_
                                          and id=id_
                                          and trim(name) != trim(DC#E2_max) )
                              loop
                                 select lpad(trim(c.cnum_cst),9,'#')||'/'||
                                        substr(c.cnum_year,-1)||'/'
                                    into DC1#E2_
                                 from  customs_decl c
                                 where trim(c.cnum_num)=trim(k.name)
                                   and trim(c.f_okpo)=trim(okpo_);

                                 D61#E2_ := D61#E2_||DC1#E2_||trim(k.name)||' '||
                                            k.datedoc||',';

                              end loop;
                           else
                              D61#E2_ := '������ ��'||to_char(kol_61)||'-�� ���';
                           end if;
                        end if;
                     exception
                               when no_data_found then
                        null;
                               when too_many_rows then
                        null; -- ���� ������ �� ���������� ����������, �� ����� ��������� ����� � ������ ��������� ����
                     end;

                     if nls_ like '1919%' or nls_ like '3739%' then
                        -- ���� ��� ������ ��������
                        if tt_ = 'NOS' then
                           -- �� ���� �������� ��������, ������� �������������� NOS
                           refd_ := to_number(trim(f_dop(ref_, 'NOS_R')));

                           if refd_ is null then
                              begin
                                 select ref
                                    into refd_
                                 from oper
                                 where vdat between to_date(dat_)-7 and dat_
                                   and nlsb=nls_
                                   and kv=kv_
                                   and refl in (ref_);
                              exception
                                        when no_data_found then
                                 refd_ := null;
                              end;
                           end if;

                           -- ���� ����� �������������� ��������, �� �������� �������� ������
                           if refd_ is null then
                              begin
                                 select p.ref, p.tt, p.NLSD, p.accd
                                    into refd_, ttd_, nlsdd_, accdd_
                                 from provodki p
                                 where p.ref=ref_ and
                                       p.acck=acc_;
                              exception
                                        when no_data_found then
                                 refd_ := null;
                              end;
                           end if;

                           -- ���� ����� �������������� ��������, �� �������� �������� ��������
                           if refd_ is not null and refd_ != ref_ then
                              begin
                                 select c.rnk, trim(c.okpo), c.nmk, TO_CHAR (c.country), c.adr,
                                        NVL (c.ved, '00000'), c.codcagent, p.tt, p.NLSD, p.accd
                                    into rnk_, okpo_, nmk_, k040_, adr_, k110_, codc_, ttd_, nlsdd_, accdd_
                                 from provodki p, cust_acc ca, customer c
                                 where p.ref=refd_
                                   and p.acck=acc_
                                   and p.accd=ca.acc  --������� �� ������� ������� ���� 14.03.2008
                                   and ca.rnk=c.rnk;

                                 -- ��� ������ �� ���� ���� �� RCUKRU(IKOD)
                                 -- ���������� ��� ����� ���� GLB
                                 if codc_ in (1, 2) then
                                    okpo_ := ourGLB_;
                                 end if;

                                 IF sheme_ = 'G' AND typ_ > 0
                                 THEN
                                    nbuc_ := NVL (f_codobl_tobo (accdd_, typ_), nbuc1_);
                                 ELSE
                                    nbuc_ := nbuc1_;
                                 END IF;

                              exception
                                        when no_data_found then
                                 null;
                              end;
                           end if;

                           if refd_ is not null then
                              -- ���� �������������� �������� - ������
                              if nvl(ttd_, '***') like 'FX%' then
                                 -- �� ��������� �������� - ��� ����, ������� ����� ��� ��� �� RCUKRU
                                 okpo_ := ourGLB_;
                                 codc_ := 1;

                                 BEGIN
                                    -- ����� �������� �� ������ ������
                                    select decode(kva, 980, '30', '28'), ntik, to_char(dat, 'ddmmyyyy')
                                       into D1#E2_, D2#E2_, D3#E2_
                                    from fx_deal
                                    where refb=refd_;
                                 EXCEPTION WHEN NO_DATA_FOUND THEN
                                    null;
                                 END;
                                 if D1#E2_ = '30' then
                                    formOk_ := false;
                                 end if;
                              else
                                 -- ���� �� ������, �� �������� "�������" ������ "��������-��������� ���������"
                                 begin
                                    select p.pid, min(p.id), max(p.id)
                                       into pid_, id_min_, id_
                                    from contract_p p
                                    where p.ref=refd_
                                    group by p.pid;

                                    select 20+t.id_oper, t.name, to_char(t.dateopen, 'ddmmyyyy'),
                                           t.bankcountry, t.bank_code, t.benefbank, trim(t.aim)
                                       into D1#E2_, D2#E2_, D3#E2_,
                                            D6#E2_, D7#E2_, D8#E2_, DB#E2_
                                    from top_contracts t
                                    where t.pid=pid_ ; 

                                    if length(trim(D7#E2_))=3 then
                                       D7#E2_ := D7#E2_ ||'0000000';
                                    end if;

                                    BEGIN
                                       select max(trim(name))
                                          into DC#E2_max
                                       from tamozhdoc
                                       where pid=pid_
                                         and id=id_;

                                       select count(*)
                                          INTO kol_61
                                       from tamozhdoc
                                       where pid=pid_
                                         and id=id_;
                                    exception
                                              when no_data_found then
                                       DC#E2_ := null;
                                    END;
                                    if DC#E2_max is null then
                                       BEGIN
                                          select max(trim(name))
                                             into DC#E2_max
                                          from tamozhdoc
                                          where pid=pid_
                                            and id=id_min_;

                                          select count(*)
                                             INTO kol_61
                                          from tamozhdoc
                                          where pid=pid_
                                            and id=id_min_;

                                          id_ := id_min_;
                                       exception
                                                 when no_data_found then
                                          DC#E2_ := null;
                                       END;
                                    end if;

                                    if DC#E2_max is not null then
                                       BEGIN
                                          select to_char(t.datedoc,'ddmmyyyy'),
                                                 lpad(trim(c.cnum_cst),9,'#')||'/'||
                                                 substr(c.cnum_year,-1)||'/'||
                                                 lpad(DC#E2_max,6,'0')
                                             into D4#E2_, DC#E2_
                                          from tamozhdoc t, customs_decl c
                                          where t.pid=pid_
                                            and t.id=id_
                                            and trim(t.name)=trim(DC#E2_max)
                                            and trim(c.cnum_num)=trim(t.name)
                                            and trim(c.f_okpo)=trim(okpo_);
                                       exception
                                                 when no_data_found then
                                          null;
                                       end;

                                       if kol_61 <= 3 then
                                          for k in (select name, to_char(datedoc,'ddmmyyyy') DATEDOC
                                                    from tamozhdoc
                                                    where pid=pid_
                                                      and id=id_
                                                      and trim(name) != trim(DC#E2_max) )
                                          loop
                                             select lpad(trim(c.cnum_cst),9,'#')||'/'||
                                                    substr(c.cnum_year,-1)||'/'
                                                into DC1#E2_
                                             from  customs_decl c
                                             where trim(c.cnum_num)=trim(k.name)
                                               and trim(c.f_okpo)=trim(okpo_);

                                             D61#E2_ := D61#E2_||DC1#E2_||trim(k.name)||' '||
                                                        k.datedoc||',';

                                          end loop;
                                       else
                                          D61#E2_ := '������ �� '||to_char(kol_61)||'-�� ���';
                                       end if;

                                    end if;
                                 exception
                                           when no_data_found then
                                    null;
                                           when too_many_rows then
                                    null; -- ���� ������ �� ���������� ����������, �� ����� ��������� ����� � ������ ��������� ����
                                 end;
                              end if;
                           else
                              refd_:=ref_;
                           end if;
                        else
                           refd_:=ref_;
                        end if;
                     end if;

                     -- �� �������� ����� ��������� ���� �������
                     if substr(nls_, 1, 3) in ('151', '152', '161', '162') or
                        substr(nlsdd_, 1, 3) in ('151', '152', '161', '162') then
                        if nlsdd_ is not null then
                           s180_ := fs180(accdd_, '1', dat_);
                        else
                           s180_ := fs180(acc_, '1', dat_);
                        end if;

                        -- ���� ���� ������� ������ ������, �� �� ����� ���
                        if s180_ in ('1', '2', '3', '4', '5') then
                           formOk_ := false;
                        else
                           mbkOK_ := true;
                        end if;
                     end if;

                     if nlsk_ like '3739%' and nls_ like '2909%' 
                     then
                        begin
                           select ob22d
                              into ob22_
                           from provodki_otc
                           where fdat = Dat_
                             and ref = ref_;
                        exception
                              when no_data_found then
                           ob22_ := '00';
                        end;
                     end if;

                     if formOk_ then
                        nnnn_ := nnnn_ + 1;
                        -- ��� ������
                        p_ins (nnnn_, '10', LPAD (kv_, 3, '0'));

                        -- ���� � �������� ������ (��� 12)
                        p_ins (nnnn_, '20', TO_CHAR (ROUND (sum0_ / dig_, 0)));

                        if okpo_ = ourOKPO_ then
                           okpo_ := ourGLB_;
                           codc_ := 1 ;
                        end if;

                        if nlsk_ like '3739%' and  nls_ like '3720%'
                        then
                           BEGIN
                              select max(c.rnk), max(c.okpo)
                                 into rnk1_, okpo_
                              from operw w, person p, customer c
                              where w.ref = ref_
                                and w.tag like 'PASPN%'
                                and upper(substr(w.value,1,2)) = p.ser
                                and ( substr(w.value,3,6) = p.numdoc OR
                                      substr(w.value,4.6) = p.numdoc )
                                and p.rnk = c.rnk ;
                           EXCEPTION WHEN NO_DATA_FOUND THEN
                              null;
                           END;
                        end if;

                        if mfo_ = 300465 and 
                          (nlsk_ like '1500%' and  nls_ like '1600%')
                        then
                           p_ins (nnnn_, '31', lpad('0', 10, '0'));
                        else 
                           if nlsk_ like '3739%' and nls_ like '2909%' and ob22_ = '35'    
                           then 
                              p_ins (nnnn_, '31', '0');
                           else
                              p_ins (nnnn_, '31', lpad(trim (okpo_), 10, '0'));
                           end if;
                        end if;

                        if dat_ >= dat_izm3_ 
                        then
                           if nlsk_ like '3739%' and nls_ like '2909%' and ob22_ = '35' 
                           then 
                              p_ins (nnnn_, '32', ' ');
                           else
                              p_ins (nnnn_, '32', substr(TRIM (nmk_),1,70));
                           end if;
                        end if; 
                       
                        if okpo_='0' then
                           -- ��� ������������i
                           p_ins (nnnn_, '62', '0');
                        else
                           -- ��� ������������i
                           if nlsk_ like '3739%' and nls_ like '2909%' and ob22_ = '35'
                           then 
                              p_ins (nnnn_, '62', '1');
                           else
                              p_ins (nnnn_, '62', TO_CHAR(2 - mod(codc_,2)));
                           end if;
                        end if;

                        -- ��������i ���������
                        n_ := 13;

                        IF dat_ >= to_date('01062009','ddmmyyyy') and dat_ <= dat_Izm1_
                        THEN
                           n_ := 14;
                        END IF;

                        IF dat_ >= dat_izm3_
                        THEN
                           n_ := 17;
                        END IF;

                        FOR i IN 1 .. n_
                        LOOP
                           IF i < 10
                           THEN
                              tag_ := 'D' || TO_CHAR (i) || '#70';
                           ELSIF i=10
                           THEN
                              tag_ := 'DA#70';
                           ELSIF i = 11
                           THEN
                              tag_ := 'DB#70';
                           ELSIF i=12
                           THEN
                              tag_ := 'DC#70';
                           ELSIF i=13
                           THEN
                              tag_ := 'DA#E2';  --'DD#70';
                           ELSIF i=15 
                           THEN
                              tag_ := '59F';
                           ELSIF i=16 
                           THEN
                              tag_ := '12_2C';
                           ELSIF i=17 
                           THEN
                              tag_ := 'F089';
                           ELSE
                              tag_ := 'DE#E2';
                           END IF;

                           IF i = 1 THEN
                              tag_ := 'D1#E2';
                           END IF;

                        -- ���� ���.��������� (D1#E2 - DA#E2)
                        -- ������� 27.08.2007 ���.��������� (D1#E2, D2#70 - DC#70)
                        -- ������� 20.11.2007 �������� ���.�������� 13 - DD#70
                        -- (�i������i ��� ������i�)
                           IF ((dat_ < to_date('01062009','ddmmyyyy') and
                               ko_ = 3 AND i IN (1, 2, 3, 4, 6, 9, 10, 11, 12, 13)) 
                                  OR
                               (dat_ >= to_date('01062009','ddmmyyyy') and
                               ko_ = 3 AND i IN (1, 6, 9, 10, 13, 14)) and
                                dat_ < dat_izm3_
                                  OR
                               (dat_ >= dat_izm3_ and
                               ko_ = 3 AND i IN (1, 2, 3, 6, 9, 10, 13, 15, 16, 17)) 
                               )
                           THEN
                              BEGIN
                                 SELECT trim(SUBSTR (VALUE, 1, 70))
                                    INTO val_
                                 FROM operw
                                 WHERE REF = refd_ AND tag = tag_;
                              EXCEPTION
                                        WHEN NO_DATA_FOUND
                              THEN
                                 if i=9 then
                                    tag_ := 'D7#E2';
                                 elsif i=10 then
                                    tag_ := 'D8#E2';
                                 elsif i=13 then
                                    tag_ := 'DD#70';
                                 elsif i=15 then
                                    tag_ := '59F';
                                 elsif i=16 then
                                   tag_ := '12_2C';
                                 elsif i=17 then
                                   tag_ := 'F089';
                                 else
                                    tag_ := substr(tag_,1,3)||'E2';
                                 end if;

                                 BEGIN
                                    SELECT trim(SUBSTR (VALUE, 1, 70))
                                       INTO val_
                                    FROM operw
                                    WHERE REF = refd_ AND tag = tag_;
                                 EXCEPTION
                                           WHEN NO_DATA_FOUND
                                 THEN
                                       val_ := NULL;
                                 END;
                              END;

                              if i=2 and D2#E2_ is null then
                                 begin
                                    select trim(value)
                                       into D2#E2_
                                    from operw
                                    where ref=refd_
                                      and tag='D2#70';
                                 exception
                                    when no_data_found then
                                     null;
                                 end;
                              end if;

                              cont_num_ := D2#E2_;

                              if i=3 and D3#E2_ is null then
                                 begin
                                    select trim(value)
                                       into D3#E2_
                                    from operw
                                    where ref=refd_
                                      and tag='D3#70';
                                    
                                    if instr(D3#E2_, '/') > 0 then
                                       D3#E2_ := to_char(to_date(D3#E2_, 'dd/mm/yyyy'), 'ddmmyyyy');
                                    elsif instr(D3#E2_, '.') > 0 then
                                       D3#E2_ := to_char(to_date(D3#E2_, 'dd.mm.yyyy'), 'ddmmyyyy');
                                    elsif instr(D3#E2_, ',') > 0 then
                                       D3#E2_ := to_char(to_date(replace(D3#E2_, ',','.'), 'dd.mm.yyyy'), 'ddmmyyyy');
                                    elsif instr(D3#E2_, '-') > 0 then
                                       D3#E2_ := to_char(to_date(D3#E2_, 'dd-mm-yyyy'), 'ddmmyyyy');
                                    else 
                                       D3#E2_ := to_char(to_date(D3#E2_), 'ddmmyyyy');
                                    end if;
                                 exception
                                    when no_data_found then
                                        null;
                                    when others then
                                        null;
                                 end;
                              end if;
                              
                              cont_dat_ := D3#E2_;

                              if i=6 and val_ is null and D6#E2_ is null then
                                 begin
                                    select value
                                       into D6#E2_
                                    from operw
                                    where ref=refd_
                                      and tag='D6#70';
                                 exception
                                    when no_data_found then

                                       begin
                                          select value
                                             into D6#E2_
                                          from operw
                                          where ref=refd_
                                            and tag='KOD_G';
                                       exception
                                                 when no_data_found then
                                          D6#E2_ := null;
                                       end;
                                 end;
                              end if;

                              if i=9 and val_ is null and D7#E2_ is null then
                                 begin
                                    select substr(trim(value),1,10)
                                       into kod_b_
                                    from operw
                                    where ref=refd_
                                      and tag='KOD_B';
                                 exception
                                           when no_data_found then
                                    kod_b_ := null;
                                 end;

                                 if kod_b_ is not null then
                                    begin
                                       select distinct r.glb
                                          into D7#E2_
                                       from rcukru r
                                       where r.mfo in (select distinct f.mfo
                                                       from forex_alien f
                                                       where trim(f.kod_b)=kod_b_
                                                         and rownum=1);
                                    exception
                                              when no_data_found then
                                       D7#E2_ := null;
                                    end;
                                 end if;
                              end if;

                              if i=10 and val_ is null and D8#E2_ is null then
                                 begin
                                    select substr(trim(value),1,10)
                                       into kod_b_
                                    from operw
                                    where ref=refd_
                                      and tag='KOD_B';
                                 exception
                                           when no_data_found then
                                    kod_b_ := null;
                                 end;

                                 if kod_b_ is not null then
                                    begin
                                       select distinct r.knb
                                          into D8#E2_
                                       from rcukru r
                                       where r.mfo in (select distinct f.mfo
                                                       from forex_alien f
                                                       where trim(f.kod_b)=kod_b_
                                                         and rownum=1);
                                    exception
                                              when no_data_found then
                                       D8#E2_ := null;
                                    end;
                                 end if;
                              end if;

                              -- ��� ��������� �� default-��������
                              p_tag (i, val_, kodp_, ref_);
                              -- ����� ���������
                              p_ins (nnnn_, kodp_, val_);
                           END IF;
                        END LOOP;
                     END IF;
                  end if;
               end if;
            END IF;
         END LOOP;

         CLOSE opl_dok;
   END LOOP;

   CLOSE c_main;

---------------------------------------------------
   DELETE FROM tmp_nbu
         WHERE kodf = kodf_ AND datf = dat_;

---------------------------------------------------
   INSERT INTO tmp_nbu (kodp, datf, kodf, znap, nbuc)
      SELECT kodp, dat_, kodf_, znap, nbuc
        FROM rnbu_trace;
    ----------------------------------------
    DELETE FROM OTCN_TRACE_70
             WHERE kodf = kodf_ and datf = dat_ ;

    insert into OTCN_TRACE_70(KODF, DATF, USERID, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO)
    select kodf_, dat_, USERID_, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO
    from rnbu_trace;

    logger.info ('P_FE2_NN: End for datf = '||to_char(dat_, 'dd/mm/yyyy'));
END p_fe2_nn;
/

show errors;
