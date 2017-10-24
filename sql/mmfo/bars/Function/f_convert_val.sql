
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_convert_val.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CONVERT_VAL (p_val_a tabval.kv%type, p_sum number, p_date date, p_val_b tabval.kv%type, p_kurs_type varchar2 default 'O')
   return varchar2
 is
   l_res number;
   l_rato number;
   l_ratb number;
   l_rats number;
begin
      begin
       --KV A = KV B(ERROR)
        if p_val_a = p_val_b then
          raise_application_error(-20000, '"Валюта А" рівна "Валюті Б"');
        end if;
         gl.x_rat(rat_o =>l_rato , rat_b => l_ratb, rat_s => l_rats, kv1_ => p_val_a, kv2_ => p_val_b, dat_ =>p_date);
         if  p_kurs_type= 'B' then
             l_res:=p_sum*l_ratb;
         elsif p_kurs_type= 'S' then
             l_res:=p_sum*l_rats;
         else
             l_res:=p_sum*l_rato;
         end if;
        end;
        return trim(to_char(round(l_res,2), '9999999999999999990.00'));
      end f_convert_val;
/
 show err;
 
PROMPT *** Create  grants  F_CONVERT_VAL ***
grant EXECUTE                                                                on F_CONVERT_VAL   to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_convert_val.sql =========*** End 
 PROMPT ===================================================================================== 
 