

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FE9_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FE9_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_FE9_NN ( dat_     DATE,
                                       sheme_   VARCHAR2 DEFAULT 'D') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :   ��������� ������������ #E9 ��� �� 
% COPYRIGHT   :   Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :   01.04.2014 (22.08.2013,21.08.2013,17.07.2013,10.07.2013)  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
���������: Dat_ - �������� ����
           sheme_ - ����� ������������

01.04.2014 - � 31.03.2014 ����� ��������� ���������� (�������� ��� "KKK"
             ��� �������) 
22.08.2013 - ��������� ������� ��� ����� ��������� � PROVODKI ����� ����� 
             � OPER (��������� �������� ��������)
21.08.2013 - ��� �������� �� 2809 �� 2909 ��� ���������� ����� ���������� 
             �� ���.������ '100*','262*' (����� ���� ������ �� 100*)
17.07.2013 - ��� ����� ������ ��� ������ �����������/����������
             ������������� �������� �� TAG="KOD_G'  
10.07.2013 - ��� �� 2809, 2909 ��� ������ ����������� �������� ��
             ���.��������� D1#E9 � ��� ������ ���������� ����� 804
             � ��� �� 100, 2620, 2902,2924 � �� 2809, 2909 
             ��� ������ ����������� 804 � ���������� �� D1#E9
             � D060 (��� ������� ���������) �������� �� ���.���������
             D060
26.03.2013 - ��� ���������� ����� ���������� �� ���.������ 
            '100*','262*', '2900', '2902', '2924'
02.10.2009 - ��� �������� ���� �� 100* �� 2909 ��� ������ ������ 804
17.03.2009 - ������� ��� ���������� TMP_NBU �������� �����
02.04.2008 - � �������� ������������ ����. RNBU_TRACE ��������� ���������� 
             ���� ISP - ����� �����������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   kodf_      VARCHAR2 (2)   := 'E9';
   sql_z      VARCHAR2 (200);
   typ_       NUMBER;
   flag_      NUMBER;
   ko_        VARCHAR2 (2);      -- ������ ������ii � ������i������ i��������
   ko_1       VARCHAR2 (2);      -- ������ ������ii � ������i������ i��������
   kod_b_     VARCHAR2 (10);                          -- ��� �����
   nam_b      VARCHAR2 (70);                        -- ����� �����
   n_         NUMBER         := 4;
   acc_       NUMBER;
   acc1_      NUMBER;
   acck_      NUMBER;
   kv_        NUMBER;
   kv1_       NUMBER;
   nls_       VARCHAR2 (15);
   nls1_      VARCHAR2 (15);
   nlsk_      VARCHAR2 (15);
   nlsk1_     VARCHAR2 (15);
   isp_       NUMBER;
   nbuc1_     VARCHAR2 (12);
   nbuc_      VARCHAR2 (12);
   country_   VARCHAR2 (3);
   d060_      NUMBER;
   rnk_       NUMBER;
   okpo_      VARCHAR2 (14);
   nmk_       VARCHAR2 (70);
   k040_      VARCHAR2 (3);
   val_       VARCHAR2 (70);
   tg_        VARCHAR2 (70);
   fdat_      DATE;
   data_      DATE;
   dat1_      DATE;
   sum0_      DECIMAL (24);
   sumk0_     DECIMAL (24);                            --���_�_� �� ���������
   kodp_      VARCHAR2 (15);
   znap_      VARCHAR2 (70);
   tag_       VARCHAR2 (5);
   userid_    NUMBER;
   ref_       NUMBER;
   mfo_       number;
   mfou_      number;
   tt_        varchar2(3);
   comm_      varchar2(200);

   formOk_    boolean;
   ttd_       varchar2(3);
   nlsdd_     varchar2(20);


   d1#E9_     VARCHAR2 (70);
   d2#E9_     VARCHAR2 (70);
   d3#E9_     VARCHAR2 (70);
   d4#E9_     VARCHAR2 (70);
   our_reg_   NUMBER;
   b040_      VARCHAR2 (20);
   kkk_       VARCHAR2(3);
   dat_izm1   date := to_date('31032014','ddmmyyyy');

-- ������� ����i� �� �i�������i� ������i �������� ����i� ��� ��������� ��������
   CURSOR opl_dok
   IS
      SELECT   t.ko, t.fdat, t.TT, t.REF, t.accd, t.nlsd, t.kv, t.acck, t.nlsk, 
               max(t.s_nom), max(t.s_eqv)
      FROM OTCN_PROV_TEMP t
      WHERE t.nlsd is not null 
        and t.nlsk is not null
      GROUP BY t.ko, t.fdat, t.TT, t.REF, t.accd, t.nlsd, t.kv, t.acck, t.nlsk;

-------------------------------------------------------------------
   PROCEDURE p_ins (p_kodp_ IN VARCHAR2, p_znap_ IN VARCHAR2)
   IS
      l_kodp_   VARCHAR2 (15);
   BEGIN
      l_kodp_ := p_kodp_ ;
      
      INSERT INTO rnbu_trace
         (nls, kv, odate, kodp, znap, nbuc, isp, rnk, ref, comm)
      VALUES 
         (nls1_, kv_, fdat_, l_kodp_, p_znap_, nbuc_, isp_, rnk_, ref_, comm_);
	  
   END;
-------------------------------------------------------------------
-----------------------------------------------------------------------------
BEGIN

   userid_ := user_id;

   EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
   EXECUTE IMMEDIATE 'TRUNCATE TABLE otcn_prov_temp';
   EXECUTE IMMEDIATE 'ALTER SESSION SET NLS_NUMERIC_CHARACTERS=''.,''';
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
   Dat1_ := ADD_MONTHS(Dat_, -2);
   Dat1_ := TRUNC(Dat1_,'MM');

   -- ��� �������, ��� ���������� ����
   --BEGIN
   --   b040_ := LPAD (f_get_params ('OUR_TOBO', NULL), 12, 0);

   --   IF SUBSTR (b040_, 1, 1) IN ('0', '1')
   --   THEN
   --      our_reg_ := TO_NUMBER (SUBSTR (b040_, 2, 2));
   --   ELSE
   --      our_reg_ := TO_NUMBER (SUBSTR (b040_, 7, 2));
   --   END IF;

   --   our_reg_ := NVL (our_reg_, '00');
   --END;

   -- ��� "KKK" - ��� ������� � 31.03.2014 
   kkk_ := '';

   -- ��������� ������������ �����
   p_proc_set (kodf_, sheme_, nbuc1_, typ_);

   -- ����� ��������, ��������������� �������
   -- ������� ����i� �� �i�������i� ������i �������� ����i� ��� ��������� ��������
   -- ������� ����i� ������������ (��������� ����i� �i� ����������i�)
   if mfo_ = 300120 then
      INSERT INTO OTCN_PROV_TEMP
                  (ko, rnk, fdat, REF, tt, accd, nlsd, kv, acck, nlsk, s_nom, s_eqv)
         SELECT *
           FROM (
                 SELECT   '999' ko, ca.rnk, o.fdat, o.REF, o.tt, o.accd, o.nlsd, o.kv, o.acck, o.nlsk,
                          o.s * 100 s_nom,
                          gl.p_icurval (o.kv, o.s * 100, dat_) s_eqv
                     FROM provodki o, cust_acc ca
                    WHERE o.fdat >= Dat1_
                      AND o.fdat <= Dat_
                      AND DECODE(substr(o.nlsd,1,4),'2809',o.accd,'2909',o.accd,o.acck)=ca.acc
                      AND o.tt in ('��1','��2','��3','��4') );
   else 
      INSERT INTO OTCN_PROV_TEMP
                  (ko, rnk, fdat, REF, tt, accd, nlsd, kv, acck, nlsk, s_nom, s_eqv)
         SELECT *
           FROM (
                 SELECT   k.d060 ko, ca.rnk, o.fdat, o.REF, o.tt, o.accd, o.nlsd, o.kv, o.acck, o.nlsk,
                          o.s * 100 s_nom,
                          gl.p_icurval (o.kv, o.s * 100, dat_) s_eqv
                     FROM provodki o, cust_acc ca, kl_fe9 k, oper w
                    WHERE o.fdat >= Dat1_
                      AND o.fdat <= Dat_
                      AND DECODE(substr(k.nlsd,1,4),'2809',o.accd,'2909',o.accd,o.acck)=ca.acc
                      AND trim(o.nlsd) LIKE trim(k.nlsd)||'%' 
                      AND trim(o.nlsk) LIKE trim(k.nlsk)||'%'
                      AND NVL(trim(k.kv),o.kv)=o.kv 
                      AND NVL(trim(k.tt),o.tt)=o.tt 
                      AND o.ref = w.ref 
                      AND o.s*100 = w.s 
                );
   end if;
 
   -- ������� ����i� ������������ (��������� ����i� �i� ����������i�)
   OPEN opl_dok;

   LOOP
      FETCH opl_dok
       INTO d060_, fdat_, tt_, ref_, acc_, nls_, kv_, acck_, nlsk_, sum0_, sumk0_;

      EXIT WHEN opl_dok%NOTFOUND;
      
      ttd_ := null;
      nlsdd_ := null;
      d1#E9_ := null;
      d2#E9_ := null;
      d3#E9_ := null;
      d4#E9_ := null;
      kod_b_ := null;
   		
      IF sum0_ <> 0 THEN

         formOk_ := true;

         if nls_ like '100%' or nls_ like '262%' or nls_ like '2900%' or nls_ like '2902%' or nls_ like '2924%' then
            acc1_ := acc_;
            nls1_ := nls_;
         else
            acc1_ := acck_;
            nls1_ := nlsk_;
         end if;

         --if nls_ like '2809%' then
         --   acc1_ := acc_;
         --   nls1_ := nls_;
         --else
         --   acc1_ := acck_;
         --   nls1_ := nlsk_;
         --end if;                

         if mfo_ = 353575 and nls_ like '2809%' and nlsk_ like '2909%' then
            BEGIN
               select p.acck 
                  into acc1_
               from provodki p  
               where p.nlsd = nlsk_ 
                 and p.kv = kv_ 
                 and p.ref = ref_ 
                 and (p.nlsk like '100%' or p.nlsk like '262%'); 
            EXCEPTION WHEN NO_DATA_FOUND THEN 
               null;
            END; 
         end if; 

         -- �� 01.04.2014 ���� ����� ���������������� 
         -- �� � ���������� �������� ��� ������� (��� KKK)
         IF dat_ >= dat_izm1 then
            nbuc_ := nbuc1_; 
            kkk_ := lpad (f_codobl_tobo (acc1_, 4), 3, '0');
         ELSE              
            IF sheme_ in ('C','G','D') AND typ_ > 0 THEN
               nbuc_ := NVL (f_codobl_tobo (acc1_, typ_), nbuc1_);
            ELSE
               nbuc_ := nbuc1_;
            END IF;
         END IF;

         if formOk_ then  
            -- ��������i ���������
            n_ := 2;

            BEGIN 
               select userid into isp_ 
               from oper  
               where ref=ref_;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               isp_ := 0;
            END;

            FOR i IN 1 .. n_
               LOOP
                  IF i = 1 THEN
                     begin
                        select trim(value)
                           into D1#E9_
                        from operw
                        where ref=ref_ 
                          and tag='D1#E9';
                     exception
                             when no_data_found then
                        D1#E9_ := '000';
                     end;
                  END IF;

                  if i=2 then
                     begin
                        select trim(value)
                           into D060_
                        from operw
                        where ref=ref_ 
                          and tag='D060';
                     exception
                             when no_data_found then
                        null;
                     end;
                  end if;
            END LOOP;

            comm_ := 'D1#E9 = '||d1#e9_;

            if (d1#e9_ is null or d1#e9_ = '000') and mfo_ = 353575 
            then    
               begin
                  select trim(value)
                     into D1#E9_
                  from operw
                  where ref=ref_ 
                    and tag='KOD_G';
               exception
                       when no_data_found then
                  D1#E9_ := '000';
               end;
            end if;

            if kv_ = 980 and d1#e9_ in ('000','804')  
            then
               kkk_ := '000';
            end if;

            if kv_ = 980 and d1#e9_ = '000' and mfo_ = 353575 
            then    
               d1#e9_ := '804';
            end if;

            if nls_ like '2809%' or nls_ like '2909%' then
               d2#e9_ := '804'; 

               kodp_ := '1'||lpad(to_char(d060_),2,'0')||
                             lpad(to_char(kv_),3,'0')||
                             lpad(d1#e9_,3,'0')||
                             lpad(d2#e9_,3,'0') || kkk_;
            else
               d2#e9_ := '804';

               kodp_ := '1'||lpad(to_char(d060_),2,'0')||
                             lpad(to_char(kv_),3,'0')||
                             lpad(d2#e9_,3,'0')||
                             lpad(d1#e9_,3,'0') || kkk_;
            end if;

            if d060_ <> 999 then                   
               -- ����� ��������� ����
               p_ins (kodp_, to_char(sum0_) );
               -- ����� ��������� �i������i
               kodp_ := '3'||substr(kodp_,2);
               p_ins (kodp_, '1' );
            end if;

         end if;
      END IF;
   END LOOP;

   CLOSE opl_dok;
---------------------------------------------------
   DELETE FROM tmp_nbu
         WHERE kodf = kodf_ AND datf = dat_;
---------------------------------------------------
   INSERT INTO tmp_nbu (kodp, datf, kodf, znap, nbuc)
      SELECT kodp, dat_, kodf_, SUM(to_number(znap)), nbuc
        FROM rnbu_trace
       WHERE userid = userid_
      GROUP BY KODP,NBUC;
----------------------------------------
END p_fe9_nn;
/
show err;

PROMPT *** Create  grants  P_FE9_NN ***
grant EXECUTE                                                                on P_FE9_NN        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FE9_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
