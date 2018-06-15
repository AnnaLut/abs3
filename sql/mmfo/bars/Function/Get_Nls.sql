create OR replace function Get_NLS  ( p_KV int, p_B4 varchar2) return varchar2 is     nTmp_ number;     l_NLS accounts.nls%type;
begin
   While 1<2
   loop  nTmp_ := trunc(dbms_random.value(1, 999999999));       l_NLS :=p_B4||'_'||nTmp_ ;
         begin select 1 into nTmp_ from accounts where nls like l_NLS and kv = p_KV ;
         EXCEPTION WHEN NO_DATA_FOUND THEN  return vkrzn ( substr(gl.aMfo,1,5) , l_NLS ) ;
         end ;
   end loop  ;
end Get_Nls  ;
/
show err;

