

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MVO_SABO_NAZN.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MVO_SABO_NAZN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MVO_SABO_NAZN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MVO_SABO_NAZN'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MVO_SABO_NAZN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MVO_SABO_NAZN ***
begin 
  execute immediate '
  CREATE TABLE BARS.MVO_SABO_NAZN 
   (	ID NUMBER(*,0), 
	NLSD VARCHAR2(14), 
	NLSK VARCHAR2(14), 
	NAZN VARCHAR2(160), 
	VOB NUMBER, 
	TT CHAR(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MVO_SABO_NAZN ***
 exec bpa.alter_policies('MVO_SABO_NAZN');


COMMENT ON TABLE BARS.MVO_SABO_NAZN IS '';
COMMENT ON COLUMN BARS.MVO_SABO_NAZN.ID IS '';
COMMENT ON COLUMN BARS.MVO_SABO_NAZN.NLSD IS '';
COMMENT ON COLUMN BARS.MVO_SABO_NAZN.NLSK IS '';
COMMENT ON COLUMN BARS.MVO_SABO_NAZN.NAZN IS '';
COMMENT ON COLUMN BARS.MVO_SABO_NAZN.VOB IS '';
COMMENT ON COLUMN BARS.MVO_SABO_NAZN.TT IS '';




PROMPT *** Create  constraint XPK_MVO_SABO_NAZN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MVO_SABO_NAZN ADD CONSTRAINT XPK_MVO_SABO_NAZN PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_MVO_SABO_NAZN_VOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.MVO_SABO_NAZN ADD CONSTRAINT FK_MVO_SABO_NAZN_VOB FOREIGN KEY (VOB)
	  REFERENCES BARS.VOB (VOB) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_MVO_SABO_NAZN_TT ***
begin   
 execute immediate '
  ALTER TABLE BARS.MVO_SABO_NAZN ADD CONSTRAINT FK_MVO_SABO_NAZN_TT FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_MVO_SABO_NAZN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_MVO_SABO_NAZN ON BARS.MVO_SABO_NAZN (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MVO_SABO_NAZN ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MVO_SABO_NAZN   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MVO_SABO_NAZN   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on MVO_SABO_NAZN   to MVO;
grant FLASHBACK,SELECT                                                       on MVO_SABO_NAZN   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MVO_SABO_NAZN.sql =========*** End ***
PROMPT ===================================================================================== 
