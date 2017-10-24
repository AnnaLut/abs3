

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_TMP_INS_70.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_TMP_INS_70 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_TMP_INS_70'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_TMP_INS_70'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NBUR_TMP_INS_70'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_TMP_INS_70 ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_TMP_INS_70 
   (	KODF VARCHAR2(2), 
	DATF DATE, 
	USERID NUMBER, 
	REF NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_TMP_INS_70 ***
 exec bpa.alter_policies('NBUR_TMP_INS_70');


COMMENT ON TABLE BARS.NBUR_TMP_INS_70 IS '������� ��� ��������� �������� ��� ���������� �����';
COMMENT ON COLUMN BARS.NBUR_TMP_INS_70.KODF IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_INS_70.DATF IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_INS_70.USERID IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_INS_70.REF IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_INS_70.KF IS '';




PROMPT *** Create  index I1_NBUR_TMP_INS_70 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.I1_NBUR_TMP_INS_70 ON BARS.NBUR_TMP_INS_70 (KF, KODF, DATF, REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_TMP_INS_70 ***
grant SELECT                                                                 on NBUR_TMP_INS_70 to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_TMP_INS_70.sql =========*** End *
PROMPT ===================================================================================== 
