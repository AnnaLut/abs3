

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DPT_INV.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DPT_INV ***

  CREATE OR REPLACE PROCEDURE BARS.DPT_INV 
 (mode_   int ,
  p_DAT   date,
  BRANCH_ varchar2
  ) IS

l_cont varchar2(100);  -- ��� ������������ ��������
l_kk   integer;
/*
11.09.2015 nvv mode_=1    � ��������� �� draps �� ������������� ���������� ��� ������� � �������� 0
               mode_=100  � ��������� �� draps �� ������������� ���������� ��� ������� � �������� 0

18.01.2011 qwa ������� �� ������ ���� ������� (���� � �������� �� ��������)
               +����� ����������+������ �� �������� ������� tmp_dpt_inv

10.12.2010 qwa ������������������ ���������. ���� ������ - ���� ���� ���������� � ���������
               ���� ������ � �� ���� ���������� %% - �� ���� ������ � ������������� ��������
               �� ������ ����������� %% � �����. ����� ��������  �� ����������.

02.04.2010 Qwa
 �������� 102  -  ���������  �� ���.���, � ���� 096
                 �������� ��� ������, ���� ������� � ��������,
                 �� � ������� \BRS\SBM\REP\31\7
                 �������� �� ��������� P_SAL_SNP
                 - �� ��������� �� ������
04.02.2010 Qwa
  1. ��� ���������� 100,101 (�������� � ���������������)
                 ���������� ���������� �� 02.02.2010
  2. ����� �������� 102 ��� �������� ��������� �� ���� 11
     ������ 2620,2628,2630,2635,2638  ������� ������ �����

02.02.2010 Qwa
  1. ������������ ������������� �������� ������ ��� ���, ��� ��� ����
  ��� 2 � 3 ������ ��� ������������ ��������� ������������ �������������
  - ��� �����
  2. �� ������������� ������ ��������� ����� ������ ����

28.01.2010 Qwa

   1. ������� ��������� �� dpt_deposit_clos - ��� ��������� ���, ������� ��������� ����� ���� ������
   2. �������� ��� ��������  2620_07 - �������� "�������? �����?���"
      �������� ��� ��������  99998   - �������� "?��? �� ��22"
                             99999   -          "�������? ����"
   3. ������� ����� ���� � ����������� ���� (���������� add cck_an_tmp.nlsalt)
   ��������  �� ��������
   =======================================================
   1 - ���� ���������� ��������
   2 - ���  ���������� ��������
   1 - ���� "_��_ ������_", � �� ��������� (�� ������ � ��������)
   1 - "���� �������_" (�� ������ � ��������)

26.01.2010 Qwa +Sta

mode_ = 0   -  ��������      �� ����, ��� ����
mode_ = 1   -  ������i������ �� ����, ��� ����
mode_ = 100 -  ��������      �� ��.�?�, � ����
mode_ = 101 -  ������i������ �� ��.�?�, � ����
������  �� ��������
=======================================================
1 - ���� ���������� ��������
2 - ���  ���������� ��������
1 - ���� - _��_ ������_, � �� �����_��� (�� ������� � ��������)
1 - ���� �������_ (�� ������� � ��������)
*/

   DAT_  date := p_DAT;
   caldt_ID_ accm_calendar.caldt_ID%type;

begin

  EXECUTE IMMEDIATE 'TRUNCATE TABLE TMP_DPT_INV';
--  bars_audit.info ('dpt_inv === '||' mode_ = '||mode_||' p_dat = '||p_dat||' BRANCH_ = '||BRANCH_);
  l_cont:=sys_context('bars_context','user_branch');
--  bars_audit.info ('dpt_inv === CALDT_ID_ = '||CALDT_ID_||'sys_context = '||l_cont);
  begin

  if mode_ >= 100 then
     DAT_  := to_date  ('01.'||to_char(p_DAT,'mm.yyyy'),'dd.mm.yyyy');
  end if;
  if length(BRANCH_)=8 and mode_ >= 100 then
     -- ������������ ������������� ��������
       bars_accm_sync.sync_AGG('MONBAL', Dat_);
  elsif length(BRANCH_)=8 and mode_ < 100 then
       -- ������������ ������������� �������
       bars_accm_sync.sync_snap('BALANCE', Dat_);
  end if;
  commit;

  select caldt_ID into caldt_ID_ from accm_calendar  where caldt_DATE=Dat_ ;

  EXCEPTION WHEN NO_DATA_FOUND THEN return;
  end;

If mode_ = 0 then  /* �������� �� ����, ��� ����*/
-- bars_audit.info ('dpt_inv === 0'||' mode_ = '||mode_||' p_dat = '||p_dat||' BRANCH_ = '||BRANCH_);
-- bars_audit.info ('dpt_inv ===0 CALDT_ID_ = '||CALDT_ID_||'sys_context = '||l_cont);
 insert into TMP_DPT_INV
        (branch,    nbs,   kv,  ob22,
         vidd,      nmk,
         nls,       ost,   ostq,
         nlsn,      nost,  nostq,
         nlsalt,    prizn )
  select a.branch,  a.nbs, a.kv, s.ob22,
         d.vidd vidd, substr(c.nmk,1,35),
         a.nls,     m.ost,  m.ostq,
         b.nls, decode(a.nls,b.nls,0,n.ost), decode(a.nls,b.nls,0,n.ostq),
         nvl(a.nlsalt,to_char(d.deposit_id)),                  --
         decode(a.nlsalt,null,2,1)                               -- ���������� �� ����=1, ���=2
  from accounts a,
       (select acc,rnk,ost,ostq,caldt_id from ACCM_SNAP_BALANCES where caldt_id=caldt_ID_) m,
       (select a.acc,a.vidd,a.deposit_id,a.idupd
               from dpt_deposit_clos a,
                   (select distinct acc,  deposit_id,
                            max(idupd)  over (partition by acc, deposit_id) idupd
                    from dpt_deposit_clos   ) b
              where a.acc=b.acc and a.deposit_id=a.deposit_id and a.idupd=b.idupd
        ) d,
       (select acc,rnk,ost,ostq,caldt_id from ACCM_SNAP_BALANCES where caldt_id=caldt_ID_) n,
       customer c, int_accn i, accounts b, specparam_int s
  where d.acc=a.acc
    and a.acc=m.acc and   a.nbs not like '8%'  and a.nls not like '8%'
    and ( a.dazs is null or a.dazs > p_dat)
    and m.rnk=c.rnk
    and i.acc=a.acc
    and i.id =1
    and i.acra=b.acc
    and a.branch like BRANCH_||'%'
    and a.branch like sys_context('bars_context','user_branch')||'%'
    and n.acc(+)=b.acc
    and a.acc=s.acc(+)
union all
  select a.branch, a.nbs,a.kv,s.ob22,
         decode(a.nbs,'2620',decode(s.ob22,'07',262007,99998),99998) vidd,             -- _��_ ������_ �� ��22 (�������_)
         substr(c.nmk,1,35),                                                     -- � �.�. 262007 �������_ �����_���
         a.nls, m.ost,m.ostq,
         b.nls, decode(a.nls,b.nls,0,n.ost), decode(a.nls,b.nls,0,n.ostq),
         a.nlsalt, 1
  from accounts a,
       (select acc,rnk,ost,ostq,caldt_id from ACCM_SNAP_BALANCES where caldt_id=caldt_ID_) m,
       customer c, int_accn i,   accounts b, specparam_int s,
       (select acc,rnk,ost,ostq,caldt_id from ACCM_SNAP_BALANCES where caldt_id=caldt_ID_) n
  where a.acc not in (select acc from dpt_deposit_clos)
    and ((newnbs.g_state = 1 and a.nbs in ('2620','2630')) or (newnbs.g_state = 0 and a.nbs in ('2620','2630','2635')))
    and a.acc=m.acc and   a.nbs not like '8%'   and a.nls not like '8%'
    and ( a.dazs is null or a.dazs > p_dat)
    and m.rnk=c.rnk
    and i.acc=a.acc
    and i.id =1
    and i.acra=b.acc
    and a.branch like BRANCH_||'%'
    and a.branch like sys_context('bars_context','user_branch')||'%'
    and n.acc(+)=b.acc
    and a.acc=s.acc(+)
union all
  select a.branch, a.nbs,a.kv,s.ob22,
         decode(a.nbs,'2620',decode(s.ob22,'07',262007,99999),99999) vidd,
         substr(c.nmk,1,35),    -- ���� �������
         a.nls, m.ost,m.ostq,
         '', 0, 0, a.nlsalt, 1
  from accounts a,
       (select acc,rnk,ost,ostq,caldt_id from ACCM_SNAP_BALANCES where caldt_id=caldt_ID_) m,
        customer c,   specparam_int s
  where a.acc not in (select acc from dpt_deposit_clos)
    and ((newnbs.g_state = 1 and a.nbs in ('2620','2630')) or (newnbs.g_state = 0 and a.nbs in ('2620','2630','2635')))
    and a.acc=m.acc and   a.nbs not like '8%'   and a.nls not like '8%'
    and ( a.dazs is null or a.dazs > p_dat)
    and m.rnk=c.rnk
    and not exists (select 1 from int_accn i where a.acc=i.acc and i.id=1 and i.acra is not null)
    and a.branch like BRANCH_||'%'
    and a.branch like sys_context('bars_context','user_branch')||'%'
    and a.acc=s.acc(+)
     ;

ElsIf mode_ = 1 then  /* ������i������ �� ����, ��� ���� */
--bars_audit.info ('dpt_inv === 1'||' mode_ = '||mode_||' p_dat = '||p_dat||' BRANCH_ = '||BRANCH_);
--bars_audit.info ('dpt_inv === 1 CALDT_ID_ = '||CALDT_ID_||'sys_context = '||l_cont);
  insert into TMP_DPT_INV
  (branch,
      nbs,
       kv,
     ob22,
     vidd,
      ost,
     ostq,
     nost,
    nostq,
      kol)
  select a.branch,     a.nbs,   a.kv,   a.ob22,
         d.vidd vidd,  sum(nvl(m.ost,0)), sum(nvl(m.ostq,0)),
         sum(decode(a.nls,b.nls,0,nvl(n.ost,0))), sum(decode(a.nls,b.nls,0,nvl(n.ostq,0))), count(*)
  from accounts a
       left outer join
       (select acc,rnk,ost,ostq,caldt_id from ACCM_SNAP_BALANCES where caldt_id=caldt_ID_) m on (a.acc = m.acc),
       (select a.acc,a.vidd,a.deposit_id,a.idupd
               from dpt_deposit_clos a,
                   (select distinct acc,  deposit_id,
                            max(idupd)  over (partition by acc, deposit_id) idupd
                    from dpt_deposit_clos   ) b
              where a.acc=b.acc and a.deposit_id=a.deposit_id and a.idupd=b.idupd
       ) d,
       int_accn i,
          accounts b
              left outer join
          (select acc,rnk,ost,ostq,caldt_id from ACCM_SNAP_BALANCES where caldt_id=caldt_ID_) n  on (b.acc = n.acc)
  where d.acc=a.acc
    and a.nbs not like '8%'     and a.nls not like '8%'
    and ( a.dazs is null or a.dazs > p_dat)
    and i.acc=a.acc
    and i.id=1
    and i.acra=b.acc
    and a.branch like BRANCH_||'%'
    and a.branch like sys_context('bars_context','user_branch')||'%'
    group by a.branch, a.nbs,a.kv,a.ob22,d.vidd
union all
   select a.branch, a.nbs,a.kv, a.ob22,
          decode(a.nbs,'2620',decode(a.ob22,'07',262007,99998),99998) vidd,       -- _��_ ������_ �� ��22 (�������_)
           sum(m.ost), sum(m.ostq),                                               -- � �.�. 262007 �������_ �����_���
           sum(decode(a.nls,b.nls,0,n.ost)), sum(decode(a.nls,b.nls,0,n.ostq)), count(*)
  from accounts a
       left outer join
       (select acc,rnk,ost,ostq,caldt_id from ACCM_SNAP_BALANCES where caldt_id=caldt_ID_) m on (a.acc = m.acc),
       int_accn i,
        accounts b
         left outer join
       (select acc,rnk,ost,ostq,caldt_id from ACCM_SNAP_BALANCES where caldt_id=caldt_ID_) n on (b.acc = n.acc)
  where a.acc not in (select acc from dpt_deposit_clos)
    and ((newnbs.g_state = 1 and a.nbs in ('2620','2630')) or (newnbs.g_state = 0 and a.nbs in ('2620','2630','2635')))
    and a.acc=m.acc
    and a.nbs not like '8%'     and a.nls not like '8%'
    and ( a.dazs is null or a.dazs > p_dat)
    and i.acc=a.acc
    and i.id=1
    and i.acra=b.acc
    and a.branch like BRANCH_||'%'
    and a.branch like sys_context('bars_context','user_branch')||'%'
  group by a.branch, a.nbs,a.kv,a.ob22
  union all                                                  -- ���� �������
   select  a.branch, a.nbs,a.kv, a.ob22,
           decode(a.nbs,'2620',decode(a.ob22,'07',262007,99999),99999) vidd,
           sum(m.ost), sum(m.ostq),   0, 0, count(*)
  from accounts a
       left outer join
        (select acc,rnk,ost,ostq,caldt_id from ACCM_SNAP_BALANCES where caldt_id=caldt_ID_) m on (a.acc = m.acc)
  where a.acc not in (select acc from dpt_deposit_clos)
    and ((newnbs.g_state = 1 and a.nbs in ('2620','2630')) or (newnbs.g_state = 0 and a.nbs in ('2620','2630','2635')))
    and  a.nbs not like '8%'   and a.nls not like '8%'
    and ( a.dazs is null or a.dazs > p_dat)
    and  not exists (select 1 from int_accn i where a.acc=i.acc and i.id=1 and i.acra is not null)
    and a.branch like BRANCH_||'%'
    and a.branch like sys_context('bars_context','user_branch')||'%'
  group by a.branch, a.nbs,a.kv,a.ob22;

ElsIf mode_ = 100 then  /* �� ��.���, � ����*/

--bars_audit.info ('dpt_inv === 100'||' mode_ = '||mode_||' p_dat = '||p_dat||' BRANCH_ = '||BRANCH_);
--bars_audit.info ('dpt_inv === 100 CALDT_ID_ = '||CALDT_ID_||'sys_context = '||l_cont);

  insert into TMP_DPT_INV (branch,  nbs,  kv,  ob22, vidd,  nmk,  nls,  ost,  ostq, nlsn, nost, nostq,  nlsalt, prizn )
  select a.branch,   a.nbs,   a.kv,   a.ob22,   d.vidd vidd,    substr(c.nmk,1,35),
         a.nls, m.ost-m.crdos+m.crkos OST,  m.ostq-m.crdosQ+m.crkosQ OSTQ,
         b.nls, decode(a.nls,b.nls,0,n.ost-n.crdos+n.crkos)    OSTn,
                decode(a.nls,b.nls,0,n.ostq-n.crdosQ+n.crkosQ) OSTQn,
         nvl(a.nlsalt,to_char(d.deposit_id)),                  --
         decode(a.nlsalt,null,2,1)                               -- ���������� �� ����=1, ���=2
  from accounts a left outer join
       (select acc,rnk,ost,ostq,crdos,crkos,crdosQ,crkosQ,caldt_id
          from ACCM_AGG_MONBALS where caldt_id=caldt_ID_) m on (a.acc = m.acc),
       (select a.acc,a.vidd,a.deposit_id,a.idupd
               from dpt_deposit_clos a,
                   (select distinct acc,  deposit_id,
                            max(idupd)  over (partition by acc, deposit_id) idupd
                    from dpt_deposit_clos   ) b
              where a.acc=b.acc and a.deposit_id=a.deposit_id and a.idupd=b.idupd
       ) d,
       customer c, int_accn i, accounts b left outer join
       (select acc,rnk,ost,ostq,crdos,crkos,crdosQ,crkosQ,caldt_id
          from ACCM_AGG_MONBALS where caldt_id=caldt_ID_) n on (b.acc = n.acc)
  where d.acc=a.acc
    and   a.nbs not like '8%'     and a.nls not like '8%'
    and ( a.dazs is null or a.dazs > p_dat)
    and a.rnk=c.rnk
    and i.acc=a.acc
    and i.id =1
    and i.acra=b.acc
    and a.branch like BRANCH_||'%'
    and a.branch like sys_context('bars_context','user_branch')||'%'
    and a.daos < p_DAT
union all
  select a.branch, a.nbs,a.kv,a.ob22,
         decode(a.nbs,'2620',decode(a.ob22,'07',262007,99998),99998) vidd,    -- _��_ ������_ �� ��22 (�������_)
         substr(c.nmk,1,35),
         a.nls, m.ost-m.crdos+m.crkos OST,  m.ostq-m.crdosQ+m.crkosQ  OSTQ,
         b.nls, decode(a.nls,b.nls,0,n.ost-n.crdos+n.crkos)    OSTn,
                decode(a.nls,b.nls,0,n.ostq-n.crdosQ+n.crkosQ) OSTQn,
         a.nlsalt, 1
  from accounts a left outer join
       (select acc,rnk,ost,ostq,crdos,crkos,crdosQ,crkosQ,caldt_id
          from ACCM_AGG_MONBALS where caldt_id=caldt_ID_) m on (a.acc = m.acc),
       customer c, int_accn i, accounts b left outer join
       (select acc,rnk,ost,ostq,crdos,crkos,crdosQ,crkosQ,caldt_id
          from ACCM_AGG_MONBALS where caldt_id=caldt_ID_) n on (b.acc = n.acc)
  where a.acc not in (select acc from dpt_deposit_clos)
    and ((newnbs.g_state = 1 and a.nbs in ('2620','2630')) or (newnbs.g_state = 0 and a.nbs in ('2620','2630','2635')))
    and   a.nbs not like '8%'   and a.nls not like '8%'
    and ( a.dazs is null or a.dazs > p_dat)
    and a.rnk=c.rnk
    and i.acc=a.acc
    and i.id =1
    and i.acra=b.acc
    and a.branch like BRANCH_||'%'
    and a.branch like sys_context('bars_context','user_branch')||'%'
    and a.daos < p_DAT
union all
  select a.branch, a.nbs,a.kv,a.ob22,
         decode(a.nbs,'2620',decode(a.ob22,'07',262007,99999),99999) vidd,
         substr(c.nmk,1,35),    -- ���� �������
         a.nls, m.ost-m.crdos+m.crkos OST, m.ostq-m.crdosQ+m.crkosQ OSTQ,
         '', 0, 0,
         a.nlsalt, 1
  from accounts a left outer join
       (select acc,rnk,ost,ostq,crdos,crkos,crdosQ,crkosQ,caldt_id
          from ACCM_AGG_MONBALS where caldt_id=caldt_ID_) m on (a.acc = m.acc),
       customer c
  where a.acc not in (select acc from dpt_deposit_clos)
    and ((newnbs.g_state = 1 and a.nbs in ('2620','2630')) or (newnbs.g_state = 0 and a.nbs in ('2620','2630','2635')))
    and   a.nbs not like '8%'   and a.nls not like '8%'
    and ( a.dazs is null or a.dazs > p_dat)
    and a.rnk=c.rnk
    and not exists (select 1 from int_accn i where a.acc=i.acc and i.id=1 and i.acra is not null)
    and a.branch like BRANCH_||'%'
    and a.branch like sys_context('bars_context','user_branch')||'%'
    and a.daos < p_DAT
     ;

ElsIf mode_ = 101 then  /* ������i������ �� ��.���, � ���� */
--bars_audit.info ('dpt_inv === 101'||' mode_ = '||mode_||' p_dat = '||p_dat||' BRANCH_ = '||BRANCH_);
--bars_audit.info ('dpt_inv === 101 CALDT_ID_ = '||CALDT_ID_||'sys_context = '||l_cont);
  insert into TMP_DPT_INV (branch, nbs,  kv, ob22, vidd, ost, ostq, nost, nostq, kol)
  select a.branch, a.nbs,a.kv,a.ob22,d.vidd vidd,
          sum(m.ost-m.crdos+m.crkos), sum(m.ostq-m.crdosQ+m.crkosQ),
          sum(decode(a.nls,b.nls,0,n.ost-n.crdos+n.crkos)),
          sum(decode(a.nls,b.nls,0,n.ostq-n.crdosQ+n.crkosQ)),
          count(*)
  from accounts a left outer join
       (select acc,rnk,ost,ostq,crdos,crkos,crdosQ,crkosQ,caldt_id
          from ACCM_AGG_MONBALS where caldt_id=caldt_ID_) m on (a.acc = m.acc),
       (select a.acc,a.vidd,a.deposit_id,a.idupd
               from dpt_deposit_clos a,
                   (select distinct acc,  deposit_id,
                            max(idupd)  over (partition by acc, deposit_id) idupd
                    from dpt_deposit_clos   ) b
               where a.acc=b.acc and a.deposit_id=a.deposit_id and a.idupd=b.idupd
       ) d,
       customer c, int_accn i,
       accounts b left outer join
       (select acc,rnk,ost,ostq,crdos,crkos,crdosQ,crkosQ,caldt_id
          from ACCM_AGG_MONBALS where caldt_id=caldt_ID_) n on (b.acc = n.acc)
  where d.acc=a.acc
    and   a.nbs not like '8%'     and a.nls not like '8%'
    and ( a.dazs is null or a.dazs > p_dat)
    and a.rnk=c.rnk
    and i.acc=a.acc
    and i.id=1
    and i.acra=b.acc
    and a.branch like BRANCH_||'%'
    and a.branch like sys_context('bars_context','user_branch')||'%'
    and a.daos < p_DAT
     group by a.branch, a.nbs,a.kv,a.ob22,d.vidd
union all
   select a.branch, a.nbs,a.kv, a.ob22,
          decode(a.nbs,'2620',decode(a.ob22,'07',262007,99998),99998) vidd, -- _��_ ������_ �� ��22 (�������_)
          sum(m.ost -m.crdos +m.crkos),
          sum(m.ostq-m.crdosQ+m.crkosQ),
          sum(decode(a.nls,b.nls,0,n.ost -n.crdos +n.crkos)),
          sum(decode(a.nls,b.nls,0,n.ostq-n.crdosQ+n.crkosQ)),
          count(*)
  from accounts a left outer join
       (select acc,rnk,ost,ostq,crdos,crkos,crdosQ,crkosQ,caldt_id
          from ACCM_AGG_MONBALS where caldt_id=caldt_ID_) m on (a.acc = m.acc),
       customer c, int_accn i, accounts b left outer join
       (select acc,rnk,ost,ostq,crdos,crkos,crdosQ,crkosQ,caldt_id
          from ACCM_AGG_MONBALS where caldt_id=caldt_ID_) n on (b.acc = n.acc)
  where a.acc not in (select acc from dpt_deposit_clos)
    and ((newnbs.g_state = 1 and a.nbs in ('2620','2630')) or (newnbs.g_state = 0 and a.nbs in ('2620','2630','2635')))
    and   a.nbs not like '8%'     and a.nls not like '8%'
    and ( a.dazs is null or a.dazs > p_dat)
    and a.rnk=c.rnk
    and i.acc=a.acc
    and i.id=1
    and i.acra=b.acc
    and a.branch like BRANCH_||'%'
    and a.branch like sys_context('bars_context','user_branch')||'%'
    and a.daos < p_DAT
  group by a.branch, a.nbs,a.kv,a.ob22
  union all                                                  -- ���� �������
   select a.branch, a.nbs,a.kv, a.ob22,
          decode(a.nbs,'2620',decode(a.ob22,'07',262007,99999),99999) vidd,
          sum(m.ost -m.crdos +m.crkos),
          sum(m.ostq-m.crdosQ+m.crkosQ),
          0, 0, count(*)
  from accounts a left outer join
       (select acc,rnk,ost,ostq,crdos,crkos,crdosQ,crkosQ,caldt_id
          from ACCM_AGG_MONBALS where caldt_id=caldt_ID_) m on (a.acc = m.acc),
       customer c
  where a.acc not in (select acc from dpt_deposit_clos)
    and ((newnbs.g_state = 1 and a.nbs in ('2620','2630')) or (newnbs.g_state = 0 and a.nbs in ('2620','2630','2635')))
    and   a.nbs not like '8%'     and a.nls not like '8%'
    and ( a.dazs is null or a.dazs > p_dat)
    and m.rnk=c.rnk
    and  not exists (select 1 from int_accn i where a.acc=i.acc and i.id=1 and i.acra is not null)
    and a.branch like BRANCH_||'%'
    and a.branch like sys_context('bars_context','user_branch')||'%'
    and a.daos < p_DAT
  group by a.branch, a.nbs,a.kv,a.ob22;

ElsIf mode_ = 102 then  /* ���������  �� ���.���, � ���� 096*/

  insert into CCK_AN_TMP
             (branch,nbs,kv,name,name1,nls,n1,n2,n3,n4,n5,zalq,zal,rezq)
  select a.branch,
         a.nbs,
         a.kv,
         nvl(s.ob22,'00') ob22,
         substr(a.nms,1,35) nms,
         a.nls,
         m.ost  + m.dos    -m.kos  -m.cudos  + m.cukos  ost,
         m.ostq + m.dosq   -m.kosq -m.cudosq + m.cukosq ostq,
         m.dos  + m.crdos  -m.cudos   dos,
         m.dosq + m.crdosq -m.cudosq  dosq,
         m.kos +  m.crkos  -m.cukos   kos,
         m.kosq + m.crkosq -m.cukosq  kosq,
         m.ost -  m.crdos +m.crkos  osti,
         m.ostq-  m.crdosQ+m.crkosQ ostiq
  from accounts a,
       (select acc,rnk, caldt_id,
               dos,    kos,   dosQ,   kosQ,
               ost,    ostq,
               crdos,  crkos, crdosQ, crkosQ,
               cudos,  cukos, cudosQ, cukosQ
          from ACCM_AGG_MONBALS where caldt_id=caldt_ID_) m,
       customer c, specparam_int s
  where a.acc=m.acc
    and ( a.dazs is null or a.dazs > p_dat)
    and m.rnk=c.rnk
    and a.branch like BRANCH_||'%'
    and a.branch like sys_context('bars_context','user_branch')||'%'
    and a.acc=s.acc(+);
end if;

commit;
--select count(*) into l_kk from tmp_dpt_inv;
--bars_audit.info ('dpt_inv === end'||' l_kk = '||l_kk);
Return;
end DPT_INV;
/
show err;

PROMPT *** Create  grants  DPT_INV ***
grant EXECUTE                                                                on DPT_INV         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DPT_INV         to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DPT_INV.sql =========*** End *** =
PROMPT ===================================================================================== 
