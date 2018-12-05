PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_PAR.sql =========*** Run *** =====
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to REZ_PAR ***
BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_PAR'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''REZ_PAR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_PAR ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_PAR
   (	par   VARCHAR2(20), 
	val   VARCHAR2(4000), 
	COMM  VARCHAR2(1000) 
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to REZ_PAR ***
 exec bpa.alter_policies('REZ_PAR');


COMMENT ON TABLE BARS.REZ_PAR       IS 'Параметри для резерву';
COMMENT ON COLUMN BARS.REZ_PAR.par  IS 'Параметр';
COMMENT ON COLUMN BARS.REZ_PAR.val  IS 'Значення';
COMMENT ON COLUMN BARS.REZ_PAR.comm IS 'Опис';

PROMPT *** Create  constraint PK_REZ_PAR ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_PAR ADD CONSTRAINT PK_REZ_PAR PRIMARY KEY (PAR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 or sqlcode=-955 then null; else raise; end if;
 end;
/


PROMPT *** Create  index PK_REZ_PAR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REZ_PAR ON BARS.REZ_PAR (par) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  grants REZ_PAR ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REZ_PAR to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REZ_PAR to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_PAR.sql =========**
PROMPT ===================================================================================== 
