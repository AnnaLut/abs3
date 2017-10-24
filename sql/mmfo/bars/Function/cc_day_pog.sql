
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/cc_day_pog.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CC_DAY_POG (FDAT_ date,DAY_ number) return DATE is
 DS_ varchar2(4);
begin
 if day_<10 then
           return to_date('0'||to_char(DAY_)||to_char(FDAT_,'MMYYYY'),'ddmmyyyy');

 elsif day_>=28 then
        DS_:=to_char(FDAT_,'mm')||to_char(DAY_);

    If DS_ in ('0229','0230','0231')
       and trunc(to_number(to_char(fdat_,'yyyy'))/4)!=to_number(to_char(fdat_,'yyyy'))/4
       then
            return to_date('0228'||to_char(FDAT_,'yyyy'),'mmddyyyy');
    elsif  DS_ in ('0229','0230','0231')
           and trunc(to_number(to_char(fdat_,'yyyy'))/4)=to_number(to_char(fdat_,'yyyy'))/4
           then
                return to_date('0229'||to_char(FDAT_,'yyyy'),'mmddyyyy');
    elsIf DS_ in ('0431','0631','0931','1131')
          then
               return to_date(substr(DS_,1,3)||'0'||to_char(FDAT_,'yyyy'),'mmddyyyy');
    end if;

 end if;
return to_date(to_char(DAY_)||to_char(FDAT_,'MMYYYY'),'ddmmyyyy');

end CC_DAY_POG;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/cc_day_pog.sql =========*** End ***
 PROMPT ===================================================================================== 
 