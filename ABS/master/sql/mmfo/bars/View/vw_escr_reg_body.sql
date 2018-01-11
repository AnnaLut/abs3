

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VW_ESCR_REG_BODY.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view VW_ESCR_REG_BODY ***

  CREATE OR REPLACE FORCE VIEW BARS.VW_ESCR_REG_BODY ("DEAL_ID", "DEAL_KF", "DEAL_ADR_ID", "DEAL_REGION", "DEAL_FULL_ADDRESS", "DEAL_BUILD_TYPE", "DEAL_EVENT_ID", "DEAL_EVENT", "DEAL_BUILD_ID", "DEAL_EVENT_RW") AS 
  WITH reg_region
           AS (SELECT t.nd,
                      t.txt,
                      t.tag,
                      t.kf,
                      CASE t.tag
                         WHEN 'ES074' THEN 1
                         WHEN 'ES224' THEN 2
                         WHEN 'ES362' THEN 3
                      END
                         adr_id
                 FROM nd_txt t JOIN cc_tag t1 ON to_char(t.tag) = to_char(t1.tag)
                WHERE     t1.code = 'STPROG'
                      AND t.tag IN ('ES074', 'ES224', 'ES362')
                      AND t.txt IS NOT NULL),
        reg_build_type
           AS (SELECT t.nd,
                      t.txt,
                      t.tag,
                      t.kf,
                      CASE t.tag
                         WHEN 'ES084' THEN 1
                         WHEN 'ES236' THEN 2
                         WHEN 'ES374' THEN 3
                      END
                         adr_id
                 FROM nd_txt t JOIN cc_tag t1 ON to_char(t.tag) = to_char(t1.tag)
                WHERE     t1.code = 'STPROG'
                      AND t.tag IN ('ES084', 'ES236', 'ES374')
                      AND t.txt IS NOT NULL),
        reg_events
           AS (  SELECT t.nd,
                        t.txt,
                        t.tag,
                        t.kf,
                        CASE
                           WHEN t.tag IN
                                   ('ES104',
                                    'ES110',
                                    'ES116',
                                    'ES122',
                                    'ES128',
                                    'ES134',
                                    'ES140',
                                    'ES146',
                                    'ES152',
                                    'ES158',
                                    'ES164',
                                    'ES170',
                                    'ES176',
                                    'ES182',
                                    'ES188',
                                    'ES194',
                                    'ES200',
                                    'ES206',
                                    'ES212',
                                    'ES218')
                           THEN
                              1
                           WHEN t.tag IN
                                   ('ES242',
                                    'ES248',
                                    'ES254',
                                    'ES260',
                                    'ES266',
                                    'ES272',
                                    'ES278',
                                    'ES284',
                                    'ES290',
                                    'ES296',
                                    'ES302',
                                    'ES308',
                                    'ES314',
                                    'ES320',
                                    'ES326',
                                    'ES332',
                                    'ES338',
                                    'ES344',
                                    'ES350',
                                    'ES356')
                           THEN
                              2
                           WHEN t.tag IN
                                   ('ES380',
                                    'ES386',
                                    'ES392',
                                    'ES398',
                                    'ES404',
                                    'ES410',
                                    'ES416',
                                    'ES422',
                                    'ES428',
                                    'ES434',
                                    'ES440',
                                    'ES446',
                                    'ES452',
                                    'ES458',
                                    'ES464',
                                    'ES470',
                                    'ES476',
                                    'ES482',
                                    'ES488',
                                    'ES494')
                           THEN
                              3
                        END
                           adr_id
                   FROM nd_txt t JOIN cc_tag t1 ON to_char(t.tag) = to_char(t1.tag)
                  WHERE     t1.code = 'STPROG'
                        AND t.txt IN (SELECT TO_CHAR (ev.id)
                                        FROM escr_events ev)
                        AND t.txt IS NOT NULL
                        AND t.tag IN
                               ('ES104',
                                'ES110',
                                'ES116',
                                'ES122',
                                'ES128',
                                'ES134',
                                'ES140',
                                'ES146',
                                'ES152',
                                'ES158',
                                'ES164',
                                'ES170',
                                'ES176',
                                'ES182',
                                'ES188',
                                'ES194',
                                'ES200',
                                'ES206',
                                'ES212',
                                'ES218',
                                'ES242',
                                'ES248',
                                'ES254',
                                'ES260',
                                'ES266',
                                'ES272',
                                'ES278',
                                'ES284',
                                'ES290',
                                'ES296',
                                'ES302',
                                'ES308',
                                'ES314',
                                'ES320',
                                'ES326',
                                'ES332',
                                'ES338',
                                'ES344',
                                'ES350',
                                'ES356',
                                'ES380',
                                'ES386',
                                'ES392',
                                'ES398',
                                'ES404',
                                'ES410',
                                'ES416',
                                'ES422',
                                'ES428',
                                'ES434',
                                'ES440',
                                'ES446',
                                'ES452',
                                'ES458',
                                'ES464',
                                'ES470',
                                'ES476',
                                'ES482',
                                'ES488',
                                'ES494')
               ORDER BY t.tag),
        reg_adr_full
           AS (SELECT tt.nd,
                      tt.adr_id,
                      TRIM (
                            DECODE (tt.area,null, '', tt.area||' ,' )
                         || decode(tt.locality_type,null,'',  tt.locality_type)
                         || decode(tt.locality,null,'', ''|| tt.locality)
                         || decode(tt.street_type,null,'', ' ,'|| street_type)
                         || decode(tt.street,null,'', ' '|| tt.street)
                         || DECODE (tt.section_type,null,
                                    '', '' || tt.section_type)
                         || DECODE (tt.section,null, '', tt.section )
                         || DECODE (tt.build_type, null,' ', ' ,' ||tt.build_type)
                         || DECODE (tt.build,null, '', ' '|| tt.build )
                         || DECODE (tt.flat_type,null ,' ',  ' ,' ||tt.flat_type)
                         || DECODE (tt.flat,null ,'', ' '||tt.flat))
                         txt
                 FROM (SELECT *
                         FROM (  SELECT t.nd,
                                        t.txt,
                                        CASE
                                           WHEN tag IN
                                                   ('ES069',
                                                    'ES070',
                                                    'ES072',
                                                    'ES075',
                                                    'ES076',
                                                    'ES077',
                                                    'ES078',
                                                    'ES079',
                                                    'ES080',
                                                    'ES081',
                                                    'ES082')
                                           THEN
                                              1
                                           WHEN tag IN
                                                   ('ES219',
                                                    'ES220',
                                                    'ES222',
                                                    'ES225',
                                                    'ES226',
                                                    'ES227',
                                                    'ES228',
                                                    'ES229',
                                                    'ES230',
                                                    'ES231',
                                                    'ES232')
                                           THEN
                                              2
                                           WHEN tag IN
                                                   ('ES357',
                                                    'ES358',
                                                    'ES360',
                                                    'ES363',
                                                    'ES364',
                                                    'ES365',
                                                    'ES366',
                                                    'ES367',
                                                    'ES368',
                                                    'ES369',
                                                    'ES370')
                                           THEN
                                              3
                                        END
                                           adr_id,
                                        CASE
                                           WHEN tag IN
                                                   ('ES069', 'ES219', 'ES357')
                                           THEN
                                              'LOCALITY_TYPE'
                                           WHEN tag IN
                                                   ('ES070', 'ES220', 'ES358')
                                           THEN
                                              'LOCALITY'
                                           WHEN tag IN
                                                   ('ES072', 'ES222', 'ES360')
                                           THEN
                                              'AREA'
                                           WHEN tag IN
                                                   ('ES075', 'ES225', 'ES363')
                                           THEN
                                              'STREET_TYPE'
                                           WHEN tag IN
                                                   ('ES076', 'ES226', 'ES364')
                                           THEN
                                              'STREET'
                                           WHEN tag IN
                                                   ('ES077', 'ES227', 'ES365')
                                           THEN
                                              'SECTION_TYPE'
                                           WHEN tag IN
                                                   ('ES078', 'ES228', 'ES366')
                                           THEN
                                              'SECTION'
                                           WHEN tag IN
                                                   ('ES079', 'ES229', 'ES367')
                                           THEN
                                              'BUILD_TYPE'
                                           WHEN tag IN
                                                   ('ES080', 'ES230', 'ES368')
                                           THEN
                                              'BUILD'
                                           WHEN tag IN
                                                   ('ES081', 'ES231', 'ES369')
                                           THEN
                                              'FLAT_TYPE'
                                           WHEN tag IN
                                                   ('ES082', 'ES232', 'ES370')
                                           THEN
                                              'FLAT'
                                        END
                                           tag_type
                                   FROM nd_txt t
                                  WHERE t.tag IN
                                           ('ES069',
                                            'ES070',
                                            'ES072',
                                            'ES075',
                                            'ES076',
                                            'ES077',
                                            'ES078',
                                            'ES079',
                                            'ES080',
                                            'ES081',
                                            'ES082',
                                            'ES219',
                                            'ES220',
                                            'ES222',
                                            'ES225',
                                            'ES226',
                                            'ES227',
                                            'ES228',
                                            'ES229',
                                            'ES230',
                                            'ES231',
                                            'ES232',
                                            'ES357',
                                            'ES358',
                                            'ES360',
                                            'ES363',
                                            'ES364',
                                            'ES365',
                                            'ES366',
                                            'ES367',
                                            'ES368',
                                            'ES369',
                                            'ES370')
                               ORDER BY t.tag) PIVOT (MAX (txt)
                                               FOR tag_type
                                               IN  ('LOCALITY_TYPE' AS locality_type,
                                                   'LOCALITY' AS locality,
                                                   'AREA' AS area,
                                                   'STREET_TYPE' AS street_type,
                                                   'STREET' AS street,
                                                   'SECTION_TYPE' AS section_type,
                                                   'SECTION' AS section,
                                                   'BUILD_TYPE' AS build_type,
                                                   'BUILD' AS build,
                                                   'FLAT_TYPE' AS flat_type,
                                                   'FLAT' AS flat))) tt)
   SELECT t.nd AS deal_id,
          t.kf AS deal_kf,
          t2.adr_id AS deal_adr_id,
          TRIM (
                     INITCAP (
                        REGEXP_REPLACE (
                           TRIM (t1.txt),
                           '( Ëø‚$| »Ø¬$|Ó·Î‡ÒÚ¸|Œ¡À¿—“‹|Ó·Î.|Œ¡À.)',
                           '')))
                    as deal_region ,
          t2.txt AS deal_full_address,
          t4.TYPE AS deal_build_type,
          t5.id AS deal_event_id,
          t5.NAME AS deal_event,
          t4.id AS deal_build_id,
          ROW_NUMBER ()
             OVER (PARTITION BY t.nd, t2.adr_id ORDER BY t2.adr_id)
             deal_event_rw
     FROM  reg_events t
        left  JOIN  reg_region t1
             ON to_char(t1.nd) = to_char(t.nd) AND t.adr_id = t1.adr_id
         left JOIN reg_adr_full t2
             ON to_char(t.nd) = to_char(t2.nd) AND t.adr_id = t2.adr_id
         left  JOIN reg_build_type t3
             ON to_char(t.nd) = to_char(t3.nd) AND t.adr_id = t3.adr_id
         LEFT JOIN escr_build_types t4
             ON to_char(t3.txt) = to_char(t4.id)
         left  JOIN escr_events t5
             ON to_char(t.txt) = to_char(t5.id) AND t5.date_to IS NULL;

PROMPT *** Create  grants  VW_ESCR_REG_BODY ***
grant SELECT                                                                 on VW_ESCR_REG_BODY to BARSREADER_ROLE;
grant SELECT                                                                 on VW_ESCR_REG_BODY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VW_ESCR_REG_BODY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VW_ESCR_REG_BODY.sql =========*** End *
PROMPT ===================================================================================== 
