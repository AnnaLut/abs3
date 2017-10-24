

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_NLS_23.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_NLS_23 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_NLS_23 ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_NLS_23 
   (	NBS VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ_NLS_23 ***
 exec bpa.alter_policies('REZ_NLS_23');


COMMENT ON TABLE BARS.REZ_NLS_23 IS '';
COMMENT ON COLUMN BARS.REZ_NLS_23.NBS IS '';




PROMPT *** Create  constraint PK_REZ_NLS_23 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_NLS_23 ADD CONSTRAINT PK_REZ_NLS_23 PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REZ_NLS_23 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REZ_NLS_23 ON BARS.REZ_NLS_23 (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REZ_NLS_23 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on REZ_NLS_23      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REZ_NLS_23      to BARS_DM;
grant SELECT                                                                 on REZ_NLS_23      to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on REZ_NLS_23      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_NLS_23.sql =========*** End *** ==
PROMPT ===================================================================================== 
