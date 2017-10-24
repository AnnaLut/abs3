

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_DPTFILEAGENCY.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_DPTFILEAGENCY ***

  CREATE OR REPLACE TRIGGER BARS.TU_DPTFILEAGENCY 
before update of agency_id ON BARS.DPT_FILE_AGENCY for each row
declare
	l_cnt number(38);
begin
  -- Репликация: Если изменения пришли из удаленной БД, то ничего не делаем
  if (dbms_mview.i_am_a_refresh = true or dbms_reputil.from_remote = true) then
      return;
  end if;

  -- Якщо є оплачені документи - орган соц. захисту змінювати не можна
  select count(*)
  into l_cnt
  from dpt_file_row
  where header_id = :old.header_id and branch = :old.branch and ref is not null;

  if l_cnt > 0 then
	bars_error.raise_nerror('SOC', 'BF_IS_PAID',to_char(:old.header_id),to_char(:old.branch));
  end if;

  update dpt_file_row
  set agency_id = :new.agency_id,
   agency_name = (select name from social_agency where agency_id = :new.agency_id )
  where header_id = :old.header_id and branch = :old.branch;

end; 




/
ALTER TRIGGER BARS.TU_DPTFILEAGENCY ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_DPTFILEAGENCY.sql =========*** En
PROMPT ===================================================================================== 
