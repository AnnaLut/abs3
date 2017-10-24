create or replace view bars.v_e_deal_accounts
as
   (select a.acc,
           a.branch,
           a.nls,
           a.kv,
           a.nms,
           a.dos/100 as dos,
           a.kos/100 as kos,
           a.ostc/100 as ostc,
           a.ostb/100 as ostb,
           a.ostf/100 as ostf,
           a.dapp,
           a.mdate,
           a.lim,
           a.nbs,
           a.pap,
           a.tip,
           a.vid,
           a.ob22,
           a.isp,
           a.blkd,
           a.blkk,
           a.daos,
           a.dazs,
           a.rnk 
      from accounts a, e_deal$base d
     where     (   a.acc = d.acc26
                or a.acc = d.acc36
                or a.acc = d.accd
                or a.acc = d.accp)
           and d.nd = to_number(pul.get('DEAL_ND')));

show errors;

grant select on bars.v_e_deal_accounts to bars_access_defrole;



comment on table bars.v_e_deal_accounts is '������� ���� (�������)';

comment on column bars.v_e_deal_accounts.acc is 'ACC';

comment on column bars.v_e_deal_accounts.nls is '�����~�������';

comment on column bars.v_e_deal_accounts.kv is '���~������';

comment on column bars.v_e_deal_accounts.branch is '���~��������������~��������';

comment on column bars.v_e_deal_accounts.nbs is '����������~�������';

comment on column bars.v_e_deal_accounts.daos is '����~��������~�������';

comment on column bars.v_e_deal_accounts.dapp is '����~���������~����';

comment on column bars.v_e_deal_accounts.isp is 'ID~���������';

comment on column bars.v_e_deal_accounts.nms is '�����~�������';

comment on column bars.v_e_deal_accounts.lim is '˳��';

comment on column bars.v_e_deal_accounts.ostb is '�������~��������';

comment on column bars.v_e_deal_accounts.ostc is '�������~���������';

comment on column bars.v_e_deal_accounts.ostf is '�������~��������';

comment on column bars.v_e_deal_accounts.dos is '�������~�����';

comment on column bars.v_e_deal_accounts.kos is '�������~������';

comment on column bars.v_e_deal_accounts.pap is '�����~�����';

comment on column bars.v_e_deal_accounts.tip is '���~�������';

comment on column bars.v_e_deal_accounts.vid is '���~����~�������';

comment on column bars.v_e_deal_accounts.mdate is '����~���������~�������';

comment on column bars.v_e_deal_accounts.dazs is '����~��������~�������';

comment on column bars.v_e_deal_accounts.blkd is '���~����.~(�����)';

comment on column bars.v_e_deal_accounts.blkk is '���~����.~(������)';

comment on column bars.v_e_deal_accounts.rnk is '���';

comment on column bars.v_e_deal_accounts.ob22 is '��22';
