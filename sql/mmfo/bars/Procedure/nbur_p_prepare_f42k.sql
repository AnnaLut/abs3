CREATE OR REPLACE PROCEDURE BARS.nbur_p_prepare_f42k(p_kod_filii        varchar2,
                                                p_report_date      date) is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : ��������� ��������� ����� ��� 42 �������������� �����
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.005  05/04/2019 (18/01/2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.005  05/04/2019';
                                                
   se_          number;
   sk_          number;
   sz_          number;
   sz0_         number;
   sz1_         number;
   s02_         number;
   s04_         number;
   ostc_        number;
   rnk_         number;
   
   ddd_         varchar2(3);                                                
begin
   -- ������� �������
   EXECUTE IMMEDIATE 'truncate table rnbu_trace';
   EXECUTE IMMEDIATE 'truncate table otcn_f42_temp';
   EXECUTE IMMEDIATE 'truncate table otcn_f42_zalog';
   EXECUTE IMMEDIATE 'TRUNCATE TABLE otcn_fa7_temp';
   EXECUTE IMMEDIATE 'TRUNCATE TABLE tmp_kod_r020';

   delete from NBUR_TMP_42_DATA where report_date = p_report_date and kf = p_kod_filii;

   -- ��������� �����
   -- ��������� 047 �� 051
   insert into otcn_f42_temp (ACC, NLS, KV, FDAT, DDD, R012, ACCC, OST_EQV, ap)          
   select *
   from (with perelik as     
           (select *
            from KL_F3_29 
            where kf = '42'
              and ddd in ('047', '051')
            ) 
              select /*+ leading(k) */ 
                     a.acc_id, a.acc_num, a.kv, p_report_date, k.ddd, 
                     a.r013,  a.cust_id, sum (d.ostq), 0
                from NBUR_DM_ACCOUNTS a, NBUR_DM_BALANCES_DAILY d, perelik k
                where a.nbs = k.r020 
                and a.r013 = k.r012 
                and k.r050 = decode(sign(d.ost), -1, '11', '22')      
                and a.report_date = p_report_date
                and a.kf = p_kod_filii
                and d.acc_id = a.acc_id
                and d.report_date = p_report_date
                and d.kf = p_kod_filii
                group by a.acc_id, a.acc_num, a.kv, k.ddd, a.r013, a.cust_id
        );
    commit;
    
    insert into otcn_f42_zalog (ACC, ACCS, RNKS, ND, NBS, R013, OST)
    SELECT /*+ ordered*/ 
        z.acc, z.accs, a.cust_id, z.nd, a.nbs, a.r013, d.ostq
    FROM CC_ACCP z, NBUR_DM_BALANCES_DAILY d, NBUR_DM_ACCOUNTS a
    WHERE z.acc in (select acc from otcn_f42_temp where ap = 0)
      AND z.accs = d.acc_id
      and d.report_date = p_report_date
      and d.kf = p_kod_filii
      AND d.acc_id = a.acc_id
      and a.report_date = p_report_date
      and a.kf = p_kod_filii
      AND a.nbs || a.r013 <> '91299'
      and d.ost < 0 ;
    commit;    

    for k in (select acc, nls, kv, fdat, ddd, r012 as r013, accc as rnk, ost_eqv as ostq
              from otcn_f42_temp
              where ap=0)
    loop
       ddd_ := k.ddd;
       rnk_ := k.rnk;
       
       IF k.r013 = '0'
       THEN
          ddd_ := '098'; -- ��� ��������
       END IF;

       IF ddd_ IN ('047', '051') THEN
         -- ����� �������������, ���. ��������� ������ �����
          sk_ := 0;
          sz_ := 0;
          se_ := abs(k.ostq);

          -- �������� ��� ������, � ������� "��������" ������ �����
          For p in (select z.ACC, z.ACCS, z.ND, z.NBS, z.R013, z.OST, z.rnks rnk,
                        nvl(sum(ost) over (partition by acc), 0) as sk_all
                   from OTCN_F42_ZALOG z
                   WHERE z.ACC = k.acc)
          loop
             ostc_ := 0;

             -- ��������� ������� ������ �� ������ �����
             if abs(p.ost) < abs(p.sk_all) then -- �� ���� �����
                sz1_ := round(abs(p.ost / p.sk_all) * k.ostq, 0);
             else
                sz1_ :=  k.ostq;
             end if;

             BEGIN
               select /*+ ordered*/ 
                  SUM(d.ostq)
                  INTO s04_                        
                from nd_acc n, NBUR_DM_ACCOUNTS a, NBUR_DM_BALANCES_DAILY d
               where n.nd = p.nd 
                 and n.acc <> p.acc
                 and n.acc = a.acc_id
                 and a.report_date = p_report_date
                 and a.kf = p_kod_filii
                 and a.cust_id = rnk_  
                 and substr(a.nbs,4,1) in ('5','6','9')
                 and substr(a.nbs,1,3) = substr(p.nbs,1,3)
                 AND d.acc_id = a.acc_id                                        
                 AND d.report_date = p_report_date
                 and d.kf = p_kod_filii;
             EXCEPTION WHEN no_data_found THEN
               s04_ := 0;
             END;

             ostc_ := abs(p.ost + NVL(s04_,0));
 
             -- ��������, ������� ��������� ��������, ��������� � ������ ���
             if rnk_ <> p.rnk then
                rnk_ := p.rnk;
             end if;

             -- �� ��������, �.�. ������ ����������� ������ �� ��� �����
             if not (k.nls like '9010%' and p.nbs='9023' and p.r013='1') then
                BEGIN
                    select nvl(SUM(ost_eqv),0)
                    INTO s02_
                    from otcn_f42_temp
                    where accc = p.accs
                      AND ap=1;
                EXCEPTION WHEN no_data_found THEN
                    s02_ := 0;
                END;

                if s02_ < ostc_ then
                   if s02_ + sz1_ >= ostc_ then
                      sz0_ := ostc_ - s02_;
                   else
                      sz0_ := sz1_;
                   end if;

                   if sz0_ <> 0 then
                      sz_ := sz_ + sz0_;
                      sk_ := sk_ + abs(ostc_);

                      insert into otcn_f42_temp(ACC, ACCC, OST_EQV, ap, kv)
                      values(k.acc, p.accs, sz0_, 1, k.kv);

                      INSERT INTO RNBU_TRACE(nls, kv, odate, kodp, znap, rnk, acc)
                      VALUES (k.nls, k.kv, k.fdat, substr (k.ddd, 2, 2) || '0000' || '000', to_char (sz0_), k.rnk, k.acc);
                   end if;
                end if;
             end if;
          end loop;
       END IF;    
    end loop;

    insert into NBUR_TMP_42_DATA (REPORT_DATE, KF, RNK, ACC, KV, NBS, OB22, NLS, 
            OST_NOM, OST_EQV, AP, R012, DDD, R020, ACCC, ZAL, LINK_GROUP, LINK_CODE, LINK_NAME, FL_PRINS)
    select p_report_date, p_kod_filii, a.rnk, a.acc, a.kv, substr(nls,1,4), null, a.nls,
           0, a.znap, null, null, substr(a.kodp, 1, 2)||'0', null, null, 0, NVL(d.link_group, c.cust_id),
           nvl(d.link_code, '000') link_code, nvl(d.groupname, c.cust_name) link_name,
           decode (c.k060, null, 2, 0, 2, 99, 2, 1) prins
    from rnbu_trace a
    join NBUR_DM_CUSTOMERS c
    on (a.rnk = c.cust_id and
        c.report_date = p_report_date and 
        c.kf = p_kod_filii)
    left outer join d8_cust_link_groups d
    on (c.cust_code = d.okpo); 
    
    -- �������� 72 
    insert into NBUR_TMP_42_DATA (REPORT_DATE, KF, RNK, ACC, KV, NBS, OB22, NLS, 
            OST_NOM, OST_EQV, AP, R012, DDD, R020, ACCC, ZAL, LINK_GROUP, LINK_CODE, LINK_NAME, FL_PRINS)
    select p_report_date, p_kod_filii, a.rnk, a.acc, a.kv, a.nbs, a.ob22, a.nls,
           a.ost_nom, a.ost_eqv, DECODE(SIGN(a.ost_nom),-1, 1, 2) ap, a.r012,
           a.ddd, a.r020, a.accc, 0, NVL(d.link_group, a.cust_id), nvl(d.link_code, '000') link_code, 
           nvl(d.groupname, a.cust_name) link_name, a.prins
    from (select /*+ ordered index(a, IDX_DMACCOUNTS_ACCNUM_KV) */ 
                    a.acc_id as acc, a.acc_num as nls, a.kv, d.report_date as FDAT, a.nbs, a.ob22,
                    d.ost as ost_nom, d.ostq as ost_eqv, a.acc_pid as accc,
                    a.cust_id as rnk, k.r012, k.ddd, k.r020,
                    c.cust_id, c.cust_name, c.cust_code, 
                    decode (c.k060, null, 2, 0, 2, 99, 2, 1) prins
                from kl_f3_29 k, NBUR_DM_ACCOUNTS a, NBUR_DM_BALANCES_DAILY d, NBUR_DM_CUSTOMERS c
                where k.kf = '42'
                and k.ddd in ('001', '006')
                and a.report_date = p_report_date
                and a.kf = p_kod_filii
                and a.acc_num like k.r020 || '%'
                and (a.nbs is null or substr(a.acc_num,1,4) = a.nbs)
                and a.acc_id = d.acc_id
                and d.report_date = p_report_date
                and d.kf = p_kod_filii
                and a.cust_id = c.cust_id 
                and c.report_date = p_report_date
                and c.kf = p_kod_filii 
                and d.ost <> 0
        ) a
    left outer join d8_cust_link_groups d
    on (a.cust_code = d.okpo)
    where decode(sign(a.ost_nom),-1, 1, 2) = a.r012;
    commit;
    
    -- �������� A0
    insert into NBUR_TMP_42_DATA (REPORT_DATE, KF, RNK, ACC, KV, NBS, OB22, NLS, 
            OST_NOM, OST_EQV, AP, R012, DDD, R020, ACCC, ZAL, LINK_GROUP, LINK_CODE, LINK_NAME, FL_PRINS)
    select p_report_date, p_kod_filii, a.rnk, a.acc, a.kv, a.nbs, a.ob22, a.nls,
           a.ost_nom, a.ost_eqv, DECODE(SIGN(a.ost_nom),-1, 1, 2) ap, a.r012, 
           a.ddd, a.r020, a.accc, 0, NVL(d.link_group, a.cust_id), nvl(d.link_code, '000') link_code, 
           nvl(d.groupname, a.cust_name) link_name, a.prins
    from (select /*+ ordered index(a, IDX_DMACCOUNTS_ACCNUM_KV) */ 
                    a.acc_id as acc, a.acc_num as nls, a.kv, d.report_date as FDAT, a.nbs, a.ob22,
                    d.ost as ost_nom, d.ostq as ost_eqv, a.acc_pid as accc,
                    a.cust_id as rnk, k.r012, k.r050, k.ddd, k.r020,
                    c.cust_id, c.cust_name, c.cust_code, 
                    decode (c.k060, null, 2, 0, 2, 99, 2, 1) prins,
                    (case when d.ostq < 0 then '11' else '22' end) r050_a
                from kl_f3_29 k, NBUR_DM_ACCOUNTS a, NBUR_DM_BALANCES_DAILY d, NBUR_DM_CUSTOMERS c
                where k.kf = '42'
                and k.ddd IN ('0A0')
                and a.report_date = p_report_date
                and a.kf = p_kod_filii
                and a.acc_num like k.r020 || '%'
                and a.acc_id = d.acc_id
                and d.report_date = p_report_date
                and d.kf = p_kod_filii
                and a.cust_id = c.cust_id 
                and c.report_date = p_report_date
                and c.kf = p_kod_filii 
                and d.ost <> 0                
        ) a
    left outer join d8_cust_link_groups d
    on (a.cust_code = d.okpo)
    where a.r050_a = a.r050;
    commit;    
    
    -- �������� A9
    insert into NBUR_TMP_42_DATA (REPORT_DATE, KF, RNK, ACC, KV, NBS, OB22, NLS, 
            OST_NOM, OST_EQV, AP, R012, DDD, R020, ACCC)
    select /*+ leading(a) */ 
        p_report_date, p_kod_filii, a.rnk, a.acc, a.kv, a.nbs, a.ob22, a.nls,
        b.ost, b.ostq, null, null, 'A90', null, a.accc
    FROM ACCOUNTS a, SNAP_BALANCES b, specparam p
    WHERE a.kf = p_kod_filii
      and a.nls like '14%' 
      and substr(a.nls,4,1) <> '8'
      and a.nbs is null
      and a.mdate is not null   
      and a.mdate - p_report_date < 183  
      and a.acc = b.acc
      and b.fdat = p_report_date
      and b.kf = p_kod_filii
      and b.ost <> 0
      and a.acc = p.acc
      and NVL (p.r011, '0') in ('C','D');
    commit;     
end;
/