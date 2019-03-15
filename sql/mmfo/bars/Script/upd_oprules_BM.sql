BEGIN
   FOR op IN (SELECT tt
                FROM tts
               WHERE tt IN ('TIP',
                            'BNY',
                            'BKY',
                            'TTI',
                            'BMY',
							'TMP'))
   LOOP
      FOR tags IN (SELECT tag
                     FROM op_field
                    WHERE tag IN ('BM__C',
                                  'BM__N',
                                  'BM__R',
                                  'BM__U',
                                  'BM__Y',
                                  'BM_FC',
                                  'BM_FN',
                                  'BM_FR'))
      LOOP
         BEGIN
            EXECUTE IMMEDIATE
               'update op_rules set nomodify=1 where tag = :p_tag and tt = :p_tt'
               USING tags.tag, op.tt;
         EXCEPTION
            WHEN OTHERS
            THEN
               DBMS_OUTPUT.put_line (
                  'ERROR for TT=' || op.tt || ' TAG=' || tags.tag);
         END;
      END LOOP;
   END LOOP;
   commit;
END;
/