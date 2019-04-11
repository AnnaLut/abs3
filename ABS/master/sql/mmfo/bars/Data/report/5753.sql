

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_5753.sql =========*** Run 
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == ���������� �������� �������� �� �������� �� ��� ��� �����
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
   l_zpr.name := '���������� �������� �������� �� �������� �� ��� ��� �����';
   l_zpr.pkey := '\BRS\SBM\REP\5753';

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
    l_zpr.name         := '���������� �������� �������� �� �������� �� ��� ��� �����';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2='''',:Param0=''�������'',:KV=''������''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '5753.frx';
    l_zpr.form_proc    := 'bars.rptlic_nls(to_date(:sFdat1), to_date(:sFdat2), :Param0, :KV)';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select t.nd, --����� ���������
       to_char(t.datd, ''DD.MM.YYYY'') as datd, --���� ���������
       t.s*100 as s, --���� ��������
       --gl.p_ncurval(t.kv, t.s, t.datd) as sq, --���� �������� (UAH)
       t.sq*100 as sq, --���� �������� (UAH)
       t.kv, --������ ��������
       CASE WHEN t.dk = 0 THEN t.nls ELSE t.nls2 END as nls, --����� ������� ��������
       substr(CASE WHEN t.dk = 0 THEN t.mfo ELSE t.mfo2 END, 1, 6) as mfo, --��� ����� ��������
       trim(substr(CASE WHEN t.dk = 0 THEN t.nb ELSE t.nb2 END, 1, 100)) as nb, --���� ��������
       case when t.dk = 0 then t.nmk else t.nmk2 end as nmk, --������������ ��������
       case when t.dk = 0 then t.okpo else t.okpo2 end as okpo, --�����/��� ��������
       t.nazn, --����������� �������
       to_char(t.paydate, ''DD.MM.YYYY'') as paydate, --���� ���������� ��������
       to_char(t.paydate, ''HH24:MI:SS'') as paytime, --��� ��������� ��������
       null as ip_address, --ip-������ ��������
       t.nmk as nmk_main
       --f_fm_replace_symbols --��� ����� �����
  from v_rptlic2 t
 where coalesce(t.ref, 0) = decode(''0'', ''0'', t.ref, coalesce(t.ref, 0))
   and t.bis = 0
   and t.srt < 3
 order by t.nls, t.kv, t.fdat, t.srt, t.dksrt, t.vobsrt, t.paydate, t.ref, t.bis';
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
    l_rep.description :='���������� �������� �������� �� �������� �� ��� ��� �����';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',19,sFdat,sFdat2,"",TRUE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    l_rep.idf         :=null;    

    -- ������������� � ��������� ������   
    l_rep.id          := 5753;


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

exec umu.add_report2arm(5753,'$RM_DRU1');
commit;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_5753.sql =========*** End 
PROMPT ===================================================================================== 
