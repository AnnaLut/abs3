DECLARE
   l_cnt   NUMBER (10);
BEGIN
   SELECT COUNT (1)
     INTO l_cnt
     FROM dyn_filter
    WHERE WHERE_CLAUSE =
             '(  $~~ALIAS~~$.ND IN ( select d.nd from cc_deal d where not exists (select 1 from nd_txt n where n.nd = d.nd and n.tag IN (''VNCRP'', ''VNCRP'') AND n.txt IS  not NULL)))';

   IF l_cnt = 0
   THEN
      INSERT INTO BARS.DYN_FILTER (FILTER_ID,
                                   TABID,
                                   SEMANTIC,
                                   WHERE_CLAUSE,
                                   BRANCH)
              VALUES (
                        s_dyn_filter.NEXTVAL,
                        BARS_METABASE.GET_TABID ('V_CCK_RF'),
                        'КД з невизначеним ВКР',
                        '(  $~~ALIAS~~$.ND IN ( select d.nd from cc_deal d where not exists (select 1 from nd_txt n where n.nd = d.nd and n.tag IN (''VNCRP'', ''VNCRP'') AND n.txt IS  not NULL)))',
                        '/');
   END IF;
END;
/
COMMIT;