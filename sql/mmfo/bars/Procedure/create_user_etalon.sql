

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CREATE_USER_ETALON.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CREATE_USER_ETALON ***

  CREATE OR REPLACE PROCEDURE BARS.CREATE_USER_ETALON (
    l_branch    in  varchar2,/* отделение */ 
    l_usermask  in  varchar2,/* начала имени пользователя oracle */
    l_usertype  in  varchar2,/* маска OP-оперционист, CA-кассир, CH-контроллер,или другой */ 
    l_loginmask in  varchar2,/* oper, cash, cont */
    l_username  in  varchar2,/* описание пользователя */
    useretalon  in  varchar2)/*'имя эталонного пользователя, который клонируется;*/
is
  l_logname    staff$base.logname%type;
  l_tabn       staff$base.tabn%type;
  l_count      number;
  l_usrid      staff$base.id%type;
  l_usretalon  staff$base.id%type;
  l_id         staff$base.id%type;
  l_login      web_usermap.webuser%type;
begin
  select max(id) into l_usrid from staff$base where id >= 10000 and id <= 20000;
  select id into l_usretalon from staff$base where logname=UPPER(useretalon);
  
  for k in ( select branch from branch where branch like l_branch||'%' and branch <> l_branch)
  loop
     begin
          -- Вставка в staff$base
         l_tabn := calc_tabn(l_usertype,k.branch);    
         l_usrid := l_usrid + 1;
         l_logname := l_usermask || 'W' || l_usertype || '_' || l_usrid;
        begin
          select id into l_id from staff$base where upper(logname)= upper(l_logname);  
        exception when no_data_found then 
           bars_useradm.create_user(
                      p_usrfio      => l_username||'('|| k.branch || ')',
                      p_usrtabn     => l_tabn,
                      p_usrtype     => 0,
                      p_usraccown   => 1,
                      p_usrbranch   => k.branch,
                      p_usrusearc   => 0,
                      p_usrusegtw   => 0,
                      p_usrwprof    => 'DEFAULT_PROFILE',
                      p_reclogname  => l_logname,
                      p_recpasswd   => 'qwerty',
                      p_recappauth  => 'APPSERVER',
                      p_recprof     => NULL,
                      p_recdefrole  => 'BARS_CONNECT',
                      p_recrsgrp    =>  NULL,
                      p_usrid         => l_usrid
          );    
         end;
         bars_useradm.clone_user(l_usretalon,
                                 l_usrid,
                                 bars_useradm.t_numberlist(1,2,3,4,5),
                                 bars_useradm.t_numberlist(1,1,1,1,1),
                                 bars_useradm.t_numberlist(0,0,0,0,0)                           
                                 );
        update applist_staff set approve=1 where id=l_usrid;
        update staff_tts set approve=1 where id=l_usrid;
        update staff_chk set approve=1 where id=l_usrid;
        update groups_staff set approve=1 where idu=l_usrid;
        update staff_klf00 set approve=1 where id=l_usrid;
        begin
            bars_useradm.change_user_privs(l_usrid);
            exception when others then null;
        end;                         
        l_login := l_loginmask || substr(k.branch, -4, 3); 
        select count(webuser) into l_count from web_usermap where webuser=LOWER(l_login);
        if (l_count = 0) then
        begin
           insert into web_usermap(webuser,dbuser,webpass,errmode, comm, blocked, attempts)
           values(LOWER(l_login),UPPER(l_logname),'b1b3773a05c0ed0176787a4f1574ff0075f7521e',1,l_username||'('|| k.branch || ')',0,0);
            exception when dup_val_on_index then null;
        end;
        end if;    
     end;
     end loop;
  commit;
end; 
 
/
show err;

PROMPT *** Create  grants  CREATE_USER_ETALON ***
grant EXECUTE                                                                on CREATE_USER_ETALON to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CREATE_USER_ETALON.sql =========**
PROMPT ===================================================================================== 
