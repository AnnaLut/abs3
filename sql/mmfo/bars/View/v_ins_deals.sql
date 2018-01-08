

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_DEALS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_DEALS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_DEALS ("DEAL_ID", "TASK_TYPE_ID", "TASK_TYPE_NAME", "TASK_STATUS_ID", "TASK_STATUS_NAME", "TASK_PLAN_DATE", "TASK_DAYS", "BRANCH", "BRANCH_NAME", "STAFF_ID", "STAFF_FIO", "STAFF_LOGNAME", "CRT_DATE", "PARTNER_ID", "PARTNER_NAME", "PARTNER_RNK", "PARTNER_INN", "PARTNER_ACTIVE", "TYPE_ID", "TYPE_NAME", "PT_ACTIVE", "STATUS_ID", "STATUS_NAME", "STATUS_DATE", "STATUS_COMM", "INS_RNK", "INS_CTYPE", "INS_FIO", "INS_INN", "INS_DOC_SER", "INS_DOC_NUM", "INS_DOC_ISSUER", "INS_DOC_DATE", "SER", "NUM", "SDATE", "EDATE", "SUM", "SUM_KV", "SUM_KV_LCV", "SUM_KV_NAME", "INSU_TARIFF", "INSU_SUM", "TOTAL_INSU_SUM", "OBJECT_TYPE", "OBJECT_NAME", "CL_RNK", "CL_CTYPE", "CL_FIO", "CL_INN", "CL_DOC_SER", "CL_DOC_NUM", "CL_DOC_ISSUER", "CL_DOC_DATE", "GRT_ID", "GRT_TYPE_ID", "GRT_TYPE_NAME", "GRT_DEAL_NUM", "GRT_DEAL_DATE", "GRT_GRT_NAME", "ND", "ND_NUM", "ND_SDATE", "PAY_FREQ_ID", "PAY_FREQ_NAME", "RENEW_NEED", "RENEW_NEWID", "CUSTID", "EXT_SYSTEM") AS 
  SELECT d.id AS deal_id,
          st.type_id AS task_type_id,
          st.type_name AS task_type_name,
          st.status_id AS task_status_id,
          st.status_name AS task_status_name,
          st.plan_date AS task_plan_date,
          st.days AS task_days,
          d.branch,
          b.name AS branch_name,
          d.staff_id,
          s.fio AS staff_fio,
          s.logname AS staff_logname,
          d.crt_date,
          d.partner_id,
          p.name AS partner_name,
          p.rnk AS partner_rnk,
          c1.okpo AS partner_inn,
          p.active AS partner_active,
          d.type_id,
          t.name AS type_name,
          pt.active AS pt_active,
          d.status_id,
          ds.name AS status_name,
          d.status_date,
          d.status_comm,
          d.ins_rnk,
          c2.custtype AS ins_ctype,
          c2.nmk AS ins_fio,
          c2.okpo AS ins_inn,
          p2.ser AS ins_doc_ser,
          p2.numdoc AS ins_doc_num,
          p2.organ AS ins_doc_issuer,
          p2.pdate AS ins_doc_date,
          d.ser,
          d.num,
          d.sdate,
          d.edate,
          d.SUM,
          d.sum_kv,
          tg1.lcv AS sum_kv_lcv,
          tg1.name AS sum_kv_name,
          d.insu_tariff,
          d.insu_sum,
          (SELECT SUM (ps.plan_sum)
             FROM ins_payments_schedule ps
            WHERE ps.deal_id = d.id)
             AS total_insu_sum,
          d.object_type,
          ot.name AS object_name,
          d.rnk AS cl_rnk,
          c3.custtype AS cl_ctype,
          c3.nmk AS cl_fio,
          c3.okpo AS cl_inn,
          p3.ser AS cl_doc_ser,
          p3.numdoc AS cl_doc_num,
          p3.organ AS cl_doc_issuer,
          p3.pdate AS cl_doc_date,
          d.grt_id,
          gd.type_id AS grt_type_id,
          gd.type_name AS grt_type_name,
          gd.deal_num AS grt_deal_num,
          gd.deal_date AS grt_deal_date,
          gd.grt_name AS grt_grt_name,
          d.nd,
          cd.cc_id AS nd_num,
          cd.sdate AS nd_sdate,
          d.pay_freq AS pay_freq_id,
          f.name AS pay_freq_name,
          d.renew_need,
          d.renew_newid,
          p.custtype AS custid,
          ins_pack.get_deal_attr_s (d.id, 'EXT_SYSTEM') AS ext_system
     FROM ins_deals d,
          branch b,
          staff$base s,
          ins_partners p,
          customer c1,
          ins_types t,
          ins_partner_types pt,
          ins_deal_statuses ds,
          customer c2,
          person p2,
          tabval$global tg1,
          ins_object_types ot,
          customer c3,
          person p3,
          cc_deal cd,
          v_ins_grt_deals gd,
          freq f,
          (SELECT *
             FROM (SELECT t.*,
                          RANK ()
                          OVER (PARTITION BY t.deal_id
                                ORDER BY t.plan_date DESC, t.priority DESC)
                             AS rnk
                     FROM mv_ins_schedule_tasks t)
            WHERE rnk = 1) st
    WHERE     d.id = st.deal_id(+)
          AND d.branch = b.branch
          AND d.staff_id = s.id
          AND d.partner_id = p.id
          AND p.rnk = c1.rnk(+)
          AND d.type_id = t.id
          AND d.partner_id = pt.partner_id
          AND d.type_id = pt.type_id
          AND d.status_id = ds.id
          AND d.ins_rnk = c2.rnk
          AND d.ins_rnk = p2.rnk(+)
          AND d.sum_kv = tg1.kv
          AND d.object_type = ot.id
          AND d.rnk = c3.rnk(+)
          AND d.rnk = p3.rnk(+)
          AND d.grt_id = gd.deal_id(+)
          AND d.nd = cd.nd(+)
          AND d.pay_freq = f.freq;

PROMPT *** Create  grants  V_INS_DEALS ***
grant SELECT                                                                 on V_INS_DEALS     to BARSREADER_ROLE;
grant SELECT                                                                 on V_INS_DEALS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_INS_DEALS     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_DEALS.sql =========*** End *** ==
PROMPT ===================================================================================== 
