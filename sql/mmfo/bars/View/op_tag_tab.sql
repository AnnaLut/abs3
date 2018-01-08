

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OP_TAG_TAB.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view OP_TAG_TAB ***

  CREATE OR REPLACE FORCE VIEW BARS.OP_TAG_TAB ("TAG", "NAME", "TAB") AS 
  select tag, name, substr( tab,1, instr(tab,' ')-1) tab
from ( select tag, name,
              trim( replace ( replace ( substr( UPPER(browser),
                                                instr( upper(browser),'FROM')+5
                                                ),
                                        '"',' '
                                        ),
                             '''',' '
                             )
                  ) tab
       from op_field
       where browser is not null
      );

PROMPT *** Create  grants  OP_TAG_TAB ***
grant SELECT                                                                 on OP_TAG_TAB      to BARSREADER_ROLE;
grant SELECT                                                                 on OP_TAG_TAB      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OP_TAG_TAB      to STO;
grant SELECT                                                                 on OP_TAG_TAB      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OP_TAG_TAB.sql =========*** End *** ===
PROMPT ===================================================================================== 
