

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/MIGR_CREATE_ALL.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure MIGR_CREATE_ALL ***

  CREATE OR REPLACE PROCEDURE BARS.MIGR_CREATE_ALL 
is
  l_userid     staff$base.id%type;
  l_logname    staff$base.logname%type;
  l_tabn       staff$base.tabn%type;
  l_branch3pos varchar2(3);
  l_num2pos    varchar2(4);
  l_pos1       number(3);
  l_pos2       number(3);
  l_login      web_usermap.webuser%type;
  l_usretalon  staff$base.logname%type;
begin
  select nvl(max(id),501) into l_userid from staff$base where id >= 500 and id <= 2000;

  for migr in
  (
        select tabn, logname weblogin, logname, fio, branch, user_type, rowid
        from migr_webusers
        where imported=0 or imported is null
    order by branch, tabn
  )
  loop
     begin
        l_userid := l_userid + 1;
        l_logname := '';

        begin
      select val into l_logname from params$global where par='KODRU';
        exception
        when NO_DATA_FOUND then
          raise_application_error(-20999, 'Не знайдено параметра KODRU в довіднику params$global');
      end;

        if(l_logname is null)
        then
          raise_application_error(-20999, 'Не заповнений  параметр KODRU в довіднику params$global - номер регіонального управління');
        end if;

        l_logname := 'U'||trim(to_char(to_number(l_logname), '00'))||'_';
        l_tabn := migr.tabn;

        if (length(migr.tabn) = 8)
        then
           l_tabn := substr(migr.tabn,3);
        end if;

        -- 3 позиции из номера отделения
        l_branch3pos := substr(migr.branch,-4,3);
        l_logname := l_logname || l_branch3pos;

        -- ищем порядковый номер в пределах отделения
        select count(id)+1 into l_pos1 from staff$base where logname like l_logname||'%';

        select max(to_number(substr(logname,9,2)))+1 into l_pos2 from staff$base where logname like l_logname||'%' and substr(logname,9,1) !='S';

        if(l_pos2 >= l_pos1) then
            l_pos1 := l_pos2;
        end if;

        l_num2pos := trim(to_char(l_pos1, substr('0000',1,length(l_pos1))));
        -- если все таки такой есть, то берем следующий номер

        -- Генерим имя типа U03+[3 последних символа бранча] + [номер по порядку по отделению]
        l_logname := l_logname || '_' || l_num2pos;

        -- Определяем еталонного пользователя
        select logname into l_usretalon from migr_user_types where type_id=migr.user_type;

        l_login := lower(l_logname);

        if (migr.logname is not null)
        then
            l_logname := upper(migr.logname);
            l_login := lower(l_logname);
        end if;

        if (migr.weblogin is not null)
        then
            l_login := lower(migr.weblogin);
        end if;

        migr_clone_webuser(l_userid, l_logname, migr.branch, l_tabn, l_login, migr.fio, l_usretalon, migr.user_type);

        update migr_webusers set imported=1, id=l_userid, logname=l_logname, weblogin=l_login where rowid=migr.rowid;

        logger.INFO('MIGR: Cтворено користувача '|| l_logname || '('|| migr.fio || ')' || ', код-' ||l_userid || ', відділення ' || migr.branch||',login='||l_login||'.');
     end;
     end loop;
  commit;
end;
/
show err;

PROMPT *** Create  grants  MIGR_CREATE_ALL ***
grant EXECUTE                                                                on MIGR_CREATE_ALL to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/MIGR_CREATE_ALL.sql =========*** E
PROMPT ===================================================================================== 
