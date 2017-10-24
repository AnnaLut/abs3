
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/sem_role.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.SEM_ROLE (p_Id number, p_tab varchar2 ) return varchar2 is
  -- получение семантического названия доп.рекц по таблице допустимых значений
  l_Tb  number       ;
  l_SK  varchar2(50) ;
  l_fK  varchar2(50) ;
  l_sem varchar2(250);

begin
  If p_Id is not null and p_tab is not null then
     begin select tabid   into l_Tb from meta_tables   where tabname = p_tab ;
           SELECT colname into l_sk from meta_columns  WHERE tabid   = l_Tb  AND showretval     = 1 and  rownum = 1 ;
           SELECT colname into l_fk FROM meta_columns  WHERE tabid   = l_Tb  AND INSTNSSEMANTIC = 1 and  rownum = 1 ;
           EXECUTE IMMEDIATE 'select ' || l_fk || ' from '|| p_tab || ' where ' || l_sk || ' = '|| p_Id  into l_sem ;
    EXCEPTION WHEN NO_DATA_FOUND THEN null;
    end ;
 end if ;

 RETURN l_Sem ;
end SEM_ROLE  ;
/
 show err;
 
PROMPT *** Create  grants  SEM_ROLE ***
grant EXECUTE                                                                on SEM_ROLE        to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/sem_role.sql =========*** End *** =
 PROMPT ===================================================================================== 
 