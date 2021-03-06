prompt ===================================== 
prompt == ����� ������������ ������� ����� (�� �����)
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
   l_zpr.name := '����� ������������ ������� ����� (�� �����)';
   l_zpr.pkey := '\BRS\SBR\REP\5707';

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
    l_zpr.name         := '����� ������������ ������� ����� (�� �����)';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2='''',:check_ru=''1-��, 0-��''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep_5707.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':check_ru=''1''';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'SELECT (select op.nlsa from oper op where op.ref=o.refl) as nlsa,'||nlchr||
                           '         o.pdat,'||nlchr||
                           '         o.sos_change_time,'||nlchr||
                           '         o.s / 100 AS S,'||nlchr||
                           '         (SELECT 1.5 FROM DUAL) AS RKO,'||nlchr||
                           '         o.datd,'||nlchr||
                           '         o.nd'||nlchr||
                           '    FROM oper o'||nlchr||
                           '   WHERE     (pdat BETWEEN TO_DATE ( :sFdat1, ''dd.mm.yyyy'')'||nlchr||
                           '                      AND TO_DATE ( :sFdat2, ''dd.mm.yyyy'')+0.999)'||nlchr||
                           '              and(((o.tt=''OWI'' and SUBSTR (o.nlsb, 1, 4) = ''2650'' AND o.id_b = ''24175269'' AND O.MFOA<>''300465'' AND o.nazn LIKE ''��������� �����;%'' and o.sos=5) and :check_ru = 1)'||nlchr||
                           '              OR ((o.tt=''OW1'' and SUBSTR (o.nlsb, 1, 4) = ''2650'' AND o.id_b = ''24175269'' AND O.MFOA =''300465'' AND o.nazn LIKE ''��������� �����;%''and o.sos=5) and :check_ru = 0))';
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
    l_rep.description :='����� ������������ ������� ����� (�� �����)';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 50; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- ������������� � ��������� ������   
    l_rep.id          := 5707;


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
