create or replace view v_dpt_dpu as
select a.rnk,
           c.nmk,
           a.nms,
           d.Deposit_id id,
           d.dat_begin,
           d.dat_end,
           a.kv,
           a.ostc  sum
    from DPT_DEPOSIT d,
         accounts a,
         customer c
    where d.acc=a.acc
      and a.dazs is null
      and a.rnk=c.rnk
union all
    select a.rnk,
           c.nmk,
           a.nms,
           d.Dpu_id     id,
           d.dat_begin,
           d.dat_end,
           a.kv,
           a.ostc
    from DPU_DEAL    d,
         accounts a,
         customer c
    where d.acc=a.acc
      and a.dazs is null
      and a.rnk=c.rnk;
comment on table V_DPT_DPU is '������ �������� ��/��';
comment on column V_DPT_DPU.RNK is '��� ������������';
comment on column V_DPT_DPU.NMK is '������������ �볺���';
comment on column V_DPT_DPU.NMS is '������������ �������';
comment on column V_DPT_DPU.ID is '����� ����������� ��������';
comment on column V_DPT_DPU.DAT_BEGIN is '���� ��������� ����������� ��������';
comment on column V_DPT_DPU.DAT_END is '���� ��������� ����������� ��������';
comment on column V_DPT_DPU.KV is '��� ������ �� ���������';
comment on column V_DPT_DPU.SUM is '���� ��������';


GRANT SELECT, FLASHBACK ON BARS.v_dpt_dpu TO bars_access_defrole;               
