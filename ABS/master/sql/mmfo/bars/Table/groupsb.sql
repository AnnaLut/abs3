

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GROUPSB.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GROUPSB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GROUPSB'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''GROUPSB'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''GROUPSB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GROUPSB ***
begin 
  execute immediate '
  CREATE TABLE BARS.GROUPSB 
   (	KODG NUMBER(*,0), 
	NAMG VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GROUPSB ***
 exec bpa.alter_policies('GROUPSB');


COMMENT ON TABLE BARS.GROUPSB IS 'Справочник групп банков';
COMMENT ON COLUMN BARS.GROUPSB.KODG IS 'Код группы';
COMMENT ON COLUMN BARS.GROUPSB.NAMG IS 'Наименование группы (головного банка)';




PROMPT *** Create  constraint XPK_GRUPB ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPSB ADD CONSTRAINT XPK_GRUPB PRIMARY KEY (KODG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005773 ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPSB MODIFY (KODG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_GRUPB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_GRUPB ON BARS.GROUPSB (KODG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GROUPSB ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on GROUPSB         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GROUPSB         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on GROUPSB         to GROUPSB;
grant DELETE,INSERT,SELECT,UPDATE                                            on GROUPSB         to SEP_ROLE;
grant SELECT                                                                 on GROUPSB         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on GROUPSB         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on GROUPSB         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GROUPSB.sql =========*** End *** =====
PROMPT ===================================================================================== 
