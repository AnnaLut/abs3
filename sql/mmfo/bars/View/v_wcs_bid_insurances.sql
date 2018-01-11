

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BID_INSURANCES.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BID_INSURANCES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BID_INSURANCES ("BID_ID", "INSURANCE_ID", "INSURANCE_NAME", "INSURANCE_NUM", "INS_TYPE_ID", "WS_ID", "STATUS_ID", "STATUS_NAME", "PARTNER_ID", "PARTNER_NAME", "SER", "NUM", "DATE_ON", "DATE_OFF", "SUM") AS 
  SELECT b.id AS bid_id,
            si.insurance_id,
            i.name AS insurance_name,
            cnt.idx - 1 AS insurance_num,
            i.ins_type_id,
            si.ws_id,
            wcs_utl.get_answ_list (b.id,
                                   i.status_qid,
                                   si.ws_id,
                                   cnt.idx - 1)
               AS status_id,
            wcs_utl.get_answ_list_text (b.id,
                                        i.status_qid,
                                        si.ws_id,
                                        cnt.idx - 1)
               AS status_name,
            wcs_utl.get_answ_refer (b.id,
                                    'INS_PARTNER_ID',
                                    si.ws_id,
                                    cnt.idx - 1)
               AS partner_id,
            (SELECT ip.name
               FROM v_ins_partners ip
              WHERE ip.PARTNER_ID = TO_NUMBER (wcs_utl.get_answ_refer (
                                                  b.id,
                                                  'INS_PARTNER_ID',
                                                  si.ws_id,
                                                  cnt.idx - 1)))
               AS partner_name,
            wcs_utl.get_answ_text (b.id,
                                   'INS_SER',
                                   si.ws_id,
                                   cnt.idx - 1)
               AS ser,
            wcs_utl.get_answ_text (b.id,
                                   'INS_NUM',
                                   si.ws_id,
                                   cnt.idx - 1)
               AS num,
            wcs_utl.get_answ_date (b.id,
                                   'INS_DATE_ON',
                                   si.ws_id,
                                   cnt.idx - 1)
               AS date_on,
            wcs_utl.get_answ_date (b.id,
                                   'INS_DATE_OFF',
                                   si.ws_id,
                                   cnt.idx - 1)
               AS date_off,
            wcs_utl.get_answ_decimal (b.id,
                                      'INS_SUM',
                                      si.ws_id,
                                      cnt.idx - 1)
               AS SUM
       FROM wcs_bids b,
            wcs_subproduct_insurances si,
            wcs_insurances i,
            wcs_counter cnt
      WHERE     b.subproduct_id = si.subproduct_id
            AND si.insurance_id = i.id
            AND cnt.idx <= wcs_utl.get_answ_numb (b.id, i.count_qid, si.ws_id)
   ORDER BY b.id, si.insurance_id;

PROMPT *** Create  grants  V_WCS_BID_INSURANCES ***
grant SELECT                                                                 on V_WCS_BID_INSURANCES to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_BID_INSURANCES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_BID_INSURANCES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BID_INSURANCES.sql =========*** E
PROMPT ===================================================================================== 
