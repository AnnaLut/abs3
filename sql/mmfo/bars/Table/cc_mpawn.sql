

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_MPAWN.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_MPAWN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_MPAWN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_MPAWN'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_MPAWN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_MPAWN ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_MPAWN 
   (	MPAWN NUMBER(*,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_MPAWN ***
 exec bpa.alter_policies('CC_MPAWN');


COMMENT ON TABLE BARS.CC_MPAWN IS 'Местонахождение залога';
COMMENT ON COLUMN BARS.CC_MPAWN.MPAWN IS 'Код';
COMMENT ON COLUMN BARS.CC_MPAWN.NAME IS 'Местонахождение залога';




PROMPT *** Create  constraint XPK_CC_MPAWN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_MPAWN ADD CONSTRAINT XPK_CC_MPAWN PRIMARY KEY (MPAWN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_MPAWN_MPAWN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_MPAWN MODIFY (MPAWN CONSTRAINT NK_CC_MPAWN_MPAWN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CC_MPAWN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CC_MPAWN ON BARS.CC_MPAWN (MPAWN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_MPAWN ***
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CC_MPAWN        to BARS009;
grant SELECT                                                                 on CC_MPAWN        to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_MPAWN        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_MPAWN        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_MPAWN        to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_MPAWN        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CC_MPAWN        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_MPAWN.sql =========*** End *** ====
PROMPT ===================================================================================== 
