

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/P_L_2C.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to P_L_2C ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''P_L_2C'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''P_L_2C'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table P_L_2C ***
begin 
  execute immediate '
  CREATE TABLE BARS.P_L_2C 
   (	ID NUMBER(4,0), 
	NAME VARCHAR2(512), 
	DELETE_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to P_L_2C ***
 exec bpa.alter_policies('P_L_2C');


COMMENT ON TABLE BARS.P_L_2C IS 'Атрибут L звіту #2C';
COMMENT ON COLUMN BARS.P_L_2C.ID IS 'ID';
COMMENT ON COLUMN BARS.P_L_2C.NAME IS 'Текстова назва';
COMMENT ON COLUMN BARS.P_L_2C.DELETE_DATE IS 'Дата видаленя';



PROMPT *** Create  index PK_P_L_2C ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_P_L_2C ON BARS.P_L_2C (ID) 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint PK_P_L_2C ***
begin   
 execute immediate '
  ALTER TABLE BARS.P_L_2C ADD CONSTRAINT PK_P_L_2C PRIMARY KEY (ID)
  USING INDEX BARS.PK_P_L_2C';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




alter table P_L_2C modify id varchar2(4);


PROMPT *** Create  grants  P_L_2C ***
grant SELECT                                                                 on P_L_2C          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on P_L_2C          to BARS_DM;
grant SELECT                                                                 on P_L_2C          to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/P_L_2C.sql =========*** End *** ======
PROMPT ===================================================================================== 
