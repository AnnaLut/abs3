

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_SAL_SNP_AUDIT.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_SAL_SNP_AUDIT ***

  CREATE OR REPLACE PROCEDURE BARS.P_SAL_SNP_AUDIT 
  ( mode_   int ,
    p_dat1  date,
    p_dat2  date,
    --branch_ varchar2,  -- p_p3
    p_p0    varchar2 default null,  -- �_� "�"
    p_p1    varchar2 default null,  -- �_� "��"
    p_p2    varchar2 default null,  -- ���
    p_p4    varchar2 default null,  -- OB22
    p_p7    varchar2 default null  -- ��� 8 ����
  ) IS

/*

06-03-2012 qwa - 104-XLS - �������� ��� ��� �� ���� 1000 ���������,
           ����� ��������� ���������� ��� ����, ����� �� �������� �� ������ ������
           ������� ���� ���������
06-01-2011 qwa-102-1000 �������� �������
               �������� �������� �� ������� ��������� ����� ��������-��������
               �������� ��� �������� ���� �������, ���� �����-�� �������� � �������
               � ������� ��������
23.08.2011 Qwa-102-1000 ������������� ��������� accm_agg_monbals �� ���� p_dat1
12.01.2011 Qwa-102-1000 �� ����������  ����� �������� ����� ���� ������������
           � �� �������  ���� ���� (096)
24.03.2010 Qwa-102-1000 ���� ������ � ���������� �����������
           � ���������������

23.03.2010 Qwa-102-1000 ������ �������� �� �������� �����
               ��� ��� ��� �� �������� �� �������
22.03.2010 Qwa-102-1000
 ������� ����� 8625 ( � ��� ���������� 2625)

19.03.2010 Qwa-102-1000
 ������ 8 �����, ��������� ��� ������� � ������ ����� ���� ������

18.03.2010 Qwa-102
  1. ��������  102 - ��������� 1000 �� ������ (�����, �� ��������� �����)
     � ���������������
     ������ 2620,2628,2630,2635,2638  ������� ������ ����� (�� ���� �������)
*/

   p constant varchar2(30) := 'P_SAL_SNP';
   dat1_  date := p_dat1;
   dat2_  date := p_dat2;
   caldt_ID_1 accm_calendar.caldt_ID%type;
   caldt_ID_2 accm_calendar.caldt_ID%type;

   nn_  number;
   l_dd number;
   MODCODE   constant varchar2(3) := 'REP';
   l_cnt    number; -- ���-�� ����-����
   -- ����� ���-�� ������:
   -- ���� �� ������ ����� ��������, ���������� �������� �������� �������
   -- ����� - ���������� ��������� �������� �������
   l_acc_threshold  number;
   --
   l_flag   integer;  -- 0/1
begin

    dat1_  := to_date  ('01.'||to_char(p_dat1,'mm.yyyy'),'dd.mm.yyyy');
    dat2_  := to_date  ('01.'||to_char(p_dat2,'mm.yyyy'),'dd.mm.yyyy');

/* ������������ ������������� */

  --if length(BRANCH_)=8  then
     -- ������������ ������������� ��������

  if    mode_ in (102,104) then
         begin
           bars_accm_sync.sync_AGG('MONBAL', dat1_);
         end;
  end if;
  commit;


if mode_ = 104 then  /* ���������  �� ������, � ���� 096 ����� ���*/
  EXECUTE IMMEDIATE 'TRUNCATE TABLE CCK_AN_TMP';
  begin
  -- bars_audit.info( 'p_sal_snp=p_dat1='||p_dat1||'p_dat2='||p_dat2);
     select caldt_ID
      into caldt_ID_1
      from accm_calendar
     where caldt_DATE=dat1_ ;
     exception when no_data_found then return;  -- ����� ���������� ���������
  end;
  begin
  select caldt_ID
      into caldt_ID_2
      from accm_calendar
     where caldt_DATE=dat2_ ;
     exception when no_data_found then return;  -- ����� ���������� ���������
  end;
 insert into CCK_AN_TMP
             (branch,nbs,kv,name1,nls,n1,n2,n3,n4,n5,zalq,zal,rezq)
 with account as (
                   select acc,branch,nbs,kv, substr(nms,1,35) nms, nls,daos
                   from accounts
                  where nbs not like '8%'
                   and  (dazs is null or dazs > p_dat1)
                   and  to_number(nbs)  in (2620,2625,2630,2635)
             --      and  mdate is null
    --and  a.branch like BRANCH_||'%'
    --and  a.branch like sys_context('bars_context','user_branch')||'%';
    --and  a.acc=s.acc(+);
                  )
 select a.branch,
         a.nbs,
         a.kv,
         --nvl(s.ob22,'00') ob22,
         a.nms,
         a.nls,
         y.ost,y.ostq,y.dos,y.dosq,y.kos,y.kosq,y.osti,y.ostiq
 from  account a,--specparam_int s,
      (select m.acc,
         sum(m.ost) ost,  sum(m.ostq) ostq,
         sum(m.dos) dos,  sum(m.dosq) dosq,
         sum(m.kos) kos,  sum(m.kosq) kosq,
         sum(m.osti) osti,sum(m.ostiq)  ostiq
       from
       (select acc,
         (decode(caldt_id, caldt_ID_1, ost+dos-kos-cudos+cukos, 0)) ost,
         (decode(caldt_id, caldt_ID_1, ostq+dosq-kosq-cudosq+cukosq, 0)) ostq,
         (decode(caldt_id, caldt_ID_2, ost -crdos +crkos, 0))  osti,
         (decode(caldt_id, caldt_ID_2, ostq-crdosq+crkosq, 0)) ostiq,
         (dos + crdos- cudos)  dos ,
         (dosq+ crdosq-cudosq) dosq ,
         (kos+  crkos -cukos)  kos ,
         (kosq+ crkosq-cukosq) kosq
       from accm_agg_monbals
       where  caldt_id  between caldt_ID_1 and caldt_ID_2
       and (dos<>0 or dosq<>0 or kos<>0 or kosq<>0 or crdos<>0 or crdosq<>0 or crkos<>0 or crkosq<>0
          or cudos<>0 or cudosq<>0 or cukos<>0 or cukosq<>0 or ost<>0 or ostq<>0 )
       ) m
      group by m.acc) y
  where  a.acc=y.acc
    and (a.daos<=p_dat2
         or (a.daos>p_dat2  and (y.ost<>0 or y.osti<>0  -- ������� �����,�� ���� ����.� ������-� �����
                                or y.dos<>0 or y.kos<>0))
         );
end if;
commit;
select count(*) into l_cnt from cck_an_tmp;
bars_audit.info('p_sal_snp_audit='||l_cnt);
Return;
end p_sal_snp_audit;
/
show err;

PROMPT *** Create  grants  P_SAL_SNP_AUDIT ***
grant EXECUTE                                                                on P_SAL_SNP_AUDIT to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_SAL_SNP_AUDIT to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_SAL_SNP_AUDIT.sql =========*** E
PROMPT ===================================================================================== 
