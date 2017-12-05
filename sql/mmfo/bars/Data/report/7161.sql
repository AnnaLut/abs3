prompt ===================================== 
prompt == ��� �� ��������� �� ����� �������� ����������
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
   l_zpr.name := '��� �� ��������� �� ����� �������� ����������';
   l_zpr.pkey := '\brs\prvx\xxx\5505';

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
    l_zpr.name         := '��� �� ��������� �� ����� �������� ����������';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''������� ���� ������� (DD.MM.YYYY)'',:sFdat2=''��������� ���� (DD.MM.YYYY)'',:BRANCH=''�i��i�����(%-��)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep_5505.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':BRANCH=''%''';
    l_zpr.bind_sql     := ':BRANCH=''V_BRANCH_OWN|BRANCH|NAME''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select * from (select /*+ ORDERED INDEX(a) INDEX(i)*/
         a.branch,
         d.deposit_id,
         d.nd,
         d.datz,
         d.rnk,
         i.id,
         i.s SUM,
         a.acc,
         a.nls,
         a.kv,
         a.nbs,
         substr(a.nms, 1, 38) nms,
         t.lcv,
         a.daos,
         a.ostc,
         nvl(i.tt, ''%%1'') tt,
         ''DPT'' DPT
          from dpt_deposit d, accounts a, int_accn i, tabval t, dpt_vidd v
         where d.acc = a.acc
           and d.acc = i.acc
           and i.id = 1
           and a.kv = t.kv
           and d.vidd = v.vidd
           and d.branch like :BRANCH||''%''
          -- and (p_dptid = 0 or p_dptid = d.deposit_id)
           and ((i.acr_dat is null) or
               (i.acr_dat < to_date(:sFdat1,''dd.mm.yyyy'')-1 and i.stp_dat is null) or
               (i.acr_dat < to_date(:sFdat1,''dd.mm.yyyy'')-1 and i.stp_dat > i.acr_dat))
           and dpt.get_intpaydate(to_date(:sFdat2,''dd.mm.yyyy''),
                                  d.dat_begin,
                                  d.dat_end,
                                  d.freq,
                                  decode(v.amr_metr, 0, 0, 1),
                                  decode(nvl(d.cnt_dubl, 0), 0, 0, 1),
                                  1) = to_date(:sFdat1,''dd.mm.yyyy'')
           union all
           select /*+ ORDERED INDEX(a) INDEX(i)*/
         ''������ �� ���. 2630:'',
         null,
         null,
         null,
         null,
         null,
         sum(i.s) SUM,
         null,
         null,
         a.kv,
         a.nbs,
         null,
         null,
         null,
         sum(a.ostc)/100 ostc,
         null,
         ''DPT'' DPT
          from dpt_deposit d, accounts a, int_accn i, tabval t, dpt_vidd v
         where d.acc = a.acc
           and d.acc = i.acc
           and i.id = 1
           and a.kv = t.kv
           and d.vidd = v.vidd
           and d.branch like :BRANCH||''%''
          -- and (p_dptid = 0 or p_dptid = d.deposit_id)
           and a.nbs =''2630''
           and ((i.acr_dat is null) or
               (i.acr_dat < to_date(:sFdat1,''dd.mm.yyyy'')-1 and i.stp_dat is null) or
               (i.acr_dat < to_date(:sFdat1,''dd.mm.yyyy'')-1 and i.stp_dat > i.acr_dat))
           and dpt.get_intpaydate(to_date(:sFdat2,''dd.mm.yyyy''),
                                  d.dat_begin,
                                  d.dat_end,
                                  d.freq,
                                  decode(v.amr_metr, 0, 0, 1),
                                  decode(nvl(d.cnt_dubl, 0), 0, 0, 1),
                                  1) = to_date(:sFdat1,''dd.mm.yyyy'') group by a.kv, a.nbs
          union all
           select /*+ ORDERED INDEX(a) INDEX(i)*/
         ''������ ������� �������'',
         null,
         null,
         null,
         null,
         null,
         sum(i.s) SUM,
         null,
         to_char(count(a.nls)) nls,
         a.kv,
         null,
         null,
         null,
         null,
         sum(a.ostc)/100 ostc,
         null,
         ''DPT'' DPT
          from dpt_deposit d, accounts a, int_accn i, tabval t, dpt_vidd v
         where d.acc = a.acc
           and d.acc = i.acc
           and i.id = 1
           and a.kv = t.kv
           and d.vidd = v.vidd
           and d.branch like :BRANCH||''%''
          -- and (p_dptid = 0 or p_dptid = d.deposit_id)
           and ((i.acr_dat is null) or
               (i.acr_dat < to_date(:sFdat1,''dd.mm.yyyy'')-1 and i.stp_dat is null) or
               (i.acr_dat < to_date(:sFdat1,''dd.mm.yyyy'')-1 and i.stp_dat > i.acr_dat))
           and dpt.get_intpaydate(to_date(:sFdat2,''dd.mm.yyyy''),
                                  d.dat_begin,
                                  d.dat_end,
                                  d.freq,
                                  decode(v.amr_metr, 0, 0, 1),
                                  decode(nvl(d.cnt_dubl, 0), 0, 0, 1),
                                  1) = to_date(:sFdat1,''dd.mm.yyyy'') group by a.kv) order by branch, kv ';
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
