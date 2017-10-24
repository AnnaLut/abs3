
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/depricated_branch_edit.sql =========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.DEPRICATED_BRANCH_EDIT IS

--***************************************************************************--
-- (C) BARS. Branch Edit Редактирование иерархии подразделений.
--***************************************************************************--

G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'Version 1.3 11/03/2010';
G_AWK_HEADER_DEFS CONSTANT VARCHAR2(512) := '';

----
-- header_version - возвращает версию заголовка пакета
--
function header_version return varchar2;

----
-- body_version - возвращает версию тела пакета
--
function body_version return varchar2;

PROCEDURE insBranch
 (sBranch  in  branch.branch%type,
  sName    in  branch.name%type,
  sB040    in  branch.b040%type,
  sDescr   in  branch.description%type,
  sIdPdr   in  branch.idpdr%type );

PROCEDURE updateBranch
 (sBranch  in  branch.branch%type,
  sName    in  branch.name%type,
  sB040    in  branch.b040%type,
  sDescr   in  branch.description%type,
  sIdPdr   in  branch.idpdr%type );

PROCEDURE modifyBranch(
  sBranch      VARCHAR2,
  sName        VARCHAR2,
  sB040        VARCHAR2,
  sDescr       VARCHAR2,
  sIdpdr       NUMBER   ) ;

FUNCTION getBranchParams(
  sBranch      VARCHAR2,
  sTag         VARCHAR2 ) RETURN VARCHAR2;

PROCEDURE setBranchParams(
  sBranch      VARCHAR2,
  sTag         VARCHAR2,
  sVal         VARCHAR2 ) ;

PROCEDURE reBranch(
  sBranch      VARCHAR2,
  sBranchNew   VARCHAR2,
  sName        VARCHAR2,
  sB040        VARCHAR2,
  sDescr       VARCHAR2 ) ;

----
-- get_branch_parameter - возвращает значение параметра отделения
--
-- при отсутствиии параметра выбрасывается исключение no_data_found
--
function get_branch_parameter(
	p_branch  			in branch_parameters.branch%type,
    p_tag     			in branch_parameters.tag%type
  ) return branch_parameters.val%type;

----
-- get_branch_parameter_ex - возвращает значение параметра отделения
--
-- при отсутствиии параметра возвращается значение p_valdefault
--
function get_branch_parameter_ex(
	p_branch  			in branch_parameters.branch%type,
    p_tag     			in branch_parameters.tag%type,
    p_valdefault		in branch_parameters.val%type default null
  ) return branch_parameters.val%type;

END depricated_BRANCH_EDIT;
/
CREATE OR REPLACE PACKAGE BODY BARS.DEPRICATED_BRANCH_EDIT 
IS
--***************************************************************************--
-- (C) BARS. Branch Edit Редактирование иерархии подразделений.
--***************************************************************************--

g_body_version  CONSTANT VARCHAR2(64)  := 'version 2.0 17/04/2015';
g_awk_body_defs CONSTANT VARCHAR2(512) := '';

/* header_version - возвращает версию заголовка пакета */
function header_version return varchar2 is
begin
  return 'Package header BRANCH_EDIT '||G_HEADER_VERSION||'.'||chr(10)||
         'AWK definition: '||chr(10)  ||G_AWK_HEADER_DEFS;
end header_version;

/* body_version - возвращает версию тела пакета */
function body_version return varchar2 is
begin
  return 'Package body BRANCH_EDIT '||G_BODY_VERSION||'.'||chr(10)||
         'AWK definition: '||chr(10)||G_AWK_BODY_DEFS;
end body_version;

--***************************************************************************--
-- PROCEDURE    : insBranch
-- DESCRIPTION  : Добавить новое подразделение
--***************************************************************************--
PROCEDURE insBranch
 (sBranch  in  branch.branch%type,
  sName    in  branch.name%type,
  sB040    in  branch.b040%type,
  sDescr   in  branch.description%type,
  sIdPdr   in  branch.idpdr%type)
IS
BEGIN
   branch_utl.add_branch(
                 p_branch      => sBranch,
                 p_name        => sName,
                 p_b040        => sB040,
                 p_branch_type => null,
                 p_opendate    => null,
                 p_closedate   => null);





END insBranch;

--***************************************************************************--
-- PROCEDURE    : updateBranch
-- DESCRIPTION  : Изменить свойства подразделения
--***************************************************************************--
PROCEDURE updateBranch
 (sBranch  in  branch.branch%type,
  sName    in  branch.name%type,
  sB040    in  branch.b040%type,
  sDescr   in  branch.description%type,
  sIdPdr   in  branch.idpdr%type)
IS
BEGIN


   branch_utl.update_branch(
                 p_branch      => sBranch,
                 p_name        => sName,
                 p_b040        => sB040,
                 p_branch_type => null,
                 p_opendate    => null,
                 p_closedate   => null);
END updateBranch;

--***************************************************************************--
-- PROCEDURE    : modifyBranch
-- DESCRIPTION  : Добавить подразделение или Изменить свойства подразделения
--***************************************************************************--
PROCEDURE modifyBranch(
  sBranch      VARCHAR2,
  sName        VARCHAR2,
  sB040        VARCHAR2,
  sDescr       VARCHAR2,
  sIdpdr       NUMBER
) IS
BEGIN
  branch_utl.update_branch(
                 p_branch      => sBranch,
                 p_name        => sName,
                 p_b040        => sB040,
                 p_branch_type => null,
                 p_opendate    => null,
                 p_closedate   => null);
END modifyBranch;

--***************************************************************************--
-- PROCEDURE    : getBranchParams
-- DESCRIPTION  : Установить параметры подразделения
--***************************************************************************--
FUNCTION getBranchParams(
  sBranch      VARCHAR2,
  sTag         VARCHAR2 ) RETURN VARCHAR2 IS
result_ branch_parameters.val%TYPE;
BEGIN
     /*
	 SELECT val INTO result_
  FROM branch_parameters
  WHERE branch=sBranch AND tag=sTag;
  RETURN result_;
  */
  return  branch_attribute_utl.get_attribute_value
           (p_branch_code    => sBranch,
            p_attribute_code => sTag,
            p_raise_expt     => 1,
            p_parent_lookup  => 1,
            p_check_exist    => 0
            );
END getBranchParams;

--***************************************************************************--
-- PROCEDURE    : setBranchParams
-- DESCRIPTION  : Установить параметры подразделения
--***************************************************************************--
PROCEDURE setBranchParams(
  sBranch      VARCHAR2,
  sTag         VARCHAR2,
  sVal         VARCHAR2
) IS
BEGIN
  /*
  UPDATE branch_parameters
  SET val=sVal
  WHERE branch=sBranch AND tag=sTag;
  IF sql%rowcount=0 THEN
    INSERT INTO branch_parameters(branch, tag, val)
    VALUES(sBranch, sTag, sVal) ;
  END IF;
  */

  branch_attribute_utl.set_attribute_value(
                 p_branch_code => sBranch,
                 p_attribute_code  => sTag,
                 p_attribute_value => sVal);

END setBranchParams;

--***************************************************************************--
-- PROCEDURE    : reBranch
-- DESCRIPTION  : Перерегистрировать отделение на др. филиал
--***************************************************************************--
PROCEDURE reBranch(
  sBranch      VARCHAR2,
  sBranchNew   VARCHAR2,
  sName        VARCHAR2,
  sB040        VARCHAR2,
  sDescr       VARCHAR2
) IS
ConstraintName_ VARCHAR2(30);
BEGIN
  insBranch(sBranchNew, sName, sB040, sDescr, null);

  SELECT constraint_name INTO ConstraintName_
  FROM user_constraints
  WHERE table_name='BRANCH' AND constraint_type='P';

  FOR k IN ( SELECT table_name, constraint_name FROM user_constraints
             WHERE r_constraint_name=ConstraintName_
               AND upper(table_name)<>'BRANCH') LOOP
    FOR m IN ( SELECT column_name FROM user_cons_columns
               WHERE constraint_name=k.constraint_name ) LOOP
      EXECUTE IMMEDIATE
        'UPDATE ' || k.table_name ||
        '   SET ' || m.column_name || '=:sBranchNew ' ||
        ' WHERE ' || m.column_name || '=:sBranch' USING sBranchNew, sBranch;
    END LOOP;
  END LOOP;

  DELETE FROM branch WHERE branch=sBranch;
END reBranch;


----
-- get_branch_parameter - возвращает значение параметра отделения
--
-- при отсутствиии параметра выбрасывается исключение no_data_found
--
function get_branch_parameter(
    p_branch            in branch_parameters.branch%type,
    p_tag               in branch_parameters.tag%type
  ) return branch_parameters.val%type
is
    l_val   branch_parameters.val%type;
begin
    /*select val into l_val from branch_parameters
    where branch=p_branch and tag=p_tag;
    return l_val;
	*/
	return  branch_attribute_utl.get_attribute_value
           (p_branch_code    => p_branch,
            p_attribute_code => p_tag,
            p_raise_expt     => 0,
            p_parent_lookup  => 1,
            p_check_exist    => 0
            );

end get_branch_parameter;


----
-- get_branch_parameter_ex - возвращает значение параметра отделения
--
-- при отсутствиии параметра возвращается значение p_valdefault
--
function get_branch_parameter_ex(
    p_branch            in branch_parameters.branch%type,
    p_tag               in branch_parameters.tag%type,
    p_valdefault        in branch_parameters.val%type default null
  ) return branch_parameters.val%type
is
begin
    return  branch_attribute_utl.get_attribute_value
           (p_branch_code    => p_branch,
            p_attribute_code => p_tag,
            p_raise_expt     => 0,
            p_parent_lookup  => 1,
            p_check_exist    => 0,
            p_def_value      => p_valdefault
            );
end get_branch_parameter_ex;




END depricated_BRANCH_EDIT;
/
 show err;
 
PROMPT *** Create  grants  DEPRICATED_BRANCH_EDIT ***
grant EXECUTE                                                                on DEPRICATED_BRANCH_EDIT to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DEPRICATED_BRANCH_EDIT to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/depricated_branch_edit.sql =========
 PROMPT ===================================================================================== 
 