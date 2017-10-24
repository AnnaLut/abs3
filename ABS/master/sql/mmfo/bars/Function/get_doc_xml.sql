
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_doc_xml.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_DOC_XML (p_docid in number) return xmltype
  is
    l_xml   xmltype;
  begin
    execute immediate 'select doc_xml from barsaq.doc_export where doc_id=:p_docid'
       into l_xml
      using p_docid;
    return xmltype(l_xml.getClobVal());
  end get_doc_xml;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_doc_xml.sql =========*** End **
 PROMPT ===================================================================================== 
 