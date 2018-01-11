
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_ob22_num.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_OB22_NUM (p_ob22 accounts.ob22%type) return varchar2
as
/*ѕерекодуванн€ символьного значенн€ ќЅ22 в цифрове
OB22 = УA0Ф -> 10*36 + 0 = 0360,
OB22 = УB1Ф -> 11*36 + 1 = 0397,
.........................................................
OB22 = УAAФ -> 10*36 + 10 = 0370,
OB22 = УBZФ -> 11*36 + 35 = 0431,
OB22 = УZZФ -> 35*36 + 35 = 1295.
*/
l_var varchar2(50) := '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
l_cof number := 36;
l_num_ob22 number;
l_p1 number := instr(l_var,substr(p_ob22,1,1))-1;
l_p2 number := instr(l_var,substr(p_ob22,2,1))-1;
begin

 l_num_ob22 :=  l_p1 * l_cof + l_p2;

  If l_p1 <0 or l_p2<0
    then raise_application_error(-(20001),'/' ||'     «наченн€ ќЅ22 м≥стить не в≥рн≥ символа>'||p_ob22,TRUE);
  end if;

 return lpad(l_num_ob22,4,'0');

 end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_ob22_num.sql =========*** End ***
 PROMPT ===================================================================================== 
 