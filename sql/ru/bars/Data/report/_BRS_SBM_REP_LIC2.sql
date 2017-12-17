

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_LIC2.sql =========*** Run 
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == ������� � ����� ��� ���.  (����������� �������)
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
   l_zpr.name := '������� � ����� ��� ���.  (����������� �������)';
   l_zpr.pkey := '\BRS\SBM\REP\LIC2';

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
    l_zpr.name         := '������� � ����� ��� ���.  (����������� �������)';
    l_zpr.namef        := '= ''VPVALp''||substr(:sFdat1,1,2)||substr(:sFdat1,4,2)||''.''||user_id';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2='''',:Param0=''����� ������� (%-��i)'',:KV=''������ (0-��i)'',:BRANCH=''�i��i�����'',:DEP=''���. �i������� (1-���.)'',:INFORM=''���. i��.���i����.(1-���.)'',:NODOCS=''���. ��� ������i� (1-���.)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'sbm_lc6p.qrp';
    l_zpr.form_proc    := 'rptlic_notnbs(to_date(:sFdat1), to_date(:sFdat2) , :Param0,  :KV, 0,  bars_report.get_branch(:BRANCH,:DEP) , :INFORM)';
    l_zpr.default_vars := ':Param0=''%'',:KV=''0'',:BRANCH=''�������'',:DEP=''1'',:INFORM=''0'',:NODOCS=''0''';
    l_zpr.bind_sql     := ':BRANCH=''V_BRANCH_OWN|BRANCH|NAME''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select   '''' fio, 
       srt,  
       dksrt,
       vobsrt,
       nmk ,
       okpo,    
       acc,            
       nls,            
       v.kv,           
       lcv,            
       v.fdat,           
       dapp,           
       ostf,           
       ostfq,           
       nms,            
       s,      
       sq,     
       doss,   
       koss,   
       dossq,  
       kossq,  
       nd,     
       mfo2,    
       nb2  ,     
       nls2   ,   
       nmk2 ,  
       okpo2,   
       nazn,   
       bis,
       dosr,       
       kosr,       
       ostfr,          
       v.fdat,
       curs,
       bsum,
       paydate, 
       ref,
       nlsalt
from  v_rptlic2 v, 
          tabval t, 
         ( select  t.kv, t.fdat,  c1.bsum,    c1.rate_o curs
              from (select unique kv, fdat from tmp_licm)  t,    cur_rates c1
           where  c1.kv = t.kv  and c1.vdate  = t.fdat
      ) k          
where v.kv = t.kv and k.kv = v.kv
  and k.fdat = v.fdat 
  and nvl(v.ref, 0)  =  decode(:NODOCS, ''0'',  v.ref,   nvl(v.ref, 0) )
order by okpo, nls, v.kv, v.fdat, srt desc, dksrt, vobsrt, paydate, ref, bis,  v.fdat';
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
    l_rep.description :='������� � ����� ��� ���.  (����������� �������)';
    l_rep.form        :='frm_UniReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,TRUE';
    l_rep.ndat        :=2;
    l_rep.mask        :='VPVALp*.*';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 30; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- ������������� � ��������� ������   
    l_rep.id          := 1007;


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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_LIC2.sql =========*** End 
PROMPT ===================================================================================== 
