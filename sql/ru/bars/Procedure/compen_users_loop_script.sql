

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/COMPEN_USERS_LOOP_SCRIPT.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure COMPEN_USERS_LOOP_SCRIPT ***

  CREATE OR REPLACE PROCEDURE BARS.COMPEN_USERS_LOOP_SCRIPT (l_type number) is

  procedure compen_user_create_script(p_logname           staff.logname%type,
                                      p_fio               staff.fio%type,
                                      p_branch            staff.branch%type,
                                      p_can_select_branch staff.can_select_branch%type) is
    l_txt         varchar2(32000);

    type t_dic IS TABLE OF CHAR(2) INDEX BY PLS_INTEGER;
    l_kf_ru       t_dic;

    l_logname           staff.logname%type;
  begin
       l_kf_ru(300465) := '01';
       l_kf_ru(324805) := '02';
       l_kf_ru(302076) := '03';
       l_kf_ru(303398) := '04';
       l_kf_ru(305482) := '05';
       l_kf_ru(335106) := '06';
       l_kf_ru(311647) := '07';
       l_kf_ru(312356) := '08';
       l_kf_ru(313957) := '09';
       l_kf_ru(336503) := '10';
       l_kf_ru(322669) := '11';
       l_kf_ru(323475) := '12';
       l_kf_ru(304665) := '13';
       l_kf_ru(325796) := '14';
       l_kf_ru(326461) := '15';
       l_kf_ru(328845) := '16';
       l_kf_ru(331467) := '17';
       l_kf_ru(333368) := '18';
       l_kf_ru(337568) := '19';
       l_kf_ru(338545) := '20';
       l_kf_ru(351823) := '21';
       l_kf_ru(352457) := '22';
       l_kf_ru(315784) := '23';
       l_kf_ru(354507) := '24';
       l_kf_ru(356334) := '25';
       l_kf_ru(353553) := '26';

      l_logname := p_logname||l_kf_ru(substr(p_branch,2,6));


      l_txt := l_txt||'prompt ===================================='||chr(10);
      l_txt := l_txt||'prompt Create user  '||l_logname||chr(10);
      l_txt := l_txt||'prompt ===================================='||chr(10);
      l_txt := l_txt||'begin '||chr(10)||
                        ' for x in (select ''create web user '' as msg from dual '||chr(10)||
                        '           where not exists (select 1 from staff$base where logname = '''||l_logname||''')) loop'||chr(10);
      l_txt := l_txt||'   bars_useradm.create_user(p_usrfio     => '''||p_fio||''','||chr(10)||
                        '                            p_usrtabn    => null,'||chr(10)||
                        '                            p_usrtype    => 0,'||chr(10)||
                        '                            p_usraccown  => 0,'||chr(10)||
                        '                            p_usrbranch  =>'''||p_branch||''','||chr(10)||
                        '                            p_usrusearc  => 0,'||chr(10)||
                        '                            p_usrusegtw  => 0,'||chr(10)||
                        '                            p_usrwprof   => ''DEFAULT_PROFILE'','||chr(10)||
                        '                            p_reclogname => '''||l_logname||''','||chr(10)||
                        '                            p_recpasswd  => ''qwerty'','||chr(10)||
                        '                            p_recappauth => '''||l_logname||''','||chr(10)||
                        '                            p_recprof    => ''DEFAULTPROFILE'','||chr(10)||
                        '                            p_recdefrole => ''BARS_ACCESS_DEFROLE'','||chr(10)||
                        '                            p_recrsgrp   => null,'||chr(10)||
                        '                            p_usrid      => null,'||chr(10)||
                        '                            p_gtwpasswd  => ''qwerty'','||chr(10)||
                        '                            p_canselectbranch  => '||case when p_can_select_branch is null then 'null,' else ''''||p_can_select_branch||''',' end||chr(10)||
                        '                            p_chgpwd     => null,'||chr(10)||
                        '                            p_tipid      => null);'||chr(10);

      l_txt := l_txt||'   update staff$base  set   BAX =1, TBAX = sysdate '||chr(10)||
                        '   where logname = '''||l_logname||''';'||chr(10);
      l_txt := l_txt||'   commit;'||chr(10)||
                        '   dbms_output.put_line(''User '||l_logname||' was created.'');'||chr(10);

      l_txt := l_txt||'   update web_usermap set webpass=''b1b3773a05c0ed0176787a4f1574ff0075f7521e'', adminpass=null, blocked=0, attempts=0 where DBUSER='''||l_logname||''';'||chr(10)||
                        '   commit;'||chr(10);

      l_txt := l_txt||'  end loop;'||chr(10)||
                        'end;'||chr(10)||
                        '/'||chr(10);

      l_txt := l_txt||'prompt ADD user  '||l_logname||' in ARM '||chr(10);
      l_txt := l_txt||'prompt ===================================='||chr(10);
      l_txt := l_txt||'insert into applist_staff (id, codeapp, approve, grantor) '||chr(10)||
                       'select s.id, '''||case l_type when 1 then 'CRCO' when 2 then 'CRCT' end||''', 1, 1'||chr(10)||
                       'from   staff$base s'||chr(10)||
                       'where  s.logname = '''||l_logname||''' and'||chr(10)||
                       'not exists (select 1 from applist_staff astf where astf.id = s.id and astf.codeapp = '''
                       ||case l_type when 1 then 'CRCO' when 2 then 'CRCT' end||''');'||chr(10)||
                       '/'||chr(10)||
                       'commit;'
                       ;


      dbms_output.put_line(l_txt);

  end;

begin
   for cur in (select st.logname, st.fio, st.branch, st.can_select_branch
                from applist_staff ast, staff st
               where ast.codeapp = case l_type when 1 then 'ACBO' when 2 then 'WOPR' end
                 and ast.id = st.id
                 and ast.approve = 1
                 and (ast.adate2 > sysdate or ast.adate2 is null)
                 and nvl(ast.revoked, 0) = 0
                 --and st.branch = '/333368/000000/000038/'
                 --and rownum < 2
                 ) loop
    compen_user_create_script(cur.logname, cur.fio, cur.branch, cur.can_select_branch);
  end loop;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/COMPEN_USERS_LOOP_SCRIPT.sql =====
PROMPT ===================================================================================== 
