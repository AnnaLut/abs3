CREATE OR REPLACE PROCEDURE BARS.p_fd9_NN (Dat_ DATE ,
                                      sheme_ varchar2 default 'G') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : ��������� ������������ #D9 ��� �� (�������������)
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 12/12/2018 (29/11/2018, 27/11/2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
���������: Dat_ - �������� ����
           sheme_ - ����� ������������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
12.12.2018 - �������� �� � ��� �� ������ ���������� � ����
29.11.2018 - �������� ������������ ���� ���������� ��� �� ������������
27.11.2018 - �� ����� ������������� ��� 219 ���� ���� ���������
             '0000000000' ��� '9999999999'  
11.05.2018 - ��� ���� 206 �������� ������������ �������� ���������� 
04.05.2018 - �� ����� ������������� ��������� ���������� 010
16.04.2018 - �������� ������������ ���� ����(K020) � ���� K021
01.03.2018 - ��� ����������� ��� �������� - ������� ��������� �������
             �������� K021 ����� ������������� ��� "9"
02.02.2018 - ��� ���������� ���������� �� ������ ������� 
             ��� ������ �����������  (  and NVL(c.prinsider,99) = 99  )
31.01.2018 - ��_���� ���������� ������� ��������� ���������� ��� 
             ����������_�
25.01.2018 - ��_���� ���������� ���_� ZZZZZZZZZZ _ ���������� � �����
             ��� K021
13.10.2017 - ���� ��� ���� ����������� �� ���_� � ����� �������� ���_  
             K021 ������ ����������� ��������� '9' 
13.09.2017 - ��� ���� �������� � ����� �������� ������ �� "D00000000_" 
             K021 ������ ����������� ��������� '9'
18.08.2017 - ���� ��� �������� ���������� ������� ��������������� ������
             (ISE=13110,13120,13131,13132) � ���� OKPO_U ����� ��������
             '00000000' ��� '000000000' ��� '0000000000' ��� '99999' ��� 
             '999999999' ��� '9999999999' 
             �� ����� ��� ����� �������� ����� ��������� "D"||<����� �/�>
14.08.2017 - ��� �����_� �������� ����� �������� K021 ������ �����������
             ��������� '9'
10.11.2016 - ��� �� ���������� ������ ����������� �����������
17.05.2016 - ��� ���������� �� ������������ � ��� ������ ���������� ����
             ����� �������� ����� ������������� IN || <�������� ���>
13.05.2106 - ��� ������ ��������� ��� ��� �� ����� ����������
             ID_REL in (1,4) ��� �� ID_REL in (5,12)
21.04.2016 - ��� ����������� ���������� 040 ��� �� �� CUST_BUN ��������
             ������ �� ������� RNKA=RNK  � �� �������� �� RNKB
             (��������� ���������� - ������ �������� ���������)
19.04.2016 - ��� �� ������� �������� ������ ��������� ���
13.04/2016 - ��� ����������� 010, 019 ������ ����� ���� ���������� "�"
             ����� ������������� �������� '9'.
18.03.2016 - �� 01.04.2016 ����� ������������� ����� ����� ����������
             "������ _������_���_����� ����" (�������� K021 �� KOD_K021)
07.09.2015 - ���� ��� �������� ���������� ������� ��������������� ������
             (ISE=13110,13120,13131,13132) ���� OKPO_U �� ���������� �� "D"
             �� ����� ��� ����� �������� ����� ��������� "D"||<����� �/�>
07.07.2015 - ��� KL_K070 ��������� ������� "D_CLOSE is null"
17.06.2015 - �������������� ���������
10.06.2015 - ��� �� ������������ ���������� ������������ ��� IN ������ CC
08.06.2015 - ��� �������� ���������� ������� ��������������� ������
             (ISE=13110,13120,13131,13132) ����� ����������� ��� ����
             �� ���� OKPO_U (��� ��������� �������� ����� ���������
                           "D"||<����� �/�> )
03.06.2015 - ��� �������� ���������� ������� ��������������� ������
             (ISE=13110,13120,13131,13132) ����� ����������� ��� ���� ���
             "D"||<����� �/�>
29.04.2015 - ��� ����� � ������ ��������� �������� �������� ��������
             �������� (��������� ������� trim)
30.10.2014 - ��� �������� ������� ��������������� ������ (ISE=13110,13120,
             13131,13132) ����� ����������� ��� ���� ��� "D"||<����� �/�>
24.10.2014 - ��� ����� ��������� ���������� 010 ��������� ��������� ���� NB
             �� RCUKRU � ��� ������������ ��������� ���� NAME �� RC_BNK
18.02.2014 - ��� �������� �� �������� MAX �� ����� ID_REL in (5,12)
04.10.2013 - ��� �������� �� �������� ��� ID_REL=12 (�������� �����)
             �.�. ����������� ���� � �� �� ������ ��� �� ���� 01 ��� 04
             � ����� � �� ���� 12 (�������� ������ ID_REL=5)
             (� ��������� ������ �������������� ����� �����������)
16.09.2013 - �� 01.10.2013 ����������� ������������ ���������� 221
11.02.2013 - ���������� 212, 213 ����������� �� ������� 9990D0000
             (� 4-� ������� ����� �����)
11.10.2012 - � ��������� ������� ����������� ����������� ��� �����������
05.09.2012 - ��� �� �������� K074_ ������ ����������� �������� 2.
             ����������. �������� �������� 1 ��� 2.
07.08.2012 - ���������� K074_ ����� ��������� ��������� "0" ���� ��������
             K074 � KL_K070 ������ (���������� 221 )
             ��� ��  � ������������ �������� K074='0'
24.02.2011 - ��� ������������ ������ ������������ �� ��������� ����������
             "019"
25.01.2011 - ��� ����� ��������� ��� ���� ��������� ��������� ���� GLB
             �� RCUKRU � ��� ������������ ��������� ���� B010 �� RC_BNK
             (� ��� ���� B010 ������� � CUSTBANK ���� ALT_BIC)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_     varchar2(2) := 'D9';
typ_      number;
acc_      Number;
kv_       Number;
ost_      Number;
sum_proc  Number := 20;
mfo_      Varchar2(12);
mfou_     Number;
nbuc1_    Varchar2(12);
nbuc_     Varchar2(12);
nbuc2_    Varchar2(12);
kol_      Number:=0;
kol1_     Number:=0;
kol2_     Number:=0;
kol3_     Number:=0;
rnk_      Number:=0;
rnka_     Number;
rnka_k    Number:=0;
cust_     Number;
codc_     Number;
okpo_     Varchar2(14);
okpo_k    Varchar2(14);
okpo_u    Varchar2(14);
k021_k    Varchar2(1);
k021_u    Varchar2(1);
nmk_      Varchar2(70);
nmk_u_    Varchar2(70);
k040_     Varchar2(3);
obl_      Number;
ser_      Varchar2(15);
numdoc_   Varchar2(20);
ser_k     Varchar2(10);
numdoc_k  Varchar2(20);
fs_       Varchar2(2);
ise_      Varchar2(5);
ved_      Varchar2(5);
k074_     Varchar2(1);
k081_     Varchar2(1);
k110_     Varchar2(5);
k111_     Varchar2(2);
vaga1_    Number(6,2);
vaga2_    Number(6,2);
data_     Date;
kodp_     Varchar2(35);
znap_     Varchar2(70);
userid_   Number;
dd_       varchar2(2);
tk_       Varchar2(1);
cust_type number;
glb_      number;
dat_izm1     date := to_date('31/08/2013','dd/mm/yyyy');
is_foreign_bank     number;
pr_kl_    number;
-----------------------------------------------------------------------------
BEGIN
-------------------------------------------------------------------
   userid_ := user_id;
   EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
   mfo_ := F_Ourmfo();

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

   -- ��������� ������������ �����
   p_proc_set(kodf_,sheme_,nbuc1_,typ_);

   nbuc2_ := nbuc1_;

   IF nbuc2_ IS NULL THEN
      nbuc2_ := '0';
   END IF;

   -- ����� ������� ������� ���������� � 20% �� 10%
   if Dat_ >= to_date('29082008','ddmmyyyy') then
      sum_proc := 10;
   end if;

    for k in (select c.rnk RNK, NVL(c.okpo,'0000000000') OKPO,
                     c.codcagent CODC, c.nmk NMK, NVL(c.ise,'00000') ISE,
                     b.name NMK_U, NVL(trim(b.okpo_u),'0000000000') OKPO_U,
                     nvl(b.custtype_u, '2') TK, -- 1 - ������, 2 - �������
                     b.country_u K040,
                     nvl(TO_CHAR (k.KO), b.region_u) OBL,
                     c.date_on DAT,
                     NVL(b.rnkb,0) RNKA, b.rnka RNKB,
                     b.notes NOTES, b.vaga1 VAGA1, b.vaga2 VAGA2,
                     NVL(b.ved_u,'     ') VED_U, NVL(b.fs_u,'00') FS_U,
                     NVL(b.ise_u,'00000') ISE_U,
                     DECODE(b.country_u,804,1,2) REZ,
                     NVL(trim(b.doc_serial),'') SER, NVL(b.doc_number,'000000') NUMDOC,
                     'XXXXX' TAG, '0' VALUE
              from  customer c, cust_bun b, kodobl_reg k
              where c.rnk in (select distinct rnk
                              from otcn_f71_history
                              where datf = Dat_
                                and rnk is not null
                                and p040 <> 0 )
                and NVL(c.prinsider,99) = 99
                and b.region_u = to_char(k.C_REG(+))
                and c.rnk = b.rnka
                and c.rnk <> 94809201
                and c.custtype in (1, 2)
                and ( (b.id_rel in (select min(id_rel)
                                    from cust_bun
                                    where rnka = b.rnka
                                      and id_rel in (1, 4)
                                    group by rnka, rnkb, okpo_u, doc_number)
                          and nvl(b.VAGA1, 0) + nvl(b.VAGA2, 0) >= sum_proc) )
                and nvl(b.edate, Dat_) >= Dat_
                and nvl(b.bdate, Dat_) <= Dat_
                and (c.date_off is null or c.date_off > Dat_)
              --UNION
              --select c.rnk RNK, NVL(c.okpo,'0000000000') OKPO,
              --       c.codcagent CODC, c.nmk NMK, NVL(c.ise,'00000') ISE,
              --       b.name NMK_U, NVL(trim(b.okpo_u),'0000000000') OKPO_U,
              --       b.custtype_u TK, -- 1 - ������, 2 - �������
              --       b.country_u K040, nvl(TO_CHAR (k.KO), b.region_u) OBL,
              --       c.date_on DAT,
              --       NVL(b.rnkb,0) RNKA, b.rnka RNKB,
              --       b.notes NOTES, b.vaga1 VAGA1, b.vaga2 VAGA2,
              --       NVL(b.ved_u,'     ') VED_U, NVL(b.fs_u,'00') FS_U,
              --       NVL(b.ise_u,'00000') ISE_U,
              --       DECODE(b.country_u,804,1,2) REZ,
              --       NVL(trim(b.doc_serial),'') SER, NVL(trim(b.doc_number),'000000') NUMDOC,
              --       'XXXXX' TAG, '0' VALUE
              --from  customer c, cust_bun b, kodobl_reg k
              --where c.rnk in (select distinct rnk
              --                from otcn_f71_history
              --                where datf = Dat_
              --                  and rnk is not null
              --                  and p040 <> 0 )
              --  and NVL(c.prinsider,99) = 99
              --  and b.region_u = to_char(k.C_REG(+))
              --  and c.rnk = b.rnka
              --  and c.rnk <> 94809201
              --  and c.custtype = 3
              --  and b.id_rel in (select max(id_rel)
              --                   from cust_bun
              --                   where rnka = b.rnka
              --                     and id_rel in (5, 12)
              --                   group by rnka, rnkb, okpo_u, doc_number)
              --  and nvl(b.edate, Dat_) >= Dat_
              --  and nvl(b.bdate, Dat_) <= Dat_
              --  and (c.date_off is null or c.date_off > Dat_) 
             )

   loop
       nbuc_ := NVL(nbuc1_,'0');

       IF nbuc_ IS NULL THEN
          nbuc_ := '0';
       END IF;

       cust_type := null;
       k040_ := k.k040;
       ser_ := k.ser;
       numdoc_ := k.numdoc;
       nmk_ := k.nmk;
       nmk_u_ := k.nmk_u;
       okpo_u := k.okpo_u;
       okpo_ := '0000000000';

       rnka_ := k.rnka;

       if trim(k.rnka) is null OR k.rnka = 0 then
          rnka_k := rnka_k+1;
          rnka_ := rnka_k;
       end if;

       -- ��������� �� � ������� ��_����� �����
       BEGIN
          select 1
             into pr_kl_
          from customer 
          where rnk = k.rnka;
       EXCEPTION WHEN NO_DATA_FOUND THEN
          pr_kl_ := 0;
       END;

       BEGIN
          select NVL(k081,' ')
             into k081_
          from kl_k080
          where k080 = k.fs_u;
       EXCEPTION WHEN NO_DATA_FOUND THEN
          k081_ := ' ';
       END;

       BEGIN
          select NVL(k074,'0')
             into k074_
          from kl_k070
          where k070 = k.ise_u
            and d_open <= dat_
            and (d_close is null or d_close > dat_);
       EXCEPTION WHEN NO_DATA_FOUND THEN
          k074_ := '0';
       END;

       -- ��� ����?� ��������?�
       IF k.codc = 1 then
          BEGIN
             select NVL(rc.glb,0), NVL(rc.nb, nmk_)
                into glb_, nmk_
             from custbank cb, rcukru rc
             where cb.rnk = k.rnk
               and cb.mfo = rc.mfo;

             okpo_k := LPAD( TO_CHAR(glb_), 10, '0');
          EXCEPTION WHEN NO_DATA_FOUND THEN
             okpo_k := '0000000000';  --null;
          END;
          k021_k := '3';
       END IF;

       -- ��� ����?� ����������?�
       IF k.codc = 2 then
          BEGIN
             select NVL(cb.alt_bic,0), NVL(rc.name, nmk_)
                into glb_, nmk_
             from custbank cb, rc_bnk rc
             where cb.rnk = k.rnk
               and trim(cb.alt_bic) = rc.b010;

             okpo_k := LPAD( TO_CHAR(glb_), 10, '0');
          EXCEPTION WHEN NO_DATA_FOUND THEN
             okpo_k := '0000000000'; 
          END;
          k021_k := '4';
       END IF;

       -- ��� �� ����������
       if k.codc = 3 
       then
          -- ������� ���(����)
          if nvl(ltrim(trim(k.okpo), '0'), 'Z') <> 'Z' AND 
             nvl(ltrim(trim(k.okpo), '9'), 'Z') <> 'Z'  
          then
             okpo_k := LPAD (trim(k.okpo), 10, '0');
             k021_k := '1';
             if k.ise in ('13110','13120','13131','13132') then
                k021_k := 'G';
             end if;
          end if;
          -- ���������� ���(����)
          if nvl(ltrim(trim(k.okpo), '0'), 'Z') = 'Z' OR 
             nvl(ltrim(trim(k.okpo), '9'), 'Z') = 'Z'  
          then
             okpo_k := LPAD (trim(k.rnk), 10, '0');
             k021_k := 'E';
          end if;
       end if;

       -- ��� �� ������������
       if k.codc = 4 
       then
          -- ������� ���(����)
          if nvl(ltrim(trim(k.okpo), '0'), 'Z') <> 'Z' AND 
             nvl(ltrim(trim(k.okpo), '9'), 'Z') <> 'Z'  
          then
             okpo_k := LPAD (trim(k.okpo), 10, '0');
             k021_k := '1';
          end if;
          -- ���������� ���(����)
          if nvl(ltrim(trim(k.okpo), '0'), 'Z') = 'Z' OR 
             nvl(ltrim(trim(k.okpo), '9'), 'Z') = 'Z'  
          then
             okpo_k := 'I' || LPAD (trim(k.rnk), 9, '0');
             k021_k := '9';
          end if;
       end if;

       -- ��� �� ��������?�
       IF k.codc = 5 
       then
          -- ������� ���(����)
          if nvl(ltrim(trim(k.okpo), '0'), 'Z') <> 'Z' AND 
             nvl(ltrim(trim(k.okpo), '9'), 'Z') <> 'Z'  
          then
             okpo_k := LPAD (trim(k.okpo), 10, '0');
             k021_k := '2';
          end if;

          -- ���������� ���(����)
          if nvl(ltrim(trim(k.okpo), '0'), 'Z') = 'Z' OR 
             nvl(ltrim(trim(k.okpo), '9'), 'Z') = 'Z'  
          then
             BEGIN
                select NVL(replace(trim(ser),' ',''),''), NVL(numdoc,'000000')
                   into ser_k, numdoc_k
                from person
                where rnk = k.rnk;

                okpo_k := lpad(substr(ser_k||numdoc_k, 1, 10), 10, '0');
                k021_k := '6';
             EXCEPTION WHEN NO_DATA_FOUND THEN
                okpo_k := lpad(k.rnk, 10, '0');
                k021_k := '9';
             END;
          end if; 
       end if;

       -- ��� �� ����������?�
       IF k.codc = 6 
       then
          -- ������� ���(����)
          if nvl(ltrim(trim(k.okpo), '0'), 'Z') <> 'Z' AND 
             nvl(ltrim(trim(k.okpo), '9'), 'Z') <> 'Z'  
          then
             okpo_k := LPAD (trim(k.okpo), 10, '0');
             k021_k := '2';
          end if;

          -- ���������� ���(����)
          if nvl(ltrim(trim(k.okpo), '0'), 'Z') = 'Z' OR 
             nvl(ltrim(trim(k.okpo), '9'), 'Z') = 'Z'  
          then
             BEGIN
                select NVL(replace(trim(ser),' ',''),''), NVL(numdoc,'000000')
                   into ser_k, numdoc_k
                from person
                where rnk = k.rnk;

                okpo_k := 'I' || lpad(substr(ser_k||numdoc_k, 1, 10), 9, '0');
                k021_k := 'B';
             EXCEPTION WHEN NO_DATA_FOUND THEN
                okpo_k := 'I' || lpad(TO_CHAR(k.rnk), 9, '0');
                k021_k := '9';
             END;
          end if; 
       end if;

       -- ������� ��
       if k.tk in (1, 3) 
       then
          -- ������� ���(����)
          if  nvl(ltrim(trim(k.okpo_u), '0'), 'Z') <> 'Z' and
              nvl(ltrim(trim(k.okpo_u), '9'), 'Z') <> 'Z'
          then
             if k040_ <> '804' then
                select count(*)
                into is_foreign_bank
                from rc_bnk
                where b010 = trim(k.okpo_u);
             
                if is_foreign_bank <> 0 then
                   okpo_ := lpad(substr(NVL(trim(okpo_u),'0'), 1, 10), 10, '0');
                   k021_u := '4';
                else
                   okpo_ := 'I' || lpad(substr(NVL(trim(okpo_u),'0'), 1, 8), 9, '0');
                   k021_u := '8';
                end if;
             else
                okpo_ := substr(lpad(trim(k.okpo_u), 10, '0'), 1, 10);
                k021_u := '1';
                -- ������ �������� �����
                if k.ise_u in ('13110','13120','13131','13132') then
                   k021_u := 'G';
                end if;
             end if;
          end if;

          -- ���������� ���(����)
          if  nvl(ltrim(trim(k.okpo_u), '0'), 'Z') = 'Z' or
              nvl(ltrim(trim(k.okpo_u), '9'), 'Z') = 'Z'
          then
             if k040_ = '804' then
                if pr_kl_ = 1 
                then
                   okpo_ := lpad(to_char(k.rnka), 10, '0');
                   k021_u := '9';
                else
                   okpo_ := lpad(to_char(k.rnka), 10, '0');
                   k021_u := 'E';
                end if;
             else
                if pr_kl_ = 1 
                then
                   okpo_ := 'I' || lpad(to_char(k.rnka), 9, '0');
                   k021_u := 'C';
                else
                   okpo_ := 'I' || lpad(to_char(k.rnka), 9, '0');
                   k021_u := '9';
                end if;
             end if;
          end if; 
       end if; 

       -- ������� ��
       if k.tk = 2 
       then
          -- ������� ���(����) 
          if  nvl(ltrim(trim(k.okpo_u), '0'), 'Z') <> 'Z' and
              nvl(ltrim(trim(k.okpo_u), '9'), 'Z') <> 'Z'
          then
             if k040_ <> '804' then
                okpo_ := 'I' || lpad(substr(NVL(trim(okpo_u),'0'), 1, 8), 9, '0');
                k021_u := '7';
             else
                okpo_ := substr(lpad(trim(k.okpo_u), 10, '0'), 1, 10);
                k021_u := '2';
             end if;
          end if;

          -- ���������� ���(����)
          if  nvl(ltrim(trim(k.okpo_u), '0'), 'Z') = 'Z' or
              nvl(ltrim(trim(k.okpo_u), '9'), 'Z') = 'Z'
          then
             if k040_ = '804' then
                if pr_kl_ = 1 
                then
                   okpo_ := lpad(substr(ser_ || numdoc_, 1, 10), 10, '0');
                   okpo_u := ser_ || numdoc_;
                   k021_u := '6';
                else              
                   okpo_ := lpad(to_char(k.rnka), 10, '0');
                   k021_u := 'E';
                end if;
             else
                if pr_kl_ = 1 
                then
                   if length(trim(ser_ || numdoc_))>3
                   then 
                      okpo_ := 'I' || lpad(substr(ser_ || numdoc_, 1, 9), 9, '0');
                      k021_u := 'B';
                   else
                      okpo_ := 'I' || lpad(to_char(k.rnka), 9, '0');
                      k021_u := '9';
                   end if;
                else
                   if length(trim(ser_ || numdoc_))>3
                   then 
                      okpo_ := 'I' || lpad(substr(ser_ || numdoc_, 1, 9), 9, '0');
                      k021_u := 'B';
                   else
                      okpo_ := 'I' || lpad(to_char(k.rnka), 9, '0');
                      k021_u := '9';
                   end if;
                end if;
             end if;
          end if;
       end if;

       if lower(k.nmk) like '%���_���%�_�_���_�%'
       then
          k021_k := 'E';
       end if;

       if lower(k.nmk_u) like '%���_���%�_�_���_�%'
       then
          k021_u := 'E';
       end if;

       if cust_type is not null then
          cust_ := cust_type;
       end if;

       if k.tk = 1 then
          cust_ := 2;
       else
          cust_ := 1;
       end if;

       if k021_u = '4'
       then
          cust_ := 2;
       end if;
 
       if k040_ <> '804' or cust_ = 1 then
          k074_ := '0';
       end if;
     

-- ��� 010
      kodp_ := '010'||lpad(okpo_k,10,'0')||'0000000000'||k021_k||'9'||'000000'||lpad(to_char(k.rnkb),4,'0');
      znap_ := nmk_;  --k.nmk;

      insert into bars.rnbu_trace
      (nls, kv, odate, kodp, znap, nbuc, rnk) VALUES
      ('00000', 980, k.dat, kodp_, znap_, nbuc_, k.rnk);

-- ��� 205
      kodp_ := '205'||lpad(okpo_k,10,'0')||lpad(okpo_,10,'0')||k021_k||k021_u||
               lpad(to_char(rnka_),6,'0')||lpad(to_char(k.rnkb),4,'0');
      znap_ := nmk_u_;

      insert into bars.rnbu_trace
      (nls, kv, odate, kodp, znap, nbuc, rnk) VALUES
      ('00000', 980, k.dat, kodp_, znap_, nbuc_, k.rnk);

-- ��� 206
      kodp_ := '206'||lpad(okpo_k,10,'0')||lpad(okpo_,10,'0')||k021_k||k021_u||
      	       lpad(to_char(rnka_),6,'0')||lpad(to_char(k.rnkb),4,'0');
      znap_ := to_char(cust_);

      insert into bars.rnbu_trace
      (nls, kv, odate, kodp, znap, nbuc, rnk) VALUES
      ('00000', 980, k.dat, kodp_, znap_, nbuc_, k.rnk);

-- ��� 250
      kodp_ := '250'||lpad(okpo_k,10,'0')||lpad(okpo_,10,'0')||k021_k||k021_u||
               lpad(to_char(rnka_),6,'0')||lpad(to_char(k.rnkb),4,'0');
      znap_ := lpad(k040_,3,'0');

      insert into bars.rnbu_trace
      (nls, kv, odate, kodp, znap, nbuc, rnk) VALUES
      ('00000', 980, k.dat, kodp_, znap_, nbuc_, k.rnk);

-- ��� 255
      kodp_ := '255'||lpad(okpo_k,10,'0')||lpad(okpo_,10,'0')||k021_k||k021_u||
               lpad(to_char(rnka_),6,'0')||lpad(to_char(k.rnkb),4,'0');
      if k040_ != '804' then
         znap_ := '00';
      else
         znap_ := to_char(k.obl);
      end if;

      insert into bars.rnbu_trace
      (nls, kv, odate, kodp, znap, nbuc, rnk) VALUES
      ('00000', 980, k.dat, kodp_, znap_, nbuc_, k.rnk);

      if dat_ < to_date('31082007','ddmmyyyy') then
         -- ��� 220
         kodp_ := '220'||lpad(okpo_k,10,'0')||lpad(okpo_,10,'0')||k021_k||k021_u||
                  lpad(to_char(rnka_),6,'0')||lpad(to_char(k.rnkb),4,'0');
         znap_ := k081_;
      else
         -- ��� 221
         kodp_ := '221'||lpad(okpo_k,10,'0')||lpad(okpo_,10,'0')||k021_k||k021_u||
                  lpad(to_char(rnka_),6,'0')||lpad(to_char(k.rnkb),4,'0');
         znap_ := k074_;
      end if;
      -- ����������� �� 01.10.2013
      if dat_ < dat_izm1 then
         insert into bars.rnbu_trace
         (nls, kv, odate, kodp, znap, nbuc, rnk) VALUES
         ('00000', 980, k.dat, kodp_, znap_, nbuc_, k.rnk);
      end if;

-- ��� 225
      kodp_ := '225'||lpad(okpo_k,10,'0')||lpad(okpo_,10,'0')||k021_k||k021_u||
               lpad(to_char(rnka_),6,'0')||lpad(to_char(k.rnkb),4,'0');
      znap_ := k.ved_u;

      insert into bars.rnbu_trace
      (nls, kv, odate, kodp, znap, nbuc, rnk) VALUES
      ('00000', 980, k.dat, kodp_, znap_, nbuc_, k.rnk);

-- ��� 212
      kodp_ := '212'||lpad(okpo_k,10,'0')||lpad(okpo_,10,'0')||k021_k||k021_u||
               lpad(to_char(rnka_),6,'0')||lpad(to_char(k.rnkb),4,'0');
      if k.vaga1 = 0 then
         znap_ := to_char(k.vaga1);
      else
         znap_ := trim(to_char(k.vaga1,'9990D0000'));
      end if;

      if trim(znap_) is not null then
         insert into bars.rnbu_trace
         (nls, kv, odate, kodp, znap, nbuc, rnk) VALUES
         ('00000', 980, k.dat, kodp_, znap_, nbuc_, k.rnk);
      end if;

-- ��� 213
      kodp_ := '213'||lpad(okpo_k,10,'0')||lpad(okpo_,10,'0')||k021_k||k021_u||
               lpad(to_char(rnka_),6,'0')||lpad(to_char(k.rnkb),4,'0');
      if k.vaga2 = 0 then
         znap_ := to_char(k.vaga2);
      else
         znap_ := trim(to_char(k.vaga2,'9990D0000'));
      end if;

      if trim(znap_) is not null then
         insert into bars.rnbu_trace
         (nls, kv, odate, kodp, znap, nbuc, rnk) VALUES
         ('00000', 980, k.dat, kodp_, znap_, nbuc_, k.rnk);
      end if;

      if k.codc in (4,6) and 
         nvl(ltrim(trim(k.okpo), '0'), 'Z') <> 'Z' and
         nvl(ltrim(trim(k.okpo), '9'), 'Z') <> 'Z' and
         length(trim(k.okpo))>8 
      then

         kodp_ := '019'||lpad(okpo_k,10,'0')||'0000000000'||k021_k||'9'||'000000'||lpad(to_char(k.rnkb),4,'0');
         znap_ := trim(k.okpo);

         insert into bars.rnbu_trace
         (nls, kv, odate, kodp, znap, nbuc, rnk) VALUES
         ('00000', 980, k.dat, kodp_, znap_, nbuc_, k.rnk);

      end if;

      if k040_<>'804' and length(trim(okpo_u))>8 and 
         nvl(ltrim(trim(okpo_u), '0'), 'Z') <> 'Z' AND 
         nvl(ltrim(trim(okpo_u), '9'), 'Z') <> 'Z'
      then
         kodp_ := '219'||lpad(okpo_k,10,'0')||lpad(okpo_,10,'0')||k021_k||k021_u||
      		  lpad(to_char(rnka_),6,'0')||lpad(to_char(k.rnkb),4,'0');
         znap_ := trim(okpo_u);

         insert into bars.rnbu_trace
         (nls, kv, odate, kodp, znap, nbuc, rnk) VALUES
         ('00000', 980, k.dat, kodp_, znap_, nbuc_, k.rnk);

      end if;
   end loop;
  ---------------------------------------------------
   DELETE FROM tmp_nbu where kodf = kodf_ and datf = dat_;
   ---------------------------------------------------
   for k in (select kodp, znap, nbuc from rnbu_trace)
   loop
       select count(*) into kol1_
       from tmp_nbu
       where kodf = kodf_ and
             datf = dat_ and
            substr(kodp,1,25) = substr(k.kodp,1,25);

       if kol1_ = 0 then
          INSERT INTO tmp_nbu (kodp, datf, kodf, nbuc, znap) VALUES
                              (k.kodp, dat_, kodf_, k.nbuc, k.znap);
       end if;
   end loop;
  ----------------------------------------
END p_fd9_NN;
/
