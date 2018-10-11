create or replace view v_sw_compare_list as
select /*case when c.cause_err <> 0 and c.is_resolve = 0 then 1 else 0 end*/ c.is_resolve  type,
       t.name system,
       T.KOD_NBU,
       c.ddate_oper ddate,
       o.mtsc transactionid_bars,
       i.transactionid transactionid_EW,
       op.id operation,
       op.name operation_name,
       o.pdat date_bars,
       i.operdate date_EW,
       o.ref,
       o.tt,
       e.name cause_err,
       c.kf,
       o.oper_branch branch_bars,
       i.barspointcode branch_EW,
       o.nls,
       to_char(i.currency ) kv,
       o.s sum_bars,
       o.sk kom_bars,
       i.amount sum_EW,
       i.totalcomission kom_EWT,
       i.bankcomission  kom_EWB,
       o.nazn,
       C.ID ID_C,
       i.trn,
       case when c.cause_err>1000 then nvl(o.prn_file,i.prn_file) else null end prn_file
from SW_COMPARE C, SW_OWN O, SW_IMPORT I,SWI_MTI_LIST T, SW_OPERATION op , SW_CAUSE_ERR E
where C.ID = O.COMPARE_ID(+)
  and C.ID = I.COMPARE_ID(+)
  and C.KOD_NBU = T.KOD_NBU(+)
  and op.id(+) = i.operation
  and C.CAUSE_ERR  = E.ID (+)
union all
select 2 type,
       t.name system,
       t.kod_nbu,
       o.pdat  ddate,
       o.mtsc transactionid_bars,
       null transactionid_EW,
       op.id operation,
       op.name operation_name,
       o.fdat date_bars,
       null date_EW,
       o.ref,
       o.tt,
       'переказ є в АБС – відсутній в ЄВ'  cause_err,
       o.kf,
       o.oper_branch branch_bars,
       null branch_EW,
       o.nls,
       to_char(o.kv),
       o.s sum_bars,
       o.sk kom_bars,
       null sum_EW,
       0 kom_EWT,
       0  kom_EWB,
       o.nazn,
       -1 ID_C,
       null trn,
       o.prn_file
from SW_OWN O,SWI_MTI_LIST T,SW_TT_OPER TT, SW_OPERATION op
where o.compare_id = 0
  and O.KOD_NBU = T.KOD_NBU
  and O.TT      = tt.tt
  and op.id     = tt.id
union all
select 3 type,
       t.name system,
       t.kod_nbu,
       i.operdate ddate,
       null transactionid_bars,
       i.transactionid transactionid_EW,
       op.id operation,
       op.name operation_name,
       null date_bars,
       i.operdate date_EW,
       null ref,
       null tt,
       'переказ є в ЄВ – відсутній в АБС'  cause_err,
       i.kf,
       null branch_bars,
       i.barspointcode branch_EW,
       null nls,
       i.currency kv,
       null sum_bars,
       null kom_bars,
       i.amount sum_EW,
       i.totalcomission kom_EWT,
       i.bankcomission  kom_EWB,
       null nazn,
       -1 ID_C,
       i.trn,
       i.prn_file
from SW_IMPORT I, SW_SYSTEM S,SWI_MTI_LIST T, SW_OPERATION op
where i.compare_id = 0
  and I.SYSTEMCODE = S.SYSTEMCODE
  and S.KOD_NBU = T.KOD_NBU
  and op.id = i.operation;


grant SELECT                                                on v_sw_compare_list    to BARS_ACCESS_DEFROLE;
