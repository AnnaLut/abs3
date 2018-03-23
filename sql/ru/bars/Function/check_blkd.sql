
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/function/check_blkd.sql ===============*** R
PROMPT ===================================================================================== 


CREATE OR REPLACE FUNCTION bars.check_blkd (p_nls varchar2,
                                       p_kv number)
return number
is
priority number :=0;
begin
   if ( substr(p_nls,1,4) = '2625' or substr(p_nls,1,4) = '2605' ) then
       begin
          select bars.sto_utl.get_next_priority(a.acc) into priority from accounts a where a.nls = p_nls and a.kv = p_kv and a.blkd != 0;
       EXCEPTION WHEN NO_DATA_FOUND THEN
          return priority; -- �������� �������� 0, ����� ���������� �� ������� 0
       end;
       return priority; -- �������� �������� ����� 0, ����� �� ������� ����������� ����������
   end if;
end;
/

show err;
 
PROMPT *** Create  grants  CHECK_BLKD ***
grant EXECUTE                                                                on CHECK_BLKD to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CHECK_BLKD to START1;
 
 
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/function/check_blkd.sql ===============*** E
PROMPT ===================================================================================== 

