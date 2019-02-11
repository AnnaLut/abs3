
PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_F2GX.sql =========*** Run ***
PROMPT ===================================================================================== 

CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F2GX (p_kod_filii  varchar2
                                            , p_report_date      date
                                            , p_form_id          number
                                            , p_scheme           varchar2 default 'C'
                                            , p_file_code        varchar2 default '2GX')
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 DESCRIPTION :    Процедура формирования 2GX
 COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.

 VERSION     :    v.19.001    14.01.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: p_report_date - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  l_p_version       char(30)  := ' v.19.001  14.01.2019';

  c_title           constant varchar2(100 char) := $$PLSQL_UNIT || '.';

  l_nbuc          varchar2(20);
  l_type          number;
  l_datez         date := p_report_date + 1;
  l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
  l_old_file_code varchar2(3) := '#2G';
  l_version       number;

     l_d100    varchar2(2);
     l_days    number;

  --Exception
  e_ptsn_not_exsts exception;

  pragma exception_init( e_ptsn_not_exsts, -02149 );
begin
  logger.info (c_title || ' begin for date = '||to_char(p_report_date, 'dd.mm.yyyy')||l_p_version);

  -- визначення початкових параметрів для формування файлу
  nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 1, l_file_code, l_nbuc, l_type);
  
  --Очистка партиции для хранения детального протокола
  begin
    execute immediate 'alter table NBUR_LOG_F2GX truncate subpartition for ( to_date('''
                      || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
  exception
    when e_ptsn_not_exsts then
      null;
  end;
  
  -- не очікуємо формування старого файлу -формуємо незалежно
--  nbur_waiting_form(p_kod_filii, p_report_date, l_old_file_code, c_title);
  
  --Определяем версию файла для хранения детального протокола (сели рабочей нет, то ставим -1)
  l_version := coalesce(f_nbur_get_run_version(
                                                p_file_code => p_file_code
                                                , p_kf => p_kod_filii
                                                , p_report_date => p_report_date
                                               )
                           , -1);

--    форекснi операції з FX_DEAL
      for u in (  select '3' f091, kva r030, rnk, nb,
                         gl.p_icurval (kva, suma, p_report_date) t070,
                         decode(kodb,'300001','3','NBUAUAUXXXX','3','2') q024, 
                         (case  when nvl(swap_tag,0) != 0  then  '05' 
                                else       '00' 
                           end) d100, dat_a dat_2, dat dat_1, ref, 
                        (select trim(value) from operw o where o.ref=f.ref 
                                           and tag ='FOREX')  op_tag 
                    from fx_deal f
                   where dat =p_report_date
                     and kva != 980   and kvb =980 
                     and nvl(swap_tag,0) = 0
                     and exists (select 1 from oper o where o.ref=f.ref and sos <>-1 and sos is not null)
                  union all 
                  select '4' f091, kvb r030, rnk, nb,
                         gl.p_icurval (kvb, sumb, p_report_date) t070,
                         decode(kodb,'300001','3','NBUAUAUXXXX','3','2') q024, 
                         (case  when nvl(swap_tag,0) != 0  then  '05' 
                                else       '00' 
                           end) d100, dat_b dat_2, dat dat_1, ref, 
                        (select trim(value) from operw o where o.ref=f.ref 
                                           and tag ='FOREX')  op_tag 
                    from fx_deal f
                   where dat =p_report_date
                     and kva = 980     and kvb !=980 
                     and nvl(swap_tag,0) = 0
                     and exists (select 1 from oper o where o.ref=f.ref and sos <>-1 and sos is not null)
      ) loop

         if u.op_tag is null or u.op_tag is not null and u.op_tag != 'SWAP'  then

             l_d100 := u.d100;
             l_days :=0;

             begin
                select u.dat_2 - u.dat_1 - (select count(*)  from holiday
                                              where kv=980 and holiday between u.dat_1 and u.dat_2 )
                  into l_days
                  from dual;
             exception
                when others  then  l_days :=0;
             end;

             if u.op_tag = 'SPOT' and l_days !=1
             then
                 l_d100 :='03';
             else
               if l_d100 ='00'  then
                 if     l_days >2  then  l_d100 :='04';
                 elsif  l_days =2  then  l_d100 :='03';
                 elsif  l_days =1  then  l_d100 :='02';
                 else                    l_d100 :='01';
                 end if;
      
               end if;
             end if;
      
              insert
                into NBUR_LOG_F2GX
                   ( REPORT_DATE, KF, NBUC, VERSION_ID,
                     EKP, F091, D100, Q024, T070,
                     REF, CUST_ID, CUST_NAME, KV, DESCRIPTION )
              select p_report_date, p_kod_filii, p_kod_filii, l_version
                     , 'A2G001'                as EKP
                     , u.f091                  as F091
                     , l_d100                  as D100
                     , u.q024                  as Q024
                     , u.t070                  as T070
                     , u.ref                   as REF
                     , u.rnk                   as CUST_ID
                     , u.nb                    as CUST_NAME
                     , u.r030                  as KV
                     , 'форекснi операції з FX_DEAL'  as DESCRIPTION
                from dual;
      
         end if;

      end loop;

--    покупка/продаж валюти, тип операції FXE
      for u in (  SELECT  '3' f091, o.rnkk rnk, o.REF, o.acck, o.nlsk,
                         o.kv, o.accd, o.nlsd,
                         SUM (o.s * 100) s_nom,
                         SUM (gl.p_icurval (o.kv, o.s * 100, p_report_date)) s_eqv
                    FROM provodki_otc o
                   WHERE o.fdat = p_report_date --p_rpt_dt
                     AND o.kv not in (959, 961, 962, 964, 980)
                     AND o.tt ='FXE'
                     and o.nlsd ='29003'
                     and o.nlsk like '3800%'
                     and o.kv =o.kv_o and o.kv2_o =980
                GROUP BY '3', o.rnkk, o.REF, o.acck, o.nlsk, o.kv, o.accd, o.nlsd
                union
                 SELECT  '4' f091, o.rnkd rnk, o.REF, o.acck, o.nlsk,
                         o.kv, o.accd, o.nlsd,
                         SUM (o.s * 100) s_nom,
                         SUM (gl.p_icurval (o.kv, o.s * 100, p_report_date)) s_eqv
                    FROM provodki_otc o
                   WHERE o.fdat = p_report_date  --p_rpt_dt
                     AND o.kv not in (959, 961, 962, 964, 980)
                     AND o.tt ='FXE'
                     and o.nlsk ='29003'
                     and o.nlsd like '3800%'
                     and o.kv =o.kv2_o and o.kv_o =980
                GROUP BY '4', o.rnkd, o.REF, o.acck, o.nlsk, o.kv, o.accd, o.nlsd
      ) loop

              insert
                into NBUR_LOG_F2GX
                   ( REPORT_DATE, KF, NBUC, VERSION_ID,
                     EKP, F091, D100, Q024, T070,
                     REF, CUST_ID, CUST_NAME, KV, ACC_ID, ACC_NUM, DESCRIPTION )
              select p_report_date, p_kod_filii, p_kod_filii, l_version
                     , 'A2G001'                as EKP
                     , u.f091                  as F091
                     , '01'                    as D100
                     , '1'                     as Q024
                     , u.s_eqv                 as T070
                     , u.ref                   as REF
                     , u.rnk                   as CUST_ID
                     , c.nmk                   as CUST_NAME
                     , u.kv                    as KV
                     , decode(u.f091,'3',u.accd,u.acck)   as ACC_ID
                     , decode(u.f091,'3',u.nlsd,u.nlsk)   as ACC_NUM
                     , decode(u.f091,'3','купiвля валюти, тип операції FXE',
                                          'продаж валюти, тип операції FXE' )
                                                          as DESCRIPTION
                from customer c
               where c.rnk = u.rnk;
      
      end loop;

    commit;

   logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_F2GX.sql =========*** End ***
PROMPT ===================================================================================== 

