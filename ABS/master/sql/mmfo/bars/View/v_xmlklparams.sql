

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_XMLKLPARAMS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_XMLKLPARAMS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_XMLKLPARAMS ("TAG", "VALUE", "COMM") AS 
  select p.tag par, substr(val,1,14) val, name comm
     from  bars.branch_parameters p, bars.branch_tags t
    where p.tag in ('DPTNUM', 'TRDPT', 'CASH', 'RNK', 'NLS_9910', 'CASH7', 'DPT_PHON', 'TR2924_03POS', 'TR2924_01POS')
      and  p.branch like SYS_CONTEXT('bars_context', 'user_branch')
      and p.tag = t.tag
    union all
   select 'SOCTT' ,'KBQ', 'Операцiя для зарахувань до ПФ' from dual
    union all
   select 'GLB_NAME', val, comm
     from params$global where par = 'GLB-NAME'
    union all
   select 'orgOKPO' , okpo, 'Код ЗКПО банку'
     from customer c, branch_parameters b
    where tag = 'RNK' and b.val = c.rnk
      and b.branch = SYS_CONTEXT('bars_context', 'user_branch')
    union all
    select d.tag, d.val, descript
      from ( select val, 'DPT_'||replace(tag,'_') tag
               from dpt_staff d
                    unpivot include nulls ( val FOR tag IN (fio, fio_r, dover, posada, posada_r, town, adress))
              where branch = sys_context('bars_context', 'user_branch')
  	        and userid in (select id from staff$base where logname like 'TVBV%')
           ) d, xml_dptparams x
    where d.tag = x.par;

PROMPT *** Create  grants  V_XMLKLPARAMS ***
grant SELECT                                                                 on V_XMLKLPARAMS   to KLBX;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_XMLKLPARAMS   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_XMLKLPARAMS.sql =========*** End *** 
PROMPT ===================================================================================== 
