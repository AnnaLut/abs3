

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SREZERV_ERROR_TYPES.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SREZERV_ERROR_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SREZERV_ERROR_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SREZERV_ERROR_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SREZERV_ERROR_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SREZERV_ERROR_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.SREZERV_ERROR_TYPES 
   (	ERROR_TYPE NUMBER, 
	ERROR_TXT VARCHAR2(100), 
	SORT_ORDER NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SREZERV_ERROR_TYPES ***
 exec bpa.alter_policies('SREZERV_ERROR_TYPES');


COMMENT ON TABLE BARS.SREZERV_ERROR_TYPES IS '';
COMMENT ON COLUMN BARS.SREZERV_ERROR_TYPES.ERROR_TYPE IS '';
COMMENT ON COLUMN BARS.SREZERV_ERROR_TYPES.ERROR_TXT IS '';
COMMENT ON COLUMN BARS.SREZERV_ERROR_TYPES.SORT_ORDER IS '';



PROMPT *** Create  grants  SREZERV_ERROR_TYPES ***
grant SELECT                                                                 on SREZERV_ERROR_TYPES to BARSREADER_ROLE;
grant SELECT                                                                 on SREZERV_ERROR_TYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SREZERV_ERROR_TYPES to BARS_DM;
grant SELECT                                                                 on SREZERV_ERROR_TYPES to RCC_DEAL;
grant SELECT                                                                 on SREZERV_ERROR_TYPES to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SREZERV_ERROR_TYPES to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SREZERV_ERROR_TYPES.sql =========*** E
PROMPT ===================================================================================== 
