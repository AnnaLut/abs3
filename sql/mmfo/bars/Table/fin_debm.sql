

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_DEBM.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_DEBM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_DEBM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_DEBM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_DEBM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_DEBM ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_DEBM 
   (	ID NUMBER(*,0), 
	NAME VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_DEBM ***
 exec bpa.alter_policies('FIN_DEBM');


COMMENT ON TABLE BARS.FIN_DEBM IS 'Довідник мод.АБС, пов`язаних з Фін.Деб';
COMMENT ON COLUMN BARS.FIN_DEBM.ID IS 'Код';
COMMENT ON COLUMN BARS.FIN_DEBM.NAME IS 'Назва';




PROMPT *** Create  constraint PK_FINDEBM ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_DEBM ADD CONSTRAINT PK_FINDEBM PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FINDEBM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FINDEBM ON BARS.FIN_DEBM (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_DEBM ***
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_DEBM        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_DEBM        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_DEBM        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_DEBM.sql =========*** End *** ====
PROMPT ===================================================================================== 
