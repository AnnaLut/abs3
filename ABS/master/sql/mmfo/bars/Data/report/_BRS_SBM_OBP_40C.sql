

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_OBP_40C.sql =========*** Run *
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == ������� � ������� ��� way4
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
   l_zpr.name := '������� � ������� ��� way4';
   l_zpr.pkey := '\BRS\SBM\OBP\40C';

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
    l_zpr.name         := '������� � ������� ��� way4';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2='''',:p_rnk=''RNK ����.''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'dss_sum.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':p_rnk=''31609''';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select :sFdat1 dat1,:sFdat2 dat2, res.*, sum.inost,sum.outost
  from (select sum(sa.dos)/100 dos,--���� �� ���� ������
               sum(sa.kos)/100 kos,
               sum(fost(w4a.acc_pk, sa.fdat) / 100    --���� ���� �������� �� ������ �� ������������ ����, � ������ ������ ���� 2208,3570
                -decode(w4a.acc_2208,null,0,fost(w4a.acc_2208, sa.fdat)) / 100
                -decode(w4a.acc_3570,null,0,fost(w4a.acc_3570,sa.fdat)) / 100
               )dayost,
               sa.fdat
          from v_w4_accounts w4a
          left join saldoa sa
            on w4a.acc_pk = sa.ACC
           and sa.FDAT between :sFdat1 and :sFdat2
         where w4a.rnk = :p_rnk
           and w4a.daos_pk <= :sFdat2
           and (w4a.dazs_pk is null or w4a.dazs_pk >= :sFdat2)
         group by fdat
       ) res,
       (select sum(fost(w4a.acc_pk, to_date(:sFdat1, ''dd.mm.yyyy'') - 1) / 100
                    -decode(w4a.acc_2208,null,0,fost(w4a.acc_2208,to_date(:sFdat1, ''dd.mm.yyyy'') - 1)) / 100
                    -decode(w4a.acc_3570,null,0,fost(w4a.acc_3570,to_date(:sFdat1, ''dd.mm.yyyy'') - 1)) / 100
                   ) inost,
               sum(fost(w4a.acc_pk, :sFdat2) / 100
                    -decode(w4a.acc_2208,null,0,fost(w4a.acc_2208, :sFdat2)) / 100
                    -decode(w4a.acc_3570,null,0,fost(w4a.acc_3570, :sFdat2)) / 100
                   ) outost
          from v_w4_accounts w4a
                 where w4a.rnk = :p_rnk
                   and w4a.daos_pk <= :sFdat2
                   and (w4a.dazs_pk is null or w4a.dazs_pk >= :sFdat2)
         )  sum
    order by fdat     ';
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
    l_rep.description :='������� � ������� ��� way4';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 75; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- ������������� � ��������� ������   
    l_rep.id          := 4021;


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

exec umu.add_report2arm(4021,'$RM_DRU1');
commit;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_OBP_40C.sql =========*** End *
PROMPT ===================================================================================== 
