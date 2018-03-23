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
    from dpt_file_row
   where header_id = :old.header_id and branch = :old.branch and ref is not null;

  if ( l_cnt > 0 )
  then
    bars_error.raise_nerror('SOC', 'BF_IS_PAID',to_char(:old.header_id),to_char(:old.branch));
  end if;

  update DPT_FILE_ROW
     set AGENCY_ID = :new.agency_id
       , AGENCY_NAME = (select name from social_agency where agency_id = :new.agency_id )
   where HEADER_ID = :old.header_id;

end TU_DPTFILEAGENCY;
/

show errors;
