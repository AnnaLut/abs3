

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_FILE_TYPE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_FILE_TYPE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_FILE_TYPE ("NAME", "OFFSET", "OFFSETEXPIRE") AS 
  select name, offset, offsetexpire
     from ow_file_type
    where file_type = 'ATRANSFERS';

PROMPT *** Create  grants  V_OW_FILE_TYPE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_OW_FILE_TYPE  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_FILE_TYPE  to UPLD;
grant FLASHBACK,SELECT                                                       on V_OW_FILE_TYPE  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_FILE_TYPE.sql =========*** End ***
PROMPT ===================================================================================== 
