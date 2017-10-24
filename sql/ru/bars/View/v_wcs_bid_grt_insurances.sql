

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BID_GRT_INSURANCES.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BID_GRT_INSURANCES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BID_GRT_INSURANCES ("BID_ID", "GARANTEE_ID", "GARANTEE_NUM", "GARANTEE_NAME", "INSURANCE_ID", "INSURANCE_NAME", "INSURANCE_NUM", "INS_TYPE_ID", "WS_ID", "STATUS_ID", "STATUS_NAME", "PARTNER_ID", "PARTNER_NAME", "SER", "NUM", "DATE_ON", "DATE_OFF", "SUM") AS 
  select bg.bid_id,
       bg.garantee_id,
       bg.garantee_num,
       bg.garantee_name,
       gi.insurance_id,
       i.name as insurance_name,
       cnt.idx - 1 as insurance_num,
       i.ins_type_id,
       wcs_utl.get_answ_text(bg.bid_id,
                             gi.ws_qid,
                             bg.ws_id,
                             bg.garantee_num) as ws_id,
       wcs_utl.get_answ_list(bg.bid_id,
                             i.status_qid,
                             wcs_utl.get_answ_text(bg.bid_id,
                                                   gi.ws_qid,
                                                   bg.ws_id,
                                                   bg.garantee_num),
                             cnt.idx - 1) as status_id,
       wcs_utl.get_answ_list_text(bg.bid_id,
                                  i.status_qid,
                                  wcs_utl.get_answ_text(bg.bid_id,
                                                        gi.ws_qid,
                                                        bg.ws_id,
                                                        bg.garantee_num),
                                  cnt.idx - 1) as status_name,
       wcs_utl.get_answ_refer(bg.bid_id,
                              'INS_PARTNER_ID',
                              wcs_utl.get_answ_text(bg.bid_id,
                                                    gi.ws_qid,
                                                    bg.ws_id,
                                                    bg.garantee_num),
                              cnt.idx - 1) as partner_id,
       (select ip.name
          from v_ins_partners ip
         where ip.partner_id =
               to_number(wcs_utl.get_answ_refer(bg.bid_id,
                                                'INS_PARTNER_ID',
                                                wcs_utl.get_answ_text(bg.bid_id,
                                                                      gi.ws_qid,
                                                                      bg.ws_id,
                                                                      bg.garantee_num),
                                                cnt.idx - 1))) as partner_name,
       wcs_utl.get_answ_text(bg.bid_id,
                             'INS_SER',
                             wcs_utl.get_answ_text(bg.bid_id,
                                                   gi.ws_qid,
                                                   bg.ws_id,
                                                   bg.garantee_num),
                             cnt.idx - 1) as ser,
       wcs_utl.get_answ_text(bg.bid_id,
                             'INS_NUM',
                             wcs_utl.get_answ_text(bg.bid_id,
                                                   gi.ws_qid,
                                                   bg.ws_id,
                                                   bg.garantee_num),
                             cnt.idx - 1) as num,
       wcs_utl.get_answ_date(bg.bid_id,
                             'INS_DATE_ON',
                             wcs_utl.get_answ_text(bg.bid_id,
                                                   gi.ws_qid,
                                                   bg.ws_id,
                                                   bg.garantee_num),
                             cnt.idx - 1) as date_on,
       wcs_utl.get_answ_date(bg.bid_id,
                             'INS_DATE_OFF',
                             wcs_utl.get_answ_text(bg.bid_id,
                                                   gi.ws_qid,
                                                   bg.ws_id,
                                                   bg.garantee_num),
                             cnt.idx - 1) as date_off,
       wcs_utl.get_answ_decimal(bg.bid_id,
                                'INS_SUM',
                                wcs_utl.get_answ_text(bg.bid_id,
                                                      gi.ws_qid,
                                                      bg.ws_id,
                                                      bg.garantee_num),
                                cnt.idx - 1) as sum
  from v_wcs_bid_garantees     bg,
       wcs_garantee_insurances gi,
       wcs_insurances          i,
       wcs_counter             cnt
 where bg.garantee_id = gi.garantee_id
   and gi.insurance_id = i.id
   and cnt.idx <=
       wcs_utl.get_answ_numb(bg.bid_id,
                             i.count_qid,
                             wcs_utl.get_answ_text(bg.bid_id,
                                                   gi.ws_qid,
                                                   bg.ws_id,
                                                   bg.garantee_num))
 order by bg.bid_id, gi.insurance_id;

PROMPT *** Create  grants  V_WCS_BID_GRT_INSURANCES ***
grant SELECT                                                                 on V_WCS_BID_GRT_INSURANCES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BID_GRT_INSURANCES.sql =========*
PROMPT ===================================================================================== 
