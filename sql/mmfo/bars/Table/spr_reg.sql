

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SPR_REG.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SPR_REG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SPR_REG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SPR_REG'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SPR_REG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SPR_REG ***
begin 
  execute immediate '
  CREATE TABLE BARS.SPR_REG 
   (	C_REG NUMBER(2,0), 
	C_DST NUMBER(2,0), 
	T_STI NUMBER(2,0), 
	NAME_STI VARCHAR2(70), 
	ZIP_CODE NUMBER(6,0), 
	ADDRESS VARCHAR2(70), 
	INUSE NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SPR_REG ***
 exec bpa.alter_policies('SPR_REG');


COMMENT ON TABLE BARS.SPR_REG IS 'Справочник налоговых инспекций';
COMMENT ON COLUMN BARS.SPR_REG.C_REG IS 'Код обл';
COMMENT ON COLUMN BARS.SPR_REG.C_DST IS 'Код районной налоговой инспекции';
COMMENT ON COLUMN BARS.SPR_REG.T_STI IS 'Тип налог.инспекции';
COMMENT ON COLUMN BARS.SPR_REG.NAME_STI IS 'Наименование налог.инспекции';
COMMENT ON COLUMN BARS.SPR_REG.ZIP_CODE IS 'Индекс инспекции';
COMMENT ON COLUMN BARS.SPR_REG.ADDRESS IS 'Адрес инспекции';
COMMENT ON COLUMN BARS.SPR_REG.INUSE IS '';




PROMPT *** Create  constraint CC_SPRREG_TSTI ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPR_REG ADD CONSTRAINT CC_SPRREG_TSTI CHECK (t_sti between 0 and 99) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SPRREG ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPR_REG ADD CONSTRAINT PK_SPRREG PRIMARY KEY (C_REG, C_DST)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPRREG_INUSE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPR_REG ADD CONSTRAINT CC_SPRREG_INUSE CHECK (inuse in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPRREG_CREG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPR_REG MODIFY (C_REG CONSTRAINT CC_SPRREG_CREG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPRREG_CDST_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPR_REG MODIFY (C_DST CONSTRAINT CC_SPRREG_CDST_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPRREG_INUSE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPR_REG MODIFY (INUSE CONSTRAINT CC_SPRREG_INUSE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SPRREG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SPRREG ON BARS.SPR_REG (C_REG, C_DST) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SPR_REG ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SPR_REG         to ABS_ADMIN;
grant SELECT                                                                 on SPR_REG         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SPR_REG         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SPR_REG         to BARS_DM;
grant SELECT                                                                 on SPR_REG         to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPR_REG         to SPR_REG;
grant SELECT                                                                 on SPR_REG         to START1;
grant SELECT                                                                 on SPR_REG         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SPR_REG         to WR_ALL_RIGHTS;
grant SELECT                                                                 on SPR_REG         to WR_CUSTREG;
grant FLASHBACK,SELECT                                                       on SPR_REG         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SPR_REG.sql =========*** End *** =====
PROMPT ===================================================================================== 
