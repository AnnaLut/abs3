

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/ZAY_CORPDOCS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view ZAY_CORPDOCS ***

  CREATE OR REPLACE FORCE VIEW BARS.ZAY_CORPDOCS ("ID", "DOC_ID", "DOC_DESC") AS 
  select z.id, m.doc_id, d.doc_desc from bars.zayavka z, barsaq.zayavka_id_map m, barsaq.doc_export d where z.id = m.idz and m.doc_id = D.doc_id;

PROMPT *** Create  grants  ZAY_CORPDOCS ***
grant SELECT                                                                 on ZAY_CORPDOCS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAY_CORPDOCS    to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/ZAY_CORPDOCS.sql =========*** End *** =
PROMPT ===================================================================================== 
