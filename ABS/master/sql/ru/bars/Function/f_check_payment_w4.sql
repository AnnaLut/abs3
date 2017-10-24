
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_check_payment_w4.sql =========***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CHECK_PAYMENT_W4 (p_s OPERW.VALUE%type, p_kv oper.kv%type, p_paspn OPERW.VALUE%type, flag number default null)
     RETURN NUMBER
     /*
     -- flag=1 -- Сума яку треба виплатити на касу
     -- flag=2 -- Сума яку треба перерахувати на 2909
     */

   is
 --
   l_kv oper.kv%type;
   l_s_val opldok.sq%type;
   l_s  opldok.sq%type;
   l_doc operw.value%type;
   l_sum number;
   l_1002 opldok.sq%type;
   l_2909 opldok.sq%type;
   g_modcode varchar2(3) :='DOC';
   f_dat date;
 --


BEGIN


    select dat_next_u(trunc(sysdate), 1)
    into f_dat
    from dual;

/*     select nvl(max(fdat), trunc(sysdate))
      into f_dat
      from opldok
     where fdat >= trunc(sysdate); */
    ---
    --Шукаєм серію-номер паспорта і еквівалент нашої операції, якщо не знайшли, то видаємо помилку
    --

/*
     begin
       select nvl(gl.p_icurval(o.kv, o.s, trunc(sysdate)),0), o.s, o.kv into l_s, l_s_val, l_kv from oper o
         where o.ref=p_ref;
     end;
*/


    if p_s is null or p_kv is null or p_paspn is null then return 0; end if;

  l_s_val := to_number(trim(to_char(replace(p_s, ',', '.'), '9999999999999.99')), '999999999.99')*100;
  l_s     := nvl(gl.p_icurval(p_kv, l_s_val, trunc(sysdate)),0);
  l_kv    := p_kv;


   --
    l_doc := p_paspn;
   --

   logger.info('Test-'||l_s_val||' '||l_doc);

/*
   if (l_doc is null) then
       raise_application_error(-20000, 'Not found props "PASPN!"');
    end if;
*/

    begin
    begin
      select sum(sq_total) as sq_total
        into l_sum
        from (select tl.doc, tl.sq_total
                from mv_trans_limit150 tl
               where tl.doc =
                    case when TRANSLATE(substr(replace(l_doc,' ',''),1,2),chr(0)||'0123456789',chr(0)) is null then l_doc
                    else
                     recode_passport_serial_noex(substr(replace(l_doc, ' ', ''),
                                                        1,
                                                        2)) ||
                     substr(replace(l_doc, ' ', ''), 3)
                    end
              union all
              select case when TRANSLATE(substr(replace(p.pasp,' ',''),1,2),chr(0)||'0123456789',chr(0)) is null then l_doc
                     else
                        recode_passport_serial_noex(substr(replace(l_doc, ' ', ''),
                                                        1,
                                                        2)) ||
                             substr(replace(l_doc, ' ', ''), 3)
                     end  as doc,
                     o.sq
                from opldok o, (select op.pdat, op.ref,  value pasp from oper op, operw ow where op.ref = ow.ref and ow.tag = 'PASPN' ) p
               where p.pdat between  trunc(sysdate) and sysdate
                 and o.fdat between  trunc(sysdate) and f_dat
                 and o.dk = 0
                 and o.sos >= 1
                 and o.tt in( 'MUX', 'MUK', 'MUZ', 'MVX','W4R','M4Y','MUD')
                 and o.ref<>gl.aref
                 and o.ref=p.ref
                 and
                        case when TRANSLATE(substr(replace(p.pasp,' ',''),1,2),chr(0)||'0123456789',chr(0)) is null then
                            p.pasp
                         else
                            recode_passport_serial_noex(substr(replace(p.pasp,' ',''),1,2))||substr(replace(p.pasp,' ',''),3,length(replace(p.pasp,' ','')))
                         end
                        =
                         case when TRANSLATE(substr(replace(l_doc,' ',''),1,2),chr(0)||'0123456789',chr(0)) is null then l_doc
                         else
                           recode_passport_serial_noex(substr(replace(l_doc,' ',''),1,2))||substr(replace(l_doc,' ',''),3,length(replace(l_doc,' ','')))
                         end
                 and exists (select acc
                        from accounts
                       where nbs = '2909'
                         and dazs is null
                         and acc = o.acc
                         and kv != 980)
                         )
       group by doc;

      exception when no_data_found then l_sum:=0;
     end;



   if flag is not null then
      l_1002:=case when l_sum=0 and l_s <=14999999 then l_s_val
	               when l_sum>14999999 then 0
				   when l_sum+l_s <= 14999999 and l_sum<>0 then l_s_val
				   when l_sum+l_s > 14999999 and l_sum<=14999999 then gl.p_Ncurval( l_kv, 14999999-l_sum, gl.bdate)
				   else 0
			  end;  --т0ут поковирятися

	  l_1002:= least(gl.p_ncurval(l_kv, 14999999, gl.bd),l_1002);

	  if  gl.p_icurval(l_kv, l_1002, gl.bd) > 14999999
	        then  l_1002 := l_1002 - 1;
	  end if;

      l_2909:=l_s_val-l_1002;

	  else
       if (l_sum+l_s > 14999999) then
        bars_error.raise_nerror(g_modcode, 'SUM_IS_GREATER');
       end if;
   end if;
end;


   logger.info('Test-'||l_1002||' '||l_s_val||' '||l_2909||' '||l_sum);

    begin

     if     flag=1 then

      RETURN l_1002;

       elsif flag=2 then

       RETURN l_2909;

       else  RETURN 0;
       end if;
    end;

END;
/
 show err;
 
PROMPT *** Create  grants  F_CHECK_PAYMENT_W4 ***
grant EXECUTE                                                                on F_CHECK_PAYMENT_W4 to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_check_payment_w4.sql =========***
 PROMPT ===================================================================================== 
 