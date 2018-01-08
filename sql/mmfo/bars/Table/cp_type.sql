

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_TYPE.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_TYPE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CP_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_TYPE 
   (	IDT VARCHAR2(4), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_TYPE ***
 exec bpa.alter_policies('CP_TYPE');


COMMENT ON TABLE BARS.CP_TYPE IS 'Види ЦП';
COMMENT ON COLUMN BARS.CP_TYPE.IDT IS 'Код виду ЦП';
COMMENT ON COLUMN BARS.CP_TYPE.NAME IS 'Назва виду ЦП';




PROMPT *** Create  constraint XPK_CP_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_TYPE ADD CONSTRAINT XPK_CP_TYPE PRIMARY KEY (IDT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007609 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_TYPE MODIFY (IDT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_TYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_TYPE ON BARS.CP_TYPE (IDT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_TYPE ***
grant SELECT                                                                 on CP_TYPE         to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CP_TYPE         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_TYPE         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_TYPE         to CP_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_TYPE         to START1;
grant SELECT                                                                 on CP_TYPE         to UPLD;
grant FLASHBACK,SELECT                                                       on CP_TYPE         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_TYPE.sql =========*** End *** =====
PROMPT ===================================================================================== 
