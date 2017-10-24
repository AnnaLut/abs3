

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRIOCOM_VOB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PRIOCOM_VOB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PRIOCOM_VOB'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PRIOCOM_VOB'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PRIOCOM_VOB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PRIOCOM_VOB ***
begin 
  execute immediate '
  CREATE TABLE BARS.PRIOCOM_VOB 
   (	PRIOCOM_VOB_CODE NUMBER(*,0), 
	PRIOCOM_VOB_NAME VARCHAR2(35), 
	BARS_VOB_CODE NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PRIOCOM_VOB ***
 exec bpa.alter_policies('PRIOCOM_VOB');


COMMENT ON TABLE BARS.PRIOCOM_VOB IS '';
COMMENT ON COLUMN BARS.PRIOCOM_VOB.PRIOCOM_VOB_CODE IS '';
COMMENT ON COLUMN BARS.PRIOCOM_VOB.PRIOCOM_VOB_NAME IS '';
COMMENT ON COLUMN BARS.PRIOCOM_VOB.BARS_VOB_CODE IS '';




PROMPT *** Create  constraint XPK_PRIOCOM_VOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_VOB ADD CONSTRAINT XPK_PRIOCOM_VOB PRIMARY KEY (PRIOCOM_VOB_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PRIOCOM_VOB_VOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_VOB ADD CONSTRAINT FK_PRIOCOM_VOB_VOB FOREIGN KEY (BARS_VOB_CODE)
	  REFERENCES BARS.VOB (VOB) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRIOCOM_VOB_NAME ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_VOB MODIFY (PRIOCOM_VOB_NAME CONSTRAINT CC_PRIOCOM_VOB_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRIOCOM_VOB_BARS_VOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_VOB MODIFY (BARS_VOB_CODE CONSTRAINT CC_PRIOCOM_VOB_BARS_VOB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_PRIOCOM_VOB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_PRIOCOM_VOB ON BARS.PRIOCOM_VOB (PRIOCOM_VOB_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PRIOCOM_VOB ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PRIOCOM_VOB     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PRIOCOM_VOB     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on PRIOCOM_VOB     to PRIOCOM_VOB;
grant FLASHBACK,SELECT                                                       on PRIOCOM_VOB     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PRIOCOM_VOB.sql =========*** End *** =
PROMPT ===================================================================================== 
