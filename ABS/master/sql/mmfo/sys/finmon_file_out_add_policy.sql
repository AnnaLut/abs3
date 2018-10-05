PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/finmon/Script/file_out_add_policy.sql =========*** Run *** 
PROMPT ===================================================================================== 

PROMPT *** FILE_OUT DROP_POLICY ***

BEGIN
  SYS.DBMS_RLS.DROP_POLICY (
    object_schema    => 'FINMON'
    ,object_name     => 'FILE_OUT'
    ,policy_name     => 'GET_FM_POLICIES');
exception when others then
  if sqlcode = -28102 then null; else raise; end if;
END;
/

PROMPT *** FILE_OUT ADD_POLICY ***

BEGIN
  SYS.DBMS_RLS.ADD_POLICY     (
    object_schema          => 'FINMON'
    ,object_name           => 'FILE_OUT'
    ,policy_name           => 'GET_FM_POLICIES'
    ,function_schema       => 'FINMON'
    ,policy_function       => 'FM_POLICIES.GET_FM_POLICIES'
    ,statement_types       => 'SELECT,INSERT,UPDATE,DELETE'
    ,policy_type           => dbms_rls.dynamic
    ,long_predicate        => FALSE
    ,update_check          => FALSE
    ,static_policy         => FALSE
    ,enable                => TRUE );
exception when others then
  if sqlcode = -28101 then null; else raise; end if;
END;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/finmon/Script/file_out_add_policy.sql =========*** End *** 
PROMPT =====================================================================================
