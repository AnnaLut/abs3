prompt =====================================
prompt == ���������� ���� ��� (�� ����, ����������)
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
   l_zpr.name := '���������� ���� ��� (�� ����, ����������)';
   l_zpr.pkey := '\BRS\SBR\DPT\152';

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
    l_zpr.name         := '���������� ���� ��� (�� ����, ����������)';
    l_zpr.namef        := 'my.txt';
    l_zpr.bindvars     := ':sdate1=''���� � (DD.MM.YYYY)'',:sdate2=''���� �� (DD.MM.YYYY)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select 
     ''� ''||to_char(to_date(:sdate1,''dd.mm.yyyy''),''dd.mm.yyyy'')||'' �� ''||to_char(to_date(:sdate2,''dd.mm.yyyy''),''dd.mm.yyyy'') as Period
    , case when (substr(bp.branch,9,6)=''000000'' or substr(bp.branch,9,6) is NULL) then ''�� �� �. ���� �� ���.''
          when  substr(bp.branch,9,6)=''000001'' then ''����������''
          when  substr(bp.branch,9,6)=''000020'' then ''��i��������''
          when  substr(bp.branch,9,6)=''000045'' then ''���������''
          when  substr(bp.branch,9,6)=''000066'' then ''����������''
          when  substr(bp.branch,9,6)=''000084'' then ''�����"������''
          when  substr(bp.branch,9,6)=''000104'' then ''���i������''
          when  substr(bp.branch,9,6)=''000124'' then ''������������''
          when  substr(bp.branch,9,6)=''000143'' then ''����������''
          when  substr(bp.branch,9,6)=''000159'' then ''�������i�����''
          when  substr(bp.branch,9,6)=''000187'' then ''���������''
          when  substr(bp.branch,9,6)=''000538'' then ''����i�����''
          when  substr(bp.branch,9,6)=''000559'' then ''�����i�����''
          when  substr(bp.branch,9,6)=''000583'' then ''������������''
          when  substr(bp.branch,9,6)=''000594'' then ''����������''
          when  substr(bp.branch,9,6)=''000614'' then ''�����������''
          when  substr(bp.branch,9,6)=''000638'' then ''������������''
          when  substr(bp.branch,9,6)=''000657'' then (case when substr(bp.branch,16,6)=''000668'' then ''����i����� (������)'' else ''����i�����'' end) 
          when  substr(bp.branch,9,6)=''000671'' then (case when substr(bp.branch,16,6)=''000638'' then ''�����i����� (��������)'' else ''�����i�����'' end)
          when  substr(bp.branch,9,6)=''000688'' then ''�������i�����''
          when  substr(bp.branch,9,6)=''000712'' then ''���i�����''
          when  substr(bp.branch,9,6)=''000726'' then (case when substr(bp.branch,16,6)=''000559'' then ''������������ (������)'' else ''������������'' end)
          when  substr(bp.branch,9,6)=''000741'' then ''����������''
          when  substr(bp.branch,9,6)=''000773'' then ''�����i�����''
          when  substr(bp.branch,9,6)=''000790'' then ''�����������''
          when  substr(bp.branch,9,6)=''000805'' then ''���i������''
          when  substr(bp.branch,9,6)=''000830'' then ''�-������������''
          when  substr(bp.branch,9,6)=''000849'' then ''�-�����������''
          when  substr(bp.branch,9,6)=''000877'' then (case when substr(bp.branch,16,6)=''000583'' then ''��������i����� (�������)'' 
                                                          when substr(bp.branch,16,6)=''000898'' then ''��������i����� (���������)'' else ''��������i�����'' end)
          when  substr(bp.branch,9,6)=''000901'' then (case when substr(bp.branch,16,6)=''000916'' then ''������i������ (���������)'' else ''������i������'' end)
          else ''''
     end as Name_TVBV
     , bp.branch as Nom_TVBV
     , sum(nvl(x.count_lim,0)) as opened_count_lim
     , sum(nvl(x.Sum_Limit,0)) as opened_Sum_lim
     , case when sum(nvl(x.count_lim,0))=0 then 0  
            else round(sum(nvl(x.Sum_Limit,0))/sum(nvl(x.count_lim,0)),2) 
       end as opened_Avg_sum_lim
     , sum(nvl(y.cl_lim     ,0)) as Closed_lim  
     
     , sum(nvl(y.SPn_lim    ,0)) as SP_count_lim
     , sum(nvl(y.VPn_lim    ,0)) as VP_count_lim
     , sum(nvl(y.ZKn_lim    ,0)) as ZK_count_lim
     , sum(nvl(y.ZBn_lim    ,0)) as ZB_count_lim
     
     , sum(nvl(y.EKNn_lim    ,0)) as EKN_count_lim
     , sum(nvl(y.STDn_lim    ,0)) as STD_count_lim
     , sum(nvl(y.PRMn_lim    ,0)) as PRM_count_lim
     
     , sum(nvl(y.INSn_lim    ,0)) as INS_count_lim
     
     , sum(nvl(y.tot_lim    ,0)) as Total_count_lim
     , sum(nvl(y.tot_sum_lim,0)) as Total_sum_lim
     , case when sum(nvl(y.tot_lim  ,0))=0 then 0  
            else round(sum(nvl(y.tot_sum_lim,0))/sum(nvl(y.tot_lim  ,0)),2)
       end as Total_Avg_sum_lim  
     , sum(nvl(y.OVR_N,0))     as OVR_N
     , sum(nvl(y.OVR_OST,0))   as OVR_OST
     , sum(nvl(y.OVR_DOS_N,0)) as OVR_DOS_N
     , sum(nvl(y.OVR_DOS,0))   as OVR_DOS       
from branch bp left join
(
select pk.branch 
     , sum( case when (nvl(abs(fost(w.acc_ovr, greatest(a3.daos,a9.daos) )),0) + nvl(abs(fost(w.acc_9129, greatest(a3.daos,a9.daos) )),0))/100>0
                 then 1 
                 else 0 end ) as Count_Lim
     , sum((nvl(abs(fost(w.acc_ovr, greatest(a3.daos,a9.daos) )),0) + nvl(abs(fost(w.acc_9129, greatest(a3.daos,a9.daos) )),0))/100) as Sum_Limit
from w4_acc w left join accounts pk on w.acc_pk=pk.acc
              left join accounts a3 on w.acc_ovr=a3.acc
              left join accounts a9 on w.acc_9129=a9.acc
where (w.dat_close is NULL or w.dat_close>to_date(:sdate2,''dd.mm.yyyy''))
  and ( w.acc_ovr is not NULL or w.acc_9129 is not NULL) 
  and (   ((a3.dazs is NULL or a3.dazs>to_date(:sdate1,''dd.mm.yyyy'')) and a3.daos<=to_date(:sdate2,''dd.mm.yyyy''))
       or
          ((a9.dazs is NULL or a9.dazs>to_date(:sdate1,''dd.mm.yyyy'')) and a9.daos<=to_date(:sdate2,''dd.mm.yyyy'')) )
  and least(nvl(a9.daos,to_date(:sdate2,''dd.mm.yyyy'')+1),nvl(a3.daos,to_date(:sdate2,''dd.mm.yyyy'')+1)) between to_date(:sdate1,''dd.mm.yyyy'') and to_date(:sdate2,''dd.mm.yyyy'')
group by pk.branch  
) x on bp.branch=nvl(x.branch,''000'')
left join
(
select pk.branch 
      , sum(case when (nvl(abs(fost(w.acc_ovr, to_date(:sdate2,''dd.mm.yyyy'') )),0) + nvl(abs(fost(w.acc_9129, to_date(:sdate2,''dd.mm.yyyy'') )),0))=0
             and (nvl(abs(fost(w.acc_ovr, to_date(:sdate1,''dd.mm.yyyy'') )),0) + nvl(abs(fost(w.acc_9129, to_date(:sdate1,''dd.mm.yyyy'') )),0))>0
            then 1
            else 0 end) as cl_lim
     
      , sum(case when (nvl(abs(fost(w.acc_ovr, to_date(:sdate2,''dd.mm.yyyy'') )),0) + nvl(abs(fost(w.acc_9129, to_date(:sdate2,''dd.mm.yyyy'') )),0))<>0 and pk.ob22=''29''
            then 1
            else 0 end) as SPn_lim 
      , sum(case when (nvl(abs(fost(w.acc_ovr, to_date(:sdate2,''dd.mm.yyyy'') )),0) + nvl(abs(fost(w.acc_9129, to_date(:sdate2,''dd.mm.yyyy'') )),0))<>0 and pk.ob22=''30''
            then 1
            else 0 end) as VPn_lim
      , sum(case when (nvl(abs(fost(w.acc_ovr, to_date(:sdate2,''dd.mm.yyyy'') )),0) + nvl(abs(fost(w.acc_9129, to_date(:sdate2,''dd.mm.yyyy'') )),0))<>0 and pk.ob22 in (''24'', ''27'')
            then 1
            else 0 end) as ZKn_lim
      , sum(case when (nvl(abs(fost(w.acc_ovr, to_date(:sdate2,''dd.mm.yyyy'') )),0) + nvl(abs(fost(w.acc_9129, to_date(:sdate2,''dd.mm.yyyy'') )),0))<>0 and pk.ob22 in (''31'', ''32'')
            then 1
            else 0 end) as ZBn_lim
      
      , sum(case when (nvl(abs(fost(w.acc_ovr, to_date(:sdate2,''dd.mm.yyyy'') )),0) + nvl(abs(fost(w.acc_9129, to_date(:sdate2,''dd.mm.yyyy'') )),0))<>0 and pk.ob22 in (''25'',''36'')
            then 1
            else 0 end) as EKNn_lim
      , sum(case when (nvl(abs(fost(w.acc_ovr, to_date(:sdate2,''dd.mm.yyyy'') )),0) + nvl(abs(fost(w.acc_9129, to_date(:sdate2,''dd.mm.yyyy'') )),0))<>0 and pk.ob22 in (''26'',''35'')
            then 1
            else 0 end) as STDn_lim
      , sum(case when (nvl(abs(fost(w.acc_ovr, to_date(:sdate2,''dd.mm.yyyy'') )),0) + nvl(abs(fost(w.acc_9129, to_date(:sdate2,''dd.mm.yyyy'') )),0))<>0 and pk.ob22 in (''28'')
            then 1
            else 0 end) as PRMn_lim
      
      , sum(case when (nvl(abs(fost(w.acc_ovr, to_date(:sdate2,''dd.mm.yyyy'') )),0) + nvl(abs(fost(w.acc_9129, to_date(:sdate2,''dd.mm.yyyy'') )),0))<>0 and pk.ob22 not in (''28'',''26'',''35'',''25'',''36'', ''31'', ''32'', ''24'', ''27'', ''30'', ''29'')
            then 1
            else 0 end) as INSn_lim      
                        
      , sum(case when (nvl(abs(fost(w.acc_ovr, to_date(:sdate2,''dd.mm.yyyy'') )),0) + nvl(abs(fost(w.acc_9129, to_date(:sdate2,''dd.mm.yyyy'') )),0))<>0
            then 1
            else 0 end) as tot_lim
      , sum(case when (nvl(abs(fost(w.acc_ovr, to_date(:sdate2,''dd.mm.yyyy'') )),0) + nvl(abs(fost(w.acc_9129, to_date(:sdate2,''dd.mm.yyyy'') )),0))<>0
            then (nvl(abs(fost(w.acc_ovr,to_date(:sdate2,''dd.mm.yyyy'') )),0) + nvl(abs(fost(w.acc_9129, to_date(:sdate2,''dd.mm.yyyy'') )),0))/100
            else 0 end) as tot_sum_lim 
      , sum(case when w.acc_ovr is NULL then 0 else case when abs(fostq(w.acc_ovr,to_date(:sdate2,''dd.mm.yyyy'')))>0 then 1 else 0 end end)  as OVR_N
      , sum(case when w.acc_ovr is NULL then 0 else abs(fostq(w.acc_ovr,to_date(:sdate2,''dd.mm.yyyy'')))/100 end)  as OVR_OST
      , sum(case when w.acc_ovr is NULL then 0 else case when abs(fdosn(a3.kv, w.acc_ovr, to_date(:sdate1,''dd.mm.yyyy''), to_date(:sdate2,''dd.mm.yyyy'')))>0 then 1 else 0 end end)  as OVR_DOS_N
      , sum(case when w.acc_ovr is NULL then 0 else abs(fdosn(a3.kv, w.acc_ovr, to_date(:sdate1,''dd.mm.yyyy''), to_date(:sdate2,''dd.mm.yyyy'')))/100 end)  as OVR_DOS                     
from w4_acc w left join accounts pk on w.acc_pk=pk.acc
              left join accounts a3 on w.acc_ovr=a3.acc
              left join accounts a9 on w.acc_9129=a9.acc
where (w.dat_close is NULL or w.dat_close>to_date(:sdate2,''dd.mm.yyyy''))
  and ( w.acc_ovr is not NULL or w.acc_9129 is not NULL) 
  and (   ((a3.dazs is NULL or a3.dazs>to_date(:sdate1,''dd.mm.yyyy'')) and a3.daos<=to_date(:sdate2,''dd.mm.yyyy''))
       or
          ((a9.dazs is NULL or a9.dazs>to_date(:sdate1,''dd.mm.yyyy'')) and a9.daos<=to_date(:sdate2,''dd.mm.yyyy'')) )
group by pk.branch  
) y on bp.branch=nvl(y.branch,''000'')
where bp.date_closed is NULL and bp.branch<>''/''
--  and bp.branch like ''%000002%''
group by bp.branch
order by bp.branch';
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
