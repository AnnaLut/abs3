

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBR_REP_1111.sql =========*** Run 
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == 7.���: �������� ��������i� ��� - �Ū��� ��������  (�����,�����i+)
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
   l_zpr.name := '7.���: �������� ��������i� ��� - �Ū��� ��������  (�����,�����i+)';
   l_zpr.pkey := '\BRS\SBR\REP\1111';

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
    l_zpr.name         := '7.���: �������� ��������i� ��� - �Ū��� ��������  (�����,�����i+)';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:TEMA=''��� ����� (0-��)'',:BRANCH=''³������� (%-��)'',:PRN=''��������-0,����� ���_����-1,�����(26,27)-2,�����(38,39)-3,����� ���-����-4'',:ISP=''���.''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'ZVT7n.qrp';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':TEMA=''0'',:BRANCH=''%'',:PRN=''0'',:ISP=''0''';
    l_zpr.bind_sql     := ':TEMA=''TEST_ZVT|TEMA|NAME|ORDER BY TEMA'',:BRANCH=''BRANCH2|BRANCH|NAME|ORDER BY BRANCH''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select t.TEMA, b.BRANCH, d.isp USERID, d.KV, d.TT, d.REF, d.NLSD, d.NLSK,
     d.S S, d.SQ, b.NAME,t.name NAMET
from  branch b, TEST_ZVT t, zvt_doc d
where d.fdat = to_date( :sFdat1,''dd-mm-yyyy'')
  and ( nvl(:PRN,''0'') = ''0'' or t.PRN =:PRN )
  and b.branch = substr( d.branch,1,15)
  and t.tema =abs(d.tema )
  and t.tema = decode(:TEMA,''0'', t.tema, to_number(:TEMA))
  and b.branch like :BRANCH || decode ( length(:BRANCH), 8, '''',''%'' )
  and d.isp = decode(:ISP,''0'', d.ISP, to_number(:ISP))
order by 1, 2, 3,  sign(tema),   4, 5, 6';
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
    l_rep.description :='7.���: �������� ��������i� ��� - �Ū��� ��������  (�����,�����i+)';
    l_rep.form        :='frm_UniReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat,"",TRUE,FALSE';
    l_rep.ndat        :=1;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 80; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- ������������� � ��������� ������   
    l_rep.id          := 107;


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

exec umu.add_report2arm(107,'$RM_BUHG');
exec umu.add_report2arm(107,'$RM_DRU1');
exec umu.add_report2arm(107,'$RM_OWAY');
exec umu.add_report2arm(107,'$RM_MAIN');
exec umu.add_report2arm(107,'$RM_OPER');
exec umu.add_report2arm(107,'$RM_BVBB');
exec umu.add_report2arm(107,'$RM_BVB ');
commit;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBR_REP_1111.sql =========*** End 
PROMPT ===================================================================================== 
