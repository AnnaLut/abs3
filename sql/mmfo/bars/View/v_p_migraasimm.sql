PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_p_migraasimm.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view v_p_migraasimm ***

create or replace view v_p_migraasimm as
select  ACTION
       ,PROCNAME
       ,ERRMASK
       ,ORDNUNG
       ,PROV_SQL
       ,to_char(DATE_BEGIN,'dd.mm.yyyy hh24:mi:ss') DATE_BEGIN
       ,to_char(DATE_END,'dd.mm.yyyy hh24:mi:ss') DATE_END
       ,DONE
       ,ERR
       ,MISTAKE_SHOW
  from BARS.P_MIGRAASIMM;


PROMPT *** Create  grants  v_p_migraasimm ***
grant SELECT                                                                 on v_p_migraasimm to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on v_p_migraasimm to BARSR;
grant SELECT                                                                 on v_p_migraasimm to BARSREADER_ROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_p_migraasimm.sql =========**
PROMPT ===================================================================================== 
