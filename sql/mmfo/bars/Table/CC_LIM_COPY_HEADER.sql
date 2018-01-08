

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_LIM_COPY_HEADER.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_LIM_COPY_HEADER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_LIM_COPY_HEADER'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_LIM_COPY_HEADER'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CC_LIM_COPY_HEADER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_LIM_COPY_HEADER ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_LIM_COPY_HEADER 
   (	ID NUMBER, 
	ND NUMBER, 
	OPER_DATE DATE DEFAULT sysdate, 
	USERID NUMBER, 
	COMMENTS VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_LIM_COPY_HEADER ***
 exec bpa.alter_policies('CC_LIM_COPY_HEADER');


COMMENT ON TABLE BARS.CC_LIM_COPY_HEADER IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY_HEADER.ID IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY_HEADER.ND IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY_HEADER.OPER_DATE IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY_HEADER.USERID IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY_HEADER.COMMENTS IS '';




PROMPT *** Create  constraint SYS_C00136936 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_LIM_COPY_HEADER MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00136937 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_LIM_COPY_HEADER MODIFY (ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00136938 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_LIM_COPY_HEADER MODIFY (OPER_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00136939 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_LIM_COPY_HEADER MODIFY (USERID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CC_LIM_COPY_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_LIM_COPY_HEADER ADD CONSTRAINT PK_CC_LIM_COPY_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CC_LIM_COPY_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CC_LIM_COPY_ID ON BARS.CC_LIM_COPY_HEADER (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_LIM_COPY_HEADER ***
grant SELECT                                                                 on CC_LIM_COPY_HEADER to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on CC_LIM_COPY_HEADER to BARSREADER_ROLE;
grant SELECT                                                                 on CC_LIM_COPY_HEADER to BARSUPL;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on CC_LIM_COPY_HEADER to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_LIM_COPY_HEADER to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CC_LIM_COPY_HEADER to FOREX;
grant SELECT                                                                 on CC_LIM_COPY_HEADER to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_LIM_COPY_HEADER to WR_ALL_RIGHTS;
grant SELECT                                                                 on CC_LIM_COPY_HEADER to WR_CREDIT;
grant FLASHBACK,SELECT                                                       on CC_LIM_COPY_HEADER to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_LIM_COPY_HEADER.sql =========*** En
PROMPT ===================================================================================== 
