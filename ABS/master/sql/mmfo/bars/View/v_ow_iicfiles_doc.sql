

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_IICFILES_DOC.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_IICFILES_DOC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_IICFILES_DOC ("FLAG_KVT", "FILE_NAME", "FILE_DATE", "RESP_CLASS", "RESP_CODE", "RESP_TEXT", "REF", "DK", "TT", "ACC", "NLS", "NMS", "S", "LCV", "NAZN", "BRANCH") AS 
  select k.flag_kvt, k.f_n, k.file_date, k.resp_class, k.resp_code, k.resp_text,
       k.ref, k.dk, k.tt, a.acc, a.nls, a.nms, k.s/100, v.lcv, k.nazn, k.branch
  from ( -- ow_pkk_history - dk=1
         select 1 flag_kvt, q.f_n, f.file_date, q.resp_class, q.resp_code, q.resp_text,
                q.dk, o.ref, q.acc, o.tt, decode(q.dk,o.dk,nvl(o.s2,o.s),o.s) s, o.nazn, o.branch
           from ow_pkk_history q, ow_iicfiles f, oper o
          where q.f_n = f.file_name
            and q.ref = o.ref
            and q.dk  = 1
         union all
         -- ow_pkk_history - dk=0
         select 1, q.f_n, f.file_date, q.resp_class, q.resp_code, q.resp_text,
                q.dk, o.ref, q.acc, o.tt, decode(q.dk,o.dk,nvl(o.s2,o.s),o.s) s, o.nazn, o.branch
           from ow_pkk_history q, ow_iicfiles f, oper o
          where q.f_n = f.file_name
            and q.ref = o.ref
            and q.dk  = 0
         union all
         -- ow_pkk_que
         select 0, q.f_n, f.file_date, q.resp_class, q.resp_code, q.resp_text,
                q.dk, o.ref, q.acc, o.tt, decode(q.dk,o.dk,nvl(o.s2,o.s),o.s) s, o.nazn, o.branch
           from ow_pkk_que q, ow_iicfiles f, oper o
          where q.f_n = f.file_name
            and q.sos = 1
            and q.ref = o.ref
         union all
         -- ow_acc_history
         select 1, q.f_n, f.file_date, q.resp_class, q.resp_code, q.resp_text,
                null dk, null ref, q.acc, null tt, q.s, 'арест суммы на счёте 2625' nazn, null branch
           from ow_acc_history q, ow_iicfiles f
          where q.f_n = f.file_name
         union all
         -- ow_acc_que
         select 0, q.f_n, f.file_date, null resp_class, null resp_code, null resp_text,
                null dk, null ref, q.acc, null tt, q.s, 'арест суммы на счёте 2625' nazn, null branch
           from ow_acc_que q, ow_iicfiles f
          where q.f_n = f.file_name
            and q.sos = 1
         union all
         -- ow_locpaymatch
         select decode(ol.state, 11, 1, 0), ol.revfile_name, oi.file_date, ol.resp_class resp_class, ol.resp_code resp_code, ol.resp_text resp_text,
                o.dk, o.ref, ol.acc, o.tt, o.s, o.nazn, o.branch
           from ow_locpay_match ol, ow_oicrevfiles oi, oper o
          where oi.file_name = ol.revfile_name and ol.revflag in(1, 2)
            and o.ref = ol.ref
            ) k, accounts a, tabval$global v
 where k.acc = a.acc
   and a.kv = v.kv
   and nvl(k.branch, sys_context('bars_context', 'user_branch')) like sys_context('bars_context', 'user_branch_mask');

PROMPT *** Create  grants  V_OW_IICFILES_DOC ***
grant SELECT                                                                 on V_OW_IICFILES_DOC to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_IICFILES_DOC to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_IICFILES_DOC.sql =========*** End 
PROMPT ===================================================================================== 
