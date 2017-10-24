

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SREZ_ID_NBS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SREZ_ID_NBS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SREZ_ID_NBS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SREZ_ID_NBS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SREZ_ID_NBS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SREZ_ID_NBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.SREZ_ID_NBS 
   (	ID NUMBER(*,0), 
	NBS CHAR(4), 
	METODIKA NUMBER, 
	FONDID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SREZ_ID_NBS ***
 exec bpa.alter_policies('SREZ_ID_NBS');


COMMENT ON TABLE BARS.SREZ_ID_NBS IS '';
COMMENT ON COLUMN BARS.SREZ_ID_NBS.ID IS '';
COMMENT ON COLUMN BARS.SREZ_ID_NBS.NBS IS '';
COMMENT ON COLUMN BARS.SREZ_ID_NBS.METODIKA IS '';
COMMENT ON COLUMN BARS.SREZ_ID_NBS.FONDID IS '';




PROMPT *** Create  constraint FK_SREZ_ID_NBS_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SREZ_ID_NBS ADD CONSTRAINT FK_SREZ_ID_NBS_NBS FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_SREZ_ID_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SREZ_ID_NBS ADD CONSTRAINT XPK_SREZ_ID_NBS PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SREZ_ID_NBS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.SREZ_ID_NBS ADD CONSTRAINT FK_SREZ_ID_NBS_ID FOREIGN KEY (ID)
	  REFERENCES BARS.SREZ_ID (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_SREZ_ID_NBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_SREZ_ID_NBS ON BARS.SREZ_ID_NBS (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SREZ_ID_NBS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SREZ_ID_NBS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SREZ_ID_NBS     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SREZ_ID_NBS     to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SREZ_ID_NBS     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SREZ_ID_NBS     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SREZ_ID_NBS.sql =========*** End *** =
PROMPT ===================================================================================== 
