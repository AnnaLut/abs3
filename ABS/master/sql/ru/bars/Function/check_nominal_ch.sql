
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/check_nominal_ch.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CHECK_NOMINAL_CH (p_kv accounts.kv%type,
                                            p_tag op_field.tag%type,
                                            p_val varchar2)
RETURN  number
 is
n_ int :=1 ;
tmp_ number;
BEGIN
 if p_tag in('NOMC1','NOMC2','NOMC3','NOMC4','NOMC5',
             'NDC01','NDC02','NDC03','NDC04','NDC05',
             'NDC06','NDC07','NDC08','NDC09','NDC10',
             'NDC11','NDC12','NDC13','NDC14','NDC15') then
     BEGIN
      if p_val='0'
        then  n_:=1;
      else
       BEGIN
        select 1 into tmp_ from nominal_check
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
 
PROMPT *** Create  grants  CHECK_NOMINAL_CH ***
grant EXECUTE                                                                on CHECK_NOMINAL_CH to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CHECK_NOMINAL_CH to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/check_nominal_ch.sql =========*** E
 PROMPT ===================================================================================== 
 