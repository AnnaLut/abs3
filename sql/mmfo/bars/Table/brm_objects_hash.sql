

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BRM_OBJECTS_HASH.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BRM_OBJECTS_HASH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BRM_OBJECTS_HASH'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BRM_OBJECTS_HASH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BRM_OBJECTS_HASH ***
begin 
  execute immediate '
  CREATE TABLE BARS.BRM_OBJECTS_HASH 
   (	INSTALL_ID NUMBER, 
	OBJECT_ID NUMBER, 
	OBJECT_OWNER VARCHAR2(30), 
	OBJECT_TYPE VARCHAR2(20), 
	OBJECT_NAME VARCHAR2(30), 
	OBJECT_TS VARCHAR2(100), 
	BARS_HASH VARCHAR2(32)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BRM_OBJECTS_HASH ***
 exec bpa.alter_policies('BRM_OBJECTS_HASH');


COMMENT ON TABLE BARS.BRM_OBJECTS_HASH IS 'Лог по каждому объекту на момент записи в основной brm_install_log';
COMMENT ON COLUMN BARS.BRM_OBJECTS_HASH.INSTALL_ID IS 'Ид в основной таблице';
COMMENT ON COLUMN BARS.BRM_OBJECTS_HASH.OBJECT_ID IS '';
COMMENT ON COLUMN BARS.BRM_OBJECTS_HASH.OBJECT_OWNER IS '';
COMMENT ON COLUMN BARS.BRM_OBJECTS_HASH.OBJECT_TYPE IS '';
COMMENT ON COLUMN BARS.BRM_OBJECTS_HASH.OBJECT_NAME IS '';
COMMENT ON COLUMN BARS.BRM_OBJECTS_HASH.OBJECT_TS IS '';
COMMENT ON COLUMN BARS.BRM_OBJECTS_HASH.BARS_HASH IS '';




PROMPT *** Create  index XPK_BRM_OBJ_HASH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_BRM_OBJ_HASH ON BARS.BRM_OBJECTS_HASH (INSTALL_ID, OBJECT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BRM_OBJECTS_HASH ***
grant SELECT                                                                 on BRM_OBJECTS_HASH to BARSREADER_ROLE;
grant SELECT                                                                 on BRM_OBJECTS_HASH to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BRM_OBJECTS_HASH to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BRM_OBJECTS_HASH.sql =========*** End 
PROMPT ===================================================================================== 
