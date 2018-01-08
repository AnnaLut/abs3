

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/MP_DM.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  table MP_DM ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.MP_DM 
   (	OWNER VARCHAR2(30), 
	TABLE_NAME VARCHAR2(30), 
	COLUMN_NAME VARCHAR2(30), 
	DM_NAME VARCHAR2(30), 
	DM_COLUMN VARCHAR2(30), 
	C_DPND VARCHAR2(80), 
	TXT VARCHAR2(160), 
	COLUMN_ID NUMBER(4,0), 
	DM_F_PK NUMBER(1,0), 
	WHR_DPND VARCHAR2(160), 
	F_FK NUMBER(1,0), 
	JOIN_DPND VARCHAR2(256), 
	TAG_NAME VARCHAR2(32)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.MP_DM IS '';
COMMENT ON COLUMN BARSUPL.MP_DM.OWNER IS '';
COMMENT ON COLUMN BARSUPL.MP_DM.TABLE_NAME IS '';
COMMENT ON COLUMN BARSUPL.MP_DM.COLUMN_NAME IS '';
COMMENT ON COLUMN BARSUPL.MP_DM.DM_NAME IS '';
COMMENT ON COLUMN BARSUPL.MP_DM.DM_COLUMN IS '';
COMMENT ON COLUMN BARSUPL.MP_DM.C_DPND IS '';
COMMENT ON COLUMN BARSUPL.MP_DM.TXT IS '';
COMMENT ON COLUMN BARSUPL.MP_DM.COLUMN_ID IS '';
COMMENT ON COLUMN BARSUPL.MP_DM.DM_F_PK IS '';
COMMENT ON COLUMN BARSUPL.MP_DM.WHR_DPND IS '';
COMMENT ON COLUMN BARSUPL.MP_DM.F_FK IS 'ознака, чи дана колонка використовується в якості FK на іншу таблицю';
COMMENT ON COLUMN BARSUPL.MP_DM.JOIN_DPND IS '';
COMMENT ON COLUMN BARSUPL.MP_DM.TAG_NAME IS 'для таблиць вертикальної структури є уточнюючою ідентифікуючою ознакою до table_name+column_name';



PROMPT *** Create  grants  MP_DM ***
grant SELECT                                                                 on MP_DM           to BARSREADER_ROLE;
grant SELECT                                                                 on MP_DM           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/MP_DM.sql =========*** End *** ====
PROMPT ===================================================================================== 
