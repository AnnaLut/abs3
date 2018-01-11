

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/AUTO_CLOSE_ACC.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to AUTO_CLOSE_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''AUTO_CLOSE_ACC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''AUTO_CLOSE_ACC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''AUTO_CLOSE_ACC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table AUTO_CLOSE_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.AUTO_CLOSE_ACC 
   (	ID NUMBER, 
	TIP CHAR(3), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to AUTO_CLOSE_ACC ***
 exec bpa.alter_policies('AUTO_CLOSE_ACC');


COMMENT ON TABLE BARS.AUTO_CLOSE_ACC IS '';
COMMENT ON COLUMN BARS.AUTO_CLOSE_ACC.ID IS '';
COMMENT ON COLUMN BARS.AUTO_CLOSE_ACC.TIP IS '';
COMMENT ON COLUMN BARS.AUTO_CLOSE_ACC.NAME IS '';




PROMPT *** Create  constraint PK_AUTOCLOSEACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.AUTO_CLOSE_ACC ADD CONSTRAINT PK_AUTOCLOSEACC PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009416 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AUTO_CLOSE_ACC MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_AUTOCLOSEACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_AUTOCLOSEACC ON BARS.AUTO_CLOSE_ACC (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  AUTO_CLOSE_ACC ***
grant SELECT                                                                 on AUTO_CLOSE_ACC  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on AUTO_CLOSE_ACC  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on AUTO_CLOSE_ACC  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on AUTO_CLOSE_ACC  to RCC_DEAL;
grant SELECT                                                                 on AUTO_CLOSE_ACC  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/AUTO_CLOSE_ACC.sql =========*** End **
PROMPT ===================================================================================== 
