

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MBD_K_R.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MBD_K_R ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MBD_K_R'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MBD_K_R'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MBD_K_R'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MBD_K_R ***
begin 
  execute immediate '
  CREATE TABLE BARS.MBD_K_R 
   (	ND NUMBER(38,0), 
	REF NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MBD_K_R ***
 exec bpa.alter_policies('MBD_K_R');


COMMENT ON TABLE BARS.MBD_K_R IS '';
COMMENT ON COLUMN BARS.MBD_K_R.ND IS '';
COMMENT ON COLUMN BARS.MBD_K_R.REF IS '';




PROMPT *** Create  constraint R_MB_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBD_K_R ADD CONSTRAINT R_MB_ND FOREIGN KEY (ND)
	  REFERENCES BARS.CC_DEAL (ND) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005097 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBD_K_R MODIFY (ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005098 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBD_K_R MODIFY (REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_MB_R ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBD_K_R ADD CONSTRAINT XPK_MB_R PRIMARY KEY (ND, REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_MB_R ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_MB_R ON BARS.MBD_K_R (ND, REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MBD_K_R ***
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on MBD_K_R         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MBD_K_R         to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on MBD_K_R         to FOREX;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MBD_K_R.sql =========*** End *** =====
PROMPT ===================================================================================== 
