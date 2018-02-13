

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FD2_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FD2_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_FD2_NN (Dat_ DATE ,
                                      sheme_ varchar2 default 'G') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : ��������� ������������ #D2 ��� �� (�������������)
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.18.001       07.02.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
���������: Dat_ - �������� ����
           sheme_ - ����� ������������

   ��������� ����������     L DD � C

  1    L          1/3  (�����/����������)
  2    DD         ������� �� ������� ������������
  4    �          K013 ��� ���� �������
  5    C          R034 ������� ��� ������

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
07.02.2018  �������� ��������� � R013 �������� �� R011
04/02/2015 - ��� �������� �� ����� 2903 (���������� 111...) ����� ��������
             ������� � ������ ��������������.
23/12/2014 - ������� ������� � �������
16/02/2014 - ��� 322669, 324805 ��� ������� ��� ������������ ����������
             �� ���� TOBO �����, � �� �� ���� TOBO ������� � �������
             ��������� � ������ ����� �������� -
             ���� ����������� 301XX, 302XX
13/02/2014 - ��� ���.����� 2620 � R013='9' � R014='6' ����� �����������
             �������� ���� "DD" 06 ������ 15
07/02/2014 - ��� ���.����� 2604 ����� ���������� K013='3' ���� SED<>'91'
30/01/2014 - ���.���� 2903 �������� � ���� � ���������� R013 in (0,1,9)
             ����� ���� ������ R013='1'
28/01/2014 - ��� �������� ���������� � ��������� ����� ��������� ���� ISE
             (14101,14201) ������ VED (74111, 74112)
             � ������ ������� ���������� ��� �� CUSTOMERW � ����� ��������
             ��� K013 � ����������� �� ����������� �����
15/02/2013 - ��� ���������� ��������� �� ���������� TYP_ ������ ����������
             SHEME_
14/02/2013 - ��� ���=322669 ������� ������� ��� �������� ���������� ������
             2620,2630,2635 � TIP='ODB'(����������������� �����)
12/02/2013 - ��� ��� (300205) �� ���������� �������� tag='K013'
10/02/2013 - ������� ����������� ���������� SQL_ � 500 �������� �� 2000
08/01/2013 - � 01.01.2013 �� ����� ������������� ���������� 30511,30512,
             307XX, 31010, 11110, 31440, 31460
12/10/2012 - ����������� ���� ���������� ����� ����������� ��� ����� �����
             ��� PR_TOBO <> 0
20/07/2012 - ��������� ���� K013 ��� �� ���������������� � ����� ��
28/02/2012 - ������� ������������ ����� 12, 16 (������ �������� ������ �
             ���������� �������� ��������� R014)
16/02/2012 - ��� ���.����� 2620 � R014 in ('2','3') ����� �������������
             ��� 12 ����� ��� 16
15/02/2012 - ��� ���=322669 ������� ����������������� ����� (TIP='ODB)
             ���������� 2620,2630,2635
18/01/2012 - ��� ������ ���� "DDD" �� ��-�� KL_F3_29 ��� ����� #D2
             ������� ������� ROWNUM=1
14/07/2011 - ��� ������� ��������� ����� 8021,8022,8023 ������� �������
             � �������� ������������ 15 � 16 ����� ��� ���.�����
             (����� ���� ������� ���.����� 2605,2625,2655)
12/07/2011 - � ��� 01 �� ���������� ������� ������� �������������� ������
             � ���� DD='12'
11/07/2011 - �� ���� DD='12' ��������� ���.���� 2625 (������ ���� R014
             ���� �� 1,2,3,4,6,7 ����� ��������)
08/07/2011 - ����� ��������� �������� ����������� 316�� ��������
             ������������ ���� 16 � ����������� �� ��������� R014
07/07/2011 - � ��-� ��������� ���.����� ��� ���� 15 � ����� �����������
             ���� 15 ��� 16 � ����������� �� ��������� R014
05.07.2011 - �� ������ ������������� ���� 04,08,13 (������� �� KL_F3_29)
             ������� ������������ ���� '14' (R014='2','4','5','7')
19.05.2011 - � �������� ������������ ������� ���������� ���� ACC
28.04.2011 - ��� ������������� ������� ��� ������� "6"-��� ����� 1-5
27.04.2011 - � ���������� 05 ������� ��� ������� �� "3". ����� ���������.
             (��������� �������������)
07.02.2011 - ��� ����� ������������ �������� K013 ����� �������� ��
             ���. ��������� K013 �� CUSTOMERW (��������� �����)
18.01.2011 - �������� �������� ��������� "obl_" � 2 �� 12 ��������
10.01.2011 - �������� ������������ ����� "30961","30962","30963","30964",
             "30965","30966","30967","30968"
             ��
             "31321","31322","31331","31332",
             "31341","31342","31351","31352"
             ���������� "12" ����� �����������  ��� R014 in ('1','2','3').
21.07.2010 - ��� ����� ������ ���.����� 8021,8022,8023 �� �������� � �����
             ���� ���������� ������ (���������� "dd1_ := '99')
15.07.2010 - ��� ����� ������ ��� ���.����� 8021 ���������� ����.���� ��
             ����. NSMEP_SPARAMS (���� BAL_NLS) � ���� 2605 �� ��� �������
             ����� "3"(��) � ����� ����� �� �������� � ���� �� �������
             ����� ������ (������ �� 16.07.2010
19.05.2010 - ��� ������� ��� ������������ ���������� �� ���� TOBO �������,
             � �� �� ���� TOBO ����� � ������� ��������� ���� ���, � ��
             ��������� ���� ����� ������� � ������ ����� �������� -
             ���� ����������� 301XX, 302XX
22.04.2010 - ���� � CUSTOMERW tag='K013' � �������� �������� �� 1,2,3,4,5
             �� ��� �� ������������ (��������� �������������)
10.02.2010 - ��������� ������������ ����� ����� "30961"."30962","30963",
             "30964","30965","30966","30967","30968"
07.07.2009 - ��� ����� �� �� �������� ���.����� 8605,8625
05.01.2009 - ����������� �������� �� ���.������ � �� �������� ��� ����� 04,
             05,06,07,08,09 (��������� ������ � ����������).
29.01.2008 - �� ��������� ������� ��� ���� ������� "3".
06.02.2007 - ��������� ����� ���� "02", "12".
12.07.2006 - ������� ����� ����� "G" ����� "D" ��� ����������� ���� �������
������ �� 22.05.2006 ���� �������� ��� �������� ������ � ������������
15.03.2006 - ����� "G" � ������� ����� ��������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='D2';
typ_     number;
acc_     Number;
kv_      Number;
ost_     Number;
nls_     Varchar2(15);
nlsk_    Varchar2(15);
nlsk1_   Varchar2(15);
nbs1_    Varchar2(4);
mfo_     Varchar2(12);
nbuc1_   Varchar2(12);
nbuc_    Varchar2(12);
nbuc2_   Varchar2(12);
r011_    Varchar2(1);
r013_    Varchar2(1);
r014_    Varchar2(1);
k013_    Varchar2(1):='9';
k013_n   Varchar2(1);
c_       Varchar2(1);
kol_     Number;
rnk_     Number:=0;
okpo_    Varchar2(14);
data_    Date;
kodp_    Varchar2(10);
znap_    Varchar2(70);
userid_  Number;
dd_      varchar2(2);
dd1_     varchar2(2);
tk_      Varchar2(1);
sed_     Varchar2(2);
ise_     Varchar2(5);
ved_     Varchar2(5);
fs_      Varchar2(2);
sql_     VARCHAR2(2000);
comm_    Varchar2(200);
n_dat1_  NUMBER;
ret_     number;
sql_acc_ varchar2(2000):='';
sql_doda_ varchar2(200):='';

function f_codobl_cust(rnk_ in number) return varchar2 is
    obl_    varchar2(12);
    b040_   varchar2(20);

begin

   BEGIN
      select distinct b.b040
         into b040_
      from customer c, tobo b
      where c.rnk=rnk_
        and c.tobo=b.tobo;

      if substr(b040_,9,1)='0' then
         obl_ := substr(b040_,4,2);
      elsif substr(b040_,9,1)='1' then
         obl_ := substr(b040_,10,2);
      elsif substr(b040_,9,1)='2' then
         obl_ := substr(b040_,15,2);
      else
         b040_ := null;
      end if;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      obl_ := null;
   END;

   IF typ_ = 0 then   --sheme_='C' then
      obl_ := nbuc1_;
   END IF;

    return obl_;
end;
-----------------------------------------------------------------------------
BEGIN
   logger.info ('P_FD2_NN: Begin ');
-------------------------------------------------------------------
   userid_ := user_id;
   EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
   -- ��������� ������������ �����
   p_proc_set(kodf_,sheme_,nbuc1_,typ_);

   -- ������ �������������� KL_R020 ����� ������������ KOD_R020
   sql_acc_ := 'select distinct r020 from kl_f3_29 where kf=''D2'' and trim(ddd) = ''10'' ';

   ret_ := f_pop_otcn(Dat_, 2, sql_acc_);

   nbuc2_ := nbuc1_;

   IF nbuc2_ IS NULL THEN
      nbuc2_:='0';
   END IF;

-- ��� �������� �����-���� ���
   update specparam set r014='1'
   where (trim(r014) is null or r014='0') and
         acc in (select a.acc
                 from accounts a
                 where a.nbs in (select distinct r020
                                 from kl_f3_29
                                 where kf='D2') and
                 (nls,kv) in (select s.nls, s.kv
                              from conts s
                              where s.nls is not null));

   insert into specparam (acc,R014)
   select a.acc, '1'
   from accounts a
   where a.nbs in (select distinct r020
                   from kl_f3_29
                   where kf='D2') and
         a.acc not in (select s.acc from specparam s) and
         (a.nls,a.kv) in (select nls,kv from conts where nls is not null);

-- ��� �������� �����-���� NOK,���
   update specparam set r014='1'
   where (trim(r014) is null or r014='0') and
         acc in (select a.acc
                 from accounts a
                 where a.nbs in (select distinct r020
                                 from kl_f3_29
                                 where kf='D2')) and
         acc in (select c.acc from ACCE c where c.acc is not null);

   insert into specparam (acc,R014)
   select a.acc, '1'
   from ACCE a
   where a.acc in (select acc
                   from accounts
                   where nbs in (select distinct r020
                                 from kl_f3_29
                                 where kf='D2')) and
         a.acc not in (select s.acc from specparam s) and
         a.acc is not null;

for k in (select c.rnk RNK, a.acc ACC, a.nls NLS, a.kv KV, a.nbs NBS, a.tobo TOBO, a.nms NMS,
                 DECODE(a.kv,980,'1','2') TKV, a.isp, a.daos Dat, c.codcagent CODC,
                 decode(c.custtype,1,'4',2,'1',decode(trim(c.sed),'91','2','3')) TK,
                 NVL(trim(c.ise),'00000') ISE, NVL(substr(trim(c.sed),1,2),'00') SED,
                 NVL(c.ved,'00000') VED, NVL(c.fs,'00') FS,
                 NVL(2-MOD(c.codcagent,2),1) REZ,
                 'XXXXX' TAG, '0' VALUE, trim(c.okpo) OKPO,
                 NVL(sp.r011,'0') R011, NVL(sp.r013,'9') R013, NVL(sp.r014,'0') R014
          from  accounts a, customer c, specparam sp,
                (select distinct r020 from kl_f3_29 where kf='D2') k
          where a.nbs = k.r020
            and a.nls NOT LIKE '86_5%'   --(8605,8625)
            and a.daos <= Dat_
            and (a.dazs is null or a.dazs > Dat_)
            and a.rnk = c.rnk
            and (c.date_off is null or c.date_off > Dat_)
--            and c.rnk not in (select rnk from kf77 where rnk is not null)
            and not exists (select 1 from customerw w
                            where w.rnk = c.rnk
                              and w.tag in ('K013'))
            and a.acc = sp.acc(+)
          union all
          select c.rnk RNK, a.acc ACC, a.nls NLS, a.kv KV, a.nbs NBS, a.tobo TOBO, a.nms NMS,
                 DECODE(a.kv,980,'1','2') TKV, a.isp, a.daos Dat, c.codcagent CODC,
                 decode(c.custtype,1,'4',2,'1',decode(trim(c.sed),'91','2','3')) TK,
                 NVL(trim(c.ise),'00000') ISE, NVL(c.sed,'00') SED,
                 NVL(c.ved,'00000') VED, NVL(c.fs,'00') FS,
                 NVL(2-MOD(c.codcagent,2),1) REZ,
                 d.tag TAG, NVL(substr(trim(d.value),1,1),'0') VALUE, trim(c.okpo) OKPO,
                 NVL(sp.r011,'0') R011, NVL(sp.r013,'9') R013, NVL(sp.r014,'0') R014
          from  accounts a, customer c, customerw d, specparam sp,
                (select distinct r020 from kl_f3_29 where kf='D2') k
          where a.nbs = k.r020
            and a.nls NOT LIKE '86_5%' --(8605,8625)
            and a.daos <= Dat_
            and (a.dazs is null or a.dazs > Dat_)
            and a.rnk = c.rnk
            and (c.date_off is null or c.date_off > Dat_)
--            and c.rnk not in (select rnk from kf77 where rnk is not null)
            and c.rnk = d.rnk
            and d.tag = 'K013'
            and a.acc = sp.acc(+)
         )

    loop

          comm_ := '';
          k013_:='3';
          dd1_ := '00';
          r011_ := k.r011;
          r013_ := k.r013;
          r014_ := k.r014;

          if k.tk in ('1','2') then
             k013_:='3';
          end if;

          if k.tk='3' then
             k013_:='5';
          end if;

          if k.tk in ('1','2') and k.fs in ('30','31') and
             k.ise in ('11001','13110','13120','13130','13131','13132') then
             k013_:='1';
          end if;

          if k.tk in ('1','2') and k.ise in ('12201','12202','12203',
             '12301','12302','12303','12401','12402','12502','12503') then
             k013_:='2';
          end if;

          -- ����������� - ������� �������� �� ��������
          if k.tk in ('2','3') and k.ise = '14101' and trim(k.sed)='91'
          then
             k013_:='6';
          end if;
          -- ��������� ������ ���������� - ������� �������� �� ��������
          if k.tk='3' and k.ise = '14201' and trim(k.sed)<>'91'
          then
             k013_:='4';
          end if;
          -- ���� ������ �����
          if k.tk='3' and k.ise not in ('14101','14201') and trim(k.sed)<>'91'
          then
             k013_:='5';
          end if;

          -- �� 10.07.2012 ���� ������ ��� 300120 ������� ��� ����
          if f_ourmfo() <> 300205 and trim(k.tag)='K013' and trim(k.value) is not null and    --f_ourmfo() = 300120 and
             substr(trim(k.value),1,1) in ('1','2','3','4','5','6')
          then
             k013_:=substr(trim(k.value),1,1);
          end if;

          if f_ourmfo() = 353575 and k.nbs in ('8021','8022','8023') then
             k013_:='5';
             comm_ := comm_||' �/� = '||k.nbs||' ��� = '||k013_;
             nbs1_ := '0000';

             --- ��������� ������� ������������������ ����� 2605 ��� 8021,8022,8023
             BEGIN
                sql_ := 'SELECT substr(bal_nls,1,4)
                         FROM NSMEP_SPARAMS
                         WHERE acc = :acc_ ';
                EXECUTE IMMEDIATE sql_ INTO nbs1_ USING k.acc;
             EXCEPTION WHEN NO_DATA_FOUND THEN
                nbs1_ := '0000';
             END;
             if nbs1_ like '260%' then
                -- ��� �������� ����� ������ ����� �� ��������
                k013_:='3';
                comm_ := comm_ || ' ����� ��� = '||k013_;
                dd1_ := '99';
             else
                comm_ := comm_ || ' ����. ���. �� ��. 260 ';
             end if;
          end if;

          if f_ourmfo() <> 353575 then
             comm_ := comm_ || ' ' || k.tobo || '  ' || k.nms;
          end if;

          if f_ourmfo() = 353575 and k.nbs='8620' then
             k013_:='5';
          end if;

          if k.nbs in ('2512','2531','2541','2542','2544','2545','2560','2561',
             '2562','2565') and k013_<>'1' then
             k013_:='1';
          end if;

          if k.nbs in ('2513','2520','2523','2525','2530','2546','2553','2555',
                       '2570','2571','2572') and k013_<>'1' then
             k013_:='1';
          end if;

          if k.nbs in ('2650','2651','2652','2655') and k013_<>'2' then
             k013_:='2';
          end if;

          if k.nbs in ('2600','2603','2604','2605','2606','2610','2615') and trim(k.sed)='91' and k013_<>'6'
          then
             k013_:='6';
          end if;

          if k.nbs in ('2600','2605','2606','2610','2615') and trim(k.sed)<>'91' and k013_<>'3'
          then
             k013_:='3';
          end if;

          if k.nbs in ('2620','2625','2630','2635') and k013_ not in ('4','5','6') then

             -- ����������� - ������� �������� �� ��������
             if k.tk in ('2','3') and k.ise = '14101' and trim(k.sed)='91'
             then
                k013_:='6';
             end if;
             -- ��������� ������ ���������� - ������� �������� �� ��������
             if k.tk='3' and k.ise = '14201' and trim(k.sed)<>'91'
             then
                k013_:='4';
             end if;
             -- ���� ������ �����
             if k.tk='3' and k.ise not in ('14101','14201') and trim(k.sed)<>'91'
             then
                k013_:='5';
             end if;

          end if;

          if substr(k.nbs,1,3) in ('260','261') and k013_ in ('3','4','5') then
             if trim(k.sed)='91' then
                k013_:='6';
             end if;
          end if;

          -- �� 10.07.2012 ���� ������ ��� 300120 ������� ��� ����
          -- 27.01.2014 ������� ������� ������� "and substr(trim(k.value),1,1)<>k013_"
          --if f_ourmfo() <> 300205 and trim(k.tag)='K013'
          --   and trim(k.value) is not null     --f_ourmfo() = 300120 and
          --   and substr(trim(k.value),1,1) in ('1','2','3','4','5','6')
          --   and substr(trim(k.value),1,1) <> k013_
          --then
          --   k013_:=substr(trim(k.value),1,1);
          --end if;

          if k.nbs = '2903' and LENGTH(k.okpo) > 8
                            and trim(k.okpo)<>'000000000'
                            and (k.sed = '91' or ( lower(k.nms) like '%���%' or
                                                   lower(k.nms) like '%��%'  or
                                                   lower(k.nms) like '%���%' or
                                                   lower(k.nms) like '%�_��%'
                                                 )
                                )
          then
             k013_:='6';
          end if;

          if k.nbs = '2903' and LENGTH(k.okpo) > 8
                            and trim(k.okpo)<>'000000000'
                            and k.sed <> '91'
                            and lower(k.nms) not like '%���%'
                            and lower(k.nms) not like '%��%'
                            and lower(k.nms) not like '%���%'
                            and lower(k.nms) not like '%�_��%'
          then
             k013_:='5';
          end if;

          if k.nbs = '2625' and k013_ = '6'
          then
             k013_:='5';
          end if;

          if k.nbs in ('2620','2630','2635') and k013_ in ('3','6')
          then
             k013_:='5';
          end if;

          --BEGIN
          --   select nvl(trim(r014),'0') into r014_
          --   from specparam
          --   where acc=k.acc;
          --EXCEPTION WHEN NO_DATA_FOUND THEN
          --   r014_:='0';
          --END;

          BEGIN
             SELECT NVL(trim(ddd),'00') INTO dd_
             FROM kl_f3_29
             WHERE kf='D2'
               and r020=k.nbs
               and r012=k013_
               and trim(ddd)<>'12'
               and rownum=1;
          EXCEPTION WHEN NO_DATA_FOUND THEN
             BEGIN
                SELECT distinct trim(ddd) INTO dd_
                FROM kl_f3_29
                WHERE kf='D2'
                  and r020=k.nbs
                  and trim(ddd)<>'12'
                  and rownum=1;
--                k013_:='0';
             EXCEPTION WHEN NO_DATA_FOUND THEN
                dd_:='00';
--                k013_:='0';
             END ;
          END ;

--- 22.05.2006 �����
--          if dd_ in ('06','08') and k.fs in ('30','31') and k013_<>'1' then
--             k013_:='1';
--          end if;

--          if dd_ in ('06','08') and k.fs in ('30','31') and
--             substr(k.nbs,1,2)<>'25' then
--             k013_:='3';
--          end if;

--          if dd_='08' and (k.nbs='2600' or (substr(k.nbs,1,2)='25' and
--                           k.fs not in ('30','31'))) and k013_<>'3' then
--             k013_:='3';
--          end if;
-------------------------------------------------------------------------------

          IF typ_ > 0 THEN   --sheme_  in ('C','G','D') AND
             nbuc_ := NVL(F_Codobl_Tobo(k.acc,typ_),nbuc1_);
          ELSE
             nbuc_ := NVL(nbuc1_,'0');
          END IF;

          IF nbuc_ IS NULL THEN
             nbuc_:='0';
          END IF;

          if k.nbs in ('2600','2620','2650') then
             --BEGIN
             --   select nvl(r013,'9') into r013_
             --   from specparam
             --   where acc=k.acc;
             --EXCEPTION WHEN NO_DATA_FOUND THEN
             --   r013_:='9';
             --END;
             if k.nbs='2650' and r011_ ='3' then
                dd_:='09';
             end if;
             if k.nbs='2650' and r011_ ='1' then
                dd_:='15';
             end if;
             if k.nbs='2600' and r011_ ='3' then
                dd_:='09';
             end if;
             if k.nbs='2600' and r011_ ='1' then
                dd_:='15';
             end if;
             if k.nbs='2620' and r011_ ='3' then
                dd_:='09';
             end if;
             if k.nbs='2620' and r011_ in ('1','2') and r014_ ='6' then
                dd_:='06';
             end if;
          end if;

          if k.nbs ='2903'  then
             dd_ :='10';
          end if;
          c_ := k.tkv;

          if dd_ not in ('05','10') and dd1_ != '99' then

             if dd_ = '15' and ((k.nbs='2650' and r014_ not in ('7')) or
                                (k.nbs='2600' and r014_ not in ('4','6')) or
                                (k.nbs in ('2620','8620') and r014_ not in ('4','6','7')) or
                                --(k.nbs in ('8021','8022','8023') and r014_ not in ('4','6','7')) or
                                (k.nbs not in ('2600','2605','2620','2625','2650','2655','8021','8022','8023','8620') and
                                  r014_ in ('0','1','2','3','5','8','9','A')) )
             then
                dd_ := '16';
             end if;

             -- ������� ����i���� ������ �i���� DD='15'
             if dd_ = '15' and r014_ not in ('4','6','7') and k.nbs not in ('2605','2625','2655','8021','8022','8023')
             then
                dd_ := '00';
             end if;

             if Dat_ < to_date('01122008','ddmmyyyy') then
                insert into bars.rnbu_trace
                 (nls, kv, odate, kodp, znap, nbuc, isp, rnk, comm, acc) VALUES
                 (k.nls, k.kv, k.dat, '3'||dd_||k013_||'0', '1', nbuc_, k.isp, k.rnk, comm_, k.acc);
             else
                if dd_ in ('06','07','09','15','16') then  --dd_ in ('04','06','07','08','09') then

                   kodp_ := '3'||dd_||k013_||c_;

                   if k.nbs in ('2651','2652') then
                      --if dat_ < to_date('31122010','ddmmyyyy') then
                      --   kodp_ := '3'||dd_||'6'||c_;
                      --else
                      --   kodp_ := '3'||'13'||k013_||c_;
                      --end if;
                      null;
                   elsif k.nbs in ('2610','2615') then
                      --if dat_ < to_date('31122010','ddmmyyyy') then
                      --   kodp_ := '3'||dd_||'6'||to_char(to_number(c_)+2);
                      --else
                      --   kodp_ := '3'||'13'||k013_||c_;
                      --end if;
                      null;
                   elsif k.nbs in ('2630','2635') and k013_='4' then
                      --if dat_ < to_date('31122010','ddmmyyyy') then
                      --   kodp_ := '3'||dd_||'6'||to_char(to_number(c_)+4);
                      --else
                      --   kodp_ := '3'||'13'||k013_||c_;
                      --end if;
                      null;
                   elsif k.nbs in ('2630','2635') and k013_='5' then
                      --if dat_ < to_date('31122010','ddmmyyyy') then
                      --   kodp_ := '3'||dd_||'6'||to_char(to_number(c_)+6);
                      --else
                      --   kodp_ := '3'||'13'||k013_||c_;
                      --end if;
                      null;
                   else
                      null;
                   end if;

                   if (dd_ = '07' and Dat_<= to_date('30112012','ddmmyyyy')) or dd_ <> '07' then
                      insert into bars.rnbu_trace
                       (nls, kv, odate, kodp, znap, nbuc, isp, rnk, comm, acc) VALUES
                       (k.nls, k.kv, k.dat, kodp_, '1', nbuc_, k.isp, k.rnk, comm_, k.acc);
                   end if;

                   if dat_ >= to_date('31122010','ddmmyyyy') then
                      if (Dat_ < to_date('29122012','ddmmyyyy') and k.nbs in ('2600','2610','2615','2620','2630','2635')
                          and k013_ in ('4','5','6') and r014_ in ('2','4','5','7') ) or
                         (Dat_ >= to_date('29122012','ddmmyyyy') and k.nbs in ('2600','2610','2615','2620','2630','2635')
                          and k013_ in ('5') and r014_ in ('2','4','5','7') )
                      then
                         kodp_ := '3'||'14'||k013_||'0';
                         insert into bars.rnbu_trace
                          (nls, kv, odate, kodp, znap, nbuc, isp, rnk, comm, acc) VALUES
                          (k.nls, k.kv, k.dat, kodp_, '1', nbuc_, k.isp, k.rnk, comm_, k.acc);
                      end if;
                   end if;
                end if;
                if dd_ not in ('06','07','09','15','16') then
                   insert into bars.rnbu_trace
                    (nls, kv, odate, kodp, znap, nbuc, isp, rnk, comm, acc) VALUES
                    (k.nls, k.kv, k.dat, '3'||dd_||k013_||c_, '1', nbuc_, k.isp, k.rnk, comm_, k.acc);
                end if;
             end if;
          end if;

          if dd_='05' then
             --BEGIN
             --   select nvl(r013,'0') into r013_
             --   from specparam
             --   where acc=k.acc;
             --EXCEPTION WHEN NO_DATA_FOUND THEN
             --   r013_:='0';
             --END;

             if r013_='2' then
                --k013_:='3';
                if Dat_ < to_date('01122008','ddmmyyyy') then
                   insert into bars.rnbu_trace
                    (nls, kv, odate, kodp, znap, nbuc, isp, rnk, comm, acc) VALUES
                    (k.nls, k.kv, k.dat, '3'||dd_||k013_||'0', '1', nbuc_, k.isp, k.rnk, comm_, k.acc);
                else
                   if Dat_ < to_date('29122012','ddmmyyyy') or (Dat_ >= to_date('29122012','ddmmyyyy') and k013_ <> '1')
                   then
                      insert into bars.rnbu_trace
                       (nls, kv, odate, kodp, znap, nbuc, isp, rnk, comm, acc) VALUES
                       (k.nls, k.kv, k.dat, '3'||dd_||k013_||c_, '1', nbuc_, k.isp, k.rnk, comm_, k.acc);
                   end if;
                end if;
             end if;
          end if;

          if dd_='10' then

             n_dat1_ := f_snap_dati(Dat_,2);

             --BEGIN
             --   select nvl(r013,'0') into r013_
             --   from specparam
             --   where acc=k.acc;
             --EXCEPTION WHEN NO_DATA_FOUND THEN
             --   r013_:='0';
             --END;

--             if r013_ in ('0','1','9') then
                --insert into bars.rnbu_trace
                -- (nls, kv, odate, kodp, znap, nbuc, isp, rnk, comm, acc) VALUES
                -- (k.nls, k.kv, k.dat, '3'||dd_||k013_||'0', '1', nbuc_, k.isp, k.rnk, comm_, k.acc);

                BEGIN
                   select decode(kv,980,Ost - Dos96 + Kos96,
                                        Ostq - Dosq96 + Kosq96)
                      into ost_
                   from otcn_saldo
                   where acc=k.acc;
                EXCEPTION WHEN NO_DATA_FOUND THEN
                   ost_:=0;
                END;

                if ost_<>0 then
                   --������ ��������� ���� 16.07.2012 ���
                   -- ���������� ���-�� ��� ������������� ������ ����������� ��� ��������� ������� �� �����
--                   if Dat_ < to_date('29122012','ddmmyyyy') or (Dat_ >= to_date('29122012','ddmmyyyy') and k013_ <> '1')
--                   then
                      insert into bars.rnbu_trace
                      (nls, kv, odate, kodp, znap, nbuc, isp, rnk, comm, acc) VALUES
                      (k.nls, k.kv, k.dat, '3'||dd_||k013_||'0', '1', nbuc_, k.isp, k.rnk, comm_, k.acc);

                      insert into bars.rnbu_trace
                      (nls, kv, odate, kodp, znap, nbuc, isp, rnk, comm, acc) VALUES
                      (k.nls, k.kv, dat_, '1'||'11'||k013_||'0',
                                      to_char(ABS(ost_)), nbuc_, k.isp, k.rnk, comm_, k.acc);
--                   end if;
                end if;
--             end if;
          end if;

          BEGIN
             SELECT distinct trim(ddd) INTO dd_
             FROM kl_f3_29
             WHERE kf='D2' and r020=k.nbs and trim(ddd)='12';
          EXCEPTION WHEN NO_DATA_FOUND THEN
             dd_:='00';
          END ;

          IF dd_ = '12' and ((k.nbs not in ('2605','2620','2625','2655') and r014_ in ('1','2','3')) or
                              (k.nbs in ('2620','8620') and r014_ in ('1','2','3')) or
                              (k.nbs in ('2605','2625','2655') and r014_ in ('1')) or
                              (k.nbs in ('8021','8022','8023') and r014_ in ('1','2','3')) ) THEN

             --BEGIN
             --   select nvl(r013,'0') into r013_
             --   from specparam
             --   where acc=k.acc;
             --EXCEPTION WHEN NO_DATA_FOUND THEN
             --   r013_:='0';
             --END;

             if (k.nbs='2603' and r013_='2') or k.nbs <> '2603' then
                insert into bars.rnbu_trace
                (nls, kv, odate, kodp, znap, nbuc, isp, rnk, comm, acc) VALUES
                (k.nls, k.kv, k.dat, '3'||dd_||k013_||'0', '1', nbuc_, k.isp, k.rnk, comm_, k.acc);
             end if;
          END IF;

          -- ��������� ��� ������? 09 ����
          /*
          IF dd_ = '12' and r014_ in ('4','5','7') then
             BEGIN
                select nvl(r013,'0') into r013_
                from specparam
                where acc=k.acc;
             EXCEPTION WHEN NO_DATA_FOUND THEN
                r013_:='0';
             END;

             if k.nbs in ('2610','2615') or (k.nbs='2600' and r013_='7')
             THEN
                dd_ := '14';
                insert into bars.rnbu_trace
                (nls, kv, odate, kodp, znap, nbuc, isp, rnk, comm, acc) VALUES
                (k.nls, k.kv, k.dat, '3'||dd_||k013_||'0', '1', nbuc_, k.isp, k.rnk, comm_, k.acc);
             end if;
             if k.nbs in ('2630','2635') or (k.nbs='2620' and r013_='1')
             THEN
                dd_ := '14';
                insert into bars.rnbu_trace
                (nls, kv, odate, kodp, znap, nbuc, isp, rnk, comm, acc) VALUES
                (k.nls, k.kv, k.dat, '3'||dd_||k013_||'0', '1', nbuc_, k.isp, k.rnk, comm_, k.acc);
             end if;

          END IF;
          */
end loop;

if f_ourmfo() = 322669 then
   BEGIN
      sql_ := 'delete from rnbu_trace
               where substr(nls,1,4) in (''2620'',''2630'',''2635'')
                and (nls,kv) in (select a.nls, a.kv
                                 from accounts a
                                 where ((a.nbs in (''2630'',''2635'') AND a.tip=''ODB'') OR
                                        (a.nbs=''2620'' and a.ob22 in (''05'',''08'',''09'',''11'',''12'',
                                                                       ''17'',''20'',''21'',''22'',''29'')
                                                        and a.tip=''ODB''))
                                )';
      EXECUTE IMMEDIATE sql_ ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      null;
   END;


end if;

-- ����� ��������� ��� ������� ��������� �����
nbuc_:=nbuc2_;

-- ��������� ���������� DBF �����
for k in (select decode(c.rnk,NULL,c.N_PP,c.RNK) RNK, trim(c.nls) NLS, c.kv KV,
                 c.z_date Dat, NVL(c.k013,'0') K013, NVL(trim(c.ID_KOD),'99') OKPO,
                 NVL(c.NUMDOC,'99') ND
          from  tmp_filed2 c
          where c.z_date=Dat_
            and c.k013 is not null
            and c.rnk is not null
            and c.nls is not null
            and substr(trim(c.nls),1,4) in
               (select distinct r020 from kl_f3_29 where kf='D2') )

     loop

          BEGIN
             select NVL(acc,0) into acc_
             from accounts
             where nls=k.nls and kv=k.kv;
          EXCEPTION WHEN NO_DATA_FOUND THEN
             acc_:=0;
          END;

          IF typ_ > 0 THEN   -- sheme_  in ('C','G','D') AND
             nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
          ELSE
             nbuc_ := NVL(nbuc1_,'0');
          END IF;

          IF nbuc_ IS NULL THEN
             nbuc_:='0';
          END IF;

          if k.okpo is null or k.okpo in ('000000000','0000000000',
                        '99999','9999999999','999999999','99') then

             BEGIN
                select c.rnk, decode(c.custtype,1,'4',2,'1',
                              decode(trim(c.sed),'91','2','3')),
                       NVL(trim(c.ise),'00000'), NVL(substr(trim(c.sed),1,2),'00'),
                       NVL(c.ved,'00000'), NVL(c.fs,'00'),
                       NVL(substr(trim(w.value),1,1),'0')
                INTO rnk_, tk_, ise_, sed_, ved_, fs_, k013_
                from customer c, customerw w
                where c.rnk in (select max(rnk) from person
                                where trim(numdoc)=trim(k.ND)
                                group by numdoc)
--                  and trim(c.adm) is not null
                  and c.rnk=w.rnk(+)
                  and w.tag(+)='K013';

                if k013_='0' and tk_ in ('1','2') and fs_ in ('30','31') and
                   ise_ in ('11001','13110','13120','13130','13131','13132') then
                   k013_:='1';
                end if;

                if k013_='0' and tk_ in ('1','2') and ise_ in ('12201','12202',
                    '12203','12301','12302','12303','12401','12402','12502','12503') then
                   k013_:='2';
                end if;

                if k013_='0' and tk_='2' and
                   ved_ in ('74111','74112') and trim(sed_)='91' and fs_='10' then
                   k013_:='4';
                end if;

                if k013_='0' and tk_='3' and ved_ in ('74111','74112') and
                   fs_='10' then
                   k013_:='4';
                end if;

                if k013_='0' and tk_='3' and ved_ not in ('74111','74112') and
                   trim(sed_)<>'91' and fs_='10' then
                   k013_:='5';
                end if;

                if k013_='0' and k.k013='0' and tk_ in ('1','2') then
                   k013_:='3';
                end if;

                if k013_='0' and k.k013<>'0' and tk_ in ('1','2') then
                   k013_:=k.k013;
                end if;

                if k013_='0' and k.k013='0' and tk_='3' then
                   k013_:='5';
                end if;

                if k013_='0' and k.k013<>'0' and tk_='3' then
                   k013_:=k.k013;
                end if;

             EXCEPTION WHEN NO_DATA_FOUND THEN
                k013_:=k.k013;
                rnk_:=to_number(k.nls);
             END;

             BEGIN
                SELECT NVL(trim(ddd),'00') INTO dd_
                FROM kl_f3_29
                WHERE kf='D2' and r020=substr(k.nls,1,4) and
                      r012=k013_ and trim(ddd)<>'12';
             EXCEPTION WHEN NO_DATA_FOUND THEN
                BEGIN
                   SELECT distinct trim(ddd) INTO dd_
                   FROM kl_f3_29
                   WHERE kf='D2' and r020=substr(k.nls,1,4) and
                         trim(ddd)<>'12';
                EXCEPTION WHEN NO_DATA_FOUND THEN
                   dd_:='00';
                END ;
             END ;

             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, isp, rnk)
             VALUES
             (k.nls, k.kv, k.dat, '3'||dd_||k013_||'0', '1', nbuc_, 0, rnk_);

          end if;

          if k.okpo is not null and k.okpo not in ('000000000','0000000000',
                        '99999','9999999999','999999999','99') then

             BEGIN
                select max(rnk) into rnk_
                from customer
                where trim(okpo)=trim(k.okpo)
                group by okpo;

                select decode(c.custtype,1,'4',2,'1',
                              decode(trim(c.sed),'91','2','3')),
                       NVL(trim(c.ise),'00000'), NVL(substr(trim(c.sed),1,2),'00'),
                       NVL(c.ved,'00000'), NVL(c.fs,'00'),
                       NVL(substr(trim(w.value),1,1),'0')
                INTO tk_, ise_, sed_, ved_, fs_, k013_
                from customer c, customerw w
                where c.rnk=rnk_
--                  and trim(c.adm) is not null
                  and c.rnk=w.rnk(+)
                  and w.tag(+)='K013';

                if k013_='0' and tk_ in ('1','2') and fs_ in ('30','31') and
                   ise_ in ('11001','13110','13120','13130','13131','13132') then
                   k013_:='1';
                end if;

                if k013_='0' and tk_ in ('1','2') and ise_ in ('12201','12202',
                    '12203','12301','12302','12303','12401','12402','12502','12503') then
                   k013_:='2';
                end if;

                if k013_='0' and tk_='2' and
                   ved_ in ('74111','74112') and trim(sed_)='91' and fs_='10' then
                   k013_:='4';
                end if;

                if k013_='0' and tk_='3' and ved_ in ('74111','74112') and
                   fs_='10' then
                   k013_:='4';
                end if;

                if k013_='0' and tk_='3' and ved_ not in ('74111','74112') and
                   trim(sed_)<>'91' and fs_='10' then
                   k013_:='5';
                end if;

                if k013_='0' and k.k013='0' and tk_ in ('1','2') then
                   k013_:='3';
                end if;

                if k013_='0' and k.k013<>'0' and tk_ in ('1','2') then
                   k013_:=k.k013;
                end if;

                if k013_='0' and k.k013='0' and tk_='3' then
                   k013_:='5';
                end if;

                if k013_='0' and k.k013<>'0' and tk_='3' then
                   k013_:=k.k013;
                end if;

             EXCEPTION WHEN NO_DATA_FOUND THEN
                k013_:=k.k013;
                rnk_:=NVL(trim(k.okpo),0);
--                rnk_:=NVL(to_number(trim(k.okpo)),0);
             END;

             BEGIN
                SELECT NVL(trim(ddd),'00') INTO dd_
                FROM kl_f3_29
                WHERE kf='D2' and r020=substr(k.nls,1,4) and
                      r012=k013_ and trim(ddd)<>'12' ;
             EXCEPTION WHEN NO_DATA_FOUND THEN
                BEGIN
                   SELECT distinct trim(ddd) INTO dd_
                   FROM kl_f3_29
                   WHERE kf='D2' and r020=substr(k.nls,1,4) and
                         trim(ddd)<>'12';
                EXCEPTION WHEN NO_DATA_FOUND THEN
                   dd_:='00';
                END ;
             END ;
                insert into bars.rnbu_trace
                   (nls, kv, odate, kodp, znap, nbuc, isp, rnk) VALUES
                   (k.nls, k.kv, k.dat, '3'||dd_||k013_||'0', '1', nbuc_, 0, rnk_);

--             END;
          end if;

--     insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, isp, rnk)
--      VALUES
--           (k.nls, k.kv, k.dat, '3'||k.dd||k.tk||'0', '1', nbuc_, 0, k.rnk);
end loop;

rnk_:=0;
-- ��������� ���������� �� ���������� �������� ��� "301�0"
-- � ���-�� �������� �� ��������� �������� ������� ������ ����� 2903 (DD='10')
for k in (select t.acc ACC, t.nbuc TOBO, t.nls NLS, t.kv KV, t.rnk RNK,
                 substr(t.kodp,4,1) K013, substr(t.kodp,2,2) DD,
                 NVL(c.date_on, Dat_) data, substr(t.kodp,5,1) R034, trim(t.comm) COMM
          from  rnbu_trace t, customer c
          where substr(t.kodp,1,1)='3' and
                substr(t.kodp,2,2) not in ('10','11') and
                t.rnk=c.rnk(+) and userid=userid_
          --ORDER BY t.nbuc, t.rnk, substr(t.kodp,2,2), substr(t.kodp,4,1)
          ORDER BY t.rnk, substr(t.kodp,4,1), substr(t.kodp,2,2) )

     loop

--     kol_:=1;

--     if k.dd='10' then
--        select count(*) into kol_
--        from cust_acc
--        where rnk=k.rnk and
--              acc in (select acc
--                          from accounts
--                          where (dazs is null or dazs > Dat_) and
--                                nbs<>'2903');
--     end if;

     dd_ := k.dd;
     data_ := k.data;
     k013_n := k.k013;

     /*
     if substr(k.nls,1,4) in ('2651','2652') and k.k013='6' and
        k.r034 in ('1','2')
     then
        k013_n := '2';
     elsif substr(k.nls,1,4) in ('2610','2615') and k.k013='6' and
        k.r034 in ('3','4')
     then
        k013_n := '3';
     elsif substr(k.nls,1,4) in ('2630','2635') and k.k013='6' and
        k.r034 in ('5','6')
     then
        k013_n := '4';
     elsif substr(k.nls,1,4) in ('2630','2635') and k.k013='6' and
        k.r034 in ('7','8')
     then
        k013_n := '5';
     else
        null;
     end if;
     */

     if rnk_=0 then
        nbuc_:=k.tobo;
        acc_ :=k.acc;
        nls_:=k.nls;
        kv_:=k.kv;
        rnk_:=k.rnk;
        k013_:=k013_n;  --k.k013;
        comm_:=k.comm;
     end if;

     --if (rnk_<>0 and rnk_<>k.rnk) or (k013_<>'9' and k013_<>k013_n) then
     if ( ( mfo_ in (322669,324805) and
            (nbuc_<>k.tobo) or
            (rnk_<>0 and rnk_<>k.rnk) or
            (k013_<>'9' and k013_<>k013_n)
          ) OR
          ( mfo_ not in (322669,324805) and
            (rnk_<>0 and rnk_<>k.rnk) or
            (k013_<>'9' and k013_<>k013_n)
          )
        )
     then

        if mfo_ not in (322669,324805)
        then
           nbuc1_ := f_codobl_cust(rnk_);

           if nbuc1_ is not null then
              nbuc_ := nbuc1_;
           end if;
        end if;

--        if kol_ > 0 then
           insert into bars.rnbu_trace
                  (nls, kv, odate, kodp, znap, nbuc, isp, rnk, comm, acc) VALUES
                  (nls_, kv_, k.data, '301'||k013_||'0', '1', nbuc_, 0, rnk_, comm_, acc_);
--        end if;

        nbuc_:=k.tobo;
        acc_ :=k.acc;
        nls_:=k.nls;
        kv_:=k.kv;
        rnk_:=k.rnk;
        k013_:=k013_n;  --k.k013;
        comm_:=k.comm;
     end if;

end loop;

if dd_ not in ('10','11') then
   nbuc1_ := f_codobl_cust(rnk_);

   if nbuc1_ is not null then
      nbuc_ := nbuc1_;
   end if;

   insert into bars.rnbu_trace
       (nls, kv, odate, kodp, znap, nbuc, isp, rnk, comm, acc) VALUES
       (nls_, kv_, data_, '301'||k013_||'0', '1', nbuc_, 0, rnk_, comm_, acc_);
end if;

rnk_:=0;
-- ��������� ����� ���������� �� ���������� �������� ��� "302�0"
-- ������� ���������� ������� �������������� ������������
for k in (select t.acc ACC, t.nbuc TOBO, t.nls NLS, t.kv KV, t.rnk RNK,
                 substr(t.kodp,4,1) K013, substr(t.kodp,2,2) DD,
                 NVL(c.date_on, Dat_) data, trim(t.comm) COMM
          from  rnbu_trace t, customer c
          where substr(t.kodp,2,2)='12' and
                t.rnk=c.rnk(+) and userid=userid_
          --ORDER BY t.nbuc, t.rnk, substr(t.kodp,4,1)
          ORDER BY t.rnk, substr(t.kodp,4,1) )

     loop

     dd_ := k.dd;
     data_ := k.data;

     if rnk_=0 then
        nbuc_:=k.tobo;
        acc_ :=k.acc;
        nls_:=k.nls;
        kv_:=k.kv;
        rnk_:=k.rnk;
        k013_:=k.k013;
        comm_:=k.comm;
     end if;

     --if (rnk_<>0 and rnk_<>k.rnk) or (k013_<>'9' and k013_<>k.k013) then
     if ( ( mfo_ in (322669,324805) and
            (nbuc_<>k.tobo) or
            (rnk_<>0 and rnk_<>k.rnk) or
            (k013_<>'9' and k013_<>k.k013)
          ) OR
          ( mfo_ not in (322669,324805) and
            (rnk_<>0 and rnk_<>k.rnk) or
            (k013_<>'9' and k013_<>k.k013)
          )
        )
     then

        if mfo_ not in (322669, 324805)
        then
           nbuc1_ := f_codobl_cust(rnk_);

           if nbuc1_ is not null then
              nbuc_ := nbuc1_;
           end if;
        end if;

        insert into bars.rnbu_trace
               (nls, kv, odate, kodp, znap, nbuc, isp, rnk, comm, acc) VALUES
               (nls_, kv_, k.data, '302'||k013_||'0', '1', nbuc_, 0, rnk_, comm_, acc_);

        nbuc_:=k.tobo;
        acc_ := k.acc;
        nls_:=k.nls;
        kv_:=k.kv;
        rnk_:=k.rnk;
        k013_:=k.k013;
        comm_:=k.comm;
     end if;

end loop;
if dd_ = '12' then
   nbuc1_ := f_codobl_cust(rnk_);

   if nbuc1_ is not null then
      nbuc_ := nbuc1_;
   end if;

   insert into bars.rnbu_trace
       (nls, kv, odate, kodp, znap, nbuc, isp, rnk, comm, acc) VALUES
       (nls_, kv_, data_, '302'||k013_||'0', '1', nbuc_, 0, rnk_, comm_, acc_);
end if;
---------------------------------------------------
DELETE FROM tmp_nbu where kodf=kodf_ and datf= dat_;
---------------------------------------------------
INSERT INTO tmp_nbu (kodp, datf, kodf, nbuc, znap)
   SELECT kodp, Dat_, kodf_, nbuc, SUM(to_number(znap))
   FROM rnbu_trace
   WHERE userid=userid_
   GROUP BY kodp, Dat_, kodf_, nbuc;
---------------------------------------------------
logger.info ('P_FD2_NN: END ');
----------------------------------------
END p_fd2_NN;
/
show err;

PROMPT *** Create  grants  P_FD2_NN ***
grant EXECUTE                                                                on P_FD2_NN        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FD2_NN        to RPBN002;
grant EXECUTE                                                                on P_FD2_NN        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FD2_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
