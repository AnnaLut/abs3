
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_mon_null.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_MON_NULL 
 (kod_  bank_mon.kod%type,
  type_  bank_mon.type%type,
  kol_ varchar2,
  p_branch branch.branch%type default sys_context('bars_context','user_branch')
  )

  return varchar2
  result_cache

is

 Branch_ Branch.Branch%type := p_branch;
 Lng_    int;

begin

 Lng_    := length(Branch_);

 FOR i in (select dk I from dk order by 1)
 loop
   Branch_ := substr(Branch_, 1, Lng_ - i.I*7);


      for k in    (SELECT *
                        FROM BANK_MON
                      WHERE     TYPE = type_
                          AND      kod   = kod_
                          AND      branch = branch_ )
      loop
            if kol_= 'NAME_MON' then return k.NAME_MON;
        elsif kol_= 'CENA_NBU_OTP' then return k.CENA_NBU_OTP/100;
        elsif kol_= 'CENA_NBU' then return k.CENA_NBU/100;
        elsif kol_= 'NOM_MON' then return k.NOM_MON/100;
		elsif kol_= 'RAZR' then return k.RAZR;
		elsif kol_= 'CASE' then return k."CASE";
        end if;

      end loop;

   If length(Branch_) <=8 then  return null; end if;
 end loop;
 -----------------
 return null;

end f_mon_null;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_mon_null.sql =========*** End ***
 PROMPT ===================================================================================== 
 