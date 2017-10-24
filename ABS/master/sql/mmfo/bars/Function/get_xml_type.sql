create or replace function BARS.GET_XML_TYPE
( p_file_code     in     nbur_ref_files.file_code%type
) return xmltype
DETERMINISTIC
is
  title       constant  varchar2(60) := $$PLSQL_UNIT||'.SET_RPT_PARM';
  l_rpt_dt              nbur_lst_files.report_date%type;
  l_kf                  nbur_lst_files.kf%type;
  l_vrsn_id             nbur_lst_files.version_id%type;
  l_XmlType             xmltype;
begin
  
  bars_audit.trace( '%s: Entry with ( p_file_code=% ).'
                  , title,  p_file_code );
  
  l_rpt_dt  := NBUR_XML.GET_RPT_DT();
  l_kf      := NBUR_XML.GET_KF();
  l_vrsn_id := NBUR_XML.GET_VRSN_ID();
  
  bars_audit.trace( '%s: l_rpt_dt=%s, l_kf=%s, vrsn_id=%s.'
                  , title, to_char(l_rpt_dt,'dd/mm/yyyy'), l_kf, to_char(l_vrsn_id) );
  
  select XMLType( lf.FILE_BODY )
    into l_XmlType
    from BARS.NBUR_LST_FILES lf
    join BARS.NBUR_REF_FILES rf
      on ( rf.ID = lf.FILE_ID )
   where lf.REPORT_DATE = l_rpt_dt
     and lf.KF          = l_kf
     and lf.VERSION_ID  = l_vrsn_id
     and lf.FILE_STATUS = 'FINISHED'
     and rf.FILE_CODE   = p_file_code
  ;
  
  return l_XmlType;
  
end GET_XML_TYPE;
/

show err

GRANT EXECUTE ON BARS.GET_XML_TYPE TO BARS_ACCESS_DEFROLE;
