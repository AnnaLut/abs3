PROMPT *** Create  trigger TU_DPTFILEAGENCY ***

CREATE OR REPLACE TRIGGER BARS.TU_DPTFILEAGENCY 
before update of agency_id ON BARS.DPT_FILE_AGENCY
for each row
declare
  l_cnt number(38);
begin

  -- Якщо є оплачені документи - орган соц. захисту змінювати не можна
  select count(*)
    into l_cnt
    from DPT_FILE_ROW
   where HEADER_ID = :old.HEADER_ID
     and REF is not null;

  if ( l_cnt > 0 )
  then
    bars_error.raise_nerror( 'SOC', 'BF_IS_PAID', to_char(:old.HEADER_ID), to_char(:old.BRANCH) );
  else
    update DPT_FILE_ROW
       set AGENCY_ID   = :new.AGENCY_ID
         , AGENCY_NAME = ( select NAME from SOCIAL_AGENCY where AGENCY_ID = :new.AGENCY_ID )
     where HEADER_ID   = :old.HEADER_ID;
  end if;

end TU_DPTFILEAGENCY;
/

show errors;
