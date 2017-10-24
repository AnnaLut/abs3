

DOC 
###################################################################### 
###################################################################### 
    The following PL/SQL block will cause an ORA-20000 error and
    terminate the current SQLPLUS session if the user is not BARS. 
    Disconnect and reconnect as BARS. 
###################################################################### 
###################################################################### 
# 
declare
l_usrid number;
begin
 
 begin 
   select id into l_usrid from staff$base t where upper(t.logname) = 'TECH_TOMAS';
 exception when no_data_found then null;
 end;
 if l_usrid is null then
 bars_useradm.create_user(p_usrfio => 'Технічний користувач Томас', 
                           p_usrtabn => null, 
                           p_usrtype => 3, 
                           p_usraccown => 1, 
                           p_usrbranch => '/'||f_ourmfo_g||'/', 
                           p_usrusearc => 0, 
                           p_usrusegtw => 0, 
                           p_usrwprof => 'DEFAULT_PROFILE', 
                           p_reclogname => 'TECH_TOMAS', 
                           p_recpasswd => 'qwerty123', 
                           p_recappauth => null, 
                           p_recprof => null, 
                           p_recdefrole => null, 
                           p_recrsgrp => null); 
 else
 bars_useradm.alter_user(p_usrid => l_usrid, 
                        p_usrfio => 'Технічний користувач Томас', 
                        p_usrtabn => null, 
                        p_usrtype => 3, 
                        p_usraccown => 1, 
                        p_usrbranch => '/'||f_ourmfo_g||'/', 
                        p_usrusearc => 0, 
                        p_usrusegtw => 0, 
                        p_usrwprof => 'DEFAULT_PROFILE', 
                        p_recpasswd => 'qwerty123', 
                        p_recappauth => null, 
                        p_recprof => null, 
                        p_recdefrole => null, 
                        p_recrsgrp => null);
 end if;

  
  begin
    insert into groups_staff(idu,idg,secg,approve,grantor,sec_sel,sec_cre,sec_deb)
    select id, 6, 7, 1, 1, 1, 1, 1 from staff$base where logname = 'TECH_TOMAS';
  exception
    when dup_val_on_index then
      null;
  end;

  begin
    insert into web_usermap(webuser,dbuser,errmode,webpass,adminpass,comm,blocked,attempts)
    values('tech_tomas','TECH_TOMAS',1,'5cec175b165e3d5e62c9e13ce848ef6feac81bff',null,'Технічний користувач Томас',0,0);
      update web_usermap set chgdate = to_date('01.01.2020 00:00:00','dd.mm.yyyy hh24:mi:ss') where webuser = 'tech_tomas';
  exception
    when dup_val_on_index then
      null;
  end;

end;
/
update staff$base 
   set bax = 1, 
       tbax = sysdate, 
       chgpwd = 'N',
       can_select_branch = 'Y' 
 where logname = 'TECH_TOMAS';
/
commit;