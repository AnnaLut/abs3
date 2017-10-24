-- запускаем под барсом
prompt ====================================
prompt Create user  ' ористувач GERCTEST'
prompt ====================================
declare 
l_count integer;
p_usrid_ staff$base.id%type;
begin
 for x in (select 'create web user ' as msg from dual 
           where not exists (select 1 from staff$base where logname = 'GERCTEST')) loop
     
 select (max(id)+1) into p_usrid_ from staff$base;
  
  bars_useradm.create_user(
        p_usrfio     => ' ористувач GERCTEST', 
        p_usrtabn    => null,
        p_usrtype    => 0,
        p_usraccown   => 0,
        p_usrbranch   => '/'||f_ourmfo_g||'/',
        p_usrusearc   => 0,
        p_usrusegtw   => 0,
        p_usrwprof    => 'DEFAULT_PROFILE',
        p_reclogname  => 'GERCTEST',
        p_recpasswd   => 'qwerty654',
        p_recappauth  => 'GERCTEST',
        p_recprof     => 'DEFAULTPROFILE',
        p_recdefrole  => 'BARS_ACCESS_DEFROLE',
        p_recrsgrp    => null,
        p_usrid       => p_usrid_,
        p_gtwpasswd   => 'qwerty654',
        p_canselectbranch => null,
        p_chgpwd      => null,
        p_tipid       => null );
        
    --чтоб открыть веб - пользовател€
    update staff$base
    set   BAX =1,
          TBAX = sysdate 
    where logname = 'GERCTEST';
  
    commit;   
         
    dbms_output.put_line('User GERCTEST was created.');
 end loop;   


begin
          
           select count(webuser) into l_count from bars.web_usermap where webuser=LOWER('GERCTEST');
           if (l_count = 0) then
                 begin
                insert into bars.web_usermap(webuser,dbuser,webpass,errmode, comm, blocked, attempts)
                 values(LOWER('GERCTEST'),'GERCTEST','b1b3773a05c0ed0176787a4f1574ff0075f7521e',1,' ористувач GERCTEST',0,0);
                    exception when dup_val_on_index then null;
                end;
           end if;    
        dbms_output.put_line('користувачу GERCTEST заведено веб ');
end;   
 


end; 
/


update web_usermap set webpass='b1b3773a05c0ed0176787a4f1574ff0075f7521e', adminpass=null, blocked=0, attempts=0 where DBUSER='GERCTEST';
/
commit;
 
update web_usermap set chgdate=null where DBUSER='GERCTEST';
/
commit;
/

 begin 
    insert into groups_staff (IDU, IDG, SECG, APPROVE, GRANTOR, SEC_SEL, SEC_CRE, SEC_DEB)
    select id, 1, 7, 1,1,1,1,1 from staff$base where logname = 'GERCTEST'
    union all
    select id, 4, 7, 1,1,1,1,1 from staff$base where logname = 'GERCTEST';
 exception when dup_val_on_index then null;
 end; 
/
commit;
/