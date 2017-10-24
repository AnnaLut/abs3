
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/gou_ru.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GOU_RU (id_ int) RETURN VARCHAR2 IS
 NLS_ varchar2(15);
begin

 begin
   SELECT  decode(id_, 1,a.NLS_GTD, 2,a.NLS6_GOU_GT, null)
   INTO NLS_
   FROM  alegro a, oper o
   WHERE a.MFO = o.MFOb and o.ref=gl.aREF and num not like '%/%';
 EXCEPTION WHEN OTHERS THEN  null;
 END;

 return NLS_;

end GOU_RU;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/gou_ru.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 