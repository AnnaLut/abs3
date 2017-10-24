

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/MIGR_CLONE_WEBUSER.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  procedure MIGR_CLONE_WEBUSER ***

  CREATE OR REPLACE PROCEDURE BARS.MIGR_CLONE_WEBUSER (
    l_userid      in  number,  /* id пользователя*/
    l_logname     in  varchar2,/* имя пользователя oracle*/
    l_branch      in  varchar2,/* отделение */
    l_tabn        in  varchar2,/* табельный номер (код ключа) */
    l_login       in  varchar2,/* логин в вебе  */
    l_fio         in  varchar2,/* описание пользователя */
    l_useretalon  in  varchar2,/*'имя эталонного пользователя, который клонируется;*/
    l_user_type number )
is
  p_userid     staff$base.id%type;
  l_count      number;
  l_idetalon   staff$base.id%type;
begin
  -- Проверка еталонного пользователя
  begin
    select id into l_idetalon from staff$base where logname=UPPER(l_useretalon);
  exception
    when NO_DATA_FOUND then
        raise_application_error(-20999, 'Не знайдено еталонного користувача '|| l_useretalon);
  end;

  -- Проверка уникальности logname
  begin
    select id into p_userid from staff$base where upper(logname)= upper(l_logname);
  exception
    when NO_DATA_FOUND then
    -- Создание пользователя
    bars_useradm.create_user(
              p_usrfio      => l_fio,
              p_usrtabn     => l_tabn,
              p_usrtype     => 0,
              p_usraccown   => 1,
              p_usrbranch   => l_branch,
              p_usrusearc   => 0,
              p_usrusegtw   => 0,
              p_usrwprof    => 'DEFAULT_PROFILE',
              p_reclogname  => l_logname,
              p_recpasswd   => 'qwerty',
              p_recappauth  => 'APPSERVER',
              p_recprof     => NULL,
              p_recdefrole  => 'BARS_CONNECT',
              p_recrsgrp    =>  NULL,
              p_usrid       => l_userid,
              p_tipid        =>  l_user_type
    );
    p_userid := l_userid;
  end;

 -- клонирование ресурсов
  bars_useradm.clone_user(l_idetalon,
                         p_userid,
                         bars_useradm.t_numberlist(1,2,3,4,5),
                         bars_useradm.t_numberlist(1,1,1,1,1),
                         bars_useradm.t_numberlist(0,0,0,0,0)
                         );
  -- подтверждение прав на ресурсы
  update staff$base set bax=1 where id=l_userid;
  update applist_staff set approve=1 where id=p_userid;
  update staff_tts set approve=1 where id=p_userid;
  update staff_chk set approve=1 where id=p_userid;
  update groups_staff set approve=1 where idu=p_userid;
  update staff_klf00 set approve=1 where id=p_userid;
  -- выдача прав по ресурсам
  begin
     bars_useradm.change_user_privs(p_userid);
     exception when others then null;
  end;
  -- создание веб-пользователя
  select count(webuser) into l_count from web_usermap where webuser=lower(l_login) and dbuser=upper(l_logname);
  if (l_count = 0) then
    begin
       insert into web_usermap(webuser,dbuser,webpass,errmode, comm, blocked, attempts)
       values(LOWER(l_login),UPPER(l_logname),'b1b3773a05c0ed0176787a4f1574ff0075f7521e',1,l_fio,0,0);
        exception when dup_val_on_index then null;
    end;
  end if;
end;
/
show err;

PROMPT *** Create  grants  MIGR_CLONE_WEBUSER ***
grant EXECUTE                                                                on MIGR_CLONE_WEBUSER to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/MIGR_CLONE_WEBUSER.sql =========**
PROMPT ===================================================================================== 
