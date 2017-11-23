prompt upl_sql credits_zal (day)
declare 
  l_clob clob := TO_CLOB('select
             kf,
             vidd_name,
             nd,
             rnk,
             rel_type,
			 zal_sum
        from bars_dm.credits_zal c
   where c.per_id=bars_dm.dm_import.GET_PERIOD_ID(''DAY'',nvl(to_date(:param1, ''dd/mm/yyyy''), trunc(sysdate)))
   and kf = sys_context(''bars_context'', ''user_mfo'')');
begin
  update barsupl.upl_sql
  set sql_text = l_clob,
      vers = '1.0'
  where sql_id = 8;
  if sql%rowcount = 0 then
	insert into barsupl.upl_sql (sql_id, sql_text, before_proc, after_proc, descript, vers)
	values (8, l_clob, null, null, 'CRM: Поручителі / заставодавці - DAY', 1.0);
  end if;  
end;
/

prompt upl_sql credits_zal (MONTH)
declare 
  l_clob clob := TO_CLOB('select
             kf,
             vidd_name,
             nd,
             rnk,
             rel_type,
			 zal_sum
        from bars_dm.credits_zal c
   where c.per_id=bars_dm.dm_import.GET_PERIOD_ID(''MONTH'',nvl(to_date(:param1, ''dd/mm/yyyy''), trunc(sysdate)))
   and kf = sys_context(''bars_context'', ''user_mfo'')');
begin
  update barsupl.upl_sql
  set sql_text = l_clob,
      vers = '1.0'
  where sql_id = 9;
  if sql%rowcount = 0 then
	insert into barsupl.upl_sql (sql_id, sql_text, before_proc, after_proc, descript, vers)
	values (9, l_clob, null, null, 'CRM: Поручителі / заставодавці - MONTH', 1.0);
  end if;  
end;
/

prompt upl_sql cust_rel_s (short) day
declare 
  l_clob clob := TO_CLOB('select
             kf,
             rnk,
             rel_rnk,
             rel_id,
             bdate,
             edate
        from bars_dm.custur_rel c
   where c.per_id=bars_dm.dm_import.GET_PERIOD_ID(''DAY'',nvl(to_date(:param1, ''dd/mm/yyyy''), trunc(sysdate)))
   and kf = sys_context(''bars_context'', ''user_mfo'')
   and change_type is null');
begin
  update barsupl.upl_sql
  set sql_text = l_clob,
      vers = '1.4'
  where sql_id = 6;
  if sql%rowcount = 0 then
	insert into barsupl.upl_sql (sql_id, sql_text, before_proc, after_proc, descript, vers)
	values (6, l_clob, null, null, 'CRM: Повязані особи (всі) - DAY', 1.0);
  end if;
end;
/

prompt upl_sql cust_rel_s (short) MONTH
declare 
  l_clob clob := TO_CLOB('select
             kf,
             rnk,
             rel_rnk,
             rel_id,
             bdate,
             edate
        from bars_dm.custur_rel c
   where c.per_id=bars_dm.dm_import.GET_PERIOD_ID(''MONTH'',nvl(to_date(:param1, ''dd/mm/yyyy''), trunc(sysdate)))
   and kf = sys_context(''bars_context'', ''user_mfo'')
   and change_type is null');
begin
  update barsupl.upl_sql
  set sql_text = l_clob,
      vers = '1.4'
  where sql_id = 7;
  if sql%rowcount = 0 then
	insert into barsupl.upl_sql (sql_id, sql_text, before_proc, after_proc, descript, vers)
	values (7, l_clob, null, null, 'CRM: Повязані особи (всі) - MONTH', 1.0);
  end if;  
end;
/

prompt upl_sql bpk2 day
declare 
  l_clob clob := to_clob('
select  branch,
        kf,
        rnk,
        nd,
        dat_begin,
        bpk_type,
        nls,
        daos,
        kv,
        intrate,
        ostc,
        date_lastop,
        cred_line,
        cred_lim,
        use_cred_sum,
        dazs,
        blkd,
        blkk,
        bpk_status,
        pk_okpo,
        pk_name,
        pk_okpo_n,
        vid,
        lie_sum,
        lie_val,
        lie_date,
        lie_docn,
        lie_atrt,
        lie_doc,
        pk_term,
        pk_oldnd,
        pk_work,
        pk_cntrw,
        pk_ofax,
        pk_phone,
        pk_pcodw,
        pk_odat,
        pk_strtw,
        pk_cityw,
        pk_offic,
        dkbo_date_off,
        dkbo_start_date,
        dkbo_deal_number,
        kos,
        dos,
        w4_arsum,
        w4_kproc,
        w4_sec,
        acc
        from bars_dm.bpk_plt
        where per_id=bars_dm.dm_import.GET_PERIOD_ID(''DAY'',nvl(to_date(:param1, ''dd/mm/yyyy''), trunc(sysdate)))
	and kf = sys_context(''bars_context'', ''user_mfo'')');
begin
  update barsupl.upl_sql
  set sql_text = l_clob,
      vers = '1.2'
  where sql_id = 4;
  if sql%rowcount = 0 then
     insert into barsupl.upl_sql(sql_id, sql_text, vers, descript) values (4, l_clob, '1.2', 'Платіжні картки 2 для CRM - зміни');
  end if;
end;
/

prompt upl_sql bpk2 MONTH
declare 
  l_clob clob := to_clob('
select  branch,
        kf,
        rnk,
        nd,
        dat_begin,
        bpk_type,
        nls,
        daos,
        kv,
        intrate,
        ostc,
        date_lastop,
        cred_line,
        cred_lim,
        use_cred_sum,
        dazs,
        blkd,
        blkk,
        bpk_status,
        pk_okpo,
        pk_name,
        pk_okpo_n,
        vid,
        lie_sum,
        lie_val,
        lie_date,
        lie_docn,
        lie_atrt,
        lie_doc,
        pk_term,
        pk_oldnd,
        pk_work,
        pk_cntrw,
        pk_ofax,
        pk_phone,
        pk_pcodw,
        pk_odat,
        pk_strtw,
        pk_cityw,
        pk_offic,
        dkbo_date_off,
        dkbo_start_date,
        dkbo_deal_number,
        kos,
        dos,
        w4_arsum,
        w4_kproc,
        w4_sec,
        acc
        from bars_dm.bpk_plt
        where per_id=bars_dm.dm_import.GET_PERIOD_ID(''MONTH'',nvl(to_date(:param1, ''dd/mm/yyyy''), trunc(sysdate)))
		and kf = sys_context(''bars_context'', ''user_mfo'')');
begin
  update barsupl.upl_sql
  set sql_text = l_clob,
      vers = '1.0'
  where sql_id = 5;
  if sql%rowcount = 0 then
     insert into barsupl.upl_sql(sql_id, sql_text, vers, descript) values (5, l_clob, '1.0', 'Платіжні картки 2 для CRM - MONTH');
  end if;
end;
/

prompt upl_sql custur_rel day
declare 
  l_clob clob := TO_CLOB('select
             kf,
             rnk,
             rel_id,
             rel_rnk,
             rel_intext,
             name,
             okpo,
             vaga1,
             custtype,
             tel,
             email,
             position,
             sed,
             bdate,
             edate,
             sign_privs,
	     change_type--,
			 --cl_type
        from bars_dm.custur_rel c
   where c.per_id=bars_dm.dm_import.GET_PERIOD_ID(''DAY'',nvl(to_date(:param1, ''dd/mm/yyyy''), trunc(sysdate)))
   and kf = sys_context(''bars_context'', ''user_mfo'')
   and cl_type in (2)
   ');
begin
  update barsupl.upl_sql
  set sql_text = l_clob,
      vers = '1.3'
  where sql_id = 99;
end;
/

prompt upl_sql custur_rel month
declare 
  l_clob clob := TO_CLOB('select
             kf,
             rnk,
             rel_id,
             rel_rnk,
             rel_intext,
             name,
             okpo,
             vaga1,
             custtype,
             tel,
             email,
             position,
             sed,
             bdate,
             edate,
             sign_privs,
	     change_type--,
			 --cl_type
        from bars_dm.custur_rel c
   where c.per_id=bars_dm.dm_import.GET_PERIOD_ID(''MONTH'',nvl(to_date(:param1, ''dd/mm/yyyy''), trunc(sysdate)))
   and cl_type in (2)
   and kf = sys_context(''bars_context'', ''user_mfo'')
   ');
begin
  update barsupl.upl_sql
  set sql_text = l_clob,
      vers = '1.3'
  where sql_id = 89;
end;
/

prompt upl_sql zastava day
declare 
  l_clob clob := TO_CLOB('SELECT z.kf, z.rnk, z.okpo, z.nd, z.vidd, z.ndz, z.datez, z.mpawn, z.pawnpawn,
                z.pawn, z.ozn, z.bvart, z.svart, z.nree, z.ndstrah, z.datestrah,
                z.cntchk, z.dlchk, z.nfact, z.stzz, z.acc_pawn, z.rnk_accpawn, state_accpawn
           FROM bars_dm.zastava z
   where z.per_id=bars_dm.dm_import.GET_PERIOD_ID(''DAY'',nvl(to_date(:param1, ''dd/mm/yyyy''), trunc(sysdate)))
   and kf = sys_context(''bars_context'', ''user_mfo'')');
begin
  update barsupl.upl_sql
  set sql_text = l_clob,
      vers = '1.2'
  where sql_id = 68;
end;
/

prompt upl_sql segments day
declare 
  l_clob clob := TO_CLOB('select kf,
       rnk,
       segment_act,
       segment_fin,
       segment_beh,
       social_vip,
       segment_trans,
       product_amount,
       deposit_ammount,
       credits_ammount,
       garantcredits_ammount,
       cardcredits_ammount,
       energycredits_ammount,
       cards_ammount,
       accounts_ammount,
       lastchangedt
  from bars_dm.customers_segment
   where per_id=bars_dm.dm_import.GET_PERIOD_ID(''DAY'',nvl(to_date(:param1, ''dd/mm/yyyy''), trunc(sysdate)))
   and kf = sys_context(''bars_context'', ''user_mfo'')');
begin
  update barsupl.upl_sql
  set sql_text = l_clob,
      vers = '1.2'
  where sql_id = 10051;
end;
/

prompt upl_sql clientfo day
declare 
  l_clob clob := TO_CLOB('select last_name,
       first_name,
       middle_name,
       bday,
       gr,
       passp,
       ser,
       numdoc,
       pdate,
       organ,
       passp_expire_to,
       passp_to_bank,
       kf ru,
       rnk,
       okpo,
       cust_status,
       cust_active,
       telm,
       telw,
       teld,
       teladd,
       email,
       adr_post_country,
       adr_post_domain,
       adr_post_region,
       adr_post_loc,
       adr_post_adr,
       adr_post_zip,
       adr_fact_country,
       adr_fact_domain,
       adr_fact_region,
       adr_fact_loc,
       adr_fact_adr,
       adr_fact_zip,
       adr_work_country,
       adr_work_domain,
       adr_work_region,
       adr_work_loc,
       adr_work_adr,
       adr_work_zip,
       branch,
       negativ_status,
       reestr_mob_bank,
       reestr_inet_bank,
       reestr_sms_bank,
       month_income,
       subject_role,
       rezident,
       merried,
       emp_status,
       subject_class,
       insider,
       sex,
       vipk,
       vip_fio_manager,
       vip_phone_manager,
       date_on,
       date_off,
       eddr_id,
       actual_date
from bars_dm.customers c
   where c.per_id=bars_dm.dm_import.GET_PERIOD_ID(''DAY'',nvl(to_date(:param1, ''dd/mm/yyyy''), trunc(sysdate)))
   and kf = sys_context(''bars_context'', ''user_mfo'')');
begin
  update barsupl.upl_sql
  set sql_text = l_clob,
      vers = '1.2'
  where sql_id = 50;
end;
/

prompt upl_sql XRM stats day
declare 
  l_clob clob := TO_CLOB('SELECT obj,
     start_time,
     stop_time,
     rows_ok,
     rows_err,
     status
   FROM bars_dm.dm_stats
   WHERE     per_id = bars_dm.dm_import.GET_PERIOD_ID(''DAY'',nvl(to_date(:param1, ''dd/mm/yyyy''), trunc(sysdate)))
        AND id_session =
               (SELECT MAX (id_session)
                  FROM bars_dm.dm_stats
                 WHERE per_id =
                          bars_dm.dm_import.GET_PERIOD_ID(''DAY'',nvl(to_date(:param1, ''dd/mm/yyyy''), trunc(sysdate))))');
begin
  update barsupl.upl_sql
  set sql_text = l_clob,
      vers = '1.2'
  where sql_id = 80;
end;
/


prompt upl_sql custur day
declare 
  l_clob clob := TO_CLOB('select
          kf,
          rnk,
          branch,
          nmk,
          nmkk,
          ruk,
          okpo,
          e_mail,
          telr,
          telb,
          tel_fax,
          date_on,
          date_off,
          au_contry,
          au_zip,
          au_domain,
          au_region,
          au_locality_type,
          au_locality,
          au_adress,
          au_street_type,
          au_street,
          au_home_type,
          au_home,
          au_homepart_type,
          au_homepart,
          au_room_type,
          au_room,
          af_contry,
          af_zip,
          af_domain,
          af_region,
          af_locality_type,
          af_locality,
          af_adress,
          af_street_type,
          af_street,
          af_home_type,
          af_home,
          af_homepart_type,
          af_homepart,
          af_room_type,
          af_room,
          fsdry,
          fskpr,
          ved,
          idpib,
          uudv,
          kvpkk,
          oe,
          ise,
          fs,
          sed,
          rezid,
          ainab,
          fsved,
          case when (select rnk from barsaq.ibank_rnk where rnk = c.rnk) is null then 0 else 1 end as kbfl,
          prinsider,
          country,
          custtype,
          lastchangedt,
          gcif
     from bars_dm.custur c
   where c.per_id=bars_dm.dm_import.GET_PERIOD_ID(''DAY'',nvl(to_date(:param1, ''dd/mm/yyyy''), trunc(sysdate)))
   and kf = sys_context(''bars_context'', ''user_mfo'')');
begin
  update barsupl.upl_sql
  set sql_text = l_clob,
      vers = '1.2'
  where sql_id = 64;
end;
/

prompt upl_sql bpk day
declare 
  l_clob clob := TO_CLOB('select
       b.branch
      ,b.kf
      ,b.rnk
      ,b.nd
      ,b.dat_begin
      ,b.BPK_TYPE
      ,b.nls
      ,b.daos
      ,b.kv
      ,b.intrate
      ,b.ostc
      ,b.date_lastop
      ,b.cred_line
      ,b.cred_lim
      ,b.use_cred_sum
      ,b.dazs
      ,b.blkd
      ,b.blkk
      ,b.bpk_status
      ,b.pk_okpo
      ,b.pk_name
      ,b.pk_okpo_n
  from bars_dm.bpk b
   where b.per_id=bars_dm.dm_import.GET_PERIOD_ID(''DAY'',nvl(to_date(:param1, ''dd/mm/yyyy''), trunc(sysdate)))
   and kf = sys_context(''bars_context'', ''user_mfo'')');
begin
  update barsupl.upl_sql
  set sql_text = l_clob,
      vers = '1.2'
  where sql_id = 59;
end;
/

prompt upl_sql accounts day
declare 
  l_clob clob := TO_CLOB('select
        a.branch
       ,a.kf
       ,a.rnk
       ,a.nls
       ,a.vidd
       ,a.daos
       ,a.kv
       ,a.intrate
       ,a.massa
       ,a.count_zl
       ,a.ostc
       ,a.ob_mon
       ,a.last_add_date
       ,a.last_add_suma
       ,a.dazs
       ,a.blkd
       ,a.blkk
       ,a.acc_status
   from bars_dm.dm_accounts a
   where a.per_id=bars_dm.dm_import.GET_PERIOD_ID(''DAY'',nvl(to_date(:param1, ''dd/mm/yyyy''), trunc(sysdate)))
   and kf = sys_context(''bars_context'', ''user_mfo'')');
begin
  update barsupl.upl_sql
  set sql_text = l_clob,
      vers = '1.2'
  where sql_id = 57;
end;
/

prompt upl_sql credits_d, credits_s 1.2
declare 
  l_clob clob := TO_CLOB('select
                           nd
                          ,rnk
                          ,kf
                          ,okpo
                          ,cc_id
                          ,sdate
                          ,wdate
                          ,wdate_fact
                          ,vidd
                          ,prod
                          ,prod_clas
                          ,pawn
                          ,sdog
                          ,term
                          ,kv
                          ,pog_plan
                          ,pog_fact
                          ,borg_sy
                          ,borgproc_sy
                          ,bpk_nls
                          ,intrate
                          ,ptn_name
                          ,ptn_okpo
                          ,ptn_mother_name
                          ,open_date_bal22
                          ,ES000
                          ,ES003
                          ,VIDD_CUSTTYPE
                   from bars_dm.credits_stat c
                   where c.per_id=bars_dm.dm_import.GET_PERIOD_ID(''DAY'',nvl(to_date(:param1, ''dd/mm/yyyy''), trunc(sysdate)))
				   and kf = sys_context(''bars_context'', ''user_mfo'')');
begin
  update barsupl.upl_sql
  set sql_text = l_clob,
      vers = '1.2'
  where sql_id = 52;
end;
/
declare 
  l_clob clob := TO_CLOB('select
                           nd
                          ,rnk
                          ,kf
                          ,cc_id
                          ,sdate
                          ,branch
                          ,vidd
                          ,next_pay
                          ,probl_rozgl
                          ,probl_date
                          ,probl
                          ,cred_change
                          ,cred_datechange
                          ,borg
                          ,borg_tilo
                          ,borg_proc
                          ,prosr1
                          ,prosr2
                          ,prosrcnt
                          ,borg_prosr
                          ,borg_tilo_prosr
                          ,borg_proc_prosr
                          ,penja
                          ,shtraf
                          ,pay_tilo
                          ,pay_proc
                          ,cat_ryzyk
                          ,cred_to_prosr
                          ,borg_to_pbal
                          ,vart_majna
                          ,pog_finish
                          ,prosr_fact_cnt
                          ,next_pay_all
                          ,next_pay_tilo
                          ,next_pay_proc
                          ,sos
                          ,last_pay_date
                          ,last_pay_suma
                          ,prosrcnt_proc
                          ,tilo_prosr_uah
                          ,proc_prosr_uah
                          ,borg_tilo_uah
                          ,borg_proc_uah
                          ,pay_vdvs
                          ,amount_commission
                          ,amount_prosr_commission
                          ,ES000
                          ,ES003
                          ,VIDD_CUSTTYPE
                      from bars_dm.credits_dyn c
                      where c.per_id=bars_dm.dm_import.GET_PERIOD_ID(''DAY'',nvl(to_date(:param1, ''dd/mm/yyyy''), trunc(sysdate)))
					  and kf = sys_context(''bars_context'', ''user_mfo'')');
begin
  update barsupl.upl_sql
  set sql_text = l_clob,
      vers = '1.2'
  where sql_id = 53;
end;
/

prompt upl_sql BPK_PLT ver. 1.1

declare
l_sql clob := to_clob('
select  branch,
        kf,
        rnk,
        nd,
        dat_begin,
        bpk_type,
        nls,
        daos,
        kv,
        intrate,
        ostc,
        date_lastop,
        cred_line,
        cred_lim,
        use_cred_sum,
        dazs,
        blkd,
        blkk,
        bpk_status,
        pk_okpo,
        pk_name,
        pk_okpo_n,
        vid,
        lie_sum,
        lie_val,
        lie_date,
        lie_docn,
        lie_atrt,
        lie_doc,
        pk_term,
        pk_oldnd,
        pk_work,
        pk_cntrw,
        pk_ofax,
        pk_phone,
        pk_pcodw,
        pk_odat,
        pk_strtw,
        pk_cityw,
        pk_offic,
        dkbo_date_off,
        dkbo_start_date,
        dkbo_deal_number,
        kos,
        dos,
        w4_arsum,
        w4_kproc,
        w4_sec
        from bars_dm.bpk_plt
        where per_id=bars_dm.dm_import.GET_PERIOD_ID(''DAY'',nvl(to_date(:param1, ''dd/mm/yyyy''), trunc(sysdate)))
		and kf = sys_context(''bars_context'', ''user_mfo'')');
begin
  update upl_sql t
  set t.sql_text = l_sql,
      t.vers = '1.1'
  where t.sql_id = 10052;
end;
/
commit;
/
prompt upl_sql CUSTOMERS_PLT ver. 1.2
declare
l_sql clob := to_clob('
select LAST_NAME,
        FIRST_NAME,
        MIDDLE_NAME,
        BDAY,
        GR,
        PASSP,
        SER,
        NUMDOC,
        PDATE,
        ORGAN,
        PASSP_EXPIRE_TO,
        PASSP_TO_BANK,
        KF,
        RNK,
        OKPO,
        CUST_STATUS,
        CUST_ACTIVE,
        TELM,
        TELW,
        TELD,
        TELADD,
        EMAIL,
        ADR_POST_COUNTRY,
        ADR_POST_DOMAIN,
        ADR_POST_REGION,
        ADR_POST_LOC,
        ADR_POST_ADR,
        ADR_POST_ZIP,
        ADR_FACT_COUNTRY,
        ADR_FACT_DOMAIN,
        ADR_FACT_REGION,
        ADR_FACT_LOC,
        ADR_FACT_ADR,
        ADR_FACT_ZIP,
        ADR_WORK_COUNTRY,
        ADR_WORK_DOMAIN,
        ADR_WORK_REGION,
        ADR_WORK_LOC,
        ADR_WORK_ADR,
        ADR_WORK_ZIP,
        BRANCH,
        NEGATIV_STATUS,
        REESTR_MOB_BANK,
        REESTR_INET_BANK,
        REESTR_SMS_BANK,
        MONTH_INCOME,
        SUBJECT_ROLE,
        REZIDENT,
        MERRIED,
        EMP_STATUS,
        SUBJECT_CLASS,
        INSIDER,
        SEX,
        VIPK,
        VIP_FIO_MANAGER,
        VIP_PHONE_MANAGER,
        DATE_ON,
        DATE_OFF,
        EDDR_ID,
        BPLACE,
        SUBSD,
        SUBSN,
        ELT_N,
        ELT_D,
        GCIF,
        NOMPDV,
        NOM_DOG,
        SW_RN,
        Y_ELT,
        ADM,
        FADR,
        ADR_ALT,
        BUSSS,
        PC_MF,
        PC_Z4,
        PC_Z3,
        PC_Z5,
        PC_Z2,
        PC_Z1,
        AGENT,
        PC_SS,
        STMT,
        VIDKL,
        VED,
        TIPA,
        PHKLI,
        AF1_9,
        IDDPD,
        DAIDI,
        DATVR,
        DATZ,
        IDDPL,
        DATE_PHOTO,
        IDDPR,
        ISE,
        OBSLU,
        CRSRC,
        DJOTH,
        DJAVI,
        DJ_TC,
        DJOWF,
        DJCFI,
        DJ_LN,
        DJ_FH,
        DJ_CP,
        CHORN,
        CRISK_KL,
        BC,
        SPMRK,
        K013,
        KODID,
        COUNTRY,
        MS_FS,
        MS_VD,
        MS_GR,
        LIM_KASS,
        LIM,
        LICO,
        UADR,
        MOB01,
        MOB02,
        MOB03,
        SUBS,
        K050,
        DEATH,
        NO_PHONE,
        NSMCV,
        NSMCC,
        NSMCT,
        NOTES,
        SAMZ,
        OREP,
        OVIFS,
        AF6,
        FSKRK,
        FSOMD,
        FSVED,
        FSZPD,
        FSPOR,
        FSRKZ,
        FSZOP,
        FSKPK,
        FSKPR,
        FSDIB,
        FSCP,
        FSVLZ,
        FSVLA,
        FSVLN,
        FSVLO,
        FSSST,
        FSSOD,
        FSVSN,
        DOV_P,
        DOV_A,
        DOV_F,
        NMKV,
        SN_GC,
        NMKK,
        PRINSIDER,
        NOTESEC,
        MB,
        PUBLP,
        WORKB,
        C_REG,
        C_DST,
        RGADM,
        RGTAX,
        DATEA,
        DATET,
        RNKP,
        CIGPO,
        COUNTRY_NAME,
        TARIF,
        AINAB,
        TGR,
        CUSTTYPE,
        RIZIK,
        SNSDR,
        IDPIB,
        FS,
        SED,
        DJER,
        CODCAGENT,
        SUTD,
        RVDBC,
        RVIBA,
        RVIDT,
        RV_XA,
        RVIBR,
        RVIBB,
        RVRNK,
        RVPH1,
        RVPH2,
        RVPH3,
        SAB,
        J_COUNTRY,
        J_ZIP,
        J_DOMAIN,
        J_REGION,
        J_LOCALITY,
        J_ADDRESS,
        J_TERRITORY_ID,
        J_LOCALITY_TYPE,
        J_STREET_TYPE,
        J_STREET,
        J_HOME_TYPE,
        J_HOME,
        J_HOMEPART_TYPE,
        J_HOMEPART,
        J_ROOM_TYPE,
        J_ROOM,
        j_koatuu,
        j_region_id,
        j_area_id,
        j_settlement_id,
        j_street_id,
        j_house_id,
        F_COUNTRY,
        F_ZIP,
        F_DOMAIN,
        F_REGION,
        F_LOCALITY,
        F_ADDRESS,
        F_TERRITORY_ID,
        F_LOCALITY_TYPE,
        F_STREET_TYPE,
        F_STREET,
        F_HOME_TYPE,
        F_HOME,
        F_HOMEPART_TYPE,
        F_HOMEPART,
        F_ROOM_TYPE,
        F_ROOM,
        f_koatuu,
        f_region_id,
        f_area_id,
        f_settlement_id,
        f_street_id,
        f_house_id,
        P_COUNTRY,
        P_ZIP,
        P_DOMAIN,
        P_REGION,
        P_LOCALITY,
        P_ADDRESS,
        P_TERRITORY_ID,
        P_LOCALITY_TYPE,
        P_STREET_TYPE,
        P_STREET,
        P_HOME_TYPE,
        P_HOME,
        P_HOMEPART_TYPE,
        P_HOMEPART,
        P_ROOM_TYPE,
        P_ROOM,
        p_koatuu,
        p_region_id,
        p_area_id,
        p_settlement_id,
        p_street_id,
        p_house_id
--        case when PASSP = 7 then actual_date else null end as IDCARD_VALID_DATE,
--        vip_account_manager
        from bars_dm.customers_plt
        where per_id=bars_dm.dm_import.GET_PERIOD_ID(''DAY'',nvl(to_date(:param1, ''dd/mm/yyyy''), trunc(sysdate)))
		and kf = sys_context(''bars_context'', ''user_mfo'')');
begin
  update upl_sql t
  set t.sql_text = l_sql,
      t.vers = '1.3'
  where t.sql_id = 10054;
end;
/

prompt upl_sql CLIENTFO2 ver. 1.1
declare
l_sql_id number;
l_sql clob := to_clob('
select LAST_NAME,
        FIRST_NAME,
        MIDDLE_NAME,
        BDAY,
        GR,
        PASSP,
        SER,
        NUMDOC,
        PDATE,
        ORGAN,
        PASSP_EXPIRE_TO,
        PASSP_TO_BANK,
        KF,
        RNK,
        OKPO,
        CUST_STATUS,
        CUST_ACTIVE,
        TELM,
        TELW,
        TELD,
        TELADD,
        EMAIL,
        ADR_POST_COUNTRY,
        ADR_POST_DOMAIN,
        ADR_POST_REGION,
        ADR_POST_LOC,
        ADR_POST_ADR,
        ADR_POST_ZIP,
        ADR_FACT_COUNTRY,
        ADR_FACT_DOMAIN,
        ADR_FACT_REGION,
        ADR_FACT_LOC,
        ADR_FACT_ADR,
        ADR_FACT_ZIP,
        ADR_WORK_COUNTRY,
        ADR_WORK_DOMAIN,
        ADR_WORK_REGION,
        ADR_WORK_LOC,
        ADR_WORK_ADR,
        ADR_WORK_ZIP,
        BRANCH,
        NEGATIV_STATUS,
        REESTR_MOB_BANK,
        REESTR_INET_BANK,
        REESTR_SMS_BANK,
        MONTH_INCOME,
        SUBJECT_ROLE,
        REZIDENT,
        MERRIED,
        EMP_STATUS,
        SUBJECT_CLASS,
        INSIDER,
        SEX,
        VIPK,
        VIP_FIO_MANAGER,
        VIP_PHONE_MANAGER,
        DATE_ON,
        DATE_OFF,
        EDDR_ID,
        actual_date as IDCARD_VALID_DATE,        
        IDDPL,        
        BPLACE,
        SUBSD,
        SUBSN,
        ELT_N,
        ELT_D,
        GCIF,
        NOMPDV,
        NOM_DOG,
        SW_RN,
        Y_ELT,
        ADM,
        FADR,
        ADR_ALT,
        BUSSS,
        PC_MF,
        PC_Z4,
        PC_Z3,
        PC_Z5,
        PC_Z2,
        PC_Z1,
        AGENT,
        PC_SS,
        STMT,
        VIDKL,
        VED,
        TIPA,
        PHKLI,
        AF1_9,
        IDDPD,
        DAIDI,
        DATVR,
        DATZ,
        DATE_PHOTO,
        IDDPR,
        ISE,
        OBSLU,
        CRSRC,
        DJOTH,
        DJAVI,
        DJ_TC,
        DJOWF,
        DJCFI,
        DJ_LN,
        DJ_FH,
        DJ_CP,
        CHORN,
        CRISK_KL,
        BC,
        SPMRK,
        K013,
        KODID,
        COUNTRY,
        MS_FS,
        MS_VD,
        MS_GR,
        LIM_KASS,
        LIM,
        LICO,
        UADR,
        MOB01,
        MOB02,
        MOB03,
        SUBS,
        K050,
        DEATH,
        NO_PHONE,
        NSMCV,
        NSMCC,
        NSMCT,
        NOTES,
        SAMZ,
        OREP,
        OVIFS,
        AF6,
        FSKRK,
        FSOMD,
        FSVED,
        FSZPD,
        FSPOR,
        FSRKZ,
        FSZOP,
        FSKPK,
        FSKPR,
        FSDIB,
        FSCP,
        FSVLZ,
        FSVLA,
        FSVLN,
        FSVLO,
        FSSST,
        FSSOD,
        FSVSN,
        DOV_P,
        DOV_A,
        DOV_F,
        NMKV,
        SN_GC,
        NMKK,
        PRINSIDER,
        NOTESEC,
        MB,
        PUBLP,
        WORKB,
        C_REG,
        C_DST,
        RGADM,
        RGTAX,
        DATEA,
        DATET,
        RNKP,
        CIGPO,
        COUNTRY_NAME,
        TARIF,
        AINAB,
        TGR,
        CUSTTYPE,
        RIZIK,
        SNSDR,
        IDPIB,
        FS,
        SED,
        DJER,
        CODCAGENT,
        SUTD,
        RVDBC,
        RVIBA,
        RVIDT,
        RV_XA,
        RVIBR,
        RVIBB,
        RVRNK,
        RVPH1,
        RVPH2,
        RVPH3,
        SAB,
        vip_account_manager
        from bars_dm.customers_plt
        where per_id=bars_dm.dm_import.GET_PERIOD_ID(''DAY'',nvl(to_date(:param1, ''dd/mm/yyyy''), trunc(sysdate)))
		and kf = sys_context(''bars_context'', ''user_mfo'')');
begin
  update upl_sql t
  set t.sql_text = l_sql,
      t.vers = '1.0'
  where t.sql_id = 99442;
  if sql%rowcount = 0 then
    insert into upl_sql (sql_id, sql_text, before_proc, after_proc, descript, vers)
    values (99442, l_sql, null, null, 'CRM, Фізичні особи (основна інформація)', '1.0');
  end if;
end;
/

prompt upl_sql CLIENTADDRESS ver. 1.0
declare
l_sql_id number;
l_sql clob := to_clob('
select  KF,
        RNK,
        J_COUNTRY,
        J_ZIP,
        J_DOMAIN,
        J_REGION,
        J_LOCALITY,
        J_ADDRESS,
        J_TERRITORY_ID,
        J_LOCALITY_TYPE,
        J_STREET_TYPE,
        J_STREET,
        J_HOME_TYPE,
        J_HOME,
        J_HOMEPART_TYPE,
        J_HOMEPART,
        J_ROOM_TYPE,
        J_ROOM,
        j_koatuu,
        j_region_id,
        j_area_id,
        j_settlement_id,
        j_street_id,
        j_house_id,
        F_COUNTRY,
        F_ZIP,
        F_DOMAIN,
        F_REGION,
        F_LOCALITY,
        F_ADDRESS,
        F_TERRITORY_ID,
        F_LOCALITY_TYPE,
        F_STREET_TYPE,
        F_STREET,
        F_HOME_TYPE,
        F_HOME,
        F_HOMEPART_TYPE,
        F_HOMEPART,
        F_ROOM_TYPE,
        F_ROOM,
        f_koatuu,
        f_region_id,
        f_area_id,
        f_settlement_id,
        f_street_id,
        f_house_id,
        P_COUNTRY,
        P_ZIP,
        P_DOMAIN,
        P_REGION,
        P_LOCALITY,
        P_ADDRESS,
        P_TERRITORY_ID,
        P_LOCALITY_TYPE,
        P_STREET_TYPE,
        P_STREET,
        P_HOME_TYPE,
        P_HOME,
        P_HOMEPART_TYPE,
        P_HOMEPART,
        P_ROOM_TYPE,
        P_ROOM,
        p_koatuu,
        p_region_id,
        p_area_id,
        p_settlement_id,
        p_street_id,
        p_house_id
        from bars_dm.customers_plt
        where per_id=bars_dm.dm_import.GET_PERIOD_ID(''DAY'',nvl(to_date(:param1, ''dd/mm/yyyy''), trunc(sysdate)))
		and kf = sys_context(''bars_context'', ''user_mfo'')');
begin
  update upl_sql t
  set t.sql_text = l_sql,
      t.vers = '1.0'
  where t.sql_id = 99443;
  if sql%rowcount = 0 then
    insert into upl_sql (sql_id, sql_text, before_proc, after_proc, descript, vers)
    values (99443, l_sql, null, null, 'CRM, Фізичні особи (коди адрес)', '1.0');
  end if;
end;
/

prompt upl_sql DEPOSITS(DAY) ver. 1.1
declare
l_sql_id number;
l_sql clob := to_clob('
select d.branch
                ,d.kf
                ,d.rnk
                ,d.nd
                ,d.dat_begin
                ,d.dat_end
                ,d.nls
                ,d.vidd
                ,d.term
                ,d.sdog
                ,d.massa
                ,d.kv
                ,d.intrate
                ,d.sdog_begin
                ,d.last_add_date
                ,d.last_add_suma
                ,d.ostc
                ,d.suma_proc
                ,d.suma_proc_plan
                ,d.deposit_id
                ,d.dpt_status
                ,d.suma_proc_payoff
                ,d.date_proc_payoff
                ,d.date_dep_payoff
                ,d.datz
                ,d.dazs
                ,d.blkd
                ,d.blkk
                ,d.cnt_dubl
                ,d.archdoc_id
                ,d.wb
          from bars_dm.deposits d
          where d.per_id=bars_dm.dm_import.GET_PERIOD_ID(''DAY'',nvl(to_date(:param1, ''dd/mm/yyyy''), trunc(sysdate)))
		  and kf = sys_context(''bars_context'', ''user_mfo'')');
begin
  update upl_sql t
  set t.sql_text = l_sql,
      t.vers = '1.1'
  where t.sql_id = 55;
  if sql%rowcount = 0 then
    insert into upl_sql (sql_id, sql_text, before_proc, after_proc, descript, vers)
    values (55, l_sql, null, null, 'CRM, Депозити, зміни', '1.1');
  end if;
end;
/
prompt upl_sql DEPOSITS(MONTH) ver. 1.1
declare
l_sql_id number;
l_sql clob := to_clob('
select d.branch
                ,d.kf
                ,d.rnk
                ,d.nd
                ,d.dat_begin
                ,d.dat_end
                ,d.nls
                ,d.vidd
                ,d.term
                ,d.sdog
                ,d.massa
                ,d.kv
                ,d.intrate
                ,d.sdog_begin
                ,d.last_add_date
                ,d.last_add_suma
                ,d.ostc
                ,d.suma_proc
                ,d.suma_proc_plan
                ,d.deposit_id
                ,d.dpt_status
                ,d.suma_proc_payoff
                ,d.date_proc_payoff
                ,d.date_dep_payoff
                ,d.datz
                ,d.dazs
                ,d.blkd
                ,d.blkk
                ,d.cnt_dubl
                ,d.archdoc_id
                ,d.wb
          from bars_dm.deposits d
          where d.per_id=bars_dm.dm_import.GET_PERIOD_ID(''MONTH'',nvl(to_date(:param1, ''dd/mm/yyyy''), trunc(sysdate)))
		  and kf = sys_context(''bars_context'', ''user_mfo'')');
begin
  update upl_sql t
  set t.sql_text = l_sql,
      t.vers = '1.1'
  where t.descript = 'CRM, Депозити';
end;
/
prompt upl_sql DEPOSITS_PLT(DAY) ver. 1.2
declare
l_sql_id number;
l_sql clob := to_clob('
select branch,
                      kf,
                      rnk,
                      nd,
                      dat_begin,
                      dat_end,
                      nls,
                      vidd_name,
                      term,
                      sdog,
                      massa,
                      kv,
                      intrate,
                      sdog_begin,
                      last_add_date,
                      last_add_suma,
                      ostc,
                      suma_proc,
                      suma_proc_plan,
                      deposit_id,
                      dpt_status,
                      suma_proc_payoff,
                      date_proc_payoff,
                      date_dep_payoff,
                      datz,
                      dazs,
                      blkd,
                      blkk,
                      cnt_dubl,
                      archdoc_id,
                      ncash,
                      name_d,
                      okpo_d,
                      nls_d,
                      mfo_d,
                      name_p,
                      okpo_p,
                      nlsb,
                      mfob,
                      nlsp,
                      rosp_m,
                      mal,
                      ben,
                      vidd,
					  wb
                      from bars_dm.deposit_plt
          where per_id=bars_dm.dm_import.GET_PERIOD_ID(''DAY'',nvl(to_date(:param1, ''dd/mm/yyyy''), trunc(sysdate)))
		  and kf = sys_context(''bars_context'', ''user_mfo'')');
begin
  update upl_sql t
  set t.sql_text = l_sql,
      t.vers = '1.1',
	  t.descript = 'CRM, Депозити(пілот)'
  where t.sql_id = 10053;
  if sql%rowcount = 0 then
    insert into upl_sql (sql_id, sql_text, before_proc, after_proc, descript, vers)
    values (10053, l_sql, null, null, 'CRM, Депозити(пілот)', '1.2');
  end if;
end;
/

prompt upl_sql DEPOSITS_PLT(MONTH) ver. 1.2
declare
l_sql_id number;
l_sql clob := to_clob('
select branch,
                      kf,
                      rnk,
                      nd,
                      dat_begin,
                      dat_end,
                      nls,
                      vidd_name,
                      term,
                      sdog,
                      massa,
                      kv,
                      intrate,
                      sdog_begin,
                      last_add_date,
                      last_add_suma,
                      ostc,
                      suma_proc,
                      suma_proc_plan,
                      deposit_id,
                      dpt_status,
                      suma_proc_payoff,
                      date_proc_payoff,
                      date_dep_payoff,
                      datz,
                      dazs,
                      blkd,
                      blkk,
                      cnt_dubl,
                      archdoc_id,
                      ncash,
                      name_d,
                      okpo_d,
                      nls_d,
                      mfo_d,
                      name_p,
                      okpo_p,
                      nlsb,
                      mfob,
                      nlsp,
                      rosp_m,
                      mal,
                      ben,
                      vidd,
					  wb
                      from bars_dm.deposit_plt
          where per_id=bars_dm.dm_import.GET_PERIOD_ID(''MONTH'',nvl(to_date(:param1, ''dd/mm/yyyy''), trunc(sysdate)))
		  and kf = sys_context(''bars_context'', ''user_mfo'')');
begin
  update upl_sql t
  set t.sql_text = l_sql,
      t.vers = '1.2',
	  t.descript = 'CRM, Депозити(пілот) - MONTH'
  where t.sql_id = 10055;
  if sql%rowcount = 0 then
    insert into upl_sql (sql_id, sql_text, before_proc, after_proc, descript, vers)
    values (10055, l_sql, null, null, 'CRM, Депозити(пілот) - MONTH', '1.2');
  end if;
end;
/

prompt upl_sql CLIENTFO2(MONTH) ver. 1.1
declare
l_sql_id number;
l_sql clob := to_clob('
select LAST_NAME,
        FIRST_NAME,
        MIDDLE_NAME,
        BDAY,
        GR,
        PASSP,
        SER,
        NUMDOC,
        PDATE,
        ORGAN,
        PASSP_EXPIRE_TO,
        PASSP_TO_BANK,
        KF,
        RNK,
        OKPO,
        CUST_STATUS,
        CUST_ACTIVE,
        TELM,
        TELW,
        TELD,
        TELADD,
        EMAIL,
        ADR_POST_COUNTRY,
        ADR_POST_DOMAIN,
        ADR_POST_REGION,
        ADR_POST_LOC,
        ADR_POST_ADR,
        ADR_POST_ZIP,
        ADR_FACT_COUNTRY,
        ADR_FACT_DOMAIN,
        ADR_FACT_REGION,
        ADR_FACT_LOC,
        ADR_FACT_ADR,
        ADR_FACT_ZIP,
        ADR_WORK_COUNTRY,
        ADR_WORK_DOMAIN,
        ADR_WORK_REGION,
        ADR_WORK_LOC,
        ADR_WORK_ADR,
        ADR_WORK_ZIP,
        BRANCH,
        NEGATIV_STATUS,
        REESTR_MOB_BANK,
        REESTR_INET_BANK,
        REESTR_SMS_BANK,
        MONTH_INCOME,
        SUBJECT_ROLE,
        REZIDENT,
        MERRIED,
        EMP_STATUS,
        SUBJECT_CLASS,
        INSIDER,
        SEX,
        VIPK,
        VIP_FIO_MANAGER,
        VIP_PHONE_MANAGER,
        DATE_ON,
        DATE_OFF,
        EDDR_ID,
        actual_date as IDCARD_VALID_DATE,        
        IDDPL,        
        BPLACE,
        SUBSD,
        SUBSN,
        ELT_N,
        ELT_D,
        GCIF,
        NOMPDV,
        NOM_DOG,
        SW_RN,
        Y_ELT,
        ADM,
        FADR,
        ADR_ALT,
        BUSSS,
        PC_MF,
        PC_Z4,
        PC_Z3,
        PC_Z5,
        PC_Z2,
        PC_Z1,
        AGENT,
        PC_SS,
        STMT,
        VIDKL,
        VED,
        TIPA,
        PHKLI,
        AF1_9,
        IDDPD,
        DAIDI,
        DATVR,
        DATZ,
        DATE_PHOTO,
        IDDPR,
        ISE,
        OBSLU,
        CRSRC,
        DJOTH,
        DJAVI,
        DJ_TC,
        DJOWF,
        DJCFI,
        DJ_LN,
        DJ_FH,
        DJ_CP,
        CHORN,
        CRISK_KL,
        BC,
        SPMRK,
        K013,
        KODID,
        COUNTRY,
        MS_FS,
        MS_VD,
        MS_GR,
        LIM_KASS,
        LIM,
        LICO,
        UADR,
        MOB01,
        MOB02,
        MOB03,
        SUBS,
        K050,
        DEATH,
        NO_PHONE,
        NSMCV,
        NSMCC,
        NSMCT,
        NOTES,
        SAMZ,
        OREP,
        OVIFS,
        AF6,
        FSKRK,
        FSOMD,
        FSVED,
        FSZPD,
        FSPOR,
        FSRKZ,
        FSZOP,
        FSKPK,
        FSKPR,
        FSDIB,
        FSCP,
        FSVLZ,
        FSVLA,
        FSVLN,
        FSVLO,
        FSSST,
        FSSOD,
        FSVSN,
        DOV_P,
        DOV_A,
        DOV_F,
        NMKV,
        SN_GC,
        NMKK,
        PRINSIDER,
        NOTESEC,
        MB,
        PUBLP,
        WORKB,
        C_REG,
        C_DST,
        RGADM,
        RGTAX,
        DATEA,
        DATET,
        RNKP,
        CIGPO,
        COUNTRY_NAME,
        TARIF,
        AINAB,
        TGR,
        CUSTTYPE,
        RIZIK,
        SNSDR,
        IDPIB,
        FS,
        SED,
        DJER,
        CODCAGENT,
        SUTD,
        RVDBC,
        RVIBA,
        RVIDT,
        RV_XA,
        RVIBR,
        RVIBB,
        RVRNK,
        RVPH1,
        RVPH2,
        RVPH3,
        SAB,
        vip_account_manager
        from bars_dm.customers_plt
        where per_id=bars_dm.dm_import.GET_PERIOD_ID(''MONTH'',nvl(to_date(:param1, ''dd/mm/yyyy''), trunc(sysdate)))
		and kf = sys_context(''bars_context'', ''user_mfo'')');
begin
  update upl_sql t
  set t.sql_text = l_sql,
      t.vers = '1.0'
  where t.sql_id = 99444;
  if sql%rowcount = 0 then
    insert into upl_sql (sql_id, sql_text, before_proc, after_proc, descript, vers)
    values (99444, l_sql, null, null, 'CRM, Фізичні особи (основна інформація) - MONTH', '1.0');
  end if;
end;
/


prompt upl_sql CLIENTADDRESS(MONTH) ver. 1.0
declare
l_sql clob := to_clob('
select  KF,
        RNK,
        J_COUNTRY,
        J_ZIP,
        J_DOMAIN,
        J_REGION,
        J_LOCALITY,
        J_ADDRESS,
        J_TERRITORY_ID,
        J_LOCALITY_TYPE,
        J_STREET_TYPE,
        J_STREET,
        J_HOME_TYPE,
        J_HOME,
        J_HOMEPART_TYPE,
        J_HOMEPART,
        J_ROOM_TYPE,
        J_ROOM,
        j_koatuu,
        j_region_id,
        j_area_id,
        j_settlement_id,
        j_street_id,
        j_house_id,
        F_COUNTRY,
        F_ZIP,
        F_DOMAIN,
        F_REGION,
        F_LOCALITY,
        F_ADDRESS,
        F_TERRITORY_ID,
        F_LOCALITY_TYPE,
        F_STREET_TYPE,
        F_STREET,
        F_HOME_TYPE,
        F_HOME,
        F_HOMEPART_TYPE,
        F_HOMEPART,
        F_ROOM_TYPE,
        F_ROOM,
        f_koatuu,
        f_region_id,
        f_area_id,
        f_settlement_id,
        f_street_id,
        f_house_id,
        P_COUNTRY,
        P_ZIP,
        P_DOMAIN,
        P_REGION,
        P_LOCALITY,
        P_ADDRESS,
        P_TERRITORY_ID,
        P_LOCALITY_TYPE,
        P_STREET_TYPE,
        P_STREET,
        P_HOME_TYPE,
        P_HOME,
        P_HOMEPART_TYPE,
        P_HOMEPART,
        P_ROOM_TYPE,
        P_ROOM,
        p_koatuu,
        p_region_id,
        p_area_id,
        p_settlement_id,
        p_street_id,
        p_house_id
        from bars_dm.customers_plt
        where per_id=bars_dm.dm_import.GET_PERIOD_ID(''MONTH'',nvl(to_date(:param1, ''dd/mm/yyyy''), trunc(sysdate)))
		and kf = sys_context(''bars_context'', ''user_mfo'')');
begin
  update upl_sql t
  set t.sql_text = l_sql,
      t.vers = '1.0'
  where t.sql_id = 99445;
  if sql%rowcount = 0 then
    insert into upl_sql (sql_id, sql_text, before_proc, after_proc, descript, vers)
    values (99445, l_sql, null, null, 'CRM, Фізичні особи (коди адрес) - MONTH', '1.0');
  end if;
end;
/

commit;
/