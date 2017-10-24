
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/check_nominal.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CHECK_NOMINAL (p_kv accounts.kv%type,
                                         p_tag op_field.tag%type,
                                         p_val varchar2)
RETURN  number
 is
n_ int :=1 ;
tmp_ number;
BEGIN
 if p_tag in('NOMI1','NOMI2','NOMI3','NOMI4','NOMI5','NOMCH',
             'NOMI6','NOMI7','NOMI8','NOMI9','NOM10','NOM11',
             'NOM12','NOM13','NOM14','NOM15') then
     BEGIN
      if p_val='0'
        then  n_:=1;
      else
       BEGIN
        select 1 into tmp_ from nominal
         where kv=p_kv and nominal=p_val;
       exception when no_data_found
                                  then n_:=0;
       END;
      end if;
      END;
  end if;
 RETURN n_;
END;
/
 show err;
 
PROMPT *** Create  grants  CHECK_NOMINAL ***
grant EXECUTE                                                                on CHECK_NOMINAL   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CHECK_NOMINAL   to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/check_nominal.sql =========*** End 
 PROMPT ===================================================================================== 
 