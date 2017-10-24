

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ALIEN_SW.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ALIEN_SW ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ALIEN_SW'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ALIEN_SW'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ALIEN_SW'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ALIEN_SW ***
begin 
  execute immediate '
  CREATE TABLE BARS.ALIEN_SW 
   (	NLS VARCHAR2(34), 
	NAME VARCHAR2(70), 
	ADDRESS VARCHAR2(105), 
	ID NUMBER(38,0), 
	REC_ID NUMBER(38,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ALIEN_SW ***
 exec bpa.alter_policies('ALIEN_SW');


COMMENT ON TABLE BARS.ALIEN_SW IS '';
COMMENT ON COLUMN BARS.ALIEN_SW.NLS IS '';
COMMENT ON COLUMN BARS.ALIEN_SW.NAME IS '';
COMMENT ON COLUMN BARS.ALIEN_SW.ADDRESS IS '';
COMMENT ON COLUMN BARS.ALIEN_SW.ID IS '';
COMMENT ON COLUMN BARS.ALIEN_SW.REC_ID IS '';




PROMPT *** Create  constraint PK_ALIEN_SW ***
begin   
 execute immediate '
  ALTER TABLE BARS.ALIEN_SW ADD CONSTRAINT PK_ALIEN_SW PRIMARY KEY (REC_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ALIEN_SW_RECID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ALIEN_SW MODIFY (REC_ID CONSTRAINT CC_ALIEN_SW_RECID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ALIEN_SW ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ALIEN_SW ON BARS.ALIEN_SW (REC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ALIEN_SW ***
grant FLASHBACK,SELECT                                                       on ALIEN_SW        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ALIEN_SW        to BARS_DM;
grant FLASHBACK,SELECT                                                       on ALIEN_SW        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ALIEN_SW.sql =========*** End *** ====
PROMPT ===================================================================================== 
