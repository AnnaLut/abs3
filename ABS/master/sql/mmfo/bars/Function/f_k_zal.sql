CREATE OR REPLACE FUNCTION BARS.F_K_ZAL (p_rnk number, p_nd number, p_kod_351 number, p_kol_fin_max number) RETURN number is
-- ���������� ����������� �������� ������������

/* ������ 1.0   20-02-2019 
   COBUSUPABS-7264 (COBUSUPABS-7190)
 */
l_fin_restr  NUMBER;
l_proc_restr NUMBER;
l_k          NUMBER;
begin
   -- l_fin_restr - ��������� ���������������
   -- l_proc_restr - ��������� ���. ����������.
   l_fin_restr  := nvl(fin_nbu.zn_p_nd('ZD6',  55, null, p_nd, p_rnk),0); 
   l_proc_restr := nvl(fin_nbu.zn_p_nd('ZD8',  55, null, p_nd, p_rnk),2); 
/* l_proc_restr
   0 -    1 -  ���������� ��� � ����� - ��������� ������ *
   1 -    2 -  ���������� ��� � ����� - ��������� ������, �����-�����������, ������� ������� �������� ������� �������, �������� 
               �������� ����������, ���������� ������������* 
          * �� �����, �� ����� 䳿 ������������ �� ����� �� ����� ��������� ���������������� �������� �� ���� ������ ����� �������� 
            ��������� �� ���� ������������ �� �������� ���������� ��������� ���� ����������������, ��� � ���� �� ����������
*/
   if p_kod_351 BETWEEN 3 AND 11 THEN
      if p_kol_fin_max < 90 THEN l_k := 1; 
      else                       l_k := 0;
      end if;
   elsif p_kod_351 BETWEEN 12 AND 27 THEN
      if p_kol_fin_max < 730 THEN l_k := 1; 
      else
         if l_fin_restr = 1 THEN  l_k := 1; 
         else
            if    p_kol_fin_max  between  731 and 1095 THEN l_k := 0.7;
            elsif p_kol_fin_max  between 1096 and 1460 THEN l_k := 0.5;
            elsif p_kol_fin_max > 1460                 THEN l_k := 0;
            end if;
         end if;
      end if; 
   elsif p_kod_351 BETWEEN 1 AND 2 THEN    -- ���� ��������� �� 04.03.2019 21:19
      if l_fin_restr = 1 THEN
         if l_proc_restr = 0  THEN 
            if p_kol_fin_max < 365  THEN l_k := 1; 
            else                         l_k := 1;  -- ���� 0
            end if;
         elsif  l_proc_restr = 1 THEN
            if p_kol_fin_max < 1095 THEN l_k := 1; 
            else                         l_k := 1;  -- ���� 0
            end if;
         else                            l_k := 1;
         end if;   
      else
         if p_kol_fin_max < 90 THEN l_k := 1; 
         else                       l_k := 1;       -- ���� 0
         end if;
      end if;
   else                             
      l_k := 1; 
   end if;
   RETURN (L_K);
end;
/
 show err;
 
PROMPT *** Create  grants  F_K_ZAL ***
grant EXECUTE                        on F_K_ZAL to BARS_ACCESS_DEFROLE;
grant EXECUTE                        on F_K_ZAL to START1;
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ============ Scripts /Sql/BARS/function/F_K_ZAL.sql ===========*** End***
 PROMPT ===================================================================================== 

