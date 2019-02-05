CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F02 (p_kod_filii        varchar2,
                                             p_report_date      date,
                                             p_form_id          number,
                                             p_scheme           varchar2 default 'G',
                                             p_balance_type     varchar2 default 'S',
                                             p_file_code        varchar2 default '#02')
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : ��������� ������������ #02 ��� ��
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.010  05/02/2019 (14/01/2019)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.010  05.02.2019';
/*
   ��������� ���������    DD BBBB VVV Y

   DD         {10,11,20,21,50,51,60,61,70,71,80,81...}
   BBBB       R020 ���������� �������
   VVV        R030 ��� ������
   Y          K041 ������i� �� ������� ���i�

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
���������� ������� ��������� � ��������������� ������� v_nbur_dm_....
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   l_nbuc          varchar2(20);
   l_type          number;
   l_datez         date := p_report_date + 1;
   l_file_code     varchar2(2) := substr(p_file_code, 2, 2);

   -- COBUMMFO-7501 Begin
   l_date_first     date := trunc(p_report_date, 'MM');
   l_date_last      date := last_day(p_report_date);
   l_date_transform date;
   -- COBUMMFO-7501 End
BEGIN
   logger.info ('NBUR_P_F02 begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

   -- ����������� ��������� ���������� (��� ������� ��� ��� ��� �������������)
   nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 1, l_file_code, l_nbuc, l_type, p_report_date);

   -- COBUMMFO-7501 Begin
   -- ���������� ���� ������ ������ �� ���
   begin
	  select max(bal.report_date)
      into l_date_transform
      from nbur_kor_balances bal
      where bal.kf = p_kod_filii
            and bal.report_date between l_date_first and l_date_last;
   exception
	  when others then
 	       l_date_transform := to_date('01011900', 'ddmmyyyy'); -- ������� ���� ������������� ���� ������� �������
   end;
   -- COBUMMFO-7501 End

   if l_date_transform is null then
        BEGIN
           INSERT /*+ APPEND */
                INTO nbur_detail_protocols (report_date,
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
              SELECT /*+ parallel(8) */p_report_date,
                     p_kod_filii,
                     p_file_code,
                     (case when l_type = 0 then l_nbuc else d.nbuc end) nbuc,
                     SUBSTR (d.colname, 2, 2)
                     || d.nbs
                     || SUBSTR ('000' || d.kv, -3)
                     || k041 field_code,
                     field_value,
                     NULL description,
                     acc_id,
                     acc_num,
                     kv,
                     maturity_date,
                     cust_id,
                     NULL,
                     NULL,
                     branch
                FROM (SELECT acc_id,
                             acc_num,
                             nbs,
                             kv,
                             date_off,
                             maturity_date,
                             cust_id,
                             k041,
                             branch,
                             nbuc,
                             colname,
                             ABS (VALUE) field_value
                        FROM (SELECT /*+ ordered*/
                                     c.cust_id,
                                     b.acc_id,
                                     a.maturity_date,
                                     a.kf,
                                     a.acc_num,
                                     a.kv,
                                     a.nbs,
                                     a.close_date date_off,
                                     DECODE (SIGN (b.adj_bal_uah), 1, 0, -adj_bal_uah) P10,
                                     DECODE (SIGN (b.adj_bal_uah), 1, adj_bal_uah, 0) P20,
                                     DECODE (SIGN (b.adj_bal), 1, 0, -adj_bal) P11,
                                     DECODE (SIGN (b.adj_bal), 1, adj_bal, 0) P21,
                                     (CASE
                                         WHEN b.dosq - b.cudosq - b.yr_dos_uah < 0 AND b.kosq - b.cukosq - b.yr_kos_uah < 0
                                            THEN ABS (b.kosq - b.cukosq - b.yr_kos_uah)
                                         WHEN b.kosq - b.cukosq - b.yr_kos_uah < 0 
                                            THEN b.dosq - b.cudosq - b.yr_dos_uah + ABS (b.kosq - b.cukosq - b.yr_kos_uah)
                                         WHEN b.dosq - b.cudosq - b.yr_dos_uah < 0 
                                            THEN 0
                                         ELSE b.dosq - b.cudosq - b.yr_dos_uah 
                                      END)
                                     P50,
                                     (CASE
                                         WHEN b.kosq - b.cukosq - b.yr_kos_uah < 0 AND b.dosq - b.cudosq - b.yr_dos_uah < 0 
                                            THEN ABS (b.dosq - b.cudosq - b.yr_dos_uah)
                                         WHEN b.dosq - b.cudosq - b.yr_dos_uah < 0 
                                            THEN b.kosq - b.cukosq - b.yr_kos_uah + ABS (b.dosq - b.cudosq - b.yr_dos_uah)
                                         WHEN b.kosq - b.cukosq - b.yr_kos_uah < 0 
                                            THEN 0
                                         ELSE b.kosq - b.cukosq - b.yr_kos_uah
                                      END)
                                     P60,
                                     (CASE
                                         WHEN b.kos - b.cukos - b.yr_kos < 0 THEN b.dos - b.cudos - b.yr_dos + ABS (b.kos - b.cukos - b.yr_kos)
                                         WHEN b.dos - b.cudos - b.yr_dos < 0 THEN 0
                                         ELSE b.dos - b.cudos - b.yr_dos
                                      END)
                                        P51,
                                     (CASE
                                         WHEN b.dos - b.cudos - b.yr_dos < 0 THEN b.kos - b.cukos - b.yr_kos + ABS (b.dos - b.cudos - b.yr_dos)
                                         WHEN b.kos - b.cukos - b.yr_kos < 0 THEN 0
                                         ELSE b.kos - b.cukos - b.yr_kos
                                      END)
                                        P61,
                                     -- ����� ���������   
                                     b.crdosq P70,
                                     b.crkosq P80,
                                     b.crdos  P71,
                                     b.crkos  P81,
                                     -- ��� ���������
                                     b.yr_dos_uah P90,
                                     b.yr_kos_uah P00,
                                     b.yr_dos P91,
                                     b.yr_kos P01,    
                                     --                                 
                                     a.branch,
                                     a.nbuc,
                                     c.K041
                                FROM nbur_tmp_kod_r020 k,
                                     nbur_dm_accounts a,
                                     nbur_dm_customers c,
                                     nbur_dm_balances_monthly b
                               WHERE     a.nbs = k.r020
                                     AND a.report_date = p_report_date
                                     AND a.kf = p_kod_filii
                                     AND b.acc_id = a.acc_id
                                     AND b.report_date = p_report_date
                                     AND b.kf = p_kod_filii
                                     AND a.cust_id = c.cust_id
                                     AND c.report_date = p_report_date
                                     AND c.kf = p_kod_filii) UNPIVOT (VALUE
                                                                        FOR colname
                                                                        IN  (P10,
                                                                            P20,
                                                                            P11,
                                                                            P21,
                                                                            P50,
                                                                            P60,
                                                                            P51,
                                                                            P61,
                                                                            P70,
                                                                            P80,
                                                                            P71,
                                                                            P81,
                                                                            P90,
                                                                            P00,
                                                                            P91,
                                                                            P01))) d
           where (d.kv!='980' or d.colname like 'P_0') and d.field_value!=0;
        EXCEPTION
           WHEN OTHERS
           THEN
              logger.info ('NBUR_P_F02 error: ' || SQLERRM);
        END;

        commit;
    else
        BEGIN
           INSERT /*+ APPEND */
                INTO nbur_detail_protocols (report_date,
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
              SELECT /*+ parallel(8) */p_report_date,
                     p_kod_filii,
                     p_file_code,
                     (case when l_type = 0 then l_nbuc else d.nbuc end) nbuc,
                     SUBSTR (d.colname, 2, 2)
                     || d.nbs
                     || SUBSTR ('000' || d.kv, -3)
                     || k041 field_code,
                     field_value,
                     NULL description,
                     acc_id,
                     acc_num,
                     kv,
                     maturity_date,
                     cust_id,
                     NULL,
                     NULL,
                     branch
                FROM (SELECT acc_id,
                             acc_num,
                             nbs,
                             kv,
                             date_off,
                             maturity_date,
                             cust_id,
                             k041,
                             branch,
                             nbuc,
                             colname,
                             ABS (VALUE) field_value
                        FROM (SELECT /*+ ordered*/
                                     c.cust_id,
                                     b.acc_id,
                                     a.maturity_date,
                                     a.kf,
                                     a.acc_num,
                                     a.kv,
                                     a.nbs,
                                     a.close_date date_off,
                                     DECODE (SIGN (b.adj_bal_uah), 1, 0, -adj_bal_uah) P10,
                                     DECODE (SIGN (b.adj_bal_uah), 1, adj_bal_uah, 0) P20,
                                     DECODE (SIGN (b.adj_bal), 1, 0, -adj_bal) P11,
                                     DECODE (SIGN (b.adj_bal), 1, adj_bal, 0) P21,
                                     (CASE
                                         WHEN b.kosq - b.cukosq < 0 THEN b.dosq - b.cudosq + ABS (b.kosq - b.cukosq)
                                         WHEN b.dosq - b.cudosq < 0 THEN 0
                                         ELSE b.dosq - b.cudosq
                                      END)
                                     P50,
                                     (CASE
                                         WHEN b.dosq - b.cudosq < 0 THEN b.kosq - b.cukosq + ABS (b.dosq - b.cudosq)
                                         WHEN b.kosq - b.cukosq < 0 THEN 0
                                         ELSE b.kosq - b.cukosq
                                      END)
                                     P60,
                                     (CASE
                                         WHEN b.kos - b.cukos < 0 THEN b.dos - b.cudos + ABS (b.kos - b.cukos)
                                         WHEN b.dos - b.cudos < 0 THEN 0
                                         ELSE b.dos - b.cudos
                                      END)
                                        P51,
                                     (CASE
                                         WHEN b.dos - b.cudos < 0 THEN b.kos - b.cukos + ABS (b.dos - b.cudos)
                                         WHEN b.kos - b.cukos < 0 THEN 0
                                         ELSE b.kos - b.cukos
                                      END)
                                        P61,
                                     b.crdosq P70,
                                     b.crkosq P80,
                                     b.crdos  P71,
                                     b.crkos  P81,
                                     a.branch,
                                     a.nbuc,
                                     c.K041
                                FROM nbur_tmp_kod_r020 k,
                                     nbur_dm_accounts a,
                                     nbur_dm_customers c,
                                     nbur_dm_balances_monthly b
                               WHERE     a.nbs = k.r020
                                     AND a.report_date = p_report_date
                                     AND a.kf = p_kod_filii
                                     AND b.acc_id = a.acc_id
                                     AND b.report_date = p_report_date
                                     AND b.kf = p_kod_filii
                                     AND a.cust_id = c.cust_id
                                     AND c.report_date = p_report_date
                                     AND (trunc(nvl(a.acc_alt_dt, add_months(p_report_date, -1)), 'mm') <> trunc(p_report_date, 'mm') OR
                                          a.acc_alt_dt is not null and a.acc_num_alt not like '2625%' OR
                                          a.acc_alt_dt is not null and a.acc_num_alt like '2625%' and (a.open_date >= a.acc_alt_dt or a.acc_alt_dt <> l_date_transform))
                                     AND c.kf = p_kod_filii) UNPIVOT (VALUE
                                                                        FOR colname
                                                                        IN  (P10,
                                                                            P20,
                                                                            P11,
                                                                            P21,
                                                                            P50,
                                                                            P60,
                                                                            P51,
                                                                            P61,
                                                                            P70,
                                                                            P80,
                                                                            P71,
                                                                            P81))) d
           where (d.kv!='980' or d.colname like 'P_0') and d.field_value!=0;
        EXCEPTION
           WHEN OTHERS
           THEN
              logger.info ('NBUR_P_F02 error: ' || SQLERRM);
        END;

        commit;

        BEGIN
           INSERT /*+ APPEND */
                INTO nbur_detail_protocols (report_date,
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
              SELECT p_report_date,
                     p_kod_filii,
                     p_file_code,
                     (case when l_type = 0 then l_nbuc else d.nbuc end) nbuc,
                     SUBSTR (d.colname, 2, 2)
                     || d.nbs
                     || SUBSTR ('000' || d.kv, -3)
                     || k041 field_code,
                     field_value,
                     NULL description,
                     acc_id,
                     acc_num,
                     kv,
                     maturity_date,
                     cust_id,
                     NULL,
                     NULL,
                     branch
                FROM (SELECT acc_id,
                             acc_num,
                             nbs,
                             kv,
                             date_off,
                             maturity_date,
                             cust_id,
                             k041,
                             branch,
                             nbuc,
                             colname,
                             ABS (VALUE) field_value
                        FROM (SELECT /*+ ordered*/
                                     c.cust_id,
                                     d.acc_id,
                                     a.maturity_date,
                                     a.kf,
                                     d.acc_num,
                                     a.kv,
                                     substr(d.acc_num, 1, 4) NBS,
                                     a.close_date date_off,
                                     (case when sign(b.adj_bal_uah) = 1 or d.acc_type = 'OLD' then 0 else -adj_bal_uah end) P10,
                                     (case when sign(b.adj_bal_uah) <> 1 or d.acc_type = 'OLD' then 0 else adj_bal_uah end) P20,
                                     (case when sign(b.adj_bal) = 1 or d.acc_type = 'OLD' then 0 else -adj_bal end) P11,
                                     (case when sign(b.adj_bal) <> 1 or d.acc_type = 'OLD' then 0 else adj_bal end) P21,
                                     ----
                                     (case when d.acc_type = 'OLD'
                                           then
                                              d.dosq_repm - b.cudosq
                                           else
                                              b.dosq - nvl(LEAD(d.dosq_repm - d.dosq_repd, 1) OVER (partition by d.acc_id ORDER BY d.acc_type), 0) + d.dosq_repm
                                     end)
                                     P50,
                                     (case when d.acc_type = 'OLD'
                                           then
                                              d.kosq_repm - b.cukosq
                                           else
                                              b.kosq - nvl(LEAD(d.kosq_repm - d.kosq_repd, 1) OVER (partition by d.acc_id ORDER BY d.acc_type), 0) + d.kosq_repm
                                     end)
                                     P60,
                                     (case when d.acc_type = 'OLD'
                                           then
                                              d.dos_repm - b.cudos
                                           else
                                              b.dos - nvl(LEAD(d.dos_repm - d.dos_repd, 1) OVER (partition by d.acc_id ORDER BY d.acc_type), 0) + d.dos_repm
                                     end)
                                     P51,
                                     (case when d.acc_type = 'OLD'
                                           then
                                              d.kos_repm - b.cukos
                                           else
                                              b.kos - nvl(LEAD(d.kos_repm - d.kos_repd, 1) OVER (partition by d.acc_id ORDER BY d.acc_type), 0) + d.kos_repm
                                     end)
                                     P61,
                                     (case when d.acc_type = 'OLD' then 0 else b.crdosq end) P70,
                                     (case when d.acc_type = 'OLD' then 0 else b.crkosq end) P80,
                                     (case when d.acc_type = 'OLD' then 0 else b.crdos end)  P71,
                                     (case when d.acc_type = 'OLD' then 0 else b.crkos end)  P81,
                                     a.branch,
                                     a.nbuc,
                                     c.K041
                                FROM nbur_kor_balances d,
                                     nbur_dm_accounts a,
                                     nbur_dm_customers c,
                                     nbur_dm_balances_monthly b
                               WHERE      substr(d.acc_num,1,4) in (select r020 from nbur_tmp_kod_r020)
                                     AND d.report_date = l_date_transform  -- COBUMMFO-7501 to_date('18122017','ddmmyyyy')
                                     and d.kf = p_kod_filii
                                     and a.acc_id = d.acc_id
                                     AND a.report_date = p_report_date
                                     AND a.kf = p_kod_filii
                                     AND b.acc_id = d.acc_id
                                     AND b.report_date = p_report_date
                                     AND b.kf = p_kod_filii
                                     AND d.cust_id = c.cust_id
                                     AND c.report_date = p_report_date
                                     and trunc(a.acc_alt_dt, 'mm') = trunc(p_report_date, 'mm')
                                     AND c.kf = p_kod_filii
                                     ) UNPIVOT (VALUE
                                                                        FOR colname
                                                                        IN  (P10,
                                                                            P20,
                                                                            P11,
                                                                            P21,
                                                                            P50,
                                                                            P60,
                                                                            P51,
                                                                            P61,
                                                                            P70,
                                                                            P80,
                                                                            P71,
                                                                            P81))) d
           where (d.kv!='980' or d.colname like 'P_0') and d.field_value!=0;
        EXCEPTION
           WHEN OTHERS
           THEN
              logger.info ('NBUR_P_F02 error: ' || SQLERRM);
        END;

        commit;
    end if;

    -- ������������ ����������� �����  �  nbur_agg_protocols
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
              field_value
         FROM (  SELECT report_date,
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

    logger.info ('NBUR_P_F02 end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
END NBUR_P_F02;
/