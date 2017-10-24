declare
    l_user_ligin varchar2(28) := 'CORP_LIGHT_SYSTEM_USER';
    l_is_user_exist number := 0;
begin
    select count(0) into l_is_user_exist from staff$base where logname = l_user_ligin;
    if (l_is_user_exist = 0) then
        -- Call the procedure
        bars_useradm.create_user(
                            p_usrfio => 'CorpLight System User',
                            p_usrtabn => '',
                            p_usrtype => 3, -- Адміністратор
                            p_usraccown => 0,
                            p_usrbranch => '/',
                            p_usrusearc => 0,
                            p_usrusegtw => 0,
                            p_usrwprof => 'DEFAULT_PROFILE',
                            p_reclogname => l_user_ligin,
                            p_recpasswd => 'qwerty',
                            p_recappauth => null,
                            p_recprof => null,
                            p_recdefrole => null,
                            p_recrsgrp => null);
    end if;
end;
/
 