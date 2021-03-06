prompt ===================================== 
prompt == ��� ��� ���� ������������� �� ������������ ������ �� �������
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
   l_zpr.name := '��� ��� ���� ������������� �� ������������ ������ �� �������';
   l_zpr.pkey := '\brs\prvx\xxx\5504';

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
    l_zpr.name         := '��� ��� ���� ������������� �� ������������ ������ �� �������';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''���� ������� (DD.MM.YYYY)'',:sFdat2=''��������� ���� (DD.MM.YYYY)'',:BRANCH=''�i��i�����(%-��)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep_5504.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':BRANCH=''%''';
    l_zpr.bind_sql     := ':BRANCH=''V_BRANCH_OWN|BRANCH|NAME''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select d.branch, d.rnk, d.nd, a.nls, a.nbs, (a.ostc/100) ostc, d.deposit_id, d.kv,
                   dpt.get_intpaydate(:sFdat2,
                                      d.dat_begin,
                                      d.dat_end,
                                      d.freq,
                                      decode(v.amr_metr, 0, 0, 1),
                                      decode(nvl(d.cnt_dubl, 0), 0, 0, 1),
                                      1) plandate,
                   v.comproc,
                   v.limit
              from dpt_deposit d, dpt_vidd v, accounts a
             where d.vidd = v.vidd
               and d.acc = a.acc
               and d.kv = a.kv
               and d.branch like :BRANCH||''%''
              -- and p_dptid = 0 -- ���������� ��������
               and d.mfo_p is not null
               and d.nls_p is not null
               and dpt.get_intpaydate(:sFdat2,
                                      d.dat_begin,
                                      d.dat_end,
                                      d.freq,
                                      decode(v.amr_metr, 0, 0, 1),
                                      decode(nvl(d.cnt_dubl, 0), 0, 0, 1),
                                      1) between :sFdat1 and :sFdat2
              union all
select ''������ �� ���. 2638:'', null, null, null, a.nbs, sum(a.ostc)/100 ostc, null, d.kv,
                   null,
                   null,
                   null
              from dpt_deposit d, dpt_vidd v, accounts a
             where d.vidd = v.vidd
               and d.acc = a.acc
               and d.kv = a.kv
               and d.branch like :BRANCH||''%''
              -- and p_dptid = 0 -- ���������� ��������
               and d.mfo_p is not null
               and d.nls_p is not null
               and a.nbs = ''2638''
               and dpt.get_intpaydate(:sFdat2,
                                      d.dat_begin,
                                      d.dat_end,
                                      d.freq,
                                      decode(v.amr_metr, 0, 0, 1),
                                      decode(nvl(d.cnt_dubl, 0), 0, 0, 1),
                                      1) between :sFdat1 and :sFdat2 group by d.kv, a.nbs
                union all
select ''������ �������������� �� ���. 2630'', null, null, null, a.nbs, sum(a.ostc)/100 ostc, null, d.kv,
                   null,
                   null,
                   null
              from dpt_deposit d, dpt_vidd v, accounts a
             where d.vidd = v.vidd
               and d.acc = a.acc
               and d.kv = a.kv
               and d.branch like :BRANCH||''%''
              -- and p_dptid = 0 -- ���������� ��������
               and d.mfo_p is not null
               and d.nls_p is not null
               and a.nbs = ''2630''
               and dpt.get_intpaydate(:sFdat2,
                                      d.dat_begin,
                                      d.dat_end,
                                      d.freq,
                                      decode(v.amr_metr, 0, 0, 1),
                                      decode(nvl(d.cnt_dubl, 0), 0, 0, 1),
                                      1) between :sFdat1 and :sFdat2 group by d.kv, a.nbs';
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
    bars_report.print_message(l_message);   
end;                                        
/                                           
                                            
commit;                                     
