

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F08_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F08_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_F08_NN (Dat_ DATE,
                                      sheme_ varchar2 default 'G')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : ��������� ������������ ����� #08 ��� ��
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 16/10/2017 (12/05/2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
���������: Dat_ - �������� ����
           sheme_ - ����� ������������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
07.06.2016 ��� ����� ���.������ 602,604,605 � �� �������� � ��������������
           �� ������� �������� ��������� ���������� �� ������ ����
03.06.2016 ��� �������� ������� �� R013 �� ������������ ��� ���.�����
           ����������.
04.04.2016 ������ �������� '00' ��� S130 ����� ������������� �������� '90'
           ������� ������� � �������������� KL_S130
30.03.2016 �� 01.04.2016 ����� ������������� ����� ����� ����������
           "��� ���� ������ ������" (�������� S130 2-� ������� ���)
20.01.2016 ��������� �������� ���������� �������������� �� �������
           ����� �������� �� ����� DRAPS�
03.07.2015 ��� ��� ������� ������������ ���� 704
19.06.2015 ��� KL_K070 ��������� ������� "D_CLOSE is null"
09.06.2015 ��������� ��� ����� ���.������ 602, 605, 609, 702, 707, 709
20.05.2015 ������� ��� ��������� ������� ���� ��������� ������ ��� ���
10.03.2015 �� �������� �������������� �������� ������� ��������������
           �������� ����������� � ��������� �� �������� ������
25.02.2015 ��� ������������ �������� K072 ����� ����� '0'
           (��������� ���������� ��� �� ���������������� �����)
19.01.2015 ��� mfou_ <> 300465 � ��������� ������ 12 �������� �������
           f_pop_otcn(Dat_, 4, sql_acc_, null, 1)
19.12.2013 � ����. OTCN_F08_HISTORY ��������� ���� VOB ��� ���������
           ������������ �����
09.12.2013 ������ VIEW PROVODKI ����� ������������ ����. OPLDOK � ����.
           ACCOUNTS (����� ����� ����������� ����. OTCN_F08_HISTORY)
20.06.2013 ��� ��������(���������������) �������� �� 6,7 ������� ��
           ���������� ��������� ����������� ����������������� ������
           2,3 �������. ����������. (��������� ��������� ��)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='08';
typ_ number;
acc_     number;
nbs_     varchar2(4);
nbs1_    varchar2(4);
nls_     varchar2(15);
nls1_    varchar2(15);
rnk_     Number;
isp_     Number;
data_    date;
dat1_    date;
dat2_    date;
datng_   date;
kv_      SMALLINT;
sk_      NUMBER;
Ostn_    DECIMAL(24);
Ostq_    DECIMAL(24);
Dos96_   DECIMAL(24);
Dosq96_  DECIMAL(24);
Kos96_   DECIMAL(24);
Kosq96_  DECIMAL(24);
Dos99_   DECIMAL(24);
Dosq99_  DECIMAL(24);
Kos99_   DECIMAL(24);
Kosq99_  DECIMAL(24);
Doszg_   DECIMAL(24);
Koszg_   DECIMAL(24);
se_      DECIMAL(24);
se1_     DECIMAL(24);
se_k_    DECIMAL(24);
mfo_     Number;
mfou_    Number;
dk_      char(1);
kodp_    varchar2(20);
znap_    varchar2(30);
r011_    varchar2(1);
r013_    varchar2(1);
s130_    Varchar2(2);
s180_    Varchar2(1);
s183_    Varchar2(1);
k072_    varchar2(1);
s_       char(1);
s1_      char(1);
s2_      char(1);
r_       char(1);
r1_      char(1);
userid_  number;
userid1_ number;
flag_    number;
nbuc1_   varchar2(12);
nbuc_    varchar2(12);
DatN_    date;
sql_acc_ varchar2(2000):='';
sql_doda_ varchar2(200):='';
sql_z      VARCHAR2 (2000):='';
ret_     number;
fa7p_    NUMBER;
nd_      NUMBER;
comm_    rnbu_trace.comm%type;
comm1_   rnbu_trace.comm%type;
freq_    NUMBER;
dos_     number;
dose_    number;
kol_     number;
pr_se_   number;
tobo_    accounts.tobo%TYPE;
nms_     accounts.nms%TYPE;
d_sum_   number;
k_sum_   number;

-- �� 30 ����
o_r013_1   VARCHAR2 (1);
o_se_1     DECIMAL (24);
o_comm_1   rnbu_trace.comm%TYPE;
-- ����� 30 ����
o_r013_2   VARCHAR2 (1);
o_se_2     DECIMAL (24);
o_comm_2   rnbu_trace.comm%TYPE;
tip_       accounts.tip%type;

CURSOR Saldo IS
   select a.*, n.nd, i.freq
   from (
     SELECT s.rnk, s.acc, s.nls, s.kv, s.fdat, s.nbs,
              NVL(cc.r011,'0') r011, NVL(cc.r013,'0') r013,
              NVL(trim(cc.k072),'X') k072,
              s.ost, s.ostq, s.dos96, s.kos96, s.dosq96, s.kosq96,
              s.dos99, s.kos99, s.dosq99, s.kosq99,
              s.doszg, s.koszg, a.isp, a.tobo, a.nms, a.tip, NVL(cc.s130,'90') S130
       FROM  otcn_saldo s, specparam cc, otcn_acc a
       WHERE (s.ost-s.dos96+s.kos96+s.doszg-s.koszg<>0 OR
              s.ostq-s.dosq96+s.kosq96<>0)
         and s.acc=a.acc
         and s.acc=cc.acc(+)) a
    left outer join (select n.acc, max(n.nd) nd
                      from nd_acc n, cc_deal e
                      WHERE e.sdate <= Dat_
                        AND e.nd = n.nd
                      group by n.acc ) n
    on (a.acc = n.acc)
    left outer join (SELECT n8.nd, max(i.freq) freq
                              FROM accounts a8, nd_acc n8, int_accn i
                             WHERE a8.nbs = '8999'
                               AND n8.acc = a8.acc
                               AND a8.acc = i.acc
                               AND i.ID = 0
                            group by n8.nd) i
    on (i.nd = n.nd)     ;
-----------------------------------------------------------------------------
--- ��������� ������������ ���������
procedure p_ins(p_dat_ date, p_tp_ varchar2, p_rnk_ number, p_nls_ varchar2,
                p_nbs_ varchar2, p_kv_ smallint, p_r011_ varchar2,
                p_r013_ varchar2, p_k072_ varchar2,
                p_s183_ varchar2, p_s130_ varchar2,
                p_znap_ varchar2, p_isp_ number, p_nbuc_ varchar2) IS

kod_ varchar2(14);

begin
   BEGIN
      SELECT NVL(trim(k.k072),'0'), to_char(2 - MOD(c.codcagent,2))
      INTO s_, r_
      FROM customer c, kl_k070 k
      WHERE c.rnk=p_rnk_ AND c.ise=k.k070(+) and k.d_close is null;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      s_:='0';
      r_:='1';
   END;

   if p_k072_ is not null and p_k072_<>'X' then
      s_:= p_k072_;
   end if;

   if substr(p_nbs_,1,1) in ('6','7') and 353575 in (mfo_, mfou_) then
      s_:='X';
   end if;

   if (substr(p_nbs_,1,3) in ('600','700') OR p_nbs_ in ('6054','6055')) and
       s_<>'4'
   then
      s_:= '4';
   end if;

   if substr(p_nbs_,1,3) in ('601','608','701','708') and r_='1' and
       s_ not in ('5','6','7')
   then
      s_:= '6';
   end if;

   if substr(p_nbs_,1,3) in ('601','608','701','708') and r_='2' and s_<>'0' then
      s_:= '0';
   end if;

   if p_nbs_ in ('6030','6032') and s_<>'H' then
      s_:='H';
   end if;

   if p_nbs_ in ('6031','6033') and s_<>'I' then
      s_:='I';
   end if;

   if substr(p_nbs_,1,3) in ('604','704') and r_='1' and s_<>'N' then
      s_:= 'N';
   end if;

   if substr(p_nbs_,1,3) in ('604','704') and r_='2' and s_<>'0' then
      s_:= '0';
   end if;

   if p_nbs_ in ('7030') and s_<>'I' then
      s_:='I';
   end if;

   if r_ = 2 then
      s_ := '0';
   end if;

   -- ������ ��� ����������
   if mfo_ <> 300120 and p_nbs_ in ('2902','2903','2909') and r_<>2 and p_r011_='1' and s_<>'2'
   then
      s_:='2';
   end if;

   if mfo_ <> 300120 and p_nbs_ in ('2902','2903','2909') and r_<>2 and p_r011_='2' and s_<>'N'
   then
      s_:='N';
   end if;

   Ostn_:= to_number(p_znap_);

   if substr(p_nbs_,1,3) in ('602','605','609') then
      for k in (select accd, nlsd, kv, decode(kv,980,sum(s*100),sum(sq*100)) s,
                       acck, nlsk
                from otcn_f08_history
                where fdat between Datng_ and Dat_
                  and nlsk=trim(p_nls_)
                group by accd, nlsd, kv, acck, nlsk
                union
                select accd, nlsd, kv, decode(kv,980,sum(s*100),sum(sq*100)) s,
                       acck, nlsk
                from otcn_f08_history
                where fdat between Dat_+1 and Dat_+29 and
                      vob=96 and
                      nlsk=trim(p_nls_)
                group by accd, nlsd, kv, acck, nlsk )
      loop

         if substr(k.nlsd,1,1) in ('1','2','3') then
            select NVL(p.k072,'0'), 2-mod(c.codcagent,2), nvl(trim(s.k072),'0'),
                   ca.tobo, ca.nms
              into s1_, r1_, s2_, tobo_, nms_
            from accounts ca, customer c, kl_k070 p, specparam s --cust_acc ca,
            where ca.acc=k.accd and
                  ca.rnk=c.rnk  and
                  ca.acc=s.acc(+) and
                  c.ise = p.k070(+) and
                  p.d_close is null ;
         else
            s1_:='X';
            r1_:='1';
            s2_:=s_ ;
         end if;

         if s2_ <> '0' then  -- s1_ = 'X' and s2_<>'0' then
            s1_ := s2_;
         end if;

         if p_tp_ = '1'
         then
            se_ := - k.s;
         else
            se_ := k.s;
         end if;

         if mfo_ = 324805
         then
            s1_ := '0';
            r1_ := '2';
         end if;

         kod_:= p_tp_ || p_nbs_ || p_r013_ || s1_ || r1_ || lpad(p_kv_,3,'0') || p_s183_ || p_s130_;

         if se_ <> 0 then
            if k.nlsd like '6%' then
               nls1_ := k.nlsk;
               comm1_ := comm_;
            else
               nls1_ := k.nlsd;
               comm1_ := '';
               comm1_ := substr(comm1_ || tobo_ || '  ' || nms_, 1, 200);
            end if;

            INSERT INTO rnbu_trace
                    (nls, kv, odate, kodp, znap, nbuc, rnk, isp, comm)
            VALUES  (nls1_, k.kv, dat_, kod_, to_char(se_), p_nbuc_, rnk_, isp_, comm1_);

            --Ostn_:= Ostn_ - (k.s - se_);
            Ostn_:= Ostn_ - se_;
         end if;

      end loop;

      -- ��� �������� �� ������ ���������� ����� � ��� �� ������ 2,3 ... �������
      for k in (select accd, nlsd, kv, decode(kv,980,sum(s*100),sum(sq*100)) s,
                       acck, nlsk
                from otcn_f08_history
                where fdat between Datng_ and  Dat_
                  and nlsd=trim(p_nls_)
                  --and nlsd not in (select trim(nls) from rnbu_trace)
                group by accd, nlsd, kv, acck, nlsk
                union
                select accd, nlsd, kv, decode(kv,980,sum(s*100),sum(sq*100)) s,
                       acck, nlsk
                from otcn_f08_history
                where fdat between Dat_+1 and Dat_+29 and
                      vob=96 and
                      nlsd=trim(p_nls_)
                  --and nlsd not in (select trim(nls) from rnbu_trace)
                group by accd, nlsd, kv, acck, nlsk )
      loop

         if substr(k.nlsk,1,1) in ('1','2','3') then
            select NVL(p.k072,'0'), 2-mod(c.codcagent,2), nvl(trim(s.k072),'0'),
                   ca.tobo, ca.nms
              into s1_, r1_, s2_, tobo_, nms_
            from accounts ca, customer c, kl_k070 p, specparam s
           where ca.acc=k.acck and
                  ca.rnk=c.rnk  and
                  ca.acc=s.acc(+) and
                  c.ise = p.k070(+) and
                  p.d_close is null;
         else
            s1_:='X';
            r1_:='1';
            s2_:=s_ ;
         end if;

         if s2_<>'0' then
            s1_:=s2_;
         end if;

         if p_tp_ = '1'
         then
            se_ := k.s;
         else
            se_ := - k.s;
         end if;

         if mfo_ = 324805
         then
            s_ := '0';
            r_ := '2';
            s1_ := '0';
            r1_ := '2';
         end if;

         kod_:= p_tp_ || p_nbs_ || p_r013_ || s1_ || r1_ || lpad(p_kv_,3,'0') || p_s183_ || p_s130_;


         if se_ <> 0 and k.nlsk not like '6%'  --se_ - k.s > 0 and k.nlsk not like '6%'
         then
            comm1_ := '';
            comm1_ := substr(comm1_ || tobo_ || '  ' || nms_, 1, 200);
            INSERT INTO rnbu_trace
                    (nls, kv, odate, kodp, znap, nbuc, rnk, isp, comm)
            VALUES  (k.nlsk, k.kv, dat_, kod_, to_char(se_), p_nbuc_, rnk_, isp_, comm1_);

            Ostn_:= Ostn_ - se_;
         end if;

         if se_ <> 0 and k.nlsk like '6%'  -- k.s > 0 and k.nlsk like '6%'
         then
            kod_:= p_tp_ || p_nbs_ || p_r013_ || s_ || r_ || lpad(p_kv_,3,'0') || p_s183_ || p_s130_;
            INSERT INTO rnbu_trace
                    (nls, kv, odate, kodp, znap, nbuc, rnk, isp, comm)
            VALUES  (k.nlsd, k.kv, dat_, kod_, to_char(se_), p_nbuc_, rnk_, isp_, comm_);

            Ostn_:= Ostn_ - se_;
         end if;

      end loop;
   end if;

   if (substr(p_nbs_,1,3) in ('702','707','709') and mfo_<>300465) OR
      (substr(p_nbs_,1,3) in ('702','707','709') and mfo_=300465 and p_k072_ in ('X','5') ) then

      for k in (select accd, nlsd, kv, decode(kv,980,sum(s*100),sum(sq*100)) s,
                       acck, nlsk
                from otcn_f08_history
                where fdat between Datng_ and Dat_
                  and nlsd=trim(p_nls_)
                group by accd, nlsd, kv, acck, nlsk
                union
                select accd, nlsd, kv, decode(kv,980,sum(s*100),sum(sq*100)) s,
                       acck, nlsk
                from otcn_f08_history
                where fdat between Dat_+1 and Dat_+29 and
                      vob=96 and
                      nlsd=trim(p_nls_)
                group by accd, nlsd, kv, acck, nlsk )
      loop

         comm1_ := comm_;

         if substr(k.nlsk,1,1) in ('2','3','8') then
            if k.nlsk like '2%' OR k.nlsk like '3%' then
               select NVL(p.k072,'0'), 2-mod(c.codcagent,2), nvl(trim(s.k072),'0'),
                      ca.tobo, ca.nms
                 into s1_, r1_, s2_, tobo_, nms_
               from accounts ca, customer c, kl_k070 p, specparam s  --cust_acc ca,
               where ca.acc=k.acck and
                     ca.rnk=c.rnk  and
                     ca.acc=s.acc(+) and
                     c.ise = p.k070(+) and
                     p.d_close is null ;
               comm1_ := '';
               comm1_ := substr(comm1_ || tobo_ || '  ' || nms_, 1, 200);
            end if;
            if k.nlsk like '8%' then
               select NVL(p.k072,'0'), 2-mod(c.codcagent,2), nvl(trim(s.k072),'0'),
                      ca.tobo, ca.nms
                 into s1_, r1_, s2_, tobo_, nms_
               from accounts ca, customer c, kl_k070 p, specparam s  --cust_acc ca,
               where ca.acc=k.acck  and
                     ca.rnk=c.rnk  and
                     ca.acc=s.acc(+) and
                     c.ise = p.k070(+) and
                     p.d_close is null;

               comm1_ := '';
               comm1_ := substr(comm1_ || tobo_ || '  ' || nms_, 1, 200);
            end if;
         else
            s1_:='X';
            r1_:='1';
            s2_:=s_ ;
         end if;

         se_:= 0;  -- 09.06.2013 ���� ���� ���� ��� �������� ��������

         if s2_ <> '0' then  --s1_ = 'X' and s2_<>'0' then
            s1_ := s2_;
         end if;

         if p_tp_ = '1'
         then
            se_ := k.s;
         else
            se_ := - k.s;
         end if;

         if mfo_ = 324805
         then
            s1_ := '0';
            r1_ := '2';
         end if;

         kod_:= p_tp_ || p_nbs_ || p_r013_ || s1_ || r1_ || lpad(p_kv_,3,'0') || p_s183_ || p_s130_;

         if se_ <> 0 then
            INSERT INTO rnbu_trace
                    (nls, kv, odate, kodp, znap, nbuc, rnk, isp, comm)
            VALUES  (k.nlsk, k.kv, dat_, kod_, to_char(se_), p_nbuc_, rnk_, isp_, comm1_);

            Ostn_:= Ostn_ - se_;
         end if;

      end loop;

----- ��� �������� �� ������� ��������� ����� � ��� �� ������ 2,3 ... �������
      for k in (select accd, nlsd, kv, decode(kv,980,sum(s*100),sum(sq*100)) s,
                       acck, nlsk
                from otcn_f08_history
                where fdat  between Datng_ and Dat_ and
                      nlsk=trim(p_nls_)
                  --and nlsk not in (select trim(nls) from rnbu_trace)
                group by accd, nlsd, kv, acck, nlsk
                union
                select accd, nlsd, kv, decode(kv,980,sum(s*100),sum(sq*100)) s,
                       acck, nlsk
                from otcn_f08_history
                where fdat between Dat_+1 and Dat_+29 and
                      vob = 96 and
                      nlsk=trim(p_nls_)
                  --and nlsk not in (select trim(nls) from rnbu_trace)
                group by accd, nlsd, kv, acck, nlsk )
      loop

         comm1_ := comm_;

         if substr(k.nlsd,1,1) in ('2','3','8') then
            if k.nlsd like '2%' OR k.nlsd like '3%' then
               select NVL(p.k072,'0'), 2-mod(c.codcagent,2), nvl(trim(s.k072),'0'),
                      ca.tobo, ca.nms
                 into s1_, r1_, s2_, tobo_, nms_
               from accounts ca, customer c, kl_k070 p, specparam s
               where ca.acc=k.accd and
                     ca.rnk=c.rnk  and
                     ca.acc=s.acc(+) and
                     c.ise = p.k070(+) and
                     p.d_close is null;

               comm1_ := '';
               comm1_ := substr(comm1_ || tobo_ || '  ' || nms_, 1, 200);
            end if;

            if k.nlsd like '8%' then
               select NVL(p.k072,'0'), 2-mod(c.codcagent,2), nvl(trim(s.k072),'0'),
                      ca.tobo, ca.nms
                 into s1_, r1_, s2_, tobo_, nms_
               from accounts ca, customer c, kl_k070 p, specparam s
               where ca.acc=k.accd  and
                     ca.rnk=c.rnk  and
                     ca.acc=s.acc(+) and
                     c.ise = p.k070(+) and
                     p.d_close is null;

               comm1_ := '';
               comm1_ := substr(comm1_ || tobo_ || '  ' || nms_, 1, 200);
            end if;
         else
            s1_:='X';
            r1_:='1';
            s2_:=s_ ;  --'0';
         end if;

         if s2_ <> '0' then
            s1_ := s2_;
         end if;

         if p_tp_ = '1'
         then
            se_ := - k.s;
         else
            se_ := k.s;
         end if;

         if mfo_ = 324805
         then
            s_ := '0';
            r_ := '2';
            s1_ := '0';
            r1_ := '2';
         end if;

         kod_:= p_tp_ || p_nbs_ || p_r013_ || s1_ || r1_ || lpad(p_kv_,3,'0') || p_s183_ || p_s130_;

         if se_ <> 0 and k.nlsd not like '7%' then
            INSERT INTO rnbu_trace
                    (nls, kv, odate, kodp, znap, nbuc, rnk, isp, comm)
            VALUES  (k.nlsd, k.kv, dat_, kod_, to_char(se_), p_nbuc_, rnk_, isp_, comm1_);

            Ostn_:= Ostn_ - se_ ;
         end if;

         if se_ <> 0 and k.nlsd like '7%' then
            kod_:= p_tp_ || p_nbs_ || p_r013_ || s_ || r_ || lpad(p_kv_,3,'0') || p_s183_ || p_s130_;
            INSERT INTO rnbu_trace
                    (nls, kv, odate, kodp, znap, nbuc, rnk, isp, comm)
            VALUES  (k.nlsk, k.kv, dat_, kod_, to_char(se_), p_nbuc_, rnk_, isp_, comm_);

            Ostn_:= Ostn_ - se_ ;
         end if;

      end loop;
   end if;

   if substr(p_nbs_,1,3)='704' and mfo_=300465 then
      for k in (select accd, nlsd, kv, decode(kv,980,sum(s*100),sum(sq*100)) s,
                       acck, nlsk
                from otcn_f08_history
                where fdat between Datng_ and Dat_
                  and nlsd=trim(p_nls_)
                group by accd, nlsd, kv, acck, nlsk
                union
                select accd, nlsd, kv, decode(kv,980,sum(s*100),sum(sq*100)) s,
                       acck, nlsk
                from otcn_f08_history
                where fdat between Dat_+1 and Dat_+29 and
                      vob = 96 and
                      nlsd=trim(p_nls_)
                group by accd, nlsd, kv, acck, nlsk )
      loop
         comm1_ := comm_;

         if substr(k.nlsk,1,1) in ('2','8') then
            select NVL(p.k072,'0'), 2-mod(c.codcagent,2), nvl(trim(s.k072),'0'),
                   ca.tobo, ca.nms
                 into s1_, r1_, s2_, tobo_, nms_
            from accounts ca, customer c, kl_k070 p, specparam s
            where ca.acc=k.acck and
                  ca.rnk=c.rnk  and
                  ca.acc=s.acc(+) and
                  c.ise = p.k070(+) and
                  p.d_close is null;

            comm1_ := '';
            comm1_ := substr(comm1_ || tobo_ || '  ' || nms_, 1, 200);
         else
            s1_:='X';
            r1_:='1';
            s2_:=s_ ;
         end if;

         if s1_ = 'X' and s2_<>'0' then
            s1_:=s2_;
         end if;

         if s1_='0' then
            r1_:='2';
         end if;

         if p_tp_ = '1'
         then
            se_ := k.s;
         else
            se_ := - k.s;
         end if;

         if mfo_ = 324805
         then
            s1_ := '0';
            r1_ := '2';
         end if;

         kod_:= p_tp_ || p_nbs_ || p_r013_ || s1_ || r1_ || lpad(p_kv_,3,'0') || p_s183_ || p_s130_;

         if se_ <> 0 then  --  -se_
            INSERT INTO rnbu_trace
                    (nls, kv, odate, kodp, znap, nbuc, rnk, isp, comm)
            VALUES  (k.nlsk, k.kv, dat_, kod_, to_char(se_), p_nbuc_, rnk_, isp_, comm1_);

            Ostn_:= Ostn_ - se_;
         end if;

      end loop;
---------------
----- ��� �������� �� ������� ��������� ����� � ��� �� ������ 2,3,8 ... �������
      for k in (select accd, nlsd, kv, decode(kv,980,sum(s*100),sum(sq*100)) s,
                       acck, nlsk
                from otcn_f08_history
                where fdat between Datng_ and Dat_
                  and nlsk like p_nls_ || '%'
                group by accd, nlsd, kv, acck, nlsk
                union
                select accd, nlsd, kv, decode(kv,980,sum(s*100),sum(sq*100)) s,
                       acck, nlsk
                from otcn_f08_history
                where fdat between Dat_+1 and Dat_+29 and
                      vob = 96 and
                      nlsk like p_nls_ || '%'
                group by accd, nlsd, kv, acck, nlsk )
      loop

         comm1_ := comm_;

         if substr(k.nlsd,1,1) in ('2','8') then
            select NVL(p.k072,'0'), 2-mod(c.codcagent,2), nvl(trim(s.k072),'0'),
                   ca.tobo, ca.nms
                 into s1_, r1_, s2_, tobo_, nms_
            from accounts ca, customer c, kl_k070 p, specparam s
            where ca.acc=k.accd and
                  ca.rnk=c.rnk  and
                  ca.acc=s.acc(+) and
                  c.ise = p.k070(+) ;
            comm1_ := '';
            comm1_ := substr(comm1_ || tobo_ || '  ' || nms_, 1, 200);
         else
            s1_:='X';
            r1_:='1';
            s2_:=s_ ;
         end if;

         if s1_ = 'X' and s2_<>'0' then
            s1_:=s2_;
         end if;

         if s1_='0' then
            r1_:='2';
         end if;

         if p_tp_ = '1'
         then
            se_ := - k.s;
         else
            se_ := k.s;
         end if;

         if mfo_ = 324805
         then
            s_ := '0';
            r_ := '2';
            s1_ := '0';
            r1_ := '2';
         end if;

         kod_:= p_tp_ || p_nbs_ || p_r013_ || s1_ || r1_ || lpad(p_kv_,3,'0') || p_s183_ || p_s130_;

         if se_ <> 0 then   -- k.s-se_
            INSERT INTO rnbu_trace
                    (nls, kv, odate, kodp, znap, nbuc, rnk, isp, comm)
            VALUES  (k.nlsk, k.kv, dat_, kod_, to_char(se_), p_nbuc_, rnk_, isp_, comm1_);

            Ostn_:= Ostn_ - se_;
         end if;

      end loop;

   end if;

   if substr(p_nbs_,1,3) in ('702','707','709') and s_='0' and mfo_=300465 then
      r_:='2';
   end if;

   if Ostn_ <> 0 then

      kod_:= p_tp_ || p_nbs_ || p_r013_ || s_ || r_ || lpad(p_kv_,3,'0') || p_s183_ || p_s130_;

      INSERT INTO rnbu_trace
               (nls, kv, odate, kodp, znap, nbuc, rnk, isp, comm)
      VALUES  (p_nls_, p_kv_, p_dat_, kod_, to_char(Ostn_), p_nbuc_, rnk_, isp_, comm_);
   end if;
exception
    when others then
        raise_application_error(-20002, '������� � ��������?: '||sqlerrm);
end;
----------------------------------------------------------------------------
BEGIN

commit;

EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
-------------------------------------------------------------------
userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';

logger.info ('P_F08_NN: Begin for datf = '||to_char(dat_, 'dd/mm/yyyy'));
-------------------------------------------------------------------
Dat1_ := TRUNC(Dat_,'MM');
Datng_:= to_date('0201'||to_char(Dat_,'YYYY'),'ddmmyyyy');

-- ���� ���
   mfo_ := f_ourmfo ();

-- ��� "��������"
   BEGIN
      SELECT mfou
        INTO mfou_
        FROM banks
       WHERE mfo = mfo_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         mfou_ := mfo_;
   END;
-- ����������� ���� ��� ��� ���� ������� ��� ���������� ����� � �����
p_proc_set(kodf_,sheme_,nbuc1_,typ_);

-- ������ �������������� KL_R020 ����� ������������ KOD_R020
sql_acc_ := 'select r020 from kod_r020 where trim(prem)=''��'' and a010=''08'' ';

   if mfou_ <> 300465 and to_char(Dat_,'MM')='12' then
      ret_ := f_pop_otcn(Dat_, 4, sql_acc_, null, 1);   --ret_ := f_pop_otcn(Dat_, 4, sql_acc_);
   else
      if to_char(Dat_,'MM') in ('01','02','03','04','05','06') then
         ret_ := f_pop_otcn(Dat_, 4, sql_acc_, null, 1);
      else
         ret_ := f_pop_otcn(Dat_, 2, sql_acc_);
      end if;
   end if;

-- ��� ������������ ����� �� ������ �����
-- �� ������� OTCN_F08_HISTORY ������� �������� �� ���������� ���
if to_char(dat_,'MM')='01' then
   delete from otcn_f08_history
   where fdat < Dat1_;
end if;

delete from otcn_f08_history
where fdat between Dat1_ and Dat_;

delete from otcn_f08_history
where fdat between Dat_+1 and Dat_+29
  and vob = 96 ;

-- ��� ������ �������� � ������ ������ ��������� ������ ���� ����
-- �.�. � ���� ���� ����������� �������� ���������� 6,7 ������� �� 5040(5041)
-- ����������� ����
if to_char(dat_,'MM')='01' then
   Dat1_ := Dat1_ + 1;
end if;

commit;

---------------------------------------------------------------------
-- ����� ������� ����� ���������� ������� OTCN_F08_HISTORY
 insert /*+ APPEND */
 into otcn_f08_history
            (accd,tt,ref,kv,nlsd,s,sq,fdat,nazn,acck,nlsk,userid,tobo,vob)
 select accd,tt,ref,kv,trim(nlsd),s,sq,fdat,nazn,acck,trim(nlsk),isp,'0',vob
        from (SELECT p.userid isp, p.branch, p.mfoa, p.mfob, p.nam_a, p.nam_b, p.sos,
                       DECODE (o.tt, p.tt, p.nazn, DECODE (o.tt, 'PO3', p.nazn, t.NAME)) nazn,
                       o.tt, o.REF, o.sq/100 sq, o.fdat, o.stmt, o.txt,
                       (case when ad.nls like '3801%' then 0 else o.accd end) accd,
                       (case when ad.nls like '3801%' then decode(p.dk,1,p.nlsa,p.nlsb) else ad.nls end) nlsd,
                       (case when ad.nls like '3801%' then substr(decode(p.dk,1,p.nlsa,p.nlsb),1,4) else ad.nbs end) nbsd,
                       (case when ak.nls like '3801%' then 0 else o.acck end) acck,
                       (case when ak.nls like '3801%' then decode(p.dk,0,p.nlsa,p.nlsb) else ak.nls end) nlsk,
                       (case when ak.nls like '3801%' then substr(decode(p.dk,0,p.nlsa,p.nlsb),1,4) else ak.nbs end) nbsk,
                       (case when ad.nls like '3801%' or ak.nls like '3801%' then decode(p.kv, 980, p.kv2, p.kv) else ad.kv end) kv,
                       (case when ad.nls like '3801%' or ak.nls like '3801%' then decode(p.kv, 980, p.s2, p.s) else o.s end)/100 s,
                     p.vob
                FROM oper p, tts t, accounts ad,   accounts ak,
                     (SELECT /*leading(a) */
                             p.fdat, p.REF, p.stmt, p.tt, p.s, p.sq, p.txt,
                             DECODE (p.dk,0,p.acc,z.acc) accd,
                             DECODE (p.dk,1,p.acc,z.acc) acck
                      FROM opldok p, accounts a, opldok z
                      WHERE p.fdat = any (select fdat from fdat where fdat between Dat1_ and Dat_)
                        and p.sos >= 4
                        and p.acc = a.acc
                        and regexp_like(A.NLS, '^((602)|(605)|(609)|(702)|(704)|(707)|(709))')
                        and p.ref = z.ref
                        and p.fdat = z.fdat
                        and p.stmt = z.stmt
                        and p.dk <> z.dk) o
                WHERE p.REF = o.REF
                  and t.tt = o.tt
                  and o.accd = ad.acc
                  and o.acck = ak.acc
                  and p.sos = 5
                  );
 commit;

 -- ������������� ��������
 insert /*+ APPEND */
 into otcn_f08_history
            (accd,tt,ref,kv,nlsd,s,sq,fdat,nazn,acck,nlsk,userid,tobo,vob)
 select accd,tt,ref,kv,trim(nlsd),s,sq,fdat,nazn,acck,trim(nlsk),isp,'0',vob
        from (SELECT p.userid isp, p.branch, p.mfoa, p.mfob, p.nam_a, p.nam_b, p.sos,
                       DECODE (o.tt, p.tt, p.nazn, DECODE (o.tt, 'PO3', p.nazn, t.NAME)) nazn,
                       o.tt, o.REF, o.sq/100 sq, o.fdat, o.stmt, o.txt,
                       (case when ad.nls like '3801%' then 0 else o.accd end) accd,
                       (case when ad.nls like '3801%' then decode(p.dk,1,p.nlsa,p.nlsb) else ad.nls end) nlsd,
                       (case when ad.nls like '3801%' then substr(decode(p.dk,1,p.nlsa,p.nlsb),1,4) else ad.nbs end) nbsd,
                       (case when ak.nls like '3801%' then 0 else o.acck end) acck,
                       (case when ak.nls like '3801%' then decode(p.dk,0,p.nlsa,p.nlsb) else ak.nls end) nlsk,
                       (case when ak.nls like '3801%' then substr(decode(p.dk,0,p.nlsa,p.nlsb),1,4) else ak.nbs end) nbsk,
                       (case when ad.nls like '3801%' or ak.nls like '3801%' then decode(p.kv, 980, p.kv2, p.kv) else ad.kv end) kv,
                       (case when ad.nls like '3801%' or ak.nls like '3801%' then decode(p.kv, 980, p.s2, p.s) else o.s end)/100 s,
                     p.vob
                FROM oper p, tts t, accounts ad, accounts ak,
                     (SELECT /*leading(a) */
                             p.fdat, p.REF, p.stmt, p.tt, p.s, p.sq, p.txt,
                             DECODE (p.dk,0,p.acc,z.acc) accd,
                             DECODE (p.dk,1,p.acc,z.acc) acck
                      FROM opldok p, accounts a, opldok z
                      WHERE p.fdat = any (select fdat from fdat where fdat between Dat_+1 and Dat_+29)
                        and p.sos >= 4
                        and p.acc = a.acc
                        and regexp_like(A.NLS, '^((602)|(605)|(609)|(702)|(704)|(707)|(709))')
                        and p.ref = z.ref
                        and p.fdat = z.fdat
                        and p.stmt = z.stmt
                        and p.dk <> z.dk) o
                WHERE p.REF = o.REF
                  and t.tt = o.tt
                  and o.accd = ad.acc
                  and o.acck = ak.acc
                  and p.sos = 5
                  and p.vob = 96
                  );
 commit;

 update otcn_f08_history a set
 a.accd=(select acc from accounts
         where nls=a.nlsd and kv=decode(substr(a.nlsd,1,1),'6',980,
                                 decode(substr(a.nlsd,1,1),'7',980,a.kv)))
 where a.fdat >= dat1_ and
       (a.accd=0 or a.accd is NULL);

 update otcn_f08_history a set
 a.acck=(select acc from accounts
         where nls=a.nlsk and kv=decode(substr(a.nlsk,1,1),'6',980,
                                 decode(substr(a.nlsk,1,1),'7',980,a.kv)))
 where a.fdat >= dat1_ and
       (a.acck=0 or a.acck is NULL);

---------------------------------------------------------------------
-- ��� ������������ ����� �� ������ ����� �� ������� OTCN_F08_HISTORY
-- ������� �������������� �������� �� ���������� ���
if to_char(dat_,'MM')='01' then
   delete from otcn_f08_history
   where fdat < Dat_
     and vob=96 ;
end if;
-- ������� ������� ���������� 6,7 �� 504
if to_char(dat_,'MM') in ('01','12') then
   delete from otcn_f08_history
   where nlsd LIKE '504%' and
         (nlsk LIKE '6%' OR nlsk LIKE '7%');
end if;
if to_char(dat_,'MM') in ('01','12') then
   delete from otcn_f08_history
   where (nlsd LIKE '6%' OR nlsd LIKE '7%') and
         nlsk LIKE '504%';
end if;

-- ��� �������� �� ��������� ����������� ��������������� ����������
if to_char(dat_,'MM')='01' then
   delete from otcn_f08_history
   where fdat < Dat_
     and ref in (select a.ref
                 from oper a
                 where a.datd BETWEEN Dat1_ and Dat_ and a.vob=96) ;
end if;

if (to_char(dat_,'MM') not in ('01','02') and mfo_=333368) or mfo_<>333368 then
   delete from otcn_f08_history
   where substr(nlsd,1,4)='3801' and
         regexp_like(nlsk, '^((602)|(605)|(609)|(702)|(704)|(707)|(709))');
end if;

if (to_char(dat_,'MM') not in ('01','02') and mfo_=333368) or mfo_<>333368 then
   delete from otcn_f08_history
   where regexp_like(nlsd, '^((602)|(605)|(609)|(702)|(704)|(707)|(709))') and
         substr(nlsk,1,4)='3801';
end if;

delete from otcn_fa7_temp;

-- 05/06/2013 ����� ������� ���������� OTCN_FA7_TEMP ��� ���� ����� �������������
-- ����� ����������� ��� ����
insert into otcn_fa7_temp (r020)
values ('3570');

insert into otcn_fa7_temp (r020)
values ('3578');

----------------------------------------------------------------------
----- ��������� ��������
OPEN SALDO;
LOOP
   FETCH SALDO INTO rnk_, acc_, nls_, kv_, data_, nbs1_, r011_, r013_, k072_,
                    Ostn_, Ostq_, Dos96_, Kos96_, Dosq96_, Kosq96_,
                    Dos99_, Kos99_, Dosq99_, Kosq99_,
                    Doszg_, Koszg_, isp_, tobo_, nms_, tip_, s130_, nd_, freq_;
   EXIT WHEN SALDO%NOTFOUND;

   comm_ := 'R013='||r013_;
   nd_:=null;

   --- ������� �� ���������� 6,7 ������� �� 5040,5041
   IF to_char(Dat_,'MM')='12' and (nls_ like '6%' or nls_ like '7%' or nls_ like '504%') THEN
    SELECT NVL(SUM(decode(dk,0,1,0)*s),0),
                    NVL(SUM(decode(dk,1,1,0)*s),0)
             INTO d_sum_, k_sum_
             FROM opldok
             WHERE fdat  between Dat_  AND Dat_+29 AND
                   acc  = acc_   AND
                   (tt like 'ZG8%'  or tt like 'ZG9%');
      Dos96_:=Dos96_-d_sum_;
      Kos96_:=Kos96_-k_sum_;
   END IF;

   IF Dos99_ > 0 THEN
      BEGIN
        select NVL(sum(s),0)
           into sk_
        from kor_prov
        where vob=99
          and dk=0
          and acc=acc_
          and fdat between Dat_+1 and Dat_+28;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         sk_ := 0;
      END;
      Dos96_ := Dos96_ - sk_;
   END IF;

   IF Kos99_ > 0 THEN
      BEGIN
        select NVL(sum(s),0)
           into sk_
        from kor_prov
        where vob=99
          and dk=1
          and acc=acc_
          and fdat between Dat_+1 and Dat_+28;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         sk_ := 0;
      END;
      Kos96_ := Kos96_ - sk_;
   END IF;

   IF Dosq99_ > 0 THEN
      BEGIN
        select NVL( sum(gl.p_icurval(kv_, s, vdat)), 0)
           into sk_
        from kor_prov
        where vob=99
          and dk=0
          and acc=acc_
          and fdat between Dat_+1 and Dat_+28;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         sk_ := 0;
      END;
      Dosq96_ := Dosq96_ - sk_;
   END IF;

   IF Kosq99_ > 0 THEN
      BEGIN
        select NVL( sum(gl.p_icurval(kv_, s, vdat)), 0)
           into sk_
        from kor_prov
        where vob=99
          and dk=1
          and acc=acc_
          and fdat between Dat_+1 and Dat_+28;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         sk_ := 0;
      END;
      Kosq96_ := Kosq96_ - sk_;
   END IF;

   IF kv_ <> 980 THEN
      se_:=Ostq_-Dosq96_+Kosq96_;
   ELSE
      se_:=Ostn_-Dos96_+Kos96_;
   END IF;

   if nbs1_ = '3579' then
      r013_ := '0';
   end if;

   IF se_<>0 THEN
      if typ_>0 then  --sheme_ = 'G' and (tips_<>'T00' and tips_<>'T0D') and typ_>0 then
         nbuc_ := nvl(f_codobl_tobo(acc_,typ_),nbuc1_);
      else
         nbuc_ := nbuc1_;
      end if;
      comm_ := '';
      comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);
      BEGIN
         SELECT DECODE(Trim(s180), NULL, Fs180(acc_,SUBSTR(nbs1_,1,1), dat_), s180)
            INTO s180_
         FROM specparam
         WHERE acc=acc_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         s180_:='0';
      END ;

      IF nbs1_ in ('1819','2900','2901','2902','2903','2905','2909','3579') and
           (s180_ is NULL OR s180_='0') THEN
         s180_:='1';
      END IF;

      if substr(nbs1_,1,1) in ('6','7') then
         S180_:='1';
      end if;

      if nbs1_ in ('3340','3346','3347','3348') THEN
         S180_:='1';
      end if;

-- � 01.02.2007 ����������� �������� S183
      BEGIN
         SELECT NVL(s183,'0')
         INTO S183_
         FROM kl_s180
         WHERE s180=s180_;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         s183_:='0';
      END ;

      if nbs1_ in ('3300','3301','3305','3306','3307','3308','3320',
                   '3326','3327','3328') then
         s183_:='B';
      end if;

      dk_:=IIF_N(se_,0,'1','2','2');

      -- ���� ����������� ���������?
      BEGIN
         SELECT 1 INTO fa7p_
         FROM otcn_fa7_temp
         WHERE r020 = nbs1_ and rownum=1;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         fa7p_ := 0;
      END;

      -- ����� ����������� ���������
      IF fa7p_ > 0 and se_ < 0 THEN

         freq_:= NULL;

         if nbs1_ = '3579' then
            if Dat_ <= to_date('30112012','ddmmyyyy') then
               select (-1)*nvl(sum(dos),0)
                  into dos_
               from saldoa
               where acc=acc_ and
                     fdat between (Dat_-31)+1 and Dat_;

               IF kv_ <> 980 THEN
                  dose_:=GL.P_ICURVAL(kv_, dos_, Dat_) ;
               ELSE
                  dose_:=dos_ ;
               END IF;

               if abs(se_) > abs(dose_) then
                  comm_ := comm_ || ' �������� �������';

                  IF dose_<>0 THEN
                     dk_:=IIF_N(dose_,0,'1','2','2');
                     r013_:='1';
                     p_ins(data_, dk_, rnk_, nls_, nbs1_, kv_, r011_, r013_,
                           k072_, s183_, s130_, TO_CHAR(ABS(dose_)), isp_, nbuc_);
                  END IF;

                  se_ := se_ - dose_;
                  r013_ := '2';
               else
                  if r013_='0' then
                     r013_ := '1';
                     comm_ := comm_ || ' ���i�� R013';
                  end if;
               end if;
            else
               r013_ := '0';
            end if;
         else
            if (not (322498 IN (mfo_, mfou_)) and nvl(freq_, 400) = 5) or
                  (322498 IN (mfo_, mfou_) and nvl(r013_, '0') = '3') then
               if r013_ in ('0','1', '2') then
                  r013_ := '3';
                  comm_ := comm_ || ' ���i�� R013';
               end if;
            else
               IF typ_ > 0 THEN
                  nbuc_ := NVL (F_Codobl_Tobo (acc_, typ_), nbuc1_);
               ELSE
                  nbuc_ := nbuc1_;
               END IF;

               p_analiz_r013_new (mfo_,
                              mfou_,
                              dat_,
                              acc_,
                              tip_,
                              nbs_,
                              kv_,
                              r013_,
                              se_,
                              nd_,
                              freq_,
                              --------
                              o_r013_1,
                              o_se_1,
                              o_comm_1,
                              --------
                              o_r013_2,
                              o_se_2,
                              o_comm_2
                             );

               -- �� 30 ����
               IF o_se_1 <> 0
               THEN
                  r013_ := '3';
                  p_ins(data_, dk_, rnk_, nls_, nbs1_, kv_, r011_, r013_,
                        k072_, s183_, s130_, TO_CHAR(ABS(o_se_1)), isp_, nbuc_);

                  se_ := se_ - o_se_1;
               END IF;

               -- ����� 30 ����
               IF o_se_2 <> 0
               THEN
                  r013_ := '4';
                  p_ins(data_, dk_, rnk_, nls_, nbs1_, kv_, r011_, r013_,
                        k072_, s183_, s130_, TO_CHAR(ABS(o_se_2)), isp_, nbuc_);

                  se_ := se_ - o_se_2;
               END IF;
            END IF;

         end if;
      end if;

      dk_:=IIF_N(se_,0,'1','2','2');
      if se_ <> 0 then
         p_ins(data_, dk_, rnk_, nls_, nbs1_, kv_, r011_, r013_,
               k072_, s183_, s130_, TO_CHAR(ABS(se_)), isp_, nbuc_);
      end if;
   END IF;

END LOOP;
CLOSE SALDO;
---------------------------------------------------
DELETE FROM tmp_nbu where kodf=kodf_ and datf= dat_;
---------------------------------------------------

INSERT INTO tmp_nbu(kodf, datf, kodp, znap, nbuc)
SELECT kodf_, Dat_, kodp, SUM (znap), nbuc
FROM rnbu_trace
GROUP BY kodf_, Dat_, kodp, nbuc;

logger.info ('P_F08_NN: End for datf = '||to_char(dat_, 'dd/mm/yyyy'));
----------------------------------------
END p_f08_NN;
/
show err;

PROMPT *** Create  grants  P_F08_NN ***
grant EXECUTE                                                                on P_F08_NN        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F08_NN        to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F08_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
