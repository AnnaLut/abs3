

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_PAWN_23.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_PAWN_23 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_PAWN_23 ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_PAWN_23 
   (	GRP23 VARCHAR2(15), 
	KL NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_PAWN_23 ***
 exec bpa.alter_policies('CC_PAWN_23');


COMMENT ON TABLE BARS.CC_PAWN_23 IS '';
COMMENT ON COLUMN BARS.CC_PAWN_23.GRP23 IS '';
COMMENT ON COLUMN BARS.CC_PAWN_23.KL IS '';




PROMPT *** Create  constraint PK_CC_PAWN_23 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PAWN_23 ADD CONSTRAINT PK_CC_PAWN_23 PRIMARY KEY (GRP23)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CC_PAWN_23 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CC_PAWN_23 ON BARS.CC_PAWN_23 (GRP23) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_PAWN_23 ***
grant SELECT                                                                 on CC_PAWN_23      to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_PAWN_23      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_PAWN_23      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_PAWN_23      to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_PAWN_23      to START1;
grant SELECT                                                                 on CC_PAWN_23      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_PAWN_23.sql =========*** End *** ==
PROMPT ===================================================================================== 
