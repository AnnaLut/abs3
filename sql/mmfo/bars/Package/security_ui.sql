
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/security_ui.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.SECURITY_UI is

    procedure approve_resource_access(
        p_activity_id in integer,
        p_approvement_comment in varchar2);

    procedure approve_resource_access(
        p_activities_list in number_list,
        p_approvement_comment in varchar2);

    procedure reject_resource_access(
        p_activity_id in integer,
        p_rejection_comment in varchar2);

    procedure reject_resource_access(
        p_activities_list in number_list,
        p_rejection_comment in varchar2);

end;
/
CREATE OR REPLACE PACKAGE BODY BARS.SECURITY_UI as

    procedure approve_resource_access(
        p_activity_id in integer,
        p_approvement_comment in varchar2)
    is
    begin
        resource_utl.approve_resource_access(p_activity_id, p_approvement_comment);
    end;

    procedure approve_resource_access(
        p_activities_list in number_list,
        p_approvement_comment in varchar2)
    is
        type t_resource_activities is table of adm_resource_activity%rowtype;
        l_resource_activities t_resource_activities;
        l integer;
    begin
        bars_audit.debug('security_ui.approve_resource_access' || chr(10) ||
                         'p_activities_list     : ' || tools.number_list_to_string(p_activities_list) || chr(10) ||
                         'p_approvement_comment : ' || p_approvement_comment);

        select a.*
        bulk collect into l_resource_activities
        from   adm_resource_activity a
        where  a.id in (select column_value from table(p_activities_list))
        for update wait 60;

        l := l_resource_activities.first;
        while (l is not null) loop
            resource_utl.approve_resource_access(l_resource_activities(l), p_approvement_comment);
            l := l_resource_activities.next(l);
        end loop;
    exception
        when others then
             rollback;
             bars_audit.error('security_ui.approve_resource_access' || chr(10) ||
                              sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
             raise;
    end;

    procedure reject_resource_access(
        p_activity_id in integer,
        p_rejection_comment in varchar2)
    is
    begin
        resource_utl.reject_resource_access(p_activity_id, p_rejection_comment);
    end;

    procedure reject_resource_access(
        p_activities_list in number_list,
        p_rejection_comment in varchar2)
    is
        type t_resource_activities is table of adm_resource_activity%rowtype;
        l_resource_activities t_resource_activities;
        l integer;
    begin
        bars_audit.debug('security_ui.reject_resource_access' || chr(10) ||
                         'p_activities_list   : ' || tools.number_list_to_string(p_activities_list) || chr(10) ||
                         'p_rejection_comment : ' || p_rejection_comment);

        select a.*
        bulk collect into l_resource_activities
        from   adm_resource_activity a
        where  a.id in (select column_value from table(p_activities_list))
        for update wait 60;

        l := l_resource_activities.first;
        while (l is not null) loop
            resource_utl.reject_resource_access(l_resource_activities(l), p_rejection_comment);
            l := l_resource_activities.next(l);
        end loop;
    exception
        when others then
             rollback;
             bars_audit.error('security_ui.reject_resource_access' || chr(10) ||
                              sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
             raise;
    end;

end;
/
 show err;
 
PROMPT *** Create  grants  SECURITY_UI ***
grant EXECUTE                                                                on SECURITY_UI     to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/security_ui.sql =========*** End ***
 PROMPT ===================================================================================== 
 