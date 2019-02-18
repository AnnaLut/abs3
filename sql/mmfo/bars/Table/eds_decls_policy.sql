

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EDS_DECLS_POLICY.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EDS_DECLS_POLICY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EDS_DECLS_POLICY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EDS_DECLS_POLICY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EDS_DECLS_POLICY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EDS_DECLS_POLICY ***
begin 
  execute immediate '
  CREATE TABLE BARS.EDS_DECLS_POLICY 
   (    ID VARCHAR2(36), 
    ADD_DATE DATE, 
    ADD_ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EDS_DECLS_POLICY ***
 exec bpa.alter_policies('EDS_DECLS_POLICY');


COMMENT ON TABLE BARS.EDS_DECLS_POLICY IS 'Права доступу до декларацій';
COMMENT ON COLUMN BARS.EDS_DECLS_POLICY.ID IS 'Ід декларації';
COMMENT ON COLUMN BARS.EDS_DECLS_POLICY.ADD_DATE IS 'Дата коля додали права';
COMMENT ON COLUMN BARS.EDS_DECLS_POLICY.ADD_ID IS 'Ід користувача, який додав декларацію';



PROMPT *** Create  index PK_EDS_DECLS_POLICY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EDS_DECLS_POLICY ON BARS.EDS_DECLS_POLICY (id, add_id) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint PK_EDS_DECLS_POLICY ***
begin   
 execute immediate '
  ALTER TABLE BARS.EDS_DECLS_POLICY ADD CONSTRAINT PK_EDS_DECLS_POLICY PRIMARY KEY (id, add_id)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EDS_DECLS_POLICY.sql =========*** End 
PROMPT ===================================================================================== 

