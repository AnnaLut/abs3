

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_FORM_STRU.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_FORM_STRU ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_FORM_STRU ("FILE_ID", "FILE_CODE", "SCHEME_CODE", "SEGMENT_NUMBER", "SEGMENT_NAME", "SEGMENT_RULE", "SORT_ATTRIBUTE", "KEY_ATTRIBUTE") AS 
  SELECT f.id file_id,
          f.file_code,
          F.SCHEME_CODE,
          P.SEGMENT_NUMBER,
          P.SEGMENT_NAME,
          REPLACE (REPLACE (UPPER (P.SEGMENT_RULE), 'KODP', 'FIELD_CODE'),
                   'ZNAP',
                   'FIELD_VALUE')
             SEGMENT_RULE,
          P.SORT_ATTRIBUTE,
          P.KEY_ATTRIBUTE
     FROM NBUR_REF_FILES f JOIN NBUR_REF_FORM_STRU p ON (F.ID = p.FILE_ID);

PROMPT *** Create  grants  V_NBUR_FORM_STRU ***
grant SELECT                                                                 on V_NBUR_FORM_STRU to BARSREADER_ROLE;
grant SELECT                                                                 on V_NBUR_FORM_STRU to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_FORM_STRU to RPBN002;
grant SELECT                                                                 on V_NBUR_FORM_STRU to START1;
grant SELECT                                                                 on V_NBUR_FORM_STRU to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_FORM_STRU.sql =========*** End *
PROMPT ===================================================================================== 
