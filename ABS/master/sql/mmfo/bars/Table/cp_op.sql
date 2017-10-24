

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_OP.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_OP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_OP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_OP'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CP_OP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_OP ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_OP 
   (	OP NUMBER(*,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_OP ***
 exec bpa.alter_policies('CP_OP');


COMMENT ON TABLE BARS.CP_OP IS 'Види операц_й з ЦП';
COMMENT ON COLUMN BARS.CP_OP.OP IS 'Назва виду операц_ї';
COMMENT ON COLUMN BARS.CP_OP.NAME IS '';




PROMPT *** Create  constraint XPK_CPOP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_OP ADD CONSTRAINT XPK_CPOP PRIMARY KEY (OP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CPOP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CPOP ON BARS.CP_OP (OP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_OP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_OP           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_OP           to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_OP           to CP_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_OP           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_OP.sql =========*** End *** =======
PROMPT ===================================================================================== 
