

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CLOSE_MFO.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CLOSE_MFO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CLOSE_MFO'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CLOSE_MFO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CLOSE_MFO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CLOSE_MFO ***
begin 
  execute immediate '
  CREATE TABLE BARS.CLOSE_MFO 
   (	DATA_CLOS VARCHAR2(10), 
	TIME_CLOS VARCHAR2(5), 
	MFO VARCHAR2(12), 
	MFO_NAME VARCHAR2(38), 
	RU_NAME VARCHAR2(38)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CLOSE_MFO ***
 exec bpa.alter_policies('CLOSE_MFO');


COMMENT ON TABLE BARS.CLOSE_MFO IS '';
COMMENT ON COLUMN BARS.CLOSE_MFO.DATA_CLOS IS '';
COMMENT ON COLUMN BARS.CLOSE_MFO.TIME_CLOS IS '';
COMMENT ON COLUMN BARS.CLOSE_MFO.MFO IS '';
COMMENT ON COLUMN BARS.CLOSE_MFO.MFO_NAME IS '';
COMMENT ON COLUMN BARS.CLOSE_MFO.RU_NAME IS '';




PROMPT *** Create  constraint CLOSE_MFO_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLOSE_MFO ADD CONSTRAINT CLOSE_MFO_PK PRIMARY KEY (MFO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index CLOSE_MFO_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.CLOSE_MFO_PK ON BARS.CLOSE_MFO (MFO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CLOSE_MFO ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CLOSE_MFO       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CLOSE_MFO       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CLOSE_MFO       to START1;
grant FLASHBACK,SELECT                                                       on CLOSE_MFO       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CLOSE_MFO.sql =========*** End *** ===
PROMPT ===================================================================================== 
