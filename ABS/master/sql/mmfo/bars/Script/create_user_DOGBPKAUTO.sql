declare
   l_res number;
begin
    begin
        begin 
           execute immediate 'drop user DOGBPKAUTO cascade';
        exception when others then null;
        end;    
        select 1 into l_res from bars.staff$base where logname = 'DOGBPKAUTO';
    exception
        when no_data_found then
            dbms_output.put_line('Нет пользователя staff$base - создаем');
            bars.bars_login.login_user(sys_guid, 1, null, null);
            bars.bars_useradm.create_user(p_usrfio     => 'Технич. для автовизы вертушка DOGBPK(договірні списання БПК)',
                           p_usrtabn    => '',
                           p_usrtype    => 0, -- Адміністратор
                           p_usraccown  => 0,
                           p_usrbranch  => '/',
                           p_usrusearc  => 0,
                           p_usrusegtw  => 0,
                           p_usrwprof   => 'DEFAULT_PROFILE',
                           p_reclogname => 'DOGBPKAUTO',
                           p_recpasswd  => 'dogbpkauto',
                           p_recappauth => null,
                           p_recprof    => null,
                           p_recdefrole => null,
                           p_recrsgrp   => null);
            commit;
    end;
end;
/


declare
  l_pass_sh1 varchar2(400);
begin
  l_pass_sh1 := lower(TO_CHAR(RAWTOHEX(DBMS_CRYPTO.HASH(UTL_RAW.CAST_TO_RAW('barsbars'),DBMS_CRYPTO.HASH_SH1))));
  insert into web_usermap(webuser,dbuser,errmode,webpass,adminpass,comm,blocked,attempts)
  values('dogbpkauto','DOGBPKAUTO',1,l_pass_sh1,null,'Технологический для авто подписи в вертушке DOGBPK (договірні списання БПК)',0,0);
  update web_usermap set chgdate = to_date('01.01.2030 00:00:00','dd.mm.yyyy hh24:mi:ss') where webuser = 'dogbpkauto';
  commit;
exception
  when dup_val_on_index then
    null;
end;
/

