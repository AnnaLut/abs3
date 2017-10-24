

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_DYN_FILTER.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_DYN_FILTER ***

   CREATE SEQUENCE  BARS.S_DYN_FILTER  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 67438 CACHE 20 ORDER  NOCYCLE ;

PROMPT *** Create  grants  S_DYN_FILTER ***
grant SELECT                                                                 on S_DYN_FILTER    to ABS_ADMIN;
grant SELECT                                                                 on S_DYN_FILTER    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_DYN_FILTER    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_DYN_FILTER.sql =========*** End *
PROMPT ===================================================================================== 
