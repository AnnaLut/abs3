

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_PAWN_S_VID.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_PAWN_S_VID ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_PAWN_S_VID'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_PAWN_S_VID'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_PAWN_S_VID'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_PAWN_S_VID ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_PAWN_S_VID 
   (	PAWNVID VARCHAR2(2), 
	VALUE VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_PAWN_S_VID ***
 exec bpa.alter_policies('CC_PAWN_S_VID');


COMMENT ON TABLE BARS.CC_PAWN_S_VID IS 'Вид кредиту';
COMMENT ON COLUMN BARS.CC_PAWN_S_VID.PAWNVID IS 'Код кредиту';
COMMENT ON COLUMN BARS.CC_PAWN_S_VID.VALUE IS 'Найменування';




PROMPT *** Create  constraint PK_CC_PAWN_S_VID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PAWN_S_VID ADD CONSTRAINT PK_CC_PAWN_S_VID PRIMARY KEY (PAWNVID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PAWN_S_VID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PAWN_S_VID MODIFY (PAWNVID CONSTRAINT CC_PAWN_S_VID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PAWN_S_VID_VALUE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PAWN_S_VID MODIFY (VALUE CONSTRAINT CC_PAWN_S_VID_VALUE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CC_PAWN_S_VID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CC_PAWN_S_VID ON BARS.CC_PAWN_S_VID (PAWNVID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_PAWN_S_VID ***
grant SELECT                                                                 on CC_PAWN_S_VID   to BARSREADER_ROLE;
grant SELECT                                                                 on CC_PAWN_S_VID   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_PAWN_S_VID   to BARS_DM;
grant SELECT                                                                 on CC_PAWN_S_VID   to RCC_DEAL;
grant SELECT                                                                 on CC_PAWN_S_VID   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_PAWN_S_VID.sql =========*** End ***
PROMPT ===================================================================================== 
