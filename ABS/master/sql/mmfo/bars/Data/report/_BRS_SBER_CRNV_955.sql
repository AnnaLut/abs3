prompt ===================================== 
prompt == ������ �������� ���������  ������, ���������  �� ����
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
   l_zpr.name := '������ �������� ���������  ������, ���������  �� ����';
   l_zpr.pkey := '\BRS\SBER\CRNV\955';

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
    l_zpr.name         := '������ �������� ���������  ������, ���������  �� ����';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''�_����'',:sFdat2=''��_����''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'CRNV955.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select rownum, s.* from'||nlchr||
                           '(   '||nlchr||
                           'select '||nlchr||
                           '    case a.source when ''BARS'' then ac.nls else a.nls end as nls,'||nlchr||
                           '    a.kv, '||nlchr||
                           '    case a.source when ''BARS'' then ''����'' when ''����'' then ''����'' else ''����'' end source, '||nlchr||
                           '    a.fio,'||nlchr||
                           '    a.branch, '||nlchr||
                           '    A.OST/100 ostc, '||nlchr||
                           '    a.nd,'||nlchr||
                           '    (select dv.type_name from   dpt_vidd dv where dv.vidd=d.vidd) type_name,'||nlchr||
                           '    0 narax_proc, '||nlchr||
                           '    A.OST/100 ostc_and_prc, '||nlchr||
                           '    ac.dazs '||nlchr||
                           'from '||nlchr||
                           '    bars.asvo_immobile a,'||nlchr||
                           '    bars.dpt_deposit_clos d, '||nlchr||
                           '    bars.accounts ac'||nlchr||
                           '   where '||nlchr||
                           '    a.dptid=d.deposit_id(+)'||nlchr||
                           '    and d.acc=ac.acc(+)'||nlchr||
                           '    and a.branch like sys_context(''bars_context'',''user_branch_mask'')'||nlchr||
                           '    and a.fl=3'||nlchr||
                           '    and d.ACTION_ID = 1'||nlchr||
                           '    and a.source=''BARS'''||nlchr||
                           '    and ac.dazs is not null'||nlchr||
                           '    and a.dzagr >= :sFdat1 '||nlchr||
                           '    and a.dzagr <= :sFdat2'||nlchr||
                           'ORDER BY SOURCE, A.KV,a.branch, A.FIO'||nlchr||
                           ') S';
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
    l_rep.description :='������ �������� ���������  ������, ���������  �� ����';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    l_rep.idf         :=null;    

    -- ������������� � ��������� ������   
    l_rep.id          := 955;


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
