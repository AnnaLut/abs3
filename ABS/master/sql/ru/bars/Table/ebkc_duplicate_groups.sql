

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBKC_DUPLICATE_GROUPS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBKC_DUPLICATE_GROUPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EBKC_DUPLICATE_GROUPS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EBKC_DUPLICATE_GROUPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBKC_DUPLICATE_GROUPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBKC_DUPLICATE_GROUPS 
   (	M_RNK NUMBER(38,0), 
	D_RNK NUMBER(38,0), 
	CUST_TYPE VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EBKC_DUPLICATE_GROUPS ***
 exec bpa.alter_policies('EBKC_DUPLICATE_GROUPS');


COMMENT ON TABLE BARS.EBKC_DUPLICATE_GROUPS IS 'Таблица основной карточки с дочерними для дедубликации';
COMMENT ON COLUMN BARS.EBKC_DUPLICATE_GROUPS.M_RNK IS '';
COMMENT ON COLUMN BARS.EBKC_DUPLICATE_GROUPS.D_RNK IS '';
COMMENT ON COLUMN BARS.EBKC_DUPLICATE_GROUPS.CUST_TYPE IS '';



PROMPT *** Create  grants  EBKC_DUPLICATE_GROUPS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on EBKC_DUPLICATE_GROUPS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBKC_DUPLICATE_GROUPS.sql =========***
PROMPT ===================================================================================== 
