

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BID_INSURANCES.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BID_INSURANCES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BID_INSURANCES ("BID_ID", "INSURANCE_ID", "INSURANCE_NAME", "INSURANCE_NUM", "INS_TYPE_ID", "WS_ID", "STATUS_ID", "STATUS_NAME", "PARTNER_ID", "PARTNER_NAME", "SER", "NUM", "DATE_ON", "DATE_OFF", "SUM") AS 
  select b.id as bid_id,
       si.insurance_id,
       i.name as insurance_name,
       cnt.idx - 1 as insurance_num,
       i.ins_type_id,
       si.ws_id,
       wcs_utl.get_answ_list(b.id, i.status_qid, si.ws_id, cnt.idx - 1) as status_id,
       wcs_utl.get_answ_list_text(b.id, i.status_qid, si.ws_id, cnt.idx - 1) as status_name,
       wcs_utl.get_answ_refer(b.id, 'INS_PARTNER_ID', si.ws_id, cnt.idx - 1) as partner_id,
       (select ip.name
          from v_ins_partners ip
         where ip.partner_id =
               to_number(wcs_utl.get_answ_refer(b.id,
                                                'INS_PARTNER_ID',
                                                si.ws_id,
                                                cnt.idx - 1))) as partner_name,
       wcs_utl.get_answ_text(b.id, 'INS_SER', si.ws_id, cnt.idx - 1) as ser,
       wcs_utl.get_answ_text(b.id, 'INS_NUM', si.ws_id, cnt.idx - 1) as num,
       wcs_utl.get_answ_date(b.id, 'INS_DATE_ON', si.ws_id, cnt.idx - 1) as date_on,
       wcs_utl.get_answ_date(b.id, 'INS_DATE_OFF', si.ws_id, cnt.idx - 1) as date_off,
       wcs_utl.get_answ_decimal(b.id,
                                'INS_SUM', si.ws_id, cnt.idx - 1) as sum
  from wcs_bids                  b,
       wcs_subproduct_insurances si,
       wcs_insurances            i,
       wcs_counter               cnt
 where b.subproduct_id = si.subproduct_id
   and si.insurance_id = i.id
   and cnt.idx <= wcs_utl.get_answ_numb(b.id, i.count_qid, si.ws_id)
 order by b.id, si.insurance_id;

PROMPT *** Create  grants  V_WCS_BID_INSURANCES ***
grant SELECT                                                                 on V_WCS_BID_INSURANCES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BID_INSURANCES.sql =========*** E
PROMPT ===================================================================================== 
