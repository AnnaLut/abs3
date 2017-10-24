

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KF27.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KF27 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KF27'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KF27'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KF27'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KF27 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KF27 
   (	D020 CHAR(2), 
	TXT VARCHAR2(144)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KF27 ***
 exec bpa.alter_policies('KF27');


COMMENT ON TABLE BARS.KF27 IS '';
COMMENT ON COLUMN BARS.KF27.D020 IS '';
COMMENT ON COLUMN BARS.KF27.TXT IS '';




PROMPT *** Create  constraint XPK_KF27 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF27 ADD CONSTRAINT XPK_KF27 PRIMARY KEY (D020)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005373 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF27 MODIFY (D020 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_KF27 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KF27 ON BARS.KF27 (D020) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KF27 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KF27            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KF27            to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KF27            to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KF27.sql =========*** End *** ========
PROMPT ===================================================================================== 
