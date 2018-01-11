

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VW_ESCR_INVALID_CREDITS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view VW_ESCR_INVALID_CREDITS ***

  CREATE OR REPLACE FORCE VIEW BARS.VW_ESCR_INVALID_CREDITS ("DEAL_ID", "ERROR_ID") AS 
  SELECT  t.deal_id, 1 error_id
  FROM bars.vw_escr_reg_all_credits t
 WHERE (t.nls IS NULL or t.nls='-999')
   AND( t.credit_status_id NOT IN (1, 2, 3, 4, 5, 6, 7, 11) or  t.credit_status_id is null)
   AND t.money_date IS NULL
   AND t.doc_date IS NOT NULL
UNION ALL
SELECT  t.deal_id, 2 error_id
  FROM bars.vw_escr_reg_all_credits t
 WHERE t.subs_available = 1
   AND (t.subs_numb IS NULL OR t.subs_date IS NULL OR
       t.subs_doc_type IS NULL)
   AND( t.credit_status_id NOT IN (1, 2, 3, 4, 5, 6, 7, 11) or  t.credit_status_id is null)
   AND t.money_date IS NULL
   AND t.doc_date IS NOT NULL
UNION ALL
  SELECT  t.deal_id, 3 error_id
  FROM bars.vw_escr_reg_all_credits t
 WHERE ( t.good_cost = 0 or nvl(t.good_cost - t.deal_sum, 0) <= nvl(t.deal_sum * 0.1, 0))
   AND( t.credit_status_id NOT IN (1, 2, 3, 4, 5, 6, 7, 11) or  t.credit_status_id is null)
   AND t.money_date IS NULL
   AND t.doc_date IS NOT NULL
UNION ALL
  SELECT  t.deal_id, 4 error_id
  FROM bars.vw_escr_reg_all_credits t
 WHERE( t.credit_status_id NOT IN (1, 2, 3, 4, 5, 6, 7, 11) or  t.credit_status_id is null)
   AND t.money_date IS NULL
   AND t.doc_date IS NOT NULL
   AND NOT EXISTS
 (SELECT 1
          FROM (SELECT t.nd
                      ,t.txt
                      ,t.tag
                      ,t.kf
                      ,CASE
                         WHEN t.tag IN ('ES104'
                                       ,'ES110'
                                       ,'ES116'
                                       ,'ES122'
                                       ,'ES128'
                                       ,'ES134'
                                       ,'ES140'
                                       ,'ES146'
                                       ,'ES152'
                                       ,'ES158'
                                       ,'ES164'
                                       ,'ES170'
                                       ,'ES176'
                                       ,'ES182'
                                       ,'ES188'
                                       ,'ES194'
                                       ,'ES200'
                                       ,'ES206'
                                       ,'ES212'
                                       ,'ES218') THEN
                          1
                         WHEN t.tag IN ('ES242'
                                       ,'ES248'
                                       ,'ES254'
                                       ,'ES260'
                                       ,'ES266'
                                       ,'ES272'
                                       ,'ES278'
                                       ,'ES284'
                                       ,'ES290'
                                       ,'ES296'
                                       ,'ES302'
                                       ,'ES308'
                                       ,'ES314'
                                       ,'ES320'
                                       ,'ES326'
                                       ,'ES332'
                                       ,'ES338'
                                       ,'ES344'
                                       ,'ES350'
                                       ,'ES356') THEN
                          2
                         WHEN t.tag IN ('ES380'
                                       ,'ES386'
                                       ,'ES392'
                                       ,'ES398'
                                       ,'ES404'
                                       ,'ES410'
                                       ,'ES416'
                                       ,'ES422'
                                       ,'ES428'
                                       ,'ES434'
                                       ,'ES440'
                                       ,'ES446'
                                       ,'ES452'
                                       ,'ES458'
                                       ,'ES464'
                                       ,'ES470'
                                       ,'ES476'
                                       ,'ES482'
                                       ,'ES488'
                                       ,'ES494') THEN
                          3
                       END adr_id
                  FROM bars.nd_txt t
                  JOIN bars.cc_tag t1
                    ON to_char(t.tag) = to_char(t1.tag)
                 WHERE t1.code = 'STPROG'
                   AND t.txt IN
                       (SELECT to_char(ev.id) FROM bars.escr_events ev)
                   AND t.txt IS NOT NULL
                   AND t.tag IN ('ES104'
                                ,'ES110'
                                ,'ES116'
                                ,'ES122'
                                ,'ES128'
                                ,'ES134'
                                ,'ES140'
                                ,'ES146'
                                ,'ES152'
                                ,'ES158'
                                ,'ES164'
                                ,'ES170'
                                ,'ES176'
                                ,'ES182'
                                ,'ES188'
                                ,'ES194'
                                ,'ES200'
                                ,'ES206'
                                ,'ES212'
                                ,'ES218'
                                ,'ES242'
                                ,'ES248'
                                ,'ES254'
                                ,'ES260'
                                ,'ES266'
                                ,'ES272'
                                ,'ES278'
                                ,'ES284'
                                ,'ES290'
                                ,'ES296'
                                ,'ES302'
                                ,'ES308'
                                ,'ES314'
                                ,'ES320'
                                ,'ES326'
                                ,'ES332'
                                ,'ES338'
                                ,'ES344'
                                ,'ES350'
                                ,'ES356'
                                ,'ES380'
                                ,'ES386'
                                ,'ES392'
                                ,'ES398'
                                ,'ES404'
                                ,'ES410'
                                ,'ES416'
                                ,'ES422'
                                ,'ES428'
                                ,'ES434'
                                ,'ES440'
                                ,'ES446'
                                ,'ES452'
                                ,'ES458'
                                ,'ES464'
                                ,'ES470'
                                ,'ES476'
                                ,'ES482'
                                ,'ES488'
                                ,'ES494')
                 ORDER BY t.tag) t1
         WHERE t.deal_id = t1.nd)
UNION ALL
SELECT  t.deal_id, 5 error_id
  FROM bars.vw_escr_reg_all_credits t
 WHERE( t.credit_status_id NOT IN (1, 2, 3, 4, 5, 6, 7, 11) or  t.credit_status_id is null)
   AND t.money_date IS NULL
   AND t.doc_date IS NOT NULL
   AND NOT EXISTS (SELECT 1
          FROM (SELECT t.nd
                      ,t.txt
                      ,t.tag
                      ,t.kf
                      ,CASE t.tag
                         WHEN 'ES084' THEN
                          1
                         WHEN 'ES236' THEN
                          2
                         WHEN 'ES374' THEN
                          3
                       END adr_id
                  FROM bars.nd_txt t
                  JOIN bars.cc_tag t1
                    ON to_char(t.tag) = to_char(t1.tag)
                 WHERE t1.code = 'STPROG'
                   AND t.tag IN ('ES084', 'ES236', 'ES374')
                   AND t.txt IS NOT NULL) t1
         WHERE t.deal_id = t1.nd)
UNION ALL
SELECT  tt.deal_id,  case tt.adr_id when 1 then 6 when 2 then 7 when 3 then 8 end error_id
  FROM (SELECT t.nd deal_id
              ,t.txt
              ,CASE
                 WHEN tag IN ('ES069'
                             ,'ES070'
                             ,'ES072'
                             ,'ES075'
                             ,'ES076'
                             ,'ES077'
                             ,'ES078'
                             ,'ES079'
                             ,'ES080'
                             ,'ES081'
                             ,'ES082') THEN
                  1
                 WHEN tag IN ('ES219'
                             ,'ES220'
                             ,'ES222'
                             ,'ES225'
                             ,'ES226'
                             ,'ES227'
                             ,'ES228'
                             ,'ES229'
                             ,'ES230'
                             ,'ES231'
                             ,'ES232') THEN
                  2
                 WHEN tag IN ('ES357'
                             ,'ES358'
                             ,'ES360'
                             ,'ES363'
                             ,'ES364'
                             ,'ES365'
                             ,'ES366'
                             ,'ES367'
                             ,'ES368'
                             ,'ES369'
                             ,'ES370') THEN
                  3
               END adr_id
              ,CASE
                 WHEN tag IN ('ES069', 'ES219', 'ES357') THEN
                  'LOCALITY_TYPE'
                 WHEN tag IN ('ES070', 'ES220', 'ES358') THEN
                  'LOCALITY'
                 WHEN tag IN ('ES072', 'ES222', 'ES360') THEN
                  'AREA'
                 WHEN tag IN ('ES075', 'ES225', 'ES363') THEN
                  'STREET_TYPE'
                 WHEN tag IN ('ES076', 'ES226', 'ES364') THEN
                  'STREET'
                 WHEN tag IN ('ES077', 'ES227', 'ES365') THEN
                  'SECTION_TYPE'
                 WHEN tag IN ('ES078', 'ES228', 'ES366') THEN
                  'SECTION'
                 WHEN tag IN ('ES079', 'ES229', 'ES367') THEN
                  'BUILD_TYPE'
                 WHEN tag IN ('ES080', 'ES230', 'ES368') THEN
                  'BUILD'
                 WHEN tag IN ('ES081', 'ES231', 'ES369') THEN
                  'FLAT_TYPE'
                 WHEN tag IN ('ES082', 'ES232', 'ES370') THEN
                  'FLAT'
               END tag_type
          FROM bars.nd_txt t
          join  bars.vw_escr_reg_all_credits t1
          on t.nd=t1.deal_id
       WHERE ( t1.credit_status_id NOT IN (1, 2, 3, 4, 5, 6, 7, 11) or  t1.credit_status_id is null)
        AND t1.money_date IS NULL
          AND t1.doc_date IS NOT NULL
         AND t.tag IN ('ES069'
                        ,'ES070'
                        ,'ES072'
                        ,'ES075'
                        ,'ES076'
                        ,'ES077'
                        ,'ES078'
                        ,'ES079'
                        ,'ES080'
                        ,'ES081'
                        ,'ES082'
                        ,'ES219'
                        ,'ES220'
                        ,'ES222'
                        ,'ES225'
                        ,'ES226'
                        ,'ES227'
                        ,'ES228'
                        ,'ES229'
                        ,'ES230'
                        ,'ES231'
                        ,'ES232'
                        ,'ES357'
                        ,'ES358'
                        ,'ES360'
                        ,'ES363'
                        ,'ES364'
                        ,'ES365'
                        ,'ES366'
                        ,'ES367'
                        ,'ES368'
                        ,'ES369'
                        ,'ES370')
         ORDER BY t.tag) pivot(MAX(txt) FOR tag_type IN('LOCALITY_TYPE' AS
                                                        locality_type
                                                       ,'LOCALITY' AS
                                                        locality
                                                       ,'AREA' AS area
                                                       ,'STREET_TYPE' AS
                                                        street_type
                                                       ,'STREET' AS street
                                                       ,'SECTION_TYPE' AS
                                                        section_type
                                                       ,'SECTION' AS
                                                        section
                                                       ,'BUILD_TYPE' AS
                                                        build_type
                                                       ,'BUILD' AS build
                                                       ,'FLAT_TYPE' AS
                                                        flat_type
                                                       ,'FLAT' AS flat)) tt
 WHERE tt.locality_type IS NULL
    OR tt.locality IS NULL
    OR tt.street_type IS NULL
    OR tt.street IS NULL
    OR tt.build_type IS NULL
    OR tt.build IS NULL
union all
select  rez.deal_id,  rez.error_id from (
SELECT
case when tt.adr_id =1 aND  tt.build_type_id=1 and (tt.flat_type is not null or TT.FLAT IS not null) then 11
  when tt.adr_id =2 aND  tt.build_type_id=1 and (tt.flat_type is not null or  TT.FLAT IS not null) then 12
  when tt.adr_id =3 aND  tt.build_type_id=1 and (tt.flat_type is not null  or  TT.FLAT IS not null ) then 13
  when tt.adr_id =1 aND  tt.build_type_id=2 and (tt.flat_type is null or  TT.FLAT IS  null   or TT.FLAT not in ('1','2')) then 14
  when tt.adr_id =2 aND  tt.build_type_id=2 and (tt.flat_type is null or  TT.FLAT IS  null   or TT.FLAT not in ('1','2')) then 15
  when tt.adr_id =3 aND  tt.build_type_id=2 and (tt.flat_type is null or  TT.FLAT IS  null   or TT.FLAT not in ('1','2')) then 16
  when tt.adr_id =1 aND  tt.build_type_id=3 and (tt.flat_type is null or  TT.FLAT IS  null)  then 17
  when tt.adr_id =2 aND  tt.build_type_id=3 and (tt.flat_type is null or  TT.FLAT IS  null) then 18
  when tt.adr_id =3 aND  tt.build_type_id=3 and (tt.flat_type is null or  TT.FLAT IS  null)  then 19
end error_id, tt.*
FROM (SELECT t.nd deal_id
              ,t.txt
              ,CASE
                 WHEN tag IN ('ES084', 'ES081', 'ES082') THEN
                  1
                 WHEN tag IN ('ES236', 'ES231', 'ES232') THEN
                  2
                 WHEN tag IN ('ES374', 'ES369', 'ES370') THEN
                  3
               END adr_id
              ,CASE
                 WHEN tag IN ('ES084', 'ES236', 'ES374') THEN
                  'BUILD_TYPE_ID'
                 WHEN tag IN ('ES081', 'ES231', 'ES369') THEN
                  'FLAT_TYPE'
                 WHEN tag IN ('ES082', 'ES232', 'ES370') THEN
                  'FLAT'
               END tag_type
          FROM bars.nd_txt t
          JOIN bars.vw_escr_reg_all_credits t1
            ON t.nd = t1.deal_id
         WHERE t1.credit_status_id NOT IN (1, 2, 3, 4, 5, 6, 7, 11)
           AND t1.money_date IS NULL
           AND t1.doc_date IS NOT NULL
           AND t.tag IN ('ES081'
                        ,'ES082'
                        ,'ES231'
                        ,'ES232'
                        ,'ES369'
                        ,'ES370'
                        ,'ES084'
                        ,'ES236'
                        ,'ES374')
         ORDER BY t.tag) pivot(MAX(txt) FOR tag_type IN('BUILD_TYPE_ID' AS
                                                        build_type_id
                                                       ,'FLAT_TYPE' AS
                                                        flat_type
                                                       ,'FLAT' AS flat)) tt) rez where rez.error_id is not null
union all
select t.deal_id, 10 error_id
  FROM bars.vw_escr_reg_body t, bars.cc_deal d
  , bars.vw_escr_reg_all_credits t1
    WHERE t.deal_id = t1.deal_id
 AND  (t1.credit_status_id NOT IN (1, 2, 3, 4, 5, 6, 7, 11) or  t1.credit_status_id is null)
   AND t1.money_date IS NULL
   AND t1.doc_date IS NOT NULL
   AND t.deal_id = d.nd
   AND NOT EXISTS (SELECT 1
          FROM bars.vw_escr_ref r
         WHERE r.event_id = t.deal_event_id
           AND r.build_type_id = t.deal_build_id
           AND substr(d.prod, 1, 6) = r.ob22);

PROMPT *** Create  grants  VW_ESCR_INVALID_CREDITS ***
grant SELECT                                                                 on VW_ESCR_INVALID_CREDITS to BARSREADER_ROLE;
grant SELECT                                                                 on VW_ESCR_INVALID_CREDITS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VW_ESCR_INVALID_CREDITS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VW_ESCR_INVALID_CREDITS.sql =========**
PROMPT ===================================================================================== 
