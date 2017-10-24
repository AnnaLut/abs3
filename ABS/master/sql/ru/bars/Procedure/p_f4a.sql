

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F4A.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F4A ***

  CREATE OR REPLACE PROCEDURE BARS.P_F4A (Dat_ DATE )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : ��������� ������������ ����� #4A ��� ��
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 15/04/2015 (12/11/2014, 14/10/2014, 10/10/2014)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
���������: Dat_ - �������� ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
15.04.2015 ��� ������ ������������ �������� ��� "CC"  ������� ���������
           �� OTC_F4A_HISTORY_ACC � ��� ���������� �� KL_F3_29
12.11.2014 ��� ����������� ���������� ������������� ����� ����������
           (�� ������)
14.10.2014 ��� �������� �� 2600 �� 2607 ����� ����������� ��� 08
10.10.2014 �� �������� ������� ��� �������� �� ��������� ����� ���������
09.10.2014 ��� �������� �� 2069 �� 2607 ������ ���� DD='08' �����
           ������������� ��� DD='11'
           �� �� �������� ��� ������� �� ��������� � ������� ������
           ������ �� �������� � ����
           ��� ������������ ������� �� ���������� ������ ��������� �������
           ��� ������ ��������
14.03.2014 �� ��������� ������������� 18.07.2013 ���� ��������� ���������
           � ��������� ��� ����� ���������� ��� ���������� �����������
           ������������� ����� ����������� �� ����� ��������� ��� ������
           � �� �� ����� ���������� ��������
           � 14.03.2014 ��������� ��������� ��� ����� ���������� ���
           ���������� ����������� ������������� �� ������������ ��������
           ����������� � ������� � ������ �������� ����� �����������
           �� ����� ���������� �������� � �� �� ����� ��������� ��� ������
           (��������� ����� ������������)
21.01.2014 � ������ ������� �������� ���.���� 2890

������� ������������ �����������:

    03 - ����� ������i��� �������������i �� ��i��� ����
    ----------------------------------------------------------------------------------------
    �� 01.12.2012
    04 - ����� ������i��� �������������i �� ���� i��� ����������� ����i� �i���� 180 ��i� (�� 01.12.2012)

    � 01.12.2012
    15 - ����� ������_��� �������������_, �� ���� � ������������ ��������� ��������� ����� �_���� 180 ��_� (� 01.12.2012)

    16 - ����� ������_��� �������������_, �� ���� � ������������ ��������� �����. �����_� �_���� 180 ��_� (� 01.12.2012)
    -----------------------------------------------------------------------------------------
    �� 01.12.2012
    05 - ��i������� ������ ������i��� �������������i � ��i����� ���i��i

    � 01.12.2012
    06 - ��_������� ������ ������_��� �������������_ �� �������� ������

    12 - ��_������� ������ ������_��� �������������_ �� ������������ ��������
    -----------------------------------------------------------------------------------------
    07 - ��������� ������ ������i��� �������������i � ������ i� ��������� �� ������� �������

    08 - ��������� ������ ������i��� �������������i � ������ i� ����������

    09 - ��������� ������ ������i��� �������������i � ������ i� ���������� �� ������� ������������

    10 - ��������� ������ ������i��� �������������i � ������ i� �������� (������������� ����� ������)

    11 - ��������� ������ ������i��� �������������i � ������ � i���� ������

    � 01.12.2012
    13 - ��������� ������ ������_��� �������������_ �� �������� ������

    14 - ��������� ������ ������_��� �������������_ ��  ������������ ��������


�����������:

    1. ����� �������� � �������� ��������� ���� ������������ ��������� ������� -
       - �������� �� �������� �������� (��, ���, ���, �����������)
       - ���� �������� � �������� ��� - ����� ������� �� ��������� "����� �������� (�.71)" �� �����
       - ���� �������� �� ��������, ������ ���� ��������� ��������� ���������

    2.    ��������, ������� ���� ��������� � �������� �� ���������� ��������� �������, ������������ �� ����� dd:
        -    07 - ��� ���������� ������ ��������;
        -    08 - ��� �������� ��������;
        -    12 - ��� ������ �� ����� ��������� ���������;
        -    14 - ��� �������� ��������� ���������.

    3. �� ����������� ����������� �� �����, �� ������� � ������� ��������� ������ �� ���� �������� ��������.

    4. ��� ����������� ������� ��-������� (���������) ������ ��
        - ��������� ������� �� ����� (��������� ������� �� ���������� ����),
        - ���������� �������� �� ������� �����
        - ������ �� ������� ����� (�� ����� #03)
        �.�.
         1. �� >= 0  ��� = 0  -  ����� = ������
         2. �� >= 0  ��� < 0  -  ����� = ������ - abs(���)
         3. �� < 0  ��� = 0  -  ����� = ������ + abs(��)
         4. �� < 0  ��� < 0  -  ����� = ������ + abs(��) - abs(���)

    5. ������������ ��������� �������� ������� ���� � �������� ����������� (����. ACC_OVER ��� ACC_OVER_ARCHIVE)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='4A';
sheme_   Varchar2(1):='C';
acc_     Number;
dk_      Varchar2(1);
nbs_     Varchar2(4);
nls_     Varchar2(15);
dd_      Varchar2(2);
mdate_   Date;
dat1_    Date;
data_    Date;
kv_      SMALLINT;
se_      DECIMAL(24);
Ostn_    DECIMAL(24);
Ostq_    DECIMAL(24);
Dos96_   DECIMAL(24);
Kos96_   DECIMAL(24);
Dosq96_  DECIMAL(24);
Kosq96_  DECIMAL(24);
Doszg_   DECIMAL(24);
Koszg_   DECIMAL(24);
Dos96zg_ DECIMAL(24);
Kos96zg_ DECIMAL(24);
Dos99zg_ DECIMAL(24);
Kos99zg_ DECIMAL(24);
skq_     Number;
szq_     Number;
kol_     Number;
kodp_    Varchar2(14);
znap_    Varchar2(30);
cc_      Varchar(3);
userid_  Number;
sql_acc_ varchar2(2000):='';
ret_     number;
rnk_     number;
codcagent_ number;

nd_      number;
sdate_   date;
wdate_   date;
sos_     number;
s080_r   specparam.S080%type;
rs080_   specparam.S080%type;
name_s080_ tmp_rez_risk.S080_NAME%type;
comm_    varchar2(200);
datp_    date;
datb_    date;
mfo_     number;
mfou_    number;
default_ number;
is_upb   number := 0;
kosq_    number;
typ_     number;
nbuc_    varchar2(12);
nbuc1_   varchar2(12);


BEGIN
commit;

EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
-------------------------------------------------------------------
logger.info ('P_F4A_NN: Begin for datf = '||to_char(dat_, 'dd/mm/yyyy'));
-------------------------------------------------------------------
userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
EXECUTE IMMEDIATE 'alter session set NLS_NUMERIC_CHARACTERS=''.,''';
EXECUTE IMMEDIATE 'TRUNCATE TABLE TMP_FILE03';
-------------------------------------------------------------------
mfo_ := f_ourmfo;

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

Dat1_  := TRUNC(add_months(Dat_,1),'MM');

BEGIN
   select A017
      into sheme_
   from kl_f00
   where kodf = kodf_
     and a017 <> sheme_;
EXCEPTION WHEN NO_DATA_FOUND THEN
   NULL;
END;

-- ����������� ��������� ���������� (��� ������� ��� ��� ��� �������������)
P_Proc_Set(kodf_,sheme_,nbuc1_,typ_);

-- 16.04.2013 ����� ������� ��������� ����� �������� �������� ����� �� ��
sql_acc_ := 'select distinct r020 from kl_f3_29 where kf=''4A'' ) or '||
            '(nbs is null and substr(nls,1,4) in
             (select distinct r020 from kl_f3_29 where kf=''4A'')';

--��� ��� � ������� ������ ����������� �� ����� �� �������� ����
if (300205 in (mfo_, mfou_)) or (353575 in (mfo_, mfou_)) then
   is_upb := 1;
end if;

datb_ := trunc(dat_, 'mm'); -- ���� ������ ������

select max(fdat) -- ������� �������� ����
into datp_
from fdat
where fdat<datb_ and fdat NOT IN (SELECT holiday FROM holiday);

if mfo_ = 300465 and datp_=to_date('30122012','ddmmyyyy') then
   datp_ := to_date('29122012','ddmmyyyy');
end if;

ret_ := f_pop_otcn(Dat_, 3, sql_acc_);   -- ������ ���������� f_pop_otcn_snp
-------------------------------------------------------------------
--!!!!!!!!!!!!!!!!!!!!!
delete from otc_f4A_history_acc where datf=dat_ ;

-- ���������� ��� �����
insert into otc_f4a_history_acc(DATF, ACC, ISP, NBS, SGN, NLS, KV, NMS, DAOS, DAZS, OST,
       OSTQ, DOSQ, KOSQ, ND, NKD, SDATE, WDATE, SOS, RNK, PRINSIDER, STAFF, TOBO, s080, r011,
       tip, cc_id, s280, s290)
select dat_, tt.ACC, tt.ISP, tt.NBS, tt.SGN, tt.NLS, tt.KV, tt.NMS, tt.DAOS, tt.DAZS, tt.OST,
       tt.OSTQ, tt.DOSQ, tt.KOSQ, tt.ND, tt.NKD, tt.SDATE, tt.WDATE, tt.SOS, tt.RNK, tt.prinsider,
       tt.u_id, tt.TOBO, tt.s080, tt.r011,
       tt.tip, tt.cc_id, tt.s280, tt.s290
from (select  s.acc, o.isp isp, substr(o.nls,1,4) nbs, decode(sign(s.ost-s.dos96+s.kos96),-1,'1',1,'2','0') sgn,
               o.nls, o.kv, o.nms, o.daos, o.dazs, s.ost-s.dos96+s.kos96 ost,
               decode(o.kv, 980, s.ost-s.dos96+s.kos96, s.ostq-s.dosq96+s.kosq96) ostq,
               decode(o.kv, 980, s.dos+s.dos96-s.dos96p, gl.p_icurval (o.kv, s.dos+s.dos96-s.dos96p, dat_)) dosq,
               decode(o.kv, 980, s.kos+s.kos96-s.kos96p, gl.p_icurval (o.kv, s.kos+s.kos96-s.kos96p, dat_)) kosq,
               nvl(to_char(c.nd), decode(trim(p.nkd), null,'-'||to_char(s.acc), '�'||trim(p.nkd))) nd,
               null nkd, -- ���� ���� ND, �� �_���������� ACC
               c.sdate, c.wdate, c.sos, s.rnk, DECODE(z.prinsider,99,2,0,2,1) prinsider, user_id u_id, o.tobo,
               nvl(p.s080,'0') s080, nvl(p.r011,'0') r011,
               o.tip,
               c.cc_id, trim(p.s280) s280, trim(p.s290) s290
        from OTCN_SALDO s, OTCN_ACC o,
           (select a.acc,
                   -- ��� ��� ��������� ND ����������� NULL -
                   --����� �������� ����� ������� �� �����
                   (case
                    when 300465 in  (mfo_) then null
                    else a.nd
                    end ) nd ,
                   b.sdate, b.wdate, b.sos, b.cc_id
            from
                 (select n.acc, max(n.nd) nd
                     from nd_acc n, cc_deal c
                     where n.nd=c.nd and c.sdate <= dat_
                     group by n.acc
                 ) a
                 left join cc_deal b on a.nd=b.nd
                 --��� ��������� ����� � �������� ���� ��� ������� � ������� �� ������ �������, �� ���� ����� 9129
           ) c,
              specparam p, customer z
              ,kl_f3_29 n
        where s.acc = o.acc and
             s.acc=c.acc(+) and
             s.acc=p.acc(+) and
             s.rnk=z.rnk and
             substr(o.nls,1,4) = n.r020 and
             n.kf='4A'
            and nvl(o.dazs, to_date('01014999','ddmmyyyy')) >= trunc(dat_,'mm')
        ) tt
where (tt.ost <> 0 or tt.dosq <> 0 or tt.kosq <> 0) and --���� ������� ��� ������� �� ������-�� �� ������ ��������
      -- ������ ����� � ���������� ���������
     not (tt.ost > 0 and
        tt.nbs in ('1600','2600','2605','2620','2625','2650','2655','8025','8026','8027','8028')
        )
group by   tt.acc, tt.isp,tt.nbs, tt.sgn,
       tt.nls, tt.kv, tt.nms, tt.daos, tt.dazs,
       tt.ost,tt.ostq, tt.dosq, tt.kosq,tt.nd, tt.nkd,
       tt.sdate, tt.wdate, tt.sos, tt.rnk, tt.prinsider, tt.tobo,
       tt.s080, tt.r011, tt.tip, tt.u_id, tt.cc_id, tt.s280, tt.s290 ;

logger.info ('P_F4A_NN: END Part1 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

--��� ������� ������� ����������������� ����� �����������
if 353575 in (mfo_, mfou_) then
    delete from otc_f4a_history_acc o
    where o.datf = dat_ and
          o.nls in ('262551018','262771018','220781118','220901118');
end if;

--��������� ��������� S280 � S290 �� ������ ���������, ���� ��� �� ��������� � specparam
update otc_f4a_history_acc
set s280 = decode(trim(tip),'SP',decode(nvl(s280,'*'),'*',f_get_s280(dat_,acc, null,acc ),s280),null),
    s290 = decode(trim(tip),'SPN',decode(nvl(s290,'*'),'*',f_get_s290(dat_,acc, null,acc ),s290),null)
where datf=dat_ and trim(tip) in ('SP','SPN');

--��������� ��������� S280,S290 �� �������� ������, �� ������ ���������, ���� ��� �� ��������� � specparam
begin
for k in (select rnk, nd, max(NVL(s280,'0')) over(partition by nvl(nkd, nd)) s280,
                     max(NVL(s290,'0')) over(partition by nvl(nkd, nd)) s290
          from otc_f4a_history_acc
          where datf=dat_ and tip in ('SP','SPN')
              and nd is not null
          order by nd
         )
   loop
      update otc_f4a_history_acc set s280=GREATEST(k.s280,k.s290), s290=GREATEST(k.s280,k.s290)
      where datf=dat_ and rnk=k.rnk and nd=k.nd; -- and trim(tip) in ('SS','SN','SK0','SK9','ODB');
   end loop;
end;

logger.info ('P_F4A_NN: END Part2 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

-- ��������� �������� S080 �� �������� ������ ��� ������ ��������� �� ����. TMP_REZ_RISK � �������� S080
begin
for k in (select *
          from otc_f4a_history_acc
          where datf=dat_
          order by nls
         )
   loop
      s080_r := '0';

      if Dat_ <= to_date('30112012','ddmmyyyy') then
         BEGIN
            select NVL(trim(t.s080),'0')
               into s080_r
            from tmp_rez_risk t
            where t.acc = k.acc
              and t.id in (select userid from rez_protocol where dat = Dat_)
              and t.dat = dat_
              and t.cc_id = k.cc_id
              and t.rnk = k.rnk
              and t.skq <> 0;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            s080_r := '0';
         END;
      end if;

      if Dat_ > to_date('30112012','ddmmyyyy') then
         BEGIN
            select to_char(NVL(trim(t.kat),0))
               into s080_r
            from nbu23_rez t
            where t.fdat = dat1_
              and t.acc = k.acc
              and t.acc is not null
              and t.bv <> 0
              and rownum = 1;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            s080_r := '0';
         END;
      end if;

      -- ������ ��������� ����� �� �������� ������ ��� ������ ���������
      if s080_r <> '0' and s080_r <> k.s080 then
         update otc_f4a_history_acc set s080=s080_r
         where datf=dat_ and acc=k.acc;  --and tip in ('SS','SP') and nd=k.nd and rnk=k.rnk;   --cc_id=k.cc_id
      end if;
   end loop;
end;

logger.info ('P_F4A_NN: END Part3 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

-- 10.05.2012 �������� �.�. ��� ���.��. 3570,3578,3579 � TMP_REZ_RISK SKQ=SZQ
-- ���� ������ ��� ����� ������������ ����� �������� ������ ���.�����
if mfou_ in (300120) then
   begin
      for k in (select *
                from otc_f4a_history_acc
                where datf=dat_
                and trim(cc_id) is null
               )
      loop

         s080_r := '0';

         if Dat_ <= to_date('30112012','ddmmyyyy') then
            BEGIN
               select NVL(trim(t.s080),'0'), skq, nvl(gl.p_icurval(t.kv, nvl(t.sz1, t.sz), dat_),0) szq
                  into s080_r, skq_, szq_
               from tmp_rez_risk t
               where t.acc = k.acc
                 and t.id in (select userid from rez_protocol where dat = Dat_)
                 and t.dat = dat_
                 and t.rnk = k.rnk;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               s080_r := '0';
               skq_ := 0;
               szq_ := 0;
            END;
         end if;

         if Dat_ > to_date('30112012','ddmmyyyy') then
            BEGIN
               select to_char(NVL(trim(t.kat),0))
                  into s080_r
               from nbu23_rez t
               where t.acc = k.acc
                 and t.fdat = dat1_
                 and t.rnk = k.rnk
                 and t.bv <> 0
                 and rownum = 1;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               s080_r := '0';
            END;
         end if;

         if s080_r = '9' and skq_ = szq_ then
            s080_r := '5';
         end if;

         if s080_r = '9' and skq_ <> szq_ then
            s080_r := '4';
         end if;

         if s080_r <> '0' and s080_r <> k.s080 then
            update otc_f4a_history_acc set s080=s080_r
            where datf=dat_ and acc=k.acc;
         end if;

      end loop;
   end;
end if;

logger.info ('P_F4A_NN: END Part4 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

-- ���������� ���� CC �� ������� � KL_F3_29
update otc_f4a_history_acc o
set cc = (select trim(f.ddd) from kl_f3_29 f where f.kf='4A' and f.r020=o.nbs) -- and f.r012=decode(o.sgn, 0 ,f.r012, o.sgn))
where datf = dat_;

-- �������� ������ �� ����������� ������������� � ���������� ����� �� 5
delete from otc_f4a_history_acc
where datf=dat_
  and cc not in ('31','32','33','34','35')
  and NVL(s080,'0')<>'5'; -- and NVL(s280,'0')<>'N' and NVL(s290,'0')<>'N';

-- �������� ������ ����������� ������������� � ����� ����� �� 4
if Dat_ <= to_date('30112012','ddmmyyyy') then
   delete from otc_f4a_history_acc
   where datf=dat_
     and cc in ('31','32','33','34','35')
     and NVL(s080,'0') <> '4'; -- and NVL(s280,'0')<>'N' and NVL(s290,'0')<>'N';
else
   delete from otc_f4a_history_acc
   where datf=dat_
     and cc in ('31','32','33','34','35')
     and NVL(s080,'0') <> '5'; -- and NVL(s280,'0')<>'N' and NVL(s290,'0')<>'N';
end if;

-- ���������� ���� S280 ��� ������ ���.�������������
update otc_f4a_history_acc o
set s280 = 'N'
where datf = dat_
  and cc in ('31','32','33','34','35');

-- ���������� ���� S290 ��� ������ ���.�������������
update otc_f4a_history_acc o
set s290 = 'N'
where datf = dat_
  and cc in ('36');

-- ���������� �������� �� ������ ����������� �������������
begin
   insert into tmp_file03
                (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK)
   select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK
    from (
        select decode(a.dk, 0, a.acc, b.acc) accd, a.tt, a.ref, a.kv,
            decode(a.dk, 0, a.nls, d.nls) nlsd, a.s, a.sq, a.fdat,
            c.nazn, decode(a.dk, 1, a.acc, b.acc) acck,
             decode(a.dk, 1, a.nls, d.nls) nlsk
        from (select /*+parallel(o1) */
                    o1.fdat, o1.ref, o1.stmt, o1.dk, o1.tt,
                    o1.acc, o1.s / 100 s, o1.sq / 100 sq, a.nls, a.kv
                from opldok o1, accounts a
                where o1.fdat between datb_ and dat_ and
                    o1.acc in (select acc from otc_f4a_history_acc where datf=datp_) and
                    o1.acc = a.acc and
                    o1.sos >= 4) a, opldok b, accounts d, oper c
        where a.ref = b.ref and
            a.stmt = b.stmt and
            a.dk <> b.dk and
            b.acc = d.acc and
            a.ref = c.ref and
            c.sos = 5)
      group by ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK;
end;

delete from tmp_file03
where (nlsd like '20_9%' or nlsd like '21_9%' or nlsd like '22_9%')
  and substr(nlsk,1,4) in ('2607','2627','2657');


logger.info ('P_F4A_NN: END Part5 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

update otc_f4a_history_acc o
set cc = decode(r011,'2',27,'3',28,cc)
where nls like '3108%' and datf = dat_;

update otc_f4a_history_acc o
set cc = decode(r011,'4',21,'5',22,cc)
where substr(nls,1,4) in ('1416','1417','1418','1419','1426','1427','1428','1429') and datf = dat_;

update otc_f4a_history_acc o
set cc = decode(r011,'3',21,'4',21,'5',22,cc)
where substr(nls,1,4) in ('3116','3117','3118','3119','3216','3217','3218','3219') and datf = dat_;

commit;

-- ������������ ���� 03 ����� ������i��� �������������i
begin
   for k in (select * from otc_f4a_history_acc
             where datf=dat_
               and ost <> 0
            )
   loop

      IF typ_>0 THEN
         nbuc_ := NVL(F_Codobl_Tobo(k.acc,typ_),nbuc1_);
      ELSE
         nbuc_ := nbuc1_;
      END IF;

      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid, isp, acc)
      values (k.nls, k.kv, dat_, '03' || NVL(k.cc,'00') || to_char(k.prinsider) ||
                     lpad(k.kv,3,'0'),
                     decode(k.kv,980,to_char(0-k.ost),to_char(0-k.ostq)),  -- �������
                     (case substr(k.nd,1,1) when '�' then null when '-' then k.nd else k.nd end),
                     k.rnk,
                     nvl(k.nkd, k.nd),
                     nbuc_,
                     userid_,
                     k.isp,
                     k.acc );
   end loop;
end;

logger.info ('P_F4A_NN: END Part6 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

-- ������������ ���� 04 ����� ������i��� �������������i �� ���� i��� ����������� ����i� �i���� 180 ��i�
begin
   for k in (select * from otc_f4a_history_acc
             where datf=dat_
               and ost <> 0
               and (NVL(s280,'0')='N' or NVL(s290,'0')='N') )
   loop

      IF typ_>0 THEN
         nbuc_ := NVL(F_Codobl_Tobo(k.acc,typ_),nbuc1_);
      ELSE
         nbuc_ := nbuc1_;
      END IF;

      if Dat_ <= to_date('30112012','ddmmyyyy') then
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid, isp, acc)
         values (k.nls, k.kv, dat_, '04' || NVL(k.cc,'00') || to_char(k.prinsider) ||
                        lpad(k.kv,3,'0'),
                        decode(k.kv,980,to_char(0-k.ost),to_char(0-k.ostq)),  -- �������
                        (case substr(k.nd,1,1) when '�' then null when '-' then k.nd else k.nd end),
                        k.rnk,
                        nvl(k.nkd, k.nd),
                        nbuc_,
                        userid_,
                        k.isp,
                        k.acc );
      end if;

      if Dat_ > to_date('30112012','ddmmyyyy') then

         if (k.nbs like '___8%' or k.nbs like '___9%' or k.nbs in ('2607','2627','2657','3570'))
            and k.nbs not in ('1819','2809','3548','3519','3559')
         then
            dd_ := '16';
         else
            dd_ := '15';
         end if;

         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid, isp, acc)
         values (k.nls, k.kv, dat_, dd_ || NVL(k.cc,'00') || to_char(k.prinsider) ||
                        lpad(k.kv,3,'0'),
                        decode(k.kv,980,to_char(0-k.ost),to_char(0-k.ostq)),  -- �������
                        (case substr(k.nd,1,1) when '�' then null when '-' then k.nd else k.nd end),
                        k.rnk,
                        nvl(k.nkd, k.nd),
                        nbuc_,
                        userid_,
                        k.isp,
                        k.acc );
      end if;
   end loop;
end;

logger.info ('P_F4A_NN: END Part7 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

-- ������������ ���� 05 ��i������� ������ ������i��� �������������i � ��i����� ���i��i (��i�� �������?� ������)
begin
   for k in (select a.acc, a.nls, a.kv, a.nbs, NVL(a.cc,'00') cc, NVL(0-a.ostq,0) ostq,
                    a.nkd, a.nd, a.prinsider, a.rnk, a.isp
             from otc_f4a_history_acc a
             where a.datf=dat_
               and not exists (select /*+index(a1)*/ 1
                               from otc_f4a_history_acc  a1
                               where a1.acc=a.acc
                                 and a1.datf=datp_)
               and a.ost <> 0
               and not exists ( select 1
                                from tmp_file03 t
                                where t.accd = a.acc
                                  and substr(t.nlsd,1,3) like substr(t.nlsk,1,3) ||'%'
                                  and exists ( select /*+index(a2)*/ 1
                                               from otc_f4a_history_acc  a2
                                               where a2.acc = t.acck
                                                 and a2.datf=datp_
                                             )
                              )
            )
   loop

      IF typ_>0 THEN
         nbuc_ := NVL(F_Codobl_Tobo(k.acc,typ_),nbuc1_);
      ELSE
         nbuc_ := nbuc1_;
      END IF;

      comm_ := '��i�� �������i� ������';

      if Dat_ <= to_date('30112012','ddmmyyyy') then
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, nbuc, userid, isp, acc, comm)
         values (k.nls, k.kv, dat_, '05' || NVL(k.cc,'00') || to_char(k.prinsider) ||
                        lpad(k.kv,3,'0'),
                        to_char(k.ostq),  -- �������
                        (case substr(k.nd,1,1) when '�' then null when '-' then k.nd else k.nd end),
                        k.rnk,
                        nbuc_,
                        userid_,
                        k.isp,
                        k.acc,
                        comm_);
      end if;

      if Dat_ > to_date('30112012','ddmmyyyy') then
         if (k.nbs like '___8%' or k.nbs like '___9%' or k.nbs in ('2607','2627','2657'))
            and k.nbs not in ('1819','2809','3548','3519','3559')
         then
            dd_ := '12';
         else
            dd_ := '06';
         end if;

         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, nbuc, userid, isp, acc, comm)
         values (k.nls, k.kv, dat_, dd_ || NVL(k.cc,'00') || to_char(k.prinsider) ||
                        lpad(k.kv,3,'0'),
                        to_char(k.ostq),  -- �������
                        (case substr(k.nd,1,1) when '�' then null when '-' then k.nd else k.nd end),
                        k.rnk,
                        nbuc_,
                        userid_,
                        k.isp,
                        k.acc,
                        nvl(k.nkd, k.nd));  --comm_
      end if;

   end loop;
end;

logger.info ('P_F4A_NN: END Part8 for datf = '||to_char(dat_, 'dd/mm/yyyy'));


-- ��i������� ������ ��� 06 ��� 12
-- �� ������� ���������i�
begin
   for k in (select a.acc, a.nls, a.kv, a.nbs, NVL(a.cc,'00') cc, o.nlsk nlsk,
                 a.nkd, a.nd, a.prinsider, a.rnk, a.isp,
                 NVL(sum(gl.p_icurval(o.kv, o.s*100, o.fdat /*dat_*/)), 0) dos
          from accounts s, saldoa sa, tmp_file03 o, otc_f4a_history_acc a
          where a.datf = Datp_
            and s.acc = o.accd
            and s.acc = sa.acc(+)
            and sa.dos > 0
            and sa.fdat = o.fdat
            and substr(o.nlsd,1,3) not like substr(o.nlsk,1,3) ||'%'
            and o.accd = a.acc
            and ((o.fdat between datb_ and Dat_
                 and o.tt not in ('096', 'ZG8', 'ZG9'))
             or (o.fdat between Dat_+1 and Dat_+28
                 and o.tt in ('096', 'ZG8', 'ZG9')))
          group by a.acc, a.nls, a.kv, a.nbs, NVL(a.cc,'00'), o.nlsk,
                   a.nkd, a.nd, a.prinsider, a.rnk, a.isp)
   loop
      IF typ_>0 THEN
         nbuc_ := NVL(F_Codobl_Tobo(k.acc,typ_),nbuc1_);
      ELSE
         nbuc_ := nbuc1_;
      END IF;

      if Dat_ <= to_date('30112012','ddmmyyyy') then
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid, isp, acc)
         values (k.nls, k.kv, dat_, '05' || NVL(k.cc,'00') || to_char(k.prinsider) || lpad(k.kv,3,'0'),
                        to_char(k.dos),  -- ��i������� ������
                        (case substr(k.nd,1,1) when '�' then null when '-' then k.nd else k.nd end),
                        k.rnk,
                        nvl(k.nkd, k.nd),
                        nbuc_,
                        userid_,
                        k.isp,
                        k.acc );
      end if;

      if Dat_ > to_date('30112012','ddmmyyyy') then
         if (k.nbs like '___8%' or k.nbs like '___9%' or k.nbs in ('2607','2627','2657'))
            and k.nbs not in ('1819','2809','3548','3519','3559')
         then
            dd_ := '12';
         else
            dd_ := '06';
         end if;

         if substr(k.nls,1,4) not in ('2600','2605','2620','2625','2650','2655')
         then

            BEGIN
               INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid, isp, acc)
               values (k.nls, k.kv, dat_, dd_ || NVL(k.cc,'00') || to_char(k.prinsider) || lpad(k.kv,3,'0'),
                        to_char(k.dos),  -- ��i������� ������
                        (case substr(k.nd,1,1) when '�' then null when '-' then k.nd else k.nd end),
                        k.rnk,
                        nvl(k.nkd, k.nd),
                        nbuc_,
                        userid_,
                        k.isp,
                        k.acc );
            EXCEPTION WHEN OTHERS THEN
               null;
            END;
         end if;

      end if;

   end loop;
end;

-- ��i������� ������ ��� 06
-- ������� ���������i�
kol_ := 0;
begin
   for k in (select a.acc, a.nls, a.kv, a.nbs, NVL(a.cc,'00') cc, o.nlsk nlsk,
                 a.nkd, a.nd, a.prinsider, a.rnk, a.isp,
                 o.fdat, sa.ostf ost, sa.dos, sa.kos, o.s*100 sump
             from accounts s, saldoa sa, tmp_file03 o, otc_f4a_history_acc a
             where a.datf = Datp_
               and s.acc = o.accd
               and s.acc = sa.acc(+)
               and sa.dos > 0
               and sa.fdat = o.fdat
               --and substr(o.nlsd,1,3) not like substr(o.nlsk,1,3) ||'%'
               and o.nlsk not like substr(o.nlsd,1,3) ||'7_'||substr(o.nlsd,6)||'%'
               and o.accd = a.acc
               and ((o.fdat between datb_ and Dat_
                    and o.tt not in ('096', 'ZG8', 'ZG9'))
                or (o.fdat between Dat_+1 and Dat_+28
                    and o.tt in ('096', 'ZG8', 'ZG9')))
            )
   loop

      IF typ_>0 THEN
         nbuc_ := NVL(F_Codobl_Tobo(k.acc,typ_),nbuc1_);
      ELSE
         nbuc_ := nbuc1_;
      END IF;

      kol_ := kol_ + 1;
      if kol_ = 1 then
         ostq_ := k.ost - k.dos + k.kos;
      end if;

      if Dat_ <= to_date('30112012','ddmmyyyy') then

         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid, isp, acc)
         values (k.nls, k.kv, dat_, '05' || NVL(k.cc,'00') || to_char(k.prinsider) || lpad(k.kv,3,'0'),
                        to_char(k.dos),  -- ��i������� ������
                        (case substr(k.nd,1,1) when '�' then null when '-' then k.nd else k.nd end),
                        k.rnk,
                        nvl(k.nkd, k.nd),
                        nbuc_,
                        userid_,
                        k.isp,
                        k.acc );
      end if;

      if Dat_ > to_date('30112012','ddmmyyyy') then

         if (k.nbs like '___8%' or k.nbs like '___9%' or k.nbs in ('2607','2627','2657'))
            and k.nbs not in ('1819','2809','3548','3519','3559')
         then
            dd_ := '12';
         else
            dd_ := '06';
         end if;

         if substr(k.nls,1,4) in ('2600','2605','2620','2625','2650','2655') and
              ((k.ost < 0 and k.ost - k.dos + k.kos < 0) or -- and ABS(k.ost - k.dos + k.kos) > ABS(k.ost) ) or
               (k.ost >= 0 and k.ost - k.dos + k.kos < 0 ))
         then

            if k.ost < 0 and k.ost - k.dos + k.kos < 0 and k.dos <> 0
               --and ABS(k.ost - k.dos + k.kos) > ABS(k.ost)
            then
               --znap_ := to_char(NVL(gl.p_icurval(k.kv, ABS(k.ost - k.dos + k.kos) - ABS(k.ost), dat_ /*k.fdat*/), 0));
               znap_ := to_char(NVL(gl.p_icurval(k.kv, k.sump, dat_), 0));
            end if;

            if k.ost >= 0 and k.ost - k.dos + k.kos < 0 then
               --znap_ := to_char(NVL(gl.p_icurval(k.kv, k.ost - k.dos + k.kos, dat_ /*k.fdat*/), 0));
               if ostq_ <> 0 then
                  znap_ := to_char(LEAST(ABS(ostq_), k.sump));
                  ostq_ := ostq_ + LEAST(ABS(ostq_), k.sump);
               end if;
            end if;

            BEGIN
               INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid, isp, acc)
               values (k.nls, k.kv, k.fdat/*dat_*/, dd_ || NVL(k.cc,'00') || to_char(k.prinsider) || lpad(k.kv,3,'0'),
                        znap_,  --to_char(k.dos),  -- ��i������� ������
                        (case substr(k.nd,1,1) when '�' then null when '-' then k.nd else k.nd end),
                        k.rnk,
                        nvl(k.nkd, k.nd),
                        nbuc_,
                        userid_,
                        k.isp,
                        k.acc );
            EXCEPTION WHEN OTHERS THEN
               null;
            END;
         end if;

      end if;

   end loop;
end;

-- ������������ ���� 07 ��������� ������ ������i��� �������������i � ������ �i ��������� �� ������� �������
-- ��� ������ �� ������� ��� ������� � ���������� ������ � ��� � �������
-- ������ ������� ��������� ����������� � ������� � ���������� �� �����������
for k in (select a.acc, a.nls, a.kv, NVL(a.cc,'00') cc,
                 a.nkd, a.nd, a.prinsider, a.rnk, a.isp,
                 NVL(sum(gl.p_icurval(o.kv, o.s*100, o.fdat /*dat_*/)), 0) kos
          from accounts s, saldoa sa, tmp_file03 o, otc_f4a_history_acc a
          where a.datf = Datp_
            and s.acc = o.accd
            and s.nbs in ('1590','1592','2400','2401','2890',
                          '3190','3191','3590','3599')
            and s.acc = sa.acc(+)
            and sa.dos > 0
            and sa.fdat = o.fdat
            and o.acck = a.acc
            and ((o.fdat between datb_ and Dat_
                 and o.tt not in ('096', 'ZG8', 'ZG9'))
             or (o.fdat between Dat_+1 and Dat_+28
                 and o.tt in ('096', 'ZG8', 'ZG9')))
          group by a.acc, a.nls, a.kv, NVL(a.cc,'00'),
                   a.nkd, a.nd, a.prinsider, a.rnk, a.isp)
loop

   BEGIN
      if k.kos <> 0 then

         IF typ_>0 THEN
            nbuc_ := NVL(F_Codobl_Tobo(k.acc,typ_),nbuc1_);
         ELSE
            nbuc_ := nbuc1_;
         END IF;

         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid, isp, acc)
         values (k.nls, k.kv, dat_, '07' || NVL(k.cc,'00') || to_char(k.prinsider) || lpad(k.kv,3,'0'),
                        to_char(k.kos),  -- ���������
                        (case substr(k.nd,1,1) when '�' then null when '-' then k.nd else k.nd end),
                        k.rnk,
                        nvl(k.nkd, k.nd),
                        nbuc_,
                        userid_,
                        k.isp,
                        k.acc );
      end if;
   EXCEPTION WHEN OTHERS THEN
      null;
   END;
end loop;

-- ������������ ���� 08 ��������� ������ ������i��� �������������i � ������ i� ����������
-- ��� ������ �� ������� ��� ������� � ���������� ������ � ��� � �������
-- �� ����� �����������
for k in (select a.acc, a.nls, a.kv, NVL(a.cc,'00') cc, o.nlsk nlsk,
                 a.nkd, a.nd, a.prinsider, a.rnk, a.isp,
                 NVL(sum(gl.p_icurval(o.kv, o.s*100, o.fdat /*dat_*/)), 0) kos
          from accounts s, saldoa sa, tmp_file03 o, otc_f4a_history_acc a
          where a.datf = Datp_
            and s.acc = o.accd
            and ( (s.nbs not in ('1590','1592','2400','2401','3190','3191','3590','3599','2909')) or
                  (s.nbs like '2909%' and LOWER(o.nazn) not like '%�_���%' and LOWER(o.nazn) not like '%������%')
                )
            and o.acck = sa.acc(+)
            and sa.kos > 0
            and sa.fdat = o.fdat
            and substr(o.nlsd,1,3) not like substr(o.nlsk,1,3) ||'%'
            and o.acck = a.acc
            and ((o.fdat between datb_ and Dat_
                 and o.tt not in ('096', 'ZG8', 'ZG9'))
             or (o.fdat between Dat_+1 and Dat_+28
                 and o.tt in ('096', 'ZG8', 'ZG9')))
          group by a.acc, a.nls, a.kv, NVL(a.cc,'00'), o.nlsk,
                   a.nkd, a.nd, a.prinsider, a.rnk, a.isp)
loop
   IF typ_>0 THEN
      nbuc_ := NVL(F_Codobl_Tobo(k.acc,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   if substr(k.nlsk,1,4) not in ('2600','2605','2607',
                                 '2620','2625','2627',
                                 '2650','2655','2657')
      and k.kos <> 0 then
      BEGIN
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid, isp, acc)
         values (k.nls, k.kv, dat_, '08' || NVL(k.cc,'00') || to_char(k.prinsider) || lpad(k.kv,3,'0'),
                        to_char(k.kos),  -- ���������
                        (case substr(k.nd,1,1) when '�' then null when '-' then k.nd else k.nd end),
                        k.rnk,
                        nvl(k.nkd, k.nd),
                        nbuc_,
                        userid_,
                        k.isp,
                        k.acc );
      EXCEPTION WHEN OTHERS THEN
         null;
      END;
   end if;
end loop;

-- ������������ ���� 08 ��������� ������ ������i��� �������������i � ������ i� ����������
-- ��� ������ �� ������� ��� ������� � ���������� ������ � ��� � �������
-- ����� �����������
for k in (select distinct a.acc, a.nls, a.kv, NVL(a.cc,'00') cc,
                 o.nlsd nlsd, o.nlsk nlsk,
                 a.nkd, a.nd, a.prinsider, a.rnk, a.isp,
                 o.fdat, sa.ostf ost, sa.dos, sa.kos
          from accounts s, saldoa sa, tmp_file03 o, otc_f4a_history_acc a
          where a.datf = Datp_
            and s.acc = o.accd
            and s.nbs not in ('1590','1592','2400','2401','3190','3191','3590','3599')
            and o.acck = sa.acc(+)
            and sa.kos > 0
            and sa.fdat = o.fdat
            and ( (substr(o.nlsd,1,3) not like substr(o.nlsk,1,3) ||'%') or
                  (substr(o.nlsd,1,3)='260' and substr(o.nlsk,1,3)='260')
                )
            and o.acck = a.acc
            and ((o.fdat between datb_ and Dat_
                 and o.tt not in ('096', 'ZG8', 'ZG9'))
             or (o.fdat between Dat_+1 and Dat_+28
                 and o.tt in ('096', 'ZG8', 'ZG9'))) )
loop

   IF typ_>0 THEN
      nbuc_ := NVL(F_Codobl_Tobo(k.acc,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   if k.nlsd like '2__9%' and substr(k.nlsk,1,4) in ('2607','2627','2757')
   then
      dd_ := '11';
   else
      dd_ := '08';
   end if;

   if substr(k.nlsk,1,4) in ('2600','2605','2607','2620','2625','2627',
                             '2650','2655','2657') and
      ((k.ost < 0 and  k.ost - k.dos + k.kos >= 0) or
       (k.ost < 0 and k.ost - k.dos - k.kos < 0 and k.kos <> 0)) then

      if k.ost < 0 and k.ost - k.dos + k.kos >= 0 then
         znap_ := to_char(0 - NVL(gl.p_icurval(k.kv, k.ost, dat_ /*k.fdat*/), 0));
      end if;
      if k.ost < 0 and k.ost - k.dos + k.kos <= 0 and k.kos <> 0 then
         znap_ := to_char(NVL(gl.p_icurval(k.kv, k.kos, dat_ /*k.fdat*/), 0));
      end if;
      BEGIN
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid, isp, acc)
         values (k.nls, k.kv, k.fdat, dd_ || NVL(k.cc,'00') || to_char(k.prinsider) || lpad(k.kv,3,'0'),
                        znap_,   -- ���������
                        (case substr(k.nd,1,1) when '�' then null when '-' then k.nd else k.nd end),
                        k.rnk,
                        nvl(k.nkd, k.nd),
                        nbuc_,
                        userid_,
                        k.isp,
                        k.acc );
      EXCEPTION WHEN OTHERS THEN
         null;
      END;
   end if;
end loop;

-- ������������ ���� 10 ��������� ������ ������i��� �������������i � ������ i� ��������
-- �� ����� �����������
for k in (select a.acc, a.nls, a.kv, NVL(a.cc,'00') cc, o.nlsk nlsk,
                 a.nkd, a.nd, a.prinsider, a.rnk, a.isp,
                 NVL(sum(gl.p_icurval(o.kv, o.s*100, o.fdat /*dat_*/)), 0) kos
          from accounts s, saldoa sa, tmp_file03 o, otc_f4a_history_acc a
          where a.datf = Datp_
            and s.acc = o.accd
            and s.nbs = '2909'
            and (LOWER(o.nazn) like '%�_���%' or LOWER(o.nazn) like '%������%')
            and o.acck = sa.acc(+)
            and sa.kos > 0
            and sa.fdat = o.fdat
            and substr(o.nlsd,1,3) not like substr(o.nlsk,1,3) ||'%'
            and o.acck = a.acc
            and ((o.fdat between datb_ and Dat_
                 and o.tt not in ('096', 'ZG8', 'ZG9'))
             or (o.fdat between Dat_+1 and Dat_+28
                 and o.tt in ('096', 'ZG8', 'ZG9')))
          group by a.acc, a.nls, a.kv, NVL(a.cc,'00'), o.nlsk,
                   a.nkd, a.nd, a.prinsider, a.rnk, a.isp)
loop
   IF typ_>0 THEN
      nbuc_ := NVL(F_Codobl_Tobo(k.acc,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   if substr(k.nlsk,1,4) not in ('2600','2605','2620','2625','2650','2655') and k.kos <> 0 then
      BEGIN
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid, isp, acc)
         values (k.nls, k.kv, dat_, '10' || NVL(k.cc,'00') || to_char(k.prinsider) || lpad(k.kv,3,'0'),
                        to_char(k.kos),  -- ������ �������
                        (case substr(k.nd,1,1) when '�' then null when '-' then k.nd else k.nd end),
                        k.rnk,
                        nvl(k.nkd, k.nd),
                        nbuc_,
                        userid_,
                        k.isp,
                        k.acc );
      EXCEPTION WHEN OTHERS THEN
         null;
      END;
   end if;
end loop;


logger.info ('P_F4A_NN: END Part9 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

-- ���� ��� ������������ �������� �� ������������ ��.��� + �� ����. - ��.����. = ���.���.
-- ��� ������ ����������� � ������������ ���������
begin
   for k in (select NULL acc, nls,
                    kv, cc, prinsider,
                    nd, rnk, nbuc,
                    sum(ost) ost, sum(dos) dos, sum(kos) kos, sum(vost) vost
             from
                (select
                 NULL acc, '___8' nls,
                 r.kv, substr(r.kodp,3,2) cc, substr(r.kodp,5,1) prinsider,
                 NVL(trim(to_char(r.nd)),trim(r.comm)) nd, r.rnk, r.nbuc,  --r.isp,
                 NVL(SUM(decode(substr(r.kodp,1,2),'03',1,0)*to_number(r.znap)),0) ost,
                 NVL(SUM(decode(substr(r.kodp,1,2),'05',1,'12',1,0)*to_number(r.znap)),0) dos,
                 NVL(SUM(decode(substr(r.kodp,1,2),'07',1,'08',1,'09',1,'10',1,'11',1,0)*to_number(r.znap)),0) kos,
                 0  vost
                 from rnbu_trace r
                 where (substr(r.nls,1,4) like '___8%' or substr(r.nls,1,4) like '___9%' or
                        substr(r.nls,1,4) in ('2607','2627','2657'))
                   and substr(r.nls,1,4) not in ('1819','2809','3548','3519','3559')
                   and r.kv <> 0
                   and substr(r.kodp,1,2) in ('03','05','12','07','08','09','10','11')
                   and not exists (select 1
                                   from otc_f4a_history_acc a
                                   where a.acc = r.acc
                                     and a.datf=datp_ )
                 group by '___8', r.kv,
                          substr(r.kodp,3,2), substr(r.kodp,5,1),
                          NVL(trim(to_char(r.nd)),trim(r.comm)), r.rnk, r.nbuc  --, r.isp
                UNION
                select
                NULL acc, '___8' nls,
                r.kv, substr(r.kodp,3,2) cc, substr(r.kodp,5,1) prinsider,
                NVL(trim(to_char(r.nd)),trim(r.comm)) nd, r.rnk, r.nbuc,
                NVL(SUM(decode(substr(r.kodp,1,2),'03',1,0)*to_number(r.znap)),0) ost,
                NVL(SUM(decode(substr(r.kodp,1,2),'05',1,'12',1,0)*to_number(r.znap)),0) dos,
                NVL(SUM(decode(substr(r.kodp,1,2),'07',1,'08',1,'09',1,'10',1,'11',1,0)*to_number(r.znap)),0) kos,
                0 vost
                from rnbu_trace r, otc_f4a_history_acc a
                where (substr(r.nls,1,4) like '___8%' or substr(r.nls,1,4) like '___9%' or
                        substr(r.nls,1,4) in ('2607','2627','2657'))
                  and substr(r.nls,1,4) not in ('1819','2809','3548','3519','3559')
                  and r.kv <> 0
                  and substr(r.kodp,1,2) in ('03','05','12','07','08','09','10','11')
                  and r.acc = a.acc
                  and a.datf=datp_
                group by '___8',  --r.acc, r.nls,
                      r.kv,
                      substr(r.kodp,3,2), substr(r.kodp,5,1),
                      NVL(trim(to_char(r.nd)),trim(r.comm)), r.rnk, r.nbuc  --, r.isp
                UNION
                select
                NULL acc, '___8' nls,
                a.kv, a.cc, to_char(a.prinsider),
                a.nd, a.rnk, decode(typ_, 0, nbuc1_, f_codobl_tobo(a.acc, typ_) ) nbuc,
                0 ost,
                0 dos,
                0 kos,
                NVL(SUM(0-a.ostq),0) vost
                from  otc_f4a_history_acc a
                where (substr(a.nls,1,4) like '___8%' or substr(a.nls,1,4) like '___9%' or
                        substr(a.nls,1,4) in ('2607','2627','2657'))
                  and substr(a.nls,1,4) not in ('1819','2809','3548','3519','3559')
                  and a.kv <> 0
                  and a.datf=datp_
                  and exists (select 1 from rnbu_trace r where r.acc=a.acc)
                 group by '___8', a.kv,
                          a.cc, a.prinsider,
                          a.nd, a.rnk,
                          decode(typ_, 0, nbuc1_, f_codobl_tobo(a.acc, typ_) )
                UNION
                select
                NULL acc, '___8' nls,
                a.kv, NVl(a.cc, trim(kl.ddd)), decode(a.prinsider,2,'2','1') prinsider,
                a.nd nd, a.rnk,
                decode(typ_, 0, nbuc1_, f_codobl_tobo(a.acc, typ_) ) nbuc,
                0 ost,
                0 dos,
                0 kos,
                NVL(SUM(0-a.ostq),0) vost
                from  otc_f4a_history_acc a, kl_f3_29 kl
                where (substr(a.nls,1,4) like '___8%' or substr(a.nls,1,4) like '___9%' or
                        substr(a.nls,1,4) in ('2607','2627','2657'))
                  and substr(a.nls,1,4) not in ('1819','2809','3548','3519','3559')
                  and a.kv <> 0
                  and a.datf=datp_
                  and kl.kf = '4A'
                  and a.nbs = kl.r020
                  and not exists (select 1
                                  from rnbu_trace r
                                  where r.acc = a.acc )
                 group by '___8', a.kv,
                          NVL(a.cc, trim(kl.ddd)), decode(a.prinsider,2,'2','1'),
                          a.nd, a.rnk,
                          decode(typ_, 0, nbuc1_, f_codobl_tobo(a.acc, typ_) )
                )
             group by nls, kv, cc, prinsider,
                      nd, rnk, nbuc
            )
   loop
      BEGIN
         select max(acc)
            into acc_
         from otc_f4a_history_acc
         where datf >= datp_
           and (substr(nls,4,1) in ('8','9') or
                substr(nls,1,4) in ('2607','2627','2657'))
           and substr(nls,1,4) not in ('1819','2809','3548','3519','3559')
           and rnk=k.rnk
           and kv=k.kv
           and cc=k.cc
           and nd=k.nd
           and rownum = 1
         group by acc, rnk, kv, nd;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         BEGIN
            select max(acc)
               into acc_
            from otc_f4a_history_acc
            where datf >= datp_
              and (substr(nls,4,1) in ('8','9') or
                   substr(nls,1,4) in ('2607','2627','2657'))
              and substr(nls,1,4) not in ('1819','2809','3548','3519','3559')
              and rnk=k.rnk
              and kv=k.kv
              and cc=k.cc
              and rownum = 1
            group by acc, rnk, kv;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            null;
         END;
      END;

      IF typ_>0 THEN
         nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
      ELSE
         nbuc_ := nbuc1_;
      END IF;


      if (k.vost+k.dos-k.kos) < (k.ost) then

         if Dat_ <= to_date('30112012','ddmmyyyy') then

            comm_ := '����������� ������i� ' || to_char(ABS(k.ost - (k.vost+k.dos-k.kos))) || ' ND=' || k.nd;
            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, nbuc, userid, isp, acc, comm)
            values (k.nls, k.kv, dat_, '05' || NVL(k.cc,'00') || to_char(k.prinsider) || lpad(to_char(k.kv),3,'0'),
                           to_char(ABS(k.ost - (k.vost+k.dos-k.kos))) ,   -- ����������
                           0,
                           k.rnk,
                           nbuc_,
                           userid_,
                           0,
                           k.acc,
                           comm_ );
         end if;

         if Dat_ > to_date('30112012','ddmmyyyy') then

            dd_ := '12';

            comm_ := '����������� ������i� ' || to_char(ABS(k.ost - (k.vost+k.dos-k.kos))) || ' ND=' || k.nd;
            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, nbuc, userid, isp, acc, comm)
            values (k.nls, k.kv, dat_, dd_ || NVL(k.cc,'00') || to_char(k.prinsider) || lpad(to_char(k.kv),3,'0'),
                           to_char(ABS(k.ost - (k.vost+k.dos-k.kos))) ,   -- ����������
                           0,
                           k.rnk,
                           nbuc_,
                           userid_,
                           0,
                           k.acc,
                           comm_ );
         end if;

      end if;

      if (k.vost+k.dos-k.kos) > (k.ost) then
         comm_ := '����������� ������i� ' || to_char(ABS((k.vost+k.dos-k.kos) - k.ost)) || ' ND=' || k.nd;
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, nbuc, userid, isp, acc, comm)
         values (k.nls, k.kv, dat_, '11' || NVL(k.cc,'00') || to_char(k.prinsider) || lpad(to_char(k.kv),3,'0'),
                        to_char(ABS((k.vost+k.dos-k.kos) - k.ost)) ,   -- ����������
                        0,
                        k.rnk,
                        nbuc_,
                        userid_,
                        0,
                        k.acc,
                        comm_ );
      end if;
   end loop;
end;


-- ���� ��� ������������ �������� �� ������������ ��.��� + �� ����. - ��.����. = ���.���.
-- ��� �������� ������ (����� ������ ����������� � ������������ ���������)
begin
   for k in (select NULL acc, nls,
                    kv, cc, prinsider,
                    nd, rnk, nbuc,
                    sum(ost) ost, sum(dos) dos, sum(kos) kos, sum(vost) vost
             from
                (select
                 NULL acc, '___1' nls,
                 r.kv, substr(r.kodp,3,2) cc, substr(r.kodp,5,1) prinsider,
                 NVL(trim(to_char(r.nd)),trim(r.comm)) nd, r.rnk, r.nbuc, --r.isp,
                 NVL(SUM(decode(substr(r.kodp,1,2),'03',1,0)*to_number(r.znap)),0) ost,
                 NVL(SUM(decode(substr(r.kodp,1,2),'05',1,'06',1,0)*to_number(r.znap)),0) dos,
                 NVL(SUM(decode(substr(r.kodp,1,2),'07',1,'08',1,'09',1,'10',1,'11',1,0)*to_number(r.znap)),0) kos,
                 0  vost
                 from rnbu_trace r
                 where ( (substr(r.nls,1,4) not like '___8%' and
                          substr(r.nls,1,4) not like '___9%' and
                          substr(r.nls,1,4) not in ('2607','2627','2657') ) or
                          substr(r.nls,1,4) in ('1819','2809','3548','3519','3559')
                       )
                   and r.kv <> 0
                   and substr(r.kodp,1,2) in ('03','05','06','07','08','09','10','11')
                   and not exists (select 1
                                   from otc_f4a_history_acc a
                                   where a.acc = r.acc
                                     and a.datf=datp_ )
                 group by '___1', r.kv,
                          substr(r.kodp,3,2), substr(r.kodp,5,1),
                          NVL(trim(to_char(r.nd)),trim(r.comm)), r.rnk, r.nbuc
                UNION
                select
                NULL acc, '___1' nls,
                r.kv, substr(r.kodp,3,2) cc, substr(r.kodp,5,1) prinsider,
                NVL(trim(to_char(r.nd)),trim(r.comm)) nd, r.rnk, r.nbuc,
                NVL(SUM(decode(substr(r.kodp,1,2),'03',1,0)*to_number(r.znap)),0) ost,
                NVL(SUM(decode(substr(r.kodp,1,2),'05',1,'06',1,0)*to_number(r.znap)),0) dos,
                NVL(SUM(decode(substr(r.kodp,1,2),'07',1,'08',1,'09',1,'10',1,'11',1,0)*to_number(r.znap)),0) kos,
                0 vost
                from rnbu_trace r, otc_f4a_history_acc a
                where ( (substr(r.nls,1,4) not like '___8%' and
                          substr(r.nls,1,4) not like '___9%' and
                          substr(r.nls,1,4) not in ('2607','2627','2657') ) or
                          substr(r.nls,1,4) in ('1819','2809','3548','3519','3559')
                       )
                  and r.kv <> 0
                  and substr(r.kodp,1,2) in ('03','05','06','07','08','09','10','11')
                  and r.acc = a.acc
                  and a.datf=datp_
                group by '___1', r.kv,
                      substr(r.kodp,3,2), substr(r.kodp,5,1),
                      NVL(trim(to_char(r.nd)),trim(r.comm)), r.rnk, r.nbuc  --, r.isp
                UNION
                select
                NULL acc, '___1' nls,
                a.kv, a.cc, to_char(a.prinsider),
                a.nd, a.rnk, decode(typ_, 0, nbuc1_, f_codobl_tobo(a.acc, typ_) ) nbuc,
                0 ost,
                0 dos,
                0 kos,
                NVL(SUM(0-a.ostq),0) vost
                from  otc_f4a_history_acc a
                where ( (substr(a.nls,1,4) not like '___8%' and
                          substr(a.nls,1,4) not like '___9%' and
                          substr(a.nls,1,4) not in ('2607','2627','2657') ) or
                          substr(a.nls,1,4) in ('1819','2809','3548','3519','3559')
                       )
                  and a.kv <> 0
                  and a.datf=datp_
                  and exists (select 1 from rnbu_trace r where r.acc=a.acc)
                 group by '___1', a.kv,
                          a.cc, a.prinsider,
                          a.nd, a.rnk,
                          decode(typ_, 0, nbuc1_, f_codobl_tobo(a.acc, typ_) )
                UNION
                select
                NULL acc, '___1' nls,
                a.kv, NVl(a.cc, trim(kl.ddd)), decode(a.prinsider,2,'2','1') prinsider,
                a.nd nd, a.rnk,
                decode(typ_, 0, nbuc1_, f_codobl_tobo(a.acc, typ_) ) nbuc,
                0 ost,
                0 dos,
                0 kos,
                NVL(SUM(0-a.ostq),0) vost
                from  otc_f4a_history_acc a, kl_f3_29 kl
                where ( (substr(a.nls,1,4) not like '___8%' and
                          substr(a.nls,1,4) not like '___9%' and
                          substr(a.nls,1,4) not in ('2607','2627','2657') ) or
                          substr(a.nls,1,4) in ('1819','2809','3548','3519','3559')
                       )
                  and a.kv <> 0
                  and a.datf=datp_
                  and kl.kf = '4A'
                  and a.nbs = kl.r020
                  and not exists (select 1
                                  from rnbu_trace r
                                  where r.acc = a.acc )
                 group by '___1', a.kv,
                          NVL(a.cc, trim(kl.ddd)), decode(a.prinsider,2,'2','1'),
                          a.nd, a.rnk,
                          decode(typ_, 0, nbuc1_, f_codobl_tobo(a.acc, typ_) )
                )
             group by nls, kv, cc, prinsider,
                      nd, rnk, nbuc  --, isp
            )

   loop
      BEGIN
         select max(acc)
            into acc_
         from otc_f4a_history_acc
         where datf >= datp_
           and ( (substr(nls,4,1) not in ('8','9') and
                  substr(nls,1,4) not in ('2607','2627','2657')) or
                 (substr(nls,1,4) in ('1819','2809','3548','3519','3559'))
               )
           and rnk = k.rnk
           and kv =  k.kv
           and nd =  k.nd
           and rownum = 1
         group by acc, rnk, kv, nd;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         BEGIN
            select max(acc)
               into acc_
            from otc_f4a_history_acc
            where datf >= datp_
              and ( (substr(nls,4,1) not in ('8','9') and
                     substr(nls,1,4) not in ('2607','2627','2657')) or
                    (substr(nls,1,4) in ('1819','2809','3548','3519','3559'))
                  )
              and rnk = k.rnk
              and kv =  k.kv
              and cc=k.cc
              and rownum = 1
            group by acc, rnk, kv, cc;
         EXCEPTION WHEN NO_DATA_FOUND THEN
           null;
         END;
      END;

      IF typ_>0 THEN
         nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
      ELSE
         nbuc_ := nbuc1_;
      END IF;

      if (k.vost+k.dos-k.kos) < (k.ost) then

         if Dat_ <= to_date('30112012','ddmmyyyy') then
            comm_ := '����������� ������i� ' || to_char(ABS(k.ost - (k.vost+k.dos-k.kos))) || ' ND=' || k.nd;
            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, nbuc, userid, isp, acc, comm)
            values (k.nls, k.kv, dat_, '05' || NVL(k.cc,'00') || to_char(k.prinsider) || lpad(k.kv,3,'0'),
                           to_char(ABS(k.ost - (k.vost+k.dos-k.kos))) ,   -- ����������
                           0,
                           k.rnk,
                           nbuc_,
                           userid_,
                           0,
                           k.acc,
                           comm_ );
         end if;

         if Dat_ > to_date('30112012','ddmmyyyy') then
            dd_ := '06';

            comm_ := '����������� ������i� ' || to_char(ABS(k.ost - (k.vost+k.dos-k.kos))) || ' ND=' || k.nd;
            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, nbuc, userid, isp, acc, comm)
            values (k.nls, k.kv, dat_, dd_ || NVL(k.cc,'00') || to_char(k.prinsider) || lpad(k.kv,3,'0'),
                           to_char(ABS(k.ost - (k.vost+k.dos-k.kos))) ,   -- ����������
                           0,
                           k.rnk,
                           nbuc_,
                           userid_,
                           0,
                           k.acc,
                           comm_ );
         end if;

      end if;

      if (k.vost+k.dos-k.kos) > (k.ost) then

         comm_ := '����������� ������i� ' || to_char(ABS((k.vost+k.dos-k.kos) - k.ost)) || ' ND=' || k.nd;
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, nbuc, userid, isp, acc, comm)
         values (k.nls, k.kv, dat_, '11' || NVL(k.cc,'00') || to_char(k.prinsider) || lpad(k.kv,3,'0'),
                        to_char(ABS((k.vost+k.dos-k.kos) - k.ost)) ,   -- ����������
                        0,
                        k.rnk,
                        nbuc_,
                        userid_,
                        0,
                        k.acc,
                        comm_ );
      end if;
   end loop;
end;

logger.info ('P_F4A_NN: END Part10 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

-- ������������ ����� ����� 13,14 ��������� ������ ������i��� �������������i �� �������� ������ i �����.��������
-- ������ ������������� � 01.12.2012 (�� 01.01.2013)
for k in ( select * from rnbu_trace
           where substr(kodp,1,2) in ('07','08','09','10','11')
         )

   loop

      if (k.nls like '___8%' or k.nls like '___9%' or substr(k.nls,1,4) in ('2607','2627','2657'))
         and substr(k.nls,1,4) not in ('1819','2809','3548','3519','3559')
      then
         dd_ := '14';
      else
         dd_ := '13';
      end if;

      BEGIN
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid, isp, acc)
         values (k.nls, k.kv, k.odate, dd_ || substr(k.kodp,3,6),
                         k.znap,   -- ���������
                         k.nd,
                         k.rnk,
                         k.comm,
                         k.nbuc,
                         userid_,
                         k.isp,
                         k.acc );
      EXCEPTION WHEN OTHERS THEN
         null;
      END;

   end loop;
-----------------------------------------------------------------------------
DELETE FROM tmp_nbu where kodf=kodf_ and datf= dat_;
---------------------------------------------------
INSERT INTO tmp_nbu(kodf, datf, kodp, nbuc, znap)
SELECT kodf_, Dat_, kodp, nbuc, SUM(znap)
FROM rnbu_trace
where kodp not like '00%'
GROUP BY kodp, nbuc;

logger.info ('P_F4A_NN: END for datf = '||to_char(dat_, 'dd/mm/yyyy'));
----------------------------------------
p_ch_file4a(kodf_,dat_,userid_);
----------------------------------------
END;
/
show err;

PROMPT *** Create  grants  P_F4A ***
grant EXECUTE                                                                on P_F4A           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F4A           to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F4A.sql =========*** End *** ===
PROMPT ===================================================================================== 
