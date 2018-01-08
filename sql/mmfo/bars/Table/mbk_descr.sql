

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MBK_DESCR.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MBK_DESCR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MBK_DESCR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MBK_DESCR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MBK_DESCR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MBK_DESCR ***
begin 
  execute immediate '
  CREATE TABLE BARS.MBK_DESCR 
   (	ID VARCHAR2(10), 
	DESCR VARCHAR2(70), 
	SQLVAL VARCHAR2(2000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MBK_DESCR ***
 exec bpa.alter_policies('MBK_DESCR');


COMMENT ON TABLE BARS.MBK_DESCR IS '';
COMMENT ON COLUMN BARS.MBK_DESCR.ID IS '';
COMMENT ON COLUMN BARS.MBK_DESCR.DESCR IS '';
COMMENT ON COLUMN BARS.MBK_DESCR.SQLVAL IS '';




PROMPT *** Create  constraint PK_MBK_DESCR ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBK_DESCR ADD CONSTRAINT PK_MBK_DESCR PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_MBK_DESCR_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBK_DESCR MODIFY (ID CONSTRAINT NK_MBK_DESCR_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_MBK_DESCR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_MBK_DESCR ON BARS.MBK_DESCR (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MBK_DESCR ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MBK_DESCR       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MBK_DESCR       to BARS_DM;
grant SELECT                                                                 on MBK_DESCR       to FOREX;
grant DELETE,INSERT,SELECT,UPDATE                                            on MBK_DESCR       to MBK_DESCR;
grant FLASHBACK,SELECT                                                       on MBK_DESCR       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MBK_DESCR.sql =========*** End *** ===
PROMPT ===================================================================================== 
