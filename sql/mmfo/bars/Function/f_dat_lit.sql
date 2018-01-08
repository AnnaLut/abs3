
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_dat_lit.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_DAT_LIT ( dat_ DATE, lang_ CHAR DEFAULT 'U' )
RETURN VARCHAR2 IS
sDAT_     VARCHAR2(40);
dd_       VARCHAR2(2);
mm_       VARCHAR2(2);
yyyy_     VARCHAR2(4);

BEGIN
   SELECT to_char(to_date(dat_),'dd'),
          to_number(to_char(to_date(dat_),'mm')),
          to_char(to_date(dat_),'yyyy' )
     INTO dd_, mm_, yyyy_
     FROM dual;

   SELECT '" '||substr('00'||dd_,-2)||' "'||' '||
          decode(lang_,'R',m.name_rus_from,m.name_from)||' '||
          yyyy_||'ð.'
     INTO sDAT_
     FROM meta_month m
    WHERE m.n=to_number(mm_);

   RETURN sDAT_;
END F_DAT_LIT;
/
 show err;
 
PROMPT *** Create  grants  F_DAT_LIT ***
grant EXECUTE                                                                on F_DAT_LIT       to ABS_ADMIN;
grant EXECUTE                                                                on F_DAT_LIT       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_DAT_LIT       to CC_DOC;
grant EXECUTE                                                                on F_DAT_LIT       to DPT;
grant EXECUTE                                                                on F_DAT_LIT       to RPBN001;
grant EXECUTE                                                                on F_DAT_LIT       to RS;
grant EXECUTE                                                                on F_DAT_LIT       to START1;
grant EXECUTE                                                                on F_DAT_LIT       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_dat_lit.sql =========*** End *** 
 PROMPT ===================================================================================== 
 