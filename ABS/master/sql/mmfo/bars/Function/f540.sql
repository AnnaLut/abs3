
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f540.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F540 ( p_sk   oper.sk%type   ,
                                       p_nazn oper.nazn%type ,
                                       p_ref  oper.ref%type  ,
                                       p_new  int            ,
                                       p_kv   oper.kv%type
                                     )
return number is
----------------------------------------------------
 l_ret  int ; ---   = 0  - �� ��������� � 150 ���
              ---   = 1  - ��������� � 150 ���
----------------------------------------------------
 l_sk   oper.sk%type   := nvl(p_sk, 0)  ;
 l_nazn oper.nazn%type := upper (p_nazn);
begin

IF p_kv = 980 then          -------  1).  ���  -------------

   If l_sk < 40           or
      l_sk  in (40,50,59) or
      l_sk  = 61 and (l_NAZN like '%������%' or l_NAZN like '%�_����%')   then

      -- �� ��������� �� ��� 40,50,59 � 61 c *������* :

      l_ret := 0 ;

   Else

      -- �� ��������� � ���.����. NB540 "ĳ������� ����.������ (1-���)"

      If p_new = 1 then ------- ��� �����, ������� ��� � ���������� ������

         If NVL(pul.get_mas_ini_val('NB540'),'0')='1' then
            l_ret := 0 ;
         else
            l_ret := 1 ;
         end if ;

      else              ------- ��� �������� ��������� �����
         begin
           select 0 into l_ret from OperW where REF= p_ref and TAG ='NB540' and VALUE ='1';
         exception when no_data_found then
           l_ret := 1;
         end;
      end if;

   End If;

ELSE                 ---------   2).  �����A   ------------


   If l_sk < 40 then

      l_ret := 0 ;

      RETURN l_ret;

   End If;


   If p_new = 1 then ------- ��� �����, ������� ��� � ���������� ������

      If NVL(pul.get_mas_ini_val('NB758'),'0')='1' then
         l_ret := 0 ;
      else
         l_ret := 1 ;
      end if ;

   Else              ------- ��� �������� ��������� �����

      begin
        select 0 into l_ret from OperW where REF= p_ref and TAG ='NB758' and VALUE ='1';
      exception when no_data_found then
        l_ret := 1;
      end;

   End if;


END IF;

RETURN l_ret;

end f540 ;
/
 show err;
 
PROMPT *** Create  grants  F540 ***
grant EXECUTE                                                                on F540            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F540            to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f540.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 