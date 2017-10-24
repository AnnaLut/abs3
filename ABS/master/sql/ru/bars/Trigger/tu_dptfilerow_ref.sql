

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_DPTFILEROW_REF.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_DPTFILEROW_REF ***

  CREATE OR REPLACE TRIGGER BARS.TU_DPTFILEROW_REF 
AFTER UPDATE OF ref
ON BARS.DPT_FILE_ROW
for each row
 WHEN (new.ref is not null) declare
  l_typid SOCIAL_AGENCY.TYPE_ID%TYPE;
  l_depid DPT_DEPOSIT.DEPOSIT_ID%TYPE;
begin
-- Вставка ознаки(дати) зарахування
-- на депозит коштів від ПФУ
  select TYPE_ID
    into l_typid
    from social_agency where AGENCY_ID=:new.agency_id;

  if (l_typid in (1,5,6)) then
    begin
      select DEPOSIT_ID
        into l_depid
        from dpt_deposit where acc = (select acc from opldok where ref=:new.ref and DK=1);
    exception
      when NO_DATA_FOUND then
        l_depid := null;
    end;

    if (l_depid is not null) then
      update DPT_DEPOSIT_DETAILS
         set DAT_TRANSFER_PF = gl.bd
       where DPT_ID = l_depid;

      -- якщо нічого не обновили
      if (sql%rowcount = 0) then
        insert into DPT_DEPOSIT_DETAILS
          ( DPT_ID, DAT_TRANSFER_PF )
        values
          ( l_depid, gl.bd );
      end if;

    end if;

  end if;

end;
/
ALTER TRIGGER BARS.TU_DPTFILEROW_REF ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_DPTFILEROW_REF.sql =========*** E
PROMPT ===================================================================================== 
