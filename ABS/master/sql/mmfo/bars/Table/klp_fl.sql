

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KLP_FL.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KLP_FL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KLP_FL'', ''CENTER'' , ''C'', ''C'', ''C'', null);
               bpa.alter_policy_info(''KLP_FL'', ''WHOLE'' , ''C'', ''C'', ''C'', null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KLP_FL ***
begin 
  execute immediate '
  CREATE TABLE BARS.KLP_FL 
   (	FL NUMBER, 
	DESCR VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KLP_FL ***
 exec bpa.alter_policies('KLP_FL');


COMMENT ON TABLE BARS.KLP_FL IS 'Флаги обробки';
COMMENT ON COLUMN BARS.KLP_FL.FL IS 'Код флагу';
COMMENT ON COLUMN BARS.KLP_FL.DESCR IS 'Опис флагу';




PROMPT *** Create  constraint KLP_FL_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_FL ADD CONSTRAINT KLP_FL_PK PRIMARY KEY (FL)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index KLP_FL_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.KLP_FL_PK ON BARS.KLP_FL (FL) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KLP_FL ***
grant SELECT                                                                 on KLP_FL          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KLP_FL          to BARS_DM;
grant SELECT                                                                 on KLP_FL          to PYOD001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KLP_FL.sql =========*** End *** ======
PROMPT ===================================================================================== 
