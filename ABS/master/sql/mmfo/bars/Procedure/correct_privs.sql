

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CORRECT_PRIVS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CORRECT_PRIVS ***

  CREATE OR REPLACE PROCEDURE BARS.CORRECT_PRIVS is
--        fOut            utl_file.file_type;
        cursor_id       integer;
        rows            integer;
        user_name       varchar2 (30);
        role_name       varchar2 (30);
        grant_str       varchar2 (100);
        err             exception;
        cursor user_crs is
        select
                rtrim (ltrim (logname))
        from
                staff
        where
                rtrim (ltrim (logname)) <> 'BARS' and
                rtrim (ltrim (logname)) in (
                        select
                                rtrim (ltrim (username))
                        from
                                sys.dba_users);
        cursor role_to_grant_crs is
                select
                        upper (ltrim (rtrim (ol.rolename)))
                from
                        operlist ol,
                        operapp oa,
                        applist al,
                        applist_staff als,
                        staff s
                where
                        ol.codeoper = oa.codeoper and
                        oa.codeapp  = al.codeapp  and
                        al.codeapp = als.codeapp  and
                        als.id = s.id             and
                        ol.rolename is not null   and
                        s.logname = user_name      and
                        upper (ltrim (rtrim (ol.rolename))) not in (
                select
                        upper (ltrim (rtrim (granted_role)))
                from
                        dba_role_privs
                where
                        grantee = user_name
                )
                UNION
                select
                        upper (ltrim (rtrim (r.role2edit)))
                from
                        references r,
                        refapp ra,
                        applist al,
                        applist_staff als,
                        staff s
                where
                        r.tabid = ra.tabid and
                        ra.codeapp  = al.codeapp  and
                        al.codeapp = als.codeapp  and
                        als.id = s.id             and
                        r.role2edit is not null   and
                        s.logname = user_name      and
                        upper (ltrim (rtrim (r.role2edit))) not in (
                select
                        upper (ltrim (rtrim (granted_role)))
                from
                        dba_role_privs
                where
                        grantee = user_name
                );
        cursor  role_to_revoke_crs is
                select
                        upper (ltrim (rtrim (granted_role)))
                from
                        dba_role_privs
                where
                        grantee = user_name and
                        upper (ltrim (rtrim (granted_role))) not in (
                        'START1',
			'AQ_ADMINISTRATOR_ROLE',
			'AQ_USER_ROLE',
			'CONNECT',
			'DBA',
			'DELETE_CATALOG_ROLE',
			'EXECUTE_CATALOG_ROLE',
			'EXP_FULL_DATABASE',
			'IMP_FULL_DATABASE',
			'RECOVERY_CATALOG_OWNER',
			'RESOURCE',
			'SELECT_CATALOG_ROLE',
			'SNMPAGENT'
			) and
                        upper (ltrim (rtrim (granted_role))) not in (
                select
                        upper (ltrim (rtrim (ol.rolename)))
                from
                        operlist ol,
                        operapp oa,
                        applist al,
                        applist_staff als,
                        staff s
                where
                        ol.codeoper = oa.codeoper and
                        oa.codeapp  = al.codeapp  and
                        al.codeapp = als.codeapp  and
                        als.id = s.id             and
                        upper (ltrim (rtrim (ol.rolename))) is not null   and
                        s.logname = user_name
                UNION
                select
                        upper (ltrim (rtrim (r.role2edit)))
                from
                        references r,
                        refapp ra,
                        applist al,
                        applist_staff als,
                        staff s
                where
                        r.tabid = ra.tabid and
                        ra.codeapp  = al.codeapp  and
                        al.codeapp = als.codeapp  and
                        als.id = s.id             and
                        upper (ltrim (rtrim (r.role2edit))) is not null   and
                        s.logname = user_name
                );
begin
--        fOut := utl_file.fopen ('../sql','test.lst','w');
        open user_crs;
        loop
                fetch user_crs into user_name;
                exit when user_crs%notfound;
                open role_to_revoke_crs;
                loop
                        grant_str := '';
                        fetch role_to_revoke_crs into role_name;
                        exit when role_to_revoke_crs%notfound;
                        grant_str := 'revoke '|| role_name || ' from ' || user_name;
--                        utl_file.put_line (fOut, grant_str);
                        cursor_id := dbms_sql.open_cursor;
                        dbms_sql.parse (cursor_id, grant_str, dbms_sql.NATIVE);
                        rows := dbms_sql.execute (cursor_id);
                        dbms_sql.close_cursor (cursor_id);
                end loop;
                close role_to_revoke_crs;
                open role_to_grant_crs;
                loop
                        grant_str := '';
                        fetch role_to_grant_crs into role_name;
                        exit when role_to_grant_crs%notfound;
                        grant_str := 'grant '|| role_name || ' to ' || user_name;
--                        utl_file.put_line (fOut, grant_str);
                        cursor_id := dbms_sql.open_cursor;
                        dbms_sql.parse (cursor_id, grant_str, dbms_SQL.V7);
                        rows := dbms_sql.execute (cursor_id);
                        dbms_sql.close_cursor (cursor_id);
                end loop;
                close role_to_grant_crs;
        end loop;
--        utl_file.fclose (fOut);
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CORRECT_PRIVS.sql =========*** End
PROMPT ===================================================================================== 
