

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CORP2_DOCS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CORP2_DOCS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CORP2_DOCS ("REF", "PDAT", "TT", "KV", "BRANCH", "USERID", "NLSA", "SOS", "DOC_ID", "STATUS_ID", "STATUS_CHANGE_TIME", "TYPE_ID", "DOC_DESC", "TYPE_NAME") AS 
  SELECT o.REF,
           o.pdat,
           o.tt,
           o.kv,
           o.branch,
           o.userid,
           o.nlsa,
           o.sos,
           d.doc_id,
           d.status_id,
           d.status_change_time,
           d.type_id,
           i.doc_file,
           DECODE (d.type_id,
                   'P_INT', 'Внутрішній платіж',
                   'P_SEP', 'Зовнішній платіж',
                   'I_CUREXCH', 'Купівля/продаж валюти',
                   'P_SWIFT', 'Платіжне доручення')
               type_name
      FROM oper o, barsaq.doc_export d, barsaq.doc_export_files i
     WHERE     o.REF = d.bank_ref
           AND o.sos > 0
           AND d.doc_id = i.doc_id
           AND i.bank_ref = o.REF;

PROMPT *** Create  grants  V_CORP2_DOCS ***
grant SELECT                                                                 on V_CORP2_DOCS    to BARSREADER_ROLE;
grant SELECT                                                                 on V_CORP2_DOCS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CORP2_DOCS    to START1;
grant SELECT                                                                 on V_CORP2_DOCS    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CORP2_DOCS.sql =========*** End *** =
PROMPT ===================================================================================== 
