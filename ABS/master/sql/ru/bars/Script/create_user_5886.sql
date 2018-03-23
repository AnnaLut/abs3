begin 
begin
  bars_useradm.create_user(p_usrfio => 'Технічний користува SW', 
                           p_usrtabn => null, 
                           p_usrtype => 3, 
                           p_usraccown => 1, 
                           p_usrbranch => '/', 
                           p_usrusearc => 0, 
                           p_usrusegtw => 0, 
                           p_usrwprof => 'DEFAULT_PROFILE', 
                           p_reclogname => 'TECH_SW', 
                           p_recpasswd => 'tech_sw', 
                           p_recappauth => null, 
                           p_recprof => null, 
                           p_recdefrole => null, 
                           p_recrsgrp => null);
exception when others then
if sqlcode=-01920 then
null;
end if;
end;
 
/*  begin
    insert into groups_staff(idu,idg,secg,approve,grantor,sec_sel,sec_cre,sec_deb)
    select id, 1003, 7, 1, 1, 1, 1, 1 from staff$base where logname = 'TECH_SW';
  exception
    when dup_val_on_index then
      null;
  end;*/
  declare
    l_pass_sh1 varchar2(400);
  begin
    l_pass_sh1 := lower(TO_CHAR(RAWTOHEX(DBMS_CRYPTO.HASH(UTL_RAW.CAST_TO_RAW('barsbars'),DBMS_CRYPTO.HASH_SH1))));
    insert into web_usermap(webuser,dbuser,errmode,webpass,adminpass,comm,blocked,attempts)
    values('tech_sw','TECH_SW',1,l_pass_sh1,null,'Технічний користувач SW',0,0);
  
    update web_usermap set chgdate = to_date('01.01.2030 00:00:00','dd.mm.yyyy hh24:mi:ss') where webuser = 'TECH_SW';
  exception
    when dup_val_on_index then
      null;
  end;
  

update staff$base 
   set bax = 1, 
       tbax = sysdate, 
       chgpwd = 'N',
       can_select_branch = 'Y' 
 where logname = 'TECH_SW';


end;
/
commit;

grant bars_connect to TECH_SW;