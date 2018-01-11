

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BID_GARANTEES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BID_GARANTEES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BID_GARANTEES ("BID_ID", "GARANTEE_ID", "GARANTEE_NAME", "GARANTEE_NUM", "WS_ID", "STATUS_ID", "STATUS_NAME", "TYPE_OBU_ID", "TYPE_OBU_NAME", "SUBJ_OBU_ID", "SUBJ_OBU_NAME", "GRT_NAME", "AGR_NUMBER", "AGR_DATE", "GRT_COST", "TYPE_ID", "TYPE_NAME") AS 
  SELECT b.id AS bid_id,
            sg.garantee_id,
            g.name AS garantee_name,
            cnt.idx - 1 AS garantee_num,
            g.ws_id,
            wcs_utl.get_answ_list (b.id,
                                   g.status_qid,
                                   g.ws_id,
                                   cnt.idx - 1)
               AS status_id,
            wcs_utl.get_answ_list_text (b.id,
                                        g.status_qid,
                                        g.ws_id,
                                        cnt.idx - 1)
               AS status_name,
            wcs_utl.get_answ_refer (b.id,
                                    'GRT_2_1',
                                    g.ws_id,
                                    cnt.idx - 1)
               AS type_obu_id,
            wcs_utl.get_answ_refer_text (b.id,
                                         'GRT_2_1',
                                         g.ws_id,
                                         cnt.idx - 1)
               AS type_obu_name,
            wcs_utl.get_answ_refer (b.id,
                                    'GRT_2_1_0',
                                    g.ws_id,
                                    cnt.idx - 1)
               AS subj_obu_id,
            wcs_utl.get_answ_refer_text (b.id,
                                         'GRT_2_1_0',
                                         g.ws_id,
                                         cnt.idx - 1)
               AS subj_obu_name,
            wcs_utl.get_answ_text (b.id,
                                   'GRT_2_7',
                                   g.ws_id,
                                   cnt.idx - 1)
               AS grt_name,
            wcs_utl.get_answ_text (b.id,
                                   'GRT_2_3',
                                   g.ws_id,
                                   cnt.idx - 1)
               AS agr_number,
            wcs_utl.get_answ_date (b.id,
                                   'GRT_2_4',
                                   g.ws_id,
                                   cnt.idx - 1)
               AS agr_date,
            ROUND (  NVL (wcs_utl.get_answ_decimal (b.id,
                                                    'GRT_2_13',
                                                    g.ws_id,
                                                    cnt.idx - 1),
                          0)
                   + NVL (wcs_utl.get_answ_decimal (b.id,
                                                    'GRT_2_16',
                                                    g.ws_id,
                                                    cnt.idx - 1),
                          0)
                   + DECODE (sg.garantee_id,
                             'DEPOSIT',   NVL (wcs_utl.
                                                get_answ_decimal (b.id,
                                                                  'GRT_2_13',
                                                                  g.ws_id,
                                                                  cnt.idx - 1),
                                               0)
                                        * NVL (wcs_utl.
                                                get_answ_decimal (b.id,
                                                                  'GRT_6_6',
                                                                  g.ws_id,
                                                                  cnt.idx - 1),
                                               0)
                                        / 12
                                        / 100,
                             0), 2)
               AS grt_cost,
            wcs_utl.get_answ_list (b.id,
                                   'GRT_2_17',
                                   g.ws_id,
                                   cnt.idx - 1)
               AS type_id,
            wcs_utl.get_answ_list_text (b.id,
                                        'GRT_2_17',
                                        g.ws_id,
                                        cnt.idx - 1)
               AS type_name
       FROM wcs_bids b,
            wcs_subproduct_garantees sg,
            wcs_garantees g,
            wcs_counter cnt
      WHERE     b.subproduct_id = sg.subproduct_id
            AND sg.garantee_id = g.id
            AND cnt.idx <= wcs_utl.get_answ_numb (b.id, g.count_qid)
   ORDER BY b.id, sg.garantee_id, cnt.idx;

PROMPT *** Create  grants  V_WCS_BID_GARANTEES ***
grant SELECT                                                                 on V_WCS_BID_GARANTEES to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_BID_GARANTEES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_BID_GARANTEES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BID_GARANTEES.sql =========*** En
PROMPT ===================================================================================== 
