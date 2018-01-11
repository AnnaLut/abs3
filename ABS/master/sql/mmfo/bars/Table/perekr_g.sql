

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PEREKR_G.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PEREKR_G ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PEREKR_G'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PEREKR_G'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''PEREKR_G'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PEREKR_G ***
begin 
  execute immediate '
  CREATE TABLE BARS.PEREKR_G 
   (	IDG NUMBER(38,0), 
	NAME VARCHAR2(100), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PEREKR_G ***
 exec bpa.alter_policies('PEREKR_G');


COMMENT ON TABLE BARS.PEREKR_G IS 'Перекрытия. Группы перекрытий';
COMMENT ON COLUMN BARS.PEREKR_G.IDG IS 'Код группы';
COMMENT ON COLUMN BARS.PEREKR_G.NAME IS 'Наименование группы';
COMMENT ON COLUMN BARS.PEREKR_G.KF IS '';




PROMPT *** Create  constraint SYS_C008685 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_G MODIFY (IDG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PEREKRG_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_G MODIFY (NAME CONSTRAINT CC_PEREKRG_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PEREKRG_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_G MODIFY (KF CONSTRAINT CC_PEREKRG_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PEREKRG ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_G ADD CONSTRAINT PK_PEREKRG PRIMARY KEY (KF, IDG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PEREKRG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PEREKRG ON BARS.PEREKR_G (KF, IDG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PEREKR_G ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PEREKR_G        to ABS_ADMIN;
grant SELECT                                                                 on PEREKR_G        to BARS015;
grant SELECT                                                                 on PEREKR_G        to BARSREADER_ROLE;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on PEREKR_G        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PEREKR_G        to BARS_DM;
grant SELECT                                                                 on PEREKR_G        to DPT_ADMIN;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on PEREKR_G        to REF0000;
grant SELECT                                                                 on PEREKR_G        to R_KP;
grant SELECT                                                                 on PEREKR_G        to START1;
grant SELECT                                                                 on PEREKR_G        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PEREKR_G        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on PEREKR_G        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PEREKR_G.sql =========*** End *** ====
PROMPT ===================================================================================== 
