
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/visa_kl.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.VISA_KL 
( N_VISA_ int,
  branch_ oper.BRANCH%type,
  ref_    oper.REF%type,
  nlsa_   oper.NLSA%type,
  id_a_   oper.ID_A%type,
  mfob_   oper.MFOB%type,
  nlsb_   oper.NLSB%type,
  id_b_   oper.ID_B%type,
  NAZN_   oper.NAZN%type)    return int is

begin

If N_VISA_ = 2 then

   if length(branch_) = 8 or  branch_ like '%/000000/%' then
      -- ��� ������ ��� ��� 000000  - ��������
      RETURN 1;
   end if;

elsIF N_VISA_ = 1 then
   -- ���� � 1 "25/������i��i�� ��i���-����" -
   NULL;

--   -- ����� �.�. ���� ������� ��������������� ���������� ----
--
--   If NAZN_ like '%���% ' or NAZN_ like '%���%' then
--      RETURN N_VISA_ ;
--   end if;

end if;

   -- ������ �����������
   RETURN 0;


end VISA_KL;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/visa_kl.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 