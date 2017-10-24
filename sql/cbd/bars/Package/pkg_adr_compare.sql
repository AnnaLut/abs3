create or replace package body PKG_ADR_COMPARE is
  g_body_version constant varchar2(64) := 'version 30/11/2016';
  g_dbgcode      constant varchar2(12) := 'ADR_IMPORT.';
  g_modcode      constant varchar2(3) := 'ADR';

  --���������� ������ � REGIONS_MATCH
  procedure INS_REGIONS_MATCH(p_DOMAIN    in REGIONS_MATCH.DOMAIN%type,        --������ �������� (������)
                              p_region_id in REGIONS_MATCH.REGION_ID%type) is  --����� �������� (�����)
    l_th constant varchar2(100) := g_dbgcode || 'INS_REGIONS_MATCH';
  begin
    bars_audit.trace('%s: entry point', l_th);
    insert into REGIONS_MATCH
      (domain, region_id)
    values
      (p_DOMAIN, p_region_id);

    bars_audit.info(bars_msg.get_msg(p_modcode => g_modcode,
                                     p_msgcode => 'REGIONS_MATCH_CREATED',
                                     p_param1  => p_DOMAIN,
                                     p_param2  => p_region_id));
    logger.trace('%s: done', l_th);
  end;

  --�������� ������ � REGIONS_MATCH
  procedure DEL_REGIONS_MATCH(p_DOMAIN    in REGIONS_MATCH.DOMAIN%type) is
    l_th constant varchar2(100) := g_dbgcode || 'DEL_REGIONS_MATCH';
  begin
    bars_audit.trace('%s: entry point', l_th);
    DELETE FROM REGIONS_MATCH
     WHERE domain = p_DOMAIN;
    bars_audit.info(bars_msg.get_msg(p_modcode => g_modcode,
                                     p_msgcode => 'REGIONS_MATCH_DELETED',
                                     p_param1  => p_DOMAIN));
    logger.trace('%s: done', l_th);
  end;

  --���������� ������ � AREAS_MATCH
  procedure INS_AREAS_MATCH(p_domain  in AREAS_MATCH.DOMAIN%type,
                            p_region  in AREAS_MATCH.REGION%type,        --������ �������� (������)
                            p_area_id in AREAS_MATCH.AREA_ID%type) is    --����� �������� (�����)
    l_th constant varchar2(100) := g_dbgcode || 'INS_AREAS_MATCH';
  begin
    bars_audit.trace('%s: entry point', l_th);
    insert into AREAS_MATCH (domain, region, area_id) values (p_domain,p_region, p_area_id);

    bars_audit.info(bars_msg.get_msg(p_modcode => g_modcode,
                                     p_msgcode => 'AREAS_MATCH_CREATED',
                                     p_param1  => p_domain,
                                     p_param2  => p_region,
                                     p_param3  => p_area_id));
    logger.trace('%s: done', l_th);
  end;

  --�������� ������ � AREAS_MATCH
  procedure DEL_AREAS_MATCH(p_domain  in AREAS_MATCH.DOMAIN%type,
                            p_region  in AREAS_MATCH.REGION%type) is
    l_th constant varchar2(100) := g_dbgcode || 'DEL_AREAS_MATCH';
  begin
    bars_audit.trace('%s: entry point', l_th);
    DELETE FROM AREAS_MATCH
     WHERE (DOMAIN = p_domain or p_domain is null)
       and region = p_region;
    bars_audit.info(bars_msg.get_msg(p_modcode => g_modcode,
                                     p_msgcode => 'AREAS_MATCH_DELETED',
                                     p_param1  => p_domain,
                                     p_param2  => p_region
                                     )
                   );
    logger.trace('%s: done', l_th);
  END;

  --���������� ������ � SETTLEMENTS_MATCH
  procedure INS_SETTLEMENTS_MATCH(p_domain         in SETTLEMENTS_MATCH.REGION%type,
                                  p_region         in SETTLEMENTS_MATCH.AREA%type,
                                  p_locality       in SETTLEMENTS_MATCH.LOCALITY%type,              --������ �������� (������)
                                  p_settlements_id in SETTLEMENTS_MATCH.SETTLEMENTS_ID%type) is     --����� �������� (�����)
    l_th constant varchar2(100) := g_dbgcode || 'INS_SETTLEMENTS_MATCH';
  begin
    bars_audit.trace('%s: entry point', l_th);
    insert into SETTLEMENTS_MATCH
      (region , area ,locality, settlements_id)
    values
      (p_domain, p_region, p_locality, p_settlements_id);

    bars_audit.info(bars_msg.get_msg(p_modcode => g_modcode,
                                     p_msgcode => 'SETTLEMENTS_MATCH_CREATED',
                                     p_param1  => p_domain,
                                     p_param2  => p_region,
                                     p_param3  => p_locality,
                                     p_param4  => p_settlements_id));
    logger.trace('%s: done', l_th);
  end;

  --�������� ������ � SETTLEMENTS_MATCH
  procedure DEL_SETTLEMENTS_MATCH(p_domain         in SETTLEMENTS_MATCH.REGION%type,
                                  p_region         in SETTLEMENTS_MATCH.AREA%type,
                                  p_locality       in SETTLEMENTS_MATCH.LOCALITY%type) is
    l_th constant varchar2(100) := g_dbgcode || 'DEL_SETTLEMENTS_MATCH';
  begin
    bars_audit.trace('%s: entry point', l_th);
    DELETE FROM SETTLEMENTS_MATCH
     WHERE (region  = p_domain or p_domain is null)
       and (area    = p_region or p_region is null)
       and locality = p_locality;
    bars_audit.info(bars_msg.get_msg(p_modcode => g_modcode,
                                     p_msgcode => 'SETTLEMENTS_MATCH_DELETED',
                                     p_param1  => p_domain,
                                     p_param2  => p_region,
                                     p_param3  => p_locality));
    logger.trace('%s: done', l_th);
  end;
  
    --���������� ������ � STREETS_MATCH
  procedure     INS_STREETS_MATCH(p_domain         in STREETS_MATCH.REGION%type,
                                  p_region         in STREETS_MATCH.AREA%type,
                                  p_locality       in STREETS_MATCH.SETTLEMENTS%type,
                                  p_street         in STREETS_MATCH.STREET%type,             --������ �������� (������)
                                  p_street_id      in STREETS_MATCH.STREET_ID%type) is       --����� �������� (�����)
    l_th constant varchar2(100) := g_dbgcode || 'INS_STREETS_MATCH';
  begin
    bars_audit.trace('%s: entry point', l_th);
    insert into STREETS_MATCH
      (region, area, settlements , street ,street_id)
    values
      (p_domain, p_region, p_locality, p_street, p_street_id);

    bars_audit.info(bars_msg.get_msg(p_modcode => g_modcode,
                                     p_msgcode => 'STREETS_MATCH_CREATED',
                                     p_param1  => p_domain,
                                     p_param2  => p_region,
                                     p_param3  => p_locality,
                                     p_param4  => p_street,
                                     p_param5  => p_street_id));
    logger.trace('%s: done', l_th);
  end;

  --�������� ������ � STREETS_MATCH
  procedure     DEL_STREETS_MATCH(p_domain         in STREETS_MATCH.REGION%type,
                                  p_region         in STREETS_MATCH.AREA%type,
                                  p_locality       in STREETS_MATCH.SETTLEMENTS%type,
                                  p_street         in STREETS_MATCH.STREET%type) is
    l_th constant varchar2(100) := g_dbgcode || 'DEL_STREETS_MATCH';
  begin
    bars_audit.trace('%s: entry point', l_th);
    DELETE FROM STREETS_MATCH
     WHERE (region  = p_domain or p_domain is null)
       and (area    = p_region or p_region is null)
       and (settlements    = p_region or p_region is null)
       and street  = p_street;
    bars_audit.info(bars_msg.get_msg(p_modcode => g_modcode,
                                     p_msgcode => 'STREETS_MATCH_DELETED',
                                     p_param1  => p_domain,
                                     p_param2  => p_region,
                                     p_param3  => p_locality,
                                     p_param4  => p_street));
    logger.trace('%s: done', l_th);
  end;
  
  


  --������ ������� (�� �������/�� �����/�� ������)
  procedure SET_REGION is
    l_th constant varchar2(100) := g_dbgcode || 'SET_REGION';
  begin
    bars_audit.trace('%s: entry point', l_th);

    begin
    ------------------------------------------------------------
    update CUSTOMER_ADDRESS a set a.region_id =
      (
      with t as (select
           1 gf,
           r.region_id,
           r.region_name,
           case  r.region_id
            when  1   then '²�%'
            when  2   then '���%'
            when  3   then '�Ͳ%'
            when  4   then '���%'
            when  5   then '���%'
            when  6   then '���%'
            when  7   then '���%'
            when  8   then '���%'
            when  9   then '��_�'
            when  10  then '��_����%'
            when  11  then 'ʲ�%'
            when  12  then '����%'
            when  13  then '���%'
            when  14  then '���%'
            when  15  then '���%'
            when  16  then '���%'
            when  17  then '�����%'
            when  18  then 'в�%�%'
            when  19  then '���%'
            when  20  then '���%'
            when  21  then '���%'
            when  22  then '���%'
            when  23  then '���%'
            when  24  then '���%'
            when  25  then '����%'
            when  26  then '����_�%'
            when  27  then '����_�%'

           end UKR,
           case  r.region_id
             when  1   then '���%'
             when  2   then '���%'
             when  3   then '���%'
             when  4   then '���%'
             when  5   then '���%'
             when  6   then '���%'
             when  7   then '���%'
             when  8   then '���%'
             when  9   then '��_�'
             when  10  then '��_���%'
             when  11  then '���%'
             when  12  then '����%'
             when  13  then '���%'
             when  14  then '���%'
             when  15  then '���%'
             when  16  then '���%'
             when  17  then '����%'
             when  18  then '���%�%'
             when  19  then '���%'
             when  20  then '���%'
             when  21  then '���%'
             when  22  then '���%'
             when  23  then '���%'
             when  24  then '���%'
             when  25  then '����%'
             when  26  then '����_�%'
             when  27  then '����_�%'
             end RUS
             from ADR_REGIONS r)
        select min(t.region_id)
        from t where ((TRANSLATE(upper(a.domain), 'ETYUIOPAHKXCBM', '���Ȳ���������')) like '%'||t.ukr and t.ukr is not null and ((TRANSLATE(upper(a.locality), 'ETYUIOPAHKXCBM', '���Ȳ���������')) not like '%��_�' or a.locality is null) and t.ukr not like '��_�' and upper(a.locality) not like '%Ȍ�%' )  --������������ �� ���������� ��� ����� ����� � �������� �������
                  or ((TRANSLATE(upper(a.domain), 'ETYUIOPAHKXCBM', '���Ȳ���������')) like '%'||t.RUS and t.rus is not null and ((TRANSLATE(upper(a.locality), 'ETYUIOPAHKXCBM', '���Ȳ���������')) not like '%��_�' or a.locality is null) and t.rus not like '��_�' and upper(a.locality) not like '%Ȍ�%')   --������������ �� ������� ��� ����� ����� � �������� �������
                  or (t.ukr like '��_�' and ((TRANSLATE(upper(a.locality), 'ETYUIOPAHKXCBM', '���Ȳ���������')) like '%��_�' or  upper(a.locality) like '%Ȍ�%')) --   ����   ������������ ������ �� ������
        group by t.gf having count(t.gf)=1 --���� ����������� ��� � ������ ��������, �� ������ �� ����������
        ) --����������� �� DOMAIN
    where a.country=804
      and a.region_id is null;

    update CUSTOMER_ADDRESS a set a.region_id =
      ( select DM.REGION_ID from REGIONS_MATCH DM where DM.DOMAIN = a.domain
      ) --����������� �� DOMAIN_MATCH
    where a.country=804
      and a.region_id is null
      and a.domain is not null;
    ----------------------------------------------------------------
      update CUSTOMER_ADDRESS a set (a.region_id, a.area_id) =
          (
        ---���� ������ ���� ����� ���� � �������  (������ ������������)
        select min(region_id), min(area_id) from (
           select 1 gf, t.region_id, t.area_id, t.area_name, t.area_name_ru from ADR_AREAS t
           ) w
        where upper(w.area_name)   =  (TRANSLATE(/*upper( */ /*initcap(*/REGEXP_REPLACE (TRIM (upper(a.region)),'(\,|\.|�����$|�-�\.|�-�)',''/*))*/   ), 'ETYUIOPAHKXCBM', '���Ȳ���������'))||' �-�'
           or upper(w.area_name_ru) = (TRANSLATE(/*upper( */ /*initcap(*/REGEXP_REPLACE (TRIM (upper(a.region)),'(\,|\.|�����$|�-�\.|�-�)',''/*)) */  ), 'ETYUIOPAHKXCBM', '���Ȳ���������'))||' �-�'
        group by  w.gf
        having count(w.gf)=1

          ) --����������� �� SETTLEMENTS
        where a.country=804
          and a.region_id is null
          and a.region is not null;

---------------------------------------------------------------------------------------------------------------------------------

    update CUSTOMER_ADDRESS a set (a.region_id, a.area_id)  =
      (
      ---���� ��������� ����� ������ � ������, �� ��� �� ����� ���, ��� � � ����� ������� (���� ����������� ������ (��� ������� �� ���������� ������), �� ��� ����� �����)
    select min(region_id), min(area_id) from (
       select 1 gf, t.region_id, t.area_id, t.area_name, t.area_name_ru from ADR_AREAS t where t.region_id= (select AR.region_id from v_adr_regions AR where AR.MFO = sys_context('bars_gl', 'mfo'))
       ) w
    where upper(w.area_name)   =  (TRANSLATE(/*upper( */ /*initcap(*/REGEXP_REPLACE (TRIM (upper(a.region)),'(\,|\.|�����$|�-�\.|�-�)',''/*))*/   ), 'ETYUIOPAHKXCBM', '���Ȳ���������'))||' �-�'
       or upper(w.area_name_ru) = (TRANSLATE(/*upper( */ /*initcap(*/REGEXP_REPLACE (TRIM (upper(a.region)),'(\,|\.|�����$|�-�\.|�-�)',''/*))*/   ), 'ETYUIOPAHKXCBM', '���Ȳ���������'))||' �-�'
    group by  w.gf
    having count(w.gf)=1 and sys_context('bars_gl', 'mfo') not in ('300465','322669','324805') --��� ����� � ����� ��� �� ������

      ) --����������� �� SETTLEMENTS
    where a.country=804
      and a.region_id is null
      and a.region is not null ;


 ---------------------------------------------------------------------------------------------------------------------------------

    update CUSTOMER_ADDRESS a set (a.region_id, a.area_id  )=
      (
        select s.region_id, s.area_id 
        from AREAS_MATCH DM, ADR_AREAS S 
        where DM.AREA_ID=S.AREA_ID 
          and DM.REGION = a.region
          and DM.DOMAIN is null
      ) --����������� �� SETTLEMENTS
    where a.country=804
      and a.region_id is null
      and a.region is not null ;


 ---------------------------------------------------------------------------------------------------------------------------------
    if sys_context('bars_gl', 'mfo') not in ('322669','324805') then  --��� ����� � ����� ��� �� ������
        update CUSTOMER_ADDRESS a set (a.region_id, a.area_id, a.settlement_id)=
          (
          ---���� ��������� ����� ������� � ������, �� ��� �� ����� ���, ��� � � ����� ������� (���� ����������� ������  (��� ������� �� ���������� ������), �� ��� ����� �����, ��� ����������� ������� ��� ���� �������� � ���� ������� ������)
          ---���� ����� ������, ����� �����/���� � ����� ������� ����������� ��������� ���. �� �� ����� ������� �������, �� ����� ��� ����� ���������� � ����������� ������, ������� ����� ����� �������� ���������� ����� (�� �������)
        select min(region_id), min(area_id), min(settlement_id) from (
           select 1 gf, t.region_id,t.area_id,t.settlement_id,  t.settlement_name, t.settlement_name_ru from ADR_SETTLEMENTS t where t.region_id=(select AR.region_id from v_adr_regions AR where AR.MFO = sys_context('bars_gl', 'mfo'))
           ) w
        where upper(w.settlement_name)   =  (TRANSLATE(/*upper(*//*initcap(*/trim(regexp_replace(upper(a.locality),('^(\,|\.|��� |���� |�,|� |�\.|� |� |�\.|��� |��� |�� )|^(\S{1}\.)'),'')/*))*/ ), 'ETYUIOPAHKXCBM', '���Ȳ���������'))
           or upper(w.settlement_name_ru) = (TRANSLATE(/*upper(*//*initcap(*/trim(regexp_replace(upper(a.locality),('^(\,|\.|��� |���� |�,|� |�\.|� |� |�\.|��� |��� |�� )|^(\S{1}\.)'),'')/*))*/ ), 'ETYUIOPAHKXCBM', '���Ȳ���������'))
        group by  w.gf
        having count(w.gf)=1

          ) --����������� �� SETTLEMENTS
        where a.country=804
          and a.region_id is null
          and a.locality is not null;
    else
          update CUSTOMER_ADDRESS a set (a.region_id, a.area_id, a.settlement_id)=
          (
          ---���� ��������� ����� ������� � ������, �� ��� �� ����� ���, ��� � � ����� ������� (���� ����������� ������  (��� ������� �� ���������� ������), �� ��� ����� �����, ��� ����������� ������� ��� ���� �������� � ���� ������� ������)
          ---���� ����� ������, ����� �����/���� � ����� ������� ����������� ��������� ���. �� �� ����� ������� �������, �� ����� ��� ����� ���������� � ����������� ������, ������� ����� ����� �������� ���������� ����� (�� �������)
        select min(region_id), min(area_id), min(settlement_id) from (
           select 1 gf, t.region_id,t.area_id,t.settlement_id,  t.settlement_name, t.settlement_name_ru from ADR_SETTLEMENTS t where t.region_id in (9,10)
           ) w
        where upper(w.settlement_name)   =  (TRANSLATE(/*upper(*//*initcap(*/trim(regexp_replace(upper(a.locality),('^(\,|\.|��� |���� |�,|� |�\.|� |� |�\.|��� |��� |�� )|^(\S{1}\.)'),'')/*))*/ ), 'ETYUIOPAHKXCBM', '���Ȳ���������'))
           or upper(w.settlement_name_ru) = (TRANSLATE(/*upper(*//*initcap(*/trim(regexp_replace(upper(a.locality),('^(\,|\.|��� |���� |�,|� |�\.|� |� |�\.|��� |��� |�� )|^(\S{1}\.)'),'')/*))*/ ), 'ETYUIOPAHKXCBM', '���Ȳ���������'))
        group by  w.gf
        having count(w.gf)=1

          ) --����������� �� SETTLEMENTS
        where a.country=804
          and a.region_id is null
          and a.locality is not null;
          
          

    end if;
    
    
 ---------------------------------------------------------------------------------------------------------------------------------

 --������ ������������� ��������� ������
   merge into CUSTOMER_ADDRESS t 
   using
   (select tt.region_id, m1.* from (
    (with w as (select 1 gf, t.region_id,t.area_id,t.settlement_id, t.settlement_name, t.settlement_name_ru, t.region_center_f from ADR_SETTLEMENTS t ),
             a as (select        (TRANSLATE(TRIM(REGEXP_REPLACE(REGEXP_REPLACE(UPPER("BARS"."STRTOK"(a.ADDRESS,',', 1)),  '^(\,|\.|�� |��\.|�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.|���\.|��� |�� |��\.|������ |�������� |����� |��������\.|�����\.|��-� |��-�\.|��� |���\.)', ''),'(\,|\.|\*|\"|\\|\/| � | �\.| ��� | ������� |\d)', '',3)),'ETYUIOPAHKXCBM','���Ȳ���������')) aa,
                   a.address,
                   a.settlement_id,
                   a.rnk,
                   a.type_id  

                   from CUSTOMER_ADDRESS a 
                       where a.country=804
                         and a.region_id is null
                         and a.address is not null) 
       select ( 
        select   min(settlement_id) settlement_id from  w --------
        where (
              a.aa like  '%'||upper(w.settlement_name)||'%'
           )    
        group by  w.gf
        having count(w.gf)=1
        and min(area_id) is null
        and min(region_center_f ) =1
             ) settlement_id,
             a.address,
             a.rnk,
             a.type_id  
        from a)) m1, ADR_SETTLEMENTS tt
        where m1.settlement_id = tt.settlement_id  )m  
     
     on (t.rnk = m.rnk and t.type_id = m.type_id)

    WHEN MATCHED THEN UPDATE SET settlement_id =m.settlement_id ,
                                 REGION_ID     =m.region_id;   
       

 ---------------------------------------------------------------------------------------------------------------------------------

/*    update CUSTOMER_ADDRESS a set (a.region_id, a.area_id, a.settlement_id) =
      (
        select s.region_id, s.area_id, s.settlement_id 
        from SETTLEMENTS_MATCH DM, ADR_SETTLEMENTS S 
        where DM.SETTLEMENTS_ID=S.SETTLEMENT_ID 
          and DM.LOCALITY = a.locality
          and DM.REGION is null
          and DM.AREA is null
      ) --����������� �� SETTLEMENTS
    where a.country=804
      and a.region_id is null
      and a.locality is not null;*/

----------------------------------------------------------------
    logger.trace('%s: done', l_th);
   end;
 end;
 
 procedure SET_REGION_MATCH is
    l_th constant varchar2(100) := g_dbgcode || 'SET_REGION_MATCH';
  begin
    bars_audit.trace('%s: entry point', l_th);

    begin
-------------------------------------------------------------------------------------------------------------------------------

    update CUSTOMER_ADDRESS a set (a.region_id, a.area_id, a.settlement_id) =
      (
        select s.region_id, s.area_id, s.settlement_id 
        from SETTLEMENTS_MATCH DM, ADR_SETTLEMENTS S 
        where DM.SETTLEMENTS_ID=S.SETTLEMENT_ID 
          and DM.LOCALITY = a.locality
          and DM.REGION is null
          and DM.AREA is null
      ) --����������� �� SETTLEMENTS
    where a.country=804
      and a.region_id is null
      and a.locality is not null;

----------------------------------------------------------------
    logger.trace('%s: done', l_th);
   end;
 end;
 
 
 
  --������ ����� (�� �����/�� ������)
  procedure SET_AREA is
    l_th constant varchar2(100) := g_dbgcode || 'SET_AREA';
  begin
    bars_audit.trace('%s: entry point', l_th);
    begin
    ---------------------------------------------------------------------------------------------------------------------------------
        update CUSTOMER_ADDRESS a set (a.area_id) =
          (
        ---���� ������ ���� ����� ���� � �������  (������ ������������)
        select  min(area_id) from (
           select 1 gf, t.region_id, t.area_id, t.area_name, t.area_name_ru from ADR_AREAS t
           ) w
        where (upper(w.area_name)   =  (TRANSLATE(/*upper(  *//*initcap(*/REGEXP_REPLACE (TRIM (upper(a.region)),'(\,|\.|�����$|�-�\.|�-�)',''/*)) */  ), 'ETYUIOPAHKXCBM', '���Ȳ���������'))||' �-�'
           or upper(w.area_name_ru) = (TRANSLATE(/*upper( */ /*initcap(*/REGEXP_REPLACE (TRIM (upper(a.region)),'(\,|\.|�����$|�-�\.|�-�)',''/*)) */  ), 'ETYUIOPAHKXCBM', '���Ȳ���������'))||' �-�'
              )
          and w.region_id = a.region_id
        group by  w.gf
        having count(w.gf)=1

          ) --����������� �� SETTLEMENTS
        where a.country=804
          and a.region_id is  not null
          and a.area_id   is null
          and a.region is not null
          and a.settlement_id is null;

    ---------------------------------------------------------------------------------------------------------------------------------

          --������� �������
           update CUSTOMER_ADDRESS a set (a.area_id) =
          (
        ---���� ������ ���� ����� ���� � �������
        select  min(area_id) from (
           select 1 gf, t.region_id, t.area_id, t.area_name, t.area_name_ru from ADR_AREAS t
           ) w
        where ( upper(w.area_name)  like /*'%'||*/(TRANSLATE(/*upper( */ /*initcap(*/REGEXP_REPLACE (TRIM (upper(a.region)),'(\,|\.|�����$|�-�\.|�-�)',''/*))*/   ), 'ETYUIOPAHKXCBM', '���Ȳ���������'))||'%'
                   )
          and w.region_id = a.region_id
        group by  w.gf
        having count(w.gf)=1

          ) --����������� �� SETTLEMENTS
        where a.country=804
          and a.region_id is  not null
          and a.area_id   is null
          and a.region is not null
          and a.settlement_id is null;


                --������� �������
          update CUSTOMER_ADDRESS a set (a.area_id) =
          (
        ---���� ������ ���� ����� ���� � �������
        select  min(area_id) from (
           select 1 gf, t.region_id, t.area_id, t.area_name, t.area_name_ru from ADR_AREAS t
           ) w
        where (upper(w.area_name_ru) like /*'%'||*/(TRANSLATE(/*upper( */ /*initcap(*/REGEXP_REPLACE (TRIM (upper(a.region)),'(\,|\.|�����$|�-�\.|�-�)',''/*))*/   ), 'ETYUIOPAHKXCBM', '���Ȳ���������'))||'%'
              )
          and w.region_id = a.region_id
        group by  w.gf
        having count(w.gf)=1

          ) --����������� �� SETTLEMENTS
        where a.country=804
          and a.region_id is  not null
          and a.area_id   is null
          and a.region is not null
          and a.settlement_id is null;

    ---------------------------------------------------------------------------------------------------------------------------------

        update CUSTOMER_ADDRESS a set (a.area_id)  =
          (
          ---���� ��������� ����� ������ � ������, �� ��� �� ����� ���, ��� � � ����� ������� (���� ����������� ������ (��� ������� �� ���������� ������), �� ��� ����� �����)
        select min(area_id) from (
           select 1 gf, t.region_id, t.area_id, t.area_name, t.area_name_ru from ADR_AREAS t where t.region_id= (select AR.region_id from v_adr_regions AR where AR.MFO = sys_context('bars_gl', 'mfo'))
           ) w
        where (upper(w.area_name)   =  (TRANSLATE(/*upper( */ /*initcap(*/REGEXP_REPLACE (TRIM (upper(a.region)),'(\,|\.|�����$|�-�\.|�-�)',''/*))*/   ), 'ETYUIOPAHKXCBM', '���Ȳ���������'))||' �-�'
           or upper(w.area_name_ru) = (TRANSLATE(/*upper( */ /*initcap(*/REGEXP_REPLACE (TRIM (upper(a.region)),'(\,|\.|�����$|�-�\.|�-�)',''/*))*/   ), 'ETYUIOPAHKXCBM', '���Ȳ���������'))||' �-�'
              )
              and w.region_id = a.region_id
        group by  w.gf
        having count(w.gf)=1 and sys_context('bars_gl', 'mfo') not in ('300465','322669','324805') --��� ����� � ����� ��� �� ������

          ) --����������� �� SETTLEMENTS
        where a.country=804
          and a.region_id is  not null
          and a.area_id   is null
          and a.region is not null
          and a.settlement_id is null;

     ---------------------------------------------------------------------------------------------------------------------------------

/*        update CUSTOMER_ADDRESS a set ( a.area_id  )=
            (select s.area_id
              from AREAS_MATCH DM
              join ADR_AREAS    S on DM.AREA_ID = S.AREA_ID 
             where (DM.REGION = a.region and DM.DOMAIN is null)
                    or 
                    (DM.REGION = a.region and DM.DOMAIN =a.region_id)
               and s.region_id = a.region_id)--����������� �� SETTLEMENTS
        where a.country=804
          and a.region_id is  not null
          and a.area_id   is null
          and a.region is not null
          and a.settlement_id is null;*/

---------------------------------------------------------------------------------------------------------------------------------
    end;

    logger.trace('%s: done', l_th);
  end;
  
  
  procedure SET_AREA_MATCH is
    l_th constant varchar2(100) := g_dbgcode || 'SET_AREA_MATCH';
  begin
    bars_audit.trace('%s: entry point', l_th);
    begin
     ---------------------------------------------------------------------------------------------------------------------------------

        update CUSTOMER_ADDRESS a set ( a.area_id  )=
            (select s.area_id
              from AREAS_MATCH DM
              join ADR_AREAS    S on DM.AREA_ID = S.AREA_ID 
             where (DM.REGION = a.region and DM.DOMAIN is null)
                    or 
                    (DM.REGION = a.region and DM.DOMAIN =a.region_id)
               and s.region_id = a.region_id)--����������� �� SETTLEMENTS
        where a.country=804
          and a.region_id is  not null
          and a.area_id   is null
          and a.region is not null
          and a.settlement_id is null;

---------------------------------------------------------------------------------------------------------------------------------
    end;

    logger.trace('%s: done', l_th);
  end;

    --������ ������ (�� ������)
  procedure SET_SETTLEMENTS is
    l_th constant varchar2(100) := g_dbgcode || 'SET_SETTLEMENTS';
  begin
    tuda;
    bars_audit.trace('%s: entry point', l_th);
    begin
   ---------------------------------------------------------------------------------------------------------------------------------

    update CUSTOMER_ADDRESS a set (a.area_id, a.settlement_id)  =
      (
    ---���� ������ ���� ����� ����� � ������ (������ ������������)
    select  min(area_id), min(settlement_id)  from (
       select 1 gf, t.region_id,t.area_id,t.settlement_id, t.settlement_name, t.settlement_name_ru from ADR_SETTLEMENTS t
       ) w
    where (upper(w.settlement_name)   =  (TRANSLATE(/*upper(*/ /*initcap(*/trim(regexp_replace(upper(a.locality),('^(\,|\.|��� |���� |�,|� |�\.|� |� |�\.|��� |��� |�� )'),'')/*))*/       ), 'ETYUIOPAHKXCBM', '���Ȳ���������'))
       or upper(w.settlement_name_ru) = (TRANSLATE(/*upper( */ /*initcap(*/trim(regexp_replace(upper(a.locality),('^(\,|\.|��� |���� |�,|� |�\.|� |� |�\.|��� |��� |�� )'),'')/*))*/    ), 'ETYUIOPAHKXCBM', '���Ȳ���������'))
          )
        and w.region_id = a.region_id
        and (w.area_id = a.area_id or a.area_id is null or w.area_id is null)

    group by  w.gf
    having count(w.gf)=1

      ) --����������� �� SETTLEMENTS
    where a.country=804
      and a.region_id is  not null
      and a.locality is not null
      and a.settlement_id is null;

---------------------------------------------------------------------------------------------------------------------------------

      --������� �������
       update CUSTOMER_ADDRESS a set (a.area_id, a.settlement_id)   =
      (
    ---���� ������ ���� ����� ����� � ������
    select  min(area_id), min(settlement_id)  from (
       select 1 gf, t.region_id,t.area_id,t.settlement_id, t.settlement_name, t.settlement_name_ru from ADR_SETTLEMENTS t
       ) w
    where (upper(w.settlement_name)   like (TRANSLATE(/*upper( *//*initcap(*/trim(regexp_replace(upper(a.locality),('^(\,|\.|��� |���� |�,|� |�\.|� |� |�\.|��� |��� |�� )'),'')/*))*/       ), 'ETYUIOPAHKXCBM', '���Ȳ���������'))||'%'
             )
        and w.region_id = a.region_id
        and (w.area_id = a.area_id or a.area_id is null or w.area_id is null)
    group by  w.gf
    having count(w.gf)=1

      ) --����������� �� SETTLEMENTS
    where a.country=804
      and a.region_id is  not null
      and a.locality is not null
      and a.settlement_id is null;


           --������� �������
       update CUSTOMER_ADDRESS a set (a.area_id, a.settlement_id)   =
      (
    ---���� ������ ���� ����� ����� � ������
    select  min(area_id), min(settlement_id)  from (
       select 1 gf, t.region_id,t.area_id,t.settlement_id, t.settlement_name, t.settlement_name_ru from ADR_SETTLEMENTS t
       ) w
    where ( upper(w.settlement_name_ru) like (TRANSLATE(/*upper( *//*initcap(*/trim(regexp_replace(upper(a.locality),('^(\,|\.|��� |���� |�,|� |�\.|� |� |�\.|��� |��� |�� )'),'')/*))*/     ), 'ETYUIOPAHKXCBM', '���Ȳ���������'))||'%'
          )
        and w.region_id = a.region_id
        and (w.area_id = a.area_id or a.area_id is null or w.area_id is null)
    group by  w.gf
    having count(w.gf)=1

      ) --����������� �� SETTLEMENTS
    where a.country=804
      and a.region_id is  not null
      and a.locality is not null
      and a.settlement_id is null;


 ---------------------------------------------------------------------------------------------------------------------------------
     if sys_context('bars_gl', 'mfo') not in ('322669','324805') then  --��� ����� � ����� ��� �� ������
        update CUSTOMER_ADDRESS a set (a.area_id, a.settlement_id) =
          (
          ---���� ��������� ����� ������� � ������, �� ��� �� ����� ���, ��� � � ����� ������� (���� ����������� ������  (��� ������� �� ���������� ������), �� ��� ����� �����, ��� ����������� ������� ��� ���� �������� � ���� ������� ������)
          ---���� ����� ������, ����� �����/���� � ����� ������� ����������� ��������� ���. �� �� ����� ������� �������, �� ����� ��� ����� ���������� � ����������� ������, ������� ����� ����� �������� ���������� ����� (�� �������)
        select min(area_id), min(settlement_id)  from (
           select 1 gf, t.region_id,t.area_id,t.settlement_id,  t.settlement_name, t.settlement_name_ru from ADR_SETTLEMENTS t where t.region_id=(select AR.region_id from v_adr_regions AR where AR.MFO = sys_context('bars_gl', 'mfo'))
           ) w
        where (upper(w.settlement_name)   =  (TRANSLATE(/*upper(*//*initcap(*/trim(regexp_replace(upper(a.locality),('^(\,|\.|��� |���� |�,|� |�\.|� |� |�\.|��� |��� |�� )'),'')/*))*/ ), 'ETYUIOPAHKXCBM', '���Ȳ���������'))
           or upper(w.settlement_name_ru) = (TRANSLATE(/*upper(*//*initcap(*/trim(regexp_replace(upper(a.locality),('^(\,|\.|��� |���� |�,|� |�\.|� |� |�\.|��� |��� |�� )'),'')/*))*/ ), 'ETYUIOPAHKXCBM', '���Ȳ���������'))
              )
              and w.region_id = a.region_id
              and (w.area_id = a.area_id or a.area_id is null or w.area_id is null)
        group by  w.gf
        having count(w.gf)=1

          ) --����������� �� SETTLEMENTS
        where a.country=804
          and a.region_id is  not null
          and a.locality is not null
          and a.settlement_id is null;
    else
          update CUSTOMER_ADDRESS a set (a.area_id, a.settlement_id) =
          (
          ---���� ��������� ����� ������� � ������, �� ��� �� ����� ���, ��� � � ����� ������� (���� ����������� ������  (��� ������� �� ���������� ������), �� ��� ����� �����, ��� ����������� ������� ��� ���� �������� � ���� ������� ������)
          ---���� ����� ������, ����� �����/���� � ����� ������� ����������� ��������� ���. �� �� ����� ������� �������, �� ����� ��� ����� ���������� � ����������� ������, ������� ����� ����� �������� ���������� ����� (�� �������)
        select min(area_id), min(settlement_id)  from (
           select 1 gf, t.region_id,t.area_id,t.settlement_id,  t.settlement_name, t.settlement_name_ru from ADR_SETTLEMENTS t where t.region_id in (9,10)
           ) w
        where (upper(w.settlement_name)   =  (TRANSLATE(/*upper(*//*initcap(*/trim(regexp_replace(upper(a.locality),('^(\,|\.|��� |���� |�,|� |�\.|� |� |�\.|��� |��� |�� )'),'')/*))*/ ), 'ETYUIOPAHKXCBM', '���Ȳ���������'))
           or upper(w.settlement_name_ru) = (TRANSLATE(/*upper(*//*initcap(*/trim(regexp_replace(upper(a.locality),('^(\,|\.|��� |���� |�,|� |�\.|� |� |�\.|��� |��� |�� )'),'')/*))*/ ), 'ETYUIOPAHKXCBM', '���Ȳ���������'))
              )
            and w.region_id = a.region_id
            and (w.area_id = a.area_id or a.area_id is null or w.area_id is null)
        group by  w.gf
        having count(w.gf)=1

          ) --����������� �� SETTLEMENTS
        where a.country=804
          and a.region_id is  not null
          and a.locality is not null
          and a.settlement_id is null;
    end if;



           --������� �������
       update CUSTOMER_ADDRESS a set (a.area_id, a.settlement_id)   =
      (
    ---���� ������ ���� ����� ����� � ������
    select  min(area_id), min(settlement_id)  from (
       select 1 gf, t.region_id,t.area_id,t.settlement_id, t.settlement_name, t.settlement_name_ru from ADR_SETTLEMENTS t
       ) w
    where ( -- like (TRANSLATE(/*upper( *//*initcap(*/trim(regexp_replace(upper(a.locality),('^(\,|\.|��� |���� |�,|� |�\.|� |� |�\.|��� |��� |�� )'),'')/*))*/     ), 'ETYUIOPAHKXCBM', '���Ȳ���������'))||'%'
          
          TRANSLATE(UPPER(upper(w.settlement_name)),'��������ު�','___________')) = (TRANSLATE((TRANSLATE(/*upper( *//*initcap(*/trim(regexp_replace(upper(a.locality),('^(\,|\.|��� |���� |�,|� |�\.|� |� |�\.|��� |��� |�� )'),'')/*))*/     ), 'ETYUIOPAHKXCBM', '���Ȳ���������')),'��������ު�','___________') 
          
          )
        and w.region_id = a.region_id
        and (w.area_id = a.area_id or a.area_id is null or w.area_id is null)
    group by  w.gf
    having count(w.gf)=1

      ) --����������� �� SETTLEMENTS
    where a.country=804
      and a.region_id is  not null
      and a.locality is not null
      and a.settlement_id is null;


           --������� �������
       update CUSTOMER_ADDRESS a set (a.area_id, a.settlement_id)   =
      (
    ---���� ������ ���� ����� ����� � ������
    select  min(area_id), min(settlement_id)  from (
       select 1 gf, t.region_id,t.area_id,t.settlement_id, t.settlement_name, t.settlement_name_ru from ADR_SETTLEMENTS t
       ) w
    where ( -- like (TRANSLATE(/*upper( *//*initcap(*/trim(regexp_replace(upper(a.locality),('^(\,|\.|��� |���� |�,|� |�\.|� |� |�\.|��� |��� |�� )'),'')/*))*/     ), 'ETYUIOPAHKXCBM', '���Ȳ���������'))||'%'
          
          TRANSLATE(UPPER(upper(w.settlement_name_ru)),'��������ު�','___________')) = (TRANSLATE((TRANSLATE(/*upper( *//*initcap(*/trim(regexp_replace(upper(a.locality),('^(\,|\.|��� |���� |�,|� |�\.|� |� |�\.|��� |��� |�� )'),'')/*))*/     ), 'ETYUIOPAHKXCBM', '���Ȳ���������')),'��������ު�','___________') 
          
          )
        and w.region_id = a.region_id
        and (w.area_id = a.area_id or a.area_id is null or w.area_id is null)
    group by  w.gf
    having count(w.gf)=1

      ) --����������� �� SETTLEMENTS
    where a.country=804
      and a.region_id is  not null
      and a.locality is not null
      and a.settlement_id is null;





 ---------------------------------------------------------------------------------------------------------------------------------

/*    update CUSTOMER_ADDRESS a set (a.area_id, a.settlement_id)  =
      (
        select   s.area_id, s.settlement_id 
          from SETTLEMENTS_MATCH DM
          join ADR_SETTLEMENTS    S on DM.SETTLEMENTS_ID=S.SETTLEMENT_ID
         where (DM.LOCALITY = a.locality and DM.region  is null and DM.area  is null)
              or 
               (DM.LOCALITY = a.locality and DM.region  = a.region_id and DM.area  is null)
              or 
               (DM.LOCALITY = a.locality and DM.region  is null and DM.area  = a.area_id)
              or 
               (DM.LOCALITY = a.locality and DM.region  = a.region_id and DM.area  = a.area_id)
        
           and s.region_id = a.region_id
           and (s.area_id = a.area_id or a.area_id is null or s.area_id is null)
      ) --����������� �� SETTLEMENTS
    where a.country=804
      and a.region_id is  not null
      and a.locality is not null
      and a.settlement_id is null;*/
  ----------------------------------------------------------------
    end;
    logger.trace('%s: done', l_th);
  end;
  
  procedure SET_SETTLEMENTS_MATCH is
    l_th constant varchar2(100) := g_dbgcode || 'SET_SETTLEMENTS_MATCH';
  begin
    tuda;
    bars_audit.trace('%s: entry point', l_th);
    begin
  ---------------------------------------------------------------------------------------------------------------------------------

    update CUSTOMER_ADDRESS a set (a.area_id, a.settlement_id)  =
      (
        select   s.area_id, s.settlement_id 
          from SETTLEMENTS_MATCH DM
          join ADR_SETTLEMENTS    S on DM.SETTLEMENTS_ID=S.SETTLEMENT_ID
         where (DM.LOCALITY = a.locality and DM.region  is null and DM.area  is null)
              or 
               (DM.LOCALITY = a.locality and DM.region  = a.region_id and DM.area  is null)
              or 
               (DM.LOCALITY = a.locality and DM.region  is null and DM.area  = a.area_id)
              or 
               (DM.LOCALITY = a.locality and DM.region  = a.region_id and DM.area  = a.area_id)
        
           and s.region_id = a.region_id
           and (s.area_id = a.area_id or a.area_id is null or s.area_id is null)
      ) --����������� �� SETTLEMENTS
    where a.country=804
      and a.region_id is  not null
      and a.locality is not null
      and a.settlement_id is null;
  ----------------------------------------------------------------
    end;
    logger.trace('%s: done', l_th);
  end;
  
  
  procedure SET_STREETS is
    l_th constant varchar2(100) := g_dbgcode || 'SET_STREETS';
  begin
    tuda;
    bars_audit.trace('%s: entry point', l_th);
    begin
         merge into CUSTOMER_ADDRESS t 
   using
   (with w as (select 1 gf, t.street_id, t.street_name,t.street_name_ru,t.settlement_id, t.street_type from ADR_STREETS t  ),
         a as (select        (TRANSLATE(TRIM(REGEXP_REPLACE(REGEXP_REPLACE(UPPER("BARS"."STRTOK"(a.ADDRESS,',', 1)),  '^(\,|\.|�� |��\.|�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.|���\.|��� |�� |��\.|������ |�������� |����� |��������\.|�����\.|��-� |��-�\.|��� |���\.)', ''),'(\,|\.|\*|\"|\\|\/| � | �\.| ��� | ������� |\d)', '',3)),'ETYUIOPAHKXCBM','���Ȳ���������')) aa,
                    --  length((TRANSLATE(TRIM(REGEXP_REPLACE(REGEXP_REPLACE(UPPER("BARS"."STRTOK"(a.ADDRESS,',', 1)),  '^(\,|\.|�� |��\.|�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.|���\.|��� |�� |��\.|������ |�������� |����� |��������\.|�����\.|��-� |��-�\.|��� |���\.)', ''),'(\,|\.|\*|\"|\\|\/| � | �\.| ��� | ������� |\d)', '',3)),'ETYUIOPAHKXCBM','���Ȳ���������'))) length_aa,
                             a.rnk,
                             a.type_id  ,
                             a.address ,
                             a.settlement_id
               from CUSTOMER_ADDRESS a 
               where a.country = 804
                 and a.settlement_id is not null
                 and a.street_id is null
                 and a.address is not null) 
   select ( 
    select   min(w.street_id )  from  w --------
    where (
         UPPER(w.STREET_NAME) = a.aa    

       )   
      and a.settlement_id = w.settlement_id  
      and ((REGEXP_INSTR(upper(a.address),('^(�� |��\.|�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.|���\.|��� |�� |��\.|������ |�������� |����� |��������\.|�����\.|��-� |��-�\.|��� |���\.)')) = 0 )
           or
           (REGEXP_INSTR(upper(a.address),('^(�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.)'))>0 and w.street_type=20)
           or
           (REGEXP_INSTR(upper(a.address),('^(�� |��\.)'))>0 and w.street_type=19)
           or
           (REGEXP_INSTR(upper(a.address),('^(���\.|��� |�� |��\.|������ )'))>0 and w.street_type=4)
           or
           (REGEXP_INSTR(upper(a.address),('^(�� |��\.|�������� |����� |��������\.|�����\.|��-� |��-�\.)'))>0 and w.street_type=22)
          ) 
          
    group by  w.gf
    having count(w.gf)=1
         )street_id,
         a.rnk,
         a.type_id
    from a) m  
     
     on (t.rnk = m.rnk and t.type_id = m.type_id)

    WHEN MATCHED THEN UPDATE SET street_id =m.street_id ;
                         
      merge into CUSTOMER_ADDRESS t 
   using
   (with w as (select 1 gf, t.street_id, t.street_name,t.street_name_ru,t.settlement_id, t.street_type from ADR_STREETS t  ),
         a as (select        (TRANSLATE(TRIM(REGEXP_REPLACE(REGEXP_REPLACE(UPPER("BARS"."STRTOK"(a.ADDRESS,',', 1)),  '^(\,|\.|�� |��\.|�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.|���\.|��� |�� |��\.|������ |�������� |����� |��������\.|�����\.|��-� |��-�\.|��� |���\.)', ''),'(\,|\.|\*|\"|\\|\/| � | �\.| ��� | ������� |\d)', '',3)),'ETYUIOPAHKXCBM','���Ȳ���������')) aa,
                 --     length((TRANSLATE(TRIM(REGEXP_REPLACE(REGEXP_REPLACE(UPPER("BARS"."STRTOK"(a.ADDRESS,',', 1)),  '^(\,|\.|�� |��\.|�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.|���\.|��� |�� |��\.|������ |�������� |����� |��������\.|�����\.|��-� |��-�\.|��� |���\.)', ''),'(\,|\.|\*|\"|\\|\/| � | �\.| ��� | ������� |\d)', '',3)),'ETYUIOPAHKXCBM','���Ȳ���������'))) length_aa,
                             a.rnk,
                             a.type_id  ,
                             a.address ,
                             a.settlement_id
               from CUSTOMER_ADDRESS a 
               where a.country = 804
                 and a.settlement_id is not null
                 and a.street_id is null
                 and a.address is not null) 
   select ( 
    select   min(w.street_id )  from  w --------
    where (
         UPPER(w.STREET_NAME_RU) = a.aa   

       )   
      and a.settlement_id = w.settlement_id  
      and ((REGEXP_INSTR(upper(a.address),('^(�� |��\.|�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.|���\.|��� |�� |��\.|������ |�������� |����� |��������\.|�����\.|��-� |��-�\.|��� |���\.)')) = 0 )
           or
           (REGEXP_INSTR(upper(a.address),('^(�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.)'))>0 and w.street_type=20)
           or
           (REGEXP_INSTR(upper(a.address),('^(�� |��\.)'))>0 and w.street_type=19)
           or
           (REGEXP_INSTR(upper(a.address),('^(���\.|��� |�� |��\.|������ )'))>0 and w.street_type=4)
           or
           (REGEXP_INSTR(upper(a.address),('^(�� |��\.|�������� |����� |��������\.|�����\.|��-� |��-�\.)'))>0 and w.street_type=22)
          ) 
          
    group by  w.gf
    having count(w.gf)=1
         )street_id,
         a.rnk,
         a.type_id
    from a) m  
     
     on (t.rnk = m.rnk and t.type_id = m.type_id)

    WHEN MATCHED THEN UPDATE SET street_id =m.street_id ;
    
   merge into CUSTOMER_ADDRESS t 
   using
   (with w as (select 1 gf, t.street_id, t.street_name,t.street_name_ru,t.settlement_id, t.street_type from ADR_STREETS t  ),
         a as (select        (TRANSLATE(TRIM(REGEXP_REPLACE(REGEXP_REPLACE(UPPER("BARS"."STRTOK"(a.ADDRESS,',', 1)),  '^(\,|\.|�� |��\.|�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.|���\.|��� |�� |��\.|������ |�������� |����� |��������\.|�����\.|��-� |��-�\.|��� |���\.)', ''),'(\,|\.|\*|\"|\\|\/| � | �\.| ��� | ������� |\d)', '',3)),'ETYUIOPAHKXCBM','���Ȳ���������')) aa,
                  --    length((TRANSLATE(TRIM(REGEXP_REPLACE(REGEXP_REPLACE(UPPER("BARS"."STRTOK"(a.ADDRESS,',', 1)),  '^(\,|\.|�� |��\.|�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.|���\.|��� |�� |��\.|������ |�������� |����� |��������\.|�����\.|��-� |��-�\.|��� |���\.)', ''),'(\,|\.|\*|\"|\\|\/| � | �\.| ��� | ������� |\d)', '',3)),'ETYUIOPAHKXCBM','���Ȳ���������'))) length_aa,
                             a.rnk,
                             a.type_id  ,
                             a.address ,
                             a.settlement_id
               from CUSTOMER_ADDRESS a 
               where a.country = 804
                 and a.settlement_id is not null
                 and a.street_id is null
                 and a.address is not null) 
   select ( 
    select   min(w.street_id )  from  w --------
    where (
         a.aa  like '%'||UPPER(w.STREET_NAME)||'%' 

       )   
      and a.settlement_id = w.settlement_id  
      and ((REGEXP_INSTR(upper(a.address),('^(�� |��\.|�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.|���\.|��� |�� |��\.|������ |�������� |����� |��������\.|�����\.|��-� |��-�\.|��� |���\.)')) = 0 )
           or
           (REGEXP_INSTR(upper(a.address),('^(�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.)'))>0 and w.street_type=20)
           or
           (REGEXP_INSTR(upper(a.address),('^(�� |��\.)'))>0 and w.street_type=19)
           or
           (REGEXP_INSTR(upper(a.address),('^(���\.|��� |�� |��\.|������ )'))>0 and w.street_type=4)
           or
           (REGEXP_INSTR(upper(a.address),('^(�� |��\.|�������� |����� |��������\.|�����\.|��-� |��-�\.)'))>0 and w.street_type=22)
          ) 
          
    group by  w.gf
    having count(w.gf)=1
         )street_id,
         a.rnk,
         a.type_id
    from a) m  
     
     on (t.rnk = m.rnk and t.type_id = m.type_id)

    WHEN MATCHED THEN UPDATE SET street_id =m.street_id ;
                                                                      
       merge into CUSTOMER_ADDRESS t 
   using
   (with w as (select 1 gf, t.street_id, t.street_name,t.street_name_ru,t.settlement_id, t.street_type from ADR_STREETS t  ),
         a as (select        (TRANSLATE(TRIM(REGEXP_REPLACE(REGEXP_REPLACE(UPPER("BARS"."STRTOK"(a.ADDRESS,',', 1)),  '^(\,|\.|�� |��\.|�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.|���\.|��� |�� |��\.|������ |�������� |����� |��������\.|�����\.|��-� |��-�\.|��� |���\.)', ''),'(\,|\.|\*|\"|\\|\/| � | �\.| ��� | ������� |\d)', '',3)),'ETYUIOPAHKXCBM','���Ȳ���������')) aa,
                    --  length((TRANSLATE(TRIM(REGEXP_REPLACE(REGEXP_REPLACE(UPPER("BARS"."STRTOK"(a.ADDRESS,',', 1)),  '^(\,|\.|�� |��\.|�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.|���\.|��� |�� |��\.|������ |�������� |����� |��������\.|�����\.|��-� |��-�\.|��� |���\.)', ''),'(\,|\.|\*|\"|\\|\/| � | �\.| ��� | ������� |\d)', '',3)),'ETYUIOPAHKXCBM','���Ȳ���������'))) length_aa,
                             a.rnk,
                             a.type_id  ,
                             a.address ,
                             a.settlement_id
               from CUSTOMER_ADDRESS a 
               where a.country = 804
                 and a.settlement_id is not null
                 and a.street_id is null
                 and a.address is not null) 
   select ( 
    select   min(w.street_id )  from  w --------
    where (
         a.aa  like '%'||UPPER(w.STREET_NAME_RU)||'%' 

       )   
      and a.settlement_id = w.settlement_id  
      and ((REGEXP_INSTR(upper(a.address),('^(�� |��\.|�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.|���\.|��� |�� |��\.|������ |�������� |����� |��������\.|�����\.|��-� |��-�\.|��� |���\.)')) = 0 )
           or
           (REGEXP_INSTR(upper(a.address),('^(�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.)'))>0 and w.street_type=20)
           or
           (REGEXP_INSTR(upper(a.address),('^(�� |��\.)'))>0 and w.street_type=19)
           or
           (REGEXP_INSTR(upper(a.address),('^(���\.|��� |�� |��\.|������ )'))>0 and w.street_type=4)
           or
           (REGEXP_INSTR(upper(a.address),('^(�� |��\.|�������� |����� |��������\.|�����\.|��-� |��-�\.)'))>0 and w.street_type=22)
          ) 
          
    group by  w.gf
    having count(w.gf)=1
         )street_id,
         a.rnk,
         a.type_id
    from a) m  
     
     on (t.rnk = m.rnk and t.type_id = m.type_id)

    WHEN MATCHED THEN UPDATE SET street_id =m.street_id ;
                         
         merge into CUSTOMER_ADDRESS t 
   using
   (with w as (select 1 gf, t.street_id, t.street_name,t.street_name_ru,t.settlement_id, t.street_type from ADR_STREETS t  ),
         a as (select        (TRANSLATE(TRIM(REGEXP_REPLACE(REGEXP_REPLACE(UPPER("BARS"."STRTOK"(a.ADDRESS,',', 1)),  '^(\,|\.|�� |��\.|�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.|���\.|��� |�� |��\.|������ |�������� |����� |��������\.|�����\.|��-� |��-�\.|��� |���\.)', ''),'(\,|\.|\*|\"|\\|\/| � | �\.| ��� | ������� |\d)', '',3)),'ETYUIOPAHKXCBM','���Ȳ���������')) aa,
                      length((TRANSLATE(TRIM(REGEXP_REPLACE(REGEXP_REPLACE(UPPER("BARS"."STRTOK"(a.ADDRESS,',', 1)),  '^(\,|\.|�� |��\.|�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.|���\.|��� |�� |��\.|������ |�������� |����� |��������\.|�����\.|��-� |��-�\.|��� |���\.)', ''),'(\,|\.|\*|\"|\\|\/| � | �\.| ��� | ������� |\d)', '',3)),'ETYUIOPAHKXCBM','���Ȳ���������'))) length_aa,
                             a.rnk,
                             a.type_id  ,
                             a.address ,
                             a.settlement_id
               from CUSTOMER_ADDRESS a 
               where a.country = 804
                 and a.settlement_id is not null
                 and a.street_id is null
                 and a.address is not null) 
   select ( 
    select   min(w.street_id )  from  w --------
    where (

          UPPER(w.STREET_NAME) like '%'||a.aa||'%' and a.length_aa>2

       )   
      and a.settlement_id = w.settlement_id  
      and ((REGEXP_INSTR(upper(a.address),('^(�� |��\.|�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.|���\.|��� |�� |��\.|������ |�������� |����� |��������\.|�����\.|��-� |��-�\.|��� |���\.)')) = 0 )
           or
           (REGEXP_INSTR(upper(a.address),('^(�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.)'))>0 and w.street_type=20)
           or
           (REGEXP_INSTR(upper(a.address),('^(�� |��\.)'))>0 and w.street_type=19)
           or
           (REGEXP_INSTR(upper(a.address),('^(���\.|��� |�� |��\.|������ )'))>0 and w.street_type=4)
           or
           (REGEXP_INSTR(upper(a.address),('^(�� |��\.|�������� |����� |��������\.|�����\.|��-� |��-�\.)'))>0 and w.street_type=22)
          ) 
          
    group by  w.gf
    having count(w.gf)=1
         )street_id,
         a.rnk,
         a.type_id
    from a) m  
     
     on (t.rnk = m.rnk and t.type_id = m.type_id)

    WHEN MATCHED THEN UPDATE SET street_id =m.street_id ;
                         
       merge into CUSTOMER_ADDRESS t 
   using
   (with w as (select 1 gf, t.street_id, t.street_name,t.street_name_ru,t.settlement_id, t.street_type from ADR_STREETS t  ),
         a as (select        (TRANSLATE(TRIM(REGEXP_REPLACE(REGEXP_REPLACE(UPPER("BARS"."STRTOK"(a.ADDRESS,',', 1)),  '^(\,|\.|�� |��\.|�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.|���\.|��� |�� |��\.|������ |�������� |����� |��������\.|�����\.|��-� |��-�\.|��� |���\.)', ''),'(\,|\.|\*|\"|\\|\/| � | �\.| ��� | ������� |\d)', '',3)),'ETYUIOPAHKXCBM','���Ȳ���������')) aa,
                      length((TRANSLATE(TRIM(REGEXP_REPLACE(REGEXP_REPLACE(UPPER("BARS"."STRTOK"(a.ADDRESS,',', 1)),  '^(\,|\.|�� |��\.|�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.|���\.|��� |�� |��\.|������ |�������� |����� |��������\.|�����\.|��-� |��-�\.|��� |���\.)', ''),'(\,|\.|\*|\"|\\|\/| � | �\.| ��� | ������� |\d)', '',3)),'ETYUIOPAHKXCBM','���Ȳ���������'))) length_aa,
                             a.rnk,
                             a.type_id  ,
                             a.address ,
                             a.settlement_id
               from CUSTOMER_ADDRESS a 
               where a.country = 804
                 and a.settlement_id is not null
                 and a.street_id is null
                 and a.address is not null) 
   select ( 
    select   min(w.street_id )  from  w --------
    where (
          UPPER(w.STREET_NAME_RU) like '%'||a.aa||'%' and a.length_aa>2
       )   
      and a.settlement_id = w.settlement_id  
      and ((REGEXP_INSTR(upper(a.address),('^(�� |��\.|�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.|���\.|��� |�� |��\.|������ |�������� |����� |��������\.|�����\.|��-� |��-�\.|��� |���\.)')) = 0 )
           or
           (REGEXP_INSTR(upper(a.address),('^(�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.)'))>0 and w.street_type=20)
           or
           (REGEXP_INSTR(upper(a.address),('^(�� |��\.)'))>0 and w.street_type=19)
           or
           (REGEXP_INSTR(upper(a.address),('^(���\.|��� |�� |��\.|������ )'))>0 and w.street_type=4)
           or
           (REGEXP_INSTR(upper(a.address),('^(�� |��\.|�������� |����� |��������\.|�����\.|��-� |��-�\.)'))>0 and w.street_type=22)
          ) 
          
    group by  w.gf
    having count(w.gf)=1
         )street_id,
         a.rnk,
         a.type_id
    from a) m  
     
     on (t.rnk = m.rnk and t.type_id = m.type_id)

    WHEN MATCHED THEN UPDATE SET street_id =m.street_id ;    
    
    
    
          merge into CUSTOMER_ADDRESS t 
   using
   (with w as (select 1 gf, t.street_id, t.street_name,t.street_name_ru,t.settlement_id, t.street_type from ADR_STREETS t  ),
         a as (select        (TRANSLATE(TRIM(REGEXP_REPLACE(REGEXP_REPLACE(UPPER("BARS"."STRTOK"(a.ADDRESS,',', 1)),  '^(\,|\.|�� |��\.|�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.|���\.|��� |�� |��\.|������ |�������� |����� |��������\.|�����\.|��-� |��-�\.|��� |���\.)', ''),'(\,|\.|\*|\"|\\|\/| � | �\.| ��� | ������� |\d)', '',3)),'ETYUIOPAHKXCBM','���Ȳ���������')) aa,
                      length((TRANSLATE(TRIM(REGEXP_REPLACE(REGEXP_REPLACE(UPPER("BARS"."STRTOK"(a.ADDRESS,',', 1)),  '^(\,|\.|�� |��\.|�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.|���\.|��� |�� |��\.|������ |�������� |����� |��������\.|�����\.|��-� |��-�\.|��� |���\.)', ''),'(\,|\.|\*|\"|\\|\/| � | �\.| ��� | ������� |\d)', '',3)),'ETYUIOPAHKXCBM','���Ȳ���������'))) length_aa,
                             a.rnk,
                             a.type_id  ,
                             a.address ,
                             a.settlement_id
               from CUSTOMER_ADDRESS a 
               where a.country = 804
                 and a.settlement_id is not null
                 and a.street_id is null
                 and a.address is not null) 
   select ( 
    select   min(w.street_id )  from  w --------
    where (
          TRANSLATE(UPPER(w.STREET_NAME),'��������ު�','___________')) = (TRANSLATE(a.aa,'��������ު�','___________') 
       )   
      and a.settlement_id = w.settlement_id  
      and ((REGEXP_INSTR(upper(a.address),('^(�� |��\.|�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.|���\.|��� |�� |��\.|������ |�������� |����� |��������\.|�����\.|��-� |��-�\.|��� |���\.)')) = 0 )
           or
           (REGEXP_INSTR(upper(a.address),('^(�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.)'))>0 and w.street_type=20)
           or
           (REGEXP_INSTR(upper(a.address),('^(�� |��\.)'))>0 and w.street_type=19)
           or
           (REGEXP_INSTR(upper(a.address),('^(���\.|��� |�� |��\.|������ )'))>0 and w.street_type=4)
           or
           (REGEXP_INSTR(upper(a.address),('^(�� |��\.|�������� |����� |��������\.|�����\.|��-� |��-�\.)'))>0 and w.street_type=22)
          ) 
          
    group by  w.gf
    having count(w.gf)=1
         )street_id,
         a.rnk,
         a.type_id
    from a) m  
     
     on (t.rnk = m.rnk and t.type_id = m.type_id)

    WHEN MATCHED THEN UPDATE SET street_id =m.street_id ;     
    
    
    
              merge into CUSTOMER_ADDRESS t 
   using
   (with w as (select 1 gf, t.street_id, t.street_name,t.street_name_ru,t.settlement_id, t.street_type from ADR_STREETS t  ),
         a as (select        (TRANSLATE(TRIM(REGEXP_REPLACE(REGEXP_REPLACE(UPPER("BARS"."STRTOK"(a.ADDRESS,',', 1)),  '^(\,|\.|�� |��\.|�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.|���\.|��� |�� |��\.|������ |�������� |����� |��������\.|�����\.|��-� |��-�\.|��� |���\.)', ''),'(\,|\.|\*|\"|\\|\/| � | �\.| ��� | ������� |\d)', '',3)),'ETYUIOPAHKXCBM','���Ȳ���������')) aa,
                      length((TRANSLATE(TRIM(REGEXP_REPLACE(REGEXP_REPLACE(UPPER("BARS"."STRTOK"(a.ADDRESS,',', 1)),  '^(\,|\.|�� |��\.|�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.|���\.|��� |�� |��\.|������ |�������� |����� |��������\.|�����\.|��-� |��-�\.|��� |���\.)', ''),'(\,|\.|\*|\"|\\|\/| � | �\.| ��� | ������� |\d)', '',3)),'ETYUIOPAHKXCBM','���Ȳ���������'))) length_aa,
                             a.rnk,
                             a.type_id  ,
                             a.address ,
                             a.settlement_id
               from CUSTOMER_ADDRESS a 
               where a.country = 804
                 and a.settlement_id is not null
                 and a.street_id is null
                 and a.address is not null) 
   select ( 
    select   min(w.street_id )  from  w --------
    where (
          TRANSLATE(UPPER(w.STREET_NAME_RU),'��������ު�','___________')) = (TRANSLATE(a.aa,'��������ު�','___________') 
       )   
      and a.settlement_id = w.settlement_id  
      and ((REGEXP_INSTR(upper(a.address),('^(�� |��\.|�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.|���\.|��� |�� |��\.|������ |�������� |����� |��������\.|�����\.|��-� |��-�\.|��� |���\.)')) = 0 )
           or
           (REGEXP_INSTR(upper(a.address),('^(�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.)'))>0 and w.street_type=20)
           or
           (REGEXP_INSTR(upper(a.address),('^(�� |��\.)'))>0 and w.street_type=19)
           or
           (REGEXP_INSTR(upper(a.address),('^(���\.|��� |�� |��\.|������ )'))>0 and w.street_type=4)
           or
           (REGEXP_INSTR(upper(a.address),('^(�� |��\.|�������� |����� |��������\.|�����\.|��-� |��-�\.)'))>0 and w.street_type=22)
          ) 
          
    group by  w.gf
    having count(w.gf)=1
         )street_id,
         a.rnk,
         a.type_id
    from a) m  
     
     on (t.rnk = m.rnk and t.type_id = m.type_id)

    WHEN MATCHED THEN UPDATE SET street_id =m.street_id ;    
    
    
    
                     
    end;
    logger.trace('%s: done', l_th);
  end;
  
    procedure SET_STREETS_MATCH is
    l_th constant varchar2(100) := g_dbgcode || 'SET_SETTLEMENTS_MATCH';
  begin
    tuda;
    bars_audit.trace('%s: entry point', l_th);
    begin
  ---------------------------------------------------------------------------------------------------------------------------------

    update CUSTOMER_ADDRESS a set a.street_id  = 
      ( 
        select   s.street_id from STREETS_MATCH DM, ADR_STREETS S 
         where DM.STREET_ID = S.STREET_ID
           and DM.STREET      = (TRANSLATE(TRIM( REGEXP_REPLACE ( REGEXP_REPLACE (UPPER(STRTOK(a.ADDRESS,',',1)),'^(\,|\.|�� |��\.|�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.|���\.|��� |�� |��\.|������ |�������� |����� |��������\.|�����\.|��-� |��-�\.|��� |���\.)',''),'(\,|\.|\*|\"|\\|\/| � | �\.| ��� | ������� |\d)','',3)),'ETYUIOPAHKXCBM','���Ȳ���������'))
           and s.settlement_id = A.SETTLEMENT_ID
      ) 
        where a.country=804 
          and a.settlement_id is not null
          and a.street_id is null
          and a.address is not null;    
  ----------------------------------------------------------------
    end;
    logger.trace('%s: done', l_th);
  end;

  procedure SET_REGION_FULL is
    l_th constant varchar2(100) := g_dbgcode || 'SET_REGION_FULL';
    l_trig  varchar2_list;
  begin
    tuda;
    bars_audit.trace('%s: entry point', l_th);
      l_trig := varchar2_list();
      for k in (SELECT TRIGGER_NAME
                FROM   USER_TRIGGERS
                WHERE  TABLE_NAME='CUSTOMER_ADDRESS'    and
                       TRIGGERING_EVENT like '%UPDATE%' and
                       status='ENABLED')
      loop
        execute immediate 'alter trigger '||k.TRIGGER_NAME||' disable';
        l_trig.extend;
        l_trig(l_trig.count) := k.TRIGGER_NAME;
      end loop;
    begin
     set_region;
     SET_REGION_MATCH;
    end;
    for k in (select COLUMN_VALUE
              from   table(cast(l_trig as varchar2_list)))
    loop
      execute immediate 'alter trigger '||k.COLUMN_VALUE||' ENABLE';
    end loop;
    logger.trace('%s: done', l_th);
  end;
  
  
    procedure SET_REGION_FULL_MATCH is
    l_th constant varchar2(100) := g_dbgcode || 'SET_REGION_FULL_MATCH';
    l_trig  varchar2_list;
  begin
    tuda;
    bars_audit.trace('%s: entry point', l_th);
      l_trig := varchar2_list();
      for k in (SELECT TRIGGER_NAME
                FROM   USER_TRIGGERS
                WHERE  TABLE_NAME='CUSTOMER_ADDRESS'    and
                       TRIGGERING_EVENT like '%UPDATE%' and
                       status='ENABLED')
      loop
        execute immediate 'alter trigger '||k.TRIGGER_NAME||' disable';
        l_trig.extend;
        l_trig(l_trig.count) := k.TRIGGER_NAME;
      end loop;
    begin
     SET_REGION_MATCH;
    end;
    for k in (select COLUMN_VALUE
              from   table(cast(l_trig as varchar2_list)))
    loop
      execute immediate 'alter trigger '||k.COLUMN_VALUE||' ENABLE';
    end loop;
    logger.trace('%s: done', l_th);
  end;


  procedure SET_AREA_FULL is
    l_th constant varchar2(100) := g_dbgcode || 'SET_AREA_FULL';
    l_trig  varchar2_list;
  begin
    tuda;
    bars_audit.trace('%s: entry point', l_th);
      l_trig := varchar2_list();
      for k in (SELECT TRIGGER_NAME
                FROM   USER_TRIGGERS
                WHERE  TABLE_NAME='CUSTOMER_ADDRESS'    and
                       TRIGGERING_EVENT like '%UPDATE%' and
                       status='ENABLED')
      loop
        execute immediate 'alter trigger '||k.TRIGGER_NAME||' disable';
        l_trig.extend;
        l_trig(l_trig.count) := k.TRIGGER_NAME;
      end loop;
    begin
/*     set_region;*/
     set_area;
     SET_AREA_MATCH;
    end;
    for k in (select COLUMN_VALUE
              from   table(cast(l_trig as varchar2_list)))
    loop
      execute immediate 'alter trigger '||k.COLUMN_VALUE||' ENABLE';
    end loop;
    logger.trace('%s: done', l_th);
  end;
  
    procedure SET_AREA_FULL_MATCH is
    l_th constant varchar2(100) := g_dbgcode || 'SET_AREA_FULL_MATCH';
    l_trig  varchar2_list;
  begin
    tuda;
    bars_audit.trace('%s: entry point', l_th);
      l_trig := varchar2_list();
      for k in (SELECT TRIGGER_NAME
                FROM   USER_TRIGGERS
                WHERE  TABLE_NAME='CUSTOMER_ADDRESS'    and
                       TRIGGERING_EVENT like '%UPDATE%' and
                       status='ENABLED')
      loop
        execute immediate 'alter trigger '||k.TRIGGER_NAME||' disable';
        l_trig.extend;
        l_trig(l_trig.count) := k.TRIGGER_NAME;
      end loop;
    begin
     SET_AREA_MATCH;
    end;
    for k in (select COLUMN_VALUE
              from   table(cast(l_trig as varchar2_list)))
    loop
      execute immediate 'alter trigger '||k.COLUMN_VALUE||' ENABLE';
    end loop;
    logger.trace('%s: done', l_th);
  end;


  procedure SET_SETTLEMENTS_FULL is
    l_th constant varchar2(100) := g_dbgcode || 'SET_SETTLEMENTS_FULL';
    l_trig  varchar2_list;
  begin
    tuda;
    bars_audit.trace('%s: entry point', l_th);
      l_trig := varchar2_list();
      for k in (SELECT TRIGGER_NAME
                FROM   USER_TRIGGERS
                WHERE  TABLE_NAME='CUSTOMER_ADDRESS'    and
                       TRIGGERING_EVENT like '%UPDATE%' and
                       status='ENABLED')
      loop
        execute immediate 'alter trigger '||k.TRIGGER_NAME||' disable';
        l_trig.extend;
        l_trig(l_trig.count) := k.TRIGGER_NAME;
      end loop;
    begin
/*     set_region;
     set_area;*/
     set_settlements;
     SET_SETTLEMENTS_MATCH;
    end;
    for k in (select COLUMN_VALUE
              from   table(cast(l_trig as varchar2_list)))
    loop
      execute immediate 'alter trigger '||k.COLUMN_VALUE||' ENABLE';
    end loop;
    logger.trace('%s: done', l_th);
  end;
  
  procedure SET_SETTLEMENTS_FULL_MATCH is
    l_th constant varchar2(100) := g_dbgcode || 'SET_SETTLEMENTS_FULL_MATCH';
    l_trig  varchar2_list;
  begin
    tuda;
    bars_audit.trace('%s: entry point', l_th);
      l_trig := varchar2_list();
      for k in (SELECT TRIGGER_NAME
                FROM   USER_TRIGGERS
                WHERE  TABLE_NAME='CUSTOMER_ADDRESS'    and
                       TRIGGERING_EVENT like '%UPDATE%' and
                       status='ENABLED')
      loop
        execute immediate 'alter trigger '||k.TRIGGER_NAME||' disable';
        l_trig.extend;
        l_trig(l_trig.count) := k.TRIGGER_NAME;
      end loop;
    begin

     SET_SETTLEMENTS_MATCH;
    end;
    for k in (select COLUMN_VALUE
              from   table(cast(l_trig as varchar2_list)))
    loop
      execute immediate 'alter trigger '||k.COLUMN_VALUE||' ENABLE';
    end loop;
    logger.trace('%s: done', l_th);
  end;
  
  procedure SET_STREETS_FULL is
    l_th constant varchar2(100) := g_dbgcode || 'SET_STREETS_FULL';
    l_trig  varchar2_list;
  begin
    tuda;
    bars_audit.trace('%s: entry point', l_th);
      l_trig := varchar2_list();
      for k in (SELECT TRIGGER_NAME
                FROM   USER_TRIGGERS
                WHERE  TABLE_NAME='CUSTOMER_ADDRESS'    and
                       TRIGGERING_EVENT like '%UPDATE%' and
                       status='ENABLED')
      loop
        execute immediate 'alter trigger '||k.TRIGGER_NAME||' disable';
        l_trig.extend;
        l_trig(l_trig.count) := k.TRIGGER_NAME;
      end loop;
    begin
     set_streets;
     SET_STREETS_MATCH;
    end;
    for k in (select COLUMN_VALUE
              from   table(cast(l_trig as varchar2_list)))
    loop
      execute immediate 'alter trigger '||k.COLUMN_VALUE||' ENABLE';
    end loop;
    logger.trace('%s: done', l_th);
  end;


  procedure SET_STREETS_FULL_MATCH is
    l_th constant varchar2(100) := g_dbgcode || 'SET_STREETS_FULL_MATCH';
    l_trig  varchar2_list;
  begin
    tuda;
    bars_audit.trace('%s: entry point', l_th);
      l_trig := varchar2_list();
      for k in (SELECT TRIGGER_NAME
                FROM   USER_TRIGGERS
                WHERE  TABLE_NAME='CUSTOMER_ADDRESS'    and
                       TRIGGERING_EVENT like '%UPDATE%' and
                       status='ENABLED')
      loop
        execute immediate 'alter trigger '||k.TRIGGER_NAME||' disable';
        l_trig.extend;
        l_trig(l_trig.count) := k.TRIGGER_NAME;
      end loop;
    begin

     SET_STREETS_MATCH;
    end;
    for k in (select COLUMN_VALUE
              from   table(cast(l_trig as varchar2_list)))
    loop
      execute immediate 'alter trigger '||k.COLUMN_VALUE||' ENABLE';
    end loop;
    logger.trace('%s: done', l_th);
  end;

end PKG_ADR_COMPARE;
/