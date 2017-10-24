

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CRKR_GET_USERS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CRKR_GET_USERS ***

  CREATE OR REPLACE PROCEDURE BARS.CRKR_GET_USERS as
  l_authorization varchar2(4000);
  l_login         varchar2(400);
  l_password      varchar2(400);
  l_wallet_path varchar2(4000);
  l_wallet_pass   varchar2(4000);
  l_request       clob;
  l_url           varchar2(4000);
  l_response      wsm_mgr.t_response;
  l_count         decimal;
  l_key           decimal := 0;
  l_import_users crkr_import_users%rowtype;
  l_logname      crkr_import_users.logname%type;
  l_xml xmltype;
begin
  savepoint sp_importstart;
  for c in (select st.logname,
                   st.fio,
                   st.branch,
                   st.can_select_branch,
                   ast.adate1,
                   ast.adate2
              from APPLIST_STAFF ast, staff st
             where ast.codeapp = 'ACBO'
               and ast.id = st.id
               and AST.APPROVE = 1
               and (AST.ADATE2 > sysdate or AST.ADATE2 is null)
               and nvl(ast.revoked, 0) = 0
               and st.branch not in ('/')) loop
    begin
      insert into crkr_import_users(logname,fio,branch,canselectbranch,dateprivstart,dateprivend,state,method)
      values(c.logname,c.fio,c.branch,c.can_select_branch,c.adate1,c.adate2,'IMPORT','I');
    exception
      when dup_val_on_index then
        select *
          into l_import_users
          from crkr_import_users
         where logname = c.logname;
        if l_import_users.fio not in (c.fio) or
           l_import_users.branch not in (c.branch) or
           l_import_users.canselectbranch not in (c.can_select_branch) or
           l_import_users.dateprivstart not in (c.adate1) or
           l_import_users.dateprivend not in (c.adate2) then
          update crkr_import_users
             set fio             = c.fio,
                 branch          = c.branch,
                 canselectbranch = c.can_select_branch,
                 dateprivstart   = c.adate1,
                 dateprivend     = c.adate2,
                 state           = 'IMPORT',
                 method          = 'U'
           where logname = c.logname;
        end if;
    end;
  end loop;
  for c in (select * from crkr_import_users) loop
    declare
      l_cnt decimal := 0;
    begin
      select count(1)
        into l_cnt
        from APPLIST_STAFF ast, staff st
       where ast.codeapp = 'ACBO'
         and ast.id = st.id
         and AST.APPROVE = 1
         and (AST.ADATE2 > sysdate or AST.ADATE2 is null)
         and nvl(ast.revoked, 0) = 0
         and st.branch not in ('/')
         and st.logname = c.logname;
      if l_cnt = 0 then
        update crkr_import_users
           set state           = 'IMPORT',
               method          = 'D'
         where logname = c.logname;
      end if;
    end;
  end loop;
  select count(1) into l_count from crkr_import_users where state in ('IMPORT','ERROR');
  /*l_request := '[';
  for c in (/*select st.logname, st.fio, st.branch, st.can_select_branch
              from APPLIST_STAFF ast, staff st
             where ast.codeapp = 'ACBO'
               and ast.id = st.id
               and AST.APPROVE = 1
               and AST.ADATE2 > sysdate
               and nvl(ast.revoked, 0) = 0
               and st.branch not in ('/')*
             select * from crkr_import_users where state in ('IMPORT','ERROR')) loop
    l_key := l_key + 1;
    l_request := l_request||'{';
    l_request := l_request||'"logname": "'||c.logname||'",';
    l_request := l_request||'"fio": "'||c.fio||'",';
    l_request := l_request||'"branch": "'||c.branch||'",';
    l_request := l_request||'"canselectbranch": "'||c.canselectbranch||'",';
    l_request := l_request||'"method": "'||c.method||'"';
    if l_count = l_key then
      l_request := l_request||'}';
    else
      l_request := l_request||'},';
    end if;
    update crkr_import_users set state = 'DONE' where logname = c.logname;
  end loop;
  l_request := l_request||']';*/
  l_request := '<?xml version="1.0" encoding="UTF-8" ?>';
  select XmlElement("ListUsersParams",
                    XmlAgg(XmlElement("user",
                                      XmlElement("logname", c.logname),
                                      XmlElement("fio", c.fio),
                                      XmlElement("branch", c.branch),
                                      XmlElement("canselectbranch",
                                                 c.canselectbranch),
                                      XmlElement("method", c.method),
                                      (case when c.dateprivstart is null then null else XmlElement("dateprivstart", c.dateprivstart) end),
                                      (case when c.dateprivend is null then null else XmlElement("dateprivend", c.dateprivend) end))))
    into l_xml
    from crkr_import_users c
   where state in ('IMPORT', 'ERROR');
  --l_url := get_wparam('CRKR_URL');
  l_request := l_request||l_xml.getClobVal();
  l_url := 'http://10.10.10.85:8009/barsroot/api/ImportUsers/ImportUsers';
  begin
    begin
       select val into l_wallet_path from params where par = 'CRKR_WALLET_PATH';
    exception when no_data_found then
       l_wallet_path := null;
    end;
    begin
       select val into l_wallet_pass from params where par = 'CRKR_WALLET_PASS';
    exception when no_data_found then
       l_wallet_pass := null;
    end;
    begin
       select val into l_login from params where par = 'CRKR_LOGIN';
    exception when no_data_found then
       l_login := null;
    end;
    begin
       select val into l_password from params where par = 'CRKR_PASS';
    exception when no_data_found then
       l_password := null;
    end;

    if (l_login is not null) then
      l_authorization := 'Basic ' ||
                         utl_raw.cast_to_varchar2(utl_encode.base64_encode(utl_raw.cast_to_raw(l_login || ':' ||
                                                                                               l_password)));
    end if;

    bars.wsm_mgr.prepare_request(p_url          => l_url,
                                 p_action       => null,
                                 p_http_method  => bars.wsm_mgr.G_HTTP_POST,
                                 p_wallet_path  => l_wallet_path,
                                 p_wallet_pwd   => l_wallet_pass,
                                 p_body         => l_request);

    if (l_authorization is not null) then
      bars.wsm_mgr.add_header(p_name  => 'Authorization',
                              p_value => l_authorization);
    end if;
    wsm_mgr.add_header(p_name  => 'Content-Type',
                       p_value => 'application/xml; charset=utf-8');
    bars.wsm_mgr.execute_api(l_response);

    if l_response.cdoc is not null then
      declare
        l_res     xmltype;
        l_user    crkr_import_users%rowtype;
      begin
        l_res := xmltype(l_response.cdoc);
        for c in (select (column_value).extract('user/logname/text()').getStringVal() as logname,
                         (column_value).extract('user/success/text()').getNumberVal() as success,
                         (column_value).extract('user/message/text()').getStringVal() as message
                    from table (select XMLSequence(l_res.extract('ListUsersResponse/user'))
                                  from dual)) loop
          if c.success = 0 then
            update crkr_import_users set state = 'ERROR', errormessage = c.message where logname = c.logname;
          else
            select * into l_user from crkr_import_users where logname = c.logname;
            if l_user.method = 'D' then
              delete from crkr_import_users where logname = c.logname;
            else
              update crkr_import_users set state = 'DONE', errormessage = null where logname = c.logname;
            end if;
          end if;
        end loop;
      end;
    else
      rollback to savepoint sp_importstart;
      RAISE_APPLICATION_ERROR(-20000, l_response.cdoc);
    end if;

    /*if l_response.cdoc not in ('success') then
      rollback to savepoint sp_importstart;
      RAISE_APPLICATION_ERROR(-20000, l_response.cdoc);
    end if;*/
  exception
    when others then
      rollback to savepoint sp_importstart;
      RAISE_APPLICATION_ERROR(-20000, sqlerrm);
  end;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CRKR_GET_USERS.sql =========*** En
PROMPT ===================================================================================== 
