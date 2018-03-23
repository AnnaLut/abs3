

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_***_CAC_14.sql =========*** Run **
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == ����� �������� ������� �� �����   
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
   l_zpr.name := '����� �������� ������� �� �����   ';
   l_zpr.pkey := '\BRS\***\CAC\14';

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
    l_zpr.name         := '����� �������� ������� �� �����   ';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2='''',:Param0=''����� �������(%-��)'',:Param1=''����� � (0-��)'',:Param2=''��� ��.(0-��,1-�����,2-��,3-��)'',:branch=''� ���� (%-��)'',:Param3=''�������������� ������� (0-��, 1-��������������)'',:Param4=''����������(0 � �� ���������, 1 � ���������)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'JS_NDU2.qrp';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':Param0=''%'',:Param1=''0'',:Param2=''0'',:branch=''%'',:Param3=''0'',:Param4=''0''';
    l_zpr.bind_sql     := ':branch=''V_USER_BRANCHES|BRANCH|NAME''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'SELECT a.branch TOBO, p1.val boss, p2.val gl_buch,'||nlchr||
                           '       case when to_number(:Param4)>0 then a.isp else null end isp,'||nlchr||
                           '       case when to_number(:Param4)>0 then t.fio else null end fio, '||nlchr||
                           '       r.rnk, substr(r.nmk,1,70) NMK,'||nlchr||
                           '       a.nls, a.nlsalt NLSALT,  a.kv,   a.daos,r.okpo, a.dazs, substr(a.nls,1,4) nbs'||nlchr||
                           'FROM Customer r, Accounts a, Cust_acc ra, Staff t ,'||nlchr||
                           '      (select val from params where par=''BOSS'') p1,'||nlchr||
                           '      (select val from params where par=''ACCMAN'') p2'||nlchr||
                           'WHERE r.rnk=ra.rnk and a.acc=ra.acc and a.dazs is not null'||nlchr||
                           'and a.isp=t.id'||nlchr||
                           'and  a.dazs>=  :sFdat1  and a.dazs<=  :sFdat2'||nlchr||
                           'AND trim(a.nls) LIKE :Param0'||nlchr||
                           'AND trim(a.nlsalt) LIKE decode(:Param3, 0, ''%'', :Param3||''%'')'||nlchr||
                           'AND trim(a.branch) LIKE :branch||''%'''||nlchr||
                           'AND r.rnk>=to_number(:Param1) AND r.rnk<='||nlchr||
                           '             decode(to_number(:Param1),0,999999999,to_number(:Param1))'||nlchr||
                           'and r.custtype>=to_number(:Param2) AND r.custtype<='||nlchr||
                           '             decode(to_number(:Param2),0,9999,to_number(:Param2))'||nlchr||
                           'AND substr(a.nbs,1,1)<>''8'''||nlchr||
                           'ORDER BY nbs, a.isp, r.rnk, a.nls,  a.kv';
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
    l_rep.description :='����� �������� ������� �� �����   ';
    l_rep.form        :='frm_UniReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 333; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- ������������� � ��������� ������   
    l_rep.id          := 184;


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



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_***_CAC_14.sql =========*** End **
PROMPT ===================================================================================== 
