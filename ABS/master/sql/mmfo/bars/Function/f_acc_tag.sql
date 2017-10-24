
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_acc_tag.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_ACC_TAG 
(p_acc int, p_tag varchar2, p_reg int default 0)
RETURN Varchar2 IS
-- ���������� �������� p_tag ��� ����� p_acc
-- � ����������� �������������� �������� ������ ����� ���-� p_reg
-- p_reg: <0 - �� ������ � AccountsW
-- p_reg: >=0 - ������ � � AccountsW � � TOBO_Params
-- p_reg: 9 -������ ������ �� AccountsW
--        ����� ��� �������� ������ ������ �� ���� �������
--        ��� ������ �� ����������� ������ ����

    l_ret_f varchar2(250);
    l_ret   varchar2(250);
    nls_f varchar2(15);
    nls_  varchar2(15);
    tobo_ varchar2(30);

begin

      l_ret_f:=NULL;

      if p_reg >= 0  then
      BEGIN        -- ������� ���� "������" �������� �� AccountsW
      SELECT trim(VALUE) into l_ret_f
      FROM   AccountsW
      WHERE  ACC=p_acc and TAG=p_tag;
      EXCEPTION  WHEN NO_DATA_FOUND THEN
      l_ret_f:=NULL;
      end;
      if l_ret_f is not NULL then return l_ret_f; end if;
      if p_reg=9 then return l_ret_f; end if;
      end if;

                   -- ��������� ����
    begin
    select tobo into tobo_
    from accounts
    where acc=p_acc;
    EXCEPTION  WHEN NO_DATA_FOUND THEN
    tobo_:= sys_context('bars_context','user_branch');
    end;

    -- ���� � TOBO_PARAMS (��� Branch_parameters ?)
         BEGIN
         SELECT rtrim(VAL)  into l_ret
         FROM TOBO_PARAMS
         WHERE TOBO=tobo_ and TAG=p_tag;
         EXCEPTION  WHEN NO_DATA_FOUND THEN NULL;
         tobo_:=substr(tobo_,1,15);   -- ���� �� 2-� ������
         begin
         SELECT rtrim(VAL) into l_ret
         FROM TOBO_PARAMS
         WHERE TOBO=tobo_ and TAG=p_tag;
         EXCEPTION  WHEN NO_DATA_FOUND THEN NULL;
         tobo_:=substr(tobo_,1,8);   -- ���� �� 1-� ������
         begin
         SELECT rtrim(VAL) into l_ret
         FROM TOBO_PARAMS
         WHERE TOBO=tobo_ and TAG=p_tag;
         EXCEPTION  WHEN NO_DATA_FOUND THEN NULL;
         l_ret:=l_ret_f;
         end;
         end;
         END;

  --    EXCEPTION  WHEN NO_DATA_FOUND THEN
  --      raise_application_error(-20000, '���-�: '||P_tag, true);

 RETURN l_ret;
end;
 
/
 show err;
 
PROMPT *** Create  grants  F_ACC_TAG ***
grant EXECUTE                                                                on F_ACC_TAG       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_ACC_TAG       to START1;
grant EXECUTE                                                                on F_ACC_TAG       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_acc_tag.sql =========*** End *** 
 PROMPT ===================================================================================== 
 