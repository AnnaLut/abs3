

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CBIREP_REPPARAMS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CBIREP_REPPARAMS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CBIREP_REPPARAMS ("REP_ID", "REP_NAME", "REP_DESC", "PARAM", "NDAT", "MASK", "NAMEW", "IDF", "KODZ", "ZAP_NAME", "NAMEF", "BINDVARS", "CREATE_STMT", "RPT_TEMPLATE", "KODR", "FORM_PROC", "DEFAULT_VARS", "BIND_SQL", "TXT", "PKEY", "FORM") AS 
  select r.id as rep_id,
       r.name as rep_name,
       r.description as rep_desc,
       r.param,
       r.ndat,
       r.mask,
       r.namew,
       r.idf,
       z.kodz,
       z.name as zap_name,
       z.namef,
       z.bindvars,
       z.create_stmt,
       z.rpt_template,
       z.kodr,
       z.form_proc,
       z.default_vars,
       z.bind_sql,
       z.txt,
       z.pkey,
       r.form
  from reports r, zapros z
 where r.form in ('frm_UniReport','frm_FastReport') and substr(r.param, 0, instr(r.param, ',') - 1) = z.kodz;

PROMPT *** Create  grants  V_CBIREP_REPPARAMS ***
grant SELECT                                                                 on V_CBIREP_REPPARAMS to BARSREADER_ROLE;
grant SELECT                                                                 on V_CBIREP_REPPARAMS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CBIREP_REPPARAMS to UPLD;
grant SELECT                                                                 on V_CBIREP_REPPARAMS to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_CBIREP_REPPARAMS to WR_CBIREP;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CBIREP_REPPARAMS.sql =========*** End
PROMPT ===================================================================================== 
