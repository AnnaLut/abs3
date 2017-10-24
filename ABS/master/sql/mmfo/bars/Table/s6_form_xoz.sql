

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_FORM_XOZ.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_FORM_XOZ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''S6_FORM_XOZ'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''S6_FORM_XOZ'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''S6_FORM_XOZ'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_FORM_XOZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_FORM_XOZ 
   (	ID NUMBER(5,0), 
	NAME VARCHAR2(80), 
	K051 NUMBER(3,0), 
	K052 NUMBER(3,0), 
	D_open DATE, 
	D_close DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_FORM_XOZ ***
 exec bpa.alter_policies('S6_FORM_XOZ');


COMMENT ON TABLE BARS.S6_FORM_XOZ IS '';
COMMENT ON COLUMN BARS.S6_FORM_XOZ.ID IS '';
COMMENT ON COLUMN BARS.S6_FORM_XOZ.NAME IS '';
COMMENT ON COLUMN BARS.S6_FORM_XOZ.K051 IS '';
COMMENT ON COLUMN BARS.S6_FORM_XOZ.K052 IS '';
COMMENT ON COLUMN BARS.S6_FORM_XOZ.D_open IS '';
COMMENT ON COLUMN BARS.S6_FORM_XOZ.D_close IS '';




PROMPT *** Create  constraint SYS_C005959 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_FORM_XOZ MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  S6_FORM_XOZ ***
grant DELETE,INSERT,SELECT,UPDATE                                            on S6_FORM_XOZ     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S6_FORM_XOZ     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on S6_FORM_XOZ     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_FORM_XOZ.sql =========*** End *** =
PROMPT ===================================================================================== 
