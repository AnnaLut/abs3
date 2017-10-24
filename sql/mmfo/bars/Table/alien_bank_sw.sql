

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ALIEN_BANK_SW.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ALIEN_BANK_SW ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ALIEN_BANK_SW'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ALIEN_BANK_SW'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ALIEN_BANK_SW'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ALIEN_BANK_SW ***
begin 
  execute immediate '
  CREATE TABLE BARS.ALIEN_BANK_SW 
   (	NLS VARCHAR2(35), 
	BIC VARCHAR2(11), 
	NAME VARCHAR2(140), 
	ADDRESS VARCHAR2(350), 
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




PROMPT *** ALTER_POLICIES to ALIEN_BANK_SW ***
 exec bpa.alter_policies('ALIEN_BANK_SW');


COMMENT ON TABLE BARS.ALIEN_BANK_SW IS '';
COMMENT ON COLUMN BARS.ALIEN_BANK_SW.NLS IS '';
COMMENT ON COLUMN BARS.ALIEN_BANK_SW.BIC IS '';
COMMENT ON COLUMN BARS.ALIEN_BANK_SW.NAME IS '';
COMMENT ON COLUMN BARS.ALIEN_BANK_SW.ADDRESS IS '';
COMMENT ON COLUMN BARS.ALIEN_BANK_SW.ID IS '';
COMMENT ON COLUMN BARS.ALIEN_BANK_SW.REC_ID IS '';




PROMPT *** Create  constraint PK_ALIEN_BANK_SW ***
begin   
 execute immediate '
  ALTER TABLE BARS.ALIEN_BANK_SW ADD CONSTRAINT PK_ALIEN_BANK_SW PRIMARY KEY (REC_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ALIEN_BANK_SW_RECID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ALIEN_BANK_SW MODIFY (REC_ID CONSTRAINT CC_ALIEN_BANK_SW_RECID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ALIEN_BANK_SW ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ALIEN_BANK_SW ON BARS.ALIEN_BANK_SW (REC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ALIEN_BANK_SW ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ALIEN_BANK_SW   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ALIEN_BANK_SW   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ALIEN_BANK_SW   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ALIEN_BANK_SW.sql =========*** End ***
PROMPT ===================================================================================== 
