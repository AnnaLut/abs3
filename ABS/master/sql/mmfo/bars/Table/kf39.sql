

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KF39.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KF39 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KF39'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KF39'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KF39'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KF39 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KF39 
   (	KOD CHAR(3), 
	NAIM VARCHAR2(40), 
	DK NUMBER(1,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KF39 ***
 exec bpa.alter_policies('KF39');


COMMENT ON TABLE BARS.KF39 IS 'Классификатор показателей для файла НБУ #39';
COMMENT ON COLUMN BARS.KF39.KOD IS 'Код показателя';
COMMENT ON COLUMN BARS.KF39.NAIM IS 'Название показателя';
COMMENT ON COLUMN BARS.KF39.DK IS 'Признак (1-покупка, 2-продажа, 0-другое)';




PROMPT *** Create  constraint CC_KF39_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF39 ADD CONSTRAINT CC_KF39_DK CHECK (dk in (0, 1, 2)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_KF39 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF39 ADD CONSTRAINT PK_KF39 PRIMARY KEY (KOD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KF39_KOD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF39 MODIFY (KOD CONSTRAINT CC_KF39_KOD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KF39_NAIM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF39 MODIFY (NAIM CONSTRAINT CC_KF39_NAIM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KF39_DK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF39 MODIFY (DK CONSTRAINT CC_KF39_DK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KF39 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KF39 ON BARS.KF39 (KOD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KF39 ***
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on KF39            to ABS_ADMIN;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on KF39            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KF39            to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KF39            to KF39;
grant SELECT                                                                 on KF39            to PYOD001;
grant SELECT                                                                 on KF39            to RPBN002;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KF39            to WR_ALL_RIGHTS;
grant SELECT                                                                 on KF39            to ZAY;



PROMPT *** Create SYNONYM  to KF39 ***

  CREATE OR REPLACE PUBLIC SYNONYM KF39 FOR BARS.KF39;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KF39.sql =========*** End *** ========
PROMPT ===================================================================================== 
