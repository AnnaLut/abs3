

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BID_INFOQUERIES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BID_INFOQUERIES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BID_INFOQUERIES ("BID_ID", "TYPE_ID", "TYPE_NAME", "SERVICE_ID", "SERVICE_NAME", "SRV_HIERARCHY", "SRV_HIERARCHY_NAME", "WS_ID", "ACT_LEVEL", "IQUERY_ID", "IQUERY_NAME", "IQUERY_TEXT", "IS_REQUIRED", "STATUS", "STATUS_MSG", "PROCESSED", "ORD") AS 
  select b.bid_id,
       i.type_id,
       it.name as type_name,
       si.service_id,
       s.name as service_name,
       srvhr.id as srv_hierarchy,
       srvhr.name as srv_hierarchy_name,
       srvhr.ws_id as ws_id,
       si.act_level,
       si.iquery_id,
       i.name as iquery_name,
       decode(i.type_id,
              'MANUAL',
              wcs_utl.parse_sql(b.bid_id, i.plsql, 'MAIN', 0),
              null) as iquery_text,
       si.is_required,
       wcs_utl.get_answ_list(b.bid_id, i.result_qid, srvhr.ws_id, 0) as status,
       wcs_utl.get_answ(b.bid_id, i.result_msg_qid, srvhr.ws_id, 0) as status_msg,
       decode(srvhr.id,
              'NONE',
              1,
              b.branch_hierarchy,
              1,
              wcs_utl.has_answ(b.bid_id, i.result_qid, srvhr.ws_id, 0)) as processed,
       si.ord
  from v_wcs_bids b,
       wcs_subproduct_infoqueries si,
       wcs_infoqueries i,
       wcs_services s,
       wcs_infoquery_types it,
       (select 'NONE' as id,
               'MAIN' as ws_id,
               'NOT_MANUAL' as type_id,
               '' as name
          from dual
        union
        select id, 'SRV_' || upper(id) as ws_id, 'MANUAL' as type_id, name
          from wcs_srv_hierarchy) srvhr
 where b.subproduct_id = si.subproduct_id
   and si.service_id = s.id(+)
   and si.iquery_id = i.id
   and i.type_id = it.id
   and srvhr.type_id = decode(i.type_id, 'MANUAL', 'MANUAL', 'NOT_MANUAL')
 order by b.bid_id, i.type_id, si.service_id, si.ord;

PROMPT *** Create  grants  V_WCS_BID_INFOQUERIES ***
grant SELECT                                                                 on V_WCS_BID_INFOQUERIES to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_BID_INFOQUERIES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_BID_INFOQUERIES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BID_INFOQUERIES.sql =========*** 
PROMPT ===================================================================================== 
