declare
   l_res number;
begin
    begin
        select 1 into l_res from bars.staff$base where logname = 'CORP2AUTO';
    exception
        when no_data_found then
            dbms_output.put_line('Нет пользователя staff$base - создаем');
            bars.bars_login.login_user(sys_guid, 1, null, null);
            bars.bars_useradm.create_user(p_usrfio     => 'Технологический для подписи в вертушке СДО(CORP2)',
                           p_usrtabn    => '',
                           p_usrtype    => 0, -- Адміністратор
                           p_usraccown  => 0,
                           p_usrbranch  => '/',
                           p_usrusearc  => 0,
                           p_usrusegtw  => 0,
                           p_usrwprof   => 'DEFAULT_PROFILE',
                           p_reclogname => 'CORP2AUTO',
                           p_recpasswd  => 'corp2auto',
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
  values('corp2auto','CORP2AUTO',1,l_pass_sh1,null,'Технологический для подписи в вертушке СДО(CORP2)',0,0);

  update web_usermap set chgdate = to_date('01.01.2030 00:00:00','dd.mm.yyyy hh24:mi:ss') where webuser = 'corp2auto';
  
  commit;
exception
  when dup_val_on_index then
    null;
end;
/

