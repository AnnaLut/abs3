prompt ===================================== 
prompt == ��� �� ��������� �� ����� �������� ���������� � ��������� ���� ������� ����������� 
prompt == �� �� �������� ��������� �� ������ ����������� �������� �� ���� / �� �����
prompt ===================================== 

set serveroutput on

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
    l_zpr.bindvars     := ':sFdat2=''���� ���������� (DD.MM.YYYY)'',:BRANCH=''�i��i�����(%-��)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep_5505.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':BRANCH=''%''';
    l_zpr.bind_sql     := ':BRANCH=''V_BRANCH_OWN|BRANCH|NAME''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select  branch, deposit_id, nd, datz, okpo, id, sum, acc, nls, kv, nbs, nms, daos, ostc, tt from
        (select /*+ ORDERED INDEX(a) INDEX(i)*/
         a.branch,
         d.deposit_id,
         d.nd,
         d.datz,
         c.okpo,
         i.id,
         i.s SUM,
         a.acc,
         a.nls,
         a.kv,
         a.nbs,
         substr(a.nms, 1, 38) nms,
         a.daos,
         a.ostc/100 ostc,
         nvl(i.tt, ''%%1'') tt
          from dpt_deposit d, accounts a, int_accn i, dpt_vidd v, customer c
         where d.acc = a.acc
           and d.acc = i.acc
           and i.id = 1
           and d.vidd = v.vidd
           and d.rnk = c.rnk
           and d.branch like :BRANCH||''%''
          -- and (p_dptid = 0 or p_dptid = d.deposit_id)
           and a.nbs =''2630''
           and dpt.get_intpaydate(to_date(gl.bd, ''dd.mm.yyyy''),
                                  d.dat_begin,
                                  d.dat_end,
                                  d.freq,
                                  decode(v.amr_metr, 0, 0, 1),
                                  decode(nvl(d.cnt_dubl, 0), 0, 0, 1),
                                  1) between to_date(:sFdat2, ''dd.mm.yyyy'') and to_date(gl.bd, ''dd.mm.yyyy'')
           and (((a.ostc > 50000000 or a.ostc > 250000000) and a.kv = 980) 
           or ((a.ostc > 2000000 or a.ostc > 10000000) and a.kv != 980)) 
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
         sum(a.ostc)/100 ostc,
         null
          from dpt_deposit d, accounts a, int_accn i, dpt_vidd v, customer c
         where d.acc = a.acc
           and d.acc = i.acc
           and i.id = 1
           and d.vidd = v.vidd
           and d.rnk = c.rnk
           and d.branch like :BRANCH||''%''
          -- and (p_dptid = 0 or p_dptid = d.deposit_id)
           and a.nbs =''2630''
           and dpt.get_intpaydate(to_date(gl.bd, ''dd.mm.yyyy''),
                                  d.dat_begin,
                                  d.dat_end,
                                  d.freq,
                                  decode(v.amr_metr, 0, 0, 1),
                                  decode(nvl(d.cnt_dubl, 0), 0, 0, 1),
                                  1) between to_date(:sFdat2, ''dd.mm.yyyy'') and to_date(gl.bd, ''dd.mm.yyyy'')
           and (((a.ostc > 50000000 or a.ostc > 250000000) and a.kv = 980) 
           or ((a.ostc > 2000000 or a.ostc > 10000000) and a.kv != 980)) group by a.kv, a.nbs)';
    l_zpr.xsl_data     := '';
    l_zpr.xsd_data     := '';

    if l_isnew = 1 then           
       insert into zapros values l_zpr;  
       l_message:=l_message||'�������� ����� ���.������ �'||l_zpr.kodz||'.'; 
    else                           
       update zapros set name         = l_zpr.name,        
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
    l_rep.description :='��� �� ��������� �� ����� �������� ����������';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat,"",FALSE,FALSE';
    l_rep.ndat        :=0;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 160;
    exception when no_data_found then
        l_repfolder := null;
    end;
    l_rep.idf := l_repfolder;

    -- ������������� � ��������� ������
    l_rep.id          := 5505;


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

    begin
       Insert into BARS.APP_REP
               (CODEAPP, CODEREP, APPROVE, GRANTOR)
       Values
               ('$RM_DRU1', l_rep.id, 1, 1);
          l_message:=l_message||nlchr||'�������� ����� ��� �'||l_rep.id||' �������� � ��� ���� ����';
    exception when dup_val_on_index
          then 
          l_message:=l_message||nlchr||'�������� ����� ��� �'||l_rep.id||' ���������� � ��� ���� ����';
    end;

    begin
       Insert into BARS.APP_REP
               (CODEAPP, CODEREP, APPROVE, GRANTOR)
       Values
               ('$RM_WDPT', l_rep.id, 1, 1);
          l_message:=l_message||nlchr||'�������� ����� ��� �'||l_rep.id||' �������� � ��� �������� ��������';
    exception when dup_val_on_index
          then 
          l_message:=l_message||nlchr||'�������� ����� ��� �'||l_rep.id||' ���������� � ��� �������� ��������';
    end;

    bars_report.print_message(l_message);
end;
/

commit;