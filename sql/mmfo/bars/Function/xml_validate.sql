
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/xml_validate.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.XML_VALIDATE (xml in clob,xsd in clob, base_url varchar2)
return varchar2
is language java name
'SchemaUtil.validation(oracle.sql.CLOB,oracle.sql.CLOB, java.lang.String) returns java.lang.String';
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/xml_validate.sql =========*** End *
 PROMPT ===================================================================================== 
 