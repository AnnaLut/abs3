CREATE OR REPLACE PACKAGE PKG_STAT_DICT is
--работа со словарями
  g_header_version  constant varchar2(64) := 'version 1.1 24/01/2019';
  
  --добавление/исправление workflow
  procedure set_stat_workflows(p_id         in stat_workflows.id%type,
                               p_name       in stat_workflows.name%type,
                               p_close_date in stat_workflows.close_date%type);                             
  --удаление workflow
  procedure delete_stat_workflows(p_id in stat_workflows.id%type);
  
 
  --добавление/исправление расширение
  procedure set_stat_file_extensions(p_id         in stat_file_extensions.id%type,
                                     p_name       in stat_file_extensions.name%type);                                      
  --удаление расширения
  procedure delete_stat_file_extensions(p_id in stat_file_extensions.id%type);    
  
  --добавление/исправление статусов
  procedure set_stat_file_statuses(p_id         in STAT_FILE_STATUSES.id%type,
                                   p_name       in STAT_FILE_STATUSES.name%type);
  --удаление статуса
  procedure delete_stat_file_statuses(p_id in STAT_FILE_STATUSES.id%type);   
  
  --добавление/исправление типу файла
  procedure set_stat_file_types(p_id         in STAT_FILE_TYPES.id%type,
                                p_name       in STAT_FILE_TYPES.name%type,
                                p_code       in STAT_FILE_TYPES.code%type,
                                p_WF_ID      in STAT_FILE_TYPES.WF_ID%type,
                                p_EXT_ID     in STAT_FILE_TYPES.EXT_ID%type);
  --удаление типу файла
  procedure delete_stat_file_types(p_id in STAT_FILE_TYPES.id%type);                                                                                                     
                                  
  --добавление/исправление операции
  procedure set_stat_operations(p_id            in STAT_OPERATIONS.id%type,
                                p_name          in STAT_OPERATIONS.name%type,
                                p_BEGIN_STATUS  in STAT_OPERATIONS.BEGIN_STATUS%type,
                                p_END_STATUS    in STAT_OPERATIONS.END_STATUS%type,
                                p_NEED_SIGN     in STAT_OPERATIONS.NEED_SIGN%type);
  --удаление операции
  procedure delete_stat_operations(p_id in stat_operations.id%type);    
  
  --добавление/исправление соответствия операции-WF (Связь операций с техпроцессом)
  procedure set_stat_workflow_operations(p_id        in stat_workflow_operations.id%type,
                                         p_wf_id     in stat_workflow_operations.wf_id %type,
                                         p_oper_id   in stat_workflow_operations.oper_id %type,
                                         p_end_oper  in stat_workflow_operations.end_oper %type);
  --удаление соответствия операции-WF (Связь операций с техпроцессом)
  procedure delete_stat_workflow_oper(p_id in stat_operations.id%type);                                          
 

  --добавление/исправление Доступ пользователя к операции
  procedure set_stat_access(p_id           in stat_access.id%type,
                            p_WF_OPER_ID   in stat_access.WF_OPER_ID%type,
                            p_ROLE         in stat_access.ROLE%type);
  --удаление Доступ пользователя к операции
  procedure delete_stat_access(p_id in stat_access.id%type);                                                            
end PKG_STAT_DICT;
/
CREATE OR REPLACE PACKAGE BODY PKG_STAT_DICT is
--работа со словарями
  g_body_version  constant varchar2(64) := 'version 1.1 24/01/2019';
  g_dbgcode       constant varchar2(20) := 'PKG_STAT_DICT';
  g_load_oper     constant int := 0;  --операция загрузки

  --добавление/исправление workflow
  procedure set_stat_workflows(p_id         in stat_workflows.id%type,
                               p_name       in stat_workflows.name%type,
                               p_close_date in stat_workflows.close_date%type) is
  l_th constant varchar2(100) := g_dbgcode || 'set_stat_workflows';
  begin
    logger.trace('%s: entry point', l_th);
    update stat_workflows t
       set t.name = p_name,
           t.close_date = p_close_date,
           t.close_user_id =  case when p_close_date is not null then gl.USR_ID else null end
     where t.id = p_id;
    if sql%rowcount = 0 then
      insert into stat_workflows
        (id, name, close_date, close_user_id)
      values
        (s_statworkflows.nextval, p_name, p_close_date,null);
    end if;
    logger.trace('%s: done', l_th);
  end set_stat_workflows;

  --удаление workflow
  procedure delete_stat_workflows(p_id in stat_workflows.id%type) is
    l_th constant varchar2(100) := g_dbgcode || 'delete_stat_workflows';
  begin
    logger.trace('%s: entry point', l_th);
    begin
      delete from stat_workflows where id = p_id;
    exception
      when others then
        if sqlcode = -02292 then
          raise_application_error(-20001,'Даний запис використовується в інших словниках. Видалення неможливе!');
        else
          raise;
        end if;
    end;
    logger.trace('%s: done', l_th);
  end delete_stat_workflows;


  --добавление/исправление расширение
  procedure set_stat_file_extensions(p_id         in stat_file_extensions.id%type,
                                     p_name       in stat_file_extensions.name%type) is
  l_th constant varchar2(100) := g_dbgcode || 'set_stat_file_extensions';
  begin
    logger.trace('%s: entry point', l_th);
    update stat_file_extensions t
       set t.name = p_name
     where t.id = p_id;
    if sql%rowcount = 0 then
      insert into stat_file_extensions
        (id, name)
      values
        (p_id, p_name);
    end if;
    logger.trace('%s: done', l_th);
  end set_stat_file_extensions;

  --удаление расширения
  procedure delete_stat_file_extensions(p_id in stat_file_extensions.id%type) is
    l_th constant varchar2(100) := g_dbgcode || 'delete_stat_file_extensions';
  begin
    logger.trace('%s: entry point', l_th);
    begin
      delete from stat_file_extensions where id = p_id;
    exception
      when others then
        if sqlcode = -02292 then
          raise_application_error(-20001,'Даний запис використовується в інших словниках. Видалення неможливе!');
        else
          raise;
        end if;
    end;
    logger.trace('%s: done', l_th);
  end delete_stat_file_extensions;

  --добавление/исправление статусов
  procedure set_stat_file_statuses(p_id         in STAT_FILE_STATUSES.id%type,
                                   p_name       in STAT_FILE_STATUSES.name%type) is
  l_th constant varchar2(100) := g_dbgcode || 'set_stat_file_statuses';
  begin
    logger.trace('%s: entry point', l_th);
    update STAT_FILE_STATUSES t
       set t.name = p_name
     where t.id = p_id;
    if sql%rowcount = 0 then
      insert into STAT_FILE_STATUSES
        (id, name)
      values
        (s_statfilestatuses.nextval, p_name);
    end if;
    logger.trace('%s: done', l_th);
  end set_stat_file_statuses;

  --удаление статуса
  procedure delete_stat_file_statuses(p_id in STAT_FILE_STATUSES.id%type) is
    l_th constant varchar2(100) := g_dbgcode || 'delete_stat_file_statuses';
  begin
    logger.trace('%s: entry point', l_th);
    begin
      delete from STAT_FILE_STATUSES where id = p_id;
    exception
      when others then
        if sqlcode = -02292 then
          raise_application_error(-20001,'Даний запис використовується в інших словниках. Видалення неможливе!');
        else
          raise;
        end if;
    end;
    logger.trace('%s: done', l_th);
  end delete_stat_file_statuses;

  --добавление/исправление типу файла
  procedure set_stat_file_types(p_id         in STAT_FILE_TYPES.id%type,
                                p_name       in STAT_FILE_TYPES.name%type,
                                p_code       in STAT_FILE_TYPES.code%type,
                                p_WF_ID      in STAT_FILE_TYPES.WF_ID%type,
                                p_EXT_ID     in STAT_FILE_TYPES.EXT_ID%type) is
  l_th constant varchar2(100) := g_dbgcode || 'set_stat_file_types';
  begin
    logger.trace('%s: entry point', l_th);
    update STAT_FILE_TYPES t
       set t.name   = p_name,
           t.wf_id  = p_WF_ID,
           t.ext_id = p_EXT_ID,
           t.code   = p_code
     where t.id = p_id;
    if sql%rowcount = 0 then
      insert into STAT_FILE_TYPES
        (id, name, wf_id, ext_id, code)
      values
        (s_statfilestatuses.nextval, p_name, p_WF_ID, p_EXT_ID, p_code);
    end if;
    logger.trace('%s: done', l_th);
  end set_stat_file_types;

  --удаление типу файла
  procedure delete_stat_file_types(p_id in STAT_FILE_TYPES.id%type) is
    l_th constant varchar2(100) := g_dbgcode || 'delete_stat_file_types';
  begin
    logger.trace('%s: entry point', l_th);
    begin
      delete from STAT_FILE_TYPES where id = p_id;
    exception
      when others then
        if sqlcode = -02292 then
          raise_application_error(-20001,'Даний запис використовується в інших словниках. Видалення неможливе!');
        else
          raise;
        end if;
    end;
    logger.trace('%s: done', l_th);
  end delete_stat_file_types;


  --добавление/исправление операции
  procedure set_stat_operations(p_id            in STAT_OPERATIONS.id%type,
                                p_name          in STAT_OPERATIONS.name%type,
                                p_BEGIN_STATUS  in STAT_OPERATIONS.BEGIN_STATUS%type,
                                p_END_STATUS    in STAT_OPERATIONS.END_STATUS%type,
                                p_NEED_SIGN     in STAT_OPERATIONS.NEED_SIGN%type) is
  l_th constant varchar2(100) := g_dbgcode || 'set_stat_operations';
  begin
    logger.trace('%s: entry point', l_th);
    if p_id =  g_load_oper then
      raise_application_error(-20001,'Даний запис є базовим. Виправлення неможливе!');
    end if;
    update STAT_OPERATIONS t
       set t.name          = p_name,
           t.BEGIN_STATUS  = p_BEGIN_STATUS,
           t.END_STATUS    = p_END_STATUS,
           t.NEED_SIGN     = p_NEED_SIGN
     where t.id = p_id;
    if sql%rowcount = 0 then
      insert into STAT_OPERATIONS
        (id, name, begin_status, end_status, need_sign)
      values
        (s_statoperations.nextval, p_name, p_BEGIN_STATUS, p_END_STATUS, p_NEED_SIGN);
    end if;
    logger.trace('%s: done', l_th);
  end set_stat_operations;

  --удаление операции
  procedure delete_stat_operations(p_id in stat_operations.id%type) is
    l_th constant varchar2(100) := g_dbgcode || 'delete_stat_operations';
  begin
    logger.trace('%s: entry point', l_th);
    if p_id =  g_load_oper then
      raise_application_error(-20001,'Даний запис є базовим. Видалення неможливе!');
    end if;
    begin
      delete from stat_operations where id = p_id;
    exception
      when others then
        if sqlcode = -02292 then
          raise_application_error(-20001,'Даний запис використовується в інших словниках. Видалення неможливе!');
        else
          raise;
        end if;
    end;
    logger.trace('%s: done', l_th);
  end delete_stat_operations;

  --добавление/исправление соответствия операции-WF (Связь операций с техпроцессом)
  procedure set_stat_workflow_operations(p_id        in stat_workflow_operations.id%type,
                                         p_wf_id     in stat_workflow_operations.wf_id%type,
                                         p_oper_id   in stat_workflow_operations.oper_id%type,
                                         p_end_oper  in stat_workflow_operations.end_oper%type) is
  l_th constant varchar2(100) := g_dbgcode || 'set_stat_workflow_operations';
  begin
    logger.trace('%s: entry point', l_th);
    update stat_workflow_operations t
       set t.wf_id          = p_wf_id,
           t.oper_id        = p_oper_id,
           t.end_oper       = p_end_oper
     where t.id = p_id;
    if sql%rowcount = 0 then
      insert into stat_workflow_operations
        (id, wf_id, oper_id, end_oper)
      values
        (S_STATWORKFLOWOPERATIONS.nextval, p_wf_id, p_oper_id, p_end_oper);
    end if;
    logger.trace('%s: done', l_th);
  end set_stat_workflow_operations;

  --удаление соответствия операции-WF (Связь операций с техпроцессом)
  procedure delete_stat_workflow_oper(p_id in stat_operations.id%type) is
    l_th constant varchar2(100) := g_dbgcode || 'delete_stat_workflow_operations';
  begin
    logger.trace('%s: entry point', l_th);
    begin
      delete from stat_workflow_operations where id = p_id;
    exception
      when others then
        if sqlcode = -02292 then
          raise_application_error(-20001,'Даний запис використовується в інших словниках. Видалення неможливе!');
        else
          raise;
        end if;
    end;
    logger.trace('%s: done', l_th);
  end delete_stat_workflow_oper;


  --добавление/исправление Доступ пользователя к операции
  procedure set_stat_access(p_id           in stat_access.id%type,
                            p_WF_OPER_ID   in stat_access.WF_OPER_ID%type,
                            p_ROLE         in stat_access.ROLE%type) is
  l_th constant varchar2(100) := g_dbgcode || 'set_stat_access';
  begin
    logger.trace('%s: entry point', l_th);
    update stat_access t
       set t.WF_OPER_ID  = p_WF_OPER_ID,
           t.ROLE        = p_ROLE
     where t.id = p_id;
    if sql%rowcount = 0 then
      insert into stat_access
        (id, WF_OPER_ID, ROLE)
      values
        (S_STATACCESS.nextval, p_WF_OPER_ID, p_ROLE);
    end if;
    logger.trace('%s: done', l_th);
  end set_stat_access;



  --удаление Доступ пользователя к операции
  procedure delete_stat_access(p_id in stat_access.id%type) is
    l_th constant varchar2(100) := g_dbgcode || 'delete_stat_workflow_operations';
  begin
    logger.trace('%s: entry point', l_th);
    begin
      delete from stat_access where id = p_id;
    exception
      when others then
        if sqlcode = -02292 then
          raise_application_error(-20001,'Даний запис використовується в інших словниках. Видалення неможливе!');
        else
          raise;
        end if;
    end;
    logger.trace('%s: done', l_th);
  end delete_stat_access;

begin
  null;
end PKG_STAT_DICT;
/
