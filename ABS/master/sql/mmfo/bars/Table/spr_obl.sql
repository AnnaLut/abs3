

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SPR_OBL.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SPR_OBL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SPR_OBL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SPR_OBL'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SPR_OBL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SPR_OBL ***
begin 
  execute immediate '
  CREATE TABLE BARS.SPR_OBL 
   (	C_REG NUMBER(2,0), 
	NAME_REG VARCHAR2(35), 
	KOD_REG CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SPR_OBL ***
 exec bpa.alter_policies('SPR_OBL');


COMMENT ON TABLE BARS.SPR_OBL IS 'Области Украины';
COMMENT ON COLUMN BARS.SPR_OBL.C_REG IS 'Код области';
COMMENT ON COLUMN BARS.SPR_OBL.NAME_REG IS 'Название области';
COMMENT ON COLUMN BARS.SPR_OBL.KOD_REG IS 'Символ области';




PROMPT *** Create  constraint PK_SPROBL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPR_OBL ADD CONSTRAINT PK_SPROBL PRIMARY KEY (C_REG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPROBL_CREG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPR_OBL MODIFY (C_REG CONSTRAINT CC_SPROBL_CREG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPROBL_NAMEREG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPR_OBL MODIFY (NAME_REG CONSTRAINT CC_SPROBL_NAMEREG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SPROBL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SPROBL ON BARS.SPR_OBL (C_REG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SPR_OBL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SPR_OBL         to ABS_ADMIN;
grant SELECT                                                                 on SPR_OBL         to BARSREADER_ROLE;
grant SELECT                                                                 on SPR_OBL         to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SPR_OBL         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SPR_OBL         to BARS_DM;
grant SELECT                                                                 on SPR_OBL         to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPR_OBL         to SPR_OBL;
grant SELECT                                                                 on SPR_OBL         to START1;
grant SELECT                                                                 on SPR_OBL         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SPR_OBL         to WR_ALL_RIGHTS;
grant SELECT                                                                 on SPR_OBL         to WR_CUSTREG;
grant FLASHBACK,SELECT                                                       on SPR_OBL         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SPR_OBL.sql =========*** End *** =====
PROMPT ===================================================================================== 
