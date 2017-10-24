

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VW_ESCR_ADR_HOME_TYPE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view VW_ESCR_ADR_HOME_TYPE ***

  CREATE OR REPLACE FORCE VIEW BARS.VW_ESCR_ADR_HOME_TYPE ("ID", "NAME", "VALUE") AS 
  SELECT 1 id, 'будинок' NAME, 'буд.' VALUE
  FROM dual
UNION ALL
SELECT 2 id, 'домоволодіння' NAME, 'д/в.' VALUE
  FROM dual;

PROMPT *** Create  grants  VW_ESCR_ADR_HOME_TYPE ***
grant SELECT                                                                 on VW_ESCR_ADR_HOME_TYPE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VW_ESCR_ADR_HOME_TYPE.sql =========*** 
PROMPT ===================================================================================== 
