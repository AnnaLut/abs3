

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_PAWN_S_PAWN.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_PAWN_S_PAWN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_PAWN_S_PAWN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_PAWN_S_PAWN'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_PAWN_S_PAWN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_PAWN_S_PAWN ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_PAWN_S_PAWN 
   (	PAWN NUMBER, 
	PAWNPAWN NUMBER, 
	VALUE VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_PAWN_S_PAWN ***
 exec bpa.alter_policies('CC_PAWN_S_PAWN');


COMMENT ON TABLE BARS.CC_PAWN_S_PAWN IS 'Розширенний код предмету застави';
COMMENT ON COLUMN BARS.CC_PAWN_S_PAWN.PAWN IS '';
COMMENT ON COLUMN BARS.CC_PAWN_S_PAWN.PAWNPAWN IS 'Код предмету застави';
COMMENT ON COLUMN BARS.CC_PAWN_S_PAWN.VALUE IS 'Найменування';




PROMPT *** Create  constraint PK_CC_PAWN_S_PAWN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PAWN_S_PAWN ADD CONSTRAINT PK_CC_PAWN_S_PAWN PRIMARY KEY (PAWN, PAWNPAWN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CC_PAWN_S_PAWN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PAWN_S_PAWN ADD CONSTRAINT FK_CC_PAWN_S_PAWN FOREIGN KEY (PAWN)
	  REFERENCES BARS.CC_PAWN (PAWN) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PAWN_S_PAWN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PAWN_S_PAWN MODIFY (PAWN CONSTRAINT CC_PAWN_S_PAWN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PAWN_S_PAWN_NN1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PAWN_S_PAWN MODIFY (PAWNPAWN CONSTRAINT CC_PAWN_S_PAWN_NN1 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PAWN_S_PAWN_VALUE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PAWN_S_PAWN MODIFY (VALUE CONSTRAINT CC_PAWN_S_PAWN_VALUE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CC_PAWN_S_PAWN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CC_PAWN_S_PAWN ON BARS.CC_PAWN_S_PAWN (PAWN, PAWNPAWN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_PAWN_S_PAWN ***
grant SELECT                                                                 on CC_PAWN_S_PAWN  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_PAWN_S_PAWN  to BARS_DM;
grant SELECT                                                                 on CC_PAWN_S_PAWN  to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_PAWN_S_PAWN.sql =========*** End **
PROMPT ===================================================================================== 
