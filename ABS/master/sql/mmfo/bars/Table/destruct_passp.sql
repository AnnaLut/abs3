

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DESTRUCT_PASSP.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DESTRUCT_PASSP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DESTRUCT_PASSP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DESTRUCT_PASSP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DESTRUCT_PASSP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DESTRUCT_PASSP ***
begin 
  execute immediate '
  CREATE TABLE BARS.DESTRUCT_PASSP 
   (	ID NUMBER(*,0), 
	SER VARCHAR2(10), 
	NUM VARCHAR2(20)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYNI ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DESTRUCT_PASSP ***
 exec bpa.alter_policies('DESTRUCT_PASSP');


COMMENT ON TABLE BARS.DESTRUCT_PASSP IS 'Перелік паспортів, які підлягають знищенню';
COMMENT ON COLUMN BARS.DESTRUCT_PASSP.ID IS 'ID';
COMMENT ON COLUMN BARS.DESTRUCT_PASSP.SER IS 'Серія';
COMMENT ON COLUMN BARS.DESTRUCT_PASSP.NUM IS 'Номер';




PROMPT *** Create  constraint PK_DESTRUCT_PASSP ***
begin   
 execute immediate '
  ALTER TABLE BARS.DESTRUCT_PASSP ADD CONSTRAINT PK_DESTRUCT_PASSP PRIMARY KEY (SER, NUM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DESTRUCT_PASSP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DESTRUCT_PASSP ON BARS.DESTRUCT_PASSP (SER, NUM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DESTRUCT_PASSP ***
grant SELECT                                                                 on DESTRUCT_PASSP  to BARSREADER_ROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on DESTRUCT_PASSP  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DESTRUCT_PASSP  to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on DESTRUCT_PASSP  to START1;
grant SELECT                                                                 on DESTRUCT_PASSP  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DESTRUCT_PASSP.sql =========*** End **
PROMPT ===================================================================================== 
