-- ======================================================================================
-- Module  : CDM (ЄБК)
-- Author  : BAA
-- Date    : 10.10.2016
-- ======================================================================================
-- COBUCDMCORP-46 (створення WEB функцій):
--   1) АРМ Якості ФОП
--   2) АРМ Якості ЮО
-- ======================================================================================
begin
  Insert into BARS.ROLES$BASE ( ROLE_NAME ) Values ( 'BARS_ACCESS_DEFROLE' );
exception
  when DUP_VAL_ON_INDEX
  then null;
end;
/

COMMIT;


prompt ========================================
prompt == Створення функції "АРМ Якості ФОП" ==
prompt ========================================

declare
  l_fcn_id   operlist.codeoper%type;
  l_fcn_nm   operlist.funcname%type;
begin
  
--l_fcn_nm := replace('/barsroot/cdm/quality/index?type=entrepreneurperson','?','\?');
  l_fcn_nm := '/barsroot/cdm/quality/\S*entrepreneurperson';
  
  begin
    
    delete BARS.OPERAPP 
     where CODEOPER in ( select CODEOPER
                           from BARS.OPERLIST 
                          where regexp_like( FUNCNAME, l_fcn_nm, 'i' ) );
    
    delete BARS.OPERLIST_DEPS
     where ID_CHILD in ( select CODEOPER 
                           from BARS.OPERLIST 
                          where regexp_like( FUNCNAME, l_fcn_nm, 'i' ) )
        or ID_PARENT in (select CODEOPER 
                           from BARS.OPERLIST 
                          where regexp_like( FUNCNAME, l_fcn_nm, 'i' ) );
    
    delete BARS.OPERLIST
     where regexp_like( FUNCNAME, l_fcn_nm, 'i' )
--  returning CODEOPER into l_fcn_id
    ;
    
--  if ( sql%rowcount > 0 )
--  then
--    dbms_output.put_line( 'Функцiя №' || to_char(l_fcn_id) || ' - видалена' );
--  end if;
    
  end;
  
  l_fcn_id := abs_utils.add_func
  ( p_name     => 'АРМ Якості ФОП'
  , p_funcname => '/barsroot/cdm/quality/advisorylist?type=entrepreneurPerson'
  , p_rolename => 'BARS_ACCESS_DEFROLE'
  , p_frontend => 1
  , p_runnable => 1 );
  
  -- вставка функцій в АРМ
  begin
    
    insert
      into BARS.OPERAPP
      ( CODEAPP, CODEOPER, APPROVE, GRANTOR )
    values
      ( 'CDME', l_fcn_id, 1, user_id );
    
    dbms_output.put_line( 'Функцiю <АРМ Якості ФОП> додано в АРМ Робота з ЄБК ФОП' );
    
  exception 
    when DUP_VAL_ON_INDEX then
      null;
  end;
  
end;
/

commit;

prompt ========================================
prompt == Створення функції "АРМ Якості ЮО" ==
prompt ========================================

declare
  l_fcn_id   operlist.codeoper%type;
  l_fcn_nm   operlist.funcname%type;
begin
   
  begin
    
--  l_fcn_nm := replace('/barsroot/cdm/quality/index?type=legalperson','?','\?');
    l_fcn_nm := '/barsroot/cdm/quality/\S*legalperson';
    
    delete BARS.OPERAPP 
     where CODEOPER in ( select CODEOPER
                           from BARS.OPERLIST 
                          where regexp_like( FUNCNAME, l_fcn_nm, 'i' ) );
    
    delete BARS.OPERLIST_DEPS
     where ID_CHILD in ( select CODEOPER 
                           from BARS.OPERLIST 
                          where regexp_like( FUNCNAME, l_fcn_nm, 'i' ) )
        or ID_PARENT in (select CODEOPER 
                           from BARS.OPERLIST 
                          where regexp_like( FUNCNAME, l_fcn_nm, 'i' ) );
    
    delete BARS.OPERLIST
     where regexp_like( FUNCNAME, l_fcn_nm, 'i' )
--  returning CODEOPER into l_fcn_id
    ;
    
--  if ( sql%rowcount > 0 )
--  then
--    dbms_output.put_line( 'Функцiя №' || to_char(l_fcn_id) || ' - видалена' );
--  end if;
    
  end;
  
  l_fcn_id := abs_utils.add_func
  ( p_name     => 'АРМ Якості ЮО'
  , p_funcname => '/barsroot/cdm/quality/advisorylist?type=legalPerson'
  , p_rolename => 'BARS_ACCESS_DEFROLE'
  , p_frontend => 1
  , p_runnable => 1 );
  
  -- вставка функцій в АРМ
  begin
    
    insert 
      into BARS.OPERAPP
      ( CODEAPP, CODEOPER, APPROVE, GRANTOR )
    values
      ( 'CDML', l_fcn_id, 1, user_id );
    
    dbms_output.put_line( 'Функцiю <АРМ Якості ЮО> додано в АРМ Робота з ЄБК ЮО' );
    
  exception 
    when DUP_VAL_ON_INDEX then
      null;
  end;
  
end;
/

commit;

prompt ========================================
prompt == Створення функції "АРМ Якості ФО" ==
prompt ========================================

declare
  l_fcn_id   operlist.codeoper%type;
  l_fcn_nm   operlist.funcname%type;
begin
   
  begin
    
    l_fcn_nm := '/barsroot/cdm/quality/\S*individualperson';
    
    delete BARS.OPERAPP 
     where CODEOPER in ( select CODEOPER
                           from BARS.OPERLIST 
                          where regexp_like( FUNCNAME, l_fcn_nm, 'i' ) );
    
    delete BARS.OPERLIST_DEPS
     where ID_CHILD in ( select CODEOPER 
                           from BARS.OPERLIST 
                          where regexp_like( FUNCNAME, l_fcn_nm, 'i' ) )
        or ID_PARENT in (select CODEOPER 
                           from BARS.OPERLIST 
                          where regexp_like( FUNCNAME, l_fcn_nm, 'i' ) );
    
    delete BARS.OPERLIST
     where regexp_like( FUNCNAME, l_fcn_nm, 'i' )
--  returning CODEOPER into l_fcn_id
    ;
    
--  if ( sql%rowcount > 0 )
--  then
--    dbms_output.put_line( 'Функцiя №' || to_char(l_fcn_id) || ' - видалена' );
--  end if;
    
  end;
  
  l_fcn_id := abs_utils.add_func
  ( p_name     => 'АРМ Якості ФО'
  , p_funcname => '/barsroot/cdm/quality/index?type=individualPerson'
  , p_rolename => 'BARS_ACCESS_DEFROLE'
  , p_frontend => 1
  , p_runnable => 1 );
  
  -- вставка функцій в АРМ
  begin
    
    insert 
      into BARS.OPERAPP
      ( CODEAPP, CODEOPER, APPROVE, GRANTOR )
    values
      ( 'CDMI', l_fcn_id, 1, user_id );
    
    dbms_output.put_line( 'Функцiю <АРМ Якості ФО> додано в АРМ Робота з ЄБК ФО' );
    
  exception 
    when DUP_VAL_ON_INDEX then
      null;
  end;
  
end;
/

prompt ==================================================
prompt == BranchList ( АРМ Якості + АРМ Дедублікації ) ==
prompt ==================================================

declare
  l_fcn_id   operlist.codeoper%type;
  l_fcn_nm   operlist.funcname%type;
begin
  
  begin
    
    l_fcn_nm := '/barsroot/cdm/quality/branchlist\S*';
    
    delete BARS.OPERAPP 
     where CODEOPER in ( select CODEOPER
                           from BARS.OPERLIST 
                          where FUNCNAME = l_fcn_nm );
    
    delete BARS.OPERLIST_DEPS
     where ID_CHILD in ( select CODEOPER 
                           from BARS.OPERLIST 
                          where FUNCNAME = l_fcn_nm )
        or ID_PARENT in (select CODEOPER 
                           from BARS.OPERLIST 
                          where FUNCNAME = l_fcn_nm );
    
    delete BARS.OPERLIST
     where FUNCNAME = l_fcn_nm
    returning CODEOPER into l_fcn_id;
    
    if ( sql%rowcount > 0 )
    then
      dbms_output.put_line( 'Функцiя №' || to_char(l_fcn_id) || ' - видалена' );
    end if;
    
  end;
  
  l_fcn_id := abs_utils.add_func
  ( p_name     => 'ЄБК (список філіалів)'
  , p_funcname => l_fcn_nm
  , p_rolename => 'BARS_ACCESS_DEFROLE'
  , p_frontend => 1
  , p_runnable => 3 );
  
  -- АРМ Якості ( ФО + ФОП + ЮО )
  for k in ( select CODEOPER as PRN_ID
               from BARS.OPERLIST
              where FUNCNAME like '/barsroot/cdm/quality/advisorylist%' )
  loop 
    
    abs_utils.add_oplist_deps( p_id_parent => k.prn_id
                             , p_id_child  => l_fcn_id );
  end loop;
  
  -- АРМ Дедублікації ( ФО + ФОП + ЮО )
  for k in ( select CODEOPER as PRN_ID
               from BARS.OPERLIST
              where FUNCNAME like '/barsroot/cdm/deduplicate/index%' )
  loop
    
    abs_utils.add_oplist_deps( p_id_parent => k.prn_id
                             , p_id_child  => l_fcn_id );
  end loop;
  
end;
/

commit;

--
--
--
declare
  l_fcn_id   operlist.codeoper%type;
begin
  
  -- Реєстрація Клієнтів і Рахунків (ФО)
  select CODEOPER
    into l_fcn_id
    from bars.operlist
   where funcname = '/barsroot/clients/customers/index/?custtype=person';
  
  dbms_output.put_line( 'fcn_id='||to_char(l_fcn_id) );
  
  -- вставка функції в АРМ
  begin
    
    insert into BARS.OPERAPP
      ( codeapp, codeoper, approve, grantor )
    values
      ( 'CDMI', l_fcn_id, 1, user_id );
    
    dbms_output.put_line( 'Функцiю <Реєстрація Клієнтів і Рахунків (ФО)> додано в АРМ Робота з ЄБК ФО' );
    
  exception 
    when DUP_VAL_ON_INDEX then
      null;
  end;
  
exception
  when NO_DATA_FOUND then
    null;
end;
/

commit;

--
--
--
declare
  l_fcn_id   operlist.codeoper%type;
begin
  
  -- Реєстрація Клієнтів і Рахунків (ЮО)
  select CODEOPER
    into l_fcn_id
    from bars.operlist
   where funcname = '/barsroot/clients/customers/index/?custtype=corp';
  
  dbms_output.put_line( 'fcn_id='||to_char(l_fcn_id) );
  
  -- вставка функції в АРМ
  begin
    
    insert into BARS.OPERAPP
      ( codeapp, codeoper, approve, grantor )
    values
      ( 'CDML', l_fcn_id, 1, user_id );
    
    dbms_output.put_line( 'Функцiю <Реєстрація Клієнтів і Рахунків (ЮО)> додано в АРМ Робота з ЄБК ЮО' );
    
  exception 
    when DUP_VAL_ON_INDEX then
      null;
  end;
  
exception
  when NO_DATA_FOUND then
    null;
end;
/

commit;

--
--
--
declare
  l_fcn_id   operlist.codeoper%type;
begin
  
  -- Реєстрація Клієнтів і Рахунків (ФОП)
  select CODEOPER
    into l_fcn_id
    from bars.operlist
   where funcname = '/barsroot/clients/customers/index/?custtype=personspd';
  
  dbms_output.put_line( 'fcn_id='||to_char(l_fcn_id) );
  
  -- вставка функції в АРМ
  begin
    
    insert into BARS.OPERAPP
      ( codeapp, codeoper, approve, grantor )
    values
      ( 'CDME', l_fcn_id, 1, user_id );
    
    dbms_output.put_line( 'Функцiю <Реєстрація Клієнтів і Рахунків (ФОП)> додано в АРМ Робота з ЄБК ФОП' );
    
  exception 
    when DUP_VAL_ON_INDEX then
      null;
  end;
  
exception
  when NO_DATA_FOUND then
    null;
end;
/

commit;

prompt ========================================
prompt == GetRnkAttributes (Арм Дедублікації )
prompt ========================================

declare
  l_fcn_id   operlist.codeoper%type;
  l_fcn_nm   operlist.funcname%type;
begin
  
  begin
    
    l_fcn_nm := '/barsroot/cdm/deduplicate/getrnkattributes?rnk=\d+&type=\S+';
    
    delete BARS.OPERAPP 
     where CODEOPER in ( select CODEOPER
                           from BARS.OPERLIST 
                          where FUNCNAME like '/barsroot/cdm/deduplicate/getrnkattributes%' );
    
    delete BARS.OPERLIST_DEPS
     where ID_CHILD in ( select CODEOPER 
                           from BARS.OPERLIST 
                          where FUNCNAME like '/barsroot/cdm/deduplicate/getrnkattributes%' )
        or ID_PARENT in (select CODEOPER 
                           from BARS.OPERLIST 
                          where FUNCNAME like '/barsroot/cdm/deduplicate/getrnkattributes%' );
    
    delete BARS.OPERLIST
     where FUNCNAME like '/barsroot/cdm/deduplicate/getrnkattributes%'
    returning CODEOPER into l_fcn_id;
    
    if ( sql%rowcount > 0 )
    then
      dbms_output.put_line( 'Функцiя №' || to_char(l_fcn_id) || ' - видалена' );
    end if;
    
  end;
  
  l_fcn_id := abs_utils.add_func
  ( p_name     => 'ЄБК (Rnk Attributes)'
  , p_funcname => l_fcn_nm
  , p_rolename => 'BARS_ACCESS_DEFROLE'
  , p_frontend => 1
  , p_runnable => 3 );
  
  -- АРМ Дедублікації ( ФО + ФОП + ЮО )
  for k in ( select CODEOPER as PRN_ID
               from BARS.OPERLIST
              where FUNCNAME like '/barsroot/cdm/deduplicate/index%' )
  loop
    
    abs_utils.add_oplist_deps( p_id_parent => k.prn_id
                             , p_id_child  => l_fcn_id );
  end loop;
  
end;
/

commit;

prompt ========================================
prompt == GetAdvisoryListByRnk (Арм Якості)
prompt ========================================

declare
  l_fcn_id   operlist.codeoper%type;
  l_fcn_nm   operlist.funcname%type;
begin
  
  begin
    
    l_fcn_nm := replace('/barsroot/cdm/quality/getadvisorylistbyrnk','?','\?');
    
    delete BARS.OPERAPP 
     where CODEOPER in ( select CODEOPER
                           from BARS.OPERLIST 
                          where regexp_like( FUNCNAME, l_fcn_nm, 'i' ) );
    
    delete BARS.OPERLIST_DEPS
     where ID_CHILD in ( select CODEOPER 
                           from BARS.OPERLIST 
                          where regexp_like( FUNCNAME, l_fcn_nm, 'i' ) )
        or ID_PARENT in (select CODEOPER 
                           from BARS.OPERLIST 
                          where regexp_like( FUNCNAME, l_fcn_nm, 'i' ) );
    
    delete BARS.OPERLIST
     where regexp_like( FUNCNAME, l_fcn_nm, 'i' )
    returning CODEOPER into l_fcn_id;
    
    if ( sql%rowcount > 0 )
    then
      dbms_output.put_line( 'Функцiя №' || to_char(l_fcn_id) || ' - видалена' );
    end if;
    
  end;
  
  l_fcn_id := abs_utils.add_func
  ( p_name     => 'ЄБК (список філіалів)'
  , p_funcname => '/barsroot/cdm/quality/getadvisorylistbyrnk?rnk=\d+&groupid=\d&type=\S+'
  , p_rolename => 'BARS_ACCESS_DEFROLE'
  , p_frontend => 1
  , p_runnable => 3 );
  
  -- АРМ Якості ( ФО + ФОП + ЮО )
  for k in ( select CODEOPER as PRN_ID
               from BARS.OPERLIST
              where FUNCNAME like '/barsroot/cdm/quality/advisorylist%' )
  loop 
    
    abs_utils.add_oplist_deps( p_id_parent => k.prn_id
                             , p_id_child  => l_fcn_id );
  end loop;
  
end;
/

commit;

begin
  
  delete BARS.OPERAPP 
   where CODEAPP = 'CDM';
  
  delete BARS.APPLIST_STAFF
   where CODEAPP = 'CDM';
  
  delete BARS.APPLIST
   where CODEAPP = 'CDM';
  
end;
/

commit;
