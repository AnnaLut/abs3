prompt =====================================
prompt == ����� - �������� �i���i��� �� �I���� (� �����������, ������i�.)
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
   l_zpr.name := '����� - �������� �i���i��� �� �I���� (� �����������, ������i�.)';
   l_zpr.pkey := '\BRS\SBR\REP\00002';

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
    l_zpr.name         := '����� - �������� �i���i��� �� �I���� (� �����������, ������i�.)';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':Param0=''����'',:Param1=''���/0-��i'',:Param2=''��_�_(%)-��i'',:Param3=''��_��(%)-��i'',:Param4=''���_������(%)-��i'',:Param5=''0=��/1=��''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := 'P_SALZO_SNP ( to_date(:Param0,''dd.mm.yyyy''), to_number(:Param1), :Param2, :Param3, :Param4 )';
    l_zpr.default_vars := ':Param1=''0'',:Param2=''%'',:Param3=''%'',:Param4=''%'',:Param5=''1''';
    l_zpr.bind_sql     := ':Param4=''BRANCH|BRANCH|NAME|WHERE length(branch)>=8''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'SELECT TO_NUMBER (:Param5) PR4,
 :Param1 PR0,
 :Param2 PR1, 
 :Param3 PR2,
 :Param4 PR3,
       substr(nbs,1,1) RZ,
       NBS , KV, NLS, pr ISP, name1 NMS,
       decode(sign(n2),-1,-n1,0 ) VOSTD, 
       decode(sign(n2),-1, 0 ,n1) VOSTK, 
       decode(sign(n2),-1,-n2,0)  VOSTDQ, 
       decode(sign(n2),-1, 0 ,n2) VOSTKQ,  
       n3 DOS, n4 DOSQ, n5 KOS, prs KOSQ,
       decode(sign(zalq),-1,-zal,0)  OSTD, 
       decode(sign(zalq),-1,0, zal)  OSTK, 
       decode(sign(zalq),-1,-zalQ,0)  OSTDQ, 
       decode(sign(zalq),-1,0, zalq)  OSTKQ         
from CCK_AN_TMP ORDER BY nbs, kv, substr(nls,6,9)';
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


 