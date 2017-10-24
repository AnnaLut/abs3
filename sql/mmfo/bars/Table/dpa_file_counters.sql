

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPA_FILE_COUNTERS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPA_FILE_COUNTERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPA_FILE_COUNTERS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPA_FILE_COUNTERS'', ''FILIAL'' , null, ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DPA_FILE_COUNTERS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPA_FILE_COUNTERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPA_FILE_COUNTERS 
   (	NBUF_DATE DATE, 
	NBUF_SEQ NUMBER(2,0), 
	TAXF_DATE DATE, 
	TAXF_SEQ NUMBER(3,0), 
	TAXD_DATE DATE, 
	TAXD_SEQ NUMBER(2,0), 
	TAXM_DATE DATE, 
	TAXM_SEQ NUMBER(2,0), 
	TAXB_DATE DATE, 
	TAXB_SEQ NUMBER(2,0), 
	NBUQ_DATE DATE, 
	NBUQ_SEQ NUMBER(2,0), 
	TAXK_DATE DATE, 
	TAXK_SEQ NUMBER(2,0), 
	FTM_DATE DATE, 
	FTM_SEQ NUMBER, 
	TAXCV_DATE DATE, 
	TAXCV_SEQ NUMBER, 
	TAXCA_DATE DATE, 
	TAXCA_SEQ NUMBER, 
	NBUF_SEQ_DEFAULT NUMBER DEFAULT 0, 
	TAXF_SEQ_DEFAULT NUMBER DEFAULT 0, 
	TAXB_SEQ_DEFAULT NUMBER DEFAULT 0, 
	TAXD_SEQ_DEFAULT NUMBER DEFAULT 0, 
	TAXM_SEQ_DEFAULT NUMBER DEFAULT 0, 
	NBUQ_SEQ_DEFAULT NUMBER DEFAULT 0, 
	TAXK_SEQ_DEFAULT NUMBER DEFAULT 0, 
	TAXCV_SEQ_DEFAULT NUMBER DEFAULT 0, 
	TAXCA_SEQ_DEFAULT NUMBER DEFAULT 0, 
	TAXP_DATE DATE, 
	TAXP_SEQ NUMBER(2,0), 
	TAXP_SEQ_DEFAULT NUMBER(2,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPA_FILE_COUNTERS ***
 exec bpa.alter_policies('DPA_FILE_COUNTERS');


COMMENT ON TABLE BARS.DPA_FILE_COUNTERS IS '';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.TAXM_SEQ_DEFAULT IS 'Номер последнего файла @M (умолчательное значение)';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.NBUQ_SEQ_DEFAULT IS 'Номер последнего файла ^Q (умолчательное значение)';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.TAXK_SEQ_DEFAULT IS 'Номер последнего файла @K (умолчательное значение)';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.TAXCV_SEQ_DEFAULT IS '';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.TAXCA_SEQ_DEFAULT IS '';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.TAXP_DATE IS '';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.TAXP_SEQ IS '';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.TAXP_SEQ_DEFAULT IS '';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.KF IS '';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.NBUF_DATE IS '';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.NBUF_SEQ IS '';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.TAXF_DATE IS '';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.TAXF_SEQ IS '';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.TAXD_DATE IS '';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.TAXD_SEQ IS '';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.TAXM_DATE IS '';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.TAXM_SEQ IS '';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.TAXB_DATE IS '';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.TAXB_SEQ IS '';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.NBUQ_DATE IS '';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.NBUQ_SEQ IS '';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.TAXK_DATE IS '';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.TAXK_SEQ IS '';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.FTM_DATE IS '';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.FTM_SEQ IS '';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.TAXCV_DATE IS '';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.TAXCV_SEQ IS '';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.TAXCA_DATE IS '';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.TAXCA_SEQ IS '';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.NBUF_SEQ_DEFAULT IS 'Номер последнего файла ^F (умолчательное значение)';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.TAXF_SEQ_DEFAULT IS 'Номер последнего файла @F (умолчательное значение)';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.TAXB_SEQ_DEFAULT IS 'Номер последнего файла @B (умолчательное значение)';
COMMENT ON COLUMN BARS.DPA_FILE_COUNTERS.TAXD_SEQ_DEFAULT IS 'Номер последнего файла @D (умолчательное значение)';




PROMPT *** Create  constraint FK_DPAFILECOUNTERS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPA_FILE_COUNTERS ADD CONSTRAINT FK_DPAFILECOUNTERS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPAFILECOUNTERS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPA_FILE_COUNTERS MODIFY (KF CONSTRAINT CC_DPAFILECOUNTERS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPA_FILE_COUNTERS ***
grant SELECT,UPDATE                                                          on DPA_FILE_COUNTERS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPA_FILE_COUNTERS to BARS_DM;
grant SELECT,UPDATE                                                          on DPA_FILE_COUNTERS to RPBN002;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPA_FILE_COUNTERS to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to DPA_FILE_COUNTERS ***

  CREATE OR REPLACE PUBLIC SYNONYM DPA_FILE_COUNTERS FOR BARS.DPA_FILE_COUNTERS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPA_FILE_COUNTERS.sql =========*** End
PROMPT ===================================================================================== 
