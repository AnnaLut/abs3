

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_GROUPS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_GROUPS ***

   CREATE SEQUENCE  BARS.S_GROUPS  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1724 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_GROUPS ***
grant SELECT                                                                 on S_GROUPS        to ABS_ADMIN;
grant SELECT                                                                 on S_GROUPS        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_GROUPS        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_GROUPS.sql =========*** End *** =
PROMPT ===================================================================================== 
