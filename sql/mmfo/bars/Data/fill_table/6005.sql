

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_6005.sql =========*** Run 
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == �601 ������� 1 ���������� ��� �������� - ��
prompt ===================================== 

set serveroutput on
set feed off       
declare                               

   nlchr       char(2):=chr(13)||chr(10);
   l_zpr       zapros%rowtype;    
   l_zprr      zapros%rowtype;    
   l_rep       reports%rowtype;   
   l_repfolder number;            
   l_isnew     smallint:=0;       
   l_isnewr    smallint:=0;       
   l_message   varchar2(1000);    

begin     
   l_zpr.name := '�601 ������� 1 ���������� ��� �������� - ��';
   l_zpr.pkey := '\BRS\SBM\REP\6005';

   l_message  := '���� �������: '||l_zpr.pkey||'  '||nlchr;

   begin                                                   
      select kodz, kodr into l_zpr.kodz, l_zpr.kodr        
      from zapros where pkey=l_zpr.pkey;                   
   exception when no_data_found then                       
      l_isnew:=1;                                          
      select s_zapros.nextval into l_zpr.kodz from dual;   
      if (0>0) then                  
         select s_zapros.nextval into l_zpr.kodr from dual;
         l_zprr.kodz:=l_zpr.kodr;           
      end if;                               
   end;                                     
                                            

    ------------------------    
    --  main query        --    
    ------------------------    
                                
    l_zpr.id           := 1;
    l_zpr.name         := '�601 ������� 1 ���������� ��� �������� - ��';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''�������� ����������� ��� � ����� �'',:sFdat2=''��''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep6005.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select'||nlchr||
                           'c.lastname || '' '' || c.firstname || '' '' || c.middlename as fio,'||nlchr||
                           '       c.birthday as birthday,'||nlchr||
                           '       d.seriya||'' ''||d.nomerd as pasp,'||nlchr||
                           '       d.dtd as pasp_date,'||nlchr||
                           '       null as education,'||nlchr||
                           '       c.inn inn,'||nlchr||
                           '       f.codregion codregion,'||nlchr||
                           '       trim(f.area||'' ''||f.zip||'' ''||f.city||'' ''||f.streetAddress||'' ''||f.houseNo||'' ''||f.adrKorp||'' ''||f.flatno) as adress,'||nlchr||
                           '       c.isrez isrez,'||nlchr||
                           '       c.countrycodnerez countrycodnerez,'||nlchr||
                           '       o.namew namew,'||nlchr||
                           '       o.codedrpou codedrpou,'||nlchr||
                           '       p.real6month real6month,'||nlchr||
                           '       p.noreal6month noreal6month,'||nlchr||
                           '       fam.status_f status_f,'||nlchr||
                           '       fam.members members,'||nlchr||
                           '       c.k060 k060,'||nlchr||
                           '       c.iskr iskr,'||nlchr||
                           '       f_dat_lit(:sFdat1) STR_DAT1,'||nlchr||
                           '       f_dat_lit(:sFdat2) STR_DAT2,'||nlchr||
                           '       sys_context(''bars_context'',''user_branch'') branch,'||nlchr||
                           '       b.name branchname'||nlchr||
                           'from '||nlchr||
                           '(select * from  nbu_gateway.CORE_CREDIT cr where REQUEST_ID in ('||nlchr||
                           '       (select id from'||nlchr||
                           '       (select dat.KF, max(ID) id from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where DATA_TYPE_ID=15'||nlchr||
                           '       and (RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/''))=DECODE ((sys_context(''bars_context'',''user_branch'')),''/'',(RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/'')),(sys_context(''bars_context'',''user_branch'')))'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >= :sFdat1'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <= :sFdat2'||nlchr||
                           '       group by dat.KF)))) cr,'||nlchr||
                           '(select * from  nbu_gateway.core_person_fo c where REQUEST_ID in('||nlchr||
                           '       (select id from'||nlchr||
                           '       (select dat.KF, max(ID) id from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where DATA_TYPE_ID=1'||nlchr||
                           '       and (RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/''))=DECODE ((sys_context(''bars_context'',''user_branch'')),''/'',(RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/'')),(sys_context(''bars_context'',''user_branch'')))'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >= :sFdat1'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <= :sFdat2'||nlchr||
                           '       group by dat.KF)))) c,'||nlchr||
                           '(select * from  nbu_gateway.core_document_fo d  where REQUEST_ID in('||nlchr||
                           '       (select id from'||nlchr||
                           '       (select dat.KF, max(ID) id from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where DATA_TYPE_ID=2'||nlchr||
                           '       and (RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/''))=DECODE ((sys_context(''bars_context'',''user_branch'')),''/'',(RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/'')),(sys_context(''bars_context'',''user_branch'')))'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >= :sFdat1'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <= :sFdat2'||nlchr||
                           '       group by dat.KF)))) d,'||nlchr||
                           '(select * from  nbu_gateway.core_address_fo f where REQUEST_ID in('||nlchr||
                           '       (select id from'||nlchr||
                           '       (select dat.KF, max(ID) id from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where DATA_TYPE_ID=3'||nlchr||
                           '       and (RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/''))=DECODE ((sys_context(''bars_context'',''user_branch'')),''/'',(RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/'')),(sys_context(''bars_context'',''user_branch'')))'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >= :sFdat1'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <= :sFdat2'||nlchr||
                           '       group by dat.KF)))) f,'||nlchr||
                           '(select * from  nbu_gateway.core_profit_fo p where REQUEST_ID in('||nlchr||
                           '       (select id from'||nlchr||
                           '       (select dat.KF, max(ID) id from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where DATA_TYPE_ID=4'||nlchr||
                           '       and (RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/''))=DECODE ((sys_context(''bars_context'',''user_branch'')),''/'',(RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/'')),(sys_context(''bars_context'',''user_branch'')))'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >= :sFdat1'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <= :sFdat2'||nlchr||
                           '       group by dat.KF)))) p,'||nlchr||
                           '(select * from nbu_gateway.core_family_fo fam where REQUEST_ID in('||nlchr||
                           '       (select id from'||nlchr||
                           '       (select dat.KF, max(ID) id from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where DATA_TYPE_ID=5'||nlchr||
                           '       and (RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/''))=DECODE ((sys_context(''bars_context'',''user_branch'')),''/'',(RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/'')),(sys_context(''bars_context'',''user_branch'')))'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >= :sFdat1'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <= :sFdat2'||nlchr||
                           '       group by dat.KF)))) fam,'||nlchr||
                           'branch b,'||nlchr||
                           'nbu_gateway.core_organization_fo o,'||nlchr||
                           '(select * from  nbu_gateway.NBU_SESSION n where trunc(CAST(n.CREATED_AT AS DATE)) >= :sFdat1'||nlchr||
                           'and trunc(CAST(n.CREATED_AT AS DATE)) <= :sFdat2) n'||nlchr||
                           'where'||nlchr||
                           'b.branch = sys_context(''bars_context'',''user_branch'')'||nlchr||
                           'and c.rnk(+) = cr.rnk'||nlchr||
                           'and f.rnk(+) = cr.rnk '||nlchr||
                           'and o.rnk(+) = cr.rnk'||nlchr||
                           'and p.rnk(+) = cr.rnk'||nlchr||
                           'and fam.rnk(+) = cr.rnk'||nlchr||
                           'and d.rnk(+) = cr.rnk'||nlchr||
                           'and n.OBJECT_ID=cr.LOAN_OBJECT_ID'||nlchr||
                           'and n.STATE_ID=9';
    l_zpr.xsl_data     := '';
    l_zpr.xsd_data     := '';

    if l_isnew = 1 then           
       insert into zapros values l_zpr;  
       l_message:=l_message||'�������� ����� ���.������ �'||l_zpr.kodz||'.'; 
    else                           
       update zapros set name         = l_zpr.name,        
                         namef        = l_zpr.namef,       
                         bindvars     = l_zpr.bindvars,    
                         create_stmt  = l_zpr.create_stmt, 
                         rpt_template = l_zpr.rpt_template,
                         form_proc    = l_zpr.form_proc,   
                         default_vars = l_zpr.default_vars,
                         bind_sql     = l_zpr.bind_sql,    
                         xml_encoding = l_zpr.xml_encoding,
                         txt          = l_zpr.txt,         
                         xsl_data     = l_zpr.xsl_data,    
                         xsd_data     = l_zpr.xsd_data     
       where pkey=l_zpr.pkey;                              
       l_message:=l_message||'���.������ c ����� ������ ��� ���������� ��� �'||l_zpr.kodz||', ��� ��������� ��������.'; 
                                                           
    end if;                                                

    ------------------------    
    --  report            --    
    ------------------------    
                                

    l_rep.name        :='Empty';
    l_rep.description :='�601 ������� 1 ���������� ��� �������� - ��';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 99; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- ������������� � ��������� ������   
    l_rep.id          := 6005;


    if l_isnew = 1 then                     
       begin                                
          insert into reports values l_rep;        
          l_message:=l_message||nlchr||'�������� ����� ���. ����� ��� �'||l_rep.id;
       exception when dup_val_on_index then  
           bars_error.raise_error('REP',14, to_char(l_rep.id));
       end;                                    
    else                                            
       begin                                        
          insert into reports values l_rep;         
          l_message:=l_message||nlchr||'�������� ����� ���. ����� ��� �'||l_rep.id;
       exception when dup_val_on_index then         
          l_message:=l_message||nlchr||'�������� ����� ��� �'||l_rep.id||' �������.';
          update reports set                
             name        = l_rep.name,       
             description = l_rep.description,
             form        = l_rep.form,       
             param       = l_rep.param,      
             ndat        = l_rep.ndat,       
             mask        = l_rep.mask,       
             usearc      = l_rep.usearc,     
             idf         = l_rep.idf         
          where id=l_rep.id;                 
       end;                                  
    end if;                                  
    bars_report.print_message(l_message);   
end;                                        
/                                           
                                            
commit;                                     

exec umu.add_report2arm(6005,'$RM_F601');
commit;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_6005.sql =========*** End 
PROMPT ===================================================================================== 
