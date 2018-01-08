

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_PF.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_PF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_PF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_PF'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CP_PF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_PF ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_PF 
   (	PF NUMBER, 
	NAME VARCHAR2(70), 
	NO_A NUMBER(*,0), 
	NO_P NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_PF ***
 exec bpa.alter_policies('CP_PF');


COMMENT ON TABLE BARS.CP_PF IS 'Портфелі ЦП';
COMMENT ON COLUMN BARS.CP_PF.PF IS 'Код портфеля';
COMMENT ON COLUMN BARS.CP_PF.NAME IS 'Назва портфеля';
COMMENT ON COLUMN BARS.CP_PF.NO_A IS 'Ознака амортизац_ї портфеля 1/0 ні/так';
COMMENT ON COLUMN BARS.CP_PF.NO_P IS 'Ознака переоц_нювання портфеля 1/0 ні/так';




PROMPT *** Create  constraint SYS_C005843 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_PF MODIFY (PF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_CP_PF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_PF ADD CONSTRAINT XPK_CP_PF PRIMARY KEY (PF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_PF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_PF ON BARS.CP_PF (PF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_PF ***
grant SELECT                                                                 on CP_PF           to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CP_PF           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_PF           to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_PF           to CP_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_PF           to START1;
grant SELECT                                                                 on CP_PF           to UPLD;
grant FLASHBACK,SELECT                                                       on CP_PF           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_PF.sql =========*** End *** =======
PROMPT ===================================================================================== 
