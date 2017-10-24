

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_LIST_FUNCSET_PK.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_LIST_FUNCSET_PK ***

   CREATE SEQUENCE  BARS.S_LIST_FUNCSET_PK  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 6001 CACHE 20 ORDER  NOCYCLE ;

PROMPT *** Create  grants  S_LIST_FUNCSET_PK ***
grant SELECT                                                                 on S_LIST_FUNCSET_PK to ABS_ADMIN;
grant SELECT                                                                 on S_LIST_FUNCSET_PK to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_LIST_FUNCSET_PK to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_LIST_FUNCSET_PK.sql =========*** 
PROMPT ===================================================================================== 
