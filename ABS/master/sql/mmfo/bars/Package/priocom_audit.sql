
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/priocom_audit.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.PRIOCOM_AUDIT is
/**
	����� priocom_audit �������� ��������� ��� ������ �������� ������������
	��������� ������� �������
*/

G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'version 1.0 01/09/2006';

G_AWK_HEADER_DEFS CONSTANT VARCHAR2(512) := '';

/**
 * header_version - ���������� ������ ��������� ������
 */
function header_version return varchar2;

/**
 * body_version - ���������� ������ ���� ������
 */
function body_version return varchar2;

/**
 * trace - ����� �������������� ���������
 */
procedure trace(p_msg in varchar2);

/**
 * debug - ����� ���������� ���������
 */
procedure debug(p_msg in varchar2);

/**
 * info - ����� �������������� ���������
 */
procedure info(p_msg in varchar2);

/**
 * security - ����� ��������� ������� ������
 */
procedure security(p_msg in varchar2);

/**
 * financial - ����� ���������� ���������
 */
procedure financial(p_msg in varchar2);

/**
 * error - ����� ��������� �� �������
 */
procedure error(p_msg in varchar2);

/**
 * fatal - ����� ��������� ���������
 */
procedure fatal(p_msg in varchar2);


end priocom_audit;
/
CREATE OR REPLACE PACKAGE BODY BARS.PRIOCOM_AUDIT is

/**
	����� priocom_audit �������� ��������� ��� ������ �������� ������������
	��������� ������� �������
*/


G_BODY_VERSION  CONSTANT VARCHAR2(64)  := 'version 1.0 01/09/2006';

G_AWK_BODY_DEFS CONSTANT VARCHAR2(512) := '';

/**
 * header_version - ���������� ������ ��������� ������
 */
function header_version return varchar2 is
begin
  return 'Package header PRIOCOM_AUDIT '||G_HEADER_VERSION||'.'||chr(10)
	   ||'AWK definition: '||chr(10)
	   ||G_AWK_HEADER_DEFS;
end header_version;

/**
 * body_version - ���������� ������ ���� ������
 */
function body_version return varchar2 is
begin
  return 'Package body PRIOCOM_AUDIT '||G_BODY_VERSION||'.'||chr(10)
	   ||'AWK definition: '||chr(10)
	   ||G_AWK_BODY_DEFS;
end body_version;

/**
 * trace - ����� �������������� ���������
 */
procedure trace(p_msg in varchar2) is
begin
    bars_audit.trace('PRIOCOM: '||p_msg);
end trace;

/**
 * debug - ����� ���������� ���������
 */
procedure debug(p_msg in varchar2) is
begin
    bars_audit.debug('PRIOCOM: '||p_msg);
end debug;

/**
 * info - ����� �������������� ���������
 */
procedure info(p_msg in varchar2) is
begin
    bars_audit.info('PRIOCOM: '||p_msg);
end info;

/**
 * security - ����� ��������� ������� ������
 */
procedure security(p_msg in varchar2) is
begin
    bars_audit.security('PRIOCOM: '||p_msg);
end security;

/**
 * financial - ����� ���������� ���������
 */
procedure financial(p_msg in varchar2) is
begin
    bars_audit.financial('PRIOCOM: '||p_msg);
end financial;

/**
 * error - ����� ��������� �� �������
 */
procedure error(p_msg in varchar2) is
begin
    bars_audit.error('PRIOCOM: '||p_msg);
end error;

/**
 * fatal - ����� ��������� ���������
 */
procedure fatal(p_msg in varchar2) is
begin
    bars_audit.error('PRIOCOM: '||p_msg);
end fatal;

end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/priocom_audit.sql =========*** End *
 PROMPT ===================================================================================== 
 