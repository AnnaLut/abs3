

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/T902_ACC.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to T902_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''T902_ACC'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''T902_ACC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''T902_ACC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table T902_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.T902_ACC 
   (	BLK NUMBER(38,0), 
	DK NUMBER(1,0), 
	KV NUMBER(3,0), 
	NLS VARCHAR2(15), 
	TT VARCHAR2(3) DEFAULT null, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to T902_ACC ***
 exec bpa.alter_policies('T902_ACC');


COMMENT ON TABLE BARS.T902_ACC IS 'Список счетов ДО ВЫЯСНЕНИЯ для зачисления по коду бизнес-правила';
COMMENT ON COLUMN BARS.T902_ACC.BLK IS 'Код бизнес правила';
COMMENT ON COLUMN BARS.T902_ACC.DK IS '0-Деб  1-Кред';
COMMENT ON COLUMN BARS.T902_ACC.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.T902_ACC.NLS IS 'Счет-транзит для зачисления';
COMMENT ON COLUMN BARS.T902_ACC.TT IS 'Код дочерней операции для зачисления';
COMMENT ON COLUMN BARS.T902_ACC.KF IS '';




PROMPT *** Create  constraint PK_T902ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.T902_ACC ADD CONSTRAINT PK_T902ACC PRIMARY KEY (KF, BLK, DK, KV, NLS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_T902ACC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.T902_ACC MODIFY (KF CONSTRAINT CC_T902ACC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_T902_ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_T902_ACC ON BARS.T902_ACC (BLK, DK, KV, NLS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_T902ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_T902ACC ON BARS.T902_ACC (KF, BLK, DK, KV, NLS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  T902_ACC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on T902_ACC        to BARS014;
grant SELECT                                                                 on T902_ACC        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on T902_ACC        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on T902_ACC        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on T902_ACC        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on T902_ACC        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/T902_ACC.sql =========*** End *** ====
PROMPT ===================================================================================== 
