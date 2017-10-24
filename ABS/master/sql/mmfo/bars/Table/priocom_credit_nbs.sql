

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRIOCOM_CREDIT_NBS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PRIOCOM_CREDIT_NBS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PRIOCOM_CREDIT_NBS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PRIOCOM_CREDIT_NBS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PRIOCOM_CREDIT_NBS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PRIOCOM_CREDIT_NBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.PRIOCOM_CREDIT_NBS 
   (	NBS CHAR(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PRIOCOM_CREDIT_NBS ***
 exec bpa.alter_policies('PRIOCOM_CREDIT_NBS');


COMMENT ON TABLE BARS.PRIOCOM_CREDIT_NBS IS '';
COMMENT ON COLUMN BARS.PRIOCOM_CREDIT_NBS.NBS IS '';




PROMPT *** Create  constraint FK_PRIOCOM_CREDIT_NBS_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_CREDIT_NBS ADD CONSTRAINT FK_PRIOCOM_CREDIT_NBS_PS FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_PRIOCOM_CREDIT_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_CREDIT_NBS ADD CONSTRAINT XPK_PRIOCOM_CREDIT_NBS PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_PRIOCOM_CREDIT_NBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_PRIOCOM_CREDIT_NBS ON BARS.PRIOCOM_CREDIT_NBS (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PRIOCOM_CREDIT_NBS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PRIOCOM_CREDIT_NBS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PRIOCOM_CREDIT_NBS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on PRIOCOM_CREDIT_NBS to PRIOCOM_CREDIT_NBS;
grant FLASHBACK,SELECT                                                       on PRIOCOM_CREDIT_NBS to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PRIOCOM_CREDIT_NBS.sql =========*** En
PROMPT ===================================================================================== 
