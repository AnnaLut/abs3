PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_EDIT_CC_SWTRACE.sql =========*** Run
PROMPT ===================================================================================== 

PROMPT *** Create  procedure P_EDIT_CC_SWTRACE***


CREATE OR REPLACE PROCEDURE P_EDIT_CC_SWTRACE (p_par number ,
                                               p_id in cc_swtrace.id%type,
                                               p_rnk in cc_swtrace.rnk%type,
                                               p_kv  in number,
                                               p_swo_bic in cc_swtrace.swo_bic%type,
                                               p_swo_acc in cc_swtrace.swo_acc%type,
                                               p_swo_alt in cc_swtrace.swo_alt%type,
                                               p_interm_b in cc_swtrace.interm_b%type,
                                               p_field_58d  in cc_swtrace.field_58d%type,
                                               p_nls  in cc_swtrace.nls%type)

is 
v_rnk_cust customer%rowtype;
v_bic sw_banks%rowtype;
BEGIN
IF p_par=0 THEN

  update cc_swtrace set
         kv=p_kv,
         SWO_BIC=p_swo_bic,
         SWO_ACC=p_swo_acc,
         SWO_ALT=p_swo_alt,
         INTERM_B=p_interm_b,
         FIELD_58D=p_field_58d,
         NLS=p_nls
             where rnk=p_rnk and id=p_id;
  ELSIF p_par=1 THEN
       begin
       select * into v_rnk_cust  from customer where rnk=p_rnk;
          EXCEPTION when no_data_found then
            raise_application_error(-20000,'Такого клієнта '|| to_char(p_rnk)  ||' не існує');
            end;
            if (v_rnk_cust.rnk is not null) then
            begin
             begin
              select * into v_bic from sw_banks where bic=p_swo_bic;
               EXCEPTION when no_data_found then
               raise_application_error(-20000,'Не вірно вказаний BIC-код партнера ' || to_char(p_swo_bic));
               end;
              if (v_bic.bic=p_swo_bic)  then
                insert into cc_swtrace
                         (rnk,kv,swo_bic,swo_acc,swo_alt,interm_b,field_58d,nls)
                         values
                         (v_rnk_cust.rnk, p_kv,v_bic.bic,p_swo_acc,p_swo_alt,p_interm_b,p_field_58d,p_nls);
                end if;
              end;
            end if;

  ELSIF p_par=2 THEN
       DELETE FROM cc_swtrace
       WHERE rnk=p_rnk and id=p_id;
 END IF;
END;
/
PROMPT *** Create  grants  P_EDIT_CC_SWTRACE ***
grant EXECUTE on P_EDIT_CC_SWTRACE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_EDIT_CC_SWTRACE.sql =========*** End
PROMPT ===================================================================================== 








 


