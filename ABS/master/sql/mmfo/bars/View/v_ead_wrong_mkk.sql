

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_EAD_WRONG_MKK.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_EAD_WRONG_MKK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_EAD_WRONG_MKK ("RNK", "NDBO", "DDBO", "ACC", "ID", "CRT_DATE", "TYPE_ID", "OBJ_ID", "STATUS_ID", "ERR_TEXT", "ERR_COUNT", "MESSAGE_ID", "MESSAGE_DATE", "MESSAGE", "RESPONCE_ID", "RESPONCE_DATE", "RESPONCE", "KF") AS 
  select t."RNK",t."NDBO",t."DDBO",t."ACC", a."ID",a."CRT_DATE",a."TYPE_ID",a."OBJ_ID",a."STATUS_ID",a."ERR_TEXT",a."ERR_COUNT",a."MESSAGE_ID",a."MESSAGE_DATE",a."MESSAGE",a."RESPONCE_ID",a."RESPONCE_DATE",a."RESPONCE",a."KF"
from (
SELECT c.rnk,
       kl.get_customerw (c.rnk, 'NDBO') ndbo,
       kl.get_customerw (c.rnk, 'DDBO') ddbo,
       w.acc
  FROM W4_ACC_INSTANT w, customer c
 WHERE     kl.get_customerw (c.rnk, 'NDBO') IS NOT NULL
       AND c.date_off IS NULL
       AND c.custtype = 2
       and w.rnk is not null
       AND c.rnk = w.rnk) t,
       ead_sync_queue a
 where a.obj_id  ='ACC;'||TO_CHAR (t.acc)
       AND A.STATUS_ID = 'DONE'
       AND A.CRT_DATE >= (SELECT MIN (daos)
                            FROM accounts_update
                           WHERE acc = t.acc)
       and a.message not like '%' || t.ndbo ||'%';

PROMPT *** Create  grants  V_EAD_WRONG_MKK ***
grant SELECT                                                                 on V_EAD_WRONG_MKK to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_EAD_WRONG_MKK.sql =========*** End **
PROMPT ===================================================================================== 
