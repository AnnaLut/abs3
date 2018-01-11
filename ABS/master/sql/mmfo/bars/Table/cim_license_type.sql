

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_LICENSE_TYPE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_LICENSE_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_LICENSE_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_LICENSE_TYPE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CIM_LICENSE_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_LICENSE_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_LICENSE_TYPE 
   (	TYPE_ID NUMBER, 
	TYPE_NAME VARCHAR2(64), 
	DELETE_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_LICENSE_TYPE ***
 exec bpa.alter_policies('CIM_LICENSE_TYPE');


COMMENT ON TABLE BARS.CIM_LICENSE_TYPE IS 'Типи ліцензій мінекономіки';
COMMENT ON COLUMN BARS.CIM_LICENSE_TYPE.TYPE_ID IS 'ID типу ліцензій';
COMMENT ON COLUMN BARS.CIM_LICENSE_TYPE.TYPE_NAME IS 'Назва типу ліцензій';
COMMENT ON COLUMN BARS.CIM_LICENSE_TYPE.DELETE_DATE IS 'Дата видалення';




PROMPT *** Create  constraint PK_CIMLICENSETYPE_TYPEID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_LICENSE_TYPE ADD CONSTRAINT PK_CIMLICENSETYPE_TYPEID PRIMARY KEY (TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMLICENSETYPE_TYPEID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMLICENSETYPE_TYPEID ON BARS.CIM_LICENSE_TYPE (TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_LICENSE_TYPE ***
grant SELECT                                                                 on CIM_LICENSE_TYPE to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_LICENSE_TYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_LICENSE_TYPE to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_LICENSE_TYPE to CIM_ROLE;
grant SELECT                                                                 on CIM_LICENSE_TYPE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_LICENSE_TYPE.sql =========*** End 
PROMPT ===================================================================================== 
