CREATE OR REPLACE PROCEDURE BARS.p_ff8 (Dat_ DATE) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DESCRIPTION : ��������� ������������ ����� #F8 ��� ��
COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.All Rights Reserved.

VERSION     :   v.18.001    23.01.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
���������: Dat_ - �������� ����

   ��������� ���������    DD CC LL �� � � AA VVV L

 1   DD         {04,05,06,...}            ��� ���������
 3   CC         {11,51,21,31,32,33,38,35} ��� ���� �������
 5   LL         K111 ��� ������i���i �i�������i
 7   ��         S260 ��� i����i��������� ���������� �� �i����
 9   �          S032 ��� ���� ������������
10   �          S080 ��� ��������� �����
11   AA         S270 ��� ����� ��������� ��������� �����
13   VVV        R030 ��� ������
16   L          S245 ������������ ����� ���������

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
23.01.2018  -����� ������� � ����������: L(S245)
               -��������� ������� ������� otc_ff8_history_acc
            -��� �������� CC ����� �������� �� ����������
31/08/2017 - � 26 ���������� ����� ���������� �������� �� �������
             �� ���� �������� �� ���� �������� �������
             � ���������� 20 (���-�� ����) �� ����� ���������� 
             �������� ��� ���� ������ ������ (ND=NDI � ����. CC_DEAL) 
13/07/2017 - � 12 ���������� �� ����� ���������� �������� ���������-
             ���������� � ���������� �������� �������
11/07/2017 - ��� ����������� �������� S080
             ��������� ����� ��������� ��� ������ �� V_TMP_REZ_RISK
             � �������� S080 �� �� SPECPARAM � �� OTC_FF7_HISTORY_ACC
             �� ���������� ���������� ����
10/03/2017 - ����� �����
13/02/2017 - ��� ������������ ����������� 15,16,18 �������� �������
             ��� S080  � S080 in ('4','5') �� S080 in ('Q','J')
10/02/2017 - ��� ��������� ���������������� (VIEW CC_V) ����� ��������
             �������� S080 (�� "A" ��� "M")
07/02/2016 - ��� ��������� S080 ����� ������������ ���� S080 ������ KAT
10/08/2016 - ��� ������ ����������� ��� ���������� ���� "CC" ������� ��
             ����� ����� ���� � ���������
08/08/2016 - ��� ���������� 16 ������� ������� �� f,r013 is not null
             ������ NVL(f.r013,'0') not in ('0','3') ��� ('0','1')
01/08/2016 - ��� ���������� 16 �������� ����� �������
             f.cc like '__1' and f.s270='08' (���� f.s270='1')
             f.cc like '__3' and f.s370='J'  (���� f.s370='J')
09/06/2016 - ��� ������� �� OPLDOK(��) ������� ������� �� ���� FDAT
03/06/2016 - ��� 1502 ������� ���� DOSQ ������ R_DOS �.�. ������ ��
             ����������� � RNBU_HISTORY
12/08/2014 - ��������� �������� ������ BRSMAIN-2645.
             ����������� �������� � ������� ����� �� �������������� ��������
             ����������� ������������ � �������� ������� �� ���������� ���������
             �� �������� �� ��������� ������ ������� ����� ����������� ������� 3600 � 2066
             ��������� ������������� S032 �� �������� ���������, ���������� ��.������
24/09/2013 - ���� � STRU_F8 �� 1508, 1509
06/02/2013 - ��������� �� KL_K110 (���� �������� � �������� ����������)
28/01/2013 - ������������� �� 23 ��������
17/12/2012 - ��������� �� KL_K110
11/10/2012 - ��������� � ������� ����� ����������
13/06/2012 - ����������� ������� ��� ��������� ��������� 12 �� 13 (��
             ���������� 12 �� 13 ��������, ���� �� ����s�� ����� ����
             ������� ����� �� ���� ��� ����������������)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  kodf_       varchar2(2):='F8';
  sheme_      varchar2(1);
  acc_        Number;
  dk_         Varchar2(1);
  nbs_        Varchar2(4);
  nls_        Varchar2(15);
  dd_         Varchar2(3);
  mdate_      Date;
  data_       Date;
  kv_         SMALLINT;
  se_         DECIMAL(24);
  Ostn_       DECIMAL(24);
  Ostq_       DECIMAL(24);
  Dos96_      DECIMAL(24);
  Kos96_      DECIMAL(24);
  Dosq96_     DECIMAL(24);
  Kosq96_     DECIMAL(24);
  Doszg_      DECIMAL(24);
  Koszg_      DECIMAL(24);
  Dos96zg_    DECIMAL(24);
  Kos96zg_    DECIMAL(24);
  Dos99zg_    DECIMAL(24);
  Kos99zg_    DECIMAL(24);
  kodp_       Varchar2(16);
  znap_       Varchar2(30);
  cc_         Varchar(3);
  userid_     Number;
  sql_acc_    varchar2(2000):='';
  ret_        number;
  rnk_        number;
  codcagent_  number;

  nd_         number;
  sdate_      date;
  wdate_      date;
  sos_        number;
  comm_       varchar2(200);
  datp_       date;
  datb_       date;
  datr_       date;

  mfo_        number;
  mfou_       number;
  default_    number;

  typ_        number;
  nbuc_       varchar2(12);
  nbuc1_      varchar2(12);
  flag_       number;
  dat_spr_    date := last_day(dat_)+1;
  s080r_      varchar2(1);

BEGIN
logger.info ('P_FF8: Begin for datf = '||to_char(dat_, 'dd/mm/yyyy'));
-------------------------------------------------------------------
userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_FF8_MIGR_ND';
-------------------------------------------------------------------
sql_acc_ := 'select * from accounts '||
            'where nbs in (select distinct r020 from kl_f3_29 where kf='''||kodf_||''') and '||
            ' acc in (select n.acc from nd_acc n, cck_restr c where n.nd=c.nd and '||
            ' c.fdat<=to_date('''||to_char(dat_,'ddmmyyyy')||''',''ddmmyyyy'') and '||
            ' nvl(c.fdat_end, to_date('''|| to_char(dat_,'ddmmyyyy')||''',''ddmmyyyy'')) '||
            ' >= to_date('''|| to_char(dat_,'ddmmyyyy')||''',''ddmmyyyy'') and pr_no = 1 '||
            ' union all '||
            'select acc from cck_restr_acc c where c.fdat<=to_date('''||
            to_char(dat_,'ddmmyyyy')||''',''ddmmyyyy'') and '||
            ' nvl(c.fdat_end, to_date('''|| to_char(dat_,'ddmmyyyy')||''',''ddmmyyyy'')) '||
            ' >= to_date('''|| to_char(dat_,'ddmmyyyy')||''',''ddmmyyyy'') and pr_no = 1 '||
            ')';

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

if 300120 in (mfo_, mfou_) then
   default_ := 1; -- ��� s260='00', ������������� ��-��������� s260='06'
else
   default_ := 0;
end if;

default_ := 0; --����������� ���������

if 300465 in (mfo_, mfou_) then
   sheme_ := 'C';
else
   sheme_ := 'G';
end if;

datb_ := trunc(dat_,'mm'); -- ���� ������ ������

select max(fdat) -- ������� �������� ����
into datp_
from fdat
where fdat<datb_;

-- ���� ���������� �������
datr_ := last_day(dat_) + 1;

select count(*)
into flag_
from nbu23_rez
where fdat = datr_;

if flag_ = 0 then
   datr_ := add_months(datr_, -1);
end if;

-- ����������� ��������� ���������� (��� ������� ��� ��� ��� �������������)
P_Proc_Set(kodf_,sheme_,nbuc1_,typ_);
nbuc_ := nbuc1_;

ret_ := f_pop_otcn(Dat_, 2, sql_acc_,null, 0, 1);
-------------------------------------------------------------------
delete from otc_ff8_history_acc where datf=dat_;

insert into otc_ff8_history_acc(
       DATF, ACC, ACCC, NBS,
       SGN,
       NLS, KV, NMS, DAOS, DAZS, OST,
       OSTQ,
       ND, NKD,
       SDATE, WDATE, SOS, RNK, STAFF, TOBO, s260, k110, s031, s080, s270,
       tip, r011, r013, s370, sum_r013_1, s245)
select dat_, s.acc, o.accc, substr(o.nls,1,4),
       decode(sign(s.ost-s.dos96+s.kos96),-1,'1','2'),
       o.nls, o.kv, o.nms, o.daos, o.dazs, s.ost-s.dos96+s.kos96 ost,
       decode(o.kv, 980, s.ost-s.dos96+s.kos96, s.ostq-s.dosq96+s.kosq96) ostq,
       nvl(c.nd, -s.acc) nd, trim(p.nkd), -- ���� ���� ND, �� ����������� ACC
       c.sdate, c.wdate, c.sos, s.rnk, userid_, o.tobo,
       f_get_s260(c.nd, s.acc, p.s260, s.rnk, o.nbs, default_) s260,
       z.ved, p.s031, nvl(p.s080,0), p.s270,
       o.tip, nvl(trim(p.r011), '0'), nvl(trim(p.r013), '0'), nvl(trim(p.s370), '0'), 0, '1'
from   OTCN_SALDO        s,
       OTCN_ACC          o,
       (select a.acc, a.nd, b.sdate, b.wdate, b.sos
        from   (select n.acc, max(n.nd) nd
                from   nd_acc n, cc_deal c
                where  n.nd=c.nd and
                       c.sdate <= dat_ and
                       c.VIDD <> 26 -- ������� ������������ �������
                group by n.acc) a, cc_deal b
        where a.nd=b.nd) c,
       specparam         p,
       customer          z
where  (s.ost-s.dos96+s.kos96)<>0 and
       s.acc=o.acc                and
       (substr(o.nls,1,4),decode(sign(s.ost-s.dos96+s.kos96),-1,'1','2')) in
       (select n.r020,n.r012
        from   kl_f3_29 n
        where  n.kf=kodf_)         and
       s.acc=c.acc(+)             and
       s.acc=p.acc(+)             and
       s.rnk=z.rnk;

logger.info ('P_FF8: etap 1 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

insert into otc_ff8_history_acc(
       DATF, ACC, ACCC, NBS,
       SGN,
       NLS, KV, NMS, DAOS, DAZS, OST,
       OSTQ,
       ND, NKD,
       SDATE, WDATE, SOS, RNK, STAFF, TOBO, s260, k110, s031, s080, s270,
       tip, r011, r013, s370, sum_r013_1, s245)
select dat_, o.acc, o.accc, substr(o.nls,1,4),
       '0',
       o.nls, o.kv, o.nms, o.daos, o.dazs, 0 ost,0 ostq,
       nvl(c.nd, -o.acc) nd, trim(p.nkd), -- ���� ���� ND, �� ����������� ACC
       c.sdate, c.wdate, c.sos, o.rnk, userid_, o.tobo,
       f_get_s260(c.nd, o.acc, p.s260, o.rnk, o.nbs, default_) s260,
       z.ved, p.s031, nvl(p.s080,0), p.s270,
       o.tip, nvl(trim(p.r011), '0'), nvl(trim(p.r013), '0'), nvl(trim(p.s370), '0'), 0, '1'
from   OTCN_ACC          o,
       (select a.acc, a.nd, b.sdate, b.wdate, b.sos
        from   (select n.acc, max(n.nd) nd
                from   nd_acc n, cc_deal c
                where  n.nd=c.nd and
                       --dat_ between c.sdate and c.WDATE and
                       c.sdate <= dat_ and
                       c.VIDD not in (10, 26) -- ������� ������������ �������
                group by n.acc) a, cc_deal b
        where a.nd=b.nd) c,
       specparam         p,
       customer          z
where  substr(o.nls,1,4) in
           (select n.r020
            from   kl_f3_29 n
            where  n.kf=kodf_)         and
       o.acc=c.acc(+)             and
       o.acc=p.acc(+)             and
       o.rnk=z.rnk and
       o.acc not in (select acc from otc_ff8_history_acc where datf=dat_) and
       nvl(o.dazs, dat_+1) > dat_ and 
       exists (select 1
               from nd_acc n, sal s
               where n.nd=c.nd and
                     n.acc=s.acc and
                     s.fdat=dat_ and
                     s.nls like '9129%' and
                     s.ost<>0);

logger.info ('P_FF8: etap 2 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

   delete
   from otc_ff8_history_acc o
   where datf=dat_ and
         nbs in ('1508') and r011 !='6';

logger.info ('P_FF8: etap 2-1 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

update otc_ff8_history_acc o
set k111 = nvl((select k111 from kl_k110 k where k.k110=o.k110 and d_open <= dat_spr_ and (d_close is null or d_close > dat_spr_)),'00'),
    cc   = (select trim(f.ddd) from kl_f3_29 f
            where f.kf=kodf_    and
                  f.r020=o.nbs and
                  (f.r012=o.sgn or o.sgn=0)),
    s032 = f_get_s032(o.acc,dat_,null,o.nd),
    s080 = f_get_rez_kat(acc, rnk, nd, datr_),
    s370 = f_get_s370(dat_, o.s370, o.acc, o.nd)
where datf=dat_;

update otc_ff8_history_acc o
set o.cc = (select max(trim(f.ddd)) from kl_f3_29 f
            where f.kf='F8' and f.r020 = o.nbs
              and f.r012 <> o.sgn
            )
where o.datf = dat_ and
      trim(o.cc) is null and
      o.nbs in ('2600','2605','2607','2620','2625','2627','2650','2655','2657');

update otc_ff8_history_acc o
   set cc ='33'
   where datf=dat_
     and nbs in ('2246','2248','2456','2457','2458')
     and r011 in ('3');

update otc_ff8_history_acc o
   set cc ='32'
   where datf=dat_
     and nbs in ('2246','2248','2456','2457','2458')
     and r011 in ('2');

update otc_ff8_history_acc o
   set cc ='31'
   where datf=dat_
     and nbs in ('2246','2248','2456','2457','2458')
     and r011 in ('1');

-- ��������� S080 �� ����� �������� "A" ��� "M" � ������������ � KL_S080
if dat_ >= to_date('31012017','ddmmyyyy') then
    update otc_ff8_history_acc o
    set o.s080 = 'A'
    where o.datf = dat_ and
          o.cc like '21%' and
          NVL(o.s080, '0') in ('0','1','2','3','4','5') ;

    update otc_ff8_history_acc o
    set o.s080 = 'M'
    where o.datf = dat_ and
          o.cc not like '21%' and
          NVL(o.s080, '0') in ('0','1','2','3','4','5') ;
end if;

update otc_ff8_history_acc o
set o.s260 = '08'
where o.s260='00'
  and substr(o.cc, 1, 2) in ('31', '35')
  and o.datf = dat_;

logger.info ('P_FF8: etap 3 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

declare
    pnd_ number;
    ps270_ varchar2(2);
begin
    for i in (select acc, nd
              from otc_ff8_history_acc
              where datf=dat_ and
                    (s270 in ('00', '01') or trim(s270) is null))
    loop
        if pnd_ > 0 then
           pnd_ := i.nd;
        else
           pnd_ := null;
        end if;

        ps270_ := f_get_s270(dat_, null, i.acc, pnd_);

        if ps270_ <> '00' then
           update otc_ff8_history_acc
           set s270 = ps270_
           where datf=dat_ and
                 acc=i.acc;
        end if;
    end loop;
end;

logger.info ('P_FF8: etap 4 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

merge into otc_ff8_history_acc o
using (select nd,kv,accs from cc_add where nd in (select nd
                                                  from   otc_ff8_history_acc
                                                  where  datf=dat_) and
                                           adds=0) c
on (o.nd=c.nd and
    o.datf=dat_)
when matched then update
     set o.kv_dog=c.kv
when not matched then -- ��������� �����, ��� ����������� ������������� � ����� ������� �������� Oracle
     insert (o.nd, o.DATF, o.ACC )
     values (c.nd, dat_,   c.accs);

-- ��� s260 = '00'  �� ���������� ������������ ������������ �� KOD_F7 ������������� �������� �� ���������
update otc_ff8_history_acc o
set s260 = (case when cc in ('11','51','21') then '08'
                 when cc = '35' then '06'
                 when cc = '38' then '07'
                 else '00'
            end)
where datf = dat_ and
      s260 = '00';

logger.info ('P_FF8: etap 5 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

declare
    nbs1_       varchar2(4);
    r013_       varchar2(1);
    o_r013_1    varchar2(1);
    o_se_1      number;
    o_comm_1    varchar2(100);
    o_r013_2    varchar2(1);
    o_se_2      number;
    o_comm_2    varchar2(100);
begin
    for i in (select acc, nd, nbs,kv, r013, ostq
              from otc_ff8_history_acc
              where datf=dat_ and
                    nls like '___8' and
                    ostq <> 0)
    loop
       if mfo_ not in (300465,333368,300205) then
          p_analiz_r013 (mfo_, mfou_, dat_, i.acc, i.nbs, i.kv, r013_, i.ostq, i.nd,
                    o_r013_1, o_se_1, o_comm_1, o_r013_2, o_se_2, o_comm_2);

          IF o_se_2 <> 0 THEN
             update otc_ff8_history_acc o
               set r013 = '2',
                   SUM_R013_1 = o_se_2
               where datf = dat_ and
                     acc = i.acc;
          end if;
       end if;
    end loop;
end;

logger.info ('P_FF8: etap 6 for datf = '||to_char(dat_, 'dd/mm/yyyy'));


update otc_ff8_history_acc o
set r013 = (case when s370 = 'J' then '3'
                 else r013
            end)
where datf = dat_ and
      nls like '___9' and
      r013 in (0,1);

logger.info ('P_FF8: etap 7 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

declare
    pnd_        number;
    ps270_      varchar2(2);
    rzprr013_   number;
    sr013_      number;
    add_        number;
begin
    BEGIN
       SELECT TO_NUMBER (NVL (val, '0'))
          INTO rzprr013_
       FROM params
       WHERE par = 'RZPRR013';
    EXCEPTION WHEN NO_DATA_FOUND THEN
       rzprr013_ := '0';
    END;

    if rzprr013_ = '0' then
        for i in (select acc, ostq, kv
                  from otc_ff8_history_acc
                  where datf=dat_ and
                        nls like '___8' and  tip ='SPN' and
--                        nls like '___9' and
                        r013 in (0, 1) and
                        ostq <> 0)
        loop
            sr013_ := gl.p_icurval(i.kv, otcn_pkg.f_GET_R013(i.acc, dat_), dat_);

            IF i.ostq <> 0 and sr013_ < 0 and
               abs(sr013_) < abs(i.ostq)
            THEN
               update otc_ff8_history_acc o
               set r013 = '2',
                   SUM_R013_1 = sr013_
               where datf = dat_ and
                     acc = i.acc;
            end if;
        end loop;
    end if;
end;

logger.info ('P_FF8: etap 8 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

--Alexy ������� kv_dog ��� ������������� �� �������
update otc_ff8_history_acc o
set kv_dog = null where datf = dat_;

update otc_ff8_history_acc
   set s245 ='2'
 where tip in ('SK9','SP ','SPN','OFR','KSP','KK9','KPN','SNA');

logger.info ('P_FF8: etap 9 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

-- �������� 04 - ������� ������ ��������� ��������, ���� ���� ��������
--               ������ ��� ���������������� - ���� ������ ��������� �����
--               �� ������ �������/�����
        if dat_ <to_date('20171229','yyyymmdd')  then

INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, tobo)
select *
from (
    with kred as (select max(nls)                   nls ,
                         nvl(kv_dog,kv)             kv  ,
                         dat_                       dt  ,
                         substr(cc,1,2)||
                         k111          ||
                         max(nvl(s260,'00'))||
                         max(s032)          ||
                         s080               ||
                         '00'               ||
--                         max(s270)          ||
                         lpad(nvl(kv_dog,kv),3,'0') kodp,
                         (case when f.nd<0 then
                           null
                         else
                           f.nd
                         end)                       nd  ,
                         rnk                            ,
                         'ʳ������ ������� - '||
                         to_char(count(*))          comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         tobo                           ,
                         1                          cnt ,
                         sum(ostq)                  ost
                  from   OTC_ff8_HISTORY_ACC f
                  where  f.datf=dat_ and
                         f.nd in -- ������������ ���������������� ���.����� � %%-�
                               (SELECT nd
                                  FROM (SELECT   nd
                                        FROM v_cck_restr a
                                        WHERE exists (SELECT 1
                                                      FROM v_cck_restr b
                                                      WHERE a.nd = b.nd and
                                                            dat_ between b.fdat and nvl(b.FDAT_END, dat_)  and
                                                            b.PR_NO = 1 and
                                                            b.vid_restr not in (1, 3, 16)) and -- ���������������� ���.�����
                                              exists (SELECT 1
                                                      FROM v_cck_restr c
                                                      WHERE a.nd = c.nd and
                                                            dat_ between c.fdat and nvl(c.FDAT_END, dat_)  and
                                                            c.PR_NO = 1 and
                                                            c.vid_restr in (3, 16)) -- ���������������� %%-�
                                             or
                                             dat_ between a.fdat and nvl(a.FDAT_END, dat_)  and
                                             a.PR_NO = 1 and
                                             vid_restr = 1 -- ������������ ���������������� ���.����� � %%-�
                                       )
                               )  and
                         (length(trim(f.cc))=2 or f.cc like '__2')-- ����� ���. �����-��� � ���������� �� ���. ������-��
                  group by nvl(kv_dog,kv), substr(cc,1,2), k111, s080, lpad(nvl(kv_dog,kv),3,'0'),
                           f.nd, rnk, decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), tobo)
    select nls, kv, dt, '04'||kodp, cnt znap, nd, rnk, comm, nbuc, tobo
    from kred
);
        end if;

-- �������� 05 - ������� ������ ��������� ��������, ���� ���� ��������
--               ������ ��� ���������������� - ���� ������ ��������� �����
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, tobo)
select *
from (
    with kred as (select max(nls)                   nls ,
                         nvl(kv_dog,kv)             kv  ,
                         dat_                       dt  ,
                         substr(cc,1,2)||
                         k111          ||
                         max(nvl(s260,'00'))||
                         max(s032)          ||
                         s080               ||
                         '00'               ||
--                         max(s270)          ||
                         lpad(nvl(kv_dog,kv),3,'0')||s245 kodp,
                        (case when f.nd<0 then
                           null
                         else
                           f.nd
                         end)                       nd  ,
                         rnk                            ,
                         'ʳ������ ������� - '||
                         to_char(count(*))          comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         tobo                           ,
                         1                          cnt ,
                         sum(ostq)                  ost
                  from   OTC_ff8_HISTORY_ACC f
                  where  f.datf=dat_ and
                         f.nd in -- !!! ������ ���������������� ���.�����
                               (SELECT nd
                                  FROM (SELECT   nd
                                        FROM v_cck_restr a
                                        WHERE exists (SELECT 1
                                                      FROM v_cck_restr b
                                                      WHERE a.nd = b.nd and
                                                            dat_ between b.fdat and nvl(b.FDAT_END, dat_)  and
                                                            b.PR_NO = 1 and
                                                            b.vid_restr not in (3, 16)) and -- ���� ���������������� ���.�����
                                              not exists (SELECT 1
                                                      FROM v_cck_restr c
                                                      WHERE a.nd = c.nd and
                                                            dat_ between c.fdat and nvl(c.FDAT_END, dat_)  and
                                                            c.PR_NO = 1 and
                                                            c.vid_restr in (1, 3, 16)) -- ��� ���������������� %%-� � �����
                                       )
                                ) and
                         (length(trim(f.cc))=2 or f.cc like '__2')-- ����� ���. �����-��� � ���������� �� ���. ������-��
                  group by nvl(kv_dog,kv), substr(cc,1,2), k111, s080, lpad(nvl(kv_dog,kv),3,'0'), s245,
                           f.nd, rnk, decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), tobo)
    select nls, kv, dt, '05'||kodp, cnt znap, nd, rnk, comm, nbuc, tobo
    from kred
);


-- �������� 06 - ������� ������ ��������� ��������, ���� ���� ��������
--               ������ ��� ���������������� - ���� ������ �������/�����
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, tobo)
select *
from (
    with kred as (select max(nls)                   nls ,
                         nvl(kv_dog,kv)             kv  ,
                         dat_                       dt  ,
                         substr(cc,1,2)||
                         k111          ||
                         max(nvl(s260,'00'))||
                         max(s032)          ||
                         s080               ||
                         '00'               ||
--                         max(s270)          ||
                         lpad(nvl(kv_dog,kv),3,'0')||s245 kodp,
                        (case when f.nd<0 then
                           null
                         else
                           f.nd
                         end)                       nd  ,
                         rnk                            ,
                         'ʳ������ ������� - '||
                         to_char(count(*))          comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         tobo                           ,
                         1                          cnt ,
                         sum(ostq)                  ost
                  from   OTC_ff8_HISTORY_ACC f
                  where  f.datf=dat_ and
                         f.nd in -- !!! ������ ���������������� %%-�
                               (SELECT nd
                                  FROM (SELECT   nd
                                        FROM v_cck_restr a
                                        WHERE not exists (SELECT 1
                                                      FROM v_cck_restr b
                                                      WHERE a.nd = b.nd and
                                                            dat_ between b.fdat and nvl(b.FDAT_END, dat_)  and
                                                            b.PR_NO = 1 and
                                                            b.vid_restr not in (1, 3, 16)) and -- ��� ���������������� ���.����� � �����
                                              exists (SELECT 1
                                                      FROM v_cck_restr c
                                                      WHERE a.nd = c.nd and
                                                            dat_ between c.fdat and nvl(c.FDAT_END, dat_)  and
                                                            c.PR_NO = 1 and
                                                            c.vid_restr in (3, 16)) -- ���� ���������������� %%-�
                                       )
                                 ) and
                           (length(trim(f.cc))=2 or f.cc like '__2')-- ����� ���. �����-��� � ���������� �� ���. ������-��
                  group by nvl(kv_dog,kv), substr(cc,1,2), k111, s080, lpad(nvl(kv_dog,kv),3,'0'), s245,
                           f.nd, rnk, decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), tobo)
    select nls, kv, dt, '06'||kodp, cnt znap, nd, rnk, comm, nbuc, tobo
    from kred
);


-- �������� 08 - ����� ������������� �� ������� ���������� ����������,
--               ���� ���� �������� ������ ��� ���������������� - ��
--               �������� ������
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, tobo)
select *
from (
    with kred as (select max(nls)                   nls ,
                         nvl(kv_dog,kv)             kv  ,
                         dat_                       dt  ,
                         substr(cc,1,2)||
                         k111          ||
                         max(nvl(s260,'00'))||
                         max(s032)          ||
                         s080               ||
                         '00'               ||
--                         max(s270)          ||
                         lpad(nvl(kv_dog,kv),3,'0')||s245 kodp,
                         (case when f.nd<0 then
                           null
                         else
                           f.nd
                         end)                       nd  ,
                         rnk                            ,
                         'ʳ������ ������� - '||
                         to_char(count(*))          comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         tobo                           ,
                         1                          cnt ,
                         sum(ostq)                  ost,
                         p.sumr
                  from   OTC_ff8_HISTORY_ACC f,
                         (select nd, sum(sumr) sumr
                          from   v_cck_restr b
                          where  b.vid_restr not in (3, 16) and
                                 dat_ between b.fdat and nvl(b.FDAT_END, dat_)  and
                                 b.PR_NO = 1
                           group by nd) p
                  where  f.datf=dat_ and
                         (length(trim(f.cc))=2 or f.cc like '__2') and -- ����� ���. �����-��� � ���������� �� ���. ������-��
                         f.nd = p.nd
                  group by nvl(kv_dog,kv), substr(cc,1,2), k111, s080, lpad(nvl(kv_dog,kv),3,'0'), s245, 
                           f.nd, rnk, decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), tobo, p.sumr)
    select nls, kv, dt, '08'||kodp,
           (case when sumr = 0 or abs(ost) < sumr then abs(ost) else sumr end) znap,
           k.nd, rnk, comm||' SUMR='||to_char(sumr)||' OST='||to_char(abs(ost)), nbuc, tobo
    from kred k
);


-- �������� 09 - ����� ������������� �� ������� ���������� ����������,
--               ���� ���� �������� ������ ��� ���������������� - ��
--               ������������ ��������
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, tobo)
select *
from (
    with kred as (select max(nls)                   nls ,
                         nvl(kv_dog,kv)             kv  ,
                         dat_                       dt  ,
                         substr(cc,1,2)||
                         k111          ||
                         max(nvl(s260,'00'))||
                         max(s032)          ||
                         s080               ||
                         '00'               ||
--                         max(s270)          ||
                         lpad(nvl(kv_dog,kv),3,'0')||s245 kodp,
                        (case when f.nd<0 then
                           null
                         else
                           f.nd
                         end)                       nd  ,
                         rnk                            ,
                         'ʳ������ ������� - '||
                         to_char(count(*))          comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         tobo                           ,
                         1                          cnt ,
                         sum(ostq)                  ost,
                         p.sumr
                  from   OTC_ff8_HISTORY_ACC f,
                         (select nd, sum(sumr) sumr
                          from   v_cck_restr b
                          where  b.vid_restr in (1, 3, 16) and
                                 dat_ between b.fdat and nvl(b.FDAT_END, dat_)  and
                                 b.PR_NO = 1
                          group by nd) p
                  where  f.datf=dat_ and
                         (f.cc like '__1' or f.cc like '__3') and -- ����� ������. %% -� � ������������� %% -�
                         f.nd = p.nd
                  group by nvl(kv_dog,kv), substr(cc,1,2), k111, s080, lpad(nvl(kv_dog,kv),3,'0'), s245,
                           f.nd, rnk, decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), tobo, p.sumr)
    select nls, kv, dt, '09'||kodp,
           (case when sumr = 0 or abs(ost) < sumr then abs(ost) else sumr end) znap,
           k.nd, rnk, comm||' SUMR='||to_char(sumr)||' OST='||to_char(abs(ost)), nbuc, tobo
    from kred k);


-- �������� 10 - ������� ������ ��������� ��������, ���� ���� ��������
--               ������ ��� ���������������� �������� ������� ������
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, tobo)
select *
from (
    with kred as (select max(nls)                   nls ,
                         nvl(kv_dog,kv)             kv  ,
                         dat_                       dt  ,
                         substr(cc,1,2)||
                         k111          ||
                         max(nvl(s260,'00'))||
                         max(s032)          ||
                         s080               ||
                         '00'               ||
--                         max(s270)          ||
                         lpad(nvl(kv_dog,kv),3,'0')||s245 kodp,
                        (case when f.nd<0 then
                           null
                         else
                           f.nd
                         end)                       nd  ,
                         rnk                            ,
                         'ʳ������ ������� - '||
                         to_char(count(*))          comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         tobo                           ,
                         1                          cnt ,
                         sum(ostq)                  ost
                  from   OTC_ff8_HISTORY_ACC f
                  where  f.datf=dat_ and
                         (length(trim(f.cc))=2 or f.cc like '__2') and -- ����� ���. �����-��� � ���������� �� ���. ������-��
                         exists (select nd
                                  from v_cck_restr v
                                  where v.nd = f.nd and
                                        v.fdat between datb_ and dat_ and
                                        dat_ between v.fdat and nvl(v.FDAT_END, dat_)  and
                                        v.PR_NO = 1
                                 ) and
                         not exists (select nd
                                  from v_cck_restr v
                                  where v.nd = f.nd and
                                        v.fdat < datb_  and
                                        v.PR_NO = 1
                                        )
                  group by nvl(kv_dog,kv), substr(cc,1,2), k111, s080, lpad(nvl(kv_dog,kv),3,'0'), s245,
                           f.nd, rnk, decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), tobo)
    select nls, kv, dt, '10'||kodp, cnt znap, nd, rnk, comm, nbuc, tobo
    from kred
);


-- �������� 12 - ����� ������������� �� ������� ���������� ����������,
--               ���� ���� �������� ������ ��� ���������������� ��������
--               ������� ������ - �� �������� ������
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, tobo)
select *
from (
    with kred as (select max(nls)                   nls ,
                         nvl(kv_dog,kv)             kv  ,
                         dat_                       dt  ,
                         substr(cc,1,2)||
                         k111          ||
                         max(nvl(s260,'00'))||
                         max(s032)          ||
                         s080               ||
                         '00'               ||
--                         max(s270)          ||
                         lpad(nvl(kv_dog,kv),3,'0')||s245 kodp,
                        (case when f.nd<0 then
                           null
                         else
                           f.nd
                         end)                       nd  ,
                         rnk                            ,
                         'ʳ������ ������� - '||
                         to_char(count(*))          comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         tobo                           ,
                         1                          cnt ,
                         sum(ostq)                  ost,
                         p.sumr
                  from   OTC_ff8_HISTORY_ACC f,
                         (select nd,
                                sum(case when fdat < datb_ then 1 else 0 end) p1,
                                sum(case when fdat between datb_ and dat_ then 1 else 0 end) p2,
                                sum(case when fdat between datb_ and dat_ then sumr else 0 end) sumr
                            from   v_cck_restr v
                            where  vid_restr not in (3, 16) and
                                 fdat <= dat_ and
                                 dat_ between v.fdat and nvl(v.FDAT_END, dat_)  and
                                 v.PR_NO = 1
                          group by nd) p
                  where  f.datf=dat_ and
                         (length(trim(f.cc))=2 or f.cc like '__2') and -- ����� ���. �����-��� � ���������� �� ���. ������-��
                         f.nd = p.nd and
                         p.p1 = 0 and
                         p.p2 >= 1 and
                         not exists (select nd
                                  from v_cck_restr v
                                  where v.nd = f.nd and
                                        v.fdat < datb_  and
                                        v.PR_NO = 1
                                        )
                  group by nvl(kv_dog,kv), substr(cc,1,2), k111, s080, lpad(nvl(kv_dog,kv),3,'0'), s245,
                           f.nd, rnk, decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), tobo, p.sumr)
    select nls, kv, dt, '12'||kodp,
           (case when sumr = 0 or abs(ost) < sumr then abs(ost) else sumr end) znap,
           k.nd, rnk, comm||' SUMR='||to_char(sumr)||' OST='||to_char(abs(ost)), nbuc, tobo
    from kred k);

-- �������� 13 - ����� ������������� �� ������� ���������� ����������,
--               ���� ���� �������� ������ ��� ���������������� ��������
--               ������� ������ - �� ������������ ��������
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, tobo)
select *
from (
    with kred as (select max(nls)                   nls ,
                         nvl(kv_dog,kv)             kv  ,
                         dat_                       dt  ,
                         substr(cc,1,2)||
                         k111          ||
                         max(nvl(s260,'00'))||
                         max(s032)          ||
                         s080               ||
                         '00'               ||
--                         max(s270)          ||
                         lpad(nvl(kv_dog,kv),3,'0')||s245 kodp,
                        (case when f.nd<0 then
                           null
                         else
                           f.nd
                         end)                       nd  ,
                         rnk                            ,
                         'ʳ������ ������� - '||
                         to_char(count(*))          comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         tobo                           ,
                         1                          cnt ,
                         sum(ostq)                  ost,
                         p.sumr
                  from   OTC_ff8_HISTORY_ACC f,
                         (select nd,
                                sum(case when fdat < datb_ then 1 else 0 end) p1,
                                sum(case when fdat between datb_ and dat_ then 1 else 0 end) p2,
                                sum(case when fdat between datb_ and dat_ then sumr else 0 end) sumr
                            from   v_cck_restr v
                            where  vid_restr in (1, 3, 16) and
                                 fdat <= dat_ and
                                 dat_ between v.fdat and nvl(v.FDAT_END, dat_)  and
                                 v.PR_NO = 1
                          group by nd) p
                  where  f.datf=dat_ and
                         (f.cc like '__1' or f.cc like '__3') and -- ����� ������. %% -� � ������������� %% -�
                         f.nd = p.nd and
                         p.p1 = 0 and
                         p.p2 >= 1 and
                         not exists (select nd
                                  from v_cck_restr v
                                  where v.nd = f.nd and
                                        v.fdat < datb_  and
                                        v.PR_NO = 1
                                        )
                  group by nvl(kv_dog,kv), substr(cc,1,2), k111, s080, lpad(nvl(kv_dog,kv),3,'0'), s245,
                           f.nd, rnk, decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), tobo, p.sumr)
    select nls, kv, dt, '13'||kodp,
           (case when sumr = 0 or abs(ost) < sumr then abs(ost) else sumr end) znap,
           k.nd, rnk, comm||' SUMR='||to_char(sumr)||' OST='||to_char(abs(ost)), nbuc, tobo
    from kred k);

-- �������� 15 - ����� ��������� ������������� ������������� ��
--               ������������������� ���������� ���������� - �� �������� ������
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, tobo)
select *
from (
    with kred as (select max(nls)                   nls ,
                         nvl(kv_dog,kv)             kv  ,
                         dat_                       dt  ,
                         substr(cc,1,2)||
                         k111          ||
                         max(nvl(s260,'00'))||
                         max(s032)          ||
                         s080               ||
                         '00'               ||
--                         max(s270)          ||
                         lpad(nvl(kv_dog,kv),3,'0')||s245 kodp,
                        (case when f.nd<0 then
                           null
                         else
                           f.nd
                         end)                       nd  ,
                         rnk                            ,
                         'ʳ������ ������� - '||
                         to_char(count(*))          comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         tobo                           ,
                         1                          cnt ,
                         sum(ostq)                  ost
                  from   OTC_ff8_HISTORY_ACC f
                  where  f.datf=dat_                  and
                         (length(trim(f.cc))=2 or f.cc like '__2') and  -- ����� ���. �����-��� � ���������� �� ���. ������-��
                         f.nd in (select nd
                                  from   v_cck_restr b
                                  where  b.vid_restr not in (3, 16) and -- in (1,2,4,5,7,8) and -- ����� 11/08/2010 --18/01/2010
                                         dat_ between b.fdat and nvl(b.FDAT_END, dat_)  and
                                         b.PR_NO = 1
                                  ) and
                         f.s080 in ('Q','J')  and
                         f.s270 in ('01','07','08')
                  group by nvl(kv_dog,kv), substr(cc,1,2), k111, s080, lpad(nvl(kv_dog,kv),3,'0'), s245,
                           f.nd, rnk, decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), tobo)
    select nls, kv, dt, '15'||kodp, -ost znap, nd, rnk, comm, nbuc, tobo
    from kred);


-- �������� 16 - ����� ��������� ������������� ������������� ��
--               ������������������� ���������� ���������� -
--               �� ������������ ��������
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, tobo)
select *
from (
    with kred as (select max(f.nls)                   nls ,
                         nvl(f.kv_dog, f.kv)             kv  ,
                         dat_                       dt  ,
                         substr(f.cc,1,2)||
                         f.k111          ||
                         max(nvl(f.s260,'00'))||
                         max(f.s032)          ||
                         f.s080               ||
                         '00'               ||
--                         max(f.s270)          ||
                         lpad(nvl(f.kv_dog,f.kv),3,'0')||s245 kodp,
                        (case when f.nd<0 then
                           null
                         else
                           f.nd
                         end)                       nd  ,
                         f.rnk                            ,
                         'ʳ������ ������� - '||
                         to_char(count(*))          comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         tobo                           ,
                         1                          cnt ,
                         sum(f.ostq)                  ost
                  from   OTC_ff8_HISTORY_ACC f
                  where  f.datf=dat_                  and
                         (f.cc like '__1' or f.cc like '__3') and -- ����� ������. %% -� � ������������� %% -�
                         f.nd in (select nd
                                  from   v_cck_restr b
                                  where  b.vid_restr in (1, 3, 16) and -- ����� 11/08/2010 --18/01/2010
                                         dat_ between b.fdat and nvl(b.FDAT_END, dat_)  and
                                         b.PR_NO = 1
                                  ) and
                          f.s080 in ('Q', 'J') and
                         (f.cc like '__1' and f.r013 is not null  or  -- nvl(f.r013,'0') not in ('0', '3')
                          f.cc like '__3' and f.r013 is not null  or  -- nvl(f.r013,'0') not in ('0', '1')
                          f.cc like '__1' and f.s270 = '08' or
                          f.cc like '__3' and f.s370 = 'J')
                  group by nvl(f.kv_dog,kv), substr(f.cc,1,2), f.k111, f.s080, lpad(nvl(f.kv_dog,f.kv),3,'0'), s245,
                           f.nd, f.rnk, decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), f.tobo)
    select nls, kv, dt, '16'||kodp, -ost znap, nd, rnk, comm, nbuc, tobo
    from kred);

-- �������� 18 - ����� ����������� ������������� �� �������������������
--               ���������� ���������� - �� �������� ������
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, tobo)
select *
from (
    with kred as (select max(nls)                   nls ,
                         nvl(kv_dog,kv)             kv  ,
                         dat_                       dt  ,
                         substr(cc,1,2)||
                         k111          ||
                         max(nvl(s260,'00'))||
                         max(s032)          ||
                         s080               ||
                         '00'               ||
--                         max(s270)          ||
                         lpad(nvl(kv_dog,kv),3,'0')||s245 kodp,
                        (case when f.nd<0 then
                           null
                         else
                           f.nd
                         end)                       nd  ,
                         rnk                            ,
                         'ʳ������ ������� - '||
                         to_char(count(*))          comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         tobo                           ,
                         1                          cnt ,
                         sum(ostq)                  ost
                  from   OTC_ff8_HISTORY_ACC f
                  where  f.datf=dat_                  and
                         (f.cc like '__2') and -- ����� ���������� �� ���. �����-���
                         f.nd in (select nd
                                  from   v_cck_restr b
                                  where  b.vid_restr not in (3, 16) and -- in (1,2,4,5,7,8) and -- ����� 11/08/2010 --18/01/2010
                                         dat_ between b.fdat and nvl(b.FDAT_END, dat_)  and
                                         b.PR_NO = 1
                                  ) and
--                         f.s080 in ('2', '3', '4', '5')  and
                         f.s270 in ('07', '08')  and s245='2'
                  group by nvl(kv_dog,kv), substr(cc,1,2), k111, s080, lpad(nvl(kv_dog,kv),3,'0'), s245,
                           f.nd, rnk, decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), tobo)
    select nls, kv, dt, '18'||kodp, -ost znap, nd, rnk, comm, nbuc, tobo
    from kred);


-- �������� 19 - ����� ����������� ������������� �� �������������������
--               ���������� ���������� - �� ������������ ��������
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, tobo)
select *
from (
    with kred as (select max(nls)                   nls ,
                         nvl(kv_dog,kv)             kv  ,
                         dat_                       dt  ,
                         substr(cc,1,2)||
                         k111          ||
                         max(nvl(s260,'00'))||
                         max(s032)          ||
                         NVL(s080,'0')      ||
                         '00'               ||
--                         max(s270)          ||
                         lpad(nvl(kv_dog,kv),3,'0')||s245 kodp,
                        (case when f.nd<0 then
                           null
                         else
                           f.nd
                         end)                       nd  ,
                         rnk                            ,
                         'ʳ������ ������� - '||
                         to_char(count(*))          comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         tobo                           ,
                         1                          cnt ,
                         sum(ostq)                  ost
                  from   OTC_ff8_HISTORY_ACC f
                  where  f.datf=dat_                  and
                         (f.cc like '__3') and -- ����� ��������. ������. %% -�
                         f.nd in (select nd
                                  from   v_cck_restr b
                                  where  b.vid_restr in (1, 3, 16) and -- ����� 11/08/2010 --18/01/2010
                                         dat_ between b.fdat and nvl(b.FDAT_END, dat_)  and
                                         b.PR_NO = 1
                                  ) and s245='2'
                  group by nvl(kv_dog,kv), substr(cc,1,2), k111, s080, lpad(nvl(kv_dog,kv),3,'0'), s245,
                           f.nd, rnk, decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), tobo)
    select nls, kv, dt, '19'||kodp, -ost znap, nd, rnk, comm, nbuc, tobo
    from kred);

p_ff7(dat_,'G',0,1);
commit;

update otc_ff7_history_acc o
set o.s260 = '08' 
where o.s260='00' 
  and substr(o.cc, 1, 2) in ('31', '35')
  and o.datf = dat_;
commit;

logger.info ('P_FF8: etap 10 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

for k in (select acc,nd,rnk from OTC_FF7_HISTORY_ACC where datf=dat_)
loop
    BEGIN
        select NVL(s080_351,'0')
           into s080r_
        from v_tmp_rez_risk
        where dat = dat_spr_
          and acc = k.acc
          and id not like 'DEB%'
          and nd = decode(is_number(k.nd),0,999999999,abs(k.nd))
          and s080 is not null
          and rownum = 1;
     EXCEPTION WHEN NO_DATA_FOUND THEN
        BEGIN
           select NVL(s080_351,'0')
              into s080r_
           from v_tmp_rez_risk
           where dat = dat_spr_
             and acc = k.acc
             and id not like 'DEB%'
             and s080_351 is not null
             and rownum = 1;
        EXCEPTION WHEN NO_DATA_FOUND THEN
           BEGIN
              select max(NVL(s080_351,'0'))
                 into s080r_
              from v_tmp_rez_risk
              where dat = dat_spr_
                and nd = decode(is_number(k.nd),0,999999999,abs(k.nd))
                and id not like 'DEB%'
                and s080_351 is not null;
           EXCEPTION WHEN NO_DATA_FOUND THEN
              BEGIN
                 select max(NVL(s080_351,'0'))
                    into s080r_
                 from v_tmp_rez_risk
                 where dat = dat_spr_
                   and rnk = k.rnk
                   and id not like 'DEB%'
                   and s080_351 is not null;
              EXCEPTION WHEN NO_DATA_FOUND THEN
                 BEGIN
                    select NVL(s080,'0')
                       into s080r_
                    from OTC_FF7_HISTORY_ACC
                    where datf = datp_
                      and acc = k.acc
                      and rownum = 1;
                 EXCEPTION WHEN NO_DATA_FOUND THEN
                     s080r_ := '0';
                 END;
              END;
           END;
        END;
    END;

    update OTC_FF7_HISTORY_ACC f
           set s080 = nvl(s080r_,'0')
           where datf=dat_ and acc=k.acc and nd=k.nd and rnk=k.rnk;

end loop;

-- ��������� S080 �� ����� �������� "A" ��� "M" � ������������ � KL_S080
if dat_ >= to_date('31012017','ddmmyyyy') then
    update otc_ff7_history_acc o
    set o.s080 = 'A'
    where o.datf = dat_ and
          o.cc = '21' and
          NVL(o.s080, '0') in ('0','1','2','3','4','5') ;

    update otc_ff7_history_acc o
    set o.s080 = 'M'
    where o.datf = dat_ and
          o.cc <> '21' and
          NVL(o.s080, '0') in ('0','1','2','3','4','5') ;
end if;

logger.info ('P_FF8: etap 11 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

-- ���� ��� ������������ ���������� 26
for k in (select acck, nlsk, kv,
                 NVL (SUM (gl.p_icurval (o.kv, o.s * 100, o.fdat)), 0) kos
            from (
                select decode(a.dk, 0, a.acc, b.acc) accd, a.tt, a.ref, a.kv,
                    decode(a.dk, 0, a.nls, d.nls) nlsd, a.s, a.sq, a.fdat,
                    c.nazn, decode(a.dk, 1, a.acc, b.acc) acck,
                     decode(a.dk, 1, a.nls, d.nls) nlsk
                from (select /*+parallel(8)*/ o1.fdat, o1.ref, o1.stmt, o1.dk, o1.tt,
                            o1.acc, o1.s / 100 s, o1.sq / 100 sq, a.nls, a.kv
                        from opldok o1, accounts a
                        where o1.fdat = any (select fdat from fdat where fdat between datb_ and dat_) and
                            o1.dk = 0 and
                            o1.tt not in ('096', 'ZG8', 'ZG9') and
                            o1.acc = a.acc and
                            a.nls LIKE '159%'  and
                            o1.sos >= 4
                      union
                      select /*+parallel(8)*/ o1.fdat, o1.ref, o1.stmt, o1.dk, o1.tt,
                            o1.acc, o1.s / 100 s, o1.sq / 100 sq, a.nls, a.kv
                        from opldok o1, accounts a
                        where o1.fdat = any (select fdat from fdat where fdat between datb_ and dat_) and
                            o1.dk = 0 and
                            o1.tt not in ('096', 'ZG8', 'ZG9') and
                            o1.acc = a.acc and
                            a.nls LIKE '240%'  and
                            o1.sos >= 4
                      union
                      select /*+parallel(8)*/ o1.fdat, o1.ref, o1.stmt, o1.dk, o1.tt,
                            o1.acc, o1.s / 100 s, o1.sq / 100 sq, a.nls, a.kv
                        from opldok o1, accounts a
                        where o1.fdat = any (select fdat from fdat where fdat between datb_ and dat_) and
                            o1.dk = 0 and
                            o1.tt not in ('096', 'ZG8', 'ZG9') and
                            o1.acc = a.acc and
                               a.nls like '15_9%' and 
                              o1.fdat > to_date('20171218','yyyymmdd')  and
                            o1.sos >= 4
                      union
                      select /*+parallel(8)*/ o1.fdat, o1.ref, o1.stmt, o1.dk, o1.tt,
                            o1.acc, o1.s / 100 s, o1.sq / 100 sq, a.nls, a.kv
                        from opldok o1, accounts a
                        where o1.fdat = any (select fdat from fdat where fdat between datb_ and dat_) and
                            o1.dk = 0 and
                            o1.tt not in ('096', 'ZG8', 'ZG9') and
                            o1.acc = a.acc and
                                (   a.nls like '20_9%'
                                 or a.nls like '21_9%'
                                 or a.nls like '22_9%'
                                 or a.nls like '26_9%' ) and
                              o1.fdat > to_date('20171218','yyyymmdd') and
                            o1.sos >= 4
                    ) a, opldok b, accounts d, oper c
                where a.ref = b.ref and
                    a.stmt = b.stmt and
                    a.fdat = b.fdat and
                    a.dk <> b.dk and
                    b.acc = d.acc and
                    d.nbs in (select r020 from kl_f3_29  where kf = 'F7') and
                    a.ref = c.ref and
                    c.sos = 5
                    ) o
              group by acck, nlsk, kv)
loop
   BEGIN
      update OTC_FF7_HISTORY_ACC
      set kosq = kosq - k.kos
      where datf=dat_
        and acc=k.acck;

      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid, isp)
      select f.nls, nvl(f.kv_dog, f.kv), dat_, 'B8' || NVL(f.cc,'00') || NVL(f.k111,'00') ||
                      NVL(f.s260,'00') || NVL(f.s032,'0')|| NVL(s080,'0')||'00'||
                      lpad(nvl(f.kv_dog, f.kv),3,'0')||s245,
                     to_char(0-k.kos),  -- ���������
                     (case substr(f.nd,1,1) when '�' then null when '-' then null else f.nd end),
                      f.rnk,
                      nvl(f.nkd, f.nd),
                      decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                      userid_,
                      f.accc
                from OTC_FF7_HISTORY_ACC f
                where f.datf=dat_
                      and f.acc=k.acck;
   EXCEPTION WHEN OTHERS THEN
      null;
   END;
end loop;

logger.info ('P_FF8: etap 12 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

insert
into otcn_ff8_migr_nd(nd)
select /*+ hash(n) */
    n.nd
from opldok o, oper p, nd_acc n
where o.fdat = any (select fdat from fdat where fdat between datb_ and dat_) and
      o.tt= 'R01' and
      o.ref = p.ref and
      p.sos = 5 and
      o.acc = n.acc and
      to_char(n.nd) in (select unique nd from OTC_FF7_HISTORY_ACC f where f.datf=dat_) and
      lower(p.nazn) like '���%��%';
commit;

logger.info ('P_FF8: etap 12-1 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

-- ��� ������� ��������
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid, isp)
select *
from (
    with kred as (select min(nls) nls, nvl(kv_dog, kv) kv, dat_ dt, cc||k111 k1,
                         max(f.s260) k2, max(s032) k3, lpad(nvl(kv_dog, kv),3,'0') k4, s245,
                         max((case substr(nd,1,1) when '�' then null when '-' then null else nd end)) nd, rnk,
                         nvl(nkd, nd) comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         1 cnt,
                         sum((case when substr(nls,1,4)='1502' and r_dos = 0 then dosq else r_dos end)) ost -- ������
                         --sum(r_dos) ost -- ������
                         ,min (accc) isp, s080
                    from OTC_FF7_HISTORY_ACC f
                    where f.datf=dat_
                          and f.tpa = 1
                          and (f.ostq_kd <> 0 or (f.ostq_kd=0 and f.dosq+f.kosq<>0))
                          and daos <> to_date('01012011','ddmmyyyy')
                          and not exists
                          (select 1 from OTC_FF7_HISTORY_ACC f1 where nvl(f.nkd, f.nd) = nvl(f1.nkd, f1.nd) and f1.datf=datp_
                          -- ���� � ������� ������ ����� �� �������� = 0, � � ���� <> 0  - ������� �����
                                   and (f1.ostq_kd <> 0
                                            or
                                       (f1.nbs in ('2202','2203') and f1.ostq_kd = 0 ))
                          )
                    group by nvl(kv_dog, kv), cc,k111, lpad(nvl(kv_dog, kv),3,'0'), s245, nvl(nkd,nd), rnk,
                             decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), s080
                    order by 1)
    select nls, kv, dt, 'A7'||k1||k2||k3||s080||'00'||k4||s245 kodp, cnt  znap, nd, rnk, comm, nbuc, userid_, isp
    from kred
    union all
    select nls, kv, dt, 'B2'||k1||k2||k3||s080||'00'||k4||s245 kodp, abs(ost) znap, nd, rnk, comm, nbuc, userid_,isp
    from kred
    where nvl(ost,0) <> 0);

logger.info ('P_FF8: etap 12-2 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

-- ������ ������� ��������
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid, isp)
select *
from (
    with kred as (select min(nls) nls, nvl(kv_dog, kv) kv, dat_ dt, cc||k111 k1,
                         max(f.s260) k2 ,
                         max(s032) k3, lpad(nvl(kv_dog, kv),3,'0') k4, s245,
                         max((case substr(nd,1,1) when '�' then null when '-' then null else nd end)) nd, rnk,
                         nvl(nkd,nd) comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         1 cnt, sum(ostq) ost
                         ,sum(kosq) kos
                         ,min (accc)  isp, s080
                    from OTC_FF7_HISTORY_ACC f
                    where f.datf=dat_ and
                          f.nls not like '9129%' and
                          f.ostq_kd = 0 and
                          f.tpa in (1, 4) and
                          (f.nkd is not null and
                           f.nkd in (SELECT F1.NKD
                                       FROM OTC_FF7_HISTORY_ACC F1
                                      WHERE  F1.DATF = datp_
                                            AND F1.OSTQ_KD <> 0)
                                             or
                           f.nkd is null and
                           f.nd in (SELECT F1.ND
                                       FROM OTC_FF7_HISTORY_ACC F1
                                      WHERE  F1.DATF = datp_
                                            AND F1.OSTQ_KD <> 0) )                          
                           and f.nd not in (select nd from otcn_ff8_migr_nd)
                    group by nvl(kv_dog, kv), cc,k111, lpad(nvl(kv_dog, kv),3,'0'), s245, tobo, nvl(nkd,nd), rnk,
                             decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), s080
                  )
    select nls, kv, dt, 'A8'||k1||k2||k3||s080||'00'||k4||s245 kodp, cnt  znap, nd, rnk, comm, nbuc, userid_,isp
    from kred
    union all
    select nls, kv, dt, 'B4'||k1||k2||k3||s080||'00'||k4||s245 kodp,
           --decode(qnt,0, kos,1,kos, greatest(0, kos-kos1)) znap,--��� ������� : ��������� = ����� ���������� - ����� ��������� �� ���� ������ SS
           --���� ��� ����� SS ������� ���������� ������ �� �����
           --���� ����� SS ����, �� �������� �� � �� ������� � ������ �������� �� ��������� (�� ������ SS SP)
           --���� ������ SS ��������� (� �������) - �������� ����� ���������� - ����� ��������� �� ���� ������ SS
          -- decode(qnt,0, kos2,1,kos, greatest(0, kos-kos1)) znap,
          kos znap,
           nd, rnk, comm, nbuc, userid_,isp
    from kred
    where kos<>0 and nls not like '9129%');

logger.info ('P_FF8: etap 12-3 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

-- �������� 03 - ������� ��������� �������� �� ����� ���� (00 - ���� �� �������� ��� ��������)
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid,isp)
select *
from (
    with kred as (select min(nls) nls, nvl(kv_dog, kv) kv, dat_ dt,
                         cc||k111||max(f.s260)||max(s032)||NVL(s080,'0')||'00'||lpad(nvl(kv_dog, kv),3,'0')||s245 kodp,
                        max((case substr(nd,1,1) when '�' then null when '-' then null else nd end)) nd, rnk,
                        nvl(nkd,nd) comm,
                        decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                        1 cnt, sum(ostq) ost, sum (r_dos) r_dos
                         ,sum(case substr(nd,1,1) when '�' then (kosq)
                                                  when '-' then (kosq)
                                                  else decode(f.tip,'SS ',(kosq), 'SP ', (-dosq+kosq), 'SL', (-dosq+kosq), 0)
                              end) kos
                         --��� �������   ���� ��������� ������ SS
                         ,sum(decode(f.tip,'SS ',1,0)) qnt
                         ,sum(case substr(nd,1,1) when '�' then 0
                                                  when '-' then 0
                                                  else decode(f.tip,'SS ',(dosq), 0)
                              end) kos1
                         ,min (accc)  isp
                  from OTC_FF7_HISTORY_ACC f
                  where f.datf = dat_
                        and ( f.ostq_kd <> 0 or
                              (f.ostq_kd = 0 and
                               f.nbs in ('2600','2605','2607',
                                         '2620','2625','2627',
                                         '2650','2655','2657'
                                        )
                              )
                             )
                        and f.tpa in (1, 3, 4)
                  group by nvl(kv_dog, kv), cc,k111,lpad(nvl(kv_dog, kv),3,'0'), s245, nvl(nkd,nd), rnk,
                           decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), s080
                  )
    select nls, kv, dt, 'A3'||kodp, cnt  znap, nd, rnk, comm, nbuc, userid_,isp
    from kred
    where nls not like '9129%'
    union all
    select nls, kv, dt, 'A0'||kodp, -1*ost znap, nd, rnk, comm, nbuc, userid_,isp
    from kred
    where nls not like '9129%');

logger.info ('P_FF8: etap 12-4 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

-- 13, 15 - ������ � ��������� �� ������������ ���������
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid,isp)
select *
from (
    with kred as (select min(nls) nls, nvl(kv_dog, kv) kv, dat_ dt,
                         cc||k111||max(f.s260)||max(s032)||s080||'00'||lpad(nvl(kv_dog, kv),3,'0')||s245 kodp,
                        max((case substr(nd,1,1) when '�' then null when '-' then null else nd end)) nd, rnk,
                        nvl(nkd,nd) comm,
                        decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                        1 cnt, sum(ostq) ost,
                        sum((case when substr(nls,1,4)='1502' and r_dos = 0 then dosq else r_dos end)) r_dos -- ������
                        --sum (r_dos) r_dos
                         ,sum(kosq) kos
                         ,min (accc)  isp
                  from OTC_FF7_HISTORY_ACC f
                  where f.datf=dat_
                         and f.tpa = 1
                         and f.nd not in (select nd from otcn_ff8_migr_nd)
                  group by nvl(kv_dog, kv), cc,k111,lpad(nvl(kv_dog, kv),3,'0'), s245, nvl(nkd,nd), rnk,
                           decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), s080
                  )
    select nls, kv, dt, 'B5'||kodp,
           --decode(qnt,0, kos,1,kos, greatest(0, kos-kos1))  znap, --��� ������� : ��������� = ����� ���������� - ����� ��������� �� ���� ������ SS
           --���� ��� ����� SS ������� ���������� ������ �� �����
           --���� ����� SS ����, �� �������� �� � �� ������� � ������ �������� �� ��������� (�� ������ SS SP)
           --���� ������ SS ��������� (� �������) - �������� ����� ���������� - ����� ��������� �� ���� ������ SS
           --decode(qnt,0, kos2,1,kos, greatest(0, kos-kos1)) znap,
           kos znap,
           nd, rnk, comm, nbuc, userid_,isp
    from kred kk
    where kos>0
          --������������ �������� - ��� ����������� (���� � 03 ����������), �� �� ����� (��� � 07 ����������) � �� �������� (��� � 08 ����������)
          and exists (select 1 from rnbu_trace r where  (r.kodp like 'A3%' or r.kodp like 'A7%') and r.comm = kk.comm)
          and not exists (select 1 from rnbu_trace r where (/*r.kodp like '07%' or*/ r.kodp like 'A8%') and r.comm = kk.comm)
    union all
    select nls, kv, dt, 'B3'||kodp,
           r_dos  znap, --������ (������� �� ����� 03)
           nd, rnk, comm, nbuc, userid_,isp
    from kred kk
    where nvl(r_dos,0)>0
          --������������ �������� - ��� ����������� (���� � 03 ����������), �� �� ����� (��� � 07 ����������) � �� �������� (��� � 08 ����������)
          and exists (select 1 from rnbu_trace r where  (r.kodp like 'A3%' or r.kodp like 'A8%') and r.comm = kk.comm)
          and not exists (select 1 from rnbu_trace r where (r.kodp like 'A7%') and r.comm = kk.comm)
);

logger.info ('P_FF8: etap 12-5 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

-- 16 - �������� �� ������������ ���������
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid,isp)
select *
from (
    with kred as (select min(nls) nls, nvl(kv_dog, kv) kv, dat_ dt,
                         cc||k111||max(f.s260)||max(s032)||s080||'00'||lpad(nvl(kv_dog, kv),3,'0')||s245 kodp,
                        max((case substr(nd,1,1) when '�' then null when '-' then null else nd end)) nd, rnk,
                        nvl(nkd,nd) comm,
                        decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                        1 cnt, sum(ostq) ost, sum (r_dos) r_dos
                         ,sum((case when nbs like '___6' then -dosq else kosq end)) kos
                         ,min (accc)  isp
                  from OTC_FF7_HISTORY_ACC f
                  where f.datf=dat_
                         and f.nls not like '9129%'
                         and f.nd in (select nd from otcn_ff8_migr_nd)
                  group by nvl(kv_dog, kv), cc,k111,lpad(nvl(kv_dog, kv),3,'0'), s245, nvl(nkd,nd), rnk,
                           decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), s080
                  )
    select nls, kv, dt, 'B6'||kodp,
           kos znap,
           nd, rnk, comm, nbuc, userid_,isp
    from kred kk
    where kos>0
);

logger.info ('P_FF8: etap 12-6 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

--��� ���������
--if nvl(GetGlobalOption('OB22'),0) = 1 or 300465 in (mfou_) or mfou_ not in (300465) then  -- ���� ��� � ��� ������� 353575 in (mfo_) then
    --��������� ����� % � �������� � ���������� 12,13,14,15                              -- � 24.12.10 ����� ��� ����
    INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid,isp)
    select *
    from (
    with kred as (select min(nls) nls, nvl(kv_dog, kv) kv, dat_ dt, cc||k111 k1,
                         max(f.s260) k2, max(s032) k3, lpad(nvl(kv_dog, kv),3,'0') k4, s245,
                         max((case substr(nd,1,1) when '�' then null when '-' then null else nd end)) nd, rnk,
                         nvl(nkd,nd) comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         1 cnt,
                         sum(decode(f_acc_type(f.nbs),'SN ',(dosq),'SPN',(dosq), 'DSK', (dosq), 0)) dos
                         ,min (accc)  isp, s080
                    from OTC_FF7_HISTORY_ACC f
                    where f.datf=dat_
                      and f.tpa in (2, 3)
                      and not exists
                      (select 1 from OTC_FF7_HISTORY_ACC f1 where nvl(f.nkd, f.nd) = nvl(f1.nkd, f1.nd) and f1.datf=datp_
                               and ((f1.ostq_kd <> 0 ) -- ���� � ������� ������ ����� �� �������� = 0, � � ���� <> 0  - ������� �����
                                     OR (f1.nbs in ('2202','2203') and f1.ostq_kd = 0 ) )

                      )
                    group by nvl(kv_dog, kv), cc,k111, lpad(nvl(kv_dog, kv),3,'0'), s245, nvl(nkd,nd), rnk,
                             decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), s080
                    order by 1)
    select nls, kv, dt, 'B2'||k1||k2||k3||s080||'00'||k4||s245 kodp, dos znap, nd, rnk, comm, nbuc, userid_,isp
    from kred
    where nvl(dos,0) <> 0);

    logger.info ('P_FF8: etap 12-7 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

    INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid,isp)
    select nls, kv, dt, 'B3'||k1||k2||k3||s080||'00'||k4||s245 kodp, dos znap, nd, rnk, comm, nbuc, userid_,isp
    from (select min(nls) nls, nvl(kv_dog, kv) kv, dat_ dt, cc||k111 k1,
                             max(f.s260) k2, max(s032) k3, lpad(nvl(kv_dog, kv),3,'0') k4, s245, 
                             max((case substr(nd,1,1) when '�' then null when '-' then null else nd end)) nd, rnk,
                             nvl(nkd,nd) comm,
                             decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                             1 cnt,
                             sum(decode(f_acc_type(f.nbs),'SN ',(dosq), 'SPN',(dosq), 'DSK', (dosq), 0)) dos
                            ,min (accc)  isp, s080
                        from OTC_FF7_HISTORY_ACC f
                        where f.datf=dat_
                              and f.tpa in (2, 3)
                             --������������ �������� - ��� ����������� (���� � 03 ����������), �� �� ����� (��� � 07 ����������) � �� �������� (��� � 08 ����������)
                              and nvl(nkd,nd) in
                                     (SELECT R.COMM
                                        FROM RNBU_TRACE R
                                       WHERE R.KODP LIKE 'A3%' OR R.KODP LIKE 'A8%'
                                             minus
                                      SELECT R.COMM
                                        FROM RNBU_TRACE R
                                       WHERE R.KODP LIKE 'A7%')
                        group by nvl(kv_dog, kv), cc,k111, lpad(nvl(kv_dog, kv),3,'0'), s245, nvl(nkd,nd), rnk,
                                 decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ), s080
                        having sum(decode(f_acc_type(f.nbs),'SN ',(dosq), 'SPN',(dosq), 'DSK', (dosq), 0)) <> 0);

    logger.info ('P_FF8: etap 12-8 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

    INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid,isp)
    select *
    from (
        with kred as (select min(nls) nls, nvl(kv_dog, kv) kv, dat_ dt, cc||k111 k1,
                             max(f.s260) k2, max(s032) k3, lpad(nvl(kv_dog, kv),3,'0') k4, s245,
                             max((case substr(nd,1,1) when '�' then null when '-' then null else nd end)) nd, rnk,
                             nvl(nkd,nd) comm,
                             decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                             1 cnt,
                             sum(decode(f_acc_type(f.nbs),'SN ',(kosq), 'SPN', /*(-dosq+kosq)*/ (kosq), 'DSK', (kosq), 0)) kos
                             ,min (accc)  isp, s080
                        from OTC_FF7_HISTORY_ACC f
                        where f.datf=dat_ and
                          f.ostq_kd = 0 and
                          f.tpa in (2, 3) and
                          (f.nkd is not null and
                           f.nkd in (SELECT F1.NKD
                                       FROM OTC_FF7_HISTORY_ACC F1
                                      WHERE  F1.DATF = datp_
                                            AND F1.OSTQ_KD = 0)
                                             or
                           f.nkd is null and
                           f.nd in (SELECT F1.ND
                                       FROM OTC_FF7_HISTORY_ACC F1
                                      WHERE  F1.DATF = datp_
                                            AND F1.OSTQ_KD <= 0) )
                          and f.nd not in (select nd from otcn_ff8_migr_nd)
                         group by nvl(kv_dog, kv), cc,k111, lpad(nvl(kv_dog, kv),3,'0'), s245, nvl(nkd,nd), rnk,
                                  decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), s080
                        order by 1)
        select nls, kv, dt, 'B4'||k1||k2||k3||s080||'00'||k4||s245 kodp, kos znap, nd, rnk, comm, nbuc, userid_,isp
        from kred kk
        where nvl(kos,0) <> 0
          and kk.comm in (select r.comm from rnbu_trace r where r.kodp like 'A8%'));

    logger.info ('P_FF8: etap 12-9 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

    INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid,isp)
    select nls, kv, dt, 'B5'||k1||k2||k3||s080||'00'||k4||s245 kodp, abs(kos) znap, nd, rnk, comm, nbuc, userid_,isp
    from (select min(nls) nls, nvl(kv_dog, kv) kv, dat_ dt, cc||k111 k1,
                         max(f.s260) k2, max(s032) k3, lpad(nvl(kv_dog, kv),3,'0') k4, s245,
                         max((case substr(nd,1,1) when '�' then null when '-' then null else nd end)) nd, rnk,
                         nvl(nkd,nd) comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         1 cnt,
                         sum(decode(f_acc_type(f.nbs),'SN ',(kosq), 'SPN', /*(-dosq+kosq)*/ (kosq), 'DSK', (kosq), 0)) kos
                         ,min (accc)  isp, s080
                    from OTC_FF7_HISTORY_ACC f
                    where f.datf=dat_
                          and f.tpa in (2, 3)
                          and f.nd not in (select nd from otcn_ff8_migr_nd)
                          --������������ �������� - ��� ����������� (���� � 03 ����������), �� �� ����� (��� � 07 ����������) � �� �������� (��� � 08 ����������)
                          and nvl(nkd,nd) in
                                 (SELECT R.COMM
                                    FROM RNBU_TRACE R
                                   WHERE R.KODP LIKE 'A3%' OR R.KODP LIKE 'A8%'
                                         minus
                                  SELECT R.COMM
                                    FROM RNBU_TRACE R
                                   WHERE R.KODP LIKE 'A7%')
                    group by nvl(kv_dog, kv), cc,k111, lpad(nvl(kv_dog, kv),3,'0'), s245, nvl(nkd,nd), rnk,
                             decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), s080
                    having sum(decode(f_acc_type(f.nbs),'SN ',(kosq), 'SPN', /*(-dosq+kosq)*/ (kosq), 'DSK', (kosq), 0))<>0);

    logger.info ('P_FF8: etap 12-10 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

    --��� ��� ��������� �� ��� �������� ���������� 13 � 15 �� 12 � 14
    if 300465 in (mfo_) then
       update rnbu_trace
       set kodp = decode(substr(kodp,1,2),'B3','B2','B5','B4')||substr(kodp,3)
       where substr(kodp,1,2) in ('B3','B5') and nls like '1%'
       ;
    end if;

    logger.info ('P_FF8: etap 12-11 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

    --��� C�������� ��������� 18 ����������  ��� ������ % � �������� - ���� ��� ������/��������� �� ������ ��������� �����
    -- ������ ������� ������������ ���������� 18 ��� ��� ����� 13 � 15
    -- � ��� ���� 15 ����� ���������� ���������� � ������������� ���������
    -- ��������� � ��������� ������� ������������ �������������
    -- ����� ������� ��� (������ ��) ���������� 18 ��������� ������ ��� ���� 15
   If nvl(GetGlobalOption('OB22'),0) = 1 or 300465 in (mfou_) then
       update rnbu_trace kk
       set kodp = 'B8'||substr(kodp,3), znap=decode(substr(kodp,1,2),'B2',znap, 'B3',znap, -znap)  --, znap=decode(substr(kodp,1,2),'13',znap, -znap)
       where --��� ������/��������� �� ������ ��������� �����
             substr(kk.kodp,1,2) in ('B2','B3','B4','B5')
          and not exists (select 1 from rnbu_trace r,
                          kl_f3_29 n
                          where substr(r.nls,1,4) = n.r020
                            and nvl(n.s240,'0') = '0'
                            and n.kf='F7'
                            and r.comm = kk.comm
                            and substr(r.kodp,1,2) not in ('A0','A3','A7','A8','A9') )
          --�������� ����� % � ��������
          and exists(select 1
                     from kl_f3_29 n
                     where substr(kk.nls,1,4) = n.r020
                       and nvl(n.s240,'0') = '1'
                       and n.kf='F7');
   End if;

   logger.info ('P_FF8: etap 12-12 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

   if mfou_ not in (300465) then    -- ���� ������ ��� ������� 353575
      update rnbu_trace kk
      set kodp = 'B8'||substr(kodp,3), znap=decode(substr(kodp,1,2),'B2',znap, 'B3',znap, -znap)
      where --��� ������/��������� �� ������ ��������� �����
          substr(kk.kodp,1,2) in ('B2','B3','B4','B5')
          and not exists (select 1 from rnbu_trace r,
                          kl_f3_29 n
                          where substr(r.nls,1,4) = n.r020
                            and nvl(n.s240,'0') = '0'
                            and n.kf='F7'
                            and r.comm = kk.comm
                            and substr(r.kodp,1,2) not in ('A0','A3','A7','A8','A9') )
          --�������� ����� % � ��������
          and exists(select 1
                     from kl_f3_29 n
                     where substr(kk.nls,1,4) = n.r020
                       and nvl(n.s240,'0') = '1'
                       and n.kf='F7');
   end if;

   logger.info ('P_FF8: etap 12-13 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

    --  18 - ��������� � ������ ������������� - ������
   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid,isp)
    select *
    from (
    with kred as (select min(nls) nls, nvl(kv_dog, kv) kv, dat_ dt, cc||k111 k1,
                         max(f.s260) k2, max(s032) k3, lpad(nvl(kv_dog, kv),3,'0') k4, s245, 
                         max((case substr(nd,1,1) when '�' then null when '-' then null else nd end)) nd, rnk,
                          /*'ʳ������ ������� - '||to_char(count(*))*/nvl(nkd,nd) comm,
                          decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                          1 cnt,
                          sum(dosq) dos, sum(kosq) kos
                          ,min (accc)  isp, s080
                    from OTC_FF7_HISTORY_ACC f
                    where f.datf=dat_ and
                          f.tpa in (2, 3) and
                          f.tip not in ('OVR', 'W4B')
                    group by nvl(kv_dog, kv), cc,k111, lpad(nvl(kv_dog, kv),3,'0'), s245, nvl(nkd,nd), rnk,
                             decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), s080
                    order by 1)
    select nls, kv, dat_, 'B8'||k1||k2||k3||s080||'00'||k4||s245 kodp, dos-kos  znap, nd, rnk, comm, nbuc, userid_ ,isp
    from kred kk
    where dos-kos<>0
         and not exists (select 1
                         from rnbu_trace r
                         where substr(r.kodp,1,2) not in ('B3','B4','B5','B8') and
                               r.comm = kk.comm));

logger.info ('P_FF8: etap 13 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

    --  18 - �������� ������� �������� � �����������
   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid,isp)
    select *
    from (
    with kred as (select min(f.nls) nls, nvl(f.kv_dog, f.kv) kv, dat_ dt, 
                         f.cc||f.k111 k1,
                         max(f.s260) k2, max(f.s032) k3, 
                         lpad(nvl(f.kv_dog, f.kv),3,'0') k4, f.s245,
                         max(case substr(f.nd,1,1) when '�' then null when '-' then null else f.nd end) nd, 
                         f.rnk,
                         '�������� �������  ND = ' || nvl(f.nkd, f.nd) comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         1 cnt,
                         sum(f.ostq) ostq, sum(f1.ostq) ostqp,
                         min (f.accc) isp, f.s080
                    from OTC_FF7_HISTORY_ACC f, OTC_FF7_HISTORY_ACC f1 
                    where f.datf = dat_ 
                      and f.kv <> 980 
                      and f.dosq + f.kosq = 0  
                      and f1.datf = datp_
                      and f1.acc = f.acc 
                      and f.ost = f1.ost 
                      and  f1.ostq <> f.ostq
                    group by nvl(f.kv_dog, f.kv), f.cc, f.k111, 
                             lpad(nvl(f.kv_dog, f.kv),3,'0'), f.s245, 
                             nvl(f.nkd,f.nd), f.rnk,
                             decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), 
                             f.s080
                    order by 1)
    select nls, kv, dat_, 'B8'||k1||k2||k3||s080||'00'||k4||s245 kodp, ABS(ostq - ostqp) znap, 
           nd, rnk, comm, nbuc, userid_ ,isp
    from kred kk
   );

logger.info ('P_FF8: etap 13-1 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

-- AlexY ��������� ������������ ����� � �����������
FOR K IN
(SELECT ndo.acc,
        o.nls,
        o.kv,
        ndo.nd
   FROM otcn_acc o,
        (SELECT a.*, b.nd
           FROM (SELECT acc, MAX (datf) datf
                     FROM otc_ff7_history_acc
                     where datf < dat_
                 GROUP BY acc) a,
                otc_ff7_history_acc b
          WHERE a.acc = b.acc AND a.datf = b.datf) ndo
  WHERE     o.acc = ndo.acc
        AND tip = 'SS'
        AND dapp IS NOT NULL
        AND (dazs IS NULL OR dazs > dat_)
        AND o.acc NOT IN (SELECT acc FROM otcn_saldo)
        AND ndo.nd not in (select to_char(nd) from cc_deal where sos = 15 and wdate <= dat_)
        AND nls LIKE '2%'
        AND nd IN (SELECT DISTINCT TO_CHAR (NVL (nd, 0))
                     FROM rnbu_trace
                    WHERE kodp LIKE 'A3%')
        AND (nd, kv) NOT IN (SELECT DISTINCT TO_CHAR (NVL (nd, 0)), kv
                               FROM rnbu_trace
                              WHERE kodp LIKE 'A3%')
        AND nd NOT IN (SELECT to_char(c.nd) FROM cc_deal c WHERE c.nd = c.ndi))
loop
   for t in (select * from rnbu_trace where kodp like 'A3%' and to_char(nd) = k.nd)
   loop
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid,isp)
      VALUES (k.nls,k.kv,t.odate,substr(t.kodp,1,12)||lpad(to_char(k.kv),3,'0')||substr(t.kodp,16,1),1, t.nd, t.rnk, t.comm, t.nbuc, t.userid, t.isp);
   END LOOP;
END LOOP;

logger.info ('P_FF8: etap 14 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

FOR K IN

(SELECT nls,
        kv,
        dat_ odate,
           'A3'
        || (SELECT TRIM (f.ddd)
              FROM kl_f3_29 f
             WHERE f.kf = 'F7' AND f.r020 = SUBSTR (nls, 1, 4))
        || NVL ( (SELECT k111
                    FROM kl_k110 k
                   WHERE     k.k110 IN (SELECT ved
                                          FROM customer
                                         WHERE rnk = cc_v.rnk)
                         AND d_open <= dat_spr_
                         AND (d_close IS NULL OR d_close > dat_spr_)),
                '00')
        || f_get_s260 (nd,
                       acc,
                       (SELECT s260
                          FROM specparam
                         WHERE acc = cc_v.acc),
                       rnk,
                       SUBSTR (nls, 1, 4),
                       0)
        || f_get_s032 (acc,
                       dat_,
                       NULL,
                       nd)
        || s080
        || '00'
        || kv || '1'
           kodp,
        1 znap,
        nd,
        rnk,
        nd comm,
        DECODE (typ_, 0, nbuc1_, NVL (F_Codobl_Tobo (acc, typ_), nbuc1_))
           nbuc,
        (SELECT isp
           FROM accounts
          WHERE acc = cc_v.acc)
           isp
   FROM cc_v
  WHERE     vidd IN (1, 2, 3)
        AND dsdate <= dat_
        AND (dazs IS NULL OR dazs > dat_)
        AND nls NOT LIKE '9%'
        AND nd NOT IN (SELECT DISTINCT NVL (nd, 0) FROM rnbu_trace)
        AND nd NOT IN (SELECT ND FROM cc_deal c WHERE c.nd = c.ndi)
        AND EXISTS
               (SELECT 1
                  FROM saldoa
                 WHERE acc = cc_v.acc8 AND dos <> 0 AND fdat between trunc(dat_, 'mm') and dat_))
loop

    if substr(k.kodp, 3, 2) like '21%' and
       substr(k.kodp, 10, 1) in ('0','1','2','3','4','5')
    then
        kodp_ := substr(k.kodp,1,9) || 'A' || substr(k.kodp,11);
    END IF;

    IF SUBSTR(k.kodp, 3, 2) NOT LIKE '21%' AND
       SUBSTR(k.kodp, 10, 1) IN ('0','1','2','3','4','5')
    THEN
        kodp_ := SUBSTR(k.kodp,1,9) || 'M' || SUBSTR(k.kodp,11);
    END IF;

    INSERT INTO rnbu_trace (nls,
                        kv,
                        odate,
                        kodp,
                        znap,
                        nd,
                        rnk,
                        comm,
                        nbuc,
                        userid,
                        isp)
     VALUES (k.nls,
             k.kv,
             k.odate,
             kodp_,
             k.znap,
             k.nd,
             k.rnk,
             k.comm,
             k.nbuc,
             userid_,
             k.isp);

END LOOP;

logger.info ('P_FF8: etap 15 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

update rnbu_trace set kodp = decode(substr(kodp,1,2),'A3','20','B2','21','B3','22','B4','23','B5','23','B6','24','B7','25','B8','26',substr(kodp,1,2))||substr(kodp,3);

delete from rnbu_trace where kodp like 'A%' or kodp like 'B%';

-- ��������� ���������� ��������, ��� �� ���� ���� ��������� ��� ������� � ��������� ������� = 0
--delete 
--from rnbu_trace
--where kodp like '20%' and
--      trim(nvl(trim(to_char(nd)), comm)) in (
--        select f.nd
--        from  OTC_FF7_HISTORY_ACC f
--        Where f.datf = dat_ and
--              f.ostq_kd = 0 and
--              f.WDATE <= dat_);

----------------------------------------------------
if mfo_ = 380764 then
   update rnbu_trace
   set kodp = substr(kodp, 1, 4)||'00'||substr(kodp, 7)
   where substr(kodp, 3,2) in ('31', '32', '33', '34', '35', '38');
end if;
----------------------------------------------------
DELETE FROM tmp_nbu where kodf=kodf_ and datf= dat_;
---------------------------------------------------
INSERT INTO tmp_nbu(kodf, datf, kodp, nbuc, znap)
select kodf_, Dat_, kodp, nbuc, znap from
(
SELECT kodp, nbuc, SUM(znap) znap
FROM rnbu_trace
GROUP BY kodp, nbuc
) where znap<>0;

otc_del_arch(kodf_, dat_, 0);
OTC_SAVE_ARCH(kodf_, dat_, 0);
commit;

logger.info ('P_FF8: End for datf = '||to_char(dat_, 'dd/mm/yyyy'));
----------------------------------------
--exception
--    when others then
--        logger.info ('P_FF8: errors '||sqlerrm||' for datf = '||to_char(dat_, 'dd/mm/yyyy'));
END;
/

