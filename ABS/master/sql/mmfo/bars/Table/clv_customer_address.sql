

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CLV_CUSTOMER_ADDRESS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CLV_CUSTOMER_ADDRESS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CLV_CUSTOMER_ADDRESS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CLV_CUSTOMER_ADDRESS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CLV_CUSTOMER_ADDRESS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CLV_CUSTOMER_ADDRESS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CLV_CUSTOMER_ADDRESS 
   (	RNK NUMBER(38,0), 
	TYPE_ID NUMBER(38,0), 
	COUNTRY NUMBER(3,0), 
	ZIP VARCHAR2(20), 
	DOMAIN VARCHAR2(30), 
	REGION VARCHAR2(30), 
	LOCALITY VARCHAR2(30), 
	ADDRESS VARCHAR2(100), 
	TERRITORY_ID NUMBER(22,0), 
	LOCALITY_TYPE NUMBER(22,0), 
	STREET_TYPE NUMBER(22,0), 
	STREET VARCHAR2(100), 
	HOME_TYPE NUMBER(22,0), 
	HOME VARCHAR2(100), 
	HOMEPART_TYPE NUMBER(22,0), 
	HOMEPART VARCHAR2(100), 
	ROOM_TYPE NUMBER(22,0), 
	ROOM VARCHAR2(100), 
	COMM VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CLV_CUSTOMER_ADDRESS ***
 exec bpa.alter_policies('CLV_CUSTOMER_ADDRESS');


COMMENT ON TABLE BARS.CLV_CUSTOMER_ADDRESS IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_ADDRESS.RNK IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_ADDRESS.TYPE_ID IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_ADDRESS.COUNTRY IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_ADDRESS.ZIP IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_ADDRESS.DOMAIN IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_ADDRESS.REGION IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_ADDRESS.LOCALITY IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_ADDRESS.ADDRESS IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_ADDRESS.TERRITORY_ID IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_ADDRESS.LOCALITY_TYPE IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_ADDRESS.STREET_TYPE IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_ADDRESS.STREET IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_ADDRESS.HOME_TYPE IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_ADDRESS.HOME IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_ADDRESS.HOMEPART_TYPE IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_ADDRESS.HOMEPART IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_ADDRESS.ROOM_TYPE IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_ADDRESS.ROOM IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_ADDRESS.COMM IS '';




PROMPT *** Create  constraint PK_CLVCUSTOMERADDRESS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_CUSTOMER_ADDRESS ADD CONSTRAINT PK_CLVCUSTOMERADDRESS PRIMARY KEY (RNK, TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVCUSTOMERADR_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_CUSTOMER_ADDRESS MODIFY (RNK CONSTRAINT CC_CLVCUSTOMERADR_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVCUSTOMERADR_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_CUSTOMER_ADDRESS MODIFY (TYPE_ID CONSTRAINT CC_CLVCUSTOMERADR_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CLVCUSTOMERADDRESS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CLVCUSTOMERADDRESS ON BARS.CLV_CUSTOMER_ADDRESS (RNK, TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CLV_CUSTOMER_ADDRESS ***
grant SELECT                                                                 on CLV_CUSTOMER_ADDRESS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CLV_CUSTOMER_ADDRESS to BARS_DM;
grant SELECT                                                                 on CLV_CUSTOMER_ADDRESS to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CLV_CUSTOMER_ADDRESS.sql =========*** 
PROMPT ===================================================================================== 
