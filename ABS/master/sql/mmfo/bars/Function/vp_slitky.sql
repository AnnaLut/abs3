
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/vp_slitky.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.VP_SLITKY (tag_ operw.tag%type, REF_ OPER.REF%TYPE) RETURN varchar2  IS
   nls_38_    accounts.NLS%type;
   nls_38_09  accounts.NLS%type;
   val_       operw.value%type;
   err        EXCEPTION;
   erm        VARCHAR2(80);
  begin
   logger.info('SPM 1 '|| TAg_ || ' '||ref_);
    if REF_ is null 
     then   begin 
               select tobopack.GetTOBOParam('VP_09') into  nls_38_09 from dual;
               nls_38_:=nls_38_09;
               return nls_38_;
            end;   
     else 
       if     tag_='B_SLK' then 
         begin 
           select nls_3800,w.value
             into nls_38_, val_
             from bank_slitky b, operw w 
            where w.ref=REF_ and w.tag=tag_ and w.value= N_SLK(b.kod) and b.branch =tobopack.GET_BRANCH;
            return nls_38_;
            EXCEPTION  WHEN NO_DATA_FOUND THEN nls_38_:=nls_38_09;
            --erm:= 'Некоректно заповнений довідник "Довідник злитків банківських металів" для '||val_; RAISE err ;
         end;
        elsif tag_='B_SLI' then  
         begin
           select nls_3800,w.value
             into nls_38_, val_
             from bank_slitky b, operw w 
            where w.ref=REF_ and w.tag=tag_ and w.value= N_SLI(b.kod) and b.branch =tobopack.GET_BRANCH;
            return nls_38_;
            EXCEPTION  WHEN NO_DATA_FOUND THEN nls_38_:=nls_38_09;
            --erm:= 'Некоректно заповнений довідник "Довідник злитків банківських металів" для '||val_; RAISE err ;
         end;     
         else 
           begin 
               select tobopack.GetTOBOParam('VP_09') into  nls_38_09 from dual;
               nls_38_:=nls_38_09;
               return nls_38_;
            end; 
       end if;
             
    end if; 
   

  exception
  WHEN err THEN raise_application_error(-(20000),erm,TRUE);
  when others then RETURN 0;

 end VP_slitky; 
 
/
 show err;
 
PROMPT *** Create  grants  VP_SLITKY ***
grant EXECUTE                                                                on VP_SLITKY       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on VP_SLITKY       to PYOD001;
grant EXECUTE                                                                on VP_SLITKY       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/vp_slitky.sql =========*** End *** 
 PROMPT ===================================================================================== 
 