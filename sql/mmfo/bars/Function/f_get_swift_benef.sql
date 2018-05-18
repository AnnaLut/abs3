CREATE OR REPLACE function BARS.f_get_swift_benef(p_ref in number) return varchar2 
is
    l_benef   varchar2(200) := null;
begin
   BEGIN
      SELECT trim(value)
         INTO l_benef
      FROM OPERW
      WHERE REF=p_ref
        AND TAG LIKE '59F%'
        AND ROWNUM=1;

   EXCEPTION WHEN NO_DATA_FOUND THEN
      null;
   END;
    
   return l_benef;
end;
/
