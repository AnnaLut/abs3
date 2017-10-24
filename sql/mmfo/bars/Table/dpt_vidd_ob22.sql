

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_OB22.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_VIDD_OB22 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_VIDD_OB22'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_VIDD_OB22'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_VIDD_OB22'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_VIDD_OB22 ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_VIDD_OB22 
   (	VIDD NUMBER, 
	OB22 CHAR(2), 
	OB22N CHAR(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_VIDD_OB22 ***
 exec bpa.alter_policies('DPT_VIDD_OB22');


COMMENT ON TABLE BARS.DPT_VIDD_OB22 IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_OB22.VIDD IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_OB22.OB22 IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_OB22.OB22N IS '';




PROMPT *** Create  constraint PK_DPT_VIDD_OB22 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_OB22 ADD CONSTRAINT PK_DPT_VIDD_OB22 PRIMARY KEY (VIDD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPT_VIDD_OB22 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_OB22 ADD CONSTRAINT FK_DPT_VIDD_OB22 FOREIGN KEY (VIDD)
	  REFERENCES BARS.DPT_VIDD (VIDD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005439 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_OB22 MODIFY (VIDD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005440 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_OB22 MODIFY (OB22 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005441 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_OB22 MODIFY (OB22N NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPT_VIDD_OB22 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPT_VIDD_OB22 ON BARS.DPT_VIDD_OB22 (VIDD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_VIDD_OB22 ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_VIDD_OB22   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_VIDD_OB22   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_VIDD_OB22   to VKLAD;
grant FLASHBACK,SELECT                                                       on DPT_VIDD_OB22   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_OB22.sql =========*** End ***
PROMPT ===================================================================================== 
