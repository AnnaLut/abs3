

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/W4_CONF_ACC_STAT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to W4_CONF_ACC_STAT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''W4_CONF_ACC_STAT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''W4_CONF_ACC_STAT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table W4_CONF_ACC_STAT ***
begin 
  execute immediate '
  CREATE TABLE BARS.W4_CONF_ACC_STAT 
   (	ACC NUMBER, 
	STATE NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to W4_CONF_ACC_STAT ***
 exec bpa.alter_policies('W4_CONF_ACC_STAT');


COMMENT ON TABLE BARS.W4_CONF_ACC_STAT IS '/ Переведення рахунку із статусу «Зарезервований» в статус «Відкритий';
COMMENT ON COLUMN BARS.W4_CONF_ACC_STAT.ACC IS '';
COMMENT ON COLUMN BARS.W4_CONF_ACC_STAT.STATE IS 'Статус рахунку 1- Підтвердженно, 0 - відхилено';
COMMENT ON COLUMN BARS.W4_CONF_ACC_STAT.KF IS '';



PROMPT *** Create  grants  W4_CONF_ACC_STAT ***
grant SELECT                                                                 on W4_CONF_ACC_STAT to BARSREADER_ROLE;
grant SELECT                                                                 on W4_CONF_ACC_STAT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/W4_CONF_ACC_STAT.sql =========*** End 
PROMPT ===================================================================================== 
