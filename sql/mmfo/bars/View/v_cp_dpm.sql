PROMPT *** Create  view v_cp_dpm ***

create or replace view v_cp_dpm(ref, nls_nom, acc_dpm, nls_dpm)  as
select d.ref, a.nls, dpm.cp_acc, dpm.nls from cp_deal d
join accounts a on (d.acc = a.acc) 
left join (select ca.cp_acc, ca.cp_acctype, ca.cp_ref, a.nls from cp_accounts ca,  accounts a where ca.cp_acc = a.acc and ca.cp_acctype = 'SDM') dpm on (dpm.cp_ref = d.ref);

comment on table v_cp_dpm is 'Рахунок Дисконта/Премії модифікації';
comment on column BARS.v_cp_dpm.ref is 'Референс угоди';
comment on column BARS.v_cp_dpm.nls_nom is 'Рахунок номіналу';
comment on column BARS.v_cp_dpm.acc_dpm is 'ACC Рахунка дисконта/премії модифікації';
comment on column BARS.v_cp_dpm.nls_dpm is 'Рахунок дисконта/премії модифікації';

PROMPT *** Create  grants  v_cp_dpm ***
grant SELECT                                                          on v_cp_dpm       to BARSREADER_ROLE;
grant SELECT                                                          on v_cp_dpm       to BARS_ACCESS_DEFROLE;
grant SELECT                                                          on v_cp_dpm       to CP_ROLE;
grant SELECT                                                          on v_cp_dpm       to START1;
