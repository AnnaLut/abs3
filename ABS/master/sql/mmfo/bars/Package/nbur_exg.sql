create or replace package NBUR_EXG
is
  
  --
  -- constants
  --
  header_vrsn  constant varchar2(64) := 'version 1.0  2017.06.23';
  
  --
  -- повертає версію заголовка пакета
  -- 
  function header_version 
     return varchar2;
  
  --
  -- повертає версію тіла пакета
  --
  function body_version
    return varchar2;
  
  --
  -- SET_DOC_LST
  --
  procedure SET_DOC_LST
  ( p_doc_lst   in     t_dictionary_list
  , p_errmsg       out varchar2
  );
  
  --
  -- EXPRT_1PB
  --
  procedure EXPRT_1PB
  ( p_clnt_id       in     nbur_exg_1pb.clnt_id%type
  , p_xml              out clob
  , p_file_nm          out varchar2
  );
  
  --
  -- IMPRT_1PB
  --
  procedure IMPRT_1PB
  ( p_xml       in out nocopy blob
  , p_errmsg       out varchar2
  );
  
  --
  -- IMPRT_1PB
  --
  procedure IMPRT_1PB
  ( p_clob          in out nocopy clob
  , p_errmsg           out varchar2
  );

end NBUR_EXG;
/

show errors

----------------------------------------------------------------------------------------------------

create or replace package body NBUR_EXG
is
  
  --
  -- constants
  --
  body_vrsn     constant varchar2(64) := 'version 1.2  2017.06.26';
  ora_dt_fmt    constant varchar2(10) := 'dd.mm.yyyy';
  xml_dt_fmt    constant varchar2(10) := 'yyyy-mm-dd';
  
  --
  -- types
  --
  
  --
  -- variables
  --
  
  -- 
  -- повертає версію заголовка пакета
  -- 
  function header_version 
     return varchar2
  is
  begin
    return 'Package '||$$PLSQL_UNIT||' header '||header_vrsn||'.';
  end header_version;
  
  --
  -- повертає версію тіла пакета
  --
  function body_version
    return varchar2
  is
  begin
    return 'Package '||$$PLSQL_UNIT||' body ' ||body_vrsn|| '.';
  end body_version;
  
  --
  -- SET_DOC_LST
  --
  procedure SET_DOC_LST
  ( p_doc_lst   in     t_dictionary_list
  , p_errmsg       out varchar2
  ) is
  /**
  <b>SET_DOC_LST</b>  - 
  %param p_doc_lst    - 
  %param p_errmsg     - 

  %version 1.0 (23/06/2017)
  %usage   
  */
    title     constant varchar2(64) := $$PLSQL_UNIT||'.SET_DOC_LST'; 
    r_1pb              nbur_exg_1pb%rowtype;
  begin
    
    case
    when ( p_doc_lst is null )
    then p_errmsg := 'p_doc_lst is null';
    when ( p_doc_lst is empty )
    then p_errmsg := 'p_doc_lst is empty';
    else
      
      bars_audit.trace( '%s: Entry with %s item(s).', title, to_char(p_doc_lst.count) );
      
      for r in p_doc_lst.first .. p_doc_lst.last
      loop -- by rows
        
        if ( ( p_doc_lst(r) is Not Null  ) and 
             ( p_doc_lst(r) is Not empty ) )
        then
          
          r_1pb := null;
          
          for c in p_doc_lst(r).first .. p_doc_lst(r).last
          loop -- by row columns
            
            if ( p_doc_lst(r)(c) is Not Null )
            then
              
              begin
                
                case p_doc_lst(r)(c).key
                when 'KF'
                then r_1pb.KF := trim(p_doc_lst(r)(c).value);
                when 'DOC_REF'
                then r_1pb.DOC_REF := to_number(trim(p_doc_lst(r)(c).value));
                when 'DOC_DT'
                then r_1pb.DOC_DT := to_date(SubStr(p_doc_lst(r)(c).value,1,10),xml_dt_fmt);
--                begin
--                  r_1pb.DOC_DT := to_date(trim(p_doc_lst(r)(c).value),xml_dt_fmt);
--                exception
--                  when others then
--                    bars_audit.error( title||': DOC_DT=>'||trim(p_doc_lst(r)(c).value) || chr(10) || sqlerrm );
--                end;
                when 'CCY_ID'
                then r_1pb.CCY_ID := to_number(trim(p_doc_lst(r)(c).value));
                when 'ACC_DB_NUM'
                then r_1pb.ACC_DB_NUM := trim(p_doc_lst(r)(c).value);
                when 'ACC_DB_NM'
                then r_1pb.ACC_DB_NM := trim(p_doc_lst(r)(c).value);
                when 'ACC_CR_NUM'
                then r_1pb.ACC_CR_NUM := trim(p_doc_lst(r)(c).value);
                when 'ACC_CR_NM'
                then r_1pb.ACC_CR_NM := trim(p_doc_lst(r)(c).value);
                when 'DOC_AMNT'
                then r_1pb.DOC_AMNT := to_number(trim(p_doc_lst(r)(c).value))*100;
                when 'DOC_DSC'
                then r_1pb.DOC_DSC := trim(p_doc_lst(r)(c).value);
                else null;
                end case;
                
              exception
                when OTHERS then
                  p_errmsg := p_errmsg || 'on row('||to_char(r)||') and column('||to_char(c)||')'|| chr(10) || sqlerrm;
              end;
              
            end if;
            
          end loop; -- by row columns
          
        end if;
        
        if ( r_1pb.DOC_REF Is Not Null )
        then
          
          r_1pb.CLNT_ID := SYS_CONTEXT('USERENV','CLIENT_IDENTIFIER');
          
          begin
            insert 
              into NBUR_EXG_1PB
            values r_1pb;
          exception
            when DUP_VAL_ON_INDEX then
              null;
          end;
          
        end if;
        
      end loop; -- by rows
      
    end case;
    
    bars_audit.trace( '%s: Exit with ( p_errmsg=%s ).', title, p_errmsg );
    
  end SET_DOC_LST;
  
  --
  -- IMPRT_1PB
  --
  procedure IMPRT_1PB
  ( p_xml       in out nocopy blob
  , p_errmsg       out varchar2
  ) is
  /**
  <b>IMPRT_1PB</b>  - імпорт даних 1-ПБ від уповноваженого банку
  %param p_xml      - 
  %param p_errmsg   - 

  %version 1.0 (23/06/2017)
  %usage   
  */
    l_clnt_id              nbur_exg_1pb.clnt_id%type;
  begin
    
    bars_audit.trace( $$PLSQL_UNIT || '.IMPRT_1PB: Entry.' );
    
    l_clnt_id := 'IMPORTED'; -- SYS_CONTEXT('USERENV','CLIENT_IDENTIFIER');
    
    begin
      
      delete NBUR_EXG_1PB
       where CLNT_ID = l_clnt_id;
      
      insert
        into NBUR_EXG_1PB
           ( KF, DOC_REF, TXN_CODE, TXN_NM, CUST_ST, CUST_CODE, CUST_NM, CLNT_ID )
      select extractValue( COLUMN_VALUE, 'DATA/KF'        ) as KF
           , extractValue( COLUMN_VALUE, 'DATA/DOC_REF'   ) as DOC_REF
           , extractValue( COLUMN_VALUE, 'DATA/TXN_CODE'  ) as TXN_CODE
           , extractValue( COLUMN_VALUE, 'DATA/TXN_NM'    ) as TXN_NM
           , extractValue( COLUMN_VALUE, 'DATA/CUST_ST'   ) as CUST_ST
           , extractValue( COLUMN_VALUE, 'DATA/CUST_CODE' ) as CUST_CODE
           , extractValue( COLUMN_VALUE, 'DATA/CUST_NM'   ) as CUST_NM
           , l_clnt_id
        from table( XMLSequence( XMLType( p_xml, NLS_CHARSET_ID('UTF8') ).extract('/EXGDOCSET/DATA') ) ) t
      ;
      
      if ( sql%rowcount > 0 )
      then
      
        begin
        
          merge
           into OPERW t
          using ( select DOC_REF   as REF
                       , 'KOD_N'   as TAG -- Код ПРИЗНАЧЕННЯ пл.(1-ПБ)
                       , TXN_CODE  as VAL
                    from NBUR_EXG_1PB
                   where CLNT_ID = l_clnt_id
                     and TXN_CODE Is Not Null
                   union all
                  select DOC_REF   as REF
                       , 'ASP_K'   as TAG -- ЗКПО клієнта ЛОРО-банку
                       , CUST_CODE as VAL
                    from NBUR_EXG_1PB
                   where CLNT_ID = l_clnt_id
                     and CUST_CODE Is Not Null
                   union all
                  select DOC_REF   as REF
                       , 'ASP_N'   as TAG -- Назва клієнта ЛОРО-банку
                       , CUST_NM   as VAL
                    from NBUR_EXG_1PB
                   where CLNT_ID = l_clnt_id
                     and CUST_NM Is Not Null
                   union all
                  select DOC_REF   as REF
                       , 'ASP_S'   as TAG -- Статус клієнта ЛОРО-банку
                       , CUST_ST   as VAL
                    from NBUR_EXG_1PB
                   where CLNT_ID = l_clnt_id
                     and CUST_ST Is Not Null
                ) s
             on ( s.REF = t.REF and s.TAG = t.TAG )
           when NOT MATCHED 
           then insert ( t.REF, t.TAG, t.VALUE )
                values ( s.REF, s.TAG, s.VAL   )
           when MATCHED 
           then update
                   set t.VALUE = s.VAL
          ;
          
          bars_audit.info( $$PLSQL_UNIT || '.IMPRT_1PB: ' || to_char(sql%rowcount) || 'row(s) merged.' );
          
        exception
          when OTHERS then
            p_errmsg := sqlerrm;
        end;
        
      else
        p_errmsg := 'XML is empty';
      end if;
      
    exception
      when OTHERS then
        p_errmsg := sqlerrm;
    end;
    
    bars_audit.trace( $$PLSQL_UNIT || '.IMPRT_1PB: Exit with ( p_errmsg=%s ).', p_errmsg );
    
  end IMPRT_1PB;
  
  --
  -- IMPRT_1PB
  --
  procedure IMPRT_1PB
  ( p_clob          in out nocopy clob
  , p_errmsg           out varchar2
  ) is
    title         constant varchar2(64) := $$PLSQL_UNIT||'.IMPRT_1PB';
    l_blob                 blob;
    l_dst_offset           integer := 1;
    l_src_offset           integer := 1;
    l_lng_context          integer := DBMS_LOB.DEFAULT_LANG_CTX;
    l_wrn                  integer; -- := DBMS_LOB.WARN_INCONVERTIBLE_CHAR;
  begin
    
    bars_audit.trace( '%s: Entry.', title );
    
--  NBUR_XML.CONVERT_CLOB_TO_BLOB
--  ( p_clob_data =>      in out nocopy clob
--  , p_blob_data =>      in out nocopy blob
--  , p_blob_csid => NLS_CHARSET_ID('UTF8') );
    
    DBMS_LOB.CREATETEMPORARY( l_blob, true );
    
    DBMS_LOB.CONVERTTOBLOB
    ( dest_lob     => l_blob
    , src_clob     => p_clob
    , amount       => DBMS_LOB.LOBMAXSIZE
    , dest_offset  => l_dst_offset
    , src_offset   => l_src_offset
    , blob_csid    => NLS_CHARSET_ID('UTF8')
    , lang_context => l_lng_context
    , warning      => l_wrn );
    
    IMPRT_1PB( p_xml    => l_blob
             , p_errmsg => p_errmsg );
    
    DBMS_LOB.FREETEMPORARY( l_blob );
    
    bars_audit.trace( '%s: Exit.', title );
    
  end IMPRT_1PB;
  
  --
  -- EXPRT_1PB
  --
  procedure EXPRT_1PB
  ( p_clnt_id       in     nbur_exg_1pb.clnt_id%type
  , p_xml              out clob
  , p_file_nm          out varchar2
  ) is
  /**
  <b>EXPRT_1PB</b>  - експорт даних 1-ПБ для уповноваженого банку
  %param p_clnt_id  - CLIENT_IDENTIFIER
  %param p_xml      - 
  %param p_file_nm  - file name

  %version 1.0 (23/06/2017)
  %usage   
  */
    title         constant varchar2(64) := $$PLSQL_UNIT||'.EXPRT_1PB'; 
    l_clnt_id              nbur_exg_1pb.clnt_id%type;
    l_rcur                 SYS_REFCURSOR;
    l_ctx                  dbms_xmlgen.ctxHandle;
  begin
    
    bars_audit.trace( '%s: Entry with ( p_clnt_id=%s ).', title, p_clnt_id );
    
    if ( p_clnt_id Is Null )
    then
      l_clnt_id := SYS_CONTEXT('USERENV','CLIENT_IDENTIFIER');
    else
      l_clnt_id := p_clnt_id;
    end if;
    
    open l_rcur 
     for select KF, DOC_REF, DOC_DT, CCY_ID, ACC_DB_NUM, ACC_DB_NM, ACC_CR_NUM, ACC_CR_NM
              , DOC_AMNT, DOC_DSC, TXN_CODE, TXN_NM, CUST_ST, CUST_CODE, CUST_NM
           from NBUR_EXG_1PB
          where CLNT_ID = l_clnt_id;
    
    l_ctx := DBMS_XMLGEN.newContext( l_rcur );
    
    DBMS_XMLGEN.setRowSetTag( l_ctx, 'EXGDOCSET' );
    DBMS_XMLGEN.setRowTag( l_ctx, 'DATA' );
    DBMS_XMLGEN.setNullHandling( l_ctx, DBMS_XMLGEN.EMPTY_TAG );
    
    p_xml := DBMS_XMLGEN.getxml( l_ctx );
    
    if ( p_xml Is Null )
    then
      p_xml := '<?xml version="1.0" encoding="utf-8" standalone="yes"?>';
      p_xml := p_xml || chr(10) || '<EXGDOCSET xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">';
      p_xml := p_xml || chr(10) || '</EXGDOCSET>';
    else
      p_xml := replace( p_xml, '<?xml version="1.0"?>', '<?xml version="1.0" encoding="utf-8" standalone="yes"?>' );
      p_xml := replace( p_xml, '<EXGDOCSET>', '<EXGDOCSET xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' );
    end if;
    
    DBMS_XMLGEN.closeContext(l_ctx);
    
    CLOSE l_rcur;
    
    delete NBUR_EXG_1PB
     where CLNT_ID = l_clnt_id;
    
    p_file_nm := '1pbdocs.xml';
    
    bars_audit.trace( '%s: Exit.', title );
    
  end EXPRT_1PB;



begin
  null;
end NBUR_EXG;
/

show errors

grant EXECUTE on NBUR_EXG to BARS_ACCESS_DEFROLE;
