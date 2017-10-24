

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F12.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_F12 ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F12 (p_kod_filii        varchar2,
                                             p_report_date      date,
                                             p_form_id          number,
                                             p_scheme           varchar2 default 'C',
                                             p_balance_type     varchar2 default 'S',
                                             p_file_code        varchar2 default '#12')
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования @12 для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.002  11.08.2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.002  11.08.2016';
/*
   Структура показника   DD

   DD         символ касплану
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    l_nbuc          varchar2(20);
    l_type          number;
    l_datez         date := p_report_date + 1;
    l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
    l_date_beg      date := nbur_files.f_get_date (p_report_date, 1);
BEGIN
    logger.info ('NBUR_P_F12 begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

    -- определение начальных параметров (код области или МФО или подразделение)
    nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 0, l_file_code, l_nbuc, l_type);

    BEGIN
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
              kf,
              p_file_code,
              (case when l_type = 0 then l_nbuc else a.nbuc end) nbuc,
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
              branch
        from nbur_detail_protocols_arch a
        where report_date between l_date_beg and p_report_date and
            kf = p_kod_filii and
            report_code = '@12' and
            version_id = (select l.version_id
                          from nbur_lst_files l, nbur_ref_files r
                          where l.report_date = a.report_date and
                                l.kf = a.kf and
                                l.file_status = 'FINISHED' and
                                l.file_id = r.id and
                                r.FILE_CODE = '@12') and
           field_code not in ('69', '70', '34', '35');
    EXCEPTION
       WHEN OTHERS
       THEN
          logger.info (
                'NBUR_P_F12 error: '
             || SQLERRM
             || ' for date = '
             || TO_CHAR (p_report_date, 'dd.mm.yyyy'));
    END;

    BEGIN
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
              kf,
              p_file_code,
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
              branch
        from nbur_detail_protocols_arch a
        where report_date = l_date_beg and
            kf = p_kod_filii and
            report_code = '@12' and
            version_id = (select max(l.version_id)
                          from nbur_lst_files l, nbur_ref_files r
                          where l.report_date = a.report_date and
                                l.kf = a.kf and
                                l.file_status in ('FINISHED', 'INVALID') and
                                l.file_id = r.id and
                                r.FILE_CODE = '@12') and
           field_code in ('34', '35');
    EXCEPTION
       WHEN OTHERS
       THEN
          logger.info (
                'NBUR_P_F12 error: '
             || SQLERRM
             || ' for date = '
             || TO_CHAR (p_report_date, 'dd.mm.yyyy'));
    END;

    BEGIN
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
              kf,
              p_file_code,
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
              branch
        from nbur_detail_protocols_arch a
        where report_date = p_report_date and
            kf = p_kod_filii and
            report_code = '@12' and
            version_id = (select max(l.version_id)
                          from nbur_lst_files l, nbur_ref_files r
                          where l.report_date = a.report_date and
                                l.kf = a.kf and
                                l.file_status in ('FINISHED', 'INVALID') and
                                l.file_id = r.id and
                                r.FILE_CODE = '@12') and
           field_code in ('69', '70');
    EXCEPTION
       WHEN OTHERS
       THEN
          logger.info (
                'NBUR_P_F12 error: '
             || SQLERRM
             || ' for date = '
             || TO_CHAR (p_report_date, 'dd.mm.yyyy'));
    END;

    commit;

    -- формирование показателей файла  в  nbur_agg_protocols
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

    logger.info ('NBUR_P_F12 end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

END NBUR_P_F12;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F12.sql =========*** End **
PROMPT ===================================================================================== 
