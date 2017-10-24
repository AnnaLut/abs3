

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ORDER_REZ.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ORDER_REZ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ORDER_REZ'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ORDER_REZ'', ''WHOLE'' , null, null, null, null);
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
	NAME VARCHAR2(100)
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
COMMENT ON COLUMN BARS.ORDER_REZ.NLSB IS 'счет затрат';
COMMENT ON COLUMN BARS.ORDER_REZ.S IS 'Сумма';
COMMENT ON COLUMN BARS.ORDER_REZ.NAME IS 'Назва';
COMMENT ON COLUMN BARS.ORDER_REZ.GRP IS 'Группа';
COMMENT ON COLUMN BARS.ORDER_REZ.DK IS 'ДК';
COMMENT ON COLUMN BARS.ORDER_REZ.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.ORDER_REZ.NLSA IS 'счет резерва';



PROMPT *** Create  grants  ORDER_REZ ***
grant SELECT                                                                 on ORDER_REZ       to RCC_DEAL;
grant SELECT                                                                 on ORDER_REZ       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ORDER_REZ.sql =========*** End *** ===
PROMPT ===================================================================================== 
