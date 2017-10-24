prompt =====================================
prompt == DBF-�����i�� ��i�� ������i�(���i����)�� �������� ��i���i�
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
   l_zpr.name := 'DBF-�����i�� ��i�� ������i�(���i����)�� �������� ��i���i�';
   l_zpr.pkey := '\BRS\SBM\***\5053';

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
    l_zpr.name         := 'DBF-�����i�� ��i�� ������i�(���i����)�� �������� ��i���i�';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''�� ����(dd/mm/yyyy)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep5053.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select      decode(:sFdat1, ''gl.bd'',  gl.bd,  to_date(:sFdat1)   ) DATE_REP,   
            decode(f_ourmfo,''300465'',300465, to_number(a.kf))                MFO_DEP, 
            substr(c.okpo,1,10)       ZKPO_CLI,    substr(c.nmk,1,50)        NAME_CLI,   
             to_number(a.nbs)         BAL_ACC,
            substr(a.nms,1,50)       NAME_ACC,    
            a.kv        KV,
            r.r013 R013,
            a.nls NLS,
            case when fost(a.acc,   decode(:sFdat1, ''gl.bd'',  gl.bd,  to_date(:sFdat1)   )    )<0   then 1 else 2    end                                DK,  
            fost(a.acc,   decode(:sFdat1, ''gl.bd'',  gl.bd,  to_date(:sFdat1)   )  )/100   AMOUNT
      from    customer c,
              scli_r20 b,
              scli_zkp k,
              (select acc, nms, rnk, nbs ,kf,kv,nls from accounts 
                                                    where dazs is null 
                                                       or dazs>  decode(:sFdat1, ''gl.bd'',  gl.bd,  to_date(:sFdat1) ) ) a
              left join specparam r on (r.acc = a.acc)
    where a.rnk=c.rnk 
      and a.nbs=b.r020
      and ltrim(rtrim(c.okpo))=ltrim(rtrim(k.zkpo))
    group by
      decode(:sFdat1, ''gl.bd'',  gl.bd,  to_date(:sFdat1)   ),
      decode(f_ourmfo,''300465'',300465,to_number(a.kf)),
      substr(c.okpo,1,10),
      substr(c.nmk,1,50),
      to_number(a.nbs),
      substr(a.nms,1,50),
      a.kv,
      r.r013,
      a.nls,
      CASE WHEN fost(a.acc,   DECODE(:sFdat1, ''gl.bd'',  gl.bd,  TO_DATE(:sFdat1)   )    )<0   THEN 1 ELSE 2    END,
      fost(a.acc,   decode(:sFdat1, ''gl.bd'',  gl.bd,  to_date(:sFdat1)   )  )/100
    order by r.r013, 2';

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
    l_rep.description :='DBF-�����i�� ��i�� ������i�(���i����)�� �������� ��i���i�';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,TRUE';
    l_rep.ndat        :=2;
    l_rep.mask        :='*.*';
    l_rep.usearc      :=0;
    begin
        select idf into l_repfolder from reportsf where idf = 210;
    exception when no_data_found then
        l_repfolder := null;
    end;
    l_rep.idf := l_repfolder;

    -- ������������� � ��������� ������
    l_rep.id          := 5053;


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
 