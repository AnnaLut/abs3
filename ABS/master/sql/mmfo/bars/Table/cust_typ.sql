

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUST_TYP.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUST_TYP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUST_TYP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUST_TYP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CUST_TYP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUST_TYP ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUST_TYP 
   (	TYPE NUMBER, 
	NAME VARCHAR2(30)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUST_TYP ***
 exec bpa.alter_policies('CUST_TYP');


COMMENT ON TABLE BARS.CUST_TYP IS '';
COMMENT ON COLUMN BARS.CUST_TYP.TYPE IS '';
COMMENT ON COLUMN BARS.CUST_TYP.NAME IS '';




PROMPT *** Create  constraint SYS_C006112 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_TYP MODIFY (TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUST_TYP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CUST_TYP        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUST_TYP        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUST_TYP        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUST_TYP.sql =========*** End *** ====
PROMPT ===================================================================================== 
