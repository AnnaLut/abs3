
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_createheadlineex.sql =========***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CREATEHEADLINEEX (
                        sNumFile varchar2,  -- KODF из V_F00
                        sGCode varchar2,    -- A017 из V_F00
                        sNBUC  varchar2     -- из V_TMP_NBU
) return varchar2 is
------------------------------------------------------------------------------
-- VERSION: 02.11.2009
------------------------------------------------------------------------------
-- Функция для формирования подзаголовной строки файла отчетности           --
-- #R=MФО                                                                   --
------------------------------------------------------------------------------
    strLine_ varchar2(100);
    r_ KL_f00.r%type;
    sMFO_  varchar2(20):=trim(sNBUC);
begin
    if length(sMFO_) in (1, 14) then
        sMFO_ := sMFO_;
    end if;

    begin
        select r
        into r_
        from kl_f00
        where kodf=sNumFile and
              a017=sGCode and
              trim(branch) <> '/';
    exception
        when no_data_found then return null;
    end;

    strLine_ := '#' || r_ || '=';

    if length(sMFO_) = 14 then
        strLine_ := strLine_ || substr(sMFO_, 1, 2) ||  '=' || substr(sMFO_, 3);
    else
        strLine_ := strLine_ || sMFO_;
    end if;

    return strLine_;

end F_CREATEHEADLINEEX;
/
 show err;
 
PROMPT *** Create  grants  F_CREATEHEADLINEEX ***
grant EXECUTE                                                                on F_CREATEHEADLINEEX to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_createheadlineex.sql =========***
 PROMPT ===================================================================================== 
 