

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/ZAY_CORPDOCS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view ZAY_CORPDOCS ***

  CREATE OR REPLACE FORCE VIEW BARS.ZAY_CORPDOCS ("ID", "DOC_ID", "DOC_DESC") AS 
  SELECT z.id, m.doc_id, D.DOC_FILE as DOC_DESC
     FROM bars.zayavka z, barsaq.zayavka_id_map m, barsaq.DOC_EXPORT_FILES d
    WHERE z.id = m.idz AND m.doc_id = D.doc_id;

PROMPT *** Create  grants  ZAY_CORPDOCS ***
grant SELECT                                                                 on ZAY_CORPDOCS    to BARSREADER_ROLE;
grant SELECT                                                                 on ZAY_CORPDOCS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAY_CORPDOCS    to UPLD;
grant SELECT                                                                 on ZAY_CORPDOCS    to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/ZAY_CORPDOCS.sql =========*** End *** =
PROMPT ===================================================================================== 
