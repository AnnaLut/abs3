create or replace procedure NBUR_P_I75 
( p_kod_filii        in     varchar2
, p_report_date      in     date
, p_form_id          in     number   default null
, p_scheme           in     varchar2 default 'C'
, p_balance_type     in     varchar2 default 'S'
, p_file_code        in     varchar2 default '@75'
) is
  /*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % DESCRIPTION : Процедура формирования @75 для Ощадного банку
  % COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
  %
  % VERSION     : v.1.4  24.01.2018
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  l_nbuc          varchar2(20);
  l_type          number;
  l_datez         date;
  l_file_code     varchar2(2);
BEGIN
  
  bars_audit.info( $$PLSQL_UNIT||' begin for date = '||to_char(p_report_date,'dd.mm.yyyy') );
  
  l_datez     := p_report_date + 1;
  l_file_code := substr(p_file_code,2,2);
  
  -- определение начальных параметров (код области или МФО или подразделение)
  NBUR_FILES.P_PROC_SET( p_kod_filii, p_file_code, p_scheme, l_datez, 0, l_file_code, l_nbuc, l_type );
  
  bars_audit.trace( '%s: nbuc=%s, type=%s, first_dt=%s, last_dt=%s.', $$PLSQL_UNIT, l_nbuc, to_char(l_type) );
  
  -- execute immediate 'ALTER SESSION ENABLE PARALLEL DML';
  
  -- open SALDO (  otcn_saldo + specparam_int);
  insert all
    when ( R034 = 1 ) 
    then -- нацювалюта
      into NBUR_DETAIL_PROTOCOLS 
        ( REPORT_DATE, KF, REPORT_CODE, NBUC, FIELD_CODE, FIELD_VALUE, ACC_ID, ACC_NUM, KV )
      values
        ( p_report_date, p_kod_filii, p_file_code, NBUC, FIELD_CODE, FIELD_VALUE, ACC_ID, ACC_NUM, KV )
    else -- інвалюта
      into NBUR_DETAIL_PROTOCOLS 
        ( REPORT_DATE, KF, REPORT_CODE, NBUC, FIELD_CODE, FIELD_VALUE, ACC_ID, ACC_NUM, KV )
      values
        ( p_report_date, p_kod_filii, p_file_code, NBUC, FIELD_CODE, FIELD_VALUE, ACC_ID, ACC_NUM, KV )
      into NBUR_DETAIL_PROTOCOLS 
        ( REPORT_DATE, KF, REPORT_CODE, NBUC, FIELD_CODE, FIELD_VALUE, ACC_ID, ACC_NUM, KV )
      values
        ( p_report_date, p_kod_filii, p_file_code, NBUC, FIELD_CODE_UAH, FIELD_VALUE_UAH, ACC_ID, ACC_NUM, KV )
  select /*+ PARALLEL 4 */ 
         case 
           when l_type > 0 
           then acc.NBUC -- acc.B040
           else l_nbuc
         end as NBUC
       , case 
           when bal.ADJ_BAL < 0
           then '1'
           when bal.ADJ_BAL > 0
           then '2'
           else to_char(acc.PAP)
         end ||
         case
           when acc.KV = 980
           then '0'
           else '1'
         end || acc.NBS || acc.OB22 || to_char(acc.KV,'FM000') || '00' as FIELD_CODE
       , to_char(abs(bal.ADJ_BAL)) as FIELD_VALUE
       , case 
           when bal.ADJ_BAL < 0
           then '1'
           when bal.ADJ_BAL > 0
           then '2'
           else to_char(acc.PAP)
         end || '0' || acc.NBS || acc.OB22 || lpad(acc.KV,3,'0') || '00' as FIELD_CODE_UAH
       , to_char(abs(bal.ADJ_BAL_UAH)) as FIELD_VALUE_UAH
       , case
           when acc.KV = 980
           then 1
           else 2
         end as R034
       , acc.ACC_ID
       , acc.ACC_NUM
       , acc.KV
    from NBUR_DM_ACCOUNTS         acc
    join NBUR_DM_BALANCES_MONTHLY bal
      on ( bal.KF = acc.KF and bal.ACC_ID = acc.ACC_ID )
   where acc.KF = p_kod_filii
     and acc.NBS in ( select R020
                        from SB_R020
                       where F_75 = '1'
                         and lnnvl( D_CLOSE <= p_report_date )
                    )
     and ( ADJ_BAL <> 0 or ADJ_BAL_UAH <> 0 )
  ;
  
  commit;
  
  -- OPEN OBOROTY ()
  insert all
    when ( Ind1 = '5' and Ind2 = '0' ) 
    then -- Дт. (нацювалюта) 
      into NBUR_DETAIL_PROTOCOLS 
         ( REPORT_DATE, KF, REPORT_CODE, NBUC
         , FIELD_CODE, FIELD_VALUE, ACC_ID, ACC_NUM, KV, REF, DESCRIPTION )
      values
         ( p_report_date, KF, p_file_code, NBUC_DB
         , Ind1 || Ind2 || R020_DB || OB22_DB || Ind3 || Ind4_DB, FIELD_VALUE
         , ACC_ID_DB, ACC_NUM_DB, CCY_ID, REF, DESCRIPTION )
    when ( Ind1 = '6' and Ind2 = '0' ) 
    then -- Кт. (нацювалюта)
      into NBUR_DETAIL_PROTOCOLS 
         ( REPORT_DATE, KF, REPORT_CODE, NBUC
         , FIELD_CODE, FIELD_VALUE, ACC_ID, ACC_NUM, KV, REF, DESCRIPTION )
      values
         ( p_report_date, KF, p_file_code, NBUC_CR
         , Ind1 || Ind2 || R020_CR || OB22_CR || Ind3 || Ind4_CR, FIELD_VALUE
         , ACC_ID_CR, ACC_NUM_CR, CCY_ID, REF, DESCRIPTION )
    when ( Ind1 = '5' and Ind2 = '1' ) 
    then -- Дт. (інвалюта + еквівалент) 
      into NBUR_DETAIL_PROTOCOLS 
         ( REPORT_DATE, KF, REPORT_CODE, NBUC
         , FIELD_CODE, FIELD_VALUE, ACC_ID, ACC_NUM, KV, REF, DESCRIPTION )
      values
         ( p_report_date, KF, p_file_code, NBUC_DB
         , Ind1 || Ind2 || R020_DB || OB22_DB || Ind3 || Ind4_DB, FIELD_VALUE
         , ACC_ID_DB, ACC_NUM_DB, CCY_ID, REF, DESCRIPTION )
      into NBUR_DETAIL_PROTOCOLS 
         ( REPORT_DATE, KF, REPORT_CODE, NBUC
         , FIELD_CODE, FIELD_VALUE, ACC_ID, ACC_NUM, KV, REF, DESCRIPTION )
      values
         ( p_report_date, KF, p_file_code, NBUC_DB
         , Ind1 || Ind2 || R020_DB || OB22_DB || Ind3 || Ind4_DB, FIELD_VALUE_UAH
         , ACC_ID_DB, ACC_NUM_DB, CCY_ID, REF, DESCRIPTION )
    when ( Ind1 = '6' and Ind2 = '1' ) 
    then -- Кт. (інвалюта + еквівалент)
      into NBUR_DETAIL_PROTOCOLS 
         ( REPORT_DATE, KF, REPORT_CODE, NBUC
         , FIELD_CODE, FIELD_VALUE, ACC_ID, ACC_NUM, KV, REF, DESCRIPTION )
      values
         ( p_report_date, KF, p_file_code, NBUC_CR
         , Ind1 || Ind2 || R020_CR || OB22_CR || Ind3 || Ind4_CR, FIELD_VALUE
         , ACC_ID_CR, ACC_NUM_CR, CCY_ID, REF, DESCRIPTION )
      into NBUR_DETAIL_PROTOCOLS 
         ( REPORT_DATE, KF, REPORT_CODE, NBUC
         , FIELD_CODE, FIELD_VALUE, ACC_ID, ACC_NUM, KV, REF, DESCRIPTION )
      values
         ( p_report_date, KF, p_file_code, NBUC_CR
         , Ind1 || Ind2 || R020_CR || OB22_CR || Ind3 || Ind4_CR, FIELD_VALUE_UAH
         , ACC_ID_CR, ACC_NUM_CR, CCY_ID, REF, DESCRIPTION )
    when ( CHK_F = 1 and Ind2 = '0' ) 
    then -- Кт. (нацювалюта)
      into NBUR_DETAIL_PROTOCOLS 
         ( REPORT_DATE, KF, REPORT_CODE, NBUC
         , FIELD_CODE, FIELD_VALUE, ACC_ID, ACC_NUM, KV, REF, DESCRIPTION )
      values
         ( p_report_date, KF, p_file_code, NBUC_CR
         , Ind1 || Ind2 || R020_CR || OB22_CR || Ind3 || Ind4_CHK, FIELD_VALUE
         , ACC_ID_CR, ACC_NUM_CR, CCY_ID, REF, DESCRIPTION )
    when ( CHK_F = 1 and Ind2 = '1' ) 
    then -- Кт. (інвалюта + еквівалент)
      into NBUR_DETAIL_PROTOCOLS 
         ( REPORT_DATE, KF, REPORT_CODE, NBUC
         , FIELD_CODE, FIELD_VALUE, ACC_ID, ACC_NUM, KV, REF, DESCRIPTION )
      values
         ( p_report_date, KF, p_file_code, NBUC_CR
         , Ind1 || Ind2 || R020_CR || OB22_CR || Ind3 || Ind4_CHK, FIELD_VALUE
         , ACC_ID_CR, ACC_NUM_CR, CCY_ID, REF, CHK_DSC )
      into NBUR_DETAIL_PROTOCOLS 
         ( REPORT_DATE, KF, REPORT_CODE, NBUC
         , FIELD_CODE, FIELD_VALUE, ACC_ID, ACC_NUM, KV, REF, DESCRIPTION )
      values
         ( p_report_date, KF, p_file_code, NBUC_CR
         , Ind1 || Ind2 || R020_CR || OB22_CR || Ind3 || Ind4_CHK, FIELD_VALUE_UAH
         , ACC_ID_CR, ACC_NUM_CR, CCY_ID, REF, CHK_DSC )
  select /*+ parallel( txn 8 ) */
         txn.KF, txn.REF, txn.CCY_ID
       , to_char(txn.BAL    ) as FIELD_VALUE
       , to_char(txn.BAL_UAH) as FIELD_VALUE_UAH
       , txn.ACC_ID_DB, txn.ACC_NUM_DB, txn.R020_DB, nvl(txn.OB22_DB,'00') as OB22_DB
       , case 
           when l_type > 0 
           then acd.NBUC
           else l_nbuc
         end as NBUC_DB
       , txn.ACC_ID_CR, txn.ACC_NUM_CR, txn.R020_CR, nvl(txn.OB22_CR,'00') as OB22_CR
       , case 
           when l_type > 0 
           then ack.NBUC
           else l_nbuc
         end as NBUC_CR
       , substr( ' Дт. рах. = ' || txn.ACC_NUM_DB || ', Кт. рах. = ' || txn.ACC_NUM_CR, 1, 250 ) as DESCRIPTION
       , case
           when rdb.F_75 in ('1','5') 
           then '5'
           when rcr.F_75 in ('1','6') 
           then '6'
           else null
         end as Ind1
       , case
           when txn.CCY_ID = 980
           then '0'
           else '1'
         end as Ind2
       , to_char(txn.CCY_ID,'FM000') as Ind3
       , case
           when rdb.F_75 in ('1','5')
           then
             case
               when txn.R020_DB = '7700'
               then case
                    when txn.OB22_DB in ('02','07')
                    then '01'
                    when txn.OB22_DB in ('04','09')
                    then '12'
                    when txn.OB22_DB in ('06')
                    then '14'
                    else '__'
                    end
               when txn.R020_DB = '7701'
               then case
                    when txn.OB22_DB in ('02','09','23','24')
                    then '01'
                    when txn.OB22_DB in ('04','11','26','27')
                    then '12'
                    when txn.OB22_DB in ('07','25')
                    then '14'
                    else '__'
                    end
               when txn.R020_DB = '7702'
               then case
                    when txn.OB22_DB in ('11','12','22','65','66','75','79','83','85','92','94','96')
                    then '01'
                    when txn.OB22_DB in ('14','15','62','67','68','77','81','84','86','93','95','97')
                    then '12'
                    when txn.OB22_DB in ('17','18','19','53','54','55')
                    then '14'
                    else '__'
                    end
               when txn.R020_DB = '7703'
               then case
                    when txn.OB22_DB in ('01','03','07','09')
                    then '01'
                    when txn.OB22_DB in ('06','08','13','16')
                    then '12'
                    when txn.OB22_DB in ('12','23')
                    then '14'
                    else '__'
                    end
               when txn.R020_DB = '7704'
               then case
                    when txn.OB22_DB in ('02','05','10','13')
                    then '01'
                    when txn.OB22_DB in ('03','07','11','14')
                    then '12'
                    when txn.OB22_DB in ('06','15')
                    then '14'
                    else '__'
                    end
               when txn.R020_DB = '7705'
               then case
                    when txn.R020_DB in ('02')
                    then '01'
                    when txn.R020_DB in ('06')
                    then '12'
                    else '__'
                    end
               when txn.R020_DB = '7706'
               then case
                    when txn.OB22_DB in ('01','07','11','19')
                    then '01'
                    when txn.OB22_DB in ('02','08','12','18')
                    then '12'
                    else '__'
                    end
               when txn.R020_DB = '7707'
               then case
                    when txn.OB22_DB in ('01','04','06','13','14','17','19','21','25')
                    then '01'
                    when txn.OB22_DB in ('02','05','07','15','16','18','20','22')
                    then '12'
                    when txn.OB22_DB in ('03,08')
                    then '14'
                    else '__'
                    end
               -- кошти направленi на формування резерву
               when txn.R020_DB like '7%' and txn.R020_CR like '380%'
               then '01'
               --
               when txn.CCY_ID = 980 and txn.R020_DB like '7%' and 
                  ( txn.R020_CR like '149%' or txn.R020_CR like '159%' or txn.R020_CR like '189%' or
                    txn.R020_CR like '240%' or txn.R020_CR like '289%' or txn.R020_CR like '319%' or  
                    txn.R020_CR like '329%' or txn.R020_CR like '359%' or txn.R020_CR like '369%' )
               then '01'
               -- зменшення резервiв за рахунок уточнень
               when ( txn.R020_DB like '1%' or txn.R020_DB like '2%' or txn.R020_DB like '3%' 
                    ) and txn.R020_CR like '380%' 
               then '02'
               -- списання за рахунок резерву
               when txn.R020_DB not like '7%' and
                  ( txn.R020_CR like '1%' or txn.R020_CR like '2%' or txn.R020_CR like '3%' 
                  ) and txn.R020_CR not like '380%' 
               then '03'
               -- повернення заборгованностi
               when txn.CCY_ID = 980 and 
                  ( txn.R020_DB like '1%' or txn.R020_DB like '2%' or txn.R020_DB like '3%'
                  ) and txn.R020_CR like '7%' 
               then '02'
               -- перерахування до iнших фондових рахункiв
               when txn.CCY_ID = 980 and 
                  ( txn.R020_DB like '1%' or txn.R020_DB like '2%' or txn.R020_DB like '3%'
                  ) and txn.R020_CR like '5%' 
               then '05'
               when txn.CCY_ID = 980 and txn.R020_DB like '7%' and txn.R020_CR = '3739' 
               then '07'
               when ( txn.R020_DB like '149%' or txn.R020_DB like '159%' or txn.R020_DB like '189%' or
                      txn.R020_DB like '240%' or txn.R020_DB like '289%' or txn.R020_DB like '319%' or 
                      txn.R020_DB like '329%' or txn.R020_DB like '359%' or txn.R020_DB like '369%' 
                    ) and txn.R020_CR = '3739'
               then '07'
               -- виправнi обороти щодо коду 01
               when txn.R020_DB = txn.R020_CR
               then '11'
               -- зменшення резервiв за рахунок прибутку банку
               when txn.CCY_ID = 980 and 
                  ( txn.R020_DB like '7%' and txn.OB22_DB = '06' ) and 
                  ( txn.R020_CR  = '3590' and txn.OB22_CR = '03' ) 
               then '12'
               else '00'
             end
           else '00'
         end as Ind4_DB
       ----------------
       , case
           when rcr.F_75 in ('1','6')
           then
             case
               when txn.R020_CR = '7700'
               then case
                    when txn.OB22_CR in ('02','07')
                    then '11'
                    when txn.OB22_CR in ('04','09')
                    then '02'
                    when txn.OB22_CR in ('06')
                    then '04'
                    else '__'
                    end
               when txn.R020_CR = '7701'
               then case
                    when txn.OB22_CR in ('02','09','23','24')
                    then '11'
                    when txn.OB22_CR in ('04','11','26','27')
                    then '02'
                    when txn.OB22_CR in ('07','25')
                    then '04'
                    else '__'
                    end
               when txn.R020_CR = '7702'
               then case 
                    when txn.OB22_CR in ('11','12','22','65','66','75','79','83','85','92','94','96')
                    then '11'
                    when txn.OB22_CR in ('14','15','62','67','68','77','81','84','86','93','95','97')
                    then '02'
                    when txn.OB22_CR in ('17','18','19','53','54','55')
                    then '04'
                    else '__'
                    end
               when txn.R020_CR = '7703'
               then case
                    when txn.OB22_CR in ('01','03','07','09')
                    then '11'
                    when txn.OB22_CR in ('06','08','13','16')
                    then '02'
                    when txn.OB22_CR in ('12','23')
                    then '04'
                    else '__'
                    end
               when txn.R020_CR = '7704'
               then case
                    when txn.OB22_CR in ('02','05','10','13')
                    then '11'
                    when txn.OB22_CR in ('03','07','11','14')
                    then '02'
                    when txn.OB22_CR in ('06','15')
                    then '04'
                    else '__'
                    end
               when txn.R020_CR = '7705'
               then case
                    when txn.OB22_CR in ('02')
                    then '11'
                    when txn.OB22_CR in ('06')
                    then '02'
                    else '__'
                    end
               when txn.R020_CR = '7706'
               then case 
                    when txn.OB22_CR in ('01','07','11','19')
                    then '11'
                    when txn.OB22_CR in ('02','08','12','18')
                    then '02'
                    else '__'
                    end
               when txn.R020_CR = '7707'
               then case 
                    when txn.OB22_CR in ('01','04','06','13','14','17','19','21','25')
                    then '11'
                    when txn.OB22_CR in ('02','05','07','15','16','18','20','22')
                    then '02'
                    when txn.OB22_CR in ('03,08')
                    then '04'
                    else '__'
                    end
               -- кошти направленi на формування резерву
               when txn.R020_DB like '7%' and txn.R020_CR not like '7%'
               then '01'
               -- виправнi обороти щодо коду 01
               when txn.R020_DB = txn.R020_CR
               then '01'
               -- при формировании новых счетов для резерва
               when txn.R020_DB = '3739' and txn.R020_CR like '7%'
               then '07'
               -- при формировании новых счетов для резерва
               when txn.R020_DB = '3739' and 
                  ( txn.R020_CR like '149%' or txn.R020_CR like '159%' or txn.R020_CR like '189%' or 
                    txn.R020_CR like '240%' or txn.R020_CR like '289%' or txn.R020_CR like '319%' or
                    txn.R020_CR like '329%' or txn.R020_CR like '359%' or txn.R020_CR like '369%' ) 
               then '07'
               -- зменшення резервiв за рахунок прибутку банку
               when txn.CCY_ID = 980 and (txn.R020_DB like '7%' and txn.OB22_DB = '06') 
                                 and (txn.R020_CR  = '3590' and txn.OB22_CR = '03') 
               then '12'
               else '00'
             end
           else '00'
         end as Ind4_CR
       ----------------
       , case
           when rcr.F_75 in ('1','6') and nvl(rdb.F_75,'0') = '0'
           then 1
           else 0
         end as CHK_F
       , case
           when rcr.F_75 in ('1','6') and nvl(rdb.F_75,'0') = '0'
           then substr( ' Дт. рах. = ' || txn.ACC_NUM_DB || ', Кт. рах. = ' 
                                       || txn.ACC_NUM_CR || '  !!! Проверка !!!'
                      , 1, 250 )
           else null
         end CHK_DSC
       ----------------
       , case
           when rcr.F_75 in ('1','6') and nvl(rdb.F_75,'0') = '0'
           then
             case
               -- кошти направленi на формування резерву
               when txn.R020_DB like '380%' and txn.R020_CR not like '7%' 
               then '01'
               when txn.R020_DB like '7%'   and txn.R020_CR not like '7%'
               then '01'
               -- зменшення резервiв за рахунок уточнень
               when txn.CCY_ID = 980 and txn.R020_DB like '3801%' and txn.R020_CR like '7%'
               then '02'
               -- повернення заборгованностi
               when ( txn.R020_DB like '1%' or txn.R020_DB like '2%' or txn.R020_DB like '3%' 
                    ) and txn.R020_DB not like '3801%' and txn.R020_CR like '7%' 
               then '04'
               -- при формировании новых счетов для резерва
               when txn.R020_DB = '3739' and txn.R020_CR like '7%' 
               then '07'
               -- при формировании новых счетов для резерва
               when txn.R020_DB = '3739' and 
                  ( txn.R020_CR like '149%' or txn.R020_CR like '159%' or txn.R020_CR like '189%' or 
                    txn.R020_CR like '240%' or txn.R020_CR like '289%' or txn.R020_CR like '319%' or
                    txn.R020_CR like '329%' or txn.R020_CR like '359%' or txn.R020_CR like '369%' ) 
               then '07'
               -- списання резерву
               when txn.R020_DB = '3903' and 
                  ( txn.R020_CR like '149%' or txn.R020_CR like '159%' or txn.R020_CR like '189%' or 
                    txn.R020_CR like '240%' or txn.R020_CR like '289%' or txn.R020_CR like '319%' or
                    txn.R020_CR like '329%' or txn.R020_CR like '359%' or txn.R020_CR like '369%' ) 
               then '07'
               else '00'
             end
           else '00'
         end as Ind4_CHK
    from NBUR_DM_TRANSACTIONS_CNSL txn
    join NBUR_DM_ACCOUNTS acd
      on ( acd.KF = txn.KF and acd.ACC_ID = txn.ACC_ID_DB )
    join NBUR_DM_ACCOUNTS ack
      on ( ack.KF = txn.KF and ack.ACC_ID = txn.ACC_ID_CR )
    left 
    join SB_R020 rdb
      on ( rdb.R020 = txn.R020_DB )
    left 
    join SB_R020 rcr
      on ( rcr.R020 = txn.R020_CR )
   where txn.KF = p_kod_filii
     and txn.TT Not like 'ZG_'
     and ( rdb.F_75 = '1' and lnnvl( rdb.D_CLOSE <= p_report_date ) or
           rcr.F_75 = '1' and lnnvl( rcr.D_CLOSE <= p_report_date ) )
  ;
  
  commit;
  
  -- розрахунок показників курсової різниці (код 06)
  insert all
    when ( Ind_DB Is Not Null ) 
    then
      into NBUR_DETAIL_PROTOCOLS 
         ( REPORT_DATE, KF, REPORT_CODE, NBUC
         , FIELD_CODE, FIELD_VALUE, ACC_ID, ACC_NUM, KV, DESCRIPTION )
      values
         ( p_report_date, KF, p_file_code, NBUC
         , Ind_DB || R020 || OB22 || R030 || '06', OUTCOME_DB
         , ACC_ID, ACC_NUM, CCY_ID, DESCRIPTION )
    when ( Ind_CR Is Not Null ) 
    then
      into NBUR_DETAIL_PROTOCOLS 
         ( REPORT_DATE, KF, REPORT_CODE, NBUC
         , FIELD_CODE, FIELD_VALUE, ACC_ID, ACC_NUM, KV, DESCRIPTION )
      values
         ( p_report_date, KF, p_file_code, NBUC
         , Ind_CR || R020 || OB22 || R030 || '06', OUTCOME_CR
         , ACC_ID, ACC_NUM, CCY_ID, DESCRIPTION )
  select case
           when OUTCOME_DB > 0 then '50'
           when OUTCOME_DB < 0 then '60'
           else null
         end as Ind_DB
       , to_char(abs(OUTCOME_DB)) as OUTCOME_DB
       , case
           when OUTCOME_CR > 0 then '60'
           when OUTCOME_CR < 0 then '50'
           else null
         end as Ind_CR
       , to_char(abs(OUTCOME_CR)) OUTCOME_CR
       , t.R020
       , t.OB22
       , t.R030
       , t.NBUC
       , t.KF
       , t.ACC_ID
       , t.ACC_NUM
       , t.CCY_ID
       , 'формирование показетелей переоценки' as DESCRIPTION
    from ( select /*+ no_parallel */ a.KF, a.ACC_ID, a.ACC_NUM
                , a.KV  as CCY_ID
                , a.NBS as R020  
                , a.OB22
                , lpad(to_char(a.kv),3,'0') as R030 
                , nvl(p.DOS,0) as DOS
                , nvl(p.KOS,0) as KOS
                , nvl(b.DOSQ - b.CUDOSQ,0) as DOSQ
                , nvl(b.KOSQ - b.CUKOSQ,0) as KOSQ
                , case 
                    when l_type > 0 
                    then a.NBUC -- acc.B040
                    else l_nbuc
                  end as NBUC
                , nvl(b.DOSQ - b.CUDOSQ,0) - nvl(p.DOS,0) as OUTCOME_DB
                , nvl(b.KOSQ - b.CUKOSQ,0) - nvl(p.KOS,0) as OUTCOME_CR
             from NBUR_DM_ACCOUNTS a
             join SB_R020 r
               on ( r.R020 = a.NBS )
             left
             join NBUR_DM_BALANCES_MONTHLY b
               on ( b.KF = a.KF and b.ACC_ID = a.ACC_ID )
             left
             join ( select KF, ACC_ID, ACC_NUM, KV
                         , substr(FIELD_CODE,3,4) as NBS 
                         , substr(FIELD_CODE,7,2) as OB22
                         , substr(FIELD_CODE,9,3) as KVP
                         , sum( case when (substr(FIELD_CODE,1,2)='50') then to_number(FIELD_VALUE) else 0 end ) as DOS
                         , sum( case when (substr(FIELD_CODE,1,2)='60') then to_number(FIELD_VALUE) else 0 end ) as KOS
                      from NBUR_DETAIL_PROTOCOLS  
                     where kv != 980
                     group 
                        by KF, ACC_ID, ACC_NUM, KV
                         , substr(FIELD_CODE,3,4)
                         , substr(FIELD_CODE,7,2)
                         , substr(FIELD_CODE,9,3)
                  ) p
               on ( p.KF = a.KF and p.ACC_ID = a.ACC_ID )
            where a.KF = p_kod_filii
              and a.KV != 980
              and r.F_75 = '1'
              and lnnvl( r.D_CLOSE <= p_report_date )
              and lnnvl( a.CLOSE_DATE < trunc(p_report_date,'MM') )
          ) t 
    where ( t.DOSQ <> t.DOS AND t.DOSQ <> 0 and t.DOS >=0 )
       or ( t.KOSQ <> t.DOS AND t.KOSQ <> 0 and t.KOS >=0 )
  ;
  
  -- OPEN BaseL;
  insert 
    into NBUR_AGG_PROTOCOLS
       ( REPORT_DATE, KF, REPORT_CODE, NBUC, FIELD_CODE, FIELD_VALUE )
  select REPORT_DATE, KF, REPORT_CODE, NBUC, FIELD_CODE, sum(to_number(FIELD_VALUE))
    from NBUR_DETAIL_PROTOCOLS
   where REPORT_DATE = p_report_date
     and KF          = p_kod_filii
     and REPORT_CODE = p_file_code
   group by REPORT_DATE, KF, REPORT_CODE, NBUC, FIELD_CODE;

  bars_audit.info( $$PLSQL_UNIT||' end for date = '||TO_CHAR(p_report_date, 'dd.mm.yyyy') );
  
end NBUR_P_I75;
/

show err;

grant EXECUTE on NBUR_P_I75 to BARS_ACCESS_DEFROLE;
