

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_EAD_SYNC_QUEUE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_EAD_SYNC_QUEUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_EAD_SYNC_QUEUE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_EAD_SYNC_QUEUE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_EAD_SYNC_QUEUE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_EAD_SYNC_QUEUE ***

begin 
  execute immediate 'create table TMP_EAD_SYNC_QUEUE
(
  id            NUMBER,
  crt_date      DATE,
  type_id       VARCHAR2(100),
  obj_id        VARCHAR2(100),
  status_id     VARCHAR2(100),
  err_text      VARCHAR2(4000),
  err_count     NUMBER default 0,
  message_id    VARCHAR2(100),
  message_date  DATE,
  message       CLOB,
  responce_id   VARCHAR2(100),
  responce_date DATE,
  responce      CLOB,
  kf            VARCHAR2(6) default sys_context(''bars_context'',''user_mfo''),
  rnk           NUMBER(38)
)
partition by list  (STATUS_ID)
subpartition by list (KF)
(
partition EAD_ST_NEW_P                  values (''OUTDATED'') tablespace BRSBIGD
(   subpartition SP_EAD_300465_OUTDATED values (''300465'') tablespace BRSBIGD,
    subpartition SP_EAD_324805_OUTDATED values (''324805'') tablespace BRSBIGD,
    subpartition SP_EAD_302076_OUTDATED values (''302076'') tablespace BRSBIGD,
    subpartition SP_EAD_303398_OUTDATED values (''303398'') tablespace BRSBIGD,
    subpartition SP_EAD_305482_OUTDATED values (''305482'') tablespace BRSBIGD,
    subpartition SP_EAD_335106_OUTDATED values (''335106'') tablespace BRSBIGD,
    subpartition SP_EAD_311647_OUTDATED values (''311647'') tablespace BRSBIGD,
    subpartition SP_EAD_312356_OUTDATED values (''312356'') tablespace BRSBIGD,
    subpartition SP_EAD_313957_OUTDATED values (''313957'') tablespace BRSBIGD,
    subpartition SP_EAD_336503_OUTDATED values (''336503'') tablespace BRSBIGD,
    subpartition SP_EAD_322669_OUTDATED values (''322669'') tablespace BRSBIGD,
    subpartition SP_EAD_323475_OUTDATED values (''323475'') tablespace BRSBIGD,
    subpartition SP_EAD_304665_OUTDATED values (''304665'') tablespace BRSBIGD,
    subpartition SP_EAD_325796_OUTDATED values (''325796'') tablespace BRSBIGD,
    subpartition SP_EAD_326461_OUTDATED values (''326461'') tablespace BRSBIGD,
    subpartition SP_EAD_328845_OUTDATED values (''328845'') tablespace BRSBIGD,
    subpartition SP_EAD_331467_OUTDATED values (''331467'') tablespace BRSBIGD,
    subpartition SP_EAD_333368_OUTDATED values (''333368'') tablespace BRSBIGD,
    subpartition SP_EAD_337568_OUTDATED values (''337568'') tablespace BRSBIGD,
    subpartition SP_EAD_338545_OUTDATED values (''338545'') tablespace BRSBIGD,
    subpartition SP_EAD_351823_OUTDATED values (''351823'') tablespace BRSBIGD,
    subpartition SP_EAD_352457_OUTDATED values (''352457'') tablespace BRSBIGD,
    subpartition SP_EAD_315784_OUTDATED values (''315784'') tablespace BRSBIGD,
    subpartition SP_EAD_354507_OUTDATED values (''354507'') tablespace BRSBIGD,
    subpartition SP_EAD_356334_OUTDATED values (''356334'') tablespace BRSBIGD,
    subpartition SP_EAD_353553_OUTDATED values (''353553'') tablespace BRSBIGD)
,partition EAD_ST_PROC_P              values (''PROC'')  tablespace BRSBIGD
(   subpartition SP_EAD_300465_PROC values (''300465'') tablespace BRSBIGD,
    subpartition SP_EAD_324805_PROC values (''324805'') tablespace BRSBIGD,
    subpartition SP_EAD_302076_PROC values (''302076'') tablespace BRSBIGD,
    subpartition SP_EAD_303398_PROC values (''303398'') tablespace BRSBIGD,
    subpartition SP_EAD_305482_PROC values (''305482'') tablespace BRSBIGD,
    subpartition SP_EAD_335106_PROC values (''335106'') tablespace BRSBIGD,
    subpartition SP_EAD_311647_PROC values (''311647'') tablespace BRSBIGD,
    subpartition SP_EAD_312356_PROC values (''312356'') tablespace BRSBIGD,
    subpartition SP_EAD_313957_PROC values (''313957'') tablespace BRSBIGD,
    subpartition SP_EAD_336503_PROC values (''336503'') tablespace BRSBIGD,
    subpartition SP_EAD_322669_PROC values (''322669'') tablespace BRSBIGD,
    subpartition SP_EAD_323475_PROC values (''323475'') tablespace BRSBIGD,
    subpartition SP_EAD_304665_PROC values (''304665'') tablespace BRSBIGD,
    subpartition SP_EAD_325796_PROC values (''325796'') tablespace BRSBIGD,
    subpartition SP_EAD_326461_PROC values (''326461'') tablespace BRSBIGD,
    subpartition SP_EAD_328845_PROC values (''328845'') tablespace BRSBIGD,
    subpartition SP_EAD_331467_PROC values (''331467'') tablespace BRSBIGD,
    subpartition SP_EAD_333368_PROC values (''333368'') tablespace BRSBIGD,
    subpartition SP_EAD_337568_PROC values (''337568'') tablespace BRSBIGD,
    subpartition SP_EAD_338545_PROC values (''338545'') tablespace BRSBIGD,
    subpartition SP_EAD_351823_PROC values (''351823'') tablespace BRSBIGD,
    subpartition SP_EAD_352457_PROC values (''352457'') tablespace BRSBIGD,
    subpartition SP_EAD_315784_PROC values (''315784'') tablespace BRSBIGD,
    subpartition SP_EAD_354507_PROC values (''354507'') tablespace BRSBIGD,
    subpartition SP_EAD_356334_PROC values (''356334'') tablespace BRSBIGD,
    subpartition SP_EAD_353553_PROC values (''353553'') tablespace BRSBIGD)
,partition EAD_ST_MSG_SEND_P             values (''MSG_SEND'') tablespace BRSBIGD
(   subpartition SP_EAD_300465_MSG_SEND values (''300465'') tablespace BRSBIGD,
    subpartition SP_EAD_324805_MSG_SEND values (''324805'') tablespace BRSBIGD,
    subpartition SP_EAD_302076_MSG_SEND values (''302076'') tablespace BRSBIGD,
    subpartition SP_EAD_303398_MSG_SEND values (''303398'') tablespace BRSBIGD,
    subpartition SP_EAD_305482_MSG_SEND values (''305482'') tablespace BRSBIGD,
    subpartition SP_EAD_335106_MSG_SEND values (''335106'') tablespace BRSBIGD,
    subpartition SP_EAD_311647_MSG_SEND values (''311647'') tablespace BRSBIGD,
    subpartition SP_EAD_312356_MSG_SEND values (''312356'') tablespace BRSBIGD,
    subpartition SP_EAD_313957_MSG_SEND values (''313957'') tablespace BRSBIGD,
    subpartition SP_EAD_336503_MSG_SEND values (''336503'') tablespace BRSBIGD,
    subpartition SP_EAD_322669_MSG_SEND values (''322669'') tablespace BRSBIGD,
    subpartition SP_EAD_323475_MSG_SEND values (''323475'') tablespace BRSBIGD,
    subpartition SP_EAD_304665_MSG_SEND values (''304665'') tablespace BRSBIGD,
    subpartition SP_EAD_325796_MSG_SEND values (''325796'') tablespace BRSBIGD,
    subpartition SP_EAD_326461_MSG_SEND values (''326461'') tablespace BRSBIGD,
    subpartition SP_EAD_328845_MSG_SEND values (''328845'') tablespace BRSBIGD,
    subpartition SP_EAD_331467_MSG_SEND values (''331467'') tablespace BRSBIGD,
    subpartition SP_EAD_333368_MSG_SEND values (''333368'') tablespace BRSBIGD,
    subpartition SP_EAD_337568_MSG_SEND values (''337568'') tablespace BRSBIGD,
    subpartition SP_EAD_338545_MSG_SEND values (''338545'') tablespace BRSBIGD,
    subpartition SP_EAD_351823_MSG_SEND values (''351823'') tablespace BRSBIGD,
    subpartition SP_EAD_352457_MSG_SEND values (''352457'') tablespace BRSBIGD,
    subpartition SP_EAD_315784_MSG_SEND values (''315784'') tablespace BRSBIGD,
    subpartition SP_EAD_354507_MSG_SEND values (''354507'') tablespace BRSBIGD,
    subpartition SP_EAD_356334_MSG_SEND values (''356334'') tablespace BRSBIGD,
    subpartition SP_EAD_353553_MSG_SEND values (''353553'') tablespace BRSBIGD)
,partition EAD_ST_RSP_RECEIVED_P             values (''RSP_RECEIVED'') tablespace BRSBIGD
(   subpartition SP_EAD_300465_RSP_RECEIVED values (''300465'') tablespace BRSBIGD,
    subpartition SP_EAD_324805_RSP_RECEIVED values (''324805'') tablespace BRSBIGD,
    subpartition SP_EAD_302076_RSP_RECEIVED values (''302076'') tablespace BRSBIGD,
    subpartition SP_EAD_303398_RSP_RECEIVED values (''303398'') tablespace BRSBIGD,
    subpartition SP_EAD_305482_RSP_RECEIVED values (''305482'') tablespace BRSBIGD,
    subpartition SP_EAD_335106_RSP_RECEIVED values (''335106'') tablespace BRSBIGD,
    subpartition SP_EAD_311647_RSP_RECEIVED values (''311647'') tablespace BRSBIGD,
    subpartition SP_EAD_312356_RSP_RECEIVED values (''312356'') tablespace BRSBIGD,
    subpartition SP_EAD_313957_RSP_RECEIVED values (''313957'') tablespace BRSBIGD,
    subpartition SP_EAD_336503_RSP_RECEIVED values (''336503'') tablespace BRSBIGD,
    subpartition SP_EAD_322669_RSP_RECEIVED values (''322669'') tablespace BRSBIGD,
    subpartition SP_EAD_323475_RSP_RECEIVED values (''323475'') tablespace BRSBIGD,
    subpartition SP_EAD_304665_RSP_RECEIVED values (''304665'') tablespace BRSBIGD,
    subpartition SP_EAD_325796_RSP_RECEIVED values (''325796'') tablespace BRSBIGD,
    subpartition SP_EAD_326461_RSP_RECEIVED values (''326461'') tablespace BRSBIGD,
    subpartition SP_EAD_328845_RSP_RECEIVED values (''328845'') tablespace BRSBIGD,
    subpartition SP_EAD_331467_RSP_RECEIVED values (''331467'') tablespace BRSBIGD,
    subpartition SP_EAD_333368_RSP_RECEIVED values (''333368'') tablespace BRSBIGD,
    subpartition SP_EAD_337568_RSP_RECEIVED values (''337568'') tablespace BRSBIGD,
    subpartition SP_EAD_338545_RSP_RECEIVED values (''338545'') tablespace BRSBIGD,
    subpartition SP_EAD_351823_RSP_RECEIVED values (''351823'') tablespace BRSBIGD,
    subpartition SP_EAD_352457_RSP_RECEIVED values (''352457'') tablespace BRSBIGD,
    subpartition SP_EAD_315784_RSP_RECEIVED values (''315784'') tablespace BRSBIGD,
    subpartition SP_EAD_354507_RSP_RECEIVED values (''354507'') tablespace BRSBIGD,
    subpartition SP_EAD_356334_RSP_RECEIVED values (''356334'') tablespace BRSBIGD,
    subpartition SP_EAD_353553_RSP_RECEIVED values (''353553'') tablespace BRSBIGD)
,partition EAD_ST_RSP_PARSED_P             values (''RSP_PARSED'') tablespace BRSBIGD
(   subpartition SP_EAD_300465_RSP_PARSED values (''300465'') tablespace BRSBIGD,
    subpartition SP_EAD_324805_RSP_PARSED values (''324805'') tablespace BRSBIGD,
    subpartition SP_EAD_302076_RSP_PARSED values (''302076'') tablespace BRSBIGD,
    subpartition SP_EAD_303398_RSP_PARSED values (''303398'') tablespace BRSBIGD,
    subpartition SP_EAD_305482_RSP_PARSED values (''305482'') tablespace BRSBIGD,
    subpartition SP_EAD_335106_RSP_PARSED values (''335106'') tablespace BRSBIGD,
    subpartition SP_EAD_311647_RSP_PARSED values (''311647'') tablespace BRSBIGD,
    subpartition SP_EAD_312356_RSP_PARSED values (''312356'') tablespace BRSBIGD,
    subpartition SP_EAD_313957_RSP_PARSED values (''313957'') tablespace BRSBIGD,
    subpartition SP_EAD_336503_RSP_PARSED values (''336503'') tablespace BRSBIGD,
    subpartition SP_EAD_322669_RSP_PARSED values (''322669'') tablespace BRSBIGD,
    subpartition SP_EAD_323475_RSP_PARSED values (''323475'') tablespace BRSBIGD,
    subpartition SP_EAD_304665_RSP_PARSED values (''304665'') tablespace BRSBIGD,
    subpartition SP_EAD_325796_RSP_PARSED values (''325796'') tablespace BRSBIGD,
    subpartition SP_EAD_326461_RSP_PARSED values (''326461'') tablespace BRSBIGD,
    subpartition SP_EAD_328845_RSP_PARSED values (''328845'') tablespace BRSBIGD,
    subpartition SP_EAD_331467_RSP_PARSED values (''331467'') tablespace BRSBIGD,
    subpartition SP_EAD_333368_RSP_PARSED values (''333368'') tablespace BRSBIGD,
    subpartition SP_EAD_337568_RSP_PARSED values (''337568'') tablespace BRSBIGD,
    subpartition SP_EAD_338545_RSP_PARSED values (''338545'') tablespace BRSBIGD,
    subpartition SP_EAD_351823_RSP_PARSED values (''351823'') tablespace BRSBIGD,
    subpartition SP_EAD_352457_RSP_PARSED values (''352457'') tablespace BRSBIGD,
    subpartition SP_EAD_315784_RSP_PARSED values (''315784'') tablespace BRSBIGD,
    subpartition SP_EAD_354507_RSP_PARSED values (''354507'') tablespace BRSBIGD,
    subpartition SP_EAD_356334_RSP_PARSED values (''356334'') tablespace BRSBIGD,
    subpartition SP_EAD_353553_RSP_PARSED values (''353553'') tablespace BRSBIGD)
,partition EAD_ST_DONE_P             values (''DONE'')   tablespace BRSBIGD
(   subpartition SP_EAD_300465_DONE values (''300465'') tablespace BRSBIGD,
    subpartition SP_EAD_324805_DONE values (''324805'') tablespace BRSBIGD,
    subpartition SP_EAD_302076_DONE values (''302076'') tablespace BRSBIGD,
    subpartition SP_EAD_303398_DONE values (''303398'') tablespace BRSBIGD,
    subpartition SP_EAD_305482_DONE values (''305482'') tablespace BRSBIGD,
    subpartition SP_EAD_335106_DONE values (''335106'') tablespace BRSBIGD,
    subpartition SP_EAD_311647_DONE values (''311647'') tablespace BRSBIGD,
    subpartition SP_EAD_312356_DONE values (''312356'') tablespace BRSBIGD,
    subpartition SP_EAD_313957_DONE values (''313957'') tablespace BRSBIGD,
    subpartition SP_EAD_336503_DONE values (''336503'') tablespace BRSBIGD,
    subpartition SP_EAD_322669_DONE values (''322669'') tablespace BRSBIGD,
    subpartition SP_EAD_323475_DONE values (''323475'') tablespace BRSBIGD,
    subpartition SP_EAD_304665_DONE values (''304665'') tablespace BRSBIGD,
    subpartition SP_EAD_325796_DONE values (''325796'') tablespace BRSBIGD,
    subpartition SP_EAD_326461_DONE values (''326461'') tablespace BRSBIGD,
    subpartition SP_EAD_328845_DONE values (''328845'') tablespace BRSBIGD,
    subpartition SP_EAD_331467_DONE values (''331467'') tablespace BRSBIGD,
    subpartition SP_EAD_333368_DONE values (''333368'') tablespace BRSBIGD,
    subpartition SP_EAD_337568_DONE values (''337568'') tablespace BRSBIGD,
    subpartition SP_EAD_338545_DONE values (''338545'') tablespace BRSBIGD,
    subpartition SP_EAD_351823_DONE values (''351823'') tablespace BRSBIGD,
    subpartition SP_EAD_352457_DONE values (''352457'') tablespace BRSBIGD,
    subpartition SP_EAD_315784_DONE values (''315784'') tablespace BRSBIGD,
    subpartition SP_EAD_354507_DONE values (''354507'') tablespace BRSBIGD,
    subpartition SP_EAD_356334_DONE values (''356334'') tablespace BRSBIGD,
    subpartition SP_EAD_353553_DONE values (''353553'') tablespace BRSBIGD)
,partition EAD_ST_ERROR_P             values (''ERROR'')  tablespace BRSBIGD
(   subpartition SP_EAD_300465_ERROR values (''300465'') tablespace BRSBIGD,
    subpartition SP_EAD_324805_ERROR values (''324805'') tablespace BRSBIGD,
    subpartition SP_EAD_302076_ERROR values (''302076'') tablespace BRSBIGD,
    subpartition SP_EAD_303398_ERROR values (''303398'') tablespace BRSBIGD,
    subpartition SP_EAD_305482_ERROR values (''305482'') tablespace BRSBIGD,
    subpartition SP_EAD_335106_ERROR values (''335106'') tablespace BRSBIGD,
    subpartition SP_EAD_311647_ERROR values (''311647'') tablespace BRSBIGD,
    subpartition SP_EAD_312356_ERROR values (''312356'') tablespace BRSBIGD,
    subpartition SP_EAD_313957_ERROR values (''313957'') tablespace BRSBIGD,
    subpartition SP_EAD_336503_ERROR values (''336503'') tablespace BRSBIGD,
    subpartition SP_EAD_322669_ERROR values (''322669'') tablespace BRSBIGD,
    subpartition SP_EAD_323475_ERROR values (''323475'') tablespace BRSBIGD,
    subpartition SP_EAD_304665_ERROR values (''304665'') tablespace BRSBIGD,
    subpartition SP_EAD_325796_ERROR values (''325796'') tablespace BRSBIGD,
    subpartition SP_EAD_326461_ERROR values (''326461'') tablespace BRSBIGD,
    subpartition SP_EAD_328845_ERROR values (''328845'') tablespace BRSBIGD,
    subpartition SP_EAD_331467_ERROR values (''331467'') tablespace BRSBIGD,
    subpartition SP_EAD_333368_ERROR values (''333368'') tablespace BRSBIGD,
    subpartition SP_EAD_337568_ERROR values (''337568'') tablespace BRSBIGD,
    subpartition SP_EAD_338545_ERROR values (''338545'') tablespace BRSBIGD,
    subpartition SP_EAD_351823_ERROR values (''351823'') tablespace BRSBIGD,
    subpartition SP_EAD_352457_ERROR values (''352457'') tablespace BRSBIGD,
    subpartition SP_EAD_315784_ERROR values (''315784'') tablespace BRSBIGD,
    subpartition SP_EAD_354507_ERROR values (''354507'') tablespace BRSBIGD,
    subpartition SP_EAD_356334_ERROR values (''356334'') tablespace BRSBIGD,
    subpartition SP_EAD_353553_ERROR values (''353553'') tablespace BRSBIGD)
,partition EAD_ST_OUTDATED_P        values (''NEW'')    tablespace BRSBIGD
(   subpartition SP_EAD_300465_NEW values (''300465'') tablespace BRSBIGD,
    subpartition SP_EAD_324805_NEW values (''324805'') tablespace BRSBIGD,
    subpartition SP_EAD_302076_NEW values (''302076'') tablespace BRSBIGD,
    subpartition SP_EAD_303398_NEW values (''303398'') tablespace BRSBIGD,
    subpartition SP_EAD_305482_NEW values (''305482'') tablespace BRSBIGD,
    subpartition SP_EAD_335106_NEW values (''335106'') tablespace BRSBIGD,
    subpartition SP_EAD_311647_NEW values (''311647'') tablespace BRSBIGD,
    subpartition SP_EAD_312356_NEW values (''312356'') tablespace BRSBIGD,
    subpartition SP_EAD_313957_NEW values (''313957'') tablespace BRSBIGD,
    subpartition SP_EAD_336503_NEW values (''336503'') tablespace BRSBIGD,
    subpartition SP_EAD_322669_NEW values (''322669'') tablespace BRSBIGD,
    subpartition SP_EAD_323475_NEW values (''323475'') tablespace BRSBIGD,
    subpartition SP_EAD_304665_NEW values (''304665'') tablespace BRSBIGD,
    subpartition SP_EAD_325796_NEW values (''325796'') tablespace BRSBIGD,
    subpartition SP_EAD_326461_NEW values (''326461'') tablespace BRSBIGD,
    subpartition SP_EAD_328845_NEW values (''328845'') tablespace BRSBIGD,
    subpartition SP_EAD_331467_NEW values (''331467'') tablespace BRSBIGD,
    subpartition SP_EAD_333368_NEW values (''333368'') tablespace BRSBIGD,
    subpartition SP_EAD_337568_NEW values (''337568'') tablespace BRSBIGD,
    subpartition SP_EAD_338545_NEW values (''338545'') tablespace BRSBIGD,
    subpartition SP_EAD_351823_NEW values (''351823'') tablespace BRSBIGD,
    subpartition SP_EAD_352457_NEW values (''352457'') tablespace BRSBIGD,
    subpartition SP_EAD_315784_NEW values (''315784'') tablespace BRSBIGD,
    subpartition SP_EAD_354507_NEW values (''354507'') tablespace BRSBIGD,
    subpartition SP_EAD_356334_NEW values (''356334'') tablespace BRSBIGD,
    subpartition SP_EAD_353553_NEW values (''353553'') tablespace BRSBIGD)
)';
    
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** Create  grants  TMP_EAD_SYNC_QUEUE ***
grant SELECT on TMP_EAD_SYNC_QUEUE  to BARS_ACCESS_DEFROLE;
grant SELECT on TMP_EAD_SYNC_QUEUE  to BARS_DM;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_EAD_SYNC_QUEUE.sql =========*** End **
PROMPT ===================================================================================== 
