

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_DM_AGRM_ACCOUNTS_ARCH.sql =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_DM_AGRM_ACCOUNTS_ARCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_DM_AGRM_ACCOUNTS_ARCH'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_DM_AGRM_ACCOUNTS_ARCH'', ''FILIAL'' , ''M'', ''M'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_DM_AGRM_ACCOUNTS_ARCH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_DM_AGRM_ACCOUNTS_ARCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_DM_AGRM_ACCOUNTS_ARCH 
   (	REPORT_DATE DATE, 
	KF CHAR(6), 
	VERSION_ID NUMBER(3,0), 
	ACC_ID NUMBER(38,0), 
	AGRM_ID NUMBER(38,0), 
	PRTFL_TP CHAR(3), 
	BEG_DT DATE, 
	END_DT DATE, 
	AGRM_NUM VARCHAR2(50), 
	AGRM_TP NUMBER(38,0), 
	AGRM_STE NUMBER(2,0), 
	 CONSTRAINT PK_DMAGRMACCARCH PRIMARY KEY (REPORT_DATE, KF, VERSION_ID, ACC_ID, AGRM_ID) ENABLE
   ) ORGANIZATION INDEX COMPRESS 3 PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSMDLD 
 PCTTHRESHOLD 50 INCLUDING PRTFL_TP OVERFLOW
 PCTFREE 10 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD 
  PARTITION BY RANGE (REPORT_DATE,KF) 
 (PARTITION P_20150630_SP_300465  VALUES LESS THAN (TO_DATE('' 2015-07-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''300465'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION SYS_P16136  VALUES LESS THAN (TO_DATE('' 2016-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''300465'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_302076  VALUES LESS THAN (TO_DATE('' 2016-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''302076'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_303398  VALUES LESS THAN (TO_DATE('' 2016-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''303398'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_304665  VALUES LESS THAN (TO_DATE('' 2016-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''304665'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_305482  VALUES LESS THAN (TO_DATE('' 2016-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''305482'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_311647  VALUES LESS THAN (TO_DATE('' 2016-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''311647'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_312356  VALUES LESS THAN (TO_DATE('' 2016-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''312356'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_313957  VALUES LESS THAN (TO_DATE('' 2016-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''313957'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_315784  VALUES LESS THAN (TO_DATE('' 2016-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''315784'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_322669  VALUES LESS THAN (TO_DATE('' 2016-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''322669'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_323475  VALUES LESS THAN (TO_DATE('' 2016-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''323475'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_324805  VALUES LESS THAN (TO_DATE('' 2016-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''324805'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_325796  VALUES LESS THAN (TO_DATE('' 2016-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''325796'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_326461  VALUES LESS THAN (TO_DATE('' 2016-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''326461'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_328845  VALUES LESS THAN (TO_DATE('' 2016-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''328845'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_331467  VALUES LESS THAN (TO_DATE('' 2016-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''331467'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_333368  VALUES LESS THAN (TO_DATE('' 2016-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''333368'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_335106  VALUES LESS THAN (TO_DATE('' 2016-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''335106'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_336503  VALUES LESS THAN (TO_DATE('' 2016-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''336503'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_337568  VALUES LESS THAN (TO_DATE('' 2016-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''337568'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_338545  VALUES LESS THAN (TO_DATE('' 2016-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''338545'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_351823  VALUES LESS THAN (TO_DATE('' 2016-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''351823'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_352457  VALUES LESS THAN (TO_DATE('' 2016-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''352457'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_353553  VALUES LESS THAN (TO_DATE('' 2016-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''353553'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_354507  VALUES LESS THAN (TO_DATE('' 2016-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''354507'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_356334  VALUES LESS THAN (TO_DATE('' 2016-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''356334'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160111_300465  VALUES LESS THAN (TO_DATE('' 2016-01-11 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''300465'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160401_SP_300465  VALUES LESS THAN (TO_DATE('' 2016-04-02 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''300465'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160404_SP_300465  VALUES LESS THAN (TO_DATE('' 2016-04-05 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''300465'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160405_SP_300465  VALUES LESS THAN (TO_DATE('' 2016-04-06 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''300465'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160601_SP_300465  VALUES LESS THAN (TO_DATE('' 2016-06-02 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''300465'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION SYS_P213016  VALUES LESS THAN (TO_DATE('' 2016-07-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''300465'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160701_SP_300465  VALUES LESS THAN (TO_DATE('' 2016-07-02 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''300465'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION SYS_P18158  VALUES LESS THAN (TO_DATE('' 2016-07-02 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''322669'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160704_SP_300465  VALUES LESS THAN (TO_DATE('' 2016-07-05 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''300465'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION SYS_P18518  VALUES LESS THAN (TO_DATE('' 2016-07-05 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''322669'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160705_SP_322669  VALUES LESS THAN (TO_DATE('' 2016-07-06 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''322669'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160706_SP_322669  VALUES LESS THAN (TO_DATE('' 2016-07-07 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''322669'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160707_SP_322669  VALUES LESS THAN (TO_DATE('' 2016-07-08 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''322669'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160708_SP_322669  VALUES LESS THAN (TO_DATE('' 2016-07-09 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''322669'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160711_SP_300465  VALUES LESS THAN (TO_DATE('' 2016-07-12 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''300465'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION SYS_P19511  VALUES LESS THAN (TO_DATE('' 2016-07-12 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''322669'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160712_SP_322669  VALUES LESS THAN (TO_DATE('' 2016-07-13 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''322669'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160713_SP_322669  VALUES LESS THAN (TO_DATE('' 2016-07-14 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''322669'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160714_SP_322669  VALUES LESS THAN (TO_DATE('' 2016-07-15 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''322669'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160715_SP_322669  VALUES LESS THAN (TO_DATE('' 2016-07-16 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''322669'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160718_SP_300465  VALUES LESS THAN (TO_DATE('' 2016-07-19 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''300465'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION SYS_P19513  VALUES LESS THAN (TO_DATE('' 2016-07-19 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''322669'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160719_SP_322669  VALUES LESS THAN (TO_DATE('' 2016-07-20 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''322669'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160720_SP_322669  VALUES LESS THAN (TO_DATE('' 2016-07-21 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''322669'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160721_SP_322669  VALUES LESS THAN (TO_DATE('' 2016-07-22 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''322669'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160722_SP_322669  VALUES LESS THAN (TO_DATE('' 2016-07-23 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''322669'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160725_SP_300465  VALUES LESS THAN (TO_DATE('' 2016-07-26 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''300465'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION SYS_P19515  VALUES LESS THAN (TO_DATE('' 2016-07-26 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''322669'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160726_SP_322669  VALUES LESS THAN (TO_DATE('' 2016-07-27 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''322669'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160727_SP_322669  VALUES LESS THAN (TO_DATE('' 2016-07-28 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''322669'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160728_SP_322669  VALUES LESS THAN (TO_DATE('' 2016-07-29 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''322669'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160729_SP_300465  VALUES LESS THAN (TO_DATE('' 2016-07-30 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''300465'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160729_SP_322669  VALUES LESS THAN (TO_DATE('' 2016-07-30 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''322669'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160830_SP_300465  VALUES LESS THAN (TO_DATE('' 2016-08-31 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''300465'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_20161031_SP_300465  VALUES LESS THAN (TO_DATE('' 2016-11-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''300465'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION P_20161110_SP_300465  VALUES LESS THAN (TO_DATE('' 2016-11-11 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''300465'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD , 
 PARTITION SYS_P217570  VALUES LESS THAN (TO_DATE('' 2016-11-17 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''), ''300465'') 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD 
 OVERFLOW PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD ) 
  PARALLEL 8 ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_DM_AGRM_ACCOUNTS_ARCH ***
 exec bpa.alter_policies('NBUR_DM_AGRM_ACCOUNTS_ARCH');


COMMENT ON TABLE BARS.NBUR_DM_AGRM_ACCOUNTS_ARCH IS '��`���� ������� �� ��������';
COMMENT ON COLUMN BARS.NBUR_DM_AGRM_ACCOUNTS_ARCH.REPORT_DATE IS '����� ����';
COMMENT ON COLUMN BARS.NBUR_DM_AGRM_ACCOUNTS_ARCH.KF IS '��� ������ (���)';
COMMENT ON COLUMN BARS.NBUR_DM_AGRM_ACCOUNTS_ARCH.VERSION_ID IS 'I������i����� ����';
COMMENT ON COLUMN BARS.NBUR_DM_AGRM_ACCOUNTS_ARCH.ACC_ID IS 'I������i����� ������� (ACC)';
COMMENT ON COLUMN BARS.NBUR_DM_AGRM_ACCOUNTS_ARCH.AGRM_ID IS '������������� ��������';
COMMENT ON COLUMN BARS.NBUR_DM_AGRM_ACCOUNTS_ARCH.PRTFL_TP IS '��� �������� ��������';
COMMENT ON COLUMN BARS.NBUR_DM_AGRM_ACCOUNTS_ARCH.BEG_DT IS '���� �������';
COMMENT ON COLUMN BARS.NBUR_DM_AGRM_ACCOUNTS_ARCH.END_DT IS '���� ���������';
COMMENT ON COLUMN BARS.NBUR_DM_AGRM_ACCOUNTS_ARCH.AGRM_NUM IS '����� ��������';
COMMENT ON COLUMN BARS.NBUR_DM_AGRM_ACCOUNTS_ARCH.AGRM_TP IS '��� �������� (CC_VIDD.VIDD)';
COMMENT ON COLUMN BARS.NBUR_DM_AGRM_ACCOUNTS_ARCH.AGRM_STE IS '���� �������� (CC_SOS.SOS)';




PROMPT *** Create  constraint CC_DMAGRMACCARCH_REPORTDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_AGRM_ACCOUNTS_ARCH MODIFY (REPORT_DATE CONSTRAINT CC_DMAGRMACCARCH_REPORTDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMAGRMACCARCH_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_AGRM_ACCOUNTS_ARCH MODIFY (KF CONSTRAINT CC_DMAGRMACCARCH_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMAGRMACCARCH_VRSN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_AGRM_ACCOUNTS_ARCH MODIFY (VERSION_ID CONSTRAINT CC_DMAGRMACCARCH_VRSN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMAGRMACCARCH_ACNTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_AGRM_ACCOUNTS_ARCH MODIFY (ACC_ID CONSTRAINT CC_DMAGRMACCARCH_ACNTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMAGRMACCARCH_AGRMID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_AGRM_ACCOUNTS_ARCH MODIFY (AGRM_ID CONSTRAINT CC_DMAGRMACCARCH_AGRMID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMAGRMACCARCH_PRTFLTP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_AGRM_ACCOUNTS_ARCH MODIFY (PRTFL_TP CONSTRAINT CC_DMAGRMACCARCH_PRTFLTP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMAGRMACCARCH_BEGDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_AGRM_ACCOUNTS_ARCH MODIFY (BEG_DT CONSTRAINT CC_DMAGRMACCARCH_BEGDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DMAGRMACCARCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_AGRM_ACCOUNTS_ARCH ADD CONSTRAINT PK_DMAGRMACCARCH PRIMARY KEY (REPORT_DATE, KF, VERSION_ID, ACC_ID, AGRM_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSMDLD  LOCAL
 (PARTITION P_20150630_SP_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION SYS_P16136 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_302076 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_303398 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_304665 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_305482 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_311647 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_312356 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_313957 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_315784 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_323475 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_324805 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_325796 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_326461 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_328845 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_331467 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_333368 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_335106 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_336503 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_337568 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_338545 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_351823 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_352457 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_353553 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_354507 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_356334 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160111_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160401_SP_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160404_SP_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160405_SP_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160601_SP_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION SYS_P213016 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160701_SP_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION SYS_P18158 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160704_SP_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION SYS_P18518 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160705_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160706_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160707_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160708_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160711_SP_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION SYS_P19511 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160712_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160713_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160714_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160715_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160718_SP_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION SYS_P19513 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160719_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160720_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160721_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160722_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160725_SP_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION SYS_P19515 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160726_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160727_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160728_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160729_SP_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160729_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160830_SP_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20161031_SP_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20161110_SP_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION SYS_P217570 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD ) COMPRESS 3  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DMAGRMACCARCH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DMAGRMACCARCH ON BARS.NBUR_DM_AGRM_ACCOUNTS_ARCH (REPORT_DATE, KF, VERSION_ID, ACC_ID, AGRM_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSMDLD  LOCAL
 (PARTITION P_20150630_SP_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION SYS_P16136 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_302076 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_303398 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_304665 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_305482 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_311647 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_312356 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_313957 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_315784 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_323475 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_324805 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_325796 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_326461 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_328845 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_331467 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_333368 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_335106 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_336503 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_337568 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_338545 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_351823 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_352457 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_353553 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_354507 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MINVALUE_SP_356334 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160111_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160401_SP_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160404_SP_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160405_SP_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160601_SP_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION SYS_P213016 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160701_SP_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION SYS_P18158 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160704_SP_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION SYS_P18518 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160705_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160706_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160707_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160708_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160711_SP_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION SYS_P19511 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160712_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160713_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160714_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160715_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160718_SP_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION SYS_P19513 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160719_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160720_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160721_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160722_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160725_SP_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION SYS_P19515 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160726_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160727_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160728_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160729_SP_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160729_SP_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20160830_SP_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20161031_SP_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_20161110_SP_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION SYS_P217570 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLD ) COMPRESS 3 
  PARALLEL 8 ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_DM_AGRM_ACCOUNTS_ARCH ***
grant SELECT                                                                 on NBUR_DM_AGRM_ACCOUNTS_ARCH to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_DM_AGRM_ACCOUNTS_ARCH to BARSUPL;
grant SELECT                                                                 on NBUR_DM_AGRM_ACCOUNTS_ARCH to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_DM_AGRM_ACCOUNTS_ARCH to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_DM_AGRM_ACCOUNTS_ARCH.sql =======
PROMPT ===================================================================================== 
