
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/not_role.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.NOT_ROLE (l_RowId varchar2 ) return int is
-- 0 = �� ����������� � ���.������
-- 1 = ���� � ���.������ ������ 1 ���
  l_Ret int  ; -- = 0 ������ ����������� � �����. = 1 - ������ ������������ ���� �� � ����� ����
  l_tabname varchar2 (30) := PUL.GET( 'TABNAME' ) ;
  l_RT  int  ; -- ��� �������
  l_RI  int  ; -- �� ������ � �������  TABNAME
  -------------------------------------------------
begin
  begin 

     If l_tabname = 'STAFF$BASE'    then ----------------------------------------| ������������ -> ...
        select id into l_RI from STAFF$BASE    where rowid  = l_rowid ;  l_RT := resource_utl.get_resource_type_id('STAFF_USER') ;
        select 1  into l_Ret from ADM_RESOURCE where rownum = 1 and   GRANTEE_TYPE_ID  = l_RT  and GRANTEE_ID  = l_RI  ;

     ElsIf l_tabname = 'STAFF_ROLE' then ----------------------------------------| ... -> ���� -> ���� -> ...
        select id into l_RI from  STAFF_ROLE   where rowid  = l_rowid ;  l_RT := resource_utl.get_resource_type_id('STAFF_ROLE') ;
        select 1  into l_Ret from ADM_RESOURCE where rownum = 1 and
                  (resource_type_id = l_RT and resource_id  = l_RI or GRANTEE_TYPE_ID  = l_RT  and GRANTEE_ID  = l_RI );

     ElsIf l_tabname = 'GROUPS'     then  ----------------------------------------| ... -> ��� ������� 
        select id into l_RI from  GROUPS       where rowid  = l_rowid ;  l_RT := resource_utl.get_resource_type_id('ACCOUNT_GROUP') ;
        select 1  into l_Ret from ADM_RESOURCE where rownum = 1 and   resource_type_id = l_RT and resource_id  = l_RI  ;

     ElsIf l_tabname = 'CHKLIST'    then  ----------------------------------------| ... -> ��� �����������
        select idchk into l_RI from CHKLIST    where rowid  = l_rowid ;  l_RT := resource_utl.get_resource_type_id('CHKLIST') ;
        select 1  into l_Ret from ADM_RESOURCE where rownum = 1 and   resource_type_id = l_RT and resource_id  = l_RI  ;

     ElsIf l_tabname = 'KL_F00$GLOBAL' then  ----------------------------------------| ... -> ��� ����� 
        select id into l_RI  from KL_F00$GLOBAL where rowid = l_rowid ;  l_RT := resource_utl.get_resource_type_id('KLF') ;
        select 1  into l_Ret from ADM_RESOURCE where rownum = 1 and   resource_type_id = l_RT and resource_id  = l_RI  ;

     ElsIf l_tabname = 'TTS'        then  ----------------------------------------| ... -> ��������
        select id into l_RI from TTS           where rowid  = l_rowid ;  l_RT := resource_utl.get_resource_type_id('TTS') ;
        select 1  into l_Ret from ADM_RESOURCE where rownum = 1 and   resource_type_id = l_RT and resource_id  = l_RI  ;

     ElsIf l_tabname = 'APPLIST1'   then -----------------------------------------| ... -> ��� -> ��� -> ...
        select id into l_RI from  APPLIST      where rowid  = l_rowid ;  l_RT := resource_utl.get_resource_type_id('ARM_WEB') ;
        select 1  into l_Ret from ADM_RESOURCE where rownum = 1 and
                  (resource_type_id = l_RT and resource_id  = l_RI or GRANTEE_TYPE_ID  = l_RT  and GRANTEE_ID  = l_RI );

     ElsIf l_tabname = 'OPERLIST1'  then  ----------------------------------------| ... -> �������
        select codeoper into l_RI from operlist where rowid = l_rowid ;  l_RT := resource_utl.get_resource_type_id('FUNCTION_WEB') ;
        select 1  into l_Ret from ADM_RESOURCE where rownum= 1 and   resource_type_id = l_RT and resource_id  = l_RI  ;

     ElsIf l_tabname = 'TYPEREF'    then -----------------------------------------| ...  -> (���� ������������)
        select type into l_RI from TYPEREF     where rowid = l_rowid ;  l_RT := resource_utl.get_resource_type_id('DIRECTORIES')   ; 
        select 1  into l_Ret from ADM_RESOURCE a, references r where rownum= 1  and 
                  a.resource_type_id = l_RT and a.resource_id = r.tabid and r.type = l_RI;

    ElsIf l_tabname = 'REPORTSF'   then  -----------------------------------------| ...  -> (����� ���.�������) 
       select idf into l_RI  from REPORTSF    where rowid = l_rowid ;  l_RT := resource_utl.get_resource_type_id('REPORTS')   ; 
       select 1   into l_Ret from ADM_RESOURCE a, reports r where rownum= 1  and 
                  a.resource_type_id = l_RT and a.resource_id = r.id and r.idf = l_RI;
    else l_Ret := 0 ;
    end if ;

  EXCEPTION  WHEN NO_DATA_FOUND THEN l_Ret := 0 ;
  end;
  Return l_Ret ;

end NOT_ROLE;
/
 show err;
 
PROMPT *** Create  grants  NOT_ROLE ***
grant EXECUTE                                                                on NOT_ROLE        to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/not_role.sql =========*** End *** =
 PROMPT ===================================================================================== 
 