

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BID_TEMPLATES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BID_TEMPLATES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BID_TEMPLATES ("BID_ID", "TEMPLATE_ID", "TEMPLATE_NAME", "FILE_NAME", "PRINT_STATE_ID", "PRINT_STATE_NAME", "SCAN_QID", "WS_ID", "WS_NUM", "DOCEXP_TYPE_ID", "IMG", "IS_SCAN_REQUIRED") AS 
  select "BID_ID","TEMPLATE_ID","TEMPLATE_NAME","FILE_NAME","PRINT_STATE_ID","PRINT_STATE_NAME","SCAN_QID","WS_ID","WS_NUM","DOCEXP_TYPE_ID","IMG","IS_SCAN_REQUIRED"
  from (select b.id as bid_id,
               st.template_id,
               dt.name as template_name,
               dt.file_name,
               st.print_state_id,
               ps.name as print_state_name,
               st.scan_qid,
               'MAIN' as ws_id,
               0 as ws_num,
               t.docexp_type_id,
               wcs_utl.get_answ_blob(b.id, st.scan_qid, 'MAIN', 0) as img,
               st.is_scan_required
          from wcs_bids                 b,
               wcs_subproduct_templates st,
               wcs_templates            t,
               v_doc_templates          dt,
               wcs_print_states         ps
         where b.subproduct_id = st.subproduct_id
           and st.template_id = t.template_id
           and t.template_id = dt.id
           and dt.fr = 1
           and st.print_state_id = ps.id
         order by b.id, st.template_id)
union all
select "BID_ID","TEMPLATE_ID","TEMPLATE_NAME","FILE_NAME","PRINT_STATE_ID","PRINT_STATE_NAME","SCAN_QID","WS_ID","WS_NUM","DOCEXP_TYPE_ID","IMG","IS_SCAN_REQUIRED"
  from (select bg.bid_id,
               gt.template_id,
               'Забезпечення ' || bg.garantee_name || '(' || bg.garantee_num ||
               ') - ' || dt.name as template_name,
               dt.file_name,
               gt.print_state_id,
               ps.name as print_state_name,
               gt.scan_qid,
               bg.ws_id as ws_id,
               bg.garantee_num as ws_num,
               t.docexp_type_id,
               wcs_utl.get_answ_blob(bg.bid_id,
                                     gt.scan_qid,
                                     bg.ws_id,
                                     bg.garantee_num) as img,
               gt.is_scan_required
          from v_wcs_bid_garantees    bg,
               wcs_garantee_templates gt,
               wcs_templates          t,
               v_doc_templates        dt,
               wcs_print_states       ps
         where bg.garantee_id = gt.garantee_id
           and gt.template_id = t.template_id
           and t.template_id = dt.id
           and dt.fr = 1
           and gt.print_state_id = ps.id
         order by bg.bid_id, gt.template_id);

PROMPT *** Create  grants  V_WCS_BID_TEMPLATES ***
grant SELECT                                                                 on V_WCS_BID_TEMPLATES to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_BID_TEMPLATES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_BID_TEMPLATES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BID_TEMPLATES.sql =========*** En
PROMPT ===================================================================================== 
