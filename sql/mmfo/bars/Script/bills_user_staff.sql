prompt Создаем технологического пользователя BILLS в staff$base
declare
l_username varchar2(32);
begin
    insert into staff$base (ID, FIO, LOGNAME, TYPE, TABN, BAX, TBAX, DISABLE, ADATE1, ADATE2, RDATE1, RDATE2, CLSID, APPROVE, BRANCH, COUNTCONN, COUNTPASS, PROFILE, USEARC, CSCHEMA, WEB_PROFILE, POLICY_GROUP, ACTIVE, CREATED, EXPIRED, CHKSUM, USEGTW, BLK, TBLK, TEMPL_ID, CAN_SELECT_BRANCH, CHGPWD, TIP, CURRENT_BRANCH)
    values (s_staff.nextval, 'Технологічний користувач BILLS', 'BILLS', 0, null, null, null, 0, null, null, null, null, 0, 1, '/', null, null, null, 0, 'BILLS', 'DEFAULT_PROFILE', 'WHOLE', 1, to_date('24-04-2018', 'dd-mm-yyyy'), null, null, 0, null, null, 1, null, 'N', null, null);
exception
    when dup_val_on_index then
        select username into l_username from all_users where username = 'BILLS';
        if l_username is not null then
            dbms_output.put_line('Пользователь BILLS уже существует');
        end if;
end;
/