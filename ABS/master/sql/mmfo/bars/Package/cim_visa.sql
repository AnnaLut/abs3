
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/cim_visa.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CIM_VISA 
is
   --
   --  CIM_VISA
   --  ������� ������� ��� �������� ���������� ���.
   --

   g_header_version    constant varchar2 (64) := 'version 1.00.01 29/09/2015';
   g_awk_header_defs   constant varchar2 (512) := '';

   --------------------------------------------------------------------------------
   -- ����
   --

   --------------------------------------------------------------------------------
   -- ���������
   --
   --------------------------------------------------------------------------------
   -- �������� ���������
   --

   --------------------------------------------------------------------------------
   -- �������� ����
   --

   --------------------------------------------------------------------------------
   -- header_version - ������� ����� ��������� ������
   --
   function header_version return varchar2;

   --------------------------------------------------------------------------------
   -- body_version - ������� ����� ��� ������
   --
   function body_version return varchar2;

   --------------------------------------------------------------------------------
   --�������� �������� ����������� �� ���� ���� �������� �������� ������
  function exist_income_sum (p_nls in varchar2, -- NLS ������� ����������
                             p_kv in number, -- ��� ������
                             p_s in number, -- ����
                             p_income_nls_mask in varchar2, -- ����� �������, � ����� �� ���� �����������
                             p_dat in date, -- ���� �������
                             p_period in number -- �����, �������� ����� ����������� ����� �����������
                            ) return number; -- ���������: 1 - ����������� ��������, 0 - ����������� �� �������� - ����������� �� ��������

END cim_visa;
/
CREATE OR REPLACE PACKAGE BODY BARS.CIM_VISA 
is
   --
   --  CIM_VISA
   --

   g_body_version      constant varchar2 (64) := 'version 1.00.01 29/09/2015';
   g_awk_body_defs     constant varchar2 (512) := '';

   --------------------------------------------------------------------------------
   -- header_version - ������� ����� ��������� ������
   --
   function header_version return varchar2
   is
   begin
      return    'Package header CIM_REPORTS '
             || g_header_version
             || '.'
             || CHR (10)
             || 'AWK definition: '
             || CHR (10)
             || g_awk_header_defs;
   end header_version;

   --------------------------------------------------------------------------------
   -- body_version - ������� ����� ��� ������
   --
   function body_version return varchar2
   is
   begin
      return    'Package body CIM_REPORTS '
             || g_body_version
             || '.'
             || CHR (10)
             || 'AWK definition: '
             || CHR (10)
             || g_awk_body_defs;
   end body_version;

   --------------------------------------------------------------------------------
   --�������� �������� ����������� �� ���� ���� �������� �������� ������

  function exist_income_sum (p_nls in varchar2, -- NLS ������� ����������
                             p_kv in number, -- ��� ������
                             p_s in number, -- ����
                             p_income_nls_mask in varchar2, -- ����� �������, � ����� �� ���� �����������
                             p_dat in date, -- ���� �������
                             p_period in number -- �����, �������� ����� ����������� ����� �����������
                            ) return number -- ���������: 1 - ����������� ��������, 0 - ����������� ��
  is
    l_n number;
    l_acc number;
  begin
    select a.acc into l_acc from accounts a where a.kv=p_kv and a.nls=p_nls;
    select count(*) into l_n
      from opldok b
           join opldok a on a.ref=b.ref
           join accounts r on r.nls like p_income_nls_mask and r.acc=a.acc
     where b.sos=5 and b.s=p_s and b.acc=l_acc and b.fdat<trunc(p_dat+1) and b.fdat>=(p_dat-p_period);
    return l_n;
  end exist_income_sum;

end cim_visa;
/
 show err;
 
PROMPT *** Create  grants  CIM_VISA ***
grant EXECUTE                                                                on CIM_VISA        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CIM_VISA        to CIM_ROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/cim_visa.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 