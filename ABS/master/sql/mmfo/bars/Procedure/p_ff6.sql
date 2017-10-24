

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FF6.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FF6 ***

  CREATE OR REPLACE PROCEDURE BARS.P_FF6 (Dat_ DATE)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : ��������� ������������ ����� #F6 ��� ��
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 08/10/2013 (07/02/2013)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
���������: Dat_ - �������� ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
05/02/2013 - ��������� �� KL_K110 (���� �������� � �������� ����������)
17/12/2012 - ��������� �� KL_K110
11/10/2012 - ��������� � ������� ����� ����������
08/05/2012 - ��������� S280, s290 ������� �i����� � �� ��� i� ���
26/04/2012 - �������� ���. ��� ���� i��� ��������� ���� ���������
             (�������� ����� ��� ���� 06.07.2011)
12/12/2011 - ��������� ����� ���������� ��������� S280 �� S290
08/12/2011 - ������������� ��� ����� �����
07/07/2011 - ���� ���������� ��������� S280 �� S290, �� ������ �i���������
06/07/2011 - ����������� ������� (������ S290 � ������ �������� �����������
             S280 � �������).
06/05/2011 - �� �������� � ���� �����������, � ����� S280 �� S290 = 0
12.03.2011 - ��� ���.����� 3548 � ��������� S280 �������� ������ �������
             ��������� �������� f_get_s280(dat_,a.acc, null,a.acc ) �
             �������� ������ �� SPECPARAM
03.12.2010 - ��� ����.KL_S031 ������� ������� "D_CLOSE is NULL" �.�.
             ���������� ���������� ����.
22.10.2010 - �������� S280, S290 ��������� ��� MAX �� ���� ���� ��������
             ��� ���� ������ � ���� ��������� ������� � ���� ��� ���
             ��������� � ������� ����������� ����� ���������
04/10/2010 - ��������� S280,S290 ��������� ��� max �� RNK ������ (nd,nkd)
             � ������� ���� ND Varchar2(100) ������� � ������� ���������
             ���������� ��������
15/07/2010 - ������ to_char(-a.acc) ����� -a.acc �.�. ���� ND ��������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

kodf_    varchar2(2):='F6';
sheme_   varchar2(1);

acc_     Number;
userid_  Number;

mfo_    number;
mfou_   number;

typ_     number;
nbuc_    varchar2(12);
nbuc1_   varchar2(12);

dat_spr_    date := last_day(dat_)+1;

BEGIN
-------------------------------------------------------------------
userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
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

if 300465 in (mfo_, mfou_) then
   sheme_ := 'C';
else
   sheme_ := 'G';
end if;

-- ����������� ��������� ���������� (��� ������� ��� ��� ��� �������������)
P_Proc_Set(kodf_,sheme_,nbuc1_,typ_);
nbuc_ := nbuc1_;

delete from otc_ff6_history_acc where datf=dat_;
--�������� ����������� ������ �� �7 �����
insert into otc_ff6_history_acc
  (DATF,ACC,ACCC,NBS,SGN,NLS,KV,KV_DOG,NMS,DAOS,DAZS,OST,OSTQ,DOSQ,KOSQ,ND,
   NKD,SDATE,WDATE,SOS,RNK,STAFF,TOBO,S260,K110,K111,S031,S032,CC,TIP,OSTQ_KD,R_DOS,CC_ID, S280, S290)
select DATF,o.ACC,o.ACCC,NBS,SGN,NLS,KV,KV_DOG,NMS,DAOS,DAZS,OST,OSTQ,DOSQ,KOSQ,ND,
   o.NKD,SDATE,WDATE,SOS,RNK,STAFF,TOBO,o.S260,o.K110,o.K111,o.S031,o.S032,nvl(trim(s.r011),'0'), f_acc_type(NBS),
   0,R_DOS,CC_ID, trim(s.s280), trim(s.s290)
from otc_ff7_history_acc o, specparam s
where datf=dat_ and o.acc = s.acc(+) and
    o.nbs in (select r020 from kod_r020 where a010 = 'F6' and (d_close is null or d_close > dat_spr_));
--union all
--��������� ����� 3548, ������� ��� � �7 �����
-- 3548 ���� � �7!!!
--select
--    dat_, a.acc, a.isp,a.NBS, decode(sign(s.ostf-s.dos+s.kos),-1,'1',1,'2','0'),
--    a.NLS,a.KV,null,a.NMS,a.DAOS,a.DAZS,
--    s.ostf-s.dos+s.kos ost,
--    decode(a.kv, 980, s.ostf-s.dos+s.kos, gl.p_icurval(a.kv,s.ostf-s.dos+s.kos, dat_)) ostq,s.DOSQ,s.KOSQ, to_char(-a.acc),
--    null,null,null,null, a.RNK,user_id,a.TOBO,p.S260,z.ved,
--    nvl((select k111 from kl_k110 k where k.k110=z.ved and d_open <= dat_spr_ and (d_close is null or d_close > dat_spr_)),'00'),
--    p.S031,nvl((select s032 from kl_s031 k where k.s031=p.s031 and (k.d_close is null or k.d_close > dat_)),'0'),
--    nvl(p.r011,'0'), null,
--    s.ostf-s.dos+s.kos,0,null,nvl(p.s280,'0'),nvl(p.s290,'0')
--from accounts a,
--     specparam p,
--     saldoa s,
--     customer z
--where a.nbs = '3548' and
--      (s.fdat,s.acc)  = (select max(fdat),acc from saldoa ss where a.acc = ss.acc and ss.fdat <= dat_ group by acc) and
--      a.acc = p.acc(+) and
--      a.rnk = z.rnk and
--      s.ostf-s.dos+s.kos <> 0 ;

--��������� ��������� S280 � S290 �� ������ ���������, ���� ��� �� ��������� � specparam
update otc_ff6_history_acc
set s280 = decode(trim(tip),'SP',decode(nvl(s280,'*'),'*',f_get_s280(dat_,acc, null,acc ),s280),null),
    s290 = decode(trim(tip),'SPN',decode(nvl(s290,'*'),'*',f_get_s290(dat_,acc, null,acc ),s290),null),
    --������ �� ������ ��������� ����������� ������� �� ����� � ���� OSTQ_KD
    OSTQ_KD = OSTQ
where datf=dat_ and trim(tip) in ('SP','SPN');

INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, tobo, userid, isp)
select nls, kv, datf,
       decode(sign(ostq),-1,1,2)||nbs||nvl(cc,'0')||nvl(k111,'00')||nvl(s260,'00')||nvl(s032,'0')||nvl(s280,'0')||nvl(s290,'0')||kv,
       abs(ostq) ostq, (case substr(nd,1,1) when '�' then null when '-' then null else nd end), rnk, nvl(nkd, nd),
       nbuc, tobo, userid_, isp
from
(select datf,acc, nbs, nls, nd, nkd,
        NVL(max(s280) over(partition by rnk ),'0') s280
       ,NVL(max(s290) over(partition by rnk),'0') s290
       ,ostq,ostq_kd,
        sum(ostq_kd) over(partition by rnk ) sm_expire  --����� ���� ��������� �� �������
                                                        --�������� ������ ��� 40-511/5019-18275 �� 20.10.2010
       ,cc,
        k111,
        NVL(max(s260) over(partition by nd),'00') s260,
        s032, kv, rnk, decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(acc,typ_), nbuc1_) ) nbuc, 0 tobo, accc isp
from otc_ff6_history_acc where datf=dat_
)
where sm_expire <> 0 and ostq <> 0 and (s280<>'0' or s290<>'0');
-----------------------------------------------------------------------------
if mfo_ = 380764 then
   update rnbu_trace
   set kodp = substr(kodp, 1, 6)||'00'||substr(kodp, 9)
   where substr(kodp, 2, 2) = '22';
end if;
-------------------------------------------------------------------------------
DELETE FROM tmp_nbu where kodf=kodf_ and datf= dat_;
---------------------------------------------------
INSERT INTO tmp_nbu(kodf, datf, kodp, nbuc, znap)
SELECT kodf_, Dat_, kodp, nbuc, SUM(znap)
FROM rnbu_trace
GROUP BY kodp, nbuc;
----------------------------------------
END;
/
show err;

PROMPT *** Create  grants  P_FF6 ***
grant EXECUTE                                                                on P_FF6           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FF6           to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FF6.sql =========*** End *** ===
PROMPT ===================================================================================== 
