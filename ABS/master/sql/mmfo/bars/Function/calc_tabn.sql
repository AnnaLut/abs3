
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/calc_tabn.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CALC_TABN (mask_ varchar2, branch_ varchar2) return varchar2 is
 tabn_   varchar2(8);
 begin
    tabn_ := '28YYIB';
    case 
        when mask_='OP' then tabn_ := tabn_ || '10'; 
        when mask_='CA' then tabn_ := tabn_ || '11';
        when mask_='CH' then tabn_ := tabn_ || '12';
        else tabn_ := tabn_ + '13';
    end case;
    return tabn_;
end; 
 
/
 show err;
 
PROMPT *** Create  grants  CALC_TABN ***
grant EXECUTE                                                                on CALC_TABN       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/calc_tabn.sql =========*** End *** 
 PROMPT ===================================================================================== 
 