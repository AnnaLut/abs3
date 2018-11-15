

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_EAD_DOCS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_EAD_DOCS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_EAD_DOCS ("DOC_ID", "CRT_DATE", "CRT_STAFF_ID", "CRT_STAFF_FIO", "CRT_STAFF_LOGNAME", "CRT_BRANCH", "CRT_BRANCH_NAME", "TEMPLATE_ID", "TEMPLATE_NAME", "EA_STRUCT_ID", "EA_STRUCT_NAME", "RNK", "CL_FIO", "CL_INN", "AGR_ID", "AGR_NUM", "AGR_DATE", "DOC_PRINT_NUMBER", "TICKET_ID") AS 
  select ed.id           as doc_id,
       ed.crt_date,
       ed.crt_staff_id,
       sb.fio          as crt_staff_fio,
       sb.logname      as crt_staff_logname,
       ed.crt_branch,
       b.name          as crt_branch_name,
       ed.template_id,
       ds.name         as template_name,
       ed.ea_struct_id,
       sc.name         as ea_struct_name,
       ed.rnk,
       c.nmk           as cl_fio,
       c.okpo          as cl_inn,
       ed.agr_id,
       d.nd            as agr_num,
       d.dat_begin     as agr_date,
       ed.doc_print_number,
       ed.ticket_id				   
  from ead_docs         ed,
       staff$base       sb,
       branch           b,
       doc_scheme       ds,
       ead_struct_codes sc,
       customer         c,
       dpt_deposit      d
 where 1=1
   and (ed.type_id = 'DOC' or ed.type_id = 'SCAN' and ed.ea_struct_id in ('146', '221','224'))
   and ed.crt_staff_id = sb.id
   and ed.crt_branch = b.branch
   and ed.template_id = ds.id(+)
   and ed.ea_struct_id = sc.id
   and ed.rnk = c.rnk
   and ed.agr_id = d.deposit_id(+)
;

comment on table V_EAD_DOCS is 'Надруковані документи (представлення)';
comment on column V_EAD_DOCS.DOC_ID is 'Ідентифікатор (10... - АБС)';
comment on column V_EAD_DOCS.CRT_DATE is 'Дата створення';
comment on column V_EAD_DOCS.CRT_STAFF_ID is 'Ід. користувача';																												   
comment on column V_EAD_DOCS.CRT_STAFF_FIO is 'ПІБ користувача';
comment on column V_EAD_DOCS.CRT_STAFF_LOGNAME is 'Логін користувача';
comment on column V_EAD_DOCS.CRT_BRANCH is 'Відділення';
comment on column V_EAD_DOCS.CRT_BRANCH_NAME is 'Найм. відділення';
comment on column V_EAD_DOCS.TEMPLATE_ID is 'Ід. шаблону';
comment on column V_EAD_DOCS.TEMPLATE_NAME is 'Найм. шаблону';
comment on column V_EAD_DOCS.EA_STRUCT_ID is 'Код структури документу за ЕА';
comment on column V_EAD_DOCS.EA_STRUCT_NAME is 'Найм структури документу за ЕА';
comment on column V_EAD_DOCS.RNK is 'РНК клієнта';
comment on column V_EAD_DOCS.CL_FIO is 'ПІБ клієнта';
comment on column V_EAD_DOCS.CL_INN is 'ІПН клієнта';
comment on column V_EAD_DOCS.AGR_ID is 'Ід. угоди';
comment on column V_EAD_DOCS.AGR_NUM is 'Номер угоди';
comment on column V_EAD_DOCS.AGR_DATE is 'Дата угоди';
comment on column V_EAD_DOCS.DOC_PRINT_NUMBER is 'Унікальний номер друку';
comment on column V_EAD_DOCS.TICKET_ID is 'GUID обєкта';

PROMPT *** Create  grants  V_EAD_DOCS ***
grant SELECT on V_EAD_DOCS      to BARSREADER_ROLE;
grant SELECT on V_EAD_DOCS      to BARS_ACCESS_DEFROLE;
grant SELECT on V_EAD_DOCS      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_EAD_DOCS.sql =========*** End *** ===
PROMPT ===================================================================================== 
