

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_6010.sql =========*** Run 
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == �601 ������� 6 ���������� ��� �������� �������� ��������  - ��
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
   l_zpr.name := '�601 ������� 6 ���������� ��� �������� �������� ��������  - ��';
   l_zpr.pkey := '\BRS\SBM\REP\6010';

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
    l_zpr.name         := '�601 ������� 6 ���������� ��� �������� �������� ��������  - ��';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''������� ����������� ��� � ����� �'',:sFdat2=''��''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep6010.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select'||nlchr||
                           ' c.TYPECREDIT DATA_TYPE_NAME,'||nlchr||
                           ' c.NUMDOG NUMDOG,'||nlchr||
                           ' c.DOGDAY DOGDAY,'||nlchr||
                           ' c.ENDDAY ENDDAY,'||nlchr||
                           ' c.SUMZAGAL SUMZAGAL,'||nlchr||
                           ' c.R030 R030,'||nlchr||
                           ' c.PROCCREDIT PROCCREDIT,'||nlchr||
                           ' c.SUMPAY SUMPAY,'||nlchr||
                           ' c.PERIODBASE PERIODBASE,'||nlchr||
                           ' c.PERIODPROC PERIODPROC,'||nlchr||
                           ' c.SUMARREARS SUMARREARS,'||nlchr||
                           ' c.ARREARBASE ARREARBASE,'||nlchr||
                           ' c.ARREARPROC ARREARPROC,'||nlchr||
                           ' c.DAYBASE DAYBASE,'||nlchr||
                           ' c.DAYPROC DAYPROC,'||nlchr||
                           ' c.FACTENDDAY FACTENDDAY,'||nlchr||
                           ' c.FLAGZ FLAGZ,'||nlchr||
                           ' c.KLASS KLASS,'||nlchr||
                           ' c.RISK RISK,'||nlchr||
                           ' f_dat_lit(:sFdat1) STR_DAT1,'||nlchr||
                           ' f_dat_lit(:sFdat2) STR_DAT2,'||nlchr||
                           ' sys_context(''bars_context'',''user_branch'') branch,'||nlchr||
                           ' b.name branchname'||nlchr||
                           'from '||nlchr||
                           ' branch b,'||nlchr||
                           '(select * from  nbu_gateway.CORE_CREDIT c where REQUEST_ID in('||nlchr||
                           '      (select id from'||nlchr||
                           '      (select dat.KF, max(ID) id from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where DATA_TYPE_ID=15'||nlchr||
                           '       and (RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/''))=DECODE ((sys_context(''bars_context'',''user_branch'')),''/'',(RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/'')),(sys_context(''bars_context'',''user_branch'')))'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >= :sFdat1'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <= :sFdat2'||nlchr||
                           '       group by dat.KF)))) c,    '||nlchr||
                           '(select * from  nbu_gateway.CORE_PERSON_UO pu where REQUEST_ID in('||nlchr||
                           '      (select id from'||nlchr||
                           '      (select dat.KF, max(ID) id from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where DATA_TYPE_ID=6'||nlchr||
                           '       and (RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/''))=DECODE ((sys_context(''bars_context'',''user_branch'')),''/'',(RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/'')),(sys_context(''bars_context'',''user_branch'')))'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >= :sFdat1'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <= :sFdat2'||nlchr||
                           '       group by dat.KF)))) pu,'||nlchr||
                           '       (select * from  nbu_gateway.NBU_SESSION n where trunc(CAST(n.CREATED_AT AS DATE)) >= :sFdat1'||nlchr||
                           '       and trunc(CAST(n.CREATED_AT AS DATE)) <= :sFdat2) n'||nlchr||
                           'where'||nlchr||
                           'b.branch = sys_context(''bars_context'',''user_branch'')'||nlchr||
                           'and c.rnk=pu.rnk'||nlchr||
                           'and n.OBJECT_ID=c.LOAN_OBJECT_ID'||nlchr||
                           'and n.STATE_ID=9'||nlchr||
                           '';
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
    l_rep.description :='�601 ������� 6 ���������� ��� �������� �������� ��������  - ��';
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
    l_rep.id          := 6010;


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

exec umu.add_report2arm(6010,'$RM_F601');
commit;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_6010.sql =========*** End 
PROMPT ===================================================================================== 
