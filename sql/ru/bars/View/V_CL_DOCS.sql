CREATE OR REPLACE VIEW V_CL_DOCS
(ref, pdat, tt, kv, branch, userid, nlsa, sos, doc_id, status_id, status_change_time, type_id, doc_desc, type_name)
AS
 select o1.REF,
           o1.pdat,
           o1.tt,
           o1.kv,
           o1.branch,
           o1.userid,
           o1.nlsa,
           o1.sos,
           t.cl_id doc_id,
           o1.sos status_id,
           o1.sos_change_time,
           to_char(t.type) type_id,
           null,
           DECODE (t.type,
                   1, 'Платіж',
                   2, 'Платіжне доручення',
                   3, 'Купівля/продаж валюти') type_name
      FROM oper o1, tmp_cl_payment t
     WHERE o1.REF = t.ref
           AND o1.sos > 0;
           
grant select on V_CL_DOCS to bars_access_defrole;
