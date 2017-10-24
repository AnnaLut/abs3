prompt --Дані про структуру активів та пасивів за строками

delete from operapp
 where codeapp = '$RM_NBUR'
   and codeoper in ( select CODEOPER
                       from operlist
                       where funcname like '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0'||chr(38)||'sPar=[PROC=>BARSUPL.BARS_UPLOAD_USR%18%' );
   
delete from operlist where funcname like '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0'||chr(38)||'sPar=[PROC=>BARSUPL.BARS_UPLOAD_USR%18%';

Declare
    Newfunc  number;
    l_funcname varchar2(512 Byte) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0'|| chr(38) ||'sPar=[PROC=>BARSUPL.BARS_UPLOAD_USR.DELETE_JOBINFO(p_bankdate => :date_to, p_groupid => 18); BARSUPL.BARS_UPLOAD_USR.create_interface_job(p_group_id => 18, p_enabled =>1,p_sheduled => 0, p_bankdate=> :date_to)][PAR=>:date_to(SEM=За дату,TYPE=D)][EXEC=>BEFORE][showDialogWindow=>false][CONDITIONS=>KF=sys_context(''bars_context'',''user_mfo'')]'; 
begin

    Newfunc := abs_utils.add_func( p_name        => 'Вивантаження А7',
                                   p_funcname    => l_funcname,
                                   p_rolename    => '',
                                   p_frontend    => 1,
                                   p_runnable    => 1
                                  );
    begin 
      insert into bars.operapp (codeapp, codeoper, approve, grantor)  values  ('$RM_NBUR', Newfunc, 1, 1);
      exception when dup_val_on_index then null;
    end;
end;
/

commit;
