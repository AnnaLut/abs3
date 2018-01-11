

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CBIREP_REPLIST.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CBIREP_REPLIST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CBIREP_REPLIST ("CODEAPP", "REP_ID", "REP_DESC", "FOLDER_ID") AS 
  select app.codeapp, rep.coderep as rep_id, rep.description as rep_desc, rep.idf as folder_id
  from (select astf.codeapp
          from applist_staff astf,
          	  (SELECT id_whom, date_start, date_finish
                         FROM staff_substitute
                         WHERE id_who = user_id
                              AND date_is_valid (date_start,
                                                 date_finish,
                                                 NULL,
                                                 NULL) = 1
                         UNION ALL
                         SELECT user_id, NULL, NULL FROM DUAL) ss
         where astf.id = ss.id_whom
           and 1 = secure_groups_approved(astf.approve,
                                          astf.adate1,
                                          astf.adate2,
                                          astf.rdate1,
                                          astf.rdate2)) app,
       (select ar.codeapp, ar.coderep, r.description, r.idf
          from app_rep ar, reports r, zapros z
         where r.form in ('frm_UniReport','frm_FastReport')
           and ar.coderep = r.id
           and substr(r.param, 0, instr(r.param, ',') - 1) = z.kodz
           and z.rpt_template is not null
           and 1 = secure_groups_approved(ar.approve,
                                          ar.adate1,
                                          ar.adate2,
                                          ar.rdate1,
                                          ar.rdate2)) rep
 where app.codeapp = rep.codeapp;

PROMPT *** Create  grants  V_CBIREP_REPLIST ***
grant SELECT                                                                 on V_CBIREP_REPLIST to BARSREADER_ROLE;
grant SELECT                                                                 on V_CBIREP_REPLIST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CBIREP_REPLIST to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_CBIREP_REPLIST to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_CBIREP_REPLIST to WR_CBIREP;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CBIREP_REPLIST.sql =========*** End *
PROMPT ===================================================================================== 
