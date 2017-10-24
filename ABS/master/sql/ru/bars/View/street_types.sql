

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/STREET_TYPES.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view STREET_TYPES ***

  CREATE OR REPLACE FORCE VIEW BARS.STREET_TYPES ("TYPE_ID", "TYPE_NAME", "TYPE_PREFIX", "TYPE_ORD") AS 
  select ID, NAME, VALUE, ID
    from ADDRESS_STREET_TYPE;

PROMPT *** Create  grants  STREET_TYPES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on STREET_TYPES    to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on STREET_TYPES    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on STREET_TYPES    to DPT_ADMIN;
grant SELECT                                                                 on STREET_TYPES    to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on STREET_TYPES    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/STREET_TYPES.sql =========*** End *** =
PROMPT ===================================================================================== 
