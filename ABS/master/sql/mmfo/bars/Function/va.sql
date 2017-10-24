
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/va.sql =========*** Run *** =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.VA (nbs_ varchar2 ) RETURN varchar2 IS
   nls_98v accounts.NLS%type;
   -- выбор счета для разных случаев, предусмотренных в приложениях
   l_val operw.value%type;
begin

  begin
    if Substr(nbs_,1,2) in ('99','97')  then
       --Для функции <<Компенсацiї>> , используется в операции 976
       select nbs_ob22( substr(nbs_,1,4),  substr(nbs_,6,2)   )
       into nls_98v  from dual;

    Elsif nbs_ ='98' then
       select decode (substr(o.nlsB,1,2),'29',v.nls_9819,
                                         '99',v.nls_9812,
                                                         v.nls_9812)
       into nls_98v
       from VALUABLES_NLS v, operw w, oper o
       where w.tag='VA_KC' and w.ref=gl.aRef and w.value= v.ob22
         and o.ref=gl.aRef ;

    ElsIf nbs_ ='98S' then

       select v.nls_9819  into nls_98v
       from VALUABLES_NLS v, operw w
       where w.tag='VA_KC' and w.ref=gl.aRef and w.value= v.ob22      ;

       If nls_98v is null then
         raise_application_error(-(20203),
         'Не вiдкрито Рах.обл. цiнностей ' , TRUE);
       end if;

    ElsIf nbs_ ='98D' then

       select v.NLS_9899  into nls_98v
       from VALUABLES_NLS v, operw w
       where w.tag='VA_KC' and w.ref=gl.aRef and w.value= v.ob22  ;

       If nls_98v is null then
         raise_application_error(-(20203),
         'Не вiдкрито Рах.в ДOРОЗI ' ,      TRUE);
       end if;

    else
        null;
    end if;
  EXCEPTION  WHEN NO_DATA_FOUND THEN null;
  end;

  return nls_98v ;

end VA;
 
/
 show err;
 
PROMPT *** Create  grants  VA ***
grant EXECUTE                                                                on VA              to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on VA              to PYOD001;
grant EXECUTE                                                                on VA              to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/va.sql =========*** End *** =======
 PROMPT ===================================================================================== 
 