

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBS_PROFACC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBS_PROFACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBS_PROFACC'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBS_PROFACC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBS_PROFACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBS_PROFACC 
   (	NBS VARCHAR2(4), 
	NP NUMBER, 
	SQLCONDITION VARCHAR2(4000), 
	ORD NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBS_PROFACC ***
 exec bpa.alter_policies('NBS_PROFACC');


COMMENT ON TABLE BARS.NBS_PROFACC IS 'Профили для открытия счетов';
COMMENT ON COLUMN BARS.NBS_PROFACC.NBS IS 'Номер БС';
COMMENT ON COLUMN BARS.NBS_PROFACC.NP IS 'Номер профиля';
COMMENT ON COLUMN BARS.NBS_PROFACC.SQLCONDITION IS 'Sql-условие для выбора профиля';
COMMENT ON COLUMN BARS.NBS_PROFACC.ORD IS 'Сортировка';




PROMPT *** Create  constraint FK_NBS_PROFACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_PROFACC ADD CONSTRAINT FK_NBS_PROFACC FOREIGN KEY (NBS, NP)
	  REFERENCES BARS.NBS_PROFNAM (NBS, NP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_NBS_PROFACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_PROFACC ADD CONSTRAINT XPK_NBS_PROFACC PRIMARY KEY (NBS, NP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_NBS_PROFACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_NBS_PROFACC ON BARS.NBS_PROFACC (NBS, NP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBS_PROFACC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on NBS_PROFACC     to NBS_PROF;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NBS_PROFACC     to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to NBS_PROFACC ***

  CREATE OR REPLACE PUBLIC SYNONYM NBS_PROFACC FOR BARS.NBS_PROFACC;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBS_PROFACC.sql =========*** End *** =
PROMPT ===================================================================================== 
