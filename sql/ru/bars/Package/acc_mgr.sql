
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/acc_mgr.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.ACC_MGR is
--
--  ACC_MGR - ����� ��� ������ �� �������
--

g_header_version  constant varchar2(64)  := 'version 1.0 22/12/2008';

g_awk_header_defs constant varchar2(512) := '';


--------------------------------------------------------------------------------
-- header_version - ���������� ������ ��������� ������
--
function header_version return varchar2;

--------------------------------------------------------------------------------
-- body_version - ���������� ������ ���� ������
--
function body_version return varchar2;


end acc_mgr;
/

 show err;
 
PROMPT *** Create  grants  ACC_MGR ***
grant EXECUTE                                                                on ACC_MGR         to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/acc_mgr.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 