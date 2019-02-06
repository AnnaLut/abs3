

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_TRADE_PAYMENTS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_TRADE_PAYMENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_TRADE_PAYMENTS ("BOUND_ID", "CONTR_ID", "PAY_FLAG", "REF", "DIRECT", "TYPE_ID", "TYPE", "VDAT", "ACCOUNT", "NAZN", "V_PL", "S_VPL", "SK_VPL", "RATE", "S_VK", "S_PD", "ZS_VP", "ZS_VK", "CONTROL_DATE", "OVERDUE", "S_PD_AFTER", "SERVICE_CODE", "CREATE_DATE", "MODIFY_DATE", "BORG_REASON", "EA_URL", "DEADLINE_DOC", "ZSQ_VP", "DATE_MAX_BOUND_DOC") AS 
  SELECT b.bound_id, b.contr_id, b.pay_flag, b.ref, b.direct, b.type_id, b.type, b.vdat, b.account, b.nazn, b.v_pl, b.s_vpl, b.sk_vpl, b.rate,
         b.s_vk, b.s_pd, decode(b.s_vk, 0, 0, round((b.s_vpl+ decode(b.direct, 0, b.sk_vpl, -b.sk_vpl))*(b.s_vk-b.s_pd)/b.s_vk,2)) as zs_vp, b.s_vk-b.s_pd as zs_vk,
         b.control_date, case when b.s_vk>b.s_pd and trunc(bankdate)>trunc(b.control_date) then bankdate-b.control_date else 0 end as overdue,
         case
         when b.type_id = 0 then
          (select round(nvl(sum(case  when nvl2(l.vmd_id,
                                            (select max(allow_dat) from v_cim_customs_decl where cim_id in (select vmd_id from cim_vmd_bound  where bound_id = l.vmd_id)),
                                            (select max(allow_date) from cim_acts where act_id in (select act_id  from cim_act_bound where bound_id = l.act_id))) >  b.control_date then
                                           l.s
                                      else
                                           0
                                end),
                            0) / 100,
                        2)
             from cim_link l where l.delete_date is null and l.payment_id = b.bound_id)
         else
          (select round(nvl(sum(case  when nvl2(l.vmd_id,
                                            (select max(allow_dat) from v_cim_customs_decl where cim_id in (select vmd_id from cim_vmd_bound where bound_id = l.vmd_id)),
                                            (select max(allow_date) from cim_acts where act_id in (select act_id from cim_act_bound where bound_id = l.act_id))) > b.control_date then
                                           l.s
                                      else
                                           0
                                end),
                            0) / 100,
                        2)
             from cim_link l where l.delete_date is null and l.fantom_id = b.bound_id)
         end as s_pd_after,
         case
         when b.type_id = 0 then
          (select max(service_code) from cim_ape_link where payment_id = b.bound_id)
         else
          (select max(service_code) from cim_ape_link where fantom_id = b.bound_id)
         end as servce_code,
         b.create_date, b.modify_date, b.borg_reason, b.ea_url, b.deadline_doc,
         gl.p_icurval(v_pl, decode(b.s_vk, 0, 0, round((b.s_vpl+ decode(b.direct, 0, b.sk_vpl, -b.sk_vpl))*(b.s_vk-b.s_pd)/b.s_vk,2))/*zs_vp*/ * 100, nvl(b.date_max_bound_doc,b.vdat)) / 100 as zsq_vp,
         b.date_max_bound_doc
    FROM (SELECT b.bound_id, b.contr_id, b.pay_flag, b.pay_flag_name, b.ref, b.direct, b.type_id, b.type, b.vdat, b.account,
                 b.nazn, b.v_pl, b.s_vpl, b.sk_vpl, b.rate, b.s_vk, cim_mgr.get_control_date(0, b.type_id, b.bound_id) as control_date,
                 b.create_date, b.modify_date, b.borg_reason, b.ea_url,
                 round(nvl(case
                           when b.type_id = 0 then
                            (select sum(s) from cim_link where delete_date is null and payment_id = b.bound_id)
                           else
                            (select sum(s) from cim_link where delete_date is null and fantom_id = b.bound_id)
                           end,
                         0) / 100,
                      2) as s_pd,
                 b.deadline_doc,
                 case
                 when b.type_id = 0 then
                  (select max(nvl2(l.vmd_id,
                                                    (select max(allow_dat) from v_cim_customs_decl where cim_id in (select vmd_id from cim_vmd_bound  where bound_id = l.vmd_id)),
                                                    (select max(allow_date) from cim_acts where act_id in (select act_id  from cim_act_bound where bound_id = l.act_id))))
                     from cim_link l where l.delete_date is null and l.payment_id = b.bound_id)
                 else
                  (select max(nvl2(l.vmd_id,
                                                    (select max(allow_dat) from v_cim_customs_decl where cim_id in (select vmd_id from cim_vmd_bound where bound_id = l.vmd_id)),
                                                    (select max(allow_date) from cim_acts where act_id in (select act_id from cim_act_bound where bound_id = l.act_id)))) 
                     from cim_link l where l.delete_date is null and l.fantom_id = b.bound_id)
                 end as date_max_bound_doc                
            FROM v_cim_bound_payments b /*join cim_contracts c on c.contr_type<2 and b.contr_id=c.contr_id*/ where pay_flag=0) b;

comment on table V_CIM_TRADE_PAYMENTS is '����`���� ������ �������� ��������� 1.00.05';
comment on column V_CIM_TRADE_PAYMENTS.BOUND_ID is 'Id ����''����';
comment on column V_CIM_TRADE_PAYMENTS.CONTR_ID is '�������� ��� ���������';
comment on column V_CIM_TRADE_PAYMENTS.PAY_FLAG is 'id c������������ �������';
comment on column V_CIM_TRADE_PAYMENTS.REF is '�������� �������';
comment on column V_CIM_TRADE_PAYMENTS.DIRECT is '�������� ������� (0-�����, 1-������)';
comment on column V_CIM_TRADE_PAYMENTS.TYPE_ID is 'id ���� �������';
comment on column V_CIM_TRADE_PAYMENTS.TYPE is '��� ������� (�����)';
comment on column V_CIM_TRADE_PAYMENTS.VDAT is '���� �����������';
comment on column V_CIM_TRADE_PAYMENTS.ACCOUNT is '�������';
comment on column V_CIM_TRADE_PAYMENTS.NAZN is '����������� �������';
comment on column V_CIM_TRADE_PAYMENTS.V_PL is '������ �������';
comment on column V_CIM_TRADE_PAYMENTS.S_VPL is '���� � ����� �������';
comment on column V_CIM_TRADE_PAYMENTS.SK_VPL is '���� ���� � ����� �������';
comment on column V_CIM_TRADE_PAYMENTS.RATE is '���� ������� ������ ���������';
comment on column V_CIM_TRADE_PAYMENTS.S_VK is '���� � ����� ���������';
comment on column V_CIM_TRADE_PAYMENTS.S_PD is '�������� ���� ���`������ ������������� ���������';
comment on column V_CIM_TRADE_PAYMENTS.ZS_VP is '������`������ �������� ���� � ����� �������';
comment on column V_CIM_TRADE_PAYMENTS.ZS_VK is '������`������ �������� ���� � ����� ��������� ';
comment on column V_CIM_TRADE_PAYMENTS.CONTROL_DATE is '���� ������������ ���';
comment on column V_CIM_TRADE_PAYMENTS.OVERDUE is 'ʳ������ ��� ����������';
comment on column V_CIM_TRADE_PAYMENTS.S_PD_AFTER is 'C��� ���`������ ������������� ��������� ���� ������������ ��� ';
comment on column V_CIM_TRADE_PAYMENTS.SERVICE_CODE is '��� ������������� ������';
comment on column V_CIM_TRADE_PAYMENTS.CREATE_DATE is '���� ���������';
comment on column V_CIM_TRADE_PAYMENTS.MODIFY_DATE is '���� �����������';
comment on column V_CIM_TRADE_PAYMENTS.BORG_REASON is '������� �������������';
comment on column V_CIM_TRADE_PAYMENTS.EA_URL is '������ ������� ������������ ������ ��';
comment on column V_CIM_TRADE_PAYMENTS.DEADLINE_DOC is '����������� ����� �� ���������';
comment on column V_CIM_TRADE_PAYMENTS.ZSQ_VP is '���.���.�������� ��䳿 ������������� ����������';
comment on column V_CIM_TRADE_PAYMENTS.DATE_MAX_BOUND_DOC is '���� �������� �������� ��䳿';


PROMPT *** Create  grants  V_CIM_TRADE_PAYMENTS ***
grant SELECT                                                                 on V_CIM_TRADE_PAYMENTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIM_TRADE_PAYMENTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_TRADE_PAYMENTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_TRADE_PAYMENTS.sql =========*** E
PROMPT ===================================================================================== 
