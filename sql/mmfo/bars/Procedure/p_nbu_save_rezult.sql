

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_NBU_SAVE_REZULT.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_NBU_SAVE_REZULT ***

  CREATE OR REPLACE PROCEDURE BARS.P_NBU_SAVE_REZULT 
( p_rpt_date      in     nbur_agg_protocols_arch.report_date%type
, p_kf            in     nbur_agg_protocols_arch.kf%type
, p_rpt_code      in     nbur_agg_protocols_arch.report_code%type
) is
  /**
  <b>P_NBU_SAVE_REZULT</b> - Перенесення протоколу форування файлу звітності
  %param p_rpt_date  - Звітна дата
  %param p_kf        - Код фiлiалу (МФО)
  %param p_rpt_code  - Код звітного файлу

  %version 1.0
  %usage   Перенесення даних протоколу форування файлу звітності
  */
  title      constant     varchar2(32) := 'NBUR.SAVE_REZULT';
  l_cnt                   number;
  l_file_code             char(2);
  l_file_id               nbur_lst_files.file_id%type;
  l_version_id            nbur_lst_files.version_id%type;
begin

  bars_audit.info( title||': Entry with ( p_rpt_date='||to_char(p_rpt_date,'dd.mm.yyyy')
                        ||', p_kf='||p_kf||', p_rpt_code='||p_rpt_code||' ).' );
  commit;

  l_file_code := subStr(p_rpt_code,2,2);

  insert
    into NBUR_DETAIL_PROTOCOLS
       ( REPORT_DATE, KF, REPORT_CODE, NBUC, FIELD_CODE, FIELD_VALUE, DESCRIPTION
       , ACC_ID, ACC_NUM, KV, MATURITY_DATE, CUST_ID, REF, ND, BRANCH )
  select p_rpt_date, p_kf, p_rpt_code, nvl(trim(nbuc), '300465'), kodp, nvl(znap, ' '), COMM
       , ACC, NLS, KV, MDATE, RNK, REF, ND, TOBO
    from RNBU_TRACE;

  commit;

  if ( p_rpt_code like '#%' )
  then

    l_file_id := NBUR_FILES.F_GET_ID_FILE( p_rpt_code, (case when p_rpt_code in ('#79', '#26', '#D4', '#E9', '#3D') then 'D' else 'C' end), 1 );

    if ( p_rpt_code like '#E2%' )
    then -- консолідація
      
      insert all
        when ( FIELD_CODE like '20%' )
        then into NBUR_AGG_PROTOCOLS
                ( REPORT_DATE, KF, REPORT_CODE, NBUC, FIELD_CODE, FIELD_VALUE )
           values
                ( REPORT_DATE, KF, REPORT_CODE, NBUC, FIELD_CODE, SUM_VAL )
        else into NBUR_AGG_PROTOCOLS
                ( REPORT_DATE, KF, REPORT_CODE, NBUC, FIELD_CODE, FIELD_VALUE )
           values
                ( REPORT_DATE, KF, REPORT_CODE, NBUC, FIELD_CODE, MAX_VAL )
      select REPORT_DATE
           , KF
           , REPORT_CODE
           , NBUC
           , FIELD_CODE
           , to_char( sum( case
                           when FIELD_CODE like '20%'
                           then to_number(FIELD_VALUE)
                           else 0
                           end )
                    ) as SUM_VAL
           , max( FIELD_VALUE ) as MAX_VAL
        from NBUR_DETAIL_PROTOCOLS
       WHERE REPORT_DATE = p_rpt_date
         AND REPORT_CODE = p_rpt_code
         AND KF          = p_kf
       group by REPORT_DATE, KF, REPORT_CODE, NBUC, FIELD_CODE;

    else

      insert
        into NBUR_AGG_PROTOCOLS
           ( REPORT_DATE, KF, REPORT_CODE, NBUC, FIELD_CODE, FIELD_VALUE, ERROR_MSG, ADJ_IND )
      select unique datf, kf, p_rpt_code, nvl(trim(nbuc), '300465'), kodp, nvl(znap, ' '), ERR_MSG, FL_MOD
       from TMP_NBU
      where KODF = l_file_code
        and DATF = p_rpt_date
        and KF   = p_kf;

    end if;

  else

    l_file_id := NBUR_FILES.F_GET_ID_FILE( p_rpt_code, 'C', 2 );

    insert
      into NBUR_AGG_PROTOCOLS
         ( REPORT_DATE, KF, REPORT_CODE, NBUC, FIELD_CODE, FIELD_VALUE, ERROR_MSG, ADJ_IND )
    select unique datf, kf, p_rpt_code, nvl(trim(nbuc), '300465'), kodp, nvl(znap, ' '), ERR_MSG, FL_MOD
      from TMP_IREP
     where KODF = l_file_code
       and DATF = p_rpt_date
       and KF   = p_kf;

  end if;

  select count(*)
    into l_cnt
    from OTCN_LOG
   where KODF = l_file_code;

  if ( l_cnt > 0 )
  then

    select max(VERSION_ID)
      into l_version_id
      from NBUR_LST_FILES
     where FILE_ID     = l_file_id
       and REPORT_DATE = p_rpt_date
       and KF          = p_kf
       and FILE_STATUS = 'RUNNING';

    insert
      into NBUR_LST_MESSAGES
         ( REPORT_DATE, KF, REPORT_CODE, VERSION_ID, MESSAGE_ID, MESSAGE_TXT, USERID )
    select p_rpt_date, p_kf, p_rpt_code, l_version_id, ID, TXT, USERID
      from OTCN_LOG
     where KODF = l_file_code
     order by id;

   end if;

  commit;

  bars_audit.trace( '%s: Exit.', title );

exception
  when others then
    bars_audit.error( SubStr( title||': error during saving '||CHR(10)
                                   ||sqlerrm||CHR(10)
                                   ||dbms_utility.format_error_backtrace()
                            , 1, 4000 ) );
end P_NBU_SAVE_REZULT;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_NBU_SAVE_REZULT.sql =========***
PROMPT ===================================================================================== 
