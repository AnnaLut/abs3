

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Trigger/TBIU_UPLPARAMS_CHECK.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_UPLPARAMS_CHECK ***

  CREATE OR REPLACE TRIGGER BARSUPL.TBIU_UPLPARAMS_CHECK 
before insert or update
of VALUE
on BARSUPL.UPL_PARAMS
for each row
 WHEN ( NEW.PARAM = 'RELEASE' ) declare
  l_rec           UPL_RELEASES%rowtype;
  l_prv_rel_num   UPL_RELEASES.RELEASE_NUMBER%type;
begin

  l_prv_rel_num        := to_number(SubStr(:old.VALUE,1,4),'99.9');

  l_rec.DESCRIPTION    := SubStr(:new.VALUE,1,250);
  l_rec.RELEASE_NUMBER := to_number(SubStr(:new.VALUE,1,4),'99.9');
  l_rec.RELEASE_DATE   := to_date(SubStr(:new.VALUE,6,10),'dd/mm/yyyy');
  l_rec.CHANGE_DATE    := sysdate;
  l_rec.KF             := :new.KF;

  if ( trunc(l_rec.RELEASE_NUMBER) < trunc(l_prv_rel_num) )
  then -- якщо встановлюється оновлення "страрішої" весрсії ніж уже встановлена
    raise_application_error( -20666,'\ UPL: Заборонена інсталяція "страрішої" весрсії ніж поточна (' || to_char(l_prv_rel_num) || ')!', TRUE );
  end if;

  --
  update UPL_RELEASES
     set EXPIRY_DATE = trunc(sysdate)
   where EXPIRY_DATE Is Null
     and RELEASE_NUMBER < l_rec.RELEASE_NUMBER;

  begin
    insert into UPL_RELEASES
    values l_rec;
  exception
    when DUP_VAL_ON_INDEX then
      update UPL_RELEASES
         set ROW = l_rec
       where RELEASE_NUMBER = l_rec.RELEASE_NUMBER;
  end;

end TBIU_UPLPARAMS_CHECK;
/
ALTER TRIGGER BARSUPL.TBIU_UPLPARAMS_CHECK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Trigger/TBIU_UPLPARAMS_CHECK.sql ========
PROMPT ===================================================================================== 
