<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
  <xsl:output method="html" encoding="windows-1251" indent="yes" omit-xml-declaration="yes"
              doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
              doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />

  <!--Параметры вызова-->
  <xsl:param name="generatedUniversalTime" select="0"/>
  <xsl:param name="territoryRef" select="/.."/>

  <!--Справочники-->


  <xsl:variable name="davContractType" select="document('ContractType-rv-001.xml')"></xsl:variable>
  <xsl:variable name="davEntity" select="document('Entity-rv-002.xml')"></xsl:variable>
  <xsl:variable name="davCatGroupHead" select="document('CategoryGroupHeader.xml')"></xsl:variable>

  <xsl:variable name="davClassification" select="document('Classification-cid-01.xml')"></xsl:variable>
  <xsl:variable name="davRole" select="document('RoleId-cid-02.xml')"></xsl:variable>
  <xsl:variable name="davResidency" select="document('Residency-cid-03.xml')"></xsl:variable>
  <xsl:variable name="davNegativeState" select="document('NegativeStatus-cid-05.xml')"></xsl:variable>
  <xsl:variable name="davGender" select="document('Gender-cid-06.xml')"></xsl:variable>
  <xsl:variable name="davEducation" select="document('Education-cid-07.xml')"></xsl:variable>
  <xsl:variable name="davMaritalStatus" select="document('MaritalStatus-cid-08.xml')"></xsl:variable>
  <xsl:variable name="davOwnership" select="document('Ownership-cid-10.xml')"></xsl:variable>
  <xsl:variable name="davEconomicActivity" select="document('EconomicActivity-cid-11.xml')"></xsl:variable>
  <xsl:variable name="davStatus" select="document('StatusId-cid-12.xml')"></xsl:variable>
  <xsl:variable name="davCreditPurpose" select="document('CreditPurpose-cid-14.xml')"></xsl:variable>
  <xsl:variable name="davPhase" select="document('PhaseId-cid-15.xml')"></xsl:variable>
  <xsl:variable name="davNegativeStatus" select="document('NegativeStatus-cid-16.xml')"></xsl:variable>
  <xsl:variable name="davCollateralType" select="document('CollateralTypeId-cid-17.xml')"></xsl:variable>
  <xsl:variable name="davPaymentPeriod" select="document('PaymentPeriodId-cid-18.xml')"></xsl:variable>
  <!--xsl:variable name="davPaymentMethod" select="document('PaymentMethodId-cid-19.xml')"></xsl:variable-->
  <xsl:variable name="davCreditUsage" select="document('CreditUsage-cid-20.xml')"></xsl:variable>
  <xsl:variable name="davEmployeeCount" select="document('EmployeeCount-cid-22.xml')"></xsl:variable>
  <xsl:variable name="davAddressType" select="document('AddressTypeId-cid-26.xml')"></xsl:variable>
  <xsl:variable name="davCommunicationType" select="document('CommunicationTypeId-cid-27.xml')"></xsl:variable>
  <xsl:variable name="davIdentificationType" select="document('IdentificationTypeId-cid-29.xml')"></xsl:variable>

  <!--ВЫПИСКА-->
  <xsl:template match="Statement">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1251" />
        <meta http-equiv="Expires" content="Thu, 17 Jan 1974 12:00:00 GMT" />
        <meta name="Author" content="Aleksandr V. Diomin" />
        <meta name="Copyright" content="First All-Ukrainian Bureau of Credit Histories" />
        <title>Statement for <xsl:value-of select="Subject/requestid"/> at <xsl:value-of select="msxsl:format-date(substring(@generated, 1, 10), 'dd-MM-yyyy')"/><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text><xsl:value-of select="substring(@generated, 12, 8)"/> from PVBKI</title>
        <script type="text/javascript">
          function formatTwoDigits(value) {
          return (Math.floor(value) / 100).toFixed(2).split('.')[1];
          }
          function tick() {
          var Today = new Date();
          var Generated = <xsl:value-of select="$generatedUniversalTime"/>;
          var Elapsed = Today.valueOf() - Generated;
          Elapsed = Math.floor(Elapsed / 1000);
          if (Elapsed <xsl:text disable-output-escaping="yes">&lt;</xsl:text> 86400)
          document.getElementById('ReportAge').innerHTML = formatTwoDigits(Elapsed / 3600 % 24) + ':' + formatTwoDigits(Elapsed / 60 % 60) + ':' + formatTwoDigits(Elapsed % 60);
          else document.getElementById('ReportAge').innerHTML = Math.floor(Elapsed / 86400).toString() + '.' + formatTwoDigits(Elapsed / 3600 % 24) + ':' + formatTwoDigits(Elapsed / 60 % 60) + ':' + formatTwoDigits(Elapsed % 60);
          window.setTimeout('tick();', 1000);
          }
          function hideAll() {
          if (document.getElementById('SubjectEntity') != null
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          document.getElementById('SubjectEntity').style.display == '')
          document.getElementById('SubjectEntitySwitch').onclick();
          if (document.getElementById('SubjectIdentification') != null
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          document.getElementById('SubjectIdentification').style.display == '')
          document.getElementById('SubjectIdentificationSwitch').onclick();
          if (document.getElementById('SubjectCommunication') != null
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          document.getElementById('SubjectCommunication').style.display == '')
          document.getElementById('SubjectCommunicationSwitch').onclick();
          if (document.getElementById('SubjectAddress') != null
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          document.getElementById('SubjectAddress').style.display == '')
          document.getElementById('SubjectAddressSwitch').onclick();
          if (document.getElementById('SubjectClassification') != null
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          document.getElementById('SubjectClassification').style.display == '')
          document.getElementById('SubjectClassificationSwitch').onclick();
          if (document.getElementById('FinancialSummary') != null
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          document.getElementById('FinancialSummary').style.display == '')
          document.getElementById('FinancialSummarySwitch').onclick();

          for (var i = 1; i <xsl:text disable-output-escaping="yes">&lt;</xsl:text>= <xsl:value-of select="count(Contract)"/>; i++)
          if (document.getElementById('Contract' + i.toString()) != null
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          document.getElementById('Contract' + i.toString()).style.display == '')
          document.getElementById('Contract' + i.toString() + 'Switch').onclick();

          if (document.getElementById('SubjectEvents') != null
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          document.getElementById('SubjectEvents').style.display == '')
          document.getElementById('SubjectEventsSwitch').onclick();
          }
          function showAll() {
          if (document.getElementById('SubjectEntity') != null
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          document.getElementById('SubjectEntity').style.display == 'none')
          document.getElementById('SubjectEntitySwitch').onclick();
          if (document.getElementById('SubjectIdentification') != null
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          document.getElementById('SubjectIdentification').style.display == 'none')
          document.getElementById('SubjectIdentificationSwitch').onclick();
          if (document.getElementById('SubjectCommunication') != null
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          document.getElementById('SubjectCommunication').style.display == 'none')
          document.getElementById('SubjectCommunicationSwitch').onclick();
          if (document.getElementById('SubjectAddress') != null
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          document.getElementById('SubjectAddress').style.display == 'none')
          document.getElementById('SubjectAddressSwitch').onclick();
          if (document.getElementById('SubjectClassification') != null
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          document.getElementById('SubjectClassification').style.display == 'none')
          document.getElementById('SubjectClassificationSwitch').onclick();
          if (document.getElementById('FinancialSummary') != null
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          document.getElementById('FinancialSummary').style.display == 'none')
          document.getElementById('FinancialSummarySwitch').onclick();

          for (var i = 1; i <xsl:text disable-output-escaping="yes">&lt;</xsl:text>= <xsl:value-of select="count(Contract)"/>; i++)
          if (document.getElementById('Contract' + i.toString()) != null
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          document.getElementById('Contract' + i.toString()).style.display == 'none')
          document.getElementById('Contract' + i.toString() + 'Switch').onclick();

          if (document.getElementById('SubjectEvents') != null
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          document.getElementById('SubjectEvents').style.display == 'none')
          document.getElementById('SubjectEventsSwitch').onclick();
          }
          function hideAllRecords() {
          for (var i = 1; i <xsl:text disable-output-escaping="yes">&lt;</xsl:text>= <xsl:value-of select="count(Contract)"/>; i++)
          if (document.getElementById('RecordsFor' + i.toString()) != null
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          document.getElementById('RecordsFor' + i.toString()).style.display == '')
          document.getElementById('RecordsFor' + i.toString() + 'Switch').onclick();
          }
          function showAllRecords() {
          for (var i = 1; i <xsl:text disable-output-escaping="yes">&lt;</xsl:text>= <xsl:value-of select="count(Contract)"/>; i++)
          if (document.getElementById('RecordsFor' + i.toString()) != null
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
          document.getElementById('RecordsFor' + i.toString()).style.display == 'none')
          document.getElementById('RecordsFor' + i.toString() + 'Switch').onclick();
          }
        </script>
      </head>
      <body>
        <input type="hidden" id="generatedUniversalTime" name="generatedUniversalTime">
          <xsl:attribute name="value">
            <xsl:value-of select="$generatedUniversalTime"/>
          </xsl:attribute>
        </input>
        <!--Заголовок Выписки-->
        <table style="width: 100%; font-size: 10pt;margin-top:10px;">
          <tbody>
            <tr>
              <th colspan="4" style="background-color: #FFCCCC; border-bottom-style: solid; border-width: 1px; border-color: #000000;">
                First All-Ukrainian Bureau of Credit Histories
                <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                <xsl:text disable-output-escaping="yes">&amp;copy;</xsl:text>
                <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                <xsl:value-of select="substring(@generated, 1, 4)"/>
              </th>
            </tr>
            <tr>
              <td style="background-color: #E0E0E0; vertical-align: middle; text-align: center; border-left-style: solid; border-top-style: solid; border-width: 1px; border-color: #000000;">
                Credit Report
              </td>
              <td style="vertical-align: middle; text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                STATEMENT
              </td>
              <td style="background-color: #E0E0E0; vertical-align: middle; text-align: center; border-left-style: solid; border-top-style: solid; border-width: 1px; border-color: #000000;">
                Issued
              </td>
              <td style="vertical-align: middle; text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                <xsl:value-of select="msxsl:format-date(substring(@generated, 1, 10), 'dd-MM-yyyy')"/>
                <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                <xsl:value-of select="substring(@generated, 12, 8)"/>
              </td>
            </tr>
            <tr>
              <td style="background-color: #E0E0E0; vertical-align: middle; text-align: center; border-left-style: solid; border-top-style: solid; border-width: 1px; border-color: #000000;">
                Request ID
              </td>
              <td style="vertical-align: middle; text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                <xsl:value-of select="Subject/requestid"/>
              </td>
              <td style="background-color: #E0E0E0; vertical-align: middle; text-align: center; border-left-style: solid; border-top-style: solid; border-width: 1px; border-color: #000000;">
                Last update
              </td>
              <td style="vertical-align: middle; text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                <xsl:value-of select="msxsl:format-date(substring(Subject/lastUpdate, 1, 10), 'dd-MM-yyyy')"/>
                <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                <xsl:value-of select="substring(Subject/lastUpdate, 12, 8)"/>
              </td>
            </tr>
          </tbody>
        </table>
        <!--hr /-->
        
        <hr/>
        <!--Субъект-->
        <xsl:if test="Subject">
          <fieldset id="SubjectEntityGroup">
            <legend style="background-color: #FFFFFF;">
              <label id="SubjectEntitySwitch" style="color: #800000; cursor: pointer;">
                <xsl:attribute name="onclick">if (document.getElementById('SubjectEntity').style.display == 'none')
                                              {
                                                  document.getElementById('SubjectEntity').style.display = '';
                                                  this.innerHTML = '(-)';
                                                  this.style.color = '#800000';
                                                  document.getElementById('SubjectEntityGroup').style.backgroundColor = '';
                                              } else {
                                                  document.getElementById('SubjectEntity').style.display = 'none';
                                                  this.innerHTML = '[+]';
                                                  this.style.color = '#008000';
                                                  document.getElementById('SubjectEntityGroup').style.backgroundColor = '#E0E0AD';
                                              }</xsl:attribute>
                (-)
              </label>
              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
              <label><xsl:value-of select="$davEntity/Vocabulary/Statement[code = current()/Subject/entity]/valueEN"/></label>
            </legend>
            <table id="SubjectEntity" style="width: 100%; font-size: 10pt; background-color: #E0E0AD;">
              <tbody style="background-color: #FFFFFF;">
                <xsl:if test="Subject/entity = 'individual'">
                  <tr>
                    <td rowspan="3" style="background-color: #E0E0AD; border-bottom-style: solid; border-width: 1px; border-color: #000000;">
                      Surname
                    </td>
                    <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="Subject/surnameUA"/>
                    </td>
                    <td rowspan="3" style="background-color: #E0E0AD; border-bottom-style: solid; border-width: 1px; border-color: #000000;">
                      Birth Surname
                    </td>
                    <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="Subject/birthSurnameUA"/>
                    </td>
                  </tr>
                  <tr>
                    <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="Subject/surnameRU"/>
                    </td>
                    <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="Subject/birthSurnameRU"/>
                    </td>
                  </tr>
                  <tr>
                    <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="Subject/surnameEN"/>
                    </td>
                    <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="Subject/birthSurnameEN"/>
                    </td>
                  </tr>
                  <tr>
                    <td rowspan="3" style="background-color: #E0E0AD; border-top-style: solid; border-bottom-style: solid; border-width: 1px; border-color: #000000;">
                      First Name
                    </td>
                    <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="Subject/firstNameUA"/>
                    </td>
                    <td rowspan="3" colspan="2" style="background-color: #E0E0AD; border-top-style: solid; border-bottom-style: solid; border-width: 1px; border-color: #000000;">
                      <table style="width: 100%; font-size: 10pt;">
                        <tbody style="background-color: #FFFFFF;">
                          <tr>
                            <td style="width: 25%; background-color: #E0E0AD;">Birth Date</td>
                            <td colspan="2" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                              <xsl:value-of select="msxsl:format-date(substring(Subject/dateOfBirth, 1, 10), 'dd-MM-yyyy')"/>
                            </td>
                          </tr>
                          <tr>
                            <td style="width: 25%; background-color: #E0E0AD;">Gender</td>
                            <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                              <xsl:value-of select="Subject/gender"/>
                            </td>
                            <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                              <xsl:value-of select="$davGender/CreditInfo/Dictionary[code = current()/Subject/gender]/valueEN"/>
                            </td>
                          </tr>
                        </tbody>
                      </table>
                    </td>
                  </tr>
                  <tr>
                    <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="Subject/firstNameRU"/>
                    </td>
                  </tr>
                  <tr>
                    <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="Subject/firstNameEN"/>
                    </td>
                  </tr>
                  <tr>
                    <td rowspan="3" style="background-color: #E0E0AD; border-top-style: solid; border-width: 1px; border-color: #000000;">
                      Fathers Name
                    </td>
                    <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="Subject/fathersNameUA"/>
                    </td>
                    <td rowspan="3" style="background-color: #E0E0AD; border-top-style: solid; border-width: 1px; border-color: #000000;">
                      Birth Place
                    </td>
                    <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="Subject/placeOfBirthUA"/>
                    </td>
                  </tr>
                  <tr>
                    <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="Subject/fathersNameRU"/>
                    </td>
                    <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="Subject/placeOfBirthRU"/>
                    </td>
                  </tr>
                  <tr>
                    <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="Subject/fathersNameEN"/>
                    </td>
                    <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="Subject/placeOfBirthEN"/>
                    </td>
                  </tr>
                </xsl:if>
                <xsl:if test="Subject/entity = 'company'">
                  <tr>
                    <td rowspan="3" style="width: 25%; background-color: #E0E0AD; border-bottom-style: solid; border-width: 1px; border-color: #000000;">
                      Name
                    </td>
                    <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="Subject/nameUA"/>
                    </td>
                  </tr>
                  <tr>
                    <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="Subject/nameRU"/>
                    </td>
                  </tr>
                  <tr>
                    <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="Subject/nameEN"/>
                    </td>
                  </tr>
                  <tr>
                    <td style="width: 25%; background-color: #E0E0AD; border-top-style: solid; border-bottom-style: solid; border-width: 1px; border-color: #000000;">
                      Registration Date
                    </td>
                    <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="msxsl:format-date(substring(Subject/registrationDate, 1, 10), 'dd-MM-yyyy')"/>
                    </td>
                  </tr>
                  <tr>
                    <td rowspan="3" style="width: 25%; background-color: #E0E0AD; border-top-style: solid; border-width: 1px; border-color: #000000;">
                      Abbreviation
                    </td>
                    <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="Subject/abbreviationUA"/>
                    </td>
                  </tr>
                  <tr>
                    <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="Subject/abbreviationRU"/>
                    </td>
                  </tr>
                  <tr>
                    <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="Subject/abbreviationEN"/>
                    </td>
                  </tr>
                </xsl:if>
              </tbody>
            </table>
          </fieldset>
        </xsl:if>
        <!--hr /-->
        <!--Идентификация-->
        <xsl:if test="Identification">
          <fieldset id="SubjectIdentificationGroup">
            <legend style="background-color: #FFFFFF;">
              <label id="SubjectIdentificationSwitch" style="color: #800000; cursor: pointer;">
                <xsl:attribute name="onclick">if (document.getElementById('SubjectIdentification').style.display == 'none')
                                              {
                                                  document.getElementById('SubjectIdentification').style.display = '';
                                                  this.innerHTML = '(-)';
                                                  this.style.color = '#800000';
                                                  document.getElementById('SubjectIdentificationGroup').style.backgroundColor = '';
                                              } else {
                                                  document.getElementById('SubjectIdentification').style.display = 'none';
                                                  this.innerHTML = '[+]';
                                                  this.style.color = '#008000';
                                                  document.getElementById('SubjectIdentificationGroup').style.backgroundColor = '#ADE0AD';
                                              }</xsl:attribute>
                (-)
              </label>
              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
              <label>Identification</label>
            </legend>
            <table id="SubjectIdentification" style="width: 100%; font-size: 10pt; background-color: #ADE0AD;">
              <tbody style="background-color: #FFFFFF;">
                <xsl:for-each select="Identification">
                  <!--ДРФО-->
                  <xsl:if test="typeId = 2">
                    <tr>
                      <th style="background-color: #BDF0BD; color: #000000; border: 1px dotted #000000;">
                        <xsl:value-of select="number"/>
                      </th>
                      <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="typeId"/>
                      </td>
                      <td colspan="4" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="$davIdentificationType/CreditInfo/Dictionary[code = current()/typeId]/valueEN"/>
                      </td>
                    </tr>
                  </xsl:if>
                  <!--Составной Ключ-->
                  <xsl:if test="typeId = 3">
                    <tr>
                      <th style="background-color: #BDF0BD; color: #000000; border: 1px dotted #000000;">
                        <xsl:value-of select="number"/>
                      </th>
                      <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="typeId"/>
                      </td>
                      <td colspan="4" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="$davIdentificationType/CreditInfo/Dictionary[code = current()/typeId]/valueEN"/>
                      </td>
                    </tr>
                  </xsl:if>
                  <!--Паспорт-->
                  <xsl:if test="typeId = 4">
                    <tr>
                      <th style="background-color: #BDF0BD; color: #000000; border: 1px dotted #000000;">
                        <xsl:value-of select="number"/>
                      </th>
                      <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="typeId"/>
                      </td>
                      <td colspan="2" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="$davIdentificationType/CreditInfo/Dictionary[code = current()/typeId]/valueEN"/>
                      </td>
                      <td style="width: 7%; background-color: #ADE0AD;">
                        Issued
                      </td>
                      <td style="width: 11%; text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="msxsl:format-date(substring(issueDate, 1, 10), 'dd-MM-yyyy')"/>
                      </td>
                      <!--xsl:value-of select="msxsl:format-date(substring(expirationDate, 1, 10), 'dd-MM-yyyy')"/-->
                    </tr>
                    <tr>
                      <td colspan="6" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="authorityUA"/>
                      </td>
                    </tr>
                    <tr>
                      <td colspan="6" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="authorityRU"/>
                      </td>
                    </tr>
                    <tr>
                      <td colspan="6" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="authorityEN"/>
                      </td>
                    </tr>
                  </xsl:if>
                  <!--ОКПО-->
                  <xsl:if test="typeId = 12">
                    <tr>
                      <th style="background-color: #BDF0BD; color: #000000; border: 1px dotted #000000;">
                        <xsl:value-of select="number"/>
                      </th>
                      <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="typeId"/>
                      </td>
                      <td colspan="2" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="$davIdentificationType/CreditInfo/Dictionary[code = current()/typeId]/valueEN"/>
                      </td>
                      <td style="background-color: #ADE0AD;">
                        Registration Date
                      </td>
                      <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="msxsl:format-date(substring(registrationDate, 1, 10), 'dd-MM-yyyy')"/>
                      </td>
                    </tr>
                  </xsl:if>
                </xsl:for-each>
              </tbody>
            </table>
          </fieldset>
        </xsl:if>
        <!--hr /-->
        <!--Контакты-->
        <xsl:if test="Communication">
          <fieldset id="SubjectCommunicationGroup">
            <legend style="background-color: #FFFFFF;">
              <label id="SubjectCommunicationSwitch" style="color: #800000; cursor: pointer;">
                <xsl:attribute name="onclick">if (document.getElementById('SubjectCommunication').style.display == 'none')
                                              {
                                                  document.getElementById('SubjectCommunication').style.display = '';
                                                  this.innerHTML = '(-)';
                                                  this.style.color = '#800000';
                                                  document.getElementById('SubjectCommunicationGroup').style.backgroundColor = '';
                                              } else {
                                                  document.getElementById('SubjectCommunication').style.display = 'none';
                                                  this.innerHTML = '[+]';
                                                  this.style.color = '#008000';
                                                  document.getElementById('SubjectCommunicationGroup').style.backgroundColor = '#E0AD7A';
                                              }</xsl:attribute>
                (-)
              </label>
              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
              <label>Communication</label>
            </legend>
            <table id="SubjectCommunication" style="width: 100%; font-size: 10pt; background-color: #E0AD7A;">
              <tbody style="background-color: #FFFFFF;">
                <xsl:for-each select="Communication">
                  <tr>
                    <th style="background-color: #FFCC99; color: #000000; border: 1px dotted #000000;">
                      <xsl:value-of select="value"/>
                    </th>
                    <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="typeId"/>
                    </td>
                    <td colspan="4" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="$davCommunicationType/CreditInfo/Dictionary[code = current()/typeId]/valueEN"/>
                    </td>
                  </tr>
                </xsl:for-each>
              </tbody>
            </table>
          </fieldset>
        </xsl:if>
        <!--hr /-->
        <!--Адреса-->
        <xsl:if test="Address">
          <fieldset id="SubjectAddressGroup">
            <legend style="background-color: #FFFFFF;">
              <label id="SubjectAddressSwitch" style="color: #800000; cursor: pointer;">
                <xsl:attribute name="onclick">if (document.getElementById('SubjectAddress').style.display == 'none')
                                              {
                                                  document.getElementById('SubjectAddress').style.display = '';
                                                  this.innerHTML = '(-)';
                                                  this.style.color = '#800000';
                                                  document.getElementById('SubjectAddressGroup').style.backgroundColor = '';
                                              } else {
                                                  document.getElementById('SubjectAddress').style.display = 'none';
                                                  this.innerHTML = '[+]';
                                                  this.style.color = '#008000';
                                                  document.getElementById('SubjectAddressGroup').style.backgroundColor = '#ADADE0';
                                              }</xsl:attribute>
                (-)
              </label>
              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
              <label>Address</label>
            </legend>
            <table id="SubjectAddress" style="width: 100%; font-size: 10pt; background-color: #ADADE0;">
              <tbody style="background-color: #FFFFFF;">
                <xsl:for-each select="Address">
                  <tr>
                    <td style="background-color: #BDBDF0;">
                      Postal Code
                    </td>
                    <th style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="postalCode"/>
                    </th>
                    <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="typeId"/>
                    </td>
                    <td colspan="2" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="$davAddressType/CreditInfo/Dictionary[code = current()/typeId]/valueEN"/>
                    </td>
                    <td style="background-color: #BDBDF0;">
                      Location
                    </td>
                    <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="locationId"/>
                    </td>
                  </tr>
                  <xsl:if test="locationId != -1">
                    <tr>
                      <td colspan="3" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="$territoryRef/Territory/Place[locationId = current()/locationId]/region"/>
                      </td>
                      <td colspan="2" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="$territoryRef/Territory/Place[locationId = current()/locationId]/district"/>
                      </td>
                      <td style="background-color: #BDBDF0;">
                        Town
                      </td>
                      <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="$territoryRef/Territory/Place[locationId = current()/locationId]/town"/>
                      </td>
                    </tr>
                  </xsl:if>
                  <tr>
                    <td colspan="7" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="streetUA"/>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="7" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="streetRU"/>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="7" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="streetEN"/>
                    </td>
                  </tr>
                </xsl:for-each>
              </tbody>
            </table>
          </fieldset>
        </xsl:if>
        <!--hr /-->
        <!--Классификация Субъекта-->
        <xsl:if test="Subject">
          <fieldset id="SubjectClassificationGroup">
            <legend style="background-color: #FFFFFF;">
              <label id="SubjectClassificationSwitch" style="color: #800000; cursor: pointer;">
                <xsl:attribute name="onclick">if (document.getElementById('SubjectClassification').style.display == 'none')
                                              {
                                                  document.getElementById('SubjectClassification').style.display = '';
                                                  this.innerHTML = '(-)';
                                                  this.style.color = '#800000';
                                                  document.getElementById('SubjectClassificationGroup').style.backgroundColor = '';
                                              } else {
                                                  document.getElementById('SubjectClassification').style.display = 'none';
                                                  this.innerHTML = '[+]';
                                                  this.style.color = '#008000';
                                                  document.getElementById('SubjectClassificationGroup').style.backgroundColor = '#E0E0AD';
                                              }</xsl:attribute>
                (-)
              </label>
              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
              <label>Classification</label>
            </legend>
            <div id="SubjectClassification" style="width: 100%;">
              <table style="width: 100%; font-size: 10pt; background-color: #E0E0AD;">
                <tbody style="background-color: #FFFFFF;">
                  <xsl:if test="Subject/entity = 'individual'">
                    <tr>
                      <td style="background-color: #F0F0BD;">
                        Activity
                      </td>
                      <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="Subject/classification"/>
                      </td>
                      <td colspan="4" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="$davClassification/CreditInfo/Dictionary[code = current()/Subject/classification]/valueEN"/>
                      </td>
                    </tr>
                    <tr>
                      <td style="background-color: #F0F0BD;">
                        Residency
                      </td>
                      <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="Subject/residency"/>
                      </td>
                      <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="$davResidency/CreditInfo/Dictionary[code = current()/Subject/residency]/valueEN"/>
                      </td>
                      <td style="background-color: #F0F0BD;">
                        Citizenship
                      </td>
                      <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="Subject/citizenship"/>
                      </td>
                      <td style="background-color: #F0F0BD;">
                      </td>
                    </tr>
                    <tr>
                      <td style="background-color: #F0F0BD;">
                        Education
                      </td>
                      <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="Subject/education"/>
                      </td>
                      <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="$davEducation/CreditInfo/Dictionary[code = current()/Subject/education]/valueEN"/>
                      </td>
                      <td style="background-color: #F0F0BD;">
                        Marital Status
                      </td>
                      <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="Subject/maritalStatus"/>
                      </td>
                      <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="$davMaritalStatus/CreditInfo/Dictionary[code = current()/Subject/maritalStatus]/valueEN"/>
                      </td>
                    </tr>
                    <tr>
                      <td style="background-color: #F0F0BD;">
                        Negative Status
                      </td>
                      <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="Subject/negativeStatus"/>
                      </td>
                      <td colspan="4" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="$davNegativeState/CreditInfo/Dictionary[code = current()/Subject/negativeStatus]/valueEN"/>
                      </td>
                    </tr>
                  </xsl:if>
                  <xsl:if test="Subject/entity = 'company'">
                    <tr>
                      <td style="background-color: #F0F0BD;">
                        Status
                      </td>
                      <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="Subject/statusId"/>
                      </td>
                      <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="$davStatus/CreditInfo/Dictionary[code = current()/Subject/statusId]/valueEN"/>
                      </td>
                      <td style="background-color: #F0F0BD;">
                        Ownership
                      </td>
                      <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="Subject/ownership"/>
                      </td>
                      <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="$davOwnership/CreditInfo/Dictionary[code = current()/Subject/ownership]/valueEN"/>
                      </td>
                    </tr>
                    <tr>
                      <td style="background-color: #F0F0BD;">
                        Employee Count
                      </td>
                      <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="Subject/employeeCount"/>
                      </td>
                      <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="$davEmployeeCount/CreditInfo/Dictionary[code = current()/Subject/employeeCount]/valueEN"/>
                      </td>
                      <td style="background-color: #F0F0BD;">
                        Economic Activity
                      </td>
                      <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="Subject/economicActivity"/>
                      </td>
                      <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="$davEconomicActivity/CreditInfo/Dictionary[code = current()/Subject/economicActivity]/valueEN"/>
                      </td>
                    </tr>
                  </xsl:if>
                </tbody>
              </table>
              <xsl:if test="Subject/entity = 'individual'">
                <table style="width: 100%; font-size: 10pt;">
                  <tbody style="background-color: #E0E0AD;">
                    <tr>
                      <td>
                        <!--Иждивенцы-->
                        <table style="width: 100%; font-size: 10pt;">
                          <thead style="background-color: #999966; color: #FFFFFF;">
                            <tr>
                              <th>
                                Dependant
                              </th>
                              <th style="width: 10%;">
                                cnt
                              </th>
                            </tr>
                          </thead>
                          <tbody style="background-color: #FFFFFF;">
                            <xsl:for-each select="Dependant">
                              <tr>
                                <td style="background-color: #F0F0BD;">
                                  <xsl:choose>
                                    <xsl:when test="typeId = 1">
                                      Children under 18 years
                                    </xsl:when>
                                    <xsl:when test="typeId = 2">
                                      Over 18 years
                                    </xsl:when>
                                  </xsl:choose>
                                </td>
                                <td style="width: 10%; text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                                  <xsl:value-of select="count"/>
                                </td>
                              </tr>
                            </xsl:for-each>
                          </tbody>
                        </table>
                      </td>
                      <td>
                        <!--Ежемесячный доход-->
                        <table style="width: 100%; font-size: 10pt;">
                          <thead style="background-color: #999966; color: #FFFFFF;">
                            <tr>
                              <th colspan="2">
                                Monthly Income
                              </th>
                            </tr>
                          </thead>
                          <tbody style="background-color: #FFFFFF;">
                            <xsl:for-each select="MonthlyIncome">
                              <tr>
                                <td style="text-align: right; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                                  <xsl:if test="string(number(value)) != 'NaN'">
                                    <xsl:value-of select="format-number(value, '### ### ##0.00')"/>
                                  </xsl:if>
                                </td>
                                <td style="width: 15%; text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                                  <xsl:value-of select="currency"/>
                                </td>
                              </tr>
                            </xsl:for-each>
                          </tbody>
                        </table>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </xsl:if>
            </div>
          </fieldset>
        </xsl:if>
        <!--hr /-->
        <!--Сводная Финансовая Информация-->
        <xsl:if test="Summary">
          <xsl:variable name="root" select="current()"></xsl:variable>
          <fieldset id="FinancialSummaryGroup">
            <legend style="background-color: #FFFFFF;">
              <label id="FinancialSummarySwitch" style="color: #800000; cursor: pointer;">
                <xsl:attribute name="onclick">if (document.getElementById('FinancialSummary').style.display == 'none')
                                              {
                                                  document.getElementById('FinancialSummary').style.display = '';
                                                  this.innerHTML = '(-)';
                                                  this.style.color = '#800000';
                                                  document.getElementById('FinancialSummaryGroup').style.backgroundColor = '';
                                              } else {
                                                  document.getElementById('FinancialSummary').style.display = 'none';
                                                  this.innerHTML = '[+]';
                                                  this.style.color = '#008000';
                                                  document.getElementById('FinancialSummaryGroup').style.backgroundColor = '#99CCCC';
                                              }</xsl:attribute>
                (-)
              </label>
              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
              <label>Financial Summary</label>
            </legend>
            <div id="FinancialSummary" style="width: 100%;">
              <xsl:for-each select="$davCatGroupHead/Group/Head">
                <xsl:variable name="cat" select="category"></xsl:variable>
                <div style="width: 33.32%; float: left;">
                  <table border="0" style="width: 100%; font-size: 10pt; background-color: #99CCCC;">
                    <thead style="background-color: #BBEEEE;">
                      <tr>
                        <th colspan="2">
                          <xsl:value-of select="textEN"/>
                        </th>
                        <th>
                          cnt
                        </th>
                      </tr>
                    </thead>
                    <xsl:for-each select="$root/Summary[category = $cat]">
                      <tbody style="background-color: #FFFFFF;">
                        <tr>
                          <xsl:choose>
                            <xsl:when test="string(number(amount)) != 'NaN'">
                              <td style="text-align: right; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                                <xsl:value-of select="format-number(amount, '### ### ##0.00')"/>
                              </td>
                              <td style="width: 20%; text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                                <xsl:if test="value">
                                  <xsl:value-of select="value"/>
                                </xsl:if>
                                <xsl:if test="code">
                                  <xsl:value-of select="code"/>
                                </xsl:if>
                              </td>
                              <xsl:choose>
                                <xsl:when test="count">
                                  <td style="width: 10%; text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                                    <xsl:value-of select="count"/>
                                  </td>
                                </xsl:when>
                                <xsl:otherwise>
                                  <td style="width: 10%; background-color: #BBEEEE;">
                                    <xsl:value-of select="count"/>
                                  </td>
                                </xsl:otherwise>
                              </xsl:choose>
                            </xsl:when>
                            <xsl:when test="value|code">
                              <xsl:choose>
                                <xsl:when test="$cat = 'phaseId' or $cat = 'roleId'">
                                  <td style="width: 7%; text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                                    <xsl:if test="value">
                                      <xsl:value-of select="value"/>
                                    </xsl:if>
                                    <xsl:if test="code">
                                      <xsl:value-of select="code"/>
                                    </xsl:if>
                                  </td>
                                  <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                                    <xsl:if test="$cat = 'phaseId'">
                                      <xsl:value-of select="$davPhase/CreditInfo/Dictionary[code = current()/value]/valueEN"/>
                                    </xsl:if>
                                    <xsl:if test="$cat = 'roleId'">
                                      <xsl:value-of select="$davRole/CreditInfo/Dictionary[code = current()/value]/valueEN"/>
                                    </xsl:if>
                                  </td>
                                  <td style="width: 10%; text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                                    <xsl:value-of select="count"/>
                                  </td>
                                </xsl:when>
                                <xsl:otherwise>
                                  <td colspan="2" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                                    <xsl:if test="value">
                                      <xsl:value-of select="value"/>
                                    </xsl:if>
                                    <xsl:if test="code">
                                      <xsl:value-of select="code"/>
                                    </xsl:if>
                                  </td>
                                  <td style="width: 10%; text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                                    <xsl:value-of select="count"/>
                                  </td>
                                </xsl:otherwise>
                              </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                              <td colspan="2" style="background-color: #BBEEEE;">
                                Count
                              </td>
                              <td style="width: 10%; text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                                <xsl:value-of select="count"/>
                              </td>
                            </xsl:otherwise>
                          </xsl:choose>
                        </tr>
                      </tbody>
                    </xsl:for-each>
                  </table>
                </div>
                <xsl:if test="position() mod 3 = 0">
                  <div style="display: block; clear: left;">
                    <table style="width: 100%; font-size: 0px;">
                      <tr>
                        <td>
                          <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                        </td>
                      </tr>
                    </table>
                  </div>
                </xsl:if>
              </xsl:for-each>
            </div>
          </fieldset>
        </xsl:if>
        <!--hr /-->
        <!--КонтРакты-->
        <xsl:for-each select="Contract">
          <xsl:variable name="curcid" select="contractid"></xsl:variable>
          <fieldset>
            <!--xsl:attribute name="style">
              background-color:
              <xsl:choose>
                <xsl:when test="phaseId = 4"> #CCFFCC;</xsl:when>
                <xsl:when test="phaseId = 5"> #DDDDFF;</xsl:when>
                <xsl:when test="phaseId = 6"> #FFCCCC;</xsl:when>
                <xsl:otherwise> #CCCCCC;</xsl:otherwise>
              </xsl:choose>
            </xsl:attribute-->
            <xsl:attribute name="id">Contract<xsl:value-of select="$curcid"/>Group</xsl:attribute>
            <legend style="background-color: #FFFFFF;">
              <label style="color: #800000; cursor: pointer;">
                <xsl:attribute name="id">Contract<xsl:value-of select="$curcid"/>Switch</xsl:attribute>
                <xsl:attribute name="onclick">
                  if (document.getElementById('Contract<xsl:value-of select="$curcid"/>').style.display == 'none')
                  {
                      document.getElementById('Contract<xsl:value-of select="$curcid"/>').style.display = '';
                      this.innerHTML = '(-)';
                      this.style.color = '#800000';
                      document.getElementById('Contract<xsl:value-of select="$curcid"/>Group').style.backgroundColor = '';
                  } else {
                      document.getElementById('Contract<xsl:value-of select="$curcid"/>').style.display = 'none';
                      this.innerHTML = '[+]';
                      this.style.color = '#008000';
                      document.getElementById('Contract<xsl:value-of select="$curcid"/>Group').style.backgroundColor =
                  <xsl:choose>
                    <xsl:when test="phaseId = 4"> '#CCFFCC';</xsl:when>
                    <xsl:when test="phaseId = 5"> '#DDDDFF';</xsl:when>
                    <xsl:when test="phaseId = 6"> '#FFCCCC';</xsl:when>
                    <xsl:otherwise> '#CCCCCC';</xsl:otherwise>
                  </xsl:choose>
                  }
                </xsl:attribute>
                (-)
              </label>
              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
              <span style="font-weight: bold;">
                <xsl:value-of select="position()"/>
              </span>
              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
              <label>
                <xsl:choose>
                  <xsl:when test="phaseId = 4">
                    <xsl:attribute name="style">font-weight: bold; background-color: #CCFFCC; color: #009900;</xsl:attribute>
                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                    EXISTING
                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                  </xsl:when>
                  <xsl:when test="phaseId = 5">
                    <xsl:attribute name="style">font-weight: bold; background-color: #DDDDFF; color: #0000FF;</xsl:attribute>
                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                    TERMINATED
                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                  </xsl:when>
                  <xsl:when test="phaseId = 6">
                    <xsl:attribute name="style">font-weight: bold; background-color: #FFCCCC; color: #FF0000;</xsl:attribute>
                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                    TERMINATED IN ADVANCE
                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:attribute name="style">font-weight: bold; background-color: #CCCCCC; color: #999999;</xsl:attribute>
                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                    UNKNOWN
                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                  </xsl:otherwise>
                </xsl:choose>
              </label>
              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
              <span>
                <xsl:value-of select="$davContractType/Vocabulary/Statement[code = current()/type]/valueEN"/>
              </span>
            </legend>
            <div style="width: 100%;">
              <xsl:attribute name="id">Contract<xsl:value-of select="$curcid"/></xsl:attribute>
              <table style="width: 100%; font-size: 10pt; background-color: #BDBDF0;">
                <tbody style="background-color: #FFFFFF;">
                  <tr>
                    <td style="background-color: #DDDDFF;">
                      Index
                    </td>
                    <th style="background-color: #DDFFFF; color: #0000FF; border: 1px dotted #000000;">
                      <xsl:value-of select="position()"/>
                    </th>
                    <td style="background-color: #DDDDFF;">
                      Currency
                    </td>
                    <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="currency"/>
                    </td>
                    <td style="background-color: #DDDDFF;">
                      Type
                    </td>
                    <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="type"/>
                    </td>
                    <td style="background-color: #DDDDFF;">
                      Provider
                    </td>
                    <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      B-<xsl:value-of select="provider"/>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="1" style="background-color: #DDDDFF;">
                      Subject Role
                    </td>
                    <td colspan="1" style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="roleId"/>
                    </td>
                    <td colspan="2" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="$davRole/CreditInfo/Dictionary[code = current()/roleId]/valueEN"/>
                    </td>
                    <td colspan="2" style="background-color: #DDDDFF;">
                      Last update
                    </td>
                    <td colspan="2" style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="msxsl:format-date(substring(lastUpdate, 1, 10), 'dd-MM-yyyy')"/>
                      <!--xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text-->
                      <!--xsl:value-of select="substring(lastUpdate, 12, 8)"/-->
                    </td>
                  </tr>
                  <tr>
                    <td colspan="1" style="background-color: #DDDDFF;">
                      Credit Purpose
                    </td>
                    <td colspan="1" style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="creditPurpose"/>
                    </td>
                    <td colspan="2" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="$davCreditPurpose/CreditInfo/Dictionary[code = current()/creditPurpose]/valueEN"/>
                    </td>
                    <td colspan="2" style="background-color: #DDDDFF;">
                      Start Date
                    </td>
                    <td colspan="2" style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="msxsl:format-date(substring(startDate, 1, 10), 'dd-MM-yyyy')"/>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="1" style="background-color: #DDDDFF;">
                      Negative Status
                    </td>
                    <td colspan="1" style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="negativeStatus"/>
                    </td>
                    <td colspan="2" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="$davNegativeStatus/CreditInfo/Dictionary[code = current()/negativeStatus]/valueEN"/>
                    </td>
                    <td colspan="2" style="background-color: #DDDDFF;">
                      Expected End Date
                    </td>
                    <td colspan="2" style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="msxsl:format-date(substring(expectedEndDate, 1, 10), 'dd-MM-yyyy')"/>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="1" style="background-color: #DDDDFF;">
                      Phase
                    </td>
                    <td colspan="1" style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="phaseId"/>
                    </td>
                    <td colspan="2" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="$davPhase/CreditInfo/Dictionary[code = current()/phaseId]/valueEN"/>
                    </td>
                    <td colspan="2" style="background-color: #DDDDFF;">
                      Factual End Date
                    </td>
                    <td colspan="2" style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="msxsl:format-date(substring(factualEndDate, 1, 10), 'dd-MM-yyyy')"/>
                    </td>
                  </tr>
                </tbody>
              </table>
              <table style="width: 100%; font-size: 10pt; background-color: #BDBDF0;">
                <tbody style="background-color: #FFFFFF;">
                  <xsl:if test="paymentPeriodId">
                    <tr>
                      <td style="background-color: #DDDDFF;">
                        Payment Period
                      </td>
                      <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="paymentPeriodId"/>
                      </td>
                      <td colspan="3" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="$davPaymentPeriod/CreditInfo/Dictionary[code = current()/paymentPeriodId]/valueEN"/>
                      </td>
                      <!--xsl:value-of select="paymentMethodId"/-->
                      <!--xsl:value-of select="$davPaymentMethod/CreditInfo/Dictionary[code = current()/paymentMethodId]/valueEN"/-->
                    </tr>
                  </xsl:if>
                  <tr>
                    <td style="background-color: #DDDDFF;">
                      Installment Count
                    </td>
                    <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="instalmentCount"/>
                    </td>
                    <td style="background-color: #DDDDFF;">
                      Total Amount
                    </td>
                    <td style="text-align: right; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:if test="string(number(totalAmount)) != 'NaN'">
                        <xsl:value-of select="format-number(totalAmount, '### ### ##0.00')"/>
                      </xsl:if>
                      <xsl:if test="string(number(creditLimit)) != 'NaN'">
                        <xsl:value-of select="format-number(creditLimit, '### ### ##0.00')"/>
                      </xsl:if>
                    </td>
                    <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="actualCurrency"/>
                    </td>
                  </tr>
                  <tr>
                    <td style="background-color: #DDDDFF;">
                      Outstanding Installment Count
                    </td>
                    <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="restInstalmentCount"/>
                    </td>
                    <td style="background-color: #DDDDFF;">
                      Outstanding Amount
                    </td>
                    <td style="text-align: right; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="format-number(restAmount, '### ### ##0.00')"/>
                    </td>
                    <td style="background-color: #BDBDF0;"></td>
                  </tr>
                  <tr>
                    <td style="background-color: #BDBDF0;"></td>
                    <td style="background-color: #BDBDF0;"></td>
                    <td style="background-color: #DDDDFF;">
                      Installment Amount
                    </td>
                    <td style="text-align: right; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:if test="string(number(instalmentAmount)) != 'NaN'">
                        <xsl:value-of select="format-number(instalmentAmount, '### ### ##0.00')"/>
                      </xsl:if>
                    </td>
                    <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="instalmentAmountCurrency"/>
                    </td>
                  </tr>
                  <tr>
                    <td style="background-color: #DDDDFF;">
                      Overdue Installment Count
                    </td>
                    <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:value-of select="overdueCount"/>
                    </td>
                    <td style="background-color: #DDDDFF;">
                      Overdue Amount
                    </td>
                    <td style="text-align: right; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                      <xsl:if test="string(number(overdueAmount)) != 'NaN'">
                        <xsl:value-of select="format-number(overdueAmount, '### ### ##0.00')"/>
                      </xsl:if>
                    </td>
                    <td style="background-color: #BDBDF0;"></td>
                  </tr>
                </tbody>
              </table>
              <!--Обеспечения (залоги, гарантии, поручительства) по контрактам-->
              <table style="width: 100%; font-size: 10pt; background-color: #FFA500;">
                <tbody style="background-color: #FFFFFF;">
                  <xsl:for-each select="../Collateral[contractid = $curcid]">
                    <tr>
                      <th colspan="2" style="background-color: #FFCC33; border: 1px dotted #000000;">
                        Collateral
                      </th>
                      <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="typeId"/>
                      </td>
                      <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="$davCollateralType/CreditInfo/Dictionary[code = current()/typeId]/valueEN"/>
                      </td>
                      <td style="background-color: #FFCC33;">
                        Amount
                      </td>
                      <th style="text-align: right; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="format-number(value, '### ### ##0.00')"/>
                      </th>
                      <th style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                        <xsl:value-of select="currency"/>
                      </th>
                    </tr>
                    <!--Идентификация Обеспечения-->
                    <xsl:if test="identification-typeId">
                      <!--ДРФО Обеспечения-->
                      <xsl:if test="identification-typeId = 2">
                        <tr>
                          <td colspan="2" style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                            <xsl:value-of select="number"/>
                          </td>
                          <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                            <xsl:value-of select="identification-typeId"/>
                          </td>
                          <td colspan="4" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                            <xsl:value-of select="$davIdentificationType/CreditInfo/Dictionary[code = current()/identification-typeId]/valueEN"/>
                          </td>
                        </tr>
                      </xsl:if>
                      <!--Составной Ключ Обеспечения-->
                      <xsl:if test="identification-typeId = 3">
                        <tr>
                          <td colspan="2" style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                            <xsl:value-of select="number"/>
                          </td>
                          <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                            <xsl:value-of select="identification-typeId"/>
                          </td>
                          <td colspan="4" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                            <xsl:value-of select="$davIdentificationType/CreditInfo/Dictionary[code = current()/identification-typeId]/valueEN"/>
                          </td>
                        </tr>
                      </xsl:if>
                      <!--Паспорт Обеспечения-->
                      <xsl:if test="identification-typeId = 4">
                        <tr>
                          <td colspan="2" style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                            <xsl:value-of select="number"/>
                          </td>
                          <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                            <xsl:value-of select="identification-typeId"/>
                          </td>
                          <td colspan="2" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                            <xsl:value-of select="$davIdentificationType/CreditInfo/Dictionary[code = current()/identification-typeId]/valueEN"/>
                          </td>
                          <td style="background-color: #FFCC33;">
                            Issued
                          </td>
                          <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                            <xsl:value-of select="msxsl:format-date(substring(issueDate, 1, 10), 'dd-MM-yyyy')"/>
                          </td>
                          <!--xsl:value-of select="msxsl:format-date(substring(expirationDate, 1, 10), 'dd-MM-yyyy')"/-->
                        </tr>
                        <tr>
                          <td colspan="7" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                            <xsl:value-of select="authorityUA"/>
                          </td>
                        </tr>
                        <tr>
                          <td colspan="7" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                            <xsl:value-of select="authorityRU"/>
                          </td>
                        </tr>
                        <tr>
                          <td colspan="7" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                            <xsl:value-of select="authorityEN"/>
                          </td>
                        </tr>
                      </xsl:if>
                      <!--ОКПО Обеспечения-->
                      <xsl:if test="identification-typeId = 12">
                        <tr>
                          <td colspan="2" style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                            <xsl:value-of select="number"/>
                          </td>
                          <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                            <xsl:value-of select="identification-typeId"/>
                          </td>
                          <td colspan="2" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                            <xsl:value-of select="$davIdentificationType/CreditInfo/Dictionary[code = current()/identification-typeId]/valueEN"/>
                          </td>
                          <td style="background-color: #FFCC33;">
                            Registration Date
                          </td>
                          <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                            <xsl:value-of select="msxsl:format-date(substring(registrationDate, 1, 10), 'dd-MM-yyyy')"/>
                          </td>
                        </tr>
                      </xsl:if>
                    </xsl:if>
                    <!--Адрес Обеспечения-->
                    <xsl:if test="address-typeId">
                      <tr>
                        <td style="background-color: #FFCC33;">
                          Postal Code
                        </td>
                        <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                          <xsl:value-of select="postalCode"/>
                        </td>
                        <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                          <xsl:value-of select="address-typeId"/>
                        </td>
                        <td colspan="2" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                          <xsl:value-of select="$davAddressType/CreditInfo/Dictionary[code = current()/address-typeId]/valueEN"/>
                        </td>
                        <td style="background-color: #FFCC33;">
                          Location
                        </td>
                        <td style="text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                          <xsl:value-of select="locationId"/>
                        </td>
                      </tr>
                      <xsl:if test="locationId != -1">
                        <tr>
                          <td colspan="3" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                            <xsl:value-of select="$territoryRef/Territory/Place[locationId = current()/locationId]/region"/>
                          </td>
                          <td colspan="2" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                            <xsl:value-of select="$territoryRef/Territory/Place[locationId = current()/locationId]/district"/>
                          </td>
                          <td style="background-color: #FFCC33;">
                            Town
                          </td>
                          <td style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                            <xsl:value-of select="$territoryRef/Territory/Place[locationId = current()/locationId]/town"/>
                          </td>
                        </tr>
                      </xsl:if>
                      <tr>
                        <td colspan="7" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                          <xsl:value-of select="streetUA"/>
                        </td>
                      </tr>
                      <tr>
                        <td colspan="7" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                          <xsl:value-of select="streetRU"/>
                        </td>
                      </tr>
                      <tr>
                        <td colspan="7" style="border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                          <xsl:value-of select="streetEN"/>
                        </td>
                      </tr>
                    </xsl:if>
                  </xsl:for-each>
                </tbody>
              </table>
              <!--Финансовые Записи по контрактам-->
              <table style="width: 100%; font-size: 10pt; border-collapse: collapse; background-color: #FFFFFF; color: #000000;">
                <thead style="font-size: 8pt; background-color: #DDDDDD; color: #333333;">
                  <tr>
                    <th colspan="9" style="border-left-style: dotted; border-top-style: dotted; border-right-style: dotted; border-width: 1px; border-color: #000000;">
                      <label>
                        All Payment Records
                      </label>
                      <!--xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text-->
                      <!--xsl:value-of select="$curcid"/-->
                    </th>
                  </tr>
                </thead>
                <tbody style="font-size: 8pt; background-color: #DDFFDD; color: #000000; border: 1px dotted #000000;">
                  <tr>
                    <th rowspan="2" style="width: 24px; background-color: #FFFFFF; color: #800000; cursor: pointer;">
                      <xsl:attribute name="id">RecordsFor<xsl:value-of select="$curcid"/>Switch</xsl:attribute>
                      <xsl:attribute name="onclick">
                        if (document.getElementById('RecordsFor<xsl:value-of select="$curcid"/>').style.display == 'none')
                        {   document.getElementById('RecordsFor<xsl:value-of select="$curcid"/>').style.display = '';
                            this.innerHTML = '(-)';
                            this.style.color = '#800000';
                        } else {
                            document.getElementById('RecordsFor<xsl:value-of select="$curcid"/>').style.display = 'none';
                            this.innerHTML = '[+]';
                            this.style.color = '#008000';
                        }
                      </xsl:attribute>
                      (-)
                    </th>
                    <th style="border-left-style: dotted; border-width: 1px; border-color: #000000;">
                      Accounting
                    </th>
                    <th style="border-left-style: dotted; border-width: 1px; border-color: #000000;">
                      Credit
                    </th>
                    <th colspan="3" style="border-left-style: dotted; border-bottom-style: dotted; border-width: 1px; border-color: #000000;">
                      Outstanding
                    </th>
                    <th colspan="3" style="border-left-style: dotted; border-bottom-style: dotted; border-width: 1px; border-color: #000000;">
                      Overdue
                    </th>
                  </tr>
                  <tr>
                    <th style="border-left-style: dotted; border-width: 1px; border-color: #000000;">
                      Date
                    </th>
                    <th style="border-left-style: dotted; border-width: 1px; border-color: #000000;">
                      Usage
                    </th>
                    <th style="border-left-style: dotted; border-width: 1px; border-color: #000000;">
                      amount
                    </th>
                    <th style="border-left-style: dotted; border-width: 1px; border-color: #000000;">
                      $$$
                    </th>
                    <th style="border-left-style: dotted; border-width: 1px; border-color: #000000;">
                      cnt
                    </th>
                    <th style="border-left-style: dotted; border-width: 1px; border-color: #000000;">
                      amount
                    </th>
                    <th style="border-left-style: dotted; border-width: 1px; border-color: #000000;">
                      $$$
                    </th>
                    <th style="border-left-style: dotted; border-width: 1px; border-color: #000000;">
                      cnt
                    </th>
                  </tr>
                </tbody>
                <tbody style="background-color: #FFFFFF;">
                  <xsl:attribute name="id">RecordsFor<xsl:value-of select="$curcid"/></xsl:attribute>
                  <xsl:for-each select="../Record[contractid = $curcid]">
                    <!--tr style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: #C0C0C0"-->
                    <tr>
                      <td>
                        <xsl:choose>
                          <xsl:when test="position() > 1">
                            <xsl:choose>
                              <xsl:when test="preceding-sibling::node()[name() = 'Record'][1][restAmount &lt; current()/restAmount]">
                                <xsl:attribute name="style">width: 24px; text-align: center; background-color: #FF0000; color: #FFFF00;</xsl:attribute>
                                [!]
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:attribute name="style">width: 24px;</xsl:attribute>
                                <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:attribute name="style">width: 24px;</xsl:attribute>
                            <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                          </xsl:otherwise>
                        </xsl:choose>
                      </td>
                      <td style="text-align: center; border-bottom-style: dotted; border-bottom-width: 1px; border-bottom-color: #C0C0C0;">
                        <xsl:value-of select="msxsl:format-date(substring(accountingDate, 1, 10), 'dd-MM-yyyy')"/>
                      </td>
                      <td style="text-align: center; border-bottom-style: dotted; border-bottom-width: 1px; border-bottom-color: #C0C0C0;">
                        <xsl:value-of select="creditUsage"/>
                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                        <xsl:value-of select="$davCreditUsage/CreditInfo/Dictionary[code = current()/creditUsage]/valueEN"/>
                      </td>
                      <td style="text-align: right; border-bottom-style: dotted; border-bottom-width: 1px; border-bottom-color: #C0C0C0;">
                        <xsl:value-of select="format-number(restAmount, '### ### ##0.00')"/>
                      </td>
                      <td style="text-align: center; border-bottom-style: dotted; border-bottom-width: 1px; border-bottom-color: #C0C0C0;">
                        <xsl:value-of select="restCurrency"/>
                      </td>
                      <td style="text-align: center; border-bottom-style: dotted; border-bottom-width: 1px; border-bottom-color: #C0C0C0;">
                        <xsl:value-of select="restInstalmentCount"/>
                      </td>
                      <td style="text-align: right; border-bottom-style: dotted; border-bottom-width: 1px; border-bottom-color: #C0C0C0;">
                        <xsl:if test="string(number(overdueAmount)) != 'NaN'">
                          <xsl:choose>
                            <xsl:when test="number(overdueAmount) != 0">
                              <b style="color: #FF0000;">
                                <xsl:value-of select="format-number(overdueAmount, '### ### ##0.00')"/>                                
                              </b>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:value-of select="format-number(overdueAmount, '### ### ##0.00')"/>
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:if>
                      </td>
                      <td style="text-align: center; border-bottom-style: dotted; border-bottom-width: 1px; border-bottom-color: #C0C0C0;">
                        <xsl:value-of select="overdueCurrency"/>
                      </td>
                      <td style="text-align: center; border-bottom-style: dotted; border-bottom-width: 1px; border-bottom-color: #C0C0C0;">
                        <xsl:if test="string(number(overdueCount)) != 'NaN'">
                          <xsl:choose>
                            <xsl:when test="number(overdueCount) != 0">
                              <b style="color: #FF0000;">
                                <xsl:value-of select="overdueCount"/>
                              </b>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:value-of select="overdueCount"/>
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:if>
                      </td>
                    </tr>
                  </xsl:for-each>
                </tbody>
              </table>
            </div>
          </fieldset>
          <!--hr /-->
        </xsl:for-each>
        <!--Журнал Событий по субъекту (Реестр Запросов и Передачи информации по субъекту)-->
        <xsl:if test="Event">
          <fieldset id="SubjectEventsGroup">
            <legend style="background-color: #FFFFFF;">
              <label id="SubjectEventsSwitch" style="color: #800000; cursor: pointer;">
                <xsl:attribute name="onclick">if (document.getElementById('SubjectEvents').style.display == 'none')
                                              {
                                                  document.getElementById('SubjectEvents').style.display = '';
                                                  this.innerHTML = '(-)';
                                                  this.style.color = '#800000';
                                                  document.getElementById('SubjectEventsGroup').style.backgroundColor = '';
                                              } else {
                                                  document.getElementById('SubjectEvents').style.display = 'none';
                                                  this.innerHTML = '[+]';
                                                  this.style.color = '#008000';
                                                  document.getElementById('SubjectEventsGroup').style.backgroundColor = '#666699';
                                              }</xsl:attribute>
                (-)
              </label>
              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
              <label>Subject Events</label>
            </legend>
            <table id="SubjectEvents" style="width: 100%; font-size: 10pt; background-color: #CCCCFF;">
              <thead style="background-color: #666699; color: #FFFFFF;">
                <tr>
                  <th>
                    №
                  </th>
                  <th colspan="2">
                    When
                  </th>
                  <th>
                    Kind
                  </th>
                  <th>
                    B-
                  </th>
                  <th>
                    Description
                  </th>
                </tr>
              </thead>
              <tbody style="background-color: #FFFFFF;">
                <xsl:for-each select="Event">
                  <tr>
                    <td style="text-align: center;">
                      <xsl:value-of select="position()"/>
                    </td>
                    <td style="text-align: center;">
                      <xsl:value-of select="msxsl:format-date(substring(when, 1, 10), 'dd-MM-yyyy')"/>
                    </td>
                    <td style="text-align: center;">
                      <xsl:value-of select="substring(when, 12, 8)"/>
                    </td>
                    <td style="text-align: center;">
                      <xsl:value-of select="event"/>
                    </td>
                    <td style="text-align: center;">
                      <xsl:value-of select="provider"/>
                    </td>
                    <td style="text-align: center;">
                      <xsl:choose>
                        <xsl:when test="event = 'request'">
                          Subjects request or report ordering
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:value-of select="$davContractType/Vocabulary/Statement[code = current()/event]/valueEN"/>
                        </xsl:otherwise>
                      </xsl:choose>
                    </td>
                  </tr>
                </xsl:for-each>
              </tbody>
            </table>
          </fieldset>
        </xsl:if>
        <!--hr /-->
        <!--Подвал Выписки-->
        <table style="width: 100%; font-size: 10pt;">
          <tbody>
            <tr>
              <td style="background-color: #E0E0E0; vertical-align: middle; text-align: center; border-left-style: solid; border-top-style: solid; border-width: 1px; border-color: #000000;">
                Request ID
              </td>
              <td style="vertical-align: middle; text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                <xsl:value-of select="Subject/requestid"/>
              </td>
              <td style="background-color: #E0E0E0; vertical-align: middle; text-align: center; border-left-style: solid; border-top-style: solid; border-width: 1px; border-color: #000000;">
                Last update
              </td>
              <td style="vertical-align: middle; text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                <xsl:value-of select="msxsl:format-date(substring(Subject/lastUpdate, 1, 10), 'dd-MM-yyyy')"/>
                <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                <xsl:value-of select="substring(Subject/lastUpdate, 12, 8)"/>
              </td>
            </tr>
            <tr>
              <td style="background-color: #E0E0E0; vertical-align: middle; text-align: center; border-left-style: solid; border-top-style: solid; border-width: 1px; border-color: #000000;">
                Credit Report End
              </td>
              <td style="vertical-align: middle; text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                STATEMENT
              </td>
              <td style="background-color: #E0E0E0; vertical-align: middle; text-align: center; border-left-style: solid; border-top-style: solid; border-width: 1px; border-color: #000000;">
                Issued
              </td>
              <td style="vertical-align: middle; text-align: center; border-bottom-style: solid; border-right-style: solid; border-width: 1px; border-color: #000000;">
                <xsl:value-of select="msxsl:format-date(substring(@generated, 1, 10), 'dd-MM-yyyy')"/>
                <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                <xsl:value-of select="substring(@generated, 12, 8)"/>
              </td>
            </tr>
          </tbody>
          <tfoot>
            <tr>
              <th colspan="3" style="background-color: #FFCCCC; border-top-style: solid; border-width: 1px; border-color: #000000;">
                First All-Ukrainian Bureau of Credit Histories
                <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                <xsl:text disable-output-escaping="yes">&amp;copy;</xsl:text>
                <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                <xsl:value-of select="substring(@generated, 1, 4)"/>
              </th>
              <th style="background-color: #CCCCCC; color: #FFFFCC; border-left-style: dotted; border-top-style: solid; border-width: 1px; border-color: #000000;">
                <xsl:value-of select="@powered"/>
              </th>
            </tr>
          </tfoot>
        </table>
        <!--hr /-->

      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
