
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/resource_usr.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.RESOURCE_USR is
    procedure on_resolve_user_role(
        p_activity_id in integer);

    procedure on_resolve_role_arm(
        p_activity_id in integer);

    procedure on_resolve_role_group(
        p_activity_id in integer);

    procedure on_resolve_role_chk(
        p_activity_id in integer);

    procedure on_resolve_role_tts(
        p_activity_id in integer);

    procedure on_resolve_role_klf(
        p_activity_id in integer);

    procedure on_resolve_arm_function(
        p_activity_id in integer);

    procedure on_resolve_arm_directory(
        p_activity_id in integer);

    procedure on_resolve_arm_report(
        p_activity_id in integer);

    procedure refresh_role_resources(
        p_role_id in integer,
        p_is_active in boolean);
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.RESOURCE_USR as

    function get_role_users(
        p_role_id in integer)
    return number_list
    is
        l_role_users number_list;
    begin
        select s.id
        bulk collect into l_role_users
        from   staff$base s
        where  s.id in (select column_value
                        from table(resource_utl.get_resource_grantees(
                                       p_role_id,
                                       resource_utl.get_resource_type_id('STAFF_ROLE'),
                                       resource_utl.get_resource_type_id('STAFF_USER')))) and
               s.active = 1;

        return l_role_users;
    end;

    procedure on_resolve_user_role_utl(
        p_user_id in integer,
        p_activity_user_id in integer,
        p_excluded_roles in number_list default null)
    is
        l_role_resource_type_id integer;
        l_web_arm_resource_type_id integer;
        l_centura_arm_resource_type_id integer;
        l_group_resource_type_id integer;
        l_chklist_resource_type_id integer;
        l_tts_resource_type_id integer;
        l_klf_resource_type_id integer;

        l_user_roles number_list;
    begin
        l_role_resource_type_id        := resource_utl.get_resource_type_id('STAFF_ROLE');
        l_web_arm_resource_type_id     := resource_utl.get_resource_type_id('ARM_WEB');
        l_centura_arm_resource_type_id := resource_utl.get_resource_type_id('ARM_CENTURA');
        l_group_resource_type_id       := resource_utl.get_resource_type_id('ACCOUNT_GROUP');
        l_chklist_resource_type_id     := resource_utl.get_resource_type_id('CHKLIST');
        l_tts_resource_type_id         := resource_utl.get_resource_type_id('TTS');
        l_klf_resource_type_id         := resource_utl.get_resource_type_id('KLF');

        delete applist_staff t
        where  t.id = p_user_id;

        delete groups_staff t
        where  t.idu = p_user_id;

        delete staff_chk t
        where  t.id = p_user_id;

        delete staff_tts t
        where  t.id = p_user_id;

        delete staff_klf00 t
        where  t.id = p_user_id;

        l_user_roles := user_utl.get_user_roles(p_user_id);
        if (p_excluded_roles is not null) then
            l_user_roles := l_user_roles multiset except p_excluded_roles;
        end if;

        -- TODO : unique resource
        insert into applist_staff
        select p_user_id,
               d.codeapp,
               1, null, null, null, null, 0,
               p_activity_user_id
        from   (select unique a.codeapp
                from   adm_resource t
                join   applist a on a.id = t.resource_id
                where  t.grantee_type_id = l_role_resource_type_id and
                       t.resource_type_id in (l_web_arm_resource_type_id, l_centura_arm_resource_type_id) and
                       t.grantee_id in (select column_value from table(l_user_roles)) and
                       t.access_mode_id <> 0) d;

        insert into groups_staff
        select p_user_id,
               d.id,
               d.aggregate_access_mode,
               1, null, null, null, null, 0,
               p_activity_user_id,
               bitand(d.aggregate_access_mode, 4)/4 sec_sel,
               bitand(d.aggregate_access_mode, 1) sec_cre,
               bitand(d.aggregate_access_mode, 2)/2 sec_deb
        from   (select g.id, tools.bitor_vector(cast(collect(t.access_mode_id) as number_list)) aggregate_access_mode
                from adm_resource t
                join groups g on g.id = t.resource_id
                where  t.grantee_type_id = l_role_resource_type_id and
                       t.resource_type_id in (l_group_resource_type_id) and
                       t.grantee_id in (select column_value from table(l_user_roles)) and
                       t.access_mode_id <> 0
                group by g.id) d;

        insert into staff_chk
        select p_user_id,
               d.idchk,
               1, null, null, null, null, 0,
               p_activity_user_id
        from   (select unique c.idchk
                from   adm_resource t
                join   chklist c on c.idchk = t.resource_id
                where  t.grantee_type_id = l_role_resource_type_id and
                       t.resource_type_id in (l_chklist_resource_type_id) and
                       t.grantee_id in (select column_value from table(l_user_roles)) and
                       t.access_mode_id <> 0) d;

        insert into staff_tts
        select d.tt,
               p_user_id,
               1, null, null, null, null, 0,
               p_activity_user_id
        from   (select unique tt.tt
                from adm_resource t
                join tts tt on tt.id = t.resource_id
                where  t.grantee_type_id = l_role_resource_type_id and
                       t.resource_type_id in (l_tts_resource_type_id) and
                       t.grantee_id in (select column_value from table(l_user_roles)) and
                       t.access_mode_id <> 0) d;

        insert into staff_klf00
        select p_user_id,
               d.kodf,
               d.a017,
               1, null, null, null, null, null, 0,
               p_activity_user_id
        from   (select unique k.kodf, k.a017
                from   adm_resource t
                join   kl_f00$global k on k.id = t.resource_id
                where  t.grantee_type_id = l_role_resource_type_id and
                       t.resource_type_id in (l_klf_resource_type_id) and
                       t.grantee_id in (select column_value from table(l_user_roles)) and
                       t.access_mode_id <> 0) d;
    end;

    procedure on_resolve_user_role(
        p_activity_id in integer)
    is
        l_activity_row adm_resource_activity%rowtype;
    begin
        l_activity_row := resource_utl.read_resource_activity(p_activity_id, p_lock => true);

        on_resolve_user_role_utl(l_activity_row.grantee_id, l_activity_row.action_user_id);
    end;

    procedure on_resolve_role_arm(
        p_activity_id in integer)
    is
        l_activity_row adm_resource_activity%rowtype;
        l_role_users number_list;
        l_codeapp varchar2(30 char);
    begin
        l_activity_row := resource_utl.read_resource_activity(p_activity_id, p_lock => true);

        if (l_activity_row.resolution_type_id = resource_utl.RESOLUTION_TYPE_APPROVE) then
            l_role_users := get_role_users(l_activity_row.grantee_id);
            l_codeapp := user_menu_utl.get_arm_code(l_activity_row.resource_id);

            if (l_codeapp is not null) then
                if (l_activity_row.access_mode_id = 0) then
                    delete applist_staff t
                    where  t.codeapp = l_codeapp and
                           t.id in (select column_value from table(l_role_users));
                else
                    insert into applist_staff
                    select t.column_value,
                           l_codeapp,
                           1, null, null, null, null, 0,
                           l_activity_row.action_user_id
                    from   table(l_role_users) t
                    where not exists (select 1
                                      from   applist_staff d
                                      where  d.id = t.column_value and
                                             d.codeapp = l_codeapp);
                end if;
            end if;
        end if;
    end;

    procedure on_resolve_role_group(
        p_activity_id in integer)
    is
        l_activity_row adm_resource_activity%rowtype;
        l_role_users number_list;
    begin
        l_activity_row := resource_utl.read_resource_activity(p_activity_id, p_lock => true);

        if (l_activity_row.resolution_type_id = resource_utl.RESOLUTION_TYPE_APPROVE) then
            l_role_users := get_role_users(l_activity_row.grantee_id);

            if (l_activity_row.access_mode_id = 0) then
                delete groups_staff t
                where  t.idg = l_activity_row.resource_id and
                       t.idu in (select column_value from table(l_role_users));
            else
                merge into groups_staff a
                using (select t.column_value idu,
                              g.id idg,
                              bitand(l_activity_row.access_mode_id, 4) / 4 sec_sel,
                              bitand(l_activity_row.access_mode_id, 1) sec_cre,
                              bitand(l_activity_row.access_mode_id, 2) / 2 sec_deb
                       from   table(l_role_users) t
                       join   groups g on g.id = l_activity_row.resource_id) s
                on (a.idu = s.idu and
                    a.idg = s.idg)
                when matched then update
                     set a.secg = l_activity_row.access_mode_id,
                         a.approve = 1,
                         a.adate1 = null,
                         a.adate2 = null,
                         a.rdate1 = null,
                         a.rdate2 = null,
                         a.revoked = 0,
                         a.grantor = l_activity_row.action_user_id,
                         a.sec_sel = s.sec_sel,
                         a.sec_cre = s.sec_cre,
                         a.sec_deb = s.sec_deb
                when not matched then insert
                     values (s.idu, s.idg, l_activity_row.access_mode_id, 1, null, null, null, null, 0,
                             l_activity_row.action_user_id, s.sec_sel, s.sec_cre, s.sec_deb);
            end if;
        end if;
    end;

    procedure on_resolve_role_chk(
        p_activity_id in integer)
    is
        l_activity_row adm_resource_activity%rowtype;
        l_role_users number_list;
    begin
        l_activity_row := resource_utl.read_resource_activity(p_activity_id, p_lock => true);

        if (l_activity_row.resolution_type_id = resource_utl.RESOLUTION_TYPE_APPROVE) then
            l_role_users := get_role_users(l_activity_row.grantee_id);

            if (l_activity_row.access_mode_id = 0) then
                delete staff_chk t
                where  t.chkid = l_activity_row.resource_id and
                       t.id in (select column_value from table(l_role_users));
            else
                insert into staff_chk
                select t.column_value,
                       c.idchk,
                       1, null, null, null, null, 0,
                       l_activity_row.action_user_id
                from   table(l_role_users) t
                join   chklist c on c.idchk = l_activity_row.resource_id
                where not exists (select 1
                                  from   staff_chk d
                                  where  d.id = t.column_value and
                                         d.chkid = l_activity_row.resource_id);
            end if;
        end if;
    end;

    procedure on_resolve_role_tts(
        p_activity_id in integer)
    is
        l_activity_row adm_resource_activity%rowtype;
        l_role_users number_list;
        l_tt varchar2(30 char);
    begin
        l_activity_row := resource_utl.read_resource_activity(p_activity_id, p_lock => true);

        if (l_activity_row.resolution_type_id = resource_utl.RESOLUTION_TYPE_APPROVE) then
            l_role_users := get_role_users(l_activity_row.grantee_id);

            begin
                select t.tt
                into   l_tt
                from   tts t
                where  t.id = l_activity_row.resource_id;
            exception
                when no_data_found then
                     null;
            end;

            if (l_tt is not null) then
                if (l_activity_row.access_mode_id = 0) then
                    delete staff_tts t
                    where  t.tt = l_tt and
                           t.id in (select column_value from table(l_role_users));
                else
                    insert into staff_tts
                    select l_tt,
                           t.column_value,
                           1, null, null, null, null, 0,
                           l_activity_row.action_user_id
                    from   table(l_role_users) t
                    where not exists (select 1
                                      from   staff_tts d
                                      where  d.id = t.column_value and
                                             d.tt = l_tt);

                end if;
            end if;
        end if;
    end;

    procedure on_resolve_role_klf(
        p_activity_id in integer)
    is
        l_activity_row adm_resource_activity%rowtype;
        l_role_users number_list;
        l_kodf varchar2(30 char);
        l_a017 varchar2(30 char);
    begin
        l_activity_row := resource_utl.read_resource_activity(p_activity_id, p_lock => true);

        if (l_activity_row.resolution_type_id = resource_utl.RESOLUTION_TYPE_APPROVE) then
            l_role_users := get_role_users(l_activity_row.grantee_id);

            begin
                select t.kodf, t.a017
                into   l_kodf, l_a017
                from   kl_f00$global t
                where  t.id = l_activity_row.resource_id;
            exception
                when no_data_found then
                     null;
            end;

            if (l_kodf is not null and l_a017 is not null) then
                if (l_activity_row.access_mode_id = 0) then
                    delete staff_klf00 t
                    where  t.kodf = l_kodf and
                           t.a017 = l_a017 and
                           t.id in (select column_value from table(l_role_users));
                else
                    insert into staff_klf00
                    select t.column_value,
                           l_kodf,
                           l_a017,
                           1, null, null, null, null, null, 0,
                           l_activity_row.action_user_id
                    from   table(l_role_users) t
                    where not exists (select 1
                                      from   staff_klf00 d
                                      where  d.id = t.column_value and
                                             d.kodf = l_kodf and
                                             d.a017 = l_a017);
                end if;
            end if;
        end if;
    end;

    procedure on_resolve_arm_function(
        p_activity_id in integer)
    is
        l_activity_row adm_resource_activity%rowtype;
        l_codeapp varchar2(30 char);
    begin
        l_activity_row := resource_utl.read_resource_activity(p_activity_id, p_lock => true);

        if (l_activity_row.resolution_type_id = resource_utl.RESOLUTION_TYPE_APPROVE) then

            l_codeapp := user_menu_utl.get_arm_code(l_activity_row.grantee_id);

            if (l_codeapp is not null) then
                if (l_activity_row.access_mode_id = 0) then
                    delete operapp t
                    where  t.codeoper = l_activity_row.resource_id and
                           t.codeapp = l_codeapp;
                else
                    insert into operapp
                    select l_codeapp, l_activity_row.resource_id, null,
                           1, null, null, null, null, null, 0,
                           l_activity_row.action_user_id
                    from operlist o
                    where o.codeoper = l_activity_row.resource_id and
                          not exists (select 1
                                      from   operapp d
                                      where  d.codeapp = l_codeapp and
                                             d.codeoper = o.codeoper);
                end if;
            end if;
        end if;
    end;

    procedure on_resolve_arm_directory(
        p_activity_id in integer)
    is
        l_activity_row adm_resource_activity%rowtype;
        l_codeapp varchar2(30 char);
    begin
        l_activity_row := resource_utl.read_resource_activity(p_activity_id, p_lock => true);

        if (l_activity_row.resolution_type_id = resource_utl.RESOLUTION_TYPE_APPROVE) then
            l_codeapp := user_menu_utl.get_arm_code(l_activity_row.grantee_id);

            if (l_codeapp is not null) then
                if (l_activity_row.access_mode_id = 0) then
                    delete refapp t
                    where  t.tabid = l_activity_row.resource_id and
                           t.codeapp = l_codeapp;
                else
                    merge into refapp a
                    using (select r.tabid from references r where r.tabid = l_activity_row.resource_id) s
                    on (a.codeapp = l_codeapp and a.tabid = s.tabid)
                    when matched then update
                         set a.acode = list_utl.get_item_code('DIRECTORY_ACCESS_MODE', l_activity_row.access_mode_id),
                             a.approve = 1,
                             a.adate1 = null,
                             a.adate2 = null,
                             a.rdate1 = null,
                             a.rdate2 = null,
                             a.reverse = null,
                             a.revoked = 0,
                             a.grantor = l_activity_row.action_user_id
                    when not matched then insert
                         values (s.tabid, l_codeapp, list_utl.get_item_code('DIRECTORY_ACCESS_MODE', l_activity_row.access_mode_id),
                                 1, null, null, null, null, null, 0,
                                 l_activity_row.action_user_id);
                end if;
            end if;
        end if;
    end;

    procedure on_resolve_arm_report(
        p_activity_id in integer)
    is
        l_activity_row adm_resource_activity%rowtype;
        l_codeapp varchar2(30 char);
    begin
        l_activity_row := resource_utl.read_resource_activity(p_activity_id, p_lock => true);

        if (l_activity_row.resolution_type_id = resource_utl.RESOLUTION_TYPE_APPROVE) then
            l_codeapp := user_menu_utl.get_arm_code(l_activity_row.grantee_id);

            if (l_codeapp is not null) then
                if (l_activity_row.access_mode_id = 0) then
                    delete app_rep t
                    where  t.coderep = l_activity_row.resource_id and
                           t.codeapp = l_codeapp;
                else
                    insert into app_rep
                    select l_codeapp, r.id,
                           1, null, null, null, null, null, 0,
                           l_activity_row.action_user_id, null
                    from reports r
                    where r.id = l_activity_row.resource_id and
                          not exists (select 1
                                      from   app_rep d
                                      where  d.codeapp = l_codeapp and
                                             d.coderep = r.id);
                end if;
            end if;
        end if;
    end;

    procedure refresh_role_resources(
        p_role_id in integer,
        p_is_active in boolean)
    is
        l_role_users number_list;
        l integer;
    begin
        l_role_users := get_role_users(p_role_id);

        if (l_role_users is not null and l_role_users is not empty) then
            l := l_role_users.first;
            while (l is not null) loop
                on_resolve_user_role_utl(l_role_users(l), user_id(), case when p_is_active then null else number_list(p_role_id) end);
                l := l_role_users.next(l);
            end loop;
        end if;
    end;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/resource_usr.sql =========*** End **
 PROMPT ===================================================================================== 
 