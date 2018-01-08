

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PEREKR_DOG.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PEREKR_DOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PEREKR_DOG'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PEREKR_DOG'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''PEREKR_DOG'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PEREKR_DOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.PEREKR_DOG 
   (	IDG NUMBER(38,0), 
	DOG VARCHAR2(100), 
	PRIM VARCHAR2(70), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PEREKR_DOG ***
 exec bpa.alter_policies('PEREKR_DOG');


COMMENT ON TABLE BARS.PEREKR_DOG IS 'Перекрытия. Номера договоров';
COMMENT ON COLUMN BARS.PEREKR_DOG.IDG IS 'Код группы';
COMMENT ON COLUMN BARS.PEREKR_DOG.DOG IS 'Номер договора';
COMMENT ON COLUMN BARS.PEREKR_DOG.PRIM IS '';
COMMENT ON COLUMN BARS.PEREKR_DOG.KF IS '';




PROMPT *** Create  constraint PK_PEREKR_DOG ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_DOG ADD CONSTRAINT PK_PEREKR_DOG PRIMARY KEY (IDG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005536 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_DOG MODIFY (IDG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PEREKRG_DOG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_DOG MODIFY (DOG CONSTRAINT CC_PEREKRG_DOG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PEREKR_DOG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PEREKR_DOG ON BARS.PEREKR_DOG (IDG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PEREKR_DOG ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PEREKR_DOG      to ABS_ADMIN;
grant SELECT                                                                 on PEREKR_DOG      to BARS015;
grant SELECT                                                                 on PEREKR_DOG      to BARSREADER_ROLE;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on PEREKR_DOG      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PEREKR_DOG      to BARS_DM;
grant SELECT                                                                 on PEREKR_DOG      to DPT_ADMIN;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on PEREKR_DOG      to REF0000;
grant SELECT                                                                 on PEREKR_DOG      to R_KP;
grant SELECT                                                                 on PEREKR_DOG      to START1;
grant SELECT                                                                 on PEREKR_DOG      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PEREKR_DOG      to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on PEREKR_DOG      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PEREKR_DOG.sql =========*** End *** ==
PROMPT ===================================================================================== 
