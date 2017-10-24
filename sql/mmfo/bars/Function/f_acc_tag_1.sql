
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_acc_tag_1.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_ACC_TAG_1 
(p_acc int, p_tag varchar2, p_nbs varchar2 default '6110', p_ob22_6 varchar2, p_reg int default 0)
RETURN Varchar2 IS
-- *** ver 5.2 �� 28/10-15 ***
-- ����� ���-�� ���-�� � AccountsW, ���������� ����� �� NBS_OB22_NULL. ��� ���-�� p_nbs, p_ob22_6
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
    tobo_ varchar2(30);    l_branch varchar2(30);
    l_nbs varchar2(4);
    l_ob22_6 varchar2(2);

begin

      l_ret_f:=NULL;
      l_nbs:=p_nbs;  -- ������� ������������� ��������� � ������������� p_reg ...
      l_ob22_6:=p_ob22_6;

      if p_reg >= 0  then
      BEGIN        -- ������� ���� "������" �������� �� AccountsW
      SELECT trim(VALUE) into l_ret_f
      FROM   AccountsW
      WHERE  ACC=p_acc and
             (TAG=p_tag  or (TAG like 'ELT6%' and p_tag like 'ELT6%'))
             and rownum=1;
      EXCEPTION  WHEN NO_DATA_FOUND THEN
      logger.trace('ELT AccountsW not found '||p_tag);
      l_ret_f:=NULL;
                 WHEN TOO_MANY_ROWS THEN
      logger.trace('ELT AccountsW too many rows '||p_tag);
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
    end;   l_branch:=tobo_;

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

    --
    if l_ret is null then
       l_ret:=NBS_OB22_NULL(l_nbs,l_ob22_6,l_branch);
    end if;

  --    EXCEPTION  WHEN NO_DATA_FOUND THEN
  --      raise_application_error(-20000, '���-�: '||P_tag, true);

 RETURN l_ret;
end;
/
 show err;
 
PROMPT *** Create  grants  F_ACC_TAG_1 ***
grant EXECUTE                                                                on F_ACC_TAG_1     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_ACC_TAG_1     to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_acc_tag_1.sql =========*** End **
 PROMPT ===================================================================================== 
 