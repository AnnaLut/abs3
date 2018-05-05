
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/xirr.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
CREATE OR REPLACE FUNCTION XIRR(r_ number, p_arr_tmp_irr t_tmp_irr default null) RETURN NUMBER IS

/*

����� ���� ������� = 1000000
����� ���.��� % ������ =20 = IR
����� ��������� ����+���� ��������� - � ����� �����
���� ���������� K ����
������ ��.������:

delete from tmp_irr;
insert into tmp_irr(n,s) select 1, -1000000 from dual union all select (:k +1 ), 1000000+(1000000*0.2*:k/365) from dual;
select xirr(20)*100 from dual;

k=  180 irr = 21.0146030038595
k=  360 irr = 20.0257766712457
k=  364 irr = 20.005148514756
k=  365 irr = 10 (����� �����-�� ��) � ����, �������� , ���. !!!!!!!!!!!!!!!!!
k=  366 irr = 19.9948548851535
k=  370 irr = 19.9743083841167
k=  540 irr = 19.1482907088357
k=  720 irr = 18.362848906545
k=  730 irr = 18.3215956599452
k= 1095 irr = 16.9607095280662
k= 3650 irr = 11.6123174034146

   �������
   ������ �� ������� ������, ������� � ������ � ������� ���������� IRR=IR.
   ���������:
1) ������� �����������.
2) l_ratn := r_/100; - �������� �� ���.
3) ���������� ����������� ������.
   ��������� ����������, ��� ��� �������� ���������� ������ ��������� ��� (10%)� �������� �� �����.
   ������� ���������� prec  (�������� ���������� ��� ������) ����� ���� ��� ������� �������� ������ � �����  ����� ��������� ����� ���������.

-----------------------
06.03.2018 Diver ������� �������� p_arr_tmp_irr (��� ��������� ������������ � ������ �������� [value_paper])
           ���� �� ������� �� ��������������� nested table, � �� ������� ������� tmp_irr  
30-04-2012 ��������� ��������� ���������� ������ ����� npv=0
03-09-2012 Sta �� �� ����.
04/12/2009 Nov  ������ �� ������. ������������� ������������ �� IRR
                �������� ��� ������ � tmp_irr  �� ����������� ���������
                ������� ������ (S=0) � ��������� ��������� � ����������
                ������� ���� ������, � �� ������� ��� irr
                  13% - ������������ ��� 0.13
*/

   TYPE t_cf_ IS TABLE OF tmp_irr%rowtype INDEX BY BINARY_INTEGER;
   cf_        t_cf_  ;          -- �����
   mark       number := 0;      -- ������� ��������� �����
   step_limit number := 0;      -- ���-�� ����������� ��������
   l_npv      number ;
   l_ratn     number ;          -- �������������� ������
   step       number := 0.1;    -- ��� 10% �������� �� ������
   prec       number := 100000; -- �������� ���������� ��� ������
   k          pls_integer := 0;

BEGIN
   l_ratn := r_/100;

   if p_arr_tmp_irr is not null then
--     SELECT null, t.n, t.s BULK COLLECT INTO cf_ FROM table(p_arr_tmp_irr) t where t.s<>0 ORDER BY t.n;
     for i in p_arr_tmp_irr.first..p_arr_tmp_irr.last loop
       if p_arr_tmp_irr(i).s <> 0 then
         k := k+1;
         cf_(k).s := p_arr_tmp_irr(i).s;
         cf_(k).n := p_arr_tmp_irr(i).n;       
       end if;  
     end loop;  
     else
     begin
       SELECT * BULK COLLECT INTO cf_ FROM TMP_IRR where s<>0 ORDER BY n;
     EXCEPTION WHEN NO_DATA_FOUND THEN  RETURN 0;
     end;
   end if;  

   loop
      begin
         l_npv := cf_(1).s;
      EXCEPTION WHEN NO_DATA_FOUND THEN  RETURN 0;
      end;

      for i in 2 .. cf_.count
      loop
        l_npv := l_npv + cf_(i).s/power((1 + l_ratn),(cf_(i).n-1)/365);
      end loop;
       -- dbms_output.put_line('Mark='||to_char(mark)||' ratn= '||to_char(l_ratn)||' npv='||to_char(l_npv));

     --  ��������� ���� npv ������� ��������� ���
      if l_npv > 0 and mark = 0 then
         step := step / 2;
         mark := 1;
      end if;
     --  ��������� ���� npv ������� ��������� ���
      if l_npv < 0 and mark = 1 then
          step := step / 2;
          mark := 0;
      end if;

      -- �������� % ������ �� ���
      if round(l_npv * prec) != 0 then
         if mark = 0 then     l_ratn := l_ratn - step;
         else                 l_ratn := l_ratn + step;
         end if;
      end if;

      step_limit := step_limit + 1;

      exit when((round(l_npv * prec) = 0) or (step_limit = 10000));
    end loop;

    return l_ratn;

END XIRR;
/
 show err;
 
PROMPT *** Create  grants  XIRR ***
grant EXECUTE                                                                on XIRR            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on XIRR            to RCC_DEAL;
grant EXECUTE                                                                on XIRR            to START1;
grant EXECUTE                                                                on XIRR            to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/xirr.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 