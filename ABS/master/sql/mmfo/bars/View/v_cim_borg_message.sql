

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_BORG_MESSAGE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_BORG_MESSAGE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_BORG_MESSAGE ("ID", "BRANCH", "NAME_BANK", "ADR_BANK", "RNK", "OKPO", "NAME_KL", "ADR_KL", "NOM_DOG", "DATE_DOG", "DATE_PLAT", "FILE_NAME", "DELETE_DATE", "DOC_KIND", "DOC_TYPE", "BOUND_ID", "CONTROL_DATE", "APPROVE") AS 
  SELECT m.ID, m.branch, b.NAME, b.adr, m.rnk, c.okpo,
          NVL ((SELECT nmku
                  FROM corps
                 WHERE rnk = m.rnk), c.nmk), c.adr, m.nom_dog,
          TRUNC (m.date_dog), TRUNC (m.date_plat), m.file_name, m.delete_date,
          m.doc_kind, m.doc_type, m.bound_id, m.control_date, m.approve
     FROM cim_borg_message m, cim_journal_num b, customer c
    WHERE b.branch = m.branch AND c.rnk = m.rnk AND m.delete_date IS NULL;

PROMPT *** Create  grants  V_CIM_BORG_MESSAGE ***
grant SELECT                                                                 on V_CIM_BORG_MESSAGE to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIM_BORG_MESSAGE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_BORG_MESSAGE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_BORG_MESSAGE.sql =========*** End
PROMPT ===================================================================================== 
