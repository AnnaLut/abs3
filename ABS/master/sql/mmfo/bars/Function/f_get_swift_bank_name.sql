
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_swift_bank_name.sql =========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_SWIFT_BANK_NAME (p_ref in number) return varchar2
is
    l_b010 varchar(10);
    l_name varchar(100);
begin
    l_b010 := f_get_swift_country(p_ref,  2);
    
   if length(l_b010)=3 then
      BEGIN
         SELECT NVL (knb, '����� �����')
            INTO l_name
         FROM rcukru
         WHERE glb = l_b010
           and rownum=1;
      EXCEPTION
         WHEN NO_DATA_FOUND
            THEN l_name := '����� �����';
      END;
   else
      BEGIN
         SELECT NVL (NAME, '����� �����')
            INTO l_name
         FROM rc_bnk
         WHERE b010 = l_b010
           and rownum=1;
      EXCEPTION
         WHEN NO_DATA_FOUND
           THEN l_name := '����� �����';
      END;
   end if;
   
   return l_name;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_swift_bank_name.sql =========
 PROMPT ===================================================================================== 
 