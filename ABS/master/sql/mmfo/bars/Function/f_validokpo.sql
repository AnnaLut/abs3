
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_validokpo.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_VALIDOKPO (okpo_  varchar2) RETURN int IS
  ln_   int;
  s_    int;
  kc_   int;
  m7_   CHAR(7);
  i_    int;
  sum_  int;
  c1_   char(1);
BEGIN
  ln_ := length(okpo_);
  s_  := 0;
  if ln_=8 then
    if okpo_<'30000000' or okpo_>'60000000' then
      m7_ := '1234567';
    else
      m7_ := '7123456';
    end if;
    sum_ := 0;
    FOR i_ in 1..7
    LOOP
      c1_ := substr(okpo_,i_,1);
      if ascii(c1_)<48 or ascii(c1_)>57 then
         return -1;
      end if;
      sum_ := sum_ + to_number(substr(okpo_,i_,1))*to_number(substr(m7_,i_,1));
    END LOOP;
    kc_ := mod(sum_,11);
    if kc_=10 then
      if okpo_<'30000000' or okpo_>'60000000' then
        m7_ := '3456789';
      else
        m7_ := '9345678';
      end if;
      sum_ := 0;
      FOR i_ in 1..7
      LOOP
        sum_ := sum_ + to_number(substr(okpo_,i_,1))*to_number(substr(m7_,i_,1));
      END LOOP;
      kc_ := mod(sum_,11);
      if kc_ = 10 then
         kc_ := 0;
      end if;
    end if;
    if okpo_=substr(okpo_,1,7)||kc_ then
      return 0;
    else
      return -1;
    end if;
  elsif ln_=10 then
    if substr(okpo_,1,1) between '0' and '9' then
      s_ := s_ - to_number(substr(okpo_,1,1));
    else
      return -1;
    end if;
    if substr(okpo_,2,1) between '0' and '9' then
      s_ := s_ + to_number(substr(okpo_,2,1))*5;
    else
      return -1;
    end if;
    if substr(okpo_,3,1) between '0' and '9' then
      s_ := s_ + to_number(substr(okpo_,3,1))*7;
    else
      return -1;
    end if;
    if substr(okpo_,4,1) between '0' and '9' then
      s_ := s_ + to_number(substr(okpo_,4,1))*9;
    else
      return -1;
    end if;
    if substr(okpo_,5,1) between '0' and '9' then
      s_ := s_ + to_number(substr(okpo_,5,1))*4;
    else
      return -1;
    end if;
    if substr(okpo_,6,1) between '0' and '9' then
      s_ := s_ + to_number(substr(okpo_,6,1))*6;
    else
      return -1;
    end if;
    if substr(okpo_,7,1) between '0' and '9' then
      s_ := s_ + to_number(substr(okpo_,7,1))*10;
    else
      return -1;
    end if;
    if substr(okpo_,8,1) between '0' and '9' then
      s_ := s_ + to_number(substr(okpo_,8,1))*5;
    else
      return -1;
    end if;
    if substr(okpo_,9,1) between '0' and '9' then
      s_ := s_ + to_number(substr(okpo_,9,1))*7;
    else
      return -1;
    end if;
    if substr(okpo_,10,1) between '0' and '9' then
      if substr(to_char(s_-(11*trunc(s_/11))),-1)=substr(okpo_,10,1) then
        return 0;
      else
        return -1;
      end if;
    else
      return -1;
    end if;
  else
    return null;
  end if;
END f_validokpo;
/
 show err;
 
PROMPT *** Create  grants  F_VALIDOKPO ***
grant EXECUTE                                                                on F_VALIDOKPO     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_VALIDOKPO     to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_validokpo.sql =========*** End **
 PROMPT ===================================================================================== 
 