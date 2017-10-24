

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_DPTFILEROW.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_DPTFILEROW ***

  CREATE OR REPLACE TRIGGER BARS.TU_DPTFILEROW 
before update of branch ON BARS.DPT_FILE_ROW for each row
declare
    l_modcode                 constant varchar2(3) := 'SOC';
    l_noagencyfound           constant err_codes.err_name%type := 'AGENCY_BRANCH_NOT_FOUND';
	l_agency_id 		social_agency.agency_id%type;
	l_agency_name 		social_agency.name%type;
	l_recheck_agency 	dpt_file_header.recheck_agency%type;
    l_agency_type       dpt_file_header.agency_type%type;
begin
  -- Репликация: Если изменения пришли из удаленной БД, то ничего не делаем
  if (dbms_mview.i_am_a_refresh = true or dbms_reputil.from_remote = true) then
      return;
  end if;

  select recheck_agency
  into l_recheck_agency
  from dpt_file_header
  where header_id = :old.header_id;

  if (l_recheck_agency = 1)
  then
	  BEGIN
		  -- Якщо є оплачені документи - орган соц. захисту змінювати не можна
		  select v.agency_id, v.agency_name
		  into l_agency_id, l_agency_name
		  from dpt_file_agency f, v_socialagencies_ext v
		  where f.header_id = :old.header_id and f.branch = :new.branch and v.agency_id = f.agency_id;

		  -- Такий бранч вже заведений  - проставляємо орган соц. захисту лише для нього
		  :new.agency_id := l_agency_id;
		  :new.agency_name := l_agency_name;

	  EXCEPTION WHEN NO_DATA_FOUND THEN
		-- Немає такого
        select agency_type
        into l_agency_type
        from dpt_file_header
        where header_id = :old.header_id;

        begin
            select agency_id, agency_name
            into l_agency_id, l_agency_name
            from v_socialagencies_ext s
            where s.agency_branch = :new.branch and
                s.agency_type = l_agency_type and rownum = 1;

            INSERT INTO DPT_FILE_AGENCY(HEADER_ID, BRANCH, AGENCY_ID)
            values (:old.header_id, :new.branch, l_agency_id);

            :new.agency_id := l_agency_id;
            :new.agency_name := l_agency_name;
        exception when no_data_found then
            bars_error.raise_nerror(l_modcode, l_noagencyfound, :new.branch, l_agency_type);
        end;

	  END;
  end if;

end;




/
ALTER TRIGGER BARS.TU_DPTFILEROW ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_DPTFILEROW.sql =========*** End *
PROMPT ===================================================================================== 
