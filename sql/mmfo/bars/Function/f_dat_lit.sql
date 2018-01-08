CREATE OR REPLACE FUNCTION BARS.F_DAT_LIT( dat_ DATE, lang_ CHAR DEFAULT 'U' )
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

  IF lang_ = 'U' THEN 
    
   SELECT '" '||substr('00'||dd_,-2)||' "'||' '|| m.name_from||' '||yyyy_||'ð.'
     INTO sDAT_
     FROM meta_month m
    WHERE m.n=to_number(mm_);
    
  ELSIF lang_ = 'R' THEN 
   
   SELECT '" '||substr('00'||dd_,-2)||' "'||' '|| m.name_rus_from||' '||yyyy_||'ã.'
     INTO sDAT_
     FROM meta_month m
    WHERE m.n=to_number(mm_);
   
  ELSIF lang_ = 'ENG' THEN 
   
   SELECT '" '||substr('00'||dd_,-2)||' "'||' '|| m.NAME_ENG||' '||yyyy_||''
     INTO sDAT_
     FROM meta_month m
    WHERE m.n=to_number(mm_);
 
  END IF;

   RETURN sDAT_;
END F_DAT_LIT;
/

grant EXECUTE on F_DAT_LIT to ABS_ADMIN;
grant EXECUTE on F_DAT_LIT to BARS_ACCESS_DEFROLE;
grant EXECUTE on F_DAT_LIT to CC_DOC;
grant EXECUTE on F_DAT_LIT to DPT;
grant EXECUTE on F_DAT_LIT to RPBN001;
grant EXECUTE on F_DAT_LIT to RS;
grant EXECUTE on F_DAT_LIT to START1;
grant EXECUTE on F_DAT_LIT to WR_ALL_RIGHTS;