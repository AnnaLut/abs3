
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/vkrzn.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.VKRZN (AMF_ varchar2, NLS_ varchar2) RETURN VARCHAR2 IS
  m1_  VARCHAR2(9);
  m2_  VARCHAR2(15);
  w_   VARCHAR2(15);
  nl_  VARCHAR2(15);
  am_  VARCHAR2(9);
  i_   number;
  j_   number;
  la_  number;
  ln_  number;
BEGIN
 --bars_audit.info('VKRZN PAR AMF_= '||AMF_||'NLS_= '||NLS_);
  la_ := 5; --length(amf_);
  ln_ := length(nls_);
  if nvl(ln_,0)<5 then
    return nls_;
  end if;
  nl_ := '';
  FOR i_ in 1..ln_
  LOOP
    begin
      nl_:=nl_||to_char(to_number(substr(nls_,i_,1)));
    exception when others then
      nl_:=nl_||'0';
    end;
  END LOOP;
  am_ := '';
  FOR i_ in 1..la_
  LOOP
    begin
      am_:=am_||to_char(to_number(substr(AMF_,i_,1)));
    exception when others then
      am_:=am_||'0';
    end;
  END LOOP;
  w_  := substr(nl_,1,4)||'0'||substr(nl_,6,ln_-5);
  m1_ := '13713';
  m2_ := '37137137137137';
  j_  := 0;
  FOR i_ in 1..la_
  LOOP
    j_:=j_+to_number(substr(am_,i_,1))*to_number(substr(m1_,i_,1));
  END LOOP;
  FOR i_ in 1..ln_
  LOOP
    j_:=j_+to_number(substr(w_,i_,1))*to_number(substr(m2_,i_,1));
  END LOOP;
  RETURN substr(nl_,1,4)||nvl(to_char(MOD((j_+ln_)*7,10)),'X')||substr(nl_,6,ln_-5);
END VKRZN;
/
 show err;
 
PROMPT *** Create  grants  VKRZN ***
grant EXECUTE                                                                on VKRZN           to ABS_ADMIN;
grant EXECUTE                                                                on VKRZN           to BARS015;
grant EXECUTE                                                                on VKRZN           to BARSAQ with grant option;
grant EXECUTE                                                                on VKRZN           to BARSAQ_ADM;
grant EXECUTE                                                                on VKRZN           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on VKRZN           to START1;
grant EXECUTE                                                                on VKRZN           to WR_ALL_RIGHTS;
grant EXECUTE                                                                on VKRZN           to WR_CREDIT;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/vkrzn.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 