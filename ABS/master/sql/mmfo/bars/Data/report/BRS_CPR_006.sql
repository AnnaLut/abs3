

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_***_CPR_006.sql =========*** Run *
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == �������� ������� � ������ �� �����
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
   l_zpr.name := '�������� ������� � ������ �� �����';
   l_zpr.pkey := '\BRS\***\CPR\006';

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
    l_zpr.name         := '�������� ������� � ������ �� �����';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2='''',:P_MASK=''����� ���-��'',:P_KV=''��� ������: 0 - ��'',:P_REG=''³��� ���: 0 - � �����.��� ����.; 1- � ����.; 2 - �� '',:P_SYS=''���-��: 1-������� (� ������), 0-�����������'',:P_BRANCH=''��� ��������'',:P_SUB=''%-� ��������� ����������''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'S-B005N.QRP ';
    l_zpr.form_proc    := 'p_rep_sal(:P_MASK,:P_BRANCH, :sFdat2)';
    l_zpr.default_vars := ':P_MASK=''%'',:P_KV=''0'',:P_REG=''0'',:P_SYS=''1''';
    l_zpr.bind_sql     := ':P_BRANCH=''V_BRANCH_OWN|BRANCH|NAME|ORDER BY BRANCH''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select v.kv, v.nbs,
       decode(sign(v.ostvd),1,0,abs(v.ostvd))/power(10,t.dig) ostvd,
       decode(sign(v.ostvd),-1,0,v.ostvd)/power(10,t.dig) ostvk,
       decode(sign(v.ostid),1,0,abs(v.ostid))/power(10,t.dig) ostid,
       decode(sign(v.ostid),-1,0,v.ostid)/power(10,t.dig) ostik,
       v.DOS/power(10,t.dig) DOS, v.KOS/power(10,t.dig) KOS,
       nms,
       :P_MASK MASKA, :P_REG REG, decode(:P_SYS,''%'',''2'',:P_SYS) PSYS
 from ( SELECT a.KV, to_number(a.nls) NBS, a.nms,
               sum(decode(b1.fdat, :sFdat1, b1.ost+b1.dos-b1.kos,0)) OSTVD,
               sum(decode(b1.fdat, :sFdat2, b1.ost, 0)) OSTID,
               sum(b1.dos) DOS, sum(b1.kos) KOS
          FROM snap_balances b1, accounts a
         WHERE b1.fdat >= :sFdat1 and b1.fdat <= :sFdat2
           and b1.kf = sys_context(''bars_context'',''user_mfo'')
           and b1.acc = a.acc
           and a.kf = b1.kf
           and (a.dazs IS NULL or a.dazs>= :sFdat1)
           and trim(a.nls) LIKE :P_MASK
           and (a.kv=:P_KV or nvl(:P_KV,0)=0)
           and (:P_SYS=''%'' or a.nbs is not NULL and :P_SYS=''1'' or a.nbs is NULL and :P_SYS=''0'')
           and a.branch like :P_BRANCH || :P_SUB
         group by a.KV, a.nls, a.nms
         ORDER BY a.kv, SUBSTR(a.nls,1,4),SUBSTR(a.nls,6,9) ) V, tabval t
 where ((:P_REG=''0'' and (v.ostvd!=0 or v.ostid!=0 or v.dos!=0 or v.kos!=0))
        or (:P_REG=''1'' and (v.dos!=0 or v.kos!=0))
        or :P_REG=''2'')
   and t.kv = v.kv';
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
    l_rep.description :='�������� ������� � ������ �� �����';
    l_rep.form        :='frm_UniReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 21; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- ������������� � ��������� ������   
    l_rep.id          := 35;


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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_***_CPR_006.sql =========*** End *
PROMPT ===================================================================================== 
