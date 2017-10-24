
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/kikot_gettag.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.KIKOT_GETTAG (ref_ INTEGER)
   RETURN VARCHAR2
IS
   res_   VARCHAR2 (250);
BEGIN
   res_ := '';

   FOR x IN (SELECT tag, VALUE
               FROM operw
              WHERE REF = ref_
                and tag in ('IBV01','IBV02') )
   LOOP
      res_ := res_ || x.tag || '=' || x.VALUE || ';';
   END LOOP;

   RETURN res_;
END kikot_gettag;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/kikot_gettag.sql =========*** End *
 PROMPT ===================================================================================== 
 