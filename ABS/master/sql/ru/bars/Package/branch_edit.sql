
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/branch_edit.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BRANCH_EDIT IS

--***************************************************************************--
-- (C) BARS. Branch Edit �������������� �������� �������������.
--***************************************************************************--

G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'Version 1.3 11/03/2010';
G_AWK_HEADER_DEFS CONSTANT VARCHAR2(512) := '';

----
-- header_version - ���������� ������ ��������� ������
--
function header_version return varchar2;

----
-- body_version - ���������� ������ ���� ������
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
-- get_branch_parameter - ���������� �������� ��������� ���������
--
-- ��� ����������� ��������� ������������� ���������� no_data_found
--
function get_branch_parameter(
	p_branch  			in branch_parameters.branch%type,
    p_tag     			in branch_parameters.tag%type
  ) return branch_parameters.val%type;

----
-- get_branch_parameter_ex - ���������� �������� ��������� ���������
--
-- ��� ����������� ��������� ������������ �������� p_valdefault
--
function get_branch_parameter_ex(
	p_branch  			in branch_parameters.branch%type,
    p_tag     			in branch_parameters.tag%type,
    p_valdefault		in branch_parameters.val%type default null
  ) return branch_parameters.val%type;

END BRANCH_EDIT;
/
CREATE OR REPLACE PACKAGE BODY BARS.BRANCH_EDIT 
IS
--***************************************************************************--
-- (C) BARS. Branch Edit �������������� �������� �������������.
--***************************************************************************--

g_body_version  CONSTANT VARCHAR2(64)  := 'version 1.5 11/03/2010';
g_awk_body_defs CONSTANT VARCHAR2(512) := ''
	||'KF - ����� � ����� KF'||chr(10)
;

/* header_version - ���������� ������ ��������� ������ */
function header_version return varchar2 is
begin
  return 'Package header BRANCH_EDIT '||G_HEADER_VERSION||'.'||chr(10)||
         'AWK definition: '||chr(10)  ||G_AWK_HEADER_DEFS;
end header_version;

/* body_version - ���������� ������ ���� ������ */
function body_version return varchar2 is
begin
  return 'Package body BRANCH_EDIT '||G_BODY_VERSION||'.'||chr(10)||
         'AWK definition: '||chr(10)||G_AWK_BODY_DEFS;
end body_version;

--***************************************************************************--
-- PROCEDURE 	: insBranch
-- DESCRIPTION	: �������� ����� �������������
--***************************************************************************--
PROCEDURE insBranch
 (sBranch  in  branch.branch%type,
  sName    in  branch.name%type,
  sB040    in  branch.b040%type,
  sDescr   in  branch.description%type,
  sIdPdr   in  branch.idpdr%type)
IS
  l_kf     banks.mfo%type;
  l_val    params$base.val%type;
BEGIN

  INSERT INTO branch
     (branch,  name,  b040,  description, idpdr)
  VALUES
     (sBranch, sName, sB040, sDescr, sIdPdr) ;

  -- ������� ���������
  l_kf :=  bars_context.extract_mfo(sBranch);

  IF sBranch = '/'||l_kf||'/' THEN

     FOR k IN (SELECT UNIQUE par, comm
                 FROM params$base
                ORDER BY par)
     LOOP

       l_val := CASE
                WHEN k.par = 'BANKDATE' THEN to_char(glb_bankdate, 'MM/DD/YYYY')
                WHEN k.par = 'BASEVAL'  THEN '980'
                WHEN k.par = 'KOD_G'    THEN '804'
                WHEN k.par = 'MFO'      THEN l_kf
                WHEN k.par = 'NAME'     THEN sName
                WHEN k.par = 'RRPDAY'   THEN '0'
                ELSE                         null
                END;

       BEGIN
         INSERT INTO params$base(par, val, comm, kf)
         VALUES (k.par, l_val, k.comm, l_kf);
       EXCEPTION
         WHEN DUP_VAL_ON_INDEX THEN NULL;
       END;

     END LOOP;

  END IF;

END insBranch;

--***************************************************************************--
-- PROCEDURE    : updateBranch
-- DESCRIPTION  : �������� �������� �������������
--***************************************************************************--
PROCEDURE updateBranch
 (sBranch  in  branch.branch%type,
  sName    in  branch.name%type,
  sB040    in  branch.b040%type,
  sDescr   in  branch.description%type,
  sIdPdr   in  branch.idpdr%type)
IS
BEGIN

  UPDATE branch
     SET name = sName,
         b040 = sB040,
         description = sDescr,
         idpdr = sIdPdr
   WHERE branch = sBranch ;

END updateBranch;
--***************************************************************************--
-- PROCEDURE    : modifyBranch
-- DESCRIPTION  : �������� ������������� ��� �������� �������� �������������
--***************************************************************************--
PROCEDURE modifyBranch(
  sBranch      VARCHAR2,
  sName        VARCHAR2,
  sB040        VARCHAR2,
  sDescr       VARCHAR2,
  sIdpdr       NUMBER
) IS
BEGIN
  UPDATE branch
  SET name=sName, b040=sB040, description=sDescr , idpdr=sIdpdr
  WHERE branch=sBranch ;
  if SQL%rowcount = 0 then
     INSERT INTO branch(branch, name, b040, description, idpdr)
            VALUES(sBranch, sName, sB040, sDescr, sIdpdr) ;
  end if;
END modifyBranch;

--***************************************************************************--
-- PROCEDURE    : getBranchParams
-- DESCRIPTION  : ���������� ��������� �������������
--***************************************************************************--

FUNCTION getBranchParams(
  sBranch      VARCHAR2,
  sTag         VARCHAR2 ) RETURN VARCHAR2 IS
result_ branch_parameters.val%TYPE;
BEGIN
  SELECT val INTO result_
  FROM branch_parameters
  WHERE branch=sBranch AND tag=sTag;
  RETURN result_;
END getBranchParams;

--***************************************************************************--
-- PROCEDURE    : setBranchParams
-- DESCRIPTION  : ���������� ��������� �������������
--***************************************************************************--

PROCEDURE setBranchParams(
  sBranch      VARCHAR2,
  sTag         VARCHAR2,
  sVal         VARCHAR2
) IS
BEGIN
  UPDATE branch_parameters
  SET val=sVal
  WHERE branch=sBranch AND tag=sTag;
  IF sql%rowcount=0 THEN
    INSERT INTO branch_parameters(branch, tag, val)
    VALUES(sBranch, sTag, sVal) ;
  END IF;
END setBranchParams;

--***************************************************************************--
-- PROCEDURE 	: reBranch
-- DESCRIPTION	: ������������������ ��������� �� ��. ������
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
-- get_branch_parameter - ���������� �������� ��������� ���������
--
-- ��� ����������� ��������� ������������� ���������� no_data_found
--
function get_branch_parameter(
	p_branch  			in branch_parameters.branch%type,
    p_tag     			in branch_parameters.tag%type
  ) return branch_parameters.val%type
is
	l_val	branch_parameters.val%type;
begin
	select val into l_val from branch_parameters
	where branch=p_branch and tag=p_tag;
	return l_val;
end get_branch_parameter;


----
-- get_branch_parameter_ex - ���������� �������� ��������� ���������
--
-- ��� ����������� ��������� ������������ �������� p_valdefault
--
function get_branch_parameter_ex(
	p_branch  			in branch_parameters.branch%type,
    p_tag     			in branch_parameters.tag%type,
    p_valdefault		in branch_parameters.val%type default null
  ) return branch_parameters.val%type
is
begin
	return get_branch_parameter(p_branch, p_tag);
exception when no_data_found then
	return p_valdefault;
end get_branch_parameter_ex;

END BRANCH_EDIT;
/
 show err;
 
PROMPT *** Create  grants  BRANCH_EDIT ***
grant EXECUTE                                                                on BRANCH_EDIT     to ABS_ADMIN;
grant EXECUTE                                                                on BRANCH_EDIT     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BRANCH_EDIT     to DPT_ROLE;
grant EXECUTE                                                                on BRANCH_EDIT     to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/branch_edit.sql =========*** End ***
 PROMPT ===================================================================================== 
 