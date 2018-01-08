

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_PTRTYPES.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SUBPRODUCT_PTRTYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SUBPRODUCT_PTRTYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCT_PTRTYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCT_PTRTYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SUBPRODUCT_PTRTYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SUBPRODUCT_PTRTYPES 
   (	SUBPRODUCT_ID VARCHAR2(100), 
	PTR_TYPE_ID VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SUBPRODUCT_PTRTYPES ***
 exec bpa.alter_policies('WCS_SUBPRODUCT_PTRTYPES');


COMMENT ON TABLE BARS.WCS_SUBPRODUCT_PTRTYPES IS 'Привязка типов торговцев партнеров к суб-продукту';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_PTRTYPES.SUBPRODUCT_ID IS 'Идентификатор субродукта';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_PTRTYPES.PTR_TYPE_ID IS 'Идентификатор типа торговца партнера';




PROMPT *** Create  constraint PK_SUBPRODUCTPTRTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_PTRTYPES ADD CONSTRAINT PK_SUBPRODUCTPTRTYPES PRIMARY KEY (SUBPRODUCT_ID, PTR_TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPPTRTYPES_SBPID_SBPS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_PTRTYPES ADD CONSTRAINT FK_SBPPTRTYPES_SBPID_SBPS_ID FOREIGN KEY (SUBPRODUCT_ID)
	  REFERENCES BARS.WCS_SUBPRODUCTS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPPTRTYPES_PID_PARTS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_PTRTYPES ADD CONSTRAINT FK_SBPPTRTYPES_PID_PARTS_ID FOREIGN KEY (PTR_TYPE_ID)
	  REFERENCES BARS.WCS_PARTNER_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SUBPRODUCTPTRTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SUBPRODUCTPTRTYPES ON BARS.WCS_SUBPRODUCT_PTRTYPES (SUBPRODUCT_ID, PTR_TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SUBPRODUCT_PTRTYPES ***
grant SELECT                                                                 on WCS_SUBPRODUCT_PTRTYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SUBPRODUCT_PTRTYPES to BARS_DM;
grant SELECT                                                                 on WCS_SUBPRODUCT_PTRTYPES to WCS_SYNC_USER;



PROMPT *** Create SYNONYM  to WCS_SUBPRODUCT_PTRTYPES ***

  CREATE OR REPLACE PUBLIC SYNONYM WCS_SUBPRODUCT_PTRTYPES FOR BARS.WCS_SUBPRODUCT_PTRTYPES;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_PTRTYPES.sql =========*
PROMPT ===================================================================================== 
