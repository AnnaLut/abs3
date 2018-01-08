

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ORDER_REZ.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ORDER_REZ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ORDER_REZ'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ORDER_REZ'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ORDER_REZ'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ORDER_REZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.ORDER_REZ 
   (	GRP NUMBER, 
	DK NUMBER, 
	KV NUMBER(*,0), 
	NLSA VARCHAR2(15), 
	NLSB VARCHAR2(15), 
	S NUMBER, 
	NAME VARCHAR2(100), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ORDER_REZ ***
 exec bpa.alter_policies('ORDER_REZ');


COMMENT ON TABLE BARS.ORDER_REZ IS 'Розпорядження на проводки';
COMMENT ON COLUMN BARS.ORDER_REZ.KF IS '';
COMMENT ON COLUMN BARS.ORDER_REZ.GRP IS 'Группа';
COMMENT ON COLUMN BARS.ORDER_REZ.DK IS 'ДК';
COMMENT ON COLUMN BARS.ORDER_REZ.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.ORDER_REZ.NLSA IS 'счет резерва';
COMMENT ON COLUMN BARS.ORDER_REZ.NLSB IS 'счет затрат';
COMMENT ON COLUMN BARS.ORDER_REZ.S IS 'Сумма';
COMMENT ON COLUMN BARS.ORDER_REZ.NAME IS 'Назва';




PROMPT *** Create  constraint CC_ORDERREZ_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ORDER_REZ MODIFY (KF CONSTRAINT CC_ORDERREZ_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ORDER_REZ ***
grant SELECT                                                                 on ORDER_REZ       to BARSREADER_ROLE;
grant SELECT                                                                 on ORDER_REZ       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ORDER_REZ       to BARS_DM;
grant SELECT                                                                 on ORDER_REZ       to RCC_DEAL;
grant SELECT                                                                 on ORDER_REZ       to START1;
grant SELECT                                                                 on ORDER_REZ       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ORDER_REZ.sql =========*** End *** ===
PROMPT ===================================================================================== 
