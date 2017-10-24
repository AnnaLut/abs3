

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BRANCH_PARAMS_VALUES.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view BRANCH_PARAMS_VALUES ***

  CREATE OR REPLACE FORCE VIEW BARS.BRANCH_PARAMS_VALUES ("MFO", "NAME", "PARAM_VALUE") AS 
  SELECT BRANCH,TAG,VAL FROM BRANCH_PARAMETERS 
 ;

PROMPT *** Create  grants  BRANCH_PARAMS_VALUES ***
grant SELECT                                                                 on BRANCH_PARAMS_VALUES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BRANCH_PARAMS_VALUES to PYOD001;
grant SELECT                                                                 on BRANCH_PARAMS_VALUES to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BRANCH_PARAMS_VALUES to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BRANCH_PARAMS_VALUES.sql =========*** E
PROMPT ===================================================================================== 
