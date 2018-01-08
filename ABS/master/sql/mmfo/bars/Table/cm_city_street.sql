

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CM_CITY_STREET.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CM_CITY_STREET ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CM_CITY_STREET'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CM_CITY_STREET'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CM_CITY_STREET ***
begin 
  execute immediate '
  CREATE TABLE BARS.CM_CITY_STREET 
   (	CITY_AREA_ID NUMBER(10,0), 
	STREET_TYPE_ID NUMBER(10,0), 
	STREET_NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CM_CITY_STREET ***
 exec bpa.alter_policies('CM_CITY_STREET');


COMMENT ON TABLE BARS.CM_CITY_STREET IS 'CardMake. Довідник вулиць міста';
COMMENT ON COLUMN BARS.CM_CITY_STREET.CITY_AREA_ID IS 'Код району міста';
COMMENT ON COLUMN BARS.CM_CITY_STREET.STREET_TYPE_ID IS 'Код типувулиці';
COMMENT ON COLUMN BARS.CM_CITY_STREET.STREET_NAME IS 'Назва вулиці';



PROMPT *** Create  grants  CM_CITY_STREET ***
grant SELECT                                                                 on CM_CITY_STREET  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CM_CITY_STREET  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CM_CITY_STREET  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CM_CITY_STREET  to OW;
grant SELECT                                                                 on CM_CITY_STREET  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CM_CITY_STREET.sql =========*** End **
PROMPT ===================================================================================== 
