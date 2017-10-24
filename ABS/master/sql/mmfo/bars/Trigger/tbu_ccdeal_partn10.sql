

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_CCDEAL_PARTN10.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_CCDEAL_PARTN10 ***

  CREATE OR REPLACE TRIGGER BARS.TBU_CCDEAL_PARTN10 before update of sos ON BARS.CC_DEAL
for each row
   WHEN (
old.sos <10 and new.sos = 10
      ) declare
 l_partn_txt  nd_txt.txt%type;
 l_par_txt nd_txt.txt%type;
    begin
        select txt into l_partn_txt from nd_txt where nd = :new.nd and tag = 'PARTN';

        if l_partn_txt = 'Так'  then
            begin
                select txt into l_par_txt from nd_txt where nd = :new.nd and tag = 'PAR_N';

                exception
                when no_data_found then
                bars_error.raise_nerror('CCK', 'NOT_PARAM_PARTNER_ID');
                end;
         else null;

        end if;
        exception
        when no_data_found then null;
end tbu_ccdeal_partn10;


/
ALTER TRIGGER BARS.TBU_CCDEAL_PARTN10 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_CCDEAL_PARTN10.sql =========*** 
PROMPT ===================================================================================== 
