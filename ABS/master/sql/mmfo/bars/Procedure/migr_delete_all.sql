

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/MIGR_DELETE_ALL.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure MIGR_DELETE_ALL ***

  CREATE OR REPLACE PROCEDURE BARS.MIGR_DELETE_ALL 
is
begin
  for migr in (select * from migr_webusers where imported=1)
  loop
     begin
        delete from sec_audit where rec_uid=migr.id;
        delete from sec_user_io where id=migr.id;
        migr_drop_webuser(migr.id);
        update migr_webusers set imported=0, id=null, logname=null, weblogin=null where id=migr.id;
        logger.INFO('MIGR: Видалено користувача '||migr.logname || '('|| migr.fio || ')' || ', код-' ||migr.id || ', відділення ' || migr.branch||'.');
     end;
  end loop;
end;
 
/
show err;

PROMPT *** Create  grants  MIGR_DELETE_ALL ***
grant EXECUTE                                                                on MIGR_DELETE_ALL to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/MIGR_DELETE_ALL.sql =========*** E
PROMPT ===================================================================================== 
