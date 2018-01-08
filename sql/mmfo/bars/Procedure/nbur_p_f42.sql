

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F42.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_F42 ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F42 (p_kod_filii        varchar2,
                                             p_report_date      date,
                                             p_form_id          number,
                                             p_scheme           varchar2 default 'C',
                                             p_balance_type     varchar2 default 'S',
                                             p_file_code        varchar2 default '#42')
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования #E2 для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.002  25.01.2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.002  25.01.2017';
/*
    Формат коду показника > DD NNNN 000
    
   DD    -    може приймати значення:
        01:06,19:22,41:43,47,50,51,54,57,58,61:66,70:91,94:96,A0:A2    
        
   NNNN    -    умовний порядковий номер контрагента, пов’язаної з банком особи, установи. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    l_nbuc          varchar2(20);
    l_type          number;
    l_datez         date := p_report_date + 1;
    l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
    l_file_id       number;
    l_ourRNK        number;
    l_ourOKPO       varchar2(20);
    l_ourGLB        varchar2(20);
    l_flag          number := 0;
    l_vNKA          NUMBER;
    ls_prizn        NUMBER;  
    l_k1            NUMBER;
    l_k2            NUMBER;  
    l_k3            NUMBER;            
    l_rgk           NUMBER;            
    l_sum_k         NUMBER;            
    l_sum_SK        NUMBER;       
    l_fmt           VARCHAR2(30):='999G999G999G990D99';
    l_pdat          date;
    
    PROCEDURE p_ins(p_kod VARCHAR2, p_val NUMBER) IS
        pragma     AUTONOMOUS_TRANSACTION;
    BEGIN
        INSERT INTO NBUR_LST_MESSAGES
            (REPORT_DATE, KF, REPORT_CODE, VERSION_ID, MESSAGE_ID, MESSAGE_TXT, USERID)
        VALUES(p_report_date, p_kod_filii, p_file_code, 0, S_NBUR_MESSAGES.nextval, 
            p_kod||TO_CHAR(p_val/100, l_fmt), user_id);
        commit;
    exception
        when others then null;
    END;
BEGIN
    logger.info ('NBUR_P_F42 begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
    
    EXECUTE IMMEDIATE 'truncate table NBUR_TMP_F42';
    
    -- определение начальных параметров (код области или МФО или подразделение)
    nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 3, l_file_code, l_nbuc, l_type);
    
    l_file_id := 15250;
    
    begin
        select max(decode(glb, 0, '0', lpad(to_char(glb), 3, '0')))
        into l_ourGLB
        from rcukru
        where mfo = p_kod_filii;
    exception
        when no_data_found then
            l_ourGLB := null;
    end;
    
   l_ourOKPO := lpad(F_Get_Params('OKPO',null), 8, '0');
   l_ourRNK  := F_Get_Params ('OUR_RNK', -1);

   -- тип банку (0 - універсальний, 1 - спеціалізований ощадний)
   l_flag := F_Get_Params ('NORM_TPB', 0);

   -- відсоток негативно класифікованих активів у відповідній групі активів
   IF l_flag > 0 THEN
      l_vNKA := F_Get_Params ('NOR_NKA', 0);
   ELSE  -- для універсального банку не має значення
      l_vNKA := 0;
   END IF;

   --ознака вiдповiдностi банку пп. 2.5-2.7 глави 2 роздiлу VI Iнструкцiї про порядок регулювання дiяльностi банкiв України
   -- а саме - можливiсть виникнення заборгованостi, що перевищує 25% регулятивного капiталу
   ls_prizn:= F_Get_Params ('NORM_OP', 0);

   IF l_flag = 0
   THEN
      l_k1 := 0.25; -- для нормативу Н7
      l_k2 := 0.05; -- для нормативу Н9
      l_k3 := 0; -- для нормативу Н10
   ELSE
      IF l_vNKA = 0 THEN
         l_k1 := 0.05;
         l_k2 := 0.02;
         l_k3 := 0;
      ELSE
         l_k3 := 0;
         l_k2 := 0.02;

         -- для нормативу Н9
         CASE
            WHEN l_vNKA <= 10 THEN
               l_k1 := 0.2;

               -- для нормативу Н10
               CASE
                  WHEN l_vNKA <= 7 THEN l_k3 := 0.2;
                  WHEN l_vNKA <= 10 THEN l_k3 := 0.1;
               ELSE
                  l_k3 := 0;
               END CASE;

            WHEN l_vNKA <= 20 THEN l_k1 := 0.15;
            WHEN l_vNKA <= 30 THEN l_k1 := 0.1;
         ELSE
            l_k1 := 0.5;
         END CASE;

      END IF;
   END IF;

   l_rgk := Rkapital (p_report_date, l_file_code, user_id, 1); 

   if l_rgk <= 0 then
      l_sum_k := 100;
      ls_prizn := 1; -- щоб не формувався показник 41
   else
      l_sum_k := l_rgk;
   end if;

   -- статутний капiтал
   BEGIN
     SELECT SUM(ost)
     INTO   l_sum_SK
     FROM   nbur_dm_balances_daily b, nbur_dm_accounts a
     WHERE  b.report_date = p_report_date and
            b.kf = p_kod_filii and 
            b.acc_id = a.acc_id and
            a.report_date = p_report_date and
            a.kf = p_kod_filii and 
            a.nbs IN ('5000','5001', '5002');
   EXCEPTION WHEN NO_DATA_FOUND THEN
     l_sum_SK:=0 ;
   END ;

   IF NVL(l_sum_SK, 0) = 0 THEN
     l_sum_SK:= NVL(Trim(F_Get_Params ('NORM_SK', 0)), 0);
   END IF;

   p_ins(' -------------------------------- Формування #42 файлу  --------------------------------- ', NULL);

   p_ins('Тип банку -  '|| (CASE l_flag WHEN 0 THEN  'універсальний' ELSE 'ощадний' END), NULL);

   IF l_vNKA > 0 THEN
     p_ins('Відсоток негативно-класифікованих активів: '||TO_CHAR(l_vNKA), NULL);
   END IF;

   p_ins(' --------------------------------- НОРМАТИВИ --------------------------------- ',NULL);

   p_ins('Регулятивний капiтал (РК1): ', l_sum_k);

   p_ins('Показник 01 та 41 ('||TO_CHAR(l_k1*100)||'% від РК1): ',l_sum_k * l_k1);

   p_ins('Показник 02 (10% від РК1): ',l_sum_k * 0.1);

   p_ins('Показник 42 ('||TO_CHAR(l_k2*100)||'% від РК1): ',l_sum_k * l_k2);

   p_ins('Показник 06  (15% від РК1): ',l_sum_k * 0.15);

   IF l_flag>0 THEN
      p_ins('Показник 61 (20% від РК1): ',l_sum_k * 0.2);
   END IF;

   p_ins(' ----------------------------------------------------------------------------------------- ',NULL);

   p_ins('Статутний капiтал: ', l_sum_SK);

   p_ins('Показник 03 ('||TO_CHAR(l_k2*100)||'% від статутного капiталу): ',l_sum_SK * l_k2);

    IF l_k3 <> 0 THEN
       p_ins('Показник 63 ('||TO_CHAR(l_k3*100)||'% від статутного капiталу): ',l_sum_SK * l_k3);
    END IF;

   p_ins('Показник 72  (15% від статутного капiталу): ',l_sum_SK * 0.15);

   -- останн_й робочий день зв_тного пер_оду
   SELECT MAX (FDAT)
      INTO l_pdat
   FROM FDAT
   WHERE FDAT <= p_report_date;
    
   -- формування детального протоколу 
   -- показники по забезпеченню
   INSERT INTO nbur_detail_protocols (report_date,
                                      kf,
                                      report_code,
                                      nbuc,
                                      field_code,
                                      field_value,
                                      description,
                                      acc_id,
                                      acc_num,
                                      kv,
                                      maturity_date,
                                      cust_id,
                                      REF,
                                      nd,
                                      branch)        
    select c.report_date,
           c.kf,
           p_file_code,
           l_nbuc nbuc,
           SUBSTR (k.ddd, 2, 2) || '0000' || '000' field_code, 
           to_char(abs(c.clt_amnt_uah)) field_value,
           'Part 1' description,
           ac.acc_id acc, 
           ac.acc_num nls, 
           ac.kv, 
           ac.maturity_date,
           ac.cust_id rnk,
           null ref, 
           null nd, 
           ac.branch
    from nbur_dm_balances_clt c
    join nbur_dm_accounts ac
    on (ac.report_date = p_report_date and
        ac.kf = p_kod_filii and
        c.clt_acc_id = ac.acc_id)
    join kl_f3_29 k 
    on (k.kf = '42' and 
        k.ddd in  ('047', '051') and
        ac.nbs = k.r020 and
        ac.r013 = k.r012)
    join nbur_dm_accounts aa
    on (aa.report_date = p_report_date and
        aa.kf = p_kod_filii and
        c.ast_acc_id = aa.acc_id)
    where c.report_date = p_report_date and
          c.kf = p_kod_filii ;  
          
    -- показники 001 та 006 
    INSERT INTO NBUR_TMP_F42(ACC, KV, FDAT, NBS, NLS, OST_NOM, OST_EQV,
                     AP, R012, DDD, R020, R013, ACCC, ZAL, K060, RNK, RNKP, OKPO)
    SELECT a.acc, a.kv, a.FDAT, a.nbs, a.nls,
          a.ost_nom, a.ost_eqv,
          DECODE(SIGN(a.ost_nom),-1, 1, 2) ap, a.r012,
          a.ddd, a.r020, a.r013, null, 0, a.k060, a.rnk, nvl(null, a.rnk), okpo
    FROM (SELECT  /*+ parallel leading(k) */ 
                 b.acc_id acc, a.acc_num nls, a.kv, b.report_date FDAT, a.nbs,
                 b.ost ost_nom, b.ostq ost_eqv, 
                 c.cust_id rnk, k.r012, k.ddd, k.r020, a.r013, 
                 c.k060, NVL(ltrim(c.CUST_CODE, '0'),'X') okpo
         FROM nbur_dm_balances_daily b
         join nbur_dm_accounts a
         on (a.kf = b.kf and
             b.acc_id = a.acc_id)
        join nbur_dm_customers c
        on (c.kf = b.kf and
            c.cust_id = b.cust_id)
        join kl_f3_29 k 
        on (k.kf = '42' and 
            k.ddd in  ('001', '006') and
            a.nbs = k.r020)
        where b.report_date = p_report_date and
              b.kf = p_kod_filii and
              b.ost <> 0) a;     
   commit;
   
   -- показник 01 та повязані з ним
   INSERT INTO nbur_detail_protocols (report_date,
                                      kf,
                                      report_code,
                                      nbuc,
                                      field_code,
                                      field_value,
                                      description,
                                      acc_id,
                                      acc_num,
                                      kv,
                                      maturity_date,
                                      cust_id,
                                      REF,
                                      nd,
                                      branch)        
    select p_report_date,
           p_kod_filii,
           p_file_code,
           l_nbuc nbuc,
           dd field_code, 
           znap field_value,
           'Part 2' description,
           null acc, 
           null nls, 
           null kv, 
           null maturity_date,
           rnk,
           null ref, 
           null nd, 
           null branch
     from (with sel_rows as          
            (select b.*, 
                DENSE_RANK() over (partition by b.ddd, b.prins order by b.sum_kor desc) row_num1,
                DENSE_RANK() over (partition by b.ddd, b.prins, tpz order by b.sum_kor desc) row_num2
             from (          
                select ddd, rnk, prins, znap, tp_1, tp_2, tp_3, tp_4, tp_5, tp_6, tp_7, 
                    (case when se + sum_proc < 0 then 0 else se + sum_proc end) se,
                    (case when ((case when se + sum_proc < 0 then 0 else se + sum_proc end) > 
                        ROUND (l_sum_k * l_k1, 0)) and l_rgk >= 0 and ls_prizn=0
                     then 1 else 2 end) tpz,
                    znap - tp_1 - tp_2 - tp_3 - tp_4 sum_kor
                from (
                    select ddd, rnk, prins, znap, tp_1, tp_2, tp_3, tp_4, tp_5, tp_6, tp_7, 
                        znap - tp_1 - tp_2 - tp_3 - tp_4 sum_kor,
                        nvl((select -1*sum(znap) from otc_c5_proc p where p.datf = p_report_date and p.rnk = a.rnk), 0) sum_proc,
                        znap - tp_6 - tp_7 - (case when prins <> '1' then tp_1 + tp_2 + tp_3 + tp_4 else 0 end) se
                    from (
                       SELECT  a.ddd, 
                               a.rnkp rnk,  
                               (case when a.k060 in ('00', '99') then '2' else '1' end) prins,
                               ABS (SUM (a.ost_eqv)) znap,
                               ABS (NVL (sum((case when a.r020 IN ('1502') and NVL (a.r013, '0') NOT IN ('1', '2', '9') or
                                                        a.r020 IN ('1524') and NVL (a.r013, '0') NOT IN ('1', '3') 
                                                then a.ost_eqv
                                                else 0
                                               end)),0)) tp_1,
                               ABS (NVL (sum((case when a.r020 IN ('3003', '3005', '3007', '3010', '3011', '3015') AND NVL (a.r013, '0' ) NOT IN ('9') or
                                                        a.r020 IN ('3006', '3106') AND NVL (a.r013, '0' ) NOT IN ('1') or
                                                        a.r020 IN ('3012', '3014') AND NVL (a.r013, '0' ) NOT IN ('7', '9') or
                                                        a.r020 IN ('3013') AND NVL (a.r013, '0') NOT IN ('5','6','9','A','B','C') or
                                                        a.r020 IN ('3103', '3105', '3107') AND NVL (a.r013, '0') NOT IN ('1', '9')
                                                then a.ost_eqv
                                                else 0
                                              end)),0)) tp_2,
                               ABS (NVL (sum((case when a.r020 = '3212' AND NVL (a.r013, '0') not in ('2', '3')
                                                then a.ost_eqv
                                                else 0
                                              end)),0)) tp_3,
                               ABS (NVL (sum((case when a.r020 = '3540' and NVL (a.r013, '0') not in ('6')
                                                then a.ost_eqv
                                                else 0
                                              end)),0)) tp_4,
                               ABS (NVL (sum((case when a.ost_eqv <> 0 and a.r020 = '3540' and NVL (a.r013, '0') in ('4', '5')
                                                then a.ost_eqv
                                                else 0
                                              end)),0)) tp_5,
                               ABS (NVL (sum((case when a.r020 IN ('9500') and NVL (a.r013, '0') = 3
                                                then a.ost_eqv
                                                else 0
                                               end)),0)) tp_6,
                               ABS (NVL (sum((case when a.r020 IN ('9129') and NVL (a.r013, '0') NOT IN ('0', '1')
                                                then a.ost_eqv
                                                else 0
                                               end)),0)) tp_7                                   
                       FROM NBUR_TMP_F42 a
                       WHERE a.ap=a.r012 AND
                             a.ddd = '001' and
                             NOT exists (SELECT 1
                                         FROM NBUR_TMP_F42 b
                                         WHERE  b.ap=b.r012        AND
                                                b.nbs IS NULL      AND
                                                b.ACCC = a.acc ) and
                             ((l_ourRNK = -1 or a.rnk <> l_ourRNK) AND
                              (l_ourOKPO = '0' or a.okpo<> l_ourOKPO)) 
                       GROUP BY a.ddd, a.rnkp, a.k060
                    ) a
                    where znap<>0) s
                    order by ddd, se desc) b)
            select '01'||lpad(row_num1, 4, '0')||'000' dd, rnk, to_char(se) znap
            from sel_rows
            where prins <> '1' and 
              (se > ROUND (l_sum_k * l_k1, 0) and l_sum_k >= 0 and ls_prizn=0) or
               row_num2 = 1 
               union all
            select '02'||'0000'||'000' dd, rnk, to_char(se) znap
            from sel_rows
            where prins <> '1' and 
                  se > ROUND (l_sum_k * 0.1, 0) and l_rgk >= 0 
               union all   
            select '03'||'0000'||'000' dd, rnk, to_char(se) znap
            from sel_rows
            where prins = '1' and 
                  (row_num2 = 1 or
                   ABS (se) > ROUND (l_sum_k * 0.1, 0))  
                union all 
            select '05'||lpad(row_num1, 4, '0')||'000' dd, rnk, to_char(0) znap
            from sel_rows
            where prins <> '1' and 
              row_num2 = 1 and tpz = 2);
    commit;
    
    -- формування агрегованих показників 
    INSERT INTO nbur_agg_protocols (report_date,
                                    kf,
                                    report_code,
                                    nbuc,
                                    field_code,
                                    field_value)
       SELECT report_date,
              kf,
              report_code,
              nbuc,
              field_code,
              to_char(field_value)
         FROM (SELECT report_date,
                        kf,
                        report_code,
                        nbuc,
                        field_code,
                        SUM (field_value) field_value
                   FROM nbur_detail_protocols
                  WHERE     report_date = p_report_date
                        AND report_code = p_file_code
                        AND kf = p_kod_filii
               GROUP BY report_date,
                        kf,
                        report_code,
                        nbuc,
                        field_code);              

    logger.info ('NBUR_P_F42 end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F42.sql =========*** End **
PROMPT ===================================================================================== 
