

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_STAFF.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_STAFF ***

   CREATE SEQUENCE  BARS.S_STAFF  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 51982 CACHE 20 ORDER  NOCYCLE ;

PROMPT *** Create  grants  S_STAFF ***
grant SELECT                                                                 on S_STAFF         to ABS_ADMIN;
grant SELECT                                                                 on S_STAFF         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_STAFF         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_STAFF.sql =========*** End *** ==
PROMPT ===================================================================================== 
