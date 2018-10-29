prompt Секционирование таблицы REC_QUE;
begin
    lock table REC_QUE in exclusive mode;
    execute immediate q'[create table tmp_rec_que (rec, rec_g, otm, kf, fmcheck, constraint PK_REC_QUE primary key (KF, REC))
    organization index
PARTITION BY LIST (KF)
( PARTITION KF_300465 VALUES ('300465')
, PARTITION KF_302076 VALUES ('302076')
, PARTITION KF_303398 VALUES ('303398')
, PARTITION KF_304665 VALUES ('304665')
, PARTITION KF_305482 VALUES ('305482')
, PARTITION KF_311647 VALUES ('311647')
, PARTITION KF_312356 VALUES ('312356')
, PARTITION KF_313957 VALUES ('313957')
, PARTITION KF_315784 VALUES ('315784')
, PARTITION KF_322669 VALUES ('322669')
, PARTITION KF_323475 VALUES ('323475')
, PARTITION KF_324805 VALUES ('324805')
, PARTITION KF_325796 VALUES ('325796')
, PARTITION KF_326461 VALUES ('326461')
, PARTITION KF_328845 VALUES ('328845')
, PARTITION KF_331467 VALUES ('331467')
, PARTITION KF_333368 VALUES ('333368')
, PARTITION KF_335106 VALUES ('335106')
, PARTITION KF_336503 VALUES ('336503')
, PARTITION KF_337568 VALUES ('337568')
, PARTITION KF_338545 VALUES ('338545')
, PARTITION KF_351823 VALUES ('351823')
, PARTITION KF_352457 VALUES ('352457')
, PARTITION KF_353553 VALUES ('353553')
, PARTITION KF_354507 VALUES ('354507')
, PARTITION KF_356334 VALUES ('356334')
)
tablespace brsdyni pctfree 30
as
select * from rec_que]';
execute immediate 'alter table tmp_REC_QUE modify fmcheck default 0';
execute immediate 'alter table TMP_REC_QUE modify kf default sys_context(''bars_context'', ''user_mfo'')';
execute immediate 'drop table REC_QUE';
execute immediate 'rename TMP_REC_QUE to REC_QUE';
--execute immediate 'drop table TMP_REC_QUE';
-- Add/modify columns 

end;
/
COMMENT ON TABLE BARS.REC_QUE IS 'Очередь визирования документов';
COMMENT ON COLUMN BARS.REC_QUE.REF IS 'Референс документа';
COMMENT ON COLUMN BARS.REC_QUE.FMCHECK IS '1-проверено фин.мониторингом';
COMMENT ON COLUMN BARS.REC_QUE.KF IS '';
COMMENT ON COLUMN BARS.REC_QUE.OTM IS 'Признак возврата на пред.визу';


PROMPT *** Create  grants  REC_QUE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on REC_QUE         to ABS_ADMIN;
grant SELECT                                                                 on REC_QUE         to BARSREADER_ROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on REC_QUE         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REC_QUE         to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on REC_QUE         to START1;
grant SELECT                                                                 on REC_QUE         to TOSS;
grant SELECT                                                                 on REC_QUE         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REC_QUE         to WR_ALL_RIGHTS;

prompt Статистика
begin
    dbms_stats.gather_table_stats(ownname => 'BARS', tabname => 'REC_QUE', estimate_percent => dbms_stats.AUTO_SAMPLE_SIZE, cascade => true);
end;
/
